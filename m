Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161050AbWBAMoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161050AbWBAMoz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 07:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161052AbWBAMoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 07:44:55 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:30140 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1161050AbWBAMoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 07:44:54 -0500
Subject: Re: [PATCH] Avoid moving tasks when a schedule can be made.
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
In-Reply-To: <43E02CC2.3080805@bigpond.net.au>
References: <1138736609.7088.35.camel@localhost.localdomain>
	 <43E02CC2.3080805@bigpond.net.au>
Content-Type: text/plain
Date: Wed, 01 Feb 2006 07:44:34 -0500
Message-Id: <1138797874.7088.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-01 at 14:36 +1100, Peter Williams wrote:
> Steven Rostedt wrote:
> > I found this in the -rt kernel.  While running "hackbench 20" I hit
> > latencies of over 1.5 ms.  That is huge!  This latency was created by
> > the move_tasks function in sched.c to rebalance the queues over CPUS.  
> > 
> > There currently isn't any check in this function to see if it should
> > stop, thus a large number of tasks can drive the latency high.
> > 
> > With the below patch, (tested on -rt with latency tracing), the latency
> > caused by hackbench disappeared below my notice threshold (100 usecs).
> > 
> > I'm not convinced that this bail out is in the right location, but it
> > worked where it is.  Comments are welcome.
> > 

> 
> I presume that the intention here is to allow a newly woken task that 
> preempts the current task to stop the load balancing?
> 
> As I see it (and I may be wrong), for this to happen, the task must have 
> woken before the run queue locks were taken (otherwise it wouldn't have 
> got as far as activation) i.e. before move_tasks() is called and 
> therefore you may as well just do this check at the start of move_tasks().

Actually, one of the tasks that was moved might need to resched right
away, since it preempts the current task that is doing the moving.

> 
> However, a newly woken task that preempts the current task isn't the 
> only way that needs_resched() can become true just before load balancing 
> is started.  E.g. scheduler_tick() calls set_tsk_need_resched(p) when a 
> task finishes a time slice and this patch would cause rebalance_tick() 
> to be aborted after a lot of work has been done in this case.

No real work is lost.  This is a loop that individually pulls tasks.  So
the bail only stops the work of looking for more tasks to pull and we
don't lose the tasks that have already been pulled.

> 
> In summary, I think that the bail out is badly placed and needs some way 
> of knowing if the reason need_resched() has become true is because of 
> preemption of a newly woken task and not some other reason.

I need that bail in the loop, so it can stop if needed. Like I said, it
can be a task that is pulled to cause the bail. Also, having the run
queue locks and interrupts off for over a msec is really a bad idea.

> 
> Peter
> PS I've added Nick Piggin to the CC list as he is interested in load 
> balancing issues.

Thanks, and thanks for the comments too.  I'm up for all suggestions and
ideas.  I just feel it is important that we don't have unbounded
latencies of spin locks and interrupts off.

-- Steve


