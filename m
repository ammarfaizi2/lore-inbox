Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289210AbSA1PDr>; Mon, 28 Jan 2002 10:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289211AbSA1PDi>; Mon, 28 Jan 2002 10:03:38 -0500
Received: from mx2.elte.hu ([157.181.151.9]:19395 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S289210AbSA1PDT>;
	Mon, 28 Jan 2002 10:03:19 -0500
Date: Mon, 28 Jan 2002 18:00:52 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [patch] [sched] load-balancer improvements, 2.5.3-pre5
Message-ID: <Pine.LNX.4.33.0201281754050.10067-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch improves the load-balancer with two new details:

- when 'stealing' tasks from another CPU then we should first consider
  tasks at the end of the runqueue - those are the most likely to be
  cache-cold.

- a new 'cache_decay_ticks' value is derived from the already existing
  cacheflush_time value, and this value is used to protect cache-hot tasks
  from being migrated.

for the second change the meaning of sleep_timestamp had to be extended a
bit - in the case of running tasks sleep_timestamp means the time when the
task last left the CPU. The CAN_MIGRATE_TASK() test checks for this
timestamp.

these two changes together improved a test-compilation from 40.5 seconds
to 39.2 seconds, on an 8-way system. (the compilation time is the minimum
time out of multiple compilations.)

NOTE: if HZ=100 is used then low cacheflush times will still be rounded up
to at least 1 tick of cache-hot status, ie. 10 msecs. With HZ=1000 the
cache-hot status is 5 msecs for a 2MB L2 cache Xeon, and 1 msec for 128 KB
L2 cache Celerons.

	Ingo

diff -rNu linux/arch/i386/kernel/smpboot.c linux/arch/i386/kernel/smpboot.c
--- linux/arch/i386/kernel/smpboot.c	Mon Jan 28 15:21:39 2002
+++ linux/arch/i386/kernel/smpboot.c	Mon Jan 28 15:24:44 2002
@@ -924,6 +925,7 @@
 }

 cycles_t cacheflush_time;
+unsigned long cache_decay_ticks;

 static void smp_tune_scheduling (void)
 {
@@ -957,9 +959,13 @@
 		cacheflush_time = (cpu_khz>>10) * (cachesize<<10) / bandwidth;
 	}

+	cache_decay_ticks = (long)cacheflush_time/cpu_khz * HZ / 1000;
+
 	printk("per-CPU timeslice cutoff: %ld.%02ld usecs.\n",
 		(long)cacheflush_time/(cpu_khz/1000),
 		((long)cacheflush_time*100/(cpu_khz/1000)) % 100);
+	printk("task migration cache decay timeout: %ld msecs.\n",
+		(cache_decay_ticks + 1) * 1000 / HZ);
 }

 /*
diff -rNu linux/include/linux/sched.h linux/include/linux/sched.h
--- linux/include/linux/sched.h	Mon Jan 28 15:23:50 2002
+++ linux/include/linux/sched.h	Mon Jan 28 15:24:44 2002
@@ -151,6 +151,8 @@
 extern void scheduler_tick(struct task_struct *p);
 extern void sched_task_migrated(struct task_struct *p);
 extern void smp_migrate_task(int cpu, task_t *task);
+extern unsigned long cache_decay_ticks;
+

 #define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
 extern signed long FASTCALL(schedule_timeout(signed long timeout));
diff -rNu linux/kernel/sched.c linux/kernel/sched.c
--- linux/kernel/sched.c	Mon Jan 28 15:23:50 2002
+++ linux/kernel/sched.c	Mon Jan 28 15:24:44 2002
@@ -460,8 +462,9 @@
 		goto out_unlock;

 	/*
-	 * We first consider expired tasks. Those will likely not run
-	 * in the near future, thus switching CPUs has the least effect
+	 * We first consider expired tasks. Those will likely not be
+	 * executed in the near future, and they are most likely to
+	 * be cache-cold, thus switching CPUs has the least effect
 	 * on them.
 	 */
 	if (busiest->expired->nr_active)
@@ -486,10 +489,23 @@
 	}

 	head = array->queue + idx;
-	curr = head->next;
+	curr = head->prev;
 skip_queue:
 	tmp = list_entry(curr, task_t, run_list);
-	if ((tmp == busiest->curr) || !(tmp->cpus_allowed & (1 << this_cpu))) {
+
+	/*
+	 * We do not migrate tasks that are:
+	 * 1) running (obviously), or
+	 * 2) cannot be migrated to this CPU due to cpus_allowed, or
+	 * 3) are cache-hot on their current CPU.
+	 */
+
+#define CAN_MIGRATE_TASK(p,rq,this_cpu)					\
+	((jiffies - (p)->sleep_timestamp > cache_decay_ticks) &&	\
+		((p) != (rq)->curr) &&					\
+			(tmp->cpus_allowed & (1 << (this_cpu))))
+
+	if (!CAN_MIGRATE_TASK(tmp, busiest, this_cpu)) {
 		curr = curr->next;
 		if (curr != head)
 			goto skip_queue;
@@ -619,21 +641,27 @@
 	spin_lock_irq(&rq->lock);

 	switch (prev->state) {
+	case TASK_RUNNING:
+		prev->sleep_timestamp = jiffies;
+		break;
 	case TASK_INTERRUPTIBLE:
 		if (unlikely(signal_pending(prev))) {
 			prev->state = TASK_RUNNING;
+			prev->sleep_timestamp = jiffies;
 			break;
 		}
 	default:
 		deactivate_task(prev, rq);
-	case TASK_RUNNING:
-		;
 	}
+#if CONFIG_SMP
 pick_next_task:
+#endif
 	if (unlikely(!rq->nr_running)) {
+#if CONFIG_SMP
 		load_balance(rq, 1);
 		if (rq->nr_running)
 			goto pick_next_task;
+#endif
 		next = rq->idle;
 		rq->expired_timestamp = 0;
 		goto switch_tasks;


