Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262299AbVCVCVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262299AbVCVCVe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 21:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262376AbVCVCVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:21:23 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:49546 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262299AbVCVBeb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:34:31 -0500
Message-Id: <20050322013455.380672000@abc>
References: <20050322013427.919515000@abc>
Date: Tue, 22 Mar 2005 02:23:41 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-frontends-ves1x93-invert-pwm.patch
X-SA-Exim-Connect-IP: 217.231.55.169
Subject: [DVB patch 08/48] ves1x93: invert_pwm fix
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fix unhandled invert_pwm option (needed on dbox2 hardware)
submitted by Carsten Juttner

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 ves1x93.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/ves1x93.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/frontends/ves1x93.c	2005-03-21 23:27:59.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/ves1x93.c	2005-03-22 00:15:00.000000000 +0100
@@ -175,7 +175,7 @@ static int ves1x93_set_symbolrate (struc
 {
 	u32 BDR;
 	u32 ratio;
-	u8  ADCONF, FCONF, FNR;
+	u8  ADCONF, FCONF, FNR, AGCR;
 	u32 BDRI;
 	u32 tmp;
 	u32 FIN;
@@ -243,10 +243,16 @@ static int ves1x93_set_symbolrate (struc
 	ves1x93_writereg (state, 0x20, ADCONF);
 	ves1x93_writereg (state, 0x21, FCONF);
 
+	AGCR = state->init_1x93_tab[0x05];
+	if (state->config->invert_pwm)
+		AGCR |= 0x20;
+
 	if (srate < 6000000)
-		ves1x93_writereg (state, 0x05, state->init_1x93_tab[0x05] | 0x80);
+		AGCR |= 0x80;
 	else
-		ves1x93_writereg (state, 0x05, state->init_1x93_tab[0x05] & 0x7f);
+		AGCR &= ~0x80;
+
+	ves1x93_writereg (state, 0x05, AGCR);
 
 	/* ves1993 hates this, will lose lock */
 	if (state->demod_type != DEMOD_VES1993)

--

