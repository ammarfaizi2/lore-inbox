Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262018AbVF0Mbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbVF0Mbq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 08:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbVF0Mbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 08:31:45 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:1509 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262018AbVF0MQE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:16:04 -0400
Message-Id: <20050627121413.302343000@abc>
References: <20050627120600.739151000@abc>
Date: Mon, 27 Jun 2005 14:06:19 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Manu Abraham <manu@kromtek.com>
Content-Disposition: inline; filename=dvb-bt8xx-dst-fixes.patch
X-SA-Exim-Connect-IP: 84.189.248.249
Subject: [DVB patch 19/51] Twinhan DST: frontend fixes
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manu Abraham <manu@kromtek.com>

o Make the inversion setting specific, ie, only for the 200103A DVB-S
  This should not be flagged on other cards.
o Make the frequency setting card specific
o Make the bandwidth setting generic such that it supports more DVB-T cards
o Set QAM size for DVB-C cards that do not autodetect QAM size
o Fix a bug that caused the polarization not to be set.
  Set polarization for cards that do not autodetect polarization
o Fix a bogus frontend signal lock, that caused a tuning delay as well.
o Make the Symbolrate setting card specific

Signed-off-by: Manu Abraham <manu@kromtek.com>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/bt8xx/dst.c        |  227 ++++++++++++++--------
 drivers/media/dvb/bt8xx/dst_ca.c     |  349 ++++++++++++-----------------------
 drivers/media/dvb/bt8xx/dst_common.h |    3 
 3 files changed, 272 insertions(+), 307 deletions(-)

