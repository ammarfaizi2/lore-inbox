Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbVFOXQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbVFOXQz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 19:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbVFOXQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 19:16:55 -0400
Received: from mailsrvr2.bull.com ([192.90.162.8]:7396 "EHLO
	mailsrvr2.bull.com") by vger.kernel.org with ESMTP id S261631AbVFOXNI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 19:13:08 -0400
Message-ID: <42B0B5FD.3010309@bull.com>
Date: Wed, 15 Jun 2005 16:13:01 -0700
From: Todd Kneisel <todd.kneisel@bull.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [RFC/Patch] robust futexes for 2.6.12-rc6
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds robust futex support to the existing sys_futex system call.
The patch applies to 2.6.12-rc6. I have tested this code on an IA64 SMP
system. Any comments or discussion will be welcome.

Sys_futex provides operations on futexes that can be local to a process, or
shared between processes by placing the futex in shared memory. However, if
a process terminates while it owns a locked shared futex, any other
processes that uses the same futex will hang.

If a process terminates while it owns a locked robust futex, the ownership
of the lock will be transferred to the next waiting process, the waiting
process will be awakened and will receive the status EOWNERDEAD. If there
is no waiting process at the time of termination, then the next process
that attempts to wait will receive ownership of the futex and the
EOWNERDEAD status. The new owner can recover the futex and unlock it, in
which case the futex can continue to be used. If the new owner only unlocks
the futex, then the futex becomes unrecoverable and any attempt to use
the futex will get the status ENOTRECOVERABLE.

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

For this code to work, robust futexes must be in shared memory.

I plan to create a kernel config option for this code.

Robust futexes must be registered with the kernel when created and
deregistered when no longer required. Process termination will clean up
any registered futexes that were not deregistered.

Memory is allocated when a futex is registered. This memory is freed
when the reference count of the memory mapped file's dentry reaches zero.
There is a problem here if the memory mapped file has hard links. This
would result in multiple dentrys for the file. The memory would be
freed when the reference count of any dentry reached zero, while the
file is still mapped by other dentrys. I believe I can fix this by adding
a reference count for the allocated memory. This is on my to-do list.

Signed-off-by: Todd Kneisel <todd.kneisel@bull.com>


diff -uprN -X dontdiff linux-2.6.12-rc6/fs/dcache.c linux-2.6.12-todd/fs/dcache.c
--- linux-2.6.12-rc6/fs/dcache.c	2005-06-14 10:47:35.836170525 -0700
+++ linux-2.6.12-todd/fs/dcache.c	2005-06-14 10:52:54.214990261 -0700
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
diff -uprN -X dontdiff linux-2.6.12-rc6/fs/inode.c linux-2.6.12-todd/fs/inode.c
--- linux-2.6.12-rc6/fs/inode.c	2005-06-14 10:47:36.006195730 -0700
+++ linux-2.6.12-todd/fs/inode.c	2005-06-14 10:52:54.217921765 -0700
@@ -202,6 +202,8 @@ void inode_init_once(struct inode *inode
  	INIT_LIST_HEAD(&inode->i_data.i_mmap_nonlinear);
  	spin_lock_init(&inode->i_lock);
  	i_size_ordered_init(inode);
+	INIT_LIST_HEAD(&inode->i_data.robust_list);
+	init_MUTEX(&inode->i_data.robust_sem);
  }

  EXPORT_SYMBOL(inode_init_once);
diff -uprN -X dontdiff linux-2.6.12-rc6/include/linux/fs.h linux-2.6.12-todd/include/linux/fs.h
--- linux-2.6.12-rc6/include/linux/fs.h	2005-06-14 10:47:37.597006100 -0700
+++ linux-2.6.12-todd/include/linux/fs.h	2005-06-14 10:52:54.221830438 -0700
@@ -350,6 +350,8 @@ struct address_space {
  	spinlock_t		private_lock;	/* for use by the address_space */
  	struct list_head	private_list;	/* ditto */
  	struct address_space	*assoc_mapping;	/* ditto */
+ 	struct list_head	robust_list;	/* list of robust futexes */
+ 	struct semaphore	robust_sem;	/* protect list of robust futexes */
  } __attribute__((aligned(sizeof(long))));
  	/*
  	 * On most architectures that alignment is already the case; but
diff -uprN -X dontdiff linux-2.6.12-rc6/include/linux/futex.h linux-2.6.12-todd/include/linux/futex.h
--- linux-2.6.12-rc6/include/linux/futex.h	2005-05-12 14:39:04.000000000 -0700
+++ linux-2.6.12-todd/include/linux/futex.h	2005-06-14 10:52:54.222807607 -0700
@@ -1,6 +1,8 @@
  #ifndef _LINUX_FUTEX_H
  #define _LINUX_FUTEX_H

+#include <linux/fs.h>
+
  /* Second argument to futex syscall */


@@ -9,9 +11,18 @@
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

+void futex_free_robust_list(struct inode *inode);
+
+void exit_futex(void);
+
  #endif
diff -uprN -X dontdiff linux-2.6.12-rc6/kernel/exit.c linux-2.6.12-todd/kernel/exit.c
--- linux-2.6.12-rc6/kernel/exit.c	2005-06-14 10:47:38.072881162 -0700
+++ linux-2.6.12-todd/kernel/exit.c	2005-06-14 10:52:54.225739111 -0700
@@ -28,6 +28,7 @@
  #include <linux/cpuset.h>
  #include <linux/syscalls.h>
  #include <linux/signal.h>
+#include <linux/futex.h>

  #include <asm/uaccess.h>
  #include <asm/unistd.h>
@@ -815,6 +816,8 @@ fastcall NORET_TYPE void do_exit(long co
   		del_timer_sync(&tsk->signal->real_timer);
  		acct_process(code);
  	}
+
+	exit_futex();
  	exit_mm(tsk);

  	exit_sem(tsk);
diff -uprN -X dontdiff linux-2.6.12-rc6/kernel/futex.c linux-2.6.12-todd/kernel/futex.c
--- linux-2.6.12-rc6/kernel/futex.c	2005-06-14 10:47:38.080698411 -0700
+++ linux-2.6.12-todd/kernel/futex.c	2005-06-14 10:52:54.231602121 -0700
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
@@ -43,6 +46,11 @@

  #define FUTEX_HASHBITS (CONFIG_BASE_SMALL ? 4 : 8)

+#define FUTEX_WAITERS		0x80000000
+#define FUTEX_OWNER_DIED	0x40000000
+#define FUTEX_NOT_RECOVERABLE	0x20000000
+#define FUTEX_PID               0x1fffffff
+
  /*
   * Futexes are matched on equal values of this key.
   * The key type depends on whether it's a shared or private mapping.
@@ -91,6 +99,9 @@ struct futex_q {
  	/* For fd, sigio sent using these. */
  	int fd;
  	struct file *filp;
+	
+	/* For robust futex, transferring ownership */
+	pid_t waiter_pid;
  };

  /*
@@ -103,6 +114,14 @@ struct futex_hash_bucket {

  static struct futex_hash_bucket futex_queues[1<<FUTEX_HASHBITS];

+/*
+ * one element of the list of shared robust futexes in a shared memory region
+ */
+struct futex_robust {
+	struct list_head list;
+	union futex_key key;
+};
+
  /* Futex-fs vfsmount entry: */
  static struct vfsmount *futex_mnt;

