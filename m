Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318488AbSHPPpB>; Fri, 16 Aug 2002 11:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318497AbSHPPpB>; Fri, 16 Aug 2002 11:45:01 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:5895 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S318488AbSHPPo7>; Fri, 16 Aug 2002 11:44:59 -0400
Date: Fri, 16 Aug 2002 19:48:25 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: "H. J. Lu" <hjl@lucon.org>
Cc: dhinds <dhinds@sonic.net>, linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: New fix for CardBus bridge behind a PCI bridge
Message-ID: <20020816194825.A7086@jurassic.park.msu.ru>
References: <20020809164835.B21110@lucon.org> <20020809172140.A30911@sonic.net> <20020810222355.A13749@lucon.org> <20020812104902.A18430@lucon.org> <20020812110431.A14125@sonic.net> <20020812112911.A18947@lucon.org> <20020812122158.A27172@sonic.net> <20020812140730.A21710@lucon.org> <20020812154851.A20073@sonic.net> <20020812202942.A27362@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020812202942.A27362@lucon.org>; from hjl@lucon.org on Mon, Aug 12, 2002 at 08:29:42PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2002 at 08:29:42PM -0700, H. J. Lu wrote:
> I was told all PCI_CLASS_BRIDGE_PCI bridges were transparent. The non-
> transparent ones have class code PCI_CLASS_BRIDGE_OTHER. This new patch
> only checks PCI_CLASS_BRIDGE_PCI and works for me.

I guess that info came from Intel ;-)  Interesting, but completely wrong.
The devices they call "non-transparent PCI-to-PCI bridges" aren't classic
PCI-to-PCI bridges at all, that's why they are PCI_CLASS_BRIDGE_OTHER.
It's more to do with CPU-to-CPU bridges.
In our terms, "transparent" PCI-to-PCI bridge means subtractive decoding one.
Your previous patch makes much more sense, although a) it should belong to
generic pci code b) is way incomplete.

Please try this one instead.

Ivan.

--- 2.4.19/drivers/pci/quirks.c	Sat Aug  3 04:39:44 2002
+++ linux/drivers/pci/quirks.c	Fri Aug 16 18:38:52 2002
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
--- 2.4.19/drivers/pci/pci.c	Fri Aug 16 17:05:12 2002
+++ linux/drivers/pci/pci.c	Fri Aug 16 19:00:49 2002
@@ -1073,6 +1073,13 @@ void __devinit pci_read_bridge_bases(str
 	if (!dev)		/* It's a host bus, nothing to read */
 		return;
 
+	if (dev->class & 1) {
+		printk("Transparent bridge - %s\n", dev->name);
+		for(i=0; i < 3; i++)
+			child->resource[i] = child->parent->resource[i];
+		return;
+	}
+
 	for(i=0; i<3; i++)
 		child->resource[i] = &dev->resource[PCI_BRIDGE_RESOURCES+i];
 
@@ -1095,13 +1102,6 @@ void __devinit pci_read_bridge_bases(str
 		res->start = base;
 		res->end = limit + 0xfff;
 		res->name = child->name;
-	} else {
-		/*
-		 * Ugh. We don't know enough about this bridge. Just assume
-		 * that it's entirely transparent.
-		 */
-		printk(KERN_ERR "Unknown bridge resource %d: assuming transparent\n", 0);
-		child->resource[0] = child->parent->resource[0];
 	}
 
 	res = child->resource[1];
@@ -1114,10 +1114,6 @@ void __devinit pci_read_bridge_bases(str
 		res->start = base;
 		res->end = limit + 0xfffff;
 		res->name = child->name;
-	} else {
-		/* See comment above. Same thing */
-		printk(KERN_ERR "Unknown bridge resource %d: assuming transparent\n", 1);
-		child->resource[1] = child->parent->resource[1];
 	}
 
 	res = child->resource[2];
@@ -1145,10 +1141,6 @@ void __devinit pci_read_bridge_bases(str
 		res->start = base;
 		res->end = limit + 0xfffff;
 		res->name = child->name;
-	} else {
-		/* See comments above */
-		printk(KERN_ERR "Unknown bridge resource %d: assuming transparent\n", 2);
-		child->resource[2] = child->parent->resource[2];
 	}
 }
 
--- 2.4.19/arch/i386/kernel/pci-pc.c	Sat Aug  3 04:39:42 2002
+++ linux/arch/i386/kernel/pci-pc.c	Fri Aug 16 19:08:18 2002
@@ -1245,6 +1245,23 @@ static void __init pci_fixup_via_northbr
 	}
 }
 
+/*
+ * For some weird reasons Intel decided that certain parts of their
+ * 815, 845 and some other chipsets must look like PCI-to-PCI bridges
+ * while they are obviously not. The 82801xx (AA, AB, BAM/CAM, BA/CA/DB
+ * and E) PCI bridges are actually HUB-to-PCI ones, according to Intel
+ * terminology. These devices do forward all addresses from system to
+ * PCI bus no matter what are their window settings, so they are
+ * "transparent" (or subtractive decoding) from programmers point of view.
+ * Indicate this in ProgIf bit 0.
+ */
+static void __init pci_fixup_transparent_bridge(struct pci_dev *dev)
+{
+	if ((dev->class >> 8) == PCI_CLASS_BRIDGE_PCI &&
+	    (dev->device & 0xff00) == 0x2400);
+		dev->class |= 1;
+}
+
 struct pci_fixup pcibios_fixups[] = {
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82451NX,	pci_fixup_i450nx },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82454GX,	pci_fixup_i450gx },
@@ -1259,6 +1276,7 @@ struct pci_fixup pcibios_fixups[] = {
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8361,	        pci_fixup_via_northbridge_bug },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8367_0,	pci_fixup_via_northbridge_bug },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_NCR,	PCI_DEVICE_ID_NCR_53C810,	pci_fixup_ncr53c810 },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_ANY_ID,			pci_fixup_transparent_bridge },
 	{ 0 }
 };
 
