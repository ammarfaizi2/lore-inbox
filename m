Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbVGEXTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbVGEXTg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 19:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbVGEXTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 19:19:35 -0400
Received: from mailsrvr2.bull.com ([192.90.162.8]:39572 "EHLO
	mailsrvr2.bull.com") by vger.kernel.org with ESMTP id S262007AbVGEXMV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 19:12:21 -0400
Message-ID: <42CB13B5.8000907@bull.com>
Date: Tue, 05 Jul 2005 16:11:49 -0700
From: Todd Kneisel <todd.kneisel@bull.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: robustmutexes@lists.osdl.org
Subject: Resend:[RFC/Patch] Robust futexes
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a resend of my patch to add robust futex support to the existing
sys_futex system call. The patch applies to 2.6.12. Any comments or
discussion will be welcome.

Changes since my last posted version:
- Applies to 2.6.12, was 2.6.12-rc6
- Added config option CONFIG_ROBUST_FUTEX, depends on existing CONFIG_FUTEX
   and defaults to no.
- Commented functions, using kernel-doc style comments
- Cleaned up some CodingStyle violations

Sys_futex provides operations on futexes that can be local to a process, or
shared between processes by placing the futex in shared memory. However, if
a process terminates while it owns a locked shared futex, any other
processes that use the same futex will hang.

With this patch, if a process terminates while it owns a locked robust
futex, the ownership of the lock will be transferred to the next waiting
process, the waiting process will be awakened and will receive the status
EOWNERDEAD. If there is no waiting process at the time of termination, then
the next process that attempts to wait will receive ownership of the futex
and the EOWNERDEAD status. The new owner can recover the futex and unlock it,
in which case the futex can continue to be used. If the new owner only
unlocks the futex, then the futex becomes unrecoverable and any attempt to
use the futex will get the status ENOTRECOVERABLE.

The patch does not change the existing sys_futex operations on non-robust
mutexes, so the patch should not affect existing code that uses futexes.
New op codes are added to the sys_futex system call for use by code that
requires robust futexes. I have a patch to glibc and the nptl thread
library that uses robust futexes. We are in the process of getting
copyright assignments to the Free Software Foundation so that we can
submit the glibc and nptl patches.

Robust futexes have a different format from the non-robust futexes.
The non-robust futexes can have the values 0 (unlocked), 1 (locked) or
2 (locked with waiters). In a robust futex the high bit indicates if there
are processes waiting on the futex, the next bit indicates if the owning
process died, and the next bit indicates if the futex is not recoverable.
The rest of the futex contains the pid of the task that owns the futex lock
or zero if the futex is not locked.

Signed-off-by: Todd Kneisel <todd.kneisel@bull.com>

  fs/dcache.c           |    3
  fs/inode.c            |    2
  include/linux/fs.h    |    4
  include/linux/futex.h |   20 +
  init/Kconfig          |   11
  kernel/exit.c         |    3
  kernel/futex.c        |  686 +++++++++++++++++++++++++++++++++++++++++++++++++-
  7 files changed, 728 insertions(+), 1 deletion(-)


diff -uprN -X dontdiff linux-2.6.12/fs/dcache.c linux-2.6.12-todd/fs/dcache.c
--- linux-2.6.12/fs/dcache.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12-todd/fs/dcache.c	2005-06-20 10:44:40.738407891 -0700
@@ -32,6 +32,7 @@
  #include <linux/seqlock.h>
  #include <linux/swap.h>
  #include <linux/bootmem.h>
+#include <linux/futex.h>

  /* #define DCACHE_DEBUG 1 */

@@ -158,6 +159,8 @@ repeat:
  		return;
  	}

+	futex_free_robust_list(dentry->d_inode);
+
  	/*
  	 * AV: ->d_delete() is _NOT_ allowed to block now.
  	 */
diff -uprN -X dontdiff linux-2.6.12/fs/inode.c linux-2.6.12-todd/fs/inode.c
--- linux-2.6.12/fs/inode.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12-todd/fs/inode.c	2005-06-20 15:08:36.428029628 -0700
@@ -21,6 +21,7 @@
  #include <linux/pagemap.h>
  #include <linux/cdev.h>
  #include <linux/bootmem.h>
