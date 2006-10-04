Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161910AbWJDRiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161910AbWJDRiv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 13:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161922AbWJDRir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 13:38:47 -0400
Received: from www.osadl.org ([213.239.205.134]:26597 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1161910AbWJDRiA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 13:38:00 -0400
Message-Id: <20061004172223.235279000@cruncher.tec.linutronix.de>
References: <20061004172217.092570000@cruncher.tec.linutronix.de>
Date: Wed, 04 Oct 2006 17:31:42 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       John Stultz <johnstul@us.ibm.com>,
       Valdis Kletnieks <valdis.kletnieks@vt.edu>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>,
       David Woodhouse <dwmw2@infradead.org>, Jim Gettys <jg@laptop.org>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: [patch 12/22] hrtimers: clean up callback tracking
Content-Disposition: inline; filename=hrtimers-clean-up-callback-tracking.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Reintroduce ktimers feature "optimized away" by the ktimers review process:
remove the curr_timer pointer from the cpu-base and use the hrtimer state.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
 include/linux/hrtimer.h |    1 -
 kernel/hrtimer.c        |   10 +---------
 2 files changed, 1 insertion(+), 10 deletions(-)

Index: linux-2.6.18-mm3/include/linux/hrtimer.h
===================================================================
--- linux-2.6.18-mm3.orig/include/linux/hrtimer.h	2006-10-04 18:13:56.000000000 +0200
+++ linux-2.6.18-mm3/include/linux/hrtimer.h	2006-10-04 18:13:56.000000000 +0200
@@ -136,7 +136,6 @@ struct hrtimer_cpu_base {
 	spinlock_t			lock;
 	struct lock_class_key		lock_key;
 	struct hrtimer_clock_base	clock_base[HRTIMER_MAX_CLOCK_BASES];
-	struct hrtimer			*curr_timer;
 };
 
 /*
Index: linux-2.6.18-mm3/kernel/hrtimer.c
===================================================================
--- linux-2.6.18-mm3.orig/kernel/hrtimer.c	2006-10-04 18:13:56.000000000 +0200
+++ linux-2.6.18-mm3/kernel/hrtimer.c	2006-10-04 18:13:56.000000000 +0200
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

