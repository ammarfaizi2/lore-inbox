Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264799AbTANQeg>; Tue, 14 Jan 2003 11:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264836AbTANQeg>; Tue, 14 Jan 2003 11:34:36 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:47364 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S264799AbTANQe1>; Tue, 14 Jan 2003 11:34:27 -0500
Date: Tue, 14 Jan 2003 19:39:57 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Grant Grundler <grundler@cup.hp.com>, Paul Mackerras <paulus@samba.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, davidm@hpl.hp.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       greg@kroah.com
Subject: Re: [patch 2.5] 2-pass PCI probing, generic part
Message-ID: <20030114193957.A1115@jurassic.park.msu.ru>
References: <20030110021904.A15863@localhost.park.msu.ru> <Pine.LNX.4.44.0301091531260.1506-100000@penguin.transmeta.com> <20030110163503.A4486@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030110163503.A4486@jurassic.park.msu.ru>; from ink@jurassic.park.msu.ru on Fri, Jan 10, 2003 at 04:35:03PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We know for a fact that current probing code works fine on
a vast majority of systems, so _not_ disabling all types of
bridges during the probing seems to be a reasonable default
behavior (which can be overridden by PCI quirks, of course).
This should work on x86 and ia64 without any additional fixups,
ppc will need only minimal changes - skip probe for I/O ASIC
and perhaps certain host bridges, no need to care about P2P ones.

Here's updated patch vs. 2.5.58.

Ivan.

--- 2.5.58/drivers/pci/probe.c	Tue Jan 14 13:38:12 2003
+++ linux/drivers/pci/probe.c	Tue Jan 14 15:08:46 2003
@@ -43,12 +43,37 @@ static u32 pci_size(u32 base, unsigned l
 	return size-1;			/* extent = size - 1 */
 }
 
