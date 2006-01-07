Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161070AbWAGXku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161070AbWAGXku (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 18:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161071AbWAGXku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 18:40:50 -0500
Received: from omta02sl.mx.bigpond.com ([144.140.93.154]:13162 "EHLO
	omta02sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1161070AbWAGXkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 18:40:49 -0500
Message-ID: <43C0517E.8020604@bigpond.net.au>
Date: Sun, 08 Jan 2006 10:40:46 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: Helge Hafting <helgehaf@aitel.hist.no>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ingo Molnar <mingo@elte.hu>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: Fix adverse effects of NFS client      on	interactive
 response
References: <5.2.1.1.2.20060107051229.00c42230@pop.gmx.net> <5.2.1.1.2.20060106074738.00bbaeb8@pop.gmx.net> <5.2.1.1.2.20060105143705.00be85c8@pop.gmx.net> <5.2.1.1.2.20060105070601.026b21f0@pop.gmx.net> <43BB2414.6060400@bigpond.net.au> <43A8EF87.1080108@bigpond.net.au> <1135145341.7910.17.camel@lade.trondhjem.org> <43A8F714.4020406@bigpond.net.au> <20060102110145.GA25624@aitel.hist.no> <43B9BD19.5050408@bigpond.net.au> <43BB2414.6060400@bigpond.net.au> <5.2.1.1.2.20060105070601.026b21f0@pop.gmx.net> <5.2.1.1.2.20060105143705.00be85c8@pop.gmx.net> <5.2.1.1.2.20060106074738.00bbaeb8@pop.gmx.net> <5.2.1.1.2.20060107051229.00c42230@pop.gmx.net> <5.2.1.1.2.20060107085929.00c24f98@pop.gmx.net>
In-Reply-To: <5.2.1.1.2.20060107085929.00c24f98@pop.gmx.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sat, 7 Jan 2006 23:40:46 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> At 05:34 PM 1/7/2006 +1100, Peter Williams wrote:
> 
>> Mike Galbraith wrote:
>>
>>> I'm trying to think of ways to quell the nasty side of sleep_avg 
>>> without destroying the good.  One method I've tinkered with in the 
>>> past with encouraging results is to compute a weighted slice_avg, 
>>> which is a measure of how long it takes you to use your slice, and 
>>> scale it to match MAX_SLEEPAVG for easy comparison.  A possible use 
>>> thereof:  In order to be classified interactive, you need the 
>>> sleep_avg, but that's not enough... you also have to have a record of 
>>> sharing the cpu. When your slice_avg degrades enough as you burn cpu, 
>>> you no longer get to loop in the active queue.  Being relegated to 
>>> the expired array though will improve your slice_avg and let you 
>>> regain your status.  Your priority remains, so you can still preempt, 
>>> but you become mortal and have to share.  When there is a large 
>>> disparity between sleep_avg and slice_avg, it can be used as a 
>>> general purpose throttle to trigger TASK_NONINTERACTIVE flagging in 
>>> schedule() as negative feedback for the ill behaved.  Thoughts?
>>
>>
>> Sounds like the kind of thing that's required.  I think the deferred 
>> shift from active to expired is safe as long as CPU hogs can't exploit 
>> it and your scheme sounds like it might provide that assurance.  One 
>> problem this solution will experience is that when the system gets 
>> heavily loaded every task will have small CPU usage rates (even the 
>> CPU hogs) and this makes it harder to detect the CPU hogs.
> 
> 
> True.  A gaggle of more or less equally well (or not) behaving tasks 
> will have their 'hogginess' diluted.   I'll have to think more about 
> scaling with nr_running or maybe starting the clock at first tick of a 
> new slice... that should still catch most of the guys who are burning 
> hard without being preempted, or only sleeping for short intervals only 
> to keep coming right back to beat up poor cc1.  I think the real problem 
> children should stick out enough for a proof of concept even without 
> additional complexity.
> 
>>   One slight variation of your scheme would be to measure the average 
>> length of the CPU runs that the task does (i.e. how long it runs 
>> without voluntarily relinquishing the CPU) and not allowing them to 
>> defer the shift to the expired array if this average run length is 
>> greater than some specified value.  The length of this average for 
>> each task shouldn't change with system load.  (This is more or less 
>> saying that it's ok for a task to stay on the active array provided 
>> it's unlikely to delay the switch between the active and expired 
>> arrays for very long.)
> 
> 
> Average burn time would indeed probably be a better metric, but that 
> would require doing bookkeeping is the fast path.

Most of the infrastructure is already there and the cost of doing the 
extra bits required to get this metric would be extremely small.  The 
hardest bit would be deciding on the "limit" to be applied when deciding 
whether to let a supposed interactive task stay on the active array.

 From the statistical point of view, the distribution of random time 
intervals with a given average length is such that about 99% of them 
will be less than four times the average length.  So a value of 1/4 of 
the delay in array switches that can be tolerated would be about right. 
  But that still leaves the problem of what delay can be tolerated :-).

>  I'd like to stick to 
> tick time or even better, slice renewal time if possible to keep it down 
> on the 'dead simple and dirt cheap' shelf.  After all, this kind of 
> thing is supposed to accomplish absolutely nothing meaningful the vast 
> majority of the time :)
> 

By the way, it seems you have your own scheduler versions?  If so are 
you interested in adding them to the collection in PlugSched?

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
