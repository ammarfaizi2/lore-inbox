Return-Path: <linux-kernel-owner+w=401wt.eu-S932290AbXAPCVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbXAPCVj (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 21:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbXAPCVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 21:21:39 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:42147 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932290AbXAPCVi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 21:21:38 -0500
Date: Mon, 15 Jan 2007 18:23:25 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@elte.hu, tglx@linuxtronix.de, dipankar@in.ibm.com,
       rostedt@goodmis.org, billh@gnuppy.monkey.org,
       nielsen.esben@googlemail.com, tytso@us.ibm.com, dvhltc@us.ibm.com,
       corbet@lwn.net
Subject: [RFC PATCH -rt] RCU priority boosting that survives moderate testing
Message-ID: <20070116022324.GA28513@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This is a updated version of the earlier RCU-boosting patch
(http://lkml.org/lkml/2007/1/2/347).  It boosts the priority of RCU
read-side critical sections in -rt kernels, and the context diff is
almost 300 lines shorter than its predecessor.  Simplifications were
inspired by the act of attempting to design enterprise-level testing
for this patch's predecessor -- after all, you don't have to write tests
for any code that you manage to eliminate!

Still lacks tie-in to OOM, and still needs more vigorous testing (though
less so than its predecessor).  However, a design doc is on its way.

This version permits the system administrator to manually adjust the
priority of the RCU-booster task, which will result in RCU boosting
to the priority one slot less-favored than the booster task itself.
Any tasks that have been previously boosted will have their priority
adjusted to align with the RCU-booster task's new priority.

As always, any and all comments appreciated!

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---

 include/linux/init_task.h  |   12 +
 include/linux/rcupdate.h   |   12 +
 include/linux/rcupreempt.h |   19 +
 include/linux/sched.h      |   16 +
 init/main.c                |    1 
 kernel/Kconfig.preempt     |   32 ++
 kernel/fork.c              |    6 
 kernel/rcupreempt.c        |  536 +++++++++++++++++++++++++++++++++++++++++++++
 kernel/rtmutex.c           |    9 
 kernel/sched.c             |    5 
 10 files changed, 645 insertions(+), 3 deletions(-)

diff -urpNa -X dontdiff linux-2.6.20-rc4-rt1/include/linux/init_task.h linux-2.6.20-rc4-rt1-rcub/include/linux/init_task.h
--- linux-2.6.20-rc4-rt1/include/linux/init_task.h	2007-01-09 10:59:54.000000000 -0800
+++ linux-2.6.20-rc4-rt1-rcub/include/linux/init_task.h	2007-01-09 11:01:12.000000000 -0800
@@ -87,6 +87,17 @@ extern struct nsproxy init_nsproxy;
 	.siglock	= __SPIN_LOCK_UNLOCKED(sighand.siglock),	\
 }
 
+#ifdef CONFIG_PREEMPT_RCU_BOOST
+#define INIT_RCU_BOOST_PRIO .rcu_prio	= MAX_PRIO,
+#define INIT_PREEMPT_RCU_BOOST(tsk)					\
+	.rcub_rbdp	= NULL,						\
+	.rcub_state	= RCU_BOOST_IDLE,				\
+	.rcub_entry	= LIST_HEAD_INIT(tsk.rcub_entry),
+#else /* #ifdef CONFIG_PREEMPT_RCU_BOOST */
+#define INIT_RCU_BOOST_PRIO
+#define INIT_PREEMPT_RCU_BOOST(tsk)
+#endif /* #else #ifdef CONFIG_PREEMPT_RCU_BOOST */
+
 extern struct group_info init_groups;
 
 /*
@@ -143,6 +154,7 @@ extern struct group_info init_groups;
 	.pi_lock	= RAW_SPIN_LOCK_UNLOCKED(tsk.pi_lock),		\
 	INIT_TRACE_IRQFLAGS						\
 	INIT_LOCKDEP							\
+	INIT_PREEMPT_RCU_BOOST(tsk)					\
 }
 
 
diff -urpNa -X dontdiff linux-2.6.20-rc4-rt1/include/linux/rcupdate.h linux-2.6.20-rc4-rt1-rcub/include/linux/rcupdate.h
--- linux-2.6.20-rc4-rt1/include/linux/rcupdate.h	2007-01-09 10:59:54.000000000 -0800
+++ linux-2.6.20-rc4-rt1-rcub/include/linux/rcupdate.h	2007-01-09 11:01:12.000000000 -0800
@@ -227,6 +227,18 @@ extern void rcu_barrier(void);
 extern void rcu_init(void);
 extern void rcu_advance_callbacks(int cpu, int user);
 extern void rcu_check_callbacks(int cpu, int user);
+#ifdef CONFIG_PREEMPT_RCU_BOOST
+extern void init_rcu_boost_late(void);
+extern void __rcu_preempt_boost(void);
+#define rcu_preempt_boost() \
+	do { \
+		if (unlikely(current->rcu_read_lock_nesting > 0)) \
+			__rcu_preempt_boost(); \
+	} while (0)
+#else /* #ifdef CONFIG_PREEMPT_RCU_BOOST */
+#define init_rcu_boost_late()
+#define rcu_preempt_boost()
+#endif /* #else #ifdef CONFIG_PREEMPT_RCU_BOOST */
 
 #endif /* __KERNEL__ */
 #endif /* __LINUX_RCUPDATE_H */
diff -urpNa -X dontdiff linux-2.6.20-rc4-rt1/include/linux/rcupreempt.h linux-2.6.20-rc4-rt1-rcub/include/linux/rcupreempt.h
--- linux-2.6.20-rc4-rt1/include/linux/rcupreempt.h	2007-01-09 10:59:54.000000000 -0800
+++ linux-2.6.20-rc4-rt1-rcub/include/linux/rcupreempt.h	2007-01-09 11:01:12.000000000 -0800
@@ -42,6 +42,25 @@
 #include <linux/cpumask.h>
 #include <linux/seqlock.h>
 
+#ifdef CONFIG_PREEMPT_RCU_BOOST
+/*
+ * Task state with respect to being RCU-boosted.  This state is changed
+ * by the task itself in response to the following three events:
+ * 1. Preemption (or block on lock) while in RCU read-side critical section.
+ * 2. Outermost rcu_read_unlock() for blocked RCU read-side critical section.
+ *
+ * The RCU-boost task also updates the state when boosting priority.
+ */
+enum rcu_boost_state {
+	RCU_BOOST_IDLE = 0,	   /* Not yet blocked if in RCU read-side. */
+	RCU_BOOST_BLOCKED = 1,	   /* Blocked from RCU read-side. */
+	RCU_BOOSTED = 2,	   /* Boosting complete. */
+};
+
+#define N_RCU_BOOST_STATE (RCU_BOOSTED + 1)
+
+#endif /* #ifdef CONFIG_PREEMPT_RCU_BOOST */
+
 #define rcu_qsctr_inc(cpu)
 #define rcu_bh_qsctr_inc(cpu)
 #define call_rcu_bh(head, rcu) call_rcu(head, rcu)
diff -urpNa -X dontdiff linux-2.6.20-rc4-rt1/include/linux/sched.h linux-2.6.20-rc4-rt1-rcub/include/linux/sched.h
--- linux-2.6.20-rc4-rt1/include/linux/sched.h	2007-01-09 10:59:54.000000000 -0800
+++ linux-2.6.20-rc4-rt1-rcub/include/linux/sched.h	2007-01-09 11:01:12.000000000 -0800
@@ -699,6 +699,14 @@ struct signal_struct {
 #define is_rt_policy(p)		((p) != SCHED_NORMAL && (p) != SCHED_BATCH)
 #define has_rt_policy(p)	unlikely(is_rt_policy((p)->policy))
 
+#ifdef CONFIG_PREEMPT_RCU_BOOST
+#define set_rcu_prio(p, prio)  ((p)->rcu_prio = (prio))
+#define get_rcu_prio(p) ((p)->rcu_prio)
+#else /* #ifdef CONFIG_PREEMPT_RCU_BOOST */
+#define set_rcu_prio(p, prio)  do { } while (0)
+#define get_rcu_prio(p) MAX_PRIO
+#endif /* #else #ifdef CONFIG_PREEMPT_RCU_BOOST */
+
 /*
  * Some day this will be a full-fledged user tracking system..
  */
@@ -982,6 +990,9 @@ struct task_struct {
 #endif
 	int load_weight;	/* for niceness load balancing purposes */
 	int prio, static_prio, normal_prio;
+#ifdef CONFIG_PREEMPT_RCU_BOOST
+	int rcu_prio;
+#endif /* #ifdef CONFIG_PREEMPT_RCU_BOOST */
 	struct list_head run_list;
 	struct prio_array *array;
 
@@ -1003,6 +1014,11 @@ struct task_struct {
         atomic_t *rcu_flipctr1;
         atomic_t *rcu_flipctr2;
 #endif
+#ifdef CONFIG_PREEMPT_RCU_BOOST
+	struct rcu_boost_dat *rcub_rbdp;
+	enum rcu_boost_state rcub_state;
+	struct list_head rcub_entry;
+#endif /* #ifdef CONFIG_PREEMPT_RCU_BOOST */
 
 #if defined(CONFIG_SCHEDSTATS) || defined(CONFIG_TASK_DELAY_ACCT)
 	struct sched_info sched_info;
diff -urpNa -X dontdiff linux-2.6.20-rc4-rt1/init/main.c linux-2.6.20-rc4-rt1-rcub/init/main.c
--- linux-2.6.20-rc4-rt1/init/main.c	2007-01-09 10:59:54.000000000 -0800
+++ linux-2.6.20-rc4-rt1-rcub/init/main.c	2007-01-09 11:01:12.000000000 -0800
@@ -712,6 +712,7 @@ static void __init do_basic_setup(void)
 	init_workqueues();
 	usermodehelper_init();
 	driver_init();
+	init_rcu_boost_late();
 
 #ifdef CONFIG_SYSCTL
 	sysctl_init();
diff -urpNa -X dontdiff linux-2.6.20-rc4-rt1/kernel/Kconfig.preempt linux-2.6.20-rc4-rt1-rcub/kernel/Kconfig.preempt
--- linux-2.6.20-rc4-rt1/kernel/Kconfig.preempt	2007-01-09 10:59:54.000000000 -0800
+++ linux-2.6.20-rc4-rt1-rcub/kernel/Kconfig.preempt	2007-01-09 11:01:12.000000000 -0800
@@ -176,3 +176,35 @@ config RCU_TRACE
 
 	  Say Y here if you want to enable RCU tracing
 	  Say N if you are unsure.
+
+config PREEMPT_RCU_BOOST
+	bool "Enable priority boosting of RCU read-side critical sections"
+	depends on PREEMPT_RCU
+	default n
+	help
+	  This option permits priority boosting of RCU read-side critical
+	  sections that have been preempted in order to prevent indefinite
+	  delay of grace periods in face of runaway non-realtime processes.
+
+	  Say N if you are unsure.
+
+config PREEMPT_RCU_BOOST_STATS
+	bool "Enable RCU priority-boosting statistic printing"
+	depends on PREEMPT_RCU_BOOST
+	default n
+	help
+	  This option enables debug printk()s of RCU boost statistics,
+	  which are normally only used to debug RCU priority boost
+	  implementations.
+
+	  Say N if you are unsure.
+
+config PREEMPT_RCU_BOOST_STATS_INTERVAL
+	int "RCU priority-boosting statistic printing interval (seconds)"
+	depends on PREEMPT_RCU_BOOST_STATS
+	default 100
+	range 10 86400
+	help
+	  This option controls the timing of debug printk()s of RCU boost
+	  statistics, which are normally only used to debug RCU priority
+	  boost implementations.
diff -urpNa -X dontdiff linux-2.6.20-rc4-rt1/kernel/fork.c linux-2.6.20-rc4-rt1-rcub/kernel/fork.c
--- linux-2.6.20-rc4-rt1/kernel/fork.c	2007-01-09 10:59:54.000000000 -0800
+++ linux-2.6.20-rc4-rt1-rcub/kernel/fork.c	2007-01-09 11:01:12.000000000 -0800
@@ -1129,6 +1129,12 @@ static struct task_struct *copy_process(
 	p->softirq_context = 0;
 #endif
 	p->pagefault_disabled = 0;
+#ifdef CONFIG_PREEMPT_RCU_BOOST
+	p->rcu_prio = MAX_PRIO;
+	p->rcub_rbdp = NULL;
+	p->rcub_state = RCU_BOOST_IDLE;
+	INIT_LIST_HEAD(&p->rcub_entry);
+#endif
 #ifdef CONFIG_LOCKDEP
 	p->lockdep_depth = 0; /* no locks held yet */
 	p->curr_chain_key = 0;
diff -urpNa -X dontdiff linux-2.6.20-rc4-rt1/kernel/rcupreempt.c linux-2.6.20-rc4-rt1-rcub/kernel/rcupreempt.c
--- linux-2.6.20-rc4-rt1/kernel/rcupreempt.c	2007-01-09 10:59:54.000000000 -0800
+++ linux-2.6.20-rc4-rt1-rcub/kernel/rcupreempt.c	2007-01-09 19:22:53.000000000 -0800
@@ -49,6 +49,7 @@
 #include <linux/byteorder/swabb.h>
 #include <linux/cpumask.h>
 #include <linux/rcupreempt_trace.h>
+#include <linux/kthread.h>
 
 /*
  * PREEMPT_RCU data structures.
@@ -80,6 +81,534 @@ static struct rcu_ctrlblk rcu_ctrlblk = 
 static DEFINE_PER_CPU(atomic_t [2], rcu_flipctr) =
 	{ ATOMIC_INIT(0), ATOMIC_INIT(0) };
 
+#ifndef CONFIG_PREEMPT_RCU_BOOST
+static inline void init_rcu_boost_early(void) { }
+static inline void rcu_read_unlock_unboost(void) { }
+#else /* #ifndef CONFIG_PREEMPT_RCU_BOOST */
+
+/* Defines possible event indices for ->rbs_stats[] (first index). */
+
+#define RCU_BOOST_DAT_BLOCK	0
+#define RCU_BOOST_DAT_BOOST	1
+#define RCU_BOOST_DAT_UNLOCK	2
+#define N_RCU_BOOST_DAT_EVENTS	3
+
+/* RCU-boost per-CPU array element. */
+
+struct rcu_boost_dat {
+	raw_spinlock_t rbs_mutex;
+	struct list_head rbs_toboost;
+	struct list_head rbs_boosted;
+	long rbs_blocked;
+	long rbs_boost_attempt;
+	long rbs_boost;
+	long rbs_unlock;
+	long rbs_unboosted;
+#ifdef CONFIG_PREEMPT_RCU_BOOST_STATS
+	long rbs_stats[N_RCU_BOOST_DAT_EVENTS][N_RCU_BOOST_STATE + 1];
+#endif /* #ifdef CONFIG_PREEMPT_RCU_BOOST_STATS */
+};
+#define RCU_BOOST_ELEMENTS 4
+
+int rcu_boost_idx = -1; /* invalid value in case someone uses RCU early. */
+DEFINE_PER_CPU(struct rcu_boost_dat, rcu_boost_dat[RCU_BOOST_ELEMENTS]);
+static struct task_struct *rcu_boost_task = NULL;
+
+#ifdef CONFIG_PREEMPT_RCU_BOOST_STATS
+
+/*
+ * Function to increment indicated ->rbs_stats[] element.
+ */
+static inline void rcu_boost_dat_stat(struct rcu_boost_dat *rbdp,
+				      int event,
+				      enum rcu_boost_state oldstate)
+{
+	if (oldstate >= RCU_BOOST_IDLE &&
+	    oldstate <= RCU_BOOSTED) {
+		rbdp->rbs_stats[event][oldstate]++;
+	} else {
+		rbdp->rbs_stats[event][N_RCU_BOOST_STATE]++;
+	}
+}
+
+#define rcu_boost_dat_stat_block(rbdp, oldstate) \
+	rcu_boost_dat_stat(rbdp, RCU_BOOST_DAT_BLOCK, oldstate)
+#define rcu_boost_dat_stat_boost(rbdp, oldstate) \
+	rcu_boost_dat_stat(rbdp, RCU_BOOST_DAT_BOOST, oldstate)
+#define rcu_boost_dat_stat_unlock(rbdp, oldstate) \
+	rcu_boost_dat_stat(rbdp, RCU_BOOST_DAT_UNLOCK, oldstate)
+
+/*
+ * Prefix for kprint() strings for periodic statistics messages.
+ */
+static char *rcu_boost_state_event[] = {
+	"block:  ",
+	"boost:  ",
+	"unlock: ",
+};
+
+/*
+ * Indicators for numbers in kprint() strings.  "!" indicates a state-event
+ * pair that should not happen, while "?" indicates a state that should
+ * not happen.
+ */
+static char *rcu_boost_state_error[] = {
+       /*ibBe*/
+	"   ?",  /* block */
+	"!  ?",  /* boost */
+	"?  ?",  /* unlock */
+};
+
+/*
+ * Print out RCU booster task statistics at the specified interval.
+ */
+static void rcu_boost_dat_stat_print(void)
+{
+	char buf[N_RCU_BOOST_STATE * (sizeof(long) * 3 + 2) + 2];
+	int cpu;
+	int event;
+	int i;
+	static time_t lastprint = 0;
+	struct rcu_boost_dat *rbdp;
+	int state;
+	struct rcu_boost_dat sum;
+
+	/* Wait a graceful interval between printk spamming. */
+
+	if (xtime.tv_sec - lastprint <
+	    CONFIG_PREEMPT_RCU_BOOST_STATS_INTERVAL)
+		return;
+
+	/* Sum up the state/event-independent counters. */
+
+	sum.rbs_blocked = 0;
+	sum.rbs_boost_attempt = 0;
+	sum.rbs_boost = 0;
+	sum.rbs_unlock = 0;
+	sum.rbs_unboosted = 0;
+	for_each_possible_cpu(cpu)
+		for (i = 0; i < RCU_BOOST_ELEMENTS; i++) {
+			rbdp = per_cpu(rcu_boost_dat, cpu);
+			sum.rbs_blocked += rbdp[i].rbs_blocked;
+			sum.rbs_boost_attempt += rbdp[i].rbs_boost_attempt;
+			sum.rbs_boost += rbdp[i].rbs_boost;
+			sum.rbs_unlock += rbdp[i].rbs_unlock;
+			sum.rbs_unboosted += rbdp[i].rbs_unboosted;
+		}
+
+	/* Sum up the state/event-dependent counters. */
+
+	for (event = 0; event < N_RCU_BOOST_DAT_EVENTS; event++)
+		for (state = 0; state <= N_RCU_BOOST_STATE; state++) {
+			sum.rbs_stats[event][state] = 0;
+			for_each_possible_cpu(cpu) {
+				for (i = 0; i < RCU_BOOST_ELEMENTS; i++) {
+					sum.rbs_stats[event][state]
+					    += per_cpu(rcu_boost_dat,
+						       cpu)[i].rbs_stats[event][state];
+				}
+			}
+		}
+
+	/* Print them out! */
+
+	printk(KERN_ALERT
+	       "rcu_boost_dat: idx=%d "
+	       "b=%ld ul=%ld ub=%ld boost: a=%ld b=%ld\n",
+	       rcu_boost_idx,
+	       sum.rbs_blocked, sum.rbs_unlock, sum.rbs_unboosted,
+	       sum.rbs_boost_attempt, sum.rbs_boost);
+	for (event = 0; event < N_RCU_BOOST_DAT_EVENTS; event++) {
+		i = 0;
+		for (state = 0; state <= N_RCU_BOOST_STATE; state++) {
+			i += sprintf(&buf[i], " %ld%c",
+				     sum.rbs_stats[event][state],
+				     rcu_boost_state_error[event][state]);
+		}
+		printk(KERN_ALERT "rcu_boost_dat %s %s\n",
+		       rcu_boost_state_event[event], buf);
+	}
+
+	/* Go away and don't come back for awhile. */
+
+	lastprint = xtime.tv_sec;
+}
+
+#else /* #ifdef CONFIG_PREEMPT_RCU_BOOST_STATS */
+
+#define rcu_boost_dat_stat_block(rbdp, oldstate)
+#define rcu_boost_dat_stat_boost(rbdp, oldstate)
+#define rcu_boost_dat_stat_unlock(rbdp, oldstate)
+#define rcu_boost_dat_stat_print()
+
+#endif /* #else #ifdef CONFIG_PREEMPT_RCU_BOOST_STATS */
+
+/*
+ * Initialize RCU-boost state.  This happens early in the boot process,
+ * when the scheduler does not yet exist.  So don't try to use it.
+ */
+static void init_rcu_boost_early(void)
+{
+	struct rcu_boost_dat *rbdp;
+	int cpu;
+	int i;
+
+	for_each_possible_cpu(cpu) {
+		rbdp = per_cpu(rcu_boost_dat, cpu);
+		for (i = 0; i < RCU_BOOST_ELEMENTS; i++) {
+			rbdp[i].rbs_mutex =
+				RAW_SPIN_LOCK_UNLOCKED(rbdp[i].rbs_mutex);
+			INIT_LIST_HEAD(&rbdp[i].rbs_toboost);
+			INIT_LIST_HEAD(&rbdp[i].rbs_boosted);
+			rbdp[i].rbs_blocked = 0;
+			rbdp[i].rbs_boost_attempt = 0;
+			rbdp[i].rbs_boost = 0;
+			rbdp[i].rbs_unlock = 0;
+			rbdp[i].rbs_unboosted = 0;
+#ifdef CONFIG_PREEMPT_RCU_BOOST_STATS
+			{
+				int j, k;
+
+				for (j = 0; j < N_RCU_BOOST_DAT_EVENTS; j++)
+					for (k = 0; k <= N_RCU_BOOST_STATE; k++)
+						rbdp[i].rbs_stats[j][k] = 0;
+			}
+#endif /* #ifdef CONFIG_PREEMPT_RCU_BOOST_STATS */
+		}
+		smp_wmb();
+		rcu_boost_idx = 0;
+	}
+}
+
+/*
+ * Return the current boost index for boosting target tasks.
+ * May only be invoked by the booster task, so guaranteed to
+ * already be initialized.
+ */
+static inline int rcu_boost_idx_boosting(void)
+{
+	return (rcu_boost_idx + 1) & (RCU_BOOST_ELEMENTS - 1);
+}
+
+/*
+ * Return the list on which the calling task should add itself, or
+ * NULL if too early during initialization.
+ */
+static inline struct rcu_boost_dat *rcu_rbd_new(void)
+{
+	int cpu = raw_smp_processor_id();  /* locks used, so preemption OK. */
+	int idx = rcu_boost_idx;
+
+	smp_read_barrier_depends(); barrier();
+	if (unlikely(idx < 0))
+		return (NULL);
+	return &per_cpu(rcu_boost_dat, cpu)[idx];
+}
+
+/*
+ * Return the list from which to boost target tasks.
+ * May only be invoked by the booster task, so guaranteed to
+ * already be initialized.
+ */
+static inline struct rcu_boost_dat *rcu_rbd_boosting(int cpu)
+{
+	int idx = (rcu_boost_idx + 1) & (RCU_BOOST_ELEMENTS - 1);
+
+	return &per_cpu(rcu_boost_dat, cpu)[idx];
+}
+
+#define PREEMPT_RCU_BOOSTER_PRIO 49  /* Match curr_irq_prio manually. */
+			             /*  Administrators can always adjust */
+				     /*  via the /proc interface. */
+
+/*
+ * Boost the specified task from an RCU viewpoint.
+ * Boost the target task to a priority just a bit less-favored than
+ * that of the RCU-boost task, but boost to a realtime priority even
+ * if the RCU-boost task is running at a non-realtime priority.
+ * We check the priority of the RCU-boost task each time we boost
+ * in case the sysadm manually changes the priority.
+ */
+static void rcu_boost_prio(struct task_struct *taskp)
+{
+	unsigned long oldirq;
+	int rcuprio;
+
+	spin_lock_irqsave(&current->pi_lock, oldirq);
+	rcuprio = rt_mutex_getprio(current) + 1;
+	if (rcuprio >= MAX_USER_RT_PRIO)
+		rcuprio = MAX_USER_RT_PRIO - 1;
+	spin_unlock_irqrestore(&current->pi_lock, oldirq);
+	spin_lock_irqsave(&taskp->pi_lock, oldirq);
+	if (taskp->rcu_prio != rcuprio) {
+		taskp->rcu_prio = rcuprio;
+		if (taskp->rcu_prio != taskp->prio)
+			rt_mutex_setprio(taskp, taskp->rcu_prio);
+	}
+	spin_unlock_irqrestore(&taskp->pi_lock, oldirq);
+}
+
+/*
+ * Unboost the specified task from an RCU viewpoint.
+ */
+static void rcu_unboost_prio(struct task_struct *taskp)
+{
+	int nprio;
+	unsigned long oldirq;
+
+	spin_lock_irqsave(&taskp->pi_lock, oldirq);
+	taskp->rcu_prio = MAX_PRIO;
+	nprio = rt_mutex_getprio(taskp);
+	if (nprio > taskp->prio)
+		rt_mutex_setprio(taskp, nprio);
+	spin_unlock_irqrestore(&taskp->pi_lock, oldirq);
+}
+
+/*
+ * Boost all of the RCU-reader tasks on the specified list.
+ */
+static void rcu_boost_one_reader_list(struct rcu_boost_dat *rbdp)
+{
+	LIST_HEAD(list);
+	unsigned long oldirq;
+	struct task_struct *taskp;
+
+	/*
+	 * Splice both lists onto a local list.  We will still
+	 * need to hold the lock when manipulating the local list
+	 * because tasks can remove themselves at any time.
+	 * The reason for splicing the rbs_boosted list is that
+	 * our priority may have changed, so reboosting may be
+	 * required.
+	 */
+
+	spin_lock_irqsave(&rbdp->rbs_mutex, oldirq);
+	list_splice_init(&rbdp->rbs_toboost, &list);
+	list_splice_init(&rbdp->rbs_boosted, &list);
+	while (!list_empty(&list)) {
+
+		/*
+		 * Pause for a bit before boosting each task.
+		 * @@@FIXME: reduce/eliminate pausing in case of OOM.
+		 */
+
+		spin_unlock_irqrestore(&rbdp->rbs_mutex, oldirq);
+		schedule_timeout_uninterruptible(1);
+		spin_lock_irqsave(&rbdp->rbs_mutex, oldirq);
+
+		/*
+		 * All tasks might have removed themselves while
+		 * we were waiting.  Recheck list emptiness.
+		 */
+
+		if (list_empty(&list))
+			break;
+
+		/* Remove first task in local list, count the attempt. */
+
+		taskp = list_entry(list.next, typeof(*taskp), rcub_entry);
+		list_del_init(&taskp->rcub_entry);
+		rbdp->rbs_boost_attempt++;
+
+		/* Ignore tasks in unexpected states. */
+
+		if (taskp->rcub_state == RCU_BOOST_IDLE) {
+			list_add_tail(&taskp->rcub_entry, &rbdp->rbs_toboost);
+			rcu_boost_dat_stat_boost(rbdp, taskp->rcub_state);
+			continue;
+		}
+
+		/* Boost the task's priority. */
+
+		rcu_boost_prio(taskp);
+		taskp->rcub_state = RCU_BOOSTED;
+		rbdp->rbs_boost++;
+		rcu_boost_dat_stat_boost(rbdp, RCU_BOOST_BLOCKED);
+		list_add_tail(&taskp->rcub_entry, &rbdp->rbs_boosted);
+	}
+	spin_unlock_irqrestore(&rbdp->rbs_mutex, oldirq);
+}
+
+/*
+ * Priority-boost tasks stuck in RCU read-side critical sections as
+ * needed (presumably rarely).
+ */
+static int rcu_booster(void *arg)
+{
+	int cpu;
+	struct sched_param sp;
+
+	sp.sched_priority = PREEMPT_RCU_BOOSTER_PRIO;
+	sched_setscheduler(current, SCHED_RR, &sp);
+	current->flags |= PF_NOFREEZE;
+
+	do {
+
+		/* Advance the lists of tasks. */
+
+		rcu_boost_idx = (rcu_boost_idx + 1) % RCU_BOOST_ELEMENTS;
+		for_each_possible_cpu(cpu) {
+
+			/*
+			 * Boost all sufficiently aged readers.
+			 * Readers must first be preempted or block
+			 * on a mutex in an RCU read-side critical section,
+			 * then remain in that critical section for
+			 * RCU_BOOST_ELEMENTS-1 time intervals.
+			 * So most of the time we should end up doing
+			 * nothing.
+			 */
+
+			rcu_boost_one_reader_list(rcu_rbd_boosting(cpu));
+
+			/*
+			 * Large SMP systems may need to sleep sometimes
+			 * in this loop.  Or have multiple RCU-boost tasks.
+			 */
+		}
+
+		/*
+		 * Sleep to allow any unstalled RCU read-side critical
+		 * sections to age out of the list.  @@@ FIXME: reduce,
+		 * adjust, or eliminate in case of OOM.
+		 */
+
+		schedule_timeout_uninterruptible(HZ / 100);
+
+		/* Print stats if enough time has passed. */
+
+		rcu_boost_dat_stat_print();
+
+	} while (!kthread_should_stop());
+
+	return 0;
+}
+
+/*
+ * Perform the portions of RCU-boost initialization that require the
+ * scheduler to be up and running.
+ */
+void init_rcu_boost_late(void)
+{
+	int i;
+
+	/* Spawn RCU-boost task. */
+
+	printk(KERN_ALERT "Starting RCU priority booster\n");
+	rcu_boost_task = kthread_run(rcu_booster, NULL, "RCU Prio Booster");
+	if (IS_ERR(rcu_boost_task)) {
+		i = PTR_ERR(rcu_boost_task);
+		printk(KERN_ALERT
+		       "Unable to create RCU Priority Booster, errno %d\n", -i);
+
+		/*
+		 * Continue running, but tasks permanently blocked
+		 * in RCU read-side critical sections will be able
+		 * to stall grace-period processing, potentially
+		 * OOMing the machine.
+		 */
+
+		rcu_boost_task = NULL;
+	}
+}
+
+/*
+ * Update task's RCU-boost state to reflect blocking in RCU read-side
+ * critical section, so that the RCU-boost task can find it in case it
+ * later needs its priority boosted.
+ */
+void __rcu_preempt_boost(void)
+{
+	struct rcu_boost_dat *rbdp;
+	unsigned long oldirq;
+
+	/* Identify list to place task on for possible later boosting. */
+
+	local_irq_save(oldirq);
+	rbdp = rcu_rbd_new();
+	if (rbdp == NULL) {
+		local_irq_restore(oldirq);
+		printk("Preempted RCU read-side critical section too early.\n");
+		return;
+	}
+	spin_lock(&rbdp->rbs_mutex);
+	rbdp->rbs_blocked++;
+
+	/*
+	 * Update state.  We hold the lock and aren't yet on the list,
+	 * so the booster cannot mess with us yet.
+	 */
+
+	rcu_boost_dat_stat_block(rbdp, current->rcub_state);
+	if (current->rcub_state != RCU_BOOST_IDLE) {
+
+		/*
+		 * We have been here before, so just update stats.
+		 * It may seem strange to do all this work just to
+		 * accumulate statistics, but this is such a
+		 * low-probability code path that we shouldn't care.
+		 * If it becomes a problem, it can be fixed.
+		 */
+
+		spin_unlock_irqrestore(&rbdp->rbs_mutex, oldirq);
+		return;
+	}
+	current->rcub_state = RCU_BOOST_BLOCKED;
+
+	/* Now add ourselves to the list so that the booster can find use. */
+
+	list_add_tail(&current->rcub_entry, &rbdp->rbs_toboost);
+	current->rcub_rbdp = rbdp;
+	spin_unlock_irqrestore(&rbdp->rbs_mutex, oldirq);
+}
+
+/*
+ * Do the list-removal and priority-unboosting "heavy lifting" when
+ * required.
+ */
+static void __rcu_read_unlock_unboost(void)
+{
+	unsigned long oldirq;
+	struct rcu_boost_dat *rbdp;
+
+	/* Identify the list structure and acquire the corresponding lock. */
+
+	rbdp = current->rcub_rbdp;
+	spin_lock_irqsave(&rbdp->rbs_mutex, oldirq);
+
+	/* Remove task from the list it was on. */
+
+	list_del_init(&current->rcub_entry);
+	rbdp->rbs_unlock++;
+	current->rcub_rbdp = NULL;
+
+	/* Record stats, unboost if needed, and update state. */
+
+	rcu_boost_dat_stat_unlock(rbdp, current->rcub_state);
+	if (current->rcub_state == RCU_BOOSTED) {
+		rcu_unboost_prio(current);
+		rbdp->rbs_unboosted++;
+	}
+	current->rcub_state = RCU_BOOST_IDLE;
+	spin_unlock_irqrestore(&rbdp->rbs_mutex, oldirq);
+}
+
+/*
+ * Do any state changes and unboosting needed for rcu_read_unlock().
+ * Pass any complex work on to __rcu_read_unlock_unboost().
+ * The vast majority of the time, no work will be needed, as preemption
+ * and blocking within RCU read-side critical sections is comparatively
+ * rare.
+ */
+static inline void rcu_read_unlock_unboost(void)
+{
+
+	if (unlikely(current->rcub_state != RCU_BOOST_IDLE))
+		__rcu_read_unlock_unboost();
+}
+
+#endif /* #else #ifndef CONFIG_PREEMPT_RCU_BOOST */
+
 /*
  * Return the number of RCU batches processed thus far.  Useful
  * for debug and statistics.
@@ -155,6 +684,7 @@ void __rcu_read_unlock(void)
 			atomic_dec(current->rcu_flipctr2);
 			current->rcu_flipctr2 = NULL;
 		}
+		rcu_read_unlock_unboost();
 	}
 
 	local_irq_restore(oldirq);
@@ -345,6 +875,11 @@ int notrace rcu_pending(int cpu)
 		rcu_data.nextlist != NULL);
 }
 
+/*
+ * Initialize RCU.  This is called very early in boot, so is restricted
+ * to very simple operations.  Don't even think about messing with anything
+ * that involves the scheduler, as it doesn't exist yet.
+ */
 void __init __rcu_init(void)
 {
 /*&&&&*/printk("WARNING: experimental RCU implementation.\n");
@@ -356,6 +891,7 @@ void __init __rcu_init(void)
 	rcu_data.waittail = &rcu_data.waitlist;
 	rcu_data.donelist = NULL;
 	rcu_data.donetail = &rcu_data.donelist;
+	init_rcu_boost_early();
 	tasklet_init(&rcu_data.rcu_tasklet, rcu_process_callbacks, 0UL);
 }
 
diff -urpNa -X dontdiff linux-2.6.20-rc4-rt1/kernel/rtmutex.c linux-2.6.20-rc4-rt1-rcub/kernel/rtmutex.c
--- linux-2.6.20-rc4-rt1/kernel/rtmutex.c	2007-01-09 10:59:54.000000000 -0800
+++ linux-2.6.20-rc4-rt1-rcub/kernel/rtmutex.c	2007-01-09 11:01:12.000000000 -0800
@@ -105,11 +105,14 @@ static inline void init_lists(struct rt_
  */
 int rt_mutex_getprio(struct task_struct *task)
 {
+	int prio = task->normal_prio;
+
+	if (get_rcu_prio(task) < prio)
+		prio = get_rcu_prio(task);
 	if (likely(!task_has_pi_waiters(task)))
-		return task->normal_prio;
+		return prio;
 
-	return min(task_top_pi_waiter(task)->pi_list_entry.prio,
-		   task->normal_prio);
+	return min(task_top_pi_waiter(task)->pi_list_entry.prio, prio);
 }
 
 /*
diff -urpNa -X dontdiff linux-2.6.20-rc4-rt1/kernel/sched.c linux-2.6.20-rc4-rt1-rcub/kernel/sched.c
--- linux-2.6.20-rc4-rt1/kernel/sched.c	2007-01-09 10:59:54.000000000 -0800
+++ linux-2.6.20-rc4-rt1-rcub/kernel/sched.c	2007-01-09 11:01:12.000000000 -0800
@@ -1962,6 +1962,7 @@ void fastcall sched_fork(struct task_str
 	 * Make sure we do not leak PI boosting priority to the child:
 	 */
 	p->prio = current->normal_prio;
+	set_rcu_prio(p, MAX_PRIO);
 
 	INIT_LIST_HEAD(&p->run_list);
 	p->array = NULL;
@@ -2044,6 +2045,7 @@ void fastcall wake_up_new_task(struct ta
 			else {
 				p->prio = current->prio;
 				p->normal_prio = current->normal_prio;
+				set_rcu_prio(p, MAX_PRIO);
 				__activate_task_after(p, current, rq);
 			}
 			set_need_resched();
@@ -3986,6 +3988,8 @@ void __sched __schedule(void)
 	}
 	profile_hit(SCHED_PROFILING, __builtin_return_address(0));
 
+	rcu_preempt_boost();
+
 	preempt_disable(); // FIXME: disable irqs here
 	prev = current;
 	release_kernel_lock(prev);
@@ -5725,6 +5729,7 @@ void __cpuinit init_idle(struct task_str
 	idle->sleep_avg = 0;
 	idle->array = NULL;
 	idle->prio = idle->normal_prio = MAX_PRIO;
+	set_rcu_prio(idle, MAX_PRIO);
 	idle->state = TASK_RUNNING;
 	idle->cpus_allowed = cpumask_of_cpu(cpu);
 	set_task_cpu(idle, cpu);
