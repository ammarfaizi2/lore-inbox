Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265736AbSJTCTh>; Sat, 19 Oct 2002 22:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265737AbSJTCTh>; Sat, 19 Oct 2002 22:19:37 -0400
Received: from pfaff.Stanford.EDU ([128.12.189.154]:7296 "EHLO
	pfaff.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S265736AbSJTCTe>; Sat, 19 Oct 2002 22:19:34 -0400
To: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
CC: Samuele Kaplun <kaplun@inwind.it>
Subject: patch: fix vga16fb to work in 2.5.x
Reply-To: blp@cs.stanford.edu
From: Ben Pfaff <blp@cs.stanford.edu>
Date: 19 Oct 2002 19:22:35 -0700
Message-ID: <874rbhq26s.fsf@pfaff.Stanford.EDU>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a patch, along the lines of the differences between vesafb
between 2.4.19 and 2.5.44, that makes vga16fb work for me under
2.5.x.  I don't get a penguin at boot-up, but I don't get one
with vesafb either, and everything else seems to work.

--- linux-2.5.44/drivers/video/vga16fb.c	2002-10-18 21:01:19.000000000 -0700
+++ linux-2.5.44-work/drivers/video/vga16fb.c	2002-10-19 17:04:32.000000000 -0700
@@ -22,6 +22,7 @@
 #include <linux/selection.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 
 #include <asm/io.h>
 
@@ -81,22 +82,33 @@
 /* --------------------------------------------------------------------- */
 
 static struct fb_var_screeninfo vga16fb_defined = {
-	640,480,640,480,/* W,H, W, H (virtual) load xres,xres_virtual*/
-	0,0,		/* virtual -> visible no offset */
-	4,		/* depth -> load bits_per_pixel */
-	0,		/* greyscale ? */
-	{0,0,0},	/* R */
-	{0,0,0},	/* G */
-	{0,0,0},	/* B */
-	{0,0,0},	/* transparency */
-	0,		/* standard pixel format */
-	FB_ACTIVATE_NOW,
-	-1,-1,
-	0,
-	39721, 48, 16, 39, 8,
-	96, 2, 0,	/* No sync info */
-	FB_VMODE_NONINTERLACED,
-	{0,0,0,0,0,0}
+        .xres           = 640,
+        .yres           = 480,
+        .xres_virtual   = 640,
+        .yres_virtual   = 480,
+        .bits_per_pixel = 4,
+        .activate       = FB_ACTIVATE_NOW,
+        .height         = -1,
+        .width          = -1,
+        .pixclock       = 39721,
+        .left_margin    = 48,
+        .right_margin   = 16,
+        .upper_margin   = 39,
+        .lower_margin   = 8,
+        .hsync_len      = 96,
+        .vsync_len      = 2,
+        .vmode          = FB_VMODE_NONINTERLACED,
+};
+
+static struct fb_fix_screeninfo vga16fb_fix __initdata = {
+        .id             = "VGA16 VGA",
+        .smem_start     = VGA_FB_PHYS,
+        .smem_len       = VGA_FB_PHYS_LEN,
+        .type           = FB_TYPE_VGA_PLANES,
+        .visual         = FB_VISUAL_PSEUDOCOLOR,
+        .xpanstep       = 8,
+        .ypanstep       = 1,
+        .line_length    = 640 / 8,
 };
 
 static struct display disp;
@@ -121,69 +133,22 @@
 #endif
 }
 
