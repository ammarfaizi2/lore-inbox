Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263117AbUHDKhy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbUHDKhy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 06:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264098AbUHDKhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 06:37:54 -0400
Received: from mx1.elte.hu ([157.181.1.137]:51158 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263117AbUHDKhM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 06:37:12 -0400
Date: Wed, 4 Aug 2004 12:31:43 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2-mm2
Message-ID: <20040804103143.GA13072@elte.hu>
References: <20040802015527.49088944.akpm@osdl.org> <410E3CAF.6080305@kolivas.org> <410F3423.3020409@yahoo.com.au> <cone.1091518501.973503.9648.502@pc.kolivas.org> <cone.1091519122.804104.9648.502@pc.kolivas.org> <41109FCC.4070906@yahoo.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
In-Reply-To: <41109FCC.4070906@yahoo.com.au>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9, BAYES_00 -4.90,
	UPPERCASE_25_50 0.00
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> Also, basic interactivity in X is bad with the interactive sysctl set
> to 0 (is X supposed to be at nice 0?), however fairness is bad when
> interactive is 1. I'm not sure if this is an acceptable tradeoff - are
> you planning to fix it?

it also has clear interactivity problems when just running lots of CPU
hogs even with the default interactive=1 compute=0 setting.

> Increasing priority (negative nice) doesn't have much impact. -20 CPU
> hog only gets about double the CPU of a 0 priority CPU hog and only
> about 120% the CPU time of a nice -10 hog.

this is a property of the base scheduler as well.

We can do a nonlinear timeslice distribution trivially - the attached
patch implements the following timeslice distribution ontop of
2.6.8-rc3:

   [ -20 ... 0 ... 19 ] => [800ms ... 100ms ... 5ms]

the patch also cleans up some other aspects of timeslice calculations -
with it applied nice +19 tasks will get 20 times less CPU time than
default tasks. Previously it was 1:10.

the nice-20/nice+19 ratio is now 1:160 - sufficient for all aspects.

	Ingo

--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sched-2.6.8-rc2-mm2-A2"

--- linux/kernel/sched.c.orig	
+++ linux/kernel/sched.c	
@@ -68,8 +68,6 @@
 #define USER_PRIO(p)		((p)-MAX_RT_PRIO)
 #define TASK_USER_PRIO(p)	USER_PRIO((p)->static_prio)
 #define MAX_USER_PRIO		(USER_PRIO(MAX_PRIO))
-#define AVG_TIMESLICE	(MIN_TIMESLICE + ((MAX_TIMESLICE - MIN_TIMESLICE) *\
-			(MAX_PRIO-1-NICE_TO_PRIO(0))/(MAX_USER_PRIO - 1)))
 
 /*
  * Some helpers for converting nanosecond timing to jiffy resolution
@@ -80,12 +78,12 @@
 /*
  * These are the 'tuning knobs' of the scheduler:
  *
- * Minimum timeslice is 10 msecs, default timeslice is 100 msecs,
- * maximum timeslice is 200 msecs. Timeslices get refilled after
- * they expire.
+ * Minimum timeslice is 5 msecs (or 1 jiffy, whichever is larger),
+ * default timeslice is 100 msecs, maximum timeslice is 800 msecs.
+ * Timeslices get refilled after they expire.
  */
-#define MIN_TIMESLICE		( 10 * HZ / 1000)
-#define MAX_TIMESLICE		(200 * HZ / 1000)
+#define MIN_TIMESLICE		max(5 * HZ / 1000, 1)
+#define DEF_TIMESLICE		(100 * HZ / 1000)
 #define ON_RUNQUEUE_WEIGHT	 30
 #define CHILD_PENALTY		 95
 #define PARENT_PENALTY		100
@@ -93,7 +91,7 @@
 #define PRIO_BONUS_RATIO	 25
 #define MAX_BONUS		(MAX_USER_PRIO * PRIO_BONUS_RATIO / 100)
 #define INTERACTIVE_DELTA	  2
-#define MAX_SLEEP_AVG		(AVG_TIMESLICE * MAX_BONUS)
+#define MAX_SLEEP_AVG		(DEF_TIMESLICE * MAX_BONUS)
 #define STARVATION_LIMIT	(MAX_SLEEP_AVG)
 #define NS_MAX_SLEEP_AVG	(JIFFIES_TO_NS(MAX_SLEEP_AVG))
 #define CREDIT_LIMIT		100
@@ -162,23 +160,23 @@
 	((p)->prio < (rq)->curr->prio)
 
 /*
- * BASE_TIMESLICE scales user-nice values [ -20 ... 19 ]
- * to time slice values.
+ * task_timeslice() scales user-nice values [ -20 ... 0 ... 19 ]
+ * to time slice values: [800ms ... 100ms ... 5ms]
  *
  * The higher a thread's priority, the bigger timeslices
  * it gets during one round of execution. But even the lowest
  * priority thread gets MIN_TIMESLICE worth of execution time.
- *
- * task_timeslice() is the interface that is used by the scheduler.
  */
 
-#define BASE_TIMESLICE(p) (MIN_TIMESLICE + \
-		((MAX_TIMESLICE - MIN_TIMESLICE) * \
-			(MAX_PRIO-1 - (p)->static_prio) / (MAX_USER_PRIO-1)))
+#define SCALE_PRIO(x, prio) \
+	max(x * (MAX_PRIO - prio) / (MAX_USER_PRIO/2), MIN_TIMESLICE)
 
 static unsigned int task_timeslice(task_t *p)
 {
-	return BASE_TIMESLICE(p);
+	if (p->static_prio < NICE_TO_PRIO(0))
+		return SCALE_PRIO(DEF_TIMESLICE*4, p->static_prio);
+	else
+		return SCALE_PRIO(DEF_TIMESLICE, p->static_prio);
 }
 
 #define task_hot(p, now, sd) ((now) - (p)->timestamp < (sd)->cache_hot_time)
@@ -400,7 +398,7 @@ static void recalc_task_prio(task_t *p, 
 		if (p->mm && p->activated != -1 &&
 			sleep_time > INTERACTIVE_SLEEP(p)) {
 				p->sleep_avg = JIFFIES_TO_NS(MAX_SLEEP_AVG -
-						AVG_TIMESLICE);
+						DEF_TIMESLICE);
 				if (!HIGH_CREDIT(p))
 					p->interactive_credit++;
 		} else {
@@ -1024,8 +1022,8 @@ void fastcall sched_exit(task_t * p)
 	rq = task_rq_lock(p->parent, &flags);
 	if (p->first_time_slice) {
 		p->parent->time_slice += p->time_slice;
-		if (unlikely(p->parent->time_slice > MAX_TIMESLICE))
-			p->parent->time_slice = MAX_TIMESLICE;
+		if (unlikely(p->parent->time_slice > task_timeslice(p)))
+			p->parent->time_slice = task_timeslice(p);
 	}
 	if (p->sleep_avg < p->parent->sleep_avg)
 		p->parent->sleep_avg = p->parent->sleep_avg /

--Kj7319i9nmIyA2yE--
