Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbVIDXes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbVIDXes (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbVIDXbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:31:05 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:32129 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932114AbVIDXaO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:30:14 -0400
Message-Id: <20050904232321.696901000@abc>
References: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:23:14 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andrew de Quincey <adq_dvb@lidskialf.net>
Content-Disposition: inline; filename=dvb-frontend-stv0299-ber-and-ucb.patch
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 15/54] frontend: stv0299: support reading both BER and UCBLOCKS
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew de Quincey <adq_dvb@lidskialf.net>

Allow the stv0299 to read the BER and UCBLOCKS.

Signed-off-by: Andrew de Quincey <adq_dvb@lidskialf.net>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/frontends/stv0299.c |   13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

--- linux-2.6.13-git4.orig/drivers/media/dvb/frontends/stv0299.c	2005-09-04 22:28:03.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/frontends/stv0299.c	2005-09-04 22:28:05.000000000 +0200
@@ -63,12 +63,8 @@ struct stv0299_state {
 	u32 tuner_frequency;
 	u32 symbol_rate;
 	fe_code_rate_t fec_inner;
-	int errmode;
 };
 
-#define STATUS_BER 0
-#define STATUS_UCBLOCKS 1
-
 static int debug;
 static int debug_legacy_dish_switch;
 #define dprintk(args...) \
@@ -520,7 +516,8 @@ static int stv0299_read_ber(struct dvb_f
 {
         struct stv0299_state* state = fe->demodulator_priv;
 
-	if (state->errmode != STATUS_BER) return 0;
+	stv0299_writeregI(state, 0x34, (stv0299_readreg(state, 0x34) & 0xcf) | 0x10);
+	msleep(100);
 	*ber = (stv0299_readreg (state, 0x1d) << 8) | stv0299_readreg (state, 0x1e);
 
 	return 0;
@@ -559,8 +556,9 @@ static int stv0299_read_ucblocks(struct 
 {
         struct stv0299_state* state = fe->demodulator_priv;
 
-	if (state->errmode != STATUS_UCBLOCKS) *ucblocks = 0;
-	else *ucblocks = (stv0299_readreg (state, 0x1d) << 8) | stv0299_readreg (state, 0x1e);
+	stv0299_writeregI(state, 0x34, (stv0299_readreg(state, 0x34) & 0xcf) | 0x30);
+	msleep(100);
+	*ucblocks = (stv0299_readreg (state, 0x1d) << 8) | stv0299_readreg (state, 0x1e);
 
 	return 0;
 }
@@ -709,7 +707,6 @@ struct dvb_frontend* stv0299_attach(cons
 	state->tuner_frequency = 0;
 	state->symbol_rate = 0;
 	state->fec_inner = 0;
-	state->errmode = STATUS_BER;
 
 	/* check if the demod is there */
 	stv0299_writeregI(state, 0x02, 0x34); /* standby off */

--

