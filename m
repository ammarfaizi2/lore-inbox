Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262289AbVBVMSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262289AbVBVMSk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 07:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262282AbVBVMPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 07:15:53 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:57806 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262290AbVBVMNE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 07:13:04 -0500
Date: Tue, 22 Feb 2005 13:13:03 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: [Patch 5/6] Bind Mount Extensions 0.06
Message-ID: <20050222121303.GF3682@mail.13thfloor.at>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



;
; Bind Mount Extensions
;
; This part propagates the vfsmount into both setxattr() and
; removexattr() to allow for vfsmount based checks there, and
; verifies that the vfsmount isn't RDONLY
;
; Copyright (C) 2003-2005 Herbert Pötzl <herbert@13thfloor.at>
;
; Changelog:
;
;   0.01  - broken out part from bme0.05
;
; this patch is free software; you can redistribute it and/or
; modify it under the terms of the GNU General Public License
; as published by the Free Software Foundation; either version 2
; of the License, or (at your option) any later version.
;
; this patch is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.
;

diff -NurpP --minimal linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01/fs/xattr.c linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01/fs/xattr.c
--- linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01/fs/xattr.c	2004-12-25 01:55:21 +0100
+++ linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01/fs/xattr.c	2005-02-19 06:31:58 +0100
@@ -23,7 +23,7 @@
  */
 static long
 setxattr(struct dentry *d, char __user *name, void __user *value,
-	 size_t size, int flags)
+	 size_t size, int flags, struct vfsmount *mnt)
 {
 	int error;
 	void *kvalue = NULL;
@@ -56,6 +56,9 @@ setxattr(struct dentry *d, char __user *
 		error = security_inode_setxattr(d, kname, kvalue, size, flags);
 		if (error)
 			goto out;
+		error = -EROFS;
+		if (MNT_IS_RDONLY(mnt))
+			goto out;
 		error = d->d_inode->i_op->setxattr(d, kname, kvalue, size, flags);
 		if (!error)
 			security_inode_post_setxattr(d, kname, kvalue, size, flags);
@@ -77,7 +80,7 @@ sys_setxattr(char __user *path, char __u
 	error = user_path_walk(path, &nd);
 	if (error)
 		return error;
-	error = setxattr(nd.dentry, name, value, size, flags);
+	error = setxattr(nd.dentry, name, value, size, flags, nd.mnt);
 	path_release(&nd);
 	return error;
 }
@@ -92,7 +95,7 @@ sys_lsetxattr(char __user *path, char __
 	error = user_path_walk_link(path, &nd);
 	if (error)
 		return error;
-	error = setxattr(nd.dentry, name, value, size, flags);
+	error = setxattr(nd.dentry, name, value, size, flags, nd.mnt);
 	path_release(&nd);
 	return error;
 }
@@ -107,7 +110,7 @@ sys_fsetxattr(int fd, char __user *name,
 	f = fget(fd);
 	if (!f)
 		return error;
-	error = setxattr(f->f_dentry, name, value, size, flags);
+	error = setxattr(f->f_dentry, name, value, size, flags, f->f_vfsmnt);
 	fput(f);
 	return error;
 }
@@ -285,7 +288,7 @@ sys_flistxattr(int fd, char __user *list
  * Extended attribute REMOVE operations
  */
 static long
-removexattr(struct dentry *d, char __user *name)
+removexattr(struct dentry *d, char __user *name, struct vfsmount *mnt)
 {
 	int error;
 	char kname[XATTR_NAME_MAX + 1];
@@ -301,6 +304,9 @@ removexattr(struct dentry *d, char __use
 		error = security_inode_removexattr(d, kname);
 		if (error)
 			goto out;
+		error = -EROFS;
+		if (MNT_IS_RDONLY(mnt))
+			goto out;
 		down(&d->d_inode->i_sem);
 		error = d->d_inode->i_op->removexattr(d, kname);
 		up(&d->d_inode->i_sem);
@@ -318,7 +324,7 @@ sys_removexattr(char __user *path, char 
 	error = user_path_walk(path, &nd);
 	if (error)
 		return error;
-	error = removexattr(nd.dentry, name);
+	error = removexattr(nd.dentry, name, nd.mnt);
 	path_release(&nd);
 	return error;
 }
@@ -332,7 +338,7 @@ sys_lremovexattr(char __user *path, char
 	error = user_path_walk_link(path, &nd);
 	if (error)
 		return error;
-	error = removexattr(nd.dentry, name);
+	error = removexattr(nd.dentry, name, nd.mnt);
 	path_release(&nd);
 	return error;
 }
@@ -346,7 +352,7 @@ sys_fremovexattr(int fd, char __user *na
 	f = fget(fd);
 	if (!f)
 		return error;
-	error = removexattr(f->f_dentry, name);
+	error = removexattr(f->f_dentry, name, f->f_vfsmnt);
 	fput(f);
 	return error;
 }
