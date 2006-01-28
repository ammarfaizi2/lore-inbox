Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbWA1XoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbWA1XoV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 18:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbWA1XoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 18:44:21 -0500
Received: from omta03sl.mx.bigpond.com ([144.140.92.155]:56936 "EHLO
	omta03sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750792AbWA1XoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 18:44:21 -0500
Message-ID: <43DC01D1.9040902@bigpond.net.au>
Date: Sun, 29 Jan 2006 10:44:17 +1100
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
References: <43D00887.6010409@bigpond.net.au>	<20060121114616.4a906b4f@localhost>	<43D2BE83.1020200@bigpond.net.au>	<43D40B96.3060705@bigpond.net.au>	<43D4281D.10009@bigpond.net.au>	<20060123212158.3fba71d5@localhost>	<43D82161.6000809@bigpond.net.au> <20060126091129.53de58fa@localhost> <43D94E62.6080603@bigpond.net.au>
In-Reply-To: <43D94E62.6080603@bigpond.net.au>
Content-Type: multipart/mixed;
 boundary="------------080301010703080601040006"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sat, 28 Jan 2006 23:44:17 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080301010703080601040006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Peter Williams wrote:
> Paolo Ornati wrote:
> 
>> On Thu, 26 Jan 2006 12:09:53 +1100
>> Peter Williams <pwil3058@bigpond.net.au> wrote:
>>
>>
>>> I know that I've said this before but I've found the problem. 
>>> Embarrassingly, it was a basic book keeping error (recently 
>>> introduced and equivalent to getting nr_running wrong for each CPU) 
>>> in the gathering of the statistics that I use. :-(
>>>
>>> The attached patch (applied on top of the PlugSched patch) should fix 
>>> things.  Could you test it please?
>>
>>
>>
>> Ok, this one make a difference:
>>
>> (transcode)
>>
>>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>>  5774 paolo     34   0  116m  18m 2432 R 86.2  3.7   0:11.65 transcode
>>  5788 paolo     32   0 51000 4472 1872 S  7.5  0.9   0:01.13 tcdecode
>>  5797 paolo     29   0  4948 1468  372 D  3.2  0.3   0:00.30 dd
>>  5781 paolo     33   0 19844 1092  880 S  1.0  0.2   0:00.10 tcdemux
>>  5783 paolo     31   0 47964 2496 1956 S  0.7  0.5   0:00.08 tcdecode
>>  5786 paolo     34   0 19840 1088  880 R  0.5  0.2   0:00.06 tcdemux
>>
>> (sched_fooler)
>>
>>  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>>  5804 paolo     34   0  2396  292  228 R 35.7  0.1   0:12.84 a.out
>>  5803 paolo     34   0  2392  288  228 R 30.5  0.1   0:11.49 a.out
>>  5805 paolo     34   0  2392  288  228 R 30.2  0.1   0:10.70 a.out
>>  5815 paolo     29   0  4948 1468  372 D  3.7  0.3   0:00.29 dd
>>  5458 paolo     28   0 86656  21m  15m S  0.2  4.4   0:02.18 konsole
>>
>>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>>  5804 paolo     34   0  2396  292  228 R 36.5  0.1   0:38.19 a.out
>>  5803 paolo     34   0  2392  288  228 R 30.5  0.1   0:34.27 a.out
>>  5805 paolo     34   0  2392  288  228 R 29.2  0.1   0:32.39 a.out
>>  5829 paolo     34   0  4952 1472  372 R  3.2  0.3   0:00.35 dd
>>
>> DD_TEST + sched_fooler: 512 MB --- ~20s instead of 16.6s
>>
>> This is a clear improvement... however I wonder why DD priority
>> fluctuate going up even to 34 (the range is something like 29 <--->
>> 34).
>>
> 
> It's because the "fairness" bonus is still being done as a one shot 
> bonus when a task's delay time become unfairly large.  I mentioned this 
> before as possibly needing to be changed to a more persistent model but 
> after I discovered the accounting bug I deferred doing anything about it 
> in the hope that fixing the bug would have been sufficient.
> 
> I'll now try a model whereby a task's fairness bonus is increased 
> whenever it has unfair delays and decreased when it doesn't.  Hopefully, 
> with the right rates of increase/decrease, this can result in a system 
> where a task has a fairly persistent bonus which is sufficient to give 
> it its fair share.  One reason that I've been avoiding this method is 
> that it introduces double smoothing: once in the calculation of the 
> average delay time and then again in the determination of the bonus; and 
> I'm concerned this may make it slow to react to change.  Any way I'll 
> give it a try and see what happens.

Attached is a patch which makes the fairness bonuses more persistent.  I 
should be applied on top of the last patch that I sent.  Could you test 
it please?

Thanks
Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

--------------080301010703080601040006
Content-Type: text/plain;
 name="spa_ws-persistent-fairness"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="spa_ws-persistent-fairness"

Index: MM-2.6.16/kernel/sched_spa_ws.c
===================================================================
--- MM-2.6.16.orig/kernel/sched_spa_ws.c	2006-01-26 12:21:50.000000000 +1100
+++ MM-2.6.16/kernel/sched_spa_ws.c	2006-01-29 10:00:21.000000000 +1100
@@ -45,12 +45,20 @@ static unsigned int initial_ia_bonus = D
 #define LSHARES_AVG_ALPHA ((1 << LSHARES_AVG_OFFSET) - 2)
 #define LSHARES_AVG_INCR(a) ((a) << 1)
 #define LSHARES_AVG_REAL(s) ((s) << LSHARES_AVG_OFFSET)
-#define LSHARES_AVG_ONE LSAHRES_AVG_REAL(1UL)
+#define LSHARES_AVG_ONE LSHARES_AVG_REAL(1UL)
 #define LSHARES_AVG_MUL(a, b) (((a) * (b)) >> LSHARES_AVG_OFFSET)
 
 static unsigned int max_fairness_bonus = DEF_MAX_FAIRNESS_BONUS;
 
-#define FAIRNESS_BONUS_OFFSET	8
+#define FAIRNESS_BONUS_OFFSET	5
+#define FAIRNESS_ALPHA		((1UL << FAIRNESS_BONUS_OFFSET) - 2)
+#define FAIRNESS_ALPHA_COMPL	2
+
+static inline int fairness_bonus(const struct task_struct *p)
+{
+	return (p->sdu.spa.auxilary_bonus * max_fairness_bonus) >>
+		FAIRNESS_BONUS_OFFSET;
+}
 
 static DEFINE_PER_CPU(unsigned long, rq_avg_lshares);
 
@@ -124,7 +132,7 @@ static inline void zero_interactive_bonu
 
 static inline int bonuses(const struct task_struct *p)
 {
-	return current_ia_bonus_rnd(p) + p->sdu.spa.auxilary_bonus;
+	return current_ia_bonus_rnd(p) + fairness_bonus(p);
 }
 
 static int spa_ws_effective_prio(const struct task_struct *p)
@@ -161,65 +169,22 @@ static void spa_ws_fork(struct task_stru
 	p->sdu.spa.interactive_bonus <<= IA_BONUS_OFFSET;
 }
 
-static inline unsigned int map_ratio(unsigned long long a,
-				     unsigned long long b,
-				     unsigned int range)
-{
-	a *= range;
-
-#if BITS_PER_LONG < 64
-	/*
-	 * Assume that there's no 64 bit divide available
-	 */
-	if (a < b)
-		return 0;
-	/*
-	 * Scale down until b less than 32 bits so that we can do
-	 * a divide using do_div()
-	 */
-	while (b > ULONG_MAX) { a >>= 1; b >>= 1; }
-
-	(void)do_div(a, (unsigned long)b);
-
-	return a;
-#else
-	return a / b;
-#endif
-}
-
 static void spa_ws_reassess_fairness_bonus(struct task_struct *p)
 {
-	unsigned long long expected_delay, adjusted_delay;
-	unsigned long long avg_lshares;
-	unsigned long pshares;
-
-	p->sdu.spa.auxilary_bonus = 0;
-	if (max_fairness_bonus == 0)
-		return;
+	unsigned long long expected_delay;
+	unsigned long long wanr; /* weighted average number running */
 
-	pshares = LSHARES_AVG_REAL(p->sdu.spa.eb_shares);
-	avg_lshares = per_cpu(rq_avg_lshares, task_cpu(p));
-	if (avg_lshares <= pshares)
+	wanr = per_cpu(rq_avg_lshares, task_cpu(p)) / p->sdu.spa.eb_shares;
+	if (wanr <= LSHARES_AVG_ONE)
 		expected_delay = 0;
-	else {
-		expected_delay = p->sdu.spa.avg_cpu_per_cycle *
-			(avg_lshares - pshares);
-		(void)do_div(expected_delay, pshares);
-	}
-
-	/*
-	 * No delay means no bonus, but
-	 * NB this test also avoids a possible divide by zero error if
-	 * cpu is also zero and negative bonuses
-	 */
-	if (p->sdu.spa.avg_delay_per_cycle <= expected_delay)
-		return;
-
-	adjusted_delay = p->sdu.spa.avg_delay_per_cycle - expected_delay;
-	p->sdu.spa.auxilary_bonus =
-		map_ratio(adjusted_delay,
-			  adjusted_delay + p->sdu.spa.avg_cpu_per_cycle,
-			  max_fairness_bonus);
+	else
+		expected_delay = LSHARES_AVG_MUL(p->sdu.spa.avg_cpu_per_cycle,
+						(wanr - LSHARES_AVG_ONE));
+
+	p->sdu.spa.auxilary_bonus *= FAIRNESS_ALPHA;
+	p->sdu.spa.auxilary_bonus >>= FAIRNESS_BONUS_OFFSET;
+	if (p->sdu.spa.avg_delay_per_cycle > expected_delay)
+		p->sdu.spa.auxilary_bonus += FAIRNESS_ALPHA_COMPL;
 }
 
 static inline int spa_ws_eligible(struct task_struct *p)

--------------080301010703080601040006--
