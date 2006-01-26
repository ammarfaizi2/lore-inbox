Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbWAZBJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbWAZBJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 20:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWAZBJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 20:09:57 -0500
Received: from omta04ps.mx.bigpond.com ([144.140.83.156]:16106 "EHLO
	omta04ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751223AbWAZBJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 20:09:56 -0500
Message-ID: <43D82161.6000809@bigpond.net.au>
Date: Thu, 26 Jan 2006 12:09:53 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paolo Ornati <ornati@fastwebnet.it>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Han <xiphux@gmail.com>, Con Kolivas <kernel@kolivas.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jake Moilanen <moilanen@austin.ibm.com>
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.2 for  2.6.16-rc1 and 2.6.16-rc1-mm1
References: <43D00887.6010409@bigpond.net.au>	<20060121114616.4a906b4f@localhost>	<43D2BE83.1020200@bigpond.net.au>	<43D40B96.3060705@bigpond.net.au>	<43D4281D.10009@bigpond.net.au> <20060123212158.3fba71d5@localhost>
In-Reply-To: <20060123212158.3fba71d5@localhost>
Content-Type: multipart/mixed;
 boundary="------------070908010708010307030903"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Thu, 26 Jan 2006 01:09:53 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070908010708010307030903
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Paolo Ornati wrote:
> On Mon, 23 Jan 2006 11:49:33 +1100
> Peter Williams <pwil3058@bigpond.net.au> wrote:
> 
> 
>>>However, in spite of the above, the fairness mechanism should have been 
>>>able to generate enough bonus points to get dd's priority back to less 
>>>than 34.  I'm still investigating why this didn't happen.
>>
>>Problem solved.  It was a scaling issue during the calculation of 
>>expected delay.  The attached patch should fix both the CPU hog problem 
>>and the fairness problem.  Could you give it a try?
>>
> 
> 
> Mmmm... it doesn't work:
> 
>  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>  5516 paolo     34   0  115m  18m 2432 S 87.5  3.7   0:23.72 transcode
>  5530 paolo     34   0 51000 4472 1872 S  8.0  0.9   0:02.29 tcdecode
>  5523 paolo     34   0 19840 1088  880 R  2.0  0.2   0:00.21 tcdemux
>  5522 paolo     34   0 22156 1204  972 R  0.7  0.2   0:00.02 tccat
>  5539 paolo     34   0  4952 1468  372 D  0.7  0.3   0:00.04 dd
>  5350 root      28   0  167m  16m 3228 S  0.3  3.4   0:03.64 X
> 
>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>  5456 paolo     34   0  115m  18m 2432 D 63.9  3.7   0:48.21 transcode
>  5470 paolo     37   0 50996 4472 1872 R  6.2  0.9   0:05.20 tcdecode
>  5493 paolo     34   0  4952 1472  372 R  1.5  0.3   0:00.22 dd
>  5441 paolo     28   0 86656  21m  15m S  0.2  4.4   0:00.77 konsole
>  5468 paolo     34   0 19840 1088  880 S  0.2  0.2   0:00.23 tcdemux
> 

I know that I've said this before but I've found the problem. 
Embarrassingly, it was a basic book keeping error (recently introduced 
and equivalent to getting nr_running wrong for each CPU) in the 
gathering of the statistics that I use. :-(

The attached patch (applied on top of the PlugSched patch) should fix 
things.  Could you test it please?

Thanks
Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

--------------070908010708010307030903
Content-Type: text/plain;
 name="fix-spa_ws-scheduler-v2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-spa_ws-scheduler-v2"

Index: MM-2.6.16/kernel/sched_spa_ws.c
===================================================================
--- MM-2.6.16.orig/kernel/sched_spa_ws.c	2006-01-21 16:42:45.000000000 +1100
+++ MM-2.6.16/kernel/sched_spa_ws.c	2006-01-26 11:44:14.000000000 +1100
@@ -44,7 +44,8 @@ static unsigned int initial_ia_bonus = D
 #define LSHARES_AVG_OFFSET 7
 #define LSHARES_AVG_ALPHA ((1 << LSHARES_AVG_OFFSET) - 2)
 #define LSHARES_AVG_INCR(a) ((a) << 1)
-#define LSHARES_AVG_ONE (1UL << LSHARES_AVG_OFFSET)
+#define LSHARES_AVG_REAL(s) ((s) << LSHARES_AVG_OFFSET)
+#define LSHARES_AVG_ONE LSAHRES_AVG_REAL(1UL)
 #define LSHARES_AVG_MUL(a, b) (((a) * (b)) >> LSHARES_AVG_OFFSET)
 
 static unsigned int max_fairness_bonus = DEF_MAX_FAIRNESS_BONUS;
@@ -121,32 +122,9 @@ static inline void zero_interactive_bonu
 	p->sdu.spa.interactive_bonus = 0;
 }
 
-static inline int current_fairness_bonus(const struct task_struct *p)
-{
-	return p->sdu.spa.auxilary_bonus >> FAIRNESS_BONUS_OFFSET;
-}
-
-static inline int current_fairness_bonus_rnd(const struct task_struct *p)
-{
-	return (p->sdu.spa.auxilary_bonus + (1UL << (FAIRNESS_BONUS_OFFSET - 1)))
-		>> FAIRNESS_BONUS_OFFSET;
-}
-
-static inline void decr_fairness_bonus(struct task_struct *p)
-{
-	p->sdu.spa.auxilary_bonus *= ((1UL << FAIRNESS_BONUS_OFFSET) - 2);
-	p->sdu.spa.auxilary_bonus >>= FAIRNESS_BONUS_OFFSET;
-}
-
-static inline void incr_fairness_bonus(struct task_struct *p)
-{
-	decr_fairness_bonus(p);
-	p->sdu.spa.auxilary_bonus += (max_fairness_bonus << 1);
-}
-
 static inline int bonuses(const struct task_struct *p)
 {
-	return current_ia_bonus_rnd(p) + current_fairness_bonus_rnd(p);
+	return current_ia_bonus_rnd(p) + p->sdu.spa.auxilary_bonus;
 }
 
 static int spa_ws_effective_prio(const struct task_struct *p)
@@ -211,43 +189,37 @@ static inline unsigned int map_ratio(uns
 
 static void spa_ws_reassess_fairness_bonus(struct task_struct *p)
 {
-	unsigned long long expected_delay;
+	unsigned long long expected_delay, adjusted_delay;
 	unsigned long long avg_lshares;
+	unsigned long pshares;
 
-#if 0
 	p->sdu.spa.auxilary_bonus = 0;
 	if (max_fairness_bonus == 0)
 		return;
-#endif
 
+	pshares = LSHARES_AVG_REAL(p->sdu.spa.eb_shares);
 	avg_lshares = per_cpu(rq_avg_lshares, task_cpu(p));
-	if (avg_lshares <= p->sdu.spa.eb_shares)
+	if (avg_lshares <= pshares)
 		expected_delay = 0;
 	else {
-		expected_delay = LSHARES_AVG_MUL(p->sdu.spa.avg_cpu_per_cycle,
-				      (avg_lshares - p->sdu.spa.eb_shares));
-		(void)do_div(expected_delay, p->sdu.spa.eb_shares);
+		expected_delay = p->sdu.spa.avg_cpu_per_cycle *
+			(avg_lshares - pshares);
+		(void)do_div(expected_delay, pshares);
 	}
-#if 1
-	if (p->sdu.spa.avg_delay_per_cycle > expected_delay)
-		incr_fairness_bonus(p);
-	else
-		decr_fairness_bonus(p);
-#else
+
 	/*
 	 * No delay means no bonus, but
 	 * NB this test also avoids a possible divide by zero error if
 	 * cpu is also zero and negative bonuses
 	 */
-	lhs = p->sdu.spa.avg_delay_per_cycle;
-	if (lhs <= rhs)
+	if (p->sdu.spa.avg_delay_per_cycle <= expected_delay)
 		return;
 
-	lhs  -= rhs;
+	adjusted_delay = p->sdu.spa.avg_delay_per_cycle - expected_delay;
 	p->sdu.spa.auxilary_bonus =
-		map_ratio(lhs, lhs + p->sdu.spa.avg_cpu_per_cycle,
+		map_ratio(adjusted_delay,
+			  adjusted_delay + p->sdu.spa.avg_cpu_per_cycle,
 			  max_fairness_bonus);
-#endif
 }
 
 static inline int spa_ws_eligible(struct task_struct *p)
@@ -255,6 +227,15 @@ static inline int spa_ws_eligible(struct
 	return p->sdu.spa.avg_sleep_per_cycle < WS_BIG_SLEEP;
 }
 
+static inline int spa_sleepiness_exceeds_ppt(const struct task_struct *p,
+					    unsigned int ppt)
+{
+	return RATIO_EXCEEDS_PPT(p->sdu.spa.avg_sleep_per_cycle,
+				 p->sdu.spa.avg_sleep_per_cycle +
+				 p->sdu.spa.avg_cpu_per_cycle,
+				 ppt);
+}
+
 static void spa_ws_reassess_at_activation(struct task_struct *p)
 {
 	spa_ws_reassess_fairness_bonus(p);
@@ -264,7 +245,7 @@ static void spa_ws_reassess_at_activatio
 		else
 			partial_incr_interactive_bonus(p);
 	}
-	else if (!spa_ia_sleepiness_exceeds_ppt(p, iab_decr_threshold))
+	else if (!spa_sleepiness_exceeds_ppt(p, iab_decr_threshold))
 		decr_interactive_bonus(p);
 	else if (!spa_ia_sleepiness_exceeds_ppt(p, (iab_decr_threshold + iab_incr_threshold) / 2))
 		partial_decr_interactive_bonus(p);
@@ -284,7 +265,7 @@ static void spa_ws_reassess_at_end_of_ts
 	/* Don't punish tasks that have done a lot of sleeping for the
 	 * occasional run of short sleeps unless they become a cpu hog.
 	 */
-	if (!spa_ia_sleepiness_exceeds_ppt(p, iab_decr_threshold))
+	if (!spa_sleepiness_exceeds_ppt(p, iab_decr_threshold))
 		decr_interactive_bonus(p);
 	else if (!spa_ia_sleepiness_exceeds_ppt(p, (iab_decr_threshold + iab_incr_threshold) / 2))
 		partial_decr_interactive_bonus(p);
Index: MM-2.6.16/kernel/sched_spa.c
===================================================================
--- MM-2.6.16.orig/kernel/sched_spa.c	2006-01-21 16:41:32.000000000 +1100
+++ MM-2.6.16/kernel/sched_spa.c	2006-01-26 11:43:20.000000000 +1100
@@ -490,18 +490,29 @@ static inline int effective_prio(const t
 	return spa_sched_child->normal_effective_prio(p);
 }
 
+static inline void spa_inc_nr_running(task_t *p, runqueue_t *rq)
+{
+	inc_nr_running(p, rq);
+	check_restart_promotions(rq);
+	if (!rt_task(p))
+		rq->qu.spa.nr_active_eb_shares += p->sdu.spa.eb_shares;
+}
+
+static inline void spa_dec_nr_running(task_t *p, runqueue_t *rq)
+{
+	dec_nr_running(p, rq);
+	check_stop_promotions(rq);
+	if (!rt_task(p))
+		rq->qu.spa.nr_active_eb_shares -= p->sdu.spa.eb_shares;
+}
+
 /*
  * __activate_task - move a task to the runqueue.
  */
 static inline void __activate_task(task_t *p, runqueue_t *rq)
 {
-	struct spa_runqueue_queue *rqq = &rq->qu.spa;
-
-	enqueue_task(p, rqq);
-	inc_nr_running(p, rq);
-	check_restart_promotions(rq);
-	if (!rt_task(p))
-		rqq->nr_active_eb_shares += p->sdu.spa.eb_shares;
+	enqueue_task(p, &rq->qu.spa);
+	spa_inc_nr_running(p, rq);
 }
 
 static inline void do_nothing_to_task(task_t *p) {}
@@ -536,11 +547,8 @@ static inline void deactivate_task(struc
 {
 	struct spa_runqueue_queue *rqq = &rq->qu.spa;
 
-	dec_nr_running(p, rq);
+	spa_dec_nr_running(p, rq);
 	dequeue_task(p, rqq);
-	check_stop_promotions(rq);
-	if (!rt_task(p))
-		rqq->nr_active_eb_shares -= p->sdu.spa.eb_shares;
 }
 
 /*
@@ -648,7 +656,7 @@ void spa_wake_up_new_task(task_t * p, un
 			} else {
 				p->prio = current->prio;
 				list_add_tail(&p->run_list, &current->run_list);
-				inc_nr_running(p, rq);
+				spa_inc_nr_running(p, rq);
 				check_restart_promotions(rq);
 			}
 			set_need_resched();
@@ -678,13 +686,11 @@ static inline
 void pull_task(runqueue_t *src_rq, task_t *p, runqueue_t *this_rq, int this_cpu)
 {
 	dequeue_task(p, &src_rq->qu.spa);
-	dec_nr_running(p, src_rq);
-	check_stop_promotions(src_rq);
+	spa_dec_nr_running(p, src_rq);
 	set_task_cpu(p, this_cpu);
 	adjust_timestamp(p, this_rq, src_rq);
-	inc_nr_running(p, this_rq);
+	spa_inc_nr_running(p, this_rq);
 	enqueue_task(p, &this_rq->qu.spa);
-	check_restart_promotions(this_rq);
 	preempt_if_warranted(p, this_rq);
 }
 
@@ -1333,7 +1339,7 @@ void spa_set_select_idle_first(struct ru
 	__setscheduler(rq->idle, SCHED_FIFO, MAX_RT_PRIO - 1);
 	/* Add idle task to _front_ of it's priority queue */
 	enqueue_task_head(rq->idle, &rq->qu.spa);
-	inc_nr_running(rq->idle, rq);
+	spa_inc_nr_running(rq->idle, rq);
 }
 
 void spa_set_select_idle_last(struct runqueue *rq)

--------------070908010708010307030903--
