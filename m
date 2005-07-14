Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262529AbVGNRPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262529AbVGNRPw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 13:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261607AbVGNROI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 13:14:08 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:50058 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261621AbVGNRMU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 13:12:20 -0400
Date: Thu, 14 Jul 2005 19:10:14 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Adam Belay <abelay@novell.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [RFC][PATCH] split PCI probing code [1/9]
Message-ID: <20050714171014.GA16069@electric-eye.fr.zoreil.com>
References: <1121331304.3398.89.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121331304.3398.89.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Belay <abelay@novell.com> :
[...]

Some nits + a suspect error branch. It seems nice otherwise.

> --- a/drivers/pci/bus/bus.c	1969-12-31 19:00:00.000000000 -0500
> +++ b/drivers/pci/bus/bus.c	2005-07-10 22:32:53.000000000 -0400
[...]
> +struct pci_bus * pci_alloc_bus(void)
> +{
> +	struct pci_bus *b;
> +
> +	b = kmalloc(sizeof(*b), GFP_KERNEL);
> +	if (b) {
> +		memset(b, 0, sizeof(*b));

mm/slab.c provides kcalloc.

[...]
> --- a/drivers/pci/bus/config.c	1969-12-31 19:00:00.000000000 -0500
> +++ b/drivers/pci/bus/config.c	2005-07-12 00:52:35.147664368 -0400
[...]
> +static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
> +{
> +	unsigned int pos, reg, next;
> +	u32 l, sz;
> +	struct resource *res;
> +
> +	for(pos=0; pos<howmany; pos = next) {

   	for (pos = 0; pos < howmany; pos = next) {

[...]
> +static struct pci_dev * __devinit
> +pci_scan_device(struct pci_bus *bus, int devfn)
> +{
[...]
> +	dev = kmalloc(sizeof(struct pci_dev), GFP_KERNEL);
> +	if (!dev)
> +		return NULL;
> +
> +	memset(dev, 0, sizeof(struct pci_dev));

kcalloc

[...]
> +	/* Assume 32-bit PCI; let 64-bit PCI cards (which are far rarer)
> +	   set this higher, assuming the system even supports it.  */
> +	dev->dma_mask = 0xffffffff;

DMA_32BIT_MASK

> +	if (pci_setup_device(dev) < 0) {
> +		kfree(dev);
> +		return NULL;
> +	}
> +	device_initialize(&dev->dev);
> +	dev->dev.release = pci_release_dev;
> +	pci_dev_get(dev);
> +
> +	pci_name_device(dev);
> +
> +	dev->dev.dma_mask = &dev->dma_mask;
> +	dev->dev.coherent_dma_mask = 0xffffffffull;

DMA_32BIT_MASK

[...]
> +struct pci_dev * __devinit
> +pci_scan_single_device(struct pci_bus *bus, int devfn)
> +{
> +	struct pci_dev *dev;
> +
> +	dev = pci_scan_device(bus, devfn);
> +	pci_scan_msi_device(dev);
> +
> +	if (!dev)
> +		return NULL;

Why not do the test immediately ?

[...]
> --- a/drivers/pci/bus/probe.c	1969-12-31 19:00:00.000000000 -0500
> +++ b/drivers/pci/bus/probe.c	2005-07-12 00:55:50.580953992 -0400
[...]
> +int __devinit pci_scan_bridge(struct pci_bus *bus, struct pci_dev * dev, int max, int pass)
[...]
> +
> +		/* Prevent assigning a bus number that already exists.
> +		 * This can happen when a bridge is hot-plugged */
> +		if (pci_find_bus(pci_domain_nr(bus), max+1))

   		if (pci_find_bus(pci_domain_nr(bus), max + 1))

[...]
> +			/*
> +			 * For CardBus bridges, we leave 4 bus numbers
> +			 * as cards with a PCI-to-PCI bridge can be
> +			 * inserted later.
> +			 */
> +			for (i=0; i<CARDBUS_RESERVE_BUSNR; i++)

   			for (i = 0; i < CARDBUS_RESERVE_BUSNR; i++)


[...]
> +int __devinit pci_scan_slot(struct pci_bus *bus, int devfn)
> +{
> +	int func, nr = 0;
> +	int scan_all_fns;
> +
> +	scan_all_fns = pcibios_scan_all_fns(bus, devfn);
> +
> +	for (func = 0; func < 8; func++, devfn++) {
> +		struct pci_dev *dev;
> +
> +		dev = pci_scan_single_device(bus, devfn);
> +		if (dev) {
> +			nr++;
> +
> +			/*
> +		 	 * If this is a single function device,
> +		 	 * don't scan past the first function.
> +		 	 */
> +			if (!dev->multifunction) {
> +				if (func > 0) {
> +					dev->multifunction = 1;
> +				} else {
> + 					break;
> +				}

   				if (func == 0)
    					break;
   				dev->multifunction = 1;


[...]
> +unsigned int __devinit pci_scan_child_bus(struct pci_bus *bus)
> +{
[...]
> +	pcibios_fixup_bus(bus);
> +	for (pass=0; pass < 2; pass++)

   	for (pass = 0; pass < 2; pass++)

[...]
> +struct pci_bus * __devinit pci_scan_bus_parented(struct device *parent, int bus, struct pci_ops *ops, void *sysdata)
> +{
> +	int error;
> +	struct pci_bus *b;
> +	struct device *dev;
> +
> +	b = pci_alloc_bus();
> +	if (!b)
> +		return NULL;
> +
> +	dev = kmalloc(sizeof(*dev), GFP_KERNEL);
> +	if (!dev){
> +		kfree(b);
> +		return NULL;
> +	}

The code below uses goto. Why not here ?

> +
> +	b->sysdata = sysdata;
> +	b->ops = ops;
> +
> +	if (pci_find_bus(pci_domain_nr(b), bus)) {
> +		/* If we already got to this bus through a different bridge, ignore it */
> +		pr_debug("PCI: Bus %04x:%02x already known\n", pci_domain_nr(b), bus);
> +		goto err_out;
> +	}
> +	spin_lock(&pci_bus_lock);
> +	list_add_tail(&b->node, &pci_root_buses);
> +	spin_unlock(&pci_bus_lock);
> +
> +	memset(dev, 0, sizeof(*dev));

kcalloc

> +	dev->parent = parent;
> +	dev->release = pci_release_bus_bridge_dev;
> +	sprintf(dev->bus_id, "pci%04x:%02x", pci_domain_nr(b), bus);
> +	error = device_register(dev);
> +	if (error)
> +		goto dev_reg_err;

If you make this goto and the others 'err_WHAT_SHOULD_BE_DONE_some_number',
one can verify the error branch without going forth and back.

> +	b->bridge = get_device(dev);
> +
> +	b->class_dev.class = &pcibus_class;
> +	sprintf(b->class_dev.class_id, "%04x:%02x", pci_domain_nr(b), bus);
> +	error = class_device_register(&b->class_dev);
> +	if (error)
> +		goto class_dev_reg_err;

Should not "get_device" above be balanced ?

> +	error = class_device_create_file(&b->class_dev, &class_device_attr_cpuaffinity);
> +	if (error)
> +		goto class_dev_create_file_err;
> +
> +	/* Create legacy_io and legacy_mem files for this bus */
> +	pci_create_legacy_files(b);
> +
> +	error = sysfs_create_link(&b->class_dev.kobj, &b->bridge->kobj, "bridge");
> +	if (error)
> +		goto sys_create_link_err;

Add "pci_remove_legacy_files" on the error branch ?

> +
> +	b->number = b->secondary = bus;
> +	b->resource[0] = &ioport_resource;
> +	b->resource[1] = &iomem_resource;
> +
> +	b->subordinate = pci_scan_child_bus(b);
> +
> +	return b;
> +
> +sys_create_link_err:
> +	class_device_remove_file(&b->class_dev, &class_device_attr_cpuaffinity);
> +class_dev_create_file_err:
> +	class_device_unregister(&b->class_dev);
> +class_dev_reg_err:
> +	device_unregister(dev);
> +dev_reg_err:
> +	spin_lock(&pci_bus_lock);
> +	list_del(&b->node);
> +	spin_unlock(&pci_bus_lock);
> +err_out:
> +	kfree(dev);
> +	kfree(b);
> +	return NULL;
> +}
> +

--
Ueimor
