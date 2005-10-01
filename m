Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbVJAKdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbVJAKdL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 06:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbVJAKdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 06:33:11 -0400
Received: from dd3624.kasserver.com ([81.209.188.85]:52184 "EHLO
	dd3624.kasserver.com") by vger.kernel.org with ESMTP
	id S1750787AbVJAKdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 06:33:10 -0400
From: Sven Henkel <shenkel@gmail.com>
To: benh@kernel.crashing.org, linux-fbdev-devel@lists.sourceforge.net
Subject: [PATCH] radeonfb: Add suspend support for M11 chip in new iBook 12"
Date: Sat, 1 Oct 2005 12:32:59 +0200
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510011233.00147.shenkel@gmail.com>
X-Spam-Flag: NO
X-Spam-score: -1.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch adds suspend support for the Radeon M11 chip in 12" iBooks 
manufactured after July 2005. I don't know if the new 14" iBooks also have 
that chip, so they might also be supported.

The chip identifies itself as "RV350 NV" (pci id 0x4e56), revision 0x80. 
Apple calls it "Snowy", xfree86 names it "ATI FireGL Mobility T2 (M11) NV 
(AGP)". So, we seem to be lucky here: The suspend-code for the M10 (which 
also is a "RV350 NV") works flawless for that chip.

Together with the patch provided at

http://lkml.org/lkml/2005/10/1/30/index.html

the following patch completes suspend-to-ram support for post-July-2005 
12" iBooks. It applies to vanilla 2.6.13.2 and contains mainly documentation 
updates and one line of code-change.

Ciao,
Sven

Signed-off-by: Sven Henkel <shenkel@gmail.com>

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
