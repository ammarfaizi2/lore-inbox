Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932521AbVJDO57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521AbVJDO57 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 10:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932524AbVJDO57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 10:57:59 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:49371 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932521AbVJDO56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 10:57:58 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86_64 io_apic.c: Memorize at bootup where the i8259 is
 connected
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 04 Oct 2005 08:56:35 -0600
Message-ID: <m1oe658h5o.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Currently we attempt to restore virtual wire mode on reboot, which
only works if we can figure out where the i8259 is connected.  This
is very useful when we are kexec another kernel and likely helpful
to an peculiar BIOS that make assumptions about how the system is setup.

Since the acpi MADT table does not provide the location where the i8259
is connected we have to look at the hardware to figure it out.

Most systems have the i8259 connected the local apic of the cpu so
won't be affected but people running Opteron and some serverworks chipsets
should be able to use kexec now.

In addition this patch removes the hard coded assumption that the
io_apic that delivers isa interrups is always known to the kernel
as io_apic 0.  There does not appear to be anything to guarantee
that assumption is true.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 arch/x86_64/kernel/io_apic.c |  140 ++++++++++++++++++++++++++++++++----------
 1 files changed, 105 insertions(+), 35 deletions(-)

a25d18a4d21556b3485731956fc768052967630c
diff --git a/arch/x86_64/kernel/io_apic.c b/arch/x86_64/kernel/io_apic.c
--- a/arch/x86_64/kernel/io_apic.c
+++ b/arch/x86_64/kernel/io_apic.c
@@ -46,6 +46,9 @@ static int no_timer_check;
 
 int disable_timer_pin_1 __initdata;
 
+/* Where if anywhere is the i8259 connect in external int mode */
+static struct { int pin, apic; } ioapic_i8259 = { -1, -1 };
+
 static DEFINE_SPINLOCK(ioapic_lock);
 
 /*
@@ -359,7 +362,7 @@ static int find_irq_entry(int apic, int 
 /*
  * Find the pin to which IRQ[irq] (ISA) is connected
  */
