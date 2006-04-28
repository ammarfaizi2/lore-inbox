Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030274AbWD1BmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030274AbWD1BmI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 21:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030251AbWD1BiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 21:38:09 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:54509 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030252AbWD1Bh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 21:37:59 -0400
From: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
Cc: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
Date: Fri, 28 Apr 2006 10:37:35 +0900
Message-Id: <20060428013735.9582.46323.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
In-Reply-To: <20060428013730.9582.9351.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
References: <20060428013730.9582.9351.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
Subject: [PATCH 1/9] CPU controller - Add class load estimation support
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1/9: cpurc_load_estimation

This patch corresponds to section 1 in Documentation/res_group/cpurc-internals,
adding load estimation of task in a resource group that is
grouped by the cpurc structure.  Load estimation is necessary for controlling
CPU resource because the CPU resource controller need to know whether
the resource assigned to a resource group is enough or not.

Signed-off-by: Kurosawa Takahiro <kurosawa@valinux.co.jp>
Signed-off-by: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>

 include/linux/cpu_rc.h |   65 ++++++++++++++++++++++++++++++++++++++++
 include/linux/sched.h  |    5 +++
 init/Kconfig           |    9 +++++
 kernel/Makefile        |    1 
 kernel/cpu_rc.c        |   79 +++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/exit.c          |    2 +
 kernel/sched.c         |   14 ++++++++
 7 files changed, 175 insertions(+)

Index: linux-2.6.17-rc3/include/linux/cpu_rc.h
===================================================================
--- /dev/null
+++ linux-2.6.17-rc3/include/linux/cpu_rc.h
@@ -0,0 +1,65 @@
+#ifndef _LINUX_CPU_RC_H_
+#define _LINUX_CPU_RC_H_
+/*
+ *  CPU resource controller interface
+ *
+ *  Copyright 2005-2006 FUJITSU LIMITED
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License.  See the file COPYING in the main directory of the Linux
+ *  distribution for more details.
+ */
+
+#include <linux/config.h>
+#include <linux/sched.h>
+
+#ifdef CONFIG_CPU_RC
+
+#define CPU_RC_SPREAD_PERIOD	(10 * HZ)
+#define CPU_RC_LOAD_SCALE	(2 * CPU_RC_SPREAD_PERIOD)
+#define CPU_RC_GUAR_SCALE	100
+
+struct cpu_rc_domain {
+	spinlock_t lock;
+	unsigned long timestamp;
+	cpumask_t cpus;
+	int numcpus;
+	int numcrs;
+};
+
+struct cpu_rc {
+	struct cpu_rc_domain *rcd;
+	struct {
+		unsigned long timestamp;
+		unsigned int load;
+	} stat[NR_CPUS];	/* XXX  need alignment */
+};
+
+extern struct cpu_rc *cpu_rc_get(task_t *);
+extern unsigned int cpu_rc_load(struct cpu_rc *);
+extern void cpu_rc_account(task_t *, unsigned long);
+
+static inline void cpu_rc_record_allocation(task_t *tsk,
+					    unsigned int slice,
+					    unsigned long now)
+{
+	if (slice == 0) {
+		/* minimal allocated time_slice is 1 (see sched_fork()). */
+		slice = 1;
+	}
+
+	tsk->last_slice = slice;
+	tsk->ts_alloced = now;
+}
+
+#else /* CONFIG_CPU_RC */
+
+static inline void cpu_rc_account(task_t *tsk, unsigned long now) {}
+static inline void cpu_rc_record_allocation(task_t *tsk,
+					    unsigned int slice,
+					    unsigned long now) {}
+
+#endif /* CONFIG_CPU_RC */
+
+#endif /* _LINUX_CPU_RC_H_ */
+
Index: linux-2.6.17-rc3/include/linux/sched.h
===================================================================
--- linux-2.6.17-rc3.orig/include/linux/sched.h
+++ linux-2.6.17-rc3/include/linux/sched.h
@@ -892,6 +892,11 @@ struct task_struct {
 	struct resource_group *res_group;
 	struct list_head member_list; /* list of tasks in the resource group */
 #endif /* CONFIG_RES_GROUPS */
+#ifdef CONFIG_CPU_RC
+	unsigned int last_slice;
+	unsigned long ts_alloced;
+#endif
+
 };
 
 static inline pid_t process_group(struct task_struct *tsk)
