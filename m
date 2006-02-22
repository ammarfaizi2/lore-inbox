Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422638AbWBVAah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422638AbWBVAah (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 19:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422639AbWBVAah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 19:30:37 -0500
Received: from omta05ps.mx.bigpond.com ([144.140.83.195]:38070 "EHLO
	omta05ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1422638AbWBVAag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 19:30:36 -0500
Message-ID: <43FBB093.2090101@bigpond.net.au>
Date: Wed, 22 Feb 2006 11:30:11 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, npiggin@suse.de,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: Consolidated and improved smpnice patch
References: <43F94D71.1040109@bigpond.net.au> <200602210941.23352.kernel@kolivas.org> <43FAB17B.8020608@bigpond.net.au> <200602212009.47654.kernel@kolivas.org>
In-Reply-To: <200602212009.47654.kernel@kolivas.org>
Content-Type: multipart/mixed;
 boundary="------------020103080003020409030708"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 22 Feb 2006 00:30:31 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020103080003020409030708
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Con Kolivas wrote:
> On Tuesday 21 February 2006 17:21, Peter Williams wrote:
> 
>>Con Kolivas wrote:
>>
>>>Would be just a matter of using task_timeslice(p) and making it
>>>proportional to some baseline ensuring the baseline works at any HZ.
>>
>>How does the attached patch grab you?  It's independent of HZ.
> 
> 
> Looks good thanks.
> 

I think that there's a way that we can leverage this to make 
task_timeslice() more efficient by calculating it in terms of the task's 
load_weight.  I.e. if the value of load_weight is established based on 
the current time slice formula then it will be a simple mapping 
(basically, just a scaling) from load_weight to time slice.  Scaling is 
at most a multiply and a divide where the current cost of 
task_timeslice() is 2 comparisons, a subtraction, a multiply and a 
divide (after you take account of the multiplies and divides that the 
compiler would do at compile time).

Attached is a patch for comment.

NB I had to add an extra comparison in sched_timeslice() to maintain the 
relationship between "nice" and time slice allocations to RT tasks.  I 
don't know whether this relationship is deliberate (as there are 
comments in set_user_nice() to the effect that static_prio is just 
updated for RT tasks in case they become non RT tasks and has no effect 
on scheduling).  If it's not and higher time slice allocations for RT 
tasks would be acceptable (only really matters for SCHED_RR except for 
where task_timeslice() is used in sched_exit() and dependent_sleeper()) 
then this could be simplified.

Comments, Please?

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

--------------020103080003020409030708
Content-Type: text/plain;
 name="smpnice-align-time_slice-and-load_weight"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="smpnice-align-time_slice-and-load_weight"

Index: MM-2.6.X/kernel/sched.c
===================================================================
--- MM-2.6.X.orig/kernel/sched.c	2006-02-21 16:27:32.000000000 +1100
+++ MM-2.6.X/kernel/sched.c	2006-02-22 11:17:07.000000000 +1100
@@ -170,13 +170,30 @@
 #define SCALE_PRIO(x, prio) \
 	max(x * (MAX_PRIO - prio) / (MAX_USER_PRIO/2), MIN_TIMESLICE)
 
-static unsigned int task_timeslice(task_t *p)
+static unsigned int static_prio_timeslice(int static_prio)
 {
-	if (p->static_prio < NICE_TO_PRIO(0))
-		return SCALE_PRIO(DEF_TIMESLICE*4, p->static_prio);
+	if (static_prio < NICE_TO_PRIO(0))
+		return SCALE_PRIO(DEF_TIMESLICE*4, static_prio);
 	else
-		return SCALE_PRIO(DEF_TIMESLICE, p->static_prio);
+		return SCALE_PRIO(DEF_TIMESLICE, static_prio);
 }
+
+static inline unsigned int task_timeslice(task_t *p)
+{
+	/*
+	 * This is needed in order to maintain the relationship between
+	 * "nice" and time slice allocations for SCHED_RR and SCHED_FIFO tasks
+	 */
+	if (rt_task(p))
+		return static_prio_timeslice(p->static_prio);
+#ifdef CONFIG_SMP
+	/* load_weight is a scaled version of the time slice allocation */
+	return p->load_weight * DEF_TIMESLICE / SCHED_LOAD_SCALE;
+#else
+	return p->load_weight;
+#endif
+}
+
 #define task_hot(p, now, sd) ((long long) ((now) - (p)->last_ran)	\
 				< (long long) (sd)->cache_hot_time)
 
