Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263577AbTJCH3s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 03:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263579AbTJCH3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 03:29:48 -0400
Received: from dp.samba.org ([66.70.73.150]:23787 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263577AbTJCH3k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 03:29:40 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org
Cc: Hugh Dickins <hugh@veritas.com>, Ulrich Drepper <drepper@redhat.com>,
       Klaus Dittrich <kladit@t-online.de>, Andrew Morton <akpm@zip.com.au>,
       Boris Hu <boris.hu@intel.com>
Subject: Re: [PATCH] For testing/scrutiny: futex locking fix against 2.6.0-test6 
In-reply-to: Your message of "Wed, 01 Oct 2003 06:31:08 +0100."
             <20031001053108.GA1131@mail.shareable.org> 
Date: Fri, 03 Oct 2003 17:28:06 +1000
Message-Id: <20031003072939.C32A92C0F9@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20031001053108.GA1131@mail.shareable.org> you write:
> Patch: futex_refs_and_lock_fix-2.6.0-test6-jl1

Hi Jamie,

	I've been working through your patches separating them (also a
good way of understanding them), and it strikes me that there's a
fundamental problem with the requeue code and the reference counting
fixes.

	The futex_requeue code has to drop all locks to call
drop_key_ref, but that exposes it to races against wake_up.  Not just
the key, but the local "moved" list could be corrupted.  I simply
can't think of a neat way of solving this: it's an independent problem
from whether locks are hashed or not.

BTW, I tried to take the cleanups out of your patches while separating
them, and fixed a requeue bug where you requeue in backwards order (I
don't think it's really important, but...).

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Minor Futex Tweaks
Author: Jamie Lokier <jamie@shareable.org>
Status: Trivial

