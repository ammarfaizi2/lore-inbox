Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272272AbTHDWQu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 18:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272243AbTHDWQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 18:16:49 -0400
Received: from www.13thfloor.at ([212.16.59.250]:34700 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S272235AbTHDWQJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 18:16:09 -0400
Date: Tue, 5 Aug 2003 00:16:15 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>,
       Christoph Hellwig <hch@infradead.org>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: RO --bind mount implementation ...
Message-ID: <20030804221615.GA18521@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>,
	Christoph Hellwig <hch@infradead.org>,
	Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A few days ago, I asked on lkml if mount options
like RO would be useful for --bind mounts, and
Christoph was so nice to refer me to a 'n step' 
plan posted by Al 'a while ago', which I could 
not find 8-) ...

anyway, I discussed this with some friends, and
they pointed out that this would be useful ...
so here is the first try ...

I hope my approach does not interfere with the
long term plans Alexander has, because I admire
his well designed evolution of the vfs layer ...

enjoy,
Herbert

--------------------------

;
; Bind Mount Extensions 
;
; this patch adds some functionality to the --bind
; type of vfs mounts.
;
; (C) 2003 Herbert Pötzl <herbert@13thfloor.at>
;
; Changelog:  
;
;   0.01  - readonly bind mounts
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

diff -NurP --minimal linux-2.4.22-pre10/fs/namei.c linux-2.4.22-pre10-bme0.01/fs/namei.c
--- linux-2.4.22-pre10/fs/namei.c	2003-08-02 02:32:05.000000000 +0200
+++ linux-2.4.22-pre10-bme0.01/fs/namei.c	2003-08-04 23:51:54.000000000 +0200
@@ -935,6 +935,24 @@
 	return permission(dir,MAY_WRITE | MAY_EXEC);
 }
 
+static inline int mnt_may_create(struct vfsmount *mnt, struct inode *dir, struct dentry *child) {
+	if (child->d_inode)
+		return -EEXIST;
+	if (IS_DEADDIR(dir))
+		return -ENOENT;
+	if (mnt->mnt_flags & MNT_RDONLY)
+		return -EROFS;
+	return 0;
+}
+
+static inline int mnt_may_unlink(struct vfsmount *mnt, struct inode *dir, struct dentry *child) {
+	if (!child->d_inode)
+		return -ENOENT;
+	if (mnt->mnt_flags & MNT_RDONLY)
+		return -EROFS;
+	return 0;
+}
+
 /* 
  * Special case: O_CREAT|O_EXCL implies O_NOFOLLOW for security
  * reasons.
@@ -1025,6 +1043,9 @@
 	error = path_lookup(pathname, LOOKUP_PARENT, nd);
 	if (error)
 		return error;
+	error = -EROFS;
+	if (MNT_IS_RDONLY(nd->mnt))
+		return error;
 
 	/*
 	 * We have the parent and last component. First of all, check
@@ -1120,7 +1141,7 @@
 		flag &= ~O_TRUNC;
 	} else {
 		error = -EROFS;
-		if (IS_RDONLY(inode) && (flag & 2))
+		if ((flag & 2) && (IS_RDONLY(inode) || MNT_IS_RDONLY(nd->mnt)))
 			goto exit;
 	}
 	/*
@@ -1216,22 +1237,27 @@
 static struct dentry *lookup_create(struct nameidata *nd, int is_dir)
 {
 	struct dentry *dentry;
+	int error;
 
 	down(&nd->dentry->d_inode->i_sem);
-	dentry = ERR_PTR(-EEXIST);
+	error = -EEXIST;
 	if (nd->last_type != LAST_NORM)
-		goto fail;
+		goto out;
 	dentry = lookup_hash(&nd->last, nd->dentry);
 	if (IS_ERR(dentry))
-		goto fail;
+		goto ret;
+	error = mnt_may_create(nd->mnt, nd->dentry->d_inode, dentry);
+	if (error)
+		goto fail; 
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
@@ -1457,7 +1483,11 @@
 	dentry = lookup_hash(&nd.last, nd.dentry);
 	error = PTR_ERR(dentry);
 	if (!IS_ERR(dentry)) {
+		error = mnt_may_unlink(nd.mnt, nd.dentry->d_inode, dentry);
+			if (error)
+				goto exit2;
 		error = vfs_rmdir(nd.dentry->d_inode, dentry);
+	exit2:
 		dput(dentry);
 	}
 	up(&nd.dentry->d_inode->i_sem);
@@ -1519,7 +1549,9 @@
 		/* Why not before? Because we want correct error value */
 		if (nd.last.name[nd.last.len])
 			goto slashes;
