Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129091AbQKDOmf>; Sat, 4 Nov 2000 09:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129095AbQKDOmZ>; Sat, 4 Nov 2000 09:42:25 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:1983 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129091AbQKDOmV>; Sat, 4 Nov 2000 09:42:21 -0500
Message-ID: <3A042031.A170B555@uow.edu.au>
Date: Sun, 05 Nov 2000 01:41:53 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>,
        Trond Myklebust <trond.myklebust@fys.uio.no>,
        Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Multithreaded locks.c
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Gentlemen,

Here's a patch which fully multithreads the file locking code.

The functionality is unchanged, however I wonder if we actually
have got it right.  Does anyone know what this part of the
flock(2) manpage means?

       A  single file may not simultaneously have both shared and
       exclusive locks.

I'm not able to generate any code which triggers this error.
The implementation actually handles this case by detecting
when a flock transits from LOCK_EX to LOCK_SH and waking up
any LOCK_EX waiters.  The BSD manpage isn't very helpful either.
I think this should be an error.  If it were, locks.c could become
significantly simpler.


Commentary:

- This patch includes changes which were covered in Trond's recent
  patch, vis:

    - Drop semaphore when we call fl_notify hooks. This is to allow the
      notification routines to call posix_unblock_lock().

      (I didn't do this - it would have introduced a lot of races.
       Instead, posix_unlock_block() requires that the per-inode
       lock be held, and doesn't do the lock itself)

    - In locks_wake_up_blocks(), drop semaphore when we're asking the
      waiter waiter to unblock, and reorder loop to protect against the
      waiter disappearing beneath us while we're not holding the
      semaphore.

    - locks_delete_lock() should not call file->f_op->lock().  The
      latter notifies the *server*, hence calling it from routines like
      posix_lock_file() while merging/unmerging locks in our internal
      representation of the locks is a bug.

    - A new function locks_unlock_delete() takes care of the special
      case when we're freeing all locks upon close() and drops the
      semaphore before notifying the server.

- The global semaphore has gone.  In its place are per-inode
  spinlocks and a global spinlock to protect the two global lists.

- Fixed the deadlock where nlmsvc_notify_blocked() calls
  posix_unblock_lock() with the global semaphore held.

- There was a bug in nlmsvc_notify_blocked() - it can return
  with the BKL held.

- The locking rules are:

  fl_notify(), fl_insert() and fl_remove() are called with the
  per-inode spinlock held.  They may not sleep (they don't at
  present).  If it's a requirement that these be able to
  sleep then we have a medium-sized mess on our hands.

  file_operations.lock() is always called with no locks held.
  It may sleep.

- I introduced a funky naming convention where functions which
  require that the per-inode spinlock be held end in `_ilr'.
  This helped a lot in getting the locking right.


--- linux-2.4.0-test10/include/linux/fs.h	Sat Nov  4 16:22:49 2000
+++ linux-akpm/include/linux/fs.h	Sat Nov  4 21:07:05 2000
@@ -405,6 +405,7 @@
 	struct super_block	*i_sb;
 	wait_queue_head_t	i_wait;
 	struct file_lock	*i_flock;
+	spinlock_t		i_flock_lock;
 	struct address_space	*i_mapping;
 	struct address_space	i_data;	
 	struct dquot		*i_dquot[MAXQUOTAS];
@@ -546,7 +547,7 @@
 #endif
 
 extern struct list_head file_lock_list;
-extern struct semaphore file_lock_sem;
+extern spinlock_t file_locks_lock;
 
 #include <linux/fcntl.h>
 
--- linux-2.4.0-test10/fs/lockd/clntlock.c	Sat Nov  4 16:22:49 2000
+++ linux-akpm/fs/lockd/clntlock.c	Sat Nov  4 21:07:05 2000
@@ -168,10 +168,10 @@
 	 * reclaim is in progress */
 	lock_kernel();
 	lockd_up();
-	down(&file_lock_sem);
 
 	/* First, reclaim all locks that have been granted previously. */
 restart:
+	spin_lock(&file_locks_lock);
 	tmp = file_lock_list.next;
 	while (tmp != &file_lock_list) {
 		struct file_lock *fl = list_entry(tmp, struct file_lock, fl_link);
@@ -181,12 +181,13 @@
 				fl->fl_u.nfs_fl.state != host->h_state &&
 				(fl->fl_u.nfs_fl.flags & NFS_LCK_GRANTED)) {
 			fl->fl_u.nfs_fl.flags &= ~ NFS_LCK_GRANTED;
+			spin_unlock(&file_locks_lock);
 			nlmclnt_reclaim(host, fl);
 			goto restart;
 		}
 		tmp = tmp->next;
 	}
-	up(&file_lock_sem);
+	spin_unlock(&file_locks_lock);
 
 	host->h_reclaiming = 0;
 	wake_up(&host->h_gracewait);
--- linux-2.4.0-test10/fs/lockd/clntproc.c	Sat Nov  4 16:22:49 2000
+++ linux-akpm/fs/lockd/clntproc.c	Sat Nov  4 22:07:49 2000
@@ -404,6 +404,11 @@
 	return 0;
 }
 
+/*
+ * VFS callback for file lock insertion.
+ *
+ * This function is not allowed to sleep.
+ */
 static
 void nlmclnt_insert_lock_callback(struct file_lock *fl)
 {
@@ -411,6 +416,12 @@
 	nlm_get_host(fl->fl_u.nfs_fl.host);
 	unlock_kernel();
 }
+
+/*
+ * VFS callback for file lock removal.
+ *
+ * This function is not allowed to sleep.
+ */
 static
 void nlmclnt_remove_lock_callback(struct file_lock *fl)
 {
--- linux-2.4.0-test10/fs/locks.c	Sat Nov  4 16:22:49 2000
+++ linux-akpm/fs/locks.c	Sun Nov  5 01:38:59 2000
@@ -113,6 +113,31 @@
  *  Leases and LOCK_MAND
  *  Matthew Wilcox <willy@linuxcare.com>, June, 2000.
  *  Stephen Rothwell <sfr@linuxcare.com>, June, 2000.
+ *
+ *  Replace global semaphore with:
+ *     per-inode spinlock for the per-inode list
+ *     global spinlock `file_locks_lock' for the global file_lock_list and blocked_list
+ *  Andrew Morton <andrewm@uow.edu.au>, Nov, 2000.
+ */
+
+/*
+ * README: locking and naming conventions.
+ *
+ * The spinlock inode.i_flock_lock protects the entire list of locks which hangs off
+ * the inode.
+ *
+ * Functions which require that the inode lock be held are named *_ilr (inode lock required)
+ * Functions which require that the inode lock be free are named *_ilf (inode lock free)
+ * Functions which don't care or which have extern scope use neither suffix
+ * *_ilf functions either acquire the lock or sleep.
+ *
+ * The global spinlock file_locks_lock protects the globals `file_lock_list' and
+ * `blocked_list'.  We use a single lock for these because file_lock.fl_link
+ * can reside on either list, and we don't know which list it is on when
+ * we do a list_del(file_lock.fl_link)
+ *
+ * The three callout functions file_lock.fl_notify, .fl_insert and .fl_remove
+ * are called with the inode spinlock held.  Hence they cannot sleep!
  */
 
 #include <linux/malloc.h>
@@ -125,10 +150,7 @@
 #include <asm/semaphore.h>
 #include <asm/uaccess.h>
 
-DECLARE_MUTEX(file_lock_sem);
-
-#define acquire_fl_sem()	down(&file_lock_sem)
-#define release_fl_sem()	up(&file_lock_sem)
+spinlock_t file_locks_lock = SPIN_LOCK_UNLOCKED;
 
 int leases_enable = 1;
 int lease_break_time = 45;
@@ -352,29 +374,27 @@
 #endif
 
 /* Allocate a file_lock initialised to this type of lease */
-static int lease_alloc(struct file *filp, int type, struct file_lock **flp)
+static struct file_lock *lease_alloc_ilf(struct file *filp, int type)
 {
 	struct file_lock *fl = locks_alloc_lock(1);
-	if (fl == NULL)
-		return -ENOMEM;
-
-	fl->fl_owner = current->files;
-	fl->fl_pid = current->pid;
+	if (fl != NULL) {
+		fl->fl_owner = current->files;
+		fl->fl_pid = current->pid;
 
-	fl->fl_file = filp;
-	fl->fl_flags = FL_LEASE;
-	if (assign_type(fl, type) != 0) {
-		locks_free_lock(fl);
-		return -EINVAL;
+		fl->fl_file = filp;
+		fl->fl_flags = FL_LEASE;
+		if (assign_type(fl, type) != 0) {
+			locks_free_lock(fl);
+			fl = NULL;
+		} else {
+			fl->fl_start = 0;
+			fl->fl_end = OFFSET_MAX;
+			fl->fl_notify = NULL;
+			fl->fl_insert = NULL;
+			fl->fl_remove = NULL;
+		}
 	}
-	fl->fl_start = 0;
-	fl->fl_end = OFFSET_MAX;
-	fl->fl_notify = NULL;
-	fl->fl_insert = NULL;
-	fl->fl_remove = NULL;
-
-	*flp = fl;
-	return 0;
+	return fl;
 }
 
 /* Check if two locks overlap each other.
@@ -400,11 +420,13 @@
 /* Remove waiter from blocker's block list.
  * When blocker ends up pointing to itself then the list is empty.
  */
-static void locks_delete_block(struct file_lock *waiter)
+static void locks_delete_block_ilr(struct file_lock *waiter)
 {
 	list_del(&waiter->fl_block);
 	INIT_LIST_HEAD(&waiter->fl_block);
+	spin_lock(&file_locks_lock);
 	list_del(&waiter->fl_link);
+	spin_unlock(&file_locks_lock);
 	INIT_LIST_HEAD(&waiter->fl_link);
 	waiter->fl_next = NULL;
 }
@@ -414,43 +436,60 @@
  * the order they blocked. The documentation doesn't require this but
  * it seems like the reasonable thing to do.
  */
-static void locks_insert_block(struct file_lock *blocker, 
+static void locks_insert_block_ilr(struct file_lock *blocker, 
 			       struct file_lock *waiter)
 {
 	if (!list_empty(&waiter->fl_block)) {
-		printk(KERN_ERR "locks_insert_block: removing duplicated lock "
+		printk(KERN_ERR "locks_insert_block_ilr: removing duplicated lock "
 			"(pid=%d %Ld-%Ld type=%d)\n", waiter->fl_pid,
 			waiter->fl_start, waiter->fl_end, waiter->fl_type);
-		locks_delete_block(waiter);
+		locks_delete_block_ilr(waiter);
 	}
 	list_add_tail(&waiter->fl_block, &blocker->fl_block);
 	waiter->fl_next = blocker;
+	spin_lock(&file_locks_lock);
 	list_add(&waiter->fl_link, &blocked_list);
+	spin_unlock(&file_locks_lock);
 }
 
 /* Wake up processes blocked waiting for blocker.
  * If told to wait then schedule the processes until the block list
  * is empty, otherwise empty the block list ourselves.
+ *
+ * If (wait != 0) then we will drop the inode lock and schedule.
+ * The caller _must_ be aware that everything could have changed.
  */
-static void locks_wake_up_blocks(struct file_lock *blocker, unsigned int wait)
+static void locks_wake_up_blocks_ilr(struct file_lock *blocker, struct inode *inode, unsigned int wait)
 {
 	while (!list_empty(&blocker->fl_block)) {
 		struct file_lock *waiter = list_entry(blocker->fl_block.next, struct file_lock, fl_block);
-		/* N.B. Is it possible for the notify function to block?? */
-		if (waiter->fl_notify)
+
+		if (!wait) {
+			/* Remove waiter from the block list, because by the
+			 * time it wakes up blocker won't exist any more.
+			 */
+			locks_delete_block_ilr(waiter);
+		}
+
+		/* The notify function is not allowed to block */
+		if (waiter->fl_notify) 
 			waiter->fl_notify(waiter);
-		wake_up(&waiter->fl_wait);
+		else
+			wake_up(&waiter->fl_wait);
+
 		if (wait) {
 			/* Let the blocked process remove waiter from the
 			 * block list when it gets scheduled.
 			 */
+			spin_unlock(&inode->i_flock_lock);
 			current->policy |= SCHED_YIELD;
 			schedule();
+			spin_lock(&inode->i_flock_lock);
 		} else {
 			/* Remove waiter from the block list, because by the
 			 * time it wakes up blocker won't exist any more.
 			 */
-			locks_delete_block(waiter);
+			locks_delete_block_ilr(waiter);
 		}
 	}
 }
@@ -458,9 +497,11 @@
 /* Insert file lock fl into an inode's lock list at the position indicated
  * by pos. At the same time add the lock to the global file lock list.
  */
-static void locks_insert_lock(struct file_lock **pos, struct file_lock *fl)
+static void locks_insert_lock_ilr(struct file_lock **pos, struct file_lock *fl)
 {
+	spin_lock(&file_locks_lock);
 	list_add(&fl->fl_link, &file_lock_list);
+	spin_unlock(&file_locks_lock);
 
 	/* insert into file's list */
 	fl->fl_next = *pos;
@@ -474,40 +515,60 @@
  * Remove our lock from the lock lists, wake up processes that are blocked
  * waiting for this lock, notify the FS that the lock has been cleared and
  * finally free the lock.
+ *
+ * If (wait != 0) then we can drop the inode lock and schedule.  The caller
+ * must be aware of this.
  */
-static void locks_delete_lock(struct file_lock **thisfl_p, unsigned int wait)
+static void locks_delete_lock_ilr(struct file_lock **thisfl_p, struct inode *inode, unsigned int wait)
 {
-	int (*lock)(struct file *, int, struct file_lock *);
 	struct file_lock *fl = *thisfl_p;
 
 	*thisfl_p = fl->fl_next;
 	fl->fl_next = NULL;
 
+	spin_lock(&file_locks_lock);
 	list_del(&fl->fl_link);
+	spin_unlock(&file_locks_lock);
 	INIT_LIST_HEAD(&fl->fl_link);
 
 	fasync_helper(0, fl->fl_file, 0, &fl->fl_fasync);
 	if (fl->fl_fasync != NULL){
-		printk("locks_delete_lock: fasync == %p\n", fl->fl_fasync);
+		printk(KERN_ERR "locks_delete_lock_ilr: fasync == %p\n", fl->fl_fasync);
 		fl->fl_fasync = NULL;
 	}
 
 	if (fl->fl_remove)
 		fl->fl_remove(fl);
 
-	locks_wake_up_blocks(fl, wait);
-	lock = fl->fl_file->f_op->lock;
-	if (lock) {
+	locks_wake_up_blocks_ilr(fl, inode, wait);
+	locks_free_lock(fl);
+}
+
+/*
+ * Call back client filesystem in order to get it to unregister a lock,
+ * then delete lock. Essentially useful only in locks_remove_*().
+ * Note: this must be called with the semaphore already held!
+ *
+ * This function drops the lock.  The caller must be aware of this.
+ */
+static inline void locks_unlock_delete_ilr(struct file_lock **thisfl_p, struct inode *inode)
+{
+	struct file_lock *fl = *thisfl_p;
+	int (*lock)(struct file *, int, struct file_lock *);
+
+	if ((lock = fl->fl_file->f_op->lock) != NULL) {
 		fl->fl_type = F_UNLCK;
+		spin_unlock(&inode->i_flock_lock);
 		lock(fl->fl_file, F_SETLK, fl);
+		spin_lock(&inode->i_flock_lock);
 	}
-	locks_free_lock(fl);
+	locks_delete_lock_ilr(thisfl_p, inode, 0);
 }
 
 /* Determine if lock sys_fl blocks lock caller_fl. Common functionality
  * checks for shared/exclusive status of overlapping locks.
  */
-static int locks_conflict(struct file_lock *caller_fl, struct file_lock *sys_fl)
+static int locks_conflict_ilr(struct file_lock *caller_fl, struct file_lock *sys_fl)
 {
 	switch (caller_fl->fl_type) {
 	case F_RDLCK:
@@ -517,7 +578,7 @@
 		return (1);
 
 	default:
-		printk("locks_conflict(): impossible lock type - %d\n",
+		printk(KERN_ERR "locks_conflict_ilr(): impossible lock type - %d\n",
 		       caller_fl->fl_type);
 		break;
 	}
@@ -525,9 +586,11 @@
 }
 
 /* Determine if lock sys_fl blocks lock caller_fl. POSIX specific
- * checking before calling the locks_conflict().
+ * checking before calling the locks_conflict_ilr().
+ *
+ * Caller must ensure that caller_fl and sys_fl are locked down.
  */
-static int posix_locks_conflict(struct file_lock *caller_fl, struct file_lock *sys_fl)
+static int posix_locks_conflict_ilr(struct file_lock *caller_fl, struct file_lock *sys_fl)
 {
 	/* POSIX locks owned by the same process do not conflict with
 	 * each other.
@@ -540,13 +603,15 @@
 	if (!locks_overlap(caller_fl, sys_fl))
 		return 0;
 
-	return (locks_conflict(caller_fl, sys_fl));
+	return (locks_conflict_ilr(caller_fl, sys_fl));
 }
 
 /* Determine if lock sys_fl blocks lock caller_fl. FLOCK specific
- * checking before calling the locks_conflict().
+ * checking before calling the locks_conflict_ilr().
+ *
+ * Caller must ensure that caller_fl and sys_fl are locked down.
  */
-static int flock_locks_conflict(struct file_lock *caller_fl, struct file_lock *sys_fl)
+static int flock_locks_conflict_ilr(struct file_lock *caller_fl, struct file_lock *sys_fl)
 {
 	/* FLOCK locks referring to the same filp do not conflict with
 	 * each other.
@@ -559,45 +624,48 @@
 		return 0;
 #endif
 
-	return (locks_conflict(caller_fl, sys_fl));
+	return (locks_conflict_ilr(caller_fl, sys_fl));
 }
 
-int interruptible_sleep_on_locked(wait_queue_head_t *fl_wait, struct semaphore *sem, int timeout)
+static int interruptible_sleep_on_locked_ilr(wait_queue_head_t *fl_wait, int timeout, struct inode *inode)
 {
 	int result = 0;
 	wait_queue_t wait;
 	init_waitqueue_entry(&wait, current);
 
 	__add_wait_queue(fl_wait, &wait);
-	current->state = TASK_INTERRUPTIBLE;
-	up(sem);
+	set_current_state(TASK_INTERRUPTIBLE);
+	spin_unlock(&inode->i_flock_lock);
 	if (timeout == 0)
 		schedule();
 	else
 		result = schedule_timeout(timeout);
 	if (signal_pending(current))
 		result = -ERESTARTSYS;
-	down(sem);
+	spin_lock(&inode->i_flock_lock);
 	remove_wait_queue(fl_wait, &wait);
 	current->state = TASK_RUNNING;
 	return result;
 }
 
-static int locks_block_on(struct file_lock *blocker, struct file_lock *waiter)
+/* inode spinlock: held */
+static int locks_block_on_ilr(struct file_lock *blocker, struct file_lock *waiter, struct inode *inode)
 {
 	int result;
-	locks_insert_block(blocker, waiter);
-	result = interruptible_sleep_on_locked(&waiter->fl_wait, &file_lock_sem, 0);
-	locks_delete_block(waiter);
+	locks_insert_block_ilr(blocker, waiter);
+	result = interruptible_sleep_on_locked_ilr(&waiter->fl_wait, 0, inode);
+	locks_delete_block_ilr(waiter);
 	return result;
 }
 
-static int locks_block_on_timeout(struct file_lock *blocker, struct file_lock *waiter, int time)
+/* inode spinlock: held */
+static int locks_block_on_timeout_ilr(struct file_lock *blocker, struct file_lock *waiter,
+					struct inode *inode, int time)
 {
 	int result;
-	locks_insert_block(blocker, waiter);
-	result = interruptible_sleep_on_locked(&waiter->fl_wait, &file_lock_sem, time);
-	locks_delete_block(waiter);
+	locks_insert_block_ilr(blocker, waiter);
+	result = interruptible_sleep_on_locked_ilr(&waiter->fl_wait, time, inode);
+	locks_delete_block_ilr(waiter);
 	return result;
 }
 
@@ -605,15 +673,16 @@
 posix_test_lock(struct file *filp, struct file_lock *fl)
 {
 	struct file_lock *cfl;
+	struct inode *inode = filp->f_dentry->d_inode;
 
-	acquire_fl_sem();
-	for (cfl = filp->f_dentry->d_inode->i_flock; cfl; cfl = cfl->fl_next) {
+	spin_lock(&inode->i_flock_lock);
+	for (cfl = inode->i_flock; cfl; cfl = cfl->fl_next) {
 		if (!(cfl->fl_flags & FL_POSIX))
 			continue;
-		if (posix_locks_conflict(cfl, fl))
+		if (posix_locks_conflict_ilr(cfl, fl))
 			break;
 	}
-	release_fl_sem();
+	spin_unlock(&inode->i_flock_lock);
 
 	return (cfl);
 }
@@ -631,6 +700,8 @@
  * Note: the above assumption may not be true when handling lock requests
  * from a broken NFS client. But broken NFS clients have a lot more to
  * worry about than proper deadlock detection anyway... --okir
+ *
+ * The caller must ensure that caller_fl and block_fl are locked down.
  */
 static int posix_locks_deadlock(struct file_lock *caller_fl,
 				struct file_lock *block_fl)
@@ -644,6 +715,7 @@
 	blocked_owner = block_fl->fl_owner;
 	blocked_pid = block_fl->fl_pid;
 
+	spin_lock(&file_locks_lock);		/* for `blocker' */
 next_task:
 	if (caller_owner == blocked_owner && caller_pid == blocked_pid)
 		return 1;
@@ -657,6 +729,7 @@
 			goto next_task;
 		}
 	}
+	spin_unlock(&file_locks_lock);
 	return 0;
 }
 
@@ -668,14 +741,14 @@
 	/*
 	 * Search the lock list for this inode for any POSIX locks.
 	 */
-	acquire_fl_sem();
+	spin_lock(&inode->i_flock_lock);
 	for (fl = inode->i_flock; fl != NULL; fl = fl->fl_next) {
 		if (!(fl->fl_flags & FL_POSIX))
 			continue;
 		if (fl->fl_owner != owner)
 			break;
 	}
-	release_fl_sem();
+	spin_unlock(&inode->i_flock_lock);
 	return fl ? -EAGAIN : 0;
 }
 
@@ -696,7 +769,7 @@
 	new_fl->fl_end = offset + count - 1;
 
 	error = 0;
-	acquire_fl_sem();
+	spin_lock(&inode->i_flock_lock);
 
 repeat:
 	/* Search the lock list for this inode for locks that conflict with
@@ -707,7 +780,7 @@
 			continue;
 		if (fl->fl_start > new_fl->fl_end)
 			break;
-		if (posix_locks_conflict(new_fl, fl)) {
+		if (posix_locks_conflict_ilr(new_fl, fl)) {
 			error = -EAGAIN;
 			if (filp && (filp->f_flags & O_NONBLOCK))
 				break;
@@ -715,7 +788,7 @@
 			if (posix_locks_deadlock(new_fl, fl))
 				break;
 	
-			error = locks_block_on(fl, new_fl);
+			error = locks_block_on_ilr(fl, new_fl, inode);
 			if (error != 0)
 				break;
 	
@@ -729,7 +802,7 @@
 		}
 	}
 	locks_free_lock(new_fl);
-	release_fl_sem();
+	spin_unlock(&inode->i_flock_lock);
 	return error;
 }
 
@@ -758,6 +831,7 @@
 	}
 
 	error = 0;
+	spin_lock(&inode->i_flock_lock);
 search:
 	change = 0;
 	before = &inode->i_flock;
@@ -775,9 +849,21 @@
 	 */
 	if (change) {
 		/* N.B. What if the wait argument is false? */
-		locks_delete_lock(before, !unlock);
 		/*
-		 * If we waited, another lock may have been added ...
+		 * AKPM: this is the ONLY caller of locks_delete_lock and
+		 * locks_unlock_delete who can cause those functions
+		 * to drop the spinlock.  So make sure we make no
+		 * assumptions about state after this function returns.
+		 *
+		 * And yeah: what if the wait argument _is_ false?
+		 * We're supposed to return EWOULDBLOCK.
+		 *
+		 * But according to the BSD manpage we shouldn't get here
+		 * anyway.
+		 */
+		locks_delete_lock_ilr(before, inode, !unlock);
+		/*
+		 * If we waited, other locks could have been added or removed.
 		 */
 		if (!unlock)
 			goto search;
@@ -788,21 +874,22 @@
 repeat:
 	for (fl = inode->i_flock; (fl != NULL) && (fl->fl_flags & FL_FLOCK);
 	     fl = fl->fl_next) {
-		if (!flock_locks_conflict(new_fl, fl))
+		if (!flock_locks_conflict_ilr(new_fl, fl))
 			continue;
 		error = -EAGAIN;
 		if (!wait)
 			goto out;
-		error = locks_block_on(fl, new_fl);
+		error = locks_block_on_ilr(fl, new_fl, inode);
 		if (error != 0)
 			goto out;
 		goto repeat;
 	}
-	locks_insert_lock(&inode->i_flock, new_fl);
+	locks_insert_lock_ilr(&inode->i_flock, new_fl);
 	new_fl = NULL;
 	error = 0;
 
 out:
+	spin_unlock(&inode->i_flock_lock);
 	if (new_fl)
 		locks_free_lock(new_fl);
 	return error;
@@ -847,13 +934,13 @@
 	if (!(new_fl && new_fl2))
 		goto out;
 
-	acquire_fl_sem();
+	spin_lock(&inode->i_flock_lock);
 	if (caller->fl_type != F_UNLCK) {
   repeat:
 		for (fl = inode->i_flock; fl != NULL; fl = fl->fl_next) {
 			if (!(fl->fl_flags & FL_POSIX))
 				continue;
-			if (!posix_locks_conflict(caller, fl))
+			if (!posix_locks_conflict_ilr(caller, fl))
 				continue;
 			error = -EAGAIN;
 			if (!wait)
@@ -862,7 +949,7 @@
 			if (posix_locks_deadlock(caller, fl))
 				goto out;
 
-			error = locks_block_on(fl, caller);
+			error = locks_block_on_ilr(fl, caller, inode);
 			if (error != 0)
 				goto out;
 			goto repeat;
@@ -913,7 +1000,7 @@
 			else
 				caller->fl_end = fl->fl_end;
 			if (added) {
-				locks_delete_lock(before, 0);
+				locks_delete_lock_ilr(before, inode, 0);
 				continue;
 			}
 			caller = fl;
@@ -943,7 +1030,7 @@
 				 * one (This may happen several times).
 				 */
 				if (added) {
-					locks_delete_lock(before, 0);
+					locks_delete_lock_ilr(before, inode, 0);
 					continue;
 				}
 				/* Replace the old lock with the new one.
@@ -951,7 +1038,7 @@
 				 * as the change in lock type might satisfy
 				 * their needs.
 				 */
-				locks_wake_up_blocks(fl, 0);
+				locks_wake_up_blocks_ilr(fl, inode, 0);
 				fl->fl_start = caller->fl_start;
 				fl->fl_end = caller->fl_end;
 				fl->fl_type = caller->fl_type;
@@ -971,7 +1058,7 @@
 		if (caller->fl_type == F_UNLCK)
 			goto out;
 		locks_copy_lock(new_fl, caller);
-		locks_insert_lock(before, new_fl);
+		locks_insert_lock_ilr(before, new_fl);
 		new_fl = NULL;
 	}
 	if (right) {
@@ -982,17 +1069,17 @@
 			left = new_fl2;
 			new_fl2 = NULL;
 			locks_copy_lock(left, right);
-			locks_insert_lock(before, left);
+			locks_insert_lock_ilr(before, left);
 		}
 		right->fl_start = caller->fl_end + 1;
-		locks_wake_up_blocks(right, 0);
+		locks_wake_up_blocks_ilr(right, inode, 0);
 	}
 	if (left) {
 		left->fl_end = caller->fl_start - 1;
-		locks_wake_up_blocks(left, 0);
+		locks_wake_up_blocks_ilr(left, inode, 0);
 	}
 out:
-	release_fl_sem();
+	spin_unlock(&inode->i_flock_lock);
 	/*
 	 * Free any unused locks.
 	 */
@@ -1034,11 +1121,14 @@
 	int error = 0, future;
 	struct file_lock *new_fl, *flock;
 	struct file_lock *fl;
-	int alloc_err;
 
-	alloc_err = lease_alloc(NULL, 0, &new_fl);
+	new_fl = lease_alloc_ilf(NULL, 0);
+	if (new_fl == NULL) {
+		error = -ENOMEM;
+		goto out_no_fl;
+	}
 
-	acquire_fl_sem();
+	spin_lock(&inode->i_flock_lock);
 	flock = inode->i_flock;
 	if (flock->fl_type & F_INPROGRESS) {
 		if ((mode & O_NONBLOCK)
@@ -1046,12 +1136,8 @@
 			error = -EWOULDBLOCK;
 			goto out;
 		}
-		if (alloc_err != 0) {
-			error = alloc_err;
-			goto out;
-		}
 		do {
-			error = locks_block_on(flock, new_fl);
+			error = locks_block_on_ilr(flock, new_fl, inode);
 			if (error != 0)
 				goto out;
 			flock = inode->i_flock;
@@ -1071,11 +1157,6 @@
 		goto out;
 	}
 
-	if (alloc_err && (flock->fl_owner != current->files)) {
-		error = alloc_err;
-		goto out;
-	}
-
 	fl = flock;
 	do {
 		fl->fl_type = future;
@@ -1094,10 +1175,10 @@
 	else
 		error = 0;
 restart:
-	error = locks_block_on_timeout(flock, new_fl, error);
+	error = locks_block_on_timeout_ilr(flock, new_fl, inode, error);
 	if (error == 0) {
 		/* We timed out.  Unilaterally break the lease. */
-		locks_delete_lock(&inode->i_flock, 0);
+		locks_delete_lock_ilr(&inode->i_flock, inode, 0);
 		printk(KERN_WARNING "lease timed out\n");
 	} else if (error > 0) {
 		flock = inode->i_flock;
@@ -1107,9 +1188,9 @@
 	}
 
 out:
-	release_fl_sem();
-	if (!alloc_err)
-		locks_free_lock(new_fl);
+	spin_unlock(&inode->i_flock_lock);
+	locks_free_lock(new_fl);
+out_no_fl:
 	return error;
 }
 
@@ -1152,22 +1233,26 @@
 	return fl->fl_type & ~F_INPROGRESS;
 }
 
-/* We already had a lease on this file; just change its type */
-static int lease_modify(struct file_lock **before, int arg, int fd, struct file *filp)
+/*
+ * We already had a lease on this file; just change its type
+ */
+
+static int lease_modify_ilr(struct file_lock **before, int arg, int fd, struct file *filp)
 {
 	struct file_lock *fl = *before;
+	struct inode *inode = filp->f_dentry->d_inode;
 	int error = assign_type(fl, arg);
 	if (error < 0)
 		goto out;
 
-	locks_wake_up_blocks(fl, 0);
+	locks_wake_up_blocks_ilr(fl, inode, 0);
 
 	if (arg == F_UNLCK) {
 		filp->f_owner.pid = 0;
 		filp->f_owner.uid = 0;
 		filp->f_owner.euid = 0;
 		filp->f_owner.signum = 0;
-		locks_delete_lock(before, 0);
+		locks_delete_lock_ilr(before, inode, 0);
 		fasync_helper(fd, filp, 0, &fl->fl_fasync);
 	}
 
@@ -1187,7 +1272,7 @@
  */
 int fcntl_setlease(unsigned int fd, struct file *filp, long arg)
 {
-	struct file_lock *fl, **before, **my_before = NULL;
+	struct file_lock *fl, *new_fl, **before, **my_before = NULL;
 	struct dentry *dentry;
 	struct inode *inode;
 	int error, rdlease_count = 0, wrlease_count = 0;
@@ -1210,7 +1295,13 @@
 
 	before = &inode->i_flock;
 
-	acquire_fl_sem();
+	new_fl = lease_alloc_ilf(filp, arg);
+	if (new_fl == NULL) {
+		error = -ENOMEM;
+		goto out;
+	}
+
+	spin_lock(&inode->i_flock_lock);
 
 	while ((fl = *before) != NULL) {
 		if (fl->fl_flags != FL_LEASE)
@@ -1231,7 +1322,7 @@
 	}
 
 	if (my_before != NULL) {
-		error = lease_modify(my_before, arg, fd, filp);
+		error = lease_modify_ilr(my_before, arg, fd, filp);
 		goto out_unlock;
 	}
 
@@ -1245,9 +1336,8 @@
 		goto out_unlock;
 	}
 
-	error = lease_alloc(filp, arg, &fl);
-	if (error)
-		goto out_unlock;
+	fl = new_fl;
+	new_fl = NULL;
 
 	error = fasync_helper(fd, filp, 1, &fl->fl_fasync);
 	if (error < 0) {
@@ -1256,12 +1346,17 @@
 	}
 	fl->fl_next = *before;
 	*before = fl;
+	spin_lock(&file_locks_lock);
 	list_add(&fl->fl_link, &file_lock_list);
+	spin_unlock(&file_locks_lock);
 	filp->f_owner.pid = current->pid;
 	filp->f_owner.uid = current->uid;
 	filp->f_owner.euid = current->euid;
 out_unlock:
-	release_fl_sem();
+	spin_unlock(&inode->i_flock_lock);
+out:
+	if (new_fl)
+		locks_free_lock(new_fl);
 	return error;
 }
 
@@ -1307,10 +1402,8 @@
 		&& !(filp->f_mode & 3))
 		goto out_putf;
 
-	acquire_fl_sem();
 	error = flock_lock_file(filp, type,
 				(cmd & (LOCK_UN | LOCK_NB)) ? 0 : 1);
-	release_fl_sem();
 
 out_putf:
 	fput(filp);
@@ -1643,16 +1736,18 @@
 		 */
 		return;
 	}
-	acquire_fl_sem();
+again:
+	spin_lock(&inode->i_flock_lock);
 	before = &inode->i_flock;
 	while ((fl = *before) != NULL) {
 		if ((fl->fl_flags & FL_POSIX) && fl->fl_owner == owner) {
-			locks_delete_lock(before, 0);
-			continue;
+			locks_unlock_delete_ilr(before, inode);		/* This opens the inode spinlock */
+			spin_unlock(&inode->i_flock_lock);
+			goto again;
 		}
 		before = &fl->fl_next;
 	}
-	release_fl_sem();
+	spin_unlock(&inode->i_flock_lock);
 }
 
 /*
@@ -1667,18 +1762,18 @@
 	if (!inode->i_flock)
 		return;
 
-	acquire_fl_sem();
+	spin_lock(&inode->i_flock_lock);
 	before = &inode->i_flock;
 
 	while ((fl = *before) != NULL) {
 		if ((fl->fl_flags & (FL_FLOCK|FL_LEASE))
 		    && (fl->fl_file == filp)) {
-			locks_delete_lock(before, 0);
+			locks_delete_lock_ilr(before, inode, 0);
 			continue;
  		}
 		before = &fl->fl_next;
 	}
-	release_fl_sem();
+	spin_unlock(&inode->i_flock_lock);
 }
 
 /**
@@ -1691,9 +1786,7 @@
 void
 posix_block_lock(struct file_lock *blocker, struct file_lock *waiter)
 {
-	acquire_fl_sem();
-	locks_insert_block(blocker, waiter);
-	release_fl_sem();
+	locks_insert_block_ilr(blocker, waiter);
 }
 
 /**
@@ -1701,16 +1794,16 @@
  *	@waiter: the lock which was waiting
  *
  *	lockd needs to block waiting for locks.
+ *	The caller must ensure that locking is in place to
+ *	protect *waiter's list.
  */
 void
 posix_unblock_lock(struct file_lock *waiter)
 {
-	acquire_fl_sem();
 	if (!list_empty(&waiter->fl_block)) {
-		locks_delete_block(waiter);
+		locks_delete_block_ilr(waiter);
 		wake_up(&waiter->fl_wait);
 	}
-	release_fl_sem();
 }
 
 static void lock_get_status(char* out, struct file_lock *fl, int id, char *pfx)
@@ -1801,7 +1894,7 @@
 	off_t pos = 0;
 	int i = 0;
 
-	acquire_fl_sem();
+	spin_lock(&file_locks_lock);
 	list_for_each(tmp, &file_lock_list) {
 		struct list_head *btmp;
 		struct file_lock *fl = list_entry(tmp, struct file_lock, fl_link);
@@ -1822,7 +1915,7 @@
 		}
 	}
 done:
-	release_fl_sem();
+	spin_unlock(&file_locks_lock);
 	*start = buffer;
 	if(q-buffer < length)
 		return (q-buffer);
@@ -1847,7 +1940,7 @@
 {
 	struct file_lock *fl;
 	int result = 1;
-	acquire_fl_sem();
+	spin_lock(&inode->i_flock_lock);
 	for (fl = inode->i_flock; fl != NULL; fl = fl->fl_next) {
 		if (fl->fl_flags == FL_POSIX) {
 			if (fl->fl_type == F_RDLCK)
@@ -1864,7 +1957,7 @@
 		result = 0;
 		break;
 	}
-	release_fl_sem();
+	spin_unlock(&inode->i_flock_lock);
 	return result;
 }
 
@@ -1885,7 +1978,7 @@
 {
 	struct file_lock *fl;
 	int result = 1;
-	acquire_fl_sem();
+	spin_lock(&inode->i_flock_lock);
 	for (fl = inode->i_flock; fl != NULL; fl = fl->fl_next) {
 		if (fl->fl_flags == FL_POSIX) {
 			if ((fl->fl_end < start) || (fl->fl_start > (start + len)))
@@ -1900,7 +1993,7 @@
 		result = 0;
 		break;
 	}
-	release_fl_sem();
+	spin_unlock(&inode->i_flock_lock);
 	return result;
 }
 #endif
--- linux-2.4.0-test10/fs/inode.c	Sat Nov  4 16:22:49 2000
+++ linux-akpm/fs/inode.c	Sat Nov  4 21:07:05 2000
@@ -99,6 +99,7 @@
 		sema_init(&inode->i_sem, 1);
 		sema_init(&inode->i_zombie, 1);
 		spin_lock_init(&inode->i_data.i_shared_lock);
+		spin_lock_init(&inode->i_flock_lock);
 	}
 }
 
--- linux-2.4.0-test10/kernel/ksyms.c	Sat Nov  4 16:22:49 2000
+++ linux-akpm/kernel/ksyms.c	Sat Nov  4 21:07:05 2000
@@ -215,7 +215,7 @@
 EXPORT_SYMBOL(page_hash_bits);
 EXPORT_SYMBOL(page_hash_table);
 EXPORT_SYMBOL(file_lock_list);
-EXPORT_SYMBOL(file_lock_sem);
+EXPORT_SYMBOL(file_locks_lock);
 EXPORT_SYMBOL(locks_init_lock);
 EXPORT_SYMBOL(locks_copy_lock);
 EXPORT_SYMBOL(posix_lock_file);
--- linux-2.4.0-test10/fs/lockd/svclock.c	Sat Nov  4 16:22:49 2000
+++ linux-akpm/fs/lockd/svclock.c	Sat Nov  4 22:05:44 2000
@@ -460,6 +460,8 @@
  *
  * This function doesn't grant the blocked lock instantly, but rather moves
  * the block to the head of nlm_blocked where it can be picked up by lockd.
+ *
+ * This function is not allowed to sleep.
  */
 static void
 nlmsvc_notify_blocked(struct file_lock *fl)
@@ -473,6 +475,7 @@
 		if (nlm_compare_locks(&block->b_call.a_args.lock.fl, fl)) {
 			nlmsvc_insert_block(block, 0);
 			svc_wake_up(block->b_daemon);
+			unlock_kernel();
 			return;
 		}
 	}
--- linux-2.4.0-test10/Documentation/filesystems/Locking	Fri Aug 11 19:06:11 2000
+++ linux-akpm/Documentation/filesystems/Locking	Sun Nov  5 00:38:05 2000
@@ -159,10 +159,10 @@
 	void (*fl_remove)(struct file_lock *);	/* lock removal callback */
 
 locking rules:
-		BKL	may block
-fl_notify:	yes	no
-fl_insert:	yes	maybe
-fl_remove:	yes	maybe
+		BKL	file_locks_lock   inode.i_flock_lock   may block
+fl_notify:	no	     no               yes              no
+fl_insert:	no	     no               yes              no
+fl_remove:	no	     no               yes              no
 	Currently only NLM provides instances of this class. None of the
 them block. If you have out-of-tree instances - please, show up. Locking
 in that area will change.
@@ -230,7 +230,7 @@
 release:	no
 fsync:		yes	(see below)
 fasync:		yes	(see below)
-lock:		yes
+lock:		no
 readv:		no
 writev:		no
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
