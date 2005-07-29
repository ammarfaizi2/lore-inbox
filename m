Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262541AbVG2LtX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262541AbVG2LtX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 07:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262535AbVG2LtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 07:49:23 -0400
Received: from mx1.elte.hu ([157.181.1.137]:29148 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262524AbVG2LtS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 07:49:18 -0400
Date: Fri, 29 Jul 2005 13:48:22 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Nick Piggin'" <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [patch] remove wake-balancing
Message-ID: <20050729114822.GA25249@elte.hu>
References: <42E98DEA.9090606@yahoo.com.au> <200507290627.j6T6Rrg06842@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507290627.j6T6Rrg06842@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Chen, Kenneth W <kenneth.w.chen@intel.com> wrote:

> > If we can get performance to within a couple of tenths of a percent
> > of the zero balancing case, then that would be preferable I think.
> 
> I won't try to compromise between the two.  If you do so, we would end 
> up with two half baked raw turkey.  Making less aggressive load 
> balance in the wake up path would probably reduce performance for the 
> type of workload you quoted earlier and for db workload, we don't want 
> any of them at all, not even the code to determine whether it should 
> be balanced or not.

i think we could try to get rid of wakeup-time balancing altogether.

these days pretty much the only time we can sensibly do 'fast' (as in 
immediate) migration are fork/clone and exec. Furthermore, the gained 
simplicity of wakeup is quite compelling too. (Originally, when i 
introduced the first variant wakeup-time balancing eons ago, we didnt 
have anything like fork-time and exec-time balancing.)

i think we could try the patch below in -mm, it removes (non-)affine 
wakeup and passive wakeup-balancing, but keeps SD_WAKE_IDLE that is 
needed for efficient SMT scheduling. I test-booted the patch on x86, and 
it should work on all architectures. (I have tested various local-IPC 
and non-IPC workloads and only found performance improvements - but i'm 
sure regressions exist too, and need to be examined.)

	Ingo

------
remove wakeup-time balancing. It turns out exec-time and fork-time
balancing combined with periodic rebalancing ticks does a good enough
job.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 include/asm-i386/topology.h           |    3 -
 include/asm-ia64/topology.h           |    6 --
 include/asm-mips/mach-ip27/topology.h |    3 -
 include/asm-ppc64/topology.h          |    3 -
 include/asm-x86_64/topology.h         |    3 -
 include/linux/sched.h                 |    4 -
 include/linux/topology.h              |    4 -
 kernel/sched.c                        |   89 +++-------------------------------
 8 files changed, 16 insertions(+), 99 deletions(-)

Index: linux-prefetch-task/include/asm-i386/topology.h
===================================================================
--- linux-prefetch-task.orig/include/asm-i386/topology.h
+++ linux-prefetch-task/include/asm-i386/topology.h
@@ -81,8 +81,7 @@ static inline int node_to_first_cpu(int 
 	.per_cpu_gain		= 100,			\
 	.flags			= SD_LOAD_BALANCE	\
 				| SD_BALANCE_EXEC	\
-				| SD_BALANCE_FORK	\
-				| SD_WAKE_BALANCE,	\
+				| SD_BALANCE_FORK,	\
 	.last_balance		= jiffies,		\
 	.balance_interval	= 1,			\
 	.nr_balance_failed	= 0,			\
Index: linux-prefetch-task/include/asm-ia64/topology.h
===================================================================
--- linux-prefetch-task.orig/include/asm-ia64/topology.h
+++ linux-prefetch-task/include/asm-ia64/topology.h
@@ -65,8 +65,7 @@ void build_cpu_to_node_map(void);
 	.forkexec_idx		= 1,			\
 	.flags			= SD_LOAD_BALANCE	\
 				| SD_BALANCE_NEWIDLE	\
-				| SD_BALANCE_EXEC	\
-				| SD_WAKE_AFFINE,	\
+				| SD_BALANCE_EXEC,	\
 	.last_balance		= jiffies,		\
 	.balance_interval	= 1,			\
 	.nr_balance_failed	= 0,			\
@@ -91,8 +90,7 @@ void build_cpu_to_node_map(void);
 	.per_cpu_gain		= 100,			\
 	.flags			= SD_LOAD_BALANCE	\
 				| SD_BALANCE_EXEC	\
-				| SD_BALANCE_FORK	\
-				| SD_WAKE_BALANCE,	\
+				| SD_BALANCE_FORK,	\
 	.last_balance		= jiffies,		\
 	.balance_interval	= 64,			\
 	.nr_balance_failed	= 0,			\
Index: linux-prefetch-task/include/asm-mips/mach-ip27/topology.h
===================================================================
--- linux-prefetch-task.orig/include/asm-mips/mach-ip27/topology.h
+++ linux-prefetch-task/include/asm-mips/mach-ip27/topology.h
@@ -28,8 +28,7 @@ extern unsigned char __node_distances[MA
 	.cache_nice_tries	= 1,			\
 	.per_cpu_gain		= 100,			\
 	.flags			= SD_LOAD_BALANCE	\
-				| SD_BALANCE_EXEC	\
-				| SD_WAKE_BALANCE,	\
+				| SD_BALANCE_EXEC,	\
 	.last_balance		= jiffies,		\
 	.balance_interval	= 1,			\
 	.nr_balance_failed	= 0,			\
Index: linux-prefetch-task/include/asm-ppc64/topology.h
===================================================================
--- linux-prefetch-task.orig/include/asm-ppc64/topology.h
+++ linux-prefetch-task/include/asm-ppc64/topology.h
@@ -52,8 +52,7 @@ static inline int node_to_first_cpu(int 
 	.flags			= SD_LOAD_BALANCE	\
 				| SD_BALANCE_EXEC	\
 				| SD_BALANCE_NEWIDLE	\
-				| SD_WAKE_IDLE		\
-				| SD_WAKE_BALANCE,	\
+				| SD_WAKE_IDLE,		\
 	.last_balance		= jiffies,		\
 	.balance_interval	= 1,			\
 	.nr_balance_failed	= 0,			\
Index: linux-prefetch-task/include/asm-x86_64/topology.h
===================================================================
--- linux-prefetch-task.orig/include/asm-x86_64/topology.h
+++ linux-prefetch-task/include/asm-x86_64/topology.h
@@ -48,8 +48,7 @@ extern int __node_distance(int, int);
 	.per_cpu_gain		= 100,			\
 	.flags			= SD_LOAD_BALANCE	\
 				| SD_BALANCE_FORK	\
-				| SD_BALANCE_EXEC	\
-				| SD_WAKE_BALANCE,	\
+				| SD_BALANCE_EXEC,	\
 	.last_balance		= jiffies,		\
 	.balance_interval	= 1,			\
 	.nr_balance_failed	= 0,			\
Index: linux-prefetch-task/include/linux/sched.h
===================================================================
--- linux-prefetch-task.orig/include/linux/sched.h
+++ linux-prefetch-task/include/linux/sched.h
@@ -471,9 +471,7 @@ enum idle_type
 #define SD_BALANCE_EXEC		4	/* Balance on exec */
 #define SD_BALANCE_FORK		8	/* Balance on fork, clone */
 #define SD_WAKE_IDLE		16	/* Wake to idle CPU on task wakeup */
-#define SD_WAKE_AFFINE		32	/* Wake task to waking CPU */
-#define SD_WAKE_BALANCE		64	/* Perform balancing at task wakeup */
-#define SD_SHARE_CPUPOWER	128	/* Domain members share cpu power */
+#define SD_SHARE_CPUPOWER	32	/* Domain members share cpu power */
 
 struct sched_group {
 	struct sched_group *next;	/* Must be a circular list */
Index: linux-prefetch-task/include/linux/topology.h
===================================================================
--- linux-prefetch-task.orig/include/linux/topology.h
+++ linux-prefetch-task/include/linux/topology.h
@@ -97,7 +97,6 @@
 	.flags			= SD_LOAD_BALANCE	\
 				| SD_BALANCE_NEWIDLE	\
 				| SD_BALANCE_EXEC	\
-				| SD_WAKE_AFFINE	\
 				| SD_WAKE_IDLE		\
 				| SD_SHARE_CPUPOWER,	\
 	.last_balance		= jiffies,		\
@@ -127,8 +126,7 @@
 	.forkexec_idx		= 1,			\
 	.flags			= SD_LOAD_BALANCE	\
 				| SD_BALANCE_NEWIDLE	\
-				| SD_BALANCE_EXEC	\
-				| SD_WAKE_AFFINE,	\
+				| SD_BALANCE_EXEC,	\
 	.last_balance		= jiffies,		\
 	.balance_interval	= 1,			\
 	.nr_balance_failed	= 0,			\
Index: linux-prefetch-task/kernel/sched.c
===================================================================
--- linux-prefetch-task.orig/kernel/sched.c
+++ linux-prefetch-task/kernel/sched.c
@@ -254,7 +254,6 @@ struct runqueue {
 
 	/* try_to_wake_up() stats */
 	unsigned long ttwu_cnt;
-	unsigned long ttwu_local;
 #endif
 };
 
@@ -373,7 +372,7 @@ static inline void task_rq_unlock(runque
  * bump this up when changing the output format or the meaning of an existing
  * format, so that tools can adapt (or abort)
  */
-#define SCHEDSTAT_VERSION 12
+#define SCHEDSTAT_VERSION 13
 
 static int show_schedstat(struct seq_file *seq, void *v)
 {
@@ -390,11 +389,11 @@ static int show_schedstat(struct seq_fil
 
 		/* runqueue-specific stats */
 		seq_printf(seq,
-		    "cpu%d %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu",
+		    "cpu%d %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu",
 		    cpu, rq->yld_both_empty,
 		    rq->yld_act_empty, rq->yld_exp_empty, rq->yld_cnt,
 		    rq->sched_switch, rq->sched_cnt, rq->sched_goidle,
-		    rq->ttwu_cnt, rq->ttwu_local,
+		    rq->ttwu_cnt,
 		    rq->rq_sched_info.cpu_time,
 		    rq->rq_sched_info.run_delay, rq->rq_sched_info.pcnt);
 
@@ -424,8 +423,7 @@ static int show_schedstat(struct seq_fil
 			seq_printf(seq, " %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu\n",
 			    sd->alb_cnt, sd->alb_failed, sd->alb_pushed,
 			    sd->sbe_cnt, sd->sbe_balanced, sd->sbe_pushed,
-			    sd->sbf_cnt, sd->sbf_balanced, sd->sbf_pushed,
-			    sd->ttwu_wake_remote, sd->ttwu_move_affine, sd->ttwu_move_balance);
+			    sd->sbf_cnt, sd->sbf_balanced, sd->sbf_pushed);
 		}
 		preempt_enable();
 #endif
@@ -1134,8 +1132,6 @@ static int try_to_wake_up(task_t * p, un
 	long old_state;
 	runqueue_t *rq;
 #ifdef CONFIG_SMP
-	unsigned long load, this_load;
-	struct sched_domain *sd, *this_sd = NULL;
 	int new_cpu;
 #endif
 
@@ -1154,77 +1150,13 @@ static int try_to_wake_up(task_t * p, un
 	if (unlikely(task_running(rq, p)))
 		goto out_activate;
 
-	new_cpu = cpu;
-
 	schedstat_inc(rq, ttwu_cnt);
-	if (cpu == this_cpu) {
-		schedstat_inc(rq, ttwu_local);
-		goto out_set_cpu;
-	}
-
-	for_each_domain(this_cpu, sd) {
-		if (cpu_isset(cpu, sd->span)) {
-			schedstat_inc(sd, ttwu_wake_remote);
-			this_sd = sd;
-			break;
-		}
-	}
-
-	if (unlikely(!cpu_isset(this_cpu, p->cpus_allowed)))
-		goto out_set_cpu;
 
 	/*
-	 * Check for affine wakeup and passive balancing possibilities.
+	 * Wake to the CPU the task was last running on (or any
+	 * nearby SMT-equivalent idle CPU):
 	 */
-	if (this_sd) {
-		int idx = this_sd->wake_idx;
-		unsigned int imbalance;
-
-		imbalance = 100 + (this_sd->imbalance_pct - 100) / 2;
-
-		load = source_load(cpu, idx);
-		this_load = target_load(this_cpu, idx);
-
-		new_cpu = this_cpu; /* Wake to this CPU if we can */
-
-		if (this_sd->flags & SD_WAKE_AFFINE) {
-			unsigned long tl = this_load;
-			/*
-			 * If sync wakeup then subtract the (maximum possible)
-			 * effect of the currently running task from the load
-			 * of the current CPU:
-			 */
-			if (sync)
-				tl -= SCHED_LOAD_SCALE;
-
-			if ((tl <= load &&
-				tl + target_load(cpu, idx) <= SCHED_LOAD_SCALE) ||
-				100*(tl + SCHED_LOAD_SCALE) <= imbalance*load) {
-				/*
-				 * This domain has SD_WAKE_AFFINE and
-				 * p is cache cold in this domain, and
-				 * there is no bad imbalance.
-				 */
-				schedstat_inc(this_sd, ttwu_move_affine);
-				goto out_set_cpu;
-			}
-		}
-
-		/*
-		 * Start passive balancing when half the imbalance_pct
-		 * limit is reached.
-		 */
-		if (this_sd->flags & SD_WAKE_BALANCE) {
-			if (imbalance*this_load <= 100*load) {
-				schedstat_inc(this_sd, ttwu_move_balance);
-				goto out_set_cpu;
-			}
-		}
-	}
-
-	new_cpu = cpu; /* Could not wake to this_cpu. Wake to cpu instead */
-out_set_cpu:
-	new_cpu = wake_idle(new_cpu, p);
+	new_cpu = wake_idle(cpu, p);
 	if (new_cpu != cpu) {
 		set_task_cpu(p, new_cpu);
 		task_rq_unlock(rq, &flags);
@@ -4758,9 +4690,7 @@ static int sd_degenerate(struct sched_do
 	}
 
 	/* Following flags don't use groups */
-	if (sd->flags & (SD_WAKE_IDLE |
-			 SD_WAKE_AFFINE |
-			 SD_WAKE_BALANCE))
+	if (sd->flags & SD_WAKE_IDLE)
 		return 0;
 
 	return 1;
@@ -4778,9 +4708,6 @@ static int sd_parent_degenerate(struct s
 		return 0;
 
 	/* Does parent contain flags not in child? */
-	/* WAKE_BALANCE is a subset of WAKE_AFFINE */
-	if (cflags & SD_WAKE_AFFINE)
-		pflags &= ~SD_WAKE_BALANCE;
 	/* Flags needing groups don't count if only 1 group in parent */
 	if (parent->groups == parent->groups->next) {
 		pflags &= ~(SD_LOAD_BALANCE |
