Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262837AbUG1TXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262837AbUG1TXc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 15:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbUG1TXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 15:23:32 -0400
Received: from av1-1-sn3.vrr.skanova.net ([81.228.9.105]:16809 "EHLO
	av1-1-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S263429AbUG1TWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 15:22:33 -0400
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [RFT/PATCH 2.6] ALPS touchpad driver
References: <200407110045.08208.dtor_core@ameritech.net>
From: Peter Osterlund <petero2@telia.com>
Date: 28 Jul 2004 21:22:17 +0200
In-Reply-To: <200407110045.08208.dtor_core@ameritech.net>
Message-ID: <m3u0vsszrq.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dtor_core@ameritech.net> writes:

> I lifted some code off tpconfig and merged it with Peter's/Neil's ALPS driver.
> The driver will try to auto-detect presence of an ALPS touchpad by issuing
> E6/E7 requests and matching responses with known ALPS signatures. It will
> also try disabling hardware tapping so taps could be controlled by either
> userspace drivers (X/GPM) or future version of mousedev (2.6.8 I hope will
> have it).

I now have a computer with an ALPS touchpad, and your patch works
better than the old patch, even though there are some issues.
Auto-detection works:

        alps.c: E6 report: 00 00 64
        alps.c: E7 report: 73 02 0a
        alps.c: E6 report: 00 00 64
        alps.c: E7 report: 73 02 0a
        alps.c: Status: 15 01 0a
        ALPS Touchpad (Glidepoint) detected
          Disabling hardware tapping
        alps.c: Status: 11 01 0a
        input: AlpsPS/2 ALPS TouchPad on isa0060/serio4

However, fast double taps are no longer detected. The second tap is
simply ignored. I added this printk:

	printk("time:%lu x:%3d y:%3d z:%3d %d%d%d %d%d%d %d%d%d\n",
	       jiffies, x, y, z,
	       (packet[0] & 0x04) != 0, (packet[0] & 0x02) != 0, (packet[0] & 0x01) != 0,
	       (packet[2] & 0x04) != 0, (packet[2] & 0x02) != 0, (packet[2] & 0x01) != 0,
	       (packet[3] & 0x04) != 0, (packet[3] & 0x02) != 0, (packet[3] & 0x01) != 0);

to alps_process_packet() and made some tests:

A single tap gives:

        time:2836613 x:469 y:445 z: 16 111 010 000
        time:2836714 x:469 y:445 z:  0 111 000 000

Note that taps always generate z==16, and they always appear to be
100ms long. Apparently the touchpad firmware is still trying to be
clever instead of just reporting the measured x/y/z values.
Unfortunately a fast double tap generates exactly the same response.
The second tap is not detected.

A slightly longer tap (>100ms I think) gives:

        time:2947819 x:575 y:466 z: 79 111 010 000
        time:2947911 x:575 y:466 z: 52 111 010 000
        time:2947931 x:575 y:466 z:  0 111 000 000
        time:2947991 x:575 y:466 z: 16 111 010 000
        time:2948092 x:575 y:466 z:  0 111 000 000

This gets translated to a double click by the X driver (assuming
FingerHigh<16), even though I only tapped once.

If I hold the finger even longer on the pad before releasing it
(>~180ms I think), the touchpad reports:

        time:3180578 x:656 y:432 z: 78 111 010 000
        time:3180728 x:656 y:432 z: 71 111 010 000
        time:3180737 x:656 y:432 z: 42 111 010 000
        time:3180746 x:656 y:432 z:  0 111 000 000

Now it doesn't try to be clever, and instead reports the true x/y/z
values.

I tried the windows driver, and it correctly detects fast double taps,
which makes me think it is not using the "hardware tapping off" mode.
Therefore, it made some tests with hardware tapping enabled.

A short single tap now gives:

        time:3850310 x:574 y:402 z:  0 111 001 000
        time:3850410 x:574 y:402 z:  0 111 000 000

Ie, z==0 but the gesture bit is set to 1 for 100ms.

A fast double tap gives:

        time:3951723 x:589 y:359 z:  0 111 001 000
        time:3951865 x:589 y:359 z:  0 111 000 000
        time:3951883 x:617 y:354 z:  0 111 001 000
        time:3951905 x:617 y:354 z:  0 111 000 000

which is good, since it no longer looks identical to a single tap.

A longer tap gives:

        time:4161527 x:506 y:480 z: 90 111 010 000
        time:4161560 x:506 y:480 z: 68 111 010 000
        time:4161579 x:506 y:480 z:  0 111 000 000

So, it looks like it would be enough to convert the gesture bit to
some sufficiently large Z value. However, that's not enough, because a
tap-and-drag (touch-release-touch-drag-release) operation gives:

        time:4221184 x:502 y:444 z:  0 111 001 000
        time:4221312 x:542 y:365 z: 73 111 011 000
        time:4221324 x:540 y:368 z: 74 111 011 000
        ...
        time:4221543 x:511 y:419 z: 24 111 011 000
        time:4221554 x:511 y:419 z:  0 111 001 000
        time:4221577 x:511 y:419 z:  0 111 000 000

Note that there is no indication from the hardware that the finger was
released and then touched again between the first and second lines.
This case can be handled too by the driver, by detecting when the
state changes from "!fin && ges" to "fin && ges". With that logic
added, the driver can undo most of the damage caused by hardware tap
emulation, but sometimes there are delays between state changes which
I haven't completely understood yet. Setting MaxTapTime >= 210 in the
X driver seems to make it work quite well though.

The above analysis leads to the patch below. The static variable
obviously has to go in the final version. This patch is only to
illustrate the logic/ugliness needed to make my touchpad behave
reasonably.

---

 linux-petero/drivers/input/mouse/alps.c |   28 +++++++++++++++++++++++++---
 1 files changed, 25 insertions(+), 3 deletions(-)

diff -puN drivers/input/mouse/alps.c~alps-test drivers/input/mouse/alps.c
--- linux/drivers/input/mouse/alps.c~alps-test	2004-07-27 23:15:40.000000000 +0200
+++ linux-petero/drivers/input/mouse/alps.c	2004-07-28 20:53:06.993329536 +0200
@@ -80,6 +80,8 @@ static void alps_process_packet(struct p
 	struct input_dev *dev = &psmouse->dev;
 	int x, y, z;
 	int left = 0, right = 0, middle = 0;
+	int ges, fin;
+	static int prev_fin;
 
 	input_regs(dev, regs);
 
@@ -87,6 +89,27 @@ static void alps_process_packet(struct p
 	y = (packet[4] & 0x7f) | ((packet[3] & 0x70)<<(7-4));
 	z = packet[5];
 
+	printk("time:%lu x:%3d y:%3d z:%3d %d%d%d %d%d%d %d%d%d\n",
+	       jiffies, x, y, z,
+	       (packet[0] & 0x04) != 0, (packet[0] & 0x02) != 0, (packet[0] & 0x01) != 0,
+	       (packet[2] & 0x04) != 0, (packet[2] & 0x02) != 0, (packet[2] & 0x01) != 0,
+	       (packet[3] & 0x04) != 0, (packet[3] & 0x02) != 0, (packet[3] & 0x01) != 0);
+
+	ges = packet[2] & 1;
+	fin = packet[2] & 2;
+
+	if (ges && !fin)
+		z = 40;
+
+	if (ges && fin && !prev_fin) {
+		input_report_abs(dev, ABS_X, x);
+		input_report_abs(dev, ABS_Y, y);
+		input_report_abs(dev, ABS_PRESSURE, 0);
+		input_report_key(dev, BTN_TOOL_FINGER, 0);
+		input_sync(dev);
+	}
+	prev_fin = fin;
+
 	if (z > 30) input_report_key(dev, BTN_TOUCH, 1);
 	if (z < 25) input_report_key(dev, BTN_TOUCH, 0);
 
@@ -97,7 +120,6 @@ static void alps_process_packet(struct p
 	input_report_abs(dev, ABS_PRESSURE, z);
 	input_report_key(dev, BTN_TOOL_FINGER, z > 0);
 
-	left  |= (packet[2]     ) & 1;
 	left  |= (packet[3]     ) & 1;
 	right |= (packet[3] >> 1) & 1;
 	if (packet[0] == 0xff) {
@@ -289,7 +311,7 @@ static int alps_reconnect(struct psmouse
 		return -1;
 
 	if ((model == ALPS_MODEL_DUALPOINT ? param[2] : param[0]) & 0x04)
-		alps_tap_mode(psmouse, model, 0);
+		alps_tap_mode(psmouse, model, 1);
 
 	if (alps_absolute_mode(psmouse)) {
 		printk(KERN_ERR "alps.c: Failed to enable absolute mode\n");
@@ -322,7 +344,7 @@ int alps_init(struct psmouse *psmouse)
 
 	if ((model == ALPS_MODEL_DUALPOINT ? param[2] : param[0]) & 0x04) {
 		printk(KERN_INFO "  Disabling hardware tapping\n");
-		if (alps_tap_mode(psmouse, model, 0))
+		if (alps_tap_mode(psmouse, model, 1))
 			printk(KERN_WARNING "alps.c: Failed to disable hardware tapping\n");
 	}
 
_

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
