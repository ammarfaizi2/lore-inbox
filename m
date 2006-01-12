Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161268AbWALVCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161268AbWALVCc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 16:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161270AbWALVCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 16:02:32 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:50144 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1161268AbWALVCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 16:02:32 -0500
Subject: [RFC RT] hrtimers with prio
From: Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
Cc: john stultz <johnstul@us.ibm.com>, George Anzinger <george@mvista.com>,
       Daniel Walker <dwalker@mvista.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 12 Jan 2006 16:02:16 -0500
Message-Id: <1137099736.6197.161.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas,

I know you had priorities once with the hrtimers, and then you took them
out.  I was playing a little here with putting them back in.  When a
timer is restarted, I have it store the priority of the process in the
timer, so that, when the hrtimer interrupt goes off, it sets the hrtimer
softirq priority to the priority of the timer.

With this patch, the following program will not lock up when run as
root. Without the patch it will, because the lower priority busy guy
will starve out the highres timer softirq.

http://www.kihontech.com/tests/rt/jitter_sig.c
(run test with -b to make busy loop)

So any thoughts on the below patch?

Daniel, I bet this patch will make that posixtestsuite test 10-1.c work.

-- Steve

This patch goes against 2.6.15-rt4-sr2
http://home.stny.rr.com/rostedt/patches/patch-2.6.15-rt4-sr2


Index: linux-2.6.15-rt4/include/linux/hrtimer.h
===================================================================
--- linux-2.6.15-rt4.orig/include/linux/hrtimer.h	2006-01-11 14:46:30.000000000 -0500
+++ linux-2.6.15-rt4/include/linux/hrtimer.h	2006-01-12 10:23:38.000000000 -0500
@@ -70,6 +70,7 @@
 	struct hrtimer_base	*base;
 #ifdef CONFIG_HIGH_RES_TIMERS
 	struct list_head	list;
+	int			prio;
 #endif
 };
 
Index: linux-2.6.15-rt4/kernel/hrtimer.c
===================================================================
--- linux-2.6.15-rt4.orig/kernel/hrtimer.c	2006-01-11 21:38:17.000000000 -0500
+++ linux-2.6.15-rt4/kernel/hrtimer.c	2006-01-12 15:52:09.000000000 -0500
@@ -218,6 +218,13 @@
 
 static DEFINE_PER_CPU(struct hrtimer_hres, hrtimer_hres);
 
+static DEFINE_PER_CPU(int, hrtimer_prio);
+static DEFINE_PER_CPU(int, hrtimer_policy);
+static DEFINE_PER_CPU(int, hrtimer_curr_prio);
+static DEFINE_PER_CPU(struct task_struct *,hrtimer_thread);
+
+#define set_hrtimer_prio(timer) do { timer->prio = current->rt_priority; } while(0)
+
 /*
  * Shared reprogramming for clock_realtime and clock_monotonic
  *
@@ -387,6 +394,21 @@
 	       smp_processor_id());
 }
 
+static void
+hrtimer_inherit_prio(struct hrtimer *timer, int cpu)
+{
+	struct sched_param sp = { .sched_priority = 0 };
+
+	if (per_cpu(hrtimer_thread, cpu) &&
+	    timer->prio > per_cpu(hrtimer_curr_prio, cpu)) {
+		per_cpu(hrtimer_curr_prio, cpu) = timer->prio;
+		sp.sched_priority = per_cpu(hrtimer_curr_prio, cpu);
+		sched_setscheduler(per_cpu(hrtimer_thread, cpu),
+				   SCHED_FIFO,
+				   &sp);
+	}
+}
+
 /*
  * kick_off_hrtimer - queue the timer to the expire list and
  *                    raise the hrtimer softirq.
@@ -397,6 +419,7 @@
 	list_add_tail(&timer->list, &base->expired);
 	timer->state = HRTIMER_PENDING_CALLBACK;
 	raise_softirq(HRTIMER_SOFTIRQ);
+	hrtimer_inherit_prio(timer, smp_processor_id());
 }
 
 #else /* CONFIG_HIGH_RES_TIMERS */
@@ -405,6 +428,7 @@
 # define hres_enqueue_expired(t,b,n)	0
 # define hrtimer_check_clocks()		do { } while (0)
 # define kick_off_hrtimer		do { } while (0)
+# define set_hrtimer_prio(timer)	do { } while (0)
 
 #endif /* !CONFIG_HIGH_RES_TIMERS */
 
@@ -659,6 +683,8 @@
 
 	base = hrtimer_cancel_and_lock(timer, &flags);
 
+	set_hrtimer_prio(timer);
+
 	/* Switch the timer base, if necessary: */
 	new_base = switch_hrtimer_base(timer, base);
 
@@ -873,6 +899,7 @@
 				list_add_tail(&timer->list, &base->expired);
 				timer->state = HRTIMER_PENDING_CALLBACK;
 				raise = 1;
+				hrtimer_inherit_prio(timer, cpu);
 			}
 		}
 		spin_unlock(&base->lock);
@@ -899,8 +926,11 @@
  * timer have been expired by the high resolution interrupt or have
  * been enqueued into the expired list in the first place.
  */
-static inline void run_hrtimer_hres_queue(struct hrtimer_base *base)
+static inline int run_hrtimer_hres_queue(struct hrtimer_base *base)
 {
+	int cpu = smp_processor_id();
+	int prio = per_cpu(hrtimer_prio, cpu);
+
 	spin_lock_irq(&base->lock);
 
 	while (!list_empty(&base->expired)) {
@@ -929,22 +959,45 @@
 		spin_lock_irq(&base->lock);
 
 		if (restart == HRTIMER_RESTART) {
-			if (enqueue_hrtimer(timer, base))
+			if (enqueue_hrtimer(timer, base)) {
 				kick_off_hrtimer(timer, base);
+				if (prio < timer->prio)
+					prio = timer->prio;
+			}
 		} else
 			timer->state = HRTIMER_EXPIRED;
 		set_curr_timer(base, NULL);
 	}
 	spin_unlock_irq(&base->lock);
+	return prio;
 }
 
 static void run_hrtimer_softirq(struct softirq_action *h)
 {
-	struct hrtimer_base *base = per_cpu(hrtimer_bases, smp_processor_id());
+	struct sched_param sp;
+	int cpu = smp_processor_id();
+	struct hrtimer_base *base = per_cpu(hrtimer_bases, cpu);
+	int curr_prio = per_cpu(hrtimer_prio, cpu);
+	int prio;
 	int i;
 
-	for (i = 0; i < MAX_HRTIMER_BASES; i++)
-		run_hrtimer_hres_queue(&base[i]);
+	if (unlikely(!per_cpu(hrtimer_thread, cpu))) {
+		per_cpu(hrtimer_prio, cpu) = current->rt_priority;
+		per_cpu(hrtimer_policy, cpu) = current->policy;
+		per_cpu(hrtimer_curr_prio, cpu) = per_cpu(hrtimer_prio, cpu);
+		per_cpu(hrtimer_thread, cpu) = current;
+	}
+
+	for (i = 0; i < MAX_HRTIMER_BASES; i++) {
+		prio = run_hrtimer_hres_queue(&base[i]);
+		if (prio > curr_prio)
+			curr_prio = prio;
+	}
+	sp.sched_priority = prio;
+	per_cpu(hrtimer_curr_prio, cpu) = prio;
+	sched_setscheduler(per_cpu(hrtimer_thread, cpu),
+			   per_cpu(hrtimer_policy, cpu),
+			   &sp);
 }
 
 #endif	/* CONFIG_HIGH_RES_TIMERS */




