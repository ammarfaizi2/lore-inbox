Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbTEQU1X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 16:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbTEQU1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 16:27:23 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:13322 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261819AbTEQU1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 16:27:01 -0400
Date: Sat, 17 May 2003 21:39:41 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Dreamcast framebuffer updates.
Message-ID: <Pine.LNX.4.44.0305172138420.19598-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch updates the Dreamcast framebuffer to the new api. Please apply.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1113.1.1 -> 1.1113.1.2
#	drivers/video/pvr2fb.c	1.14    -> 1.15   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/14	jsimmons@maxwell.earthlink.net	1.1113.1.2
# [PVR2 FBDEV] Port of the Dreamcast Frambuffer to the new api.
# --------------------------------------------
#
diff -Nru a/drivers/video/pvr2fb.c b/drivers/video/pvr2fb.c
--- a/drivers/video/pvr2fb.c	Sat May 17 13:27:54 2003
+++ b/drivers/video/pvr2fb.c	Sat May 17 13:27:54 2003
@@ -4,7 +4,7 @@
  * Dreamcast.
  *
  * Copyright (c) 2001 M. R. Brown <mrbrown@0xd6.org>
- * Copyright (c) 2001 Paul Mundt  <lethal@chaoticdreams.org>
+ * Copyright (c) 2001, 2002, 2003 Paul Mundt <lethal@linux-sh.org>
  *
  * This file is part of the LinuxDC project (linuxdc.sourceforge.net).
  *
@@ -12,14 +12,15 @@
 
 /*
  * This driver is mostly based on the excellent amifb and vfb sources.  It uses
- * an odd scheme for converting hardware values to/from framebuffer values, here are
- * some hacked-up formulas:
+ * an odd scheme for converting hardware values to/from framebuffer values,
+ * here are some hacked-up formulas:
  *
- *  The Dreamcast has screen offsets from each side of its four borders and the start
- *  offsets of the display window.  I used these values to calculate 'pseudo' values
- *  (think of them as placeholders) for the fb video mode, so that when it came time
- *  to convert these values back into their hardware values, I could just add mode-
- *  specific offsets to get the correct mode settings:
+ *  The Dreamcast has screen offsets from each side of its four borders and
+ *  the start offsets of the display window.  I used these values to calculate
+ *  'pseudo' values (think of them as placeholders) for the fb video mode, so
+ *  that when it came time to convert these values back into their hardware
+ *  values, I could just add mode- specific offsets to get the correct mode
+ *  settings:
  *
  *      left_margin = diwstart_h - borderstart_h;
  *      right_margin = borderstop_h - (diwstart_h + xres);
@@ -29,9 +30,9 @@
  *      hsync_len = borderstart_h + (hsync_total - borderstop_h);
  *      vsync_len = borderstart_v + (vsync_total - borderstop_v);
  *
- *  Then, when it's time to convert back to hardware settings, the only constants
- *  are the borderstart_* offsets, all other values are derived from the fb video
- *  mode:
+ *  Then, when it's time to convert back to hardware settings, the only
+ *  constants are the borderstart_* offsets, all other values are derived from
+ *  the fb video mode:
  *  
  *      // PAL
  *      borderstart_h = 116;
@@ -57,7 +58,6 @@
 #include <linux/interrupt.h>
 #include <linux/fb.h>
 #include <linux/init.h>
-#include <linux/console.h>
 
 #ifdef CONFIG_SH_DREAMCAST
 #include <asm/io.h>
@@ -66,14 +66,9 @@
 #endif
 
 #ifdef CONFIG_MTRR
-  #include <asm/mtrr.h>
+#include <asm/mtrr.h>
 #endif
 
-#include <video/fbcon.h>
-#include <video/fbcon-cfb16.h>
-#include <video/fbcon-cfb24.h>
-#include <video/fbcon-cfb32.h>
-
 #ifdef CONFIG_FB_PVR2_DEBUG
 #  define DPRINTK(fmt, args...) printk(KERN_DEBUG "%s: " fmt, __FUNCTION__ , ## args)
 #else
@@ -124,16 +119,6 @@
  */
 
 static struct pvr2fb_par {
-
-	int xres;
-	int yres;
-	int vxres;
-	int vyres;
-	int xoffset;
-	int yoffset;
-	u_short bpp;
-
-	u_long pixclock;
 	u_short hsync_total;	/* Clocks/line */
 	u_short vsync_total;	/* Lines/field */
 	u_short borderstart_h;
@@ -144,38 +129,37 @@
 	u_short diwstart_v;	/* Vertical offset of the display field, for
 				   interlaced modes, this is the long field */
 	u_long disp_start;	/* Address of image within VRAM */
-
-	u_long next_line;	/* Modulo for next line */
-
 	u_char is_interlaced;	/* Is the display interlaced? */
 	u_char is_doublescan;	/* Are scanlines output twice? (doublescan) */
 	u_char is_lowres;	/* Is horizontal pixel-doubling enabled? */
+} *currentpar;
 
-	u_long bordercolor;	/* RGB888 format border color */
-
-	u_long vmode;
-	
-} currentpar;
-
-static int currbpp;
-static struct display disp;
-static struct fb_info fb_info;
+static struct fb_info *fb_info;
 static int pvr2fb_inverse = 0;
 
-static struct { u_short red, green, blue, alpha; } palette[256];
-static union {
-#ifdef FBCON_HAS_CFB16
-	u16 cfb16[16];
-#endif
-#ifdef FBCON_HAS_CFB24
-	u32 cfb24[16];
-#endif
-#ifdef FBCON_HAS_CFB32
-	u32 cfb32[16];
-#endif
-} fbcon_cmap;
+static struct fb_fix_screeninfo pvr2_fix __initdata = {
+	.id =		"NEC PowerVR2",
+	.type = 	FB_TYPE_PACKED_PIXELS,
+	.visual = 	FB_VISUAL_TRUECOLOR,
+	.ypanstep =	1,
+	.ywrapstep =	1,
+	.accel = 	FB_ACCEL_NONE,
+};
 
