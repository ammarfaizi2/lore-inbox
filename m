Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262947AbSJAXx2>; Tue, 1 Oct 2002 19:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262963AbSJAXx2>; Tue, 1 Oct 2002 19:53:28 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:32141 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262947AbSJAXxW>; Tue, 1 Oct 2002 19:53:22 -0400
Subject: [RFC] Simple NUMA scheduler patch
From: Michael Hohnbaum <hohnbaum@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Cc: Erich Focht <efocht@ess.nec.de>
In-Reply-To: <Pine.LNX.4.44.0209050905180.8086-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0209050905180.8086-100000@localhost.localdomain>
Content-Type: multipart/mixed; boundary="=-1yC0mXnnkmVQ75kY85HI"
X-Mailer: Ximian Evolution 1.0.8 
Date: 01 Oct 2002 16:55:35 -0700
Message-Id: <1033516540.1209.144.camel@dyn9-47-17-164.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1yC0mXnnkmVQ75kY85HI
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Attached is a patch which provides a rudimentary NUMA scheduler.
This patch basically does two things:

* at exec() it finds the least loaded CPU to assign a task to;
* at load_balance() (find_busiest_queue() actually) it favors 
  cpus on the same node for taking tasks from.

This has been tested on the IA32 based NUMAQ platform and shows
performance gains for kernbench.  Various microbenchmarks also 
show improvements and stickiness of processes to nodes.  Profiles
show that the kernbench performance improvements are directly 
attributable to the use of local memory caused by tasks running
on the same node through their lifetime.

I will be doing much more testing of this, and likely will be
tweaking some of the algorithms based upon test results.  Any
comments, suggestions, flames are welcome.

Patch applies to 2.5.40 and makes use of the new NUMA topology
API.  This scheduler change should work on other NUMA platforms
with just the definition of the architecture specific macros in
topology.h.

-- 

Michael Hohnbaum                      503-578-5486
hohnbaum@us.ibm.com                   T/L 775-5486

--=-1yC0mXnnkmVQ75kY85HI
Content-Disposition: attachment; filename=sched40.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=sched40.patch; charset=ISO-8859-1

--- clean-2.5.40/kernel/sched.c	Tue Oct  1 13:48:34 2002
+++ linux-2.5.40/kernel/sched.c	Tue Oct  1 13:27:46 2002
@@ -30,6 +30,9 @@
 #include <linux/notifier.h>
 #include <linux/delay.h>
 #include <linux/timer.h>
