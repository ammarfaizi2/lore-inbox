Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030188AbWHHVLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030188AbWHHVLm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 17:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030212AbWHHVLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 17:11:42 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:47306 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030203AbWHHVLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 17:11:37 -0400
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Yeasah Pell <yeasah@schwide.com>,
       Yeasah Pell <yeasah@shwide.com>, Manu Abraham <manu@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 13/14] V4L/DVB (4431): Add several error checks to dst
Date: Tue, 08 Aug 2006 18:06:54 -0300
Message-id: <20060808210654.PS70850700013@infradead.org>
In-Reply-To: <20060808210151.PS78629800000@infradead.org>
References: <20060808210151.PS78629800000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.2.1-4mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Yeasah Pell <yeasah@schwide.com>

Signed-off-by: Yeasah Pell <yeasah@shwide.com>
Signed-off-by: Manu Abraham <manu@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/dvb/bt8xx/dst.c |   58 +++++++++++++++++++----------------------
 1 files changed, 27 insertions(+), 31 deletions(-)

diff --git a/drivers/media/dvb/bt8xx/dst.c b/drivers/media/dvb/bt8xx/dst.c
index d687a14..06ac899 100644
--- a/drivers/media/dvb/bt8xx/dst.c
+++ b/drivers/media/dvb/bt8xx/dst.c
@@ -393,7 +393,7 @@ static int dst_set_bandwidth(struct dst_
 	state->bandwidth = bandwidth;
 
 	if (state->dst_type != DST_TYPE_IS_TERR)
-		return 0;
+		return -EOPNOTSUPP;
 
 	switch (bandwidth) {
 	case BANDWIDTH_6_MHZ:
@@ -462,7 +462,7 @@ static int dst_set_symbolrate(struct dst
 
 	state->symbol_rate = srate;
 	if (state->dst_type == DST_TYPE_IS_TERR) {
-		return 0;
+		return -EOPNOTSUPP;
 	}
 	dprintk(verbose, DST_INFO, 1, "set symrate %u", srate);
 	srate /= 1000;
@@ -504,7 +504,7 @@ static int dst_set_symbolrate(struct dst
 static int dst_set_modulation(struct dst_state *state, fe_modulation_t modulation)
 {
 	if (state->dst_type != DST_TYPE_IS_CABLE)
-		return 0;
+		return -EOPNOTSUPP;
 
 	state->modulation = modulation;
 	switch (modulation) {
@@ -1234,7 +1234,7 @@ int dst_command(struct dst_state *state,
 		goto error;
 	}
 	if (write_dst(state, data, len)) {
-		dprintk(verbose, DST_INFO, 1, "Tring to recover.. ");
+		dprintk(verbose, DST_INFO, 1, "Trying to recover.. ");
 		if ((dst_error_recovery(state)) < 0) {
 			dprintk(verbose, DST_ERROR, 1, "Recovery Failed.");
 			goto error;
@@ -1328,15 +1328,13 @@ static int dst_tone_power_cmd(struct dst
 {
 	u8 paket[8] = { 0x00, 0x09, 0xff, 0xff, 0x01, 0x00, 0x00, 0x00 };
 
-	if (state->dst_type == DST_TYPE_IS_TERR)
-		return 0;
+	if (state->dst_type != DST_TYPE_IS_SAT)
+		return -EOPNOTSUPP;
 	paket[4] = state->tx_tuna[4];
 	paket[2] = state->tx_tuna[2];
 	paket[3] = state->tx_tuna[3];
 	paket[7] = dst_check_sum (paket, 7);
-	dst_command(state, paket, 8);
-
-	return 0;
+	return dst_command(state, paket, 8);
 }
 
 static int dst_get_tuna(struct dst_state *state)
@@ -1465,7 +1463,7 @@ static int dst_set_diseqc(struct dvb_fro
 	u8 paket[8] = { 0x00, 0x08, 0x04, 0xe0, 0x10, 0x38, 0xf0, 0xec };
 
 	if (state->dst_type != DST_TYPE_IS_SAT)
-		return 0;
+		return -EOPNOTSUPP;
 	if (cmd->msg_len > 0 && cmd->msg_len < 5)
 		memcpy(&paket[3], cmd->msg, cmd->msg_len);
 	else if (cmd->msg_len == 5 && state->dst_hw_cap & DST_TYPE_HAS_DISEQC5)
@@ -1473,18 +1471,17 @@ static int dst_set_diseqc(struct dvb_fro
 	else
 		return -EINVAL;
 	paket[7] = dst_check_sum(&paket[0], 7);
-	dst_command(state, paket, 8);
-	return 0;
+	return dst_command(state, paket, 8);
 }
 
 static int dst_set_voltage(struct dvb_frontend *fe, fe_sec_voltage_t voltage)
 {
-	int need_cmd;
+	int need_cmd, retval = 0;
 	struct dst_state *state = fe->demodulator_priv;
 
 	state->voltage = voltage;
 	if (state->dst_type != DST_TYPE_IS_SAT)
-		return 0;
+		return -EOPNOTSUPP;
 
 	need_cmd = 0;
 
@@ -1506,9 +1503,9 @@ static int dst_set_voltage(struct dvb_fr
 	}
 
 	if (need_cmd)
-		dst_tone_power_cmd(state);
+		retval = dst_tone_power_cmd(state);
 
-	return 0;
+	return retval;
 }
 
 static int dst_set_tone(struct dvb_frontend *fe, fe_sec_tone_mode_t tone)
@@ -1517,7 +1514,7 @@ static int dst_set_tone(struct dvb_front
 
 	state->tone = tone;
 	if (state->dst_type != DST_TYPE_IS_SAT)
-		return 0;
+		return -EOPNOTSUPP;
 
 	switch (tone) {
 	case SEC_TONE_OFF:
@@ -1533,9 +1530,7 @@ static int dst_set_tone(struct dvb_front
 	default:
 		return -EINVAL;
 	}
-	dst_tone_power_cmd(state);
-
-	return 0;
+	return dst_tone_power_cmd(state);
 }
 
 static int dst_send_burst(struct dvb_frontend *fe, fe_sec_mini_cmd_t minicmd)
@@ -1543,7 +1538,7 @@ static int dst_send_burst(struct dvb_fro
 	struct dst_state *state = fe->demodulator_priv;
 
 	if (state->dst_type != DST_TYPE_IS_SAT)
-		return 0;
+		return -EOPNOTSUPP;
 	state->minicmd = minicmd;
 	switch (minicmd) {
 	case SEC_MINI_A:
@@ -1553,9 +1548,7 @@ static int dst_send_burst(struct dvb_fro
 		state->tx_tuna[3] = 0xff;
 		break;
 	}
-	dst_tone_power_cmd(state);
-
-	return 0;
+	return dst_tone_power_cmd(state);
 }
 
 
@@ -1608,28 +1601,31 @@ static int dst_read_signal_strength(stru
 {
 	struct dst_state *state = fe->demodulator_priv;
 
-	dst_get_signal(state);
+	int retval = dst_get_signal(state);
 	*strength = state->decode_strength;
 
-	return 0;
+	return retval;
 }
 
 static int dst_read_snr(struct dvb_frontend *fe, u16 *snr)
 {
 	struct dst_state *state = fe->demodulator_priv;
 
-	dst_get_signal(state);
+	int retval = dst_get_signal(state);
 	*snr = state->decode_snr;
 
-	return 0;
+	return retval;
 }
 
 static int dst_set_frontend(struct dvb_frontend *fe, struct dvb_frontend_parameters *p)
 {
+	int retval = -EINVAL;
 	struct dst_state *state = fe->demodulator_priv;
 
 	if (p != NULL) {
-		dst_set_freq(state, p->frequency);
+		retval = dst_set_freq(state, p->frequency);
+		if(retval != 0)
+			return retval;
 		dprintk(verbose, DST_DEBUG, 1, "Set Frequency=[%d]", p->frequency);
 
 		if (state->dst_type == DST_TYPE_IS_SAT) {
@@ -1647,10 +1643,10 @@ static int dst_set_frontend(struct dvb_f
 			dst_set_symbolrate(state, p->u.qam.symbol_rate);
 			dst_set_modulation(state, p->u.qam.modulation);
 		}
-		dst_write_tuna(fe);
+		retval = dst_write_tuna(fe);
 	}
 
-	return 0;
+	return retval;
 }
 
 static int dst_tune_frontend(struct dvb_frontend* fe,

