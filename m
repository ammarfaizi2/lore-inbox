Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275061AbTHGDDy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 23:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275086AbTHGDDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 23:03:54 -0400
Received: from www.13thfloor.AT ([212.16.59.250]:37282 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S275061AbTHGDDY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 23:03:24 -0400
Date: Thu, 7 Aug 2003 05:03:31 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Bind Mount Extensions 0.02 for 2.6.x
Message-ID: <20030807030331.GA18518@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I thought, maybe this would be useful for 2.6 too,
so here is a preliminary patch for 2.6.0-test2 ...

I would be happy to hear about any misbehaviour
(read: difference in behaviour regarding a 'normal'
read only mounted filesystem ...)

patch is for 2.6.0-test2 but should apply and
work for all available 2.6.0 including -bkx ...

enjoy,
Herbert

---------------

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
;   0.02  - correct ro truncate handling
;	  - correct ro (f)chown, (f)chmod handling
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

diff -NurP --minimal linux-2.6.0-test2/fs/namei.c linux-2.6.0-test2-bme0.02/fs/namei.c
--- linux-2.6.0-test2/fs/namei.c	2003-07-14 05:32:42.000000000 +0200
+++ linux-2.6.0-test2-bme0.02/fs/namei.c	2003-08-07 03:39:39.000000000 +0200
@@ -207,10 +207,14 @@
 {
 	int retval;
 	int submask;
+	umode_t	mode = inode->i_mode;
 
 	/* Ordinary permission routines do not understand MAY_APPEND. */
 	submask = mask & ~MAY_APPEND;
 
+	if (nd && (mask & MAY_WRITE) && MNT_IS_RDONLY(nd->mnt) &&
+		(S_ISREG(mode) || S_ISDIR(mode) || S_ISLNK(mode)))
+		return -EROFS;
 	if (inode->i_op && inode->i_op->permission)
 		retval = inode->i_op->permission(inode, submask, nd);
 	else
@@ -1039,6 +1043,24 @@
 	return permission(dir,MAY_WRITE | MAY_EXEC, nd);
 }
 
+static inline int mnt_may_create(struct vfsmount *mnt, struct inode *dir, struct dentry *child) {
+       if (child->d_inode)
+               return -EEXIST;
+       if (IS_DEADDIR(dir))
+               return -ENOENT;
+       if (mnt->mnt_flags & MNT_RDONLY)
+               return -EROFS;
+       return 0;
+}
+
+static inline int mnt_may_unlink(struct vfsmount *mnt, struct inode *dir, struct dentry *child) {
+       if (!child->d_inode)
+               return -ENOENT;
+       if (mnt->mnt_flags & MNT_RDONLY)
+               return -EROFS;
+       return 0;
+}
+
 /* 
  * Special case: O_CREAT|O_EXCL implies O_NOFOLLOW for security
  * reasons.
@@ -1160,7 +1182,8 @@
 			return -EACCES;
 
 		flag &= ~O_TRUNC;
-	} else if (IS_RDONLY(inode) && (flag & FMODE_WRITE))
+	} else if ((IS_RDONLY(inode) || MNT_IS_RDONLY(nd->mnt)) &&
+		(flag & FMODE_WRITE))
 		return -EROFS;
 	/*
 	 * An append-only file must be opened in append mode for writing.
@@ -1379,23 +1402,28 @@
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
@@ -1620,7 +1648,11 @@
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
@@ -1692,6 +1724,9 @@
 		/* Why not before? Because we want correct error value */
 		if (nd.last.name[nd.last.len])
 			goto slashes;
+		error = mnt_may_unlink(nd.mnt, nd.dentry->d_inode, dentry);
+		if (error)
+			goto exit2;
 		inode = dentry->d_inode;
 		if (inode)
 			atomic_inc(&inode->i_count);
@@ -2056,6 +2091,9 @@
 	error = -EINVAL;
 	if (old_dentry == trap)
 		goto exit4;
+	error = -EROFS;
+	if (MNT_IS_RDONLY(newnd.mnt))
+		goto exit4;
 	new_dentry = lookup_hash(&newnd.last, new_dir);
 	error = PTR_ERR(new_dentry);
 	if (IS_ERR(new_dentry))
diff -NurP --minimal linux-2.6.0-test2/fs/namespace.c linux-2.6.0-test2-bme0.02/fs/namespace.c
--- linux-2.6.0-test2/fs/namespace.c	2003-07-29 01:58:01.000000000 +0200
+++ linux-2.6.0-test2-bme0.02/fs/namespace.c	2003-08-07 03:45:02.000000000 +0200
@@ -225,7 +225,8 @@
 	seq_path(m, mnt, mnt->mnt_root, " \t\n\\");
 	seq_putc(m, ' ');
 	mangle(m, mnt->mnt_sb->s_type->name);
-	seq_puts(m, mnt->mnt_sb->s_flags & MS_RDONLY ? " ro" : " rw");
+	seq_puts(m, (MNT_IS_RDONLY(mnt) ||
+		(mnt->mnt_sb->s_flags & MS_RDONLY)) ? " ro" : " rw");
 	for (fs_infop = fs_info; fs_infop->flag; fs_infop++) {
 		if (mnt->mnt_sb->s_flags & fs_infop->flag)
 			seq_puts(m, fs_infop->str);
@@ -516,11 +517,13 @@
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
@@ -547,6 +550,7 @@
 			spin_unlock(&vfsmount_lock);
 		} else
 			mntput(mnt);
+		mnt->mnt_flags = mnt_flags;
 	}
 
 	up_write(&current->namespace->sem);
