Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317847AbSGVSTY>; Mon, 22 Jul 2002 14:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317848AbSGVSTY>; Mon, 22 Jul 2002 14:19:24 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:61947 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317847AbSGVSTX>; Mon, 22 Jul 2002 14:19:23 -0400
Subject: Re: [PATCH] low-latency zap_page_range
From: Robert Love <rml@tech9.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@zip.com.au>, riel@conectiva.com.br,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <Pine.LNX.4.44.0207221103430.2928-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0207221103430.2928-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 22 Jul 2002 11:22:25 -0700
Message-Id: <1027362145.932.49.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-22 at 11:05, Linus Torvalds wrote:

> How about adding an "cond_resched_lock()" primitive?
> 
> You can do it better as a primitive than as the written-out thing (the
> spin_unlock() doesn't need to conditionally test the scheduling point
> again, it can just unconditionally call schedule())
> 
> And there might be other places that want to drop a lock before scheduling
> anyway.

Great idea.  I have similar functions in my lock-break patch...

This introduces "cond_resched_lock()" and "break_spin_lock()".  Both
take a lock has a parameter.  The former only drops the locks and
reschedules if need_resched is set.  It is optimized to only check once,
etc.  The later simply unlocks then relocks.

Patch is against your BK tree.

	Robert Love

diff -urN linux-2.5.27/include/linux/sched.h linux/include/linux/sched.h
--- linux-2.5.27/include/linux/sched.h	Sat Jul 20 12:11:07 2002
+++ linux/include/linux/sched.h	Mon Jul 22 11:16:55 2002
@@ -865,6 +867,30 @@
 		__cond_resched();
 }
 
+/*
+ * cond_resched_lock() - if a reschedule is pending, drop the given lock,
+ * call schedule, and on return reacquire the lock.  Note this assumes
+ * the given lock is the _only_ held lock and otherwise you are not atomic.
+ */
+static inline void cond_resched_lock(spinlock_t * lock)
+{
+	if (need_resched()) {
+		spin_unlock_no_resched(lock);
+		__cond_resched();
+		spin_lock(lock);
+	}
+}
+
+/*
+ * break_spin_lock - drop and immeditately reacquire the given lock.  This
+ * creates a preemption point if it is the only held lock.
+ */
+static inline void break_spin_lock(spinlock_t * lock)
+{
+	spin_unlock(lock);
+	spin_lock(lock);
+}
+
 /* Reevaluate whether the task has signals pending delivery.
    This is required every time the blocked sigset_t changes.
    Athread cathreaders should have t->sigmask_lock.  */

