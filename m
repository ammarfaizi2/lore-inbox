Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271746AbTHHTeP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 15:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271750AbTHHTeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 15:34:14 -0400
Received: from fmr06.intel.com ([134.134.136.7]:16326 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S271746AbTHHTeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 15:34:08 -0400
Date: Fri, 8 Aug 2003 12:33:01 -0700
From: long <tlnguyen@snoqualmie.dp.intel.com>
Message-Id: <200308081933.h78JX12u025854@snoqualmie.dp.intel.com>
To: greg@kroah.com, tlnguyen@snoqualmie.dp.intel.com
Subject: Re: Updated MSI Patches
Cc: jun.nakajima@intel.com, linux-kernel@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net, tom.l.nguyen@intel.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>pcihpd-discuss?  Don't you mean the linux-pci mailing list instead?
pcihpd-discuss is my first assumption of what you mean the linux-pci mailing list. Please forward me the email address of the linux-pci mailing list.

> - Is there any way to dynamically detect if hardware can support MSI?
The MSI patch dynamically detects whether hardware devices can support MSI once the CONFIG_PCI_MSI is set during kernel built. By default, the CONFIG_PCI_MSI_ON_SPECIFIC_DEVICES is also set to provide users an option to enable MSI on specific devices with the use of boot parameter "device_msi=". With both CONFIG_PCI_MSI and CONFIG_PCI_MSI_ON_SPECIFIC_DEVICES set, the PCI subsystem dynamically detects if hardware devices can support MSI. However, enabling MSI on these devices is determined based on whether these devices are explicitly listed in the boot parameter "device_msi=". The reason is that users may not know how many MSI capable hardware devices are populated in their systems. The software device drivers of these devices may break their system once the patches are installed and users want the PCI subsystem to enable MSI automatically on all MSI capable devices. The second reason is that it may be difficult to debug all MSI capable devices at the same time. Users can de!
 bug on individual MSI capable device with its existing software driver. When all are fully validated, users can rebuild the kernel with the CONFIG_PCI_MSI_ON_SPECIFIC_DEVICES cleared; the PCI subsystem will enable MSI on all MSI capable devices automatically and the boot parameter "device_msi=" is no longer necessary.

> - If you enable this option, will boxes that do not support it stop
   working?
Once users enable this option, all devices that do not support MSI are still working. These devices are by default using IRQ pin assertion as interrupt generated mechanism since all pre-assigned vectors to any enabled IOxAPICs are reserved.

>A driver has to be modified to use this option, right?  Do you have any
>drivers that have been modified?  Without that, I don't think we can
>test this patch out, right?
MSI support may be transparent to some device drivers. This transparency is dependent on whether the existing driver can provide the hardware/software synchronization; that means, once the hardware/firmware of the device signals a Vector A, it cannot signal Vector A again until it is explicitly enabled to do so by its device driver. Such example of this transparency is the Intel Pro(R) Ethernet (10000 MBit> driver, which works with these patches without requiring any changes in the existing driver. The second driver we are validating is Adaptec AIC79XX PCI-X SCSI HBA driver (Rev 1.3.9). This existing software driver is tested as a module driver (such as mount/unmount /dev/sda2 /mnt/temp and then read/write to files to this device). However, if its hardware device is a boot device, then the results are unpredictable. We are currently working with the driver engineer to root cause the issues.


> diff -X excludes -urN linux-2.6.0-test2/arch/i386/kernel/io_apic.c linux-2.6.0-test2-create-vectorbase/arch/i386/kernel/io_apic.c
> --- linux-2.6.0-test2/arch/i386/kernel/io_apic.c	2003-07-27 13:00:21.000000000 -0400
> +++ linux-2.6.0-test2-create-vectorbase/arch/i386/kernel/io_apic.c	2003-08-05 09:25:54.000000000 -0400

>You are cluttering up this file with a lot of #ifdefs.  Is there any way
>you can not do this?
Agree. We will make appropriate changes in the next update release.

>Does this break the summit and/or NUMA builds?
We have not tested with these builds, I will add it to my list of builds to test. Thanks.

> diff -X excludes -urN linux-2.6.0-test2/include/asm-i386/mach-default/irq_vectors.h linux-2.6.0-test2-create-vectorbase/include/asm-i386/mach-default/irq_vectors.h
> --- linux-2.6.0-test2/include/asm-i386/mach-default/irq_vectors.h	2003-07-27 12:58:54.000000000 -0400
> +++ linux-2.6.0-test2-create-vectorbase/include/asm-i386/mach-default/irq_vectors.h	2003-08-05 09:25:54.000000000 -0400
> @@ -76,9 +76,14 @@
>   * Since vectors 0x00-0x1f are used/reserved for the CPU,
>   * the usable vector space is 0x20-0xff (224 vectors)
>   */
> +#define NR_VECTORS 256

>Will this _always_ be the value?  Can boxes have bigger numbers (I
>haven't seen the spec, so I don't know...)
Yes, this will always be 256 since the current CPU architecture supports a maximum of 256 vectors.

>Care to add a comment about this value?
Agree. Will add a comment about this value in the next update release.

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

>Put the EXPORT_SYMBOL in the files that have the functions.  Don't
>clutter up the ksyms.c files anymore.
Agree. Will put these EXPORT_SYMBOL(s) in the file ../include/asm-i386/hw_irq.h where these functions are declared as extern. Thanks.



> +u32 device_nomsi_list[DRIVER_NOMSI_MAX] = {0, };

>Shouldn't this be static?

> +u32 device_msi_list[DRIVER_NOMSI_MAX] = {0, };

>Same with this one?

In the initial design draft, I am thinking of defining DRIVER_NOMSI_MAX as 32 since it may be impossible to have more than 32 MSI capable devices populated in the same system. I will add some comments to it and look forward for your comments.

> +	base = (u32*)ioremap_nocache(phys_addr,
> +		dev_msi_cap*PCI_MSIX_ENTRY_SIZE*sizeof(u32));
> +	if (base == NULL) 
> +		goto free_region; 

...

> +	*base = address.lo_address.value;
> +	*(base + 1) = address.hi_address;
> +	*(base + 2) = *((u32*)&data);

>Don't do direct writes to memory, use the proper function calls.  You do
>this in a few other places too.
Thanks. I will replace all direct writes/reads with the proper functions calls such as writel()/readl().


thanks,
Long
