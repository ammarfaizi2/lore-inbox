Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265180AbSJWUSX>; Wed, 23 Oct 2002 16:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265182AbSJWUSX>; Wed, 23 Oct 2002 16:18:23 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:62459 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265180AbSJWUSV>; Wed, 23 Oct 2002 16:18:21 -0400
Subject: Re: [PATCH 2.5.44] Simple NUMA Scheduler rev4 (2/2)
From: Michael Hohnbaum <hohnbaum@us.ibm.com>
To: Michael Hohnbaum <hohnbaum@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu,
       Erich Focht <efocht@ess.nec.de>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
In-Reply-To: <1035395598.9367.1037.camel@dyn9-47-17-164.beaverton.ibm.com>
References: <1035395598.9367.1037.camel@dyn9-47-17-164.beaverton.ibm.com>
Content-Type: multipart/mixed; boundary="=-5Hcm7PGR7b8gY9xGHlVT"
X-Mailer: Ximian Evolution 1.0.8 
Date: 23 Oct 2002 13:22:03 -0700
Message-Id: <1035404551.1274.1045.camel@dyn9-47-17-164.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5Hcm7PGR7b8gY9xGHlVT
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2002-10-23 at 10:53, Michael Hohnbaum wrote:
> Attached is my simple NUMA scheduler patch.  It has been split into
> two separate patches, 

Here is the second piece of the NUMA scheduler patch.  This patch adds
logic to exec to place the exec'd task on the least loaded runqueue.

This only effects kernels built with CONFIG_NUMA.

Please consider for inclusion in 2.5 kernel trees.

-- 

Michael Hohnbaum                      503-578-5486
hohnbaum@us.ibm.com                   T/L 775-5486

--=-5Hcm7PGR7b8gY9xGHlVT
Content-Disposition: attachment; filename=sched44rev4.part2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=sched44rev4.part2; charset=ISO-8859-1

--- clean-2.5.44/kernel/sched.c	Wed Oct 23 10:03:50 2002
+++ linux-2.5.44/kernel/sched.c	Wed Oct 23 10:03:59 2002
@@ -33,6 +33,7 @@
 #include <linux/timer.h>
 #include <linux/rcupdate.h>
 #include <asm/topology.h>
+#include <linux/percpu.h>
=20
 /*
  * Convert user-nice values [ -20 ... 0 ... 19 ]
@@ -2134,6 +2135,81 @@ __init int migration_init(void)
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
--- clean-2.5.44/fs/exec.c	Tue Oct 22 13:53:08 2002
+++ linux-2.5.44/fs/exec.c	Tue Oct 22 10:32:19 2002
@@ -1001,6 +1001,8 @@ int do_execve(char * filename, char ** a
 	int retval;
 	int i;
=20
+	sched_balance_exec();
+
 	file =3D open_exec(filename);
=20
 	retval =3D PTR_ERR(file);
--- clean-2.5.44/include/linux/sched.h	Tue Oct 22 13:53:41 2002
+++ linux-2.5.44/include/linux/sched.h	Tue Oct 22 10:32:19 2002
@@ -156,6 +156,11 @@ extern void update_one_process(struct ta
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

--=-5Hcm7PGR7b8gY9xGHlVT--

