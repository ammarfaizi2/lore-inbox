Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263182AbUE2EJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263182AbUE2EJM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 00:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263171AbUE2EJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 00:09:12 -0400
Received: from gate.crashing.org ([63.228.1.57]:35237 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263182AbUE2EJE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 00:09:04 -0400
Subject: [PATCH] radeonfb iBook & IGP fixes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1085803388.2140.4.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 29 May 2004 14:03:08 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch to radeonfb fixes support for the latest iBook models along
with an initialisation problem on some IGP chipsets. Please apply.

Ben.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

--- linux/drivers/video/aty/radeon_base.c.orig	2004-05-10 04:32:27.000000000 +0200
+++ linux/drivers/video/aty/radeon_base.c	2004-05-16 17:57:59.000000000 +0200
@@ -1144,6 +1144,7 @@
 
 	/* Set PPLL ref. div */
 	if (rinfo->family == CHIP_FAMILY_R300 ||
+	    rinfo->family == CHIP_FAMILY_RS300 ||
 	    rinfo->family == CHIP_FAMILY_R350 ||
 	    rinfo->family == CHIP_FAMILY_RV350) {
 		if (mode->ppll_ref_div & R300_PPLL_REF_DIV_ACC_MASK) {
@@ -1855,7 +1856,8 @@
 	     rinfo->family == CHIP_FAMILY_RV280 ||
 	     rinfo->family == CHIP_FAMILY_RV350) &&
 	    !machine_is_compatible("PowerBook4,3") &&
-	    !machine_is_compatible("PowerBook6,3"))
+	    !machine_is_compatible("PowerBook6,3") &&
+	    !machine_is_compatible("PowerBook6,5"))
 		conv_table = backlight_conv_m7;
 	else
 		conv_table = backlight_conv_m6;
@@ -2129,7 +2131,31 @@
 #endif /* CONFIG_PPC_OF */
 
 	/* framebuffer size */
-	tmp = INREG(CONFIG_MEMSIZE);
+        if ((rinfo->family == CHIP_FAMILY_RS100) ||
+            (rinfo->family == CHIP_FAMILY_RS200) ||
+            (rinfo->family == CHIP_FAMILY_RS300)) {
+          u32 tom = INREG(NB_TOM);
+          tmp = ((((tom >> 16) - (tom & 0xffff) + 1) << 6) * 1024);
+ 
+          OUTREG(MC_FB_LOCATION, tom);
+          OUTREG(DISPLAY_BASE_ADDR, (tom & 0xffff) << 16);
+          OUTREG(CRTC2_DISPLAY_BASE_ADDR, (tom & 0xffff) << 16);
+          OUTREG(OV0_BASE_ADDR, (tom & 0xffff) << 16);
+ 
+          /* This is supposed to fix the crtc2 noise problem. */
+          OUTREG(GRPH2_BUFFER_CNTL, INREG(GRPH2_BUFFER_CNTL) & ~0x7f0000);
+ 
+          if ((rinfo->family == CHIP_FAMILY_RS100) ||
+              (rinfo->family == CHIP_FAMILY_RS200)) {
+             /* This is to workaround the asic bug for RMX, some versions
+                of BIOS dosen't have this register initialized correctly.
+             */
+             OUTREGP(CRTC_MORE_CNTL, CRTC_H_CUTOFF_ACTIVE_EN,
+                     ~CRTC_H_CUTOFF_ACTIVE_EN);
+          }
+        } else {
+          tmp = INREG(CONFIG_MEMSIZE);
+        }
 
 	/* mem size is bits [28:0], mask off the rest */
 	rinfo->video_ram = tmp & CONFIG_MEMSIZE_MASK;
--- linux/include/video/radeon.h.orig	2004-05-10 04:33:21.000000000 +0200
+++ linux/include/video/radeon.h	2004-05-17 17:48:34.000000000 +0200
@@ -173,6 +173,8 @@
 #define CUR_CLR1                               0x0270  
 #define FP_HORZ_VERT_ACTIVE                    0x0278  
 #define CRTC_MORE_CNTL                         0x027C  
+#define CRTC_H_CUTOFF_ACTIVE_EN                (1<<4)
+#define CRTC_V_CUTOFF_ACTIVE_EN                (1<<5)
 #define DAC_EXT_CNTL                           0x0280  
 #define FP_GEN_CNTL                            0x0284  
 #define FP_HORZ_STRETCH                        0x028C  
@@ -185,6 +187,7 @@
 //#define DDA_ON_OFF			       0x02e4
 #define DVI_I2C_CNTL_1			       0x02e4
 #define GRPH_BUFFER_CNTL                       0x02F0
+#define GRPH2_BUFFER_CNTL                      0x03F0
 #define VGA_BUFFER_CNTL                        0x02F4
 #define OV0_Y_X_START                          0x0400
 #define OV0_Y_X_END                            0x0404  
@@ -1944,7 +1947,7 @@
 #define ixREG_COLLAR_WRITE                         0x0013
 #define ixREG_COLLAR_READ                          0x0014
 
-
+#define NB_TOM                                     0x15C
 
 
 #endif	/* _RADEON_H */
--- linux/drivers/video/aty/radeon_monitor.c.orig	2004-05-10 04:31:55.000000000 +0200
+++ linux/drivers/video/aty/radeon_monitor.c	2004-05-16 17:59:32.000000000 +0200
@@ -653,7 +653,8 @@
 		rinfo->panel_info.use_bios_dividers = 1;
 	}
 	/* iBook G4 */
-	if (machine_is_compatible("PowerBook6,3")) {
+        if (machine_is_compatible("PowerBook6,3") |
+            machine_is_compatible("PowerBook6,5")) {
 		rinfo->panel_info.ref_divider = rinfo->pll.ref_div;
 		rinfo->panel_info.post_divider = 0x6;
 		rinfo->panel_info.fbk_divider = 0xad;


