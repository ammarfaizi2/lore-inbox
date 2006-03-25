Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbWCYSsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbWCYSsa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 13:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbWCYSs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 13:48:29 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:45953 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932227AbWCYSs2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 13:48:28 -0500
Date: Sat, 25 Mar 2006 19:45:45 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>
Subject: [patch 01/10] PI-futex: futex code cleanups
Message-ID: <20060325184545.GB16724@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

clean up the futex code, before adding more features to it:

 - use u32 as the futex field type - that's the ABI
 - use __user and pointers to u32 instead of unsigned long
 - code style / comment style cleanups
 - rename hash-bucket name from 'bh' to 'hb'.

I checked the pre and post futex.o object files to make sure this
patch has no code effects.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

----

 include/linux/futex.h    |    5 
 include/linux/syscalls.h |    4 
 kernel/futex.c           |  245 ++++++++++++++++++++++++-----------------------
 3 files changed, 134 insertions(+), 120 deletions(-)

Index: linux-pi-futex.mm.q/include/linux/futex.h
===================================================================
--- linux-pi-futex.mm.q.orig/include/linux/futex.h
+++ linux-pi-futex.mm.q/include/linux/futex.h
@@ -90,9 +90,8 @@ struct robust_list_head {
  */
 #define ROBUST_LIST_LIMIT	2048
 
-long do_futex(unsigned long uaddr, int op, int val,
-		unsigned long timeout, unsigned long uaddr2, int val2,
-		int val3);
+long do_futex(u32 __user *uaddr, int op, u32 val, unsigned long timeout,
+	      u32 __user *uaddr2, u32 val2, u32 val3);
 
 extern int handle_futex_death(u32 __user *uaddr, struct task_struct *curr);
 
Index: linux-pi-futex.mm.q/include/linux/syscalls.h
===================================================================
--- linux-pi-futex.mm.q.orig/include/linux/syscalls.h
+++ linux-pi-futex.mm.q/include/linux/syscalls.h
@@ -174,9 +174,9 @@ asmlinkage long sys_waitid(int which, pi
 			   int options, struct rusage __user *ru);
 asmlinkage long sys_waitpid(pid_t pid, int __user *stat_addr, int options);
 asmlinkage long sys_set_tid_address(int __user *tidptr);
-asmlinkage long sys_futex(u32 __user *uaddr, int op, int val,
+asmlinkage long sys_futex(u32 __user *uaddr, int op, u32 val,
 			struct timespec __user *utime, u32 __user *uaddr2,
-			int val3);
+			u32 val3);
 
 asmlinkage long sys_init_module(void __user *umod, unsigned long len,
 				const char __user *uargs);
Index: linux-pi-futex.mm.q/kernel/futex.c
===================================================================
--- linux-pi-futex.mm.q.orig/kernel/futex.c
+++ linux-pi-futex.mm.q/kernel/futex.c
@@ -63,7 +63,7 @@ union futex_key {
 		int offset;
 	} shared;
 	struct {
-		unsigned long uaddr;
+		unsigned long address;
 		struct mm_struct *mm;
 		int offset;
 	} private;
@@ -87,13 +87,13 @@ struct futex_q {
 	struct list_head list;
 	wait_queue_head_t waiters;
 
-	/* Which hash list lock to use. */
+	/* Which hash list lock to use: */
 	spinlock_t *lock_ptr;
 
-	/* Key which the futex is hashed on. */
+	/* Key which the futex is hashed on: */
 	union futex_key key;
 
-	/* For fd, sigio sent using these. */
+	/* For fd, sigio sent using these: */
 	int fd;
 	struct file *filp;
 };
@@ -145,8 +145,9 @@ static inline int match_futex(union fute
  *
  * Should be called with &current->mm->mmap_sem but NOT any spinlocks.
  */
-static int get_futex_key(unsigned long uaddr, union futex_key *key)
+static int get_futex_key(u32 __user *uaddr, union futex_key *key)
 {
+	unsigned long address = (unsigned long)uaddr;
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	struct page *page;
@@ -155,16 +156,16 @@ static int get_futex_key(unsigned long u
 	/*
 	 * The futex address must be "naturally" aligned.
 	 */
-	key->both.offset = uaddr % PAGE_SIZE;
+	key->both.offset = address % PAGE_SIZE;
 	if (unlikely((key->both.offset % sizeof(u32)) != 0))
 		return -EINVAL;
-	uaddr -= key->both.offset;
+	address -= key->both.offset;
 
 	/*
 	 * The futex is hashed differently depending on whether
 	 * it's in a shared or private mapping.  So check vma first.
 	 */
-	vma = find_extend_vma(mm, uaddr);
+	vma = find_extend_vma(mm, address);
 	if (unlikely(!vma))
 		return -EFAULT;
 
@@ -185,7 +186,7 @@ static int get_futex_key(unsigned long u
 	 */
 	if (likely(!(vma->vm_flags & VM_MAYSHARE))) {
 		key->private.mm = mm;
-		key->private.uaddr = uaddr;
+		key->private.address = address;
 		return 0;
 	}
 
@@ -195,7 +196,7 @@ static int get_futex_key(unsigned long u
 	key->shared.inode = vma->vm_file->f_dentry->d_inode;
 	key->both.offset++; /* Bit 0 of offset indicates inode-based key. */
 	if (likely(!(vma->vm_flags & VM_NONLINEAR))) {
-		key->shared.pgoff = (((uaddr - vma->vm_start) >> PAGE_SHIFT)
+		key->shared.pgoff = (((address - vma->vm_start) >> PAGE_SHIFT)
 				     + vma->vm_pgoff);
 		return 0;
 	}
@@ -206,7 +207,7 @@ static int get_futex_key(unsigned long u
 	 * from swap.  But that's a lot of code to duplicate here
 	 * for a rare case, so we simply fetch the page.
 	 */
-	err = get_user_pages(current, mm, uaddr, 1, 0, 0, &page, NULL);
+	err = get_user_pages(current, mm, address, 1, 0, 0, &page, NULL);
 	if (err >= 0) {
 		key->shared.pgoff =
 			page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
@@ -247,12 +248,12 @@ static void drop_key_refs(union futex_ke
 	}
 }
 
-static inline int get_futex_value_locked(int *dest, int __user *from)
+static inline int get_futex_value_locked(u32 *dest, u32 __user *from)
 {
 	int ret;
 
 	inc_preempt_count();
-	ret = __copy_from_user_inatomic(dest, from, sizeof(int));
+	ret = __copy_from_user_inatomic(dest, from, sizeof(u32));
 	dec_preempt_count();
 
 	return ret ? -EFAULT : 0;
@@ -289,12 +290,12 @@ static void wake_futex(struct futex_q *q
  * Wake up all waiters hashed on the physical page that is mapped
  * to this virtual address:
  */
-static int futex_wake(unsigned long uaddr, int nr_wake)
+static int futex_wake(u32 __user *uaddr, int nr_wake)
 {
-	union futex_key key;
-	struct futex_hash_bucket *bh;
-	struct list_head *head;
+	struct futex_hash_bucket *hb;
 	struct futex_q *this, *next;
+	struct list_head *head;
+	union futex_key key;
 	int ret;
 
 	down_read(&current->mm->mmap_sem);
@@ -303,9 +304,9 @@ static int futex_wake(unsigned long uadd
 	if (unlikely(ret != 0))
 		goto out;
 
-	bh = hash_futex(&key);
-	spin_lock(&bh->lock);
-	head = &bh->chain;
+	hb = hash_futex(&key);
+	spin_lock(&hb->lock);
+	head = &hb->chain;
 
 	list_for_each_entry_safe(this, next, head, list) {
 		if (match_futex (&this->key, &key)) {
@@ -315,7 +316,7 @@ static int futex_wake(unsigned long uadd
 		}
 	}
 
-	spin_unlock(&bh->lock);
+	spin_unlock(&hb->lock);
 out:
 	up_read(&current->mm->mmap_sem);
 	return ret;
@@ -325,10 +326,12 @@ out:
  * Wake up all waiters hashed on the physical page that is mapped
  * to this virtual address:
  */
-static int futex_wake_op(unsigned long uaddr1, unsigned long uaddr2, int nr_wake, int nr_wake2, int op)
+static int
+futex_wake_op(u32 __user *uaddr1, u32 __user *uaddr2,
+	      int nr_wake, int nr_wake2, int op)
 {
 	union futex_key key1, key2;
-	struct futex_hash_bucket *bh1, *bh2;
+	struct futex_hash_bucket *hb1, *hb2;
 	struct list_head *head;
 	struct futex_q *this, *next;
 	int ret, op_ret, attempt = 0;
@@ -343,27 +346,29 @@ retryfull:
 	if (unlikely(ret != 0))
 		goto out;
 
-	bh1 = hash_futex(&key1);
-	bh2 = hash_futex(&key2);
+	hb1 = hash_futex(&key1);
+	hb2 = hash_futex(&key2);
 
 retry:
-	if (bh1 < bh2)
-		spin_lock(&bh1->lock);
-	spin_lock(&bh2->lock);
-	if (bh1 > bh2)
-		spin_lock(&bh1->lock);
+	if (hb1 < hb2)
+		spin_lock(&hb1->lock);
+	spin_lock(&hb2->lock);
+	if (hb1 > hb2)
+		spin_lock(&hb1->lock);
 
-	op_ret = futex_atomic_op_inuser(op, (int __user *)uaddr2);
+	op_ret = futex_atomic_op_inuser(op, uaddr2);
 	if (unlikely(op_ret < 0)) {
-		int dummy;
+		u32 dummy;
 
-		spin_unlock(&bh1->lock);
-		if (bh1 != bh2)
-			spin_unlock(&bh2->lock);
+		spin_unlock(&hb1->lock);
+		if (hb1 != hb2)
+			spin_unlock(&hb2->lock);
 
 #ifndef CONFIG_MMU
-		/* we don't get EFAULT from MMU faults if we don't have an MMU,
-		 * but we might get them from range checking */
+		/*
+		 * we don't get EFAULT from MMU faults if we don't have an MMU,
+		 * but we might get them from range checking
+		 */
 		ret = op_ret;
 		goto out;
 #endif
@@ -373,23 +378,26 @@ retry:
 			goto out;
 		}
 
-		/* futex_atomic_op_inuser needs to both read and write
+		/*
+		 * futex_atomic_op_inuser needs to both read and write
 		 * *(int __user *)uaddr2, but we can't modify it
 		 * non-atomically.  Therefore, if get_user below is not
 		 * enough, we need to handle the fault ourselves, while
-		 * still holding the mmap_sem.  */
+		 * still holding the mmap_sem.
+		 */
 		if (attempt++) {
 			struct vm_area_struct * vma;
 			struct mm_struct *mm = current->mm;
+			unsigned long address = (unsigned long)uaddr2;
 
 			ret = -EFAULT;
 			if (attempt >= 2 ||
-			    !(vma = find_vma(mm, uaddr2)) ||
-			    vma->vm_start > uaddr2 ||
+			    !(vma = find_vma(mm, address)) ||
+			    vma->vm_start > address ||
 			    !(vma->vm_flags & VM_WRITE))
 				goto out;
 
-			switch (handle_mm_fault(mm, vma, uaddr2, 1)) {
+			switch (handle_mm_fault(mm, vma, address, 1)) {
 			case VM_FAULT_MINOR:
 				current->min_flt++;
 				break;
@@ -402,18 +410,20 @@ retry:
 			goto retry;
 		}
 
-		/* If we would have faulted, release mmap_sem,
-		 * fault it in and start all over again.  */
+		/*
+		 * If we would have faulted, release mmap_sem,
+		 * fault it in and start all over again.
+		 */
 		up_read(&current->mm->mmap_sem);
 
-		ret = get_user(dummy, (int __user *)uaddr2);
+		ret = get_user(dummy, uaddr2);
 		if (ret)
 			return ret;
 
 		goto retryfull;
 	}
 
-	head = &bh1->chain;
+	head = &hb1->chain;
 
 	list_for_each_entry_safe(this, next, head, list) {
 		if (match_futex (&this->key, &key1)) {
@@ -424,7 +434,7 @@ retry:
 	}
 
 	if (op_ret > 0) {
-		head = &bh2->chain;
+		head = &hb2->chain;
 
 		op_ret = 0;
 		list_for_each_entry_safe(this, next, head, list) {
@@ -437,9 +447,9 @@ retry:
 		ret += op_ret;
 	}
 
-	spin_unlock(&bh1->lock);
-	if (bh1 != bh2)
-		spin_unlock(&bh2->lock);
+	spin_unlock(&hb1->lock);
+	if (hb1 != hb2)
+		spin_unlock(&hb2->lock);
 out:
 	up_read(&current->mm->mmap_sem);
 	return ret;
@@ -449,11 +459,11 @@ out:
  * Requeue all waiters hashed on one physical page to another
  * physical page.
  */
-static int futex_requeue(unsigned long uaddr1, unsigned long uaddr2,
-			 int nr_wake, int nr_requeue, int *valp)
+static int futex_requeue(u32 __user *uaddr1, u32 __user *uaddr2,
+			 int nr_wake, int nr_requeue, u32 *cmpval)
 {
 	union futex_key key1, key2;
-	struct futex_hash_bucket *bh1, *bh2;
+	struct futex_hash_bucket *hb1, *hb2;
 	struct list_head *head1;
 	struct futex_q *this, *next;
 	int ret, drop_count = 0;
@@ -468,68 +478,69 @@ static int futex_requeue(unsigned long u
 	if (unlikely(ret != 0))
 		goto out;
 
-	bh1 = hash_futex(&key1);
-	bh2 = hash_futex(&key2);
+	hb1 = hash_futex(&key1);
+	hb2 = hash_futex(&key2);
 
-	if (bh1 < bh2)
-		spin_lock(&bh1->lock);
-	spin_lock(&bh2->lock);
-	if (bh1 > bh2)
-		spin_lock(&bh1->lock);
+	if (hb1 < hb2)
+		spin_lock(&hb1->lock);
+	spin_lock(&hb2->lock);
+	if (hb1 > hb2)
+		spin_lock(&hb1->lock);
 
-	if (likely(valp != NULL)) {
-		int curval;
+	if (likely(cmpval != NULL)) {
+		u32 curval;
 
-		ret = get_futex_value_locked(&curval, (int __user *)uaddr1);
+		ret = get_futex_value_locked(&curval, uaddr1);
 
 		if (unlikely(ret)) {
-			spin_unlock(&bh1->lock);
-			if (bh1 != bh2)
-				spin_unlock(&bh2->lock);
+			spin_unlock(&hb1->lock);
+			if (hb1 != hb2)
+				spin_unlock(&hb2->lock);
 
-			/* If we would have faulted, release mmap_sem, fault
+			/*
+			 * If we would have faulted, release mmap_sem, fault
 			 * it in and start all over again.
 			 */
 			up_read(&current->mm->mmap_sem);
 
-			ret = get_user(curval, (int __user *)uaddr1);
+			ret = get_user(curval, uaddr1);
 
 			if (!ret)
 				goto retry;
 
 			return ret;
 		}
-		if (curval != *valp) {
+		if (curval != *cmpval) {
 			ret = -EAGAIN;
 			goto out_unlock;
 		}
 	}
 
-	head1 = &bh1->chain;
+	head1 = &hb1->chain;
 	list_for_each_entry_safe(this, next, head1, list) {
 		if (!match_futex (&this->key, &key1))
 			continue;
 		if (++ret <= nr_wake) {
 			wake_futex(this);
 		} else {
-			list_move_tail(&this->list, &bh2->chain);
-			this->lock_ptr = &bh2->lock;
+			list_move_tail(&this->list, &hb2->chain);
+			this->lock_ptr = &hb2->lock;
 			this->key = key2;
 			get_key_refs(&key2);
 			drop_count++;
 
 			if (ret - nr_wake >= nr_requeue)
 				break;
-			/* Make sure to stop if key1 == key2 */
-			if (head1 == &bh2->chain && head1 != &next->list)
+			/* Make sure to stop if key1 == key2: */
+			if (head1 == &hb2->chain && head1 != &next->list)
 				head1 = &this->list;
 		}
 	}
 
 out_unlock:
-	spin_unlock(&bh1->lock);
-	if (bh1 != bh2)
-		spin_unlock(&bh2->lock);
+	spin_unlock(&hb1->lock);
+	if (hb1 != hb2)
+		spin_unlock(&hb2->lock);
 
 	/* drop_key_refs() must be called outside the spinlocks. */
 	while (--drop_count >= 0)
@@ -544,7 +555,7 @@ out:
 static inline struct futex_hash_bucket *
 queue_lock(struct futex_q *q, int fd, struct file *filp)
 {
-	struct futex_hash_bucket *bh;
+	struct futex_hash_bucket *hb;
 
 	q->fd = fd;
 	q->filp = filp;
@@ -552,23 +563,23 @@ queue_lock(struct futex_q *q, int fd, st
 	init_waitqueue_head(&q->waiters);
 
 	get_key_refs(&q->key);
-	bh = hash_futex(&q->key);
-	q->lock_ptr = &bh->lock;
+	hb = hash_futex(&q->key);
+	q->lock_ptr = &hb->lock;
 
-	spin_lock(&bh->lock);
-	return bh;
+	spin_lock(&hb->lock);
+	return hb;
 }
 
-static inline void __queue_me(struct futex_q *q, struct futex_hash_bucket *bh)
+static inline void __queue_me(struct futex_q *q, struct futex_hash_bucket *hb)
 {
-	list_add_tail(&q->list, &bh->chain);
-	spin_unlock(&bh->lock);
+	list_add_tail(&q->list, &hb->chain);
+	spin_unlock(&hb->lock);
 }
 
 static inline void
-queue_unlock(struct futex_q *q, struct futex_hash_bucket *bh)
+queue_unlock(struct futex_q *q, struct futex_hash_bucket *hb)
 {
-	spin_unlock(&bh->lock);
+	spin_unlock(&hb->lock);
 	drop_key_refs(&q->key);
 }
 
@@ -580,16 +591,17 @@ queue_unlock(struct futex_q *q, struct f
 /* The key must be already stored in q->key. */
 static void queue_me(struct futex_q *q, int fd, struct file *filp)
 {
-	struct futex_hash_bucket *bh;
-	bh = queue_lock(q, fd, filp);
-	__queue_me(q, bh);
+	struct futex_hash_bucket *hb;
+
+	hb = queue_lock(q, fd, filp);
+	__queue_me(q, hb);
 }
 
 /* Return 1 if we were still queued (ie. 0 means we were woken) */
 static int unqueue_me(struct futex_q *q)
 {
-	int ret = 0;
 	spinlock_t *lock_ptr;
+	int ret = 0;
 
 	/* In the common case we don't take the spinlock, which is nice. */
  retry:
@@ -623,12 +635,13 @@ static int unqueue_me(struct futex_q *q)
 	return ret;
 }
 
-static int futex_wait(unsigned long uaddr, int val, unsigned long time)
+static int futex_wait(u32 __user *uaddr, u32 val, unsigned long time)
 {
 	DECLARE_WAITQUEUE(wait, current);
-	int ret, curval;
+	struct futex_hash_bucket *hb;
 	struct futex_q q;
-	struct futex_hash_bucket *bh;
+	u32 uval;
+	int ret;
 
  retry:
 	down_read(&current->mm->mmap_sem);
@@ -637,7 +650,7 @@ static int futex_wait(unsigned long uadd
 	if (unlikely(ret != 0))
 		goto out_release_sem;
 
-	bh = queue_lock(&q, -1, NULL);
+	hb = queue_lock(&q, -1, NULL);
 
 	/*
 	 * Access the page AFTER the futex is queued.
@@ -659,31 +672,31 @@ static int futex_wait(unsigned long uadd
 	 * We hold the mmap semaphore, so the mapping cannot have changed
 	 * since we looked it up in get_futex_key.
 	 */
-
-	ret = get_futex_value_locked(&curval, (int __user *)uaddr);
+	ret = get_futex_value_locked(&uval, uaddr);
 
 	if (unlikely(ret)) {
-		queue_unlock(&q, bh);
+		queue_unlock(&q, hb);
 
-		/* If we would have faulted, release mmap_sem, fault it in and
+		/*
+		 * If we would have faulted, release mmap_sem, fault it in and
 		 * start all over again.
 		 */
 		up_read(&current->mm->mmap_sem);
 
-		ret = get_user(curval, (int __user *)uaddr);
+		ret = get_user(uval, uaddr);
 
 		if (!ret)
 			goto retry;
 		return ret;
 	}
-	if (curval != val) {
+	if (uval != val) {
 		ret = -EWOULDBLOCK;
-		queue_unlock(&q, bh);
+		queue_unlock(&q, hb);
 		goto out_release_sem;
 	}
 
 	/* Only actually queue if *uaddr contained val.  */
-	__queue_me(&q, bh);
+	__queue_me(&q, hb);
 
 	/*
 	 * Now the futex is queued and we have checked the data, we
@@ -721,8 +734,10 @@ static int futex_wait(unsigned long uadd
 		return 0;
 	if (time == 0)
 		return -ETIMEDOUT;
-	/* We expect signal_pending(current), but another thread may
-	 * have handled it for us already. */
+	/*
+	 * We expect signal_pending(current), but another thread may
+	 * have handled it for us already.
+	 */
 	return -EINTR;
 
  out_release_sem:
@@ -736,6 +751,7 @@ static int futex_close(struct inode *ino
 
 	unqueue_me(q);
 	kfree(q);
+
 	return 0;
 }
 
@@ -767,7 +783,7 @@ static struct file_operations futex_fops
  * Signal allows caller to avoid the race which would occur if they
  * set the sigio stuff up afterwards.
  */
-static int futex_fd(unsigned long uaddr, int signal)
+static int futex_fd(u32 __user *uaddr, int signal)
 {
 	struct futex_q *q;
 	struct file *filp;
@@ -938,7 +954,7 @@ retry:
 			goto retry;
 
 		if (uval & FUTEX_WAITERS)
-			futex_wake((unsigned long)uaddr, 1);
+			futex_wake(uaddr, 1);
 	}
 	return 0;
 }
@@ -1000,8 +1016,8 @@ void exit_robust_list(struct task_struct
 	}
 }
 
-long do_futex(unsigned long uaddr, int op, int val, unsigned long timeout,
-		unsigned long uaddr2, int val2, int val3)
+long do_futex(u32 __user *uaddr, int op, u32 val, unsigned long timeout,
+		u32 __user *uaddr2, u32 val2, u32 val3)
 {
 	int ret;
 
@@ -1032,13 +1048,13 @@ long do_futex(unsigned long uaddr, int o
 }
 
 
-asmlinkage long sys_futex(u32 __user *uaddr, int op, int val,
+asmlinkage long sys_futex(u32 __user *uaddr, int op, u32 val,
 			  struct timespec __user *utime, u32 __user *uaddr2,
-			  int val3)
+			  u32 val3)
 {
 	struct timespec t;
 	unsigned long timeout = MAX_SCHEDULE_TIMEOUT;
-	int val2 = 0;
+	u32 val2 = 0;
 
 	if (utime && (op == FUTEX_WAIT)) {
 		if (copy_from_user(&t, utime, sizeof(t)) != 0)
@@ -1051,10 +1067,9 @@ asmlinkage long sys_futex(u32 __user *ua
 	 * requeue parameter in 'utime' if op == FUTEX_REQUEUE.
 	 */
 	if (op >= FUTEX_REQUEUE)
-		val2 = (int) (unsigned long) utime;
+		val2 = (u32) (unsigned long) utime;
 
-	return do_futex((unsigned long)uaddr, op, val, timeout,
-			(unsigned long)uaddr2, val2, val3);
+	return do_futex(uaddr, op, val, timeout, uaddr2, val2, val3);
 }
 
 static struct super_block *
