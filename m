Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290614AbSBLAIb>; Mon, 11 Feb 2002 19:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290618AbSBLAIY>; Mon, 11 Feb 2002 19:08:24 -0500
Received: from www.transvirtual.com ([206.14.214.140]:12296 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S290614AbSBLAIL>; Mon, 11 Feb 2002 19:08:11 -0500
Date: Mon, 11 Feb 2002 16:07:49 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: davej@suse.de
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] accel wrapper again
Message-ID: <Pine.LNX.4.10.10202111605310.5200-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi folks!!

  Here is the second run at a accel wrapper plus also new generic fbdev
functions totally depended on the new fbdev api. Makes it easy to port
drivers over :-) With your blessing Geert I like to have it included into
the DJ tree. 

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'_   _/`\
 ___)=(___/

diff -urN -X /home/jsimmons/dontdiff linux-2.5.3-dj5/drivers/video/Makefile linux/drivers/video/Makefile
--- linux-2.5.3-dj5/drivers/video/Makefile	Mon Feb 11 11:37:39 2002
+++ linux/drivers/video/Makefile	Mon Feb 11 12:00:48 2002
@@ -14,7 +14,7 @@
 		  fbcon-vga.o fbcon-iplan2p2.o fbcon-iplan2p4.o \
 		  fbcon-iplan2p8.o fbcon-vga-planes.o fbcon-cfb16.o \
 		  fbcon-cfb2.o fbcon-cfb24.o fbcon-cfb32.o fbcon-cfb4.o \
-		  fbcon-cfb8.o fbcon-mac.o fbcon-mfb.o \
+		  fbcon-cfb8.o fbcon-mac.o fbcon-mfb.o fbcon-accel.o \
 		  cyber2000fb.o sa1100fb.o fbcon-hga.o
 
 # Each configuration option enables a list of files.
@@ -137,6 +137,7 @@
 obj-$(CONFIG_FBCON_VGA)           += fbcon-vga.o
 obj-$(CONFIG_FBCON_HGA)           += fbcon-hga.o
 obj-$(CONFIG_FBCON_STI)           += fbcon-sti.o
+obj-$(CONFIG_FBCON_ACCEL)	  += fbcon-accel.o
 
 include $(TOPDIR)/Rules.make
 