-static char pvr2fb_name[16] = "NEC PowerVR2";
+static struct fb_var_screeninfo pvr2_var __initdata = {
+	.xres =		640,
+	.yres =		480,
+	.xres_virtual =	640,
+	.yres_virtual = 480,
+	.bits_per_pixel	=16,
+	.red =		{ 11, 5, 0 },
+	.green =	{  5, 6, 0 },
+	.blue =		{  0, 5, 0 },
+	.activate =	FB_ACTIVATE_NOW,
+	.height =	-1,
+	.width =	-1,
+	.vmode =	FB_VMODE_NONINTERLACED,
+};
 
 #define VIDEOMEMSIZE (8*1024*1024)
 static u_long videomemory = 0xa5000000, videomemorysize = VIDEOMEMSIZE;
@@ -187,10 +171,12 @@
 static int mtrr_handle;
 #endif
 
+static int nopan = 0;
+static int nowrap = 1;
+
 /*
  * We do all updating, blanking, etc. during the vertical retrace period
  */
-
 static u_short do_vmode_full = 0;	/* Change the video mode */
 static u_short do_vmode_pan = 0;	/* Update the video mode */
 static short do_blank = 0;		/* (Un)Blank the screen */
@@ -201,50 +187,15 @@
 
 int pvr2fb_setup(char*);
 
-static int pvr2fb_get_fix(struct fb_fix_screeninfo *fix, int con,
-                            struct fb_info *info);
-static int pvr2fb_get_var(struct fb_var_screeninfo *var, int con,
-                            struct fb_info *info);
-static int pvr2fb_set_var(struct fb_var_screeninfo *var, int con,
-                            struct fb_info *info);
-static int pvr2fb_pan_display(struct fb_var_screeninfo *var, int con,
-                                struct fb_info *info);
-static int pvr2fb_get_cmap(struct fb_cmap *cmap, int kspc, int con,
-                             struct fb_info *info);
-static int pvr2fb_set_cmap(struct fb_cmap *cmap, int kspc, int con,
-                             struct fb_info *info);
 static int pvr2fb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
                             u_int transp, struct fb_info *info);
 static int pvr2fb_blank(int blank, struct fb_info *info);
-
-	/*
-	 * Interface to the low level console driver
-	 */
-
-static int pvr2fbcon_switch(int con, struct fb_info *info);
-static int pvr2fbcon_updatevar(int con, struct fb_info *info);
-
-	/*
-	 * Internal/hardware-specific routines
-	 */
-
 static u_long get_line_length(int xres_virtual, int bpp);
 static void set_color_bitfields(struct fb_var_screeninfo *var);
-static int pvr2_getcolreg(u_int regno, u_int *red, u_int *green, u_int *blue,
-                            u_int *transp, struct fb_info *info);
-
-static int pvr2_encode_fix(struct fb_fix_screeninfo *fix,
-                             struct pvr2fb_par *par);
-static int pvr2_decode_var(struct fb_var_screeninfo *var,
-                          struct pvr2fb_par *par);
-static int pvr2_encode_var(struct fb_var_screeninfo *var,
-                          struct pvr2fb_par *par);
-static void pvr2_get_par(struct pvr2fb_par *par);
-static void pvr2_set_var(struct fb_var_screeninfo *var);
-static void pvr2_pan_var(struct fb_var_screeninfo *var);
-static int pvr2_update_par(void);
-static void pvr2_update_display(void);
-static void pvr2_init_display(void);
+static int pvr2fb_check_var(struct fb_var_screeninfo *var, struct fb_info *info);
+static int pvr2fb_set_par(struct fb_info *info);
+static void pvr2_update_display(struct fb_info *info);
+static void pvr2_init_display(struct fb_info *info);
 static void pvr2_do_blank(void);
 static irqreturn_t pvr2fb_interrupt(int irq, void *dev_id, struct pt_regs *fp);
 static int pvr2_init_cable(void);
@@ -252,19 +203,18 @@
                             int val, int size);
 
 static struct fb_ops pvr2fb_ops = {
-	.owner =	THIS_MODULE,
-	.fb_get_fix =	pvr2fb_get_fix,
-	.fb_get_var =	pvr2fb_get_var,
-	.fb_set_var =	pvr2fb_set_var,
-	.fb_get_cmap =	pvr2fb_get_cmap,
-	.fb_set_cmap =	pvr2fb_set_cmap,
-	.fb_setcolreg =	pvr2fb_setcolreg,
-	.fb_pan_display = pvr2fb_pan_display,
-	.fb_blank =	pvr2fb_blank,
+	.owner 		= THIS_MODULE,
+	.fb_setcolreg 	= pvr2fb_setcolreg,
+	.fb_blank 	= pvr2fb_blank,
+	.fb_check_var 	= pvr2fb_check_var,
+	.fb_set_par 	= pvr2fb_set_par,
+	.fb_fillrect 	= cfb_fillrect,
+	.fb_copyarea	= cfb_copyarea,
+	.fb_imageblit	= cfb_imageblit,
+	.fb_cursor	= soft_cursor,
 };
 
 static struct fb_videomode pvr2_modedb[] __initdata = {
-
     /*
      * Broadcast video modes (PAL and NTSC).  I'm unfamiliar with
      * PAL-M and PAL-N, but from what I've read both modes parallel PAL and
@@ -275,21 +225,16 @@
 	/* 640x480 @ 60Hz interlaced (NTSC) */
 	"ntsc_640x480i", 60, 640, 480, TV_CLK, 38, 33, 0, 18, 146, 26,
 	FB_SYNC_BROADCAST, FB_VMODE_INTERLACED | FB_VMODE_YWRAP
-    },
-
-    {
+    }, {
 	/* 640x240 @ 60Hz (NTSC) */
 	/* XXX: Broken! Don't use... */
 	"ntsc_640x240", 60, 640, 240, TV_CLK, 38, 33, 0, 0, 146, 22,
 	FB_SYNC_BROADCAST, FB_VMODE_YWRAP
-    },
-
-    {
+    }, {
 	/* 640x480 @ 60hz (VGA) */
 	"vga_640x480", 60, 640, 480, VGA_CLK, 38, 33, 0, 18, 146, 26,
 	0, FB_VMODE_YWRAP
-    },
-
+    }, 
 };
 
 #define NUM_TOTAL_MODES  ARRAY_SIZE(pvr2_modedb)
@@ -301,222 +246,10 @@
 static int defmode = DEFMODE_NTSC;
 static char *mode_option __initdata = NULL;
 
-/* Get the fixed part of the display */
-
-static int pvr2fb_get_fix(struct fb_fix_screeninfo *fix, int con,
-                            struct fb_info *info)
-{
-	struct pvr2fb_par par;
-
-	if (con == -1)
-		pvr2_get_par(&par);
-	else {
-		int err;
-
-		if ((err = pvr2_decode_var(&fb_display[con].var, &par)))
-			return err;
-	}
-	return pvr2_encode_fix(fix, &par);
-}
-
-/* Get the user-defined part of the display */
-
-static int pvr2fb_get_var(struct fb_var_screeninfo *var, int con,
-                            struct fb_info *info)
-{
-	int err = 0;
-
-	if (con == -1) {
-		struct pvr2fb_par par;
-
-		pvr2_get_par(&par);
-		err = pvr2_encode_var(var, &par);
-	} else
-		*var = fb_display[con].var;
-	
-	return err;
-}
-
-/* Set the user-defined part of the display */
-
-static int pvr2fb_set_var(struct fb_var_screeninfo *var, int con,
-                            struct fb_info *info)
-{
-	int err, activate = var->activate;
-	int oldxres, oldyres, oldvxres, oldvyres, oldbpp;
-	struct pvr2fb_par par;
-
-	struct display *display;
-	if (con >= 0)
-		display = &fb_display[con];
-	else
-		display = &disp;        /* used during initialization */
-
-	/*
-	 * FB_VMODE_CONUPDATE and FB_VMODE_SMOOTH_XPAN are equal!
-	 * as FB_VMODE_SMOOTH_XPAN is only used internally
-	 */
-
-	if (var->vmode & FB_VMODE_CONUPDATE) {
-		var->vmode |= FB_VMODE_YWRAP;
-		var->xoffset = display->var.xoffset;
-		var->yoffset = display->var.yoffset;
-	}
-	if ((err = pvr2_decode_var(var, &par)))
-		return err;
-	pvr2_encode_var(var, &par);
-
-	/* Do memory check and bitfield set here?? */
-
-	if ((activate & FB_ACTIVATE_MASK) == FB_ACTIVATE_NOW) {
-		oldxres = display->var.xres;
-		oldyres = display->var.yres;
-		oldvxres = display->var.xres_virtual;
-		oldvyres = display->var.yres_virtual;
-		oldbpp = display->var.bits_per_pixel;
-		display->var = *var;
-		if (oldxres != var->xres || oldyres != var->yres ||
-		    oldvxres != var->xres_virtual || oldvyres != var->yres_virtual ||
-		    oldbpp != var->bits_per_pixel) {
-			struct fb_fix_screeninfo fix;
-
-			pvr2_encode_fix(&fix, &par);
-			display->scrollmode = SCROLL_YREDRAW;
-			display->visual = fix.visual;
-			display->type = fix.type;
-			display->type_aux = fix.type_aux;
-			display->ypanstep = fix.ypanstep;
-			display->ywrapstep = fix.ywrapstep;
-			display->line_length = fix.line_length;
-			display->can_soft_blank = 1;
-			display->inverse = pvr2fb_inverse;
-			switch (var->bits_per_pixel) {
-#ifdef FBCON_HAS_CFB16
-			    case 16:
-				display->dispsw = &fbcon_cfb16;
-				display->dispsw_data = fbcon_cmap.cfb16;
-				break;
-#endif
-#ifdef FBCON_HAS_CFB24
-			    case 24:
-				display->dispsw = &fbcon_cfb24;
-				display->dispsw_data = fbcon_cmap.cfb24;
-				break;
-#endif
-#ifdef FBCON_HAS_CFB32
-			    case 32:
-				display->dispsw = &fbcon_cfb32;
-				display->dispsw_data = fbcon_cmap.cfb32;
-				break;
-#endif
-			    default:
-				display->dispsw = &fbcon_dummy;
-				break;
-			}
-			if (fb_info.changevar)
-				(*fb_info.changevar)(con);
-		}
-		if (oldbpp != var->bits_per_pixel) {
-			if ((err = fb_alloc_cmap(&display->cmap, 0, 0)))
-				return err;
-			do_install_cmap(con, info);
-		}
-		if (con == info->currcon)
-			pvr2_set_var(&display->var);
-	}
-
-	return 0;
-}
-
-/*
- * Pan or wrap the display.
- * This call looks only at xoffset, yoffset and the FB_VMODE_YRAP flag
- */
-
-static int pvr2fb_pan_display(struct fb_var_screeninfo *var, int con,
-                                struct fb_info *info)
-{
-	if (var->vmode & FB_VMODE_YWRAP) {
-		if (var->yoffset<0 || var->yoffset >=
-		    fb_display[con].var.yres_virtual || var->xoffset)
-			return -EINVAL;
-	 } else {
-		if (var->xoffset+fb_display[con].var.xres >
-		    fb_display[con].var.xres_virtual ||
-		    var->yoffset+fb_display[con].var.yres >
-		    fb_display[con].var.yres_virtual)
-		    return -EINVAL;
-	}
-	if (con == info->currcon)
-		pvr2_pan_var(var);
-	fb_display[con].var.xoffset = var->xoffset;
-	fb_display[con].var.yoffset = var->yoffset;
-	if (var->vmode & FB_VMODE_YWRAP)
-		fb_display[con].var.vmode |= FB_VMODE_YWRAP;
-	else
-		fb_display[con].var.vmode &= ~FB_VMODE_YWRAP;
-			
-	return 0;
-}
-
-/* Get the colormap */
-
-static int pvr2fb_get_cmap(struct fb_cmap *cmap, int kspc, int con,
-                             struct fb_info *info)
-{
-	if (con == info->currcon) /* current console? */
-		return fb_get_cmap(cmap, kspc, pvr2_getcolreg, info);
-	else if (fb_display[con].cmap.len) /* non default colormap? */
-		fb_copy_cmap(&fb_display[con].cmap, cmap, kspc ? 0 : 2);
-	else
-		fb_copy_cmap(fb_default_cmap(1<<fb_display[con].var.bits_per_pixel),
-		             cmap, kspc ? 0 : 2);
-	return 0;
-}
-
-/* Set the colormap */
-
-static int pvr2fb_set_cmap(struct fb_cmap *cmap, int kspc, int con,
-	                     struct fb_info *info)
-{
-	int err;
-
-	if (!fb_display[con].cmap.len) {        /* no colormap allocated? */
-		if ((err = fb_alloc_cmap(&fb_display[con].cmap,
-		                         1<<fb_display[con].var.bits_per_pixel,
-					 0)))
-			 return err;
-	}
-	if (con == info->currcon)                     /* current console? */
-		return fb_set_cmap(cmap, kspc, info);
-	else
-		fb_copy_cmap(cmap, &fb_display[con].cmap, kspc ? 0 : 1);
-
-	return 0;
-}
-
-static int pvr2fbcon_switch(int con, struct fb_info *info)
-{
-	/* Do we have to save the colormap? */
-	if (fb_display[info->currcon].cmap.len)
-		fb_get_cmap(&fb_display[info->currcon].cmap, 1, pvr2_getcolreg, info);
-
-	info->currcon = con;
-	pvr2_set_var(&fb_display[con].var);
-	/* Install new colormap */
-	do_install_cmap(con, info);
-	return 0;
-}
-
-static int pvr2fbcon_updatevar(int con, struct fb_info *info)
-{
-	pvr2_pan_var(&fb_display[con].var);
-	return 0;
-}
-
 static int pvr2fb_blank(int blank, struct fb_info *info)
 {
 	do_blank = blank ? blank : -1;
+	return 0;
 }
 
 static inline u_long get_line_length(int xres_virtual, int bpp)
@@ -548,52 +281,29 @@
 	}
 }
 
-static int pvr2_getcolreg(u_int regno, u_int *red, u_int *green, u_int *blue,
-                            u_int *transp, struct fb_info *info)
-{
-	if (regno > 255)
-	    return 1;
-	
-	*red = palette[regno].red;
-	*green = palette[regno].green;
-	*blue = palette[regno].blue;
-	*transp = 0;
-	return 0;
-}
-	
 static int pvr2fb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
                             u_int transp, struct fb_info *info)
 {
 	if (regno > 255)
 		return 1;
 
-	palette[regno].red = red;
-	palette[regno].green = green;
-	palette[regno].blue = blue;
-
 	if (regno < 16) {
-		switch (currbpp) {
-#ifdef FBCON_HAS_CFB16
+		switch (info->var.bits_per_pixel) {
 		    case 16: /* RGB 565 */
-			fbcon_cmap.cfb16[regno] = (red & 0xf800) |
-			                          ((green & 0xfc00) >> 5) |
+			((u16*)(info->pseudo_palette))[regno] = (red & 0xf800) |
+						((green & 0xfc00) >> 5) |
 						  ((blue & 0xf800) >> 11);
 			break;
-#endif
-#ifdef FBCON_HAS_CFB24
 		    case 24: /* RGB 888 */
 			red >>= 8; green >>= 8; blue >>= 8;
-			fbcon_cmap.cfb24[regno] = (red << 16) | (green << 8) | blue;
+			((u32*)(info->pseudo_palette))[regno] = (red << 16) | (green << 8) | blue;
 			break;
-#endif
-#ifdef FBCON_HAS_CFB32
 		    case 32: /* ARGB 8888 */
 			red >>= 8; green >>= 8; blue >>= 8;
-			fbcon_cmap.cfb32[regno] = (red << 16) | (green << 8) | blue;
+			((u32*)(info->pseudo_palette))[regno] = (transp << 24) |(red << 16) | (green << 8) | blue;
 			break;
-#endif
 		    default:
-			DPRINTK("Invalid bit depth %d?!?\n", currbpp);
+			DPRINTK("Invalid bit depth %d?!?\n", info->var.bits_per_pixel);
 			return 1;
 		}
 	}
@@ -601,85 +311,33 @@
 	return 0;
 }
 
-
-static int pvr2_encode_fix(struct fb_fix_screeninfo *fix,
-                             struct pvr2fb_par *par)
-{
-	memset(fix, 0, sizeof(struct fb_fix_screeninfo));
-	strcpy(fix->id, pvr2fb_name);
-	fix->smem_start = videomemory;
-	fix->smem_len = videomemorysize;
-	fix->type = FB_TYPE_PACKED_PIXELS;
-	fix->type_aux = 0;
-	fix->visual = FB_VISUAL_TRUECOLOR;
-
-	if (par->vmode & FB_VMODE_YWRAP) {
-		fix->ywrapstep = 1;
-		fix->xpanstep = fix->ypanstep = 0;
-	} else {
-		fix->ywrapstep = 0;
-		fix->xpanstep = 1;
-		fix->ypanstep = 1;
-	}
-	fix->line_length = par->next_line;
-
-	return 0;
-}
-
-/*
- * Create a hardware video mode using the framebuffer values.  If a value needs
- * to be clipped or constrained it's done here.  This routine needs a bit more
- * work to make sure we're doing the right tests at the right time.
- */
-static int pvr2_decode_var(struct fb_var_screeninfo *var,
-                             struct pvr2fb_par *par)
+static int pvr2fb_set_par(struct fb_info *info)
 {
+	struct pvr2fb_par *par = (struct pvr2fb_par *)info->par;
+	struct fb_var_screeninfo *var = &info->var;
 	u_long line_length;
 	u_short vtotal;
 
-	if (var->pixclock != TV_CLK && var->pixclock != VGA_CLK) {
-		DPRINTK("Invalid pixclock value %d\n", var->pixclock);
-		return -EINVAL;
-	}
-	par->pixclock = var->pixclock;
-	
-	if ((par->xres = var->xres) < 320)
-		par->xres = 320;
-	if ((par->yres = var->yres) < 240)
-		par->yres = 240;
-	if ((par->vxres = var->xres_virtual) < par->xres)
-		par->vxres = par->xres;
-	if ((par->vyres = var->yres_virtual) < par->yres)
-		par->vyres = par->yres;
-
-	if ((par->bpp = var->bits_per_pixel) <= 16)
-		par->bpp = 16;
-	else if ((par->bpp = var->bits_per_pixel) <= 24)
-		par->bpp = 24;
-	else if ((par->bpp = var->bits_per_pixel) <= 32)
-		par->bpp = 32;
-
-	currbpp = par->bpp;
-
 	/*
 	 * XXX: It's possible that a user could use a VGA box, change the cable
-	 * type in hardware (i.e. switch from VGA<->composite), then change modes
-	 * (i.e. switching to another VT).  If that happens we should automagically
-	 * change the output format to cope, but currently I don't have a VGA box
-	 * to make sure this works properly.
+	 * type in hardware (i.e. switch from VGA<->composite), then change
+	 * modes (i.e. switching to another VT).  If that happens we should
+	 * automagically change the output format to cope, but currently I
+	 * don't have a VGA box to make sure this works properly.
 	 */
 	cable_type = pvr2_init_cable();
 	if (cable_type == CT_VGA && video_output != VO_VGA)
 		video_output = VO_VGA;
 
-	par->vmode = var->vmode & FB_VMODE_MASK;
-	if (par->vmode & FB_VMODE_INTERLACED && video_output != VO_VGA)
+	var->vmode &= FB_VMODE_MASK;
+	if (var->vmode & FB_VMODE_INTERLACED && video_output != VO_VGA)
 		par->is_interlaced = 1;
 	/* 
 	 * XXX: Need to be more creative with this (i.e. allow doublecan for
 	 * PAL/NTSC output).
 	 */
-	par->is_doublescan = (par->yres < 480 && video_output == VO_VGA);
+	if (var->vmode & FB_VMODE_DOUBLE && video_output == VO_VGA)
+		par->is_doublescan = 1;
 	
 	par->hsync_total = var->left_margin + var->xres + var->right_margin +
 	                   var->hsync_len;
@@ -691,22 +349,12 @@
 		if (par->is_interlaced)
 			vtotal /= 2;
 		if (vtotal > (PAL_VTOTAL + NTSC_VTOTAL)/2) {
-			/* PAL video output */
-			/* XXX: Should be using a range here ... ? */
-			if (par->hsync_total != PAL_HTOTAL) {
-				DPRINTK("invalid hsync total for PAL\n");
-				return -EINVAL;
-			}
 			/* XXX: Check for start values here... */
 			/* XXX: Check hardware for PAL-compatibility */
 			par->borderstart_h = 116;
 			par->borderstart_v = 44;
 		} else {
 			/* NTSC video output */
-			if (par->hsync_total != NTSC_HTOTAL) {
-				DPRINTK("invalid hsync total for NTSC\n");
-				return -EINVAL;
-			}
 			par->borderstart_h = 126;
 			par->borderstart_v = 18;
 		}
@@ -714,155 +362,122 @@
 		/* VGA mode */
 		/* XXX: What else needs to be checked? */
 		/* 
-		 * XXX: We have a little freedom in VGA modes, what ranges should
-		 * be here (i.e. hsync/vsync totals, etc.)?
+		 * XXX: We have a little freedom in VGA modes, what ranges
+		 * should be here (i.e. hsync/vsync totals, etc.)?
 		 */
 		par->borderstart_h = 126;
 		par->borderstart_v = 40;
 	}
 
 	/* Calculate the remainding offsets */
-	par->borderstop_h = par->borderstart_h + par->hsync_total -
-	                    var->hsync_len;
-	par->borderstop_v = par->borderstart_v + par->vsync_total -
-	                    var->vsync_len;
 	par->diwstart_h = par->borderstart_h + var->left_margin;
 	par->diwstart_v = par->borderstart_v + var->upper_margin;
+	par->borderstop_h = par->diwstart_h + var->xres + 
+			    var->right_margin;    
+	par->borderstop_v = par->diwstart_v + var->yres +
+			    var->lower_margin;
+
 	if (!par->is_interlaced)
 		par->borderstop_v /= 2;
-
-	if (par->xres < 640)
+	if (info->var.xres < 640)
 		par->is_lowres = 1;
 
-	/* XXX: Needs testing. */
-	if (!((par->vmode ^ var->vmode) & FB_VMODE_YWRAP)) {
-		par->xoffset = var->xoffset;
-		par->yoffset = var->yoffset;
-		if (par->vmode & FB_VMODE_YWRAP) {
-			if (par->xoffset || par->yoffset < 0 || par->yoffset >=
-			    par->vyres)
-				par->xoffset = par->yoffset = 0;
-		} else {
-			if (par->xoffset < 0 || par->xoffset > par->vxres-par->xres ||
-			    par->yoffset < 0 || par->yoffset > par->vyres-par->yres)
-				par->xoffset = par->yoffset = 0;
-		}
-	} else
-		par->xoffset = par->yoffset = 0;
-
-	/* Check memory sizes */
 	line_length = get_line_length(var->xres_virtual, var->bits_per_pixel);
-	if (line_length * var->yres_virtual > videomemorysize)
-		return -ENOMEM;
-	par->disp_start = videomemory + (get_line_length(par->vxres, par->bpp) *
-	                  par->yoffset) * get_line_length(par->xoffset, par->bpp);
-	par->next_line = line_length;
-	
+	par->disp_start = videomemory + (line_length * var->yoffset) * line_length;
+	info->fix.line_length = line_length;
 	return 0;
 }
 
-static int pvr2_encode_var(struct fb_var_screeninfo *var,
-                             struct pvr2fb_par *par)
+static int pvr2fb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 {
-	memset(var, 0, sizeof(struct fb_var_screeninfo));
+	struct pvr2fb_par *par = (struct pvr2fb_par *)info->par;
+	u_short vtotal, hsync_total;
+	u_long line_length;
 
-	var->xres = par->xres;
-	var->yres = par->yres;
-	var->xres_virtual = par->vxres;
-	var->yres_virtual = par->vyres;
-	var->xoffset = par->xoffset;
-	var->yoffset = par->yoffset;
+	if (var->pixclock != TV_CLK || var->pixclock != VGA_CLK) {
+		DPRINTK("Invalid pixclock value %d\n", var->pixclock);
+		return -EINVAL;
+	}
 
-	var->bits_per_pixel = par->bpp;
-	set_color_bitfields(var);
+	if (var->xres < 320)
+		var->xres = 320;
+	if (var->yres < 240)
+		var->yres = 240;
+	if (var->xres_virtual < var->xres)
+		var->xres_virtual = var->xres;
+	if (var->yres_virtual < var->yres)
+		var->yres_virtual = var->yres;
+
+	if (var->bits_per_pixel <= 16)
+		var->bits_per_pixel = 16;
+	else if (var->bits_per_pixel <= 24)
+		var->bits_per_pixel = 24;
+	else if (var->bits_per_pixel <= 32)
+		var->bits_per_pixel = 32;
 
-	var->activate = FB_ACTIVATE_NOW;
-	var->height = -1;
-	var->width = -1;
+	set_color_bitfields(var);
 
-	var->pixclock = par->pixclock;
+	if (var->vmode & FB_VMODE_YWRAP) {
+		if (var->xoffset || var->yoffset < 0 || 
+		    var->yoffset >= var->yres_virtual)
+			var->xoffset = var->yoffset = 0;
+		} else {
+			if (var->xoffset > var->xres_virtual - var->xres ||
+		    	    var->yoffset > var->yres_virtual - var->yres || 
+			    var->xoffset < 0 || var->yoffset < 0)
+				var->xoffset = var->yoffset = 0;
+		}
+	} else
+		var->xoffset = var->yoffset = 0;
 
-	if (par->is_doublescan)
+	/* 
+	 * XXX: Need to be more creative with this (i.e. allow doublecan for
+	 * PAL/NTSC output).
+	 */
+	if (var->yres < 480 && video_output == VO_VGA)
 		var->vmode = FB_VMODE_DOUBLE;
 
-	if (par->is_interlaced)
-		var->vmode |= FB_VMODE_INTERLACED;
-	else
-		var->vmode |= FB_VMODE_NONINTERLACED;
-
-	var->right_margin = par->borderstop_h - (par->diwstart_h + par->xres);
-	var->left_margin = par->diwstart_h - par->borderstart_h;
-	var->hsync_len = par->borderstart_h + (par->hsync_total - par->borderstop_h);
-	var->upper_margin = par->diwstart_v - par->borderstart_v;
-	var->lower_margin = par->borderstop_v - (par->diwstart_v + par->yres);
-	var->vsync_len = par->borderstart_v + (par->vsync_total - par->borderstop_v);
 	if (video_output != VO_VGA)
-		var->sync = FB_SYNC_BROADCAST;
-
-	if (par->vmode & FB_VMODE_YWRAP)
-		var->vmode |= FB_VMODE_YWRAP;
-	
-	return 0;
-}
-
-static void pvr2_get_par(struct pvr2fb_par *par)
-{
-	*par = currentpar;
-}
-
-/* Setup the new videomode in hardware */
-
-static void pvr2_set_var(struct fb_var_screeninfo *var)
-{
-	do_vmode_pan = 0;
-	do_vmode_full = 0;
-	pvr2_decode_var(var, &currentpar);
+		var->sync = FB_SYNC_BROADCAST | FB_VMODE_INTERLACED;
 
-	do_vmode_full = 1;
-}
-
-/* 
- * Pan or wrap the display
- * This call looks only at xoffset, yoffset and the FB_VMODE_YWRAP flag in `var'.
- */
-static void pvr2_pan_var(struct fb_var_screeninfo *var)
-{
-	struct pvr2fb_par *par = &currentpar;
-
-	par->xoffset = var->xoffset;
-	par->yoffset = var->yoffset;
-	if (var->vmode & FB_VMODE_YWRAP)
-		par->vmode |= FB_VMODE_YWRAP;
-	else
-		par->vmode &= ~FB_VMODE_YWRAP;
-
-	do_vmode_pan = 0;
-	pvr2_update_par();
-	do_vmode_pan = 1;
-}
-
-static int pvr2_update_par(void)
-{
-	struct pvr2fb_par *par = &currentpar;
-	u_long move;
-
-	move = get_line_length(par->xoffset, par->bpp);
-	if (par->yoffset) {
-		par->disp_start += (par->next_line * par->yoffset) + move;
-	} else
-		par->disp_start += move;
+	hsync_total = var->left_margin + var->xres + var->right_margin +
+		      var->hsync_len;
+	vtotal = var->upper_margin + var->yres + var->lower_margin +
+		 var->vsync_len;
 
+	if (var->sync & FB_SYNC_BROADCAST) {
+		if (var->vmode & FB_VMODE_INTERLACED)
+			vtotal /= 2;
+		if (vtotal > (PAL_VTOTAL + NTSC_VTOTAL)/2) {
+			/* PAL video output */
+			/* XXX: Should be using a range here ... ? */
+			if (hsync_total != PAL_HTOTAL) {
+				DPRINTK("invalid hsync total for PAL\n");
+				return -EINVAL;
+			}
+		} else {
+			/* NTSC video output */
+			if (hsync_total != NTSC_HTOTAL) {
+				DPRINTK("invalid hsync total for NTSC\n");
+				return -EINVAL;
+			}
+	}
+	/* Check memory sizes */
+	line_length = get_line_length(var->xres_virtual, var->bits_per_pixel);
+	if (line_length * var->yres_virtual > videomemorysize)
+		return -ENOMEM;
 	return 0;
 }
 
-static void pvr2_update_display(void)
+static void pvr2_update_display(struct fb_info *info)
 {
-	struct pvr2fb_par *par = &currentpar;
+	struct pvr2fb_par *par = (struct pvr2fb_par *) info->par;
+	struct fb_var_screeninfo *var = &info->var;
 
 	/* Update the start address of the display image */
 	ctrl_outl(par->disp_start, DISP_DIWADDRL);
 	ctrl_outl(par->disp_start +
-		  get_line_length(par->xoffset + par->xres, par->bpp),
+		  get_line_length(var->xoffset+var->xres, var->bits_per_pixel),
 	          DISP_DIWADDRS);
 }
 
@@ -872,11 +487,12 @@
  * registers are still undocumented.
  */
 
-static void pvr2_init_display(void)
+static void pvr2_init_display(struct fb_info *info)
 {
-	struct pvr2fb_par *par = &currentpar;
+	struct pvr2fb_par *par = (struct pvr2fb_par *) info->par;
+	struct fb_var_screeninfo *var = &info->var;
 	u_short diw_height, diw_width, diw_modulo = 1;
-	u_short bytesperpixel = par->bpp / 8;
+	u_short bytesperpixel = var->bits_per_pixel >> 3;
 
 	/* hsync and vsync totals */
 	ctrl_outl((par->vsync_total << 16) | par->hsync_total, DISP_SYNCSIZE);
@@ -885,16 +501,16 @@
 	/* since we're "panning" within vram, we need to offset things based
 	 * on the offset from the virtual x start to our real gfx. */
 	if (video_output != VO_VGA && par->is_interlaced)
-		diw_modulo += par->next_line / 4;
-	diw_height = (par->is_interlaced ? par->yres / 2 : par->yres);
-	diw_width = get_line_length(par->xres, par->bpp) / 4;
+		diw_modulo += info->fix.line_length / 4;
+	diw_height = (par->is_interlaced ? var->yres / 2 : var->yres);
+	diw_width = get_line_length(var->xres, var->bits_per_pixel) / 4;
 	ctrl_outl((diw_modulo << 20) | (--diw_height << 10) | --diw_width,
 	          DISP_DIWSIZE);
 
 	/* display address, long and short fields */
 	ctrl_outl(par->disp_start, DISP_DIWADDRL);
 	ctrl_outl(par->disp_start +
-	          get_line_length(par->xoffset + par->xres, par->bpp),
+	          get_line_length(var->xoffset+var->xres, var->bits_per_pixel),
 	          DISP_DIWADDRS);
 
 	/* border horizontal, border vertical, border color */
@@ -919,7 +535,6 @@
 	/* video enable, color sync, interlace, 
 	 * hsync and vsync polarity (currently unused) */
 	ctrl_outl(0x100 | ((par->is_interlaced /*|4*/) << 4), DISP_SYNCCONF);
-
 }
 
 /* Simulate blanking by making the border cover the entire screen */
@@ -941,23 +556,20 @@
 
 static irqreturn_t pvr2fb_interrupt(int irq, void *dev_id, struct pt_regs *fp)
 {
-	if (do_vmode_pan || do_vmode_full)
-		pvr2_update_display();
+	struct fb_info *info = dev_id;
 
+	if (do_vmode_pan || do_vmode_full)
+		pvr2_update_display(info);
 	if (do_vmode_full)
-		pvr2_init_display();
-
+		pvr2_init_display(info);
 	if (do_vmode_pan)
 		do_vmode_pan = 0;
-
+	if (do_vmode_full)
+		do_vmode_full = 0;
 	if (do_blank) {
 		pvr2_do_blank();
 		do_blank = 0;
 	}
-
-	if (do_vmode_full) {
-		do_vmode_full = 0;
-	}
 	return IRQ_HANDLED;
 }
 
@@ -997,51 +609,83 @@
 	if (!MACH_DREAMCAST)
 		return -ENXIO;
 
+	fb_info = kmalloc(sizeof(struct fb_info) + sizeof(struct pvr2fb_par) +
+			  sizeof(u32) * 16, GFP_KERNEL);
+	
+	if (!fb_info) {
+		printk(KERN_ERR "Failed to allocate memory for fb_info\n");
+		return -ENOMEM;
+	}
+
+	memset(fb_info, 0, sizeof(fb_info) + sizeof(struct pvr2fb_par) + sizeof(u32) * 16);
+
+	currentpar = (struct pvr2fb_par *)(fb_info + 1);
+
 	/* Make a guess at the monitor based on the attached cable */
 	if (pvr2_init_cable() == CT_VGA) {
-		fb_info.monspecs.hfmin = 30000;
-		fb_info.monspecs.hfmax = 70000;
-		fb_info.monspecs.vfmin = 60;
-		fb_info.monspecs.vfmax = 60;
-	}
-	else { /* Not VGA, using a TV (taken from acornfb) */
-		fb_info.monspecs.hfmin = 15469;
-		fb_info.monspecs.hfmax = 15781;
-		fb_info.monspecs.vfmin = 49;
-		fb_info.monspecs.vfmax = 51;
+		fb_info->monspecs.hfmin = 30000;
+		fb_info->monspecs.hfmax = 70000;
+		fb_info->monspecs.vfmin = 60;
+		fb_info->monspecs.vfmax = 60;
+	} else {
+		/* Not VGA, using a TV (taken from acornfb) */
+		fb_info->monspecs.hfmin = 15469;
+		fb_info->monspecs.hfmax = 15781;
+		fb_info->monspecs.vfmin = 49;
+		fb_info->monspecs.vfmax = 51;
 	}
 
-	/* XXX: This needs to pull default video output via BIOS or other means */
+	/*
+	 * XXX: This needs to pull default video output via BIOS or other means
+	 */
 	if (video_output < 0) {
-		if (cable_type == CT_VGA)
+		if (cable_type == CT_VGA) {
 			video_output = VO_VGA;
-		else
+		} else {
 			video_output = VO_NTSC;
+		}
 	}
 	
-	strcpy(fb_info.modename, pvr2fb_name);
-	fb_info.changevar = NULL;
-	fb_info.fbops = &pvr2fb_ops;
-	fb_info.screen_base = (char *) videomemory;
-	fb_info.disp = &disp;
-	fb_info.currcon = -1;
-	fb_info.switch_con = &pvr2fbcon_switch;
-	fb_info.updatevar = &pvr2fbcon_updatevar;
-	fb_info.flags = FBINFO_FLAG_DEFAULT;
+	pvr2_fix.smem_start = videomemory;
+	pvr2_fix.smem_len = videomemorysize;
+
+	fb_info->screen_base = ioremap_nocache(pvr2_fix.smem_start,
+					       pvr2_fix.smem_len);
+	
+	if (!fb_info->screen_base) {
+		printk("Failed to remap MMIO space\n");
+		kfree(fb_info);
+		return -ENXIO;
+	}
+
+	memset_io((unsigned long)fb_info->screen_base, 0, pvr2_fix.smem_len);
+
+	pvr2_fix.ypanstep	= nopan  ? 0 : 1;
+	pvr2_fix.ywrapstep	= nowrap ? 0 : 1;
+
+	fb_info->fbops		= &pvr2fb_ops;
+	fb_info->fix		= pvr2_fix;
+	fb_info->par		= currentpar;
+	fb_info->pseudo_palette	= (void *)(fb_info->par + 1);
+	fb_info->flags		= FBINFO_FLAG_DEFAULT;
+
 	memset(&var, 0, sizeof(var));
 
 	if (video_output == VO_VGA)
 		defmode = DEFMODE_VGA;
 
-	if (!fb_find_mode(&var, &fb_info, mode_option, pvr2_modedb,
-	                  NUM_TOTAL_MODES, &pvr2_modedb[defmode], 16)) {
-		return -EINVAL;
-	}
+	if (!mode_option)
+		mode_option = "640x480@60";
+
+	if (!fb_find_mode(&fb_info->var, fb_info, mode_option, pvr2_modedb,
+	                  NUM_TOTAL_MODES, &pvr2_modedb[defmode], 16))
+		fb_info->var = pvr2_var;
 
 	if (request_irq(HW_EVENT_VSYNC, pvr2fb_interrupt, 0,
-	                "pvr2 VBL handler", &currentpar)) {
+	                "pvr2 VBL handler", fb_info)) {
 		DPRINTK("couldn't register VBL int\n");
-		return -EBUSY;
+		kfree(fb_info);
+		return 	-EBUSY;
 	}
 
 #ifdef CONFIG_MTRR
@@ -1051,18 +695,18 @@
 	}
 #endif
 
-	pvr2fb_set_var(&var, -1, &fb_info);
-
-	if (register_framebuffer(&fb_info) < 0)
+	if (register_framebuffer(fb_info) < 0) {
+		kfree(fb_info);
 		return -EINVAL;
+	}
 
 	modememused = get_line_length(var.xres_virtual, var.bits_per_pixel);
 	modememused *= var.yres_virtual;
 	printk("fb%d: %s frame buffer device, using %ldk/%ldk of video memory\n",
-	       fb_info.node, fb_info.modename, modememused>>10,
+	       fb_info->node, fb_info->fix.id, modememused>>10,
 	       videomemorysize>>10);
 	printk("fb%d: Mode %dx%d-%d pitch = %ld cable: %s video output: %s\n", 
-	       fb_info.node, var.xres, var.yres, var.bits_per_pixel, 
+	       fb_info->node, var.xres, var.yres, var.bits_per_pixel, 
 	       get_line_length(var.xres, var.bits_per_pixel),
 	       (char *)pvr2_get_param(cables, NULL, cable_type, 3),
 	       (char *)pvr2_get_param(outputs, NULL, video_output, 3));
@@ -1078,7 +722,8 @@
 		printk("pvr2fb: MTRR turned off\n");
 	}
 #endif
-	unregister_framebuffer(&fb_info);
+	unregister_framebuffer(fb_info);
+	kfree(fb_info);
 }
 
 static int __init pvr2_get_param(const struct pvr2_params *p, const char *s,
@@ -1102,7 +747,6 @@
  * Parse command arguments.  Supported arguments are:
  *    inverse                             Use inverse color maps
  *    nomtrr                              Disable MTRR usage
- *    font:<fontname>                     Specify console font
  *    cable:composite|rgb|vga             Override the video cable type
  *    output:NTSC|PAL|VGA                 Override the video output format
  *
@@ -1117,8 +761,6 @@
 	char cable_arg[80];
 	char output_arg[80];
 
-	fb_info.fontname[0] = '\0';
-
 	if (!options || !*options)
 		return 0;
 
@@ -1128,23 +770,25 @@
 		if (!strcmp(this_opt, "inverse")) {
 			pvr2fb_inverse = 1;
 			fb_invert_cmaps();
-		} else if (!strncmp(this_opt, "font:", 5))
-			strcpy(fb_info.fontname, this_opt + 5);
-		else if (!strncmp(this_opt, "cable:", 6))
+		} else if (!strncmp(this_opt, "cable:", 6)) {
 			strcpy(cable_arg, this_opt + 6);
-		else if (!strncmp(this_opt, "output:", 7))
+		} else if (!strncmp(this_opt, "output:", 7)) {
 			strcpy(output_arg, this_opt + 7);
+		} else if (!strncmp(this_opt, "nopan", 5)) {
+			nopan = 1;
+		} else if (!strncmp(this_opt, "nowrap", 6)) {
+			nowrap = 1;
 #ifdef CONFIG_MTRR
-		else if (!strncmp(this_opt, "nomtrr", 6))
+		} else if (!strncmp(this_opt, "nomtrr", 6)) {
 			enable_mtrr = 0;
 #endif
-		else
+		} else {
 			mode_option = this_opt;
+		}
 	}
 
 	if (*cable_arg)
 		cable_type = pvr2_get_param(cables, cable_arg, 0, 3);
-
 	if (*output_arg)
 		video_output = pvr2_get_param(outputs, output_arg, 0, 3);
 

