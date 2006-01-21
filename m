Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbWAUInk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbWAUInk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 03:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWAUInj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 03:43:39 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:30909 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1751193AbWAUIni (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 03:43:38 -0500
Date: Sat, 21 Jan 2006 09:43:37 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, Al Viro <viro@ftp.linux.org.uk>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/6] vfs: extend IS_RDONLY() checks to MNT_IS_RDONLY()
Message-ID: <20060121084336.GG10044@MAIL.13thfloor.at>
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
; wherever checks for IS_RDONLY(inode) happen, this adds
; the proper MNT_IS_RDONLY(mnt) checks to ensure that the
; vfsmount isn't read-only
;
;
; Changelog:
;
;   0.01  - broken out part from bme0.05
;   0.02  - removed redundant checks
;

Signed-off-by: Herbert Pötzl <herbert@13thfloor.at>

diff -NurpP --minimal linux-2.6.16-rc1/arch/sparc64/solaris/fs.c linux-2.6.16-rc1-bme0.06.2-ro0.02/arch/sparc64/solaris/fs.c
--- linux-2.6.16-rc1/arch/sparc64/solaris/fs.c	2006-01-18 06:07:57 +0100
+++ linux-2.6.16-rc1-bme0.06.2-ro0.02/arch/sparc64/solaris/fs.c	2006-01-21 09:09:32 +0100
@@ -363,7 +363,7 @@ static int report_statvfs(struct vfsmoun
 		int j = strlen (p);
 		
 		if (j > 15) j = 15;
-		if (IS_RDONLY(inode)) i = 1;
+		if (IS_RDONLY(inode) || MNT_IS_RDONLY(mnt)) i = 1;
 		if (mnt->mnt_flags & MNT_NOSUID) i |= 2;
 		if (!sysv_valid_dev(inode->i_sb->s_dev))
 			return -EOVERFLOW;
@@ -399,7 +399,7 @@ static int report_statvfs64(struct vfsmo
 		int j = strlen (p);
 		
 		if (j > 15) j = 15;
-		if (IS_RDONLY(inode)) i = 1;
+		if (IS_RDONLY(inode) || MNT_IS_RDONLY(mnt)) i = 1;
 		if (mnt->mnt_flags & MNT_NOSUID) i |= 2;
 		if (!sysv_valid_dev(inode->i_sb->s_dev))
 			return -EOVERFLOW;
diff -NurpP --minimal linux-2.6.16-rc1/fs/ext2/ioctl.c linux-2.6.16-rc1-bme0.06.2-ro0.02/fs/ext2/ioctl.c
--- linux-2.6.16-rc1/fs/ext2/ioctl.c	2006-01-18 06:08:29 +0100
+++ linux-2.6.16-rc1-bme0.06.2-ro0.02/fs/ext2/ioctl.c	2006-01-21 09:09:32 +0100
@@ -11,6 +11,7 @@
 #include <linux/capability.h>
 #include <linux/time.h>
 #include <linux/sched.h>
+#include <linux/mount.h>
 #include <asm/current.h>
 #include <asm/uaccess.h>
 
@@ -30,7 +31,8 @@ int ext2_ioctl (struct inode * inode, st
 	case EXT2_IOC_SETFLAGS: {
 		unsigned int oldflags;
 
-		if (IS_RDONLY(inode))
+		if (IS_RDONLY(inode) ||
+			(filp && MNT_IS_RDONLY(filp->f_vfsmnt)))
 			return -EROFS;
 
 		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
@@ -69,7 +71,8 @@ int ext2_ioctl (struct inode * inode, st
 	case EXT2_IOC_SETVERSION:
 		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
 			return -EPERM;
-		if (IS_RDONLY(inode))
+		if (IS_RDONLY(inode) ||
+			(filp && MNT_IS_RDONLY(filp->f_vfsmnt)))
 			return -EROFS;
 		if (get_user(inode->i_generation, (int __user *) arg))
 			return -EFAULT;	
diff -NurpP --minimal linux-2.6.16-rc1/fs/ext3/ioctl.c linux-2.6.16-rc1-bme0.06.2-ro0.02/fs/ext3/ioctl.c
--- linux-2.6.16-rc1/fs/ext3/ioctl.c	2006-01-18 06:08:29 +0100
+++ linux-2.6.16-rc1-bme0.06.2-ro0.02/fs/ext3/ioctl.c	2006-01-21 09:09:32 +0100
@@ -8,6 +8,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/mount.h>
 #include <linux/jbd.h>
 #include <linux/capability.h>
 #include <linux/ext3_fs.h>
@@ -36,7 +37,8 @@ int ext3_ioctl (struct inode * inode, st
 		unsigned int oldflags;
 		unsigned int jflag;
 
-		if (IS_RDONLY(inode))
+		if (IS_RDONLY(inode) ||
+			(filp && MNT_IS_RDONLY(filp->f_vfsmnt)))
 			return -EROFS;
 
 		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
@@ -112,7 +114,8 @@ flags_err:
 
 		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
 			return -EPERM;
-		if (IS_RDONLY(inode))
+		if (IS_RDONLY(inode) ||
+			(filp && MNT_IS_RDONLY(filp->f_vfsmnt)))
 			return -EROFS;
 		if (get_user(generation, (int __user *) arg))
 			return -EFAULT;
@@ -166,7 +169,8 @@ flags_err:
 		if (!test_opt(inode->i_sb, RESERVATION) ||!S_ISREG(inode->i_mode))
 			return -ENOTTY;
 
-		if (IS_RDONLY(inode))
+		if (IS_RDONLY(inode) ||
+			(filp && MNT_IS_RDONLY(filp->f_vfsmnt)))
 			return -EROFS;
 
 		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
@@ -201,7 +205,8 @@ flags_err:
 		if (!capable(CAP_SYS_RESOURCE))
 			return -EPERM;
 
-		if (IS_RDONLY(inode))
+		if (IS_RDONLY(inode) ||
+			(filp && MNT_IS_RDONLY(filp->f_vfsmnt)))
 			return -EROFS;
 
 		if (get_user(n_blocks_count, (__u32 __user *)arg))
@@ -222,7 +227,8 @@ flags_err:
 		if (!capable(CAP_SYS_RESOURCE))
 			return -EPERM;
 
-		if (IS_RDONLY(inode))
+		if (IS_RDONLY(inode) ||
+			(filp && MNT_IS_RDONLY(filp->f_vfsmnt)))
 			return -EROFS;
 
 		if (copy_from_user(&input, (struct ext3_new_group_input __user *)arg,
diff -NurpP --minimal linux-2.6.16-rc1/fs/hfsplus/ioctl.c linux-2.6.16-rc1-bme0.06.2-ro0.02/fs/hfsplus/ioctl.c
--- linux-2.6.16-rc1/fs/hfsplus/ioctl.c	2006-01-18 06:08:30 +0100
+++ linux-2.6.16-rc1-bme0.06.2-ro0.02/fs/hfsplus/ioctl.c	2006-01-21 09:09:32 +0100
@@ -35,7 +35,8 @@ int hfsplus_ioctl(struct inode *inode, s
 			flags |= EXT2_FLAG_NODUMP; /* EXT2_NODUMP_FL */
 		return put_user(flags, (int __user *)arg);
 	case HFSPLUS_IOC_EXT2_SETFLAGS: {
-		if (IS_RDONLY(inode))
+		if (IS_RDONLY(inode) ||
+			(filp && MNT_IS_RDONLY(filp->f_vfsmnt)))
 			return -EROFS;
 
 		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
diff -NurpP --minimal linux-2.6.16-rc1/fs/namei.c linux-2.6.16-rc1-bme0.06.2-ro0.02/fs/namei.c
--- linux-2.6.16-rc1/fs/namei.c	2006-01-18 06:08:30 +0100
+++ linux-2.6.16-rc1-bme0.06.2-ro0.02/fs/namei.c	2006-01-21 09:09:32 +0100
@@ -233,7 +233,7 @@ int permission(struct inode *inode, int 
 		/*
 		 * Nobody gets write access to a read-only fs.
 		 */
-		if (IS_RDONLY(inode) &&
+		if ((IS_RDONLY(inode) || (nd && MNT_IS_RDONLY(nd->mnt))) &&
 		    (S_ISREG(mode) || S_ISDIR(mode) || S_ISLNK(mode)))
 			return -EROFS;
 
@@ -1456,7 +1456,8 @@ int may_open(struct nameidata *nd, int a
 			return -EACCES;
 
 		flag &= ~O_TRUNC;
-	} else if (IS_RDONLY(inode) && (flag & FMODE_WRITE))
+	} else if ((IS_RDONLY(inode) || MNT_IS_RDONLY(nd->mnt))
+		&& (flag & FMODE_WRITE))
 		return -EROFS;
 	/*
 	 * An append-only file must be opened in append mode for writing.
@@ -2366,6 +2367,9 @@ static int do_rename(const char * oldnam
 	error = -EINVAL;
 	if (old_dentry == trap)
 		goto exit4;
+	error = -EROFS;
+	if (MNT_IS_RDONLY(newnd.mnt))
+		goto exit4;
 	new_dentry = lookup_hash(&newnd);
 	error = PTR_ERR(new_dentry);
 	if (IS_ERR(new_dentry))
diff -NurpP --minimal linux-2.6.16-rc1/fs/nfs/dir.c linux-2.6.16-rc1-bme0.06.2-ro0.02/fs/nfs/dir.c
--- linux-2.6.16-rc1/fs/nfs/dir.c	2006-01-18 06:08:30 +0100
+++ linux-2.6.16-rc1-bme0.06.2-ro0.02/fs/nfs/dir.c	2006-01-21 09:09:32 +0100
@@ -902,7 +902,8 @@ static int is_atomic_open(struct inode *
 	if (nd->flags & LOOKUP_DIRECTORY)
 		return 0;
 	/* Are we trying to write to a read only partition? */
-	if (IS_RDONLY(dir) && (nd->intent.open.flags & (O_CREAT|O_TRUNC|FMODE_WRITE)))
+	if ((IS_RDONLY(dir) || MNT_IS_RDONLY(nd->mnt)) &&
+		(nd->intent.open.flags & (O_CREAT|O_TRUNC|FMODE_WRITE)))
 		return 0;
 	return 1;
 }
diff -NurpP --minimal linux-2.6.16-rc1/fs/nfsd/vfs.c linux-2.6.16-rc1-bme0.06.2-ro0.02/fs/nfsd/vfs.c
--- linux-2.6.16-rc1/fs/nfsd/vfs.c	2006-01-18 06:08:34 +0100
+++ linux-2.6.16-rc1-bme0.06.2-ro0.02/fs/nfsd/vfs.c	2006-01-21 09:09:32 +0100
@@ -1778,7 +1778,8 @@ nfsd_permission(struct svc_export *exp, 
 	 */
 	if (!(acc & MAY_LOCAL_ACCESS))
 		if (acc & (MAY_WRITE | MAY_SATTR | MAY_TRUNC)) {
-			if (EX_RDONLY(exp) || IS_RDONLY(inode))
+			if (EX_RDONLY(exp) || IS_RDONLY(inode)
+				|| MNT_IS_RDONLY(exp->ex_mnt))
 				return nfserr_rofs;
 			if (/* (acc & MAY_WRITE) && */ IS_IMMUTABLE(inode))
 				return nfserr_perm;
diff -NurpP --minimal linux-2.6.16-rc1/fs/open.c linux-2.6.16-rc1-bme0.06.2-ro0.02/fs/open.c
--- linux-2.6.16-rc1/fs/open.c	2006-01-18 06:08:34 +0100
+++ linux-2.6.16-rc1-bme0.06.2-ro0.02/fs/open.c	2006-01-21 09:09:32 +0100
@@ -247,7 +247,7 @@ static long do_sys_truncate(const char _
 		goto dput_and_out;
 
 	error = -EROFS;
-	if (IS_RDONLY(inode))
+	if (IS_RDONLY(inode) || MNT_IS_RDONLY(nd.mnt))
 		goto dput_and_out;
 
 	error = -EPERM;
@@ -371,7 +371,7 @@ asmlinkage long sys_utime(char __user * 
 	inode = nd.dentry->d_inode;
 
 	error = -EROFS;
-	if (IS_RDONLY(inode))
+	if (IS_RDONLY(inode) || MNT_IS_RDONLY(nd.mnt))
 		goto dput_and_out;
 
 	/* Don't worry, the checks are done in inode_change_ok() */
@@ -428,7 +428,7 @@ long do_utimes(char __user * filename, s
 	inode = nd.dentry->d_inode;
 
 	error = -EROFS;
-	if (IS_RDONLY(inode))
+	if (IS_RDONLY(inode) || MNT_IS_RDONLY(nd.mnt))
 		goto dput_and_out;
 
 	/* Don't worry, the checks are done in inode_change_ok() */
@@ -510,7 +510,8 @@ asmlinkage long sys_access(const char __
 	if (!res) {
 		res = vfs_permission(&nd, mode);
 		/* SuS v2 requires we report a read only fs too */
-		if(!res && (mode & S_IWOTH) && IS_RDONLY(nd.dentry->d_inode)
+		if(!res && (mode & S_IWOTH)
+		   && (IS_RDONLY(nd.dentry->d_inode) || MNT_IS_RDONLY(nd.mnt))
 		   && !special_file(nd.dentry->d_inode->i_mode))
 			res = -EROFS;
 		path_release(&nd);
@@ -616,7 +617,7 @@ asmlinkage long sys_fchmod(unsigned int 
 	inode = dentry->d_inode;
 
 	err = -EROFS;
-	if (IS_RDONLY(inode))
+	if (IS_RDONLY(inode) || MNT_IS_RDONLY(file->f_vfsmnt))
 		goto out_putf;
 	err = -EPERM;
 	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
@@ -648,7 +649,7 @@ asmlinkage long sys_chmod(const char __u
 	inode = nd.dentry->d_inode;
 
 	error = -EROFS;
-	if (IS_RDONLY(inode))
+	if (IS_RDONLY(inode) || MNT_IS_RDONLY(nd.mnt))
 		goto dput_and_out;
 
 	error = -EPERM;
diff -NurpP --minimal linux-2.6.16-rc1/fs/reiserfs/ioctl.c linux-2.6.16-rc1-bme0.06.2-ro0.02/fs/reiserfs/ioctl.c
--- linux-2.6.16-rc1/fs/reiserfs/ioctl.c	2006-01-18 06:08:34 +0100
+++ linux-2.6.16-rc1-bme0.06.2-ro0.02/fs/reiserfs/ioctl.c	2006-01-21 09:09:32 +0100
@@ -4,6 +4,7 @@
 
 #include <linux/capability.h>
 #include <linux/fs.h>
+#include <linux/mount.h>
 #include <linux/reiserfs_fs.h>
 #include <linux/time.h>
 #include <asm/uaccess.h>
@@ -47,7 +48,8 @@ int reiserfs_ioctl(struct inode *inode, 
 			if (!reiserfs_attrs(inode->i_sb))
 				return -ENOTTY;
 
-			if (IS_RDONLY(inode))
+			if (IS_RDONLY(inode) ||
+				(filp && MNT_IS_RDONLY(filp->f_vfsmnt)))
 				return -EROFS;
 
 			if ((current->fsuid != inode->i_uid)
@@ -82,7 +84,8 @@ int reiserfs_ioctl(struct inode *inode, 
 	case REISERFS_IOC_SETVERSION:
 		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
 			return -EPERM;
-		if (IS_RDONLY(inode))
+		if (IS_RDONLY(inode) ||
+			(filp && MNT_IS_RDONLY(filp->f_vfsmnt)))
 			return -EROFS;
 		if (get_user(inode->i_generation, (int __user *)arg))
 			return -EFAULT;
diff -NurpP --minimal linux-2.6.16-rc1/fs/reiserfs/xattr.c linux-2.6.16-rc1-bme0.06.2-ro0.02/fs/reiserfs/xattr.c
--- linux-2.6.16-rc1/fs/reiserfs/xattr.c	2006-01-18 06:08:34 +0100
+++ linux-2.6.16-rc1-bme0.06.2-ro0.02/fs/reiserfs/xattr.c	2006-01-21 09:09:32 +0100
@@ -1332,7 +1332,7 @@ __reiserfs_permission(struct inode *inod
 		/*
 		 * Nobody gets write access to a read-only fs.
 		 */
-		if (IS_RDONLY(inode) &&
+		if ((IS_RDONLY(inode) || (nd && MNT_IS_RDONLY(nd->mnt))) &&
 		    (S_ISREG(mode) || S_ISDIR(mode) || S_ISLNK(mode)))
 			return -EROFS;
 

