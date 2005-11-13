Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbVKMHi6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbVKMHi6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 02:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbVKMHi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 02:38:58 -0500
Received: from verein.lst.de ([213.95.11.210]:59315 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S932081AbVKMHi5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 02:38:57 -0500
Date: Sun, 13 Nov 2005 08:38:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sanitize ->fb_ioctl prototype
Message-ID: <20051113073847.GA748@lst.de>
References: <20051111083457.GA26175@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051111083457.GA26175@lst.de>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2005 at 09:34:57AM +0100, Christoph Hellwig wrote:
> The ioctl and file arguments to ->fb_ioctl are totally unused and there's
> not reason a driver should need them.
> 
> Also update the ->fb_compat_ioctl prototype to be the same as ->fb_mmap.

Updates for the newly added sbusfb_compat_ioctl:


Index: linux-2.6/drivers/video/sbuslib.c
===================================================================
--- linux-2.6.orig/drivers/video/sbuslib.c	2005-11-12 23:49:59.000000000 +0100
+++ linux-2.6/drivers/video/sbuslib.c	2005-11-12 23:56:33.000000000 +0100
@@ -196,8 +196,8 @@
 #define FBIOPUTCMAP32	_IOW('F', 3, struct fbcmap32)
 #define FBIOGETCMAP32	_IOW('F', 4, struct fbcmap32)
 
-static int fbiogetputcmap(struct file *file, struct fb_info *info,
-		unsigned int cmd, unsigned long arg)
+static int fbiogetputcmap(struct fb_info *info, unsigned int cmd,
+		unsigned long arg)
 {
 	struct fbcmap32 __user *argp = (void __user *)arg;
 	struct fbcmap __user *p = compat_alloc_user_space(sizeof(*p));
@@ -213,10 +213,9 @@
 	ret |= put_user(compat_ptr(addr), &p->blue);
 	if (ret)
 		return -EFAULT;
-	return info->fbops->fb_ioctl(file->f_dentry->d_inode, file,
-			(cmd == FBIOPUTCMAP32) ?
+	return info->fbops->fb_ioctl(info, (cmd == FBIOPUTCMAP32) ?
 			FBIOPUTCMAP_SPARC : FBIOGETCMAP_SPARC,
-			(unsigned long)p, info);
+			(unsigned long)p);
 }
 
 struct fbcursor32 {
@@ -233,8 +232,7 @@
 #define FBIOSCURSOR32	_IOW('F', 24, struct fbcursor32)
 #define FBIOGCURSOR32	_IOW('F', 25, struct fbcursor32)
 
-static int fbiogscursor(struct file *file, struct fb_info *info,
-		unsigned long arg)
+static int fbiogscursor(struct fb_info *info, unsigned long arg)
 {
 	struct fbcursor __user *p = compat_alloc_user_space(sizeof(*p));
 	struct fbcursor32 __user *argp =  (void __user *)arg;
@@ -257,12 +255,11 @@
 	ret |= put_user(compat_ptr(addr), &p->image);
 	if (ret)
 		return -EFAULT;
-	return info->fbops->fb_ioctl(file->f_dentry->d_inode, file,
-			FBIOSCURSOR, (unsigned long)p, info);
+	return info->fbops->fb_ioctl(info, FBIOSCURSOR, (unsigned long)p);
 }
 
-long sbusfb_compat_ioctl(struct file *file, unsigned int cmd,
-		unsigned long arg, struct fb_info *info)
+int sbusfb_compat_ioctl(struct fb_info *info, unsigned int cmd,
+		unsigned long arg)
 {
 	switch (cmd) {
 	case FBIOGTYPE:
@@ -275,14 +272,13 @@
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
Index: linux-2.6/drivers/video/sbuslib.h
===================================================================
--- linux-2.6.orig/drivers/video/sbuslib.h	2005-11-12 23:49:59.000000000 +0100
+++ linux-2.6/drivers/video/sbuslib.h	2005-11-12 23:54:53.000000000 +0100
@@ -20,7 +20,7 @@
 int sbusfb_ioctl_helper(unsigned long cmd, unsigned long arg,
 			struct fb_info *info,
 			int type, int fb_depth, unsigned long fb_size);
-long sbusfb_compat_ioctl(struct file *file, unsigned int cmd,
-		unsigned long arg, struct fb_info *info);
+int sbusfb_compat_ioctl(struct fb_info *info, struct file *file,
+			unsigned int cmd);
 
 #endif /* _SBUSLIB_H */
