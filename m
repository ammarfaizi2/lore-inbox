Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130410AbQJ1PrI>; Sat, 28 Oct 2000 11:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130722AbQJ1Pq6>; Sat, 28 Oct 2000 11:46:58 -0400
Received: from isis.its.uow.edu.au ([130.130.68.21]:60081 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S130410AbQJ1Pqw>; Sat, 28 Oct 2000 11:46:52 -0400
Message-ID: <39FAF4C6.3BB04774@uow.edu.au>
Date: Sun, 29 Oct 2000 02:46:14 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: kumon@flab.fujitsu.co.jp
CC: Andi Kleen <ak@suse.de>, Alexander Viro <viro@math.psu.edu>,
        "Jeff V. Merkey" <jmerkey@timpanogas.org>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
        Olaf Kirch <okir@monad.swb.de>
Subject: Re: [PATCH] Re: Negative scalability by removal of lock_kernel()?(Was: 
 Strange performance behavior of 2.4.0-test9)
In-Reply-To: <39F957BC.4289FF10@uow.edu.au>,
		<39F92187.A7621A09@timpanogas.org>
		<Pine.GSO.4.21.0010270257550.18660-100000@weyl.math.psu.edu>
		<20001027094613.A18382@gruyere.muc.suse.de>
		<39F957BC.4289FF10@uow.edu.au> <200010271257.VAA24374@asami.proc.flab.fujitsu.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kumon@flab.fujitsu.co.jp wrote:
> 
> Change the following two macros:
>         acquire_fl_sem()->lock_kernel()
>         release_fl_sem()->unlock_kernel()
> then
> 5192 Req/s @8cpu is got. It is same as test8 within fluctuation.

hmm..  BKL increases scalability.  News at 11.

The big question is: why is Apache using file locking so
much?  Is this normal behaviour for Apache?

Because if so, the file locking code will be significantly
bad for the scalability of Apache on SMP (of all things!).
It basically grabs a big global lock for _anything_.  It
looks like it could be a lot more granular. 

> 
> I put the patch to change all occurrence of semaphore "file_lock_sem"
> into spinlock variable "file_lock_lock".

Unfortunately this is deadlocky - in several places functions
which can sleep are called when file_lock_lock is held.

More unfortunately I think we _already_ have a deadlock in
the file locking:

locks_wake_up_blocks() is always called with file_lock_sem held.
locks_wake_up_blocks() calls waiter->fl_notify(), which is really nlmsvc_notify_blocked()
nlmsvc_notify_blocked() calls posix_unblock_lock()
posix_unblock_lock() calls acquire_fl_sem()

Can someone please confirm this?

Anyway, here is a modified version of your patch which
fixes everything.

But I'm not sure that it should be applied.  I think it's
more expedient at this time to convert acquire_fl_sem/release_fl_sem
into lock_kernel/unlock_kernel (so we _can_ sleep) and to fix the
above alleged deadlock via the creation of __posix_unblock_lock() as in
this patch.


--- linux-2.4.0-test10-pre5/fs/lockd/clntlock.c	Tue Oct 24 21:34:13 2000
+++ linux-akpm/fs/lockd/clntlock.c	Sun Oct 29 00:39:15 2000
@@ -168,10 +168,10 @@
 	 * reclaim is in progress */
 	lock_kernel();
 	lockd_up();
-	down(&file_lock_sem);
 
 	/* First, reclaim all locks that have been granted previously. */
 restart:
+	spin_lock(&file_lock_lock);
 	tmp = file_lock_list.next;
 	while (tmp != &file_lock_list) {
 		struct file_lock *fl = list_entry(tmp, struct file_lock, fl_link);
@@ -181,12 +181,13 @@
 				fl->fl_u.nfs_fl.state != host->h_state &&
 				(fl->fl_u.nfs_fl.flags & NFS_LCK_GRANTED)) {
 			fl->fl_u.nfs_fl.flags &= ~ NFS_LCK_GRANTED;
+			spin_unlock(&file_lock_lock);
 			nlmclnt_reclaim(host, fl);
 			goto restart;
 		}
 		tmp = tmp->next;
 	}
-	up(&file_lock_sem);
+	spin_unlock(&file_lock_lock);
 
 	host->h_reclaiming = 0;
 	wake_up(&host->h_gracewait);
