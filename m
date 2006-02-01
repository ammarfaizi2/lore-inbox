Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030185AbWBADgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030185AbWBADgh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 22:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030235AbWBADgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 22:36:37 -0500
Received: from omta02sl.mx.bigpond.com ([144.140.93.154]:28003 "EHLO
	omta02sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1030185AbWBADgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 22:36:36 -0500
Message-ID: <43E02CC2.3080805@bigpond.net.au>
Date: Wed, 01 Feb 2006 14:36:34 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] Avoid moving tasks when a schedule can be made.
References: <1138736609.7088.35.camel@localhost.localdomain>
In-Reply-To: <1138736609.7088.35.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 1 Feb 2006 03:36:34 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> I found this in the -rt kernel.  While running "hackbench 20" I hit
> latencies of over 1.5 ms.  That is huge!  This latency was created by
> the move_tasks function in sched.c to rebalance the queues over CPUS.  
> 
> There currently isn't any check in this function to see if it should
> stop, thus a large number of tasks can drive the latency high.
> 
> With the below patch, (tested on -rt with latency tracing), the latency
> caused by hackbench disappeared below my notice threshold (100 usecs).
> 
> I'm not convinced that this bail out is in the right location, but it
> worked where it is.  Comments are welcome.
> 
> -- Steve
> 
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> 
> Index: linux-2.6.16-rc1/kernel/sched.c
> ===================================================================
> --- linux-2.6.16-rc1.orig/kernel/sched.c	2006-01-19 15:58:52.000000000 -0500
> +++ linux-2.6.16-rc1/kernel/sched.c	2006-01-31 14:27:17.000000000 -0500
> @@ -1983,6 +1983,10 @@
>  
>  	curr = curr->prev;
>  
> +	/* bail if someone else woke up */
> +	if (need_resched())
> +		goto out;
> +
>  	if (!can_migrate_task(tmp, busiest, this_cpu, sd, idle, &pinned)) {
>  		if (curr != head)
>  			goto skip_queue;
> 

I presume that the intention here is to allow a newly woken task that 
preempts the current task to stop the load balancing?

As I see it (and I may be wrong), for this to happen, the task must have 
woken before the run queue locks were taken (otherwise it wouldn't have 
got as far as activation) i.e. before move_tasks() is called and 
therefore you may as well just do this check at the start of move_tasks().

However, a newly woken task that preempts the current task isn't the 
only way that needs_resched() can become true just before load balancing 
is started.  E.g. scheduler_tick() calls set_tsk_need_resched(p) when a 
task finishes a time slice and this patch would cause rebalance_tick() 
to be aborted after a lot of work has been done in this case.

In summary, I think that the bail out is badly placed and needs some way 
of knowing if the reason need_resched() has become true is because of 
preemption of a newly woken task and not some other reason.

Peter
PS I've added Nick Piggin to the CC list as he is interested in load 
balancing issues.
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
