Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269691AbUIDFHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269691AbUIDFHk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 01:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269778AbUIDFHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 01:07:40 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:10874 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269691AbUIDFHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 01:07:22 -0400
Message-ID: <41394D79.40205@yahoo.com.au>
Date: Sat, 04 Sep 2004 15:07:05 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Rick Lindsley <ricklind@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] schedstats additions
Content-Type: multipart/mixed;
 boundary="------------090006010803040306020905"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090006010803040306020905
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
I have a patch here to provide more useful statistics for me. Basically
it moves a lot more of the balancing information into the domains instead
of the runqueue, where it is nearly useless on multi-domain setups (eg.
SMT+SMP, SMP+NUMA).

It requires a version number bump, but that isn't much of an issue because
I think we're about the only two using it at the moment. But your tools
will need a little bit of work.

What do you think?


--------------090006010803040306020905
Content-Type: text/x-patch;
 name="sched-stat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-stat.patch"




---

 linux-2.6-npiggin/kernel/sched.c |  155 ++++++++++++++++++++-------------------
 1 files changed, 82 insertions(+), 73 deletions(-)

diff -puN kernel/sched.c~sched-stat kernel/sched.c
--- linux-2.6/kernel/sched.c~sched-stat	2004-09-04 13:08:54.000000000 +1000
+++ linux-2.6-npiggin/kernel/sched.c	2004-09-04 15:02:07.000000000 +1000
@@ -194,7 +194,6 @@ struct runqueue {
 	unsigned long yld_cnt;
 
 	/* schedule() stats */
-	unsigned long sched_noswitch;
 	unsigned long sched_switch;
 	unsigned long sched_cnt;
 	unsigned long sched_goidle;
@@ -203,26 +202,9 @@ struct runqueue {
 	unsigned long pt_gained[MAX_IDLE_TYPES];
 	unsigned long pt_lost[MAX_IDLE_TYPES];
 
-	/* active_load_balance() stats */
-	unsigned long alb_cnt;
-	unsigned long alb_lost;
-	unsigned long alb_gained;
-	unsigned long alb_failed;
-
 	/* try_to_wake_up() stats */
 	unsigned long ttwu_cnt;
-	unsigned long ttwu_attempts;
-	unsigned long ttwu_moved;
-
-	/* wake_up_new_task() stats */
-	unsigned long wunt_cnt;
-	unsigned long wunt_moved;
-
-	/* sched_migrate_task() stats */
-	unsigned long smt_cnt;
-
-	/* sched_balance_exec() stats */
-	unsigned long sbe_cnt;
+	unsigned long ttwu_remote;
 #endif
 };
 
@@ -277,15 +259,24 @@ struct sched_domain {
 	/* load_balance() stats */
 	unsigned long lb_cnt[MAX_IDLE_TYPES];
 	unsigned long lb_failed[MAX_IDLE_TYPES];
+	unsigned long lb_balanced[MAX_IDLE_TYPES];
 	unsigned long lb_imbalance[MAX_IDLE_TYPES];
+	unsigned long lb_pulled[MAX_IDLE_TYPES];
+	unsigned long lb_hot_pulled[MAX_IDLE_TYPES];
 	unsigned long lb_nobusyg[MAX_IDLE_TYPES];
 	unsigned long lb_nobusyq[MAX_IDLE_TYPES];
 
+	/* Active load balancing */
+	unsigned long alb_cnt;
+	unsigned long alb_failed;
+	unsigned long alb_pushed;
+
 	/* sched_balance_exec() stats */
 	unsigned long sbe_attempts;
 	unsigned long sbe_pushed;
 
 	/* try_to_wake_up() stats */
+	unsigned long ttwu_wake_remote;
 	unsigned long ttwu_wake_affine;
 	unsigned long ttwu_wake_balance;
 #endif
@@ -409,7 +400,7 @@ static inline void task_rq_unlock(runque
  * bump this up when changing the output format or the meaning of an existing
  * format, so that tools can adapt (or abort)
  */
-#define SCHEDSTAT_VERSION 10
+#define SCHEDSTAT_VERSION 11
 
 static int show_schedstat(struct seq_file *seq, void *v)
 {
@@ -427,17 +418,12 @@ static int show_schedstat(struct seq_fil
 
 		/* runqueue-specific stats */
 		seq_printf(seq,
-		    "cpu%d %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu "
-		    "%lu %lu %lu %lu %lu %lu %lu %lu %lu %lu",
+		    "cpu%d %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu",
 		    cpu, rq->yld_both_empty,
-		    rq->yld_act_empty, rq->yld_exp_empty,
-		    rq->yld_cnt, rq->sched_noswitch,
+		    rq->yld_act_empty, rq->yld_exp_empty, rq->yld_cnt,
 		    rq->sched_switch, rq->sched_cnt, rq->sched_goidle,
-		    rq->alb_cnt, rq->alb_gained, rq->alb_lost,
-		    rq->alb_failed,
-		    rq->ttwu_cnt, rq->ttwu_moved, rq->ttwu_attempts,
-		    rq->wunt_cnt, rq->wunt_moved,
-		    rq->smt_cnt, rq->sbe_cnt, rq->rq_sched_info.cpu_time,
+		    rq->ttwu_cnt, rq->ttwu_remote,
+		    rq->rq_sched_info.cpu_time,
 		    rq->rq_sched_info.run_delay, rq->rq_sched_info.pcnt);
 
 		for (itype = IDLE; itype < MAX_IDLE_TYPES; itype++)
@@ -453,16 +439,20 @@ static int show_schedstat(struct seq_fil
 			cpumask_scnprintf(mask_str, NR_CPUS, sd->span);
 			seq_printf(seq, "domain%d %s", dcnt++, mask_str);
 			for (itype = IDLE; itype < MAX_IDLE_TYPES; itype++) {
-				seq_printf(seq, " %lu %lu %lu %lu %lu",
+				seq_printf(seq, " %lu %lu %lu %lu %lu %lu %lu %lu",
 				    sd->lb_cnt[itype],
+				    sd->lb_balanced[itype],
 				    sd->lb_failed[itype],
 				    sd->lb_imbalance[itype],
+				    sd->lb_pulled[itype],
+				    sd->lb_hot_pulled[itype],
 				    sd->lb_nobusyq[itype],
 				    sd->lb_nobusyg[itype]);
 			}
-			seq_printf(seq, " %lu %lu %lu %lu\n",
+			seq_printf(seq, " %lu %lu %lu %lu %lu %lu %lu %lu\n",
+			    sd->alb_cnt, sd->alb_failed, sd->alb_pushed,
 			    sd->sbe_pushed, sd->sbe_attempts,
-			    sd->ttwu_wake_affine, sd->ttwu_wake_balance);
+			    sd->ttwu_wake_remote, sd->ttwu_wake_affine, sd->ttwu_wake_balance);
 		}
 #endif
 	}
@@ -1058,6 +1048,10 @@ static int try_to_wake_up(task_t * p, un
 	unsigned long load, this_load;
 	struct sched_domain *sd;
 	int new_cpu;
+
+#ifdef CONFIG_SCHEDSTATS
+	struct sched_domain *stat_sd = NULL;
+#endif
 #endif
 
 	rq = task_rq_lock(p, &flags);
@@ -1076,8 +1070,19 @@ static int try_to_wake_up(task_t * p, un
 	if (unlikely(task_running(rq, p)))
 		goto out_activate;
 
-	new_cpu = cpu;
+#ifdef CONFIG_SCHEDSTATS
+	if (cpu != this_cpu) {
+		schedstat_inc(rq, ttwu_remote);
+		for_each_domain(this_cpu, stat_sd) {
+			if (cpu_isset(cpu, stat_sd->span)) {
+				schedstat_inc(stat_sd, ttwu_wake_remote);
+				break;
+			}
+		}
+	}
+#endif
 
+	new_cpu = cpu;
 	if (cpu == this_cpu || unlikely(!cpu_isset(this_cpu, p->cpus_allowed)))
 		goto out_set_cpu;
 
@@ -1103,30 +1108,32 @@ static int try_to_wake_up(task_t * p, un
 	 */
 	for_each_domain(this_cpu, sd) {
 		unsigned int imbalance;
-		/*
-		 * Start passive balancing when half the imbalance_pct
-		 * limit is reached.
-		 */
-		imbalance = sd->imbalance_pct + (sd->imbalance_pct - 100) / 2;
 
-		if ((sd->flags & SD_WAKE_AFFINE) &&
-				!task_hot(p, rq->timestamp_last_tick, sd)) {
+		if (cpu_isset(cpu, sd->span)) {
 			/*
-			 * This domain has SD_WAKE_AFFINE and p is cache cold
-			 * in this domain.
+			 * Start passive balancing when half the imbalance_pct
+			 * limit is reached.
 			 */
-			if (cpu_isset(cpu, sd->span)) {
-				schedstat_inc(sd, ttwu_wake_affine);
+			if ((sd->flags & SD_WAKE_AFFINE) &&
+				!task_hot(p, rq->timestamp_last_tick, sd)) {
+				/*
+				 * This domain has SD_WAKE_AFFINE and p is
+				 * cache cold in this domain.
+				 */
+				schedstat_inc(stat_sd, ttwu_wake_affine);
 				goto out_set_cpu;
 			}
-		} else if ((sd->flags & SD_WAKE_BALANCE) &&
+
+			imbalance = sd->imbalance_pct +
+					(sd->imbalance_pct - 100) / 2;
+
+			if ((sd->flags & SD_WAKE_BALANCE) &&
 				imbalance*this_load <= 100*load) {
-			/*
-			 * This domain has SD_WAKE_BALANCE and there is
-			 * an imbalance.
-			 */
-			if (cpu_isset(cpu, sd->span)) {
-				schedstat_inc(sd, ttwu_wake_balance);
+				/*
+				 * This domain has SD_WAKE_BALANCE and there is
+				 * an imbalance.
+				 */
+				schedstat_inc(stat_sd, ttwu_wake_balance);
 				goto out_set_cpu;
 			}
 		}
@@ -1134,10 +1141,8 @@ static int try_to_wake_up(task_t * p, un
 
 	new_cpu = cpu; /* Could not wake to this_cpu. Wake to cpu instead */
 out_set_cpu:
-	schedstat_inc(rq, ttwu_attempts);
 	new_cpu = wake_idle(new_cpu, p);
 	if (new_cpu != cpu && cpu_isset(new_cpu, p->cpus_allowed)) {
-		schedstat_inc(rq, ttwu_moved);
 		set_task_cpu(p, new_cpu);
 		task_rq_unlock(rq, &flags);
 		/* might preempt at this point */
@@ -1282,8 +1287,6 @@ void fastcall wake_up_new_task(task_t * 
 	this_cpu = smp_processor_id();
 	cpu = task_cpu(p);
 
-	schedstat_inc(rq, wunt_cnt);
-
 	array = rq->active;
 	if (unlikely(p->used_slice == -1)) {
 		p->used_slice = 0;
@@ -1329,8 +1332,6 @@ void fastcall wake_up_new_task(task_t * 
 		__activate_task(p, rq, array);
 		if (TASK_PREEMPTS_CURR(p, rq))
 			resched_task(rq->curr);
-
-		schedstat_inc(rq, wunt_moved);
 #endif
 	}
 	task_rq_unlock(rq, &flags);
@@ -1582,7 +1583,6 @@ static void sched_migrate_task(task_t *p
 	    || unlikely(cpu_is_offline(dest_cpu)))
 		goto out;
 
-	schedstat_inc(rq, smt_cnt);
 	/* force the process onto the specified CPU */
 	if (migrate_task(p, dest_cpu, &req)) {
 		/* Need to wait for migration thread (might exit: take ref). */
@@ -1610,7 +1610,6 @@ void sched_exec(void)
 	struct sched_domain *tmp, *sd = NULL;
 	int new_cpu, this_cpu = get_cpu();
 
-	schedstat_inc(this_rq(), sbe_cnt);
 	/* Prefer the current CPU if there's only this task running */
 	if (this_rq()->nr_running <= 1)
 		goto out;
@@ -1752,13 +1751,10 @@ skip_queue:
 		goto skip_bitmap;
 	}
 
-	/*
-	 * Right now, this is the only place pull_task() is called,
-	 * so we can safely collect pull_task() stats here rather than
-	 * inside pull_task().
-	 */
-	schedstat_inc(this_rq, pt_gained[idle]);
-	schedstat_inc(busiest, pt_lost[idle]);
+#ifdef CONFIG_SCHEDSTATS
+	if (task_hot(tmp, busiest->timestamp_last_tick, sd))
+		schedstat_inc(sd, lb_hot_pulled[idle]);
+#endif
 
 	pull_task(busiest, array, tmp, this_rq, dst_array, this_cpu);
 	pulled++;
@@ -1771,6 +1767,15 @@ skip_queue:
 		goto skip_bitmap;
 	}
 out:
+	/*
+	 * Right now, this is the only place pull_task() is called,
+	 * so we can safely collect pull_task() stats here rather than
+	 * inside pull_task().
+	 */
+	schedstat_add(this_rq, pt_gained[idle], pulled);
+	schedstat_add(busiest, pt_lost[idle], pulled);
+	schedstat_add(sd, lb_pulled[idle], pulled);
+
 	return pulled;
 }
 
@@ -2025,6 +2030,8 @@ static int load_balance(int this_cpu, ru
 	return nr_moved;
 
 out_balanced:
+	schedstat_inc(sd, lb_balanced[idle]);
+
 	/* tune up the balancing interval */
 	if (sd->balance_interval < sd->max_interval)
 		sd->balance_interval *= 2;
@@ -2066,8 +2073,11 @@ static int load_balance_newidle(int this
 	schedstat_add(sd, lb_imbalance[NEWLY_IDLE], imbalance);
 	nr_moved = move_tasks(this_rq, this_cpu, busiest,
 					imbalance, sd, NEWLY_IDLE);
-	if (!nr_moved)
+	if (!nr_moved) {
 		schedstat_inc(sd, lb_failed[NEWLY_IDLE]);
+	} else {
+		schedstat_inc(sd, lb_balanced[NEWLY_IDLE]);
+	}
 
 	spin_unlock(&busiest->lock);
 
@@ -2107,7 +2117,6 @@ static void active_load_balance(runqueue
 	struct sched_group *group, *busy_group;
 	int i;
 
-	schedstat_inc(busiest, alb_cnt);
 	if (busiest->nr_running <= 1)
 		return;
 
@@ -2117,6 +2126,8 @@ static void active_load_balance(runqueue
 	if (!sd)
 		return;
 
+	schedstat_inc(sd, alb_cnt);
+
 	group = sd->groups;
 	while (!cpu_isset(busiest_cpu, group->cpumask))
 		group = group->next;
@@ -2153,10 +2164,9 @@ static void active_load_balance(runqueue
 			goto next_group;
 		double_lock_balance(busiest, rq);
 		if (move_tasks(rq, push_cpu, busiest, 1, sd, IDLE)) {
-			schedstat_inc(busiest, alb_lost);
-			schedstat_inc(rq, alb_gained);
+			schedstat_inc(sd, alb_pushed);
 		} else {
-			schedstat_inc(busiest, alb_failed);
+			schedstat_inc(sd, alb_failed);
 		}
 		spin_unlock(&rq->lock);
 next_group:
@@ -2567,8 +2577,7 @@ go_idle:
 		rq->expired = array;
 		rq->expired->min_prio = MAX_PRIO;
 		array = rq->active;
-	} else
-		schedstat_inc(rq, sched_noswitch);
+	}
 
 	idx = sched_find_first_bit(array->bitmap);
 	queue = array->queue + idx;

_

--------------090006010803040306020905--
