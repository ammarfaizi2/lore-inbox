Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266200AbUAHTei (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 14:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266180AbUAHTeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 14:34:23 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:18893 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266085AbUAHTcu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 14:32:50 -0500
Date: Fri, 9 Jan 2004 01:03:23 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
       Paul McKenney <paul.mckenney@us.ibm.com>
Subject: Re: [patch] RCU for low latency [1/2]
Message-ID: <20040108193323.GF4321@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040108114851.GA5128@in.ibm.com> <20040108114958.GB5128@in.ibm.com> <3FFD7340.7050209@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FFD7340.7050209@cyberone.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 09, 2004 at 02:12:00AM +1100, Nick Piggin wrote:
> Dipankar Sarma wrote:
> 
> >Provide a rq_has_rt_task() interface to detect runqueues with
> >real time priority tasks. Useful for RCU optimizations.
> >
> 
> Can you make rq_has_rt_task the slow path? Adding things like this
> can actually be noticable on microbenchmarks (eg. pipe based ctx
> switching). Its probably cache artifacts that I see, but it wouldn't
> hurt to keep the scheduler as tight as possible.
> 
> I think this should cover it.
> 
> int rq_has_rt_task(int cpu)
> {
> 	runqueue_t *rq = cpu_rq(cpu);
> 	return (sched_find_first_bit(rq->active) < MAX_RT_PRIO);
> }
> 
> Any good?

Much better, except, well, rq->active->bitmap. Here is the new
rq_has_rt_task() patch.

Thanks
Dipankar



Provide a rq_has_rt_task() interface to detect runqueues with
real time priority tasks. Useful for RCU optimizations.


 include/linux/sched.h |    1 +
 kernel/sched.c        |    6 ++++++
 2 files changed, 7 insertions(+)

diff -puN kernel/sched.c~rq-has-rt-task kernel/sched.c
--- linux-2.6.0-smprcu/kernel/sched.c~rq-has-rt-task	2004-01-08 23:16:02.000000000 +0530
+++ linux-2.6.0-smprcu-dipankar/kernel/sched.c	2004-01-08 23:36:03.000000000 +0530
@@ -338,6 +338,12 @@ static inline void enqueue_task(struct t
 	p->array = array;
 }
 
+int rq_has_rt_task(int cpu)
+{
+        runqueue_t *rq = cpu_rq(cpu);
+        return (sched_find_first_bit(rq->active->bitmap) < MAX_RT_PRIO);
+}
+
 /*
  * effective_prio - return the priority that is based on the static
  * priority but is modified by bonuses/penalties.
diff -puN include/linux/sched.h~rq-has-rt-task include/linux/sched.h
--- linux-2.6.0-smprcu/include/linux/sched.h~rq-has-rt-task	2004-01-08 23:36:27.000000000 +0530
+++ linux-2.6.0-smprcu-dipankar/include/linux/sched.h	2004-01-08 23:36:52.000000000 +0530
@@ -525,6 +525,7 @@ extern int task_prio(task_t *p);
 extern int task_nice(task_t *p);
 extern int task_curr(task_t *p);
 extern int idle_cpu(int cpu);
+extern int rq_has_rt_task(int cpu);
 
 void yield(void);
 

_
