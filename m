Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261817AbVCRREB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbVCRREB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 12:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbVCRREB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 12:04:01 -0500
Received: from mx2.elte.hu ([157.181.151.9]:36317 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261969AbVCRRAn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 12:00:43 -0500
Date: Fri, 18 Mar 2005 18:00:06 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Jamie Lokier <jamie@shareable.org>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au, ahu@ds9a.nl, Ulrich Drepper <drepper@redhat.com>,
       Roland McGrath <roland@redhat.com>, Scott Snyder <snyder@fnal.gov>
Subject: Re: Futex queue_me/get_user ordering
Message-ID: <20050318170005.GA27077@elte.hu>
References: <4197FF42.9070706@jp.fujitsu.com> <20041115020148.GA17979@mail.shareable.org> <41981D4D.9030505@jp.fujitsu.com> <20041115132218.GB25502@mail.shareable.org> <20041117084703.GL10340@devserv.devel.redhat.com> <20041118072058.GA19965@mail.shareable.org> <20041118194726.GX10340@devserv.devel.redhat.com> <20050317102619.GA23494@devserv.devel.redhat.com> <20050317152031.GB16743@mail.shareable.org> <20050317155539.GF853@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050317155539.GF853@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jakub Jelinek <jakub@redhat.com> wrote:

> The futex man pages that have been around for years (certainly since
> mid 2002) certainly don't document FUTEX_WAIT as token passing
> operation, but as atomic operation:
> 
> Say http://www.icewalkers.com/Linux/ManPages/futex-2.html

besides this documented-behavior argument, i dont think futexes should
be degraded into waitqueues - in fact, to solve some of the known
performance problems the opposite will have to happen: e.g. i believe
that in the future we'll need to enable the kernel-side futex code to
actually modify the futex variable. I.e. atomicity of the read in
FUTEX_WAIT is an absolute must, and is only the first step.

[ the double-context-switch problem in cond_signal() that Jamie
  mentioned is precisely one such case: pthread semantics force us that
  the wakeup of the wakee _must_ happen while still holding the internal
  lock. So we cannot just delay the wakeup to outside the glibc critical
  section. This double context-switch could be avoided if the 'release
  internal lock and wake up wakee' operation could be done atomically
  within the kernel. (A sane default 'userspace unlock' operation on a
  machine word could be defined .. e.g. decrement-to-zero.) ]

so i'm very much in favor of your patch - it fixes a real bug and is
also the right step forward. We'll need more locking code in the kernel
to remove fundamental limitations of userspace (such as no ability to
control preemption), not less.

i've tested your latest patch (from today) on x86 and it boots/works
fine with Fedora userspace, where futexes do get utilized, and ran a few
tests as well.

(Andrew - might make sense to include in the next -mm so that we get
some feel of stability, while the conceptual discussion continues?)

	Ingo

--

this patch makes FUTEX_WAIT atomic again.

Signed-off-by: Jakub Jelinek <jakub@redhat.com>
Acked-by: Ingo Molnar <mingo@elte.hu>

--- linux/kernel/futex.c.orig
+++ linux/kernel/futex.c
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
