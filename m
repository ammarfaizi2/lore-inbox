Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314602AbSFTOjX>; Thu, 20 Jun 2002 10:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314634AbSFTOjX>; Thu, 20 Jun 2002 10:39:23 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:8256 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S314602AbSFTOjV>; Thu, 20 Jun 2002 10:39:21 -0400
Date: Thu, 20 Jun 2002 16:40:33 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre10aa3
Message-ID: <20020620144033.GL10718@dualathlon.random>
References: <20020620055933.GA1308@dualathlon.random> <Pine.LNX.4.44.0206201546510.4390-100000@e2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0206201546510.4390-100000@e2>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2002 at 04:05:54PM +0200, Ingo Molnar wrote:
> 
> On Thu, 20 Jun 2002, Andrea Arcangeli wrote:
> 
> > This fixes the o1 sched bits (so in turn breaks alpha :-/ any patch
> > fixing alpha is welcome of course).  Also not yet sure if DaveM is ok
> > with the removal of prepare_to_switch, his last comment on that is
> > negative as far I could see. [...]
> 
> his last comment was that it's ok. All prepare_to_switch() functionality
> can be put into prepare_arch_switch() just fine.
> 
> The -A4 backport sched.c should pretty much work on Alpha out of box, as

I didn't meant it was difficult to fix, just one more breakage to fix
that is unfixed at the moment so alpha won't compile, just in case
somebody wondered why they couldn't compile on alpha.

> long as you have the 3-argument switch_to() that the vanilla kernel has,
> and use the same _arch_ defines that x86 does - but add the
> prepare_to_switch code to prepare_arch_switch().
> 
> > Only in 2.4.19pre10aa3: 21_o1-A4-aa-1
> > 
> > 	Some more incremental O1 cleanup on top of Ingo's changes (note:
> > 	not all of them, in particular rejected the sched_yield changes
> > 	that wrongly waits the timeslice to expire before giving the
> > 	cpu to the next task in the runqueue). [...]
> 
> the gradual decreasing of timeslices is intentional, although in the
> simple cases it might not make much of a difference (besides yielding more
> before giving up). But if there is some sort of bouncing around between
> yielding tasks that happen to be at the lowest priority level already then
> we should not be too abrupt about punishing tasks by taking away all their
> timeslices.
> 
> the 'extra' yielding done does not matter much, since an expired task will
> likely wait alot of time (many milliseconds) before running again - so the
> extra yielding is amortized greatly.

I will think more about this, however the "besides yielding more
before giving up" is the part I didn't like of it, it should giveup the
cpu immediatly IMHO, no matter if there's only total bouncing, however
while giving up the cpu it also must not lose its timeslice, but that
looked ok before you apparently decreased it in -A4. again, I may be
wrong, need more time to check those bits.

> >                                      [...] Also the rq_lock rejected,
> >       see the comment on the patch, -preempt is a no-way for 2.4, so
> > 	we can a bit more efficient thanks to it.
> 
> you mean this_rq_lock()? Note that your 21_o1-A4-aa-1 patch does not do
> what is listed, those changes appear to be included in
> 20_o1-sched-updates-A4-1.

correct, this part of the comment really applied to the
20_o1-sched-updates-A4-1, not to 21_o1-A4-aa-1, I wrote it there just
because it was still an o1 topic and I forgot to mention it in the
previous point (should had gone up a few lines before writing it).

> wrt. this_rq_lock(), the only difference should be the ordering of cli vs.  
> the assignment of rq - ie. there should be no efficiency difference.

well the microoptimization is to reduce of a few cycles the cli
protected sections, I just didn't see the point in growing them.

however I noticed an smp bug in my changes, I was too aggressive
removing the loop in task_rq_lock, not that such bug ever triggered yet
but the rq may change under us while we take the lock if the task is
getting migrated to another cpu.

You may also want to review the irq-balance changes I made while
integrating it.

thanks,

Andrea
