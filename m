Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262484AbVCVEyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262484AbVCVEyH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 23:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbVCVEwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 23:52:46 -0500
Received: from mail.shareable.org ([81.29.64.88]:10133 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262484AbVCVEqg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 23:46:36 -0500
Date: Tue, 22 Mar 2005 04:46:11 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, mingo@elte.hu,
       Chris Morgan <cmorgan@alum.wpi.edu>, paul@linuxaudiosystems.com,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Subject: Re: kernel bug: futex_wait hang
Message-ID: <20050322044611.GA32432@mail.shareable.org>
References: <1111463950.3058.20.camel@mindpipe> <20050321202051.2796660e.akpm@osdl.org> <1111465520.3058.29.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111465520.3058.29.camel@mindpipe>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> > iirc we ended up deciding that the futex problems around that time were due
> > to userspace problems (a version of libc).  But then, there's no discussion
> > around Seto's patch and it didn't get applied.  So I don't know what
> > happened to that work - it's all a bit mysterious.
> 
> It does seem like it could be a different problem.  Maybe Paul can
> provide some more evidence that it's a kernel and not a glibc/NPTL bug.
> I'm really just posting this on Paul's behalf; I don't claim to
> understand the issue. ;-)

Try applying the patch below, which was recently posted by Jakub Jelinek.

If it fixes the problem, it's the same thing as Hidetoshi Seto
noticed, although this patch is much improved thanks to
"preempt_count technology" (tm).  If not, it's a whole new problem.

-- Jamie

--- linux-2.6.11/kernel/futex.c.jj	2005-03-17 04:42:29.000000000 -0500
+++ linux-2.6.11/kernel/futex.c	2005-03-18 05:45:29.000000000 -0500
@@ -97,7 +97,6 @@ struct futex_q {
  */
 struct futex_hash_bucket {
        spinlock_t              lock;
-       unsigned int	    nqueued;
        struct list_head       chain;
 };
 
@@ -265,7 +264,6 @@ static inline int get_futex_value_locked
 	inc_preempt_count();
 	ret = __copy_from_user_inatomic(dest, from, sizeof(int));
 	dec_preempt_count();
-	preempt_check_resched();
 
 	return ret ? -EFAULT : 0;
 }
