Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264650AbRFYPvO>; Mon, 25 Jun 2001 11:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264656AbRFYPvG>; Mon, 25 Jun 2001 11:51:06 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:55049 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S264650AbRFYPu4>; Mon, 25 Jun 2001 11:50:56 -0400
Date: Mon, 25 Jun 2001 19:49:41 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Grant Grundler <grundler@puffin.external.hp.com>
Cc: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org,
        parisc-linux@lists.parisc-linux.org
Subject: Re: [PATCH] 2.4.4 PCI FBB
Message-ID: <20010625194941.A18426@jurassic.park.msu.ru>
In-Reply-To: <20010618231144.A5077@jurassic.park.msu.ru> <200106232033.OAA15401@puffin.external.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200106232033.OAA15401@puffin.external.hp.com>; from grundler@puffin.external.hp.com on Sat, Jun 23, 2001 at 02:33:54PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 23, 2001 at 02:33:54PM -0600, Grant Grundler wrote:
> Ivan,
> I just got back to reading my mail....offline for three days
> in switzerland.

I've been offline for last few days, too...

> > I also have some PCI fixes/cleanups for your review)...
> 
> ok. I look forward to them...they are probably deeper in my mail queue.

No, sorry. I would like to integrate your FBB stuff, but had no time yet...
Anyway, here is a patch (not for inclusion! :-). It applies cleanly to
2.4.6-pre5 (or to 2.4.5 with offsets) and was reasonably well tested
on my alphas.
Changes:
- bus resources were not added to the resource tree properly. This bug is
  harmless in most configurations, but could be triggered by some driver
  requesting resources in the run-time.
- as you proposed a while back, code from arch-specific pcibios_fixup_bus() is
  now moved to generic pbus_assign_resources(). Hopefully this makes PPB code
  a bit cleaner.
- on the contrary, code disabling pci devices before reallocation is now
  arch-specific, as various platforms may have different console devices.
  pdev_enable_device() killed thus. On alpha I renamed it to
  pcibios_postalloc_fixup().
- pcibios_set_bridge_ctl() introduced, but this likely has to be
  changed/renamed for FBB support.
These changes currently are only for alpha and would break ARM...

Some thoughts of your patch:
- I'm not sure that we need a new field in the struct pci_bus --
  we have plenty of room in the bridge/bus->resource[N]->flags (I used
  it for IORESOURCE_BUS_HAS_VGA, same could be done for, say,
  IORESOURCE_BUS_FBB etc.)?
- it seems that pcibios_init_bus() will be actually called *before*
  pci_setup_bridge(), at least on alpha. So initializing the FBB bit
  should be done in pcibios_init_bus().

Ivan.

--- 2.4.6/include/linux/pci.h	Thu Jun 14 14:10:34 2001
+++ linux/include/linux/pci.h	Thu Jun 14 14:12:12 2001
@@ -501,6 +501,7 @@ void pcibios_update_resource(struct pci_
 			     struct resource *, int);
 void pcibios_update_irq(struct pci_dev *, int irq);
 void pcibios_fixup_pbus_ranges(struct pci_bus *, struct pbus_set_ranges_data *);
+void pcibios_set_bridge_ctl(struct pci_dev *);
 
 /* Backward compatibility, don't use in new code! */
 