--- linux-2.4.0-test10-pre5/fs/locks.c	Tue Oct 24 21:34:13 2000
+++ linux-akpm/fs/locks.c	Sun Oct 29 02:31:10 2000
@@ -125,10 +125,9 @@
 #include <asm/semaphore.h>
 #include <asm/uaccess.h>
 
-DECLARE_MUTEX(file_lock_sem);
-
-#define acquire_fl_sem()	down(&file_lock_sem)
-#define release_fl_sem()	up(&file_lock_sem)
+spinlock_t file_lock_lock = SPIN_LOCK_UNLOCKED;
+#define acquire_fl_lock()	spin_lock(&file_lock_lock);
+#define release_fl_lock()	spin_unlock(&file_lock_lock);
 
 int leases_enable = 1;
 int lease_break_time = 45;
@@ -352,29 +351,27 @@
 #endif
 
 /* Allocate a file_lock initialised to this type of lease */
-static int lease_alloc(struct file *filp, int type, struct file_lock **flp)
+static struct file_lock *lease_alloc(struct file *filp, int type)
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
@@ -431,6 +428,9 @@
 /* Wake up processes blocked waiting for blocker.
  * If told to wait then schedule the processes until the block list
  * is empty, otherwise empty the block list ourselves.
+ *
+ * waiter->fl_notify() is not allowed to block.  Otherwise
+ * we could deadlock on file_lock_lock - AKPM.
  */
 static void locks_wake_up_blocks(struct file_lock *blocker, unsigned int wait)
 {
@@ -457,6 +457,8 @@
 
 /* Insert file lock fl into an inode's lock list at the position indicated
  * by pos. At the same time add the lock to the global file lock list.
+ *
+ * Called under file_lock_lock: fl->fl_insert may not sleep - AKPM.
  */
 static void locks_insert_lock(struct file_lock **pos, struct file_lock *fl)
 {
@@ -562,22 +564,22 @@
 	return (locks_conflict(caller_fl, sys_fl));
 }
 
-int interruptible_sleep_on_locked(wait_queue_head_t *fl_wait, struct semaphore *sem, int timeout)
+static int interruptible_sleep_on_locked(wait_queue_head_t *fl_wait, int timeout)
 {
 	int result = 0;
 	wait_queue_t wait;
 	init_waitqueue_entry(&wait, current);
 
 	__add_wait_queue(fl_wait, &wait);
-	current->state = TASK_INTERRUPTIBLE;
-	up(sem);
+	set_current_state(TASK_INTERRUPTIBLE);
+	release_fl_lock();
 	if (timeout == 0)
 		schedule();
 	else
 		result = schedule_timeout(timeout);
 	if (signal_pending(current))
 		result = -ERESTARTSYS;
-	down(sem);
+	acquire_fl_lock();
 	remove_wait_queue(fl_wait, &wait);
 	current->state = TASK_RUNNING;
 	return result;
@@ -587,7 +589,7 @@
 {
 	int result;
 	locks_insert_block(blocker, waiter);
-	result = interruptible_sleep_on_locked(&waiter->fl_wait, &file_lock_sem, 0);
+	result = interruptible_sleep_on_locked(&waiter->fl_wait, 0);
 	locks_delete_block(waiter);
 	return result;
 }
@@ -596,7 +598,7 @@
 {
 	int result;
 	locks_insert_block(blocker, waiter);
-	result = interruptible_sleep_on_locked(&waiter->fl_wait, &file_lock_sem, time);
+	result = interruptible_sleep_on_locked(&waiter->fl_wait, time);
 	locks_delete_block(waiter);
 	return result;
 }
@@ -606,14 +608,14 @@
 {
 	struct file_lock *cfl;
 
-	acquire_fl_sem();
+	acquire_fl_lock();
 	for (cfl = filp->f_dentry->d_inode->i_flock; cfl; cfl = cfl->fl_next) {
 		if (!(cfl->fl_flags & FL_POSIX))
 			continue;
 		if (posix_locks_conflict(cfl, fl))
 			break;
 	}
-	release_fl_sem();
+	release_fl_lock();
 
 	return (cfl);
 }
@@ -668,14 +670,14 @@
 	/*
 	 * Search the lock list for this inode for any POSIX locks.
 	 */
-	acquire_fl_sem();
+	acquire_fl_lock();
 	for (fl = inode->i_flock; fl != NULL; fl = fl->fl_next) {
 		if (!(fl->fl_flags & FL_POSIX))
 			continue;
 		if (fl->fl_owner != owner)
 			break;
 	}
-	release_fl_sem();
+	release_fl_lock();
 	return fl ? -EAGAIN : 0;
 }
 
@@ -696,7 +698,7 @@
 	new_fl->fl_end = offset + count - 1;
 
 	error = 0;
-	acquire_fl_sem();
+	acquire_fl_lock();
 
 repeat:
 	/* Search the lock list for this inode for locks that conflict with
@@ -729,7 +731,7 @@
 		}
 	}
 	locks_free_lock(new_fl);
-	release_fl_sem();
+	release_fl_lock();
 	return error;
 }
 
@@ -757,6 +759,8 @@
 			return error;
 	}
 
+	acquire_fl_lock();
+
 	error = 0;
 search:
 	change = 0;
@@ -803,6 +807,7 @@
 	error = 0;
 
 out:
+	release_fl_lock();
 	if (new_fl)
 		locks_free_lock(new_fl);
 	return error;
@@ -847,7 +852,7 @@
 	if (!(new_fl && new_fl2))
 		goto out;
 
-	acquire_fl_sem();
+	acquire_fl_lock();
 	if (caller->fl_type != F_UNLCK) {
   repeat:
 		for (fl = inode->i_flock; fl != NULL; fl = fl->fl_next) {
@@ -992,7 +997,7 @@
 		locks_wake_up_blocks(left, 0);
 	}
 out:
-	release_fl_sem();
+	release_fl_lock();
 	/*
 	 * Free any unused locks.
 	 */
@@ -1034,11 +1039,14 @@
 	int error = 0, future;
 	struct file_lock *new_fl, *flock;
 	struct file_lock *fl;
-	int alloc_err;
 
-	alloc_err = lease_alloc(NULL, 0, &new_fl);
+	new_fl = lease_alloc(NULL, 0);
+	if (new_fl == NULL) {
+		error = -ENOMEM;
+		goto out_no_fl;
+	}
 
-	acquire_fl_sem();
+	acquire_fl_lock();
 	flock = inode->i_flock;
 	if (flock->fl_type & F_INPROGRESS) {
 		if ((mode & O_NONBLOCK)
@@ -1046,10 +1054,6 @@
 			error = -EWOULDBLOCK;
 			goto out;
 		}
-		if (alloc_err != 0) {
-			error = alloc_err;
-			goto out;
-		}
 		do {
 			error = locks_block_on(flock, new_fl);
 			if (error != 0)
@@ -1071,11 +1075,6 @@
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
@@ -1107,9 +1106,9 @@
 	}
 
 out:
-	release_fl_sem();
-	if (!alloc_err)
-		locks_free_lock(new_fl);
+	release_fl_lock();
+	locks_free_lock(new_fl);
+out_no_fl:
 	return error;
 }
 
@@ -1152,7 +1151,12 @@
 	return fl->fl_type & ~F_INPROGRESS;
 }
 
