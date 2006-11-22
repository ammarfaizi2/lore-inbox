Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755032AbWKVJqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755032AbWKVJqm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 04:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755575AbWKVJqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 04:46:42 -0500
Received: from smtp19.msg.oleane.net ([62.161.4.19]:25239 "EHLO
	smtp19.msg.oleane.net") by vger.kernel.org with ESMTP
	id S1755032AbWKVJql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 04:46:41 -0500
Message-ID: <45641CB6.5060502@innova-card.com>
Date: Wed, 22 Nov 2006 10:47:34 +0100
From: Franck Bui-Huu <franck.bui-huu@innova-card.com>
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] softcursor.c: avoid unaligned accesses
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Franck Bui-Huu <fbuihuu@gmail.com>

This patch fixes some possible unaligned accesses when accessing
fields of 'image' pointer. Indeed this pointer was obtained by
allocating a block of memory that embeds a temporary array plus an
image structure. The temporary buffer was located at the start of the
allocated block and depending on its size, the image structure which
comes right after can be unaligned.

For example when using mini fonts (4x6) (cursor's width is 4 and its
height is 6) the temporary buf size is 6 bytes.

Therefore this patch moves the image structure to the start of the
block and moves the temporary buffer right after. It makes 'image'
pointer always aligned and since the tempo buf is a buffer of char,
it's always correctly aligned as well.

It also fixes the file header alignement.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 drivers/video/console/softcursor.c |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/video/console/softcursor.c b/drivers/video/console/softcursor.c
index 7d07d83..f577bd8 100644
--- a/drivers/video/console/softcursor.c
+++ b/drivers/video/console/softcursor.c
@@ -1,11 +1,13 @@
 /*
- * linux/drivers/video/softcursor.c -- Generic software cursor for frame buffer devices
+ * linux/drivers/video/softcursor.c
+ *
+ * Generic software cursor for frame buffer devices
  *
  *  Created 14 Nov 2002 by James Simmons
  *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file COPYING in the main directory of this archive
- * for more details.
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License.  See the file COPYING in the main directory of this
+ * archive for more details.
  */
 
 #include <linux/module.h>
@@ -25,7 +27,7 @@ int soft_cursor(struct fb_info *info, st
 	unsigned int buf_align = info->pixmap.buf_align - 1;
 	unsigned int i, size, dsize, s_pitch, d_pitch;
 	struct fb_image *image;
-	u8 *dst;
+	u8 *src, *dst;
 
 	if (info->state != FBINFO_STATE_RUNNING)
 		return 0;
@@ -45,7 +47,8 @@ int soft_cursor(struct fb_info *info, st
 		}
 	}
 
-	image = (struct fb_image *) (ops->cursor_src + dsize);
+	src = ops->cursor_src + sizeof(struct fb_image);
+	image = (struct fb_image *)ops->cursor_src;
 	*image = cursor->image;
 	d_pitch = (s_pitch + scan_align) & ~scan_align;
 
@@ -57,21 +60,18 @@ int soft_cursor(struct fb_info *info, st
 		switch (cursor->rop) {
 		case ROP_XOR:
 			for (i = 0; i < dsize; i++)
-				ops->cursor_src[i] = image->data[i] ^
-					cursor->mask[i];
+				src[i] = image->data[i] ^ cursor->mask[i];
 			break;
 		case ROP_COPY:
 		default:
 			for (i = 0; i < dsize; i++)
-				ops->cursor_src[i] = image->data[i] &
-					cursor->mask[i];
+				src[i] = image->data[i] & cursor->mask[i];
 			break;
 		}
 	} else
-		memcpy(ops->cursor_src, image->data, dsize);
+		memcpy(src, image->data, dsize);
 
-	fb_pad_aligned_buffer(dst, d_pitch, ops->cursor_src, s_pitch,
-			      image->height);
+	fb_pad_aligned_buffer(dst, d_pitch, src, s_pitch, image->height);
 	image->data = dst;
 	info->fbops->fb_imageblit(info, image);
 	return 0;
-- 
1.4.3.4


