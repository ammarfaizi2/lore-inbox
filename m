Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbTIQFTL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 01:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262468AbTIQFTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 01:19:11 -0400
Received: from dp.samba.org ([66.70.73.150]:34201 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262070AbTIQFSz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 01:18:55 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jamie Lokier <jamie@shareable.org>
Cc: "Hu, Boris" <boris.hu@intel.com>, linux-kernel@vger.kernel.org,
       Ulrich Drepper <drepper@redhat.com>, akpm@zip.com.au
Subject: Re: [PATCH] Split futex global spinlock futex_lock 
In-reply-to: Your message of "Tue, 16 Sep 2003 12:04:19 +0100."
             <20030916110419.GB26576@mail.jlokier.co.uk> 
Date: Wed, 17 Sep 2003 11:55:43 +1000
Message-Id: <20030917051855.2D23A2C2F0@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030916110419.GB26576@mail.jlokier.co.uk> you write:
> Therefore, if cache line transfer between CPUs is a bottleneck, it
> makes more sense to increase FUTEX_HASHBITS than to increase the
> alignment of each bucket.

Clear thinking as usual.  One request: could you please make a really
stupid mistake to make me feel better? 8)

So I think take Boris' original patch, but just drop the
"__cacheline_aligned_in_smp" bit.

Below is that patch again, with the hashing change patch following
(Uli, if you're feeling bored, benchmarks on the hash change would be
interesting).

When Linus comes back I'll send them both, unless there are
complaints.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Split futex global spinlock futex_lock
Author: "Hu, Boris" <boris.hu@intel.com>
Status: Booted on 2.6.0-test5-bk3

D: Simple change to split the futex lock into a per-hashchain lock.
D: Don't bother cacheline aligning: Jamie points out that increasing
D: FUTEX_HASHBITS would have more payoff.
D:
D: Ulrich Drepper reports 6% improvement in on a 4way futex-thrashing
D: benchmark.

--- bk-linux-2.6/kernel/futex.c	2003-09-10 13:16:54.000000000 +0800
+++ bk-linux-2.6.dev/kernel/futex.c	2003-09-11 14:57:08.000000000
+0800
@@ -79,9 +79,16 @@
 	struct file *filp;
 };
 
+/*
+ * Split the global futex_lock into every hash list lock.
+ */
+struct futex_hash_bucket {
+       spinlock_t              lock;
+       struct list_head       chain;
+};
+
 /* The key for the hash is the address + index + offset within page */
-static struct list_head futex_queues[1<<FUTEX_HASHBITS];
-static spinlock_t futex_lock = SPIN_LOCK_UNLOCKED;
+static struct futex_hash_bucket futex_queues[1<<FUTEX_HASHBITS];
 
 /* Futex-fs vfsmount entry: */
 static struct vfsmount *futex_mnt;
@@ -89,7 +97,7 @@
 /*
  * We hash on the keys returned from get_futex_key (see below).
  */
