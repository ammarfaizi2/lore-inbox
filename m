Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129580AbRBPRgf>; Fri, 16 Feb 2001 12:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130431AbRBPRgZ>; Fri, 16 Feb 2001 12:36:25 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:22542 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129580AbRBPRgU>; Fri, 16 Feb 2001 12:36:20 -0500
Date: Fri, 16 Feb 2001 09:36:07 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org,
        bcrl@redhat.com
Subject: Re: x86 ptep_get_and_clear question
In-Reply-To: <20010216182020.B4494@pcep-jamie.cern.ch>
Message-ID: <Pine.LNX.4.10.10102160931580.14020-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 16 Feb 2001, Jamie Lokier wrote:

> Manfred Spraul wrote:
> > Ok, Is there one case were your pragmatic solutions is vastly faster?
> 
> > * mprotect: No. The difference is at most one additional locked
> > instruction for each pte.
> 
> Oh, what instruction is that?

The "set_pte()" thing could easily be changed into

	lock ; orl pte,(ptepointer)

which actually should work as-is. We do not allow "set_pte()" on anything
but "pte_none()" entries anyway, so in the trivial case the "orl" is
exactly equivalent to a "movl". And in the (so far theoretical) case where
another CPU might have set the dirty bit, the locked "or" will again do
the right thing, and preserve it.

So that would basically be a one-liner that removes the set_pte() race for
mprotect() (and the vmscan.c case of re-establishing the pte, but as
vmscan needs to do something more anyway that part is probably not
interesting).

> > * munmap(anon): No. We must handle delayed accessed anyway (don't call
> > free_pages_ok() until flush_tlb_ipi returned). The difference is that we
> > might have to perform a second pass to clear any spurious 0x40 bits.
> 
> That second pass is what I had in mind.
> 
> > * munmap(file): No. Second pass required for correct msync behaviour.
> 
> It is?

Not now it isn't. We just do a msync() + fsync() for msync(MS_SYNC). Which
is admittedly not optimal, but it works.

		Linus

