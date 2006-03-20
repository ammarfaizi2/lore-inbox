Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965005AbWCTPbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965005AbWCTPbh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965315AbWCTP12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:27:28 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:45240 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964832AbWCTP1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:27:06 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Jose Alberto Reguero <jareguero@telefonica.net>,
       Hartmut Hackmann <hartmut.hackmann@t-online.de>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 041/141] V4L/DVB (3267): Add support for the Avermedia 777
	DVB-T card
Date: Mon, 20 Mar 2006 12:08:43 -0300
Message-id: <20060320150843.PS838723000041@infradead.org>
In-Reply-To: <20060320150819.PS760228000000@infradead.org>
References: <20060320150819.PS760228000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jose Alberto Reguero <jareguero@telefonica.net>
Date: 1139300714 -0200

Signed-off-by: Jose Alberto Reguero <jareguero@telefonica.net>
Signed-off-by: Hartmut Hackmann <hartmut.hackmann@t-online.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/Documentation/video4linux/CARDLIST.saa7134 b/Documentation/video4linux/CARDLIST.saa7134
diff --git a/Documentation/video4linux/CARDLIST.saa7134 b/Documentation/video4linux/CARDLIST.saa7134
index 8a35259..636792e 100644
--- a/Documentation/video4linux/CARDLIST.saa7134
+++ b/Documentation/video4linux/CARDLIST.saa7134
@@ -83,3 +83,4 @@
  82 -> MSI TV@Anywhere plus                     [1462:6231]
  83 -> Terratec Cinergy 250 PCI TV              [153b:1160]
  84 -> LifeView FlyDVB Trio                     [5168:0319]
+ 85 -> AverTV DVB-T 777                         [1461:2c05]
diff --git a/drivers/media/dvb/frontends/dvb-pll.c b/drivers/media/dvb/frontends/dvb-pll.c
diff --git a/drivers/media/dvb/frontends/dvb-pll.c b/drivers/media/dvb/frontends/dvb-pll.c
index cd8f282..4f68253 100644
--- a/drivers/media/dvb/frontends/dvb-pll.c
+++ b/drivers/media/dvb/frontends/dvb-pll.c
@@ -362,6 +362,48 @@ struct dvb_pll_desc dvb_pll_philips_sd18
 };
 EXPORT_SYMBOL(dvb_pll_philips_sd1878_tda8261);
 
+/*
+ * Philips TD1316 Tuner.
+ */
+static void td1316_bw(u8 *buf, u32 freq, int bandwidth)
+{
+	u8 band;
+
+	/* determine band */
+	if (freq < 161000000)
+		band = 1;
+	else if (freq < 444000000)
+		band = 2;
+	else
+		band = 4;
+
+	buf[3] |= band;
+
+	/* setup PLL filter */
+	if (bandwidth == BANDWIDTH_8_MHZ)
+		buf[3] |= 1 << 3;
+}
+
+struct dvb_pll_desc dvb_pll_philips_td1316 = {
+	.name  = "Philips TD1316",
+	.min   =  87000000,
+	.max   = 895000000,
+	.setbw = td1316_bw,
+	.count = 9,
+	.entries = {
+		{  93834000, 36166000, 166666, 0xca, 0x60},
+		{ 123834000, 36166000, 166666, 0xca, 0xa0},
+		{ 163834000, 36166000, 166666, 0xca, 0xc0},
+		{ 253834000, 36166000, 166666, 0xca, 0x60},
+		{ 383834000, 36166000, 166666, 0xca, 0xa0},
+		{ 443834000, 36166000, 166666, 0xca, 0xc0},
+		{ 583834000, 36166000, 166666, 0xca, 0x60},
+		{ 793834000, 36166000, 166666, 0xca, 0xa0},
+		{ 858834000, 36166000, 166666, 0xca, 0xe0},
+	},
+};
+EXPORT_SYMBOL(dvb_pll_philips_td1316);
+
 /* ----------------------------------------------------------- */
 /* code                                                        */
 
