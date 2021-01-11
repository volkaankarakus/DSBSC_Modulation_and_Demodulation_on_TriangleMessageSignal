
%%  Message Signal

fm=110;
zaman=[0:1/fm:10];

m1=3*tripuls((zaman-3)/6);
m2=-1*tripuls((zaman-7)/2);
mt=m1+m2;  % Message Signal

figure(1);
subplot(3,1,1);
plot(zaman,mt);
xlabel('Time');
ylabel('m(t)');
title(['Triangle Message Signal fm=',num2str(fm),' Hz']);
grid on

%% Carrier Signal

fc1=300;
fc2=1000;

c1=cos(2*pi*fc1*zaman); % Carrier Signal 1
c2=cos(2*pi*fc2*zaman); % Carrier Signal 2

subplot(3,1,2);
plot(zaman,c1);
xlabel('Time');
ylabel('c1(t)');
title(['Carrier Signal fc1=',num2str(fc1),' Hz']);
grid on

subplot(3,1,3);
plot(zaman,c2);
xlabel('Time');
ylabel('m(t)');
title(['Carrier Signal fc2=',num2str(fc2),' Hz']);
grid on

%% DSB-SC Modulation
Ac=5;
s1=Ac*mt.*c1;
figure(2);
subplot(2,1,1);
plot(zaman,s1);
xlabel('Time');
ylabel('s1(t)');
title(['Modulated Signal 1 : s1(t)']);
grid on

s2=Ac*mt.*c2;
subplot(2,1,2);
plot(zaman,s2);
xlabel('Time');
ylabel('s2(t)');
title(['Modulated Signal 2 : s2(t)']);
grid on

%% Frequency Spectrum of Modulated Signal
fs=1101;      % fs for calculating the same length with f
f=-fs/2:1:fs/2-1;

s1f=fftshift(fft(s1));
figure(3);
subplot(2,1,1)
plot(f,abs(s1f)/fm);
title('Frequency Spectrum of Modulated Signal s1(t) :');
xlabel('Frequency(Hz)');
ylabel('Magnitude');
grid on


s2f=fftshift(fft(s2));
subplot(2,1,2)
plot(f,abs(s2f)/fm);
title('Frequency Spectrum of Modulated Signal s2(t)');
xlabel('Frequency(Hz)');
ylabel('Magnitude');
grid on

%% New Signals r1(t) and r2(t) 

r1t=s1.*cos(2*pi*fc1*zaman);
r2t=s2.*cos(2*pi*fc2*zaman);
figure(4);
subplot(3,1,1)
plot(zaman,r1t);
title('New Signal r1(t)');
xlabel('Time(s)');
ylabel('Amplitude');

subplot(3,1,2)
plot(zaman,r2t);
title('New Signal r2(t)');
xlabel('Time(s)');
ylabel('Amplitude');

%% Low Pass Filtered Signals

[b,a]= butter(5,2*fc1/fs);  % Butterworth Filter Design
r_flt1=filter(b,a,r1t);

subplot(3,1,3)
plot(zaman,r_flt1/3*1.2);
title('Low Pass Filtered Signal');
xlabel('Time(s)');
ylabel('Amplitude');
grid on


figure(5);
plot(zaman,mt);
xlabel('Time');
ylabel('Amplitude');
grid on

hold on

plot(zaman,r_flt1/3*1.2);
title('Low Pass Filtered Signal and m(t) Message Signal ');
legend('Demodulated Signal','Message Signal');
grid on