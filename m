Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932606AbWHJUY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932606AbWHJUY3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932603AbWHJUOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:14:46 -0400
Received: from mail.suse.de ([195.135.220.2]:40080 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932607AbWHJTgN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:36:13 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [57/145] i386: Factor out common io apic routing entry access
Message-Id: <20060810193612.581D513B90@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:36:12 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

The IO APIC code had lots of duplicated code to read/write 64bit
routing entries into the IO-APIC. Factor this out int common read/write
functions

In a few cases the IO APIC lock is taken more often now, but this
isn't a problem because it's all initialization/shutdown only
slow path code.

Similar to earlier x86-64 patch.

Includes a fix by Jiri Slaby for a mistake that broke resume

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/io_apic.c |  100 +++++++++++++++++++--------------------------
 1 files changed, 43 insertions(+), 57 deletions(-)

Index: linux/arch/i386/kernel/io_apic.c
===================================================================
--- linux.orig/arch/i386/kernel/io_apic.c
+++ linux/arch/i386/kernel/io_apic.c
@@ -94,6 +94,34 @@ int vector_irq[NR_VECTORS] __read_mostly
 #define vector_to_irq(vector)	(vector)
 #endif
 
+
+union entry_union {
+	struct { u32 w1, w2; };
+	struct IO_APIC_route_entry entry;
+};
+
+static struct IO_APIC_route_entry ioapic_read_entry(int apic, int pin)
+{
+	union entry_union eu;
+	unsigned long flags;
+	spin_lock_irqsave(&ioapic_lock, flags);
+	eu.w1 = io_apic_read(apic, 0x10 + 2 * pin);
+	eu.w2 = io_apic_read(apic, 0x11 + 2 * pin);
+	spin_unlock_irqrestore(&ioapic_lock, flags);
+	return eu.entry;
+}
+
+static void ioapic_write_entry(int apic, int pin, struct IO_APIC_route_entry e)
+{
+	unsigned long flags;
+	union entry_union eu;
+	eu.entry = e;
+	spin_lock_irqsave(&ioapic_lock, flags);
+	io_apic_write(apic, 0x10 + 2*pin, eu.w1);
+	io_apic_write(apic, 0x11 + 2*pin, eu.w2);
+	spin_unlock_irqrestore(&ioapic_lock, flags);
+}
+
 /*
  * The common case is 1:1 IRQ<->pin mappings. Sometimes there are
  * shared ISA-space IRQs, so we have to support them. We are super
@@ -201,13 +229,9 @@ static void unmask_IO_APIC_irq (unsigned
 static void clear_IO_APIC_pin(unsigned int apic, unsigned int pin)
 {
 	struct IO_APIC_route_entry entry;
-	unsigned long flags;
 	
 	/* Check delivery_mode to be sure we're not clearing an SMI pin */
-	spin_lock_irqsave(&ioapic_lock, flags);
-	*(((int*)&entry) + 0) = io_apic_read(apic, 0x10 + 2 * pin);
-	*(((int*)&entry) + 1) = io_apic_read(apic, 0x11 + 2 * pin);
-	spin_unlock_irqrestore(&ioapic_lock, flags);
+	entry = ioapic_read_entry(apic, pin);
 	if (entry.delivery_mode == dest_SMI)
 		return;
 
@@ -216,10 +240,7 @@ static void clear_IO_APIC_pin(unsigned i
 	 */
 	memset(&entry, 0, sizeof(entry));
 	entry.mask = 1;
-	spin_lock_irqsave(&ioapic_lock, flags);
-	io_apic_write(apic, 0x10 + 2 * pin, *(((int *)&entry) + 0));
-	io_apic_write(apic, 0x11 + 2 * pin, *(((int *)&entry) + 1));
-	spin_unlock_irqrestore(&ioapic_lock, flags);
+	ioapic_write_entry(apic, pin, entry);
 }
 
 static void clear_IO_APIC (void)
@@ -1284,9 +1305,8 @@ static void __init setup_IO_APIC_irqs(vo
 			if (!apic && (irq < 16))
 				disable_8259A_irq(irq);
 		}
+		ioapic_write_entry(apic, pin, entry);
 		spin_lock_irqsave(&ioapic_lock, flags);
-		io_apic_write(apic, 0x11+2*pin, *(((int *)&entry)+1));
-		io_apic_write(apic, 0x10+2*pin, *(((int *)&entry)+0));
 		set_native_irq_info(irq, TARGET_CPUS);
 		spin_unlock_irqrestore(&ioapic_lock, flags);
 	}
