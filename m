Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267079AbTBLNOK>; Wed, 12 Feb 2003 08:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267089AbTBLNOK>; Wed, 12 Feb 2003 08:14:10 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:22912 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S267079AbTBLNNu>; Wed, 12 Feb 2003 08:13:50 -0500
Date: Wed, 12 Feb 2003 22:22:19 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCHSET] PC-9800 subarch. support for 2.5.60 (1/34) AC#1
Message-ID: <20030212132219.GB1551@yuzuki.cinet.co.jp>
References: <20030212131737.GA1551@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030212131737.GA1551@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patchset to support NEC PC-9800 subarchitecture
against 2.5.60 (1/34).

   PC98 support patch in 2.5.50-ac1 with minimum changes
   to apply 2.5.60. (arch/i386/*)

- Osamu Tomita

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.60/arch/i386/Makefile linux98-2.5.60/arch/i386/Makefile
--- linux-2.5.60/arch/i386/Makefile	2003-02-11 03:38:19.000000000 +0900
+++ linux98-2.5.60/arch/i386/Makefile	2003-02-11 09:47:18.000000000 +0900
@@ -114,6 +114,7 @@
 
 archclean:
 	$(Q)$(MAKE) $(clean)=arch/i386/boot
+	$(Q)$(MAKE) $(clean)=arch/i386/boot98
 
 define archhelp
   echo  '* bzImage	- Compressed kernel image (arch/$(ARCH)/boot/bzImage)'
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.54/arch/i386/kernel/apic.c linux98-2.5.54/arch/i386/kernel/apic.c
--- linux-2.5.54/arch/i386/kernel/apic.c	2003-01-02 12:23:30.000000000 +0900
+++ linux98-2.5.54/arch/i386/kernel/apic.c	2003-01-04 10:47:57.000000000 +0900
@@ -33,6 +33,7 @@
 #include <asm/arch_hooks.h>
 
 #include <mach_apic.h>
+#include <io_ports.h>
 
 void __init apic_intr_init(void)
 {
@@ -745,9 +746,9 @@
 
 	spin_lock_irqsave(&i8253_lock, flags);
 
-	outb_p(0x00, 0x43);
-	count = inb_p(0x40);
-	count |= inb_p(0x40) << 8;
+	outb_p(0x00, PIT_MODE);
+	count = inb_p(PIT_CH0);
+	count |= inb_p(PIT_CH0) << 8;
 
 	spin_unlock_irqrestore(&i8253_lock, flags);
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.50/arch/i386/kernel/cpu/proc.c linux.50-ac1/arch/i386/kernel/cpu/proc.c
--- linux.50/arch/i386/kernel/cpu/proc.c	2002-11-25 15:09:12.000000000 +0000
+++ linux.50-ac1/arch/i386/kernel/cpu/proc.c	2002-11-17 00:19:07.000000000 +0000
@@ -83,7 +83,7 @@
 #endif
 	
 	/* We use exception 16 if we have hardware math and we've either seen it or the CPU claims it is internal */
-	fpu_exception = c->hard_math && (ignore_irq13 || cpu_has_fpu);
+	fpu_exception = c->hard_math && (ignore_fpu_irq || cpu_has_fpu);
 	seq_printf(m, "fdiv_bug\t: %s\n"
 			"hlt_bug\t\t: %s\n"
 			"f00f_bug\t: %s\n"
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.53/arch/i386/kernel/i8259.c linux98-2.5.53/arch/i386/kernel/i8259.c
--- linux-2.5.53/arch/i386/kernel/i8259.c	2002-12-24 14:21:14.000000000 +0900
+++ linux98-2.5.53/arch/i386/kernel/i8259.c	2002-12-26 10:32:58.000000000 +0900
@@ -25,6 +25,8 @@
 
 #include <linux/irq.h>
 
+#include <io_ports.h>
+
 /*
  * This is the 'legacy' 8259A Programmable Interrupt Controller,
  * present in the majority of PC/AT boxes.
@@ -74,8 +76,8 @@
 static unsigned int cached_irq_mask = 0xffff;
 
 #define __byte(x,y) 	(((unsigned char *)&(y))[x])
-#define cached_21	(__byte(0,cached_irq_mask))
-#define cached_A1	(__byte(1,cached_irq_mask))
+#define cached_master_mask	(__byte(0,cached_irq_mask))
+#define cached_slave_mask	(__byte(1,cached_irq_mask))
 
 /*
  * Not all IRQs can be routed through the IO-APIC, eg. on certain (older)
@@ -96,9 +98,9 @@
 	spin_lock_irqsave(&i8259A_lock, flags);
 	cached_irq_mask |= mask;
 	if (irq & 8)
-		outb(cached_A1,0xA1);
+		outb(cached_slave_mask, PIC_SLAVE_IMR);
 	else
-		outb(cached_21,0x21);
+		outb(cached_master_mask, PIC_MASTER_IMR);
 	spin_unlock_irqrestore(&i8259A_lock, flags);
 }
 
@@ -110,9 +112,9 @@
 	spin_lock_irqsave(&i8259A_lock, flags);
 	cached_irq_mask &= mask;
 	if (irq & 8)
-		outb(cached_A1,0xA1);
+		outb(cached_slave_mask, PIC_SLAVE_IMR);
 	else
-		outb(cached_21,0x21);
+		outb(cached_master_mask, PIC_MASTER_IMR);
 	spin_unlock_irqrestore(&i8259A_lock, flags);
 }
 
@@ -124,9 +126,9 @@
 
 	spin_lock_irqsave(&i8259A_lock, flags);
 	if (irq < 8)
-		ret = inb(0x20) & mask;
+		ret = inb(PIC_MASTER_CMD) & mask;
 	else
-		ret = inb(0xA0) & (mask >> 8);
+		ret = inb(PIC_SLAVE_CMD) & (mask >> 8);
 	spin_unlock_irqrestore(&i8259A_lock, flags);
 
 	return ret;
@@ -152,14 +154,14 @@
 	int irqmask = 1<<irq;
 
 	if (irq < 8) {
-		outb(0x0B,0x20);		/* ISR register */
-		value = inb(0x20) & irqmask;
-		outb(0x0A,0x20);		/* back to the IRR register */
+		outb(0x0B,PIC_MASTER_CMD);	/* ISR register */
+		value = inb(PIC_MASTER_CMD) & irqmask;
+		outb(0x0A,PIC_MASTER_CMD);	/* back to the IRR register */
 		return value;
 	}
-	outb(0x0B,0xA0);		/* ISR register */
-	value = inb(0xA0) & (irqmask >> 8);
-	outb(0x0A,0xA0);		/* back to the IRR register */
+	outb(0x0B,PIC_SLAVE_CMD);	/* ISR register */
+	value = inb(PIC_SLAVE_CMD) & (irqmask >> 8);
+	outb(0x0A,PIC_SLAVE_CMD);	/* back to the IRR register */
 	return value;
 }
 