@@ -571,9 +572,7 @@ int pci_enable_wake(struct pci_dev *dev,
 
 int pci_claim_resource(struct pci_dev *, int);
 void pci_assign_unassigned_resources(void);
-void pdev_enable_device(struct pci_dev *);
 void pdev_sort_resources(struct pci_dev *, struct resource_list *, u32);
-unsigned long pci_bridge_check_io(struct pci_dev *);
 void pci_fixup_irqs(u8 (*)(struct pci_dev *, u8 *),
 		    int (*)(struct pci_dev *, u8, u8));
 #define HAVE_PCI_REQ_REGIONS
--- 2.4.6/drivers/pci/setup-bus.c	Sun May 20 04:43:06 2001
+++ linux/drivers/pci/setup-bus.c	Thu Jun 14 14:12:12 2001
@@ -12,6 +12,12 @@
 /*
  * Nov 2000, Ivan Kokshaysky <ink@jurassic.park.msu.ru>
  *	     PCI-PCI bridges cleanup, sorted resource allocation
+ *
+ * NOTE: during reallocation we may have temporarily overlapping
+ * IO or MEM ranges, so the arch code (pcibios_fixup_bus()) is
+ * responsible for disabling all devices, probably except console
+ * (VGA, serial etc.) and bridges the console device might be
+ * behind -- typically AGP or PCI-(E)ISA bridges.
  */
 
 #include <linux/init.h>
@@ -23,7 +29,7 @@
 #include <linux/slab.h>
 
 
-#define DEBUG_CONFIG 1
+#define DEBUG_CONFIG 0
 #if DEBUG_CONFIG
 # define DBGC(args)     printk args
 #else
@@ -46,23 +52,10 @@ pbus_assign_resources_sorted(struct pci_
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
 		if (class == PCI_CLASS_DISPLAY_VGA
 				|| class == PCI_CLASS_NOT_DEFINED_VGA)
 			found_vga = 1;
-		else if (class >> 8 != PCI_BASE_CLASS_BRIDGE) {
-			pci_read_config_word(dev, PCI_COMMAND, &cmd);
-			cmd &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY
-						| PCI_COMMAND_MASTER);
-			pci_write_config_word(dev, PCI_COMMAND, cmd);
-		}
 
 		/* Reserve some resources for CardBus.
 		   Are these values reasonable? */
@@ -160,15 +153,31 @@ pci_setup_bridge(struct pci_bus *bus)
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
+	pcibios_set_bridge_ctl(bridge);
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
@@ -181,26 +190,47 @@ pbus_assign_resources(struct pci_bus *bu
 		struct pci_bus *b;
 
 		ranges->found_vga = 1;
-		/* Propogate presence of the VGA to upstream bridges */
-		for (b = bus; b->parent; b = b->parent) {
-#if 0
-			/* ? Do we actually need to enable PF memory? */
-			b->resource[2]->start = 0;
-#endif
+		/* Propagate presence of the VGA to upstream bridges */
+		for (b = bus; b->parent; b = b->parent)
 			b->resource[0]->flags |= IORESOURCE_BUS_HAS_VGA;
-		}
 	}
 	for (ln=bus->children.next; ln != &bus->children; ln=ln->next) {
 		struct pci_bus *b = pci_bus_b(ln);
+		struct pci_dev *bridge = b->self;
+		int i;
 
+		/* Link bus resources to the bridge ones.  */
+		for(i=0; i<3; i++) {
+			b->resource[i] =
+				&bridge->resource[PCI_BRIDGE_RESOURCES+i];
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
 
+		/* Adjust bus limits. */
 		b->resource[0]->end = ranges->io_end - 1;
 		b->resource[1]->end = ranges->mem_end - 1;
 
+		/* Add bridge resources to the resource tree. */
+		if (b->resource[0]->end > b->resource[0]->start &&
+		    request_resource(bus->resource[0], b->resource[0]) < 0)
+			printk(KERN_ERR "PCI: failed to request IO "
+					"for bus %d\n",	b->number);
+		if (b->resource[1]->end > b->resource[1]->start &&
+		    request_resource(bus->resource[0], b->resource[0]) < 0)
+			printk(KERN_ERR "PCI: failed to request MEM "
+					"for bus %d\n", b->number);
+
 		pci_setup_bridge(b);
 	}
 }
@@ -210,7 +240,6 @@ pci_assign_unassigned_resources(void)
 {
 	struct pbus_set_ranges_data ranges;
 	struct list_head *ln;
-	struct pci_dev *dev;
 
 	for(ln=pci_root_buses.next; ln != &pci_root_buses; ln=ln->next) {
 		struct pci_bus *b = pci_bus_b(ln);
@@ -222,28 +251,4 @@ pci_assign_unassigned_resources(void)
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
--- 2.4.6/drivers/pci/setup-res.c	Sun May 20 04:43:06 2001
+++ linux/drivers/pci/setup-res.c	Thu Jun 14 14:12:12 2001
@@ -25,7 +25,7 @@
 #include <linux/slab.h>
 
 
-#define DEBUG_CONFIG 1
+#define DEBUG_CONFIG 0
 #if DEBUG_CONFIG
 # define DBGC(args)     printk args
 #else
@@ -176,59 +176,4 @@ pdev_sort_resources(struct pci_dev *dev,
 			}
 		}
 	}
-}
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
-	/* ??? Always turn on bus mastering.  If the device doesn't support
-	   it, the bit will go into the bucket. */
-	cmd |= PCI_COMMAND_MASTER;
-
-	/* Set the cache line and default latency (32).  */
-	pci_write_config_word(dev, PCI_CACHE_LINE_SIZE,
-			(32 << 8) | (L1_CACHE_BYTES / sizeof(u32)));
-
-	/* Enable the appropriate bits in the PCI command register.  */
-	pci_write_config_word(dev, PCI_COMMAND, cmd);
-
-	DBGC((KERN_ERR "  cmd reg 0x%x\n", cmd));
 }
--- 2.4.6/arch/alpha/kernel/pci.c	Tue May 22 00:38:41 2001
+++ linux/arch/alpha/kernel/pci.c	Thu Jun 14 14:12:13 2001
@@ -24,6 +24,12 @@
 #include "proto.h"
 #include "pci_impl.h"
 
+#define DEBUG_CONFIG 0
+#if DEBUG_CONFIG
+# define DBGC(args)     printk args
+#else
+# define DBGC(args)
+#endif
 
 /*
  * Some string constants used by the various core logics. 
@@ -148,10 +154,8 @@ pcibios_align_resource(void *data, struc
 		/*
 		 * Put everything into 0x00-0xff region modulo 0x400
 		 */