diff --git a/drivers/media/dvb/frontends/dvb-pll.h b/drivers/media/dvb/frontends/dvb-pll.h
diff --git a/drivers/media/dvb/frontends/dvb-pll.h b/drivers/media/dvb/frontends/dvb-pll.h
index 872e3b4..56c3cd7 100644
--- a/drivers/media/dvb/frontends/dvb-pll.h
+++ b/drivers/media/dvb/frontends/dvb-pll.h
@@ -40,6 +40,7 @@ extern struct dvb_pll_desc dvb_pll_tuv12
 extern struct dvb_pll_desc dvb_pll_tdhu2;
 extern struct dvb_pll_desc dvb_pll_samsung_tbmv;
 extern struct dvb_pll_desc dvb_pll_philips_sd1878_tda8261;
+extern struct dvb_pll_desc dvb_pll_philips_td1316;
 
 int dvb_pll_configure(struct dvb_pll_desc *desc, u8 *buf,
 		      u32 freq, int bandwidth);
diff --git a/drivers/media/video/saa7134/saa7134-cards.c b/drivers/media/video/saa7134/saa7134-cards.c
diff --git a/drivers/media/video/saa7134/saa7134-cards.c b/drivers/media/video/saa7134/saa7134-cards.c
index 5a35d3b..3f964ed 100644
--- a/drivers/media/video/saa7134/saa7134-cards.c
+++ b/drivers/media/video/saa7134/saa7134-cards.c
@@ -2619,6 +2619,24 @@ struct saa7134_board saa7134_boards[] = 
 			.gpio = 0x000000,	/* GPIO21=Low for FM radio antenna */
 		},
 	},
+	[SAA7134_BOARD_AVERMEDIA_777] = {
+		.name           = "AverTV DVB-T 777",
+		.audio_clock    = 0x00187de7,
+		.tuner_type     = TUNER_ABSENT,
+		.radio_type     = UNSET,
+		.tuner_addr	= ADDR_UNSET,
+		.radio_addr	= ADDR_UNSET,
+		.mpeg           = SAA7134_MPEG_DVB,
+		.inputs = {{
+			.name   = name_comp1,
+			.vmux   = 0,
+			.amux   = LINE1,
+		},{
+			.name   = name_svideo,
+			.vmux   = 8,
+			.amux   = LINE1,
+		}},
+	},
 };
 
 const unsigned int saa7134_bcount = ARRAY_SIZE(saa7134_boards);