-static int find_isa_irq_pin(int irq, int type)
+static int __init find_isa_irq_pin(int irq, int type)
 {
 	int i;
 
@@ -377,6 +380,31 @@ static int find_isa_irq_pin(int irq, int
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
+		     mp_bus_id_to_type[lbus] == MP_BUS_MCA) &&
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
@@ -809,7 +837,7 @@ static void __init setup_IO_APIC_irqs(vo
  * Set up the 8259A-master output pin as broadcast to all
  * CPUs.
  */
-static void __init setup_ExtINT_IRQ0_pin(unsigned int pin, int vector)
+static void __init setup_ExtINT_IRQ0_pin(unsigned int apic, unsigned int pin, int vector)
 {
 	struct IO_APIC_route_entry entry;
 	unsigned long flags;
@@ -843,8 +871,8 @@ static void __init setup_ExtINT_IRQ0_pin
 	 * Add it to the IO-APIC irq-routing table:
 	 */
 	spin_lock_irqsave(&ioapic_lock, flags);
-	io_apic_write(0, 0x11+2*pin, *(((int *)&entry)+1));
-	io_apic_write(0, 0x10+2*pin, *(((int *)&entry)+0));
+	io_apic_write(apic, 0x11+2*pin, *(((int *)&entry)+1));
+	io_apic_write(apic, 0x10+2*pin, *(((int *)&entry)+0));
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 
 	enable_8259A_irq(0);
@@ -1123,7 +1151,8 @@ void __apicdebuginit print_PIC(void)
 static void __init enable_IO_APIC(void)
 {
 	union IO_APIC_reg_01 reg_01;
-	int i;
+	int i8259_apic, i8259_pin;
+	int i, apic;
 	unsigned long flags;
 
 	for (i = 0; i < PIN_MAP_SIZE; i++) {
@@ -1137,11 +1166,48 @@ static void __init enable_IO_APIC(void)
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
@@ -1155,7 +1221,6 @@ static void __init enable_IO_APIC(void)
  */
 void disable_IO_APIC(void)
 {
-	int pin;
 	/*
 	 * Clear the IO-APIC before rebooting:
 	 */
@@ -1166,8 +1231,7 @@ void disable_IO_APIC(void)
 	 * Put that IOAPIC in virtual wire mode
 	 * so legacy interrupts can be delivered.
 	 */
-	pin = find_isa_irq_pin(0, mp_ExtINT);
-	if (pin != -1) {
+	if (ioapic_i8259.pin != -1) {
 		struct IO_APIC_route_entry entry;
 		unsigned long flags;
 
@@ -1178,21 +1242,22 @@ void disable_IO_APIC(void)
 		entry.polarity        = 0; /* High */
 		entry.delivery_status = 0;
 		entry.dest_mode       = 0; /* Physical */
-		entry.delivery_mode   = 7; /* ExtInt */
+		entry.delivery_mode   = dest_ExtINT; /* ExtInt */
 		entry.vector          = 0;
 		entry.dest.physical.physical_dest = 0;
 
-
 		/*
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
@@ -1561,20 +1626,21 @@ static void setup_nmi (void)
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
 
@@ -1587,8 +1653,8 @@ static inline void unlock_ExtINT_logic(v
 	entry1.vector = 0;
 
 	spin_lock_irqsave(&ioapic_lock, flags);
-	io_apic_write(0, 0x11 + 2 * pin, *(((int *)&entry1) + 1));
-	io_apic_write(0, 0x10 + 2 * pin, *(((int *)&entry1) + 0));
+	io_apic_write(apic, 0x11 + 2 * pin, *(((int *)&entry1) + 1));
+	io_apic_write(apic, 0x10 + 2 * pin, *(((int *)&entry1) + 0));
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 
 	save_control = CMOS_READ(RTC_CONTROL);
@@ -1606,11 +1672,11 @@ static inline void unlock_ExtINT_logic(v
 
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
 
@@ -1622,7 +1688,7 @@ static inline void unlock_ExtINT_logic(v
  */
 static inline void check_timer(void)
 {
-	int pin1, pin2;
+	int apic1, pin1, apic2, pin2;
 	int vector;
 
 	/*
@@ -1643,10 +1709,13 @@ static inline void check_timer(void)
 	init_8259A(1);
 	enable_8259A_irq(0);
 
-	pin1 = find_isa_irq_pin(0, mp_INT);
-	pin2 = find_isa_irq_pin(0, mp_ExtINT);
+	pin1  = find_isa_irq_pin(0, mp_INT); 
+	apic1 = find_isa_irq_apic(0, mp_INT);
+	pin2  = ioapic_i8259.pin;
+	apic2 = ioapic_i8259.apic;
 
-	apic_printk(APIC_VERBOSE,KERN_INFO "..TIMER: vector=0x%02X pin1=%d pin2=%d\n", vector, pin1, pin2);
+	apic_printk(APIC_VERBOSE,KERN_INFO "..TIMER: vector=0x%02X apic1=%d pin1=%d apic2=%d pin2=%d\n", 
+		vector, apic1, pin1, apic2, pin2);
 
 	if (pin1 != -1) {
 		/*
@@ -1661,20 +1730,21 @@ static inline void check_timer(void)
 				enable_8259A_irq(0);
 			}
 			if (disable_timer_pin_1 > 0)
-				clear_IO_APIC_pin(0, pin1);
+				clear_IO_APIC_pin(apic1, pin1);
 			return;
 		}
-		clear_IO_APIC_pin(0, pin1);
+		clear_IO_APIC_pin(apic1, pin1);
 		apic_printk(APIC_QUIET,KERN_ERR "..MP-BIOS bug: 8254 timer not connected to IO-APIC\n");
 	}
 
 	apic_printk(APIC_VERBOSE,KERN_INFO "...trying to set up timer (IRQ0) through the 8259A ... ");
 	if (pin2 != -1) {
-		apic_printk(APIC_VERBOSE,"\n..... (found pin %d) ...", pin2);
+		apic_printk(APIC_VERBOSE,"\n..... (found apic %d pin %d) ...", 
+			apic2, pin2);
 		/*
 		 * legacy devices should be connected to IO APIC #0
 		 */
-		setup_ExtINT_IRQ0_pin(pin2, vector);
+		setup_ExtINT_IRQ0_pin(apic2, pin2, vector);
 		if (timer_irq_works()) {
 			printk("works.\n");
 			nmi_watchdog_default();
@@ -1686,7 +1756,7 @@ static inline void check_timer(void)
 		/*
 		 * Cleanup, just in case ...
 		 */
-		clear_IO_APIC_pin(0, pin2);
+		clear_IO_APIC_pin(apic2, pin2);
 	}
 	printk(" failed.\n");
 
