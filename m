Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313413AbSDPAEK>; Mon, 15 Apr 2002 20:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313416AbSDPAEJ>; Mon, 15 Apr 2002 20:04:09 -0400
Received: from holomorphy.com ([66.224.33.161]:16525 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S313413AbSDPAEI>;
	Mon, 15 Apr 2002 20:04:08 -0400
Date: Mon, 15 Apr 2002 17:03:23 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: Martin.Bligh@us.ibm.com, pdorwin@us.ibm.com, gone@us.ibm.com,
        rml@tech9.net, mingo@elte.hu
Subject: [PATCH] migration_init() synchronization fixes
Message-ID: <20020416000323.GQ23767@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, Martin.Bligh@us.ibm.com,
	pdorwin@us.ibm.com, gone@us.ibm.com, rml@tech9.net, mingo@elte.hu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch has helped me and some others having migration_init() troubles.
The migration_mask's semantics are altered for use as a lock word, and
some of its other functionality is deferred to a new counter and struct
completion to provide protection against pathological cases encountered
in practice.


Cheers,
Bill



diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Fri Apr 12 04:16:07 2002
+++ b/kernel/sched.c	Fri Apr 12 04:16:07 2002
@@ -1669,7 +1669,16 @@
 	down(&req.sem);
 }
 
+/*
+ * Treat the bits of migration_mask as lock bits.
+ * If the bit corresponding to the cpu a migration_thread is
+ * running on then we have failed to claim our cpu and must
+ * yield in order to find another.
+ */
 static volatile unsigned long migration_mask;
+static atomic_t migration_threads_seeking_cpu;
+static struct completion migration_complete
+			= COMPLETION_INITIALIZER(migration_complete);
 
 static int migration_thread(void * unused)
 {
@@ -1693,26 +1702,54 @@
 	 * task binds itself to the current CPU.
 	 */
 
-	/* wait for all migration threads to start up. */
-	while (!migration_mask)
-		yield();
+	preempt_disable();
 
-	for (;;) {
-		preempt_disable();
-		if (test_and_clear_bit(smp_processor_id(), &migration_mask))
-			current->cpus_allowed = 1 << smp_processor_id();
-		if (test_thread_flag(TIF_NEED_RESCHED))
-			schedule();
-		if (!migration_mask)
-			break;
+	/*
+	 * Enter the loop with preemption disabled so that
+	 * smp_processor_id() remains valid through the check. The
+	 * interior of the wait loop re-enables preemption in an
+	 * attempt to get scheduled off the current cpu. When the
+	 * loop is exited the lock bit in migration_mask is acquired
+	 * and preemption is disabled on the way out. This way the
+	 * cpu acquired remains valid when ->cpus_allowed is set.
+	 */
+	while (test_and_set_bit(smp_processor_id(), &migration_mask)) {
 		preempt_enable();
+		yield();
+		preempt_disable();
 	}
+
+	current->cpus_allowed = 1 << smp_processor_id();
 	rq = this_rq();
 	rq->migration_thread = current;
+
+	/*
+	 * Now that we've bound ourselves to a cpu, post to
+	 * migration_threads_seeking_cpu and wait for everyone else.
+	 * Preemption should remain disabled and the cpu should remain
+	 * in busywait. Yielding the cpu will allow the livelock
+	 * where where a timing pattern causes an idle task seeking a
+	 * migration_thread to always find the unbound migration_thread 
+	 * running on the cpu's it tries to steal tasks from.
+	 */
+	atomic_dec(&migration_threads_seeking_cpu);
+	while (atomic_read(&migration_threads_seeking_cpu))
+		cpu_relax();
+
 	preempt_enable();
 
 	sprintf(current->comm, "migration_CPU%d", smp_processor_id());
 
+	/*
+	 * Everyone's found their cpu, so now wake migration_init().
+	 * Multiple wakeups are harmless; removal from the waitqueue
+	 * has locking built-in, and waking an empty queue is valid.
+	 */
+	complete(&migration_complete);
+
+	/*
+	 * Initiate the event loop.
+	 */
 	for (;;) {
 		runqueue_t *rq_src, *rq_dest;
 		struct list_head *head;
@@ -1760,33 +1797,31 @@
 
 void __init migration_init(void)
 {
-	unsigned long tmp, orig_cache_decay_ticks;
+	unsigned long orig_cache_decay_ticks;
 	int cpu;
 
-	tmp = 0;
-	for (cpu = 0; cpu < smp_num_cpus; cpu++) {
-		if (kernel_thread(migration_thread, NULL,
-				CLONE_FS | CLONE_FILES | CLONE_SIGNAL) < 0)
-			BUG();
-		tmp |= (1UL << cpu_logical_map(cpu));
-	}
+	atomic_set(&migration_threads_seeking_cpu, smp_num_cpus);
 
-	migration_mask = tmp;
+	preempt_disable();
 
 	orig_cache_decay_ticks = cache_decay_ticks;
 	cache_decay_ticks = 0;
 
-	for (cpu = 0; cpu < smp_num_cpus; cpu++) {
-		int logical = cpu_logical_map(cpu);
+	for (cpu = 0; cpu < smp_num_cpus; cpu++)
+		if (kernel_thread(migration_thread, NULL,
+				CLONE_FS | CLONE_FILES | CLONE_SIGNAL) < 0)
+			BUG();
 
-		while (!cpu_rq(logical)->migration_thread) {
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(2);
-		}
-	}
-	if (migration_mask)
-		BUG();
+	/*
+	 * We cannot have missed the wakeup for the migration_thread
+	 * bound for the cpu migration_init() is running on cannot
+	 * acquire this cpu until migration_init() has yielded it by
+	 * means of wait_for_completion().
+	 */
+	wait_for_completion(&migration_complete);
 
 	cache_decay_ticks = orig_cache_decay_ticks;
+
+	preempt_enable();
 }
 #endif
