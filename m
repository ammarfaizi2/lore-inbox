Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265851AbSKTGlb>; Wed, 20 Nov 2002 01:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265857AbSKTGla>; Wed, 20 Nov 2002 01:41:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49156 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265851AbSKTGl1>;
	Wed, 20 Nov 2002 01:41:27 -0500
Date: Wed, 20 Nov 2002 06:48:31 +0000
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] rename get_lease to break_lease
Message-ID: <20021120064831.A12656@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Al pointed out that the current name of get_lease is extremely confusing
and I agree.  Here's a patch which (a) renames it to break_lease and
(b) fixes a bug noticed by Dave Hansen which could cause a NULL pointer
dereference under high load.

diff -urpNX dontdiff linux-2.5.48/fs/locks.c linux-2.5.48-flock/fs/locks.c
--- linux-2.5.48/fs/locks.c	2002-11-17 23:29:56.000000000 -0500
+++ linux-2.5.48-flock/fs/locks.c	2002-11-19 19:31:23.000000000 -0500
@@ -994,16 +990,16 @@ static void time_out_leases(struct inode
 }
 
 /**
- *	__get_lease	-	revoke all outstanding leases on file
+ *	__break_lease	-	revoke all outstanding leases on file
  *	@inode: the inode of the file to return
  *	@mode: the open mode (read or write)
  *
- *	get_lease (inlined for speed) has checked there already
+ *	break_lease (inlined for speed) has checked there already
  *	is a lease on this file.  Leases are broken on a call to open()
  *	or truncate().  This function can sleep unless you
  *	specified %O_NONBLOCK to your open().
  */
-int __get_lease(struct inode *inode, unsigned int mode)
+int __break_lease(struct inode *inode, unsigned int mode)
 {
 	int error = 0, future;
 	struct file_lock *new_fl, *flock;
diff -urpNX dontdiff linux-2.5.48/fs/namei.c linux-2.5.48-flock/fs/namei.c
--- linux-2.5.48/fs/namei.c	2002-11-17 23:29:30.000000000 -0500
+++ linux-2.5.48-flock/fs/namei.c	2002-11-19 17:02:36.000000000 -0500
@@ -1183,7 +1183,7 @@ int may_open(struct nameidata *nd, int a
 	/*
 	 * Ensure there are no outstanding leases on the file.
 	 */
-	error = get_lease(inode, flag);
+	error = break_lease(inode, flag);
 	if (error)
 		return error;
 
diff -urpNX dontdiff linux-2.5.48/fs/nfsd/vfs.c linux-2.5.48-flock/fs/nfsd/vfs.c
--- linux-2.5.48/fs/nfsd/vfs.c	2002-11-17 23:29:31.000000000 -0500
+++ linux-2.5.48-flock/fs/nfsd/vfs.c	2002-11-19 23:24:29.000000000 -0500
@@ -259,7 +259,7 @@ nfsd_setattr(struct svc_rqst *rqstp, str
 		 * If we are changing the size of the file, then
 		 * we need to break all leases.
 		 */
-		err = get_lease(inode, FMODE_WRITE);
+		err = break_lease(inode, FMODE_WRITE);
 		if (err)
 			goto out_nfserr;
 
@@ -453,7 +453,7 @@ nfsd_open(struct svc_rqst *rqstp, struct
 	 * Check to see if there are any leases on this file.
 	 * This may block while leases are broken.
 	 */
-	err = get_lease(inode, (access & MAY_WRITE) ? FMODE_WRITE : 0);
+	err = break_lease(inode, (access & MAY_WRITE) ? FMODE_WRITE : 0);
 	if (err)
 		goto out_nfserr;
 
diff -urpNX dontdiff linux-2.5.48/fs/open.c linux-2.5.48-flock/fs/open.c
--- linux-2.5.48/fs/open.c	2002-11-17 23:29:21.000000000 -0500
+++ linux-2.5.48-flock/fs/open.c	2002-11-19 17:03:23.000000000 -0500
@@ -131,7 +131,7 @@ static inline long do_sys_truncate(const
 	/*
 	 * Make sure that there are no leases.
 	 */
-	error = get_lease(inode, FMODE_WRITE);
+	error = break_lease(inode, FMODE_WRITE);
 	if (error)
 		goto dput_and_out;
 
diff -urpNX dontdiff linux-2.5.48/include/linux/fs.h linux-2.5.48-flock/include/linux/fs.h
--- linux-2.5.48/include/linux/fs.h	2002-11-17 23:29:29.000000000 -0500
+++ linux-2.5.48-flock/include/linux/fs.h	2002-11-19 19:24:41.000000000 -0500
@@ -578,7 +576,7 @@ extern int posix_lock_file(struct file *
 extern void posix_block_lock(struct file_lock *, struct file_lock *);
 extern void posix_unblock_lock(struct file *, struct file_lock *);
 extern int posix_locks_deadlock(struct file_lock *, struct file_lock *);
-extern int __get_lease(struct inode *inode, unsigned int flags);
+extern int __break_lease(struct inode *inode, unsigned int flags);
 extern void lease_get_mtime(struct inode *, struct timespec *time);
 extern int lock_may_read(struct inode *, loff_t start, unsigned long count);
 extern int lock_may_write(struct inode *, loff_t start, unsigned long count);
@@ -1052,10 +1086,10 @@ static inline int locks_verify_truncate(
 	return 0;
 }
 
-static inline int get_lease(struct inode *inode, unsigned int mode)
+static inline int break_lease(struct inode *inode, unsigned int mode)
 {
-	if (inode->i_flock && (inode->i_flock->fl_flags & FL_LEASE))
-		return __get_lease(inode, mode);
+	if (inode->i_flock)
+		return __break_lease(inode, mode);
 	return 0;
 }
 
diff -urpNX dontdiff linux-2.5.48/kernel/ksyms.c linux-2.5.48-flock/kernel/ksyms.c
--- linux-2.5.48/kernel/ksyms.c	2002-11-17 23:29:21.000000000 -0500
+++ linux-2.5.48-flock/kernel/ksyms.c	2002-11-19 23:13:47.000000000 -0500
@@ -287,7 +287,7 @@ EXPORT_SYMBOL(page_follow_link);
 EXPORT_SYMBOL(page_symlink_inode_operations);
 EXPORT_SYMBOL(page_symlink);
 EXPORT_SYMBOL(vfs_readdir);
-EXPORT_SYMBOL(__get_lease);
+EXPORT_SYMBOL(__break_lease);
 EXPORT_SYMBOL(lease_get_mtime);
 EXPORT_SYMBOL(lock_may_read);
 EXPORT_SYMBOL(lock_may_write);

-- 
Revolutions do not require corporate support.
