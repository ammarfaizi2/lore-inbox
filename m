Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135528AbRDXKpt>; Tue, 24 Apr 2001 06:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135531AbRDXKpj>; Tue, 24 Apr 2001 06:45:39 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:28756 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S135528AbRDXKpc>; Tue, 24 Apr 2001 06:45:32 -0400
Date: Tue, 24 Apr 2001 12:44:50 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: David Howells <dhowells@warthog.cambridge.redhat.com>
Cc: David Howells <dhowells@cambridge.redhat.com>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: rwsem benchmark [was Re: [PATCH] rw_semaphores, optimisations try #3]
Message-ID: <20010424124450.C1682@athlon.random>
In-Reply-To: <20010424114953.E7913@athlon.random> <6215.988107923@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6215.988107923@warthog.cambridge.redhat.com>; from dhowells@warthog.cambridge.redhat.com on Tue, Apr 24, 2001 at 11:25:23AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2001 at 11:25:23AM +0100, David Howells wrote:
> > I'd love to hear this sequence. Certainly regression testing never generated
> > this sequence yet but yes that doesn't mean anything. Note that your slow
> > path is very different than mine.
> 
> One of my testcases fell over on it...

so you reproduced a deadlock with my patch applied, or you are saying
you discovered that case with one of you testcases?

I'm asking because I'm running regression testing on my patch for several hours
now and it didn't showed up anything wrong yet (however I'm mainly using my
rwsem program to better stress the rwsem in an interesting environment with
different timings as well, but your stress tests by default looks less
aggressive than my rwsem, infact the bug I found in your code was never
triggered by your testcases until I changed them).

> > I don't feel the need of any xchg to enforce additional serialization.
> 
> I don't use XCHG anywhere... do you mean CMPXCHG?

yes of course, you use rwsem_cmpxchgw that is unnecessary.

> 
> > yours plays with cmpxchg in a way that I still cannot understand
> 
> It tries not to let the "active count" transition 1->0 happen if it can avoid

I don't try to avoid it anytime. I let it to happen all the time it wants.
Immediatly as soon as it can happen.

> it (ie: it would rather wake someone up and not decrement the count). It also

I always retire first.

> only calls __rwsem_do_wake() if the caller manages to transition the active
> count 0->1.

I call rwsem_wake if while retiring the counter gone down to 0 so it's
time to wakeup somebody according to my rule, then I handle the additional
synchroniziation between 0->1 inside the rwsem_wake if it fails I break
the rwsem_wake in the middle while doing the usual retire check from 1 to 0.
That's why up_write is a no brainer for me as far I can see and that's probably
why I can provide a much faster up_write fast path as benchmark shows.

> > Infact eax will be changed because it will be clobbered by the slow path, so
> > I have to. Infact you are not using the +a like I do there and you don't
> > save EAX explicitly on the stack I think that's "your" bug.
> 
> Not so... my down-failed slowpath functions return sem in EAX.

Ah ok, I didn't had such idea, I will optimize that bit in my code now.

> > Again it's not a performance issue, the "+a" (sem) is a correctness issue
> > because the slow path will clobber it.
> 
> There must be a performance issue too, otherwise our read up/down fastpaths
> are the same. Which clearly they're not.

I guess I'm faster because I avoid the pipeline stall using "+m" (sem->count)
that is written as a constant, that was definitely intentional idea. For
me right now the "+a" (sem) is a correctness issue that is hurting me (probably
not in the benchmark), and I can optimize it the same way you did.

> > I said on 64bit archs. Of course on x86-64 there is xaddq and the rex
> > registers.
> 
> But the instructions you've specified aren't 64-bit.

And infact on 32bit arch I use 32bit regs xaddl and 2^16 max sleepers.

> > It isn't mandatory, if you don't want the xchgadd infrastructure then you
> > don't set even CONFIG_RWSEM_XCHGADD, no?
> 
> My point is that mine isn't mandatory either... You just don't set the XADD
> config option.

My point is that when you set XADD you still force duplication of the header
stuff into the the asm/*

Andrea
