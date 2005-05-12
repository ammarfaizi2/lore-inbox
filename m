Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262149AbVELWQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262149AbVELWQI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 18:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262154AbVELWQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 18:16:08 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:63218 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262149AbVELWPw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 18:15:52 -0400
Message-ID: <4283D581.9070008@mvista.com>
Date: Thu, 12 May 2005 15:15:29 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesse Barnes <jesse.barnes@intel.com>
CC: vatsa@in.ibm.com, Tony Lindgren <tony@atomide.com>,
       Lee Revell <rlrevell@joe-job.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, schwidefsky@de.ibm.com,
       jdike@addtoit.com, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] (How to) Let idle CPUs sleep
References: <20050507182728.GA29592@in.ibm.com> <20050512171251.GA21656@in.ibm.com> <4283C795.1050704@mvista.com> <200505121435.01011.jesse.barnes@intel.com>
In-Reply-To: <200505121435.01011.jesse.barnes@intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes wrote:
> On Thursday, May 12, 2005 2:16 pm, George Anzinger wrote:
> 
>>The tickless system differs from VST in that it is designed to only
>>"tick" when there is something in the time list to do and it does
>>this ALWAYS.
> 
> 
> Right, that's what I gathered (and what I was getting at).
> 
> 
>>And this is exactly where the tickless system runs into overload. 
>>Simply speaking, each task has with it certain limits and
>>requirements WRT time.  It is almost always time sliced, but it may
>>also have execution limits and settimer execution time interrupts
>>that it wants.
> 
> 
> Right...
> 
> 
>>These need to be set up for each task when it is 
>>switched to and removed when the system switches away from it.
> 
> 
> Why do they need to be switched when the task's slice is up?

No, that would not be too bad, but they need to be removed when the task is 
switched away from.  This happens FAR more often than a slice expiring.  Most 
tasks are switched away from because they block, not because their time is over.

  Can't they
> remain in the timer list?  

We are timeing the tasks slice.  It is only active when the task has the cpu...

I guess I'm imagining a global outstanding
> timer list that's manipulated by add/remove_timer, settimer, etc..  
> When a timeout occurs the timer interrupt handler could mark tasks 
> runnable again, bump their priority, send SIGALRM, or whatever.  Most 

The timers that cause the problem are the ones that only run when the task is 
active.  These are the slice timer, the profile timer (ITIMER_PROF), the 
execution limit timer and the settime timer that is relative to execution time 
(ITIMER_VIRTUAL).

Again, we can colapse all these to one, but still it needs to be setup when the 
task is switched to and removed when it is switched away.

> timers are deleted before they expire anyway, right?  If that's true 
> you definitely don't want to save and restore them on every context 
> switch...

One of these timers is almost ALWAYS needed.  And yes, mostly they do not 
expire.  That is usually good as an expire cost more than a removal (provided 
you do not need to reprogram the timer as a result).

Timers that run on system time (ITIMER_REAL) stay in the list even when the task 
is inactive.
> 
> 
>>In 
>>the test I did, I reduced all these timers to one (I think I just
>>used the slice time, but this is not the thing to do if the user is
>>trying to do profiling.  In any case, only one timer needs to be set
>>up, possibly some work needs to be done to find the min. of all the
>>execution time timers it has, but only that one needs to go in the
>>time list.).
> 
> 
> Or at least only the nearest one has to be programmed as the next 
> interrupt, and before going back to sleep the kernel could check if any 
> timers had expired while the last one was running (aren't missing 
> jiffies accounted for this way too, but of course jiffies would go away 
> in this scheme)?
> 
> 
>>BUT it needs to happen each context switch time and 
>>thus adds overhead to the switch time.  In my testing, the overhead
>>for this became higher than the ticked system overhead for the same
>>services at a relatively low context switch rate.
> 
> 
> Yeah, that does sound expensive.
> 
> 
>>From a systems 
>>point of view, you just don't want to increase overhead when the load
>>goes up.  This leads to fragile systems.
>>
>>Now, the question still remains, if a cpu in an SMP system is
>>sleeping because of VST, who or how is it to be wakened to responded
>>to increases in the system load.  If all CPUs are sleeping, there is
>>some event (i.e. interrupt) that does this.  I think, in an SMP
>>system, any awake CPUs should, during their load balancing, notice
>>that there are sleeping CPUs and wake them as the load increases.
> 
> 
> Sounds reasonable to me, should be as simple as a 'wake up and load 
> balance' IPI, right?

I think there is already an IPI to tell another cpu that it has work.  That 
should be enough.  Need to check, however.  From the VST point of view, any 
interrupt wake the cpu from the VST sleep, so it need not even target the 
scheduler..

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
