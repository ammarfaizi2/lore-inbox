Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262228AbVCVBvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbVCVBvz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 20:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262272AbVCVBuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 20:50:55 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:34699 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262342AbVCVBgA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:36:00 -0500
Message-Id: <20050322013500.891149000@abc>
References: <20050322013427.919515000@abc>
Date: Tue, 22 Mar 2005 02:24:21 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-frontend-mt352-cleanup.patch
X-SA-Exim-Connect-IP: 217.231.55.169
Subject: [DVB patch 48/48] mt352: cleanups
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

o remove s* from state, they are only used in read_status
o remove casting of void*
o remove FIXME in set_parameters, should be handled by dvb-core state machine
o remove some unnecessary braces
o remove #if 1 in read_status, and add note from Zarlink design manual
o change read_signal_strength to read total AGC_GAIN in case
  some adapter turns on the RF_AGC loop.
(Kenneth Aafloy)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 mt352.c |  105 +++++++++++++++++++++++-----------------------------------------
 1 files changed, 39 insertions(+), 66 deletions(-)

Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/mt352.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/frontends/mt352.c	2005-03-22 00:27:13.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/mt352.c	2005-03-22 00:30:54.000000000 +0100
@@ -42,13 +42,11 @@
 
 struct mt352_state {
 	struct i2c_adapter* i2c;
+	struct dvb_frontend frontend;
 	struct dvb_frontend_ops ops;
 
 	/* configuration settings */
 	const struct mt352_config* config;
-	int s0,s1,s3;
-
-	struct dvb_frontend frontend;
 };
 
 static int debug;
