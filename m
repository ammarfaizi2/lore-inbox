Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965066AbWCTQBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965066AbWCTQBG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 11:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965670AbWCTQAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 11:00:23 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:49560 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965204AbWCTPRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:17:20 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Markus Rechberger <mrechberger@gmail.com>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 030/141] V4L/DVB (3432): Hauppauge HVR 900 Composite support
Date: Mon, 20 Mar 2006 12:08:42 -0300
Message-id: <20060320150842.PS015650000030@infradead.org>
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

From: Markus Rechberger <mrechberger@gmail.com>
Date: 1138043470 -0200

- Hauppauge HVR 900 Composite support

Signed-off-by: Markus Rechberger <mrechberger@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/em28xx/em28xx-cards.c b/drivers/media/video/em28xx/em28xx-cards.c
diff --git a/drivers/media/video/em28xx/em28xx-cards.c b/drivers/media/video/em28xx/em28xx-cards.c
index 58f7b41..ed428c5 100644
--- a/drivers/media/video/em28xx/em28xx-cards.c
+++ b/drivers/media/video/em28xx/em28xx-cards.c
@@ -136,6 +136,28 @@ struct em28xx_board em28xx_boards[] = {
 			.amux     = 1,
 		}},
 	},
+	[EM2880_BOARD_WINTV_HVR_900] = {
+		.name         = "WinTV HVR 900",
+		.vchannels    = 3,
+		.norm         = VIDEO_MODE_PAL,
+		.has_tuner    = 0,
+		.tda9887_conf = TDA9887_PRESENT,
+		.has_tuner    = 1,
+		.decoder      = EM28XX_TVP5150,
+		.input          = {{
+			.type     = EM28XX_VMUX_COMPOSITE1,
+			.vmux     = 2,
+			.amux     = 0,
+		},{
+			.type     = EM28XX_VMUX_TELEVISION,
+			.vmux     = 0,
+			.amux     = 1,
+		},{
+			.type     = EM28XX_VMUX_SVIDEO,
+			.vmux     = 9,
+			.amux     = 1,
+		}},
+	},
 	[EM2820_BOARD_MSI_VOX_USB_2] = {
 		.name		= "MSI VOX USB 2.0",
 		.vchannels	= 3,
@@ -254,30 +276,47 @@ struct usb_device_id em28xx_id_table [] 
 	{ USB_DEVICE(0x2304, 0x0208), .driver_info = EM2820_BOARD_PINNACLE_USB_2 },
 	{ USB_DEVICE(0x2040, 0x4200), .driver_info = EM2820_BOARD_HAUPPAUGE_WINTV_USB_2 },
 	{ USB_DEVICE(0x2304, 0x0207), .driver_info = EM2820_BOARD_PINNACLE_DVC_90 },
+	{ USB_DEVICE(0x2040, 0x6500), .driver_info = EM2880_BOARD_WINTV_HVR_900 },
 	{ },
 };
 
+void em28xx_pre_card_setup(struct em28xx *dev)
+{
+	/* request some modules */
+	switch(dev->model){
+		case EM2880_BOARD_WINTV_HVR_900:
+			{
+				em28xx_write_regs_req(dev, 0x00, 0x08, "\x7d", 1); // reset through GPIO?
+				break;
+			}
+	}
+}
+
 void em28xx_card_setup(struct em28xx *dev)
 {
 	/* request some modules */
-	if (dev->model == EM2820_BOARD_HAUPPAUGE_WINTV_USB_2) {
-		struct tveeprom tv;
+	switch(dev->model){
+		case EM2820_BOARD_HAUPPAUGE_WINTV_USB_2:
+			{
+				struct tveeprom tv;
 #ifdef CONFIG_MODULES
-		request_module("tveeprom");
-		request_module("ir-kbd-i2c");
-		request_module("msp3400");
+				request_module("tveeprom");
+				request_module("ir-kbd-i2c");
+				request_module("msp3400");
 #endif
-		/* Call first TVeeprom */
+				/* Call first TVeeprom */
 
-		dev->i2c_client.addr = 0xa0 >> 1;
-		tveeprom_hauppauge_analog(&dev->i2c_client, &tv, dev->eedata);
+				dev->i2c_client.addr = 0xa0 >> 1;
+				tveeprom_hauppauge_analog(&dev->i2c_client, &tv, dev->eedata);
 
-		dev->tuner_type= tv.tuner_type;
-		if (tv.audio_processor == AUDIO_CHIP_MSP34XX) {
-			dev->i2s_speed=2048000;
-			dev->has_msp34xx=1;
-		} else
-			dev->has_msp34xx=0;
+				dev->tuner_type= tv.tuner_type;
+				if (tv.audio_processor == AUDIO_CHIP_MSP34XX) {
+					dev->i2s_speed=2048000;
+					dev->has_msp34xx=1;
+				} else
+					dev->has_msp34xx=0;
+				break;
+			}
 	}
 }
 
diff --git a/drivers/media/video/em28xx/em28xx-video.c b/drivers/media/video/em28xx/em28xx-video.c
diff --git a/drivers/media/video/em28xx/em28xx-video.c b/drivers/media/video/em28xx/em28xx-video.c
index 1b0e10d..1726b2c 100644
--- a/drivers/media/video/em28xx/em28xx-video.c
+++ b/drivers/media/video/em28xx/em28xx-video.c
@@ -1766,6 +1766,7 @@ static int em28xx_init_dev(struct em28xx
 	dev->vpic.depth = 16;
 	dev->vpic.palette = VIDEO_PALETTE_YUV422;
 
+	em28xx_pre_card_setup(dev);
 #ifdef CONFIG_MODULES
 	/* request some modules */
 	if (dev->decoder == EM28XX_SAA7113 || dev->decoder == EM28XX_SAA7114)
diff --git a/drivers/media/video/em28xx/em28xx.h b/drivers/media/video/em28xx/em28xx.h
diff --git a/drivers/media/video/em28xx/em28xx.h b/drivers/media/video/em28xx/em28xx.h
index 119fdbe..8269cca 100644
--- a/drivers/media/video/em28xx/em28xx.h
+++ b/drivers/media/video/em28xx/em28xx.h
@@ -41,6 +41,7 @@
 #define EM2800_BOARD_LEADTEK_WINFAST_USBII      7
 #define EM2800_BOARD_KWORLD_USB2800             8
 #define EM2820_BOARD_PINNACLE_DVC_90		9
+#define EM2880_BOARD_WINTV_HVR_900              10
 
 #define UNSET -1
 
@@ -327,6 +328,7 @@ int em28xx_set_alternate(struct em28xx *
 
 /* Provided by em28xx-cards.c */
 extern int em2800_variant_detect(struct usb_device* udev,int model);
+extern void em28xx_pre_card_setup(struct em28xx *dev);
 extern void em28xx_card_setup(struct em28xx *dev);
 extern struct em28xx_board em28xx_boards[];
 extern struct usb_device_id em28xx_id_table[];

