Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319070AbSIKPFr>; Wed, 11 Sep 2002 11:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319079AbSIKPFr>; Wed, 11 Sep 2002 11:05:47 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:6148 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S319070AbSIKPFp>; Wed, 11 Sep 2002 11:05:45 -0400
Date: Wed, 11 Sep 2002 19:10:16 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: mj@ucw.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Subject: [patch 2.4.20-pre6] transparent pci-pci bridges fix
Message-ID: <20020911191016.A822@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is 2.4 version of the stuff included in 2.5.34.
This
- fixes resource allocation problems on some laptops;
- fixes problems with incorrectly detected "transparent"
  bridges which is harmful on ppc32, for example.

Ivan.

--- 2.4.20p6/include/linux/pci.h	Tue Sep 10 19:03:09 2002
+++ linux/include/linux/pci.h	Tue Sep 10 19:26:53 2002
@@ -382,6 +382,9 @@ struct pci_dev {
 	int		ro;		/* ISAPnP: read only */
 	unsigned short	regs;		/* ISAPnP: supported registers */
 
+	/* These fields are used by common fixups */
+	unsigned short	transparent:1;	/* Transparent PCI bridge */
+
 	int (*prepare)(struct pci_dev *dev);	/* ISAPnP hooks */
 	int (*activate)(struct pci_dev *dev);
 	int (*deactivate)(struct pci_dev *dev);
--- 2.4.20p6/drivers/pci/pci.c	Tue Sep 10 19:02:40 2002
+++ linux/drivers/pci/pci.c	Tue Sep 10 19:26:31 2002
@@ -1131,6 +1131,13 @@ void __devinit pci_read_bridge_bases(str
 	if (!dev)		/* It's a host bus, nothing to read */
 		return;
 
+	if (dev->transparent) {
+		printk("Transparent bridge - %s\n", dev->name);
+		for(i = 0; i < 4; i++)
+			child->resource[i] = child->parent->resource[i];
+		return;
+	}
+
 	for(i=0; i<3; i++)
 		child->resource[i] = &dev->resource[PCI_BRIDGE_RESOURCES+i];
 
@@ -1153,13 +1160,6 @@ void __devinit pci_read_bridge_bases(str
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
@@ -1172,10 +1172,6 @@ void __devinit pci_read_bridge_bases(str
 		res->start = base;
 		res->end = limit + 0xfffff;
 		res->name = child->name;
-	} else {
-		/* See comment above. Same thing */
-		printk(KERN_ERR "Unknown bridge resource %d: assuming transparent\n", 1);
-		child->resource[1] = child->parent->resource[1];
 	}
 
 	res = child->resource[2];
@@ -1203,10 +1199,6 @@ void __devinit pci_read_bridge_bases(str
 		res->start = base;
 		res->end = limit + 0xfffff;
 		res->name = child->name;
-	} else {
-		/* See comments above */
-		printk(KERN_ERR "Unknown bridge resource %d: assuming transparent\n", 2);
-		child->resource[2] = child->parent->resource[2];
 	}
 }
 
@@ -1392,6 +1384,10 @@ int pci_setup_device(struct pci_dev * de
 	case PCI_HEADER_TYPE_BRIDGE:		    /* bridge header */
 		if (class != PCI_CLASS_BRIDGE_PCI)
 			goto bad;
+		/* The PCI-to-PCI bridge spec requires that subtractive
+		   decoding (i.e. transparent) bridge must have programming
+		   interface code of 0x01. */ 
+		dev->transparent = ((class & 0xff) == 1);
 		pci_read_bases(dev, 2, PCI_ROM_ADDRESS1);
 		break;
 
--- 2.4.20p6/drivers/pci/quirks.c	Sat Aug  3 04:39:44 2002
+++ linux/drivers/pci/quirks.c	Tue Sep 10 19:26:53 2002
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
--- 2.4.20p6/arch/i386/kernel/pci-pc.c	Tue Sep 10 19:02:09 2002
+++ linux/arch/i386/kernel/pci-pc.c	Tue Sep 10 19:26:53 2002
@@ -1307,6 +1307,22 @@ static void __init pci_fixup_via_northbr
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
@@ -1321,6 +1337,7 @@ struct pci_fixup pcibios_fixups[] = {
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8361,	        pci_fixup_via_northbridge_bug },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8367_0,	pci_fixup_via_northbridge_bug },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_NCR,	PCI_DEVICE_ID_NCR_53C810,	pci_fixup_ncr53c810 },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_ANY_ID,			pci_fixup_transparent_bridge },
 	{ 0 }
 };
 
