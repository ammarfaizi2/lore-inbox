Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262956AbTELXuI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 19:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262957AbTELXuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 19:50:07 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:4627 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262956AbTELXt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 19:49:58 -0400
Date: Tue, 13 May 2003 01:02:40 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BK FBDEV] String drawing optimizations.
Message-ID: <Pine.LNX.4.44.0305130049520.14641-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please test. The pixmap code in the framebuffer layer was designed to 
align the font data. For some hardware it is required that each scanline 
end on a byte boundary but for some  it was to be 32 bit aligned. So the
solution was to take the image data and padded it to what the hardware 
needs. At present it does this by coping on byte at a time. This is just 
plain awful. So this patch copies data a whole scanline at a time. It is
a big performance boost. Please test before I send it to Linus. Thank 
you.

At present the code that byte padded the images of the fonts 
to draw to the screen do

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1042.34.1 -> 1.1042.34.2
#	  include/linux/fb.h	1.51    -> 1.52   
#	drivers/video/console/fbcon.c	1.100   -> 1.101  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/04/22	jsimmons@kozmo.(none)	1.1042.34.2
# [FBDEV] Moved pixmap to the kernel side of the header. Will not be needed for ioctl calls at the present time.
# 
# [FBCON] Lots more optimizations.
# --------------------------------------------
#
diff -Nru a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
--- a/drivers/video/console/fbcon.c	Mon May 12 13:39:09 2003
+++ b/drivers/video/console/fbcon.c	Mon May 12 13:39:09 2003
@@ -304,97 +304,6 @@
 }
 
 /*
- * drawing helpers
- */
-static void putcs_unaligned(struct vc_data *vc, struct fb_info *info,
-			    struct fb_image *image, int count,
-			    const unsigned short *s)
-{
-	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
-	unsigned int width = (vc->vc_font.width + 7) >> 3;
-	unsigned int cellsize = vc->vc_font.height * width;
-	unsigned int maxcnt = info->pixmap.size/cellsize;
-	unsigned int shift_low = 0, mod = vc->vc_font.width % 8;
-	unsigned int shift_high = 8, size, pitch, cnt, k;
-	unsigned int buf_align = info->pixmap.buf_align - 1;
-	unsigned int scan_align = info->pixmap.scan_align - 1;
-	unsigned int idx = vc->vc_font.width >> 3;
-	u8 mask, *src, *dst, *dst0;
-
-	while (count) {
-		if (count > maxcnt)
-			cnt = k = maxcnt;
-		else
-			cnt = k = count;
-
-		image->width = vc->vc_font.width * cnt;
-		pitch = ((image->width + 7) >> 3) + scan_align;
-		pitch &= ~scan_align;
-		size = pitch * vc->vc_font.height + buf_align;
-		size &= ~buf_align;
-		dst0 = info->pixmap.addr + fb_get_buffer_offset(info, size);
-		image->data = dst0;
-		while (k--) {
-			src = vc->vc_font.data + (scr_readw(s++) & charmask)*
-			cellsize;
-			dst = dst0;
-			mask = (u8) (0xfff << shift_high);
-			move_buf_unaligned(info, dst, src, pitch, image->height,
-					mask, shift_high, shift_low, mod, idx);
-			shift_low += mod;
-			dst0 += (shift_low >= 8) ? width : width - 1;
-			shift_low &= 7;
-			shift_high = 8 - shift_low;
-		}
-		info->fbops->fb_imageblit(info, image);
-		image->dx += cnt * vc->vc_font.width;
-		count -= cnt;
-		atomic_dec(&info->pixmap.count);
-		smp_mb__after_atomic_dec();
-	}
-}
-
-static void putcs_aligned(struct vc_data *vc, struct fb_info *info,
-			  struct fb_image *image, int count,
-			  const unsigned short *s)
-{
-	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
-	unsigned int width = vc->vc_font.width >> 3;
-	unsigned int cellsize = vc->vc_font.height * width;
-	unsigned int maxcnt = info->pixmap.size/cellsize;
-	unsigned int scan_align = info->pixmap.scan_align - 1;
-	unsigned int buf_align = info->pixmap.buf_align - 1;
-	unsigned int pitch, cnt, size, k;
-	u8 *src, *dst, *dst0;
-
-	while (count) {
-		if (count > maxcnt)
-			cnt = k = maxcnt;
-		else
-			cnt = k = count;
-		
-		pitch = width * cnt + scan_align;
-		pitch &= ~scan_align;
-		size = pitch * vc->vc_font.height + buf_align;
-		size &= ~buf_align;
-		image->width = vc->vc_font.width * cnt;
-		dst0 = info->pixmap.addr + fb_get_buffer_offset(info, size);
-		image->data = dst0;
-		while (k--) {
-			src = vc->vc_font.data + (scr_readw(s++)&charmask)*cellsize;
-			dst = dst0;
-			move_buf_aligned(info, dst, src, pitch, width, image->height);
-			dst0 += width;
-		}
-		info->fbops->fb_imageblit(info, image);
-		image->dx += cnt * vc->vc_font.width;
-		count -= cnt;
-		atomic_dec(&info->pixmap.count);
-		smp_mb__after_atomic_dec();
-	}
-}
-
-/*
  * Accelerated handlers.
  */
 void accel_bmove(struct vc_data *vc, struct fb_info *info, int sy, 
@@ -428,48 +337,21 @@
 	info->fbops->fb_fillrect(info, &region);
 }	
 