+#if CONFIG_NUMA
+#include <asm/topology.h>
+#endif
=20
 /*
  * Convert user-nice values [ -20 ... 0 ... 19 ]
@@ -632,6 +635,121 @@ static inline unsigned int double_lock_b
 	return nr_running;
 }
=20
+#if CONFIG_NUMA
+/*
+ * find_busiest_queue - find the busiest runqueue.
+ */
+static inline runqueue_t *find_busiest_queue(runqueue_t *this_rq, int this=
_cpu, int idle, int *imbalance)
+{
+	int nr_running, load, max_load_on_node, max_load_off_node, i;
+	runqueue_t *busiest, *busiest_on_node, *busiest_off_node, *rq_src;
+
+	/*
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
+	 * We do this lockless to reduce cache-bouncing overhead,
+	 * we re-check the 'best' source CPU later on again, with
+	 * the lock held.
+	 *
+	 * Note that this routine is called with the current runqueue
+	 * locked, and if a runqueue is found (return !=3D NULL), then
+	 * that runqueue is returned locked, also.
+	 *
+	 * We fend off statistical fluctuations in runqueue lengths by
+	 * saving the runqueue length during the previous load-balancing
+	 * operation and using the smaller one the current and saved lengths.
+	 * If a runqueue is long enough for a longer amount of time then
+	 * we recognize it and pull tasks from it.
+	 *
+	 * The 'current runqueue length' is a statistical maximum variable,
+	 * for that one we take the longer one - to avoid fluctuations in
+	 * the other direction. So for a load-balance to happen it needs
+	 * stable long runqueue on the target CPU and stable short runqueue
+	 * on the local runqueue.
+	 *
+	 * We make an exception if this CPU is about to become idle - in
+	 * that case we are less picky about moving a task across CPUs and
+	 * take what can be taken.
+	 */
+	if (idle || (this_rq->nr_running > this_rq->prev_nr_running[this_cpu]))
+		nr_running =3D this_rq->nr_running;
+	else
+		nr_running =3D this_rq->prev_nr_running[this_cpu];
+	if (nr_running < 1)
+		nr_running =3D 1;
+
+	busiest_on_node =3D NULL;
+	busiest_off_node =3D NULL;
+	busiest =3D NULL;
+	max_load_on_node =3D 1;
+	max_load_off_node =3D 1;
+=09
+	for (i =3D 0; i < NR_CPUS; i++) {
+		if (!cpu_online(i))
+			continue;
+
+		rq_src =3D cpu_rq(i);
+		if (idle || (rq_src->nr_running < this_rq->prev_nr_running[i]))
+			load =3D rq_src->nr_running;
+		else
+			load =3D this_rq->prev_nr_running[i];
+
+		this_rq->prev_nr_running[i] =3D rq_src->nr_running;
+
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
+		}
+	}
+	if (busiest_on_node) {
+		/* on node balancing happens if there is > 125% difference */
+		if (idle || ((nr_running*5)/4 < max_load_on_node)) {
+			busiest =3D busiest_on_node;
+			*imbalance =3D (max_load_on_node - nr_running) / 2;
+		}
+	}
+	if (busiest_off_node && !busiest) {
+		/* off node balancing requires 200% difference */
+		if (nr_running*2 >=3D max_load_off_node)=20
+			return NULL;
+		busiest =3D busiest_off_node;=20
+		*imbalance =3D 1;
+	}=20
+	if (busiest) {
+		if (busiest =3D=3D this_rq) {
+			return NULL;
+		}
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
+	}
+	return busiest;
+}
+#else
+
 /*
  * find_busiest_queue - find the busiest runqueue.
  */
@@ -709,6 +827,7 @@ static inline runqueue_t *find_busiest_q
 out:
 	return busiest;
 }
+#endif /* CONFIG_NUMA */
=20
 /*
  * pull_task - move a task from a remote runqueue to the local runqueue.
@@ -2104,6 +2223,65 @@ __init int migration_init(void)
 spinlock_t kernel_flag __cacheline_aligned_in_smp =3D SPIN_LOCK_UNLOCKED;
 #endif
=20
+#if CONFIG_NUMA
+/*
+ * If dest_cpu is allowed for this process, migrate the task to it.
+ * This is accomplished by forcing the cpu_allowed mask to only
+ * allow dest_cpu, which will force the cpu onto dest_cpu.  Then
+ * the cpu_allowed mask is restored.
+ */
+void sched_migrate_task(task_t *p, int dest_cpu)
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
+ * Find the least loaded CPU.  If the current runqueue is short enough
+ * just use it.
+ */
+static int sched_best_cpu(struct task_struct *p)
+{
+	int i, minload, best_cpu;
+	best_cpu =3D task_cpu(p);
+=09
+	minload =3D cpu_rq(best_cpu)->nr_running;
+	/* if the current runqueue is only 2 long, don't look elsewhere */
+	if (minload <=3D 2)
+		return best_cpu;
+
+	for (i =3D 0; i < NR_CPUS; i++) {
+		if (!cpu_online(i))
+			continue;
+
+		if (minload > cpu_rq(i)->nr_running) {
+			minload =3D cpu_rq(i)->nr_running;
+			best_cpu =3D i;
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
 extern void init_timers(void);
=20
 void __init sched_init(void)
--- clean-2.5.40/fs/exec.c	Tue Oct  1 13:47:58 2002
+++ linux-2.5.40/fs/exec.c	Tue Oct  1 12:55:50 2002
@@ -1001,6 +1001,8 @@ int do_execve(char * filename, char ** a
 	int retval;
 	int i;
=20
+	sched_balance_exec();
+
 	file =3D open_exec(filename);
=20
 	retval =3D PTR_ERR(file);
--- clean-2.5.40/include/linux/sched.h	Tue Oct  1 13:48:30 2002
+++ linux-2.5.40/include/linux/sched.h	Tue Oct  1 12:55:51 2002
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

--=-1yC0mXnnkmVQ75kY85HI--

