Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266589AbUBLU4r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 15:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266590AbUBLU4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 15:56:47 -0500
Received: from gate.crashing.org ([63.228.1.57]:46999 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266589AbUBLU4m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 15:56:42 -0500
Subject: [PATCH] Fix a link conflict between radeonfb and the radeon DRI
	driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1076619198.12431.20.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 13 Feb 2004 07:53:18 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

They both define radeon_engine_reset. Here's a fix (from Panagiotis Papadakos).


diff -ruN linux/drivers/video/aty_orig/radeon_accel.c linux/drivers/video/aty/radeon_accel.c
--- linux/drivers/video/aty_orig/radeon_accel.c	2004-02-12 17:46:43.000000000 +0200
+++ linux/drivers/video/aty/radeon_accel.c	2004-02-12 18:10:47.000000000 +0200
@@ -126,7 +126,7 @@
 	return 0;
 }
 
-void radeon_engine_reset(struct radeonfb_info *rinfo)
+void radeonfb_engine_reset(struct radeonfb_info *rinfo)
 {
 	u32 clock_cntl_index, mclk_cntl, rbbm_soft_reset;
 	u32 host_path_cntl;
@@ -222,14 +222,14 @@
 		R300_cg_workardound(rinfo);
 }
 
-void radeon_engine_init (struct radeonfb_info *rinfo)
+void radeonfb_engine_init (struct radeonfb_info *rinfo)
 {
 	unsigned long temp;
 
 	/* disable 3D engine */
 	OUTREG(RB3D_CNTL, 0);
 
-	radeon_engine_reset(rinfo);
+	radeonfb_engine_reset(rinfo);
 
 	radeon_fifo_wait (1);
 	if ((rinfo->family != CHIP_FAMILY_R300) &&
diff -ruN linux/drivers/video/aty_orig/radeon_base.c linux/drivers/video/aty/radeon_base.c
--- linux/drivers/video/aty_orig/radeon_base.c	2004-02-12 17:46:43.000000000 +0200
+++ linux/drivers/video/aty/radeon_base.c	2004-02-12 18:10:47.000000000 +0200
@@ -1662,7 +1662,7 @@
 		radeon_write_mode (rinfo, &newmode);
 		/* (re)initialize the engine */
 		if (!radeon_accel_disabled())
-			radeon_engine_init (rinfo);
+			radeonfb_engine_init (rinfo);
 	
 	}
 	/* Update fix */
diff -ruN linux/drivers/video/aty_orig/radeon_pm.c linux/drivers/video/aty/radeon_pm.c
--- linux/drivers/video/aty_orig/radeon_pm.c	2004-02-12 17:46:43.000000000 +0200
+++ linux/drivers/video/aty/radeon_pm.c	2004-02-12 18:10:47.000000000 +0200
@@ -862,7 +862,7 @@
 	if (!radeon_accel_disabled()) {
 		/* Make sure engine is reset */
 		radeon_engine_idle();
-		radeon_engine_reset(rinfo);
+		radeonfb_engine_reset(rinfo);
 		radeon_engine_idle();
 	}
 
diff -ruN linux/drivers/video/aty_orig/radeonfb.h linux/drivers/video/aty/radeonfb.h
--- linux/drivers/video/aty_orig/radeonfb.h	2004-02-12 17:46:43.000000000 +0200
+++ linux/drivers/video/aty/radeonfb.h	2004-02-12 18:10:47.000000000 +0200
@@ -556,8 +556,8 @@
 extern void radeonfb_copyarea(struct fb_info *info, const struct fb_copyarea *area);
 extern void radeonfb_imageblit(struct fb_info *p, const struct fb_image *image);
 extern int radeonfb_sync(struct fb_info *info);
-extern void radeon_engine_init (struct radeonfb_info *rinfo);
-extern void radeon_engine_reset(struct radeonfb_info *rinfo);
+extern void radeonfb_engine_init (struct radeonfb_info *rinfo);
+extern void radeonfb_engine_reset(struct radeonfb_info *rinfo);
 
 /* Other functions */
 extern int radeonfb_blank(int blank, struct fb_info *info);


