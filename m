Return-Path: <linux-kernel-owner+w=401wt.eu-S1754767AbXABCdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754767AbXABCdH (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 21:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755078AbXABCdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 21:33:06 -0500
Received: from THUNK.ORG ([69.25.196.29]:51095 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755040AbXABCdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 21:33:05 -0500
Date: Mon, 1 Jan 2007 21:32:55 -0500
From: Theodore Tso <tytso@mit.edu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Happy New Year (and v2.6.20-rc3 released)
Message-ID: <20070102023255.GA21546@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Linus Torvalds <torvalds@osdl.org>, Alan <alan@lxorguk.ukuu.org.uk>,
	Jeff Garzik <jgarzik@pobox.com>,
	Alessandro Suardi <alessandro.suardi@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0612311710430.4473@woody.osdl.org> <5a4c581d0701010528y3ba05247nc39f2ef096f84afa@mail.gmail.com> <Pine.LNX.4.64.0701011209140.4473@woody.osdl.org> <459973F6.2090201@pobox.com> <20070101213152.2cfc51c2@localhost.localdomain> <Pine.LNX.4.64.0701011533360.4473@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701011533360.4473@woody.osdl.org>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 01, 2007 at 03:34:53PM -0800, Linus Torvalds wrote:
> 
> 
> On Mon, 1 Jan 2007, Alan wrote:
> >
> > Want a fix Linus given Jeff is away ?
> 
> Send it over, and please cc Alessandro and others that can test it. Things 
> obviously aren't broken on _my_ machines ;)

Can I get a copy of the fix for testing as well?  I can confirm that
Alan's 368c73d4f689dae0807d0a2aa74c61fd2b9b075f breaks for me on my
T60 thinkpad.  Unfortunately I missed the earlier discussion on this,
and I didn't have time to test -rc1 and -rc2, so I spent a few hours
doing the git bisection in order to determine that it was Alan's
2b9b075f patch which was breaking -rc3 for me.

My current plan for testing -rc3 was to back out Alan's patch
(attached below for others' convenience), but I'm happy to test an
alternative fix.

						- Ted

Revert "PCI: quirks: fix the festering mess that claims to handle IDE quirks"

This reverts commit 368c73d4f689dae0807d0a2aa74c61fd2b9b075f.

This is needed to fix booting on a Thinkpad T60.  Without this patch,
we see the following error messages, and the SATA drive in the laptop
isn't detected, with the following messages printed during the boot
sequence:

ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 16 (level, low) -> IRQ 16
PCI: Unable to reserve I/O Region #1:8@1f0 for device 0000:00:1f.2
ata_piix: probe of 0000:00:1f.2 failed with error -16

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
---
 arch/i386/pci/fixup.c |   46 ++++++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c   |   27 ----------------------
 drivers/pci/quirks.c  |   59 ++++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 102 insertions(+), 30 deletions(-)

diff --git a/arch/i386/pci/fixup.c b/arch/i386/pci/fixup.c
index 8053b17..422483e 100644
--- a/arch/i386/pci/fixup.c
+++ b/arch/i386/pci/fixup.c
@@ -74,6 +74,52 @@ static void __devinit  pci_fixup_ncr53c810(struct pci_dev *d)
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C810, pci_fixup_ncr53c810);
 
+static void __devinit pci_fixup_ide_bases(struct pci_dev *d)
+{
+	int i;
+
+	/*
+	 * PCI IDE controllers use non-standard I/O port decoding, respect it.
+	 */
+	if ((d->class >> 8) != PCI_CLASS_STORAGE_IDE)
+		return;
+	DBG("PCI: IDE base address fixup for %s\n", pci_name(d));
+	for(i=0; i<4; i++) {
+		struct resource *r = &d->resource[i];
+		if ((r->start & ~0x80) == 0x374) {
+			r->start |= 2;
+			r->end = r->start;
+		}
+	}
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pci_fixup_ide_bases);
+
+static void __devinit  pci_fixup_ide_trash(struct pci_dev *d)
+{
+	int i;
+
+	/*
+	 * Runs the fixup only for the first IDE controller
+	 * (Shai Fultheim - shai@ftcon.com)
+	 */
+	static int called = 0;
+	if (called)
+		return;
+	called = 1;
+
+	/*
+	 * There exist PCI IDE controllers which have utter garbage
+	 * in first four base registers. Ignore that.
+	 */
+	DBG("PCI: IDE base address trash cleared for %s\n", pci_name(d));
+	for(i=0; i<4; i++)
+		d->resource[i].start = d->resource[i].end = d->resource[i].flags = 0;
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_5513, pci_fixup_ide_trash);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_10, pci_fixup_ide_trash);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_11, pci_fixup_ide_trash);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_9, pci_fixup_ide_trash);
+
 static void __devinit  pci_fixup_latency(struct pci_dev *d)
 {
 	/*
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 0e0401d..8e077b1 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -681,33 +681,6 @@ static int pci_setup_device(struct pci_dev * dev)
 		pci_read_bases(dev, 6, PCI_ROM_ADDRESS);
 		pci_read_config_word(dev, PCI_SUBSYSTEM_VENDOR_ID, &dev->subsystem_vendor);
 		pci_read_config_word(dev, PCI_SUBSYSTEM_ID, &dev->subsystem_device);
-
-		/*
-		 *	Do the ugly legacy mode stuff here rather than broken chip
-		 *	quirk code. Legacy mode ATA controllers have fixed
-		 *	addresses. These are not always echoed in BAR0-3, and
-		 *	BAR0-3 in a few cases contain junk!
-		 */
-		if (class == PCI_CLASS_STORAGE_IDE) {
-			u8 progif;
-			pci_read_config_byte(dev, PCI_CLASS_PROG, &progif);
-			if ((progif & 1) == 0) {
-				dev->resource[0].start = 0x1F0;
-				dev->resource[0].end = 0x1F7;
-				dev->resource[0].flags = LEGACY_IO_RESOURCE;
-				dev->resource[1].start = 0x3F6;
-				dev->resource[1].end = 0x3F6;
-				dev->resource[1].flags = LEGACY_IO_RESOURCE;
-			}
-			if ((progif & 4) == 0) {
-				dev->resource[2].start = 0x170;
-				dev->resource[2].end = 0x177;
-				dev->resource[2].flags = LEGACY_IO_RESOURCE;
-				dev->resource[3].start = 0x376;
-				dev->resource[3].end = 0x376;
-				dev->resource[3].flags = LEGACY_IO_RESOURCE;
-			}
-		}
 		break;
 
 	case PCI_HEADER_TYPE_BRIDGE:		    /* bridge header */
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 8f0322d..d6c4130 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -827,6 +827,56 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CYRIX,	PCI_DEVICE_ID_CYRIX_PCI_MASTER, qui
 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_CYRIX,	PCI_DEVICE_ID_CYRIX_PCI_MASTER, quirk_mediagx_master );
 
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
+              first_bar, last_bar, pci_name(dev));
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, quirk_ide_bases);
+
+/*
  *	Ensure C0 rev restreaming is off. This is normally done by
  *	the BIOS but in the odd case it is not the results are corruption
  *	hence the presence of a Linux check
@@ -878,10 +928,11 @@ static void __devinit quirk_svwks_csb5ide(struct pci_dev *pdev)
 		prog &= ~5;
 		pdev->class &= ~5;
 		pci_write_config_byte(pdev, PCI_CLASS_PROG, prog);
-		/* PCI layer will sort out resources */
+		/* need to re-assign BARs for compat mode */
+		quirk_ide_bases(pdev);
 	}
 }
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB5IDE, quirk_svwks_csb5ide );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB5IDE, quirk_svwks_csb5ide );
 
 /*
  *	Intel 82801CAM ICH3-M datasheet says IDE modes must be the same
@@ -897,9 +948,11 @@ static void __init quirk_ide_samemode(struct pci_dev *pdev)
 		prog &= ~5;
 		pdev->class &= ~5;
 		pci_write_config_byte(pdev, PCI_CLASS_PROG, prog);
+		/* need to re-assign BARs for compat mode */
+		quirk_ide_bases(pdev);
 	}
 }
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_10, quirk_ide_samemode);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_10, quirk_ide_samemode);
 
 /* This was originally an Alpha specific thing, but it really fits here.
  * The i82375 PCI/EISA bridge appears as non-classified. Fix that.
-- 
1.5.0.rc0.g1d42

