Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265132AbSLQRMh>; Tue, 17 Dec 2002 12:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265238AbSLQRMh>; Tue, 17 Dec 2002 12:12:37 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:44550 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S265132AbSLQRMS>; Tue, 17 Dec 2002 12:12:18 -0500
Date: Tue, 17 Dec 2002 20:19:38 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 2.5] PCI: kill pdev_enable_device()
Message-ID: <20021217201938.A16940@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, only Alpha relied on that due to the lack of pcibios_enable_device(),
which has been fixed recently.

- Don't disable io, mem and master bits in the PCI command
  registers during resource re-allocation. The initial motivation
  was to avoid temporarily overlaps of the PCI io/memory ranges. But,
  this can be harmful _only_ if someone was actually accessing these
  ranges in the meantime. However, in this case an access to _disabled_
  region would be equally bad.
  Also, clearing the PCI_COMMAND_MASTER bit might be fatal for things like
  USB consoles.
- So, if we don't touch the PCI command registers, there is no point in
  using pdev_enable_device(). Most drivers properly use
  pci_enable_device() anyway.

Ivan.

--- 2.5/drivers/pci/setup-res.c	Sun Nov 24 17:00:08 2002
+++ linux/drivers/pci/setup-res.c	Thu Nov 28 12:07:37 2002
@@ -183,57 +183,3 @@ pdev_sort_resources(struct pci_dev *dev,
 		}
 	}
 }
-
-void __init
-pdev_enable_device(struct pci_dev *dev)
-{
-	u32 reg;
-	u16 cmd;
-	int i;
-
-	DBGC((KERN_ERR "PCI enable device: (%s)\n", dev->name));
-
-	pci_read_config_word(dev, PCI_COMMAND, &cmd);
-
-	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-		struct resource *res = &dev->resource[i];
-
-		if (res->flags & IORESOURCE_IO)
-			cmd |= PCI_COMMAND_IO;
-		else if (res->flags & IORESOURCE_MEM)
-			cmd |= PCI_COMMAND_MEMORY;
-	}
-
-	/* Special case, disable the ROM.  Several devices act funny
-	   (ie. do not respond to memory space writes) when it is left
-	   enabled.  A good example are QlogicISP adapters.  */
-
-	if (dev->rom_base_reg) {
-		pci_read_config_dword(dev, dev->rom_base_reg, &reg);
-		reg &= ~PCI_ROM_ADDRESS_ENABLE;
-		pci_write_config_dword(dev, dev->rom_base_reg, reg);
-		dev->resource[PCI_ROM_RESOURCE].flags &= ~PCI_ROM_ADDRESS_ENABLE;
-	}
-
-	/* All of these (may) have I/O scattered all around and may not
-	   use I/O base address registers at all.  So we just have to
-	   always enable IO to these devices.  */
-	if ((dev->class >> 8) == PCI_CLASS_NOT_DEFINED
-	    || (dev->class >> 8) == PCI_CLASS_NOT_DEFINED_VGA
-	    || (dev->class >> 8) == PCI_CLASS_STORAGE_IDE
-	    || (dev->class >> 16) == PCI_BASE_CLASS_DISPLAY) {
-		cmd |= PCI_COMMAND_IO;
-	}
-
-	/* Do not enable bus mastering.  A device could corrupt
-	 * system memory by DMAing before a driver is ready for it. */
-
-	/* Set the cache line and default latency (32).  */
-	pci_write_config_word(dev, PCI_CACHE_LINE_SIZE,
-			(32 << 8) | (L1_CACHE_BYTES / sizeof(u32)));
-
-	/* Enable the appropriate bits in the PCI command register.  */
-	pci_write_config_word(dev, PCI_COMMAND, cmd);
-
-	DBGC((KERN_ERR "  cmd reg 0x%x\n", cmd));
-}
--- 2.5/drivers/pci/setup-bus.c	Sun Nov 24 17:00:08 2002
+++ linux/drivers/pci/setup-bus.c	Thu Nov 28 12:07:37 2002
@@ -48,22 +48,21 @@ pbus_assign_resources_sorted(struct pci_
 	for (ln=bus->devices.next; ln != &bus->devices; ln=ln->next) {
 		struct pci_dev *dev = pci_dev_b(ln);
 		u16 class = dev->class >> 8;
-		u16 cmd;
+		u32 rom;
 
-		/* First, disable the device to avoid side
-		   effects of possibly overlapping I/O and
-		   memory ranges.
-		   Leave VGA enabled - for obvious reason. :-)
-		   Same with all sorts of bridges - they may
-		   have VGA behind them.  */
 		if (class == PCI_CLASS_DISPLAY_VGA
 				|| class == PCI_CLASS_NOT_DEFINED_VGA)
 			found_vga = 1;
-		else if (class >> 8 != PCI_BASE_CLASS_BRIDGE) {
-			pci_read_config_word(dev, PCI_COMMAND, &cmd);
-			cmd &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY
-						| PCI_COMMAND_MASTER);
-			pci_write_config_word(dev, PCI_COMMAND, cmd);
+
+		/* Special case, disable the ROM.  Several devices act funny
+		   (ie. do not respond to memory space writes) when it is left
+		   enabled.  A good example are QlogicISP adapters.  */
+		if (dev->rom_base_reg) {
+			pci_read_config_dword(dev, dev->rom_base_reg, &rom);
+			rom &= ~PCI_ROM_ADDRESS_ENABLE;
+			pci_write_config_dword(dev, dev->rom_base_reg, rom);
+			dev->resource[PCI_ROM_RESOURCE].flags &=
+						~PCI_ROM_ADDRESS_ENABLE;
 		}
 
 		pdev_sort_resources(dev, &head);
@@ -387,7 +386,6 @@ void __init
 pci_assign_unassigned_resources(void)
 {
 	struct list_head *ln;
-	struct pci_dev *dev;
 
 	/* Depth first, calculate sizes and alignments of all
 	   subordinate buses. */
@@ -396,8 +394,4 @@ pci_assign_unassigned_resources(void)
 	/* Depth last, allocate resources and update the hardware. */
 	for(ln=pci_root_buses.next; ln != &pci_root_buses; ln=ln->next)
 		pci_bus_assign_resources(pci_bus_b(ln));
-
-	pci_for_each_dev(dev) {
-		pdev_enable_device(dev);
-	}
 }
