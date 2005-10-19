Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbVJSPsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbVJSPsw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 11:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbVJSPsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 11:48:52 -0400
Received: from silver.veritas.com ([143.127.12.111]:58981 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751120AbVJSPsv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 11:48:51 -0400
Date: Wed, 19 Oct 2005 16:48:01 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Rohit Seth <rohit.seth@intel.com>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, Adam Litke <agl@us.ibm.com>
Subject: Re: [PATCH]: Handling spurious page fault for hugetlb region for
 2.6.14-rc4-git5
In-Reply-To: <20051018210721.4c80a292.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0510191623220.7586@goblin.wat.veritas.com>
References: <20051018141512.A26194@unix-os.sc.intel.com>
 <20051018143438.66d360c4.akpm@osdl.org> <1129673824.19875.36.camel@akash.sc.intel.com>
 <20051018172549.7f9f31da.akpm@osdl.org> <1129692330.24309.44.camel@akash.sc.intel.com>
 <20051018210721.4c80a292.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 19 Oct 2005 15:48:51.0078 (UTC) FILETIME=[99E8DA60:01C5D4C4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Oct 2005, Andrew Morton wrote:
> Rohit Seth <rohit.seth@intel.com> wrote:
> >
> > The prefetching problem is handled OK for regular pages because we can
> >  handle page faults corresponding to those pages.  That is currently not
> >  true for hugepages.  Currently the kernel assumes that PAGE_FAULT
> >  happening against a hugetlb page is caused by truncate and returns
> >  SIGBUS.

Is Rohit's intended to be a late 2.6.14 fix?  We seem to have done well
without it for several years, and are just on the point of changing to
prefaulting the hugetlb pages anyway, which will fix it up.

> @@ -2045,8 +2045,18 @@ int __handle_mm_fault(struct mm_struct *
>  
>  	inc_page_state(pgfault);
>  
> -	if (is_vm_hugetlb_page(vma))
> -		return VM_FAULT_SIGBUS;	/* mapping truncation does this. */
> +	if (unlikely(is_vm_hugetlb_page(vma))) {
> +		if (valid_hugetlb_file_off(vma, address))
> +			/* We get here only if there was a stale(zero) TLB entry
> +			 * (because of  HW prefetching).
> +			 * Low-level arch code (if needed) should have already
> +			 * purged the stale entry as part of this fault handling.
> +			 * Here we just return.
> +			 */
> +			return VM_FAULT_MINOR;
> +		else
> +			return VM_FAULT_SIGBUS;	/* mapping truncation does this. */
> +	}

(I'm not surprised that the low-level arch code fixes this up as part of the
fault handling.  I am surprised that it does so only after giving the fault
to the kernel.  Sounds like something's gone wrong.)

What happens when the hugetlb file is truncated down and back up after
the mmap?  Truncating down will remove a page from the mmap and flush TLB.
Truncating up will let accesses to the gone page pass the valid...off test.
But we've no support for hugetlb faulting in this version: so won't it get
get stuck in a tight loop?

If it's decided that this issue is actually an ia64 one, and does need to
be fixed right now, then I'd have thought your idea of fixing it at the
ia64 end better: arch/ia64/mm/fault.c already has code for discarding
faults on speculative loads, and ia64 has an RGN_HPAGE set aside for
hugetlb, so shouldn't it just discard speculative loads on that region?

Hugh
