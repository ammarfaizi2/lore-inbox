Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286807AbRLVQGV>; Sat, 22 Dec 2001 11:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286808AbRLVQGQ>; Sat, 22 Dec 2001 11:06:16 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:52996 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S286807AbRLVQGJ>; Sat, 22 Dec 2001 11:06:09 -0500
Date: Sat, 22 Dec 2001 19:05:48 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: linux-kernel@vger.kernel.org
Subject: [patch] 2.5: PCI setup reorg (alpha, arm, parisc)
Message-ID: <20011222190548.A2097@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Ouch. Forgot to cc this to l-k, hence another post...]

Only generic and alpha changes here - parisc folks should be almost in
sync, and required ARM changes look more or less straightforward.

Generic changes:
- Code disabling pci devices before reallocation is now arch specific
  and supposed to be in pcibios_fixup_bus(). Same with re-enabling
  devices after allocation - much hated pdev_enable_device() removed thus.
  This gives architectures more freedom to handle specific console
  devices and other odd stuff.
- Handling of PCI-PCI bridge resources gets completely generic, so
  the only thing architectures must care of is proper initialization
  of the root bus resources.
- Fast-Back-to-Back/PERR/SERR support.
  Added new field in the struct pci_bus - bridge_ctl. It has the same
  format as PCI-PCI bridge control register (and allows to get rid
  of IORESOURCE_BUS_HAS_VGA hack).
  New function - pcibios_init_bus(). Common for all platforms, but
  safely could be defined as noop, as it's done for i386.
  Primary purpose - set appropriate bits in the bus->bridge_ctl
  depending on bus capabilities. The FBB bit will be cleared by
  pci_setup_device() if any of devices on the bus doesn't support FBB;
  PERR/SERR could be cleared in arch specific code as well if certain
  broken devices are present.
  Some specific bridge setup (setting secondary latency etc.)
  also can be done in pcibios_init_bus().
- Two recent patches from Russell King included.

Prefetchable memory support not included for now.

Alpha specific:
- Do not enable _all_ devices on startup - pcibios_enable_device()
  isn't noop anymore.
- Allow configs with multiple graphic cards, as Jay and Richard
  suggested; make sure that at least one display is enabled.
- Framework for setting up PCI control on various core logic chipsets -
  alpha_mv.pci_control(). I have code for cia/pyxis (reasonably tested)
  and tsunami (completely untested), but it's not included for now...

Ivan.

diff -urpN 2.5.1/arch/alpha/kernel/pci.c linux/arch/alpha/kernel/pci.c
--- 2.5.1/arch/alpha/kernel/pci.c	Fri Dec 21 21:29:03 2001
+++ linux/arch/alpha/kernel/pci.c	Fri Dec 21 21:52:27 2001
@@ -24,6 +24,12 @@
 #include "proto.h"
 #include "pci_impl.h"
 
+#define DEBUG_CONFIG 1
+#if DEBUG_CONFIG
+# define DBGC(args)     printk args
+#else
+# define DBGC(args)
+#endif
 
 /*
  * Some string constants used by the various core logics. 
@@ -109,6 +115,33 @@ quirk_cypress(struct pci_dev *dev)
 	}
 }
 
+static int __initdata vga_enabled;
+
+/* Called for each device after PCI setup is done. */
+static void __init
+pcibios_fixup_final(struct pci_dev *dev)
+{
+	/* If no display devices are enabled, enable
+	   the first one we've found. */
+	if (((dev->class >> 8) == PCI_CLASS_NOT_DEFINED_VGA ||
+	     (dev->class >> 16) == PCI_BASE_CLASS_DISPLAY) && !vga_enabled) {
+		pci_enable_device(dev);
+		vga_enabled = 1;
+	}
+	/* These (may) have I/O scattered all around and may not
+	   use I/O base address registers at all.  So we just have to
+	   always enable IO to these devices.  */
+	else if ((dev->class >> 8) == PCI_CLASS_NOT_DEFINED ||
+		 (dev->class >> 8) == PCI_CLASS_STORAGE_IDE) {
+			u16 cmd;
+			pci_read_config_word(dev, PCI_COMMAND, &cmd);
+			cmd |= PCI_COMMAND_IO;
+			pci_write_config_word(dev, PCI_COMMAND, cmd);
+			pci_enable_device(dev);
+			pci_set_master(dev);
+	}
+}
+
 struct pci_fixup pcibios_fixups[] __initdata = {
 	{ PCI_FIXUP_HEADER, PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82375,
 	  quirk_eisa_bridge },
@@ -118,6 +151,8 @@ struct pci_fixup pcibios_fixups[] __init
 	  quirk_ali_ide_ports },
 	{ PCI_FIXUP_HEADER, PCI_VENDOR_ID_CONTAQ, PCI_DEVICE_ID_CONTAQ_82C693,
 	  quirk_cypress },
