Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287616AbSA1XWP>; Mon, 28 Jan 2002 18:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287578AbSA1XWG>; Mon, 28 Jan 2002 18:22:06 -0500
Received: from www.transvirtual.com ([206.14.214.140]:27909 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S287657AbSA1XVt>; Mon, 28 Jan 2002 18:21:49 -0500
Date: Mon, 28 Jan 2002 15:21:39 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: davej@suse.de
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fbdev accel wrapper. II
In-Reply-To: <Pine.LNX.4.10.10201281516290.14010-100000@www.transvirtual.com>
Message-ID: <Pine.LNX.4.10.10201281521090.14010-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Oops. Forgot the patch. Here you go.

diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj6/drivers/video/Makefile linux/drivers/video/Makefile
--- linux-2.5.2-dj6/drivers/video/Makefile	Mon Jan 28 10:04:47 2002
+++ linux/drivers/video/Makefile	Mon Jan 28 10:52:59 2002
@@ -14,7 +14,7 @@
 		  fbcon-vga.o fbcon-iplan2p2.o fbcon-iplan2p4.o \
 		  fbcon-iplan2p8.o fbcon-vga-planes.o fbcon-cfb16.o \
 		  fbcon-cfb2.o fbcon-cfb24.o fbcon-cfb32.o fbcon-cfb4.o \
-		  fbcon-cfb8.o fbcon-mac.o fbcon-mfb.o \
+		  fbcon-cfb8.o fbcon-mac.o fbcon-mfb.o fbcon-accel.o \
 		  cyber2000fb.o sa1100fb.o fbcon-hga.o
 
 # Each configuration option enables a list of files.
@@ -136,6 +136,7 @@
 obj-$(CONFIG_FBCON_VGA)           += fbcon-vga.o
 obj-$(CONFIG_FBCON_HGA)           += fbcon-hga.o
 obj-$(CONFIG_FBCON_STI)           += fbcon-sti.o
+obj-$(CONFIG_FBCON_ACCEL)	  += fbcon-accel.o
 
 include $(TOPDIR)/Rules.make
 
diff -urN -X /home/jsimmons/dontdiff linux-2.5.2-dj6/drivers/video/fbcon-accel.c linux/drivers/video/fbcon-accel.c
--- linux-2.5.2-dj6/drivers/video/fbcon-accel.c	Wed Dec 31 16:00:00 1969
+++ linux/drivers/video/fbcon-accel.c	Mon Jan 28 11:15:10 2002
@@ -0,0 +1,229 @@
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
+
+void fbcon_accel_setup(struct display *p)
+{
+	p->next_line = p->line_length ? p->line_length : p->var.xres_virtual*(p->var.bits_per_pixel<<3);
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
+	if (info->fix.visual == FB_VISUAL_PSEUDOCOLOR)
+		region.color = attr_bgcol_ec(p,vc);
+	else {
+		if (info->var.bits_per_pixel > 16)
+			region.color = ((u32*)info->pseudo_palette)[attr_bgcol_ec(p,vc)];
+		else
+			region.color = ((u16*)info->pseudo_palette)[attr_bgcol_ec(p,vc)];
+	}
+	height++;
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
+	if (info->fix.visual == FB_VISUAL_PSEUDOCOLOR) {
+		image.fg_color = attr_fgcol(p, c);
+		image.bg_color = attr_bgcol(p, c);
+	} else {
+		if (info->var.bits_per_pixel > 16) {
+			image.fg_color = ((u32*)info->pseudo_palette)[attr_fgcol(p,c)];
+			image.bg_color = ((u32*)info->pseudo_palette)[attr_bgcol(p,c)];
+		} else {
+			image.fg_color = ((u16*)info->pseudo_palette)[attr_fgcol(p,c)];
+			image.bg_color = ((u16*)info->pseudo_palette)[attr_bgcol(p,c)];
+		}
+	}
+	image.dx = xx * fontwidth(p);
+	image.dy = yy * fontheight(p);
+	image.width = fontwidth(p);
+	image.height = fontheight(p);
+	image.depth = 1;
+	image.data = p->fontdata + (c & charmask)*fontheight(p)*width;
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
+	if (info->fix.visual == FB_VISUAL_PSEUDOCOLOR) {
+		image.fg_color = attr_fgcol(p, *s);
+		image.bg_color = attr_bgcol(p, *s);
+	} else {
+		if (info->var.bits_per_pixel > 16) {
+			image.fg_color = ((u32*)info->pseudo_palette)[attr_fgcol(p,*s)];
+			image.bg_color = ((u32*)info->pseudo_palette)[attr_bgcol(p,*s)];
+		} else {
+			image.fg_color = ((u16*)info->pseudo_palette)[attr_fgcol(p,*s)];
+			image.bg_color = ((u16*)info->pseudo_palette)[attr_bgcol(p,*s)];
+	}
+}
+
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
+	if (info->fix.visual == FB_VISUAL_PSEUDOCOLOR)
+		region.color = attr_bgcol_ec(p, p->conp);
+	else {
+		if (info->var.bits_per_pixel > 16)
+			region.color = ((u32*)info->pseudo_palette)[attr_bgcol_ec(p,p->conp)];
+		else
+			region.color = ((u16*)info->pseudo_palette)[attr_bgcol_ec(p,p->conp)];
+	}
+	region.dx = xx * fontwidth(p);
+	region.dy = yy * fontheight(p);
+	region.width  = fontwidth(p);
+	region.height = fontheight(p); 
+	region.rop = ROP_XOR;
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
+	if (info->fix.visual == FB_VISUAL_PSEUDOCOLOR)
+		region.color = attr_bgcol_ec(p,vc);
+	else {
+		if (info->var.bits_per_pixel > 16)
+			region.color = ((u32*)info->pseudo_palette)[attr_bgcol_ec(p,vc)];
+		else
+			region.color = ((u16*)info->pseudo_palette)[attr_bgcol_ec(p,vc)];
+	}
+
+	if (rw && !bottom_only) {
+		region.dx = info->var.xoffset + rs;
+		region.dy = 0;
+		region.width  = rw;
+		region.height = info->var.yres_virtual;
+		region.rop = ROP_COPY;
+		info->fbops->fb_fillrect(info, &region); 
+	}
+
+	if (bh) {
+		region.dx = info->var.xoffset;
+                region.dy = info->var.yoffset + bs;
+                region.width  = rs;
+                region.height = bh;
+                region.rop = ROP_COPY;
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
+	fontwidthmask:	FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16)
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

