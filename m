Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268109AbTAJCnI>; Thu, 9 Jan 2003 21:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268111AbTAJCnF>; Thu, 9 Jan 2003 21:43:05 -0500
Received: from dp.samba.org ([66.70.73.150]:41147 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S268109AbTAJCm5>;
	Thu, 9 Jan 2003 21:42:57 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15902.13445.441132.875876@argo.ozlabs.ibm.com>
Date: Fri, 10 Jan 2003 13:48:37 +1100
To: James Simmons <jsimmons@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix atyfb
X-Mailer: VM 7.07 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a patch which fixes a couple of problems in atyfb.

1. It was modifying the par structure in the check_var routine and not
   reading info->var in the set_par routine.

2. It was relying on info->var.accel_flags and consequently we were
   getting a situation where it was trying to use the drawing engine
   without having initialized it.  This caused my G3 powerbook to hang
   on boot when the console text got to the bottom of the screen and
   it tried to scroll.  I have added an accel_flags field to the par
   structure so that the driver can control when it starts and stops
   using acceleration.  I also added code to the accelerated drawing
   routines so that they will fall back to the cfb routines if
   acceleration is disabled.

3. It was accessing the pseudo_palette as 16-bit quantities in 15/16
   bpp mode rather than as u32.

The driver generally is badly formatted, particularly in the
atyfb_init routine, which is very long and should be split up.  James,
would you accept a patch to split up atyfb_init and fix the
formatting?

Paul.

diff -urN linux-2.5/drivers/video/aty/atyfb.h pmac-2.5/drivers/video/aty/atyfb.h
--- linux-2.5/drivers/video/aty/atyfb.h	2002-11-24 06:49:51.000000000 +1100
+++ pmac-2.5/drivers/video/aty/atyfb.h	2003-01-01 22:15:45.000000000 +1100
@@ -79,6 +79,7 @@
 	u8 ram_type;
 	u8 mem_refresh_rate;
 	u8 blitter_may_be_busy;
+	u32 accel_flags;
 #ifdef __sparc__
 	struct pci_mmap_map *mmap_map;
 	u8 mmaped;
diff -urN linux-2.5/drivers/video/aty/atyfb_base.c pmac-2.5/drivers/video/aty/atyfb_base.c
--- linux-2.5/drivers/video/aty/atyfb_base.c	2002-12-22 09:07:14.000000000 +1100
+++ pmac-2.5/drivers/video/aty/atyfb_base.c	2003-01-10 13:41:01.000000000 +1100
@@ -173,9 +173,6 @@
 			   struct crtc *crtc);
 static int aty_crtc_to_var(const struct crtc *crtc,
 			   struct fb_var_screeninfo *var);
-static int atyfb_encode_var(struct fb_var_screeninfo *var,
-			    const struct atyfb_par *par,
-			    const struct fb_info *info);
 static void set_off_pitch(struct atyfb_par *par,
 			  const struct fb_info *info);
 #ifdef CONFIG_PPC
@@ -772,11 +769,17 @@
 static int atyfb_set_par(struct fb_info *info)
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
-	int accelmode;
+	struct fb_var_screeninfo *var = &info->var;
 	u8 tmp;
 	u32 i;
+	int err;
 
-	accelmode = info->var.accel_flags;	/* hack */
+	if ((err = aty_var_to_crtc(info, var, &par->crtc)) ||
+	    (err = par->pll_ops->var_to_pll(info, var->pixclock,
+					var->bits_per_pixel, &par->pll)))
+		return err;
+
+	par->accel_flags = var->accel_flags;	/* hack */
 
 	if (par->blitter_may_be_busy)
 		wait_for_idle(par);
@@ -786,13 +789,14 @@
 	/* better call aty_StrobeClock ?? */
 	aty_st_8(CLOCK_CNTL + par->clk_wr_offset, CLOCK_STROBE, par);
 
