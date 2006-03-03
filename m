Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751192AbWCCHlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbWCCHlA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 02:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751672AbWCCHlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 02:41:00 -0500
Received: from pcls3.std.com ([192.74.137.143]:2213 "EHLO TheWorld.com")
	by vger.kernel.org with ESMTP id S1751076AbWCCHlA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 02:41:00 -0500
From: Alan Curry <pacman@TheWorld.com>
Message-Id: <200603030717.CAA1936751@shell.TheWorld.com>
Subject: [PATCH] framebuffer: cmap-setting return values
To: linux-kernel@vger.kernel.org
Date: Fri, 3 Mar 2006 02:17:54 -0500 (EST)
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A set of 3 small bugfixes, all of which are related to bogus return values of
fb colormap-setting functions.

First, fb_alloc_cmap returns -1 if memory allocation fails. This is a hard
condition to reproduce since you'd have to be really low on memory, but from
studying the contexts in which it is called, I think this function should be
returning a negative errno, and the -1 will be seen as an EPERM. Switching it
to -ENOMEM makes sense.

Second, the store_cmap function which is called for writes to
/sys/class/graphics/fb0/color_map returns 0 for success, but it should be
returning the count of bytes written since its return value ends up in
userspace as the result of the write() syscall.

Third, radeonfb returns 1 instead of a negative errno when FBIOPUTCMAP is
called with an oversized colormap. This is seen in userspace as a return
value of 1 from the ioctl() syscall with errno left unchanged. A more useful
return value would be -EINVAL.

Signed-off-by: Alan Curry <pacman@TheWorld.com>

--- drivers/video/fbcmap.c.orig	2006-03-02 19:27:32.000000000 -0500
+++ drivers/video/fbcmap.c	2006-03-03 00:57:11.000000000 -0500
@@ -85,7 +85,7 @@ static struct fb_cmap default_16_colors 
  *	Allocates memory for a colormap @cmap.  @len is the
  *	number of entries in the palette.
  *
- *	Returns -1 errno on error, or zero on success.
+ *	Returns negative errno on error, or zero on success.
  *
  */
 
@@ -116,7 +116,7 @@ int fb_alloc_cmap(struct fb_cmap *cmap, 
 
 fail:
     fb_dealloc_cmap(cmap);
-    return -1;
+    return -ENOMEM;
 }
 
 /**
--- drivers/video/fbsysfs.c.orig	2006-03-03 00:43:24.000000000 -0500
+++ drivers/video/fbsysfs.c	2006-03-03 00:57:10.000000000 -0500
@@ -348,7 +348,7 @@ static ssize_t store_cmap(struct class_d
 		fb_copy_cmap(&umap, &fb_info->cmap);
 		fb_dealloc_cmap(&umap);
 
-		return rc;
+		return rc ?: count;
 	}
 	for (i = 0; i < length; i++) {
 		u16 red, blue, green, tsp;
@@ -367,7 +367,7 @@ static ssize_t store_cmap(struct class_d
 		if (transp)
 			fb_info->cmap.transp[i] = tsp;
 	}
-	return 0;
+	return count;
 }
 
 static ssize_t show_cmap(struct class_device *class_device, char *buf)
--- drivers/video/aty/radeon_base.c.orig	2006-03-03 00:52:12.000000000 -0500
+++ drivers/video/aty/radeon_base.c	2006-03-03 00:57:11.000000000 -0500
@@ -1067,7 +1067,7 @@ static int radeon_setcolreg (unsigned re
 
 
 	if (regno > 255)
-		return 1;
+		return -EINVAL;
 
 	red >>= 8;
 	green >>= 8;
@@ -1086,9 +1086,9 @@ static int radeon_setcolreg (unsigned re
 			pindex = regno * 8;
 
 			if (rinfo->depth == 16 && regno > 63)
-				return 1;
+				return -EINVAL;
 			if (rinfo->depth == 15 && regno > 31)
-				return 1;
+				return -EINVAL;
 
 			/* For 565, the green component is mixed one order
 			 * below
