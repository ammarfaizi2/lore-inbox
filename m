Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262164AbVATPdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbVATPdi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 10:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262167AbVATPdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 10:33:36 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:19364 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262166AbVATPaU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 10:30:20 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 20 Jan 2005 16:28:03 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: bttv update
Message-ID: <20050120152803.GA13056@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- some cleanups merged.
- use new tveeprom module to configure Hauppauge cards.
- add new tv cards.

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 drivers/media/video/Kconfig       |    1 
 drivers/media/video/btcx-risc.c   |    3 
 drivers/media/video/bttv-cards.c  |  203 +++++++++++++++---------------
 drivers/media/video/bttv-driver.c |   21 ++-
 drivers/media/video/bttv-i2c.c    |   23 ---
 drivers/media/video/bttv-if.c     |   14 +-
 drivers/media/video/bttv-risc.c   |    2 
 drivers/media/video/bttv-vbi.c    |    5 
 drivers/media/video/bttv.h        |    5 
 drivers/media/video/bttvp.h       |    8 -
 10 files changed, 147 insertions(+), 138 deletions(-)

Index: linux-2.6.10/drivers/media/video/bttv.h
===================================================================
--- linux-2.6.10.orig/drivers/media/video/bttv.h	2005-01-13 10:48:20.000000000 +0100
+++ linux-2.6.10/drivers/media/video/bttv.h	2005-01-19 14:12:59.139835175 +0100
@@ -1,5 +1,5 @@
 /*
- * $Id: bttv.h,v 1.10 2004/10/13 10:39:00 kraxel Exp $
+ * $Id: bttv.h,v 1.14 2005/01/07 13:11:19 kraxel Exp $
  *
  *  bttv - Bt848 frame grabber driver
  *
@@ -133,6 +133,7 @@
 #define BTTV_MATRIX_VISIONSLC 0x7e
 #define BTTV_APAC_VIEWCOMP  0x7f
 #define BTTV_DVICO_DVBT_LITE  0x80
+#define BTTV_TIBET_CS16  0x83
 
 /* i2c address list */
 #define I2C_TSA5522        0xc2
@@ -149,7 +150,7 @@
 #define I2C_VHX            0xc0
 #define I2C_MSP3400        0x80
 #define I2C_MSP3400_ALT    0x88
-#define I2C_TEA6300        0x80
+#define I2C_TEA6300        0x80 /* also used by 6320 */
 #define I2C_DPL3518	   0x84
 #define I2C_TDA9887	   0x86
 
