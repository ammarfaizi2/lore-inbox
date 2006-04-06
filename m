Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbWDFXGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbWDFXGa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 19:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbWDFXGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 19:06:30 -0400
Received: from omta02sl.mx.bigpond.com ([144.140.93.154]:42913 "EHLO
	omta02sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932197AbWDFXGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 19:06:30 -0400
Message-ID: <44359EF3.9070708@bigpond.net.au>
Date: Fri, 07 Apr 2006 09:06:27 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Darren Hart <darren@dvhart.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       "Stultz, John" <johnstul@us.ibm.com>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: RT task scheduling
References: <200604052025.05679.darren@dvhart.com> <20060406073753.GA18349@elte.hu>
In-Reply-To: <20060406073753.GA18349@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Thu, 6 Apr 2006 23:06:27 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Darren Hart <darren@dvhart.com> wrote:
> 
>> My last mail specifically addresses preempt-rt, but I'd like to know 
>> people's thoughts regarding this issue in the mainline kernel.  Please 
>> see my previous post "realtime-preempt scheduling - rt_overload 
>> behavior" for a testcase that produces unpredictable scheduling 
>> results.
> 
> the rt_overload feature i intend to push upstream-wards too, i just 
> didnt separate it out of -rt yet.
> 
> "RT overload scheduling" is a totally orthogonal mechanism to the SMP 
> load-balancer (and this includes smpnice too) that is more or less 
> equivalent to having a 'global runqueue' for real-time tasks, without 
> the SMP overhead associated with that. If there is no "RT overload" [the 
> common case even on Linux systems that _do_ make use of RT tasks 
> occasionally], the new mechanism is totally inactive and there's no 
> overhead. But once there are more RT tasks than CPUs, the scheduler will 
> do "global" decisions for what RT tasks to run on which CPU. To put even 
> less overhead on the mainstream kernel, i plan to introduce a new 
> SCHED_FIFO_GLOBAL scheduling policy to trigger this behavior. [it doesnt 
> make much sense to extend SCHED_RR in that direction.]
> 
> my gut feeling is that it would be wrong to integrate this feature into 
> smpnice: SCHED_FIFO is about determinism, and smpnice is a fundamentally 
> statistical approach. Also, smpnice doesnt have to try as hard to pick 
> the right task as rt_overload does, so there would be constant 
> 'friction' between "overhead" optimizations (dont be over-eager) and 
> "latency" optimizations (dont be _under_-eager). So i'm quite sure we 
> want this feature separate. [nevertheless i'd happy to be proven wrong 
> via some good and working smpnice based solution]

I was thinking about this over night and came to similar conclusions. 
I.e. for RT tasks it's really a problem of selecting the right CPU at 
wake up time rather than a general load balancing problem.  The solution 
that I thought of was different (though) and involved modifying 
wake_idle() so that when the woken task was high priority as well as 
looking for idle CPUs it looked for the one with the lowest priority 
current task and if it couldn't find an idle CPU it returned the one 
with the lowest priority current task.  The aim was to maximize the 
probability that the newly woken task went straight onto a CPU (either 
by finding an idle one or preemption).

Although aimed at this specific problem, this solution would also help 
smpnice to attain equal "average load per task" values for groups/queues 
which I think is a desirable secondary aim to equatable distribution of 
weighted load.  If both of these aims are met I think a natural outcome 
would be that the highest priority tasks are well distributed among the 
CPUs (but, as you imply, this would be a statistical trend rather than 
an deterministic).

In summary, I think that smpnice can be modified in ways that will help 
with this problem but if you need determinism then special measures are 
probably necessary.

Peter
---
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
