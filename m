Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318538AbSIHOyk>; Sun, 8 Sep 2002 10:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318561AbSIHOyk>; Sun, 8 Sep 2002 10:54:40 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:14344 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S318538AbSIHOyh>; Sun, 8 Sep 2002 10:54:37 -0400
Date: Sun, 8 Sep 2002 18:58:55 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org
Subject: [patch 2.5.33] pci bus resources, transparent bridges
Message-ID: <20020908185855.B25001@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Added PCI_BUS_NUM_RESOURCES as Ben suggested. Default value is 4
and can be overridden by arch (probably in asm/system.h).
pci_read_bridge_bases() and pci_assign_bus_resource() changed
accordingly. "for (i = 0 ; i < 4; i++)" in pci_add_new_bus() not
changed, as it's used _only_ for pci-pci and cardbus bridges.

Ivan.

--- 2.5.33/arch/i386/pci/fixup.c	Sun Sep  1 02:04:50 2002
+++ linux/arch/i386/pci/fixup.c	Fri Sep  6 16:14:47 2002
@@ -166,6 +166,22 @@ static void __init pci_fixup_via_northbr
 	}
 }
 
+/*
+ * For some reasons Intel decided that certain parts of their
+ * 815, 845 and some other chipsets must look like PCI-to-PCI bridges
+ * while they are obviously not. The 82801 family (AA, AB, BAM/CAM,
+ * BA/CA/DB and E) PCI bridges are actually HUB-to-PCI ones, according
+ * to Intel terminology. These devices do forward all addresses from
+ * system to PCI bus no matter what are their window settings, so they are
+ * "transparent" (or subtractive decoding) from programmers point of view.
+ */
+static void __init pci_fixup_transparent_bridge(struct pci_dev *dev)
+{
+	if ((dev->class >> 8) == PCI_CLASS_BRIDGE_PCI &&
+	    (dev->device & 0xff00) == 0x2400)
+		dev->transparent = 1;
+}
+
 struct pci_fixup pcibios_fixups[] = {
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82451NX,	pci_fixup_i450nx },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82454GX,	pci_fixup_i450gx },
@@ -183,5 +199,6 @@ struct pci_fixup pcibios_fixups[] = {
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8361,	        pci_fixup_via_northbridge_bug },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8367_0,	pci_fixup_via_northbridge_bug },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_NCR,	PCI_DEVICE_ID_NCR_53C810,	pci_fixup_ncr53c810 },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_ANY_ID,			pci_fixup_transparent_bridge },
 	{ 0 }
 };
--- 2.5.33/include/linux/pci.h	Sun Sep  1 02:05:03 2002
+++ linux/include/linux/pci.h	Fri Sep  6 16:21:46 2002
@@ -386,6 +386,9 @@ struct pci_dev {
 	int		ro;		/* ISAPnP: read only */
 	unsigned short	regs;		/* ISAPnP: supported registers */
 
+	/* These fields are used by common fixups */
+	unsigned short	transparent:1;	/* Transparent PCI bridge */
+
 	int (*prepare)(struct pci_dev *dev);	/* ISAPnP hooks */
 	int (*activate)(struct pci_dev *dev);
 	int (*deactivate)(struct pci_dev *dev);
@@ -406,6 +409,10 @@ struct pci_dev {
 #define PCI_ROM_RESOURCE 6
 #define PCI_BRIDGE_RESOURCES 7
 #define PCI_NUM_RESOURCES 11
+
+#ifndef PCI_BUS_NUM_RESOURCES
+#define PCI_BUS_NUM_RESOURCES 4
+#endif
   
 #define PCI_REGION_FLAG_MASK 0x0fU	/* These bits of resource flags tell us the PCI region flags */
 
@@ -415,7 +422,8 @@ struct pci_bus {
 	struct list_head children;	/* list of child buses */
 	struct list_head devices;	/* list of devices on this bus */
 	struct pci_dev	*self;		/* bridge device as seen by parent */
-	struct resource	*resource[4];	/* address space routed to this bus */
+	struct resource	*resource[PCI_BUS_NUM_RESOURCES];
+					/* address space routed to this bus */
 
 	struct pci_ops	*ops;		/* configuration access functions */
 	void		*sysdata;	/* hook for sys-specific extension */
--- 2.5.33/drivers/pci/quirks.c	Sun Sep  1 02:04:47 2002
+++ linux/drivers/pci/quirks.c	Fri Sep  6 16:14:47 2002
@@ -471,6 +471,11 @@ static void __init quirk_dunord ( struct
 	r -> end = 0xffffff;
 }
 
+static void __init quirk_transparent_bridge(struct pci_dev *dev)
+{
+	dev->transparent = 1;
+}
+
 /*
  *  The main table of quirks.
  */
@@ -525,6 +530,13 @@ static struct pci_fixup pci_fixups[] __i
 
 	{ PCI_FIXUP_FINAL, 	PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_VIPER_7410,	quirk_amd_ioapic },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_FE_GATE_700C, quirk_amd_ordering },
+	/*
+	 * i82380FB mobile docking controller: its PCI-to-PCI bridge
+	 * is subtractive decoding (transparent), and does indicate this
+	 * in the ProgIf. Unfortunately, the ProgIf value is wrong - 0x80
+	 * instead of 0x01.
+	 */
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82380FB,	quirk_transparent_bridge },
 
 	{ 0 }
 };
