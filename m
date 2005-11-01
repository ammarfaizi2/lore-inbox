Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965080AbVKAIWI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965080AbVKAIWI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 03:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965041AbVKAIPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 03:15:15 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:52391 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S965042AbVKAIPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 03:15:06 -0500
Message-ID: <436723E8.1000300@m1k.net>
Date: Tue, 01 Nov 2005 03:14:32 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
Subject: [PATCH 19/37] dvb: Remove broken stv0299 enhanced tuning code
Content-Type: multipart/mixed;
 boundary="------------000004010709080501070703"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000004010709080501070703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit




--------------000004010709080501070703
Content-Type: text/x-patch;
 name="2388.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2388.patch"

From: Andrew de Quincy <quincy@linuxtv.org>

Remove broken stv0299 enhanced tuning code

Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>

 drivers/media/dvb/b2c2/flexcop-fe-tuner.c         |    1 
 drivers/media/dvb/frontends/stv0299.c             |   53 ++++------------------
 drivers/media/dvb/frontends/stv0299.h             |    3 -
 drivers/media/dvb/ttpci/av7110.c                  |    2 
 drivers/media/dvb/ttpci/budget-av.c               |    2 
 drivers/media/dvb/ttpci/budget-ci.c               |    2 
 drivers/media/dvb/ttpci/budget-patch.c            |    1 
 drivers/media/dvb/ttpci/budget.c                  |    2 
 drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c |    1 
 9 files changed, 10 insertions(+), 57 deletions(-)

--- linux-2.6.14-git3.orig/drivers/media/dvb/b2c2/flexcop-fe-tuner.c
+++ linux-2.6.14-git3/drivers/media/dvb/b2c2/flexcop-fe-tuner.c
@@ -234,7 +234,6 @@
 	.inittab = samsung_tbmu24112_inittab,
 	.mclk = 88000000UL,
 	.invert = 0,
-	.enhanced_tuning = 0,
 	.skip_reinit = 0,
 	.lock_output = STV0229_LOCKOUTPUT_LK,
 	.volt13_op0_op1 = STV0299_VOLT13_OP1,
--- linux-2.6.14-git3.orig/drivers/media/dvb/frontends/stv0299.c
+++ linux-2.6.14-git3/drivers/media/dvb/frontends/stv0299.c
@@ -553,49 +553,16 @@
 	if (state->config->invert) invval = (~invval) & 1;
 	stv0299_writeregI(state, 0x0c, (stv0299_readreg(state, 0x0c) & 0xfe) | invval);
 
-	if (state->config->enhanced_tuning) {
-		/* check if we should do a finetune */
-		int frequency_delta = p->frequency - state->tuner_frequency;
-		int minmax = p->u.qpsk.symbol_rate / 2000;
-		if (minmax < 5000) minmax = 5000;
-
-		if ((frequency_delta > -minmax) && (frequency_delta < minmax) && (frequency_delta != 0) &&
-		    (state->fec_inner == p->u.qpsk.fec_inner) &&
-		    (state->symbol_rate == p->u.qpsk.symbol_rate)) {
-			int Drot_freq = (frequency_delta << 16) / (state->config->mclk / 1000);
-
-			// zap the derotator registers first
-			stv0299_writeregI(state, 0x22, 0x00);
-			stv0299_writeregI(state, 0x23, 0x00);
-
-			// now set them as we want
-			stv0299_writeregI(state, 0x22, Drot_freq >> 8);
-			stv0299_writeregI(state, 0x23, Drot_freq);
-		} else {
-			/* A "normal" tune is requested */
-			stv0299_writeregI(state, 0x05, 0xb5);	/*  enable i2c repeater on stv0299  */
-			state->config->pll_set(fe, state->i2c, p);
-			stv0299_writeregI(state, 0x05, 0x35);	/*  disable i2c repeater on stv0299  */
-
-			stv0299_writeregI(state, 0x32, 0x80);
-			stv0299_writeregI(state, 0x22, 0x00);
-			stv0299_writeregI(state, 0x23, 0x00);
-			stv0299_writeregI(state, 0x32, 0x19);
-			stv0299_set_symbolrate (fe, p->u.qpsk.symbol_rate);
-			stv0299_set_FEC (state, p->u.qpsk.fec_inner);
-		}
-	} else {
-		stv0299_writeregI(state, 0x05, 0xb5);	/*  enable i2c repeater on stv0299  */
-		state->config->pll_set(fe, state->i2c, p);
-		stv0299_writeregI(state, 0x05, 0x35);	/*  disable i2c repeater on stv0299  */
-
-		stv0299_set_FEC (state, p->u.qpsk.fec_inner);
-		stv0299_set_symbolrate (fe, p->u.qpsk.symbol_rate);
-		stv0299_writeregI(state, 0x22, 0x00);
-		stv0299_writeregI(state, 0x23, 0x00);
-		stv0299_readreg (state, 0x23);
-		stv0299_writeregI(state, 0x12, 0xb9);
-	}
+	stv0299_writeregI(state, 0x05, 0xb5);	/*  enable i2c repeater on stv0299  */
+	state->config->pll_set(fe, state->i2c, p);
+	stv0299_writeregI(state, 0x05, 0x35);	/*  disable i2c repeater on stv0299  */
+
+	stv0299_set_FEC (state, p->u.qpsk.fec_inner);
+	stv0299_set_symbolrate (fe, p->u.qpsk.symbol_rate);
+	stv0299_writeregI(state, 0x22, 0x00);
+	stv0299_writeregI(state, 0x23, 0x00);
+	stv0299_readreg (state, 0x23);
+	stv0299_writeregI(state, 0x12, 0xb9);
 
 	state->tuner_frequency = p->frequency;
 	state->fec_inner = p->u.qpsk.fec_inner;
