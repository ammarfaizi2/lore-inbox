Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262292AbVBVMPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262292AbVBVMPa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 07:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbVBVMOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 07:14:42 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:57038 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262289AbVBVMMe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 07:12:34 -0500
Date: Tue, 22 Feb 2005 13:12:33 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: [Patch 4/6] Bind Mount Extensions 0.06
Message-ID: <20050222121233.GE3682@mail.13thfloor.at>
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
; This part adds mnt_may_create() and mnt_may_unlink() checks
; and uses them in lookup_create(), sys_rmdir() and sys_unlink()
; it also adds a RDONLY check to generic_write_checks() and
; for pipe_writev()
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

diff -NurpP --minimal linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01/fs/namei.c linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01/fs/namei.c
--- linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01/fs/namei.c	2005-02-13 17:16:55 +0100
+++ linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01/fs/namei.c	2005-02-19 06:31:50 +0100
@@ -1168,6 +1168,24 @@ static inline int may_create(struct inod
 	return permission(dir,MAY_WRITE | MAY_EXEC, nd);
 }
 
+static inline int mnt_may_create(struct vfsmount *mnt, struct inode *dir, struct dentry *child) {
+       if (child->d_inode)
+               return -EEXIST;
+       if (IS_DEADDIR(dir))
+               return -ENOENT;
+       if (MNT_IS_RDONLY(mnt))
+               return -EROFS;
+       return 0;
+}
+
+static inline int mnt_may_unlink(struct vfsmount *mnt, struct inode *dir, struct dentry *child) {
+       if (!child->d_inode)
+               return -ENOENT;
+       if (MNT_IS_RDONLY(mnt))
+               return -EROFS;
+       return 0;
+}
+
 /* 
  * Special case: O_CREAT|O_EXCL implies O_NOFOLLOW for security
  * reasons.
@@ -1518,23 +1536,28 @@ do_link:
 struct dentry *lookup_create(struct nameidata *nd, int is_dir)
 {
 	struct dentry *dentry;
+	int error;
 
 	down(&nd->dentry->d_inode->i_sem);
-	dentry = ERR_PTR(-EEXIST);
+	error = -EEXIST;
 	if (nd->last_type != LAST_NORM)
-		goto fail;
+		goto out;
 	nd->flags &= ~LOOKUP_PARENT;
 	dentry = lookup_hash(&nd->last, nd->dentry);
 	if (IS_ERR(dentry))
+		goto ret;
+	error = mnt_may_create(nd->mnt, nd->dentry->d_inode, dentry);
+	if (error)
 		goto fail;
+	error = -ENOENT;
 	if (!is_dir && nd->last.name[nd->last.len] && !dentry->d_inode)
-		goto enoent;
+		goto fail;
+ret:
 	return dentry;
-enoent:
-	dput(dentry);
-	dentry = ERR_PTR(-ENOENT);
 fail:
-	return dentry;
+	dput(dentry);
+out:
+	return ERR_PTR(error);
 }
 
 int vfs_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t dev)
@@ -1763,7 +1786,11 @@ asmlinkage long sys_rmdir(const char __u
 	dentry = lookup_hash(&nd.last, nd.dentry);
 	error = PTR_ERR(dentry);
 	if (!IS_ERR(dentry)) {
+		error = mnt_may_unlink(nd.mnt, nd.dentry->d_inode, dentry);
+		if (error)
+			goto exit2;
 		error = vfs_rmdir(nd.dentry->d_inode, dentry);
+	exit2:
 		dput(dentry);
 	}
 	up(&nd.dentry->d_inode->i_sem);
@@ -1835,6 +1862,9 @@ asmlinkage long sys_unlink(const char __
 		/* Why not before? Because we want correct error value */
 		if (nd.last.name[nd.last.len])
 			goto slashes;
+		error = mnt_may_unlink(nd.mnt, nd.dentry->d_inode, dentry);
+		if (error)
+			goto exit2;
 		inode = dentry->d_inode;
 		if (inode)
 			atomic_inc(&inode->i_count);
diff -NurpP --minimal linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01/fs/pipe.c linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01/fs/pipe.c
--- linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01/fs/pipe.c	2005-02-13 17:16:58 +0100
+++ linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01/fs/pipe.c	2005-02-19 06:31:50 +0100
@@ -334,7 +334,7 @@ out:
 		wake_up_interruptible(PIPE_WAIT(*inode));
 		kill_fasync(PIPE_FASYNC_READERS(*inode), SIGIO, POLL_IN);
 	}
-	if (ret > 0)
+	if ((ret > 0) && !MNT_IS_RDONLY(filp->f_vfsmnt))
 		inode_update_time(inode, 1);	/* mtime and ctime */
 	return ret;
 }
diff -NurpP --minimal linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01/mm/filemap.c linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01/mm/filemap.c
--- linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01/mm/filemap.c	2005-02-13 17:17:15 +0100
+++ linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01/mm/filemap.c	2005-02-19 06:31:50 +0100
@@ -1810,6 +1810,8 @@ inline int generic_write_checks(struct f
         }
 
 	if (!isblk) {
+		if (MNT_IS_RDONLY(file->f_vfsmnt))
+			return -EROFS;
 		/* FIXME: this is for backwards compatibility with 2.4 */
 		if (file->f_flags & O_APPEND)
                         *pos = i_size_read(inode);
