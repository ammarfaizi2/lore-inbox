Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130147AbQKUQ2J>; Tue, 21 Nov 2000 11:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130115AbQKUQ16>; Tue, 21 Nov 2000 11:27:58 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:60421 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S129431AbQKUQ1w>; Tue, 21 Nov 2000 11:27:52 -0500
Date: Tue, 21 Nov 2000 18:52:45 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Richard Henderson <rth@twiddle.net>
Cc: Michal Jaegermann <michal@ellpspace.math.ualberta.ca>,
        linux-kernel@vger.kernel.org, axp-list@redhat.com
Subject: PCI-PCI bridges patch update
Message-ID: <20001121185245.B2889@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Some not critical changes, and a bit more testing was done
(on ux164 - including card with an extra bridge, thanks to Michal).

Changes from bridges-2.4.0t11-rth:
 - Disable devices before changing BARs
 - Handle bridges not supporting IO forwarding
 - Handle bridges with their own IO ports and/or memory
 - Set cache line and default latency for all devices
 - Updated comment for empty IO/memory ranges case

Diffs against bridges-2.4.0t11-rth and pristine 2.4.0-test11 attached.

Ivan.

--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Description: diff vs bridges-2.4.0t11-rth
Content-Disposition: attachment; filename=bridges-for-RTH1

diff -urp 2.4.0t11/arch/alpha/kernel/pci.c linux/arch/alpha/kernel/pci.c
--- 2.4.0t11/arch/alpha/kernel/pci.c	Mon Nov 20 17:10:19 2000
+++ linux/arch/alpha/kernel/pci.c	Mon Nov 20 16:41:36 2000
@@ -264,7 +264,7 @@ pcibios_fixup_bus(struct pci_bus *bus)
 				&dev->resource[PCI_BRIDGE_RESOURCES+i];
 			bus->resource[i]->name = bus->name;
 		}
-		bus->resource[0]->flags |= IORESOURCE_IO;
+		bus->resource[0]->flags |= pci_bridge_check_io(dev);
 		bus->resource[1]->flags |= IORESOURCE_MEM;
 		/* For now, propogate hose limits to the bus;
 		   we'll adjust them later. */
diff -urp 2.4.0t11/drivers/pci/setup-bus.c linux/drivers/pci/setup-bus.c
--- 2.4.0t11/drivers/pci/setup-bus.c	Mon Nov 20 17:10:19 2000
+++ linux/drivers/pci/setup-bus.c	Mon Nov 20 16:55:43 2000
@@ -45,21 +45,29 @@ pbus_assign_resources_sorted(struct pci_
 	head_io.next = head_mem.next = NULL;
 	for (ln=bus->devices.next; ln != &bus->devices; ln=ln->next) {
 		struct pci_dev *dev = pci_dev_b(ln);
+		u16 cmd;
 
-		/* Skip PCI-PCI bridges */
-		if (dev->class >> 8 == PCI_CLASS_BRIDGE_PCI)
-			continue;
-
-		/* ??? Reserve some resources for CardBus */
+		/* First, disable the device to avoid side
+		   effects of possibly overlapping I/O and
+		   memory ranges.
+		   Except the VGA - for obvious reason. :-)  */
+		if (dev->class >> 8 == PCI_CLASS_DISPLAY_VGA)
+			found_vga = 1;
+		else {
+			pci_read_config_word(dev, PCI_COMMAND, &cmd);
+			cmd &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY
+						| PCI_COMMAND_MASTER);
+			pci_write_config_word(dev, PCI_COMMAND, cmd);
+		}
+ 
+		/* Reserve some resources for CardBus.
+		   Are these values reasonable? */
 		if (dev->class >> 8 == PCI_CLASS_BRIDGE_CARDBUS) {
 			io_reserved += 8*1024;
 			mem_reserved += 32*1024*1024;
 			continue;
 		}
 
-		if (dev->class >> 8 == PCI_CLASS_DISPLAY_VGA)
-			found_vga = 1;
-
 		pdev_sort_resources(dev, &head_io, IORESOURCE_IO);
 		pdev_sort_resources(dev, &head_mem, IORESOURCE_MEM);
 	}
