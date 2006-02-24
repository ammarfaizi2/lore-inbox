Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932613AbWBXW1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932613AbWBXW1I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 17:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932615AbWBXW1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 17:27:07 -0500
Received: from smtp.osdl.org ([65.172.181.4]:32128 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932613AbWBXW1G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 17:27:06 -0500
Date: Fri, 24 Feb 2006 14:28:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com,
       yanmin.zhang@intel.com, "David S. Miller" <davem@davemloft.net>,
       Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Gibson <david@gibson.dropbear.id.au>,
       William Lee Irwin III <wli@holomorphy.com>,
       Paul Mundt <lethal@linux-sh.org>, kkojima@rr.iij4u.or.jp,
       "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH] Enable mprotect on huge pages
Message-Id: <20060224142844.77cbd484.akpm@osdl.org>
In-Reply-To: <1140664780.12944.26.camel@ymzhang-perf.sh.intel.com>
References: <1140664780.12944.26.camel@ymzhang-perf.sh.intel.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Zhang, Yanmin" <yanmin_zhang@linux.intel.com> wrote:
>
> From: Zhang, Yanmin <yanmin.zhang@intel.com>
> 
> 2.6.16-rc3 uses hugetlb on-demand paging, but it doesn_t support hugetlb
> mprotect. My patch against 2.6.16-rc3 enables this capability.
> 

Well I suppose that makes sense.  It does assume that the normal pte
protection-changing APIs do the right thing on all architectures which
implement huge pages.  That's quite possibly the case, but we should
confirm that.

> +
> +void hugetlb_change_protection(struct vm_area_struct *vma,
> +		unsigned long address, unsigned long end, pgprot_t newprot)
> +{
> +	struct mm_struct *mm = vma->vm_mm;
> +	unsigned long start = address;
> +	pte_t *ptep;
> +	pte_t pte;
> +
> +	BUG_ON(address >= end);
> +	flush_cache_range(vma, address, end);
> +
> +	spin_lock(&mm->page_table_lock);
> +	for (; address < end; address += HPAGE_SIZE) {
> +		ptep = huge_pte_offset(mm, address);
> +		if (!ptep)
> +			continue;
> +		if (pte_present(*ptep)) {
> +			pte = ptep_get_and_clear(mm, address, ptep);
> +			pte = pte_modify(pte, newprot);
> +			set_huge_pte_at(mm, addr, ptep, pte);
> +			lazy_mmu_prot_update(pte);
> +		}
> +	}
> +	spin_unlock(&mm->page_table_lock);
> +
> +	flush_tlb_range(vma, start, end);
> +}

