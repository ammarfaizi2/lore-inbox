Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261660AbSJPW0Q>; Wed, 16 Oct 2002 18:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261663AbSJPW0Q>; Wed, 16 Oct 2002 18:26:16 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:58318 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261660AbSJPW0M>;
	Wed, 16 Oct 2002 18:26:12 -0400
Subject: [PATCH] NUMA Scheduler - rev 4
From: Michael Hohnbaum <hohnbaum@us.ibm.com>
To: torvalds@transmeta.com, mingo@elte.hu, linux-kernel@vger.kernel.org
Cc: Erich Focht <efocht@ess.nec.de>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Content-Type: multipart/mixed; boundary="=-AD8Q8peCoygqOtqxD5zK"
X-Mailer: Ximian Evolution 1.0.8 
Date: 16 Oct 2002 15:31:57 -0700
Message-Id: <1034807518.9367.910.camel@dyn9-47-17-164.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-AD8Q8peCoygqOtqxD5zK
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Linus, Ingo,

Attached is a small patch which provides NUMA awareness to the
O(1) scheduler.  This patch retains the identical O(1) scheduler
behavior for SMP systems.  For multi-node systems it favors
runqueues on the current node when looking for another runqueue
to pull tasks from.  It also makes a balance decision at exec().
This patch is against 2.5.43.

On NUMA systems these two changes have shown performance gains 
in the 5 - 10% range depending on tests.  Some micro-benchmarks 
provided by Erich Focht which stress the memory subsystem show
a doubling in performance.

Please consider applying this patch.
-- 

Michael Hohnbaum                      503-578-5486
hohnbaum@us.ibm.com                   T/L 775-5486

--=-AD8Q8peCoygqOtqxD5zK
Content-Disposition: attachment; filename=sched43rev4.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=sched43rev4.patch; charset=ISO-8859-1

--- clean-2.5.43/kernel/sched.c	Wed Oct 16 13:53:11 2002
+++ linux-2.5.43/kernel/sched.c	Wed Oct 16 13:35:12 2002
@@ -32,6 +32,9 @@
 #include <linux/delay.h>
 #include <linux/timer.h>
 #include <linux/rcupdate.h>
