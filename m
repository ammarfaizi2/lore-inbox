Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261883AbVBXHWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261883AbVBXHWW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 02:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbVBXHWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 02:22:21 -0500
Received: from smtp016.mail.yahoo.com ([216.136.174.113]:5529 "HELO
	smtp016.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261883AbVBXHSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 02:18:17 -0500
Subject: [PATCH 3/13] rework schedstats
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1109229415.5177.68.camel@npiggin-nld.site>
References: <1109229293.5177.64.camel@npiggin-nld.site>
	 <1109229362.5177.67.camel@npiggin-nld.site>
	 <1109229415.5177.68.camel@npiggin-nld.site>
Content-Type: multipart/mixed; boundary="=-GVtpZDBb1y99i2Flwgg5"
Date: Thu, 24 Feb 2005 18:18:10 +1100
Message-Id: <1109229491.5177.71.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GVtpZDBb1y99i2Flwgg5
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

3/13

I have an updated userspace parser for this thing, if you
are still keeping it on your website.


--=-GVtpZDBb1y99i2Flwgg5
Content-Disposition: attachment; filename=sched-stat.patch
Content-Type: text/x-patch; name=sched-stat.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Move balancing fields into struct sched_domain, so we can get more
useful results on systems with multiple domains (eg SMT+SMP, CMP+NUMA,
SMP+NUMA, etc).

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>

Index: linux-2.6/include/linux/sched.h
===================================================================
--- linux-2.6.orig/include/linux/sched.h	2005-02-24 17:31:24.598083557 +1100
+++ linux-2.6/include/linux/sched.h	2005-02-24 17:43:38.161526805 +1100
@@ -462,17 +462,26 @@
 	/* load_balance() stats */
 	unsigned long lb_cnt[MAX_IDLE_TYPES];
 	unsigned long lb_failed[MAX_IDLE_TYPES];
+	unsigned long lb_balanced[MAX_IDLE_TYPES];
 	unsigned long lb_imbalance[MAX_IDLE_TYPES];
+	unsigned long lb_gained[MAX_IDLE_TYPES];
+	unsigned long lb_hot_gained[MAX_IDLE_TYPES];
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
-	unsigned long ttwu_wake_affine;
-	unsigned long ttwu_wake_balance;
+	unsigned long ttwu_wake_remote;
+	unsigned long ttwu_move_affine;
+	unsigned long ttwu_move_balance;
 #endif
 };
 
Index: linux-2.6/kernel/sched.c
===================================================================
--- linux-2.6.orig/kernel/sched.c	2005-02-24 17:31:27.503724395 +1100
+++ linux-2.6/kernel/sched.c	2005-02-24 17:43:38.983425407 +1100
@@ -246,35 +246,13 @@
 	unsigned long yld_cnt;
 
 	/* schedule() stats */
-	unsigned long sched_noswitch;
 	unsigned long sched_switch;
 	unsigned long sched_cnt;
 	unsigned long sched_goidle;
 
-	/* pull_task() stats */
-	unsigned long pt_gained[MAX_IDLE_TYPES];
-	unsigned long pt_lost[MAX_IDLE_TYPES];
-
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
+	unsigned long ttwu_local;
 #endif
 };
 
@@ -329,7 +307,7 @@
  * bump this up when changing the output format or the meaning of an existing
  * format, so that tools can adapt (or abort)
  */
-#define SCHEDSTAT_VERSION 10
+#define SCHEDSTAT_VERSION 11
 
 static int show_schedstat(struct seq_file *seq, void *v)
 {
@@ -347,22 +325,14 @@
 
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
+		    rq->ttwu_cnt, rq->ttwu_local,
+		    rq->rq_sched_info.cpu_time,
 		    rq->rq_sched_info.run_delay, rq->rq_sched_info.pcnt);
 
-		for (itype = SCHED_IDLE; itype < MAX_IDLE_TYPES; itype++)
-			seq_printf(seq, " %lu %lu", rq->pt_gained[itype],
-						    rq->pt_lost[itype]);
 		seq_printf(seq, "\n");
 
 #ifdef CONFIG_SMP
