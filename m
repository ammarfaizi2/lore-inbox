Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262453AbTHZDTo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 23:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262503AbTHZDTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 23:19:44 -0400
Received: from dp.samba.org ([66.70.73.150]:47571 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262453AbTHZDTk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 23:19:40 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: akpm@zip.com.au, mingo@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Futex minor fixes
Date: Tue, 26 Aug 2003 13:05:56 +1000
Message-Id: <20030826031939.F1D762C0FA@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, Ingo,

	This was posted before, but dropped.

Name: Minor futex comment tweaks and cleanups
Author: Rusty Russell
Status: Tested on 2.6.0-test4-bk2

D: Changes:
D: 
D: (1) don't return 0 from futex_wait if we are somehow
D: spuriously woken up, return -EINTR on any such case,
D: 
D: (2) remove bogus comment about address no longer being in this
D: address space: we hold the mm lock, and __pin_page succeeded, so it
D: can't be true, 
D: 
D: (3) remove bogus comment about "get_user might fault and schedule", 
D: 
D: (4) remove list_empty check: we still hold the lock, so it can
D:     never happen.
D: 
D: (5) Single error exit path, and move __queue_me to the end (order
D:     doesn't matter since we're inside the futex lock).

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .6150-linux-2.5.70-bk1/kernel/futex.c .6150-linux-2.5.70-bk1.updated/kernel/futex.c
--- .6150-linux-2.5.70-bk1/kernel/futex.c	2003-05-27 15:02:23.000000000 +1000
+++ .6150-linux-2.5.70-bk1.updated/kernel/futex.c	2003-05-28 16:42:45.000000000 +1000
@@ -312,7 +312,7 @@ static inline int futex_wait(unsigned lo
 		      unsigned long time)
 {
 	DECLARE_WAITQUEUE(wait, current);
-	int ret = 0, curval;
+	int ret, curval;
 	struct page *page;
 	struct futex_q q;
 
@@ -322,55 +322,50 @@ static inline int futex_wait(unsigned lo
 
 	page = __pin_page(uaddr - offset);
 	if (!page) {
-		unlock_futex_mm();
-		return -EFAULT;
+		ret = -EFAULT;
+		goto unlock;
 	}
-	__queue_me(&q, page, uaddr, offset, -1, NULL);
-
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
+
+	/* Were we woken up (and removed from queue)?  Always return
+	 * success when this happens. */
 	if (!unqueue_me(&q))
 		ret = 0;
+	else if (time == 0)
+		ret = -ETIMEDOUT;
+	else
+		ret = -EINTR;
+
 	put_page(q.page);
+	return ret;
 
+unlock:
+	unlock_futex_mm();
 	return ret;
 }
 
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
