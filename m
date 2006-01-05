Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbWAEDSJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWAEDSJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 22:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751895AbWAEDSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 22:18:09 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.152]:4802 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751894AbWAEDSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 22:18:07 -0500
Date: Wed, 4 Jan 2006 23:27:39 -0500
From: Kurt Wall <kwall@kurtwerks.com>
To: Greg KH <gregkh@suse.de>
Cc: ak@suse.de, acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Clock going way too fast on 2.6.15 for amd64 processor
Message-ID: <20060105042739.GA4696@kurtwerks.com>
Mail-Followup-To: Greg KH <gregkh@suse.de>, ak@suse.de,
	acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20060104233919.GA15724@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060104233919.GA15724@kroah.com>
User-Agent: Mutt/1.4.2.1i
X-Operating-System: Linux 2.6.15krw
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 03:39:19PM -0800, Greg KH took 0 lines to write:
> Hi,
> 
> I tried digging through the mess in
> 	http://bugzilla.kernel.org/show_bug.cgi?id=3927
> but got lost in a see of conflicting patches.

Yup.

> I too have a amd64 box that is showing that the clock is running way too
> fast (feels about double speed, haven't checked for sure.)  I'm running
> it in 32bit mode for now, and the boot dmesg is below.
> 
> Any hints on patches that I should test out to try to track this down?
> I haven't run any real old kernels on it to see if it is something new
> (shows up on a 2.6.13 and 2.6.14 kernel too.)

Here's one from Andi that WORKSFORME. Requires acpi_skip_timer_override
on the kernel command line.

--- cut here ---
Remove support for interrupt 0/timer routing on non ACPI compliant boards. 
Timer interrupt is now always routed through the local APIC and the 8259
is always fully masked when APIC mode is active. All the special case
code for timer interrupts has been removed and interrupt 0 is now
handled like all other interrupts.

This should fix persistent timer problems on ATI and some Nvidia
boards. I tested it on different machines with different chipsets
I had available, but it needs more testing.

On an ATI IXP machine I still have some minor instability in the 
local APIC timing compared to other chipsets, but the pattern is quite 
regular and shouldn't cause big problems.

It mainly consists of removing code. I also removed support
for the IO-APIC watchdog, because it complicated the code paths
and wasn't used. Some other code also went that wasn't directly
related like support for MCA and EISA busses.

32bit is not changed right now, although it has the same troubles.
Problem is that it still has to support the old broken legacy systems
with weird interrupt routing. Perhaps the best way would be there
to check if the machine has ACPI tables (not necessarily using
ACPI, just checking if it claims to be ACPI compliant hardware) and if 
yes disable all the code I removed here on 64bit.

Signed-off-by: Andi Kleen <ak@suse.de>

 Documentation/nmi_watchdog.txt |    4 
 arch/x86_64/kernel/apic.c      |   24 -
 arch/x86_64/kernel/i8259.c     |   48 +--
 arch/x86_64/kernel/io_apic.c   |  538 -----------------------------------------
 arch/x86_64/kernel/nmi.c       |   25 -
 arch/x86_64/kernel/setup.c     |    5 
 arch/x86_64/kernel/smpboot.c   |    6 
 drivers/acpi/sleep/main.c      |    2 
 include/asm-x86_64/apic.h      |    8 
 include/asm-x86_64/hw_irq.h    |   18 -
 include/asm-x86_64/io_apic.h   |    2 
 include/asm-x86_64/nmi.h       |    0 
 12 files changed, 51 insertions(+), 629 deletions(-)



diff -u linux-2.6.15rc2-work/Documentation/nmi_watchdog.txt-o linux-2.6.15rc2-work/Documentation/nmi_watchdog.txt
--- linux-2.6.15rc2-work/Documentation/nmi_watchdog.txt-o	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.15rc2-work/Documentation/nmi_watchdog.txt	2005-11-24 16:14:10.000000000 +0100
@@ -72,8 +72,8 @@
 you have to enable it with a boot time parameter.  Prior to 2.4.2-ac18
 the NMI-oopser is enabled unconditionally on x86 SMP boxes.
 
-On x86-64 the NMI oopser is on by default. On 64bit Intel CPUs
-it uses IO-APIC by default and on AMD it uses local APIC.
+On x86-64 the NMI watchdog is on by default if the CPU is supported. 
+Only the local APIC watchdog exists.
 
 [ feel free to send bug reports, suggestions and patches to
   Ingo Molnar <mingo@redhat.com> or the Linux SMP mailing
diff -u linux-2.6.15rc2-work/arch/x86_64/kernel/nmi.c-o linux-2.6.15rc2-work/arch/x86_64/kernel/nmi.c
--- linux-2.6.15rc2-work/arch/x86_64/kernel/nmi.c-o	2005-10-30 16:09:03.000000000 +0100
+++ linux-2.6.15rc2-work/arch/x86_64/kernel/nmi.c	2005-11-24 16:30:09.000000000 +0100
@@ -116,7 +116,7 @@
 	if (nmi_known_cpu())
 		nmi_watchdog = NMI_LOCAL_APIC;
 	else
-		nmi_watchdog = NMI_IO_APIC;
+		printk(KERN_WARNING "Unknown CPU: no NMI watchdog support\n");
 }
 
 #ifdef CONFIG_SMP
@@ -264,27 +264,6 @@
 		enable_lapic_nmi_watchdog();
 }
 
-void disable_timer_nmi_watchdog(void)
-{
-	if ((nmi_watchdog != NMI_IO_APIC) || (nmi_active <= 0))
-		return;
-
-	disable_irq(0);
-	unset_nmi_callback();
-	nmi_active = -1;
-	nmi_watchdog = NMI_NONE;
-}
-
-void enable_timer_nmi_watchdog(void)
-{
-	if (nmi_active < 0) {
-		nmi_watchdog = NMI_IO_APIC;
-		touch_nmi_watchdog();
-		nmi_active = 1;
-		enable_irq(0);
-	}
-}
-
 #ifdef CONFIG_PM
 
 static int nmi_pm_active; /* nmi_active before suspend */
