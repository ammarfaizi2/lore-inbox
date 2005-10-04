Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932511AbVJDO5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932511AbVJDO5J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 10:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932521AbVJDO5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 10:57:08 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:48347 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932511AbVJDO5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 10:57:07 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Subject: [PATCH] i386 io_apic.c: Memorize at bootup where the i8259
 is connected
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 04 Oct 2005 08:55:40 -0600
Message-ID: <m1slvh8h77.fsf@ebiederm.dsl.xmission.com>
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

Most systems have the i8259 connected the local apic of the cpu so
won't be affected but people running Opteron and some serverworks chipsets
should be able to use kexec now.

In addition this patch removes the hard coded assumption that the
io_apic that delivers isa interrups is always known to the kernel
as io_apic 0.  As there does not appear to be anything to guarantee
that assumption is true.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 arch/i386/kernel/io_apic.c |  146 +++++++++++++++++++++++++++++++++-----------
 1 files changed, 111 insertions(+), 35 deletions(-)

8fa6b5d66cb7adbc9298a378e292b9f2bfcd7c19
diff --git a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
--- a/arch/i386/kernel/io_apic.c
+++ b/arch/i386/kernel/io_apic.c
@@ -46,6 +46,9 @@
 int (*ioapic_renumber_irq)(int ioapic, int irq);
 atomic_t irq_mis_count;
 
+/* Where if anywhere is the i8259 connect in external int mode */
+static struct { int pin, apic; } ioapic_i8259 = { -1, -1 };
+
 static DEFINE_SPINLOCK(ioapic_lock);
 
 /*
@@ -738,7 +741,7 @@ static int find_irq_entry(int apic, int 
 /*
  * Find the pin to which IRQ[irq] (ISA) is connected
  */
