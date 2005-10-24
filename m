Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbVJXQ54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbVJXQ54 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 12:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbVJXQ54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 12:57:56 -0400
Received: from 253-121.adsl.pool.ew.hu ([193.226.253.121]:4618 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751160AbVJXQ5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 12:57:55 -0400
To: akpm@osdl.org
CC: viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/8] VFS: per inode statfs (architectures)
Message-Id: <E1EU5dk-0005td-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 24 Oct 2005 18:57:40 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the calls of vfs_statfs() to vfs_dentry_statfs() in
all architectures.  The only remaining call to vfs_statfs() is from
sys_ustat().

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/arch/alpha/kernel/osf_sys.c
===================================================================
--- linux.orig/arch/alpha/kernel/osf_sys.c	2005-10-24 12:10:00.000000000 +0200
+++ linux/arch/alpha/kernel/osf_sys.c	2005-10-24 14:21:44.000000000 +0200
@@ -244,7 +244,7 @@ do_osf_statfs(struct dentry * dentry, st
 	      unsigned long bufsiz)
 {
 	struct kstatfs linux_stat;
-	int error = vfs_statfs(dentry->d_inode->i_sb, &linux_stat);
+	int error = vfs_dentry_statfs(dentry, &linux_stat);
 	if (!error)
 		error = linux_to_osf_statfs(&linux_stat, buffer, bufsiz);
 	return error;	
Index: linux/arch/parisc/hpux/sys_hpux.c
===================================================================
--- linux.orig/arch/parisc/hpux/sys_hpux.c	2005-10-24 11:58:25.000000000 +0200
+++ linux/arch/parisc/hpux/sys_hpux.c	2005-10-24 14:21:44.000000000 +0200
@@ -185,12 +185,12 @@ struct hpux_statfs {
      int16_t f_pad;
 };
 
-static int vfs_statfs_hpux(struct super_block *sb, struct hpux_statfs *buf)
+static int vfs_statfs_hpux(struct dentry *dentry, struct hpux_statfs *buf)
 {
 	struct kstatfs st;
 	int retval;
 	
-	retval = vfs_statfs(sb, &st);
+	retval = vfs_dentry_statfs(dentry, &st);
 	if (retval)
 		return retval;
 
@@ -218,7 +218,7 @@ asmlinkage long hpux_statfs(const char _
 	error = user_path_walk(path, &nd);
 	if (!error) {
 		struct hpux_statfs tmp;
-		error = vfs_statfs_hpux(nd.dentry->d_inode->i_sb, &tmp);
+		error = vfs_statfs_hpux(nd.dentry, &tmp);
 		if (!error && copy_to_user(buf, &tmp, sizeof(tmp)))
 			error = -EFAULT;
 		path_release(&nd);
@@ -236,7 +236,7 @@ asmlinkage long hpux_fstatfs(unsigned in
 	file = fget(fd);
 	if (!file)
 		goto out;
-	error = vfs_statfs_hpux(file->f_dentry->d_inode->i_sb, &tmp);
+	error = vfs_statfs_hpux(file->f_dentry, &tmp);
 	if (!error && copy_to_user(buf, &tmp, sizeof(tmp)))
 		error = -EFAULT;
 	fput(file);
Index: linux/arch/sparc64/solaris/fs.c
===================================================================
--- linux.orig/arch/sparc64/solaris/fs.c	2005-10-24 11:58:25.000000000 +0200
+++ linux/arch/sparc64/solaris/fs.c	2005-10-24 14:21:44.000000000 +0200
@@ -349,13 +349,14 @@ struct sol_statvfs64 {
 	u32	f_filler[16];
 };
 
-static int report_statvfs(struct vfsmount *mnt, struct inode *inode, u32 buf)
+static int report_statvfs(struct vfsmount *mnt, struct dentry *dentry, u32 buf)
 {
+	struct inode *inode = dentry->d_inode;
 	struct kstatfs s;
 	int error;
 	struct sol_statvfs __user *ss = A(buf);
 
-	error = vfs_statfs(mnt->mnt_sb, &s);
+	error = vfs_dentry_statfs(dentry, &s);
 	if (!error) {
 		const char *p = mnt->mnt_sb->s_type->name;
 		int i = 0;
@@ -385,13 +386,14 @@ static int report_statvfs(struct vfsmoun
 	return error;
 }
 
-static int report_statvfs64(struct vfsmount *mnt, struct inode *inode, u32 buf)
+static int report_statvfs64(struct vfsmount *mnt, struct dentry *dentry, u32 buf)
 {
+	struct inode *inode = dentry->d_inode;
 	struct kstatfs s;
 	int error;
 	struct sol_statvfs64 __user *ss = A(buf);
 			
-	error = vfs_statfs(mnt->mnt_sb, &s);
+	error = vfs_dentry_statfs(dentry, &s);
 	if (!error) {
 		const char *p = mnt->mnt_sb->s_type->name;
 		int i = 0;
@@ -428,8 +430,7 @@ asmlinkage int solaris_statvfs(u32 path,
 
 	error = user_path_walk(A(path),&nd);
 	if (!error) {
-		struct inode * inode = nd.dentry->d_inode;
-		error = report_statvfs(nd.mnt, inode, buf);
+		error = report_statvfs(nd.mnt, nd.dentry, buf);
 		path_release(&nd);
 	}
 	return error;
@@ -443,7 +444,7 @@ asmlinkage int solaris_fstatvfs(unsigned
 	error = -EBADF;
 	file = fget(fd);
 	if (file) {
-		error = report_statvfs(file->f_vfsmnt, file->f_dentry->d_inode, buf);
+		error = report_statvfs(file->f_vfsmnt, file->f_dentry, buf);
 		fput(file);
 	}
 
@@ -458,8 +459,7 @@ asmlinkage int solaris_statvfs64(u32 pat
 	lock_kernel();
 	error = user_path_walk(A(path), &nd);
 	if (!error) {
-		struct inode * inode = nd.dentry->d_inode;
-		error = report_statvfs64(nd.mnt, inode, buf);
+		error = report_statvfs64(nd.mnt, nd.dentry, buf);
 		path_release(&nd);
 	}
 	unlock_kernel();
@@ -475,7 +475,7 @@ asmlinkage int solaris_fstatvfs64(unsign
 	file = fget(fd);
 	if (file) {
 		lock_kernel();
-		error = report_statvfs64(file->f_vfsmnt, file->f_dentry->d_inode, buf);
+		error = report_statvfs64(file->f_vfsmnt, file->f_dentry, buf);
 		unlock_kernel();
 		fput(file);
 	}
Index: linux/arch/mips/kernel/sysirix.c
===================================================================
--- linux.orig/arch/mips/kernel/sysirix.c	2005-10-24 12:11:02.000000000 +0200
+++ linux/arch/mips/kernel/sysirix.c	2005-10-24 14:21:45.000000000 +0200
@@ -713,7 +713,7 @@ asmlinkage int irix_statfs(const char __
 	if (error)
 		goto out;
 
-	error = vfs_statfs(nd.dentry->d_inode->i_sb, &kbuf);
+	error = vfs_dentry_statfs(nd.dentry, &kbuf);
 	if (error)
 		goto dput_and_out;
 
@@ -751,7 +751,7 @@ asmlinkage int irix_fstatfs(unsigned int
 		goto out;
 	}
 
-	error = vfs_statfs(file->f_dentry->d_inode->i_sb, &kbuf);
+	error = vfs_dentry_statfs(file->f_dentry, &kbuf);
 	if (error)
 		goto out_f;
 
@@ -1379,7 +1379,7 @@ asmlinkage int irix_statvfs(char __user 
 	error = user_path_walk(fname, &nd);
 	if (error)
 		goto out;
-	error = vfs_statfs(nd.dentry->d_inode->i_sb, &kbuf);
+	error = vfs_dentry_statfs(nd.dentry, &kbuf);
 	if (error)
 		goto dput_and_out;
 
@@ -1425,7 +1425,7 @@ asmlinkage int irix_fstatvfs(int fd, str
 		error = -EBADF;
 		goto out;
 	}
-	error = vfs_statfs(file->f_dentry->d_inode->i_sb, &kbuf);
+	error = vfs_dentry_statfs(file->f_dentry, &kbuf);
 	if (error)
 		goto out_f;
 
@@ -1630,7 +1630,7 @@ asmlinkage int irix_statvfs64(char __use
 	error = user_path_walk(fname, &nd);
 	if (error)
 		goto out;
-	error = vfs_statfs(nd.dentry->d_inode->i_sb, &kbuf);
+	error = vfs_dentry_statfs(nd.dentry, &kbuf);
 	if (error)
 		goto dput_and_out;
 
@@ -1677,7 +1677,7 @@ asmlinkage int irix_fstatvfs64(int fd, s
 		error = -EBADF;
 		goto out;
 	}
-	error = vfs_statfs(file->f_dentry->d_inode->i_sb, &kbuf);
+	error = vfs_dentry_statfs(file->f_dentry, &kbuf);
 	if (error)
 		goto out_f;
 

