Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267091AbTBQOBI>; Mon, 17 Feb 2003 09:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267083AbTBQOBI>; Mon, 17 Feb 2003 09:01:08 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:20864 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S267097AbTBQN7K>; Mon, 17 Feb 2003 08:59:10 -0500
Date: Mon, 17 Feb 2003 23:07:22 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCHSET] PC-9800 subarch. support for 2.5.61 (8/26) core
Message-ID: <20030217140722.GH4799@yuzuki.cinet.co.jp>
References: <20030217134333.GA4734@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030217134333.GA4734@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patchset to support NEC PC-9800 subarchitecture
against 2.5.61 (8/26).

Core patches for PC98. Big changes using mach-* scheme.
For fix differences of timer, IRQ, IO port assign and memory mappings.

diff -Nru linux-2.5.61/arch/i386/Kconfig linux98-2.5.61/arch/i386/Kconfig
--- linux-2.5.61/arch/i386/Kconfig	2003-02-15 08:51:18.000000000 +0900
+++ linux98-2.5.61/arch/i386/Kconfig	2003-02-15 13:44:30.000000000 +0900
@@ -75,6 +75,12 @@
 
 	  If you don't have one of these computers, you should say N here.
 
+config X86_PC9800
+	bool "PC-9800 (NEC)"
+	help
+	  To make kernel for NEC PC-9801/PC-9821 sub-architecture, say Y.
+	  If say Y, kernel works -ONLY- on PC-9800 architecture.
+
 config X86_BIGSMP
 	bool "Support for other sub-arch SMP systems with more than 8 CPUs"
 	help
@@ -1199,7 +1205,7 @@
 
 config EISA
 	bool "EISA support"
-	depends on ISA
+	depends on ISA && !X86_PC9800
 	---help---
 	  The Extended Industry Standard Architecture (EISA) bus was
 	  developed as an open alternative to the IBM MicroChannel bus.
@@ -1217,7 +1223,7 @@
 
 config MCA
 	bool "MCA support"
-	depends on !(X86_VISWS || X86_VOYAGER)
+	depends on !(X86_VISWS || X86_VOYAGER || X86_PC9800)
 	help
 	  MicroChannel Architecture is found in some IBM PS/2 machines and
 	  laptops.  It is a bus system similar to PCI or ISA. See
diff -Nru linux-2.5.54/arch/i386/kernel/apic.c linux98-2.5.54/arch/i386/kernel/apic.c
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
 
diff -Nru linux-2.5.50/arch/i386/kernel/cpu/proc.c linux98-2.5.50-ac1/arch/i386/kernel/cpu/proc.c
--- linux-2.5.50/arch/i386/kernel/cpu/proc.c	2002-11-25 15:09:12.000000000 +0000
+++ linux98-2.5.50-ac1/arch/i386/kernel/cpu/proc.c	2002-11-17 00:19:07.000000000 +0000
@@ -83,7 +83,7 @@
 #endif
 	
 	/* We use exception 16 if we have hardware math and we've either seen it or the CPU claims it is internal */
-	fpu_exception = c->hard_math && (ignore_irq13 || cpu_has_fpu);
+	fpu_exception = c->hard_math && (ignore_fpu_irq || cpu_has_fpu);
 	seq_printf(m, "fdiv_bug\t: %s\n"
 			"hlt_bug\t\t: %s\n"
 			"f00f_bug\t: %s\n"
diff -Nru linux-2.5.61/arch/i386/kernel/i8259.c linux98-2.5.61/arch/i386/kernel/i8259.c
--- linux-2.5.61/arch/i386/kernel/i8259.c	2003-02-15 08:52:38.000000000 +0900
+++ linux98-2.5.61/arch/i386/kernel/i8259.c	2003-02-16 17:19:03.000000000 +0900
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
+#ifndef CONFIG_X86_PC9800
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
diff -Nru linux-2.5.61/arch/i386/kernel/setup.c linux98-2.5.61/arch/i386/kernel/setup.c
--- linux-2.5.61/arch/i386/kernel/setup.c	2003-02-15 08:51:44.000000000 +0900
+++ linux98-2.5.61/arch/i386/kernel/setup.c	2003-02-16 17:19:03.000000000 +0900
@@ -20,6 +20,7 @@
  * This file handles the architecture-dependent parts of initialization
  */
 
+#include <linux/config.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
 #include <linux/tty.h>
@@ -40,6 +41,7 @@
 #include <asm/setup.h>
 #include <asm/arch_hooks.h>
 #include "setup_arch_pre.h"
+#include "mach_resources.h"
 
 int disable_pse __initdata = 0;
 
@@ -49,7 +51,6 @@
  * Machine setup..
  */
 
-char ignore_irq13;		/* set if exception 16 works */
 /* cpu data as detected by the assembly code in head.S */
 struct cpuinfo_x86 new_cpu_data __initdata = { 0, 0, 0, 0, -1, 1, 0, 0, -1 };
 /* common cpu data for all cpus */
@@ -103,98 +104,8 @@
 static char command_line[COMMAND_LINE_SIZE];
        char saved_command_line[COMMAND_LINE_SIZE];
 
-struct resource standard_io_resources[] = {
-	{ "dma1", 0x00, 0x1f, IORESOURCE_BUSY },
-	{ "pic1", 0x20, 0x3f, IORESOURCE_BUSY },
-	{ "timer", 0x40, 0x5f, IORESOURCE_BUSY },
-	{ "keyboard", 0x60, 0x6f, IORESOURCE_BUSY },
-	{ "dma page reg", 0x80, 0x8f, IORESOURCE_BUSY },
-	{ "pic2", 0xa0, 0xbf, IORESOURCE_BUSY },
-	{ "dma2", 0xc0, 0xdf, IORESOURCE_BUSY },
-	{ "fpu", 0xf0, 0xff, IORESOURCE_BUSY }
-};
-#ifdef CONFIG_MELAN
-standard_io_resources[1] = { "pic1", 0x20, 0x21, IORESOURCE_BUSY };
-standard_io_resources[5] = { "pic2", 0xa0, 0xa1, IORESOURCE_BUSY };
-#endif
-
-#define STANDARD_IO_RESOURCES (sizeof(standard_io_resources)/sizeof(struct resource))
-
 static struct resource code_resource = { "Kernel code", 0x100000, 0 };
 static struct resource data_resource = { "Kernel data", 0, 0 };
-static struct resource vram_resource = { "Video RAM area", 0xa0000, 0xbffff, IORESOURCE_BUSY };
-
-/* System ROM resources */
-#define MAXROMS 6
-static struct resource rom_resources[MAXROMS] = {
-	{ "System ROM", 0xF0000, 0xFFFFF, IORESOURCE_BUSY },
-	{ "Video ROM", 0xc0000, 0xc7fff, IORESOURCE_BUSY }
-};
-
-#define romsignature(x) (*(unsigned short *)(x) == 0xaa55)
-
-static void __init probe_roms(void)
-{
-	int roms = 1;
-	unsigned long base;
-	unsigned char *romstart;
-
-	request_resource(&iomem_resource, rom_resources+0);
-
-	/* Video ROM is standard at C000:0000 - C7FF:0000, check signature */
-	for (base = 0xC0000; base < 0xE0000; base += 2048) {
-		romstart = isa_bus_to_virt(base);
-		if (!romsignature(romstart))
-			continue;
-		request_resource(&iomem_resource, rom_resources + roms);
-		roms++;
-		break;
-	}
-
-	/* Extension roms at C800:0000 - DFFF:0000 */
-	for (base = 0xC8000; base < 0xE0000; base += 2048) {
-		unsigned long length;
-
-		romstart = isa_bus_to_virt(base);
-		if (!romsignature(romstart))
-			continue;
-		length = romstart[2] * 512;
-		if (length) {
-			unsigned int i;
-			unsigned char chksum;
-
-			chksum = 0;
-			for (i = 0; i < length; i++)
-				chksum += romstart[i];
-
-			/* Good checksum? */
-			if (!chksum) {
-				rom_resources[roms].start = base;
-				rom_resources[roms].end = base + length - 1;
-				rom_resources[roms].name = "Extension ROM";
-				rom_resources[roms].flags = IORESOURCE_BUSY;
-
-				request_resource(&iomem_resource, rom_resources + roms);
-				roms++;
-				if (roms >= MAXROMS)
-					return;
-			}
-		}
-	}
-
-	/* Final check for motherboard extension rom at E000:0000 */
-	base = 0xE0000;
-	romstart = isa_bus_to_virt(base);
-
-	if (romsignature(romstart)) {
-		rom_resources[roms].start = base;
-		rom_resources[roms].end = base + 65535;
-		rom_resources[roms].name = "Extension ROM";
-		rom_resources[roms].flags = IORESOURCE_BUSY;
-
-		request_resource(&iomem_resource, rom_resources + roms);
-	}
-}
 
 static void __init limit_regions (unsigned long long size)
 {
@@ -827,11 +738,8 @@
 			request_resource(res, &data_resource);
 		}
 	}
-	request_resource(&iomem_resource, &vram_resource);
 
-	/* request I/O space for devices used on all i[345]86 PCs */
-	for (i = 0; i < STANDARD_IO_RESOURCES; i++)
-		request_resource(&ioport_resource, standard_io_resources+i);
+	mach_request_resource( );
 
 	/* Tell the PCI layer not to allocate too close to the RAM area.. */
 	low_mem_size = ((max_low_pfn << PAGE_SHIFT) + 0xfffff) & ~0xfffff;
@@ -912,6 +820,8 @@
 #ifdef CONFIG_VT
 #if defined(CONFIG_VGA_CONSOLE)
 	conswitchp = &vga_con;
+#elif defined(CONFIG_GDC_CONSOLE)
+	conswitchp = &gdc_con;
 #elif defined(CONFIG_DUMMY_CONSOLE)
 	conswitchp = &dummy_con;
 #endif
diff -Nru linux-2.5.60/arch/i386/kernel/time.c linux98-2.5.60/arch/i386/kernel/time.c
--- linux-2.5.60/arch/i386/kernel/time.c	2003-02-11 03:38:37.000000000 +0900
+++ linux98-2.5.60/arch/i386/kernel/time.c	2003-02-11 10:52:52.000000000 +0900
@@ -55,12 +55,15 @@
 #include <asm/processor.h>
 #include <asm/timer.h>
 
-#include <linux/mc146818rtc.h>
+#include "mach_time.h"
+
 #include <linux/timex.h>
 #include <linux/config.h>
 
 #include <asm/arch_hooks.h>
 
+#include "io_ports.h"
+
 extern spinlock_t i8259A_lock;
 int pit_latch_buggy;              /* extern */
 
