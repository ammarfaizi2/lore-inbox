Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264647AbUFPXtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264647AbUFPXtA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 19:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264762AbUFPXs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 19:48:59 -0400
Received: from mail.dif.dk ([193.138.115.101]:29868 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S264647AbUFPXs0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 19:48:26 -0400
Date: Thu, 17 Jun 2004 01:47:30 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: James Simmons <jsimmons@infradead.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] fix warning in fbmem.c
Message-ID: <8A43C34093B3D5119F7D0004AC56F4BC082C7F93@difpst1a.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here are two proposed patches to fix the following warning in fbmem.c :
drivers/video/fbmem.c:933: warning: passing arg 1 of `copy_from_user' discards qualifiers from pointer target type

The cause of the warning is that the .data member of struct fb_image is of
type 'const char *' and copy_from_user() takes a 'void *' as it's first
'to' argument.
I see two ways to fix it;
a) use a simple cast to hide the warning
b) rewrite the code to copy into a buffer pointed to by a non-const
pointer, then assign the pointer to cursor.image.data

Personally I prefer the second approach since just casting away const
defeats the whole purpose of having something const in the first place
(yes, I do realize it's quite safe in this case) and makes it look like it
could be hiding a bug on casual inspection. Better to make it completely
explicit that first we allocate a buffer and fill it, then we assign it to
this const member since it's not supposed to be changed again from this
point forward.
But, I've prepared patches implementing both solutions in case your
preference is different from mine.
Patching against 2.6.7


Here's first the patch that simply casts the pointer :

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.7-orig/drivers/video/fbmem.c	2004-06-16 07:18:37.000000000 +0200
+++ linux-2.6.7/drivers/video/fbmem.c	2004-06-17 00:59:48.000000000 +0200
@@ -930,7 +930,7 @@ fb_cursor(struct fb_info *info, struct f
 			return -ENOMEM;
 		}

-		if (copy_from_user(cursor.image.data, sprite->image.data, size) ||
+		if (copy_from_user((void *)cursor.image.data, sprite->image.data, size) ||
 		    copy_from_user(cursor.mask, sprite->mask, size)) {
 			kfree(cursor.image.data);
 			kfree(cursor.mask);


and here is the (in my oppinion better) patch that makes use of a
sepperate pointer and then assigns to cursor.image.data at the end :

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.7-orig/drivers/video/fbmem.c	2004-06-16 07:18:37.000000000 +0200
+++ linux-2.6.7/drivers/video/fbmem.c	2004-06-17 00:55:16.000000000 +0200
@@ -901,6 +901,7 @@ fb_cursor(struct fb_info *info, struct f
 {
 	struct fb_cursor cursor;
 	int err;
+	char *image_data;

 	if (copy_from_user(&cursor, sprite, sizeof(struct fb_cursor)))
 		return -EFAULT;
@@ -920,22 +921,23 @@ fb_cursor(struct fb_info *info, struct f
 		    (cursor.image.width != info->cursor.image.width))
 			cursor.set |= FB_CUR_SETSIZE;

-		cursor.image.data = kmalloc(size, GFP_KERNEL);
-		if (!cursor.image.data)
+		image_data = kmalloc(size, GFP_KERNEL);
+		if (!image_data)
 			return -ENOMEM;

 		cursor.mask = kmalloc(size, GFP_KERNEL);
 		if (!cursor.mask) {
-			kfree(cursor.image.data);
+			kfree(image_data);
 			return -ENOMEM;
 		}

-		if (copy_from_user(cursor.image.data, sprite->image.data, size) ||
+		if (copy_from_user(image_data, sprite->image.data, size) ||
 		    copy_from_user(cursor.mask, sprite->mask, size)) {
-			kfree(cursor.image.data);
+			kfree(image_data);
 			kfree(cursor.mask);
 			return -EFAULT;
 		}
+		cursor.image.data = image_data;
 	}
 	info->cursor.set = cursor.set;
 	info->cursor.rop = cursor.rop;


Notes:
I've only done compile testing of the first (simple cast) patch.
The second patch I've compile and boot tested and it seems to be OK.
If anyone on linux-fbdev-devel@lists.sourceforge.net want reply to this,
then please CC me as I'm not subscribed to that specific list.


--
Jesper Juhl <juhl-lkml@dif.dk>