--- 2.5.33/drivers/pci/probe.c	Sun Sep  1 02:04:51 2002
+++ linux/drivers/pci/probe.c	Fri Sep  6 16:14:47 2002
@@ -128,6 +128,13 @@ void __devinit pci_read_bridge_bases(str
 	if (!dev)		/* It's a host bus, nothing to read */
 		return;
 
+	if (dev->transparent) {
+		printk("Transparent bridge - %s\n", dev->name);
+		for(i = 0; i < PCI_BUS_NUM_RESOURCES; i++)
+			child->resource[i] = child->parent->resource[i];
+		return;
+	}
+
 	for(i=0; i<3; i++)
 		child->resource[i] = &dev->resource[PCI_BRIDGE_RESOURCES+i];
 
@@ -149,13 +156,6 @@ void __devinit pci_read_bridge_bases(str
 		res->flags = (io_base_lo & PCI_IO_RANGE_TYPE_MASK) | IORESOURCE_IO;
 		res->start = base;
 		res->end = limit + 0xfff;
-	} else {
-		/*
-		 * Ugh. We don't know enough about this bridge. Just assume
-		 * that it's entirely transparent.
-		 */
-		printk(KERN_ERR "Unknown bridge resource %d: assuming transparent\n", 0);
-		child->resource[0] = child->parent->resource[0];
 	}
 
 	res = child->resource[1];
@@ -167,10 +167,6 @@ void __devinit pci_read_bridge_bases(str
 		res->flags = (mem_base_lo & PCI_MEMORY_RANGE_TYPE_MASK) | IORESOURCE_MEM;
 		res->start = base;
 		res->end = limit + 0xfffff;
-	} else {
-		/* See comment above. Same thing */
-		printk(KERN_ERR "Unknown bridge resource %d: assuming transparent\n", 1);
-		child->resource[1] = child->parent->resource[1];
 	}
 
 	res = child->resource[2];
@@ -197,10 +193,6 @@ void __devinit pci_read_bridge_bases(str
 		res->flags = (mem_base_lo & PCI_MEMORY_RANGE_TYPE_MASK) | IORESOURCE_MEM | IORESOURCE_PREFETCH;
 		res->start = base;
 		res->end = limit + 0xfffff;
-	} else {
-		/* See comments above */
-		printk(KERN_ERR "Unknown bridge resource %d: assuming transparent\n", 2);
-		child->resource[2] = child->parent->resource[2];
 	}
 }
 
@@ -389,6 +381,10 @@ int pci_setup_device(struct pci_dev * de
 	case PCI_HEADER_TYPE_BRIDGE:		    /* bridge header */
 		if (class != PCI_CLASS_BRIDGE_PCI)
 			goto bad;
+		/* The PCI-to-PCI bridge spec requires that subtractive
+		   decoding (i.e. transparent) bridge must have programming
+		   interface code of 0x01. */ 
+		dev->transparent = ((class & 0xff) == 1);
 		pci_read_bases(dev, 2, PCI_ROM_ADDRESS1);
 		break;
 
--- 2.5.33/drivers/pci/setup-res.c	Sun Sep  1 02:05:32 2002
+++ linux/drivers/pci/setup-res.c	Sun Sep  8 18:35:14 2002
@@ -73,7 +73,7 @@ static int pci_assign_bus_resource(const
 	int i;
 
 	type_mask |= IORESOURCE_IO | IORESOURCE_MEM;
-	for (i = 0 ; i < 4; i++) {
+	for (i = 0 ; i < PCI_BUS_NUM_RESOURCES; i++) {
 		struct resource *r = bus->resource[i];
 		if (!r)
 			continue;