@@ -373,17 +343,21 @@
 			cpumask_scnprintf(mask_str, NR_CPUS, sd->span);
 			seq_printf(seq, "domain%d %s", dcnt++, mask_str);
 			for (itype = SCHED_IDLE; itype < MAX_IDLE_TYPES;
-						itype++) {
-				seq_printf(seq, " %lu %lu %lu %lu %lu",
+					itype++) {
+				seq_printf(seq, " %lu %lu %lu %lu %lu %lu %lu %lu",
 				    sd->lb_cnt[itype],
+				    sd->lb_balanced[itype],
 				    sd->lb_failed[itype],
 				    sd->lb_imbalance[itype],
+				    sd->lb_gained[itype],
+				    sd->lb_hot_gained[itype],
 				    sd->lb_nobusyq[itype],
 				    sd->lb_nobusyg[itype]);
 			}
-			seq_printf(seq, " %lu %lu %lu %lu\n",
+			seq_printf(seq, " %lu %lu %lu %lu %lu %lu %lu %lu\n",
+			    sd->alb_cnt, sd->alb_failed, sd->alb_pushed,
 			    sd->sbe_pushed, sd->sbe_attempts,
-			    sd->ttwu_wake_affine, sd->ttwu_wake_balance);
+			    sd->ttwu_wake_remote, sd->ttwu_move_affine, sd->ttwu_move_balance);
 		}
 #endif
 	}
@@ -996,7 +970,6 @@
 #endif
 
 	rq = task_rq_lock(p, &flags);
-	schedstat_inc(rq, ttwu_cnt);
 	old_state = p->state;
 	if (!(old_state & state))
 		goto out;
@@ -1011,8 +984,21 @@
 	if (unlikely(task_running(rq, p)))
 		goto out_activate;
 
-	new_cpu = cpu;
+#ifdef CONFIG_SCHEDSTATS
+	schedstat_inc(rq, ttwu_cnt);
+	if (cpu == this_cpu) {
+		schedstat_inc(rq, ttwu_local);
+	} else {
+		for_each_domain(this_cpu, sd) {
+			if (cpu_isset(cpu, sd->span)) {
+				schedstat_inc(sd, ttwu_wake_remote);
+				break;
+			}
+		}
+	}
+#endif
 
+	new_cpu = cpu;
 	if (cpu == this_cpu || unlikely(!cpu_isset(this_cpu, p->cpus_allowed)))
 		goto out_set_cpu;
 
@@ -1051,7 +1037,7 @@
 			 * in this domain.
 			 */
 			if (cpu_isset(cpu, sd->span)) {
-				schedstat_inc(sd, ttwu_wake_affine);
+				schedstat_inc(sd, ttwu_move_affine);
 				goto out_set_cpu;
 			}
 		} else if ((sd->flags & SD_WAKE_BALANCE) &&
@@ -1061,7 +1047,7 @@
 			 * an imbalance.
 			 */
 			if (cpu_isset(cpu, sd->span)) {
-				schedstat_inc(sd, ttwu_wake_balance);
+				schedstat_inc(sd, ttwu_move_balance);
 				goto out_set_cpu;
 			}
 		}
@@ -1069,10 +1055,8 @@
 
 	new_cpu = cpu; /* Could not wake to this_cpu. Wake to cpu instead */
 out_set_cpu:
