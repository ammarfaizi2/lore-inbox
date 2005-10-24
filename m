Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbVJXQve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbVJXQve (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 12:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbVJXQvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 12:51:33 -0400
Received: from 253-121.adsl.pool.ew.hu ([193.226.253.121]:5395 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751156AbVJXQvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 12:51:33 -0400
To: akpm@osdl.org
CC: viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/8] VFS: pass file pointer to filesystem from ftruncate()
Message-Id: <E1EU5XO-0005rf-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 24 Oct 2005 18:51:06 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch extends the iattr structure with a file pointer memeber,
and adds an ATTR_FILE validity flag for this member.

This is set if do_truncate() is invoked from ftruncate() or from
do_coredump().

The change is source and binary compatible.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/namei.c
===================================================================
--- linux.orig/fs/namei.c	2005-10-24 12:11:04.000000000 +0200
+++ linux/fs/namei.c	2005-10-24 14:13:40.000000000 +0200
@@ -1459,7 +1459,7 @@ int may_open(struct nameidata *nd, int a
 		if (!error) {
 			DQUOT_INIT(inode);
 			
-			error = do_truncate(dentry, 0);
+			error = do_truncate(dentry, 0, NULL);
 		}
 		put_write_access(inode);
 		if (error)
Index: linux/include/linux/fs.h
===================================================================
--- linux.orig/include/linux/fs.h	2005-10-24 12:11:05.000000000 +0200
+++ linux/include/linux/fs.h	2005-10-24 14:13:40.000000000 +0200
@@ -266,6 +266,7 @@ typedef void (dio_iodone_t)(struct kiocb
 #define ATTR_ATTR_FLAG	1024
 #define ATTR_KILL_SUID	2048
 #define ATTR_KILL_SGID	4096
+#define ATTR_FILE	8192
 
 /*
  * This is the Inode Attributes structure, used for notify_change().  It
@@ -285,6 +286,13 @@ struct iattr {
 	struct timespec	ia_atime;
 	struct timespec	ia_mtime;
 	struct timespec	ia_ctime;
+
+	/*
+	 * Not an attribute, but an auxilary info for filesystems wanting to
+	 * implement an ftruncate() like method.  NOTE: filesystem should
+	 * check for (ia_valid & ATTR_FILE), and not for (ia_file != NULL).
+	 */
+	struct file	*ia_file;
 };
 
 /*
@@ -1295,7 +1303,7 @@ static inline int break_lease(struct ino
 
 /* fs/open.c */
 
-extern int do_truncate(struct dentry *, loff_t start);
+extern int do_truncate(struct dentry *, loff_t start, struct file *filp);
 extern long do_sys_open(const char __user *filename, int flags, int mode);
 extern struct file *filp_open(const char *, int, int);
 extern struct file * dentry_open(struct dentry *, struct vfsmount *, int);
Index: linux/fs/exec.c
===================================================================
--- linux.orig/fs/exec.c	2005-10-24 12:11:04.000000000 +0200
+++ linux/fs/exec.c	2005-10-24 14:13:40.000000000 +0200
@@ -1510,7 +1510,7 @@ int do_coredump(long signr, int exit_cod
 		goto close_fail;
 	if (!file->f_op->write)
 		goto close_fail;
-	if (do_truncate(file->f_dentry, 0) != 0)
+	if (do_truncate(file->f_dentry, 0, file) != 0)
 		goto close_fail;
 
 	retval = binfmt->core_dump(signr, regs, file);
Index: linux/fs/open.c
===================================================================
--- linux.orig/fs/open.c	2005-10-24 12:11:04.000000000 +0200
+++ linux/fs/open.c	2005-10-24 14:13:40.000000000 +0200
@@ -194,7 +194,7 @@ out:
 	return error;
 }
 
-int do_truncate(struct dentry *dentry, loff_t length)
+int do_truncate(struct dentry *dentry, loff_t length, struct file *filp)
 {
 	int err;
 	struct iattr newattrs;
@@ -205,6 +205,10 @@ int do_truncate(struct dentry *dentry, l
 
 	newattrs.ia_size = length;
 	newattrs.ia_valid = ATTR_SIZE | ATTR_CTIME;
+	if (filp) {
+		newattrs.ia_file = filp;
+		newattrs.ia_valid |= ATTR_FILE;
+	}
 
 	down(&dentry->d_inode->i_sem);
 	err = notify_change(dentry, &newattrs);
@@ -262,7 +266,7 @@ static inline long do_sys_truncate(const
 	error = locks_verify_truncate(inode, NULL, length);
 	if (!error) {
 		DQUOT_INIT(inode);
-		error = do_truncate(nd.dentry, length);
+		error = do_truncate(nd.dentry, length, NULL);
 	}
 	put_write_access(inode);
 
@@ -314,7 +318,7 @@ static inline long do_sys_ftruncate(unsi
 
 	error = locks_verify_truncate(inode, file, length);
 	if (!error)
-		error = do_truncate(dentry, length);
+		error = do_truncate(dentry, length, file);
 out_putf:
 	fput(file);
 out:
