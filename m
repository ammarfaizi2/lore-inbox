Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266498AbUJTBqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266498AbUJTBqY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 21:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266505AbUJTAzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 20:55:51 -0400
Received: from mail.kroah.org ([69.55.234.183]:436 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266498AbUJTAT1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 20:19:27 -0400
Subject: Re: [PATCH] I2C update for 2.6.9
In-Reply-To: <1098231506642@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 19 Oct 2004 17:18:26 -0700
Message-Id: <10982315063481@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2070, 2004/10/19 15:20:22-07:00, khali@linux-fr.org

[PATCH] I2C: Fourth auto-fan control interface proposal

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


Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 Documentation/i2c/sysfs-interface |   25 ++++++++++++++++++++++++-
 1 files changed, 24 insertions(+), 1 deletion(-)


diff -Nru a/Documentation/i2c/sysfs-interface b/Documentation/i2c/sysfs-interface
--- a/Documentation/i2c/sysfs-interface	2004-10-19 16:54:09 -07:00
+++ b/Documentation/i2c/sysfs-interface	2004-10-19 16:54:09 -07:00
@@ -138,6 +138,7 @@
 *******
 * PWM *
 *******
+
 pwm[1-3]	Pulse width modulation fan control.
 		Integer value in the range 0 to 255
 		Read/Write
@@ -147,8 +148,30 @@
 		Switch PWM on and off.
 		Not always present even if fan*_pwm is.
 		0 to turn off
-		1 to turn on
+		1 to turn on in manual mode
+		2 to turn on in automatic mode
 		Read/Write
+
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
 
 
 ****************

