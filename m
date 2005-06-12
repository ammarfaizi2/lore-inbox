Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261874AbVFLEiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbVFLEiL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 00:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261871AbVFLEiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 00:38:10 -0400
Received: from smtp4.brturbo.com.br ([200.199.201.180]:49337 "EHLO
	smtp4.brturbo.com.br") by vger.kernel.org with ESMTP
	id S261876AbVFLEd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 00:33:29 -0400
Message-ID: <42ABBB1E.1020208@brturbo.com.br>
Date: Sun, 12 Jun 2005 01:33:34 -0300
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: pt-br, pt, es, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux and Kernel Video <video4linux-list@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH1/5] Synchronize patch for CX88 cards
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------010303030203010305090104"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010303030203010305090104
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

This patch adds support for various CX88 cards and allows specifying
card addresses.

Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: cybercide@f2s.com <cybercide@f2s.com>
Signed-off-by: Catalin Climov <catalin@climov.com>
Signed-off-by: Nickolay V Shmyrev <nshmyrev@yandex.ru>


--------------010303030203010305090104
Content-Type: text/x-patch;
 name="patch01.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch01.patch"

diff -u linux-2.6.12/drivers/media/video/ir-kbd-gpio.c linux/drivers/media/video/ir-kbd-gpio.c
--- linux-2.6.12/drivers/media/video/ir-kbd-gpio.c	2005-06-07 15:39:55.000000000 -0300
+++ linux/drivers/media/video/ir-kbd-gpio.c	2005-06-12 01:20:10.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: ir-kbd-gpio.c,v 1.12 2005/02/22 12:28:40 kraxel Exp $
+ * $Id: ir-kbd-gpio.c,v 1.13 2005/05/15 19:01:26 mchehab Exp $
  *
  * Copyright (c) 2003 Gerd Knorr
  * Copyright (c) 2003 Pavel Machek
diff -u linux-2.6.12/drivers/media/video/cx88/cx88.h linux/drivers/media/video/cx88/cx88.h
--- linux-2.6.12/drivers/media/video/cx88/cx88.h	2005-06-07 15:39:55.000000000 -0300
+++ linux/drivers/media/video/cx88/cx88.h	2005-06-12 01:20:10.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88.h,v 1.56 2005/03/04 09:12:23 kraxel Exp $
+ * $Id: cx88.h,v 1.62 2005/06/12 04:19:19 mchehab Exp $
  *
  * v4l2 device driver for cx2388x based TV cards
  *
@@ -64,6 +64,13 @@
 #define SHADOW_AUD_BAL_CTL           2
 #define SHADOW_MAX                   2
 
+/* FM Radio deemphasis type */
+enum cx88_deemph_type {
+	FM_NO_DEEMPH = 0,
+	FM_DEEMPH_50,
+	FM_DEEMPH_75
+};
+
 /* ----------------------------------------------------------- */
 /* tv norms                                                    */
 
@@ -163,7 +170,7 @@
 #define CX88_BOARD_DIGITALLOGIC_MEC	       25
 #define CX88_BOARD_IODATA_GVBCTV7E         26
 #define CX88_BOARD_PIXELVIEW_PLAYTV_ULTRA_PRO 27
