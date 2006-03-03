Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750995AbWCCWt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbWCCWt6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 17:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751726AbWCCWt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 17:49:57 -0500
Received: from gate.crashing.org ([63.228.1.57]:36520 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750986AbWCCWt5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 17:49:57 -0500
Date: Fri, 3 Mar 2006 16:39:52 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
X-X-Sender: galak@gate.crashing.org
To: Greg KH <greg@kroah.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       <linux-pci@atrey.karlin.mff.cuni.cz>
Subject: Re: proper way to assign fixed PCI resources to a "hotplug" device
In-Reply-To: <20060303220741.GA22298@kroah.com>
Message-ID: <Pine.LNX.4.44.0603031638050.30957-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Mar 2006, Greg KH wrote:

> On Fri, Mar 03, 2006 at 11:42:03AM -0600, Kumar Gala wrote:
> > I was wondering what the proper way to assign and setup a single PCI  
> > device that comes into existence after the system has booted.  I have  
> > an FPGA that we load from user space at which time it shows up on the  
> > PCI bus.
> 
> Idealy your BIOS would set up this information :)

How would my BIOS know about a device that didn't exist when it booted.  
Or do you mean my BIOS would load the FPGA as well so it existed.

> > It has a single BAR and I need to assign it at a fixed address in PCI  
> > MMIO space.
> > 
> > All of the exported interfaces I see have to do with having the  
> > kernel assign the BAR automatically for me.
> > 
> > the following looks like what I want to do:
> > 
> > bus = pci_find_bus(0, 3);
> > dev = pci_scan_single_device(bus, devfn);
> > pci_bus_alloc_resource(...);
> > pci_update_resource(dev, dev->resource[0], 0);
> > pci_bus_add_devices(bus);
> > 
> > However, pci_update_resource() is not an exported symbol, so I could  
> > replace that code with the need updates to the actual BAR.
> > 
> > Is this the "right" way to go about this or is there a better  
> > mechanism to do this.
> 
> Take a look at how the compat pci hotplug driver does this, you probably
> just need to do the same as it.

I'll take a look.  How about something like the following patch:

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index ea9277b..8d5caec 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -155,6 +155,42 @@ int pci_assign_resource(struct pci_dev *
 	return ret;
 }
 
+int pci_assign_resource_fixed(struct pci_dev *dev, int resno)
+{
+	struct pci_bus *bus = dev->bus;
+	struct resource *res = dev->resource + resno;
+	unsigned int type_mask;
+	int i, ret = -EBUSY;
+
+	type_mask = IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_PREFETCH;
+
+	for (i = 0; i < PCI_BUS_NUM_RESOURCES; i++) {
+		struct resource *r = bus->resource[i];
+		if (!r)
+			continue;
+
+		/* type_mask must match */
+		if ((res->flags ^ r->flags) & type_mask)
+			continue;
+
+		ret = request_resource(r, res);
+
+		if (ret == 0)
+			break;
+	}
+
+	if (ret) {
+		printk(KERN_ERR "PCI: Failed to allocate %s resource #%d:%lx@%lx for %s\n",
+		       res->flags & IORESOURCE_IO ? "I/O" : "mem",
+		       resno, res->end - res->start + 1, res->start, pci_name(dev));
+	} else if (resno < PCI_BRIDGE_RESOURCES) {
+		pci_update_resource(dev, res, resno);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_assign_resource_fixed);
+
 /* Sort resources by alignment */
 void __devinit
 pdev_sort_resources(struct pci_dev *dev, struct resource_list *head)