@@ -196,14 +198,14 @@
 
 handle_real_irq:
 	if (irq & 8) {
-		inb(0xA1);		/* DUMMY - (do we need this?) */
-		outb(cached_A1,0xA1);
-		outb(0x60+(irq&7),0xA0);/* 'Specific EOI' to slave */
-		outb(0x62,0x20);	/* 'Specific EOI' to master-IRQ2 */
+		inb(PIC_SLAVE_IMR);	/* DUMMY - (do we need this?) */
+		outb(cached_slave_mask, PIC_SLAVE_IMR);
+		outb(0x60+(irq&7),PIC_SLAVE_CMD);/* 'Specific EOI' to slave */
+		outb(0x60+PIC_CASCADE_IR,PIC_MASTER_CMD); /* 'Specific EOI' to master-IRQ2 */
 	} else {
-		inb(0x21);		/* DUMMY - (do we need this?) */
-		outb(cached_21,0x21);
-		outb(0x60+irq,0x20);	/* 'Specific EOI' to master */
+		inb(PIC_MASTER_IMR);	/* DUMMY - (do we need this?) */
+		outb(cached_master_mask, PIC_MASTER_IMR);
+		outb(0x60+irq,PIC_MASTER_CMD);	/* 'Specific EOI to master */
 	}
 	spin_unlock_irqrestore(&i8259A_lock, flags);
 	return;
@@ -275,26 +277,24 @@
 
 	spin_lock_irqsave(&i8259A_lock, flags);
 
