Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbUAANGz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 08:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbUAANFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 08:05:39 -0500
Received: from pD9E56CE4.dip.t-dialin.net ([217.229.108.228]:23685 "EHLO
	fred.muc.de") by vger.kernel.org with ESMTP id S261500AbUAANFO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 08:05:14 -0500
To: "Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com>
Cc: "Seshadri, Harinarayanan" <harinarayanan.seshadri@intel.com>,
       "Kondratiev, Vladimir" <vladimir.kondratiev@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] PCI Express Enhanced Config Patch - 2.6.0-test11
From: Andi Kleen <ak@muc.de>
Date: Mon, 29 Dec 2003 20:12:39 +0100
In-Reply-To: <183UK-2Re-11@gated-at.bofh.it> ("Durairaj, Sundarapandian"'s
 message of "Mon, 29 Dec 2003 12:40:10 +0100")
Message-ID: <m3hdzjxwt4.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <183UK-2Re-11@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com> writes:

> +u32 pcie_last_accessed_device;
> +
> +unsigned long pci_exp_set_dev_base (int bus, int dev, int fn)
> +{
> +	u32 dev_base = 
> +		mmcfg_base_address | (bus << 20) | ((PCI_DEVFN (dev,fn))
> <<12);
> +	if (dev_base != pcie_last_accessed_device){
> +		pcie_last_accessed_device = dev_base;
> +		set_fixmap (FIX_PCIE_MCFG, dev_base);
> +	}

Can you please put the details on how the fixmap is managed into
an asm-i386/* file. x86-64 shares the i386 PCI subsystem and I would
like to use a different implement a different method there (just mapping 
everything statically) 

> +}
> +
> +static int pci_express_conf_read(int seg, int bus, int devfn, int reg,
> int len, u32 *value)
> +{
> +	 unsigned long flags;
> +	 unsigned long base_address;
> +	 char * virt_addr;
> +	 int dev = PCI_SLOT (devfn);
> +	 int fn  = PCI_FUNC (devfn);
> + 
> +  if (!value || ((u32)bus > 255) || ((u32)dev > 31) || ((u32)fn > 7) ||
> ((u32)reg > 4095))
> +  	return -EINVAL;
> +
> +	/* Shoot misalligned transaction now */
> +	if (reg & (len-1))
> +  	return -EINVAL;

It would be better to printk here because nobody will check the return
value of this function

Same for _write.

> +			writew(value,(unsigned long)virt_addr+reg);
> +       		        break;
> +	        case 4:
> +			writel(value,(unsigned long)virt_addr+reg);
> +	                break;
> +     	}
> + 	/* Dummy read to flush PCI write */
> +	readl (virt_addr);

I thought the consensus was that reading the same address is dangerous
because some registers react when they are only read.
Also you cannot readl on a w or b registers, if you do that you would
need to use the same size.

Also are you sure that the old port based config read/write functions
actually flushed their writes? I don't think they did.  It probably
would be best to just drop that read.

Otherwise it should read some save register in the same mapping.


> +	 if( is_pci_exp_platform() != 0){

Shouldn't there a pci_probe option for this here?

It would be probably better to add some way to turn this off at runtime,
since it's still experimental and most drivers will probably work
with the old methods for now.

>  
>  	if (capable(CAP_SYS_ADMIN))
> -		size = PCI_CFG_SPACE_SIZE;
> +#ifdef CONFIG_PCI_EXP_ENHANCED
> +		if (pci_find_capability(dev,PCI_CAP_ID_EXP))
> +			size = PCI_CFG_SPACE_EXP_SIZE;
> +		else
> +#endif /*CONFIG_PCI_EXP_ENHANCED */
> + 		size = PCI_CFG_SPACE_SIZE;

This would be somewhat cleaner in an standard function that returns
the cfg space size for a device, especially since this code is often duplicated
in your patch.


> +#ifdef CONFIG_PCI_EXP_ENHANCED
> +struct acpi_table_mcfg {
> +	struct acpi_table_header 	header;
> +	u8	reserved[8];
> +	u64	base_address;
> +} __attribute__ ((packed));
> +#endif

Declarations don't need to be #ifdefed.

-Andi
