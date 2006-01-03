Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932542AbWACWji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932542AbWACWji (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 17:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932541AbWACWjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 17:39:37 -0500
Received: from mail03.hansenet.de ([213.191.73.10]:9950 "EHLO
	webmail.hansenet.de") by vger.kernel.org with ESMTP id S932542AbWACWje
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 17:39:34 -0500
From: Thomas Koeller <thomas@koeller.dyndns.org>
To: adaplas@pol.net
Subject: [PATCH] non-linear frame buffer read/write access
Date: Tue, 3 Jan 2006 23:39:24 +0100
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601032339.24927.thomas@koeller.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While the code in fbmem.c allows for hooking read/write access
to non-linear frame buffers by means of fb_read and fb_write
in struct fb_ops, I could not find a way tho access the actual
frame buffer memory from within these routines. I therefore
had to patch fbmem.c, to be able to retrieve a pointer to
struct fb_info from the 'file' argument to these functions.

The second hunk of the patch is not strictly required, I only
did that for symmetry reasons (and the code is somewhat
shorter).

Patch is against 2.6.14

Signed-off-by: Thomas Koeller <thomas@koeller.dyndns.org>

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index e2667dd..145c18f 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -965,6 +965,7 @@ fb_open(struct inode *inode, struct file
 		return -ENODEV;
 	if (!try_module_get(info->fbops->owner))
 		return -ENODEV;
+	file->private_data = info;
 	if (info->fbops->fb_open) {
 		res = info->fbops->fb_open(info,1);
 		if (res)
@@ -976,11 +977,9 @@ fb_open(struct inode *inode, struct file
 static int 
 fb_release(struct inode *inode, struct file *file)
 {
-	int fbidx = iminor(inode);
-	struct fb_info *info;
+	struct fb_info * const info = (struct fb_info *) file->private_data;
 
 	lock_kernel();
-	info = registered_fb[fbidx];
 	if (info->fbops->fb_release)
 		info->fbops->fb_release(info,1);
 	module_put(info->fbops->owner);

-- 
Thomas Koeller
thomas at koeller dot dyndns dot org