Index: linux-2.6.17-rc3/init/Kconfig
===================================================================
--- linux-2.6.17-rc3.orig/init/Kconfig
+++ linux-2.6.17-rc3/init/Kconfig
@@ -261,6 +261,15 @@ config RELAY
 
 	  If unsure, say N.
 
+config CPU_RC
+	bool "CPU resource controller"
+	depends on RES_GROUPS_RES_CPU
+	help
+	  This options will let you control the CPU resource by scaling
+	  the timeslice allocated for each tasks.
+
+	  Say N if unsure.
+
 source "usr/Kconfig"
 
 config UID16
Index: linux-2.6.17-rc3/kernel/Makefile
===================================================================
--- linux-2.6.17-rc3.orig/kernel/Makefile
+++ linux-2.6.17-rc3/kernel/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_KEXEC) += kexec.o
 obj-$(CONFIG_COMPAT) += compat.o
 obj-$(CONFIG_CPUSETS) += cpuset.o
+obj-$(CONFIG_CPU_RC) += cpu_rc.o
 obj-$(CONFIG_IKCONFIG) += configs.o
 obj-$(CONFIG_STOP_MACHINE) += stop_machine.o
 obj-$(CONFIG_AUDIT) += audit.o auditfilter.o
Index: linux-2.6.17-rc3/kernel/cpu_rc.c
===================================================================
--- /dev/null
+++ linux-2.6.17-rc3/kernel/cpu_rc.c
@@ -0,0 +1,79 @@
+/*
+ *  kernel/cpu_rc.c
+ *
+ *  CPU resource controller by scaling time_slice of the task.
+ *
+ *  Copyright 2005-2006 FUJITSU LIMITED
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License.  See the file COPYING in the main directory of the Linux
+ *  distribution for more details.
+ */
+
+#include <linux/config.h>
+#include <linux/sched.h>
+#include <linux/cpu_rc.h>
+
+/*
+ * cpu_rc_load() calculates a resource group load
+ */
+unsigned int cpu_rc_load(struct cpu_rc *cr)
+{
+	unsigned int load;
+	int i, n;
+
+	BUG_ON(!cr);
+
+	load = 0;
+	n = 0;
+
+	/* Just reading the value, so no locking... */
+	for_each_cpu_mask(i, cr->rcd->cpus) {
+		if (jiffies - cr->stat[i].timestamp <= CPU_RC_SPREAD_PERIOD)
+			load += cr->stat[i].load;
+		n++;
+	}
+
+	return load / n * CPU_RC_GUAR_SCALE / CPU_RC_LOAD_SCALE;
+}
+
+/*
+ * cpu_rc_account() calculates the task load when the timeslice is expired
+ */
+void cpu_rc_account(task_t *tsk, unsigned long now)
+{
+	struct cpu_rc *cr;
+	int cpu = get_cpu();
+	unsigned long last;
+	unsigned int resgrp_load, tsk_load;
+	unsigned long base, update;
+
+	if (tsk == idle_task(task_cpu(tsk)))
+		goto out;
+
+	cr = cpu_rc_get(tsk);
+	if (!cr)
+		goto out;
+
+	base = now - tsk->ts_alloced;
+	if (base == 0)
+		goto out;  /* duration too small. can not collect statistics. */
+
+	tsk_load = CPU_RC_LOAD_SCALE * (tsk->last_slice - tsk->time_slice)
+			+ (CPU_RC_LOAD_SCALE / 2);
+	if (base > CPU_RC_SPREAD_PERIOD)
+		tsk_load = CPU_RC_SPREAD_PERIOD * tsk_load / base;
+
+	last = cr->stat[cpu].timestamp;
+	update = now - last;
+	if (update > CPU_RC_SPREAD_PERIOD)
+		resgrp_load = 0;  /* statistics data obsolete. */
+	else
+		resgrp_load = cr->stat[cpu].load
+			 * (CPU_RC_SPREAD_PERIOD - update);
+
+	cr->stat[cpu].timestamp = now;
+	cr->stat[cpu].load = (resgrp_load + tsk_load) / CPU_RC_SPREAD_PERIOD;
+out:
+	put_cpu();
+}
Index: linux-2.6.17-rc3/kernel/sched.c
===================================================================
--- linux-2.6.17-rc3.orig/kernel/sched.c
+++ linux-2.6.17-rc3/kernel/sched.c
@@ -43,6 +43,7 @@
 #include <linux/rcupdate.h>
 #include <linux/cpu.h>
 #include <linux/cpuset.h>
