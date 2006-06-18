Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbWFRI1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbWFRI1E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 04:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbWFRI1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 04:27:04 -0400
Received: from omta02sl.mx.bigpond.com ([144.140.93.154]:33477 "EHLO
	omta02sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932162AbWFRI1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 04:27:02 -0400
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
Date: Sun, 18 Jun 2006 18:26:59 +1000
Message-Id: <20060618082659.6061.30435.sendpatchset@heathwren.pw.nest>
In-Reply-To: <20060618082638.6061.20172.sendpatchset@heathwren.pw.nest>
References: <20060618082638.6061.20172.sendpatchset@heathwren.pw.nest>
Subject: [PATCH 2/4] sched: Add CPU rate hard caps
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements hard CPU rate caps per task as a proportion of a
single CPU's capacity expressed in parts per thousand.

Notes:

1. Simplified calculation of sinbin durations to eliminat need for 64 bit
divide.

Signed-off-by: Peter Williams <pwil3058@bigpond.com.au>
 include/linux/sched.h |    8 ++
 kernel/Kconfig.caps   |   14 +++-
 kernel/sched.c        |  160 +++++++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 172 insertions(+), 10 deletions(-)

Index: MM-2.6.17-rc6-mm2/include/linux/sched.h
===================================================================
--- MM-2.6.17-rc6-mm2.orig/include/linux/sched.h	2006-06-14 11:08:40.000000000 +1000
+++ MM-2.6.17-rc6-mm2/include/linux/sched.h	2006-06-14 11:09:22.000000000 +1000
@@ -803,6 +803,10 @@ struct task_struct {
 	unsigned long long avg_cpu_per_cycle, avg_cycle_length;
 	unsigned int cpu_rate_cap;
 	unsigned int mutexes_held;
+#ifdef CONFIG_CPU_RATE_HARD_CAPS
+	unsigned int cpu_rate_hard_cap;
+	struct timer_list sinbin_timer;
+#endif
 #endif
 	enum sleep_type sleep_type;
 
@@ -1020,6 +1024,10 @@ struct task_struct {
 #ifdef CONFIG_CPU_RATE_CAPS
 unsigned int get_cpu_rate_cap(const struct task_struct *);
 int set_cpu_rate_cap(struct task_struct *, unsigned int);
+#ifdef CONFIG_CPU_RATE_HARD_CAPS
+unsigned int get_cpu_rate_hard_cap(const struct task_struct *);
+int set_cpu_rate_hard_cap(struct task_struct *, unsigned int);
+#endif
 #endif
 
 static inline pid_t process_group(struct task_struct *tsk)
Index: MM-2.6.17-rc6-mm2/kernel/Kconfig.caps
===================================================================
--- MM-2.6.17-rc6-mm2.orig/kernel/Kconfig.caps	2006-06-14 11:08:56.000000000 +1000
+++ MM-2.6.17-rc6-mm2/kernel/Kconfig.caps	2006-06-14 11:13:42.000000000 +1000
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
Index: MM-2.6.17-rc6-mm2/kernel/sched.c
===================================================================
--- MM-2.6.17-rc6-mm2.orig/kernel/sched.c	2006-06-14 11:08:40.000000000 +1000
+++ MM-2.6.17-rc6-mm2/kernel/sched.c	2006-06-14 11:09:23.000000000 +1000
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
@@ -3575,9 +3651,16 @@ need_resched_nonpreemptible:
 		}
 	}
 
-	/* do this now so that stats are correct for SMT code */
-	if (task_has_cap(prev))
+	if (task_has_cap(prev)) {
 		inc_cap_stats_both(prev, now);
+		if (task_has_hard_cap(prev) && !prev->state &&
+		    !rt_task(prev) && safe_to_sinbin(prev)) {
+			unsigned long sinbin_ticks = reqd_sinbin_ticks(prev);
+
+			if (sinbin_ticks)
+				sinbin_task(prev, sinbin_ticks);
+		}
+	}
 
 	cpu = smp_processor_id();
 	if (unlikely(!rq->nr_running)) {
@@ -4598,6 +4681,67 @@ out:
 }
 
 EXPORT_SYMBOL(set_cpu_rate_cap);
+
+#ifdef CONFIG_CPU_RATE_HARD_CAPS
+unsigned int get_cpu_rate_hard_cap(const struct task_struct *p)
+{
+	return p->cpu_rate_hard_cap;
+}
+
+EXPORT_SYMBOL(get_cpu_rate_hard_cap);
+
+/*
+ * Require: 1 <= new_cap <= CPU_CAP_ONE
+ */
+int set_cpu_rate_hard_cap(struct task_struct *p, unsigned int new_cap)
+{
+	int is_allowed;
+	unsigned long flags;
+	struct runqueue *rq;
+	int delta;
+
+	if (new_cap > CPU_CAP_ONE || new_cap < 1)
+		return -EINVAL;
+	is_allowed = capable(CAP_SYS_NICE);
+	/*
+	 * We have to be careful, if called from /proc code,
+	 * the task might be in the middle of scheduling on another CPU.
+	 */
+	rq = task_rq_lock(p, &flags);
+	delta = new_cap - p->cpu_rate_hard_cap;
+	if (!is_allowed) {
+		/*
+		 * Ordinary users can set/change caps on their own tasks
+		 * provided that the new setting is MORE constraining
+		 */
+		if (((current->euid != p->uid) && (current->uid != p->uid)) || (delta > 0)) {
+			task_rq_unlock(rq, &flags);
+			return -EPERM;
+		}
+	}
+	/*
+	 * The RT tasks don't have caps, but we still allow the caps to be
+	 * set - but as expected it wont have any effect on scheduling until
+	 * the task becomes SCHED_NORMAL/SCHED_BATCH:
+	 */
+	p->cpu_rate_hard_cap = new_cap;
+
+	if (has_rt_policy(p))
+		goto out;
+
+	if (p->array)
+		dec_raw_weighted_load(rq, p);
+	set_load_weight(p);
+	if (p->array)
+		inc_raw_weighted_load(rq, p);
+out:
+	task_rq_unlock(rq, &flags);
+
+	return 0;
+}
+
+EXPORT_SYMBOL(set_cpu_rate_hard_cap);
+#endif
 #endif
 
 long sched_setaffinity(pid_t pid, cpumask_t new_mask)

-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
 -- Ambrose Bierce
