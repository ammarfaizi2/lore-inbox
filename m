Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265470AbSJaX3W>; Thu, 31 Oct 2002 18:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265483AbSJaX3W>; Thu, 31 Oct 2002 18:29:22 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:63680 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265470AbSJaX3Q>; Thu, 31 Oct 2002 18:29:16 -0500
Subject: Re: [PATCH 2.5.45] NUMA Scheduler  (2/2)
From: Michael Hohnbaum <hohnbaum@us.ibm.com>
To: Michael Hohnbaum <hohnbaum@us.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, Erich Focht <efocht@ess.nec.de>
In-Reply-To: <1036107098.21647.104.camel@dyn9-47-17-164.beaverton.ibm.com>
References: <1036107098.21647.104.camel@dyn9-47-17-164.beaverton.ibm.com>
Content-Type: multipart/mixed; boundary="=-+VxA2DmJvSZRZ4Ps/yjR"
X-Mailer: Ximian Evolution 1.0.8 
Date: 31 Oct 2002 15:33:01 -0800
Message-Id: <1036107182.21701.107.camel@dyn9-47-17-164.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+VxA2DmJvSZRZ4Ps/yjR
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2002-10-31 at 15:31, Michael Hohnbaum wrote:
> Linus,
> 
> Erich Focht has written scheduler extensions in support of
> NUMA systems.  These extensions are being used at customer
> sites.  I have branched off and done some similar NUMA scheduler
> extensions, though on a much smaller scale.  We have combined
> efforts and produced two patches which provide minimal NUMA
> scheduler capabilities.
> 
> The first patch provides node awareness to the load balancer.
> This is derived directly from Erich's Node aware NUMA scheduler.
> The second patch adds load balancing at exec.  This is derived
> from work that I have done.  Together, these patches provide
> performance gains for kernel compilation of between 5 and 10%.
> On memory bandwidth extensive microbenchmarks we have seen gains
> of 50-100%.  
> 
> Please consider for inclusion in 2.5.
> 

Here is the second patch.
-- 

Michael Hohnbaum                      503-578-5486
hohnbaum@us.ibm.com                   T/L 775-5486

--=-+VxA2DmJvSZRZ4Ps/yjR
Content-Disposition: attachment; filename=03-numa_sched_ilbMH-2.5.43-20.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=03-numa_sched_ilbMH-2.5.43-20.patch;
	charset=ISO-8859-1

diff -urNp c/fs/exec.c d/fs/exec.c
--- c/fs/exec.c	Wed Oct 16 05:27:53 2002
+++ d/fs/exec.c	Wed Oct 30 14:25:59 2002
@@ -1001,6 +1001,8 @@ int do_execve(char * filename, char ** a
 	int retval;
 	int i;
=20
+	sched_balance_exec();
+
 	file =3D open_exec(filename);
=20
 	retval =3D PTR_ERR(file);
diff -urNp c/include/linux/sched.h d/include/linux/sched.h
--- c/include/linux/sched.h	Wed Oct 30 14:02:01 2002
+++ d/include/linux/sched.h	Wed Oct 30 14:25:59 2002
@@ -167,6 +167,19 @@ extern void update_one_process(struct ta
 			       unsigned long system, int cpu);
 extern void scheduler_tick(int user_tick, int system);
 extern unsigned long cache_decay_ticks;
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
=20
 #define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
 extern signed long FASTCALL(schedule_timeout(signed long timeout));
diff -urNp c/init/main.c d/init/main.c
--- c/init/main.c	Wed Oct 16 05:27:19 2002
+++ d/init/main.c	Wed Oct 30 14:25:59 2002
@@ -495,6 +495,7 @@ static void do_pre_smp_initcalls(void)
=20
 	migration_init();
 #endif
+	node_nr_running_init();
 	spawn_ksoftirqd();
 }
=20
diff -urNp c/kernel/sched.c d/kernel/sched.c
--- c/kernel/sched.c	Wed Oct 30 14:15:41 2002
+++ d/kernel/sched.c	Wed Oct 30 14:27:22 2002
@@ -153,6 +153,7 @@ struct runqueue {
 	task_t *curr, *idle;
 	prio_array_t *active, *expired, arrays[2];
 	int prev_nr_running[NR_CPUS];
+	atomic_t * node_ptr;
=20
 	task_t *migration_thread;
 	struct list_head migration_queue;
@@ -346,7 +347,7 @@ static inline void activate_task(task_t=20
 		p->prio =3D effective_prio(p);
 	}
 	enqueue_task(p, array);
-	rq->nr_running++;
+	nr_running_inc(rq);
 }
=20
 /*
@@ -354,7 +355,7 @@ static inline void activate_task(task_t=20
  */
 static inline void deactivate_task(struct task_struct *p, runqueue_t *rq)
 {
-	rq->nr_running--;
+	nr_running_dec(rq);
 	if (p->state =3D=3D TASK_UNINTERRUPTIBLE)
 		rq->nr_uninterruptible++;
 	dequeue_task(p, p->array);
@@ -897,9 +898,9 @@ skip_queue:
 static inline void pull_task(runqueue_t *src_rq, prio_array_t *src_array, =
task_t *p, runqueue_t *this_rq, int this_cpu)
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
@@ -2228,6 +2229,83 @@ __init int migration_init(void)
=20
 #endif
=20
+#if CONFIG_NUMA
+static atomic_t node_nr_running[MAX_NUMNODES] ____cacheline_maxaligned_in_=
smp =3D {[0 ...MAX_NUMNODES-1] =3D ATOMIC_INIT(0)};
+
+__init void node_nr_running_init(void)
+{
+	int i;
+
+	for (i =3D 0; i < NR_CPUS; i++) {
+		cpu_rq(i)->node_ptr =3D &node_nr_running[__cpu_to_node(i)];
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
+	old_mask =3D p->cpus_allowed;
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
+	int i, minload, load, best_cpu, node =3D 0;
+
+	best_cpu =3D task_cpu(p);
+	if (cpu_rq(best_cpu)->nr_running <=3D 2)
+		return best_cpu;
+
+	minload =3D 10000000;
+	for (i =3D 0; i < numnodes; i++) {
+		load =3D atomic_read(&node_nr_running[i]);
+		if (load < minload) {
+			minload =3D load;
+			node =3D i;
+		}
+	}
+	minload =3D 10000000;
+	loop_over_node(i,node) {
+		if (!cpu_online(i))
+			continue;
+		if (cpu_rq(i)->nr_running < minload) {
+			best_cpu =3D i;
+			minload =3D cpu_rq(i)->nr_running;
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
+		new_cpu =3D sched_best_cpu(current);
+		if (new_cpu !=3D smp_processor_id())
+			sched_migrate_task(current, new_cpu);
+	}
+}
+#endif /* CONFIG_NUMA */
+
 #if CONFIG_SMP || CONFIG_PREEMPT
 /*
  * The 'big kernel lock'
@@ -2255,6 +2334,10 @@ void __init sched_init(void)
 		rq->expired =3D rq->arrays + 1;
 		spin_lock_init(&rq->lock);
 		INIT_LIST_HEAD(&rq->migration_queue);
+#if CONFIG_NUMA
+		rq->node_ptr =3D &node_nr_running[0];
+#endif /* CONFIG_NUMA */
+
=20
 		for (j =3D 0; j < 2; j++) {
 			array =3D rq->arrays + j;

--=-+VxA2DmJvSZRZ4Ps/yjR--

