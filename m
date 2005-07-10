Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262276AbVGKGHC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262276AbVGKGHC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 02:07:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262277AbVGKGHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 02:07:01 -0400
Received: from c-24-10-253-213.hsd1.ut.comcast.net ([24.10.253.213]:13184 "EHLO
	linux.site") by vger.kernel.org with ESMTP id S262259AbVGKGGM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 02:06:12 -0400
Subject: [patch 2/2] Avoid wasting IRQs patch update (x86_64)
To: akpm@osdl.org
Cc: ak@suse.de, zwane@arm.linux.org.uk, len.brown@intel.com,
       bjorn.helgaas@hp.com, shaohua.li@intel.com,
       linux-kernel@vger.kernel.org, Natalie.Protasevich@unisys.com
From: Natalie.Protasevich@unisys.com
Date: Sun, 10 Jul 2005 04:00:32 -0700
Message-Id: <20050710110032.B7BFF5796B@linux.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch adds boundary check for the MAX_GSI_NUM.
Same as the update for i386, the patch addresses a problem with ACPI SCI IRQ. 
The patch corrects the code such that SCI IRQ is skipped and duplicate entry is avoided.
The VIA chipset uses 4-bit IRQ register for internal interrupt routing, and therefore 
cannot handle IRQ numbers assigned to its devices. The patch corrects this problem
by allowing PCI IRQs below 16.

Signed-off by: Natalie Protasevich  <Natalie.Protasevich@unisys.com>

---


diff -puN arch/x86_64/kernel/mpparse.c~irq-pack-x86_64-update arch/x86_64/kernel/mpparse.c
--- linux-2.6.13-rc2/arch/x86_64/kernel/mpparse.c~irq-pack-x86_64-update	2005-07-10 01:36:23.628899784 -0700
+++ linux-2.6.13-rc2-root/arch/x86_64/kernel/mpparse.c	2005-07-10 01:36:23.641897808 -0700
@@ -965,8 +965,21 @@ int mp_register_gsi(u32 gsi, int edge_le
 		 * due to unused I/O APIC pins.
 		 */
 		int irq = gsi;
-		gsi = pci_irq++;
-		gsi_to_irq[irq] = gsi;
+		if (gsi < MAX_GSI_NUM) {
+			if (gsi > 15)
+				gsi = pci_irq++;
+#ifdef CONFIG_ACPI_BUS
+			/*
+			 * Don't assign IRQ used by ACPI SCI
+			 */
+			if (gsi == acpi_fadt.sci_int)
+				gsi = pci_irq++;
+#endif
+			gsi_to_irq[irq] = gsi;
+		} else {
+			printk(KERN_ERR "GSI %u is too high\n", gsi);
+			return gsi;
+		}
 	}
 
 	io_apic_set_pci_routing(ioapic, ioapic_pin, gsi,
_