Index: linux-2.6.10/drivers/media/video/bttvp.h
===================================================================
--- linux-2.6.10.orig/drivers/media/video/bttvp.h	2005-01-13 10:48:20.000000000 +0100
+++ linux-2.6.10/drivers/media/video/bttvp.h	2005-01-19 14:12:59.147833671 +0100
@@ -1,5 +1,5 @@
 /*
-    $Id: bttvp.h,v 1.12 2004/10/25 11:26:36 kraxel Exp $
+    $Id: bttvp.h,v 1.15 2004/12/14 15:33:30 kraxel Exp $
 
     bttv - Bt848 frame grabber driver
 
@@ -43,6 +43,7 @@
 #include <media/video-buf.h>
 #include <media/audiochip.h>
 #include <media/tuner.h>
+#include <media/tveeprom.h>
 #include <media/ir-common.h>
 
 #include "bt848.h"
@@ -224,11 +225,6 @@ extern unsigned int bttv_gpio;
 extern void bttv_gpio_tracking(struct bttv *btv, char *comment);
 extern int init_bttv_i2c(struct bttv *btv);
 extern int fini_bttv_i2c(struct bttv *btv);
-extern int pvr_boot(struct bttv *btv);
-
-extern int bttv_common_ioctls(struct bttv *btv, unsigned int cmd, void *arg);
-extern void bttv_reinit_bt848(struct bttv *btv);
-extern void bttv_field_count(struct bttv *btv);
 
 #define vprintk  if (bttv_verbose) printk
 #define dprintk  if (bttv_debug >= 1) printk
Index: linux-2.6.10/drivers/media/video/bttv-driver.c
===================================================================
--- linux-2.6.10.orig/drivers/media/video/bttv-driver.c	2005-01-13 10:48:20.000000000 +0100
+++ linux-2.6.10/drivers/media/video/bttv-driver.c	2005-01-19 14:12:59.168829724 +0100
@@ -1,5 +1,5 @@
 /*
-    $Id: bttv-driver.c,v 1.27 2004/11/07 14:44:59 kraxel Exp $
+    $Id: bttv-driver.c,v 1.34 2005/01/07 13:11:19 kraxel Exp $
 
     bttv - Bt848 frame grabber driver
 
@@ -27,6 +27,7 @@
 
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
@@ -105,6 +106,7 @@ module_param(adc_crush,         int, 044
 module_param(whitecrush_upper,  int, 0444);
 module_param(whitecrush_lower,  int, 0444);
 module_param(vcr_hack,          int, 0444);
+
 module_param_array(radio, int, NULL, 0444);
 
 MODULE_PARM_DESC(radio,"The TV card supports radio, default is 0 (no)");
@@ -1063,7 +1065,7 @@ static void init_bt848(struct bttv *btv)
 	init_irqreg(btv);
 }
 
-void bttv_reinit_bt848(struct bttv *btv)
+static void bttv_reinit_bt848(struct bttv *btv)
 {
 	unsigned long flags;
 
@@ -1267,7 +1269,7 @@ void bttv_gpio_tracking(struct bttv *btv
 	       btv->c.nr,outbits,data & outbits, data & ~outbits, comment);
 }
 
-void bttv_field_count(struct bttv *btv)
+static void bttv_field_count(struct bttv *btv)
 {
 	int need_count = 0;
 
@@ -1467,7 +1469,7 @@ static const char *v4l1_ioctls[] = {
 	"SMICROCODE", "GVBIFMT", "SVBIFMT" };
 #define V4L1_IOCTLS ARRAY_SIZE(v4l1_ioctls)
 
-int bttv_common_ioctls(struct bttv *btv, unsigned int cmd, void *arg)
+static int bttv_common_ioctls(struct bttv *btv, unsigned int cmd, void *arg)
 {
 	switch (cmd) {
         case BTTV_VERSION:
@@ -2531,9 +2533,11 @@ static int bttv_do_ioctl(struct inode *i
 			V4L2_CAP_VIDEO_CAPTURE |
 			V4L2_CAP_VIDEO_OVERLAY |
 			V4L2_CAP_VBI_CAPTURE |
-			V4L2_CAP_TUNER |
 			V4L2_CAP_READWRITE |
 			V4L2_CAP_STREAMING;
+		if (bttv_tvcards[btv->c.type].tuner != UNSET &&
+		    bttv_tvcards[btv->c.type].tuner != TUNER_ABSENT)
+			cap->capabilities |= V4L2_CAP_TUNER;
 		return 0;
 	}
 
@@ -2988,6 +2992,9 @@ static int bttv_release(struct inode *in
 		free_btres(btv,fh,RESOURCE_VBI);
 	}
 
+	/* free stuff */
+	videobuf_mmap_free(&fh->cap);
+	videobuf_mmap_free(&fh->vbi);
 	v4l2_prio_close(&btv->prio,&fh->prio);
 	file->private_data = NULL;
 	kfree(fh);