@@ -671,30 +688,36 @@ static int effective_prio(task_t *p)
 	return prio;
 }
 
-#ifdef CONFIG_SMP
 /*
  * To aid in avoiding the subversion of "niceness" due to uneven distribution
  * of tasks with abnormal "nice" values across CPUs the contribution that
  * each task makes to its run queue's load is weighted according to its
- * scheduling class and "nice" value.
+ * scheduling class and "nice" value.  For SCHED_NORMAL tasks this is just a
+ * scaled version of the new time slice allocation that they receive on time
+ * slice expiry etc.
  */
 
 /*
- * Priority weight for load balancing ranges from 1/20 (nice==19) to 459/20 (RT
- * priority of 100).
+ * Assume: static_prio_timeslice(NICE_TO_PRIO(0)) == DEF_TIMESLICE
+ * If static_prio_timeslice() is ever changed to break this assumption then
+ * this code will need modification
  */
-#define NICE_TO_LOAD_PRIO(nice) \
-	((nice >= 0) ? (20 - (nice)) : (20 + (nice) * (nice)))
+#define TIME_SLICE_NICE_ZERO DEF_TIMESLICE
+#ifdef CONFIG_SMP
 #define LOAD_WEIGHT(lp) \
-	(((lp) * SCHED_LOAD_SCALE) / NICE_TO_LOAD_PRIO(0))
-#define NICE_TO_LOAD_WEIGHT(nice)	LOAD_WEIGHT(NICE_TO_LOAD_PRIO(nice))
-#define PRIO_TO_LOAD_WEIGHT(prio)	NICE_TO_LOAD_WEIGHT(PRIO_TO_NICE(prio))
+	(((lp) * SCHED_LOAD_SCALE) / TIME_SLICE_NICE_ZERO)
+#else
+#define LOAD_WEIGHT(lp) (lp)
+#endif
+#define PRIO_TO_LOAD_WEIGHT(prio) \
+	LOAD_WEIGHT(static_prio_timeslice(prio))
 #define RTPRIO_TO_LOAD_WEIGHT(rp) \
-	LOAD_WEIGHT(NICE_TO_LOAD_PRIO(-20) + (rp))
+	(PRIO_TO_LOAD_WEIGHT(MAX_RT_PRIO) + LOAD_WEIGHT(rp))
 
 static inline void set_load_weight(task_t *p)
 {
 	if (rt_task(p)) {
+#ifdef CONFIG_SMP
 		if (p == task_rq(p)->migration_thread)
 			/*
 			 * The migration thread does the actual balancing.
@@ -703,11 +726,13 @@ static inline void set_load_weight(task_
 			 */
 			p->load_weight = 0;
 		else
+#endif
 			p->load_weight = RTPRIO_TO_LOAD_WEIGHT(p->rt_priority);
 	} else
 		p->load_weight = PRIO_TO_LOAD_WEIGHT(p->static_prio);
 }
 
+#ifdef CONFIG_SMP
 static inline void inc_raw_weighted_load(runqueue_t *rq, const task_t *p)
 {
 	rq->raw_weighted_load += p->load_weight;
@@ -718,10 +743,6 @@ static inline void dec_raw_weighted_load
 	rq->raw_weighted_load -= p->load_weight;
 }
 #else
-static inline void set_load_weight(task_t *p)
-{
-}
-
 static inline void inc_raw_weighted_load(runqueue_t *rq, const task_t *p)
 {
 }
Index: MM-2.6.X/include/linux/sched.h
===================================================================
--- MM-2.6.X.orig/include/linux/sched.h	2006-02-21 16:27:32.000000000 +1100
+++ MM-2.6.X/include/linux/sched.h	2006-02-22 10:29:01.000000000 +1100
@@ -703,9 +703,8 @@ struct task_struct {
 	int oncpu;
 #endif
 	int prio, static_prio;
-#ifdef CONFIG_SMP
-	int load_weight;	/* for load balancing purposes */
-#endif
+	int load_weight;	/* used for load balancing and time slice allocation  */
+
 	struct list_head run_list;
 	prio_array_t *array;
 

--------------020103080003020409030708--
