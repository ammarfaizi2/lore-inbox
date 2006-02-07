Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030250AbWBGXUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030250AbWBGXUR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 18:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030252AbWBGXUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 18:20:17 -0500
Received: from omta02ps.mx.bigpond.com ([144.140.83.154]:1454 "EHLO
	omta02ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1030250AbWBGXUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 18:20:15 -0500
Message-ID: <43E92B2B.2060105@bigpond.net.au>
Date: Wed, 08 Feb 2006 10:20:11 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Con Kolivas <kernel@kolivas.org>, npiggin@suse.de, mingo@elte.hu,
       rostedt@goodmis.org, suresh.b.siddha@intel.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org,
       Martin Bligh <mbligh@google.com>
Subject: Re: [rfc][patch] sched: remove smpnice
References: <20060207142828.GA20930@wotan.suse.de>	<200602080157.07823.kernel@kolivas.org> <20060207141525.19d2b1be.akpm@osdl.org>
In-Reply-To: <20060207141525.19d2b1be.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Tue, 7 Feb 2006 23:20:12 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Con Kolivas <kernel@kolivas.org> wrote:
> 
>>On Wednesday 08 February 2006 01:28, Nick Piggin wrote:
>>
>>>I'd like to get some comments on removing smpnice for 2.6.16. I don't
>>>think the code is quite ready, which is why I asked for Peter's additions
>>>to also be merged before I acked it (although it turned out that it still
>>>isn't quite ready with his additions either).

I think the issues have now been resolved (see Martin J Bligh's message 
of 2006/01/29 11:52 "Re: -mm seems significantly slower than mainline on 
kernbench thread").

>>>
>>>Basically I have had similar observations to Suresh in that it does not
>>>play nicely with the rest of the balancing infrastructure (and raised
>>>similar concerns in my review).
>>>
>>>The samples (group of 4) I got for "maximum recorded imbalance" on a 2x2
>>>
>>>SMP+HT Xeon are as follows:
>>>           | Following boot | hackbench 20        | hackbench 40
>>>
>>>-----------+----------------+---------------------+---------------------
>>>2.6.16-rc2 | 30,37,100,112  | 5600,5530,6020,6090 | 6390,7090,8760,8470
>>>+nosmpnice |  3, 2,  4,  2  |   28, 150, 294, 132 |  348, 348, 294, 347
>>>
>>>Hackbench raw performance is down around 15% with smpnice (but that in
>>>itself isn't a huge deal because it is just a benchmark). However, the
>>>samples show that the imbalance passed into move_tasks is increased by
>>>about a factor of 10-30. I think this would also go some way to
>>>explaining latency blips turning up in the balancing code (though I
>>>haven't actually measured that).
>>>
>>>We'll probably have to revert this in the SUSE kernel.
>>>
>>>The other option for 2.6.16 would be to fast track Peter's stuff, which
>>>I could put some time into...

See below.  Should only need testing with hackbench.

> but that seems a bit risky at this stage
>>>of the game.
>>>
>>>I'd like to hear any other suggestions though. Patch included to aid
>>>discussion at this stage, rather than to encourage any rash decisions.
>>
>>I see the demonstrable imbalance but I was wondering if there is there a real 
>>world benchmark that is currently affected?
>>
> 
> 
> Well was any real-world workload (or benchmark) improved by the smpnice
> change?
> 
> Because if we have one workload which slowed and and none which sped up,
> it's a pretty easy decision..

Not really as the "smp nice" mechanism isn't meant to speed things up. 
It's meant to ensure that nice still works more or less as expected on 
SMP systems.  So the real question is "Does it achieve this without 
undue cost or unacceptable side effects?".  Even though there are no 
free lunches the extra costs of this mechanism when there are no non 
zero niced tasks is expected to be almost too small to measure. 
Similarly there should be no side effects unless there are non zero 
niced tasks and the side effects should be predictable (or, at least, 
explainable) and due solely to the fact that nice is being better enforced.

I think that the problems with excessive idling with the early versions 
of my modifications to Con's patch showed that the load balancing code 
is fairly sensitive to the average load per normal task not being 
approximately 1.  My latest patches restore this state of affairs and 
kernbench testing indicates that the excessive idling has gone away (see 
Martin J Bligh's message of 2006/01/29 11:52 "Re: -mm seems 
significantly slower than mainline on kernbench thread").

My testing indicates that niceness works well on dual CPU SMP systems 
but it would be nice if those who have commented (from time to time) on 
the need for this (I forget their names -- Con?) could also test it. 
Some testing of this on larger systems would also be appreciated.  (A 
quick test is to start 4 (reasonably CPU intensive e.g. 80%) tasks per 
CPU with nice values of 0, 5, 10 and 15 and then observing their CPU 
usage rates after the system has had a chance to settle down.  Their 
usage rates should be in accord with their nice values. The aspin 
program in the simloads package 
<http://prdownloads.sourceforge.net/cpuse/simloads-0.1.1.tar.gz?download> 
is suitable for the purpose as it has mechanisms for setting cpu demand 
and niceness.  E.g. "aspin -c 0.08 -p 0.02 -n 4 -N 10 &" would start 4 
copies of aspin with "nice" == 10 that would loop for 6 minutes and 
during each loop it would run until it consumed 0.08 seconds of CPU and 
then sleep until 0.02 seconds have elapsed giving a demand of about 80%. 
  If you do this on a system without the patches you may be lucky and 
have the tasks distributed among the CPUs so that their usage rates 
match their nice values but more often than not they will be distributed 
in ways that causes their usage rates to not match their nice values. 
Users complain when this results in heavily niced tasks still getting 
higher CPU usage rates than tasks with nice of 0.)

Finally, the issue of whether the unacceptable side effects with 
hackbench described by Nick are still present when my patch is applied 
on top of Con's patch needs to be tested.  I think that this is the only 
issue that would prevent my patch going into the main line as the other 
issues have been resolved.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
