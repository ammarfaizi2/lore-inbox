Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbUIOH1G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbUIOH1G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 03:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbUIOH1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 03:27:06 -0400
Received: from gate.crashing.org ([63.228.1.57]:13462 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262138AbUIOH0t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 03:26:49 -0400
Subject: [PATCH] radeonfb: Fix warnings about uninitialized variables
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1095232906.4537.459.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 15 Sep 2004 17:21:47 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch fixes a couple of warnings about possible uninitialized
variables in radeonfb, along with a small logic error in the monitor
probe code when nothing was found.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

===== drivers/video/aty/radeon_base.c 1.28 vs edited =====
--- 1.28/drivers/video/aty/radeon_base.c	2004-09-13 14:05:55 +10:00
+++ edited/drivers/video/aty/radeon_base.c	2004-09-15 17:20:16 +10:00
@@ -1868,7 +1868,7 @@
 #undef SET_MC_FB_FROM_APERTURE
 static void fixup_memory_mappings(struct radeonfb_info *rinfo)
 {
-	u32 save_crtc_gen_cntl, save_crtc2_gen_cntl;
+	u32 save_crtc_gen_cntl, save_crtc2_gen_cntl = 0;
 	u32 save_crtc_ext_cntl;
 	u32 aper_base, aper_size;
 	u32 agp_base;
===== drivers/video/aty/radeon_monitor.c 1.7 vs edited =====
--- 1.7/drivers/video/aty/radeon_monitor.c	2004-05-17 01:59:32 +10:00
+++ edited/drivers/video/aty/radeon_monitor.c	2004-09-15 17:19:25 +10:00
@@ -69,8 +69,10 @@
 		mt = MT_DFP;
 	else if (!strcmp(pmt, "CRT"))
 		mt = MT_CRT;
-	else if (strcmp(pmt, "NONE")) {
-		printk(KERN_WARNING "radeonfb: Unknown OF display-type: %s\n", pmt);
+	else {
+		if (strcmp(pmt, "NONE") != 0)
+			printk(KERN_WARNING "radeonfb: Unknown OF display-type: %s\n",
+			       pmt);
 		return MT_NONE;
 	}
 	for (i = 0; propnames[i] != NULL; ++i) {




