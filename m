Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262235AbUCOD4C (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 22:56:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbUCOD4C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 22:56:02 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:51150 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262235AbUCODzJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 22:55:09 -0500
Date: Mon, 15 Mar 2004 04:55:07 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Bind Mount Extensions 0.04 (linux-2.6.4)
Message-ID: <20040315035506.GB30948@MAIL.13thfloor.at>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>,
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

diff -NurpP --minimal linux-2.6.4/drivers/char/random.c linux-2.6.4-bme0.04/drivers/char/random.c
--- linux-2.6.4/drivers/char/random.c	2004-03-11 03:55:22.000000000 +0100
+++ linux-2.6.4-bme0.04/drivers/char/random.c	2004-03-12 20:51:58.000000000 +0100
@@ -1641,7 +1641,7 @@ random_read(struct file * file, char * b
 	 * If we gave the user some bytes, update the access time.
 	 */
 	if (count != 0) {
-		update_atime(file->f_dentry->d_inode);
+		update_atime(file->f_dentry->d_inode, file->f_vfsmnt);
 	}
 	
 	return (count ? count : retval);
diff -NurpP --minimal linux-2.6.4/fs/autofs4/root.c linux-2.6.4-bme0.04/fs/autofs4/root.c
--- linux-2.6.4/fs/autofs4/root.c	2004-03-11 03:55:21.000000000 +0100
+++ linux-2.6.4-bme0.04/fs/autofs4/root.c	2004-03-12 20:51:58.000000000 +0100
@@ -61,7 +61,8 @@ static void autofs4_update_usage(struct 
 		struct autofs_info *ino = autofs4_dentry_ino(dentry);
 
 		if (ino) {
-			update_atime(dentry->d_inode);
+			/* Al Viro said: unconditional */
+			update_atime(dentry->d_inode, 0);
 			ino->last_used = jiffies;
 		}
 	}
diff -NurpP --minimal linux-2.6.4/fs/bfs/dir.c linux-2.6.4-bme0.04/fs/bfs/dir.c
--- linux-2.6.4/fs/bfs/dir.c	2004-03-11 03:55:44.000000000 +0100
+++ linux-2.6.4-bme0.04/fs/bfs/dir.c	2004-03-12 20:51:58.000000000 +0100
@@ -65,7 +65,7 @@ static int bfs_readdir(struct file * f, 
 		brelse(bh);
 	}
 
-	update_atime(dir);
+	update_atime(dir, f->f_vfsmnt);
 	unlock_kernel();
 	return 0;	
 }
diff -NurpP --minimal linux-2.6.4/fs/ext2/dir.c linux-2.6.4-bme0.04/fs/ext2/dir.c
--- linux-2.6.4/fs/ext2/dir.c	2004-03-11 03:55:28.000000000 +0100
+++ linux-2.6.4-bme0.04/fs/ext2/dir.c	2004-03-12 20:51:58.000000000 +0100
@@ -310,7 +310,7 @@ ext2_readdir (struct file * filp, void *
 done:
 	filp->f_pos = (n << PAGE_CACHE_SHIFT) | offset;
 	filp->f_version = inode->i_version;
-	update_atime(inode);
+	update_atime(inode, filp->f_vfsmnt);
 	return 0;
 }
 
diff -NurpP --minimal linux-2.6.4/fs/ext2/ioctl.c linux-2.6.4-bme0.04/fs/ext2/ioctl.c
--- linux-2.6.4/fs/ext2/ioctl.c	2004-03-11 03:55:54.000000000 +0100
+++ linux-2.6.4-bme0.04/fs/ext2/ioctl.c	2004-03-12 20:51:58.000000000 +0100
@@ -10,6 +10,7 @@
 #include "ext2.h"
 #include <linux/time.h>
 #include <linux/sched.h>
+#include <linux/mount.h>
 #include <asm/current.h>
 #include <asm/uaccess.h>
 
@@ -29,7 +30,7 @@ int ext2_ioctl (struct inode * inode, st
 	case EXT2_IOC_SETFLAGS: {
 		unsigned int oldflags;
 
-		if (IS_RDONLY(inode))
+		if (IS_RDONLY(inode) || MNT_IS_RDONLY(filp->f_vfsmnt))
 			return -EROFS;
 
 		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
@@ -68,7 +69,7 @@ int ext2_ioctl (struct inode * inode, st
 	case EXT2_IOC_SETVERSION:
 		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
 			return -EPERM;
-		if (IS_RDONLY(inode))
+		if (IS_RDONLY(inode) || MNT_IS_RDONLY(filp->f_vfsmnt))
 			return -EROFS;
 		if (get_user(inode->i_generation, (int *) arg))
 			return -EFAULT;	
diff -NurpP --minimal linux-2.6.4/fs/ext3/dir.c linux-2.6.4-bme0.04/fs/ext3/dir.c
--- linux-2.6.4/fs/ext3/dir.c	2004-03-11 03:55:28.000000000 +0100
+++ linux-2.6.4-bme0.04/fs/ext3/dir.c	2004-03-12 20:51:58.000000000 +0100
@@ -224,7 +224,7 @@ revalidate:
 		offset = 0;
 		brelse (bh);
 	}
-       update_atime(inode);
+	update_atime(inode, filp->f_vfsmnt);
 out:
 	return ret;
 }
@@ -506,7 +506,7 @@ static int ext3_dx_readdir(struct file *
 	}
 finished:
 	info->last_pos = filp->f_pos;
-	update_atime(inode);
+	update_atime(inode, filp->f_vfsmnt);
 	return 0;
 }
 
diff -NurpP --minimal linux-2.6.4/fs/ext3/ioctl.c linux-2.6.4-bme0.04/fs/ext3/ioctl.c
--- linux-2.6.4/fs/ext3/ioctl.c	2004-03-11 03:55:26.000000000 +0100
+++ linux-2.6.4-bme0.04/fs/ext3/ioctl.c	2004-03-12 20:51:58.000000000 +0100
@@ -12,6 +12,7 @@
 #include <linux/ext3_fs.h>
 #include <linux/ext3_jbd.h>
 #include <linux/time.h>
+#include <linux/mount.h>
 #include <asm/uaccess.h>
 
 
@@ -34,7 +35,7 @@ int ext3_ioctl (struct inode * inode, st
 		unsigned int oldflags;
 		unsigned int jflag;
 
-		if (IS_RDONLY(inode))
+		if (IS_RDONLY(inode) || MNT_IS_RDONLY(filp->f_vfsmnt))
 			return -EROFS;
 
 		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
@@ -110,7 +111,7 @@ flags_err:
 
 		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
 			return -EPERM;
-		if (IS_RDONLY(inode))
+		if (IS_RDONLY(inode) || MNT_IS_RDONLY(filp->f_vfsmnt))
 			return -EROFS;
 		if (get_user(generation, (int *) arg))
 			return -EFAULT;
diff -NurpP --minimal linux-2.6.4/fs/hugetlbfs/inode.c linux-2.6.4-bme0.04/fs/hugetlbfs/inode.c
--- linux-2.6.4/fs/hugetlbfs/inode.c	2004-03-11 03:55:44.000000000 +0100
+++ linux-2.6.4-bme0.04/fs/hugetlbfs/inode.c	2004-03-12 20:51:58.000000000 +0100
@@ -62,7 +62,7 @@ static int hugetlbfs_file_mmap(struct fi
 	vma_len = (loff_t)(vma->vm_end - vma->vm_start);
 
 	down(&inode->i_sem);
-	update_atime(inode);
+	update_atime(inode, file->f_vfsmnt);
 	vma->vm_flags |= VM_HUGETLB | VM_RESERVED;
 	vma->vm_ops = &hugetlb_vm_ops;
 	ret = hugetlb_prefault(mapping, vma);
diff -NurpP --minimal linux-2.6.4/fs/inode.c linux-2.6.4-bme0.04/fs/inode.c
--- linux-2.6.4/fs/inode.c	2004-03-11 03:55:51.000000000 +0100
+++ linux-2.6.4-bme0.04/fs/inode.c	2004-03-12 20:51:58.000000000 +0100
@@ -20,6 +20,7 @@
 #include <linux/security.h>
 #include <linux/pagemap.h>
 #include <linux/cdev.h>
+#include <linux/mount.h>
 
 /*
  * This is needed for the following functions:
@@ -1141,15 +1142,16 @@ static int inode_times_differ(struct ino
  *	This function automatically handles read only file systems and media,
  *	as well as the "noatime" flag and inode specific "noatime" markers.
  */
-void update_atime(struct inode *inode)
+void update_atime(struct inode *inode, struct vfsmount *mnt)
 {
 	struct timespec now;
 
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
 
 	now = current_kernel_time();
diff -NurpP --minimal linux-2.6.4/fs/libfs.c linux-2.6.4-bme0.04/fs/libfs.c
--- linux-2.6.4/fs/libfs.c	2004-03-11 03:55:21.000000000 +0100
+++ linux-2.6.4-bme0.04/fs/libfs.c	2004-03-12 20:51:58.000000000 +0100
@@ -155,7 +155,7 @@ int dcache_readdir(struct file * filp, v
 			}
 			spin_unlock(&dcache_lock);
 	}
-	update_atime(dentry->d_inode);
+	update_atime(dentry->d_inode, filp->f_vfsmnt);
 	return 0;
 }
 
diff -NurpP --minimal linux-2.6.4/fs/minix/dir.c linux-2.6.4-bme0.04/fs/minix/dir.c
--- linux-2.6.4/fs/minix/dir.c	2004-03-11 03:55:37.000000000 +0100
+++ linux-2.6.4-bme0.04/fs/minix/dir.c	2004-03-12 20:51:58.000000000 +0100
@@ -127,7 +127,7 @@ static int minix_readdir(struct file * f
 
 done:
 	filp->f_pos = (n << PAGE_CACHE_SHIFT) | offset;
-	update_atime(inode);
+	update_atime(inode, filp->f_vfsmnt);
 	unlock_kernel();
 	return 0;
 }
diff -NurpP --minimal linux-2.6.4/fs/namei.c linux-2.6.4-bme0.04/fs/namei.c
--- linux-2.6.4/fs/namei.c	2004-03-11 03:55:25.000000000 +0100
+++ linux-2.6.4-bme0.04/fs/namei.c	2004-03-12 20:51:58.000000000 +0100
@@ -209,10 +209,14 @@ int permission(struct inode * inode,int 
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
@@ -412,7 +416,7 @@ static inline int do_follow_link(struct 
 		goto loop;
 	current->link_count++;
 	current->total_link_count++;
-	update_atime(dentry->d_inode);
+	update_atime(dentry->d_inode, nd->mnt);
 	err = dentry->d_inode->i_op->follow_link(dentry, nd);
 	current->link_count--;
 	return err;
@@ -1062,6 +1066,24 @@ static inline int may_create(struct inod
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
@@ -1183,7 +1205,8 @@ int may_open(struct nameidata *nd, int a
 			return -EACCES;
 
 		flag &= ~O_TRUNC;
-	} else if (IS_RDONLY(inode) && (flag & FMODE_WRITE))
+	} else if ((IS_RDONLY(inode) || MNT_IS_RDONLY(nd->mnt)) &&
+		(flag & FMODE_WRITE))
 		return -EROFS;
 	/*
 	 * An append-only file must be opened in append mode for writing.
@@ -1368,7 +1391,7 @@ do_link:
 	error = security_inode_follow_link(dentry, nd);
 	if (error)
 		goto exit_dput;
-	update_atime(dentry->d_inode);
+	update_atime(dentry->d_inode, nd->mnt);
 	error = dentry->d_inode->i_op->follow_link(dentry, nd);
 	dput(dentry);
 	if (error)
@@ -1408,23 +1431,28 @@ do_link:
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
@@ -1653,7 +1681,11 @@ asmlinkage long sys_rmdir(const char __u
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
@@ -1725,6 +1757,9 @@ asmlinkage long sys_unlink(const char __
 		/* Why not before? Because we want correct error value */
 		if (nd.last.name[nd.last.len])
 			goto slashes;
+		error = mnt_may_unlink(nd.mnt, nd.dentry->d_inode, dentry);
+		if (error)
+			goto exit2;
 		inode = dentry->d_inode;
 		if (inode)
 			atomic_inc(&inode->i_count);
@@ -2089,6 +2124,9 @@ static inline int do_rename(const char *
 	error = -EINVAL;
 	if (old_dentry == trap)
 		goto exit4;
+	error = -EROFS;
+	if (MNT_IS_RDONLY(newnd.mnt))
+		goto exit4;
 	new_dentry = lookup_hash(&newnd.last, new_dir);
 	error = PTR_ERR(new_dentry);
 	if (IS_ERR(new_dentry))
diff -NurpP --minimal linux-2.6.4/fs/namespace.c linux-2.6.4-bme0.04/fs/namespace.c
--- linux-2.6.4/fs/namespace.c	2004-03-11 03:55:35.000000000 +0100
+++ linux-2.6.4-bme0.04/fs/namespace.c	2004-03-12 20:51:58.000000000 +0100
@@ -229,7 +229,8 @@ static int show_vfsmnt(struct seq_file *
 	seq_path(m, mnt, mnt->mnt_root, " \t\n\\");
 	seq_putc(m, ' ');
 	mangle(m, mnt->mnt_sb->s_type->name);
-	seq_puts(m, mnt->mnt_sb->s_flags & MS_RDONLY ? " ro" : " rw");
+	seq_puts(m, (MNT_IS_RDONLY(mnt) ||
+		(mnt->mnt_sb->s_flags & MS_RDONLY)) ? " ro" : " rw");
 	for (fs_infop = fs_info; fs_infop->flag; fs_infop++) {
 		if (mnt->mnt_sb->s_flags & fs_infop->flag)
 			seq_puts(m, fs_infop->str);
@@ -522,11 +523,13 @@ out_unlock:
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
@@ -553,6 +556,7 @@ static int do_loopback(struct nameidata 
 			spin_unlock(&vfsmount_lock);
 		} else
 			mntput(mnt);
+		mnt->mnt_flags = mnt_flags;
 	}
 
 	up_write(&current->namespace->sem);
@@ -759,12 +763,18 @@ long do_mount(char * dev_name, char * di
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
@@ -780,7 +790,7 @@ long do_mount(char * dev_name, char * di
 		retval = do_remount(&nd, flags & ~MS_REMOUNT, mnt_flags,
 				    data_page);
 	else if (flags & MS_BIND)
-		retval = do_loopback(&nd, dev_name, flags & MS_REC);
+		retval = do_loopback(&nd, dev_name, flags, mnt_flags);
 	else if (flags & MS_MOVE)
 		retval = do_move_mount(&nd, dev_name);
 	else
diff -NurpP --minimal linux-2.6.4/fs/nfsd/vfs.c linux-2.6.4-bme0.04/fs/nfsd/vfs.c
--- linux-2.6.4/fs/nfsd/vfs.c	2004-03-11 03:55:26.000000000 +0100
+++ linux-2.6.4-bme0.04/fs/nfsd/vfs.c	2004-03-12 20:51:58.000000000 +0100
@@ -1143,7 +1143,7 @@ nfsd_readlink(struct svc_rqst *rqstp, st
 	if (!inode->i_op || !inode->i_op->readlink)
 		goto out;
 
-	update_atime(inode);
+	update_atime(inode, fhp->fh_export->ex_mnt);
 	/* N.B. Why does this call need a get_fs()??
 	 * Remove the set_fs and watch the fireworks:-) --okir
 	 */
diff -NurpP --minimal linux-2.6.4/fs/open.c linux-2.6.4-bme0.04/fs/open.c
--- linux-2.6.4/fs/open.c	2004-03-11 03:55:21.000000000 +0100
+++ linux-2.6.4-bme0.04/fs/open.c	2004-03-12 20:51:58.000000000 +0100
@@ -226,7 +226,7 @@ static inline long do_sys_truncate(const
 		goto dput_and_out;
 
 	error = -EROFS;
-	if (IS_RDONLY(inode))
+	if (IS_RDONLY(inode) || MNT_IS_RDONLY(nd.mnt))
 		goto dput_and_out;
 
 	error = -EPERM;
@@ -350,7 +350,7 @@ asmlinkage long sys_utime(char __user * 
 	inode = nd.dentry->d_inode;
 
 	error = -EROFS;
-	if (IS_RDONLY(inode))
+	if (IS_RDONLY(inode) || MNT_IS_RDONLY(nd.mnt))
 		goto dput_and_out;
 
 	/* Don't worry, the checks are done in inode_change_ok() */
@@ -407,7 +407,7 @@ long do_utimes(char __user * filename, s
 	inode = nd.dentry->d_inode;
 
 	error = -EROFS;
-	if (IS_RDONLY(inode))
+	if (IS_RDONLY(inode) || MNT_IS_RDONLY(nd.mnt))
 		goto dput_and_out;
 
 	/* Don't worry, the checks are done in inode_change_ok() */
@@ -489,8 +489,9 @@ asmlinkage long sys_access(const char __
 	if (!res) {
 		res = permission(nd.dentry->d_inode, mode, &nd);
 		/* SuS v2 requires we report a read only fs too */
-		if(!res && (mode & S_IWOTH) && IS_RDONLY(nd.dentry->d_inode)
-		   && !special_file(nd.dentry->d_inode->i_mode))
+		if (!res && (mode & S_IWOTH)
+		   && !special_file(nd.dentry->d_inode->i_mode)
+		   && (IS_RDONLY(nd.dentry->d_inode) || MNT_IS_RDONLY(nd.mnt)))
 			res = -EROFS;
 		path_release(&nd);
 	}
@@ -595,7 +596,7 @@ asmlinkage long sys_fchmod(unsigned int 
 	inode = dentry->d_inode;
 
 	err = -EROFS;
-	if (IS_RDONLY(inode))
+	if (IS_RDONLY(inode) || MNT_IS_RDONLY(file->f_vfsmnt))
 		goto out_putf;
 	err = -EPERM;
 	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
@@ -627,7 +628,7 @@ asmlinkage long sys_chmod(const char __u
 	inode = nd.dentry->d_inode;
 
 	error = -EROFS;
-	if (IS_RDONLY(inode))
+	if (IS_RDONLY(inode) || MNT_IS_RDONLY(nd.mnt))
 		goto dput_and_out;
 
 	error = -EPERM;
@@ -648,7 +649,7 @@ out:
 	return error;
 }
 
-static int chown_common(struct dentry * dentry, uid_t user, gid_t group)
+static int chown_common(struct vfsmount *mnt, struct dentry * dentry, uid_t user, gid_t group)
 {
 	struct inode * inode;
 	int error;
@@ -660,7 +661,7 @@ static int chown_common(struct dentry * 
 		goto out;
 	}
 	error = -EROFS;
-	if (IS_RDONLY(inode))
+	if (IS_RDONLY(inode) || MNT_IS_RDONLY(mnt))
 		goto out;
 	error = -EPERM;
 	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
@@ -690,7 +691,7 @@ asmlinkage long sys_chown(const char __u
 
 	error = user_path_walk(filename, &nd);
 	if (!error) {
-		error = chown_common(nd.dentry, user, group);
+		error = chown_common(nd.mnt, nd.dentry, user, group);
 		path_release(&nd);
 	}
 	return error;
@@ -703,7 +704,7 @@ asmlinkage long sys_lchown(const char __
 
 	error = user_path_walk_link(filename, &nd);
 	if (!error) {
-		error = chown_common(nd.dentry, user, group);
+		error = chown_common(nd.mnt, nd.dentry, user, group);
 		path_release(&nd);
 	}
 	return error;
@@ -717,7 +718,7 @@ asmlinkage long sys_fchown(unsigned int 
 
 	file = fget(fd);
 	if (file) {
-		error = chown_common(file->f_dentry, user, group);
+		error = chown_common(file->f_vfsmnt, file->f_dentry, user, group);
 		fput(file);
 	}
 	return error;
diff -NurpP --minimal linux-2.6.4/fs/pipe.c linux-2.6.4-bme0.04/fs/pipe.c
--- linux-2.6.4/fs/pipe.c	2004-03-11 03:55:28.000000000 +0100
+++ linux-2.6.4-bme0.04/fs/pipe.c	2004-03-12 20:51:58.000000000 +0100
@@ -165,7 +165,7 @@ pipe_readv(struct file *filp, const stru
 		kill_fasync(PIPE_FASYNC_WRITERS(*inode), SIGIO, POLL_OUT);
 	}
 	if (ret > 0)
-		update_atime(inode);
+		update_atime(inode, filp->f_vfsmnt);
 	return ret;
 }
 
diff -NurpP --minimal linux-2.6.4/fs/qnx4/dir.c linux-2.6.4-bme0.04/fs/qnx4/dir.c
--- linux-2.6.4/fs/qnx4/dir.c	2004-03-11 03:55:35.000000000 +0100
+++ linux-2.6.4-bme0.04/fs/qnx4/dir.c	2004-03-12 20:51:58.000000000 +0100
@@ -76,7 +76,7 @@ static int qnx4_readdir(struct file *fil
 		}
 		brelse(bh);
 	}
-	update_atime(inode);
+	update_atime(inode, filp->f_vfsmnt);
 
 out:
 	unlock_kernel();
diff -NurpP --minimal linux-2.6.4/fs/reiserfs/dir.c linux-2.6.4-bme0.04/fs/reiserfs/dir.c
--- linux-2.6.4/fs/reiserfs/dir.c	2004-03-11 03:55:28.000000000 +0100
+++ linux-2.6.4-bme0.04/fs/reiserfs/dir.c	2004-03-12 20:51:58.000000000 +0100
@@ -186,7 +186,7 @@ static int reiserfs_readdir (struct file
     filp->f_pos = next_pos;
     pathrelse (&path_to_entry);
     reiserfs_check_path(&path_to_entry) ;
-    update_atime(inode) ;
+    update_atime(inode, filp->f_vfsmnt) ;
  out:
     reiserfs_write_unlock(inode->i_sb);
     return ret;
diff -NurpP --minimal linux-2.6.4/fs/reiserfs/ioctl.c linux-2.6.4-bme0.04/fs/reiserfs/ioctl.c
--- linux-2.6.4/fs/reiserfs/ioctl.c	2004-03-11 03:55:26.000000000 +0100
+++ linux-2.6.4-bme0.04/fs/reiserfs/ioctl.c	2004-03-12 20:51:58.000000000 +0100
@@ -5,6 +5,7 @@
 #include <linux/fs.h>
 #include <linux/reiserfs_fs.h>
 #include <linux/time.h>
+#include <linux/mount.h>
 #include <asm/uaccess.h>
 #include <linux/pagemap.h>
 #include <linux/smp_lock.h>
@@ -38,7 +39,7 @@ int reiserfs_ioctl (struct inode * inode
 		i_attrs_to_sd_attrs( inode, ( __u16 * ) &flags );
 		return put_user(flags, (int *) arg);
 	case REISERFS_IOC_SETFLAGS: {
-		if (IS_RDONLY(inode))
+		if (IS_RDONLY(inode) || MNT_IS_RDONLY(filp->f_vfsmnt))
 			return -EROFS;
 
 		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
@@ -70,7 +71,7 @@ int reiserfs_ioctl (struct inode * inode
 	case REISERFS_IOC_SETVERSION:
 		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
 			return -EPERM;
-		if (IS_RDONLY(inode))
+		if (IS_RDONLY(inode) || MNT_IS_RDONLY(filp->f_vfsmnt))
 			return -EROFS;
 		if (get_user(inode->i_generation, (int *) arg))
 			return -EFAULT;	
diff -NurpP --minimal linux-2.6.4/fs/stat.c linux-2.6.4-bme0.04/fs/stat.c
--- linux-2.6.4/fs/stat.c	2004-03-11 03:55:23.000000000 +0100
+++ linux-2.6.4-bme0.04/fs/stat.c	2004-03-12 20:51:58.000000000 +0100
@@ -272,7 +272,7 @@ asmlinkage long sys_readlink(const char 
 		if (inode->i_op && inode->i_op->readlink) {
 			error = security_inode_readlink(nd.dentry);
 			if (!error) {
-				update_atime(inode);
+				update_atime(inode, nd.mnt);
 				error = inode->i_op->readlink(nd.dentry, buf, bufsiz);
 			}
 		}
diff -NurpP --minimal linux-2.6.4/fs/sysv/dir.c linux-2.6.4-bme0.04/fs/sysv/dir.c
--- linux-2.6.4/fs/sysv/dir.c	2004-03-11 03:55:24.000000000 +0100
+++ linux-2.6.4-bme0.04/fs/sysv/dir.c	2004-03-12 20:51:58.000000000 +0100
@@ -116,7 +116,7 @@ static int sysv_readdir(struct file * fi
 
 done:
 	filp->f_pos = (n << PAGE_CACHE_SHIFT) | offset;
-	update_atime(inode);
+	update_atime(inode, filp->f_vfsmnt);
 	unlock_kernel();
 	return 0;
 }
diff -NurpP --minimal linux-2.6.4/fs/udf/dir.c linux-2.6.4-bme0.04/fs/udf/dir.c
--- linux-2.6.4/fs/udf/dir.c	2004-03-11 03:55:24.000000000 +0100
+++ linux-2.6.4-bme0.04/fs/udf/dir.c	2004-03-12 20:51:58.000000000 +0100
@@ -98,7 +98,7 @@ int udf_readdir(struct file *filp, void 
 	}
 
 	result = do_udf_readdir(dir, filp, filldir, dirent);
-	update_atime(dir);
+	update_atime(dir, filp->f_vfsmnt);
 	unlock_kernel();
  	return result;
 }
diff -NurpP --minimal linux-2.6.4/fs/ufs/dir.c linux-2.6.4-bme0.04/fs/ufs/dir.c
--- linux-2.6.4/fs/ufs/dir.c	2004-03-11 03:55:43.000000000 +0100
+++ linux-2.6.4-bme0.04/fs/ufs/dir.c	2004-03-12 20:51:58.000000000 +0100
@@ -166,7 +166,7 @@ revalidate:
 		offset = 0;
 		brelse (bh);
 	}
-	update_atime(inode);
+	update_atime(inode, filp->f_vfsmnt);
 	unlock_kernel();
 	return 0;
 }
diff -NurpP --minimal linux-2.6.4/include/linux/fs.h linux-2.6.4-bme0.04/include/linux/fs.h
--- linux-2.6.4/include/linux/fs.h	2004-03-11 03:55:24.000000000 +0100
+++ linux-2.6.4-bme0.04/include/linux/fs.h	2004-03-12 20:51:58.000000000 +0100
@@ -211,7 +211,7 @@ extern int leases_enable, dir_notify_ena
 #include <asm/byteorder.h>
 
 /* Used to be a macro which just called the function, now just a function */
-extern void update_atime (struct inode *);
+extern void update_atime (struct inode *, struct vfsmount *);
 
 extern void inode_init(unsigned long);
 extern void mnt_init(unsigned long);
diff -NurpP --minimal linux-2.6.4/include/linux/mount.h linux-2.6.4-bme0.04/include/linux/mount.h
--- linux-2.6.4/include/linux/mount.h	2004-03-11 03:55:22.000000000 +0100
+++ linux-2.6.4-bme0.04/include/linux/mount.h	2004-03-12 20:51:58.000000000 +0100
@@ -14,9 +14,12 @@
 
 #include <linux/list.h>
 
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
@@ -33,6 +36,11 @@ struct vfsmount
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
diff -NurpP --minimal linux-2.6.4/ipc/shm.c linux-2.6.4-bme0.04/ipc/shm.c
--- linux-2.6.4/ipc/shm.c	2004-03-11 03:55:27.000000000 +0100
+++ linux-2.6.4-bme0.04/ipc/shm.c	2004-03-12 20:51:58.000000000 +0100
@@ -149,7 +149,7 @@ static void shm_close (struct vm_area_st
 
 static int shm_mmap(struct file * file, struct vm_area_struct * vma)
 {
-	update_atime(file->f_dentry->d_inode);
+	update_atime(file->f_dentry->d_inode, file->f_vfsmnt);
 	vma->vm_ops = &shm_vm_ops;
 	shm_inc(file->f_dentry->d_inode->i_ino);
 	return 0;
diff -NurpP --minimal linux-2.6.4/mm/filemap.c linux-2.6.4-bme0.04/mm/filemap.c
--- linux-2.6.4/mm/filemap.c	2004-03-11 03:55:25.000000000 +0100
+++ linux-2.6.4-bme0.04/mm/filemap.c	2004-03-12 20:51:58.000000000 +0100
@@ -725,7 +725,7 @@ no_cached_page:
 	*ppos = ((loff_t) index << PAGE_CACHE_SHIFT) + offset;
 	if (cached_page)
 		page_cache_release(cached_page);
-	update_atime(inode);
+	update_atime(inode, filp->f_vfsmnt);
 }
 
 EXPORT_SYMBOL(do_generic_mapping_read);
@@ -820,7 +820,7 @@ __generic_file_aio_read(struct kiocb *io
 			if (retval > 0)
 				*ppos = pos + retval;
 		}
-		update_atime(filp->f_dentry->d_inode);
+		update_atime(filp->f_dentry->d_inode, filp->f_vfsmnt);
 		goto out;
 	}
 
@@ -1357,7 +1357,7 @@ int generic_file_mmap(struct file * file
 
 	if (!mapping->a_ops->readpage)
 		return -ENOEXEC;
-	update_atime(inode);
+	update_atime(inode, file->f_vfsmnt);
 	vma->vm_ops = &generic_file_vm_ops;
 	return 0;
 }
diff -NurpP --minimal linux-2.6.4/mm/shmem.c linux-2.6.4-bme0.04/mm/shmem.c
--- linux-2.6.4/mm/shmem.c	2004-03-11 03:55:26.000000000 +0100
+++ linux-2.6.4-bme0.04/mm/shmem.c	2004-03-12 20:51:58.000000000 +0100
@@ -1067,7 +1067,7 @@ static int shmem_mmap(struct file *file,
 	ops = &shmem_vm_ops;
 	if (!S_ISREG(inode->i_mode))
 		return -EACCES;
-	update_atime(inode);
+	update_atime(inode, file->f_vfsmnt);
 	vma->vm_ops = ops;
 	return 0;
 }
@@ -1363,7 +1363,7 @@ static void do_shmem_file_read(struct fi
 	}
 
 	*ppos = ((loff_t) index << PAGE_CACHE_SHIFT) + offset;
-	update_atime(inode);
+	update_atime(inode, filp->f_vfsmnt);
 }
 
 static ssize_t shmem_file_read(struct file *filp, char __user *buf, size_t count, loff_t *ppos)
diff -NurpP --minimal linux-2.6.4/net/unix/af_unix.c linux-2.6.4-bme0.04/net/unix/af_unix.c
--- linux-2.6.4/net/unix/af_unix.c	2004-03-11 03:55:35.000000000 +0100
+++ linux-2.6.4-bme0.04/net/unix/af_unix.c	2004-03-12 20:51:58.000000000 +0100
@@ -691,7 +691,7 @@ static struct sock *unix_find_other(stru
 			goto put_fail;
 
 		if (u->sk_type == type)
-			update_atime(nd.dentry->d_inode);
+			update_atime(nd.dentry->d_inode, nd.mnt);
 
 		path_release(&nd);
 
@@ -707,7 +707,7 @@ static struct sock *unix_find_other(stru
 			struct dentry *dentry;
 			dentry = unix_sk(u)->dentry;
 			if (dentry)
-				update_atime(dentry->d_inode);
+				update_atime(dentry->d_inode, nd.mnt);
 		} else
 			goto fail;
 	}
