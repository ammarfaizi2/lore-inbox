Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262942AbTIAPMb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 11:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262943AbTIAPMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 11:12:31 -0400
Received: from m206.net81-67-10.noos.fr ([81.67.10.206]:61666 "EHLO
	deep-space-9.dsnet") by vger.kernel.org with ESMTP id S262942AbTIAPLp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 11:11:45 -0400
Date: Mon, 1 Sep 2003 17:11:43 +0200
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH 2.4.23-pre2] meye driver update
Message-ID: <20030901151143.GB27269@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a sync with the 2.5 meye driver. Nothing really important here,
just makes it easier for me to maintain both branches.

Marcelo, please apply.

Thanks,

Stelian.

===== drivers/media/video/meye.h 1.8 vs edited =====
--- 1.8/drivers/media/video/meye.h	Sun Jun 29 18:27:44 2003
+++ edited/drivers/media/video/meye.h	Mon Sep  1 10:38:50 2003
@@ -312,7 +312,7 @@
 
 	struct meye_queue grabq;	/* queue for buffers to be grabbed */
 
-	struct video_device video_dev;	/* video device parameters */
+	struct video_device *video_dev;	/* video device parameters */
 	struct video_picture picture;	/* video picture parameters */
 	struct meye_params params;	/* additional parameters */
 #ifdef CONFIG_PM
===== drivers/media/video/meye.c 1.15 vs edited =====
--- 1.15/drivers/media/video/meye.c	Mon Jul  7 13:48:00 2003
+++ edited/drivers/media/video/meye.c	Wed Aug 27 11:25:49 2003
@@ -947,7 +947,7 @@
 
 	case VIDIOCGCAP: {
 		struct video_capability *b = arg;
-		strcpy(b->name,meye.video_dev.name);
+		strcpy(b->name,meye.video_dev->name);
 		b->type = VID_TYPE_CAPTURE;
 		b->channels = 1;
 		b->audios = 0;
@@ -1252,6 +1252,7 @@
 	.type		= VID_TYPE_CAPTURE,
 	.hardware	= VID_HARDWARE_MEYE,
 	.fops		= &meye_fops,
+	.minor		= -1,
 };
 
 #ifdef CONFIG_PM
@@ -1302,10 +1303,16 @@
 		goto out1;
 	}
 
-	sonypi_camera_command(SONYPI_COMMAND_SETCAMERA, 1);
-
 	meye.mchip_dev = pcidev;
-	memcpy(&meye.video_dev, &meye_template, sizeof(meye_template));
+	meye.video_dev = kmalloc(sizeof(struct video_device), GFP_KERNEL);
+	if (!meye.video_dev) {
+		printk(KERN_ERR "meye: video_device_alloc() failed!\n");
+		ret = -EBUSY;
+		goto out1;
+	}
+	memcpy(meye.video_dev, &meye_template, sizeof(meye_template));
+
+	sonypi_camera_command(SONYPI_COMMAND_SETCAMERA, 1);
 
 	if ((ret = pci_enable_device(meye.mchip_dev))) {
 		printk(KERN_ERR "meye: pci_enable_device failed\n");
@@ -1362,7 +1369,7 @@
 	wait_ms(1);
 	mchip_set(MCHIP_MM_INTA, MCHIP_MM_INTA_HIC_1_MASK);
 
-	if (video_register_device(&meye.video_dev, VFL_TYPE_GRABBER, video_nr) < 0) {
+	if (video_register_device(meye.video_dev, VFL_TYPE_GRABBER, video_nr) < 0) {
 
 		printk(KERN_ERR "meye: video_register_device failed\n");
 		ret = -EIO;
@@ -1410,6 +1417,9 @@
 out3:
 	pci_disable_device(meye.mchip_dev);
 out2:
+	kfree(meye.video_dev);
+	meye.video_dev = NULL;
+
 	sonypi_camera_command(SONYPI_COMMAND_SETCAMERA, 0);
 out1:
 	return ret;
@@ -1417,7 +1427,7 @@
 
 static void __devexit meye_remove(struct pci_dev *pcidev) {
 
-	video_unregister_device(&meye.video_dev);
+	video_unregister_device(meye.video_dev);
 
 	mchip_hic_stop();
 
@@ -1443,7 +1453,7 @@
 	printk(KERN_INFO "meye: removed\n");
 }
 
-static struct pci_device_id meye_pci_tbl[] __devinitdata = {
+static struct pci_device_id meye_pci_tbl[] = {
 	{ PCI_VENDOR_ID_KAWASAKI, PCI_DEVICE_ID_MCHIP_KL5A72002, 
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ }
@@ -1502,8 +1512,6 @@
 MODULE_AUTHOR("Stelian Pop <stelian@popies.net>");
 MODULE_DESCRIPTION("video4linux driver for the MotionEye camera");
 MODULE_LICENSE("GPL");
-
-EXPORT_NO_SYMBOLS;
 
 MODULE_PARM(gbuffers,"i");
 MODULE_PARM_DESC(gbuffers,"number of capture buffers, default is 2 (32 max)");
-- 
Stelian Pop <stelian@popies.net>
