Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266948AbSKSQVv>; Tue, 19 Nov 2002 11:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266959AbSKSQVv>; Tue, 19 Nov 2002 11:21:51 -0500
Received: from ophelia.ess.nec.de ([193.141.139.8]:54418 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S266948AbSKSQVl>; Tue, 19 Nov 2002 11:21:41 -0500
From: Erich Focht <efocht@ess.nec.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: [PATCH 2.5.48] NUMA scheduler (2/2)
Date: Tue, 19 Nov 2002 17:27:23 +0100
User-Agent: KMail/1.4.1
Cc: Robert Love <rml@tech9.net>, Anton Blanchard <anton@samba.org>,
       Ingo Molnar <mingo@elte.hu>, Stephen Hemminger <shemminger@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200211061734.42713.efocht@ess.nec.de> <347990000.1037648441@flay> <200211191726.07214.efocht@ess.nec.de>
In-Reply-To: <200211191726.07214.efocht@ess.nec.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_ND0UVHRKWUK6PMQKUYXR"
Message-Id: <200211191727.23308.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_ND0UVHRKWUK6PMQKUYXR
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

And here is the the second patch...

Erich

On Tuesday 19 November 2002 17:26, Erich Focht wrote:
> As requested in another email, I attach the 2.5.48 patches for the
> NUMA scheduler which emerged from Michael's and my work:
>
> 01-numa-sched-core-2.5.48-22.patch: core NUMA scheduler infrastructure
>   providing a node aware load_balancer. Rediffed and fixed one
>   external declaration.
>
> 02-numa-sched-ilb-2.5.48-21.patch: initial load balancing, selects
>   least loaded node & CPU at exec(). Rediffed.
>
> We are curious about any benchmark results and, of course, about runnin=
g
> on other platforms than NUMAQ & Azusa/TX7, too.
>
> Regards,
> Erich
>
> On Monday 18 November 2002 20:40, Martin J. Bligh wrote:
> > BTW, can you keep producing normal patches too, when you do an update=
?
> > I don't use bitkeeper ...

--------------Boundary-00=_ND0UVHRKWUK6PMQKUYXR
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="02-numa-sched-ilb-2.5.48-21.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="02-numa-sched-ilb-2.5.48-21.patch"

diff -Nru a/fs/exec.c b/fs/exec.c
--- a/fs/exec.c	Tue Nov 19 17:09:02 2002
+++ b/fs/exec.c	Tue Nov 19 17:09:02 2002
@@ -1023,6 +1023,8 @@
 	int retval;
 	int i;
 
+	sched_balance_exec();
+
 	file = open_exec(filename);
 
 	retval = PTR_ERR(file);
diff -Nru a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	Tue Nov 19 17:09:02 2002
+++ b/include/linux/sched.h	Tue Nov 19 17:09:02 2002
@@ -159,7 +159,19 @@
 			       unsigned long system, int cpu);
 extern void scheduler_tick(int user_tick, int system);
 extern unsigned long cache_decay_ticks;
-
+#ifdef CONFIG_NUMA
+extern void sched_balance_exec(void);
+extern void node_nr_running_init(void);
+#define nr_running_inc(rq) atomic_inc(rq->node_ptr); \
+	rq->nr_running++
+#define nr_running_dec(rq) atomic_dec(rq->node_ptr); \
+	rq->nr_running--
+#else
+#define sched_balance_exec() {}
+#define node_nr_running_init() {}
+#define nr_running_inc(rq) rq->nr_running++
+#define nr_running_dec(rq) rq->nr_running--
+#endif
 
 #define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
 extern signed long FASTCALL(schedule_timeout(signed long timeout));
diff -Nru a/init/main.c b/init/main.c
--- a/init/main.c	Tue Nov 19 17:09:02 2002
+++ b/init/main.c	Tue Nov 19 17:09:02 2002
@@ -500,6 +500,7 @@
 
 	migration_init();
 #endif
+	node_nr_running_init();
 	spawn_ksoftirqd();
 }
 
diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Tue Nov 19 17:09:02 2002
+++ b/kernel/sched.c	Tue Nov 19 17:09:02 2002
@@ -153,6 +153,7 @@
 	task_t *curr, *idle;
 	prio_array_t *active, *expired, arrays[2];
 	int prev_nr_running[NR_CPUS];
+	atomic_t * node_ptr;
 
 	task_t *migration_thread;
 	struct list_head migration_queue;
