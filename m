Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261792AbVFLFM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261792AbVFLFM5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 01:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbVFLFM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 01:12:57 -0400
Received: from smtp4.brturbo.com.br ([200.199.201.180]:22970 "EHLO
	smtp4.brturbo.com.br") by vger.kernel.org with ESMTP
	id S261792AbVFLFKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 01:10:17 -0400
Message-ID: <42ABC3C4.4050406@brturbo.com.br>
Date: Sun, 12 Jun 2005 02:10:28 -0300
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: pt-br, pt, es, en-us, en
MIME-Version: 1.0
To: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
CC: Andrew Morton <akpm@osdl.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH3/5] Synchronize patch for SAA7134 cards
References: <42ABBE6F.8080406@brturbo.com.br>
In-Reply-To: <42ABBE6F.8080406@brturbo.com.br>
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------050808020807050808060907"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050808020807050808060907
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

I forgot attach... send it again:

Mauro Carvalho Chehab wrote:

>This patch adds support for various SAA7134 cards and brings some fixes.
>
>Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
>Signed-off-by: Fabrice Aeschbacher <fabrice.aeschbacher@laposte.net>
>Signed-off-by: Hermann Pitton <hermann.pitton@onlinehome.de>.
>Signed-off-by: Nickolay V Shmyrev <nshmyrev@yandex.ru>
>
>
>  
>


--------------050808020807050808060907
Content-Type: text/x-patch;
 name="patch03.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="patch03.patch"

diff -u linux-2.6.12/drivers/media/video/saa7134/saa7134.h linux/drivers/media/video/saa7134/saa7134.h
--- linux-2.6.12/drivers/media/video/saa7134/saa7134.h	2005-06-07 15:39:55.000000000 -0300
+++ linux/drivers/media/video/saa7134/saa7134.h	2005-06-12 01:22:33.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: saa7134.h,v 1.38 2005/03/07 12:01:51 kraxel Exp $
+ * $Id: saa7134.h,v 1.41 2005/06/07 18:02:26 nsh Exp $
  *
  * v4l2 device driver for philips saa7134 based TV cards
  *
@@ -168,7 +168,7 @@
 #define SAA7134_BOARD_SABRENT_SBTTVFM  42
 #define SAA7134_BOARD_ZOLID_XPERT_TV7134 43
 #define SAA7134_BOARD_EMPIRE_PCI_TV_RADIO_LE 44
-#define SAA7134_BOARD_AVERMEDIA_307    45
+#define SAA7134_BOARD_AVERMEDIA_STUDIO_307    45
 #define SAA7134_BOARD_AVERMEDIA_CARDBUS 46
 #define SAA7134_BOARD_CINERGY400_CARDBUS 47
 #define SAA7134_BOARD_CINERGY600_MK3   48
@@ -179,6 +179,10 @@
 #define SAA7135_BOARD_ASUSTeK_TVFM7135 53
 #define SAA7134_BOARD_FLYTVPLATINUM_FM 54
 #define SAA7134_BOARD_FLYDVBTDUO 55
+#define SAA7134_BOARD_AVERMEDIA_307    56
+#define SAA7134_BOARD_AVERMEDIA_GO_007_FM 57
+#define SAA7134_BOARD_ADS_INSTANT_TV 58
+#define SAA7134_BOARD_KWORLD_VSTREAM_XPERT 59
 
 #define SAA7134_MAXBOARDS 8
 #define SAA7134_INPUT_MAX 8
diff -u linux-2.6.12/drivers/media/video/saa7134/saa7134-core.c linux/drivers/media/video/saa7134/saa7134-core.c
--- linux-2.6.12/drivers/media/video/saa7134/saa7134-core.c	2005-06-07 15:39:55.000000000 -0300
+++ linux/drivers/media/video/saa7134/saa7134-core.c	2005-06-12 01:22:33.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: saa7134-core.c,v 1.28 2005/02/22 09:56:29 kraxel Exp $
+ * $Id: saa7134-core.c,v 1.30 2005/05/22 19:23:39 nsh Exp $
  *
  * device driver for philips saa7134 based TV cards
  * driver core
@@ -1212,10 +1212,8 @@
 
 static void saa7134_fini(void)
 {
-#ifdef CONFIG_MODULES
 	if (pending_registered)
 		unregister_module_notifier(&pending_notifier);
-#endif
 	pci_unregister_driver(&saa7134_pci_driver);
 }
 
diff -u linux-2.6.12/drivers/media/video/saa7134/saa7134-cards.c linux/drivers/media/video/saa7134/saa7134-cards.c
--- linux-2.6.12/drivers/media/video/saa7134/saa7134-cards.c	2005-06-07 15:38:10.000000000 -0300
+++ linux/drivers/media/video/saa7134/saa7134-cards.c	2005-06-12 01:22:33.000000000 -0300
@@ -1,6 +1,6 @@
 
 /*
- * $Id: saa7134-cards.c,v 1.54 2005/03/07 12:01:51 kraxel Exp $
+ * $Id: saa7134-cards.c,v 1.58 2005/06/07 18:05:00 nsh Exp $
  *
  * device driver for philips saa7134 based TV cards
  * card-specific stuff.
@@ -165,7 +165,7 @@
 		.inputs         = {{
 			.name = name_tv,
 			.vmux = 1,
-			.amux = LINE2,
+			.amux = TV,
 			.tv   = 1,
 		},{
 			.name = name_comp1,
@@ -878,7 +878,7 @@
         },
 	[SAA7134_BOARD_MANLI_MTV002] = {
 		/* Ognjen Nastic <ognjen@logosoft.ba> */
-		.name           = "Manli MuchTV M-TV002",
+		.name           = "Manli MuchTV M-TV002/Behold TV 403 FM",
 		.audio_clock    = 0x00200000,
 		.tuner_type     = TUNER_PHILIPS_PAL,
 		.inputs         = {{
@@ -899,14 +899,10 @@
 			.name = name_radio,
 			.amux = LINE2,
 		},
-		.mute = {
-			.name = name_mute,
-                        .amux = LINE1,
-		},
 	},
 	[SAA7134_BOARD_MANLI_MTV001] = {
 		/* Ognjen Nastic <ognjen@logosoft.ba> UNTESTED */
-		.name           = "Manli MuchTV M-TV001",
+		.name           = "Manli MuchTV M-TV001/Behold TV 401",
 		.audio_clock    = 0x00200000,
 		.tuner_type     = TUNER_PHILIPS_PAL,
 		.inputs         = {{
@@ -923,6 +919,10 @@
 			.amux = LINE2,
 			.tv   = 1,
 		}},
+		.mute = {
+			.name = name_mute,
+                        .amux = LINE1,
+		},
         },
 	[SAA7134_BOARD_TG3000TV] = {
 		/* TransGear 3000TV */
@@ -1078,7 +1078,6 @@
 		.audio_clock    = 0x00187de7,
 		.tuner_type     = TUNER_PHILIPS_FM1256_IH3,
 		.tda9887_conf   = TDA9887_PRESENT,
-		.gpiomask = 0x3,
 		.inputs         = {{
 			.name = name_tv,
 			.vmux = 1,
@@ -1285,7 +1284,7 @@
 			 .gpio =0x8000,
 		 }
 	},
-        [SAA7134_BOARD_AVERMEDIA_307] = {
+        [SAA7134_BOARD_AVERMEDIA_STUDIO_307] = {
 		/*
 		Nickolay V. Shmyrev <nshmyrev@yandex.ru>
 		Lots of thanks to Andrey Zolotarev <zolotarev_andrey@mail.ru>
@@ -1323,6 +1322,35 @@
 			.gpio = 0x01,
 		},
         },
+        [SAA7134_BOARD_AVERMEDIA_GO_007_FM] = {
+		.name           = "Avermedia AVerTV GO 007 FM",
+		.audio_clock    = 0x00187de7,
+		.tuner_type     = TUNER_PHILIPS_TDA8290,
+		.gpiomask       = 0x00300003,
+//		.gpiomask       = 0x8c240003,
+		.inputs         = {{
+			.name = name_tv,
+			.vmux = 1,
+			.amux = TV,
+			.tv   = 1,
+			.gpio = 0x01,
+		},{
+			.name = name_comp1,
+			.vmux = 0,
+			.amux = LINE2,
+			.gpio = 0x02,
+		},{
+			.name = name_svideo,
+			.vmux = 6,
+			.amux = LINE2,
+			.gpio = 0x02,
+		}},
+		.radio = {
+			.name = name_radio,
+			.amux = LINE1,
+			.gpio = 0x00300001,
+		},
+        },
 	[SAA7134_BOARD_AVERMEDIA_CARDBUS] = {
 		/* Jon Westgate <oryn@oryn.fsck.tv> */
 		.name           = "AVerMedia Cardbus TV/Radio",
@@ -1492,7 +1520,6 @@
 		.audio_clock    = 0x00187de7,
 		.tuner_type     = TUNER_PHILIPS_FQ1216ME,
 		.tda9887_conf   = TDA9887_PRESENT,
-		.gpiomask = 0x3,
 		.inputs         = {{
 			.name = name_tv,
 			.vmux = 1,
@@ -1546,7 +1573,82 @@
 //			.gpio = 0x4000,
 		}},
 	},
-};
+        [SAA7134_BOARD_AVERMEDIA_307] = {
+               /*
+                 Davydov Vladimir <vladimir@iqmedia.com>
+               */
+               .name           = "Avermedia AVerTV 307",
+               .audio_clock    = 0x00187de7,
+               .tuner_type     = TUNER_PHILIPS_FQ1216ME,
+               .tda9887_conf   = TDA9887_PRESENT,
+               .inputs         = {{
+                       .name = name_tv,
+                       .vmux = 1,
+                       .amux = TV,
+                       .tv   = 1,
+               },{
+                       .name = name_comp1,
+                       .vmux = 0,
+                       .amux = LINE1,
+               },{
+                       .name = name_comp2,
+                       .vmux = 3,
+                       .amux = LINE1,
+               },{
+                       .name = name_svideo,
+                       .vmux = 8,
+                       .amux = LINE1,
+               }},
+        },
+	[SAA7134_BOARD_ADS_INSTANT_TV] = {
+                .name           = "ADS Tech Instant TV (saa7135)",
+		.audio_clock    = 0x00187de7,   
+                .tuner_type     = TUNER_PHILIPS_TDA8290,
+                .inputs         = {{
+                        .name = name_tv,
+                        .vmux = 1,
+                        .amux = TV,
+                        .tv   = 1,
+                },{
+                        .name = name_comp1,
+                        .vmux = 3,
+                        .amux = LINE2,
+                },{
+                        .name = name_svideo,
+                        .vmux = 8,
+                        .amux = LINE2,
+                }},
+	},
+ 	[SAA7134_BOARD_KWORLD_VSTREAM_XPERT] = {
+ 		.name           = "Kworld/Tevion V-Stream Xpert TV PVR7134",
+ 		.audio_clock    = 0x00187de7,
+ 		.tuner_type     = TUNER_PHILIPS_PAL_I,
+ 		.gpiomask	= 0x0700,
+ 		.inputs = {{
+ 			.name   = name_tv,
+ 			.vmux   = 1,
+ 			.amux   = TV,
+ 			.tv     = 1,
+ 			.gpio   = 0x000,
+ 		},{
+ 			.name   = name_comp1,
+ 			.vmux   = 3,
+ 			.amux   = LINE1,
+ 			.gpio   = 0x200,		//gpio by DScaler
+ 		},{
+ 			.name   = name_svideo,
+ 			.vmux   = 0,
+ 			.amux   = LINE1,
+ 			.gpio   = 0x200,
+ 		}},
+ 		.radio = {
+ 			.name   = name_radio,
+ 			.amux   = LINE1,
+ 			.gpio   = 0x100,
+ 		},
+ 	},
+ };
+
 const unsigned int saa7134_bcount = ARRAY_SIZE(saa7134_boards);
 
 /* ------------------------------------------------------------------ */
