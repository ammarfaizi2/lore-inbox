Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750947AbWHAS40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbWHAS40 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 14:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbWHAS40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 14:56:26 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6597 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750938AbWHAS4Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 14:56:25 -0400
Date: Tue, 1 Aug 2006 14:56:18 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: use persistent allocation for cursor blinking.
Message-ID: <20060801185618.GS22240@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Every time the console cursor blinks, we do a kmalloc/kfree pair.
This patch turns that into a single allocation.

This allocation was the most frequent kmalloc I saw on my test box.

Signed-off-by: Dave Jones <davej@redhat.com>


--- linux-2.6.14/drivers/video/console/softcursor.c~	2005-12-28 18:40:08.000000000 -0500
+++ linux-2.6.14/drivers/video/console/softcursor.c	2005-12-28 18:45:50.000000000 -0500
@@ -23,7 +23,9 @@ int soft_cursor(struct fb_info *info, st
 	unsigned int buf_align = info->pixmap.buf_align - 1;
 	unsigned int i, size, dsize, s_pitch, d_pitch;
 	struct fb_image *image;
-	u8 *dst, *src;
+	u8 *dst;
+	static u8 *src=NULL;
+	static int allocsize=0;
 
 	if (info->state != FBINFO_STATE_RUNNING)
 		return 0;
@@ -31,9 +33,15 @@ int soft_cursor(struct fb_info *info, st
 	s_pitch = (cursor->image.width + 7) >> 3;
 	dsize = s_pitch * cursor->image.height;
 
-	src = kmalloc(dsize + sizeof(struct fb_image), GFP_ATOMIC);
-	if (!src)
-		return -ENOMEM;
+	if (dsize + sizeof(struct fb_image) != allocsize) {
+		if (src != NULL)
+			kfree(src);
+		allocsize = dsize + sizeof(struct fb_image);
+
+		src = kmalloc(allocsize, GFP_ATOMIC);
+		if (!src)
+			return -ENOMEM;
+	}
 
 	image = (struct fb_image *) (src + dsize);
 	*image = cursor->image;
@@ -61,7 +69,6 @@ int soft_cursor(struct fb_info *info, st
 	fb_pad_aligned_buffer(dst, d_pitch, src, s_pitch, image->height);
 	image->data = dst;
 	info->fbops->fb_imageblit(info, image);
-	kfree(src);
 	return 0;
 }
 

-- 
http://www.codemonkey.org.uk
