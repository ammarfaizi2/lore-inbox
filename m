Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316935AbSHZNxw>; Mon, 26 Aug 2002 09:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316957AbSHZNxw>; Mon, 26 Aug 2002 09:53:52 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:12300 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S316935AbSHZNxu>; Mon, 26 Aug 2002 09:53:50 -0400
Date: Mon, 26 Aug 2002 17:57:47 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [patch 2.5.31] transparent PCI-to-PCI bridges
Message-ID: <20020826175747.A27952@jurassic.park.msu.ru>
References: <3D690C1F.1090604@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D690C1F.1090604@colorfullife.com>; from manfred@colorfullife.com on Sun, Aug 25, 2002 at 06:55:59PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 25, 2002 at 06:55:59PM +0200, Manfred Spraul wrote:
> Why not
> 	if ((dev->class & 0xff) == 0x01)
> 
> Is the lowest bit an indicator of subtractive decoding, or is 
> Progif==0x01 the indicator of subtractive decoding?

The latter.

> The code and the comment should match.

Ok. Updated patch appended.

Ivan.

--- 2.5.31/arch/i386/pci/fixup.c	Sun Aug 11 05:41:21 2002
+++ linux/arch/i386/pci/fixup.c	Mon Aug 26 17:48:37 2002
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
+ * Indicate this by setting ProgIf to 0x01.
+ */
+static void __init pci_fixup_transparent_bridge(struct pci_dev *dev)
+{
+	if ((dev->class >> 8) == PCI_CLASS_BRIDGE_PCI &&
+	    (dev->device & 0xff00) == 0x2400)
+		dev->class = (dev->class & ~0xff) | 1;
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
+++ linux/drivers/pci/quirks.c	Mon Aug 26 17:50:16 2002
@@ -471,6 +471,11 @@ static void __init quirk_dunord ( struct
 	r -> end = 0xffffff;
 }
 
+static void __init quirk_transparent_bridge(struct pci_dev *dev)
+{
+	dev->class = (dev->class & ~0xff) | 1;
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
+++ linux/drivers/pci/probe.c	Mon Aug 26 17:38:51 2002
@@ -128,6 +128,18 @@ void __devinit pci_read_bridge_bases(str
 	if (!dev)		/* It's a host bus, nothing to read */
 		return;
 
+	/*
+	 * The PCI-to-PCI bridge spec requires that subtractive decoding
+	 * (i.e. transparent) bridge must have programming interface code
+	 * of 0x01.
+	 */ 
+	if ((dev->class & 0xff) == 0x01) {
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
 