@@ -1663,7 +1765,7 @@
                 .driver_data  = SAA7134_BOARD_ASUSTeK_TVFM7134,
 	},{
                 .vendor       = PCI_VENDOR_ID_PHILIPS,
-                .device       = PCI_DEVICE_ID_PHILIPS_SAA7133,
+                .device       = PCI_DEVICE_ID_PHILIPS_SAA7135,
                 .subvendor    = PCI_VENDOR_ID_ASUSTEK,
                 .subdevice    = 0x4845,
                 .driver_data  = SAA7135_BOARD_ASUSTeK_TVFM7135,
@@ -1824,6 +1926,12 @@
 		.device       = PCI_DEVICE_ID_PHILIPS_SAA7134,
 		.subvendor    = 0x1461, /* Avermedia Technologies Inc */
 		.subdevice    = 0x9715,
+		.driver_data  = SAA7134_BOARD_AVERMEDIA_STUDIO_307,
+	},{
+		.vendor       = PCI_VENDOR_ID_PHILIPS,
+		.device       = PCI_DEVICE_ID_PHILIPS_SAA7134,
+		.subvendor    = 0x1461, /* Avermedia Technologies Inc */
+		.subdevice    = 0xa70a,
 		.driver_data  = SAA7134_BOARD_AVERMEDIA_307,
 	},{
 		.vendor       = PCI_VENDOR_ID_PHILIPS,
@@ -1844,6 +1952,26 @@
 		.subvendor    = 0x5168,
 		.subdevice    = 0x0306,
 		.driver_data  = SAA7134_BOARD_FLYDVBTDUO,
+	},{
+		.vendor       = PCI_VENDOR_ID_PHILIPS,
+		.device       = PCI_DEVICE_ID_PHILIPS_SAA7133,
+		.subvendor    = 0x1461, /* Avermedia Technologies Inc */
+		.subdevice    = 0xf31f,
+		.driver_data  = SAA7134_BOARD_AVERMEDIA_GO_007_FM,
+
+ 	},{
+		.vendor       = PCI_VENDOR_ID_PHILIPS,
+		.device       = PCI_DEVICE_ID_PHILIPS_SAA7135,
+		.subvendor    = 0x1421,
+		.subdevice    = 0x0350,		/* PCI version */
+		.driver_data  = SAA7134_BOARD_ADS_INSTANT_TV,
+
+ 	},{
+		.vendor       = PCI_VENDOR_ID_PHILIPS,
+		.device       = PCI_DEVICE_ID_PHILIPS_SAA7135,
+		.subvendor    = 0x1421,
+		.subdevice    = 0x0370,		/* cardbus version */
+		.driver_data  = SAA7134_BOARD_ADS_INSTANT_TV,
 
  	},{
 		/* --- boards without eeprom + subsystem ID --- */
@@ -1954,20 +2082,23 @@
 		dev->has_remote = 1;
 		board_flyvideo(dev);
 		break;
-	case SAA7134_BOARD_FLYTVPLATINUM_FM:
+        case SAA7134_BOARD_FLYTVPLATINUM_FM:
 	case SAA7134_BOARD_CINERGY400:
 	case SAA7134_BOARD_CINERGY600:
 	case SAA7134_BOARD_CINERGY600_MK3:
 	case SAA7134_BOARD_ECS_TVP3XP:
 	case SAA7134_BOARD_ECS_TVP3XP_4CB5:
 	case SAA7134_BOARD_MD2819:
+	case SAA7134_BOARD_KWORLD_VSTREAM_XPERT:
 	case SAA7134_BOARD_AVERMEDIA_STUDIO_305:
 	case SAA7134_BOARD_AVERMEDIA_305:
+	case SAA7134_BOARD_AVERMEDIA_STUDIO_307:
 	case SAA7134_BOARD_AVERMEDIA_307:
+	case SAA7134_BOARD_AVERMEDIA_GO_007_FM:
 //	case SAA7134_BOARD_SABRENT_SBTTVFM:  /* not finished yet */
 	case SAA7134_BOARD_VIDEOMATE_TV_PVR:
-		dev->has_remote = 1;
-		break;
+ 	case SAA7134_BOARD_MANLI_MTV001:
+ 	case SAA7134_BOARD_MANLI_MTV002:
 	case SAA7134_BOARD_AVACSSMARTTV:
 		dev->has_remote = 1;
 		break;
diff -u linux-2.6.12/drivers/media/video/saa7134/saa7134-i2c.c linux/drivers/media/video/saa7134/saa7134-i2c.c
--- linux-2.6.12/drivers/media/video/saa7134/saa7134-i2c.c	2005-06-07 15:38:10.000000000 -0300
+++ linux/drivers/media/video/saa7134/saa7134-i2c.c	2005-06-12 01:22:33.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: saa7134-i2c.c,v 1.10 2005/01/24 17:37:23 kraxel Exp $
+ * $Id: saa7134-i2c.c,v 1.11 2005/06/12 01:36:14 mchehab Exp $
  *
  * device driver for philips saa7134 based TV cards
  * i2c interface support
diff -u linux-2.6.12/drivers/media/video/saa7134/saa7134-tvaudio.c linux/drivers/media/video/saa7134/saa7134-tvaudio.c
--- linux-2.6.12/drivers/media/video/saa7134/saa7134-tvaudio.c	2005-06-07 15:38:10.000000000 -0300
+++ linux/drivers/media/video/saa7134/saa7134-tvaudio.c	2005-06-12 01:22:34.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: saa7134-tvaudio.c,v 1.22 2005/01/07 13:11:19 kraxel Exp $
+ * $Id: saa7134-tvaudio.c,v 1.25 2005/06/07 19:00:38 nsh Exp $
  *
  * device driver for philips saa7134 based TV cards
  * tv audio decoder (fm stereo, nicam, ...)
@@ -181,7 +181,8 @@
 	saa_writeb(SAA7134_AUDIO_CLOCK0,      clock        & 0xff);
 	saa_writeb(SAA7134_AUDIO_CLOCK1,     (clock >>  8) & 0xff);
 	saa_writeb(SAA7134_AUDIO_CLOCK2,     (clock >> 16) & 0xff);
-	saa_writeb(SAA7134_AUDIO_PLL_CTRL,   0x01);
+	// frame locked audio was reported not to be reliable
+	saa_writeb(SAA7134_AUDIO_PLL_CTRL,   0x02);
 
 	saa_writeb(SAA7134_NICAM_ERROR_LOW,  0x14);
 	saa_writeb(SAA7134_NICAM_ERROR_HIGH, 0x50);
@@ -250,7 +251,12 @@
 	saa_andorb(SAA7134_AUDIO_FORMAT_CTRL, 0xc0, ausel);
 	saa_andorb(SAA7134_ANALOG_IO_SELECT, 0x08, ics);
 	saa_andorb(SAA7134_ANALOG_IO_SELECT, 0x07, ocs);
-
+	// for oss, we need to change the clock configuration
+	if (in->amux == TV)
+		saa_andorb(SAA7134_SIF_SAMPLE_FREQ,   0x03, 0x00);
+	else
+		saa_andorb(SAA7134_SIF_SAMPLE_FREQ,   0x03, 0x01);
+	
 	/* switch gpio-connected external audio mux */
 	if (0 == card(dev).gpiomask)
 		return;
@@ -439,16 +445,15 @@
 		nicam = saa_readb(SAA7134_NICAM_STATUS);
 		dprintk("getstereo: nicam=0x%x\n",nicam);
 		switch (nicam & 0x0b) {
+		case 0x08:
+			retval = V4L2_TUNER_SUB_MONO;
+			break;
 		case 0x09:
 			retval = V4L2_TUNER_SUB_LANG1 | V4L2_TUNER_SUB_LANG2;
 			break;
 		case 0x0a:
 			retval = V4L2_TUNER_SUB_MONO | V4L2_TUNER_SUB_STEREO;
 			break;
-		case 0x08:
-		default:
-			retval = V4L2_TUNER_SUB_MONO;
-			break;
 		}
 		break;
 	}
