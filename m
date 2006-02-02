Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422898AbWBBDTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422898AbWBBDTz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 22:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423076AbWBBDTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 22:19:55 -0500
Received: from omta02ps.mx.bigpond.com ([144.140.83.154]:20926 "EHLO
	omta02ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1422898AbWBBDTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 22:19:54 -0500
Message-ID: <43E17A53.8060401@bigpond.net.au>
Date: Thu, 02 Feb 2006 14:19:47 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] Avoid moving tasks when a schedule can be made.
References: <1138736609.7088.35.camel@localhost.localdomain>	 <43E02CC2.3080805@bigpond.net.au>	 <1138797874.7088.44.camel@localhost.localdomain>	 <43E15FAE.6040707@bigpond.net.au> <1138848511.6632.41.camel@localhost.localdomain>
In-Reply-To: <1138848511.6632.41.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Thu, 2 Feb 2006 03:19:47 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> On Thu, 2006-02-02 at 12:26 +1100, Peter Williams wrote:
> 
> 
>>>Actually, one of the tasks that was moved might need to resched right
>>>away, since it preempts the current task that is doing the moving.
>>
>>Good point but I'd say that this was an instance when you didn't want to 
>>bail out of the load balance.  E.g. during idle balancing the very first 
>>task moved would trigger it regardless of its priority.  Also, if the 
>>task was of sufficiently high priority for it to warrant bailing out of 
>>the load balance why wasn't the current task (i.e. why didn't it preempt 
>>on its current CPU).
> 
> 
> Because the task running on the current CPU is higher in priority.  That
> doesn't mean that the next one down shouldn't get scheduled on another
> CPU if it is a higher priority than the currently running one.

Yes, but I don't think that it warrants interrupting the load balancing.

>  Of
> course one needs to be careful not to cause too much cache blasting by
> popping RT tasks all over CPUS.
> 
> 
>>>
>>>>However, a newly woken task that preempts the current task isn't the 
>>>>only way that needs_resched() can become true just before load balancing 
>>>>is started.  E.g. scheduler_tick() calls set_tsk_need_resched(p) when a 
>>>>task finishes a time slice and this patch would cause rebalance_tick() 
>>>>to be aborted after a lot of work has been done in this case.
>>>
>>>
>>>No real work is lost.   This is a loop that individually pulls tasks.  So
>>>the bail only stops the work of looking for more tasks to pull and we
>>>don't lose the tasks that have already been pulled.
>>
>>I disagree.  A bunch of work is done to determine which CPU to pull from 
>>and how many tasks to pull and then it will bail out before any of them 
>>are moved (and for no good reason).
> 
> 
> Yeah, that was my mistake.  There is work lost. So nuke that argument of
> mine :)
> 
> 
>>>
>>>>In summary, I think that the bail out is badly placed and needs some way 
>>>>of knowing if the reason need_resched() has become true is because of 
>>>>preemption of a newly woken task and not some other reason.
>>>
>>>
>>>I need that bail in the loop, so it can stop if needed. Like I said, it
>>>can be a task that is pulled to cause the bail. Also, having the run
>>>queue locks and interrupts off for over a msec is really a bad idea.
>>
>>Clearly, the way to handle this is to impose some limit on the number of 
>>tasks to be moved or split large moves into a number of smaller moves 
>>(releasing and reacquiring locks in between).  This could be done in the 
>>bits of code that set things up before move_tasks() is called.
> 
> 
> I think that's something like what Ingo wants to do.  Or something other
> than my first brain dead patch.
> 
> 
>>>
>>>>Peter
>>>>PS I've added Nick Piggin to the CC list as he is interested in load 
>>>>balancing issues.
>>>
>>>
>>>Thanks, and thanks for the comments too.  I'm up for all suggestions and
>>>ideas.  I just feel it is important that we don't have unbounded
>>>latencies of spin locks and interrupts off.
>>
>>Well, you seem to have succeeded in starting a discussion :-)
> 
> 
> :)
> 
> -- Steve
> 


-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
