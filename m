Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261648AbVELVQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbVELVQp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 17:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262124AbVELVQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 17:16:45 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:28656 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261648AbVELVQh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 17:16:37 -0400
Message-ID: <4283C795.1050704@mvista.com>
Date: Thu, 12 May 2005 14:16:05 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: vatsa@in.ibm.com
CC: Jesse Barnes <jesse.barnes@intel.com>, Tony Lindgren <tony@atomide.com>,
       Lee Revell <rlrevell@joe-job.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, schwidefsky@de.ibm.com,
       jdike@addtoit.com, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] (How to) Let idle CPUs sleep
References: <20050507182728.GA29592@in.ibm.com> <1115913679.20909.31.camel@mindpipe> <20050512161636.GA15653@atomide.com> <200505120928.55476.jesse.barnes@intel.com> <20050512171251.GA21656@in.ibm.com>
In-Reply-To: <20050512171251.GA21656@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri wrote:
> On Thu, May 12, 2005 at 09:28:55AM -0700, Jesse Barnes wrote:
> 
>>Seems like we could schedule timer interrupts based solely on add_timer 
>>type stuff; the scheduler could use it if necessary for load balancing 
>>(along with fork/exec based balancing perhaps) on large machines where 
>>load imbalances hurt throughput a lot.  But on small systems if all 
> 
> 
> Even if we were to go for this tickless design, the fundamental question
> remains: who wakes up the (sleeping) idle CPU upon a imbalance? Does some other
> (busy) CPU wake it up (which makes the implementation complex) or the idle CPU 
> checks imbalance itself at periodic intervals (which restricts the amount of
> time a idle CPU may sleep).
> 
> 
>>your processes were blocked, you'd just go to sleep indefinitely and 
>>save a bit of power and avoid unnecessary overhead.
>>
>>I haven't looked at the latest tickless patches, so I'm not sure if my 
>>claims of simplicity are overblown, but especially as multiprocessor 
>>systems become more and more common it just seems wasteful to wakeup 
>>all the CPUs every so often only to have them find that they have 
>>nothing to do.
> 
> 
> I guess George's experience in implementing tickless systems is that
> it is more of an overhead for a general purpose OS like Linux. George?

The tickless system differs from VST in that it is designed to only "tick" when 
there is something in the time list to do and it does this ALWAYS.  The VST 
notion is that ticks are not needed if the cpu is idle.  This is VASTLY simpler 
to do than a tickless system because, mostly, the accounting requirements.  When 
a VST cpu is not ticking, the full sleep time is charged to the idle task and 
the system does not need to time slice or do any time driven user profiling or 
execution limiting.

And this is exactly where the tickless system runs into overload.  Simply 
speaking, each task has with it certain limits and requirements WRT time.  It is 
almost always time sliced, but it may also have execution limits and settimer 
execution time interrupts that it wants.  These need to be set up for each task 
when it is switched to and removed when the system switches away from it.  In 
the test I did, I reduced all these timers to one (I think I just used the slice 
time, but this is not the thing to do if the user is trying to do profiling.  In 
any case, only one timer needs to be set up, possibly some work needs to be done 
to find the min. of all the execution time timers it has, but only that one 
needs to go in the time list.).  BUT it needs to happen each context switch time 
and thus adds overhead to the switch time.  In my testing, the overhead for this 
became higher than the ticked system overhead for the same services at a 
relatively low context switch rate.  From a systems point of view, you just 
don't want to increase overhead when the load goes up.  This leads to fragile 
systems.
> 
Now, the question still remains, if a cpu in an SMP system is sleeping because 
of VST, who or how is it to be wakened to responded to increases in the system 
load.  If all CPUs are sleeping, there is some event (i.e. interrupt) that does 
this.  I think, in an SMP system, any awake CPUs should, during their load 
balancing, notice that there are sleeping CPUs and wake them as the load increases.

> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
