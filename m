Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964792AbWAWAti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbWAWAti (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 19:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbWAWAth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 19:49:37 -0500
Received: from omta05ps.mx.bigpond.com ([144.140.83.195]:44226 "EHLO
	omta05ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S964792AbWAWAth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 19:49:37 -0500
Message-ID: <43D4281D.10009@bigpond.net.au>
Date: Mon, 23 Jan 2006 11:49:33 +1100
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
References: <43D00887.6010409@bigpond.net.au> <20060121114616.4a906b4f@localhost> <43D2BE83.1020200@bigpond.net.au> <43D40B96.3060705@bigpond.net.au>
In-Reply-To: <43D40B96.3060705@bigpond.net.au>
Content-Type: multipart/mixed;
 boundary="------------030105040600080307030905"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Mon, 23 Jan 2006 00:49:34 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030105040600080307030905
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Peter Williams wrote:
> Peter Williams wrote:
> 
>> Paolo Ornati wrote:
>>
>>> On Fri, 20 Jan 2006 08:45:43 +1100
>>> Peter Williams <pwil3058@bigpond.net.au> wrote:
>>>
>>>
>>>> Modifications have been made to spa_ws to (hopefully) address the 
>>>> issues raised by Paolo Ornati recently and a new entitlement based 
>>>> interpretation of "nice" scheduler, spa_ebs, which is a cut down 
>>>> version of the Zaphod schedulers "eb" mode has been added as this 
>>>> mode of Zaphod performed will for Paolo's problem when he tried it 
>>>> at my request. Paolo, could you please give these a test drive on 
>>>> your problem?
>>>
>>>
>>>
>>>
>>> ---- spa_ws: the problem is still here
>>>
>>> (sched_fooler)
>>> ./a.out 3000 & ./a.out 4307 &
>>>
>>>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>>>  5573 paolo     34   0  2396  292  228 R 59.0  0.1   0:24.51 a.out
>>>  5572 paolo     34   0  2392  288  228 R 40.7  0.1   0:16.94 a.out
>>>  5580 paolo     35   0  4948 1468  372 R  0.3  0.3   0:00.04 dd
>>>
>>>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>>>  5573 paolo     34   0  2396  292  228 R 59.3  0.1   0:59.65 a.out
>>>  5572 paolo     33   0  2392  288  228 R 40.3  0.1   0:41.32 a.out
>>>  5440 paolo     28   0 86652  21m  15m S  0.3  4.4   0:03.34 konsole
>>>  5580 paolo     37   0  4948 1468  372 R  0.3  0.3   0:00.10 dd
>>>
>>>
>>> (real life - transcode)
>>>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>>>  5585 paolo     33   0  115m  18m 2432 S 90.0  3.7   0:38.04 transcode
>>>  5599 paolo     37   0 50996 4472 1872 R  9.1  0.9   0:04.03 tcdecode
>>>  5610 paolo     37   0  4948 1468  372 R  0.6  0.3   0:00.19 dd
>>>
>>>
>>> DD test takes ages in both cases.
>>>
>>> What exactly have you done to spa_ws?
>>
>>
>>
>> I added a "nice aware" version of the throughput bonuses from spa_svr 
>> and renamed them fairness bonus.  They don't appear to be working :-(
>>
>> 34 is the priority value that ordinary tasks should end up with i.e. 
>> if they don't look like interactive tasks or CPU hogs.  If they look 
>> like interactive tasks they should get a lower one via the interactive 
>> bonus mechanism and if they look like CPU hogs they should get a 
>> higher one via the same mechanism.  In addition to this tasks will get 
>> bonuses if they seem to be being treated unfairly i.e. spending too 
>> much time on run queues waiting for CPU access.
>>
>> Looking at your numbers the transcode task has the priority that I'd 
>> expect it to have but tcdecode and dd seem to have had their 
>> priorities adjusted in the wrong direction.   It's almost like they'd 
>> been (incorrectly, obviously) identified as CPU hogs :-(.  I'll look 
>> into this.
> 
> 
> I forgot that I'd also made changes to the "CPU hog" component of the 
> interactive response as the one I had was useless on heavily loaded 
> systems.  It appears that I made a mistake (I used interactive 
> sleepiness instead of ordinary sleepiness for detecting CPU hogs) during 
> these changes which means that tasks that do no interactive sleeping 
> (such as your dd) get classified as CPU hogs.  The transcode task 
> escapes this because, although its sleeps aren't really interactive, 
> they're classified as such.  More widespread us of TASK_NONINTERACTIVE 
> would fix this but would need to be done carefully as it would risk 
> breaking the normal scheduler.
> 
> However, in spite of the above, the fairness mechanism should have been 
> able to generate enough bonus points to get dd's priority back to less 
> than 34.  I'm still investigating why this didn't happen.

Problem solved.  It was a scaling issue during the calculation of 
expected delay.  The attached patch should fix both the CPU hog problem 
and the fairness problem.  Could you give it a try?

Thanks,
Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

--------------030105040600080307030905
Content-Type: text/plain;
 name="fix-spa_ws-scheduler"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-spa_ws-scheduler"

Index: MM-2.6.16/kernel/sched_spa_ws.c
===================================================================
--- MM-2.6.16.orig/kernel/sched_spa_ws.c	2006-01-21 16:42:45.000000000 +1100
+++ MM-2.6.16/kernel/sched_spa_ws.c	2006-01-23 11:42:32.000000000 +1100
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
@@ -211,43 +189,36 @@ static inline unsigned int map_ratio(uns
 
 static void spa_ws_reassess_fairness_bonus(struct task_struct *p)
 {
-	unsigned long long expected_delay;
+	unsigned long long expected_delay, adjusted_delay;
 	unsigned long long avg_lshares;
+	unsigned long pshares = LSHARES_AVG_REAL(p->sdu.spa.eb_shares);
 
-#if 0
 	p->sdu.spa.auxilary_bonus = 0;
 	if (max_fairness_bonus == 0)
 		return;
-#endif
 
 	avg_lshares = per_cpu(rq_avg_lshares, task_cpu(p));
-	if (avg_lshares <= p->sdu.spa.eb_shares)
+	if (avg_lshares <= pshares)
 		expected_delay = 0;
 	else {
 		expected_delay = LSHARES_AVG_MUL(p->sdu.spa.avg_cpu_per_cycle,
-				      (avg_lshares - p->sdu.spa.eb_shares));
-		(void)do_div(expected_delay, p->sdu.spa.eb_shares);
+				      (avg_lshares - pshares));
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
@@ -255,6 +226,15 @@ static inline int spa_ws_eligible(struct
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
@@ -264,7 +244,7 @@ static void spa_ws_reassess_at_activatio
 		else
 			partial_incr_interactive_bonus(p);
 	}
-	else if (!spa_ia_sleepiness_exceeds_ppt(p, iab_decr_threshold))
+	else if (!spa_sleepiness_exceeds_ppt(p, iab_decr_threshold))
 		decr_interactive_bonus(p);
 	else if (!spa_ia_sleepiness_exceeds_ppt(p, (iab_decr_threshold + iab_incr_threshold) / 2))
 		partial_decr_interactive_bonus(p);
@@ -284,7 +264,7 @@ static void spa_ws_reassess_at_end_of_ts
 	/* Don't punish tasks that have done a lot of sleeping for the
 	 * occasional run of short sleeps unless they become a cpu hog.
 	 */
-	if (!spa_ia_sleepiness_exceeds_ppt(p, iab_decr_threshold))
+	if (!spa_sleepiness_exceeds_ppt(p, iab_decr_threshold))
 		decr_interactive_bonus(p);
 	else if (!spa_ia_sleepiness_exceeds_ppt(p, (iab_decr_threshold + iab_incr_threshold) / 2))
 		partial_decr_interactive_bonus(p);

--------------030105040600080307030905--