-/* We already had a lease on this file; just change its type */
+/*
+ * We already had a lease on this file; just change its type
+ *
+ * This function may not sleep.
+ */
+
 static int lease_modify(struct file_lock **before, int arg, int fd, struct file *filp)
 {
 	struct file_lock *fl = *before;
@@ -1187,7 +1191,7 @@
  */
 int fcntl_setlease(unsigned int fd, struct file *filp, long arg)
 {
-	struct file_lock *fl, **before, **my_before = NULL;
+	struct file_lock *fl, *new_fl, **before, **my_before = NULL;
 	struct dentry *dentry;
 	struct inode *inode;
 	int error, rdlease_count = 0, wrlease_count = 0;
@@ -1210,7 +1214,13 @@
 
 	before = &inode->i_flock;
 
-	acquire_fl_sem();
+	new_fl = lease_alloc(filp, arg);
+	if (new_fl == NULL) {
+		error = -ENOMEM;
+		goto out;
+	}
+
+	acquire_fl_lock();
 
 	while ((fl = *before) != NULL) {
 		if (fl->fl_flags != FL_LEASE)
@@ -1245,9 +1255,8 @@
 		goto out_unlock;
 	}
 
-	error = lease_alloc(filp, arg, &fl);
-	if (error)
-		goto out_unlock;
+	fl = new_fl;
+	new_fl = NULL;
 
 	error = fasync_helper(fd, filp, 1, &fl->fl_fasync);
 	if (error < 0) {
@@ -1261,7 +1270,10 @@
 	filp->f_owner.uid = current->uid;
 	filp->f_owner.euid = current->euid;
 out_unlock:
-	release_fl_sem();
+	release_fl_lock();
+out:
+	if (new_fl)
+		locks_free_lock(new_fl);
 	return error;
 }
 
@@ -1307,10 +1319,8 @@
 		&& !(filp->f_mode & 3))
 		goto out_putf;
 
-	acquire_fl_sem();
 	error = flock_lock_file(filp, type,
 				(cmd & (LOCK_UN | LOCK_NB)) ? 0 : 1);
-	release_fl_sem();
 
 out_putf:
 	fput(filp);
@@ -1643,7 +1653,7 @@
 		 */
 		return;
 	}
