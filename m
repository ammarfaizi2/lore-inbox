Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266411AbUFQIRC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266411AbUFQIRC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 04:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266412AbUFQIRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 04:17:01 -0400
Received: from witte.sonytel.be ([80.88.33.193]:47517 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S266411AbUFQIQ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 04:16:57 -0400
Date: Thu, 17 Jun 2004 10:16:38 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jesper Juhl <juhl-lkml@dif.dk>, Andrew Morton <akpm@osdl.org>
cc: James Simmons <jsimmons@infradead.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix warning in fbmem.c
In-Reply-To: <8A43C34093B3D5119F7D0004AC56F4BC082C7F93@difpst1a.dif.dk>
Message-ID: <Pine.GSO.4.58.0406171015270.21503@waterleaf.sonytel.be>
References: <8A43C34093B3D5119F7D0004AC56F4BC082C7F93@difpst1a.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2004, Jesper Juhl wrote:
> Here are two proposed patches to fix the following warning in fbmem.c :
> drivers/video/fbmem.c:933: warning: passing arg 1 of `copy_from_user' discards qualifiers from pointer target type
>
> The cause of the warning is that the .data member of struct fb_image is of
> type 'const char *' and copy_from_user() takes a 'void *' as it's first
> 'to' argument.
> I see two ways to fix it;
> a) use a simple cast to hide the warning
> b) rewrite the code to copy into a buffer pointed to by a non-const
> pointer, then assign the pointer to cursor.image.data

Here is a variant of b, which avoids the cast and makes cursor.mask const as
well.

--- linux-2.6.7-rc1/drivers/video/fbmem.c.orig	2004-05-24 11:38:04.000000000 +0200
+++ linux-2.6.7-rc1/drivers/video/fbmem.c	2004-06-07 22:38:42.000000000 +0200
@@ -916,26 +916,30 @@ fb_cursor(struct fb_info *info, struct f

 	if (cursor.set & FB_CUR_SETSHAPE) {
 		int size = ((cursor.image.width + 7) >> 3) * cursor.image.height;
+		char *data, *mask;
+
 		if ((cursor.image.height != info->cursor.image.height) ||
 		    (cursor.image.width != info->cursor.image.width))
 			cursor.set |= FB_CUR_SETSIZE;

-		cursor.image.data = kmalloc(size, GFP_KERNEL);
-		if (!cursor.image.data)
+		data = kmalloc(size, GFP_KERNEL);
+		if (!data)
 			return -ENOMEM;

-		cursor.mask = kmalloc(size, GFP_KERNEL);
-		if (!cursor.mask) {
-			kfree(cursor.image.data);
+		mask = kmalloc(size, GFP_KERNEL);
+		if (!mask) {
+			kfree(data);
 			return -ENOMEM;
 		}

-		if (copy_from_user(cursor.image.data, sprite->image.data, size) ||
-		    copy_from_user(cursor.mask, sprite->mask, size)) {
-			kfree(cursor.image.data);
-			kfree(cursor.mask);
+		if (copy_from_user(data, sprite->image.data, size) ||
+		    copy_from_user(mask, sprite->mask, size)) {
+			kfree(data);
+			kfree(mask);
 			return -EFAULT;
 		}
+		cursor.image.data = data;
+		cursor.mask = mask;
 	}
 	info->cursor.set = cursor.set;
 	info->cursor.rop = cursor.rop;
--- linux-2.6.7-rc1/include/linux/fb.h.orig	2004-05-24 11:14:01.000000000 +0200
+++ linux-2.6.7-rc1/include/linux/fb.h	2004-06-07 22:38:01.000000000 +0200
@@ -375,7 +375,7 @@ struct fb_cursor {
 	__u16 set;		/* what to set */
 	__u16 enable;		/* cursor on/off */
 	__u16 rop;		/* bitop operation */
-	char *mask;		/* cursor mask bits */
+	const char *mask;	/* cursor mask bits */
 	struct fbcurpos hot;	/* cursor hot spot */
 	struct fb_image	image;	/* Cursor image */
 };


Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
