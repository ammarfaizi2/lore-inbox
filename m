Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbVLHQHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbVLHQHV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 11:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbVLHQHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 11:07:20 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:1935 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751210AbVLHQHS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 11:07:18 -0500
Subject: Re: 2.6.15-rc4 panic in __nr_to_section() with CONFIG_SPARSEMEM
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andy Whitcroft <andyw@uk.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       dwg@au1.ibm.com
In-Reply-To: <1134002888.30387.82.camel@localhost>
References: <1133995060.21841.56.camel@localhost.localdomain>
	 <43976AA4.2060606@uk.ibm.com>
	 <1133997772.21841.62.camel@localhost.localdomain>
	 <1134002888.30387.82.camel@localhost>
Content-Type: text/plain
Date: Thu, 08 Dec 2005 08:07:35 -0800
Message-Id: <1134058055.21841.70.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-07 at 16:48 -0800, Dave Hansen wrote:
> On Wed, 2005-12-07 at 15:22 -0800, Badari Pulavarty wrote:
> > BTW, the problem seems to be while dealing with shared memory areas
> > that are backed by largepages.
> 
> I think this is likely not directly a sparsemem problem.  It probably
> just shows symptoms earlier.
> 
> See the attached patch.  It attempts to detect and handle hugetlb pages
> in the smaps code.  However, I think one of the root issues here is that
> bad_pmd() triggers for hugetlb pmds.  I audited a few places where it is
> called, and at least a couple of them can't have hugepages handed into
> them, like fork().
> 
> -- Dave
> 
> 
> 
> ---
> 
>  proc-dups-dave/fs/proc/task_mmu.c |   22 ++++++++++++++++++++++
>  1 files changed, 22 insertions(+)
> 
> diff -puN fs/proc/task_mmu.c~task_mmu_fix fs/proc/task_mmu.c
> --- proc-dups/fs/proc/task_mmu.c~task_mmu_fix	2005-12-07 16:34:38.000000000 -0800
> +++ proc-dups-dave/fs/proc/task_mmu.c	2005-12-07 16:34:47.000000000 -0800
> @@ -245,6 +245,28 @@ static inline void smaps_pmd_range(struc
>  	pmd = pmd_offset(pud, addr);
>  	do {
>  		next = pmd_addr_end(addr, end);
> +
> +		if (pmd_huge(*pmd)) {
> +			struct page *page;
> +
> +			page = follow_huge_pmd(vma->vm_mm, addr, pmd, 0);
> +			if (!page)
> +				continue;
> +
> +			mss->resident += HPAGE_SIZE;
> +			if (page_count(page) >= 2) {
> +				if (pte_dirty(*(pte_t *)pmd))
> +					mss->shared_dirty += HPAGE_SIZE;
> +				else
> +					mss->shared_clean += HPAGE_SIZE;
> +			} else {
> +				if (pte_dirty(*(pte_t *)pmd))
> +					mss->private_dirty += HPAGE_SIZE;
> +				else
> +					mss->private_clean += HPAGE_SIZE;
> +			}
> +			continue;
> +		}
>  		if (pmd_none_or_clear_bad(pmd))
>  			continue;
>  		smaps_pte_range(vma, pmd, addr, next, mss);


No. It doesn't help. It looks like ppc pmd_huge() always returns 0.
Don't know why ? :(

Thanks,
Badari

