Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbVFJRdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVFJRdJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 13:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbVFJRdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 13:33:09 -0400
Received: from smtp2.brturbo.com.br ([200.199.201.158]:968 "EHLO
	smtp2.brturbo.com.br") by vger.kernel.org with ESMTP
	id S261153AbVFJRbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 13:31:51 -0400
Message-ID: <42A9CE83.807@brturbo.com.br>
Date: Fri, 10 Jun 2005 14:31:47 -0300
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: pt-br, pt, es, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux and Kernel Video <video4linux-list@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] bttv synchronizing patch
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------050901070106040207050001"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050901070106040207050001
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

This patch synchronizes current bttv support on V4L with linux kernel
and adds support to Adlink RTV24 card.

    It is asked that *every* patch to V4L stuff to be first submitted to
video4linux-list@redhat.com.

Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Signed-off-by: Peter Skipworth <pskipworth@clarityvi.com>
Signed-off-by: Nickolay V Shmyrev <nshmyrev@yandex.ru>



--------------050901070106040207050001
Content-Type: text/x-patch;
 name="bttv_synchronize.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bttv_synchronize.patch"

diff -u linux-2.6.12/drivers/media/video/bttv.h linux/drivers/media/video/bttv.h
--- linux-2.6.12/drivers/media/video/bttv.h	2005-06-07 15:39:55.000000000 -0300
+++ linux/drivers/media/video/bttv.h	2005-06-10 14:21:25.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: bttv.h,v 1.17 2005/02/22 14:06:32 kraxel Exp $
+ * $Id: bttv.h,v 1.18 2005/05/24 23:41:42 nsh Exp $
  *
  *  bttv - Bt848 frame grabber driver
  *
@@ -135,7 +135,7 @@
 #define BTTV_DVICO_DVBT_LITE  0x80
 #define BTTV_TIBET_CS16  0x83
 #define BTTV_KODICOM_4400R  0x84
-#define BTTV_ADLINK_RTV24   0x86
+#define BTTV_ADLINK_RTV24   0x85
 
 /* i2c address list */
 #define I2C_TSA5522        0xc2
diff -u linux-2.6.12/drivers/media/video/bttvp.h linux/drivers/media/video/bttvp.h
--- linux-2.6.12/drivers/media/video/bttvp.h	2005-06-07 15:38:09.000000000 -0300
+++ linux/drivers/media/video/bttvp.h	2005-06-10 14:21:25.000000000 -0300
@@ -229,6 +229,7 @@
 /* our devices */
 #define BTTV_MAX 16
 extern unsigned int bttv_num;
+extern struct bttv bttvs[BTTV_MAX];
 
 #define BTTV_MAX_FBUF   0x208000
 #define VBIBUF_SIZE     (2048*VBI_MAXLINES*2)
@@ -375,7 +376,6 @@
 	unsigned int users;
 	struct bttv_fh init;
 };
-extern struct bttv bttvs[BTTV_MAX];
 
 /* private ioctls */
 #define BTTV_VERSION            _IOR('v' , BASE_VIDIOCPRIVATE+6, int)
