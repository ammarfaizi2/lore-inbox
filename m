Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751220AbVJSS61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbVJSS61 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 14:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbVJSS61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 14:58:27 -0400
Received: from fmr23.intel.com ([143.183.121.15]:48607 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751220AbVJSS60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 14:58:26 -0400
Subject: Re: [PATCH]: Handling spurious page fault for hugetlb region for
	2.6.14-rc4-git5
From: Rohit Seth <rohit.seth@intel.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, Adam Litke <agl@us.ibm.com>
In-Reply-To: <Pine.LNX.4.61.0510191623220.7586@goblin.wat.veritas.com>
References: <20051018141512.A26194@unix-os.sc.intel.com>
	 <20051018143438.66d360c4.akpm@osdl.org>
	 <1129673824.19875.36.camel@akash.sc.intel.com>
	 <20051018172549.7f9f31da.akpm@osdl.org>
	 <1129692330.24309.44.camel@akash.sc.intel.com>
	 <20051018210721.4c80a292.akpm@osdl.org>
	 <Pine.LNX.4.61.0510191623220.7586@goblin.wat.veritas.com>
Content-Type: text/plain
Organization: Intel 
Date: Wed, 19 Oct 2005 12:05:33 -0700
Message-Id: <1129748733.339.90.camel@akash.sc.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Oct 2005 18:58:14.0862 (UTC) FILETIME=[0F40AEE0:01C5D4DF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-19 at 16:48 +0100, Hugh Dickins wrote:
> On Tue, 18 Oct 2005, Andrew Morton wrote:
> > Rohit Seth <rohit.seth@intel.com> wrote:
> > >
> > > The prefetching problem is handled OK for regular pages because we can
> > >  handle page faults corresponding to those pages.  That is currently not
> > >  true for hugepages.  Currently the kernel assumes that PAGE_FAULT
> > >  happening against a hugetlb page is caused by truncate and returns
> > >  SIGBUS.
> 
> Is Rohit's intended to be a late 2.6.14 fix?  We seem to have done well
> without it for several years, and are just on the point of changing to
> prefaulting the hugetlb pages anyway, which will fix it up.
> 

I understand this is (very) late in the cycle for 2.6.14  But this issue
is happening on existing HW.  Moreover, if demand paging of hugepages is
going to make into next version release from Linus then it makes all the
more sense to fill in the gap for prefaulting in this release itself. 

It is also quite possible that some OSVs use 2.6.14 as the base for
their next releases. FWIW this patch is applicable to all the previous
kernel versions as well.

That done well for years logic ..... does not really hold good.  There
is always better HW and SW that brings up new issues in existing code
that happened to be running well for years.

> >
> What happens when the hugetlb file is truncated down and back up after
> the mmap?  Truncating down will remove a page from the mmap and flush TLB.
> Truncating up will let accesses to the gone page pass the valid...off test.
> But we've no support for hugetlb faulting in this version: so won't it get
> get stuck in a tight loop?
> 

First of all, there is currently no support of extending the hugetlb
file size using truncate in 2.6.14. (I agree that part is broken).  So
the above scenario can not happen.

For the prefaulting hugepage case that exist today, I would assume that
(if someone does extend ) using truncate to extend the hugetlb file size
support, would update the PTEs of all the processes that have those
hugepages mapped (just like when truncating it down currently kernel
clear the ptes from all the processes PT).

> If it's decided that this issue is actually an ia64 one, and does need to
> be fixed right now, then I'd have thought your idea of fixing it at the
> ia64 end better: arch/ia64/mm/fault.c already has code for discarding
> faults on speculative loads, and ia64 has an RGN_HPAGE set aside for
> hugetlb, so shouldn't it just discard speculative loads on that region?
> 

This has nothing to do with speculative load fault on IA-64.  

The first time kernel finds out about if a page belongs to hugepage in
the path of page_fault is in mm/memory.c  Though the duplicated logic
could be added in the arch specific tree.  

I wonder if other archs like ppc is also exposed to this behavior.

-rohit