-static void accel_putc(struct vc_data *vc, struct fb_info *info,
-                      int c, int ypos, int xpos)
+void accel_putcs(struct vc_data *vc, struct fb_info *info,
+			const unsigned short *s, int count, int yy, int xx)
 {
 	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
 	unsigned int width = (vc->vc_font.width + 7) >> 3;
+	unsigned int cellsize = vc->vc_font.height * width;
+	unsigned int maxcnt = info->pixmap.size/cellsize;
 	unsigned int scan_align = info->pixmap.scan_align - 1;
 	unsigned int buf_align = info->pixmap.buf_align - 1;
+	unsigned int shift_low = 0, mod = vc->vc_font.width % 8;
+	unsigned int shift_high = 8, pitch, cnt, size, k;
 	int bgshift = (vc->vc_hi_font_mask) ? 13 : 12;
 	int fgshift = (vc->vc_hi_font_mask) ? 9 : 8;
-	unsigned int size, pitch;
-	struct fb_image image;
-	u8 *src, *dst;
-
-	image.dx = xpos * vc->vc_font.width;
-	image.dy = ypos * vc->vc_font.height;
-	image.width = vc->vc_font.width;
-	image.height = vc->vc_font.height;
-	image.fg_color = attr_fgcol(fgshift, c);
-	image.bg_color = attr_bgcol(bgshift, c);
-	image.depth = 1;
-
-	pitch = width + scan_align;
-	pitch &= ~scan_align;
-	size = pitch * vc->vc_font.height;
-	size += buf_align;
-	size &= ~buf_align;
-	dst = info->pixmap.addr + fb_get_buffer_offset(info, size);
-	image.data = dst;
-	src = vc->vc_font.data + (c & charmask) * vc->vc_font.height * width;
-
-	move_buf_aligned(info, dst, src, pitch, width, image.height);
-
-	info->fbops->fb_imageblit(info, &image);
-	atomic_dec(&info->pixmap.count);
-	smp_mb__after_atomic_dec();
-}
-
-void accel_putcs(struct vc_data *vc, struct fb_info *info,
-			const unsigned short *s, int count, int yy, int xx)
-{
-	int bgshift = (vc->vc_hi_font_mask) ? 13 : 12;
-	int fgshift = (vc->vc_hi_font_mask) ? 9 : 8;
+	unsigned int idx = vc->vc_font.width >> 3;
+	u8 *src, *dst, *dst0, mask;
 	struct fb_image image;
 	u16 c = scr_readw(s);
 
@@ -480,10 +362,44 @@
 	image.height = vc->vc_font.height;
 	image.depth = 1;
 
-	if (!(vc->vc_font.width & 7))
-               putcs_aligned(vc, info, &image, count, s);
-        else
-               putcs_unaligned(vc, info, &image, count, s);
+	while (count) {
+		if (count > maxcnt)
+			cnt = k = maxcnt;
+		else
+			cnt = k = count;
+
+		image.width = vc->vc_font.width * cnt;
+		pitch = ((image.width + 7) >> 3) + scan_align;
+		pitch &= ~scan_align;
+		size = pitch * vc->vc_font.height + buf_align;
+		size &= ~buf_align;
+		dst0 = info->pixmap.addr + fb_get_buffer_offset(info, size);
+		image.data = dst0;
+		while (k--) {
+			src = vc->vc_font.data + (scr_readw(s++) & charmask)*cellsize;
+			dst = dst0;
+		
+			if (mod) {
+				mask = (u8) (0xfff << shift_high);
+				move_buf_unaligned(info, dst, src, pitch,
+						   image.height, mask, shift_high, 
+						   shift_low, mod, idx);
+				shift_low += mod;
+				dst0 += (shift_low >= 8) ? width : width - 1;
+				shift_low &= 7;
+				shift_high = 8 - shift_low;
+			} else {
+				move_buf_aligned(info, dst, src, pitch, idx, 
+						 image.height);
+				dst0 += width;
+			}	
+		}
+		info->fbops->fb_imageblit(info, &image);
+		image.dx += cnt * vc->vc_font.width;
+		count -= cnt;
+		atomic_dec(&info->pixmap.count);
+		smp_mb__after_atomic_dec();
+	}
 }
 
 void accel_clear_margins(struct vc_data *vc, struct fb_info *info,
@@ -724,15 +640,13 @@
 static void fbcon_set_display(struct vc_data *vc, int init, int logo)
 {
 	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
+	int nr_rows, nr_cols, old_rows, old_cols, i, charcnt = 256;
 	struct display *p = &fb_display[vc->vc_num];
-	int nr_rows, nr_cols;
-	int old_rows, old_cols;
 	unsigned short *save = NULL, *r, *q;
-	int i, charcnt = 256;
 	struct font_desc *font;
 
 	if (vc->vc_num != fg_console || (info->flags & FBINFO_FLAG_MODULE) ||
-	    info->fix.type == FB_TYPE_TEXT)
+	    (info->fix.type == FB_TYPE_TEXT))
 		logo = 0;
 
 	info->var.xoffset = info->var.yoffset = p->yscroll = 0;	/* reset wrap/pan */
@@ -956,19 +870,50 @@
 		accel_clear(vc, info, real_y(p, sy), sx, height, width);
 }
 
