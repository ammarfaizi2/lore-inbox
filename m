Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268766AbUHaPng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268766AbUHaPng (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 11:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268775AbUHaPnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 11:43:35 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:33238 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S268766AbUHaPmr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 11:42:47 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 31 Aug 2004 17:19:42 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch 2/4] v4l: i2c tuner modules update
Message-ID: <20040831151942.GA15624@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch updates the tuner and tda9887 i2c modules which handle the tv
card tuning.  Changes:

  * some cleanups (don't ignore i2c_add_driver return value, add __init
    and __exit).
  * add support for new tuners.
  * allow to pass configuration info (tv card specific stuff) to the
    tda9887 module.

please apply,

  Gerd

diff -up linux-2.6.9-rc1/drivers/media/video/tda9887.c linux/drivers/media/video/tda9887.c
--- linux-2.6.9-rc1/drivers/media/video/tda9887.c	2004-08-25 16:10:49.000000000 +0200
+++ linux/drivers/media/video/tda9887.c	2004-08-25 18:20:58.098517940 +0200
@@ -8,6 +8,7 @@
 #include <linux/slab.h>
 
 #include <media/audiochip.h>
+#include <media/tuner.h>
 #include <media/id.h>
 
 /* Chips:
@@ -47,6 +48,7 @@ struct tda9887 {
 	struct i2c_client  client;
 	v4l2_std_id        std;
 	unsigned int       radio;
+	unsigned int       config;
 	unsigned int       pinnacle_id;
 	unsigned int       using_v4l2;
 };
@@ -391,12 +393,42 @@ static int tda9887_set_insmod(struct tda
 		else
 			buf[1] &= ~cQSS;
 	}
-
+	
 	if (adjust >= 0x00 && adjust < 0x20)
 		buf[2] |= adjust;
 	return 0;
 }
 
+static int tda9887_set_config(struct tda9887 *t, char *buf)
+{
+	if (t->config & TDA9887_PORT1)
+		buf[1] |= cOutputPort1Inactive;
+	if (t->config & TDA9887_PORT2)
+		buf[1] |= cOutputPort2Inactive;
+	if (t->config & TDA9887_QSS)
+		buf[1] |= cQSS;
+	if (t->config & TDA9887_INTERCARRIER)
+		buf[1] &= ~cQSS;
+
+	if (t->config & TDA9887_AUTOMUTE)
+		buf[1] |= cAutoMuteFmActive;
+	if (t->config & TDA9887_DEEMPHASIS_MASK) {
+		buf[2] &= ~0x60;
+		switch (t->config & TDA9887_DEEMPHASIS_MASK) {
+		case TDA9887_DEEMPHASIS_NONE:
+			buf[2] |= cDeemphasisOFF;
+			break;
+		case TDA9887_DEEMPHASIS_50:
+			buf[2] |= cDeemphasisON | cDeemphasis50;
+			break;
+		case TDA9887_DEEMPHASIS_75:
+			buf[2] |= cDeemphasisON | cDeemphasis75;
+			break;
+		}
+	}
+	return 0;
+}
+
 /* ---------------------------------------------------------------------- */
 
 static int tda9887_set_pinnacle(struct tda9887 *t, char *buf)
