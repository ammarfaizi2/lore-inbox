Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263293AbTJZQrv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 11:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263303AbTJZQrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 11:47:51 -0500
Received: from m77.net81-65-140.noos.fr ([81.65.140.77]:17577 "EHLO
	deep-space-9.dsnet") by vger.kernel.org with ESMTP id S263293AbTJZQrr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 11:47:47 -0500
Date: Sun, 26 Oct 2003 17:47:10 +0100
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: marcelo.tosatti@cyclades.com
Subject: [PATCH 2.4.23-pre8] meye driver update
Message-ID: <20031026164710.GR4013@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	marcelo.tosatti@cyclades.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch updates the meye driver with:
	* some documentation on a forth camera model (unsupported)
	* headers cleanup backported from 2.6
	* irqreturn_t constructs backported from 2.6
	* use the new videodev video_device_alloc/video_device_release

Marcelo, please apply.

Thanks,

Stelian.


===== Documentation/video4linux/meye.txt 1.7 vs edited =====
--- 1.7/Documentation/video4linux/meye.txt	Fri Aug  1 14:47:23 2003
+++ edited/Documentation/video4linux/meye.txt	Sun Oct 26 14:57:58 2003
@@ -33,6 +33,11 @@
 driver however), but things are not moving very fast (see
 http://r-engine.sourceforge.net/) (PCI vendor/device is 0x10cf/0x2011).
 
+There is a forth model connected on the USB bus in TR1* Vaio laptops.
+This camera is not supported at all by the current driver, in fact
+little information if any is available for this camera
+(USB vendor/device is 0x054c/0x0107).
+
 Driver options:
 ---------------
 
===== drivers/media/video/meye.h 1.9 vs edited =====
--- 1.9/drivers/media/video/meye.h	Mon Sep  1 12:38:50 2003
+++ edited/drivers/media/video/meye.h	Sun Oct 26 15:32:45 2003
@@ -31,13 +31,11 @@
 #define _MEYE_PRIV_H_
 
 #define MEYE_DRIVER_MAJORVERSION	1
-#define MEYE_DRIVER_MINORVERSION	7
+#define MEYE_DRIVER_MINORVERSION	8
 
 #include <linux/config.h>
 #include <linux/types.h>
 #include <linux/pci.h>
-#include <linux/sonypi.h>
-#include <linux/meye.h>
 
 /****************************************************************************/
 /* Motion JPEG chip registers                                               */
===== drivers/media/video/meye.c 1.16 vs edited =====
--- 1.16/drivers/media/video/meye.c	Wed Aug 27 13:25:49 2003
+++ edited/drivers/media/video/meye.c	Sun Oct 26 16:21:57 2003
@@ -862,7 +862,7 @@
 /* Interrupt handling                                                       */
 /****************************************************************************/
 
-static void meye_irq(int irq, void *dev_id, struct pt_regs *regs) {
+static irqreturn_t meye_irq(int irq, void *dev_id, struct pt_regs *regs) {
 	u32 v;
 	int reqnr;
 	v = mchip_read(MCHIP_MM_INTA);
@@ -870,7 +870,7 @@
 	while (1) {
 		v = mchip_get_frame();
 		if (!(v & MCHIP_MM_FIR_RDY))
-			return;
+			return IRQ_NONE;
 		switch (meye.mchip_mode) {
 
 		case MCHIP_HIC_MODE_CONT_OUT:
@@ -903,11 +903,12 @@
 
 		default:
 			/* do not free frame, since it can be a snap */
-			return;
+			return IRQ_NONE;
 		} /* switch */
 
 		mchip_free_frame();
 	}
+	return IRQ_HANDLED;
 }
 
 /****************************************************************************/
@@ -1252,6 +1253,7 @@
 	.type		= VID_TYPE_CAPTURE,
 	.hardware	= VID_HARDWARE_MEYE,
 	.fops		= &meye_fops,
+	.release	= video_device_release,
 	.minor		= -1,
 };
 
@@ -1304,7 +1306,7 @@
 	}
 
 	meye.mchip_dev = pcidev;
-	meye.video_dev = kmalloc(sizeof(struct video_device), GFP_KERNEL);
+	meye.video_dev = video_device_alloc();
 	if (!meye.video_dev) {
 		printk(KERN_ERR "meye: video_device_alloc() failed!\n");
 		ret = -EBUSY;
@@ -1417,7 +1419,7 @@
 out3:
 	pci_disable_device(meye.mchip_dev);
 out2:
-	kfree(meye.video_dev);
+	video_device_release(meye.video_dev);
 	meye.video_dev = NULL;
 
 	sonypi_camera_command(SONYPI_COMMAND_SETCAMERA, 0);
-- 
Stelian Pop <stelian@popies.net>
