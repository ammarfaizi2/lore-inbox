Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964778AbWDZOJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbWDZOJb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 10:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbWDZOJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 10:09:31 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:41017
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932442AbWDZOJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 10:09:30 -0400
Message-Id: <444F9B65.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Wed, 26 Apr 2006 16:10:13 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andreas Kleen" <ak@suse.de>, <linux-kernel@vger.kernel.org>
Cc: <discuss@x86-64.org>
Subject: [PATCH] i386/x86-64: simplify ioapic_register_intr()
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify (remove duplication of) code in ioapic_register_intr().

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru /home/jbeulich/tmp/linux-2.6.17-rc2/arch/i386/kernel/io_apic.c
2.6.17-rc2-x86-ioapic_register_intr-simplify/arch/i386/kernel/io_apic.c
--- /home/jbeulich/tmp/linux-2.6.17-rc2/arch/i386/kernel/io_apic.c	2006-04-26 10:55:11.000000000 +0200
+++ 2.6.17-rc2-x86-ioapic_register_intr-simplify/arch/i386/kernel/io_apic.c	2006-04-25 15:38:32.000000000 +0200
@@ -1184,21 +1184,14 @@ static struct hw_interrupt_type ioapic_e
 
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
diff -Npru /home/jbeulich/tmp/linux-2.6.17-rc2/arch/x86_64/kernel/io_apic.c
2.6.17-rc2-x86-ioapic_register_intr-simplify/arch/x86_64/kernel/io_apic.c
--- /home/jbeulich/tmp/linux-2.6.17-rc2/arch/x86_64/kernel/io_apic.c	2006-04-26 10:55:24.000000000 +0200
+++ 2.6.17-rc2-x86-ioapic_register_intr-simplify/arch/x86_64/kernel/io_apic.c	2006-04-25 15:38:32.000000000 +0200
@@ -846,21 +846,14 @@ static struct hw_interrupt_type ioapic_e
 
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


