Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbWC3QBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbWC3QBd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 11:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbWC3QBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 11:01:33 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:59289 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932167AbWC3QBc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 11:01:32 -0500
Message-ID: <442C00D7.3000502@watson.ibm.com>
Date: Thu, 30 Mar 2006 11:01:27 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Patch 3/8] cpu delays
References: <442B271D.10208@watson.ibm.com>	<442B2967.6010704@watson.ibm.com> <20060329210352.53a64b5c.akpm@osdl.org>
In-Reply-To: <20060329210352.53a64b5c.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Shailabh Nagar <nagar@watson.ibm.com> wrote:
>  
>
>>delayacct-schedstats.patch
>>
>>Make the task-related schedstats functions
>>callable by delay accounting even if schedstats
>>collection isn't turned on. This removes the
>>dependency of delay accounting on schedstats and allows
>>cpu delays to be exported.
>>
>>..
>>
>>Index: linux-2.6.16/include/linux/sched.h
>>===================================================================
>>--- linux-2.6.16.orig/include/linux/sched.h	2006-03-29 18:13:13.000000000 -0500
>>+++ linux-2.6.16/include/linux/sched.h	2006-03-29 18:13:15.000000000 -0500
>>@@ -525,7 +525,7 @@ typedef struct prio_array prio_array_t;
>> struct backing_dev_info;
>> struct reclaim_state;
>>
>>-#ifdef CONFIG_SCHEDSTATS
>>+#if defined(CONFIG_SCHEDSTATS) || defined(CONFIG_TASK_DELAY_ACCT)
>> struct sched_info {
>> 	/* cumulative counters */
>> 	unsigned long	cpu_time,	/* time spent on the cpu */
>>@@ -537,10 +537,14 @@ struct sched_info {
>> 			last_queued;	/* when we were last queued to run */
>> };
>>
>>+#ifdef CONFIG_SCHEDSTATS
>> extern struct file_operations proc_schedstat_operations;
>>-#endif
>>+#endif /* CONFIG_SCHEDSTATS */
>>+#endif /* defined(CONFIG_SCHEDSTATS) || defined(CONFIG_TASK_DELAY_ACCT) */
>>
>> #ifdef CONFIG_TASK_DELAY_ACCT
>>+extern int delayacct_on;
>>+
>>    
>>
>
>This was already declared in delayacct.h and nothing in sched.h needs it. 
>So it's better if .c files pick this declaration up from delayacct.h.
>
>  
>
>>+static inline void rq_sched_info_arrive(struct runqueue *rq,
>>+						unsigned long diff)
>>+{
>>+	if (rq) {
>>+		rq->rq_sched_info.run_delay += diff;
>>+		rq->rq_sched_info.pcnt++;
>>+	}
>>+}
>>    
>>
>
>The nonatomic updates need locking.  I assume it's runqueue.lock, but a
>comment describing the rules would be good.
>
>  
>
Yes, it is rq.lock. Will add comment.

>>+static inline void rq_sched_info_depart(struct runqueue *rq,
>>+						unsigned long diff)
>>+{
>>+	if (rq)
>>+		rq->rq_sched_info.cpu_time += diff;
>>+}
>>    
>>
>
>Ditto.
>  
>
Will add comment.

>  
>
>> static inline void sched_info_queued(task_t *t)
>> {
>>-	if (!t->sched_info.last_queued)
>>-		t->sched_info.last_queued = jiffies;
>>+	if (unlikely(sched_info_on()))
>>+		if (!t->sched_info.last_queued)
>>+			t->sched_info.last_queued = jiffies;
>> }
>>    
>>
>
>It might be better to put the unlikely() into sched_info_on() itself.
>  
>
The function sched_info_on has only got a return statement so putting 
the unlikely within
it doesn't seem possible.

This is a rather aggressive use of the unlikely. In the case where 
CONFIG_SCHEDSTATS is
defined, sched_info_on always returns 1 so the unlikely will always 
cause a mispredict. I'm assuming
the extra penalty for that is acceptable for those using schedstats 
since its never turned on in a production
kernel.
If only CONFIG_TASK_DELAY_ACCT is configured, the value of delayacct_on, 
which is very
likely going to be 0, will be returned so the unlikely is potentially 
helpful to reduce overhead.

Thoughts ?

As I write this, I realize the function sched_info_on() is also wrongly 
written and doesn't account for the
case where both SCHEDSTATS and TASK_DELAY_ACCT  are configured. Will fix 
that. But thats
orthogonal to the above discussion of whether the unlikely should be used.

--Shailabh


