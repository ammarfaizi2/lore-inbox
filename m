Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262141AbVELVhl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262141AbVELVhl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 17:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262142AbVELVhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 17:37:41 -0400
Received: from fmr21.intel.com ([143.183.121.13]:30950 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S262141AbVELVhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 17:37:20 -0400
From: Jesse Barnes <jesse.barnes@intel.com>
To: george@mvista.com
Subject: Re: [RFC] (How to) Let idle CPUs sleep
Date: Thu, 12 May 2005 14:35:00 -0700
User-Agent: KMail/1.8
Cc: vatsa@in.ibm.com, Tony Lindgren <tony@atomide.com>,
       Lee Revell <rlrevell@joe-job.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, schwidefsky@de.ibm.com,
       jdike@addtoit.com, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
References: <20050507182728.GA29592@in.ibm.com> <20050512171251.GA21656@in.ibm.com> <4283C795.1050704@mvista.com>
In-Reply-To: <4283C795.1050704@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505121435.01011.jesse.barnes@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, May 12, 2005 2:16 pm, George Anzinger wrote:
> The tickless system differs from VST in that it is designed to only
> "tick" when there is something in the time list to do and it does
> this ALWAYS.

Right, that's what I gathered (and what I was getting at).

> And this is exactly where the tickless system runs into overload. 
> Simply speaking, each task has with it certain limits and
> requirements WRT time.  It is almost always time sliced, but it may
> also have execution limits and settimer execution time interrupts
> that it wants.

Right...

> These need to be set up for each task when it is 
> switched to and removed when the system switches away from it.

Why do they need to be switched when the task's slice is up?  Can't they 
remain in the timer list?  I guess I'm imagining a global outstanding 
timer list that's manipulated by add/remove_timer, settimer, etc..  
When a timeout occurs the timer interrupt handler could mark tasks 
runnable again, bump their priority, send SIGALRM, or whatever.  Most 
timers are deleted before they expire anyway, right?  If that's true 
you definitely don't want to save and restore them on every context 
switch...

> In 
> the test I did, I reduced all these timers to one (I think I just
> used the slice time, but this is not the thing to do if the user is
> trying to do profiling.  In any case, only one timer needs to be set
> up, possibly some work needs to be done to find the min. of all the
> execution time timers it has, but only that one needs to go in the
> time list.).

Or at least only the nearest one has to be programmed as the next 
interrupt, and before going back to sleep the kernel could check if any 
timers had expired while the last one was running (aren't missing 
jiffies accounted for this way too, but of course jiffies would go away 
in this scheme)?

> BUT it needs to happen each context switch time and 
> thus adds overhead to the switch time.  In my testing, the overhead
> for this became higher than the ticked system overhead for the same
> services at a relatively low context switch rate.

Yeah, that does sound expensive.

> From a systems 
> point of view, you just don't want to increase overhead when the load
> goes up.  This leads to fragile systems.
>
> Now, the question still remains, if a cpu in an SMP system is
> sleeping because of VST, who or how is it to be wakened to responded
> to increases in the system load.  If all CPUs are sleeping, there is
> some event (i.e. interrupt) that does this.  I think, in an SMP
> system, any awake CPUs should, during their load balancing, notice
> that there are sleeping CPUs and wake them as the load increases.

Sounds reasonable to me, should be as simple as a 'wake up and load 
balance' IPI, right?

Jesse
