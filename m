Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265975AbUA1PTM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 10:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265973AbUA1PTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 10:19:12 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46216 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266019AbUA1PSa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 10:18:30 -0500
Date: Wed, 28 Jan 2004 15:18:28 +0000
From: Matthew Wilcox <willy@debian.org>
To: "Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       torvalds@osdl.org, alan@lxorguk.ukuu.org.uk, greg@kroah.com,
       Andi Kleen <ak@colin2.muc.de>, akpm@osdl.org, mj@ucw.cz,
       "Kondratiev, Vladimir" <vladimir.kondratiev@intel.com>,
       "Seshadri, Harinarayanan" <harinarayanan.seshadri@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [patch] PCI Express Enhanced Config Patch - 2.6.0-test11
Message-ID: <20040128151828.GJ11844@parcelfarce.linux.theplanet.co.uk>
References: <6B09584CC3D2124DB45C3B592414FA83011A336E@bgsmsx402.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6B09584CC3D2124DB45C3B592414FA83011A336E@bgsmsx402.gar.corp.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 28, 2004 at 03:08:01PM +0530, Durairaj, Sundarapandian wrote:
> -menu "Bus options (PCI, PCMCIA, EISA, MCA, ISA)"
> +menu "Bus options (PCI, PCMCIA, EISA, MCA, ISA, PCI_EXPRESS)"

I think this is unnecessary.  For users, PCI Express is just another
form of PCI.

> +config PCI_EXPRESS
> +	bool "PCI_EXPRESS (EXPERIMENTAL)" 
> +	depends on EXPERIMENTAL && ACPI_BOOT

Can't we do this with select?  ie:

config PCI_EXPRESS
	bool "PCI Express (EXPERIMENTAL)"
	depends on EXPERIMENTAL
	select ACPI_BOOT

> +	help
> +	  PCI Express extends the configuration space from 256 bytes to
> +	  4k bytes. It also defines an enhanced configuration mechanism
> +	  to access the extended configuration space. With this option, 
> +	  you can specify that Linux will first attempt to access the 
> +	  PCI configuration space through enhanced config access 
> +	  mechanism (will work only on PCI Express based system)
> +	  otherwise other standard PCI access mechanism will be used.

I don't think this help is terribly helpful to the user.  How about:

	help
	  PCI Express is a new I/O architecture that is used in many
	  systems from 2004 onwards.  Even if there are no PCI Express
	  slots on your motherboard, it may use PCI Express internally.
	  If you don't know, it is safe to say Y here.

Also, I would place this entry after PCI and make it depend on PCI (since
all the PCI infrastructure is relevant to PCI Express).

> +#ifdef CONFIG_PCI_EXPRESS
> +	result = acpi_table_parse(ACPI_MCFG, acpi_parse_mcfg);
> +	if (!result) {
> +		printk(KERN_WARNING PREFIX "MCFG not present\n");
> +		return 0;
> +	}
> +	else if (result < 0) {

CodingStyle recommends joining these last two lines together.

> +static int pci_express_conf_read(int seg, int bus,
> +		int devfn, int reg, int len, u32 *value)
> +{
> +	if (!value || (bus > 255) || (devfn > 255) || (reg > 4095)) {
> +		printk(KERN_ERR "pci_express_conf_read: "
> +					"Invalid Parameter\n");
> +  		return -EINVAL;
> +	}
> +
> +	/* Shoot misaligned transaction now */
> +	if (reg & (len-1)) {
> +		printk(KERN_ERR "pci_express_conf_read: "
> +					"misaligned transaction\n");
> +  		return -EINVAL;
> +	}

This last bit is not needed; Linux doesn't let misaligned requests get
this far.  See drivers/pci/access.c::pci_bus_read_config_##size

> @@ -90,6 +90,8 @@
>   *  %PCI_CAP_ID_CHSWP        CompactPCI HotSwap 
>   *
>   *  %PCI_CAP_ID_PCIX         PCI-X
> + *  %PCI_CAP_ID_EXP          PCI-EXP
> +

seems like a stray blank line?

>   */
>  int
>  pci_find_capability(struct pci_dev *dev, int cap)
> diff -Naur linux-2.6.0/drivers/pci/probe.c linux_pciexpress/drivers/pci/probe.c
> --- linux-2.6.0/drivers/pci/probe.c	2003-12-18 08:29:06.000000000 +0530
> +++ linux_pciexpress/drivers/pci/probe.c	2004-01-28 12:06:39.000000000 +0530
> @@ -17,6 +17,8 @@
>  
>  #define CARDBUS_LATENCY_TIMER	176	/* secondary latency timer */
>  #define CARDBUS_RESERVE_BUSNR	3
> +#define PCI_CFG_SPACE_SIZE	256
> +#define PCI_CFG_SPACE_EXP_SIZE	4096

fwiw, PCI-X 2 also has 4096 bytes of config space.  Perhaps we can just
agree that 'EXP' stands for 'Expanded', not 'Express' in this instance?
;-)

> +static int pci_cfg_space_size(struct pci_dev *dev)
> +{
> +#ifdef CONFIG_PCI_EXPRESS
> +	/* Find whether the device is PCI Express device */
> +	int is_pci_express_dev = 
> +		pci_find_capability(dev, PCI_CAP_ID_EXP);
> +	if (is_pci_express_dev)
> +		return PCI_CFG_SPACE_EXP_SIZE;
> +	else

I would drop the `else' here.

> +#endif
> +	return PCI_CFG_SPACE_SIZE; 
> +}
> +
>  /*
>   * Read the config data for a PCI device, sanity-check it
>   * and fill in the dev structure...
> @@ -515,6 +533,7 @@
>  	dev->multifunction = !!(hdr_type & 0x80);
>  	dev->vendor = l & 0xffff;
>  	dev->device = (l >> 16) & 0xffff;
> +	dev->cfg_size = pci_cfg_space_size(dev);

Good idea to cache it in the pci_dev.

> +static inline void pci_express_read(int bus, int devfn, int reg, 
> +		int len, u32 *value)
> +{
> +	unsigned long flags;
> +	spin_lock_irqsave(&pci_config_lock, flags);

You're already under the pci_lock spinlock (again see drivers/pci/access.c),
so I think this is unnecessary.


This is coming together nicely.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
