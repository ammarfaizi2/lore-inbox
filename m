Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293457AbSCFKdL>; Wed, 6 Mar 2002 05:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293462AbSCFKdC>; Wed, 6 Mar 2002 05:33:02 -0500
Received: from artemis.rus.uni-stuttgart.de ([129.69.1.28]:14255 "EHLO
	artemis.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S293457AbSCFKct>; Wed, 6 Mar 2002 05:32:49 -0500
Date: Wed, 6 Mar 2002 11:32:46 +0100 (MET)
From: Erich Focht <efocht@ess.nec.de>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] scheduler: migration tasks startup
Message-ID: <Pine.LNX.4.21.0203061123270.2743-100000@sx6.ess.nec.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

we encountered problems with the initial distribution of the
migration_tasks across the CPUs. Machines with 16 and more CPUs
sometimes won't boot. Here is a fix which works reliably:
- all migration_tasks are started on CPU#0,
- migration_task #0 is used to migrate the others to their destination,
- synchronization with migration_mask isn't needed any more.

Thanks,
best regards,
Erich


diff -urN 2.5.6-pre1-fix/kernel/sched.c 2.5.6-pre1-fix2/kernel/sched.c
--- 2.5.6-pre1-fix/kernel/sched.c	Thu Feb 28 19:14:29 2002
+++ 2.5.6-pre1-fix2/kernel/sched.c	Wed Mar  6 11:28:59 2002
@@ -1557,8 +1557,9 @@
 
 static volatile unsigned long migration_mask;
 
-static int migration_thread(void * unused)
+static int migration_thread(void * bind_cpu)
 {
+	int cpu = cpu_logical_map((int) (long) bind_cpu);
 	struct sched_param param = { sched_priority: 99 };
 	runqueue_t *rq;
 	int ret;
@@ -1566,33 +1567,19 @@
 	daemonize();
 	sigfillset(&current->blocked);
 	set_fs(KERNEL_DS);
-	ret = setscheduler(0, SCHED_FIFO, &param);
 
 	/*
-	 * We have to migrate manually - there is no migration thread
-	 * to do this for us yet :-)
-	 *
-	 * We use the following property of the Linux scheduler. At
-	 * this point no other task is running, so by keeping all
-	 * migration threads running, the load-balancer will distribute
-	 * them between all CPUs equally. At that point every migration
-	 * task binds itself to the current CPU.
+	 * The first migration task is started on CPU #0. This one can migrate
+	 * the tasks to their destination CPUs.
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
 	preempt_enable();
@@ -1651,17 +1638,15 @@
 {
 	int cpu;
 
+	current->cpus_allowed = 1UL << cpu_logical_map(0);
 	for (cpu = 0; cpu < smp_num_cpus; cpu++)
-		if (kernel_thread(migration_thread, NULL,
+		if (kernel_thread(migration_thread, (void *) (long) cpu,
 				CLONE_FS | CLONE_FILES | CLONE_SIGNAL) < 0)
 			BUG();
-
-	migration_mask = (1 << smp_num_cpus) - 1;
+	current->cpus_allowed = -1L;
 
 	for (cpu = 0; cpu < smp_num_cpus; cpu++)
 		while (!cpu_rq(cpu)->migration_thread)
 			schedule_timeout(2);
-	if (migration_mask)
-		BUG();
 }
 #endif