diff -urN -X /home/jsimmons/dontdiff linux-2.5.3-dj5/drivers/video/fbcon-accel.c linux/drivers/video/fbcon-accel.c
--- linux-2.5.3-dj5/drivers/video/fbcon-accel.c	Wed Dec 31 16:00:00 1969
+++ linux/drivers/video/fbcon-accel.c	Mon Feb 11 16:52:44 2002
@@ -0,0 +1,188 @@
+/*
+ *  linux/drivers/video/fbcon-accel.c -- Framebuffer accel console wrapper
+ *
+ *      Created 20 Feb 2001 by James Simmons <jsimmons@users.sf.net>
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License.  See the file COPYING in the main directory of this archive for
+ *  more details.
+ */
+
+#include <linux/module.h>
+#include <linux/tty.h>
+#include <linux/console.h>
+#include <linux/string.h>
+#include <linux/fb.h>
+
+#include <video/fbcon.h>
+#include "fbcon-accel.h"
+
+void fbcon_accel_setup(struct display *p)
+{
+	p->next_line = p->fb_info->fix.line_length;
+	p->next_plane = 0;
+}
+
+void fbcon_accel_bmove(struct display *p, int sy, int sx, int dy, int dx,
+		       int height, int width)
+{
+	struct fb_info *info = p->fb_info;
+	struct fb_copyarea area;
+
+	area.sx = sx * fontwidth(p);
+	area.sy = sy * fontheight(p);
+	area.dx = dx * fontwidth(p);
+	area.dy = dy * fontheight(p);
+	area.height = height * fontheight(p);
+	area.width  = width * fontwidth(p);
+
+	info->fbops->fb_copyarea(info, &area);
+}
+
+void fbcon_accel_clear(struct vc_data *vc, struct display *p, int sy, int sx,
+		       int height, int width)
+{
+	struct fb_info *info = p->fb_info;
+	struct fb_fillrect region;
+
+	region.color = attr_bgcol_ec(p,vc);
+	region.dx = sx * fontwidth(p);
+	region.dy = sy * fontheight(p);
+	region.width = width * fontwidth(p);
+	region.height = height * fontheight(p);
+	region.rop = ROP_COPY;
+
+	info->fbops->fb_fillrect(info, &region);
+}
+
+void fbcon_accel_putc(struct vc_data *vc, struct display *p, int c, int yy,
+		      int xx)
+{
+	struct fb_info *info = p->fb_info;
+	unsigned short charmask = p->charmask;
+	unsigned int width = ((fontwidth(p)+7)>>3);
+	struct fb_image image;
+
+	image.fg_color = attr_fgcol(p, c);
+	image.bg_color = attr_bgcol(p, c);
+	image.dx = xx * fontwidth(p);
+	image.dy = yy * fontheight(p);
+	image.width = fontwidth(p);
+	image.height = fontheight(p);
+	image.depth = 1;
+	image.data = p->fontdata + (c & charmask)*fontheight(p)*width;
+
+	info->fbops->fb_imageblit(info, &image);
+}
+
+void fbcon_accel_putcs(struct vc_data *vc, struct display *p,
+		       const unsigned short *s, int count, int yy, int xx)
+{
+	struct fb_info *info = p->fb_info;
+	unsigned short charmask = p->charmask;
+	unsigned int width = ((fontwidth(p)+7)>>3);
+	struct fb_image image;
+
+	image.fg_color = attr_fgcol(p, *s);
+	image.bg_color = attr_bgcol(p, *s);
+	image.dx = xx * fontwidth(p);
+	image.dy = yy * fontheight(p);
+	image.width = fontwidth(p);
+	image.height = fontheight(p);
+	image.depth = 1;
+
+	while (count--) {
+		image.data = p->fontdata +
+			(scr_readw(s++) & charmask) * fontheight(p) * width;
+		info->fbops->fb_imageblit(info, &image);
+		image.dx += fontwidth(p);
+	}
+}
+
+void fbcon_accel_revc(struct display *p, int xx, int yy)
+{
+	struct fb_info *info = p->fb_info;
+	struct fb_fillrect region;
+
+	region.color = attr_bgcol_ec(p, p->conp);
+	region.dx = xx * fontwidth(p);
+	region.dy = yy * fontheight(p);
+	region.width  = fontwidth(p);
+	region.height = fontheight(p); 
+	region.rop = ROP_XOR;
+	
+	info->fbops->fb_fillrect(info, &region);
+}
+
+void fbcon_accel_clear_margins(struct vc_data *vc, struct display *p,
+			       int bottom_only)
+{
+	struct fb_info *info = p->fb_info;
+	unsigned int cw = fontwidth(p);
+	unsigned int ch = fontheight(p);
+	unsigned int rw = info->var.xres % cw;
+	unsigned int bh = info->var.yres % ch;
+	unsigned int rs = info->var.xres - rw;
+	unsigned int bs = info->var.yres - bh;
+	struct fb_fillrect region;
+
+	region.color = attr_bgcol_ec(p,vc);
+	region.rop = ROP_COPY;
+
+	if (rw && !bottom_only) {
+		region.dx = info->var.xoffset + rs;
+		region.dy = 0;
+		region.width  = rw;
+		region.height = info->var.yres_virtual;
+		info->fbops->fb_fillrect(info, &region); 
+	}
+
+	if (bh) {
+		region.dx = info->var.xoffset;
+                region.dy = info->var.yoffset + bs;
+                region.width  = rs;
+                region.height = bh;
+		info->fbops->fb_fillrect(info, &region);
+	}
+}
+
+    /*
+     *  `switch' for the low level operations
+     */
+
+struct display_switch fbcon_accel = {
+	setup:		fbcon_accel_setup,
+	bmove:		fbcon_accel_bmove,
+	clear:		fbcon_accel_clear,
+	putc:		fbcon_accel_putc,
+	putcs:		fbcon_accel_putcs,
+	revc:		fbcon_accel_revc,
+	clear_margins:	fbcon_accel_clear_margins,
+	fontwidthmask:  ~1	
+};
+
+#ifdef MODULE
+MODULE_LICENSE("GPL");
+
+int init_module(void)
+{
+    return 0;
+}
+
+void cleanup_module(void)
+{}
+#endif /* MODULE */
+
+
+    /*
+     *  Visible symbols for modules
+     */
+
+EXPORT_SYMBOL(fbcon_accel);
+EXPORT_SYMBOL(fbcon_accel_setup);
+EXPORT_SYMBOL(fbcon_accel_bmove);
+EXPORT_SYMBOL(fbcon_accel_clear);
+EXPORT_SYMBOL(fbcon_accel_putc);
+EXPORT_SYMBOL(fbcon_accel_putcs);
+EXPORT_SYMBOL(fbcon_accel_revc);
+EXPORT_SYMBOL(fbcon_accel_clear_margins);
diff -urN -X /home/jsimmons/dontdiff linux-2.5.3-dj5/drivers/video/fbcon-accel.h linux/drivers/video/fbcon-accel.h
--- linux-2.5.3-dj5/drivers/video/fbcon-accel.h	Wed Dec 31 16:00:00 1969
+++ linux/drivers/video/fbcon-accel.h	Mon Feb 11 12:11:29 2002
@@ -0,0 +1,34 @@
+/*
+ *  FBcon low-level driver for 32 bpp packed pixel (cfb32)
+ */
+
+#ifndef _VIDEO_FBCON_ACCEL_H
+#define _VIDEO_FBCON_ACCEL_H
+
+#include <linux/config.h>
+
+#ifdef MODULE
+#if defined(CONFIG_FBCON_ACCEL) || defined(CONFIG_FBCON_ACCEL_MODULE)
+#define FBCON_HAS_ACCEL
+#endif
+#else
+#if defined(CONFIG_FBCON_ACCEL)
+#define FBCON_HAS_ACCEL
+#endif
+#endif
+
+extern struct display_switch fbcon_accel;
+extern void fbcon_accel_setup(struct display *p);
+extern void fbcon_accel_bmove(struct display *p, int sy, int sx, int dy,
+			      int dx, int height, int width);
+extern void fbcon_accel_clear(struct vc_data *vc, struct display *p, int sy,
+			      int sx, int height, int width);
+extern void fbcon_accel_putc(struct vc_data *vc, struct display *p, int c,
+			     int yy, int xx);
+extern void fbcon_accel_putcs(struct vc_data *vc, struct display *p,
+			      const unsigned short *s, int count, int yy, int xx);
+extern void fbcon_accel_revc(struct display *p, int xx, int yy);
+extern void fbcon_accel_clear_margins(struct vc_data *vc, struct display *p,
+				      int bottom_only);
+
+#endif /* _VIDEO_FBCON_ACCEL_H */
diff -urN -X /home/jsimmons/dontdiff linux-2.5.3-dj5/drivers/video/fbgen.c linux/drivers/video/fbgen.c
--- linux-2.5.3-dj5/drivers/video/fbgen.c	Mon Feb 11 11:37:40 2002
+++ linux/drivers/video/fbgen.c	Mon Feb 11 11:53:50 2002
@@ -21,6 +21,14 @@
 #include <asm/io.h>
 
 #include <video/fbcon.h>
