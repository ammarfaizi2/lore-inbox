Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030361AbWGHUlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030361AbWGHUlR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 16:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030363AbWGHUlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 16:41:17 -0400
Received: from relay01.pair.com ([209.68.5.15]:29195 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S1030361AbWGHUlR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 16:41:17 -0400
X-pair-Authenticated: 71.197.50.189
From: Chase Venters <chase.venters@clientec.com>
Organization: Clientec, Inc.
To: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: [patch] spinlocks: remove 'volatile'
Date: Sat, 8 Jul 2006 15:40:44 -0500
User-Agent: KMail/1.9.3
Cc: "linux-os \\\\(Dick Johnson\\\\)" <linux-os@analogic.com>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       Linux kernel <linux-kernel@vger.kernel.org>, arjan@infradead.org
References: <20060705114630.GA3134@elte.hu> <200607080841.38235.chase.venters@clientec.com> <m38xn3j1um.fsf@defiant.localdomain>
In-Reply-To: <m38xn3j1um.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607081541.07449.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 08 July 2006 15:08, Krzysztof Halasa wrote:
> Chase Venters <chase.venters@clientec.com> writes:
> > You're mincing my words. The reason "memory" is on the clobber list is
> > because
> > a lock is supposed to synchronize all memory accesses up to that point.
> > It's a fence / a barrier, because if the compiler re-orders your
> > loads/stores across the lock, you're in trouble. That's exactly what I
> > was pointing out.
>
> Sure, but a barrier alone isn't enough. You have to use assembler and
> it's beyond scope of C volatile.

Right, which is why volatile is wrong. Which is what we've all been saying. 
Constantly.

You need the barrier for both the CPU and the compiler. The CPU barrier comes 
from an instruction like '*fence' on x86 (or a locked bus op), while the 
compiler barrier comes from the memory clobber. Because the spinlocks already 
_must_ have both of these (including the other constraints in the inline 
asm), 'volatile' on the spinlock ctr is useless.

> > A volatile cast lets you prevent the compiler from always treating the
> > variable as volatile.
>
> Yes, if that's what you really want.
>
> >> If the "volatile" is used the wrong way (which is probably true for most
> >> cases), then volatile cast and barrier() will be wrong as well. You need
> >> locks or atomic access, meaningful on hardware level.
> >
> > No. Linus already described what some example invalid uses of "volatile"
> > are.
> > One example is the very one this whole thread is about - using 'volatile'
> > on the declaration of the spinlock counter. That usage is _wrong_, and
> > barrier()
> > would not be.
>
> That's a special case, because you want to invalidate all variables,
> but you still need locking. I.e., barrier() alone doesn't buy you
> anything WRT to hardware.

Special case? It's the topic of this thread.

As for barrier() being a compiler boundary versus a hardware boundary, I don't 
think anyone is disputing that. Which is why I speak of both compiler and 
hardware barriers:

> > Volatile originally existed to tell the compiler a variable could change
> > at will. Because of reordering, it's almost never sufficient with our
> > modern compilers and CPUs. That's precisely where barrier() (and/or its
> > hardware equivalents) help in places where 'volatile' is wrong.
>
> How does barrier() help here? Some example, maybe?
> What do you consider a barrier() hardware equivalent?
> Don't you think you're mixing compiler optimization and operation of
> the hardware?

Documentation/memory-barriers.txt covers barriers pretty thoroughly. barrier() 
is a Linux macro that is part of a suite of macros to implement various kinds 
of barriers in various situations. Hardware equivalent? How about mb()?

> > Your statement is
> > additionally wrong because one use-case of memory barriers is to safely
> > write
> > lock-free code.
>
> You can't safely write lock-free code in C, if you have to deal
> with hardware or SMP. C don't know about hardware.

Documentation/memory-barriers.txt lists situations like the ones I describe. 
It's not pure C -- you end up having to insert a hardware barrier too, but 
Linux makes many macros available to do so. (Of course, these macros are 
using inline asm). Notice I specifically mention hardware barriers in the 
paragraph above. When I say one use-case of memory barriers is to safely 
write lock-free code, I'm talking about the use of both hardware and compiler 
barriers (indeed, _both_ types of barriers are documented in 
Documentation/memory-barriers.txt, along with examples of lock-free C code 
supported by Linux barrier macros).

Thanks,
Chase
