Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbVH3OtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbVH3OtO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 10:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbVH3OtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 10:49:14 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:65482 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S932162AbVH3OtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 10:49:14 -0400
Date: Tue, 30 Aug 2005 18:48:52 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Tero Roponen <teanropo@cc.jyu.fi>, linux-kernel@vger.kernel.org
Subject: [patch] x86: pci_assign_unassigned_resources() update
Message-ID: <20050830184852.A25380@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I've been on vacation, so I missed quite a few interesting
things that went into 2.6.13 (particularly the change for ROM resource
assignment, which looks excellent).
On the other hand, I had some time to think about PCI assign issues
in 2.6.13-rc series.

The major problem here is that we call pci_assign_unassigned_resources()
way too early - at subsys_initcall level. Therefore we give no chances
to ACPI and PnP routines (called at fs_initcall level) to reserve their
respective resources properly, as the comments in drivers/pnp/system.c
and drivers/acpi/motherboard.c suggest:
 /**
  * Reserve motherboard resources after PCI claim BARs,
  * but before PCI assign resources for uninitialized PCI devices
  */

So I moved pci_assign_unassigned_resources() call to pcibios_assign_resources()
(fs_initcall), which should hopefully fix a lot of problems and make
PCIBIOS_MIN_IO tweaks unnecessary.
Other changes:
- remove resource assignment code from pcibios_assign_resources(), since
  it duplicates pci_assign_unassigned_resources() functionality and
  actually does nothing in 2.6.13;
- modify ROM assignment code as per Ben's suggestion: try to use firmware
  settings by default (if PCI_ASSIGN_ROMS is not set);
- set CARDBUS_IO_SIZE back to 4K as it's a wonderful stress test for
  various setups.

Tero, can you confirm that 2.6.13 with this patch works for you?

Ivan.

--- 2.6.13/arch/i386/pci/common.c	2005-08-29 03:41:01.000000000 +0400
+++ linux/arch/i386/pci/common.c	2005-08-30 13:44:24.000000000 +0400
@@ -165,7 +165,6 @@ static int __init pcibios_init(void)
 	if ((pci_probe & PCI_BIOS_SORT) && !(pci_probe & PCI_NO_SORT))
 		pcibios_sort();
 #endif
-	pci_assign_unassigned_resources();
 	return 0;
 }
 
--- 2.6.13/arch/i386/pci/i386.c	2005-08-29 03:41:01.000000000 +0400
+++ linux/arch/i386/pci/i386.c	2005-08-30 17:35:03.000000000 +0400
@@ -170,43 +170,26 @@ static void __init pcibios_allocate_reso
 static int __init pcibios_assign_resources(void)
 {
 	struct pci_dev *dev = NULL;
-	int idx;
-	struct resource *r;
+	struct resource *r, *pr;
 
-	for_each_pci_dev(dev) {
-		int class = dev->class >> 8;
-
-		/* Don't touch classless devices and host bridges */
-		if (!class || class == PCI_CLASS_BRIDGE_HOST)
-			continue;
-
-		for(idx=0; idx<6; idx++) {
-			r = &dev->resource[idx];
-
-			/*
-			 *  Don't touch IDE controllers and I/O ports of video cards!
-			 */
-			if ((class == PCI_CLASS_STORAGE_IDE && idx < 4) ||
-			    (class == PCI_CLASS_DISPLAY_VGA && (r->flags & IORESOURCE_IO)))
-				continue;
-
-			/*
-			 *  We shall assign a new address to this resource, either because
-			 *  the BIOS forgot to do so or because we have decided the old
-			 *  address was unusable for some reason.
-			 */
-			if (!r->start && r->end)
-				pci_assign_resource(dev, idx);
-		}
-
-		if (pci_probe & PCI_ASSIGN_ROMS) {
+	if (!(pci_probe & PCI_ASSIGN_ROMS)) {
+		/* Try to use BIOS settings for ROMs, otherwise let
+		   pci_assign_unassigned_resources() allocate the new
+		   addresses. */
+		for_each_pci_dev(dev) {
 			r = &dev->resource[PCI_ROM_RESOURCE];
-			r->end -= r->start;
-			r->start = 0;
-			if (r->end)
-				pci_assign_resource(dev, PCI_ROM_RESOURCE);
+			if (!r->flags || !r->start)
+				continue;
+			pr = pci_find_parent_resource(dev, r);
+			if (!pr || request_resource(pr, r) < 0) {
+				r->end -= r->start;
+				r->start = 0;
+			}
 		}
 	}
+
+	pci_assign_unassigned_resources();
+
 	return 0;
 }
 
--- 2.6.13/drivers/pci/setup-bus.c	2005-08-29 03:41:01.000000000 +0400
+++ linux/drivers/pci/setup-bus.c	2005-08-30 13:44:24.000000000 +0400
@@ -40,7 +40,7 @@
  * FIXME: IO should be max 256 bytes.  However, since we may
  * have a P2P bridge below a cardbus bridge, we need 4K.
  */
-#define CARDBUS_IO_SIZE		(256)
+#define CARDBUS_IO_SIZE		(4*1024)
 #define CARDBUS_MEM_SIZE	(32*1024*1024)
 
 static void __devinit
