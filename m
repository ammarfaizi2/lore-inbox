Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbVIDXtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbVIDXtP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbVIDXai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:30:38 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:34433 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932117AbVIDXaV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:30:21 -0400
Message-Id: <20050904232323.603086000@abc>
References: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:23:19 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-frontend-cx24110-timeout-handling-cleanup.patch
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 20/54] frontend: cx24110: clean up timeout handling.
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up timeout handling.

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/frontends/cx24110.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

--- linux-2.6.13-git4.orig/drivers/media/dvb/frontends/cx24110.c	2005-09-04 22:28:10.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/frontends/cx24110.c	2005-09-04 22:28:11.000000000 +0200
@@ -387,8 +387,9 @@ static int cx24110_set_voltage (struct d
 
 static int cx24110_diseqc_send_burst(struct dvb_frontend* fe, fe_sec_mini_cmd_t burst)
 {
-	int rv, bit, i;
+	int rv, bit;
 	struct cx24110_state *state = fe->demodulator_priv;
+	unsigned long timeout;
 
 	if (burst == SEC_MINI_A)
 		bit = 0x00;
@@ -403,8 +404,9 @@ static int cx24110_diseqc_send_burst(str
 
 	rv = cx24110_readreg(state, 0x76);
 	cx24110_writereg(state, 0x76, ((rv & 0x90) | 0x40 | bit));
-	for (i = 500; i-- > 0 && !(cx24110_readreg(state,0x76)&0x40) ; )
-              ; /* wait for LNB ready */
+	timeout = jiffies + msecs_to_jiffies(100);
+	while (!time_after(jiffies, timeout) && !(cx24110_readreg(state, 0x76) & 0x40))
+		; /* wait for LNB ready */
 
 	return 0;
 }
@@ -414,6 +416,7 @@ static int cx24110_send_diseqc_msg(struc
 {
 	int i, rv;
 	struct cx24110_state *state = fe->demodulator_priv;
+	unsigned long timeout;
 
 	for (i = 0; i < cmd->msg_len; i++)
 		cx24110_writereg(state, 0x79 + i, cmd->msg[i]);
@@ -427,8 +430,9 @@ static int cx24110_send_diseqc_msg(struc
 	rv = cx24110_readreg(state, 0x76);
 
 	cx24110_writereg(state, 0x76, ((rv & 0x90) | 0x40) | ((cmd->msg_len-3) & 3));
-	for (i=100; i-- > 0 && !(cx24110_readreg(state,0x76)&0x40);)
-		msleep(1); /* wait for LNB ready */
+	timeout = jiffies + msecs_to_jiffies(100);
+	while (!time_after(jiffies, timeout) && !(cx24110_readreg(state, 0x76) & 0x40))
+		; /* wait for LNB ready */
 
 	return 0;
 }

--

