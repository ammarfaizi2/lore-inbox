Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262004AbVEKSFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262004AbVEKSFf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 14:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbVEKSFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 14:05:32 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:17089 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S262004AbVEKSFQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 14:05:16 -0400
X-ORBL: [67.117.73.34]
Date: Wed, 11 May 2005 11:03:49 -0700
From: Tony Lindgren <tony@atomide.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Rusty Russell <rusty@rustcorp.com.au>, vatsa@in.ibm.com,
       schwidefsky@de.ibm.com, jdike@addtoit.com,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [RFC] (How to) Let idle CPUs sleep
Message-ID: <20050511180349.GG15479@atomide.com>
References: <20050507182728.GA29592@in.ibm.com> <1115524211.17482.23.camel@localhost.localdomain> <427D921F.8070602@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <427D921F.8070602@yahoo.com.au>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Nick Piggin <nickpiggin@yahoo.com.au> [050507 21:15]:
> Rusty Russell wrote:
> >On Sat, 2005-05-07 at 23:57 +0530, Srivatsa Vaddagiri wrote:
> >
> >>Two solutions have been proposed so far:
> >>
> >>	A. As per Nick's suggestion, impose a max limit (say some 100 ms or
> >>	   say a second, Nick?) on how long a idle CPU can avoid taking
> 
> Yeah probably something around that order of magnitude. I suspect
> there will fast be a point where either you'll get other timers
> going off more frequently, and / or you simply get very quickly
> diminishing returns on the amount of power saving gained from
> increasing the period.
> 
> >>	   local-timer ticks. As a result, the load imbalance could exist 
> >>	   only
> >>	   for this max duration, after which the sleeping CPU will wake up
> >>	   and balance itself. If there is no imbalance, it can go and sleep
> >>	   again for the max duration.
> >>
> >>	   For ex, lets say a idle CPU found that it doesn't have any near 
> >>	   timer
> >>	   for the next 1 minute. Instead of letting it sleep for 1 minute in
> >>	   a single stretch, we let it sleep in bursts of 100 msec (or 
> >>	   whatever
> >>	   is the max. duration chosen). This still is better than having
> >>	   the idle CPU take HZ ticks a second.
> >>
> >>	   As a special case, when all the CPUs of an image go idle, we
> >>	   could consider completely shutting off local timer ticks
> >>	   across all CPUs (till the next non-timer interrupt).
> >>
> >>
> >>	B. Don't impose any max limit on how long a idle CPU can sleep.
> >>	   Here we let the idle CPU sleep as long as it wants. It is
> >>	   woken up by a "busy" CPU when it detects an imbalance. The
> >>	   busy CPU acts as a watchdog here. If there are no such
> >>	   busy CPUs, then it means that nobody will acts as watchdogs
> >>	   and idle CPUs sleep as long as they want. A possible watchdog
> >>	   implementation has been discussed at:
> >>
> >>	http://marc.theaimsgroup.com/?l=linux-kernel&m=111287808905764&w=2
> >
> >
> >My preference would be the second: fix the scheduler so it doesn't rely
> >on regular polling.
> 
> It is not so much a matter of "fixing" the scheduler as just adding
> more heuristics. When are we too busy? When should we wake another
> CPU? What if that CPU is an SMT sibling? What if it is across the
> other side of the topology, and other CPUs closer to it are busy
> as well? What if they're busy but not as busy as we are? etc.
> 
> We've already got that covered in the existing periodic pull balancing,
> so instead of duplicating this logic and moving this extra work to busy
> CPUs, we can just use the existing framework.
> 
> At least we should try method A first, and if that isn't good enough
> (though I suspect it will be), then think about adding more complexity
> to the scheduler.
> 
> > However, as long as the UP case runs with no timer
> >interrupts when idle, many people will be happy (eg. most embedded).
> >
> 
> Well in the UP case, both A and B should basically degenerate to the
> same thing.
> 
> Probably the more important case for the scheduler is to be able to
> turn off idle SMP hypervisor clients, Srivatsa?

Sorry to jump in late. For embedded stuff we should be able to skip
ticks until something _really_ happens, like an interrupt.

So we need to be able to skip ticks several seconds at a time. Ticks
should be event driven. For embedded systems option B is really
the only way to go to take advantage of the power savings.

Of course the situation is different on servers, where the goal is
to save ticks to be able to run more virtual machines. And then
cutting down the ticks down to few per second does the trick.

Regards,

Tony
