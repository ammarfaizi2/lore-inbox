Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262131AbVGGAXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbVGGAXh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 20:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbVGFUAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:00:10 -0400
Received: from kirby.webscope.com ([204.141.84.57]:23229 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S262316AbVGFQlU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 12:41:20 -0400
Message-ID: <42CC0965.8080801@m1k.net>
Date: Wed, 06 Jul 2005 12:40:05 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux and Kernel Video <video4linux-list@redhat.com>,
       linux-kernel@vger.kernel.org,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       Johannes Stezenbach <js@linuxtv.org>
Subject: [PATCH] v4l: add DVB support for DViCO FusionHDTV3 Gold-T
Content-Type: multipart/mixed;
 boundary="------------090900090808030203020307"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090900090808030203020307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch depends on:

dvb-frontend-add-driver-for-lgdt3302.patch
v4l-add-dvb-support-for-dvico-fusionhdtv3-gold-q.patch

This is NOT a duplicate patch... Previous patch was for FusionHDTV 
Gold-Q .... This patch is for the Gold-T model.



--------------090900090808030203020307
Content-Type: text/plain;
 name="v4l-add-dvb-support-for-dvico-fusionhdtv3-gold-t.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="v4l-add-dvb-support-for-dvico-fusionhdtv3-gold-t.patch"

- Correct sync byte for MPEG-2 transport stream packets.
- Add lgdt3302 as dependency of cx88-dvb in Kconfig.
- Add dvb support in v4l for DViCO FusionHDTV3 Gold-T using lgdt3302 frontend.
  This adds support for a different board from the previous (Gold-Q) patch.

Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 linux/drivers/media/dvb/frontends/dvb-pll.c |   13 ++++++++++++
 linux/drivers/media/dvb/frontends/dvb-pll.h |    1 
 linux/drivers/media/video/Kconfig           |    1 
 linux/drivers/media/video/cx88/cx88-cards.c |    3 +-
 linux/drivers/media/video/cx88/cx88-dvb.c   |   21 ++++++++++++++++++++
 linux/drivers/media/video/cx88/cx88-mpeg.c  |    8 +++----
 6 files changed, 42 insertions(+), 5 deletions(-)

diff -u linux-2.6.13/drivers/media/video/cx88/cx88-cards.c linux/drivers/media/video/cx88/cx88-cards.c
--- linux-2.6.13/drivers/media/video/cx88/cx88-cards.c	2005-07-05 00:35:06.000000000 +0000
+++ linux/drivers/media/video/cx88/cx88-cards.c	2005-07-06 08:17:22.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88-cards.c,v 1.84 2005/07/02 19:42:09 mkrufky Exp $
+ * $Id: cx88-cards.c,v 1.85 2005/07/04 19:35:05 mkrufky Exp $
  *
  * device driver for Conexant 2388x based TV cards
  * card-specific stuff.
@@ -723,6 +723,7 @@
                         .vmux   = 2,
                         .gpio0  = 0x0f00,
                 }},
+		.dvb            = 1,
         },
         [CX88_BOARD_ADSTECH_DVB_T_PCI] = {
                 .name           = "ADS Tech Instant TV DVB-T PCI",
diff -u linux-2.6.13/drivers/media/video/cx88/cx88-mpeg.c linux/drivers/media/video/cx88/cx88-mpeg.c
--- linux-2.6.13/drivers/media/video/cx88/cx88-mpeg.c	2005-07-05 00:34:56.000000000 +0000
+++ linux/drivers/media/video/cx88/cx88-mpeg.c	2005-07-06 08:17:22.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88-mpeg.c,v 1.28 2005/06/20 03:36:00 mkrufky Exp $
+ * $Id: cx88-mpeg.c,v 1.30 2005/07/05 19:44:40 mkrufky Exp $
  *
  *  Support for the mpeg transport stream transfers
  *  PCI function #2 of the cx2388x.
@@ -73,11 +73,11 @@
 		cx_write(TS_GEN_CNTRL, 0x0040 | dev->ts_gen_cntrl);
 		udelay(100);
 		cx_write(MO_PINMUX_IO, 0x00);
-		if (core->board == CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD_Q) {
-			cx_write(TS_HW_SOP_CNTRL,0x47<<16 | 188<<4 | 0x00);
+		cx_write(TS_HW_SOP_CNTRL,0x47<<16|188<<4|0x01);
+		if ((core->board == CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD_Q) ||
+		    (core->board == CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD_T)) {
 			cx_write(TS_SOP_STAT, 0<<16 | 0<<14 | 1<<13 | 0<<12);
 		} else {
-			cx_write(TS_HW_SOP_CNTRL,47<<16|188<<4|0x00);
 			cx_write(TS_SOP_STAT,0x00);
 		}
 		cx_write(TS_GEN_CNTRL, dev->ts_gen_cntrl);
diff -u linux-2.6.13/drivers/media/video/cx88/cx88-dvb.c linux/drivers/media/video/cx88/cx88-dvb.c
--- linux-2.6.13/drivers/media/video/cx88/cx88-dvb.c	2005-07-05 00:35:06.000000000 +0000
+++ linux/drivers/media/video/cx88/cx88-dvb.c	2005-07-06 08:17:22.000000000 +0000
@@ -220,6 +220,13 @@
 	.pll_desc         = &dvb_pll_microtune_4042,
 	.set_ts_params    = lgdt3302_set_ts_param,
 };
+
+static struct lgdt3302_config fusionhdtv_3_gold_t = {
+	.demod_address    = 0x0e,
+	.pll_address      = 0x61,
+	.pll_desc         = &dvb_pll_thomson_dtt7611,
+	.set_ts_params    = lgdt3302_set_ts_param,
+};
 #endif
 
 static int dvb_register(struct cx8802_dev *dev)
@@ -282,6 +289,20 @@
 						    &dev->core->i2c_adap);
 		}
 		break;
+	case CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD_T:
+		dev->ts_gen_cntrl = 0x08;
+		{
+		/* Do a hardware reset of chip before using it. */
+		struct cx88_core *core = dev->core;
+
+		cx_clear(MO_GP0_IO, 1);
+		mdelay(100);
+		cx_set(MO_GP0_IO, 9); /* ANT connector too FIXME */
+		mdelay(200);
+		dev->dvb.frontend = lgdt3302_attach(&fusionhdtv_3_gold_t,
+						    &dev->core->i2c_adap);
+		}
+		break;
 #endif
 	default:
 		printk("%s: The frontend of your DVB/ATSC card isn't supported yet\n",
diff -u linux-2.6.13/drivers/media/dvb/frontends/dvb-pll.c linux/drivers/media/dvb/frontends/dvb-pll.c
--- linux-2.6.13/drivers/media/dvb/frontends/dvb-pll.c	2005-07-05 00:42:14.000000000 +0000
+++ linux/drivers/media/dvb/frontends/dvb-pll.c	2005-07-06 08:17:22.000000000 +0000
@@ -106,6 +106,19 @@
 };
 EXPORT_SYMBOL(dvb_pll_microtune_4042);
 
+struct dvb_pll_desc dvb_pll_thomson_dtt7611 = {
+	.name  = "Thomson dtt7611",
+	.min   =  44000000,
+	.max   = 958000000,
+	.count = 3,
+	.entries = {
+		{ 157250000, 44000000, 62500, 0x8e, 0x39 },
+		{ 454000000, 44000000, 62500, 0x8e, 0x3a },
+		{ 999999999, 44000000, 62500, 0x8e, 0x3c },
+	},
+};
+EXPORT_SYMBOL(dvb_pll_thomson_dtt7611);
+
 struct dvb_pll_desc dvb_pll_unknown_1 = {
 	.name  = "unknown 1", /* used by dntv live dvb-t */
 	.min   = 174000000,
diff -u linux-2.6.13/drivers/media/dvb/frontends/dvb-pll.h linux/drivers/media/dvb/frontends/dvb-pll.h
--- linux-2.6.13/drivers/media/dvb/frontends/dvb-pll.h	2005-07-05 00:42:14.000000000 +0000
+++ linux/drivers/media/dvb/frontends/dvb-pll.h	2005-07-06 08:17:22.000000000 +0000
@@ -25,6 +25,7 @@
 extern struct dvb_pll_desc dvb_pll_thomson_dtt7610;
 extern struct dvb_pll_desc dvb_pll_lg_z201;
 extern struct dvb_pll_desc dvb_pll_microtune_4042;
+extern struct dvb_pll_desc dvb_pll_thomson_dtt7611;
 extern struct dvb_pll_desc dvb_pll_unknown_1;
 
 extern struct dvb_pll_desc dvb_pll_tua6010xs;
diff -u linux-2.6.13/drivers/media/video/Kconfig linux/drivers/media/video/Kconfig
--- linux-2.6.13/drivers/media/video/Kconfig	2005-07-05 00:34:29.000000000 +0000
+++ linux/drivers/media/video/Kconfig	2005-07-06 08:17:22.000000000 +0000
@@ -344,6 +344,7 @@
 	select DVB_MT352
 	select DVB_OR51132
 	select DVB_CX22702
+	select DVB_LGDT3302
 	---help---
 	  This adds support for DVB/ATSC cards based on the
 	  Connexant 2388x chip.

--------------090900090808030203020307--

