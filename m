Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268270AbUIXFwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268270AbUIXFwd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 01:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268482AbUIXFvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 01:51:09 -0400
Received: from gate.crashing.org ([63.228.1.57]:12515 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267807AbUIXFpY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 01:45:24 -0400
Subject: [PATCH] radeonfb: Fix newer PowerBook & warnings
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1096004691.4011.25.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 24 Sep 2004 15:44:52 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch fixes a few warnings in radeonfb and add proper PLL divider
values for Apple latest PowerBook Aliminium 17" so the display isn't
"fuzzy" (the LVDS interface needs special PLL values that the driver
can't calculate, on most x86, the BIOS tells us the values to use,
on Apple laptops, we have to hard code them for each model).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

diff -urN linux-2.5/drivers/video/aty/radeon_base.c linux-lappy/drivers/video/aty/radeon_base.c
--- linux-2.5/drivers/video/aty/radeon_base.c	2004-09-24 14:35:04.000000000 +1000
+++ linux-lappy/drivers/video/aty/radeon_base.c	2004-09-24 14:41:36.000000000 +1000
@@ -1868,7 +1868,7 @@
 #undef SET_MC_FB_FROM_APERTURE
 static void fixup_memory_mappings(struct radeonfb_info *rinfo)
 {
-	u32 save_crtc_gen_cntl, save_crtc2_gen_cntl;
+	u32 save_crtc_gen_cntl, save_crtc2_gen_cntl = 0;
 	u32 save_crtc_ext_cntl;
 	u32 aper_base, aper_size;
 	u32 agp_base;
diff -urN linux-2.5/drivers/video/aty/radeon_monitor.c linux-lappy/drivers/video/aty/radeon_monitor.c
--- linux-2.5/drivers/video/aty/radeon_monitor.c	2004-09-24 14:35:04.000000000 +1000
+++ linux-lappy/drivers/video/aty/radeon_monitor.c	2004-09-24 15:30:11.000000000 +1000
@@ -55,7 +55,7 @@
 	u8 *pedid = NULL;
 	u8 *pmt = NULL;
 	u8 *tmp;
-        int i, mt;  
+        int i, mt = MT_NONE;  
 	
 	RTRACE("analyzing OF properties...\n");
 	pmt = (u8 *)get_property(dp, "display-type", NULL);
@@ -72,7 +72,9 @@
 	else if (strcmp(pmt, "NONE")) {
 		printk(KERN_WARNING "radeonfb: Unknown OF display-type: %s\n", pmt);
 		return MT_NONE;
-	}
+	} else
+		return MT_NONE;
+
 	for (i = 0; propnames[i] != NULL; ++i) {
 		pedid = (u8 *)get_property(dp, propnames[i], NULL);
 		if (pedid != NULL)
@@ -645,15 +647,23 @@
 		rinfo->panel_info.fbk_divider = 0xad;
 		rinfo->panel_info.use_bios_dividers = 1;
 	}
+	/* Aluminium PowerBook 15" */
+	if (machine_is_compatible("PowerBook5,4")) {
+		rinfo->panel_info.ref_divider = rinfo->pll.ref_div;
+		rinfo->panel_info.post_divider = 0x2;
+		rinfo->panel_info.fbk_divider = 0x8e;
+		rinfo->panel_info.use_bios_dividers = 1;
+	}
 	/* Aluminium PowerBook 17" */
-	if (machine_is_compatible("PowerBook5,3")) {
+	if (machine_is_compatible("PowerBook5,3") ||
+	    machine_is_compatible("PowerBook5,5")) {
 		rinfo->panel_info.ref_divider = rinfo->pll.ref_div;
 		rinfo->panel_info.post_divider = 0x4;
 		rinfo->panel_info.fbk_divider = 0x80;
 		rinfo->panel_info.use_bios_dividers = 1;
 	}
 	/* iBook G4 */
-        if (machine_is_compatible("PowerBook6,3") |
+        if (machine_is_compatible("PowerBook6,3") ||
             machine_is_compatible("PowerBook6,5")) {
 		rinfo->panel_info.ref_divider = rinfo->pll.ref_div;
 		rinfo->panel_info.post_divider = 0x6;




