Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129215AbQKGR6l>; Tue, 7 Nov 2000 12:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129185AbQKGR6V>; Tue, 7 Nov 2000 12:58:21 -0500
Received: from mons.uio.no ([129.240.130.14]:46497 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S129114AbQKGR6P>;
	Tue, 7 Nov 2000 12:58:15 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14856.17034.160339.773098@charged.uio.no>
Date: Tue, 7 Nov 2000 18:57:30 +0100 (CET)
To: Linus Torvalds <torvalds@transmeta.com>
Cc: : Andrew Morton <andrewm@uow.edu.au>,
        "kumon@flab.fujitsu.co.jp" <kumon@flab.fujitsu.co.jp>,
        linux-kernel@vger.kernel.org
Subject: locks.c: removal of semaphores
In-Reply-To: <3A053B05.2AE5D4EB@uow.edu.au>
In-Reply-To: <3A053B05.2AE5D4EB@uow.edu.au>
X-Mailer: VM 6.71 under 21.1 (patch 3) "Acadia" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's a slightly modified version of Andrew's patch: the version he
sent me on Sunday contained an incomplete merge of my fix to
locks_remove_posix(), meaning that the host server was not being
notified that posix locks were cleared in the call to close().

The following patch contains his patch + the above correction +
removal of the now-redundant BKLs in fl_notify & friends. It's been
tested. Amongst other things, we now pass all the Connectathon tests.

Remaining issues on NFS locking: just the lock reclaiming fixes, which
as I said earlier are non-critical for purposes of the 2.4.0 release.


fs/locks.c

    - Remove semaphore file_lock_sem, and revert to BKL locking in
      order to fix various races and deadlocks.

    - locks_delete_lock() should not call file->f_op->lock().  The
      latter notifies the *server*, hence calling it from routines like
      posix_lock_file() while merging/unmerging locks in our internal
      representation of the locks is a bug.

    - A new function locks_unlock_delete() takes care of the special
      case when we're freeing all locks upon close().

    - Straighten out lock notification. Don't bother waking up task
      when we have a notify function. Don't wake up task in
      posix_unblock_lock().


fs/lockd/clntlock.c
    - Remove semaphore file_lock_sem. We're now protected by the BKL.

fs/lockd/clntproc, fs/lockd/svclock.c
    - Remove redundant BKL. The caller already holds it.

Cheers,
  Trond


diff -u --recursive --new-file linux-2.4.0-test10/fs/lockd/clntlock.c linux-2.4.0-lockd/fs/lockd/clntlock.c
--- linux-2.4.0-test10/fs/lockd/clntlock.c	Mon Oct 16 21:58:51 2000
+++ linux-2.4.0-lockd/fs/lockd/clntlock.c	Tue Nov  7 02:24:01 2000
@@ -168,7 +168,6 @@
 	 * reclaim is in progress */
 	lock_kernel();
 	lockd_up();
-	down(&file_lock_sem);
 
 	/* First, reclaim all locks that have been granted previously. */
 restart:
@@ -181,12 +180,11 @@
 				fl->fl_u.nfs_fl.state != host->h_state &&
 				(fl->fl_u.nfs_fl.flags & NFS_LCK_GRANTED)) {
 			fl->fl_u.nfs_fl.flags &= ~ NFS_LCK_GRANTED;
-			nlmclnt_reclaim(host, fl);
+			nlmclnt_reclaim(host, fl);	/* This sleeps */
 			goto restart;
 		}
 		tmp = tmp->next;
 	}
-	up(&file_lock_sem);
 
 	host->h_reclaiming = 0;
 	wake_up(&host->h_gracewait);
