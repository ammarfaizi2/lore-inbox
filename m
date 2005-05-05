Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261978AbVEEHhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261978AbVEEHhs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 03:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbVEEHhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 03:37:48 -0400
Received: from mxsf09.cluster1.charter.net ([209.225.28.209]:50617 "EHLO
	mxsf09.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S261978AbVEEHhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 03:37:34 -0400
X-Ironport-AV: i="3.92,155,1112587200"; 
   d="scan'208"; a="890198839:sNHT13590440"
Subject: [PATCH] kbtab tweaks, pen tool reporting
From: Dave Ahlswede <mightyquinn@letterboxes.org>
To: linux-kernel@vger.kernel.org
Cc: vojtech@suse.cz
Content-Type: text/plain
Date: Thu, 05 May 2005 03:37:29 -0400
Message-Id: <1115278649.31630.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch improves the kbtab behavior with regards to the pen tool a
little bit. I previously submitted a patch with the rather bad behavior
of reporting the pen tool as not-in-use when the device was opened, but
I've changed it around a little this time.

With this patch, the driver will report the pen tool as not-in-use if it
hasn't received input events for over a second-- given the somewhat
sloppy hardware, this seems to be the only way to get a sensible value
here. I hope this is acceptable. 

There's also a few minor tweaks in the last block. I've turned off fuzz
compensation for the X and Y axes, as I found that these actually made
the jitter seem worse when drawing, causing sudden pixel-sized jumps
instead of the more gradual usually-subpixel jumps without the jitter. 

Conversely, some small fuzz compensation seems good on the pressure axis
to help prevent stray click-and-release under low pressure.

Finally, as before, I've corrected the pressure limit to 127 instead of
255 (The upper limit as observed on two KBGear tablets)

Please CC me on any replies; I'm not subscribed to lkml. Thanks much!

Patch against 2.6.11.7 (seems to apply to .12-rc3 too) follows:

--- ../../../../linux-2.6.11.7/drivers/usb/input/kbtab.c 2005-04-07
14:57:08.000000000 -0400
+++ linux/drivers/usb/input/kbtab.c 2005-05-05 02:57:13.000000000 -0400
@@ -1,3 +1,4 @@
+#include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/input.h>
@@ -13,6 +14,9 @@
  * v0.0.2 - Updated, works with 2.5.62 and 2.4.20;
  *           - added pressure-threshold modules param code from
  *              Alex Perry <alex.perry@ieee.org>
+ *           - Report pen tool not in use after ~1 second idle
+ *              Tweak jitter and max pressure limit
+ *              Dave Ahlswede <mightyquinn@letterboxes.org>
  */
 
 #define DRIVER_VERSION "v0.0.2"
@@ -25,6 +29,7 @@
 MODULE_LICENSE(DRIVER_LICENSE);
 
 #define USB_VENDOR_ID_KBGEAR	0x084e
+#define KBTAB_PEN_TIMEOUT_DELAY     1000
 
 static int kb_pressure_click = 0x10;
 module_param(kb_pressure_click, int, 0);
@@ -40,6 +45,7 @@
 	int x, y;
 	int button;
 	int pressure;
+	unsigned long pen_timeout;
 	__u32 serial[2];
 	char phys[32];
 };
@@ -71,7 +77,11 @@
 
 	kbtab->pressure = (data[5]);
 
-	input_report_key(dev, BTN_TOOL_PEN, 1);
+	if (time_after(jiffies, kbtab->pen_timeout))
+		input_report_key(dev, BTN_TOOL_PEN, 0);
+	else
+		input_report_key(dev, BTN_TOOL_PEN, 1);
+	kbtab->pen_timeout = jiffies + KBTAB_PEN_TIMEOUT_DELAY;
 
 	input_report_abs(dev, ABS_X, kbtab->x);
 	input_report_abs(dev, ABS_Y, kbtab->y);
@@ -160,10 +170,11 @@
 
 	kbtab->dev.absmax[ABS_X] = 0x2000;
 	kbtab->dev.absmax[ABS_Y] = 0x1750;
-	kbtab->dev.absmax[ABS_PRESSURE] = 0xff;
+	kbtab->dev.absmax[ABS_PRESSURE] = 0x7F;
 	
-	kbtab->dev.absfuzz[ABS_X] = 4;
-	kbtab->dev.absfuzz[ABS_Y] = 4;
+	kbtab->dev.absfuzz[ABS_X] = 0;
+	kbtab->dev.absfuzz[ABS_Y] = 0;
+	kbtab->dev.absfuzz[ABS_PRESSURE] = 2;
 
 	kbtab->dev.private = kbtab;
 	kbtab->dev.open = kbtab_open;


