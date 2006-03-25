Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750896AbWCYAZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbWCYAZS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 19:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbWCYAZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 19:25:18 -0500
Received: from omta05ps.mx.bigpond.com ([144.140.83.195]:7907 "EHLO
	omta05ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750896AbWCYAZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 19:25:17 -0500
Message-ID: <44248DE7.80001@bigpond.net.au>
Date: Sat, 25 Mar 2006 11:25:11 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Mike Galbraith <efault@gmx.de>, lkml <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [2.6.16-mm1 patch] throttling tree patches
References: <1143198208.7741.8.camel@homer> <200603242237.38100.kernel@kolivas.org>
In-Reply-To: <200603242237.38100.kernel@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sat, 25 Mar 2006 00:25:12 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Friday 24 March 2006 22:03, Mike Galbraith wrote:
>> Greetings,
> 
> /me waves
> 
>> Ignore timewarps caused by SMP timestamp rounding.  Also, don't stamp a
>> task with a computed timestamp, stamp with the already called clock.
> 
> Looks good. Actually now < p->timestamp is not going to only happen on SMP. 
> Once every I don't know how often the sched_clock seems to return a value 
> that appears to have been in the past (I believe Peter has instrumented 
> this).

I haven't bothered to check if it still occurs for quite a long while. 
I just check for time deltas being negative and if they are negative I 
make them zero and move on.  As far as I can remember I only ever saw 
this when measuring "delay" (i.e. time on the run queue waiting to get 
on to a CPU which can be quite short :-) when the systems not heavily 
loaded) as other time intervals that I measure (i.e. time on CPU and 
sleep time) are generally long enough for the error in the delta not 
being big enough to make the value negative.

> 
>> Signed-off-by: Mike Galbraith <efault@gmx.de>
> 
>> +		__sleep_time = 0ULL;
> 
> I don't think the ULL is necessary.
> 
>> -	unsigned long long now;
>> +	unsigned long long now, comp;
>>
>> -	now = sched_clock();
>> +	now = comp = sched_clock();
>>  #ifdef CONFIG_SMP
>>  	if (!local) {
>>  		/* Compensate for drifting sched_clock */
>>  		runqueue_t *this_rq = this_rq();
>> -		now = (now - this_rq->timestamp_last_tick)
>> +		comp = (now - this_rq->timestamp_last_tick)
>>  			+ rq->timestamp_last_tick;
>>  	}
>>  #endif
>>
>>  	if (!rt_task(p))
>> -		p->prio = recalc_task_prio(p, now);
>> +		p->prio = recalc_task_prio(p, comp);
> 
> Seems wasteful of a very expensive (on 32bit) unsigned long long on 
> uniprocessor builds.

Unsigned long long is necessary in order to avoid overflow when dealing 
with nano seconds but (if you reorganized the expressions and made the 
desired precedence explicit) you could probably use something smaller 
for the difference between the two timestamp_lats_tick values.  More 
importantly, I think that the original code which used the computed 
"now" was correct as otherwise the task's timestamp will not have the 
correct time for its CPU.

Of course, this all hinges on the differences between the run queues' 
timestamp_last_tick fields being a true measure of the time drift 
between them.  I've never been wholly convinced of that but as long as 
any error is much smaller than the drift it's probably worth doing.

Peter
PS I think that some inline functions to handle timestamp adjustment 
wouldn't hurt.
PPS I'm not sure that the timstamp adjustment in __migrate_task() is 
completely valid as the timestamp will be modified in activate_task() 
using the wrong clock.  I need to study this more to see if I convince 
myself one way or the other.
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
