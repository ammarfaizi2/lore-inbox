Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265661AbUBJGgY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 01:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265663AbUBJGgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 01:36:24 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:21767 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265661AbUBJGgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 01:36:05 -0500
Date: Tue, 10 Feb 2004 06:36:03 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Newest fbdev patch to go mainline.
Message-ID: <Pine.LNX.4.44.0402100634430.32169-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


First step to incorporate the new cursor api. It s abig patch so I broke 
it into pieces. Give it a try.


diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/console/fbcon.c fbdev-2.6/drivers/video/console/fbcon.c
--- linus-2.6/drivers/video/console/fbcon.c	2004-02-04 16:09:28.000000000 -0800
+++ fbdev-2.6/drivers/video/console/fbcon.c	2004-02-09 05:54:59.000000000 -0800
@@ -323,7 +323,7 @@
 	unsigned int buf_align = info->pixmap.buf_align - 1;
 	unsigned int scan_align = info->pixmap.scan_align - 1;
 	unsigned int idx = vc->vc_font.width >> 3;
-	u8 mask, *src, *dst, *dst0;
+	u8 *src, *dst, *dst0;
 
 	while (count) {
 		if (count > maxcnt)
@@ -342,9 +342,9 @@
 			src = vc->vc_font.data + (scr_readw(s++) & charmask)*
 			cellsize;
 			dst = dst0;
-			mask = (u8) (0xfff << shift_high);
-			move_buf_unaligned(info, dst, src, pitch, image->height,
-					mask, shift_high, shift_low, mod, idx);
+			fb_move_buf_unaligned(info, &info->pixmap, dst, pitch, src,
+						idx, image->height, shift_high, 
+						shift_low, mod);
 			shift_low += mod;
 			dst0 += (shift_low >= 8) ? width : width - 1;
 			shift_low &= 7;
@@ -387,7 +387,8 @@
 		while (k--) {
 			src = vc->vc_font.data + (scr_readw(s++)&charmask)*cellsize;
 			dst = dst0;
-			move_buf_aligned(info, dst, src, pitch, width, image->height);
+			fb_move_buf_aligned(info, &info->pixmap, dst, pitch, src, 
+						width, image->height);
 			dst0 += width;
 		}
 		info->fbops->fb_imageblit(info, image);
@@ -462,7 +463,7 @@
 	image.data = dst;
 	src = vc->vc_font.data + (c & charmask) * vc->vc_font.height * width;
 
-	move_buf_aligned(info, dst, src, pitch, width, image.height);
+	fb_move_buf_aligned(info, &info->pixmap, dst, pitch, src, width, image.height);
 
 	info->fbops->fb_imageblit(info, &image);
 	atomic_dec(&info->pixmap.count);
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/fbmem.c fbdev-2.6/drivers/video/fbmem.c
--- linus-2.6/drivers/video/fbmem.c	2004-02-08 08:58:43.000000000 -0800
+++ fbdev-2.6/drivers/video/fbmem.c	2004-02-09 05:42:18.000000000 -0800
@@ -389,7 +389,7 @@
 };
 
 #define NUM_FB_DRIVERS	(sizeof(fb_drivers)/sizeof(*fb_drivers))
-#define FBPIXMAPSIZE	8192
+#define FBPIXMAPSIZE	16384
 
 extern const char *global_mode_option;
 
@@ -405,52 +405,54 @@
 /*
  * Drawing helpers.
  */
-u8 sys_inbuf(u8 *src)
+u8 sys_inbuf(struct fb_info *info, u8 *src)
 {	
 	return *src;
 }
 
-void sys_outbuf(u8 *src, u8 *dst, unsigned int size)
+void sys_outbuf(struct fb_info *info, u8 *dst, u8 *src, unsigned int size)
 {
 	memcpy(dst, src, size);
 }	
 
-void move_buf_aligned(struct fb_info *info, u8 *dst, u8 *src, u32 d_pitch, 
-			u32 s_pitch, u32 height)
+void fb_move_buf_aligned(struct fb_info *info, struct fb_pixmap *buf,
+			u8 *dst, u32 d_pitch, u8 *src, u32 s_pitch,
+			u32 height)
 {
 	int i;
 
 	for (i = height; i--; ) {
-		info->pixmap.outbuf(src, dst, s_pitch);
+		buf->outbuf(info, dst, src, s_pitch);
 		src += s_pitch;
 		dst += d_pitch;
 	}
 }
 