@@ -88,15 +96,20 @@ pbus_assign_resources_sorted(struct pci_
 	ranges->io_end += io_reserved;
 	ranges->mem_end += mem_reserved;
 
-	/* ??? How to turn off a bus from responding to, say, I/O at
-	   all if there are no I/O ports behind the bus?  Turning off
-	   PCI_COMMAND_IO doesn't seem to do the job.  So we must
-	   allow for at least one unit.  */
+	/* PCI-to-PCI Bridge Architecture Specification rev. 1.1 (1998)
+	   requires that if there is no I/O ports or memory behind the
+	   bridge, corresponding range must be turned off by writing base
+	   value greater than limit to the bridge's base/limit registers.  */
+#if 1
+	/* But assuming that some hardware designed before 1998 might
+	   not support this (very unlikely - at least all DEC bridges
+	   are ok and I believe that was standard de-facto. -ink), we
+	   must allow for at least one unit.  */
 	if (ranges->io_end == ranges->io_start)
 		ranges->io_end += 1;
 	if (ranges->mem_end == ranges->mem_start)
 		ranges->mem_end += 1;
-
+#endif
 	ranges->io_end = ROUND_UP(ranges->io_end, 4*1024);
 	ranges->mem_end = ROUND_UP(ranges->mem_end, 1024*1024);
 
@@ -123,10 +136,6 @@ pci_setup_bridge(struct pci_bus *bus)
 	DBGC(("  IO window: %04lx-%04lx\n", ranges.io_start, ranges.io_end));
 	DBGC(("  MEM window: %08lx-%08lx\n", ranges.mem_start, ranges.mem_end));
 
-	/* Set the cache line correctly.  */
-	pci_write_config_byte(bridge, PCI_CACHE_LINE_SIZE,
-				      (L1_CACHE_BYTES / sizeof(u32)));
-
 	/* Set up the top and bottom of the PCI I/O segment for this bus. */
 	pci_read_config_dword(bridge, PCI_IO_BASE, &l);
 	l &= 0xffff0000;
@@ -134,14 +143,9 @@ pci_setup_bridge(struct pci_bus *bus)
 	l |= ranges.io_end & 0xf000;
 	pci_write_config_dword(bridge, PCI_IO_BASE, l);
 
-#if 0
-	/* Set up upper 16 bits of I/O base/limit. */
-	l = (ranges.io_start >> 16) & 0xffff;
-	l |= ranges.io_end & 0xffff0000;
-	pci_write_config_dword(bridge, PCI_IO_BASE_UPPER16, l);
-#else
+	/* Clear upper 16 bits of I/O base/limit. */
 	pci_write_config_dword(bridge, PCI_IO_BASE_UPPER16, 0);
-#endif
+
 	/* Clear out the upper 32 bits of PREF base/limit. */
 	pci_write_config_dword(bridge, PCI_PREF_BASE_UPPER32, 0);
 	pci_write_config_dword(bridge, PCI_PREF_LIMIT_UPPER32, 0);
@@ -160,15 +164,7 @@ pci_setup_bridge(struct pci_bus *bus)
 	/* Check if we have VGA behind the bridge.
 	   Enable ISA in either case. */
 	l = (bus->resource[0]->flags & IORESOURCE_BUS_HAS_VGA) ? 0x0c : 0x04;
-	pci_write_config_byte(bridge, PCI_BRIDGE_CONTROL, l);
-
-	/*
-	 * Clear status bits,
-	 * turn on I/O    enable (for downstream I/O),
-	 * turn on memory enable (for downstream memory),
-	 * turn on master enable (for upstream memory and I/O).
-	 */
-	pci_write_config_dword(bridge, PCI_COMMAND, 0xffff0007);
+	pci_write_config_word(bridge, PCI_BRIDGE_CONTROL, l);
 }
 
 static void __init
