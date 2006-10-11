Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbWJKKMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbWJKKMj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 06:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbWJKKMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 06:12:39 -0400
Received: from relay.gothnet.se ([82.193.160.251]:28936 "EHLO
	GOTHNET-SMTP2.gothnet.se") by vger.kernel.org with ESMTP
	id S1751101AbWJKKMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 06:12:38 -0400
Message-ID: <452CC383.4050401@tungstengraphics.com>
Date: Wed, 11 Oct 2006 12:12:19 +0200
From: Thomas Hellstrom <thomas@tungstengraphics.com>
User-Agent: Mozilla Thunderbird 1.0.6-7.6.20060mdk (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <npiggin@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 4/5] mm: add vm_insert_pfn helpler
References: <20061010121314.19693.75503.sendpatchset@linux.site> <20061010121357.19693.7339.sendpatchset@linux.site>
In-Reply-To: <20061010121357.19693.7339.sendpatchset@linux.site>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-BitDefender-Scanner: Mail not scanned due to license constraints
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Add a vm_insert_pfn helper, so that ->fault handlers can have nopfn
> functionality by installing their own pte and returning NULL.
> 
> Signed-off-by: Nick Piggin <npiggin@suse.de>
> 
> Index: linux-2.6/include/linux/mm.h
> ===================================================================
> --- linux-2.6.orig/include/linux/mm.h
> +++ linux-2.6/include/linux/mm.h
> @@ -1121,6 +1121,7 @@ unsigned long vmalloc_to_pfn(void *addr)
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
> @@ -1267,6 +1267,50 @@ int vm_insert_page(struct vm_area_struct
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
> + * they've allocated into a user vma. Same comments apply.
> + *
> + * This function should only be called from a vm_ops->fault handler, and
> + * in that case the handler should return NULL.
> + */
> +int vm_insert_pfn(struct vm_area_struct *vma, unsigned long addr, unsigned long pfn)

Nick, I just realized: would it be possible to have a pgprot_t argument 
to this one, instead of it using vma->vm_pgprot?

The motivation for this (DRM again) is that some architectures (powerpc) 
cannot map the AGP aperture through IO space, but needs to remap the 
page from memory with a nocache attribute set. Others need special 
pgprot settings for write-combined mappings.

Now, there's a possibility to change vma->vm_pgprot during the first 
->fault(), but again, we only have the mmap_sem in read mode.

/Thomas




