Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264039AbTFQEiS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 00:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264546AbTFQEiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 00:38:18 -0400
Received: from dp.samba.org ([66.70.73.150]:12515 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264039AbTFQEiO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 00:38:14 -0400
Date: Tue, 17 Jun 2003 14:49:48 +1000
From: Anton Blanchard <anton@samba.org>
To: Matthew Wilcox <willy@debian.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: pci_domain_nr vs. /sys/devices
Message-ID: <20030617044948.GA1172@krispykreme>
References: <1055341842.754.3.camel@gaston> <20030611144801.GZ28581@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030611144801.GZ28581@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Look in /sys/bus/pci/devices/  There you have all the PCI devices
> lumped together in one place, and we obviously need the domain number
> in the name.  I don't know where the 0 on the end of /sys/devices/pci0/
> comes from, but if we could, I wouldn't say no to:
> 
> /sys/devices/pciDDDD/DDDD:BB:SS.F
> or
> /sys/devices/pciDDDD:BB/DDDD:BB:SS.F
> (Domain,Bus,Slot,Func)

I like it. I think we do need the bus number in the top level since we
could have multiple host bridges on the same domain. I put a quick patch
together, it lays things out as such:

/sys/devices/pci0002:00/0002:00:02.2

It also adds the domain to /proc/pci (are there userspace tools that
parse this directly?):

  Domain  2, Bus  0, device   2, function  2:

And only creates /proc/bus/pci entries for the first domain. I was going
to extend it one level to encode the domain but I now think we should just
move that functionality into sysfs and be done with it. Willy, you had a
patch that exposed BARS etc in sysfs didnt you? X and lspci etc will need
updating to match, but they are currently broken.

I chose to add the domain into dev->slot_name since its needed for matching
kernel messages to drivers. Im wondering if we should make this conditional
on pci domain support since it does add some noise for those who couldnt
care less about domains.

Finally there was some shuffling required to make pci_bus_exists work
(passing in a pci_bus *, ->sysdata and ->number must be initialised
before calling it). There are some uses of pci_bus_exists in x86 that
will need updating.

Thoungts?

Anton

===== drivers/pci/probe.c 1.43 vs edited =====
--- 1.43/drivers/pci/probe.c	Mon Jun  9 02:36:59 2003
+++ edited/drivers/pci/probe.c	Tue Jun 17 10:29:08 2003
@@ -400,8 +400,8 @@
 {
 	u32 class;
 
-	sprintf(dev->slot_name, "%02x:%02x.%d", dev->bus->number,
-		PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
+	sprintf(dev->slot_name, "%04x:%02x:%02x.%d", pci_domain_nr(dev->bus),
+		dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
 	sprintf(dev->dev.name, "PCI device %04x:%04x",
 		dev->vendor, dev->device);
 
@@ -529,8 +529,7 @@
 	pci_name_device(dev);
 
 	/* now put in global tree */
-	sprintf(dev->dev.bus_id, "%04x:%s", pci_domain_nr(bus),
-			dev->slot_name);
+	strcpy(dev->dev.bus_id,dev->slot_name);
 	dev->dev.dma_mask = &dev->dma_mask;
 
 	return dev;
@@ -632,56 +636,60 @@
 	return max;
 }
 
-int __devinit pci_bus_exists(const struct list_head *list, int nr)
+int __devinit pci_bus_exists(const struct list_head *list, struct pci_bus *bus)
 {
-	const struct pci_bus *b;
+	struct pci_bus *b;
 
 	list_for_each_entry(b, list, node) {
-		if (b->number == nr || pci_bus_exists(&b->children, nr))
+		if (((b->number == bus->number) &&
+				pci_domain_nr(b) == pci_domain_nr(bus)) || 
+			pci_bus_exists(&b->children, bus))
 			return 1;
 	}
 	return 0;
 }
 
-static struct pci_bus * __devinit pci_alloc_primary_bus_parented(struct device *parent, int bus)
+static struct pci_bus * __devinit pci_alloc_primary_bus_parented(struct device *parent, int bus, void *sysdata)
 {
 	struct pci_bus *b;
 
-	if (pci_bus_exists(&pci_root_buses, bus)) {
+	b = pci_alloc_bus();
+	if (!b)
+		return NULL;
+
+	b->sysdata = sysdata;
+	b->number = b->secondary = bus;
+	b->resource[0] = &ioport_resource;
+	b->resource[1] = &iomem_resource;
+
+	if (pci_bus_exists(&pci_root_buses, b)) {
 		/* If we already got to this bus through a different bridge, ignore it */
 		DBG("PCI: Bus %02x already known\n", bus);
+		kfree(b);
 		return NULL;
 	}
 
-	b = pci_alloc_bus();
-	if (!b)
-		return NULL;
-	
 	b->dev = kmalloc(sizeof(*(b->dev)),GFP_KERNEL);
 	if (!b->dev){
 		kfree(b);
 		return NULL;
 	}
-	
+
 	list_add_tail(&b->node, &pci_root_buses);
 
 	memset(b->dev,0,sizeof(*(b->dev)));
-	sprintf(b->dev->bus_id,"pci%d",bus);
+	sprintf(b->dev->bus_id, "pci%04x:%02x", pci_domain_nr(b), bus);
 	strcpy(b->dev->name,"Host/PCI Bridge");
 	b->dev->parent = parent;
 	device_register(b->dev);
 
-	b->number = b->secondary = bus;
-	b->resource[0] = &ioport_resource;
-	b->resource[1] = &iomem_resource;
 	return b;
 }
 
 struct pci_bus * __devinit pci_scan_bus_parented(struct device *parent, int bus, struct pci_ops *ops, void *sysdata)
 {
-	struct pci_bus *b = pci_alloc_primary_bus_parented(parent, bus);
+	struct pci_bus *b = pci_alloc_primary_bus_parented(parent, bus, sysdata);
 	if (b) {
-		b->sysdata = sysdata;
 		b->ops = ops;
 		b->subordinate = pci_scan_child_bus(b);
 		pci_bus_add_devices(b);
===== drivers/pci/proc.c 1.29 vs edited =====
--- 1.29/drivers/pci/proc.c	Wed Jun 11 02:33:14 2003
+++ edited/drivers/pci/proc.c	Tue Jun 17 09:32:20 2003
@@ -382,6 +382,10 @@
 	if (!proc_initialized)
 		return -EACCES;
 
+	/* Backwards compatibility for domain 0 only */
+	if (pci_domain_nr(dev->bus) != 0)
+		return 0;
+
 	if (!(de = bus->procdir)) {
 		sprintf(name, "%02x", bus->number);
 		de = bus->procdir = proc_mkdir(name, proc_bus_pci_dir);
@@ -470,8 +474,9 @@
 	pci_read_config_byte (dev, PCI_LATENCY_TIMER, &latency);
 	pci_read_config_byte (dev, PCI_MIN_GNT, &min_gnt);
 	pci_read_config_byte (dev, PCI_MAX_LAT, &max_lat);
-	seq_printf(m, "  Bus %2d, device %3d, function %2d:\n",
-	       dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
+	seq_printf(m, "  Domain %2d, Bus %2d, device %3d, function %2d:\n",
+	       pci_domain_nr(dev->bus), dev->bus->number, PCI_SLOT(dev->devfn),
+	       PCI_FUNC(dev->devfn));
 	class = pci_class_name(class_rev >> 16);
 	if (class)
 		seq_printf(m, "    %s", class);
===== include/linux/pci.h 1.90 vs edited =====
--- 1.90/include/linux/pci.h	Wed Jun 11 16:49:42 2003
+++ edited/include/linux/pci.h	Tue Jun 17 10:27:32 2003
@@ -414,7 +414,7 @@
 	struct resource dma_resource[DEVICE_COUNT_DMA];
 	struct resource irq_resource[DEVICE_COUNT_IRQ];
 
-	char		slot_name[8];	/* slot name */
+	char		slot_name[13];	/* slot name */
 
 	/* These fields are used by common fixups */
 	unsigned int	transparent:1;	/* Transparent PCI bridge */
@@ -536,7 +536,7 @@
 
 /* Generic PCI functions used internally */
 
-int pci_bus_exists(const struct list_head *list, int nr);
+int pci_bus_exists(const struct list_head *list, struct pci_bus *bus);
 struct pci_bus *pci_scan_bus_parented(struct device *parent, int bus, struct pci_ops *ops, void *sysdata);
 static inline struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops, void *sysdata)
 {

