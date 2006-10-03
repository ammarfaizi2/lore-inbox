Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030668AbWJCXQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030668AbWJCXQI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 19:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030669AbWJCXQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 19:16:07 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:9160 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030668AbWJCXQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 19:16:06 -0400
Subject: [PATCH] quirks: fix the festering mess that claims to handle IDE
	quirks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, greg@kroah.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 04 Oct 2006 00:41:26 +0100
Message-Id: <1159918886.17553.111.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The number of permutations of crap we do is amazing and almost all of it
has the wrong effect in 2.6.

At the heart of this is the PCI SFF magic which says that compatibility
mode PCI IDE controllers use ISA IRQ routing and hard coded addresses
not the BAR values. The old quirks variously clears them, sets them,
adjusts them and then IDE ignores the result.

In order to drive all this garbage out and to do it portably we need to
handle the SFF rules directly and properly. Because we know the device
BAR 0-3 are not used in compatibility mode we load them with the values
that are implied (and indeed which many controllers actually
thoughtfully put there in this mode anyway).

This removes special cases in the IDE layer and libata which now knows
that bar 0/1/2/3 always contain the correct address. It means our
resource allocation map is accurate from boot, not "mostly accurate"
after ide is loaded, and it shoots lots of code. There is also lots more
code and magic constant knowledge to shoot once this is in and settled.

Been in my test tree for a while both with drivers/ide and with libata.
Wants some -mm shakedown in case I've missed something dumb or there are
corner cases lurking.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm3/drivers/pci/probe.c linux-2.6.18-mm3/drivers/pci/probe.c
--- linux.vanilla-2.6.18-mm3/drivers/pci/probe.c	2006-10-03 19:23:10.041227968 +0100
+++ linux-2.6.18-mm3/drivers/pci/probe.c	2006-10-03 23:31:40.637472792 +0100
@@ -679,6 +679,33 @@
 		pci_read_bases(dev, 6, PCI_ROM_ADDRESS);
 		pci_read_config_word(dev, PCI_SUBSYSTEM_VENDOR_ID, &dev->subsystem_vendor);
 		pci_read_config_word(dev, PCI_SUBSYSTEM_ID, &dev->subsystem_device);
+
+		/*
+		 *	Do the ugly legacy mode stuff here rather than broken chip
+		 *	quirk code. Legacy mode ATA controllers have fixed
+		 *	addresses. These are not always echoed in BAR0-3, and
+		 *	BAR0-3 in a few cases contain junk!
+		 */
+		if (class == PCI_CLASS_STORAGE_IDE) {
+			u8 progif;
+			pci_read_config_byte(dev, PCI_CLASS_PROG, &progif);
+			if ((progif & 1) == 0) {
+				dev->resource[0].start = 0x1F0;
+				dev->resource[0].end = 0x1F7;
+				dev->resource[0].flags = IORESOURCE_IO;
+				dev->resource[1].start = 0x3F6;
+				dev->resource[1].end = 0x3F6;
+				dev->resource[1].flags = IORESOURCE_IO;
+			}
+			if ((progif & 4) == 0) {
+				dev->resource[2].start = 0x170;
+				dev->resource[2].end = 0x177;
+				dev->resource[2].flags = IORESOURCE_IO;
+				dev->resource[3].start = 0x376;
+				dev->resource[3].end = 0x376;
+				dev->resource[3].flags = IORESOURCE_IO;
+			}
+		}
 		break;
 
 	case PCI_HEADER_TYPE_BRIDGE:		    /* bridge header */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm3/drivers/pci/quirks.c linux-2.6.18-mm3/drivers/pci/quirks.c
--- linux.vanilla-2.6.18-mm3/drivers/pci/quirks.c	2006-10-03 19:23:10.043227664 +0100
+++ linux-2.6.18-mm3/drivers/pci/quirks.c	2006-10-03 23:31:40.653470360 +0100
@@ -824,56 +824,6 @@
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CYRIX,	PCI_DEVICE_ID_CYRIX_PCI_MASTER, quirk_mediagx_master );
 
 /*
- * As per PCI spec, ignore base address registers 0-3 of the IDE controllers
- * running in Compatible mode (bits 0 and 2 in the ProgIf for primary and
- * secondary channels respectively). If the device reports Compatible mode
- * but does use BAR0-3 for address decoding, we assume that firmware has
- * programmed these BARs with standard values (0x1f0,0x3f4 and 0x170,0x374).
- * Exceptions (if they exist) must be handled in chip/architecture specific
- * fixups.
- *
- * Note: for non x86 people. You may need an arch specific quirk to handle
- * moving IDE devices to native mode as well. Some plug in card devices power
- * up in compatible mode and assume the BIOS will adjust them.
- *
- * Q: should we load the 0x1f0,0x3f4 into the registers or zap them as
- * we do now ? We don't want is pci_enable_device to come along
- * and assign new resources. Both approaches work for that.
- */ 
-static void __devinit quirk_ide_bases(struct pci_dev *dev)
-{
-       struct resource *res;
-       int first_bar = 2, last_bar = 0;
-
-       if ((dev->class >> 8) != PCI_CLASS_STORAGE_IDE)
-               return;
-
-       res = &dev->resource[0];
-
-       /* primary channel: ProgIf bit 0, BAR0, BAR1 */
-       if (!(dev->class & 1) && (res[0].flags || res[1].flags)) { 
-               res[0].start = res[0].end = res[0].flags = 0;
-               res[1].start = res[1].end = res[1].flags = 0;
-               first_bar = 0;
-               last_bar = 1;
-       }
-
-       /* secondary channel: ProgIf bit 2, BAR2, BAR3 */
-       if (!(dev->class & 4) && (res[2].flags || res[3].flags)) { 
-               res[2].start = res[2].end = res[2].flags = 0;
-               res[3].start = res[3].end = res[3].flags = 0;
-               last_bar = 3;
-       }
-
-       if (!last_bar)
-               return;
-
-       printk(KERN_INFO "PCI: Ignoring BAR%d-%d of IDE controller %s\n",
-              first_bar, last_bar, pci_name(dev));
-}
-DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, quirk_ide_bases);
-
-/*
  *	Ensure C0 rev restreaming is off. This is normally done by
  *	the BIOS but in the odd case it is not the results are corruption
  *	hence the presence of a Linux check
@@ -907,11 +857,10 @@
 		prog &= ~5;
 		pdev->class &= ~5;
 		pci_write_config_byte(pdev, PCI_CLASS_PROG, prog);
-		/* need to re-assign BARs for compat mode */
-		quirk_ide_bases(pdev);
+		/* PCI layer will sort out resources */
 	}
 }
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB5IDE, quirk_svwks_csb5ide );
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB5IDE, quirk_svwks_csb5ide );
 
 /*
  *	Intel 82801CAM ICH3-M datasheet says IDE modes must be the same
@@ -927,11 +876,9 @@
 		prog &= ~5;
 		pdev->class &= ~5;
 		pci_write_config_byte(pdev, PCI_CLASS_PROG, prog);
-		/* need to re-assign BARs for compat mode */
-		quirk_ide_bases(pdev);
 	}
 }
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_10, quirk_ide_samemode);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_10, quirk_ide_samemode);
 
 /* This was originally an Alpha specific thing, but it really fits here.
  * The i82375 PCI/EISA bridge appears as non-classified. Fix that.
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm3/arch/i386/pci/fixup.c linux-2.6.18-mm3/arch/i386/pci/fixup.c
--- linux.vanilla-2.6.18-mm3/arch/i386/pci/fixup.c	2006-10-03 19:23:01.818478016 +0100
+++ linux-2.6.18-mm3/arch/i386/pci/fixup.c	2006-09-28 13:42:26.000000000 +0100
@@ -74,52 +74,6 @@
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C810, pci_fixup_ncr53c810);
 
-static void __devinit pci_fixup_ide_bases(struct pci_dev *d)
-{
-	int i;
-
-	/*
-	 * PCI IDE controllers use non-standard I/O port decoding, respect it.
-	 */
-	if ((d->class >> 8) != PCI_CLASS_STORAGE_IDE)
-		return;
-	DBG("PCI: IDE base address fixup for %s\n", pci_name(d));
-	for(i=0; i<4; i++) {
-		struct resource *r = &d->resource[i];
-		if ((r->start & ~0x80) == 0x374) {
-			r->start |= 2;
-			r->end = r->start;
-		}
-	}
-}
-DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pci_fixup_ide_bases);
-
-static void __devinit  pci_fixup_ide_trash(struct pci_dev *d)
-{
-	int i;
-
-	/*
-	 * Runs the fixup only for the first IDE controller
-	 * (Shai Fultheim - shai@ftcon.com)
-	 */
-	static int called = 0;
-	if (called)
-		return;
-	called = 1;
-
-	/*
-	 * There exist PCI IDE controllers which have utter garbage
-	 * in first four base registers. Ignore that.
-	 */
-	DBG("PCI: IDE base address trash cleared for %s\n", pci_name(d));
-	for(i=0; i<4; i++)
-		d->resource[i].start = d->resource[i].end = d->resource[i].flags = 0;
-}
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_5513, pci_fixup_ide_trash);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_10, pci_fixup_ide_trash);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_11, pci_fixup_ide_trash);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_9, pci_fixup_ide_trash);
-
 static void __devinit  pci_fixup_latency(struct pci_dev *d)
 {
 	/*

