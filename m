Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314446AbSDRUIi>; Thu, 18 Apr 2002 16:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314447AbSDRUIh>; Thu, 18 Apr 2002 16:08:37 -0400
Received: from artemis.rus.uni-stuttgart.de ([129.69.1.28]:21146 "EHLO
	artemis.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S314446AbSDRUIf>; Thu, 18 Apr 2002 16:08:35 -0400
Date: Thu, 18 Apr 2002 22:08:55 +0200 (CEST)
From: Erich Focht <efocht@ess.nec.de>
X-X-Sender: focht@beast.local
To: linux-kernel@vger.kernel.org
cc: Ingo Molnar <mingo@elte.hu>, <torvalds@transmeta.com>
Subject: [PATCH] migration thread fix
Message-ID: <Pine.LNX.4.44.0204182043110.2453-100000@beast.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below applies to the 2.5.8 kernel. It does two things:

1: Fixes a BUG in the migration threads: the interrupts MUST be disabled
before the double runqueue lock is aquired, otherwise this thing will
deadlock sometimes.

2: Streamlines the initialization of migration threads. Instead of
fiddling around with cache_deccay_ticks, waiting for migration_mask bits
and relying on the scheduler to distribute the tasks uniformly among
processors, it starts the migration thread on the boot cpu and uses it to
reliably distribute the other threads to their target cpus.

Please consider applying it!

Thanks,
Erich

diff -urN 2.5.8-ia64/kernel/sched.c 2.5.8-ia64-ef/kernel/sched.c
--- 2.5.8-ia64/kernel/sched.c	Wed Apr 17 23:39:00 2002
+++ 2.5.8-ia64-ef/kernel/sched.c	Thu Apr 18 20:00:49 2002
@@ -1669,10 +1669,9 @@
 	down(&req.sem);
 }

-static volatile unsigned long migration_mask;
-
-static int migration_thread(void * unused)
+static int migration_thread(void * bind_cpu)
 {
+	int cpu = cpu_logical_map((int) (long) bind_cpu);
 	struct sched_param param = { sched_priority: 99 };
 	runqueue_t *rq;
 	int ret;
@@ -1680,36 +1679,20 @@
 	daemonize();
 	sigfillset(&current->blocked);
 	set_fs(KERNEL_DS);
-	ret = setscheduler(0, SCHED_FIFO, &param);
-
 	/*
-	 * We have to migrate manually - there is no migration thread
-	 * to do this for us yet :-)
-	 *
-	 * We use the following property of the Linux scheduler. At
-	 * this point no other task is running, so by keeping all
-	 * migration threads running, the load-balancer will distribute
-	 * them between all CPUs equally. At that point every migration
-	 * task binds itself to the current CPU.
+	 * The first migration thread is started on CPU #0. This one can migrate
+	 * the other migration threads to their destination CPUs.
 	 */
-
-	/* wait for all migration threads to start up. */
-	while (!migration_mask)
-		yield();
-
-	for (;;) {
-		preempt_disable();
-		if (test_and_clear_bit(smp_processor_id(), &migration_mask))
-			current->cpus_allowed = 1 << smp_processor_id();
-		if (test_thread_flag(TIF_NEED_RESCHED))
-			schedule();
-		if (!migration_mask)
-			break;
-		preempt_enable();
+	if (cpu != 0) {
+		while (!cpu_rq(cpu_logical_map(0))->migration_thread)
+			yield();
+		set_cpus_allowed(current, 1UL << cpu);
 	}
+	printk("migration_task %d on cpu=%d\n",cpu,smp_processor_id());
+	ret = setscheduler(0, SCHED_FIFO, &param);
+
 	rq = this_rq();
 	rq->migration_thread = current;
-	preempt_enable();

 	sprintf(current->comm, "migration_CPU%d", smp_processor_id());

@@ -1740,6 +1723,7 @@
 		cpu_src = p->thread_info->cpu;
 		rq_src = cpu_rq(cpu_src);

+		local_irq_save(flags);
 		double_rq_lock(rq_src, rq_dest);
 		if (p->thread_info->cpu != cpu_src) {
 			double_rq_unlock(rq_src, rq_dest);
@@ -1753,6 +1737,7 @@
 			}
 		}
 		double_rq_unlock(rq_src, rq_dest);
+		local_irq_restore(flags);

 		up(&req->sem);
 	}
@@ -1760,33 +1745,18 @@

 void __init migration_init(void)
 {
-	unsigned long tmp, orig_cache_decay_ticks;
 	int cpu;

-	tmp = 0;
+	current->cpus_allowed = 1UL << cpu_logical_map(0);
 	for (cpu = 0; cpu < smp_num_cpus; cpu++) {
-		if (kernel_thread(migration_thread, NULL,
+		if (kernel_thread(migration_thread, (void *) (long) cpu,
 				CLONE_FS | CLONE_FILES | CLONE_SIGNAL) < 0)
 			BUG();
-		tmp |= (1UL << cpu_logical_map(cpu));
 	}
+	current->cpus_allowed = -1L;

-	migration_mask = tmp;
-
-	orig_cache_decay_ticks = cache_decay_ticks;
-	cache_decay_ticks = 0;
-
-	for (cpu = 0; cpu < smp_num_cpus; cpu++) {
-		int logical = cpu_logical_map(cpu);
-
-		while (!cpu_rq(logical)->migration_thread) {
-			set_current_state(TASK_INTERRUPTIBLE);
+	for (cpu = 0; cpu < smp_num_cpus; cpu++)
+		while (!cpu_rq(cpu)->migration_thread)
 			schedule_timeout(2);
-		}
-	}
-	if (migration_mask)
-		BUG();
-
-	cache_decay_ticks = orig_cache_decay_ticks;
 }
 #endif

