Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbTJIKz1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 06:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262004AbTJIKyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 06:54:43 -0400
Received: from mail.convergence.de ([212.84.236.4]:44196 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S261979AbTJIKr6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 06:47:58 -0400
Subject: [PATCH 7/7] Update the AV7110 DVB driver
In-Reply-To: <1065696476413@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Thu, 9 Oct 2003 12:47:57 +0200
Message-Id: <10656964772908@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold (LinuxTV.org CVS maintainer) <hunold@linuxtv.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- [DVB] add vbi device handling for dvb-c cards with analog module
- [DVB] fix error handling upon device initialization
- [DVB] fix DD1_INIT handling of DVB-C w/ analog module installed. (Jon Burgess)
diff -uNrwB --new-file linux-2.6.0-test7/drivers/media/dvb/ttpci/av7110.c linux-2.6.0-test7-patch/drivers/media/dvb/ttpci/av7110.c
--- linux-2.6.0-test7/drivers/media/dvb/ttpci/av7110.c	2003-10-09 10:40:19.000000000 +0200
+++ linux-2.6.0-test7-patch/drivers/media/dvb/ttpci/av7110.c	2003-10-09 10:30:43.000000000 +0200
@@ -55,8 +55,10 @@
 #include <linux/ptrace.h>
 #include <linux/ioport.h>
 #include <linux/in.h>
+#include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/pci.h>
+#include <linux/init.h>
 #include <linux/vmalloc.h>
 #include <linux/netdevice.h>
 #include <linux/inetdevice.h>
@@ -4520,28 +4526,6 @@
 
 	DEB_EE(("dev: %p, av7110: %p\n",dev,av7110));
 
-	/* special case DVB-C: these cards have an analog tuner
-	   plus need some special handling, so we have separate
-	   saa7146_ext_vv data for these... */
-	if (dev->pci->subsystem_vendor == 0x110a) {
-		ret = saa7146_vv_init(dev, &av7110_vv_data_c);
-	} else {
-		ret = saa7146_vv_init(dev, &av7110_vv_data_st);
-	}
-	
-	if ( 0 != ret) {
-		ERR(("cannot init capture device. skipping.\n"));
-		kfree(av7110);
-		return -1;
-	}
-
-	if (saa7146_register_device(&av7110->v4l_dev, dev, "av7110", VFL_TYPE_GRABBER)) {
-		ERR(("cannot register capture device. skipping.\n"));
-		saa7146_vv_release(dev);
-		kfree(av7110);
-		return -1;
-	}
-
 	av7110->dev=(struct saa7146_dev *)dev;
 	dvb_register_adapter(&av7110->dvb_adapter, av7110->card_name);
 
@@ -4555,8 +4539,6 @@
 						av7110->dvb_adapter, 0);
 
 	if (!av7110->i2c_bus) {
-		saa7146_unregister_device(&av7110->v4l_dev, dev);
-		saa7146_vv_release(dev);
 		dvb_unregister_adapter (av7110->dvb_adapter);
 		kfree(av7110);
 		return -ENOMEM;
@@ -4727,7 +4709,7 @@
 		memcpy(standard,dvb_standard,sizeof(struct saa7146_standard)*2);
 		/* set dd1 stream a & b */
       		saa7146_write(dev, DD1_STREAM_B, 0x00000000);
-		saa7146_write(dev, DD1_INIT, 0x0200700);
+		saa7146_write(dev, DD1_INIT, 0x02000700);
 		saa7146_write(dev, MC2, (MASK_09 | MASK_25 | MASK_10 | MASK_26));
 	}
 	else if (dev->pci->subsystem_vendor == 0x110a) {
@@ -4754,17 +4736,52 @@
 	av7110_setup_irc_config (av7110, 0);
 	av7110_register(av7110);
 	
+	/* special case DVB-C: these cards have an analog tuner
+	   plus need some special handling, so we have separate
+	   saa7146_ext_vv data for these... */
+	if (0 != av7110->has_analog_tuner) {
+		ret = saa7146_vv_init(dev, &av7110_vv_data_c);
+	} else {
+		ret = saa7146_vv_init(dev, &av7110_vv_data_st);
+	}
+	
+	if ( 0 != ret) {
+		ERR(("cannot init capture device. skipping.\n"));
+		ret = -ENODEV;
+		goto err;
+	}
+
+	if (saa7146_register_device(&av7110->v4l_dev, dev, "av7110", VFL_TYPE_GRABBER)) {
+		ERR(("cannot register capture device. skipping.\n"));
+		ret = -ENODEV;
+		goto video_err;
+	}
+	
+	if (0 != av7110->has_analog_tuner) {
+		if( 0 != saa7146_register_device(&av7110->vbi_dev, dev, "av7110", VFL_TYPE_VBI)) {
+			ERR(("cannot register vbi v4l2 device. skipping.\n"));
+		}
+		/* we use this to remember that this dvb-c card cannot do vbi */
+		av7110->has_analog_tuner = 2;
+	}	
+
 	printk(KERN_INFO "av7110: found av7110-%d.\n",av7110_num);
 	av7110_num++;
         return 0;
 
+video_err:
+	saa7146_vv_release(dev);
+
 err:
-	if (av7110 )
+	if (NULL != av7110 ) {
 		kfree(av7110);
-
-	/* FIXME: error handling is pretty bogus: memory does not get freed...*/
-	saa7146_unregister_device(&av7110->v4l_dev, dev);
-	saa7146_vv_release(dev);
+	}
+	if (NULL != av7110->debi_virt) {
+		pci_free_consistent(dev->pci, 8192, av7110->debi_virt, av7110->debi_bus);
+	}
+	if (NULL != av7110->iobuf) {
+		vfree(av7110->iobuf);
+	}
 
 	dvb_unregister_i2c_bus (master_xfer,av7110->i2c_bus->adapter,
 				av7110->i2c_bus->id);
@@ -4780,6 +4797,9 @@
 	DEB_EE(("av7110: %p\n",av7110));
 
 	saa7146_unregister_device(&av7110->v4l_dev, saa);
+	if (2 == av7110->has_analog_tuner) {
+		saa7146_unregister_device(&av7110->vbi_dev, saa);
+	}	
 
 	av7110->arm_rmmod=1;
 	wake_up_interruptible(&av7110->arm_wait);
@@ -4948,8 +4968,8 @@
 static struct saa7146_ext_vv av7110_vv_data_c = {
 	.inputs		= 1,
 	.audios 	= 1,
-	.capabilities	= V4L2_CAP_TUNER,
-	.flags		= 0,
+	.capabilities	= V4L2_CAP_TUNER | V4L2_CAP_VBI_CAPTURE,
+	.flags		= SAA7146_USE_PORT_B_FOR_VBI,
 
 	.stds		= &standard[0],
 	.num_stds	= sizeof(standard)/sizeof(struct saa7146_standard),
diff -uNrwB --new-file linux-2.6.0-test7/drivers/media/dvb/ttpci/av7110.h linux-2.6.0-test7-patch/drivers/media/dvb/ttpci/av7110.h
--- linux-2.6.0-test7/drivers/media/dvb/ttpci/av7110.h	2003-10-09 10:40:19.000000000 +0200
+++ linux-2.6.0-test7-patch/drivers/media/dvb/ttpci/av7110.h	2003-10-06 15:31:36.000000000 +0200
@@ -399,14 +399,16 @@
 
         struct dvb_device       dvb_dev;
         struct dvb_net               dvb_net;
+
 	struct video_device	v4l_dev;
+	struct video_device	vbi_dev;
 
         struct saa7146_dev	*dev;
 
 	struct dvb_i2c_bus	*i2c_bus;	
 	char			*card_name;
 
-	/* support for analog module of dvb-c */
+	/* support for analog module of dvb-c */
 	int			has_analog_tuner;
 	int			current_input;
 	u32			current_freq;

