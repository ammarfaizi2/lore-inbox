Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261750AbVEZVAB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbVEZVAB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 17:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbVEZUmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 16:42:52 -0400
Received: from penta.pentaserver.com ([216.74.97.66]:34982 "EHLO
	penta.pentaserver.com") by vger.kernel.org with ESMTP
	id S261733AbVEZUkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 16:40:32 -0400
Message-ID: <4296330A.9040501@kromtek.com>
Date: Fri, 27 May 2005 00:35:22 +0400
From: Manu Abraham <manu@kromtek.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Johannes Stezenbach <js@linuxtv.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] Fix LNB power switching
Content-Type: multipart/mixed;
 boundary="------------070907030500050403030008"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - penta.pentaserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kromtek.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070907030500050403030008
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

o Fix bug in LNB Power switching

Signed-off-by: Manu Abraham <manu@kromtek.com>

dst.c |   38 ++++++++++++++------------------------
      1 files changed, 14 insertions(+), 24 deletions(-)





--------------070907030500050403030008
Content-Type: text/x-patch;
 name="fix-power-switching.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-power-switching.diff"

--- linux-2.6.12-rc5.orig/drivers/media/dvb/bt8xx/dst.c	2005-05-26 10:41:27.000000000 +0400
+++ linux-2.6.12-rc5/drivers/media/dvb/bt8xx/dst.c	2005-05-26 21:39:55.000000000 +0400
@@ -906,10 +906,7 @@ static int dst_tone_power_cmd(struct dst
 	if (state->dst_type == DST_TYPE_IS_TERR)
 		return 0;
 
-	if (state->voltage == SEC_VOLTAGE_OFF)
-		paket[4] = 0;
-	else
-		paket[4] = 1;
+	paket[4] = state->tx_tuna[4];
 
 	if (state->tone == SEC_TONE_ON)
 		paket[2] = 0x02;
@@ -1062,7 +1059,6 @@ static int dst_set_diseqc(struct dvb_fro
 
 static int dst_set_voltage(struct dvb_frontend* fe, fe_sec_voltage_t voltage)
 {
-	u8 *val;
 	int need_cmd;
 	struct dst_state* state = fe->demodulator_priv;
 
@@ -1072,29 +1068,23 @@ static int dst_set_voltage(struct dvb_fr
 		return 0;
 
 	need_cmd = 0;
-	val = &state->tx_tuna[0];
-	val[8] &= ~0x40;
 	switch (voltage) {
-	case SEC_VOLTAGE_13:
-		if ((state->diseq_flags & HAS_POWER) == 0)
-			need_cmd = 1;
-		state->diseq_flags |= HAS_POWER;
-		break;
+		case SEC_VOLTAGE_13:
+		case SEC_VOLTAGE_18:
+			if ((state->diseq_flags & HAS_POWER) == 0)
+				need_cmd = 1;
+			state->diseq_flags |= HAS_POWER;
+			state->tx_tuna[4] = 0x01;
+			break;
 
-	case SEC_VOLTAGE_18:
-		if ((state->diseq_flags & HAS_POWER) == 0)
+		case SEC_VOLTAGE_OFF:
 			need_cmd = 1;
-		state->diseq_flags |= HAS_POWER;
-		val[8] |= 0x40;
-		break;
-
-	case SEC_VOLTAGE_OFF:
-		need_cmd = 1;
-		state->diseq_flags &= ~(HAS_POWER | HAS_LOCK | ATTEMPT_TUNE);
-		break;
+			state->diseq_flags &= ~(HAS_POWER | HAS_LOCK | ATTEMPT_TUNE);
+			state->tx_tuna[4] = 0x00;
+			break;
 
-	default:
-		return -EINVAL;
+		default:
+			return -EINVAL;
 	}
 	if (need_cmd)
 		dst_tone_power_cmd(state);





--------------070907030500050403030008--
