Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264576AbTCZDi5>; Tue, 25 Mar 2003 22:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264579AbTCZDi5>; Tue, 25 Mar 2003 22:38:57 -0500
Received: from pine.compass.com.ph ([202.70.96.37]:13587 "HELO
	pine.compass.com.ph") by vger.kernel.org with SMTP
	id <S264576AbTCZDih>; Tue, 25 Mar 2003 22:38:37 -0500
Subject: Re: [Linux-fbdev-devel] [BK FBDEV] A few more updates.
From: Antonino Daplas <adaplas@pol.net>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0303251031180.4272-100000@maxwell.earthlink.net>
References: <Pine.LNX.4.33.0303251031180.4272-100000@maxwell.earthlink.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1048649746.998.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 26 Mar 2003 11:37:21 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-26 at 02:32, James Simmons wrote:
> 
> Linus, please do a
> 
> 	bk pull http://fbdev.bkbits.net/fbdev-2.5
> 
> This will update the following files:
> 
>  drivers/video/aty/aty128fb.c  |   16 +++++++---------
>  drivers/video/console/fbcon.c |    4 ++--
>  drivers/video/controlfb.c     |   18 +++---------------
>  drivers/video/platinumfb.c    |   28 ++++++++--------------------
>  drivers/video/radeonfb.c      |   10 ++++++++++
>  drivers/video/softcursor.c    |    2 +-
>  6 files changed, 31 insertions(+), 47 deletions(-)
> 

James,

Attached is a patch that fixes the following:

1.  The following lines are missing from softcursor.c, but is present in
fb_show_logo() where it shoudn't be:

	atomic_dec(&info->pixmap.count);
	smp_mb__after_atomic_dec();

In both cases, the reference counting will be incorrect which can cause
irregular cursor flashing and unnecessary "syncing".  Only functions
that call fb_get_buffer_offset() need to decrement the reference count
afterwards.

2.  I applied your workqueue patch and changed locking from spinlocks to
semaphores in fb_get_buffer_offset().

3.  BTW, there are too many kmalloc's/kfree's in accel_cursor() and
softcursor().  Personally, I would rather have 2 64-byte buffers for the
mask and the data in the info->cursor structure than allocating/freeing
memory each time the cursor flashes.  However, if you prefer doing it
this way, the patch also includes changes so kmallocs are only done when
necessary.  Still, accel_cursor() has unnecessary work being done, such
as always creating the mask bitmap, when a simple flag to monitor cursor
shape changes could prevent all this.

5.  softcursor should not concern itself with memory bookkeeping, and
must be able to function with just the parameter passed to it in order
to keep it as simple as possible.  These tasks are moved to
accel_cursor.

6.  The patch should also fix the "irregularly dashed" cursor.

Tony

PS:  What happened to the logo?  I just get a white square in the uppper left corner.


diff -Naur linux-2.5.66-orig/drivers/video/console/fbcon.c linux-2.5.66/drivers/video/console/fbcon.c
--- linux-2.5.66-orig/drivers/video/console/fbcon.c	2003-03-26 02:25:01.000000000 +0000
+++ linux-2.5.66/drivers/video/console/fbcon.c	2003-03-26 02:47:58.000000000 +0000
@@ -172,8 +172,9 @@
  *  Internal routines
  */
 static void fbcon_set_display(struct vc_data *vc, int init, int logo);
+static void accel_cursor(struct vc_data *vc, struct fb_info *info,
+			 struct fb_cursor *cursor, int yy);
 static __inline__ int real_y(struct display *p, int ypos);
-static void fb_vbl_handler(int irq, void *dummy, struct pt_regs *fp);
 static __inline__ void updatescrollmode(struct display *p, struct vc_data *vc);
 static __inline__ void ywrap_up(struct vc_data *vc, int count);
 static __inline__ void ywrap_down(struct vc_data *vc, int count);
@@ -194,6 +195,34 @@
 }
 #endif
 