-	outb(0xff, 0x21);	/* mask all of 8259A-1 */
-	outb(0xff, 0xA1);	/* mask all of 8259A-2 */
+	outb(0xff, PIC_MASTER_IMR);	/* mask all of 8259A-1 */
+	outb(0xff, PIC_SLAVE_IMR);	/* mask all of 8259A-2 */
 
 	/*
 	 * outb_p - this has to work on a wide range of PC hardware.
 	 */
-	outb_p(0x11, 0x20);	/* ICW1: select 8259A-1 init */
-	outb_p(0x20 + 0, 0x21);	/* ICW2: 8259A-1 IR0-7 mapped to 0x20-0x27 */
-	outb_p(0x04, 0x21);	/* 8259A-1 (the master) has a slave on IR2 */
-	if (auto_eoi)
-		outb_p(0x03, 0x21);	/* master does Auto EOI */
-	else
-		outb_p(0x01, 0x21);	/* master expects normal EOI */
-
-	outb_p(0x11, 0xA0);	/* ICW1: select 8259A-2 init */
-	outb_p(0x20 + 8, 0xA1);	/* ICW2: 8259A-2 IR0-7 mapped to 0x28-0x2f */
-	outb_p(0x02, 0xA1);	/* 8259A-2 is a slave on master's IR2 */
-	outb_p(0x01, 0xA1);	/* (slave's support for AEOI in flat mode
-				    is to be investigated) */
-
+	outb_p(0x11, PIC_MASTER_CMD);	/* ICW1: select 8259A-1 init */
+	outb_p(0x20 + 0, PIC_MASTER_IMR);	/* ICW2: 8259A-1 IR0-7 mapped to 0x20-0x27 */
+	outb_p(1U << PIC_CASCADE_IR, PIC_MASTER_IMR);	/* 8259A-1 (the master) has a slave on IR2 */
+	if (auto_eoi)	/* master does Auto EOI */
+		outb_p(MASTER_ICW4_DEFAULT | PIC_ICW4_AEOI, PIC_MASTER_IMR);
+	else		/* master expects normal EOI */
+		outb_p(MASTER_ICW4_DEFAULT, PIC_MASTER_IMR);
+
+	outb_p(0x11, PIC_SLAVE_CMD);	/* ICW1: select 8259A-2 init */
+	outb_p(0x20 + 8, PIC_SLAVE_IMR);	/* ICW2: 8259A-2 IR0-7 mapped to 0x28-0x2f */
+	outb_p(PIC_CASCADE_IR, PIC_SLAVE_IMR);	/* 8259A-2 is a slave on master's IR2 */
+	outb_p(SLAVE_ICW4_DEFAULT, PIC_SLAVE_IMR); /* (slave's support for AEOI in flat mode is to be investigated) */
 	if (auto_eoi)
 		/*
 		 * in AEOI mode we just have to mask the interrupt
@@ -306,8 +306,8 @@
 
 	udelay(100);		/* wait for 8259A to initialize */
 
-	outb(cached_21, 0x21);	/* restore master IRQ mask */
-	outb(cached_A1, 0xA1);	/* restore slave IRQ mask */
+	outb(cached_master_mask, PIC_MASTER_IMR); /* restore master IRQ mask */
+	outb(cached_slave_mask, PIC_SLAVE_IMR);	  /* restore slave IRQ mask */
 
 	spin_unlock_irqrestore(&i8259A_lock, flags);
 }
@@ -324,11 +324,17 @@
  * be shot.
  */
  
+/*
+ * =PC9800NOTE= In NEC PC-9800, we use irq8 instead of irq13!
+ */
+
 static void math_error_irq(int cpl, void *dev_id, struct pt_regs *regs)
 {
 	extern void math_error(void *);
+#ifndef CONFIG_PC9800
 	outb(0,0xF0);
-	if (ignore_irq13 || !boot_cpu_data.hard_math)
+#endif
+	if (ignore_fpu_irq || !boot_cpu_data.hard_math)
 		return;
 	math_error((void *)regs->eip);
 }
@@ -337,7 +343,7 @@
  * New motherboards sometimes make IRQ 13 be a PCI interrupt,
  * so allow interrupt sharing.
  */
