Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268314AbTCAA0X>; Fri, 28 Feb 2003 19:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268335AbTCAA0X>; Fri, 28 Feb 2003 19:26:23 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:9152 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S268314AbTCAA0U>; Fri, 28 Feb 2003 19:26:20 -0500
Date: Fri, 28 Feb 2003 16:44:49 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: PCI and MWI
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <3E600281.2050805@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <3E4622B0.7040201@pobox.com>
 <20030210151813.B12043@jurassic.park.msu.ru> <3E47DF75.20801@pacbell.net>
 <3E5B1C08.6030906@pacbell.net> <3E5C2368.6010502@pobox.com>
 <20030226160403.A15729@jurassic.park.msu.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Kokshaysky wrote:
> 
> Well, here's some updated bits for 2.5. It's attempt to fix
> x86 PCI cacheline size. Completely untested, someone with better
> knowledge of x86 CPUs ought to verify this...

It worked for me on K7/Tbred and P6/Coppermine.  No more messages
at driver init about nassty stupd BIOS, or new problems.

But I think the arch code is wrong for CPUs like i386 and i486;
I recall at least one of them having 16 byte cachelines.  PCI
gets used with those, yes?  I wonder if it might not be best to
have cpuinfo_x86 store that value; people don't really expect
to see cpu-specific logic in the pci code.

One minor curiousity:  a multifunction device seemed to share
PCI_CACHE_LINE_SIZE between the enabled/active function and ones
without a driver.  Makes sense, the values can never legally
differ, but some more troublesome devices don't do that...

Re Jeff's suggestion to merge this to 2.5 ASAP, sounds right
to me if all the arch code gets worked out up front.  I have
no problem with the idea of enabling it as done here (when
the device is enabled) rather than waiting to enable DMA,
though I'd certainly pay attention to people who know about
devices broken enough to get indigestion that way.

- Dave



> Ivan.
> 
> --- 2.5.63/drivers/pci/pci.c	Mon Feb 24 22:05:14 2003
> +++ linux/drivers/pci/pci.c	Wed Feb 26 15:08:34 2003
> @@ -327,6 +327,8 @@ pci_restore_state(struct pci_dev *dev, u
>  	return 0;
>  }
>  
> +u8 pci_cache_line_size = L1_CACHE_BYTES >> 2;
> +
>  /**
>   * pci_enable_device_bars - Initialize some of a device for use
>   * @dev: PCI device to be initialized
> @@ -343,6 +345,9 @@ pci_enable_device_bars(struct pci_dev *d
>  	int err;
>  
>  	pci_set_power_state(dev, 0);
> +
> +	pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE, pci_cache_line_size);
> +
>  	if ((err = pcibios_enable_device(dev, bars)) < 0)
>  		return err;
>  	return 0;
> @@ -597,7 +602,6 @@ pci_set_master(struct pci_dev *dev)
>  static int
>  pci_generic_prep_mwi(struct pci_dev *dev)
>  {
> -	int rc = 0;
>  	u8 cache_size;
>  
>  	/*
> @@ -607,22 +611,13 @@ pci_generic_prep_mwi(struct pci_dev *dev
>  	 * line set at boot time, the other will not.
>  	 */
>  	pci_read_config_byte(dev, PCI_CACHE_LINE_SIZE, &cache_size);
> -	cache_size <<= 2;
> -	if (cache_size != SMP_CACHE_BYTES) {
> -		printk(KERN_WARNING "PCI: %s PCI cache line size set "
> -		       "incorrectly (%i bytes) by BIOS/FW, ",
> -		       dev->slot_name, cache_size);
> -		if (cache_size > SMP_CACHE_BYTES) {
> -			printk("expecting %i\n", SMP_CACHE_BYTES);
> -			rc = -EINVAL;
> -		} else {
> -			printk("correcting to %i\n", SMP_CACHE_BYTES);
> -			pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE,
> -					      SMP_CACHE_BYTES >> 2);
> -		}
> -	}
> +	if (cache_size == pci_cache_line_size)
> +		return 0;
> +
> +	printk(KERN_WARNING "PCI: cache line size of %d is not supported "
> +	       "by device %s\n", pci_cache_line_size << 2, dev->slot_name);
>  
> -	return rc;
> +	return -EINVAL;
>  }
>  #endif /* !HAVE_ARCH_PCI_MWI */
>  
> --- 2.5.63/arch/i386/pci/common.c	Mon Feb 24 22:05:16 2003
> +++ linux/arch/i386/pci/common.c	Wed Feb 26 15:41:51 2003
> @@ -125,12 +125,22 @@ struct pci_bus * __devinit pcibios_scan_
>  	return pci_scan_bus(busnum, pci_root_ops, NULL);
>  }
>  
> +extern u8 pci_cache_line_size;
> +
>  static int __init pcibios_init(void)
>  {
> +	struct cpuinfo_x86 *c = &boot_cpu_data;
> +
>  	if (!pci_root_ops) {
>  		printk("PCI: System does not support PCI\n");
>  		return 0;
>  	}
> +
> +	pci_cache_line_size = 32 >> 2;
> +	if (c->x86 >= 6 && c->x86_vendor == X86_VENDOR_AMD)
> +		pci_cache_line_size = 64 >> 2;	/* K7 & K8 */
> +	else if (c->x86 > 6)
> +		pci_cache_line_size = 128 >> 2;	/* P4 */
>  
>  	pcibios_resource_survey();
>  
> 



