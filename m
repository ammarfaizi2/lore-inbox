Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316465AbSHaHhV>; Sat, 31 Aug 2002 03:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316491AbSHaHhU>; Sat, 31 Aug 2002 03:37:20 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:22532 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S316465AbSHaHg2>; Sat, 31 Aug 2002 03:36:28 -0400
Date: Sat, 31 Aug 2002 01:38:29 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: [patch 2.5.32] transparent PCI-to-PCI bridges
Message-ID: <20020831013829.A926@jurassic.park.msu.ru>
References: <20020828045802.A31036@jurassic.park.msu.ru> <Pine.LNX.4.44.0208271828080.1287-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0208271828080.1287-100000@home.transmeta.com>; from torvalds@transmeta.com on Tue, Aug 27, 2002 at 06:29:23PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2002 at 06:29:23PM -0700, Linus Torvalds wrote:
> Why add a bitfield, and not just add single bitmembers?

Modified as you suggested. For now, "transparent" is the only field
added to the struct pci_dev. Adding other fields certainly looks
promising, but it will take some time...

Ivan.

--- 2.5.32/drivers/pci/quirks.c	Tue Aug 27 23:26:32 2002
+++ linux/drivers/pci/quirks.c	Fri Aug 30 18:32:32 2002
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
--- 2.5.32/drivers/pci/probe.c	Tue Aug 27 23:26:36 2002
+++ linux/drivers/pci/probe.c	Fri Aug 30 18:20:44 2002
@@ -128,6 +128,13 @@ void __devinit pci_read_bridge_bases(str
 	if (!dev)		/* It's a host bus, nothing to read */
 		return;
 
+	if (dev->transparent) {
+		printk("Transparent bridge - %s\n", dev->name);
+		for(i = 0; i < 3; i++)
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
 
@@ -388,6 +380,10 @@ int pci_setup_device(struct pci_dev * de
 	case PCI_HEADER_TYPE_BRIDGE:		    /* bridge header */
 		if (class != PCI_CLASS_BRIDGE_PCI)
 			goto bad;
+		/* The PCI-to-PCI bridge spec requires that subtractive
+		   decoding (i.e. transparent) bridge must have programming
+		   interface code of 0x01. */ 
+		dev->transparent = ((class & 0xff) == 1);
 		pci_read_bases(dev, 2, PCI_ROM_ADDRESS1);
 		break;
 
--- 2.5.32/arch/i386/pci/fixup.c	Tue Aug 27 23:26:35 2002
+++ linux/arch/i386/pci/fixup.c	Fri Aug 30 18:23:04 2002
@@ -166,6 +166,22 @@ static void __init pci_fixup_via_northbr
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
--- 2.5.32/include/linux/pci.h	Tue Aug 27 23:26:42 2002
+++ linux/include/linux/pci.h	Fri Aug 30 18:08:09 2002
@@ -385,6 +385,9 @@ struct pci_dev {
 	int		ro;		/* ISAPnP: read only */
 	unsigned short	regs;		/* ISAPnP: supported registers */
 
+	/* These fields are used by common fixups */
+	unsigned short	transparent:1;	/* Transparent PCI bridge */
+
 	int (*prepare)(struct pci_dev *dev);	/* ISAPnP hooks */
 	int (*activate)(struct pci_dev *dev);
 	int (*deactivate)(struct pci_dev *dev);
