Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317023AbSFFRNo>; Thu, 6 Jun 2002 13:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317024AbSFFRNm>; Thu, 6 Jun 2002 13:13:42 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30482 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317023AbSFFRNb>;
	Thu, 6 Jun 2002 13:13:31 -0400
Date: Thu, 6 Jun 2002 18:13:31 +0100
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        Trivial Kernel Patches <trivial@rustcorp.com.au>
Subject: [PATCH] fs/locks.c: Only yield once for flocks
Message-ID: <20020606181331.I27186@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch removes the annoying and confusing `wait' argument from
many places.  The only change in behaviour is that we now yield once
when unblocking other BSD-style flocks instead of once for each lock.

This slightly improves the semantics for userspace.  Before, when we
had two tasks waiting on a lock, the first one would receive the lock.
Now, the one with the highest priority receives the lock.

diff -urNX dontdiff linux-2.5.15/fs/locks.c linux-2.5.15-flock/fs/locks.c
--- linux-2.5.15/fs/locks.c	Thu May  9 16:23:59 2002
+++ linux-2.5.15-flock/fs/locks.c	Sun May 12 09:21:40 2002
@@ -436,24 +436,15 @@
  * If told to wait then schedule the processes until the block list
  * is empty, otherwise empty the block list ourselves.
  */
-static void locks_wake_up_blocks(struct file_lock *blocker, unsigned int wait)
+static void locks_wake_up_blocks(struct file_lock *blocker)
 {
 	while (!list_empty(&blocker->fl_block)) {
 		struct file_lock *waiter = list_entry(blocker->fl_block.next, struct file_lock, fl_block);
-
-		if (wait) {
-			locks_notify_blocked(waiter);
-			/* Let the blocked process remove waiter from the
-			 * block list when it gets scheduled.
-			 */
-			yield();
-		} else {
-			/* Remove waiter from the block list, because by the
-			 * time it wakes up blocker won't exist any more.
-			 */
-			locks_delete_block(waiter);
-			locks_notify_blocked(waiter);
-		}
+		/* Remove waiter from the block list, because by the
+		 * time it wakes up blocker won't exist any more.
+		 */
+		locks_delete_block(waiter);
+		locks_notify_blocked(waiter);
 	}
 }
 
@@ -490,7 +481,7 @@
  * notify the FS that the lock has been cleared and
  * finally free the lock.
  */
-static inline void _delete_lock(struct file_lock *fl, unsigned int wait)
+static inline void _delete_lock(struct file_lock *fl)
 {
 	fasync_helper(0, fl->fl_file, 0, &fl->fl_fasync);
 	if (fl->fl_fasync != NULL){
@@ -501,19 +492,19 @@
 	if (fl->fl_remove)
 		fl->fl_remove(fl);
 
-	locks_wake_up_blocks(fl, wait);
+	locks_wake_up_blocks(fl);
 	locks_free_lock(fl);
 }
 
 /*
  * Delete a lock and then free it.
  */
-static void locks_delete_lock(struct file_lock **thisfl_p, unsigned int wait)
+static void locks_delete_lock(struct file_lock **thisfl_p)
 {
 	struct file_lock *fl = *thisfl_p;
 
 	_unhash_lock(thisfl_p);
-	_delete_lock(fl, wait);
+	_delete_lock(fl);
 }
 
 /*
@@ -532,7 +523,7 @@
 		fl->fl_type = F_UNLCK;
 		lock(fl->fl_file, F_SETLK, fl);
 	}
-	_delete_lock(fl, 0);
+	_delete_lock(fl);
 }
 
 /* Determine if lock sys_fl blocks lock caller_fl. Common functionality
@@ -806,12 +797,14 @@
 	 */
 	if (change) {
 		/* N.B. What if the wait argument is false? */
-		locks_delete_lock(before, !unlock);
-		/*
-		 * If we waited, another lock may have been added ...
-		 */
-		if (!unlock)
+		locks_delete_lock(before);
+		if (!unlock) {
+			yield();
+			/*
+			 * If we waited, another lock may have been added ...
+			 */
 			goto search;
+		}
 	}
 	if (unlock)
 		goto out;
@@ -944,7 +937,7 @@
 			else
 				caller->fl_end = fl->fl_end;
 			if (added) {
-				locks_delete_lock(before, 0);
+				locks_delete_lock(before);
 				continue;
 			}
 			caller = fl;
@@ -974,7 +967,7 @@
 				 * one (This may happen several times).
 				 */
 				if (added) {
-					locks_delete_lock(before, 0);
+					locks_delete_lock(before);
 					continue;
 				}
 				/* Replace the old lock with the new one.
@@ -982,7 +975,7 @@
 				 * as the change in lock type might satisfy
 				 * their needs.
 				 */
-				locks_wake_up_blocks(fl, 0);	/* This cannot schedule()! */
+				locks_wake_up_blocks(fl);
 				fl->fl_start = caller->fl_start;
 				fl->fl_end = caller->fl_end;
 				fl->fl_type = caller->fl_type;
@@ -1016,11 +1009,11 @@
 			locks_insert_lock(before, left);
 		}
 		right->fl_start = caller->fl_end + 1;
-		locks_wake_up_blocks(right, 0);
+		locks_wake_up_blocks(right);
 	}
 	if (left) {
 		left->fl_end = caller->fl_start - 1;
-		locks_wake_up_blocks(left, 0);
+		locks_wake_up_blocks(left);
 	}
 out:
 	unlock_kernel();
@@ -1129,7 +1122,7 @@
 	error = locks_block_on_timeout(flock, new_fl, error);
 	if (error == 0) {
 		/* We timed out.  Unilaterally break the lease. */
-		locks_delete_lock(&inode->i_flock, 0);
+		locks_delete_lock(&inode->i_flock);
 		printk(KERN_WARNING "lease timed out\n");
 	} else if (error > 0) {
 		flock = inode->i_flock;
@@ -1192,14 +1185,14 @@
 	if (error < 0)
 		goto out;
 
-	locks_wake_up_blocks(fl, 0);
+	locks_wake_up_blocks(fl);
 
 	if (arg == F_UNLCK) {
 		filp->f_owner.pid = 0;
 		filp->f_owner.uid = 0;
 		filp->f_owner.euid = 0;
 		filp->f_owner.signum = 0;
-		locks_delete_lock(before, 0);
+		locks_delete_lock(before);
 		fasync_helper(fd, filp, 0, &fl->fl_fasync);
 	}
 
@@ -1712,7 +1705,7 @@
 	while ((fl = *before) != NULL) {
 		if ((fl->fl_flags & (FL_FLOCK|FL_LEASE))
 		    && (fl->fl_file == filp)) {
-			locks_delete_lock(before, 0);
+			locks_delete_lock(before);
 			continue;
  		}
 		before = &fl->fl_next;

-- 
Revolutions do not require corporate support.
