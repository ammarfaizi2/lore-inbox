Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbWFXATU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbWFXATU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 20:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbWFXATU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 20:19:20 -0400
Received: from cantor.suse.de ([195.135.220.2]:15503 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932110AbWFXATS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 20:19:18 -0400
Date: Sat, 24 Jun 2006 02:19:16 +0200
From: "Andi Kleen" <ak@suse.de>
To: torvalds@osdl.org
Cc: discuss@x86-64.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       jbeulich@novell.com
Subject: [PATCH] [16/82] i386/x86-64: simplify ioapic_register_intr()
Message-ID: <449C8504.mailCVE1AFQPQ@suse.de>
User-Agent: nail 10.6 11/15/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Jan Beulich" <jbeulich@novell.com>
Simplify (remove duplication of) code in ioapic_register_intr().

Signed-off-by: Jan Beulich <jbeulich@novell.com>
Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/io_apic.c   |   23 ++++++++---------------
 arch/x86_64/kernel/io_apic.c |   23 ++++++++---------------
 2 files changed, 16 insertions(+), 30 deletions(-)

Index: linux/arch/i386/kernel/io_apic.c
===================================================================
--- linux.orig/arch/i386/kernel/io_apic.c
+++ linux/arch/i386/kernel/io_apic.c
@@ -1205,21 +1205,14 @@ static struct hw_interrupt_type ioapic_e
 
 static inline void ioapic_register_intr(int irq, int vector, unsigned long trigger)
 {
-	if (use_pci_vector() && !platform_legacy_irq(irq)) {
-		if ((trigger == IOAPIC_AUTO && IO_APIC_irq_trigger(irq)) ||
-				trigger == IOAPIC_LEVEL)
-			irq_desc[vector].handler = &ioapic_level_type;
-		else
-			irq_desc[vector].handler = &ioapic_edge_type;
-		set_intr_gate(vector, interrupt[vector]);
-	} else	{
-		if ((trigger == IOAPIC_AUTO && IO_APIC_irq_trigger(irq)) ||
-				trigger == IOAPIC_LEVEL)
-			irq_desc[irq].handler = &ioapic_level_type;
-		else
-			irq_desc[irq].handler = &ioapic_edge_type;
-		set_intr_gate(vector, interrupt[irq]);
-	}
+	unsigned idx = use_pci_vector() && !platform_legacy_irq(irq) ? vector : irq;
+
+	if ((trigger == IOAPIC_AUTO && IO_APIC_irq_trigger(irq)) ||
+			trigger == IOAPIC_LEVEL)
+		irq_desc[idx].handler = &ioapic_level_type;
+	else
+		irq_desc[idx].handler = &ioapic_edge_type;
+	set_intr_gate(vector, interrupt[idx]);
 }
 
 static void __init setup_IO_APIC_irqs(void)
Index: linux/arch/x86_64/kernel/io_apic.c
===================================================================
--- linux.orig/arch/x86_64/kernel/io_apic.c
+++ linux/arch/x86_64/kernel/io_apic.c
@@ -876,21 +876,14 @@ static struct hw_interrupt_type ioapic_e
 
 static inline void ioapic_register_intr(int irq, int vector, unsigned long trigger)
 {
-	if (use_pci_vector() && !platform_legacy_irq(irq)) {
-		if ((trigger == IOAPIC_AUTO && IO_APIC_irq_trigger(irq)) ||
-				trigger == IOAPIC_LEVEL)
-			irq_desc[vector].handler = &ioapic_level_type;
-		else
-			irq_desc[vector].handler = &ioapic_edge_type;
-		set_intr_gate(vector, interrupt[vector]);
-	} else	{
-		if ((trigger == IOAPIC_AUTO && IO_APIC_irq_trigger(irq)) ||
-				trigger == IOAPIC_LEVEL)
-			irq_desc[irq].handler = &ioapic_level_type;
-		else
-			irq_desc[irq].handler = &ioapic_edge_type;
-		set_intr_gate(vector, interrupt[irq]);
-	}
+	unsigned idx = use_pci_vector() && !platform_legacy_irq(irq) ? vector : irq;
+
+	if ((trigger == IOAPIC_AUTO && IO_APIC_irq_trigger(irq)) ||
+			trigger == IOAPIC_LEVEL)
+		irq_desc[idx].handler = &ioapic_level_type;
+	else
+		irq_desc[idx].handler = &ioapic_edge_type;
+	set_intr_gate(vector, interrupt[idx]);
 }
 
 static void __init setup_IO_APIC_irqs(void)
