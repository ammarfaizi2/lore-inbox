Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422816AbWBIGLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422816AbWBIGLt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 01:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422817AbWBIGLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 01:11:49 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:60645 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1422816AbWBIGLs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 01:11:48 -0500
From: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
To: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Cc: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
Message-Id: <20060209061147.2164.4528.sendpatchset@debian>
In-Reply-To: <20060209061142.2164.35994.sendpatchset@debian>
References: <20060209061142.2164.35994.sendpatchset@debian>
Subject: [PATCH 1/2] add a CPU resource controller
Date: Thu,  9 Feb 2006 15:11:47 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds CPU resource controller.  It enables us to control
CPU time percentage of tasks grouped by the cpu_rc structure.
It controls time_slice of tasks based on the feedback of difference
between the target value and the current usage in order to control
the percentage of the CPU usage to the target value.

This patch is against linux-2.6.15.  The patched source requires
the next patch and the CKRM patchset for compilation.

CKRM patchset can be obtained from
 http://prdownloads.sourceforge.net/ckrm/ckrm-f0.4-2615-single.patch.gz?download

The CKRM patches requires configfs-patched source code:
 http://oss.oracle.com/projects/ocfs2/dist/files/patches/2.6.15-rc5/2005-12-14/01_configfs.patch

Please note that you need to apply the patches in the following order:
 1. 01_configfs.patch
 2. ckrm-f0.4-2615-single.patch
 3. this patch (1/2)
 4. the next patch (2/2)

Signed-off-by: Kurosawa Takahiro <kurosawa@valinux.co.jp>
Signed-off-by: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>

---
 include/linux/cpu_rc.h |  104 +++++++++++++++++++++
 include/linux/sched.h  |    5 +
 init/Kconfig           |    9 +
 kernel/Makefile        |    1 
 kernel/cpu_rc.c        |  239 +++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched.c         |   48 ++++++++-
 6 files changed, 401 insertions(+), 5 deletions(-)

diff -urNp a/include/linux/cpu_rc.h b/include/linux/cpu_rc.h
--- a/include/linux/cpu_rc.h	1970-01-01 09:00:00.000000000 +0900
+++ b/include/linux/cpu_rc.h	2006-02-09 08:55:53.000000000 +0900
@@ -0,0 +1,104 @@
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
+
+#ifdef CONFIG_CPU_RC
+
+#define CPU_RC_SPREAD_PERIOD	(5 * HZ)
+#define CPU_RC_LOAD_SCALE	1000
+#define CPU_RC_GUAR_SCALE	100
+#define CPU_RC_TSFACTOR_MAX	CPU_RC_GUAR_SCALE
+#define CPU_RC_TSFACTOR_INC	5
+#define CPU_RC_HCOUNT_INC	2
+#define CPU_RC_STARVE_THRESHOLD	2
+#define CPU_RC_RECALC_INTERVAL	HZ
+
+struct cpu_rc_domain {
+	spinlock_t lock;
+	unsigned int hungry_count;
+	unsigned long timestamp;
+	cpumask_t cpus;
+	int numcpus;
+	int numcrs;
+};
+
+struct cpu_rc {
+	int guarantee;
+	int is_hungry;
+	unsigned int ts_factor;
+	unsigned long last_recalc;
+	struct cpu_rc_domain *rcd;
+	struct {
+		unsigned long timestamp;
+		unsigned int load;
+		int maybe_hungry;
+	} stat[NR_CPUS];	/* XXX  need alignment */
+};
+
+#ifdef __KERNEL__
+void cpu_rc_init(void);
+struct cpu_rc *cpu_rc_get(task_t *tsk);
+unsigned int cpu_rc_load(struct cpu_rc *cr);
+
+unsigned int cpu_rc_scale_timeslice(task_t *tsk, unsigned int slice);
+void cpu_rc_account(task_t *tsk, unsigned long now);
+void cpu_rc_collect_hunger(task_t *tsk);
+int cpu_rc_task_is_starving(task_t *tsk);
+void cpu_rc_task_kept_active(task_t *tsk);
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
+static inline struct cpu_rc *cpu_rc_get(task_t *tsk) { return NULL; }
+static inline unsigned int cpu_rc_load(struct cpu_rc *cr) { return 0; }
+static inline void cpu_rc_account(task_t *tsk, unsigned long now) {}
+static inline void cpu_rc_collect_hunger(task_t *tsk) {}
+static inline int cpu_rc_task_is_starving(task_t *tsk) { return 0; }
+static inline void cpu_rc_task_kept_active(task_t *tsk) {}
+static inline void cpu_rc_record_activated(task_t *tsk, unsigned long now) {}
+static inline void cpu_rc_record_allocation(task_t *tsk,
+					    unsigned int slice,
+					    unsigned long now) {}
+
+static inline unsigned int cpu_rc_scale_timeslice(task_t *tsk,
+						  unsigned int slice)
+{
+	return slice;
+}
+#endif /* __KERNEL__ */
+
+#endif /* CONFIG_CPU_RC */
+
+#endif /* _LINUX_CPU_RC_H_ */
+
diff -urNp a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	2006-02-08 20:09:00.000000000 +0900
+++ b/include/linux/sched.h	2006-02-09 08:56:32.000000000 +0900
@@ -860,6 +860,11 @@ struct task_struct {
 	struct ckrm_class *class;
 	struct list_head class_link;
 #endif /* CONFIG_CKRM */
+#ifdef CONFIG_CPU_RC
+	unsigned int last_slice;
+	unsigned long ts_alloced;
+	unsigned long last_activated;
+#endif
 	atomic_t fs_excl;	/* holding fs exclusive resources */
 };
 
