Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276468AbRJYWAs>; Thu, 25 Oct 2001 18:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276470AbRJYWAi>; Thu, 25 Oct 2001 18:00:38 -0400
Received: from [208.129.208.52] ([208.129.208.52]:55310 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S276468AbRJYWA3>;
	Thu, 25 Oct 2001 18:00:29 -0400
Date: Thu, 25 Oct 2001 15:07:57 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] CPU history scheduler patch for 2.4.13 ...
Message-ID: <Pine.LNX.4.40.0110251454540.1027-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The previous patch i sent contain an error in the cpu accounting formula.
This is an update for 2.4.13.
You can try this by using the latency sampler patch together with
the  schedcnt  and  cpuhog  tools that you can find here :

http://www.xmailserver.org/linux-patches/lnxsched.html

If you run the test with 2 cpu hog processes over an UP system and you
move the mouse during the test you'll find that with the current scheduler
the two cpu hog processes are swapped after the mouse irq processing.
A more correct behavior is obtained using this patch.



- Davide




diff -Nru linux-2.4.13.vanilla/include/linux/sched.h linux-2.4.13.mcsched/include/linux/sched.h
--- linux-2.4.13.vanilla/include/linux/sched.h	Tue Oct 23 21:59:06 2001
+++ linux-2.4.13.mcsched/include/linux/sched.h	Thu Oct 25 14:42:50 2001
@@ -393,12 +393,14 @@
 	int (*notifier)(void *priv);
 	void *notifier_data;
 	sigset_t *notifier_mask;
-
+
 /* Thread group tracking */
    	u32 parent_exec_id;
    	u32 self_exec_id;
 /* Protection of (de-)allocation: mm, files, fs, tty */
 	spinlock_t alloc_lock;
+/* a better place for these brothers must be found */
+	unsigned long cpu_jtime, sched_jtime;
 };

 /*
@@ -485,7 +487,8 @@
     sig:		&init_signals,					\
     pending:		{ NULL, &tsk.pending.head, {{0}}},		\
     blocked:		{{0}},						\
-    alloc_lock:		SPIN_LOCK_UNLOCKED				\
+    alloc_lock:		SPIN_LOCK_UNLOCKED,				\
+	cpu_jtime:		0 \
 }


@@ -808,7 +811,7 @@
 	current->state = TASK_RUNNING;					\
 	remove_wait_queue(&wq, &__wait);				\
 } while (0)
-
+
 #define wait_event_interruptible(wq, condition)				\
 ({									\
 	int __ret = 0;							\
diff -Nru linux-2.4.13.vanilla/kernel/fork.c linux-2.4.13.mcsched/kernel/fork.c
--- linux-2.4.13.vanilla/kernel/fork.c	Tue Oct 23 17:44:15 2001
+++ linux-2.4.13.mcsched/kernel/fork.c	Thu Oct 25 14:42:50 2001
@@ -687,6 +687,9 @@
 	if (!current->counter)
 		current->need_resched = 1;

+	p->cpu_jtime = 0;
+	p->sched_jtime = jiffies;
+
 	/*
 	 * Ok, add it to the run-queues and make it
 	 * visible to the rest of the system.
diff -Nru linux-2.4.13.vanilla/kernel/sched.c linux-2.4.13.mcsched/kernel/sched.c
--- linux-2.4.13.vanilla/kernel/sched.c	Wed Oct 17 14:14:37 2001
+++ linux-2.4.13.mcsched/kernel/sched.c	Thu Oct 25 14:45:55 2001
@@ -167,13 +167,25 @@
 		weight = p->counter;
 		if (!weight)
 			goto out;
-
+
 #ifdef CONFIG_SMP
 		/* Give a largish advantage to the same processor...   */
 		/* (this is equivalent to penalizing other processors) */
-		if (p->processor == this_cpu)
+		if (p->processor == this_cpu) {
 			weight += PROC_CHANGE_PENALTY;
-#endif
+			/* add advantage related to the history of this task on this cpu
+			 * this try to account the cache footprint of p in this_cpu
+			 */
+			if (p->cpu_jtime > jiffies)
+				weight += p->cpu_jtime - jiffies;
+		}
+#else	/* #ifdef CONFIG_SMP */
+		/* add advantage related to the history of this task on this cpu
+		 * this try to account the cache footprint of p in this_cpu
+		 */
+		if (p->cpu_jtime > jiffies)
+			weight += p->cpu_jtime - jiffies;
+#endif	/* #ifdef CONFIG_SMP */

 		/* .. and a slight advantage to the current MM */
 		if (p->mm == this_mm || !p->mm)
@@ -382,7 +394,7 @@
  * delivered to the current task. In this case the remaining time
  * in jiffies will be returned, or 0 if the timer expired in time
  *
- * The current task state is guaranteed to be TASK_RUNNING when this
+ * The current task state is guaranteed to be TASK_RUNNING when this
  * routine returns.
  *
  * Specifying a @timeout value of %MAX_SCHEDULE_TIMEOUT will schedule
@@ -574,7 +586,13 @@
 		case TASK_RUNNING:;
 	}
 	prev->need_resched = 0;
-
+	/* we certainly do not want to do this onto the idle task */
+	if (prev != idle_task(this_cpu)) {
+		/* this save the cpu time that has not been consumed by the previous preemption */
+		prev->cpu_jtime = prev->cpu_jtime > prev->sched_jtime ? prev->cpu_jtime - prev->sched_jtime: 0;
+		/* recalculate the cpu time */
+		prev->cpu_jtime += (jiffies - prev->sched_jtime) + jiffies;
+	}
 	/*
 	 * this is the scheduler proper:
 	 */
@@ -611,6 +629,7 @@
  	next->has_cpu = 1;
 	next->processor = this_cpu;
 #endif
+	next->sched_jtime = jiffies;
 	spin_unlock_irq(&runqueue_lock);

 	if (prev == next) {
@@ -1322,6 +1341,8 @@
 			smp_processor_id(), current->pid);
 		del_from_runqueue(current);
 	}
+	current->cpu_jtime = 0;
+	current->sched_jtime = jiffies;
 	sched_data->curr = current;
 	sched_data->last_schedule = get_cycles();
 	clear_bit(current->processor, &wait_init_idle);

