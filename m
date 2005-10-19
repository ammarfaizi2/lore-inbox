Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932444AbVJSDue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbVJSDue (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 23:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbVJSDue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 23:50:34 -0400
Received: from fmr24.intel.com ([143.183.121.16]:30343 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S932444AbVJSDue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 23:50:34 -0400
Subject: Re: [PATCH]: Handling spurious page fault for hugetlb region for
	2.6.14-rc4-git5
From: Rohit Seth <rohit.seth@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
In-Reply-To: <20051018172549.7f9f31da.akpm@osdl.org>
References: <20051018141512.A26194@unix-os.sc.intel.com>
	 <20051018143438.66d360c4.akpm@osdl.org>
	 <1129673824.19875.36.camel@akash.sc.intel.com>
	 <20051018172549.7f9f31da.akpm@osdl.org>
Content-Type: text/plain
Organization: Intel 
Date: Tue, 18 Oct 2005 20:25:30 -0700
Message-Id: <1129692330.24309.44.camel@akash.sc.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Oct 2005 03:18:19.0063 (UTC) FILETIME=[C0BCAC70:01C5D45B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-18 at 17:25 -0700, Andrew Morton wrote: 
> Rohit Seth <rohit.seth@intel.com> wrote:
> >
> > 
> > Unsused pte is where *pte == 0.  Basically entries in leaf page table
> > that does not map anything.
> 
> Oh.  Then I'm still not understanding.


Following is the scenario:

Kernel is going to prefault the huge page for user virtual address V.  

Let us say the pointer pte points to the page table entry (for x86 it is
PDE/PMD) which maps the hugepage.  

At this point *pte == 0.  CPU also has this entry cached in its TLB.
Meaning, unless this entry is purged or displaced, for virtual address V
CPU will generate the page fault (as the P bit is not set and assuming
this fault has the highest precedence).

Kernel updates the *pte so that it now maps the hugepage at virtual
address V to physical address P.  

Later when the user process make a reference to V, because of stale TLB
entry, the processor gets PAGE_FAULT.

> 
> >  If such a pte ends up mapping a normal page
> > then  you get a page fault and HW/handler does the right thing (in terms
> > of purging old entries). 
> 
> For starters, we don't actually _use_ pte's for the hugepage.  We use an
> entry in a pmd page.  Does that concept still apply for ia64?
> 

With pte entry, I mean the entry that is mapping the hugepage (leaf
level entry).  This entry could be sitting in PDE/PMD for x86 or VHPT
for IA-64. This entry is referring to what the processor uses for
translation to get to huge page.

> If so, are you saying that the hardware prefetching is happening at the pmd
> level?  If not, how can it happen at the pte level when the hardware
> doesn't know where the pte page _is_?
> 

IA-64, for example, directly maps the last level of page table.
Processor directly uses this table to find the translations.  So, there
is no pmd here.

But it is entirely possible on x86 arch as well that any level of PDE
(PMD), PTE could be getting prefetched.  That is why architecture
requires invalidate/purge operations whenever any of this entry changes.

> Has this problem been observed in testing?
> 

Yes. On IA-64.

> 
> > > I'd have thought that invalidating those ptes at mmap()-time would be a
> > > more consistent approach.
> > 
> > That would be adding too many unconditional purges (which are very
> > expensive operations) during mmap.  And as we are only talking of
> > speculative pre-fetches that are done by HW so IMO we should do this as
> > lazily as possible (only if required).
> 
> Is an mmap of a hugepage region very common?  I guess it is, on ia32, or on
> 64-bit apps which are (poorly?) designed to also run on ia32.
> 
> 
On x86 it surely is.  For 64-bit there is 100G or more of mmaps...

And then you will have to do this purge for all the processes that are trying
to mmap hugepages.

> > > If the low-level code has purged the stale pte then it knows what's
> > > happening.  Perhaps it shouldn't call into handle_mm_fault() at all?
> > 
> > Well, at that time the code does not know if the address belong to
> > hugetlbfile.  The archs that needs those purges in low level code need
> > them for all (for example) page not present faults.
> 
> I still don't understand what's different about hugepages here.  If the
> prefetching problem also occurs on regular pages and is handled OK for
> regular pages, why do hugepages need special treatment?

The prefetching problem is handled OK for regular pages because we can
handle page faults corresponding to those pages.  That is currently not
true for hugepages.  Currently the kernel assumes that PAGE_FAULT
happening against a hugetlb page is caused by truncate and returns
SIGBUS.




