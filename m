Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261699AbVCRQ7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbVCRQ7A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 11:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbVCRQ7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 11:59:00 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49882 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261699AbVCRQxw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 11:53:52 -0500
Date: Fri, 18 Mar 2005 11:53:26 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, mingo@elte.hu,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au, ahu@ds9a.nl, Ulrich Drepper <drepper@redhat.com>,
       Roland McGrath <roland@redhat.com>, Scott Snyder <snyder@fnal.gov>
Subject: Re: Futex queue_me/get_user ordering
Message-ID: <20050318165326.GB32746@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20041114092308.GA4389@mail.shareable.org> <4197FF42.9070706@jp.fujitsu.com> <20041115020148.GA17979@mail.shareable.org> <41981D4D.9030505@jp.fujitsu.com> <20041115132218.GB25502@mail.shareable.org> <20041117084703.GL10340@devserv.devel.redhat.com> <20041118072058.GA19965@mail.shareable.org> <20041118194726.GX10340@devserv.devel.redhat.com> <20050317102619.GA23494@devserv.devel.redhat.com> <20050317152031.GB16743@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050317152031.GB16743@mail.shareable.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2005 at 03:20:31PM +0000, Jamie Lokier wrote:
> > [numerous instances of...]
> > +	preempt_check_resched();
> 
> Not required.  The spin unlocks will do this.

Here is updated patch with those removed (all of them are preceeded
by spin_unlock) and out_unqueue label and following unused code removed
too.

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


	Jakub