+	{ PCI_FIXUP_FINAL,  PCI_ANY_ID,	PCI_ANY_ID,
+	  pcibios_fixup_final },
 	{ 0 }
 };
 
@@ -235,40 +270,69 @@ pcibios_fixup_device_resources(struct pc
 void __init
 pcibios_fixup_bus(struct pci_bus *bus)
 {
-	/* Propogate hose info into the subordinate devices.  */
+	/* Propagate hose info into the subordinate devices.
+	   Setup FBB/PERR/SERR depending on the bus capabilities.  */
 
-	struct pci_controller *hose = bus->sysdata;
 	struct list_head *ln;
-	struct pci_dev *dev = bus->self;
+	u16 cmdbits = 0;
+
+	if (!bus->self) {
+		/* Initialize the root bus resources.  */
+		struct pci_controller *hose = bus->sysdata;
 
-	if (!dev) {
-		/* Root bus */
 		bus->resource[0] = hose->io_space;
 		bus->resource[1] = hose->mem_space;
-	} else {
-		/* This is a bridge. Do not care how it's initialized,
-		   just link its resources to the bus ones */
-		int i;
-
-		for(i=0; i<3; i++) {
-			bus->resource[i] =
-				&dev->resource[PCI_BRIDGE_RESOURCES+i];
-			bus->resource[i]->name = bus->name;
-		}
-		bus->resource[0]->flags |= pci_bridge_check_io(dev);
-		bus->resource[1]->flags |= IORESOURCE_MEM;
-		/* For now, propogate hose limits to the bus;
-		   we'll adjust them later. */
-		bus->resource[0]->end = hose->io_space->end;
-		bus->resource[1]->end = hose->mem_space->end;
-		/* Turn off downstream PF memory address range by default */
-		bus->resource[2]->start = 1024*1024;
-		bus->resource[2]->end = bus->resource[2]->start - 1;
+
+		/* Setup our pci controller.  */
+		if (alpha_mv.pci_control)
+			bus->bridge_ctl = alpha_mv.pci_control(bus);
+		else
+			bus->bridge_ctl &= ~PCI_COMMAND_FAST_BACK;
 	}
 
+	if (bus->bridge_ctl & PCI_BRIDGE_CTL_PARITY)
+		cmdbits |= PCI_COMMAND_PARITY;
+	if (bus->bridge_ctl & PCI_BRIDGE_CTL_SERR)
+		cmdbits |= PCI_COMMAND_SERR;
+	if (bus->bridge_ctl & PCI_BRIDGE_CTL_FAST_BACK)
+		cmdbits |= PCI_COMMAND_FAST_BACK;
+
 	for (ln = bus->devices.next; ln != &bus->devices; ln = ln->next) {
 		struct pci_dev *dev = pci_dev_b(ln);
-		if ((dev->class >> 8) != PCI_CLASS_BRIDGE_PCI)
+		u16 class = dev->class >> 8;
+		u16 cmd;
+		u32 reg;
+
+		pci_read_config_word(dev, PCI_COMMAND, &cmd);
+
+		/* First, disable the device to avoid side
+		   effects of possibly overlapping I/O and
+		   memory ranges.
+		   Don't touch VGAs and all sorts of bridges.  */
+		if (class == PCI_CLASS_NOT_DEFINED_VGA ||
+		    class >> 8 == PCI_BASE_CLASS_DISPLAY) {
+			/* Check that at least one display device
+			   is enabled.  */
+			if (cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY))
+				vga_enabled = 1;
+		} else if (class >> 8 != PCI_BASE_CLASS_BRIDGE)
+			cmd &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY
+						| PCI_COMMAND_MASTER);
+
+		cmd |= cmdbits;
+		pci_write_config_word(dev, PCI_COMMAND, cmd);
+
+		/* Disable the ROM.  Several devices act funny (ie. do not
+		   respond to memory space writes) when it is left enabled.
+		   A good example are QlogicISP adapters.  */
+		if (dev->rom_base_reg) {
+			pci_read_config_dword(dev, dev->rom_base_reg, &reg);
+			reg &= ~PCI_ROM_ADDRESS_ENABLE;
+			pci_write_config_dword(dev, dev->rom_base_reg, reg);
+			dev->resource[PCI_ROM_RESOURCE].flags &=
+						~PCI_ROM_ADDRESS_ENABLE;
+		}
+		if (class != PCI_CLASS_BRIDGE_PCI)
 			pcibios_fixup_device_resources(dev, bus);
 	}
 }