+static void fb_callback(void *private)
+{
+	struct fb_info *info = (struct fb_info *) private;
+	struct display *p = &fb_display[fg_console];
+	struct vc_data *vc = vc_cons[fg_console].d;
+	struct fb_cursor cursor;
+
+	if (!info || !cursor_on)
+		return;
+
+	if (vbl_cursor_cnt && --vbl_cursor_cnt == 0) {
+		cursor.set = 0;
+
+		if (!cursor_drawn)
+			cursor.set = FB_CUR_SETCUR;
+		accel_cursor(vc, info, &cursor, real_y(p, vc->vc_y));
+		cursor_drawn ^= 1;
+		vbl_cursor_cnt = cursor_blink_rate;
+	}
+}
+
+static void fb_vbl_handler(int irq, void *dev_id, struct pt_regs *fp)
+{
+	struct fb_info *info = dev_id;
+
+	schedule_work(&info->queue);
+}
+
 static void cursor_timer_handler(unsigned long dev_addr);
 
 static struct timer_list cursor_timer =
@@ -203,7 +232,7 @@
 {
 	struct fb_info *info = (struct fb_info *) dev_addr;
 	
-	fb_vbl_handler(0, info, NULL);
+ 	schedule_work(&info->queue);
 	cursor_timer.expires = jiffies + HZ / 50;
 	add_timer(&cursor_timer);
 }
