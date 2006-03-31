Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbWCaR2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbWCaR2u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 12:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbWCaR2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 12:28:50 -0500
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:39094 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932116AbWCaR2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 12:28:49 -0500
To: akpm@osdl.org
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-reply-to: <E1FPNOD-0005Tg-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Fri, 31 Mar 2006 19:26:25 +0200)
Subject: Re: [PATCH 1/4] locks: export raw __posix_lock_file() interface
References: <E1FPNOD-0005Tg-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1FPNQI-0005Uf-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 31 Mar 2006 19:28:34 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FUSE file locking needs to pass an inode to posix_lock_file() which is
actually the interface provided by __posix_lock_file().

This patch exports __posix_lock_file() and makes posix_lock_file() an
inline function since it doesn't actually do anything other than get
the inode from the file pointer.

Since the posix_lock_file_conf() export was just recently added, move
the single user of it to the __posix_lock_file() interface, thus
actually decreasing the number of exported functions.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/locks.c
===================================================================
--- linux.orig/fs/locks.c	2006-03-31 18:55:10.000000000 +0200
+++ linux/fs/locks.c	2006-03-31 18:55:33.000000000 +0200
@@ -781,7 +781,18 @@ out:
 	return error;
 }
 
-static int __posix_lock_file_conf(struct inode *inode, struct file_lock *request, struct file_lock *conflock)
+/**
+ * posix_lock_file - Apply a POSIX-style lock to a file
+ * @filp: The file to apply the lock to
+ * @fl: The lock to be applied
+ * @conflock: Place to return a copy of the conflicting lock, if found.
+ *
+ * Add a POSIX style lock to a file.
+ * We merge adjacent & overlapping locks whenever possible.
+ * POSIX locks are sorted by owner task, then by starting address
+ */
+int __posix_lock_file(struct inode *inode, struct file_lock *request,
+		      struct file_lock *conflock)
 {
 	struct file_lock *fl;
 	struct file_lock *new_fl, *new_fl2;
@@ -964,36 +975,7 @@ static int __posix_lock_file_conf(struct
 		locks_free_lock(new_fl2);
 	return error;
 }
-
-/**
- * posix_lock_file - Apply a POSIX-style lock to a file
- * @filp: The file to apply the lock to
- * @fl: The lock to be applied
- *
- * Add a POSIX style lock to a file.
- * We merge adjacent & overlapping locks whenever possible.
- * POSIX locks are sorted by owner task, then by starting address
- */
-int posix_lock_file(struct file *filp, struct file_lock *fl)
-{
-	return __posix_lock_file_conf(filp->f_dentry->d_inode, fl, NULL);
-}
-EXPORT_SYMBOL(posix_lock_file);
-
-/**
- * posix_lock_file_conf - Apply a POSIX-style lock to a file
- * @filp: The file to apply the lock to
- * @fl: The lock to be applied
- * @conflock: Place to return a copy of the conflicting lock, if found.
- *
- * Except for the conflock parameter, acts just like posix_lock_file.
- */
-int posix_lock_file_conf(struct file *filp, struct file_lock *fl,
-			struct file_lock *conflock)
-{
-	return __posix_lock_file_conf(filp->f_dentry->d_inode, fl, conflock);
-}
-EXPORT_SYMBOL(posix_lock_file_conf);
+EXPORT_SYMBOL(__posix_lock_file);
 
 /**
  * posix_lock_file_wait - Apply a POSIX-style lock to a file
@@ -1081,7 +1063,7 @@ int locks_mandatory_area(int read_write,
 	fl.fl_end = offset + count - 1;
 
 	for (;;) {
-		error = __posix_lock_file_conf(inode, &fl, NULL);
+		error = __posix_lock_file(inode, &fl, NULL);
 		if (error != -EAGAIN)
 			break;
 		if (!(fl.fl_flags & FL_SLEEP))
Index: linux/fs/nfsd/nfs4state.c
===================================================================
--- linux.orig/fs/nfsd/nfs4state.c	2006-03-31 18:55:10.000000000 +0200
+++ linux/fs/nfsd/nfs4state.c	2006-03-31 18:55:33.000000000 +0200
@@ -2754,7 +2754,8 @@ nfsd4_lock(struct svc_rqst *rqstp, struc
 	 * locks_copy_lock: */
 	conflock.fl_ops = NULL;
 	conflock.fl_lmops = NULL;
-	status = posix_lock_file_conf(filp, &file_lock, &conflock);
+	status = __posix_lock_file(filp->f_dentry->d_inode, &file_lock,
+				   &conflock);
 	dprintk("NFSD: nfsd4_lock: posix_lock_file_conf status %d\n",status);
 	switch (-status) {
 	case 0: /* success! */
Index: linux/include/linux/fs.h
===================================================================
--- linux.orig/include/linux/fs.h	2006-03-31 18:55:10.000000000 +0200
+++ linux/include/linux/fs.h	2006-03-31 18:55:33.000000000 +0200
@@ -763,8 +763,7 @@ extern void locks_copy_lock(struct file_
 extern void locks_remove_posix(struct file *, fl_owner_t);
 extern void locks_remove_flock(struct file *);
 extern int posix_test_lock(struct file *, struct file_lock *, struct file_lock *);
-extern int posix_lock_file_conf(struct file *, struct file_lock *, struct file_lock *);
-extern int posix_lock_file(struct file *, struct file_lock *);
+extern int __posix_lock_file(struct inode *, struct file_lock *, struct file_lock *);
 extern int posix_lock_file_wait(struct file *, struct file_lock *);
 extern int posix_unblock_lock(struct file *, struct file_lock *);
 extern int flock_lock_file_wait(struct file *filp, struct file_lock *fl);
@@ -775,6 +774,11 @@ extern int lease_modify(struct file_lock
 extern int lock_may_read(struct inode *, loff_t start, unsigned long count);
 extern int lock_may_write(struct inode *, loff_t start, unsigned long count);
 
+static inline int posix_lock_file(struct file *filp, struct file_lock *fl)
+{
+	return __posix_lock_file(filp->f_dentry->d_inode, fl, NULL);
+}
+
 struct fasync_struct {
 	int	magic;
 	int	fa_fd;
