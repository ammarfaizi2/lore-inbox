Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262070AbSJIX4u>; Wed, 9 Oct 2002 19:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262582AbSJIX4t>; Wed, 9 Oct 2002 19:56:49 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:62155 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262070AbSJIX42>;
	Wed, 9 Oct 2002 19:56:28 -0400
Subject: [RFC] Simple NUMA Scheduler - rev 2
From: Michael Hohnbaum <hohnbaum@us.ibm.com>
To: mingo@elte.hu, linux-kernel@vger.kernel.org
Cc: Erich Focht <efocht@ess.nec.de>, mbligh@arcanet.com
Content-Type: multipart/mixed; boundary="=-at7rgZ7p1AuPtNasYKKY"
X-Mailer: Ximian Evolution 1.0.8 
Date: 09 Oct 2002 16:56:15 -0700
Message-Id: <1034207779.9367.595.camel@dyn9-47-17-164.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-at7rgZ7p1AuPtNasYKKY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Attached is an updated version of my simple NUMA scheduler patch
which applies against 2.5.41. This patch does two things:

* When balancing loads between runqueues, it favors balancing 
  between runqueues on the same node.
* An additional balance action happens at exec time to help
  minimize balancing later.  This results in less movement
  of tasks between nodes.

Since the last version, the only significant change has been to
modify the exec time load balancing to keep track of the last cpu
that was chosen by the exec load balance and start looking on the 
next node for the shortest runqueue.  This results in a more balanced
distribution of tasks across nodes and processors, but on 32-bit
NUMA systems has the disadvantage of no longer favoring node 0.  Due
to the bulk of the kernel's memory residing on node 0, the prior
behavior that favored node 0 actually resulted in slightly better
performance for the 32-bit NUMA systems I've been working with.

There have been a few other minor tweaks and extensive testing.

This is not nearly as full functioned as Erich Focht's NUMA scheduler,
but is also less intrusive.  Our performance testing shows no effect
on non-NUMA smp machines, better performance on NUMA machines, and 
more even distribution of load across nodes.

While much more can be done to support NUMA scheduling, this relatively
small patch is a good start and provides significant improvements.

Kernbench numbers:

stock 2.5.41:  312.49user 123.99system 34.86elapsed
numasched:     293.36user 126.47system 33.69elapsed

Also attached are the results of running Erich's numa_test with 
parameters of 4, 8, 12, 16, 24, 32, 48, 64, and 96.  These show
the load across nodes and the percent of time that each process
spent on each node.

Comments?
-- 

Michael Hohnbaum                      503-578-5486
hohnbaum@us.ibm.com                   T/L 775-5486

--=-at7rgZ7p1AuPtNasYKKY
Content-Disposition: attachment; filename=sched41rev1.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=sched41rev1.patch; charset=ISO-8859-1

--- clean-2.5.41/kernel/sched.c	Wed Oct  9 14:57:30 2002
+++ linux-2.5.41/kernel/sched.c	Wed Oct  9 14:47:36 2002
@@ -31,6 +31,8 @@
 #include <linux/blkdev.h>
 #include <linux/delay.h>
 #include <linux/timer.h>
