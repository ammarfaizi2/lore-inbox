Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262238AbUCOD52 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 22:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbUCOD52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 22:57:28 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:51918 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262238AbUCOD4B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 22:56:01 -0500
Date: Mon, 15 Mar 2004 04:55:59 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Bind Mount Extensions 0.04 (linux-2.4.25)
Message-ID: <20040315035559.GC30948@MAIL.13thfloor.at>
Mail-Followup-To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	linux-kernel@vger.kernel.org
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
; this patch adds some functionality to the --bind
; type of vfs mounts.
;
; (C) 2003-2004 Herbert Pötzl <herbert@13thfloor.at>
;
; Changelog:  
;
;   0.01  - readonly bind mounts
;   0.02  - added ro truncate handling
;         - added ro (f)chown, (f)chmod handling
;   0.03  - added ro utime(s) handling
;         - added ro access and *_ioctl
;   0.04  - added noatime and nodiratime
;         - fixed bug in open_namei (exit)
;         - made autofs4 update_atime uncond
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

diff -NurpP --minimal linux-2.4.25/drivers/char/random.c linux-2.4.25-bme0.04/drivers/char/random.c
--- linux-2.4.25/drivers/char/random.c	2004-02-18 14:36:31.000000000 +0100
+++ linux-2.4.25-bme0.04/drivers/char/random.c	2004-03-10 12:18:35.000000000 +0100
@@ -1550,7 +1550,7 @@ random_read(struct file * file, char * b
 	 * If we gave the user some bytes, update the access time.
 	 */
 	if (count != 0) {
-		UPDATE_ATIME(file->f_dentry->d_inode);
+		UPDATE_ATIME(file->f_dentry->d_inode, file->f_vfsmnt);
 	}
 	
 	return (count ? count : retval);
diff -NurpP --minimal linux-2.4.25/fs/autofs4/root.c linux-2.4.25-bme0.04/fs/autofs4/root.c
--- linux-2.4.25/fs/autofs4/root.c	2003-08-25 13:44:43.000000000 +0200
+++ linux-2.4.25-bme0.04/fs/autofs4/root.c	2004-03-10 14:21:57.000000000 +0100
@@ -62,7 +62,8 @@ static void autofs4_update_usage(struct 
 		struct autofs_info *ino = autofs4_dentry_ino(dentry);
 
 		if (ino) {
-			update_atime(dentry->d_inode);
+			/* Al Viro said: unconditional */
+			update_atime(dentry->d_inode, 0);
 			ino->last_used = jiffies;
 		}
 	}
diff -NurpP --minimal linux-2.4.25/fs/bfs/dir.c linux-2.4.25-bme0.04/fs/bfs/dir.c
--- linux-2.4.25/fs/bfs/dir.c	2003-08-25 13:44:43.000000000 +0200
+++ linux-2.4.25-bme0.04/fs/bfs/dir.c	2004-03-10 12:18:35.000000000 +0100
@@ -61,7 +61,7 @@ static int bfs_readdir(struct file * f, 
 		brelse(bh);
 	}
 
-	UPDATE_ATIME(dir);
+	UPDATE_ATIME(dir, f->f_vfsmnt);
 	return 0;	
 }
 
diff -NurpP --minimal linux-2.4.25/fs/ext2/dir.c linux-2.4.25-bme0.04/fs/ext2/dir.c
--- linux-2.4.25/fs/ext2/dir.c	2002-11-29 00:53:15.000000000 +0100
+++ linux-2.4.25-bme0.04/fs/ext2/dir.c	2004-03-10 12:18:35.000000000 +0100
@@ -290,7 +290,7 @@ ext2_readdir (struct file * filp, void *
 done:
 	filp->f_pos = (n << PAGE_CACHE_SHIFT) | offset;
 	filp->f_version = inode->i_version;
-	UPDATE_ATIME(inode);
+	UPDATE_ATIME(inode, filp->f_vfsmnt);
 	return 0;
 }
 