+#include <linux/cpu_rc.h>
 #include <linux/percpu.h>
 #include <linux/kthread.h>
 #include <linux/seq_file.h>
@@ -1377,6 +1378,7 @@ int fastcall wake_up_state(task_t *p, un
 void fastcall sched_fork(task_t *p, int clone_flags)
 {
 	int cpu = get_cpu();
+	unsigned long now;
 
 #ifdef CONFIG_SMP
 	cpu = sched_balance_self(cpu, SD_BALANCE_FORK);
@@ -1416,6 +1418,9 @@ void fastcall sched_fork(task_t *p, int 
 	p->first_time_slice = 1;
 	current->time_slice >>= 1;
 	p->timestamp = sched_clock();
+	now = jiffies;
+	cpu_rc_record_allocation(current, current->time_slice, now);
+	cpu_rc_record_allocation(p, p->time_slice, now);
 	if (unlikely(!current->time_slice)) {
 		/*
 		 * This case is rare, it happens when the parent has only
@@ -1533,6 +1538,8 @@ void fastcall sched_exit(task_t *p)
 		p->parent->time_slice += p->time_slice;
 		if (unlikely(p->parent->time_slice > task_timeslice(p)))
 			p->parent->time_slice = task_timeslice(p);
+		cpu_rc_record_allocation(p->parent,
+					 p->parent->time_slice, jiffies);
 	}
 	if (p->sleep_avg < p->parent->sleep_avg)
 		p->parent->sleep_avg = p->parent->sleep_avg /
@@ -2617,6 +2624,7 @@ void scheduler_tick(void)
 	runqueue_t *rq = this_rq();
 	task_t *p = current;
 	unsigned long long now = sched_clock();
+	unsigned long jnow;
 
 	update_cpu_clock(p, rq, now);
 
@@ -2651,6 +2659,9 @@ void scheduler_tick(void)
 			p->time_slice = task_timeslice(p);
 			p->first_time_slice = 0;
 			set_tsk_need_resched(p);
+#ifdef CONFIG_CPU_RC
+			/* XXX  need accounting even for rt_task? */
+#endif
 
 			/* put it at the end of the queue: */
 			requeue_task(p, rq->active);
@@ -2660,9 +2671,12 @@ void scheduler_tick(void)
 	if (!--p->time_slice) {
 		dequeue_task(p, rq->active);
 		set_tsk_need_resched(p);
+		jnow = jiffies;
+		cpu_rc_account(p, jnow);
 		p->prio = effective_prio(p);
 		p->time_slice = task_timeslice(p);
 		p->first_time_slice = 0;
+		cpu_rc_record_allocation(p, p->time_slice, jnow);
 
 		if (!rq->expired_timestamp)
 			rq->expired_timestamp = jiffies;
Index: linux-2.6.17-rc3/kernel/exit.c
===================================================================
--- linux-2.6.17-rc3.orig/kernel/exit.c
+++ linux-2.6.17-rc3/kernel/exit.c
@@ -36,6 +36,7 @@
 #include <linux/compat.h>
 #include <linux/pipe_fs_i.h>
 #include <linux/res_group.h>
+#include <linux/cpu_rc.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -852,6 +853,7 @@ fastcall NORET_TYPE void do_exit(long co
 	int group_dead;
 
 	profile_task_exit(tsk);
+	cpu_rc_account(tsk, jiffies);
 
 	WARN_ON(atomic_read(&tsk->fs_excl));
 