@@ -572,14 +577,14 @@
 		} else if (0 != dev->last_carrier) {
 			/* no carrier -- try last detected one as fallback */
 			carrier = dev->last_carrier;
-			printk(KERN_WARNING "%s/audio: audio carrier scan failed, "
+			dprintk(KERN_WARNING "%s/audio: audio carrier scan failed, "
 			       "using %d.%03d MHz [last detected]\n",
 			       dev->name, carrier/1000, carrier%1000);
 
 		} else {
 			/* no carrier + no fallback -- use default */
 			carrier = default_carrier;
-			printk(KERN_WARNING "%s/audio: audio carrier scan failed, "
+			dprintk(KERN_WARNING "%s/audio: audio carrier scan failed, "
 			       "using %d.%03d MHz [default]\n",
 			       dev->name, carrier/1000, carrier%1000);
 		}
diff -u linux-2.6.12/drivers/media/video/saa7134/saa7134-video.c linux/drivers/media/video/saa7134/saa7134-video.c
--- linux-2.6.12/drivers/media/video/saa7134/saa7134-video.c	2005-06-07 15:39:55.000000000 -0300
+++ linux/drivers/media/video/saa7134/saa7134-video.c	2005-06-12 01:22:34.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: saa7134-video.c,v 1.28 2005/02/15 15:59:35 kraxel Exp $
+ * $Id: saa7134-video.c,v 1.30 2005/06/07 19:00:38 nsh Exp $
  *
  * device driver for philips saa7134 based TV cards
  * video4linux video interface
@@ -31,8 +31,6 @@
 #include "saa7134-reg.h"
 #include "saa7134.h"
 
-#define V4L2_I2C_CLIENTS 1
-
 /* ------------------------------------------------------------------ */
 
 static unsigned int video_debug   = 0;
@@ -276,13 +274,14 @@
 
 		.h_start       = 0,
 		.h_stop        = 719,
- 		.video_v_start = 23,
- 		.video_v_stop  = 262,
- 		.vbi_v_start_0 = 10,
- 		.vbi_v_stop_0  = 21,
- 		.vbi_v_start_1 = 273,
- 		.src_timing    = 7,
-
+		.video_v_start = 22,
+  		.video_v_start = 23,
+  		.video_v_stop  = 262,
+  		.vbi_v_start_0 = 10,
+  		.vbi_v_stop_0  = 21,
+  		.vbi_v_start_1 = 273,
+  		.src_timing    = 7,
+		
 		.sync_control  = 0x18,
 		.luma_control  = 0x40,
 		.chroma_ctrl1  = 0x81,
@@ -524,22 +523,7 @@
 	saa_writeb(SAA7134_RAW_DATA_GAIN,         0x40);
 	saa_writeb(SAA7134_RAW_DATA_OFFSET,       0x80);
 
-#ifdef V4L2_I2C_CLIENTS
 	saa7134_i2c_call_clients(dev,VIDIOC_S_STD,&norm->id);
-#else
-	{
-		/* pass down info to the i2c chips (v4l1) */
-		struct video_channel c;
-		memset(&c,0,sizeof(c));
-		c.channel = dev->ctl_input;
-		c.norm = VIDEO_MODE_PAL;
-		if (norm->id & V4L2_STD_NTSC)
-			c.norm = VIDEO_MODE_NTSC;
-		if (norm->id & V4L2_STD_SECAM)
-			c.norm = VIDEO_MODE_SECAM;
-		saa7134_i2c_call_clients(dev,VIDIOCSCHAN,&c);
-	}
-#endif
 }
 
 static void video_mux(struct saa7134_dev *dev, int input)
@@ -1883,11 +1867,9 @@
 			return -EINVAL;
 		down(&dev->lock);
 		dev->ctl_freq = f->frequency;
-#ifdef V4L2_I2C_CLIENTS
+
 		saa7134_i2c_call_clients(dev,VIDIOC_S_FREQUENCY,f);
-#else
-		saa7134_i2c_call_clients(dev,VIDIOCSFREQ,&dev->ctl_freq);
-#endif
+
 		saa7134_tvaudio_do_scan(dev);
 		up(&dev->lock);
 		return 0;
@@ -2142,16 +2124,19 @@
                 t->rangelow  = (int)(65*16);
                 t->rangehigh = (int)(108*16);
 
-#ifdef V4L2_I2C_CLIENTS
-		saa7134_i2c_call_clients(dev,VIDIOC_G_TUNER,t);
-#else
-		{
-			struct video_tuner vt;
-			memset(&vt,0,sizeof(vt));
-			saa7134_i2c_call_clients(dev,VIDIOCGTUNER,&vt);
-			t->signal = vt.signal;
-		}
-#endif
+		saa7134_i2c_call_clients(dev, VIDIOC_G_TUNER, t);
+
+		return 0;
+	}
+	case VIDIOC_S_TUNER:
+	{
+		struct v4l2_tuner *t = arg;
+
+		if (0 != t->index)
+			return -EINVAL;
+			
+		saa7134_i2c_call_clients(dev,VIDIOC_S_TUNER,t);
+
 		return 0;
 	}
 	case VIDIOC_ENUMINPUT:
@@ -2185,7 +2170,6 @@
 		return 0;
 	}
 	case VIDIOC_S_AUDIO:
-	case VIDIOC_S_TUNER:
 	case VIDIOC_S_INPUT:
 	case VIDIOC_S_STD:
 		return 0;
diff -u linux-2.6.12/drivers/media/video/saa7134/saa7134-vbi.c linux/drivers/media/video/saa7134/saa7134-vbi.c
--- linux-2.6.12/drivers/media/video/saa7134/saa7134-vbi.c	2005-06-07 15:39:55.000000000 -0300
+++ linux/drivers/media/video/saa7134/saa7134-vbi.c	2005-06-12 01:22:34.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: saa7134-vbi.c,v 1.6 2004/12/10 12:33:39 kraxel Exp $
+ * $Id: saa7134-vbi.c,v 1.7 2005/05/24 23:13:06 nsh Exp $
  *
  * device driver for philips saa7134 based TV cards
  * video4linux video interface
diff -u linux-2.6.12/drivers/media/video/saa7134/saa7134-oss.c linux/drivers/media/video/saa7134/saa7134-oss.c
--- linux-2.6.12/drivers/media/video/saa7134/saa7134-oss.c	2005-06-07 15:38:10.000000000 -0300
+++ linux/drivers/media/video/saa7134/saa7134-oss.c	2005-06-12 01:22:34.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: saa7134-oss.c,v 1.13 2004/12/10 12:33:39 kraxel Exp $
+ * $Id: saa7134-oss.c,v 1.14 2005/05/18 22:45:16 hhackmann Exp $
  *
  * device driver for philips saa7134 based TV cards
  * oss dsp interface
