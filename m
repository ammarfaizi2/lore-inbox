Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263614AbUE0NPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263614AbUE0NPX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 09:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263134AbUE0NPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 09:15:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1926 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263614AbUE0NPI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 09:15:08 -0400
Date: Thu, 27 May 2004 09:15:00 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: Cleanups for APIC
In-Reply-To: <20040525124937.GA13347@elf.ucw.cz>
Message-ID: <Pine.LNX.4.58.0405270856120.28319@devserv.devel.redhat.com>
References: <20040525124937.GA13347@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 25 May 2004, Pavel Machek wrote:

> This cleans up io_apic.c a bit -- I do not really like 4 copies of same
> code. Does it look okay to apply?

yeah, agreed - i checked & test it, it's ok. I made a small modification
(see the patch below) to uninline the __modify_IO_APIC_irq() function -
shaving 0.5K off the kernel's size ...

(wrt. io_apic_sync(): i added it in 2.1.104 together with some other
changes - i dont this it's necessary anymore - the local APICs had
writearound erratas, but i dont remember this ever being necessary for
IO-APICs. I'll address this in another patch.)

	Ingo

From: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/arch/i386/kernel/io_apic.c.orig	
+++ linux/arch/i386/kernel/io_apic.c	
@@ -41,8 +41,6 @@
 
 #include "io_ports.h"
 
-#undef APIC_LOCKUP_DEBUG
-
 #define APIC_LOCKUP_DEBUG
 
 static spinlock_t ioapic_lock = SPIN_LOCK_UNLOCKED;
@@ -127,83 +125,50 @@ static void __init replace_pin_at_irq(un
 	}
 }
 
-/* mask = 1 */
-static void __mask_IO_APIC_irq (unsigned int irq)
+static void __modify_IO_APIC_irq (unsigned int irq, unsigned long enable, unsigned long disable)
 {
-	int pin;
 	struct irq_pin_list *entry = irq_2_pin + irq;
+	unsigned int pin, reg;
 
 	for (;;) {
-		unsigned int reg;
 		pin = entry->pin;
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
+}
+
+/* mask = 1 */
+static void __mask_IO_APIC_irq (unsigned int irq)
+{
+	struct irq_pin_list *entry = irq_2_pin + irq;
+	__modify_IO_APIC_irq(irq, 0x00010000, 0);
+	/* Is it needed? Or do others need it too? */
 	io_apic_sync(entry->apic);
 }
 
 /* mask = 0 */
 static void __unmask_IO_APIC_irq (unsigned int irq)
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
-		io_apic_modify(entry->apic, 0x10 + pin*2, reg &= 0xfffeffff);
-		if (!entry->next)
-			break;
-		entry = irq_2_pin + entry->next;
-	}
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
