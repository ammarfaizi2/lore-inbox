Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130244AbQJ0M5z>; Fri, 27 Oct 2000 08:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130365AbQJ0M5m>; Fri, 27 Oct 2000 08:57:42 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:28905 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id <S130244AbQJ0M5h>; Fri, 27 Oct 2000 08:57:37 -0400
From: kumon@flab.fujitsu.co.jp
Date: Fri, 27 Oct 2000 21:57:23 +0900
Message-Id: <200010271257.VAA24374@asami.proc.flab.fujitsu.co.jp>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Andi Kleen <ak@suse.de>, Alexander Viro <viro@math.psu.edu>,
        "Jeff V. Merkey" <jmerkey@timpanogas.org>, kumon@flab.fujitsu.co.jp,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: [PATCH] Re: Negative scalability by removal of lock_kernel()?(Was: Strange 
 performance behavior of 2.4.0-test9)
In-Reply-To: <39F957BC.4289FF10@uow.edu.au>
In-Reply-To: <39F92187.A7621A09@timpanogas.org>
	<Pine.GSO.4.21.0010270257550.18660-100000@weyl.math.psu.edu>
	<20001027094613.A18382@gruyere.muc.suse.de>
	<39F957BC.4289FF10@uow.edu.au>
Reply-To: kumon@flab.fujitsu.co.jp
Cc: kumon@flab.fujitsu.co.jp
X-Mailer: Handmade Mailer version 1.0
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
 > I bet if acquire_fl_sem() and release_fl_sem() are turned into lock_kernel()/unlock_kernel() then the scalability will come back.

Change the following two macros:
	acquire_fl_sem()->lock_kernel()
	release_fl_sem()->unlock_kernel()
then
5192 Req/s @8cpu is got. It is same as test8 within fluctuation.

>			4way->8way
>	2.4.0-test1	2816->3702 (31%up)
>	2.4.0-test8	4006->5287 (63%up)
>	2.4.0-test9	3669->2193 (40%down)

Be cautious, interruptible_sleep_on_locked() uses up()/down directly
without using acquire_fl_sem()/release_fl_sem().

As far as the logic of original test9 is correct, big kernel lock is
not needed now.

Changing lock_kernel() into local-lock, e.g. spin_lock(&mylock), I've
expected the performance be more improved, but it shows the same
performance. This means most of the kernel outdates BKL already.

I put the patch to change all occurrence of semaphore "file_lock_sem"
into spinlock variable "file_lock_lock".

Computer Systems Laboratory, Fujitsu Labs.
kumon@flab.fujitsu.co.jp


diff -ru linux-2.4.0-test9/fs/lockd/clntlock.c linux-2.4.0-test9-test/fs/lockd/clntlock.c
--- linux-2.4.0-test9/fs/lockd/clntlock.c	Sat Sep 23 06:21:18 2000
+++ linux-2.4.0-test9-test/fs/lockd/clntlock.c	Fri Oct 27 21:26:28 2000
@@ -168,7 +168,7 @@
 	 * reclaim is in progress */
 	lock_kernel();
 	lockd_up();
-	down(&file_lock_sem);
+	spin_lock(&file_lock_lock);
 
 	/* First, reclaim all locks that have been granted previously. */
 restart:
@@ -186,7 +186,7 @@
 		}
 		tmp = tmp->next;
 	}
-	up(&file_lock_sem);
+	spin_unlock(&file_lock_lock);
 
 	host->h_reclaiming = 0;
 	wake_up(&host->h_gracewait);
diff -ru linux-2.4.0-test9/fs/locks.c linux-2.4.0-test9-test/fs/locks.c
--- linux-2.4.0-test9/fs/locks.c	Mon Oct  2 11:45:29 2000
+++ linux-2.4.0-test9-test/fs/locks.c	Fri Oct 27 21:30:25 2000
@@ -125,10 +125,10 @@
 #include <asm/semaphore.h>
 #include <asm/uaccess.h>
 
-DECLARE_MUTEX(file_lock_sem);
+spinlock_t file_lock_lock = SPIN_LOCK_UNLOCKED;
+#define acquire_fl_lock()	spin_lock(&file_lock_lock);
+#define release_fl_lock()	spin_unlock(&file_lock_lock);
 