diff -u --recursive --new-file linux-2.4.0-test10/fs/lockd/clntproc.c linux-2.4.0-lockd/fs/lockd/clntproc.c
--- linux-2.4.0-test10/fs/lockd/clntproc.c	Mon Oct 30 23:41:41 2000
+++ linux-2.4.0-lockd/fs/lockd/clntproc.c	Tue Nov  7 00:35:39 2000
@@ -407,19 +407,15 @@
 static
 void nlmclnt_insert_lock_callback(struct file_lock *fl)
 {
-	lock_kernel();
 	nlm_get_host(fl->fl_u.nfs_fl.host);
-	unlock_kernel();
 }
 static
 void nlmclnt_remove_lock_callback(struct file_lock *fl)
 {
-	lock_kernel();
 	if (fl->fl_u.nfs_fl.host) {
 		nlm_release_host(fl->fl_u.nfs_fl.host);
 		fl->fl_u.nfs_fl.host = NULL;
 	}
-	unlock_kernel();
 }
 
 /*
diff -u --recursive --new-file linux-2.4.0-test10/fs/lockd/svclock.c linux-2.4.0-lockd/fs/lockd/svclock.c
--- linux-2.4.0-test10/fs/lockd/svclock.c	Tue Nov  7 00:38:57 2000
+++ linux-2.4.0-lockd/fs/lockd/svclock.c	Tue Nov  7 00:37:13 2000
@@ -468,16 +468,13 @@
 
 	dprintk("lockd: VFS unblock notification for block %p\n", fl);
 	posix_unblock_lock(fl);
-	lock_kernel();
 	for (bp = &nlm_blocked; (block = *bp); bp = &block->b_next) {
 		if (nlm_compare_locks(&block->b_call.a_args.lock.fl, fl)) {
 			nlmsvc_insert_block(block, 0);
 			svc_wake_up(block->b_daemon);
-			unlock_kernel();
 			return;
 		}
 	}
-	unlock_kernel();
 
 	printk(KERN_WARNING "lockd: notification for unknown block!\n");
 }
diff -u --recursive --new-file linux-2.4.0-test10/fs/locks.c linux-2.4.0-lockd/fs/locks.c
--- linux-2.4.0-test10/fs/locks.c	Fri Oct 13 21:12:18 2000
+++ linux-2.4.0-lockd/fs/locks.c	Tue Nov  7 02:31:05 2000
@@ -125,11 +125,6 @@
 #include <asm/semaphore.h>
 #include <asm/uaccess.h>
 
-DECLARE_MUTEX(file_lock_sem);
-
-#define acquire_fl_sem()	down(&file_lock_sem)
-#define release_fl_sem()	up(&file_lock_sem)
-
 int leases_enable = 1;
 int lease_break_time = 45;
 
@@ -428,6 +423,15 @@
 	list_add(&waiter->fl_link, &blocked_list);
 }
 
+static inline
+void locks_notify_blocked(struct file_lock *waiter)
+{
+	if (waiter->fl_notify)
+		waiter->fl_notify(waiter);
+	else
+		wake_up(&waiter->fl_wait);
+}
+
 /* Wake up processes blocked waiting for blocker.
  * If told to wait then schedule the processes until the block list
  * is empty, otherwise empty the block list ourselves.
@@ -436,11 +440,9 @@
 {
 	while (!list_empty(&blocker->fl_block)) {
 		struct file_lock *waiter = list_entry(blocker->fl_block.next, struct file_lock, fl_block);
-		/* N.B. Is it possible for the notify function to block?? */
-		if (waiter->fl_notify)
-			waiter->fl_notify(waiter);
-		wake_up(&waiter->fl_wait);
+
 		if (wait) {
+			locks_notify_blocked(waiter);
 			/* Let the blocked process remove waiter from the
 			 * block list when it gets scheduled.
 			 */
@@ -451,6 +453,7 @@
 			 * time it wakes up blocker won't exist any more.
 			 */
 			locks_delete_block(waiter);
+			locks_notify_blocked(waiter);
 		}
 	}
 }
