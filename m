Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271034AbTHGWOI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 18:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271026AbTHGWOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 18:14:08 -0400
Received: from mail.kroah.org ([65.200.24.183]:60909 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S271034AbTHGWOC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 18:14:02 -0400
Date: Thu, 7 Aug 2003 15:14:12 -0700
From: Greg KH <greg@kroah.com>
To: long <tlnguyen@snoqualmie.dp.intel.com>
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net,
       jun.nakajima@intel.com, tom.l.nguyen@intel.com
Subject: Re: Updated MSI Patches
Message-ID: <20030807221411.GA13363@kroah.com>
References: <200308072125.h77LPKUN024461@snoqualmie.dp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308072125.h77LPKUN024461@snoqualmie.dp.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pcihpd-discuss?  Don't you mean the linux-pci mailing list instead?

A few initial comments on your patch:
 - Is there any way to dynamically detect if hardware can support MSI?
 - If you enable this option, will boxes that do not support it stop
   working?

A driver has to be modified to use this option, right?  Do you have any
drivers that have been modified?  Without that, I don't think we can
test this patch out, right?


> diff -X excludes -urN linux-2.6.0-test2/arch/i386/kernel/io_apic.c linux-2.6.0-test2-create-vectorbase/arch/i386/kernel/io_apic.c
> --- linux-2.6.0-test2/arch/i386/kernel/io_apic.c	2003-07-27 13:00:21.000000000 -0400
> +++ linux-2.6.0-test2-create-vectorbase/arch/i386/kernel/io_apic.c	2003-08-05 09:25:54.000000000 -0400

You are cluttering up this file with a lot of #ifdefs.  Is there any way
you can not do this?

Does this break the summit and/or NUMA builds?

> diff -X excludes -urN linux-2.6.0-test2/include/asm-i386/mach-default/irq_vectors.h linux-2.6.0-test2-create-vectorbase/include/asm-i386/mach-default/irq_vectors.h
> --- linux-2.6.0-test2/include/asm-i386/mach-default/irq_vectors.h	2003-07-27 12:58:54.000000000 -0400
> +++ linux-2.6.0-test2-create-vectorbase/include/asm-i386/mach-default/irq_vectors.h	2003-08-05 09:25:54.000000000 -0400
> @@ -76,9 +76,14 @@
>   * Since vectors 0x00-0x1f are used/reserved for the CPU,
>   * the usable vector space is 0x20-0xff (224 vectors)
>   */
> +#define NR_VECTORS 256

Will this _always_ be the value?  Can boxes have bigger numbers (I
haven't seen the spec, so I don't know...)

Care to add a comment about this value?

> diff -X excludes -urN linux-2.6.0-test2-create-vectorbase/arch/i386/kernel/i386_ksyms.c linux-2.6.0-test2-create-msi/arch/i386/kernel/i386_ksyms.c
> --- linux-2.6.0-test2-create-vectorbase/arch/i386/kernel/i386_ksyms.c	2003-07-27 13:11:42.000000000 -0400
> +++ linux-2.6.0-test2-create-msi/arch/i386/kernel/i386_ksyms.c	2003-08-05 09:45:25.000000000 -0400
> @@ -166,6 +166,11 @@
>  EXPORT_SYMBOL(IO_APIC_get_PCI_irq_vector);
>  #endif
>  
> +#ifdef CONFIG_PCI_MSI
> +EXPORT_SYMBOL(msix_alloc_vectors);
> +EXPORT_SYMBOL(msix_free_vectors);
> +#endif
> +
>  #ifdef CONFIG_MCA
>  EXPORT_SYMBOL(machine_id);
>  #endif

Put the EXPORT_SYMBOL in the files that have the functions.  Don't
clutter up the ksyms.c files anymore.



> +u32 device_nomsi_list[DRIVER_NOMSI_MAX] = {0, };

Shouldn't this be static?

> +u32 device_msi_list[DRIVER_NOMSI_MAX] = {0, };

Same with this one?


> +	base = (u32*)ioremap_nocache(phys_addr,
> +		dev_msi_cap*PCI_MSIX_ENTRY_SIZE*sizeof(u32));
> +	if (base == NULL) 
> +		goto free_region; 

...

> +	*base = address.lo_address.value;
> +	*(base + 1) = address.hi_address;
> +	*(base + 2) = *((u32*)&data);

Don't do direct writes to memory, use the proper function calls.  You do
this in a few other places too.

That's enough to get the conversation started :)

thanks,

greg k-h