diff -u linux-2.6.12/drivers/media/video/bttv-driver.c linux/drivers/media/video/bttv-driver.c
--- linux-2.6.12/drivers/media/video/bttv-driver.c	2005-06-07 15:38:09.000000000 -0300
+++ linux/drivers/media/video/bttv-driver.c	2005-06-10 14:21:25.000000000 -0300
@@ -1,5 +1,5 @@
 /*
-    $Id: bttv-driver.c,v 1.37 2005/02/21 13:57:59 kraxel Exp $
+    $Id: bttv-driver.c,v 1.38 2005/06/10 17:20:24 mchehab Exp $
 
     bttv - Bt848 frame grabber driver
 
diff -u linux-2.6.12/drivers/media/video/bttv-cards.c linux/drivers/media/video/bttv-cards.c
--- linux-2.6.12/drivers/media/video/bttv-cards.c	2005-06-07 15:39:55.000000000 -0300
+++ linux/drivers/media/video/bttv-cards.c	2005-06-10 14:21:25.000000000 -0300
@@ -1,5 +1,5 @@
 /*
-    $Id: bttv-cards.c,v 1.47 2005/02/22 14:06:32 kraxel Exp $
+    $Id: bttv-cards.c,v 1.49 2005/06/10 17:20:24 mchehab Exp $
 
     bttv-cards.c
 
@@ -2254,17 +2254,18 @@
 	.muxsel_hook	= kodicom4400r_muxsel,
 },
 {
-	/* ---- card 0x86---------------------------------- */
-	/* Michael Henson <mhenson@clarityvi.com> */
-	/* Adlink RTV24 with special unlock codes */
-	.name           = "Adlink RTV24",
-	.video_inputs   = 4,
-	.audio_inputs   = 1,
-	.tuner          = 0,
-	.svhs           = 2,
-	.muxsel         = { 2, 3, 1, 0},
-	.tuner_type     = -1,
-	.pll            = PLL_28,
+        /* ---- card 0x85---------------------------------- */
+        /* Michael Henson <mhenson@clarityvi.com> */
+        /* Adlink RTV24 with special unlock codes */
+        .name           = "Adlink RTV24",
+        .video_inputs   = 4,
+        .audio_inputs   = 1,
+        .tuner          = 0,
+        .svhs           = 2,
+        .muxsel         = { 2, 3, 1, 0},
+        .tuner_type     = -1,
+        .pll            = PLL_28,
+ 
 }};
 
 static const unsigned int bttv_num_tvcards = ARRAY_SIZE(bttv_tvcards);
@@ -2650,6 +2651,10 @@
 	case BTTV_AVDVBT_771:
 		btv->use_i2c_hw = 1;
 		break;
+        case BTTV_ADLINK_RTV24:
+                init_RTV24( btv );
+                break;
+
 	}
 	if (!bttv_tvcards[btv->c.type].has_dvb)
 		bttv_reset_audio(btv);
@@ -2762,9 +2767,6 @@
 	case BTTV_KODICOM_4400R:
 		kodicom4400r_init(btv);
 		break;
-        case BTTV_ADLINK_RTV24:
-                init_RTV24(btv);
-                break;
 	}
 
 	/* pll configuration */
@@ -2801,6 +2803,8 @@
         }
 	btv->pll.pll_current = -1;
 
+	bttv_reset_audio(btv);
+
 	/* tuner configuration (from card list / autodetect / insmod option) */
  	if (UNSET != bttv_tvcards[btv->c.type].tuner_type)
 		if(UNSET == btv->tuner_type)
@@ -3320,6 +3324,8 @@
 	printk(KERN_INFO "PXC200 Initialised.\n");
 }
 
+
+
 /* ----------------------------------------------------------------------- */
 /*
  *  The Adlink RTV-24 (aka Angelo) has some special initialisation to unlock
@@ -3348,49 +3354,54 @@
  *                error. ERROR_CPLD_Check_Failed.
  */
 /* ----------------------------------------------------------------------- */