-		error = vfs_unlink(nd.dentry->d_inode, dentry);
+		error = mnt_may_unlink(nd.mnt, nd.dentry->d_inode, dentry);
+		if (!error)
+			error = vfs_unlink(nd.dentry->d_inode, dentry);
 	exit2:
 		dput(dentry);
 	}
@@ -1893,6 +1925,9 @@
 		if (newnd.last.name[newnd.last.len])
 			goto exit4;
 	}
+	error = -EROFS;
+	if (MNT_IS_RDONLY(newnd.mnt))
+		goto exit4;
 	new_dentry = lookup_hash(&newnd.last, new_dir);
 	error = PTR_ERR(new_dentry);
 	if (IS_ERR(new_dentry))
diff -NurP --minimal linux-2.4.22-pre10/fs/namespace.c linux-2.4.22-pre10-bme0.01/fs/namespace.c
--- linux-2.4.22-pre10/fs/namespace.c	2003-06-13 16:51:37.000000000 +0200
+++ linux-2.4.22-pre10-bme0.01/fs/namespace.c	2003-08-04 23:50:16.000000000 +0200
@@ -226,7 +226,7 @@
 	free_page((unsigned long) path_buf);
 	seq_putc(m, ' ');
 	mangle(m, mnt->mnt_sb->s_type->name);
-	seq_puts(m, mnt->mnt_sb->s_flags & MS_RDONLY ? " ro" : " rw");
+	seq_puts(m, (MNT_IS_RDONLY(mnt) || mnt->mnt_sb->s_flags & MS_RDONLY) ? " ro" : " rw");
 	for (fs_infop = fs_info; fs_infop->flag; fs_infop++) {
 		if (mnt->mnt_sb->s_flags & fs_infop->flag)
 			seq_puts(m, fs_infop->str);
@@ -484,11 +484,13 @@
 /*
  * do loopback mount.
  */
-static int do_loopback(struct nameidata *nd, char *old_name, int recurse)
+static int do_loopback(struct nameidata *nd, char *old_name, unsigned long flags, int mnt_flags)
 {
 	struct nameidata old_nd;
 	struct vfsmount *mnt = NULL;
+	int recurse = flags & MS_REC;
 	int err = mount_is_safe(nd);
+
 	if (err)
 		return err;
 	if (!old_name || !*old_name)
@@ -515,6 +517,7 @@
 			spin_unlock(&dcache_lock);
 		} else
 			mntput(mnt);
+		mnt->mnt_flags = mnt_flags;
 	}
 
 	up_write(&current->namespace->sem);
@@ -716,6 +719,8 @@
 		return -EINVAL;
 
 	/* Separate the per-mountpoint flags */
+	if (flags & MS_RDONLY)
+		mnt_flags |= MNT_RDONLY;
 	if (flags & MS_NOSUID)
 		mnt_flags |= MNT_NOSUID;
 	if (flags & MS_NODEV)
@@ -733,7 +738,7 @@
 		retval = do_remount(&nd, flags & ~MS_REMOUNT, mnt_flags,
 				    data_page);
 	else if (flags & MS_BIND)
-		retval = do_loopback(&nd, dev_name, flags & MS_REC);
+		retval = do_loopback(&nd, dev_name, flags, mnt_flags);
 	else if (flags & MS_MOVE)
 		retval = do_move_mount(&nd, dev_name);
 	else
diff -NurP --minimal linux-2.4.22-pre10/include/linux/mount.h linux-2.4.22-pre10-bme0.01/include/linux/mount.h
--- linux-2.4.22-pre10/include/linux/mount.h	2001-10-05 22:05:55.000000000 +0200
+++ linux-2.4.22-pre10-bme0.01/include/linux/mount.h	2003-08-04 23:46:39.000000000 +0200
@@ -12,9 +12,10 @@
 #define _LINUX_MOUNT_H
 #ifdef __KERNEL__
 
-#define MNT_NOSUID	1
-#define MNT_NODEV	2
-#define MNT_NOEXEC	4
+#define MNT_RDONLY	1
+#define MNT_NOSUID	2
+#define MNT_NODEV	4
+#define MNT_NOEXEC	8
 
 struct vfsmount
 {
@@ -31,6 +32,8 @@
 	struct list_head mnt_list;
 };
 
+#define	MNT_IS_RDONLY(m)	((m)->mnt_flags & MNT_RDONLY)
+
 static inline struct vfsmount *mntget(struct vfsmount *mnt)
 {
 	if (mnt)