@@ -353,24 +417,79 @@ pcibios_fixup_pbus_ranges(struct pci_bus
 int
 pcibios_enable_device(struct pci_dev *dev)
 {
-	/* Nothing to do, since we enable all devices at startup.  */
+	u16 cmd, oldcmd;
+	int i;
+
+	pci_read_config_word(dev, PCI_COMMAND, &cmd);
+	oldcmd = cmd;
+
+	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
+		struct resource *res = &dev->resource[i];
+
+		if (res->flags & IORESOURCE_IO)
+			cmd |= PCI_COMMAND_IO;
+		else if (res->flags & IORESOURCE_MEM)
+			cmd |= PCI_COMMAND_MEMORY;
+	}
+
+	if (cmd != oldcmd) {
+		DBGC((KERN_INFO "PCI: Enabling device: (%s), cmd %x\n",
+				dev->name, cmd));
+		/* Enable the appropriate bits in the PCI command register.  */
+		pci_write_config_word(dev, PCI_COMMAND, cmd);
+	}
 	return 0;
 }
 
-/*
- *  If we set up a device for bus mastering, we need to check the latency
- *  timer as certain firmware forgets to set it properly, as seen
- *  on SX164 and LX164 with SRM.
- */
 void
 pcibios_set_master(struct pci_dev *dev)
 {
-	u8 lat;
-	pci_read_config_byte(dev, PCI_LATENCY_TIMER, &lat);
-	if (lat >= 16) return;
-	printk("PCI: Setting latency timer of device %s to 64\n",
-							dev->slot_name);
-	pci_write_config_byte(dev, PCI_LATENCY_TIMER, 64);
+	/* Set the cacheline size and default latency (32).  */
+	pci_write_config_word(dev, PCI_CACHE_LINE_SIZE,
+			(32 << 8) | (L1_CACHE_BYTES / sizeof(u32)));
+
+#if 0	/* ??? Turning on MWI might be dangerous... */
+	{
+		u8 cacheline;
+
+		pci_read_config_byte(dev, PCI_CACHE_LINE_SIZE, &cacheline);
+		/* If this cacheline size is supported,
+		   turn on write/invalidate. */
+		if (cacheline) {
+			u16 cmd;
+
+			pci_read_config_word(dev, PCI_COMMAND, &cmd);
+			cmd |= PCI_COMMAND_INVALIDATE;
+			pci_write_config_word(dev, PCI_COMMAND, cmd);
+		}
+	}
+#endif
+}
+
+void __init
+pcibios_init_bus(struct pci_bus *bus)
+{
+	struct pci_dev *dev = bus->self;
+	u16 status;
+	/* Set FBB bit for now. Disable ISA IO forwarding. Enable PERR/SERR. */
+	u16 ctl = PCI_BRIDGE_CTL_FAST_BACK | PCI_BRIDGE_CTL_NO_ISA |
+		  PCI_BRIDGE_CTL_PARITY | PCI_BRIDGE_CTL_SERR;
+
+	/* We deal only with pci controllers and pci-pci bridges. */
+	if (dev) {
+		if ((dev->class >> 8) != PCI_CLASS_BRIDGE_PCI)
+			return;
+		/* PCI-PCI bridge - set default latency (32)
+		   for secondary bus. */
+		pci_write_config_byte(dev, PCI_SEC_LATENCY_TIMER, 32);
+		/* Read bridge control. */
+		pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &bus->bridge_ctl);
+		/* Does the bridge support FBB on its secondary bus? */
+		pci_read_config_word(dev, PCI_SEC_STATUS, &status);
+		if (!(status & PCI_BRIDGE_CTL_FAST_BACK))
+			ctl &= ~PCI_BRIDGE_CTL_FAST_BACK;
+	}
+	bus->bridge_ctl |= ctl;
 }
 
 void __init