@@ -477,7 +480,6 @@
  */
 static void locks_delete_lock(struct file_lock **thisfl_p, unsigned int wait)
 {
-	int (*lock)(struct file *, int, struct file_lock *);
 	struct file_lock *fl = *thisfl_p;
 
 	*thisfl_p = fl->fl_next;
@@ -488,7 +490,7 @@
 
 	fasync_helper(0, fl->fl_file, 0, &fl->fl_fasync);
 	if (fl->fl_fasync != NULL){
-		printk("locks_delete_lock: fasync == %p\n", fl->fl_fasync);
+		printk(KERN_ERR "locks_delete_lock: fasync == %p\n", fl->fl_fasync);
 		fl->fl_fasync = NULL;
 	}
 
@@ -496,12 +498,24 @@
 		fl->fl_remove(fl);
 
 	locks_wake_up_blocks(fl, wait);
-	lock = fl->fl_file->f_op->lock;
-	if (lock) {
+	locks_free_lock(fl);
+}
+
+/*
+ * Call back client filesystem in order to get it to unregister a lock,
+ * then delete lock. Essentially useful only in locks_remove_*().
+ * Note: this must be called with the semaphore already held!
+ */
+static inline void locks_unlock_delete(struct file_lock **thisfl_p)
+{
+	struct file_lock *fl = *thisfl_p;
+	int (*lock)(struct file *, int, struct file_lock *);
+
+	if ((lock = fl->fl_file->f_op->lock) != NULL) {
 		fl->fl_type = F_UNLCK;
 		lock(fl->fl_file, F_SETLK, fl);
 	}
-	locks_free_lock(fl);
+	locks_delete_lock(thisfl_p, 0);
 }
 
 /* Determine if lock sys_fl blocks lock caller_fl. Common functionality
@@ -562,22 +576,19 @@
 	return (locks_conflict(caller_fl, sys_fl));
 }
 
-int interruptible_sleep_on_locked(wait_queue_head_t *fl_wait, struct semaphore *sem, int timeout)
+static int interruptible_sleep_on_locked(wait_queue_head_t *fl_wait, int timeout)
 {
 	int result = 0;
-	wait_queue_t wait;
-	init_waitqueue_entry(&wait, current);
+	DECLARE_WAITQUEUE(wait, current);
 
-	__add_wait_queue(fl_wait, &wait);
 	current->state = TASK_INTERRUPTIBLE;
-	up(sem);
+	add_wait_queue(fl_wait, &wait);
 	if (timeout == 0)
 		schedule();
 	else
 		result = schedule_timeout(timeout);
 	if (signal_pending(current))
 		result = -ERESTARTSYS;
-	down(sem);
 	remove_wait_queue(fl_wait, &wait);
 	current->state = TASK_RUNNING;
 	return result;
@@ -587,7 +598,7 @@
 {
 	int result;
 	locks_insert_block(blocker, waiter);
-	result = interruptible_sleep_on_locked(&waiter->fl_wait, &file_lock_sem, 0);
+	result = interruptible_sleep_on_locked(&waiter->fl_wait, 0);
 	locks_delete_block(waiter);
 	return result;
 }
@@ -596,7 +607,7 @@
 {
 	int result;
 	locks_insert_block(blocker, waiter);
-	result = interruptible_sleep_on_locked(&waiter->fl_wait, &file_lock_sem, time);
+	result = interruptible_sleep_on_locked(&waiter->fl_wait, time);
 	locks_delete_block(waiter);
 	return result;
 }
@@ -606,14 +617,14 @@
 {
 	struct file_lock *cfl;
 
-	acquire_fl_sem();
+	lock_kernel();
 	for (cfl = filp->f_dentry->d_inode->i_flock; cfl; cfl = cfl->fl_next) {
 		if (!(cfl->fl_flags & FL_POSIX))
 			continue;
 		if (posix_locks_conflict(cfl, fl))
 			break;
 	}
-	release_fl_sem();
+	unlock_kernel();
 
 	return (cfl);
 }
@@ -668,14 +679,14 @@
 	/*
 	 * Search the lock list for this inode for any POSIX locks.
 	 */
-	acquire_fl_sem();
+	lock_kernel();
 	for (fl = inode->i_flock; fl != NULL; fl = fl->fl_next) {
 		if (!(fl->fl_flags & FL_POSIX))
 			continue;
 		if (fl->fl_owner != owner)
 			break;
 	}
-	release_fl_sem();
+	unlock_kernel();
 	return fl ? -EAGAIN : 0;
 }
 
