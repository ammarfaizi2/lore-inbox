Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263075AbTH0FS6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 01:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbTH0FS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 01:18:58 -0400
Received: from dp.samba.org ([66.70.73.150]:34996 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263075AbTH0FSx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 01:18:53 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: alexander.riesen@synopsys.COM
Cc: akpm@zip.com.au, mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Futex minor fixes 
In-reply-to: Your message of "Tue, 26 Aug 2003 11:26:31 +0200."
             <20030826092631.GN16080@Synopsys.COM> 
Date: Wed, 27 Aug 2003 12:40:14 +1000
Message-Id: <20030827051853.1E6422C0EA@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030826092631.GN16080@Synopsys.COM> you write:
> Rusty Russell, Tue, Aug 26, 2003 05:05:56 +0200:
> > Hi Andrew, Ingo,
> > 
> > 	This was posted before, but dropped.
> > 
> > Name: Minor futex comment tweaks and cleanups
> > Author: Rusty Russell
> > Status: Tested on 2.6.0-test4-bk2
> > 
> > D: Changes:
> > D: 
> > D: (1) don't return 0 from futex_wait if we are somehow
> > D: spuriously woken up, return -EINTR on any such case,
> 
> Here. EINTR is often (if not always) assumed to be caused by a signal.
> And someone may rightfully depend on it being that way.

Yes.  Changed code to loop in this case.  I don't know of anyone who
actually randomly wakes processes, but just in case.  Returning "0"
always means as "you were woken up by someone using FUTEX_WAKE", and
some callers *need to know*.

How's this?

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Minor futex comment tweaks and cleanups
Author: Rusty Russell
Status: Tested on 2.6.0-test4-bk2

D: Changes:
D: 
D: (1) don't return 0 from futex_wait if we are somehow
D:     spuriously woken up, loop in that case.
D: 
D: (2) remove bogus comment about address no longer being in this
D:     address space: we hold the mm lock, and __pin_page succeeded, so it
D:     can't be true, 
D: 
D: (3) remove bogus comment about "get_user might fault and schedule", 
D: 
D: (4) clarify comment about hashing: we hash address of struct page,
D:     not page itself,
D: 
D: (4) remove list_empty check: we still hold the lock, so it can
D:     never happen, and
D: 
D: (5) single error exit path, and move __queue_me to the end (order
D:     doesn't matter since we're inside the futex lock).

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .9416-linux-2.6.0-test4-bk2/kernel/futex.c .9416-linux-2.6.0-test4-bk2.updated/kernel/futex.c
--- .9416-linux-2.6.0-test4-bk2/kernel/futex.c	2003-05-27 15:02:23.000000000 +1000
+++ .9416-linux-2.6.0-test4-bk2.updated/kernel/futex.c	2003-08-27 12:34:53.000000000 +1000
@@ -84,9 +84,7 @@ static inline void unlock_futex_mm(void)
 	spin_unlock(&current->mm->page_table_lock);
 }
 
-/*
- * The physical page is shared, so we can hash on its address:
- */
+/* The struct page is shared, so we can hash on its address. */
 static inline struct list_head *hash_futex(struct page *page, int offset)
 {
 	return &futex_queues[hash_long((unsigned long)page + offset,
@@ -311,67 +309,68 @@ static inline int futex_wait(unsigned lo
 		      int val,
 		      unsigned long time)
 {
-	DECLARE_WAITQUEUE(wait, current);
-	int ret = 0, curval;
+	wait_queue_t wait;
+	int ret, curval;
 	struct page *page;
 	struct futex_q q;
 
+again:
 	init_waitqueue_head(&q.waiters);
+	init_waitqueue_entry(wait, current);
 
 	lock_futex_mm();
 
 	page = __pin_page(uaddr - offset);
 	if (!page) {
-		unlock_futex_mm();
-		return -EFAULT;
+		ret = -EFAULT;
+		goto unlock;
 	}
-	__queue_me(&q, page, uaddr, offset, -1, NULL);
 
 	/*
-	 * Page is pinned, but may no longer be in this address space.
+	 * Page is pinned, but may be a kernel address.
 	 * It cannot schedule, so we access it with the spinlock held.
 	 */
 	if (get_user(curval, (int *)uaddr) != 0) {
-		unlock_futex_mm();
 		ret = -EFAULT;
-		goto out;
+		goto unlock;
 	}
+
 	if (curval != val) {
-		unlock_futex_mm();
 		ret = -EWOULDBLOCK;
-		goto out;
+		goto unlock;
 	}
-	/*
-	 * The get_user() above might fault and schedule so we
-	 * cannot just set TASK_INTERRUPTIBLE state when queueing
-	 * ourselves into the futex hash. This code thus has to
-	 * rely on the futex_wake() code doing a wakeup after removing
-	 * the waiter from the list.
-	 */
+
+	__queue_me(&q, page, uaddr, offset, -1, NULL);
 	add_wait_queue(&q.waiters, &wait);
 	set_current_state(TASK_INTERRUPTIBLE);
-	if (!list_empty(&q.list)) {
-		unlock_futex_mm();
-		time = schedule_timeout(time);
-	}
+	unlock_futex_mm();
+
+	time = schedule_timeout(time);
+
 	set_current_state(TASK_RUNNING);
 	/*
 	 * NOTE: we don't remove ourselves from the waitqueue because
 	 * we are the only user of it.
 	 */
-	if (time == 0) {
-		ret = -ETIMEDOUT;
-		goto out;
-	}
-	if (signal_pending(current))
-		ret = -EINTR;
-out:
-	/* Were we woken up anyway? */
+	put_page(q.page);
+
+	/* Were we woken up (and removed from queue)?  Always return
+	 * success when this happens. */
 	if (!unqueue_me(&q))
 		ret = 0;
-	put_page(q.page);
+	else if (time == 0)
+		ret = -ETIMEDOUT;
+	else if (signal_pending(current))
+		ret = -EINTR;
+	else
+		/* Spurious wakeup somehow.  Loop. */
+		goto again;
 
 	return ret;
+
+unlock:
+	unlock_futex_mm();
+	return ret;
 }
 
 static int futex_close(struct inode *inode, struct file *filp)