diff -urpN 2.5.1/drivers/pci/pci.c linux/drivers/pci/pci.c
--- 2.5.1/drivers/pci/pci.c	Fri Dec 21 21:29:03 2001
+++ linux/drivers/pci/pci.c	Fri Dec 21 21:29:43 2001
@@ -914,13 +914,15 @@ static void pci_read_bases(struct pci_de
 			l = 0;
 		if ((l & PCI_BASE_ADDRESS_SPACE) == PCI_BASE_ADDRESS_SPACE_MEMORY) {
 			res->start = l & PCI_BASE_ADDRESS_MEM_MASK;
+			res->flags |= l & ~PCI_BASE_ADDRESS_MEM_MASK;
 			sz = pci_size(sz, PCI_BASE_ADDRESS_MEM_MASK);
 		} else {
 			res->start = l & PCI_BASE_ADDRESS_IO_MASK;
+			res->flags |= l & ~PCI_BASE_ADDRESS_IO_MASK;
 			sz = pci_size(sz, PCI_BASE_ADDRESS_IO_MASK & 0xffff);
 		}
 		res->end = res->start + (unsigned long) sz;
-		res->flags |= (l & 0xf) | pci_calc_resource_flags(l);
+		res->flags |= pci_calc_resource_flags(l);
 		if ((l & (PCI_BASE_ADDRESS_SPACE | PCI_BASE_ADDRESS_MEM_TYPE_MASK))
 		    == (PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64)) {
 			pci_read_config_dword(dev, reg+4, &l);
@@ -1210,6 +1212,7 @@ static void pci_read_irq(struct pci_dev 
 int pci_setup_device(struct pci_dev * dev)
 {
 	u32 class;
+	unsigned short status;
 
 	sprintf(dev->slot_name, "%02x:%02x.%d", dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
 	sprintf(dev->name, "PCI device %04x:%04x", dev->vendor, dev->device);
@@ -1260,6 +1263,11 @@ int pci_setup_device(struct pci_dev * de
 		dev->class = PCI_CLASS_NOT_DEFINED;
 	}
 
+	/* FBB capability - if not, clear bit in parent bridge_ctl.  */
+	pci_read_config_word(dev, PCI_STATUS, &status);
+	if (!(status & PCI_STATUS_FAST_BACK))
+		dev->bus->bridge_ctl &= ~PCI_BRIDGE_CTL_FAST_BACK;
+
 	/* We found a fine healthy device, go go go... */
 	return 0;
 }
@@ -1341,6 +1349,8 @@ unsigned int __devinit pci_do_scan_bus(s
 	unsigned int devfn, max, pass;
 	struct list_head *ln;
 	struct pci_dev *dev, dev0;
+
+	pcibios_init_bus(bus);
 
 	DBG("Scanning bus %02x\n", bus->number);
 	max = bus->secondary;
diff -urpN 2.5.1/drivers/pci/setup-bus.c linux/drivers/pci/setup-bus.c
--- 2.5.1/drivers/pci/setup-bus.c	Fri Dec 21 21:29:03 2001
+++ linux/drivers/pci/setup-bus.c	Fri Dec 21 21:33:58 2001
@@ -12,6 +12,16 @@
 /*
  * Nov 2000, Ivan Kokshaysky <ink@jurassic.park.msu.ru>
  *	     PCI-PCI bridges cleanup, sorted resource allocation
+ * Jul 2001, Grant Grundler <grundler@parisc-linux.org>,
+ *	     Ivan Kokshaysky <ink@jurassic.park.msu.ru>
+ *	     Further cleanup, generic Fast-Back-to-Back/PERR/SERR support
+ */
+
+/* NOTE: during reallocation we may have temporarily overlapping
+ * IO or MEM ranges, so the arch code (pcibios_fixup_bus()) is
+ * responsible for disabling all devices, probably except console
+ * (VGA, serial etc.) and bridges the console device might be
+ * behind -- typically AGP or PCI-(E)ISA bridges.
  */
 
 #include <linux/init.h>
@@ -46,23 +56,9 @@ pbus_assign_resources_sorted(struct pci_
 	for (ln=bus->devices.next; ln != &bus->devices; ln=ln->next) {
 		struct pci_dev *dev = pci_dev_b(ln);
 		u16 class = dev->class >> 8;
-		u16 cmd;
 
-		/* First, disable the device to avoid side
-		   effects of possibly overlapping I/O and
-		   memory ranges.
-		   Leave VGA enabled - for obvious reason. :-)
-		   Same with all sorts of bridges - they may
-		   have VGA behind them.  */
-		if (class == PCI_CLASS_DISPLAY_VGA
-				|| class == PCI_CLASS_NOT_DEFINED_VGA)
-			found_vga = 1;
-		else if (class >> 8 != PCI_BASE_CLASS_BRIDGE) {
-			pci_read_config_word(dev, PCI_COMMAND, &cmd);
-			cmd &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY
-						| PCI_COMMAND_MASTER);
-			pci_write_config_word(dev, PCI_COMMAND, cmd);
-		}
+		found_vga |= (class == PCI_CLASS_DISPLAY_VGA ||
+			      class == PCI_CLASS_NOT_DEFINED_VGA);
 
 		/* Reserve some resources for CardBus.
 		   Are these values reasonable? */
@@ -100,20 +96,6 @@ pbus_assign_resources_sorted(struct pci_
 	ranges->io_end += io_reserved;
 	ranges->mem_end += mem_reserved;
 
-	/* PCI-to-PCI Bridge Architecture Specification rev. 1.1 (1998)
-	   requires that if there is no I/O ports or memory behind the
-	   bridge, corresponding range must be turned off by writing base
-	   value greater than limit to the bridge's base/limit registers.  */
-#if 1
-	/* But assuming that some hardware designed before 1998 might
-	   not support this (very unlikely - at least all DEC bridges
-	   are ok and I believe that was standard de-facto. -ink), we
-	   must allow for at least one unit.  */
-	if (ranges->io_end == ranges->io_start)
-		ranges->io_end += 1;
-	if (ranges->mem_end == ranges->mem_start)
-		ranges->mem_end += 1;
-#endif
 	ranges->io_end = ROUND_UP(ranges->io_end, 4*1024);
 	ranges->mem_end = ROUND_UP(ranges->mem_end, 1024*1024);
 
@@ -130,6 +112,7 @@ pci_setup_bridge(struct pci_bus *bus)
 
 	if (!bridge || (bridge->class >> 8) != PCI_CLASS_BRIDGE_PCI)
 		return;
+
 	ranges.io_start = bus->resource[0]->start;
 	ranges.io_end = bus->resource[0]->end;
 	ranges.mem_start = bus->resource[1]->start;
@@ -147,8 +130,11 @@ pci_setup_bridge(struct pci_bus *bus)
 	l |= ranges.io_end & 0xf000;
 	pci_write_config_dword(bridge, PCI_IO_BASE, l);
 
-	/* Clear upper 16 bits of I/O base/limit. */
-	pci_write_config_dword(bridge, PCI_IO_BASE_UPPER16, 0);
+	/* Set up upper 16 bits of I/O base/limit. */
+	pci_write_config_word(bridge, PCI_IO_BASE_UPPER16,
+			ranges.io_start >> 16);
+	pci_write_config_word(bridge, PCI_IO_LIMIT_UPPER16,
+			ranges.io_end >> 16);
 
 	/* Clear out the upper 32 bits of PREF base/limit. */
 	pci_write_config_dword(bridge, PCI_PREF_BASE_UPPER32, 0);
@@ -160,15 +146,34 @@ pci_setup_bridge(struct pci_bus *bus)
 	l |= ranges.mem_end & 0xfff00000;
 	pci_write_config_dword(bridge, PCI_MEMORY_BASE, l);
 
-	/* Set up PREF base/limit. */
-	l = (bus->resource[2]->start >> 16) & 0xfff0;
-	l |= bus->resource[2]->end & 0xfff00000;
-	pci_write_config_dword(bridge, PCI_PREF_MEMORY_BASE, l);
-
-	/* Check if we have VGA behind the bridge.
-	   Enable ISA in either case. */
-	l = (bus->resource[0]->flags & IORESOURCE_BUS_HAS_VGA) ? 0x0c : 0x04;
-	pci_write_config_word(bridge, PCI_BRIDGE_CONTROL, l);
+	/* Disable PREF memory range. */
+	pci_write_config_dword(bridge, PCI_PREF_MEMORY_BASE, 0x0000fff0);
+
+	pci_write_config_word(bridge, PCI_BRIDGE_CONTROL, bus->bridge_ctl);
+
+	pci_enable_device(bridge);
+	pci_set_master(bridge);
+}
+
+/* Check whether the bridge supports I/O forwarding.
+   If not, its I/O base/limit register must be
+   read-only and read as 0. */
+static unsigned long __init
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
 
 static void __init
@@ -181,26 +186,52 @@ pbus_assign_resources(struct pci_bus *bu
 		struct pci_bus *b;
 
 		ranges->found_vga = 1;
-		/* Propogate presence of the VGA to upstream bridges */
-		for (b = bus; b->parent; b = b->parent) {
-#if 0
-			/* ? Do we actually need to enable PF memory? */
-			b->resource[2]->start = 0;
-#endif
-			b->resource[0]->flags |= IORESOURCE_BUS_HAS_VGA;
-		}
+		/* Propagate presence of the VGA to upstream bridges */
+		for (b = bus; b->parent; b = b->parent)
+			b->bridge_ctl |= PCI_BRIDGE_CTL_VGA;
 	}
 	for (ln=bus->children.next; ln != &bus->children; ln=ln->next) {
 		struct pci_bus *b = pci_bus_b(ln);
+		struct pci_dev *bridge = b->self;
+		int i;
 
+		/* Link bus resources to the bridge ones.  */
+		for (i = 0; i < 3; i++) {
+			b->resource[i] =
+				&bridge->resource[PCI_BRIDGE_RESOURCES + i];
+			b->resource[i]->name = bus->name;
+		}
+		b->resource[0]->flags |= pci_bridge_check_io(bridge);
+		b->resource[1]->flags |= IORESOURCE_MEM;
 		b->resource[0]->start = ranges->io_start = ranges->io_end;
 		b->resource[1]->start = ranges->mem_start = ranges->mem_end;
 
+		/* For now, set IO and MEM limits of this bus
+		   same as limits of its parent bus. */
+		b->resource[0]->end = bus->resource[0]->end;
+		b->resource[1]->end = bus->resource[1]->end;
+
 		pbus_assign_resources(b, ranges);
 
+		/* PCI-to-PCI Bridge Architecture Specification rev. 1.1 (1998)
+		   requires that if there is no I/O ports or memory behind the
+		   bridge, corresponding range must be turned off by writing
+		   base value greater than limit to the bridge's base/limit
+		   registers.
+		   This is done automatically for empty (start==end) ranges. */
 		b->resource[0]->end = ranges->io_end - 1;
 		b->resource[1]->end = ranges->mem_end - 1;
 
+		/* Add bridge resources to the resource tree. */
+		if (b->resource[0]->end > b->resource[0]->start &&
+		    request_resource(bus->resource[0], b->resource[0]) < 0)
+			printk(KERN_ERR "PCI: failed to request IO "
+					"for bus %d\n",	b->number);
+		if (b->resource[1]->end > b->resource[1]->start &&
+		    request_resource(bus->resource[1], b->resource[1]) < 0)
+			printk(KERN_ERR "PCI: failed to request MEM "
+					"for bus %d\n", b->number);
+
 		pci_setup_bridge(b);
 	}
 }
@@ -210,7 +241,6 @@ pci_assign_unassigned_resources(void)
 {
 	struct pbus_set_ranges_data ranges;
 	struct list_head *ln;
-	struct pci_dev *dev;
 
 	for(ln=pci_root_buses.next; ln != &pci_root_buses; ln=ln->next) {
 		struct pci_bus *b = pci_bus_b(ln);
@@ -222,28 +252,4 @@ pci_assign_unassigned_resources(void)
 		ranges.found_vga = 0;
 		pbus_assign_resources(b, &ranges);
 	}
-	pci_for_each_dev(dev) {
-		pdev_enable_device(dev);
-	}
-}
-
-/* Check whether the bridge supports I/O forwarding.
-   If not, its I/O base/limit register must be
-   read-only and read as 0. */
-unsigned long __init
-pci_bridge_check_io(struct pci_dev *bridge)
-{
-	u16 io;
-
-	pci_read_config_word(bridge, PCI_IO_BASE, &io);
-	if (!io) {
-		pci_write_config_word(bridge, PCI_IO_BASE, 0xf0f0);
-		pci_read_config_word(bridge, PCI_IO_BASE, &io);
-		pci_write_config_word(bridge, PCI_IO_BASE, 0x0);
-	}
-	if (io)
-		return IORESOURCE_IO;
-	printk(KERN_WARNING "PCI: bridge %s does not support I/O forwarding!\n",
-				bridge->name);
-	return 0;
 }
diff -urpN 2.5.1/drivers/pci/setup-res.c linux/drivers/pci/setup-res.c
--- 2.5.1/drivers/pci/setup-res.c	Fri Dec 21 21:29:03 2001
+++ linux/drivers/pci/setup-res.c	Fri Dec 21 21:29:43 2001
@@ -177,57 +177,3 @@ pdev_sort_resources(struct pci_dev *dev,
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
diff -urpN 2.5.1/include/asm-alpha/machvec.h linux/include/asm-alpha/machvec.h
--- 2.5.1/include/asm-alpha/machvec.h	Fri Dec 21 21:29:03 2001
+++ linux/include/asm-alpha/machvec.h	Fri Dec 21 21:29:43 2001
@@ -18,7 +18,7 @@ struct task_struct;
 struct mm_struct;
 struct pt_regs;
 struct vm_area_struct;
-struct linux_hose_info;
+struct pci_bus;
 struct pci_dev;
 struct pci_ops;
 struct pci_controller;
@@ -79,6 +79,7 @@ struct alpha_machine_vector
 	void (*ack_irq)(unsigned long);
 	void (*device_interrupt)(unsigned long vector, struct pt_regs *regs);
 	void (*machine_check)(u64 vector, u64 la, struct pt_regs *regs);
+	u16 (*pci_control)(struct pci_bus *);
 
 	void (*init_arch)(void);
 	void (*init_irq)(void);
diff -urpN 2.5.1/include/asm-i386/pci.h linux/include/asm-i386/pci.h
--- 2.5.1/include/asm-i386/pci.h	Fri Dec 21 21:29:03 2001
+++ linux/include/asm-i386/pci.h	Fri Dec 21 21:29:43 2001
@@ -263,6 +263,11 @@ static inline int pci_controller_num(str
 	return 0;
 }
 
+/* Set up bus control bits (FBB/PERR/SERR etc.) supported by PCI controller. */
+static inline void pcibios_init_bus(struct pci_bus *bus)
+{
+}
+
 #define HAVE_PCI_MMAP
 extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
 			       enum pci_mmap_state mmap_state, int write_combine);
diff -urpN 2.5.1/include/linux/ioport.h linux/include/linux/ioport.h
--- 2.5.1/include/linux/ioport.h	Fri Dec 21 21:29:03 2001
+++ linux/include/linux/ioport.h	Fri Dec 21 21:29:43 2001
@@ -40,7 +40,6 @@ struct resource_list {
 #define IORESOURCE_CACHEABLE	0x00004000
 #define IORESOURCE_RANGELENGTH	0x00008000
 #define IORESOURCE_SHADOWABLE	0x00010000
-#define IORESOURCE_BUS_HAS_VGA	0x00080000
 
 #define IORESOURCE_UNSET	0x20000000
 #define IORESOURCE_AUTO		0x40000000
diff -urpN 2.5.1/include/linux/pci.h linux/include/linux/pci.h
--- 2.5.1/include/linux/pci.h	Fri Dec 21 21:29:03 2001
+++ linux/include/linux/pci.h	Fri Dec 21 21:29:43 2001
@@ -429,6 +429,8 @@ struct pci_bus {
 	unsigned char	productver;	/* product version */
 	unsigned char	checksum;	/* if zero - checksum passed */
 	unsigned char	pad1;
+	unsigned short  bridge_ctl;	/* manage NO_ISA/FBB/et al behaviors */
+	unsigned short  pad2;
 };
 
 #define pci_bus_b(n) list_entry(n, struct pci_bus, node)
@@ -491,8 +493,10 @@ struct pci_driver {
 #define pci_for_each_dev(dev) \
 	for(dev = pci_dev_g(pci_devices.next); dev != pci_dev_g(&pci_devices); dev = pci_dev_g(dev->global_list.next))
 
-void pcibios_init(void);
-void pcibios_fixup_bus(struct pci_bus *);
+/* pcibios_*() == arch specific implementation */
+void pcibios_init(void);			/* global init */
+void pcibios_init_bus(struct pci_bus *);	/* before each bus scan */
+void pcibios_fixup_bus(struct pci_bus *);	/* after each bus scan */
 int pcibios_enable_device(struct pci_dev *);
 char *pcibios_setup (char *str);
 
@@ -575,9 +579,7 @@ int pci_enable_wake(struct pci_dev *dev,
 
 int pci_claim_resource(struct pci_dev *, int);
 void pci_assign_unassigned_resources(void);
-void pdev_enable_device(struct pci_dev *);
 void pdev_sort_resources(struct pci_dev *, struct resource_list *, u32);
-unsigned long pci_bridge_check_io(struct pci_dev *);
 void pci_fixup_irqs(u8 (*)(struct pci_dev *, u8 *),
 		    int (*)(struct pci_dev *, u8, u8));
 #define HAVE_PCI_REQ_REGIONS
