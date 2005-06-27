Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261318AbVF0OPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbVF0OPS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 10:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262058AbVF0OBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 10:01:36 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:33765 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262092AbVF0MRG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:17:06 -0400
Message-Id: <20050627121411.913808000@abc>
References: <20050627120600.739151000@abc>
Date: Mon, 27 Jun 2005 14:06:12 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Patrick Boettcher <pb@linuxtv.org>
Content-Disposition: inline; filename=dvb-frontend-cx22702-fixes.patch
X-SA-Exim-Connect-IP: 84.189.248.249
Subject: [DVB patch 12/51] frontend: cx22702: support for cxusb
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Boettcher <pb@linuxtv.org>

Add .get_tune_settings callback (min_delay_ms = 1sec) and output_mode-field
(parallel/serial) to support cxusb; minor cleanups.

Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/frontends/cx22702.c |   29 ++++++++++++++++++++---------
 drivers/media/dvb/frontends/cx22702.h |    5 +++++
 2 files changed, 25 insertions(+), 9 deletions(-)

Index: linux-2.6.12-git8/drivers/media/dvb/frontends/cx22702.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/frontends/cx22702.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/frontends/cx22702.c	2005-06-27 13:23:06.000000000 +0200
@@ -76,7 +76,6 @@ static u8 init_tab [] = {
 	0x49, 0x56,
 	0x6b, 0x1e,
 	0xc8, 0x02,
-	0xf8, 0x02,
 	0xf9, 0x00,
 	0xfa, 0x00,
 	0xfb, 0x00,
@@ -203,7 +202,7 @@ static int cx22702_set_tps (struct dvb_f
 	struct cx22702_state* state = fe->demodulator_priv;
 
 	/* set PLL */
-        cx22702_writereg (state, 0x0D, cx22702_readreg(state,0x0D) &0xfe);
+	cx22702_writereg (state, 0x0D, cx22702_readreg(state,0x0D) &0xfe);
 	if (state->config->pll_set) {
 		state->config->pll_set(fe, p);
 	} else if (state->config->pll_desc) {
@@ -217,7 +216,7 @@ static int cx22702_set_tps (struct dvb_f
 	} else {
 		BUG();
 	}
-        cx22702_writereg (state, 0x0D, cx22702_readreg(state,0x0D) | 1);
+	cx22702_writereg (state, 0x0D, cx22702_readreg(state,0x0D) | 1);
 
 	/* set inversion */
 	cx22702_set_inversion (state, p->inversion);
@@ -256,7 +255,7 @@ static int cx22702_set_tps (struct dvb_f
 		cx22702_writereg(state, 0x0B, cx22702_readreg(state, 0x0B) & 0xfc );
 		cx22702_writereg(state, 0x0C, (cx22702_readreg(state, 0x0C) & 0xBF) | 0x40 );
 		cx22702_writereg(state, 0x00, 0x01); /* Begin aquisition */
-		printk("%s: Autodetecting\n",__FUNCTION__);
+		dprintk("%s: Autodetecting\n",__FUNCTION__);
 		return 0;
 	}
 
@@ -347,10 +346,11 @@ static int cx22702_init (struct dvb_fron
 	for (i=0; i<sizeof(init_tab); i+=2)
 		cx22702_writereg (state, init_tab[i], init_tab[i+1]);
 
+	cx22702_writereg (state, 0xf8, (state->config->output_mode << 1) & 0x02);
 
 	/* init PLL */
 	if (state->config->pll_init) {
-	        cx22702_writereg (state, 0x0D, cx22702_readreg(state,0x0D) &0xfe);
+		cx22702_writereg (state, 0x0D, cx22702_readreg(state,0x0D) & 0xfe);
 		state->config->pll_init(fe);
 		cx22702_writereg (state, 0x0D, cx22702_readreg(state,0x0D) | 1);
 	}
@@ -440,8 +440,10 @@ static int cx22702_read_ucblocks(struct 
 
 	/* RS Uncorrectable Packet Count then reset */
 	_ucblocks = cx22702_readreg (state, 0xE3);
-	if (state->prevUCBlocks < _ucblocks) *ucblocks = (_ucblocks - state->prevUCBlocks);
-	else *ucblocks = state->prevUCBlocks - _ucblocks;
+	if (state->prevUCBlocks < _ucblocks)
+		*ucblocks = (_ucblocks - state->prevUCBlocks);
+	else
+		*ucblocks = state->prevUCBlocks - _ucblocks;
 	state->prevUCBlocks = _ucblocks;
 
 	return 0;
@@ -457,6 +459,12 @@ static int cx22702_get_frontend(struct d
 	return cx22702_get_tps (state, &p->u.ofdm);
 }
 
+static int cx22702_get_tune_settings(struct dvb_frontend* fe, struct dvb_frontend_tune_settings *tune)
+{
+	tune->min_delay_ms = 1000;
+	return 0;
+}
+
 static void cx22702_release(struct dvb_frontend* fe)
 {
 	struct cx22702_state* state = fe->demodulator_priv;
@@ -472,7 +480,8 @@ struct dvb_frontend* cx22702_attach(cons
 
 	/* allocate memory for the internal state */
 	state = kmalloc(sizeof(struct cx22702_state), GFP_KERNEL);
-	if (state == NULL) goto error;
+	if (state == NULL)
+		goto error;
 
 	/* setup the state */
 	state->config = config;
@@ -481,7 +490,8 @@ struct dvb_frontend* cx22702_attach(cons
 	state->prevUCBlocks = 0;
 
 	/* check if the demod is there */
-	if (cx22702_readreg(state, 0x1f) != 0x3) goto error;
+	if (cx22702_readreg(state, 0x1f) != 0x3)
+		goto error;
 
 	/* create dvb_frontend */
 	state->frontend.ops = &state->ops;
@@ -514,6 +524,7 @@ static struct dvb_frontend_ops cx22702_o
 
 	.set_frontend = cx22702_set_tps,
 	.get_frontend = cx22702_get_frontend,
+	.get_tune_settings = cx22702_get_tune_settings,
 
 	.read_status = cx22702_read_status,
 	.read_ber = cx22702_read_ber,
Index: linux-2.6.12-git8/drivers/media/dvb/frontends/cx22702.h
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/frontends/cx22702.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/frontends/cx22702.h	2005-06-27 13:23:06.000000000 +0200
@@ -35,6 +35,11 @@ struct cx22702_config
 	/* the demodulator's i2c address */
 	u8 demod_address;
 
+	/* serial/parallel output */
+#define CX22702_PARALLEL_OUTPUT 0
+#define CX22702_SERIAL_OUTPUT   1
+	u8 output_mode;
+
 	/* PLL maintenance */
 	u8 pll_address;
 	struct dvb_pll_desc *pll_desc;

--