+#include <video/fbcon-mfb.h>
+#include <video/fbcon-cfb2.h>
+#include <video/fbcon-cfb4.h>
+#include <video/fbcon-cfb8.h>
+#include <video/fbcon-cfb16.h>
+#include <video/fbcon-cfb24.h>
+#include <video/fbcon-cfb32.h>
+#include "fbcon-accel.h"
 
 /* ---- `Generic' versions of the frame buffer device operations ----------- */
 
@@ -56,6 +64,11 @@
     return fbhw->encode_fix(fix, &par, info2);
 }
 
+int gen_get_fix(struct fb_fix_screeninfo *fix, int con, struct fb_info *info)
+{
+	*fix = info->fix;
+	return 0;	
+}
 
 /**
  *	fbgen_get_var - get user defined part of display
@@ -84,6 +97,11 @@
     return 0;
 }
 
+int gen_get_var(struct fb_var_screeninfo *var, int con, struct fb_info *info)
+{
+	*var = info->var;
+	return 0;	
+}
 
 /**
  *	fbgen_set_var - set the user defined part of display
@@ -132,6 +150,41 @@
 }
 
 
+int gen_set_var(struct fb_var_screeninfo *var, int con, struct fb_info *info)
+{
+	int err;
+
+	if (con < 0 || (memcpy(&info->var, var, sizeof(struct fb_var_screeninfo)))) {
+		if (!info->fbops->fb_check_var) {
+			*var = info->var;
+			return 0;
+		}
+		
+		if ((err = info->fbops->fb_check_var(var, info)))
+			return err;
+
+		if ((var->activate & FB_ACTIVATE_MASK) == FB_ACTIVATE_NOW) {
+			info->var = *var;
+			
+			gen_set_disp(con, info);
+		
+			if (con == info->currcon) {
+				if (info->fbops->fb_set_par)
+					info->fbops->fb_set_par(info);
+
+				if (info->fbops->fb_pan_display)
+					info->fbops->fb_pan_display(&info->var, con, info);
+
+				fb_set_cmap(&info->cmap, 1, info);
+			}
+		
+			if (info->changevar)
+				info->changevar(con);
+		}
+	}
+	return 0;
+}
+
 /**
  *	fbgen_get_cmap - get the colormap
  *	@cmap: frame buffer colormap structure
@@ -164,6 +217,11 @@
     return 0;
 }
 
+int gen_get_cmap(struct fb_cmap *cmap, int kspc, int con, struct fb_info *info)
+{
+	fb_copy_cmap (&info->cmap, cmap, kspc ? 0 : 2);
+	return 0;
+}
 
 /**
  *	fbgen_set_cmap - set the colormap
@@ -196,6 +254,30 @@
     return 0;
 }
 
+int gen_set_cmap(struct fb_cmap *cmap, int kspc, int con,
+		 struct fb_info *info)
+{
+	struct display *disp = (con < 0) ? info->disp : (fb_display + con);
+	struct fb_cmap *dcmap = &disp->cmap;
+	int err = 0;
+
+	/* No colormap allocated ? */
+	if (!dcmap->len) {
+		int size = info->cmap.len;
+
+		err = fb_alloc_cmap(dcmap, size, 0);
+	}
+ 	
+
+	if (!err && con == info->currcon) {
+		err = fb_set_cmap(cmap, kspc, info);
+		dcmap = &info->cmap;
+	}
+	
+	if (!err)
+		fb_copy_cmap(cmap, dcmap, kspc ? 0 : 1);
+	return err;
+}
 
 /**
  *	fbgen_pan_display - pan or wrap the display
@@ -277,7 +359,6 @@
     return 0;
 }
 
-
 /**
  *	fbgen_set_disp - set generic display
  *	@con: virtual console number
@@ -325,6 +406,93 @@
 #endif
 }
 
+void gen_set_disp(int con, struct fb_info *info)
+{
+	struct display *display;
+
+	if (con >= 0)
+		display = fb_display + con;
+	else
+		display = info->disp;
+
+#ifdef FBCON_HAS_ACCEL
+	if (info->var.accel_flags & FB_ACCELF_TEXT) {
+		display->dispsw = &fbcon_accel;
+		return;
+	}
+#endif
+
+	switch (info->var.bits_per_pixel)
+	{
+#ifdef FBCON_HAS_MFB
+		case 1:
+			display->dispsw = &fbcon_mfb;
+			break;
+#endif
+
+#ifdef FBCON_HAS_CFB2
+		case 2:
+			display->dispsw = &fbcon_cfb2;
+			break;
+#endif
+
+#ifdef FBCON_HAS_CFB4
+		case 4:
+			display->dispsw = &fbcon_cfb4;
+			break;
+#endif
+
+#ifdef FBCON_HAS_CFB8
+		case 8:
+			display->dispsw = &fbcon_cfb8;
+			break;
+#endif
+
+#ifdef FBCON_HAS_CFB16
+		case 16:
+			display->dispsw = &fbcon_cfb16;
+			break;
+#endif
+
+#ifdef FBCON_HAS_CFB24:
+		case 24:
+			display->dispsw = &fbcon_cfb24;
+			break;
+#endif
+
+#ifdef FBCON_HAS_CFB32
+		case 32:
+			display->dispsw = &fbcon_cfb32;
+			break;
+#endif
+		default:
+			display->dispsw = &fbcon_dummy;
+			break;
+	} 
+	
+	display->visual = info->fix.visual;
+	display->type	= info->fix.type;
+	display->type_aux = info->fix.type_aux;
+	display->ypanstep = info->fix.ypanstep;
+    	display->ywrapstep = info->fix.ywrapstep;
+    	display->line_length = info->fix.line_length;
+	if (info->fbops->fb_blank || info->fix.visual == FB_VISUAL_PSEUDOCOLOR ||
+	    info->fix.visual == FB_VISUAL_DIRECTCOLOR) {
+		display->can_soft_blank = 1;
+		display->dispsw_data = NULL;
+	} else {
+		display->can_soft_blank = 0;
+		display->dispsw_data = info->pseudo_palette;
+	}
+	display->var = info->var;
+
+	/*
+	 * If we are setting all the virtual consoles, also set
+	 * the defaults used to create new consoles.
+	 */
+	if (info->var.activate & FB_ACTIVATE_ALL)
+		info->disp->var = info->var;	
+}
 
 /**
  *	do_install_cmap - install the current colormap
@@ -404,6 +572,46 @@
 }
 
 
+int gen_switch(int con, struct fb_info *info)
+{
+	struct display *disp;
+	struct fb_cmap *cmap;
+	
+	if (info->currcon >= 0) {
+		disp = fb_display + info->currcon;
+	
+		/*
+		 * Save the old colormap and graphics mode.
+		 */
+		disp->var = info->var;
+		if (disp->cmap.len)
+			fb_copy_cmap(&info->cmap, &disp->cmap, 0);
+	}
+	
+	info->currcon = con;
+	disp = fb_display + con;
+	
+	/*
+	 * Install the new colormap and change the graphics mode. By default
+	 * fbcon sets all the colormaps and graphics modes to the default
+	 * values at bootup.
+	 *
+	 * Really, we want to set the colormap size depending on the
+	 * depth of the new grpahics mode. For now, we leave it as its
+	 * default 256 entry.
+	 */
+	if (disp->cmap.len)
+		cmap = &disp->cmap;
+	else
+		cmap = fb_default_cmap(1 << disp->var.bits_per_pixel);
+	
+	fb_copy_cmap(cmap, &info->cmap, 0);
+	
+	disp->var.activate = FB_ACTIVATE_NOW;
+	info->fbops->fb_set_var(&disp->var, con, info);
+ 	return 0;	  	
+}
+
 /**
  *	fbgen_blank - blank the screen
  *	@blank: boolean, 0 unblank, 1 blank
@@ -438,10 +646,15 @@
 
 /* generic frame buffer operations */
 EXPORT_SYMBOL(fbgen_get_fix);
