clc;
clear all;

% inputimage = imread('text-2.jpg');
inputimage = imread('img (13).jpg');

if ndims(inputimage) == 3
    inputimage = rgb2gray(inputimage);
end
figure;
imshow(inputimage);title('input');
inputimage = double(inputimage);
figure;
imshow(inputimage);title('double');
[width, height] = size(inputimage);
outputbinaryimage = zeros(width,height);
% s and t(in paper)
s = width/4;
t = 15;
intimg = ones(width,height).*255;
for i = 1:width
    sum = 0;
    for j = 1:height
        sum = sum + inputimage(i,j);
        if i == 1
            intimg(i,j) = sum;
        else
            intimg(i,j) = intimg(i-1,j) + sum;
        end
    end
end
sum = 0;
count = 0;
w = width;
h = height;
for i=1:w
    for j = 1:h
        x1 = round(i-s/2);
        if x1 <1
            x1 = 1;
        end    
        
        x2 = round(i+s/2);
        if x2 >=w
           x2 = w-1;
        end
        
        y1 = round(j - s/2);
        if y1 < 1
            y1 = 1;
        end
        
        y2 = round(j + s/2);
        if y2>=h
            y2 = h-1;
        end
        
        count = (x2-x1)*(y2-y1);
        sum = intimg(x2+1,y2+1) - intimg(x2+1,y1) - intimg(x1,y2+1) + intimg(x1,y1);

%          a = inputimage(i,j) * count;
%          b = sum * (100.0 - t)/100;
%         a,b;
        if (inputimage(i,j) * count) <= (sum * (100.0 - t)/100)

            outputbinaryimage(i,j) = 0;
        else
            outputbinaryimage(i,j) = 255;
        end
    end
end

figure;
imshow(outputbinaryimage);
pause;
close all;