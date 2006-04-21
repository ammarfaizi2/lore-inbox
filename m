Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbWDUC16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbWDUC16 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 22:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbWDUC15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 22:27:57 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:61924 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932119AbWDUC1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 22:27:51 -0400
From: maeda.naoaki@jp.fujitsu.com
To: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Cc: maeda.naoaki@jp.fujitsu.com
Date: Fri, 21 Apr 2006 11:27:37 +0900
Message-Id: <20060421022737.13598.67183.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
In-Reply-To: <20060421022727.13598.15397.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
References: <20060421022727.13598.15397.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
Subject: [RFC][PATCH 2/9] CPU controller - Adds class hungry detection
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2/9: cpurc_hungry_detection

This patch corresponds to section 2 in Documentation/ckrm/cpurc-internals,
adding the detection code that checks whether a task group needs more CPU
resource or not.  The CPU resource controller have to distinguish whether
tasks in the group actually need more resource or they are just sleepy.
If they need more resource, the resource controller must give more resource,
otherwise it must not.

Signed-off-by: Kurosawa Takahiro <kurosawa@valinux.co.jp>
Signed-off-by: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>

 include/linux/cpu_rc.h |   15 +++++++
 include/linux/sched.h  |    1 
 kernel/cpu_rc.c        |   96 +++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched.c         |    5 ++
 4 files changed, 117 insertions(+)

Index: linux-2.6.17-rc2/include/linux/cpu_rc.h
===================================================================
--- linux-2.6.17-rc2.orig/include/linux/cpu_rc.h
+++ linux-2.6.17-rc2/include/linux/cpu_rc.h
@@ -18,9 +18,13 @@
 #define CPU_RC_SPREAD_PERIOD	(10 * HZ)
 #define CPU_RC_LOAD_SCALE	(2 * CPU_RC_SPREAD_PERIOD)
 #define CPU_RC_SHARE_SCALE	100
