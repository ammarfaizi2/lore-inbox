Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263209AbVCKEEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263209AbVCKEEi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 23:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263171AbVCKECu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 23:02:50 -0500
Received: from rproxy.gmail.com ([64.233.170.198]:18579 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262763AbVCKDzn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 22:55:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=GbjCNurJrnwjfFt7N5wLIpseALSBstqNPBeDH6dIoZSde9A38rcIwBJxKEgltVOtbEJUMNgSeIVfn0A/GD5Bhd8Ix+BvxHe+cZlcGPwlA8EJ0tzGRpFifKXvye20MALlxeo4RiLhbJwoZOl/R1+/RqBMkxjx0NzvsrJdP/qwIkk=
Message-ID: <9e4733910503101955138dea1@mail.gmail.com>
Date: Thu, 10 Mar 2005 22:55:37 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] Make primary boot video device detection more robust
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When detecting the boot video device, allow for the case of multiple
cards on the same bus. Check each candidate to make sure that the card
is active.

Signed off by: Jon Smirl <jonsmirl@gmail.com>

-- 
Jon Smirl
jonsmirl@gmail.com


===== arch/i386/pci/fixup.c 1.24 vs edited =====
--- 1.24/arch/i386/pci/fixup.c	2005-01-11 19:42:41 -05:00
+++ edited/arch/i386/pci/fixup.c	2005-03-10 22:50:30 -05:00
@@ -343,7 +343,7 @@
 /*
  * Fixup to mark boot BIOS video selected by BIOS before it changes
  *
- * From information provided by "Jon Smirl" <jonsmirl@yahoo.com>
+ * From information provided by "Jon Smirl" <jonsmirl@gmail.com>
  *
  * The standard boot ROM sequence for an x86 machine uses the BIOS
  * to select an initial video card for boot display. This boot video 
@@ -355,11 +355,12 @@
  * is marked here since the boot video device will be the only enabled
  * video device at this point.
  *
- */static void __devinit pci_fixup_video(struct pci_dev *pdev)
+ */
+static void __devinit pci_fixup_video(struct pci_dev *pdev)
 {
 	struct pci_dev *bridge;
 	struct pci_bus *bus;
-	u16 l;
+	u16 config;
 
 	if ((pdev->class >> 8) != PCI_CLASS_DISPLAY_VGA)
 		return;
@@ -369,12 +370,16 @@
 	while (bus) {
 		bridge = bus->self;
 		if (bridge) {
-			pci_read_config_word(bridge, PCI_BRIDGE_CONTROL, &l);
-			if (!(l & PCI_BRIDGE_CTL_VGA))
+			pci_read_config_word(bridge, PCI_BRIDGE_CONTROL, &config);
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
