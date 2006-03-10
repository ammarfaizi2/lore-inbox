Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751571AbWCJPQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbWCJPQd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 10:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbWCJPQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 10:16:33 -0500
Received: from gate.crashing.org ([63.228.1.57]:23470 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751571AbWCJPQc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 10:16:32 -0500
Date: Fri, 10 Mar 2006 09:05:58 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
X-X-Sender: galak@gate.crashing.org
To: Greg KH <greg@kroah.com>
cc: linux-pci@atrey.karlin.mff.cuni.cz, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]
In-Reply-To: <Pine.LNX.4.44.0603100844540.28974-100000@gate.crashing.org>
Message-ID: <Pine.LNX.4.44.0603100902560.29294-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ack, this is what I get for sending patches before I've actually gotten 
up.  The first line was suppose to be the subject line, oh well will 
resend this.

- k

On Fri, 10 Mar 2006, Kumar Gala wrote:

> PCI: Add pci_assign_resource_fixed -- allow fixed address assignments
> 
> On some embedded systems the PCI address for hotplug devices are not only
> known a priori but are required to be at a given PCI address for other
> master in the system to be able to access.
> 
> An example of such a system would be an FPGA which is setup from user space
> after the system has booted.  The FPGA may be access by DSPs in the system
> and those DSPs expect the FPGA at a fixed PCI address.
> 
> Added pci_assign_resource_fixed() as a way to allow assignment of the PCI
> devices's BARs at fixed PCI addresses.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> 
> ---
> commit 45d4a23317c459865ec740c80b6e2a2ad9f53fd3
> tree 432b5e41ef5f231dd57eb1a98f103239c62d63a0
> parent 8176dee014ec6ad1039b8c0075c9c1d02147c2c8
> author Kumar Gala <galak@kernel.crashing.org> Thu, 09 Mar 2006 12:34:25 -0600
> committer Kumar Gala <galak@kernel.crashing.org> Thu, 09 Mar 2006 12:34:25 -0600
> 
>  drivers/pci/pci.c       |    1 +
>  drivers/pci/setup-res.c |   35 +++++++++++++++++++++++++++++++++++
>  include/linux/pci.h     |    1 +
>  3 files changed, 37 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index d2d1879..2557e86 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -935,6 +935,7 @@ EXPORT_SYMBOL_GPL(pci_intx);
>  EXPORT_SYMBOL(pci_set_dma_mask);
>  EXPORT_SYMBOL(pci_set_consistent_dma_mask);
>  EXPORT_SYMBOL(pci_assign_resource);
> +EXPORT_SYMBOL(pci_assign_resource_fixed);
>  EXPORT_SYMBOL(pci_find_parent_resource);
>  
>  EXPORT_SYMBOL(pci_set_power_state);
> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index ea9277b..f485958 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c
> @@ -155,6 +155,41 @@ int pci_assign_resource(struct pci_dev *
>  	return ret;
>  }
>  
> +int pci_assign_resource_fixed(struct pci_dev *dev, int resno)
> +{
> +	struct pci_bus *bus = dev->bus;
> +	struct resource *res = dev->resource + resno;
> +	unsigned int type_mask;
> +	int i, ret = -EBUSY;
> +
> +	type_mask = IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_PREFETCH;
> +
> +	for (i = 0; i < PCI_BUS_NUM_RESOURCES; i++) {
> +		struct resource *r = bus->resource[i];
> +		if (!r)
> +			continue;
> +
> +		/* type_mask must match */
> +		if ((res->flags ^ r->flags) & type_mask)
> +			continue;
> +
> +		ret = request_resource(r, res);
> +
> +		if (ret == 0)
> +			break;
> +	}
> +
> +	if (ret) {
> +		printk(KERN_ERR "PCI: Failed to allocate %s resource #%d:%lx@%lx for %s\n",
> +		       res->flags & IORESOURCE_IO ? "I/O" : "mem",
> +		       resno, res->end - res->start + 1, res->start, pci_name(dev));
> +	} else if (resno < PCI_BRIDGE_RESOURCES) {
> +		pci_update_resource(dev, res, resno);
> +	}
> +
> +	return ret;
> +}
> +
>  /* Sort resources by alignment */
>  void __devinit
>  pdev_sort_resources(struct pci_dev *dev, struct resource_list *head)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index fe1a2b0..0db1e2d 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -460,6 +460,7 @@ int pci_set_dma_mask(struct pci_dev *dev
>  int pci_set_consistent_dma_mask(struct pci_dev *dev, u64 mask);
>  void pci_update_resource(struct pci_dev *dev, struct resource *res, int resno);
>  int pci_assign_resource(struct pci_dev *dev, int i);
> +int pci_assign_resource_fixed(struct pci_dev *dev, int i);
>  void pci_restore_bars(struct pci_dev *dev);
>  
>  /* ROM control related routines */
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

