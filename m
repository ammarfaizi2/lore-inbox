Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317533AbSFRSIA>; Tue, 18 Jun 2002 14:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317534AbSFRSIA>; Tue, 18 Jun 2002 14:08:00 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:50681 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S317533AbSFRSH6>;
	Tue, 18 Jun 2002 14:07:58 -0400
Message-ID: <3D0F76E4.AC6EA257@mvista.com>
Date: Tue, 18 Jun 2002 11:07:32 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Matthew Wilcox <willy@debian.org>, Robert Love <rml@mvista.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Replace timer_bh with tasklet
References: <Pine.LNX.4.44.0206172104450.1164-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 17 Jun 2002, george anzinger wrote:
> >
> > This patch replaces the timer_bh with a tasklet.  It also introduces a
> > way to flag a tasklet as a must run (i.e. do NOT kick up to ksoftirqd).
> >
> > It make NO sense to pass timer work to a task.
> 
> I hate adding infrastructure that isn't needed.
> 
> Is there any reason why it would be _wrong_ to pass the timer work to a
> task? In particular, is it really any more wrong than anything else?
> 
> I don't see that there is any difference between a timer bh and any other
> BH.

I reasoned that the timers, unlike most other I/O, directly drive the system.  
For example, the time slice is counted down by the timer BH.  By pushing the 
timer out to ksoftirqd, running at nice 19, you open the door to a compute 
bound task running over its time slice (admittedly this should be caught on 
the next interrupt).  Also, a great deal of the system depends on timers to 
expire reasonably close to the correct time and not to be delayed by 
scheduling decisions (oops, recursion).

As to infrastructure, why is ksoftirqd needed at all?  IMNSHO it introduces 
system overhead just when the system is most loaded.  The work must be done 
sometime soon in any case. Interrupts are on so all we are gaining is a bit 
of responsiveness in the current task.  But who is to say that the more 
important task isn't being held off by the delay introduced by the 
ksoftirqd "feature".

I do think that it would be a good thing to move some BH processing to the 
task level, but I think it must be done selectively AND that there should 
be a task per BH.  That task should also be adjusted in priority, to the 
users requirements.  This would allow, for example, the network BH code 
to run at a mid level priority such that some real time tasks could 
preempt it, while others could be preempted by it.  

But today we are just trying to say that of all the BH handlers, the 
timer BH, since it drives the scheduler, is more important than other BHs.
> 
>                 Linus
> 
> PS. Your email is also seriously whitespace-damaged, so the patch
> wouldn't have worked anyway.

Sigh, I know....  Lets agree on what is to be done and I will cut a new patch...
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml
