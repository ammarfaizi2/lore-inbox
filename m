Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129817AbRBOUcK>; Thu, 15 Feb 2001 15:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130025AbRBOUcA>; Thu, 15 Feb 2001 15:32:00 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:1546 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130023AbRBOUbm>; Thu, 15 Feb 2001 15:31:42 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: x86 ptep_get_and_clear question
Date: 15 Feb 2001 12:31:15 -0800
Organization: Transmeta Corporation
Message-ID: <96heaj$bvs$1@penguin.transmeta.com>
In-Reply-To: <3A8C254F.17334682@colorfullife.com> <200102151905.LAA62688@google.engr.sgi.com> <20010215201945.A2505@pcep-jamie.cern.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010215201945.A2505@pcep-jamie.cern.ch>,
Jamie Lokier  <lk@tantalophile.demon.co.uk> wrote:
>> > << lock;
>> > read pte
>> > if (!present(pte))
>> > 	do_page_fault();
>> > pte |= dirty
>> > write pte.
>> > >> end lock;
>> 
>> No, it is a little more complicated. You also have to include in the
>> tlb state into this algorithm. Since that is what we are talking about.
>> Specifically, what does the processor do when it has a tlb entry allowing
>> RW, the processor has only done reads using the translation, and the 
>> in-memory pte is clear?
>
>Yes (no to the no): Manfred's pseudo-code is exactly the question you're
>asking.  Because when the TLB entry is non-dirty and you do a write, we
>_know_ the processor will do a locked memory cycle to update the dirty
>bit.  A locked memory cycle implies read-modify-write, not "write TLB
>entry + dirty" (which would be a plain write) or anything like that.
>
>Given you know it's a locked cycle, the only sensible design from Intel
>is going to be one of Manfred's scenarios.

Not necessarily, and this is NOT guaranteed by the docs I've seen.

It _could_ be that the TLB data actually also contains the pointer to
the place where it was fetched, and a "mark dirty" becomes

	read *ptr locked
	val |= D
	write *ptr unlock

Now, I will agree that I suspect most x86 _implementations_ will not do
this. TLB's are too timing-critical, and nobody tends to want to make
them bigger than necessary - so saving off the source address is
unlikely. Also, setting the D bit is not a very common operation, so
it's easy enough to say that an internal D-bit-fault will just cause a
TLB re-load, where the TLB re-load just sets the A and D bits as it
fetches the entry (and then page fault handling is an automatic result
of the reload).

However, the _implementation_ detail is not, as far as I can tell,
explicitly defined by the architecture.  And in anothe rpost I quote a
book by the designers of the original 80386 that implies strongly that
the "re-walk the page tables on D miss" assumption is not what they
_meant_ for the architecture design, even if they probably happened to
implement it that way. 

>An interesting thought experiment though is this:
>
><< lock;
>read pte
>pte |= dirty
>write pte
>>> end lock;
>if (!present(pte))
>	do_page_fault();
>
>It would have a mighty odd effect wouldn't it?

Why do you insist on the !present() check at all? It's not implied by
the architecture - a correctly functioning OS is not supposed to ever
be able to cause it according to specs..

I tink Kanoj is right to be worried. I _do_ believe that the current
Linux code works on "all current hardware". But I think Kanoj has a
valid point in that it's not guaranteed to work in the future.

That said, I think Intel tends to be fairly pragmatic in their design
(that's the nice way of saying that Intel CPU's tend to dismiss the
notion of "beautiful architecture" completely over the notion of "let's
make it work").  And I would be extremely surprised indeed if especially
MS Windows didn't do some really bad things with the TLB.  In fact, I
think I can say from personal experience that I pretty much _know_
windows has big bugs in TLB invalidation.

And because of that, it may be that nobody can ever create a
x86-compatible CPU that does anything but "re-walk the TLB tables on
_anything_ fishy going on with the TLB".

(Basically, it seems to be pretty much a fact of life that the x86
architecture will NOT raise a page protection fault directly from the
TLB content - it will re-walk the page tables before it actually raises
the fault, and only the act of walking the page tables and finding that
it really _should_ fault will raise an x86-level fault.  It all boils
down to "never trust the TLB more than you absolutely have to"). 

		Linus