-void move_buf_unaligned(struct fb_info *info, u8 *dst, u8 *src, u32 d_pitch, 
-			u32 height, u32 mask, u32 shift_high, u32 shift_low,
-			u32 mod, u32 idx)
+void fb_move_buf_unaligned(struct fb_info *info, struct fb_pixmap *buf, 
+			u8 *dst, u32 d_pitch, u8 *src, u32 idx,
+			u32 height, u32 shift_high, u32 shift_low,
+			u32 mod)
 {
+	u8 mask = (u8) (0xfff << shift_high), tmp;
 	int i, j;
-	u8 tmp;
 
 	for (i = height; i--; ) {
 		for (j = 0; j < idx; j++) {
-			tmp = info->pixmap.inbuf(dst+j);
+			tmp = buf->inbuf(info, dst+j);
 			tmp &= mask;
 			tmp |= *src >> shift_low;
-			info->pixmap.outbuf(&tmp, dst+j, 1);
+			buf->outbuf(info, dst+j, &tmp, 1);
 			tmp = *src << shift_high;
-			info->pixmap.outbuf(&tmp, dst+j+1, 1);
+			buf->outbuf(info, dst+j+1, &tmp, 1);
 			src++;
 		}
-		tmp = info->pixmap.inbuf(dst+idx);
+		tmp = buf->inbuf(info, dst+idx);
 		tmp &= mask;
 		tmp |= *src >> shift_low;
-		info->pixmap.outbuf(&tmp, dst+idx, 1);
+		buf->outbuf(info, dst+idx, &tmp, 1);
 		if (shift_high < mod) {
 			tmp = *src << shift_high;
-			info->pixmap.outbuf(&tmp, dst+idx+1, 1);
+			buf->outbuf(info, dst+idx+1, &tmp, 1);
 		}	
 		src++;
 		dst += d_pitch;
@@ -1397,7 +1399,7 @@
 EXPORT_SYMBOL(fb_blank);
 EXPORT_SYMBOL(fb_pan_display);
 EXPORT_SYMBOL(fb_get_buffer_offset);
-EXPORT_SYMBOL(move_buf_unaligned);
-EXPORT_SYMBOL(move_buf_aligned);
+EXPORT_SYMBOL(fb_move_buf_unaligned);
+EXPORT_SYMBOL(fb_move_buf_aligned);
 
 MODULE_LICENSE("GPL");
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/softcursor.c fbdev-2.6/drivers/video/softcursor.c
--- linus-2.6/drivers/video/softcursor.c	2004-01-27 19:48:12.000000000 -0800
+++ fbdev-2.6/drivers/video/softcursor.c	2004-02-09 05:51:57.000000000 -0800
@@ -70,7 +70,7 @@
 	} else 
 		memcpy(src, cursor->image.data, dsize);
 	
-	move_buf_aligned(info, dst, src, d_pitch, s_pitch, info->cursor.image.height);
+	fb_move_buf_aligned(info, &info->pixmap, dst, d_pitch, src, s_pitch, info->cursor.image.height);
 	info->cursor.image.data = dst;
 	
 	info->fbops->fb_imageblit(info, &info->cursor.image);
diff -urN -X /home/jsimmons/dontdiff linus-2.6/include/linux/fb.h fbdev-2.6/include/linux/fb.h
--- linus-2.6/include/linux/fb.h	2004-02-08 08:58:43.000000000 -0800
+++ fbdev-2.6/include/linux/fb.h	2004-02-09 05:50:43.000000000 -0800
@@ -347,23 +347,23 @@
  * format the hardware needs.
  */
 
-#define FB_PIXMAP_DEFAULT 1     /* used internally by fbcon */
-#define FB_PIXMAP_SYSTEM  2     /* memory is in system RAM  */
-#define FB_PIXMAP_IO      4     /* memory is iomapped       */
-#define FB_PIXMAP_SYNC    256   /* set if GPU can DMA       */
+#define FB_PIXMAP_DEFAULT 1     /* used internally by fbcon	*/
+#define FB_PIXMAP_SYSTEM  2     /* memory is in system RAM	*/
+#define FB_PIXMAP_IO      4     /* memory is iomapped		*/
+#define FB_PIXMAP_SYNC    256   /* set if GPU can DMA		*/
 
 struct fb_pixmap {
-	u8 *addr;		/* pointer to memory                    */
-	u32 size;		/* size of buffer in bytes              */
-	u32 offset;		/* current offset to buffer             */
-	u32 buf_align;		/* byte alignment of each bitmap        */
-	u32 scan_align;		/* alignment per scanline               */
-	u32 access_align;	/* alignment per read/write             */
-	u32 flags;		/* see FB_PIXMAP_*                      */
-					  /* access methods                */
-	void (*outbuf)(u8 *dst, u8 *addr, unsigned int size); 
-	u8   (*inbuf) (u8 *addr);
-	spinlock_t lock;                  /* spinlock                      */
+	u8 *addr;		/* pointer to memory			*/
+	u32 size;		/* size of buffer in bytes		*/
+	u32 offset;		/* current offset to buffer		*/
+	u32 buf_align;		/* byte alignment of each bitmap	*/
+	u32 scan_align;		/* alignment per scanline		*/
+	u32 access_align;	/* alignment per read/write		*/
+	u32 flags;		/* see FB_PIXMAP_*			*/
+				/* access methods			*/
+	void (*outbuf)(struct fb_info *info, u8 *addr, u8 *src, unsigned int size);
+	u8   (*inbuf) (struct fb_info *info, u8 *addr);
+	spinlock_t lock;	/* spinlock				*/
 	atomic_t count;
 };
 
@@ -520,12 +520,12 @@
 extern int fb_prepare_logo(struct fb_info *fb_info);
 extern int fb_show_logo(struct fb_info *fb_info);
 extern u32 fb_get_buffer_offset(struct fb_info *info, u32 size);
-extern void move_buf_unaligned(struct fb_info *info, u8 * dst, u8 * src,
-				u32 d_pitch, u32 height, u32 mask,
-				u32 shift_high, u32 shift_low, u32 mod,
-				u32 idx);
-extern void move_buf_aligned(struct fb_info *info, u8 * dst, u8 * src,
-				u32 d_pitch, u32 s_pitch, u32 height);
+extern void fb_move_buf_unaligned(struct fb_info *info, struct fb_pixmap *buf,
+				u8 *dst, u32 d_pitch, u8 *src, u32 idx,
+				u32 height, u32 shift_high, u32 shift_low, u32 mod);
+extern void fb_move_buf_aligned(struct fb_info *info, struct fb_pixmap *buf,
+				u8 *dst, u32 d_pitch, u8 *src, u32 s_pitch,
+				u32 height);
 extern struct fb_info *registered_fb[FB_MAX];
 extern int num_registered_fb;
 