@@ -290,14 +319,14 @@
 			    const unsigned short *s)
 {
 	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
-	unsigned int width = (vc->vc_font.width + 7)/8;
+	unsigned int width = (vc->vc_font.width + 7) >> 3;
 	unsigned int cellsize = vc->vc_font.height * width;
 	unsigned int maxcnt = info->pixmap.size/cellsize;
 	unsigned int shift_low = 0, mod = vc->vc_font.width % 8;
 	unsigned int shift_high = 8, size, pitch, cnt, k;
 	unsigned int buf_align = info->pixmap.buf_align - 1;
 	unsigned int scan_align = info->pixmap.scan_align - 1;
-	unsigned int idx = vc->vc_font.width/8;
+	unsigned int idx = vc->vc_font.width >> 3;
 	u8 mask, *src, *dst, *dst0;
 
 	while (count) {
@@ -307,7 +336,7 @@
 			cnt = k = count;
 
 		image->width = vc->vc_font.width * cnt;
-		pitch = (image->width + 7)/8 + scan_align;
+		pitch = ((image->width + 7) >> 3) + scan_align;
 		pitch &= ~scan_align;
 		size = pitch * vc->vc_font.height + buf_align;
 		size &= ~buf_align;
@@ -338,7 +367,7 @@
 			  const unsigned short *s)
 {
 	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
-	unsigned int width = vc->vc_font.width/8;
+	unsigned int width = vc->vc_font.width >> 3;
 	unsigned int cellsize = vc->vc_font.height * width;
 	unsigned int maxcnt = info->pixmap.size/cellsize;
 	unsigned int scan_align = info->pixmap.scan_align - 1;
@@ -411,7 +440,7 @@
                       int c, int ypos, int xpos)
 {
 	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
-	unsigned int width = (vc->vc_font.width + 7)/8;
+	unsigned int width = (vc->vc_font.width + 7) >> 3;
 	unsigned int scan_align = info->pixmap.scan_align - 1;
 	unsigned int buf_align = info->pixmap.buf_align - 1;
 	int bgshift = (vc->vc_hi_font_mask) ? 13 : 12;
@@ -559,6 +588,15 @@
 
 	vc = (struct vc_data *) kmalloc(sizeof(struct vc_data), GFP_ATOMIC); 
 
+	if (!vc) {
+		if (softback_buf)
+			kfree((void *) softback_buf);
+		return NULL;
+	}
+
+	/* Initialize the work queue */
+	INIT_WORK(&info->queue, fb_callback, info);
+
 	/* Setup default font */
 	vc->vc_font.data = font->data;
 	vc->vc_font.width = font->width;
@@ -956,8 +994,8 @@
 	accel_putcs(vc, info, s, count, real_y(p, ypos), xpos);
 }
 
-void accel_cursor(struct vc_data *vc, struct fb_info *info, struct fb_cursor *cursor,
-		  int yy)
+void accel_cursor(struct vc_data *vc, struct fb_info *info, 
+		  struct fb_cursor *cursor, int yy)
 {
 	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
 	int bgshift = (vc->vc_hi_font_mask) ? 13 : 12;
@@ -971,25 +1009,39 @@
 	else
 		cursor->enable = 0;
 
-	cursor->set |= FB_CUR_SETPOS;
 
 	height = info->cursor.image.height;
 	width = info->cursor.image.width;
 
 	if (width != vc->vc_font.width || 
 	    height != vc->vc_font.height) {
-		width = vc->vc_font.width;
-		height = vc->vc_font.height;
+		info->cursor.image.width = vc->vc_font.width;
+		info->cursor.image.height = vc->vc_font.height;
+		height = info->cursor.image.height;
+		width = info->cursor.image.width;
 		cursor->set |= FB_CUR_SETSIZE;
 	}	
 
+	if (info->cursor.image.dx != vc->vc_x * width ||
+	    info->cursor.image.dy != yy * height) {
+		info->cursor.image.dx = vc->vc_x * width;
+		info->cursor.image.dy = yy * height;
+		cursor->set |= FB_CUR_SETPOS;
+	}
+
 	size = ((width + 7) >> 3) * height;
 
-	data = kmalloc(size, GFP_KERNEL);
 	mask = kmalloc(size, GFP_KERNEL);
-	
+	if (mask == NULL)
+		return;
 	if (cursor->set & FB_CUR_SETSIZE) {
+		if (info->cursor.image.data)
+			kfree(info->cursor.image.data);
+		data = kmalloc(size, GFP_KERNEL);
+		if (data == NULL)
+			return;
 		memset(data, 0xff, size);
+		info->cursor.image.data = data;
 		cursor->set |= FB_CUR_SETSHAPE;
 	}
 
@@ -997,13 +1049,14 @@
 
 	if (info->cursor.image.fg_color != attr_fgcol(fgshift, c) ||
 	    info->cursor.image.bg_color != attr_bgcol(bgshift, c)) {
-		cursor->image.fg_color = attr_fgcol(fgshift, c);
-		cursor->image.bg_color = attr_bgcol(bgshift, c);
+		info->cursor.image.fg_color = attr_fgcol(fgshift, c);
+		info->cursor.image.bg_color = attr_bgcol(bgshift, c);
+		info->cursor.image.depth = 0;
 		cursor->set |= FB_CUR_SETCMAP;
 	}
 	font = vc->vc_font.data + ((c & charmask) * size);
 	if (font != info->cursor.dest) {
-		cursor->dest = font;
+		info->cursor.dest = font;
 		cursor->set |= FB_CUR_SETDEST;
 	}
 
@@ -1038,21 +1091,18 @@
 	while (size--)
 		mask[i++] = 0xff;
 
-	if (!info->cursor.mask ||  (memcmp(mask, info->cursor.mask, w*height)))
+	if (!(cursor->set & FB_CUR_SETSHAPE) && 
+	    (memcmp(mask, info->cursor.mask, size)))
 		cursor->set |= FB_CUR_SETSHAPE;
-
-	cursor->image.width = width;
-	cursor->image.height = height;
-	cursor->image.dx = vc->vc_x * width;
-	cursor->image.dy = yy * height;
-	cursor->image.depth = 0;
-	cursor->image.data = data;
-	cursor->mask = mask;
+	if (info->cursor.mask)
+		kfree(info->cursor.mask);
+	info->cursor.mask = mask;
+	
+	cursor->image = info->cursor.image;
+	cursor->dest = info->cursor.dest;
+	cursor->mask = info->cursor.mask;
 	cursor->rop = ROP_XOR;
-
 	info->fbops->fb_cursor(info, cursor);
-	kfree(data);
-	kfree(mask);
 }
 	
 static void fbcon_cursor(struct vc_data *vc, int mode)
@@ -1101,26 +1151,6 @@
 	}
 }
 
-static void fb_vbl_handler(int irq, void *dev_id, struct pt_regs *fp)
-{
-	struct fb_info *info = dev_id;
-	struct display *p = &fb_display[fg_console];
-	struct vc_data *vc = vc_cons[fg_console].d;
-	struct fb_cursor cursor;
-	
-	if (!cursor_on)
-		return;
-
-	if (vbl_cursor_cnt && --vbl_cursor_cnt == 0) {
-		cursor.set = 0;
-
-		if (!cursor_drawn)
-			cursor.set = FB_CUR_SETCUR;
-		accel_cursor(vc, info, &cursor, real_y(p, vc->vc_y));
-		cursor_drawn ^= 1;
-		vbl_cursor_cnt = cursor_blink_rate; 
-	}
-}	
 	
 static int scrollback_phys_max = 0;
 static int scrollback_max = 0;