-#define CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD_T   28
+#define CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD_T  28
 
 enum cx88_itype {
 	CX88_VMUX_COMPOSITE1 = 1,
@@ -187,6 +194,9 @@
 struct cx88_board {
 	char                    *name;
 	unsigned int            tuner_type;
+	unsigned int		radio_type;
+	unsigned char		tuner_addr;
+	unsigned char		radio_addr;
 	int                     tda9887_conf;
 	struct cx88_input       input[8];
 	struct cx88_input       radio;
@@ -257,6 +267,9 @@
 	/* config info -- analog */
 	unsigned int               board;
 	unsigned int               tuner_type;
+	unsigned int               radio_type;
+	unsigned char              tuner_addr;
+	unsigned char              radio_addr;
 	unsigned int               tda9887_conf;
 	unsigned int               has_radio;
 
@@ -422,6 +435,7 @@
 /* ----------------------------------------------------------- */
 /* cx88-core.c                                                 */
 
+extern char *cx88_pci_irqs[32];
 extern char *cx88_vid_irqs[32];
 extern char *cx88_mpeg_irqs[32];
 extern void cx88_print_irqbits(char *name, char *tag, char **strings,
@@ -473,6 +487,11 @@
 /* cx88-vbi.c                                                  */
 
 void cx8800_vbi_fmt(struct cx8800_dev *dev, struct v4l2_format *f);
+/*
+int cx8800_start_vbi_dma(struct cx8800_dev    *dev,
+			 struct cx88_dmaqueue *q,
+			 struct cx88_buffer   *buf);
+*/
 int cx8800_stop_vbi_dma(struct cx8800_dev *dev);
 int cx8800_restart_vbi_queue(struct cx8800_dev    *dev,
 			     struct cx88_dmaqueue *q);
diff -u linux-2.6.12/drivers/media/video/cx88/cx88-reg.h linux/drivers/media/video/cx88/cx88-reg.h
--- linux-2.6.12/drivers/media/video/cx88/cx88-reg.h	2005-05-25 00:31:20.000000000 -0300
+++ linux/drivers/media/video/cx88/cx88-reg.h	2005-06-12 01:20:10.000000000 -0300
@@ -1,5 +1,5 @@
 /*
-    $Id: cx88-reg.h,v 1.6 2004/10/13 10:39:00 kraxel Exp $
+    $Id: cx88-reg.h,v 1.7 2005/06/03 13:31:51 mchehab Exp $
 
     cx88x-hw.h - CX2388x register offsets
 
@@ -397,6 +397,7 @@
 #define AUD_RATE_ADJ4            0x3205e4
 #define AUD_RATE_ADJ5            0x3205e8
 #define AUD_APB_IN_RATE_ADJ      0x3205ec
+#define AUD_I2SCNTL              0x3205ec
 #define AUD_PHASE_FIX_CTL        0x3205f0
 #define AUD_PLL_PRESCALE         0x320600
 #define AUD_PLL_DDS              0x320604
diff -u linux-2.6.12/drivers/media/video/cx88/cx88-cards.c linux/drivers/media/video/cx88/cx88-cards.c
--- linux-2.6.12/drivers/media/video/cx88/cx88-cards.c	2005-06-07 15:39:55.000000000 -0300
+++ linux/drivers/media/video/cx88/cx88-cards.c	2005-06-12 01:20:10.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88-cards.c,v 1.66 2005/03/04 09:12:23 kraxel Exp $
+ * $Id: cx88-cards.c,v 1.76 2005/06/08 01:28:09 mchehab Exp $
  *
  * device driver for Conexant 2388x based TV cards
  * card-specific stuff.
@@ -35,6 +35,9 @@
 	[CX88_BOARD_UNKNOWN] = {
 		.name		= "UNKNOWN/GENERIC",
 		.tuner_type     = UNSET,
+		.radio_type     = UNSET,
+		.tuner_addr	= ADDR_UNSET,
+		.radio_addr	= ADDR_UNSET,
 		.input          = {{
 			.type   = CX88_VMUX_COMPOSITE1,
 			.vmux   = 0,
@@ -52,6 +55,9 @@
 	[CX88_BOARD_HAUPPAUGE] = {
 		.name		= "Hauppauge WinTV 34xxx models",
 		.tuner_type     = UNSET,
+		.radio_type     = UNSET,
+		.tuner_addr	= ADDR_UNSET,
+		.radio_addr	= ADDR_UNSET,
 		.tda9887_conf   = TDA9887_PRESENT,
 		.input          = {{
 			.type   = CX88_VMUX_TELEVISION,
@@ -78,6 +84,9 @@
 	[CX88_BOARD_GDI] = {
 		.name		= "GDI Black Gold",
 		.tuner_type     = UNSET,
+		.radio_type     = UNSET,
+		.tuner_addr	= ADDR_UNSET,
+		.radio_addr	= ADDR_UNSET,
 		.input          = {{
 			.type   = CX88_VMUX_TELEVISION,
 			.vmux   = 0,
@@ -85,7 +94,10 @@
 	},
 	[CX88_BOARD_PIXELVIEW] = {
 		.name           = "PixelView",
-		.tuner_type     = 5,
+		.tuner_type     = TUNER_PHILIPS_PAL,
+		.radio_type     = UNSET,
+		.tuner_addr	= ADDR_UNSET,
+		.radio_addr	= ADDR_UNSET,
 		.input          = {{
 			.type   = CX88_VMUX_TELEVISION,
 			.vmux   = 0,
@@ -104,7 +116,10 @@
 	},
 	[CX88_BOARD_ATI_WONDER_PRO] = {
 		.name           = "ATI TV Wonder Pro",
-		.tuner_type     = 44,
+		.tuner_type     = TUNER_PHILIPS_4IN1,
+		.radio_type     = UNSET,
+		.tuner_addr	= ADDR_UNSET,
+		.radio_addr	= ADDR_UNSET,
 		.tda9887_conf   = TDA9887_PRESENT | TDA9887_INTERCARRIER,
 		.input          = {{
 			.type   = CX88_VMUX_TELEVISION,
@@ -122,7 +137,10 @@
 	},
         [CX88_BOARD_WINFAST2000XP_EXPERT] = {
                 .name           = "Leadtek Winfast 2000XP Expert",
-                .tuner_type     = 44,
+                .tuner_type     = TUNER_PHILIPS_4IN1,
+		.radio_type     = UNSET,
+		.tuner_addr	= ADDR_UNSET,
+		.radio_addr	= ADDR_UNSET,
 		.tda9887_conf   = TDA9887_PRESENT,
                 .input          = {{
                         .type   = CX88_VMUX_TELEVISION,
@@ -156,7 +174,10 @@
         },
 	[CX88_BOARD_AVERTV_303] = {
 		.name           = "AverTV Studio 303 (M126)",
-		.tuner_type     = 38,
+		.tuner_type     = TUNER_PHILIPS_FM1216ME_MK3,
+		.radio_type     = UNSET,
+		.tuner_addr	= ADDR_UNSET,
+		.radio_addr	= ADDR_UNSET,
 		.tda9887_conf   = TDA9887_PRESENT,
 		.input          = {{
 			.type   = CX88_VMUX_TELEVISION,
@@ -179,7 +200,10 @@
 		// added gpio values thanks to Michal
 		// values for PAL from DScaler
 		.name           = "MSI TV-@nywhere Master",
-		.tuner_type     = 33,
+		.tuner_type     = TUNER_MT2032,
+		.radio_type     = UNSET,
+		.tuner_addr	= ADDR_UNSET,
+		.radio_addr	= ADDR_UNSET,
 		.tda9887_conf	= TDA9887_PRESENT,
 		.input          = {{
 			.type   = CX88_VMUX_TELEVISION,
@@ -206,7 +230,10 @@
 	},
 	[CX88_BOARD_WINFAST_DV2000] = {
                 .name           = "Leadtek Winfast DV2000",
-                .tuner_type     = 38,
+                .tuner_type     = TUNER_PHILIPS_FM1216ME_MK3,
+		.radio_type     = UNSET,
+		.tuner_addr	= ADDR_UNSET,
+		.radio_addr	= ADDR_UNSET,
 		.tda9887_conf   = TDA9887_PRESENT,
                 .input          = {{
                         .type   = CX88_VMUX_TELEVISION,
@@ -239,34 +266,40 @@
 			.gpio3  = 0x02000000,
 		 },
         },
-        [CX88_BOARD_LEADTEK_PVR2000] = {
+	[CX88_BOARD_LEADTEK_PVR2000] = {
 		// gpio values for PAL version from regspy by DScaler
-                .name           = "Leadtek PVR 2000",
-                .tuner_type     = 38,
+		.name           = "Leadtek PVR 2000",
+		.tuner_type     = TUNER_PHILIPS_FM1216ME_MK3,
+		.radio_type     = UNSET,
+		.tuner_addr	= ADDR_UNSET,
+		.radio_addr	= ADDR_UNSET,
 		.tda9887_conf   = TDA9887_PRESENT,
-                .input          = {{
-                        .type   = CX88_VMUX_TELEVISION,
-                        .vmux   = 0,
-                        .gpio0  = 0x0000bde6,
-                },{
-                        .type   = CX88_VMUX_COMPOSITE1,
-                        .vmux   = 1,
-                        .gpio0  = 0x0000bde6,
-                },{
-                        .type   = CX88_VMUX_SVIDEO,
-                        .vmux   = 2,
-                        .gpio0  = 0x0000bde6,
-                }},
-                .radio = {
-                        .type   = CX88_RADIO,
-                        .gpio0  = 0x0000bd62,
-                },
+		.input          = {{
+			.type   = CX88_VMUX_TELEVISION,
+			.vmux   = 0,
+			.gpio0  = 0x0000bde2,
+		},{
+			.type   = CX88_VMUX_COMPOSITE1,
+			.vmux   = 1,
+			.gpio0  = 0x0000bde6,
+		},{
+			.type   = CX88_VMUX_SVIDEO,
+			.vmux   = 2,
+			.gpio0  = 0x0000bde6,
+		}},
+		.radio = {
+			.type   = CX88_RADIO,
+			.gpio0  = 0x0000bd62,
+		},
 		.blackbird = 1,
-        },
+	},
 	[CX88_BOARD_IODATA_GVVCP3PCI] = {
  		.name		= "IODATA GV-VCP3/PCI",
 		.tuner_type     = TUNER_ABSENT,
- 		.input          = {{
+ 		.radio_type     = UNSET,
+		.tuner_addr	= ADDR_UNSET,
+		.radio_addr	= ADDR_UNSET,
+		.input          = {{
  			.type   = CX88_VMUX_COMPOSITE1,
  			.vmux   = 0,
  		},{
@@ -279,7 +312,10 @@
  	},
 	[CX88_BOARD_PROLINK_PLAYTVPVR] = {
                 .name           = "Prolink PlayTV PVR",
-                .tuner_type     = 43,
+                .tuner_type     = TUNER_PHILIPS_FM1236_MK3,
+		.radio_type     = UNSET,
+		.tuner_addr	= ADDR_UNSET,
+		.radio_addr	= ADDR_UNSET,
 		.tda9887_conf	= TDA9887_PRESENT,
 		.input          = {{
 			.type   = CX88_VMUX_TELEVISION,
@@ -301,8 +337,11 @@
 	},
 	[CX88_BOARD_ASUS_PVR_416] = {
 		.name		= "ASUS PVR-416",
-		.tuner_type     = 43,
-                .tda9887_conf   = TDA9887_PRESENT,
+		.tuner_type     = TUNER_PHILIPS_FM1236_MK3,
+		.radio_type     = UNSET,
+		.tuner_addr	= ADDR_UNSET,
+		.radio_addr	= ADDR_UNSET,
+		.tda9887_conf   = TDA9887_PRESENT,
 		.input          = {{
 			.type   = CX88_VMUX_TELEVISION,
 			.vmux   = 0,
@@ -320,7 +359,10 @@
 	},
 	[CX88_BOARD_MSI_TVANYWHERE] = {
 		.name           = "MSI TV-@nywhere",
-		.tuner_type     = 33,
+		.tuner_type     = TUNER_MT2032,
+		.radio_type     = UNSET,
+		.tuner_addr	= ADDR_UNSET,
+		.radio_addr	= ADDR_UNSET,
 		.tda9887_conf   = TDA9887_PRESENT,
 		.input          = {{
 			.type   = CX88_VMUX_TELEVISION,
@@ -342,6 +384,9 @@
         [CX88_BOARD_KWORLD_DVB_T] = {
                 .name           = "KWorld/VStream XPert DVB-T",
 		.tuner_type     = TUNER_ABSENT,
+		.radio_type     = UNSET,
+		.tuner_addr	= ADDR_UNSET,
+		.radio_addr	= ADDR_UNSET,
                 .input          = {{
                         .type   = CX88_VMUX_COMPOSITE1,
                         .vmux   = 1,
@@ -358,6 +403,9 @@
 	[CX88_BOARD_DVICO_FUSIONHDTV_DVB_T1] = {
 		.name           = "DVICO FusionHDTV DVB-T1",
 		.tuner_type     = TUNER_ABSENT, /* No analog tuner */
+		.radio_type     = UNSET,
+		.tuner_addr	= ADDR_UNSET,
+		.radio_addr	= ADDR_UNSET,
 		.input          = {{
 			.type   = CX88_VMUX_COMPOSITE1,
 			.vmux   = 1,
@@ -371,7 +419,10 @@
 	},
 	[CX88_BOARD_KWORLD_LTV883] = {
 		.name           = "KWorld LTV883RF",
-                .tuner_type     = 48,
+		.tuner_type     = TUNER_TNF_8831BGFF,
+		.radio_type     = UNSET,
+		.tuner_addr	= ADDR_UNSET,
+		.radio_addr	= ADDR_UNSET,
                 .input          = {{
                         .type   = CX88_VMUX_TELEVISION,
                         .vmux   = 0,
@@ -397,6 +448,9 @@
 	[CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD] = {
 		.name		= "DViCO - FusionHDTV 3 Gold",
 		.tuner_type     = TUNER_MICROTUNE_4042FI5,
+		.radio_type     = UNSET,
+		.tuner_addr	= ADDR_UNSET,
+		.radio_addr	= ADDR_UNSET,
 		/*
 		   GPIO[0] resets DT3302 DTV receiver
 		    0 - reset asserted
@@ -429,31 +483,12 @@
 			.gpio0	= 0x0f00,
 		}},
 	},
-        [CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD_T] = {
-                .name           = "DViCO - FusionHDTV 3 Gold-T",
-                .tuner_type     = 52, /* Thomson DDT 7611 ATSC/NTSC */
-               /*  See DViCO FusionHDTV 3 Gold for GPIO documentation.  */
-                .input          = {{
-                        .type   = CX88_VMUX_TELEVISION,
-                        .vmux   = 0,
-                        .gpio0  = 0x0f0d,
-                },{
-                        .type   = CX88_VMUX_CABLE,
-                        .vmux   = 0,
-                        .gpio0  = 0x0f05,
-                },{
-                        .type   = CX88_VMUX_COMPOSITE1,
-                        .vmux   = 1,
-                        .gpio0  = 0x0f00,
-                },{
-                        .type   = CX88_VMUX_SVIDEO,
-                        .vmux   = 2,
-                        .gpio0  = 0x0f00,
-                }},
-        },
         [CX88_BOARD_HAUPPAUGE_DVB_T1] = {
                 .name           = "Hauppauge Nova-T DVB-T",
 		.tuner_type     = TUNER_ABSENT,
+		.radio_type     = UNSET,
+		.tuner_addr	= ADDR_UNSET,
+		.radio_addr	= ADDR_UNSET,
                 .input          = {{
                         .type   = CX88_VMUX_DVB,
                         .vmux   = 0,
@@ -463,6 +498,9 @@
         [CX88_BOARD_CONEXANT_DVB_T1] = {
 		.name           = "Conexant DVB-T reference design",
 		.tuner_type     = TUNER_ABSENT,
+		.radio_type     = UNSET,
+		.tuner_addr	= ADDR_UNSET,
+		.radio_addr	= ADDR_UNSET,
                 .input          = {{
                         .type   = CX88_VMUX_DVB,
                         .vmux   = 0,
@@ -472,6 +510,9 @@
 	[CX88_BOARD_PROVIDEO_PV259] = {
 		.name		= "Provideo PV259",
 		.tuner_type     = TUNER_PHILIPS_FQ1216ME,
+		.radio_type     = UNSET,
+		.tuner_addr	= ADDR_UNSET,
+		.radio_addr	= ADDR_UNSET,
 		.input          = {{
 			.type   = CX88_VMUX_TELEVISION,
 			.vmux   = 0,
@@ -481,6 +522,9 @@
 	[CX88_BOARD_DVICO_FUSIONHDTV_DVB_T_PLUS] = {
 		.name           = "DVICO FusionHDTV DVB-T Plus",
 		.tuner_type     = TUNER_ABSENT, /* No analog tuner */
+		.radio_type     = UNSET,
+		.tuner_addr	= ADDR_UNSET,
+		.radio_addr	= ADDR_UNSET,
 		.input          = {{
 			.type   = CX88_VMUX_COMPOSITE1,
 			.vmux   = 1,
@@ -495,6 +539,9 @@
 	[CX88_BOARD_DNTV_LIVE_DVB_T] = {
 		.name	        = "digitalnow DNTV Live! DVB-T",
 		.tuner_type     = TUNER_ABSENT,
+		.radio_type     = UNSET,
+		.tuner_addr	= ADDR_UNSET,
+		.radio_addr	= ADDR_UNSET,
 		.input	        = {{
 			.type   = CX88_VMUX_COMPOSITE1,
 			.vmux   = 1,
@@ -511,6 +558,9 @@
 	[CX88_BOARD_PCHDTV_HD3000] = {
 		.name           = "pcHDTV HD3000 HDTV",
 		.tuner_type     = TUNER_THOMSON_DTT7610,
+		.radio_type     = UNSET,
+		.tuner_addr	= ADDR_UNSET,
+		.radio_addr	= ADDR_UNSET,
 		.input          = {{
 			.type   = CX88_VMUX_TELEVISION,
 			.vmux   = 0,
@@ -546,8 +596,11 @@
 	[CX88_BOARD_HAUPPAUGE_ROSLYN] = {
 		// entry added by Kaustubh D. Bhalerao <bhalerao.1@osu.edu>
 		// GPIO values obtained from regspy, courtesy Sean Covel
-		.name        = "Hauppauge WinTV 28xxx (Roslyn) models",
-		.tuner_type  = UNSET,
+		.name           = "Hauppauge WinTV 28xxx (Roslyn) models",
+		.tuner_type     = UNSET,
+		.radio_type     = UNSET,
+		.tuner_addr	= ADDR_UNSET,
+		.radio_addr	= ADDR_UNSET,
 		.input          = {{
 			.type   = CX88_VMUX_TELEVISION,
 			.vmux   = 0,
@@ -575,33 +628,37 @@
 		.blackbird = 1,
 	},
 	[CX88_BOARD_DIGITALLOGIC_MEC] = {
-		/* params copied over from Leadtek PVR 2000 */
 		.name           = "Digital-Logic MICROSPACE Entertainment Center (MEC)",
-		/* not sure yet about the tuner type */
-		.tuner_type     = 38,
+		.tuner_type     = TUNER_PHILIPS_FM1216ME_MK3,
+		.radio_type     = UNSET,
+		.tuner_addr	= ADDR_UNSET,
+		.radio_addr	= ADDR_UNSET,
 		.tda9887_conf   = TDA9887_PRESENT,
 		.input          = {{
 			.type   = CX88_VMUX_TELEVISION,
 			.vmux   = 0,
-			.gpio0  = 0x0000bde6,
+			.gpio0  = 0x00009d80,
 		},{
 			.type   = CX88_VMUX_COMPOSITE1,
 			.vmux   = 1,
-			.gpio0  = 0x0000bde6,
+			.gpio0  = 0x00009d76,
 		},{
 			.type   = CX88_VMUX_SVIDEO,
 			.vmux   = 2,
-			.gpio0  = 0x0000bde6,
+			.gpio0  = 0x00009d76,
 		}},
 		.radio = {
 			.type   = CX88_RADIO,
-			.gpio0  = 0x0000bd62,
+			.gpio0  = 0x00009d00,
 		},
 		.blackbird = 1,
 	},
 	[CX88_BOARD_IODATA_GVBCTV7E] = {
 		.name           = "IODATA GV/BCTV7E",
 		.tuner_type     = TUNER_PHILIPS_FQ1286,
+		.radio_type     = UNSET,
+		.tuner_addr	= ADDR_UNSET,
+		.radio_addr	= ADDR_UNSET,
 		.tda9887_conf   = TDA9887_PRESENT,
 		.input          = {{
 			.type   = CX88_VMUX_TELEVISION,
@@ -619,25 +676,54 @@
 	},
 	[CX88_BOARD_PIXELVIEW_PLAYTV_ULTRA_PRO] = {
 		.name           = "PixelView PlayTV Ultra Pro (Stereo)",
-		.tuner_type     = 38,
+		/* May be also TUNER_YMEC_TVF_5533MF for NTSC/M or PAL/M */
+		.tuner_type     = TUNER_PHILIPS_FM1216ME_MK3,
+		.radio_type     = TUNER_TEA5767,
+		.tuner_addr	= 0xc2>>1,
+		.radio_addr	= 0xc0>>1,
 		.input          = {{
 			.type   = CX88_VMUX_TELEVISION,
 			.vmux   = 0,
-			.gpio0  = 0xbf61,  // internal decoder
+			.gpio0  = 0xbf61,  /* internal decoder */
 		},{
 			.type   = CX88_VMUX_COMPOSITE1,
 			.vmux   = 1,
-			.gpio0  = 0xbf63,
+			.gpio0	= 0xbf63,
 		},{
 			.type   = CX88_VMUX_SVIDEO,
 			.vmux   = 2,
-			.gpio0  = 0xbf63,
+			.gpio0	= 0xbf63,
 		}},
 		.radio = {
-			.type  = CX88_RADIO,
-			.gpio0 = 0xbf60,
-		},
+			 .type  = CX88_RADIO,
+			 .gpio0 = 0xbf60,
+		 },
 	},
+        [CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD_T] = {
+                .name           = "DViCO - FusionHDTV 3 Gold-T",
+		.tuner_type     = TUNER_THOMSON_DTT7611,
+		.radio_type     = UNSET,
+		.tuner_addr	= ADDR_UNSET,
+		.radio_addr	= ADDR_UNSET,
+		/*  See DViCO FusionHDTV 3 Gold for GPIO documentation.  */
+                .input          = {{
+                        .type   = CX88_VMUX_TELEVISION,
+                        .vmux   = 0,
+                        .gpio0  = 0x0f0d,
+                },{
+                        .type   = CX88_VMUX_CABLE,
+                        .vmux   = 0,
+                        .gpio0  = 0x0f05,
+                },{
+                        .type   = CX88_VMUX_COMPOSITE1,
+                        .vmux   = 1,
+                        .gpio0  = 0x0f00,
+                },{
+                        .type   = CX88_VMUX_SVIDEO,
+                        .vmux   = 2,
+                        .gpio0  = 0x0f00,
+                }},
+        },
 };
 const unsigned int cx88_bcount = ARRAY_SIZE(cx88_boards);
 
@@ -976,4 +1062,5 @@
  * Local variables:
  * c-basic-offset: 8
  * End:
+ * kate: eol "unix"; indent-width 3; remove-trailing-space on; replace-trailing-space-save on; tab-width 8; replace-tabs off; space-indent off; mixed-indent off
  */
diff -u linux-2.6.12/drivers/media/video/cx88/cx88-core.c linux/drivers/media/video/cx88/cx88-core.c
--- linux-2.6.12/drivers/media/video/cx88/cx88-core.c	2005-06-07 15:39:55.000000000 -0300
+++ linux/drivers/media/video/cx88/cx88-core.c	2005-06-12 01:20:10.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88-core.c,v 1.24 2005/01/19 12:01:55 kraxel Exp $
+ * $Id: cx88-core.c,v 1.28 2005/06/12 04:19:19 mchehab Exp $
  *
  * device driver for Conexant 2388x based TV cards
  * driver core
@@ -51,12 +51,15 @@
 MODULE_PARM_DESC(latency,"pci latency timer");
 
 static unsigned int tuner[] = {[0 ... (CX88_MAXBOARDS - 1)] = UNSET };
+static unsigned int radio[] = {[0 ... (CX88_MAXBOARDS - 1)] = UNSET };
 static unsigned int card[]  = {[0 ... (CX88_MAXBOARDS - 1)] = UNSET };
 
 module_param_array(tuner, int, NULL, 0444);
+module_param_array(radio, int, NULL, 0444);
 module_param_array(card,  int, NULL, 0444);
 
 MODULE_PARM_DESC(tuner,"tuner type");
+MODULE_PARM_DESC(radio,"radio tuner type");
 MODULE_PARM_DESC(card,"card type");
 
 static unsigned int nicam = 0;
@@ -429,7 +432,7 @@
 /* ------------------------------------------------------------------ */
 /* debug helper code                                                  */
 
-static int cx88_risc_decode(u32 risc)
+int cx88_risc_decode(u32 risc)
 {
 	static char *instr[16] = {
 		[ RISC_SYNC    >> 28 ] = "sync",
@@ -1173,8 +1176,20 @@
 	       "insmod option" : "autodetected");
 
 	core->tuner_type = tuner[core->nr];
+	core->radio_type = radio[core->nr];
 	if (UNSET == core->tuner_type)
 		core->tuner_type = cx88_boards[core->board].tuner_type;
+	if (UNSET == core->radio_type)
+		core->radio_type = cx88_boards[core->board].radio_type;
+	if (!core->tuner_addr)
+		core->tuner_addr = cx88_boards[core->board].tuner_addr;
+	if (!core->radio_addr)
+		core->radio_addr = cx88_boards[core->board].radio_addr;
+
+        printk(KERN_INFO "TV tuner %d at 0x%02x, Radio tuner %d at 0x%02x\n",
+		core->tuner_type, core->tuner_addr<<1, 
+		core->radio_type, core->radio_addr<<1);
+
 	core->tda9887_conf = cx88_boards[core->board].tda9887_conf;
 
 	/* init hardware */
diff -u linux-2.6.12/drivers/media/video/cx88/cx88-i2c.c linux/drivers/media/video/cx88/cx88-i2c.c
--- linux-2.6.12/drivers/media/video/cx88/cx88-i2c.c	2005-06-07 15:38:09.000000000 -0300
+++ linux/drivers/media/video/cx88/cx88-i2c.c	2005-06-12 01:20:10.000000000 -0300
@@ -1,5 +1,5 @@
 /*
-    $Id: cx88-i2c.c,v 1.20 2005/02/15 15:59:35 kraxel Exp $
+    $Id: cx88-i2c.c,v 1.23 2005/06/12 04:19:19 mchehab Exp $
 
     cx88-i2c.c  --  all the i2c code is here
 
@@ -91,6 +91,7 @@
 
 static int attach_inform(struct i2c_client *client)
 {
+        struct tuner_addr tun_addr;
 	struct cx88_core *core = i2c_get_adapdata(client->adapter);
 
 	dprintk(1, "i2c attach [addr=0x%x,client=%s]\n",
@@ -98,8 +99,19 @@
 	if (!client->driver->command)
 		return 0;
 
-	if (core->tuner_type != UNSET)
-		client->driver->command(client, TUNER_SET_TYPE, &core->tuner_type);
+        if (core->radio_type != UNSET) {
+                tun_addr.v4l2_tuner = V4L2_TUNER_RADIO;
+                tun_addr.type = core->radio_type;
+                tun_addr.addr = core->radio_addr;
+                client->driver->command(client,TUNER_SET_TYPE_ADDR, &tun_addr);
+        }
+        if (core->tuner_type != UNSET) {
+                tun_addr.v4l2_tuner = V4L2_TUNER_ANALOG_TV;
+                tun_addr.type = core->tuner_type;
+                tun_addr.addr = core->tuner_addr;
+                client->driver->command(client,TUNER_SET_TYPE_ADDR, &tun_addr);
+        }
+
 	if (core->tda9887_conf)
 		client->driver->command(client, TDA9887_SET_CONFIG, &core->tda9887_conf);
 	return 0;
diff -u linux-2.6.12/drivers/media/video/cx88/cx88-tvaudio.c linux/drivers/media/video/cx88/cx88-tvaudio.c
--- linux-2.6.12/drivers/media/video/cx88/cx88-tvaudio.c	2005-06-07 15:38:09.000000000 -0300
+++ linux/drivers/media/video/cx88/cx88-tvaudio.c	2005-06-12 01:20:10.000000000 -0300
@@ -1,5 +1,5 @@
 /*
-    $Id: cx88-tvaudio.c,v 1.34 2005/03/07 16:10:51 kraxel Exp $
+    $Id: cx88-tvaudio.c,v 1.36 2005/06/05 05:53:45 mchehab Exp $
 
     cx88x-audio.c - Conexant CX23880/23881 audio downstream driver driver
 
@@ -127,7 +127,8 @@
 	cx_write(AUD_VOL_CTL,       (1 << 6));
 
 	//  increase level of input by 12dB
-	cx_write(AUD_AFE_12DB_EN,   0x0001);
+//	cx_write(AUD_AFE_12DB_EN,   0x0001);
+	cx_write(AUD_AFE_12DB_EN,   0x0000);
 
 	// start programming
 	cx_write(AUD_CTL,           0x0000);
@@ -143,9 +144,15 @@
 	u32 volume;
 
 	if (cx88_boards[core->board].blackbird) {
+		// sets sound input from external adc
+		cx_set(AUD_CTL, EN_I2SIN_ENABLE);
+		//cx_write(AUD_I2SINPUTCNTL, 0);
+		cx_write(AUD_I2SINPUTCNTL, 4);
+		cx_write(AUD_BAUDRATE, 1);
 		// 'pass-thru mode': this enables the i2s output to the mpeg encoder
-		cx_set(AUD_CTL, 0x2000);
+		cx_set(AUD_CTL, EN_I2SOUT_ENABLE);
 		cx_write(AUD_I2SOUTPUTCNTL, 1);
+		cx_write(AUD_I2SCNTL, 0);
 		//cx_write(AUD_APB_IN_RATE_ADJ, 0);
 	}
 
@@ -707,50 +714,65 @@
 	set_audio_finish(core);
 }
 
-static void set_audio_standard_FM(struct cx88_core *core)
+static void set_audio_standard_FM(struct cx88_core *core, enum cx88_deemph_type deemph)
 {
-#if 0 /* FIXME */
-	switch (dev->audio_properties.FM_deemphasis)
-	{
-		case WW_FM_DEEMPH_50:
-			//Set De-emphasis filter coefficients for 50 usec
-			cx_write(AUD_DEEMPH0_G0, 0x0C45);
-			cx_write(AUD_DEEMPH0_A0, 0x6262);
-			cx_write(AUD_DEEMPH0_B0, 0x1C29);
-			cx_write(AUD_DEEMPH0_A1, 0x3FC66);
-			cx_write(AUD_DEEMPH0_B1, 0x399A);
-
-			cx_write(AUD_DEEMPH1_G0, 0x0D80);
-			cx_write(AUD_DEEMPH1_A0, 0x6262);
-			cx_write(AUD_DEEMPH1_B0, 0x1C29);
-			cx_write(AUD_DEEMPH1_A1, 0x3FC66);
-			cx_write(AUD_DEEMPH1_B1, 0x399A);
+	static const struct rlist fm_deemph_50[] = {
+		{ AUD_DEEMPH0_G0,	0x0C45 },
+		{ AUD_DEEMPH0_A0,	0x6262 },
+		{ AUD_DEEMPH0_B0,	0x1C29 },
+		{ AUD_DEEMPH0_A1,	0x3FC66},
+		{ AUD_DEEMPH0_B1,	0x399A },
+
+		{ AUD_DEEMPH1_G0,	0x0D80 },
+		{ AUD_DEEMPH1_A0,	0x6262 },
+		{ AUD_DEEMPH1_B0,	0x1C29 },
+		{ AUD_DEEMPH1_A1,	0x3FC66},
+		{ AUD_DEEMPH1_B1,	0x399A},
 
-			break;
+		{ AUD_POLYPH80SCALEFAC,	0x0003},
+		{ /* end of list */ },
+	};
+	static const struct rlist fm_deemph_75[] = {
+		{ AUD_DEEMPH0_G0,	0x091B },
+		{ AUD_DEEMPH0_A0,	0x6B68 },
+		{ AUD_DEEMPH0_B0,	0x11EC },
+		{ AUD_DEEMPH0_A1,	0x3FC66},
+		{ AUD_DEEMPH0_B1,	0x399A },
+
+		{ AUD_DEEMPH1_G0,	0x0AA0 },
+		{ AUD_DEEMPH1_A0,	0x6B68 },
+		{ AUD_DEEMPH1_B0,	0x11EC },
+		{ AUD_DEEMPH1_A1,	0x3FC66},
+		{ AUD_DEEMPH1_B1,	0x399A},
 
-		case WW_FM_DEEMPH_75:
-			//Set De-emphasis filter coefficients for 75 usec
-			cx_write(AUD_DEEMPH0_G0, 0x91B );
-			cx_write(AUD_DEEMPH0_A0, 0x6B68);
-			cx_write(AUD_DEEMPH0_B0, 0x11EC);
-			cx_write(AUD_DEEMPH0_A1, 0x3FC66);
-			cx_write(AUD_DEEMPH0_B1, 0x399A);
-
-			cx_write(AUD_DEEMPH1_G0, 0xAA0 );
-			cx_write(AUD_DEEMPH1_A0, 0x6B68);
-			cx_write(AUD_DEEMPH1_B0, 0x11EC);
-			cx_write(AUD_DEEMPH1_A1, 0x3FC66);
-			cx_write(AUD_DEEMPH1_B1, 0x399A);
+		{ AUD_POLYPH80SCALEFAC,	0x0003},
+		{ /* end of list */ },
+	};
 
-			break;
-	}
-#endif
+	/* It is enough to leave default values? */
+	static const struct rlist fm_no_deemph[] = {
+
+		{ AUD_POLYPH80SCALEFAC,	0x0003},
+		{ /* end of list */ },
+	};
 
 	dprintk("%s (status: unknown)\n",__FUNCTION__);
 	set_audio_start(core, 0x0020, EN_FMRADIO_AUTO_STEREO);
 
-	// AB: 10/2/01: this register is not being reset appropriately on occasion.
-	cx_write(AUD_POLYPH80SCALEFAC,3);
+	switch (deemph)
+	{
+		case FM_NO_DEEMPH:
+			set_audio_registers(core, fm_no_deemph);
+			break;
+
+		case FM_DEEMPH_50:
+			set_audio_registers(core, fm_deemph_50);
+			break;
+
+		case FM_DEEMPH_75:
+			set_audio_registers(core, fm_deemph_75);
+			break;
+	}
 
 	set_audio_finish(core);
 }
@@ -778,7 +800,7 @@
 		set_audio_standard_EIAJ(core);
 		break;
 	case WW_FM:
-		set_audio_standard_FM(core);
+		set_audio_standard_FM(core,FM_NO_DEEMPH);
 		break;
 	case WW_SYSTEM_L_AM:
 		set_audio_standard_NICAM_L(core, 1);
@@ -1029,4 +1051,5 @@
  * Local variables:
  * c-basic-offset: 8
  * End:
+ * kate: eol "unix"; indent-width 3; remove-trailing-space on; replace-trailing-space-save on; tab-width 8; replace-tabs off; space-indent off; mixed-indent off
  */
diff -u linux-2.6.12/drivers/media/video/cx88/cx88-video.c linux/drivers/media/video/cx88/cx88-video.c
--- linux-2.6.12/drivers/media/video/cx88/cx88-video.c	2005-06-07 15:38:09.000000000 -0300
+++ linux/drivers/media/video/cx88/cx88-video.c	2005-06-12 01:20:10.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88-video.c,v 1.58 2005/03/07 15:58:05 kraxel Exp $
+ * $Id: cx88-video.c,v 1.63 2005/06/12 04:19:19 mchehab Exp $
  *
  * device driver for Conexant 2388x based TV cards
  * video4linux video interface
@@ -1187,9 +1187,24 @@
 		.id    = V4L2_CID_AUDIO_VOLUME,
 		.value = 0x3f,
 	};
+	static struct v4l2_control hue = {
+		.id    = V4L2_CID_HUE,
+		.value = 0x80,
+	};
+	static struct v4l2_control contrast = {
+		.id    = V4L2_CID_CONTRAST,
+		.value = 0x80,
+	};
+	static struct v4l2_control brightness = {
+		.id    = V4L2_CID_BRIGHTNESS,
+		.value = 0x80,
+	};
 
 	set_control(dev,&mute);
 	set_control(dev,&volume);
+	set_control(dev,&hue);
+	set_control(dev,&contrast);
+	set_control(dev,&brightness);
 }
 
 /* ------------------------------------------------------------------ */
@@ -1336,6 +1351,9 @@
 			V4L2_CAP_STREAMING     |
 			V4L2_CAP_VBI_CAPTURE   |
 #if 0
+			V4L2_TUNER_CAP_LOW     |
+#endif
+#if 0
 			V4L2_CAP_VIDEO_OVERLAY |
 #endif
 			0;
@@ -1696,7 +1714,11 @@
 			sizeof(cap->card));
 		sprintf(cap->bus_info,"PCI:%s", pci_name(dev->pci));
 		cap->version = CX88_VERSION_CODE;
-		cap->capabilities = V4L2_CAP_TUNER;
+		cap->capabilities = V4L2_CAP_TUNER
+#if 0
+				    | V4L2_TUNER_CAP_LOW
+#endif
+				    ;
 		return 0;
 	}
 	case VIDIOC_G_TUNER:
@@ -1992,6 +2014,7 @@
 {
 	struct cx8800_dev *dev;
 	struct cx88_core *core;
+	struct tuner_addr tun_addr;
 	int err;
 
 	dev = kmalloc(sizeof(*dev),GFP_KERNEL);
@@ -2065,8 +2088,19 @@
 		request_module("tuner");
 	if (core->tda9887_conf)
 		request_module("tda9887");
-	if (core->tuner_type != UNSET)
-		cx88_call_i2c_clients(dev->core,TUNER_SET_TYPE,&core->tuner_type);
+	if (core->radio_type != UNSET) {
+	        tun_addr.v4l2_tuner = V4L2_TUNER_RADIO;
+		tun_addr.type = core->radio_type;
+		tun_addr.addr = core->radio_addr;
+		cx88_call_i2c_clients(dev->core,TUNER_SET_TYPE_ADDR, &tun_addr);
+	}
+	if (core->tuner_type != UNSET) {
+	        tun_addr.v4l2_tuner = V4L2_TUNER_ANALOG_TV;
+		tun_addr.type = core->tuner_type;
+		tun_addr.addr = core->tuner_addr;
+		cx88_call_i2c_clients(dev->core,TUNER_SET_TYPE_ADDR, &tun_addr);
+	}
+
 	if (core->tda9887_conf)
 		cx88_call_i2c_clients(dev->core,TDA9887_SET_CONFIG,&core->tda9887_conf);
 
@@ -2162,7 +2196,7 @@
 
 static int cx8800_suspend(struct pci_dev *pci_dev, pm_message_t state)
 {
-        struct cx8800_dev *dev = pci_get_drvdata(pci_dev);
+	struct cx8800_dev *dev = pci_get_drvdata(pci_dev);
 	struct cx88_core *core = dev->core;
 
 	/* stop video+vbi capture */
@@ -2194,7 +2228,7 @@
 
 static int cx8800_resume(struct pci_dev *pci_dev)
 {
-        struct cx8800_dev *dev = pci_get_drvdata(pci_dev);
+	struct cx8800_dev *dev = pci_get_drvdata(pci_dev);
 	struct cx88_core *core = dev->core;
 
 	if (dev->state.disabled) {
@@ -2230,8 +2264,8 @@
 	{
 		.vendor       = 0x14f1,
 		.device       = 0x8800,
-                .subvendor    = PCI_ANY_ID,
-                .subdevice    = PCI_ANY_ID,
+		.subvendor    = PCI_ANY_ID,
+		.subdevice    = PCI_ANY_ID,
 	},{
 		/* --- end of list --- */
 	}
@@ -2239,10 +2273,10 @@
 MODULE_DEVICE_TABLE(pci, cx8800_pci_tbl);
 
 static struct pci_driver cx8800_pci_driver = {
-        .name     = "cx8800",
-        .id_table = cx8800_pci_tbl,
-        .probe    = cx8800_initdev,
-        .remove   = __devexit_p(cx8800_finidev),
+	.name     = "cx8800",
+	.id_table = cx8800_pci_tbl,
+	.probe    = cx8800_initdev,
+	.remove   = __devexit_p(cx8800_finidev),
 
 	.suspend  = cx8800_suspend,
 	.resume   = cx8800_resume,
@@ -2274,4 +2308,5 @@
  * Local variables:
  * c-basic-offset: 8
  * End:
+ * kate: eol "unix"; indent-width 3; remove-trailing-space on; replace-trailing-space-save on; tab-width 8; replace-tabs off; space-indent off; mixed-indent off
  */
diff -u linux-2.6.12/drivers/media/video/cx88/cx88-vbi.c linux/drivers/media/video/cx88/cx88-vbi.c
--- linux-2.6.12/drivers/media/video/cx88/cx88-vbi.c	2005-06-07 15:38:09.000000000 -0300
+++ linux/drivers/media/video/cx88/cx88-vbi.c	2005-06-12 01:20:10.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88-vbi.c,v 1.16 2004/12/10 12:33:39 kraxel Exp $
+ * $Id: cx88-vbi.c,v 1.17 2005/06/12 04:19:19 mchehab Exp $
  */
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -47,8 +47,8 @@
 }
 
 static int cx8800_start_vbi_dma(struct cx8800_dev    *dev,
-				struct cx88_dmaqueue *q,
-				struct cx88_buffer   *buf)
+			 struct cx88_dmaqueue *q,
+			 struct cx88_buffer   *buf)
 {
 	struct cx88_core *core = dev->core;
 
diff -u linux-2.6.12/drivers/media/video/cx88/cx88-input.c linux/drivers/media/video/cx88/cx88-input.c
--- linux-2.6.12/drivers/media/video/cx88/cx88-input.c	2005-06-07 15:39:55.000000000 -0300
+++ linux/drivers/media/video/cx88/cx88-input.c	2005-06-12 01:20:11.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88-input.c,v 1.9 2005/03/04 09:12:23 kraxel Exp $
+ * $Id: cx88-input.c,v 1.11 2005/05/22 20:57:56 nsh Exp $
  *
  * Device driver for GPIO attached remote control interfaces
  * on Conexant 2388x based TV/DVB cards.
@@ -235,6 +235,7 @@
 	/* detect & configure */
 	switch (core->board) {
 	case CX88_BOARD_DNTV_LIVE_DVB_T:
+	case CX88_BOARD_KWORLD_DVB_T:
 		ir_codes         = ir_codes_dntv_live_dvb_t;
 		ir->gpio_addr    = MO_GP1_IO;
 		ir->mask_keycode = 0x1f;
@@ -250,7 +251,7 @@
 	case CX88_BOARD_WINFAST2000XP_EXPERT:
 		ir_codes         = ir_codes_winfast;
 		ir->gpio_addr    = MO_GP0_IO;
-		ir->mask_keycode = 0x8f8;
+		ir->mask_keycode = 0x8f8; 
 		ir->mask_keyup   = 0x100;
 		ir->polling      = 1; // ms
 		break;
@@ -264,11 +265,12 @@
 	case CX88_BOARD_PIXELVIEW_PLAYTV_ULTRA_PRO:
 		ir_codes         = ir_codes_pixelview;
 		ir->gpio_addr    = MO_GP1_IO;
-		ir->mask_keycode = 0x1f;
+		ir->mask_keycode = 0x1f; 
 		ir->mask_keyup   = 0x80;
 		ir->polling      = 1; // ms
 		break;
 	}
+
 	if (NULL == ir_codes) {
 		kfree(ir);
 		return -ENODEV;
diff -u linux-2.6.12/drivers/media/video/cx88/cx88-mpeg.c linux/drivers/media/video/cx88/cx88-mpeg.c
--- linux-2.6.12/drivers/media/video/cx88/cx88-mpeg.c	2005-06-07 15:38:09.000000000 -0300
+++ linux/drivers/media/video/cx88/cx88-mpeg.c	2005-06-12 01:20:11.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88-mpeg.c,v 1.25 2005/03/07 14:18:00 kraxel Exp $
+ * $Id: cx88-mpeg.c,v 1.26 2005/06/03 13:31:51 mchehab Exp $
  *
  *  Support for the mpeg transport stream transfers
  *  PCI function #2 of the cx2388x.
@@ -55,7 +55,7 @@
 {
 	struct cx88_core *core = dev->core;
 
-	dprintk(1, "cx8802_start_mpegport_dma %d\n", buf->vb.width);
+	dprintk(0, "cx8802_start_dma %d\n", buf->vb.width);
 
 	/* setup fifo + format */
 	cx88_sram_channel_setup(core, &cx88_sram_channels[SRAM_CH28],
@@ -100,18 +100,21 @@
 	q->count = 1;
 
 	/* enable irqs */
+	dprintk( 0, "setting the interrupt mask\n" );
 	cx_set(MO_PCI_INTMSK, core->pci_irqmask | 0x04);
-	cx_write(MO_TS_INTMSK,  0x1f0011);
+	cx_set(MO_TS_INTMSK,  0x1f0011);
+	//cx_write(MO_TS_INTMSK,  0x0f0011);
 
 	/* start dma */
-	cx_write(MO_DEV_CNTRL2, (1<<5)); /* FIXME: s/write/set/ ??? */
-	cx_write(MO_TS_DMACNTRL, 0x11);
+	cx_set(MO_DEV_CNTRL2, (1<<5));
+	cx_set(MO_TS_DMACNTRL, 0x11);
 	return 0;
 }
 
 static int cx8802_stop_dma(struct cx8802_dev *dev)
 {
 	struct cx88_core *core = dev->core;
+	dprintk( 0, "cx8802_stop_dma\n" );
 
 	/* stop dma */
 	cx_clear(MO_TS_DMACNTRL, 0x11);
@@ -131,8 +134,12 @@
 	struct cx88_buffer *buf;
 	struct list_head *item;
 
+	dprintk( 0, "cx8802_restart_queue\n" );
 	if (list_empty(&q->active))
+	{
+		dprintk( 0, "cx8802_restart_queue: queue is empty\n" );
 		return 0;
+	}
 
 	buf = list_entry(q->active.next, struct cx88_buffer, vb.queue);
 	dprintk(2,"restart_queue [%p/%d]: restart dma\n",
@@ -182,27 +189,32 @@
 	struct cx88_buffer    *prev;
 	struct cx88_dmaqueue  *q    = &dev->mpegq;
 
+	dprintk( 1, "cx8802_buf_queue\n" );
 	/* add jump to stopper */
 	buf->risc.jmp[0] = cpu_to_le32(RISC_JUMP | RISC_IRQ1 | RISC_CNT_INC);
 	buf->risc.jmp[1] = cpu_to_le32(q->stopper.dma);
 
 	if (list_empty(&q->active)) {
+		dprintk( 0, "queue is empty - first active\n" );
 		list_add_tail(&buf->vb.queue,&q->active);
 		cx8802_start_dma(dev, q, buf);
 		buf->vb.state = STATE_ACTIVE;
 		buf->count    = q->count++;
 		mod_timer(&q->timeout, jiffies+BUFFER_TIMEOUT);
-		dprintk(2,"[%p/%d] %s - first active\n",
+		dprintk(0,"[%p/%d] %s - first active\n",
 			buf, buf->vb.i, __FUNCTION__);
+		//udelay(100);
 
 	} else {
+		dprintk( 1, "queue is not empty - append to active\n" );
 		prev = list_entry(q->active.prev, struct cx88_buffer, vb.queue);
 		list_add_tail(&buf->vb.queue,&q->active);
 		buf->vb.state = STATE_ACTIVE;
 		buf->count    = q->count++;
 		prev->risc.jmp[1] = cpu_to_le32(buf->risc.dma);
-		dprintk(2,"[%p/%d] %s - append to active\n",
+		dprintk( 1, "[%p/%d] %s - append to active\n",
 			buf, buf->vb.i, __FUNCTION__);
+		//udelay(100);
 	}
 }
 
@@ -224,7 +236,10 @@
 			buf, buf->vb.i, reason, (unsigned long)buf->risc.dma);
 	}
 	if (restart)
+	{
+		dprintk(0, "restarting queue\n" );
 		cx8802_restart_queue(dev,q);
+	}
 	spin_unlock_irqrestore(&dev->slock,flags);
 }
 
@@ -232,6 +247,7 @@
 {
 	struct cx88_dmaqueue *q = &dev->mpegq;
 
+	dprintk( 1, "cx8802_cancel_buffers" );
 	del_timer_sync(&q->timeout);
 	cx8802_stop_dma(dev);
 	do_cancel_buffers(dev,"cancel",0);
@@ -241,7 +257,7 @@
 {
 	struct cx8802_dev *dev = (struct cx8802_dev*)data;
 
-	dprintk(1, "%s\n",__FUNCTION__);
+	dprintk(0, "%s\n",__FUNCTION__);
 
 	if (debug)
 		cx88_sram_channel_dump(dev->core, &cx88_sram_channels[SRAM_CH28]);
@@ -254,12 +270,17 @@
 	struct cx88_core *core = dev->core;
 	u32 status, mask, count;
 
+	dprintk( 1, "cx8802_mpeg_irq\n" );
 	status = cx_read(MO_TS_INTSTAT);
 	mask   = cx_read(MO_TS_INTMSK);
 	if (0 == (status & mask))
 		return;
 
 	cx_write(MO_TS_INTSTAT, status);
+#if 0
+	cx88_print_irqbits(core->name, "irq mpeg ",
+			cx88_mpeg_irqs, status, mask);
+#endif
 	if (debug || (status & mask & ~0xff))
 		cx88_print_irqbits(core->name, "irq mpeg ",
 				   cx88_mpeg_irqs, status, mask);
@@ -273,6 +294,7 @@
 
 	/* risc1 y */
 	if (status & 0x01) {
+		dprintk( 1, "wake up\n" );
 		spin_lock(&dev->slock);
 		count = cx_read(MO_TS_GPCNT);
 		cx88_wakeup(dev->core, &dev->mpegq, count);
@@ -288,6 +310,7 @@
 
         /* other general errors */
         if (status & 0x1f0100) {
+		dprintk( 0, "general errors: 0x%08x\n", status & 0x1f0100 );
                 spin_lock(&dev->slock);
 		cx8802_stop_dma(dev);
                 cx8802_restart_queue(dev,&dev->mpegq);
@@ -295,6 +318,8 @@
         }
 }
 
+#define MAX_IRQ_LOOP 10
+
 static irqreturn_t cx8802_irq(int irq, void *dev_id, struct pt_regs *regs)
 {
 	struct cx8802_dev *dev = dev_id;
@@ -302,10 +327,13 @@
 	u32 status;
 	int loop, handled = 0;
 
-	for (loop = 0; loop < 10; loop++) {
+	for (loop = 0; loop < MAX_IRQ_LOOP; loop++) {
 		status = cx_read(MO_PCI_INTSTAT) & (core->pci_irqmask | 0x04);
 		if (0 == status)
 			goto out;
+		dprintk( 1, "cx8802_irq\n" );
+		dprintk( 1, "    loop: %d/%d\n", loop, MAX_IRQ_LOOP );
+		dprintk( 1, "    status: %d\n", status );
 		handled = 1;
 		cx_write(MO_PCI_INTSTAT, status);
 
@@ -314,7 +342,8 @@
 		if (status & 0x04)
 			cx8802_mpeg_irq(dev);
 	};
-	if (10 == loop) {
+	if (MAX_IRQ_LOOP == loop) {
+		dprintk( 0, "clearing mask\n" );
 		printk(KERN_WARNING "%s/0: irq loop -- clearing mask\n",
 		       core->name);
 		cx_write(MO_PCI_INTMSK,0);
@@ -378,6 +407,7 @@
 
 void cx8802_fini_common(struct cx8802_dev *dev)
 {
+	dprintk( 2, "cx8802_fini_common\n" );
 	cx8802_stop_dma(dev);
 	pci_disable_device(dev->pci);
 
@@ -399,6 +429,7 @@
 	/* stop mpeg dma */
 	spin_lock(&dev->slock);
 	if (!list_empty(&dev->mpegq.active)) {
+		dprintk( 2, "suspend\n" );
 		printk("%s: suspend mpeg\n", core->name);
 		cx8802_stop_dma(dev);
 		del_timer(&dev->mpegq.timeout);
@@ -463,4 +494,5 @@
  * Local variables:
  * c-basic-offset: 8
  * End:
+ * kate: eol "unix"; indent-width 3; remove-trailing-space on; replace-trailing-space-save on; tab-width 8; replace-tabs off; space-indent off; mixed-indent off
  */
diff -u linux-2.6.12/drivers/media/video/cx88/cx88-dvb.c linux/drivers/media/video/cx88/cx88-dvb.c
--- linux-2.6.12/drivers/media/video/cx88/cx88-dvb.c	2005-06-07 15:38:09.000000000 -0300
+++ linux/drivers/media/video/cx88/cx88-dvb.c	2005-06-12 01:20:11.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88-dvb.c,v 1.31 2005/03/07 15:58:05 kraxel Exp $
+ * $Id: cx88-dvb.c,v 1.33 2005/06/12 04:19:19 mchehab Exp $
  *
  * device driver for Conexant 2388x based TV cards
  * MPEG Transport Stream (DVB) routines
@@ -183,7 +183,7 @@
 #endif
 
 #if HAVE_OR51132
-static int or51132_set_ts_param(struct dvb_frontend* fe,
+static int or51132_set_ts_param(struct dvb_frontend* fe, 
 				int is_punctured)
 {
 	struct cx8802_dev *dev= fe->dvb->priv;
diff -u linux-2.6.12/drivers/media/video/cx88/cx88-blackbird.c linux/drivers/media/video/cx88/cx88-blackbird.c
--- linux-2.6.12/drivers/media/video/cx88/cx88-blackbird.c	2005-06-07 15:38:09.000000000 -0300
+++ linux/drivers/media/video/cx88/cx88-blackbird.c	2005-06-12 01:20:11.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88-blackbird.c,v 1.26 2005/03/07 15:58:05 kraxel Exp $
+ * $Id: cx88-blackbird.c,v 1.27 2005/06/03 13:31:50 mchehab Exp $
  *
  *  Support for a cx23416 mpeg encoder via cx2388x host port.
  *  "blackbird" reference design.
@@ -61,37 +61,304 @@
 
 #define IVTV_CMD_HW_BLOCKS_RST 0xFFFFFFFF
 
-/*Firmware API commands*/
-#define IVTV_API_ENC_PING_FW 0x00000080
-#define IVTV_API_ENC_GETVER 0x000000C4
-#define IVTV_API_ENC_HALT_FW 0x000000C3
-#define IVTV_API_STD_TIMEOUT 0x00010000 /*units??*/
-//#define IVTV_API_ASSIGN_PGM_INDEX_INFO 0x000000c7
-#define IVTV_API_ASSIGN_STREAM_TYPE 0x000000b9
-#define IVTV_API_ASSIGN_OUTPUT_PORT 0x000000bb
-#define IVTV_API_ASSIGN_FRAMERATE 0x0000008f
-#define IVTV_API_ASSIGN_FRAME_SIZE 0x00000091
-#define IVTV_API_ASSIGN_ASPECT_RATIO 0x00000099
-#define IVTV_API_ASSIGN_BITRATES 0x00000095
-#define IVTV_API_ASSIGN_GOP_PROPERTIES 0x00000097
-#define IVTV_API_ASSIGN_3_2_PULLDOWN 0x000000b1
-#define IVTV_API_ASSIGN_GOP_CLOSURE 0x000000c5
-#define IVTV_API_ASSIGN_AUDIO_PROPERTIES 0x000000bd
-#define IVTV_API_ASSIGN_DNR_FILTER_MODE 0x0000009b
-#define IVTV_API_ASSIGN_DNR_FILTER_PROPS 0x0000009d
-#define IVTV_API_ASSIGN_CORING_LEVELS 0x0000009f
-#define IVTV_API_ASSIGN_SPATIAL_FILTER_TYPE 0x000000a1
-#define IVTV_API_ASSIGN_FRAME_DROP_RATE 0x000000d0
-#define IVTV_API_ASSIGN_PLACEHOLDER 0x000000d8
-#define IVTV_API_MUTE_VIDEO 0x000000d9
-#define IVTV_API_MUTE_AUDIO 0x000000da
-#define IVTV_API_INITIALIZE_INPUT 0x000000cd
-#define IVTV_API_REFRESH_INPUT 0x000000d3
-#define IVTV_API_ASSIGN_NUM_VSYNC_LINES 0x000000d6
-#define IVTV_API_BEGIN_CAPTURE 0x00000081
-//#define IVTV_API_PAUSE_ENCODER 0x000000d2
-//#define IVTV_API_EVENT_NOTIFICATION 0x000000d5
-#define IVTV_API_END_CAPTURE 0x00000082
+/* Firmware API commands */
+/* #define IVTV_API_STD_TIMEOUT 0x00010000 // 65536, units?? */
+#define IVTV_API_STD_TIMEOUT 500
+
+#define BLACKBIRD_API_PING               0x80
+#define BLACKBIRD_API_BEGIN_CAPTURE      0x81
+enum blackbird_capture_type {
+	BLACKBIRD_MPEG_CAPTURE,
+	BLACKBIRD_RAW_CAPTURE,
+	BLACKBIRD_RAW_PASSTHRU_CAPTURE
+};
+enum blackbird_capture_bits {
+	BLACKBIRD_RAW_BITS_NONE             = 0x00,
+	BLACKBIRD_RAW_BITS_YUV_CAPTURE      = 0x01,
+	BLACKBIRD_RAW_BITS_PCM_CAPTURE      = 0x02,
+	BLACKBIRD_RAW_BITS_VBI_CAPTURE      = 0x04,
+	BLACKBIRD_RAW_BITS_PASSTHRU_CAPTURE = 0x08,
+	BLACKBIRD_RAW_BITS_TO_HOST_CAPTURE  = 0x10
+};
+#define BLACKBIRD_API_END_CAPTURE        0x82
+enum blackbird_capture_end {
+	BLACKBIRD_END_AT_GOP, /* stop at the end of gop, generate irq */
+	BLACKBIRD_END_NOW, /* stop immediately, no irq */
+};
+#define BLACKBIRD_API_SET_AUDIO_ID       0x89
+#define BLACKBIRD_API_SET_VIDEO_ID       0x8B
+#define BLACKBIRD_API_SET_PCR_ID         0x8D
+#define BLACKBIRD_API_SET_FRAMERATE      0x8F
+enum blackbird_framerate {
+	BLACKBIRD_FRAMERATE_NTSC_30, /* NTSC: 30fps */
+	BLACKBIRD_FRAMERATE_PAL_25   /* PAL: 25fps */
+};
+#define BLACKBIRD_API_SET_RESOLUTION     0x91
+#define BLACKBIRD_API_SET_VIDEO_BITRATE  0x95
+enum blackbird_video_bitrate_type {
+	BLACKBIRD_VIDEO_VBR,
+	BLACKBIRD_VIDEO_CBR
+};
+#define BLACKBIRD_PEAK_RATE_DIVISOR 400
+enum blackbird_mux_rate {
+	BLACKBIRD_MUX_RATE_DEFAULT,
+	 /* dvd mux rate: multiply by 400 to get the actual rate */
+	BLACKBIRD_MUX_RATE_DVD = 25200
+};
+#define BLACKBIRD_API_SET_GOP_STRUCTURE  0x97
+#define BLACKBIRD_API_SET_ASPECT_RATIO   0x99
+enum blackbird_aspect_ratio {
+	BLACKBIRD_ASPECT_RATIO_FORBIDDEN,
+	BLACKBIRD_ASPECT_RATIO_1_1_SQUARE,
+	BLACKBIRD_ASPECT_RATIO_4_3,
+	BLACKBIRD_ASPECT_RATIO_16_9,
+	BLACKBIRD_ASPECT_RATIO_221_100,
+	BLACKBIRD_ASPECT_RATIO_RESERVED
+};
+#define BLACKBIRD_API_SET_DNR_MODE       0x9B
+enum blackbird_dnr_bits {
+	BLACKBIRD_DNR_BITS_MANUAL,
+	BLACKBIRD_DNR_BITS_AUTO_SPATIAL,
+	BLACKBIRD_DNR_BITS_AUTO_TEMPORAL,
+	BLACKBIRD_DNR_BITS_AUTO
+};
+enum blackbird_median_filter {
+	BLACKBIRD_MEDIAN_FILTER_DISABLED,
+	BLACKBIRD_MEDIAN_FILTER_HORIZONTAL,
+	BLACKBIRD_MEDIAN_FILTER_VERTICAL,
+	BLACKBIRD_MEDIAN_FILTER_HV,
+	BLACKBIRD_MEDIAN_FILTER_DIAGONAL
+};
+#define BLACKBIRD_API_SET_MANUAL_DNR     0x9D
+#define BLACKBIRD_API_SET_DNR_MEDIAN     0x9F
+#define BLACKBIRD_API_SET_SPATIAL_FILTER 0xA1
+enum blackbird_spatial_filter_luma {
+	BLACKBIRD_SPATIAL_FILTER_LUMA_DISABLED,
+	BLACKBIRD_SPATIAL_FILTER_LUMA_1D_HORIZ,
+	BLACKBIRD_SPATIAL_FILTER_LUMA_1D_VERT,
+	BLACKBIRD_SPATIAL_FILTER_LUMA_2D_HV, /* separable, default */
+	BLACKBIRD_SPATIAL_FILTER_LUMA_2D_SYMM /* symmetric non-separable */
+};
+enum blackbird_spatial_filter_chroma {
+	BLACKBIRD_SPATIAL_FILTER_CHROMA_DISABLED,
+	BLACKBIRD_SPATIAL_FILTER_CHROMA_1D_HORIZ /* default */
+};
+#define BLACKBIRD_API_SET_3_2_PULLDOWN   0xB1
+enum blackbird_pulldown {
+	BLACKBIRD_3_2_PULLDOWN_DISABLED,
+	BLACKBIRD_3_2_PULLDOWN_ENABLED
+};
+#define BLACKBIRD_API_SET_VBI_LINE_NO    0xB7
+enum blackbird_vbi_line_bits {
+	BLACKBIRD_VBI_LINE_BITS_TOP_FIELD,
+	BLACKBIRD_VBI_LINE_BITS_BOT_FIELD = (1 << 31),
+	BLACKBIRD_VBI_LINE_BITS_ALL_LINES = 0xFFFFFFFF
+};
+enum blackbird_vbi_line {
+	BLACKBIRD_VBI_LINE_DISABLED,
+	BLACKBIRD_VBI_LINE_ENABLED
+};
+enum blackbird_vbi_slicing {
+	BLACKBIRD_VBI_SLICING_NONE,
+	BLACKBIRD_VBI_SLICING_CLOSED_CAPTION
+};
+#define BLACKBIRD_API_SET_STREAM_TYPE    0xB9
+enum blackbird_stream_type {
+	BLACKBIRD_STREAM_PROGRAM,
+	BLACKBIRD_STREAM_TRANSPORT,
+	BLACKBIRD_STREAM_MPEG1,
+	BLACKBIRD_STREAM_PES_AV,
+	BLACKBIRD_STREAM_UNKNOWN4,
+	BLACKBIRD_STREAM_PES_VIDEO,
+	BLACKBIRD_STREAM_UNKNOWN6,
+	BLACKBIRD_STREAM_PES_AUDIO,
+	BLACKBIRD_STREAM_UNKNOWN8,
+	BLACKBIRD_STREAM_UNKNOWN9, /* audio/pcm ? */
+	BLACKBIRD_STREAM_DVD,
+	BLACKBIRD_STREAM_VCD,
+	BLACKBIRD_STREAM_UNKNOWN12 /* svcd/xvcd ? */
+};
+#define BLACKBIRD_API_SET_OUTPUT_PORT    0xBB
+enum blackbird_stream_port {
+	BLACKBIRD_OUTPUT_PORT_MEMORY,
+	BLACKBIRD_OUTPUT_PORT_STREAMING,
+	BLACKBIRD_OUTPUT_PORT_SERIAL
+};
+#define BLACKBIRD_API_SET_AUDIO_PARAMS   0xBD
+enum blackbird_audio_bits_sample_rate {
+	BLACKBIRD_AUDIO_BITS_44100HZ,
+	BLACKBIRD_AUDIO_BITS_48000HZ,
+	BLACKBIRD_AUDIO_BITS_32000HZ,
+	BLACKBIRD_AUDIO_BITS_RESERVED_HZ,
+};
+enum blackbird_audio_bits_encoding {
+	BLACKBIRD_AUDIO_BITS_LAYER_1 = 0x1 << 2,
+	BLACKBIRD_AUDIO_BITS_LAYER_2 = 0x2 << 2,
+};
+enum blackbird_audio_bits_bitrate_layer_1 {
+	BLACKBIRD_AUDIO_BITS_LAYER_1_FREE_FORMAT,
+	BLACKBIRD_AUDIO_BITS_LAYER_1_32  = 0x01 << 4,
+	BLACKBIRD_AUDIO_BITS_LAYER_1_64  = 0x02 << 4,
+	BLACKBIRD_AUDIO_BITS_LAYER_1_96  = 0x03 << 4,
+	BLACKBIRD_AUDIO_BITS_LAYER_1_128 = 0x04 << 4,
+	BLACKBIRD_AUDIO_BITS_LAYER_1_160 = 0x05 << 4,
+	BLACKBIRD_AUDIO_BITS_LAYER_1_192 = 0x06 << 4,
+	BLACKBIRD_AUDIO_BITS_LAYER_1_224 = 0x07 << 4,
+	BLACKBIRD_AUDIO_BITS_LAYER_1_256 = 0x08 << 4,
+	BLACKBIRD_AUDIO_BITS_LAYER_1_288 = 0x09 << 4,
+	BLACKBIRD_AUDIO_BITS_LAYER_1_320 = 0x0A << 4,
+	BLACKBIRD_AUDIO_BITS_LAYER_1_352 = 0x0B << 4,
+	BLACKBIRD_AUDIO_BITS_LAYER_1_384 = 0x0C << 4,
+	BLACKBIRD_AUDIO_BITS_LAYER_1_416 = 0x0D << 4,
+	BLACKBIRD_AUDIO_BITS_LAYER_1_448 = 0x0E << 4,
+};
+enum blackbird_audio_bits_bitrate_layer_2 {
+	BLACKBIRD_AUDIO_BITS_LAYER_2_FREE_FORMAT,
+	BLACKBIRD_AUDIO_BITS_LAYER_2_32  = 0x01 << 4,
+	BLACKBIRD_AUDIO_BITS_LAYER_2_48  = 0x02 << 4,
+	BLACKBIRD_AUDIO_BITS_LAYER_2_56  = 0x03 << 4,
+	BLACKBIRD_AUDIO_BITS_LAYER_2_64  = 0x04 << 4,
+	BLACKBIRD_AUDIO_BITS_LAYER_2_80  = 0x05 << 4,
+	BLACKBIRD_AUDIO_BITS_LAYER_2_96  = 0x06 << 4,
+	BLACKBIRD_AUDIO_BITS_LAYER_2_112 = 0x07 << 4,
+	BLACKBIRD_AUDIO_BITS_LAYER_2_128 = 0x08 << 4,
+	BLACKBIRD_AUDIO_BITS_LAYER_2_160 = 0x09 << 4,
+	BLACKBIRD_AUDIO_BITS_LAYER_2_192 = 0x0A << 4,
+	BLACKBIRD_AUDIO_BITS_LAYER_2_224 = 0x0B << 4,
+	BLACKBIRD_AUDIO_BITS_LAYER_2_256 = 0x0C << 4,
+	BLACKBIRD_AUDIO_BITS_LAYER_2_320 = 0x0D << 4,
+	BLACKBIRD_AUDIO_BITS_LAYER_2_384 = 0x0E << 4,
+};
+enum blackbird_audio_bits_mode {
+	BLACKBIRD_AUDIO_BITS_STEREO,
+	BLACKBIRD_AUDIO_BITS_JOINT_STEREO = 0x1 << 8,
+	BLACKBIRD_AUDIO_BITS_DUAL         = 0x2 << 8,
+	BLACKBIRD_AUDIO_BITS_MONO         = 0x3 << 8,
+};
+enum blackbird_audio_bits_mode_extension {
+	BLACKBIRD_AUDIO_BITS_BOUND_4,
+	BLACKBIRD_AUDIO_BITS_BOUND_8  = 0x1 << 10,
+	BLACKBIRD_AUDIO_BITS_BOUND_12 = 0x2 << 10,
+	BLACKBIRD_AUDIO_BITS_BOUND_16 = 0x3 << 10,
+};
+enum blackbird_audio_bits_emphasis {
+	BLACKBIRD_AUDIO_BITS_EMPHASIS_NONE,
+	BLACKBIRD_AUDIO_BITS_EMPHASIS_50_15     = 0x1 << 12,
+	BLACKBIRD_AUDIO_BITS_EMPHASIS_RESERVED  = 0x2 << 12,
+	BLACKBIRD_AUDIO_BITS_EMPHASIS_CCITT_J17 = 0x3 << 12,
+};
+enum blackbird_audio_bits_crc {
+	BLACKBIRD_AUDIO_BITS_CRC_OFF,
+	BLACKBIRD_AUDIO_BITS_CRC_ON = 0x1 << 14,
+};
+enum blackbird_audio_bits_copyright {
+	BLACKBIRD_AUDIO_BITS_COPYRIGHT_OFF,
+	BLACKBIRD_AUDIO_BITS_COPYRIGHT_ON = 0x1 << 15,
+};
+enum blackbird_audio_bits_original {
+	BLACKBIRD_AUDIO_BITS_COPY,
+	BLACKBIRD_AUDIO_BITS_ORIGINAL = 0x1 << 16,
+};
+#define BLACKBIRD_API_HALT               0xC3
+#define BLACKBIRD_API_GET_VERSION        0xC4
+#define BLACKBIRD_API_SET_GOP_CLOSURE    0xC5
+enum blackbird_gop_closure {
+	BLACKBIRD_GOP_CLOSURE_OFF,
+	BLACKBIRD_GOP_CLOSURE_ON,
+};
+#define BLACKBIRD_API_DATA_XFER_STATUS   0xC6
+enum blackbird_data_xfer_status {
+	BLACKBIRD_MORE_BUFFERS_FOLLOW,
+	BLACKBIRD_LAST_BUFFER,
+};
+#define BLACKBIRD_API_PROGRAM_INDEX_INFO 0xC7
+enum blackbird_picture_mask {
+	BLACKBIRD_PICTURE_MASK_NONE,
+	BLACKBIRD_PICTURE_MASK_I_FRAMES,
+	BLACKBIRD_PICTURE_MASK_I_P_FRAMES = 0x3,
+	BLACKBIRD_PICTURE_MASK_ALL_FRAMES = 0x7,
+};
+#define BLACKBIRD_API_SET_VBI_PARAMS     0xC8
+enum blackbird_vbi_mode_bits {
+	BLACKBIRD_VBI_BITS_SLICED,
+	BLACKBIRD_VBI_BITS_RAW,
+};
+enum blackbird_vbi_insertion_bits {
+	BLACKBIRD_VBI_BITS_INSERT_IN_XTENSION_USR_DATA,
+	BLACKBIRD_VBI_BITS_INSERT_IN_PRIVATE_PACKETS = 0x1 << 1,
+	BLACKBIRD_VBI_BITS_SEPARATE_STREAM = 0x2 << 1,
+	BLACKBIRD_VBI_BITS_SEPARATE_STREAM_USR_DATA = 0x4 << 1,
+	BLACKBIRD_VBI_BITS_SEPARATE_STREAM_PRV_DATA = 0x5 << 1,
+};
+#define BLACKBIRD_API_SET_DMA_BLOCK_SIZE 0xC9
+enum blackbird_dma_unit {
+	BLACKBIRD_DMA_BYTES,
+	BLACKBIRD_DMA_FRAMES,
+};
+#define BLACKBIRD_API_DMA_TRANSFER_INFO  0xCA
+#define BLACKBIRD_API_DMA_TRANSFER_STAT  0xCB
+enum blackbird_dma_transfer_status_bits {
+	BLACKBIRD_DMA_TRANSFER_BITS_DONE = 0x01,
+	BLACKBIRD_DMA_TRANSFER_BITS_ERROR = 0x04,
+	BLACKBIRD_DMA_TRANSFER_BITS_LL_ERROR = 0x10,
+};
+#define BLACKBIRD_API_SET_DMA2HOST_ADDR  0xCC
+#define BLACKBIRD_API_INIT_VIDEO_INPUT   0xCD
+#define BLACKBIRD_API_SET_FRAMESKIP      0xD0
+#define BLACKBIRD_API_PAUSE              0xD2
+enum blackbird_pause {
+	BLACKBIRD_PAUSE_ENCODING,
+	BLACKBIRD_RESUME_ENCODING,
+};
+#define BLACKBIRD_API_REFRESH_INPUT      0xD3
+#define BLACKBIRD_API_SET_COPYRIGHT      0xD4
+enum blackbird_copyright {
+	BLACKBIRD_COPYRIGHT_OFF,
+	BLACKBIRD_COPYRIGHT_ON,
+};
+#define BLACKBIRD_API_SET_NOTIFICATION   0xD5
+enum blackbird_notification_type {
+	BLACKBIRD_NOTIFICATION_REFRESH,
+};
+enum blackbird_notification_status {
+	BLACKBIRD_NOTIFICATION_OFF,
+	BLACKBIRD_NOTIFICATION_ON,
+};
+enum blackbird_notification_mailbox {
+	BLACKBIRD_NOTIFICATION_NO_MAILBOX = -1,
+};
+#define BLACKBIRD_API_SET_CAPTURE_LINES  0xD6
+enum blackbird_field1_lines {
+	BLACKBIRD_FIELD1_SAA7114 = 0x00EF, /* 239 */
+	BLACKBIRD_FIELD1_SAA7115 = 0x00F0, /* 240 */
+	BLACKBIRD_FIELD1_MICRONAS = 0x0105, /* 261 */
+};
+enum blackbird_field2_lines {
+	BLACKBIRD_FIELD2_SAA7114 = 0x00EF, /* 239 */
+	BLACKBIRD_FIELD2_SAA7115 = 0x00F0, /* 240 */
+	BLACKBIRD_FIELD2_MICRONAS = 0x0106, /* 262 */
+};
+#define BLACKBIRD_API_SET_CUSTOM_DATA    0xD7
+enum blackbird_custom_data_type {
+	BLACKBIRD_CUSTOM_EXTENSION_USR_DATA,
+	BLACKBIRD_CUSTOM_PRIVATE_PACKET,
+};
+#define BLACKBIRD_API_MUTE_VIDEO         0xD9
+enum blackbird_mute {
+	BLACKBIRD_UNMUTE,
+	BLACKBIRD_MUTE,
+};
+enum blackbird_mute_video_mask {
+	BLACKBIRD_MUTE_VIDEO_V_MASK = 0x0000FF00,
+	BLACKBIRD_MUTE_VIDEO_U_MASK = 0x00FF0000,
+	BLACKBIRD_MUTE_VIDEO_Y_MASK = 0xFF000000,
+};
+enum blackbird_mute_video_shift {
+	BLACKBIRD_MUTE_VIDEO_V_SHIFT = 8,
+	BLACKBIRD_MUTE_VIDEO_U_SHIFT = 16,
+	BLACKBIRD_MUTE_VIDEO_Y_SHIFT = 24,
+};
+#define BLACKBIRD_API_MUTE_AUDIO         0xDA
 
 /* Registers */
 #define IVTV_REG_ENC_SDRAM_REFRESH (0x07F8 /*| IVTV_REG_OFFSET*/)
@@ -405,68 +672,100 @@
 	return 0;
 }
 
+/**
+ Settings used by the windows tv app for PVR2000:
+=================================================================================================================
+Profile | Codec | Resolution | CBR/VBR | Video Qlty   | V. Bitrate | Frmrate | Audio Codec | A. Bitrate | A. Mode
+-----------------------------------------------------------------------------------------------------------------
+MPEG-1  | MPEG1 | 352x288PAL | (CBR)   | 1000:Optimal | 2000 Kbps  | 25fps   | MPG1 Layer2 | 224kbps    | Stereo
+MPEG-2  | MPEG2 | 720x576PAL | VBR     | 600 :Good    | 4000 Kbps  | 25fps   | MPG1 Layer2 | 224kbps    | Stereo
+VCD     | MPEG1 | 352x288PAL | (CBR)   | 1000:Optimal | 1150 Kbps  | 25fps   | MPG1 Layer2 | 224kbps    | Stereo
+DVD     | MPEG2 | 720x576PAL | VBR     | 600 :Good    | 6000 Kbps  | 25fps   | MPG1 Layer2 | 224kbps    | Stereo
+DB* DVD | MPEG2 | 720x576PAL | CBR     | 600 :Good    | 6000 Kbps  | 25fps   | MPG1 Layer2 | 224kbps    | Stereo
+=================================================================================================================
+*DB: "DirectBurn"
+*/
 static void blackbird_codec_settings(struct cx8802_dev *dev)
 {
 	int bitrate_mode = 1;
 	int bitrate = 7500000;
 	int bitrate_peak = 7500000;
+#if 1
+	bitrate_mode = BLACKBIRD_VIDEO_CBR;
+	bitrate = 4000*1024;
+	bitrate_peak = 4000*1024;
+#endif
 
 	/* assign stream type */
-        blackbird_api_cmd(dev, IVTV_API_ASSIGN_STREAM_TYPE, 1, 0, 0); /* program stream */
-        //blackbird_api_cmd(dev, IVTV_API_ASSIGN_STREAM_TYPE, 1, 0, 2); /* MPEG1 stream */
-        //blackbird_api_cmd(dev, IVTV_API_ASSIGN_STREAM_TYPE, 1, 0, 3); /* PES A/V */
-        //blackbird_api_cmd(dev, IVTV_API_ASSIGN_STREAM_TYPE, 1, 0, 10); /* DVD stream */
+	blackbird_api_cmd(dev, BLACKBIRD_API_SET_STREAM_TYPE, 1, 0, BLACKBIRD_STREAM_PROGRAM);
+	/* blackbird_api_cmd(dev, BLACKBIRD_API_SET_STREAM_TYPE, 1, 0, BLACKBIRD_STREAM_TRANSPORT); */
 
-        /* assign output port */
-        blackbird_api_cmd(dev, IVTV_API_ASSIGN_OUTPUT_PORT, 1, 0, 1); /* 1 = Host */
+	/* assign output port */
+	blackbird_api_cmd(dev, BLACKBIRD_API_SET_OUTPUT_PORT, 1, 0, BLACKBIRD_OUTPUT_PORT_STREAMING); /* Host */
 
-        /* assign framerate */
-        blackbird_api_cmd(dev, IVTV_API_ASSIGN_FRAMERATE, 1, 0, 0);
+	/* assign framerate */
+	blackbird_api_cmd(dev, BLACKBIRD_API_SET_FRAMERATE, 1, 0, BLACKBIRD_FRAMERATE_PAL_25);
 
-        /* assign frame size */
-        blackbird_api_cmd(dev, IVTV_API_ASSIGN_FRAME_SIZE, 2, 0,
+	/* assign frame size */
+	blackbird_api_cmd(dev, BLACKBIRD_API_SET_RESOLUTION, 2, 0,
 			  dev->height, dev->width);
 
-        /* assign aspect ratio */
-        blackbird_api_cmd(dev, IVTV_API_ASSIGN_ASPECT_RATIO, 1, 0, 2);
+	/* assign aspect ratio */
+	blackbird_api_cmd(dev, BLACKBIRD_API_SET_ASPECT_RATIO, 1, 0, BLACKBIRD_ASPECT_RATIO_4_3);
 
-        /* assign bitrates */
-        blackbird_api_cmd(dev, IVTV_API_ASSIGN_BITRATES, 5, 0,
+	/* assign bitrates */
+	blackbird_api_cmd(dev, BLACKBIRD_API_SET_VIDEO_BITRATE, 5, 0,
 			 bitrate_mode,         /* mode */
 			 bitrate,              /* bps */
-			 bitrate_peak / 400,   /* peak/400 */
-			 0, 0x70);             /* encoding buffer, ckennedy */
+			 bitrate_peak / BLACKBIRD_PEAK_RATE_DIVISOR,   /* peak/400 */
+			 BLACKBIRD_MUX_RATE_DEFAULT /*, 0x70*/);             /* encoding buffer, ckennedy */
 
-        /* assign gop properties */
-        blackbird_api_cmd(dev, IVTV_API_ASSIGN_GOP_PROPERTIES, 2, 0, 15, 3);
-        //blackbird_api_cmd(dev, IVTV_API_ASSIGN_GOP_PROPERTIES, 2, 0, 2, 1);
+	/* assign gop properties */
+	blackbird_api_cmd(dev, BLACKBIRD_API_SET_GOP_STRUCTURE, 2, 0, 15, 3);
 
-        /* assign 3 2 pulldown */
-        blackbird_api_cmd(dev, IVTV_API_ASSIGN_3_2_PULLDOWN, 1, 0, 0);
+	/* assign 3 2 pulldown */
+	blackbird_api_cmd(dev, BLACKBIRD_API_SET_3_2_PULLDOWN, 1, 0, BLACKBIRD_3_2_PULLDOWN_DISABLED);
 
-        /* note: it's not necessary to set the samplerate, the mpeg encoder seems to autodetect/adjust */
-	blackbird_api_cmd(dev, IVTV_API_ASSIGN_AUDIO_PROPERTIES, 1, 0, (2<<2) | (8<<4));
+	/* assign audio properties */
+	/* note: it's not necessary to set the samplerate, the mpeg encoder seems to autodetect/adjust */
+	/* blackbird_api_cmd(dev, IVTV_API_ASSIGN_AUDIO_PROPERTIES, 1, 0, (2<<2) | (8<<4));
+	   blackbird_api_cmd(dev, IVTV_API_ASSIGN_AUDIO_PROPERTIES, 1, 0, 0 | (2 << 2) | (14 << 4)); */
+	blackbird_api_cmd(dev, BLACKBIRD_API_SET_AUDIO_PARAMS, 1, 0,
+			BLACKBIRD_AUDIO_BITS_44100HZ |
+			BLACKBIRD_AUDIO_BITS_LAYER_2 |
+			BLACKBIRD_AUDIO_BITS_LAYER_2_224 |
+			BLACKBIRD_AUDIO_BITS_STEREO |
+			/* BLACKBIRD_AUDIO_BITS_BOUND_4 | */
+			BLACKBIRD_AUDIO_BITS_EMPHASIS_NONE |
+			BLACKBIRD_AUDIO_BITS_CRC_OFF |
+			BLACKBIRD_AUDIO_BITS_COPYRIGHT_OFF |
+			BLACKBIRD_AUDIO_BITS_COPY
+		);
 
 	/* assign gop closure */
-        blackbird_api_cmd(dev, IVTV_API_ASSIGN_GOP_CLOSURE, 1, 0, 0);
+	blackbird_api_cmd(dev, BLACKBIRD_API_SET_GOP_CLOSURE, 1, 0, BLACKBIRD_GOP_CLOSURE_OFF);
 
-        /* assign audio properties */
-        blackbird_api_cmd(dev, IVTV_API_ASSIGN_AUDIO_PROPERTIES, 1, 0, 0 | (2 << 2) | (14 << 4));
 
-        /* assign dnr filter mode */
-        blackbird_api_cmd(dev, IVTV_API_ASSIGN_DNR_FILTER_MODE, 2, 0, 0, 0);
+	/* assign dnr filter mode */
+	blackbird_api_cmd(dev, BLACKBIRD_API_SET_DNR_MODE, 2, 0,
+			BLACKBIRD_DNR_BITS_MANUAL,
+			BLACKBIRD_MEDIAN_FILTER_DISABLED
+		);
 
-        /* assign dnr filter props*/
-        blackbird_api_cmd(dev, IVTV_API_ASSIGN_DNR_FILTER_PROPS, 2, 0, 0, 0);
+	/* assign dnr filter props*/
+	blackbird_api_cmd(dev, BLACKBIRD_API_SET_MANUAL_DNR, 2, 0, 0, 0);
 
-        /* assign coring levels (luma_h, luma_l, chroma_h, chroma_l) */
-        blackbird_api_cmd(dev, IVTV_API_ASSIGN_CORING_LEVELS, 4, 0, 0, 255, 0, 255);
+	/* assign coring levels (luma_h, luma_l, chroma_h, chroma_l) */
+	blackbird_api_cmd(dev, BLACKBIRD_API_SET_DNR_MEDIAN, 4, 0, 0, 255, 0, 255);
 
-	/* assign spatial filter type: luma_t: 1 = horiz_only, chroma_t: 1 = horiz_only */
-        blackbird_api_cmd(dev, IVTV_API_ASSIGN_SPATIAL_FILTER_TYPE, 2, 0, 1, 1);
+	/* assign spatial filter type: luma_t: horiz_only, chroma_t: horiz_only */
+	blackbird_api_cmd(dev, BLACKBIRD_API_SET_SPATIAL_FILTER, 2, 0,
+			BLACKBIRD_SPATIAL_FILTER_LUMA_1D_HORIZ,
+			BLACKBIRD_SPATIAL_FILTER_CHROMA_1D_HORIZ
+		);
 
-        /* assign frame drop rate */
-        blackbird_api_cmd(dev, IVTV_API_ASSIGN_FRAME_DROP_RATE, 1, 0, 0);
+	/* assign frame drop rate */
+	/* blackbird_api_cmd(dev, IVTV_API_ASSIGN_FRAME_DROP_RATE, 1, 0, 0); */
 }
 
 static int blackbird_initialize_codec(struct cx8802_dev *dev)
@@ -476,7 +775,7 @@
 	int retval;
 
 	dprintk(1,"Initialize codec\n");
-	retval = blackbird_api_cmd(dev, IVTV_API_ENC_PING_FW, 0, 0); /* ping */
+	retval = blackbird_api_cmd(dev, BLACKBIRD_API_PING, 0, 0); /* ping */
 	if (retval < 0) {
 		/* ping was not successful, reset and upload firmware */
 		cx_write(MO_SRST_IO, 0); /* SYS_RSTO=0 */
@@ -491,13 +790,13 @@
 		if (dev->mailbox < 0)
 			return -1;
 
-		retval = blackbird_api_cmd(dev, IVTV_API_ENC_PING_FW, 0, 0); /* ping */
+		retval = blackbird_api_cmd(dev, BLACKBIRD_API_PING, 0, 0); /* ping */
 		if (retval < 0) {
 			dprintk(0, "ERROR: Firmware ping failed!\n");
 			return -1;
 		}
 
-		retval = blackbird_api_cmd(dev, IVTV_API_ENC_GETVER, 0, 1, &version);
+		retval = blackbird_api_cmd(dev, BLACKBIRD_API_GET_VERSION, 0, 1, &version);
 		if (retval < 0) {
 			dprintk(0, "ERROR: Firmware get encoder version failed!\n");
 			return -1;
@@ -517,25 +816,36 @@
 	blackbird_codec_settings(dev);
 	msleep(1);
 
-	//blackbird_api_cmd(dev, IVTV_API_ASSIGN_NUM_VSYNC_LINES, 4, 0, 0xef, 0xef);
-	blackbird_api_cmd(dev, IVTV_API_ASSIGN_NUM_VSYNC_LINES, 4, 0, 0xf0, 0xf0);
-	//blackbird_api_cmd(dev, IVTV_API_ASSIGN_NUM_VSYNC_LINES, 4, 0, 0x180, 0x180);
-        blackbird_api_cmd(dev, IVTV_API_ASSIGN_PLACEHOLDER, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
+	/* blackbird_api_cmd(dev, IVTV_API_ASSIGN_NUM_VSYNC_LINES, 4, 0, 0xef, 0xef);
+	   blackbird_api_cmd(dev, IVTV_API_ASSIGN_NUM_VSYNC_LINES, 4, 0, 0xf0, 0xf0);
+	   blackbird_api_cmd(dev, IVTV_API_ASSIGN_NUM_VSYNC_LINES, 4, 0, 0x180, 0x180); */
+	blackbird_api_cmd(dev, BLACKBIRD_API_SET_CAPTURE_LINES, 2, 0,
+			BLACKBIRD_FIELD1_SAA7115,
+			BLACKBIRD_FIELD1_SAA7115
+		);
+
+	/* blackbird_api_cmd(dev, IVTV_API_ASSIGN_PLACEHOLDER, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0); */
+	blackbird_api_cmd(dev, BLACKBIRD_API_SET_CUSTOM_DATA, 12, 0,
+			BLACKBIRD_CUSTOM_EXTENSION_USR_DATA,
+			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
 
-	blackbird_api_cmd(dev, IVTV_API_INITIALIZE_INPUT, 0, 0); /* initialize the video input */
+	blackbird_api_cmd(dev, BLACKBIRD_API_INIT_VIDEO_INPUT, 0, 0); /* initialize the video input */
 
 	msleep(1);
 
-        blackbird_api_cmd(dev, IVTV_API_MUTE_VIDEO, 1, 0, 0);
+	blackbird_api_cmd(dev, BLACKBIRD_API_MUTE_VIDEO, 1, 0, BLACKBIRD_UNMUTE);
 	msleep(1);
-        blackbird_api_cmd(dev, IVTV_API_MUTE_AUDIO, 1, 0, 0);
+	blackbird_api_cmd(dev, BLACKBIRD_API_MUTE_AUDIO, 1, 0, BLACKBIRD_UNMUTE);
 	msleep(1);
 
-	blackbird_api_cmd(dev, IVTV_API_BEGIN_CAPTURE, 2, 0, 0, 0x13); /* start capturing to the host interface */
-	//blackbird_api_cmd(dev, IVTV_API_BEGIN_CAPTURE, 2, 0, 0, 0); /* start capturing to the host interface */
-	msleep(1);
+	/* blackbird_api_cmd(dev, BLACKBIRD_API_BEGIN_CAPTURE, 2, 0, 0, 0x13); // start capturing to the host interface */
+	blackbird_api_cmd(dev, BLACKBIRD_API_BEGIN_CAPTURE, 2, 0,
+			BLACKBIRD_MPEG_CAPTURE,
+			BLACKBIRD_RAW_BITS_NONE
+		); /* start capturing to the host interface */
+	msleep(10);
 
-	blackbird_api_cmd(dev, IVTV_API_REFRESH_INPUT, 0,0);
+	blackbird_api_cmd(dev, BLACKBIRD_API_REFRESH_INPUT, 0,0);
 	return 0;
 }
 
@@ -709,7 +1019,12 @@
 {
 	struct cx8802_fh  *fh  = file->private_data;
 
-	blackbird_api_cmd(fh->dev, IVTV_API_END_CAPTURE, 3, 0, 1, 0, 0x13);
+	/* blackbird_api_cmd(fh->dev, BLACKBIRD_API_END_CAPTURE, 3, 0, BLACKBIRD_END_NOW, 0, 0x13); */
+	blackbird_api_cmd(fh->dev, BLACKBIRD_API_END_CAPTURE, 3, 0,
+			BLACKBIRD_END_NOW,
+			BLACKBIRD_MPEG_CAPTURE,
+			BLACKBIRD_RAW_BITS_NONE
+		);
 
 	/* stop mpeg capture */
 	if (fh->mpegq.streaming)
@@ -908,4 +1223,5 @@
  * Local variables:
  * c-basic-offset: 8
  * End:
+ * kate: eol "unix"; indent-width 3; remove-trailing-space on; replace-trailing-space-save on; tab-width 8; replace-tabs off; space-indent off; mixed-indent off
  */

--------------010303030203010305090104--
