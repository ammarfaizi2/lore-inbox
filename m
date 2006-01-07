Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030366AbWAGIyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030366AbWAGIyp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 03:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030367AbWAGIyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 03:54:45 -0500
Received: from mail.gmx.de ([213.165.64.21]:26505 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030366AbWAGIyo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 03:54:44 -0500
X-Authenticated: #14349625
Message-Id: <5.2.1.1.2.20060107085929.00c24f98@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Sat, 07 Jan 2006 09:54:27 +0100
To: Peter Williams <pwil3058@bigpond.net.au>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] sched: Fix adverse effects of NFS client    
  on	interactive response
Cc: Helge Hafting <helgehaf@aitel.hist.no>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ingo Molnar <mingo@elte.hu>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <43BF60EE.70909@bigpond.net.au>
References: <5.2.1.1.2.20060107051229.00c42230@pop.gmx.net>
 <5.2.1.1.2.20060106074738.00bbaeb8@pop.gmx.net>
 <5.2.1.1.2.20060105143705.00be85c8@pop.gmx.net>
 <5.2.1.1.2.20060105070601.026b21f0@pop.gmx.net>
 <43BB2414.6060400@bigpond.net.au>
 <43A8EF87.1080108@bigpond.net.au>
 <1135145341.7910.17.camel@lade.trondhjem.org>
 <43A8F714.4020406@bigpond.net.au>
 <20060102110145.GA25624@aitel.hist.no>
 <43B9BD19.5050408@bigpond.net.au>
 <43BB2414.6060400@bigpond.net.au>
 <5.2.1.1.2.20060105070601.026b21f0@pop.gmx.net>
 <5.2.1.1.2.20060105143705.00be85c8@pop.gmx.net>
 <5.2.1.1.2.20060106074738.00bbaeb8@pop.gmx.net>
 <5.2.1.1.2.20060107051229.00c42230@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Antivirus: avast! (VPS 0601-0, 01/02/2006), Outbound message
X-Antivirus-Status: Clean
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 05:34 PM 1/7/2006 +1100, Peter Williams wrote:
>Mike Galbraith wrote:
>
>>I'm trying to think of ways to quell the nasty side of sleep_avg without 
>>destroying the good.  One method I've tinkered with in the past with 
>>encouraging results is to compute a weighted slice_avg, which is a 
>>measure of how long it takes you to use your slice, and scale it to match 
>>MAX_SLEEPAVG for easy comparison.  A possible use thereof:  In order to 
>>be classified interactive, you need the sleep_avg, but that's not 
>>enough... you also have to have a record of sharing the cpu. When your 
>>slice_avg degrades enough as you burn cpu, you no longer get to loop in 
>>the active queue.  Being relegated to the expired array though will 
>>improve your slice_avg and let you regain your status.  Your priority 
>>remains, so you can still preempt, but you become mortal and have to 
>>share.  When there is a large disparity between sleep_avg and slice_avg, 
>>it can be used as a general purpose throttle to trigger 
>>TASK_NONINTERACTIVE flagging in schedule() as negative feedback for the 
>>ill behaved.  Thoughts?
>
>Sounds like the kind of thing that's required.  I think the deferred shift 
>from active to expired is safe as long as CPU hogs can't exploit it and 
>your scheme sounds like it might provide that assurance.  One problem this 
>solution will experience is that when the system gets heavily loaded every 
>task will have small CPU usage rates (even the CPU hogs) and this makes it 
>harder to detect the CPU hogs.

True.  A gaggle of more or less equally well (or not) behaving tasks will 
have their 'hogginess' diluted.   I'll have to think more about scaling 
with nr_running or maybe starting the clock at first tick of a new slice... 
that should still catch most of the guys who are burning hard without being 
preempted, or only sleeping for short intervals only to keep coming right 
back to beat up poor cc1.  I think the real problem children should stick 
out enough for a proof of concept even without additional complexity.

>   One slight variation of your scheme would be to measure the average 
> length of the CPU runs that the task does (i.e. how long it runs without 
> voluntarily relinquishing the CPU) and not allowing them to defer the 
> shift to the expired array if this average run length is greater than 
> some specified value.  The length of this average for each task shouldn't 
> change with system load.  (This is more or less saying that it's ok for a 
> task to stay on the active array provided it's unlikely to delay the 
> switch between the active and expired arrays for very long.)

Average burn time would indeed probably be a better metric, but that would 
require doing bookkeeping is the fast path.  I'd like to stick to tick time 
or even better, slice renewal time if possible to keep it down on the 'dead 
simple and dirt cheap' shelf.  After all, this kind of thing is supposed to 
accomplish absolutely nothing meaningful the vast majority of the time :)

         Thanks for the feedback,

         -Mike 

