Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264727AbUEYMvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264727AbUEYMvq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 08:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264733AbUEYMvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 08:51:46 -0400
Received: from gprs214-251.eurotel.cz ([160.218.214.251]:37505 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S264727AbUEYMvm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 08:51:42 -0400
Date: Tue, 25 May 2004 14:49:38 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, mingo@redhat.com,
       Andrew Morton <akpm@zip.com.au>
Subject: Cleanups for APIC
Message-ID: <20040525124937.GA13347@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This cleans up io_apic.c a bit -- I do not really like 4 copies of
same code. Does it look okay to apply?

								Pavel

--- tmp/linux/arch/i386/kernel/io_apic.c	2004-05-20 23:08:04.000000000 +0200
+++ linux/arch/i386/kernel/io_apic.c	2004-05-20 23:10:50.000000000 +0200
@@ -41,8 +42,6 @@
 
 #include "io_ports.h"
 
-#undef APIC_LOCKUP_DEBUG
-
 #define APIC_LOCKUP_DEBUG
 
 static spinlock_t ioapic_lock = SPIN_LOCK_UNLOCKED;
@@ -127,8 +126,7 @@
 	}
 }
 
-/* mask = 1 */
-static void __mask_IO_APIC_irq (unsigned int irq)
+static inline void __modify_IO_APIC_irq (unsigned int irq, unsigned long enable, unsigned long disable)
 {
 	int pin;
 	struct irq_pin_list *entry = irq_2_pin + irq;
@@ -139,71 +137,39 @@
 		if (pin == -1)
 			break;
 		reg = io_apic_read(entry->apic, 0x10 + pin*2);
-		io_apic_modify(entry->apic, 0x10 + pin*2, reg |= 0x00010000);
+		reg &= ~disable;
+		reg |= enable;
+		io_apic_modify(entry->apic, 0x10 + pin*2, reg);
 		if (!entry->next)
 			break;
 		entry = irq_2_pin + entry->next;
 	}
-	io_apic_sync(entry->apic);
 }
 
-/* mask = 0 */
-static void __unmask_IO_APIC_irq (unsigned int irq)
+/* mask = 1 */
+static void __mask_IO_APIC_irq (unsigned int irq)
 {
-	int pin;
 	struct irq_pin_list *entry = irq_2_pin + irq;
+	__modify_IO_APIC_irq(irq, 0x00010000, 0);
+	io_apic_sync(entry->apic);	/* Is it needed? Or do others need it too? */
+}
 
-	for (;;) {
-		unsigned int reg;
-		pin = entry->pin;
-		if (pin == -1)
-			break;
-		reg = io_apic_read(entry->apic, 0x10 + pin*2);
-		io_apic_modify(entry->apic, 0x10 + pin*2, reg &= 0xfffeffff);
-		if (!entry->next)
-			break;
-		entry = irq_2_pin + entry->next;
-	}
+/* mask = 0 */
+static void __unmask_IO_APIC_irq (unsigned int irq)
+{
+	__modify_IO_APIC_irq(irq, 0, 0x00010000);
 }
 
 /* mask = 1, trigger = 0 */
 static void __mask_and_edge_IO_APIC_irq (unsigned int irq)
 {
-	int pin;
-	struct irq_pin_list *entry = irq_2_pin + irq;
-
-	for (;;) {
-		unsigned int reg;
-		pin = entry->pin;
-		if (pin == -1)
-			break;
-		reg = io_apic_read(entry->apic, 0x10 + pin*2);
-		reg = (reg & 0xffff7fff) | 0x00010000;
-		io_apic_modify(entry->apic, 0x10 + pin*2, reg);
-		if (!entry->next)
-			break;
-		entry = irq_2_pin + entry->next;
-	}
+	__modify_IO_APIC_irq(irq, 0x00010000, 0x00008000);
 }
 
 /* mask = 0, trigger = 1 */
 static void __unmask_and_level_IO_APIC_irq (unsigned int irq)
 {
-	int pin;
-	struct irq_pin_list *entry = irq_2_pin + irq;
-
-	for (;;) {
-		unsigned int reg;
-		pin = entry->pin;
-		if (pin == -1)
-			break;
-		reg = io_apic_read(entry->apic, 0x10 + pin*2);
-		reg = (reg & 0xfffeffff) | 0x00008000;
-		io_apic_modify(entry->apic, 0x10 + pin*2, reg);
-		if (!entry->next)
-			break;
-		entry = irq_2_pin + entry->next;
-	}
+	__modify_IO_APIC_irq(irq, 0x00008000, 0x00010000);
 }
 
 static void mask_IO_APIC_irq (unsigned int irq)

-- 
934a471f20d6580d5aad759bf0d97ddc