@@ -3717,8 +3724,8 @@ static int __devinit bttv_probe(struct p
 	/* initialize structs / fill in defaults */
         init_MUTEX(&btv->lock);
         init_MUTEX(&btv->reslock);
-        btv->s_lock    = SPIN_LOCK_UNLOCKED;
-        btv->gpio_lock = SPIN_LOCK_UNLOCKED;
+        spin_lock_init(&btv->s_lock);
+        spin_lock_init(&btv->gpio_lock);
         init_waitqueue_head(&btv->gpioq);
         init_waitqueue_head(&btv->i2c_queue);
         INIT_LIST_HEAD(&btv->c.subs);
Index: linux-2.6.10/drivers/media/video/bttv-cards.c
===================================================================
--- linux-2.6.10.orig/drivers/media/video/bttv-cards.c	2005-01-13 10:48:20.000000000 +0100
+++ linux-2.6.10/drivers/media/video/bttv-cards.c	2005-01-19 14:13:07.531257744 +0100
@@ -1,5 +1,5 @@
 /*
-    $Id: bttv-cards.c,v 1.32 2004/11/07 13:17:14 kraxel Exp $
+    $Id: bttv-cards.c,v 1.42 2005/01/13 17:22:33 kraxel Exp $
 
     bttv-cards.c
 
@@ -29,18 +29,19 @@
 #include <linux/config.h>
 #include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/kmod.h>
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/vmalloc.h>
-#if defined(CONFIG_FW_LOADER) || defined(CONFIG_FW_LOADER_MODULE)
-# include <linux/firmware.h>
-#endif
+#include <linux/firmware.h>
 
 #include <asm/io.h>
 
 #include "bttvp.h"
+#if 0 /* not working yet */
 #include "bt832.h"
+#endif
 
 /* fwd decl */
 static void boot_msp34xx(struct bttv *btv, int pin);
@@ -76,6 +77,9 @@ static void PXC200_muxsel(struct bttv *b
 static void picolo_tetra_muxsel(struct bttv *btv, unsigned int input);
 static void picolo_tetra_init(struct bttv *btv);
 
+static void tibetCS16_muxsel(struct bttv *btv, unsigned int input);
+static void tibetCS16_init(struct bttv *btv);
+
 static void sigmaSLC_muxsel(struct bttv *btv, unsigned int input);
 static void sigmaSQ_muxsel(struct bttv *btv, unsigned int input);
 
@@ -84,12 +88,13 @@ static int tea5757_read(struct bttv *btv
 static int tea5757_write(struct bttv *btv, int value);
 static void identify_by_eeprom(struct bttv *btv,
 			       unsigned char eeprom_data[256]);
+static int __devinit pvr_boot(struct bttv *btv);
 
 /* config variables */
 static unsigned int triton1=0;
 static unsigned int vsfx=0;
 static unsigned int latency = UNSET;
-unsigned int no_overlay=-1;
+static unsigned int no_overlay=-1;
 
 static unsigned int card[BTTV_MAX]   = { [ 0 ... (BTTV_MAX-1) ] = UNSET };
 static unsigned int pll[BTTV_MAX]    = { [ 0 ... (BTTV_MAX-1) ] = UNSET };
@@ -283,12 +288,12 @@ static struct CARD {
 
 	// DVB cards (using pci function .1 for mpeg data xfer)
 	{ 0x01010071, BTTV_NEBULA_DIGITV, "Nebula Electronics DigiTV" },
-	{ 0x07611461, BTTV_AVDVBT_761,    "AverMedia AverTV DVB-T" },
+	{ 0x07611461, BTTV_AVDVBT_761,    "AverMedia AverTV DVB-T 761" },
 	{ 0x001c11bd, BTTV_PINNACLESAT,   "Pinnacle PCTV Sat" },
 	{ 0x002611bd, BTTV_TWINHAN_DST,   "Pinnacle PCTV SAT CI" },
 	{ 0x00011822, BTTV_TWINHAN_DST,   "Twinhan VisionPlus DVB-T" },
 	{ 0xfc00270f, BTTV_TWINHAN_DST,   "ChainTech digitop DST-1000 DVB-S" },
-	{ 0x07711461, BTTV_AVDVBT_771,    "AVermedia DVB-T 771" },
+	{ 0x07711461, BTTV_AVDVBT_771,    "AVermedia AverTV DVB-T 771" },
 	{ 0xdb1018ac, BTTV_DVICO_DVBT_LITE,    "DVICO FusionHDTV DVB-T Lite" },
 
 	{ 0, -1, NULL }
@@ -2156,6 +2161,33 @@ struct tvcard bttv_tvcards[] = {
 	.tuner_type     = TUNER_PHILIPS_NTSC_M,
 	.has_radio      = 0,
 	// .has_remote     = 1,
+},{
+	/* Rick C <cryptdragoon@gmail.com> */
+        .name           = "Super TV Tuner",
+        .video_inputs   = 4,
+        .audio_inputs   = 1,
+        .tuner          = 0,
+        .svhs           = 2,
+        .muxsel         = { 2, 3, 1, 0},
+        .tuner_type     = TUNER_PHILIPS_NTSC,
+        .gpiomask       = 0x008007,
+        .audiomux       = { 0, 0x000001,0,0, 0},
+        .needs_tvaudio  = 1,
+        .has_radio      = 1,
+},{
+		/* Chris Fanning <video4linux@haydon.net> */
+		.name           = "Tibet Systems 'Progress DVR' CS16",
+		.video_inputs   = 16,
+		.audio_inputs   = 0,
+		.tuner          = -1,
+		.svhs           = -1,
+		.muxsel         = { 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 },
+		.pll		= PLL_28,
+		.no_msp34xx     = 1,
+		.no_tda9875     = 1,
+		.no_tda7432	= 1,
+		.tuner_type     = -1,
+		.muxsel_hook    = tibetCS16_muxsel,
 }};
 
 static const unsigned int bttv_num_tvcards = ARRAY_SIZE(bttv_tvcards);
@@ -2499,7 +2531,7 @@ static void sigmaSLC_muxsel(struct bttv 
 
 /* ----------------------------------------------------------------------- */
 
-void bttv_reset_audio(struct bttv *btv)
+static void bttv_reset_audio(struct bttv *btv)
 {
 	/*
 	 * BT878A has a audio-reset register.
@@ -2542,6 +2574,8 @@ void __devinit bttv_init_card1(struct bt
 		btv->use_i2c_hw = 1;
 		break;
 	}
+	if (!bttv_tvcards[btv->c.type].has_dvb)
+		bttv_reset_audio(btv);
 }
 
 /* initialization part two -- after registering i2c bus */
@@ -2645,6 +2679,9 @@ void __devinit bttv_init_card2(struct bt
 	case BTTV_LMLBT4:
 		init_lmlbt4x(btv);
 		break;
+	case BTTV_TIBET_CS16:
+		tibetCS16_init(btv);
+		break;
 	}
 
 	/* pll configuration */
@@ -2681,6 +2718,8 @@ void __devinit bttv_init_card2(struct bt
         }
 	btv->pll.pll_current = -1;
 
+	bttv_reset_audio(btv);
+
 	/* tuner configuration (from card list / autodetect / insmod option) */
  	if (UNSET != bttv_tvcards[btv->c.type].tuner_type)
 		if(UNSET == btv->tuner_type)
@@ -2745,7 +2784,10 @@ void __devinit bttv_init_card2(struct bt
 	if (0 == tda9887 && 0 == bttv_tvcards[btv->c.type].has_dvb &&
 	    bttv_I2CRead(btv, I2C_TDA9887, "TDA9887") >=0)
 		tda9887 = 1;
-	if (tda9887)
+	if((btv->tuner_type == TUNER_PHILIPS_FM1216ME_MK3) || 
+	   (btv->tuner_type == TUNER_PHILIPS_FM1236_MK3) ||
+	   (btv->tuner_type == TUNER_PHILIPS_FM1256_IH3) ||
+	    tda9887)
 		request_module("tda9887");
 	if (btv->tuner_type != UNSET)
 		request_module("tuner");
@@ -2753,67 +2795,6 @@ void __devinit bttv_init_card2(struct bt
 
 
 /* ----------------------------------------------------------------------- */
-/* some hauppauge specific stuff                                           */
-
-static struct HAUPPAUGE_TUNER
-{
-        int  id;
-        char *name;
-}
-hauppauge_tuner[] __devinitdata =
-{
-        { TUNER_ABSENT,        "" },
-        { TUNER_ABSENT,        "External" },
-        { TUNER_ABSENT,        "Unspecified" },
-        { TUNER_PHILIPS_PAL,   "Philips FI1216" },
-        { TUNER_PHILIPS_SECAM, "Philips FI1216MF" },
-        { TUNER_PHILIPS_NTSC,  "Philips FI1236" },
-        { TUNER_PHILIPS_PAL_I, "Philips FI1246" },
-        { TUNER_PHILIPS_PAL_DK,"Philips FI1256" },
-        { TUNER_PHILIPS_PAL,   "Philips FI1216 MK2" },
-        { TUNER_PHILIPS_SECAM, "Philips FI1216MF MK2" },
-        { TUNER_PHILIPS_NTSC,  "Philips FI1236 MK2" },
-        { TUNER_PHILIPS_PAL_I, "Philips FI1246 MK2" },
-        { TUNER_PHILIPS_PAL_DK,"Philips FI1256 MK2" },
-        { TUNER_TEMIC_NTSC,    "Temic 4032FY5" },
-        { TUNER_TEMIC_PAL,     "Temic 4002FH5" },
-        { TUNER_TEMIC_PAL_I,   "Temic 4062FY5" },
-        { TUNER_PHILIPS_PAL,   "Philips FR1216 MK2" },
-        { TUNER_PHILIPS_SECAM, "Philips FR1216MF MK2" },
-        { TUNER_PHILIPS_NTSC,  "Philips FR1236 MK2" },
-        { TUNER_PHILIPS_PAL_I, "Philips FR1246 MK2" },
-        { TUNER_PHILIPS_PAL_DK,"Philips FR1256 MK2" },
-        { TUNER_PHILIPS_PAL,   "Philips FM1216" },
-        { TUNER_PHILIPS_SECAM, "Philips FM1216MF" },
-        { TUNER_PHILIPS_NTSC,  "Philips FM1236" },
-        { TUNER_PHILIPS_PAL_I, "Philips FM1246" },
-        { TUNER_PHILIPS_PAL_DK,"Philips FM1256" },
-        { TUNER_TEMIC_4036FY5_NTSC, "Temic 4036FY5" },
-        { TUNER_ABSENT,        "Samsung TCPN9082D" },
-        { TUNER_ABSENT,        "Samsung TCPM9092P" },
-        { TUNER_TEMIC_4006FH5_PAL, "Temic 4006FH5" },
-        { TUNER_ABSENT,        "Samsung TCPN9085D" },
-        { TUNER_ABSENT,        "Samsung TCPB9085P" },
-        { TUNER_ABSENT,        "Samsung TCPL9091P" },
-        { TUNER_TEMIC_4039FR5_NTSC, "Temic 4039FR5" },
-        { TUNER_PHILIPS_FQ1216ME,   "Philips FQ1216 ME" },
-        { TUNER_TEMIC_4066FY5_PAL_I, "Temic 4066FY5" },
-        { TUNER_PHILIPS_NTSC,        "Philips TD1536" },
-        { TUNER_PHILIPS_NTSC,        "Philips TD1536D" },
-	{ TUNER_PHILIPS_NTSC,  "Philips FMR1236" }, /* mono radio */
-        { TUNER_ABSENT,        "Philips FI1256MP" },
-        { TUNER_ABSENT,        "Samsung TCPQ9091P" },
-        { TUNER_TEMIC_4006FN5_MULTI_PAL, "Temic 4006FN5" },
-        { TUNER_TEMIC_4009FR5_PAL, "Temic 4009FR5" },
-        { TUNER_TEMIC_4046FM5,     "Temic 4046FM5" },
-	{ TUNER_TEMIC_4009FN5_MULTI_PAL_FM, "Temic 4009FN5" },
-	{ TUNER_ABSENT,        "Philips TD1536D_FH_44"},
-	{ TUNER_LG_NTSC_FM,    "LG TPI8NSR01F"},
-	{ TUNER_LG_PAL_FM,     "LG TPI8PSB01D"},
-	{ TUNER_LG_PAL,        "LG TPI8PSB11D"},
-	{ TUNER_LG_PAL_I_FM,   "LG TAPC-I001D"},
-	{ TUNER_LG_PAL_I,      "LG TAPC-I701D"}
-};
 
 static void modtec_eeprom(struct bttv *btv)
 {
@@ -2837,31 +2818,11 @@ static void modtec_eeprom(struct bttv *b
 
 static void __devinit hauppauge_eeprom(struct bttv *btv)
 {
-	unsigned int blk2,tuner,radio,model;
+	struct tveeprom tv;
 
-	if (eeprom_data[0] != 0x84 || eeprom_data[2] != 0)
-		printk(KERN_WARNING "bttv%d: Hauppauge eeprom: invalid\n",
-		       btv->c.nr);
-
-	/* Block 2 starts after len+3 bytes header */
-	blk2 = eeprom_data[1] + 3;
-
-	/* decode + use some config infos */
-	model = eeprom_data[12] << 8 | eeprom_data[11];
-	tuner = eeprom_data[9];
-	radio = eeprom_data[blk2-1] & 0x01;
-
-        if (tuner < ARRAY_SIZE(hauppauge_tuner))
-                btv->tuner_type = hauppauge_tuner[tuner].id;
-	if (radio)
-		btv->has_radio = 1;
-
-	if (bttv_verbose)
-		printk(KERN_INFO "bttv%d: Hauppauge eeprom: model=%d, "
-		       "tuner=%s (%d), radio=%s\n",
-		       btv->c.nr, model, (tuner < ARRAY_SIZE(hauppauge_tuner)
-					  ? hauppauge_tuner[tuner].name : "?"),
-		       btv->tuner_type, radio ? "yes" : "no");
+	tveeprom_hauppauge_analog(&tv, eeprom_data);
+	btv->tuner_type = tv.tuner_type;
+	btv->has_radio  = tv.has_radio;
 }
 
 static int terratec_active_radio_upgrade(struct bttv *btv)
@@ -2947,7 +2908,7 @@ static int __devinit pvr_altera_load(str
 	return 0;
 }
 
-int __devinit pvr_boot(struct bttv *btv)
+static int __devinit pvr_boot(struct bttv *btv)
 {
         const struct firmware *fw_entry;
 	int rc;
@@ -3077,7 +3038,8 @@ static int tuner_0_table[] = {
         TUNER_PHILIPS_PAL,   TUNER_PHILIPS_PAL /* PAL-I*/,
         TUNER_PHILIPS_PAL,   TUNER_PHILIPS_PAL,
         TUNER_PHILIPS_SECAM, TUNER_PHILIPS_SECAM,
-        TUNER_PHILIPS_SECAM, TUNER_PHILIPS_PAL};
+        TUNER_PHILIPS_SECAM, TUNER_PHILIPS_PAL,
+	TUNER_PHILIPS_FM1216ME_MK3 };
 #if 0
 int tuner_0_fm_table[] = {
         PHILIPS_FR1236_NTSC,  PHILIPS_FR1216_PAL,
@@ -3104,12 +3066,16 @@ static void __devinit avermedia_eeprom(s
 	btv->has_remote = (eeprom_data[0x42] & 0x01);
 
 	if (tuner_make == 0 || tuner_make == 2)
-		if(tuner_format <=9)
+		if(tuner_format <=0x0a)
 			tuner = tuner_0_table[tuner_format];
 	if (tuner_make == 1)
 		if(tuner_format <=9)
 			tuner = tuner_1_table[tuner_format];
 
+	if (tuner_make == 4)
+		if(tuner_format == 0x09)
+			tuner = TUNER_LG_NTSC_NEW_TAPC; // TAPC-G702P
+
 	printk(KERN_INFO "bttv%d: Avermedia eeprom[0x%02x%02x]: tuner=",
 		btv->c.nr,eeprom_data[0x41],eeprom_data[0x42]);
 	if(tuner) {
@@ -3167,6 +3133,7 @@ static void __devinit boot_msp34xx(struc
 
 static void __devinit boot_bt832(struct bttv *btv)
 {
+#if 0 /* not working yet */
 	int resetbit=0;
 
 	switch (btv->c.type) {
@@ -3195,6 +3162,7 @@ static void __devinit boot_bt832(struct 
 	// bt832 on pixelview changes from i2c 0x8a to 0x88 after
 	// being reset as above. So we must follow by this:
 	bttv_call_i2c_clients(btv, BT832_REATTACH, NULL);
+#endif
 }
 
 /* ----------------------------------------------------------------------- */
@@ -3885,6 +3853,47 @@ static void rv605_muxsel(struct bttv *bt
 	mdelay(1);
 }
 
+/* Tibet Systems 'Progress DVR' CS16 muxsel helper [Chris Fanning]
+ *
+ * The CS16 (available on eBay cheap) is a PCI board with four Fusion
+ * 878A chips, a PCI bridge, an Atmel microcontroller, four sync seperator
+ * chips, ten eight input analog multiplexors, a not chip and a few
+ * other components.
+ *
+ * 16 inputs on a secondary bracket are provided and can be selected
+ * from each of the four capture chips.  Two of the eight input
+ * multiplexors are used to select from any of the 16 input signals.
+ *
+ * Unsupported hardware capabilities:
+ *  . A video output monitor on the secondary bracket can be selected from
+ *    one of the 878A chips.
+ *  . Another passthrough but I haven't spent any time investigating it.
+ *  . Digital I/O (logic level connected to GPIO) is available from an
+ *    onboard header.
+ *
+ * The on chip input mux should always be set to 2.
+ * GPIO[16:19] - Video input selection
+ * GPIO[0:3]   - Video output monitor select (only available from one 878A)
+ * GPIO[?:?]   - Digital I/O.
+ *
+ * There is an ATMEL microcontroller with an 8031 core on board.  I have not
+ * determined what function (if any) it provides.  With the microcontroller
+ * and sync seperator chips a guess is that it might have to do with video
+ * switching and maybe some digital I/O.
+ */
+static void tibetCS16_muxsel(struct bttv *btv, unsigned int input)
+{
+	/* video mux */
+	gpio_bits(0x0f0000, input << 16);
+}
+
+static void tibetCS16_init(struct bttv *btv)
+{
+	/* enable gpio bits, mask obtained via btSpy */
+	gpio_inout(0xffffff, 0x0f7fff);
+	gpio_write(0x0f7fff);
+}
+
 // The Grandtec X-Guard framegrabber card uses two Dual 4-channel
 // video multiplexers to provide up to 16 video inputs. These
 // multiplexers are controlled by the lower 8 GPIO pins of the
Index: linux-2.6.10/drivers/media/video/bttv-if.c
===================================================================
--- linux-2.6.10.orig/drivers/media/video/bttv-if.c	2004-12-29 23:55:18.000000000 +0100
+++ linux-2.6.10/drivers/media/video/bttv-if.c	2005-01-19 14:12:59.198824086 +0100
@@ -1,5 +1,5 @@
 /*
-    $Id: bttv-if.c,v 1.3 2004/10/13 10:39:00 kraxel Exp $
+    $Id: bttv-if.c,v 1.4 2004/11/17 18:47:47 kraxel Exp $
 
     bttv-if.c  --  old gpio interface to other kernel modules
                    don't use in new code, will go away in 2.7
@@ -50,6 +50,8 @@ EXPORT_SYMBOL(bttv_i2c_call);
 
 int bttv_get_cardinfo(unsigned int card, int *type, unsigned *cardid)
 {
+	printk("The bttv_* interface is obsolete and will go away,\n"
+	       "please use the new, sysfs based interface instead.\n");
 	if (card >= bttv_num) {
 		return -1;
 	}
@@ -67,7 +69,8 @@ struct pci_dev* bttv_get_pcidev(unsigned
 
 int bttv_get_id(unsigned int card)
 {
-	printk("bttv_get_id is obsolete, use bttv_get_cardinfo instead\n");
+	printk("The bttv_* interface is obsolete and will go away,\n"
+	       "please use the new, sysfs based interface instead.\n");
 	if (card >= bttv_num) {
 		return -1;
 	}
@@ -143,6 +146,13 @@ wait_queue_head_t* bttv_get_gpio_queue(u
 	return &btv->gpioq;
 }
 
+void bttv_i2c_call(unsigned int card, unsigned int cmd, void *arg)
+{
+	if (card >= bttv_num)
+		return;
+	bttv_call_i2c_clients(&bttvs[card], cmd, arg);
+}
+
 /*
  * Local variables:
  * c-basic-offset: 8
Index: linux-2.6.10/drivers/media/video/bttv-risc.c
===================================================================
--- linux-2.6.10.orig/drivers/media/video/bttv-risc.c	2005-01-13 10:48:20.000000000 +0100
+++ linux-2.6.10/drivers/media/video/bttv-risc.c	2005-01-19 14:12:59.198824086 +0100
@@ -1,5 +1,5 @@
 /*
-    $Id: bttv-risc.c,v 1.9 2004/10/13 10:39:00 kraxel Exp $
+    $Id: bttv-risc.c,v 1.10 2004/11/19 18:07:12 kraxel Exp $
 
     bttv-risc.c  --  interfaces to other kernel modules
 
Index: linux-2.6.10/drivers/media/video/bttv-i2c.c
===================================================================
--- linux-2.6.10.orig/drivers/media/video/bttv-i2c.c	2005-01-13 10:48:20.000000000 +0100
+++ linux-2.6.10/drivers/media/video/bttv-i2c.c	2005-01-19 14:12:59.205822770 +0100
@@ -1,5 +1,5 @@
 /*
-    $Id: bttv-i2c.c,v 1.13 2004/11/07 13:17:15 kraxel Exp $
+    $Id: bttv-i2c.c,v 1.17 2004/12/14 15:33:30 kraxel Exp $
 
     bttv-i2c.c  --  all the i2c code is here
 
@@ -26,6 +26,7 @@
 */
 
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <asm/io.h>
@@ -327,13 +328,6 @@ void bttv_call_i2c_clients(struct bttv *
 	i2c_clients_command(&btv->c.i2c_adap, cmd, arg);
 }
 
-void bttv_i2c_call(unsigned int card, unsigned int cmd, void *arg)
-{
-	if (card >= bttv_num)
-		return;
-	bttv_call_i2c_clients(&bttvs[card], cmd, arg);
-}
-
 static struct i2c_client bttv_i2c_client_template = {
 	I2C_DEVNAME("bttv internal"),
         .id       = -1,
@@ -385,19 +379,8 @@ int bttv_I2CWrite(struct bttv *btv, unsi
 /* read EEPROM content */
 void __devinit bttv_readee(struct bttv *btv, unsigned char *eedata, int addr)
 {
-	int i;
-
-	if (bttv_I2CWrite(btv, addr, 0, -1, 0)<0) {
-		printk(KERN_WARNING "bttv: readee error\n");
-		return;
-	}
 	btv->i2c_client.addr = addr >> 1;
-	for (i=0; i<256; i+=16) {
-		if (16 != i2c_master_recv(&btv->i2c_client,eedata+i,16)) {
-			printk(KERN_WARNING "bttv: readee error\n");
-			break;
-		}
-	}
+	tveeprom_read(&btv->i2c_client, eedata, 256);
 }
 
 static char *i2c_devs[128] = {
Index: linux-2.6.10/drivers/media/video/bttv-vbi.c
===================================================================
--- linux-2.6.10.orig/drivers/media/video/bttv-vbi.c	2004-12-29 23:57:38.000000000 +0100
+++ linux-2.6.10/drivers/media/video/bttv-vbi.c	2005-01-19 14:13:07.531257744 +0100
@@ -1,5 +1,5 @@
 /*
-    $Id: bttv-vbi.c,v 1.7 2004/11/07 13:17:15 kraxel Exp $
+    $Id: bttv-vbi.c,v 1.9 2005/01/13 17:22:33 kraxel Exp $
 
     bttv - Bt848 frame grabber driver
     vbi interface
@@ -22,6 +22,7 @@
 */
 
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/kernel.h>
@@ -182,7 +183,7 @@ void bttv_vbi_try_fmt(struct bttv_fh *fh
 	case 2: /* SECAM */
 	default:
 		start0 = 7;
-		start1 = 319;
+		start1 = 320;
 	}
 
 	count0 = (f->fmt.vbi.start[0] + f->fmt.vbi.count[0]) - start0;
Index: linux-2.6.10/drivers/media/video/btcx-risc.c
===================================================================
--- linux-2.6.10.orig/drivers/media/video/btcx-risc.c	2004-12-29 23:54:44.000000000 +0100
+++ linux-2.6.10/drivers/media/video/btcx-risc.c	2005-01-19 14:12:59.216820703 +0100
@@ -1,5 +1,5 @@
 /*
-    $Id: btcx-risc.c,v 1.4 2004/11/07 13:17:14 kraxel Exp $
+    $Id: btcx-risc.c,v 1.5 2004/12/10 12:33:39 kraxel Exp $
 
     btcx-risc.c
 
@@ -24,6 +24,7 @@
 */
 
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/interrupt.h>
Index: linux-2.6.10/drivers/media/video/Kconfig
===================================================================
--- linux-2.6.10.orig/drivers/media/video/Kconfig	2004-12-29 23:58:54.000000000 +0100
+++ linux-2.6.10/drivers/media/video/Kconfig	2005-01-19 14:12:59.220819951 +0100
@@ -16,6 +16,7 @@ config VIDEO_BT848
 	select VIDEO_BUF
 	select VIDEO_IR
 	select VIDEO_TUNER
+	select VIDEO_TVEEPROM
 	---help---
 	  Support for BT848 based frame grabber/overlay boards. This includes
 	  the Miro, Hauppauge and STB boards. Please read the material in

-- 
#define printk(args...) fprintf(stderr, ## args)
