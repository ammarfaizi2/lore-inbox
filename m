Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262282AbVBVMSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262282AbVBVMSm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 07:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262286AbVBVMQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 07:16:37 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:56014 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262287AbVBVMME (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 07:12:04 -0500
Date: Tue, 22 Feb 2005 13:12:03 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: [Patch 3/6] Bind Mount Extensions 0.06
Message-ID: <20050222121203.GD3682@mail.13thfloor.at>
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
; This part propagates the vfsmount into chown_common() to allow
; vfsmount based checks there, and verifies that the vfsmount
; isn't RDONLY (in chown_common)
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

diff -NurpP --minimal linux-2.6.11-rc4-bme0.06-bm0.01-at0.01/fs/open.c linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01/fs/open.c
--- linux-2.6.11-rc4-bme0.06-bm0.01-at0.01/fs/open.c	2005-02-13 17:16:58 +0100
+++ linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01/fs/open.c	2005-02-19 06:31:43 +0100
@@ -661,7 +661,8 @@ out:
 	return error;
 }
 
-static int chown_common(struct dentry * dentry, uid_t user, gid_t group)
+static int chown_common(struct dentry *dentry, struct vfsmount *mnt,
+	uid_t user, gid_t group)
 {
 	struct inode * inode;
 	int error;
@@ -673,7 +674,7 @@ static int chown_common(struct dentry * 
 		goto out;
 	}
 	error = -EROFS;
-	if (IS_RDONLY(inode))
+	if (IS_RDONLY(inode) || MNT_IS_RDONLY(mnt))
 		goto out;
 	error = -EPERM;
 	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
@@ -703,7 +704,7 @@ asmlinkage long sys_chown(const char __u
 
 	error = user_path_walk(filename, &nd);
 	if (!error) {
-		error = chown_common(nd.dentry, user, group);
+		error = chown_common(nd.dentry, nd.mnt, user, group);
 		path_release(&nd);
 	}
 	return error;
@@ -716,7 +717,7 @@ asmlinkage long sys_lchown(const char __
 
 	error = user_path_walk_link(filename, &nd);
 	if (!error) {
-		error = chown_common(nd.dentry, user, group);
+		error = chown_common(nd.dentry, nd.mnt, user, group);
 		path_release(&nd);
 	}
 	return error;
@@ -730,7 +731,7 @@ asmlinkage long sys_fchown(unsigned int 
 
 	file = fget(fd);
 	if (file) {
-		error = chown_common(file->f_dentry, user, group);
+		error = chown_common(file->f_dentry, file->f_vfsmnt, user, group);
 		fput(file);
 	}
 	return error;
