Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbVIDXuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbVIDXuE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbVIDXt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:49:58 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:41089 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932128AbVIDXaf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:30:35 -0400
Message-Id: <20050904232324.148520000@abc>
References: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:23:20 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Patrick Boettcher <pb@linuxtv.org>,
       Michael Krufky <mkrufky@m1k.net>
Content-Disposition: inline; filename=dvb-frontend-stv0297-qam128-fix.patch
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 21/54] frontend: stv0297: QAM128 tuning improvement
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Boettcher <pb@linuxtv.org>

while investigating the QAM_128-issue with the stv0297-driver for the
Cablestar (which is not the same as the one in dvb-kernel CVS, yet), I
fixed it, not by increasing the timeout, but by disabling the
corner-detection for QAM_128 and higher.

This patch has been tested on dvb-kernel cvs, and has been reported to
work by multiple users. Some cards still need timeout increase on top of
this patch. This will be addressed later.

Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/frontends/stv0297.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- linux-2.6.13-git4.orig/drivers/media/dvb/frontends/stv0297.c	2005-09-04 22:24:24.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/frontends/stv0297.c	2005-09-04 22:28:12.000000000 +0200
@@ -606,7 +606,13 @@ static int stv0297_set_frontend(struct d
 	stv0297_set_inversion(state, inversion);
 
 	/* kick off lock */
-	stv0297_writereg_mask(state, 0x88, 0x08, 0x08);
+	/* Disable corner detection for higher QAMs */
+	if (p->u.qam.modulation == QAM_128 ||
+		p->u.qam.modulation == QAM_256)
+		stv0297_writereg_mask(state, 0x88, 0x08, 0x00);
+	else
+		stv0297_writereg_mask(state, 0x88, 0x08, 0x08);
+
 	stv0297_writereg_mask(state, 0x5a, 0x20, 0x00);
 	stv0297_writereg_mask(state, 0x6a, 0x01, 0x01);
 	stv0297_writereg_mask(state, 0x43, 0x40, 0x40);

--