-		if (start & 0x300) {
+		if (start & 0x300)
 			start = (start + 0x3ff) & ~0x3ff;
-			res->start = start;
-		}
 	}
 	else if	(res->flags & IORESOURCE_MEM) {
 		/* Make sure we start at our min on all hoses */
@@ -242,7 +246,7 @@ pcibios_fixup_device_resources(struct pc
 void __init
 pcibios_fixup_bus(struct pci_bus *bus)
 {
-	/* Propogate hose info into the subordinate devices.  */
+	/* Propagate hose info into the subordinate devices.  */
 
 	struct pci_controller *hose = bus->sysdata;
 	struct list_head *ln;
@@ -252,30 +256,27 @@ pcibios_fixup_bus(struct pci_bus *bus)
 		/* Root bus */
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
 	}
-
 	for (ln = bus->devices.next; ln != &bus->devices; ln = ln->next) {
 		struct pci_dev *dev = pci_dev_b(ln);
-		if ((dev->class >> 8) != PCI_CLASS_BRIDGE_PCI)
+		u16 class = dev->class >> 8;
+		u16 cmd;
+
+		/* First, disable the device to avoid side
+		   effects of possibly overlapping I/O and
+		   memory ranges.
+		   Leave VGA enabled - for obvious reason. :-)
+		   Same with all sorts of bridges - they may
+		   have VGA behind them.  */
+		if (class != PCI_CLASS_DISPLAY_VGA &&
+		    class != PCI_CLASS_NOT_DEFINED_VGA &&
+		    class >> 8 != PCI_BASE_CLASS_BRIDGE) {
+			pci_read_config_word(dev, PCI_COMMAND, &cmd);
+			cmd &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY
+						| PCI_COMMAND_MASTER);
+			pci_write_config_word(dev, PCI_COMMAND, cmd);
+		}
+		if (class != PCI_CLASS_BRIDGE_PCI)
 			pcibios_fixup_device_resources(dev, bus);
 	}
 }
@@ -381,10 +382,81 @@ pcibios_set_master(struct pci_dev *dev)
 }
 
 void __init
+pcibios_set_bridge_ctl(struct pci_dev *bridge)
+{
+	u32 l;
+
+	/* Set default latency (32) for the secondary bus.  */
+	pci_write_config_byte(bridge, PCI_SEC_LATENCY_TIMER, 32);
+
+	/* Check if we have VGA behind the bridge.
+	   Enable ISA in either case. */
+	l = (bridge->resource[PCI_BRIDGE_RESOURCES + 0].flags &
+				IORESOURCE_BUS_HAS_VGA) ? 0x0c : 0x04;
+	pci_write_config_word(bridge, PCI_BRIDGE_CONTROL, l);
+}
+
+static void __init
+pcibios_postalloc_fixup(struct pci_dev *dev)
+{
+	u32 reg;
+	u16 cmd;
+	int i;
+
+	DBGC((KERN_INFO "PCI enable device: (%s)\n", dev->name));
+
+	pci_read_config_word(dev, PCI_COMMAND, &cmd);
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
+	/* Special case, disable the ROM.  Several devices act funny
+	   (ie. do not respond to memory space writes) when it is left
+	   enabled.  A good example are QlogicISP adapters.  */
+
+	if (dev->rom_base_reg) {
+		pci_read_config_dword(dev, dev->rom_base_reg, &reg);
+		reg &= ~PCI_ROM_ADDRESS_ENABLE;
+		pci_write_config_dword(dev, dev->rom_base_reg, reg);
+		dev->resource[PCI_ROM_RESOURCE].flags &= ~PCI_ROM_ADDRESS_ENABLE;
+	}
+
+	/* All of these (may) have I/O scattered all around and may not
+	   use I/O base address registers at all.  So we just have to
+	   always enable IO to these devices.  */
+	if ((dev->class >> 8) == PCI_CLASS_NOT_DEFINED
+	    || (dev->class >> 8) == PCI_CLASS_NOT_DEFINED_VGA
+	    || (dev->class >> 8) == PCI_CLASS_STORAGE_IDE
+	    || (dev->class >> 16) == PCI_BASE_CLASS_DISPLAY) {
+		cmd |= PCI_COMMAND_IO;
+	}
+
+	/* ??? Always turn on bus mastering.  If the device doesn't support
+	   it, the bit will go into the bucket. */
+	cmd |= PCI_COMMAND_MASTER;
+
+	/* Set the cache line and default latency (32).  */
+	pci_write_config_word(dev, PCI_CACHE_LINE_SIZE,
+			(32 << 8) | (L1_CACHE_BYTES / sizeof(u32)));
+
+	/* Enable the appropriate bits in the PCI command register.  */
+	pci_write_config_word(dev, PCI_COMMAND, cmd);
+
+	DBGC((KERN_INFO "  cmd reg 0x%x\n", cmd));
+}
+
+void __init
 common_init_pci(void)
 {
 	struct pci_controller *hose;
 	struct pci_bus *bus;
+	struct pci_dev *dev;
 	int next_busno;
 
 	/* Scan all of the recorded PCI controllers.  */
@@ -398,6 +470,9 @@ common_init_pci(void)
 	}
 
 	pci_assign_unassigned_resources();
+	pci_for_each_dev(dev) {
+		pcibios_postalloc_fixup(dev);
+	}
 	pci_fixup_irqs(alpha_mv.pci_swizzle, alpha_mv.pci_map_irq);
 }
 
