Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261742AbVEZUoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbVEZUoA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 16:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbVEZUn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 16:43:58 -0400
Received: from penta.pentaserver.com ([216.74.97.66]:37030 "EHLO
	penta.pentaserver.com") by vger.kernel.org with ESMTP
	id S261735AbVEZUku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 16:40:50 -0400
Message-ID: <42963317.8050801@kromtek.com>
Date: Fri, 27 May 2005 00:35:35 +0400
From: Manu Abraham <manu@kromtek.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Johannes Stezenbach <js@linuxtv.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] Fix 22k tone control
Content-Type: multipart/mixed;
 boundary="------------070106080106000208070009"
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
--------------070106080106000208070009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

o Fix bug in 22k tone control


Signed-off-by: Manu Abraham <manu@kromtek.com>

      dst.c |   27 +++++++++------------------
      1 files changed, 9 insertions(+), 18 deletions(-)





--------------070106080106000208070009
Content-Type: text/x-patch;
 name="fix-22k-tone-control.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-22k-tone-control.diff"

--- linux-2.6.12-rc5.orig/drivers/media/dvb/bt8xx/dst.c	2005-05-26 11:08:42.000000000 +0400
+++ linux-2.6.12-rc5/drivers/media/dvb/bt8xx/dst.c	2005-05-26 11:16:20.000000000 +0400
@@ -907,12 +907,7 @@ static int dst_tone_power_cmd(struct dst
 		return 0;
 
 	paket[4] = state->tx_tuna[4];
-
-	if (state->tone == SEC_TONE_ON)
-		paket[2] = 0x02;
-	else
-		paket[2] = 0;
-
+	paket[2] = state->tx_tuna[2];
 	paket[3] = state->tx_tuna[3];
 	paket[7] = dst_check_sum (paket, 7);
 	dst_command(state, paket, 8);
@@ -1094,7 +1089,6 @@ static int dst_set_voltage(struct dvb_fr
 
 static int dst_set_tone(struct dvb_frontend* fe, fe_sec_tone_mode_t tone)
 {
-	u8 *val;
 	struct dst_state* state = fe->demodulator_priv;
 
 	state->tone = tone;
@@ -1102,20 +1096,17 @@ static int dst_set_tone(struct dvb_front
 	if (state->dst_type == DST_TYPE_IS_TERR)
 		return 0;
 
-	val = &state->tx_tuna[0];
-
-	val[8] &= ~0x1;
-
 	switch (tone) {
-	case SEC_TONE_OFF:
-		break;
+		case SEC_TONE_OFF:
+			state->tx_tuna[2] = 0xff;
+			break;
 
-	case SEC_TONE_ON:
-		val[8] |= 1;
-		break;
+		case SEC_TONE_ON:
+			state->tx_tuna[2] = 0x02;
+			break;
 
-	default:
-		return -EINVAL;
+		default:
+			return -EINVAL;
 	}
 	dst_tone_power_cmd(state);
 





--------------070106080106000208070009--
