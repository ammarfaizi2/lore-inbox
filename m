Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263589AbUETQEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263589AbUETQEr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 12:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265124AbUETQEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 12:04:47 -0400
Received: from havoc.gtf.org ([216.162.42.101]:11183 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S263589AbUETQDs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 12:03:48 -0400
Date: Thu, 20 May 2004 12:03:47 -0400
From: David Eger <eger@havoc.gtf.org>
To: Andrew Morton <akpm@osdl.org>
Cc: David Eger <eger@theboonies.us>, linux-fbdev-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] radeonfb accel capabilities
Message-ID: <20040520160347.GC17807@havoc.gtf.org>
References: <Pine.LNX.4.58.0405191118170.4760@rosencrantz.theboonies.us> <20040519030319.1f0e6eec.akpm@osdl.org> <20040520155439.GA17330@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040520155439.GA17330@havoc.gtf.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 radeonfb: upgrade accel indication to fb_info->flags semantics
    (now with accelerated framebuffer console!)

diff -Nru a/drivers/video/aty/radeon_accel.c b/drivers/video/aty/radeon_accel.c
--- a/drivers/video/aty/radeon_accel.c	Tue May 18 12:39:09 2004
+++ b/drivers/video/aty/radeon_accel.c	Tue May 18 12:39:09 2004
@@ -30,7 +30,7 @@
   
 	if (info->state != FBINFO_STATE_RUNNING)
 		return;
