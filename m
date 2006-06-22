Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030500AbWFVBxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030500AbWFVBxG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 21:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030497AbWFVBxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 21:53:05 -0400
Received: from omta01ps.mx.bigpond.com ([144.140.82.153]:49596 "EHLO
	omta01ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1030502AbWFVBxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 21:53:02 -0400
From: Peter Williams <pwil3058@bigpond.net.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Con Kolivas <kernel@kolivas.org>, Sam Vilain <sam@vilain.net>,
       Balbir Singh <bsingharora@gmail.com>, Srivatsa <vatsa@in.ibm.com>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Kirill Korotaev <dev@openvz.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>, Kingsley Cheung <kingsley@aurema.com>,
       CKRM <ckrm-tech@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>
Date: Thu, 22 Jun 2006 11:52:59 +1000
Message-Id: <20060622015259.14498.48712.sendpatchset@heathwren.pw.nest>
In-Reply-To: <20060622015237.14498.37712.sendpatchset@heathwren.pw.nest>
References: <20060622015237.14498.37712.sendpatchset@heathwren.pw.nest>
Subject: [PATCH 2/4] sched: Add CPU rate hard caps
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements hard CPU rate caps per task as a proportion of a
single CPU's capacity expressed in parts per thousand.

Notes:

1. Simplified calculation of sinbin durations to eliminat need for 64 bit
divide.

Signed-off-by: Peter Williams <pwil3058@bigpond.net.au>
 include/linux/sched.h |   22 ++++++++-
 kernel/Kconfig.caps   |   14 +++++
 kernel/sched.c        |  117 +++++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 140 insertions(+), 13 deletions(-)

Index: MM-2.6.17-mm1/include/linux/sched.h
===================================================================
--- MM-2.6.17-mm1.orig/include/linux/sched.h	2006-06-22 10:21:08.000000000 +1000
+++ MM-2.6.17-mm1/include/linux/sched.h	2006-06-22 10:35:51.000000000 +1000
@@ -804,6 +804,10 @@ struct task_struct {
 	unsigned long long avg_cpu_per_cycle, avg_cycle_length;
 	unsigned int cpu_rate_cap;
 	unsigned int mutexes_held;
+#ifdef CONFIG_CPU_RATE_HARD_CAPS
+	unsigned int cpu_rate_hard_cap;
+	struct timer_list sinbin_timer;
+#endif
 #endif
 	enum sleep_type sleep_type;
 
@@ -1021,12 +1025,28 @@ struct task_struct {
 };
 
 #ifdef CONFIG_CPU_RATE_CAPS
+int set_cpu_rate_cap_low(struct task_struct *, unsigned int, int);
+
 static inline unsigned int get_cpu_rate_cap(const struct task_struct *p)
 {
 	return p->cpu_rate_cap;
 }
 
-int set_cpu_rate_cap(struct task_struct *, unsigned int);
+static inline int set_cpu_rate_cap(struct task_struct *p, unsigned int newcap)
+{
+	return set_cpu_rate_cap_low(p, newcap, 0);
+}
+#ifdef CONFIG_CPU_RATE_HARD_CAPS
+static inline unsigned int get_cpu_rate_hard_cap(const struct task_struct *p)
+{
+	return p->cpu_rate_hard_cap;
+}
+
+static inline int set_cpu_rate_hard_cap(struct task_struct *p, unsigned int newcap)
+{
+	return set_cpu_rate_cap_low(p, newcap, 1);
+}
+#endif
 #endif
 
 static inline pid_t process_group(struct task_struct *tsk)
Index: MM-2.6.17-mm1/kernel/Kconfig.caps
===================================================================
--- MM-2.6.17-mm1.orig/kernel/Kconfig.caps	2006-06-22 10:17:47.000000000 +1000
+++ MM-2.6.17-mm1/kernel/Kconfig.caps	2006-06-22 10:29:46.000000000 +1000
@@ -3,11 +3,21 @@
 #
 
 config CPU_RATE_CAPS
-	bool "Support (soft) CPU rate caps"
+	bool "Support CPU rate caps"
 	default y
 	---help---
-	  Say y here if you wish to be able to put a (soft) upper limit on
+	  Say y here if you wish to be able to put a soft upper limit on
 	  the rate of CPU usage by individual tasks.  A task which has been
 	  allocated a soft CPU rate cap will be limited to that rate of CPU
 	  usage unless there is spare CPU resources available after the needs
 	  of uncapped tasks are met.
+
+config CPU_RATE_HARD_CAPS
+	bool "Support CPU rate hard caps"
+	depends on CPU_RATE_CAPS
+	default n
+	---help---
+	  Say y here if you wish to be able to put a hard upper limit on
+	  the rate of CPU usage by individual tasks.  A task which has been
+	  allocated a hard CPU rate cap will be limited to that rate of CPU
+	  usage regardless of whether there is spare CPU resources available.
Index: MM-2.6.17-mm1/kernel/sched.c
===================================================================
--- MM-2.6.17-mm1.orig/kernel/sched.c	2006-06-22 10:26:24.000000000 +1000
+++ MM-2.6.17-mm1/kernel/sched.c	2006-06-22 10:32:15.000000000 +1000
@@ -203,25 +203,39 @@ static inline unsigned int task_timeslic
 #ifdef CONFIG_CPU_RATE_CAPS
 #define CPU_CAP_ONE 1000
 #define CAP_STATS_OFFSET 8
+#ifdef CONFIG_CPU_RATE_HARD_CAPS
+static void sinbin_release_fn(unsigned long arg);
+#define min_cpu_rate_cap(p) min((p)->cpu_rate_cap, (p)->cpu_rate_hard_cap)
+#else
+#define min_cpu_rate_cap(p) (p)->cpu_rate_cap
+#endif
 #define task_has_cap(p) unlikely((p)->flags & PF_HAS_CAP)
 /* this assumes that p is not a real time task */
 #define task_is_background(p) unlikely((p)->cpu_rate_cap == 0)
 #define task_being_capped(p) unlikely((p)->prio >= CAPPED_PRIO)
 #define cap_load_weight(p) \
-	(max((int)(((p)->cpu_rate_cap * SCHED_LOAD_SCALE) / CPU_CAP_ONE), 1))
+	(max((int)((min_cpu_rate_cap(p) * SCHED_LOAD_SCALE) / CPU_CAP_ONE), 1))
 #define safe_to_enforce_cap(p) \
-	(!((p)->mutexes_held || (p)->flags & (PF_FREEZE | PF_UIWAKE)))
+	(!((p)->mutexes_held || \
+	   (p)->flags & (PF_FREEZE | PF_UIWAKE | PF_EXITING)))
+#define safe_to_sinbin(p) (safe_to_enforce_cap(p) && !signal_pending(p))
 
 static void init_cpu_rate_caps(task_t *p)
 {
 	p->cpu_rate_cap = CPU_CAP_ONE;
 	p->flags &= ~PF_HAS_CAP;
 	p->mutexes_held = 0;
+#ifdef CONFIG_CPU_RATE_HARD_CAPS
+	p->cpu_rate_hard_cap = CPU_CAP_ONE;
+	init_timer(&p->sinbin_timer);
+	p->sinbin_timer.function = sinbin_release_fn;
+	p->sinbin_timer.data = (unsigned long) p;
+#endif
 }
 
 static inline void set_cap_flag(task_t *p)
 {
-	if (p->cpu_rate_cap < CPU_CAP_ONE && !has_rt_policy(p))
+	if (min_cpu_rate_cap(p) < CPU_CAP_ONE && !has_rt_policy(p))
 		p->flags |= PF_HAS_CAP;
 	else
 		p->flags &= ~PF_HAS_CAP;
@@ -229,7 +243,7 @@ static inline void set_cap_flag(task_t *
 
 static inline int task_exceeding_cap(const task_t *p)
 {
-	return (p->avg_cpu_per_cycle * CPU_CAP_ONE) > (p->avg_cycle_length * p->cpu_rate_cap);
+	return (p->avg_cpu_per_cycle * CPU_CAP_ONE) > (p->avg_cycle_length * min_cpu_rate_cap(p));
 }
 
 #ifdef CONFIG_SCHED_SMT
@@ -239,7 +253,7 @@ static inline int task_exceeding_cap(con
 static unsigned int smt_timeslice(task_t *p)
 {
 	if (task_being_capped(p))
-		return (p->cpu_rate_cap * DEF_TIMESLICE) / CPU_CAP_ONE;
+		return (min_cpu_rate_cap(p) * DEF_TIMESLICE) / CPU_CAP_ONE;
 
 	return task_timeslice(p);
 }
@@ -271,7 +285,7 @@ static int task_exceeding_cap_now(const 
 	unsigned long long cpc = p->avg_cpu_per_cycle;
 
 	delta = (now > p->timestamp) ? (now - p->timestamp) : 0;
-	rhs = (p->avg_cycle_length + delta) * p->cpu_rate_cap;
+	rhs = (p->avg_cycle_length + delta) * min_cpu_rate_cap(p);
 	if (oncpu)
 		cpc += delta;
 
@@ -283,6 +297,10 @@ static inline void init_cap_stats(task_t
 	p->avg_cpu_per_cycle = 0;
 	p->avg_cycle_length = 0;
 	p->mutexes_held = 0;
+#ifdef CONFIG_CPU_RATE_HARD_CAPS
+	init_timer(&p->sinbin_timer);
+	p->sinbin_timer.data = (unsigned long) p;
+#endif
 }
 
 static inline void inc_cap_stats_cycle(task_t *p, unsigned long long now)
@@ -315,6 +333,7 @@ static inline void decay_cap_stats(task_
 #define task_being_capped(p) 0
 #define cap_load_weight(p) ((int)SCHED_LOAD_SCALE)
 #define safe_to_enforce_cap(p) 0
+#define safe_to_sinbin(p) 0
 
 static inline void init_cpu_rate_caps(task_t *p)
 {
@@ -1192,6 +1211,63 @@ static void deactivate_task(struct task_
 	p->array = NULL;
 }
 
+#ifdef CONFIG_CPU_RATE_HARD_CAPS
+#define task_has_hard_cap(p) unlikely((p)->cpu_rate_hard_cap < CPU_CAP_ONE)
+
+/*
+ * Release a task from the sinbin
+ */
+static void sinbin_release_fn(unsigned long arg)
+{
+	unsigned long flags;
+	struct task_struct *p = (struct task_struct*)arg;
+	struct runqueue *rq = task_rq_lock(p, &flags);
+
+	p->prio = effective_prio(p);
+
+	__activate_task(p, rq);
+
+	task_rq_unlock(rq, &flags);
+}
+
+static unsigned long reqd_sinbin_ticks(const task_t *p)
+{
+	unsigned long long lhs = p->avg_cpu_per_cycle * CPU_CAP_ONE;
+	unsigned long long rhs = p->avg_cycle_length * p->cpu_rate_hard_cap;
+
+	if (lhs > rhs) {
+		lhs -= p->avg_cpu_per_cycle;
+		lhs >>= CAP_STATS_OFFSET;
+		/* have to do two divisions because there's no gaurantee
+		 * that p->cpu_rate_hard_cap * (1000000000 / HZ) would
+		 * not overflow a 32 bit unsigned integer
+		 */
+		(void)do_div(lhs, p->cpu_rate_hard_cap);
+		(void)do_div(lhs, (1000000000 / HZ));
+
+		return lhs ? : 1;
+	}
+
+	return 0;
+}
+
+static void sinbin_task(task_t *p, unsigned long durn)
+{
+	if (durn == 0)
+		return;
+	deactivate_task(p, task_rq(p));
+	p->sinbin_timer.expires = jiffies + durn;
+	add_timer(&p->sinbin_timer);
+}
+#else
+#define task_has_hard_cap(p) 0
+#define reqd_sinbin_ticks(p) 0
+
+static inline void sinbin_task(task_t *p, unsigned long durn)
+{
+}
+#endif
+
 /*
  * resched_task - mark a task 'to be rescheduled now'.
  *
@@ -3579,6 +3655,13 @@ need_resched_nonpreemptible:
 	if (task_has_cap(prev)) {
 		inc_cap_stats_both(prev, now);
 		decay_cap_stats(prev);
+		if (task_has_hard_cap(prev) && !prev->state &&
+		    !rt_task(prev) && safe_to_sinbin(prev)) {
+			unsigned long sinbin_ticks = reqd_sinbin_ticks(prev);
+
+			if (sinbin_ticks)
+				sinbin_task(prev, sinbin_ticks);
+		}
 	}
 
 	cpu = smp_processor_id();
@@ -4532,9 +4615,10 @@ out_unlock:
 
 #ifdef CONFIG_CPU_RATE_CAPS
 /*
- * Require: 0 <= new_cap <= CPU_CAP_ONE
+ * Require: 0 <= new_cap <= CPU_CAP_ONE for hard == 0
+ *          1 <= new_cap <= CPU_CAP_ONE otherwise
  */
-int set_cpu_rate_cap(struct task_struct *p, unsigned int new_cap)
+int set_cpu_rate_cap_low(struct task_struct *p, unsigned int new_cap, int hard)
 {
 	int is_allowed;
 	unsigned long flags;
@@ -4544,13 +4628,21 @@ int set_cpu_rate_cap(struct task_struct 
 
 	if (new_cap > CPU_CAP_ONE)
 		return -EINVAL;
+#ifdef CONFIG_CPU_RATE_HARD_CAPS
+	if (hard && new_cap < 1)
+		return -EINVAL;
+#endif
 	is_allowed = capable(CAP_SYS_NICE);
 	/*
 	 * We have to be careful, if called from /proc code,
 	 * the task might be in the middle of scheduling on another CPU.
 	 */
 	rq = task_rq_lock(p, &flags);
+#ifdef CONFIG_CPU_RATE_HARD_CAPS
+	delta = new_cap - (hard ? p->cpu_rate_hard_cap : p->cpu_rate_cap);
+#else
 	delta = new_cap - p->cpu_rate_cap;
+#endif
 	if (!is_allowed) {
 		/*
 		 * Ordinary users can set/change caps on their own tasks
@@ -4566,7 +4658,12 @@ int set_cpu_rate_cap(struct task_struct 
 	 * set - but as expected it wont have any effect on scheduling until
 	 * the task becomes SCHED_NORMAL/SCHED_BATCH:
 	 */
-	p->cpu_rate_cap = new_cap;
+#ifdef CONFIG_CPU_RATE_HARD_CAPS
+	if (hard)
+		p->cpu_rate_hard_cap = new_cap;
+	else
+#endif
+		p->cpu_rate_cap = new_cap;
 
 	if (has_rt_policy(p))
 		goto out;
@@ -4590,7 +4687,7 @@ out:
 	return 0;
 }
 
-EXPORT_SYMBOL(set_cpu_rate_cap);
+EXPORT_SYMBOL(set_cpu_rate_cap_low);
 #endif
 
 long sched_setaffinity(pid_t pid, cpumask_t new_mask)

-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
 -- Ambrose Bierce
