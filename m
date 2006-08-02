Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750939AbWHBBWI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbWHBBWI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 21:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbWHBBWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 21:22:08 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:11955 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750939AbWHBBWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 21:22:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=GsK702T4t6/lSJSlUtsYhKKF5L3rVmm4qlvQlk4R3C7JNZAVo6aDHeKL54hrKGDYNe6MKKch9IAHAMg11AsDNy1NOyTdpW/tefsW6N/J69Nx1FlEwTgAWjPZLQoRbdmPIbuw7gDJTvFX+nwN3ARnFgTLjMCNFfy/Rh3yJuAHcFw=
Message-ID: <44CFFDF1.6030909@gmail.com>
Date: Wed, 02 Aug 2006 09:20:49 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Roland Dreier <rdreier@cisco.com>, Dave Jones <davej@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] fbcon: Use persistent allocation for cursor blinking.
References: <20060801185618.GS22240@redhat.com>  <adairlc5ktk.fsf@cisco.com> <1154470813.15540.95.camel@localhost.localdomain>
In-Reply-To: <1154470813.15540.95.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Jones <davej@redhat.com>

Every time the console cursor blinks, we do a kmalloc/kfree pair.
This patch turns that into a single allocation.

This allocation was the most frequent kmalloc I saw on my test box.

[adaplas]
Per Alan's suggestion, move global variables to fbcon's private structure.
This would also avoid resource leaks when fbcon is unloaded.

Signed-off-by: Dave Jones <davej@redhat.com>
Acked-by: Alan Cox <alan@redhat.com>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

Alan Cox wrote:
> Ar Maw, 2006-08-01 am 12:15 -0700, ysgrifennodd Roland Dreier:
>>  > Every time the console cursor blinks, we do a kmalloc/kfree pair.
>>  > This patch turns that into a single allocation.

Thanks for doing this.

>>
>> A naiive question from someone who knows nothing about this subsystem:
>> is there any possibility of concurrent calls into this function, for
>> example if there are multiple cursors on a multiheaded system?
> 
> We don't do console multihead so its basically OK. Moving all the
> console globals into a struct so we can have multiple instances would be
> a good thing [tm] and it would make sense for the variable to end up in
> said structure if it was done.
> 

Here's an update. Taking Alan's cue, I just moved the global variables
to struct fbcon_ops.

Tony


 drivers/video/console/fbcon.c      |    3 +++
 drivers/video/console/fbcon.h      |    2 ++
 drivers/video/console/softcursor.c |   31 +++++++++++++++++++++----------
 3 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 390439b..6165fd9 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -3225,7 +3225,10 @@ #endif
 			module_put(info->fbops->owner);
 
 			if (info->fbcon_par) {
+				struct fbcon_ops *ops = info->fbcon_par;
+
 				fbcon_del_cursor_timer(info);
+				kfree(ops->cursor_src);
 				kfree(info->fbcon_par);
 				info->fbcon_par = NULL;
 			}
diff --git a/drivers/video/console/fbcon.h b/drivers/video/console/fbcon.h
index f244ad0..0b73ae9 100644
--- a/drivers/video/console/fbcon.h
+++ b/drivers/video/console/fbcon.h
@@ -80,6 +80,8 @@ struct fbcon_ops {
 	char  *cursor_data;
 	u8    *fontbuffer;
 	u8    *fontdata;
+	u8    *cursor_src;
+	u8     cursor_size;
 	u32    fd_size;
 };
     /*
diff --git a/drivers/video/console/softcursor.c b/drivers/video/console/softcursor.c
index 557c563..7d07d83 100644
--- a/drivers/video/console/softcursor.c
+++ b/drivers/video/console/softcursor.c
@@ -20,11 +20,12 @@ #include "fbcon.h"
 
 int soft_cursor(struct fb_info *info, struct fb_cursor *cursor)
 {
+	struct fbcon_ops *ops = info->fbcon_par;
 	unsigned int scan_align = info->pixmap.scan_align - 1;
 	unsigned int buf_align = info->pixmap.buf_align - 1;
 	unsigned int i, size, dsize, s_pitch, d_pitch;
 	struct fb_image *image;
-	u8 *dst, *src;
+	u8 *dst;
 
 	if (info->state != FBINFO_STATE_RUNNING)
 		return 0;
@@ -32,11 +33,19 @@ int soft_cursor(struct fb_info *info, st
 	s_pitch = (cursor->image.width + 7) >> 3;
 	dsize = s_pitch * cursor->image.height;
 
-	src = kmalloc(dsize + sizeof(struct fb_image), GFP_ATOMIC);
-	if (!src)
-		return -ENOMEM;
+	if (dsize + sizeof(struct fb_image) != ops->cursor_size) {
+		if (ops->cursor_src != NULL)
+			kfree(ops->cursor_src);
+		ops->cursor_size = dsize + sizeof(struct fb_image);
 
-	image = (struct fb_image *) (src + dsize);
+		ops->cursor_src = kmalloc(ops->cursor_size, GFP_ATOMIC);
+		if (!ops->cursor_src) {
+			ops->cursor_size = 0;
+			return -ENOMEM;
+		}
+	}
+
+	image = (struct fb_image *) (ops->cursor_src + dsize);
 	*image = cursor->image;
 	d_pitch = (s_pitch + scan_align) & ~scan_align;
 
@@ -48,21 +57,23 @@ int soft_cursor(struct fb_info *info, st
 		switch (cursor->rop) {
 		case ROP_XOR:
 			for (i = 0; i < dsize; i++)
-				src[i] = image->data[i] ^ cursor->mask[i];
+				ops->cursor_src[i] = image->data[i] ^
+					cursor->mask[i];
 			break;
 		case ROP_COPY:
 		default:
 			for (i = 0; i < dsize; i++)
-				src[i] = image->data[i] & cursor->mask[i];
+				ops->cursor_src[i] = image->data[i] &
+					cursor->mask[i];
 			break;
 		}
 	} else
-		memcpy(src, image->data, dsize);
+		memcpy(ops->cursor_src, image->data, dsize);
 
-	fb_pad_aligned_buffer(dst, d_pitch, src, s_pitch, image->height);
+	fb_pad_aligned_buffer(dst, d_pitch, ops->cursor_src, s_pitch,
+			      image->height);
 	image->data = dst;
 	info->fbops->fb_imageblit(info, image);
-	kfree(src);
 	return 0;
 }
 


