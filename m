Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266772AbSLPP3C>; Mon, 16 Dec 2002 10:29:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266774AbSLPP3C>; Mon, 16 Dec 2002 10:29:02 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:63965
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266772AbSLPP3A>; Mon, 16 Dec 2002 10:29:00 -0500
Subject: IDE but no disks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 16 Dec 2002 16:16:32 +0000
Message-Id: <1040055392.13910.52.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

People seeing IDE controllers detected but no disks can you try the
following backport of Ivan's 2.5 PCI fix

--- drivers/pci/quirks.c~	2002-12-16 16:01:08.000000000 +0000
+++ drivers/pci/quirks.c	2002-12-16 16:01:08.000000000 +0000
@@ -523,6 +523,56 @@
 }
 
 /*
+ * As per PCI spec, ignore base address registers 0-3 of the IDE controllers
+ * running in Compatible mode (bits 0 and 2 in the ProgIf for primary and
+ * secondary channels respectively). If the device reports Compatible mode
+ * but does use BAR0-3 for address decoding, we assume that firmware has
+ * programmed these BARs with standard values (0x1f0,0x3f4 and 0x170,0x374).
+ * Exceptions (if they exist) must be handled in chip/architecture specific
+ * fixups.
+ *
+ * Note: for non x86 people. You may need an arch specific quirk to handle
+ * moving IDE devices to native mode as well. Some plug in card devices power
+ * up in compatible mode and assume the BIOS will adjust them.
+ *
+ * Q: should we load the 0x1f0,0x3f4 into the registers or zap them as
+ * we do now ? We don't want is pci_enable_device to come along
+ * and assign new resources. Both approaches work for that.
+ */ 
+
+static void __devinit quirk_ide_bases(struct pci_dev *dev)
+{
+       struct resource *res;
+       int first_bar = 2, last_bar = 0;
+
+       if ((dev->class >> 8) != PCI_CLASS_STORAGE_IDE)
+               return;
+
+       res = &dev->resource[0];
+
+       /* primary channel: ProgIf bit 0, BAR0, BAR1 */
+       if (!(dev->class & 1) && (res[0].flags || res[1].flags)) { 
+               res[0].start = res[0].end = res[0].flags = 0;
+               res[1].start = res[1].end = res[1].flags = 0;
+               first_bar = 0;
+               last_bar = 1;
+       }
+
+       /* secondary channel: ProgIf bit 2, BAR2, BAR3 */
+       if (!(dev->class & 4) && (res[2].flags || res[3].flags)) { 
+               res[2].start = res[2].end = res[2].flags = 0;
+               res[3].start = res[3].end = res[3].flags = 0;
+               last_bar = 3;
+       }
+
+       if (!last_bar)
+               return;
+
+       printk(KERN_INFO "PCI: Ignoring BAR%d-%d of IDE controller %s\n",
+              first_bar, last_bar, dev->slot_name);
+}
+
+/*
  *  The main table of quirks.
  */
 
@@ -565,6 +615,7 @@
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_AL,	PCI_DEVICE_ID_AL_M7101,		quirk_ali7101_acpi },
  	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82371SB_2,	quirk_piix3_usb },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82371AB_2,	quirk_piix3_usb },
+	{ PCI_FIXUP_HEADER,     PCI_ANY_ID,             PCI_ANY_ID,                     quirk_ide_bases },
 	{ PCI_FIXUP_FINAL,	PCI_ANY_ID,		PCI_ANY_ID,			quirk_cardbus_legacy },
 
 #ifdef CONFIG_X86_IO_APIC 


