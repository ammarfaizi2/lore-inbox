Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S135258AbRDXKZt>; Tue, 24 Apr 2001 06:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S135259AbRDXKZj>; Tue, 24 Apr 2001 06:25:39 -0400
Received: from t2.redhat.com ([199.183.24.243]:17647 "EHLO warthog.cambridge.redhat.com") by vger.kernel.org with ESMTP id <S135258AbRDXKZd>; Tue, 24 Apr 2001 06:25:33 -0400
To: Andrea Arcangeli <andrea@suse.de>
To: David Howells <dhowells@cambridge.redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: rwsem benchmark [was Re: [PATCH] rw_semaphores, optimisations try #3] 
In-Reply-To: Your message of "Tue, 24 Apr 2001 11:49:53 +0200." <20010424114953.E7913@athlon.random> 
Date: Tue, 24 Apr 2001 11:25:23 +0100
Message-ID: <6215.988107923@warthog.cambridge.redhat.com>
From: David Howells <dhowells@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'd love to hear this sequence. Certainly regression testing never generated
> this sequence yet but yes that doesn't mean anything. Note that your slow
> path is very different than mine.

One of my testcases fell over on it...

> I don't feel the need of any xchg to enforce additional serialization.

I don't use XCHG anywhere... do you mean CMPXCHG?

> yours plays with cmpxchg in a way that I still cannot understand

It tries not to let the "active count" transition 1->0 happen if it can avoid
it (ie: it would rather wake someone up and not decrement the count). It also
only calls __rwsem_do_wake() if the caller manages to transition the active
count 0->1.

This avoids another subtle bug that I think I have a sequence written down for
too.

> Infact eax will be changed because it will be clobbered by the slow path, so
> I have to. Infact you are not using the +a like I do there and you don't
> save EAX explicitly on the stack I think that's "your" bug.

Not so... my down-failed slowpath functions return sem in EAX.

> Again it's not a performance issue, the "+a" (sem) is a correctness issue
> because the slow path will clobber it.

There must be a performance issue too, otherwise our read up/down fastpaths
are the same. Which clearly they're not.

> About the reason I'm faster than you in the down_write fast path is that I
> can do the subl instead of the cmpxchg, you say this is my big fault, I
> think my algorithm allows me to do that, but maybe I'm wrong.

I used to do that.

> Unfortunatly I "have" to put the pushl there because I don't want to save
> %ecx in the fast path (if I declare ecx clobbered it's even worse no?).

It benchmarked faster without it for me. I suspect this will be different on
different CPUs anyway.

I'm going to have to have a play with Intel's VTUNE program and see what it
says.

> I said on 64bit archs. Of course on x86-64 there is xaddq and the rex
> registers.

But the instructions you've specified aren't 64-bit.

> It isn't mandatory, if you don't want the xchgadd infrastructure then you
> don't set even CONFIG_RWSEM_XCHGADD, no?

My point is that mine isn't mandatory either... You just don't set the XADD
config option.

David