@@ -585,6 +564,4 @@
 EXPORT_SYMBOL(nmi_watchdog);
 EXPORT_SYMBOL(reserve_lapic_nmi);
 EXPORT_SYMBOL(release_lapic_nmi);
-EXPORT_SYMBOL(disable_timer_nmi_watchdog);
-EXPORT_SYMBOL(enable_timer_nmi_watchdog);
 EXPORT_SYMBOL(touch_nmi_watchdog);
diff -u linux-2.6.15rc2-work/arch/x86_64/kernel/setup.c-o linux-2.6.15rc2-work/arch/x86_64/kernel/setup.c
--- linux-2.6.15rc2-work/arch/x86_64/kernel/setup.c-o	2005-11-22 17:15:10.000000000 +0100
+++ linux-2.6.15rc2-work/arch/x86_64/kernel/setup.c	2005-11-24 17:06:28.000000000 +0100
@@ -336,11 +336,6 @@
 #endif
 #endif
 
-		if (!memcmp(from, "disable_timer_pin_1", 19))
-			disable_timer_pin_1 = 1;
-		if (!memcmp(from, "enable_timer_pin_1", 18))
-			disable_timer_pin_1 = -1;
-
 		if (!memcmp(from, "nolapic", 7) ||
 		    !memcmp(from, "disableapic", 11))
 			disable_apic = 1;
diff -u linux-2.6.15rc2-work/arch/x86_64/kernel/io_apic.c-o linux-2.6.15rc2-work/arch/x86_64/kernel/io_apic.c
--- linux-2.6.15rc2-work/arch/x86_64/kernel/io_apic.c-o	2005-11-22 17:15:10.000000000 +0100
+++ linux-2.6.15rc2-work/arch/x86_64/kernel/io_apic.c	2005-11-24 18:03:39.000000000 +0100
@@ -18,6 +18,8 @@
  *					and Rolf G. Tews
  *					for testing these extensively
  *	Paul Diefenbaugh	:	Added full ACPI support
+ *	Andi Kleen		:	Removed support for non ACPI compliant
+ *					systems.
  */
 
 #include <linux/mm.h>
@@ -42,10 +44,6 @@
 
 int sis_apic_bug; /* not actually supported, dummy for compile */
 
-static int no_timer_check;
-
-int disable_timer_pin_1 __initdata;
-
 static DEFINE_SPINLOCK(ioapic_lock);
 
 /*
@@ -361,27 +359,6 @@
 }
 
 /*
- * Find the pin to which IRQ[irq] (ISA) is connected
- */
-static int find_isa_irq_pin(int irq, int type)
-{
-	int i;
-
-	for (i = 0; i < mp_irq_entries; i++) {
-		int lbus = mp_irqs[i].mpc_srcbus;
-
-		if ((mp_bus_id_to_type[lbus] == MP_BUS_ISA ||
-		     mp_bus_id_to_type[lbus] == MP_BUS_EISA ||
-		     mp_bus_id_to_type[lbus] == MP_BUS_MCA) &&
-		    (mp_irqs[i].mpc_irqtype == type) &&
-		    (mp_irqs[i].mpc_srcbusirq == irq))
-
-			return mp_irqs[i].mpc_dstirq;
-	}
-	return -1;
-}
-
-/*
  * Find a specific PCI IRQ entry.
  * Not an __init, possibly needed by modules
  */
@@ -428,27 +405,6 @@
 	return best_guess;
 }
 
-/*
- * EISA Edge/Level control register, ELCR
- */
-static int EISA_ELCR(unsigned int irq)
-{
-	if (irq < 16) {
-		unsigned int port = 0x4d0 + (irq >> 3);
-		return (inb(port) >> (irq & 7)) & 1;
-	}
-	apic_printk(APIC_VERBOSE, "Broken MPtable reports ISA irq %d\n", irq);
-	return 0;
-}
-
-/* EISA interrupts are always polarity zero and can be edge or level
- * trigger depending on the ELCR value.  If an interrupt is listed as
- * EISA conforming in the MP table, that means its trigger type must
- * be read in from the ELCR */
-
-#define default_EISA_trigger(idx)	(EISA_ELCR(mp_irqs[idx].mpc_srcbusirq))
-#define default_EISA_polarity(idx)	(0)
-
 /* ISA interrupts are always polarity zero edge triggered,
  * when listed as conforming in the MP table. */
 
@@ -461,12 +417,6 @@
 #define default_PCI_trigger(idx)	(1)
 #define default_PCI_polarity(idx)	(1)
 
-/* MCA interrupts are always polarity zero level triggered,
- * when listed as conforming in the MP table. */
-
-#define default_MCA_trigger(idx)	(1)
-#define default_MCA_polarity(idx)	(0)
-
 static int __init MPBIOS_polarity(int idx)
 {
 	int bus = mp_irqs[idx].mpc_srcbus;
@@ -486,21 +436,11 @@
 					polarity = default_ISA_polarity(idx);
 					break;
 				}
-				case MP_BUS_EISA: /* EISA pin */
-				{
-					polarity = default_EISA_polarity(idx);
-					break;
-				}
 				case MP_BUS_PCI: /* PCI pin */
 				{
 					polarity = default_PCI_polarity(idx);
 					break;
 				}
-				case MP_BUS_MCA: /* MCA pin */
-				{
-					polarity = default_MCA_polarity(idx);
-					break;
-				}
 				default:
 				{
 					printk(KERN_WARNING "broken BIOS!!\n");
@@ -555,21 +495,11 @@
 					trigger = default_ISA_trigger(idx);
 					break;
 				}
