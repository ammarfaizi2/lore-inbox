Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262976AbVDBARI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262976AbVDBARI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 19:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262978AbVDBAOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 19:14:06 -0500
Received: from mail.kroah.org ([69.55.234.183]:46300 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262957AbVDAXsV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 18:48:21 -0500
Cc: akpm@osdl.org
Subject: [PATCH] PCI: handle multiple video cards on the same bus
In-Reply-To: <11123992732759@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 1 Apr 2005 15:47:54 -0800
Message-Id: <1112399274112@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2181.16.22, 2005/03/28 15:10:57-08:00, akpm@osdl.org

[PATCH] PCI: handle multiple video cards on the same bus

From: Jon Smirl <jonsmirl@gmail.com>

When detecting the boot video device, allow for the case of multiple
cards on the same bus. Check each candidate to make sure that the card
is active.

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 arch/i386/pci/fixup.c |   20 +++++++++++++-------
 1 files changed, 13 insertions(+), 7 deletions(-)


diff -Nru a/arch/i386/pci/fixup.c b/arch/i386/pci/fixup.c
--- a/arch/i386/pci/fixup.c	2005-04-01 15:32:11 -08:00
+++ b/arch/i386/pci/fixup.c	2005-04-01 15:32:11 -08:00
@@ -343,7 +343,7 @@
 /*
  * Fixup to mark boot BIOS video selected by BIOS before it changes
  *
- * From information provided by "Jon Smirl" <jonsmirl@yahoo.com>
+ * From information provided by "Jon Smirl" <jonsmirl@gmail.com>
  *
  * The standard boot ROM sequence for an x86 machine uses the BIOS
  * to select an initial video card for boot display. This boot video 
@@ -354,12 +354,13 @@
  * See pci_map_rom() for use of this flag. IORESOURCE_ROM_SHADOW
  * is marked here since the boot video device will be the only enabled
  * video device at this point.
- *
- */static void __devinit pci_fixup_video(struct pci_dev *pdev)
+ */
+
+static void __devinit pci_fixup_video(struct pci_dev *pdev)
 {
 	struct pci_dev *bridge;
 	struct pci_bus *bus;
-	u16 l;
+	u16 config;
 
 	if ((pdev->class >> 8) != PCI_CLASS_DISPLAY_VGA)
 		return;
@@ -369,12 +370,17 @@
 	while (bus) {
 		bridge = bus->self;
 		if (bridge) {
-			pci_read_config_word(bridge, PCI_BRIDGE_CONTROL, &l);
-			if (!(l & PCI_BRIDGE_CTL_VGA))
+			pci_read_config_word(bridge, PCI_BRIDGE_CONTROL,
+						&config);
+			if (!(config & PCI_BRIDGE_CTL_VGA))
 				return;
 		}
 		bus = bus->parent;
 	}
-	pdev->resource[PCI_ROM_RESOURCE].flags |= IORESOURCE_ROM_SHADOW;
+	pci_read_config_word(pdev, PCI_COMMAND, &config);
+	if (config & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) {
+		pdev->resource[PCI_ROM_RESOURCE].flags |= IORESOURCE_ROM_SHADOW;
+		printk(KERN_DEBUG "Boot video device is %s\n", pci_name(pdev));
+	}
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pci_fixup_video);

