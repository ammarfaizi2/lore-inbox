Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261723AbVEVEAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbVEVEAY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 00:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbVEVEAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 00:00:24 -0400
Received: from c-24-10-253-213.hsd1.ut.comcast.net ([24.10.253.213]:2688 "EHLO
	linux.site") by vger.kernel.org with ESMTP id S261315AbVEVEAM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 00:00:12 -0400
Subject: [patch 1/1] Avoid wasting IRQs for PCI devices (i386)
To: akpm@osdl.org
Cc: ak@suse.de, zwane@arm.linux.org.uk, len.brown@intel.com,
       bjorn.helgaas@hp.com, linux-kernel@vger.kernel.org,
       Natalie.Protasevich@unisys.com
From: Natalie.Protasevich@unisys.com
Date: Sat, 21 May 2005 01:55:42 -0700
Message-Id: <20050521085543.489D62732C@linux.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have submitted the patch for x86_64, this is submission for i386.

<--snip-->

The patch changes the way IRQs are handed out to PCI devices. Currently, each I/O APIC pin gets associated 
with an IRQ, no matter if the pin is used or not. This imposes severe limitation on systems that have designs 
that employ many  I/O APICs, only utilizing couple lines of each, such as P64H2 chipset. It is used in ES7000, 
and currently, there is no way to boot the system with more that 9 I/O APICs. The simple change below allows 
to boot a system with say 64 (or more) I/O APICs, each providing 1 slot, which otherwise impossible because of 
the IRQ gaps created for unused lines on each I/O APIC. It does not resolve the problem with number of devices 
that exceeds number of possible IRQs, but eases up a tension for IRQs on any large system with potentually large 
number of devices.

Signed-off-by: Natalie Protasevich  <Natalie.Protasevich@unisys.com>
---


diff -puN arch/i386/kernel/mpparse.c~irq-pack-i386 arch/i386/kernel/mpparse.c
--- linux-2.6.12-rc4-mm2/arch/i386/kernel/mpparse.c~irq-pack-i386	2005-05-20 02:10:04.046408256 -0700
+++ linux-2.6.12-rc4-mm2-root/arch/i386/kernel/mpparse.c	2005-05-20 22:41:48.178272472 -0700
@@ -1056,11 +1056,20 @@ void __init mp_config_acpi_legacy_irqs (
 	}
 }
 
+#define MAX_GSI_NUM	4096
+
 int mp_register_gsi (u32 gsi, int edge_level, int active_high_low)
 {
 	int			ioapic = -1;
 	int			ioapic_pin = 0;
 	int			idx, bit = 0;
+	static int		pci_irq = 16;
+	/*
+	 * Mapping between Global System Interrups, which
+	 * represent all possible interrupts, and IRQs
+	 * assigned to actual devices.
+	 */
+	static int		gsi_to_irq[MAX_GSI_NUM];
 
 #ifdef CONFIG_ACPI_BUS
 	/* Don't set up the ACPI SCI because it's already set up */
@@ -1095,11 +1104,26 @@ int mp_register_gsi (u32 gsi, int edge_l
 	if ((1<<bit) & mp_ioapic_routing[ioapic].pin_programmed[idx]) {
 		Dprintk(KERN_DEBUG "Pin %d-%d already programmed\n",
 			mp_ioapic_routing[ioapic].apic_id, ioapic_pin);
-		return gsi;
+		return gsi_to_irq[gsi];
 	}
 
 	mp_ioapic_routing[ioapic].pin_programmed[idx] |= (1<<bit);
 
+	if (edge_level) {
+		/*
+		 * For PCI devices assign IRQs in order, avoiding gaps
+		 * due to unused I/O APIC pins.
+		 */
+		int irq = gsi;
+		if (gsi < MAX_GSI_NUM) {
+			gsi = pci_irq++;
+			gsi_to_irq[irq] = gsi;
+		} else {
+			printk(KERN_ERR "GSI %u is too high\n", gsi);
+			return gsi;
+		}
+	}
+
 	io_apic_set_pci_routing(ioapic, ioapic_pin, gsi,
 		    edge_level == ACPI_EDGE_SENSITIVE ? 0 : 1,
 		    active_high_low == ACPI_ACTIVE_HIGH ? 0 : 1);
_