-static struct irqaction irq13 = { math_error_irq, 0, 0, "fpu", NULL, NULL };
+static struct irqaction fpu_irq = { math_error_irq, 0, 0, "fpu", NULL, NULL };
 
 void __init init_ISA_irqs (void)
 {
@@ -369,11 +375,11 @@
 
 static void setup_timer(void)
 {
-	outb_p(0x34,0x43);		/* binary, mode 2, LSB/MSB, ch 0 */
+	outb_p(0x34, PIT_MODE);		/* binary, mode 2, LSB/MSB, ch 0 */
 	udelay(10);
-	outb_p(LATCH & 0xff , 0x40);	/* LSB */
+	outb_p(LATCH & 0xff, PIT_CH0);	/* LSB */
 	udelay(10);
-	outb(LATCH >> 8 , 0x40);	/* MSB */
+	outb(LATCH >> 8, PIT_CH0);	/* MSB */
 }
 
 static int timer_resume(struct device *dev, u32 level)
@@ -440,5 +446,5 @@
 	 * original braindamaged IBM FERR coupling.
 	 */
 	if (boot_cpu_data.hard_math && !cpu_has_fpu)
-		setup_irq(13, &irq13);
+		setup_irq(FPU_IRQ, &fpu_irq);
 }
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.60/arch/i386/kernel/io_apic.c linux98-2.5.60/arch/i386/kernel/io_apic.c
--- linux-2.5.60/arch/i386/kernel/io_apic.c	2003-02-11 03:38:17.000000000 +0900
+++ linux98-2.5.60/arch/i386/kernel/io_apic.c	2003-02-11 09:47:18.000000000 +0900
@@ -37,6 +37,7 @@
 #include <asm/desc.h>
 
 #include <mach_apic.h>
+#include <io_ports.h>
 
 #undef APIC_LOCKUP_DEBUG
 
@@ -669,7 +670,9 @@
 
 		if ((mp_bus_id_to_type[lbus] == MP_BUS_ISA ||
 		     mp_bus_id_to_type[lbus] == MP_BUS_EISA ||
-		     mp_bus_id_to_type[lbus] == MP_BUS_MCA) &&
+		     mp_bus_id_to_type[lbus] == MP_BUS_MCA ||
+		     mp_bus_id_to_type[lbus] == MP_BUS_NEC98
+		    ) &&
 		    (mp_irqs[i].mpc_irqtype == type) &&
 		    (mp_irqs[i].mpc_srcbusirq == irq))
 
@@ -763,6 +766,12 @@
 #define default_MCA_trigger(idx)	(1)
 #define default_MCA_polarity(idx)	(0)
 
+/* NEC98 interrupts are always polarity zero edge triggered,
+ * when listed as conforming in the MP table. */
+
+#define default_NEC98_trigger(idx)     (0)
+#define default_NEC98_polarity(idx)    (0)
+
 static int __init MPBIOS_polarity(int idx)
 {
 	int bus = mp_irqs[idx].mpc_srcbus;
@@ -797,6 +806,11 @@
 					polarity = default_MCA_polarity(idx);
 					break;
 				}
+				case MP_BUS_NEC98: /* NEC 98 pin */
+				{
+					polarity = default_NEC98_polarity(idx);
+					break;
+				}
 				default:
 				{
 					printk(KERN_WARNING "broken BIOS!!\n");
@@ -866,6 +880,11 @@
 					trigger = default_MCA_trigger(idx);
 					break;
 				}
