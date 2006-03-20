Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965638AbWCTP5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965638AbWCTP5x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965639AbWCTP5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:57:53 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:61848 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964841AbWCTPSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:18:39 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Markus Rechberger <mrechberger@gmail.com>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 078/141] V4L/DVB (3291): Added support for xc3028 analogue
	tuner  (Hauppauge HVR900, Terratec Hybrid XS)
Date: Mon, 20 Mar 2006 12:08:50 -0300
Message-id: <20060320150850.PS044154000078@infradead.org>
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
Date: 1141009647 -0300

Added support for xc3028 to v4l which adds support for:
 * Terratec Hybrid XS (analogue)
 * Hauppauge HVR 900 (analogue)


Signed-off-by: Markus Rechberger <mrechberger@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/Documentation/video4linux/CARDLIST.tuner b/Documentation/video4linux/CARDLIST.tuner
diff --git a/Documentation/video4linux/CARDLIST.tuner b/Documentation/video4linux/CARDLIST.tuner
index f6d0cf7..de48438 100644
--- a/Documentation/video4linux/CARDLIST.tuner
+++ b/Documentation/video4linux/CARDLIST.tuner
@@ -69,3 +69,4 @@ tuner=67 - Philips TD1316 Hybrid Tuner
 tuner=68 - Philips TUV1236D ATSC/NTSC dual in
 tuner=69 - Tena TNF 5335 MF
 tuner=70 - Samsung TCPN 2121P30A
+tuner=71 - Xceive xc3028
diff --git a/drivers/media/video/Makefile b/drivers/media/video/Makefile
diff --git a/drivers/media/video/Makefile b/drivers/media/video/Makefile
index faf7283..60e9c6e 100644
--- a/drivers/media/video/Makefile
+++ b/drivers/media/video/Makefile
@@ -9,7 +9,7 @@ zoran-objs      :=	zr36120.o zr36120_i2c
 zr36067-objs	:=	zoran_procfs.o zoran_device.o \
 			zoran_driver.o zoran_card.o
 tuner-objs	:=	tuner-core.o tuner-types.o tuner-simple.o \
-			mt20xx.o tda8290.o tea5767.o
+			mt20xx.o tda8290.o tea5767.o xc3028.o
 
 msp3400-objs	:=	msp3400-driver.o msp3400-kthreads.o
 
diff --git a/drivers/media/video/em28xx/em28xx-cards.c b/drivers/media/video/em28xx/em28xx-cards.c
diff --git a/drivers/media/video/em28xx/em28xx-cards.c b/drivers/media/video/em28xx/em28xx-cards.c
index 703927e..e9834c1 100644
--- a/drivers/media/video/em28xx/em28xx-cards.c
+++ b/drivers/media/video/em28xx/em28xx-cards.c
@@ -158,8 +158,8 @@ struct em28xx_board em28xx_boards[] = {
 		.name         = "Hauppauge WinTV HVR 900",
 		.vchannels    = 3,
 		.norm         = VIDEO_MODE_PAL,
-		.has_tuner    = 0,
 		.tda9887_conf = TDA9887_PRESENT,
+		.tuner_type   = TUNER_XCEIVE_XC3028,
 		.has_tuner    = 1,
 		.decoder      = EM28XX_TVP5150,
 		.input          = {{
@@ -180,8 +180,8 @@ struct em28xx_board em28xx_boards[] = {
 		.name         = "Terratec Hybrid XS",
 		.vchannels    = 3,
 		.norm         = VIDEO_MODE_PAL,
-		.has_tuner    = 0,
 		.tda9887_conf = TDA9887_PRESENT,
+		.tuner_type   = TUNER_XCEIVE_XC3028,
 		.has_tuner    = 1,
 		.decoder      = EM28XX_TVP5150,
 		.input          = {{
diff --git a/drivers/media/video/tuner-core.c b/drivers/media/video/tuner-core.c
diff --git a/drivers/media/video/tuner-core.c b/drivers/media/video/tuner-core.c
index e34f801..520f274 100644
--- a/drivers/media/video/tuner-core.c
+++ b/drivers/media/video/tuner-core.c
@@ -217,6 +217,9 @@ static void set_type(struct i2c_client *
 		i2c_master_send(c,buffer,4);
 		default_tuner_init(c);
 		break;
+	case TUNER_XCEIVE_XC3028:
+		xc3028_init(c);
+		break;
 	default:
 		default_tuner_init(c);
 		break;
diff --git a/drivers/media/video/tuner-types.c b/drivers/media/video/tuner-types.c
diff --git a/drivers/media/video/tuner-types.c b/drivers/media/video/tuner-types.c
index a90bc04..a4384e6 100644
--- a/drivers/media/video/tuner-types.c
+++ b/drivers/media/video/tuner-types.c
@@ -983,6 +983,23 @@ static struct tuner_params tuner_samsung
 	},
 };
 
+/* ------------ TUNER_XCEIVE_XC3028 - Xceive xc3028 ------------ */
+
+static struct tuner_range tuner_xceive_xc3028_ranges[] = {
+	{ 16 * 140.25 /*MHz*/, 0x02, },
+	{ 16 * 463.25 /*MHz*/, 0x04, },
+	{ 16 * 999.99        , 0x01, },
+};
+
+static struct tuner_params tuner_xceive_xc3028_params[] = {
+	{
+		.type   = TUNER_XCEIVE_XC3028,
+		.ranges = tuner_xceive_xc3028_ranges,
+		.count  = ARRAY_SIZE(tuner_xceive_xc3028_ranges),
+	},
+};
+
+
 /* --------------------------------------------------------------------- */
 
 struct tunertype tuners[] = {
@@ -1350,6 +1367,10 @@ struct tunertype tuners[] = {
 		.params = tuner_samsung_tcpn_2121p30a_params,
 		.count  = ARRAY_SIZE(tuner_samsung_tcpn_2121p30a_params),
 	},
+	[TUNER_XCEIVE_XC3028] = { /* Xceive 3028 */
+		.name	= "Xceive xc3028",
+		.params = tuner_xceive_xc3028_params,
+	},
 };
 
 unsigned const int tuner_count = ARRAY_SIZE(tuners);
diff --git a/include/media/tuner.h b/include/media/tuner.h
diff --git a/include/media/tuner.h b/include/media/tuner.h
index a5beeac..f51759c 100644
--- a/include/media/tuner.h
+++ b/include/media/tuner.h
@@ -117,6 +117,8 @@
 #define TUNER_TNF_5335MF                69	/* Sabrent Bt848   */
 #define TUNER_SAMSUNG_TCPN_2121P30A     70 	/* Hauppauge PVR-500MCE NTSC */
 
+#define TUNER_XCEIVE_XC3028		71
+
 /* tv card specific */
 #define TDA9887_PRESENT 		(1<<0)
 #define TDA9887_PORT1_INACTIVE 		(1<<1)
@@ -209,6 +211,7 @@ struct tuner {
 extern unsigned const int tuner_count;
 
 extern int microtune_init(struct i2c_client *c);
+extern int xc3028_init(struct i2c_client *c);
 extern int tda8290_init(struct i2c_client *c);
 extern int tda8290_probe(struct i2c_client *c);
 extern int tea5767_tuner_init(struct i2c_client *c);

