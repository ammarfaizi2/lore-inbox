Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262287AbVBVMSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262287AbVBVMSn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 07:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbVBVMSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 07:18:05 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:59086 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262291AbVBVMNe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 07:13:34 -0500
Date: Tue, 22 Feb 2005 13:13:33 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: [Patch 6/6] Bind Mount Extensions 0.06
Message-ID: <20050222121333.GG3682@mail.13thfloor.at>
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
; This part adds appropriate vfsmount checks (regarding ro)
; in various places like: report_statvfs*, *_ioctl, *utime*,
; *chmod*, and *permission (wherever RDONLY is verified)
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

diff -NurpP --minimal linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01/arch/sparc64/solaris/fs.c linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01-ro0.01/arch/sparc64/solaris/fs.c
--- linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01/arch/sparc64/solaris/fs.c	2004-12-25 01:54:50 +0100
+++ linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01-ro0.01/arch/sparc64/solaris/fs.c	2005-02-19 06:32:05 +0100
@@ -362,7 +362,7 @@ static int report_statvfs(struct vfsmoun
 		int j = strlen (p);
 		
 		if (j > 15) j = 15;
-		if (IS_RDONLY(inode)) i = 1;
+		if (IS_RDONLY(inode) || (mnt && MNT_IS_RDONLY(mnt))) i = 1;
 		if (mnt->mnt_flags & MNT_NOSUID) i |= 2;
 		if (!sysv_valid_dev(inode->i_sb->s_dev))
 			return -EOVERFLOW;
@@ -398,7 +398,7 @@ static int report_statvfs64(struct vfsmo
 		int j = strlen (p);
 		
 		if (j > 15) j = 15;
-		if (IS_RDONLY(inode)) i = 1;
+		if (IS_RDONLY(inode) || (mnt && MNT_IS_RDONLY(mnt))) i = 1;
 		if (mnt->mnt_flags & MNT_NOSUID) i |= 2;
 		if (!sysv_valid_dev(inode->i_sb->s_dev))
 			return -EOVERFLOW;
diff -NurpP --minimal linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01/fs/ext2/ioctl.c linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01-ro0.01/fs/ext2/ioctl.c
--- linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01/fs/ext2/ioctl.c	2005-02-13 17:16:54 +0100
+++ linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01-ro0.01/fs/ext2/ioctl.c	2005-02-19 06:32:05 +0100
@@ -29,7 +29,8 @@ int ext2_ioctl (struct inode * inode, st
 	case EXT2_IOC_SETFLAGS: {
 		unsigned int oldflags;
 
-		if (IS_RDONLY(inode))
+		if (IS_RDONLY(inode) ||
+			(filp && MNT_IS_RDONLY(filp->f_vfsmnt)))
 			return -EROFS;
 
 		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
@@ -68,7 +69,8 @@ int ext2_ioctl (struct inode * inode, st
 	case EXT2_IOC_SETVERSION:
 		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
 			return -EPERM;
-		if (IS_RDONLY(inode))
+		if (IS_RDONLY(inode) ||
+			(filp && MNT_IS_RDONLY(filp->f_vfsmnt)))
 			return -EROFS;
 		if (get_user(inode->i_generation, (int __user *) arg))
 			return -EFAULT;	
diff -NurpP --minimal linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01/fs/ext3/ioctl.c linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01-ro0.01/fs/ext3/ioctl.c
--- linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01/fs/ext3/ioctl.c	2005-02-13 17:16:54 +0100
+++ linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01-ro0.01/fs/ext3/ioctl.c	2005-02-19 06:32:05 +0100
@@ -35,7 +35,8 @@ int ext3_ioctl (struct inode * inode, st
 		unsigned int oldflags;
 		unsigned int jflag;
 
-		if (IS_RDONLY(inode))
+		if (IS_RDONLY(inode) ||
+			(filp && MNT_IS_RDONLY(filp->f_vfsmnt)))
 			return -EROFS;
 
 		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
@@ -111,7 +112,8 @@ flags_err:
 
 		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
 			return -EPERM;
-		if (IS_RDONLY(inode))
+		if (IS_RDONLY(inode) ||
+			(filp && MNT_IS_RDONLY(filp->f_vfsmnt)))
 			return -EROFS;
 		if (get_user(generation, (int __user *) arg))
 			return -EFAULT;
@@ -162,7 +164,8 @@ flags_err:
 		if (!test_opt(inode->i_sb, RESERVATION) ||!S_ISREG(inode->i_mode))
 			return -ENOTTY;
 
-		if (IS_RDONLY(inode))
+		if (IS_RDONLY(inode) ||
+			(filp && MNT_IS_RDONLY(filp->f_vfsmnt)))
 			return -EROFS;
 
 		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
@@ -183,7 +186,8 @@ flags_err:
 		if (!capable(CAP_SYS_RESOURCE))
 			return -EPERM;
 
-		if (IS_RDONLY(inode))
+		if (IS_RDONLY(inode) ||
+			(filp && MNT_IS_RDONLY(filp->f_vfsmnt)))
 			return -EROFS;
 
 		if (get_user(n_blocks_count, (__u32 __user *)arg))
@@ -204,7 +208,8 @@ flags_err:
 		if (!capable(CAP_SYS_RESOURCE))
 			return -EPERM;
 
-		if (IS_RDONLY(inode))
+		if (IS_RDONLY(inode) ||
+			(filp && MNT_IS_RDONLY(filp->f_vfsmnt)))
 			return -EROFS;
 
 		if (copy_from_user(&input, (struct ext3_new_group_input __user *)arg,
diff -NurpP --minimal linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01/fs/hfsplus/ioctl.c linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01-ro0.01/fs/hfsplus/ioctl.c
--- linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01/fs/hfsplus/ioctl.c	2005-02-13 17:16:55 +0100
+++ linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01-ro0.01/fs/hfsplus/ioctl.c	2005-02-19 06:32:05 +0100
@@ -34,7 +34,8 @@ int hfsplus_ioctl(struct inode *inode, s
 			flags |= EXT2_FLAG_NODUMP; /* EXT2_NODUMP_FL */
 		return put_user(flags, (int __user *)arg);
 	case HFSPLUS_IOC_EXT2_SETFLAGS: {
-		if (IS_RDONLY(inode))
+		if (IS_RDONLY(inode) ||
+			(filp && MNT_IS_RDONLY(filp->f_vfsmnt)))
 			return -EROFS;
 
 		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
diff -NurpP --minimal linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01/fs/namei.c linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01-ro0.01/fs/namei.c
--- linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01/fs/namei.c	2005-02-19 06:31:50 +0100
+++ linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01-ro0.01/fs/namei.c	2005-02-19 06:32:05 +0100
@@ -220,7 +220,7 @@ int permission(struct inode *inode, int 
 		/*
 		 * Nobody gets write access to a read-only fs.
 		 */
-		if (IS_RDONLY(inode) &&
+		if ((IS_RDONLY(inode) || (nd && MNT_IS_RDONLY(nd->mnt))) &&
 		    (S_ISREG(mode) || S_ISDIR(mode) || S_ISLNK(mode)))
 			return -EROFS;
 
@@ -1307,7 +1307,8 @@ int may_open(struct nameidata *nd, int a
 			return -EACCES;
 
 		flag &= ~O_TRUNC;
-	} else if (IS_RDONLY(inode) && (flag & FMODE_WRITE))
+	} else if ((IS_RDONLY(inode) || (nd && MNT_IS_RDONLY(nd->mnt)))
+		&& (flag & FMODE_WRITE))
 		return -EROFS;
 	/*
 	 * An append-only file must be opened in append mode for writing.
@@ -2228,6 +2229,9 @@ static inline int do_rename(const char *
 	error = -EINVAL;
 	if (old_dentry == trap)
 		goto exit4;
+	error = -EROFS;
+	if (MNT_IS_RDONLY(newnd.mnt))
+		goto exit4;
 	new_dentry = lookup_hash(&newnd.last, new_dir);
 	error = PTR_ERR(new_dentry);
 	if (IS_ERR(new_dentry))
diff -NurpP --minimal linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01/fs/nfs/dir.c linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01-ro0.01/fs/nfs/dir.c
--- linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01/fs/nfs/dir.c	2005-02-13 17:16:55 +0100
+++ linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01-ro0.01/fs/nfs/dir.c	2005-02-19 06:32:05 +0100
@@ -771,7 +771,8 @@ static int is_atomic_open(struct inode *
 	if (nd->flags & LOOKUP_DIRECTORY)
 		return 0;
 	/* Are we trying to write to a read only partition? */
-	if (IS_RDONLY(dir) && (nd->intent.open.flags & (O_CREAT|O_TRUNC|FMODE_WRITE)))
+	if ((IS_RDONLY(dir) || (nd && MNT_IS_RDONLY(nd->mnt))) &&
+		(nd->intent.open.flags & (O_CREAT|O_TRUNC|FMODE_WRITE)))
 		return 0;
 	return 1;
 }
diff -NurpP --minimal linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01/fs/nfsd/vfs.c linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01-ro0.01/fs/nfsd/vfs.c
--- linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01/fs/nfsd/vfs.c	2005-02-13 17:16:58 +0100
+++ linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01-ro0.01/fs/nfsd/vfs.c	2005-02-19 06:32:05 +0100
@@ -1734,7 +1734,8 @@ nfsd_permission(struct svc_export *exp, 
 	 */
 	if (!(acc & MAY_LOCAL_ACCESS))
 		if (acc & (MAY_WRITE | MAY_SATTR | MAY_TRUNC)) {
-			if (EX_RDONLY(exp) || IS_RDONLY(inode))
+			if (EX_RDONLY(exp) || IS_RDONLY(inode)
+				|| (exp && MNT_IS_RDONLY(exp->ex_mnt)))
 				return nfserr_rofs;
 			if (/* (acc & MAY_WRITE) && */ IS_IMMUTABLE(inode))
 				return nfserr_perm;
diff -NurpP --minimal linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01/fs/open.c linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01-ro0.01/fs/open.c
--- linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01/fs/open.c	2005-02-19 06:31:43 +0100
+++ linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01-ro0.01/fs/open.c	2005-02-19 06:32:05 +0100
@@ -239,7 +239,7 @@ static inline long do_sys_truncate(const
 		goto dput_and_out;
 
 	error = -EROFS;
-	if (IS_RDONLY(inode))
+	if (IS_RDONLY(inode) || MNT_IS_RDONLY(nd.mnt))
 		goto dput_and_out;
 
 	error = -EPERM;
@@ -363,7 +363,7 @@ asmlinkage long sys_utime(char __user * 
 	inode = nd.dentry->d_inode;
 
 	error = -EROFS;
-	if (IS_RDONLY(inode))
+	if (IS_RDONLY(inode) || MNT_IS_RDONLY(nd.mnt))
 		goto dput_and_out;
 
 	/* Don't worry, the checks are done in inode_change_ok() */
@@ -420,7 +420,7 @@ long do_utimes(char __user * filename, s
 	inode = nd.dentry->d_inode;
 
 	error = -EROFS;
-	if (IS_RDONLY(inode))
+	if (IS_RDONLY(inode) || MNT_IS_RDONLY(nd.mnt))
 		goto dput_and_out;
 
 	/* Don't worry, the checks are done in inode_change_ok() */
@@ -502,7 +502,8 @@ asmlinkage long sys_access(const char __
 	if (!res) {
 		res = permission(nd.dentry->d_inode, mode, &nd);
 		/* SuS v2 requires we report a read only fs too */
-		if(!res && (mode & S_IWOTH) && IS_RDONLY(nd.dentry->d_inode)
+		if(!res && (mode & S_IWOTH)
+		   && (IS_RDONLY(nd.dentry->d_inode) || MNT_IS_RDONLY(nd.mnt))
 		   && !special_file(nd.dentry->d_inode->i_mode))
 			res = -EROFS;
 		path_release(&nd);
@@ -608,7 +609,7 @@ asmlinkage long sys_fchmod(unsigned int 
 	inode = dentry->d_inode;
 
 	err = -EROFS;
-	if (IS_RDONLY(inode))
+	if (IS_RDONLY(inode) || (file && MNT_IS_RDONLY(file->f_vfsmnt)))
 		goto out_putf;
 	err = -EPERM;
 	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
@@ -640,7 +641,7 @@ asmlinkage long sys_chmod(const char __u
 	inode = nd.dentry->d_inode;
 
 	error = -EROFS;
-	if (IS_RDONLY(inode))
+	if (IS_RDONLY(inode) || MNT_IS_RDONLY(nd.mnt))
 		goto dput_and_out;
 
 	error = -EPERM;
diff -NurpP --minimal linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01/fs/reiserfs/ioctl.c linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01-ro0.01/fs/reiserfs/ioctl.c
--- linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01/fs/reiserfs/ioctl.c	2005-02-13 17:16:59 +0100
+++ linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01-ro0.01/fs/reiserfs/ioctl.c	2005-02-19 06:32:05 +0100
@@ -40,7 +40,8 @@ int reiserfs_ioctl (struct inode * inode
 		i_attrs_to_sd_attrs( inode, ( __u16 * ) &flags );
 		return put_user(flags, (int __user *) arg);
 	case REISERFS_IOC_SETFLAGS: {
-		if (IS_RDONLY(inode))
+		if (IS_RDONLY(inode) ||
+			(filp && MNT_IS_RDONLY(filp->f_vfsmnt)))
 			return -EROFS;
 
 		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
@@ -72,7 +73,8 @@ int reiserfs_ioctl (struct inode * inode
 	case REISERFS_IOC_SETVERSION:
 		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
 			return -EPERM;
-		if (IS_RDONLY(inode))
+		if (IS_RDONLY(inode) ||
+			(filp && MNT_IS_RDONLY(filp->f_vfsmnt)))
 			return -EROFS;
 		if (get_user(inode->i_generation, (int __user *) arg))
 			return -EFAULT;	
diff -NurpP --minimal linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01/fs/reiserfs/xattr.c linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01-ro0.01/fs/reiserfs/xattr.c
--- linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01/fs/reiserfs/xattr.c	2005-02-13 17:16:59 +0100
+++ linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01-ro0.01/fs/reiserfs/xattr.c	2005-02-19 06:32:05 +0100
@@ -1355,7 +1355,7 @@ __reiserfs_permission (struct inode *ino
 		/*
 		 * Nobody gets write access to a read-only fs.
 		 */
-		if (IS_RDONLY(inode) &&
+		if ((IS_RDONLY(inode) || (nd && MNT_IS_RDONLY(nd->mnt))) &&
 		    (S_ISREG(mode) || S_ISDIR(mode) || S_ISLNK(mode)))
 			return -EROFS;
 
