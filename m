Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272215AbTHIAg0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 20:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272169AbTHIAdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 20:33:22 -0400
Received: from mail.kroah.org ([65.200.24.183]:63679 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S272165AbTHIAcb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 20:32:31 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10603891331781@kroah.com>
Subject: [PATCH] More PCI fixes for 2.6.0-test2
In-Reply-To: <20030809003036.GA3163@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 8 Aug 2003 17:32:13 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1119.1.1, 2003/08/06 15:41:22-07:00, greg@kroah.com

[PATCH] PCI: remove all struct device.name usage from the PCI core code.

This is because that field is going away shortly...


 drivers/pci/names.c     |    2 +-
 drivers/pci/probe.c     |    9 +++------
 drivers/pci/proc.c      |    7 ++++++-
 drivers/pci/quirks.c    |    2 +-
 drivers/pci/setup-bus.c |    2 +-
 drivers/pci/setup-res.c |    2 +-
 include/linux/pci.h     |    3 +++
 7 files changed, 16 insertions(+), 11 deletions(-)


diff -Nru a/drivers/pci/names.c b/drivers/pci/names.c
--- a/drivers/pci/names.c	Fri Aug  8 17:25:15 2003
+++ b/drivers/pci/names.c	Fri Aug  8 17:25:15 2003
@@ -56,7 +56,7 @@
 {
 	const struct pci_vendor_info *vendor_p = pci_vendor_list;
 	int i = VENDORS;
-	char *name = dev->dev.name;
+	char *name = dev->pretty_name;
 
 	do {
 		if (vendor_p->vendor == dev->vendor)
diff -Nru a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c	Fri Aug  8 17:25:15 2003
+++ b/drivers/pci/probe.c	Fri Aug  8 17:25:15 2003
@@ -69,7 +69,7 @@
 	for(pos=0; pos<howmany; pos = next) {
 		next = pos+1;
 		res = &dev->resource[pos];
-		res->name = dev->dev.name;
+		res->name = pci_name(dev);
 		reg = PCI_BASE_ADDRESS_0 + (pos << 2);
 		pci_read_config_dword(dev, reg, &l);
 		pci_write_config_dword(dev, reg, ~0);
@@ -120,7 +120,7 @@
 	if (rom) {
 		dev->rom_base_reg = rom;
 		res = &dev->resource[PCI_ROM_RESOURCE];
-		res->name = dev->dev.name;
+		res->name = pci_name(dev);
 		pci_read_config_dword(dev, rom, &l);
 		pci_write_config_dword(dev, rom, ~PCI_ROM_ADDRESS_ENABLE);
 		pci_read_config_dword(dev, rom, &sz);
@@ -153,7 +153,7 @@
 		return;
 
 	if (dev->transparent) {
-		printk("Transparent bridge - %s\n", dev->dev.name);
+		printk("Transparent bridge - %s\n", pci_name(dev));
 		for(i = 0; i < PCI_BUS_NUM_RESOURCES; i++)
 			child->resource[i] = child->parent->resource[i];
 		return;
@@ -406,8 +406,6 @@
 	dev->slot_name = dev->dev.bus_id;
 	sprintf(pci_name(dev), "%04x:%02x:%02x.%d", pci_domain_nr(dev->bus),
 		dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
-	sprintf(dev->dev.name, "PCI device %04x:%04x",
-		dev->vendor, dev->device);
 
 	INIT_LIST_HEAD(&dev->pools);
 
@@ -663,7 +661,6 @@
 	memset(b->dev,0,sizeof(*(b->dev)));
 	b->dev->parent = parent;
 	sprintf(b->dev->bus_id,"pci%04x:%02x", pci_domain_nr(b), bus);
-	strcpy(b->dev->name,"Host/PCI Bridge");
 	device_register(b->dev);
 
 	b->number = b->secondary = bus;
diff -Nru a/drivers/pci/proc.c b/drivers/pci/proc.c
--- a/drivers/pci/proc.c	Fri Aug  8 17:25:15 2003
+++ b/drivers/pci/proc.c	Fri Aug  8 17:25:15 2003
@@ -483,7 +483,12 @@
 		seq_printf(m, "    %s", class);
 	else
 		seq_printf(m, "    Class %04x", class_rev >> 16);
-	seq_printf(m, ": %s (rev %d).\n", dev->dev.name, class_rev & 0xff);
+#ifdef CONFIG_PCI_NAMES
+	seq_printf(m, ": %s", dev->pretty_name);
+#else
+	seq_printf(m, ": PCI device %04x:%04x", dev->vendor, dev->device);
+#endif
+	seq_printf(m, " (rev %d).\n", class_rev & 0xff);
 
 	if (dev->irq)
 		seq_printf(m, "      IRQ %d.\n", dev->irq);
diff -Nru a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c	Fri Aug  8 17:25:15 2003
+++ b/drivers/pci/quirks.c	Fri Aug  8 17:25:15 2003
@@ -219,7 +219,7 @@
 	if (region) {
 		struct resource *res = dev->resource + nr;
 
-		res->name = dev->dev.name;
+		res->name = pci_name(dev);
 		res->start = region;
 		res->end = region + size - 1;
 		res->flags = IORESOURCE_IO;
diff -Nru a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
--- a/drivers/pci/setup-bus.c	Fri Aug  8 17:25:15 2003
+++ b/drivers/pci/setup-bus.c	Fri Aug  8 17:25:15 2003
@@ -141,7 +141,7 @@
 	u32 l;
 
 	DBGC((KERN_INFO "PCI: Bus %d, bridge: %s\n",
-			bus->number, bridge->dev.name));
+			bus->number, pci_name(bridge)));
 
 	/* Set up the top and bottom of the PCI I/O segment for this bus. */
 	pcibios_resource_to_bus(bridge, &region, bus->resource[0]);
diff -Nru a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
--- a/drivers/pci/setup-res.c	Fri Aug  8 17:25:15 2003
+++ b/drivers/pci/setup-res.c	Fri Aug  8 17:25:15 2003
@@ -166,7 +166,7 @@
 		if (!r_align) {
 			printk(KERN_WARNING "PCI: Ignore bogus resource %d "
 					    "[%lx:%lx] of %s\n",
-					    i, r->start, r->end, dev->dev.name);
+					    i, r->start, r->end, pci_name(dev));
 			continue;
 		}
 		r_align = (i < PCI_BRIDGE_RESOURCES) ? r_align + 1 : r->start;
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Fri Aug  8 17:25:15 2003
+++ b/include/linux/pci.h	Fri Aug  8 17:25:15 2003
@@ -419,6 +419,9 @@
 	/* These fields are used by common fixups */
 	unsigned int	transparent:1;	/* Transparent PCI bridge */
 	unsigned int	multifunction:1;/* Part of multi-function device */
+#ifdef CONFIG_PCI_NAMES
+	char		pretty_name[DEVICE_NAME_SIZE];	/* pretty name for users to see */
+#endif
 };
 
 #define pci_dev_g(n) list_entry(n, struct pci_dev, global_list)

