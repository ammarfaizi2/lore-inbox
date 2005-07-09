Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263045AbVGIAoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263045AbVGIAoA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 20:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263028AbVGIAmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 20:42:12 -0400
Received: from smtp4.brturbo.com.br ([200.199.201.180]:60805 "EHLO
	smtp4.brturbo.com.br") by vger.kernel.org with ESMTP
	id S263023AbVGIAkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 20:40:17 -0400
Message-ID: <42CF1CED.1000103@brturbo.com.br>
Date: Fri, 08 Jul 2005 21:40:13 -0300
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: pt-br, pt, es, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/14 2.6.13-rc2-mm1] V4L SAA7134 hybrid DVB
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------010905090506040106060902"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010905090506040106060902
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------010905090506040106060902
Content-Type: text/x-patch;
 name="v4l_dvb-saa7134.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="v4l_dvb-saa7134.diff"

- Add new Typhoon DVB-T Cardbus.
- DVB-T support for MD7134 cardbus and the PCI variants
- initial DVB-T support for Lifeview Flydvb-t duo
- DVB-T support for Philips TOUGH reference design
- Don't turn off the xtal output of tda8274/75 in sleep mode
- Let Kconfig decide whether to include frontend-specific code in saa7134-dvb.
- Removed unused structures.

Signed-off-by: Juergen Orschiedt <jorschiedt@web.de>
Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Hartmut Hackmann <hartmut.hackmann@t-online.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

 linux/drivers/media/video/saa7134/saa6752hs.c   |    4 
 linux/drivers/media/video/saa7134/saa7134-dvb.c |  420 ++++++++++++++--
 linux/include/media/saa6752hs.h                 |   49 -
 3 files changed, 389 insertions(+), 84 deletions(-)

diff -u linux-2.6.13/drivers/media/video/saa7134/saa7134-dvb.c linux/drivers/media/video/saa7134/saa7134-dvb.c
--- linux-2.6.13/drivers/media/video/saa7134/saa7134-dvb.c	2005-07-06 00:46:33.000000000 -0300
+++ linux/drivers/media/video/saa7134/saa7134-dvb.c	2005-07-07 19:05:23.000000000 -0300
@@ -1,8 +1,11 @@
 /*
- * $Id: saa7134-dvb.c,v 1.13 2005/06/12 04:19:19 mchehab Exp $
+ * $Id: saa7134-dvb.c,v 1.18 2005/07/04 16:05:50 mkrufky Exp $
  *
  * (c) 2004 Gerd Knorr <kraxel@bytesex.org> [SuSE Labs]
  *
+ *  Extended 3 / 2005 by Hartmut Hackmann to support various
+ *  cards with the tda10046 DVB-T channel decoder
+ *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
  *  the Free Software Foundation; either version 2 of the License, or
@@ -30,20 +33,25 @@
 #include "saa7134-reg.h"
 #include "saa7134.h"
 
-#include "dvb-pll.h"
-#include "mt352.h"
-#include "mt352_priv.h" /* FIXME */
-#include "tda1004x.h"
+#if CONFIG_DVB_MT352
+# include "mt352.h"
+# include "mt352_priv.h" /* FIXME */
+#endif
+#if CONFIG_DVB_TDA1004X
+# include "tda1004x.h"
+#endif
 
 MODULE_AUTHOR("Gerd Knorr <kraxel@bytesex.org> [SuSE Labs]");
 MODULE_LICENSE("GPL");
 
 static unsigned int antenna_pwr = 0;
+
 module_param(antenna_pwr, int, 0444);
 MODULE_PARM_DESC(antenna_pwr,"enable antenna power (Pinnacle 300i)");
 
 /* ------------------------------------------------------------------ */
 
+#if CONFIG_DVB_MT352
 static int pinnacle_antenna_pwr(struct saa7134_dev *dev, int on)
 {
 	u32 ok;
@@ -138,51 +146,390 @@
 	.demod_init    = mt352_pinnacle_init,
 	.pll_set       = mt352_pinnacle_pll_set,
 };
+#endif
 
 /* ------------------------------------------------------------------ */
 
