Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262938AbVDBAIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262938AbVDBAIK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 19:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262815AbVDBAG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 19:06:59 -0500
Received: from mail.kroah.org ([69.55.234.183]:35036 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262938AbVDAXsP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 18:48:15 -0500
Cc: akpm@osdl.org
Subject: [PATCH] sort-out-pci_rom_address_enable-vs-ioresource_rom_enable.patch
In-Reply-To: <1112399272178@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 1 Apr 2005 15:47:52 -0800
Message-Id: <11123992722697@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2181.16.15, 2005/03/17 14:49:28-08:00, akpm@osdl.org

[PATCH] sort-out-pci_rom_address_enable-vs-ioresource_rom_enable.patch

From: Jon Smirl <jonsmirl@gmail.com>

This sorts out the usage of PCI_ROM_ADDRESS_ENABLE vs
IORESOURCE_ROM_ENABLE.  PCI_ROM_ADDRESS_ENABLE is for actually manipulating
the ROM's PCI config space.  IORESOURCE_ROM_ENABLE is for tracking the
IORESOURCE that the ROM is enabled.  Both are defined to 1 so code
shouldn't change.

Just to remind people, there are new PCI routines for enable/disable ROMs
so please call them instead of directly coding access in device drivers.
There are ten or so drivers that need to be converted to the new API.

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 arch/frv/mb93090-mb00/pci-frv.c    |    6 +++---
 arch/i386/pci/i386.c               |    4 ++--
 arch/mips/pmc-sierra/yosemite/ht.c |    2 +-
 arch/ppc/kernel/pci.c              |    4 ++--
 arch/sh/drivers/pci/pci.c          |    2 +-
 arch/sh64/kernel/pcibios.c         |    2 +-
 arch/sparc64/kernel/pci_psycho.c   |    2 +-
 arch/sparc64/kernel/pci_sabre.c    |    2 +-
 arch/sparc64/kernel/pci_schizo.c   |    2 +-
 drivers/mtd/maps/pci.c             |    6 +++---
 10 files changed, 16 insertions(+), 16 deletions(-)


diff -Nru a/arch/frv/mb93090-mb00/pci-frv.c b/arch/frv/mb93090-mb00/pci-frv.c
--- a/arch/frv/mb93090-mb00/pci-frv.c	2005-04-01 15:35:02 -08:00
+++ b/arch/frv/mb93090-mb00/pci-frv.c	2005-04-01 15:35:02 -08:00
@@ -31,7 +31,7 @@
 	if (resource < 6) {
 		reg = PCI_BASE_ADDRESS_0 + 4*resource;
 	} else if (resource == PCI_ROM_RESOURCE) {
-		res->flags |= PCI_ROM_ADDRESS_ENABLE;
+		res->flags |= IORESOURCE_ROM_ENABLE;
 		new |= PCI_ROM_ADDRESS_ENABLE;
 		reg = dev->rom_base_reg;
 	} else {
@@ -170,11 +170,11 @@
 		}
 		if (!pass) {
 			r = &dev->resource[PCI_ROM_RESOURCE];
-			if (r->flags & PCI_ROM_ADDRESS_ENABLE) {
+			if (r->flags & IORESOURCE_ROM_ENABLE) {
 				/* Turn the ROM off, leave the resource region, but keep it unregistered. */
 				u32 reg;
 				DBG("PCI: Switching off ROM of %s\n", pci_name(dev));
-				r->flags &= ~PCI_ROM_ADDRESS_ENABLE;
+				r->flags &= ~IORESOURCE_ROM_ENABLE;
 				pci_read_config_dword(dev, dev->rom_base_reg, &reg);
 				pci_write_config_dword(dev, dev->rom_base_reg, reg & ~PCI_ROM_ADDRESS_ENABLE);
 			}
diff -Nru a/arch/i386/pci/i386.c b/arch/i386/pci/i386.c
--- a/arch/i386/pci/i386.c	2005-04-01 15:35:02 -08:00
+++ b/arch/i386/pci/i386.c	2005-04-01 15:35:02 -08:00
@@ -150,11 +150,11 @@
 		}
 		if (!pass) {
 			r = &dev->resource[PCI_ROM_RESOURCE];
-			if (r->flags & PCI_ROM_ADDRESS_ENABLE) {
+			if (r->flags & IORESOURCE_ROM_ENABLE) {
 				/* Turn the ROM off, leave the resource region, but keep it unregistered. */
 				u32 reg;
 				DBG("PCI: Switching off ROM of %s\n", pci_name(dev));
-				r->flags &= ~PCI_ROM_ADDRESS_ENABLE;
+				r->flags &= ~IORESOURCE_ROM_ENABLE;
 				pci_read_config_dword(dev, dev->rom_base_reg, &reg);
 				pci_write_config_dword(dev, dev->rom_base_reg, reg & ~PCI_ROM_ADDRESS_ENABLE);
 			}
diff -Nru a/arch/mips/pmc-sierra/yosemite/ht.c b/arch/mips/pmc-sierra/yosemite/ht.c
--- a/arch/mips/pmc-sierra/yosemite/ht.c	2005-04-01 15:35:02 -08:00
+++ b/arch/mips/pmc-sierra/yosemite/ht.c	2005-04-01 15:35:02 -08:00
@@ -361,7 +361,7 @@
         if (resource < 6) {
                 reg = PCI_BASE_ADDRESS_0 + 4 * resource;
         } else if (resource == PCI_ROM_RESOURCE) {
-                res->flags |= PCI_ROM_ADDRESS_ENABLE;
+		res->flags |= IORESOURCE_ROM_ENABLE;
                 reg = dev->rom_base_reg;
         } else {
                 /*
diff -Nru a/arch/ppc/kernel/pci.c b/arch/ppc/kernel/pci.c
--- a/arch/ppc/kernel/pci.c	2005-04-01 15:35:02 -08:00
+++ b/arch/ppc/kernel/pci.c	2005-04-01 15:35:02 -08:00
@@ -521,11 +521,11 @@
 		if (pass)
 			continue;
 		r = &dev->resource[PCI_ROM_RESOURCE];
-		if (r->flags & PCI_ROM_ADDRESS_ENABLE) {
+		if (r->flags & IORESOURCE_ROM_ENABLE) {
 			/* Turn the ROM off, leave the resource region, but keep it unregistered. */
 			u32 reg;
 			DBG("PCI: Switching off ROM of %s\n", pci_name(dev));
-			r->flags &= ~PCI_ROM_ADDRESS_ENABLE;
+			r->flags &= ~IORESOURCE_ROM_ENABLE;
 			pci_read_config_dword(dev, dev->rom_base_reg, &reg);
 			pci_write_config_dword(dev, dev->rom_base_reg,
 					       reg & ~PCI_ROM_ADDRESS_ENABLE);
diff -Nru a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
--- a/arch/sh/drivers/pci/pci.c	2005-04-01 15:35:02 -08:00
+++ b/arch/sh/drivers/pci/pci.c	2005-04-01 15:35:02 -08:00
@@ -57,7 +57,7 @@
 	if (resource < 6) {
 		reg = PCI_BASE_ADDRESS_0 + 4*resource;
 	} else if (resource == PCI_ROM_RESOURCE) {
-		res->flags |= PCI_ROM_ADDRESS_ENABLE;
+		res->flags |= IORESOURCE_ROM_ENABLE;
 		new |= PCI_ROM_ADDRESS_ENABLE;
 		reg = dev->rom_base_reg;
 	} else {
diff -Nru a/arch/sh64/kernel/pcibios.c b/arch/sh64/kernel/pcibios.c
--- a/arch/sh64/kernel/pcibios.c	2005-04-01 15:35:02 -08:00
+++ b/arch/sh64/kernel/pcibios.c	2005-04-01 15:35:02 -08:00
@@ -45,7 +45,7 @@
 	if (resource < 6) {
 		reg = PCI_BASE_ADDRESS_0 + 4*resource;
 	} else if (resource == PCI_ROM_RESOURCE) {
-		res->flags |= PCI_ROM_ADDRESS_ENABLE;
+		res->flags |= IORESOURCE_ROM_ENABLE;
 		new |= PCI_ROM_ADDRESS_ENABLE;
 		reg = dev->rom_base_reg;
 	} else {
diff -Nru a/arch/sparc64/kernel/pci_psycho.c b/arch/sparc64/kernel/pci_psycho.c
--- a/arch/sparc64/kernel/pci_psycho.c	2005-04-01 15:35:02 -08:00
+++ b/arch/sparc64/kernel/pci_psycho.c	2005-04-01 15:35:02 -08:00
@@ -1133,7 +1133,7 @@
 	       (((u32)(res->start - root->start)) & ~size));
 	if (resource == PCI_ROM_RESOURCE) {
 		reg |= PCI_ROM_ADDRESS_ENABLE;
-		res->flags |= PCI_ROM_ADDRESS_ENABLE;
+		res->flags |= IORESOURCE_ROM_ENABLE;
 	}
 	pci_write_config_dword(pdev, where, reg);
 
diff -Nru a/arch/sparc64/kernel/pci_sabre.c b/arch/sparc64/kernel/pci_sabre.c
--- a/arch/sparc64/kernel/pci_sabre.c	2005-04-01 15:35:02 -08:00
+++ b/arch/sparc64/kernel/pci_sabre.c	2005-04-01 15:35:02 -08:00
@@ -1100,7 +1100,7 @@
 	       (((u32)(res->start - base)) & ~size));
 	if (resource == PCI_ROM_RESOURCE) {
 		reg |= PCI_ROM_ADDRESS_ENABLE;
-		res->flags |= PCI_ROM_ADDRESS_ENABLE;
+		res->flags |= IORESOURCE_ROM_ENABLE;
 	}
 	pci_write_config_dword(pdev, where, reg);
 
diff -Nru a/arch/sparc64/kernel/pci_schizo.c b/arch/sparc64/kernel/pci_schizo.c
--- a/arch/sparc64/kernel/pci_schizo.c	2005-04-01 15:35:02 -08:00
+++ b/arch/sparc64/kernel/pci_schizo.c	2005-04-01 15:35:02 -08:00
@@ -1572,7 +1572,7 @@
 	       (((u32)(res->start - root->start)) & ~size));
 	if (resource == PCI_ROM_RESOURCE) {
 		reg |= PCI_ROM_ADDRESS_ENABLE;
-		res->flags |= PCI_ROM_ADDRESS_ENABLE;
+		res->flags |= IORESOURCE_ROM_ENABLE;
 	}
 	pci_write_config_dword(pdev, where, reg);
 
diff -Nru a/drivers/mtd/maps/pci.c b/drivers/mtd/maps/pci.c
--- a/drivers/mtd/maps/pci.c	2005-04-01 15:35:02 -08:00
+++ b/drivers/mtd/maps/pci.c	2005-04-01 15:35:02 -08:00
@@ -205,9 +205,9 @@
 		 * or simply enabling it?
 		 */
 		if (!(pci_resource_flags(dev, PCI_ROM_RESOURCE) &
-		     PCI_ROM_ADDRESS_ENABLE)) {
+				    IORESOURCE_ROM_ENABLE)) {
 		     	u32 val;
-			pci_resource_flags(dev, PCI_ROM_RESOURCE) |= PCI_ROM_ADDRESS_ENABLE;
+			pci_resource_flags(dev, PCI_ROM_RESOURCE) |= IORESOURCE_ROM_ENABLE;
 			pci_read_config_dword(dev, PCI_ROM_ADDRESS, &val);
 			val |= PCI_ROM_ADDRESS_ENABLE;
 			pci_write_config_dword(dev, PCI_ROM_ADDRESS, val);
@@ -241,7 +241,7 @@
 	/*
 	 * We need to undo the PCI BAR2/PCI ROM BAR address alteration.
 	 */
-	pci_resource_flags(dev, PCI_ROM_RESOURCE) &= ~PCI_ROM_ADDRESS_ENABLE;
+	pci_resource_flags(dev, PCI_ROM_RESOURCE) &= ~IORESOURCE_ROM_ENABLE;
 	pci_read_config_dword(dev, PCI_ROM_ADDRESS, &val);
 	val &= ~PCI_ROM_ADDRESS_ENABLE;
 	pci_write_config_dword(dev, PCI_ROM_ADDRESS, val);

