Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262822AbVEHUYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262822AbVEHUYQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 16:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262965AbVEHUXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 16:23:24 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:63126 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262923AbVEHTJ4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 15:09:56 -0400
Message-Id: <20050508184347.647004000@abc>
References: <20050508184229.957247000@abc>
Date: Sun, 08 May 2005 20:42:48 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-fe-mt352-state.patch
X-SA-Exim-Connect-IP: 217.231.45.168
Subject: [DVB patch 19/37] mt352: embed struct mt352_config in mt352_state
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

copying the mt352_config-struct to mt352_state instead of storing
just the pointer to it (Patrick Boettcher)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
---

 drivers/media/dvb/frontends/mt352.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

Index: linux-2.6.12-rc4/drivers/media/dvb/frontends/mt352.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/frontends/mt352.c	2005-05-08 15:55:38.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/frontends/mt352.c	2005-05-08 16:26:30.000000000 +0200
@@ -46,7 +46,7 @@ struct mt352_state {
 	struct dvb_frontend_ops ops;
 
 	/* configuration settings */
-	const struct mt352_config* config;
+	struct mt352_config config;
 };
 
 static int debug;
@@ -59,7 +59,7 @@ static int mt352_single_write(struct dvb
 {
 	struct mt352_state* state = fe->demodulator_priv;
 	u8 buf[2] = { reg, val };
-	struct i2c_msg msg = { .addr = state->config->demod_address, .flags = 0,
+	struct i2c_msg msg = { .addr = state->config.demod_address, .flags = 0,
 			       .buf = buf, .len = 2 };
 	int err = i2c_transfer(state->i2c, &msg, 1);
 	if (err != 1) {
@@ -84,10 +84,10 @@ static int mt352_read_register(struct mt
 	int ret;
 	u8 b0 [] = { reg };
 	u8 b1 [] = { 0 };
-	struct i2c_msg msg [] = { { .addr = state->config->demod_address,
+	struct i2c_msg msg [] = { { .addr = state->config.demod_address,
 				    .flags = 0,
 				    .buf = b0, .len = 1 },
-				  { .addr = state->config->demod_address,
+				  { .addr = state->config.demod_address,
 				    .flags = I2C_M_RD,
 				    .buf = b1, .len = 1 } };
 
@@ -134,8 +134,8 @@ static void mt352_calc_nominal_rate(stru
 		bw = 8;
 		break;
 	}
-	if (state->config->adc_clock)
-		adc_clock = state->config->adc_clock;
+	if (state->config.adc_clock)
+		adc_clock = state->config.adc_clock;
 
 	value = 64 * bw * (1<<16) / (7 * 8);
 	value = value * 1000 / adc_clock;
@@ -152,10 +152,10 @@ static void mt352_calc_input_freq(struct
 	int if2       = 36167; /* 36.166667 MHz */
 	int ife,value;
 
-	if (state->config->adc_clock)
-		adc_clock = state->config->adc_clock;
-	if (state->config->if2)
-		if2 = state->config->if2;
+	if (state->config.adc_clock)
+		adc_clock = state->config.adc_clock;
+	if (state->config.if2)
+		if2 = state->config.if2;
 
 	ife = (2*adc_clock - if2);
 	value = -16374 * ife / adc_clock;
@@ -289,10 +289,10 @@ static int mt352_set_parameters(struct d
 
 	mt352_calc_nominal_rate(state, op->bandwidth, buf+4);
 	mt352_calc_input_freq(state, buf+6);
-	state->config->pll_set(fe, param, buf+8);
+	state->config.pll_set(fe, param, buf+8);
 
 	mt352_write(fe, buf, sizeof(buf));
-	if (state->config->no_tuner) {
+	if (state->config.no_tuner) {
 		/* start decoding */
 		mt352_write(fe, fsm_go, 2);
 	} else {
@@ -516,7 +516,7 @@ static int mt352_init(struct dvb_fronten
 
 		/* Do a "hard" reset */
 		mt352_write(fe, mt352_reset_attach, sizeof(mt352_reset_attach));
-		return state->config->demod_init(fe);
+		return state->config.demod_init(fe);
 	}
 
 	return 0;
@@ -541,8 +541,8 @@ struct dvb_frontend* mt352_attach(const 
 	memset(state,0,sizeof(*state));
 
 	/* setup the state */
-	state->config = config;
 	state->i2c = i2c;
+	memcpy(&state->config,config,sizeof(struct mt352_config));
 	memcpy(&state->ops, &mt352_ops, sizeof(struct dvb_frontend_ops));
 
 	/* check if the demod is there */

--