Index: linux-2.6.12-git8/drivers/media/dvb/bt8xx/dst.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/bt8xx/dst.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/bt8xx/dst.c	2005-06-27 13:24:12.000000000 +0200
@@ -258,10 +258,10 @@ int write_dst(struct dst_state *state, u
 	if (debug && (verbose > 4)) {
 		u8 i;
 		if (verbose > 4) {
-			dprintk("%s writing", __FUNCTION__);
+			dprintk("%s writing [ ", __FUNCTION__);
 			for (i = 0; i < len; i++)
-				dprintk(" %02x", data[i]);
-			dprintk("\n");
+				dprintk("%02x ", data[i]);
+			dprintk("]\n");
 		}
 	}
 	for (cnt = 0; cnt < 2; cnt++) {
@@ -320,10 +320,29 @@ int read_dst(struct dst_state *state, u8
 }
 EXPORT_SYMBOL(read_dst);
 
-static int dst_set_freq(struct dst_state *state, u32 freq)
+static int dst_set_polarization(struct dst_state *state)
 {
-	u8 *val;
+	switch (state->voltage) {
+		case SEC_VOLTAGE_13:	// vertical
+			printk("%s: Polarization=[Vertical]\n", __FUNCTION__);
+			state->tx_tuna[8] |= 0x40;  //1
+			break;
+
+		case SEC_VOLTAGE_18:	// horizontal
+			printk("%s: Polarization=[Horizontal]\n", __FUNCTION__);
+			state->tx_tuna[8] =~ 0x40;  // 0
+			break;
 
+		case SEC_VOLTAGE_OFF:
+
+			break;
+	}
+
+	return 0;
+}
+
+static int dst_set_freq(struct dst_state *state, u32 freq)
+{
 	state->frequency = freq;
 	if (debug > 4)
 		dprintk("%s: set Frequency %u\n", __FUNCTION__, freq);
@@ -332,46 +351,30 @@ static int dst_set_freq(struct dst_state
 		freq = freq / 1000;
 		if (freq < 950 || freq > 2150)
 			return -EINVAL;
-		val = &state->tx_tuna[0];
-		val[2] = (freq >> 8) & 0x7f;
-		val[3] = (u8) freq;
-		val[4] = 1;
-		val[8] &= ~4;
-		if (freq < 1531)
-			val[8] |= 4;
+
+		state->tx_tuna[2] = (freq >> 8);
+		state->tx_tuna[3] = (u8) freq;
+		state->tx_tuna[4] = 0x01;
+		state->tx_tuna[8] &= ~0x04;
+		if (state->type_flags & DST_TYPE_HAS_OBS_REGS) {
+			if (freq < 1531)
+				state->tx_tuna[8] |= 0x04;
+		}
+
 	} else if (state->dst_type == DST_TYPE_IS_TERR) {
 		freq = freq / 1000;
 		if (freq < 137000 || freq > 858000)
 			return -EINVAL;
-		val = &state->tx_tuna[0];
-		val[2] = (freq >> 16) & 0xff;
-		val[3] = (freq >> 8) & 0xff;
-		val[4] = (u8) freq;
-		val[5] = 0;
-		switch (state->bandwidth) {
-		case BANDWIDTH_6_MHZ:
-			val[6] = 6;
-			break;
-
-		case BANDWIDTH_7_MHZ:
-		case BANDWIDTH_AUTO:
-			val[6] = 7;
-			break;
 
-		case BANDWIDTH_8_MHZ:
-			val[6] = 8;
-			break;
-		}
+		state->tx_tuna[2] = (freq >> 16) & 0xff;
+		state->tx_tuna[3] = (freq >> 8) & 0xff;
+		state->tx_tuna[4] = (u8) freq;
 
-		val[7] = 0;
-		val[8] = 0;
 	} else if (state->dst_type == DST_TYPE_IS_CABLE) {
-		/* guess till will get one */
-		freq = freq / 1000;
-		val = &state->tx_tuna[0];
-		val[2] = (freq >> 16) & 0xff;
-		val[3] = (freq >> 8) & 0xff;
-		val[4] = (u8) freq;
+		state->tx_tuna[2] = (freq >> 16) & 0xff;
+		state->tx_tuna[3] = (freq >> 8) & 0xff;
+		state->tx_tuna[4] = (u8) freq;
+
 	} else
 		return -EINVAL;
 	return 0;
@@ -379,51 +382,58 @@ static int dst_set_freq(struct dst_state
 
 static int dst_set_bandwidth(struct dst_state* state, fe_bandwidth_t bandwidth)
 {
-	u8 *val;
-
 	state->bandwidth = bandwidth;
 
 	if (state->dst_type != DST_TYPE_IS_TERR)
 		return 0;
 
-	val = &state->tx_tuna[0];
 	switch (bandwidth) {
-	case BANDWIDTH_6_MHZ:
-		val[6] = 6;
-		break;
+		case BANDWIDTH_6_MHZ:
+			if (state->dst_hw_cap & DST_TYPE_HAS_CA)
+				state->tx_tuna[7] = 0x06;
+			else {
+				state->tx_tuna[6] = 0x06;
+				state->tx_tuna[7] = 0x00;
+			}
+			break;
 
-	case BANDWIDTH_7_MHZ:
-		val[6] = 7;
-		break;
+		case BANDWIDTH_7_MHZ:
+			if (state->dst_hw_cap & DST_TYPE_HAS_CA)
+				state->tx_tuna[7] = 0x07;
+			else {
+				state->tx_tuna[6] = 0x07;
+				state->tx_tuna[7] = 0x00;
+			}
+			break;
 
-	case BANDWIDTH_8_MHZ:
-		val[6] = 8;
-		break;
+		case BANDWIDTH_8_MHZ:
+			if (state->dst_hw_cap & DST_TYPE_HAS_CA)
+				state->tx_tuna[7] = 0x08;
+			else {
+				state->tx_tuna[6] = 0x08;
+				state->tx_tuna[7] = 0x00;
+			}
+			break;
 
-	default:
-		return -EINVAL;
+		default:
+			return -EINVAL;
 	}
 	return 0;
 }
 
 static int dst_set_inversion(struct dst_state* state, fe_spectral_inversion_t inversion)
 {
-	u8 *val;
-
 	state->inversion = inversion;
-
-	val = &state->tx_tuna[0];
-
-	val[8] &= ~0x80;
-
 	switch (inversion) {
-	case INVERSION_OFF:
-		break;
-	case INVERSION_ON:
-		val[8] |= 0x80;
-		break;
-	default:
-		return -EINVAL;
+		case INVERSION_OFF:	// Inversion = Normal
+			state->tx_tuna[8] &= ~0x80;
+			break;
+
+		case INVERSION_ON:
+			state->tx_tuna[8] |= 0x80;
+			break;
+		default:
+			return -EINVAL;
 	}
 	return 0;
 }
@@ -478,6 +488,52 @@ static int dst_set_symbolrate(struct dst
 	return 0;
 }
 
+
+static int dst_set_modulation(struct dst_state *state, fe_modulation_t modulation)
+{
+	if (state->dst_type != DST_TYPE_IS_CABLE)
+		return 0;
+
+	state->modulation = modulation;
+	switch (modulation) {
+		case QAM_16:
+			state->tx_tuna[8] = 0x10;
+			break;
+
+		case QAM_32:
+			state->tx_tuna[8] = 0x20;
+			break;
+
+		case QAM_64:
+			state->tx_tuna[8] = 0x40;
+			break;
+
+		case QAM_128:
+			state->tx_tuna[8] = 0x80;
+			break;
+
+		case QAM_256:
+			state->tx_tuna[8] = 0x00;
+			break;
+
+		case QPSK:
+		case QAM_AUTO:
+		case VSB_8:
+		case VSB_16:
+		default:
+			return -EINVAL;
+
+	}
+
+	return 0;
+}
+
+static fe_modulation_t dst_get_modulation(struct dst_state *state)
+{
+	return state->modulation;
+}
+
+
 u8 dst_check_sum(u8 * buf, u32 len)
 {
 	u32 i;
@@ -577,7 +633,7 @@ struct dst_types dst_tlist[] = {
 		.device_id = "200103A",
 		.offset = 0,
 		.dst_type =  DST_TYPE_IS_SAT,
-		.type_flags = DST_TYPE_HAS_SYMDIV | DST_TYPE_HAS_FW_1,
+		.type_flags = DST_TYPE_HAS_SYMDIV | DST_TYPE_HAS_FW_1 | DST_TYPE_HAS_OBS_REGS,
 		.dst_feature = 0
 	},	/*	obsolete	*/
 
@@ -626,7 +682,7 @@ struct dst_types dst_tlist[] = {
 		.device_id = "DSTMCI",
 		.offset = 1,
 		.dst_type = DST_TYPE_IS_SAT,
-		.type_flags = DST_TYPE_HAS_NEWTUNE | DST_TYPE_HAS_FW_2 | DST_TYPE_HAS_FW_BUILD,
+		.type_flags = DST_TYPE_HAS_NEWTUNE | DST_TYPE_HAS_FW_2 | DST_TYPE_HAS_FW_BUILD | DST_TYPE_HAS_INC_COUNT,
 		.dst_feature = DST_TYPE_HAS_CA | DST_TYPE_HAS_DISEQC3 | DST_TYPE_HAS_DISEQC4
 							| DST_TYPE_HAS_MOTO | DST_TYPE_HAS_MAC
 	},
@@ -872,7 +928,7 @@ static int dst_get_signal(struct dst_sta
 {
 	int retval;
 	u8 get_signal[] = { 0x00, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0xfb };
-
+	printk("%s: Getting Signal strength and other parameters !!!!!!!!\n", __FUNCTION__);
 	if ((state->diseq_flags & ATTEMPT_TUNE) == 0) {
 		state->decode_lock = state->decode_strength = state->decode_snr = 0;
 		return 0;
@@ -954,15 +1010,8 @@ static int dst_get_tuna(struct dst_state
 	state->decode_freq = ((state->rx_tuna[2] & 0x7f) << 8) + state->rx_tuna[3];
 
 	state->decode_lock = 1;
-	/*
-	   dst->decode_n1 = (dst->rx_tuna[4] << 8) +
-	   (dst->rx_tuna[5]);
-
-	   dst->decode_n2 = (dst->rx_tuna[8] << 8) +
-	   (dst->rx_tuna[7]);
-	 */
 	state->diseq_flags |= HAS_LOCK;
-	/* dst->cur_jiff = jiffies; */
+
 	return 1;
 }
 
@@ -1145,7 +1194,8 @@ static int dst_init(struct dvb_frontend*
 	static u8 ini_tvci_tuna[] = { 9, 0, 3, 0xb6, 1, 7, 0x0, 0x0, 0, 0 };
 	static u8 ini_cabfta_tuna[] = { 0, 0, 3, 0xb6, 1, 7, 0x0, 0x0, 0, 0 };
 	static u8 ini_cabci_tuna[] = { 9, 0, 3, 0xb6, 1, 7, 0x0, 0x0, 0, 0 };
-	state->inversion = INVERSION_ON;
+//	state->inversion = INVERSION_ON;
+	state->inversion = INVERSION_OFF;
 	state->voltage = SEC_VOLTAGE_13;
 	state->tone = SEC_TONE_OFF;
 	state->symbol_rate = 29473000;
@@ -1174,7 +1224,7 @@ static int dst_read_status(struct dvb_fr
 
 	*status = 0;
 	if (state->diseq_flags & HAS_LOCK) {
-		dst_get_signal(state);
+//		dst_get_signal(state);	// don't require(?) to ask MCU
 		if (state->decode_lock)
 			*status |= FE_HAS_LOCK | FE_HAS_SIGNAL | FE_HAS_CARRIER | FE_HAS_SYNC | FE_HAS_VITERBI;
 	}
@@ -1208,20 +1258,25 @@ static int dst_set_frontend(struct dvb_f
 
 	dst_set_freq(state, p->frequency);
 	if (verbose > 4)
-		dprintk("Set Frequency = [%d]\n", p->frequency);
+		dprintk("Set Frequency=[%d]\n", p->frequency);
 
-	dst_set_inversion(state, p->inversion);
+//	dst_set_inversion(state, p->inversion);
 	if (state->dst_type == DST_TYPE_IS_SAT) {
+		if (state->type_flags & DST_TYPE_HAS_OBS_REGS)
+			dst_set_inversion(state, p->inversion);
+
 		dst_set_fec(state, p->u.qpsk.fec_inner);
 		dst_set_symbolrate(state, p->u.qpsk.symbol_rate);
+		dst_set_polarization(state);
 		if (verbose > 4)
-			dprintk("Set Symbolrate = [%d]\n", p->u.qpsk.symbol_rate);
+			dprintk("Set Symbolrate=[%d]\n", p->u.qpsk.symbol_rate);
 
 	} else if (state->dst_type == DST_TYPE_IS_TERR) {
 		dst_set_bandwidth(state, p->u.ofdm.bandwidth);
 	} else if (state->dst_type == DST_TYPE_IS_CABLE) {
 		dst_set_fec(state, p->u.qam.fec_inner);
 		dst_set_symbolrate(state, p->u.qam.symbol_rate);
+		dst_set_modulation(state, p->u.qam.modulation);
 	}
 	dst_write_tuna(fe);
 
@@ -1233,8 +1288,11 @@ static int dst_get_frontend(struct dvb_f
 	struct dst_state* state = fe->demodulator_priv;
 
 	p->frequency = state->decode_freq;
-	p->inversion = state->inversion;
+//	p->inversion = state->inversion;
 	if (state->dst_type == DST_TYPE_IS_SAT) {
+		if (state->type_flags & DST_TYPE_HAS_OBS_REGS)
+			p->inversion = state->inversion;
+
 		p->u.qpsk.symbol_rate = state->symbol_rate;
 		p->u.qpsk.fec_inner = dst_get_fec(state);
 	} else if (state->dst_type == DST_TYPE_IS_TERR) {
@@ -1242,7 +1300,8 @@ static int dst_get_frontend(struct dvb_f
 	} else if (state->dst_type == DST_TYPE_IS_CABLE) {
 		p->u.qam.symbol_rate = state->symbol_rate;
 		p->u.qam.fec_inner = dst_get_fec(state);
-		p->u.qam.modulation = QAM_AUTO;
+//		p->u.qam.modulation = QAM_AUTO;
+		p->u.qam.modulation = dst_get_modulation(state);
 	}
 
 	return 0;
Index: linux-2.6.12-git8/drivers/media/dvb/bt8xx/dst_common.h
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/bt8xx/dst_common.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/bt8xx/dst_common.h	2005-06-27 13:24:12.000000000 +0200
@@ -47,6 +47,8 @@
 #define DST_TYPE_HAS_FW_2	16
 #define DST_TYPE_HAS_FW_3	32
 #define DST_TYPE_HAS_FW_BUILD	64
+#define DST_TYPE_HAS_OBS_REGS	128
+#define DST_TYPE_HAS_INC_COUNT	256
 
 /*	Card capability list	*/
 
@@ -110,6 +112,7 @@ struct dst_state {
 	u32 dst_hw_cap;
 	u8 dst_fw_version;
 	fe_sec_mini_cmd_t minicmd;
+	fe_modulation_t modulation;
 	u8 messages[256];
 };
 
Index: linux-2.6.12-git8/drivers/media/dvb/bt8xx/dst_ca.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/bt8xx/dst_ca.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/bt8xx/dst_ca.c	2005-06-27 13:24:12.000000000 +0200
@@ -32,7 +32,7 @@
 #include "dst_ca.h"
 #include "dst_common.h"
 
-static unsigned int verbose = 1;
+static unsigned int verbose = 5;
 module_param(verbose, int, 0644);
 MODULE_PARM_DESC(verbose, "verbose startup messages, default is 1 (yes)");
 
@@ -295,34 +295,28 @@ static int ca_get_message(struct dst_sta
 	return 0;
 }
 
-static int handle_en50221_tag(struct dst_state *state, struct ca_msg *p_ca_message, struct ca_msg *hw_buffer)
+static int handle_dst_tag(struct dst_state *state, struct ca_msg *p_ca_message, struct ca_msg *hw_buffer, u32 length)
 {
 	if (state->dst_hw_cap & DST_TYPE_HAS_SESSION) {
 		hw_buffer->msg[2] = p_ca_message->msg[1];		/*		MSB			*/
 		hw_buffer->msg[3] = p_ca_message->msg[2];		/*		LSB			*/
 	}
 	else {
+		hw_buffer->msg[0] = (length & 0xff) + 7;
+		hw_buffer->msg[1] = 0x40;
 		hw_buffer->msg[2] = 0x03;
 		hw_buffer->msg[3] = 0x00;
+		hw_buffer->msg[4] = 0x03;
+		hw_buffer->msg[5] = length & 0xff;
+		hw_buffer->msg[6] = 0x00;
 	}
 	return 0;
 }
 
-static int debug_8820_buffer(struct ca_msg *hw_buffer)
-{
-	unsigned int i;
-
-	dprintk("%s:Debug=[", __FUNCTION__);
-	for (i = 0; i < (hw_buffer->msg[0] + 1); i++)
-		dprintk(" %02x", hw_buffer->msg[i]);
-	dprintk("]\n");
 
-	return 0;
-}
-
-static int write_to_8820(struct dst_state *state, struct ca_msg *hw_buffer, u8 reply)
+static int write_to_8820(struct dst_state *state, struct ca_msg *hw_buffer, u8 length, u8 reply)
 {
-	if ((dst_put_ci(state, hw_buffer->msg, (hw_buffer->length + 1), hw_buffer->msg, reply)) < 0) {
+	if ((dst_put_ci(state, hw_buffer->msg, length, hw_buffer->msg, reply)) < 0) {
 		dprintk("%s: DST-CI Command failed.\n", __FUNCTION__);
 		dprintk("%s: Resetting DST.\n", __FUNCTION__);
 		rdc_reset_state(state);
@@ -334,234 +328,141 @@ static int write_to_8820(struct dst_stat
 	return 0;
 }
 
-
-static int ca_set_pmt(struct dst_state *state, struct ca_msg *p_ca_message, struct ca_msg *hw_buffer, u8 reply, u8 query)
+u32 asn_1_decode(u8 *asn_1_array)
 {
-	u32 hw_offset, buf_offset, i, k;
-	u32 program_info_length = 0, es_info_length = 0, length = 0, words = 0;
-	u8 found_prog_ca_desc = 0, found_stream_ca_desc = 0, error_condition = 0, hw_buffer_length = 0;
-
-	if (verbose > 3)
-		dprintk("%s, p_ca_message length %d (0x%x)\n", __FUNCTION__,p_ca_message->length,p_ca_message->length );
-
-	handle_en50221_tag(state, p_ca_message, hw_buffer);			/*	EN50221 tag		*/
+	u8 length_field = 0, word_count = 0, count = 0;
+	u32 length = 0;
 
-	/*	Handle the length field (variable)	*/
-	if (!(p_ca_message->msg[3] & 0x80)) {				/*	Length = 1		*/
-		length = p_ca_message->msg[3] & 0x7f;
-		words = 0;						/*	domi's suggestion	*/
-	}
-	else {								/*	Length = words		*/
-		words = p_ca_message->msg[3] & 0x7f;
-		for (i = 0; i < words; i++) {
-			length = length << 8;
-			length = length | p_ca_message->msg[4 + i];
+	length_field = asn_1_array[0];
+	dprintk("%s: Length field=[%02x]\n", __FUNCTION__, length_field);
+	if (length_field < 0x80) {
+		length = length_field & 0x7f;
+		dprintk("%s: Length=[%02x]\n", __FUNCTION__, length);
+	} else {
+		word_count = length_field & 0x7f;
+		for (count = 0; count < word_count; count++) {
+			length = (length | asn_1_array[count + 1]) << 8;
+			dprintk("%s: Length=[%04x]\n", __FUNCTION__, length);
 		}
 	}
-	if (verbose > 4) {
-		dprintk("%s:Length=[%d (0x%x)], Words=[%d]\n", __FUNCTION__, length,length, words);
+	return length;
+}
 
-		/*	Debug Input string		*/
-		for (i = 0; i < length; i++)
-			dprintk(" %02x", p_ca_message->msg[i]);
-		dprintk("]\n");
-	}
+static int init_buffer(u8 *buffer, u32 length)
+{
+	u32 i;
+	for (i = 0; i < length; i++)
+		buffer[i] = 0;
 
-	hw_offset = 7;
-	buf_offset = words + 4;
+	return 0;
+}
 
-	/*		Program Header			*/
-	if (verbose > 4)
-		dprintk("\n%s:Program Header=[", __FUNCTION__);
-	for (i = 0; i < 6; i++) {
-		hw_buffer->msg[hw_offset] = p_ca_message->msg[buf_offset];
-		if (verbose > 4)
-			dprintk(" %02x", p_ca_message->msg[buf_offset]);
-		hw_offset++, buf_offset++, hw_buffer_length++;
-	}
-	if (verbose > 4)
-		dprintk("]\n");
+static int debug_string(u8 *msg, u32 length, u32 offset)
+{
+	u32 i;
 
-	program_info_length = 0;
-	program_info_length = (((program_info_length | p_ca_message->msg[words + 8]) & 0x0f) << 8) | p_ca_message->msg[words + 9];
-	if (verbose > 4)
-		dprintk("%s:Program info Length=[%d][%02x], hw_offset=[%d], buf_offset=[%d] \n",
-			__FUNCTION__, program_info_length, program_info_length, hw_offset, buf_offset);
+	dprintk(" String=[ ");
+	for (i = offset; i < length; i++)
+		dprintk("%02x ", msg[i]);
+	dprintk("]\n");
 
-	if (program_info_length && (program_info_length < 256)) {	/*	If program_info_length		*/
-		hw_buffer->msg[11] = hw_buffer->msg[11] & 0x0f;		/*	req only 4 bits			*/
-		hw_buffer->msg[12] = hw_buffer->msg[12] + 1;		/*	increment! ASIC bug!		*/
-
-		if (p_ca_message->msg[buf_offset + 1] == 0x09) {	/*	Check CA descriptor		*/
-			found_prog_ca_desc = 1;
-			if (verbose > 4)
-				dprintk("%s: Found CA descriptor @ Program level\n", __FUNCTION__);
-		}
-
-		if (found_prog_ca_desc) {				/*	Command only if CA descriptor	*/
-			hw_buffer->msg[13] = p_ca_message->msg[buf_offset];	/*	CA PMT command ID	*/
-			hw_offset++, buf_offset++, hw_buffer_length++;
-		}
-
-		/*			Program descriptors				*/
-		if (verbose > 4) {
-			dprintk("%s:**********>buf_offset=[%d], hw_offset=[%d]\n", __FUNCTION__, buf_offset, hw_offset);
-			dprintk("%s:Program descriptors=[", __FUNCTION__);
-		}
-		while (program_info_length && !error_condition) {		/*	Copy prog descriptors	*/
-			if (program_info_length > p_ca_message->length) {	/*	Error situation		*/
-				dprintk ("%s:\"WARNING\" Length error, line=[%d], prog_info_length=[%d]\n",
-								__FUNCTION__, __LINE__, program_info_length);
-				dprintk("%s:\"WARNING\" Bailing out of possible loop\n", __FUNCTION__);
-				error_condition = 1;
-				break;
-			}
+	return 0;
+}
 
-			hw_buffer->msg[hw_offset] = p_ca_message->msg[buf_offset];
-			dprintk(" %02x", p_ca_message->msg[buf_offset]);
-			hw_offset++, buf_offset++, hw_buffer_length++, program_info_length--;
-		}
-		if (verbose > 4) {
-			dprintk("]\n");
-			dprintk("%s:**********>buf_offset=[%d], hw_offset=[%d]\n", __FUNCTION__, buf_offset, hw_offset);
-		}
-		if (found_prog_ca_desc) {
-			if (!reply) {
-				hw_buffer->msg[13] = 0x01;		/*	OK descrambling			*/
-				if (verbose > 1)
-					dprintk("CA PMT Command = OK Descrambling\n");
-			}
-			else {
-				hw_buffer->msg[13] = 0x02;		/*	Ok MMI				*/
-				if (verbose > 1)
-					dprintk("CA PMT Command = Ok MMI\n");
-			}
-			if (query) {
-				hw_buffer->msg[13] = 0x03;		/*	Query				*/
-				if (verbose > 1)
-					dprintk("CA PMT Command = CA PMT query\n");
-			}
-		}
-	}
-	else {
-		hw_buffer->msg[11] = hw_buffer->msg[11] & 0xf0;		/*	Don't write to ASIC		*/
-		hw_buffer->msg[12] = hw_buffer->msg[12] = 0x00;
+static int copy_string(u8 *destination, u8 *source, u32 dest_offset, u32 source_offset, u32 length)
+{
+	u32 i;
+	dprintk("%s: Copying [", __FUNCTION__);
+	for (i = 0; i < length; i++) {
+		destination[i + dest_offset] = source[i + source_offset];
+		dprintk(" %02x", source[i + source_offset]);
 	}
-	if (verbose > 4)
-		dprintk("%s:**********>p_ca_message->length=[%d], buf_offset=[%d], hw_offset=[%d]\n",
-					__FUNCTION__, p_ca_message->length, buf_offset, hw_offset);
-
-	while ((buf_offset  < p_ca_message->length)  && !error_condition) {
-		/*	Bail out in case of an indefinite loop		*/
-		if ((es_info_length > p_ca_message->length) || (buf_offset > p_ca_message->length)) {
-			dprintk("%s:\"WARNING\" Length error, line=[%d], prog_info_length=[%d], buf_offset=[%d]\n",
-							__FUNCTION__, __LINE__, program_info_length, buf_offset);
-
-			dprintk("%s:\"WARNING\" Bailing out of possible loop\n", __FUNCTION__);
-			error_condition = 1;
-			break;
-		}
-
-		/*		Stream Header				*/
-
-		for (k = 0; k < 5; k++) {
-			hw_buffer->msg[hw_offset + k] = p_ca_message->msg[buf_offset + k];
-		}
-
-		es_info_length = 0;
-		es_info_length = (es_info_length | (p_ca_message->msg[buf_offset + 3] & 0x0f)) << 8 | p_ca_message->msg[buf_offset + 4];
-
-		if (verbose > 4) {
-			dprintk("\n%s:----->Stream header=[%02x %02x %02x %02x %02x]\n", __FUNCTION__,
-				p_ca_message->msg[buf_offset + 0], p_ca_message->msg[buf_offset + 1],
-				p_ca_message->msg[buf_offset + 2], p_ca_message->msg[buf_offset + 3],
-				p_ca_message->msg[buf_offset + 4]);
-
-			dprintk("%s:----->Stream type=[%02x], es length=[%d (0x%x)], Chars=[%02x] [%02x], buf_offset=[%d]\n", __FUNCTION__,
-				p_ca_message->msg[buf_offset + 0], es_info_length, es_info_length,
-				p_ca_message->msg[buf_offset + 3], p_ca_message->msg[buf_offset + 4], buf_offset);
-		}
-
-		hw_buffer->msg[hw_offset + 3] &= 0x0f;			/*	req only 4 bits			*/
+	dprintk("]\n");
 
-		if (found_prog_ca_desc) {
-			hw_buffer->msg[hw_offset + 3] = 0x00;
-			hw_buffer->msg[hw_offset + 4] = 0x00;
-		}
+	return i;
+}
 
-		hw_offset += 5, buf_offset += 5, hw_buffer_length += 5;
+static int modify_4_bits(u8 *message, u32 pos)
+{
+	message[pos] &= 0x0f;
 
-		/*		Check for CA descriptor			*/
-		if (p_ca_message->msg[buf_offset + 1] == 0x09) {
-			if (verbose > 4)
-				dprintk("%s:Found CA descriptor @ Stream level\n", __FUNCTION__);
-			found_stream_ca_desc = 1;
-		}
+	return 0;
+}
 
-		/*		ES descriptors				*/
 
-		if (es_info_length && !error_condition && !found_prog_ca_desc && found_stream_ca_desc) {
-//			if (!ca_pmt_done) {
-				hw_buffer->msg[hw_offset] = p_ca_message->msg[buf_offset];	/*	CA PMT cmd(es)	*/
-				if (verbose > 4)
-					printk("%s:----->CA PMT Command ID=[%02x]\n", __FUNCTION__, p_ca_message->msg[buf_offset]);
-//				hw_offset++, buf_offset++, hw_buffer_length++, es_info_length--, ca_pmt_done = 1;
-				hw_offset++, buf_offset++, hw_buffer_length++, es_info_length--;
-//			}
-			if (verbose > 4)
-				dprintk("%s:----->ES descriptors=[", __FUNCTION__);
 
-			while (es_info_length && !error_condition) {	/*	ES descriptors			*/
-				if ((es_info_length > p_ca_message->length) || (buf_offset > p_ca_message->length)) {
-					if (verbose > 4) {
-						dprintk("%s:\"WARNING\" ES Length error, line=[%d], es_info_length=[%d], buf_offset=[%d]\n",
-										__FUNCTION__, __LINE__, es_info_length, buf_offset);
+static int ca_set_pmt(struct dst_state *state, struct ca_msg *p_ca_message, struct ca_msg *hw_buffer, u8 reply, u8 query)
+{
+	u32 length = 0, count = 0;
+	u8 asn_1_words, program_header_length;
+	u16 program_info_length = 0, es_info_length = 0;
+	u32 hw_offset = 0, buf_offset = 0, i;
+	u8 dst_tag_length;
+
+	length = asn_1_decode(&p_ca_message->msg[3]);
+	dprintk("%s: CA Message length=[%d]\n", __FUNCTION__, length);
+	dprintk("%s: ASN.1 ", __FUNCTION__);
+	debug_string(&p_ca_message->msg[4], length, 0); // length does not include tag and length
 
-						dprintk("%s:\"WARNING\" Bailing out of possible loop\n", __FUNCTION__);
-					}
-					error_condition = 1;
-					break;
-				}
+	init_buffer(hw_buffer->msg, length);
+	handle_dst_tag(state, p_ca_message, hw_buffer, length);
 
-				hw_buffer->msg[hw_offset] = p_ca_message->msg[buf_offset];
-				if (verbose > 3)
-					dprintk("%02x ", hw_buffer->msg[hw_offset]);
-				hw_offset++, buf_offset++, hw_buffer_length++, es_info_length--;
-			}
-			found_stream_ca_desc = 0;			/*	unset for new streams		*/
-			dprintk("]\n");
+	hw_offset = 7;
+	asn_1_words = 1; // just a hack to test, should compute this one
+	buf_offset = 3;
+	program_header_length = 6;
+	dst_tag_length = 7;
+
+//	debug_twinhan_ca_params(state, p_ca_message, hw_buffer, reply, query, length, hw_offset, buf_offset);
+//	dprintk("%s: Program Header(BUF)", __FUNCTION__);
+//	debug_string(&p_ca_message->msg[4], program_header_length, 0);
+//	dprintk("%s: Copying Program header\n", __FUNCTION__);
+	copy_string(hw_buffer->msg, p_ca_message->msg, hw_offset, (buf_offset + asn_1_words), program_header_length);
+	buf_offset += program_header_length, hw_offset += program_header_length;
+	modify_4_bits(hw_buffer->msg, (hw_offset - 2));
+	if (state->type_flags & DST_TYPE_HAS_INC_COUNT) {	// workaround
+		dprintk("%s: Probably an ASIC bug !!!\n", __FUNCTION__);
+		debug_string(hw_buffer->msg, (hw_offset + program_header_length), 0);
+		hw_buffer->msg[hw_offset - 1] += 1;
+	}
+
+//	dprintk("%s: Program Header(HW), Count=[%d]", __FUNCTION__, count);
+//	debug_string(hw_buffer->msg, hw_offset, 0);
+
+	program_info_length =  ((program_info_length | (p_ca_message->msg[buf_offset - 1] & 0x0f)) << 8) | p_ca_message->msg[buf_offset];
+	dprintk("%s: Program info length=[%02x]\n", __FUNCTION__, program_info_length);
+	if (program_info_length) {
+		count = copy_string(hw_buffer->msg, p_ca_message->msg, hw_offset, (buf_offset + 1), (program_info_length + 1) ); // copy next elem, not current
+		buf_offset += count, hw_offset += count;
+//		dprintk("%s: Program level ", __FUNCTION__);
+//		debug_string(hw_buffer->msg, hw_offset, 0);
+	}
+
+	buf_offset += 1;// hw_offset += 1;
+	for (i = buf_offset; i < length; i++) {
+//		dprintk("%s: Stream Header ", __FUNCTION__);
+		count = copy_string(hw_buffer->msg, p_ca_message->msg, hw_offset, buf_offset, 5);
+		modify_4_bits(hw_buffer->msg, (hw_offset + 3));
+
+		hw_offset += 5, buf_offset += 5, i += 4;
+//		debug_string(hw_buffer->msg, hw_offset, (hw_offset - 5));
+		es_info_length = ((es_info_length | (p_ca_message->msg[buf_offset - 1] & 0x0f)) << 8) | p_ca_message->msg[buf_offset];
+		dprintk("%s: ES info length=[%02x]\n", __FUNCTION__, es_info_length);
+		if (es_info_length) {
+			// copy descriptors @ STREAM level
+			dprintk("%s: Descriptors @ STREAM level...!!! \n", __FUNCTION__);
 		}
-	}
-
-	/*		MCU Magic words					*/
-
-	hw_buffer_length += 7;
-	hw_buffer->msg[0] = hw_buffer_length;
-	hw_buffer->msg[1] = 64;
-	hw_buffer->msg[4] = 3;
-	hw_buffer->msg[5] = hw_buffer->msg[0] - 7;
-	hw_buffer->msg[6] = 0;
-
 
-	/*      Fix length      */
-	hw_buffer->length = hw_buffer->msg[0];
-
-	put_checksum(&hw_buffer->msg[0], hw_buffer->msg[0]);
-	/*      Do the actual write     */
-	if (verbose > 4) {
-		dprintk("%s:======================DEBUGGING================================\n", __FUNCTION__);
-		dprintk("%s: Actual Length=[%d]\n", __FUNCTION__, hw_buffer_length);
 	}
-	/*      Only for debugging!     */
-	if (verbose > 2)
-		debug_8820_buffer(hw_buffer);
-	if (verbose > 3)
-		dprintk("%s: Reply = [%d]\n", __FUNCTION__, reply);
-	write_to_8820(state, hw_buffer, reply);
+	hw_buffer->msg[length + dst_tag_length] = dst_check_sum(hw_buffer->msg, (length + dst_tag_length));
+//	dprintk("%s: Total length=[%d], Checksum=[%02x]\n", __FUNCTION__, (length + dst_tag_length), hw_buffer->msg[length + dst_tag_length]);
+	debug_string(hw_buffer->msg, (length + dst_tag_length + 1), 0);	// dst tags also
+	write_to_8820(state, hw_buffer, (length + dst_tag_length + 1), reply);	// checksum
 
 	return 0;
 }
 
+
 /*	Board supports CA PMT reply ?		*/
 static int dst_check_ca_pmt(struct dst_state *state, struct ca_msg *p_ca_message, struct ca_msg *hw_buffer)
 {
@@ -605,7 +506,7 @@ static int ca_send_message(struct dst_st
 	struct ca_msg *hw_buffer;
 
 	if ((hw_buffer = (struct ca_msg *) kmalloc(sizeof (struct ca_msg), GFP_KERNEL)) == NULL) {
-		printk("%s: Memory allocation failure\n", __FUNCTION__);
+		dprintk("%s: Memory allocation failure\n", __FUNCTION__);
 		return -ENOMEM;
 	}
 	if (verbose > 3)
@@ -630,8 +531,10 @@ static int ca_send_message(struct dst_st
 		switch (command) {
 			case CA_PMT:
 				if (verbose > 3)
+//					dprintk("Command = SEND_CA_PMT\n");
 					dprintk("Command = SEND_CA_PMT\n");
-				if ((ca_set_pmt(state, p_ca_message, hw_buffer, 0, 0)) < 0) {
+//				if ((ca_set_pmt(state, p_ca_message, hw_buffer, 0, 0)) < 0) {
+				if ((ca_set_pmt(state, p_ca_message, hw_buffer, 0, 0)) < 0) {	// code simplification started
 					dprintk("%s: -->CA_PMT Failed !\n", __FUNCTION__);
 					return -1;
 				}
@@ -664,7 +567,7 @@ static int ca_send_message(struct dst_st
 					return -1;
 				}
 				if (verbose > 3)
-					printk("%s: -->CA_APP_INFO_ENQUIRY Success !\n", __FUNCTION__);
+					dprintk("%s: -->CA_APP_INFO_ENQUIRY Success !\n", __FUNCTION__);
 
 				break;
 		}
@@ -681,17 +584,17 @@ static int dst_ca_ioctl(struct inode *in
 	struct ca_msg *p_ca_message;
 
 	if ((p_ca_message = (struct ca_msg *) kmalloc(sizeof (struct ca_msg), GFP_KERNEL)) == NULL) {
-		printk("%s: Memory allocation failure\n", __FUNCTION__);
+		dprintk("%s: Memory allocation failure\n", __FUNCTION__);
 		return -ENOMEM;
 	}
 
 	if ((p_ca_slot_info = (struct ca_slot_info *) kmalloc(sizeof (struct ca_slot_info), GFP_KERNEL)) == NULL) {
-		printk("%s: Memory allocation failure\n", __FUNCTION__);
+		dprintk("%s: Memory allocation failure\n", __FUNCTION__);
 		return -ENOMEM;
 	}
 
 	if ((p_ca_caps = (struct ca_caps *) kmalloc(sizeof (struct ca_caps), GFP_KERNEL)) == NULL) {
-		printk("%s: Memory allocation failure\n", __FUNCTION__);
+		dprintk("%s: Memory allocation failure\n", __FUNCTION__);
 		return -ENOMEM;
 	}
 

--

