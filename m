Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316673AbSHXUSE>; Sat, 24 Aug 2002 16:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316674AbSHXUSE>; Sat, 24 Aug 2002 16:18:04 -0400
Received: from zeus.kernel.org ([204.152.189.113]:52917 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S316673AbSHXUSC>;
	Sat, 24 Aug 2002 16:18:02 -0400
Date: Sun, 25 Aug 2002 00:17:11 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 2.5.31] transparent PCI-to-PCI bridges
Message-ID: <20020825001711.A988@localhost.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,
here is the attempt to fix pci_read_bridge_bases() wrt
"transparent bridges" as per PCI specs.
Current code doesn't work in two cases:
1. The bridge is not transparent, but some (or all) of its windows
   are disabled (base > limit) by BIOS because devices on the
   secondary bus don't have IO or memory resources. For instance,
   AGP cards not using IO registers or prefetchable memory are
   quite common.
2. The bridge _is_ transparent, but its base/limit registers have
   been programmed with reasonable values. The device with IO/MEM
   outside these ranges will work, but the kernel won't allow it
   because of resource conflicts.

According to PCI spec, subtractive decoding bridge must have
class code of 0x60401. Unfortunately, certain vendors ignored
this requirement - therefore they are welcomed to "quirks".
By now I've read through a number of datasheets available from
developer.intel.com. There are following "quirks":
all PCI bridges from i82801 IO controller family are "transparent" -
these ones are i386 specific;
i82380FB mobile docking controller - theoretically it can be used
with any architecture, so it's placed into the generic quirks.

It's quite possible that this list will grow and I think it's ok.

Ivan.


--- 2.5.31/arch/i386/pci/fixup.c	Sun Aug 11 05:41:21 2002
+++ linux/arch/i386/pci/fixup.c	Fri Aug 23 20:16:48 2002
@@ -166,6 +166,23 @@ static void __init pci_fixup_via_northbr
 	}
 }
 
+/*
+ * For some weird reasons Intel decided that certain parts of their
+ * 815, 845 and some other chipsets must look like PCI-to-PCI bridges
+ * while they are obviously not. The 82801 family (AA, AB, BAM/CAM,
+ * BA/CA/DB and E) PCI bridges are actually HUB-to-PCI ones, according
+ * to Intel terminology. These devices do forward all addresses from
+ * system to PCI bus no matter what are their window settings, so they are
+ * "transparent" (or subtractive decoding) from programmers point of view.
+ * Indicate this by setting ProgIf bit 0.
+ */
+static void __init pci_fixup_transparent_bridge(struct pci_dev *dev)
+{
+	if ((dev->class >> 8) == PCI_CLASS_BRIDGE_PCI &&
+	    (dev->device & 0xff00) == 0x2400)
+		dev->class |= 1;
+}
+
 struct pci_fixup pcibios_fixups[] = {
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82451NX,	pci_fixup_i450nx },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82454GX,	pci_fixup_i450gx },
@@ -183,5 +200,6 @@ struct pci_fixup pcibios_fixups[] = {
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8361,	        pci_fixup_via_northbridge_bug },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8367_0,	pci_fixup_via_northbridge_bug },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_NCR,	PCI_DEVICE_ID_NCR_53C810,	pci_fixup_ncr53c810 },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_ANY_ID,			pci_fixup_transparent_bridge },
 	{ 0 }
 };
--- 2.5.31/drivers/pci/quirks.c	Sun Aug 11 05:41:17 2002
+++ linux/drivers/pci/quirks.c	Fri Aug 23 19:35:30 2002
@@ -471,6 +471,11 @@ static void __init quirk_dunord ( struct
 	r -> end = 0xffffff;
 }
 
+static void __init quirk_transparent_bridge(struct pci_dev *dev)
+{
+	dev->class |= 1;
+}
+
 /*
  *  The main table of quirks.
  */
@@ -525,6 +530,12 @@ static struct pci_fixup pci_fixups[] __i
 
 	{ PCI_FIXUP_FINAL, 	PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_VIPER_7410,	quirk_amd_ioapic },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_FE_GATE_700C, quirk_amd_ordering },
+	/*
+	 * i82380FB mobile docking controller: its PCI-to-PCI bridge
+	 * is subtractive decoding (transparent), and does indicate this
+	 * in the ProgIf. Unfortunately, in the wrong bit - 7 instead of 0.
+	 */
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82380FB,	quirk_transparent_bridge },
 
 	{ 0 }
 };
--- 2.5.31/drivers/pci/probe.c	Sun Aug 11 05:41:21 2002
+++ linux/drivers/pci/probe.c	Fri Aug 23 21:07:43 2002
@@ -128,6 +128,18 @@ void __devinit pci_read_bridge_bases(str
 	if (!dev)		/* It's a host bus, nothing to read */
 		return;
 
+	/*
+	 * The PCI-to-PCI bridge spec requires that subtractive decoding
+	 * (i.e. transparent) bridge must have programming interface code
+	 * of 0x01.
+	 */ 
+	if (dev->class & 1) {
+		printk("Transparent bridge - %s\n", dev->name);
+		for(i = 0; i < 3; i++)
+			child->resource[i] = child->parent->resource[i];
+		return;
+	}
+
 	for(i=0; i<3; i++)
 		child->resource[i] = &dev->resource[PCI_BRIDGE_RESOURCES+i];
 
@@ -149,13 +161,6 @@ void __devinit pci_read_bridge_bases(str
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
@@ -167,10 +172,6 @@ void __devinit pci_read_bridge_bases(str
 		res->flags = (mem_base_lo & PCI_MEMORY_RANGE_TYPE_MASK) | IORESOURCE_MEM;
 		res->start = base;
 		res->end = limit + 0xfffff;
-	} else {
-		/* See comment above. Same thing */
-		printk(KERN_ERR "Unknown bridge resource %d: assuming transparent\n", 1);
-		child->resource[1] = child->parent->resource[1];
 	}
 
 	res = child->resource[2];
@@ -197,10 +198,6 @@ void __devinit pci_read_bridge_bases(str
 		res->flags = (mem_base_lo & PCI_MEMORY_RANGE_TYPE_MASK) | IORESOURCE_MEM | IORESOURCE_PREFETCH;
 		res->start = base;
 		res->end = limit + 0xfffff;
-	} else {
-		/* See comments above */
-		printk(KERN_ERR "Unknown bridge resource %d: assuming transparent\n", 2);
-		child->resource[2] = child->parent->resource[2];
 	}
 }
 
