Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964958AbVKAIN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964958AbVKAIN3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 03:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964971AbVKAIN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 03:13:29 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:26694 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S964958AbVKAINF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 03:13:05 -0500
Message-ID: <43672368.6080705@m1k.net>
Date: Tue, 01 Nov 2005 03:12:24 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
Subject: [PATCH 03/37] dvb: stv0299: revert improper method
Content-Type: multipart/mixed;
 boundary="------------060706090507030703060909"
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
--------------060706090507030703060909
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit




--------------060706090507030703060909
Content-Type: text/x-patch;
 name="2359.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2359.patch"

From: Andrew de Quincey <adq_dvb@lidskialf.net>

Remove my badly thought out patch. This does need done, but in a proper way.

Signed-off-by: Andrew de Quincey <adq_dvb@lidskialf.net>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>

 drivers/media/dvb/frontends/stv0299.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- linux-2.6.14-git3.orig/drivers/media/dvb/frontends/stv0299.c
+++ linux-2.6.14-git3/drivers/media/dvb/frontends/stv0299.c
@@ -64,8 +64,12 @@
 	u32 tuner_frequency;
 	u32 symbol_rate;
 	fe_code_rate_t fec_inner;
+	int errmode;
 };
 
+#define STATUS_BER 0
+#define STATUS_UCBLOCKS 1
+
 static int debug;
 static int debug_legacy_dish_switch;
 #define dprintk(args...) \
@@ -517,8 +521,7 @@
 {
         struct stv0299_state* state = fe->demodulator_priv;
 
-	stv0299_writeregI(state, 0x34, (stv0299_readreg(state, 0x34) & 0xcf) | 0x10);
-	msleep(100);
+	if (state->errmode != STATUS_BER) return 0;
 	*ber = (stv0299_readreg (state, 0x1d) << 8) | stv0299_readreg (state, 0x1e);
 
 	return 0;
@@ -557,9 +560,8 @@
 {
         struct stv0299_state* state = fe->demodulator_priv;
 
-	stv0299_writeregI(state, 0x34, (stv0299_readreg(state, 0x34) & 0xcf) | 0x30);
-	msleep(100);
-	*ucblocks = (stv0299_readreg (state, 0x1d) << 8) | stv0299_readreg (state, 0x1e);
+	if (state->errmode != STATUS_UCBLOCKS) *ucblocks = 0;
+	else *ucblocks = (stv0299_readreg (state, 0x1d) << 8) | stv0299_readreg (state, 0x1e);
 
 	return 0;
 }
@@ -708,6 +710,7 @@
 	state->tuner_frequency = 0;
 	state->symbol_rate = 0;
 	state->fec_inner = 0;
+	state->errmode = STATUS_BER;
 
 	/* check if the demod is there */
 	stv0299_writeregI(state, 0x02, 0x34); /* standby off */


--------------060706090507030703060909--