+/* By default, disable I/O & memory decoding while we size the BARs
+   for all devices except bridges. */
+static inline void set_probing_method(struct pci_dev *dev, u16 oldcmd)
+{
+	u16 cmd = oldcmd & ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY);
+
+	switch (dev->probe) {
+	case PCI_PROBE_CMD_ENABLED:
+		break;
+	case PCI_PROBE_DEFAULT:
+		if ((dev->class >> 16) == PCI_BASE_CLASS_BRIDGE)
+			break;
+	case PCI_PROBE_CMD_DISABLED:
+		pci_write_config_word(dev, PCI_COMMAND, cmd);
+	}
+}
+
 static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
 {
 	unsigned int pos, reg, next;
 	u32 l, sz;
+	u16 cmd;
 	struct resource *res;
 
+	if (dev->probe == PCI_PROBE_SKIP)
+		return;
+
+	pci_read_config_word(dev, PCI_COMMAND, &cmd);
+
+	set_probing_method(dev, cmd);
+
 	for(pos=0; pos<howmany; pos = next) {
 		next = pos+1;
 		res = &dev->resource[pos];
@@ -96,6 +121,9 @@ static void pci_read_bases(struct pci_de
 #endif
 		}
 	}
+
+	pci_write_config_word(dev, PCI_COMMAND, cmd);
+
 	if (rom) {
 		dev->rom_base_reg = rom;
 		res = &dev->resource[PCI_ROM_RESOURCE];
@@ -338,7 +366,7 @@ static void pci_read_irq(struct pci_dev 
  * @dev: the device structure to fill
  *
  * Initialize the device structure with information about the device's 
- * vendor,class,memory and IO-space addresses,IRQ lines etc.
+ * vendor, memory and IO-space addresses, IRQ lines etc.
  * Called at initialisation of the PCI subsystem and by CardBus services.
  * Returns 0 on success and -1 if unknown type of device (not normal, bridge
  * or CardBus).
@@ -347,14 +375,9 @@ int pci_setup_device(struct pci_dev * de
 {
 	u32 class;
 
-	sprintf(dev->slot_name, "%02x:%02x.%d", dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
-	sprintf(dev->dev.name, "PCI device %04x:%04x", dev->vendor, dev->device);
 	INIT_LIST_HEAD(&dev->pools);
 	
-	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class);
-	class >>= 8;				    /* upper 3 bytes */
-	dev->class = class;
-	class >>= 8;
+	class = dev->class >> 8;
 
 	DBG("Found %02x:%02x [%04x/%04x] %06x %02x\n", dev->bus->number, dev->devfn, dev->vendor, dev->device, class, dev->hdr_type);
 
@@ -406,8 +429,8 @@ int pci_setup_device(struct pci_dev * de
 }
 
 /*
- * Read the config data for a PCI device, sanity-check it
- * and fill in the dev structure...
+ * Read the config data for a PCI device and fill in
+ * the dev structure...
  */
 struct pci_dev * __devinit pci_scan_device(struct pci_dev *temp)
 {
@@ -429,18 +452,23 @@ struct pci_dev * __devinit pci_scan_devi
 	dev->vendor = l & 0xffff;
 	dev->device = (l >> 16) & 0xffff;
 
+	pci_read_config_dword(dev, PCI_CLASS_REVISION, &l);
+	dev->class = l >> 8;			    /* upper 3 bytes */
+
 	/* Assume 32-bit PCI; let 64-bit PCI cards (which are far rarer)
 	   set this higher, assuming the system even supports it.  */
 	dev->dma_mask = 0xffffffff;
-	if (pci_setup_device(dev) < 0) {
-		kfree(dev);
-		return NULL;
-	}
 
 	pci_name_device(dev);
 
+	sprintf(dev->slot_name, "%02x:%02x.%d",
+		dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
+
+	/* Early fixups, before probing the BARs */
+	pci_fixup_device(PCI_FIXUP_EARLY, dev);
+
 	/* now put in global tree */
-	strcpy(dev->dev.bus_id,dev->slot_name);
+	strcpy(dev->dev.bus_id, dev->slot_name);
 	dev->dev.dma_mask = &dev->dma_mask;
 
 	device_register(&dev->dev);
@@ -476,13 +504,12 @@ struct pci_dev * __devinit pci_scan_slot
 		 * the per-bus list of devices and add the /proc entry.
 		 */
 		pci_insert_device (dev, bus);
-
-		/* Fix up broken headers */
-		pci_fixup_device(PCI_FIXUP_HEADER, dev);
 	}
 	return first_dev;
 }
 
+/* First phase of device discovery. Build the bus tree, collect header types,
+   class codes, device and vendor IDs. Perform early fixups. */
 unsigned int __devinit pci_do_scan_bus(struct pci_bus *bus)
 {
 	unsigned int devfn, max, pass;
@@ -506,11 +533,8 @@ unsigned int __devinit pci_do_scan_bus(s
 	}
 
 	/*
-	 * After performing arch-dependent fixup of the bus, look behind
-	 * all PCI-to-PCI bridges on this bus.
+	 * Look behind all PCI-to-PCI bridges on this bus.
 	 */
-	DBG("Fixups for bus %02x\n", bus->number);
-	pcibios_fixup_bus(bus);
 	for (pass=0; pass < 2; pass++)
 		for (ln=bus->devices.next; ln != &bus->devices; ln=ln->next) {
 			dev = pci_dev_b(ln);
@@ -541,6 +565,38 @@ int __devinit pci_bus_exists(const struc
 	return 0;
 }
 
+/* Second phase of device discovery. Probe the BARs, fill in the rest
+   of pci_dev structure, perform device and bus fixups. */
+void __devinit pci_probe_resources(struct pci_bus *bus)
+{
+	struct list_head *ln;
+
+	if (!bus)
+		return;
+
+	for (ln = bus->devices.next; ln != &bus->devices; ln = ln->next) {
+		struct pci_dev *dev = pci_dev_b(ln);
+
+		if (pci_setup_device(dev) < 0) {
+			pci_remove_device(dev);
+			kfree(dev);
+		}
+
+		/* Fix up broken headers */
+		pci_fixup_device(PCI_FIXUP_HEADER, dev);
+	}
+
+	/*
+	 * After performing arch-dependent fixup of the bus, look behind
+	 * all PCI-to-PCI bridges on this bus.
+	 */
+	DBG("Fixups for bus %02x\n", bus->number);
+	pcibios_fixup_bus(bus);
+
+	for (ln = bus->children.next; ln != &bus->children; ln = ln->next)
+		pci_probe_resources(pci_bus_b(ln));
+}
+
 struct pci_bus * __devinit pci_alloc_primary_bus_parented(struct device *parent, int bus)
 {
 	struct pci_bus *b;
@@ -594,6 +650,7 @@ EXPORT_SYMBOL(pci_setup_device);
 EXPORT_SYMBOL(pci_add_new_bus);
 EXPORT_SYMBOL(pci_do_scan_bus);
 EXPORT_SYMBOL(pci_scan_slot);
-EXPORT_SYMBOL(pci_scan_bus);
+EXPORT_SYMBOL(pci_scan_bus_parented);
 EXPORT_SYMBOL(pci_scan_bridge);
+EXPORT_SYMBOL(pci_probe_resources);
 #endif
--- 2.5.58/include/linux/pci.h	Fri Jan 10 23:11:51 2003
+++ linux/include/linux/pci.h	Tue Jan 14 14:33:56 2003
@@ -361,6 +361,12 @@ enum pci_mmap_state {
 
 #define PCI_ANY_ID (~0)
 
+/* This defines methods for probing the BARs (dev->probe bits) */
+#define PCI_PROBE_DEFAULT	0
+#define PCI_PROBE_CMD_DISABLED	1
+#define PCI_PROBE_CMD_ENABLED	2
+#define PCI_PROBE_SKIP		3
+
 /*
  * The pci_dev structure is used to describe PCI devices.
  */
@@ -412,7 +418,9 @@ struct pci_dev {
 	char		slot_name[8];	/* slot name */
 
 	/* These fields are used by common fixups */
-	unsigned int	transparent:1;	/* Transparent PCI bridge */
+	unsigned int	transparent:1,	/* Transparent PCI bridge */
+			probe:2;	/* Override default BAR probing
+					   behavior */
 };
 
 #define pci_dev_g(n) list_entry(n, struct pci_dev, global_list)
@@ -544,11 +552,14 @@ void pcibios_fixup_pbus_ranges(struct pc
 
 /* Generic PCI functions used internally */
 
+void pci_probe_resources(struct pci_bus *bus);
 int pci_bus_exists(const struct list_head *list, int nr);
 struct pci_bus *pci_scan_bus_parented(struct device *parent, int bus, struct pci_ops *ops, void *sysdata);
 static inline struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops, void *sysdata)
 {
-	return pci_scan_bus_parented(NULL, bus, ops, sysdata);
+	struct pci_bus *pbus = pci_scan_bus_parented(NULL, bus, ops, sysdata);
+	pci_probe_resources(pbus);
+	return pbus;
 }
 struct pci_bus *pci_alloc_primary_bus_parented(struct device * parent, int bus);
 static inline struct pci_bus *pci_alloc_primary_bus(int bus)
@@ -809,8 +820,11 @@ struct pci_fixup {
 
 extern struct pci_fixup pcibios_fixups[];
 
-#define PCI_FIXUP_HEADER	1		/* Called immediately after reading configuration header */
-#define PCI_FIXUP_FINAL		2		/* Final phase of device fixups */
+#define PCI_FIXUP_EARLY		1	/* Called immediately after reading
+					   device/vendor IDs and class code */
+#define PCI_FIXUP_HEADER	2	/* Called after reading configuration
+					   header (including BARs) */
+#define PCI_FIXUP_FINAL		3	/* Final phase of device fixups */
 
 void pci_fixup_device(int pass, struct pci_dev *dev);
 