+EXPORT_SYMBOL(gen_get_fix);
 EXPORT_SYMBOL(fbgen_get_var);
+EXPORT_SYMBOL(gen_get_var);
 EXPORT_SYMBOL(fbgen_set_var);
+EXPORT_SYMBOL(gen_set_var);
 EXPORT_SYMBOL(fbgen_get_cmap);
+EXPORT_SYMBOL(gen_get_cmap);
 EXPORT_SYMBOL(fbgen_set_cmap);
+EXPORT_SYMBOL(gen_set_cmap);
 EXPORT_SYMBOL(fbgen_pan_display);
 /* helper functions */
 EXPORT_SYMBOL(fbgen_do_set_var);
@@ -449,6 +662,7 @@
 EXPORT_SYMBOL(do_install_cmap);
 EXPORT_SYMBOL(fbgen_update_var);
 EXPORT_SYMBOL(fbgen_switch);
+EXPORT_SYMBOL(gen_switch);
 EXPORT_SYMBOL(fbgen_blank);
 
 MODULE_LICENSE("GPL");
diff -urN -X /home/jsimmons/dontdiff linux-2.5.3-dj5/include/linux/fb.h linux/include/linux/fb.h
--- linux-2.5.3-dj5/include/linux/fb.h	Mon Feb 11 11:37:44 2002
+++ linux/include/linux/fb.h	Mon Feb 11 11:59:26 2002
@@ -379,9 +379,6 @@
 					/* tell fb to switch consoles */
    int (*updatevar)(int, struct fb_info*);
 					/* tell fb to update the vars */
