Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261441AbVCIDGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbVCIDGt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 22:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbVCIDGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 22:06:48 -0500
Received: from gate.crashing.org ([63.228.1.57]:16823 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261441AbVCIDGn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 22:06:43 -0500
Subject: Re: [PATCH 2/2] No-exec support for ppc64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jake Moilanen <moilanen@austin.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>
In-Reply-To: <20050308171326.3d72363a.moilanen@austin.ibm.com>
References: <20050308165904.0ce07112.moilanen@austin.ibm.com>
	 <20050308171326.3d72363a.moilanen@austin.ibm.com>
Content-Type: text/plain
Date: Wed, 09 Mar 2005 14:02:01 +1100
Message-Id: <1110337321.32556.26.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-08 at 17:13 -0600, Jake Moilanen wrote:

> diff -puN arch/ppc64/kernel/iSeries_setup.c~nx-kernel-ppc64 arch/ppc64/kernel/iSeries_setup.c
> --- linux-2.6-bk/arch/ppc64/kernel/iSeries_setup.c~nx-kernel-ppc64	2005-03-08 16:08:57 -06:00
> +++ linux-2.6-bk-moilanen/arch/ppc64/kernel/iSeries_setup.c	2005-03-08 16:08:57 -06:00
> @@ -624,6 +624,7 @@ static void __init iSeries_bolt_kernel(u
>  {
>  	unsigned long pa;
>  	unsigned long mode_rw = _PAGE_ACCESSED | _PAGE_COHERENT | PP_RWXX;
> +	unsigned long tmp_mode;
>  	HPTE hpte;
>  
>  	for (pa = saddr; pa < eaddr ;pa += PAGE_SIZE) {
> @@ -632,6 +633,12 @@ static void __init iSeries_bolt_kernel(u
>  		unsigned long va = (vsid << 28) | (pa & 0xfffffff);
>  		unsigned long vpn = va >> PAGE_SHIFT;
>  		unsigned long slot = HvCallHpt_findValid(&hpte, vpn);
> +
> +		tmp_mode = mode_rw;
> +
> +		/* Make non-kernel text non-executable */
> +		if (!is_kernel_text(ea))
> +			tmp_mode = mode_rw | HW_NO_EXEC;
>  
>  		if (hpte.dw0.dw0.v) {
>  			/* HPTE exists, so just bolt it */

tmp_mode doesn't seem to be ever used here ...

>  /* Free memory returned from module_alloc */
> diff -puN arch/ppc64/mm/fault.c~nx-kernel-ppc64 arch/ppc64/mm/fault.c
> --- linux-2.6-bk/arch/ppc64/mm/fault.c~nx-kernel-ppc64	2005-03-08 16:08:57 -06:00
> +++ linux-2.6-bk-moilanen/arch/ppc64/mm/fault.c	2005-03-08 16:08:57 -06:00
> @@ -76,6 +76,21 @@ static int store_updates_sp(struct pt_re
>  	return 0;
>  }
>  
> +pte_t *lookup_address(unsigned long address) 
> +{ 
> +	pgd_t *pgd = pgd_offset_k(address); 
> +	pmd_t *pmd;
> +
> +	if (pgd_none(*pgd))
> +		return NULL;
> +
> +	pmd = pmd_offset(pgd, address); 	       
> +	if (pmd_none(*pmd))
> +		return NULL;
> +
> +        return pte_offset_kernel(pmd, address);
> +} 

Use find_linux_pte() here (asm-ppc64/pgtable.h). It will return NULL of
the PTE is not present too, so no need to dbl check that. That way, I
won't have to fix your copy of the function when I get the proper 4L
headers patch in ;)

>  /*
>   * The error_code parameter is
>   *  - DSISR for a non-SLB data access fault,
> @@ -94,6 +109,7 @@ int do_page_fault(struct pt_regs *regs, 
>  	unsigned long is_write = error_code & 0x02000000;
>  	unsigned long trap = TRAP(regs);
>   	unsigned long is_exec = trap == 0x400;	
> +	pte_t *ptep;
>  
>  	BUG_ON((trap == 0x380) || (trap == 0x480));
>  
> @@ -253,6 +269,15 @@ bad_area_nosemaphore:
>  		info.si_addr = (void __user *) address;
>  		force_sig_info(SIGSEGV, &info, current);
>  		return 0;
> +	} 
> +
> +	ptep = lookup_address(address);
> +
> +	if (ptep && pte_present(*ptep) && !pte_exec(*ptep)) {
> +		if (printk_ratelimit())
> +			printk(KERN_CRIT "kernel tried to execute NX-protected page - exploit attempt? (uid: %d)\n", current->uid);
> +		show_stack(current, (unsigned long *)__get_SP());
> +		do_exit(SIGKILL);
>  	}

Can you try to limit to 80 columns ? (I know, I'm not the best for that
neither, but I'm trying to cure myself here, I promise my next rewrite
of radeonfb will be fully 80-columns safe :)
 



