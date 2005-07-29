Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262585AbVG2Tde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262585AbVG2Tde (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 15:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262750AbVG2TbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 15:31:15 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:64905 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262741AbVG2TaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 15:30:18 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>
Subject: [PATCH] x86_64 io_apic.c: Memorize at bootup where the i8259 is
 connected
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 29 Jul 2005 13:30:03 -0600
Message-ID: <m164ut2yx0.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Currently we attempt to restore virtual wire mode on reboot, which
only works if we can figure out where the i8259 is connected.  This
is very useful when we kexec another kernel and likely helpful
when dealing with a BIOS that make assumptions about how the system is setup.

Since the acpi MADT table does not provide the location where the i8259
is connected we have to look at the hardware to figure it out.

Most systems have the i8259 connected to the local apic of the cpu so
won't be affected but people running on Opteron and some serverworks chipsets
should be able to use kexec now.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

 arch/x86_64/kernel/io_apic.c |   52 ++++++++++++++++++++++++++++++++++++++----
 1 files changed, 47 insertions(+), 5 deletions(-)

96c59dd871b00735ef159ddf0d68f338958387fc
diff --git a/arch/x86_64/kernel/io_apic.c b/arch/x86_64/kernel/io_apic.c
--- a/arch/x86_64/kernel/io_apic.c
+++ b/arch/x86_64/kernel/io_apic.c
@@ -45,6 +45,9 @@ int sis_apic_bug; /* not actually suppor
 
 static int no_timer_check;
 
+/* Where if anywhere is the i8259 connect in external int mode */
+static int ioapic_i8259_pin = -1;
+
 static DEFINE_SPINLOCK(ioapic_lock);
 
 /*
@@ -330,7 +333,7 @@ static int find_irq_entry(int apic, int 
 /*
  * Find the pin to which IRQ[irq] (ISA) is connected
  */
-static int find_isa_irq_pin(int irq, int type)
+static int __init find_isa_irq_pin(int irq, int type)
 {
 	int i;
 
@@ -1096,6 +1099,44 @@ void __apicdebuginit print_PIC(void)
 
 #endif  /*  0  */
 
+static void __init find_i8259_pin(void)
+{
+	struct IO_APIC_route_entry entry;
+	unsigned long flags;
+	int pin, pins;
+
+	ioapic_i8259_pin = -1;
+
+	/* Find the number of pins on the primary ioapic */
+	spin_lock_irqsave(&ioapic_lock, flags);
+	pins = ((io_apic_read(0, 0x01) >> 16) & 0xff) + 1;
+	spin_unlock_irqrestore(&ioapic_lock, flags);
+
+	/* See if any of the pins is in ExtINT mode */
+	for(pin = 0; pin < pins; pin++) {
+		spin_lock_irqsave(&ioapic_lock, flags);
+		*(((int *)&entry) + 0) = io_apic_read(0, 0x10 + 2 * pin);
+		*(((int *)&entry) + 1) = io_apic_read(0, 0x11 + 2 * pin);
+		spin_unlock_irqrestore(&ioapic_lock, flags);
+
+		/* If the interrupt line is enabled and in ExtInt mode 
+		 * I have found the pin where the i8259 is connected.
+		 */
+		if ((entry.mask == 0) && (entry.delivery_mode == dest_ExtINT)) {
+			ioapic_i8259_pin = pin;
+			break;
+		}
+	}
+
+	/* If we could not find an appropriate pin by looking at the ioapic
+	 * the i8259 probably isn't connected to the ioapic but give
+	 * the mptable a chance anyway.
+	 */
+	if (ioapic_i8259_pin == -1) {
+		ioapic_i8259_pin = find_isa_irq_pin(0, mp_ExtINT);
+	}
+}
+
 static void __init enable_IO_APIC(void)
 {
 	union IO_APIC_reg_01 reg_01;
@@ -1138,11 +1179,11 @@ void disable_IO_APIC(void)
 	clear_IO_APIC();
 
 	/*
-	 * If the i82559 is routed through an IOAPIC
+	 * If the i8259 is routed through an IOAPIC
 	 * Put that IOAPIC in virtual wire mode
 	 * so legacy interrups can be delivered.
 	 */
-	pin = find_isa_irq_pin(0, mp_ExtINT);
+	pin = ioapic_i8259_pin;
 	if (pin != -1) {
 		struct IO_APIC_route_entry entry;
 		unsigned long flags;
@@ -1154,7 +1195,7 @@ void disable_IO_APIC(void)
 		entry.polarity        = 0; /* High */
 		entry.delivery_status = 0;
 		entry.dest_mode       = 0; /* Physical */
-		entry.delivery_mode   = 7; /* ExtInt */
+		entry.delivery_mode   = dest_ExtINT; /* ExtInt */
 		entry.vector          = 0;
 		entry.dest.physical.physical_dest = 0;
 
@@ -1626,7 +1667,7 @@ static inline void check_timer(void)
 	enable_8259A_irq(0);
 
 	pin1 = find_isa_irq_pin(0, mp_INT);
-	pin2 = find_isa_irq_pin(0, mp_ExtINT);
+	pin2 = ioapic_i8259_pin;
 
 	apic_printk(APIC_VERBOSE,KERN_INFO "..TIMER: vector=0x%02X pin1=%d pin2=%d\n", vector, pin1, pin2);
 
@@ -1723,6 +1764,7 @@ __setup("no_timer_check", notimercheck);
 
 void __init setup_IO_APIC(void)
 {
+	find_i8259_pin();
 	enable_IO_APIC();
 
 	if (acpi_ioapic)