@@ -49,7 +49,6 @@
 
 static int dsp_buffer_conf(struct saa7134_dev *dev, int blksize, int blocks)
 {
-	blksize &= ~0xff;
 	if (blksize < 0x100)
 		blksize = 0x100;
 	if (blksize > 0x10000)
@@ -57,8 +56,6 @@
 
 	if (blocks < 2)
 		blocks = 2;
-        while ((blksize * blocks) & ~PAGE_MASK)
-		blocks++;
 	if ((blksize * blocks) > 1024*1024)
 		blocks = 1024*1024 / blksize;
 
@@ -79,7 +76,7 @@
 		BUG();
 	videobuf_dma_init(&dev->oss.dma);
 	err = videobuf_dma_init_kernel(&dev->oss.dma, PCI_DMA_FROMDEVICE,
-				       dev->oss.bufsize >> PAGE_SHIFT);
+				       (dev->oss.bufsize + PAGE_SIZE) >> PAGE_SHIFT);
 	if (0 != err)
 		return err;
 	return 0;
@@ -163,10 +160,11 @@
 			fmt |= 0x04;
 		fmt |= (TV == dev->oss.input) ? 0xc0 : 0x80;
 
-		saa_writeb(SAA7134_NUM_SAMPLES0, (dev->oss.blksize & 0x0000ff));
-		saa_writeb(SAA7134_NUM_SAMPLES1, (dev->oss.blksize & 0x00ff00) >>  8);
-		saa_writeb(SAA7134_NUM_SAMPLES2, (dev->oss.blksize & 0xff0000) >> 16);
+		saa_writeb(SAA7134_NUM_SAMPLES0, ((dev->oss.blksize - 1) & 0x0000ff));
+		saa_writeb(SAA7134_NUM_SAMPLES1, ((dev->oss.blksize - 1) & 0x00ff00) >>  8);
+		saa_writeb(SAA7134_NUM_SAMPLES2, ((dev->oss.blksize - 1) & 0xff0000) >> 16);
 		saa_writeb(SAA7134_AUDIO_FORMAT_CTRL, fmt);
+		
 		break;
 	case PCI_DEVICE_ID_PHILIPS_SAA7133:
 	case PCI_DEVICE_ID_PHILIPS_SAA7135:
@@ -817,7 +815,7 @@
 			reg = SAA7134_RS_BA1(6);
 	} else {
 		/* even */
-		if (0 == (dev->oss.dma_blk & 0x00))
+		if (1 == (dev->oss.dma_blk & 0x01))
 			reg = SAA7134_RS_BA2(6);
 	}
 	if (0 == reg) {
diff -u linux-2.6.12/drivers/media/video/saa7134/saa7134-input.c linux/drivers/media/video/saa7134/saa7134-input.c
--- linux-2.6.12/drivers/media/video/saa7134/saa7134-input.c	2005-06-07 15:38:10.000000000 -0300
+++ linux/drivers/media/video/saa7134/saa7134-input.c	2005-06-12 01:22:34.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: saa7134-input.c,v 1.16 2004/12/10 12:33:39 kraxel Exp $
+ * $Id: saa7134-input.c,v 1.19 2005/06/07 18:02:26 nsh Exp $
  *
  * handle saa7134 IR remotes via linux kernel input layer.
  *
@@ -308,6 +308,102 @@
 	[ 32 ] = KEY_LANGUAGE,
 	[ 33 ] = KEY_SLEEP,
 };
+
+/* Michael Tokarev <mjt@tls.msk.ru>
+   http://www.corpit.ru/mjt/beholdTV/remote_control.jpg
+   keytable is used by MANLI MTV00[12] and BeholdTV 40[13] at
+   least, and probably other cards too.
+   The "ascii-art picture" below (in comments, first row
+   is the keycode in hex, and subsequent row(s) shows
+   the button labels (several variants when appropriate)
+   helps to descide which keycodes to assign to the buttons.
+ */
+static IR_KEYTAB_TYPE manli_codes[IR_KEYTAB_SIZE] = {
+
+	/*  0x1c            0x12  *
+	 * FUNCTION         POWER *
+	 *   FM              (|)  *
+	 *                        */
+	[ 0x1c ] = KEY_RADIO,	/*XXX*/
+	[ 0x12 ] = KEY_POWER,
+
+	/*  0x01    0x02    0x03  *
+	 *   1       2       3    *
+	 *                        *
+	 *  0x04    0x05    0x06  *
+	 *   4       5       6    *
+	 *                        *
+	 *  0x07    0x08    0x09  *
+	 *   7       8       9    *
+	 *                        */
+	[ 0x01 ] = KEY_KP1,
+	[ 0x02 ] = KEY_KP2,
+	[ 0x03 ] = KEY_KP3,
+	[ 0x04 ] = KEY_KP4,
+	[ 0x05 ] = KEY_KP5,
+	[ 0x06 ] = KEY_KP6,
+	[ 0x07 ] = KEY_KP7,
+	[ 0x08 ] = KEY_KP8,
+	[ 0x09 ] = KEY_KP9,
+
+	/*  0x0a    0x00    0x17  *
+	 * RECALL    0      +100  *
+	 *                  PLUS  *
+	 *                        */
+	[ 0x0a ] = KEY_AGAIN,	/*XXX KEY_REWIND? */
+	[ 0x00 ] = KEY_KP0,
+	[ 0x17 ] = KEY_DIGITS,	/*XXX*/
+
+	/*  0x14            0x10  *
+	 *  MENU            INFO  *
+	 *  OSD                   */
+	[ 0x14 ] = KEY_MENU,
+	[ 0x10 ] = KEY_INFO,
+
+	/*          0x0b          *
+	 *           Up           *
+	 *                        *
+	 *  0x18    0x16    0x0c  *
+	 *  Left     Ok     Right *
+	 *                        *
+	 *         0x015          *
+	 *         Down           *
+	 *                        */
+	[ 0x0b ] = KEY_UP,	/*XXX KEY_SCROLLUP? */
+	[ 0x18 ] = KEY_LEFT,	/*XXX KEY_BACK? */
+	[ 0x16 ] = KEY_OK,	/*XXX KEY_SELECT? KEY_ENTER? */
+	[ 0x0c ] = KEY_RIGHT,	/*XXX KEY_FORWARD? */
+	[ 0x15 ] = KEY_DOWN,	/*XXX KEY_SCROLLDOWN? */
+
+	/*  0x11            0x0d  *
+	 *  TV/AV           MODE  *
+	 *  SOURCE         STEREO *
+	 *                        */
+	[ 0x11 ] = KEY_TV,	/*XXX*/
+	[ 0x0d ] = KEY_MODE,	/*XXX there's no KEY_STEREO */
+
+	/*  0x0f    0x1b    0x1a  *
+	 *  AUDIO   Vol+    Chan+ *
+	 *        TIMESHIFT???    *
+	 *                        *
+	 *  0x0e    0x1f    0x1e  *
+	 *  SLEEP   Vol-    Chan- *
+	 *                        */
+	[ 0x0f ] = KEY_AUDIO,
+	[ 0x1b ] = KEY_VOLUMEUP,
+	[ 0x1a ] = KEY_CHANNELUP,
+	[ 0x0e ] = KEY_SLEEP,	/*XXX maybe KEY_PAUSE */
+	[ 0x1f ] = KEY_VOLUMEDOWN,
+	[ 0x1e ] = KEY_CHANNELDOWN,
+
+	/*         0x13     0x19  *
+	 *         MUTE   SNAPSHOT*
+	 *                        */
+	[ 0x13 ] = KEY_MUTE,
+	[ 0x19 ] = KEY_RECORD,	/*XXX*/
+
+	// 0x1d unused ?
+};
 /* ---------------------------------------------------------------------- */
 
 static int build_key(struct saa7134_dev *dev)
