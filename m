Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317010AbSEWVQY>; Thu, 23 May 2002 17:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317011AbSEWVQX>; Thu, 23 May 2002 17:16:23 -0400
Received: from [195.223.140.120] ([195.223.140.120]:54802 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S317010AbSEWVQW>; Thu, 23 May 2002 17:16:22 -0400
Date: Thu, 23 May 2002 23:15:37 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Q: backport of the free_pgtables tlb fixes to 2.4
Message-ID: <20020523211537.GA21164@dualathlon.random>
In-Reply-To: <20020523195757.GW21164@dualathlon.random> <Pine.LNX.4.33.0205231300530.4338-100000@penguin.transmeta.com> <20020523204101.GY21164@dualathlon.random> <3CED48C8.80406@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2002 at 09:53:44PM +0200, Martin Dalecki wrote:
> Uz.ytkownik Andrea Arcangeli napisa?:
> 
> >What I don't understand is how the BTB can invoke random userspace tlb
> >fills when we are running do_munmap, there's no point at all in doing
> >that. If the cpu see a read of an user address after invalidate_tlb,
> >the tlb must not be started because it's before an invalidate_tlb.
> >
> >And if it's true not even irq are barriers for the tlb fills invoked by
> >this p4-BTB thing, so if leave_mm is really necessary, then 2.5 is as
> >well wrong in UP, because the pagetable can be scribbled by irqs in a UP
> >machine, and so the fastmode must go away even in 1 cpu systems.
> 
> I for one would be really really surprised if the execution of an
> interrupt isn't treating the BTB specially. If one reads

me too of course. If an irq isn't making UP-transparent the speculative
actions of the BTB, then 2.5 is still buggy in allowing the fast mode in
UP machines (beause the irq can allocate the pagetable and scribble over
it so then the tlb will be filled with global garbage). To make things
more clear this is what will happen right now in 2.5 if the irq isn't
serializing the BTB speculative tlb fills:

        CPU1

        munmap
        .. speculation starts ..
        .. TLB reads pmd entry, so it now knows the phys address of the pte ..

        clear pmd entry
        free pte
	(doesn't matter if we clear the pmd entry or if we free the pte first)

	irq fired, BTB speculative actions aren't stopped they runs speculative in parallel to the irq
        alloc page - get old pte
        scribble on pte

        .. TLB reads the contents of the pte at the phys address now invalid ..
        .. tlb fill ends and we filled the tlb with random pte contents marked global ...

If instead the irq is serializing the BTB actions as expected (the
invariant is that an UP machine will never see any speculative action
internally, speculations is a problem only with SMP on shared memory
or while talking with hardware devices outside the local cpu), then it
means the above cannot happen, so 2.5 isn't buggy in allowing the
fastmode with 1 cpu systems, but then it also means 2.5 is overkill in
the leave_mm hack and so we can drop it.

Andrea