+#include <linux/futex.h>

  /*
   * This is needed for the following functions:
@@ -202,6 +203,7 @@ void inode_init_once(struct inode *inode
  	INIT_LIST_HEAD(&inode->i_data.i_mmap_nonlinear);
  	spin_lock_init(&inode->i_lock);
  	i_size_ordered_init(inode);
+	futex_init_inode(inode);
  }

  EXPORT_SYMBOL(inode_init_once);
diff -uprN -X dontdiff linux-2.6.12/include/linux/fs.h linux-2.6.12-todd/include/linux/fs.h
--- linux-2.6.12/include/linux/fs.h	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12-todd/include/linux/fs.h	2005-06-20 14:56:16.977970185 -0700
@@ -350,6 +350,10 @@ struct address_space {
  	spinlock_t		private_lock;	/* for use by the address_space */
  	struct list_head	private_list;	/* ditto */
  	struct address_space	*assoc_mapping;	/* ditto */
+#ifdef CONFIG_ROBUST_FUTEX
+ 	struct list_head	robust_list;	/* list of robust futexes */
+ 	struct semaphore	robust_sem;	/* protect list of robust futexes */
+#endif
  } __attribute__((aligned(sizeof(long))));
  	/*
  	 * On most architectures that alignment is already the case; but
diff -uprN -X dontdiff linux-2.6.12/include/linux/futex.h linux-2.6.12-todd/include/linux/futex.h
--- linux-2.6.12/include/linux/futex.h	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12-todd/include/linux/futex.h	2005-06-20 16:43:46.293122664 -0700
@@ -1,6 +1,8 @@
  #ifndef _LINUX_FUTEX_H
  #define _LINUX_FUTEX_H

+#include <linux/fs.h>
+
  /* Second argument to futex syscall */


@@ -9,9 +11,27 @@
  #define FUTEX_FD (2)
  #define FUTEX_REQUEUE (3)
  #define FUTEX_CMP_REQUEUE (4)
+#define FUTEX_WAIT_ROBUST (5)
+#define FUTEX_WAKE_ROBUST (6)
+#define FUTEX_REGISTER (7)
+#define FUTEX_DEREGISTER (8)
+#define FUTEX_RECOVER (9)

  long do_futex(unsigned long uaddr, int op, int val,
  		unsigned long timeout, unsigned long uaddr2, int val2,
  		int val3);

+#ifdef CONFIG_ROBUST_FUTEX
+  extern void futex_free_robust_list(struct inode *inode);
+  extern void exit_futex(void);
+  static inline void futex_init_inode(struct inode *inode) {
+	INIT_LIST_HEAD(&inode->i_data.robust_list);
+	init_MUTEX(&inode->i_data.robust_sem);
+  }
+#else
+  static inline void futex_free_robust_list(struct inode *inode) { }
+  static inline void exit_futex(void) { }
+  static inline void futex_init_inode(struct inode *inode) { }
+#endif
+
  #endif
diff -uprN -X dontdiff linux-2.6.12/init/Kconfig linux-2.6.12-todd/init/Kconfig
--- linux-2.6.12/init/Kconfig	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12-todd/init/Kconfig	2005-06-20 14:33:07.437696418 -0700
@@ -312,6 +312,17 @@ config FUTEX
  	  support for "fast userspace mutexes".  The resulting kernel may not
  	  run glibc-based applications correctly.

+config ROBUST_FUTEX
+	bool "Enable robust futex support" if EMBEDDED
+	depends on FUTEX
+	default n
+	help
+	  Enabling this option will cause the kernel to be built with support
+	  for robust futexes. Robust futexes are an extension to futexes.
+	  You should only enable this option if you have a specific application
+	  that requires robust futexes, and you have a version of glibc and the
+	  nptl thread libraries that provide robust mutexes.
+	
  config EPOLL
  	bool "Enable eventpoll support" if EMBEDDED
  	default y
