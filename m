Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130834AbRBPSAb>; Fri, 16 Feb 2001 13:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130835AbRBPSAV>; Fri, 16 Feb 2001 13:00:21 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:24847 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130834AbRBPSAM>; Fri, 16 Feb 2001 13:00:12 -0500
Date: Fri, 16 Feb 2001 09:59:51 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: Jamie Lokier <lk@tantalophile.demon.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: x86 ptep_get_and_clear question
In-Reply-To: <3A8D4045.F8F27782@colorfullife.com>
Message-ID: <Pine.LNX.4.10.10102160953060.14020-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 16 Feb 2001, Manfred Spraul wrote:

> Jamie Lokier wrote:
> > 
> > Linus Torvalds wrote:
> > > So the only case that ends up being fairly heavy may be a case that is
> > > very uncommon in practice (only for unmapping shared mappings in
> > > threaded programs or the lazy TLB case).
> >
> The lazy tlb case is quite fast: lazy tlb thread never write to user
> space pages, we don't need to protect the dirty bits. And the first ipi
> clears mm->cpu_vm_mask, only one ipi.

This is NOT necessarily true in the generic case.

The lazy TLB thread itself may not write to the address space, but I can
in theory see a hardware implementation that delays writing out the dirty
bit from the TLB until it is invalidated. I agree that it is unlikely,
especially on an x86, but I think it's a case we should at least think
about for the generic kernel architecture.

Think of the TLB as a cache, and think of the dirty state as being either
write-through or write-back. Now, I will bet you that all current x86's
 (a) _do_ actually check the P bit when writing D (ie current Linux code
     is probably fine as-is, even if incorrect in theory)
and
  (b) the D bit is write-through.

But even so, I want people to at least consider the case of a write-back
TLB dirty bit, in which case the real state of the D bit might not be
known until a TLB flush has been done (even on a UP machine - which is why
I'm certain that no current x86 actually does this optimization).

(And because of (a), I don't think I'll necessarily fix this during 2.4.x
anyway unless it gets fixed as a result of the generic TLB shootdown issue
which has nothing at all to do with the D bit)

Don't get too hung up on implementation details when designing a good
architecture for this thing.

			Linus

