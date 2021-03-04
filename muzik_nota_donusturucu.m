filename='keman_gam.wav';
Fs=48000;
a=0;
nota_matris = zeros(1,8);
e=1;
b=[0.1 0.6 1 1.5 1.6 2 2.15 2.8 2.9 3.5 3.9 4.5 4.7 5.3 5.6 6.2];
for i=1:8
samples = [b(e)*Fs,b(e+1)*Fs];
e=e+2;
[y, Fs]=audioread(filename, samples);
%sound(y,Fs);
X = fft(y);
N=length(X);
freq = (0:N-1)*(Fs/N);
[~,I] = max(abs(X));
f = freq(I);
m= (12*log2(f/440))+69;
a=a+1;
if(a==9)
    a=0;
end
nota_matris(a) = m;
end
M = zeros(8,6);
M(:,1) = 1;         
M(:,2) = 1;         
M(:,3) = nota_matris;      
M(:,4) = 80;  
M(:,5) = (.5:.5:4)';  
M(:,6) = M(:,5) + .5;   
midi_new = matrix2midi(M);
writemidi(midi_new, 'keman_gam.mid');