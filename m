Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280878AbRKOPGp>; Thu, 15 Nov 2001 10:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280889AbRKOPGi>; Thu, 15 Nov 2001 10:06:38 -0500
Received: from mout03.kundenserver.de ([195.20.224.218]:11332 "EHLO
	mout03.kundenserver.de") by vger.kernel.org with ESMTP
	id <S280878AbRKOPG0>; Thu, 15 Nov 2001 10:06:26 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Hans-Peter Jansen <hpj@urpla.net>
Organization: TreeWater Society Berlin
To: Dan Hollis <goemon@anime.net>
Subject: [lm_sensors] wrong sensors readings from w83782d on Tyan Dual K7/Thunder
Date: Thu, 15 Nov 2001 16:06:16 +0100
X-Mailer: KMail [version 1.3]
In-Reply-To: <Pine.LNX.4.30.0111141847300.31580-100000@anime.net>
In-Reply-To: <Pine.LNX.4.30.0111141847300.31580-100000@anime.net>
Cc: <sensors@stimpy.netroedge.com>, <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20011115152423.03BD910A3@shrek.lisa.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dan, thanks, for your ultimate help on this topic.

On Thursday, 15. November 2001 03:50, Dan Hollis wrote:
> On Wed, 14 Nov 2001, Hans-Peter Jansen wrote:
> > fan1:     7180 RPM  (min = 3000 RPM, div = 2)                      
> > <3590> fan2:     7105 RPM  (min = 3000 RPM, div = 2)                     
> >  <3515>
>
> Fan divisor is wrong.
> adjust /proc/sys/dev/sensors/w83782d-i2c-0-2d/fan_div as needed.

ok, then

tyrex:~# echo "4 4 4" > /proc/sys/dev/sensors/w83782d-i2c-0-2d/fan_div
tyrex:~# sensors | egrep ^fan
fan1:     6887 RPM  (min = 1500 RPM, div = 4)                     
fan2:     7031 RPM  (min = 1500 RPM, div = 4)                     

tyrex:~# echo "1 1 1" > /proc/sys/dev/sensors/w83782d-i2c-0-2d/fan_div
tyrex:~# sensors | egrep ^fan
fan1:     7142 RPM  (min = 6000 RPM, div = 1)                     
fan2:     6716 RPM  (min = 6000 RPM, div = 1)                     

Is adjusting the min value the intended behaviour?
I also tried this in /etc/sensors.conf:
   set fan1_div 4
   set fan2_div 4
   set fan1_min 2000
   set fan2_min 2000
   ignore fan3

Again, with no success. The fan value isn't corrected. Or is this
a userland problem. (Divide yourself and get happy?)

> > temp1:    +77.0°C   (limit = +60°C, hysteresis = +50°C) sensor =
> > thermistor <46°C>
> > temp2:    +76.5°C   (limit = +60°C, hysteresis = +50°C) sensor =
> > thermistor <41°C>
> > temp3:    +77.0°C   (limit = +60°C, hysteresis = +50°C) sensor =
> > thermistor <46°C>
>
> thermistor type is wrong.
>
> echo "2" > /proc/sys/dev/sensors/w83782d-i2c-0-2d/sensor{1..3}

That does the trick. I was looking at the wrong place ("w83781d")...

   set sensor1 2
   set sensor2 2
   set sensor3 2

# examples for temperature limits
    set temp1_over 65···
    set temp1_hyst 55···
    set temp2_over 65···
    set temp2_hyst 55···
    set temp3_over 65···
    set temp3_hyst 55···

Readings from temp2 are always lower than from 1 and 3.
BIOS says:
temp1 = cpu0
temp2 = cpu1
temp3 = chassis

I tend to distrust the BIOS and think that 1 and 3 are cpu temps,
and 2 is chassis temp, but I also tend to distrust these reading
generally, because of the low variance between the readings:
tyrex:~# sensors | egrep ^temp
temp1:    +46.0°C   (limit = +65°C, hysteresis = +55°C) sensor = 3904 
transistor           
temp2:    +42.0°C   (limit = +65°C, hysteresis = +55°C) sensor = 3904 
transistor           
temp3:    +45.0°C   (limit = +65°C, hysteresis = +55°C) sensor = 3904 
transistor          

tyrex:~# sensors | egrep ^temp
temp1:    +46.0°C   (limit = +65°C, hysteresis = +55°C) sensor = 3904 
transistor           
temp2:    +43.0°C   (limit = +65°C, hysteresis = +55°C) sensor = 3904 
transistor           
temp3:    +46.0°C   (limit = +65°C, hysteresis = +55°C) sensor = 3904 
transistor          

More of a headache are the voltage readings:
VCore 1:   +1.74 V  (min =  +1.74 V, max =  +1.93 V)       ALARM  
VCore 2:   +2.84 V  (min =  +1.74 V, max =  +1.93 V)              
+3.3V:     +3.32 V  (min =  +3.13 V, max =  +3.45 V)              
+5V:       +4.89 V  (min =  +4.72 V, max =  +5.24 V)              
+12V:      +4.71 V  (min = +10.79 V, max = +13.19 V)              
-12V:      -2.11 V  (min = -10.90 V, max = -13.21 V)              
-5V:       +2.71 V  (min =  -4.76 V, max =  -5.26 V)              
V5SB:      +4.32 V  (min =  +4.72 V, max =  +5.24 V)              
VBat:      +3.29 V  (min =  +2.40 V, max =  +3.60 V)              
vid:      +1.85 V

VCore 2, +12V, -12V, -5V, V5SB are bogus (and no ALARM flag)

I have no idea how to correct the corresponding formulas in
/etc/sensors.conf. Does somebody did it, before?

> -Dan

Cheers,
Hans-Peter
