Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261658AbVCVStt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261658AbVCVStt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 13:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbVCVStt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 13:49:49 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:38204 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261670AbVCVStQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 13:49:16 -0500
Date: Tue, 22 Mar 2005 18:48:23 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "Luck, Tony" <tony.luck@intel.com>
cc: "David S. Miller" <davem@davemloft.net>,
       Nick Piggin <nickpiggin@yahoo.com.au>, akpm@osdl.org,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: RE: [PATCH 1/5] freepgt: free_pgtables use vma list
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F0321137B@scsmsx401.amr.corp.intel.com>
Message-ID: <Pine.LNX.4.61.0503221830560.9034@goblin.wat.veritas.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F0321137B@scsmsx401.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2005, Luck, Tony wrote:

> >> For example, you may have a single page (start,end) address range
> >> to free, but if this is enclosed by a large enough (floor,ceiling)
> >> then it may free an entire pgd entry.
> >> 
> >> I assume the intention of the API would be to provide the full
> >> pgd width in that case?
> >
> >Yes, that is what should happen if the full PGD entry is liberated.
> >
> >Any time page table chunks are liberated, they have to be included
> >in the range passed to the flush_tlb_pgtables() call.

This now makes it crystal clear to me that Nick's suspicion was right,
my start,end to flush_tlb_pgtables is too narrow.  I'll take another
look there and correct it.

> So should this part of Hugh's code:
> 
>                         /*
>                          * Optimization: gather nearby vmas into one call down
>                          */
>                         while (next && next->vm_start <= vma->vm_end + PMD_SIZE
>                         && !is_hugepage_only_range(next->vm_start, HPAGE_SIZE)){
>                                 vma = next;
>                                 next = vma->vm_next;
>                         }
>                         free_pgd_range(tlb, addr, vma->vm_end,
>                                 floor, next? next->vm_start: ceiling);
>  
> be changed to use pgd_addr_end() to gather up all the vma that
> are mapped by a single pgd instead of just spanning out the next
> PMD_SIZE?

Oh, I don't think so.  I suppose it could be done at this level,
but then the lower levels would go back to searching through lots
of unnecessary cachelines to find the significant entries, and
we might as well throw out the whole set of patches (which will
soon happen anyway if we can't find why they're not working!).

No, we don't have to pass pgd granularity to flush_tlb_pgtables,
we just have to try a bit harder to supply the right span to it,
whatever that is.  It might be in pmd granularity, it might be in
pud granularity (if we freed some at that level), it might be in
pgd granularity (if we freed some at that level).

> On ia64 we can have a vma big enough to require more than one pgd, but

Yes, no problem.

> in the case that we span, we won't cross the problematic pgd boundaries
> where the holes in the address space are lurking.

Yes, it wouldn't be a hole if a vma was allowed into it.

I do assume that on all architectures, the peculiar regions (might be
holes, might be huge-only regions) are separated from the ordinary
ones by pgd boundaries.

Hugh
