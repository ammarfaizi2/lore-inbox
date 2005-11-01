Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965088AbVKAIUH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965088AbVKAIUH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 03:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964981AbVKAIQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 03:16:13 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:44871 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S965066AbVKAIPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 03:15:52 -0500
Message-ID: <43672412.3080007@m1k.net>
Date: Tue, 01 Nov 2005 03:15:14 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
Subject: [PATCH 25/37] dvb: dst: protect dst_write_tuna from simultaneous
 writes
Content-Type: multipart/mixed;
 boundary="------------090505050608070002060006"
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
--------------090505050608070002060006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit




--------------090505050608070002060006
Content-Type: text/x-patch;
 name="2399.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2399.patch"

From: Henrik Sjoberg <henke@epact.se>

-dst_write_tuna needs to be protected against simultaeneous writes, just like dst_command

Signed-off-by: Henrik Sjoberg <henke@epact.se>
Signed-off-by: Manu Abraham <manu@linuxtv.org>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>

 drivers/media/dvb/bt8xx/dst.c |   31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

--- linux-2.6.14-git3.orig/drivers/media/dvb/bt8xx/dst.c
+++ linux-2.6.14-git3/drivers/media/dvb/bt8xx/dst.c
@@ -1077,7 +1077,7 @@
 		return 0;
 	state->diseq_flags &= ~(HAS_LOCK);
 	if (!dst_wait_dst_ready(state, NO_DELAY))
-		return 0;
+		return -EIO;
 	if (state->type_flags & DST_TYPE_HAS_NEWTUNE)
 		/* how to get variable length reply ???? */
 		retval = read_dst(state, state->rx_tuna, 10);
@@ -1085,22 +1085,21 @@
 		retval = read_dst(state, &state->rx_tuna[2], FIXED_COMM);
 	if (retval < 0) {
 		dprintk(verbose, DST_DEBUG, 1, "read not successful");
-		return 0;
+		return retval;
 	}
 	if (state->type_flags & DST_TYPE_HAS_NEWTUNE) {
 		if (state->rx_tuna[9] != dst_check_sum(&state->rx_tuna[0], 9)) {
 			dprintk(verbose, DST_INFO, 1, "checksum failure ? ");
-			return 0;
+			return -EIO;
 		}
 	} else {
 		if (state->rx_tuna[9] != dst_check_sum(&state->rx_tuna[2], 7)) {
 			dprintk(verbose, DST_INFO, 1, "checksum failure? ");
-			return 0;
+			return -EIO;
 		}
 	}
 	if (state->rx_tuna[2] == 0 && state->rx_tuna[3] == 0)
 		return 0;
-
 	if (state->dst_type == DST_TYPE_IS_SAT) {
 		state->decode_freq = ((state->rx_tuna[2] & 0x7f) << 8) + state->rx_tuna[3];
 	} else {
@@ -1129,10 +1128,10 @@
 			dst_set_voltage(fe, SEC_VOLTAGE_13);
 	}
 	state->diseq_flags &= ~(HAS_LOCK | ATTEMPT_TUNE);
-
+	down(&state->dst_mutex);
 	if ((dst_comm_init(state)) < 0) {
 		dprintk(verbose, DST_DEBUG, 1, "DST Communication initialization failed.");
-		return -1;
+		goto error;
 	}
 	if (state->type_flags & DST_TYPE_HAS_NEWTUNE) {
 		state->tx_tuna[9] = dst_check_sum(&state->tx_tuna[0], 9);
@@ -1144,23 +1143,29 @@
 	if (retval < 0) {
 		dst_pio_disable(state);
 		dprintk(verbose, DST_DEBUG, 1, "write not successful");
-		return retval;
+		goto werr;
 	}
 	if ((dst_pio_disable(state)) < 0) {
 		dprintk(verbose, DST_DEBUG, 1, "DST PIO disable failed !");
-		return -1;
+		goto error;
 	}
 	if ((read_dst(state, &reply, GET_ACK) < 0)) {
 		dprintk(verbose, DST_DEBUG, 1, "read verify not successful.");
-		return -1;
+		goto error;
 	}
 	if (reply != ACK) {
 		dprintk(verbose, DST_DEBUG, 1, "write not acknowledged 0x%02x ", reply);
-		return 0;
+		goto error;
 	}
 	state->diseq_flags |= ATTEMPT_TUNE;
-
-	return dst_get_tuna(state);
+	retval = dst_get_tuna(state);
+werr:
+	up(&state->dst_mutex);
+	return retval;
+
+error:
+	up(&state->dst_mutex);
+	return -EIO;
 }
 
 /*




--------------090505050608070002060006--
