Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264756AbTAWAqf>; Wed, 22 Jan 2003 19:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264790AbTAWAqf>; Wed, 22 Jan 2003 19:46:35 -0500
Received: from [212.156.4.130] ([212.156.4.130]:22235 "EHLO fep01.ttnet.net.tr")
	by vger.kernel.org with ESMTP id <S264756AbTAWAqc>;
	Wed, 22 Jan 2003 19:46:32 -0500
Date: Thu, 23 Jan 2003 02:55:30 +0200
From: Faik Uygur <faikuygur@ttnet.net.tr>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com, robbiew@us.ibm.com
Subject: [PATCH] 2.5.59: ftruncate/truncate oopses with mandatory locking
Message-ID: <20030123005530.GA808@ttnet.net.tr>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	torvalds@transmeta.com, robbiew@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-9
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-PGP-Fingerprint: 15 C0 AA 31 59 F9 DE 4F 7D A6 C7 D8 A0 D5 67 73
X-PGP-Key-ID: 0x5C447959
X-PGP-Key-Size: 2048 bits
X-Editor: GNU Emacs 21.2.1
X-Operating-System: Debian GNU/Linux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the truncate/ftruncate oopses with mandatory locking
enabled. The problem with ftruncate is that the local variable fl is 
not initialized properly in locks_mandatory_area that it misbehaves at
various places like locks_insert_block. And the problem with truncate
is that the filp variable is NULL at posix_lock_file. The NULL value
comes from do_sys_truncate.

The bug report and details can be found at,
http://bugme.osdl.org/show_bug.cgi?id=280


diff -uNr linux-2.5.59-vanilla/fs/lockd/svclock.c linux-2.5.59/fs/lockd/svclock.c
--- linux-2.5.59-vanilla/fs/lockd/svclock.c	Thu Nov 28 00:35:55 2002
+++ linux-2.5.59/fs/lockd/svclock.c	Thu Jan 23 00:41:45 2003
@@ -315,7 +315,7 @@
 
 again:
 	if (!(conflock = posix_test_lock(&file->f_file, &lock->fl))) {
-		error = posix_lock_file(&file->f_file, &lock->fl);
+		error = posix_lock_file(file->f_file.f_dentry->d_inode, &lock->fl);
 
 		if (block)
 			nlmsvc_delete_block(block, 0);
@@ -419,7 +419,7 @@
 	nlmsvc_cancel_blocked(file, lock);
 
 	lock->fl.fl_type = F_UNLCK;
-	error = posix_lock_file(&file->f_file, &lock->fl);
+	error = posix_lock_file(file->f_file.f_dentry->d_inode, &lock->fl);
 
 	return (error < 0)? nlm_lck_denied_nolocks : nlm_granted;
 }
@@ -523,7 +523,7 @@
 	 * following yields an error, this is most probably due to low
 	 * memory. Retry the lock in a few seconds.
 	 */
