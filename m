Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263038AbVCQLaf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263038AbVCQLaf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 06:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263037AbVCQLaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 06:30:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50848 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263038AbVCQK0x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 05:26:53 -0500
Date: Thu, 17 Mar 2005 05:26:22 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, mingo@elte.hu,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au, ahu@ds9a.nl, Ulrich Drepper <drepper@redhat.com>,
       Roland McGrath <roland@redhat.com>
Subject: Re: Futex queue_me/get_user ordering
Message-ID: <20050317102619.GA23494@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20041114090023.GA478@mail.shareable.org> <20041114010943.3d56985a.akpm@osdl.org> <20041114092308.GA4389@mail.shareable.org> <4197FF42.9070706@jp.fujitsu.com> <20041115020148.GA17979@mail.shareable.org> <41981D4D.9030505@jp.fujitsu.com> <20041115132218.GB25502@mail.shareable.org> <20041117084703.GL10340@devserv.devel.redhat.com> <20041118072058.GA19965@mail.shareable.org> <20041118194726.GX10340@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041118194726.GX10340@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 02:47:26PM -0500, Jakub Jelinek wrote:
> The scenario described in futex_wait-fix.patch IMHO can happen even
> if all calls to pthread_cond_signal are done with mutex held around it, i.e.
> A		B		X		Y
> pthread_mutex_lock (&mtx);
> pthread_cond_wait (&cv, &mtx);
>   - mtx release *)
>   total++ [1/0/0] (0) {}
> 				pthread_mutex_lock (&mtx);
> 				pthread_cond_signal (&cv);
> 				  - wake++ [1/1/0] (1) {}
> 				  FUTEX_WAKE, 1 (returns, nothing is queued)
> 				pthread_mutex_unlock (&mtx);
> 		pthread_mutex_lock (&mtx);
> 		pthread_cond_wait (&cv, &mtx);
> 		  - mtx release *)
> 		  total++ [2/1/0] (1) {}
>   FUTEX_WAIT, 0
>   queue_me [2/1/0] (1) {A}
>   0 != 1
> 		FUTEX_WAIT, 1
> 		queue_me [2/1/0] (1) {A,B}
> 		1 == 1
> 						pthread_mutex_lock (&mtx);
> 						pthread_cond_signal (&cv);
> 						  - wake++ [2/2/0] (2) {A,B}
> 						  FUTEX_WAKE, 1 (unqueues incorrectly A)
> 						  [2/2/0] (2) {B}
> 						pthread_mutex_unlock (&mtx);
>   try to dequeue but already dequeued
>   would normally return EWOULDBLOCK here
>   but as unqueue_me failed, returns 0
>   woken++ [2/2/1] (2) {B}
> 		schedule_timeout (forever)
>   - mtx reacquire
>   pthread_cond_wait returns
> pthread_mutex_unlock (&mtx);
> 
> 		-------------------
> 		the code would like to say pthread_mutex_unlock (&mtx);
> 		and pthread_exit here, but never reaches there.
...

http://www.ussg.iu.edu/hypermail/linux/kernel/0411.2/0953.html

Your argument in November was that you don't want to slow down the
kernel and that userland must be able to cope with the
non-atomicity of futex syscall.

But with the recent changes to futex.c I think kernel can ensure
atomicity for free.

With get_futex_value_locked doing the user access in_atomic () and
repeating if that failed, I think it would be just a matter of
something as in the patch below (totally untested though).
It would simplify requeue implementation (getting rid of the nqueued
field), as well as never enqueue a futex in futex_wait until
the *uaddr == val uaccess check has shown it should be enqueued.
And I don't think the kernel will be any slower because of that,
in the common case where get_futex_value_locked does not cause
a mm fault (userland typically accessed that memory a few cycles before
the syscall), the futex_wait change is just about doing first half of
queue_me before the user access and second half after it.

--- linux-2.6.11/kernel/futex.c.jj	2005-03-17 04:42:29.000000000 -0500
+++ linux-2.6.11/kernel/futex.c	2005-03-17 05:13:45.000000000 -0500
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
@@ -354,23 +351,24 @@ static int futex_requeue(unsigned long u
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
+			preempt_check_resched();
+
 			/* If we would have faulted, release mmap_sem, fault
 			 * it in and start all over again.
 			 */
@@ -385,21 +383,10 @@ static int futex_requeue(unsigned long u
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
@@ -435,13 +422,9 @@ out:
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
 
@@ -455,11 +438,35 @@ static void queue_me(struct futex_q *q, 
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
@@ -503,6 +510,7 @@ static int futex_wait(unsigned long uadd
 	DECLARE_WAITQUEUE(wait, current);
 	int ret, curval;
 	struct futex_q q;
+	struct futex_hash_bucket *bh;
 
  retry:
 	down_read(&current->mm->mmap_sem);
@@ -511,7 +519,7 @@ static int futex_wait(unsigned long uadd
 	if (unlikely(ret != 0))
 		goto out_release_sem;
 
-	queue_me(&q, -1, NULL);
+	bh = queue_lock(&q, -1, NULL);
 
 	/*
 	 * Access the page AFTER the futex is queued.
@@ -537,14 +545,15 @@ static int futex_wait(unsigned long uadd
 	ret = get_futex_value_locked(&curval, (int __user *)uaddr);
 
 	if (unlikely(ret)) {
+		queue_unlock(&q, bh);
+
+		preempt_check_resched();
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
@@ -553,9 +562,15 @@ static int futex_wait(unsigned long uadd
 	}
 	if (curval != val) {
 		ret = -EWOULDBLOCK;
-		goto out_unqueue;
+		queue_unlock(&q, bh);
+		preempt_check_resched();
+		goto out_release_sem;
 	}
 
+	/* Only actually queue if *uaddr contained val.  */
+	__queue_me(&q, bh);
+	preempt_check_resched();
+
 	/*
 	 * Now the futex is queued and we have checked the data, we
 	 * don't want to hold mmap_sem while we sleep.


	Jakub
