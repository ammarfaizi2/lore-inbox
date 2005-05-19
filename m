Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbVESQ4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbVESQ4x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 12:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbVESQ4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 12:56:53 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:55589 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261158AbVESQ4o convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 12:56:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=tIU0gDlhW4MMYGDS/2gBQ8PFImxMo3H/XVTPHnLkn0xj1EQbfBk9EeXjVSlPmPWblqQuyPrVHd5iumIgEgX4CuiLywTKh2moFUwgCL2B3sNRbtqXqgNJ49XM2GAVuRqX8V0j2Q2siifcv/ZVqtYBJgRT0vdji7SNL5zFR8eXrr4=
Message-ID: <855e4e4605051909561f47351@mail.gmail.com>
Date: Thu, 19 May 2005 09:56:44 -0700
From: chen Shang <shangcs@gmail.com>
Reply-To: chen Shang <shangcs@gmail.com>
To: linux-kernel@vger.kernel.org, rml@tech9.net
Subject: [PATCH] kernel <linux-2.6.11.10> kernel/sched.c
Cc: shangcs@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Given the frequency of schedule() calling, there is a margin to
improve it. In step of recalculate task priority, it first dequeues
from one priority queue, calls recalc_task_prio(), then enqueue the
task into another priority queue. However, statistics shows only
around 0.5% of recalculation changed task priority (see below). While
rest of 99.5% of recalculation do not change priority, it is
reasonably to use requeue_task() to avoid overhead of dequeue and
enqueue on the same priority queue.

The patch is implemented with above idea. Note, a new help function,
change_queue_task(), to combine dequeue() and enqueue() to reduce one
function call overhead. Two statistics fields, sched_prio_changed and
sched_prio_unchanged, are added to provide statistic data on priority
recalculation.

Thanks,

chen
shangcs@gmail.com

/*===== Statistics ===== */
The statistics is based on Intel x86 machine with 2 Xeon 1.8G
processors with hyperthreading enable.
	Prio_unchanged	prio_changed	sched_cnt
CPU0	109			22743			59123 CPU1	120			23733			60407
CPU2	73			29981			86153 CPU3	96			22050			53094

/*===== Patch <linux-2.6.11.10> kernel/sched.c =====*/
--- linux-2.6.11.10.orig/kernel/sched.c	2005-05-16 10:51:53.000000000 -0700
+++ linux-2.6.11.10/kernel/sched.c	2005-05-18 22:31:32.000000000 -0700
@@ -249,6 +249,8 @@
 	unsigned long sched_noswitch;
 	unsigned long sched_switch;
 	unsigned long sched_cnt;
+	unsigned long sched_prio_changed;
+	unsigned long sched_prio_unchanged;
 	unsigned long sched_goidle;
 
 	/* pull_task() stats */
@@ -347,12 +349,20 @@
 
 		/* runqueue-specific stats */
 		seq_printf(seq,
-		    "cpu%d %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu "
-		    "%lu %lu %lu %lu %lu %lu %lu %lu %lu %lu",
+		    "cpu%d \n\tyld: both(%lu) act(%lu) both(%lu) cnt(%lu) "
+			"\n\tsched: noswitch(%lu) switch(%lu) "
+			"\n\t\t cnt(%lu) prio_changed(%lu) prio_unchanged(%lu)"
+			"\n\t\t goidle(%lu) "
+			"\n\talb: cnt(%lu) gained(%lu) lost(%lu) failed(%lu) "
+		    "\n\tttwu:cnt(%lu) moved(%lu) attempts(%lu) "
+			"\n\twunt: cnt(%lu) moved(%lu) "
+			"\n\tsmt: cnt(%lu) \n\tsbe: cnt(%lu) "
+			"\n\trq_sched_info: cpu_time(%lu) run_delay(%lu) pcnt(%lu)",
 		    cpu, rq->yld_both_empty,
 		    rq->yld_act_empty, rq->yld_exp_empty,
 		    rq->yld_cnt, rq->sched_noswitch,
-		    rq->sched_switch, rq->sched_cnt, rq->sched_goidle,
+		    rq->sched_switch, rq->sched_cnt, rq->sched_prio_changed, 
+			rq->sched_prio_unchanged, rq->sched_goidle,
 		    rq->alb_cnt, rq->alb_gained, rq->alb_lost,
 		    rq->alb_failed,
 		    rq->ttwu_cnt, rq->ttwu_moved, rq->ttwu_attempts,
@@ -374,14 +384,14 @@
 			seq_printf(seq, "domain%d %s", dcnt++, mask_str);
 			for (itype = SCHED_IDLE; itype < MAX_IDLE_TYPES;
 						itype++) {
-				seq_printf(seq, " %lu %lu %lu %lu %lu",
+				seq_printf(seq, "lb: cnt(%lu) failed(%lu) imbl(%lu) nobzq(%lu) %lu",
 				    sd->lb_cnt[itype],
 				    sd->lb_failed[itype],
 				    sd->lb_imbalance[itype],
 				    sd->lb_nobusyq[itype],
 				    sd->lb_nobusyg[itype]);
 			}
-			seq_printf(seq, " %lu %lu %lu %lu\n",
+			seq_printf(seq, "sbe: pushed(%lu) attempts(%lu) %lu %lu\n",
 			    sd->sbe_pushed, sd->sbe_attempts,
 			    sd->ttwu_wake_affine, sd->ttwu_wake_balance);
 		}
@@ -580,6 +590,18 @@
 	p->array = array;
 }
 
+static void change_queue_task(struct task_struct *p, prio_array_t *array, 
+							int old_prio)
+{
+	list_del(&p->run_list);
+	if (list_empty(array->queue + old_prio))
+		__clear_bit(old_prio, array->bitmap);
+	
+	sched_info_queued(p);
+	list_add_tail(&p->run_list, array->queue + p->prio);
+	__set_bit(p->prio, array->bitmap);
+	p->array = array;
+}
 /*
  * Put task to the end of the run list without the overhead of dequeue
  * followed by enqueue.
@@ -2668,7 +2690,7 @@
 	struct list_head *queue;
 	unsigned long long now;
 	unsigned long run_time;
-	int cpu, idx;
+	int cpu, idx, prio;
 
 	/*
 	 * Test if we are atomic.  Since do_exit() needs to call into
@@ -2787,9 +2809,19 @@
 			delta = delta * (ON_RUNQUEUE_WEIGHT * 128 / 100) / 128;
 
 		array = next->array;
-		dequeue_task(next, array);
+		prio = next->prio;
 		recalc_task_prio(next, next->timestamp + delta);
-		enqueue_task(next, array);
+		
+		if (unlikely(prio != next->prio))
+		{
+			change_queue_task(next, array, prio);
+			schedstat_inc(rq, sched_prio_changed);
+		}
+		else
+		{
+			requeue_task(next, array);
+			schedstat_inc(rq, sched_prio_unchanged);
+		}
 	}
 	next->activated = 0;
 switch_tasks:
