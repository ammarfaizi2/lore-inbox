Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261862AbVDKSAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbVDKSAX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 14:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbVDKSAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 14:00:23 -0400
Received: from cantor2.suse.de ([195.135.220.15]:64900 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261862AbVDKSAF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 14:00:05 -0400
Date: Mon, 11 Apr 2005 20:00:01 +0200
From: Andi Kleen <ak@suse.de>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: Andi Kleen <ak@suse.de>, akpm@osdl.org, discuss@x86-64.org,
       davej@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [discuss] [21/31] x86_64: Always use CPUID 80000008 to figure out MTRR address space size
Message-ID: <20050411180001.GA27367@wotan.suse.de>
References: <425554EC.mailMV61WIBOM@suse.de> <20050410232523.B24470@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050410232523.B24470@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10, 2005 at 11:25:23PM -0700, Siddha, Suresh B wrote:
> We need to use the size_and_mask in set_mtrr_var_ranges(which is called 
> while programming MTRR's for AP's

Patch is ok for me. But how did you find this out? Did you force
a mapping high in the address space?

-Andi
> 
> Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
> 
> --- linux/arch/i386/kernel/cpu/mtrr/generic.c~	2005-04-10 14:07:11.821466664 -0700
> +++ linux/arch/i386/kernel/cpu/mtrr/generic.c	2005-04-10 14:12:21.913325536 -0700
> @@ -192,7 +192,8 @@ static int set_mtrr_var_ranges(unsigned 
>  
>  	rdmsr(MTRRphysBase_MSR(index), lo, hi);
>  	if ((vr->base_lo & 0xfffff0ffUL) != (lo & 0xfffff0ffUL)
> -	    || (vr->base_hi & 0xfUL) != (hi & 0xfUL)) {
> +	    || (vr->base_hi & (size_and_mask >> (32 - PAGE_SHIFT))) != 
> +		(hi & (size_and_mask >> (32 - PAGE_SHIFT)))) {
>  		mtrr_wrmsr(MTRRphysBase_MSR(index), vr->base_lo, vr->base_hi);
>  		changed = TRUE;
>  	}
> @@ -200,7 +201,8 @@ static int set_mtrr_var_ranges(unsigned 
>  	rdmsr(MTRRphysMask_MSR(index), lo, hi);
>  
>  	if ((vr->mask_lo & 0xfffff800UL) != (lo & 0xfffff800UL)
> -	    || (vr->mask_hi & 0xfUL) != (hi & 0xfUL)) {
> +	    || (vr->mask_hi & (size_and_mask >> (32 - PAGE_SHIFT))) != 
> +		(hi & (size_and_mask >> (32 - PAGE_SHIFT)))) {
>  		mtrr_wrmsr(MTRRphysMask_MSR(index), vr->mask_lo, vr->mask_hi);
>  		changed = TRUE;
>  	}
> 
> On Thu, Apr 07, 2005 at 05:42:36PM +0200, Andi Kleen wrote:
> > Always use CPUID 80000008 to figure out MTRR address space size
> > 
> > It doesn't make sense to only do this only for AMD K8.
> > 
> > This would support future CPUs with extended address spaces properly.
> > 
> > For i386 and x86-64
> > 
> > Cc: davej@redhat.com
> > 
> > 
> > Index: linux/arch/i386/kernel/cpu/mtrr/main.c
> > ===================================================================
> > --- linux.orig/arch/i386/kernel/cpu/mtrr/main.c
> > +++ linux/arch/i386/kernel/cpu/mtrr/main.c
> > @@ -614,40 +614,21 @@ static int __init mtrr_init(void)
> >  		mtrr_if = &generic_mtrr_ops;
> >  		size_or_mask = 0xff000000;	/* 36 bits */
> >  		size_and_mask = 0x00f00000;
> > -			
> > -		switch (boot_cpu_data.x86_vendor) {
> > -		case X86_VENDOR_AMD:
> > -			/* The original Athlon docs said that
> > -			   total addressable memory is 44 bits wide.
> > -			   It was not really clear whether its MTRRs
> > -			   follow this or not. (Read: 44 or 36 bits).
> > -			   However, "x86-64_overview.pdf" explicitly
> > -			   states that "previous implementations support
> > -			   36 bit MTRRs" and also provides a way to
> > -			   query the width (in bits) of the physical
> > -			   addressable memory on the Hammer family.
> > -			 */
> > -			if (boot_cpu_data.x86 == 15
> > -			    && (cpuid_eax(0x80000000) >= 0x80000008)) {
> > -				u32 phys_addr;
> > -				phys_addr = cpuid_eax(0x80000008) & 0xff;
> > -				size_or_mask =
> > -				    ~((1 << (phys_addr - PAGE_SHIFT)) - 1);
> > -				size_and_mask = ~size_or_mask & 0xfff00000;
> > -			}
> > -			/* Athlon MTRRs use an Intel-compatible interface for 
> > -			 * getting and setting */
> > -			break;
> > -		case X86_VENDOR_CENTAUR:
> > -			if (boot_cpu_data.x86 == 6) {
> > -				/* VIA Cyrix family have Intel style MTRRs, but don't support PAE */
> > -				size_or_mask = 0xfff00000;	/* 32 bits */
> > -				size_and_mask = 0;
> > -			}
> > -			break;
> > -		
> > -		default:
> > -			break;
> > +	
> > +		/* This is an AMD specific MSR, but we assume(hope?) that
> > +		   Intel will implement it to when they extend the address
> > +		   bus of the Xeon. */		
> > +		if (cpuid_eax(0x80000000) >= 0x80000008) {
> > +			u32 phys_addr;
> > +			phys_addr = cpuid_eax(0x80000008) & 0xff;
> > +			size_or_mask = ~((1 << (phys_addr - PAGE_SHIFT)) - 1);
> > +			size_and_mask = ~size_or_mask & 0xfff00000;
> > +		} else if (boot_cpu_data.x86_vendor == X86_VENDOR_CENTAUR &&
> > +			   boot_cpu_data.x86 == 6) {
> > +			/* VIA C* family have Intel style MTRRs, but
> > +			   don't support PAE */
> > +			size_or_mask = 0xfff00000;	/* 32 bits */
> > +			size_and_mask = 0;
> >  		}
> >  	} else {
> >  		switch (boot_cpu_data.x86_vendor) {
