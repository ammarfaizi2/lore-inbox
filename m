Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965317AbWCTP16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965317AbWCTP16 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964875AbWCTP1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:27:33 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:42680 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964837AbWCTP0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:26:54 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Peter Hartshorn <p3r@users.sourceforge.net>,
       Hartmut Hackmann <hartmut.hackmann@t-online.de>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 067/141] V4L/DVB (3315): Added support for the Tevion DVB-T
	220RF card
Date: Mon, 20 Mar 2006 12:08:48 -0300
Message-id: <20060320150848.PS158640000067@infradead.org>
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

From: Peter Hartshorn <p3r@users.sourceforge.net>
Date: 1139302153 -0200

This is an analog / digital hybrid card.

Signed-off-by: Peter Hartshorn <p3r@users.sourceforge.net>
Signed-off-by: Hartmut Hackmann <hartmut.hackmann@t-online.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/Documentation/video4linux/CARDLIST.saa7134 b/Documentation/video4linux/CARDLIST.saa7134
diff --git a/Documentation/video4linux/CARDLIST.saa7134 b/Documentation/video4linux/CARDLIST.saa7134
index ee1618d..c10cfd2 100644
--- a/Documentation/video4linux/CARDLIST.saa7134
+++ b/Documentation/video4linux/CARDLIST.saa7134
@@ -86,3 +86,4 @@
  85 -> AverTV DVB-T 777                         [1461:2c05]
  86 -> LifeView FlyDVB-T                        [5168:0301]
  87 -> ADS Instant TV Duo Cardbus PTV331        [0331:1421]
+ 88 -> Tevion DVB-T 220RF                       [17de:7201]
diff --git a/drivers/media/video/saa7134/saa7134-cards.c b/drivers/media/video/saa7134/saa7134-cards.c
diff --git a/drivers/media/video/saa7134/saa7134-cards.c b/drivers/media/video/saa7134/saa7134-cards.c
index d65b9dd..3f41862 100644
--- a/drivers/media/video/saa7134/saa7134-cards.c
+++ b/drivers/media/video/saa7134/saa7134-cards.c
@@ -2674,6 +2674,33 @@ struct saa7134_board saa7134_boards[] = 
 			.gpio   = 0x00200000,
 		}},
 	},
+	[SAA7134_BOARD_TEVION_DVBT_220RF] = {
+		.name           = "Tevion DVB-T 220RF",
+		.audio_clock    = 0x00187de7,
+		.tuner_type     = TUNER_PHILIPS_TDA8290,
+		.radio_type     = UNSET,
+		.tuner_addr     = ADDR_UNSET,
+		.radio_addr     = ADDR_UNSET,
+		.mpeg           = SAA7134_MPEG_DVB,
+		.inputs = {{
+			.name   = name_tv,
+			.vmux   = 1,
+			.amux   = TV,
+			.tv     = 1,
+		},{
+			.name   = name_comp1,
+			.vmux   = 3,
+			.amux   = LINE1,
+		},{
+			.name   = name_svideo,
+			.vmux   = 0,
+			.amux   = LINE1,
+		}},
+		.radio = {
+			.name   = name_radio,
+			.amux   = LINE1,
+		},
+	},
 };
 
 const unsigned int saa7134_bcount = ARRAY_SIZE(saa7134_boards);
