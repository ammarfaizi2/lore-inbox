Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266870AbUHIS72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266870AbUHIS72 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 14:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266867AbUHIS5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 14:57:07 -0400
Received: from fmr04.intel.com ([143.183.121.6]:35557 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S266870AbUHISyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 14:54:47 -0400
Message-Id: <200408091854.i79IsCY12450@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'William Lee Irwin III'" <wli@holomorphy.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
       "Seth, Rohit" <rohit.seth@intel.com>
Subject: RE: Hugetlb demanding paging for -mm tree
Date: Mon, 9 Aug 2004 11:54:13 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcR8WZ1lKPNQOcxPRniauN4tumLoCAB48I+Q
In-Reply-To: <20040807083613.GZ17188@holomorphy.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote on Saturday, August 07, 2004 1:36 AM
> On Thu, Aug 05, 2004 at 06:39:59AM -0700, Chen, Kenneth W wrote:
> > +static void scrub_one_pmd(pmd_t * pmd)
> > +{
> > +	struct page *page;
> > +
> > +	if (pmd && !pmd_none(*pmd) && !pmd_huge(*pmd)) {
> > +		page = pmd_page(*pmd);
> > +		pmd_clear(pmd);
> > +		dec_page_state(nr_page_table_pages);
> > +		page_cache_release(page);
> > +	}
> > +}
>
> This is needed because we're only freeing pagetables at pgd granularity
> at munmap() -time. It makes more sense to refine it to pmd granularity
> instead of this cleanup pass, as it's a memory leak beyond just hugetlb
> data structure corruption.
>

That would be nice and ease the pain on x86.  OTOH, leaving pte persistent
right now may help in mmap/munmap intensive workload since unmap_region()
only destroys all pte allocation at pgd granularity.


> I wonder why this bugfix was rolled into the demand paging patch instead
> of shipped separately. And for that matter, this fix applies to mainline.

The bug fix went into hugetlb_prefault() function in the mainline for the
prefaulting case.  It went to that function instead of huge_pte_alloc and huge_pte_offset is to avoid scrubbing at pte lookup time.
One thing we can
do for demand paging case is to scrub it at initial mmap hugetlb vma, so
the penalty is paid upfront instead of at every pte allocation/lookup time.