-	acquire_fl_sem();
+	acquire_fl_lock();
 	before = &inode->i_flock;
 	while ((fl = *before) != NULL) {
 		if ((fl->fl_flags & FL_POSIX) && fl->fl_owner == owner) {
@@ -1652,7 +1662,7 @@
 		}
 		before = &fl->fl_next;
 	}
-	release_fl_sem();
+	release_fl_lock();
 }
 
 /*
@@ -1667,7 +1677,7 @@
 	if (!inode->i_flock)
 		return;
 
-	acquire_fl_sem();
+	acquire_fl_lock();
 	before = &inode->i_flock;
 
 	while ((fl = *before) != NULL) {
@@ -1678,7 +1688,7 @@
  		}
 		before = &fl->fl_next;
 	}
-	release_fl_sem();
+	release_fl_lock();
 }
 
 /**
@@ -1691,9 +1701,9 @@
 void
 posix_block_lock(struct file_lock *blocker, struct file_lock *waiter)
 {
-	acquire_fl_sem();
+	acquire_fl_lock();
 	locks_insert_block(blocker, waiter);
-	release_fl_sem();
+	release_fl_lock();
 }
 
 /**
@@ -1701,16 +1711,32 @@
  *	@waiter: the lock which was waiting
  *
  *	lockd needs to block waiting for locks.
+ *	This function locks the locklist and calls
+ *	__posix_unblock_lock()
  */
 void
 posix_unblock_lock(struct file_lock *waiter)
 {
-	acquire_fl_sem();
+	acquire_fl_lock();
+	__posix_unblock_lock(waiter);
+	release_fl_lock();
+}
+
+/**
+ *	__posix_unblock_lock - stop waiting for a file lock
+ *	@waiter: the lock which was waiting
+ *
+ *	lockd needs to block waiting for locks.
+ *	Does not lock the locklist.  This is for use within
+ *	the file_lock.fl_notify() callback.
+ */
+void
+__posix_unblock_lock(struct file_lock *waiter)
+{
 	if (!list_empty(&waiter->fl_block)) {
 		locks_delete_block(waiter);
 		wake_up(&waiter->fl_wait);
 	}
-	release_fl_sem();
 }
 
 static void lock_get_status(char* out, struct file_lock *fl, int id, char *pfx)
@@ -1801,7 +1827,7 @@
 	off_t pos = 0;
 	int i = 0;
 
-	acquire_fl_sem();
+	acquire_fl_lock();
 	list_for_each(tmp, &file_lock_list) {
 		struct list_head *btmp;
 		struct file_lock *fl = list_entry(tmp, struct file_lock, fl_link);
@@ -1822,7 +1848,7 @@
 		}
 	}
 done:
-	release_fl_sem();
+	release_fl_lock();
 	*start = buffer;
 	if(q-buffer < length)
 		return (q-buffer);