+#define CPU_RC_TSFACTOR_MAX	CPU_RC_SHARE_SCALE
+#define CPU_RC_HCOUNT_INC	2
+#define CPU_RC_RECALC_INTERVAL	HZ
 
 struct cpu_rc_domain {
 	spinlock_t lock;
+ 	unsigned int hungry_count;
 	unsigned long timestamp;
 	cpumask_t cpus;
 	int numcpus;
@@ -28,16 +32,25 @@ struct cpu_rc_domain {
 };
 
 struct cpu_rc {
+	int share;
+	int is_hungry;
 	struct cpu_rc_domain *rcd;
 	struct {
 		unsigned long timestamp;
 		unsigned int load;
+		int maybe_hungry;
 	} stat[NR_CPUS];	/* XXX  need alignment */
 };
 
 extern struct cpu_rc *cpu_rc_get(task_t *);
 extern unsigned int cpu_rc_load(struct cpu_rc *);
 extern void cpu_rc_account(task_t *, unsigned long);
+extern void cpu_rc_detect_hunger(task_t *);
+
+static inline void cpu_rc_record_activated(task_t *tsk, unsigned long now)
+{
+	tsk->last_activated = now;
+}
 
 static inline void cpu_rc_record_allocation(task_t *tsk,
 					    unsigned int slice,
@@ -55,6 +68,8 @@ static inline void cpu_rc_record_allocat
 #else /* CONFIG_CPU_RC */
 
 static inline void cpu_rc_account(task_t *tsk, unsigned long now) {}
+static inline void cpu_rc_detect_hunger(task_t *tsk) {}
+static inline void cpu_rc_record_activated(task_t *tsk, unsigned long now) {}
 static inline void cpu_rc_record_allocation(task_t *tsk,
 					    unsigned int slice,
 					    unsigned long now) {}
Index: linux-2.6.17-rc2/include/linux/sched.h
===================================================================
--- linux-2.6.17-rc2.orig/include/linux/sched.h
+++ linux-2.6.17-rc2/include/linux/sched.h
@@ -895,6 +895,7 @@ struct task_struct {
 #ifdef CONFIG_CPU_RC
 	unsigned int last_slice;
 	unsigned long ts_alloced;
+	unsigned long last_activated;
 #endif
 };
 
Index: linux-2.6.17-rc2/kernel/cpu_rc.c
===================================================================
--- linux-2.6.17-rc2.orig/kernel/cpu_rc.c
+++ linux-2.6.17-rc2/kernel/cpu_rc.c
@@ -14,6 +14,72 @@
 #include <linux/sched.h>
 #include <linux/cpu_rc.h>
 
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
+/*
+ * cpu_rc_recalc_tsfactor() uptates the class timeslice scale factor
+ */
+static inline void cpu_rc_recalc_tsfactor(struct cpu_rc *cr)
+{
+	unsigned long now = jiffies;
+	unsigned long interval = now - cr->rcd->timestamp;
+	unsigned int load;
+	int maybe_hungry;
+	int i, n;
+
+	n = 0;
+	load = 0;
+	maybe_hungry = 0;
+
+	cpu_rcd_lock(cr);
+	if (cr->rcd->timestamp == 0)	{
+		cr->rcd->timestamp = now;
+	} else if (interval > CPU_RC_SPREAD_PERIOD) {
+		cr->rcd->hungry_count = 0;
+		cr->rcd->timestamp = now;
+	} else if (interval > CPU_RC_RECALC_INTERVAL) {
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
+	if ((load * CPU_RC_SHARE_SCALE >= cr->share * CPU_RC_LOAD_SCALE) ||
+	    !maybe_hungry)
+		cpu_rc_set_satisfied(cr);
+	else
+		cpu_rc_set_hungry(cr);
+
+	cpu_rcd_unlock(cr);
+}
+
 /*
  * cpu_rc_load() calculates the class load
  */
@@ -77,3 +143,33 @@ void cpu_rc_account(task_t *tsk, unsigne
 	cr->stat[cpu].timestamp = now;
 	cr->stat[cpu].load = (cls_load + tsk_load) / CPU_RC_SPREAD_PERIOD;
 }
+
+/*
+ * cpu_rc_detect_hunger() judges if the class is maybe hungry
+ */
+void cpu_rc_detect_hunger(task_t *tsk)
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
+	BUG_ON(tsk->last_slice == 0);
+	wait = jiffies - tsk->last_activated;
+	if (CPU_RC_GUAR_SCALE * tsk->last_slice	/ (wait + tsk->last_slice)
+			< cr->share)
+		cr->stat[cpu].maybe_hungry++;
+
+	tsk->last_activated = 0;
+}
Index: linux-2.6.17-rc2/kernel/sched.c
===================================================================
--- linux-2.6.17-rc2.orig/kernel/sched.c
+++ linux-2.6.17-rc2/kernel/sched.c
@@ -716,6 +716,7 @@ static void __activate_task(task_t *p, r
 
 	if (unlikely(batch_task(p) || (expired_starving(rq) && !rt_task(p))))
 		target = rq->expired;
+	cpu_rc_record_activated(p, jiffies);
 	enqueue_task(p, target);
 	rq->nr_running++;
 }
@@ -1478,6 +1479,7 @@ void fastcall wake_up_new_task(task_t *p
 				p->array = current->array;
 				p->array->nr_active++;
 				rq->nr_running++;
+				cpu_rc_record_activated(p, jiffies);
 			}
 			set_need_resched();
 		} else
@@ -2686,6 +2688,8 @@ void scheduler_tick(void)
 				rq->best_expired_prio = p->static_prio;
 		} else
 			enqueue_task(p, rq->active);
+
+		cpu_rc_record_activated(p, jnow);
 	} else {
 		/*
 		 * Prevent a too long timeslice allowing a task to monopolize
@@ -3079,6 +3083,7 @@ switch_tasks:
 	rcu_qsctr_inc(task_cpu(prev));
 
 	update_cpu_clock(prev, rq, now);
+	cpu_rc_detect_hunger(next);
 
 	prev->sleep_avg -= run_time;
 	if ((long)prev->sleep_avg <= 0)
