Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbVIDXrB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbVIDXrB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbVIDXao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:30:44 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:35457 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932119AbVIDXaW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:30:22 -0400
Message-Id: <20050904232321.306762000@abc>
References: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:23:13 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andrew de Quincey <adq_dvb@lidskialf.net>
Content-Disposition: inline; filename=dvb-frontend-s5h1420-fixes.patch
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 14/54] frontend: s5h1420: fixes
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew de Quincey <adq_dvb@lidskialf.net>

Misc. fixes.

Signed-off-by: Andrew de Quincey <adq_dvb@lidskialf.net>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/frontends/s5h1420.c |  162 +++++++++++++++++++---------------
 drivers/media/dvb/frontends/s5h1420.h |    3 
 drivers/media/dvb/ttpci/budget.c      |    1 
 3 files changed, 97 insertions(+), 69 deletions(-)

--- linux-2.6.13-git4.orig/drivers/media/dvb/frontends/s5h1420.c	2005-09-04 22:24:24.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/frontends/s5h1420.c	2005-09-04 22:28:04.000000000 +0200
@@ -48,7 +48,8 @@ struct s5h1420_state {
 };
 
 static u32 s5h1420_getsymbolrate(struct s5h1420_state* state);
-static int s5h1420_get_tune_settings(struct dvb_frontend* fe, struct dvb_frontend_tune_settings* fesettings);
+static int s5h1420_get_tune_settings(struct dvb_frontend* fe,
+				     struct dvb_frontend_tune_settings* fesettings);
 
 
 static int debug = 0;
