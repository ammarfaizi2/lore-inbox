Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRBOV05>; Thu, 15 Feb 2001 16:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129447AbRBOV0s>; Thu, 15 Feb 2001 16:26:48 -0500
Received: from colorfullife.com ([216.156.138.34]:30989 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129183AbRBOV0b>;
	Thu, 15 Feb 2001 16:26:31 -0500
Message-ID: <3A8C499A.E0370F63@colorfullife.com>
Date: Thu, 15 Feb 2001 22:26:50 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1-ac13 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: x86 ptep_get_and_clear question
In-Reply-To: <3A8C254F.17334682@colorfullife.com> <200102151905.LAA62688@google.engr.sgi.com> <20010215201945.A2505@pcep-jamie.cern.ch> <96heaj$bvs$1@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> In article <20010215201945.A2505@pcep-jamie.cern.ch>,
> Jamie Lokier  <lk@tantalophile.demon.co.uk> wrote:
> >> > << lock;
> >> > read pte
> >> > if (!present(pte))
> >> >    do_page_fault();
> >> > pte |= dirty
> >> > write pte.
> >> > >> end lock;
> >>
> >> No, it is a little more complicated. You also have to include in the
> >> tlb state into this algorithm. Since that is what we are talking about.
> >> Specifically, what does the processor do when it has a tlb entry allowing
> >> RW, the processor has only done reads using the translation, and the
> >> in-memory pte is clear?
> >
> >Yes (no to the no): Manfred's pseudo-code is exactly the question you're
> >asking.  Because when the TLB entry is non-dirty and you do a write, we
> >_know_ the processor will do a locked memory cycle to update the dirty
> >bit.  A locked memory cycle implies read-modify-write, not "write TLB
> >entry + dirty" (which would be a plain write) or anything like that.
> >
> >Given you know it's a locked cycle, the only sensible design from Intel
> >is going to be one of Manfred's scenarios.
> 
> Not necessarily, and this is NOT guaranteed by the docs I've seen.
> 
> It _could_ be that the TLB data actually also contains the pointer to
> the place where it was fetched, and a "mark dirty" becomes
> 
>         read *ptr locked
>         val |= D
>         write *ptr unlock
>

Jamie wrote "one of my scenarios", that's the other option ;-)

> Now, I will agree that I suspect most x86 _implementations_ will not do
> this. TLB's are too timing-critical, and nobody tends to want to make
> them bigger than necessary - so saving off the source address is
> unlikely. Also, setting the D bit is not a very common operation, so
> it's easy enough to say that an internal D-bit-fault will just cause a
> TLB re-load, where the TLB re-load just sets the A and D bits as it
> fetches the entry (and then page fault handling is an automatic result
> of the reload).
>

But then the cpu would support setting the D bit in the page directory,
but it doesn't.

Probably Kanoj is right, the current code is not guaranteed by the
specs.

But if we change the interface, could we think about the poor s390
developers?

s390 only has a "clear the present bit in the pte and flush the tlb"
instruction.


>From your other post:
>        pte = ptep_get_and_clear(page_table);
>        flush_tlb_page(vma, address);
>+       pte = ptep_update_after_flush(page_table, pte);

What about one arch specific

	pte = ptep_get_and_invalidate(vma, address, page_table);


On i386 SMP it would

{
	pte = *page_table_entry;
	if(!present(pte))
		return pte;
	lock; andl 0xfffffffe, *page_table_entry;
	flush_tlb_page();
	return *page_table_entry | 1;
}

> 
> The "gather" operation could possibly be improved to make the other
> CPU's do useful work while being shot down (ie schedule away to another
> mm), but that has it's own pitfalls too.
>
IMHO scheduling away is the best long term solution.
Perhaps try to schedule away, just to improve the probability that
mm->cpu_vm_mask is clear.

I just benchmarked a single flush_tlb_page().

Pentium II 350: ~ 2000 cpu ticks.
Pentium III 850: ~ 3000 cpu ticks.

--
	Manfred
