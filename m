Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265907AbUBPW1W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 17:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265902AbUBPW1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 17:27:22 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:30477 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265907AbUBPW0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 17:26:31 -0500
Date: Mon, 16 Feb 2004 22:26:28 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: fbdev cursor part 1.
Message-ID: <Pine.LNX.4.44.0402162221001.21833-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

   I broke up the cursor patch. This patch creates a seperate cursor 
image drawing region and regular drawing region. It does not break any 
drivers to my knowledge. I posted it anyways for people to test it. The 
patch is against 2.6.3-rc3. Please try.

diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/console/fbcon.c fbdev-2.6/drivers/video/console/fbcon.c
--- linus-2.6/drivers/video/console/fbcon.c	2004-02-15 22:11:27.000000000 -0800
+++ fbdev-2.6/drivers/video/console/fbcon.c	2004-02-15 21:19:57.000000000 -0800
@@ -324,7 +324,7 @@
 	unsigned int buf_align = info->pixmap.buf_align - 1;
 	unsigned int scan_align = info->pixmap.scan_align - 1;
 	unsigned int idx = vc->vc_font.width >> 3;
-	u8 mask, *src, *dst, *dst0;
+	u8 *src, *dst, *dst0;
 
 	while (count) {
 		if (count > maxcnt)
@@ -337,15 +337,15 @@
 		pitch &= ~scan_align;
 		size = pitch * vc->vc_font.height + buf_align;
 		size &= ~buf_align;
-		dst0 = info->pixmap.addr + fb_get_buffer_offset(info, size);
+		dst0 = fb_get_buffer_offset(info, &info->pixmap, size);
 		image->data = dst0;
 		while (k--) {
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
@@ -381,12 +381,13 @@
 		size = pitch * vc->vc_font.height + buf_align;
 		size &= ~buf_align;
 		image->width = vc->vc_font.width * cnt;
-		dst0 = info->pixmap.addr + fb_get_buffer_offset(info, size);
+		dst0 = fb_get_buffer_offset(info, &info->pixmap, size);
 		image->data = dst0;
 		while (k--) {
 			src = vc->vc_font.data + (scr_readw(s++)&charmask)*cellsize;
 			dst = dst0;
-			move_buf_aligned(info, dst, src, pitch, width, image->height);
+			fb_move_buf_aligned(info, &info->pixmap, dst, pitch, src, 
+						width, image->height);
 			dst0 += width;
 		}
 		info->fbops->fb_imageblit(info, image);
@@ -455,11 +456,11 @@
 	size = pitch * vc->vc_font.height;
 	size += buf_align;
 	size &= ~buf_align;
-	dst = info->pixmap.addr + fb_get_buffer_offset(info, size);
+	dst = fb_get_buffer_offset(info, &info->pixmap, size);
 	image.data = dst;
 	src = vc->vc_font.data + (c & charmask) * vc->vc_font.height * width;
 
-	move_buf_aligned(info, dst, src, pitch, width, image.height);
+	fb_move_buf_aligned(info, &info->pixmap, dst, pitch, src, width, image.height);
 
 	info->fbops->fb_imageblit(info, &image);
 }
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/fbmem.c fbdev-2.6/drivers/video/fbmem.c
--- linus-2.6/drivers/video/fbmem.c	2004-02-15 22:11:23.000000000 -0800
+++ fbdev-2.6/drivers/video/fbmem.c	2004-02-15 21:33:52.000000000 -0800
@@ -395,7 +393,7 @@
 };
 
 #define NUM_FB_DRIVERS	(sizeof(fb_drivers)/sizeof(*fb_drivers))
-#define FBPIXMAPSIZE	8192
+#define FBPIXMAPSIZE	16384
 
 extern const char *global_mode_option;
 
@@ -412,52 +410,54 @@
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
@@ -468,10 +468,10 @@
  * we need to lock this section since fb_cursor
  * may use fb_imageblit()
  */