-				case MP_BUS_EISA: /* EISA pin */
-				{
-					trigger = default_EISA_trigger(idx);
-					break;
-				}
 				case MP_BUS_PCI: /* PCI pin */
 				{
 					trigger = default_PCI_trigger(idx);
 					break;
 				}
-				case MP_BUS_MCA: /* MCA pin */
-				{
-					trigger = default_MCA_trigger(idx);
-					break;
-				}
 				default:
 				{
 					printk(KERN_WARNING "broken BIOS!!\n");
@@ -687,8 +617,6 @@
 	switch (mp_bus_id_to_type[bus])
 	{
 		case MP_BUS_ISA: /* ISA pin */
-		case MP_BUS_EISA:
-		case MP_BUS_MCA:
 		{
 			irq = mp_irqs[idx].mpc_srcbusirq;
 			break;
@@ -847,17 +775,10 @@
 		irq = pin_2_irq(idx, apic, pin);
 		add_pin_to_irq(irq, apic, pin);
 
-		if (!apic && !IO_APIC_IRQ(irq))
-			continue;
-
-		if (IO_APIC_IRQ(irq)) {
-			vector = assign_irq_vector(irq);
-			entry.vector = vector;
-
-			ioapic_register_intr(irq, vector, IOAPIC_AUTO);
-			if (!apic && (irq < 16))
-				disable_8259A_irq(irq);
-		}
+		vector = assign_irq_vector(irq);
+		entry.vector = vector;
+		
+		ioapic_register_intr(irq, vector, IOAPIC_AUTO);
 		spin_lock_irqsave(&ioapic_lock, flags);
 		io_apic_write(apic, 0x11+2*pin, *(((int *)&entry)+1));
 		io_apic_write(apic, 0x10+2*pin, *(((int *)&entry)+0));
@@ -870,51 +791,6 @@
 		apic_printk(APIC_VERBOSE," not connected.\n");
 }
 
-/*
- * Set up the 8259A-master output pin as broadcast to all
- * CPUs.
- */
-static void __init setup_ExtINT_IRQ0_pin(unsigned int pin, int vector)
-{
-	struct IO_APIC_route_entry entry;
-	unsigned long flags;
-
-	memset(&entry,0,sizeof(entry));
-
-	disable_8259A_irq(0);
-
-	/* mask LVT0 */
-	apic_write_around(APIC_LVT0, APIC_LVT_MASKED | APIC_DM_EXTINT);
-
-	/*
-	 * We use logical delivery to get the timer IRQ
-	 * to the first CPU.
-	 */
-	entry.dest_mode = INT_DEST_MODE;
-	entry.mask = 0;					/* unmask IRQ now */
-	entry.dest.logical.logical_dest = cpu_mask_to_apicid(TARGET_CPUS);
-	entry.delivery_mode = INT_DELIVERY_MODE;
-	entry.polarity = 0;
-	entry.trigger = 0;
-	entry.vector = vector;
-
-	/*
-	 * The timer IRQ doesn't have to know that behind the
-	 * scene we have a 8259A-master in AEOI mode ...
-	 */
-	irq_desc[0].handler = &ioapic_edge_type;
-
-	/*
-	 * Add it to the IO-APIC irq-routing table:
-	 */
-	spin_lock_irqsave(&ioapic_lock, flags);
-	io_apic_write(0, 0x11+2*pin, *(((int *)&entry)+1));
-	io_apic_write(0, 0x10+2*pin, *(((int *)&entry)+0));
-	spin_unlock_irqrestore(&ioapic_lock, flags);
-
-	enable_8259A_irq(0);
-}
-
 void __init UNEXPECTED_IO_APIC(void)
 {
 }
@@ -959,17 +835,6 @@
 
 	printk(KERN_DEBUG ".... register #01: %08X\n", *(int *)&reg_01);
 	printk(KERN_DEBUG ".......     : max redirection entries: %04X\n", reg_01.bits.entries);
-	if (	(reg_01.bits.entries != 0x0f) && /* older (Neptune) boards */
-		(reg_01.bits.entries != 0x17) && /* typical ISA+PCI boards */
-		(reg_01.bits.entries != 0x1b) && /* Compaq Proliant boards */
-		(reg_01.bits.entries != 0x1f) && /* dual Xeon boards */
-		(reg_01.bits.entries != 0x22) && /* bigger Xeon boards */
-		(reg_01.bits.entries != 0x2E) &&
-		(reg_01.bits.entries != 0x3F) &&
-		(reg_01.bits.entries != 0x03) 
-	)
-		UNEXPECTED_IO_APIC();
-
 	printk(KERN_DEBUG ".......     : PRQ implemented: %X\n", reg_01.bits.PRQ);
 	printk(KERN_DEBUG ".......     : IO APIC version: %04X\n", reg_01.bits.version);
 	if (	(reg_01.bits.version != 0x01) && /* 82489DX IO-APICs */
@@ -1151,37 +1016,6 @@
 	on_each_cpu(print_local_APIC, NULL, 1, 1);
 }
 
-void __apicdebuginit print_PIC(void)
-{
-	unsigned int v;
-	unsigned long flags;
-
-	if (apic_verbosity == APIC_QUIET)
-		return;
-
-	printk(KERN_DEBUG "\nprinting PIC contents\n");
-
-	spin_lock_irqsave(&i8259A_lock, flags);
-
-	v = inb(0xa1) << 8 | inb(0x21);
-	printk(KERN_DEBUG "... PIC  IMR: %04x\n", v);
-
-	v = inb(0xa0) << 8 | inb(0x20);
-	printk(KERN_DEBUG "... PIC  IRR: %04x\n", v);
-
-	outb(0x0b,0xa0);
-	outb(0x0b,0x20);
-	v = inb(0xa0) << 8 | inb(0x20);
-	outb(0x0a,0xa0);
-	outb(0x0a,0x20);
-
-	spin_unlock_irqrestore(&i8259A_lock, flags);
-
-	printk(KERN_DEBUG "... PIC  ISR: %04x\n", v);
-
-	v = inb(0x4d1) << 8 | inb(0x4d0);
-	printk(KERN_DEBUG "... PIC ELCR: %04x\n", v);
-}
 
 #endif  /*  0  */
 
@@ -1220,44 +1054,11 @@
  */
 void disable_IO_APIC(void)
 {
-	int pin;
 	/*
 	 * Clear the IO-APIC before rebooting:
 	 */
 	clear_IO_APIC();
-
-	/*
-	 * If the i8259 is routed through an IOAPIC
-	 * Put that IOAPIC in virtual wire mode
-	 * so legacy interrupts can be delivered.
-	 */
-	pin = find_isa_irq_pin(0, mp_ExtINT);
-	if (pin != -1) {
-		struct IO_APIC_route_entry entry;
-		unsigned long flags;
-
-		memset(&entry, 0, sizeof(entry));
-		entry.mask            = 0; /* Enabled */
-		entry.trigger         = 0; /* Edge */
-		entry.irr             = 0;
-		entry.polarity        = 0; /* High */
-		entry.delivery_status = 0;
-		entry.dest_mode       = 0; /* Physical */
-		entry.delivery_mode   = 7; /* ExtInt */
-		entry.vector          = 0;
-		entry.dest.physical.physical_dest = 0;
-
-
-		/*
-		 * Add it to the IO-APIC irq-routing table:
-		 */
-		spin_lock_irqsave(&ioapic_lock, flags);
-		io_apic_write(0, 0x11+2*pin, *(((int *)&entry)+1));
-		io_apic_write(0, 0x10+2*pin, *(((int *)&entry)+0));
-		spin_unlock_irqrestore(&ioapic_lock, flags);
-	}
-
-	disconnect_bsp_APIC(pin != -1);
+	disconnect_bsp_APIC();
 }
 
 /*
@@ -1327,36 +1128,6 @@
 }
 
 /*
- * There is a nasty bug in some older SMP boards, their mptable lies
- * about the timer IRQ. We do the following to work around the situation:
- *
- *	- timer IRQ defaults to IO-APIC IRQ
- *	- if this function detects that timer IRQs are defunct, then we fall
- *	  back to ISA timer IRQs
- */
-static int __init timer_irq_works(void)
-{
-	unsigned long t1 = jiffies;
-
-	local_irq_enable();
-	/* Let ten ticks pass... */
-	mdelay((10 * 1000) / HZ);
-
-	/*
-	 * Expect a few ticks at least, to be sure some possible
-	 * glue logic does not lock up after one or two first
-	 * ticks in a non-ExtINT mode.  Also the local APIC
-	 * might have cached one ExtINT interrupt.  Finally, at
-	 * least one tick may be lost due to delays.
-	 */
-
-	/* jiffies wrap? */
-	if (jiffies - t1 > 4)
-		return 1;
-	return 0;
-}
-
-/*
  * In the SMP+IOAPIC case it might happen that there are an unspecified
  * number of pending IRQ events unhandled. These cases are very rare,
  * so we 'resend' these IRQs via IPIs, to the same CPU. It's much
@@ -1385,8 +1156,7 @@
 	unsigned long flags;
 
 	spin_lock_irqsave(&ioapic_lock, flags);
-	if (irq < 16) {
-		disable_8259A_irq(irq);
+	if (irq < 16) { 		/* needed? */
 		if (i8259A_irq_pending(irq))
 			was_pending = 1;
 	}
@@ -1529,291 +1299,13 @@
 #endif
 };
 