diff -NurpP --minimal linux-2.4.25/fs/ext2/ioctl.c linux-2.4.25-bme0.04/fs/ext2/ioctl.c
--- linux-2.4.25/fs/ext2/ioctl.c	2003-06-13 16:51:37.000000000 +0200
+++ linux-2.4.25-bme0.04/fs/ext2/ioctl.c	2004-03-10 12:18:35.000000000 +0100
@@ -27,7 +27,7 @@ int ext2_ioctl (struct inode * inode, st
 	case EXT2_IOC_SETFLAGS: {
 		unsigned int oldflags;
 
-		if (IS_RDONLY(inode))
+		if (IS_RDONLY(inode) || MNT_IS_RDONLY(filp->f_vfsmnt))
 			return -EROFS;
 
 		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
@@ -63,7 +63,7 @@ int ext2_ioctl (struct inode * inode, st
 	case EXT2_IOC_SETVERSION:
 		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
 			return -EPERM;
-		if (IS_RDONLY(inode))
+		if (IS_RDONLY(inode) || MNT_IS_RDONLY(filp->f_vfsmnt))
 			return -EROFS;
 		if (get_user(inode->i_generation, (int *) arg))
 			return -EFAULT;	
diff -NurpP --minimal linux-2.4.25/fs/ext3/dir.c linux-2.4.25-bme0.04/fs/ext3/dir.c
--- linux-2.4.25/fs/ext3/dir.c	2001-11-09 23:25:04.000000000 +0100
+++ linux-2.4.25-bme0.04/fs/ext3/dir.c	2004-03-10 12:18:35.000000000 +0100
@@ -185,6 +185,6 @@ revalidate:
 		offset = 0;
 		brelse (bh);
 	}
-	UPDATE_ATIME(inode);
+	UPDATE_ATIME(inode, filp->f_vfsmnt);
 	return 0;
 }
diff -NurpP --minimal linux-2.4.25/fs/ext3/ioctl.c linux-2.4.25-bme0.04/fs/ext3/ioctl.c
--- linux-2.4.25/fs/ext3/ioctl.c	2003-06-13 16:51:37.000000000 +0200
+++ linux-2.4.25-bme0.04/fs/ext3/ioctl.c	2004-03-10 12:18:35.000000000 +0100
@@ -33,7 +33,7 @@ int ext3_ioctl (struct inode * inode, st
 		unsigned int oldflags;
 		unsigned int jflag;
 
-		if (IS_RDONLY(inode))
+		if (IS_RDONLY(inode) || MNT_IS_RDONLY(filp->f_vfsmnt))
 			return -EROFS;
 
 		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
@@ -106,7 +106,7 @@ flags_err:
 
 		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
 			return -EPERM;
-		if (IS_RDONLY(inode))
+		if (IS_RDONLY(inode) || MNT_IS_RDONLY(filp->f_vfsmnt))
 			return -EROFS;
 		if (get_user(generation, (int *) arg))
 			return -EFAULT;
diff -NurpP --minimal linux-2.4.25/fs/inode.c linux-2.4.25-bme0.04/fs/inode.c
--- linux-2.4.25/fs/inode.c	2004-02-18 14:36:31.000000000 +0100
+++ linux-2.4.25-bme0.04/fs/inode.c	2004-03-10 12:18:35.000000000 +0100
@@ -1354,15 +1354,16 @@ void __init inode_init(unsigned long mem
  *	as well as the "noatime" flag and inode specific "noatime" markers.
  */
  
-void update_atime (struct inode *inode)
+void update_atime (struct inode *inode, struct vfsmount *mnt)
 {
 	if (inode->i_atime == CURRENT_TIME)
 		return;
-	if (IS_NOATIME(inode))
+	if (IS_NOATIME(inode) || MNT_IS_NOATIME(mnt))
 		return;
-	if (IS_NODIRATIME(inode) && S_ISDIR(inode->i_mode)) 
+	if (S_ISDIR(inode->i_mode) &&
+		(IS_NODIRATIME(inode) || MNT_IS_NODIRATIME(mnt)))
 		return;
-	if (IS_RDONLY(inode)) 
+	if (IS_RDONLY(inode) || MNT_IS_RDONLY(mnt))
 		return;
 	inode->i_atime = CURRENT_TIME;
 	mark_inode_dirty_sync (inode);
diff -NurpP --minimal linux-2.4.25/fs/minix/dir.c linux-2.4.25-bme0.04/fs/minix/dir.c
--- linux-2.4.25/fs/minix/dir.c	2002-02-25 20:38:09.000000000 +0100
+++ linux-2.4.25-bme0.04/fs/minix/dir.c	2004-03-10 12:18:35.000000000 +0100
@@ -114,7 +114,7 @@ static int minix_readdir(struct file * f
 
 done:
 	filp->f_pos = (n << PAGE_CACHE_SHIFT) | offset;
-	UPDATE_ATIME(inode);
+	UPDATE_ATIME(inode, filp->f_vfsmnt);
 	return 0;
 }
 
diff -NurpP --minimal linux-2.4.25/fs/namei.c linux-2.4.25-bme0.04/fs/namei.c
--- linux-2.4.25/fs/namei.c	2003-08-25 13:44:43.000000000 +0200
+++ linux-2.4.25-bme0.04/fs/namei.c	2004-03-10 12:18:35.000000000 +0100
@@ -345,7 +345,7 @@ static inline int do_follow_link(struct 
 	}
 	current->link_count++;
 	current->total_link_count++;
-	UPDATE_ATIME(dentry->d_inode);
+	UPDATE_ATIME(dentry->d_inode, nd->mnt);
 	err = dentry->d_inode->i_op->follow_link(dentry, nd);
 	current->link_count--;
 	return err;
@@ -935,6 +935,24 @@ static inline int may_create(struct inod
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
@@ -1025,6 +1043,9 @@ int open_namei(const char * pathname, in
 	error = path_lookup(pathname, LOOKUP_PARENT, nd);
 	if (error)
 		return error;
+	error = -EROFS;
+	if (MNT_IS_RDONLY(nd->mnt))
+		goto exit;
 
 	/*
 	 * We have the parent and last component. First of all, check
@@ -1120,7 +1141,7 @@ ok:
 		flag &= ~O_TRUNC;
 	} else {
 		error = -EROFS;
-		if (IS_RDONLY(inode) && (flag & 2))
+		if ((flag & FMODE_WRITE) && (IS_RDONLY(inode) || MNT_IS_RDONLY(nd->mnt)))
 			goto exit;
 	}
 	/*
@@ -1184,7 +1205,7 @@ do_link:
 	 * stored in nd->last.name and we will have to putname() it when we
 	 * are done. Procfs-like symlinks just set LAST_BIND.
 	 */
-	UPDATE_ATIME(dentry->d_inode);
+	UPDATE_ATIME(dentry->d_inode, nd->mnt);
 	error = dentry->d_inode->i_op->follow_link(dentry, nd);
 	dput(dentry);
 	if (error)
@@ -1216,22 +1237,27 @@ do_link:
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
@@ -1457,7 +1483,11 @@ asmlinkage long sys_rmdir(const char * p
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
@@ -1519,7 +1549,9 @@ asmlinkage long sys_unlink(const char * 
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
@@ -1893,6 +1925,9 @@ static inline int do_rename(const char *
 		if (newnd.last.name[newnd.last.len])
 			goto exit4;
 	}
+	error = -EROFS;
+	if (MNT_IS_RDONLY(newnd.mnt))
+		goto exit4;
 	new_dentry = lookup_hash(&newnd.last, new_dir);
 	error = PTR_ERR(new_dentry);
 	if (IS_ERR(new_dentry))
diff -NurpP --minimal linux-2.4.25/fs/namespace.c linux-2.4.25-bme0.04/fs/namespace.c
--- linux-2.4.25/fs/namespace.c	2004-02-18 14:36:31.000000000 +0100
+++ linux-2.4.25-bme0.04/fs/namespace.c	2004-03-10 12:18:35.000000000 +0100
@@ -226,7 +226,7 @@ static int show_vfsmnt(struct seq_file *
 	free_page((unsigned long) path_buf);
 	seq_putc(m, ' ');
 	mangle(m, mnt->mnt_sb->s_type->name);
-	seq_puts(m, mnt->mnt_sb->s_flags & MS_RDONLY ? " ro" : " rw");
+	seq_puts(m, (MNT_IS_RDONLY(mnt) || mnt->mnt_sb->s_flags & MS_RDONLY) ? " ro" : " rw");
 	for (fs_infop = fs_info; fs_infop->flag; fs_infop++) {
 		if (mnt->mnt_sb->s_flags & fs_infop->flag)
 			seq_puts(m, fs_infop->str);
@@ -484,11 +484,13 @@ out_unlock:
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
@@ -515,6 +517,7 @@ static int do_loopback(struct nameidata 
 			spin_unlock(&dcache_lock);
 		} else
 			mntput(mnt);
+		mnt->mnt_flags = mnt_flags;
 	}
 
 	up_write(&current->namespace->sem);
@@ -719,12 +722,18 @@ long do_mount(char * dev_name, char * di
 		((char *)data_page)[PAGE_SIZE - 1] = 0;
 
 	/* Separate the per-mountpoint flags */
+	if (flags & MS_RDONLY)
+		mnt_flags |= MNT_RDONLY;
 	if (flags & MS_NOSUID)
 		mnt_flags |= MNT_NOSUID;
 	if (flags & MS_NODEV)
 		mnt_flags |= MNT_NODEV;
 	if (flags & MS_NOEXEC)
 		mnt_flags |= MNT_NOEXEC;
+	if (flags & MS_NOATIME)
+		mnt_flags |= MNT_NOATIME;
+	if (flags & MS_NODIRATIME)
+		mnt_flags |= MNT_NODIRATIME;
 	flags &= ~(MS_NOSUID|MS_NOEXEC|MS_NODEV);
 
 	/* ... and get the mountpoint */
@@ -736,7 +745,7 @@ long do_mount(char * dev_name, char * di
 		retval = do_remount(&nd, flags & ~MS_REMOUNT, mnt_flags,
 				    data_page);
 	else if (flags & MS_BIND)
-		retval = do_loopback(&nd, dev_name, flags & MS_REC);
+		retval = do_loopback(&nd, dev_name, flags, mnt_flags);
 	else if (flags & MS_MOVE)
 		retval = do_move_mount(&nd, dev_name);
 	else
diff -NurpP --minimal linux-2.4.25/fs/nfsd/vfs.c linux-2.4.25-bme0.04/fs/nfsd/vfs.c
--- linux-2.4.25/fs/nfsd/vfs.c	2003-11-28 19:26:21.000000000 +0100
+++ linux-2.4.25-bme0.04/fs/nfsd/vfs.c	2004-03-10 14:14:22.000000000 +0100
@@ -1088,7 +1088,7 @@ nfsd_readlink(struct svc_rqst *rqstp, st
 	if (!inode->i_op || !inode->i_op->readlink)
 		goto out;
 
-	UPDATE_ATIME(inode);
+	UPDATE_ATIME(inode, fhp->fh_export->ex_mnt);
 	/* N.B. Why does this call need a get_fs()??
 	 * Remove the set_fs and watch the fireworks:-) --okir
 	 */
diff -NurpP --minimal linux-2.4.25/fs/open.c linux-2.4.25-bme0.04/fs/open.c
--- linux-2.4.25/fs/open.c	2004-02-18 14:36:31.000000000 +0100
+++ linux-2.4.25-bme0.04/fs/open.c	2004-03-10 12:18:35.000000000 +0100
@@ -144,7 +144,7 @@ static inline long do_sys_truncate(const
 		goto dput_and_out;
 
 	error = -EROFS;
-	if (IS_RDONLY(inode))
+	if (IS_RDONLY(inode) || MNT_IS_RDONLY(nd.mnt))
 		goto dput_and_out;
 
 	error = -EPERM;
@@ -268,7 +268,7 @@ asmlinkage long sys_utime(char * filenam
 	inode = nd.dentry->d_inode;
 
 	error = -EROFS;
-	if (IS_RDONLY(inode))
+	if (IS_RDONLY(inode) || MNT_IS_RDONLY(nd.mnt))
 		goto dput_and_out;
 
 	/* Don't worry, the checks are done in inode_change_ok() */
@@ -319,7 +319,7 @@ asmlinkage long sys_utimes(char * filena
 	inode = nd.dentry->d_inode;
 
 	error = -EROFS;
-	if (IS_RDONLY(inode))
+	if (IS_RDONLY(inode) || MNT_IS_RDONLY(nd.mnt))
 		goto dput_and_out;
 
 	/* Don't worry, the checks are done in inode_change_ok() */
@@ -383,8 +383,9 @@ asmlinkage long sys_access(const char * 
 	if (!res) {
 		res = permission(nd.dentry->d_inode, mode);
 		/* SuS v2 requires we report a read only fs too */
-		if(!res && (mode & S_IWOTH) && IS_RDONLY(nd.dentry->d_inode)
-		   && !special_file(nd.dentry->d_inode->i_mode))
+		if (!res && (mode & S_IWOTH)
+		   && !special_file(nd.dentry->d_inode->i_mode)
+		   && (IS_RDONLY(nd.dentry->d_inode) || MNT_IS_RDONLY(nd.mnt)))
 			res = -EROFS;
 		path_release(&nd);
 	}
@@ -490,7 +491,7 @@ asmlinkage long sys_fchmod(unsigned int 
 	inode = dentry->d_inode;
 
 	err = -EROFS;
-	if (IS_RDONLY(inode))
+	if (IS_RDONLY(inode) || MNT_IS_RDONLY(file->f_vfsmnt))
 		goto out_putf;
 	err = -EPERM;
 	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
@@ -520,7 +521,7 @@ asmlinkage long sys_chmod(const char * f
 	inode = nd.dentry->d_inode;
 
 	error = -EROFS;
-	if (IS_RDONLY(inode))
+	if (IS_RDONLY(inode) || MNT_IS_RDONLY(nd.mnt))
 		goto dput_and_out;
 
 	error = -EPERM;
@@ -539,7 +540,7 @@ out:
 	return error;
 }
 
-static int chown_common(struct dentry * dentry, uid_t user, gid_t group)
+static int chown_common(struct vfsmount *mnt, struct dentry * dentry, uid_t user, gid_t group)
 {
 	struct inode * inode;
 	int error;
@@ -551,7 +552,7 @@ static int chown_common(struct dentry * 
 		goto out;
 	}
 	error = -EROFS;
-	if (IS_RDONLY(inode))
+	if (IS_RDONLY(inode) || MNT_IS_RDONLY(mnt))
 		goto out;
 	error = -EPERM;
 	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
@@ -606,7 +607,7 @@ asmlinkage long sys_chown(const char * f
 
 	error = user_path_walk(filename, &nd);
 	if (!error) {
-		error = chown_common(nd.dentry, user, group);
+		error = chown_common(nd.mnt, nd.dentry, user, group);
 		path_release(&nd);
 	}
 	return error;
@@ -619,7 +620,7 @@ asmlinkage long sys_lchown(const char * 
 
 	error = user_path_walk_link(filename, &nd);
 	if (!error) {
-		error = chown_common(nd.dentry, user, group);
+		error = chown_common(nd.mnt, nd.dentry, user, group);
 		path_release(&nd);
 	}
 	return error;
@@ -633,7 +634,7 @@ asmlinkage long sys_fchown(unsigned int 
 
 	file = fget(fd);
 	if (file) {
-		error = chown_common(file->f_dentry, user, group);
+		error = chown_common(file->f_vfsmnt, file->f_dentry, user, group);
 		fput(file);
 	}
 	return error;
diff -NurpP --minimal linux-2.4.25/fs/pipe.c linux-2.4.25-bme0.04/fs/pipe.c
--- linux-2.4.25/fs/pipe.c	2003-08-25 13:44:43.000000000 +0200
+++ linux-2.4.25-bme0.04/fs/pipe.c	2004-03-10 12:18:35.000000000 +0100
@@ -130,7 +130,7 @@ out_nolock:
 	if (read)
 		ret = read;
 
-	UPDATE_ATIME(inode);
+	UPDATE_ATIME(inode, filp->f_vfsmnt);
 	return ret;
 }
 
diff -NurpP --minimal linux-2.4.25/fs/qnx4/dir.c linux-2.4.25-bme0.04/fs/qnx4/dir.c
--- linux-2.4.25/fs/qnx4/dir.c	2002-02-25 20:38:09.000000000 +0100
+++ linux-2.4.25-bme0.04/fs/qnx4/dir.c	2004-03-10 12:18:35.000000000 +0100
@@ -73,7 +73,7 @@ static int qnx4_readdir(struct file *fil
 		}
 		brelse(bh);
 	}
-	UPDATE_ATIME(inode);
+	UPDATE_ATIME(inode, filp->f_vfsmnt);
 
 	return 0;
 }
diff -NurpP --minimal linux-2.4.25/fs/readdir.c linux-2.4.25-bme0.04/fs/readdir.c
--- linux-2.4.25/fs/readdir.c	2004-02-18 14:36:31.000000000 +0100
+++ linux-2.4.25-bme0.04/fs/readdir.c	2004-03-10 12:18:35.000000000 +0100
@@ -146,7 +146,7 @@ int dcache_readdir(struct file * filp, v
 			}
 			spin_unlock(&dcache_lock);
 	}
-	UPDATE_ATIME(dentry->d_inode);
+	UPDATE_ATIME(dentry->d_inode, filp->f_vfsmnt);
 	return 0;
 }
 
diff -NurpP --minimal linux-2.4.25/fs/reiserfs/dir.c linux-2.4.25-bme0.04/fs/reiserfs/dir.c
--- linux-2.4.25/fs/reiserfs/dir.c	2003-08-25 13:44:43.000000000 +0200
+++ linux-2.4.25-bme0.04/fs/reiserfs/dir.c	2004-03-10 12:18:35.000000000 +0100
@@ -181,7 +181,7 @@ static int reiserfs_readdir (struct file
     filp->f_pos = next_pos;
     pathrelse (&path_to_entry);
     reiserfs_check_path(&path_to_entry) ;
-    UPDATE_ATIME(inode) ;
+    UPDATE_ATIME(inode, filp->f_vfsmnt);
     return 0;
 }
 
diff -NurpP --minimal linux-2.4.25/fs/reiserfs/ioctl.c linux-2.4.25-bme0.04/fs/reiserfs/ioctl.c
--- linux-2.4.25/fs/reiserfs/ioctl.c	2003-11-28 19:26:21.000000000 +0100
+++ linux-2.4.25-bme0.04/fs/reiserfs/ioctl.c	2004-03-10 12:18:35.000000000 +0100
@@ -42,7 +42,7 @@ int reiserfs_ioctl (struct inode * inode
 		i_attrs_to_sd_attrs( inode, ( __u16 * ) &flags );
 		return put_user(flags, (int *) arg);
 	case REISERFS_IOC_SETFLAGS: {
-		if (IS_RDONLY(inode))
+		if (IS_RDONLY(inode) || MNT_IS_RDONLY(filp->f_vfsmnt))
 			return -EROFS;
 
 		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
@@ -74,7 +74,7 @@ int reiserfs_ioctl (struct inode * inode
 	case REISERFS_IOC_SETVERSION:
 		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
 			return -EPERM;
-		if (IS_RDONLY(inode))
+		if (IS_RDONLY(inode) || MNT_IS_RDONLY(filp->f_vfsmnt))
 			return -EROFS;
 		if (get_user(inode->i_generation, (int *) arg))
 			return -EFAULT;	
diff -NurpP --minimal linux-2.4.25/fs/stat.c linux-2.4.25-bme0.04/fs/stat.c
--- linux-2.4.25/fs/stat.c	2004-02-18 14:36:31.000000000 +0100
+++ linux-2.4.25-bme0.04/fs/stat.c	2004-03-10 12:18:35.000000000 +0100
@@ -260,7 +260,7 @@ asmlinkage long sys_readlink(const char 
 		error = -EINVAL;
 		if (inode->i_op && inode->i_op->readlink &&
 		    !(error = do_revalidate(nd.dentry))) {
-			UPDATE_ATIME(inode);
+			UPDATE_ATIME(inode, nd.mnt);
 			error = inode->i_op->readlink(nd.dentry, buf, bufsiz);
 		}
 		path_release(&nd);
diff -NurpP --minimal linux-2.4.25/fs/sysv/dir.c linux-2.4.25-bme0.04/fs/sysv/dir.c
--- linux-2.4.25/fs/sysv/dir.c	2002-02-25 20:38:09.000000000 +0100
+++ linux-2.4.25-bme0.04/fs/sysv/dir.c	2004-03-10 12:18:35.000000000 +0100
@@ -117,7 +117,7 @@ static int sysv_readdir(struct file * fi
 done:
 	filp->f_pos = (n << PAGE_CACHE_SHIFT) | offset;
 	filp->f_version = inode->i_version;
-	UPDATE_ATIME(inode);
+	UPDATE_ATIME(inode, filp->f_vfsmnt);
 	return 0;
 }
 
diff -NurpP --minimal linux-2.4.25/fs/udf/dir.c linux-2.4.25-bme0.04/fs/udf/dir.c
--- linux-2.4.25/fs/udf/dir.c	2002-08-03 02:39:45.000000000 +0200
+++ linux-2.4.25-bme0.04/fs/udf/dir.c	2004-03-10 12:18:35.000000000 +0100
@@ -91,7 +91,7 @@ int udf_readdir(struct file *filp, void 
 	}
  
 	result = do_udf_readdir(dir, filp, filldir, dirent);
-	UPDATE_ATIME(dir);
+	UPDATE_ATIME(dir, filp->f_vfsmnt);
  	return result;
 }
 
diff -NurpP --minimal linux-2.4.25/fs/ufs/dir.c linux-2.4.25-bme0.04/fs/ufs/dir.c
--- linux-2.4.25/fs/ufs/dir.c	2002-02-25 20:38:09.000000000 +0100
+++ linux-2.4.25-bme0.04/fs/ufs/dir.c	2004-03-10 12:18:35.000000000 +0100
@@ -160,7 +160,7 @@ revalidate:
 		offset = 0;
 		brelse (bh);
 	}
-	UPDATE_ATIME(inode);
+	UPDATE_ATIME(inode, filp->f_vfsmnt);
 	return 0;
 }
 
diff -NurpP --minimal linux-2.4.25/fs/xfs/linux/xfs_lrw.c linux-2.4.25-bme0.04/fs/xfs/linux/xfs_lrw.c
--- linux-2.4.25/fs/xfs/linux/xfs_lrw.c	2004-02-18 14:36:31.000000000 +0100
+++ linux-2.4.25-bme0.04/fs/xfs/linux/xfs_lrw.c	2004-03-10 12:18:35.000000000 +0100
@@ -323,7 +323,7 @@ xfs_read(
 
 	if (unlikely(ioflags & IO_ISDIRECT)) {
 		ret = do_generic_direct_read(file, buf, size, offset);
-		UPDATE_ATIME(file->f_dentry->d_inode);
+		UPDATE_ATIME(file->f_dentry->d_inode, file->f_vfsmnt);
 	} else {
 		ret = generic_file_read(file, buf, size, offset);
 	}
diff -NurpP --minimal linux-2.4.25/include/linux/fs.h linux-2.4.25-bme0.04/include/linux/fs.h
--- linux-2.4.25/include/linux/fs.h	2004-03-10 11:06:44.000000000 +0100
+++ linux-2.4.25-bme0.04/include/linux/fs.h	2004-03-10 14:28:50.000000000 +0100
@@ -200,9 +200,9 @@ extern int leases_enable, dir_notify_ena
 #include <asm/semaphore.h>
 #include <asm/byteorder.h>
 
-extern void update_atime (struct inode *);
+extern void update_atime (struct inode *, struct vfsmount *);
 extern void update_mctime (struct inode *);
-#define UPDATE_ATIME(inode) update_atime (inode)
+#define UPDATE_ATIME(inode, mnt) update_atime (inode, mnt)
 
 extern void buffer_init(unsigned long);
 extern void inode_init(unsigned long);
diff -NurpP --minimal linux-2.4.25/include/linux/mount.h linux-2.4.25-bme0.04/include/linux/mount.h
--- linux-2.4.25/include/linux/mount.h	2001-10-05 22:05:55.000000000 +0200
+++ linux-2.4.25-bme0.04/include/linux/mount.h	2004-03-10 12:18:35.000000000 +0100
@@ -12,9 +12,12 @@
 #define _LINUX_MOUNT_H
 #ifdef __KERNEL__
 
-#define MNT_NOSUID	1
-#define MNT_NODEV	2
-#define MNT_NOEXEC	4
+#define MNT_RDONLY	1
+#define MNT_NOSUID	2
+#define MNT_NODEV	4
+#define MNT_NOEXEC	8
+#define MNT_NOATIME	1024
+#define MNT_NODIRATIME	2048
 
 struct vfsmount
 {
@@ -31,6 +34,11 @@ struct vfsmount
 	struct list_head mnt_list;
 };
 
+				/* remove (m) with fixmes */
+#define	MNT_IS_RDONLY(m)	((m) && ((m)->mnt_flags & MNT_RDONLY))
+#define	MNT_IS_NOATIME(m)	((m) && ((m)->mnt_flags & MNT_NOATIME))
+#define	MNT_IS_NODIRATIME(m)	((m) && ((m)->mnt_flags & MNT_NODIRATIME))
+
 static inline struct vfsmount *mntget(struct vfsmount *mnt)
 {
 	if (mnt)
diff -NurpP --minimal linux-2.4.25/ipc/shm.c linux-2.4.25-bme0.04/ipc/shm.c
--- linux-2.4.25/ipc/shm.c	2002-08-03 02:39:46.000000000 +0200
+++ linux-2.4.25-bme0.04/ipc/shm.c	2004-03-10 12:18:35.000000000 +0100
@@ -159,7 +159,7 @@ static void shm_close (struct vm_area_st
 
 static int shm_mmap(struct file * file, struct vm_area_struct * vma)
 {
-	UPDATE_ATIME(file->f_dentry->d_inode);
+	UPDATE_ATIME(file->f_dentry->d_inode, file->f_vfsmnt);
 	vma->vm_ops = &shm_vm_ops;
 	shm_inc(file->f_dentry->d_inode->i_ino);
 	return 0;
diff -NurpP --minimal linux-2.4.25/mm/filemap.c linux-2.4.25-bme0.04/mm/filemap.c
--- linux-2.4.25/mm/filemap.c	2004-02-18 14:36:32.000000000 +0100
+++ linux-2.4.25-bme0.04/mm/filemap.c	2004-03-10 12:18:35.000000000 +0100
@@ -1613,7 +1613,7 @@ no_cached_page:
 	filp->f_reada = 1;
 	if (cached_page)
 		page_cache_release(cached_page);
-	UPDATE_ATIME(inode);
+	UPDATE_ATIME(inode, filp->f_vfsmnt);
 }
 
 static inline int have_mapping_directIO(struct address_space * mapping)
@@ -1809,7 +1809,7 @@ ssize_t generic_file_read(struct file * 
 			retval = do_generic_direct_read(filp, buf, count, ppos);
 		up(&inode->i_sem);
 		up_read(&inode->i_alloc_sem);
-		UPDATE_ATIME(filp->f_dentry->d_inode);
+		UPDATE_ATIME(filp->f_dentry->d_inode, filp->f_vfsmnt);
 		goto out;
 	}
 }
@@ -2324,7 +2324,7 @@ int generic_file_mmap(struct file * file
 	}
 	if (!mapping->a_ops->readpage)
 		return -ENOEXEC;
-	UPDATE_ATIME(inode);
+	UPDATE_ATIME(inode, file->f_vfsmnt);
 	vma->vm_ops = &generic_file_vm_ops;
 	return 0;
 }
diff -NurpP --minimal linux-2.4.25/mm/shmem.c linux-2.4.25-bme0.04/mm/shmem.c
--- linux-2.4.25/mm/shmem.c	2003-11-28 19:26:21.000000000 +0100
+++ linux-2.4.25-bme0.04/mm/shmem.c	2004-03-10 12:18:35.000000000 +0100
@@ -838,7 +838,7 @@ static int shmem_mmap(struct file *file,
 	ops = &shmem_vm_ops;
 	if (!S_ISREG(inode->i_mode))
 		return -EACCES;
-	UPDATE_ATIME(inode);
+	UPDATE_ATIME(inode, file->f_vfsmnt);
 	vma->vm_ops = ops;
 	return 0;
 }
@@ -1119,7 +1119,7 @@ static void do_shmem_file_read(struct fi
 
 	*ppos = ((loff_t) index << PAGE_CACHE_SHIFT) + offset;
 	filp->f_reada = 1;
-	UPDATE_ATIME(inode);
+	UPDATE_ATIME(inode, filp->f_vfsmnt);
 }
 
 static ssize_t shmem_file_read(struct file *filp, char *buf, size_t count, loff_t *ppos)
diff -NurpP --minimal linux-2.4.25/net/unix/af_unix.c linux-2.4.25-bme0.04/net/unix/af_unix.c
--- linux-2.4.25/net/unix/af_unix.c	2002-11-29 00:53:16.000000000 +0100
+++ linux-2.4.25-bme0.04/net/unix/af_unix.c	2004-03-10 12:18:35.000000000 +0100
@@ -607,7 +607,7 @@ static unix_socket *unix_find_other(stru
 			goto put_fail;
 
 		if (u->type == type)
-			UPDATE_ATIME(nd.dentry->d_inode);
+			UPDATE_ATIME(nd.dentry->d_inode, nd.mnt);
 
 		path_release(&nd);
 
@@ -623,7 +623,7 @@ static unix_socket *unix_find_other(stru
 			struct dentry *dentry;
 			dentry = u->protinfo.af_unix.dentry;
 			if (dentry)
-				UPDATE_ATIME(dentry->d_inode);
+				UPDATE_ATIME(dentry->d_inode, nd.mnt);
 		} else
 			goto fail;
 	}
