Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262824AbTEGENg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 00:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262830AbTEGENg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 00:13:36 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:31752 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262824AbTEGENS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 00:13:18 -0400
Date: Wed, 7 May 2003 05:25:48 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Fbdev patch
Message-ID: <Pine.LNX.4.44.0305070517450.2974-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is the newest patch. The patch fixes 3 problems. The first problem is 
set_con2fb did not test to see if we where mapping to a invalid VC. Now we 
do. The part of this patch which is the bulk of it aimed at combining
putcs_aligned and putcs_unaligned. Even at non 8 bit multiple wide fonts 
we often ended up having aligned data. So I used aligned data as often as 
possible. This is a nice performance boost. The final improvement was 
to change struct pixmap. Data is now transfered whole scanlines instead of
byte by byte. This was really needed to enhance speed on drawing fonts.
I also moved struct pixmap inside of __KERNEL__ to prevent userland 
versions of this file from defining this. Userland doesn't really need it
and it breaks userland apps because it is mixed with internal kernel data
defines. Please give it a try.

diff -uwrN -X /home/jsimmons/dontdiff linus-2.5/drivers/video/console/fbcon.c fbdev-2.5/drivers/video/console/fbcon.c
--- linus-2.5/drivers/video/console/fbcon.c	Mon Apr 21 18:13:48 2003
+++ fbdev-2.5/drivers/video/console/fbcon.c	Fri Apr 25 11:29:26 2003
@@ -294,104 +294,16 @@
  *	Maps a virtual console @unit to a frame buffer device
  *	@newidx.
  */
-void set_con2fb_map(int unit, int newidx)
+int set_con2fb_map(int unit, int newidx)
 {
 	struct vc_data *vc = vc_cons[unit].d;
 
+	if (!vc)
+		return -ENODEV;
 	con2fb_map[unit] = newidx;
 	fbcon_is_default = (vc->vc_sw == &fb_con) ? 1 : 0;
 	take_over_console(&fb_con, unit, unit, fbcon_is_default);
-}
-
-/*
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
+	return 0;
 }
 
 /*
@@ -428,62 +340,69 @@
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
+	unsigned int idx = vc->vc_font.width >> 3;
+	u8 *src, *dst, *dst0, mask;
 	struct fb_image image;
-	u8 *src, *dst;
+	u16 c = scr_readw(s);
 
-	image.dx = xpos * vc->vc_font.width;
-	image.dy = ypos * vc->vc_font.height;
-	image.width = vc->vc_font.width;
-	image.height = vc->vc_font.height;
 	image.fg_color = attr_fgcol(fgshift, c);
 	image.bg_color = attr_bgcol(bgshift, c);
+	image.dx = xx * vc->vc_font.width;
+	image.dy = yy * vc->vc_font.height;
+	image.height = vc->vc_font.height;
 	image.depth = 1;
 
-	pitch = width + scan_align;
+	while (count) {
+		if (count > maxcnt)
+			cnt = k = maxcnt;
+		else
+			cnt = k = count;
+
+		image.width = vc->vc_font.width * cnt;
+		pitch = ((image.width + 7) >> 3) + scan_align;
 	pitch &= ~scan_align;
-	size = pitch * vc->vc_font.height;
-	size += buf_align;
+		size = pitch * vc->vc_font.height + buf_align;
 	size &= ~buf_align;
-	dst = info->pixmap.addr + fb_get_buffer_offset(info, size);
-	image.data = dst;
-	src = vc->vc_font.data + (c & charmask) * vc->vc_font.height * width;
-
-	move_buf_aligned(info, dst, src, pitch, width, image.height);
+		dst0 = info->pixmap.addr + fb_get_buffer_offset(info, size);
+		image.data = dst0;
+		while (k--) {
+			src = vc->vc_font.data + (scr_readw(s++) & charmask)*cellsize;
+			dst = dst0;
 
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
 	info->fbops->fb_imageblit(info, &image);
+		image.dx += cnt * vc->vc_font.width;
+		count -= cnt;
 	atomic_dec(&info->pixmap.count);
 	smp_mb__after_atomic_dec();
 }
-
-void accel_putcs(struct vc_data *vc, struct fb_info *info,
-			const unsigned short *s, int count, int yy, int xx)
-{
-	int bgshift = (vc->vc_hi_font_mask) ? 13 : 12;
-	int fgshift = (vc->vc_hi_font_mask) ? 9 : 8;
-	struct fb_image image;
-	u16 c = scr_readw(s);
-
-	image.fg_color = attr_fgcol(fgshift, c);
-	image.bg_color = attr_bgcol(bgshift, c);
-	image.dx = xx * vc->vc_font.width;
-	image.dy = yy * vc->vc_font.height;
-	image.height = vc->vc_font.height;
-	image.depth = 1;
-
-	if (!(vc->vc_font.width & 7))
-               putcs_aligned(vc, info, &image, count, s);
-        else
-               putcs_unaligned(vc, info, &image, count, s);
 }
 
 void accel_clear_margins(struct vc_data *vc, struct fb_info *info,
@@ -724,15 +643,13 @@
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
@@ -956,11 +873,19 @@
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
+	unsigned int size, pitch;
+	struct fb_image image;
+	u8 *src, *dst;
 
 	if (!info->fbops->fb_blank && console_blanked)
 		return;
@@ -968,7 +893,30 @@
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
@@ -1045,6 +993,11 @@
 			cursor.image.height = vc->vc_font.height;
 			cursor.image.width = vc->vc_font.width;
 			cursor.set |= FB_CUR_SETSIZE;
+		}
+
+		if (info->cursor.hot.x || info->cursor.hot.y) {
+			cursor.hot.x = cursor.hot.y = 0;
+			cursor.set |= FB_CUR_SETHOT;
 		}
 
 		if ((cursor.set & FB_CUR_SETSIZE) || ((vc->vc_cursor_type & 0x0f) != p->cursor_shape)) {
diff -uwrN -X /home/jsimmons/dontdiff linus-2.5/drivers/video/console/fbcon.h fbdev-2.5/drivers/video/console/fbcon.h
--- linus-2.5/drivers/video/console/fbcon.h	Tue Apr 15 10:44:31 2003
+++ fbdev-2.5/drivers/video/console/fbcon.h	Thu Apr 24 16:18:06 2003
@@ -38,7 +38,7 @@
 
 /* drivers/video/console/fbcon.c */
 extern char con2fb_map[MAX_NR_CONSOLES];