-static inline void init_IO_APIC_traps(void)
-{
-	int irq;
-
-	/*
-	 * NOTE! The local APIC isn't very good at handling
-	 * multiple interrupts at the same interrupt level.
-	 * As the interrupt level is determined by taking the
-	 * vector number and shifting that right by 4, we
-	 * want to spread these out a bit so that they don't
-	 * all fall in the same interrupt level.
-	 *
-	 * Also, we've got to be careful not to trash gate
-	 * 0x80, because int 0x80 is hm, kind of importantish. ;)
-	 */
-	for (irq = 0; irq < NR_IRQS ; irq++) {
-		int tmp = irq;
-		if (use_pci_vector()) {
-			if (!platform_legacy_irq(tmp))
-				if ((tmp = vector_to_irq(tmp)) == -1)
-					continue;
-		}
-		if (IO_APIC_IRQ(tmp) && !IO_APIC_VECTOR(tmp)) {
-			/*
-			 * Hmm.. We don't have an entry for this,
-			 * so default to an old-fashioned 8259
-			 * interrupt if we can..
-			 */
-			if (irq < 16)
-				make_8259A_irq(irq);
-			else
-				/* Strange. Oh, well.. */
-				irq_desc[irq].handler = &no_irq_type;
-		}
-	}
-}
-
-static void enable_lapic_irq (unsigned int irq)
-{
-	unsigned long v;
-
-	v = apic_read(APIC_LVT0);
-	apic_write_around(APIC_LVT0, v & ~APIC_LVT_MASKED);
-}
-
-static void disable_lapic_irq (unsigned int irq)
-{
-	unsigned long v;
-
-	v = apic_read(APIC_LVT0);
-	apic_write_around(APIC_LVT0, v | APIC_LVT_MASKED);
-}
-
-static void ack_lapic_irq (unsigned int irq)
-{
-	ack_APIC_irq();
-}
-
-static void end_lapic_irq (unsigned int i) { /* nothing */ }
-
-static struct hw_interrupt_type lapic_irq_type __read_mostly = {
-	.typename = "local-APIC-edge",
-	.startup = NULL, /* startup_irq() not used for IRQ0 */
-	.shutdown = NULL, /* shutdown_irq() not used for IRQ0 */
-	.enable = enable_lapic_irq,
-	.disable = disable_lapic_irq,
-	.ack = ack_lapic_irq,
-	.end = end_lapic_irq,
-};
-
-static void setup_nmi (void)
-{
-	/*
- 	 * Dirty trick to enable the NMI watchdog ...
-	 * We put the 8259A master into AEOI mode and
-	 * unmask on all local APICs LVT0 as NMI.
-	 *
-	 * The idea to use the 8259A in AEOI mode ('8259A Virtual Wire')
-	 * is from Maciej W. Rozycki - so we do not have to EOI from
-	 * the NMI handler or the timer interrupt.
-	 */ 
-	printk(KERN_INFO "activating NMI Watchdog ...");
-
-	enable_NMI_through_LVT0(NULL);
-
-	printk(" done.\n");
-}
-
-/*
- * This looks a bit hackish but it's about the only one way of sending
- * a few INTA cycles to 8259As and any associated glue logic.  ICR does
- * not support the ExtINT mode, unfortunately.  We need to send these
- * cycles as some i82489DX-based boards have glue logic that keeps the
- * 8259A interrupt line asserted until INTA.  --macro
- */
-static inline void unlock_ExtINT_logic(void)
-{
-	int pin, i;
-	struct IO_APIC_route_entry entry0, entry1;
-	unsigned char save_control, save_freq_select;
-	unsigned long flags;
-
-	pin = find_isa_irq_pin(8, mp_INT);
-	if (pin == -1)
-		return;
-
-	spin_lock_irqsave(&ioapic_lock, flags);
-	*(((int *)&entry0) + 1) = io_apic_read(0, 0x11 + 2 * pin);
-	*(((int *)&entry0) + 0) = io_apic_read(0, 0x10 + 2 * pin);
-	spin_unlock_irqrestore(&ioapic_lock, flags);
-	clear_IO_APIC_pin(0, pin);
-
-	memset(&entry1, 0, sizeof(entry1));
-
-	entry1.dest_mode = 0;			/* physical delivery */
-	entry1.mask = 0;			/* unmask IRQ now */
-	entry1.dest.physical.physical_dest = hard_smp_processor_id();
-	entry1.delivery_mode = dest_ExtINT;
-	entry1.polarity = entry0.polarity;
-	entry1.trigger = 0;
-	entry1.vector = 0;
-
-	spin_lock_irqsave(&ioapic_lock, flags);
-	io_apic_write(0, 0x11 + 2 * pin, *(((int *)&entry1) + 1));
-	io_apic_write(0, 0x10 + 2 * pin, *(((int *)&entry1) + 0));
-	spin_unlock_irqrestore(&ioapic_lock, flags);
-
-	save_control = CMOS_READ(RTC_CONTROL);
-	save_freq_select = CMOS_READ(RTC_FREQ_SELECT);
-	CMOS_WRITE((save_freq_select & ~RTC_RATE_SELECT) | 0x6,
-		   RTC_FREQ_SELECT);
-	CMOS_WRITE(save_control | RTC_PIE, RTC_CONTROL);
-
-	i = 100;
-	while (i-- > 0) {
-		mdelay(10);
-		if ((CMOS_READ(RTC_INTR_FLAGS) & RTC_PF) == RTC_PF)
-			i -= 10;
-	}
-
-	CMOS_WRITE(save_control, RTC_CONTROL);
-	CMOS_WRITE(save_freq_select, RTC_FREQ_SELECT);
-	clear_IO_APIC_pin(0, pin);
-
-	spin_lock_irqsave(&ioapic_lock, flags);
-	io_apic_write(0, 0x11 + 2 * pin, *(((int *)&entry0) + 1));
-	io_apic_write(0, 0x10 + 2 * pin, *(((int *)&entry0) + 0));
-	spin_unlock_irqrestore(&ioapic_lock, flags);
-}
-
-/*
- * This code may look a bit paranoid, but it's supposed to cooperate with
- * a wide range of boards and BIOS bugs.  Fortunately only the timer IRQ
- * is so screwy.  Thanks to Brian Perkins for testing/hacking this beast
- * fanatically on his truly buggy board.
- */
-static inline void check_timer(void)
-{
-	int pin1, pin2;
-	int vector;
-
-	/*
-	 * get/set the timer IRQ vector:
-	 */
-	disable_8259A_irq(0);
-	vector = assign_irq_vector(0);
-	set_intr_gate(vector, interrupt[0]);
-
-	/*
-	 * Subtle, code in do_timer_interrupt() expects an AEOI
-	 * mode for the 8259A whenever interrupts are routed
-	 * through I/O APICs.  Also IRQ0 has to be enabled in
-	 * the 8259A which implies the virtual wire has to be
-	 * disabled in the local APIC.
-	 */
-	apic_write_around(APIC_LVT0, APIC_LVT_MASKED | APIC_DM_EXTINT);
-	init_8259A(1);
-	enable_8259A_irq(0);
-
-	pin1 = find_isa_irq_pin(0, mp_INT);
-	pin2 = find_isa_irq_pin(0, mp_ExtINT);
-
-	apic_printk(APIC_VERBOSE,KERN_INFO "..TIMER: vector=0x%02X pin1=%d pin2=%d\n", vector, pin1, pin2);
-
-	if (pin1 != -1) {
-		/*
-		 * Ok, does IRQ0 through the IOAPIC work?
-		 */
-		unmask_IO_APIC_irq(0);
-		if (!no_timer_check && timer_irq_works()) {
-			nmi_watchdog_default();
-			if (nmi_watchdog == NMI_IO_APIC) {
-				disable_8259A_irq(0);
-				setup_nmi();
-				enable_8259A_irq(0);
-			}
-			if (disable_timer_pin_1 > 0)
-				clear_IO_APIC_pin(0, pin1);
-			return;
-		}
-		clear_IO_APIC_pin(0, pin1);
-		apic_printk(APIC_QUIET,KERN_ERR "..MP-BIOS bug: 8254 timer not connected to IO-APIC\n");
-	}
-
-	apic_printk(APIC_VERBOSE,KERN_INFO "...trying to set up timer (IRQ0) through the 8259A ... ");
-	if (pin2 != -1) {
-		apic_printk(APIC_VERBOSE,"\n..... (found pin %d) ...", pin2);
-		/*
-		 * legacy devices should be connected to IO APIC #0
-		 */
-		setup_ExtINT_IRQ0_pin(pin2, vector);
-		if (timer_irq_works()) {
-			printk("works.\n");
-			nmi_watchdog_default();
-			if (nmi_watchdog == NMI_IO_APIC) {
-				setup_nmi();
-			}
-			return;
-		}
-		/*
-		 * Cleanup, just in case ...
-		 */
-		clear_IO_APIC_pin(0, pin2);
-	}
-	printk(" failed.\n");
-
-	if (nmi_watchdog) {
-		printk(KERN_WARNING "timer doesn't work through the IO-APIC - disabling NMI Watchdog!\n");
-		nmi_watchdog = 0;
-	}
-
-	apic_printk(APIC_VERBOSE, KERN_INFO "...trying to set up timer as Virtual Wire IRQ...");
-
-	disable_8259A_irq(0);
-	irq_desc[0].handler = &lapic_irq_type;
-	apic_write_around(APIC_LVT0, APIC_DM_FIXED | vector);	/* Fixed mode */
-	enable_8259A_irq(0);
-
-	if (timer_irq_works()) {
-		apic_printk(APIC_QUIET, " works.\n");
-		return;
-	}
-	apic_write_around(APIC_LVT0, APIC_LVT_MASKED | APIC_DM_FIXED | vector);
-	apic_printk(APIC_VERBOSE," failed.\n");
-
-	apic_printk(APIC_VERBOSE, KERN_INFO "...trying to set up timer as ExtINT IRQ...");
-
-	init_8259A(0);
-	make_8259A_irq(0);
-	apic_write_around(APIC_LVT0, APIC_DM_EXTINT);
-
-	unlock_ExtINT_logic();
-
-	if (timer_irq_works()) {
-		apic_printk(APIC_VERBOSE," works.\n");
-		return;
-	}
-	apic_printk(APIC_VERBOSE," failed :(.\n");
-	panic("IO-APIC + timer doesn't work! Try using the 'noapic' kernel parameter\n");
-}
-
-static int __init notimercheck(char *s)
-{
-	no_timer_check = 1;
-	return 1;
-}
-__setup("no_timer_check", notimercheck);
-
-/*
- *
- * IRQ's that are handled by the PIC in the MPS IOAPIC case.
- * - IRQ2 is the cascade IRQ, and cannot be a io-apic IRQ.
- *   Linux doesn't really care, as it's not actually used
- *   for any interrupt handling anyway.
- */
-#define PIC_IRQS	(1<<2)
-
 void __init setup_IO_APIC(void)
 {
+	apic_printk(APIC_VERBOSE, "ENABLING IO-APIC\n");
+
 	enable_IO_APIC();
 
-	if (acpi_ioapic)
-		io_apic_irqs = ~0;	/* all IRQs go through IOAPIC */
-	else
-		io_apic_irqs = ~PIC_IRQS;
+	disable_8259A_completely();
 
 	apic_printk(APIC_VERBOSE, "ENABLING IO-APIC IRQs\n");
 
@@ -1824,8 +1316,6 @@
 		setup_ioapic_ids_from_mpc();
 	sync_Arb_IDs();
 	setup_IO_APIC_irqs();
-	init_IO_APIC_traps();
-	check_timer();
 	if (!acpi_ioapic)
 		print_IO_APIC();
 }
