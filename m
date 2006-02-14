Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422726AbWBNR7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422726AbWBNR7S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 12:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422731AbWBNR7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 12:59:18 -0500
Received: from fmr20.intel.com ([134.134.136.19]:21143 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1422732AbWBNR7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 12:59:17 -0500
Subject: Re: AMD 8131 and MSI quirk
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Roland Dreier <rolandd@cisco.com>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <20060214165222.GC12974@mellanox.co.il>
References: <524q799p2t.fsf@cisco.com>
	 <20060214165222.GC12974@mellanox.co.il>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 14 Feb 2006 10:03:45 -0800
Message-Id: <1139940226.18044.3.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-OriginalArrivalTime: 14 Feb 2006 17:59:03.0974 (UTC) FILETIME=[5780AC60:01C63190]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-14 at 18:52 +0200, Michael S. Tsirkin wrote:
> Quoting r. Roland Dreier <rolandd@cisco.com>:
> > Subject: AMD 8131 and MSI quirk
> > 
> > The current quirk_amd_8131_ioapic() function sets a global
> > pci_msi_quirk flag, which disables MSI/MSI-X for all devices in the
> > system.  This is safe but suboptimal, because there may be devices on
> > other buses not related to the AMD 8131 bridge, for which MSI would
> > work fine.  As an example, see the end of this email for a lspci -t
> > from a real Opteron system that has PCI-X buses coming from an AMD
> > 8131 and PCI Express buses coming from an Nforce4 bridge -- MSI works
> > fine for the Mellanox InfiniBand adapter on the PCIe bus, if we allow
> > it to be enabled.
> 
> The following should do this IMO. Roland, could you test this patch please?
> 
> ---
> 
> It turns out AMD 8131 quirk only affects MSI for devices behind the 8131 bridge.
> Handle this by adding a flags field in pci_bus, inherited from parent to child.

It seems like we have a way to turn of msi already (the no_msi bit in
the pci_dev structure).  Does it make sense to just have the child bus
pci_dev structure inherit the no_msi bit from the parent's pci_dev
structure when doing an allocation, or does that unnecessarily remove
the msi capability for devices that may not need it?

Kristen


> 
> Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
> 
> Index: linux-2.6.16-rc2/drivers/pci/msi.c
> ===================================================================
> --- linux-2.6.16-rc2.orig/drivers/pci/msi.c	2006-02-14 17:09:23.000000000 +0200
> +++ linux-2.6.16-rc2/drivers/pci/msi.c	2006-02-14 18:14:00.000000000 +0200
> @@ -699,6 +699,9 @@ int pci_enable_msi(struct pci_dev* dev)
>  	if (dev->no_msi)
>  		return status;
>  
> +	if (dev->bus->bus_flags & PCI_BUS_FLAGS_NO_MSI)
> +		return -EINVAL;
> +
>  	temp = dev->irq;
>  
>  	if ((status = msi_init()) < 0)
> @@ -924,6 +927,9 @@ int pci_enable_msix(struct pci_dev* dev,
>  	if (!pci_msi_enable || !dev || !entries)
>   		return -EINVAL;
>  
> +	if (dev->bus->bus_flags & PCI_BUS_FLAGS_NO_MSI)
> +		return -EINVAL;
> +
>  	if ((status = msi_init()) < 0)
>  		return status;
>  
> Index: linux-2.6.16-rc2/drivers/pci/probe.c
> ===================================================================
> --- linux-2.6.16-rc2.orig/drivers/pci/probe.c	2006-02-14 17:09:23.000000000 +0200
> +++ linux-2.6.16-rc2/drivers/pci/probe.c	2006-02-14 17:58:17.000000000 +0200
> @@ -347,6 +347,7 @@ pci_alloc_child_bus(struct pci_bus *pare
>  	child->parent = parent;
>  	child->ops = parent->ops;
>  	child->sysdata = parent->sysdata;
> +	child->bus_flags = parent->bus_flags;
>  	child->bridge = get_device(&bridge->dev);
>  
>  	child->class_dev.class = &pcibus_class;
> Index: linux-2.6.16-rc2/drivers/pci/quirks.c
> ===================================================================
> --- linux-2.6.16-rc2.orig/drivers/pci/quirks.c	2006-02-14 17:09:23.000000000 +0200
> +++ linux-2.6.16-rc2/drivers/pci/quirks.c	2006-02-14 17:58:17.000000000 +0200
> @@ -575,8 +575,11 @@ static void __init quirk_amd_8131_ioapic
>  { 
>          unsigned char revid, tmp;
>          
> -	pci_msi_quirk = 1;
> -	printk(KERN_WARNING "PCI: MSI quirk detected. pci_msi_quirk set.\n");
> +	if (dev->subordinate) {
> +		printk(KERN_WARNING "PCI: MSI quirk detected. "
> +		       "PCI_BUS_FLAGS_NO_MSI set for subordinate bus.\n");
> +		dev->subordinate->bus_flags |= PCI_BUS_FLAGS_NO_MSI;
> +	}
>  
>          if (nr_ioapics == 0) 
>                  return;
> Index: linux-2.6.16-rc2/include/linux/pci.h
> ===================================================================
> --- linux-2.6.16-rc2.orig/include/linux/pci.h	2006-02-14 17:09:24.000000000 +0200
> +++ linux-2.6.16-rc2/include/linux/pci.h	2006-02-14 17:58:17.000000000 +0200
> @@ -95,6 +95,11 @@ enum pci_channel_state {
>  	pci_channel_io_perm_failure = (__force pci_channel_state_t) 3,
>  };
>  
> +typedef unsigned short __bitwise pci_bus_flags_t;
> +enum pci_bus_flags {
> +	PCI_BUS_FLAGS_NO_MSI = (pci_bus_flags_t) 1,
> +};
> +
>  /*
>   * The pci_dev structure is used to describe PCI devices.
>   */
> @@ -203,7 +208,7 @@ struct pci_bus {
>  	char		name[48];
>  
>  	unsigned short  bridge_ctl;	/* manage NO_ISA/FBB/et al behaviors */
> -	unsigned short  pad2;
> +	pci_bus_flags_t bus_flags;	/* Inherited by child busses */
>  	struct device		*bridge;
>  	struct class_device	class_dev;
>  	struct bin_attribute	*legacy_io; /* legacy I/O for this bus */
> 
> 
> 
