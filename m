Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932364AbVJSAZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbVJSAZi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 20:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbVJSAZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 20:25:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38550 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932333AbVJSAZh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 20:25:37 -0400
Date: Tue, 18 Oct 2005 17:25:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Rohit Seth <rohit.seth@intel.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Handling spurious page fault for hugetlb region for
 2.6.14-rc4-git5
Message-Id: <20051018172549.7f9f31da.akpm@osdl.org>
In-Reply-To: <1129673824.19875.36.camel@akash.sc.intel.com>
References: <20051018141512.A26194@unix-os.sc.intel.com>
	<20051018143438.66d360c4.akpm@osdl.org>
	<1129673824.19875.36.camel@akash.sc.intel.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rohit Seth <rohit.seth@intel.com> wrote:
>
> On Tue, 2005-10-18 at 14:34 -0700, Andrew Morton wrote:
> > "Seth, Rohit" <rohit.seth@intel.com> wrote:
> > >
> > > Linus,
> > > 
> > > [PATCH]: Handle spurious page fault for hugetlb region
> > > 
> > > The hugetlb pages are currently pre-faulted.  At the time of mmap of
> > > hugepages, we populate the new PTEs.  It is possible that HW has already cached
> > > some of the unused PTEs internally.
> > 
> > What's an "unused pte"?  One which maps a regular-sized page at the same
> > virtual address?  How can such a thing come about, and why isn't it already
> > a problem for regular-sized pages?  From where does the hardware prefetch
> > the pte contents?
> > 
> 
> Unsused pte is where *pte == 0.  Basically entries in leaf page table
> that does not map anything.

Oh.  Then I'm still not understanding.

>  If such a pte ends up mapping a normal page
> then  you get a page fault and HW/handler does the right thing (in terms
> of purging old entries). 

For starters, we don't actually _use_ pte's for the hugepage.  We use an
entry in a pmd page.  Does that concept still apply for ia64?

If so, are you saying that the hardware prefetching is happening at the pmd
level?  If not, how can it happen at the pte level when the hardware
doesn't know where the pte page _is_?

Has this problem been observed in testing?

> 
> > IOW: please tell us more about this hardware pte-fetcher.
> > 
> > >  These stale entries never get a chance to
> > > be purged in existing control flow.
> > 
> > I'd have thought that invalidating those ptes at mmap()-time would be a
> > more consistent approach.
> 
> That would be adding too many unconditional purges (which are very
> expensive operations) during mmap.  And as we are only talking of
> speculative pre-fetches that are done by HW so IMO we should do this as
> lazily as possible (only if required).

Is an mmap of a hugepage region very common?  I guess it is, on ia32, or on
64-bit apps which are (poorly?) designed to also run on ia32.

> > If the low-level code has purged the stale pte then it knows what's
> > happening.  Perhaps it shouldn't call into handle_mm_fault() at all?
> 
> Well, at that time the code does not know if the address belong to
> hugetlbfile.  The archs that needs those purges in low level code need
> them for all (for example) page not present faults.

I still don't understand what's different about hugepages here.  If the
prefetching problem also occurs on regular pages and is handled OK for
regular pages, why do hugepages need special treatment?