-static int vga16fb_update_var(int con, struct fb_info *info)
-{
-	vga16fb_pan_var(info, &fb_display[con].var);
-	return 0;
-}
-
-static int vga16fb_get_fix(struct fb_fix_screeninfo *fix, int con,
-			   struct fb_info *info)
-{
-	struct display *p;
-
-	if (con < 0)
-		p = &disp;
-	else
-		p = fb_display + con;
-
-	memset(fix, 0, sizeof(struct fb_fix_screeninfo));
-	strcpy(fix->id,"VGA16 VGA");
-
-	fix->smem_start = VGA_FB_PHYS;
-	fix->smem_len = VGA_FB_PHYS_LEN;
-	fix->type = FB_TYPE_VGA_PLANES;
-	fix->visual = FB_VISUAL_PSEUDOCOLOR;
-	fix->xpanstep  = 8;
-	fix->ypanstep  = 1;
-	fix->ywrapstep = 0;
-	fix->line_length = p->var.xres_virtual / 8;
-	return 0;
-}
-
-static int vga16fb_get_var(struct fb_var_screeninfo *var, int con,
-			 struct fb_info *info)
-{
-	if(con==-1)
-		memcpy(var, &vga16fb_defined, sizeof(struct fb_var_screeninfo));
-	else
-		*var=fb_display[con].var;
-	return 0;
-}
-
 static void vga16fb_set_disp(int con, struct vga16fb_info *info)
 {
-	struct fb_fix_screeninfo fix;
-	struct display *display;
-
-	if (con < 0)
-		display = &disp;
-	else
-		display = fb_display + con;
+        struct display *display = (con < 0) ? info->fb_info.disp : (fb_display + con);
 
-	
-	vga16fb_get_fix(&fix, con, &info->fb_info);
-
-	display->visual = fix.visual;
-	display->type = fix.type;
-	display->type_aux = fix.type_aux;
-	display->ypanstep = fix.ypanstep;
-	display->ywrapstep = fix.ywrapstep;
-	display->line_length = fix.line_length;
-	display->next_line = fix.line_length;
 	display->can_soft_blank = 1;
+        display->dispsw_data = NULL;
+        display->var = info->fb_info.var;
 	display->inverse = 0;
 
+        /*
+         * If we are setting all the virtual consoles, also set
+         * the defaults used to create new consoles.
+         */
+        if (con < 0 || info->fb_info.var.activate & FB_ACTIVATE_ALL)
+                info->fb_info.disp->var = info->fb_info.var;
+
 	if (info->isVGA)
 		display->dispsw = &fbcon_vga_planes;
 	else
@@ -500,13 +465,9 @@
 {
 	struct vga16fb_info *info = (struct vga16fb_info*)fb;
 	struct vga16fb_par par;
-	struct display *display;
+        struct display *display = (con < 0) ? fb->disp : (fb_display + con);
 	int err;
 
-	if (con < 0)
-		display = fb->disp;
-	else
-		display = fb_display + con;
 	if ((err = vga16fb_decode_var(var, &par, info)) != 0)
 		return err;
 	vga16fb_encode_var(var, &par, info);
@@ -552,25 +513,6 @@
 	outb_p(0x20, 0x3C0); /* unblank screen */
 }
 
-static int vga16_getcolreg(unsigned regno, unsigned *red, unsigned *green,
-			  unsigned *blue, unsigned *transp,
-			  struct fb_info *fb_info)
-{
-	/*
-	 *  Read a single color register and split it into colors/transparent.
-	 *  Return != 0 for invalid regno.
-	 */
-
-	if (regno >= 16)
-		return 1;
-
-	*red   = palette[regno].red;
-	*green = palette[regno].green;
-	*blue  = palette[regno].blue;
-	*transp = 0;
-	return 0;
-}
-
 static void vga16_setpalette(int regno, unsigned red, unsigned green, unsigned blue)
 {
 	outb(regno,       dac_reg);
@@ -615,19 +557,6 @@
 	return 0;
 }
 
-static int vga16fb_get_cmap(struct fb_cmap *cmap, int kspc, int con,
-			   struct fb_info *info)
-{
-	if (con == info->currcon) /* current console? */
-		return fb_get_cmap(cmap, kspc, vga16_getcolreg, info);
-	else if (fb_display[con].cmap.len) /* non default colormap? */
-		fb_copy_cmap(&fb_display[con].cmap, cmap, kspc ? 0 : 2);
-	else
-		fb_copy_cmap(fb_default_cmap(16),
-		     cmap, kspc ? 0 : 2);
-	return 0;
-}
-
 static int vga16fb_pan_display(struct fb_var_screeninfo *var, int con,
 			       struct fb_info *info) 
 {
@@ -811,10 +740,8 @@
 
 static struct fb_ops vga16fb_ops = {
 	.owner =	THIS_MODULE,
-	.fb_get_fix =	vga16fb_get_fix,
-	.fb_get_var =	vga16fb_get_var,
 	.fb_set_var =	vga16fb_set_var,
-	.fb_get_cmap =	vga16fb_get_cmap,
+	.fb_get_cmap =	gen_get_cmap,
 	.fb_set_cmap =	gen_set_cmap,
 	.fb_setcolreg =	vga16fb_setcolreg,
 	.fb_pan_display =vga16fb_pan_display,
@@ -839,27 +766,6 @@
 	return 0;
 }
 
-static int vga16fb_switch(int con, struct fb_info *fb)
-{
-	struct vga16fb_par par;
-	struct vga16fb_info *info = (struct vga16fb_info*)fb;
-
-	/* Do we have to save the colormap? */
-	if (fb_display[fb->currcon].cmap.len)
-		fb_get_cmap(&fb_display[fb->currcon].cmap, 1, vga16_getcolreg,
-			    fb);
-	
-	fb->currcon = con;
-	vga16fb_decode_var(&fb_display[con].var, &par, info);
-	vga16fb_set_par(&par, info);
-	vga16fb_set_disp(con, info);
-
-	/* Install new colormap */
-	do_install_cmap(con, fb);
-/*	vga16fb_update_var(con, fb); */
-	return 1;
-}
-
 int __init vga16fb_init(void)
 {
 	int i,j;
@@ -895,19 +801,22 @@
 
 	disp.var = vga16fb_defined;
 
-	/* name should not depend on EGA/VGA */
-	strcpy(vga16fb.fb_info.modename, "VGA16 VGA");
+	strcpy(vga16fb.fb_info.modename, vga16fb_fix.id);
 	vga16fb.fb_info.changevar = NULL;
 	vga16fb.fb_info.node = NODEV;
+        vga16fb.fb_info.var = vga16fb_defined;
+        vga16fb.fb_info.fix = vga16fb_fix;
 	vga16fb.fb_info.fbops = &vga16fb_ops;
 	vga16fb.fb_info.screen_base = vga16fb.video_vbase;
 	vga16fb.fb_info.disp=&disp;
 	vga16fb.fb_info.currcon = -1;
-	vga16fb.fb_info.switch_con=&vga16fb_switch;
-	vga16fb.fb_info.updatevar=&vga16fb_update_var;
+	vga16fb.fb_info.switch_con=&gen_switch;
+	vga16fb.fb_info.updatevar=&gen_update_var;
 	vga16fb.fb_info.flags=FBINFO_FLAG_DEFAULT;
 	vga16fb_set_disp(-1, &vga16fb);
 
+	fb_alloc_cmap(&vga16fb.fb_info.cmap, 16, 0);
+
 	if (register_framebuffer(&vga16fb.fb_info)<0) {
 		iounmap(vga16fb.video_vbase);
 		return -EINVAL;


-- 
Aim to please, shoot to kill.
