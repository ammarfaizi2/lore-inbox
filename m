Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbUCKSeh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 13:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbUCKSeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 13:34:37 -0500
Received: from dd1802.kasserver.com ([81.209.148.61]:19841 "EHLO
	dd1802.kasserver.com") by vger.kernel.org with ESMTP
	id S261646AbUCKSeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 13:34:31 -0500
Message-ID: <4050B134.4090800@triphoenix.de>
Date: Thu, 11 Mar 2004 19:34:28 +0100
From: Dennis Bliefernicht <kernel@triphoenix.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: vojtech@suse.cz
Subject: [PATCH] gamecon.c mapping axes to buttons, kernel 2.6.4
Content-Type: multipart/mixed;
 boundary="------------030903000201050503030202"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030903000201050503030202
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch enables a module parameter for the gamecon module to enable mapping 
the X and Y axis onto buttons for PSX controllers. This is necessary for 
certain game controllers that need left and right for example pressed at the 
same time (the PSX dance mats are a famous example). If the module parameter 
gc_psx_map_axes=1 is given, the left/right/up/down directions won't be mapped 
to X/Y-axes but to BTN_TL, BTN_TR, BTN_TL2 and BTN_TR2.
The patch ist against 2.6.X kernels (worked since 2.6.0 up to 2.6.4 for me). 
The patch worked fine for several months now for me, any feedback is appreciated.
Patch is attached.

--------------030903000201050503030202
Content-Type: text/x-diff;
 name="gamecon-mapaxes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gamecon-mapaxes.patch"

Only in /usr/src/linux-2.6.4: config-2.6.4-rc1
diff -r -u linux-2.6.4/drivers/input/joystick/gamecon.c /usr/src/linux-2.6.4/drivers/input/joystick/gamecon.c
--- linux-2.6.4/drivers/input/joystick/gamecon.c	2004-03-11 03:55:54.000000000 +0100
+++ /usr/src/linux-2.6.4/drivers/input/joystick/gamecon.c	2004-03-11 15:30:59.000000000 +0100
@@ -47,6 +47,7 @@
 MODULE_PARM(gc_2,"2-6i");
 MODULE_PARM(gc_3,"2-6i");
 MODULE_PARM(gc_psx_delay, "i");
+MODULE_PARM(gc_psx_map_axes, "i");
 
 #define GC_SNES		1
 #define GC_NES		2
@@ -231,6 +232,7 @@
 #define GC_PSX_ID(x)	((x) >> 4)	/* High nibble is device type */
 #define GC_PSX_LEN(x)	((x) & 0xf)	/* Low nibble is length in words */
 
+static int gc_psx_map_axes = 0;
 static int gc_psx_delay = GC_PSX_DELAY;
 static short gc_psx_abs[] = { ABS_X, ABS_Y, ABS_RX, ABS_RY, ABS_HAT0X, ABS_HAT0Y };
 static short gc_psx_btn[] = { BTN_TL, BTN_TR, BTN_TL2, BTN_TR2, BTN_A, BTN_B, BTN_X, BTN_Y,
@@ -410,7 +412,6 @@
 
 			case GC_PSX_NEGCON:
 			case GC_PSX_ANALOG:
-
 				for (j = 0; j < 4; j++)
 					input_report_abs(dev + i, gc_psx_abs[j], data[j + 2]);
 
@@ -429,11 +430,23 @@
 
 			case GC_PSX_NORMAL:
 
-				input_report_abs(dev + i, ABS_X, 128 + !(data[0] & 0x20) * 127 - !(data[0] & 0x80) * 128);
-				input_report_abs(dev + i, ABS_Y, 128 + !(data[0] & 0x40) * 127 - !(data[0] & 0x10) * 128);
+				if (!gc_psx_map_axes) {
+					input_report_abs(dev + i, ABS_X, 128 + !(data[0] & 0x20) * 127 - !(data[0] & 0x80) * 128);
+					input_report_abs(dev + i, ABS_Y, 128 + !(data[0] & 0x40) * 127 - !(data[0] & 0x10) * 128);
+
+					for (j = 0; j < 8; j++)
+						input_report_key(dev + i, gc_psx_btn[j], ~data[1] & (1 << j));
+				} else {
+					// map axes to buttons
+					input_report_key(dev + i, BTN_TL, (~data[0] & 0x80) | (~data[1] & 0x01));
+					input_report_key(dev + i, BTN_TR, (~data[0] & 0x20) | (~data[1] & 0x02));
+					input_report_key(dev + i, BTN_TL2, (~data[0] & 0x10) | (~data[1] & 0x04));
+					input_report_key(dev + i, BTN_TR2, (~data[0] & 0x40) | (~data[1] & 0x08));
+
+					for (j = 4; j < 8; j++)
+						input_report_key(dev + i, gc_psx_btn[j], ~data[1] & (1 << j));
+				}
 
-				for (j = 0; j < 8; j++)
-					input_report_key(dev + i, gc_psx_btn[j], ~data[1] & (1 << j));
 
 				input_report_key(dev + i, BTN_START,  ~data[0] & 0x08);
 				input_report_key(dev + i, BTN_SELECT, ~data[0] & 0x01);
@@ -656,10 +669,17 @@
 }
 static int __init gc_psx_setup(char *str)
 {
+static int __init gc_psx_map_setup(char *str)
+{
+	get_option(&str, &gc_psx_map_axes);
+	return 1;
+}
+
         get_option(&str, &gc_psx_delay);
         return 1;
 }
 __setup("gc=", gc_setup);
+__setup("gc_psx_map_axes=", gc_psx_map_setup);
 __setup("gc_2=", gc_setup_2);
 __setup("gc_3=", gc_setup_3);
 __setup("gc_psx_delay=", gc_psx_setup);

--------------030903000201050503030202
Content-Type: text/plain;
 name="README"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="README"

This patch adds the option to map the axes of a PSX-controller to buttons in order to use controllers which depend on this (the famous dance mats for example)
patch created by Dennis Bliefernicht <kernel@triphoenix.de>

--------------030903000201050503030202--