@@ -379,7 +475,7 @@
 	switch (dev->board) {
 	case SAA7134_BOARD_FLYVIDEO2000:
 	case SAA7134_BOARD_FLYVIDEO3000:
-	case SAA7134_BOARD_FLYTVPLATINUM_FM:
+        case SAA7134_BOARD_FLYTVPLATINUM_FM:
 		ir_codes     = flyvideo_codes;
 		mask_keycode = 0xEC00000;
 		mask_keydown = 0x0040000;
@@ -405,8 +501,12 @@
 		polling      = 50; // ms
 		break;
 	case SAA7134_BOARD_MD2819:
+	case SAA7134_BOARD_KWORLD_VSTREAM_XPERT:
 	case SAA7134_BOARD_AVERMEDIA_305:
 	case SAA7134_BOARD_AVERMEDIA_307:
+	case SAA7134_BOARD_AVERMEDIA_STUDIO_305:
+	case SAA7134_BOARD_AVERMEDIA_STUDIO_307:
+	case SAA7134_BOARD_AVERMEDIA_GO_007_FM:
 		ir_codes     = md2819_codes;
 		mask_keycode = 0x0007C8;
 		mask_keydown = 0x000010;
@@ -415,6 +515,14 @@
 		saa_setb(SAA7134_GPIO_GPMODE0, 0x4);
 		saa_setb(SAA7134_GPIO_GPSTATUS0, 0x4);
 		break;
+	case SAA7134_BOARD_MANLI_MTV001:
+	case SAA7134_BOARD_MANLI_MTV002:
+		ir_codes     = manli_codes;
+		mask_keycode = 0x001f00;
+		mask_keyup   = 0x004000;
+		mask_keydown = 0x002000;
+		polling      = 50; // ms
+		break;
 	case SAA7134_BOARD_VIDEOMATE_TV_PVR:
 		ir_codes     = videomate_tv_pvr_codes;
 		mask_keycode = 0x00003F;
diff -u linux-2.6.12/drivers/media/video/saa7134/saa7134-empress.c linux/drivers/media/video/saa7134/saa7134-empress.c
--- linux-2.6.12/drivers/media/video/saa7134/saa7134-empress.c	2005-06-07 15:38:10.000000000 -0300
+++ linux/drivers/media/video/saa7134/saa7134-empress.c	2005-06-12 01:22:34.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: saa7134-empress.c,v 1.10 2005/02/03 10:24:33 kraxel Exp $
+ * $Id: saa7134-empress.c,v 1.11 2005/05/22 19:23:39 nsh Exp $
  *
  * (c) 2004 Gerd Knorr <kraxel@bytesex.org> [SuSE Labs]
  *
diff -u linux-2.6.12/drivers/media/video/saa7134/saa7134-dvb.c linux/drivers/media/video/saa7134/saa7134-dvb.c
--- linux-2.6.12/drivers/media/video/saa7134/saa7134-dvb.c	2005-06-07 15:38:10.000000000 -0300
+++ linux/drivers/media/video/saa7134/saa7134-dvb.c	2005-06-12 01:22:34.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: saa7134-dvb.c,v 1.12 2005/02/18 12:28:29 kraxel Exp $
+ * $Id: saa7134-dvb.c,v 1.13 2005/06/12 04:19:19 mchehab Exp $
  *
  * (c) 2004 Gerd Knorr <kraxel@bytesex.org> [SuSE Labs]
  *
@@ -171,7 +171,7 @@
 	struct saa7134_dev *dev = fe->dvb->priv;
 	return request_firmware(fw, name, &dev->pci->dev);
 }
