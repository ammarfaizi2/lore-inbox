Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312590AbSFTOIJ>; Thu, 20 Jun 2002 10:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313508AbSFTOII>; Thu, 20 Jun 2002 10:08:08 -0400
Received: from mx1.elte.hu ([157.181.1.137]:50118 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S312590AbSFTOII>;
	Thu, 20 Jun 2002 10:08:08 -0400
Date: Thu, 20 Jun 2002 16:05:54 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre10aa3
In-Reply-To: <20020620055933.GA1308@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0206201546510.4390-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Jun 2002, Andrea Arcangeli wrote:

> This fixes the o1 sched bits (so in turn breaks alpha :-/ any patch
> fixing alpha is welcome of course).  Also not yet sure if DaveM is ok
> with the removal of prepare_to_switch, his last comment on that is
> negative as far I could see. [...]

his last comment was that it's ok. All prepare_to_switch() functionality
can be put into prepare_arch_switch() just fine.

The -A4 backport sched.c should pretty much work on Alpha out of box, as
long as you have the 3-argument switch_to() that the vanilla kernel has,
and use the same _arch_ defines that x86 does - but add the
prepare_to_switch code to prepare_arch_switch().

> Only in 2.4.19pre10aa3: 21_o1-A4-aa-1
> 
> 	Some more incremental O1 cleanup on top of Ingo's changes (note:
> 	not all of them, in particular rejected the sched_yield changes
> 	that wrongly waits the timeslice to expire before giving the
> 	cpu to the next task in the runqueue). [...]

the gradual decreasing of timeslices is intentional, although in the
simple cases it might not make much of a difference (besides yielding more
before giving up). But if there is some sort of bouncing around between
yielding tasks that happen to be at the lowest priority level already then
we should not be too abrupt about punishing tasks by taking away all their
timeslices.

the 'extra' yielding done does not matter much, since an expired task will
likely wait alot of time (many milliseconds) before running again - so the
extra yielding is amortized greatly.

>                                      [...] Also the rq_lock rejected,
>       see the comment on the patch, -preempt is a no-way for 2.4, so
> 	we can a bit more efficient thanks to it.

you mean this_rq_lock()? Note that your 21_o1-A4-aa-1 patch does not do
what is listed, those changes appear to be included in
20_o1-sched-updates-A4-1.

wrt. this_rq_lock(), the only difference should be the ordering of cli vs.  
the assignment of rq - ie. there should be no efficiency difference.

	Ingo

