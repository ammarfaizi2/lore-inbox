Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbUKIM4B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbUKIM4B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 07:56:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbUKIM4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 07:56:01 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:11019 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261232AbUKIMzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 07:55:49 -0500
Date: Tue, 9 Nov 2004 12:55:40 +0000
From: Christoph Hellwig <hch@infradead.org>
To: dhowells@redhat.com
Cc: torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com,
       linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: Re: [PATCH] VM routine fixes
Message-ID: <20041109125539.GA4867@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	dhowells@redhat.com, torvalds@osdl.org, akpm@osdl.org,
	davidm@snapgear.com, linux-kernel@vger.kernel.org,
	uclinux-dev@uclinux.org
References: <200411081432.iA8EWfmh023432@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411081432.iA8EWfmh023432@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +++ linux-2.6.10-rc1-mm3-frv/include/linux/mm.h	2004-11-05 17:44:09.120160519 +0000
> @@ -37,6 +37,10 @@ extern int sysctl_legacy_va_layout;
>  #include <asm/processor.h>
>  #include <asm/atomic.h>
>  
> +#ifndef CONFIG_MMU
> +#define swapper_pml4 NULL
> +#endif
> +
>  #ifndef MM_VM_SIZE
>  #define MM_VM_SIZE(mm)	TASK_SIZE
>  #endif
> @@ -640,6 +674,7 @@ extern void remove_shrinker(struct shrin
>   * inlining and the symmetry break with pte_alloc_map() that does all
>   * of this out-of-line.
>   */
> +#ifdef CONFIG_MMU
>  static inline pmd_t *pmd_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address)
>  {
>  	if (pgd_none(*pgd))
> @@ -660,6 +695,7 @@ static inline pgd_t *pgd_alloc_k(struct 
>  		return __pgd_alloc(mm, pml4, address);
>  	return pml4_pgd_offset_k(pml4, address);
>  }
> +#endif

Please don't stick CONFIG_MMU all over the place but keep them in as small
as possible blocks.

> +#ifdef CONFIG_MMU
>  	{
>  		.ctl_name	= VM_MAX_MAP_COUNT,
>  		.procname	= "max_map_count",
> @@ -763,6 +764,7 @@ static ctl_table vm_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= &proc_dointvec
>  	},
> +#endif

As I told you before please move registration of MMU-only sysctls
to a MMU-only file in mm/

> +extern void set_page_refs(struct page *page, int order);

this should probably be an inline.

>  	mod_page_state(pgfree, 1 << order);
> +
> +#ifndef CONFIG_MMU
> +	if (order > 0)
> +		for (i = 1 ; i < (1 << order) ; ++i)
> +			__put_page(page + i);
> +#endif
> +

this is nasty.  The right thing would probably to swich !MMU arches
to use the compount-page mechanism from the hugetlb code for this.

> --- /warthog/kernels/linux-2.6.10-rc1-mm3/mm/tiny-shmem.c	2004-10-27 17:32:38.000000000 +0100
> +++ linux-2.6.10-rc1-mm3-frv/mm/tiny-shmem.c	2004-11-05 14:13:05.000000000 +0000
> @@ -112,7 +112,9 @@ int shmem_zero_setup(struct vm_area_stru
>  	if (vma->vm_file)
>  		fput(vma->vm_file);
>  	vma->vm_file = file;
> +#ifdef CONFIG_MMU
>  	vma->vm_ops = &generic_file_vm_ops;
> +#endif

And you ocmpletely ignored the previous comment here aswell.

