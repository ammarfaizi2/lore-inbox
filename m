Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751005AbWBVXug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbWBVXug (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 18:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751557AbWBVXug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 18:50:36 -0500
Received: from ozlabs.org ([203.10.76.45]:55192 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750980AbWBVXuf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 18:50:35 -0500
Date: Thu, 23 Feb 2006 10:49:49 +1100
From: "'David Gibson'" <david@gibson.dropbear.id.au>
To: Hugh Dickins <hugh@veritas.com>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: IA64 non-contiguous memory space bugs
Message-ID: <20060222234949.GB25108@localhost.localdomain>
Mail-Followup-To: 'David Gibson' <david@gibson.dropbear.id.au>,
	Hugh Dickins <hugh@veritas.com>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
References: <200602220132.k1M1Vxg09552@unix-os.sc.intel.com> <200602220151.k1M1pqg09761@unix-os.sc.intel.com> <20060222022558.GE23574@localhost.localdomain> <Pine.LNX.4.61.0602221546040.9885@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0602221546040.9885@goblin.wat.veritas.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 04:35:34PM +0000, Hugh Dickins wrote:
> On Wed, 22 Feb 2006, 'David Gibson' wrote:
> > On Tue, Feb 21, 2006 at 05:51:52PM -0800, Chen, Kenneth W wrote:
> > > 
> > > free_pgtables() has partial crap that the check of is_hugepage_only_range()
> > > should be done on the entire vma range, not just the first hugetlb page.
> 
> We're testing whether this vma falls in a hugepage_only_range.  It's
> important to check the size (end) of the vma when setting it up; but
> when tearing down it is fair to assume that it was set up correctly,
> so unnecessary to check its size (end).
> 
> I used HPAGE_SIZE rather than 0 because one can imagine an implementation
> of is_hugepage_only_range which would go wrong with 0, or with a fraction
> of HPAGE_SIZE.  Perhaps you'd be happier to add an is_hugepage_only_addr
> macro which hides that size arg to is_hugepage_only_range.

(Aside: is_hugepage_only_range() isn't about telling where huge pages
can go, it's about telling where normal pages can't go.  As such it
must for it's primary callsite on the MAP_FIXED path in
get_unmapped_area() work with parameters that aren't HPAGE_SIZE
aligned).

> > > Though, it's not possible to have a hugetlb vma while having normal page
> > > instantiated inside that vma.
> 
> That is, if the setup does its checks correctly, you're not allowed
> to have a normal vma in (or spanning) a hugepage_only_range.
> 
> > > So the bug is mostly phantom.  For correctness, it should be fixed.
> 
> I believe the bug is non-existent, and therefore needs no fix.

The bug is real alright, I've watched it call hugetlb_free_pgd_range()
for a normal page VMA on powerpc.

> > Actually, from ppc64's point of view, the problem with the test is
> > that the whole vma could be *less* than HPAGE_SIZE - we don't test
> > that the address is aligned before checking is_hugepage_only_range().
> > We thus can call hugetlb_free_pgd_range() on normal page VMAs - which
> > we only get away with because the ppc64 hugetlb_free_pgd_range() is
> > (so far) an alias for the normal free_pgd_range().
> 
> Are you saying that on ppc64, you can put non-hugepage vmas into a
> hugepage_only_range?  If so, why is it called a hugepage_only_range?
> Or, are you saying that your hugepage_only_range is smaller than
> HPAGE_SIZE, so no hugepages can fit in it?  Or that you have
> hugepage vma start addresses not aligned to HPAGE_SIZE?
> None of that makes sense to me.

None of the above.  However, is_hugepage_only_range() does not need to
be called on a hugepage aligned range (and is not here), and returns
true (and must do so) if the given range intersects a hugepage only
area, not only if it lies entirely within a hugepage only area.

Consider a HPAGE_SIZE hugepage VMA starting at 4GB, and a normal page
VMA starting at (4GB-PAGE_SIZE).  This situation is possible on
powerpc, and is_hugepage_only_range(4GB-PAGE_SIZE, HPAGE_SIZE) will
(and must) return true.  Therefore the free_pgtables() logic will call
hugetlb_free_pgd_range() across the normal page VMA.

> > Your patch below is insufficient, because there's a second test of
> > is_hugepage_only_range() further down.  However, instead of tweaking
> > the tested ranges, I think what we really want to do is check for
> > is_vm_hugetlb_page() instead.
> 
> No, that looks cleaner, but it's wrong.  hugetlb_free_pgd_range does
> something useful on those architectures which have a not-always-false
> is_hugepage_only_range (ia64 and powerpc alone): it's paired with it.
> (Though as you've noticed, powerpc only does the usual free_pgd_range.)
> 
> hugetlb_free_pgd_range does nothing on most architectures, even those
> (i386 etc) which have a not-always-false is_vm_hugetlb_page: we do
> want to free_pgd_range on those.  So using is_vm_hugetlb_page instead
> of is_hugepage_only_range is wrong for them.  Though I guess you could
> change their hugetlb_free_pgd_range definitions to free_pgd_range, and
> then use is_vm_hugetlb_page as you did, that would work too (though
> with less combining of vmas in that loop, so not an improvement).

Yes, I realised that was wrong shortly after posting.  In fact it's
wrong in just the same way that is_hugepage_only_range() is wrong for
powerpc right now - which we work around becuse
hugetlb_free_pgd_range() is identical to free_pgd_range().

I can see two ways of fixing this.  The quick, hacky fix is to use
is_vm_hugetlb_page(), and work around the problems by having
hugetlb_free_pgd_range() be identical to free_pgd_range() in most
cases.  Fixing it more cleanly will need a new callback that actually
encodes this "need special pagetable freeing" concept.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
