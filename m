Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262686AbUKLXZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262686AbUKLXZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbUKLXYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:24:45 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:21891 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262686AbUKLXWm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:22:42 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.10-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <11003017152930@kroah.com>
Date: Fri, 12 Nov 2004 15:21:55 -0800
Message-Id: <11003017151066@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2026.35.2, 2004/10/28 15:14:02-05:00, akpm@osdl.org

[PATCH] acpi: better encapsulate eisa_set_level_irq()

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

Move the "only do this once" stuff from acpi_register_gsi() into
eisa_set_level().

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/i386/kernel/acpi/boot.c |    8 +-------
 arch/i386/pci/irq.c          |    9 ++++++++-
 2 files changed, 9 insertions(+), 8 deletions(-)


diff -Nru a/arch/i386/kernel/acpi/boot.c b/arch/i386/kernel/acpi/boot.c
--- a/arch/i386/kernel/acpi/boot.c	2004-11-12 15:14:43 -08:00
+++ b/arch/i386/kernel/acpi/boot.c	2004-11-12 15:14:43 -08:00
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
 
diff -Nru a/arch/i386/pci/irq.c b/arch/i386/pci/irq.c
--- a/arch/i386/pci/irq.c	2004-11-12 15:14:43 -08:00
+++ b/arch/i386/pci/irq.c	2004-11-12 15:14:43 -08:00
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

