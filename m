Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264580AbTCZDW7>; Tue, 25 Mar 2003 22:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264582AbTCZDW7>; Tue, 25 Mar 2003 22:22:59 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:4369 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S264580AbTCZDWX>; Tue, 25 Mar 2003 22:22:23 -0500
Date: Wed, 26 Mar 2003 03:33:31 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: =?ISO-8859-2?Q?Pawe=B3_Go=B3aszewski?= <blues@ds.pg.gda.pl>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.66
In-Reply-To: <Pine.LNX.4.51L.0303260335420.24751@piorun.ds.pg.gda.pl>
Message-ID: <Pine.LNX.4.44.0303260331580.10852-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> * And this changes aren't good for tdfx driver :(

Sorry I haven't got around to the driver. 

> The most important thing - I have a lot of oops in my logs. ~ 1 per 2 
> seconds

Try this patch and let me know how it works.

diff -urN -X /home/jsimmons/dontdiff linus-2.5/drivers/video/console/fbcon.c fbdev-2.5/drivers/video/console/fbcon.c
--- linus-2.5/drivers/video/console/fbcon.c	Sat Mar 22 21:45:23 2003
+++ fbdev-2.5/drivers/video/console/fbcon.c	Tue Mar 25 12:03:56 2003
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
+	schedule_work(&info->queue);
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
+static void accel_cursor(struct vc_data *vc, struct fb_info *info,
+			 struct fb_cursor *cursor, int yy)
 {
 	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
 	int bgshift = (vc->vc_hi_font_mask) ? 13 : 12;
@@ -986,7 +1024,15 @@
 	size = ((width + 7) >> 3) * height;

 	data = kmalloc(size, GFP_KERNEL);
+
+	if (!data) return;
+
 	mask = kmalloc(size, GFP_KERNEL);
+
+	if (!mask) {
+		kfree(data);
+		return;
+	}

 	if (cursor->set & FB_CUR_SETSIZE) {
 		memset(data, 0xff, size);
@@ -1101,27 +1147,6 @@
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
-
 static int scrollback_phys_max = 0;
 static int scrollback_max = 0;
 static int scrollback_current = 0;
diff -urN -X /home/jsimmons/dontdiff linus-2.5/drivers/video/softcursor.c fbdev-2.5/drivers/video/softcursor.c
--- linus-2.5/drivers/video/softcursor.c	Sat Mar 22 21:45:22 2003
+++ fbdev-2.5/drivers/video/softcursor.c	Tue Mar 25 11:41:28 2003
@@ -44,6 +44,7 @@
 		if (info->cursor.mask)
 			kfree(info->cursor.mask);
 		info->cursor.mask = kmalloc(dsize, GFP_KERNEL);
+		if (!info->cursor.mask) return -ENOMEM;
 		if (cursor->mask)
 			memcpy(info->cursor.mask, cursor->mask, dsize);
 		else
diff -urN -X /home/jsimmons/dontdiff linus-2.5/include/linux/fb.h fbdev-2.5/include/linux/fb.h
--- linus-2.5/include/linux/fb.h	Sat Mar 22 21:45:25 2003
+++ fbdev-2.5/include/linux/fb.h	Tue Mar 25 12:00:20 2003
@@ -2,6 +2,7 @@
 #define _LINUX_FB_H

 #include <linux/tty.h>
+#include <linux/workqueue.h>
 #include <asm/types.h>
 #include <asm/io.h>

@@ -406,8 +407,9 @@
    struct fb_fix_screeninfo fix;        /* Current fix */
    struct fb_monspecs monspecs;         /* Current Monitor specs */
    struct fb_cursor cursor;		/* Current cursor */
-   struct fb_cmap cmap;                 /* Current cmap */
+   struct work_struct queue;		/* Framebuffer event queue */
    struct fb_pixmap pixmap;	        /* Current pixmap */
+   struct fb_cmap cmap;                 /* Current cmap */
    struct fb_ops *fbops;
    char *screen_base;                   /* Virtual address */
    struct vc_data *display_fg;		/* Console visible on this display */


