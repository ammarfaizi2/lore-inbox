Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265338AbTFZCgs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 22:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265339AbTFZCgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 22:36:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56775 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265338AbTFZCgq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 22:36:46 -0400
Date: Thu, 26 Jun 2003 03:50:57 +0100
From: Matthew Wilcox <willy@debian.org>
To: Greg KH <greg@kroah.com>
Cc: Matthew Wilcox <willy@debian.org>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] pci_name()
Message-ID: <20030626025057.GE451@parcelfarce.linux.theplanet.co.uk>
References: <20030625233525.GB451@parcelfarce.linux.theplanet.co.uk> <20030626003620.GB13892@kroah.com> <20030626005315.GD451@parcelfarce.linux.theplanet.co.uk> <20030626010239.GB15189@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030626010239.GB15189@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 25, 2003 at 06:02:40PM -0700, Greg KH wrote:
> Ok, I'll buy that, feel free to send the patch :)

It's kind of late to be writing patches ... but this boots & works for me.

This patch introduces pci_name() and converts slot_name into a pointer to
dev.bus_id.

Index: drivers/pci/probe.c
===================================================================
RCS file: /var/cvs/linux-2.5/drivers/pci/probe.c,v
retrieving revision 1.16
diff -u -p -r1.16 probe.c
--- drivers/pci/probe.c	23 Jun 2003 03:30:26 -0000	1.16
+++ drivers/pci/probe.c	26 Jun 2003 02:45:53 -0000
@@ -106,7 +109,7 @@ static void pci_read_bases(struct pci_de
 						(((unsigned long) ~sz) << 32);
 #else
 			if (l) {
-				printk(KERN_ERR "PCI: Unable to handle 64-bit address for device %s\n", dev->slot_name);
+				printk(KERN_ERR "PCI: Unable to handle 64-bit address for device %s\n", pci_name(dev));
 				res->start = 0;
 				res->flags = 0;
 				continue;
@@ -301,7 +304,7 @@ int __devinit pci_scan_bridge(struct pci
 	pci_read_config_dword(dev, PCI_PRIMARY_BUS, &buses);
 
 	DBG("Scanning behind PCI bridge %s, config %06x, pass %d\n",
-	    dev->slot_name, buses & 0xffffff, pass);
+	    pci_name(dev), buses & 0xffffff, pass);
 
 	if ((buses & 0xffff00) && !pcibios_assign_all_busses() && !is_cardbus) {
 		unsigned int cmax;
@@ -400,8 +403,9 @@ static int pci_setup_device(struct pci_d
 {
 	u32 class;
 
-	sprintf(dev->slot_name, "%02x:%02x.%d", dev->bus->number,
-		PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
+	dev->slot_name = dev->dev.bus_id;
+	sprintf(pci_name(dev), "%04x:%02x:%02x.%d", pci_domain_nr(dev->bus),
+		dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
 	sprintf(dev->dev.name, "PCI device %04x:%04x",
 		dev->vendor, dev->device);
 
@@ -449,12 +453,12 @@ static int pci_setup_device(struct pci_d
 
 	default:				    /* unknown header */
 		printk(KERN_ERR "PCI: device %s has unknown header type %02x, ignoring.\n",
-			dev->slot_name, dev->hdr_type);
+			pci_name(dev), dev->hdr_type);
 		return -1;
 
 	bad:
 		printk(KERN_ERR "PCI: %s: class %x doesn't match header type %02x. Ignoring class.\n",
-		       dev->slot_name, class, dev->hdr_type);
+		       pci_name(dev), class, dev->hdr_type);
 		dev->class = PCI_CLASS_NOT_DEFINED;
 	}
 
@@ -528,9 +532,6 @@ pci_scan_device(struct pci_bus *bus, int
 
 	pci_name_device(dev);
 
-	/* now put in global tree */
-	sprintf(dev->dev.bus_id, "%04x:%s", pci_domain_nr(bus),
-			dev->slot_name);
 	dev->dev.dma_mask = &dev->dma_mask;
 
 	return dev;
Index: include/linux/pci.h
===================================================================
RCS file: /var/cvs/linux-2.5/include/linux/pci.h,v
retrieving revision 1.18
diff -u -p -r1.18 pci.h
--- include/linux/pci.h	23 Jun 2003 03:30:53 -0000	1.18
+++ include/linux/pci.h	26 Jun 2003 02:45:54 -0000
@@ -414,7 +414,7 @@ struct pci_dev {
 	struct resource dma_resource[DEVICE_COUNT_DMA];
 	struct resource irq_resource[DEVICE_COUNT_IRQ];
 
-	char		slot_name[8];	/* slot name */
+	char *		slot_name;	/* pointer to dev.bus_id */
 
 	/* These fields are used by common fixups */
 	unsigned int	transparent:1;	/* Transparent PCI bridge */
@@ -802,6 +802,14 @@ static inline void *pci_get_drvdata (str
 static inline void pci_set_drvdata (struct pci_dev *pdev, void *data)
 {
 	dev_set_drvdata(&pdev->dev, data);
+}
+
+/* If you want to know what to call your pci_dev, ask this function.
+ * Again, it's a wrapper around the generic device.
+ */
+static inline char *pci_name(struct pci_dev *pdev)
+{
+	return pdev->dev.bus_id;
 }
 
 /*

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