@@ -1961,12 +1451,6 @@
 	struct IO_APIC_route_entry entry;
 	unsigned long flags;
 
-	if (!IO_APIC_IRQ(irq)) {
-		apic_printk(APIC_QUIET,KERN_ERR "IOAPIC[%d]: Invalid reference to IRQ 0\n",
-			ioapic);
-		return -EINVAL;
-	}
-
 	/*
 	 * Generate a PCI IRQ routing entry and program the IOAPIC accordingly.
 	 * Note that we mask (disable) IRQs now -- these get enabled when the
diff -u linux-2.6.15rc2-work/arch/x86_64/kernel/apic.c-o linux-2.6.15rc2-work/arch/x86_64/kernel/apic.c
--- linux-2.6.15rc2-work/arch/x86_64/kernel/apic.c-o	2005-11-22 17:15:10.000000000 +0100
+++ linux-2.6.15rc2-work/arch/x86_64/kernel/apic.c	2005-11-24 16:56:09.000000000 +0100
@@ -129,7 +129,7 @@
 	}
 }
 
-void disconnect_bsp_APIC(int virt_wire_setup)
+void disconnect_bsp_APIC(void)
 {
 	if (pic_mode) {
 		/*
@@ -153,20 +153,14 @@
 		value |= 0xf;
 		apic_write_around(APIC_SPIV, value);
 
-		if (!virt_wire_setup) {
-			/* For LVT0 make it edge triggered, active high, external and enabled */
-			value = apic_read(APIC_LVT0);
-			value &= ~(APIC_MODE_MASK | APIC_SEND_PENDING |
-				APIC_INPUT_POLARITY | APIC_LVT_REMOTE_IRR |
-				APIC_LVT_LEVEL_TRIGGER | APIC_LVT_MASKED );
-			value |= APIC_LVT_REMOTE_IRR | APIC_SEND_PENDING;
-			value = SET_APIC_DELIVERY_MODE(value, APIC_MODE_EXTINT);
-			apic_write_around(APIC_LVT0, value);
-		}
-		else {
-			/* Disable LVT0 */
-			apic_write_around(APIC_LVT0, APIC_LVT_MASKED);
-		}
+		/* For LVT0 make it edge triggered, active high, external and enabled */
+		value = apic_read(APIC_LVT0);
+		value &= ~(APIC_MODE_MASK | APIC_SEND_PENDING |
+			   APIC_INPUT_POLARITY | APIC_LVT_REMOTE_IRR |
+			   APIC_LVT_LEVEL_TRIGGER | APIC_LVT_MASKED );
+		value |= APIC_LVT_REMOTE_IRR | APIC_SEND_PENDING;
+		value = SET_APIC_DELIVERY_MODE(value, APIC_MODE_EXTINT);
+		apic_write_around(APIC_LVT0, value);
 
 		/* For LVT1 make it edge triggered, active high, nmi and enabled */
 		value = apic_read(APIC_LVT1);
