Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269099AbUINBux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269099AbUINBux (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 21:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269103AbUINBuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 21:50:52 -0400
Received: from c-24-10-253-213.client.comcast.net ([24.10.253.213]:65489 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269099AbUINBur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 21:50:47 -0400
Message-Id: <200409140151.i8E1p03W023713@localhost.localdomain>
Subject: [patch 1/2] Incorrect PCI interrupt assignment on ES7000 for platform GSI
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Natalie.Protasevich@unisys.com
From: Natalie.Protasevich@unisys.com
Date: Mon, 13 Sep 2004 19:50:59 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resending the patches for PCI interrupt assignment problem after proper formatting (sorry, Andrew!)

In arch/i386/kernel/acpi/boot.c, platform GSI does not propagate back from mp_register_gsi() to a calling routine which results in IRQ to be set for wrong GSI. This causes most of the PCI slots on the first PCI module to fail.  This patch fixes the problem by returning new GSI back to acpi_register_gsi().

Signed-off-by: Natalie Protasevich <Natalie.Protasevich@xxxxxxxxxx>

---

 linux-root/arch/i386/kernel/acpi/boot.c |    5 +++--
 linux-root/arch/i386/kernel/mpparse.c   |   11 ++++++-----
 linux-root/include/asm-i386/mpspec.h    |    2 +-
 3 files changed, 10 insertions(+), 8 deletions(-)

diff -puN arch/i386/kernel/acpi/boot.c~mypatch arch/i386/kernel/acpi/boot.c
--- linux/arch/i386/kernel/acpi/boot.c~mypatch	2004-09-13 14:08:21.192015024 -0600
+++ linux-root/arch/i386/kernel/acpi/boot.c	2004-09-13 14:10:51.457171248 -0600
@@ -442,6 +442,7 @@ int acpi_gsi_to_irq(u32 gsi, unsigned in
 unsigned int acpi_register_gsi(u32 gsi, int edge_level, int active_high_low)
 {
 	unsigned int irq;
+	unsigned int plat_gsi;
 
 #ifdef CONFIG_PCI
 	/*
@@ -463,10 +464,10 @@ unsigned int acpi_register_gsi(u32 gsi, 
 
 #ifdef CONFIG_X86_IO_APIC
 	if (acpi_irq_model == ACPI_IRQ_MODEL_IOAPIC) {
-		mp_register_gsi(gsi, edge_level, active_high_low);
+		plat_gsi = mp_register_gsi(gsi, edge_level, active_high_low);
 	}
 #endif
-	acpi_gsi_to_irq(gsi, &irq);
+	acpi_gsi_to_irq(plat_gsi, &irq);
 	return irq;
 }
 EXPORT_SYMBOL(acpi_register_gsi);
diff -puN include/asm-i386/mpspec.h~mypatch include/asm-i386/mpspec.h
--- linux/include/asm-i386/mpspec.h~mypatch	2004-09-13 14:08:21.249006360 -0600
+++ linux-root/include/asm-i386/mpspec.h	2004-09-13 14:09:52.381152168 -0600
@@ -33,7 +33,7 @@ extern void mp_register_lapic_address (u
 extern void mp_register_ioapic (u8 id, u32 address, u32 gsi_base);
 extern void mp_override_legacy_irq (u8 bus_irq, u8 polarity, u8 trigger, u32 gsi);
 extern void mp_config_acpi_legacy_irqs (void);
-extern void mp_register_gsi (u32 gsi, int edge_level, int active_high_low);
+extern int mp_register_gsi (u32 gsi, int edge_level, int active_high_low);
 #endif /*CONFIG_ACPI_BOOT*/
 
 #define PHYSID_ARRAY_SIZE	BITS_TO_LONGS(MAX_APICS)
diff -puN arch/i386/kernel/mpparse.c~mypatch arch/i386/kernel/mpparse.c
--- linux/arch/i386/kernel/mpparse.c~mypatch	2004-09-13 14:08:21.311996784 -0600
+++ linux-root/arch/i386/kernel/mpparse.c	2004-09-13 14:12:00.562665616 -0600
@@ -1051,7 +1051,7 @@ void __init mp_config_acpi_legacy_irqs (
 
 int (*platform_rename_gsi)(int ioapic, int gsi);
 
-void mp_register_gsi (u32 gsi, int edge_level, int active_high_low)
+int mp_register_gsi (u32 gsi, int edge_level, int active_high_low)
 {
 	int			ioapic = -1;
 	int			ioapic_pin = 0;
@@ -1060,13 +1060,13 @@ void mp_register_gsi (u32 gsi, int edge_
 #ifdef CONFIG_ACPI_BUS
 	/* Don't set up the ACPI SCI because it's already set up */
 	if (acpi_fadt.sci_int == gsi)
-		return;
+		return gsi;
 #endif
 
 	ioapic = mp_find_ioapic(gsi);
 	if (ioapic < 0) {
 		printk(KERN_WARNING "No IOAPIC for GSI %u\n", gsi);
-		return;
+		return gsi;
 	}
 
 	ioapic_pin = gsi - mp_ioapic_routing[ioapic].gsi_base;
@@ -1085,12 +1085,12 @@ void mp_register_gsi (u32 gsi, int edge_
 		printk(KERN_ERR "Invalid reference to IOAPIC pin "
 			"%d-%d\n", mp_ioapic_routing[ioapic].apic_id, 
 			ioapic_pin);
-		return;
+		return gsi;
 	}
 	if ((1<<bit) & mp_ioapic_routing[ioapic].pin_programmed[idx]) {
 		Dprintk(KERN_DEBUG "Pin %d-%d already programmed\n",
 			mp_ioapic_routing[ioapic].apic_id, ioapic_pin);
-		return;
+		return gsi;
 	}
 
 	mp_ioapic_routing[ioapic].pin_programmed[idx] |= (1<<bit);
@@ -1098,6 +1098,7 @@ void mp_register_gsi (u32 gsi, int edge_
 	io_apic_set_pci_routing(ioapic, ioapic_pin, gsi,
 		    edge_level == ACPI_EDGE_SENSITIVE ? 0 : 1,
 		    active_high_low == ACPI_ACTIVE_HIGH ? 0 : 1);
+	return gsi;
 }
 
 #endif /*CONFIG_X86_IO_APIC && (CONFIG_ACPI_INTERPRETER || CONFIG_ACPI_BOOT)*/
_