@@ -339,7 +337,6 @@ static int futex_requeue(unsigned long u
 	struct list_head *head1;
 	struct futex_q *this, *next;
 	int ret, drop_count = 0;
-	unsigned int nqueued;
 
  retry:
 	down_read(&current->mm->mmap_sem);
@@ -354,23 +351,22 @@ static int futex_requeue(unsigned long u
 	bh1 = hash_futex(&key1);
 	bh2 = hash_futex(&key2);
 
-	nqueued = bh1->nqueued;
+	if (bh1 < bh2)
+		spin_lock(&bh1->lock);
+	spin_lock(&bh2->lock);
+	if (bh1 > bh2)
+		spin_lock(&bh1->lock);
+
 	if (likely(valp != NULL)) {
 		int curval;
 
-		/* In order to avoid doing get_user while
-		   holding bh1->lock and bh2->lock, nqueued
-		   (monotonically increasing field) must be first
-		   read, then *uaddr1 fetched from userland and
-		   after acquiring lock nqueued field compared with
-		   the stored value.  The smp_mb () below
-		   makes sure that bh1->nqueued is read from memory
-		   before *uaddr1.  */
-		smp_mb();
-
 		ret = get_futex_value_locked(&curval, (int __user *)uaddr1);
 
 		if (unlikely(ret)) {
+			spin_unlock(&bh1->lock);
+			if (bh1 != bh2)
+				spin_unlock(&bh2->lock);
+
 			/* If we would have faulted, release mmap_sem, fault
 			 * it in and start all over again.
 			 */
@@ -385,21 +381,10 @@ static int futex_requeue(unsigned long u
 		}
 		if (curval != *valp) {
 			ret = -EAGAIN;
-			goto out;
+			goto out_unlock;
 		}
 	}
 
-	if (bh1 < bh2)
-		spin_lock(&bh1->lock);
-	spin_lock(&bh2->lock);
-	if (bh1 > bh2)
-		spin_lock(&bh1->lock);
-
-	if (unlikely(nqueued != bh1->nqueued && valp != NULL)) {
-		ret = -EAGAIN;
-		goto out_unlock;
-	}
-
 	head1 = &bh1->chain;
 	list_for_each_entry_safe(this, next, head1, list) {
 		if (!match_futex (&this->key, &key1))
@@ -435,13 +420,9 @@ out:
 	return ret;
 }
 
-/*
- * queue_me and unqueue_me must be called as a pair, each
- * exactly once.  They are called with the hashed spinlock held.
- */
-
 /* The key must be already stored in q->key. */
-static void queue_me(struct futex_q *q, int fd, struct file *filp)
+static inline struct futex_hash_bucket *
+queue_lock(struct futex_q *q, int fd, struct file *filp)
 {
 	struct futex_hash_bucket *bh;
 
@@ -455,11 +436,35 @@ static void queue_me(struct futex_q *q, 
 	q->lock_ptr = &bh->lock;
 
 	spin_lock(&bh->lock);
-	bh->nqueued++;
+	return bh;
+}
+
+static inline void __queue_me(struct futex_q *q, struct futex_hash_bucket *bh)
+{
 	list_add_tail(&q->list, &bh->chain);
 	spin_unlock(&bh->lock);
 }
 
+static inline void
+queue_unlock(struct futex_q *q, struct futex_hash_bucket *bh)
+{
+	spin_unlock(&bh->lock);
+	drop_key_refs(&q->key);
+}
+
+/*
+ * queue_me and unqueue_me must be called as a pair, each
+ * exactly once.  They are called with the hashed spinlock held.
+ */
+
+/* The key must be already stored in q->key. */
+static void queue_me(struct futex_q *q, int fd, struct file *filp)
+{
+	struct futex_hash_bucket *bh;
+	bh = queue_lock(q, fd, filp);
+	__queue_me(q, bh);
+}
+
 /* Return 1 if we were still queued (ie. 0 means we were woken) */
 static int unqueue_me(struct futex_q *q)
 {
@@ -503,6 +508,7 @@ static int futex_wait(unsigned long uadd
 	DECLARE_WAITQUEUE(wait, current);
 	int ret, curval;
 	struct futex_q q;
+	struct futex_hash_bucket *bh;
 
  retry:
 	down_read(&current->mm->mmap_sem);
@@ -511,7 +517,7 @@ static int futex_wait(unsigned long uadd
 	if (unlikely(ret != 0))
 		goto out_release_sem;
 
-	queue_me(&q, -1, NULL);
+	bh = queue_lock(&q, -1, NULL);
 
 	/*
 	 * Access the page AFTER the futex is queued.
@@ -537,14 +543,13 @@ static int futex_wait(unsigned long uadd
 	ret = get_futex_value_locked(&curval, (int __user *)uaddr);
 
 	if (unlikely(ret)) {
+		queue_unlock(&q, bh);
+
 		/* If we would have faulted, release mmap_sem, fault it in and
 		 * start all over again.
 		 */
 		up_read(&current->mm->mmap_sem);
 
-		if (!unqueue_me(&q)) /* There's a chance we got woken already */
-			return 0;
-
 		ret = get_user(curval, (int __user *)uaddr);
 
 		if (!ret)
@@ -553,9 +558,13 @@ static int futex_wait(unsigned long uadd
 	}
 	if (curval != val) {
 		ret = -EWOULDBLOCK;
-		goto out_unqueue;
+		queue_unlock(&q, bh);
+		goto out_release_sem;
 	}
 
+	/* Only actually queue if *uaddr contained val.  */
+	__queue_me(&q, bh);
+
 	/*
 	 * Now the futex is queued and we have checked the data, we
 	 * don't want to hold mmap_sem while we sleep.
@@ -596,10 +605,6 @@ static int futex_wait(unsigned long uadd
 	 * have handled it for us already. */
 	return -EINTR;
 
- out_unqueue:
-	/* If we were woken (and unqueued), we succeeded, whatever. */
-	if (!unqueue_me(&q))
-		ret = 0;
  out_release_sem:
 	up_read(&current->mm->mmap_sem);
 	return ret;
