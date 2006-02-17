Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161142AbWBQBOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161142AbWBQBOl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 20:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161147AbWBQBOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 20:14:41 -0500
Received: from fmr22.intel.com ([143.183.121.14]:63182 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1161142AbWBQBOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 20:14:41 -0500
Date: Thu, 16 Feb 2006 17:13:57 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>, npiggin@suse.de,
       Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       Linus Torvalds <torvalds@osdl.org>, Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH] Fix smpnice high priority task hopping problem
Message-ID: <20060216171357.A27025@unix-os.sc.intel.com>
References: <43F3C9C6.5080606@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <43F3C9C6.5080606@bigpond.net.au>; from pwil3058@bigpond.net.au on Thu, Feb 16, 2006 at 11:39:34AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, Please don't apply this patch. This breaks the existing HT
(and multi-core) scheduler optimizations.

Peter, on a DP system with HT, if we have only two runnable processes
and they end up running on the two threads of the same package, 
with your patch, migration thread will never move one of those processes 
to the idle package..

To fix my reported problem, we need to make sure that find_busiest_group()
doesn't find an imbalance..

thanks,
suresh

On Thu, Feb 16, 2006 at 11:39:34AM +1100, Peter Williams wrote:
> Suresh B. Siddha has reported:
> 
> "on a lightly loaded system, this will result in higher priority job 
> hopping around from one processor to another processor.. This is because 
> of the code in find_busiest_group() which assumes that SCHED_LOAD_SCALE 
> represents a unit process load and with nice_to_bias calculations this 
> is no longer true (in the presence of non nice-0 tasks)"
> 
> Analysis of this problem as revealed that the smpnice code results in 
> the weighted load being larger than 1 and this triggers the active load 
> balancing code.  However, in active_load_balance(), the migration thread 
> fails to take into account itself when deciding if there are any tasks 
> to be migrated from its run queue. I.e. even if there is only one other 
> task on the run queue other than itself it will still migrate that other 
> task.
> 
> The attached patch fixes that anomaly.
> 
> Signed-off-by: Peter Williams <pwil3058@bigpond.com.au>
> 
> Peter
> -- 
> Peter Williams                                   pwil3058@bigpond.net.au
> 
> "Learning, n. The kind of ignorance distinguishing the studious."
>   -- Ambrose Bierce

> Index: MM-2.6.X/kernel/sched.c
> ===================================================================
> --- MM-2.6.X.orig/kernel/sched.c	2006-02-16 10:51:52.000000000 +1100
> +++ MM-2.6.X/kernel/sched.c	2006-02-16 11:02:45.000000000 +1100
> @@ -2406,7 +2406,7 @@ static void active_load_balance(runqueue
>  	runqueue_t *target_rq;
>  	int target_cpu = busiest_rq->push_cpu;
>  
> -	if (busiest_rq->nr_running <= 1)
> +	if (busiest_rq->nr_running <= 2)
>  		/* no task to move */
>  		return;
>  

