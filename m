Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbWDJVTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbWDJVTu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 17:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbWDJVTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 17:19:50 -0400
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:48534 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751189AbWDJVTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 17:19:49 -0400
To: akpm@osdl.org
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       viro@ftp.linux.org.uk
Subject: [PATCH 1/2] vfs: add lock owner argument to flush operation
Message-Id: <E1FT3n4-0006fN-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 10 Apr 2006 23:19:18 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pass the POSIX lock owner ID to the flush operation.

This is useful for filesystems which don't want to store any locking
state in inode->i_flock but want to handle locking/unlocking POSIX
locks internally.  FUSE is one such filesystem but I think it possible
that some network filesystems would need this also.

Also add a flag to indicate that a POSIX locking request was generated
by close(), so filesystems using the above feature won't send an extra
locking request in this case.

f_op->flush() is only called from filp_close().  Since the added
argument may safely be ignored by filesystems the API/ABI remains
backward compatible.  Only a compile time warning is generated if the
signature of the flush method is old.  The next patch fixes up all the
in-tree uses of flush(), out-of-tree uses can migrate at will.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/include/linux/fs.h
===================================================================
--- linux.orig/include/linux/fs.h	2006-04-09 11:17:01.000000000 +0200
+++ linux/include/linux/fs.h	2006-04-09 11:18:58.000000000 +0200
@@ -679,6 +679,7 @@ extern spinlock_t files_lock;
 #define FL_FLOCK	2
 #define FL_ACCESS	8	/* not trying to lock, just looking */
 #define FL_LEASE	32	/* lease held on this file */
+#define FL_CLOSE	64	/* unlock on close */
 #define FL_SLEEP	128	/* A blocking lock */
 
 /*
@@ -1025,7 +1026,7 @@ struct file_operations {
 	long (*compat_ioctl) (struct file *, unsigned int, unsigned long);
 	int (*mmap) (struct file *, struct vm_area_struct *);
 	int (*open) (struct inode *, struct file *);
-	int (*flush) (struct file *);
+	int (*flush) (struct file *, fl_owner_t id);
 	int (*release) (struct inode *, struct file *);
 	int (*fsync) (struct file *, struct dentry *, int datasync);
 	int (*aio_fsync) (struct kiocb *, int datasync);
Index: linux/fs/locks.c
===================================================================
--- linux.orig/fs/locks.c	2006-04-09 11:17:58.000000000 +0200
+++ linux/fs/locks.c	2006-04-09 11:18:58.000000000 +0200
@@ -1902,7 +1902,7 @@ void locks_remove_posix(struct file *fil
 		return;
 
 	lock.fl_type = F_UNLCK;
-	lock.fl_flags = FL_POSIX;
+	lock.fl_flags = FL_POSIX | FL_CLOSE;
 	lock.fl_start = 0;
 	lock.fl_end = OFFSET_MAX;
 	lock.fl_owner = owner;
Index: linux/fs/open.c
===================================================================
--- linux.orig/fs/open.c	2006-04-09 11:17:01.000000000 +0200
+++ linux/fs/open.c	2006-04-09 11:18:58.000000000 +0200
@@ -1137,7 +1137,7 @@ int filp_close(struct file *filp, fl_own
 	}
 
 	if (filp->f_op && filp->f_op->flush)
-		retval = filp->f_op->flush(filp);
+		retval = filp->f_op->flush(filp, id);
 
 	dnotify_flush(filp, id);
 	locks_remove_posix(filp, id);
