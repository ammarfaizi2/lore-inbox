Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271156AbTHHCsI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 22:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271161AbTHHCsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 22:48:08 -0400
Received: from [66.212.224.118] ([66.212.224.118]:24082 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S271156AbTHHCsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 22:48:04 -0400
Date: Thu, 7 Aug 2003 22:36:16 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: long <tlnguyen@snoqualmie.dp.intel.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       pcihpd-discuss@lists.sourceforge.net,
       "Nakajima, Jun" <jun.nakajima@intel.com>, tom.l.nguyen@intel.com
Subject: Re: Updated MSI Patches
In-Reply-To: <200308072125.h77LPKUN024461@snoqualmie.dp.intel.com>
Message-ID: <Pine.LNX.4.53.0308072148420.12875@montezuma.mastecende.com>
References: <200308072125.h77LPKUN024461@snoqualmie.dp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Aug 2003, long wrote:

> - Change the interface name from msi_free_vectors to msix_free_vectors since 
> this interface is used for MSI-X device drivers, which request for releasing 
> the number of vector back to the PCI subsystem.
> - Change the function name from remove_hotplug_vectors to 
> msi_remove_pci_irq_vectors to have a close match with function name 
> msi_get_pci_irq_vector.

I think the vector allocator code can all be arch specific generic, 
there is no particular reason as to why it has to be MSI specific.

> diff -X excludes -urN linux-2.6.0-test2/arch/i386/kernel/io_apic.c linux-2.6.0-test2-create-vectorbase/arch/i386/kernel/io_apic.c
> --- linux-2.6.0-test2/arch/i386/kernel/io_apic.c	2003-07-27 13:00:21.000000000 -0400
> +++ linux-2.6.0-test2-create-vectorbase/arch/i386/kernel/io_apic.c	2003-08-05 09:25:54.000000000 -0400
> @@ -76,6 +76,20 @@
>  	int apic, pin, next;
>  } irq_2_pin[PIN_MAP_SIZE];
>  
> +#ifdef CONFIG_PCI_USE_VECTOR
> +int vector_irq[NR_IRQS] = { [0 ... NR_IRQS -1] = -1};
> + 
> +static int platform_irq(int irq) 	
> +{ 	
> +	if (platform_legacy_irq(irq))
> +		return irq;
> +	else
> +		return vector_irq[irq];
> +}
> +#else
> +#define platform_irq(irq)	(irq)
> +#endif 

I wish you wouldn't mix up vector and irq like this :( This is really 
beginning to look like IPF. When is an irq an irq and when is a vector a 
vector? This can get very confusing very quickly. I spent a fair 
amount of time debugging this last time due to the confusion in the 
common_interrupt -> do_IRQ path, i'd hate for this to be a permanent 
fixture. If you're going to change things just change everything 
(including variable names) instead of making it conditional.

> diff -X excludes -urN linux-2.6.0-test2-create-vectorbase/arch/i386/kernel/io_apic.c linux-2.6.0-test2-create-msi/arch/i386/kernel/io_apic.c
> --- linux-2.6.0-test2-create-vectorbase/arch/i386/kernel/io_apic.c	2003-08-05 09:25:54.000000000 -0400
> +++ linux-2.6.0-test2-create-msi/arch/i386/kernel/io_apic.c	2003-08-05 09:45:25.000000000 -0400
> @@ -427,6 +427,11 @@
>  			/* Is this an active IRQ? */
>  			if (!irq_desc[j].action)
>  				continue;
> +#ifdef CONFIG_PCI_MSI
> +			/* Is this an active MSI? */
> +			if (msi_desc[j])
> +				continue;
> +#endif

Is there any locking for msi_desc? Or are you relying on something else?

> +static int nr_alloc_vectors = 0;
> +static int nr_released_vectors = 0;

No need to initialise to 0 it'll be done for you when .bss gets zeroed.

> +	if (current_vector == FIRST_SYSTEM_VECTOR) 
> +		panic("ran out of interrupt sources!");

Please just fail and return -ENOSPC or something like that.

Besides my whining thanks for cranking this out.

	Zwane

