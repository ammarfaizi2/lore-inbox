Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319570AbSIHFet>; Sun, 8 Sep 2002 01:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319571AbSIHFet>; Sun, 8 Sep 2002 01:34:49 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18194 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S319570AbSIHFem>;
	Sun, 8 Sep 2002 01:34:42 -0400
Date: Sun, 8 Sep 2002 06:39:22 +0100
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sleeping file locks
Message-ID: <20020908063922.B10583@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Whole pile of changes mixed in together here:

 - Add FL_SLEEP flag to indicate we intend to sleep and therefore desire
   to be placed on the block list.  Use it for POSIX & flock locks.
 - Remove locks_block_on.
 - Change posix_unblock_lock to eliminate a race that will appear once we
   don't use the BKL any more.
 - Update the comment for locks_same_owner() and rename it to
   posix_same_owner().
 - Change locks_mandatory_area() to allocate its lock on the stack and
   call posix_lock_file() instead of repeating that logic.
 - Rename the "caller" parameter to posix_lock_file() to "request"
   to better show that this is not to be inserted directly.
 - Redo some of the proc code a little.  Stop exposing kernel addresses
   to userspace (whoever thought _that_ was a good idea?!) and show how
   we should be printing the device name.  The last part is ifdeffed
   out to avoid breaking lslk.
 - Remove FL_BROKEN.  And there was much rejoicing.