@@ -3090,6 +3108,12 @@ struct pci_device_id saa7134_pci_tbl[] =
 		.subdevice    = 0x0319,
 		.driver_data  = SAA7134_BOARD_FLYDVB_TRIO,
 	},{
+		.vendor       = PCI_VENDOR_ID_PHILIPS,
+		.device       = PCI_DEVICE_ID_PHILIPS_SAA7134,	/* SAA 7131E */
+		.subvendor    = 0x1461,
+		.subdevice    = 0x2c05,
+		.driver_data  = SAA7134_BOARD_AVERMEDIA_777,
+	},{
 		/* --- boards without eeprom + subsystem ID --- */
 		.vendor       = PCI_VENDOR_ID_PHILIPS,
 		.device       = PCI_DEVICE_ID_PHILIPS_SAA7134,
diff --git a/drivers/media/video/saa7134/saa7134-dvb.c b/drivers/media/video/saa7134/saa7134-dvb.c
diff --git a/drivers/media/video/saa7134/saa7134-dvb.c b/drivers/media/video/saa7134/saa7134-dvb.c
index 1a536e8..45b5257 100644
--- a/drivers/media/video/saa7134/saa7134-dvb.c
+++ b/drivers/media/video/saa7134/saa7134-dvb.c
@@ -32,6 +32,7 @@
 #include "saa7134-reg.h"
 #include "saa7134.h"
 #include <media/v4l2-common.h>
+#include "dvb-pll.h"
 
 #ifdef HAVE_MT352
 # include "mt352.h"
@@ -42,7 +43,6 @@
 #endif
 #ifdef HAVE_NXT200X
 # include "nxt200x.h"
-# include "dvb-pll.h"
 #endif
 
 MODULE_AUTHOR("Gerd Knorr <kraxel@bytesex.org> [SuSE Labs]");
@@ -113,6 +113,24 @@ static int mt352_pinnacle_init(struct dv
 	return 0;
 }
 
+static int mt352_aver777_init(struct dvb_frontend* fe)
+{
+	static u8 clock_config []  = { CLOCK_CTL,  0x38, 0x2d };
+	static u8 reset []         = { RESET,      0x80 };
+	static u8 adc_ctl_1_cfg [] = { ADC_CTL_1,  0x40 };
+	static u8 agc_cfg []       = { AGC_TARGET, 0x28, 0xa0 };
+	static u8 capt_range_cfg[] = { CAPT_RANGE, 0x33 };
+
+	mt352_write(fe, clock_config,   sizeof(clock_config));
+	udelay(200);
+	mt352_write(fe, reset,          sizeof(reset));
+	mt352_write(fe, adc_ctl_1_cfg,  sizeof(adc_ctl_1_cfg));
+	mt352_write(fe, agc_cfg,        sizeof(agc_cfg));
+	mt352_write(fe, capt_range_cfg, sizeof(capt_range_cfg));
+
+	return 0;
+}
+
 static int mt352_pinnacle_pll_set(struct dvb_frontend* fe,
 				  struct dvb_frontend_parameters* params,
 				  u8* pllbuf)
@@ -142,6 +160,15 @@ static int mt352_pinnacle_pll_set(struct
 	return 0;
 }
 
+static int mt352_aver777_pll_set(struct dvb_frontend *fe, struct dvb_frontend_parameters *params, u8* pllbuf)
+{
+	pllbuf[0] = 0xc2;
+	dvb_pll_configure(&dvb_pll_philips_td1316, pllbuf+1,
+			  params->frequency,
+			  params->u.ofdm.bandwidth);
+	return 0;
+}
+
 static struct mt352_config pinnacle_300i = {
 	.demod_address = 0x3c >> 1,
 	.adc_clock     = 20333,
@@ -150,6 +177,12 @@ static struct mt352_config pinnacle_300i
 	.demod_init    = mt352_pinnacle_init,
 	.pll_set       = mt352_pinnacle_pll_set,
 };
+
+static struct mt352_config avermedia_777 = {
+	.demod_address = 0xf,
+	.demod_init    = mt352_aver777_init,
+	.pll_set       = mt352_aver777_pll_set,
+};
 #endif
 
 /* ------------------------------------------------------------------ */
@@ -847,6 +880,12 @@ static int dvb_init(struct saa7134_dev *
 		dev->dvb.frontend = mt352_attach(&pinnacle_300i,
 						 &dev->i2c_adap);
 		break;
+
+	case SAA7134_BOARD_AVERMEDIA_777:
+		printk("%s: avertv 777 dvb setup\n",dev->name);
+		dev->dvb.frontend = mt352_attach(&avermedia_777,
+						 &dev->i2c_adap);
+		break;
 #endif
 #ifdef HAVE_TDA1004X
 	case SAA7134_BOARD_MD7134:
diff --git a/drivers/media/video/saa7134/saa7134.h b/drivers/media/video/saa7134/saa7134.h
diff --git a/drivers/media/video/saa7134/saa7134.h b/drivers/media/video/saa7134/saa7134.h
index 3261d8b..3b8f466 100644
--- a/drivers/media/video/saa7134/saa7134.h
+++ b/drivers/media/video/saa7134/saa7134.h
@@ -210,6 +210,7 @@ struct saa7134_format {
 #define SAA7134_BOARD_MSI_TVATANYWHERE_PLUS  82
 #define SAA7134_BOARD_CINERGY250PCI 83
 #define SAA7134_BOARD_FLYDVB_TRIO 84
+#define SAA7134_BOARD_AVERMEDIA_777 85
 
 #define SAA7134_MAXBOARDS 8
 #define SAA7134_INPUT_MAX 8

