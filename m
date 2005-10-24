Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbVJXQzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbVJXQzh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 12:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbVJXQzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 12:55:37 -0400
Received: from 253-121.adsl.pool.ew.hu ([193.226.253.121]:29189 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751163AbVJXQzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 12:55:36 -0400
To: akpm@osdl.org
CC: viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/8] VFS: per inode statfs (core)
Message-Id: <E1EU5bT-0005sq-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 24 Oct 2005 18:55:19 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a statfs method to inode operations.  This is invoked
whenever the dentry is available (not called from sys_ustat()) and the
filesystem implements this method.  Otherwise the normal
s_op->statfs() will be called.

This change is backward compatible, but calls to vfs_statfs() should
be changed to vfs_dentry_statfs() whenever possible.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/include/linux/fs.h
===================================================================
--- linux.orig/include/linux/fs.h	2005-10-24 14:13:40.000000000 +0200
+++ linux/include/linux/fs.h	2005-10-24 14:21:37.000000000 +0200
@@ -1012,6 +1012,7 @@ struct inode_operations {
 	ssize_t (*getxattr) (struct dentry *, const char *, void *, size_t);
 	ssize_t (*listxattr) (struct dentry *, char *, size_t);
 	int (*removexattr) (struct dentry *, const char *);
+	int (*statfs) (struct dentry *, struct kstatfs *);
 };
 
 struct seq_file;