diff -u linux-2.6.15rc2-work/arch/x86_64/kernel/i8259.c-o linux-2.6.15rc2-work/arch/x86_64/kernel/i8259.c
--- linux-2.6.15rc2-work/arch/x86_64/kernel/i8259.c-o	2005-11-22 17:15:10.000000000 +0100
+++ linux-2.6.15rc2-work/arch/x86_64/kernel/i8259.c	2005-11-24 16:27:07.000000000 +0100
@@ -176,16 +176,6 @@
 #define cached_21	(__byte(0,cached_irq_mask))
 #define cached_A1	(__byte(1,cached_irq_mask))
 
-/*
- * Not all IRQs can be routed through the IO-APIC, eg. on certain (older)
- * boards the timer interrupt is not really connected to any IO-APIC pin,
- * it's fed to the master 8259A's IR0 line only.
- *
- * Any '1' bit in this mask means the IRQ is routed through the IO-APIC.
- * this 'mixed mode' IRQ handling costs nothing because it's only used
- * at IRQ setup time.
- */
-unsigned long io_apic_irqs;
 
 void disable_8259A_irq(unsigned int irq)
 {
@@ -231,14 +221,6 @@
 	return ret;
 }
 
-void make_8259A_irq(unsigned int irq)
-{
-	disable_irq_nosync(irq);
-	io_apic_irqs &= ~(1<<irq);
-	irq_desc[irq].handler = &i8259A_irq_type;
-	enable_irq(irq);
-}
-
 /*
  * This function assumes to be called rarely. Switching between
  * 8259A registers is slow.
@@ -338,7 +320,17 @@
 	}
 }
 
-void init_8259A(int auto_eoi)
+/* Called by the IO-APIC code when it takes over */
+void disable_8259A_completely(void)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&i8259A_lock, flags);
+	outb(0xff, 0x21);	/* mask all of 8259A-1 */
+	outb(0xff, 0xA1);	/* mask all of 8259A-2 */
+	spin_unlock_irqrestore(&i8259A_lock, flags);	
+}
+
+static void init_8259A(void)
 {
 	unsigned long flags;
 
@@ -353,10 +345,7 @@
 	outb_p(0x11, 0x20);	/* ICW1: select 8259A-1 init */
 	outb_p(0x20 + 0, 0x21);	/* ICW2: 8259A-1 IR0-7 mapped to 0x20-0x27 */
 	outb_p(0x04, 0x21);	/* 8259A-1 (the master) has a slave on IR2 */
-	if (auto_eoi)
-		outb_p(0x03, 0x21);	/* master does Auto EOI */
-	else
-		outb_p(0x01, 0x21);	/* master expects normal EOI */
+	outb_p(0x01, 0x21);	/* master expects normal EOI */
 
 	outb_p(0x11, 0xA0);	/* ICW1: select 8259A-2 init */
 	outb_p(0x20 + 8, 0xA1);	/* ICW2: 8259A-2 IR0-7 mapped to 0x28-0x2f */
@@ -364,14 +353,7 @@
 	outb_p(0x01, 0xA1);	/* (slave's support for AEOI in flat mode
 				    is to be investigated) */
 
-	if (auto_eoi)
-		/*
-		 * in AEOI mode we just have to mask the interrupt
-		 * when acking.
-		 */
-		i8259A_irq_type.ack = disable_8259A_irq;
-	else
-		i8259A_irq_type.ack = mask_and_ack_8259A;
+	i8259A_irq_type.ack = mask_and_ack_8259A;
 
 	udelay(100);		/* wait for 8259A to initialize */
 
@@ -400,7 +382,7 @@
 
 static int i8259A_resume(struct sys_device *dev)
 {
-	init_8259A(0);
+	init_8259A();
 	restore_ELCR(irq_trigger);
 	return 0;
 }
@@ -457,7 +439,7 @@
 #ifdef CONFIG_X86_LOCAL_APIC
 	init_bsp_APIC();
 #endif
-	init_8259A(0);
+	init_8259A();
 
 	for (i = 0; i < NR_IRQS; i++) {
 		irq_desc[i].status = IRQ_DISABLED;
diff -u linux-2.6.15rc2-work/arch/x86_64/kernel/smpboot.c-o linux-2.6.15rc2-work/arch/x86_64/kernel/smpboot.c
--- linux-2.6.15rc2-work/arch/x86_64/kernel/smpboot.c-o	2005-11-22 17:15:10.000000000 +0100
+++ linux-2.6.15rc2-work/arch/x86_64/kernel/smpboot.c	2005-11-24 16:29:52.000000000 +0100
@@ -516,12 +516,6 @@
 
 	Dprintk("cpu %d: enabling apic timer\n", smp_processor_id());
 
-	if (nmi_watchdog == NMI_IO_APIC) {
-		disable_8259A_irq(0);
-		enable_NMI_through_LVT0(NULL);
-		enable_8259A_irq(0);
-	}
-
 	enable_APIC_timer();
 
 	/*
diff -u linux-2.6.15rc2-work/drivers/acpi/sleep/main.c-o linux-2.6.15rc2-work/drivers/acpi/sleep/main.c
--- linux-2.6.15rc2-work/drivers/acpi/sleep/main.c-o	2005-11-16 00:34:18.000000000 +0100
+++ linux-2.6.15rc2-work/drivers/acpi/sleep/main.c	2005-11-24 17:41:56.000000000 +0100
@@ -137,10 +137,12 @@
 	/* reset firmware waking vector */
 	acpi_set_firmware_waking_vector((acpi_physical_address) 0);
 
+#ifndef CONFIG_X86_64
 	if (init_8259A_after_S1) {
 		printk("Broken toshiba laptop -> kicking interrupts\n");
 		init_8259A(0);
 	}
+#endif
 	return 0;
 }
 
diff -u linux-2.6.15rc2-work/include/asm-x86_64/apic.h-o linux-2.6.15rc2-work/include/asm-x86_64/apic.h
--- linux-2.6.15rc2-work/include/asm-x86_64/apic.h-o	2005-11-22 17:15:13.000000000 +0100
+++ linux-2.6.15rc2-work/include/asm-x86_64/apic.h	2005-11-24 16:54:40.000000000 +0100
@@ -77,7 +77,7 @@
 extern int get_maxlvt (void);
 extern void clear_local_APIC (void);
 extern void connect_bsp_APIC (void);
-extern void disconnect_bsp_APIC (int virt_wire_setup);
+extern void disconnect_bsp_APIC (void);
 extern void disable_local_APIC (void);
 extern int verify_local_APIC (void);
 extern void cache_APIC_registers (void);
@@ -91,8 +91,9 @@
 extern void setup_apic_nmi_watchdog (void);
 extern int reserve_lapic_nmi(void);
 extern void release_lapic_nmi(void);
-extern void disable_timer_nmi_watchdog(void);
-extern void enable_timer_nmi_watchdog(void);
+/* For oprofile. not needed anymore */
+static inline void enable_timer_nmi_watchdog(void) {}
+static inline void disable_timer_nmi_watchdog(void) {}
 extern void nmi_watchdog_tick (struct pt_regs * regs, unsigned reason);
 extern int APIC_init_uniprocessor (void);
 extern void disable_APIC_timer(void);
@@ -105,7 +106,6 @@
 extern unsigned int nmi_watchdog;
 #define NMI_DEFAULT	-1
 #define NMI_NONE	0
-#define NMI_IO_APIC	1
 #define NMI_LOCAL_APIC	2
 #define NMI_INVALID	3
 
diff -u linux-2.6.15rc2-work/include/asm-x86_64/hw_irq.h-o linux-2.6.15rc2-work/include/asm-x86_64/hw_irq.h
--- linux-2.6.15rc2-work/include/asm-x86_64/hw_irq.h-o	2005-11-22 17:15:13.000000000 +0100
+++ linux-2.6.15rc2-work/include/asm-x86_64/hw_irq.h	2005-11-24 17:26:29.000000000 +0100
@@ -93,8 +93,7 @@
 extern void enable_8259A_irq(unsigned int irq);
 extern int i8259A_irq_pending(unsigned int irq);
 extern void make_8259A_irq(unsigned int irq);
-extern void init_8259A(int aeoi);
-extern void FASTCALL(send_IPI_self(int vector));
+extern void send_IPI_self(int vector);
 extern void init_VISWS_APIC_irqs(void);
 extern void setup_IO_APIC(void);
 extern void disable_IO_APIC(void);
@@ -102,13 +101,12 @@
 extern int IO_APIC_get_PCI_irq_vector(int bus, int slot, int fn);
 extern void send_IPI(int dest, int vector);
 extern void setup_ioapic_dest(void);
-
-extern unsigned long io_apic_irqs;
+extern void disable_8259A_completely(void);
 
 extern atomic_t irq_err_count;
 extern atomic_t irq_mis_count;
 
-#define IO_APIC_IRQ(x) (((x) >= 16) || ((1<<(x)) & io_apic_irqs))
+#define IO_APIC_IRQ(x) 1
 
 #define __STR(x) #x
 #define STR(x) __STR(x)
@@ -130,14 +128,10 @@
 	"push $" #nr "-256 ; " \
 	"jmp common_interrupt");
 
