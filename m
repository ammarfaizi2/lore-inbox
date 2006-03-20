Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965170AbWCTQGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965170AbWCTQGI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 11:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965077AbWCTQGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 11:06:07 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:30872 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965170AbWCTPPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:15:20 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Andrew Burri <andrew.burri@gmail.com>,
       Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 096/141] V4L/DVB (3361): Add support for Kworld ATSC110
Date: Mon, 20 Mar 2006 12:08:53 -0300
Message-id: <20060320150853.PS015222000096@infradead.org>
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

From: Andrew Burri <andrew.burri@gmail.com>
Date: 1141009703 -0300

Signed-off-by: Andrew Burri <andrew.burri@gmail.com>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/Documentation/video4linux/CARDLIST.saa7134 b/Documentation/video4linux/CARDLIST.saa7134
diff --git a/Documentation/video4linux/CARDLIST.saa7134 b/Documentation/video4linux/CARDLIST.saa7134
index 7d16376..f74d2f9 100644
--- a/Documentation/video4linux/CARDLIST.saa7134
+++ b/Documentation/video4linux/CARDLIST.saa7134
@@ -88,3 +88,4 @@
  87 -> ADS Instant TV Duo Cardbus PTV331        [0331:1421]
  88 -> Tevion DVB-T 220RF                       [17de:7201]
  89 -> ELSA EX-VISION 700TV                     [1131:7130]
+ 90 -> KWORLD ATSC110                           [17de:7350]
diff --git a/drivers/media/video/saa7134/saa7134-cards.c b/drivers/media/video/saa7134/saa7134-cards.c
diff --git a/drivers/media/video/saa7134/saa7134-cards.c b/drivers/media/video/saa7134/saa7134-cards.c
index 602c614..6ce9c08 100644
--- a/drivers/media/video/saa7134/saa7134-cards.c
+++ b/drivers/media/video/saa7134/saa7134-cards.c
@@ -2731,6 +2731,22 @@ struct saa7134_board saa7134_boards[] = 
 			.amux   = LINE1,
 		},
 	},
+	[SAA7134_BOARD_KWORLD_ATSC110] = {
+		.name           = "KWORLD ATSC110",
+		.audio_clock    = 0x00187de7,
+		.tuner_type     = TUNER_PHILIPS_TUV1236D,
+		.radio_type     = UNSET,
+		.tuner_addr     = ADDR_UNSET,
+		.radio_addr     = ADDR_UNSET,
+		.tda9887_conf   = TDA9887_PRESENT,
+		.mpeg           = SAA7134_MPEG_DVB,
+		.inputs         = {{
+			.name = name_tv,
+			.vmux = 1,
+			.amux = TV,
+			.tv   = 1,
+		}},
+	},
 };
 
 const unsigned int saa7134_bcount = ARRAY_SIZE(saa7134_boards);
@@ -3232,6 +3248,12 @@ struct pci_device_id saa7134_pci_tbl[] =
 		.subdevice    = 0x7201,
 		.driver_data  = SAA7134_BOARD_TEVION_DVBT_220RF,
 	},{
+		.vendor       = PCI_VENDOR_ID_PHILIPS,
+		.device       = PCI_DEVICE_ID_PHILIPS_SAA7133, /* SAA7135HL */
+		.subvendor    = 0x17de,
+		.subdevice    = 0x7350,
+		.driver_data  = SAA7134_BOARD_KWORLD_ATSC110,
+	},{
 		/* --- boards without eeprom + subsystem ID --- */
 		.vendor       = PCI_VENDOR_ID_PHILIPS,
 		.device       = PCI_DEVICE_ID_PHILIPS_SAA7134,
diff --git a/drivers/media/video/saa7134/saa7134-dvb.c b/drivers/media/video/saa7134/saa7134-dvb.c
diff --git a/drivers/media/video/saa7134/saa7134-dvb.c b/drivers/media/video/saa7134/saa7134-dvb.c
index 56ca3fa..354bbf7 100644
--- a/drivers/media/video/saa7134/saa7134-dvb.c
+++ b/drivers/media/video/saa7134/saa7134-dvb.c
@@ -927,6 +927,12 @@ static struct nxt200x_config avertvhda18
 	.pll_address      = 0x61,
 	.pll_desc         = &dvb_pll_tdhu2,
 };
+
+static struct nxt200x_config kworldatsc110 = {
+	.demod_address    = 0x0a,
+	.pll_address      = 0x61,
+	.pll_desc         = &dvb_pll_tuv1236d,
+};
 #endif
 
 /* ------------------------------------------------------------------ */
@@ -1012,6 +1018,9 @@ static int dvb_init(struct saa7134_dev *
 	case SAA7134_BOARD_AVERMEDIA_AVERTVHD_A180:
 		dev->dvb.frontend = nxt200x_attach(&avertvhda180, &dev->i2c_adap);
 		break;
+	case SAA7134_BOARD_KWORLD_ATSC110:
+		dev->dvb.frontend = nxt200x_attach(&kworldatsc110, &dev->i2c_adap);
+		break;
 #endif
 	default:
 		printk("%s: Huh? unknown DVB card?\n",dev->name);
diff --git a/drivers/media/video/saa7134/saa7134.h b/drivers/media/video/saa7134/saa7134.h
diff --git a/drivers/media/video/saa7134/saa7134.h b/drivers/media/video/saa7134/saa7134.h
index 55a6733..f8c9b67 100644
--- a/drivers/media/video/saa7134/saa7134.h
+++ b/drivers/media/video/saa7134/saa7134.h
@@ -217,6 +217,7 @@ struct saa7134_format {
 #define SAA7134_BOARD_ADS_DUO_CARDBUS_PTV331 87
 #define SAA7134_BOARD_TEVION_DVBT_220RF 88
 #define SAA7134_BOARD_ELSA_700TV       89
+#define SAA7134_BOARD_KWORLD_ATSC110   90
 
 #define SAA7134_MAXBOARDS 8
 #define SAA7134_INPUT_MAX 8

