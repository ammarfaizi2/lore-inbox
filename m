Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161403AbWBUGWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161403AbWBUGWV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 01:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161434AbWBUGWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 01:22:14 -0500
Received: from omta02ps.mx.bigpond.com ([144.140.83.154]:35203 "EHLO
	omta02ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1161437AbWBUGVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 01:21:50 -0500
Message-ID: <43FAB17B.8020608@bigpond.net.au>
Date: Tue, 21 Feb 2006 17:21:47 +1100
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
References: <43F94D71.1040109@bigpond.net.au> <200602202102.14003.kernel@kolivas.org> <43FA444B.20903@bigpond.net.au> <200602210941.23352.kernel@kolivas.org>
In-Reply-To: <200602210941.23352.kernel@kolivas.org>
Content-Type: multipart/mixed;
 boundary="------------050400010302090805020006"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Tue, 21 Feb 2006 06:21:47 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050400010302090805020006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Con Kolivas wrote:
> On Tuesday 21 February 2006 09:35, Peter Williams wrote:
> 
>>Con Kolivas wrote:
>>
>>>On Monday 20 February 2006 16:02, Peter Williams wrote:
>>>[snip description]
>>>
>>>Hi peter, I've had a good look and have just a couple of comments:
>>>
>>>---
>>> #endif
>>>        int prio, static_prio;
>>>+#ifdef CONFIG_SMP
>>>+       int load_weight;        /* for load balancing purposes */
>>>+#endif
>>>---
>>>
>>>Can this be moved up to be part of the other ifdef CONFIG_SMP? Not highly
>>>significant since it's in a .h file but looks a tiny bit nicer.
>>
>>I originally put it where it is to be near prio and static_prio which
>>are referenced at the same time as it BUT that doesn't happen often
>>enough to justify it anymore so I guess it can be moved.
> 
> 
> Well it is just before prio instead of just after it now and I understand the 
> legacy of the position.
> 
> 
>>>---
>>>+/*
>>>+ * Priority weight for load balancing ranges from 1/20 (nice==19) to
>>>459/20 (RT
>>>+ * priority of 100).
>>>+ */
>>>+#define NICE_TO_LOAD_PRIO(nice) \
>>>+       ((nice >= 0) ? (20 - (nice)) : (20 + (nice) * (nice)))
>>>+#define LOAD_WEIGHT(lp) \
>>>+       (((lp) * SCHED_LOAD_SCALE) / NICE_TO_LOAD_PRIO(0))
>>>+#define NICE_TO_LOAD_WEIGHT(nice)     
>>>LOAD_WEIGHT(NICE_TO_LOAD_PRIO(nice)) +#define PRIO_TO_LOAD_WEIGHT(prio)
>>>NICE_TO_LOAD_WEIGHT(PRIO_TO_NICE(prio))
>>>+#define RTPRIO_TO_LOAD_WEIGHT(rp) \
>>>+       LOAD_WEIGHT(NICE_TO_LOAD_PRIO(-20) + (rp))
>>>---
>>>
>>>The weighting seems not related to anything in particular apart from
>>>saying that -nice values are more heavily weighted.
>>
>>The idea (for the change from the earlier model) was to actually give
>>equal weight to negative and positive nices.  Under the old (purely
>>linear) model a nice=19 task has 1/20th the weight of a nice==0 task but
>>a nice==-20 task only has twice the weight of a nice==0 so that system
>>is heavily weighted against negative nices.  With this new mapping a
>>nice=19 has 1/20th and a nice==-19 has 20 times the weight of a nice==0
>>task and to me that is symmetric.  Does that make sense to you?
> 
> 
> Yes but what I meant is it's still an arbitrary algorithm which is why I 
> suggested proportional to tasks' timeslice because then it should scale with 
> the theoretically allocated cpu resource.
> 
> 
>>Should I add a comment to explain the mapping?
>>
>>
>>>Since you only do this when
>>>setting the priority of tasks can you link it to the scale of
>>>(SCHED_NORMAL) tasks' timeslice instead even though that will take a
>>>fraction more calculation? RTPRIO_TO_LOAD_WEIGHT is fine since there
>>>isn't any obvious cpu proportion relationship to rt_prio level.
>>
>>Interesting idea.  I'll look at this more closely.
> 
> 
> Would be just a matter of using task_timeslice(p) and making it proportional 
> to some baseline ensuring the baseline works at any HZ.

How does the attached patch grab you?  It's independent of HZ.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

--------------050400010302090805020006
Content-Type: text/plain;
 name="smpnice-improve-weight-function"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="smpnice-improve-weight-function"

Index: MM-2.6.X/kernel/sched.c
===================================================================
--- MM-2.6.X.orig/kernel/sched.c	2006-02-21 16:27:32.000000000 +1100
+++ MM-2.6.X/kernel/sched.c	2006-02-21 17:01:12.000000000 +1100
@@ -169,13 +169,13 @@
 
 #define SCALE_PRIO(x, prio) \
 	max(x * (MAX_PRIO - prio) / (MAX_USER_PRIO/2), MIN_TIMESLICE)
+#define PRIO_TO_TS(sp) \
+	((sp) < NICE_TO_PRIO(0) ? SCALE_PRIO(DEF_TIMESLICE*4, (sp)) : \
+	 SCALE_PRIO(DEF_TIMESLICE, (sp)))
 
 static unsigned int task_timeslice(task_t *p)
 {
-	if (p->static_prio < NICE_TO_PRIO(0))
-		return SCALE_PRIO(DEF_TIMESLICE*4, p->static_prio);
-	else
-		return SCALE_PRIO(DEF_TIMESLICE, p->static_prio);
+	return PRIO_TO_TS(p->static_prio);
 }
 #define task_hot(p, now, sd) ((long long) ((now) - (p)->last_ran)	\
 				< (long long) (sd)->cache_hot_time)
@@ -680,11 +680,9 @@ static int effective_prio(task_t *p)
  */
 
 /*
- * Priority weight for load balancing ranges from 1/20 (nice==19) to 459/20 (RT
- * priority of 100).
+ * Priority weight for load balancing ranges (based on time slice allocations).
  */
-#define NICE_TO_LOAD_PRIO(nice) \
-	((nice >= 0) ? (20 - (nice)) : (20 + (nice) * (nice)))
+#define NICE_TO_LOAD_PRIO(nice) 	PRIO_TO_TS(NICE_TO_PRIO(nice))
 #define LOAD_WEIGHT(lp) \
 	(((lp) * SCHED_LOAD_SCALE) / NICE_TO_LOAD_PRIO(0))
 #define NICE_TO_LOAD_WEIGHT(nice)	LOAD_WEIGHT(NICE_TO_LOAD_PRIO(nice))

--------------050400010302090805020006--
