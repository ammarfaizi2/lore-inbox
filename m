Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268555AbTBMUav>; Thu, 13 Feb 2003 15:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268557AbTBMUau>; Thu, 13 Feb 2003 15:30:50 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51473 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S268555AbTBMUaq>;
	Thu, 13 Feb 2003 15:30:46 -0500
Date: Thu, 13 Feb 2003 20:40:31 +0000
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
       robbiew@us.ibm.com
Subject: [PATCH] Fix mandatory locking
Message-ID: <20030213204031.I5992@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Robbie Williamson found some bugs in the mandatory locking implementation.
This patch fixes all the problems he found:

 - Fix null pointer dereference caused by sys_truncate() passing a null filp.
 - Honour the O_NONBLOCK flag when calling ftruncate()
 - Local variable `fl' wasn't being initialised correctly in 
   locks_mandatory_area()
 - Don't return -ENOLCK from __posix_lock_file() when FL_ACCESS is set.

Index: fs/locks.c
===================================================================
RCS file: /var/cvs/linux-2.5/fs/locks.c,v
retrieving revision 1.8
diff -u -p -r1.8 locks.c
--- fs/locks.c	10 Dec 2002 22:03:03 -0000	1.8
+++ fs/locks.c	13 Feb 2003 17:25:01 -0000
@@ -652,63 +652,6 @@ next_task:
 	return 0;
 }
 
-int locks_mandatory_locked(struct inode *inode)
-{
-	fl_owner_t owner = current->files;
-	struct file_lock *fl;
-
-	/*
-	 * Search the lock list for this inode for any POSIX locks.
-	 */
-	lock_kernel();
-	for (fl = inode->i_flock; fl != NULL; fl = fl->fl_next) {
-		if (!IS_POSIX(fl))
-			continue;
-		if (fl->fl_owner != owner)
-			break;
-	}
-	unlock_kernel();
-	return fl ? -EAGAIN : 0;
-}
-
-int locks_mandatory_area(int read_write, struct inode *inode,
-			 struct file *filp, loff_t offset,
-			 size_t count)
-{
-	struct file_lock fl;
-	int error;
-
-	fl.fl_owner = current->files;
-	fl.fl_pid = current->tgid;
-	fl.fl_file = filp;
-	fl.fl_flags = FL_POSIX | FL_ACCESS | FL_SLEEP;
-	fl.fl_type = (read_write == FLOCK_VERIFY_WRITE) ? F_WRLCK : F_RDLCK;
-	fl.fl_start = offset;
-	fl.fl_end = offset + count - 1;
-
-	for (;;) {
-		error = posix_lock_file(filp, &fl);
-		if (error != -EAGAIN)
-			break;
-		error = wait_event_interruptible(fl.fl_wait, !fl.fl_next);
-		if (!error) {
-			/*
-			 * If we've been sleeping someone might have
-			 * changed the permissions behind our back.
-			 */
-			if ((inode->i_mode & (S_ISGID | S_IXGRP)) == S_ISGID)
-				continue;
-		}
-
-		lock_kernel();
-		locks_delete_block(&fl);
-		unlock_kernel();
-		break;
-	}
-
-	return error;
-}
-
 /* Try to create a FLOCK lock on filp. We always insert new FLOCK locks
  * at the head of the list, but that's secret knowledge known only to
  * flock_lock_file and posix_lock_file.
@@ -770,32 +713,13 @@ out:
 	return error;
 }
 
-/**
- *	posix_lock_file:
- *	@filp: The file to apply the lock to
- *	@caller: The lock to be applied
- *	@wait: 1 to retry automatically, 0 to return -EAGAIN
- *
- * Add a POSIX style lock to a file.
- * We merge adjacent locks whenever possible. POSIX locks are sorted by owner
- * task, then by starting address
- *
- * Kai Petzke writes:
- * To make freeing a lock much faster, we keep a pointer to the lock before the
- * actual one. But the real gain of the new coding was, that lock_it() and
- * unlock_it() became one function.
- *
- * To all purists: Yes, I use a few goto's. Just pass on to the next function.
- */
-
-int posix_lock_file(struct file *filp, struct file_lock *request)
+static int __posix_lock_file(struct inode *inode, struct file_lock *request)
 {
 	struct file_lock *fl;
 	struct file_lock *new_fl, *new_fl2;
 	struct file_lock *left = NULL;
 	struct file_lock *right = NULL;
 	struct file_lock **before;
-	struct inode * inode = filp->f_dentry->d_inode;
 	int error, added = 0;
 
 	/*
@@ -804,9 +728,6 @@ int posix_lock_file(struct file *filp, s
 	 */
 	new_fl = locks_alloc_lock(0);
 	new_fl2 = locks_alloc_lock(0);
-	error = -ENOLCK; /* "no luck" */
-	if (!(new_fl && new_fl2))
-		goto out_nolock;
 
 	lock_kernel();
 	if (request->fl_type != F_UNLCK) {
@@ -829,9 +750,14 @@ int posix_lock_file(struct file *filp, s
   	}
 
 	/* If we're just looking for a conflict, we're done. */
+	error = 0;
 	if (request->fl_flags & FL_ACCESS)
 		goto out;
 
+	error = -ENOLCK; /* "no luck" */
+	if (!(new_fl && new_fl2))
+		goto out;
+
 	/*
 	 * We've allocated the new locks in advance, so there are no
 	 * errors possible (and no blocking operations) from here on.
@@ -952,9 +878,8 @@ int posix_lock_file(struct file *filp, s
 		left->fl_end = request->fl_start - 1;
 		locks_wake_up_blocks(left);
 	}
-out:
+ out:
 	unlock_kernel();
-out_nolock:
 	/*
 	 * Free any unused locks.
 	 */
@@ -965,6 +890,102 @@ out_nolock:
 	return error;
 }
 
+/**
+ * posix_lock_file - Apply a POSIX-style lock to a file
+ * @filp: The file to apply the lock to
+ * @fl: The lock to be applied
+ *
+ * Add a POSIX style lock to a file.
+ * We merge adjacent & overlapping locks whenever possible.
+ * POSIX locks are sorted by owner task, then by starting address
+ */
+int posix_lock_file(struct file *filp, struct file_lock *fl)
+{
+	return __posix_lock_file(filp->f_dentry->d_inode, fl);
+}
+
+/**
+ * locks_mandatory_locked - Check for an active lock
+ * @inode: the file to check
+ *
+ * Searches the inode's list of locks to find any POSIX locks which conflict.
+ * This function is called from locks_verify_locked() only.
+ */
+int locks_mandatory_locked(struct inode *inode)
+{
+	fl_owner_t owner = current->files;
+	struct file_lock *fl;
+
+	/*
+	 * Search the lock list for this inode for any POSIX locks.
+	 */
+	lock_kernel();
+	for (fl = inode->i_flock; fl != NULL; fl = fl->fl_next) {
+		if (!IS_POSIX(fl))
+			continue;
+		if (fl->fl_owner != owner)
+			break;
+	}
+	unlock_kernel();
+	return fl ? -EAGAIN : 0;
+}
+
+/**
+ * locks_mandatory_area - Check for a conflicting lock
+ * @read_write: %FLOCK_VERIFY_WRITE for exclusive access, %FLOCK_VERIFY_READ
+ *		for shared
+ * @inode: the file to check
+ * @file: how the file was opened (if it was)
+ * @offset: start of area to check
+ * @count: length of area to check
+ *
+ * Searches the inode's list of locks to find any POSIX locks which conflict.
+ * This function is called from locks_verify_area() and
+ * locks_verify_truncate().
+ */
+int locks_mandatory_area(int read_write, struct inode *inode,
+			 struct file *filp, loff_t offset,
+			 size_t count)
+{
+	struct file_lock fl;
+	int error;
+
+	locks_init_lock(&fl);
+	fl.fl_owner = current->files;
+	fl.fl_pid = current->tgid;
+	fl.fl_file = filp;
+	fl.fl_flags = FL_POSIX | FL_ACCESS;
+	if (filp && !(filp->f_flags & O_NONBLOCK))
+		fl.fl_flags |= FL_SLEEP;
+	fl.fl_type = (read_write == FLOCK_VERIFY_WRITE) ? F_WRLCK : F_RDLCK;
+	fl.fl_start = offset;
+	fl.fl_end = offset + count - 1;
+
+	for (;;) {
+		error = __posix_lock_file(inode, &fl);
+		if (error != -EAGAIN)
+			break;
+		if (!(fl.fl_flags & FL_SLEEP))
+			break;
+		error = wait_event_interruptible(fl.fl_wait, !fl.fl_next);
+		if (!error) {
+			/*
+			 * If we've been sleeping someone might have
+			 * changed the permissions behind our back.
+			 */
+			if ((inode->i_mode & (S_ISGID | S_IXGRP)) == S_ISGID)
+				continue;
+		}
+
+		lock_kernel();
+		locks_delete_block(&fl);
+		unlock_kernel();
+		break;
+	}
+
+	return error;
+}
+
 /* We already had a lease on this file; just change its type */
 static int lease_modify(struct file_lock **before, int arg)
 {
@@ -1460,7 +1481,7 @@ int fcntl_setlk(struct file *filp, unsig
 	}
 
 	for (;;) {
-		error = posix_lock_file(filp, file_lock);
+		error = __posix_lock_file(inode, file_lock);
 		if ((error != -EAGAIN) || (cmd == F_SETLK))
 			break;
 		error = wait_event_interruptible(file_lock->fl_wait,
@@ -1600,7 +1621,7 @@ int fcntl_setlk64(struct file *filp, uns
 	}
 
 	for (;;) {
-		error = posix_lock_file(filp, file_lock);
+		error = __posix_lock_file(inode, file_lock);
 		if ((error != -EAGAIN) || (cmd == F_SETLK64))
 			break;
 		error = wait_event_interruptible(file_lock->fl_wait,

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