@@ -1256,7 +1257,9 @@ extern int may_umount_tree(struct vfsmou
 extern int may_umount(struct vfsmount *);
 extern long do_mount(char *, char *, char *, unsigned long, void *);
 
+/* vfs_statfs() is deprecated, use vfs_dentry_statfs() instead */
 extern int vfs_statfs(struct super_block *, struct kstatfs *);
+extern int vfs_dentry_statfs(struct dentry *, struct kstatfs *);
 
 #define FLOCK_VERIFY_READ  1
 #define FLOCK_VERIFY_WRITE 2
Index: linux/fs/open.c
===================================================================
--- linux.orig/fs/open.c	2005-10-24 14:13:40.000000000 +0200
+++ linux/fs/open.c	2005-10-24 14:21:37.000000000 +0200
@@ -49,12 +49,35 @@ int vfs_statfs(struct super_block *sb, s
 
 EXPORT_SYMBOL(vfs_statfs);
 
-static int vfs_statfs_native(struct super_block *sb, struct statfs *buf)
+int vfs_dentry_statfs(struct dentry *dentry, struct kstatfs *buf)
+{
+	struct inode *inode = dentry->d_inode;
+	int retval;
+
+	if (inode->i_op && inode->i_op->statfs) {
+		memset(buf, 0, sizeof(*buf));
+		retval = security_sb_statfs(inode->i_sb);
+		if (retval)
+			return retval;
+
+		retval = inode->i_op->statfs(dentry, buf);
+
+		if (retval == 0 && buf->f_frsize == 0)
+			buf->f_frsize = buf->f_bsize;
+	} else
+		retval = vfs_statfs(inode->i_sb, buf);
+
+	return retval;
+}
+
+EXPORT_SYMBOL(vfs_dentry_statfs);
+
+static int vfs_statfs_native(struct dentry *dentry, struct statfs *buf)
 {
 	struct kstatfs st;
 	int retval;
 
-	retval = vfs_statfs(sb, &st);
+	retval = vfs_dentry_statfs(dentry, &st);
 	if (retval)
 		return retval;
 
@@ -92,12 +115,12 @@ static int vfs_statfs_native(struct supe
 	return 0;
 }
 
-static int vfs_statfs64(struct super_block *sb, struct statfs64 *buf)
+static int vfs_statfs64(struct dentry *dentry, struct statfs64 *buf)
 {
 	struct kstatfs st;
 	int retval;
 
-	retval = vfs_statfs(sb, &st);
+	retval = vfs_dentry_statfs(dentry, &st);
 	if (retval)
 		return retval;
 
@@ -127,7 +150,7 @@ asmlinkage long sys_statfs(const char __
 	error = user_path_walk(path, &nd);
 	if (!error) {
 		struct statfs tmp;
-		error = vfs_statfs_native(nd.dentry->d_inode->i_sb, &tmp);
+		error = vfs_statfs_native(nd.dentry, &tmp);
 		if (!error && copy_to_user(buf, &tmp, sizeof(tmp)))
 			error = -EFAULT;
 		path_release(&nd);
@@ -146,7 +169,7 @@ asmlinkage long sys_statfs64(const char 
 	error = user_path_walk(path, &nd);
 	if (!error) {
 		struct statfs64 tmp;
-		error = vfs_statfs64(nd.dentry->d_inode->i_sb, &tmp);
+		error = vfs_statfs64(nd.dentry, &tmp);
 		if (!error && copy_to_user(buf, &tmp, sizeof(tmp)))
 			error = -EFAULT;
 		path_release(&nd);
@@ -165,7 +188,7 @@ asmlinkage long sys_fstatfs(unsigned int
 	file = fget(fd);
 	if (!file)
 		goto out;
-	error = vfs_statfs_native(file->f_dentry->d_inode->i_sb, &tmp);
+	error = vfs_statfs_native(file->f_dentry, &tmp);
 	if (!error && copy_to_user(buf, &tmp, sizeof(tmp)))
 		error = -EFAULT;
 	fput(file);
@@ -186,7 +209,7 @@ asmlinkage long sys_fstatfs64(unsigned i
 	file = fget(fd);
 	if (!file)
 		goto out;
-	error = vfs_statfs64(file->f_dentry->d_inode->i_sb, &tmp);
+	error = vfs_statfs64(file->f_dentry, &tmp);
 	if (!error && copy_to_user(buf, &tmp, sizeof(tmp)))
 		error = -EFAULT;
 	fput(file);
Index: linux/fs/nfsd/vfs.c
===================================================================
--- linux.orig/fs/nfsd/vfs.c	2005-10-24 12:11:04.000000000 +0200
+++ linux/fs/nfsd/vfs.c	2005-10-24 14:21:37.000000000 +0200
@@ -1740,7 +1740,7 @@ int
 nfsd_statfs(struct svc_rqst *rqstp, struct svc_fh *fhp, struct kstatfs *stat)
 {
 	int err = fh_verify(rqstp, fhp, 0, MAY_NOP);
-	if (!err && vfs_statfs(fhp->fh_dentry->d_inode->i_sb,stat))
+	if (!err && vfs_dentry_statfs(fhp->fh_dentry, stat))
 		err = nfserr_io;
 	return err;
 }
Index: linux/fs/nfsd/nfs4xdr.c
===================================================================
--- linux.orig/fs/nfsd/nfs4xdr.c	2005-10-24 12:11:04.000000000 +0200
+++ linux/fs/nfsd/nfs4xdr.c	2005-10-24 14:21:37.000000000 +0200
@@ -1311,7 +1311,7 @@ nfsd4_encode_fattr(struct svc_fh *fhp, s
 	if ((bmval0 & (FATTR4_WORD0_FILES_FREE | FATTR4_WORD0_FILES_TOTAL)) ||
 	    (bmval1 & (FATTR4_WORD1_SPACE_AVAIL | FATTR4_WORD1_SPACE_FREE |
 		       FATTR4_WORD1_SPACE_TOTAL))) {
-		status = vfs_statfs(dentry->d_inode->i_sb, &statfs);
+		status = vfs_dentry_statfs(dentry, &statfs);
 		if (status)
 			goto out_nfserr;
 	}
Index: linux/fs/compat.c
===================================================================
--- linux.orig/fs/compat.c	2005-10-24 12:11:04.000000000 +0200
+++ linux/fs/compat.c	2005-10-24 14:21:37.000000000 +0200
@@ -167,7 +167,7 @@ asmlinkage long compat_sys_statfs(const 
 	error = user_path_walk(path, &nd);
 	if (!error) {
 		struct kstatfs tmp;
-		error = vfs_statfs(nd.dentry->d_inode->i_sb, &tmp);
+		error = vfs_dentry_statfs(nd.dentry, &tmp);
 		if (!error && put_compat_statfs(buf, &tmp))
 			error = -EFAULT;
 		path_release(&nd);
@@ -185,7 +185,7 @@ asmlinkage long compat_sys_fstatfs(unsig
 	file = fget(fd);
 	if (!file)
 		goto out;
-	error = vfs_statfs(file->f_dentry->d_inode->i_sb, &tmp);
+	error = vfs_dentry_statfs(file->f_dentry, &tmp);
 	if (!error && put_compat_statfs(buf, &tmp))
 		error = -EFAULT;
 	fput(file);
@@ -235,7 +235,7 @@ asmlinkage long compat_sys_statfs64(cons
 	error = user_path_walk(path, &nd);
 	if (!error) {
 		struct kstatfs tmp;
-		error = vfs_statfs(nd.dentry->d_inode->i_sb, &tmp);
+		error = vfs_dentry_statfs(nd.dentry, &tmp);
 		if (!error && put_compat_statfs64(buf, &tmp))
 			error = -EFAULT;
 		path_release(&nd);
@@ -256,7 +256,7 @@ asmlinkage long compat_sys_fstatfs64(uns
 	file = fget(fd);
 	if (!file)
 		goto out;
-	error = vfs_statfs(file->f_dentry->d_inode->i_sb, &tmp);
+	error = vfs_dentry_statfs(file->f_dentry, &tmp);
 	if (!error && put_compat_statfs64(buf, &tmp))
 		error = -EFAULT;
 	fput(file);
Index: linux/kernel/acct.c
===================================================================
--- linux.orig/kernel/acct.c	2005-10-24 12:11:05.000000000 +0200
+++ linux/kernel/acct.c	2005-10-24 14:21:37.000000000 +0200
@@ -116,7 +116,7 @@ static int check_free_space(struct file 
 	spin_unlock(&acct_globals.lock);
 
 	/* May block */
-	if (vfs_statfs(file->f_dentry->d_inode->i_sb, &sbuf))
+	if (vfs_dentry_statfs(file->f_dentry, &sbuf))
 		return res;
 	suspend = sbuf.f_blocks * SUSPEND;
 	resume = sbuf.f_blocks * RESUME;