-
 static void fbcon_putc(struct vc_data *vc, int c, int ypos, int xpos)
 {
 	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
+	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
+	unsigned int scan_align = info->pixmap.scan_align - 1;
+	unsigned int buf_align = info->pixmap.buf_align - 1;
+	unsigned int width = (vc->vc_font.width + 7) >> 3;
+	int bgshift = (vc->vc_hi_font_mask) ? 13 : 12;
+	int fgshift = (vc->vc_hi_font_mask) ? 9 : 8;
 	struct display *p = &fb_display[vc->vc_num];
-
+	unsigned int size, pitch;
+	struct fb_image image;
+	u8 *src, *dst;
+	
 	if (!info->fbops->fb_blank && console_blanked)
 		return;
 
 	if (vt_cons[vc->vc_num]->vc_mode != KD_TEXT)
 		return;
 
-	accel_putc(vc, info, c, real_y(p, ypos), xpos);
+	image.dx = xpos * vc->vc_font.width;
+	image.dy = real_y(p, ypos) * vc->vc_font.height;
+	image.width = vc->vc_font.width;
+	image.height = vc->vc_font.height;
+	image.fg_color = attr_fgcol(fgshift, c);
+	image.bg_color = attr_bgcol(bgshift, c);
+	image.depth = 1;
+
+	src = vc->vc_font.data + (c & charmask) * vc->vc_font.height * width;
+
+	pitch = width + scan_align;
+	pitch &= ~scan_align;
+	size = pitch * vc->vc_font.height;
+	size += buf_align;
+	size &= ~buf_align;
+
+	dst = info->pixmap.addr + fb_get_buffer_offset(info, size);
+	image.data = dst;
+	
+	move_buf_aligned(info, dst, src, pitch, width, image.height);
+
+	info->fbops->fb_imageblit(info, &image);
+	atomic_dec(&info->pixmap.count);
+	smp_mb__after_atomic_dec();
 }
 
 static void fbcon_putcs(struct vc_data *vc, const unsigned short *s,
diff -Nru a/include/linux/fb.h b/include/linux/fb.h
--- a/include/linux/fb.h	Mon May 12 13:39:09 2003
+++ b/include/linux/fb.h	Mon May 12 13:39:09 2003
@@ -2,7 +2,6 @@
 #define _LINUX_FB_H
 
 #include <linux/tty.h>
-#include <linux/workqueue.h>
 #include <asm/types.h>
 #include <asm/io.h>
 
@@ -326,29 +325,31 @@
 	struct fb_image	image;	/* Cursor image */
 };
 