diff -urNp a/init/Kconfig b/init/Kconfig
--- a/init/Kconfig	2006-02-08 20:09:00.000000000 +0900
+++ b/init/Kconfig	2006-02-09 09:00:24.000000000 +0900
@@ -290,6 +290,15 @@ config CPUSETS
 
 	  Say N if unsure.
 
+config CPU_RC
+	bool "CPU resource controller"
+	depends on CKRM_RES_CPU
+	help
+	  This options will let you control the CPU resource by scaling
+	  the timeslice allocated for each tasks.
+
+	  Say N if unsure.
+
 source "usr/Kconfig"
 
 config CC_OPTIMIZE_FOR_SIZE
diff -urNp a/kernel/Makefile b/kernel/Makefile
--- a/kernel/Makefile	2006-02-08 20:09:00.000000000 +0900
+++ b/kernel/Makefile	2006-02-09 08:55:53.000000000 +0900
@@ -21,6 +21,7 @@ obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_KEXEC) += kexec.o
 obj-$(CONFIG_COMPAT) += compat.o
 obj-$(CONFIG_CPUSETS) += cpuset.o
+obj-$(CONFIG_CPU_RC) += cpu_rc.o
 obj-$(CONFIG_IKCONFIG) += configs.o
 obj-$(CONFIG_STOP_MACHINE) += stop_machine.o
 obj-$(CONFIG_AUDIT) += audit.o
