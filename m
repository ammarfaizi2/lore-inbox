Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266912AbUHITOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266912AbUHITOK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 15:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266920AbUHITNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 15:13:18 -0400
Received: from holomorphy.com ([207.189.100.168]:12258 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266901AbUHITMr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 15:12:47 -0400
Date: Mon, 9 Aug 2004 12:12:40 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       "Seth, Rohit" <rohit.seth@intel.com>
Subject: Re: Hugetlb demanding paging for -mm tree
Message-ID: <20040809191240.GS11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
	"Seth, Rohit" <rohit.seth@intel.com>
References: <20040807083613.GZ17188@holomorphy.com> <200408091854.i79IsCY12450@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408091854.i79IsCY12450@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote on Saturday, August 07, 2004 1:36 AM
>> This is needed because we're only freeing pagetables at pgd granularity
>> at munmap() -time. It makes more sense to refine it to pmd granularity
>> instead of this cleanup pass, as it's a memory leak beyond just hugetlb
>> data structure corruption.

On Mon, Aug 09, 2004 at 11:54:13AM -0700, Chen, Kenneth W wrote:
> That would be nice and ease the pain on x86.  OTOH, leaving pte persistent
> right now may help in mmap/munmap intensive workload since unmap_region()
> only destroys all pte allocation at pgd granularity.

We're better off caching pagetables for that. I don't appear to be able
to get the code to cache 3rd-level pagetables on ia32 past permavetoes.


William Lee Irwin III wrote on Saturday, August 07, 2004 1:36 AM
>> I wonder why this bugfix was rolled into the demand paging patch instead
>> of shipped separately. And for that matter, this fix applies to mainline.

On Mon, Aug 09, 2004 at 11:54:13AM -0700, Chen, Kenneth W wrote:
> The bug fix went into hugetlb_prefault() function in the mainline for the
> prefaulting case.  It went to that function instead of huge_pte_alloc
> and huge_pte_offset is to avoid scrubbing at pte lookup time. One
> thing we can do for demand paging case is to scrub it at initial mmap
> hugetlb vma, so the penalty is paid upfront instead of at every pte
> allocation/lookup time.

Good thing I brought a barfbag back from the OLS return flight... the
leak really is a major issue, esp. on 64-bit where vast amounts of
virtualspace are mapped and hence vast amounts of pagetables may leak.

I'll put the pagetable cleanup on my TODO along with ia64 pagetable
caching (which should be as easy as it was for ppc64).


-- wli