-	if ((error = posix_lock_file(&file->f_file, &lock->fl)) < 0) {
+	if ((error = posix_lock_file(file->f_file.f_dentry->d_inode, &lock->fl)) < 0) {
 		printk(KERN_WARNING "lockd: unexpected error %d in %s!\n",
 				-error, __FUNCTION__);
 		nlmsvc_insert_block(block, 10 * HZ);
diff -uNr linux-2.5.59-vanilla/fs/lockd/svcsubs.c linux-2.5.59/fs/lockd/svcsubs.c
--- linux-2.5.59-vanilla/fs/lockd/svcsubs.c	Thu Nov 28 00:36:14 2002
+++ linux-2.5.59/fs/lockd/svcsubs.c	Thu Jan 23 01:01:51 2003
@@ -176,7 +176,7 @@
 			lock.fl_type  = F_UNLCK;
 			lock.fl_start = 0;
 			lock.fl_end   = OFFSET_MAX;
-			if (posix_lock_file(&file->f_file, &lock) < 0) {
+			if (posix_lock_file(file->f_file.f_dentry->d_inode, &lock) < 0) {
 				printk("lockd: unlock failure in %s:%d\n",
 						__FILE__, __LINE__);
 				return 1;
diff -uNr linux-2.5.59-vanilla/fs/locks.c linux-2.5.59/fs/locks.c
--- linux-2.5.59-vanilla/fs/locks.c	Thu Jan 23 00:02:16 2003
+++ linux-2.5.59/fs/locks.c	Thu Jan 23 01:58:16 2003
@@ -678,6 +678,10 @@
 	struct file_lock fl;
 	int error;
 
+	INIT_LIST_HEAD(&fl.fl_link);
+	INIT_LIST_HEAD(&fl.fl_block);
+	init_waitqueue_head(&fl.fl_wait);
+
 	fl.fl_owner = current->files;
 	fl.fl_pid = current->tgid;
 	fl.fl_file = filp;
@@ -685,9 +689,14 @@
 	fl.fl_type = (read_write == FLOCK_VERIFY_WRITE) ? F_WRLCK : F_RDLCK;
 	fl.fl_start = offset;
 	fl.fl_end = offset + count - 1;
+	fl.fl_next = NULL;
+	fl.fl_notify = NULL;
+	fl.fl_insert = NULL;
+	fl.fl_remove = NULL;
+	fl.fl_fasync = NULL;
 
 	for (;;) {
-		error = posix_lock_file(filp, &fl);
+		error = posix_lock_file(inode, &fl);
 		if (error != -EAGAIN)
 			break;
 		error = wait_event_interruptible(fl.fl_wait, !fl.fl_next);
@@ -772,9 +781,8 @@
 
 /**
  *	posix_lock_file:
- *	@filp: The file to apply the lock to
- *	@caller: The lock to be applied
- *	@wait: 1 to retry automatically, 0 to return -EAGAIN
+ *	@inode: The inode of file to apply the lock to
+ *	@request: The lock to be applied
  *
  * Add a POSIX style lock to a file.
  * We merge adjacent locks whenever possible. POSIX locks are sorted by owner
@@ -788,14 +796,13 @@
  * To all purists: Yes, I use a few goto's. Just pass on to the next function.
  */
 
-int posix_lock_file(struct file *filp, struct file_lock *request)
+int posix_lock_file(struct inode *inode, struct file_lock *request)
 {
 	struct file_lock *fl;
 	struct file_lock *new_fl, *new_fl2;
 	struct file_lock *left = NULL;
 	struct file_lock *right = NULL;
 	struct file_lock **before;
-	struct inode * inode = filp->f_dentry->d_inode;
 	int error, added = 0;
 
 	/*
@@ -1460,7 +1467,7 @@
 	}
 
 	for (;;) {
-		error = posix_lock_file(filp, file_lock);
+		error = posix_lock_file(inode, file_lock);
 		if ((error != -EAGAIN) || (cmd == F_SETLK))
 			break;
 		error = wait_event_interruptible(file_lock->fl_wait,
@@ -1600,7 +1607,7 @@
 	}
 
 	for (;;) {
-		error = posix_lock_file(filp, file_lock);
+		error = posix_lock_file(inode, file_lock);
 		if ((error != -EAGAIN) || (cmd == F_SETLK64))
 			break;
 		error = wait_event_interruptible(file_lock->fl_wait,
@@ -1650,7 +1657,7 @@
 		/* Ignore any error -- we must remove the locks anyway */
 	}
 
-	posix_lock_file(filp, &lock);
+	posix_lock_file(filp->f_dentry->d_inode, &lock);
 }
 
 /*
@@ -1717,7 +1724,7 @@
 	} else {
 		unlock_kernel();
 		waiter->fl_type = F_UNLCK;
-		posix_lock_file(filp, waiter);
+		posix_lock_file(filp->f_dentry->d_inode, waiter);
 	}
 }
 
diff -uNr linux-2.5.59-vanilla/include/linux/fs.h linux-2.5.59/include/linux/fs.h
--- linux-2.5.59-vanilla/include/linux/fs.h	Thu Jan 23 00:02:44 2003
+++ linux-2.5.59/include/linux/fs.h	Thu Jan 23 00:48:25 2003
@@ -568,7 +568,7 @@
 extern void locks_remove_posix(struct file *, fl_owner_t);
 extern void locks_remove_flock(struct file *);
 extern struct file_lock *posix_test_lock(struct file *, struct file_lock *);
-extern int posix_lock_file(struct file *, struct file_lock *);
+extern int posix_lock_file(struct inode *, struct file_lock *);
 extern void posix_block_lock(struct file_lock *, struct file_lock *);
 extern void posix_unblock_lock(struct file *, struct file_lock *);
 extern int posix_locks_deadlock(struct file_lock *, struct file_lock *);
