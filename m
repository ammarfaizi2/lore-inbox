Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316517AbSEUFKl>; Tue, 21 May 2002 01:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316514AbSEUFKk>; Tue, 21 May 2002 01:10:40 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8204 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316517AbSEUFKe>; Tue, 21 May 2002 01:10:34 -0400
Date: Mon, 20 May 2002 22:10:31 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Paul Mackerras <paulus@samba.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.16
In-Reply-To: <15592.61285.98743.781939@argo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.44.0205202143010.949-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 20 May 2002, Paul Mackerras wrote:
>
> This patch splits up the existing tlb_remove_page into
> tlb_remove_tlb_entry (for pages that are/were mapped into userspace)
> and tlb_remove_page, as you suggested.  It also adds the necessary
> stuff for PPC, which has its own include/asm-ppc/tlb.h now.  This
> works on at least one PPC machine. :)

Looking into this a bit more, I came to the conclusion that this cannot
actually work on ppc.

The start/end address optimization cannot work the way you intended them
to, because the "tlb_remove_page()" semantics _only_ call it for "real
pages". Thus anything that is unknown to the kernel VM (ie reserved or
outside the kernel mem_map[]) will never cause that interface to be
called, since those pages will not be free'd.

I solved this by splitting up the interface: the tlb_remove_page() thing
still exists and does the same old thing, but I added a _separate_
"tlb_remove_tlb_entry()" which on x86 is a no-op, and that gets called on
each present pte entry.

So the loop basically looks like

        tlb = tlb_gather_mmu(mm);
	for_each_vma() {
		tlb_start_vma(tlb, vma);
		for_each_pte() {
			tlb_remove_tlb_entry(tlb, pte, address);
			if (pte_valid_page()) {
				tlb->freed++;
				tlb_remove_page(tlb, page);
			}
		}
		tlb_end_vma(tlb, vma);
	}
	tlb_finish_mmu(tlb, start, end);

where the x86 defines tlb_start_vma/tlb_end_vma/tlb_remove_tlb_entry to be
no-ops, because on the x86 we always just do a full TLB flush when we fill
up the free buffer.

For other architectures, any of the following may be a good idea:

 - tlb_end_vma() looks at the type of the VMA, and flushes that type only
   (ie if the vma was not executable, you can avoid the ITLB flush)

 - tlb_remove_tlb_entry() can try to remove the entry proactively from MMU
   hash chains like on the PPC: it gets enough information to do so. In
   this case, the tlb_remove_page() thing might decide to only flush the
   on-chip TLB, since it knows that the off-chip TLB has already been
   cleared.

   (For this reason, tlb_finish_mmu() doesn't actually call the old
   "flush_tlb_mm()", but instead calls a "tlb_flush(tlb)", so that the
   architecture can know that it doesn't need to flush the whole mm)

 - For architectures that hide hints in the PTE ("this pte has been loaded
   for a iTLB access"), the tlb_remove_tlb_entry() routine might just or
   in that bit into a tlb "status" word, and then tlb_flush(tlb) might
   decide to only flush the DTLB if it never saw any TLB entries that had
   the iTLB bit set. This should work for ia64 or alpha.

I tried to make the interface fairly generic, so that people could easily
do any (or none, like on x86) of these optimizations with little or no
overhead.

It's there in 2.5.17..

		Linus