@@ -137,69 +140,13 @@
 	write_sequnlock_irq(&xtime_lock);
 }
 
-/*
- * In order to set the CMOS clock precisely, set_rtc_mmss has to be
- * called 500 ms after the second nowtime has started, because when
- * nowtime is written into the registers of the CMOS clock, it will
- * jump to the next second precisely 500 ms later. Check the Motorola
- * MC146818A or Dallas DS12887 data sheet for details.
- *
- * BUG: This routine does not handle hour overflow properly; it just
- *      sets the minutes. Usually you'll only notice that after reboot!
- */
 static int set_rtc_mmss(unsigned long nowtime)
 {
-	int retval = 0;
-	int real_seconds, real_minutes, cmos_minutes;
-	unsigned char save_control, save_freq_select;
+	int retval;
 
 	/* gets recalled with irq locally disabled */
 	spin_lock(&rtc_lock);
-	save_control = CMOS_READ(RTC_CONTROL); /* tell the clock it's being set */
-	CMOS_WRITE((save_control|RTC_SET), RTC_CONTROL);
-
-	save_freq_select = CMOS_READ(RTC_FREQ_SELECT); /* stop and reset prescaler */
-	CMOS_WRITE((save_freq_select|RTC_DIV_RESET2), RTC_FREQ_SELECT);
-
-	cmos_minutes = CMOS_READ(RTC_MINUTES);
-	if (!(save_control & RTC_DM_BINARY) || RTC_ALWAYS_BCD)
-		BCD_TO_BIN(cmos_minutes);
-
-	/*
-	 * since we're only adjusting minutes and seconds,
-	 * don't interfere with hour overflow. This avoids
-	 * messing with unknown time zones but requires your
-	 * RTC not to be off by more than 15 minutes
-	 */
-	real_seconds = nowtime % 60;
-	real_minutes = nowtime / 60;
-	if (((abs(real_minutes - cmos_minutes) + 15)/30) & 1)
-		real_minutes += 30;		/* correct for half hour time zone */
-	real_minutes %= 60;
-
-	if (abs(real_minutes - cmos_minutes) < 30) {
-		if (!(save_control & RTC_DM_BINARY) || RTC_ALWAYS_BCD) {
-			BIN_TO_BCD(real_seconds);
-			BIN_TO_BCD(real_minutes);
-		}
-		CMOS_WRITE(real_seconds,RTC_SECONDS);
-		CMOS_WRITE(real_minutes,RTC_MINUTES);
-	} else {
-		printk(KERN_WARNING
-		       "set_rtc_mmss: can't update from %d to %d\n",
-		       cmos_minutes, real_minutes);
-		retval = -1;
-	}
-
-	/* The following flags have to be released exactly in this order,
-	 * otherwise the DS12887 (popular MC146818A clone with integrated
-	 * battery and quartz) will not reset the oscillator and will not
-	 * update precisely 500 ms later. You won't find this mentioned in
-	 * the Dallas Semiconductor data sheets, but who believes data
-	 * sheets anyway ...                           -- Markus Kuhn
-	 */
-	CMOS_WRITE(save_control, RTC_CONTROL);
-	CMOS_WRITE(save_freq_select, RTC_FREQ_SELECT);
+	retval = mach_set_rtc_mmss(nowtime);
 	spin_unlock(&rtc_lock);
 
 	return retval;
@@ -225,9 +172,9 @@
 		 * on an 82489DX-based system.
 		 */
 		spin_lock(&i8259A_lock);
-		outb(0x0c, 0x20);
+		outb(0x0c, PIC_MASTER_OCW3);
 		/* Ack the IRQ; AEOI will end it automatically. */
-		inb(0x20);
+		inb(PIC_MASTER_POLL);
 		spin_unlock(&i8259A_lock);
 	}
 #endif
@@ -241,14 +188,14 @@
 	 */
 	if ((time_status & STA_UNSYNC) == 0 &&
 	    xtime.tv_sec > last_rtc_update + 660 &&
-	    (xtime.tv_nsec / 1000) >= 500000 - ((unsigned) TICK_SIZE) / 2 &&
-	    (xtime.tv_nsec / 1000) <= 500000 + ((unsigned) TICK_SIZE) / 2) {
+	    (xtime.tv_nsec / 1000) >= TIME1 - ((unsigned) TICK_SIZE) / 2 &&
+	    (xtime.tv_nsec / 1000) <= TIME2 + ((unsigned) TICK_SIZE) / 2) {
 		if (set_rtc_mmss(xtime.tv_sec) == 0)
 			last_rtc_update = xtime.tv_sec;
 		else
 			last_rtc_update = xtime.tv_sec - 600; /* do it again in 60 s */
 	}
