Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262755AbTJYS2z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 14:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262759AbTJYS2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 14:28:54 -0400
Received: from havoc.gtf.org ([63.247.75.124]:19598 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262755AbTJYS2t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 14:28:49 -0400
Date: Sat, 25 Oct 2003 14:27:05 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: ak@suse.de, linux-kernel@vger.kernel.org
Cc: len.brown@intel.com
Subject: [AMD64 2/3] Fix build broken due to ACPI changes
Message-ID: <20031025182705.GA12075@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


# --------------------------------------------
# 03/10/25	jgarzik@redhat.com	1.1352
# [AMD64] add acpi_pic_set_level_irq
# 
# ACPI guys broke the AMD64 build.  Adding this function fixes it.
# --------------------------------------------

diff -Nru a/arch/x86_64/kernel/acpi/boot.c b/arch/x86_64/kernel/acpi/boot.c
--- a/arch/x86_64/kernel/acpi/boot.c	Sat Oct 25 06:08:24 2003
+++ b/arch/x86_64/kernel/acpi/boot.c	Sat Oct 25 06:08:24 2003
@@ -226,30 +226,33 @@
 
 #endif /*CONFIG_X86_IO_APIC*/
 
-#ifdef CONFIG_HPET_TIMER
-static int __init
-acpi_parse_hpet (
-	unsigned long		phys_addr,
-	unsigned long		size)
-{
-	struct acpi_table_hpet *hpet_tbl;
-
-	hpet_tbl = __va(phys_addr);
+#ifdef	CONFIG_ACPI_BUS
+/*
+ * Set specified PIC IRQ to level triggered mode.
+ *
+ * Port 0x4d0-4d1 are ECLR1 and ECLR2, the Edge/Level Control Registers
+ * for the 8259 PIC.  bit[n] = 1 means irq[n] is Level, otherwise Edge.
+ * ECLR1 is IRQ's 0-7 (IRQ 0, 1, 2 must be 0)
+ * ECLR2 is IRQ's 8-15 (IRQ 8, 13 must be 0)
+ *
+ * As the BIOS should have done this for us,
+ * print a warning if the IRQ wasn't already set to level.
+ */
 
-	if (hpet_tbl->addr.space_id != ACPI_SPACE_MEM) {
-		printk(KERN_WARNING "acpi: HPET timers must be located in memory.\n");
-		return -1;
+void acpi_pic_set_level_irq(unsigned int irq)
+{
+	unsigned char mask = 1 << (irq & 7);
+	unsigned int port = 0x4d0 + (irq >> 3);
+	unsigned char val = inb(port);
+
+	if (!(val & mask)) {
+		printk(KERN_WARNING PREFIX "IRQ %d was Edge Triggered, "
+			"setting to Level Triggerd\n", irq);
+		outb(val | mask, port);
 	}
+}
+#endif /* CONFIG_ACPI_BUS */
 
-	vxtime.hpet_address = hpet_tbl->addr.addrl |
-		((long) hpet_tbl->addr.addrh << 32);
-
-	printk(KERN_INFO "acpi: HPET id: %#x base: %#lx\n",
-	       hpet_tbl->id, vxtime.hpet_address);
-
-	return 0;
-} 
-#endif
 
 static unsigned long __init
 acpi_scan_rsdp (
@@ -272,6 +275,30 @@
 	return 0;
 }
 
+#ifdef CONFIG_HPET_TIMER
+static int __init
+acpi_parse_hpet (
+	unsigned long		phys_addr,
+	unsigned long		size)
+{
+	struct acpi_table_hpet *hpet_tbl;
+
+	hpet_tbl = __va(phys_addr);
+
+	if (hpet_tbl->addr.space_id != ACPI_SPACE_MEM) {
+		printk(KERN_WARNING "acpi: HPET timers must be located in memory.\n");
+		return -1;
+	}
+
+	vxtime.hpet_address = hpet_tbl->addr.addrl |
+		((long) hpet_tbl->addr.addrh << 32);
+
+	printk(KERN_INFO "acpi: HPET id: %#x base: %#lx\n",
+	       hpet_tbl->id, vxtime.hpet_address);
+
+	return 0;
+} 
+#endif
 
 unsigned long __init
 acpi_find_rsdp (void)
