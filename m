Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315469AbSFJPtX>; Mon, 10 Jun 2002 11:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315471AbSFJPtW>; Mon, 10 Jun 2002 11:49:22 -0400
Received: from air-2.osdl.org ([65.201.151.6]:11923 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S315469AbSFJPtT>;
	Mon, 10 Jun 2002 11:49:19 -0400
Date: Mon, 10 Jun 2002 08:44:44 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: Peter Osterlund <petero2@telia.com>
cc: Tobias Diedrich <ranma@gmx.at>,
        Alessandro Suardi <alessandro.suardi@oracle.com>,
        <linux-kernel@vger.kernel.org>, <torvalds@transmeta.com>
Subject: Re: 2.5.20 - Xircom PCI Cardbus doesn't work
In-Reply-To: <m2r8jgd8ly.fsf@ppro.localdomain>
Message-ID: <Pine.LNX.4.33.0206100817090.654-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 9 Jun 2002, Peter Osterlund wrote:

> Tobias Diedrich <ranma@gmx.at> writes:
> 
> > Peter Osterlund wrote:
> > > Alessandro Suardi <alessandro.suardi@oracle.com> writes:
> > > 
> > > > In 2.5.19 I got an oops on boot (kindly fixed by Peter's patch),
> > > >   in 2.5.20 no oopsen but eth0 isn't seen anymore by the kernel:
> > > 
> > > Same problem here. My network card isn't seen either by the kernel in
> > > 2.5.20. If it's still broken in 2.5.21, maybe I'll try to fix it.
> > 
> > This oneliner fixes it for me, but I don't know if that's the right fix:
> 
> Thanks, it fixes my problem too. (This patch is still needed in
> 2.5.21.) However, in 2.5.21 I get an oops at shutdown in
> device_detach. This happens both with and without your patch:

Sorry about the delay. Could you please try this patch and let me know if 
it helps? It attempts to treat cardbus more like PCI, and let the PCI 
helpers do the probing. 

Note that it's based on the assumption that there is a cardbus bridge for 
each cardbus slot. This appears to be true on all systems I've seen, but 
it may not hold for all systems. If other people are feeling adventurous, 
please give this a try and let me know if it works. 

You can pull from bk://ldm.bkbits.net/linux-2.5-cardbus

Thanks,

	-pat

ChangeSet@1.494, 2002-06-10 08:35:32-07:00, mochel@osdl.org
  Treat cardbus more like PCI: let the PCI helpers do more WRT probing

 drivers/pci/hotplug.c    |    2 
 drivers/pcmcia/cardbus.c |  114 ++++++++++++++++-------------------------------
 2 files changed, 40 insertions, 76 deletions


diff -Nru a/drivers/pci/hotplug.c b/drivers/pci/hotplug.c
--- a/drivers/pci/hotplug.c	Mon Jun 10 08:42:14 2002
+++ b/drivers/pci/hotplug.c	Mon Jun 10 08:42:14 2002
@@ -56,8 +56,6 @@
 void
 pci_insert_device(struct pci_dev *dev, struct pci_bus *bus)
 {
-	list_add_tail(&dev->bus_list, &bus->devices);
-	list_add_tail(&dev->global_list, &pci_devices);
 #ifdef CONFIG_PROC_FS
 	pci_proc_attach_device(dev);
 #endif
diff -Nru a/drivers/pcmcia/cardbus.c b/drivers/pcmcia/cardbus.c
--- a/drivers/pcmcia/cardbus.c	Mon Jun 10 08:42:14 2002
+++ b/drivers/pcmcia/cardbus.c	Mon Jun 10 08:42:14 2002
@@ -178,16 +178,21 @@
 void read_cb_mem(socket_info_t * s, u_char fn, int space,
 		 u_int addr, u_int len, void *ptr)
 {
-	struct pci_dev *dev;
+	struct pci_dev *dev = NULL;
 	struct resource *res;
+	list_t * node;
 
 	DEBUG(3, "cs: read_cb_mem(%d, %#x, %u)\n", space, addr, len);
 
-	if (!s->cb_config)
+	list_for_each(node,&s->cap.cb_dev->subordinate->devices) {
+		dev = list_entry(node,struct pci_dev,bus_list);
+		if (PCI_FUNC(dev->devfn) == fn)
+			break;
+		dev = NULL;
+	}
+	if (!dev)
 		goto fail;
 
-	dev = &s->cb_config[fn].dev;
-
 	/* Config space? */
 	if (space == 0) {
 		if (addr + len > 0x100)
@@ -233,10 +238,10 @@
 {
 	struct pci_bus *bus;
 	struct pci_dev tmp;
-	u_short vend, v, dev;
-	u_char i, hdr, fn;
-	cb_config_t *c;
+	u16 vend, dev;
 	int irq;
+	list_t	* node;
+	struct pci_dev * pdev;
 
 	bus = s->cap.cb_dev->subordinate;
 	memset(&tmp, 0, sizeof(tmp));
@@ -249,80 +254,43 @@
 	printk(KERN_INFO "cs: cb_alloc(bus %d): vendor 0x%04x, "
 	       "device 0x%04x\n", bus->number, vend, dev);
 
-	pci_readb(&tmp, PCI_HEADER_TYPE, &hdr);
-	fn = 1;
-	if (hdr & 0x80) {
-		do {
-			tmp.devfn = fn;
-			if (pci_readw(&tmp, PCI_VENDOR_ID, &v) || !v || v == 0xffff)
-				break;
-			fn++;
-		} while (fn < 8);
-	}
-	s->functions = fn;
-
-	c = kmalloc(fn * sizeof(struct cb_config_t), GFP_ATOMIC);
-	if (!c)
-		return CS_OUT_OF_RESOURCE;
-	memset(c, 0, fn * sizeof(struct cb_config_t));
+	/* let generic PCI code scan bus */
+	pci_do_scan_bus(bus);
 
+	/* walk the bus again and set the irq for the devices, 
+	 * enable each one, and let userspace know (pci_insert_device)
+	 */
 	irq = s->cap.pci_irq;
-	for (i = 0; i < fn; i++) {
-		struct pci_dev *dev = &c[i].dev;
+	list_for_each(node,&bus->devices) {
 		u8 irq_pin;
-		int r;
-
-		dev->bus = bus;
-		dev->sysdata = bus->sysdata;
-		dev->devfn = i;
-		dev->vendor = vend;
-		pci_readw(dev, PCI_DEVICE_ID, &dev->device);
-		dev->hdr_type = hdr & 0x7f;
-
-		pci_setup_device(dev);
-
-		dev->dev.parent = bus->dev;
-		strcpy(dev->dev.name, dev->name);
-		strcpy(dev->dev.bus_id, dev->slot_name);
-		device_register(&dev->dev);
-
-		/* FIXME: Do we need to enable the expansion ROM? */
-		for (r = 0; r < 7; r++) {
-			struct resource *res = dev->resource + r;
-			if (res->flags)
-				pci_assign_resource(dev, r);
-		}
+		pdev = list_entry(node,struct pci_dev, bus_list);
 
 		/* Does this function have an interrupt at all? */
-		pci_readb(dev, PCI_INTERRUPT_PIN, &irq_pin);
+		pci_readb(pdev, PCI_INTERRUPT_PIN, &irq_pin);
 		if (irq_pin) {
-			dev->irq = irq;
-			pci_writeb(dev, PCI_INTERRUPT_LINE, irq);
+			pdev->irq = irq;
+			pci_writeb(pdev, PCI_INTERRUPT_LINE, irq);
 		}
-
-		pci_enable_device(dev); /* XXX check return */
-		pci_insert_device(dev, bus);
+		pci_enable_device(pdev);
+		pci_insert_device(pdev,bus);
 	}
-
-	s->cb_config = c;
 	s->irq.AssignedIRQ = irq;
 	return CS_SUCCESS;
 }
 
 void cb_free(socket_info_t * s)
 {
-	cb_config_t *c = s->cb_config;
-
-	if (c) {
-		int i;
+	struct pci_bus * bus = s->cap.cb_dev->subordinate;
+	list_t * node = bus->devices.next;
 
-		s->cb_config = NULL;
-		for (i = 0 ; i < s->functions ; i++)
-			pci_remove_device(&c[i].dev);
 
-		kfree(c);
-		printk(KERN_INFO "cs: cb_free(bus %d)\n", s->cap.cb_dev->subordinate->number);
+	while(node != &bus->devices) {
+		struct pci_dev	* pdev = list_entry(node,struct pci_dev,bus_list);
+		pci_remove_device(pdev);
+		node = bus->devices.next;
 	}
+
+	printk(KERN_INFO "cs: cb_free(bus %d)\n", bus->number);
 }
 
 /*=====================================================================
@@ -374,27 +342,25 @@
 
 void cb_enable(socket_info_t * s)
 {
-	struct pci_dev *dev;
-	u_char i;
+	list_t	* node;
+	struct pci_bus * bus = s->cap.cb_dev->subordinate;
 
-	DEBUG(0, "cs: cb_enable(bus %d)\n", s->cap.cb_dev->subordinate->number);
+	DEBUG(0, "cs: cb_enable(bus %d)\n", bus->number);
 
 	/* Configure bridge */
 	cb_release_cis_mem(s);
 
 	/* Set up PCI interrupt and command registers */
-	for (i = 0; i < s->functions; i++) {
-		dev = &s->cb_config[i].dev;
+	list_for_each(node,&bus->devices) {
+		struct pci_dev * dev = list_entry(node,struct pci_dev,bus_list);
 		pci_writeb(dev, PCI_COMMAND, PCI_COMMAND_MASTER |
 			   PCI_COMMAND_IO | PCI_COMMAND_MEMORY);
 		pci_writeb(dev, PCI_CACHE_LINE_SIZE, L1_CACHE_BYTES / 4);
-	}
 
-	if (s->irq.AssignedIRQ) {
-		for (i = 0; i < s->functions; i++) {
-			dev = &s->cb_config[i].dev;
+		if (s->irq.AssignedIRQ)
 			pci_writeb(dev, PCI_INTERRUPT_LINE, s->irq.AssignedIRQ);
-		}
+	}
+	if (s->irq.AssignedIRQ) {
 		s->socket.io_irq = s->irq.AssignedIRQ;
 		s->ss_entry->set_socket(s->sock, &s->socket);
 	}