@@ -481,7 +513,7 @@ static int tda9887_status(struct tda9887
 {
 	unsigned char buf[1];
 	int rc;
-
+	
 	memset(buf,0,sizeof(buf));
         if (1 != (rc = i2c_master_recv(&t->client,buf,1)))
                 printk(PREFIX "i2c i/o error: rc == %d (should be 1)\n",rc);
@@ -499,6 +531,7 @@ static int tda9887_configure(struct tda9
 	if (UNSET != t->pinnacle_id) {
 		tda9887_set_pinnacle(t,buf);
 	}
+	tda9887_set_config(t,buf);
 	tda9887_set_insmod(t,buf);
 
 	dprintk(PREFIX "writing: b=0x%02x c=0x%02x e=0x%02x\n",
@@ -594,6 +627,14 @@ tda9887_command(struct i2c_client *clien
 		tda9887_configure(t);
 		break;
 	}
+	case TDA9887_SET_CONFIG:
+	{
+		int *i = arg;
+
+		t->config = *i;
+		tda9887_configure(t);
+		break;
+	}
 	/* --- v4l ioctls --- */
 	/* take care: bttv does userspace copying, we'll get a
 	   kernel pointer here... */
@@ -644,6 +685,25 @@ tda9887_command(struct i2c_client *clien
 			t->radio = 1;
 		}
 		tda9887_configure(t);
+		break;
+	}
+	case VIDIOC_G_TUNER:
+	{
+		static int AFC_BITS_2_kHz[] = {
+			-12500,  -37500,  -62500,  -97500,
+			-112500, -137500, -162500, -187500,
+			187500,  162500,  137500,  112500,
+			97500 ,  62500,   37500 ,  12500
+		};
+		struct v4l2_tuner* tuner = arg;
+
+		if (t->radio) {
+			__u8 reg = 0;
+			tuner->afc=0;
+			if (1 == i2c_master_recv(&t->client,&reg,1))
+				tuner->afc = AFC_BITS_2_kHz[(reg>>1)&0x0f];
+		}
+		break;
 	}
 	default:
 		/* nothing */
@@ -670,13 +730,12 @@ static struct i2c_client client_template
         .driver    = &driver,
 };
 
-static int tda9887_init_module(void)
+static int __init tda9887_init_module(void)
 {
-	i2c_add_driver(&driver);
-	return 0;
+	return i2c_add_driver(&driver);
 }
 
-static void tda9887_cleanup_module(void)
+static void __exit tda9887_cleanup_module(void)
 {
 	i2c_del_driver(&driver);
 }
diff -up linux-2.6.9-rc1/drivers/media/video/tuner.c linux/drivers/media/video/tuner.c
--- linux-2.6.9-rc1/drivers/media/video/tuner.c	2004-08-25 16:13:15.000000000 +0200
+++ linux/drivers/media/video/tuner.c	2004-08-25 18:20:58.101517379 +0200
@@ -208,7 +208,7 @@ static struct tunertype tuners[] = {
 	{ "Temic PAL* auto + FM (4009 FN5)", TEMIC, PAL,
 	  16*141.00, 16*464.00, 0xa0,0x90,0x30,0x8e,623},
 	{ "SHARP NTSC_JP (2U5JF5540)", SHARP, NTSC, /* 940=16*58.75 NTSC@Japan */
-	  16*137.25,16*317.25,0x01,0x02,0x08,0x8e,732 }, // Corrected to NTSC=732 (was:940)
+	  16*137.25,16*317.25,0x01,0x02,0x08,0x8e,940 },
 
 	{ "Samsung PAL TCPM9091PD27", Samsung, PAL,  /* from sourceforge v3tv */
           16*169,16*464,0xA0,0x90,0x30,0x8e,623},
@@ -229,7 +229,7 @@ static struct tunertype tuners[] = {
           16*170.00, 16*450.00, 0x01,0x02,0x08,0x8e,732},
 
 	{ "HITACHI V7-J180AT", HITACHI, NTSC,
-	  16*170.00, 16*450.00, 0x01,0x02,0x00,0x8e,940 },
+	  16*170.00, 16*450.00, 0x01,0x02,0x08,0x8e,940 },
 	{ "Philips PAL_MK (FI1216 MK)", Philips, PAL,
 	  16*140.25,16*463.25,0x01,0xc2,0xcf,0x8e,623},
 	{ "Philips 1236D ATSC/NTSC daul in",Philips,ATSC,
@@ -241,6 +241,13 @@ static struct tunertype tuners[] = {
           16*160.00,16*442.00,0x01,0x02,0x04,0x8e,732},
 	{ "Microtune 4049 FM5",Microtune,PAL,
 	  16*141.00,16*464.00,0xa0,0x90,0x30,0x8e,623},
+	{ "Panasonic VP27s/ENGE4324D", Panasonic, NTSC,
+	  16*160.00,16*454.00,0x01,0x02,0x08,0xce,940},
+        { "LG NTSC (TAPE series)", LGINNOTEK, NTSC,
+          16*170.00, 16*450.00, 0x01,0x02,0x04,0x8e,732 },
+
+        { "Tenna TNF 8831 BGFF)", Philips, PAL,
+          16*161.25,16*463.25,0xa0,0x90,0x30,0x8e,623},
 
 };
 #define TUNERS ARRAY_SIZE(tuners)
@@ -543,7 +550,7 @@ static void mt2032_set_tv_freq(struct i2
 		// NTSC
 		from = 40750*1000;
 		to   = 46750*1000;
-		if2  = 45750*1000;
+		if2  = 45750*1000; 
 	} else {
 		// PAL
 		from = 32900*1000;
@@ -847,7 +854,7 @@ static void default_set_tv_freq(struct i
 
 		} else if (t->std & V4L2_STD_PAL_DK) {
 			config |= TEMIC_SET_PAL_DK;
-
+			
 		} else if (t->std & V4L2_STD_SECAM_L) {
 			config |= TEMIC_SET_PAL_L;
 
@@ -934,6 +941,9 @@ static void default_set_radio_freq(struc
 	case TUNER_PHILIPS_FM1236_MK3:
 		buffer[3] = 0x19;
 		break;
+	case TUNER_LG_PAL_FM:
+		buffer[3] = 0xa5;
+		break;
 	default:
 		buffer[3] = 0xa4;
 		break;
@@ -1300,13 +1310,12 @@ static struct i2c_client client_template
         .driver     = &driver,
 };
 
-static int tuner_init_module(void)
+static int __init tuner_init_module(void)
 {
-	i2c_add_driver(&driver);
-	return 0;
+	return i2c_add_driver(&driver);
 }
 
-static void tuner_cleanup_module(void)
+static void __exit tuner_cleanup_module(void)
 {
 	i2c_del_driver(&driver);
 }
diff -up linux-2.6.9-rc1/include/media/tuner.h linux/include/media/tuner.h
--- linux-2.6.9-rc1/include/media/tuner.h	2004-08-25 16:12:51.000000000 +0200
+++ linux/include/media/tuner.h	2004-08-25 18:20:58.103517005 +0200
@@ -70,6 +70,8 @@
 #define TUNER_PHILIPS_FM1236_MK3 43
 #define TUNER_PHILIPS_4IN1       44	/* ATI TV Wonder Pro - Conexant */
 #define TUNER_MICROTUNE_4049FM5  45
+#define TUNER_LG_NTSC_TAPE       47
+#define TUNER_TNF_8831BGFF       48
 
 #define NOTUNER 0
 #define PAL     1	/* PAL_BG */
@@ -88,6 +90,7 @@
 #define Samsung 7
 #define Microtune 8
 #define HITACHI 9
+#define Panasonic 10
 
 #define TUNER_SET_TYPE               _IOW('t',1,int)    /* set tuner type */
 #define TUNER_SET_TVFREQ             _IOW('t',2,int)    /* set tv freq */
@@ -96,4 +99,18 @@
 # define TUNER_SET_MODE              _IOW('t',4,int)    /* set tuner mode */
 #endif
 
+#define  TDA9887_SET_CONFIG          _IOW('t',5,int)
+/* tv card specific */
+# define TDA9887_PRESENT             (1<<0)
+# define TDA9887_PORT1               (1<<1)
+# define TDA9887_PORT2               (1<<2)
+# define TDA9887_QSS                 (1<<3)
+# define TDA9887_INTERCARRIER        (1<<4)
+/* config options */
+# define TDA9887_DEEMPHASIS_MASK     (3<<16)
+# define TDA9887_DEEMPHASIS_NONE     (1<<16)
+# define TDA9887_DEEMPHASIS_50       (2<<16)
+# define TDA9887_DEEMPHASIS_75       (3<<16)
+# define TDA9887_AUTOMUTE            (1<<18)
+
 #endif

-- 
return -ENOSIG;
