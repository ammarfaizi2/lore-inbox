Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbVIDXjD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbVIDXjD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:39:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbVIDXa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:30:57 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:29313 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932110AbVIDXaH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:30:07 -0400
Message-Id: <20050904232320.538578000@abc>
References: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:23:11 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Barry Scott <barry.scott@onelan.co.uk>
Content-Disposition: inline; filename=dvb-frontend-mt352-signalstrength-fix.patch
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 12/54] frontend: mt352: fix signal strength reading
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Barry Scott <barry.scott@onelan.co.uk>

Fix two problems with the signal strength value in the mt352.c frontend:
1. the 4 most significant bits are zeroed - shift and mask wrong way round
2. need to align the 12 bits from the registers at the top of the 16 bit
   returned value - otherwise the range is not 0 to 0xffff its 0xf000 to 0xffff

Signed-off-by: Barry Scott <barry.scott@onelan.co.uk>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/frontends/mt352.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- linux-2.6.13-git4.orig/drivers/media/dvb/frontends/mt352.c	2005-09-04 22:24:24.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/frontends/mt352.c	2005-09-04 22:28:02.000000000 +0200
@@ -462,9 +462,11 @@ static int mt352_read_signal_strength(st
 {
 	struct mt352_state* state = fe->demodulator_priv;
 
-	u16 signal = ((mt352_read_register(state, AGC_GAIN_1) << 8) & 0x0f) |
-		      (mt352_read_register(state, AGC_GAIN_0));
+	/* align the 12 bit AGC gain with the most significant bits */
+	u16 signal = ((mt352_read_register(state, AGC_GAIN_1) & 0x0f) << 12) |
+		(mt352_read_register(state, AGC_GAIN_0) << 4);
 
+	/* inverse of gain is signal strength */
 	*strength = ~signal;
 	return 0;
 }

--