diff -urpNX dontdiff linux-2.5.33/fs/lockd/svclock.c linux-2.5.33-willy/fs/lockd/svclock.c
--- linux-2.5.33/fs/lockd/svclock.c	2002-08-28 06:42:34.000000000 -0700
+++ linux-2.5.33-willy/fs/lockd/svclock.c	2002-09-07 22:07:43.000000000 -0700
@@ -237,17 +237,8 @@ nlmsvc_delete_block(struct nlm_block *bl
 
 	/* Remove block from list */
 	nlmsvc_remove_block(block);
-
-	/* If granted, unlock it, else remove from inode block list */
-	if (unlock && block->b_granted) {
-		dprintk("lockd: deleting granted lock\n");
-		fl->fl_type = F_UNLCK;
-		posix_lock_file(&block->b_file->f_file, fl, 0);
-		block->b_granted = 0;
-	} else {
-		dprintk("lockd: unblocking blocked lock\n");
-		posix_unblock_lock(fl);
-	}
+	posix_unblock_lock(&file->f_file, fl);
+	block->b_granted = 0;
 
 	/* If the block is in the middle of a GRANT callback,
 	 * don't kill it yet. */
@@ -324,7 +315,7 @@ nlmsvc_lock(struct svc_rqst *rqstp, stru
 
 again:
 	if (!(conflock = posix_test_lock(&file->f_file, &lock->fl))) {
-		error = posix_lock_file(&file->f_file, &lock->fl, 0);
+		error = posix_lock_file(&file->f_file, &lock->fl);
 
 		if (block)
 			nlmsvc_delete_block(block, 0);
@@ -428,7 +419,7 @@ nlmsvc_unlock(struct nlm_file *file, str
 	nlmsvc_cancel_blocked(file, lock);
 
 	lock->fl.fl_type = F_UNLCK;
-	error = posix_lock_file(&file->f_file, &lock->fl, 0);
+	error = posix_lock_file(&file->f_file, &lock->fl);
 
 	return (error < 0)? nlm_lck_denied_nolocks : nlm_granted;
 }
@@ -532,7 +523,7 @@ nlmsvc_grant_blocked(struct nlm_block *b
 	 * following yields an error, this is most probably due to low
 	 * memory. Retry the lock in a few seconds.
 	 */
-	if ((error = posix_lock_file(&file->f_file, &lock->fl, 0)) < 0) {
+	if ((error = posix_lock_file(&file->f_file, &lock->fl)) < 0) {
 		printk(KERN_WARNING "lockd: unexpected error %d in %s!\n",
 				-error, __FUNCTION__);
 		nlmsvc_insert_block(block, 10 * HZ);
diff -urpNX dontdiff linux-2.5.33/fs/lockd/svcsubs.c linux-2.5.33-willy/fs/lockd/svcsubs.c
--- linux-2.5.33/fs/lockd/svcsubs.c	2002-08-01 14:16:06.000000000 -0700
+++ linux-2.5.33-willy/fs/lockd/svcsubs.c	2002-09-07 22:07:43.000000000 -0700
@@ -176,7 +176,7 @@ again:
 			lock.fl_type  = F_UNLCK;
 			lock.fl_start = 0;
 			lock.fl_end   = OFFSET_MAX;
-			if (posix_lock_file(&file->f_file, &lock, 0) < 0) {
+			if (posix_lock_file(&file->f_file, &lock) < 0) {
 				printk("lockd: unlock failure in %s:%d\n",
 						__FILE__, __LINE__);
 				return 1;
diff -urpNX dontdiff linux-2.5.33/fs/locks.c linux-2.5.33-willy/fs/locks.c
--- linux-2.5.33/fs/locks.c	2002-09-02 19:24:07.000000000 -0700
+++ linux-2.5.33-willy/fs/locks.c	2002-09-07 22:16:36.000000000 -0700
@@ -404,15 +412,14 @@ static inline int locks_overlap(struct f
 }
 
 /*
- * Check whether two locks have the same owner
- * N.B. Do we need the test on PID as well as owner?
- * (Clone tasks should be considered as one "owner".)
+ * Check whether two locks have the same owner.  The apparently superfluous
+ * check for fl_pid enables us to distinguish between locks set by lockd.
  */
 static inline int
-locks_same_owner(struct file_lock *fl1, struct file_lock *fl2)
+posix_same_owner(struct file_lock *fl1, struct file_lock *fl2)
 {
 	return (fl1->fl_owner == fl2->fl_owner) &&
-	       (fl1->fl_pid   == fl2->fl_pid);
+		(fl1->fl_pid == fl2->fl_pid);
 }
 
 /* Remove waiter from blocker's block list.
@@ -531,7 +536,7 @@ static int posix_locks_conflict(struct f
 	/* POSIX locks owned by the same process do not conflict with
 	 * each other.
 	 */
-	if (!IS_POSIX(sys_fl) || locks_same_owner(caller_fl, sys_fl))
+	if (!IS_POSIX(sys_fl) || posix_same_owner(caller_fl, sys_fl))
 		return (0);
 
 	/* Check whether they overlap */
@@ -575,15 +580,6 @@ static int interruptible_sleep_on_locked
 	return result;
 }
 
-static int locks_block_on(struct file_lock *blocker, struct file_lock *waiter)
-{
-	int result;
-	locks_insert_block(blocker, waiter);
-	result = interruptible_sleep_on_locked(&waiter->fl_wait, 0);
-	locks_delete_block(waiter);
-	return result;
-}
-
 static int locks_block_on_timeout(struct file_lock *blocker, struct file_lock *waiter, int time)
 {
 	int result;
@@ -675,56 +671,37 @@ int locks_mandatory_area(int read_write,
 			 struct file *filp, loff_t offset,
 			 size_t count)
 {
-	struct file_lock *fl;
-	struct file_lock *new_fl = locks_alloc_lock(0);
+	struct file_lock fl;
 	int error;
 
-	if (new_fl == NULL)
-		return -ENOMEM;
-
-	new_fl->fl_owner = current->files;
-	new_fl->fl_pid = current->pid;
-	new_fl->fl_file = filp;
-	new_fl->fl_flags = FL_POSIX | FL_ACCESS;
-	new_fl->fl_type = (read_write == FLOCK_VERIFY_WRITE) ? F_WRLCK : F_RDLCK;
-	new_fl->fl_start = offset;
-	new_fl->fl_end = offset + count - 1;
-
-	error = 0;
-	lock_kernel();
-
-repeat:
-	/* Search the lock list for this inode for locks that conflict with
-	 * the proposed read/write.
-	 */
-	for (fl = inode->i_flock; fl != NULL; fl = fl->fl_next) {
-		if (!IS_POSIX(fl))
-			continue;
-		if (fl->fl_start > new_fl->fl_end)
+	fl.fl_owner = current->files;
+	fl.fl_pid = current->pid;
+	fl.fl_file = filp;
+	fl.fl_flags = FL_POSIX | FL_ACCESS | FL_SLEEP;
+	fl.fl_type = (read_write == FLOCK_VERIFY_WRITE) ? F_WRLCK : F_RDLCK;
+	fl.fl_start = offset;
+	fl.fl_end = offset + count - 1;
+
+	for (;;) {
+		error = posix_lock_file(filp, &fl);
+		if (error != -EAGAIN)
 			break;
-		if (posix_locks_conflict(new_fl, fl)) {
-			error = -EAGAIN;
-			if (filp && (filp->f_flags & O_NONBLOCK))
-				break;
-			error = -EDEADLK;
-			if (posix_locks_deadlock(new_fl, fl))
-				break;
-	
-			error = locks_block_on(fl, new_fl);
-			if (error != 0)
-				break;
-	
+		error = wait_event_interruptible(fl.fl_wait, !fl.fl_next);
+		if (!error) {
 			/*
 			 * If we've been sleeping someone might have
 			 * changed the permissions behind our back.
 			 */
-			if ((inode->i_mode & (S_ISGID | S_IXGRP)) != S_ISGID)
-				break;
-			goto repeat;
+			if ((inode->i_mode & (S_ISGID | S_IXGRP)) == S_ISGID)
+				continue;
 		}
+
+		lock_kernel();
+		locks_delete_block(&fl);
+		unlock_kernel();
+		break;
 	}
-	locks_free_lock(new_fl);
-	unlock_kernel();
+
 	return error;
 }
 
@@ -732,8 +709,7 @@ repeat:
  * at the head of the list, but that's secret knowledge known only to
  * flock_lock_file and posix_lock_file.
  */
-static int flock_lock_file(struct file *filp, struct file_lock *new_fl,
-			   unsigned int wait)
+static int flock_lock_file(struct file *filp, struct file_lock *new_fl)
 {
 	struct file_lock **before;
 	struct inode * inode = filp->f_dentry->d_inode;
@@ -764,7 +740,6 @@ static int flock_lock_file(struct file *
 		return 0;
 
 	lock_kernel();
-repeat:
 	for_each_lock(inode, before) {
 		struct file_lock *fl = *before;
 		if (IS_POSIX(fl))
@@ -774,12 +749,10 @@ repeat:
 		if (!flock_locks_conflict(new_fl, fl))
 			continue;
 		error = -EAGAIN;
-		if (!wait)
-			goto out;
-		error = locks_block_on(fl, new_fl);
-		if (error != 0)
-			goto out;
-		goto repeat;
+		if (new_fl->fl_flags & FL_SLEEP) {
+			locks_insert_block(fl, new_fl);
+		}
+		goto out;
 	}
 	locks_insert_lock(&inode->i_flock, new_fl);
 	error = 0;
@@ -807,8 +780,7 @@ out:
  * To all purists: Yes, I use a few goto's. Just pass on to the next function.
  */
 
-int posix_lock_file(struct file *filp, struct file_lock *caller,
-			   unsigned int wait)
+int posix_lock_file(struct file *filp, struct file_lock *request)
 {
 	struct file_lock *fl;
 	struct file_lock *new_fl, *new_fl2;
@@ -829,27 +801,29 @@ int posix_lock_file(struct file *filp, s
 		goto out_nolock;
 
 	lock_kernel();
-	if (caller->fl_type != F_UNLCK) {
-  repeat:
-		for (fl = inode->i_flock; fl != NULL; fl = fl->fl_next) {
+	if (request->fl_type != F_UNLCK) {
+		for_each_lock(inode, before) {
+			struct file_lock *fl = *before;
 			if (!IS_POSIX(fl))
 				continue;
-			if (!posix_locks_conflict(caller, fl))
+			if (!posix_locks_conflict(request, fl))
 				continue;
 			error = -EAGAIN;
-			if (!wait)
+			if (!(request->fl_flags & FL_SLEEP))
 				goto out;
 			error = -EDEADLK;
-			if (posix_locks_deadlock(caller, fl))
+			if (posix_locks_deadlock(request, fl))
 				goto out;
-
-			error = locks_block_on(fl, caller);
-			if (error != 0)
-				goto out;
-			goto repeat;
+			error = -EAGAIN;
+			locks_insert_block(fl, request);
+			goto out;
   		}
   	}
 
+	/* If we're just looking for a conflict, we're done. */
+	if (request->fl_flags & FL_ACCESS)
+		goto out;
+
 	/*
 	 * We've allocated the new locks in advance, so there are no
 	 * errors possible (and no blocking operations) from here on.
@@ -859,25 +833,23 @@ int posix_lock_file(struct file *filp, s
 	
 	before = &inode->i_flock;
 
-	/* First skip locks owned by other processes.
-	 */
+	/* First skip locks owned by other processes.  */
 	while ((fl = *before) && (!IS_POSIX(fl) ||
-				  !locks_same_owner(caller, fl))) {
+				  !posix_same_owner(request, fl))) {
 		before = &fl->fl_next;
 	}
 
-	/* Process locks with this owner.
-	 */
-	while ((fl = *before) && locks_same_owner(caller, fl)) {
+	/* Process locks with this owner.  */
+	while ((fl = *before) && posix_same_owner(request, fl)) {
 		/* Detect adjacent or overlapping regions (if same lock type)
 		 */
-		if (caller->fl_type == fl->fl_type) {
-			if (fl->fl_end < caller->fl_start - 1)
+		if (request->fl_type == fl->fl_type) {
+			if (fl->fl_end < request->fl_start - 1)
 				goto next_lock;
 			/* If the next lock in the list has entirely bigger
 			 * addresses than the new one, insert the lock here.
 			 */
-			if (fl->fl_start > caller->fl_end + 1)
+			if (fl->fl_start > request->fl_end + 1)
 				break;
 
 			/* If we come here, the new and old lock are of the
@@ -885,41 +857,41 @@ int posix_lock_file(struct file *filp, s
 			 * lock yielding from the lower start address of both
 			 * locks to the higher end address.
 			 */
-			if (fl->fl_start > caller->fl_start)
-				fl->fl_start = caller->fl_start;
+			if (fl->fl_start > request->fl_start)
+				fl->fl_start = request->fl_start;
 			else
-				caller->fl_start = fl->fl_start;
-			if (fl->fl_end < caller->fl_end)
-				fl->fl_end = caller->fl_end;
+				request->fl_start = fl->fl_start;
+			if (fl->fl_end < request->fl_end)
+				fl->fl_end = request->fl_end;
 			else
-				caller->fl_end = fl->fl_end;
+				request->fl_end = fl->fl_end;
 			if (added) {
 				locks_delete_lock(before);
 				continue;
 			}
-			caller = fl;
+			request = fl;
 			added = 1;
 		}
 		else {
 			/* Processing for different lock types is a bit
 			 * more complex.
 			 */
-			if (fl->fl_end < caller->fl_start)
+			if (fl->fl_end < request->fl_start)
 				goto next_lock;
-			if (fl->fl_start > caller->fl_end)
+			if (fl->fl_start > request->fl_end)
 				break;
-			if (caller->fl_type == F_UNLCK)
+			if (request->fl_type == F_UNLCK)
 				added = 1;
-			if (fl->fl_start < caller->fl_start)
+			if (fl->fl_start < request->fl_start)
 				left = fl;
 			/* If the next lock in the list has a higher end
 			 * address than the new one, insert the new one here.
 			 */
-			if (fl->fl_end > caller->fl_end) {
+			if (fl->fl_end > request->fl_end) {
 				right = fl;
 				break;
 			}
-			if (fl->fl_start >= caller->fl_start) {
+			if (fl->fl_start >= request->fl_start) {
 				/* The new lock completely replaces an old
 				 * one (This may happen several times).
 				 */
@@ -933,11 +905,11 @@ int posix_lock_file(struct file *filp, s
 				 * their needs.
 				 */
 				locks_wake_up_blocks(fl);
-				fl->fl_start = caller->fl_start;
-				fl->fl_end = caller->fl_end;
-				fl->fl_type = caller->fl_type;
-				fl->fl_u = caller->fl_u;
-				caller = fl;
+				fl->fl_start = request->fl_start;
+				fl->fl_end = request->fl_end;
+				fl->fl_type = request->fl_type;
+				fl->fl_u = request->fl_u;
+				request = fl;
 				added = 1;
 			}
 		}
@@ -949,9 +921,9 @@ int posix_lock_file(struct file *filp, s
 
 	error = 0;
 	if (!added) {
-		if (caller->fl_type == F_UNLCK)
+		if (request->fl_type == F_UNLCK)
 			goto out;
-		locks_copy_lock(new_fl, caller);
+		locks_copy_lock(new_fl, request);
 		locks_insert_lock(before, new_fl);
 		new_fl = NULL;
 	}
@@ -965,11 +937,11 @@ int posix_lock_file(struct file *filp, s
 			locks_copy_lock(left, right);
 			locks_insert_lock(before, left);
 		}
-		right->fl_start = caller->fl_end + 1;
+		right->fl_start = request->fl_end + 1;
 		locks_wake_up_blocks(right);
 	}
 	if (left) {
-		left->fl_end = caller->fl_start - 1;
+		left->fl_end = request->fl_start - 1;
 		locks_wake_up_blocks(left);
 	}
 out:
@@ -1323,22 +1295,35 @@ asmlinkage long sys_flock(unsigned int f
 		goto out_putf;
 
 	error = flock_make_lock(filp, &lock, cmd);
-	if (error < 0)
+	if (error)
 		goto out_putf;
 
-	error = security_ops->file_lock(filp, lock->fl_type);
+	error = security_ops->file_lock(filp, cmd);
 	if (error)
-		goto out_putf;
+		goto out_free;
 
-	error = flock_lock_file(filp, lock,
-				(cmd & (LOCK_UN | LOCK_NB)) ? 0 : 1);
+	for (;;) {
+		error = flock_lock_file(filp, lock);
+		if ((error != -EAGAIN) || (cmd & LOCK_NB))
+			break;
+		error = wait_event_interruptible(lock->fl_wait, !lock->fl_next);
+		if (!error)
+			continue;
 
-	if (error)
+		lock_kernel();
+		locks_delete_block(lock);
+		unlock_kernel();
+		break;
+	}
+
+ out_free:
+	if (error) {
 		locks_free_lock(lock);
+	}
 
-out_putf:
+ out_putf:
 	fput(filp);
-out:
+ out:
 	return error;
 }
 
@@ -1442,6 +1427,9 @@ int fcntl_setlk(struct file *filp, unsig
 	error = flock_to_posix_lock(filp, file_lock, &flock);
 	if (error)
 		goto out;
+	if (cmd == F_SETLKW) {
+		file_lock->fl_flags |= FL_SLEEP;
+	}
 	
 	error = -EBADF;
 	switch (flock.l_type) {
@@ -1469,10 +1457,26 @@ int fcntl_setlk(struct file *filp, unsig
 		if (error < 0)
 			goto out;
 	}
-	error = posix_lock_file(filp, file_lock, cmd == F_SETLKW);
+
+	for (;;) {
+		error = posix_lock_file(filp, file_lock);
+		if ((error != -EAGAIN) || (cmd == F_SETLK))
+			break;
+		error = wait_event_interruptible(file_lock->fl_wait,
+				!file_lock->fl_next);
+		if (!error)
+			continue;
+
+		lock_kernel();
+		locks_delete_block(file_lock);
+		unlock_kernel();
+		break;
+	}
 
 out:
-	locks_free_lock(file_lock);
+	if (error) {
+		locks_free_lock(file_lock);
+	}
 	return error;
 }
 
@@ -1565,6 +1569,9 @@ int fcntl_setlk64(struct file *filp, uns
 	error = flock64_to_posix_lock(filp, file_lock, &flock);
 	if (error)
 		goto out;
+	if (cmd == F_SETLKW64) {
+		file_lock->fl_flags |= FL_SLEEP;
+	}
 	
 	error = -EBADF;
 	switch (flock.l_type) {
@@ -1592,10 +1599,27 @@ int fcntl_setlk64(struct file *filp, uns
 		if (error < 0)
 			goto out;
 	}
-	error = posix_lock_file(filp, file_lock, cmd == F_SETLKW64);
+
+	for (;;) {
+		error = posix_lock_file(filp, file_lock);
+		if ((error != -EAGAIN) || (cmd == F_SETLK))
+			break;
+		error = wait_event_interruptible(file_lock->fl_wait,
+				!file_lock->fl_next);
+		if (!error)
+			continue;
+
+		lock_kernel();
+		locks_delete_block(file_lock);
+		unlock_kernel();
+		break;
+	}
+
 
 out:
-	locks_free_lock(file_lock);
+	if (error) {
+		locks_free_lock(file_lock);
+	}
 	return error;
 }
 #endif /* BITS_PER_LONG == 32 */
@@ -1630,7 +1654,7 @@ void locks_remove_posix(struct file *fil
 		/* Ignore any error -- we must remove the locks anyway */
 	}
 
-	posix_lock_file(filp, &lock, 0);
+	posix_lock_file(filp, &lock);
 }
 
 /*
@@ -1684,10 +1708,21 @@ posix_block_lock(struct file_lock *block
  *	lockd needs to block waiting for locks.
  */
 void
-posix_unblock_lock(struct file_lock *waiter)
+posix_unblock_lock(struct file *filp, struct file_lock *waiter)
 {
-	if (!list_empty(&waiter->fl_block))
+	/* 
+	 * A remote machine may cancel the lock request after it's been
+	 * granted locally.  If that happens, we need to delete the lock.
+	 */
+	lock_kernel();
+	if (waiter->fl_next) {
 		locks_delete_block(waiter);
+		unlock_kernel();
+	} else {
+		unlock_kernel();
+		waiter->fl_type = F_UNLCK;
+		posix_lock_file(filp, waiter);
+	}
 }
 
 static void lock_get_status(char* out, struct file_lock *fl, int id, char *pfx)
@@ -1733,21 +1768,28 @@ static void lock_get_status(char* out, s
 			       ? (fl->fl_type & F_UNLCK) ? "UNLCK" : "READ "
 			       : (fl->fl_type & F_WRLCK) ? "WRITE" : "READ ");
 	}
-	/*
-	 *	NOTE: it should be inode->i_sb->s_id, not kdevname(...).
-	 */
-	out += sprintf(out, "%d %s:%ld ",
-		     fl->fl_pid,
-		     inode ? kdevname(to_kdev_t(inode->i_dev)) : "<none>",
-		     inode ? inode->i_ino : 0);
-	out += sprintf(out, "%Ld ", fl->fl_start);
-	if (fl->fl_end == OFFSET_MAX)
-		out += sprintf(out, "EOF ");
-	else
-		out += sprintf(out, "%Ld ", fl->fl_end);
-	sprintf(out, "%08lx %08lx %08lx %08lx %08lx\n",
-		(long)fl, (long)fl->fl_link.prev, (long)fl->fl_link.next,
-		(long)fl->fl_next, (long)fl->fl_block.next);
+#if WE_CAN_BREAK_LSLK_NOW
+	if (inode) {
+		out += sprintf(out, "%d %s:%ld ", fl->fl_pid,
+				inode->i_sb->s_id, inode->i_ino);
+	} else {
+		out += sprintf(out, "%d <none>:0 ", fl->fl_pid);
+	}
+#else
+	/* kdevname is a broken interface.  but we expose it to userspace */
+	out += sprintf(out, "%d %s:%ld ", fl->fl_pid,
+			inode ? kdevname(to_kdev_t(inode->i_dev)) : "<none>",
+			inode ? inode->i_ino : 0);
+#endif
+	if (IS_POSIX(fl)) {
+		if (fl->fl_end == OFFSET_MAX)
+			out += sprintf(out, "%Ld EOF\n", fl->fl_start);
+		else
+			out += sprintf(out, "%Ld %Ld\n", fl->fl_start,
+					fl->fl_end);
+	} else {
+		out += sprintf(out, "0 EOF\n");
+	}
 }
 
 static void move_lock_status(char **p, off_t* pos, off_t offset)
diff -urpNX dontdiff linux-2.5.33/include/linux/fs.h linux-2.5.33-willy/include/linux/fs.h
--- linux-2.5.33/include/linux/fs.h	2002-08-28 06:42:36.000000000 -0700
+++ linux-2.5.33-willy/include/linux/fs.h	2002-09-07 22:07:43.000000000 -0700
@@ -525,10 +525,10 @@ extern int init_private_file(struct file
 
 #define FL_POSIX	1
 #define FL_FLOCK	2
-#define FL_BROKEN	4	/* broken flock() emulation */
-#define FL_ACCESS	8	/* for processes suspended by mandatory locking */
+#define FL_ACCESS	8	/* not trying to lock, just looking */
 #define FL_LOCKD	16	/* lock held by rpc.lockd */
 #define FL_LEASE	32	/* lease held on this file */
+#define FL_SLEEP	128	/* A blocking lock */
 
 /*
  * The POSIX file lock owner is determined by
@@ -590,9 +590,9 @@ extern void locks_copy_lock(struct file_
 extern void locks_remove_posix(struct file *, fl_owner_t);
 extern void locks_remove_flock(struct file *);
 extern struct file_lock *posix_test_lock(struct file *, struct file_lock *);
-extern int posix_lock_file(struct file *, struct file_lock *, unsigned int);
+extern int posix_lock_file(struct file *, struct file_lock *);
 extern void posix_block_lock(struct file_lock *, struct file_lock *);
-extern void posix_unblock_lock(struct file_lock *);
+extern void posix_unblock_lock(struct file *, struct file_lock *);
 extern int posix_locks_deadlock(struct file_lock *, struct file_lock *);
 extern int __get_lease(struct inode *inode, unsigned int flags);
 extern time_t lease_get_mtime(struct inode *);

-- 
Revolutions do not require corporate support.