@@ -91,7 +92,8 @@ static int s5h1420_set_voltage (struct d
 
 	switch(voltage) {
 	case SEC_VOLTAGE_13:
-		s5h1420_writereg(state, 0x3c, (s5h1420_readreg(state, 0x3c) & 0xfe) | 0x02);
+		s5h1420_writereg(state, 0x3c,
+				 (s5h1420_readreg(state, 0x3c) & 0xfe) | 0x02);
 		break;
 
 	case SEC_VOLTAGE_18:
@@ -112,18 +114,21 @@ static int s5h1420_set_tone (struct dvb_
 
 	switch(tone) {
 	case SEC_TONE_ON:
-		s5h1420_writereg(state, 0x3b, (s5h1420_readreg(state, 0x3b) & 0x74) | 0x08);
+		s5h1420_writereg(state, 0x3b,
+				 (s5h1420_readreg(state, 0x3b) & 0x74) | 0x08);
 		break;
 
 	case SEC_TONE_OFF:
-		s5h1420_writereg(state, 0x3b, (s5h1420_readreg(state, 0x3b) & 0x74) | 0x01);
+		s5h1420_writereg(state, 0x3b,
+				 (s5h1420_readreg(state, 0x3b) & 0x74) | 0x01);
 		break;
 	}
 
 	return 0;
 }
 
-static int s5h1420_send_master_cmd (struct dvb_frontend* fe, struct dvb_diseqc_master_cmd* cmd)
+static int s5h1420_send_master_cmd (struct dvb_frontend* fe,
+				    struct dvb_diseqc_master_cmd* cmd)
 {
 	struct s5h1420_state* state = fe->demodulator_priv;
 	u8 val;
@@ -131,6 +136,9 @@ static int s5h1420_send_master_cmd (stru
 	unsigned long timeout;
 	int result = 0;
 
+	if (cmd->msg_len > 8)
+		return -EINVAL;
+
 	/* setup for DISEQC */
 	val = s5h1420_readreg(state, 0x3b);
 	s5h1420_writereg(state, 0x3b, 0x02);
@@ -138,16 +146,17 @@ static int s5h1420_send_master_cmd (stru
 
 	/* write the DISEQC command bytes */
 	for(i=0; i< cmd->msg_len; i++) {
-		s5h1420_writereg(state, 0x3c + i, cmd->msg[i]);
+		s5h1420_writereg(state, 0x3d + i, cmd->msg[i]);
 	}
 
 	/* kick off transmission */
-	s5h1420_writereg(state, 0x3b, s5h1420_readreg(state, 0x3b) | ((cmd->msg_len-1) << 4) | 0x08);
+	s5h1420_writereg(state, 0x3b, s5h1420_readreg(state, 0x3b) |
+				      ((cmd->msg_len-1) << 4) | 0x08);
 
 	/* wait for transmission to complete */
 	timeout = jiffies + ((100*HZ) / 1000);
 	while(time_before(jiffies, timeout)) {
-		if (s5h1420_readreg(state, 0x3b) & 0x08)
+		if (!(s5h1420_readreg(state, 0x3b) & 0x08))
 			break;
 
 		msleep(5);
@@ -161,7 +170,8 @@ static int s5h1420_send_master_cmd (stru
 	return result;
 }
 
-static int s5h1420_recv_slave_reply (struct dvb_frontend* fe, struct dvb_diseqc_slave_reply* reply)
+static int s5h1420_recv_slave_reply (struct dvb_frontend* fe,
+				     struct dvb_diseqc_slave_reply* reply)
 {
 	struct s5h1420_state* state = fe->demodulator_priv;
 	u8 val;
@@ -205,7 +215,7 @@ static int s5h1420_recv_slave_reply (str
 
 	/* extract data */
 	for(i=0; i< length; i++) {
-		reply->msg[i] = s5h1420_readreg(state, 0x3c + i);
+		reply->msg[i] = s5h1420_readreg(state, 0x3d + i);
 	}
 
 exit:
@@ -236,7 +246,7 @@ static int s5h1420_send_burst (struct dv
 	s5h1420_writereg(state, 0x3b, s5h1420_readreg(state, 0x3b) | 0x08);
 
 	/* wait for transmission to complete */
-	timeout = jiffies + ((20*HZ) / 1000);
+	timeout = jiffies + ((100*HZ) / 1000);
 	while(time_before(jiffies, timeout)) {
 		if (!(s5h1420_readreg(state, 0x3b) & 0x08))
 			break;
@@ -259,9 +269,9 @@ static fe_status_t s5h1420_get_status_bi
 
 	val = s5h1420_readreg(state, 0x14);
 	if (val & 0x02)
-		status |=  FE_HAS_SIGNAL; // FIXME: not sure if this is right
+		status |=  FE_HAS_SIGNAL;
 	if (val & 0x01)
-		status |=  FE_HAS_CARRIER; // FIXME: not sure if this is right
+		status |=  FE_HAS_CARRIER;
 	val = s5h1420_readreg(state, 0x36);
 	if (val & 0x01)
 		status |=  FE_HAS_VITERBI;
@@ -284,8 +294,8 @@ static int s5h1420_read_status(struct dv
 	/* determine lock state */
 	*status = s5h1420_get_status_bits(state);
 
-	/* fix for FEC 5/6 inversion issue - if it doesn't quite lock, invert the inversion,
-	wait a bit and check again */
+	/* fix for FEC 5/6 inversion issue - if it doesn't quite lock, invert
+	the inversion, wait a bit and check again */
 	if (*status == (FE_HAS_SIGNAL|FE_HAS_CARRIER|FE_HAS_VITERBI)) {
 		val = s5h1420_readreg(state, 0x32);
 		if ((val & 0x07) == 0x03) {
@@ -330,6 +340,10 @@ static int s5h1420_read_status(struct dv
 			tmp = (tmp * 2 * 7) / 8;
 			break;
 		}
+		if (tmp == 0) {
+			printk("s5h1420: avoided division by 0\n");
+			tmp = 1;
+		}
 		tmp = state->fclk / tmp;
 
 		/* set the MPEG_CLK_INTL for the calculated data rate */
@@ -368,16 +382,21 @@ static int s5h1420_read_ber(struct dvb_f
 
 	s5h1420_writereg(state, 0x46, 0x1d);
 	mdelay(25);
-	return (s5h1420_readreg(state, 0x48) << 8) | s5h1420_readreg(state, 0x47);
+
+	*ber = (s5h1420_readreg(state, 0x48) << 8) | s5h1420_readreg(state, 0x47);
+
+	return 0;
 }
 
 static int s5h1420_read_signal_strength(struct dvb_frontend* fe, u16* strength)
 {
 	struct s5h1420_state* state = fe->demodulator_priv;
 
-	u8 val = 0xff - s5h1420_readreg(state, 0x15);
+	u8 val = s5h1420_readreg(state, 0x15);
 
-	return (int) ((val << 8) | val);
+	*strength =  (u16) ((val << 8) | val);
+
+	return 0;
 }
 
 static int s5h1420_read_ucblocks(struct dvb_frontend* fe, u32* ucblocks)
@@ -386,7 +405,10 @@ static int s5h1420_read_ucblocks(struct 
 
 	s5h1420_writereg(state, 0x46, 0x1f);
 	mdelay(25);
-	return (s5h1420_readreg(state, 0x48) << 8) | s5h1420_readreg(state, 0x47);
+
+	*ucblocks = (s5h1420_readreg(state, 0x48) << 8) | s5h1420_readreg(state, 0x47);
+
+	return 0;
 }
 
 static void s5h1420_reset(struct s5h1420_state* state)
@@ -396,11 +418,12 @@ static void s5h1420_reset(struct s5h1420
 	udelay(10);
 }
 
-static void s5h1420_setsymbolrate(struct s5h1420_state* state, struct dvb_frontend_parameters *p)
+static void s5h1420_setsymbolrate(struct s5h1420_state* state,
+				  struct dvb_frontend_parameters *p)
 {
 	u64 val;
 
-	val = (p->u.qpsk.symbol_rate / 1000) * (1<<24);
+	val = ((u64) p->u.qpsk.symbol_rate / 1000ULL) * (1ULL<<24);
 	if (p->u.qpsk.symbol_rate <= 21000000) {
 		val *= 2;
 	}
@@ -415,7 +438,7 @@ static void s5h1420_setsymbolrate(struct
 
 static u32 s5h1420_getsymbolrate(struct s5h1420_state* state)
 {
-	u64 val;
+	u64 val = 0;
 	int sampling = 2;
 
 	if (s5h1420_readreg(state, 0x05) & 0x2)
@@ -427,10 +450,10 @@ static u32 s5h1420_getsymbolrate(struct 
 	val |= s5h1420_readreg(state, 0x13);
 	s5h1420_writereg(state, 0x06, s5h1420_readreg(state, 0x06) & 0xf7);
 
-	val *= (state->fclk / 1000);
+	val *= (state->fclk / 1000ULL);
 	do_div(val, ((1<<24) * sampling));
 
-	return (u32) (val * 1000);
+	return (u32) (val * 1000ULL);
 }
 
 static void s5h1420_setfreqoffset(struct s5h1420_state* state, int freqoffset)
@@ -463,46 +486,55 @@ static int s5h1420_getfreqoffset(struct 
 
 	/* remember freqoffset is in kHz, but the chip wants the offset in Hz, so
 	 * divide fclk by 1000000 to get the correct value. */
-	val = - ((val * (state->fclk/1000000)) / (1<<24));
+	val = (((-val) * (state->fclk/1000000)) / (1<<24));
 
 	return val;
 }
 
-static void s5h1420_setfec(struct s5h1420_state* state, struct dvb_frontend_parameters *p)
+static void s5h1420_setfec_inversion(struct s5h1420_state* state,
+			   	     struct dvb_frontend_parameters *p)
 {
+	u8 inversion = 0;
+
+	if (p->inversion == INVERSION_OFF) {
+		inversion = state->config->invert ? 0x08 : 0;
+	} else if (p->inversion == INVERSION_ON) {
+		inversion = state->config->invert ? 0 : 0x08;
+	}
+
 	if ((p->u.qpsk.fec_inner == FEC_AUTO) || (p->inversion == INVERSION_AUTO)) {
-		s5h1420_writereg(state, 0x31, 0x00);
 		s5h1420_writereg(state, 0x30, 0x3f);
+		s5h1420_writereg(state, 0x31, 0x00 | inversion);
 	} else {
 		switch(p->u.qpsk.fec_inner) {
 		case FEC_1_2:
-			s5h1420_writereg(state, 0x31, 0x10);
 			s5h1420_writereg(state, 0x30, 0x01);
+			s5h1420_writereg(state, 0x31, 0x10 | inversion);
 			break;
 
 		case FEC_2_3:
-			s5h1420_writereg(state, 0x31, 0x11);
 			s5h1420_writereg(state, 0x30, 0x02);
+			s5h1420_writereg(state, 0x31, 0x11 | inversion);
 			break;
 
 		case FEC_3_4:
-			s5h1420_writereg(state, 0x31, 0x12);
 			s5h1420_writereg(state, 0x30, 0x04);
-			break;
+                        s5h1420_writereg(state, 0x31, 0x12 | inversion);
+                        break;
 
 		case FEC_5_6:
-			s5h1420_writereg(state, 0x31, 0x13);
 			s5h1420_writereg(state, 0x30, 0x08);
+			s5h1420_writereg(state, 0x31, 0x13 | inversion);
 			break;
 
 		case FEC_6_7:
-			s5h1420_writereg(state, 0x31, 0x14);
 			s5h1420_writereg(state, 0x30, 0x10);
+			s5h1420_writereg(state, 0x31, 0x14 | inversion);
 			break;
 
 		case FEC_7_8:
-			s5h1420_writereg(state, 0x31, 0x15);
 			s5h1420_writereg(state, 0x30, 0x20);
+			s5h1420_writereg(state, 0x31, 0x15 | inversion);
 			break;
 
 		default:
@@ -536,22 +568,6 @@ static fe_code_rate_t s5h1420_getfec(str
 	return FEC_NONE;
 }
 
-static void s5h1420_setinversion(struct s5h1420_state* state, struct dvb_frontend_parameters *p)
-{
-	if ((p->u.qpsk.fec_inner == FEC_AUTO) || (p->inversion == INVERSION_AUTO)) {
-		s5h1420_writereg(state, 0x31, 0x00);
-		s5h1420_writereg(state, 0x30, 0x3f);
-	} else {
-		u8 tmp = s5h1420_readreg(state, 0x31) & 0xf7;
-			tmp |= 0x10;
-
-		if (p->inversion == INVERSION_ON)
-			tmp |= 0x80;
-
-		s5h1420_writereg(state, 0x31, tmp);
-	}
-}
-
 static fe_spectral_inversion_t s5h1420_getinversion(struct s5h1420_state* state)
 {
 	if (s5h1420_readreg(state, 0x32) & 0x08)
@@ -560,35 +576,35 @@ static fe_spectral_inversion_t s5h1420_g
 	return INVERSION_OFF;
 }
 
-static int s5h1420_set_frontend(struct dvb_frontend* fe, struct dvb_frontend_parameters *p)
+static int s5h1420_set_frontend(struct dvb_frontend* fe,
+				struct dvb_frontend_parameters *p)
 {
 	struct s5h1420_state* state = fe->demodulator_priv;
-	u32 frequency_delta;
+	int frequency_delta;
 	struct dvb_frontend_tune_settings fesettings;
+	u32 tmp;
 
 	/* check if we should do a fast-tune */
 	memcpy(&fesettings.parameters, p, sizeof(struct dvb_frontend_parameters));
 	s5h1420_get_tune_settings(fe, &fesettings);
 	frequency_delta = p->frequency - state->tunedfreq;
-	if ((frequency_delta > -fesettings.max_drift) && (frequency_delta < fesettings.max_drift) &&
+	if ((frequency_delta > -fesettings.max_drift) &&
+	    (frequency_delta < fesettings.max_drift) &&
 	    (frequency_delta != 0) &&
 	    (state->fec_inner == p->u.qpsk.fec_inner) &&
 	    (state->symbol_rate == p->u.qpsk.symbol_rate)) {
 
-		s5h1420_setfreqoffset(state, frequency_delta);
+		if (state->config->pll_set) {
+			s5h1420_writereg (state, 0x02, s5h1420_readreg(state,0x02) | 1);
+			state->config->pll_set(fe, p, &tmp);
+			s5h1420_setfreqoffset(state, p->frequency - tmp);
+		}
 		return 0;
 	}
 
 	/* first of all, software reset */
 	s5h1420_reset(state);
 
-	/* set tuner PLL */
-	if (state->config->pll_set) {
-		s5h1420_writereg (state, 0x02, s5h1420_readreg(state,0x02) | 1);
-		state->config->pll_set(fe, p, &state->tunedfreq);
-		s5h1420_writereg (state, 0x02, s5h1420_readreg(state,0x02) & 0xfe);
-	}
-
 	/* set s5h1420 fclk PLL according to desired symbol rate */
 	if (p->u.qpsk.symbol_rate > 28000000) {
 		state->fclk = 88000000;
@@ -609,8 +625,9 @@ static int s5h1420_set_frontend(struct d
 
 	/* set misc registers */
 	s5h1420_writereg(state, 0x02, 0x00);
+	s5h1420_writereg(state, 0x06, 0x00);
 	s5h1420_writereg(state, 0x07, 0xb0);
-	s5h1420_writereg(state, 0x0a, 0x67);
+	s5h1420_writereg(state, 0x0a, 0xe7);
 	s5h1420_writereg(state, 0x0b, 0x78);
 	s5h1420_writereg(state, 0x0c, 0x48);
 	s5h1420_writereg(state, 0x0d, 0x6b);
@@ -626,21 +643,26 @@ static int s5h1420_set_frontend(struct d
 	/* start QPSK */
 	s5h1420_writereg(state, 0x05, s5h1420_readreg(state, 0x05) | 1);
 
-	/* set the frequency offset to adjust for PLL inaccuracy */
-	s5h1420_setfreqoffset(state, p->frequency - state->tunedfreq);
+	/* set tuner PLL */
+	if (state->config->pll_set) {
+		s5h1420_writereg (state, 0x02, s5h1420_readreg(state,0x02) | 1);
+		state->config->pll_set(fe, p, &tmp);
+		s5h1420_setfreqoffset(state, 0);
+	}
 
 	/* set the reset of the parameters */
 	s5h1420_setsymbolrate(state, p);
-	s5h1420_setinversion(state, p);
-	s5h1420_setfec(state, p);
+	s5h1420_setfec_inversion(state, p);
 
 	state->fec_inner = p->u.qpsk.fec_inner;
 	state->symbol_rate = p->u.qpsk.symbol_rate;
 	state->postlocked = 0;
+	state->tunedfreq = p->frequency;
 	return 0;
 }
 
-static int s5h1420_get_frontend(struct dvb_frontend* fe, struct dvb_frontend_parameters *p)
+static int s5h1420_get_frontend(struct dvb_frontend* fe,
+				struct dvb_frontend_parameters *p)
 {
 	struct s5h1420_state* state = fe->demodulator_priv;
 
@@ -652,7 +674,8 @@ static int s5h1420_get_frontend(struct d
 	return 0;
 }
 
-static int s5h1420_get_tune_settings(struct dvb_frontend* fe, struct dvb_frontend_tune_settings* fesettings)
+static int s5h1420_get_tune_settings(struct dvb_frontend* fe,
+				     struct dvb_frontend_tune_settings* fesettings)
 {
 	if (fesettings->parameters.u.qpsk.symbol_rate > 20000000) {
 		fesettings->min_delay_ms = 50;
@@ -717,7 +740,8 @@ static void s5h1420_release(struct dvb_f
 
 static struct dvb_frontend_ops s5h1420_ops;
 
-struct dvb_frontend* s5h1420_attach(const struct s5h1420_config* config, struct i2c_adapter* i2c)
+struct dvb_frontend* s5h1420_attach(const struct s5h1420_config* config,
+				    struct i2c_adapter* i2c)
 {
 	struct s5h1420_state* state = NULL;
 	u8 identity;
--- linux-2.6.13-git4.orig/drivers/media/dvb/frontends/s5h1420.h	2005-09-04 22:24:24.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/frontends/s5h1420.h	2005-09-04 22:28:04.000000000 +0200
@@ -30,6 +30,9 @@ struct s5h1420_config
 	/* the demodulator's i2c address */
 	u8 demod_address;
 
+	/* does the inversion require inversion? */
+	u8 invert:1;
+
 	/* PLL maintenance */
 	int (*pll_init)(struct dvb_frontend* fe);
 	int (*pll_set)(struct dvb_frontend* fe, struct dvb_frontend_parameters* params, u32* freqout);
--- linux-2.6.13-git4.orig/drivers/media/dvb/ttpci/budget.c	2005-09-04 22:28:03.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/ttpci/budget.c	2005-09-04 22:28:04.000000000 +0200
@@ -480,6 +480,7 @@ static int s5h1420_pll_set(struct dvb_fr
 
 static struct s5h1420_config s5h1420_config = {
 	.demod_address = 0x53,
+	.invert = 1,
 	.pll_set = s5h1420_pll_set,
 };
 

--

