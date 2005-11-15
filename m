Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965062AbVKOWxv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965062AbVKOWxv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 17:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965064AbVKOWxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 17:53:51 -0500
Received: from sccrmhc12.comcast.net ([63.240.77.82]:49304 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S965062AbVKOWxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 17:53:50 -0500
In-Reply-To: <437A613A.1020705@watson.ibm.com>
References: <43796596.2010908@watson.ibm.com> <1F92A563-B430-49FE-895E-FB93DC64981E@comcast.net> <437A613A.1020705@watson.ibm.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4ABDC730-2888-4DBE-B1DC-62362A87EEB7@comcast.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Parag Warudkar <kernel-stuff@comcast.net>
Subject: Re: [Patch 1/4] Delay accounting: Initialization
Date: Tue, 15 Nov 2005 17:53:32 -0500
To: nagar@watson.ibm.com
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Nov 15, 2005, at 5:29 PM, Shailabh Nagar wrote:
>>
>> Curious as to when would this occur. Probably for tasks running on a
>> SMP machine for a very short period of time (timer drift should  
>> not  be
>> hopefully that high) and switching CPUs in that short period of time?
>
> Possibly. Also, the simpler case of wraparound needs to be handled.  
> Since
> one delay sample isn't significant, dropping it seemed the safest bet.
>
Yep, better to report zero than invalid values.

>
>>> +config STATS_CONNECTOR
>>> +config DELAY_ACCT
>>
>>
>> Probably TASK_DELAY_STATS_CONNECTOR and TASK_DELAY_ACCOUNTING are
>> better names?
>
> TASK_DELAY_ACCOUNTING is better since thats what the code protected
> does.
>
> STATS_CONNECTOR can be used to transmit stats other than per-task
> delays (current patch also transmits cpu run time). Also there's a  
> possibility
> that the overall per-task accounting solution whose discussion was  
> proposed
> by Andrew will deviate from delays. So how about TASK_STATS_CONNECTOR.
>>

Sounds good.

>> Does this mean, whether or not the per task delay accounting is used,
>> we have a constant overhead of sizeof(spinlock_t) + 2*sizeof  
>> (uint32_t)
>> + 2* sizeof(uint64_t) bytes going into the struct  task_struct?.  
>> Is it
>> possible/beneficial to use struct task_delay_info  *delays instead  
>> and
>> allocate it if task wants to use the information?
>>
>
> Doing so would have value in the case where the feature is  
> configured but
> no one ever registers to listen for it.

Precisely. Such a feature will be used only occasionally I suppose.
I didn't read the code deeply but are any scheduling decisions  
altered based on
this data? If not, then it makes sense to not account unless required.

I think it should be possible to do it on demand, per process instead  
of forcing
the accounting on _all_ processes which cumulatively becomes a  
sizeable o/h.

Per Process activation of this feature will add significant value  
IMHO. (Of course,
if that's possible in first place.)

> The cost of doing this would be
> - adding more code to the fork path to allocate conditionally

Just an unlikely branch for normal code path - not a big deal.
Also I am thinking it could be handled outside of fork?

> - make the collecting of the delays conditional on a similar check

Weighing this against the actual accounting - I think it's a win.

> - cache pollution from following an extra pointer in the pgflt/ 
> io_schedule paths
> I'm not sure is this really matters for these two code paths.

Possibly.

> Even if one does this, once the first listener registers, all  
> future tasks
> (and even the current ones) will have to go ahead and allocate the  
> structure
> and accounting of delays will have to switch to unconditional mode.  
> This is
> because the delay data has cumulative value...future listeners will be
> interested in data collected earlier (as long as task is still  
> running). And
> once the first listener registers, you can no longer be sure no  
> one's interested
> in the future.
>

Is it possible to do it per process? Forcing it on all processes is  
what I was trying
to avoid given the feature's usage pattern.

> Another alternative is to let userland control the overhead of  
> allocation and
> collection completely through a /proc/sys/kernel/delayacct variable.
> When its switched on, it triggers an allocation for all existing  
> tasks in the
> system, turns on allocation in fork() for future tasks, and  
> collection of the stats.
> When turned off, collection of stats stops as does allocation for  
> future tasks
> (not worth going in and deallocating structs for existing tasks).

> Does this seem worth it ?
>

Definitely not unless we can do it per process and on demand.

> -- Shailabh
>

Cheers

Parag