diff -uprN -X dontdiff linux-2.6.12/kernel/exit.c linux-2.6.12-todd/kernel/exit.c
--- linux-2.6.12/kernel/exit.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12-todd/kernel/exit.c	2005-06-20 10:46:48.983033854 -0700
@@ -28,6 +28,7 @@
  #include <linux/cpuset.h>
  #include <linux/syscalls.h>
  #include <linux/signal.h>
+#include <linux/futex.h>

  #include <asm/uaccess.h>
  #include <asm/unistd.h>
@@ -813,6 +814,8 @@ fastcall NORET_TYPE void do_exit(long co
  	group_dead = atomic_dec_and_test(&tsk->signal->live);
  	if (group_dead)
  		acct_process(code);
+
+ 	exit_futex();
  	exit_mm(tsk);

  	exit_sem(tsk);
diff -uprN -X dontdiff linux-2.6.12/kernel/futex.c linux-2.6.12-todd/kernel/futex.c
--- linux-2.6.12/kernel/futex.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12-todd/kernel/futex.c	2005-06-29 17:46:05.715369816 -0700
@@ -8,6 +8,9 @@
   *  Removed page pinning, fix privately mapped COW pages and other cleanups
   *  (C) Copyright 2003, 2004 Jamie Lokier
   *
+ *  Robust futexes added by Todd Kneisel
+ *  (C) Copyright 2005, Bull HN.
+ *
   *  Thanks to Ben LaHaise for yelling "hashed waitqueues" loudly
   *  enough at me, Linus for the original (flawed) idea, Matthew
   *  Kirkwood for proof-of-concept implementation.
@@ -91,6 +94,11 @@ struct futex_q {
  	/* For fd, sigio sent using these. */
  	int fd;
  	struct file *filp;
+	
+#ifdef CONFIG_ROBUST_FUTEX
+	/* used when transferring ownership */
+	pid_t waiter_pid;
+#endif
  };

  /*
@@ -718,6 +726,661 @@ out:
  	return ret;
  }

+
+#ifdef CONFIG_ROBUST_FUTEX
+
+/*
+ * Robust futexes provide a locking mechanism that can be shared between
+ * user mode processes. The major difference between robust futexes and
+ * regular futexes is that when the owner of a robust futex dies, the
+ * next task waiting on the futex will be awakened, will get ownership
+ * of the futex lock, and will receive the error status EOWNERDEAD.
+ *
+ * A robust futex is a 32 bit integer stored in user mode shared memory.
+ * Bit 31 indicates that there are tasks waiting on the futex.
+ * Bit 30 indicates that the task that owned the futex has died.
+ * Bit 29 indicates that the futex is not recoverable and cannot be used.
+ * Bits 0-28 are the pid of the task that owns the futex lock, or zero if
+ * the futex is not locked.
+ */
+
+#define FUTEX_WAITERS		0x80000000
+#define FUTEX_OWNER_DIED	0x40000000
+#define FUTEX_NOT_RECOVERABLE	0x20000000
+#define FUTEX_PID		0x1fffffff
+
+/*
+ * Used to track registered robust futexes. Attached to linked list in inodes.
+ */
+struct futex_robust {
+	struct list_head list;
+	union futex_key key;
+};
+
+/**
+ * futex_wake_robust - wake a task that is waiting on a robust futex
+ * @uaddr: user space address of the robust futex
+ *
+ * Called from user space (through sys_futex syscall) when unlocking a
+ * robust futex, but only if %FUTEX_WAITERS is set in the futex.
+ * Unlocking when there are no waiters is done entirely in user space.
+ */
+static int futex_wake_robust(unsigned long uaddr)
+{
+	union futex_key key;
+	struct futex_hash_bucket *bh;
+	struct list_head *head;
+	struct futex_q *this, *next;
+	int ret;
+	int value;
+	int count;
+	struct futex_q *target;
+
+retry:
+	down_read(&current->mm->mmap_sem);
+
+	ret = get_futex_key(uaddr, &key);
+	if (unlikely(ret != 0))
+		goto out;
+
+	bh = hash_futex(&key);
+	spin_lock(&bh->lock);
+
+	ret = get_futex_value_locked(&value, (int __user *)uaddr);
+
+	if (unlikely(ret)) {
+		spin_unlock(&bh->lock);
+
+		/* If we would have faulted, release mmap_sem, fault it in and
+		 * start all over again.
+		 */
+		up_read(&current->mm->mmap_sem);
+
+		ret = get_user(value, (int __user *)uaddr);
+
+		if (!ret)
+			goto retry;
+		return ret;
+	}
+
+	head = &bh->chain;
+
+	/*
+	 * if the owner died, mark the futex as not recoverable
+	 * and wake up all waiting tasks.
+	 */
+	if( value & FUTEX_OWNER_DIED ) {
+		if (put_user( FUTEX_OWNER_DIED | FUTEX_NOT_RECOVERABLE,
+				(int __user *) uaddr)) {
+			ret = -EFAULT;
+			goto out_unlock;
+		}
+		list_for_each_entry_safe(this, next, head, list) {
+			if (match_futex (&this->key, &key)) {
+				wake_futex(this);
+				ret++;
+			}
+		}
+		goto out_unlock;
+	}
+	
+	/* find the first waiting task */
+	count = 0;
+	target = NULL;
+	list_for_each_entry_safe(this, next, head, list) {
+		if (match_futex (&this->key, &key)) {
+			if (target == NULL)
+				target = this;
+			if (++count > 1)
+				break;
+		}
+	}
+	
+	/* if no waiters, unlock the futex */
+	if (count == 0) {
+		if (put_user( 0, (int __user *) uaddr)) {
+			ret = -EFAULT;
+			goto out_unlock;
+		}
+		goto out_unlock;
+	}
+	
+	/* transfer ownership and wake waiting task */
+	value = (int)target->waiter_pid;
+	if (count > 1)
+		value |= FUTEX_WAITERS;
+	if (put_user( value, (int __user *) uaddr)) {
+		ret = -EFAULT;
+		goto out_unlock;
+	}
+	wake_futex(target);
+	ret = 1;
+
+out_unlock:
+	spin_unlock(&bh->lock);
+out:
+	up_read(&current->mm->mmap_sem);
+	return ret;
+}
+
+/**
+ * futex_wait_robust - add current task to wait queue of a robust futex
+ * @uaddr: user space address of the robust futex
+ * @time:  timeout in jiffies. zero for no timeout.
+ *
+ * Called from user space (through sys_futex syscall) when locking a
+ * robust futex. Only called if the futex is already locked by another
+ * task. Uncontended locking is done entirely in user space.
+ */
+static int futex_wait_robust(unsigned long uaddr, unsigned long time)
+{
+	DECLARE_WAITQUEUE(wait, current);
+	int ret, curval;
+	struct futex_q q;
+	struct futex_hash_bucket *bh;
+
+ retry:
+	down_read(&current->mm->mmap_sem);
+
+	ret = get_futex_key(uaddr, &q.key);
+	if (unlikely(ret != 0))
+		goto out_release_sem;
+
+	bh = queue_lock(&q, -1, NULL);
+
+	ret = get_futex_value_locked(&curval, (int __user *)uaddr);
+
+	if (unlikely(ret)) {
+		queue_unlock(&q, bh);
+
+		/* If we would have faulted, release mmap_sem, fault it in and
+		 * start all over again.
+		 */
+		up_read(&current->mm->mmap_sem);
+
+		ret = get_user(curval, (int __user *)uaddr);
+
+		if (!ret)
+			goto retry;
+		return ret;
+	}
+
+	/*
+	 * user mode called us because futex was owned by a task,
+	 * but now it's not. Let user mode try again.
+	 */
+	if (curval == 0) {
+		ret = -EAGAIN;
+		queue_unlock(&q, bh);
+		goto out_release_sem;
+	}
+
+	/*
+	 * user mode called us because futex had owner and waitflag was
+	 * set. That's not true now, so let user mode try again
+	 */
+	if ((curval & FUTEX_PID) && !(curval & FUTEX_WAITERS)) {
+		ret = -EAGAIN;
+		queue_unlock(&q, bh);
+		goto out_release_sem;
+	}
+
+	/* if owner has died, we don't want to wait */
+	if ((curval & FUTEX_OWNER_DIED)) {
+		ret = -EOWNERDEAD;
+		queue_unlock(&q, bh);
+		goto out_release_sem;
+	}
+
+	/*
+	 * Save pid of waiting task for transferring ownership in
+	 * futex_wake_robust(). Avoids problem where futex_wake_robust()
+	 * runs before waiting task is added to futex wait queue.
+	 */
+	q.waiter_pid = current->pid;
+	__queue_me(&q, bh);
+
+	/*
+	 * Now the futex is queued and we have checked the data, we
+	 * don't want to hold mmap_sem while we sleep.
+	 */	
+	up_read(&current->mm->mmap_sem);
+
+	/*
+	 * There might have been scheduling since the queue_me(), as we
+	 * cannot hold a spinlock across the get_user() in case it
+	 * faults, and we cannot just set TASK_INTERRUPTIBLE state when
+	 * queueing ourselves into the futex hash.  This code thus has to
+	 * rely on the futex_wake() code removing us from hash when it
+	 * wakes us up.
+	 */
+
+	/* add_wait_queue is the barrier after __set_current_state. */
+	__set_current_state(TASK_INTERRUPTIBLE);
+	add_wait_queue(&q.waiters, &wait);
+	/*
+	 * !list_empty() is safe here without any lock.
+	 * q.lock_ptr != 0 is not safe, because of ordering against wakeup.
+	 */
+	if (likely(!list_empty(&q.list)))
+		time = schedule_timeout(time);
+	__set_current_state(TASK_RUNNING);
+
+	/*
+	 * NOTE: we don't remove ourselves from the waitqueue because
+	 * we are the only user of it.
+	 */
+
+retry2:
+	ret = get_futex_value_locked(&curval, (int __user *)uaddr);
+
+	if (unlikely(ret)) {
+		/* If we would have faulted, release mmap_sem, fault it in and
+		 * start all over again.
+		 */
+		up_read(&current->mm->mmap_sem);
+
+		ret = get_user(curval, (int __user *)uaddr);
+
+		if (!ret) {
+			down_read(&current->mm->mmap_sem);
+			goto retry2;
+		}
+		unqueue_me(&q);
+		return ret;
+	}
+
+	if (curval & FUTEX_OWNER_DIED) {
+		unqueue_me(&q);
+		return -EOWNERDEAD;
+	}
+
+	/* If we were woken (and unqueued), we succeeded, whatever. */
+	if (!unqueue_me(&q))
+		return 0;
+	if (time == 0)
+		return -ETIMEDOUT;
+	/* We expect signal_pending(current), but another thread may
+	 * have handled it for us already. */
+	return -EINTR;
+
+ out_release_sem:
+	up_read(&current->mm->mmap_sem);
+	return ret;
+}
+
+/**
+ * futex_free_robust_list - release the list of registered futexes.
+ * @inode: inode that may be a memory mapped file
+ *
+ * Called from dput() when a dentry reference count reaches zero.
+ * If the dentry is associated with a memory mapped file, then
+ * release the list of registered robust futexes that are contained
+ * in that mapping.
+ */
+void futex_free_robust_list(struct inode *inode)
+{
+	struct address_space *mapping;
+	struct list_head *head;
+	struct futex_robust *this, *next;
+
+	if (inode == NULL)
+		return;
+	
+	mapping = inode->i_mapping;
+	if (mapping == NULL)
+		return;
+
+	if (list_empty(&mapping->robust_list))
+		return;
+		
+	down(&mapping->robust_sem);
+	
+	head = &mapping->robust_list;
+
+	list_for_each_entry_safe(this, next, head, list) {
+		list_del(&this->list);
+		kfree(this);
+	}
+
+	up(&mapping->robust_sem);
+	return;
+}
+
+/**
+ * get_private_uaddr - convert a private futex_key to a user addr
+ * @key: the futex_key that identifies a futex.
+ *
+ * Private futex_keys identify a futex that is in non-shared memory.
+ * Robust futexes should never result in private futex_keys, but keep
+ * this code for completeness.
+ * Returns zero if futex is not contained in current task's mm
+ */
+static unsigned long get_private_uaddr( union futex_key *key)
+{
+	unsigned long uaddr = 0;
+
+	if (key->private.mm == current->mm)
+		uaddr = key->private.uaddr;
+	return uaddr;
+}
+
+/**
+ * get_shared_uaddr - convert a shared futex_key to a user addr.
+ * @key: a futex_key that identifies a futex.
+ * @vma: a vma that may contain the futex
+ *
+ * Shared futex_keys identify a futex that is contained in a vma,
+ * and so may be shared.
+ * Returns zero if futex is not contained in @vma
+ */
+static unsigned long get_shared_uaddr( union futex_key *key,
+				       struct vm_area_struct *vma)
+{
+	unsigned long uaddr = 0;
+	unsigned long tmpaddr;
+	struct address_space *mapping;
+
+	mapping = vma->vm_file->f_mapping;
+	if (key->shared.inode == mapping->host ) {
+		tmpaddr = ((key->shared.pgoff - vma->vm_pgoff) << PAGE_SHIFT)
+				+ (key->shared.offset & ~0x1)
+				+ vma->vm_start;
+		if (tmpaddr >= vma->vm_start && tmpaddr < vma->vm_end)
+			uaddr = tmpaddr;
+	}
+	
+	return uaddr;
+}
+
+/**
+ * get_futex_uaddr - convert a futex_key to a user addr.
+ * @key: futex_key that identifies a futex
+ * @vma: vma that may contain the futex
+ *
+ * Converts both shared and private futex_keys.
+ * Returns zero if futex is not contained in @vma or in the current
+ * task's mm.
+ */
+static unsigned long get_futex_uaddr( union futex_key *key,
+				      struct vm_area_struct *vma)
+{
+	unsigned long uaddr;
+
+	if ((key->both.offset & 0x1) == 0)
+		uaddr = get_private_uaddr(key);
+	else
+		uaddr = get_shared_uaddr(key,vma);
+	
+	return uaddr;
+}
+
+/**
+ * set_owner_died - mark futex when owner dies, then wake a waiting task
+ * @key: futex_key that identifies the futex that is owned by the
+ *       current task.
+ * @uaddr: user space address of the futex.
+ * @value: the current value of the futex.
+ *
+ * Set the %FUTEX_OWNER_DIED flag in the futex, then find the first task
+ * that is waiting on this futex and that is not part of the current
+ * thread group, and wake that task.
+ */
+static void set_owner_died(union futex_key *key, unsigned long uaddr,
+			   int value)
+{
+	struct futex_hash_bucket *bh;
+	struct list_head *head;
+	struct futex_q *this, *next;
+	wait_queue_t *waitq;
+	struct list_head *waitq_list;
+	struct task_struct *task;
+	int ret;
+
+	bh = hash_futex(key);
+	spin_lock(&bh->lock);
+	head = &bh->chain;
+
+	ret = put_user(FUTEX_OWNER_DIED | value, (int __user *) uaddr);
+	if (ret != 0) {
+		spin_unlock(&bh->lock);
+		WARN_ON(ret!=0);
+		return;
+	}
+
+	list_for_each_entry_safe(this, next, head, list) {
+		if (!match_futex (&this->key, key))
+			continue;
+
+		waitq_list = this->waiters.task_list.next;
+		waitq = list_entry(waitq_list, wait_queue_t, task_list);
+		task = waitq->task;
+		if (task->tgid == current->tgid)
+			continue;
+
+		wake_futex(this);
+		break;
+	}
+	spin_unlock(&bh->lock);
+}
+
+/**
+ * find_owned_futex - find futexes owned by the current task
+ * @vma: the vma to search for futexes
+ *
+ * Walk the list of registered robust futexes for this @vma,
+ * setting the %FUTEX_OWNER_DIED flag on those futexes owned
+ * by the current, exiting task.
+ */
+static void find_owned_futex( struct vm_area_struct *vma )
+{
+	struct address_space *mapping;
+	struct list_head *head;
+	struct futex_robust *this, *next;
+	unsigned long uaddr;
+	int value;
+	int ret;
+
+	mapping = vma->vm_file->f_mapping;
+	down(&mapping->robust_sem);
+
+	head = &mapping->robust_list;
+	list_for_each_entry_safe(this, next, head, list) {
+
+		uaddr = get_futex_uaddr(&this->key, vma);
+		if (uaddr == 0)
+			continue;
+			
+		if ((ret = get_user(value, (int *)uaddr)) != 0) {
+			WARN_ON(ret!=0);
+			continue;
+		}
+		
+		if ((value & FUTEX_PID) == current->pid)
+			set_owner_died(&this->key,uaddr,value);
+	}
+
+	up(&mapping->robust_sem);
+}
+
+/**
+ * exit_futex - futex processing when a task exits.
+ *
+ * Called from do_exit() when a task exits. Mark all robust futexes
+ * that are owned by the current terminating task as %FUTEX_OWNER_DIED.
+ */
+
+void exit_futex(void)
+{
+	struct mm_struct *mm;
+	struct vm_area_struct *vma;
+
+	if (current==NULL)
+		return;
+
+	mm = current->mm;
+	if (mm==NULL)
+		return;
+
+	down_read(&mm->mmap_sem);
+	
+	for (vma = mm->mmap; vma != NULL; vma = vma->vm_next) {
+		if (vma->vm_file == NULL)
+			continue;
+			
+		if (vma->vm_file->f_mapping == NULL)
+			continue;
+
+		find_owned_futex(vma);
+	}
+
+	up_read(&mm->mmap_sem);
+}
+
+/**
+ * futex_register - Record the existence of a robust futex in a vma.
+ * @uaddr: user space address of the robust futex
+ *
+ * Called from user space (through sys_futex syscall) when a robust
+ * futex is created. Looks up the vma that contains the futex and
+ * adds an entry to the list of all robust futexes in the vma.
+ */
+static int futex_register(unsigned long uaddr)
+{
+	int ret;
+	struct futex_robust *robust;
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+	struct file *file;
+	struct address_space *mapping;
+	
+	robust = kmalloc(sizeof(*robust), GFP_KERNEL);
+	if (!robust) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	
+	down_read(&current->mm->mmap_sem);
+
+	ret = get_futex_key(uaddr, &robust->key);
+	if (unlikely(ret != 0))	{
+		up_read(&current->mm->mmap_sem);
+		kfree(robust);
+		goto out;
+	}
+
+	up_read(&current->mm->mmap_sem);
+
+	vma = find_extend_vma(mm, uaddr);
+	if (unlikely(!vma)) {
+		ret = -EFAULT;
+		kfree(robust);
+		goto out;
+	}
+	
+	file = vma->vm_file;
+	if (!file) {
+		ret = -EINVAL;
+		kfree(robust);
+		goto out;
+	}
+	
+	mapping = file->f_mapping;
+	down(&mapping->robust_sem);
+	list_add_tail(&robust->list, &mapping->robust_list);
+	up(&mapping->robust_sem);
+
+out:
+	return ret;
+}
+
+/**
+ * futex_deregister - Delete robust futex registration from a vma
+ * @uaddr: user space address of the robust futex
+ *
+ * Called from user space (through sys_futex syscall) when a robust
+ * futex is destroyed. Looks up the vma that contains the futex and
+ * removes the futex entry from the list of all robust futexes in
+ * the vma.
+ */
+static int futex_deregister(unsigned long uaddr)
+{
+	union futex_key key;
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+	struct file *file;
+	struct address_space *mapping;
+	struct list_head *head;
+	struct futex_robust *this, *next;
+	int ret;
+
+	down_read(&mm->mmap_sem);
+
+	ret = get_futex_key(uaddr, &key);
+	if (unlikely(ret != 0))
+		goto out;
+
+	vma = find_extend_vma(mm, uaddr);
+	if (unlikely(!vma)) {
+		ret = -EFAULT;
+		goto out;
+	}
+	
+	file = vma->vm_file;
+	if (!file) {
+		ret = -EINVAL;
+		goto out;
+	}
+	
+	mapping = file->f_mapping;
+	down(&mapping->robust_sem);
+	head = &mapping->robust_list;
+
+	list_for_each_entry_safe(this, next, head, list) {
+		if (match_futex (&this->key, &key)) {
+			list_del(&this->list);
+			kfree(this);
+			break;
+		}
+	}
+
+	up(&mapping->robust_sem);
+out:
+	up_read(&mm->mmap_sem);
+	return ret;
+}
+
+/**
+ * futex_recover - Recover a futex after its owner died
+ * @uaddr: user space address of the robust futex
+ *
+ * Called from user space (through sys_futex syscall).
+ * When a task dies while owning a robust futex, the futex is
+ * marked with %FUTEX_OWNER_DIED and ownership is transferred
+ * to the next waiting task. That task can choose to restore
+ * the futex to a useful state by calling this function.
+ */
+static int futex_recover(unsigned long uaddr)
+{
+	int ret = 0;
+	int value;
+
+	down_read(&current->mm->mmap_sem);
+
+	if ((ret = get_user(value, (int *)uaddr)) != 0)
+		goto out_release_sem;
+	
+	value &= ~FUTEX_OWNER_DIED;
+	ret = put_user(value, (int *)uaddr);
+
+ out_release_sem:
+	up_read(&current->mm->mmap_sem);
+	return ret;
+}
+
+#endif /* #ifdef CONFIG_ROBUST_FUTEX */
+
+
  long do_futex(unsigned long uaddr, int op, int val, unsigned long timeout,
  		unsigned long uaddr2, int val2, int val3)
  {
@@ -740,6 +1403,23 @@ long do_futex(unsigned long uaddr, int o
  	case FUTEX_CMP_REQUEUE:
  		ret = futex_requeue(uaddr, uaddr2, val, val2, &val3);
  		break;
+#ifdef CONFIG_ROBUST_FUTEX
+	case FUTEX_WAIT_ROBUST:
+		ret = futex_wait_robust(uaddr, timeout);
+		break;
+	case FUTEX_WAKE_ROBUST:
+		ret = futex_wake_robust(uaddr);
+		break;
+	case FUTEX_REGISTER:
+		ret = futex_register(uaddr);
+		break;
+	case FUTEX_DEREGISTER:
+		ret = futex_deregister(uaddr);
+		break;
+	case FUTEX_RECOVER:
+		ret = futex_recover(uaddr);
+		break;
+#endif
  	default:
  		ret = -ENOSYS;
  	}
@@ -755,7 +1435,11 @@ asmlinkage long sys_futex(u32 __user *ua
  	unsigned long timeout = MAX_SCHEDULE_TIMEOUT;
  	int val2 = 0;

+#ifdef CONFIG_ROBUST_FUTEX
+	if ((op == FUTEX_WAIT || op == FUTEX_WAIT_ROBUST) && utime) {
+#else
  	if ((op == FUTEX_WAIT) && utime) {
+#endif
  		if (copy_from_user(&t, utime, sizeof(t)) != 0)
  			return -EFAULT;
  		timeout = timespec_to_jiffies(&t) + 1;
@@ -763,7 +1447,7 @@ asmlinkage long sys_futex(u32 __user *ua
  	/*
  	 * requeue parameter in 'utime' if op == FUTEX_REQUEUE.
  	 */
-	if (op >= FUTEX_REQUEUE)
+	if (op == FUTEX_REQUEUE || op == FUTEX_CMP_REQUEUE)
  		val2 = (int) (unsigned long) utime;

  	return do_futex((unsigned long)uaddr, op, val, timeout,