-   void (*blank)(int, struct fb_info*);	/* tell fb to (un)blank the screen */
-					/* arg = 0: unblank */
-					/* arg > 0: VESA level (arg-1) */
    void *pseudo_palette;                /* Fake palette of 16 colors and 
 					   the cursor's color for non
                                            palette mode */
@@ -437,14 +434,24 @@
 
 extern int fbgen_get_fix(struct fb_fix_screeninfo *fix, int con,
 			 struct fb_info *info);
+extern int gen_get_fix(struct fb_fix_screeninfo *fix, int con,
+		       struct fb_info *info);
 extern int fbgen_get_var(struct fb_var_screeninfo *var, int con,
 			 struct fb_info *info);
+extern int gen_get_var(struct fb_var_screeninfo *var, int con,
+		       struct fb_info *info);
 extern int fbgen_set_var(struct fb_var_screeninfo *var, int con,
 			 struct fb_info *info);
+extern int gen_set_var(struct fb_var_screeninfo *var, int con,
+		       struct fb_info *info);
 extern int fbgen_get_cmap(struct fb_cmap *cmap, int kspc, int con,
 			  struct fb_info *info);
+extern int gen_get_cmap(struct fb_cmap *cmap, int kspc, int con,
+			struct fb_info *info);
 extern int fbgen_set_cmap(struct fb_cmap *cmap, int kspc, int con,
 			  struct fb_info *info);
+extern int gen_set_cmap(struct fb_cmap *cmap, int kspc, int con,
+			struct fb_info *info);
 extern int fbgen_pan_display(struct fb_var_screeninfo *var, int con,
 			     struct fb_info *info);
 extern void cfb_fillrect(struct fb_info *p, struct fb_fillrect *rect); 
@@ -461,9 +468,10 @@
 extern void do_install_cmap(int con, struct fb_info *info);
 extern int fbgen_update_var(int con, struct fb_info *info);
 extern int fbgen_switch(int con, struct fb_info *info);
+extern int gen_switch(int con, struct fb_info *info);
 extern int fbgen_blank(int blank, struct fb_info *info);
 
-extern void fbgen2_set_disp(int con, struct fb_info *info);
+extern void gen_set_disp(int con, struct fb_info *info);
 
 /* drivers/video/fbmem.c */
 extern int register_framebuffer(struct fb_info *fb_info);