diff -urNp a/kernel/cpu_rc.c b/kernel/cpu_rc.c
--- a/kernel/cpu_rc.c	1970-01-01 09:00:00.000000000 +0900
+++ b/kernel/cpu_rc.c	2006-02-09 09:00:24.000000000 +0900
@@ -0,0 +1,239 @@
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
+#include <linux/cpu_rc.h>
+
+static inline void cpu_rcd_lock(struct cpu_rc *cr)
+{
+	spin_lock(&cr->rcd->lock);
+}
+
+static inline void cpu_rcd_unlock(struct cpu_rc *cr)
+{
+	spin_unlock(&cr->rcd->lock);
+}
+
+static inline int cpu_rc_is_hungry(struct cpu_rc *cr)
+{
+	return cr->is_hungry;
+}
+
+static inline void cpu_rc_set_hungry(struct cpu_rc *cr)
+{
+	cr->is_hungry++;
+	cr->rcd->hungry_count += CPU_RC_HCOUNT_INC;
+}
+
+static inline void cpu_rc_set_satisfied(struct cpu_rc *cr)
+{
+	cr->is_hungry = 0;
+}
+
+static inline int cpu_rc_is_anyone_hungry(struct cpu_rc *cr)
+{
+	return cr->rcd->hungry_count > 0;
+}
+
+static inline void cpu_rc_recalc_tsfactor(struct cpu_rc *cr)
+{
+	unsigned long now = jiffies;
+	unsigned int load;
+	int maybe_hungry;
+	int i, n;
+
+	n = 0;
+	load = 0;
+	maybe_hungry = 0;
+
+	cpu_rcd_lock(cr);
+	if (cr->rcd->timestamp == 0) {
+		cr->rcd->timestamp = now;
+	} else if (now - cr->rcd->timestamp > CPU_RC_SPREAD_PERIOD) {
+		cr->rcd->hungry_count = 0;
+		cr->rcd->timestamp = now;
+	} else if (now - cr->rcd->timestamp > CPU_RC_RECALC_INTERVAL) {
+		cr->rcd->hungry_count >>= 1;
+		cr->rcd->timestamp = now;
+	}
+
+	for_each_cpu_mask(i, cr->rcd->cpus) {
+		load += cr->stat[i].load;
+		maybe_hungry += cr->stat[i].maybe_hungry;
+		cr->stat[i].maybe_hungry = 0;
+		n++;
+	}
+
+	BUG_ON(n == 0);
+	load = load / n;
+
+	if (load * CPU_RC_GUAR_SCALE >= cr->guarantee * CPU_RC_LOAD_SCALE)
+		cpu_rc_set_satisfied(cr);
+	else if (maybe_hungry > 0)
+		cpu_rc_set_hungry(cr);
+	else
+		cpu_rc_set_satisfied(cr);
+
+	if (!cpu_rc_is_anyone_hungry(cr)) {
+		/* Everyone satisfied.  Extend time_slice. */
+		cr->ts_factor += CPU_RC_TSFACTOR_INC;
+	} else {
+		if (cpu_rc_is_hungry(cr)) {
+			/* Extend time_slice a little. */
+			cr->ts_factor++;
+		} else if (load * CPU_RC_GUAR_SCALE > 
+			   cr->guarantee * CPU_RC_LOAD_SCALE) {
+			/*
+			 * scale time_slice only when load is higher than
+			 * the guarantee.
+			 */
+			cr->ts_factor = cr->ts_factor * cr->guarantee
+				* CPU_RC_LOAD_SCALE
+				/ (load * CPU_RC_GUAR_SCALE);
+		}
+	}
+
+	if (cr->ts_factor == 0)
+		cr->ts_factor = 1;
+	else if (cr->ts_factor > CPU_RC_TSFACTOR_MAX)
+		cr->ts_factor = CPU_RC_TSFACTOR_MAX;
+
+	cr->last_recalc = now;
+
+	cpu_rcd_unlock(cr);
+}
+
+unsigned int cpu_rc_load(struct cpu_rc *cr)
+{
+	unsigned int load;
+	int i, n;
+
+	if (!cr)
+		return 0;
+
+	load = 0;
+	n = 0;
+
+	/* Just displaying the value, so no locking... */
+	for_each_cpu_mask(i, cr->rcd->cpus) {
+		if (jiffies - cr->stat[i].timestamp <= CPU_RC_SPREAD_PERIOD)
+			load += cr->stat[i].load;
+		n++;
+	}
+
+	return load / n * CPU_RC_GUAR_SCALE / CPU_RC_LOAD_SCALE;
+}
+
+unsigned int cpu_rc_scale_timeslice(task_t *tsk, unsigned int slice)
+{
+	struct cpu_rc *cr;
+	unsigned int scaled;
+
+	cr = cpu_rc_get(tsk);
+	if (!cr)
+		return slice;
+
+	if (jiffies - cr->last_recalc > CPU_RC_RECALC_INTERVAL)
+		cpu_rc_recalc_tsfactor(cr);
+
+	scaled = slice * cr->ts_factor / CPU_RC_TSFACTOR_MAX;
+	if (scaled == 0)
+		scaled = 1;
+
+	return scaled;
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
+	if (tsk == idle_task(task_cpu(tsk)))
+		return;
+
+	cr = cpu_rc_get(tsk);
+	if (!cr)
+		return;
+
+	base = now - tsk->ts_alloced;
+	if (base == 0)
+		return;  /* duration too small. can not collect statistics. */
+
+	tsk_load = CPU_RC_LOAD_SCALE * (tsk->last_slice - tsk->time_slice)
+		+ (CPU_RC_LOAD_SCALE / 2);
+	if (base > CPU_RC_SPREAD_PERIOD)
+		tsk_load = CPU_RC_SPREAD_PERIOD * tsk_load / base;
+
+	last = cr->stat[cpu].timestamp;
+	update = now - last;
+	if (update > CPU_RC_SPREAD_PERIOD)
+		load = 0;  /* statistics data obsolete. */
+	else
+		load = cr->stat[cpu].load * (CPU_RC_SPREAD_PERIOD - update);
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
+	if (tsk == idle_task(task_cpu(tsk)))
+		return;
+
+	if (tsk->last_activated == 0)
+		return;
+
+	cr = cpu_rc_get(tsk);
+	if (!cr) {
+		tsk->last_activated = 0;
+		return;
+	}
+
+	wait = jiffies - tsk->last_activated;
+	if (CPU_RC_GUAR_SCALE * tsk->last_slice	/ (wait + tsk->last_slice)
+			< cr->guarantee / cr->rcd->numcpus)
+		cr->stat[cpu].maybe_hungry++;
+
+	tsk->last_activated = 0;
+}
+
+int cpu_rc_task_is_starving(task_t *tsk)
+{
+	struct cpu_rc *cr = cpu_rc_get(tsk);
+
+	if (!cr)
+		return 0;
+
+	if (cr->rcd->numcrs == 1)
+		return 0;  /* alone in the rcd. no competing rcs. */
+
+	return (cr->is_hungry > CPU_RC_STARVE_THRESHOLD);
+}
+
+void cpu_rc_task_kept_active(task_t *tsk)
+{
+	struct cpu_rc *cr = cpu_rc_get(tsk);
+	int cpu = smp_processor_id();
+
+	if (!cr)
+		return;
+
+	cr->stat[cpu].maybe_hungry++;
+}
diff -urNp a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	2006-01-03 12:21:10.000000000 +0900
+++ b/kernel/sched.c	2006-02-09 08:55:53.000000000 +0900
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
+		timeslice = cpu_rc_scale_timeslice(p, timeslice);
+
+	return timeslice;
 }
 #define task_hot(p, now, sd) ((long long) ((now) - (p)->last_ran)	\
 				< (long long) (sd)->cache_hot_time)