-#define acquire_fl_sem()	down(&file_lock_sem)
-#define release_fl_sem()	up(&file_lock_sem)
 
 int leases_enable = 1;
 int lease_break_time = 45;
@@ -563,7 +563,7 @@
 	return (locks_conflict(caller_fl, sys_fl));
 }
 
-int interruptible_sleep_on_locked(wait_queue_head_t *fl_wait, struct semaphore *sem, int timeout)
+int interruptible_sleep_on_locked(wait_queue_head_t *fl_wait, int timeout)
 {
 	int result = 0;
 	wait_queue_t wait;
@@ -571,14 +571,14 @@
 
 	__add_wait_queue(fl_wait, &wait);
 	current->state = TASK_INTERRUPTIBLE;
-	up(sem);
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
@@ -588,7 +588,7 @@
 {
 	int result;
 	locks_insert_block(blocker, waiter);
-	result = interruptible_sleep_on_locked(&waiter->fl_wait, &file_lock_sem, 0);
+	result = interruptible_sleep_on_locked(&waiter->fl_wait, 0);
 	locks_delete_block(waiter);
 	return result;
 }
@@ -597,7 +597,7 @@
 {
 	int result;
 	locks_insert_block(blocker, waiter);
-	result = interruptible_sleep_on_locked(&waiter->fl_wait, &file_lock_sem, time);
+	result = interruptible_sleep_on_locked(&waiter->fl_wait, time);
 	locks_delete_block(waiter);
 	return result;
 }
@@ -607,14 +607,14 @@
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
@@ -670,14 +670,14 @@
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
 
@@ -698,7 +698,7 @@
 	new_fl->fl_end = offset + count - 1;
 
 	error = 0;
-	acquire_fl_sem();
+	acquire_fl_lock();
 
 repeat:
 	/* Search the lock list for this inode for locks that conflict with
@@ -731,7 +731,7 @@
 		}
 	}
 	locks_free_lock(new_fl);
-	release_fl_sem();
+	release_fl_lock();
 	return error;
 }
 
@@ -849,7 +849,7 @@
 	if (!(new_fl && new_fl2))
 		goto out;
 
-	acquire_fl_sem();
+	acquire_fl_lock();
 	if (caller->fl_type != F_UNLCK) {
   repeat:
 		for (fl = inode->i_flock; fl != NULL; fl = fl->fl_next) {
@@ -994,7 +994,7 @@
 		locks_wake_up_blocks(left, 0);
 	}
 out:
-	release_fl_sem();
+	release_fl_lock();
 	/*
 	 * Free any unused locks.
 	 */
@@ -1040,7 +1040,7 @@
 
 	alloc_err = lease_alloc(NULL, 0, &new_fl);
 
-	acquire_fl_sem();
+	acquire_fl_lock();
 	flock = inode->i_flock;
 	if (flock->fl_type & F_INPROGRESS) {
 		if ((mode & O_NONBLOCK)
@@ -1109,7 +1109,7 @@
 	}
 
 out:
-	release_fl_sem();
+	release_fl_lock();
 	if (!alloc_err)
 		locks_free_lock(new_fl);
 	return error;
@@ -1212,7 +1212,7 @@
 
 	before = &inode->i_flock;
 
-	acquire_fl_sem();
+	acquire_fl_lock();
 
 	while ((fl = *before) != NULL) {
 		if (fl->fl_flags != FL_LEASE)
@@ -1263,7 +1263,7 @@
 	filp->f_owner.uid = current->uid;
 	filp->f_owner.euid = current->euid;
 out_unlock:
-	release_fl_sem();
+	release_fl_lock();
 	return error;
 }
 
@@ -1309,10 +1309,10 @@
 		&& !(filp->f_mode & 3))
 		goto out_putf;
 
-	acquire_fl_sem();
+	acquire_fl_lock();
 	error = flock_lock_file(filp, type,
 				(cmd & (LOCK_UN | LOCK_NB)) ? 0 : 1);
-	release_fl_sem();
+	release_fl_lock();
 
 out_putf:
 	fput(filp);
@@ -1645,7 +1645,7 @@
 		 */
 		return;
 	}
-	acquire_fl_sem();
+	acquire_fl_lock();
 	before = &inode->i_flock;
 	while ((fl = *before) != NULL) {
 		if ((fl->fl_flags & FL_POSIX) && fl->fl_owner == owner) {
@@ -1654,7 +1654,7 @@
 		}
 		before = &fl->fl_next;
 	}
