Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266027AbUFIWq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266027AbUFIWq6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 18:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266092AbUFIWq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 18:46:58 -0400
Received: from relay2.EECS.Berkeley.EDU ([169.229.60.28]:34303 "EHLO
	relay2.EECS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S266027AbUFIWql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 18:46:41 -0400
Subject: PATCH: 2.6.7-rc3 drivers/video/fbmem.c: user/kernel pointer bugs
From: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 09 Jun 2004 15:46:39 -0700
Message-Id: <1086821199.32054.111.camel@dooby.cs.berkeley.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since sprite is a user pointer, reading sprite->mask or sprite->image.data 
requires unsafe dereferences.  Let me know if you have any questions or if 
I've made a mistake.

Best,
Rob

--- linux-2.6.7-rc3-full/drivers/video/fbmem.c.orig	Wed Jun  9 13:09:30 2004
+++ linux-2.6.7-rc3-full/drivers/video/fbmem.c	Wed Jun  9 13:07:06 2004
@@ -901,7 +901,9 @@ fb_cursor(struct fb_info *info, struct f
 {
 	struct fb_cursor cursor;
 	int err;
-	
+	char *mask;
+	const char *image_data;
+
 	if (copy_from_user(&cursor, sprite, sizeof(struct fb_cursor)))
 		return -EFAULT;
 
@@ -920,18 +922,20 @@ fb_cursor(struct fb_info *info, struct f
 		    (cursor.image.width != info->cursor.image.width))
 			cursor.set |= FB_CUR_SETSIZE;
 		
+		image_data = cursor.image.data;
 		cursor.image.data = kmalloc(size, GFP_KERNEL);
 		if (!cursor.image.data)
 			return -ENOMEM;
 		
+		mask = cursor.mask;
 		cursor.mask = kmalloc(size, GFP_KERNEL);
 		if (!cursor.mask) {
 			kfree(cursor.image.data);
 			return -ENOMEM;
 		}
 		
-		if (copy_from_user(cursor.image.data, sprite->image.data, size) ||
-		    copy_from_user(cursor.mask, sprite->mask, size)) { 
+		if (copy_from_user(cursor.image.data, image_data, size) ||
+		    copy_from_user(cursor.mask, mask, size)) { 
 			kfree(cursor.image.data);
 			kfree(cursor.mask);
 			return -EFAULT;