-u32 fb_get_buffer_offset(struct fb_info *info, u32 size)
+char* fb_get_buffer_offset(struct fb_info *info, struct fb_pixmap *buf, u32 size)
 {
-	struct fb_pixmap *buf = &info->pixmap;
 	u32 align = buf->buf_align - 1, offset;
+	char *addr = buf->addr;
 
 	/* If IO mapped, we need to sync before access, no sharing of
 	 * the pixmap is done
@@ -479,7 +479,7 @@
 	if (buf->flags & FB_PIXMAP_IO) {
 		if (info->fbops->fb_sync && (buf->flags & FB_PIXMAP_SYNC))
 			info->fbops->fb_sync(info);
-		return 0;
+		return addr;
 	}
 
 	/* See if we fit in the remaining pixmap space */
@@ -495,8 +495,9 @@
 		offset = 0;
 	}
 	buf->offset = offset + size;
+	addr += offset;
 
-	return offset;
+	return addr;
 }
 
 #ifdef CONFIG_LOGO
@@ -869,6 +870,15 @@
 }
 #endif /* CONFIG_KMOD */
 
+void
+fb_load_cursor_image(struct fb_info *info)
+{
+	unsigned int width = (info->cursor.image.width + 7) >> 3;
+	u8 *data = (u8 *) info->cursor.image.data;
+
+	info->sprite.outbuf(info, info->sprite.addr, data, width);
+}
+
 int
 fb_cursor(struct fb_info *info, struct fb_cursor *sprite)
 {
@@ -1276,6 +1286,21 @@
 	if (fb_info->pixmap.inbuf == NULL)
 		fb_info->pixmap.inbuf = sys_inbuf;
 
+	if (fb_info->sprite.addr == NULL) {
+		fb_info->sprite.addr = kmalloc(FBPIXMAPSIZE, GFP_KERNEL);
+		if (fb_info->sprite.addr) {
+			fb_info->sprite.size = FBPIXMAPSIZE;
+			fb_info->sprite.buf_align = 1;
+			fb_info->sprite.scan_align = 1;
+			fb_info->sprite.flags = FB_PIXMAP_DEFAULT;
+		}
+	}
+	fb_info->sprite.offset = 0;
+	if (fb_info->sprite.outbuf == NULL)
+		fb_info->sprite.outbuf = sys_outbuf;
+	if (fb_info->sprite.inbuf == NULL)
+		fb_info->sprite.inbuf = sys_inbuf;
+
 	registered_fb[i] = fb_info;
 
 	devfs_mk_cdev(MKDEV(FB_MAJOR, i),
@@ -1304,8 +1329,10 @@
 		return -EINVAL;
 	devfs_remove("fb/%d", i);
 
-	if (fb_info->pixmap.addr)
+	if (fb_info->pixmap.addr && (fb_info->pixmap.flags & FB_PIXMAP_DEFAULT))
 		kfree(fb_info->pixmap.addr);
+	if (fb_info->sprite.addr && (fb_info->pixmap.flags & FB_PIXMAP_DEFAULT))
+		kfree(fb_info->sprite.addr);
 	registered_fb[i]=NULL;
 	num_registered_fb--;
 	return 0;
@@ -1460,8 +1487,9 @@
 EXPORT_SYMBOL(fb_blank);
 EXPORT_SYMBOL(fb_pan_display);
 EXPORT_SYMBOL(fb_get_buffer_offset);
-EXPORT_SYMBOL(move_buf_unaligned);
-EXPORT_SYMBOL(move_buf_aligned);
+EXPORT_SYMBOL(fb_move_buf_unaligned);
+EXPORT_SYMBOL(fb_move_buf_aligned);
+EXPORT_SYMBOL(fb_load_cursor_image);
 EXPORT_SYMBOL(fb_set_suspend);
 EXPORT_SYMBOL(fb_register_client);
 EXPORT_SYMBOL(fb_unregister_client);
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/softcursor.c fbdev-2.6/drivers/video/softcursor.c
--- linus-2.6/drivers/video/softcursor.c	2004-02-15 22:11:24.000000000 -0800
+++ fbdev-2.6/drivers/video/softcursor.c	2004-02-15 21:22:17.000000000 -0800
@@ -19,8 +19,8 @@
 
 int soft_cursor(struct fb_info *info, struct fb_cursor *cursor)
 {
-	unsigned int scan_align = info->pixmap.scan_align - 1;
-	unsigned int buf_align = info->pixmap.buf_align - 1;
+	unsigned int scan_align = info->sprite.scan_align - 1;
+	unsigned int buf_align = info->sprite.buf_align - 1;
 	unsigned int i, size, dsize, s_pitch, d_pitch;
 	u8 *dst, src[64];
 
@@ -56,7 +56,7 @@
 	d_pitch = (s_pitch + scan_align) & ~scan_align;
 	size = d_pitch * info->cursor.image.height + buf_align;
 	size &= ~buf_align;
-	dst = info->pixmap.addr + fb_get_buffer_offset(info, size);
+	dst = fb_get_buffer_offset(info, &info->sprite, size);
 
 	if (info->cursor.enable) {
 		switch (info->cursor.rop) {
@@ -73,7 +73,7 @@
 	} else 
 		memcpy(src, cursor->image.data, dsize);
 	
-	move_buf_aligned(info, dst, src, d_pitch, s_pitch, info->cursor.image.height);
+	fb_move_buf_aligned(info, &info->sprite, dst, d_pitch, src, s_pitch, info->cursor.image.height);
 	info->cursor.image.data = dst;
 	
 	info->fbops->fb_imageblit(info, &info->cursor.image);
diff -urN -X /home/jsimmons/dontdiff linus-2.6/include/linux/fb.h fbdev-2.6/include/linux/fb.h
--- linus-2.6/include/linux/fb.h	2004-02-15 22:13:17.000000000 -0800
+++ fbdev-2.6/include/linux/fb.h	2004-02-15 18:54:24.000000000 -0800
@@ -371,16 +371,16 @@
 #define FB_PIXMAP_SYNC    256   /* set if GPU can DMA       */
 
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
+	u8  *addr;		/* pointer to memory			*/
+	u32 size;		/* size of buffer in bytes		*/
+	u32 offset;		/* current offset to buffer		*/
+	u32 buf_align;		/* byte alignment of each bitmap	*/
+	u32 scan_align;		/* alignment per scanline		*/
+	u32 access_align;	/* alignment per read/write		*/
+	u32 flags;		/* see FB_PIXMAP_*			*/
+				/* access methods			*/
+	void (*outbuf)(struct fb_info *info, u8 *addr, u8 *src, unsigned int size);
+	u8   (*inbuf) (struct fb_info *info, u8 *addr);
 };
 
     /*
@@ -388,64 +388,53 @@
      */
 
 struct fb_ops {
-    /* open/release and usage marking */
-    struct module *owner;
-    int (*fb_open)(struct fb_info *info, int user);
-    int (*fb_release)(struct fb_info *info, int user);
-
-    /* For framebuffers with strange non linear layouts */	
-	ssize_t(*fb_read) (struct file * file, char *buf, size_t count,
-			   loff_t * ppos);
-	ssize_t(*fb_write) (struct file * file, const char *buf,
-			    size_t count, loff_t * ppos);
+	/* open/release and usage marking */
+	struct module *owner;
+	int (*fb_open)(struct fb_info *info, int user);
+	int (*fb_release)(struct fb_info *info, int user);
+
+	/* For framebuffers with strange non linear layouts */	
+	ssize_t (*fb_read)(struct file *file, char *buf, size_t count, loff_t *ppos);
+	ssize_t (*fb_write)(struct file *file, const char *buf, size_t count, loff_t *ppos);
 
 	/* checks var and eventually tweaks it to something supported,
 	 * DO NOT MODIFY PAR */
-	int (*fb_check_var) (struct fb_var_screeninfo * var,
-			     struct fb_info * info);
+	int (*fb_check_var)(struct fb_var_screeninfo *var, struct fb_info *info);
 	/* set the video mode according to info->var */
-    int (*fb_set_par)(struct fb_info *info);
+	int (*fb_set_par)(struct fb_info *info);
 
-    /* set color register */
-    int (*fb_setcolreg)(unsigned regno, unsigned red, unsigned green,
-			     unsigned blue, unsigned transp,
-			     struct fb_info * info);
-
-    /* blank display */
-    int (*fb_blank)(int blank, struct fb_info *info);
-
-    /* pan display */
-	int (*fb_pan_display) (struct fb_var_screeninfo * var,
-			       struct fb_info * info);
-
-    /* draws a rectangle */
-	void (*fb_fillrect) (struct fb_info * info,
-			     const struct fb_fillrect * rect);
-    /* Copy data from area to another */
-	void (*fb_copyarea) (struct fb_info * info,
-			     const struct fb_copyarea * region);
-    /* Draws a image to the display */
-	void (*fb_imageblit) (struct fb_info * info,
-			      const struct fb_image * image);
-
-    /* Draws cursor */
-	int (*fb_cursor) (struct fb_info * info,
-			  struct fb_cursor * cursor);
-
-    /* Rotates the display */
-    void (*fb_rotate)(struct fb_info *info, int angle);
-
-    /* wait for blit idle, optional */
-    int (*fb_sync)(struct fb_info *info);		
-
-    /* perform fb specific ioctl (optional) */
-	int (*fb_ioctl) (struct inode * inode, struct file * file,
-			 unsigned int cmd, unsigned long arg,
-			 struct fb_info * info);
-
-    /* perform fb specific mmap */
-	int (*fb_mmap) (struct fb_info * info, struct file * file,
-			struct vm_area_struct * vma);
+	/* set color register */
+	int (*fb_setcolreg)(unsigned regno, unsigned red, unsigned green,
+			    unsigned blue, unsigned transp, struct fb_info *info);
+
+	/* blank display */
+	int (*fb_blank)(int blank, struct fb_info *info);
+
+	/* pan display */
+	int (*fb_pan_display)(struct fb_var_screeninfo *var, struct fb_info *info);
+
+	/* Draws a rectangle */
+	void (*fb_fillrect) (struct fb_info *info, const struct fb_fillrect *rect);
+	/* Copy data from area to another */
+	void (*fb_copyarea) (struct fb_info *info, const struct fb_copyarea *region);
+	/* Draws a image to the display */
+	void (*fb_imageblit) (struct fb_info *info, const struct fb_image *image);
+
+	/* Draws cursor */
+	int (*fb_cursor) (struct fb_info *info, struct fb_cursor *cursor);
+
+	/* Rotates the display */
+	void (*fb_rotate)(struct fb_info *info, int angle);
+
+	/* wait for blit idle, optional */
+	int (*fb_sync)(struct fb_info *info);		
+
+	/* perform fb specific ioctl (optional) */
+	int (*fb_ioctl)(struct inode *inode, struct file *file, unsigned int cmd,
+			unsigned long arg, struct fb_info *info);
+
+	/* perform fb specific mmap */
+	int (*fb_mmap)(struct fb_info *info, struct file *file, struct vm_area_struct *vma);
 };
 
 struct fb_info {
@@ -459,6 +448,7 @@
 	struct fb_cursor cursor;	/* Current cursor */	
 	struct work_struct queue;	/* Framebuffer event queue */
 	struct fb_pixmap pixmap;	/* Image Hardware Mapper */
+	struct fb_pixmap sprite;	/* Cursor hardware Mapper */
 	struct fb_cmap cmap;		/* Current cmap */
 	struct fb_ops *fbops;
 	char *screen_base;		/* Virtual address */
@@ -537,14 +527,16 @@
 extern int unregister_framebuffer(struct fb_info *fb_info);
 extern int fb_prepare_logo(struct fb_info *fb_info);
 extern int fb_show_logo(struct fb_info *fb_info);
-extern u32 fb_get_buffer_offset(struct fb_info *info, u32 size);
-extern void move_buf_unaligned(struct fb_info *info, u8 * dst, u8 * src,
-				u32 d_pitch, u32 height, u32 mask,
-				u32 shift_high, u32 shift_low, u32 mod,
-				u32 idx);
-extern void move_buf_aligned(struct fb_info *info, u8 * dst, u8 * src,
-				u32 d_pitch, u32 s_pitch, u32 height);
+extern char* fb_get_buffer_offset(struct fb_info *info, struct fb_pixmap *buf, u32 size);
+extern void fb_move_buf_unaligned(struct fb_info *info, struct fb_pixmap *buf,
+				u8 *dst, u32 d_pitch, u8 *src, u32 idx,
+				u32 height, u32 shift_high, u32 shift_low, u32 mod);
+extern void fb_move_buf_aligned(struct fb_info *info, struct fb_pixmap *buf,
+				u8 *dst, u32 d_pitch, u8 *src, u32 s_pitch,
+				u32 height);
+extern void fb_load_cursor_image(struct fb_info *);
 extern void fb_set_suspend(struct fb_info *info, int state);
+
 extern struct fb_info *registered_fb[FB_MAX];
 extern int num_registered_fb;
 

