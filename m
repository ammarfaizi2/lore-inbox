Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbWBVQer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbWBVQer (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 11:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbWBVQer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 11:34:47 -0500
Received: from silver.veritas.com ([143.127.12.111]:6075 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1750793AbWBVQeq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 11:34:46 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.02,137,1139212800"; 
   d="scan'208"; a="34699512:sNHT24239784"
Date: Wed, 22 Feb 2006 16:35:34 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "'David Gibson'" <david@gibson.dropbear.id.au>
cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: IA64 non-contiguous memory space bugs
In-Reply-To: <20060222022558.GE23574@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0602221546040.9885@goblin.wat.veritas.com>
References: <200602220132.k1M1Vxg09552@unix-os.sc.intel.com>
 <200602220151.k1M1pqg09761@unix-os.sc.intel.com> <20060222022558.GE23574@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 22 Feb 2006 16:34:45.0491 (UTC) FILETIME=[E3B76C30:01C637CD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Feb 2006, 'David Gibson' wrote:
> On Tue, Feb 21, 2006 at 05:51:52PM -0800, Chen, Kenneth W wrote:
> > 
> > free_pgtables() has partial crap that the check of is_hugepage_only_range()
> > should be done on the entire vma range, not just the first hugetlb page.

We're testing whether this vma falls in a hugepage_only_range.  It's
important to check the size (end) of the vma when setting it up; but
when tearing down it is fair to assume that it was set up correctly,
so unnecessary to check its size (end).

I used HPAGE_SIZE rather than 0 because one can imagine an implementation
of is_hugepage_only_range which would go wrong with 0, or with a fraction
of HPAGE_SIZE.  Perhaps you'd be happier to add an is_hugepage_only_addr
macro which hides that size arg to is_hugepage_only_range.

> > Though, it's not possible to have a hugetlb vma while having normal page
> > instantiated inside that vma.

That is, if the setup does its checks correctly, you're not allowed
to have a normal vma in (or spanning) a hugepage_only_range.

> > So the bug is mostly phantom.  For correctness, it should be fixed.

I believe the bug is non-existent, and therefore needs no fix.

> Actually, from ppc64's point of view, the problem with the test is
> that the whole vma could be *less* than HPAGE_SIZE - we don't test
> that the address is aligned before checking is_hugepage_only_range().
> We thus can call hugetlb_free_pgd_range() on normal page VMAs - which
> we only get away with because the ppc64 hugetlb_free_pgd_range() is
> (so far) an alias for the normal free_pgd_range().

Are you saying that on ppc64, you can put non-hugepage vmas into a
hugepage_only_range?  If so, why is it called a hugepage_only_range?
Or, are you saying that your hugepage_only_range is smaller than
HPAGE_SIZE, so no hugepages can fit in it?  Or that you have
hugepage vma start addresses not aligned to HPAGE_SIZE?
None of that makes sense to me.

> Your patch below is insufficient, because there's a second test of
> is_hugepage_only_range() further down.  However, instead of tweaking
> the tested ranges, I think what we really want to do is check for
> is_vm_hugetlb_page() instead.

No, that looks cleaner, but it's wrong.  hugetlb_free_pgd_range does
something useful on those architectures which have a not-always-false
is_hugepage_only_range (ia64 and powerpc alone): it's paired with it.
(Though as you've noticed, powerpc only does the usual free_pgd_range.)

hugetlb_free_pgd_range does nothing on most architectures, even those
(i386 etc) which have a not-always-false is_vm_hugetlb_page: we do
want to free_pgd_range on those.  So using is_vm_hugetlb_page instead
of is_hugepage_only_range is wrong for them.  Though I guess you could
change their hugetlb_free_pgd_range definitions to free_pgd_range, and
then use is_vm_hugetlb_page as you did, that would work too (though
with less combining of vmas in that loop, so not an improvement).

So far as I know, there's nothing to be fixed at the free_pgtables end
(apart from an utterly unrelated latency issue).  But, without having
studied your first patch, I've little doubt that you have identified
significant oversights when bounds checking the vma when it's set up.

Hugh
