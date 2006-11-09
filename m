Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161835AbWKIXjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161835AbWKIXjF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 18:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161826AbWKIXjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 18:39:05 -0500
Received: from www.osadl.org ([213.239.205.134]:49820 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1161835AbWKIXjC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 18:39:02 -0500
Message-Id: <20061109233034.296218000@cruncher.tec.linutronix.de>
References: <20061109233030.915859000@cruncher.tec.linutronix.de>
Date: Thu, 09 Nov 2006 23:38:19 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Len Brown <lenb@kernel.org>, John Stultz <johnstul@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: [patch 02/19] hrtimers: clean up callback tracking
Content-Disposition: inline; filename=hrtimers-clean-up-callback-tracking.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Reintroduce ktimers feature "optimized away" by the ktimers review process:
remove the curr_timer pointer from the cpu-base and use the hrtimer state.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

Index: linux-2.6.19-rc5-mm1/include/linux/hrtimer.h
===================================================================
--- linux-2.6.19-rc5-mm1.orig/include/linux/hrtimer.h	2006-11-09 21:06:07.000000000 +0100
+++ linux-2.6.19-rc5-mm1/include/linux/hrtimer.h	2006-11-09 21:06:09.000000000 +0100
@@ -136,7 +136,6 @@ struct hrtimer_cpu_base {
 	spinlock_t			lock;
 	struct lock_class_key		lock_key;
 	struct hrtimer_clock_base	clock_base[HRTIMER_MAX_CLOCK_BASES];
-	struct hrtimer			*curr_timer;
 };
 
 /*
Index: linux-2.6.19-rc5-mm1/kernel/hrtimer.c
===================================================================
--- linux-2.6.19-rc5-mm1.orig/kernel/hrtimer.c	2006-11-09 21:06:07.000000000 +0100
+++ linux-2.6.19-rc5-mm1/kernel/hrtimer.c	2006-11-09 21:06:09.000000000 +0100
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
@@ -654,7 +650,6 @@ static inline void run_hrtimer_queue(str
 			break;
 
 		fn = timer->function;
-		set_curr_timer(cpu_base, timer);
 		__remove_hrtimer(timer, base, HRTIMER_STATE_CALLBACK);
 		spin_unlock_irq(&cpu_base->lock);
 
@@ -668,7 +663,6 @@ static inline void run_hrtimer_queue(str
 			enqueue_hrtimer(timer, base);
 		}
 	}
-	set_curr_timer(cpu_base, NULL);
 	spin_unlock_irq(&cpu_base->lock);
 }
 
@@ -855,8 +849,6 @@ static void migrate_hrtimers(int cpu)
 	spin_lock(&old_base->lock);
 
 	for (i = 0; i < HRTIMER_MAX_CLOCK_BASES; i++) {
-		BUG_ON(old_base->curr_timer);
-
 		migrate_hrtimer_list(&old_base->clock_base[i],
 				     &new_base->clock_base[i]);
 	}

--

