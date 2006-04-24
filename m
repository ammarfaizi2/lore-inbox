Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbWDXVWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbWDXVWu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 17:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbWDXVWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 17:22:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37289 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751262AbWDXVWu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 17:22:50 -0400
Date: Mon, 24 Apr 2006 14:22:43 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [RFC 1/2] irq: record edge-level setting
Message-ID: <20060424142243.519d61f1@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0604241354200.3701@g5.osdl.org>
References: <20060424114105.113eecac@localhost.localdomain>
	<Pine.LNX.4.64.0604241156340.3701@g5.osdl.org>
	<Pine.LNX.4.64.0604241203130.3701@g5.osdl.org>
	<1145908402.3116.63.camel@laptopd505.fenrus.org>
	<20060424201646.GA23517@devserv.devel.redhat.com>
	<1145911417.3116.69.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.64.0604241354200.3701@g5.osdl.org>
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Record the level vs edge-triggered status of IRQ to allow for error checks later.

Note: this is only done fir i386/x86_64.

--- irq.orig/arch/i386/kernel/i8259.c
+++ irq/arch/i386/kernel/i8259.c
@@ -128,11 +128,22 @@ int i8259A_irq_pending(unsigned int irq)
 	return ret;
 }
 
+static int i8259A_trigger(unsigned int irq)
+{
+	if (irq & 8)
+		return inb(0x4d1) & (1<< (irq-8));
+	else
+		return inb(0x4d0) & (1<<irq);
+}
+
+
 void make_8259A_irq(unsigned int irq)
 {
 	disable_irq_nosync(irq);
 	io_apic_irqs &= ~(1<<irq);
 	irq_desc[irq].handler = &i8259A_irq_type;
+	if (i8259A_trigger(irq))
+		irq_desc[irq].status |= IRQ_LEVEL;
 	enable_irq(irq);
 }
 
--- irq.orig/arch/i386/kernel/io_apic.c
+++ irq/arch/i386/kernel/io_apic.c
@@ -1186,17 +1186,23 @@ static inline void ioapic_register_intr(
 {
 	if (use_pci_vector() && !platform_legacy_irq(irq)) {
 		if ((trigger == IOAPIC_AUTO && IO_APIC_irq_trigger(irq)) ||
-				trigger == IOAPIC_LEVEL)
+		    trigger == IOAPIC_LEVEL) {
 			irq_desc[vector].handler = &ioapic_level_type;
-		else
+			irq_desc[vector].status |= IRQ_LEVEL;
+		} else {
 			irq_desc[vector].handler = &ioapic_edge_type;
+			irq_desc[vector].status &= ~IRQ_LEVEL;
+		}
 		set_intr_gate(vector, interrupt[vector]);
 	} else	{
 		if ((trigger == IOAPIC_AUTO && IO_APIC_irq_trigger(irq)) ||
-				trigger == IOAPIC_LEVEL)
+		    trigger == IOAPIC_LEVEL) {
 			irq_desc[irq].handler = &ioapic_level_type;
-		else
+			irq_desc[irq].status |= IRQ_LEVEL;
+		} else {
 			irq_desc[irq].handler = &ioapic_edge_type;
+			irq_desc[irq].status &= ~IRQ_LEVEL;
+		}
 		set_intr_gate(vector, interrupt[irq]);
 	}
 }
--- irq.orig/arch/x86_64/kernel/i8259.c
+++ irq/arch/x86_64/kernel/i8259.c
@@ -231,11 +231,22 @@ int i8259A_irq_pending(unsigned int irq)
 	return ret;
 }
 
+static int i8259A_trigger(unsigned int irq)
+{
+	if (irq & 8)
+		return inb(0x4d1) & (1<< (irq-8));
+	else
+		return inb(0x4d0) & (1<<irq);
+}
+
+
 void make_8259A_irq(unsigned int irq)
 {
 	disable_irq_nosync(irq);
 	io_apic_irqs &= ~(1<<irq);
 	irq_desc[irq].handler = &i8259A_irq_type;
+	if (i8259A_trigger(irq))
+		irq_desc[irq].status |= IRQ_LEVEL;
 	enable_irq(irq);
 }
 
--- irq.orig/arch/x86_64/kernel/io_apic.c
+++ irq/arch/x86_64/kernel/io_apic.c
@@ -848,17 +848,23 @@ static inline void ioapic_register_intr(
 {
 	if (use_pci_vector() && !platform_legacy_irq(irq)) {
 		if ((trigger == IOAPIC_AUTO && IO_APIC_irq_trigger(irq)) ||
-				trigger == IOAPIC_LEVEL)
+		    trigger == IOAPIC_LEVEL) {
 			irq_desc[vector].handler = &ioapic_level_type;
-		else
+			irq_desc[vector].status |= IRQ_LEVEL;
+		} else {
 			irq_desc[vector].handler = &ioapic_edge_type;
+			irq_desc[vector].status &= ~IRQ_LEVEL;
+		}
 		set_intr_gate(vector, interrupt[vector]);
 	} else	{
 		if ((trigger == IOAPIC_AUTO && IO_APIC_irq_trigger(irq)) ||
-				trigger == IOAPIC_LEVEL)
+		    trigger == IOAPIC_LEVEL) {
 			irq_desc[irq].handler = &ioapic_level_type;
-		else
+			irq_desc[irq].status |= IRQ_LEVEL;
+		} else {
 			irq_desc[irq].handler = &ioapic_edge_type;
+			irq_desc[irq].status &= ~IRQ_LEVEL;
+		}
 		set_intr_gate(vector, interrupt[irq]);
 	}
 }