+				case MP_BUS_NEC98: /* NEC 98 pin */
+				{
+					trigger = default_NEC98_trigger(idx);
+					break;
+				}
 				default:
 				{
 					printk(KERN_WARNING "broken BIOS!!\n");
@@ -927,6 +946,7 @@
 		case MP_BUS_ISA: /* ISA pin */
 		case MP_BUS_EISA:
 		case MP_BUS_MCA:
+		case MP_BUS_NEC98:
 		{
 			irq = mp_irqs[idx].mpc_srcbusirq;
 			break;
@@ -2031,7 +2051,7 @@
  * Additionally, something is definitely wrong with irq9
  * on PIIX4 boards.
  */
-#define PIC_IRQS	(1<<2)
+#define PIC_IRQS	(1 << PIC_CASCADE_IR)
 
 void __init setup_IO_APIC(void)
 {
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.53/arch/i386/kernel/mpparse.c linux98-2.5.53/arch/i386/kernel/mpparse.c
--- linux-2.5.53/arch/i386/kernel/mpparse.c	2002-12-24 14:19:54.000000000 +0900
+++ linux98-2.5.53/arch/i386/kernel/mpparse.c	2002-12-26 09:22:43.000000000 +0900
@@ -209,6 +209,8 @@
 		mp_current_pci_id++;
 	} else if (strncmp(str, BUSTYPE_MCA, sizeof(BUSTYPE_MCA)-1) == 0) {
 		mp_bus_id_to_type[m->mpc_busid] = MP_BUS_MCA;
+	} else if (strncmp(str, BUSTYPE_NEC98, sizeof(BUSTYPE_NEC98)-1) == 0) {
+		mp_bus_id_to_type[m->mpc_busid] = MP_BUS_NEC98;
 	} else {
 		printk("Unknown bustype %s - ignoring\n", str);
 	}
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.53/arch/i386/kernel/reboot.c linux98-2.5.53/arch/i386/kernel/reboot.c
--- linux-2.5.53/arch/i386/kernel/reboot.c	2002-12-24 14:19:53.000000000 +0900
+++ linux98-2.5.53/arch/i386/kernel/reboot.c	2002-12-26 10:46:08.000000000 +0900
@@ -8,6 +8,7 @@
 #include <linux/interrupt.h>
 #include <linux/mc146818rtc.h>
 #include <asm/uaccess.h>
+#include <mach_reboot.h>
 
 /*
  * Power off function, if any
@@ -125,15 +126,6 @@
 	0xea, 0x00, 0x00, 0xff, 0xff		/*    ljmp  $0xffff,$0x0000  */
 };
 
-static inline void kb_wait(void)
-{
-	int i;
-
-	for (i=0; i<0x10000; i++)
-		if ((inb_p(0x64) & 0x02) == 0)
-			break;
-}
-
 /*
  * Switch to real mode and then execute the code
  * specified by the code and length parameters.
@@ -264,13 +256,7 @@
 		/* rebooting needs to touch the page at absolute addr 0 */
 		*((unsigned short *)__va(0x472)) = reboot_mode;
 		for (;;) {
-			int i;
-			for (i=0; i<100; i++) {
-				kb_wait();
-				udelay(50);
-				outb(0xfe,0x64);         /* pulse reset low */
-				udelay(50);
-			}
+			mach_reboot();
 			/* That didn't work - force a triple fault.. */
 			__asm__ __volatile__("lidt %0": :"m" (no_idt));
 			__asm__ __volatile__("int3");
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.53/arch/i386/kernel/setup.c linux98-2.5.53/arch/i386/kernel/setup.c
--- linux-2.5.53/arch/i386/kernel/setup.c	2002-12-24 14:20:16.000000000 +0900
+++ linux98-2.5.53/arch/i386/kernel/setup.c	2002-12-26 11:04:03.000000000 +0900
@@ -49,7 +49,6 @@
  * Machine setup..
  */
 
-char ignore_irq13;		/* set if exception 16 works */
 /* cpu data as detected by the assembly code in head.S */
 struct cpuinfo_x86 new_cpu_data __initdata = { 0, 0, 0, 0, -1, 1, 0, 0, -1 };
 /* common cpu data for all cpus */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.60/arch/i386/kernel/traps.c linux98-2.5.60/arch/i386/kernel/traps.c
--- linux-2.5.60/arch/i386/kernel/traps.c	2003-02-11 03:38:01.000000000 +0900
+++ linux98-2.5.60/arch/i386/kernel/traps.c	2003-02-11 09:47:18.000000000 +0900
@@ -57,6 +57,9 @@
 struct desc_struct default_ldt[] = { { 0, 0 }, { 0, 0 }, { 0, 0 },
 		{ 0, 0 }, { 0, 0 } };
 
+/* Do we ignore FPU interrupts ? */
+char ignore_fpu_irq = 0;
+
 /*
  * The IDT has to be page-aligned to simplify the Pentium
  * F0 0F bug workaround.. We have a special link segment
@@ -643,7 +646,7 @@
 
 asmlinkage void do_coprocessor_error(struct pt_regs * regs, long error_code)
 {
-	ignore_irq13 = 1;
+	ignore_fpu_irq = 1;
 	math_error((void *)regs->eip);
 }
 
@@ -700,7 +703,7 @@
 {
 	if (cpu_has_xmm) {
 		/* Handle SIMD FPU exceptions on PIII+ processors. */
-		ignore_irq13 = 1;
+		ignore_fpu_irq = 1;
 		simd_math_error((void *)regs->eip);
 	} else {
 		/*
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.56/arch/i386/kernel/vm86.c linux98-2.5.56/arch/i386/kernel/vm86.c
--- linux-2.5.56/arch/i386/kernel/vm86.c	2003-01-11 05:11:22.000000000 +0900
+++ linux98-2.5.56/arch/i386/kernel/vm86.c	2003-01-11 13:32:25.000000000 +0900
@@ -720,7 +720,7 @@
 void release_x86_irqs(struct task_struct *task)
 {
 	int i;
-	for (i=3; i<16; i++)
+	for (i = FIRST_VM86_IRQ; i <= LAST_VM86_IRQ; i++)
 	    if (vm86_irqs[i].tsk == task)
 		free_vm86_irq(i);
 }
@@ -730,7 +730,7 @@
 	int bit;
 	unsigned long flags;
 	
-	if ( (irqnumber<3) || (irqnumber>15) ) return 0;
+	if (invalid_vm86_irq(irqnumber)) return 0;
 	if (vm86_irqs[irqnumber].tsk != current) return 0;
 	spin_lock_irqsave(&irqbits_lock, flags);	
 	bit = irqbits & (1 << irqnumber);
@@ -755,7 +755,7 @@
 			int irq = irqnumber & 255;
 			if (!capable(CAP_SYS_ADMIN)) return -EPERM;
 			if (!((1 << sig) & ALLOWED_SIGS)) return -EPERM;
-			if ( (irq<3) || (irq>15) ) return -EPERM;
+			if (invalid_vm86_irq(irq)) return -EPERM;
 			if (vm86_irqs[irq].tsk) return -EPERM;
 			ret = request_irq(irq, &irq_handler, 0, VM86_IRQNAME, 0);
 			if (ret) return ret;
@@ -764,7 +764,7 @@
 			return irq;
 		}
 		case  VM86_FREE_IRQ: {
-			if ( (irqnumber<3) || (irqnumber>15) ) return -EPERM;
+			if (invalid_vm86_irq(irqnumber)) return -EPERM;
 			if (!vm86_irqs[irqnumber].tsk) return 0;
 			if (vm86_irqs[irqnumber].tsk != current) return -EPERM;
 			free_vm86_irq(irqnumber);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.50/arch/i386/mach-pc9800/Makefile linux.50-ac1/arch/i386/mach-pc9800/Makefile
--- linux.50/arch/i386/mach-pc9800/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux.50-ac1/arch/i386/mach-pc9800/Makefile	2002-10-31 15:05:52.000000000 +0000
@@ -0,0 +1,15 @@
+#
+# Makefile for the linux kernel.
+#
+# Note! Dependencies are done automagically by 'make dep', which also
+# removes any old dependencies. DON'T put your own dependencies here
+# unless it's something special (ie not a .c file).
+#
+# Note 2! The CFLAGS definitions are now in the main makefile...
+
+EXTRA_CFLAGS	+= -I../kernel
+export-objs     := 
+
+obj-y				:= setup.o
+
+include $(TOPDIR)/Rules.make
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.50/arch/i386/mach-pc9800/setup.c linux.50-ac1/arch/i386/mach-pc9800/setup.c
--- linux.50/arch/i386/mach-pc9800/setup.c	1970-01-01 01:00:00.000000000 +0100
+++ linux.50-ac1/arch/i386/mach-pc9800/setup.c	2002-10-31 15:05:52.000000000 +0000
@@ -0,0 +1,117 @@
+/*
+ *	Machine specific setup for generic
+ */
+
+#include <linux/config.h>
+#include <linux/mm.h>
+#include <linux/smp.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <asm/setup.h>
+#include <asm/arch_hooks.h>
+
+struct sys_desc_table_struct {
+	unsigned short length;
+	unsigned char table[0];
+};
+
+/* Indicates PC-9800 architecture  No:0 Yes:1 */
+extern int pc98;
+
+/**
+ * pre_intr_init_hook - initialisation prior to setting up interrupt vectors
+ *
+ * Description:
+ *	Perform any necessary interrupt initialisation prior to setting up
+ *	the "ordinary" interrupt call gates.  For legacy reasons, the ISA
+ *	interrupts should be initialised here if the machine emulates a PC
+ *	in any way.
+ **/
+void __init pre_intr_init_hook(void)
+{
+	init_ISA_irqs();
+}
+
+/*
+ * IRQ7 is cascade interrupt to second interrupt controller
+ */
+static struct irqaction irq7 = { no_action, 0, 0, "cascade", NULL, NULL};
+
+/**
+ * intr_init_hook - post gate setup interrupt initialisation
+ *
+ * Description:
+ *	Fill in any interrupts that may have been left out by the general
+ *	init_IRQ() routine.  interrupts having to do with the machine rather
+ *	than the devices on the I/O bus (like APIC interrupts in intel MP
+ *	systems) are started here.
+ **/
+void __init intr_init_hook(void)
+{
+#ifdef CONFIG_X86_LOCAL_APIC
+	apic_intr_init();
+#endif
+
+	setup_irq(7, &irq7);
+}
+
+/**
+ * pre_setup_arch_hook - hook called prior to any setup_arch() execution
+ *
+ * Description:
+ *	generally used to activate any machine specific identification
+ *	routines that may be needed before setup_arch() runs.  On VISWS
+ *	this is used to get the board revision and type.
+ **/
+void __init pre_setup_arch_hook(void)
+{
+	SYS_DESC_TABLE.length = 0;
+	MCA_bus = 0;
+	pc98 = 1;
+}
+
+/**
+ * trap_init_hook - initialise system specific traps
+ *
+ * Description:
+ *	Called as the final act of trap_init().  Used in VISWS to initialise
+ *	the various board specific APIC traps.
+ **/
+void __init trap_init_hook(void)
+{
+}
+
+static struct irqaction irq0  = { timer_interrupt, SA_INTERRUPT, 0, "timer", NULL, NULL};
+
+/**
+ * time_init_hook - do any specific initialisations for the system timer.
+ *
+ * Description:
+ *	Must plug the system timer interrupt source at HZ into the IRQ listed
+ *	in irq_vectors.h:TIMER_IRQ
+ **/
+void __init time_init_hook(void)
+{
+	setup_irq(0, &irq0);
+}
+
+#ifdef CONFIG_MCA
+/**
+ * mca_nmi_hook - hook into MCA specific NMI chain
+ *
+ * Description:
+ *	The MCA (Microchannel Arcitecture) has an NMI chain for NMI sources
+ *	along the MCA bus.  Use this to hook into that chain if you will need
+ *	it.
+ **/
+void __init mca_nmi_hook(void)
+{
+	/* If I recall correctly, there's a whole bunch of other things that
+	 * we can do to check for NMI problems, but that's all I know about
+	 * at the moment.
+	 */
+
+	printk("NMI generated from unknown source!\n");
+}
+#endif
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.50/arch/i386/pci/pcbios.c linux.50-ac1/arch/i386/pci/pcbios.c
--- linux.50/arch/i386/pci/pcbios.c	2002-11-25 15:09:13.000000000 +0000
+++ linux.50-ac1/arch/i386/pci/pcbios.c	2002-10-31 15:05:49.000000000 +0000
@@ -5,22 +5,9 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include "pci.h"
+#include "pci-functions.h"
 
 
-#define PCIBIOS_PCI_FUNCTION_ID 	0xb1XX
-#define PCIBIOS_PCI_BIOS_PRESENT 	0xb101
-#define PCIBIOS_FIND_PCI_DEVICE		0xb102
-#define PCIBIOS_FIND_PCI_CLASS_CODE	0xb103
-#define PCIBIOS_GENERATE_SPECIAL_CYCLE	0xb106
-#define PCIBIOS_READ_CONFIG_BYTE	0xb108
-#define PCIBIOS_READ_CONFIG_WORD	0xb109
-#define PCIBIOS_READ_CONFIG_DWORD	0xb10a
-#define PCIBIOS_WRITE_CONFIG_BYTE	0xb10b
-#define PCIBIOS_WRITE_CONFIG_WORD	0xb10c
-#define PCIBIOS_WRITE_CONFIG_DWORD	0xb10d
-#define PCIBIOS_GET_ROUTING_OPTIONS	0xb10e
-#define PCIBIOS_SET_PCI_HW_INT		0xb10f
-
 /* BIOS32 signature: "_32_" */
 #define BIOS32_SIGNATURE	(('_' << 0) + ('3' << 8) + ('2' << 16) + ('_' << 24))
 