+#include <asm/topology.h>
+#include <linux/percpu.h>
=20
 /*
  * Convert user-nice values [ -20 ... 0 ... 19 ]
@@ -638,15 +640,35 @@ static inline unsigned int double_lock_b
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
@@ -667,9 +689,15 @@ static inline runqueue_t *find_busiest_q
 		nr_running =3D this_rq->nr_running;
 	else
 		nr_running =3D this_rq->prev_nr_running[this_cpu];
+	if (nr_running < 1)=20
+		nr_running =3D 1;
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
@@ -679,35 +707,47 @@ static inline runqueue_t *find_busiest_q
 			load =3D rq_src->nr_running;
 		else
 			load =3D this_rq->prev_nr_running[i];
+
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
+		if (idle || ((nr_running*5)/4 < max_load_on_node)) {
+			busiest =3D busiest_on_node;
+			*imbalance =3D (max_load_on_node - nr_running) / 2;
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
+		if (busiest->nr_running <=3D nr_running) {
+			spin_unlock(&busiest->lock);
+			busiest =3D NULL;
+		}
 	}
-out:
 	return busiest;
 }
=20
@@ -2097,6 +2137,78 @@ __init int migration_init(void)
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
+ * setting its runqueue length as the minimum to start.
+ */
+static int sched_best_cpu(struct task_struct *p)
+{
+	int i, minload, best_cpu, cur_cpu, node;
+	best_cpu =3D task_cpu(p);
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
--- clean-2.5.41/fs/exec.c	Wed Oct  9 14:57:12 2002
+++ linux-2.5.41/fs/exec.c	Wed Oct  9 14:44:43 2002
@@ -1001,6 +1001,8 @@ int do_execve(char * filename, char ** a
 	int retval;
 	int i;
=20
+	sched_balance_exec();
+
 	file =3D open_exec(filename);
=20
 	retval =3D PTR_ERR(file);
--- clean-2.5.41/include/linux/sched.h	Wed Oct  9 14:57:29 2002
+++ linux-2.5.41/include/linux/sched.h	Wed Oct  9 14:44:44 2002
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

--=-at7rgZ7p1AuPtNasYKKY
Content-Disposition: attachment; filename=numa_test.41_rev1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=numa_test.41_rev1; charset=ISO-8859-1

Executing 4 times: ./randupdt 1000000=20
Running 'hackbench 20' in the background: Time: 11.536
Job  node00 node01 node02 node03 | iSched MSched | UserTime(s)
  1   100.0    0.0    0.0    0.0 |    0     0    |  23.84
  2     0.0    0.0  100.0    0.0 |    2     2    |  22.72
  3     0.0    0.0    0.0  100.0 |    3     3    |  41.32
  4     0.0    0.0    0.0  100.0 |    3     3    |  41.57
AverageUserTime 32.36 seconds
ElapsedTime     49.55
TotalUserTime   129.49
TotalSysTime    0.80

Executing 8 times: ./randupdt 1000000=20
Running 'hackbench 20' in the background: Time: 11.874
Job  node00 node01 node02 node03 | iSched MSched | UserTime(s)
  1     0.0    0.0    0.0  100.0 |    3     3    |  84.39
  2   100.0    0.0    0.0    0.0 |    0     0    |  23.63
  3     0.0    0.0  100.0    0.0 |    2     2    |  61.75
  4     0.0    0.0    0.0  100.0 |    3     3    |  85.00
  5     0.0    0.0  100.0    0.0 |    2     2    |  61.50
  6     0.0    0.0    0.0  100.0 |    3     3    |  84.99
  7     0.0    0.0    0.0  100.0 |    3     3    |  84.72
  8     0.0    0.0  100.0    0.0 |    2     2    |  61.24
AverageUserTime 68.40 seconds
ElapsedTime     91.19
TotalUserTime   547.32
TotalSysTime    2.07

Executing 12 times: ./randupdt 1000000=20
Running 'hackbench 20' in the background: Time: 16.169
Job  node00 node01 node02 node03 | iSched MSched | UserTime(s)
  1     0.0    0.0  100.0    0.0 |    2     2    |  44.10
  2   100.0    0.0    0.0    0.0 |    0     0    |  84.31
  3   100.0    0.0    0.0    0.0 |    0     0    |  84.45
  4   100.0    0.0    0.0    0.0 |    0     0    |  84.46
  5     0.0  100.0    0.0    0.0 |    1     1    |  61.54
  6     0.0    0.0    0.0  100.0 |    3     3    |  61.42
  7     0.0    0.0  100.0    0.0 |    2     2    |  43.71
  8     0.0    0.0    0.0  100.0 |    3     3    |  60.61
  9     0.0  100.0    0.0    0.0 |    1     1    |  61.78
 10     0.0    0.0    0.0  100.0 |    3     3    |  61.16
 11   100.0    0.0    0.0    0.0 |    0     0    |  84.66
 12     0.0  100.0    0.0    0.0 |    1     1    |  61.59
AverageUserTime 66.15 seconds
ElapsedTime     91.51
TotalUserTime   793.90
TotalSysTime    3.62

Executing 16 times: ./randupdt 1000000=20
Running 'hackbench 20' in the background: Time: 14.488
Job  node00 node01 node02 node03 | iSched MSched | UserTime(s)
  1     0.0    0.0  100.0    0.0 |    2     2    |  70.24
  2     0.0   93.9    0.0    6.0 |    3     1   *|  65.34
  3     0.0    0.0  100.0    0.0 |    2     2    |  70.86
  4     0.0  100.0    0.0    0.0 |    1     1    |  70.22
  5     0.0  100.0    0.0    0.0 |    1     1    |  70.09
  6   100.0    0.0    0.0    0.0 |    0     0    |  84.47
  7   100.0    0.0    0.0    0.0 |    0     0    |  84.32
  8     0.0    0.0  100.0    0.0 |    2     2    |  70.02
  9     0.0  100.0    0.0    0.0 |    1     1    |  69.88
 10   100.0    0.0    0.0    0.0 |    0     0    |  83.83
 11     0.0    0.0  100.0    0.0 |    2     2    |  71.03
 12     0.0    0.0    0.0  100.0 |    3     3    |  45.64
 13     0.0    0.0    0.0  100.0 |    3     3    |  45.56
 14   100.0    0.0    0.0    0.0 |    0     0    |  83.71
 15     0.0  100.0    0.0    0.0 |    1     1    |  69.67
 16     0.0    0.0   93.1    6.9 |    3     2   *|  67.75
AverageUserTime 70.16 seconds
ElapsedTime     94.40
TotalUserTime   1122.77
TotalSysTime    6.10

Executing 24 times: ./randupdt 1000000=20
Running 'hackbench 20' in the background: Time: 13.749
Job  node00 node01 node02 node03 | iSched MSched | UserTime(s)
  1     0.0  100.0    0.0    0.0 |    1     1    |  79.82
  2     0.0  100.0    0.0    0.0 |    1     1    |  80.48
  3     0.0   81.4   18.6    0.0 |    2     1   *|  75.62
  4     0.0    0.0  100.0    0.0 |    2     2    |  73.29
  5     0.0    0.0    0.0  100.0 |    3     3    |  85.90
  6   100.0    0.0    0.0    0.0 |    0     0    |  88.94
  7     0.0   13.5   86.4    0.0 |    1     2   *|  70.06
  8     0.0    0.0    0.0  100.0 |    3     3    |  84.27
  9     0.0    0.0  100.0    0.0 |    2     2    |  70.40
 10     0.0   76.8   23.2    0.0 |    2     1   *|  75.80
 11     0.0  100.0    0.0    0.0 |    1     1    |  81.97
 12   100.0    0.0    0.0    0.0 |    0     0    |  89.59
 13     0.0    0.0    0.0  100.0 |    3     3    |  84.69
 14   100.0    0.0    0.0    0.0 |    0     0    |  89.16
 15   100.0    0.0    0.0    0.0 |    0     0    |  88.98
 16     0.0    0.0    0.0  100.0 |    3     3    |  83.11
 17     0.0  100.0    0.0    0.0 |    1     1    |  80.33
 18     0.0   81.8   18.2    0.0 |    2     1   *|  76.35
 19     0.0    0.0  100.0    0.0 |    2     2    |  72.20
 20     0.0   91.2    8.7    0.0 |    1     1    |  75.47
 21     0.0    0.0  100.0    0.0 |    2     2    |  72.95
 22   100.0    0.0    0.0    0.0 |    0     0    |  88.33
 23     0.0    0.0    0.0  100.0 |    3     3    |  85.27
 24   100.0    0.0    0.0    0.0 |    0     0    |  89.63
AverageUserTime 80.94 seconds
ElapsedTime     160.86
TotalUserTime   1942.83
TotalSysTime    9.59

Executing 32 times: ./randupdt 1000000=20
Running 'hackbench 20' in the background: Time: 15.366
Job  node00 node01 node02 node03 | iSched MSched | UserTime(s)
  1     0.0   83.8   16.2    0.0 |    2     1   *|  71.19
  2     0.0    0.0    0.0  100.0 |    3     3    |  89.87
  3   100.0    0.0    0.0    0.0 |    0     0    |  79.33
  4     0.0    0.0    0.0  100.0 |    3     3    |  91.40
  5    65.9   34.1    0.0    0.0 |    0     0    |  89.42
  6     0.0  100.0    0.0    0.0 |    1     1    |  72.16
  7     0.0    7.5   92.4    0.0 |    1     2   *|  69.71
  8     0.0    0.0  100.0    0.0 |    2     2    |  72.38
  9     0.0    0.0  100.0    0.0 |    2     2    |  72.22
 10     0.0    0.0    0.0  100.0 |    3     3    |  89.89
 11     0.0    0.0    0.0  100.0 |    3     3    |  91.95
 12     0.0  100.0    0.0    0.0 |    1     1    |  71.96
 13    64.4   35.6    0.0    0.0 |    0     0    |  89.74
 14    62.6   37.4    0.0    0.0 |    0     0    |  88.76
 15   100.0    0.0    0.0    0.0 |    0     0    |  79.55
 16     0.0  100.0    0.0    0.0 |    1     1    |  72.04
 17     0.0    0.0    0.0  100.0 |    3     3    |  91.11
 18     9.1    7.0   83.9    0.0 |    1     2   *|  67.27
 19     0.0    0.0  100.0    0.0 |    2     2    |  71.78
 20     0.0    7.9   92.0    0.0 |    1     2   *|  69.52
 21    92.8    0.0    0.0    7.2 |    3     0   *|  73.01
 22    65.2   34.7    0.0    0.0 |    0     0    |  90.05
 23     0.0    0.0  100.0    0.0 |    2     2    |  71.58
 24     0.0    0.0    0.0  100.0 |    3     3    |  91.21
 25   100.0    0.0    0.0    0.0 |    0     0    |  78.10
 26     0.0  100.0    0.0    0.0 |    1     1    |  72.83
 27     0.0   85.0   15.0    0.0 |    2     1   *|  74.99
 28     0.0    0.0    0.0  100.0 |    3     3    |  91.33
 29   100.0    0.0    0.0    0.0 |    0     0    |  77.85
 30     0.0  100.0    0.0    0.0 |    1     1    |  72.55
 31     0.0    0.0  100.0    0.0 |    2     2    |  71.68
 32     0.0    0.0  100.0    0.0 |    2     2    |  71.55
AverageUserTime 79.00 seconds
ElapsedTime     173.62
TotalUserTime   2528.29
TotalSysTime    13.18

Executing 48 times: ./randupdt 1000000=20
Running 'hackbench 20' in the background: Time: 14.108
Job  node00 node01 node02 node03 | iSched MSched | UserTime(s)
  1     0.0    0.0  100.0    0.0 |    2     2    |  93.07
  2   100.0    0.0    0.0    0.0 |    0     0    |  76.73
  3     0.0    0.0    0.0  100.0 |    3     3    |  92.80
  4   100.0    0.0    0.0    0.0 |    0     0    |  76.67
  5     0.0  100.0    0.0    0.0 |    1     1    |  87.13
  6     0.0    0.0   27.4   72.5 |    3     3    |  92.50
  7     0.0  100.0    0.0    0.0 |    1     1    |  87.40
  8    96.4    0.0    3.6    0.0 |    2     0   *|  68.70
  9     0.0    0.0  100.0    0.0 |    2     2    |  93.17
 10     0.0    0.0  100.0    0.0 |    2     2    |  93.29
 11   100.0    0.0    0.0    0.0 |    0     0    |  77.31
 12    14.5   85.5    0.0    0.0 |    1     1    |  85.20
 13    11.2    0.0    0.0   88.8 |    3     3    |  89.68
 14     0.0  100.0    0.0    0.0 |    1     1    |  86.71
 15   100.0    0.0    0.0    0.0 |    0     0    |  76.31
 16     0.0    0.0  100.0    0.0 |    2     2    |  92.60
 17    85.7    0.0   14.3    0.0 |    0     0    |  79.78
 18    14.2   85.8    0.0    0.0 |    1     1    |  86.48
 19     0.0    0.0   24.2   75.8 |    3     3    |  93.75
 20     0.0  100.0    0.0    0.0 |    1     1    |  87.53
 21     3.9   89.6    6.5    0.0 |    2     1   *|  75.30
 22     0.0    0.0   28.6   71.4 |    3     3    |  92.68
 23    97.1    0.0    2.9    0.0 |    2     0   *|  68.57
 24     0.0    0.0   23.6   76.4 |    3     3    |  93.61
 25     0.0    0.0    0.0  100.0 |    3     3    |  92.40
 26    88.9    0.0   11.0    0.0 |    0     0    |  79.57
 27     0.0   93.0    7.0    0.0 |    1     1    |  84.48
 28     0.0    0.0  100.0    0.0 |    2     2    |  92.29
 29     0.0    0.0    0.0  100.0 |    3     3    |  90.62
 30   100.0    0.0    0.0    0.0 |    0     0    |  76.39
 31     0.0   93.5    6.4    0.0 |    1     1    |  85.21
 32     0.0    0.0    0.0  100.0 |    3     3    |  93.49
 33   100.0    0.0    0.0    0.0 |    0     0    |  76.79
 34   100.0    0.0    0.0    0.0 |    0     0    |  77.54
 35    17.8   82.2    0.0    0.0 |    1     1    |  85.70
 36     0.0    0.0    0.0  100.0 |    3     3    |  93.00
 37     0.0  100.0    0.0    0.0 |    1     1    |  87.23
 38     0.0  100.0    0.0    0.0 |    1     1    |  88.75
 39     0.0    0.0  100.0    0.0 |    2     2    |  93.61
 40    94.6    0.0    5.3    0.0 |    2     0   *|  70.23
 41     0.0    0.0    0.0  100.0 |    3     3    |  92.86
 42   100.0    0.0    0.0    0.0 |    0     0    |  76.36
 43     0.0    0.0  100.0    0.0 |    2     2    |  93.10
 44     0.0    0.0  100.0    0.0 |    2     2    |  93.20
 45     0.0    0.0    0.0  100.0 |    3     3    |  93.67
 46     0.0  100.0    0.0    0.0 |    1     1    |  86.26
 47    10.8    0.0    0.0   89.1 |    3     3    |  89.76
 48     0.0    0.0  100.0    0.0 |    2     2    |  92.90
AverageUserTime 86.09 seconds
ElapsedTime     280.00
TotalUserTime   4132.86
TotalSysTime    21.39

Executing 64 times: ./randupdt 1000000=20
Running 'hackbench 20' in the background: Time: 13.603
Job  node00 node01 node02 node03 | iSched MSched | UserTime(s)
  1   100.0    0.0    0.0    0.0 |    0     0    |  84.00
  2     4.0    0.0    0.0   95.9 |    3     3    |  95.82
  3     0.0  100.0    0.0    0.0 |    1     1    |  93.50
  4   100.0    0.0    0.0    0.0 |    0     0    |  82.26
  5     0.0  100.0    0.0    0.0 |    1     1    |  94.66
  6     0.0   16.4   83.6    0.0 |    2     2    | 102.18
  7     0.0  100.0    0.0    0.0 |    1     1    |  94.33
  8     0.0  100.0    0.0    0.0 |    1     1    |  94.03
  9     0.0    0.0    3.4   96.6 |    3     3    |  94.86
 10     0.0    0.0  100.0    0.0 |    2     2    |  96.11
 11     0.0    0.0  100.0    0.0 |    2     2    |  96.12
 12     4.5    0.0    0.0   95.5 |    3     3    |  96.22
 13     0.0    0.0  100.0    0.0 |    2     2    |  96.93
 14     0.0   15.2   84.7    0.0 |    2     2    | 100.45
 15     0.0    0.0  100.0    0.0 |    2     2    |  96.78
 16     0.0    0.0    0.0  100.0 |    3     3    |  94.57
 17   100.0    0.0    0.0    0.0 |    0     0    |  82.75
 18     0.0   16.6   83.4    0.0 |    2     2    | 101.95
 19   100.0    0.0    0.0    0.0 |    0     0    |  77.92
 20     4.5    0.0    0.0   95.5 |    3     3    |  95.95
 21    94.6    5.4    0.0    0.0 |    1     0   *|  72.52
 22     0.0  100.0    0.0    0.0 |    1     1    |  94.59
 23     0.0    0.0    3.4   96.6 |    3     3    |  94.92
 24     0.0   16.5   83.5    0.0 |    2     2    | 101.34
 25     0.0  100.0    0.0    0.0 |    1     1    |  93.88
 26     5.2    0.0    0.0   94.8 |    3     3    |  96.49
 27     0.0    0.0  100.0    0.0 |    2     2    |  96.38
 28     0.0    0.0  100.0    0.0 |    2     2    |  96.23
 29   100.0    0.0    0.0    0.0 |    0     0    |  82.50
 30     0.0  100.0    0.0    0.0 |    1     1    |  93.76
 31     0.0    0.0    3.8   96.2 |    3     3    |  95.17
 32   100.0    0.0    0.0    0.0 |    0     0    |  82.31
 33     0.0  100.0    0.0    0.0 |    1     1    |  92.61
 34   100.0    0.0    0.0    0.0 |    0     0    |  82.76
 35   100.0    0.0    0.0    0.0 |    0     0    |  83.61
 36     0.0  100.0    0.0    0.0 |    1     1    |  93.42
 37     0.0   16.4   83.6    0.0 |    2     2    | 101.63
 38     0.0    0.0  100.0    0.0 |    2     2    |  96.40
 39     4.1    0.0    0.0   95.9 |    3     3    |  95.21
 40     0.0    0.0    0.0  100.0 |    3     3    |  95.23
 41     0.0    0.0    0.0  100.0 |    3     3    |  95.13
 42   100.0    0.0    0.0    0.0 |    0     0    |  82.62
 43    93.7    6.3    0.0    0.0 |    1     0   *|  74.32
 44     3.8    0.0    0.0   96.2 |    3     3    |  95.16
 45     5.6    0.0    0.0   94.4 |    3     3    |  96.73
 46   100.0    0.0    0.0    0.0 |    0     0    |  81.83
 47     0.0  100.0    0.0    0.0 |    1     1    |  94.87
 48     0.0   16.9   83.0    0.0 |    2     2    | 101.77
 49     0.0    0.0    0.0  100.0 |    3     3    |  94.42
 50   100.0    0.0    0.0    0.0 |    0     0    |  78.51
 51     0.0  100.0    0.0    0.0 |    1     1    |  94.60
 52     0.0   16.6   83.4    0.0 |    2     2    | 102.15
 53     0.0    0.0    3.7   96.3 |    3     3    |  95.09
 54   100.0    0.0    0.0    0.0 |    0     0    |  81.18
 55     0.0  100.0    0.0    0.0 |    1     1    |  94.65
 56     0.0   16.4   83.6    0.0 |    2     2    | 101.48
 57     5.3    0.0    0.0   94.7 |    3     3    |  96.57
 58     0.0  100.0    0.0    0.0 |    1     1    |  93.91
 59   100.0    0.0    0.0    0.0 |    0     0    |  89.94
 60     0.0  100.0    0.0    0.0 |    1     1    |  94.04
 61     0.0    0.0  100.0    0.0 |    2     2    |  96.44
 62   100.0    0.0    0.0    0.0 |    0     0    |  89.97
 63   100.0    0.0    0.0    0.0 |    0     0    |  81.94
 64   100.0    0.0    0.0    0.0 |    0     0    |  82.09
AverageUserTime 92.22 seconds
ElapsedTime     383.35
TotalUserTime   5902.42
TotalSysTime    28.86

Executing 96 times: ./randupdt 1000000=20
Running 'hackbench 20' in the background: Time: 14.090
Job  node00 node01 node02 node03 | iSched MSched | UserTime(s)
  1     0.0    0.0  100.0    0.0 |    2     2    |  78.58
  2     0.0   35.8    0.0   64.2 |    3     3    | 101.31
  3     0.0    0.0  100.0    0.0 |    2     2    |  85.26
  4    18.7    0.0   81.3    0.0 |    2     2    |  91.44
  5   100.0    0.0    0.0    0.0 |    0     0    |  81.95
  6    87.3   12.7    0.0    0.0 |    0     0    |  92.05
  7    18.4    0.0    0.0   81.6 |    3     3    |  91.34
  8    20.1    0.0    0.0   79.9 |    3     3    |  89.68
  9   100.0    0.0    0.0    0.0 |    0     0    |  81.49
 10     0.0  100.0    0.0    0.0 |    1     1    |  94.60
 11     0.0    0.0    0.0  100.0 |    3     3    |  88.96
 12    17.2    0.0   82.8    0.0 |    2     2    |  89.50
 13   100.0    0.0    0.0    0.0 |    0     0    |  82.09
 14     0.0   16.5   83.5    0.0 |    1     2   *|  71.66
 15     0.0   16.5   83.5    0.0 |    1     2   *|  71.99
 16   100.0    0.0    0.0    0.0 |    0     0    |  83.69
 17     0.0    0.0  100.0    0.0 |    2     2    |  91.86
 18     0.0   36.7    0.0   63.3 |    3     3    | 102.53
 19     0.0    0.0    0.0  100.0 |    3     3    |  88.42
 20     0.0   34.5   65.5    0.0 |    2     2    | 101.58
 21     0.0  100.0    0.0    0.0 |    1     1    |  93.99
 22   100.0    0.0    0.0    0.0 |    0     0    |  85.30
 23     0.0    0.0    0.0  100.0 |    3     3    |  88.17
 24   100.0    0.0    0.0    0.0 |    0     0    |  84.35
 25     0.0  100.0    0.0    0.0 |    1     1    |  93.59
 26     0.0    0.0  100.0    0.0 |    2     2    |  94.82
 27     0.0   13.8    0.0   86.1 |    3     3    |  91.87
 28   100.0    0.0    0.0    0.0 |    0     0    |  82.11
 29     0.0    0.0  100.0    0.0 |    2     2    |  93.92
 30    12.2    0.0    0.0   87.8 |    3     3    |  95.86
 31     0.0   16.4   83.6    0.0 |    1     2   *|  71.01
 32     0.0   15.9   84.1    0.0 |    1     2   *|  73.90
 33   100.0    0.0    0.0    0.0 |    0     0    |  81.35
 34     0.0   27.3   72.7    0.0 |    2     2    |  88.46
 35     0.0  100.0    0.0    0.0 |    1     1    |  94.56
 36     0.0  100.0    0.0    0.0 |    1     1    |  95.88
 37     0.0    0.0    0.0  100.0 |    3     3    |  87.04
 38     0.0    4.8    0.0   95.2 |    3     3    |  93.61
 39   100.0    0.0    0.0    0.0 |    0     0    |  82.46
 40     8.3    0.0   91.7    0.0 |    2     2    |  91.05
 41   100.0    0.0    0.0    0.0 |    0     0    |  85.33
 42     0.0  100.0    0.0    0.0 |    1     1    |  94.32
 43     0.0    0.0  100.0    0.0 |    2     2    |  93.51
 44     0.0  100.0    0.0    0.0 |    1     1    |  95.97
 45     0.0   13.9   86.1    0.0 |    2     2    |  86.24
 46     0.0  100.0    0.0    0.0 |    1     1    |  93.91
 47     0.0    0.0  100.0    0.0 |    2     2    |  71.81
 48     0.0    0.0  100.0    0.0 |    2     2    |  95.27
 49   100.0    0.0    0.0    0.0 |    0     0    |  86.47
 50     0.0   40.0   60.0    0.0 |    2     2    | 106.63
 51     0.0    4.2    0.0   95.8 |    3     3    |  93.19
 52    11.2    0.0    0.0   88.8 |    3     3    |  94.68
 53   100.0    0.0    0.0    0.0 |    0     0    |  80.77
 54     0.0    0.0    0.0  100.0 |    3     3    |  76.72
 55     0.0  100.0    0.0    0.0 |    1     1    |  94.50
 56    19.8    0.0    0.0   80.2 |    3     3    |  92.01
 57   100.0    0.0    0.0    0.0 |    0     0    |  82.63
 58     0.0  100.0    0.0    0.0 |    1     1    |  94.37
 59   100.0    0.0    0.0    0.0 |    0     0    |  81.24
 60     0.0    0.0    0.0  100.0 |    3     3    |  92.90
 61   100.0    0.0    0.0    0.0 |    0     0    |  82.73
 62     0.0  100.0    0.0    0.0 |    1     1    |  94.01
 63     0.0   14.8    0.0   85.2 |    1     3   *|  74.53
 64     0.0    0.0    0.0  100.0 |    3     3    |  88.92
 65   100.0    0.0    0.0    0.0 |    0     0    |  82.60
 66     0.0  100.0    0.0    0.0 |    1     1    |  93.50
 67   100.0    0.0    0.0    0.0 |    0     0    |  83.04
 68   100.0    0.0    0.0    0.0 |    0     0    |  81.27
 69     0.0  100.0    0.0    0.0 |    1     1    |  94.66
 70   100.0    0.0    0.0    0.0 |    0     0    |  81.96
 71     0.0    0.0  100.0    0.0 |    2     2    |  95.29
 72    10.1    0.0   89.9    0.0 |    2     2    |  90.53
 73     0.0   38.5   61.5    0.0 |    2     2    | 107.01
 74     0.0  100.0    0.0    0.0 |    1     1    |  94.55
 75     0.0   18.2    0.0   81.8 |    3     3    |  93.29
 76     0.0   18.3   81.6    0.0 |    2     2    |  93.91
 77     0.0    0.0    0.0  100.0 |    3     3    |  87.19
 78     0.0   12.9   87.1    0.0 |    2     2    |  84.38
 79     0.0    0.0    0.0  100.0 |    3     3    |  85.86
 80     0.0    0.0  100.0    0.0 |    2     2    |  94.38
 81     0.0    0.0    0.0  100.0 |    3     3    |  92.11
 82     0.0    0.0    0.0  100.0 |    3     3    |  88.21
 83   100.0    0.0    0.0    0.0 |    0     0    |  81.03
 84     0.0    0.0    0.0  100.0 |    3     3    |  88.95
 85   100.0    0.0    0.0    0.0 |    0     0    |  80.73
 86   100.0    0.0    0.0    0.0 |    0     0    |  82.19
 87     0.0  100.0    0.0    0.0 |    1     1    |  96.19
 88     0.0  100.0    0.0    0.0 |    1     1    |  95.48
 89     0.0    0.0  100.0    0.0 |    2     2    |  71.62
 90     0.0   16.0    0.0   83.9 |    3     3    |  90.59
 91     0.0    0.0  100.0    0.0 |    2     2    |  74.89
 92     0.0    0.0  100.0    0.0 |    2     2    |  87.70
 93     0.0  100.0    0.0    0.0 |    1     1    |  95.10
 94     0.0  100.0    0.0    0.0 |    1     1    |  96.39
 95    18.5    0.0    0.0   81.5 |    3     3    |  86.26
 96   100.0    0.0    0.0    0.0 |    0     0    |  82.03
AverageUserTime 88.43 seconds
ElapsedTime     552.37
TotalUserTime   8489.93
TotalSysTime    46.83



--=-at7rgZ7p1AuPtNasYKKY--