@@ -750,6 +754,8 @@
 		return -EINVAL;
 
 	/* Separate the per-mountpoint flags */
+	if (flags & MS_RDONLY)
+		mnt_flags |= MNT_RDONLY;
 	if (flags & MS_NOSUID)
 		mnt_flags |= MNT_NOSUID;
 	if (flags & MS_NODEV)
@@ -771,7 +777,7 @@
 		retval = do_remount(&nd, flags & ~MS_REMOUNT, mnt_flags,
 				    data_page);
 	else if (flags & MS_BIND)
-		retval = do_loopback(&nd, dev_name, flags & MS_REC);
+		retval = do_loopback(&nd, dev_name, flags, mnt_flags);
 	else if (flags & MS_MOVE)
 		retval = do_move_mount(&nd, dev_name);
 	else
diff -NurP --minimal linux-2.6.0-test2/fs/open.c linux-2.6.0-test2-bme0.02/fs/open.c
--- linux-2.6.0-test2/fs/open.c	2003-07-14 05:29:30.000000000 +0200
+++ linux-2.6.0-test2-bme0.02/fs/open.c	2003-08-07 02:50:42.000000000 +0200
@@ -224,7 +224,7 @@
 		goto dput_and_out;
 
 	error = -EROFS;
-	if (IS_RDONLY(inode))
+	if (IS_RDONLY(inode) || MNT_IS_RDONLY(nd.mnt))
 		goto dput_and_out;
 
 	error = -EPERM;
@@ -348,7 +348,7 @@
 	inode = nd.dentry->d_inode;
 
 	error = -EROFS;
-	if (IS_RDONLY(inode))
+	if (IS_RDONLY(inode) || MNT_IS_RDONLY(nd.mnt))
 		goto dput_and_out;
 
 	/* Don't worry, the checks are done in inode_change_ok() */
@@ -397,7 +397,7 @@
 	inode = nd.dentry->d_inode;
 
 	error = -EROFS;
-	if (IS_RDONLY(inode))
+	if (IS_RDONLY(inode) || MNT_IS_RDONLY(nd.mnt))
 		goto dput_and_out;
 
 	/* Don't worry, the checks are done in inode_change_ok() */
@@ -577,7 +577,7 @@
 	inode = dentry->d_inode;
 
 	err = -EROFS;
-	if (IS_RDONLY(inode))
+	if (IS_RDONLY(inode) || MNT_IS_RDONLY(file->f_vfsmnt))
 		goto out_putf;
 	err = -EPERM;
 	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
@@ -609,7 +609,7 @@
 	inode = nd.dentry->d_inode;
 
 	error = -EROFS;
-	if (IS_RDONLY(inode))
+	if (IS_RDONLY(inode) || MNT_IS_RDONLY(nd.mnt))
 		goto dput_and_out;
 
 	error = -EPERM;
@@ -630,7 +630,7 @@
 	return error;
 }
 
-static int chown_common(struct dentry * dentry, uid_t user, gid_t group)
+static int chown_common(struct vfsmount *mnt, struct dentry * dentry, uid_t user, gid_t group)
 {
 	struct inode * inode;
 	int error;
@@ -642,7 +642,7 @@
 		goto out;
 	}
 	error = -EROFS;
-	if (IS_RDONLY(inode))
+	if (IS_RDONLY(inode) || MNT_IS_RDONLY(mnt))
 		goto out;
 	error = -EPERM;
 	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
@@ -672,7 +672,7 @@
 
 	error = user_path_walk(filename, &nd);
 	if (!error) {
-		error = chown_common(nd.dentry, user, group);
+		error = chown_common(nd.mnt, nd.dentry, user, group);
 		path_release(&nd);
 	}
 	return error;
@@ -685,7 +685,7 @@
 
 	error = user_path_walk_link(filename, &nd);
 	if (!error) {
-		error = chown_common(nd.dentry, user, group);
+		error = chown_common(nd.mnt, nd.dentry, user, group);
 		path_release(&nd);
 	}
 	return error;
@@ -699,7 +699,7 @@
 
 	file = fget(fd);
 	if (file) {
-		error = chown_common(file->f_dentry, user, group);
+		error = chown_common(file->f_vfsmnt, file->f_dentry, user, group);
 		fput(file);
 	}
 	return error;
diff -NurP --minimal linux-2.6.0-test2/include/linux/mount.h linux-2.6.0-test2-bme0.02/include/linux/mount.h
--- linux-2.6.0-test2/include/linux/mount.h	2003-07-14 05:30:35.000000000 +0200
+++ linux-2.6.0-test2-bme0.02/include/linux/mount.h	2003-08-07 02:50:24.000000000 +0200
@@ -14,9 +14,10 @@
 
 #include <linux/list.h>
 
-#define MNT_NOSUID	1
-#define MNT_NODEV	2
-#define MNT_NOEXEC	4
+#define MNT_RDONLY	1
+#define MNT_NOSUID	2
+#define MNT_NODEV	4
+#define MNT_NOEXEC	8
 
 struct vfsmount
 {
@@ -33,6 +34,8 @@
 	struct list_head mnt_list;
 };
 
+#define	MNT_IS_RDONLY(m)	((m)->mnt_flags & MNT_RDONLY)
+
 static inline struct vfsmount *mntget(struct vfsmount *mnt)
 {
 	if (mnt)

