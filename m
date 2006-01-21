Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751184AbWAUInE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbWAUInE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 03:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWAUInE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 03:43:04 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:29629 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1751184AbWAUInC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 03:43:02 -0500
Date: Sat, 21 Jan 2006 09:43:01 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, Al Viro <viro@ftp.linux.org.uk>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/6] vfs: propagate the vfsmount into *xattr()
Message-ID: <20060121084301.GF10044@MAIL.13thfloor.at>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
	Al Viro <viro@ftp.linux.org.uk>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <20060121083843.GA10044@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060121083843.GA10044@MAIL.13thfloor.at>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


;
; Bind Mount Extensions
;
; Copyright (C) 2003-2006 Herbert Pötzl <herbert@13thfloor.at>
;
; propagate the vfsmount into both setxattr() and removexattr()
; to allow for vfsmount based checks there ensuring that
; the vfsmount isn't read-only
;
;
; Changelog:
;
;   0.01  - broken out part from bme0.05
;

Signed-off-by: Herbert Pötzl <herbert@13thfloor.at>

diff -NurpP --minimal linux-2.6.16-rc1/fs/xattr.c linux-2.6.16-rc1-bme0.06.2-xa0.01/fs/xattr.c
--- linux-2.6.16-rc1/fs/xattr.c	2006-01-18 06:08:35 +0100
+++ linux-2.6.16-rc1-bme0.06.2-xa0.01/fs/xattr.c	2006-01-21 09:09:20 +0100
@@ -17,6 +17,7 @@
 #include <linux/syscalls.h>
 #include <linux/module.h>
 #include <linux/fsnotify.h>
+#include <linux/mount.h>
 #include <asm/uaccess.h>
 
 
@@ -167,7 +168,7 @@ EXPORT_SYMBOL_GPL(vfs_removexattr);
  */
 static long
 setxattr(struct dentry *d, char __user *name, void __user *value,
-	 size_t size, int flags)
+	 size_t size, int flags, struct vfsmount *mnt)
 {
 	int error;
 	void *kvalue = NULL;
@@ -194,6 +195,9 @@ setxattr(struct dentry *d, char __user *
 		}
 	}
 
+	if (MNT_IS_RDONLY(mnt))
+		return -EROFS;
+
 	error = vfs_setxattr(d, kname, kvalue, size, flags);
 	kfree(kvalue);
 	return error;
@@ -209,7 +213,7 @@ sys_setxattr(char __user *path, char __u
 	error = user_path_walk(path, &nd);
 	if (error)
 		return error;
-	error = setxattr(nd.dentry, name, value, size, flags);
+	error = setxattr(nd.dentry, name, value, size, flags, nd.mnt);
 	path_release(&nd);
 	return error;
 }
@@ -224,7 +228,7 @@ sys_lsetxattr(char __user *path, char __
 	error = user_path_walk_link(path, &nd);
 	if (error)
 		return error;
-	error = setxattr(nd.dentry, name, value, size, flags);
+	error = setxattr(nd.dentry, name, value, size, flags, nd.mnt);
 	path_release(&nd);
 	return error;
 }
@@ -239,7 +243,7 @@ sys_fsetxattr(int fd, char __user *name,
 	f = fget(fd);
 	if (!f)
 		return error;
-	error = setxattr(f->f_dentry, name, value, size, flags);
+	error = setxattr(f->f_dentry, name, value, size, flags, f->f_vfsmnt);
 	fput(f);
 	return error;
 }
@@ -412,7 +416,7 @@ sys_flistxattr(int fd, char __user *list
  * Extended attribute REMOVE operations
  */
 static long
-removexattr(struct dentry *d, char __user *name)
+removexattr(struct dentry *d, char __user *name, struct vfsmount *mnt)
 {
 	int error;
 	char kname[XATTR_NAME_MAX + 1];
@@ -423,6 +427,9 @@ removexattr(struct dentry *d, char __use
 	if (error < 0)
 		return error;
 
+	if (MNT_IS_RDONLY(mnt))
+		return -EROFS;
+
 	return vfs_removexattr(d, kname);
 }
 
@@ -435,7 +442,7 @@ sys_removexattr(char __user *path, char 
 	error = user_path_walk(path, &nd);
 	if (error)
 		return error;
-	error = removexattr(nd.dentry, name);
+	error = removexattr(nd.dentry, name, nd.mnt);
 	path_release(&nd);
 	return error;
 }
@@ -449,7 +456,7 @@ sys_lremovexattr(char __user *path, char
 	error = user_path_walk_link(path, &nd);
 	if (error)
 		return error;
-	error = removexattr(nd.dentry, name);
+	error = removexattr(nd.dentry, name, nd.mnt);
 	path_release(&nd);
 	return error;
 }
@@ -463,7 +470,7 @@ sys_fremovexattr(int fd, char __user *na
 	f = fget(fd);
 	if (!f)
 		return error;
-	error = removexattr(f->f_dentry, name);
+	error = removexattr(f->f_dentry, name, f->f_vfsmnt);
 	fput(f);
 	return error;
 }

