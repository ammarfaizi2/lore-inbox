Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318282AbSHSLKJ>; Mon, 19 Aug 2002 07:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318324AbSHSLKJ>; Mon, 19 Aug 2002 07:10:09 -0400
Received: from dp.samba.org ([66.70.73.150]:49133 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S318282AbSHSLKF>;
	Mon, 19 Aug 2002 07:10:05 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15712.53828.474743.657355@argo.ozlabs.ibm.com>
Date: Mon, 19 Aug 2002 21:11:00 +1000 (EST)
To: James Simmons <jsimmons@infradead.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-fbdev-devel@lists.sourceforge.net>
Subject: [PATCH] fixes for atyfb
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a number of problems in atyfb.

- atyfb_encode_var was zeroing the whole var struct, which meant that
  var.accel_flags got cleared, which meant that aty_init_engine didn't
  get called, which meant that atyfb_fillrect and atyfb_copyarea
  caused the chip to hang.

- par needs to be set inside the loop in aty_sleep_notify, since info
  is different each time around the loop.

- we weren't calling gen_set_disp to set up info->disp.

Paul.

diff -urN linux-2.5/drivers/video/aty/atyfb_base.c pmac-2.5/drivers/video/aty/atyfb_base.c
--- linux-2.5/drivers/video/aty/atyfb_base.c	Wed Aug 14 09:15:02 2002
+++ pmac-2.5/drivers/video/aty/atyfb_base.c	Mon Aug 19 12:08:33 2002
@@ -694,6 +694,13 @@
 	    (v_sync_pol ? 0 : FB_SYNC_VERT_HIGH_ACT) |
 	    (c_sync ? FB_SYNC_COMP_HIGH_ACT : 0);
 
+	var->red.msb_right = 0;
+	var->green.msb_right = 0;
+	var->blue.offset = 0;
+	var->blue.msb_right = 0;
+	var->transp.offset = 0;
+	var->transp.length = 0;
+	var->transp.msb_right = 0;
 	switch (pix_width) {
 #if 0
 	case CRTC_PIX_WIDTH_4BPP:
@@ -702,10 +709,7 @@
 		var->red.length = 8;
 		var->green.offset = 0;
 		var->green.length = 8;
-		var->blue.offset = 0;
 		var->blue.length = 8;
-		var->transp.offset = 0;
-		var->transp.length = 0;
 		break;
 #endif
 	case CRTC_PIX_WIDTH_8BPP:
@@ -714,10 +718,7 @@
 		var->red.length = 8;
 		var->green.offset = 0;
 		var->green.length = 8;
-		var->blue.offset = 0;
 		var->blue.length = 8;
-		var->transp.offset = 0;
-		var->transp.length = 0;
 		break;
 	case CRTC_PIX_WIDTH_15BPP:	/* RGB 555 */
 		bpp = 16;
@@ -725,10 +726,7 @@
 		var->red.length = 5;
 		var->green.offset = 5;
 		var->green.length = 5;
-		var->blue.offset = 0;
 		var->blue.length = 5;
-		var->transp.offset = 0;
-		var->transp.length = 0;
 		break;
 #if 0
 	case CRTC_PIX_WIDTH_16BPP:	/* RGB 565 */
@@ -737,10 +735,7 @@
 		var->red.length = 5;
 		var->green.offset = 5;
 		var->green.length = 6;
-		var->blue.offset = 0;
 		var->blue.length = 5;
-		var->transp.offset = 0;
-		var->transp.length = 0;
 		break;
 #endif
 	case CRTC_PIX_WIDTH_24BPP:	/* RGB 888 */
@@ -749,10 +744,7 @@
 		var->red.length = 8;
 		var->green.offset = 8;
 		var->green.length = 8;
-		var->blue.offset = 0;
 		var->blue.length = 8;
-		var->transp.offset = 0;
-		var->transp.length = 0;
 		break;
 	case CRTC_PIX_WIDTH_32BPP:	/* ARGB 8888 */
 		bpp = 32;
@@ -760,7 +752,6 @@
 		var->red.length = 8;
 		var->green.offset = 8;
 		var->green.length = 8;
-		var->blue.offset = 0;
 		var->blue.length = 8;
 		var->transp.offset = 24;
 		var->transp.length = 8;
@@ -870,8 +861,7 @@
 
 #ifdef CONFIG_BOOTX_TEXT
 	btext_update_display(info->fix.smem_start,
-			     (((par->crtc.h_tot_disp >> 16) & 0xff) +
-			      1) * 8,
+			     (((par->crtc.h_tot_disp >> 16) & 0xff) + 1) * 8,
 			     ((par->crtc.v_tot_disp >> 16) & 0x7ff) + 1,
 			     info->var.bits_per_pixel,
 			     par->crtc.vxres * info->var.bits_per_pixel / 8);
@@ -905,14 +895,13 @@
 {
 	int err;
 
-	memset(var, 0, sizeof(struct fb_var_screeninfo));
-
 	if ((err = aty_crtc_to_var(&par->crtc, var)))
 		return err;
 	var->pixclock = par->pll_ops->pll_to_var(info, &par->pll);
 
 	var->height = -1;
 	var->width = -1;
+	var->nonstd = 0;
 	return 0;
 }
 
@@ -1442,15 +1431,15 @@
 static int aty_sleep_notify(struct pmu_sleep_notifier *self, int when)
 {
 	struct fb_info *info;
-	struct atyfb_par *par = (struct atyfb_par *) info->fb.par;
+	struct atyfb_par *par;
 	int result;
 
 	result = PBOOK_SLEEP_OK;
 
 	for (info = first_display; info != NULL; info = par->next) {
-		struct fb_fix_screeninfo fix;
 		int nb;
 
+		par = (struct atyfb_par *) info->par;
 		nb = fb_display[fg_console].var.yres * info->fix.line_length;
 
 		switch (when) {
@@ -1469,7 +1458,7 @@
 			if (par->blitter_may_be_busy)
 				wait_for_idle(par);
 			/* Stop accel engine (stop bus mastering) */
-			if (par->accel_flags & FB_ACCELF_TEXT)
+			if (info->var.accel_flags & FB_ACCELF_TEXT)
 				aty_reset_engine(par);
 
 			/* Backup fb content */
@@ -1848,7 +1837,6 @@
 	strcpy(info->modename, info->fix.id);
 	info->node = NODEV;
 	info->fbops = &atyfb_ops;
-	info->disp = disp;
 	info->pseudo_palette = pseudo_palette;
 	info->currcon = -1;
 	strcpy(info->fontname, fontname);
@@ -1978,7 +1966,9 @@
 	info->var = var;
 
 	fb_alloc_cmap(&info->cmap, 256, 0);
+	gen_set_disp(-1, info);
 
+	var.activate = FB_ACTIVATE_NOW;
 	gen_set_var(&var, -1, info);
 
 	if (register_framebuffer(info) < 0)
@@ -2383,7 +2373,6 @@
 			if (first_display == NULL)
 				pmu_register_sleep_notifier
 				    (&aty_sleep_notifier);
-			/* FIXME info->next = first_display; */
 			default_par->next = first_display;
 #endif
 		}
@@ -2410,7 +2399,7 @@
 			return -ENOMEM;
 		}
 		memset(info, 0, sizeof(struct fb_info));
-		info->fix = atyfb_fix;		
+		info->fix = atyfb_fix;
 
 		/*
 		 *  Map the video memory (physical address given) to somewhere in the
@@ -2421,7 +2410,7 @@
 		info->fix.smem_start = info->screen_base;	/* Fake! */
 		default_par->ati_regbase = (unsigned long)ioremap(phys_guiregbase[m64_num],
 							  0x10000) + 0xFC00ul;
-		info->fix.mmio_start = par->ati_regbase; /* Fake! */
+		info->fix.mmio_start = default_par->ati_regbase; /* Fake! */
 
 		aty_st_le32(CLOCK_CNTL, 0x12345678, default_par);
 		clock_r = aty_ld_le32(CLOCK_CNTL, default_par);