@@ -225,4 +221,25 @@ pci_assign_unassigned_resources(void)
 	pci_for_each_dev(dev) {
 		pdev_enable_device(dev);
 	}
+}
+
+/* Check whether the bridge supports I/O forwarding.
+   If not, its I/O base/limit register must be
+   read-only and read as 0. */
+unsigned long __init
+pci_bridge_check_io(struct pci_dev *bridge)
+{
+	u16 io;
+
+	pci_read_config_word(bridge, PCI_IO_BASE, &io);
+	if (!io) {
+		pci_write_config_word(bridge, PCI_IO_BASE, 0xf0f0);
+		pci_read_config_word(bridge, PCI_IO_BASE, &io);
+		pci_write_config_word(bridge, PCI_IO_BASE, 0x0);
+	}
+	if (io)
+		return IORESOURCE_IO;
+	printk(KERN_WARNING "PCI: bridge %s does not support I/O forwarding!\n",
+				bridge->name);
+	return 0;
 }
diff -urp 2.4.0t11/drivers/pci/setup-res.c linux/drivers/pci/setup-res.c
--- 2.4.0t11/drivers/pci/setup-res.c	Mon Nov 20 17:10:19 2000
+++ linux/drivers/pci/setup-res.c	Mon Nov 20 16:42:05 2000
@@ -120,7 +120,8 @@ pci_assign_resource(struct pci_dev *dev,
 		}
 	}
 
-	DBGC(("  got res[%lx:%lx] for resource %d\n", res->start, res->end, i));
+	DBGC(("  got res[%lx:%lx] for resource %d of %s\n", res->start,
+						res->end, i, dev->name));
 
 	return 0;
 }
@@ -136,6 +137,12 @@ pdev_sort_resources(struct pci_dev *dev,
 		struct resource *r;
 		struct resource_list *list, *tmp;
 
+		/* PCI-PCI bridges may have I/O ports or
+		   memory on the primary bus */
+		if (dev->class >> 8 == PCI_CLASS_BRIDGE_PCI &&
+						i >= PCI_BRIDGE_RESOURCES)
+			continue;
+
 		r = &dev->resource[i];
 		if (!(r->flags & type_mask) || r->parent)
 			continue;
@@ -201,6 +208,10 @@ pdev_enable_device(struct pci_dev *dev)
 	/* ??? Always turn on bus mastering.  If the device doesn't support
 	   it, the bit will go into the bucket. */
 	cmd |= PCI_COMMAND_MASTER;
+
+	/* Set the cache line and default latency (32).  */
+	pci_write_config_word(dev, PCI_CACHE_LINE_SIZE,
+			(32 << 8) | (L1_CACHE_BYTES / sizeof(u32)));
 
 	/* Enable the appropriate bits in the PCI command register.  */
 	pci_write_config_word(dev, PCI_COMMAND, cmd);
diff -urp 2.4.0t11/include/linux/pci.h linux/include/linux/pci.h
--- 2.4.0t11/include/linux/pci.h	Mon Nov 20 17:10:31 2000
+++ linux/include/linux/pci.h	Mon Nov 20 16:41:36 2000
@@ -536,6 +536,7 @@ int pci_claim_resource(struct pci_dev *,
 void pci_assign_unassigned_resources(void);
 void pdev_enable_device(struct pci_dev *);
 void pdev_sort_resources(struct pci_dev *, struct resource_list *, u32);
+unsigned long pci_bridge_check_io(struct pci_dev *);
 void pci_fixup_irqs(u8 (*)(struct pci_dev *, u8 *),
 		    int (*)(struct pci_dev *, u8, u8));
 

--ZPt4rx8FFjLCG7dd
Content-Type: application/x-gzip
Content-Description: diff vs 2.4.0-test11
Content-Disposition: attachment; filename="bridges-2.4.0t11.gz"
Content-Transfer-Encoding: base64

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

--ZPt4rx8FFjLCG7dd--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
