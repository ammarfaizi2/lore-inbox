Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316446AbSETX44>; Mon, 20 May 2002 19:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316447AbSETX4z>; Mon, 20 May 2002 19:56:55 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:49558 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S316446AbSETX4y>;
	Mon, 20 May 2002 19:56:54 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15593.36080.660343.246677@argo.ozlabs.ibm.com>
Date: Tue, 21 May 2002 09:55:28 +1000 (EST)
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.16
In-Reply-To: <Pine.LNX.4.44.0205200904461.23874-100000@home.transmeta.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> Hmm.. The PPC <asm/tlb.h> seems to be largely a simplified version of
> the asm-generic one, with no support for the UP optimization, for example.
> 
> And that UP optimization should be perfectly correct even on PPC, so you
> apparently lost something in the translation.

The UP optimization would be slower on "classic" PPCs because you end
up doing a flush_tlb_mm rather than flushing the ranges of addresses
where there are actually PTEs present.

By "classic" PPCs I mean those that use a hashed page table, as
distinct from the embedded PPCs that have software-loaded TLBs.
Certainly for the embedded PPCs the UP optimization is useful and
desirable.  More ifdefs... :(

Anyway, on classic PPCs, the cost of TLB flushes goes up with the
amount of address space being flushed, and flush_tlb_mm is essentially
a flush of the whole space from 0 to TASK_SIZE.  As an optimization,
I currently have flush_tlb_mm look at the list of vma's and flush the
address range for each vma.  That works because flush_tlb_mm currently
only gets called from dup_mmap() and the list of vma's is valid in
that case.  If we were calling flush_tlb_mm from tlb_flush_mmu, we
could not use that optimization (since all the vma's have been removed
from the mm->mmap list at that point) so we would have to flush the
entire 0 .. TASK_SIZE range.

There is a further optimization that we do that we would not be able
to use if flush_tlb_mm were called from tlb_flush_mmu.  We have a bit
in each PTE, the _PAGE_HASHPTE bit, that tells us if a hardware PTE
for that virtual address has been put into the hash table.  (This bit
is present even when the PTE is a swap entry, and set_pte et al. don't
modify this bit.)  Then, when we are flushing a range of addresses, we
look at the linux PTE for each page and only do the hash table search
if the bit is set.  However, by the time tlb_flush_mmu is called, the
page tables have been freed, so we would have to do the hash table
search for every page from 0 to TASK_SIZE.  (This is why I call
tlb_flush_mmu from tlb_end_vma rather than tlb_finish_mmu.)

Therefore I concluded that the UP optimization was actually a
pessimization for classic PPC.

The fact that flushes cost in proportion to the size of the range
being flushed is the reason behind the code that flushes and starts a
new range if address - tlb->end > 32 * PAGE_SIZE.  The 32 is a number
that could use some tuning; we get some advantage from batching up the
flushes but that advantage will be lost if we have to look through
large ranges of addresses where there were no valid PTEs.

> I'd actually rather try to share more of the code, if possible.

I'll see what I can do along those lines...

Paul.
