Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262943AbTIAPNZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 11:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262976AbTIAPNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 11:13:25 -0400
Received: from m206.net81-67-10.noos.fr ([81.67.10.206]:63458 "EHLO
	deep-space-9.dsnet") by vger.kernel.org with ESMTP id S262943AbTIAPNJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 11:13:09 -0400
Date: Mon, 1 Sep 2003 17:13:07 +0200
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 2.6.0-test4] meye driver update
Message-ID: <20030901151307.GC27269@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The attached patch implements the needed 'release' callback in order
to make videodev/sysfs happy again.

Linus, please apply.

Thanks,

Stelian.

===== drivers/media/video/meye.h 1.8 vs edited =====
--- 1.8/drivers/media/video/meye.h	Wed Apr 16 12:01:38 2003
+++ edited/drivers/media/video/meye.h	Tue Aug 26 16:48:06 2003
@@ -312,7 +312,7 @@
 
 	struct meye_queue grabq;	/* queue for buffers to be grabbed */
 
-	struct video_device video_dev;	/* video device parameters */
+	struct video_device *video_dev;	/* video device parameters */
 	struct video_picture picture;	/* video picture parameters */
 	struct meye_params params;	/* additional parameters */
 #ifdef CONFIG_PM
===== drivers/media/video/meye.c 1.18 vs edited =====
--- 1.18/drivers/media/video/meye.c	Thu Jul 31 17:59:04 2003
+++ edited/drivers/media/video/meye.c	Wed Aug 27 11:24:51 2003
@@ -920,7 +920,7 @@
 
 	case VIDIOCGCAP: {
 		struct video_capability *b = arg;
-		strcpy(b->name,meye.video_dev.name);
+		strcpy(b->name,meye.video_dev->name);
 		b->type = VID_TYPE_CAPTURE;
 		b->channels = 1;
 		b->audios = 0;
@@ -1225,6 +1225,8 @@
 	.type		= VID_TYPE_CAPTURE,
 	.hardware	= VID_HARDWARE_MEYE,
 	.fops		= &meye_fops,
+	.release	= video_device_release,
+	.minor		= -1,
 };
 
 #ifdef CONFIG_PM
@@ -1275,10 +1277,17 @@
 		goto out1;
 	}
 
-	sonypi_camera_command(SONYPI_COMMAND_SETCAMERA, 1);
-
 	meye.mchip_dev = pcidev;
-	memcpy(&meye.video_dev, &meye_template, sizeof(meye_template));
+	meye.video_dev = video_device_alloc();
+	if (!meye.video_dev) {
+		printk(KERN_ERR "meye: video_device_alloc() failed!\n");
+		ret = -EBUSY;
+		goto out1;
+	}
+	memcpy(meye.video_dev, &meye_template, sizeof(meye_template));
+	meye.video_dev->dev = &meye.mchip_dev->dev;
+
+	sonypi_camera_command(SONYPI_COMMAND_SETCAMERA, 1);
 
 	if ((ret = pci_enable_device(meye.mchip_dev))) {
 		printk(KERN_ERR "meye: pci_enable_device failed\n");
@@ -1335,7 +1344,7 @@
 	wait_ms(1);
 	mchip_set(MCHIP_MM_INTA, MCHIP_MM_INTA_HIC_1_MASK);
 
-	if (video_register_device(&meye.video_dev, VFL_TYPE_GRABBER, video_nr) < 0) {
+	if (video_register_device(meye.video_dev, VFL_TYPE_GRABBER, video_nr) < 0) {
 
 		printk(KERN_ERR "meye: video_register_device failed\n");
 		ret = -EIO;
@@ -1383,6 +1392,9 @@
 out3:
 	pci_disable_device(meye.mchip_dev);
 out2:
+	video_device_release(meye.video_dev);
+	meye.video_dev = NULL;
+
 	sonypi_camera_command(SONYPI_COMMAND_SETCAMERA, 0);
 out1:
 	return ret;
@@ -1390,7 +1402,7 @@
 
 static void __devexit meye_remove(struct pci_dev *pcidev) {
 
-	video_unregister_device(&meye.video_dev);
+	video_unregister_device(meye.video_dev);
 
 	mchip_hic_stop();
 
-- 
Stelian Pop <stelian@popies.net>
