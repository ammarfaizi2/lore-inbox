Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266260AbUAVNNU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 08:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266261AbUAVNNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 08:13:20 -0500
Received: from colin2.muc.de ([193.149.48.15]:35335 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S266260AbUAVNNQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 08:13:16 -0500
Date: 22 Jan 2004 14:12:58 +0100
Date: Thu, 22 Jan 2004 14:12:58 +0100
From: Andi Kleen <ak@colin2.muc.de>
To: "Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       torvalds@osdl.org, alan@lxorguk.ukuu.org.uk, greg@kroah.com,
       "Kondratiev, Vladimir" <vladimir.kondratiev@intel.com>,
       "Seshadri, Harinarayanan" <harinarayanan.seshadri@intel.com>
Subject: Re: [patch] PCI Express Enhanced Config Patch - 2.6.0-test11
Message-ID: <20040122131258.GA84577@colin2.muc.de>
References: <6B09584CC3D2124DB45C3B592414FA83011A3357@bgsmsx402.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6B09584CC3D2124DB45C3B592414FA83011A3357@bgsmsx402.gar.corp.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 22, 2004 at 03:51:22PM +0530, Durairaj, Sundarapandian wrote:
> Please review this and send in your comments.

Looks better now. Still a few nitpicks.

> +	  access mechanism (Will work only on PCI Express based system)
> +	  otherwise the pci direct mechanism will be used.

Is that true? It won't use PCI BIOS anymore?  If true this looks not
right.

>  	return ((unsigned char *) base + offset);
>  }
>  
> +#ifdef CONFIG_PCI_EXPRESS
> +extern u32 mmcfg_base_address;

Please put that into some header.

> +{
> +	struct acpi_table_mcfg	*mcfg = NULL;
> +
> +	if (!phys_addr || !size)
> +		return -EINVAL;
> +
> +	mcfg = (struct acpi_table_mcfg *) __acpi_map_table
> +						(phys_addr, size);
> +	if (!mcfg) {
> +		printk(KERN_WARNING PREFIX "Unable to map MCFG\n");
> +		return -ENODEV;
> +	}
> +	if (mcfg->base_address)
> +		mmcfg_base_address = (u32)mcfg->base_address;
> +	printk(KERN_INFO PREFIX "Local  mcfg address %p\n",
> +			mcfg->base_address);

Better drop that printk. It's probably not needed and ACPI is already
too noisy.


> +	}
> +	else if (result < 0) {
> +		printk(KERN_ERR PREFIX "Error parsing MCFG\n");
> +		return result;
> +	}
> +	else if (result > 1) {
> +		printk(KERN_WARNING PREFIX \

The \ is not needed.

>  		return NULL;
>  	}
>  #endif
> +#ifdef CONFIG_PCI_EXPRESS
> +	else if (!strcmp(str, "no_pcie")) {

Would "no_pciexp" be better? no_pcie looks nearly like a typo.

> +	/* Shoot misalligned transaction now */
> +	if (reg & (len-1)){
> +		printk(KERN_ERR "pci_express_conf_read: \
> +					misalligned transaction\n");

misaligned is spelled with one l only (occurs a few more times)

> +#ifdef CONFIG_PCI_EXPRESS
> +	if ((pci_probe & PCI_PROBE_ENHANCED) == 0)
> +		goto type1;
> +	/*
> + 	 *Check if platform we are running is pci express capable

Please always add a space between the * and the text (occurs also a few
more times) 

> +  	 */
> +	if (mmcfg_base_address == 0){
> +		printk(KERN_INFO 
> +		      "MCFG table entry is not found in ACPI
> tables....\n \
> +		       PCI Express not supported in this platform....\n

on this platform

> +#ifdef CONFIG_PCI_EXPRESS
> +/*
> + *Variable used to store the base address of the last pciexpress device
> + *accessed.
> + */
> +static u32 pcie_last_accessed_device;

static in a header is a bad idea. Make this a global, defined in some file.

> +static __inline__ void pci_exp_set_dev_base (int bus, int devfn)
> +{
> +	u32 dev_base = 
> +		mmcfg_base_address | (bus << 20) | (devfn << 12);
> +	if (dev_base != pcie_last_accessed_device){
> +		pcie_last_accessed_device = dev_base;
> +		set_fixmap (FIX_PCIE_MCFG, dev_base);
> +	}
> +}
> +
> +static __inline__ void pci_express_read(int bus, int devfn, int reg, 
> +		int len, u32 *value)
> +{
> +	unsigned long flags;
> +	spin_lock_irqsave(&pci_config_lock, flags);
> +	pci_exp_set_dev_base(bus, devfn);

You could share/uninline the read/write functions when you made the interface
something like

	void *map_addr = pci_exp_map_dev_base(bus, devfn);

	... use map_addr... for the access

Having them inline doesn't make much sense anyways because they should
be accessed using function pointers.

> +	/* Dummy read to flush PCI write */
> +	readl (mmcfg_virt_addr);
> +	spin_unlock_irqrestore(&pci_config_lock, flags);

And move the spin lock/unlock into a inline too. Then an 64bit 
implementation can just define it as a dummy (not needed when
everything is statically mapped) 

-Andi
