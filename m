Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262254AbVGKGGD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262254AbVGKGGD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 02:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbVGKGGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 02:06:03 -0400
Received: from c-24-10-253-213.hsd1.ut.comcast.net ([24.10.253.213]:12416 "EHLO
	linux.site") by vger.kernel.org with ESMTP id S262254AbVGKGGB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 02:06:01 -0400
Subject: [patch 1/2] Avoid wasting IRQs patch update (i386)
To: akpm@osdl.org
Cc: ak@suse.de, zwane@arm.linux.org.uk, len.brown@intel.com,
       bjorn.helgaas@hp.com, shaohua.li@intel.com,
       linux-kernel@vger.kernel.org, Natalie.Protasevich@unisys.com
From: Natalie.Protasevich@unisys.com
Date: Sun, 10 Jul 2005 04:00:30 -0700
Message-Id: <20050710110030.D20FD57969@linux.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch addresses a problem with ACPI SCI interrupt entry, which gets re-used, and the IRQ 
is assigned to another unrelated device. The patch corrects the code such that SCI IRQ is 
skipped and duplicate entry is avoided.
Second issue came up with VIA chipset, the problem was caused by original patch assigning IRQs 
starting 16 and up. The VIA chipset uses 4-bit IRQ register for internal interrupt routing, and 
therefore cannot handle IRQ numbers assigned to its devices. The patch corrects this problem 
by allowing PCI IRQs below 16. 

Signed-off by: Natalie Protasevich  <Natalie.Protasevich@unisys.com>

---


diff -puN arch/i386/kernel/mpparse.c~irq-pack-i386-update arch/i386/kernel/mpparse.c
--- linux-2.6.13-rc2/arch/i386/kernel/mpparse.c~irq-pack-i386-update	2005-07-10 01:36:42.428041880 -0700
+++ linux-2.6.13-rc2-root/arch/i386/kernel/mpparse.c	2005-07-10 03:56:44.567722496 -0700
@@ -1116,7 +1116,15 @@ int mp_register_gsi (u32 gsi, int edge_l
 		 */
 		int irq = gsi;
 		if (gsi < MAX_GSI_NUM) {
-			gsi = pci_irq++;
+			if (gsi > 15)
+				gsi = pci_irq++;
+#ifdef CONFIG_ACPI_BUS
+			/*
+			 * Don't assign IRQ used by ACPI SCI
+			 */
+			if (gsi == acpi_fadt.sci_int)
+				gsi = pci_irq++;
+#endif
 			gsi_to_irq[irq] = gsi;
 		} else {
 			printk(KERN_ERR "GSI %u is too high\n", gsi);
_
