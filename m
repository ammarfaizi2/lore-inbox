Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964805AbWBMTTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbWBMTTL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 14:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964811AbWBMTTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 14:19:10 -0500
Received: from pcpool00.mathematik.uni-freiburg.de ([132.230.30.150]:50314
	"EHLO pcpool00.mathematik.uni-freiburg.de") by vger.kernel.org
	with ESMTP id S964805AbWBMTTJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 14:19:09 -0500
Date: Mon, 13 Feb 2006 20:19:10 +0100
From: "Bernhard R. Link" <brlink@debian.org>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Antonino Daplas <adaplas@pol.net>,
       linux-fbdev-devel@lists.sourceforge.net
Subject: [PATCH] adapt drivers/video/sbuslib.c to new fb_compat_iotcl
Message-ID: <20060213191910.GA27589@pcpool00.mathematik.uni-freiburg.de>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Antonino Daplas <adaplas@pol.net>,
	linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch "sanitize ->fb_ioctl prototype" changed prototypes but did
not adopt the code within CONFIG_COMPAT, which this patch does.

Signed-off-by: Bernhard R Link <brlink@debian.org>

---
Only test-compiled, but looks obvious and at least it compiles again.

Index: mlinux-2.6.15-git12/drivers/video/sbuslib.c
===================================================================
--- mlinux-2.6.15-git12.orig/drivers/video/sbuslib.c	2006-02-13 14:28:09.000000000 +0100
+++ mlinux-2.6.15-git12/drivers/video/sbuslib.c	2006-02-13 19:59:37.000000000 +0100
@@ -199,7 +199,7 @@
 #define FBIOPUTCMAP32	_IOW('F', 3, struct fbcmap32)
 #define FBIOGETCMAP32	_IOW('F', 4, struct fbcmap32)
 
-static int fbiogetputcmap(struct file *file, struct fb_info *info,
+static int fbiogetputcmap(struct fb_info *info,
 		unsigned int cmd, unsigned long arg)
 {
 	struct fbcmap32 __user *argp = (void __user *)arg;
@@ -216,10 +216,10 @@
 	ret |= put_user(compat_ptr(addr), &p->blue);
 	if (ret)
 		return -EFAULT;
-	return info->fbops->fb_ioctl(file->f_dentry->d_inode, file,
+	return info->fbops->fb_ioctl(info,
 			(cmd == FBIOPUTCMAP32) ?
 			FBIOPUTCMAP_SPARC : FBIOGETCMAP_SPARC,
-			(unsigned long)p, info);
+			(unsigned long)p);
 }
 
 struct fbcursor32 {
@@ -236,8 +236,7 @@
 #define FBIOSCURSOR32	_IOW('F', 24, struct fbcursor32)
 #define FBIOGCURSOR32	_IOW('F', 25, struct fbcursor32)
 
-static int fbiogscursor(struct file *file, struct fb_info *info,
-		unsigned long arg)
+static int fbiogscursor(struct fb_info *info, unsigned long arg)
 {
 	struct fbcursor __user *p = compat_alloc_user_space(sizeof(*p));
 	struct fbcursor32 __user *argp =  (void __user *)arg;
@@ -260,12 +259,12 @@
 	ret |= put_user(compat_ptr(addr), &p->image);
 	if (ret)
 		return -EFAULT;
-	return info->fbops->fb_ioctl(file->f_dentry->d_inode, file,
-			FBIOSCURSOR, (unsigned long)p, info);
+	return info->fbops->fb_ioctl(info,
+			FBIOSCURSOR, (unsigned long)p);
 }
 
-long sbusfb_compat_ioctl(struct file *file, unsigned int cmd,
-		unsigned long arg, struct fb_info *info)
+int sbusfb_compat_ioctl(struct fb_info *info, unsigned int cmd,
+		unsigned long arg)
 {
 	switch (cmd) {
 	case FBIOGTYPE:
@@ -278,14 +277,13 @@
 	case FBIOSCURPOS:
 	case FBIOGCURPOS:
 	case FBIOGCURMAX:
-		return info->fbops->fb_ioctl(file->f_dentry->d_inode,
-				file, cmd, arg, info);
+		return info->fbops->fb_ioctl(info, cmd, arg);
 	case FBIOPUTCMAP32:
-		return fbiogetputcmap(file, info, cmd, arg);
+		return fbiogetputcmap(info, cmd, arg);
 	case FBIOGETCMAP32:
-		return fbiogetputcmap(file, info, cmd, arg);
+		return fbiogetputcmap(info, cmd, arg);
 	case FBIOSCURSOR32:
-		return fbiogscursor(file, info, arg);
+		return fbiogscursor(info, arg);
 	default:
 		return -ENOIOCTLCMD;
 	}
Index: mlinux-2.6.15-git12/drivers/video/sbuslib.h
===================================================================
--- mlinux-2.6.15-git12.orig/drivers/video/sbuslib.h	2006-02-13 14:28:09.000000000 +0100
+++ mlinux-2.6.15-git12/drivers/video/sbuslib.h	2006-02-13 19:59:18.000000000 +0100
@@ -20,7 +20,7 @@
 int sbusfb_ioctl_helper(unsigned long cmd, unsigned long arg,
 			struct fb_info *info,
 			int type, int fb_depth, unsigned long fb_size);
-long sbusfb_compat_ioctl(struct file *file, unsigned int cmd,
-		unsigned long arg, struct fb_info *info);
+int sbusfb_compat_ioctl(struct fb_info *info, unsigned int cmd,
+		unsigned long arg);
 
 #endif /* _SBUSLIB_H */