-	    
+
 #ifdef CONFIG_MCA
 	if( MCA_bus ) {
 		/* The PS/2 uses level-triggered interrupts.  You can't
@@ -329,43 +276,15 @@
 /* not static: needed by APM */
 unsigned long get_cmos_time(void)
 {
-	unsigned int year, mon, day, hour, min, sec;
-	int i;
+	unsigned long retval;
 
 	spin_lock(&rtc_lock);
-	/* The Linux interpretation of the CMOS clock register contents:
-	 * When the Update-In-Progress (UIP) flag goes from 1 to 0, the
-	 * RTC registers show the second which has precisely just started.
-	 * Let's hope other operating systems interpret the RTC the same way.
-	 */
-	/* read RTC exactly on falling edge of update flag */
-	for (i = 0 ; i < 1000000 ; i++)	/* may take up to 1 second... */
-		if (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP)
-			break;
-	for (i = 0 ; i < 1000000 ; i++)	/* must try at least 2.228 ms */
-		if (!(CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP))
-			break;
-	do { /* Isn't this overkill ? UIP above should guarantee consistency */
-		sec = CMOS_READ(RTC_SECONDS);
-		min = CMOS_READ(RTC_MINUTES);
-		hour = CMOS_READ(RTC_HOURS);
-		day = CMOS_READ(RTC_DAY_OF_MONTH);
-		mon = CMOS_READ(RTC_MONTH);
-		year = CMOS_READ(RTC_YEAR);
-	} while (sec != CMOS_READ(RTC_SECONDS));
-	if (!(CMOS_READ(RTC_CONTROL) & RTC_DM_BINARY) || RTC_ALWAYS_BCD)
-	  {
-	    BCD_TO_BIN(sec);
-	    BCD_TO_BIN(min);
-	    BCD_TO_BIN(hour);
-	    BCD_TO_BIN(day);
-	    BCD_TO_BIN(mon);
-	    BCD_TO_BIN(year);
-	  }
+
+	retval = mach_get_cmos_time();
+
 	spin_unlock(&rtc_lock);
-	if ((year += 1900) < 1970)
-		year += 100;
-	return mktime(year, mon, day, hour, min, sec);
+
+	return retval;
 }
 
 /* XXX this driverfs stuff should probably go elsewhere later -john */
diff -Nru linux-2.5.60/arch/i386/kernel/timers/timer_pit.c linux98-2.5.60/arch/i386/kernel/timers/timer_pit.c
--- linux-2.5.60/arch/i386/kernel/timers/timer_pit.c	2003-02-11 03:38:51.000000000 +0900
+++ linux98-2.5.60/arch/i386/kernel/timers/timer_pit.c	2003-02-11 11:15:22.000000000 +0900
@@ -16,6 +16,7 @@
 extern spinlock_t i8259A_lock;
 extern spinlock_t i8253_lock;
 #include "do_timer.h"
+#include "io_ports.h"
 
 static int init_pit(void)
 {
@@ -77,7 +78,8 @@
 {
 	int count;
 	unsigned long flags;
-	static int count_p = LATCH;    /* for the first call after boot */
+	static int count_p;
+	static int is_1st_boot = 1;    /* for the first call after boot */
 	static unsigned long jiffies_p = 0;
 
 	/*
@@ -85,11 +87,17 @@
 	 */
 	unsigned long jiffies_t;
 
+	/* for support LATCH is not constant */
+	if (is_1st_boot) {
+		is_1st_boot = 0;
+		count_p = LATCH;
+	}
+
 	spin_lock_irqsave(&i8253_lock, flags);
 	/* timer count may underflow right here */
-	outb_p(0x00, 0x43);	/* latch the count ASAP */
+	outb_p(0x00, PIT_MODE);	/* latch the count ASAP */
 
-	count = inb_p(0x40);	/* read the latched count */
+	count = inb_p(PIT_CH0);	/* read the latched count */
 
 	/*
 	 * We do this guaranteed double memory access instead of a _p 
@@ -97,13 +105,13 @@
 	 */
  	jiffies_t = jiffies;
 
-	count |= inb_p(0x40) << 8;
+	count |= inb_p(PIT_CH0) << 8;
 	
         /* VIA686a test code... reset the latch if count > max + 1 */
         if (count > LATCH) {
-                outb_p(0x34, 0x43);
-                outb_p(LATCH & 0xff, 0x40);
-                outb(LATCH >> 8, 0x40);
+                outb_p(0x34, PIT_MODE);
+                outb_p(LATCH & 0xff, PIT_CH0);
+                outb(LATCH >> 8, PIT_CH0);
                 count = LATCH - 1;
         }
 	
diff -Nru linux-2.5.61/arch/i386/kernel/timers/timer_tsc.c linux98-2.5.61/arch/i386/kernel/timers/timer_tsc.c
--- linux-2.5.61/arch/i386/kernel/timers/timer_tsc.c	2003-02-15 08:52:04.000000000 +0900
+++ linux98-2.5.61/arch/i386/kernel/timers/timer_tsc.c	2003-02-15 14:13:41.000000000 +0900
@@ -14,6 +14,9 @@
 /* processor.h for distable_tsc flag */
 #include <asm/processor.h>
 
+#include "io_ports.h"
+#include "calibrate_tsc.h"
+
 int tsc_disable __initdata = 0;
 
 extern spinlock_t i8253_lock;
@@ -22,8 +25,6 @@
 /* Number of usecs that the last interrupt was delayed */
 static int delay_at_last_interrupt;
 
-static unsigned long last_tsc_low; /* lsb 32 bits of Time Stamp Counter */
-
 /* Cached *multiplier* to convert TSC counts to microseconds.
  * (see the equation below).
  * Equal to 2^32 * (1 / (clocks per usec) ).
@@ -64,7 +65,12 @@
 {
 	int count;
 	int countmp;
-	static int count1=0, count2=LATCH;
+	static int count1=0, count2, initialize = 1;
+
+	if (initialize) {
+		count2 = LATCH;
+		initialize = 0;
+	}
 	/*
 	 * It is important that these two operations happen almost at
 	 * the same time. We do the RDTSC stuff first, since it's
@@ -82,10 +88,10 @@
 	rdtscl(last_tsc_low);
 
 	spin_lock(&i8253_lock);
-	outb_p(0x00, 0x43);     /* latch the count ASAP */
+	outb_p(0x00, PIT_MODE);     /* latch the count ASAP */
 
-	count = inb_p(0x40);    /* read the latched count */
-	count |= inb(0x40) << 8;
+	count = inb_p(PIT_CH0);    /* read the latched count */
+	count |= inb(PIT_CH0) << 8;
 	spin_unlock(&i8253_lock);
 
 	if (pit_latch_buggy) {
@@ -118,83 +124,9 @@
 	} while ((now-bclock) < loops);
 }
 
-/* ------ Calibrate the TSC ------- 
- * Return 2^32 * (1 / (TSC clocks per usec)) for do_fast_gettimeoffset().
- * Too much 64-bit arithmetic here to do this cleanly in C, and for
- * accuracy's sake we want to keep the overhead on the CTC speaker (channel 2)
- * output busy loop as low as possible. We avoid reading the CTC registers
- * directly because of the awkward 8-bit access mechanism of the 82C54
- * device.
- */
-
-#define CALIBRATE_LATCH	(5 * LATCH)
-#define CALIBRATE_TIME	(5 * 1000020/HZ)
-
 unsigned long __init calibrate_tsc(void)
 {
-       /* Set the Gate high, disable speaker */
-	outb((inb(0x61) & ~0x02) | 0x01, 0x61);
-
-	/*
-	 * Now let's take care of CTC channel 2
-	 *
-	 * Set the Gate high, program CTC channel 2 for mode 0,
-	 * (interrupt on terminal count mode), binary count,
-	 * load 5 * LATCH count, (LSB and MSB) to begin countdown.
-	 *
-	 * Some devices need a delay here.
-	 */
-	outb(0xb0, 0x43);			/* binary, mode 0, LSB/MSB, Ch 2 */
-	outb_p(CALIBRATE_LATCH & 0xff, 0x42);	/* LSB of count */
-	outb_p(CALIBRATE_LATCH >> 8, 0x42);       /* MSB of count */
-
-	{
-		unsigned long startlow, starthigh;
-		unsigned long endlow, endhigh;
-		unsigned long count;
-
-		rdtsc(startlow,starthigh);
-		count = 0;
-		do {
-			count++;
-		} while ((inb(0x61) & 0x20) == 0);
-		rdtsc(endlow,endhigh);
-
-		last_tsc_low = endlow;
-
-		/* Error: ECTCNEVERSET */
-		if (count <= 1)
-			goto bad_ctc;
-
-		/* 64-bit subtract - gcc just messes up with long longs */
-		__asm__("subl %2,%0\n\t"
-			"sbbl %3,%1"
-			:"=a" (endlow), "=d" (endhigh)
-			:"g" (startlow), "g" (starthigh),
-			 "0" (endlow), "1" (endhigh));
-
-		/* Error: ECPUTOOFAST */
-		if (endhigh)
-			goto bad_ctc;
-
-		/* Error: ECPUTOOSLOW */
-		if (endlow <= CALIBRATE_TIME)
-			goto bad_ctc;
-
-		__asm__("divl %2"
-			:"=a" (endlow), "=d" (endhigh)
-			:"r" (endlow), "0" (0), "1" (CALIBRATE_TIME));
-
-		return endlow;
-	}
-
-	/*
-	 * The CTC wasn't reliable: we got a hit on the very first read,
-	 * or the CPU was so fast/slow that the quotient wouldn't fit in
-	 * 32 bits..
-	 */
-bad_ctc:
-	return 0;
+	return mach_calibrate_tsc();
 }
 
 
diff -Nru linux-2.5.61/arch/i386/kernel/traps.c linux98-2.5.61/arch/i386/kernel/traps.c
--- linux-2.5.61/arch/i386/kernel/traps.c	2003-02-15 08:51:19.000000000 +0900
+++ linux98-2.5.61/arch/i386/kernel/traps.c	2003-02-16 17:19:03.000000000 +0900
@@ -50,6 +50,8 @@
 #include <linux/irq.h>
 #include <linux/module.h>
 
+#include "mach_traps.h"
+
 asmlinkage int system_call(void);
 asmlinkage void lcall7(void);
 asmlinkage void lcall27(void);
@@ -57,6 +59,9 @@
 struct desc_struct default_ldt[] = { { 0, 0 }, { 0, 0 }, { 0, 0 },
 		{ 0, 0 }, { 0, 0 } };
 
+/* Do we ignore FPU interrupts ? */
+char ignore_fpu_irq = 0;
+
 /*
  * The IDT has to be page-aligned to simplify the Pentium
  * F0 0F bug workaround.. We have a special link segment
@@ -384,8 +389,7 @@
 	printk("You probably have a hardware problem with your RAM chips\n");
 
 	/* Clear and disable the memory parity error line. */
-	reason = (reason & 0xf) | 4;
-	outb(reason, 0x61);
+	clear_mem_error(reason);
 }
 
 static void io_check_error(unsigned char reason, struct pt_regs * regs)
@@ -422,7 +426,7 @@
 
 static void default_do_nmi(struct pt_regs * regs)
 {
-	unsigned char reason = inb(0x61);
+	unsigned char reason = get_nmi_reason();
  
 	if (!(reason & 0xc0)) {
 #if CONFIG_X86_LOCAL_APIC
@@ -446,10 +450,7 @@
 	 * Reassert NMI in case it became active meanwhile
 	 * as it's edge-triggered.
 	 */
-	outb(0x8f, 0x70);
-	inb(0x71);		/* dummy */
-	outb(0x0f, 0x70);
-	inb(0x71);		/* dummy */
+	reassert_nmi();
 }
 
 static int dummy_nmi_callback(struct pt_regs * regs, int cpu)
@@ -643,7 +644,7 @@
 
 asmlinkage void do_coprocessor_error(struct pt_regs * regs, long error_code)
 {
-	ignore_irq13 = 1;
+	ignore_fpu_irq = 1;
 	math_error((void *)regs->eip);
 }
 
@@ -700,7 +701,7 @@
 {
 	if (cpu_has_xmm) {
 		/* Handle SIMD FPU exceptions on PIII+ processors. */
-		ignore_irq13 = 1;
+		ignore_fpu_irq = 1;
 		simd_math_error((void *)regs->eip);
 	} else {
 		/*
diff -Nru linux-2.5.56/arch/i386/kernel/vm86.c linux98-2.5.56/arch/i386/kernel/vm86.c
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
This is patchset to support NEC PC-9800 subarchitecture
against 2.5.60 (6/34).

   PC98 support patch in 2.5.50-ac1 with minimum changes
   to apply 2.5.60. (include/*)

diff -Nru linux/include/asm-i386/mach-default/calibrate_tsc.h linux98/include/asm-i386/mach-default/calibrate_tsc.h
--- linux/include/asm-i386/mach-default/calibrate_tsc.h	1970-01-01 09:00:00.000000000 +0900
+++ linux98/include/asm-i386/mach-default/calibrate_tsc.h	2002-11-05 22:15:11.000000000 +0900
@@ -0,0 +1,90 @@
+/*
+ *  include/asm-i386/mach-default/calibrate_tsc.h
+ *
+ *  Machine specific calibrate_tsc() for generic.
+ *  Split out from timer_tsc.c by Osamu Tomita <tomita@cinet.co.jp>
+ */
+/* ------ Calibrate the TSC ------- 
+ * Return 2^32 * (1 / (TSC clocks per usec)) for do_fast_gettimeoffset().
+ * Too much 64-bit arithmetic here to do this cleanly in C, and for
+ * accuracy's sake we want to keep the overhead on the CTC speaker (channel 2)
+ * output busy loop as low as possible. We avoid reading the CTC registers
+ * directly because of the awkward 8-bit access mechanism of the 82C54
+ * device.
+ */
+#ifndef _MACH_CALIBRATE_TSC_H
+#define _MACH_CALIBRATE_TSC_H
+
+#define CALIBRATE_LATCH	(5 * LATCH)
+#define CALIBRATE_TIME	(5 * 1000020/HZ)
+
+static unsigned long last_tsc_low; /* lsb 32 bits of Time Stamp Counter */
+
+static inline unsigned long mach_calibrate_tsc(void)
+{
+       /* Set the Gate high, disable speaker */
+	outb((inb(0x61) & ~0x02) | 0x01, 0x61);
+
+	/*
+	 * Now let's take care of CTC channel 2
+	 *
+	 * Set the Gate high, program CTC channel 2 for mode 0,
+	 * (interrupt on terminal count mode), binary count,
+	 * load 5 * LATCH count, (LSB and MSB) to begin countdown.
+	 *
+	 * Some devices need a delay here.
+	 */
+	outb(0xb0, PIT_MODE);			/* binary, mode 0, LSB/MSB, Ch 2 */
+	outb(CALIBRATE_LATCH & 0xff, PIT_CH2);	/* LSB of count */
+	outb(CALIBRATE_LATCH >> 8, PIT_CH2);	/* MSB of count */
+
+	{
+		unsigned long startlow, starthigh;
+		unsigned long endlow, endhigh;
+		unsigned long count;
+
+		rdtsc(startlow,starthigh);
+		count = 0;
+		do {
+			count++;
+		} while ((inb(0x61) & 0x20) == 0);
+		rdtsc(endlow,endhigh);
+
+		last_tsc_low = endlow;
+
+		/* Error: ECTCNEVERSET */
+		if (count <= 1)
+			goto bad_ctc;
+
+		/* 64-bit subtract - gcc just messes up with long longs */
+		__asm__("subl %2,%0\n\t"
+			"sbbl %3,%1"
+			:"=a" (endlow), "=d" (endhigh)
+			:"g" (startlow), "g" (starthigh),
+			 "0" (endlow), "1" (endhigh));
+
+		/* Error: ECPUTOOFAST */
+		if (endhigh)
+			goto bad_ctc;
+
+		/* Error: ECPUTOOSLOW */
+		if (endlow <= CALIBRATE_TIME)
+			goto bad_ctc;
+
+		__asm__("divl %2"
+			:"=a" (endlow), "=d" (endhigh)
+			:"r" (endlow), "0" (0), "1" (CALIBRATE_TIME));
+
+		return endlow;
+	}
+
+	/*
+	 * The CTC wasn't reliable: we got a hit on the very first read,
+	 * or the CPU was so fast/slow that the quotient wouldn't fit in
+	 * 32 bits..
+	 */
+bad_ctc:
+	return 0;
+}
+
+#endif /* !_MACH_CALIBRATE_TSC_H */
diff -Nru linux-2.5.53/include/asm-i386/mach-default/io_ports.h linux98-2.5.53/include/asm-i386/mach-default/io_ports.h
--- linux-2.5.53/include/asm-i386/mach-default/io_ports.h	1970-01-01 01:00:00.000000000 +0100
+++ linux98-2.5.53/include/asm-i386/mach-default/io_ports.h	2002-10-31 15:05:52.000000000 +0000
@@ -0,0 +1,30 @@
+/*
+ *  arch/i386/mach-generic/io_ports.h
+ *
+ *  Machine specific IO port address definition for generic.
+ *  Written by Osamu Tomita <tomita@cinet.co.jp>
+ */
+#ifndef _MACH_IO_PORTS_H
+#define _MACH_IO_PORTS_H
+
+/* i8253A PIT registers */
+#define PIT_MODE		0x43
+#define PIT_CH0			0x40
+#define PIT_CH2			0x42
+
+/* i8259A PIC registers */
+#define PIC_MASTER_CMD		0x20
+#define PIC_MASTER_IMR		0x21
+#define PIC_MASTER_ISR		PIC_MASTER_CMD
+#define PIC_MASTER_POLL		PIC_MASTER_ISR
+#define PIC_MASTER_OCW3		PIC_MASTER_ISR
+#define PIC_SLAVE_CMD		0xa0
+#define PIC_SLAVE_IMR		0xa1
+
+/* i8259A PIC related value */
+#define PIC_CASCADE_IR		2
+#define MASTER_ICW4_DEFAULT	0x01
+#define SLAVE_ICW4_DEFAULT	0x01
+#define PIC_ICW4_AEOI		2
+
+#endif /* !_MACH_IO_PORTS_H */
diff -Nru linux-2.5.53/include/asm-i386/mach-default/irq_vectors.h linux98-2.5.53/include/asm-i386/mach-default/irq_vectors.h
--- linux-2.5.53/include/asm-i386/mach-default/irq_vectors.h	2002-11-25 15:09:13.000000000 +0000
+++ linux98-2.5.53/include/asm-i386/mach-default/irq_vectors.h	2002-10-31 15:05:52.000000000 +0000
@@ -82,4 +82,11 @@
 #define NR_IRQS 16
 #endif
 
+#define FPU_IRQ			13
+
+#define	FIRST_VM86_IRQ		3
+#define LAST_VM86_IRQ		15
+#define invalid_vm86_irq(irq)	((irq) < 3 || (irq) > 15)
+
+
 #endif /* _ASM_IRQ_VECTORS_H */
diff -Nru linux/include/asm-i386/mach-default/mach_resources.h linux98/include/asm-i386/mach-default/mach_resources.h
--- linux/include/asm-i386/mach-default/mach_resources.h	1970-01-01 09:00:00.000000000 +0900
+++ linux98/include/asm-i386/mach-default/mach_resources.h	2002-10-21 09:59:22.000000000 +0900
@@ -0,0 +1,113 @@
+/*
+ *  include/asm-i386/mach-default/mach_resources.h
+ *
+ *  Machine specific resource allocation for generic.
+ *  Split out from setup.c by Osamu Tomita <tomita@cinet.co.jp>
+ */
+#ifndef _MACH_RESOURCES_H
+#define _MACH_RESOURCES_H
+
+struct resource standard_io_resources[] = {
+	{ "dma1", 0x00, 0x1f, IORESOURCE_BUSY },
+	{ "pic1", 0x20, 0x3f, IORESOURCE_BUSY },
+	{ "timer", 0x40, 0x5f, IORESOURCE_BUSY },
+	{ "keyboard", 0x60, 0x6f, IORESOURCE_BUSY },
+	{ "dma page reg", 0x80, 0x8f, IORESOURCE_BUSY },
+	{ "pic2", 0xa0, 0xbf, IORESOURCE_BUSY },
+	{ "dma2", 0xc0, 0xdf, IORESOURCE_BUSY },
+	{ "fpu", 0xf0, 0xff, IORESOURCE_BUSY }
+};
+#ifdef CONFIG_MELAN
+standard_io_resources[1] = { "pic1", 0x20, 0x21, IORESOURCE_BUSY };
+standard_io_resources[5] = { "pic2", 0xa0, 0xa1, IORESOURCE_BUSY };
+#endif
+
+#define STANDARD_IO_RESOURCES (sizeof(standard_io_resources)/sizeof(struct resource))
+
+static struct resource vram_resource = { "Video RAM area", 0xa0000, 0xbffff, IORESOURCE_BUSY };
+
+/* System ROM resources */
+#define MAXROMS 6
+static struct resource rom_resources[MAXROMS] = {
+	{ "System ROM", 0xF0000, 0xFFFFF, IORESOURCE_BUSY },
+	{ "Video ROM", 0xc0000, 0xc7fff, IORESOURCE_BUSY }
+};
+
+#define romsignature(x) (*(unsigned short *)(x) == 0xaa55)
+
+static inline void probe_roms(void)
+{
+	int roms = 1;
+	unsigned long base;
+	unsigned char *romstart;
+
+	request_resource(&iomem_resource, rom_resources+0);
+
+	/* Video ROM is standard at C000:0000 - C7FF:0000, check signature */
+	for (base = 0xC0000; base < 0xE0000; base += 2048) {
+		romstart = isa_bus_to_virt(base);
+		if (!romsignature(romstart))
+			continue;
+		request_resource(&iomem_resource, rom_resources + roms);
+		roms++;
+		break;
+	}
+
+	/* Extension roms at C800:0000 - DFFF:0000 */
+	for (base = 0xC8000; base < 0xE0000; base += 2048) {
+		unsigned long length;
+
+		romstart = isa_bus_to_virt(base);
+		if (!romsignature(romstart))
+			continue;
+		length = romstart[2] * 512;
+		if (length) {
+			unsigned int i;
+			unsigned char chksum;
+
+			chksum = 0;
+			for (i = 0; i < length; i++)
+				chksum += romstart[i];
+
+			/* Good checksum? */
+			if (!chksum) {
+				rom_resources[roms].start = base;
+				rom_resources[roms].end = base + length - 1;
+				rom_resources[roms].name = "Extension ROM";
+				rom_resources[roms].flags = IORESOURCE_BUSY;
+
+				request_resource(&iomem_resource, rom_resources + roms);
+				roms++;
+				if (roms >= MAXROMS)
+					return;
+			}
+		}
+	}
+
+	/* Final check for motherboard extension rom at E000:0000 */
+	base = 0xE0000;
+	romstart = isa_bus_to_virt(base);
+
+	if (romsignature(romstart)) {
+		rom_resources[roms].start = base;
+		rom_resources[roms].end = base + 65535;
+		rom_resources[roms].name = "Extension ROM";
+		rom_resources[roms].flags = IORESOURCE_BUSY;
+
+		request_resource(&iomem_resource, rom_resources + roms);
+	}
+}
+
+static inline void mach_request_resource(void)
+{
+	int i;
+
+	request_resource(&iomem_resource, &vram_resource);
+
+	/* request I/O space for devices used on all i[345]86 PCs */
+	for (i = 0; i < STANDARD_IO_RESOURCES; i++)
+		request_resource(&ioport_resource, standard_io_resources+i);
+
+}
+
+#endif /* !_MACH_RESOURCES_H */
diff -Nru linux/include/asm-i386/mach-default/mach_time.h linux98/include/asm-i386/mach-default/mach_time.h
--- linux/include/asm-i386/mach-default/mach_time.h	1970-01-01 09:00:00.000000000 +0900
+++ linux98/include/asm-i386/mach-default/mach_time.h	2002-10-21 10:07:35.000000000 +0900
@@ -0,0 +1,122 @@
+/*
+ *  include/asm-i386/mach-default/mach_time.h
+ *
+ *  Machine specific set RTC function for generic.
+ *  Split out from time.c by Osamu Tomita <tomita@cinet.co.jp>
+ */
+#ifndef _MACH_TIME_H
+#define _MACH_TIME_H
+
+#include <linux/mc146818rtc.h>
+
+/* for check timing call set_rtc_mmss() 500ms     */
+/* used in arch/i386/time.c::do_timer_interrupt() */
+#define TIME1	500000
+#define TIME2	500000
+
+/*
+ * In order to set the CMOS clock precisely, set_rtc_mmss has to be
+ * called 500 ms after the second nowtime has started, because when
+ * nowtime is written into the registers of the CMOS clock, it will
+ * jump to the next second precisely 500 ms later. Check the Motorola
+ * MC146818A or Dallas DS12887 data sheet for details.
+ *
+ * BUG: This routine does not handle hour overflow properly; it just
+ *      sets the minutes. Usually you'll only notice that after reboot!
+ */
+static inline int mach_set_rtc_mmss(unsigned long nowtime)
+{
+	int retval = 0;
+	int real_seconds, real_minutes, cmos_minutes;
+	unsigned char save_control, save_freq_select;
+
+	save_control = CMOS_READ(RTC_CONTROL); /* tell the clock it's being set */
+	CMOS_WRITE((save_control|RTC_SET), RTC_CONTROL);
+
+	save_freq_select = CMOS_READ(RTC_FREQ_SELECT); /* stop and reset prescaler */
+	CMOS_WRITE((save_freq_select|RTC_DIV_RESET2), RTC_FREQ_SELECT);
+
+	cmos_minutes = CMOS_READ(RTC_MINUTES);
+	if (!(save_control & RTC_DM_BINARY) || RTC_ALWAYS_BCD)
+		BCD_TO_BIN(cmos_minutes);
+
+	/*
+	 * since we're only adjusting minutes and seconds,
+	 * don't interfere with hour overflow. This avoids
+	 * messing with unknown time zones but requires your
+	 * RTC not to be off by more than 15 minutes
+	 */
+	real_seconds = nowtime % 60;
+	real_minutes = nowtime / 60;
+	if (((abs(real_minutes - cmos_minutes) + 15)/30) & 1)
+		real_minutes += 30;		/* correct for half hour time zone */
+	real_minutes %= 60;
+
+	if (abs(real_minutes - cmos_minutes) < 30) {
+		if (!(save_control & RTC_DM_BINARY) || RTC_ALWAYS_BCD) {
+			BIN_TO_BCD(real_seconds);
+			BIN_TO_BCD(real_minutes);
+		}
+		CMOS_WRITE(real_seconds,RTC_SECONDS);
+		CMOS_WRITE(real_minutes,RTC_MINUTES);
+	} else {
+		printk(KERN_WARNING
+		       "set_rtc_mmss: can't update from %d to %d\n",
+		       cmos_minutes, real_minutes);
+		retval = -1;
+	}
+
+	/* The following flags have to be released exactly in this order,
+	 * otherwise the DS12887 (popular MC146818A clone with integrated
+	 * battery and quartz) will not reset the oscillator and will not
+	 * update precisely 500 ms later. You won't find this mentioned in
+	 * the Dallas Semiconductor data sheets, but who believes data
+	 * sheets anyway ...                           -- Markus Kuhn
+	 */
+	CMOS_WRITE(save_control, RTC_CONTROL);
+	CMOS_WRITE(save_freq_select, RTC_FREQ_SELECT);
+
+	return retval;
+}
+
+static inline unsigned long mach_get_cmos_time(void)
+{
+	unsigned int year, mon, day, hour, min, sec;
+	int i;
+
+	/* The Linux interpretation of the CMOS clock register contents:
+	 * When the Update-In-Progress (UIP) flag goes from 1 to 0, the
+	 * RTC registers show the second which has precisely just started.
+	 * Let's hope other operating systems interpret the RTC the same way.
+	 */
+	/* read RTC exactly on falling edge of update flag */
+	for (i = 0 ; i < 1000000 ; i++)	/* may take up to 1 second... */
+		if (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP)
+			break;
+	for (i = 0 ; i < 1000000 ; i++)	/* must try at least 2.228 ms */
+		if (!(CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP))
+			break;
+	do { /* Isn't this overkill ? UIP above should guarantee consistency */
+		sec = CMOS_READ(RTC_SECONDS);
+		min = CMOS_READ(RTC_MINUTES);
+		hour = CMOS_READ(RTC_HOURS);
+		day = CMOS_READ(RTC_DAY_OF_MONTH);
+		mon = CMOS_READ(RTC_MONTH);
+		year = CMOS_READ(RTC_YEAR);
+	} while (sec != CMOS_READ(RTC_SECONDS));
+	if (!(CMOS_READ(RTC_CONTROL) & RTC_DM_BINARY) || RTC_ALWAYS_BCD)
+	  {
+	    BCD_TO_BIN(sec);
+	    BCD_TO_BIN(min);
+	    BCD_TO_BIN(hour);
+	    BCD_TO_BIN(day);
+	    BCD_TO_BIN(mon);
+	    BCD_TO_BIN(year);
+	  }
+	if ((year += 1900) < 1970)
+		year += 100;
+
+	return mktime(year, mon, day, hour, min, sec);
+}
+
+#endif /* !_MACH_TIME_H */
diff -Nru linux/include/asm-i386/mach-default/mach_traps.h linux98/include/asm-i386/mach-default/mach_traps.h
--- linux/include/asm-i386/mach-default/mach_traps.h	1970-01-01 09:00:00.000000000 +0900
+++ linux98/include/asm-i386/mach-default/mach_traps.h	2002-11-05 22:42:05.000000000 +0900
@@ -0,0 +1,29 @@
+/*
+ *  include/asm-i386/mach-default/mach_traps.h
+ *
+ *  Machine specific NMI handling for generic.
+ *  Split out from traps.c by Osamu Tomita <tomita@cinet.co.jp>
+ */
+#ifndef _MACH_TRAPS_H
+#define _MACH_TRAPS_H
+
+static inline void clear_mem_error(unsigned char reason)
+{
+	reason = (reason & 0xf) | 4;
+	outb(reason, 0x61);
+}
+
+static inline unsigned char get_nmi_reason(void)
+{
+	return inb(0x61);
+}
+
+static inline void reassert_nmi(void)
+{
+	outb(0x8f, 0x70);
+	inb(0x71);		/* dummy */
+	outb(0x0f, 0x70);
+	inb(0x71);		/* dummy */
+}
+
+#endif /* !_MACH_TRAPS_H */
diff -Nru linux/include/asm-i386/mach-pc9800/calibrate_tsc.h linux98/include/asm-i386/mach-pc9800/calibrate_tsc.h
--- linux/include/asm-i386/mach-pc9800/calibrate_tsc.h	1970-01-01 09:00:00.000000000 +0900
+++ linux98/include/asm-i386/mach-pc9800/calibrate_tsc.h	2002-11-05 22:19:50.000000000 +0900
@@ -0,0 +1,71 @@
+/*
+ *  include/asm-i386/mach-pc9800/calibrate_tsc.h
+ *
+ *  Machine specific calibrate_tsc() for PC-9800.
+ *  Written by Osamu Tomita <tomita@cinet.co.jp>
+ */
+
+/* ------ Calibrate the TSC ------- 
+ * Return 2^32 * (1 / (TSC clocks per usec)) for do_fast_gettimeoffset().
+ * Too much 64-bit arithmetic here to do this cleanly in C.
+ * PC-9800:
+ *  CTC cannot be used because some models (especially
+ *  note-machines) may disable clock to speaker channel (#1)
+ *  unless speaker is enabled.  We use ARTIC instead.
+ */
+#ifndef _MACH_CALIBRATE_TSC_H
+#define _MACH_CALIBRATE_TSC_H
+
+#define CALIBRATE_LATCH	(5 * 307200/HZ) /* 0.050sec * 307200Hz = 15360 */
+#define CALIBRATE_TIME	(5 * 1000020/HZ)
+
+static unsigned long last_tsc_low; /* lsb 32 bits of Time Stamp Counter */
+
+static inline unsigned long mach_calibrate_tsc(void)
+{
+
+	unsigned long startlow, starthigh;
+	unsigned long endlow, endhigh;
+	unsigned short count;
+
+	for (count = inw(0x5c); inw(0x5c) == count; )
+		;
+	rdtsc(startlow,starthigh);
+	count = inw(0x5c);
+	while ((unsigned short)(inw(0x5c) - count) < CALIBRATE_LATCH)
+		;
+	rdtsc(endlow,endhigh);
+
+	last_tsc_low = endlow;
+
+	/* 64-bit subtract - gcc just messes up with long longs */
+	__asm__("subl %2,%0\n\t"
+		"sbbl %3,%1"
+		:"=a" (endlow), "=d" (endhigh)
+		:"g" (startlow), "g" (starthigh),
+		 "0" (endlow), "1" (endhigh));
+
+	/* Error: ECPUTOOFAST */
+	if (endhigh)
+		goto bad_ctc;
+
+	/* Error: ECPUTOOSLOW */
+	if (endlow <= CALIBRATE_TIME)
+		goto bad_ctc;
+
+	__asm__("divl %2"
+		:"=a" (endlow), "=d" (endhigh)
+		:"r" (endlow), "0" (0), "1" (CALIBRATE_TIME));
+
+	return endlow;
+
+	/*
+ 	* The CTC wasn't reliable: we got a hit on the very first read,
+ 	* or the CPU was so fast/slow that the quotient wouldn't fit in
+ 	* 32 bits..
+ 	*/
+bad_ctc:
+	return 0;
+}
+
+#endif /* !_MACH_CALIBRATE_TSC_H */
diff -Nru linux/include/asm-i386/mach-pc9800/do_timer.h linux98/include/asm-i386/mach-pc9800/do_timer.h
--- linux/include/asm-i386/mach-pc9800/do_timer.h	1970-01-01 09:00:00.000000000 +0900
+++ linux98/include/asm-i386/mach-pc9800/do_timer.h	2002-10-16 13:20:29.000000000 +0900
@@ -0,0 +1,80 @@
+/* defines for inline arch setup functions */
+
+/**
+ * do_timer_interrupt_hook - hook into timer tick
+ * @regs:	standard registers from interrupt
+ *
+ * Description:
+ *	This hook is called immediately after the timer interrupt is ack'd.
+ *	It's primary purpose is to allow architectures that don't possess
+ *	individual per CPU clocks (like the CPU APICs supply) to broadcast the
+ *	timer interrupt as a means of triggering reschedules etc.
+ **/
+
+static inline void do_timer_interrupt_hook(struct pt_regs *regs)
+{
+	do_timer(regs);
+/*
+ * In the SMP case we use the local APIC timer interrupt to do the
+ * profiling, except when we simulate SMP mode on a uniprocessor
+ * system, in that case we have to call the local interrupt handler.
+ */
+#ifndef CONFIG_X86_LOCAL_APIC
+	x86_do_profile(regs);
+#else
+	if (!using_apic_timer)
+		smp_local_timer_interrupt(regs);
+#endif
+}
+
+
+/* you can safely undefine this if you don't have the Neptune chipset */
+
+#define BUGGY_NEPTUN_TIMER
+
+/**
+ * do_timer_overflow - process a detected timer overflow condition
+ * @count:	hardware timer interrupt count on overflow
+ *
+ * Description:
+ *	This call is invoked when the jiffies count has not incremented but
+ *	the hardware timer interrupt has.  It means that a timer tick interrupt
+ *	came along while the previous one was pending, thus a tick was missed
+ **/
+static inline int do_timer_overflow(int count)
+{
+	int i;
+
+	spin_lock(&i8259A_lock);
+	/*
+	 * This is tricky when I/O APICs are used;
+	 * see do_timer_interrupt().
+	 */
+	i = inb(0x00);
+	spin_unlock(&i8259A_lock);
+	
+	/* assumption about timer being IRQ0 */
+	if (i & 0x01) {
+		/*
+		 * We cannot detect lost timer interrupts ... 
+		 * well, that's why we call them lost, don't we? :)
+		 * [hmm, on the Pentium and Alpha we can ... sort of]
+		 */
+		count -= LATCH;
+	} else {
+#ifdef BUGGY_NEPTUN_TIMER
+		/*
+		 * for the Neptun bug we know that the 'latch'
+		 * command doesnt latch the high and low value
+		 * of the counter atomically. Thus we have to 
+		 * substract 256 from the counter 
+		 * ... funny, isnt it? :)
+		 */
+		
+		count -= 256;
+#else
+		printk("do_slow_gettimeoffset(): hardware timer problem?\n");
+#endif
+	}
+	return count;
+}
diff -Nru linux-2.5.53/include/asm-i386/mach-pc9800/io_ports.h linux98-2.5.53/include/asm-i386/mach-pc9800/io_ports.h
--- linux-2.5.53/include/asm-i386/mach-pc9800/io_ports.h	1970-01-01 01:00:00.000000000 +0100
+++ linux98-2.5.53/include/asm-i386/mach-pc9800/io_ports.h	2002-10-31 15:05:52.000000000 +0000
@@ -0,0 +1,30 @@
+/*
+ *  include/asm-i386/mach-pc9800/io_ports.h
+ *
+ *  Machine specific IO port address definition for PC-9800.
+ *  Written by Osamu Tomita <tomita@cinet.co.jp>
+ */
+#ifndef _MACH_IO_PORTS_H
+#define _MACH_IO_PORTS_H
+
+/* i8253A PIT registers */
+#define PIT_MODE		0x77
+#define PIT_CH0			0x71
+#define PIT_CH2			0x75
+
+/* i8259A PIC registers */
+#define PIC_MASTER_CMD		0x00
+#define PIC_MASTER_IMR		0x02
+#define PIC_MASTER_ISR		PIC_MASTER_CMD
+#define PIC_MASTER_POLL		PIC_MASTER_ISR
+#define PIC_MASTER_OCW3		PIC_MASTER_ISR
+#define PIC_SLAVE_CMD		0x08
+#define PIC_SLAVE_IMR		0x0a
+
+/* i8259A PIC related values */
+#define PIC_CASCADE_IR		7
+#define MASTER_ICW4_DEFAULT	0x1d
+#define SLAVE_ICW4_DEFAULT	0x09
+#define PIC_ICW4_AEOI		0x02
+
+#endif /* !_MACH_IO_PORTS_H */
diff -Nru linux-2.5.53/include/asm-i386/mach-pc9800/irq_vectors.h linux98-2.5.53/include/asm-i386/mach-pc9800/irq_vectors.h
--- linux-2.5.53/include/asm-i386/mach-pc9800/irq_vectors.h	1970-01-01 01:00:00.000000000 +0100
+++ linux98-2.5.53/include/asm-i386/mach-pc9800/irq_vectors.h	2002-10-31 15:05:52.000000000 +0000
@@ -0,0 +1,93 @@
+/*
+ * This file should contain #defines for all of the interrupt vector
+ * numbers used by this architecture.
+ *
+ * In addition, there are some standard defines:
+ *
+ *	FIRST_EXTERNAL_VECTOR:
+ *		The first free place for external interrupts
+ *
+ *	SYSCALL_VECTOR:
+ *		The IRQ vector a syscall makes the user to kernel transition
+ *		under.
+ *
+ *	TIMER_IRQ:
+ *		The IRQ number the timer interrupt comes in at.
+ *
+ *	NR_IRQS:
+ *		The total number of interrupt vectors (including all the
+ *		architecture specific interrupts) needed.
+ *
+ */			
+#ifndef _ASM_IRQ_VECTORS_H
+#define _ASM_IRQ_VECTORS_H
+
+/*
+ * IDT vectors usable for external interrupt sources start
+ * at 0x20:
+ */
+#define FIRST_EXTERNAL_VECTOR	0x20
+
+#define SYSCALL_VECTOR		0x80
+
+/*
+ * Vectors 0x20-0x2f are used for ISA interrupts.
+ */
+
+/*
+ * Special IRQ vectors used by the SMP architecture, 0xf0-0xff
+ *
+ *  some of the following vectors are 'rare', they are merged
+ *  into a single vector (CALL_FUNCTION_VECTOR) to save vector space.
+ *  TLB, reschedule and local APIC vectors are performance-critical.
+ *
+ *  Vectors 0xf0-0xfa are free (reserved for future Linux use).
+ */
+#define SPURIOUS_APIC_VECTOR	0xff
+#define ERROR_APIC_VECTOR	0xfe
+#define INVALIDATE_TLB_VECTOR	0xfd
+#define RESCHEDULE_VECTOR	0xfc
+#define CALL_FUNCTION_VECTOR	0xfb
+
+#define THERMAL_APIC_VECTOR	0xf0
+/*
+ * Local APIC timer IRQ vector is on a different priority level,
+ * to work around the 'lost local interrupt if more than 2 IRQ
+ * sources per level' errata.
+ */
+#define LOCAL_TIMER_VECTOR	0xef
+
+/*
+ * First APIC vector available to drivers: (vectors 0x30-0xee)
+ * we start at 0x31 to spread out vectors evenly between priority
+ * levels. (0x80 is the syscall vector)
+ */
+#define FIRST_DEVICE_VECTOR	0x31
+#define FIRST_SYSTEM_VECTOR	0xef
+
+#define TIMER_IRQ 0
+
+/*
+ * 16 8259A IRQ's, 208 potential APIC interrupt sources.
+ * Right now the APIC is mostly only used for SMP.
+ * 256 vectors is an architectural limit. (we can have
+ * more than 256 devices theoretically, but they will
+ * have to use shared interrupts)
+ * Since vectors 0x00-0x1f are used/reserved for the CPU,
+ * the usable vector space is 0x20-0xff (224 vectors)
+ */
+#ifdef CONFIG_X86_IO_APIC
+#define NR_IRQS 224
+#else
+#define NR_IRQS 16
+#endif
+
+#define FPU_IRQ			8
+
+#define	FIRST_VM86_IRQ		2
+#define LAST_VM86_IRQ		15
+#define invalid_vm86_irq(irq)	((irq) < 2 || (irq) == 7 || (irq) > 15)
+
+#endif /* _ASM_IRQ_VECTORS_H */
+
+
diff -Nru linux/include/asm-i386/mach-pc9800/mach_resources.h linux98/include/asm-i386/mach-pc9800/mach_resources.h
--- linux/include/asm-i386/mach-pc9800/mach_resources.h	1970-01-01 09:00:00.000000000 +0900
+++ linux98/include/asm-i386/mach-pc9800/mach_resources.h	2002-10-26 17:35:19.000000000 +0900
@@ -0,0 +1,192 @@
+/*
+ *  include/asm-i386/mach-pc9800/mach_resources.h
+ *
+ *  Machine specific resource allocation for PC-9800.
+ *  Written by Osamu Tomita <tomita@cinet.co.jp>
+ */
+#ifndef _MACH_RESOURCES_H
+#define _MACH_RESOURCES_H
+
+static char str_pic1[] = "pic1";
+static char str_dma[] = "dma";
+static char str_pic2[] = "pic2";
+static char str_calender_clock[] = "calender clock";
+static char str_system[] = "system";
+static char str_nmi_control[] = "nmi control";
+static char str_kanji_rom[] = "kanji rom";
+static char str_keyboard[] = "keyboard";
+static char str_text_gdc[] = "text gdc";
+static char str_crtc[] = "crtc";
+static char str_timer[] = "timer";
+static char str_graphic_gdc[] = "graphic gdc";
+static char str_dma_ex_bank[] = "dma ex. bank";
+static char str_beep_freq[] = "beep freq.";
+static char str_mouse_pio[] = "mouse pio";
+struct resource standard_io_resources[] = {
+	{ str_pic1, 0x00, 0x00, IORESOURCE_BUSY },
+	{ str_dma, 0x01, 0x01, IORESOURCE_BUSY },
+	{ str_pic1, 0x02, 0x02, IORESOURCE_BUSY },
+	{ str_dma, 0x03, 0x03, IORESOURCE_BUSY },
+	{ str_dma, 0x05, 0x05, IORESOURCE_BUSY },
+	{ str_dma, 0x07, 0x07, IORESOURCE_BUSY },
+	{ str_pic2, 0x08, 0x08, IORESOURCE_BUSY },
+	{ str_dma, 0x09, 0x09, IORESOURCE_BUSY },
+	{ str_pic2, 0x0a, 0x0a, IORESOURCE_BUSY },
+	{ str_dma, 0x0b, 0x0b, IORESOURCE_BUSY },
+	{ str_dma, 0x0d, 0x0d, IORESOURCE_BUSY },
+	{ str_dma, 0x0f, 0x0f, IORESOURCE_BUSY },
+	{ str_dma, 0x11, 0x11, IORESOURCE_BUSY },
+	{ str_dma, 0x13, 0x13, IORESOURCE_BUSY },
+	{ str_dma, 0x15, 0x15, IORESOURCE_BUSY },
+	{ str_dma, 0x17, 0x17, IORESOURCE_BUSY },
+	{ str_dma, 0x19, 0x19, IORESOURCE_BUSY },
+	{ str_dma, 0x1b, 0x1b, IORESOURCE_BUSY },
+	{ str_dma, 0x1d, 0x1d, IORESOURCE_BUSY },
+	{ str_dma, 0x1f, 0x1f, IORESOURCE_BUSY },
+	{ str_calender_clock, 0x20, 0x20, 0 },
+	{ str_dma, 0x21, 0x21, IORESOURCE_BUSY },
+	{ str_calender_clock, 0x22, 0x22, 0 },
+	{ str_dma, 0x23, 0x23, IORESOURCE_BUSY },
+	{ str_dma, 0x25, 0x25, IORESOURCE_BUSY },
+	{ str_dma, 0x27, 0x27, IORESOURCE_BUSY },
+	{ str_dma, 0x29, 0x29, IORESOURCE_BUSY },
+	{ str_dma, 0x2b, 0x2b, IORESOURCE_BUSY },
+	{ str_dma, 0x2d, 0x2d, IORESOURCE_BUSY },
+	{ str_system, 0x31, 0x31, IORESOURCE_BUSY },
+	{ str_system, 0x33, 0x33, IORESOURCE_BUSY },
+	{ str_system, 0x35, 0x35, IORESOURCE_BUSY },
+	{ str_system, 0x37, 0x37, IORESOURCE_BUSY },
+	{ str_nmi_control, 0x50, 0x50, IORESOURCE_BUSY },
+	{ str_nmi_control, 0x52, 0x52, IORESOURCE_BUSY },
+	{ "time stamp", 0x5c, 0x5f, IORESOURCE_BUSY },
+	{ str_kanji_rom, 0xa1, 0xa1, IORESOURCE_BUSY },
+	{ str_kanji_rom, 0xa3, 0xa3, IORESOURCE_BUSY },
+	{ str_kanji_rom, 0xa5, 0xa5, IORESOURCE_BUSY },
+	{ str_kanji_rom, 0xa7, 0xa7, IORESOURCE_BUSY },
+	{ str_kanji_rom, 0xa9, 0xa9, IORESOURCE_BUSY },
+	{ str_keyboard, 0x41, 0x41, IORESOURCE_BUSY },
+	{ str_keyboard, 0x43, 0x43, IORESOURCE_BUSY },
+	{ str_text_gdc, 0x60, 0x60, IORESOURCE_BUSY },
+	{ str_text_gdc, 0x62, 0x62, IORESOURCE_BUSY },
+	{ str_text_gdc, 0x64, 0x64, IORESOURCE_BUSY },
+	{ str_text_gdc, 0x66, 0x66, IORESOURCE_BUSY },
+	{ str_text_gdc, 0x68, 0x68, IORESOURCE_BUSY },
+	{ str_text_gdc, 0x6a, 0x6a, IORESOURCE_BUSY },
+	{ str_text_gdc, 0x6c, 0x6c, IORESOURCE_BUSY },
+	{ str_text_gdc, 0x6e, 0x6e, IORESOURCE_BUSY },
+	{ str_crtc, 0x70, 0x70, IORESOURCE_BUSY },
+	{ str_crtc, 0x72, 0x72, IORESOURCE_BUSY },
+	{ str_crtc, 0x74, 0x74, IORESOURCE_BUSY },
+	{ str_crtc, 0x74, 0x74, IORESOURCE_BUSY },
+	{ str_crtc, 0x76, 0x76, IORESOURCE_BUSY },
+	{ str_crtc, 0x78, 0x78, IORESOURCE_BUSY },
+	{ str_crtc, 0x7a, 0x7a, IORESOURCE_BUSY },
+	{ str_timer, 0x71, 0x71, IORESOURCE_BUSY },
+	{ str_timer, 0x73, 0x73, IORESOURCE_BUSY },
+	{ str_timer, 0x75, 0x75, IORESOURCE_BUSY },
+	{ str_timer, 0x77, 0x77, IORESOURCE_BUSY },
+	{ str_graphic_gdc, 0xa0, 0xa0, IORESOURCE_BUSY },
+	{ str_graphic_gdc, 0xa2, 0xa2, IORESOURCE_BUSY },
+	{ str_graphic_gdc, 0xa4, 0xa4, IORESOURCE_BUSY },
+	{ str_graphic_gdc, 0xa6, 0xa6, IORESOURCE_BUSY },
+	{ "cpu", 0xf0, 0xf7, IORESOURCE_BUSY },
+	{ "fpu", 0xf8, 0xff, IORESOURCE_BUSY },
+	{ str_dma_ex_bank, 0x0e05, 0x0e05, 0 },
+	{ str_dma_ex_bank, 0x0e07, 0x0e07, 0 },
+	{ str_dma_ex_bank, 0x0e09, 0x0e09, 0 },
+	{ str_dma_ex_bank, 0x0e0b, 0x0e0b, 0 },
+	{ str_beep_freq, 0x3fd9, 0x3fd9, IORESOURCE_BUSY },
+	{ str_beep_freq, 0x3fdb, 0x3fdb, IORESOURCE_BUSY },
+	{ str_beep_freq, 0x3fdd, 0x3fdd, IORESOURCE_BUSY },
+	{ str_beep_freq, 0x3fdf, 0x3fdf, IORESOURCE_BUSY },
+	/* All PC-9800 have (exactly) one mouse interface.  */
+	{ str_mouse_pio, 0x7fd9, 0x7fd9, 0 },
+	{ str_mouse_pio, 0x7fdb, 0x7fdb, 0 },
+	{ str_mouse_pio, 0x7fdd, 0x7fdd, 0 },
+	{ str_mouse_pio, 0x7fdf, 0x7fdf, 0 },
+	{ "mouse timer", 0xbfdb, 0xbfdb, 0 },
+	{ "mouse irq", 0x98d7, 0x98d7, 0 },
+};
+
+#define STANDARD_IO_RESOURCES (sizeof(standard_io_resources)/sizeof(struct resource))
+
+static struct resource tvram_resource = { "Text VRAM/CG window", 0xa0000, 0xa4fff, IORESOURCE_BUSY };
+static struct resource gvram_brg_resource = { "Graphic VRAM (B/R/G)", 0xa8000, 0xbffff, IORESOURCE_BUSY };
+static struct resource gvram_e_resource = { "Graphic VRAM (E)", 0xe0000, 0xe7fff, IORESOURCE_BUSY };
+
+/* System ROM resources */
+#define MAXROMS 6
+static struct resource rom_resources[MAXROMS] = {
+	{ "System ROM", 0xe8000, 0xfffff, IORESOURCE_BUSY }
+};
+
+static inline void probe_roms(void)
+{
+	int roms = 1;
+	int i;
+	__u8 *xrom_id;
+
+	request_resource(&iomem_resource, rom_resources+0);
+
+	xrom_id = (__u8 *) isa_bus_to_virt(PC9800SCA_XROM_ID + 0x10);
+
+	for (i = 0; i < 16; i++) {
+		if (xrom_id[i] & 0x80) {
+			int j;
+
+			for (j = i + 1; j < 16 && (xrom_id[j] & 0x80); j++)
+				;
+			rom_resources[roms].start = 0x0d0000 + i * 0x001000;
+			rom_resources[roms].end = 0x0d0000 + j * 0x001000 - 1;
+			rom_resources[roms].name = "Extension ROM";
+			rom_resources[roms].flags = IORESOURCE_BUSY;
+
+			request_resource(&iomem_resource,
+					  rom_resources + roms);
+			if (++roms >= MAXROMS)
+				return;
+		}
+	}
+}
+
+static inline void mach_request_resource(void)
+{
+	int i;
+
+	if (PC9800_HIGHRESO_P()) {
+		tvram_resource.start = 0xe0000;
+		tvram_resource.end   = 0xe4fff;
+		gvram_brg_resource.name  = "Graphic VRAM";
+		gvram_brg_resource.start = 0xc0000;
+		gvram_brg_resource.end   = 0xdffff;
+	}
+
+	request_resource(&iomem_resource, &tvram_resource);
+	request_resource(&iomem_resource, &gvram_brg_resource);
+	if (!PC9800_HIGHRESO_P())
+		request_resource(&iomem_resource, &gvram_e_resource);
+
+	for (i = 0; i < STANDARD_IO_RESOURCES; i++)
+		request_resource(&ioport_resource, standard_io_resources + i);
+
+	if (PC9800_HIGHRESO_P() || PC9800_9821_P()) {
+		static char graphics[] = "graphics";
+		static struct resource graphics_resources[] = {
+			{ graphics, 0x9a0, 0x9a0, 0 },
+			{ graphics, 0x9a2, 0x9a2, 0 },
+			{ graphics, 0x9a4, 0x9a4, 0 },
+			{ graphics, 0x9a6, 0x9a6, 0 },
+			{ graphics, 0x9a8, 0x9a8, 0 },
+			{ graphics, 0x9aa, 0x9aa, 0 },
+			{ graphics, 0x9ac, 0x9ac, 0 },
+			{ graphics, 0x9ae, 0x9ae, 0 },
+		};
+
+#define GRAPHICS_RESOURCES (sizeof(graphics_resources)/sizeof(struct resource))
+
+		for (i = 0; i < GRAPHICS_RESOURCES; i++)
+			request_resource(&ioport_resource, graphics_resources + i);
+	}
+}
+
+#endif /* !_MACH_RESOURCES_H */
diff -Nru linux/include/asm-i386/mach-pc9800/mach_time.h linux98/include/asm-i386/mach-pc9800/mach_time.h
--- linux/include/asm-i386/mach-pc9800/mach_time.h	1970-01-01 09:00:00.000000000 +0900
+++ linux98/include/asm-i386/mach-pc9800/mach_time.h	2002-10-21 11:23:06.000000000 +0900
@@ -0,0 +1,136 @@
+/*
+ *  include/asm-i386/mach-pc9800/mach_time.h
+ *
+ *  Machine specific set RTC function for PC-9800.
+ *  Written by Osamu Tomita <tomita@cinet.co.jp>
+ */
+#ifndef _MACH_TIME_H
+#define _MACH_TIME_H
+
+#include <linux/upd4990a.h>
+
+/* for check timing call set_rtc_mmss() */
+/* used in arch/i386/time.c::do_timer_interrupt() */
+/*
+ * Because PC-9800's RTC (NEC uPD4990A) does not allow setting
+ * time partially, we always have to read-modify-write the
+ * entire time (including year) so that set_rtc_mmss() will
+ * take quite much time to execute.  You may want to relax
+ * RTC resetting interval (currently ~11 minuts)...
+ */
+#define TIME1	1000000
+#define TIME2	0
+
+static inline int mach_set_rtc_mmss(unsigned long nowtime)
+{
+	int retval = 0;
+	int real_seconds, real_minutes, cmos_minutes;
+	struct upd4990a_raw_data data;
+
+	upd4990a_get_time(&data, 1);
+	cmos_minutes = (data.min >> 4) * 10 + (data.min & 0xf);
+
+	/*
+	 * since we're only adjusting minutes and seconds,
+	 * don't interfere with hour overflow. This avoids
+	 * messing with unknown time zones but requires your
+	 * RTC not to be off by more than 15 minutes
+	 */
+	real_seconds = nowtime % 60;
+	real_minutes = nowtime / 60;
+	if (((abs(real_minutes - cmos_minutes) + 15) / 30) & 1)
+		real_minutes += 30;	/* correct for half hour time zone */
+	real_minutes %= 60;
+
+	if (abs(real_minutes - cmos_minutes) < 30) {
+		u8 temp_seconds = (real_seconds / 10) * 16 + real_seconds % 10;
+		u8 temp_minutes = (real_minutes / 10) * 16 + real_minutes % 10;
+
+		if (data.sec != temp_seconds || data.min != temp_minutes) {
+			data.sec = temp_seconds;
+			data.min = temp_minutes;
+			upd4990a_set_time(&data, 1);
+		}
+	} else {
+		printk(KERN_WARNING
+		       "set_rtc_mmss: can't update from %d to %d\n",
+		       cmos_minutes, real_minutes);
+		retval = -1;
+	}
+
+	/* uPD4990A users' manual says we should issue Register Hold
+	 * command after reading time, or future Time Read command
+	 * may not work.  When we have set the time, this also starts
+	 * the clock.
+	 */
+	upd4990a_serial_command(UPD4990A_REGISTER_HOLD);
+
+	return retval;
+}
+
+#define RTC_SANITY_CHECK
+
+static inline unsigned long mach_get_cmos_time(void)
+{
+	int i;
+	u8 prev, cur;
+	unsigned int year;
+#ifdef RTC_SANITY_CHECK
+	int retry_count;
+#endif
+
+	struct upd4990a_raw_data data;
+
+#ifdef RTC_SANITY_CHECK
+	retry_count = 0;
+ retry:
+#endif
+	/* Connect uPD4990A's DATA OUT pin to its 1Hz reference clock. */
+	upd4990a_serial_command(UPD4990A_REGISTER_HOLD);
+
+	/* Catch rising edge of reference clock.  */
+	prev = ~UPD4990A_READ_DATA();
+	for (i = 0; i < 1800000; i++) { /* may take up to 1 second... */
+		__asm__ ("outb %%al,%0" : : "N" (0x5f)); /* 0.6usec delay */
+		cur = UPD4990A_READ_DATA();
+		if (!(prev & cur & 1))
+			break;
+		prev = ~cur;
+	}
+
+	upd4990a_get_time(&data, 0);
+
+#ifdef RTC_SANITY_CHECK
+# define BCD_VALID_P(x, hi)	(((x) & 0x0f) <= 9 && (x) <= 0x ## hi)
+# define DATA			((const unsigned char *) &data)
+
+	if (!BCD_VALID_P(data.sec, 59) ||
+	    !BCD_VALID_P(data.min, 59) ||
+	    !BCD_VALID_P(data.hour, 23) ||
+	    data.mday == 0 || !BCD_VALID_P(data.mday, 31) ||
+	    data.wday > 6 ||
+	    data.mon < 1 || 12 < data.mon ||
+	    !BCD_VALID_P(data.year, 99)) {
+		printk(KERN_ERR "RTC clock data is invalid! "
+			"(%02X %02X %02X %02X %02X %02X) - ",
+			DATA[0], DATA[1], DATA[2], DATA[3], DATA[4], DATA[5]);
+		if (++retry_count < 3) {
+			printk("retrying (%d)\n", retry_count);
+			goto retry;
+		}
+		printk("giving up, continuing\n");
+	}
+
+# undef BCD_VALID_P
+# undef DATA
+#endif /* RTC_SANITY_CHECK */
+
+#define CVT(x)	(((x) & 0xF) + ((x) >> 4) * 10)
+	if ((year = CVT(data.year) + 1900) < 1995)
+		year += 100;
+	return mktime(year, data.mon, CVT(data.mday),
+		       CVT(data.hour), CVT(data.min), CVT(data.sec));
+#undef CVT
+}
+
+#endif /* !_MACH_TIME_H */
diff -Nru linux/include/asm-i386/mach-pc9800/mach_traps.h linux98/include/asm-i386/mach-pc9800/mach_traps.h
--- linux/include/asm-i386/mach-pc9800/mach_traps.h	1970-01-01 09:00:00.000000000 +0900
+++ linux98/include/asm-i386/mach-pc9800/mach_traps.h	2002-11-05 22:46:55.000000000 +0900
@@ -0,0 +1,27 @@
+/*
+ *  include/asm-i386/mach-pc9800/mach_traps.h
+ *
+ *  Machine specific NMI handling for PC-9800.
+ *  Written by Osamu Tomita <tomita@cinet.co.jp>
+ */
+#ifndef _MACH_TRAPS_H
+#define _MACH_TRAPS_H
+
+static inline void clear_mem_error(unsigned char reason)
+{
+	outb(0x08, 0x37);
+	outb(0x09, 0x37);
+}
+
+static inline unsigned char get_nmi_reason(void)
+{
+	return (inb(0x33) & 6) ? 0x80 : 0;
+}
+
+static inline void reassert_nmi(void)
+{
+	outb(0x09, 0x50);	/* disable NMI once */
+	outb(0x09, 0x52);	/* re-enable it */
+}
+
+#endif /* !_MACH_TRAPS_H */
diff -Nru linux-2.5.53/include/asm-i386/mach-pc9800/setup_arch_post.h linux98-2.5.53/include/asm-i386/mach-pc9800/setup_arch_post.h
--- linux-2.5.53/include/asm-i386/mach-pc9800/setup_arch_post.h	1970-01-01 01:00:00.000000000 +0100
+++ linux98-2.5.53/include/asm-i386/mach-pc9800/setup_arch_post.h	2002-10-31 15:05:52.000000000 +0000
@@ -0,0 +1,29 @@
+/**
+ * machine_specific_memory_setup - Hook for machine specific memory setup.
+ *
+ * Description:
+ *	This is included late in kernel/setup.c so that it can make
+ *	use of all of the static functions.
+ **/
+
+static inline char * __init machine_specific_memory_setup(void)
+{
+	char *who;
+	unsigned long low_mem_size, lower_high, higher_high;
+
+
+	who = "BIOS (common area)";
+
+	low_mem_size = ((*(unsigned char *)__va(PC9800SCA_BIOS_FLAG) & 7) + 1) << 17;
+	add_memory_region(0, low_mem_size, 1);
+	lower_high = (__u32) *(__u8 *) bus_to_virt(PC9800SCA_EXPMMSZ) << 17;
+	higher_high = (__u32) *(__u16 *) bus_to_virt(PC9800SCA_MMSZ16M) << 20;
+	if (lower_high != 0x00f00000UL) {
+		add_memory_region(HIGH_MEMORY, lower_high, 1);
+		add_memory_region(0x01000000UL, higher_high, 1);
+	}
+	else
+		add_memory_region(HIGH_MEMORY, lower_high + higher_high, 1);
+
+	return who;
+}
diff -Nru linux-2.5.53/include/asm-i386/mach-pc9800/setup_arch_pre.h linux98-2.5.53/include/asm-i386/mach-pc9800/setup_arch_pre.h
--- linux-2.5.53/include/asm-i386/mach-pc9800/setup_arch_pre.h	1970-01-01 01:00:00.000000000 +0100
+++ linux98-2.5.53/include/asm-i386/mach-pc9800/setup_arch_pre.h	2002-10-31 15:05:52.000000000 +0000
@@ -0,0 +1,36 @@
+/* Hook to call BIOS initialisation function */
+
+/* no action for generic */
+
+#define ARCH_SETUP arch_setup_pc9800();
+
+#include <linux/timex.h>
+#include <asm/io.h>
+#include <asm/pc9800.h>
+#include <asm/pc9800_sca.h>
+
+int CLOCK_TICK_RATE;
+unsigned long tick_usec;	/* ACTHZ          period (usec) */
+unsigned long tick_nsec;	/* USER_HZ period (nsec) */
+unsigned char pc9800_misc_flags;
+/* (bit 0) 1:High Address Video ram exists 0:otherwise */
+
+#ifdef CONFIG_SMP
+#define MPC_TABLE_SIZE 512
+#define MPC_TABLE ((char *) (PARAM+0x400))
+char mpc_table[MPC_TABLE_SIZE];
+#endif
+
+static  inline void arch_setup_pc9800(void)
+{
+	CLOCK_TICK_RATE = PC9800_8MHz_P() ? 1996800 : 2457600;
+	printk(KERN_DEBUG "CLOCK_TICK_RATE = %d\n", CLOCK_TICK_RATE);
+	tick_usec = TICK_USEC; 		/* ACTHZ          period (usec) */
+	tick_nsec = TICK_NSEC(TICK_USEC);	/* USER_HZ period (nsec) */
+
+	pc9800_misc_flags = PC9800_MISC_FLAGS;
+#ifdef CONFIG_SMP
+	if ((*(u32 *)(MPC_TABLE)) == 0x504d4350)
+		memcpy(mpc_table, MPC_TABLE, *(u16 *)(MPC_TABLE + 4));
+#endif /* CONFIG_SMP */
+}
diff -Nru linux-2.5.53/include/asm-i386/mach-visws/irq_vectors.h linux98-2.5.53/include/asm-i386/mach-visws/irq_vectors.h
--- linux-2.5.53/include/asm-i386/mach-visws/irq_vectors.h	2002-12-10 11:45:43.000000000 +0900
+++ linux98-2.5.53/include/asm-i386/mach-visws/irq_vectors.h	2002-12-16 09:15:54.000000000 +0900
@@ -61,4 +61,10 @@
 #define NR_IRQS 16
 #endif
 
+#define FPU_IRQ			13
+
+#define	FIRST_VM86_IRQ		3
+#define LAST_VM86_IRQ		15
+#define invalid_vm86_irq(irq)	((irq) < 3 || (irq) > 15)
+
 #endif /* _ASM_IRQ_VECTORS_H */
diff -Nru linux-2.5.53/include/asm-i386/mach-voyager/irq_vectors.h linux98-2.5.53/include/asm-i386/mach-voyager/irq_vectors.h
--- linux-2.5.53/include/asm-i386/mach-voyager/irq_vectors.h	2002-11-25 15:09:13.000000000 +0000
+++ linux98-2.5.53/include/asm-i386/mach-voyager/irq_vectors.h	2002-10-31 15:05:52.000000000 +0000
@@ -57,6 +57,12 @@
 
 #define NR_IRQS 224
 
+#define FPU_IRQ				13
+
+#define	FIRST_VM86_IRQ		3
+#define LAST_VM86_IRQ		15
+#define invalid_vm86_irq(irq)	((irq) < 3 || (irq) > 15)
+
 #ifndef __ASSEMBLY__
 extern asmlinkage void vic_cpi_interrupt(void);
 extern asmlinkage void vic_sys_interrupt(void);
diff -Nru linux-2.5.54/include/asm-i386/processor.h linux98-2.5.54/include/asm-i386/processor.h
--- linux-2.5.54/include/asm-i386/processor.h	2003-01-02 12:21:01.000000000 +0900
+++ linux98-2.5.54/include/asm-i386/processor.h	2003-01-04 10:47:57.000000000 +0900
@@ -92,7 +92,7 @@
 #define current_cpu_data boot_cpu_data
 #endif
 
-extern char ignore_irq13;
+extern char ignore_fpu_irq;
 
 extern void identify_cpu(struct cpuinfo_x86 *);
 extern void print_cpu_info(struct cpuinfo_x86 *);
diff -Nru linux/include/asm-i386/timex.h linux98/include/asm-i386/timex.h
--- linux/include/asm-i386/timex.h	2002-02-14 18:09:15.000000000 +0900
+++ linux98/include/asm-i386/timex.h	2002-02-14 23:58:57.000000000 +0900
@@ -9,11 +9,15 @@
 #include <linux/config.h>
 #include <asm/msr.h>
 
+#ifdef CONFIG_X86_PC9800
+   extern int CLOCK_TICK_RATE;
+#else
 #ifdef CONFIG_MELAN
 #  define CLOCK_TICK_RATE 1189200 /* AMD Elan has different frequency! */
 #else
 #  define CLOCK_TICK_RATE 1193180 /* Underlying HZ */
 #endif
+#endif
 
 #define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */
 #define FINETUNE ((((((long)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) * \
This is patchset to support NEC PC-9800 subarchitecture
against 2.5.60 (22/34).

Misc files for support PC98.

diff -Nru linux-2.5.60/kernel/timer.c linux98-2.5.60/kernel/timer.c
--- linux-2.5.60/kernel/timer.c	2003-02-11 03:38:50.000000000 +0900
+++ linux98-2.5.60/kernel/timer.c	2003-02-11 13:04:49.000000000 +0900
@@ -437,8 +437,13 @@
 /*
  * Timekeeping variables
  */
+#ifndef CONFIG_X86_PC9800
 unsigned long tick_usec = TICK_USEC; 		/* ACTHZ   period (usec) */
 unsigned long tick_nsec = TICK_NSEC(TICK_USEC);	/* USER_HZ period (nsec) */
+#else
+extern unsigned long tick_usec; 		/* ACTHZ   period (usec) */
+extern unsigned long tick_nsec;			/* USER_HZ period (nsec) */
+#endif
 
 /* The current time */
 struct timespec xtime __attribute__ ((aligned (16)));