-	if (radeon_accel_disabled()) {
+	if (info->flags & FBINFO_HWACCEL_DISABLED) {
 		cfb_fillrect(info, region);
 		return;
 	}
@@ -96,7 +96,7 @@
   
 	if (info->state != FBINFO_STATE_RUNNING)
 		return;
-	if (radeon_accel_disabled()) {
+	if (info->flags & FBINFO_HWACCEL_DISABLED) {
 		cfb_copyarea(info, area);
 		return;
 	}
@@ -144,6 +144,9 @@
 	u32 clock_cntl_index, mclk_cntl, rbbm_soft_reset;
 	u32 host_path_cntl;
 
+	if (rinfo->info->flags & FBINFO_HWACCEL_DISABLED)
+		return;
+	
 	radeon_engine_flush (rinfo);
 
     	/* Some ASICs have bugs with dynamic-on feature, which are  
@@ -239,6 +242,9 @@
 {
 	unsigned long temp;
 
+	if (rinfo->info->flags & FBINFO_HWACCEL_DISABLED)
+		return;
+	
 	/* disable 3D engine */
 	OUTREG(RB3D_CNTL, 0);
 
diff -Nru a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
--- a/drivers/video/aty/radeon_base.c	Tue May 18 12:39:09 2004
+++ b/drivers/video/aty/radeon_base.c	Tue May 18 12:39:09 2004
@@ -242,8 +242,6 @@
 static int nomtrr = 0;
 #endif
 
-int radeonfb_noaccel = 0;
-
 /*
  * prototypes
  */
@@ -810,9 +808,8 @@
 	/* XXX I'm adjusting xres_virtual to the pitch, that may help XFree
 	 * with some panels, though I don't quite like this solution
 	 */
-  	if (radeon_accel_disabled()) {
+  	if (rinfo->info->flags & FBINFO_HWACCEL_DISABLED) {
 		v.xres_virtual = v.xres_virtual & ~7ul;
-		v.accel_flags = 0;
 	} else {
 		pitch = ((v.xres_virtual * ((v.bits_per_pixel + 1) / 8) + 0x3f)
  				& ~(0x3f)) >> 6;
@@ -1523,7 +1520,7 @@
 	newmode.crtc_v_sync_strt_wid = (((vSyncStart - 1) & 0xfff) |
 					 (vsync_wid << 16) | (v_sync_pol  << 23));
 
-	if (!radeon_accel_disabled()) {
+	if (!(info->flags & FBINFO_HWACCEL_DISABLED)) {
 		/* We first calculate the engine pitch */
 		rinfo->pitch = ((mode->xres_virtual * ((mode->bits_per_pixel + 1) / 8) + 0x3f)
  				& ~(0x3f)) >> 6;
@@ -1671,12 +1668,10 @@
 	if (!rinfo->asleep) {
 		radeon_write_mode (rinfo, &newmode);
 		/* (re)initialize the engine */
-		if (!radeon_accel_disabled())
-			radeonfb_engine_init (rinfo);
-	
+		radeonfb_engine_init (rinfo);
 	}
 	/* Update fix */
-	if (!radeon_accel_disabled())
+	if (!(info->flags & FBINFO_HWACCEL_DISABLED))
         	info->fix.line_length = rinfo->pitch*64;
         else
 		info->fix.line_length = mode->xres_virtual
@@ -1781,7 +1776,11 @@
 	info->currcon = -1;
 	info->par = rinfo;
 	info->pseudo_palette = rinfo->pseudo_palette;
-        info->flags = FBINFO_DEFAULT;
+        info->flags = FBINFO_DEFAULT
+		| FBINFO_HWACCEL_COPYAREA
+		| FBINFO_HWACCEL_FILLRECT
+		| FBINFO_HWACCEL_XPAN
+		| FBINFO_HWACCEL_YPAN;
         info->fbops = &radeonfb_ops;
         info->display_fg = NULL;
         info->screen_base = (char *)rinfo->fb_base;
@@ -1798,17 +1797,11 @@
         info->fix.type_aux = 0;
         info->fix.mmio_start = rinfo->mmio_base_phys;
         info->fix.mmio_len = RADEON_REGSIZE;
-	if (radeon_accel_disabled())
-	        info->fix.accel = FB_ACCEL_NONE;
-	else
-		info->fix.accel = FB_ACCEL_ATI_RADEON;
 
 	fb_alloc_cmap(&info->cmap, 256, 0);
-
-	if (radeon_accel_disabled())
-		info->var.accel_flags &= ~FB_ACCELF_TEXT;
-	else
-		info->var.accel_flags |= FB_ACCELF_TEXT;
+	
+	if (noaccel)
+		info->flags |= FBINFO_HWACCEL_DISABLED;
 
         return 0;
 }
@@ -2398,7 +2391,6 @@
 
 int __init radeonfb_init (void)
 {
-	radeonfb_noaccel = noaccel;
 	return pci_module_init (&radeonfb_driver);
 }
 
@@ -2420,7 +2412,7 @@
 			continue;
 
 		if (!strncmp(this_opt, "noaccel", 7)) {
-			noaccel = radeonfb_noaccel = 1;
+			noaccel = 1;
 		} else if (!strncmp(this_opt, "mirror", 6)) {
 			mirror = 1;
 		} else if (!strncmp(this_opt, "force_dfp", 9)) {
diff -Nru a/drivers/video/aty/radeon_pm.c b/drivers/video/aty/radeon_pm.c
--- a/drivers/video/aty/radeon_pm.c	Tue May 18 12:39:09 2004
+++ b/drivers/video/aty/radeon_pm.c	Tue May 18 12:39:09 2004
@@ -859,12 +859,10 @@
 
 	fb_set_suspend(info, 1);
 
-	if (!radeon_accel_disabled()) {
-		/* Make sure engine is reset */
-		radeon_engine_idle();
-		radeonfb_engine_reset(rinfo);
-		radeon_engine_idle();
-	}
+	/* Make sure engine is reset */
+	radeon_engine_idle();
+	radeonfb_engine_reset(rinfo);
+	radeon_engine_idle();
 
 	/* Blank display and LCD */
 	radeonfb_blank(VESA_POWERDOWN+1, info);
diff -Nru a/drivers/video/aty/radeonfb.h b/drivers/video/aty/radeonfb.h
--- a/drivers/video/aty/radeonfb.h	Tue May 18 12:39:09 2004
+++ b/drivers/video/aty/radeonfb.h	Tue May 18 12:39:09 2004
@@ -527,12 +527,6 @@
 	printk(KERN_ERR "radeonfb: Idle Timeout !\n");
 }
 
-static inline int radeon_accel_disabled(void)
-{
-	extern int radeonfb_noaccel;
-	return radeonfb_noaccel;
-}
-
 #define radeon_engine_idle()		_radeon_engine_idle(rinfo)
 #define radeon_fifo_wait(entries)	_radeon_fifo_wait(rinfo,entries)
 