-static int find_isa_irq_pin(int irq, int type)
+static int __init find_isa_irq_pin(int irq, int type)
 {
 	int i;
 
@@ -758,6 +761,33 @@ static int find_isa_irq_pin(int irq, int
 	return -1;
 }
 
+static int __init find_isa_irq_apic(int irq, int type)
+{
+	int i;
+
+	for (i = 0; i < mp_irq_entries; i++) {
+		int lbus = mp_irqs[i].mpc_srcbus;
+
+		if ((mp_bus_id_to_type[lbus] == MP_BUS_ISA ||
+		     mp_bus_id_to_type[lbus] == MP_BUS_EISA ||
+		     mp_bus_id_to_type[lbus] == MP_BUS_MCA ||
+		     mp_bus_id_to_type[lbus] == MP_BUS_NEC98
+		    ) &&
+		    (mp_irqs[i].mpc_irqtype == type) &&
+		    (mp_irqs[i].mpc_srcbusirq == irq))
+			break;
+	}
+	if (i < mp_irq_entries) {
+		int apic;
+		for(apic = 0; apic < nr_ioapics; apic++) {
+			if (mp_ioapics[apic].mpc_apicid == mp_irqs[i].mpc_dstapic) 
+				return apic;
+		}
+	}
+
+	return -1;
+}
+
 /*
  * Find a specific PCI IRQ entry.
  * Not an __init, possibly needed by modules
@@ -1253,7 +1283,7 @@ static void __init setup_IO_APIC_irqs(vo
 /*
  * Set up the 8259A-master output pin:
  */
-static void __init setup_ExtINT_IRQ0_pin(unsigned int pin, int vector)
+static void __init setup_ExtINT_IRQ0_pin(unsigned int apic, unsigned int pin, int vector)
 {
 	struct IO_APIC_route_entry entry;
 	unsigned long flags;
@@ -1287,8 +1317,8 @@ static void __init setup_ExtINT_IRQ0_pin
 	 * Add it to the IO-APIC irq-routing table:
 	 */
 	spin_lock_irqsave(&ioapic_lock, flags);
-	io_apic_write(0, 0x11+2*pin, *(((int *)&entry)+1));
-	io_apic_write(0, 0x10+2*pin, *(((int *)&entry)+0));
+	io_apic_write(apic, 0x11+2*pin, *(((int *)&entry)+1));
+	io_apic_write(apic, 0x10+2*pin, *(((int *)&entry)+0));
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 
 	enable_8259A_irq(0);
@@ -1595,7 +1625,8 @@ void /*__init*/ print_PIC(void)
 static void __init enable_IO_APIC(void)
 {
 	union IO_APIC_reg_01 reg_01;
-	int i;
+	int i8259_apic, i8259_pin;
+	int i, apic;
 	unsigned long flags;
 
 	for (i = 0; i < PIN_MAP_SIZE; i++) {
@@ -1609,11 +1640,52 @@ static void __init enable_IO_APIC(void)
 	/*
 	 * The number of IO-APIC IRQ registers (== #pins):
 	 */
-	for (i = 0; i < nr_ioapics; i++) {
+	for (apic = 0; apic < nr_ioapics; apic++) {
 		spin_lock_irqsave(&ioapic_lock, flags);
-		reg_01.raw = io_apic_read(i, 1);
+		reg_01.raw = io_apic_read(apic, 1);
 		spin_unlock_irqrestore(&ioapic_lock, flags);
-		nr_ioapic_registers[i] = reg_01.bits.entries+1;
+		nr_ioapic_registers[apic] = reg_01.bits.entries+1;
+	}
+	for(apic = 0; apic < nr_ioapics; apic++) {
+		int pin;
+		/* See if any of the pins is in ExtINT mode */
+		for(pin = 0; pin < nr_ioapic_registers[i]; pin++) {
+			struct IO_APIC_route_entry entry;
+			spin_lock_irqsave(&ioapic_lock, flags);
+			*(((int *)&entry) + 0) = io_apic_read(apic, 0x10 + 2 * pin);
+			*(((int *)&entry) + 1) = io_apic_read(apic, 0x11 + 2 * pin);
+			spin_unlock_irqrestore(&ioapic_lock, flags);
+
+
+			/* If the interrupt line is enabled and in ExtInt mode 
+			 * I have found the pin where the i8259 is connected.
+			 */
+			if ((entry.mask == 0) && (entry.delivery_mode == dest_ExtINT)) {
+				ioapic_i8259.apic = apic;
+				ioapic_i8259.pin  = pin;
+				goto found_i8259;
+			}
+		}
+	}
+ found_i8259:
+	/* Look to see what if the MP table has reported the ExtINT */
+	/* If we could not find the appropriate pin by looking at the ioapic
+	 * the i8259 probably is not connected the ioapic but give the
+	 * mptable a chance anyway.
+	 */
+	i8259_pin  = find_isa_irq_pin(0, mp_ExtINT);
+	i8259_apic = find_isa_irq_apic(0, mp_ExtINT);
+	/* Trust the MP table if nothing is setup in the hardware */
+	if ((ioapic_i8259.pin == -1) && (i8259_pin >= 0)) {
+		printk(KERN_WARNING "ExtINT not setup in hardware but reported by MP table\n");
+		ioapic_i8259.pin  = i8259_pin;
+		ioapic_i8259.apic = i8259_apic;
+	}
+	/* Complain if the MP table and the hardware disagree */
+	if (((ioapic_i8259.apic != i8259_apic) || (ioapic_i8259.pin != i8259_pin)) &&
+		(i8259_pin >= 0) && (ioapic_i8259.pin >= 0))
+	{
+		printk(KERN_WARNING "ExtINT in hardware and MP table differ\n");
 	}
 
 	/*
@@ -1627,7 +1699,6 @@ static void __init enable_IO_APIC(void)
  */
 void disable_IO_APIC(void)
 {
-	int pin;
 	/*
 	 * Clear the IO-APIC before rebooting:
 	 */
@@ -1638,8 +1709,7 @@ void disable_IO_APIC(void)
 	 * Put that IOAPIC in virtual wire mode
 	 * so legacy interrupts can be delivered.
 	 */
-	pin = find_isa_irq_pin(0, mp_ExtINT);
-	if (pin != -1) {
+	if (ioapic_i8259.pin != -1) {
 		struct IO_APIC_route_entry entry;
 		unsigned long flags;
 
@@ -1650,7 +1720,7 @@ void disable_IO_APIC(void)
 		entry.polarity        = 0; /* High */
 		entry.delivery_status = 0;
 		entry.dest_mode       = 0; /* Physical */
-		entry.delivery_mode   = 7; /* ExtInt */
+		entry.delivery_mode   = dest_ExtINT; /* ExtInt */
 		entry.vector          = 0;
 		entry.dest.physical.physical_dest = 0;
 
@@ -1659,11 +1729,13 @@ void disable_IO_APIC(void)
 		 * Add it to the IO-APIC irq-routing table:
 		 */
 		spin_lock_irqsave(&ioapic_lock, flags);
-		io_apic_write(0, 0x11+2*pin, *(((int *)&entry)+1));
-		io_apic_write(0, 0x10+2*pin, *(((int *)&entry)+0));
+		io_apic_write(ioapic_i8259.apic, 0x11+2*ioapic_i8259.pin,
+			*(((int *)&entry)+1));
+		io_apic_write(ioapic_i8259.apic, 0x10+2*ioapic_i8259.pin,
+			*(((int *)&entry)+0));
 		spin_unlock_irqrestore(&ioapic_lock, flags);
 	}
-	disconnect_bsp_APIC(pin != -1);
+	disconnect_bsp_APIC(ioapic_i8259.pin != -1);
 }
 
 /*
@@ -2113,20 +2185,21 @@ static void setup_nmi (void)
  */
 static inline void unlock_ExtINT_logic(void)
 {
-	int pin, i;
+	int apic, pin, i;
 	struct IO_APIC_route_entry entry0, entry1;
 	unsigned char save_control, save_freq_select;
 	unsigned long flags;
 
-	pin = find_isa_irq_pin(8, mp_INT);
+	pin  = find_isa_irq_pin(8, mp_INT);
+	apic = find_isa_irq_apic(8, mp_INT);
 	if (pin == -1)
 		return;
 
 	spin_lock_irqsave(&ioapic_lock, flags);
-	*(((int *)&entry0) + 1) = io_apic_read(0, 0x11 + 2 * pin);
-	*(((int *)&entry0) + 0) = io_apic_read(0, 0x10 + 2 * pin);
+	*(((int *)&entry0) + 1) = io_apic_read(apic, 0x11 + 2 * pin);
+	*(((int *)&entry0) + 0) = io_apic_read(apic, 0x10 + 2 * pin);
 	spin_unlock_irqrestore(&ioapic_lock, flags);
-	clear_IO_APIC_pin(0, pin);
+	clear_IO_APIC_pin(apic, pin);
 
 	memset(&entry1, 0, sizeof(entry1));
 
@@ -2139,8 +2212,8 @@ static inline void unlock_ExtINT_logic(v
 	entry1.vector = 0;
 
 	spin_lock_irqsave(&ioapic_lock, flags);
-	io_apic_write(0, 0x11 + 2 * pin, *(((int *)&entry1) + 1));
-	io_apic_write(0, 0x10 + 2 * pin, *(((int *)&entry1) + 0));
+	io_apic_write(apic, 0x11 + 2 * pin, *(((int *)&entry1) + 1));
+	io_apic_write(apic, 0x10 + 2 * pin, *(((int *)&entry1) + 0));
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 
 	save_control = CMOS_READ(RTC_CONTROL);
@@ -2158,11 +2231,11 @@ static inline void unlock_ExtINT_logic(v
 
 	CMOS_WRITE(save_control, RTC_CONTROL);
 	CMOS_WRITE(save_freq_select, RTC_FREQ_SELECT);
-	clear_IO_APIC_pin(0, pin);
+	clear_IO_APIC_pin(apic, pin);
 
 	spin_lock_irqsave(&ioapic_lock, flags);
-	io_apic_write(0, 0x11 + 2 * pin, *(((int *)&entry0) + 1));
-	io_apic_write(0, 0x10 + 2 * pin, *(((int *)&entry0) + 0));
+	io_apic_write(apic, 0x11 + 2 * pin, *(((int *)&entry0) + 1));
+	io_apic_write(apic, 0x10 + 2 * pin, *(((int *)&entry0) + 0));
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 }
 
@@ -2174,7 +2247,7 @@ static inline void unlock_ExtINT_logic(v
  */
 static inline void check_timer(void)
 {
-	int pin1, pin2;
+	int apic1, pin1, apic2, pin2;
 	int vector;
 
 	/*
@@ -2196,10 +2269,13 @@ static inline void check_timer(void)
 	timer_ack = 1;
 	enable_8259A_irq(0);
 
-	pin1 = find_isa_irq_pin(0, mp_INT);
-	pin2 = find_isa_irq_pin(0, mp_ExtINT);
+	pin1  = find_isa_irq_pin(0, mp_INT);
+	apic1 = find_isa_irq_apic(0, mp_INT);
+	pin2  = ioapic_i8259.pin;
+	apic2 = ioapic_i8259.apic;
 
-	printk(KERN_INFO "..TIMER: vector=0x%02X pin1=%d pin2=%d\n", vector, pin1, pin2);
+	printk(KERN_INFO "..TIMER: vector=0x%02X apic1=%d pin1=%d apic2=%d pin2=%d\n", 
+		vector, apic1, pin1, apic2, pin2);
 
 	if (pin1 != -1) {
 		/*
@@ -2213,10 +2289,10 @@ static inline void check_timer(void)
 				enable_8259A_irq(0);
 			}
 			if (disable_timer_pin_1 > 0)
-				clear_IO_APIC_pin(0, pin1);
+				clear_IO_APIC_pin(apic1, pin1);
 			return;
 		}
-		clear_IO_APIC_pin(0, pin1);
+		clear_IO_APIC_pin(apic1, pin1);
 		printk(KERN_ERR "..MP-BIOS bug: 8254 timer not connected to IO-APIC\n");
 	}
 
@@ -2226,13 +2302,13 @@ static inline void check_timer(void)
 		/*
 		 * legacy devices should be connected to IO APIC #0
 		 */
-		setup_ExtINT_IRQ0_pin(pin2, vector);
+		setup_ExtINT_IRQ0_pin(apic2, pin2, vector);
 		if (timer_irq_works()) {
 			printk("works.\n");
 			if (pin1 != -1)
-				replace_pin_at_irq(0, 0, pin1, 0, pin2);
+				replace_pin_at_irq(0, apic1, pin1, apic2, pin2);
 			else
-				add_pin_to_irq(0, 0, pin2);
+				add_pin_to_irq(0, apic2, pin2);
 			if (nmi_watchdog == NMI_IO_APIC) {
 				setup_nmi();
 			}
@@ -2241,7 +2317,7 @@ static inline void check_timer(void)
 		/*
 		 * Cleanup, just in case ...
 		 */
-		clear_IO_APIC_pin(0, pin2);
+		clear_IO_APIC_pin(apic2, pin2);
 	}
 	printk(" failed.\n");
 
