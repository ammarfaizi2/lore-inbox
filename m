Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267976AbUJCPsC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267976AbUJCPsC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 11:48:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267978AbUJCPsC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 11:48:02 -0400
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:48132 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S267976AbUJCPrz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 11:47:55 -0400
Date: Sun, 3 Oct 2004 17:48:37 +0200
From: Jean Delvare <khali@linux-fr.org>
To: LM Sensors <sensors@stimpy.netroedge.com>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Fourth auto-fan control interface proposal
Message-Id: <20041003174837.5eb0ae72.khali@linux-fr.org>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here comes my fourth (and hopefully last) sysfs interface proposal for
implementing auto-fan control in 2.6. Previous proposals have been
discussed here:

[1] http://archives.andrew.net.au/lm-sensors/msg07517.html
[2] http://archives.andrew.net.au/lm-sensors/msg08049.html
[3] http://archives.andrew.net.au/lm-sensors/msg18008.html

The interface is still made up of two parts: per fan temp channels
selection, and trip points selection. Changes from the third proposal:

pwm[1-*]_enable value 2 is now used to explicitely state the auto pwm
mode. This was proposed by Mark D. Studebaker [4].

[4] http://archives.andrew.net.au/lm-sensors/msg18011.html

Temp channels selection
=======================

Renamed files from fan[1-*]_auto_channels to
pwm[1-*]_auto_channels_temp. The change from fan tp pwm is to match the
recent renaming suggested by Mark M. Hoffman [5]. The "_temp" suffix is
to leave some room for a "_fan" suffix at a later time if new chips
drive auto pwm according to fan speeds instead of temperature.

[5] http://archives.andrew.net.au/lm-sensors/msg18797.html

Trip points
===========

Trip points are now numbered (point1, point2, etc...) instead of named
(_off, _min, _max, _full...). This solves the problem of various chips
having a different number of trip points. The interface is still chip
independent in that it doesn't require chip-specific knowledge to be
used by user-space apps.

The reason for this change is that newer chips tend to have more trip
points. the LM63 has 8, the LM93 has no less than 12. Also, I read in
the LM63 datasheet that ideal pwm vs temperature curve were parabolic in
shape. Seems hard to achieve this if we arbitrarily lock the number of
trip points to 3 ;)

I also introduced an optional hysteresis temperature for trip points.
The LM63 has this. Since it makes full sense I'd expect other chips to
propose this as well.

As before, there are two sets of files, each chip driver picks the one
matching its internal model: trip points are either temperature
channel-dependent (ADM1031...) or pwm channel-dependent (IT87xx...). If
we ever come accross fan speed-driven pwm outputs where trip points are
fan channel-dependent we may have to offer a third set of files. We'll
see when/if this happens.

I hope I have taken everyone's comments and advice into account and we
can make this interface proposal part of the sysfs interface standard
now. I'm sorry it took so long. Comments welcome.

Thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.9-rc2-mm4/Documentation/i2c/sysfs-interface.orig	2004-10-03 16:42:09.000000000 +0200
+++ linux-2.6.9-rc2-mm4/Documentation/i2c/sysfs-interface	2004-10-03 17:43:13.000000000 +0200
@@ -138,6 +138,7 @@
 *******
 * PWM *
 *******
+
 pwm[1-3]	Pulse width modulation fan control.
 		Integer value in the range 0 to 255
 		Read/Write
@@ -147,9 +148,31 @@
 		Switch PWM on and off.
 		Not always present even if fan*_pwm is.
 		0 to turn off
-		1 to turn on
+		1 to turn on in manual mode
+		2 to turn on in automatic mode
 		Read/Write
 
+pwm[1-*]_auto_channels_temp
+		Select which temperature channels affect this PWM output in
+		auto mode. Bitfield, 1 is temp1, 2 is temp2, 4 is temp3 etc...
+		Which values are possible depend on the chip used.
+
+pwm[1-*]_auto_point[1-*]_pwm
+pwm[1-*]_auto_point[1-*]_temp
+pwm[1-*]_auto_point[1-*]_temp_hyst
+		Define the PWM vs temperature curve. Number of trip points is
+		chip-dependent. Use this for chips which associate trip points
+		to PWM output channels.
+
+OR
+
+temp[1-*]_auto_point[1-*]_pwm
+temp[1-*]_auto_point[1-*]_temp
+temp[1-*]_auto_point[1-*]_temp_hyst
+		Define the PWM vs temperature curve. Number of trip points is
+		chip-dependent. Use this for chips which associate trip points
+		to temperature channels.
+
 
 ****************
 * Temperatures *


-- 
Jean Delvare
http://khali.linux-fr.org/