-	schedstat_inc(rq, ttwu_attempts);
 	new_cpu = wake_idle(new_cpu, p);
 	if (new_cpu != cpu) {
-		schedstat_inc(rq, ttwu_moved);
 		set_task_cpu(p, new_cpu);
 		task_rq_unlock(rq, &flags);
 		/* might preempt at this point */
@@ -1215,7 +1199,6 @@
 
 	BUG_ON(p->state != TASK_RUNNING);
 
-	schedstat_inc(rq, wunt_cnt);
 	/*
 	 * We decrease the sleep average of forking parents
 	 * and children as well, to keep max-interactive tasks
@@ -1267,7 +1250,6 @@
 		if (TASK_PREEMPTS_CURR(p, rq))
 			resched_task(rq->curr);
 
-		schedstat_inc(rq, wunt_moved);
 		/*
 		 * Parent and child are on different CPUs, now get the
 		 * parent runqueue to update the parent's ->sleep_avg:
@@ -1571,7 +1553,6 @@
 	    || unlikely(cpu_is_offline(dest_cpu)))
 		goto out;
 
-	schedstat_inc(rq, smt_cnt);
 	/* force the process onto the specified CPU */
 	if (migrate_task(p, dest_cpu, &req)) {
 		/* Need to wait for migration thread (might exit: take ref). */
@@ -1599,7 +1580,6 @@
 	struct sched_domain *tmp, *sd = NULL;
 	int new_cpu, this_cpu = get_cpu();
 
-	schedstat_inc(this_rq(), sbe_cnt);
 	/* Prefer the current CPU if there's only this task running */
 	if (this_rq()->nr_running <= 1)
 		goto out;
@@ -1744,13 +1724,10 @@
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
+		schedstat_inc(sd, lb_hot_gained[idle]);
+#endif
 
 	pull_task(busiest, array, tmp, this_rq, dst_array, this_cpu);
 	pulled++;
@@ -1766,6 +1743,14 @@
 	*all_pinned = 0;
 	if (unlikely(pinned >= max_nr_move) && pulled == 0)
 		*all_pinned = 1;
+
+	/*
+	 * Right now, this is the only place pull_task() is called,
+	 * so we can safely collect pull_task() stats here rather than
+	 * inside pull_task().
+	 */
+	schedstat_add(sd, lb_gained[idle], pulled);
+
 	return pulled;
 }
 
@@ -2031,6 +2016,8 @@
 out_balanced:
 	spin_unlock(&this_rq->lock);
 
+	schedstat_inc(sd, lb_balanced[idle]);
+
 	/* tune up the balancing interval */
 	if (sd->balance_interval < sd->max_interval)
 		sd->balance_interval *= 2;
@@ -2056,12 +2043,14 @@
 	schedstat_inc(sd, lb_cnt[NEWLY_IDLE]);
 	group = find_busiest_group(sd, this_cpu, &imbalance, NEWLY_IDLE);
 	if (!group) {
+		schedstat_inc(sd, lb_balanced[NEWLY_IDLE]);
 		schedstat_inc(sd, lb_nobusyg[NEWLY_IDLE]);
 		goto out;
 	}
 
 	busiest = find_busiest_queue(group);
 	if (!busiest || busiest == this_rq) {
+		schedstat_inc(sd, lb_balanced[NEWLY_IDLE]);
 		schedstat_inc(sd, lb_nobusyq[NEWLY_IDLE]);
 		goto out;
 	}
@@ -2115,7 +2104,6 @@
 	cpumask_t visited_cpus;
 	int cpu;
 
-	schedstat_inc(busiest_rq, alb_cnt);
 	/*
 	 * Search for suitable CPUs to push tasks to in successively higher
 	 * domains with SD_LOAD_BALANCE set.
@@ -2126,6 +2114,8 @@
 			/* no more domains to search */
 			break;
 
+		schedstat_inc(sd, alb_cnt);
+
 		cpu_group = sd->groups;
 		do {
 			for_each_cpu_mask(cpu, cpu_group->cpumask) {
@@ -2151,10 +2141,9 @@
 				double_lock_balance(busiest_rq, target_rq);
 				if (move_tasks(target_rq, cpu, busiest_rq,
 					1, sd, SCHED_IDLE, &all_pinned)) {
-					schedstat_inc(busiest_rq, alb_lost);
-					schedstat_inc(target_rq, alb_gained);
+					schedstat_inc(sd, alb_pushed);
 				} else {
-					schedstat_inc(busiest_rq, alb_failed);
+					schedstat_inc(sd, alb_failed);
 				}
 				spin_unlock(&target_rq->lock);
 			}
@@ -2787,8 +2776,7 @@
 		array = rq->active;
 		rq->expired_timestamp = 0;
 		rq->best_expired_prio = MAX_PRIO;
-	} else
-		schedstat_inc(rq, sched_noswitch);
+	}
 
 	idx = sched_find_first_bit(array->bitmap);
 	queue = array->queue + idx;

--=-GVtpZDBb1y99i2Flwgg5--

http://mobile.yahoo.com.au - Yahoo! Mobile
- Check & compose your email via SMS on your Telstra or Vodafone mobile.
