Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261506AbSJYRdR>; Fri, 25 Oct 2002 13:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261511AbSJYRdR>; Fri, 25 Oct 2002 13:33:17 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:14277 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S261506AbSJYRdN>; Fri, 25 Oct 2002 13:33:13 -0400
From: Erich Focht <efocht@ess.nec.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] NUMA scheduler 2/2
Date: Fri, 25 Oct 2002 19:39:20 +0200
User-Agent: KMail/1.4.1
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Theurer <habanero@us.ibm.com>
References: <200210111954.30447.efocht@ess.nec.de> <200210251937.53335.efocht@ess.nec.de>
In-Reply-To: <200210251937.53335.efocht@ess.nec.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_K1TJK7AO9799VYYNJHV2"
Message-Id: <200210251939.20422.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_K1TJK7AO9799VYYNJHV2
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

The second part of the patch:

> 02-numa_sched_ilb-2.5.44-10.patch :
>        This patch provides simple initial load balancing during exec().
>        It is node aware and will select the least loaded node. Also it
>        does a round-robin initial node selection to distribute the load
>        better across the nodes.

Regards,
Erich
--------------Boundary-00=_K1TJK7AO9799VYYNJHV2
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="02-numa_sched_ilb-2.5.44-10.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="02-numa_sched_ilb-2.5.44-10.patch"

diff -urNp a/fs/exec.c b/fs/exec.c
--- a/fs/exec.c	Sat Oct 19 06:01:48 2002
+++ b/fs/exec.c	Fri Oct 25 18:09:35 2002
@@ -1001,6 +1001,7 @@ int do_execve(char * filename, char ** a
 	int retval;
 	int i;
 
+	sched_balance_exec();
 	file = open_exec(filename);
 
 	retval = PTR_ERR(file);
diff -urNp a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	Fri Oct 25 18:07:58 2002
+++ b/include/linux/sched.h	Fri Oct 25 18:09:35 2002
@@ -447,6 +447,9 @@ extern void set_cpus_allowed(task_t *p, 
 extern void build_pools(void);
 extern void pooldata_lock(void);
 extern void pooldata_unlock(void);
+extern void sched_balance_exec(void);
+#else
+#define sched_balance_exec() {}
 #endif
 extern void sched_migrate_task(task_t *p, int cpu);
 
diff -urNp a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Fri Oct 25 18:56:13 2002
+++ b/kernel/sched.c	Fri Oct 25 18:54:46 2002
@@ -2181,6 +2181,89 @@ void set_cpus_allowed(task_t *p, unsigne
 	wait_for_completion(&req.done);
 }
 
+#ifdef CONFIG_NUMA
+/* used as counter for round-robin node-scheduling */
+static atomic_t sched_node=ATOMIC_INIT(0);
+
+/*
+ * Find the least loaded CPU on the current node of the task.
+ */
+static int sched_best_cpu(struct task_struct *p, int node)
+{
+	int n, cpu, load, best_cpu = task_cpu(p);
+	
+	load = 1000000;
+	loop_over_node(n,cpu,node) {
+		if (!(p->cpus_allowed & (1UL << cpu) & cpu_online_map))
+			continue;
+		if (cpu_rq(cpu)->nr_running < load) {
+			best_cpu = cpu;
+			load = cpu_rq(cpu)->nr_running;
+		}
+	}
+	return best_cpu;
+}
+
+/*
+ * Find the node with fewest number of tasks running on it.
+ */
+static int sched_best_node(struct task_struct *p)
+{
+	int i, n, best_node=0, min_load, pool_load, min_pool=numa_node_id();
+	int cpu, pool, load;
+	unsigned long mask = p->cpus_allowed & cpu_online_map;
+
+	do {
+		/* atomic_inc_return is not implemented on all archs [EF] */
+		atomic_inc(&sched_node);
+		best_node = atomic_read(&sched_node) % numpools;
+	} while (!(pool_mask[best_node] & mask));
+
+	min_load = 100000000;
+	for (n = 0; n < numpools; n++) {
+		pool = (best_node + n) % numpools;
+		load = 0;
+		loop_over_node(i, cpu, pool) {
+			if (!cpu_online(cpu)) continue;
+			load += cpu_rq(cpu)->nr_running;
+		}
+		if (pool == numa_node_id()) load--;
+		pool_load = 100*load/pool_nr_cpus[pool];
+		if ((pool_load < min_load) && (pool_mask[pool] & mask)) {
+			min_load = pool_load;
+			min_pool = pool;
+		}
+	}
+	atomic_set(&sched_node, min_pool);
+	return min_pool;
+}
+
+void sched_balance_exec(void)
+{
+	int new_cpu, new_node=0;
+
+	while (pooldata_is_locked())
+		cpu_relax();
+	if (numpools > 1) {
+		new_node = sched_best_node(current);
+	} 
+	new_cpu = sched_best_cpu(current, new_node);
+	if (new_cpu != smp_processor_id())
+		sched_migrate_task(current, new_cpu);
+}
+#endif
+
+void sched_migrate_task(task_t *p, int dest_cpu)
+{
+	unsigned long old_mask;
+
+	old_mask = p->cpus_allowed;
+	if (!(old_mask & (1UL << dest_cpu)))
+		return;
+	set_cpus_allowed(p, 1UL << dest_cpu);
+	set_cpus_allowed(p, old_mask);
+}
+
 /*
  * migration_thread - this is a highprio system thread that performs
  * thread migration by 'pulling' threads into the target runqueue.

--------------Boundary-00=_K1TJK7AO9799VYYNJHV2--

