Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966448AbWCTPQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966448AbWCTPQZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966457AbWCTPQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:16:25 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:38040 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966449AbWCTPQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:16:09 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Nico Sabbi <nsabbi@tiscali.it>,
       Hartmut Hackmann <hartmut.hackmann@t-online.de>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 124/141] V4L/DVB (3396): Add DVB-T support for the LifeView
	DVB Trio PCI card
Date: Mon, 20 Mar 2006 12:08:57 -0300
Message-id: <20060320150857.PS743293000124@infradead.org>
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

From: Nico Sabbi <nsabbi@tiscali.it>
Date: 1141398688 -0300

This patch adds DVB-T support, no DVB-S yet

Signed-off-by: Nico Sabbi <nsabbi@tiscali.it>
Signed-off-by: Hartmut Hackmann <hartmut.hackmann@t-online.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/saa7134/saa7134-cards.c b/drivers/media/video/saa7134/saa7134-cards.c
diff --git a/drivers/media/video/saa7134/saa7134-cards.c b/drivers/media/video/saa7134/saa7134-cards.c
index 722ebff..288d1f8 100644
--- a/drivers/media/video/saa7134/saa7134-cards.c
+++ b/drivers/media/video/saa7134/saa7134-cards.c
@@ -2624,6 +2624,7 @@ struct saa7134_board saa7134_boards[] = 
 		.tuner_addr	= ADDR_UNSET,
 		.radio_addr	= ADDR_UNSET,
 		.gpiomask	= 0x00200000,
+		.mpeg           = SAA7134_MPEG_DVB,	/* FIXME: DVB not implemented yet */
 		.inputs         = {{
 			.name = name_tv,	/* Analog broadcast/cable TV */
 			.vmux = 1,
@@ -3547,6 +3548,7 @@ int saa7134_board_init2(struct saa7134_d
 		i2c_transfer(&dev->i2c_adap, &msg, 1);
 		}
 		break;
+	case SAA7134_BOARD_FLYDVB_TRIO:
 	case SAA7134_BOARD_ADS_DUO_CARDBUS_PTV331:
 		/* make the tda10046 find its eeprom */
 		{
diff --git a/drivers/media/video/saa7134/saa7134-dvb.c b/drivers/media/video/saa7134/saa7134-dvb.c
diff --git a/drivers/media/video/saa7134/saa7134-dvb.c b/drivers/media/video/saa7134/saa7134-dvb.c
index 5969481..ad34eb5 100644
--- a/drivers/media/video/saa7134/saa7134-dvb.c
+++ b/drivers/media/video/saa7134/saa7134-dvb.c
@@ -852,6 +852,39 @@ static struct tda1004x_config philips_ti
 
 /* ------------------------------------------------------------------ */
 
+static int lifeview_trio_pll_set(struct dvb_frontend *fe, struct dvb_frontend_parameters *params)
+{
+	int ret;
+
+	ret = philips_tda827xa_pll_set(0x60, fe, params);
+	return ret;
+}
+
+static int lifeview_trio_dvb_mode(struct dvb_frontend *fe)
+{
+	return 0;
+}
+
+static void lifeview_trio_analog_mode(struct dvb_frontend *fe)
+{
+	philips_tda827xa_pll_sleep(0x60, fe);
+}
+
+static struct tda1004x_config lifeview_trio_config = {
+	.demod_address = 0x09,
+	.invert        = 1,
+	.invert_oclk   = 0,
+	.xtal_freq     = TDA10046_XTAL_16M,
+	.agc_config    = TDA10046_AGC_TDA827X_GPL,
+	.if_freq       = TDA10046_FREQ_045,
+	.pll_init      = lifeview_trio_dvb_mode,
+	.pll_set       = lifeview_trio_pll_set,
+	.pll_sleep     = lifeview_trio_analog_mode,
+	.request_firmware = NULL,
+};
+
+/* ------------------------------------------------------------------ */
+
 static int ads_duo_pll_set(struct dvb_frontend *fe, struct dvb_frontend_parameters *params)
 {
 	int ret;
@@ -1019,6 +1052,10 @@ static int dvb_init(struct saa7134_dev *
 		dev->dvb.frontend = tda10046_attach(&tda827x_lifeview_config,
 						    &dev->i2c_adap);
 		break;
+	case SAA7134_BOARD_FLYDVB_TRIO:
+		dev->dvb.frontend = tda10046_attach(&lifeview_trio_config,
+						    &dev->i2c_adap);
+		break;
 	case SAA7134_BOARD_ADS_DUO_CARDBUS_PTV331:
 		dev->dvb.frontend = tda10046_attach(&ads_tech_duo_config,
 						    &dev->i2c_adap);

