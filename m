Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750876AbVJAWcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbVJAWcE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 18:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750879AbVJAWcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 18:32:04 -0400
Received: from gate.crashing.org ([63.228.1.57]:33169 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750876AbVJAWcC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 18:32:02 -0400
Subject: [PATCH] pmac/radeonfb: Add suspend support for M11 chip in new
	iBook 12"
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Sven Henkel <shenkel@gmail.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sun, 02 Oct 2005 08:29:18 +1000
Message-Id: <1128205759.8267.5.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Henkel <shenkel@gmail.com>

this patch adds suspend support for the Radeon M11 chip in 12" iBooks 
manufactured after July 2005. I don't know if the new 14" iBooks also have 
that chip, so they might also be supported.

The chip identifies itself as "RV350 NV" (pci id 0x4e56), revision 0x80. 
Apple calls it "Snowy", xfree86 names it "ATI FireGL Mobility T2 (M11) NV 
(AGP)". So, we seem to be lucky here: The suspend-code for the M10 (which 
also is a "RV350 NV") works flawless for that chip.

Signed-off-by: Sven Henkel <shenkel@gmail.com>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

--- linux-2.6.13.2-orig/drivers/video/aty/radeon_pm.c	2005-09-30 19:27:11.000000000 +0200
+++ linux-2.6.13.2-dev/drivers/video/aty/radeon_pm.c	2005-10-01 12:03:11.000000000 +0200
@@ -62,9 +62,9 @@ static void radeon_pm_disable_dynamic_mo
                 OUTPLL(pllSCLK_CNTL, tmp);
 		return;
 	}
-	/* RV350 (M10) */
+	/* RV350 (M10/M11) */
 	if (rinfo->family == CHIP_FAMILY_RV350) {
-                /* for RV350/M10, no delays are required. */
+                /* for RV350/M10/M11, no delays are required. */
                 tmp = INPLL(pllSCLK_CNTL2);
                 tmp |= (SCLK_CNTL2__R300_FORCE_TCL |
                         SCLK_CNTL2__R300_FORCE_GA  |
@@ -248,7 +248,7 @@ static void radeon_pm_enable_dynamic_mod
 		return;
 	}
 
-	/* M10 */
+	/* M10/M11 */
 	if (rinfo->family == CHIP_FAMILY_RV350) {
 		tmp = INPLL(pllSCLK_CNTL2);
 		tmp &= ~(SCLK_CNTL2__R300_FORCE_TCL |
@@ -1155,7 +1155,7 @@ static void radeon_pm_full_reset_sdram(s
 	OUTREG( CRTC_GEN_CNTL,  (crtcGenCntl | CRTC_GEN_CNTL__CRTC_DISP_REQ_EN_B) );
 	OUTREG( CRTC2_GEN_CNTL, (crtcGenCntl2 | CRTC2_GEN_CNTL__CRTC2_DISP_REQ_EN_B) );
   
-	/* This is the code for the Aluminium PowerBooks M10 */
+	/* This is the code for the Aluminium PowerBooks M10 / iBooks M11 */
 	if (rinfo->family == CHIP_FAMILY_RV350) {
 		u32 sdram_mode_reg = rinfo->save_regs[35];
 		static u32 default_mrtable[] =
@@ -2741,9 +2741,11 @@ void radeonfb_pm_init(struct radeonfb_in
 			rinfo->pm_mode |= radeon_pm_d2;
 
 		/* We can restart Jasper (M10 chip in albooks), BlueStone (7500 chip
-		 * in some desktop G4s), and Via (M9+ chip on iBook G4)
+		 * in some desktop G4s), Via (M9+ chip on iBook G4) and
+		 * Snowy (M11 chip on iBook G4 manufactured after July 2005)
 		 */
-		if (!strcmp(rinfo->of_node->name, "ATY,JasperParent")) {
+		if (!strcmp(rinfo->of_node->name, "ATY,JasperParent") ||
+		    !strcmp(rinfo->of_node->name, "ATY,SnowyParent")) {
 			rinfo->reinit_func = radeon_reinitialize_M10;
 			rinfo->pm_mode |= radeon_pm_off;
 		}

