Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264275AbUBOHLt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 02:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264288AbUBOHLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 02:11:49 -0500
Received: from gate.crashing.org ([63.228.1.57]:33181 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264275AbUBOHLm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 02:11:42 -0500
Subject: [PATCH] Fix fbdev pixmap locking
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       James Simmons <jsimmons@infradead.org>
Content-Type: text/plain
Message-Id: <1076829040.6957.14.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 15 Feb 2004 18:10:40 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch removes the broken locking code in the pixmaps, and
rewrite the buffer access function to properly call fb_sync when
needed. The old broken loocking is useless as we are covered
by the console semaphore in all cases hopefully
(except if I missed one :)

Ben.

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/02/15 16:31:31+11:00 benh@kernel.crashing.org 
#   Remove broken (and now useless) pixmap locking, fix fb_get_buffer_offset()
# 
# include/linux/fb.h
#   2004/02/15 16:31:19+11:00 benh@kernel.crashing.org +0 -2
#   Remove broken (and now useless) pixmap locking, fix fb_get_buffer_offset()
# 
# drivers/video/softcursor.c
#   2004/02/15 16:31:19+11:00 benh@kernel.crashing.org +0 -2
#   Remove broken (and now useless) pixmap locking, fix fb_get_buffer_offset()
# 
# drivers/video/fbmem.c
#   2004/02/15 16:31:19+11:00 benh@kernel.crashing.org +21 -15
#   Remove broken (and now useless) pixmap locking, fix fb_get_buffer_offset()
# 
# drivers/video/console/fbcon.c
#   2004/02/15 16:31:19+11:00 benh@kernel.crashing.org +0 -6
#   Remove broken (and now useless) pixmap locking, fix fb_get_buffer_offset()
# 
diff -Nru a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
--- a/drivers/video/console/fbcon.c	Sun Feb 15 17:04:56 2004
+++ b/drivers/video/console/fbcon.c	Sun Feb 15 17:04:56 2004
@@ -354,8 +354,6 @@
 		info->fbops->fb_imageblit(info, image);
 		image->dx += cnt * vc->vc_font.width;
 		count -= cnt;
-		atomic_dec(&info->pixmap.count);
-		smp_mb__after_atomic_dec();
 	}
 }
 
@@ -394,8 +392,6 @@
 		info->fbops->fb_imageblit(info, image);
 		image->dx += cnt * vc->vc_font.width;
 		count -= cnt;
-		atomic_dec(&info->pixmap.count);
-		smp_mb__after_atomic_dec();
 	}
 }
 
@@ -466,8 +462,6 @@
 	move_buf_aligned(info, dst, src, pitch, width, image.height);
 
 	info->fbops->fb_imageblit(info, &image);
-	atomic_dec(&info->pixmap.count);
-	smp_mb__after_atomic_dec();
 }
 
 void accel_putcs(struct vc_data *vc, struct fb_info *info,
diff -Nru a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c	Sun Feb 15 17:04:56 2004
+++ b/drivers/video/fbmem.c	Sun Feb 15 17:04:56 2004
@@ -464,23 +464,32 @@
  */
 u32 fb_get_buffer_offset(struct fb_info *info, u32 size)
 {
-	u32 align = info->pixmap.buf_align - 1;
-	u32 offset, count = 1000;
+	struct fb_pixmap *buf = &info->pixmap;
+	u32 align = buf->buf_align - 1, offset;
 
-	spin_lock(&info->pixmap.lock);
-	offset = info->pixmap.offset + align;
+	/* If IO mapped, we need to sync before access, no sharing of
+	 * the pixmap is done
+	 */
+	if (buf->flags & FB_PIXMAP_IO) {
+		if (info->fbops->fb_sync && (buf->flags & FB_PIXMAP_SYNC))
+			info->fbops->fb_sync(info);
+		return 0;
+	}
+
+	/* See if we fit in the remaining pixmap space */
+	offset = buf->offset + align;
 	offset &= ~align;
-	if (offset + size > info->pixmap.size) {
-		while (atomic_read(&info->pixmap.count) && count--);
-		if (info->fbops->fb_sync && 
-		    info->pixmap.flags & FB_PIXMAP_SYNC)
+	if (offset + size > buf->size) {
+		/* We do not fit. In order to be able to re-use the buffer,
+		 * we must ensure no asynchronous DMA'ing or whatever operation
+		 * is in progress, we sync for that.
+		 */
+		if (info->fbops->fb_sync && (buf->flags & FB_PIXMAP_SYNC))
 			info->fbops->fb_sync(info);
 		offset = 0;
 	}
-	info->pixmap.offset = offset + size;
-	atomic_inc(&info->pixmap.count);	
-	smp_mb__after_atomic_inc();
-	spin_unlock(&info->pixmap.lock);
+	buf->offset = offset + size;
+
 	return offset;
 }
 
@@ -733,8 +742,6 @@
 	     x <= info->var.xres-fb_logo.logo->width; x += (fb_logo.logo->width + 8)) {
 		image.dx = x;
 		info->fbops->fb_imageblit(info, &image);
-		//atomic_dec(&info->pixmap.count);
-		//smp_mb__after_atomic_dec();
 	}
 	
 	if (palette != NULL)
@@ -1254,7 +1261,6 @@
 		fb_info->pixmap.outbuf = sys_outbuf;
 	if (fb_info->pixmap.inbuf == NULL)
 		fb_info->pixmap.inbuf = sys_inbuf;
-	spin_lock_init(&fb_info->pixmap.lock);
 
 	registered_fb[i] = fb_info;
 
diff -Nru a/drivers/video/softcursor.c b/drivers/video/softcursor.c
--- a/drivers/video/softcursor.c	Sun Feb 15 17:04:56 2004
+++ b/drivers/video/softcursor.c	Sun Feb 15 17:04:56 2004
@@ -74,8 +74,6 @@
 	info->cursor.image.data = dst;
 	
 	info->fbops->fb_imageblit(info, &info->cursor.image);
-	atomic_dec(&info->pixmap.count);
-	smp_mb__after_atomic_dec();
 	return 0;
 }
 
diff -Nru a/include/linux/fb.h b/include/linux/fb.h
--- a/include/linux/fb.h	Sun Feb 15 17:04:56 2004
+++ b/include/linux/fb.h	Sun Feb 15 17:04:56 2004
@@ -363,8 +363,6 @@
 					  /* access methods                */
 	void (*outbuf)(u8 *dst, u8 *addr, unsigned int size); 
 	u8   (*inbuf) (u8 *addr);
-	spinlock_t lock;                  /* spinlock                      */
-	atomic_t count;
 };
 
     /*