@@ -1302,7 +1322,6 @@ static void __init setup_IO_APIC_irqs(vo
 static void __init setup_ExtINT_IRQ0_pin(unsigned int apic, unsigned int pin, int vector)
 {
 	struct IO_APIC_route_entry entry;
-	unsigned long flags;
 
 	memset(&entry,0,sizeof(entry));
 
@@ -1332,10 +1351,7 @@ static void __init setup_ExtINT_IRQ0_pin
 	/*
 	 * Add it to the IO-APIC irq-routing table:
 	 */
-	spin_lock_irqsave(&ioapic_lock, flags);
-	io_apic_write(apic, 0x11+2*pin, *(((int *)&entry)+1));
-	io_apic_write(apic, 0x10+2*pin, *(((int *)&entry)+0));
-	spin_unlock_irqrestore(&ioapic_lock, flags);
+	ioapic_write_entry(apic, pin, entry);
 
 	enable_8259A_irq(0);
 }
@@ -1445,10 +1461,7 @@ void __init print_IO_APIC(void)
 	for (i = 0; i <= reg_01.bits.entries; i++) {
 		struct IO_APIC_route_entry entry;
 
-		spin_lock_irqsave(&ioapic_lock, flags);
-		*(((int *)&entry)+0) = io_apic_read(apic, 0x10+i*2);
-		*(((int *)&entry)+1) = io_apic_read(apic, 0x11+i*2);
-		spin_unlock_irqrestore(&ioapic_lock, flags);
+		entry = ioapic_read_entry(apic, i);
 
 		printk(KERN_DEBUG " %02x %03X %02X  ",
 			i,
@@ -1667,10 +1680,7 @@ static void __init enable_IO_APIC(void)
 		/* See if any of the pins is in ExtINT mode */
 		for (pin = 0; pin < nr_ioapic_registers[apic]; pin++) {
 			struct IO_APIC_route_entry entry;
-			spin_lock_irqsave(&ioapic_lock, flags);
-			*(((int *)&entry) + 0) = io_apic_read(apic, 0x10 + 2 * pin);
-			*(((int *)&entry) + 1) = io_apic_read(apic, 0x11 + 2 * pin);
-			spin_unlock_irqrestore(&ioapic_lock, flags);
+			entry = ioapic_read_entry(apic, pin);
 
 
 			/* If the interrupt line is enabled and in ExtInt mode
@@ -1727,7 +1737,6 @@ void disable_IO_APIC(void)
 	 */
 	if (ioapic_i8259.pin != -1) {
 		struct IO_APIC_route_entry entry;
-		unsigned long flags;
 
 		memset(&entry, 0, sizeof(entry));
 		entry.mask            = 0; /* Enabled */
@@ -1744,12 +1753,7 @@ void disable_IO_APIC(void)
 		/*
 		 * Add it to the IO-APIC irq-routing table:
 		 */
-		spin_lock_irqsave(&ioapic_lock, flags);
-		io_apic_write(ioapic_i8259.apic, 0x11+2*ioapic_i8259.pin,
-			*(((int *)&entry)+1));
-		io_apic_write(ioapic_i8259.apic, 0x10+2*ioapic_i8259.pin,
-			*(((int *)&entry)+0));
-		spin_unlock_irqrestore(&ioapic_lock, flags);
+		ioapic_write_entry(ioapic_i8259.apic, ioapic_i8259.pin, entry);
 	}
 	disconnect_bsp_APIC(ioapic_i8259.pin != -1);
 }
@@ -2214,17 +2218,13 @@ static inline void unlock_ExtINT_logic(v
 	int apic, pin, i;
 	struct IO_APIC_route_entry entry0, entry1;
 	unsigned char save_control, save_freq_select;
-	unsigned long flags;
 
 	pin  = find_isa_irq_pin(8, mp_INT);
 	apic = find_isa_irq_apic(8, mp_INT);
 	if (pin == -1)
 		return;
 
-	spin_lock_irqsave(&ioapic_lock, flags);
-	*(((int *)&entry0) + 1) = io_apic_read(apic, 0x11 + 2 * pin);
-	*(((int *)&entry0) + 0) = io_apic_read(apic, 0x10 + 2 * pin);
-	spin_unlock_irqrestore(&ioapic_lock, flags);
+	entry0 = ioapic_read_entry(apic, pin);
 	clear_IO_APIC_pin(apic, pin);
 
 	memset(&entry1, 0, sizeof(entry1));
@@ -2237,10 +2237,7 @@ static inline void unlock_ExtINT_logic(v
 	entry1.trigger = 0;
 	entry1.vector = 0;
 
-	spin_lock_irqsave(&ioapic_lock, flags);
-	io_apic_write(apic, 0x11 + 2 * pin, *(((int *)&entry1) + 1));
-	io_apic_write(apic, 0x10 + 2 * pin, *(((int *)&entry1) + 0));
-	spin_unlock_irqrestore(&ioapic_lock, flags);
+	ioapic_write_entry(apic, pin, entry1);
 
 	save_control = CMOS_READ(RTC_CONTROL);
 	save_freq_select = CMOS_READ(RTC_FREQ_SELECT);
@@ -2259,10 +2256,7 @@ static inline void unlock_ExtINT_logic(v
 	CMOS_WRITE(save_freq_select, RTC_FREQ_SELECT);
 	clear_IO_APIC_pin(apic, pin);
 
-	spin_lock_irqsave(&ioapic_lock, flags);
-	io_apic_write(apic, 0x11 + 2 * pin, *(((int *)&entry0) + 1));
-	io_apic_write(apic, 0x10 + 2 * pin, *(((int *)&entry0) + 0));
-	spin_unlock_irqrestore(&ioapic_lock, flags);
+	ioapic_write_entry(apic, pin, entry0);
 }
 
 int timer_uses_ioapic_pin_0;
@@ -2462,17 +2456,12 @@ static int ioapic_suspend(struct sys_dev
 {
 	struct IO_APIC_route_entry *entry;
 	struct sysfs_ioapic_data *data;
-	unsigned long flags;
 	int i;
 	
 	data = container_of(dev, struct sysfs_ioapic_data, dev);
 	entry = data->entry;
-	spin_lock_irqsave(&ioapic_lock, flags);
-	for (i = 0; i < nr_ioapic_registers[dev->id]; i ++, entry ++ ) {
-		*(((int *)entry) + 1) = io_apic_read(dev->id, 0x11 + 2 * i);
-		*(((int *)entry) + 0) = io_apic_read(dev->id, 0x10 + 2 * i);
-	}
-	spin_unlock_irqrestore(&ioapic_lock, flags);
+	for (i = 0; i < nr_ioapic_registers[dev->id]; i ++)
+		entry[i] = ioapic_read_entry(dev->id, i);
 
 	return 0;
 }
@@ -2494,11 +2483,9 @@ static int ioapic_resume(struct sys_devi
 		reg_00.bits.ID = mp_ioapics[dev->id].mpc_apicid;
 		io_apic_write(dev->id, 0, reg_00.raw);
 	}
-	for (i = 0; i < nr_ioapic_registers[dev->id]; i ++, entry ++ ) {
-		io_apic_write(dev->id, 0x11+2*i, *(((int *)entry)+1));
-		io_apic_write(dev->id, 0x10+2*i, *(((int *)entry)+0));
-	}
 	spin_unlock_irqrestore(&ioapic_lock, flags);
+	for (i = 0; i < nr_ioapic_registers[dev->id]; i ++)
+		ioapic_write_entry(dev->id, i, entry[i]);
 
 	return 0;
 }
@@ -2695,9 +2682,8 @@ int io_apic_set_pci_routing (int ioapic,
 	if (!ioapic && (irq < 16))
 		disable_8259A_irq(irq);
 
+	ioapic_write_entry(ioapic, pin, entry);
 	spin_lock_irqsave(&ioapic_lock, flags);
-	io_apic_write(ioapic, 0x11+2*pin, *(((int *)&entry)+1));
-	io_apic_write(ioapic, 0x10+2*pin, *(((int *)&entry)+0));
 	set_native_irq_info(use_pci_vector() ? entry.vector : irq, TARGET_CPUS);
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 
