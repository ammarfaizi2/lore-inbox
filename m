Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbVGUEUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbVGUEUu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 00:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbVGUEUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 00:20:49 -0400
Received: from hulk.hostingexpert.com ([69.57.134.39]:26275 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S261605AbVGUEUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 00:20:46 -0400
Message-ID: <42DF2295.2050509@m1k.net>
Date: Thu, 21 Jul 2005 00:20:37 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: mkrufky@m1k.net, linux-dvb-maintainer@linuxtv.org,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       Mac Michaels <wmichaels1@earthlink.net>,
       LKML <linux-kernel@vger.kernel.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>
Subject: [2.6.13 PATCH 1/4] 01-lgdt3302-isolate-tuner.patch
References: <42DF2196.5040503@m1k.net>
In-Reply-To: <42DF2196.5040503@m1k.net>
Content-Type: multipart/mixed;
 boundary="------------000902050108030306020808"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000902050108030306020808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Michael Krufky wrote:

> This patch series spans both video4linux and linux-dvb trees.
> Remove the dvb_pll_desc from the lgdt3302 frontend and replace with a 
> pll_set-callback to isolate the tuner programming from the frontend.
>
> Select the RF input connector based upon the type of demodulation 
> selected. ANT RF connector is selected for 8-VSB and CABLE RF 
> connector is selected for QAM64/QAM256. Implement this along the lines 
> posted to linux-dvb list (subscribers only) by Patrick Boettcher. ( 
> http://linuxtv.org/pipermail/linux-dvb/2005-July/003557.html ) This 
> only affects the cards that use the Microtune 4042 tuner. This is not 
> ideal, but there is no current specification for selecting RF inputs. 
> It makes the card work the same way as the Windows driver thus it may 
> reduce user confusion.
>



--------------000902050108030306020808
Content-Type: text/plain;
 name="01-lgdt3302-isolate-tuner.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="01-lgdt3302-isolate-tuner.patch"

Remove the dvb_pll_desc from the frontend and replace with a
pll_set-callback to isolate the tuner programming from the frontend.

Signed-off-by: Mac Michaels <wmichaels1@earthlink.net>
Signed-off-by: Michael Krufky <mkrufky@m1k.net>

 linux/drivers/media/dvb/frontends/lgdt3302.c |   68 ++++++++-----------
 linux/drivers/media/dvb/frontends/lgdt3302.h |    7 -
 linux/drivers/media/video/cx88/cx88-dvb.c    |   34 +++++----
 3 files changed, 55 insertions(+), 54 deletions(-)

diff -u linux-2.6.13/drivers/media/dvb/frontends/lgdt3302.c linux/drivers/media/dvb/frontends/lgdt3302.c
--- linux-2.6.13/drivers/media/dvb/frontends/lgdt3302.c	2005-07-20 22:29:42.000000000 +0000
+++ linux/drivers/media/dvb/frontends/lgdt3302.c	2005-07-20 22:44:44.000000000 +0000
@@ -74,11 +74,14 @@
 			   u8 *buf, /* data bytes to send */
 			   int len  /* number of bytes to send */ )
 {
-	if (addr == state->config->pll_address) {
-		struct i2c_msg msg =
-			{ .addr = addr, .flags = 0, .buf = buf,  .len = len };
-		int err;
+	u8 tmp[] = { buf[0], buf[1] };
+	struct i2c_msg msg =
+		{ .addr = addr, .flags = 0, .buf = tmp,  .len = 2 };
+	int err;
+	int i;
 
+	for (i=1; i<len; i++) {
+		tmp[1] = buf[i];
 		if ((err = i2c_transfer(state->i2c, &msg, 1)) != 1) {
 			printk(KERN_WARNING "lgdt3302: %s error (addr %02x <- %02x, err == %i)\n", __FUNCTION__, addr, buf[0], err);
 			if (err < 0)
@@ -86,27 +89,11 @@
 			else
 				return -EREMOTEIO;
 		}
-	} else {
-		u8 tmp[] = { buf[0], buf[1] };
-		struct i2c_msg msg =
-			{ .addr = addr, .flags = 0, .buf = tmp,  .len = 2 };
-		int err;
-		int i;
-
-		for (i=1; i<len; i++) {
-			tmp[1] = buf[i];
-			if ((err = i2c_transfer(state->i2c, &msg, 1)) != 1) {
-				printk(KERN_WARNING "lgdt3302: %s error (addr %02x <- %02x, err == %i)\n", __FUNCTION__, addr, buf[0], err);
-				if (err < 0)
-					return err;
-				else
-					return -EREMOTEIO;
-			}
-			tmp[0]++;
-		}
+		tmp[0]++;
 	}
 	return 0;
 }
+
 static int i2c_readbytes (struct lgdt3302_state* state,
 			  u8 addr, /* demod_address or pll_address */
 			  u8 *buf, /* holds data bytes read */
@@ -207,7 +194,6 @@
 static int lgdt3302_set_parameters(struct dvb_frontend* fe,
 				   struct dvb_frontend_parameters *param)
 {
-	u8 buf[4];
 	struct lgdt3302_state* state =
 		(struct lgdt3302_state*) fe->demodulator_priv;
 
@@ -290,16 +276,30 @@
 
 	/* Change only if we are actually changing the channel */
 	if (state->current_frequency != param->frequency) {
-		dvb_pll_configure(state->config->pll_desc, buf,
-				  param->frequency, 0);
-		dprintk("%s: tuner bytes: 0x%02x 0x%02x "
-			"0x%02x 0x%02x\n", __FUNCTION__, buf[0],buf[1],buf[2],buf[3]);
-		i2c_writebytes(state, state->config->pll_address ,buf, 4);
+		u8 buf[5];
 
-		/* Check the status of the tuner pll */
-		i2c_readbytes(state, state->config->pll_address, buf, 1);
-		dprintk("%s: tuner status byte = 0x%02x\n", __FUNCTION__, buf[0]);
+		/* This must be done before the initialized msg is declared */
+		state->config->pll_set(fe, param, buf);
 
+		struct i2c_msg msg =
+			{ .addr = buf[0], .flags = 0, .buf = &buf[1], .len = 4 };
+		int err;
+
+		dprintk("%s: tuner at 0x%02x bytes: 0x%02x 0x%02x "
+			"0x%02x 0x%02x\n", __FUNCTION__,
+			buf[0],buf[1],buf[2],buf[3],buf[4]);
+		if ((err = i2c_transfer(state->i2c, &msg, 1)) != 1) {
+			printk(KERN_WARNING "lgdt3302: %s error (addr %02x <- %02x, err = %i)\n", __FUNCTION__, buf[0], buf[1], err);
+			if (err < 0)
+				return err;
+			else
+				return -EREMOTEIO;
+		}
+#if 0
+		/* Check the status of the tuner pll */
+		i2c_readbytes(state, buf[0], &buf[1], 1);
+		dprintk("%s: tuner status byte = 0x%02x\n", __FUNCTION__, buf[1]);
+#endif
 		/* Update current frequency */
 		state->current_frequency = param->frequency;
 	}
@@ -322,12 +322,6 @@
 
 	*status = 0; /* Reset status result */
 
-	/* Check the status of the tuner pll */
-	i2c_readbytes(state, state->config->pll_address, buf, 1);
-	dprintk("%s: tuner status byte = 0x%02x\n", __FUNCTION__, buf[0]);
-	if ((buf[0] & 0xc0) != 0x40)
-		return 0; /* Tuner PLL not locked or not powered on */
-
 	/*
 	 * You must set the Mask bits to 1 in the IRQ_MASK in order
 	 * to see that status bit in the IRQ_STATUS register.
diff -u linux-2.6.13/drivers/media/dvb/frontends/lgdt3302.h linux/drivers/media/dvb/frontends/lgdt3302.h
--- linux-2.6.13/drivers/media/dvb/frontends/lgdt3302.h	2005-07-20 22:29:34.000000000 +0000
+++ linux/drivers/media/dvb/frontends/lgdt3302.h	2005-07-20 22:44:44.000000000 +0000
@@ -1,6 +1,4 @@
 /*
- * $Id: lgdt3302.h,v 1.2 2005/06/28 23:50:48 mkrufky Exp $
- *
  *    Support for LGDT3302 (DViCO FustionHDTV 3 Gold) - VSB/QAM
  *
  *    Copyright (C) 2005 Wilson Michaels <wilsonmichaels@earthlink.net>
@@ -30,8 +28,9 @@
 {
 	/* The demodulator's i2c address */
 	u8 demod_address;
-	u8 pll_address;
-	struct dvb_pll_desc *pll_desc;
+
+	/* PLL interface */
+	int (*pll_set)(struct dvb_frontend* fe, struct dvb_frontend_parameters* params, u8* pll_address);
 
 	/* Need to set device param for start_dma */
 	int (*set_ts_params)(struct dvb_frontend* fe, int is_punctured);
diff -u linux-2.6.13/drivers/media/video/cx88/cx88-dvb.c linux/drivers/media/video/cx88/cx88-dvb.c
--- linux-2.6.13/drivers/media/video/cx88/cx88-dvb.c	2005-07-20 22:35:18.000000000 +0000
+++ linux/drivers/media/video/cx88/cx88-dvb.c	2005-07-20 22:44:44.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88-dvb.c,v 1.42 2005/07/12 15:44:55 mkrufky Exp $
+ * $Id: cx88-dvb.c,v 1.47 2005/07/20 05:20:37 mkrufky Exp $
  *
  * device driver for Conexant 2388x based TV cards
  * MPEG Transport Stream (DVB) routines
@@ -211,6 +211,18 @@
 #endif
 
 #if CONFIG_DVB_LGDT3302
+static int lgdt3302_pll_set(struct dvb_frontend* fe,
+			    struct dvb_frontend_parameters* params,
+			    u8* pllbuf)
+{
+	struct cx8802_dev *dev= fe->dvb->priv;
+
+	pllbuf[0] = dev->core->pll_addr;
+	dvb_pll_configure(dev->core->pll_desc, &pllbuf[1],
+			  params->frequency, 0);
+	return 0;
+}
+
 static int lgdt3302_set_ts_param(struct dvb_frontend* fe, int is_punctured)
 {
 	struct cx8802_dev *dev= fe->dvb->priv;
@@ -221,17 +233,9 @@
 	return 0;
 }
 
-static struct lgdt3302_config fusionhdtv_3_gold_q = {
-	.demod_address    = 0x0e,
-	.pll_address      = 0x61,
-	.pll_desc         = &dvb_pll_microtune_4042,
-	.set_ts_params    = lgdt3302_set_ts_param,
-};
-
-static struct lgdt3302_config fusionhdtv_3_gold_t = {
+static struct lgdt3302_config fusionhdtv_3_gold = {
 	.demod_address    = 0x0e,
-	.pll_address      = 0x61,
-	.pll_desc         = &dvb_pll_thomson_dtt7611,
+	.pll_set          = lgdt3302_pll_set,
 	.set_ts_params    = lgdt3302_set_ts_param,
 };
 #endif
@@ -294,7 +298,9 @@
 		mdelay(100);
 		cx_set(MO_GP0_IO, 9); // ANT connector too FIXME
 		mdelay(200);
-		dev->dvb.frontend = lgdt3302_attach(&fusionhdtv_3_gold_q,
+		dev->core->pll_addr = 0x61;
+		dev->core->pll_desc = &dvb_pll_microtune_4042;
+		dev->dvb.frontend = lgdt3302_attach(&fusionhdtv_3_gold,
 						    &dev->core->i2c_adap);
 		}
 		break;
@@ -308,7 +314,9 @@
 		mdelay(100);
 		cx_set(MO_GP0_IO, 9); /* ANT connector too FIXME */
 		mdelay(200);
-		dev->dvb.frontend = lgdt3302_attach(&fusionhdtv_3_gold_t,
+		dev->core->pll_addr = 0x61;
+		dev->core->pll_desc = &dvb_pll_thomson_dtt7611;
+		dev->dvb.frontend = lgdt3302_attach(&fusionhdtv_3_gold,
 						    &dev->core->i2c_adap);
 		}
 		break;

--------------000902050108030306020808--