@@ -3163,6 +3190,12 @@ struct pci_device_id saa7134_pci_tbl[] =
 		.subdevice    = 0x1421,
 		.driver_data  = SAA7134_BOARD_ADS_DUO_CARDBUS_PTV331,
 	},{
+		.vendor       = PCI_VENDOR_ID_PHILIPS,
+		.device       = PCI_DEVICE_ID_PHILIPS_SAA7133,
+		.subvendor    = 0x17de,
+		.subdevice    = 0x7201,
+		.driver_data  = SAA7134_BOARD_TEVION_DVBT_220RF,
+	},{
 		/* --- boards without eeprom + subsystem ID --- */
 		.vendor       = PCI_VENDOR_ID_PHILIPS,
 		.device       = PCI_DEVICE_ID_PHILIPS_SAA7134,
@@ -3431,8 +3464,11 @@ int saa7134_board_init2(struct saa7134_d
 		}
 		break;
 	case SAA7134_BOARD_PHILIPS_TIGER:
+	case SAA7134_BOARD_TEVION_DVBT_220RF:
 	case SAA7134_BOARD_ASUSTeK_P7131_DUAL:
-		/* this is a hybrid board, initialize to analog mode */
+		/* this is a hybrid board, initialize to analog mode
+		 * and configure firmware eeprom address
+		 */
 		{
 		u8 data[] = { 0x3c, 0x33, 0x68};
 		struct i2c_msg msg = {.addr=0x08, .flags=0, .buf=data, .len = sizeof(data)};
diff --git a/drivers/media/video/saa7134/saa7134-dvb.c b/drivers/media/video/saa7134/saa7134-dvb.c
diff --git a/drivers/media/video/saa7134/saa7134-dvb.c b/drivers/media/video/saa7134/saa7134-dvb.c
index a0c8fa3..56ca3fa 100644
--- a/drivers/media/video/saa7134/saa7134-dvb.c
+++ b/drivers/media/video/saa7134/saa7134-dvb.c
@@ -885,6 +885,38 @@ static struct tda1004x_config ads_tech_d
 	.request_firmware = NULL,
 };
 
+/* ------------------------------------------------------------------ */
+
+static int tevion_dvb220rf_pll_set(struct dvb_frontend *fe, struct dvb_frontend_parameters *params)
+{
+	int ret;
+	ret = philips_tda827xa_pll_set(0x60, fe, params);
+	return ret;
+}
+
+static int tevion_dvb220rf_pll_init(struct dvb_frontend *fe)
+{
+	return 0;
+}
+
+static void tevion_dvb220rf_pll_sleep(struct dvb_frontend *fe)
+{
+	philips_tda827xa_pll_sleep( 0x61, fe);
+}
+
+static struct tda1004x_config tevion_dvbt220rf_config = {
+	.demod_address = 0x08,
+	.invert        = 1,
+	.invert_oclk   = 0,
+	.xtal_freq     = TDA10046_XTAL_16M,
+	.agc_config    = TDA10046_AGC_TDA827X,
+	.if_freq       = TDA10046_FREQ_045,
+	.pll_init      = tevion_dvb220rf_pll_init,
+	.pll_set       = tevion_dvb220rf_pll_set,
+	.pll_sleep     = tevion_dvb220rf_pll_sleep,
+	.request_firmware = NULL,
+};
+
 #endif
 
 /* ------------------------------------------------------------------ */
@@ -971,6 +1003,10 @@ static int dvb_init(struct saa7134_dev *
 		dev->dvb.frontend = tda10046_attach(&ads_tech_duo_config,
 						    &dev->i2c_adap);
 		break;
+	case SAA7134_BOARD_TEVION_DVBT_220RF:
+		dev->dvb.frontend = tda10046_attach(&tevion_dvbt220rf_config,
+						    &dev->i2c_adap);
+		break;
 #endif
 #ifdef HAVE_NXT200X
 	case SAA7134_BOARD_AVERMEDIA_AVERTVHD_A180:
diff --git a/drivers/media/video/saa7134/saa7134.h b/drivers/media/video/saa7134/saa7134.h
diff --git a/drivers/media/video/saa7134/saa7134.h b/drivers/media/video/saa7134/saa7134.h
index 4b49ee0..ff39a63 100644
--- a/drivers/media/video/saa7134/saa7134.h
+++ b/drivers/media/video/saa7134/saa7134.h
@@ -214,6 +214,7 @@ struct saa7134_format {
 #define SAA7134_BOARD_AVERMEDIA_777 85
 #define SAA7134_BOARD_FLYDVBT_LR301 86
 #define SAA7134_BOARD_ADS_DUO_CARDBUS_PTV331 87
+#define SAA7134_BOARD_TEVION_DVBT_220RF 88
 
 #define SAA7134_MAXBOARDS 8
 #define SAA7134_INPUT_MAX 8

