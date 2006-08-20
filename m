Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbWHTTDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbWHTTDt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 15:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbWHTTDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 15:03:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:10467 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751155AbWHTTDt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 15:03:49 -0400
X-Authenticated: #704063
Subject: [PATCH] Signdness issue in drivers/video/intelfb/intelfbdrv.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sun, 20 Aug 2006 21:03:45 +0200
Message-Id: <1156100625.3687.6.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

another gcc 4.1 signess warning:

drivers/video/intelfb/intelfbdrv.c:419: warning: comparison of unsigned expression < 0 is always false

since dinfo->mtrr_reg is of the type u32, the error check dinfo->mtrr_reg < 0
is useless. This patch introduces a helper variable, which catches possible
negative error values returned by mtrr_add()

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.18-rc4/drivers/video/intelfb/intelfbdrv.c.orig	2006-08-20 20:46:11.000000000 +0200
+++ linux-2.6.18-rc4/drivers/video/intelfb/intelfbdrv.c	2006-08-20 20:47:14.000000000 +0200
@@ -414,12 +414,13 @@ module_exit(intelfb_exit);
 #ifdef CONFIG_MTRR
 static inline void __devinit set_mtrr(struct intelfb_info *dinfo)
 {
-	dinfo->mtrr_reg = mtrr_add(dinfo->aperture.physical,
+	int mtrr_reg = mtrr_add(dinfo->aperture.physical,
 				   dinfo->aperture.size, MTRR_TYPE_WRCOMB, 1);
-	if (dinfo->mtrr_reg < 0) {
+	if (mtrr_reg < 0) {
 		ERR_MSG("unable to set MTRR\n");
 		return;
 	}
+	dinfo->mtrr_reg = mtrr_reg;
 	dinfo->has_mtrr = 1;
 }
 static inline void unset_mtrr(struct intelfb_info *dinfo)


