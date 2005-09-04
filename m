Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbVIDXmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbVIDXmR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbVIDXmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:42:14 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:50049 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932106AbVIDXax
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:30:53 -0400
Message-Id: <20050904232330.449553000@abc>
References: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:23:36 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Manu Abraham <manu@kromtek.com>
Content-Disposition: inline; filename=dvb-bt8xx-dst-make-symbolrate-card-specifc.patch
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 37/54] dst: fix symbol rate setting
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manu Abraham <manu@kromtek.com>

Make the Symbolrate setting card specific.

Signed-off-by: Manu Abraham <manu@kromtek.com>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/bt8xx/dst.c |   30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

--- linux-2.6.13-git4.orig/drivers/media/dvb/bt8xx/dst.c	2005-09-04 22:28:26.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/bt8xx/dst.c	2005-09-04 22:28:32.000000000 +0200
@@ -324,12 +324,12 @@ static int dst_set_polarization(struct d
 {
 	switch (state->voltage) {
 		case SEC_VOLTAGE_13:	// vertical
-			printk("%s: Polarization=[Vertical]\n", __FUNCTION__);
+			dprintk("%s: Polarization=[Vertical]\n", __FUNCTION__);
 			state->tx_tuna[8] &= ~0x40;  //1
 			break;
 
 		case SEC_VOLTAGE_18:	// horizontal
-			printk("%s: Polarization=[Horizontal]\n", __FUNCTION__);
+			dprintk("%s: Polarization=[Horizontal]\n", __FUNCTION__);
 			state->tx_tuna[8] |= 0x40;  // 0
 			break;
 
@@ -344,7 +344,7 @@ static int dst_set_polarization(struct d
 static int dst_set_freq(struct dst_state *state, u32 freq)
 {
 	state->frequency = freq;
-	if (debug > 4)
+	if (verbose > 4)
 		dprintk("%s: set Frequency %u\n", __FUNCTION__, freq);
 
 	if (state->dst_type == DST_TYPE_IS_SAT) {
@@ -451,7 +451,6 @@ static fe_code_rate_t dst_get_fec(struct
 
 static int dst_set_symbolrate(struct dst_state* state, u32 srate)
 {
-	u8 *val;
 	u32 symcalc;
 	u64 sval;
 
@@ -463,7 +462,6 @@ static int dst_set_symbolrate(struct dst
 	if (debug > 4)
 		dprintk("%s: set symrate %u\n", __FUNCTION__, srate);
 	srate /= 1000;
-	val = &state->tx_tuna[0];
 
 	if (state->type_flags & DST_TYPE_HAS_SYMDIV) {
 		sval = srate;
@@ -474,17 +472,19 @@ static int dst_set_symbolrate(struct dst
 		if (debug > 4)
 			dprintk("%s: set symcalc %u\n", __FUNCTION__, symcalc);
 
-		val[5] = (u8) (symcalc >> 12);
-		val[6] = (u8) (symcalc >> 4);
-		val[7] = (u8) (symcalc << 4);
+		state->tx_tuna[5] = (u8) (symcalc >> 12);
+		state->tx_tuna[6] = (u8) (symcalc >> 4);
+		state->tx_tuna[7] = (u8) (symcalc << 4);
 	} else {
-		val[5] = (u8) (srate >> 16) & 0x7f;
-		val[6] = (u8) (srate >> 8);
-		val[7] = (u8) srate;
-	}
-	val[8] &= ~0x20;
-	if (srate > 8000)
-		val[8] |= 0x20;
+		state->tx_tuna[5] = (u8) (srate >> 16) & 0x7f;
+		state->tx_tuna[6] = (u8) (srate >> 8);
+		state->tx_tuna[7] = (u8) srate;
+	}
+	state->tx_tuna[8] &= ~0x20;
+	if (state->type_flags & DST_TYPE_HAS_OBS_REGS) {
+		if (srate > 8000)
+			state->tx_tuna[8] |= 0x20;
+	}
 	return 0;
 }
 

--

