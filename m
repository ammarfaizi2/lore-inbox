Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263755AbTJCPup (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 11:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263757AbTJCPup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 11:50:45 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:5768 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S263755AbTJCPu0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 11:50:26 -0400
Date: Fri, 3 Oct 2003 16:49:38 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Klaus Dittrich <kladit@t-online.de>, Andrew Morton <akpm@zip.com.au>,
       Boris Hu <boris.hu@intel.com>
Subject: Re: [PATCH] For testing/scrutiny: futex locking fix against 2.6.0-test6
Message-ID: <20031003154938.GB17968@mail.shareable.org>
References: <20031001053108.GA1131@mail.shareable.org> <20031003072939.C32A92C0F9@lists.samba.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <20031003072939.C32A92C0F9@lists.samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Rusty Russell wrote:
> 	The futex_requeue code has to drop all locks to call
> drop_key_ref, but that exposes it to races against wake_up.  Not just
> the key, but the local "moved" list could be corrupted.  I simply
> can't think of a neat way of solving this: it's an independent problem
> from whether locks are hashed or not.

You're looking at a very old version! :)

Please look at futex_refs_and_lock_fix-2.6.0-test6 + futex_lock_fix2-2.6.0-test6,
attached for your convenience.

There is no "moved" list any more, not to mention locks taken less
often and the hash calculation is done less often (i.e. once instead
of three times in futex_wait).

The requeue problem is solved.  There should be no race conditions,
but the locking is subtler than before so I'd appreciate you taking a
look at it.

> fixed a requeue bug where you requeue in backwards order (I
> don't think it's really important, but...).

I don't see that either of the patches requeue backwards.  The patch
with "moved" in it iterates over the first hash list head-to-tail,
adding entries to the tail of "moved".  Then it iterates over "moved"
head-to-tail, adding entries to the tail of the other hash list.  That
is the right order, isn't it?

Thanks,
-- Jamie

--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="futex_refs_and_lock_fix-2.6.0-test6.patch"

Subject: [PATCH] For testing/scrutiny: futex locking fix against 2.6.0-test6
Patch: futex_refs_and_lock_fix-2.6.0-test6-jl1

NOTE: This patch is *not* ready for inclusion until a few people have
cast their eyes over it and it's been more widely tested than my machine.
Please do not apply it to the bk tree until then.

Klaus Dittrich reported a bug in 2.6.0-test6 futexes, which we believe
is due to the introduction of hashed locks.  Hugh Dickins pointed out
that futex_requeue() can change the hash key while it is being read in a
different thread, resulting in a wrong hash value.  That is used to
select the wrong hashed lock, leading to list corruption and oops.

This patch purports to fix that bug.

It does some rather subtle things with memory ordering that I would like
Rusty and/or Hugh in particular to think about, and I'd like Ulrich or
someone else to give it a proper stress test on a big box.

The essence of the patch is two things.

1. Avoid doing hash calculations on changing keys, by storing the
address of the selected lock in the futex_q.  That address can be
updated atomically in futex_requeue, because it's just a pointer, and it
is done at a time when it is ok for the reader to use either value.

2. Avoid locking, and hence depending on which lock to use, in some
places where it can be avoided.

It's possible that this will run faster than 2.6.0-test6, because no
spinlock is taken, usually, when a waiter wakes up.  For the big boxes,
that means less cache traffic and it may improve benchmarks.
Conversely the mm reference count might have a negative effect.

The patch is against vanilla 2.6.0-test6 for convenience, and includes
the mm/inode reference changes I sent earlier this week.  Sorry, I do
not have time to separate them at the moment.

I am running this now on my machine, and I've seen no problems so far.
The test Ulrich sent a few weeks ago, tst-cond2, runs fine.

Thanks,
-- Jamie

diff -urN --exclude-from=dontdiff orig-2.6.0-test6/kernel/futex.c dual-2.6.0-test6/kernel/futex.c
--- orig-2.6.0-test6/kernel/futex.c	2003-09-30 05:41:14.000000000 +0100
+++ dual-2.6.0-test6/kernel/futex.c	2003-10-01 05:58:58.000000000 +0100
@@ -45,6 +45,9 @@
  * Futexes are matched on equal values of this key.
  * The key type depends on whether it's a shared or private mapping.
  * Don't rearrange members without looking at hash_futex().
+ *
+ * offset is aligned to a multiple of sizeof(u32) (== 4) by definition.
+ * We set bit 0 to indicate if it's an inode-based key.
  */
 union futex_key {
 	struct {
@@ -66,12 +69,20 @@
 
 /*
  * We use this hashed waitqueue instead of a normal wait_queue_t, so
- * we can wake only the relevant ones (hashed queues may be shared):
+ * we can wake only the relevant ones (hashed queues may be shared).
+ *
+ * A futex_q has a woken state, just like tasks have TASK_RUNNING.
+ * It is considered woken when list_empty(&q->list) || q->lock_ptr == 0.
+ * The order of wakup is always to make the first condition true, then
+ * wake up q->waiters, then make the second condition true.
  */
 struct futex_q {
 	struct list_head list;
 	wait_queue_head_t waiters;
 
+	/* Which hash list lock to use. */
+	spinlock_t *lock_ptr;
+
 	/* Key which the futex is hashed on. */
 	union futex_key key;
 
@@ -124,8 +135,7 @@
  * Returns: 0, or negative error code.
  * The key words are stored in *key on success.
  *
- * Should be called with &current->mm->mmap_sem,
- * but NOT &futex_lock or &current->mm->page_table_lock.
+ * Should be called with &current->mm->mmap_sem but NOT any spinlocks.
  */
 static int get_futex_key(unsigned long uaddr, union futex_key *key)
 {
@@ -172,9 +182,10 @@
 	}
 
 	/*
-	 * Linear mappings are also simple.
+	 * Linear file mappings are also simple.
 	 */
 	key->shared.inode = vma->vm_file->f_dentry->d_inode;
+	key->both.offset++; /* Bit 0 of offset indicates inode-based key. */
 	if (likely(!(vma->vm_flags & VM_NONLINEAR))) {
 		key->shared.pgoff = (((uaddr - vma->vm_start) >> PAGE_SHIFT)
 				     + vma->vm_pgoff);
@@ -214,16 +225,62 @@
 	return err;
 }
 
+/*
+ * Take a reference to the resource addressed by a key.
+ * Can be called while holding spinlocks.
+ *
+ * NOTE: mmap_sem MUST be held between get_futex_key() and calling this
+ * function, if it is called at all.  mmap_sem keeps key->shared.inode valid.
+ */
+static inline void get_key_refs(union futex_key *key)
+{
+	if (key->both.ptr != 0) {
+		if (key->both.offset & 1)
+			atomic_inc(&key->shared.inode->i_count);
+		else
+			atomic_inc(&key->private.mm->mm_count);
+	}
+}
+
+/*
+ * Drop a reference to the resource addressed by a key.
+ * The hash bucket spinlock must not be held.
+ */
+static inline void drop_key_refs(union futex_key *key)
+{
+	if (key->both.ptr != 0) {
+		if (key->both.offset & 1)
+			iput(key->shared.inode);
+		else
+			mmdrop(key->private.mm);
+	}
+}
+
+/* The hash bucket lock must be held when this is called.
+   Afterwards, the futex_q must not be accessed. */
+static inline void wake_futex(struct futex_q *q)
+{
+	list_del_init(&q->list);
+	if (q->filp)
+		send_sigio(&q->filp->f_owner, q->fd, POLL_IN);
+	/* The lock in wake_up_all() is a crucial memory barrier after the
+	   list_del_init() and also before assigning to q->lock_ptr. */
+	wake_up_all(&q->waiters);
+	/* The waiting task can free the futex_q as soon as this is written,
+	   without taking any locks.  This must come last. */
+	q->lock_ptr = 0;
+}
 
 /*
  * Wake up all waiters hashed on the physical page that is mapped
  * to this virtual address:
  */
-static int futex_wake(unsigned long uaddr, int num)
+static int futex_wake(unsigned long uaddr, int nr_wake)
 {
-	struct list_head *i, *next, *head;
-	struct futex_hash_bucket *bh;
 	union futex_key key;
+	struct futex_hash_bucket *bh;
+	struct list_head *head;
+	struct futex_q *this, *next;
 	int ret;
 
 	down_read(&current->mm->mmap_sem);
@@ -236,21 +293,15 @@
 	spin_lock(&bh->lock);
 	head = &bh->chain;
 
-	list_for_each_safe(i, next, head) {
-		struct futex_q *this = list_entry(i, struct futex_q, list);
-
+	list_for_each_entry_safe(this, next, head, list) {
 		if (match_futex (&this->key, &key)) {
-			list_del_init(i);
-			wake_up_all(&this->waiters);
-			if (this->filp)
-				send_sigio(&this->filp->f_owner, this->fd, POLL_IN);
-			ret++;
-			if (ret >= num)
+			wake_futex(this);
+			if (++ret >= nr_wake)
 				break;
 		}
 	}
-	spin_unlock(&bh->lock);
 
+	spin_unlock(&bh->lock);
 out:
 	up_read(&current->mm->mmap_sem);
 	return ret;
@@ -263,10 +314,11 @@
 static int futex_requeue(unsigned long uaddr1, unsigned long uaddr2,
 				int nr_wake, int nr_requeue)
 {
-	struct list_head *i, *next, *head1, *head2;
-	struct futex_hash_bucket *bh1, *bh2;
 	union futex_key key1, key2;
-	int ret;
+	struct futex_hash_bucket *bh1, *bh2;
+	struct list_head *head1;
+	struct futex_q *this, *next;
+	int ret, drop_count = 0;
 
 	down_read(&current->mm->mmap_sem);
 
@@ -279,78 +331,88 @@
 
 	bh1 = hash_futex(&key1);
 	bh2 = hash_futex(&key2);
-	if (bh1 < bh2) {
+
+	if (bh1 < bh2)
+		spin_lock(&bh1->lock);
+	spin_lock(&bh2->lock);
+	if (bh1 > bh2)
 		spin_lock(&bh1->lock);
-		spin_lock(&bh2->lock);
-	} else {
-		spin_lock(&bh2->lock);
-		if (bh1 > bh2)
-			spin_lock(&bh1->lock);
-	}
-	head1 = &bh1->chain;
-	head2 = &bh2->chain;
 
-	list_for_each_safe(i, next, head1) {
-		struct futex_q *this = list_entry(i, struct futex_q, list);
+	head1 = &bh1->chain;
+	list_for_each_entry_safe(this, next, head1, list) {
+		if (!match_futex (&this->key, &key1))
+			continue;
+		if (++ret <= nr_wake) {
+			wake_futex(this);
+		} else {
+			list_move_tail(&this->list, &bh2->chain);
+			this->lock_ptr = &bh2->lock;
+			this->key = key2;
+			get_key_refs(&key2);
+			drop_count++;
 
-		if (match_futex (&this->key, &key1)) {
-			list_del_init(i);
-			if (++ret <= nr_wake) {
-				wake_up_all(&this->waiters);
-				if (this->filp)
-					send_sigio(&this->filp->f_owner,
-							this->fd, POLL_IN);
-			} else {
-				list_add_tail(i, head2);
-				this->key = key2;
-				if (ret - nr_wake >= nr_requeue)
-					break;
-				/* Make sure to stop if key1 == key2 */
-				if (head1 == head2 && head1 != next)
-					head1 = i;
-			}
+			if (ret - nr_wake >= nr_requeue)
+				break;
+			/* Make sure to stop if key1 == key2 */
+			if (head1 == &bh2->chain && head1 != &next->list)
+				head1 = &this->list;
 		}
 	}
-	if (bh1 < bh2) {
-		spin_unlock(&bh2->lock);
-		spin_unlock(&bh1->lock);
-	} else {
-		if (bh1 > bh2)
-			spin_unlock(&bh1->lock);
+
+	spin_unlock(&bh1->lock);
+	if (bh1 != bh2)
 		spin_unlock(&bh2->lock);
-	}
+
+	/* drop_key_refs() must be called outside the spinlocks. */
+	while (--drop_count >= 0)
+		drop_key_refs(&key1);
+
 out:
 	up_read(&current->mm->mmap_sem);
 	return ret;
 }
 
-static inline void queue_me(struct futex_q *q, union futex_key *key,
-			    int fd, struct file *filp)
+/*
+ * queue_me and unqueue_me must be called as a pair, each
+ * exactly once.  They are called with the hashed spinlock held.
+ */
+
+/* The key must be already stored in q->key. */
+static inline void queue_me(struct futex_q *q, int fd, struct file *filp)
 {
-	struct futex_hash_bucket *bh = hash_futex(key);
-	struct list_head *head = &bh->chain;
+	struct futex_hash_bucket *bh;
 
-	q->key = *key;
 	q->fd = fd;
 	q->filp = filp;
 
+	init_waitqueue_head(&q->waiters);
+
+	get_key_refs(&q->key);
+	bh = hash_futex(&q->key);
+	q->lock_ptr = &bh->lock;
+
 	spin_lock(&bh->lock);
-	list_add_tail(&q->list, head);
+	list_add_tail(&q->list, &bh->chain);
 	spin_unlock(&bh->lock);
 }
 
 /* Return 1 if we were still queued (ie. 0 means we were woken) */
 static inline int unqueue_me(struct futex_q *q)
 {
-	struct futex_hash_bucket *bh = hash_futex(&q->key);
 	int ret = 0;
+	spinlock_t *lock_ptr = q->lock_ptr;
 
-	spin_lock(&bh->lock);
-	if (!list_empty(&q->list)) {
-		list_del(&q->list);
-		ret = 1;
+	/* In the common case we don't take the spinlock, which is nice. */
+	if (lock_ptr != 0) {
+		spin_lock(lock_ptr);
+		if (!list_empty(&q->list)) {
+			list_del(&q->list);
+			ret = 1;
+		}
+		spin_unlock(lock_ptr);
 	}
-	spin_unlock(&bh->lock);
+
+	drop_key_refs(&q->key);
 	return ret;
 }
 
@@ -358,19 +420,15 @@
 {
 	DECLARE_WAITQUEUE(wait, current);
 	int ret, curval;
-	union futex_key key;
 	struct futex_q q;
-	struct futex_hash_bucket *bh = NULL;
-
-	init_waitqueue_head(&q.waiters);
 
 	down_read(&current->mm->mmap_sem);
 
-	ret = get_futex_key(uaddr, &key);
+	ret = get_futex_key(uaddr, &q.key);
 	if (unlikely(ret != 0))
 		goto out_release_sem;
 
-	queue_me(&q, &key, -1, NULL);
+	queue_me(&q, -1, NULL);
 
 	/*
 	 * Access the page after the futex is queued.
@@ -400,23 +458,15 @@
 	 * rely on the futex_wake() code removing us from hash when it
 	 * wakes us up.
 	 */
-	add_wait_queue(&q.waiters, &wait);
-	bh = hash_futex(&key);
-	spin_lock(&bh->lock);
-	set_current_state(TASK_INTERRUPTIBLE);
-
-	if (unlikely(list_empty(&q.list))) {
-		/*
-		 * We were woken already.
-		 */
-		spin_unlock(&bh->lock);
-		set_current_state(TASK_RUNNING);
-		return 0;
-	}
 
-	spin_unlock(&bh->lock);
-	time = schedule_timeout(time);
-	set_current_state(TASK_RUNNING);
+	/* add_wait_queue is the barrier after __set_current_state. */
+	__set_current_state(TASK_INTERRUPTIBLE);
+	add_wait_queue(&q.waiters, &wait);
+	/* !list_empty() is safe here without any lock.
+	   q.lock_ptr != 0 is not safe, because of ordering against wakeup. */
+	if (likely(!list_empty(&q.list)))
+		time = schedule_timeout(time);
+	__set_current_state(TASK_RUNNING);
 
 	/*
 	 * NOTE: we don't remove ourselves from the waitqueue because
@@ -446,7 +496,7 @@
 	struct futex_q *q = filp->private_data;
 
 	unqueue_me(q);
-	kfree(filp->private_data);
+	kfree(q);
 	return 0;
 }
 
@@ -455,14 +505,18 @@
 			       struct poll_table_struct *wait)
 {
 	struct futex_q *q = filp->private_data;
-	struct futex_hash_bucket *bh = hash_futex(&q->key);
-	int ret = 0;
+	spinlock_t *lock_ptr;
+	int ret = POLLIN | POLLRDNORM;
 
 	poll_wait(filp, &q->waiters, wait);
-	spin_lock(&bh->lock);
-	if (list_empty(&q->list))
-		ret = POLLIN | POLLRDNORM;
-	spin_unlock(&bh->lock);
+
+	lock_ptr = q->lock_ptr;
+	if (lock_ptr != 0) {
+		spin_lock(lock_ptr);
+		if (!list_empty(&q->list))
+			ret = 0;
+		spin_unlock(lock_ptr);
+	}
 
 	return ret;
 }
@@ -477,7 +531,6 @@
 static int futex_fd(unsigned long uaddr, int signal)
 {
 	struct futex_q *q;
-	union futex_key key;
 	struct file *filp;
 	int ret, err;
 
@@ -519,20 +572,22 @@
 	}
 
 	down_read(&current->mm->mmap_sem);
-	err = get_futex_key(uaddr, &key);
-	up_read(&current->mm->mmap_sem);
+	err = get_futex_key(uaddr, &q->key);
 
 	if (unlikely(err != 0)) {
+		up_read(&current->mm->mmap_sem);
 		put_unused_fd(ret);
 		put_filp(filp);
 		kfree(q);
 		return err;
 	}
 
-	init_waitqueue_head(&q->waiters);
+	/* queue_me() must be called before releasing mmap_sem, because
+	   key->shared.inode needs to be referenced while holding it. */
 	filp->private_data = q;
 
-	queue_me(q, &key, ret, filp);
+	queue_me(q, ret, filp);
+	up_read(&current->mm->mmap_sem);
 
 	/* Now we map fd to filp, so userspace can access it */
 	fd_install(ret, filp);

--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="futex_lock_fix2-2.6.0-test6.patch"

Subject: [PATCH] fix to futex locking fix

Patch: futex_lock_fix2-2.6.0-test6
Depends on: futex_refs_and_lock_fix-2.6.0-test6

I had an inkling when I sent out the recent futex hashed-lock fix that
there was a race condition, but I was too tired to be sure or to work
out a solution.

This patch fixes it.  In unqueue_me(), if certain events occur in
another task we take the wrong spinlock.  I realised that yesterday, but
proving that the fix works to my satisfaction required a state of higher
consciousness not normally attained until 5am (and soon lost..)

The form of the fix is inspired by an idea from Rusty.

Please folks, take a look at the fix in unqueue_me().  It looks simple
but the proof isn't obvious.

Oh, and some comment formatting requested by Andrew Morton. :)

Thanks,
-- Jamie

--- futex1-2.6.0-test6/kernel/futex.c	2003-10-03 05:27:59.000000000 +0100
+++ dual-2.6.0-test6/kernel/futex.c	2003-10-03 06:05:05.000000000 +0100
@@ -256,18 +256,24 @@
 	}
 }
 
-/* The hash bucket lock must be held when this is called.
-   Afterwards, the futex_q must not be accessed. */
+/*
+ * The hash bucket lock must be held when this is called.
+ * Afterwards, the futex_q must not be accessed.
+ */
 static inline void wake_futex(struct futex_q *q)
 {
 	list_del_init(&q->list);
 	if (q->filp)
 		send_sigio(&q->filp->f_owner, q->fd, POLL_IN);
-	/* The lock in wake_up_all() is a crucial memory barrier after the
-	   list_del_init() and also before assigning to q->lock_ptr. */
+	/*
+	 * The lock in wake_up_all() is a crucial memory barrier after the
+	 * list_del_init() and also before assigning to q->lock_ptr.
+	 */
 	wake_up_all(&q->waiters);
-	/* The waiting task can free the futex_q as soon as this is written,
-	   without taking any locks.  This must come last. */
+	/*
+	 * The waiting task can free the futex_q as soon as this is written,
+	 * without taking any locks.  This must come last.
+	 */
 	q->lock_ptr = 0;
 }
 
@@ -397,15 +403,34 @@
 }
 
 /* Return 1 if we were still queued (ie. 0 means we were woken) */
-static inline int unqueue_me(struct futex_q *q)
+static int unqueue_me(struct futex_q *q)
 {
 	int ret = 0;
-	spinlock_t *lock_ptr = q->lock_ptr;
+	spinlock_t *lock_ptr;
 
 	/* In the common case we don't take the spinlock, which is nice. */
+ retry:
+	lock_ptr = q->lock_ptr;
 	if (lock_ptr != 0) {
 		spin_lock(lock_ptr);
-		if (!list_empty(&q->list)) {
+		/*
+		 * q->lock_ptr can change between reading it and
+		 * spin_lock(), causing us to take the wrong lock.  This
+		 * corrects the race condition.
+		 *
+		 * Reasoning goes like this: if we have the wrong lock,
+		 * q->lock_ptr must have changed (maybe several times)
+		 * between reading it and the spin_lock().  It can
+		 * change again after the spin_lock() but only if it was
+		 * already changed before the spin_lock().  It cannot,
+		 * however, change back to the original value.  Therefore
+		 * we can detect whether we acquired the correct lock.
+		 */
+		if (unlikely(lock_ptr != q->lock_ptr)) {
+			spin_unlock(lock_ptr);
+			goto retry;
+		}
+		if (likely(!list_empty(&q->list))) {
 			list_del(&q->list);
 			ret = 1;
 		}
@@ -462,8 +487,10 @@
 	/* add_wait_queue is the barrier after __set_current_state. */
 	__set_current_state(TASK_INTERRUPTIBLE);
 	add_wait_queue(&q.waiters, &wait);
-	/* !list_empty() is safe here without any lock.
-	   q.lock_ptr != 0 is not safe, because of ordering against wakeup. */
+	/*
+	 * !list_empty() is safe here without any lock.
+	 * q.lock_ptr != 0 is not safe, because of ordering against wakeup.
+	 */
 	if (likely(!list_empty(&q.list)))
 		time = schedule_timeout(time);
 	__set_current_state(TASK_RUNNING);
@@ -505,18 +532,16 @@
 			       struct poll_table_struct *wait)
 {
 	struct futex_q *q = filp->private_data;
-	spinlock_t *lock_ptr;
-	int ret = POLLIN | POLLRDNORM;
+	int ret = 0;
 
 	poll_wait(filp, &q->waiters, wait);
 
-	lock_ptr = q->lock_ptr;
-	if (lock_ptr != 0) {
-		spin_lock(lock_ptr);
-		if (!list_empty(&q->list))
-			ret = 0;
-		spin_unlock(lock_ptr);
-	}
+	/*
+	 * list_empty() is safe here without any lock.
+	 * q->lock_ptr != 0 is not safe, because of ordering against wakeup.
+	 */
+	if (list_empty(&q->list))
+		ret = POLLIN | POLLRDNORM;
 
 	return ret;
 }
@@ -526,8 +551,10 @@
 	.poll		= futex_poll,
 };
 
-/* Signal allows caller to avoid the race which would occur if they
-   set the sigio stuff up afterwards. */
+/*
+ * Signal allows caller to avoid the race which would occur if they
+ * set the sigio stuff up afterwards.
+ */
 static int futex_fd(unsigned long uaddr, int signal)
 {
 	struct futex_q *q;
@@ -582,8 +609,10 @@
 		return err;
 	}
 
-	/* queue_me() must be called before releasing mmap_sem, because
-	   key->shared.inode needs to be referenced while holding it. */
+	/*
+	 * queue_me() must be called before releasing mmap_sem, because
+	 * key->shared.inode needs to be referenced while holding it.
+	 */
 	filp->private_data = q;
 
 	queue_me(q, ret, filp);

--xHFwDpU9dbj6ez1V--