@@ -59,7 +57,7 @@ static int debug;
 
 static int mt352_single_write(struct dvb_frontend *fe, u8 reg, u8 val)
 {
-	struct mt352_state* state = (struct mt352_state*) fe->demodulator_priv;
+	struct mt352_state* state = fe->demodulator_priv;
 	u8 buf[2] = { reg, val };
 	struct i2c_msg msg = { .addr = state->config->demod_address, .flags = 0,
 			       .buf = buf, .len = 2 };
@@ -170,7 +168,7 @@ static void mt352_calc_input_freq(struct
 static int mt352_set_parameters(struct dvb_frontend* fe,
 				struct dvb_frontend_parameters *param)
 {
-	struct mt352_state* state = (struct mt352_state*) fe->demodulator_priv;
+	struct mt352_state* state = fe->demodulator_priv;
 	unsigned char buf[13];
 	static unsigned char tuner_go[] = { 0x5d, 0x01 };
 	static unsigned char fsm_go[]   = { 0x5e, 0x01 };
@@ -293,20 +291,6 @@ static int mt352_set_parameters(struct d
 	mt352_calc_input_freq(state, buf+6);
 	state->config->pll_set(fe, param, buf+8);
 
-#if 0 /* FIXME: should be catched elsewhere ... */
-	/* this dubious code which helped on some cards does not work for
-	 * the pinnacle 300i */
-	/* Only send the tuning request if the tuner doesn't have the requested
-	 * parameters already set.  Enhances tuning time and prevents stream
-	 * breakup when retuning the same transponder. */
-	for (i = 1; i < 13; i++)
-		if (buf[i] != mt352_read_register(state, i + 0x50))
-			break;
-	if (13 == i)
-		/* no changes */
-		return 0;
-#endif
-
 	mt352_write(fe, buf, sizeof(buf));
 	if (state->config->no_tuner) {
 		/* start decoding */
@@ -321,7 +305,7 @@ static int mt352_set_parameters(struct d
 static int mt352_get_parameters(struct dvb_frontend* fe,
 				struct dvb_frontend_parameters *param)
 {
-	struct mt352_state* state = (struct mt352_state*) fe->demodulator_priv;
+	struct mt352_state* state = fe->demodulator_priv;
 	u16 tps;
 	u16 div;
 	u8 trl;
@@ -339,9 +323,7 @@ static int mt352_get_parameters(struct d
 	};
 
 	if ( (mt352_read_register(state,0x00) & 0xC0) != 0xC0 )
-	{
 		return -EINVAL;
-	}
 
 	/* Use TPS_RECEIVED-registers, not the TPS_CURRENT-registers because
 	 * the mt352 sometimes works with the wrong parameters
@@ -412,17 +394,11 @@ static int mt352_get_parameters(struct d
 	param->frequency = ( 500 * (div - IF_FREQUENCYx6) ) / 3 * 1000;
 
 	if (trl == 0x72)
-	{
 		op->bandwidth = BANDWIDTH_8_MHZ;
-	}
 	else if (trl == 0x64)
-	{
 		op->bandwidth = BANDWIDTH_7_MHZ;
-	}
 	else
-	{
 		op->bandwidth = BANDWIDTH_6_MHZ;
-	}
 
 
 	if (mt352_read_register(state, STATUS_2) & 0x02)
@@ -435,41 +411,38 @@ static int mt352_get_parameters(struct d
 
 static int mt352_read_status(struct dvb_frontend* fe, fe_status_t* status)
 {
-	struct mt352_state* state = (struct mt352_state*) fe->demodulator_priv;
-#if 1
-	/* the pinnacle 300i loses lock if the STATUS_x registers
-	 * are polled too often... */
-	int val;
-
-	if (0 != mt352_read_register(state, INTERRUPT_0)) {
-		val = mt352_read_register(state, STATUS_0);
-		if (-1 != val)
-			state->s0 = val;
-		val = mt352_read_register(state, STATUS_1);
-		if (-1 != val)
-			state->s1 = val;
-		val = mt352_read_register(state, STATUS_3);
-		if (-1 != val)
-			state->s3 = val;
-	}
-#else
-	state->s0 = mt352_read_register(state, STATUS_0);
-	state->s1 = mt352_read_register(state, STATUS_1);
-	state->s3 = mt352_read_register(state, STATUS_3);
-	if (-1 == state->s0 || -1 == state->s1 || -1 == state->s3)
-		return -EIO;
-#endif
+	struct mt352_state* state = fe->demodulator_priv;
+	int s0, s1, s3;
+
+	/* FIXME:
+	 *
+	 * The MT352 design manual from Zarlink states (page 46-47):
+	 *
+	 * Notes about the TUNER_GO register:
+	 *
+	 * If the Read_Tuner_Byte (bit-1) is activated, then the tuner status
+	 * byte is copied from the tuner to the STATUS_3 register and
+	 * completion of the read operation is indicated by bit-5 of the
+	 * INTERRUPT_3 register.
+	 */
+
+	if ((s0 = mt352_read_register(state, STATUS_0)) < 0)
+		return -EREMOTEIO;
+	if ((s1 = mt352_read_register(state, STATUS_1)) < 0)
+		return -EREMOTEIO;
+	if ((s3 = mt352_read_register(state, STATUS_3)) < 0)
+		return -EREMOTEIO;
 
 	*status = 0;
-	if (state->s0 & (1 << 4))
+	if (s0 & (1 << 4))
 		*status |= FE_HAS_CARRIER;
-	if (state->s0 & (1 << 1))
+	if (s0 & (1 << 1))
 		*status |= FE_HAS_VITERBI;
-	if (state->s0 & (1 << 5))
+	if (s0 & (1 << 5))
 		*status |= FE_HAS_LOCK;
-	if (state->s1 & (1 << 1))
+	if (s1 & (1 << 1))
 		*status |= FE_HAS_SYNC;
-	if (state->s3 & (1 << 6))
+	if (s3 & (1 << 6))
 		*status |= FE_HAS_SIGNAL;
 
 	if ((*status & (FE_HAS_CARRIER | FE_HAS_VITERBI | FE_HAS_SYNC)) !=
@@ -481,7 +454,7 @@ static int mt352_read_status(struct dvb_
 
 static int mt352_read_ber(struct dvb_frontend* fe, u32* ber)
 {
-	struct mt352_state* state = (struct mt352_state*) fe->demodulator_priv;
+	struct mt352_state* state = fe->demodulator_priv;
 
 	*ber = (mt352_read_register (state, RS_ERR_CNT_2) << 16) |
 	       (mt352_read_register (state, RS_ERR_CNT_1) << 8) |
@@ -492,10 +465,10 @@ static int mt352_read_ber(struct dvb_fro
 
 static int mt352_read_signal_strength(struct dvb_frontend* fe, u16* strength)
 {
-	struct mt352_state* state = (struct mt352_state*) fe->demodulator_priv;
+	struct mt352_state* state = fe->demodulator_priv;
 
-	u16 signal = (mt352_read_register (state, AGC_GAIN_3) << 8) |
-		     (mt352_read_register (state, AGC_GAIN_2));
+	u16 signal = ((mt352_read_register(state, AGC_GAIN_1) << 8) & 0x0f) |
+		      (mt352_read_register(state, AGC_GAIN_0));
 
 	*strength = ~signal;
 	return 0;
@@ -503,7 +476,7 @@ static int mt352_read_signal_strength(st
 
 static int mt352_read_snr(struct dvb_frontend* fe, u16* snr)
 {
-	struct mt352_state* state = (struct mt352_state*) fe->demodulator_priv;
+	struct mt352_state* state = fe->demodulator_priv;
 
 	u8 _snr = mt352_read_register (state, SNR);
 	*snr = (_snr << 8) | _snr;
@@ -513,7 +486,7 @@ static int mt352_read_snr(struct dvb_fro
 
 static int mt352_read_ucblocks(struct dvb_frontend* fe, u32* ucblocks)
 {
-	struct mt352_state* state = (struct mt352_state*) fe->demodulator_priv;
+	struct mt352_state* state = fe->demodulator_priv;
 
 	*ucblocks = (mt352_read_register (state,  RS_UBC_1) << 8) |
 		    (mt352_read_register (state,  RS_UBC_0));
@@ -532,7 +505,7 @@ static int mt352_get_tune_settings(struc
 
 static int mt352_init(struct dvb_frontend* fe)
 {
-	struct mt352_state* state = (struct mt352_state*) fe->demodulator_priv;
+	struct mt352_state* state = fe->demodulator_priv;
 
 	static u8 mt352_reset_attach [] = { RESET, 0xC0 };
 
@@ -551,7 +524,7 @@ static int mt352_init(struct dvb_fronten
 
 static void mt352_release(struct dvb_frontend* fe)
 {
-	struct mt352_state* state = (struct mt352_state*) fe->demodulator_priv;
+	struct mt352_state* state = fe->demodulator_priv;
 	kfree(state);
 }
 
@@ -563,7 +536,7 @@ struct dvb_frontend* mt352_attach(const 
 	struct mt352_state* state = NULL;
 
 	/* allocate memory for the internal state */
-	state = (struct mt352_state*) kmalloc(sizeof(struct mt352_state), GFP_KERNEL);
+	state = kmalloc(sizeof(struct mt352_state), GFP_KERNEL);
 	if (state == NULL) goto error;
 	memset(state,0,sizeof(*state));
 

--

