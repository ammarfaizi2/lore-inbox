Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261649AbVGGOqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbVGGOqL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 10:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbVGGOdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 10:33:44 -0400
Received: from cantor2.suse.de ([195.135.220.15]:30128 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261704AbVGGOdN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 10:33:13 -0400
Date: Thu, 7 Jul 2005 16:33:05 +0200
From: Andi Kleen <ak@suse.de>
To: Stuart_Hayes@Dell.com
Cc: ak@suse.de, riel@redhat.com, andrea@suse.de, linux-kernel@vger.kernel.org,
       mingo@elte.hu
Subject: Re: page allocation/attributes question (i386/x86_64 specific)
Message-ID: <20050707143304.GE21330@wotan.suse.de>
References: <B1939BC11A23AE47A0DBE89A37CB26B407435C@ausx3mps305.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B1939BC11A23AE47A0DBE89A37CB26B407435C@ausx3mps305.aus.amer.dell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2005 at 03:02:26PM -0500, Stuart_Hayes@Dell.com wrote:
[Sorry for  the late answer]

> Hayes, Stuart wrote:
> >> So, if I understand correctly what's going on in x86_64, your fix
> >> wouldn't be applicable to i386.  In x86_64, every large page has a
> >> correct "ref_prot" that is the normal setting for that page... but in
> >> i386, the kernel text area does not--it should ideally be split into
> >> small pages all the time if there are both kernel code & free pages
> >> residing in the same 2M area. 
> >> 
> >> Stuart
> > 
> > (This isn't a submission--I'm just posting this for comments.)
> > 
> > Right now, any large page that touches anywhere from PAGE_OFFSET to
> > __init_end is initially set up as a large, executable page... but
> > some of this area contains data & free pages.  The patch below adds a
> > "cleanup_nx_in_kerneltext()" function, called at the end of
> > free_initmem(), which changes these pages--except for the range from
> > "_text" to "_etext"--to PAGE_KERNEL (i.e., non-executable).     
> > 
> > This does result in two large pages being split up into small PTEs
> > permanently, but all the non-code regions will be non-executable, and
> > change_page_attr() will work correctly.  
> > 
> > What do you think of this?  I have tested this on 2.6.12.
> > 
> > (I've attached the patch as a file, too, since my mail server can't
> > be convinced to not wrap text.) 
> > 
> > Stuart
> > 
> 
> Andi--
> 
> I made another pass at this.  This does roughly the same thing, but it
> doesn't create the new "change_page_attr_perm()" functions.  With this
> patch, the change to init.c (cleanup_nx_in_kerneltext()) is optional.  I
> changed __change_page_attr() so that, if the page to be changed is part
> of a large executable page, it splits the page up *keeping the
> executability of the extra 511 pages*, and then marks the new PTE page
> as reserved so that it won't be reverted.
> 
> So, basically, without the changes to init.c, the NX bits for data in
> the first two big pages won't get fixed until someone calls
> change_page_attr() on them.  If NX is disabled, these patches have no
> functional effect at all.
> 
> How does this look?

If anything you would need to ask Ingo who did the i386 NX code (cc'ed) 

I personally wouldn't like doing this NX cleanup very late like you did 
but instead directly after the early NX setup.



> Thanks!
> Stuart
> 
> -----
> 
> diff -purN linux-2.6.12grep/arch/i386/mm/init.c
> linux-2.6.12/arch/i386/mm/init.c
> --- linux-2.6.12grep/arch/i386/mm/init.c	2005-07-01
> 15:09:27.000000000 -0500
> +++ linux-2.6.12/arch/i386/mm/init.c	2005-07-05 14:32:57.000000000
> -0500
> @@ -666,6 +666,28 @@ static int noinline do_test_wp_bit(void)
>  	return flag;
>  }
>  
> +/*
> + * In kernel_physical_mapping_init(), any big pages that contained
> kernel text area were
> + * set up as big executable pages.  This function should be called when
> the initmem
> + * is freed, to correctly set up the executable & non-executable pages
> in this area.
> + */
> +static void cleanup_nx_in_kerneltext(void)
> +{
> +	unsigned long from, to;
> +
> +	if (!nx_enabled) return;
> +
> +	from = PAGE_OFFSET;
> +	to = (unsigned long)_text & PAGE_MASK;
> +	for (; from<to; from += PAGE_SIZE)
> +		change_page_attr(virt_to_page(from), 1, PAGE_KERNEL); 
> +	
> +	from = ((unsigned long)_etext + PAGE_SIZE - 1) & PAGE_MASK;
> +	to = ((unsigned long)__init_end + LARGE_PAGE_SIZE) &
> LARGE_PAGE_MASK;
> +	for (; from<to; from += PAGE_SIZE)
> +		change_page_attr(virt_to_page(from), 1, PAGE_KERNEL); 
> +}
> +
>  void free_initmem(void)
>  {
>  	unsigned long addr;
> @@ -679,6 +701,8 @@ void free_initmem(void)
>  		totalram_pages++;
>  	}
>  	printk (KERN_INFO "Freeing unused kernel memory: %dk freed\n",
> (__init_end - __init_begin) >> 10);
> +
> +	cleanup_nx_in_kerneltext();
>  }
>  
>  #ifdef CONFIG_BLK_DEV_INITRD
> diff -purN linux-2.6.12grep/arch/i386/mm/pageattr.c
> linux-2.6.12/arch/i386/mm/pageattr.c
> --- linux-2.6.12grep/arch/i386/mm/pageattr.c	2005-07-01
> 15:09:08.000000000 -0500
> +++ linux-2.6.12/arch/i386/mm/pageattr.c	2005-07-05
> 14:44:53.000000000 -0500
> @@ -35,7 +35,8 @@ pte_t *lookup_address(unsigned long addr
>          return pte_offset_kernel(pmd, address);
>  } 
>  
> -static struct page *split_large_page(unsigned long address, pgprot_t
> prot)
> +static struct page *split_large_page(unsigned long address, pgprot_t
> prot, 
> +					pgprot_t ref_prot)
>  { 
>  	int i; 
>  	unsigned long addr;
> @@ -53,7 +54,7 @@ static struct page *split_large_page(uns
>  	pbase = (pte_t *)page_address(base);
>  	for (i = 0; i < PTRS_PER_PTE; i++, addr += PAGE_SIZE) {
>  		pbase[i] = pfn_pte(addr >> PAGE_SHIFT, 
> -				   addr == address ? prot :
> PAGE_KERNEL);
> +				   addr == address ? prot : ref_prot);
>  	}
>  	return base;
>  } 
> @@ -118,11 +119,30 @@ __change_page_attr(struct page *page, pg
>  	if (!kpte)
>  		return -EINVAL;
>  	kpte_page = virt_to_page(kpte);
> +
> +	/*
> +	 * If this page is part of a large page that's executable (and
> NX is
> +	 * enabled), then split page up and set new PTE page as reserved
> so
> +	 * we won't revert this back into a large page.  This should
> only
> +	 * happen in large pages that also contain kernel executable
> code,
> +	 * and shouldn't happen at all if init.c correctly sets up NX
> regions.
> +	 */
> +	if (nx_enabled && 
> +	    !(pte_val(*kpte) & _PAGE_NX) &&
> +	    (pte_val(*kpte) & _PAGE_PSE)) {
> +		struct page *split = split_large_page(address, prot,
> PAGE_KERNEL_EXEC); 
> +		if (!split)
> +			return -ENOMEM;
> +		set_pmd_pte(kpte,address,mk_pte(split,
> PAGE_KERNEL_EXEC));
> +		SetPageReserved(split);

Why setting reserved? I don't think cpa checks that anywhere.
In fact Nick has been working on getting rid of Reserved completely.


Anyways, isn't the code from x86-64 for this enough? It should 
work here too. I don't think such a ugly special case is needed.


-Andi

> +		return 0;
> +	}
> +
>  	if (pgprot_val(prot) != pgprot_val(PAGE_KERNEL)) { 
>  		if ((pte_val(*kpte) & _PAGE_PSE) == 0) { 
>  			set_pte_atomic(kpte, mk_pte(page, prot)); 
>  		} else {
> -			struct page *split = split_large_page(address,
> prot); 
> +			struct page *split = split_large_page(address,
> prot, PAGE_KERNEL); 
>  			if (!split)
>  				return -ENOMEM;
>  			set_pmd_pte(kpte,address,mk_pte(split,
> PAGE_KERNEL));