@@ -1847,7 +1873,7 @@
 {
 	struct file_lock *fl;
 	int result = 1;
-	acquire_fl_sem();
+	acquire_fl_lock();
 	for (fl = inode->i_flock; fl != NULL; fl = fl->fl_next) {
 		if (fl->fl_flags == FL_POSIX) {
 			if (fl->fl_type == F_RDLCK)
@@ -1864,7 +1890,7 @@
 		result = 0;
 		break;
 	}
-	release_fl_sem();
+	release_fl_lock();
 	return result;
 }
 
@@ -1885,7 +1911,7 @@
 {
 	struct file_lock *fl;
 	int result = 1;
-	acquire_fl_sem();
+	acquire_fl_lock();
 	for (fl = inode->i_flock; fl != NULL; fl = fl->fl_next) {
 		if (fl->fl_flags == FL_POSIX) {
 			if ((fl->fl_end < start) || (fl->fl_start > (start + len)))
@@ -1900,7 +1926,7 @@
 		result = 0;
 		break;
 	}
-	release_fl_sem();
+	release_fl_lock();
 	return result;
 }
 #endif
--- linux-2.4.0-test10-pre5/include/linux/fs.h	Tue Oct 24 21:34:13 2000
+++ linux-akpm/include/linux/fs.h	Sun Oct 29 01:45:46 2000
@@ -546,7 +546,7 @@
 #endif
 
 extern struct list_head file_lock_list;
-extern struct semaphore file_lock_sem;
+extern spinlock_t file_lock_lock;
 
 #include <linux/fcntl.h>
 
@@ -564,6 +564,7 @@
 extern struct file_lock *posix_test_lock(struct file *, struct file_lock *);
 extern int posix_lock_file(struct file *, struct file_lock *, unsigned int);
 extern void posix_block_lock(struct file_lock *, struct file_lock *);
+extern void __posix_unblock_lock(struct file_lock *);
 extern void posix_unblock_lock(struct file_lock *);
 extern int __get_lease(struct inode *inode, unsigned int flags);
 extern time_t lease_get_mtime(struct inode *);
--- linux-2.4.0-test10-pre5/kernel/ksyms.c	Sun Oct 15 01:27:46 2000
+++ linux-akpm/kernel/ksyms.c	Sat Oct 28 23:14:13 2000
@@ -215,7 +215,7 @@
 EXPORT_SYMBOL(page_hash_bits);
 EXPORT_SYMBOL(page_hash_table);
 EXPORT_SYMBOL(file_lock_list);
-EXPORT_SYMBOL(file_lock_sem);
+EXPORT_SYMBOL(file_lock_lock);
 EXPORT_SYMBOL(locks_init_lock);
 EXPORT_SYMBOL(locks_copy_lock);
 EXPORT_SYMBOL(posix_lock_file);
--- linux-2.4.0-test10-pre5/fs/lockd/svclock.c	Tue Oct 24 21:34:13 2000
+++ linux-akpm/fs/lockd/svclock.c	Sun Oct 29 01:42:47 2000
@@ -456,7 +456,7 @@
 	struct nlm_block	**bp, *block;
 
 	dprintk("lockd: VFS unblock notification for block %p\n", fl);
-	posix_unblock_lock(fl);
+	__posix_unblock_lock(fl);
 	for (bp = &nlm_blocked; (block = *bp); bp = &block->b_next) {
 		if (nlm_compare_locks(&block->b_call.a_args.lock.fl, fl)) {
 			svc_wake_up(block->b_daemon);
--- linux-2.4.0-test10-pre5/Documentation/filesystems/Locking	Fri Aug 11 19:06:11 2000
+++ linux-akpm/Documentation/filesystems/Locking	Sun Oct 29 02:25:03 2000
@@ -159,10 +159,10 @@
 	void (*fl_remove)(struct file_lock *);	/* lock removal callback */
 
 locking rules:
-		BKL	may block
-fl_notify:	yes	no
-fl_insert:	yes	maybe
-fl_remove:	yes	maybe
+		BKL	file_lock_lock    may block
+fl_notify:	no	  already held      no
+fl_insert:	no	  already held      no
+fl_remove:	no	  already held      no
 	Currently only NLM provides instances of this class. None of the
 them block. If you have out-of-tree instances - please, show up. Locking
 in that area will change.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
