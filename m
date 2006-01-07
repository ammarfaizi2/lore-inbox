Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030268AbWAGGe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030268AbWAGGe0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 01:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932693AbWAGGe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 01:34:26 -0500
Received: from omta01ps.mx.bigpond.com ([144.140.82.153]:31380 "EHLO
	omta01ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932688AbWAGGeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 01:34:25 -0500
Message-ID: <43BF60EE.70909@bigpond.net.au>
Date: Sat, 07 Jan 2006 17:34:22 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: Helge Hafting <helgehaf@aitel.hist.no>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ingo Molnar <mingo@elte.hu>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: Fix adverse effects of NFS client     on	interactive
 response
References: <5.2.1.1.2.20060106074738.00bbaeb8@pop.gmx.net> <5.2.1.1.2.20060105143705.00be85c8@pop.gmx.net> <5.2.1.1.2.20060105070601.026b21f0@pop.gmx.net> <43BB2414.6060400@bigpond.net.au> <43A8EF87.1080108@bigpond.net.au> <1135145341.7910.17.camel@lade.trondhjem.org> <43A8F714.4020406@bigpond.net.au> <20060102110145.GA25624@aitel.hist.no> <43B9BD19.5050408@bigpond.net.au> <43BB2414.6060400@bigpond.net.au> <5.2.1.1.2.20060105070601.026b21f0@pop.gmx.net> <5.2.1.1.2.20060105143705.00be85c8@pop.gmx.net> <5.2.1.1.2.20060106074738.00bbaeb8@pop.gmx.net> <5.2.1.1.2.20060107051229.00c42230@pop.gmx.net>
In-Reply-To: <5.2.1.1.2.20060107051229.00c42230@pop.gmx.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sat, 7 Jan 2006 06:34:22 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> At 12:11 PM 1/7/2006 +1100, Peter Williams wrote:
> 
>> Is that patch complete?  (This is all I got.)
> 
> 
> Yes.
> 
>> --- linux-2.6.15/kernel/sched.c.org     Fri Jan  6 08:44:09 2006
>> +++ linux-2.6.15/kernel/sched.c Fri Jan  6 08:51:03 2006
>> @@ -1353,7 +1353,7 @@
>>
>>  out_activate:
>>  #endif /* CONFIG_SMP */
>> -       if (old_state == TASK_UNINTERRUPTIBLE) {
>> +       if (old_state & TASK_UNINTERRUPTIBLE) {
>>                 rq->nr_uninterruptible--;
>>                 /*
>>                 * Tasks on involuntary sleep don't earn
>> @@ -3010,7 +3010,7 @@
>>                                 unlikely(signal_pending(prev))))
>>                         prev->state = TASK_RUNNING;
>>                 else {
>> -                       if (prev->state == TASK_UNINTERRUPTIBLE)
>> +                       if (prev->state & TASK_UNINTERRUPTIBLE)
>>                                 rq->nr_uninterruptible++;
>>                         deactivate_task(prev, rq);
>>                 }
>>
>> In the absence of any use of TASK_NONINTERACTIVE in conjunction with 
>> TASK_UNINTERRUPTIBLE it will have no effect.
> 
> 
> Exactly.  It's only life insurance.
> 
>>   Personally, I think that all TASK_UNINTERRUPTIBLE sleeps should be 
>> treated as non interactive rather than just be heavily discounted (and 
>> that TASK_NONINTERACTIVE shouldn't be needed in conjunction with it) 
>> BUT I may be wrong especially w.r.t. media streamers such as audio and 
>> video players and the mechanisms they use to do sleeps between cpu 
>> bursts.
> 
> 
> Try it, you won't like it.

It's on my list of things to try.

>  When I first examined sleep_avg woes, my 
> reaction was to nuke uninterruptible sleep too... boy did that ever 
> _suck_ :)

I look forward to seeing it.  :-)

> 
> I'm trying to think of ways to quell the nasty side of sleep_avg without 
> destroying the good.  One method I've tinkered with in the past with 
> encouraging results is to compute a weighted slice_avg, which is a 
> measure of how long it takes you to use your slice, and scale it to 
> match MAX_SLEEPAVG for easy comparison.  A possible use thereof:  In 
> order to be classified interactive, you need the sleep_avg, but that's 
> not enough... you also have to have a record of sharing the cpu. When 
> your slice_avg degrades enough as you burn cpu, you no longer get to 
> loop in the active queue.  Being relegated to the expired array though 
> will improve your slice_avg and let you regain your status.  Your 
> priority remains, so you can still preempt, but you become mortal and 
> have to share.  When there is a large disparity between sleep_avg and 
> slice_avg, it can be used as a general purpose throttle to trigger 
> TASK_NONINTERACTIVE flagging in schedule() as negative feedback for the 
> ill behaved.  Thoughts?

Sounds like the kind of thing that's required.  I think the deferred 
shift from active to expired is safe as long as CPU hogs can't exploit 
it and your scheme sounds like it might provide that assurance.  One 
problem this solution will experience is that when the system gets 
heavily loaded every task will have small CPU usage rates (even the CPU 
hogs) and this makes it harder to detect the CPU hogs.  One slight 
variation of your scheme would be to measure the average length of the 
CPU runs that the task does (i.e. how long it runs without voluntarily 
relinquishing the CPU) and not allowing them to defer the shift to the 
expired array if this average run length is greater than some specified 
value.  The length of this average for each task shouldn't change with 
system load.  (This is more or less saying that it's ok for a task to 
stay on the active array provided it's unlikely to delay the switch 
between the active and expired arrays for very long.)

My own way around the problem is to nuke the expired/active arrays and 
use a single priority array.  That gets rid of the problem of deferred 
shifting from active to expired all together.  :-)

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