+#ifdef __KERNEL__
+
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/workqueue.h>
+#include <linux/devfs_fs_kernel.h>
+
 #define FB_PIXMAP_DEFAULT 1     /* used internally by fbcon */
 #define FB_PIXMAP_SYSTEM  2     /* memory is in system RAM  */
 #define FB_PIXMAP_IO      4     /* memory is iomapped       */
 #define FB_PIXMAP_SYNC    256   /* set if GPU can DMA       */
 
 struct fb_pixmap {
-        __u8  *addr;                      /* pointer to memory             */  
-	__u32 size;                       /* size of buffer in bytes       */
-	__u32 offset;                     /* current offset to buffer      */
-	__u32 buf_align;                  /* byte alignment of each bitmap */
-	__u32 scan_align;                 /* alignment per scanline        */
-	__u32 flags;                      /* see FB_PIXMAP_*               */
-					  /* access methods                */
+	u8  *addr;		/* pointer to memory 			*/
+	u32 size;		/* size of buffer in bytes 		*/
+	u32 offset;		/* current offset to buffer 		*/
+	u32 buf_align;		/* byte alignment of each bitmap 	*/
+	u32 scan_align;		/* alignment per scanline 		*/
+	u32 flags;		/* see FB_PIXMAP_* 			*/
+	spinlock_t lock;	/* spinlock 				*/
+	atomic_t count;
+	/* access methods */
 	void (*outbuf)(u8 *dst, u8 *addr, unsigned int size); 
 	u8   (*inbuf) (u8 *addr);
-	spinlock_t lock;                  /* spinlock                      */
-	atomic_t count;
 };
-#ifdef __KERNEL__
-
-#include <linux/fs.h>
-#include <linux/init.h>
-#include <linux/devfs_fs_kernel.h>
 
 struct fb_info;
 struct vm_area_struct;
@@ -397,24 +398,23 @@
 };
 
 struct fb_info {
-   kdev_t node;
-   int flags;
-   int open;                            /* Has this been open already ? */
+	kdev_t node;
+	int flags;
 #define FBINFO_FLAG_MODULE	1	/* Low-level driver is a module */
-   struct fb_var_screeninfo var;        /* Current var */
-   struct fb_fix_screeninfo fix;        /* Current fix */
-   struct fb_monspecs monspecs;         /* Current Monitor specs */
-   struct fb_cursor cursor;		/* Current cursor */	
-   struct work_struct queue;		/* Framebuffer event queue */
-   struct fb_pixmap pixmap;	        /* Current pixmap */
-   struct fb_cmap cmap;                 /* Current cmap */
-   struct fb_ops *fbops;
-   char *screen_base;                   /* Virtual address */
-   struct vc_data *display_fg;		/* Console visible on this display */
-   int currcon;				/* Current VC. */	
-   void *pseudo_palette;                /* Fake palette of 16 colors */ 
-   /* From here on everything is device dependent */
-   void *par;	
+	struct fb_var_screeninfo var;	/* Current var */
+	struct fb_fix_screeninfo fix;	/* Current fix */
+	struct fb_monspecs monspecs;	/* Current Monitor specs */
+	struct fb_cursor cursor;	/* Current cursor */	
+	struct work_struct queue;	/* Framebuffer event queue */
+	struct fb_pixmap pixmap;	/* Current pixmap */
+	struct fb_cmap cmap;		/* Current cmap */
+	struct fb_ops *fbops;
+	char *screen_base;		/* Virtual address */
+	struct vc_data *display_fg;	/* Console visible on this display */
+	void *pseudo_palette;		/* Fake palette of 16 colors */ 
+	int currcon;			/* Current VC. */	
+	/* From here on everything is device dependent */
+	void *par;	
 };
 
 #ifdef MODULE