@@ -696,7 +707,7 @@
 	new_fl->fl_end = offset + count - 1;
 
 	error = 0;
-	acquire_fl_sem();
+	lock_kernel();
 
 repeat:
 	/* Search the lock list for this inode for locks that conflict with
@@ -729,7 +740,7 @@
 		}
 	}
 	locks_free_lock(new_fl);
-	release_fl_sem();
+	unlock_kernel();
 	return error;
 }
 
@@ -847,7 +858,7 @@
 	if (!(new_fl && new_fl2))
 		goto out;
 
-	acquire_fl_sem();
+	lock_kernel();
 	if (caller->fl_type != F_UNLCK) {
   repeat:
 		for (fl = inode->i_flock; fl != NULL; fl = fl->fl_next) {
@@ -951,7 +962,7 @@
 				 * as the change in lock type might satisfy
 				 * their needs.
 				 */
-				locks_wake_up_blocks(fl, 0);
+				locks_wake_up_blocks(fl, 0);	/* This cannot schedule()! */
 				fl->fl_start = caller->fl_start;
 				fl->fl_end = caller->fl_end;
 				fl->fl_type = caller->fl_type;
@@ -992,7 +1003,7 @@
 		locks_wake_up_blocks(left, 0);
 	}
 out:
-	release_fl_sem();
+	unlock_kernel();
 	/*
 	 * Free any unused locks.
 	 */
@@ -1038,7 +1049,7 @@
 
 	alloc_err = lease_alloc(NULL, 0, &new_fl);
 
-	acquire_fl_sem();
+	lock_kernel();
 	flock = inode->i_flock;
 	if (flock->fl_type & F_INPROGRESS) {
 		if ((mode & O_NONBLOCK)
@@ -1107,7 +1118,7 @@
 	}
 
 out:
-	release_fl_sem();
+	unlock_kernel();
 	if (!alloc_err)
 		locks_free_lock(new_fl);
 	return error;
@@ -1210,7 +1221,7 @@
 
 	before = &inode->i_flock;
 
-	acquire_fl_sem();
+	lock_kernel();
 
 	while ((fl = *before) != NULL) {
 		if (fl->fl_flags != FL_LEASE)
@@ -1261,7 +1272,7 @@
 	filp->f_owner.uid = current->uid;
 	filp->f_owner.euid = current->euid;
 out_unlock:
-	release_fl_sem();
+	unlock_kernel();
 	return error;
 }
 
@@ -1307,10 +1318,10 @@
 		&& !(filp->f_mode & 3))
 		goto out_putf;
 
-	acquire_fl_sem();
+	lock_kernel();
 	error = flock_lock_file(filp, type,
 				(cmd & (LOCK_UN | LOCK_NB)) ? 0 : 1);
-	release_fl_sem();
+	unlock_kernel();
 
 out_putf:
 	fput(filp);
@@ -1643,16 +1654,16 @@
 		 */
 		return;
 	}
-	acquire_fl_sem();
+	lock_kernel();
 	before = &inode->i_flock;
 	while ((fl = *before) != NULL) {
 		if ((fl->fl_flags & FL_POSIX) && fl->fl_owner == owner) {
-			locks_delete_lock(before, 0);
+			locks_unlock_delete(before);
 			continue;
 		}
 		before = &fl->fl_next;
 	}
