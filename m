Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130565AbRCWMhE>; Fri, 23 Mar 2001 07:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130683AbRCWMgz>; Fri, 23 Mar 2001 07:36:55 -0500
Received: from [32.97.166.34] ([32.97.166.34]:48004 "EHLO prserv.net")
	by vger.kernel.org with ESMTP id <S130565AbRCWMgk>;
	Fri, 23 Mar 2001 07:36:40 -0500
Message-Id: <m14fjfA-001PKRC@mozart>
From: Rusty Russell <rusty@rustcorp.com.au>
To: george anzinger <george@mvista.com>
Cc: nigel@nrg.org, Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for 2.5] preemptible kernel 
In-Reply-To: Your message of "Wed, 21 Mar 2001 00:04:56 -0800."
             <3AB860A8.182A10C7@mvista.com> 
Date: Thu, 22 Mar 2001 01:32:36 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3AB860A8.182A10C7@mvista.com> you write:
> Nigel Gamble wrote:
> > 
> > On Wed, 21 Mar 2001, Keith Owens wrote:
> > > I misread the code, but the idea is still correct.  Add a preemption
> > > depth counter to each cpu, when you schedule and the depth is zero then
> > > you know that the cpu is no longer holding any references to quiesced
> > > structures.
> > 
> > A task that has been preempted is on the run queue and can be
> > rescheduled on a different CPU, so I can't see how a per-CPU counter
> > would work.  It seems to me that you would need a per run queue
> > counter, like the example I gave in a previous posting.
> 
> Exactly so.  The method does not depend on the sum of preemption being
> zip, but on each potential reader (writers take locks) passing thru a
> "sync point".  Your notion of waiting for each task to arrive
> "naturally" at schedule() would work.  It is, in fact, over kill as you
> could also add arrival at sys call exit as a (the) "sync point".  In

Power off is also a sync point 8).  But you want it to happen in
bounded time: consider a daemon which opens a device every minute and
never exits.

Nigel's "traverse the run queue and mark the preempted" solution is
actually pretty nice, and cheap.  Since the runqueue lock is grabbed,
it doesn't require icky atomic ops, either.

Despite Nigel's initial belief that this technique is fragile, I
believe it will become an increasingly fundamental method in the
kernel, so (with documentation) it will become widely understood, as
it offers scalability and efficiency.

Rusty.
--
Premature optmztion is rt of all evl. --DK