-static int medion_cardbus_init(struct dvb_frontend* fe)
+#if CONFIG_DVB_TDA1004X
+static int philips_tu1216_pll_init(struct dvb_frontend *fe)
 {
-	/* anything to do here ??? */
+	struct saa7134_dev *dev = fe->dvb->priv;
+	static u8 tu1216_init[] = { 0x0b, 0xf5, 0x85, 0xab };
+	struct i2c_msg tuner_msg = {.addr = 0x60,.flags = 0,.buf = tu1216_init,.len = sizeof(tu1216_init) };
+
+	/* setup PLL configuration */
+	if (i2c_transfer(&dev->i2c_adap, &tuner_msg, 1) != 1)
+		return -EIO;
+	msleep(1);
+
 	return 0;
 }
 
-static int medion_cardbus_pll_set(struct dvb_frontend* fe,
-				  struct dvb_frontend_parameters* params)
+static int philips_tu1216_pll_set(struct dvb_frontend *fe, struct dvb_frontend_parameters *params)
 {
 	struct saa7134_dev *dev = fe->dvb->priv;
-	struct v4l2_frequency f;
+	u8 tuner_buf[4];
+	struct i2c_msg tuner_msg = {.addr = 0x60,.flags = 0,.buf = tuner_buf,.len =
+			sizeof(tuner_buf) };
+	int tuner_frequency = 0;
+	u8 band, cp, filter;
+
+	/* determine charge pump */
+	tuner_frequency = params->frequency + 36166000;
+	if (tuner_frequency < 87000000)
+		return -EINVAL;
+	else if (tuner_frequency < 130000000)
+		cp = 3;
+	else if (tuner_frequency < 160000000)
+		cp = 5;
+	else if (tuner_frequency < 200000000)
+		cp = 6;
+	else if (tuner_frequency < 290000000)
+		cp = 3;
+	else if (tuner_frequency < 420000000)
+		cp = 5;
+	else if (tuner_frequency < 480000000)
+		cp = 6;
+	else if (tuner_frequency < 620000000)
+		cp = 3;
+	else if (tuner_frequency < 830000000)
+		cp = 5;
+	else if (tuner_frequency < 895000000)
+		cp = 7;
+	else
+		return -EINVAL;
+
+	/* determine band */
+	if (params->frequency < 49000000)
+		return -EINVAL;
+	else if (params->frequency < 161000000)
+		band = 1;
+	else if (params->frequency < 444000000)
+		band = 2;
+	else if (params->frequency < 861000000)
+		band = 4;
+	else
+		return -EINVAL;
+
+	/* setup PLL filter */
+	switch (params->u.ofdm.bandwidth) {
+	case BANDWIDTH_6_MHZ:
+		filter = 0;
+		break;
+
+	case BANDWIDTH_7_MHZ:
+		filter = 0;
+		break;
+
+	case BANDWIDTH_8_MHZ:
+		filter = 1;
+		break;
 
-	/*
-	 * this instructs tuner.o to set the frequency, the call will
-	 * end up in tuner_command(), VIDIOC_S_FREQUENCY switch.
-	 * tda9887.o will see that as well.
+	default:
+		return -EINVAL;
+	}
+
+	/* calculate divisor
+	 * ((36166000+((1000000/6)/2)) + Finput)/(1000000/6)
 	 */
-	f.tuner     = 0;
-	f.type      = V4L2_TUNER_DIGITAL_TV;
-	f.frequency = params->frequency / 1000 * 16 / 1000;
-	saa7134_i2c_call_clients(dev,VIDIOC_S_FREQUENCY,&f);
+	tuner_frequency = (((params->frequency / 1000) * 6) + 217496) / 1000;
+
+	/* setup tuner buffer */
+	tuner_buf[0] = (tuner_frequency >> 8) & 0x7f;
+	tuner_buf[1] = tuner_frequency & 0xff;
+	tuner_buf[2] = 0xca;
+	tuner_buf[3] = (cp << 5) | (filter << 3) | band;
+
+	if (i2c_transfer(&dev->i2c_adap, &tuner_msg, 1) != 1)
+		return -EIO;
+
+	msleep(1);
 	return 0;
 }
 
-static int fe_request_firmware(struct dvb_frontend* fe,
-			       const struct firmware **fw, char* name)
+static int philips_tu1216_request_firmware(struct dvb_frontend *fe,
+					   const struct firmware **fw, char *name)
 {
 	struct saa7134_dev *dev = fe->dvb->priv;
 	return request_firmware(fw, name, &dev->pci->dev);
 }
 
+static struct tda1004x_config philips_tu1216_config = {
+
+	.demod_address = 0x8,
+	.invert        = 1,
+	.invert_oclk   = 1,
+	.xtal_freq     = TDA10046_XTAL_4M,
+	.agc_config    = TDA10046_AGC_DEFAULT,
+	.if_freq       = TDA10046_FREQ_3617,
+	.pll_init      = philips_tu1216_pll_init,
+	.pll_set       = philips_tu1216_pll_set,
+	.pll_sleep     = NULL,
+	.request_firmware = philips_tu1216_request_firmware,
+};
+
+/* ------------------------------------------------------------------ */
+
+
+static int philips_fmd1216_pll_init(struct dvb_frontend *fe)
+{
+	struct saa7134_dev *dev = fe->dvb->priv;
+	/* this message is to set up ATC and ALC */
+	static u8 fmd1216_init[] = { 0x0b, 0xdc, 0x9c, 0xa0 };
+	struct i2c_msg tuner_msg = {.addr = 0x61,.flags = 0,.buf = fmd1216_init,.len = sizeof(fmd1216_init) };
+
+	if (i2c_transfer(&dev->i2c_adap, &tuner_msg, 1) != 1)
+		return -EIO;
+	msleep(1);
+
+	return 0;
+}
+
+static void philips_fmd1216_analog(struct dvb_frontend *fe)
+{
+	struct saa7134_dev *dev = fe->dvb->priv;
+	/* this message actually turns the tuner back to analog mode */
+	static u8 fmd1216_init[] = { 0x0b, 0xdc, 0x9c, 0x60 };
+	struct i2c_msg tuner_msg = {.addr = 0x61,.flags = 0,.buf = fmd1216_init,.len = sizeof(fmd1216_init) };
+
+	i2c_transfer(&dev->i2c_adap, &tuner_msg, 1);
+	msleep(1);
+	fmd1216_init[2] = 0x86;
+	fmd1216_init[3] = 0x54;
+	i2c_transfer(&dev->i2c_adap, &tuner_msg, 1);
+	msleep(1);
+}
+
+static int philips_fmd1216_pll_set(struct dvb_frontend *fe, struct dvb_frontend_parameters *params)
+{
+	struct saa7134_dev *dev = fe->dvb->priv;
+	u8 tuner_buf[4];
+	struct i2c_msg tuner_msg = {.addr = 0x61,.flags = 0,.buf = tuner_buf,.len =
+			sizeof(tuner_buf) };
+	int tuner_frequency = 0;
+	int divider = 0;
+	u8 band, mode, cp;
+
+	/* determine charge pump */
+	tuner_frequency = params->frequency + 36130000;
+	if (tuner_frequency < 87000000)
+		return -EINVAL;
+	/* low band */
+	else if (tuner_frequency < 180000000) {
+		band = 1;
+		mode = 7;
+		cp   = 0;
+	} else if (tuner_frequency < 195000000) {
+		band = 1;
+		mode = 6;
+		cp   = 1;
+	/* mid band	*/
+	} else if (tuner_frequency < 366000000) {
+		if (params->u.ofdm.bandwidth == BANDWIDTH_8_MHZ) {
+			band = 10;
+		} else {
+			band = 2;
+		}
+		mode = 7;
+		cp   = 0;
+	} else if (tuner_frequency < 478000000) {
+		if (params->u.ofdm.bandwidth == BANDWIDTH_8_MHZ) {
+			band = 10;
+		} else {
+			band = 2;
+		}
+		mode = 6;
+		cp   = 1;
+	/* high band */
+	} else if (tuner_frequency < 662000000) {
+		if (params->u.ofdm.bandwidth == BANDWIDTH_8_MHZ) {
+			band = 12;
+		} else {
+			band = 4;
+		}
+		mode = 7;
+		cp   = 0;
+	} else if (tuner_frequency < 840000000) {
+		if (params->u.ofdm.bandwidth == BANDWIDTH_8_MHZ) {
+			band = 12;
+		} else {
+			band = 4;
+		}
+		mode = 6;
+		cp   = 1;
+	} else {
+		if (params->u.ofdm.bandwidth == BANDWIDTH_8_MHZ) {
+			band = 12;
+		} else {
+			band = 4;
+		}
+		mode = 7;
+		cp   = 1;
+
+	}
+	/* calculate divisor */
+	/* ((36166000 + Finput) / 166666) rounded! */
+	divider = (tuner_frequency + 83333) / 166667;
+
+	/* setup tuner buffer */
+	tuner_buf[0] = (divider >> 8) & 0x7f;
+	tuner_buf[1] = divider & 0xff;
+	tuner_buf[2] = 0x80 | (cp << 6) | (mode  << 3) | 4;
+	tuner_buf[3] = 0x40 | band;
+
+	if (i2c_transfer(&dev->i2c_adap, &tuner_msg, 1) != 1)
+		return -EIO;
+	return 0;
+}
+
+
 static struct tda1004x_config medion_cardbus = {
-	.demod_address = 0x08,  /* not sure this is correct */
-	.invert        = 0,
-        .invert_oclk   = 0,
-        .pll_init      = medion_cardbus_init,
-        .pll_set       = medion_cardbus_pll_set,
-        .request_firmware = fe_request_firmware,
+	.demod_address = 0x08,
+	.invert        = 1,
+	.invert_oclk   = 0,
+	.xtal_freq     = TDA10046_XTAL_16M,
+	.agc_config    = TDA10046_AGC_IFO_AUTO_NEG,
+	.if_freq       = TDA10046_FREQ_3613,
+	.pll_init      = philips_fmd1216_pll_init,
+	.pll_set       = philips_fmd1216_pll_set,
+	.pll_sleep	   = philips_fmd1216_analog,
+	.request_firmware = NULL,
 };
 
 /* ------------------------------------------------------------------ */
 
+struct tda827x_data {
+	u32 lomax;
+	u8  spd;
+	u8  bs;
+	u8  bp;
+	u8  cp;
+	u8  gc3;
+	u8 div1p5;
+};
+
+static struct tda827x_data tda827x_dvbt[] = {
+	{ .lomax =  62000000, .spd = 3, .bs = 2, .bp = 0, .cp = 0, .gc3 = 3, .div1p5 = 1},
+	{ .lomax =  66000000, .spd = 3, .bs = 3, .bp = 0, .cp = 0, .gc3 = 3, .div1p5 = 1},
+	{ .lomax =  76000000, .spd = 3, .bs = 1, .bp = 0, .cp = 0, .gc3 = 3, .div1p5 = 0},
+	{ .lomax =  84000000, .spd = 3, .bs = 2, .bp = 0, .cp = 0, .gc3 = 3, .div1p5 = 0},
+	{ .lomax =  93000000, .spd = 3, .bs = 2, .bp = 0, .cp = 0, .gc3 = 1, .div1p5 = 0},
+	{ .lomax =  98000000, .spd = 3, .bs = 3, .bp = 0, .cp = 0, .gc3 = 1, .div1p5 = 0},
+	{ .lomax = 109000000, .spd = 3, .bs = 3, .bp = 1, .cp = 0, .gc3 = 1, .div1p5 = 0},
+	{ .lomax = 123000000, .spd = 2, .bs = 2, .bp = 1, .cp = 0, .gc3 = 1, .div1p5 = 1},
+	{ .lomax = 133000000, .spd = 2, .bs = 3, .bp = 1, .cp = 0, .gc3 = 1, .div1p5 = 1},
+	{ .lomax = 151000000, .spd = 2, .bs = 1, .bp = 1, .cp = 0, .gc3 = 1, .div1p5 = 0},
+	{ .lomax = 154000000, .spd = 2, .bs = 2, .bp = 1, .cp = 0, .gc3 = 1, .div1p5 = 0},
+	{ .lomax = 181000000, .spd = 2, .bs = 2, .bp = 1, .cp = 0, .gc3 = 0, .div1p5 = 0},
+	{ .lomax = 185000000, .spd = 2, .bs = 2, .bp = 2, .cp = 0, .gc3 = 1, .div1p5 = 0},
+	{ .lomax = 217000000, .spd = 2, .bs = 3, .bp = 2, .cp = 0, .gc3 = 1, .div1p5 = 0},
+	{ .lomax = 244000000, .spd = 1, .bs = 2, .bp = 2, .cp = 0, .gc3 = 1, .div1p5 = 1},
+	{ .lomax = 265000000, .spd = 1, .bs = 3, .bp = 2, .cp = 0, .gc3 = 1, .div1p5 = 1},
+	{ .lomax = 302000000, .spd = 1, .bs = 1, .bp = 2, .cp = 0, .gc3 = 1, .div1p5 = 0},
+	{ .lomax = 324000000, .spd = 1, .bs = 2, .bp = 2, .cp = 0, .gc3 = 1, .div1p5 = 0},
+	{ .lomax = 370000000, .spd = 1, .bs = 2, .bp = 3, .cp = 0, .gc3 = 1, .div1p5 = 0},
+	{ .lomax = 454000000, .spd = 1, .bs = 3, .bp = 3, .cp = 0, .gc3 = 1, .div1p5 = 0},
+	{ .lomax = 493000000, .spd = 0, .bs = 2, .bp = 3, .cp = 0, .gc3 = 1, .div1p5 = 1},
+	{ .lomax = 530000000, .spd = 0, .bs = 3, .bp = 3, .cp = 0, .gc3 = 1, .div1p5 = 1},
+	{ .lomax = 554000000, .spd = 0, .bs = 1, .bp = 3, .cp = 0, .gc3 = 1, .div1p5 = 0},
+	{ .lomax = 604000000, .spd = 0, .bs = 1, .bp = 4, .cp = 0, .gc3 = 0, .div1p5 = 0},
+	{ .lomax = 696000000, .spd = 0, .bs = 2, .bp = 4, .cp = 0, .gc3 = 0, .div1p5 = 0},
+	{ .lomax = 740000000, .spd = 0, .bs = 2, .bp = 4, .cp = 1, .gc3 = 0, .div1p5 = 0},
+	{ .lomax = 820000000, .spd = 0, .bs = 3, .bp = 4, .cp = 0, .gc3 = 0, .div1p5 = 0},
+	{ .lomax = 865000000, .spd = 0, .bs = 3, .bp = 4, .cp = 1, .gc3 = 0, .div1p5 = 0},
+	{ .lomax =         0, .spd = 0, .bs = 0, .bp = 0, .cp = 0, .gc3 = 0, .div1p5 = 0}
+};
+
+static int philips_tda827x_pll_init(struct dvb_frontend *fe)
+{
+	return 0;
+}
+
+static int philips_tda827x_pll_set(struct dvb_frontend *fe, struct dvb_frontend_parameters *params)
+{
+	struct saa7134_dev *dev = fe->dvb->priv;
+	u8 tuner_buf[14];
+
+	struct i2c_msg tuner_msg = {.addr = 0x60,.flags = 0,.buf = tuner_buf,
+		                        .len = sizeof(tuner_buf) };
+	int i, tuner_freq, if_freq;
+	u32 N;
+	switch (params->u.ofdm.bandwidth) {
+	case BANDWIDTH_6_MHZ:
+		if_freq = 4000000;
+		break;
+	case BANDWIDTH_7_MHZ:
+		if_freq = 4500000;
+		break;
+	default:		   /* 8 MHz or Auto */
+		if_freq = 5000000;
+		break;
+	}
+	tuner_freq = params->frequency + if_freq;
+
+	i = 0;
+	while (tda827x_dvbt[i].lomax < tuner_freq) {
+		if(tda827x_dvbt[i + 1].lomax == 0)
+			break;
+		i++;
+	}
+
+	N = ((tuner_freq + 125000) / 250000) << (tda827x_dvbt[i].spd + 2);
+	tuner_buf[0] = 0;
+	tuner_buf[1] = (N>>8) | 0x40;
+	tuner_buf[2] = N & 0xff;
+	tuner_buf[3] = 0;
+	tuner_buf[4] = 0x52;
+	tuner_buf[5] = (tda827x_dvbt[i].spd << 6) + (tda827x_dvbt[i].div1p5 << 5) +
+				   (tda827x_dvbt[i].bs << 3) + tda827x_dvbt[i].bp;
+	tuner_buf[6] = (tda827x_dvbt[i].gc3 << 4) + 0x8f;
+	tuner_buf[7] = 0xbf;
+	tuner_buf[8] = 0x2a;
+	tuner_buf[9] = 0x05;
+	tuner_buf[10] = 0xff;
+	tuner_buf[11] = 0x00;
+	tuner_buf[12] = 0x00;
+	tuner_buf[13] = 0x40;
+
+	tuner_msg.len = 14;
+	if (i2c_transfer(&dev->i2c_adap, &tuner_msg, 1) != 1)
+		return -EIO;
+
+	msleep(500);
+	/* correct CP value */
+	tuner_buf[0] = 0x30;
+	tuner_buf[1] = 0x50 + tda827x_dvbt[i].cp;
+	tuner_msg.len = 2;
+	i2c_transfer(&dev->i2c_adap, &tuner_msg, 1);
+
+	return 0;
+}
+
+static void philips_tda827x_pll_sleep(struct dvb_frontend *fe)
+{
+	struct saa7134_dev *dev = fe->dvb->priv;
+	static u8 tda827x_sleep[] = { 0x30, 0xd0};
+	struct i2c_msg tuner_msg = {.addr = 0x60,.flags = 0,.buf = tda827x_sleep,
+	                            .len = sizeof(tda827x_sleep) };
+	i2c_transfer(&dev->i2c_adap, &tuner_msg, 1);
+}
+
+static struct tda1004x_config tda827x_lifeview_config = {
+	.demod_address = 0x08,
+	.invert        = 1,
+	.invert_oclk   = 0,
+	.xtal_freq     = TDA10046_XTAL_16M,
+	.agc_config    = TDA10046_AGC_TDA827X,
+	.if_freq       = TDA10046_FREQ_045,
+	.pll_init      = philips_tda827x_pll_init,
+	.pll_set       = philips_tda827x_pll_set,
+	.pll_sleep	   = philips_tda827x_pll_sleep,
+	.request_firmware = NULL,
+};
+#endif
+
+/* ------------------------------------------------------------------ */
+
 static int dvb_init(struct saa7134_dev *dev)
 {
 	/* init struct videobuf_dvb */
@@ -197,18 +544,31 @@
 			    dev);
 
 	switch (dev->board) {
+#if CONFIG_DVB_MT352
 	case SAA7134_BOARD_PINNACLE_300I_DVBT_PAL:
 		printk("%s: pinnacle 300i dvb setup\n",dev->name);
 		dev->dvb.frontend = mt352_attach(&pinnacle_300i,
 						 &dev->i2c_adap);
 		break;
+#endif
+#if CONFIG_DVB_TDA1004X
 	case SAA7134_BOARD_MD7134:
 		dev->dvb.frontend = tda10046_attach(&medion_cardbus,
 						    &dev->i2c_adap);
-		if (NULL == dev->dvb.frontend)
-			printk("%s: Hmm, looks like this is the old MD7134 "
-			       "version without DVB-T support\n",dev->name);
 		break;
+	case SAA7134_BOARD_PHILIPS_TOUGH:
+		dev->dvb.frontend = tda10046_attach(&philips_tu1216_config,
+						    &dev->i2c_adap);
+		break;
+	case SAA7134_BOARD_FLYDVBTDUO:
+		dev->dvb.frontend = tda10046_attach(&tda827x_lifeview_config,
+						    &dev->i2c_adap);
+		break;
+	case SAA7134_BOARD_THYPHOON_DVBT_DUO_CARDBUS:
+		dev->dvb.frontend = tda10046_attach(&tda827x_lifeview_config,
+						    &dev->i2c_adap);
+		break;
+#endif
 	default:
 		printk("%s: Huh? unknown DVB card?\n",dev->name);
 		break;
@@ -227,8 +587,6 @@
 {
 	static int on  = TDA9887_PRESENT | TDA9887_PORT2_INACTIVE;
 
-	printk("%s: %s\n",dev->name,__FUNCTION__);
-
 	switch (dev->board) {
 	case SAA7134_BOARD_PINNACLE_300I_DVBT_PAL:
 		/* otherwise we don't detect the tuner on next insmod */
diff -u linux-2.6.13/include/media/saa6752hs.h linux/include/media/saa6752hs.h
--- linux-2.6.13/include/media/saa6752hs.h	2005-07-06 00:46:33.000000000 -0300
+++ linux/include/media/saa6752hs.h	2005-07-07 19:05:23.000000000 -0300
@@ -18,55 +18,6 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
-#if 0 /* ndef _SAA6752HS_H */
-#define _SAA6752HS_H
-
-enum mpeg_video_bitrate_mode {
-	MPEG_VIDEO_BITRATE_MODE_VBR = 0, /* Variable bitrate */
-	MPEG_VIDEO_BITRATE_MODE_CBR = 1, /* Constant bitrate */
-
-	MPEG_VIDEO_BITRATE_MODE_MAX
-};
-
-enum mpeg_audio_bitrate {
-	MPEG_AUDIO_BITRATE_256 = 0, /* 256 kBit/sec */
-	MPEG_AUDIO_BITRATE_384 = 1, /* 384 kBit/sec */
-
-	MPEG_AUDIO_BITRATE_MAX
-};
-
-enum mpeg_video_format {
-	MPEG_VIDEO_FORMAT_D1 = 0,
-	MPEG_VIDEO_FORMAT_2_3_D1 = 1,
-	MPEG_VIDEO_FORMAT_1_2_D1 = 2,
-	MPEG_VIDEO_FORMAT_SIF = 3,
-
-	MPEG_VIDEO_FORMAT_MAX
-};
-
-#define MPEG_VIDEO_TARGET_BITRATE_MAX 27000
-#define MPEG_VIDEO_MAX_BITRATE_MAX 27000
-#define MPEG_TOTAL_BITRATE_MAX 27000
-#define MPEG_PID_MAX ((1 << 14) - 1)
-
-struct mpeg_params {
-	enum mpeg_video_bitrate_mode video_bitrate_mode;
-	unsigned int video_target_bitrate;
-	unsigned int video_max_bitrate; // only used for VBR
-	enum mpeg_audio_bitrate audio_bitrate;
-	unsigned int total_bitrate;
-
-   	unsigned int pmt_pid;
-	unsigned int video_pid;
-	unsigned int audio_pid;
-	unsigned int pcr_pid;
-
-	enum mpeg_video_format video_format;
-};
-
-#define MPEG_SETPARAMS             _IOW('6',100,struct mpeg_params)
-
-#endif // _SAA6752HS_H
 
 /*
  * Local variables:
diff -u linux-2.6.13/drivers/media/video/saa7134/saa6752hs.c linux/drivers/media/video/saa7134/saa6752hs.c
--- linux-2.6.13/drivers/media/video/saa7134/saa6752hs.c	2005-07-06 00:46:33.000000000 -0300
+++ linux/drivers/media/video/saa7134/saa6752hs.c	2005-07-07 19:05:23.000000000 -0300
@@ -155,10 +155,6 @@
 		.target  = 256,
 	},
 
-#if 0
-	/* FIXME: size? via S_FMT? */
-	.video_format = MPEG_VIDEO_FORMAT_D1,
-#endif
 };
 
 /* ---------------------------------------------------------------------- */

--------------010905090506040106060902--