@@ -346,7 +347,7 @@
 		p->prio = effective_prio(p);
 	}
 	enqueue_task(p, array);
-	rq->nr_running++;
+	nr_running_inc(rq);
 }
 
 /*
@@ -354,7 +355,7 @@
  */
 static inline void deactivate_task(struct task_struct *p, runqueue_t *rq)
 {
-	rq->nr_running--;
+	nr_running_dec(rq);
 	if (p->state == TASK_UNINTERRUPTIBLE)
 		rq->nr_uninterruptible++;
 	dequeue_task(p, p->array);
@@ -841,9 +842,9 @@
 static inline void pull_task(runqueue_t *src_rq, prio_array_t *src_array, task_t *p, runqueue_t *this_rq, int this_cpu)
 {
 	dequeue_task(p, src_array);
-	src_rq->nr_running--;
+	nr_running_dec(src_rq);
 	set_task_cpu(p, this_cpu);
-	this_rq->nr_running++;
+	nr_running_inc(this_rq);
 	enqueue_task(p, this_rq->active);
 	/*
 	 * Note that idle threads have a prio of MAX_PRIO, for this test
@@ -2253,6 +2254,83 @@
 
 #endif
 
+#if CONFIG_NUMA
+static atomic_t node_nr_running[MAX_NUMNODES] ____cacheline_maxaligned_in_smp = {[0 ...MAX_NUMNODES-1] = ATOMIC_INIT(0)};
+
+__init void node_nr_running_init(void)
+{
+	int i;
+
+	for (i = 0; i < NR_CPUS; i++) {
+		cpu_rq(i)->node_ptr = &node_nr_running[__cpu_to_node(i)];
+	}
+	return;
+}
+
+/*
+ * If dest_cpu is allowed for this process, migrate the task to it.
+ * This is accomplished by forcing the cpu_allowed mask to only
+ * allow dest_cpu, which will force the cpu onto dest_cpu.  Then
+ * the cpu_allowed mask is restored.
+ */
+static void sched_migrate_task(task_t *p, int dest_cpu)
+{
+	unsigned long old_mask;
+
+	old_mask = p->cpus_allowed;
+	if (!(old_mask & (1UL << dest_cpu)))
+		return;
+	/* force the process onto the specified CPU */
+	set_cpus_allowed(p, 1UL << dest_cpu);
+
+	/* restore the cpus allowed mask */
+	set_cpus_allowed(p, old_mask);
+}
+
+/*
+ * Find the least loaded CPU.  Slightly favor the current CPU by
+ * setting its runqueue length as the minimum to start.
+ */
+static int sched_best_cpu(struct task_struct *p)
+{
+	int i, minload, load, best_cpu, node = 0;
+
+	best_cpu = task_cpu(p);
+	if (cpu_rq(best_cpu)->nr_running <= 2)
+		return best_cpu;
+
+	minload = 10000000;
+	for (i = 0; i < numnodes; i++) {
+		load = atomic_read(&node_nr_running[i]);
+		if (load < minload) {
+			minload = load;
+			node = i;
+		}
+	}
+	minload = 10000000;
+	loop_over_node(i,node) {
+		if (!cpu_online(i))
+			continue;
+		if (cpu_rq(i)->nr_running < minload) {
+			best_cpu = i;
+			minload = cpu_rq(i)->nr_running;
+		}
+	}
+	return best_cpu;
+}
+
+void sched_balance_exec(void)
+{
+	int new_cpu;
+
+	if (numnodes > 1) {
+		new_cpu = sched_best_cpu(current);
+		if (new_cpu != smp_processor_id())
+			sched_migrate_task(current, new_cpu);
+	}
+}
+#endif /* CONFIG_NUMA */
+
 #if CONFIG_SMP || CONFIG_PREEMPT
 /*
  * The 'big kernel lock'
@@ -2314,6 +2392,10 @@
 		spin_lock_init(&rq->lock);
 		INIT_LIST_HEAD(&rq->migration_queue);
 		atomic_set(&rq->nr_iowait, 0);
+#if CONFIG_NUMA
+		rq->node_ptr = &node_nr_running[0];
+#endif /* CONFIG_NUMA */
+
 
 		for (j = 0; j < 2; j++) {
 			array = rq->arrays + j;

--------------Boundary-00=_ND0UVHRKWUK6PMQKUYXR--

