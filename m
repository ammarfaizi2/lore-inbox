Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbVARMcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbVARMcN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 07:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbVARMcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 07:32:13 -0500
Received: from colin2.muc.de ([193.149.48.15]:57607 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261279AbVARMcH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 07:32:07 -0500
Date: 18 Jan 2005 13:32:06 +0100
Date: Tue, 18 Jan 2005 13:32:06 +0100
From: Andi Kleen <ak@muc.de>
To: adaplas@pol.net, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Add compat_ioctl to frame buffer layer
Message-ID: <20050118123206.GB68224@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Forward compat_ioctl through the frame buffer layer.

This is needed for a followup patch.

Signed-off-by: Andi Kleen <ak@muc.de>


diff -u linux-2.6.11-rc1-bk4/drivers/video/fbmem.c-o linux-2.6.11-rc1-bk4/drivers/video/fbmem.c
--- linux-2.6.11-rc1-bk4/drivers/video/fbmem.c-o	2005-01-14 10:12:22.000000000 +0100
+++ linux-2.6.11-rc1-bk4/drivers/video/fbmem.c	2005-01-18 03:36:37.000000000 +0100
@@ -868,6 +868,23 @@
 	}
 }
 
+#ifdef CONFIG_COMPAT
+static long
+fb_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	int fbidx = iminor(file->f_dentry->d_inode);
+	struct fb_info *info = registered_fb[fbidx];
+	struct fb_ops *fb = info->fbops;
+	int ret;
+	if (fb->fb_compat_ioctl == NULL)
+		return -ENOIOCTLCMD;
+	lock_kernel();
+	ret = fb->fb_compat_ioctl(file, cmd, arg, info);
+	unlock_kernel();
+	return ret;
+}
+#endif
+
 static int 
 fb_mmap(struct file *file, struct vm_area_struct * vma)
 {
@@ -1009,6 +1026,9 @@
 	.read =		fb_read,
 	.write =	fb_write,
 	.ioctl =	fb_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl = fb_compat_ioctl,
+#endif
 	.mmap =		fb_mmap,
 	.open =		fb_open,
 	.release =	fb_release,
diff -u linux-2.6.11-rc1-bk4/include/linux/fb.h-o linux-2.6.11-rc1-bk4/include/linux/fb.h
--- linux-2.6.11-rc1-bk4/include/linux/fb.h-o	2005-01-14 10:12:26.000000000 +0100
+++ linux-2.6.11-rc1-bk4/include/linux/fb.h	2005-01-17 11:30:29.000000000 +0100
@@ -584,6 +584,10 @@
 	int (*fb_ioctl)(struct inode *inode, struct file *file, unsigned int cmd,
 			unsigned long arg, struct fb_info *info);
 
+	/* Handle 32bit compat ioctl (optional) */
+	int (*fb_compat_ioctl)(struct file *f, unsigned cmd, unsigned long arg,
+			       struct fb_info *info);
+
 	/* perform fb specific mmap */
 	int (*fb_mmap)(struct fb_info *info, struct file *file, struct vm_area_struct *vma);
 };
