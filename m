Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267634AbTGQSri (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 14:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271531AbTGQShJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 14:37:09 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:31388 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S271534AbTGQSfR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 14:35:17 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 17 Jul 2003 20:51:19 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] saa7134 driver update
Message-ID: <20030717185119.GA22235@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch is a update for the saa7134 driver.  Changes:

  * add support for a add new card, some detection code changes.
  * fix double i2c bus unregister (=> used to oops on rmmod).
  * add dual languange support.
  * catch kernel_thread() failures.

Please apply,

  Gerd

diff -u linux-2.6.0-test1/drivers/media/video/saa7134/saa7134-cards.c linux/drivers/media/video/saa7134/saa7134-cards.c
--- linux-2.6.0-test1/drivers/media/video/saa7134/saa7134-cards.c	2003-07-17 18:56:50.109689951 +0200
+++ linux/drivers/media/video/saa7134/saa7134-cards.c	2003-07-17 19:13:34.649284273 +0200
@@ -444,7 +444,40 @@
 			.tv   = 1,
 		}},
         },
-	
+	[SAA7134_BOARD_ASUSTeK_TVFM7134] = {
+                .name           = "ASUS TV-FM 7134",
+                .audio_clock    = 0x00187de7,
+                .tuner_type     = TUNER_PHILIPS_FM1216ME_MK3,
+                .need_tda9887   = 1,
+                .inputs         = {{
+                        .name = name_tv,
+                        .vmux = 1,
+                        .amux = TV,
+                        .tv   = 1,
+#if 0 /* untested */
+                },{
+                        .name = name_comp1,
+                        .vmux = 4,
+                        .amux = LINE2,
+                },{
+                        .name = name_comp2,
+                        .vmux = 2,
+                        .amux = LINE2,
+                },{
+                        .name = name_svideo,
+                        .vmux = 6,
+                        .amux = LINE2,
+                },{
+                        .name = "S-Video2",
+                        .vmux = 7,
+                        .amux = LINE2,
+#endif
+                }},
+                .radio = {
+                        .name = name_radio,
+                        .amux = LINE1,
+                },
+        },
 };
 const unsigned int saa7134_bcount = ARRAY_SIZE(saa7134_boards);
 
