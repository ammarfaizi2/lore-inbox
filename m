Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261727AbVEZUkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbVEZUkX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 16:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbVEZUkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 16:40:23 -0400
Received: from penta.pentaserver.com ([216.74.97.66]:33446 "EHLO
	penta.pentaserver.com") by vger.kernel.org with ESMTP
	id S261727AbVEZUkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 16:40:00 -0400
Message-ID: <429632DF.6080007@kromtek.com>
Date: Fri, 27 May 2005 00:34:39 +0400
From: Manu Abraham <manu@kromtek.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Johannes Stezenbach <js@linuxtv.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] Fix Mini DiSEqC bug
Content-Type: multipart/mixed;
 boundary="------------080203060406010106030606"
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
--------------080203060406010106030606
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

o Fix bug in Mini DiSEqC code

The bug was visible as a warning with gcc-3.4.4 (prerelease)

Message:
drivers/media/dvb/bt8xx/dst.c:1349: warning: initialization from
incompatible pointer type.

Signed-off-by: Manu Abraham <manu@kromtek.com>

dst.c |   31 ++++++++++++++++++++++++++-----
       1 files changed, 26 insertions(+), 5 deletions(-)








--------------080203060406010106030606
Content-Type: text/x-patch;
 name="fix-compiler-warning.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-compiler-warning.diff"

--- linux-2.6.12-rc5.orig/drivers/media/dvb/bt8xx/dst.c	2005-05-03 20:10:56.000000000 +0400
+++ linux-2.6.12-rc5/drivers/media/dvb/bt8xx/dst.c	2005-05-26 10:36:37.000000000 +0400
@@ -915,13 +915,11 @@ static int dst_tone_power_cmd(struct dst
 		paket[2] = 0x02;
 	else
 		paket[2] = 0;
-	if (state->minicmd == SEC_MINI_A)
-		paket[3] = 0x02;
-	else
-		paket[3] = 0;
 
+	paket[3] = state->tx_tuna[3];
 	paket[7] = dst_check_sum (paket, 7);
 	dst_command(state, paket, 8);
+
 	return 0;
 }
 
@@ -1134,6 +1132,29 @@ static int dst_set_tone(struct dvb_front
 	return 0;
 }
 
+static int dst_send_burst(struct dvb_frontend *fe, fe_sec_mini_cmd_t minicmd)
+{
+	struct dst_state *state = fe->demodulator_priv;
+
+	if ((state->dst_type == DST_TYPE_IS_TERR) || (state->dst_type == DST_TYPE_IS_CABLE))
+		return 0;
+
+	state->minicmd = minicmd;
+
+	switch (minicmd) {
+		case SEC_MINI_A:
+			state->tx_tuna[3] = 0x02;
+			break;
+		case SEC_MINI_B:
+			state->tx_tuna[3] = 0xff;
+			break;
+	}
+	dst_tone_power_cmd(state);
+
+	return 0;
+}
+
+
 static int dst_init(struct dvb_frontend* fe)
 {
 	struct dst_state* state = (struct dst_state*) fe->demodulator_priv;
@@ -1346,7 +1367,7 @@ static struct dvb_frontend_ops dst_dvbs_
 	.read_signal_strength = dst_read_signal_strength,
 	.read_snr = dst_read_snr,
 
-	.diseqc_send_burst = dst_set_tone,
+	.diseqc_send_burst = dst_send_burst,
 	.diseqc_send_master_cmd = dst_set_diseqc,
 	.set_voltage = dst_set_voltage,
 	.set_tone = dst_set_tone,






--------------080203060406010106030606--