-static inline struct list_head *hash_futex(union futex_key *key)
+static inline struct futex_hash_bucket *hash_futex(union futex_key *key)
 {
 	return &futex_queues[hash_long(key->both.word
 				       + (unsigned long) key->both.ptr
@@ -214,6 +222,7 @@
 static int futex_wake(unsigned long uaddr, int num)
 {
 	struct list_head *i, *next, *head;
+	struct futex_hash_bucket *bh;
 	union futex_key key;
 	int ret;
 
@@ -223,9 +232,10 @@
 	if (unlikely(ret != 0))
 		goto out;
 
-	head = hash_futex(&key);
+	bh = hash_futex(&key);
+	spin_lock(&bh->lock);
+	head = &bh->chain;
 
-	spin_lock(&futex_lock);
 	list_for_each_safe(i, next, head) {
 		struct futex_q *this = list_entry(i, struct futex_q, list);
 
@@ -239,7 +249,7 @@
 				break;
 		}
 	}
-	spin_unlock(&futex_lock);
+	spin_unlock(&bh->lock);
 
 out:
 	up_read(&current->mm->mmap_sem);
@@ -254,6 +264,7 @@
 				int nr_wake, int nr_requeue)
 {
 	struct list_head *i, *next, *head1, *head2;
+	struct futex_hash_bucket *bh1, *bh2;
 	union futex_key key1, key2;
 	int ret;
 
@@ -266,10 +277,19 @@
 	if (unlikely(ret != 0))
 		goto out;
 
-	head1 = hash_futex(&key1);
-	head2 = hash_futex(&key2);
+	bh1 = hash_futex(&key1);
+	bh2 = hash_futex(&key2);
+	if (bh1 < bh2) {
+		spin_lock(&bh1->lock);
+		spin_lock(&bh2->lock);
+	} else {
+		spin_lock(&bh2->lock);
+		if (bh1 > bh2)
+			spin_lock(&bh1->lock);
+	}
+	head1 = &bh1->chain;
+	head2 = &bh2->chain;
 
-	spin_lock(&futex_lock);
 	list_for_each_safe(i, next, head1) {
 		struct futex_q *this = list_entry(i, struct futex_q, list);
 
@@ -291,8 +311,14 @@
 			}
 		}
 	}
-	spin_unlock(&futex_lock);
-
+	if (bh1 < bh2) {
+		spin_unlock(&bh2->lock);
+		spin_unlock(&bh1->lock);
+	} else {
+		if (bh1 > bh2)
+			spin_unlock(&bh1->lock);
+		spin_unlock(&bh2->lock);
+	}
 out:
 	up_read(&current->mm->mmap_sem);
 	return ret;
@@ -301,28 +327,30 @@
 static inline void queue_me(struct futex_q *q, union futex_key *key,
 			    int fd, struct file *filp)
 {
-	struct list_head *head = hash_futex(key);
+	struct futex_hash_bucket *bh = hash_futex(key);
+	struct list_head *head = &bh->chain;
 
 	q->key = *key;
 	q->fd = fd;
 	q->filp = filp;
 
-	spin_lock(&futex_lock);
+	spin_lock(&bh->lock);
 	list_add_tail(&q->list, head);
-	spin_unlock(&futex_lock);
+	spin_unlock(&bh->lock);
 }
 
 /* Return 1 if we were still queued (ie. 0 means we were woken) */
 static inline int unqueue_me(struct futex_q *q)
 {
+	struct futex_hash_bucket *bh = hash_futex(&q->key);
 	int ret = 0;
 
-	spin_lock(&futex_lock);
+	spin_lock(&bh->lock);
 	if (!list_empty(&q->list)) {
 		list_del(&q->list);
 		ret = 1;
 	}
-	spin_unlock(&futex_lock);
+	spin_unlock(&bh->lock);
 	return ret;
 }
 
@@ -332,6 +360,7 @@
 	int ret, curval;
 	union futex_key key;
 	struct futex_q q;
+	struct futex_hash_bucket *bh = NULL;
 
  try_again:
 	init_waitqueue_head(&q.waiters);
@@ -373,19 +402,20 @@
 	 * the waiter from the list.
 	 */
 	add_wait_queue(&q.waiters, &wait);
-	spin_lock(&futex_lock);
+	bh = hash_futex(&key);
+	spin_lock(&bh->lock);
 	set_current_state(TASK_INTERRUPTIBLE);
 
 	if (unlikely(list_empty(&q.list))) {
 		/*
 		 * We were woken already.
 		 */
-		spin_unlock(&futex_lock);
+		spin_unlock(&bh->lock);
 		set_current_state(TASK_RUNNING);
 		return 0;
 	}
 
-	spin_unlock(&futex_lock);
+	spin_unlock(&bh->lock);
 	time = schedule_timeout(time);
 	set_current_state(TASK_RUNNING);
 
@@ -435,13 +465,14 @@
 			       struct poll_table_struct *wait)
 {
 	struct futex_q *q = filp->private_data;
+	struct futex_hash_bucket *bh = hash_futex(&q->key);
 	int ret = 0;
 
 	poll_wait(filp, &q->waiters, wait);
-	spin_lock(&futex_lock);
+	spin_lock(&bh->lock);
 	if (list_empty(&q->list))
 		ret = POLLIN | POLLRDNORM;
-	spin_unlock(&futex_lock);
+	spin_unlock(&bh->lock);
 
 	return ret;
 }
@@ -587,8 +618,10 @@
 	register_filesystem(&futex_fs_type);
 	futex_mnt = kern_mount(&futex_fs_type);
 
-	for (i = 0; i < ARRAY_SIZE(futex_queues); i++)
-		INIT_LIST_HEAD(&futex_queues[i]);
+	for (i = 0; i < ARRAY_SIZE(futex_queues); i++) {
+		INIT_LIST_HEAD(&futex_queues[i].chain);
+		futex_queues[i].lock = SPIN_LOCK_UNLOCKED;
+	}
 	return 0;
 }
 __initcall(init);



Name: Minor Tweaks To Jamie Lokier & Hugh Dickins's Futex Patch
Author: Rusty Russell
Status: Booted on 2.6.0-test5-bk3
Depends: Misc/futex-split-lock.patch.gz

