Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932524AbWHJUYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932524AbWHJUYW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932605AbWHJUOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:14:41 -0400
Received: from mx1.suse.de ([195.135.220.2]:39312 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932606AbWHJTgN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:36:13 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [56/145] x86_64: Factor out common io apic routing entry access
Message-Id: <20060810193611.4B21C13B90@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:36:11 +0200 (CEST)
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

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/io_apic.c |   82 +++++++++++++++++++++----------------------
 1 files changed, 41 insertions(+), 41 deletions(-)

Index: linux/arch/x86_64/kernel/io_apic.c
===================================================================
--- linux.orig/arch/x86_64/kernel/io_apic.c
+++ linux/arch/x86_64/kernel/io_apic.c
@@ -111,6 +111,33 @@ int vector_irq[NR_VECTORS] __read_mostly
 	FINAL;								\
 }
 
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
 #ifdef CONFIG_SMP
 static void set_ioapic_affinity_irq(unsigned int irq, cpumask_t mask)
 {
@@ -196,13 +223,9 @@ static void unmask_IO_APIC_irq (unsigned
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
 	/*
@@ -210,10 +233,7 @@ static void clear_IO_APIC_pin(unsigned i
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
@@ -838,9 +858,9 @@ static void __init setup_IO_APIC_irqs(vo
 			if (!apic && (irq < 16))
 				disable_8259A_irq(irq);
 		}
+		ioapic_write_entry(apic, pin, entry);
+
 		spin_lock_irqsave(&ioapic_lock, flags);
-		io_apic_write(apic, 0x11+2*pin, *(((int *)&entry)+1));
-		io_apic_write(apic, 0x10+2*pin, *(((int *)&entry)+0));
 		set_native_irq_info(irq, TARGET_CPUS);
 		spin_unlock_irqrestore(&ioapic_lock, flags);
 	}
@@ -978,10 +998,7 @@ void __apicdebuginit print_IO_APIC(void)
 	for (i = 0; i <= reg_01.bits.entries; i++) {
 		struct IO_APIC_route_entry entry;
 
-		spin_lock_irqsave(&ioapic_lock, flags);
-		*(((int *)&entry)+0) = io_apic_read(apic, 0x10+i*2);
-		*(((int *)&entry)+1) = io_apic_read(apic, 0x11+i*2);
-		spin_unlock_irqrestore(&ioapic_lock, flags);
+		entry = ioapic_read_entry(apic, i);
 
 		printk(KERN_DEBUG " %02x %03X %02X  ",
 			i,
@@ -1191,11 +1208,7 @@ static void __init enable_IO_APIC(void)
 		/* See if any of the pins is in ExtINT mode */
 		for (pin = 0; pin < nr_ioapic_registers[apic]; pin++) {
 			struct IO_APIC_route_entry entry;
-			spin_lock_irqsave(&ioapic_lock, flags);
-			*(((int *)&entry) + 0) = io_apic_read(apic, 0x10 + 2 * pin);
-			*(((int *)&entry) + 1) = io_apic_read(apic, 0x11 + 2 * pin);
-			spin_unlock_irqrestore(&ioapic_lock, flags);
-
+			entry = ioapic_read_entry(apic, pin);
 
 			/* If the interrupt line is enabled and in ExtInt mode
 			 * I have found the pin where the i8259 is connected.
@@ -1247,7 +1260,6 @@ void disable_IO_APIC(void)
 	 */
 	if (ioapic_i8259.pin != -1) {
 		struct IO_APIC_route_entry entry;
-		unsigned long flags;
 
 		memset(&entry, 0, sizeof(entry));
 		entry.mask            = 0; /* Enabled */
@@ -1264,12 +1276,7 @@ void disable_IO_APIC(void)
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
@@ -1879,17 +1886,12 @@ static int ioapic_suspend(struct sys_dev
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
+	for (i = 0; i < nr_ioapic_registers[dev->id]; i ++, entry ++ )
+		*entry = ioapic_read_entry(dev->id, i);
 
 	return 0;
 }
@@ -1911,11 +1913,9 @@ static int ioapic_resume(struct sys_devi
 		reg_00.bits.ID = mp_ioapics[dev->id].mpc_apicid;
 		io_apic_write(dev->id, 0, reg_00.raw);
 	}
-	for (i = 0; i < nr_ioapic_registers[dev->id]; i ++, entry ++ ) {
-		io_apic_write(dev->id, 0x11+2*i, *(((int *)entry)+1));
-		io_apic_write(dev->id, 0x10+2*i, *(((int *)entry)+0));
-	}
 	spin_unlock_irqrestore(&ioapic_lock, flags);
+	for (i = 0; i < nr_ioapic_registers[dev->id]; i++)
+		ioapic_write_entry(dev->id, i, entry[i]);
 
 	return 0;
 }
@@ -2040,10 +2040,10 @@ int io_apic_set_pci_routing (int ioapic,
 	if (!ioapic && (irq < 16))
 		disable_8259A_irq(irq);
 
+	ioapic_write_entry(ioapic, pin, entry);
+
 	spin_lock_irqsave(&ioapic_lock, flags);
-	io_apic_write(ioapic, 0x11+2*pin, *(((int *)&entry)+1));
-	io_apic_write(ioapic, 0x10+2*pin, *(((int *)&entry)+0));
-	set_native_irq_info(use_pci_vector() ?  entry.vector : irq, TARGET_CPUS);
+	set_native_irq_info(use_pci_vector() ? entry.vector : irq, TARGET_CPUS);
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 
 	return 0;
