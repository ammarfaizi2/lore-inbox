Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130532AbRDGTg5>; Sat, 7 Apr 2001 15:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130552AbRDGTgj>; Sat, 7 Apr 2001 15:36:39 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:21153 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S130532AbRDGTdr>; Sat, 7 Apr 2001 15:33:47 -0400
Subject: Re: [PATCH for 2.5] preemptible kernel
To: Andi Kleen <ak@suse.de>
Cc: ak@suse.de, linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
        nigel@nrg.org, rusty@rustcorp.com.au
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF37B0793C.6B15F182-ON88256A27.0007C3EF@LocalDomain>
From: "Paul McKenney" <Paul.McKenney@us.ibm.com>
Date: Fri, 6 Apr 2001 18:25:36 -0700
X-MIMETrack: Serialize by Router on D03NM045/03/M/IBM(Release 5.0.6 |December 14, 2000) at
 04/07/2001 01:33:31 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andi, thank you for the background!  More comments interspersed...

> On Fri, Apr 06, 2001 at 04:52:25PM -0700, Paul McKenney wrote:
> > 1.   On a busy system, isn't it possible for a preempted task
> >      to stay preempted for a -long- time, especially if there are
> >      lots of real-time tasks in the mix?
>
> The problem you're describing is probably considered too hard to
> solve properly (bad answer, but that is how it is currently)
>
> Yes there is. You can also force a normal (non preemptive) kernel
> into complete livelock by just giving it enough network traffic
> to do, so that it always works in the high priority network
> softirq or doing the same with some other interrupt.
>
> Just when this happens a lot of basic things will stop working (like
> page cleaning, IO flushing etc.), so your callbacks or module unloads
> not running are probably the least of your worries.
>
> The same problem applies to a smaller scale to real time processes;
> kernel services normally do not run real-time, so they can be starved.
>
> Priority inversion is not handled in Linux kernel ATM BTW, there
> are already situations where a realtime task can cause a deadlock
> with some lower priority system thread (I believe there is at least
> one case of this known with realtime ntpd on 2.4)

I see your point here, but need to think about it.  One question:
isn't it the case that the alternative to using synchronize_kernel()
is to protect the read side with explicit locks, which will themselves
suppress preemption?  If so, why not just suppress preemption on the read
side in preemptible kernels, and thus gain the simpler implementation
of synchronize_kernel()?  You are not losing any preemption latency
compared to a kernel that uses traditional locks, in fact, you should
improve latency a bit since the lock operations are more expensive than
are simple increments and decrements.  As usual, what am I missing
here?  ;-)

> > 2.   Isn't it possible to get in trouble even on a UP if a task
> >      is preempted in a critical region?  For example, suppose the
> >      preempting task does a synchronize_kernel()?
>
> Ugly. I guess one way to solve it would be to readd the 2.2 scheduler
> taskqueue, and just queue a scheduler callback in this case.

Another approach would be to define a "really low" priority that noone
other than synchronize_kernel() was allowed to use.  Then the UP
implementation of synchronize_kernel() could drop its priority to
this level, yield the CPU, and know that all preempted tasks must
have obtained and voluntarily yielded the CPU before synchronize_kernel()
gets it back again.

I still prefer suppressing preemption on the read side, though I
suppose one could claim that this is only because I am -really-
used to it.  ;-)

                              Thanx, Paul

