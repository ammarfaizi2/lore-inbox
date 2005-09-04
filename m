Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbVIDXjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbVIDXjB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbVIDXbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:31:00 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:30081 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932111AbVIDXaM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:30:12 -0400
Message-Id: <20050904232322.468485000@abc>
References: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:23:16 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-frontend-ves1820-improve-tuning.patch
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 17/54] frontend: ves1820: improve tuning
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reset acgconf register after tuning to improve locking, as suggested
by Marco Schluessler.
Minor cleanups in ves1820_init().

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/frontends/ves1820.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

--- linux-2.6.13-git4.orig/drivers/media/dvb/frontends/ves1820.c	2005-09-04 22:24:24.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/frontends/ves1820.c	2005-09-04 22:28:08.000000000 +0200
@@ -194,19 +194,18 @@ static int ves1820_init(struct dvb_front
 {
 	struct ves1820_state* state = fe->demodulator_priv;
 	int i;
-	int val;
 
 	ves1820_writereg(state, 0, 0);
 
-	for (i = 0; i < 53; i++) {
-		val = ves1820_inittab[i];
-		if ((i == 2) && (state->config->selagc)) val |= 0x08;
-		ves1820_writereg(state, i, val);
-	}
+	for (i = 0; i < sizeof(ves1820_inittab); i++)
+		ves1820_writereg(state, i, ves1820_inittab[i]);
+	if (state->config->selagc)
+		ves1820_writereg(state, 2, ves1820_inittab[2] | 0x08);
 
 	ves1820_writereg(state, 0x34, state->pwm);
 
-	if (state->config->pll_init) state->config->pll_init(fe);
+	if (state->config->pll_init)
+		state->config->pll_init(fe);
 
 	return 0;
 }
@@ -234,7 +233,7 @@ static int ves1820_set_parameters(struct
 	ves1820_writereg(state, 0x09, reg0x09[real_qam]);
 
 	ves1820_setup_reg0(state, reg0x00[real_qam], p->inversion);
-
+	ves1820_writereg(state, 2, ves1820_inittab[2] | (state->config->selagc ? 0x08 : 0));
 	return 0;
 }
 

--

