Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbTEKKjY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 06:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbTEKKWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 06:22:13 -0400
Received: from amsfep11-int.chello.nl ([213.46.243.20]:36177 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S261221AbTEKKVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 06:21:32 -0400
Date: Sun, 11 May 2003 12:30:59 +0200
Message-Id: <200305111030.h4BAUxrT019670@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Amifb updates
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amifb: Updates for fbdev changes in 2.5.66 and 2.5.68:
  - Last parameter of fb_{fillrect,copyarea,imageblit}() became const

--- linux-2.5.x/drivers/video/amifb.c	Tue Mar 25 10:06:58 2003
+++ linux-m68k-2.5.x/drivers/video/amifb.c	Wed Mar 26 12:54:31 2003
@@ -1123,9 +1123,12 @@
 static int amifb_blank(int blank, struct fb_info *info);
 static int amifb_pan_display(struct fb_var_screeninfo *var,
 			     struct fb_info *info);
-static void amifb_fillrect(struct fb_info *info, struct fb_fillrect *rect);
-static void amifb_copyarea(struct fb_info *info, struct fb_copyarea *region);
-static void amifb_imageblit(struct fb_info *info, struct fb_image *image);
+static void amifb_fillrect(struct fb_info *info,
+			   const struct fb_fillrect *rect);
+static void amifb_copyarea(struct fb_info *info,
+			   const struct fb_copyarea *region);
+static void amifb_imageblit(struct fb_info *info,
+			    const struct fb_image *image);
 static int amifb_ioctl(struct inode *inode, struct file *file,
 		       unsigned int cmd, unsigned long arg,
 		       struct fb_info *info);
@@ -1949,11 +1952,13 @@
 }
 
 
-static void amifb_fillrect(struct fb_info *info, struct fb_fillrect *rect)
+static void amifb_fillrect(struct fb_info *info,
+			   const struct fb_fillrect *rect)
 {
 	struct amifb_par *par = (struct amifb_par *)info->par;
 	int dst_idx, x2, y2;
 	unsigned long *dst;
+	u32 width, height;
 
 	if (!rect->width || !rect->height)
 		return;
@@ -1966,25 +1971,24 @@
 	y2 = rect->dy + rect->height;
 	x2 = x2 < info->var.xres_virtual ? x2 : info->var.xres_virtual;
 	y2 = y2 < info->var.yres_virtual ? y2 : info->var.yres_virtual;
-	rect->width = x2 - rect->dx;
-	rect->height = y2 - rect->dy;
+	width = x2 - rect->dx;
+	height = y2 - rect->dy;
 
 	dst = (unsigned long *)
 		((unsigned long)info->screen_base & ~(BYTES_PER_LONG-1));
 	dst_idx = ((unsigned long)info->screen_base & (BYTES_PER_LONG-1))*8;
 	dst_idx += rect->dy*par->next_line*8+rect->dx;
-	while (rect->height--) {
+	while (height--) {
 		switch (rect->rop) {
 		    case ROP_COPY:
 			fill_one_line(info->var.bits_per_pixel,
-				      par->next_plane, dst, dst_idx,
-				      rect->width, rect->color);
+				      par->next_plane, dst, dst_idx, width,
+				      rect->color);
 			break;
 
 		    case ROP_XOR:
-			xor_one_line(info->var.bits_per_pixel,
-				     par->next_plane, dst, dst_idx,
-				     rect->width, rect->color);
+			xor_one_line(info->var.bits_per_pixel, par->next_plane,
+				     dst, dst_idx, width, rect->color);
 			break;
 		}
 		dst_idx += par->next_line*8;
@@ -2026,47 +2030,38 @@
 }
 
 
-static void amifb_copyarea(struct fb_info *info, struct fb_copyarea *area)
+static void amifb_copyarea(struct fb_info *info,
+			   const struct fb_copyarea *area)
 {
 	struct amifb_par *par = (struct amifb_par *)info->par;
-	int x2, y2, old_dx, old_dy;
+	int x2, y2;
+	u32 dx, dy, sx, sy, width, height;
 	unsigned long *dst, *src;
-	int dst_idx, src_idx, height;
+	int dst_idx, src_idx;
 	int rev_copy = 0;
 
 	/* clip the destination */
-	old_dx = area->dx;
-	old_dy = area->dy;
-
-	/*
-	 * We could use hardware clipping but on many cards you get around
-	 * hardware clipping by writing to framebuffer directly.
-	 */
 	x2 = area->dx + area->width;
 	y2 = area->dy + area->height;
-	area->dx = area->dx > 0 ? area->dx : 0;
-	area->dy = area->dy > 0 ? area->dy : 0;
+	dx = area->dx > 0 ? area->dx : 0;
+	dy = area->dy > 0 ? area->dy : 0;
 	x2 = x2 < info->var.xres_virtual ? x2 : info->var.xres_virtual;
 	y2 = y2 < info->var.yres_virtual ? y2 : info->var.yres_virtual;
-	area->width = x2 - area->dx;
-	area->height = y2 - area->dy;
-
-	/* update sx1,sy1 */
-	area->sx += (area->dx - old_dx);
-	area->sy += (area->dy - old_dy);
+	width = x2 - dx;
+	height = y2 - dy;
 
-	height = area->height;
+	/* update sx,sy */
+	sx = area->sx + (dx - area->dx);
+	sy = area->sy + (dy - area->dy);
 
 	/* the source must be completely inside the virtual screen */
-	if (area->sx < 0 || area->sy < 0 ||
-	    (area->sx + area->width) > info->var.xres_virtual ||
-	    (area->sy + area->height) > info->var.yres_virtual)
+	if (sx < 0 || sy < 0 || (sx + width) > info->var.xres_virtual ||
+	    (sy + height) > info->var.yres_virtual)
 		return;
 
-	if (area->dy > area->sy ||
-	    (area->dy == area->sy && area->dx > area->sx)) {
-		area->dy += area->height;
-		area->sy += area->height;
+	if (dy > sy || (dy == sy && dx > sx)) {
+		dy += height;
+		sy += height;
 		rev_copy = 1;
 	}
 	dst = (unsigned long *)
@@ -2074,21 +2071,21 @@
 	src = dst;
 	dst_idx = ((unsigned long)info->screen_base & (BYTES_PER_LONG-1))*8;
 	src_idx = dst_idx;
-	dst_idx += area->dy*par->next_line*8+area->dx;
-	src_idx += area->sy*par->next_line*8+area->sx;
+	dst_idx += dy*par->next_line*8+dx;
+	src_idx += sy*par->next_line*8+sx;
 	if (rev_copy) {
 		while (height--) {
 			dst_idx -= par->next_line*8;
 			src_idx -= par->next_line*8;
 			copy_one_line_rev(info->var.bits_per_pixel,
 					  par->next_plane, dst, dst_idx, src,
-					  src_idx, area->width);
+					  src_idx, width);
 		}
 	} else {
 		while (height--) {
 			copy_one_line(info->var.bits_per_pixel,
 				      par->next_plane, dst, dst_idx, src,
-				      src_idx, area->width);
+				      src_idx, width);
 			dst_idx += par->next_line*8;
 			src_idx += par->next_line*8;
 		}
@@ -2125,7 +2122,7 @@
 }
 
 
-static void amifb_imageblit(struct fb_info *info, struct fb_image *image)
+static void amifb_imageblit(struct fb_info *info, const struct fb_image *image)
 {
 	struct amifb_par *par = (struct amifb_par *)info->par;
 	int x2, y2;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
