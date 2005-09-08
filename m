Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932618AbVIHFnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932618AbVIHFnp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 01:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932623AbVIHFnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 01:43:45 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:37570 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S932618AbVIHFno (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 01:43:44 -0400
Date: Thu, 8 Sep 2005 14:43:42 +0900
From: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] SUBCPUSETS: CPU resource controller
X-Mailer: Sylpheed version 2.1.0+svn (GTK+ 2.6.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20050908054342.EDAF770031@sv1.valinux.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds CPU resource controller.  It enables us to control
CPU time percentage of tasks grouped by the cpu_rc structure.
It controls time_slice of tasks based on the feedback of difference
between the target value and the current usage in order to control 
the percentage of the CPU usage to the target value.

Signed-off-by: KUROSAWA Takahiro <kurosawa@valinux.co.jp>


--- /dev/null
+++ to-work/include/linux/cpu_rc.h	2005-09-07 20:43:16.914455369 +0900
@@ -0,0 +1,60 @@
+#ifndef _LINUX_CPU_RC_H_
+#define _LINUX_CPU_RC_H_
+/*
+ *  CPU resource controller interface
+ *
+ *  Copyright 2005 FUJITSU LIMITED
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License.  See the file COPYING in the main directory of the Linux
+ *  distribution for more details.
+ */
+
+#include <linux/config.h>
+#include <linux/sched.h>
+#include <linux/cpuset.h>
+
+#ifdef CONFIG_CPU_RC
+
+#ifdef __KERNEL__
+void cpu_rc_init(void);
+void cpu_rc_scale_timeslice(task_t *tsk, unsigned int *slice);
+void cpu_rc_account(task_t *tsk, unsigned long now);
+void cpu_rc_collect_hunger(task_t *tsk);
+
+static inline void cpu_rc_record_activated(task_t *tsk, unsigned long now)
+{
+	tsk->last_activated = now;
+}
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
+#endif /* __KERNEL__ */
+
+#else /* CONFIG_CPU_RC */
+
+#ifdef __KERNEL__
+static inline void cpu_rc_init(void) {}
+static inline void cpu_rc_scale_timeslice(task_t *tsk, unsigned int *slice) {}
+static inline void cpu_rc_account(task_t *tsk, unsigned long now) {}
+static inline void cpu_rc_collect_hunger(task_t *tsk) {}
+static inline void cpu_rc_record_activated(task_t *tsk, unsigned long now) {}
+static inline void cpu_rc_record_allocation(task_t *tsk,
+					    unsigned int slice,
+					    unsigned long now) {}
+#endif /* __KERNEL__ */
+
+#endif /* CONFIG_CPU_RC */
+
+#endif /* _LINUX_CPU_RC_H_ */
+
--- from-0001/include/linux/sched.h
+++ to-work/include/linux/sched.h	2005-09-07 20:43:16.915455228 +0900
@@ -769,6 +769,11 @@ struct task_struct {
 	nodemask_t mems_allowed;
 	int cpuset_mems_generation;
 #endif
+#ifdef CONFIG_CPU_RC
+	unsigned int last_slice;
+	unsigned long ts_alloced;
+	unsigned long last_activated;
+#endif
 	atomic_t fs_excl;	/* holding fs exclusive resources */
 };
 
--- from-0003/init/Kconfig
+++ to-work/init/Kconfig	2005-09-07 20:43:30.799495336 +0900
@@ -247,6 +247,14 @@ config SUBCPUSETS
 
 	  Say N if unsure.
 
+config CPU_RC
+	bool "CPU resource controller"
+	help
+	  This options will let you control the CPU resource by scaling 
+	  the timeslice allocated for each tasks.
+
+	  Say N if unsure.
+
 menuconfig EMBEDDED
 	bool "Configure standard kernel features (for small systems)"
 	help
--- from-0001/init/main.c
+++ to-work/init/main.c	2005-09-07 20:43:16.918454805 +0900
@@ -42,6 +42,7 @@
 #include <linux/writeback.h>
 #include <linux/cpu.h>
 #include <linux/cpuset.h>
+#include <linux/cpu_rc.h>
 #include <linux/efi.h>
 #include <linux/unistd.h>
 #include <linux/rmap.h>
@@ -524,7 +525,7 @@ asmlinkage void __init start_kernel(void
 	proc_root_init();
 #endif
 	cpuset_init();
-
+	cpu_rc_init();
 	check_bugs();
 
 	acpi_early_init(); /* before LAPIC and SMP init */
--- from-0001/kernel/Makefile
+++ to-work/kernel/Makefile	2005-09-07 20:43:16.913455511 +0900
@@ -20,6 +20,7 @@ obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_KEXEC) += kexec.o
 obj-$(CONFIG_COMPAT) += compat.o
 obj-$(CONFIG_CPUSETS) += cpuset.o
+obj-$(CONFIG_CPU_RC) += cpu_rc.o
 obj-$(CONFIG_IKCONFIG) += configs.o
 obj-$(CONFIG_IKCONFIG_PROC) += configs.o
 obj-$(CONFIG_STOP_MACHINE) += stop_machine.o
--- /dev/null
+++ to-work/kernel/cpu_rc.c	2005-09-07 20:44:20.097536349 +0900
@@ -0,0 +1,235 @@
+/*
+ *  kernel/cpu_rc.c
+ *
+ *  CPU resource controller by scaling time_slice of the task.
+ *
+ *  Copyright 2005 FUJITSU LIMITED
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License.  See the file COPYING in the main directory of the Linux
+ *  distribution for more details.
+ */
+
+#include <linux/config.h>
+#include <linux/sched.h>
+#include <linux/proc_fs.h>
+#include <linux/cpu_rc.h>
+
+/* local macros */
+#define CPU_RC_SPREAD_PERIOD	(5 * HZ)
+#define CPU_RC_LOAD_SCALE	1000
+#define CPU_RC_GUAR_SCALE	100
+#define CPU_RC_TSFACTOR_MAX	CPU_RC_GUAR_SCALE
+#define CPU_RC_TSFACTOR_INC	5
+#define CPU_RC_RECALC_INTERVAL	HZ
+
+struct cpu_rc_toplevel {
+	spinlock_t lock;
+	struct cpuset *cs;
+	unsigned int hungry_groups;
+	unsigned int shares;
+	cpumask_t cpus;
+	int numcpus;
+};
+
+struct cpu_rc {
+	int guarantee;
+	int is_hungry;
+	unsigned int ts_factor;
+	unsigned long last_recalc;
+	struct cpu_rc_toplevel *top;
+	struct {
+		unsigned long timestamp;
+		unsigned int load;
+		int maybe_hungry;
+	} stat[NR_CPUS];	/* XXX  need alignment */
+};
+
+static struct cpu_rc *cpu_rc_get(task_t *tsk);
+
+static inline void cpu_rc_lock(struct cpu_rc *cr)
+{
+	spin_lock(&cr->top->lock);
+}
+
+static inline void cpu_rc_unlock(struct cpu_rc *cr)
+{
+	spin_unlock(&cr->top->lock);
+}
+
+static inline int cpu_rc_is_hungry(struct cpu_rc *cr)
+{
+	return cr->is_hungry;
+}
+
+static inline void cpu_rc_set_hungry(struct cpu_rc *cr)
+{
+	if (!cr->is_hungry) {
+		cr->top->hungry_groups++;
+		cr->is_hungry = !cr->is_hungry;
+	}
+}
+
+static inline void cpu_rc_set_satisfied(struct cpu_rc *cr)
+{
+	if (cr->is_hungry) {
+		cr->top->hungry_groups--;
+		cr->is_hungry = !cr->is_hungry;
+	}
+}
+
+static inline int cpu_rc_is_anyone_hungry(struct cpu_rc *cr)
+{
+	return cr->top->hungry_groups > 0;
+}
+
+static inline void cpu_rc_recalc_tsfactor(struct cpu_rc *cr)
+{
+	unsigned int load;
+	int maybe_hungry;
+	int i, n;
+
+	n = 0;
+	load = 0;
+	maybe_hungry = 0;
+
+	cpu_rc_lock(cr);
+	for_each_cpu_mask(i, cr->top->cpus) {
+		load += cr->stat[i].load;
+		maybe_hungry += cr->stat[i].maybe_hungry;
+		cr->stat[i].maybe_hungry = 0;
+		n++;
+	}
+	load = load / n;
+
+	if (load * CPU_RC_GUAR_SCALE >= cr->guarantee * CPU_RC_LOAD_SCALE) {
+		cpu_rc_set_satisfied(cr);
+	} else if (maybe_hungry > 0) {
+		cpu_rc_set_hungry(cr);
+	} else {
+		cpu_rc_set_satisfied(cr);
+	}
+
+	if (!cpu_rc_is_anyone_hungry(cr)) {
+		/* Everyone satisfied.  Extend time_slice. */
+		cr->ts_factor += CPU_RC_TSFACTOR_INC;
+	} else {
+		if (cpu_rc_is_hungry(cr)) {
+			/* Extend time_slice a little. */
+			cr->ts_factor++;
+		} else {
+			/* time_slice should be scaled. */
+			cr->ts_factor = cr->ts_factor * cr->guarantee 
+				* CPU_RC_LOAD_SCALE
+				/ (load * CPU_RC_GUAR_SCALE);
+		}
+	}
+
+	if (cr->ts_factor == 0) {
+		cr->ts_factor = 1;
+	} else if (cr->ts_factor > CPU_RC_TSFACTOR_MAX) {
+		cr->ts_factor = CPU_RC_TSFACTOR_MAX;
+	}
+
+	cr->last_recalc = jiffies;
+
+	cpu_rc_unlock(cr);
+}
+
+void cpu_rc_scale_timeslice(task_t *tsk, unsigned int *slice)
+{
+	struct cpu_rc *cr;
+	unsigned int scaled;
+
+	cr = cpu_rc_get(tsk);
+	if (cr == NULL) {
+		return;
+	}
+
+	if (jiffies - cr->last_recalc > CPU_RC_RECALC_INTERVAL) {
+		cpu_rc_recalc_tsfactor(cr);
+	}	
+
+	scaled = *slice * cr->ts_factor / CPU_RC_TSFACTOR_MAX;
+	if (scaled == 0) {
+		scaled = 1;
+	}
+
+	*slice = scaled;
+}
+
+void cpu_rc_account(task_t *tsk, unsigned long now)
+{
+	struct cpu_rc *cr;
+	int cpu = smp_processor_id();
+	unsigned long last;
+	unsigned int load, tsk_load;
+	unsigned long base, update;
+
+	if (tsk == idle_task(task_cpu(tsk))) {
+		return;
+	}
+
+	cr = cpu_rc_get(tsk);
+	if (cr == NULL) {
+		return;
+	}
+
+	base = now - tsk->ts_alloced;
+	if (base == 0) {
+		/* duration too small. can not collect statistics. */
+		return;
+	}
+
+	tsk_load = CPU_RC_LOAD_SCALE * (tsk->last_slice - tsk->time_slice)
+		+ (CPU_RC_LOAD_SCALE - 1);
+	if (base > CPU_RC_SPREAD_PERIOD) {
+		tsk_load = CPU_RC_SPREAD_PERIOD * tsk_load / base;
+	}
+
+	last = cr->stat[cpu].timestamp;
+	update = now - last;
+	if (update > CPU_RC_SPREAD_PERIOD) {
+		/* statistics data obsolete. */
+		load = 0;
+		update = CPU_RC_SPREAD_PERIOD;
+	} else {
+		load = cr->stat[cpu].load * (CPU_RC_SPREAD_PERIOD - update);
+	}
+
+	cr->stat[cpu].timestamp = now;
+	cr->stat[cpu].load = (load + tsk_load) / CPU_RC_SPREAD_PERIOD;
+}
+
+void cpu_rc_collect_hunger(task_t *tsk)
+{
+	struct cpu_rc *cr;
+	unsigned long wait;
+	int cpu = smp_processor_id();
+
+	if (tsk == idle_task(task_cpu(tsk))) {
+		return;
+	}
+
+	if (tsk->last_activated == 0) {
+		return;
+	}
+
+	cr = cpu_rc_get(tsk);
+	if (cr == NULL) {
+		tsk->last_activated = 0;
+		return;
+	}
+
+	wait = jiffies - tsk->last_activated;
+	if (CPU_RC_GUAR_SCALE * tsk->last_slice
+	    / (wait + tsk->last_slice) < cr->guarantee / cr->top->numcpus) {
+		cr->stat[cpu].maybe_hungry++;
+	}
+
+	tsk->last_activated = 0;
+}
+
+void cpu_rc_init(void)
+{
+}
--- from-0001/kernel/sched.c
+++ to-work/kernel/sched.c	2005-09-07 20:43:16.911455793 +0900
@@ -41,6 +41,7 @@
 #include <linux/rcupdate.h>
 #include <linux/cpu.h>
 #include <linux/cpuset.h>
+#include <linux/cpu_rc.h>
 #include <linux/percpu.h>
 #include <linux/kthread.h>
 #include <linux/seq_file.h>
@@ -168,10 +169,17 @@
 
 static unsigned int task_timeslice(task_t *p)
 {
+	unsigned int timeslice;
+
 	if (p->static_prio < NICE_TO_PRIO(0))
-		return SCALE_PRIO(DEF_TIMESLICE*4, p->static_prio);
+		timeslice = SCALE_PRIO(DEF_TIMESLICE*4, p->static_prio);
 	else
-		return SCALE_PRIO(DEF_TIMESLICE, p->static_prio);
+		timeslice = SCALE_PRIO(DEF_TIMESLICE, p->static_prio);
+
+	if (!TASK_INTERACTIVE(p))
+		cpu_rc_scale_timeslice(p, &timeslice);
+
+	return timeslice;
 }
 #define task_hot(p, now, sd) ((long long) ((now) - (p)->last_ran)	\
 				< (long long) (sd)->cache_hot_time)