@@ -519,6 +552,18 @@
 		.subdevice    = 0x226b,
 		.driver_data  = SAA7134_BOARD_ELSA_500TV,
 	},{
+                .vendor       = PCI_VENDOR_ID_PHILIPS,
+                .device       = PCI_DEVICE_ID_PHILIPS_SAA7134,
+                .subvendor    = PCI_VENDOR_ID_ASUSTEK,
+                .subdevice    = 0x4842,
+                .driver_data  = SAA7134_BOARD_ASUSTeK_TVFM7134,
+	},{
+                .vendor       = PCI_VENDOR_ID_PHILIPS,
+                .device       = PCI_DEVICE_ID_PHILIPS_SAA7134,
+                .subvendor    = PCI_VENDOR_ID_ASUSTEK,
+                .subdevice    = 0x4830,
+                .driver_data  = SAA7134_BOARD_ASUSTeK_TVFM7134,
+        },{
 		
 		/* --- boards without eeprom + subsystem ID --- */
                 .vendor       = PCI_VENDOR_ID_PHILIPS,
@@ -595,22 +640,16 @@
 
 static void board_flyvideo(struct saa7134_dev *dev)
 {
+#if 0
 	u32 value;
+	int index;
 
-	saa_writel(SAA7134_GPIO_GPMODE0 >> 2,   0);
-	value = saa_readl(SAA7134_GPIO_GPSTATUS0 >> 2);
-#if 0
-	{
-		int index = (value & 0x1f00) >> 8;
-		printk(KERN_INFO "%s: flyvideo: gpio is 0x%x "
-				"[model=%s,tuner=%d]\n",
-		       dev->name, value, fly_list[index].model,
-		       fly_list[index].tuner_type);
-		dev->tuner_type = fly_list[index].tuner_type;
-	}
-#else
-	printk(KERN_INFO "%s: flyvideo: gpio is 0x%x\n",
-	       dev->name, value);
+	value = dev->gpio_value;
+	index = (value & 0x1f00) >> 8;
+	printk(KERN_INFO "%s: flyvideo: gpio is 0x%x [model=%s,tuner=%d]\n",
+	       dev->name, value, fly_list[index].model,
+	       fly_list[index].tuner_type);
+	dev->tuner_type = fly_list[index].tuner_type;
 #endif
 }
 
@@ -618,6 +657,11 @@
 
 int saa7134_board_init(struct saa7134_dev *dev)
 {
+	// Always print gpio, often manufacturers encode tuner type and other info.
+	saa_writel(SAA7134_GPIO_GPMODE0 >> 2, 0);
+	dev->gpio_value = saa_readl(SAA7134_GPIO_GPSTATUS0 >> 2);
+	printk(KERN_INFO "%s: board init: gpio is %x\n", dev->name, dev->gpio_value);
+
 	switch (dev->board) {
 	case SAA7134_BOARD_FLYVIDEO2000:
 	case SAA7134_BOARD_FLYVIDEO3000:
diff -u linux-2.6.0-test1/drivers/media/video/saa7134/saa7134-core.c linux/drivers/media/video/saa7134/saa7134-core.c
--- linux-2.6.0-test1/drivers/media/video/saa7134/saa7134-core.c	2003-07-17 18:55:30.485362002 +0200
+++ linux/drivers/media/video/saa7134/saa7134-core.c	2003-07-17 19:13:34.655283269 +0200
@@ -35,7 +35,7 @@
 MODULE_AUTHOR("Gerd Knorr <kraxel@bytesex.org> [SuSE Labs]");
 MODULE_LICENSE("GPL");
 
-#define SAA7134_MAXBOARDS 4
+#define SAA7134_MAXBOARDS 8
 
 /* ------------------------------------------------------------------ */
 
@@ -954,7 +954,6 @@
 	saa7134_vbi_fini(dev);
 	saa7134_video_fini(dev);
 	saa7134_tvaudio_fini(dev);
-	saa7134_i2c_unregister(dev);
 
 	/* release ressources */
 	free_irq(pci_dev->irq, dev);
diff -u linux-2.6.0-test1/drivers/media/video/saa7134/saa7134-i2c.c linux/drivers/media/video/saa7134/saa7134-i2c.c
--- linux-2.6.0-test1/drivers/media/video/saa7134/saa7134-i2c.c	2003-07-17 18:55:13.105357045 +0200
+++ linux/drivers/media/video/saa7134/saa7134-i2c.c	2003-07-17 19:13:34.667281261 +0200
@@ -400,6 +400,7 @@
 {
 	dev->i2c_adap = saa7134_adap_template;
 	strcpy(dev->i2c_adap.dev.name,dev->name);
+	dev->i2c_adap.dev.parent = &dev->pci->dev;
 	dev->i2c_adap.algo_data = dev;
 	i2c_add_adapter(&dev->i2c_adap);
 	
diff -u linux-2.6.0-test1/drivers/media/video/saa7134/saa7134-tvaudio.c linux/drivers/media/video/saa7134/saa7134-tvaudio.c
--- linux-2.6.0-test1/drivers/media/video/saa7134/saa7134-tvaudio.c	2003-07-17 18:54:26.028483383 +0200
+++ linux/drivers/media/video/saa7134/saa7134-tvaudio.c	2003-07-17 19:13:34.673280257 +0200
@@ -2,7 +2,7 @@
  * device driver for philips saa7134 based TV cards
  * tv audio decoder (fm stereo, nicam, ...)
  *
- * (c) 2001,02 Gerd Knorr <kraxel@bytesex.org> [SuSE Labs]
+ * (c) 2001-03 Gerd Knorr <kraxel@bytesex.org> [SuSE Labs]
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -547,11 +547,19 @@
 		tvaudio_setstereo(dev,&tvaudio[audio],V4L2_TUNER_MODE_MONO);
 		dev->tvaudio = &tvaudio[audio];
 
-		if (tvaudio_sleep(dev,3*HZ))
-			goto restart;
-		rx = tvaudio_getstereo(dev,&tvaudio[i]);
-		mode = saa7134_tvaudio_rx2mode(rx);
-		tvaudio_setstereo(dev,&tvaudio[audio],mode);
+		for (;;) {
+			if (tvaudio_sleep(dev,3*HZ))
+				break;
+			if (dev->thread.exit || signal_pending(current))
+				break;
+			if (UNSET == dev->thread.mode) {
+				rx = tvaudio_getstereo(dev,&tvaudio[i]);
+				mode = saa7134_tvaudio_rx2mode(rx);
+			} else {
+				mode = dev->thread.mode;
+			}
+			tvaudio_setstereo(dev,&tvaudio[audio],mode);
+		}
 	}
 
  done:
@@ -842,6 +850,7 @@
 {
 	DECLARE_MUTEX_LOCKED(sem);
 	int (*my_thread)(void *data) = NULL;
+	int rc;
 
 	/* enable I2S audio output */
 	if (saa7134_boards[dev->board].i2s_rate) {
@@ -872,8 +881,12 @@
 		/* start tvaudio thread */
 		init_waitqueue_head(&dev->thread.wq);
 		dev->thread.notify = &sem;
-		kernel_thread(my_thread,dev,0);
-		down(&sem);
+		rc = kernel_thread(my_thread,dev,0);
+		if (rc < 0)
+			printk(KERN_WARNING "%s: kernel_thread() failed\n",
+			       dev->name);
+		else
+			down(&sem);
 		dev->thread.notify = NULL;
 		wake_up_interruptible(&dev->thread.wq);
 	}
@@ -900,6 +913,7 @@
 int saa7134_tvaudio_do_scan(struct saa7134_dev *dev)
 {
 	if (dev->thread.task) {
+		dev->thread.mode = UNSET;
 		dev->thread.scan2++;
 		wake_up_interruptible(&dev->thread.wq);
 	} else {
diff -u linux-2.6.0-test1/drivers/media/video/saa7134/saa7134-video.c linux/drivers/media/video/saa7134/saa7134-video.c
--- linux-2.6.0-test1/drivers/media/video/saa7134/saa7134-video.c	2003-07-17 18:55:13.909218803 +0200
+++ linux/drivers/media/video/saa7134/saa7134-video.c	2003-07-17 19:13:34.680279086 +0200
@@ -1643,9 +1643,17 @@
 	}
 	case VIDIOC_S_TUNER:
 	{
-#if 0
 		struct v4l2_tuner *t = arg;
-#endif
+		int rx,mode;
+
+		mode = dev->thread.mode;
+		if (UNSET == mode) {
+			rx   = saa7134_tvaudio_getstereo(dev);
+			mode = saa7134_tvaudio_rx2mode(t->rxsubchans);
+		}
+		if (mode != t->audmode) {
+			dev->thread.mode = t->audmode;
+		}
 		return 0;
 	}
 	case VIDIOC_G_FREQUENCY:
diff -u linux-2.6.0-test1/drivers/media/video/saa7134/saa7134.h linux/drivers/media/video/saa7134/saa7134.h
--- linux-2.6.0-test1/drivers/media/video/saa7134/saa7134.h	2003-07-17 18:56:45.007564774 +0200
+++ linux/drivers/media/video/saa7134/saa7134.h	2003-07-17 19:13:34.685278250 +0200
@@ -28,6 +28,7 @@
 #include <media/audiochip.h>
 #include <media/id.h>
 
+#include <linux/version.h>
 #define SAA7134_VERSION_CODE KERNEL_VERSION(0,2,8)
 
 #ifndef TRUE
@@ -130,6 +131,7 @@
 #define SAA7134_BOARD_TYPHOON_90031    13
 #define SAA7134_BOARD_ELSA             14
 #define SAA7134_BOARD_ELSA_500TV       15
+#define SAA7134_BOARD_ASUSTeK_TVFM7134 16
 
 #define SAA7134_INPUT_MAX 8
 
@@ -197,6 +199,7 @@
 	unsigned int               exit;
 	unsigned int               scan1;
 	unsigned int               scan2;
+	unsigned int               mode;
 };
 
 /* buffer for one video/vbi/ts frame */
@@ -308,6 +311,7 @@
 	/* config info */
 	unsigned int               board;
 	unsigned int               tuner_type;
+	unsigned int               gpio_value;
 
 	/* i2c i/o */
 	struct i2c_adapter         i2c_adap;

-- 
sigfault
