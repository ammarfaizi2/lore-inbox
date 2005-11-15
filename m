Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965048AbVKOWZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965048AbVKOWZT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 17:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965049AbVKOWZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 17:25:19 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:41690 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S965048AbVKOWZR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 17:25:17 -0500
Message-ID: <437A613A.1020705@watson.ibm.com>
Date: Tue, 15 Nov 2005 17:29:14 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Parag Warudkar <kernel-stuff@comcast.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 1/4] Delay accounting: Initialization
References: <43796596.2010908@watson.ibm.com> <1F92A563-B430-49FE-895E-FB93DC64981E@comcast.net>
In-Reply-To: <1F92A563-B430-49FE-895E-FB93DC64981E@comcast.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Parag Warudkar wrote:
> 
> On Nov 14, 2005, at 11:35 PM, Shailabh Nagar wrote:
> 
>> +/* because of hardware timer drifts in SMPs and task continue on 
>> different cpu
>> + * then where the start_ts was taken there is a possibility that
>> + * end_ts < start_ts by some usecs. In this case we ignore the diff
>> + * and add nothing to the total.
> 
> 
> Curious as to when would this occur. Probably for tasks running on a 
> SMP machine for a very short period of time (timer drift should not  be
> hopefully that high) and switching CPUs in that short period of time?

Possibly. Also, the simpler case of wraparound needs to be handled. Since
one delay sample isn't significant, dropping it seemed the safest bet.


>> +config STATS_CONNECTOR
>> +config DELAY_ACCT
> 
> 
> Probably TASK_DELAY_STATS_CONNECTOR and TASK_DELAY_ACCOUNTING are 
> better names?

TASK_DELAY_ACCOUNTING is better since thats what the code protected
does.

STATS_CONNECTOR can be used to transmit stats other than per-task
delays (current patch also transmits cpu run time). Also there's a possibility
that the overall per-task accounting solution whose discussion was proposed
by Andrew will deviate from delays. So how about TASK_STATS_CONNECTOR.

Will fix in next round.


>> @@ -813,6 +821,9 @@ struct task_struct {
>>      int cpuset_mems_generation;
>>  #endif
>>      atomic_t fs_excl;    /* holding fs exclusive resources */
>> +#ifdef    CONFIG_DELAY_ACCT
>> +    struct task_delay_info delays;
>> +#endif
>>  };
> 
> 
> Does this mean, whether or not the per task delay accounting is used, 
> we have a constant overhead of sizeof(spinlock_t) + 2*sizeof (uint32_t)
> + 2* sizeof(uint64_t) bytes going into the struct  task_struct?. Is it
> possible/beneficial to use struct task_delay_info  *delays instead and
> allocate it if task wants to use the information?
> 

Doing so would have value in the case where the feature is configured but
no one ever registers to listen for it. The cost of doing this would be
- adding more code to the fork path to allocate conditionally
- make the collecting of the delays conditional on a similar check
- cache pollution from following an extra pointer in the pgflt/io_schedule paths
I'm not sure is this really matters for these two code paths.

Even if one does this, once the first listener registers, all future tasks
(and even the current ones) will have to go ahead and allocate the structure
and accounting of delays will have to switch to unconditional mode. This is
because the delay data has cumulative value...future listeners will be
interested in data collected earlier (as long as task is still running). And
once the first listener registers, you can no longer be sure no one's interested
in the future.

Another alternative is to let userland control the overhead of allocation and
collection completely through a /proc/sys/kernel/delayacct variable.
When its switched on, it triggers an allocation for all existing tasks in the
system, turns on allocation in fork() for future tasks, and collection of the stats.
When turned off, collection of stats stops as does allocation for future tasks
(not worth going in and deallocating structs for existing tasks).

Does this seem worth it ?

-- Shailabh


> Parag
>


