Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270034AbUJTL2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270034AbUJTL2g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 07:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270032AbUJTL2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 07:28:11 -0400
Received: from mxsf21.cluster1.charter.net ([209.225.28.221]:2285 "EHLO
	mxsf21.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S270034AbUJTL13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 07:27:29 -0400
X-Ironport-AV: i="3.85,154,1094443200"; 
   d="scan'208"; a="359565554:sNHT12668472"
Subject: [PATCH] Make kbtab play nice with wacom_drv in Xorg/XFree86
From: Dave Ahlswede <mightyquinn@charter.net>
Reply-To: mightyquinn@letterboxes.org
To: linux-kernel@vger.kernel.org
Cc: vojtech@suse.cz
Content-Type: text/plain
Date: Wed, 20 Oct 2004 07:27:21 -0400
Message-Id: <1098271641.26932.12.camel@sayuki>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In its current state, the kbtab driver can be made to work with the
XF86/Xorg Wacom driver, but only once per modprobe. If X is restarted,
the driver won't report any input events. This is because the driver
always reports the pen tool as being in use, and the information doesn't
seem to be passed after the first time the device is opened.

This patch fixes the issue by causing the driver to briefly report the
pen not in use each time the device is opened. 

Also, while the specs say the tablet is supposed to have 256 levels of
pressure sensitivity, it only seems to report 0-127 on both tablets that
I have access to. This patch changes the reported bounds to cooperate
better with Gimp 2.1.

To actually use this in X, it may require the latest stable driver from
http://linuxwacom.sourceforge.net
--Dave Ahlswede

(Please CC me personally with any replies, as I'm not subscribed to the
list-- thanks!)

Patch follows:
--- linux-2.6.7-orig/drivers/usb/input/kbtab.c	2004-06-16 01:18:38 -0400
+++ linux-2.6.7-da1/drivers/usb/input/kbtab.c	2004-08-08 11:08:00 -0400
@@ -13,6 +13,9 @@
  * v0.0.2 - Updated, works with 2.5.62 and 2.4.20;
  *           - added pressure-threshold modules param code from
  *              Alex Perry <alex.perry@ieee.org>
+ *           - fixed so driver always reports the pen tool in use
+ *              after first device open, and max pressure limit(?)
+ *              Dave Ahlswede <mightyquinn@letterboxes.org>
  */
 
 #define DRIVER_VERSION "v0.0.2"
@@ -105,9 +108,10 @@
 {
 	struct kbtab *kbtab = dev->private;
 
-	if (kbtab->open++)
+	if (kbtab->open++) {
+		input_report_key(dev, BTN_TOOL_PEN, 0);
 		return 0;
-
+	}
 	kbtab->irq->dev = kbtab->usbdev;
 	if (usb_submit_urb(kbtab->irq, GFP_KERNEL)) {
 		kbtab->open--;
@@ -160,7 +164,7 @@
 
 	kbtab->dev.absmax[ABS_X] = 0x2000;
 	kbtab->dev.absmax[ABS_Y] = 0x1750;
-	kbtab->dev.absmax[ABS_PRESSURE] = 0xff;
+	kbtab->dev.absmax[ABS_PRESSURE] = 0x7F;
 	
 	kbtab->dev.absfuzz[ABS_X] = 4;
 	kbtab->dev.absfuzz[ABS_Y] = 4;


