Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266772AbTAKAwy>; Fri, 10 Jan 2003 19:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266844AbTAKAwy>; Fri, 10 Jan 2003 19:52:54 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:10984 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S266772AbTAKAwv>; Fri, 10 Jan 2003 19:52:51 -0500
Date: Fri, 10 Jan 2003 16:54:26 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@zip.com.au>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] remove cruel torture of macros and small furry animals in io-apic.c
Message-ID: <308730000.1042246466@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, sent to you because I figure it might appeal to you,
just based on a random gut feeling.

This removes the DO_ACTION stuff. The downside is that we add
some boring and repetive code. The upside is that it's simple,
and mere mortals can read it without screwing their brains into
a small piece of silly putty and bouncing it off the wall. 
I think that's more important than pure source code size.

It also removes an unnecessary IO/apic read the code called 
from balance_irq, which seems worthwhile.

I'd like to reformat the for loops into something more obvious
as well, but I'll let that one lie for now. This is tested on
a 16-way NUMA-Q.

diff -purN -X /home/mbligh/.diff.exclude virgin/arch/i386/kernel/io_apic.c doaction2/arch/i386/kernel/io_apic.c
--- virgin/arch/i386/kernel/io_apic.c	Fri Dec 27 10:31:36 2002
+++ doaction2/arch/i386/kernel/io_apic.c	Fri Jan 10 15:41:30 2003
@@ -116,40 +116,84 @@ static void __init replace_pin_at_irq(un
 	}
 }
 
-#define __DO_ACTION(R, ACTION, FINAL)					\
-									\
-{									\
-	int pin;							\
-	struct irq_pin_list *entry = irq_2_pin + irq;			\
-									\
-	for (;;) {							\
-		unsigned int reg;					\
-		pin = entry->pin;					\
-		if (pin == -1)						\
-			break;						\
-		reg = io_apic_read(entry->apic, 0x10 + R + pin*2);	\
-		reg ACTION;						\
-		io_apic_modify(entry->apic, 0x10 + R + pin*2, reg);	\
-		if (!entry->next)					\
-			break;						\
-		entry = irq_2_pin + entry->next;			\
-	}								\
-	FINAL;								\
-}
-
-#define DO_ACTION(name,R,ACTION, FINAL)					\
-									\
-	static void name##_IO_APIC_irq (unsigned int irq)		\
-	__DO_ACTION(R, ACTION, FINAL)
-
-DO_ACTION( __mask,             0, |= 0x00010000, io_apic_sync(entry->apic) )
-						/* mask = 1 */
-DO_ACTION( __unmask,           0, &= 0xfffeffff, )
-						/* mask = 0 */
-DO_ACTION( __mask_and_edge,    0, = (reg & 0xffff7fff) | 0x00010000, )
-						/* mask = 1, trigger = 0 */
-DO_ACTION( __unmask_and_level, 0, = (reg & 0xfffeffff) | 0x00008000, )
-						/* mask = 0, trigger = 1 */
+/* mask = 1 */
+static void __mask_IO_APIC_irq (unsigned int irq)
+{
+	int pin;
+	struct irq_pin_list *entry = irq_2_pin + irq;
+
+	for (;;) {
+		unsigned int reg;
+		pin = entry->pin;
+		if (pin == -1)
+			break;
+		reg = io_apic_read(entry->apic, 0x10 + pin*2);
+		io_apic_modify(entry->apic, 0x10 + pin*2, reg |= 0x00010000);
+		if (!entry->next)
+			break;
+		entry = irq_2_pin + entry->next;
+	}
+	io_apic_sync(entry->apic);
+}
+
+/* mask = 0 */
+static void __unmask_IO_APIC_irq (unsigned int irq)
+{
+	int pin;
+	struct irq_pin_list *entry = irq_2_pin + irq;
+
+	for (;;) {
+		unsigned int reg;
+		pin = entry->pin;
+		if (pin == -1)
+			break;
+		reg = io_apic_read(entry->apic, 0x10 + pin*2);
+		io_apic_modify(entry->apic, 0x10 + pin*2, reg &= 0xfffeffff);
+		if (!entry->next)
+			break;
+		entry = irq_2_pin + entry->next;
+	}
+}
+
+/* mask = 1, trigger = 0 */
+static void __mask_and_edge_IO_APIC_irq (unsigned int irq)
+{
+	int pin;
+	struct irq_pin_list *entry = irq_2_pin + irq;
+
+	for (;;) {
+		unsigned int reg;
+		pin = entry->pin;
+		if (pin == -1)
+			break;
+		reg = io_apic_read(entry->apic, 0x10 + pin*2);
+		reg = (reg & 0xffff7fff) | 0x00010000;
+		io_apic_modify(entry->apic, 0x10 + pin*2, reg);
+		if (!entry->next)
+			break;
+		entry = irq_2_pin + entry->next;
+	}
+}
+
+/* mask = 0, trigger = 1 */
+static void __unmask_and_level_IO_APIC_irq (unsigned int irq)
+{
+	int pin;
+	struct irq_pin_list *entry = irq_2_pin + irq;
+
+	for (;;) {
+		unsigned int reg;
+		pin = entry->pin;
+		if (pin == -1)
+			break;
+		reg = io_apic_read(entry->apic, 0x10 + pin*2);
+		reg = (reg & 0xfffeffff) | 0x00008000;
+		io_apic_modify(entry->apic, 0x10 + pin*2, reg);
+		if (!entry->next)
+			break;
+		entry = irq_2_pin + entry->next;
+	}
+}
 
 static void mask_IO_APIC_irq (unsigned int irq)
 {
@@ -197,13 +241,23 @@ static void clear_IO_APIC (void)
 static void set_ioapic_affinity (unsigned int irq, unsigned long mask)
 {
 	unsigned long flags;
+	int pin;
+	struct irq_pin_list *entry = irq_2_pin + irq;
 
 	/*
 	 * Only the first 8 bits are valid.
 	 */
 	mask = mask << 24;
 	spin_lock_irqsave(&ioapic_lock, flags);
-	__DO_ACTION(1, = mask, )
+	for (;;) {
+		pin = entry->pin;
+		if (pin == -1)
+			break;
+		io_apic_modify(entry->apic, 0x10 + 1 + pin*2, mask);
+		if (!entry->next)
+			break;
+		entry = irq_2_pin + entry->next;
+	}
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 }
 