-
+	
 static struct tda1004x_config medion_cardbus = {
 	.demod_address = 0x08,  /* not sure this is correct */
 	.invert        = 0,
diff -u linux-2.6.12/drivers/media/video/saa7134/saa6752hs.c linux/drivers/media/video/saa7134/saa6752hs.c
--- linux-2.6.12/drivers/media/video/saa7134/saa6752hs.c	2005-06-07 15:39:55.000000000 -0300
+++ linux/drivers/media/video/saa7134/saa6752hs.c	2005-06-12 01:22:34.000000000 -0300
@@ -22,6 +22,7 @@
 
 /* Addresses to scan */
 static unsigned short normal_i2c[] = {0x20, I2C_CLIENT_END};
+static unsigned short normal_i2c_range[] = {I2C_CLIENT_END};
 I2C_CLIENT_INSMOD;
 
 MODULE_DESCRIPTION("device driver for saa6752hs MPEG2 encoder");
@@ -42,15 +43,15 @@
 static const struct v4l2_format v4l2_format_table[] =
 {
 	[SAA6752HS_VF_D1] = {
-		.fmt = { .pix = { .width = 720, .height = 576 }, }, },
+		.fmt.pix.width = 720, .fmt.pix.height = 576 },
 	[SAA6752HS_VF_2_3_D1] = {
-		.fmt = { .pix = { .width = 480, .height = 576 }, }, },
+		.fmt.pix.width = 480, .fmt.pix.height = 576 },
 	[SAA6752HS_VF_1_2_D1] = {
-		.fmt = { .pix = { .width = 352, .height = 576 }, }, },
+		.fmt.pix.width = 352, .fmt.pix.height = 576 },
 	[SAA6752HS_VF_SIF] = {
-		.fmt = { .pix = { .width = 352, .height = 288 }, }, },
+		.fmt.pix.width = 352, .fmt.pix.height = 288 },
 	[SAA6752HS_VF_UNKNOWN] = {
-		.fmt = { .pix = { .width = 0, .height = 0 }, }, },
+		.fmt.pix.width = 0, .fmt.pix.height = 0},
 };
 
 struct saa6752hs_state {
diff -u linux-2.6.12/include/media/tveeprom.h linux/include/media/tveeprom.h
--- linux-2.6.12/include/media/tveeprom.h	2005-05-25 00:31:20.000000000 -0300
+++ linux/include/media/tveeprom.h	2005-06-12 01:22:34.000000000 -0300
@@ -1,3 +1,7 @@
+/*
+ * $Id: tveeprom.h,v 1.2 2005/06/12 04:19:19 mchehab Exp $
+ */
+
 struct tveeprom {
 	u32 has_radio;
 
diff -u linux-2.6.12/drivers/media/video/tveeprom.c linux/drivers/media/video/tveeprom.c
--- linux-2.6.12/drivers/media/video/tveeprom.c	2005-06-07 15:39:55.000000000 -0300
+++ linux/drivers/media/video/tveeprom.c	2005-06-12 01:22:34.000000000 -0300
@@ -75,7 +75,7 @@
 	{ 0x00000007, "PAL(B/G)" },
 	{ 0x00001000, "NTSC(M)" },
 	{ 0x00000010, "PAL(I)" },
-	{ 0x00400000, "SECAM(L/Lï¿½)" },
+	{ 0x00400000, "SECAM(L/L´)" },
 	{ 0x00000e00, "PAL(D/K)" },
 	{ 0x03000000, "ATSC Digital" },
 };
@@ -482,6 +482,7 @@
 	0xa0 >> 1,
 	I2C_CLIENT_END,
 };
+static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
 I2C_CLIENT_INSMOD;
 
 struct i2c_driver i2c_driver_tveeprom;
diff -u linux-2.6.12/drivers/media/video/v4l1-compat.c linux/drivers/media/video/v4l1-compat.c
--- linux-2.6.12/drivers/media/video/v4l1-compat.c	2005-05-25 00:31:20.000000000 -0300
+++ linux/drivers/media/video/v4l1-compat.c	2005-06-12 01:22:34.000000000 -0300
@@ -1,4 +1,6 @@
 /*
+ * $Id: v4l1-compat.c,v 1.9 2005/06/12 04:19:19 mchehab Exp $
+ *
  *	Video for Linux Two
  *	Backward Compatibility Layer
  *
@@ -15,14 +17,11 @@
  *
  */
 
-#ifndef __KERNEL__
-#define __KERNEL__
-#endif
-
 #include <linux/config.h>
 
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
@@ -787,12 +786,15 @@
 		    !(qctrl2.flags & V4L2_CTRL_FLAG_DISABLED))
 			aud->step = qctrl2.step;
 		aud->mode = 0;
+
+		memset(&tun2,0,sizeof(tun2));
 		err = drv(inode, file, VIDIOC_G_TUNER, &tun2);
 		if (err < 0) {
 			dprintk("VIDIOCGAUDIO / VIDIOC_G_TUNER: %d\n",err);
 			err = 0;
 			break;
 		}
+		
 		if (tun2.rxsubchans & V4L2_TUNER_SUB_LANG2)
 			aud->mode = VIDEO_SOUND_LANG1 | VIDEO_SOUND_LANG2;
 		else if (tun2.rxsubchans & V4L2_TUNER_SUB_STEREO)

--------------050808020807050808060907--