@@ -720,6 +728,7 @@ static inline void dec_nr_running(task_t
  */
 static inline void __activate_task(task_t *p, runqueue_t *rq)
 {
+	cpu_rc_record_activated(p, jiffies);
 	enqueue_task(p, rq->active);
 	inc_nr_running(p, rq);
 }
@@ -1414,6 +1423,7 @@ int fastcall wake_up_state(task_t *p, un
 void fastcall sched_fork(task_t *p, int clone_flags)
 {
 	int cpu = get_cpu();
+	unsigned long now = jiffies;
 
 #ifdef CONFIG_SMP
 	cpu = sched_balance_self(cpu, SD_BALANCE_FORK);
@@ -1453,6 +1463,8 @@ void fastcall sched_fork(task_t *p, int 
 	p->first_time_slice = 1;
 	current->time_slice >>= 1;
 	p->timestamp = sched_clock();
+	cpu_rc_record_allocation(current, current->time_slice, now);
+	cpu_rc_record_allocation(p, p->time_slice, now);
 	if (unlikely(!current->time_slice)) {
 		/*
 		 * This case is rare, it happens when the parent has only
@@ -1510,6 +1522,7 @@ void fastcall wake_up_new_task(task_t *p
 				p->array = current->array;
 				p->array->nr_active++;
 				inc_nr_running(p, rq);
+				cpu_rc_record_activated(p, jiffies);
 			}
 			set_need_resched();
 		} else
@@ -1560,6 +1573,7 @@ void fastcall sched_exit(task_t *p)
 {
 	unsigned long flags;
 	runqueue_t *rq;
+	unsigned long now = jiffies;
 
 	/*
 	 * If the child was a (relative-) CPU hog then decrease
@@ -1570,6 +1584,8 @@ void fastcall sched_exit(task_t *p)
 		p->parent->time_slice += p->time_slice;
 		if (unlikely(p->parent->time_slice > task_timeslice(p)))
 			p->parent->time_slice = task_timeslice(p);
+		cpu_rc_record_allocation(p->parent,
+					 p->parent->time_slice, now);
 	}
 	if (p->sleep_avg < p->parent->sleep_avg)
 		p->parent->sleep_avg = p->parent->sleep_avg /
@@ -2646,6 +2662,7 @@ void scheduler_tick(void)
 	runqueue_t *rq = this_rq();
 	task_t *p = current;
 	unsigned long long now = sched_clock();
+	unsigned long jnow = jiffies;
 
 	update_cpu_clock(p, rq, now);
 
@@ -2680,6 +2697,9 @@ void scheduler_tick(void)
 			p->time_slice = task_timeslice(p);
 			p->first_time_slice = 0;
 			set_tsk_need_resched(p);
+#ifdef CONFIG_CPU_RC
+			/* XXX  need accounting even for rt_task? */
+#endif
 
 			/* put it at the end of the queue: */
 			requeue_task(p, rq->active);
@@ -2687,20 +2707,37 @@ void scheduler_tick(void)
 		goto out_unlock;
 	}
 	if (!--p->time_slice) {
+		int record_activated = 1;
+
 		dequeue_task(p, rq->active);
 		set_tsk_need_resched(p);
+		cpu_rc_account(p, jnow);
 		p->prio = effective_prio(p);
 		p->time_slice = task_timeslice(p);
 		p->first_time_slice = 0;
+		cpu_rc_record_allocation(p, p->time_slice, jnow);
 
 		if (!rq->expired_timestamp)
 			rq->expired_timestamp = jiffies;
 		if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq)) {
-			enqueue_task(p, rq->expired);
-			if (p->static_prio < rq->best_expired_prio)
-				rq->best_expired_prio = p->static_prio;
+			if (cpu_rc_task_is_starving(p)) {
+				/*
+				 * task is starving from the aspect of cpu_rc.
+				 * should keep scheduled.
+				 */
+				enqueue_task(p, rq->active);
+				cpu_rc_task_kept_active(p);
+				record_activated = 0;
+			} else {
+				enqueue_task(p, rq->expired);
+				if (p->static_prio < rq->best_expired_prio)
+					rq->best_expired_prio = p->static_prio;
+			}
 		} else
 			enqueue_task(p, rq->active);
+
+		if (record_activated)
+			cpu_rc_record_activated(p, jnow);
 	} else {
 		/*
 		 * Prevent a too long timeslice allowing a task to monopolize
@@ -3091,6 +3128,7 @@ switch_tasks:
 	rcu_qsctr_inc(task_cpu(prev));
 
 	update_cpu_clock(prev, rq, now);
+	cpu_rc_collect_hunger(next);
 
 	prev->sleep_avg -= run_time;
 	if ((long)prev->sleep_avg <= 0)