-	par->dac_ops->set_dac(info, &par->pll, info->var.bits_per_pixel, accelmode);
+	par->dac_ops->set_dac(info, &par->pll, var->bits_per_pixel,
+			      par->accel_flags);
 	par->pll_ops->set_pll(info, &par->pll);
 
 	if (!M64_HAS(INTEGRATED)) {
 		/* Don't forget MEM_CNTL */
 		i = aty_ld_le32(MEM_CNTL, par) & 0xf0ffffff;
-		switch (info->var.bits_per_pixel) {
+		switch (var->bits_per_pixel) {
 		case 8:
 			i |= 0x02000000;
 			break;
@@ -808,7 +812,7 @@
 		i = aty_ld_le32(MEM_CNTL, par) & 0xf00fffff;
 		if (!M64_HAS(MAGIC_POSTDIV))
 			i |= par->mem_refresh_rate << 20;
-		switch (info->var.bits_per_pixel) {
+		switch (var->bits_per_pixel) {
 		case 8:
 		case 24:
 			i |= 0x00000000;
@@ -841,20 +845,20 @@
 	}
 	aty_st_8(DAC_MASK, 0xff, par);
 
-	info->fix.line_length = info->var.xres_virtual * info->var.bits_per_pixel/8;
-	info->fix.visual = info->var.bits_per_pixel <= 8 ? FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_DIRECTCOLOR;
+	info->fix.line_length = var->xres_virtual * var->bits_per_pixel/8;
+	info->fix.visual = var->bits_per_pixel <= 8 ?
+		FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_DIRECTCOLOR;
 
 	/* Initialize the graphics engine */
-	if (info->var.accel_flags & FB_ACCELF_TEXT)
+	if (par->accel_flags & FB_ACCELF_TEXT)
 		aty_init_engine(par, info);
 
 #ifdef CONFIG_BOOTX_TEXT
 	btext_update_display(info->fix.smem_start,
-			     (((par->crtc.h_tot_disp >> 16) & 0xff) +
-			      1) * 8,
+			     (((par->crtc.h_tot_disp >> 16) & 0xff) + 1) * 8,
 			     ((par->crtc.v_tot_disp >> 16) & 0x7ff) + 1,
-			     info->var.bits_per_pixel,
-			     par->crtc.vxres * info->var.bits_per_pixel / 8);
+			     var->bits_per_pixel,
+			     par->crtc.vxres * var->bits_per_pixel / 8);
 #endif				/* CONFIG_BOOTX_TEXT */
 	return 0;
 }
@@ -863,41 +867,24 @@
 			   struct fb_info *info)
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
+	struct crtc crtc;
+	union aty_pll pll;
 	int err;
 
-	if ((err = aty_var_to_crtc(info, var, &par->crtc)) ||
-	    (err =
-	     par->pll_ops->var_to_pll(info, var->pixclock, var->bits_per_pixel,
-				       &par->pll)))
+	if ((err = aty_var_to_crtc(info, var, &crtc)) ||
+	    (err = par->pll_ops->var_to_pll(info, var->pixclock,
+					var->bits_per_pixel, &pll)))
 		return err;
 
-#if 0				/* fbmon is not done. uncomment for 2.5.x -brad */
+#if 0	/* fbmon is not done. uncomment for 2.5.x -brad */
 	if (!fbmon_valid_timings(var->pixclock, htotal, vtotal, info))
 		return -EINVAL;
 #endif
-	atyfb_encode_var(var, par, info);
-	return 0;
-}
-
-static int atyfb_encode_var(struct fb_var_screeninfo *var,
-			    const struct atyfb_par *par,
-			    const struct fb_info *info)
-{
-	int err;
-
-	memset(var, 0, sizeof(struct fb_var_screeninfo));
-
-	if ((err = aty_crtc_to_var(&par->crtc, var)))
-		return err;
-	var->pixclock = par->pll_ops->pll_to_var(info, &par->pll);
-
-	var->height = -1;
-	var->width = -1;
+	aty_crtc_to_var(&crtc, var);
+	var->pixclock = par->pll_ops->pll_to_var(info, &pll);
 	return 0;
 }
 