--- linux-2.6.14-git3.orig/drivers/media/dvb/frontends/stv0299.h
+++ linux-2.6.14-git3/drivers/media/dvb/frontends/stv0299.h
@@ -73,9 +73,6 @@
 	/* does the inversion require inversion? */
 	u8 invert:1;
 
-	/* Should the enhanced tuning code be used? */
-	u8 enhanced_tuning:1;
-
 	/* Skip reinitialisation? */
 	u8 skip_reinit:1;
 
--- linux-2.6.14-git3.orig/drivers/media/dvb/ttpci/av7110.c
+++ linux-2.6.14-git3/drivers/media/dvb/ttpci/av7110.c
@@ -1644,7 +1644,6 @@
 	.inittab = alps_bsru6_inittab,
 	.mclk = 88000000UL,
 	.invert = 1,
-	.enhanced_tuning = 0,
 	.skip_reinit = 0,
 	.lock_output = STV0229_LOCKOUTPUT_1,
 	.volt13_op0_op1 = STV0299_VOLT13_OP1,
@@ -1721,7 +1720,6 @@
 	.inittab = alps_bsbe1_inittab,
 	.mclk = 88000000UL,
 	.invert = 1,
-	.enhanced_tuning = 0,
 	.skip_reinit = 0,
 	.min_delay_ms = 100,
 	.set_symbol_rate = alps_bsru6_set_symbol_rate,
--- linux-2.6.14-git3.orig/drivers/media/dvb/ttpci/budget-av.c
+++ linux-2.6.14-git3/drivers/media/dvb/ttpci/budget-av.c
@@ -531,7 +531,6 @@
 	.inittab = typhoon_cinergy1200s_inittab,
 	.mclk = 88000000UL,
 	.invert = 0,
-	.enhanced_tuning = 0,
 	.skip_reinit = 0,
 	.lock_output = STV0229_LOCKOUTPUT_1,
 	.volt13_op0_op1 = STV0299_VOLT13_OP0,
@@ -546,7 +545,6 @@
 	.inittab = typhoon_cinergy1200s_inittab,
 	.mclk = 88000000UL,
 	.invert = 0,
-	.enhanced_tuning = 0,
 	.skip_reinit = 0,
 	.lock_output = STV0229_LOCKOUTPUT_0,
 	.volt13_op0_op1 = STV0299_VOLT13_OP0,
--- linux-2.6.14-git3.orig/drivers/media/dvb/ttpci/budget-ci.c
+++ linux-2.6.14-git3/drivers/media/dvb/ttpci/budget-ci.c
@@ -580,7 +580,6 @@
 	.inittab = alps_bsru6_inittab,
 	.mclk = 88000000UL,
 	.invert = 1,
-	.enhanced_tuning = 0,
 	.skip_reinit = 0,
 	.lock_output = STV0229_LOCKOUTPUT_1,
 	.volt13_op0_op1 = STV0299_VOLT13_OP1,
@@ -710,7 +709,6 @@
 	.inittab = philips_su1278_tt_inittab,
 	.mclk = 64000000UL,
 	.invert = 0,
-	.enhanced_tuning = 1,
 	.skip_reinit = 1,
 	.lock_output = STV0229_LOCKOUTPUT_1,
 	.volt13_op0_op1 = STV0299_VOLT13_OP1,
--- linux-2.6.14-git3.orig/drivers/media/dvb/ttpci/budget-patch.c
+++ linux-2.6.14-git3/drivers/media/dvb/ttpci/budget-patch.c
@@ -379,7 +379,6 @@
 	.inittab = alps_bsru6_inittab,
 	.mclk = 88000000UL,
 	.invert = 1,
-	.enhanced_tuning = 0,
 	.skip_reinit = 0,
 	.lock_output = STV0229_LOCKOUTPUT_1,
 	.volt13_op0_op1 = STV0299_VOLT13_OP1,
--- linux-2.6.14-git3.orig/drivers/media/dvb/ttpci/budget.c
+++ linux-2.6.14-git3/drivers/media/dvb/ttpci/budget.c
@@ -360,7 +360,6 @@
 	.inittab = alps_bsru6_inittab,
 	.mclk = 88000000UL,
 	.invert = 1,
-	.enhanced_tuning = 0,
 	.skip_reinit = 0,
 	.lock_output = STV0229_LOCKOUTPUT_1,
 	.volt13_op0_op1 = STV0299_VOLT13_OP1,
@@ -436,7 +435,6 @@
 	.inittab = alps_bsbe1_inittab,
 	.mclk = 88000000UL,
 	.invert = 1,
-	.enhanced_tuning = 0,
 	.skip_reinit = 0,
 	.min_delay_ms = 100,
 	.set_symbol_rate = alps_bsru6_set_symbol_rate,
--- linux-2.6.14-git3.orig/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c
+++ linux-2.6.14-git3/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c
@@ -1335,7 +1335,6 @@
 	.inittab = alps_bsru6_inittab,
 	.mclk = 88000000UL,
 	.invert = 1,
-	.enhanced_tuning = 0,
 	.skip_reinit = 0,
 	.lock_output = STV0229_LOCKOUTPUT_1,
 	.volt13_op0_op1 = STV0299_VOLT13_OP1,


--------------000004010709080501070703--