@@ -660,6 +668,7 @@ static int effective_prio(task_t *p)
  */
 static inline void __activate_task(task_t *p, runqueue_t *rq)
 {
+	cpu_rc_record_activated(p, jiffies);
 	enqueue_task(p, rq->active);
 	rq->nr_running++;
 }
@@ -1294,6 +1303,7 @@ int fastcall wake_up_state(task_t *p, un
 void fastcall sched_fork(task_t *p, int clone_flags)
 {
 	int cpu = get_cpu();
+	unsigned long now = jiffies;
 
 #ifdef CONFIG_SMP
 	cpu = sched_balance_self(cpu, SD_BALANCE_FORK);
@@ -1330,9 +1340,12 @@ void fastcall sched_fork(task_t *p, int 
 	 * The remainder of the first timeslice might be recovered by
 	 * the parent if the child exits early enough.
 	 */
+	cpu_rc_account(current, now);
 	p->first_time_slice = 1;
 	current->time_slice >>= 1;
 	p->timestamp = sched_clock();
+	cpu_rc_record_allocation(current, current->time_slice, now);
+	cpu_rc_record_allocation(p, p->time_slice, now);
 	if (unlikely(!current->time_slice)) {
 		/*
 		 * This case is rare, it happens when the parent has only
@@ -1390,6 +1403,7 @@ void fastcall wake_up_new_task(task_t * 
 				p->array = current->array;
 				p->array->nr_active++;
 				rq->nr_running++;
+				cpu_rc_record_activated(p, jiffies);
 			}
 			set_need_resched();
 		} else
@@ -1440,16 +1454,21 @@ void fastcall sched_exit(task_t * p)
 {
 	unsigned long flags;
 	runqueue_t *rq;
+	unsigned long now = jiffies;
 
 	/*
 	 * If the child was a (relative-) CPU hog then decrease
 	 * the sleep_avg of the parent as well.
 	 */
 	rq = task_rq_lock(p->parent, &flags);
+	cpu_rc_account(p, now);
 	if (p->first_time_slice) {
+		cpu_rc_account(p->parent, now);
 		p->parent->time_slice += p->time_slice;
 		if (unlikely(p->parent->time_slice > task_timeslice(p)))
 			p->parent->time_slice = task_timeslice(p);
+		cpu_rc_record_allocation(p->parent,
+					 p->parent->time_slice, now);
 	}
 	if (p->sleep_avg < p->parent->sleep_avg)
 		p->parent->sleep_avg = p->parent->sleep_avg /
@@ -2487,6 +2506,7 @@ void scheduler_tick(void)
 	runqueue_t *rq = this_rq();
 	task_t *p = current;
 	unsigned long long now = sched_clock();
+	unsigned long jnow = jiffies;
 
 	update_cpu_clock(p, rq, now);
 
@@ -2521,6 +2541,9 @@ void scheduler_tick(void)
 			p->time_slice = task_timeslice(p);
 			p->first_time_slice = 0;
 			set_tsk_need_resched(p);
+#ifdef CONFIG_CPU_RC
+			/* XXX  need accounting even for rt_task? */
+#endif
 
 			/* put it at the end of the queue: */
 			requeue_task(p, rq->active);
@@ -2530,9 +2553,12 @@ void scheduler_tick(void)
 	if (!--p->time_slice) {
 		dequeue_task(p, rq->active);
 		set_tsk_need_resched(p);
+		cpu_rc_account(p, jnow);
 		p->prio = effective_prio(p);
 		p->time_slice = task_timeslice(p);
 		p->first_time_slice = 0;
+		cpu_rc_record_allocation(p, p->time_slice, jnow);
+		cpu_rc_record_activated(p, jnow);
 
 		if (!rq->expired_timestamp)
 			rq->expired_timestamp = jiffies;
@@ -2891,6 +2917,7 @@ switch_tasks:
 	rcu_qsctr_inc(task_cpu(prev));
 
 	update_cpu_clock(prev, rq, now);
+	cpu_rc_collect_hunger(next);
 
 	prev->sleep_avg -= run_time;
 	if ((long)prev->sleep_avg <= 0)
