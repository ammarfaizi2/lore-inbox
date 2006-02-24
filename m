Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbWBXAMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWBXAMV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 19:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbWBXAMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 19:12:21 -0500
Received: from ozlabs.org ([203.10.76.45]:25832 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932159AbWBXAMU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 19:12:20 -0500
Date: Fri, 24 Feb 2006 11:11:46 +1100
From: "'David Gibson'" <david@gibson.dropbear.id.au>
To: Hugh Dickins <hugh@veritas.com>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: IA64 non-contiguous memory space bugs
Message-ID: <20060224001146.GC25101@localhost.localdomain>
Mail-Followup-To: 'David Gibson' <david@gibson.dropbear.id.au>,
	Hugh Dickins <hugh@veritas.com>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
References: <200602220132.k1M1Vxg09552@unix-os.sc.intel.com> <200602220151.k1M1pqg09761@unix-os.sc.intel.com> <20060222022558.GE23574@localhost.localdomain> <Pine.LNX.4.61.0602221546040.9885@goblin.wat.veritas.com> <20060222234949.GB25108@localhost.localdomain> <Pine.LNX.4.61.0602231956560.12069@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0602231956560.12069@goblin.wat.veritas.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2006 at 08:13:38PM +0000, Hugh Dickins wrote:
> On Thu, 23 Feb 2006, 'David Gibson' wrote:
> > 
> > Consider a HPAGE_SIZE hugepage VMA starting at 4GB, and a normal page
> > VMA starting at (4GB-PAGE_SIZE).  This situation is possible on
> > powerpc, and is_hugepage_only_range(4GB-PAGE_SIZE, HPAGE_SIZE) will
> > (and must) return true.  Therefore the free_pgtables() logic will call
> > hugetlb_free_pgd_range() across the normal page VMA.
> 
> Thanks for your patience, I eventually got it.  Although (amused to
> observe my own incomprehension) I couldn't actually understand your
> explanation at all, realized it myself overnight, read again what
> you'd written, and then found that you had explained it very well.
> 
> Yes, I was wrong to use HPAGE_SIZE in that way in free_pgtables,
> and it ought to go to the trouble of testing the real end-addr 
> (if we keep using is_hugepage_only_range there at all).  Though
> it's nothing urgent while your hugetlb_free_pgd_range happens to
> be the same as your free_pgd_range, right?  Is that changing soon?

Maybe.  At the moment ppc64 wastes substantial memory, particularly
with 64K base page size because we store 16 hugepage PTEs in a 64k
pagetable page.  I'd like to fix that by using a different pagetable
allocator for the hugepages, and that will require a different
hugetlb_free_pgd_range().

> May I plead the extenuating circumstance, that the powerpc
> is_hugepage_only_range means something quite different from the ia64?
> The ia64 one means "within a hugepage-only range" but the powerpc one
> means "overlaps a hugepage-only range"; I don't know which came first,
> and is_hugepage_only_range isn't very descriptive of either (though
> matches the ia64 case much better).

Well.. in fact on ia64 the two meanings are equivalent for
"reasonable" inputs (anything that's a valid user VM range at all).
In general the semantics need to be "overlaps" because any overlapping
range is unsuitable for a normalpage VMA, which is the real purpose of
this test.

The name "is_hugepage_only_range" is mine, I'm afraid, replacing an
even less descriptive name which I've now forgotten.  I can't think of
anything unequivocally clearer off the top of my head.  Well, that's
not ludicrously verbose anyway
(is_range_unsuitable_for_normal_vma_by_reason_of_hugepage_areas()?)

> (That is, I think from the "touch" naming, and from your description,
> that the powerpc one means "overlaps".  After a few minutes, I gave
> up trying to decipher exactly what LOW_ESID_MASK and HTLB_AREA_MASK
> end up doing, and take your superior knowledge on trust.)

You're correct, it's "overlap" semantics (now anyway, it wasn't at one
stage, and that was a bug).  It's also complicated on powerpc because
the hugepage exclusive range is not fixed - when you make a hugepage
mapping chunks of the address space (for this mm) are switched over to
be hugepage dedicated - granularity is at 256M chunks below 4GB and
1TB chunks above that, two bitmaps in the mm_context record which
"low" and "high" areas are set aside for hugepages.

> While is_hugepage_only_range means different things to different
> architectures, I guess it'd best be avoided in common code.  That use
> in get_unmapped_area: powerpc gets it right, but ia64 gets it wrong?
> But I didn't notice a change to that line (or the ia64 implementaton
> thereof) in your original patch.

It doesn't really mean different things - "touches a hugepage
exclusive area" is the correct semantic, the ia64 implementation
doesn't quite encode that, but is equivalent for valid address
ranges.  (though I wonder if that's another bug associated with by
task-region-max patch, without that patch invalid address ranges can
slip through, so maybe it's possible on ia64 to create a normalpage VM
with its start in the address space gap and its end in the hugepage
region, ouch).

> > I can see two ways of fixing this.  The quick, hacky fix is to use
> > is_vm_hugetlb_page(), and work around the problems by having
> > hugetlb_free_pgd_range() be identical to free_pgd_range() in most
> > cases.
> 
> I don't see that as hacky.  I did point out that is_vm_hugetlb_page
> will miss out on some coalescence, but that can't be a big deal for
> what are already huge areas (the optimization was intended for many
> tiny adjacent areas).

Very well, I'll look at coding up such a fix.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
