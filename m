Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263459AbTF0Cok (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 22:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263462AbTF0CoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 22:44:04 -0400
Received: from granite.he.net ([216.218.226.66]:42255 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S263496AbTF0CnD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 22:43:03 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10566751051544@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.73
In-Reply-To: <10566751054129@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 26 Jun 2003 17:51:45 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1504, 2003/06/26 17:27:43-07:00, willy@debian.org

[PATCH] PCI: create pci_name()

This patch introduces pci_name() and converts slot_name into a pointer to
dev.bus_id.


 drivers/pci/probe.c |   16 +++++++---------
 include/linux/pci.h |   10 +++++++++-
 2 files changed, 16 insertions(+), 10 deletions(-)


diff -Nru a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c	Thu Jun 26 17:38:52 2003
+++ b/drivers/pci/probe.c	Thu Jun 26 17:38:52 2003
@@ -109,7 +109,7 @@
 						(((unsigned long) ~sz) << 32);
 #else
 			if (l) {
-				printk(KERN_ERR "PCI: Unable to handle 64-bit address for device %s\n", dev->slot_name);
+				printk(KERN_ERR "PCI: Unable to handle 64-bit address for device %s\n", pci_name(dev));
 				res->start = 0;
 				res->flags = 0;
 				continue;
@@ -304,7 +304,7 @@
 	pci_read_config_dword(dev, PCI_PRIMARY_BUS, &buses);
 
 	DBG("Scanning behind PCI bridge %s, config %06x, pass %d\n",
-	    dev->slot_name, buses & 0xffffff, pass);
+	    pci_name(dev), buses & 0xffffff, pass);
 
 	if ((buses & 0xffff00) && !pcibios_assign_all_busses() && !is_cardbus) {
 		unsigned int cmax;
@@ -403,8 +403,9 @@
 {
 	u32 class;
 
-	sprintf(dev->slot_name, "%02x:%02x.%d", dev->bus->number,
-		PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
+	dev->slot_name = dev->dev.bus_id;
+	sprintf(pci_name(dev), "%04x:%02x:%02x.%d", pci_domain_nr(dev->bus),
+		dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
 	sprintf(dev->dev.name, "PCI device %04x:%04x",
 		dev->vendor, dev->device);
 
@@ -452,12 +453,12 @@
 
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
 
@@ -531,9 +532,6 @@
 
 	pci_name_device(dev);
 
-	/* now put in global tree */
-	sprintf(dev->dev.bus_id, "%04x:%s", pci_domain_nr(bus),
-			dev->slot_name);
 	dev->dev.dma_mask = &dev->dma_mask;
 
 	return dev;
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Thu Jun 26 17:38:51 2003
+++ b/include/linux/pci.h	Thu Jun 26 17:38:51 2003
@@ -414,7 +414,7 @@
 	struct resource dma_resource[DEVICE_COUNT_DMA];
 	struct resource irq_resource[DEVICE_COUNT_IRQ];
 
-	char		slot_name[8];	/* slot name */
+	char *		slot_name;	/* pointer to dev.bus_id */
 
 	/* These fields are used by common fixups */
 	unsigned int	transparent:1;	/* Transparent PCI bridge */
@@ -802,6 +802,14 @@
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

