Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932470AbWJAXIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470AbWJAXIK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 19:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbWJAXH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 19:07:56 -0400
Received: from www.osadl.org ([213.239.205.134]:11699 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932471AbWJAXGw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 19:06:52 -0400
Message-Id: <20061001225724.405122000@cruncher.tec.linutronix.de>
References: <20061001225720.115967000@cruncher.tec.linutronix.de>
Date: Sun, 01 Oct 2006 23:00:59 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: [patch 12/21] hrtimers: clean up callback tracking
Content-Disposition: inline; filename=hrtimer-change-callback-tracking.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

reintroduce ktimers feature "optimized away" by the ktimers
review process: remove the curr_timer pointer from the cpu-base
and use the hrtimer state.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
--
 include/linux/hrtimer.h |    1 -
 kernel/hrtimer.c        |   10 +---------
 2 files changed, 1 insertion(+), 10 deletions(-)

Index: linux-2.6.18-mm2/include/linux/hrtimer.h
===================================================================
--- linux-2.6.18-mm2.orig/include/linux/hrtimer.h	2006-10-02 00:55:52.000000000 +0200
+++ linux-2.6.18-mm2/include/linux/hrtimer.h	2006-10-02 00:55:53.000000000 +0200
@@ -136,7 +136,6 @@ struct hrtimer_cpu_base {
 	spinlock_t			lock;
 	struct lock_class_key		lock_key;
 	struct hrtimer_clock_base	clock_base[HRTIMER_MAX_CLOCK_BASES];
-	struct hrtimer			*curr_timer;
 };
 
 /*
Index: linux-2.6.18-mm2/kernel/hrtimer.c
===================================================================
--- linux-2.6.18-mm2.orig/kernel/hrtimer.c	2006-10-02 00:55:52.000000000 +0200
+++ linux-2.6.18-mm2/kernel/hrtimer.c	2006-10-02 00:55:53.000000000 +0200
@@ -150,8 +150,6 @@ static void hrtimer_get_softirq_time(str
  */
 #ifdef CONFIG_SMP
 
-#define set_curr_timer(b, t)		do { (b)->curr_timer = (t); } while (0)
-
 /*
  * We are using hashed locking: holding per_cpu(hrtimer_bases)[n].lock
  * means that all timers which are tied to this base via timer->base are
@@ -205,7 +203,7 @@ switch_hrtimer_base(struct hrtimer *time
 		 * completed. There is no conflict as we hold the lock until
 		 * the timer is enqueued.
 		 */
-		if (unlikely(base->cpu_base->curr_timer == timer))
+		if (unlikely(timer->state & HRTIMER_STATE_CALLBACK))
 			return base;
 
 		/* See the comment in lock_timer_base() */
@@ -219,8 +217,6 @@ switch_hrtimer_base(struct hrtimer *time
 
 #else /* CONFIG_SMP */
 
-#define set_curr_timer(b, t)		do { } while (0)
-
 static inline struct hrtimer_clock_base *
 lock_hrtimer_base(const struct hrtimer *timer, unsigned long *flags)
 {
@@ -648,7 +644,6 @@ static inline void run_hrtimer_queue(str
 			break;
 
 		fn = timer->function;
-		set_curr_timer(cpu_base, timer);
 		__remove_hrtimer(timer, base, HRTIMER_STATE_CALLBACK);
 		spin_unlock_irq(&cpu_base->lock);
 
@@ -662,7 +657,6 @@ static inline void run_hrtimer_queue(str
 			enqueue_hrtimer(timer, base);
 		}
 	}
-	set_curr_timer(cpu_base, NULL);
 	spin_unlock_irq(&cpu_base->lock);
 }
 
@@ -849,8 +843,6 @@ static void migrate_hrtimers(int cpu)
 	spin_lock(&old_base->lock);
 
 	for (i = 0; i < HRTIMER_MAX_CLOCK_BASES; i++) {
-		BUG_ON(old_base->curr_timer);
-
 		migrate_hrtimer_list(&old_base->clock_base[i],
 				     &new_base->clock_base[i]);
 	}

--