+#include <asm/topology.h>
+#include <linux/percpu.h>
+
=20
 /*
  * Convert user-nice values [ -20 ... 0 ... 19 ]
@@ -639,15 +642,35 @@ static inline unsigned int double_lock_b
  */
 static inline runqueue_t *find_busiest_queue(runqueue_t *this_rq, int this=
_cpu, int idle, int *imbalance)
 {
-	int nr_running, load, max_load, i;
-	runqueue_t *busiest, *rq_src;
+	int nr_running, load, max_load_on_node, max_load_off_node, i;
+	runqueue_t *busiest, *busiest_on_node, *busiest_off_node, *rq_src;
=20
 	/*
-	 * We search all runqueues to find the most busy one.
+	 * This routine is designed to work on NUMA systems.  For
+	 * non-NUMA systems, everything ends up being on the same
+	 * node and most of the NUMA specific logic is optimized
+	 * away by the compiler.
+	 *=20
+	 * We must look at each runqueue to update prev_nr_running.
+	 * As we do so, we find the busiest runqueue on the same
+	 * node, and the busiest runqueue off the node.  After
+	 * determining the busiest from each we first see if the
+	 * busiest runqueue on node meets the imbalance criteria.
+	 * If not, then we check the off queue runqueue.  Note that
+	 * we require a higher level of imbalance for choosing an
+	 * off node runqueue.
+	 *
+	 * For off-node, we only move at most one process, so imbalance
+	 * is always set to one for off-node runqueues.
+	 *=20
 	 * We do this lockless to reduce cache-bouncing overhead,
 	 * we re-check the 'best' source CPU later on again, with
 	 * the lock held.
 	 *
+	 * Note that this routine is called with the current runqueue
+	 * locked, and if a runqueue is found (return !=3D NULL), then
+	 * that runqueue is returned locked, also.
+	 *
 	 * We fend off statistical fluctuations in runqueue lengths by
 	 * saving the runqueue length during the previous load-balancing
 	 * operation and using the smaller one the current and saved lengths.
@@ -669,8 +692,12 @@ static inline runqueue_t *find_busiest_q
 	else
 		nr_running =3D this_rq->prev_nr_running[this_cpu];
=20
+	busiest_on_node =3D NULL;
+	busiest_off_node =3D NULL;
 	busiest =3D NULL;
-	max_load =3D 1;
+	max_load_on_node =3D 1;
+	max_load_off_node =3D 3;
+=09
 	for (i =3D 0; i < NR_CPUS; i++) {
 		if (!cpu_online(i))
 			continue;
@@ -682,33 +709,44 @@ static inline runqueue_t *find_busiest_q
 			load =3D this_rq->prev_nr_running[i];
 		this_rq->prev_nr_running[i] =3D rq_src->nr_running;
=20
-		if ((load > max_load) && (rq_src !=3D this_rq)) {
-			busiest =3D rq_src;
-			max_load =3D load;
+		if (__cpu_to_node(i) =3D=3D __cpu_to_node(this_cpu)) {
+			if ((load > max_load_on_node) && (rq_src !=3D this_rq)) {
+				busiest_on_node =3D rq_src;
+				max_load_on_node =3D load;
+			}
+		} else {
+			if (load > max_load_off_node)  {
+				busiest_off_node =3D rq_src;
+				max_load_off_node =3D load;
+			}
 		}
 	}
-
-	if (likely(!busiest))
-		goto out;
-
-	*imbalance =3D (max_load - nr_running) / 2;
-
-	/* It needs an at least ~25% imbalance to trigger balancing. */
-	if (!idle && (*imbalance < (max_load + 3)/4)) {
-		busiest =3D NULL;
-		goto out;
+	if (busiest_on_node) {
+		/* on node balancing happens if there is > 125% difference */
+		*imbalance =3D (max_load_on_node - nr_running) / 2;
+		if (idle || (*imbalance >=3D  (max_load_on_node + 3)/4)) {
+			busiest =3D busiest_on_node;
+		}
 	}
-
-	nr_running =3D double_lock_balance(this_rq, busiest, this_cpu, idle, nr_r=
unning);
-	/*
-	 * Make sure nothing changed since we checked the
-	 * runqueue length.
-	 */
-	if (busiest->nr_running <=3D nr_running + 1) {
-		spin_unlock(&busiest->lock);
-		busiest =3D NULL;
+	if (busiest_off_node && !busiest) {
+		/* off node balancing requires 400% difference */
+		/*if ((nr_running*4 >=3D max_load_off_node) && !idle) */
+		if (nr_running*4 >=3D max_load_off_node)=20
+			return NULL;
+		busiest =3D busiest_off_node;=20
+		*imbalance =3D 1;
+	}=20
+	if (busiest) {
+		nr_running =3D double_lock_balance(this_rq, busiest, this_cpu, idle, nr_=
running);
+		/*
+		 * Make sure nothing changed since we checked the
+		 * runqueue length.
+		 */
+		if (busiest->nr_running <=3D nr_running + 1) {
+			spin_unlock(&busiest->lock);
+			busiest =3D NULL;
+		}
 	}
-out:
 	return busiest;
 }
=20
@@ -2098,6 +2136,81 @@ __init int migration_init(void)
=20
 #endif
=20
+#if CONFIG_NUMA
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
+ * keep track of the last cpu that we exec'd from - use of this
+ * can be "fuzzy" as multiple procs can grab this at more or less
+ * the same time and set it similarly.  Those situations will=20
+ * balance out on a heavily loaded system (where they are more
+ * likely to occur) quite rapidly
+ */
+static DEFINE_PER_CPU(int, last_exec_cpu) =3D 0;
+/*
+ * Find the least loaded CPU.  Slightly favor the current CPU by
+ * setting its runqueue length as the minimum to start.  If=20
+ * current is lightly loaded, just stick with it.
+ */
+static int sched_best_cpu(struct task_struct *p)
+{
+	int i, minload, best_cpu, cur_cpu, node;
+	best_cpu =3D task_cpu(p);
+	if (cpu_rq(best_cpu)->nr_running <=3D 2)
+		return best_cpu;
+
+	node =3D __cpu_to_node(__get_cpu_var(last_exec_cpu));
+	if (++node >=3D numnodes)
+		node =3D 0;
+=09
+	cur_cpu =3D __node_to_first_cpu(node);
+	minload =3D cpu_rq(best_cpu)->nr_running;
+
+	for (i =3D 0; i < NR_CPUS; i++) {
+		if (!cpu_online(cur_cpu))
+			continue;
+
+		if (minload > cpu_rq(cur_cpu)->nr_running) {
+			minload =3D cpu_rq(cur_cpu)->nr_running;
+			best_cpu =3D cur_cpu;
+		}
+		if (++cur_cpu >=3D NR_CPUS)
+			cur_cpu =3D 0;
+	}
+	__get_cpu_var(last_exec_cpu) =3D best_cpu;
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
--- clean-2.5.43/fs/exec.c	Wed Oct 16 13:52:33 2002
+++ linux-2.5.43/fs/exec.c	Wed Oct 16 13:34:36 2002
@@ -1001,6 +1001,8 @@ int do_execve(char * filename, char ** a
 	int retval;
 	int i;
=20
+	sched_balance_exec();
+
 	file =3D open_exec(filename);
=20
 	retval =3D PTR_ERR(file);
--- clean-2.5.43/include/linux/sched.h	Wed Oct 16 13:53:06 2002
+++ linux-2.5.43/include/linux/sched.h	Wed Oct 16 13:34:37 2002
@@ -166,6 +166,11 @@ extern void update_one_process(struct ta
 			       unsigned long system, int cpu);
 extern void scheduler_tick(int user_tick, int system);
 extern unsigned long cache_decay_ticks;
+#ifdef CONFIG_NUMA
+extern void sched_balance_exec(void);
+#else
+#define sched_balance_exec() {}
+#endif
=20
=20
 #define	MAX_SCHEDULE_TIMEOUT	LONG_MAX

--=-AD8Q8peCoygqOtqxD5zK--