-
-
 static void set_off_pitch(struct atyfb_par *par,
 			  const struct fb_info *info)
 {
@@ -1410,7 +1397,7 @@
 	for (info = first_display; info != NULL; info = par->next) {
 		int nb;
 
-		par = (struct atyfb_par *) info->fb.par;
+		par = (struct atyfb_par *) info->par;
 		nb = info->var.yres * info->fix.line_length;
 
 		switch (when) {
@@ -1429,7 +1416,7 @@
 			if (par->blitter_may_be_busy)
 				wait_for_idle(par);
 			/* Stop accel engine (stop bus mastering) */
-			if (info->accel_flags & FB_ACCELF_TEXT)
+			if (par->accel_flags & FB_ACCELF_TEXT)
 				aty_reset_engine(par);
 
 			/* Backup fb content */
@@ -2306,9 +2293,7 @@
 
 #ifdef CONFIG_PMAC_PBOOK
 			if (first_display == NULL)
-				pmu_register_sleep_notifier
-				    (&aty_sleep_notifier);
-			/* FIXME info->next = first_display; */
+				pmu_register_sleep_notifier(&aty_sleep_notifier);
 			default_par->next = first_display;
 #endif
 		}
@@ -2346,7 +2331,7 @@
 		info->fix.smem_start = info->screen_base;	/* Fake! */
 		default_par->ati_regbase = (unsigned long)ioremap(phys_guiregbase[m64_num],
 							  0x10000) + 0xFC00ul;
-		info->fix.mmio_start = par->ati_regbase; /* Fake! */
+		info->fix.mmio_start = default_par->ati_regbase; /* Fake! */
 
 		aty_st_le32(CLOCK_CNTL, 0x12345678, default_par);
 		clock_r = aty_ld_le32(CLOCK_CNTL, default_par);
@@ -2544,6 +2529,7 @@
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 	int i, scale;
+	u32 *pal = info->pseudo_palette;
 
 	if (regno > 255)
 		return 1;
@@ -2570,17 +2556,14 @@
 	if (regno < 16)
 		switch (info->var.bits_per_pixel) {
 		case 16:
-			((u16 *) (info->pseudo_palette))[regno] =
-			    (regno << 10) | (regno << 5) | regno;
+			pal[regno] = (regno << 10) | (regno << 5) | regno;
 			break;
 		case 24:
-			((u32 *) (info->pseudo_palette))[regno] =
-			    (regno << 16) | (regno << 8) | regno;
+			pal[regno] = (regno << 16) | (regno << 8) | regno;
 			break;
 		case 32:
 			i = (regno << 8) | regno;
-			((u32 *) (info->pseudo_palette))[regno] =
-			    (i << 16) | i;
+			pal[regno] = (i << 16) | i;
 			break;
 		}
 	return 0;
diff -urN linux-2.5/drivers/video/aty/mach64_accel.c pmac-2.5/drivers/video/aty/mach64_accel.c
--- linux-2.5/drivers/video/aty/mach64_accel.c	2002-08-08 07:29:36.000000000 +1000
+++ pmac-2.5/drivers/video/aty/mach64_accel.c	2003-01-01 22:36:44.000000000 +1100
@@ -179,6 +179,12 @@
 
 	if (!area->width || !area->height)
 		return;
+	if (!par->accel_flags) {
+		if (par->blitter_may_be_busy)
+			wait_for_idle(par);
+		cfb_copyarea(info, area);
+		return;
+	}
 
 	pitch_value = info->var.xres_virtual;
 	if (info->var.bits_per_pixel == 24) {
@@ -216,6 +222,12 @@
 
 	if (!rect->width || !rect->height)
 		return;
+	if (!par->accel_flags) {
+		if (par->blitter_may_be_busy)
+			wait_for_idle(par);
+		cfb_fillrect(info, rect);
+		return;
+	}
 
 	rect->color |= (rect->color << 8);
 	rect->color |= (rect->color << 16);
