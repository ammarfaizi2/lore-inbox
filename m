Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314232AbSDSBvP>; Thu, 18 Apr 2002 21:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314233AbSDSBvO>; Thu, 18 Apr 2002 21:51:14 -0400
Received: from artemis.rus.uni-stuttgart.de ([129.69.1.28]:27870 "EHLO
	artemis.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S314232AbSDSBvN>; Thu, 18 Apr 2002 21:51:13 -0400
Date: Fri, 19 Apr 2002 03:51:29 +0200 (CEST)
From: Erich Focht <focht@ess.nec.de>
X-X-Sender: focht@beast.local
To: William Lee Irwin III <wli@holomorphy.com>
cc: Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>,
        Kimio Suganuma <k-suganuma@mvj.biglobe.ne.jp>,
        <torvalds@transmeta.com>
Subject: Re: [PATCH] migration thread fix
In-Reply-To: <20020418232753.GP23767@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0204190201570.3004-100000@beast.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bill,

> It does keep the original philosophy, and it's not too complicated:
[...]
>
> It's really a very conservative algorithm.

thanks for the explanations. Usually I'm also conservative with changes.

I'm currently working on a node affine scheduler extension for NUMA
machines and the load balancer behaves a bit different from the original.
So after a few boot failures with those slowly booting 16 CPU IA64
machines I thought there must be a simpler solution than synchronizing and
waiting for the load balancer: just let migration_CPU0 do what it is
designed for. So my proposal is:
   - start all migration threads on CPU#0
   - initialize migration_CPU0 (trivial, reliable, as it already is on
     the right CPU)
   - let all other migration threads use set_cpus_allowed() to get to the
     right place

The only synchronization needed is the non-zero migration threads waiting
for migration_CPU0 to start working, which it will, as it is already on
the right CPU. This saves quite some lines of code.

I first posted this to LKML on March 6th (BTW, the fix #1, too) and since
then it was tested on several big NUMA platforms: 16 CPU NEC AzusA (IA64)
(also known as HP rx....), up to 32 CPU SGI IA64, 16 CPU IBM NUMA-Q
(IA32). No more lock-ups at boot since then. So I consider it working.

There is another good reason for this approach: the integration of the CPU
hotplug patch with the new scheduler becomes easier. One just needs to
create the new migration thread, it will move itself to the right CPU
without any additional magic (which you otherwise need because of the
synchronizations which won't be there at hotplug). Kimi Suganuma in the
neighboring cube is fiddling this out currently.


> yourself. The side issues are non-issues to me; I just want kernels that
> do a little more than hang at boot so I can hack on other parts of it.
> I'll get around to testing it soon, but it's kind of a pain, because
> failed attempts didn't fail every time, and the machines where it fails
> are not swift to boot... though I imagine you're in a similar position
> wrt. testing being a hassle. =)

:-) I know exactly what you mean...

Best regards,
Erich

PS: attached is the patch against Linus' latest kernel. This patch is only
for the migration_init change (#2), the fix for problem #1 is in the patch
sent by Robert, it has to be applied before.


--- 2.5.8-EF/kernel/sched.c.orig	Fri Apr 19 03:45:13 2002
+++ 2.5.8-EF/kernel/sched.c	Fri Apr 19 03:43:48 2002
@@ -1672,10 +1672,9 @@
 	preempt_enable();
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
@@ -1683,36 +1682,20 @@
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

@@ -1766,33 +1749,18 @@

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



