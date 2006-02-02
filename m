Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422689AbWBBB0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422689AbWBBB0L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 20:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422759AbWBBB0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 20:26:10 -0500
Received: from omta04ps.mx.bigpond.com ([144.140.83.156]:12631 "EHLO
	omta04ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1422689AbWBBB0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 20:26:09 -0500
Message-ID: <43E15FAE.6040707@bigpond.net.au>
Date: Thu, 02 Feb 2006 12:26:06 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] Avoid moving tasks when a schedule can be made.
References: <1138736609.7088.35.camel@localhost.localdomain>	 <43E02CC2.3080805@bigpond.net.au> <1138797874.7088.44.camel@localhost.localdomain>
In-Reply-To: <1138797874.7088.44.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Thu, 2 Feb 2006 01:26:06 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> On Wed, 2006-02-01 at 14:36 +1100, Peter Williams wrote:
> 
>>Steven Rostedt wrote:
>>
>>>I found this in the -rt kernel.  While running "hackbench 20" I hit
>>>latencies of over 1.5 ms.  That is huge!  This latency was created by
>>>the move_tasks function in sched.c to rebalance the queues over CPUS.  
>>>
>>>There currently isn't any check in this function to see if it should
>>>stop, thus a large number of tasks can drive the latency high.
>>>
>>>With the below patch, (tested on -rt with latency tracing), the latency
>>>caused by hackbench disappeared below my notice threshold (100 usecs).
>>>
>>>I'm not convinced that this bail out is in the right location, but it
>>>worked where it is.  Comments are welcome.
>>>
> 
> 
>>I presume that the intention here is to allow a newly woken task that 
>>preempts the current task to stop the load balancing?
>>
>>As I see it (and I may be wrong), for this to happen, the task must have 
>>woken before the run queue locks were taken (otherwise it wouldn't have 
>>got as far as activation) i.e. before move_tasks() is called and 
>>therefore you may as well just do this check at the start of move_tasks().
> 
> 
> Actually, one of the tasks that was moved might need to resched right
> away, since it preempts the current task that is doing the moving.

Good point but I'd say that this was an instance when you didn't want to 
bail out of the load balance.  E.g. during idle balancing the very first 
task moved would trigger it regardless of its priority.  Also, if the 
task was of sufficiently high priority for it to warrant bailing out of 
the load balance why wasn't the current task (i.e. why didn't it preempt 
on its current CPU).

> 
> 
>>However, a newly woken task that preempts the current task isn't the 
>>only way that needs_resched() can become true just before load balancing 
>>is started.  E.g. scheduler_tick() calls set_tsk_need_resched(p) when a 
>>task finishes a time slice and this patch would cause rebalance_tick() 
>>to be aborted after a lot of work has been done in this case.
> 
> 
> No real work is lost.   This is a loop that individually pulls tasks.  So
> the bail only stops the work of looking for more tasks to pull and we
> don't lose the tasks that have already been pulled.

I disagree.  A bunch of work is done to determine which CPU to pull from 
and how many tasks to pull and then it will bail out before any of them 
are moved (and for no good reason).

> 
> 
>>In summary, I think that the bail out is badly placed and needs some way 
>>of knowing if the reason need_resched() has become true is because of 
>>preemption of a newly woken task and not some other reason.
> 
> 
> I need that bail in the loop, so it can stop if needed. Like I said, it
> can be a task that is pulled to cause the bail. Also, having the run
> queue locks and interrupts off for over a msec is really a bad idea.

Clearly, the way to handle this is to impose some limit on the number of 
tasks to be moved or split large moves into a number of smaller moves 
(releasing and reacquiring locks in between).  This could be done in the 
bits of code that set things up before move_tasks() is called.

> 
> 
>>Peter
>>PS I've added Nick Piggin to the CC list as he is interested in load 
>>balancing issues.
> 
> 
> Thanks, and thanks for the comments too.  I'm up for all suggestions and
> ideas.  I just feel it is important that we don't have unbounded
> latencies of spin locks and interrupts off.

Well, you seem to have succeeded in starting a discussion :-)

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
