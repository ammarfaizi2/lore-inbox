Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264618AbSJNLCt>; Mon, 14 Oct 2002 07:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264619AbSJNLCs>; Mon, 14 Oct 2002 07:02:48 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:17540 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S264618AbSJNLCq>; Mon, 14 Oct 2002 07:02:46 -0400
From: Erich Focht <efocht@ess.nec.de>
Subject: [PATCH] node affine NUMA scheduler 2/5
Date: Mon, 14 Oct 2002 13:07:23 +0200
User-Agent: KMail/1.4.1
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_BKXY3312VDCJ0C018BKN"
Message-Id: <200210141307.23442.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_BKXY3312VDCJ0C018BKN
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

----------  Resent Message  ----------

Subject: [PATCH] node affine NUMA scheduler 2/5
Date: Fri, 11 Oct 2002 19:56:22 +0200

This is the second part of the node affine NUMA scheduler patches.

> 02-numa_sched_ilb-2.5.39-10.patch :
>        This patch provides simple initial load balancing during exec().
>        It is node aware and will select the least loaded node. Also it
>        does a round-robin initial node selection to distribute the load
>        better across the nodes.

Erich

--------------Boundary-00=_BKXY3312VDCJ0C018BKN
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="02-numa_sched_ilb-2.5.39-10.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="02-numa_sched_ilb-2.5.39-10.patch"

diff -urNp a/fs/exec.c b/fs/exec.c
--- a/fs/exec.c	Tue Oct  8 15:03:54 2002
+++ b/fs/exec.c	Fri Oct 11 16:21:02 2002
@@ -993,6 +993,7 @@ int do_execve(char * filename, char ** a
 	int retval;
 	int i;
 
+	sched_balance_exec();
 	file = open_exec(filename);
 
 	retval = PTR_ERR(file);
diff -urNp a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	Thu Oct 10 13:45:18 2002
+++ b/include/linux/sched.h	Fri Oct 11 16:21:02 2002
@@ -461,6 +461,9 @@ extern void set_cpus_allowed(task_t *p, 
 extern void build_pools(void);
 extern void pooldata_lock(void);
 extern void pooldata_unlock(void);
+extern void sched_balance_exec(void);
+#else
+#define sched_balance_exec() {}
 #endif
 extern void sched_migrate_task(task_t *p, int cpu);
 
diff -urNp a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Fri Oct 11 16:18:58 2002
+++ b/kernel/sched.c	Fri Oct 11 16:21:02 2002
@@ -2166,6 +2166,78 @@ out:
 	preempt_enable();
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
 void sched_migrate_task(task_t *p, int dest_cpu)
 {
 	unsigned long old_mask;

--------------Boundary-00=_BKXY3312VDCJ0C018BKN--

