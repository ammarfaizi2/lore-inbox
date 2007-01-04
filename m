Return-Path: <linux-kernel-owner+w=401wt.eu-S965004AbXADQT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965004AbXADQT7 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 11:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965028AbXADQT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 11:19:59 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:34829 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965004AbXADQTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 11:19:55 -0500
Date: Thu, 4 Jan 2007 08:21:27 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: mingo@elte.hu, tglx@linuxtronix.de
Cc: linux-kernel@vger.kernel.org, tytso@us.ibm.com, dvhltc@us.ibm.com,
       dipankar@in.ibm.com, oleg@tv-sign.ru, twoerner.k@gmail.com,
       josh@freedesktop.org
Subject: Re: [RFC PATCH -rt] Almost-ready-for-prime-time RCU priority boosting
Message-ID: <20070104162127.GA5917@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20070103014423.GA16872@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070103014423.GA16872@linux.vnet.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 02, 2007 at 05:44:23PM -0800, Paul E. McKenney wrote:
> Hello!
> 
> An update to the long-standing need for priority boosting of RCU readers
> in -rt kernels.  This patch passes moderate testing, considerably more
> severe than that faced by previous versions.  Known shortcomings:
> 
> o	This patch has not yet been subjected to enterprise-level
> 	stress testing.  It therefore likely still contains a few bugs.
> 	My next step is to write some enterprise-level tests, probably
> 	as extensions to the RCU torture tests.

On the off-chance that someone is digging through this...  My first
attempt to design enterprise-level tests inspired me to come up with
some much-needed simplifications to this patch.  Who knows, the resulting
simplified code might actually work...

More later, either way.

							Thanx, Paul

