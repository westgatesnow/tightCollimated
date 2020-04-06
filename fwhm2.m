function width = fwhm2(x,y)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%fwhm2
% If the spectrum has a single peak, fwhm2 is fwhm.
% If the spectrum has 2 peaks, fwhm returns the width between the point
%   when the spectrum first crosses half maximum and the point when the
%   spectrum last crosses half maximum
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%fwhm
% function width = fwhm(x,y)
%
% Full-Width at Half-Maximum (FWHM) of the waveform y(x)
% and its polarity.
% The FWHM result in 'width' will be in units of 'x'
%
%
% Rev 1.2, April 2006 (Patrick Egan)
y = y / max(y);
N = length(y);
lev50 = 0.5;
% if y(1) < lev50                  % find index of center (max or min) of pulse
%     [garbage,centerindex]=max(y);
%     Pol = +1;
% %     disp('Pulse Polarity = Positive')
% else
%     [garbage,centerindex]=min(y);
%     Pol = -1;
%     disp('Pulse Polarity = Negative')
% end
i = 2;
while sign(y(i)-lev50) == sign(y(i-1)-lev50)
    i = i+1;
end                                   %first crossing is between y(i-1) & y(i)
interp = (lev50-y(i-1)) / (y(i)-y(i-1));
tlead = x(i-1) + interp*(x(i)-x(i-1));
% i = centerindex+1;                    %start search for next crossing at center
% i = i + 1;
% while ((sign(y(i)-lev50) == sign(y(i-1)-lev50)) & (i <= N-1))
%     i = i+1;
% end
i = N;
while ((sign(y(i)-lev50) == sign(y(i-1)-lev50)) && (i >= 2))
    i = i-1;
end
if i ~= N
    Ptype = 1;  
%     disp('Pulse is Impulse or Rectangular with 2 edges')
    interp = (lev50-y(i-1)) / (y(i)-y(i-1));
    ttrail = x(i-1) + interp*(x(i)-x(i-1));
    width = ttrail - tlead;
else
    Ptype = 2; 
    disp('Step-Like Pulse, no second edge')
    ttrail = NaN;
    width = NaN;
end