-	release_fl_sem();
+	unlock_kernel();
 }
 
 /*
@@ -1667,7 +1678,7 @@
 	if (!inode->i_flock)
 		return;
 
-	acquire_fl_sem();
+	lock_kernel();
 	before = &inode->i_flock;
 
 	while ((fl = *before) != NULL) {
@@ -1678,7 +1689,7 @@
  		}
 		before = &fl->fl_next;
 	}
-	release_fl_sem();
+	unlock_kernel();
 }
 
 /**
@@ -1691,9 +1702,7 @@
 void
 posix_block_lock(struct file_lock *blocker, struct file_lock *waiter)
 {
-	acquire_fl_sem();
 	locks_insert_block(blocker, waiter);
-	release_fl_sem();
 }
 
 /**
@@ -1705,12 +1714,8 @@
 void
 posix_unblock_lock(struct file_lock *waiter)
 {
-	acquire_fl_sem();
-	if (!list_empty(&waiter->fl_block)) {
+	if (!list_empty(&waiter->fl_block))
 		locks_delete_block(waiter);
-		wake_up(&waiter->fl_wait);
-	}
-	release_fl_sem();
 }
 
 static void lock_get_status(char* out, struct file_lock *fl, int id, char *pfx)
@@ -1801,7 +1806,7 @@
 	off_t pos = 0;
 	int i = 0;
 
-	acquire_fl_sem();
+	lock_kernel();
 	list_for_each(tmp, &file_lock_list) {
 		struct list_head *btmp;
 		struct file_lock *fl = list_entry(tmp, struct file_lock, fl_link);
@@ -1822,7 +1827,7 @@
 		}
 	}
 done:
-	release_fl_sem();
+	unlock_kernel();
 	*start = buffer;
 	if(q-buffer < length)
 		return (q-buffer);
@@ -1847,7 +1852,7 @@
 {
 	struct file_lock *fl;
 	int result = 1;
-	acquire_fl_sem();
+	lock_kernel();
 	for (fl = inode->i_flock; fl != NULL; fl = fl->fl_next) {
 		if (fl->fl_flags == FL_POSIX) {
 			if (fl->fl_type == F_RDLCK)
@@ -1864,7 +1869,7 @@
 		result = 0;
 		break;
 	}
-	release_fl_sem();
+	unlock_kernel();
 	return result;
 }
 
@@ -1885,7 +1890,7 @@
 {
 	struct file_lock *fl;
 	int result = 1;
-	acquire_fl_sem();
+	lock_kernel();
 	for (fl = inode->i_flock; fl != NULL; fl = fl->fl_next) {
 		if (fl->fl_flags == FL_POSIX) {
 			if ((fl->fl_end < start) || (fl->fl_start > (start + len)))
@@ -1900,7 +1905,7 @@
 		result = 0;
 		break;
 	}
-	release_fl_sem();
+	unlock_kernel();
 	return result;
 }
 #endif
diff -u --recursive --new-file linux-2.4.0-test10/include/linux/fs.h linux-2.4.0-lockd/include/linux/fs.h
--- linux-2.4.0-test10/include/linux/fs.h	Tue Oct 31 20:18:05 2000
+++ linux-2.4.0-lockd/include/linux/fs.h	Tue Nov  7 00:51:43 2000
@@ -546,7 +546,6 @@
 #endif
 
 extern struct list_head file_lock_list;
-extern struct semaphore file_lock_sem;
 
 #include <linux/fcntl.h>
 
diff -u --recursive --new-file linux-2.4.0-test10/kernel/ksyms.c linux-2.4.0-lockd/kernel/ksyms.c
--- linux-2.4.0-test10/kernel/ksyms.c	Mon Oct 30 19:50:27 2000
+++ linux-2.4.0-lockd/kernel/ksyms.c	Tue Nov  7 00:32:44 2000
@@ -215,7 +215,6 @@
 EXPORT_SYMBOL(page_hash_bits);
 EXPORT_SYMBOL(page_hash_table);
 EXPORT_SYMBOL(file_lock_list);
-EXPORT_SYMBOL(file_lock_sem);
 EXPORT_SYMBOL(locks_init_lock);
 EXPORT_SYMBOL(locks_copy_lock);
 EXPORT_SYMBOL(posix_lock_file);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