-extern void set_con2fb_map(int unit, int newidx);
+extern int set_con2fb_map(int unit, int newidx);
 
     /*
      *  Attribute Decoding
diff -uwrN -X /home/jsimmons/dontdiff linus-2.5/drivers/video/fbmem.c fbdev-2.5/drivers/video/fbmem.c
--- linus-2.5/drivers/video/fbmem.c	Fri Apr 25 00:11:39 2003
+++ fbdev-2.5/drivers/video/fbmem.c	Tue May  6 11:39:33 2003
@@ -25,7 +25,6 @@
 #include <linux/mman.h>
 #include <linux/tty.h>
 #include <linux/init.h>
-#include <linux/linux_logo.h>
 #include <linux/proc_fs.h>
 #ifdef CONFIG_KMOD
 #include <linux/kmod.h>
@@ -656,7 +654,7 @@
 	}
 
 	/* Return if no suitable logo was found */
-	fb_logo.logo = fb_find_logo(info->var.bits_per_pixel);
+	fb_logo.logo = find_logo(info->var.bits_per_pixel);
 	
 	if (!fb_logo.logo || fb_logo.logo->height > info->var.yres) {
 		fb_logo.logo = NULL;
@@ -726,8 +724,6 @@
 	     x <= info->var.xres-fb_logo.logo->width; x += (fb_logo.logo->width + 8)) {
 		image.dx = x;
 		info->fbops->fb_imageblit(info, &image);
-		//atomic_dec(&info->pixmap.count);
-		//smp_mb__after_atomic_dec();
 	}
 	
 	if (palette != NULL)
