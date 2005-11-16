Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965121AbVKPAl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965121AbVKPAl7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 19:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965122AbVKPAl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 19:41:59 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:12675 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965121AbVKPAl7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 19:41:59 -0500
Message-ID: <437A8142.7030106@watson.ibm.com>
Date: Tue, 15 Nov 2005 19:45:54 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Parag Warudkar <kernel-stuff@comcast.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 1/4] Delay accounting: Initialization
References: <43796596.2010908@watson.ibm.com> <1F92A563-B430-49FE-895E-FB93DC64981E@comcast.net> <437A613A.1020705@watson.ibm.com> <4ABDC730-2888-4DBE-B1DC-62362A87EEB7@comcast.net>
In-Reply-To: <4ABDC730-2888-4DBE-B1DC-62362A87EEB7@comcast.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Parag Warudkar wrote:
> 
> On Nov 15, 2005, at 5:29 PM, Shailabh Nagar wrote:
<snip>
> 
>>> Does this mean, whether or not the per task delay accounting is used,
>>> we have a constant overhead of sizeof(spinlock_t) + 2*sizeof  (uint32_t)
>>> + 2* sizeof(uint64_t) bytes going into the struct  task_struct?.  Is it
>>> possible/beneficial to use struct task_delay_info  *delays instead  and
>>> allocate it if task wants to use the information?
>>>
>>
>> Doing so would have value in the case where the feature is  configured
>> but no one ever registers to listen for it.
> 
> 
> Precisely. Such a feature will be used only occasionally I suppose.
> I didn't read the code deeply but are any scheduling decisions  altered
> based on this data? If not, then it makes sense to not account unless required.
> 
> I think it should be possible to do it on demand, per process instead 
> of forcing the accounting on _all_ processes which cumulatively becomes a  sizeable
> o/h.
> 
> Per Process activation of this feature will add significant value  IMHO.
> (Of course, if that's possible in first place.)


Per-task activation is useful/possible only for long-running tasks.
If one is trying to gather stats for a user-defined grouping of tasks
then it would involve too much overhead & inaccuracy to require monitoring
to be turned on individually.

> 
>> The cost of doing this would be
>> - adding more code to the fork path to allocate conditionally
> 
> 
> Just an unlikely branch for normal code path - not a big deal.
> Also I am thinking it could be handled outside of fork?

only if per-task activation is done - thats probably what you meant ?

> 
>> - make the collecting of the delays conditional on a similar check
> 
> 
> Weighing this against the actual accounting - I think it's a win.

Hmmm..since there is locking involved in the stats collection, this is
starting to make a lot of sense.

> 
>> - cache pollution from following an extra pointer in the pgflt/
>> io_schedule paths
>> I'm not sure is this really matters for these two code paths.
> 
> 
> Possibly.
> 
>> Even if one does this, once the first listener registers, all  future
>> tasks
>> (and even the current ones) will have to go ahead and allocate the 
>> structure
>> and accounting of delays will have to switch to unconditional mode. 
>> This is
>> because the delay data has cumulative value...future listeners will be
>> interested in data collected earlier (as long as task is still 
>> running). And
>> once the first listener registers, you can no longer be sure no  one's
>> interested
>> in the future.
>>
> 
> Is it possible to do it per process? Forcing it on all processes is 
> what I was trying to avoid given the feature's usage pattern.
> 
>> Another alternative is to let userland control the overhead of 
>> allocation and
>> collection completely through a /proc/sys/kernel/delayacct variable.
>> When its switched on, it triggers an allocation for all existing 
>> tasks in the
>> system, turns on allocation in fork() for future tasks, and 
>> collection of the stats.
>> When turned off, collection of stats stops as does allocation for 
>> future tasks
>> (not worth going in and deallocating structs for existing tasks).
> 
> 
>> Does this seem worth it ?
>>
> 
> Definitely not unless we can do it per process and on demand.

Per-task doesn't seem like a good idea. Neither does allowing dynamic
switching off/on of the allocation of the delay struct.

So how about this:

Have /proc/sys/kernel/delayacct and a corresponding kernel boot parameter (for setting
the switch early) which control just the collection of data. Allocation always happens.


>> -- Shailabh
>>
> 
> Cheers
> 
> Parag
> 

