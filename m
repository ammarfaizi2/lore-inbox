Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266226AbUAVLJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 06:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266227AbUAVLJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 06:09:26 -0500
Received: from albireo.ucw.cz ([81.27.194.19]:20609 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S266226AbUAVLJQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 06:09:16 -0500
Date: Thu, 22 Jan 2004 12:09:14 +0100
From: Martin Mares <mj@ucw.cz>
To: "Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       torvalds@osdl.org, alan@lxorguk.ukuu.org.uk, greg@kroah.com,
       Andi Kleen <ak@colin2.muc.de>,
       "Kondratiev, Vladimir" <vladimir.kondratiev@intel.com>,
       "Seshadri, Harinarayanan" <harinarayanan.seshadri@intel.com>
Subject: Re: [patch] PCI Express Enhanced Config Patch - 2.6.0-test11
Message-ID: <20040122110914.GA1376@ucw.cz>
References: <6B09584CC3D2124DB45C3B592414FA83011A3357@bgsmsx402.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6B09584CC3D2124DB45C3B592414FA83011A3357@bgsmsx402.gar.corp.intel.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> I am reposting the updated patch after incorporating the review comments.

Looks good, but there are still some places to polish (in addition to
Andrew's comments):

> +	  to access the pci configuration space through enhanced config
> +	  access mechanism (Will work only on PCI Express based system)

"pci" should be "PCI".

> +	mcfg = (struct acpi_table_mcfg *) __acpi_map_table
> +						(phys_addr, size);

Wrapping long lines is good, but you seem to overdo it.

> +	printk(KERN_INFO PREFIX "Local  mcfg address %p\n",
> +			mcfg->base_address);

Again -- you should be consistent in usign caps: "MCFG", not "mcfg".

> +#ifdef CONFIG_PCI_EXPRESS
> +	else if (!strcmp(str, "no_pcie")) {

Why "no_pcie" with an underscore when existing switches ("noacpi", "nobios"
etc.) don't have one?

> +	if (mmcfg_base_address == 0){
> +		printk(KERN_INFO 
> +		      "MCFG table entry is not found in ACPI
> tables....\n \
> +		       PCI Express not supported in this platform....\n
> \
> +		       Not enabling Enhanced Configuration....\n");
> +		goto type1;
> +	}

Why printing such a enormous banner for reporting a trivial error?
One line is enough.

> +		printk(KERN_INFO "PCI:Using config type PCIExp\n");

"PCI:Using" -> "PCI: Using".

>  obj-$(CONFIG_PCI_DIRECT)	+= direct.o
> +obj-$(CONFIG_PCI_EXPRES)	+= direct.o

PCI_EXPRES -> PCI_EXPRESS

Also, linking the same object twice doesn't look right.

> +static int pci_cfg_space_size (struct pci_dev *dev)
> +{
> +#ifdef CONFIG_PCI_EXPRESS
> +	/* Find whether the device is PCI Express device */
> +	int is_pci_express_dev = 
> +		pci_find_capability(dev, PCI_CAP_ID_EXP);
> +	if (is_pci_express_dev)
> +		return PCI_CFG_SPACE_EXP_SIZE;
> +	else
> +#endif
> +	return PCI_CFG_SPACE_SIZE; 
> +}

We really shouldn't scan the capability list during each access to /proc/bus/pci.
Better calculate the configuration space size when probing the device
and put it to struct pci_dev.

> +#ifdef CONFIG_PCI_EXPRESS
> +/*
> + *Variable used to store the base address of the last pciexpress device
> + *accessed.
> + */
> +static u32 pcie_last_accessed_device;

Header files should not contain static variables.

> +static __inline__ void pci_express_read(int bus, int devfn, int reg, 
> +		int len, u32 *value)

Why is this inline?

> +	u64	base_address;

If the base_address is 64-bit and you stuff it in a 32-bit variable, you
should check the upper 32 bits and in case they are non-zero, print an error
message.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Entropy isn't what it used to be.
