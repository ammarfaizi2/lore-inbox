Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262851AbVEHTQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262851AbVEHTQj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 15:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262838AbVEHTQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 15:16:07 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:59030 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262851AbVEHTJn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 15:09:43 -0400
Message-Id: <20050508184346.803381000@abc>
References: <20050508184229.957247000@abc>
Date: Sun, 08 May 2005 20:42:42 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-fe-nxt6000-status.patch
X-SA-Exim-Connect-IP: 217.231.45.168
Subject: [DVB patch 13/37] nxt6000: support frontend status reads
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

add support for read_ber, read_signal_strength and read_status (Greg Wickham)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
---

 drivers/media/dvb/frontends/nxt6000.c      |   44 ++++++++++++++++++++++++++++-
 drivers/media/dvb/frontends/nxt6000_priv.h |   21 +++++++++++++
 2 files changed, 64 insertions(+), 1 deletion(-)

Index: linux-2.6.12-rc4/drivers/media/dvb/frontends/nxt6000.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/frontends/nxt6000.c	2005-05-08 15:55:38.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/frontends/nxt6000.c	2005-05-08 16:16:25.000000000 +0200
@@ -180,7 +180,12 @@ static void nxt6000_setup(struct dvb_fro
 
 	nxt6000_writereg(state, RS_COR_SYNC_PARAM, SYNC_PARAM);
 	nxt6000_writereg(state, BER_CTRL, /*(1 << 2) | */ (0x01 << 1) | 0x01);
-	nxt6000_writereg(state, VIT_COR_CTL, VIT_COR_RESYNC);
+	nxt6000_writereg(state, VIT_BERTIME_2, 0x00);  // BER Timer = 0x000200 * 256 = 131072 bits
+	nxt6000_writereg(state, VIT_BERTIME_1, 0x02);  //
+	nxt6000_writereg(state, VIT_BERTIME_0, 0x00);  //
+	nxt6000_writereg(state, VIT_COR_INTEN, 0x98); // Enable BER interrupts
+	nxt6000_writereg(state, VIT_COR_CTL, 0x82);   // Enable BER measurement
+	nxt6000_writereg(state, VIT_COR_CTL, VIT_COR_RESYNC | 0x02 );
 	nxt6000_writereg(state, OFDM_COR_CTL, (0x01 << 5) | (nxt6000_readreg(state, OFDM_COR_CTL) & 0x0F));
 	nxt6000_writereg(state, OFDM_COR_MODEGUARD, FORCEMODE8K | 0x02);
 	nxt6000_writereg(state, OFDM_AGC_CTL, AGCLAST | INITIAL_AGC_BW);
@@ -486,6 +491,40 @@ static void nxt6000_release(struct dvb_f
 	kfree(state);
 }
 
+static int nxt6000_read_snr(struct dvb_frontend* fe, u16* snr)
+{
+	struct nxt6000_state* state = (struct nxt6000_state*) fe->demodulator_priv;
+
+	*snr = nxt6000_readreg( state, OFDM_CHC_SNR) / 8;
+
+	return 0;
+}
+
+static int nxt6000_read_ber(struct dvb_frontend* fe, u32* ber)
+{
+	struct nxt6000_state* state = (struct nxt6000_state*) fe->demodulator_priv;
+
+	nxt6000_writereg( state, VIT_COR_INTSTAT, 0x18 );
+
+	*ber = (nxt6000_readreg( state, VIT_BER_1 ) << 8 ) |
+		nxt6000_readreg( state, VIT_BER_0 );
+
+	nxt6000_writereg( state, VIT_COR_INTSTAT, 0x18); // Clear BER Done interrupts
+
+	return 0;
+}
+
+static int nxt6000_read_signal_strength(struct dvb_frontend* fe, u16* signal_strength)
+{
+	struct nxt6000_state* state = (struct nxt6000_state*) fe->demodulator_priv;
+
+	*signal_strength = (short) (511 -
+		(nxt6000_readreg(state, AGC_GAIN_1) +
+		((nxt6000_readreg(state, AGC_GAIN_2) & 0x03) << 8)));
+
+	return 0;
+}
+
 static struct dvb_frontend_ops nxt6000_ops;
 
 struct dvb_frontend* nxt6000_attach(const struct nxt6000_config* config,
@@ -542,6 +581,9 @@ static struct dvb_frontend_ops nxt6000_o
 	.set_frontend = nxt6000_set_frontend,
 
 	.read_status = nxt6000_read_status,
+	.read_ber = nxt6000_read_ber,
+	.read_signal_strength = nxt6000_read_signal_strength,
+	.read_snr = nxt6000_read_snr,
 };
 
 module_param(debug, int, 0644);
Index: linux-2.6.12-rc4/drivers/media/dvb/frontends/nxt6000_priv.h
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/frontends/nxt6000_priv.h	2005-05-08 15:55:38.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/frontends/nxt6000_priv.h	2005-05-08 16:16:25.000000000 +0200
@@ -65,12 +65,27 @@
 #define BER_DONE               (0x08)
 #define BER_OVERFLOW           (0x10)
 
+/* 0x38 VIT_BERTIME_2 */
+#define VIT_BERTIME_2      (0x38)
+
+/* 0x39 VIT_BERTIME_1 */
+#define VIT_BERTIME_1      (0x39)
+
+/* 0x3A VIT_BERTIME_0 */
+#define VIT_BERTIME_0      (0x3a)
+
 			     /* 0x38 OFDM_BERTimer *//* Use the alias registers */
 #define A_VIT_BER_TIMER_0      (0x1D)
 
 			     /* 0x3A VIT_BER_TIMER_0 *//* Use the alias registers */
 #define A_VIT_BER_0            (0x1B)
 
+/* 0x3B VIT_BER_1 */
+#define VIT_BER_1              (0x3b)
+
+/* 0x3C VIT_BER_0 */
+#define VIT_BER_0              (0x3c)
+
 /* 0x40 OFDM_COR_CTL */
 #define OFDM_COR_CTL           (0x40)
 #define COREACT                (0x20)
@@ -117,6 +132,12 @@
 #define OFDM_ITB_CTL           (0x4B)
 #define ITBINV                 (0x01)
 
+/* 0x49 AGC_GAIN_1 */
+#define AGC_GAIN_1             (0x49)
+
+/* 0x4A AGC_GAIN_2 */
+#define AGC_GAIN_2             (0x4A)
+
 /* 0x4C OFDM_ITB_FREQ_1 */
 #define OFDM_ITB_FREQ_1        (0x4C)
 

--

