Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbTLPRpl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 12:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbTLPRpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 12:45:41 -0500
Received: from mail.kroah.org ([65.200.24.183]:61146 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261973AbTLPRp3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 12:45:29 -0500
Date: Tue, 16 Dec 2003 09:45:05 -0800
From: Greg KH <greg@kroah.com>
To: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI Express support for 2.4 kernel
Message-ID: <20031216174505.GC2716@kroah.com>
References: <3FDCC171.9070902@intel.com> <3FDCCC12.20808@pobox.com> <3FDD8691.80206@intel.com> <20031215103142.GA8735@iram.es> <3FDDACA9.1050600@intel.com> <1071494155.5223.3.camel@laptop.fenrus.com> <3FDDBDFE.5020707@intel.com> <Pine.LNX.4.58.0312151154480.1631@home.osdl.org> <3FDEDC77.9010203@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FDEDC77.9010203@intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Minor code comments below:

On Tue, Dec 16, 2003 at 12:20:39PM +0200, Vladimir Kondratiev wrote:
> +
> +#ifdef CONFIG_PCI_EXPRESS
> +#define PCI_PROBE_EXP		0x0008
> +#endif
> +

If you change this to:
#ifdef CONFIG_PCI_EXPRESS
#define PCI_PROBE_EXP		0x0008
#else
#define PCI_PROBE_EXP		0x0000
#endif

You can get rid of a number of "#ifdef CONFIG_PCI_EXPRESS" statements
later on in the .c files by just always using the PCI_PROBE_EXP value.
That cleans up the patch a bit.

> -unsigned int pci_probe = PCI_PROBE_BIOS | PCI_PROBE_CONF1 | PCI_PROBE_CONF2;
> +unsigned int pci_probe = PCI_PROBE_BIOS | PCI_PROBE_CONF1 | PCI_PROBE_CONF2
> +#ifdef CONFIG_PCI_EXPRESS
> + | PCI_PROBE_EXP
> +#endif
> +;

Like right there :)

> +/**
> + * RRBAR (memory base for PCI-E config space) resides here.
> + * Initialized to default address. Actually, it is platform specific, and
> + * value may vary.
> + * I don't know how to detect it properly, it is chipset specific.
> + */
> +static u32 rrbar_phys = CONFIG_PCI_EXPRESS_BASE * 0x10000000UL;

<snip>

> +/**
> + * I don't know how to detect it properly.
> + * assume it is PCI-E, sanity_check will
> + * stop me if it is not.
> + * 
> + * Also, this function supposed to set rrbar_phys
> + */
> +static int is_pcie_platform(void)
> +{ return 1; }

Shouldn't your comments at least match your code for the rrbar_phys
statement for your first release?  :)

> +/**
> + * Initializes PCI Express method for config space access.
> + * 
> + * There is no standard method to recognize presence of PCI Express,
> + * thus we will assume it is PCI-E, and rely on sanity check to
> + * deassert PCI-E presense. If PCI-E not present,
> + * there is no physical RAM on RRBAR address, and we should read
> + * something like 0xff.
> + * 
> + * @return 1 if OK, 0 if error
> + */
> +static int pci_express_init(void)
> +{
> +	rrbar_window_virt = (void*)fix_to_virt(FIX_PCIE_CONFIG);
> +	if (!is_pcie_platform())
> +		return 0;

Call fix_to_virt() after you do the check and not before?


> +/**
> + * Shuts down PCI-E resources.
> + */
> +static inline void pci_express_fini(void)
> +{}

If this isn't needed, why have it anymore?

> +static struct pci_ops pci_express_conf = {
> +	pci_exp_read_config_byte,
> +	pci_exp_read_config_word,
> +	pci_exp_read_config_dword,
> +	pci_exp_write_config_byte,
> +	pci_exp_write_config_word,
> +	pci_exp_write_config_dword
> +};

C99 initializers here?

> +			printk(KERN_INFO "PCI-Express config at 0x%08x\n", rrbar_phys);

"%p" to show the address might be nicer.


thanks,

greg k-h