diff -uwrN -X /home/jsimmons/dontdiff linus-2.5/drivers/video/logo/logo.c fbdev-2.5/drivers/video/logo/logo.c
--- linus-2.5/drivers/video/logo/logo.c	Sun Apr 20 16:58:27 2003
+++ fbdev-2.5/drivers/video/logo/logo.c	Tue Apr 29 10:46:43 2003
@@ -32,8 +32,7 @@
 extern const struct linux_logo logo_superh_vga16;
 extern const struct linux_logo logo_superh_clut224;
 
-
-const struct linux_logo *fb_find_logo(int depth)
+const struct linux_logo *find_logo(int depth)
 {
 	const struct linux_logo *logo = 0;
 
diff -uwrN -X /home/jsimmons/dontdiff linus-2.5/include/linux/fb.h fbdev-2.5/include/linux/fb.h
--- linus-2.5/include/linux/fb.h	Fri Apr 25 00:11:41 2003
+++ fbdev-2.5/include/linux/fb.h	Tue May  6 20:46:37 2003
@@ -2,7 +2,6 @@
 #define _LINUX_FB_H
 
 #include <linux/tty.h>
-#include <linux/workqueue.h>
 #include <asm/types.h>
 #include <asm/io.h>
 
@@ -326,28 +325,31 @@
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
+	u8  *addr;		/* pointer to memory 			*/
+	u32 size;		/* size of buffer in bytes 		*/
+	u32 offset;		/* current offset to buffer 		*/
+	u32 buf_align;		/* byte alignment of each bitmap 	*/
+	u32 scan_align;		/* alignment per scanline 		*/
+	u32 flags;		/* see FB_PIXMAP_* 			*/
+	spinlock_t lock;	/* spinlock 				*/
+	atomic_t count;
 					  /* access methods                */
 	void (*outbuf)(u8 *dst, u8 *addr, unsigned int size); 
 	u8   (*inbuf) (u8 *addr);
-	spinlock_t lock;                  /* spinlock                      */
-	atomic_t count;
 };
-#ifdef __KERNEL__
-
-#include <linux/fs.h>
-#include <linux/init.h>
 
 struct fb_info;
 struct vm_area_struct;
@@ -398,7 +400,6 @@
 struct fb_info {
    int node;
    int flags;
-   int open;                            /* Has this been open already ? */
 #define FBINFO_FLAG_MODULE	1	/* Low-level driver is a module */
    struct fb_var_screeninfo var;        /* Current var */
    struct fb_fix_screeninfo fix;        /* Current fix */
@@ -410,8 +411,8 @@
    struct fb_ops *fbops;
    char *screen_base;                   /* Virtual address */
    struct vc_data *display_fg;		/* Console visible on this display */
-   int currcon;				/* Current VC. */	
    void *pseudo_palette;                /* Fake palette of 16 colors */ 
+	int currcon;			/* Current VC. */
    /* From here on everything is device dependent */
    void *par;	
 };
diff -uwrN -X /home/jsimmons/dontdiff linus-2.5/include/linux/linux_logo.h fbdev-2.5/include/linux/linux_logo.h
--- linus-2.5/include/linux/linux_logo.h	Sun Apr 20 16:58:29 2003
+++ fbdev-2.5/include/linux/linux_logo.h	Tue Apr 29 10:48:11 2003
@@ -16,13 +16,11 @@
 
 #include <linux/init.h>
 
-
 #define LINUX_LOGO_MONO		1	/* monochrome black/white */
 #define LINUX_LOGO_VGA16	2	/* 16 colors VGA text palette */
 #define LINUX_LOGO_CLUT224	3	/* 224 colors */
 #define LINUX_LOGO_GRAY256	4	/* 256 levels grayscale */
 
-
 struct linux_logo {
 	int type;			/* one of LINUX_LOGO_* */
 	unsigned int width;
@@ -32,6 +30,6 @@
 	const unsigned char *data;
 };
 
-extern const struct linux_logo *fb_find_logo(int depth);
+extern const struct linux_logo *find_logo(int depth);
 
 #endif /* _LINUX_LINUX_LOGO_H */

