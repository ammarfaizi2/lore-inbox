Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266232AbUBRQO4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 11:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266652AbUBRQO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 11:14:56 -0500
Received: from mail3.iserv.net ([204.177.184.153]:31123 "EHLO mail3.iserv.net")
	by vger.kernel.org with ESMTP id S266232AbUBRQOw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 11:14:52 -0500
Message-ID: <40338F51.1030502@didntduck.org>
Date: Wed, 18 Feb 2004 11:14:09 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <willy@debian.org>
CC: Sundarapandian Durairaj <sundarapandian.durairaj@intel.com>,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@zip.com.au>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Expanded PCI config space (against 2.6.3-rc4)
References: <20040217163744.GU31168@parcelfarce.linux.theplanet.co.uk> <20040218142141.GK11824@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040218142141.GK11824@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> Updated for 2.6.3, and reinserted an ifdef I had thought was
> unnecessary.
> 
> Patch against 2.6.3 for implementing extended PCI configuration space.
> 
>  - Enables MMCONFIG space on i386.
>    - Move the acpi apic cruft into its own function on i386.
>  - Uses the extended SAL call on ia64.
>  - Makes the extended config space available through sysfs & proc.
>  - Adds pci_find_ext_capability() to find extended capabilities.
>  - Adds definitions for some of the extended capabilities.
>  - Adds pci_cfg_space_size() to determine whether a given device supports
>    extended PCI config space.
>    - Now handles both Express and PCI-X 2 devices.
>  - Changes the PCI-X capability definitions to correspond to the spec.
>    No current users in-tree.
> 
> Patch by Sundarapandian Durairaj and Matthew Wilcox
> 

[SNIP]

> diff -urpNX build-tools/dontdiff linus-2.6/arch/ia64/pci/pci.c pciexp-2.6/arch/ia64/pci/pci.c
> --- linus-2.6/arch/ia64/pci/pci.c	2004-02-06 16:11:36.000000000 -0500
> +++ pciexp-2.6/arch/ia64/pci/pci.c	2004-02-06 16:02:47.000000000 -0500
> @@ -55,8 +55,11 @@ struct pci_fixup pcibios_fixups[1];
>  
>  #define PCI_SAL_ADDRESS(seg, bus, devfn, reg) \
>  	((u64)(seg << 24) | (u64)(bus << 16) | \
> -	 (u64)(devfn << 8) | (u64)(reg))
> +	 (u64)(devfn << 8) | (u64)(reg)), 0
>  
> +#define PCI_SAL_EXT_ADDRESS(seg, bus, devfn, reg) \
> +	((u64)(seg << 28) | (u64)(bus << 20) | \
> +	 (u64)(devfn << 12) | (u64)(reg)), 1
>  
>  static int
>  pci_sal_read (int seg, int bus, int devfn, int reg, int len, u32 *value)
> @@ -64,10 +67,14 @@ pci_sal_read (int seg, int bus, int devf
>  	int result = 0;
>  	u64 data = 0;
>  
> -	if (!value || (seg > 255) || (bus > 255) || (devfn > 255) || (reg > 255))
> +	if (!value || (seg > 65535) || (bus > 255) || (devfn > 255) || (reg > 4095))
>  		return -EINVAL;
>  
> -	result = ia64_sal_pci_config_read(PCI_SAL_ADDRESS(seg, bus, devfn, reg), len, &data);
> +	if ((seg < 256) && (reg < 256)) {
> +		result = ia64_sal_pci_config_read(PCI_SAL_ADDRESS(seg, bus, devfn, reg), len, &data);
> +	} else {
> +		result = ia64_sal_pci_config_read(PCI_SAL_EXT_ADDRESS(seg, bus, devfn, reg), len, &data);
> +	}
>  
>  	*value = (u32) data;
>  
> @@ -77,13 +84,17 @@ pci_sal_read (int seg, int bus, int devf
>  static int
>  pci_sal_write (int seg, int bus, int devfn, int reg, int len, u32 value)
>  {
> -	if ((seg > 255) || (bus > 255) || (devfn > 255) || (reg > 255))
> +	if ((seg > 65535) || (bus > 255) || (devfn > 255) || (reg > 4095))
>  		return -EINVAL;
>  
> -	return ia64_sal_pci_config_write(PCI_SAL_ADDRESS(seg, bus, devfn, reg), len, value);
> +	if ((seg < 256) && (reg < 256)) {
> +		return ia64_sal_pci_config_write(PCI_SAL_ADDRESS(seg, bus, devfn, reg), len, value);
> +	} else {
> +		return ia64_sal_pci_config_write(PCI_SAL_EXT_ADDRESS(seg, bus, devfn, reg), len, value);
> +	}
>  }
>  
> -struct pci_raw_ops pci_sal_ops = {
> +static struct pci_raw_ops pci_sal_ops = {
>  	.read = 	pci_sal_read,
>  	.write =	pci_sal_write
>  };

Having PCI_SAL_*ADDRESS() return 2 values is counter-intuituitive, since 
it looks like a normal function call.  Just add the type flag to the 
ia64_sal_pci_config_* call directly.

--
				Brian Gerst