-#if defined(CONFIG_X86_IO_APIC)
-static inline void hw_resend_irq(struct hw_interrupt_type *h, unsigned int i) {
-	if (IO_APIC_IRQ(i))
-		send_IPI_self(IO_APIC_VECTOR(i));
+static inline void hw_resend_irq(struct hw_interrupt_type *h, unsigned int i) 
+{
+	send_IPI_self(IO_APIC_VECTOR(i));
 }
-#else
-static inline void hw_resend_irq(struct hw_interrupt_type *h, unsigned int i) {}
-#endif
 
 #define platform_legacy_irq(irq)	((irq) < 16)
 
diff -u linux-2.6.15rc2-work/include/asm-x86_64/nmi.h-o linux-2.6.15rc2-work/include/asm-x86_64/nmi.h
diff -u linux-2.6.15rc2-work/include/asm-x86_64/io_apic.h-o linux-2.6.15rc2-work/include/asm-x86_64/io_apic.h
--- linux-2.6.15rc2-work/include/asm-x86_64/io_apic.h-o	2005-10-30 16:09:11.000000000 +0100
+++ linux-2.6.15rc2-work/include/asm-x86_64/io_apic.h	2005-11-24 17:26:28.000000000 +0100
@@ -199,7 +199,7 @@
  * If we use the IO-APIC for IRQ routing, disable automatic
  * assignment of PCI IRQ's.
  */
-#define io_apic_assign_pci_irqs (mp_irq_entries && !skip_ioapic_setup && io_apic_irqs)
+#define io_apic_assign_pci_irqs (!skip_ioapic_setup)
 
 #ifdef CONFIG_ACPI
 extern int io_apic_get_version (int ioapic);
-
--- cut here ---

Kurt
-- 
Naeser's Law:
	You can make it foolproof, but you can't make it
damnfoolproof.
