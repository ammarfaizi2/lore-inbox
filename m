Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbTJIBzr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 21:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbTJIBzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 21:55:47 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:54922 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261890AbTJIBzB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 21:55:01 -0400
Date: Thu, 9 Oct 2003 02:54:31 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
       Hugh Dickins <hugh@veritas.com>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@zip.com.au>
Subject: [PATCH] futex bug fixes
Message-ID: <20031009015431.GA18126@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch: futex_refs_and_lock_fix-2.6.0-test7


Dear Linus,

Please apply this patch.

It fixes two serious bugs in the futex code of 2.6.0-test7.

One is a race condition which results in list corruption when
FUTEX_REQUEUE is used.  It is due to the split locks change introduced
in 2.6.0-test6, and oopses when triggered.

The other is a security hole.  A program can use FUTEX_FD to create
futexes on mms or inodes which don't reference them, and when those
structures are reused by a different mm or inode, the addresses match.
The effect is that a malicious or flawed program can steal wakeups from
completely unrelated tasks, causing them to block (or worse if they are
counting on the token passing property).


These are the specific changes:

    1. Each futex_q retains a reference to its key mm or inode.

    2. The condition for a futex_q to indicate that it's woken can usually
       be interrogated lock-free.

    3. futex_wait calls the hash function once instead of three times,
       and usually takes the per-bucket lock once too.

    4. When a futex is woken, the per-bucket lock is not usually taken,
       so that's one less cache line transfer during heavy SMP futex use.

    5. The wait condition and barriers in futex_wait are simpler.

    5. FUTEX_REQUEUE is fixed.  The per-bucket lock juggling is done
       in such a way that there are no race conditions against the tests
       for whether a futex is woken.


This patch is an combination of patches previously sent to the list.
Unfortunately I have not received the test results or benchmarks I was
hoping for, but an equivalent patch has been in Andrew Morton's tree for
a while, with no failure reports.  Also I have been running it on my own
SMP box for a while.  Conversely, we have received an oops report for the
2.6.0-test6 code, so the fix is needed.


Thanks,
-- Jamie

--- orig-2.6.0-test6/kernel/futex.c	2003-09-30 05:41:14.000000000 +0100
+++ dual-2.6.0-test6/kernel/futex.c	2003-10-03 06:05:05.000000000 +0100
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
@@ -214,16 +225,68 @@
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
+/*
+ * The hash bucket lock must be held when this is called.
+ * Afterwards, the futex_q must not be accessed.
+ */
+static inline void wake_futex(struct futex_q *q)
+{
+	list_del_init(&q->list);
+	if (q->filp)
+		send_sigio(&q->filp->f_owner, q->fd, POLL_IN);
+	/*
+	 * The lock in wake_up_all() is a crucial memory barrier after the
+	 * list_del_init() and also before assigning to q->lock_ptr.
+	 */
+	wake_up_all(&q->waiters);
+	/*
+	 * The waiting task can free the futex_q as soon as this is written,
+	 * without taking any locks.  This must come last.
+	 */
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
@@ -236,21 +299,15 @@
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
@@ -263,10 +320,11 @@
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
 
@@ -279,78 +337,107 @@
 
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
-static inline int unqueue_me(struct futex_q *q)
+static int unqueue_me(struct futex_q *q)
 {
-	struct futex_hash_bucket *bh = hash_futex(&q->key);
 	int ret = 0;
+	spinlock_t *lock_ptr;
 
-	spin_lock(&bh->lock);
-	if (!list_empty(&q->list)) {
-		list_del(&q->list);
-		ret = 1;
+	/* In the common case we don't take the spinlock, which is nice. */
+ retry:
+	lock_ptr = q->lock_ptr;
+	if (lock_ptr != 0) {
+		spin_lock(lock_ptr);
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
 
@@ -358,19 +445,15 @@
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
@@ -400,23 +483,17 @@
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
+	/*
+	 * !list_empty() is safe here without any lock.
+	 * q.lock_ptr != 0 is not safe, because of ordering against wakeup.
+	 */
+	if (likely(!list_empty(&q.list)))
+		time = schedule_timeout(time);
+	__set_current_state(TASK_RUNNING);
 
 	/*
 	 * NOTE: we don't remove ourselves from the waitqueue because
@@ -446,7 +523,7 @@
 	struct futex_q *q = filp->private_data;
 
 	unqueue_me(q);
-	kfree(filp->private_data);
+	kfree(q);
 	return 0;
 }
 
@@ -455,14 +532,16 @@
 			       struct poll_table_struct *wait)
 {
 	struct futex_q *q = filp->private_data;
-	struct futex_hash_bucket *bh = hash_futex(&q->key);
 	int ret = 0;
 
 	poll_wait(filp, &q->waiters, wait);
-	spin_lock(&bh->lock);
+
+	/*
+	 * list_empty() is safe here without any lock.
+	 * q->lock_ptr != 0 is not safe, because of ordering against wakeup.
+	 */
 	if (list_empty(&q->list))
 		ret = POLLIN | POLLRDNORM;
-	spin_unlock(&bh->lock);
 
 	return ret;
 }
@@ -472,12 +551,13 @@
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
-	union futex_key key;
 	struct file *filp;
 	int ret, err;
 
@@ -519,20 +599,24 @@
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
+	/*
+	 * queue_me() must be called before releasing mmap_sem, because
+	 * key->shared.inode needs to be referenced while holding it.
+	 */
 	filp->private_data = q;
 
-	queue_me(q, &key, ret, filp);
+	queue_me(q, ret, filp);
+	up_read(&current->mm->mmap_sem);
 
 	/* Now we map fd to filp, so userspace can access it */
 	fd_install(ret, filp);