> o	No tie-in to the OOM system.  Note that the RCU priority booster,
> 	unlike other subsystems that respond to OOM, takes action over
> 	a timeframe.  Boosting the priority of long-blocked RCU readers
> 	does not immediately complete the grace period, so the RCU priority
> 	booster needs to know the duration of the OOM event rather than
> 	just being told to free up memory immediately.  This likely also
> 	means that the RCU priority booster should be given early warning
> 	of impending OOM, so that it has the time it needs to react.
> 
> 	I have not worried much about this yet, since my belief is that
> 	the current approach will get the RCU callbacks processed in
> 	a timely manner in almost all cases.  However, the tie-in to
> 	OOM might be needed for small-memory systems.
> 
> o	Although the RCU priority booster's own priority is easily adjusted
> 	in a running kernel, it currently boosts blocked RCU readers
> 	to a fixed priority just below that of IRQ handler threads.
> 	This is straightforward and important, but I need to get all
> 	the bugs shaken out before worrying about ease of use.
> 
> o	A design document is needed.  This is on my list!
> 
> A couple of questions:
> 
> o	Currently, the rcu_boost_prio() and rcu_unboost_prio() functions
> 	are in kernel/rcupreempt.c, because this allows them to be
> 	declared as static.  But if I ignore the desire to declare them
> 	as static, I would instead put them into kernel/rt_mutex.c
> 	with the other priority-inheritance code.  Should I move them
> 	to kernel/rt_mutex.c?
> 
> o	It appears to me that one must always hold ->pi_lock when calling
> 	rt_mutex_setprio().  Is this really the case?  (If so, I will
> 	add words to this effect to its comment header.  And the longevity
> 	of my test kernels seemed to increase dramatically when I added
> 	this locking, for whatever that is worth.)
> 
> Anyway, here is the patch.  Any and all comments greatly appreciated.
> 
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> ---
> 
>  include/linux/init_task.h  |   13 
>  include/linux/rcupdate.h   |   14 
>  include/linux/rcupreempt.h |   30 +
>  include/linux/sched.h      |   17 
>  init/main.c                |    1 
>  kernel/Kconfig.preempt     |   32 +
>  kernel/exit.c              |    1 
>  kernel/fork.c              |    7 
>  kernel/rcupreempt.c        |  826 +++++++++++++++++++++++++++++++++++++++++++++
>  kernel/rtmutex.c           |    9 
>  kernel/sched.c             |    5 
>  11 files changed, 952 insertions(+), 3 deletions(-)
> 
> diff -urpNa -X dontdiff linux-2.6.19-rt12/include/linux/init_task.h linux-2.6.19-rt12-rcubpl/include/linux/init_task.h
> --- linux-2.6.19-rt12/include/linux/init_task.h	2006-12-22 21:21:42.000000000 -0800
> +++ linux-2.6.19-rt12-rcubpl/include/linux/init_task.h	2006-12-24 16:20:08.000000000 -0800
> @@ -86,6 +86,18 @@ extern struct nsproxy init_nsproxy;
>  	.siglock	= __SPIN_LOCK_UNLOCKED(sighand.siglock),	\
>  }
>  
> +#ifdef CONFIG_PREEMPT_RCU_BOOST
> +#define INIT_RCU_BOOST_PRIO .rcu_prio	= MAX_PRIO,
> +#define INIT_PREEMPT_RCU_BOOST(tsk)					\
> +	.rcub_rbdp	= NULL,						\
> +	.rcub_state	= RCU_BOOST_IDLE,				\
> +	.rcub_entry	= LIST_HEAD_INIT(tsk.rcub_entry),		\
> +	.rcub_rbdp_wq	= NULL,
> +#else /* #ifdef CONFIG_PREEMPT_RCU_BOOST */
> +#define INIT_RCU_BOOST_PRIO
> +#define INIT_PREEMPT_RCU_BOOST(tsk)
> +#endif /* #else #ifdef CONFIG_PREEMPT_RCU_BOOST */
> +
>  extern struct group_info init_groups;
>  
>  /*
> @@ -142,6 +154,7 @@ extern struct group_info init_groups;
>  	.pi_lock	= RAW_SPIN_LOCK_UNLOCKED(tsk.pi_lock),		\
>  	INIT_TRACE_IRQFLAGS						\
>  	INIT_LOCKDEP							\
> +	INIT_PREEMPT_RCU_BOOST(tsk)					\
>  }
>  
>  
> diff -urpNa -X dontdiff linux-2.6.19-rt12/include/linux/rcupdate.h linux-2.6.19-rt12-rcubpl/include/linux/rcupdate.h
> --- linux-2.6.19-rt12/include/linux/rcupdate.h	2006-12-22 21:21:42.000000000 -0800
> +++ linux-2.6.19-rt12-rcubpl/include/linux/rcupdate.h	2006-12-24 23:27:52.000000000 -0800
> @@ -227,6 +227,20 @@ extern void rcu_barrier(void);
>  extern void rcu_init(void);
>  extern void rcu_advance_callbacks(int cpu, int user);
>  extern void rcu_check_callbacks(int cpu, int user);
> +#ifdef CONFIG_PREEMPT_RCU_BOOST
> +extern void init_rcu_boost_late(void);
> +extern void rcu_exit_wait(void);
> +extern void __rcu_preempt_boost(void);
> +#define rcu_preempt_boost() \
> +	do { \
> +		if (unlikely(current->rcu_read_lock_nesting > 0)) \
> +			__rcu_preempt_boost(); \
> +	} while (0)
> +#else /* #ifdef CONFIG_PREEMPT_RCU_BOOST */
> +#define init_rcu_boost_late()
> +#define rcu_exit_wait()
> +#define rcu_preempt_boost()
> +#endif /* #else #ifdef CONFIG_PREEMPT_RCU_BOOST */
>  
>  #endif /* __KERNEL__ */
>  #endif /* __LINUX_RCUPDATE_H */
> diff -urpNa -X dontdiff linux-2.6.19-rt12/include/linux/rcupreempt.h linux-2.6.19-rt12-rcubpl/include/linux/rcupreempt.h
> --- linux-2.6.19-rt12/include/linux/rcupreempt.h	2006-12-22 21:21:42.000000000 -0800
> +++ linux-2.6.19-rt12-rcubpl/include/linux/rcupreempt.h	2006-12-24 23:46:50.000000000 -0800
> @@ -42,6 +42,36 @@
>  #include <linux/cpumask.h>
>  #include <linux/seqlock.h>
>  
> +#ifdef CONFIG_PREEMPT_RCU_BOOST
> +/*
> + * Task state with respect to being RCU-boosted.  This state is changed
> + * by the task itself in response to the following three events:
> + * 1. Preemption (or block on lock) while in RCU read-side critical section.
> + * 2. Outermost rcu_read_unlock() for blocked RCU read-side critical section.
> + * 3. exit() processing.
> + *
> + * The RCU-boost task also updates the state on the following events:
> + * 1. Starting to boost this task's priority.
> + * 2. Finishing boosting this task's priority.
> + * 3. Unboosting this task's priority (due to race with rcu_read_unlock()).
> + *
> + * The following values are chosen to make the update macros work.
> + */
> +enum rcu_boost_state {
> +	RCU_BOOST_IDLE = 0,	   /* Not yet blocked if in RCU read-side. */
> +	RCU_BOOST_BLOCKED = 1,	   /* Blocked from RCU read-side. */
> +	RCU_BOOSTED = 2,	   /* Boosting complete. */
> +	RCU_EXIT_OK = 3,	   /* Can complete exit(). */
> +	RCU_UNBOOST_IDLE = 4,	   /* Waiting for unboost. */
> +	RCU_UNBOOST_BLOCKED = 5,   /* Blocked while waiting for unlock. */
> +	RCU_BOOSTING = 6,	   /* Boost started, not yet complete. */
> +	RCU_UNBOOST_EXITING = 7    /* Waiting for unboost during exit(). */
> +};
> +
> +#define N_RCU_BOOST_STATE (RCU_UNBOOST_EXITING + 1)
> +
> +#endif /* #ifdef CONFIG_PREEMPT_RCU_BOOST */
> +
>  #define rcu_qsctr_inc(cpu)
>  #define rcu_bh_qsctr_inc(cpu)
>  #define call_rcu_bh(head, rcu) call_rcu(head, rcu)
> diff -urpNa -X dontdiff linux-2.6.19-rt12/include/linux/sched.h linux-2.6.19-rt12-rcubpl/include/linux/sched.h
> --- linux-2.6.19-rt12/include/linux/sched.h	2006-12-22 21:21:42.000000000 -0800
> +++ linux-2.6.19-rt12-rcubpl/include/linux/sched.h	2006-12-24 23:31:23.000000000 -0800
> @@ -668,6 +668,14 @@ struct signal_struct {
>  #define is_rt_policy(p)		((p) != SCHED_NORMAL && (p) != SCHED_BATCH)
>  #define has_rt_policy(p)	unlikely(is_rt_policy((p)->policy))
>  
> +#ifdef CONFIG_PREEMPT_RCU_BOOST
> +#define set_rcu_prio(p, prio)  ((p)->rcu_prio = (prio))
> +#define get_rcu_prio(p) ((p)->rcu_prio)
> +#else /* #ifdef CONFIG_PREEMPT_RCU_BOOST */
> +#define set_rcu_prio(p, prio)  do { } while (0)
> +#define get_rcu_prio(p) MAX_PRIO
> +#endif /* #else #ifdef CONFIG_PREEMPT_RCU_BOOST */
> +
>  /*
>   * Some day this will be a full-fledged user tracking system..
>   */
> @@ -950,6 +958,9 @@ struct task_struct {
>  #endif
>  	int load_weight;	/* for niceness load balancing purposes */
>  	int prio, static_prio, normal_prio;
> +#ifdef CONFIG_PREEMPT_RCU_BOOST
> +	int rcu_prio;
> +#endif /* #ifdef CONFIG_PREEMPT_RCU_BOOST */
>  	struct list_head run_list;
>  	struct prio_array *array;
>  
> @@ -971,6 +982,12 @@ struct task_struct {
>          atomic_t *rcu_flipctr1;
>          atomic_t *rcu_flipctr2;
>  #endif
> +#ifdef CONFIG_PREEMPT_RCU_BOOST
> +	struct rcu_boost_dat *rcub_rbdp;
> +	enum rcu_boost_state rcub_state;
> +	struct list_head rcub_entry;
> +	struct rcu_boost_dat *rcub_rbdp_wq;
> +#endif /* #ifdef CONFIG_PREEMPT_RCU_BOOST */
>  
>  #if defined(CONFIG_SCHEDSTATS) || defined(CONFIG_TASK_DELAY_ACCT)
>  	struct sched_info sched_info;
> diff -urpNa -X dontdiff linux-2.6.19-rt12/init/main.c linux-2.6.19-rt12-rcubpl/init/main.c
> --- linux-2.6.19-rt12/init/main.c	2006-12-22 21:21:42.000000000 -0800
> +++ linux-2.6.19-rt12-rcubpl/init/main.c	2006-12-22 21:24:14.000000000 -0800
> @@ -692,6 +692,7 @@ static void __init do_basic_setup(void)
>  	init_workqueues();
>  	usermodehelper_init();
>  	driver_init();
> +	init_rcu_boost_late();
>  
>  #ifdef CONFIG_SYSCTL
>  	sysctl_init();
> diff -urpNa -X dontdiff linux-2.6.19-rt12/kernel/exit.c linux-2.6.19-rt12-rcubpl/kernel/exit.c
> --- linux-2.6.19-rt12/kernel/exit.c	2006-12-22 21:21:42.000000000 -0800
> +++ linux-2.6.19-rt12-rcubpl/kernel/exit.c	2006-12-24 17:46:57.000000000 -0800
> @@ -955,6 +955,7 @@ fastcall NORET_TYPE void do_exit(long co
>  		exit_pi_state_list(tsk);
>  	if (unlikely(current->pi_state_cache))
>  		kfree(current->pi_state_cache);
> +	rcu_exit_wait();
>  	/*
>  	 * Make sure we are holding no locks:
>  	 */
> diff -urpNa -X dontdiff linux-2.6.19-rt12/kernel/fork.c linux-2.6.19-rt12-rcubpl/kernel/fork.c
> --- linux-2.6.19-rt12/kernel/fork.c	2006-12-22 21:21:42.000000000 -0800
> +++ linux-2.6.19-rt12-rcubpl/kernel/fork.c	2006-12-24 23:44:03.000000000 -0800
> @@ -1124,6 +1124,13 @@ static struct task_struct *copy_process(
>  	p->hardirq_context = 0;
>  	p->softirq_context = 0;
>  #endif
> +#ifdef CONFIG_PREEMPT_RCU_BOOST
> +	p->rcu_prio = MAX_PRIO;
> +	p->rcub_rbdp = NULL;
> +	p->rcub_state = RCU_BOOST_IDLE;
> +	INIT_LIST_HEAD(&p->rcub_entry);
> +	p->rcub_rbdp_wq = NULL;
> +#endif
>  #ifdef CONFIG_LOCKDEP
>  	p->lockdep_depth = 0; /* no locks held yet */
>  	p->curr_chain_key = 0;
> diff -urpNa -X dontdiff linux-2.6.19-rt12/kernel/Kconfig.preempt linux-2.6.19-rt12-rcubpl/kernel/Kconfig.preempt
> --- linux-2.6.19-rt12/kernel/Kconfig.preempt	2006-12-22 21:21:42.000000000 -0800
> +++ linux-2.6.19-rt12-rcubpl/kernel/Kconfig.preempt	2006-12-22 21:24:14.000000000 -0800
> @@ -176,3 +176,35 @@ config RCU_TRACE
>  
>  	  Say Y here if you want to enable RCU tracing
>  	  Say N if you are unsure.
> +
> +config PREEMPT_RCU_BOOST
> +	bool "Enable priority boosting of RCU read-side critical sections"
> +	depends on PREEMPT_RCU
> +	default n
> +	help
> +	  This option permits priority boosting of RCU read-side critical
> +	  sections that have been preempted in order to prevent indefinite
> +	  delay of grace periods in face of runaway non-realtime processes.
> +
> +	  Say N if you are unsure.
> +
> +config PREEMPT_RCU_BOOST_STATS
> +	bool "Enable RCU priority-boosting statistic printing"
> +	depends on PREEMPT_RCU_BOOST
> +	default n
> +	help
> +	  This option enables debug printk()s of RCU boost statistics,
> +	  which are normally only used to debug RCU priority boost
> +	  implementations.
> +
> +	  Say N if you are unsure.
> +
> +config PREEMPT_RCU_BOOST_STATS_INTERVAL
> +	int "RCU priority-boosting statistic printing interval (seconds)"
> +	depends on PREEMPT_RCU_BOOST_STATS
> +	default 100
> +	range 10 86400
> +	help
> +	  This option controls the timing of debug printk()s of RCU boost
> +	  statistics, which are normally only used to debug RCU priority
> +	  boost implementations.
> diff -urpNa -X dontdiff linux-2.6.19-rt12/kernel/rcupreempt.c linux-2.6.19-rt12-rcubpl/kernel/rcupreempt.c
> --- linux-2.6.19-rt12/kernel/rcupreempt.c	2006-12-22 21:21:42.000000000 -0800
> +++ linux-2.6.19-rt12-rcubpl/kernel/rcupreempt.c	2007-01-01 16:22:10.000000000 -0800
> @@ -49,6 +49,7 @@
>  #include <linux/byteorder/swabb.h>
>  #include <linux/cpumask.h>
>  #include <linux/rcupreempt_trace.h>
> +#include <linux/kthread.h>
>  
>  /*
>   * PREEMPT_RCU data structures.
> @@ -80,6 +81,824 @@ static struct rcu_ctrlblk rcu_ctrlblk = 
>  static DEFINE_PER_CPU(atomic_t [2], rcu_flipctr) =
>  	{ ATOMIC_INIT(0), ATOMIC_INIT(0) };
>  
> +#ifndef CONFIG_PREEMPT_RCU_BOOST
> +static inline void init_rcu_boost_early(void) { }
> +static inline void rcu_read_unlock_unboost(void) { }
> +#else /* #ifndef CONFIG_PREEMPT_RCU_BOOST */
> +
> +/* Macros operating on enum rcu_boost_state to handle state transitions. */
> +
> +#define RCU_BOOST_STATE_BLOCKED(s) ((s) + 1)
> +#define RCU_BOOST_STATE_RCU_READ_UNLOCK(s) ((s) & ~0x3)
> +#define RCU_BOOST_STATE_EXIT(s) ((s) + 3)
> +#define RCU_BOOST_STATE_UNBOOST(s) ((s) - 4)
> +
> +/* Defines possible event indices for ->rbs_stats[] (first index). */
> +
> +#define RCU_BOOST_DAT_BLOCK	0
> +#define RCU_BOOST_DAT_BOOST	1
> +#define RCU_BOOST_DAT_UNBOOST	2
> +#define RCU_BOOST_DAT_UNLOCK	3
> +#define RCU_BOOST_DAT_EXIT	4
> +#define N_RCU_BOOST_DAT_EVENTS	5
> +
> +/* RCU-boost per-CPU array element. */
> +
> +struct rcu_boost_dat {
> +	raw_spinlock_t rbs_mutex;
> +	struct list_head rbs_toboost;
> +	struct list_head rbs_boosted;
> +	wait_queue_head_t rbs_target_wq;
> +	wait_queue_head_t rbs_booster_wq;
> +	int rbs_exit_done;
> +	long rbs_blocked;
> +	long rbs_boost_attempt;
> +	long rbs_boost_wrongstate;
> +	long rbs_boost_cmpxchgfail;
> +	long rbs_boost_start;
> +	long rbs_boost_end;
> +	long rbs_unlock;
> +	long rbs_unboosted;
> +#ifdef CONFIG_PREEMPT_RCU_BOOST_STATS
> +	long rbs_stats[N_RCU_BOOST_DAT_EVENTS][N_RCU_BOOST_STATE + 1];
> +#endif /* #ifdef CONFIG_PREEMPT_RCU_BOOST_STATS */
> +};
> +#define RCU_BOOST_ELEMENTS 4
> +
> +int rcu_boost_idx = -1; /* invalid value in case someone uses RCU early. */
> +DEFINE_PER_CPU(struct rcu_boost_dat, rcu_boost_dat[RCU_BOOST_ELEMENTS]);
> +static struct task_struct *rcu_boost_task = NULL;
> +
> +#ifdef CONFIG_PREEMPT_RCU_BOOST_STATS
> +
> +/*
> + * Function to increment indicated ->rbs_stats[] element.
> + */
> +static inline void rcu_boost_dat_stat(struct rcu_boost_dat *rbdp,
> +				      int event,
> +				      enum rcu_boost_state oldstate)
> +{
> +	if (oldstate >= RCU_BOOST_IDLE &&
> +	    oldstate <= RCU_UNBOOST_EXITING) {
> +		rbdp->rbs_stats[event][oldstate]++;
> +	} else {
> +		rbdp->rbs_stats[event][N_RCU_BOOST_STATE]++;
> +	}
> +}
> +
> +#define rcu_boost_dat_stat_block(rbdp, oldstate) \
> +	rcu_boost_dat_stat(rbdp, RCU_BOOST_DAT_BLOCK, oldstate)
> +#define rcu_boost_dat_stat_boost(rbdp, oldstate) \
> +	rcu_boost_dat_stat(rbdp, RCU_BOOST_DAT_BOOST, oldstate)
> +#define rcu_boost_dat_stat_unboost(rbdp, oldstate) \
> +	rcu_boost_dat_stat(rbdp, RCU_BOOST_DAT_UNBOOST, oldstate)
> +#define rcu_boost_dat_stat_unlock(rbdp, oldstate) \
> +	rcu_boost_dat_stat(rbdp, RCU_BOOST_DAT_UNLOCK, oldstate)
> +#define rcu_boost_dat_stat_exit(rbdp, oldstate) \
> +	do { \
> +		if (rbdp != NULL) \
> +			rcu_boost_dat_stat(rbdp, RCU_BOOST_DAT_EXIT, oldstate); \
> +	} while (0)
> +
> +/*
> + * Prefix for kprint() strings for periodic statistics messages.
> + */
> +static char *rcu_boost_state_event[] = {
> +	"block:",
> +	"boost:  ",
> +	"unboost:",
> +	"unlock: ",
> +	"exit:   ",
> +};
> +
> +/*
> + * Indicators for numbers in kprint() strings.  "!" indicates a state-event
> + * pair that should not happen, while "?" indicates a state that should
> + * not happen.
> + */
> +static char *rcu_boost_state_error[] = {
> +       /*ibDEIB^e*/
> +	"   !  !!?",  /* block */
> +	"! !!!!! ?",  /* boost */
> +	"!!!!    ?",  /* unboost */
> +	"   !   !?",  /* unlock */
> +	" !!! !!!?",  /* exit */
> +};
> +
> +/*
> + * Print out RCU booster task statistics at the specified interval.
> + */
> +static void rcu_boost_dat_stat_print(void)
> +{
> +	char buf[N_RCU_BOOST_STATE * (sizeof(long) * 3 + 2) + 2];
> +	int cpu;
> +	int event;
> +	int i;
> +	static time_t lastprint = 0;
> +	struct rcu_boost_dat *rbdp;
> +	int state;
> +	struct rcu_boost_dat sum;
> +
> +	/* Wait a graceful interval between printk spamming. */
> +
> +	if (xtime.tv_sec - lastprint <
> +	    CONFIG_PREEMPT_RCU_BOOST_STATS_INTERVAL)
> +		return;
> +
> +	/* Sum up the state/event-independent counters. */
> +
> +	sum.rbs_blocked = 0;
> +	sum.rbs_boost_attempt = 0;
> +	sum.rbs_boost_wrongstate = 0;
> +	sum.rbs_boost_cmpxchgfail = 0;
> +	sum.rbs_boost_start = 0;
> +	sum.rbs_boost_end = 0;
> +	sum.rbs_unlock = 0;
> +	sum.rbs_unboosted = 0;
> +	for_each_possible_cpu(cpu)
> +		for (i = 0; i < RCU_BOOST_ELEMENTS; i++) {
> +			rbdp = per_cpu(rcu_boost_dat, cpu);
> +			sum.rbs_blocked += rbdp[i].rbs_blocked;
> +			sum.rbs_boost_attempt += rbdp[i].rbs_boost_attempt;
> +			sum.rbs_boost_wrongstate +=
> +				rbdp[i].rbs_boost_wrongstate;
> +			sum.rbs_boost_cmpxchgfail +=
> +				rbdp[i].rbs_boost_cmpxchgfail;
> +			sum.rbs_boost_start += rbdp[i].rbs_boost_start;
> +			sum.rbs_boost_end += rbdp[i].rbs_boost_end;
> +			sum.rbs_unlock += rbdp[i].rbs_unlock;
> +			sum.rbs_unboosted += rbdp[i].rbs_unboosted;
> +		}
> +
> +	/* Sum up the state/event-dependent counters. */
> +
> +	for (event = 0; event < N_RCU_BOOST_DAT_EVENTS; event++)
> +		for (state = 0; state < N_RCU_BOOST_STATE; state++) {
> +			sum.rbs_stats[event][state] = 0;
> +			for_each_possible_cpu(cpu) {
> +				for (i = 0; i < RCU_BOOST_ELEMENTS; i++) {
> +					sum.rbs_stats[event][state]
> +					    += per_cpu(rcu_boost_dat,
> +						       cpu)[i].rbs_stats[event][state];
> +				}
> +			}
> +		}
> +
> +	/* Print them out! */
> +
> +	printk(KERN_ALERT
> +	       "rcu_boost_dat: idx=%d "
> +	       "b=%ld ul=%ld ub=%ld "
> +	       "boost: a=%ld ws=%ld cf=%ld s=%ld e=%ld\n",
> +	       rcu_boost_idx,
> +	       sum.rbs_blocked, sum.rbs_unlock, sum.rbs_unboosted,
> +	       sum.rbs_boost_attempt, sum.rbs_boost_wrongstate,
> +		       sum.rbs_boost_cmpxchgfail, sum.rbs_boost_start,
> +		       sum.rbs_boost_end);
> +	for (event = 0; event < N_RCU_BOOST_DAT_EVENTS; event++) {
> +		i = 0;
> +		for (state = 0; state <= N_RCU_BOOST_STATE; state++) {
> +			i += sprintf(&buf[i], " %ld%c",
> +				     sum.rbs_stats[event][state],
> +				     rcu_boost_state_error[event][state]);
> +		}
> +		printk(KERN_ALERT "rcu_boost_dat %s %s\n",
> +		       rcu_boost_state_event[event], buf);
> +	}
> +
> +	/* Go away and don't come back for awhile. */
> +
> +	lastprint = xtime.tv_sec;
> +}
> +
> +#else /* #ifdef CONFIG_PREEMPT_RCU_BOOST_STATS */
> +
> +#define rcu_boost_dat_stat_block(rbdp, oldstate)
> +#define rcu_boost_dat_stat_boost(rbdp, oldstate)
> +#define rcu_boost_dat_stat_unboost(rbdp, oldstate)
> +#define rcu_boost_dat_stat_unlock(rbdp, oldstate)
> +#define rcu_boost_dat_stat_exit(rbdp, oldstate)
> +#define rcu_boost_dat_stat_print()
> +
> +#endif /* #else #ifdef CONFIG_PREEMPT_RCU_BOOST_STATS */
> +
> +/*
> + * Initialize RCU-boost state.  This happens early in the boot process,
> + * when the scheduler does not yet exist.  So don't try to use it.
> + */
> +static void init_rcu_boost_early(void)
> +{
> +	struct rcu_boost_dat *rbdp;
> +	int cpu;
> +	int i;
> +
> +	for_each_possible_cpu(cpu) {
> +		rbdp = per_cpu(rcu_boost_dat, cpu);
> +		for (i = 0; i < RCU_BOOST_ELEMENTS; i++) {
> +			rbdp[i].rbs_mutex =
> +				RAW_SPIN_LOCK_UNLOCKED(rbdp[i].rbs_mutex);
> +			INIT_LIST_HEAD(&rbdp[i].rbs_toboost);
> +			INIT_LIST_HEAD(&rbdp[i].rbs_boosted);
> +			init_waitqueue_head(&rbdp[i].rbs_target_wq);
> +			init_waitqueue_head(&rbdp[i].rbs_booster_wq);
> +			rbdp[i].rbs_exit_done = 1;
> +			rbdp[i].rbs_blocked = 0;
> +			rbdp[i].rbs_boost_attempt = 0;
> +			rbdp[i].rbs_boost_wrongstate = 0;
> +			rbdp[i].rbs_boost_cmpxchgfail = 0;
> +			rbdp[i].rbs_boost_start = 0;
> +			rbdp[i].rbs_boost_end = 0;
> +			rbdp[i].rbs_unlock = 0;
> +			rbdp[i].rbs_unboosted = 0;
> +#ifdef CONFIG_PREEMPT_RCU_BOOST_STATS
> +			{
> +				int j, k;
> +
> +				for (j = 0; j < N_RCU_BOOST_DAT_EVENTS; j++)
> +					for (k = 0; k <= N_RCU_BOOST_STATE; k++)
> +						rbdp[i].rbs_stats[j][k] = 0;
> +			}
> +#endif /* #ifdef CONFIG_PREEMPT_RCU_BOOST_STATS */
> +		}
> +		smp_wmb();
> +		rcu_boost_idx = 0;
> +	}
> +}
> +
> +/*
> + * Return the current boost index for adding target tasks.
> + * Will be -1 if too early during boot.
> + */
> +static inline int rcu_boost_idx_new(void)
> +{
> +	int idx = rcu_boost_idx;
> +
> +	smp_read_barrier_depends(); barrier();
> +	return idx;
> +}
> +
> +/*
> + * Return the current boost index for boosting target tasks.
> + * May only be invoked by the booster task, so guaranteed to
> + * already be initialized.
> + */
> +static inline int rcu_boost_idx_boosting(void)
> +{
> +	return (rcu_boost_idx + 1) & (RCU_BOOST_ELEMENTS - 1);
> +}
> +
> +/*
> + * Return the list on which the calling task should add itself, or
> + * NULL if too early during initialization.
> + */
> +static inline struct rcu_boost_dat *rcu_rbd_new(void)
> +{
> +	int cpu = raw_smp_processor_id();  /* locks used, so preemption OK. */
> +	int idx = rcu_boost_idx_new();
> +
> +	if (unlikely(idx < 0))
> +		return (NULL);
> +	return &per_cpu(rcu_boost_dat, cpu)[idx];
> +}
> +
> +/*
> + * Return the list from which to boost target tasks.
> + * May only be invoked by the booster task, so guaranteed to
> + * already be initialized.
> + */
> +static inline struct rcu_boost_dat *rcu_rbd_boosting(int cpu)
> +{
> +	return &per_cpu(rcu_boost_dat, cpu)[rcu_boost_idx_boosting()];
> +}
> +
> +#define PREEMPT_RCU_BOOSTER_PRIO 49  /* Match curr_irq_prio manually for now. */
> +#define PREEMPT_RCU_BOOST_PRIO   50  /* Don't allow RCU read-side critical */
> +				     /*  sections to block irq handlers. */
> +
> +/*
> + * Boost the specified task from an RCU viewpoint.
> + * These two functions might be better in kernel/rtmutex.c?
> + */
> +static void rcu_boost_prio(struct task_struct *taskp)
> +{
> +	unsigned long oldirq;
> +
> +	spin_lock_irqsave(&taskp->pi_lock, oldirq);
> +	taskp->rcu_prio = PREEMPT_RCU_BOOST_PRIO;
> +	if (taskp->rcu_prio < taskp->prio)
> +		rt_mutex_setprio(taskp, taskp->rcu_prio);
> +	spin_unlock_irqrestore(&taskp->pi_lock, oldirq);
> +}
> +
> +/*
> + * Unboost the specified task from an RCU viewpoint.
> + */
> +static void rcu_unboost_prio(struct task_struct *taskp)
> +{
> +	int nprio;
> +	unsigned long oldirq;
> +
> +	spin_lock_irqsave(&taskp->pi_lock, oldirq);
> +	taskp->rcu_prio = MAX_PRIO;
> +	nprio = rt_mutex_getprio(taskp);
> +	if (nprio > taskp->prio)
> +		rt_mutex_setprio(taskp, nprio);
> +	spin_unlock_irqrestore(&taskp->pi_lock, oldirq);
> +}
> +
> +/*
> + * Boost all of the RCU-reader tasks on the specified list.
> + */
> +static void rcu_boost_one_reader_list(struct rcu_boost_dat *rbdp)
> +{
> +	LIST_HEAD(list);
> +	unsigned long oldirq;
> +	enum rcu_boost_state oldstate;
> +	enum rcu_boost_state newstate;
> +	struct task_struct *taskp;
> +
> +	/*
> +	 * Splice the toboost list onto a local list.  We will still
> +	 * need to hold the lock when manipulating the local list
> +	 * because tasks can remove themselves at any time.
> +	 */
> +
> +	spin_lock_irqsave(&rbdp->rbs_mutex, oldirq);
> +	list_splice_init(&rbdp->rbs_toboost, &list);
> +	while (!list_empty(&list)) {
> +
> +		/*
> +		 * Pause for a bit before boosting each task.
> +		 * @@@FIXME: reduce/eliminate pausing in case of OOM.
> +		 */
> +
> +		spin_unlock_irqrestore(&rbdp->rbs_mutex, oldirq);
> +		schedule_timeout_uninterruptible(1);
> +		spin_lock_irqsave(&rbdp->rbs_mutex, oldirq);
> +
> +		/* Interlock with prior target task if raced with exit(). */
> +
> +		if (rbdp->rbs_exit_done != 1) {
> +			spin_unlock_irqrestore(&rbdp->rbs_mutex, oldirq);
> +			wait_event(rbdp->rbs_booster_wq,
> +				   rbdp->rbs_exit_done == 1);
> +			spin_lock_irqsave(&rbdp->rbs_mutex, oldirq);
> +		}
> +
> +		/*
> +		 * All tasks might have removed themselves while
> +		 * we were waiting.  Recheck list emptiness.
> +		 */
> +	
> +		if (list_empty(&list))
> +			break;
> +
> +		/* Remove first task in local list, count the attempt. */
> +
> +		taskp = list_entry(list.next, typeof(*taskp), rcub_entry);
> +		list_del_init(&taskp->rcub_entry);
> +		rbdp->rbs_boost_attempt++;
> +
> +		/* Ignore tasks in unexpected states. */
> +
> +		if ((oldstate = taskp->rcub_state) != RCU_BOOST_BLOCKED) {
> +			list_add_tail(&taskp->rcub_entry, &rbdp->rbs_toboost);
> +			rcu_boost_dat_stat_boost(rbdp, oldstate);
> +			continue;
> +		}
> +		taskp->rcub_rbdp_wq = rbdp;
> +
> +		/*
> +		 * This cmpxchg should always succeed, since we hold the
> +		 * lock.  Count and ignore the task if it nonetheless fails.
> +		 */
> +
> +		if (cmpxchg(&taskp->rcub_state,
> +			    RCU_BOOST_BLOCKED,
> +			    RCU_BOOSTING) != RCU_BOOST_BLOCKED) {
> +			list_add_tail(&taskp->rcub_entry, &rbdp->rbs_toboost);
> +			rcu_boost_dat_stat_boost(rbdp, RCU_BOOST_BLOCKED);
> +			taskp->rcub_rbdp_wq = NULL;
> +			rbdp->rbs_boost_cmpxchgfail++;
> +			continue;
> +		}
> +		rcu_boost_dat_stat_boost(rbdp, RCU_BOOST_BLOCKED);
> +
> +		/*
> +		 * Count the task, add to boosted list, and set up
> +		 * for the potential exit() race.
> +		 */
> +
> +		rbdp->rbs_boost_start++;
> +		list_add_tail(&taskp->rcub_entry, &rbdp->rbs_boosted);
> +		rbdp->rbs_exit_done = 0;
> +
> +		/* Boost task's priority. */
> +
> +		rcu_boost_prio(taskp);
> +
> +		/* Update state to indicate that boost is complete. */
> +		
> +		newstate = RCU_BOOSTED;
> +		if (cmpxchg(&taskp->rcub_state,
> +			    RCU_BOOSTING, RCU_BOOSTED) == RCU_BOOSTING) {
> +			rbdp->rbs_boost_end++;
> +			rcu_boost_dat_stat_unboost(rbdp, RCU_BOOSTING);
> +		} else {
> +
> +			/*
> +			 * The task changed state before we could boost
> +			 * it.  We must therefore unboost it.  Note that
> +			 * the task may well be on some other list, so
> +			 * we cannot reasonably leverage locking.
> +			 */
> +
> +			rcu_unboost_prio(taskp);
> +
> +			/*
> +			 * Now transition the task's state to allow for
> +			 * the unboosting.  In theory, we could go through
> +			 * this loop many times.  In practice, this would
> +			 * require that the target task be blocking and
> +			 * unblocking ridiculously often.
> +			 *
> +			 * If latency becomes a problem, it should be
> +			 * OK to drop the lock and re-enable irqs across
> +			 * this loop.
> +			 */
> +
> +			do {
> +				oldstate = taskp->rcub_state;
> +				if (oldstate < RCU_UNBOOST_IDLE)
> +					break;  /* logged below. */
> +				newstate = RCU_BOOST_STATE_UNBOOST(oldstate);
> +			} while (cmpxchg(&taskp->rcub_state,
> +			 		  oldstate, newstate) != oldstate);
> +			rcu_boost_dat_stat_unboost(rbdp, oldstate);
> +		}
> +
> +		/* Do exit dance if needed. */
> +
> +		if (newstate == RCU_EXIT_OK) {
> +			wake_up(&rbdp->rbs_target_wq);  /* drop lock??? @@@ */
> +		} else {
> +			/* At this point, we don't own the task boost state. */
> +			rbdp->rbs_exit_done = 1;
> +		}
> +	}
> +	spin_unlock_irqrestore(&rbdp->rbs_mutex, oldirq);
> +}
> +
> +/*
> + * Priority-boost tasks stuck in RCU read-side critical sections as
> + * needed (presumably rarely).
> + */
> +static int rcu_booster(void *arg)
> +{
> +	int cpu;
> +	struct sched_param sp;
> +
> +	sp.sched_priority = PREEMPT_RCU_BOOSTER_PRIO;
> +	sched_setscheduler(current, SCHED_RR, &sp);
> +	current->flags |= PF_NOFREEZE;
> +
> +	do {
> +
> +		/* Advance the lists of tasks. */
> +
> +		rcu_boost_idx = (rcu_boost_idx + 1) % RCU_BOOST_ELEMENTS;
> +		for_each_possible_cpu(cpu) {
> +		
> +			/*
> +			 * Boost all sufficiently aged readers.
> +			 * Readers must first be preempted or block
> +			 * on a mutex in an RCU read-side critical section,
> +			 * then remain in that critical section for
> +			 * RCU_BOOST_ELEMENTS-1 time intervals.
> +			 * So most of the time we should end up doing
> +			 * nothing.
> +			 */
> +
> +			rcu_boost_one_reader_list(rcu_rbd_boosting(cpu));
> +
> +			/*
> +			 * Large SMP systems may need to sleep sometimes
> +			 * in this loop.  Or have multiple RCU-boost tasks.
> +			 */
> +		}
> +
> +		/*
> +		 * Sleep to allow any unstalled RCU read-side critical
> +		 * sections to age out of the list.  @@@ FIXME: reduce,
> +		 * adjust, or eliminate in case of OOM.
> +		 */
> +
> +		schedule_timeout_uninterruptible(HZ / 100);
> +
> +		/* Print stats if enough time has passed. */
> +
> +		rcu_boost_dat_stat_print();
> +
> +	} while (!kthread_should_stop());
> +
> +	return 0;
> +}
> +
> +/*
> + * Perform the portions of RCU-boost initialization that require the
> + * scheduler to be up and running.
> + */
> +void init_rcu_boost_late(void)
> +{
> +	int i;
> +
> +	/* Spawn RCU-boost task. */
> +
> +	printk(KERN_ALERT "Starting RCU priority booster\n");
> +	rcu_boost_task = kthread_run(rcu_booster, NULL, "RCU Prio Booster");
> +	if (IS_ERR(rcu_boost_task)) {
> +		i = PTR_ERR(rcu_boost_task);
> +		printk(KERN_ALERT
> +		       "Unable to create RCU Priority Booster, errno %d\n", -i);
> +
> +		/*
> +		 * Continue running, but tasks permanently blocked
> +		 * in RCU read-side critical sections will be able
> +		 * to stall grace-period processing, potentially
> +		 * OOMing the machine.
> +		 */
> +
> +		rcu_boost_task = NULL;
> +	}
> +}
> +
> +/*
> + * Update task's RCU-boost state to reflect blocking in RCU read-side
> + * critical section, so that the RCU-boost task can find it in case it
> + * later needs its priority boosted.
> + */
> +void __rcu_preempt_boost(void)
> +{
> +	struct rcu_boost_dat *rbdp;
> +	unsigned long oldirq;
> +	enum rcu_boost_state oldstate;
> +	enum rcu_boost_state newstate;
> +
> +	/* Identify list to place task on for possible later boosting. */
> +
> +	local_irq_save(oldirq);
> +	rbdp = rcu_rbd_new();
> +	if (rbdp == NULL) {
> +		local_irq_restore(oldirq);
> +		printk("Preempted RCU read-side critical section too early.\n");
> +		return;
> +	}
> +	spin_lock(&rbdp->rbs_mutex);
> +	rbdp->rbs_blocked++;
> +
> +	/* Update state.  There can be at most two passes through the
> +	 * following loop: (1) cmpxchg fails due to booster concurrently
> +	 * changing RCU_UNBOOST_IDLE to RCU_BOOST_IDLE and (2) cmpxchg
> +	 * succeeds changing RCU_BOOST_IDLE to RCU_BOOST_BLOCKED.
> +	 */
> +
> +	do {
> +		oldstate = current->rcub_state;
> +		switch (oldstate) {
> +		case RCU_BOOST_IDLE:
> +		case RCU_UNBOOST_IDLE:
> +			newstate = RCU_BOOST_STATE_BLOCKED(oldstate);
> +			break;
> +		default: /* Error.  Count, but don't touch state/lists. */
> +		case RCU_BOOST_BLOCKED:
> +		case RCU_UNBOOST_BLOCKED:
> +			/* Been here in same RCU read-side critical section. */
> +			spin_unlock_irqrestore(&rbdp->rbs_mutex, oldirq);
> +			rcu_boost_dat_stat_block(rbdp, oldstate);
> +			return;
> +		}
> +	} while (cmpxchg(&current->rcub_state, oldstate, newstate) != oldstate);
> +	rcu_boost_dat_stat_block(rbdp, oldstate);
> +
> +	/* Now add ourselves to the list so that the booster can find use. */
> +
> +	list_add_tail(&current->rcub_entry, &rbdp->rbs_toboost);
> +	current->rcub_rbdp = rbdp;
> +	spin_unlock_irqrestore(&rbdp->rbs_mutex, oldirq);
> +}
> +
> +/*
> + * Do the list-removal and priority-unboosting "heavy lifting" when
> + * required.
> + */
> +static void __rcu_read_unlock_unboost(void)
> +{
> +	unsigned long oldirq;
> +	enum rcu_boost_state oldstate;
> +	enum rcu_boost_state newstate;
> +	struct rcu_boost_dat *rbdp;
> +
> +	/*
> +	 * Acquire the lock -- this prevents some, but not all, races
> +	 * with the RCU-boost task.  (We might have entered another
> +	 * RCU read-side critical section on some other CPU, thus be
> +	 * using a different lock than the RCU-boost task, which might
> +	 * well still be trying to clean up after boosting one of our
> +	 * earlier RCU read-side critical sections.)
> +	 */
> +
> +	rbdp = current->rcub_rbdp;
> +	spin_lock_irqsave(&rbdp->rbs_mutex, oldirq);
> +
> +	/* Remove task from the list it was on. */
> +
> +	list_del_init(&current->rcub_entry);
> +	rbdp->rbs_unlock++;
> +	current->rcub_rbdp = NULL;
> +
> +	/*
> +	 * Update state.  There can be at most two passes through the
> +	 * following loop, via two different scenarios:
> +	 *
> +	 * (1) cmpxchg fails due to race with booster changing
> +	 *     RCU_BOOSTING to RCU_BOOSTED.
> +	 * (2) cmpxchg succeeds changing RCU_BOOSTED to RCU_BOOST_IDLE.
> +	 *     The RCU-boost task is not permitted to change the
> +	 *     state of a task in RCU_BOOST_IDLE.
> +	 *
> +	 * (1) cmpxchg fails due to race with booster changing
> +	 *     RCU_UNBOOST_BLOCKED to RCU_BOOST_BLOCKED,
> +	 * (2) cmpxchg succeeds changing RCU_BOOST_BLOCKED to
> +	 *     RCU_BOOST_IDLE.  Although the RCU-boost task is
> +	 *     permitted to change the state while in RCU_BOOST_IDLE,
> +	 *     it holds the lock when doing so, so cannot until we
> +	 *     release the lock.
> +	 */
> +
> +	do {
> +		oldstate = current->rcub_state;
> +		switch (oldstate) {
> +		case RCU_BOOST_BLOCKED:
> +		case RCU_BOOSTED:
> +		case RCU_UNBOOST_BLOCKED:
> +		case RCU_BOOSTING:
> +			newstate = RCU_BOOST_STATE_RCU_READ_UNLOCK(oldstate);
> +			break;
> +		case RCU_BOOST_IDLE:      /* Do-nothing case. */
> +		case RCU_UNBOOST_IDLE:    /* Do-nothing case. */
> +		case RCU_EXIT_OK:         /* Error case: still do nothing. */
> +		case RCU_UNBOOST_EXITING: /* Error case: still do nothing. */
> +		default:	          /* Error case: still do nothing. */
> +			rcu_boost_dat_stat_unlock(rbdp, oldstate);
> +			spin_unlock_irqrestore(&rbdp->rbs_mutex, oldirq);
> +			return;
> +		}
> +	} while (cmpxchg(&current->rcub_state, oldstate, newstate) != oldstate);
> +
> +	rcu_boost_dat_stat_unlock(rbdp, oldstate);
> +	spin_unlock_irqrestore(&rbdp->rbs_mutex, oldirq);
> +	
> +	/*
> +	 * Now unboost ourselves, if warranted and safe.  Note that if
> +	 * the booster is still trying to boost us, then he must do any
> +	 * unboosting that might be necessary.  The state we set above
> +	 * will prompt him to do so.
> +	 */
> +
> +	if (newstate == RCU_BOOST_IDLE) {
> +
> +		/* The RCU-boost task is done with use, disassociate. */
> +
> +		current->rcub_rbdp_wq = NULL;
> +
> +		/* Unboost if we were in fact ever boosted. */
> +
> +		if (unlikely(current->rcu_prio != MAX_PRIO)) {
> +			rcu_unboost_prio(current);
> +			rbdp->rbs_unboosted++;
> +		}
> +	}
> +}
> +
> +/*
> + * Do any state changes and unboosting needed for rcu_read_unlock().
> + * Pass any complex work on to __rcu_read_unlock_unboost().
> + * The vast majority of the time, no work will be needed, as preemption
> + * and blocking within RCU read-side critical sections is comparatively
> + * rare.
> + */
> +static inline void rcu_read_unlock_unboost(void)
> +{
> +
> +	if (unlikely(current->rcub_state != RCU_BOOST_IDLE))
> +		__rcu_read_unlock_unboost();
> +}
> +
> +/*
> + * Wait, if needed, for the RCU-booster task to finish manipulating this
> + * task's priority.
> + */
> +void rcu_exit_wait(void)
> +{
> +	enum rcu_boost_state oldstate;
> +	enum rcu_boost_state newstate;
> +
> +	if (current->rcub_state == RCU_BOOST_IDLE)
> +		return;
> +
> +/*&&&&*/printk(KERN_ALERT "rcu_boost_exit: pid=%d rcub_state=%d rcub_rbdp_wq=%p\n",
> +/*&&&&*/       current->pid, current->rcub_state, current->rcub_rbdp_wq);
> +
> +	oldstate = current->rcub_state;
> +	switch (oldstate) {
> +	case RCU_BOOST_BLOCKED:
> +	case RCU_BOOSTING:
> +	case RCU_BOOSTED:
> +	case RCU_UNBOOST_BLOCKED:
> +	default:
> +
> +		/*
> +		 * Either state-machine or usage error.  Unwind out of
> +		 * any remaining RCU read-side critical sections, and
> +		 * see if that gets us somewhere useful.
> +		 */
> +
> +		rcu_boost_dat_stat_exit(current->rcub_rbdp_wq, oldstate);
> +		if (current->rcu_read_lock_nesting == 0)
> +			printk(KERN_ALERT "rcu_exit_wait pid %d: bad state\n",
> +			       current->pid);
> +		else
> +			printk(KERN_ALERT "rcu_exit_wait pid %d exiting "
> +					  "with rcu_read_lock() held\n",
> +			       current->pid);
> +		while (current->rcu_read_lock_nesting > 0)
> +			rcu_read_unlock();
> +		if ((current->rcub_state != RCU_BOOST_IDLE) &&
> +		    (current->rcub_state != RCU_UNBOOST_IDLE)) {
> +			struct sched_param sp;
> +
> +			/*
> +			 * No joy.  Stall at low priority: a memory leak
> +			 * is better than strange corruption.
> +			 */
> +
> +			printk(KERN_ALERT "rcu_exit_wait() pid %d waiting "
> +					  "forever due to invalid state\n",
> +			       current->pid);
> +			sp.sched_priority = MAX_PRIO;
> +			sched_setscheduler(current, SCHED_NORMAL, &sp);
> +			current->flags |= PF_NOFREEZE;
> +			for (;;)
> +				schedule_timeout_interruptible(3600 * HZ);
> +		}
> +
> +		/* Fall into RCU_BOOST_IDLE and RCU_UNBOOST_IDLE cases. */
> +
> +	case RCU_BOOST_IDLE:
> +	case RCU_UNBOOST_IDLE:
> +
> +		/*
> +		 * Update state.  There can be at most two passes through
> +		 * the following loop: (1) cmpxchg fails due to booster
> +		 * changing RCU_UNBOOST_IDLE to RCU_BOOST_IDLE, and then
> +		 * (2) cmpxchg succeeds changing RCU_BOOST_IDLE to
> +		 * RCU_EXIT_OK.
> +		 */
> +
> +		do {
> +			oldstate = current->rcub_state;
> +			newstate = RCU_BOOST_STATE_EXIT(oldstate);
> +		} while (cmpxchg(&current->rcub_state,
> +			         oldstate, newstate) != oldstate);
> +		rcu_boost_dat_stat_exit(current->rcub_rbdp_wq, oldstate);
> +		break;
> +
> +	case RCU_EXIT_OK:
> +	case RCU_UNBOOST_EXITING:
> +
> +		/* This should not happen, but... */
> +
> +		rcu_boost_dat_stat_exit(current->rcub_rbdp_wq, oldstate);
> +		newstate = oldstate;
> +		break;
> +	}
> +
> +	/* Wait for the booster to get done with us, if needed. */
> +
> +	if (newstate == RCU_UNBOOST_EXITING) {
> +		wait_event(current->rcub_rbdp_wq->rbs_target_wq,
> +			   current->rcub_state == RCU_EXIT_OK);
> +
> +		/* Tell the booster that it is OK to reuse the waitqueue. */
> +
> +		current->rcub_rbdp_wq->rbs_exit_done = 1;
> +		wake_up(&current->rcub_rbdp_wq->rbs_booster_wq);
> +	}
> +	current->rcub_rbdp_wq = NULL;
> +}
> +
> +#endif /* #else #ifndef CONFIG_PREEMPT_RCU_BOOST */
> +
>  /*
>   * Return the number of RCU batches processed thus far.  Useful
>   * for debug and statistics.
> @@ -155,6 +974,7 @@ void __rcu_read_unlock(void)
>  			atomic_dec(current->rcu_flipctr2);
>  			current->rcu_flipctr2 = NULL;
>  		}
> +		rcu_read_unlock_unboost();
>  	}
>  
>  	local_irq_restore(oldirq);
> @@ -345,6 +1165,11 @@ int notrace rcu_pending(int cpu)
>  		rcu_data.nextlist != NULL);
>  }
>  
> +/*
> + * Initialize RCU.  This is called very early in boot, so is restricted
> + * to very simple operations.  Don't even think about messing with anything
> + * that involves the scheduler, as it doesn't exist yet.
> + */
>  void __init __rcu_init(void)
>  {
>  /*&&&&*/printk("WARNING: experimental RCU implementation.\n");
> @@ -356,6 +1181,7 @@ void __init __rcu_init(void)
>  	rcu_data.waittail = &rcu_data.waitlist;
>  	rcu_data.donelist = NULL;
>  	rcu_data.donetail = &rcu_data.donelist;
> +	init_rcu_boost_early();
>  	tasklet_init(&rcu_data.rcu_tasklet, rcu_process_callbacks, 0UL);
>  }
>  
> diff -urpNa -X dontdiff linux-2.6.19-rt12/kernel/rtmutex.c linux-2.6.19-rt12-rcubpl/kernel/rtmutex.c
> --- linux-2.6.19-rt12/kernel/rtmutex.c	2006-12-22 21:21:42.000000000 -0800
> +++ linux-2.6.19-rt12-rcubpl/kernel/rtmutex.c	2006-12-24 16:25:44.000000000 -0800
> @@ -128,11 +128,14 @@ static inline void init_lists(struct rt_
>   */
>  int rt_mutex_getprio(struct task_struct *task)
>  {
> +	int prio = task->normal_prio;
> +
> +	if (get_rcu_prio(task) < prio)
> +		prio = get_rcu_prio(task);
>  	if (likely(!task_has_pi_waiters(task)))
> -		return task->normal_prio;
> +		return prio;
>  
> -	return min(task_top_pi_waiter(task)->pi_list_entry.prio,
> -		   task->normal_prio);
> +	return min(task_top_pi_waiter(task)->pi_list_entry.prio, prio);
>  }
>  
>  /*
> diff -urpNa -X dontdiff linux-2.6.19-rt12/kernel/sched.c linux-2.6.19-rt12-rcubpl/kernel/sched.c
> --- linux-2.6.19-rt12/kernel/sched.c	2006-12-22 21:21:42.000000000 -0800
> +++ linux-2.6.19-rt12-rcubpl/kernel/sched.c	2006-12-24 16:28:13.000000000 -0800
> @@ -1949,6 +1949,7 @@ void fastcall sched_fork(struct task_str
>  	 * Make sure we do not leak PI boosting priority to the child:
>  	 */
>  	p->prio = current->normal_prio;
> +	set_rcu_prio(p, MAX_PRIO);
>  
>  	INIT_LIST_HEAD(&p->run_list);
>  	p->array = NULL;
> @@ -2031,6 +2032,7 @@ void fastcall wake_up_new_task(struct ta
>  			else {
>  				p->prio = current->prio;
>  				p->normal_prio = current->normal_prio;
> +				set_rcu_prio(p, MAX_PRIO);
>  				__activate_task_after(p, current, rq);
>  			}
>  			set_need_resched();
> @@ -3800,6 +3802,8 @@ void __sched __schedule(void)
>  	}
>  	profile_hit(SCHED_PROFILING, __builtin_return_address(0));
>  
> +	rcu_preempt_boost();
> +
>  	preempt_disable(); // FIXME: disable irqs here
>  	prev = current;
>  	release_kernel_lock(prev);
> @@ -5512,6 +5516,7 @@ void __cpuinit init_idle(struct task_str
>  	idle->sleep_avg = 0;
>  	idle->array = NULL;
>  	idle->prio = idle->normal_prio = MAX_PRIO;
> +	set_rcu_prio(idle, MAX_PRIO);
>  	idle->state = TASK_RUNNING;
>  	idle->cpus_allowed = cpumask_of_cpu(cpu);
>  	set_task_cpu(idle, cpu);