diff -Naur linux-2.5.66-orig/drivers/video/fbmem.c linux-2.5.66/drivers/video/fbmem.c
--- linux-2.5.66-orig/drivers/video/fbmem.c	2003-03-26 02:25:01.000000000 +0000
+++ linux-2.5.66/drivers/video/fbmem.c	2003-03-26 02:47:44.000000000 +0000
@@ -454,14 +454,13 @@
 u32 fb_get_buffer_offset(struct fb_info *info, u32 size)
 {
 	u32 align = info->pixmap.buf_align - 1;
-	u32 offset, count = 1000;
+	u32 offset;
 
-	spin_lock_irqsave(&info->pixmap.lock,
-			  info->pixmap.lock_flags);
+	down(&info->pixmap.sem);
 	offset = info->pixmap.offset + align;
 	offset &= ~align;
 	if (offset + size > info->pixmap.size) {
-		while (atomic_read(&info->pixmap.count) && count--);
+		while (atomic_read(&info->pixmap.count));
 		if (info->fbops->fb_sync && 
 		    info->pixmap.flags & FB_PIXMAP_SYNC)
 			info->fbops->fb_sync(info);
@@ -472,8 +471,7 @@
 	atomic_inc(&info->pixmap.count);	
 	smp_mb__after_atomic_inc();
 
-	spin_unlock_irqrestore(&info->pixmap.lock,
-			       info->pixmap.lock_flags);
+	up(&info->pixmap.sem);
 	return offset;
 }
 
@@ -754,8 +752,6 @@
 	     x <= info->var.xres-fb_logo.logo->width; x += (fb_logo.logo->width + 8)) {
 		image.dx = x;
 		info->fbops->fb_imageblit(info, &image);
-		atomic_dec(&info->pixmap.count);
-		smp_mb__after_atomic_dec();
 	}
 	
 	if (palette != NULL)