-	release_fl_sem();
+	release_fl_lock();
 }
 
 /*
@@ -1669,7 +1669,7 @@
 	if (!inode->i_flock)
 		return;
 
-	acquire_fl_sem();
+	acquire_fl_lock();
 	before = &inode->i_flock;
 
 	while ((fl = *before) != NULL) {
@@ -1680,7 +1680,7 @@
  		}
 		before = &fl->fl_next;
 	}
-	release_fl_sem();
+	release_fl_lock();
 }
 
 /**
@@ -1693,9 +1693,9 @@
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
@@ -1707,12 +1707,12 @@
 void
 posix_unblock_lock(struct file_lock *waiter)
 {
-	acquire_fl_sem();
+	acquire_fl_lock();
 	if (!list_empty(&waiter->fl_list)) {
 		locks_delete_block(waiter);
 		wake_up(&waiter->fl_wait);
 	}
-	release_fl_sem();
+	release_fl_lock();
 }
 
 static void lock_get_status(char* out, struct file_lock *fl, int id, char *pfx)
@@ -1803,7 +1803,7 @@
 	off_t pos = 0;
 	int i = 0;
 
-	acquire_fl_sem();
+	acquire_fl_lock();
 	list_for_each(tmp, &file_lock_list) {
 		struct list_head *btmp;
 		struct file_lock *fl = list_entry(tmp, struct file_lock, fl_link);
@@ -1824,7 +1824,7 @@
 		}
 	}
 done:
-	release_fl_sem();
+	release_fl_lock();
 	*start = buffer;
 	if(q-buffer < length)
 		return (q-buffer);
@@ -1849,7 +1849,7 @@
 {
 	struct file_lock *fl;
 	int result = 1;
-	acquire_fl_sem();
+	acquire_fl_lock();
 	for (fl = inode->i_flock; fl != NULL; fl = fl->fl_next) {
 		if (fl->fl_flags == FL_POSIX) {
 			if (fl->fl_type == F_RDLCK)
@@ -1866,7 +1866,7 @@
 		result = 0;
 		break;
 	}
-	release_fl_sem();
+	release_fl_lock();
 	return result;
 }
 
@@ -1887,7 +1887,7 @@
 {
 	struct file_lock *fl;
 	int result = 1;
-	acquire_fl_sem();
+	acquire_fl_lock();
 	for (fl = inode->i_flock; fl != NULL; fl = fl->fl_next) {
 		if (fl->fl_flags == FL_POSIX) {
 			if ((fl->fl_end < start) || (fl->fl_start > (start + len)))
@@ -1902,7 +1902,7 @@
 		result = 0;
 		break;
 	}
-	release_fl_sem();
+	release_fl_lock();
 	return result;
 }
 #endif
diff -ru linux-2.4.0-test9/include/linux/fs.h linux-2.4.0-test9-test/include/linux/fs.h
--- linux-2.4.0-test9/include/linux/fs.h	Tue Oct 17 14:21:53 2000
+++ linux-2.4.0-test9-test/include/linux/fs.h	Fri Oct 27 21:27:15 2000
@@ -547,7 +547,7 @@
 #endif
 
 extern struct list_head file_lock_list;
-extern struct semaphore file_lock_sem;
+extern spinlock_t file_lock_lock;
 
 #include <linux/fcntl.h>
 
diff -ru linux-2.4.0-test9/kernel/ksyms.c linux-2.4.0-test9-test/kernel/ksyms.c
--- linux-2.4.0-test9/kernel/ksyms.c	Tue Sep 26 08:18:55 2000
+++ linux-2.4.0-test9-test/kernel/ksyms.c	Fri Oct 27 21:27:32 2000
@@ -215,7 +215,7 @@
 EXPORT_SYMBOL(page_hash_bits);
 EXPORT_SYMBOL(page_hash_table);
 EXPORT_SYMBOL(file_lock_list);
-EXPORT_SYMBOL(file_lock_sem);
+EXPORT_SYMBOL(file_lock_lock);
 EXPORT_SYMBOL(locks_init_lock);
 EXPORT_SYMBOL(locks_copy_lock);
 EXPORT_SYMBOL(posix_lock_file);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
