Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbWHAWjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWHAWjo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 18:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbWHAWjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 18:39:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29576 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750707AbWHAWjn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 18:39:43 -0400
Date: Tue, 1 Aug 2006 18:39:40 -0400
From: Dave Jones <davej@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: use persistent allocation for cursor blinking.
Message-ID: <20060801223940.GH22240@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060801185618.GS22240@redhat.com> <1154470660.15540.92.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154470660.15540.92.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2006 at 11:17:40PM +0100, Alan Cox wrote:

 > If the allocation fails we have allocsize = "somesize" and src = NULL.
 > The next time we enter the if is false and we fall through and Oops
 > 
 > Either check src in the if or set allocsize to something impossible (eg
 > 0) on the error path.

Good catch.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6/drivers/video/console/softcursor.c~	2005-12-28 18:40:08.000000000 -0500
+++ linux-2.6/drivers/video/console/softcursor.c	2005-12-28 18:45:50.000000000 -0500
@@ -23,7 +23,9 @@ int soft_cursor(struct fb_info *info, st
 	unsigned int buf_align = info->pixmap.buf_align - 1;
 	unsigned int i, size, dsize, s_pitch, d_pitch;
 	struct fb_image *image;
-	u8 *dst, *src;
+	u8 *dst;
+	static u8 *src=NULL;
+	static int allocsize = 0;
 
 	if (info->state != FBINFO_STATE_RUNNING)
 		return 0;
@@ -31,9 +33,17 @@ int soft_cursor(struct fb_info *info, st
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
+		if (!src) {
+			allocsize = 0;
+			return -ENOMEM;
+		}
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
