Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270988AbTHLREt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 13:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270993AbTHLREt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 13:04:49 -0400
Received: from fmr06.intel.com ([134.134.136.7]:33785 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S270988AbTHLREr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 13:04:47 -0400
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: Updated MSI Patches
Date: Tue, 12 Aug 2003 10:04:34 -0700
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E5024015416F5@orsmsx404.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Updated MSI Patches
Thread-Index: AcNdV46j8n1k/hsTRviUMWrHuVVi+ADmsMaA
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Zwane Mwaikambo" <zwane@arm.linux.org.uk>
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "long" <tlnguyen@snoqualmie.dp.intel.com>
X-OriginalArrivalTime: 12 Aug 2003 17:04:35.0245 (UTC) FILETIME=[CE6375D0:01C360F3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

> I wish you wouldn't mix up vector and irq like this :( This is really 
> beginning to look like IPF. When is an irq an irq and when is a vector a 
> vector? This can get very confusing very quickly. I spent a fair 
> amount of time debugging this last time due to the confusion in the 
> common_interrupt -> do_IRQ path, i'd hate for this to be a permanent 
> fixture. If you're going to change things just change everything 
> (including variable names) instead of making it conditional.
I understand that mixing up vector and irq is very confusing. However, to support non-PCI legacy devices with IRQ less than 16, such as keyboard and mouse for example, may be impossilbe to achieve without mixing up. Some existing driver of legacy keyboard/mouse devices, for example, may use fixed IO ranges and fixed IRQs (as assigned to 1 for keyboard and 12 for mouse). If these device drivers use these fixed legacy IRQs and the interrupt routings for these non-PCI legacy devices use vectors, then the system may break. As you know, MSI support requires vector allocation instead of IRQ allocation since MSI does not require a support of BIOS IRQ table. Mixing vector with IRQ to be compatible with non-PCI legacy devices must be achieved. Last time, your suggestion of changing variable name from irq to vector is the good approach. I am looking at restructuring the code of the vector-base patch. I will send you an update when I am done for your feedback.

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

> Is there any locking for msi_desc? Or are you relying on something else?
Since the code determinces whether this entry is NULL or not, I think any locking for msi_desc may not be required.


> +	if (current_vector == FIRST_SYSTEM_VECTOR) 
> +		panic("ran out of interrupt sources!");

> Please just fail and return -ENOSPC or something like that.
Good. Thanks!

Thanks,
Long

