Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267417AbUHJEiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267417AbUHJEiX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 00:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267422AbUHJEiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 00:38:23 -0400
Received: from mail024.syd.optusnet.com.au ([211.29.132.242]:46533 "EHLO
	mail024.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S267417AbUHJEiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 00:38:08 -0400
References: <200408092240.05287.habanero@us.ibm.com> <200408092308.56160.habanero@us.ibm.com>
Message-ID: <cone.1092112649.681597.29067.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Theurer <habanero@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, rocklind@us.ibm.com, mbligh@aracnet.com,
       mingo@elte.hu, akpm@osdl.org
Subject: Re: 2.6.8-rc2-mm2 performance improvements (scheduler?)
Date: Tue, 10 Aug 2004 14:37:29 +1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Theurer writes:

> On Monday 09 August 2004 22:40, you wrote:
>>    Rick showed me schedstats graphs of the two ... it seems to have lower
>>     latency, does less rebalancing, fewer pull_tasks, etc, etc. Everything
>>     looks better ... he'll send them out soon, I think (hint, hint).
>>
>> Okay, they're done. Here's the URL of the graphs:
>>
>>     http://eaglet.rain.com/rick/linux/staircase/scase-vs-noscase.html
>>
>> General summary: as Martin reported, we're seeing improvements in a number
>> of areas, at least with sdet.  The graphs as listed there represent stats
>> from four separate sdet runs run sequentially with an increasing load.
>> (We're trying to see if we can get the information from each run
>> separately, rather than the aggregate -- one of the hazards of an automated
>> test harness :)
> 
> What's quite interesting is that there is a very noticeable surge in 
> load_balance with staircase in the early stage of the test, but there appears 
> to be -no- direct policy changes to load-balance at all in Con's patch (or at 
> least I didn't notice it -please tell me if you did!).  You can see it in 
> busy load_balance, sched_balance_exec, and pull_task.  The runslice and 
> latency stats confirm this -no-staircase does not balance early on, and the 
> tasks suffer, waiting on a cpu already loaded up.  I do not have an 
> explanation for this; perhaps it has something to do with eliminating expired 
> queue.

To be honest I have no idea why that's the case. One of the first things I 
did was eliminate the expired array and in my testing (up to 8x at osdl) I 
did not really notice this in and of itself made any big difference - of 
course this could be because the removal of the expired array was not done 
in a way which entitled starved tasks to run in reasonable timeframes.

> I would be nice to have per cpu runqueue lengths logged to see how this plays 
> out -do the cpus on staircase obtain a runqueue length close to 
> nr_running()/nr_online_cpus sooner than no-staircase?

/me looks in the schedstats peoples' way

> Also, one big change apparent to me, the elimination of TIMESLICE_GRANULARITY. 

Ah well I tuned the timeslice granularity and I can tell you it isn't quite 
what most people think. The granularity when you get to greater than 4 cpus 
is effectively _disabled_. So in fact, the timeslices are shorter in 
staircase (in normal interactive=1, compute=0 mode which is how martin 
would have tested it), not longer. But this is not the reason either since 
in "compute" mode they are ten times longer and this also improves 
throughput further.

> Do you have cswitch data?  I would not be surprised if it's a lot higher on 
> -no-staircase, and cache is thrashed a lot more.  This may be something you 
> can pull out of the -no-staircase kernel quite easily.

Well from what I got on 8x the optimal load (-j x4cpus) and maximal load 
(-j) on kernbench gives surprisingly similar context switch rates. It's only 
when I enable compute mode that the context switches drop compared to 
default staircase mode and mainline. You'd have to ask Martin and Rick about 
what they got.

> -Andrew Theurer

Cheers,
Con