-void init_RTV24(struct bttv *btv)
+void
+init_RTV24 (struct bttv *btv)
 {
-	u32 dataread;
-	const long watchdog_value = 0x0E;
+	uint32_t dataRead = 0;
+	long watchdog_value = 0x0E;
 
-	printk(KERN_INFO "bttv%d: Adlink RTV-24 initialisation in progress\n",
+	printk (KERN_INFO
+		"bttv%d: Adlink RTV-24 initialisation in progress ...\n",
 		btv->c.nr);
 
-	btwrite(0x00c3feff, BT848_GPIO_OUT_EN);
+	btwrite (0x00c3feff, BT848_GPIO_OUT_EN);
+
+	btwrite (0 + watchdog_value, BT848_GPIO_DATA);
+	msleep (1);
+	btwrite (0x10 + watchdog_value, BT848_GPIO_DATA);
+	msleep (10);
+	btwrite (0 + watchdog_value, BT848_GPIO_DATA);
+
+	dataRead = btread (BT848_GPIO_DATA);
+
+	if ((((dataRead >> 18) & 0x01) != 0) || (((dataRead >> 19) & 0x01) != 1)) {
+		printk (KERN_INFO
+			"bttv%d: Adlink RTV-24 initialisation(1) ERROR_CPLD_Check_Failed (read %d)\n",
+			btv->c.nr, dataRead);
+	}
+
+	btwrite (0x4400 + watchdog_value, BT848_GPIO_DATA);
+	msleep (10);
+	btwrite (0x4410 + watchdog_value, BT848_GPIO_DATA);
+	msleep (1);
+	btwrite (watchdog_value, BT848_GPIO_DATA);
+	msleep (1);
+	dataRead = btread (BT848_GPIO_DATA);
+
+	if ((((dataRead >> 18) & 0x01) != 0) || (((dataRead >> 19) & 0x01) != 0)) {
+		printk (KERN_INFO
+			"bttv%d: Adlink RTV-24 initialisation(2) ERROR_CPLD_Check_Failed (read %d)\n",
+			btv->c.nr, dataRead);
 
-	btwrite(0 + watchdog_value, BT848_GPIO_DATA);
-	msleep(1);
-	btwrite(0x10 + watchdog_value, BT848_GPIO_DATA);
-	msleep( 10 );
-	btwrite(0 + watchdog_value, BT848_GPIO_DATA);
-
-	dataread = btread(BT848_GPIO_DATA);
-
-	if (((dataread >> 18) & 0x01) != 0 || ((dataread >> 19) & 0x01) != 1) {
-		printk(KERN_INFO "bttv%d: Adlink RTV-24 initialisation(1) "
-				"ERROR_CPLD_Check_Failed (read %d)\n",
-				btv->c.nr, dataread);
-	}
-
-	btwrite(0x4400 + watchdog_value, BT848_GPIO_DATA);
-	msleep(10);
-	btwrite(0x4410 + watchdog_value, BT848_GPIO_DATA);
-	msleep(1);
-	btwrite(watchdog_value, BT848_GPIO_DATA);
-	msleep(1);
-	dataread = btread(BT848_GPIO_DATA);
-
-	if (((dataread >> 18) & 0x01) != 0 || ((dataread >> 19) & 0x01) != 0) {
-		printk(KERN_INFO "bttv%d: Adlink RTV-24 initialisation(2) "
-				"ERROR_CPLD_Check_Failed (read %d)\n",
-				btv->c.nr, dataread);
 		return;
 	}
 
-	printk(KERN_INFO "bttv%d: Adlink RTV-24 initialisation complete.\n",
-			btv->c.nr);
+	printk (KERN_INFO
+		"bttv%d: Adlink RTV-24 initialisation complete.\n", btv->c.nr);
 }
 
+
+
 /* ----------------------------------------------------------------------- */
 /* Miro Pro radio stuff -- the tea5757 is connected to some GPIO ports     */
 /*
@@ -4079,7 +4090,7 @@
 			       unsigned char yaddr,
 			       unsigned char data) {
 	unsigned int udata;
-
+	
 	udata = (data << 7) | ((yaddr&3) << 4) | (xaddr&0xf);
 	gpio_bits(0x1ff, udata);		/* write ADDR and DAT */
 	gpio_bits(0x1ff, udata | (1 << 8));	/* strobe high */
@@ -4100,7 +4111,7 @@
 	int xaddr, yaddr;
 	struct bttv *mctlr;
 	static unsigned char map[4] = {3, 0, 2, 1};
-
+	
 	mctlr = master[btv->c.nr];
 	if (mctlr == NULL) {	/* ignore if master not yet detected */
 		return;
diff -u linux-2.6.12/drivers/media/video/bttv-i2c.c linux/drivers/media/video/bttv-i2c.c
--- linux-2.6.12/drivers/media/video/bttv-i2c.c	2005-06-07 15:38:09.000000000 -0300
+++ linux/drivers/media/video/bttv-i2c.c	2005-06-10 14:21:25.000000000 -0300
@@ -1,5 +1,5 @@
 /*
-    $Id: bttv-i2c.c,v 1.18 2005/02/16 12:14:10 kraxel Exp $
+    $Id: bttv-i2c.c,v 1.21 2005/06/10 17:20:24 mchehab Exp $
 
     bttv-i2c.c  --  all the i2c code is here
 

--------------050901070106040207050001--
