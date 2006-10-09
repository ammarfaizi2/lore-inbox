Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751832AbWJILLA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbWJILLA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 07:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751841AbWJILLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 07:11:00 -0400
Received: from gate.crashing.org ([63.228.1.57]:64702 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751832AbWJILK7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 07:10:59 -0400
Subject: Re: [patch 3/3] mm: fault handler to replace nopage and populate
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20061009110007.GA3592@wotan.suse.de>
References: <20061007105758.14024.70048.sendpatchset@linux.site>
	 <20061007105853.14024.95383.sendpatchset@linux.site>
	 <20061007134407.6aa4dd26.akpm@osdl.org>
	 <1160351174.14601.3.camel@localhost.localdomain>
	 <20061009102635.GC3487@wotan.suse.de>
	 <1160391014.10229.16.camel@localhost.localdomain>
	 <20061009110007.GA3592@wotan.suse.de>
Content-Type: text/plain
Date: Mon, 09 Oct 2006 21:10:13 +1000
Message-Id: <1160392214.10229.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Yep, I see. You just need to be careful about the PFNMAP logic, so
> the VM knows whether the pte is backed by a struct page or not.

I still need to properly get my head around that one. I can't easily
change the VMA during the "switch" but I can tweak the flags on the
first nopage after one... 

> And going the pageless route means that you must disallow MAP_PRIVATE
> PROT_WRITE mappings, I trust that isn't a problem for you?

Should not but I need to look more closely.

> I guess the helper looks something like the following...
> 
> --
> 
> Index: linux-2.6/include/linux/mm.h
> ===================================================================
> --- linux-2.6.orig/include/linux/mm.h
> +++ linux-2.6/include/linux/mm.h
> @@ -1105,6 +1105,7 @@ unsigned long vmalloc_to_pfn(void *addr)
>  int remap_pfn_range(struct vm_area_struct *, unsigned long addr,
>  			unsigned long pfn, unsigned long size, pgprot_t);
>  int vm_insert_page(struct vm_area_struct *, unsigned long addr, struct page *);
> +int vm_insert_pfn(struct vm_area_struct *, unsigned long addr, unsigned long pfn);
>  
>  struct page *follow_page(struct vm_area_struct *, unsigned long address,
>  			unsigned int foll_flags);
> Index: linux-2.6/mm/memory.c
> ===================================================================
> --- linux-2.6.orig/mm/memory.c
> +++ linux-2.6/mm/memory.c
> @@ -1267,6 +1267,44 @@ int vm_insert_page(struct vm_area_struct
>  }
>  EXPORT_SYMBOL(vm_insert_page);
>  
> +/**
> + * vm_insert_pfn - insert single pfn into user vma
> + * @vma: user vma to map to
> + * @addr: target user address of this page
> + * @pfn: source kernel pfn
> + *
> + * Similar to vm_inert_page, this allows drivers to insert individual pages
> + * they've allocated into a user vma. Same comments apply
> + */
> +int vm_insert_pfn(struct vm_area_struct *vma, unsigned long addr, unsigned long pfn)
> +{
> +	struct mm_struct *mm = vma->vm_mm;
> +	int retval;
> +	pte_t *pte;
> +	spinlock_t *ptl;
> +
> +	BUG_ON(is_cow_mapping(vma->vm_flags));
> +
> +	retval = -ENOMEM;
> +	pte = get_locked_pte(mm, addr, &ptl);
> +	if (!pte)
> +		goto out;
> +	retval = -EBUSY;
> +	if (!pte_none(*pte))
> +		goto out_unlock;
> +
> +	/* Ok, finally just insert the thing.. */
> +	set_pte_at(mm, addr, pte, pfn_pte(pfn, vma->vm_page_prot));
> +
> +	vma->vm_flags |= VM_PFNMAP;
> +	retval = 0;
> +out_unlock:
> +	pte_unmap_unlock(pte, ptl);
> +out:
> +	return retval;
> +}
> +EXPORT_SYMBOL(vm_insert_pfn);

It also needs update_mmu_cache() I suppose.

>  /*
>   * maps a range of physical memory into the requested pages. the old
>   * mappings are removed. any references to nonexistent pages results

