Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262432AbTJCGZu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 02:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263338AbTJCGZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 02:25:50 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:54407 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262432AbTJCGZp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 02:25:45 -0400
Date: Fri, 3 Oct 2003 07:24:08 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, hugh@veritas.com, rusty@rustcorp.com.au,
       drepper@redhat.com, kladit@t-online.de, akpm@zip.com.au,
       boris.hu@intel.com, wli@holomorphy.com
Subject: Re: [PATCH] fix to futex locking fix
Message-ID: <20031003062408.GD15691@mail.shareable.org>
References: <20031003051918.GA15691@mail.shareable.org> <20031002230344.2a0ff989.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031002230344.2a0ff989.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jamie Lokier <jamie@shareable.org> wrote:
> > Patch: futex_lock_fix2-2.6.0-test6
> >  Depends on: futex_refs_and_lock_fix-2.6.0-test6
> 
> I'm all confused.  Your email appeared to contain two copies of the same
> patch, neither of whcih apply to anything I have.

Bugger, bitten by NFS non-cache-coherence.

Here it is again, ONCE!

It applies on top of 2.6.0-test6 + futex_refs_and_lock_fix-2.6.0-test6.

It might not apply on top of your tree because you have another futex
patch in your tree as well (uninlining?), which I have not got.

-- Jamie


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

