Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265066AbSKNRFa>; Thu, 14 Nov 2002 12:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265039AbSKNREC>; Thu, 14 Nov 2002 12:04:02 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3089 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265037AbSKNRDY>;
	Thu, 14 Nov 2002 12:03:24 -0500
Date: Thu, 14 Nov 2002 17:10:17 +0000
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, mochel@osdl.org
Subject: [PATCH] eliminate pci_dev name
Message-ID: <20021114171017.B30392@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Since struct device doesn't seem to be going away any time soon, let's
start trying to use it properly.  This patch reclaims 90 bytes from each &
every pci_dev in the system.  If this patch is accepted, I'll follow up
with other patches removing more of the pci_dev components.

diff -urpNX dontdiff linux-2.5.47/drivers/pci/names.c linux-2.5.47-willy/drivers/pci/names.c
--- linux-2.5.47/drivers/pci/names.c	2002-10-01 03:06:17.000000000 -0400
+++ linux-2.5.47-willy/drivers/pci/names.c	2002-11-14 11:51:19.000000000 -0500
@@ -56,7 +56,7 @@ void __devinit pci_name_device(struct pc
 {
 	const struct pci_vendor_info *vendor_p = pci_vendor_list;
 	int i = VENDORS;
-	char *name = dev->name;
+	char *name = dev->dev.name;
 
 	do {
 		if (vendor_p->vendor == dev->vendor)
diff -urpNX dontdiff linux-2.5.47/drivers/pci/probe.c linux-2.5.47-willy/drivers/pci/probe.c
--- linux-2.5.47/drivers/pci/probe.c	2002-11-14 10:52:13.000000000 -0500
+++ linux-2.5.47-willy/drivers/pci/probe.c	2002-11-14 11:48:24.000000000 -0500
@@ -52,7 +52,7 @@ static void pci_read_bases(struct pci_de
 	for(pos=0; pos<howmany; pos = next) {
 		next = pos+1;
 		res = &dev->resource[pos];
-		res->name = dev->name;
+		res->name = dev->dev.name;
 		reg = PCI_BASE_ADDRESS_0 + (pos << 2);
 		pci_read_config_dword(dev, reg, &l);
 		pci_write_config_dword(dev, reg, ~0);
@@ -112,7 +112,7 @@ static void pci_read_bases(struct pci_de
 			sz = pci_size(sz, PCI_ROM_ADDRESS_MASK);
 			res->end = res->start + (unsigned long) sz;
 		}
-		res->name = dev->name;
+		res->name = dev->dev.name;
 	}
 }
 
@@ -129,7 +129,7 @@ void __devinit pci_read_bridge_bases(str
 		return;
 
 	if (dev->transparent) {
-		printk("Transparent bridge - %s\n", dev->name);
+		printk("Transparent bridge - %s\n", dev->dev.name);
 		for(i = 0; i < PCI_BUS_NUM_RESOURCES; i++)
 			child->resource[i] = child->parent->resource[i];
 		return;
@@ -355,7 +355,7 @@ int pci_setup_device(struct pci_dev * de
 	u32 class;
 
 	sprintf(dev->slot_name, "%02x:%02x.%d", dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
-	sprintf(dev->name, "PCI device %04x:%04x", dev->vendor, dev->device);
+	sprintf(dev->dev.name, "PCI device %04x:%04x", dev->vendor, dev->device);
 	INIT_LIST_HEAD(&dev->pools);
 	
 	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class);
@@ -447,7 +447,6 @@ struct pci_dev * __devinit pci_scan_devi
 	pci_name_device(dev);
 
 	/* now put in global tree */
-	strcpy(dev->dev.name,dev->name);
 	strcpy(dev->dev.bus_id,dev->slot_name);
 
 	device_register(&dev->dev);
diff -urpNX dontdiff linux-2.5.47/drivers/pci/proc.c linux-2.5.47-willy/drivers/pci/proc.c
--- linux-2.5.47/drivers/pci/proc.c	2002-10-01 03:07:05.000000000 -0400
+++ linux-2.5.47-willy/drivers/pci/proc.c	2002-11-14 11:52:15.000000000 -0500
@@ -511,7 +511,7 @@ static int show_dev_config(struct seq_fi
 		seq_printf(m, "    %s", class);
 	else
 		seq_printf(m, "    Class %04x", class_rev >> 16);
-	seq_printf(m, ": %s (rev %d).\n", dev->name, class_rev & 0xff);
+	seq_printf(m, ": %s (rev %d).\n", dev->dev.name, class_rev & 0xff);
 
 	if (dev->irq)
 		seq_printf(m, "      IRQ %d.\n", dev->irq);
diff -urpNX dontdiff linux-2.5.47/drivers/pci/quirks.c linux-2.5.47-willy/drivers/pci/quirks.c
--- linux-2.5.47/drivers/pci/quirks.c	2002-11-14 10:52:13.000000000 -0500
+++ linux-2.5.47-willy/drivers/pci/quirks.c	2002-11-14 11:49:24.000000000 -0500
@@ -203,7 +203,7 @@ static void __devinit quirk_io_region(st
 	if (region) {
 		struct resource *res = dev->resource + nr;
 
-		res->name = dev->name;
+		res->name = dev->dev.name;
 		res->start = region;
 		res->end = region + size - 1;
 		res->flags = IORESOURCE_IO;
diff -urpNX dontdiff linux-2.5.47/drivers/pci/setup-res.c linux-2.5.47-willy/drivers/pci/setup-res.c
--- linux-2.5.47/drivers/pci/setup-res.c	2002-10-01 03:07:36.000000000 -0400
+++ linux-2.5.47-willy/drivers/pci/setup-res.c	2002-11-14 11:53:46.000000000 -0500
@@ -46,11 +46,11 @@ pci_claim_resource(struct pci_dev *dev, 
 		if (err) {
 			printk(KERN_ERR "PCI: Address space collision on "
 			       "region %d of device %s [%lx:%lx]\n",
-			       resource, dev->name, res->start, res->end);
+			       resource, dev->dev.name, res->start, res->end);
 		}
 	} else {
 		printk(KERN_ERR "PCI: No parent found for region %d "
-		       "of device %s\n", resource, dev->name);
+		       "of device %s\n", resource, dev->dev.name);
 	}
 
 	return err;
@@ -155,7 +155,7 @@ pdev_sort_resources(struct pci_dev *dev,
 		if (!r_align) {
 			printk(KERN_WARNING "PCI: Ignore bogus resource %d "
 					    "[%lx:%lx] of %s\n",
-					    i, r->start, r->end, dev->name);
+					    i, r->start, r->end, dev->dev.name);
 			continue;
 		}
 		r_align = (i < PCI_BRIDGE_RESOURCES) ? r_align + 1 : r->start;
diff -urpNX dontdiff linux-2.5.47/drivers/pcmcia/cardbus.c linux-2.5.47-willy/drivers/pcmcia/cardbus.c
--- linux-2.5.47/drivers/pcmcia/cardbus.c	2002-11-14 10:52:13.000000000 -0500
+++ linux-2.5.47-willy/drivers/pcmcia/cardbus.c	2002-11-14 11:55:07.000000000 -0500
@@ -284,7 +284,6 @@ int cb_alloc(socket_info_t * s)
 
 		pci_setup_device(dev);
 
-		strcpy(dev->dev.name, dev->name);
 		strcpy(dev->dev.bus_id, dev->slot_name);
 
 		/* FIXME: Do we need to enable the expansion ROM? */
diff -urpNX dontdiff linux-2.5.47/drivers/pcmcia/yenta.c linux-2.5.47-willy/drivers/pcmcia/yenta.c
--- linux-2.5.47/drivers/pcmcia/yenta.c	2002-10-15 09:32:33.000000000 -0400
+++ linux-2.5.47-willy/drivers/pcmcia/yenta.c	2002-11-14 11:56:23.000000000 -0500
@@ -585,7 +585,7 @@ static void yenta_open_bh(void * data)
 	/* It's OK to overwrite this now */
 	INIT_WORK(&socket->tq_task, yenta_bh, socket);
 
-	if (!socket->cb_irq || request_irq(socket->cb_irq, yenta_interrupt, SA_SHIRQ, socket->dev->name, socket)) {
+	if (!socket->cb_irq || request_irq(socket->cb_irq, yenta_interrupt, SA_SHIRQ, socket->dev->dev.name, socket)) {
 		/* No IRQ or request_irq failed. Poll */
 		socket->cb_irq = 0; /* But zero is a valid IRQ number. */
 		socket->poll_timer.function = yenta_interrupt_wrapper;
diff -urpNX dontdiff linux-2.5.47/drivers/usb/core/hcd-pci.c linux-2.5.47-willy/drivers/usb/core/hcd-pci.c
--- linux-2.5.47/drivers/usb/core/hcd-pci.c	2002-10-16 08:34:38.000000000 -0400
+++ linux-2.5.47-willy/drivers/usb/core/hcd-pci.c	2002-11-14 11:57:43.000000000 -0500
@@ -137,7 +137,7 @@ clean_2:
 	hcd->description = driver->description;
 	hcd->pdev = dev;
 	hcd->self.bus_name = dev->slot_name;
-	hcd->product_desc = dev->name;
+	hcd->product_desc = dev->dev.name;
 
 	if ((retval = hcd_buffer_create (hcd)) != 0) {
 clean_3:
@@ -145,7 +145,7 @@ clean_3:
 		goto clean_2;
 	}
 
-	info ("%s @ %s, %s", hcd->description,  dev->slot_name, dev->name);
+	info ("%s @ %s, %s", hcd->description,  dev->slot_name, dev->dev.name);
 
 #ifndef __sparc__
 	sprintf (buf, "%d", dev->irq);
diff -urpNX dontdiff linux-2.5.47/include/linux/pci.h linux-2.5.47-willy/include/linux/pci.h
--- linux-2.5.47/include/linux/pci.h	2002-11-14 10:52:17.000000000 -0500
+++ linux-2.5.47-willy/include/linux/pci.h	2002-11-14 11:43:40.000000000 -0500
@@ -371,7 +371,6 @@ struct pci_dev {
 	struct resource dma_resource[DEVICE_COUNT_DMA];
 	struct resource irq_resource[DEVICE_COUNT_IRQ];
 
-	char		name[90];	/* device name */
 	char		slot_name[8];	/* slot name */
 	int		active;		/* ISAPnP: device is active */
 	int		ro;		/* ISAPnP: read only */

-- 
Revolutions do not require corporate support.