@@ -326,6 +345,98 @@ out:
  	return ret;
  }

+
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
+	if( value & FUTEX_OWNER_DIED ) {
+		if (put_user( FUTEX_OWNER_DIED | FUTEX_NOT_RECOVERABLE, (int __user *) uaddr)) {
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
+	count = 0;
+	target = NULL;
+	list_for_each_entry_safe(this, next, head, list) {
+		if (match_futex (&this->key, &key)) {
+			if( target == NULL )
+				target = this;
+			if( ++count > 1 )
+				break;
+		}
+	}
+	
+	if( count == 0 ) {
+		if (put_user( 0, (int __user *) uaddr)) {
+			ret = -EFAULT;
+			goto out_unlock;
+		}
+		goto out_unlock;
+	}
+	
+	value = (int)target->waiter_pid;
+	if( count > 1 )
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
+
  /*
   * Requeue all waiters hashed on one physical page to another
   * physical page.
@@ -611,6 +722,134 @@ static int futex_wait(unsigned long uadd
  	return ret;
  }

+
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
+	if( curval == 0 ) {
+		ret = -EAGAIN;
+		queue_unlock(&q, bh);
+		goto out_release_sem;
+	}
+
+	/* if futex has owner and waitflag is not set, return */
+	if( (curval & FUTEX_PID) && !(curval & FUTEX_WAITERS) ) {
+		ret = -EAGAIN;
+		queue_unlock(&q, bh);
+		goto out_release_sem;
+	}
+
+	/* if owner has died, return */
+	if( (curval & FUTEX_OWNER_DIED) ) {
+		ret = -EOWNERDEAD;
+		queue_unlock(&q, bh);
+		goto out_release_sem;
+	}
+
+	/* Only actually queue if *uaddr contained val.  */
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
+
  static int futex_close(struct inode *inode, struct file *filp)
  {
  	struct futex_q *q = filp->private_data;
@@ -718,6 +957,305 @@ out:
  	return ret;
  }

+void futex_free_robust_list(struct inode *inode)
+{
+	struct address_space *mappingp;
+	struct list_head *head_robust;
+	struct futex_robust *this_robust, *next_robust;
+
+	if( inode == NULL ) {
+		return;
+	}
+	
+	mappingp = inode->i_mapping;
+	if( mappingp == NULL ) {
+		return;
+	}
+
+	if( list_empty(&mappingp->robust_list) ) {
+		return;
+	}
+		
+	down(&mappingp->robust_sem);
+	
+	head_robust = &mappingp->robust_list;
+
+	list_for_each_entry_safe(this_robust, next_robust, head_robust, list) {
+		list_del(&this_robust->list);
+		kfree(this_robust);
+	}
+
+	up(&mappingp->robust_sem);
+	return;
+}
+
+static unsigned long get_private_uaddr( union futex_key *key)
+{
+	unsigned long uaddr = 0;
+
+	if (key->private.mm == current->mm)
+		uaddr = key->private.uaddr;
+	return uaddr;
+}
+
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
+
+static void set_owner_died(struct futex_robust *robust, unsigned long uaddr, int value)
+{
+	struct futex_hash_bucket *bh;
+	struct list_head *head;
+	struct futex_q *this, *next;
+	wait_queue_t *waitq;
+	struct list_head *waitq_list;
+	struct task_struct *task;
+	int ret;
+
+	bh = hash_futex(&robust->key);
+	spin_lock(&bh->lock);
+	head = &bh->chain;
+
+	if ((ret = put_user( FUTEX_OWNER_DIED | value, (int __user *) uaddr)) != 0) {
+		spin_unlock(&bh->lock);
+		WARN_ON(ret!=0);
+		return;
+	}
+
+	list_for_each_entry_safe(this, next, head, list) {
+		if (!match_futex (&this->key, &robust->key))
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
+
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
+		if ( (value & FUTEX_PID) == current->pid)
+			set_owner_died(this,uaddr,value);
+	}
+
+	up(&mapping->robust_sem);
+}
+
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
+		find_owned_futex( vma );
+	}
+
+	up_read(&mm->mmap_sem);
+}
+
+
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
+	if (unlikely(ret != 0))
+	{
+		up_read(&current->mm->mmap_sem);
+		kfree(robust);
+		goto out;
+	}
+
+	up_read(&current->mm->mmap_sem);
+
+	vma = find_extend_vma(mm, uaddr);
+	if (unlikely(!vma))
+	{
+		ret = -EFAULT;
+		kfree(robust);
+		goto out;
+	}
+	
+	file = vma->vm_file;
+	if( !file )
+	{
+		ret = -EINVAL;
+		kfree(robust);
+		goto out;
+	}
+	
+	mapping = file->f_mapping;
+
+	down(&mapping->robust_sem);
+	list_add_tail(&robust->list, &mapping->robust_list);
+	up(&mapping->robust_sem);
+
+out:
+	return ret;
+}
+
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
+	if (unlikely(!vma))
+	{
+		ret = -EFAULT;
+		goto out;
+	}
+	
+	file = vma->vm_file;
+	if( !file )
+	{
+		ret = -EINVAL;
+		goto out;
+	}
+	
+	mapping = file->f_mapping;
+
+	down(&mapping->robust_sem);
+	
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
+
+static int futex_recover(unsigned long uaddr)
+{
+	int ret = 0;
+	int value;
+
+	down_read(&current->mm->mmap_sem);
+
+	if ((ret = get_user(value, (int *)uaddr)) != 0) {
+		goto out_release_sem;
+	}
+	
+	value &= ~FUTEX_OWNER_DIED;
+
+	if ((ret = put_user(value, (int *)uaddr)) != 0) {
+		goto out_release_sem;
+	}
+
+ out_release_sem:
+	up_read(&current->mm->mmap_sem);
+	return ret;
+}
+
+
  long do_futex(unsigned long uaddr, int op, int val, unsigned long timeout,
  		unsigned long uaddr2, int val2, int val3)
  {
@@ -740,6 +1278,21 @@ long do_futex(unsigned long uaddr, int o
  	case FUTEX_CMP_REQUEUE:
  		ret = futex_requeue(uaddr, uaddr2, val, val2, &val3);
  		break;
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
  	default:
  		ret = -ENOSYS;
  	}
@@ -755,7 +1308,7 @@ asmlinkage long sys_futex(u32 __user *ua
  	unsigned long timeout = MAX_SCHEDULE_TIMEOUT;
  	int val2 = 0;

-	if ((op == FUTEX_WAIT) && utime) {
+	if (((op == FUTEX_WAIT) || (op == FUTEX_WAIT_ROBUST)) && utime) {
  		if (copy_from_user(&t, utime, sizeof(t)) != 0)
  			return -EFAULT;
  		timeout = timespec_to_jiffies(&t) + 1;
@@ -763,7 +1316,7 @@ asmlinkage long sys_futex(u32 __user *ua
  	/*
  	 * requeue parameter in 'utime' if op == FUTEX_REQUEUE.
  	 */
-	if (op >= FUTEX_REQUEUE)
+	if (op == FUTEX_REQUEUE || op == FUTEX_CMP_REQUEUE)
  		val2 = (int) (unsigned long) utime;

  	return do_futex((unsigned long)uaddr, op, val, timeout,