D: Minor changes to Jamie & Hugh's excellent futex patch.
D: 1) Remove obsolete comment above hash array decl.
D: 2) Clarify comment about TASK_INTERRUPTIBLE.
D: 3) Andrew Morton says spurious wakeup is a bug.  Catch it.
D: 4) Use Jenkins hash.
D: 5) Make hash function non-inline.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31053-linux-2.6.0-test5-bk3/kernel/futex.c .31053-linux-2.6.0-test5-bk3.updated/kernel/futex.c
--- .31053-linux-2.6.0-test5-bk3/kernel/futex.c	2003-09-17 10:27:05.000000000 +1000
+++ .31053-linux-2.6.0-test5-bk3.updated/kernel/futex.c	2003-09-17 10:28:20.000000000 +1000
@@ -33,7 +33,7 @@
 #include <linux/poll.h>
 #include <linux/fs.h>
 #include <linux/file.h>
-#include <linux/hash.h>
+#include <linux/jhash.h>
 #include <linux/init.h>
 #include <linux/futex.h>
 #include <linux/mount.h>
@@ -44,6 +44,7 @@
 /*
  * Futexes are matched on equal values of this key.
  * The key type depends on whether it's a shared or private mapping.
+ * Don't rearrange members without looking at hash_futex().
  */
 union futex_key {
 	struct {
@@ -87,7 +88,6 @@ struct futex_hash_bucket {
        struct list_head       chain;
 };
 
-/* The key for the hash is the address + index + offset within page */
 static struct futex_hash_bucket futex_queues[1<<FUTEX_HASHBITS];
 
 /* Futex-fs vfsmount entry: */
@@ -96,11 +96,12 @@ static struct vfsmount *futex_mnt;
 /*
  * We hash on the keys returned from get_futex_key (see below).
  */
-static inline struct futex_hash_bucket *hash_futex(union futex_key *key)
+static struct futex_hash_bucket *hash_futex(union futex_key *key)
 {
-	return &futex_queues[hash_long(key->both.word
-				       + (unsigned long) key->both.ptr
-				       + key->both.offset, FUTEX_HASHBITS)];
+	u32 hash = jhash2((u32*)&key->both.word,
+			  (sizeof(key->both.word)+sizeof(key->both.ptr))/4,
+			  key->both.offset);
+	return &futex_queues[hash & ((1 << FUTEX_HASHBITS)-1)];
 }
 
 /*
@@ -361,7 +362,6 @@ static int futex_wait(unsigned long uadd
 	struct futex_q q;
 	struct futex_hash_bucket *bh = NULL;
 
- try_again:
 	init_waitqueue_head(&q.waiters);
 
 	down_read(&current->mm->mmap_sem);
@@ -395,10 +395,10 @@ static int futex_wait(unsigned long uadd
 	/*
 	 * There might have been scheduling since the queue_me(), as we
 	 * cannot hold a spinlock across the get_user() in case it
-	 * faults.  So we cannot just set TASK_INTERRUPTIBLE state when
+	 * faults, and we cannot just set TASK_INTERRUPTIBLE state when
 	 * queueing ourselves into the futex hash.  This code thus has to
-	 * rely on the futex_wake() code doing a wakeup after removing
-	 * the waiter from the list.
+	 * rely on the futex_wake() code removing us from hash when it
+	 * wakes us up.
 	 */
 	add_wait_queue(&q.waiters, &wait);
 	bh = hash_futex(&key);
@@ -423,26 +423,17 @@ static int futex_wait(unsigned long uadd
 	 * we are the only user of it.
 	 */
 
-	/*
-	 * Were we woken or interrupted for a valid reason?
-	 */
-	ret = unqueue_me(&q);
-	if (ret == 0)
+	/* If we were woken (and unqueued), we succeeded, whatever. */
+	if (!unqueue_me(&q))
 		return 0;
 	if (time == 0)
 		return -ETIMEDOUT;
-	if (signal_pending(current))
-		return -EINTR;
-
-	/*
-	 * No, it was a spurious wakeup.  Try again.  Should never happen. :)
-	 */
-	goto try_again;
+	/* A spurious wakeup should never happen. */
+	WARN_ON(!signal_pending(current));
+	return -EINTR;
 
  out_unqueue:
-	/*
-	 * Were we unqueued anyway?
-	 */
+	/* If we were woken (and unqueued), we succeeded, whatever. */
 	if (!unqueue_me(&q))
 		ret = 0;
  out_release_sem:
