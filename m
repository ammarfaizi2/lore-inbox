Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262323AbVCVCJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbVCVCJJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 21:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262336AbVCVCIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:08:22 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:13707 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262323AbVCVBfX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:35:23 -0500
Message-Id: <20050322013458.682949000@abc>
References: <20050322013427.919515000@abc>
Date: Tue, 22 Mar 2005 02:24:05 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-dibusb-pll-fix.patch
X-SA-Exim-Connect-IP: 217.231.55.169
Subject: [DVB patch 32/48] dibusb: pll fix
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

o fixed pll frequency calculation for channels > 700 MHz.  (Patrick Boettcher)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 dvb-dibusb-fe-i2c.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-fe-i2c.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/dibusb/dvb-dibusb-fe-i2c.c	2005-03-22 00:16:28.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-fe-i2c.c	2005-03-22 00:18:55.000000000 +0100
@@ -278,10 +278,10 @@ static int thomson_cable_eu_pll_set(stru
 
 static int panasonic_cofdm_env57h1xd5_pll_set(struct dvb_frontend_parameters *fep, u8 pllbuf[4])
 {
-	u32 freq = fep->frequency;
-	u32 tfreq = ((freq + 36125000)*6 + 500000) / 1000000;
+	u32 freq_khz = fep->frequency / 1000;
+	u32 tfreq = ((freq_khz + 36125)*6 + 500) / 1000;
 	u8 TA, T210, R210, ctrl1, cp210, p4321;
-	if (freq > 858000000) {
+	if (freq_khz > 858000) {
 		err("frequency cannot be larger than 858 MHz.");
 		return -EINVAL;
 	}
@@ -293,17 +293,17 @@ static int panasonic_cofdm_env57h1xd5_pl
 	ctrl1 = (1 << 7) | (TA << 6) | (T210 << 3) | R210;
 
 // ********    CHARGE PUMP CONFIG vs RF FREQUENCIES     *****************
-	if (freq < 470000000)
+	if (freq_khz < 470000)
 		cp210 = 2;  // VHF Low and High band ch E12 to E4 to E12
-	else if (freq < 526000000)
+	else if (freq_khz < 526000)
 		cp210 = 4;  // UHF band Ch E21 to E27
 	else // if (freq < 862000000)
 		cp210 = 5;  // UHF band ch E28 to E69
 
 //*********************    BW select  *******************************
-	if (freq < 153000000)
+	if (freq_khz < 153000)
 		p4321  = 1; // BW selected for VHF low
-	else if (freq < 470000000)
+	else if (freq_khz < 470000)
 		p4321  = 2; // BW selected for VHF high E5 to E12
 	else // if (freq < 862000000)
 		p4321  = 4; // BW selection for UHF E21 to E69

--