@@ -1195,6 +1191,7 @@
 register_framebuffer(struct fb_info *fb_info)
 {
 	char name_buf[12];
+	struct semaphore *sem = &fb_info->pixmap.sem;
 	int i;
 
 	if (num_registered_fb == FB_MAX)
@@ -1219,8 +1216,8 @@
 		fb_info->pixmap.outbuf = sys_outbuf;
 	if (fb_info->pixmap.inbuf == NULL)
 		fb_info->pixmap.inbuf = sys_inbuf;
-	spin_lock_init(&fb_info->pixmap.lock);
-	
+
+	*sem = (struct semaphore) __SEMAPHORE_INITIALIZER((*sem), 1);
 	registered_fb[i] = fb_info;
 	sprintf(name_buf, "fb/%d", i);
 	devfs_register(NULL, name_buf, DEVFS_FL_DEFAULT,
diff -Naur linux-2.5.66-orig/drivers/video/softcursor.c linux-2.5.66/drivers/video/softcursor.c
--- linux-2.5.66-orig/drivers/video/softcursor.c	2003-03-26 02:25:02.000000000 +0000
+++ linux-2.5.66/drivers/video/softcursor.c	2003-03-26 02:47:48.000000000 +0000
@@ -19,57 +19,20 @@
 
 int soft_cursor(struct fb_info *info, struct fb_cursor *cursor)
 {
+	struct fb_image image;
 	unsigned int scan_align = info->pixmap.scan_align - 1;
 	unsigned int buf_align = info->pixmap.buf_align - 1;
 	unsigned int i, size, dsize, s_pitch, d_pitch;
 	u8 *dst, src[64];
 
-	info->cursor.enable = (cursor->set & FB_CUR_SETCUR) ? 1 : 0;
-
-	if (cursor->set & FB_CUR_SETSIZE) {
-		info->cursor.image.width = cursor->image.width;
-		info->cursor.image.height = cursor->image.height;
-		cursor->set |= FB_CUR_SETSHAPE;
-	}
-
-	s_pitch = (info->cursor.image.width + 7) >> 3;
-	dsize = s_pitch * info->cursor.image.height;
+	s_pitch = (cursor->image.width + 7) >> 3;
+	dsize = s_pitch * cursor->image.height;
 	d_pitch = (s_pitch + scan_align) & ~scan_align;
-	size = d_pitch * info->cursor.image.height + buf_align;
+	size = d_pitch * cursor->image.height + buf_align;
 	size &= ~buf_align;
 	dst = info->pixmap.addr + fb_get_buffer_offset(info, size);
-	info->cursor.image.data = dst;
-
-	if (cursor->set & FB_CUR_SETSHAPE) {
-		if (info->cursor.mask)
-			kfree(info->cursor.mask);
-		info->cursor.mask = kmalloc(dsize, GFP_KERNEL);
-		if (cursor->mask)
-			memcpy(info->cursor.mask, cursor->mask, dsize);
-		else
-			memset(info->cursor.mask, 0, dsize);
-	}
-
-	if (cursor->set & FB_CUR_SETPOS) {
-		info->cursor.image.dx = cursor->image.dx;
-		info->cursor.image.dy = cursor->image.dy;
-	}
-
-	if (cursor->set & FB_CUR_SETHOT)
-		info->cursor.hot = cursor->hot;
-
-	if (cursor->set & FB_CUR_SETCMAP) {
-		if (cursor->image.depth == 0) {
-			info->cursor.image.bg_color = cursor->image.bg_color;
-			info->cursor.image.fg_color = cursor->image.fg_color;
-		} else {
-			if (cursor->image.cmap.len)
-				fb_copy_cmap(&cursor->image.cmap, &info->cursor.image.cmap, 0);
-		}
-		info->cursor.image.depth = cursor->image.depth;
-	}
 
-	if (info->cursor.enable) {
+	if (cursor->enable) {
 		switch (cursor->rop) {
 		case ROP_XOR:
 			for (i = 0; i < dsize; i++) {
@@ -89,10 +52,15 @@
 		move_buf_aligned(info, dst, src, d_pitch, s_pitch,
 				 cursor->image.height);
 	} else {
-		move_buf_aligned(info, dst, cursor->dest, s_pitch, d_pitch,
+		move_buf_aligned(info, dst, cursor->dest, d_pitch, s_pitch,
 				 cursor->image.height);
 	}
-	info->fbops->fb_imageblit(info, &info->cursor.image);
+	image = cursor->image;
+	image.data = dst;
+	info->fbops->fb_imageblit(info, &image);
+	atomic_dec(&info->pixmap.count);
+	smp_mb__after_atomic_dec();
+	
 	return 0;
 }
 
diff -Naur linux-2.5.66-orig/include/linux/fb.h linux-2.5.66/include/linux/fb.h
--- linux-2.5.66-orig/include/linux/fb.h	2003-03-26 02:25:04.000000000 +0000
+++ linux-2.5.66/include/linux/fb.h	2003-03-26 02:48:10.000000000 +0000
@@ -2,6 +2,7 @@
 #define _LINUX_FB_H
 
 #include <linux/tty.h>
+#include <linux/workqueue.h>
 #include <asm/types.h>
 #include <asm/io.h>
 
@@ -341,8 +342,7 @@
 	__u32 flags;                      /* see FB_PIXMAP_*               */
 	void (*outbuf)(u8 dst, u8 *addr); /* access methods                */
 	u8   (*inbuf) (u8 *addr);
-	unsigned long lock_flags;         /* flags for locking             */
-	spinlock_t lock;                  /* spinlock                      */
+	struct semaphore sem;
 	atomic_t count;
 };
 #ifdef __KERNEL__
@@ -407,6 +407,7 @@
    struct fb_monspecs monspecs;         /* Current Monitor specs */
    struct fb_cursor cursor;		/* Current cursor */	
    struct fb_cmap cmap;                 /* Current cmap */
+   struct work_struct queue;           /* Framebuffer event queue */
    struct fb_pixmap pixmap;	        /* Current pixmap */
    struct fb_ops *fbops;
    char *screen_base;                   /* Virtual address */

