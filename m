Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265895AbUAKOsk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 09:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265890AbUAKOsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 09:48:40 -0500
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]:36110 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S265895AbUAKOsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 09:48:36 -0500
Date: Sun, 11 Jan 2004 15:50:27 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@Stimpy.netroedge.com>
Subject: [PATCH 2.4] i2c cleanups, third wave (4/8)
Message-Id: <20040111155027.6e1e2b42.khali@linux-fr.org>
In-Reply-To: <20040111144214.7a6a4e59.khali@linux-fr.org>
References: <20040111144214.7a6a4e59.khali@linux-fr.org>
Reply-To: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@Stimpy.netroedge.com>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch doesn't really focus on the i2c subsystem, but is still
i2c-related. It concerns the media/video subsystem, where I discovered a
few incorrectnesses as I was working on my i2c patches.

* i2c-old.c contains old init stuff, obviously inherted from the times
of linux 2.2, which should be cleared. The BUZ and LML33 drivers are now
i2c drivers, not i2c-old ones.
* The Makefile needs a few adjustements.
* saa7146.h should include i2c-old.h, not i2c.h.

The thin part of this patch that also applies to linux 2.6 has been sent
to Greg KH.


diff -ruN linux-2.4.24-pre3/drivers/media/video/i2c-old.c linux-2.4.24-pre3-k3/drivers/media/video/i2c-old.c
--- linux-2.4.24-pre3/drivers/media/video/i2c-old.c	2001-09-30 21:26:06.000000000 +0200
+++ linux-2.4.24-pre3-k3/drivers/media/video/i2c-old.c	2004-01-06 14:01:45.000000000 +0100
@@ -36,28 +36,11 @@
 static struct i2c_driver *drivers[I2C_DRIVER_MAX];
 static int bus_count = 0, driver_count = 0;
 
-#ifdef CONFIG_VIDEO_BUZ
-extern int saa7111_init(void);
-extern int saa7185_init(void);
-#endif
-#ifdef CONFIG_VIDEO_LML33
-extern int bt819_init(void);
-extern int bt856_init(void);
-#endif
-
 int i2c_init(void)
 {
 	printk(KERN_INFO "i2c: initialized%s\n",
 		scan ? " (i2c bus scan enabled)" : "");
-	/* anything to do here ? */
-#ifdef CONFIG_VIDEO_BUZ
-	saa7111_init();
-	saa7185_init();
-#endif
-#ifdef CONFIG_VIDEO_LML33
-	bt819_init();
-	bt856_init();
-#endif
+
 	return 0;
 }
 
diff -ruN linux-2.4.24-pre3/drivers/media/video/Makefile linux-2.4.24-pre3-k3/drivers/media/video/Makefile
--- linux-2.4.24-pre3/drivers/media/video/Makefile	2003-12-31 14:51:01.000000000 +0100
+++ linux-2.4.24-pre3-k3/drivers/media/video/Makefile	2004-01-06 14:01:14.000000000 +0100
@@ -40,7 +40,7 @@
 
 obj-$(CONFIG_VIDEO_ZR36120) += zoran.o i2c-old.o
 obj-$(CONFIG_I2C_PARPORT) += i2c-parport.o i2c-old.o
-obj-$(CONFIG_VIDEO_SAA5249) += saa5249.o i2c-old.o
+obj-$(CONFIG_VIDEO_SAA5249) += saa5249.o
 obj-$(CONFIG_VIDEO_CQCAM) += c-qcam.o
 obj-$(CONFIG_VIDEO_BWQCAM) += bw-qcam.o
 obj-$(CONFIG_VIDEO_W9966) += w9966.o
@@ -48,11 +48,10 @@
 obj-$(CONFIG_VIDEO_ZORAN_BUZ) += saa7111.o saa7185.o
 obj-$(CONFIG_VIDEO_ZORAN_DC10) += saa7110.o adv7175.o
 obj-$(CONFIG_VIDEO_ZORAN_LML33) += bt819.o bt856.o
-obj-$(CONFIG_VIDEO_LML33) += bt856.o bt819.o
 obj-$(CONFIG_VIDEO_PMS) += pms.o
 obj-$(CONFIG_VIDEO_PLANB) += planb.o
 obj-$(CONFIG_VIDEO_VINO) += saa7191.o indycam.o vino.o
-obj-$(CONFIG_VIDEO_STRADIS) += stradis.o
+obj-$(CONFIG_VIDEO_STRADIS) += stradis.o i2c-old.o
 obj-$(CONFIG_VIDEO_CPIA) += cpia.o
 obj-$(CONFIG_VIDEO_CPIA_PP) += cpia_pp.o
 obj-$(CONFIG_VIDEO_CPIA_USB) += cpia_usb.o
@@ -81,8 +80,8 @@
 
 fastdep:
 
-zoran.o: zr36120.o zr36120_i2c.o zr36120_mem.o
-	$(LD) $(LD_RFLAG) -r -o $@ zr36120.o zr36120_i2c.o zr36120_mem.o
+zoran.o: $(zoran-objs)
+	$(LD) $(LD_RFLAG) -r -o $@ $(zoran-objs)
 
 bttv.o: $(bttv-objs)
 	$(LD) $(LD_RFLAG) -r -o $@ $(bttv-objs)
diff -ruN linux-2.4.24-pre3/drivers/media/video/saa7146.h linux-2.4.24-pre3-k3/drivers/media/video/saa7146.h
--- linux-2.4.24-pre3/drivers/media/video/saa7146.h	2000-12-11 22:15:51.000000000 +0100
+++ linux-2.4.24-pre3-k3/drivers/media/video/saa7146.h	2004-01-06 14:02:45.000000000 +0100
@@ -25,7 +25,7 @@
 #include <linux/types.h>
 #include <linux/wait.h>
 
-#include <linux/i2c.h>
+#include <linux/i2c-old.h>
 #include <linux/videodev.h>
 
 #ifndef O_NONCAP  

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
