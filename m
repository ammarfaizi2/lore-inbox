Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264551AbUFJJsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264551AbUFJJsj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 05:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266013AbUFJJqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 05:46:22 -0400
Received: from witte.sonytel.be ([80.88.33.193]:37580 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S264551AbUFJJQP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 05:16:15 -0400
Date: Thu, 10 Jun 2004 11:15:56 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
cc: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] PATCH: 2.6.7-rc3 drivers/video/fbmem.c:
 user/kernel pointer bugs
In-Reply-To: <1086821199.32054.111.camel@dooby.cs.berkeley.edu>
Message-ID: <Pine.GSO.4.58.0406101114480.14266@waterleaf.sonytel.be>
References: <1086821199.32054.111.camel@dooby.cs.berkeley.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jun 2004, Robert T. Johnson wrote:
> Since sprite is a user pointer, reading sprite->mask or sprite->image.data
> requires unsafe dereferences.  Let me know if you have any questions or if
> I've made a mistake.

I sent this one (untested, except for a compile test) to linux-fbdev-devel a
few days ago.

It also makes cursor.mask const, just like image.data.

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
