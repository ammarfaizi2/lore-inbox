Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266888AbTAIRkc>; Thu, 9 Jan 2003 12:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266898AbTAIRkc>; Thu, 9 Jan 2003 12:40:32 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:16900 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S266888AbTAIRk2>; Thu, 9 Jan 2003 12:40:28 -0500
Date: Thu, 9 Jan 2003 20:46:26 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Grant Grundler <grundler@cup.hp.com>,
       Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, davidm@hpl.hp.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       greg@kroah.com
Subject: [patch 2.5] 2-pass PCI probing, generic part
Message-ID: <20030109204626.A2007@jurassic.park.msu.ru>
References: <1041942820.20658.2.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0301070942440.1913-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0301070942440.1913-100000@home.transmeta.com>; from torvalds@transmeta.com on Tue, Jan 07, 2003 at 09:44:53AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As discussed, this patch splits PCI probing into 2 phases.
1. Do the full bus enumeration, collect identification info for
   all devices, call early fixup routines. At this stage we
   can solve two kinds of problems:
   - turn off devices generating PCI traffic, so we'll be
     safe in the phase 2 (USB DMA case);
   - allow alternative probing methods for devices that
     cannot be safely probed by generic code (powermac I/O ASIC).
2. Sizing the BARs. Now it's possible to disable the device
   being probed, which should fix ia64 case. Note that we
   don't need to keep the device disabled when sizing ROM
   base register, as we probe with ROM-enable bit cleared.

There is no need for changes to arch-specific code, as everything
is hidden in pci_scan_bus(). However, it's possible to use
pci_scan_bus_parented() and pci_probe_resources() directly,
because some arch-specific fixups between these two might
be useful.

Note: on powermacs, if the I/O ASIC is behind PCI-PCI bridge, the
bridge device probably should be marked as "skip_probe" as well.

Ivan.

diff -urpN 2.5.55/drivers/pci/probe.c linux/drivers/pci/probe.c
--- 2.5.55/drivers/pci/probe.c	Thu Jan  9 07:04:19 2003
+++ linux/drivers/pci/probe.c	Thu Jan  9 13:47:47 2003
@@ -47,8 +47,17 @@ static void pci_read_bases(struct pci_de
 {
 	unsigned int pos, reg, next;
 	u32 l, sz;
+	u16 cmd;
 	struct resource *res;
 
+	if (dev->skip_probe)
+		return;
+
+	/* Disable I/O & memory decoding while we size the BARs. */
+	pci_read_config_word(dev, PCI_COMMAND, &cmd);
+	pci_write_config_word(dev, PCI_COMMAND,
+			      cmd & ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY));
+
 	for(pos=0; pos<howmany; pos = next) {
 		next = pos+1;
 		res = &dev->resource[pos];
@@ -96,6 +105,9 @@ static void pci_read_bases(struct pci_de
 #endif
 		}
 	}
+
+	pci_write_config_word(dev, PCI_COMMAND, cmd);
+
 	if (rom) {
 		dev->rom_base_reg = rom;
 		res = &dev->resource[PCI_ROM_RESOURCE];
@@ -342,7 +354,7 @@ static void pci_read_irq(struct pci_dev 
  * @dev: the device structure to fill
  *
  * Initialize the device structure with information about the device's 
- * vendor,class,memory and IO-space addresses,IRQ lines etc.
+ * vendor, memory and IO-space addresses, IRQ lines etc.
  * Called at initialisation of the PCI subsystem and by CardBus services.
  * Returns 0 on success and -1 if unknown type of device (not normal, bridge
  * or CardBus).
@@ -351,14 +363,9 @@ int pci_setup_device(struct pci_dev * de
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
 
@@ -410,8 +417,8 @@ int pci_setup_device(struct pci_dev * de
 }
 
 /*
- * Read the config data for a PCI device, sanity-check it
- * and fill in the dev structure...
+ * Read the config data for a PCI device and fill in
+ * the dev structure...
  */
 struct pci_dev * __devinit pci_scan_device(struct pci_dev *temp)
 {
@@ -433,18 +440,23 @@ struct pci_dev * __devinit pci_scan_devi
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
@@ -480,13 +492,12 @@ struct pci_dev * __devinit pci_scan_slot
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
@@ -510,11 +521,8 @@ unsigned int __devinit pci_do_scan_bus(s
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
@@ -545,6 +553,38 @@ int __devinit pci_bus_exists(const struc
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
@@ -600,4 +640,5 @@ EXPORT_SYMBOL(pci_do_scan_bus);
 EXPORT_SYMBOL(pci_scan_slot);
 EXPORT_SYMBOL(pci_scan_bus);
 EXPORT_SYMBOL(pci_scan_bridge);
+EXPORT_SYMBOL(pci_probe_resources);
 #endif
diff -urpN 2.5.55/include/linux/pci.h linux/include/linux/pci.h
--- 2.5.55/include/linux/pci.h	Thu Jan  9 07:04:13 2003
+++ linux/include/linux/pci.h	Thu Jan  9 13:40:32 2003
@@ -412,7 +412,8 @@ struct pci_dev {
 	char		slot_name[8];	/* slot name */
 
 	/* These fields are used by common fixups */
-	unsigned int	transparent:1;	/* Transparent PCI bridge */
+	unsigned int	transparent:1,	/* Transparent PCI bridge */
+			skip_probe:1;	/* Don't probe the BARs */
 };
 
 #define pci_dev_g(n) list_entry(n, struct pci_dev, global_list)
@@ -544,11 +545,14 @@ void pcibios_fixup_pbus_ranges(struct pc
 
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
@@ -809,8 +813,11 @@ struct pci_fixup {
 
 extern struct pci_fixup pcibios_fixups[];
 
-#define PCI_FIXUP_HEADER	1		/* Called immediately after reading configuration header */
-#define PCI_FIXUP_FINAL		2		/* Final phase of device fixups */
+#define PCI_FIXUP_EARLY		1	/* Called immediately after reading
+					   device/vendor IDs and class code */
+#define PCI_FIXUP_HEADER	2	/* Called after reading configuration
+					   header (including BARs) */
+#define PCI_FIXUP_FINAL		3	/* Final phase of device fixups */
 
 void pci_fixup_device(int pass, struct pci_dev *dev);
 
