Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129080AbRBOUR3>; Thu, 15 Feb 2001 15:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129078AbRBOURT>; Thu, 15 Feb 2001 15:17:19 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:28169 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129066AbRBOURE>; Thu, 15 Feb 2001 15:17:04 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: x86 ptep_get_and_clear question
Date: 15 Feb 2001 12:16:36 -0800
Organization: Transmeta Corporation
Message-ID: <96hdf4$bul$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.30.0102151402460.15843-100000@today.toronto.redhat.com> <200102151919.LAA74131@google.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200102151919.LAA74131@google.engr.sgi.com>,
Kanoj Sarcar  <kanoj@google.engr.sgi.com> wrote:
>> 
>> Will you please go off and prove that this "problem" exists on some x86
>> processor before continuing this rant?  None of the PII, PIII, Athlon,
>
>And will you please stop behaving like this is not an issue? 

This is documented in at least

	Programming the 80386
	John Crawford & Patrick Gelsinger

which is still the best book I've ever seen on the x86 architecture. See
page 477, "Memory management, Protection, and Tasks", under "Multiple-
Processor Considerations". And I quote:

	"Before changing a page table entry that may be used on another
	procesor <sic>, software should use a locked AND instruction to
	clear the P bit to 0 in an indivisible operation.  Then the
	entry can be changed as required, and made available by later
	setting the P bit to 1.

	At some point in the modification of a page table entry, all
	processors in the system that may have had the entry cached must
	be notified (usually with an interrupt) to flush their page
	translation caches to remove any old copies of the entry.  Until
	these old copies are flushed, the processors can continue to
	access the old page, and may also set the D bit in the entry
	being modified.  If this may case the modification of the entry
	to fail, the paging caches should be flushed after the entry is
	marked not present, but before the entry is otherwise modified".

Note the last sentence - that's the one that really matters to this
discussion. 

And it does imply that the read-and-clear thing is not the right thing
to do and is not guaranteed to fix the race (even if I personally
suspect that all current x86 implementations will just re-walk the page
tables and set the D bit the same way they set the A bit, and basically
making the usage an "argument" to the page table walker logic). 

However, I suspect that we could extend it to just re-read the entry
(which _should_ be zero, but could have the D bit set) after having
invalidated the TLB on the other CPU's.  But Gelsinger suggests just
clearing the P bit - which is easily enough done, as the following
modification would be needed anyway in mm/vmscan.c:

	pte = ptep_get_and_clear(page_table);
	flush_tlb_page(vma, address);
+	pte = ptep_update_after_flush(page_table, pte);

where "ptep_update_after_flush()" would be a no-op on UP, and on SMP it
would just or in the D bit (which should be practically always zero)
from the page table entry into the pte.

Just clearing the P bit actuall ymakes "out_unlock_restore:" simpler: it
becomes a simple

	lock ; orl $1, page_table

which makes the worry about overwriting the D bit at that point go away
(although, considering where we invalidate the TLB's and that we should
now have had the correct D bits anyway, the non-locked simple store
should also work reliably).

The case of munmap() is more worrisome, and has much worse performance
issues.  Ben's experimental shootdown patch would appear to not be good
enough.  The only simple solution is the "gather" operation that I've
already suggested because of it's obvious correctness and simplicity. 

A potential alternative would be to walk the page tables twice, and make
the page table zapping be a two-phase process.  We'd only need to do
this when the "mm->cpu_vm_mask" bits implied that other CPU's might have
TLB entries, so we could avoid the double work for the normal case. 

HOWEVER, this is also the only case where a CPU "gather" operation would
be necessary, so the thing basically boils down to the question of
whether "gather" or "double walk" is the more expensive operation. 

The "gather" operation could possibly be improved to make the other
CPU's do useful work while being shot down (ie schedule away to another
mm), but that has it's own pitfalls too.

>OS clears present bit, processors can keep using their TLBs and access 
>the page, no problems at all. That is why after clearing the present bit, 
>the processor must flush all tlbs before it can assume no one is using
>the page. Hardware updated access bit could also be a problem, but an
>error there does not destroy data, it just leads the os to choosing the
>wrong page to evict during memory pressure.

The bible (see above) explicitly mentions only the D bit here - the A
bit is set at page table walk time, and is explicitly NOT set if the P
bit is clear at walk time, so there is no apparent race on that.

But as the A bit isn't very important anyway, the apparent lack of a
race is not all that interesting. 

		Linus
