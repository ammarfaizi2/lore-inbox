Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268756AbUI2RvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268756AbUI2RvY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 13:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268755AbUI2RvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 13:51:24 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:49061 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S268756AbUI2RvP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 13:51:15 -0400
Subject: [PATCH] better encapsulate eisa_set_level_irq()
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Len Brown <len.brown@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1096480261.26691.12.camel@eeyore>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 29 Sep 2004 11:51:01 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move the "only do this once" stuff from acpi_register_gsi() into
eisa_set_level().

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

diff -u -ur 2.6.9-rc2-mm4/arch/i386/kernel/acpi/boot.c pic/arch/i386/kernel/acpi/boot.c
--- 2.6.9-rc2-mm4/arch/i386/kernel/acpi/boot.c	2004-09-27 10:12:15.000000000 -0600
+++ pic/arch/i386/kernel/acpi/boot.c	2004-09-28 16:06:37.000000000 -0600
@@ -457,16 +457,10 @@
 	 * Make sure all (legacy) PCI IRQs are set as level-triggered.
 	 */
 	if (acpi_irq_model == ACPI_IRQ_MODEL_PIC) {
-		static u16 irq_mask;
 		extern void eisa_set_level_irq(unsigned int irq);
 
-		if (edge_level == ACPI_LEVEL_SENSITIVE) {
-			if ((gsi < 16) && !((1 << gsi) & irq_mask)) {
-				Dprintk(KERN_DEBUG PREFIX "Setting GSI %u as level-triggered\n", gsi);
-				irq_mask |= (1 << gsi);
+		if (edge_level == ACPI_LEVEL_SENSITIVE)
 				eisa_set_level_irq(gsi);
-			}
-		}
 	}
 #endif
 
diff -u -ur 2.6.9-rc2-mm4/arch/i386/pci/irq.c pic/arch/i386/pci/irq.c
--- 2.6.9-rc2-mm4/arch/i386/pci/irq.c	2004-09-27 10:12:15.000000000 -0600
+++ pic/arch/i386/pci/irq.c	2004-09-29 08:39:37.000000000 -0600
@@ -127,8 +127,15 @@
 {
 	unsigned char mask = 1 << (irq & 7);
 	unsigned int port = 0x4d0 + (irq >> 3);
-	unsigned char val = inb(port);
+	unsigned char val;
+	static u16 eisa_irq_mask;
 
+	if (irq >= 16 || (1 << irq) & eisa_irq_mask)
+		return;
+
+	eisa_irq_mask |= (1 << irq);
+	printk("PCI: setting IRQ %u as level-triggered\n", irq);
+	val = inb(port);
 	if (!(val & mask)) {
 		DBG(" -> edge");
 		outb(val | mask, port);


