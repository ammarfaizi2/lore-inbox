Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268950AbUJEHoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268950AbUJEHoz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 03:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268954AbUJEHoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 03:44:55 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:39037 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268950AbUJEHow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 03:44:52 -0400
Message-ID: <416250F0.5010008@yahoo.com.au>
Date: Tue, 05 Oct 2004 17:44:48 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Williams <pwil3058@bigpond.net.au>
CC: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: bug in sched.c:task_hot()
References: <200410050237.i952bx620740@unix-os.sc.intel.com> <41624E42.8030105@bigpond.net.au>
In-Reply-To: <41624E42.8030105@bigpond.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Chen, Kenneth W wrote:
> 
>> Current implementation of task_hot() has a performance bug in it
>> that it will cause integer underflow.
>>
>> Variable "now" (typically passed in as rq->timestamp_last_tick)
>> and p->timestamp are all defined as unsigned long long.  However,
>> If former is smaller than the latter, integer under flow occurs
>> which make the result of subtraction a huge positive number. Then
>> it is compared to sd->cache_hot_time and it will wrongly identify
>> a cache hot task as cache cold.
>>
>> This bug causes large amount of incorrect process migration across
>> cpus (at stunning 10,000 per second) and we lost cache affinity very
>> quickly and almost took double digit performance regression on a db
>> transaction processing workload.  Patch to fix the bug.  Diff'ed against
>> 2.6.9-rc3.
>>
>> Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>
>>
>>
>> --- linux-2.6.9-rc3/kernel/sched.c.orig    2004-10-04 
>> 19:11:21.000000000 -0700
>> +++ linux-2.6.9-rc3/kernel/sched.c    2004-10-04 19:19:27.000000000 -0700
>> @@ -180,7 +180,8 @@ static unsigned int task_timeslice(task_
>>      else
>>          return SCALE_PRIO(DEF_TIMESLICE, p->static_prio);
>>  }
>> -#define task_hot(p, now, sd) ((now) - (p)->timestamp < 
>> (sd)->cache_hot_time)
>> +#define task_hot(p, now, sd) ((long long) ((now) - (p)->timestamp)    \
>> +                < (long long) (sd)->cache_hot_time)
>>
>>  enum idle_type
>>  {
> 
> 
> The interesting question is: How does now get to be less than timestamp? 
>  This probably means that timestamp_last_tick is not a good way of 
> getting a value for "now".

It is the best we can do.

>  By the way, neither is sched_clock() when 
> measuring small time differences as it is not monotonic (something that 
> I had to allow for in my scheduling code).

I'm pretty sure it is monotonic, actually. I know some CPUs can execute
rdtsc speculatively, but I don't think it would ever be sane to execute
two rdtsc's in the wrong order.

>  I applied no such safeguards 
> to the timing used by the load balancing code as I assumed that it 
> already worked.

It should (modulo this bug).
