Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268312AbUHFVIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268312AbUHFVIn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 17:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268313AbUHFVIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 17:08:30 -0400
Received: from holomorphy.com ([207.189.100.168]:43215 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268312AbUHFVH4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 17:07:56 -0400
Date: Fri, 6 Aug 2004 14:07:50 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Hirokazu Takahashi'" <taka@valinux.co.jp>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, "Seth, Rohit" <rohit.seth@intel.com>
Subject: Re: Hugetlb demanding paging for -mm tree
Message-ID: <20040806210750.GT17188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	'Hirokazu Takahashi' <taka@valinux.co.jp>,
	linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
	"Seth, Rohit" <rohit.seth@intel.com>
References: <20040806.013522.74731251.taka@valinux.co.jp> <200408062055.i76KtcY08296@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408062055.i76KtcY08296@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2004 at 01:55:38PM -0700, Chen, Kenneth W wrote:
> diff -Nurp linux-2.6.7/mm/hugetlb.c linux-2.6.7.hugetlb/mm/hugetlb.c
> --- linux-2.6.7/mm/hugetlb.c	2004-08-06 11:44:59.000000000 -0700
> +++ linux-2.6.7.hugetlb/mm/hugetlb.c	2004-08-06 13:15:24.000000000 -0700
> @@ -276,9 +276,10 @@ retry:
>  	}
> 
>  	spin_lock(&mm->page_table_lock);
> -	if (pte_none(*pte))
> +	if (pte_none(*pte)) {
>  		set_huge_pte(mm, vma, page, pte, vma->vm_flags & VM_WRITE);
> -	else
> +		update_mmu_cache(vma, addr, *pte);
> +	} else
>  		put_page(page);
>  out:
>  	spin_unlock(&mm->page_table_lock);

update_mmu_cache() does not appear to check the size of the translation
to be established in many architectures. e.g. on arch/ia64/ it does
flush_icache_range(addr, addr + PAGE_SIZE) unconditionally, and only
sets PG_arch_1 on a single struct page. Similar comments apply to
sparc64 and ppc64; I didn't check any others.


-- wli
