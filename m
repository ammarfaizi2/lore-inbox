Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932853AbVIHB3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932853AbVIHB3l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 21:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932857AbVIHB3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 21:29:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39834 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932853AbVIHB3e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 21:29:34 -0400
Message-Id: <20050908012856.362214000@localhost.localdomain>
References: <20050908012842.299637000@localhost.localdomain>
Date: Wed, 07 Sep 2005 18:28:46 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Chris Wright <chrisw@osdl.org>
Subject: [PATCH 4/9] [PATCH] x86: pci_assign_unassigned_resources() update
Content-Disposition: inline; filename=pci_assign_unassigned_resources-update.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any  objections, please let us know.
------------------

I had some time to think about PCI assign issues in 2.6.13-rc series.

The major problem here is that we call pci_assign_unassigned_resources()
way too early - at subsys_initcall level. Therefore we give no chances
to ACPI and PnP routines (called at fs_initcall level) to reserve their
respective resources properly, as the comments in drivers/pnp/system.c
and drivers/acpi/motherboard.c suggest:

 /**
  * Reserve motherboard resources after PCI claim BARs,
  * but before PCI assign resources for uninitialized PCI devices
  */

So I moved the pci_assign_unassigned_resources() call to
pcibios_assign_resources() (fs_initcall), which should hopefully fix a
lot of problems and make PCIBIOS_MIN_IO tweaks unnecessary.

Other changes:
- remove resource assignment code from pcibios_assign_resources(), since
  it duplicates pci_assign_unassigned_resources() functionality and
  actually does nothing in 2.6.13;
- modify ROM assignment code as per Ben's suggestion: try to use firmware
  settings by default (if PCI_ASSIGN_ROMS is not set);
- set CARDBUS_IO_SIZE back to 4K as it's a wonderful stress test for
  various setups.

Confirmed by Tero Roponen <teanropo@cc.jyu.fi> (who had problems with
the 4kB CardBus IO size previously).

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---
 arch/i386/pci/common.c  |    1 
 arch/i386/pci/i386.c    |   49 +++++++++++++++---------------------------------
 drivers/pci/setup-bus.c |    2 -
 3 files changed, 17 insertions(+), 35 deletions(-)

Index: linux-2.6.13.y/arch/i386/pci/common.c
===================================================================
--- linux-2.6.13.y.orig/arch/i386/pci/common.c
+++ linux-2.6.13.y/arch/i386/pci/common.c
@@ -165,7 +165,6 @@ static int __init pcibios_init(void)
 	if ((pci_probe & PCI_BIOS_SORT) && !(pci_probe & PCI_NO_SORT))
 		pcibios_sort();
 #endif
-	pci_assign_unassigned_resources();
 	return 0;
 }
 
Index: linux-2.6.13.y/arch/i386/pci/i386.c
===================================================================
--- linux-2.6.13.y.orig/arch/i386/pci/i386.c
+++ linux-2.6.13.y/arch/i386/pci/i386.c
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
 
Index: linux-2.6.13.y/drivers/pci/setup-bus.c
===================================================================
--- linux-2.6.13.y.orig/drivers/pci/setup-bus.c
+++ linux-2.6.13.y/drivers/pci/setup-bus.c
@@ -40,7 +40,7 @@
  * FIXME: IO should be max 256 bytes.  However, since we may
  * have a P2P bridge below a cardbus bridge, we need 4K.
  */
-#define CARDBUS_IO_SIZE		(256)
+#define CARDBUS_IO_SIZE		(4*1024)
 #define CARDBUS_MEM_SIZE	(32*1024*1024)
 
 static void __devinit

--
