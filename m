Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317664AbSGaDCM>; Tue, 30 Jul 2002 23:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317665AbSGaDCM>; Tue, 30 Jul 2002 23:02:12 -0400
Received: from mail.gmx.de ([213.165.64.20]:42713 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S317664AbSGaDCL>;
	Tue, 30 Jul 2002 23:02:11 -0400
Date: Wed, 31 Jul 2002 06:05:19 +0300
From: Dan Aloni <da-x@gmx.net>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix x86 page table init
Message-ID: <20020731030519.GA27694@callisto.yi.org>
References: <3D47412D.1060407@quark.didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D47412D.1060407@quark.didntduck.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2002 at 09:45:17PM -0400, Brian Gerst wrote:
> The recent changes to the x86 page table init reintroduced a bug with 
> the 4k pagetables.  The page table must be filled with entries before it 
> is inserted into the pmd or else you risk a tlb miss on a kernel code 
> page causing an oops.  This patch takes a different approach than before 
> - it allows for reuse of the boot pagetable pages instead of allocating 
> new ones.

In the patch below, isn't there a bootmem page leak in case !pmd_none(*pmd)?

> diff -urN linux-bk/arch/i386/mm/init.c linux/arch/i386/mm/init.c
> --- linux-bk/arch/i386/mm/init.c	Tue Jul 30 20:59:27 2002
> +++ linux/arch/i386/mm/init.c	Tue Jul 30 21:02:41 2002
> @@ -70,10 +70,14 @@
>   */
>  static pte_t * __init one_page_table_init(pmd_t *pmd)
>  {
> -	pte_t *page_table = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
> -	set_pmd(pmd, __pmd(__pa(page_table) | _KERNPG_TABLE));
> -	if (page_table != pte_offset_kernel(pmd, 0))
> -		BUG();	
> +	pte_t *page_table;
> +	page_table = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
> +	if (pmd_none(*pmd)) {
> +		set_pmd(pmd, __pmd(__pa(page_table) | _KERNPG_TABLE));
> +		if (page_table != pte_offset_kernel(pmd, 0))
> +			BUG();	
> +	} else
> +		page_table = pte_offset_kernel(pmd, 0);
>  
>  	return page_table;
>  }
> @@ -107,9 +111,7 @@
>  
>  		pmd = pmd_offset(pgd, vaddr);
>  		for (; (pmd_ofs < PTRS_PER_PMD) && (vaddr != end); pmd++, pmd_ofs++) {
> -			if (pmd_none(*pmd)) 
> -				one_page_table_init(pmd);
> -
> +			one_page_table_init(pmd);
>  			vaddr += PMD_SIZE;
>  		}
>  		pmd_ofs = 0;


-- 
Dan Aloni
da-x@gmx.net