D: 1) Use list_for_each_entry_safe
D: 2) Overzealous set_task_state() usage in futex_wait: we're under a
D:    spinlock so order doesn't matter.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .7537-linux-2.6.0-test6-bk4/kernel/futex.c .7537-linux-2.6.0-test6-bk4.updated/kernel/futex.c
--- .7537-linux-2.6.0-test6-bk4/kernel/futex.c	2003-09-29 10:26:06.000000000 +1000
+++ .7537-linux-2.6.0-test6-bk4.updated/kernel/futex.c	2003-10-03 16:09:08.000000000 +1000
@@ -221,7 +221,7 @@ static int get_futex_key(unsigned long u
  */
 static int futex_wake(unsigned long uaddr, int num)
 {
-	struct list_head *i, *next, *head;
+	struct futex_q *this, *next;
 	struct futex_hash_bucket *bh;
 	union futex_key key;
 	int ret;
@@ -234,13 +234,10 @@ static int futex_wake(unsigned long uadd
 
 	bh = hash_futex(&key);
 	spin_lock(&bh->lock);
-	head = &bh->chain;
-
-	list_for_each_safe(i, next, head) {
-		struct futex_q *this = list_entry(i, struct futex_q, list);
 
+	list_for_each_entry_safe(this, next, &bh->chain, list) {
 		if (match_futex (&this->key, &key)) {
-			list_del_init(i);
+			list_del_init(&this->list);
 			wake_up_all(&this->waiters);
 			if (this->filp)
 				send_sigio(&this->filp->f_owner, this->fd, POLL_IN);
@@ -403,20 +400,16 @@ static int futex_wait(unsigned long uadd
 	add_wait_queue(&q.waiters, &wait);
 	bh = hash_futex(&key);
 	spin_lock(&bh->lock);
-	set_current_state(TASK_INTERRUPTIBLE);
 
 	if (unlikely(list_empty(&q.list))) {
-		/*
-		 * We were woken already.
-		 */
+		/* We were woken already. */
 		spin_unlock(&bh->lock);
-		set_current_state(TASK_RUNNING);
 		return 0;
 	}
 
+	__set_current_state(TASK_INTERRUPTIBLE);
 	spin_unlock(&bh->lock);
 	time = schedule_timeout(time);
-	set_current_state(TASK_RUNNING);
 
 	/*
 	 * NOTE: we don't remove ourselves from the waitqueue because

Name: FUTEX_REQUEUE simplification
Author: Jamie Lokier <jamie@shareable.org>, Rusty Russell
Status: Booted on 2.6.0-test4-bk9
Depends: Misc/futex-jamie-cleanups1.patch.gz

D: Simplify the logic of FUTEX_REQUEUE.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .32659-linux-2.6.0-test6-bk4/kernel/futex.c .32659-linux-2.6.0-test6-bk4.updated/kernel/futex.c
--- .32659-linux-2.6.0-test6-bk4/kernel/futex.c	2003-10-03 15:47:51.000000000 +1000
+++ .32659-linux-2.6.0-test6-bk4.updated/kernel/futex.c	2003-10-03 16:06:07.000000000 +1000
@@ -261,9 +260,10 @@ out:
 static int futex_requeue(unsigned long uaddr1, unsigned long uaddr2,
 				int nr_wake, int nr_requeue)
 {
-	struct list_head *i, *next, *head1, *head2;
-	struct futex_hash_bucket *bh1, *bh2;
+	struct futex_hash_bucket *bh;
 	union futex_key key1, key2;
+	struct futex_q *this, *next;
+ 	LIST_HEAD(moved);
 	int ret;
 
 	down_read(&current->mm->mmap_sem);
@@ -275,48 +275,33 @@ static int futex_requeue(unsigned long u
 	if (unlikely(ret != 0))
 		goto out;
 
-	bh1 = hash_futex(&key1);
-	bh2 = hash_futex(&key2);
-	if (bh1 < bh2) {
-		spin_lock(&bh1->lock);
-		spin_lock(&bh2->lock);
-	} else {
-		spin_lock(&bh2->lock);
-		if (bh1 > bh2)
-			spin_lock(&bh1->lock);
-	}
-	head1 = &bh1->chain;
-	head2 = &bh2->chain;
-
-	list_for_each_safe(i, next, head1) {
-		struct futex_q *this = list_entry(i, struct futex_q, list);
+	bh = hash_futex(&key1);
+	spin_lock(&bh->lock);
 
+	list_for_each_entry_safe(this, next, &bh->chain, list) {
 		if (match_futex (&this->key, &key1)) {
-			list_del_init(i);
+			list_del_init(&this->list);
 			if (++ret <= nr_wake) {
 				wake_up_all(&this->waiters);
 				if (this->filp)
 					send_sigio(&this->filp->f_owner,
 							this->fd, POLL_IN);
 			} else {
-				list_add_tail(i, head2);
+				list_add_tail(&this->list, &moved);
 				this->key = key2;
 				if (ret - nr_wake >= nr_requeue)
 					break;
-				/* Make sure to stop if key1 == key2 */
-				if (head1 == head2 && head1 != next)
-					head1 = i;
 			}
 		}
 	}
-	if (bh1 < bh2) {
-		spin_unlock(&bh2->lock);
-		spin_unlock(&bh1->lock);
-	} else {
-		if (bh1 > bh2)
-			spin_unlock(&bh1->lock);
-		spin_unlock(&bh2->lock);
-	}
+	spin_unlock(&bh->lock);
+
+	/* Requeue at the end of the new list. */
+	bh = hash_futex(&key2);
+	spin_lock(&bh->lock);
+	list_splice(&moved, bh->chain.prev);
+	spin_unlock(&bh->lock);
+
 out:
 	up_read(&current->mm->mmap_sem);
 	return ret;

Name: Futexes Hold Reference Counts on Page or MM
Author: Jamie Lokier <jamie@shareable.org>, Rusty Russell
Status: Experimental
Depends: Misc/futex-hugh-requeue.patch.gz

D: Variant on Jamie's original patch, where futexes hold a reference count
D: on the page or mm they are in.  This prevents those from being recycled
D: and taking later wakups.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12688-linux-2.6.0-test6-bk4/kernel/futex.c .12688-linux-2.6.0-test6-bk4.updated/kernel/futex.c
--- .12688-linux-2.6.0-test6-bk4/kernel/futex.c	2003-10-03 16:21:47.000000000 +1000
+++ .12688-linux-2.6.0-test6-bk4.updated/kernel/futex.c	2003-10-03 17:07:39.000000000 +1000
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
@@ -172,9 +175,10 @@ static int get_futex_key(unsigned long u
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
@@ -214,6 +218,35 @@ static int get_futex_key(unsigned long u
 	return err;
 }
 
+/*
+ * Take a reference to the resource addressed by a key.
+ *
+ * NOTE: mmap_sem MUST be held between get_futex_key() and calling this
+ * function, if it is called at all.  mmap_sem keeps key->shared.inode valid.
+ */
+static inline void get_key_ref(union futex_key *key)
+{
+	if (key->both.ptr) {
+		if (key->both.offset & 1)
+			atomic_inc(&key->shared.inode->i_count);
+		else
+			atomic_inc(&key->private.mm->mm_count);
+	}
+}
+
+/*
+ * Drop a reference to the resource addressed by a key.
+ * The hash bucket lock must not be held.
+ */
+static inline void drop_key_ref(union futex_key *key)
+{
+	if (key->both.ptr) {
+		if (key->both.offset & 1)
+			iput(key->shared.inode);
+		else
+			mmdrop(key->private.mm);
+	}
+}
 
 /*
  * Wake up all waiters hashed on the physical page that is mapped
@@ -288,7 +321,6 @@ static int futex_requeue(unsigned long u
 							this->fd, POLL_IN);
 			} else {
 				list_add_tail(&this->list, &moved);
-				this->key = key2;
 				if (ret - nr_wake >= nr_requeue)
 					break;
 			}
@@ -296,6 +328,13 @@ static int futex_requeue(unsigned long u
 	}
 	spin_unlock(&bh->lock);
 
+	/* Adjust keys and references. */
+	list_for_each_entry(this, &moved, list) {
+		drop_key_ref(&this->key);
+		this->key = key2;
+		get_key_ref(&this->key);
+	}
+
 	/* Requeue at the end of the new list. */
 	bh = hash_futex(&key2);
 	spin_lock(&bh->lock);
@@ -307,6 +346,7 @@ out:
 	return ret;
 }
 
+/* get_key_ref must have been called on the key. */
 static inline void queue_me(struct futex_q *q, union futex_key *key,
 			    int fd, struct file *filp)
 {
@@ -334,6 +374,7 @@ static inline int unqueue_me(struct fute
 		ret = 1;
 	}
 	spin_unlock(&bh->lock);
+	drop_key_ref(&q->key);
 	return ret;
 }
 
@@ -353,6 +394,7 @@ static int futex_wait(unsigned long uadd
 	if (unlikely(ret != 0))
 		goto out_release_sem;
 
+	get_key_ref(&key);
 	queue_me(&q, &key, -1, NULL);
 
 	/*
@@ -390,6 +432,7 @@ static int futex_wait(unsigned long uadd
 	if (unlikely(list_empty(&q.list))) {
 		/* We were woken already. */
 		spin_unlock(&bh->lock);
+		drop_key_ref(&q.key);
 		return 0;
 	}
 
@@ -499,6 +542,8 @@ static int futex_fd(unsigned long uaddr,
 
 	down_read(&current->mm->mmap_sem);
 	err = get_futex_key(uaddr, &key);
+	if (!err)
+		get_key_ref(&key);
 	up_read(&current->mm->mmap_sem);
 
 	if (unlikely(err != 0)) {
