Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261390AbSJ1R1y>; Mon, 28 Oct 2002 12:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261429AbSJ1R1x>; Mon, 28 Oct 2002 12:27:53 -0500
Received: from gateway.cinet.co.jp ([210.166.75.129]:59663 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S261390AbSJ1RXn>; Mon, 28 Oct 2002 12:23:43 -0500
Date: Tue, 29 Oct 2002 02:30:03 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCHSET 4/23] add support for PC-9800 architecture (core #1)
Message-ID: <20021029023003.A2241@precia.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a part 4/23 of patchset for add support NEC PC-9800 architecture,
against 2.5.44.

Summary:
 i386 core modules
  - IO port address change
  - IRQ number change
  - adapted to hardware memory mapping.
  - CLOCK_TICK_RATE constat to variable.
     some PC-9800 can change base clock by hardware switch!

diffstat:
 arch/i386/Makefile                      |   18 +
 arch/i386/config.in                     |   19 +
 arch/i386/kernel/Makefile               |    4 
 arch/i386/kernel/cpu/proc.c             |    2 
 arch/i386/kernel/i8259.c                |  100 ++++----
 arch/i386/kernel/pc9800_debug.c         |  362 ++++++++++++++++++++++++++++++++
 arch/i386/kernel/reboot.c               |   18 -
 arch/i386/kernel/setup.c                |  101 --------
 arch/i386/kernel/time.c                 |  115 +---------
 arch/i386/kernel/timers/timer_pit.c     |   22 +
 arch/i386/kernel/timers/timer_tsc.c     |   88 -------
 arch/i386/kernel/traps.c                |   21 -
 arch/i386/kernel/vm86.c                 |   21 +
 arch/i386/mach-generic/calibrate_tsc.h  |   88 +++++++
 arch/i386/mach-generic/io_ports.h       |   30 ++
 arch/i386/mach-generic/mach_reboot.h    |   30 ++
 arch/i386/mach-generic/mach_resources.h |  113 +++++++++
 arch/i386/mach-generic/mach_time.h      |  122 ++++++++++
 arch/i386/mach-generic/mach_traps.h     |   31 ++
 arch/i386/mach-pc9800/Makefile          |   15 +
 arch/i386/mach-pc9800/calibrate_tsc.h   |   73 ++++++
 arch/i386/mach-pc9800/do_timer.h        |   80 +++++++
 arch/i386/mach-pc9800/entry_arch.h      |    1 
 arch/i386/mach-pc9800/io_ports.h        |   30 ++
 arch/i386/mach-pc9800/irq_vectors.h     |    1 
 arch/i386/mach-pc9800/mach_apic.h       |    1 
 arch/i386/mach-pc9800/mach_reboot.h     |   21 +
 arch/i386/mach-pc9800/mach_resources.h  |  192 ++++++++++++++++
 arch/i386/mach-pc9800/mach_time.h       |  136 ++++++++++++
 arch/i386/mach-pc9800/mach_traps.h      |   29 ++
 arch/i386/mach-pc9800/setup.c           |  117 ++++++++++
 arch/i386/mach-pc9800/setup_arch_post.h |   29 ++
 arch/i386/mach-pc9800/setup_arch_pre.h  |   36 +++
 arch/i386/mach-pc9800/smpboot_hooks.h   |   33 ++
 arch/i386/mach-summit/calibrate_tsc.h   |    1 
 arch/i386/mach-summit/io_ports.h        |    1 
 arch/i386/mach-summit/mach_reboot.h     |    1 
 arch/i386/mach-summit/mach_resources.h  |    1 
 arch/i386/mach-summit/mach_time.h       |    1 
 arch/i386/mach-summit/mach_traps.h      |    1 
 arch/i386/mach-visws/calibrate_tsc.h    |    1 
 arch/i386/mach-visws/io_ports.h         |    1 
 arch/i386/mach-visws/mach_reboot.h      |    1 
 arch/i386/mach-visws/mach_resources.h   |    1 
 arch/i386/mach-visws/mach_time.h        |    1 
 arch/i386/mach-visws/mach_traps.h       |    1 
 46 files changed, 1748 insertions(+), 363 deletions(-)

patch:
diff -urN linux/arch/i386/Makefile linux98/arch/i386/Makefile
--- linux/arch/i386/Makefile	Sat Oct 19 13:01:23 2002
+++ linux98/arch/i386/Makefile	Sat Oct 19 14:30:00 2002
@@ -46,8 +46,14 @@
 ifdef CONFIG_VISWS
 MACHINE	:= mach-visws
 else
+ifdef CONFIG_PC9800
+MACHINE	:= mach-pc9800
+else
+ifndef MACHINE
 MACHINE	:= mach-generic
 endif
+endif
+endif
 
 HEAD := arch/i386/kernel/head.o arch/i386/kernel/init_task.o
 
@@ -63,15 +69,20 @@
 CFLAGS += -Iarch/i386/$(MACHINE)
 AFLAGS += -Iarch/i386/$(MACHINE)
 
-makeboot = $(call descend,arch/i386/boot,$(1))
+ifndef CONFIG_PC9800
+ARCHDIR=arch/i386/boot
+else
+ARCHDIR=arch/i386/boot98
+endif
+makeboot = $(call descend,$(ARCHDIR),$(1))
 
 .PHONY: zImage bzImage compressed zlilo bzlilo zdisk bzdisk install \
 		clean archclean archmrproper
 
 all: bzImage
 
-BOOTIMAGE=arch/i386/boot/bzImage
-zImage zlilo zdisk: BOOTIMAGE=arch/i386/boot/zImage
+BOOTIMAGE=$(ARCHDIR)/bzImage
+zImage zlilo zdisk: BOOTIMAGE=$(ARCHDIR)/zImage
 
 zImage bzImage: vmlinux
 	+@$(call makeboot,$(BOOTIMAGE))
@@ -89,5 +100,6 @@
 
 archclean:
 	$(MAKE) -rR -f scripts/Makefile.clean obj=arch/i386/boot
+	$(MAKE) -rR -f scripts/Makefile.clean obj=arch/i386/boot98
 
 archmrproper:
diff -urN linux/arch/i386/config.in linux98/arch/i386/config.in
--- linux/arch/i386/config.in	Sat Oct 19 13:01:21 2002
+++ linux98/arch/i386/config.in	Sat Oct 19 14:03:02 2002
@@ -271,6 +271,7 @@
 mainmenu_option next_comment
 comment 'Bus options (PCI, PCMCIA, EISA, MCA, ISA)'
 
+bool 'NEC PC-9801/PC-9821 support' CONFIG_PC9800
 # Visual Workstation support is utterly broken.
 # If you want to see it working mail an VW540 to hch@infradead.org 8)
 #bool 'SGI Visual Workstation support' CONFIG_VISWS
@@ -303,9 +304,13 @@
 source drivers/pci/Config.in
 
 bool 'ISA support' CONFIG_ISA
+if [ "$CONFIG_PC9800" != "y" ]; then
 dep_bool 'EISA support' CONFIG_EISA $CONFIG_ISA
+else
+   define_bool CONFIG_EISA n
+fi
 
-if [ "$CONFIG_VISWS" != "y" ]; then
+if [ "$CONFIG_VISWS" != "y" -a  "$CONFIG_PC9800" != "y" ]; then
    bool 'MCA support' CONFIG_MCA
 else
    define_bool CONFIG_MCA n
@@ -425,11 +430,20 @@
 if [ "$CONFIG_VT" = "y" ]; then
    mainmenu_option next_comment
    comment 'Console drivers'
+ if [ "$CONFIG_PC9800" = "y" ]; then
+   bool 'PC-9800 GDC text console' CONFIG_GDC_CONSOLE
+   dep_bool '   Enable 32-bit access to text video RAM' CONFIG_GDC_32BITACCESS $CONFIG_GDC_CONSOLE
+ else
    bool 'VGA text console' CONFIG_VGA_CONSOLE
    bool 'Video mode selection support' CONFIG_VIDEO_SELECT
    if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
       tristate 'MDA text console (dual-headed) (EXPERIMENTAL)' CONFIG_MDA_CONSOLE
+   fi
+ fi
+   if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
+     if [ "$CONFIG_PC9800" != "y" -o "$CONFIG_GDC_CONSOLE" = "y" ]; then
       source drivers/video/Config.in
+     fi
    fi
    endmenu
 fi
@@ -466,6 +480,9 @@
       bool '  Highmem debugging' CONFIG_DEBUG_HIGHMEM
    fi
    bool '  Load all symbols for debugging/kksymoops' CONFIG_KALLSYMS
+   if [ "$CONFIG_PC9800" = "y" ]; then
+      bool '  Save kernel messages into UCG-RAM' CONFIG_PC9800_UCGLOG
+   fi
 fi
 
 if [ "$CONFIG_X86_LOCAL_APIC" = "y" ]; then
diff -urN linux/arch/i386/kernel/Makefile linux98/arch/i386/kernel/Makefile
--- linux/arch/i386/kernel/Makefile	Wed Oct 16 13:20:28 2002
+++ linux98/arch/i386/kernel/Makefile	Wed Oct 16 14:27:17 2002
@@ -10,6 +10,10 @@
 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_i386.o \
 		pci-dma.o i386_ksyms.o i387.o bluesmoke.o dmi_scan.o \
 		bootflag.o
+ifeq ($(CONFIG_PC9800),y)
+export-objs			+= pc9800_debug.o
+obj-$(CONFIG_PC9800)		+= pc9800_debug.o
+endif
 
 obj-y				+= cpu/
 obj-y				+= timers/
diff -urN linux/arch/i386/kernel/cpu/proc.c linux98/arch/i386/kernel/cpu/proc.c
--- linux/arch/i386/kernel/cpu/proc.c	Mon Jun 17 11:31:35 2002
+++ linux98/arch/i386/kernel/cpu/proc.c	Mon Jun 17 23:49:02 2002
@@ -76,7 +76,7 @@
 		seq_printf(m, "cache size\t: %d KB\n", c->x86_cache_size);
 	
 	/* We use exception 16 if we have hardware math and we've either seen it or the CPU claims it is internal */
-	fpu_exception = c->hard_math && (ignore_irq13 || cpu_has_fpu);
+	fpu_exception = c->hard_math && (ignore_fpu_irq || cpu_has_fpu);
 	seq_printf(m, "fdiv_bug\t: %s\n"
 			"hlt_bug\t\t: %s\n"
 			"f00f_bug\t: %s\n"
diff -urN linux/arch/i386/kernel/i8259.c linux98/arch/i386/kernel/i8259.c
--- linux/arch/i386/kernel/i8259.c	Tue Oct  8 03:25:15 2002
+++ linux98/arch/i386/kernel/i8259.c	Thu Oct 10 21:46:44 2002
@@ -25,6 +25,8 @@
 
 #include <linux/irq.h>
 
+#include "io_ports.h"
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
@@ -393,14 +399,18 @@
 	 * Set the clock to HZ Hz, we already have a valid
 	 * vector now:
 	 */
-	outb_p(0x34,0x43);		/* binary, mode 2, LSB/MSB, ch 0 */
-	outb_p(LATCH & 0xff , 0x40);	/* LSB */
-	outb(LATCH >> 8 , 0x40);	/* MSB */
+	outb_p(0x34, PIT_MODE);		/* binary, mode 2, LSB/MSB, ch 0 */
+	outb_p(LATCH & 0xff, PIT_CH0);	/* LSB */
+	outb(LATCH >> 8 , PIT_CH0);	/* MSB */
 
 	/*
 	 * External FPU? Set up irq13 if so, for
 	 * original braindamaged IBM FERR coupling.
 	 */
 	if (boot_cpu_data.hard_math && !cpu_has_fpu)
-		setup_irq(13, &irq13);
+#ifndef CONFIG_PC9800
+		setup_irq(13, &fpu_irq);
+#else
+		setup_irq(8, &fpu_irq);
+#endif
 }
diff -urN linux/arch/i386/kernel/pc9800_debug.c linux98/arch/i386/kernel/pc9800_debug.c
--- linux/arch/i386/kernel/pc9800_debug.c	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/kernel/pc9800_debug.c	Wed May  1 16:47:15 2002
@@ -0,0 +1,362 @@
+/*
+ *  linux/arch/i386/kernel/pc9800_debug.c
+ *
+ *  Copyright (C) 1998 Linux/98 Project
+ *
+ * Revised by TAKAI Kousuke, Nov 1999.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/kdev_t.h>
+#include <linux/console.h>
+#include <linux/init.h>
+
+#include <asm/io.h>
+#include <asm/pc9800_debug.h>
+#include <asm/pc9800.h>
+
+unsigned char __pc9800_beep_flag = 0x7;
+
+/* pc9800_beep_{on|off|toggle} are moved to <asm/pc9800_debug.h>. */
+
+/* Normal CG window begins at physical address 0xA4000,
+   but user-definable characters are on odd address only... */
+#define UCG_WINDOW	(phys_to_virt (0xA4001))
+
+#define	UCG_MAX_SIZE	(UCG_LOG_END - UCG_LOG_START + 1)
+
+#define UCG_CHAR_NR(x)	((x) / 32)
+#define UCG_2ND_BYTE(x)	((UCG_CHAR_NR (x) & 0x1f) + 0x80)
+#define UCG_1ST_BYTE(x)	((UCG_CHAR_NR (x) >> 5) + 0x76 - 0x20 + 0x80)
+#define UCG_LR(x)	(((x) & 16) << 1)
+#define UCG_LR_MASK	(1U << 5)
+#define UCG_OFFSET(x)	((x) % 16)
+
+#ifdef CONFIG_PC9800_UCGLOG
+/*
+ * Notes for PC-9800 UCG-log facility:
+ *
+ *  Official specification of PC-9800 says they can have user-definable
+ *  character-generator (UCG) RAM for 188 characters, but actual
+ *  implementations appear to have 256 characters (`188' seems to come
+ *  from adapting it to 94x94 character set).  Thus there is 2KB-odd of
+ *  unused area in UCG-RAM (one character consists of 16*16 dots, or
+ *  32 bytes).  This area is not touched and its content will be preserved
+ *  around system reset.  This facility uses this area for saving
+ *  kernel messages.
+ *
+ * UCG-RAM layout:
+ *
+ *  Page  Char	Description
+ *  ----  ----	----------------------------------------------------
+ *   76    00	Magic string and character count in first 16 bytes
+ *	   00					(remaining 16 bytes)
+ *	    :	Log messages 1/2
+ *	   1f
+ *	   20	(unused)
+ *	   21
+ *	    :	Officially used for user-definable characters
+ *	   7e
+ *	   7f	(unused)
+ *   77	   00
+ *	    :	Log messages 2/2
+ *	   1f
+ *	   20	(unused)
+ *	   21
+ *	    :	Officially used for user-definable characters
+ *	   7e
+ *	   7f	(unused)
+ *
+ *    + Characters 20--7f on each page seem to be initialized by
+ *	system firmware. 
+ */
+
+
+/* UCG-RAM offsets. */
+#define UCG_LOG_MAGIC	0
+#define UCG_LOG_HEAD	12
+#define UCG_LOG_SIZE	14
+#define UCG_LOG_START	16
+#define UCG_LOG_END	(32 * 32 * 2 - 1)
+
+#define UCG_MAGIC_STRING	"Linux/98"
+
+static unsigned int ucg_log_head = UCG_LOG_START;
+static unsigned int ucg_log_size = 0;
+
+static void
+ucglog_write(struct console *console, const char *buf, unsigned int length)
+{
+	unsigned char *const cg_window = UCG_WINDOW;
+
+	/*
+	 * Note that we are called with interrupt disabled
+	 * (spin_lock_irqsave in kernel/printk.c).
+	 */
+
+	if ((ucg_log_size += length) > UCG_MAX_SIZE)
+		ucg_log_size = UCG_MAX_SIZE;
+
+	outb(0x0b, 0x68);	/* bitmap access mode */
+
+	while (length) {
+		unsigned char *p;
+		unsigned int count;
+		u8 lr;
+
+		outb(UCG_2ND_BYTE (ucg_log_head), 0xa1);
+		outb(UCG_1ST_BYTE (ucg_log_head), 0xa3);
+		lr = UCG_LR(ucg_log_head);
+		do {
+			outb(lr, 0xa5);
+			p = cg_window + UCG_OFFSET(ucg_log_head) * 2;
+			count = 16 - UCG_OFFSET(ucg_log_head);
+			if (count > length)
+				count = length;
+			length -= count;
+			ucg_log_head += count;
+			do {
+				*p = *buf++;
+				p += 2;
+			} while (--count);
+		} while (length && (lr ^= UCG_LR_MASK));
+	}
+
+	if (ucg_log_head > UCG_LOG_END)
+		ucg_log_head = UCG_LOG_START;
+	outb(UCG_2ND_BYTE(UCG_LOG_HEAD), 0xa1);
+	outb(UCG_1ST_BYTE(UCG_LOG_HEAD), 0xa3);
+	outb(UCG_LR(UCG_LOG_HEAD), 0xa5);
+	cg_window[(UCG_OFFSET(UCG_LOG_HEAD)) * 2] = ucg_log_head;
+	cg_window[(UCG_OFFSET(UCG_LOG_HEAD) + 1) * 2] = ucg_log_head >> 8;
+#if UCG_CHAR_NR(UCG_LOG_HEAD) != UCG_CHAR_NR(UCG_LOG_SIZE)
+	outb(UCG_2ND_BYTE(UCG_LOG_SIZE), 0xa1);
+	outb(UCG_1ST_BYTE(UCG_LOG_SIZE), 0xa3);
+#endif
+#if UCG_LR(UCG_LOG_HEAD) != UCG_LR(UCG_LOG_SIZE)
+	outb(UCG_LR(UCG_LOG_SIZE), 0xa5);
+#endif
+	cg_window[(UCG_OFFSET(UCG_LOG_SIZE)) * 2] = ucg_log_size;
+	cg_window[(UCG_OFFSET(UCG_LOG_SIZE) + 1) * 2] = ucg_log_size >> 8;
+
+	outb(0x0a, 0x68);
+}
+
+static struct console ucglog_console = {
+	name:	"ucg",
+	write:	ucglog_write,
+	setup:	NULL,
+	flags:	CON_PRINTBUFFER,
+	index:	-1,
+};
+
+static int __init
+ucglog_init(void)
+{
+	unsigned long flags;
+	const u8 *p;
+	u8 *cg_window;
+	static const union {
+		struct {
+			char magic[12];
+			u16 start;
+			u16 size;
+		} s;
+		u8 bytes[16];
+	} ucg_init_data __initdata = { { UCG_MAGIC_STRING, 0, 0 } };
+
+	if (PC9800_HIGHRESO_P()) {
+		/* Not implemented (yet)... */
+		return 0;
+	}
+
+	save_flags(flags);
+	cli();
+	outb(0x0b, 0x68);	/* bitmap access mode */
+	outb(UCG_2ND_BYTE(UCG_LOG_MAGIC), 0xa1);
+	outb(UCG_1ST_BYTE(UCG_LOG_MAGIC), 0xa3);
+	outb(UCG_LR(UCG_LOG_MAGIC), 0xa5);
+	for (cg_window = UCG_WINDOW, p = ucg_init_data.bytes;
+	     p < (&ucg_init_data + 1)->bytes; cg_window += 2)
+		*cg_window = *p++;
+	outb(0x0a, 0x68);
+	restore_flags(flags);
+
+	register_console(&ucglog_console);
+	printk(KERN_INFO "UCG-RAM console driver installed\n");
+	return 0;
+}
+
+__initcall (ucglog_init);
+
+#endif /* CONFIG_PC9800_UCGLOG */
+
+/*
+#define CONFIG_PC9800_UCGSAVEARGS
+*/
+
+#ifdef CONFIG_PC9800_UCGSAVEARGS
+
+#define UCG_SAVEARGS_START	(1 * 32)
+
+void
+ucg_saveargs(unsigned int n, ...)
+{
+	u8 *cg;
+	unsigned int count;
+	unsigned int addr;
+	unsigned long flags;
+	const u8 *p = (const u8 *) (&n - 1);
+
+	save_flags(flags);
+	cli();
+	outb(0x0b, 0x68);	/* bitmap access mode */
+	outb(UCG_2ND_BYTE(UCG_SAVEARGS_START), 0xa1);
+	outb(UCG_1ST_BYTE(UCG_SAVEARGS_START), 0xa3);
+	outb(UCG_LR(UCG_SAVEARGS_START), 0xa5);
+	for (cg = UCG_WINDOW, count = 0; count < 4; count++)
+		cg[count * 2] = p[count];
+
+	addr = UCG_SAVEARGS_START + 4;
+	for (p += 8; n--; p += 4) {
+		if (UCG_OFFSET(addr) == 0) {
+			outb(UCG_2ND_BYTE(addr), 0xa1);
+			outb(UCG_1ST_BYTE(addr), 0xa3);
+			outb(UCG_LR(addr), 0xa5);
+		}
+		cg[(UCG_OFFSET(addr) + 0) * 2] = p[0];
+		cg[(UCG_OFFSET(addr) + 1) * 2] = p[1];
+		cg[(UCG_OFFSET(addr) + 2) * 2] = p[2];
+		cg[(UCG_OFFSET(addr) + 3) * 2] = p[3];
+		addr += 4;
+	}
+
+	outb(UCG_2ND_BYTE(0), 0xa1);
+	outb(UCG_1ST_BYTE(0), 0xa3);
+	outb(UCG_LR(0), 0xa5);
+
+	outb(0x0a, 0x68);
+	restore_flags(flags);
+}
+#endif
+
+#ifdef CONFIG_PC9800_ASSERT
+void
+__assert_fail(const char *base_file, const char *file, unsigned int line,
+	       const char *function, void *return_address, const char *expr)
+{
+  panic("In function `%s' (called from [<%p>])\n" KERN_EMERG
+	 "%s%s%s%s:%u: Assertion `%s' failed.",
+	 function, return_address, file,
+	 base_file == file ? "" : " (",
+	 base_file == file ? "" : base_file,
+	 base_file == file ? "" : ")",
+	 line, expr);
+}
+
+void
+__invalid_kernel_pointer(const char *base_file, const char *file,
+			  unsigned int line, const char *function,
+			  void *return_address,
+			  const char *expr, void *val)
+{
+  panic("In function `%s' (called from [<%p>])\n" KERN_EMERG
+	 "%s%s%s%s:%u: Invalid kernel pointer `%s' (%p).",
+	 function, return_address, file,
+	 base_file == file ? "" : " (",
+	 base_file == file ? "" : base_file,
+	 base_file == file ? "" : ")",
+	 line, expr, val);
+}
+
+#endif /* CONFIG_PC9800_ASSERT */
+
+unsigned char pc9800_saveregs_enabled;
+
+__asm__ (".text\n"
+	 "	.global	__pc9800_saveregs\n"
+	 "__pc9800_saveregs:\n"
+#if 1
+	 "	pushfl\n"
+	 "	cmpb	$0,pc9800_saveregs_enabled\n"
+	 "	je	1f\n"
+	 "	pushl	%edi\n"			/* reverse order of PUSHA */
+	 "	pushl	%esi\n"
+	 "	pushl	%ebp\n"
+	 "	leal	20(%esp),%esi\n"	/* original ESP */
+	 "	pushl	%esi\n"
+	 "	pushl	%ebx\n"
+	 "	pushl	%edx\n"
+	 "	pushl	%ecx\n"
+	 "	pushl	%eax\n"
+	 "	movl	$0xc0000780,%edi\n"	/* save few words on stack */
+	 "	movl	$20, %ecx\n"
+	 "	cld; rep; ss; movsl\n"		/* EDI becomes 0xC00007D0 */
+	 "	subl	$(20+1+1+8)*4,%esi\n"	/* ESI points EAX on stack */
+	 "	movl	$8,%ecx\n"
+	 "	rep; ss; movsl\n"		/* save GP registers */
+	 "	ss; lodsl\n"			/* EFLAGS */
+	 "	ss; movsl\n"			/* save EIP */
+	 "	stosl\n"			/* save EFLAGS */
+	 "	movl	%cr3,%eax\n"		/* save control registers */
+	 "	stosl\n"
+	 "	movl	%cr0,%eax\n"
+	 "	stosl\n"
+	 "	popl	%eax\n"
+	 "	popl	%ecx\n"
+	 "	addl	$4*4,%esp\n"		/* discard EDX/EBX/ESP/EBP */
+	 "	popl	%esi\n"
+	 "	popl	%edi\n"
+	 "1:	popfl\n"
+#else
+	 "	cmpb	$0,pc9800_saveregs_enabled\n"
+	 "	je	1f\n"
+	 "	pushl	%eax\n"
+	 "	movl	%eax,0xc00007d0\n"
+	 "	movl	%ecx,0xc00007d4\n"
+	 "	movl	%edx,0xc00007d8\n"
+	 "	movl	%ebx,0xc00007dc\n"
+	 "	leal	8(%esp),%eax\n"		/* original ESP */
+	 "	movl	%eax,0xc00007e0\n"
+	 "	movl	%ebp,0xc00007e4\n"
+	 "	movl	%esi,0xc00007e8\n"
+	 "	movl	%edi,0xc00007ec\n"
+	 "	movl	4(%esp),%eax\n"		/* EIP as return address */
+	 "	movl	%eax,0xc00007f0\n"
+	 "	pushfl\n"
+	 "	popl	%eax\n"
+	 "	movl	%eax,0xc00007f4\n"
+	 "	movl	%cr3,%eax\n"
+	 "	movl	%eax,0xc00007f8\n"
+	 "	movl	%cr0,%eax\n"
+	 "	movl	%eax,0xc00007fc\n"
+	 "	pushl	%ecx\n"
+	 "	pushl	%esi\n"
+	 "	pushl	%edi\n"
+	 "	leal	20(%esp),%esi\n"
+	 "	movl	$0xc0000780,%edi\n"
+	 "	movl	$16,%ecx\n"
+	 "	cld; rep; ss; movsl\n"
+	 "	popl	%edi\n"
+	 "	popl	%esi\n"
+	 "	popl	%ecx\n"
+	 "	popl	%eax\n"
+	 "1:\n"
+#endif
+	 "	ret");
+
+__asm__ (".weak mcount; mcount = __pc9800_saveregs");
+
+#if 0
+int
+test_mcount(void)
+{
+	printk("Calling mcount...\n");
+	pc9800_saveregs_enabled = 1;
+	mcount();
+}
+
+__initcall (test_mcount);
+#endif
diff -urN linux/arch/i386/kernel/reboot.c linux98/arch/i386/kernel/reboot.c
--- linux/arch/i386/kernel/reboot.c	Sat Oct 19 13:01:20 2002
+++ linux98/arch/i386/kernel/reboot.c	Sun Oct 20 14:59:44 2002
@@ -8,6 +8,7 @@
 #include <linux/interrupt.h>
 #include <linux/mc146818rtc.h>
 #include <asm/uaccess.h>
+#include "mach_reboot.h"
 
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
diff -urN linux/arch/i386/kernel/setup.c linux98/arch/i386/kernel/setup.c
--- linux/arch/i386/kernel/setup.c	Sat Oct 19 13:01:53 2002
+++ linux98/arch/i386/kernel/setup.c	Sat Oct 26 17:05:18 2002
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
 
 static inline char * __init machine_specific_memory_setup(void);
 
@@ -47,7 +49,7 @@
  * Machine setup..
  */
 
-char ignore_irq13;		/* set if exception 16 works */
+char ignore_fpu_irq;		/* set if exception 16 works */
 struct cpuinfo_x86 boot_cpu_data = { 0, 0, 0, 0, -1, 1, 0, 0, -1 };
 
 unsigned long mmu_cr4_features;
@@ -98,98 +100,8 @@
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
@@ -820,11 +732,8 @@
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
@@ -904,6 +813,8 @@
 #ifdef CONFIG_VT
 #if defined(CONFIG_VGA_CONSOLE)
 	conswitchp = &vga_con;
+#elif defined(CONFIG_GDC_CONSOLE)
+	conswitchp = &gdc_con;
 #elif defined(CONFIG_DUMMY_CONSOLE)
 	conswitchp = &dummy_con;
 #endif
diff -urN linux/arch/i386/kernel/time.c linux98/arch/i386/kernel/time.c
--- linux/arch/i386/kernel/time.c	Sat Oct 19 13:01:53 2002
+++ linux98/arch/i386/kernel/time.c	Sun Oct 20 19:57:14 2002
@@ -54,12 +54,15 @@
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
 
 #include "do_timer.h"
@@ -133,69 +136,13 @@
 	write_unlock_irq(&xtime_lock);
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
@@ -221,9 +168,9 @@
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
@@ -237,14 +184,14 @@
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
@@ -289,43 +236,15 @@
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
diff -urN linux/arch/i386/kernel/timers/timer_pit.c linux98/arch/i386/kernel/timers/timer_pit.c
--- linux/arch/i386/kernel/timers/timer_pit.c	Sat Oct 19 13:02:29 2002
+++ linux98/arch/i386/kernel/timers/timer_pit.c	Mon Oct 21 11:39:53 2002
@@ -13,6 +13,7 @@
 extern spinlock_t i8259A_lock;
 extern spinlock_t i8253_lock;
 #include "do_timer.h"
+#include "io_ports.h"
 
 static int init_pit(void)
 {
@@ -61,7 +62,8 @@
 {
 	int count;
 
-	static int count_p = LATCH;    /* for the first call after boot */
+	static int count_p;
+	static int is_1st_boot = 1;    /* for the first call after boot */
 	static unsigned long jiffies_p = 0;
 
 	/*
@@ -69,12 +71,18 @@
 	 */
 	unsigned long jiffies_t;
 
+	/* for support LATCH is not constant */
+	if (is_1st_boot) {
+		is_1st_boot = 0;
+		count_p = LATCH;
+	}
+
 	/* gets recalled with irq locally disabled */
 	spin_lock(&i8253_lock);
 	/* timer count may underflow right here */
-	outb_p(0x00, 0x43);	/* latch the count ASAP */
+	outb_p(0x00, PIT_MODE);	/* latch the count ASAP */
 
-	count = inb_p(0x40);	/* read the latched count */
+	count = inb_p(PIT_CH0);	/* read the latched count */
 
 	/*
 	 * We do this guaranteed double memory access instead of a _p 
@@ -82,13 +90,13 @@
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
 	
diff -urN linux/arch/i386/kernel/timers/timer_tsc.c linux98/arch/i386/kernel/timers/timer_tsc.c
--- linux/arch/i386/kernel/timers/timer_tsc.c	Sat Oct 19 13:02:24 2002
+++ linux98/arch/i386/kernel/timers/timer_tsc.c	Sun Oct 20 22:48:53 2002
@@ -12,6 +12,9 @@
 #include <asm/timer.h>
 #include <asm/io.h>
 
+#include "io_ports.h"
+#include "calibrate_tsc.h"
+
 extern int x86_udelay_tsc;
 extern spinlock_t i8253_lock;
 
@@ -19,8 +22,6 @@
 /* Number of usecs that the last interrupt was delayed */
 static int delay_at_last_interrupt;
 
-static unsigned long last_tsc_low; /* lsb 32 bits of Time Stamp Counter */
-
 /* Cached *multiplier* to convert TSC counts to microseconds.
  * (see the equation below).
  * Equal to 2^32 * (1 / (clocks per usec) ).
@@ -77,10 +78,10 @@
 	rdtscl(last_tsc_low);
 
 	spin_lock(&i8253_lock);
-	outb_p(0x00, 0x43);     /* latch the count ASAP */
+	outb_p(0x00, PIT_MODE);     /* latch the count ASAP */
 
-	count = inb_p(0x40);    /* read the latched count */
-	count |= inb(0x40) << 8;
+	count = inb_p(PIT_CH0);    /* read the latched count */
+	count |= inb(PIT_CH0) << 8;
 	spin_unlock(&i8253_lock);
 
 	count = ((LATCH-1) - count) * TICK_SIZE;
@@ -88,83 +89,6 @@
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
-static unsigned long __init calibrate_tsc(void)
-{
-       /* Set the Gate high, disable speaker */
-	outb((inb(0x61) & ~0x02) | 0x01, 0x61);
-
-	/*
-	 * Now let's take care of CTC channel 2
-	 *
-	 * Set the Gate high, program CTC channel 2 for mode 0,
-	 * (interrupt on terminal count mode), binary count,
-	 * load 5 * LATCH count, (LSB and MSB) to begin countdown.
-	 */
-	outb(0xb0, 0x43);			/* binary, mode 0, LSB/MSB, Ch 2 */
-	outb(CALIBRATE_LATCH & 0xff, 0x42);	/* LSB of count */
-	outb(CALIBRATE_LATCH >> 8, 0x42);	/* MSB of count */
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
-}
-
 
 #ifdef CONFIG_CPU_FREQ
 
diff -urN linux/arch/i386/kernel/traps.c linux98/arch/i386/kernel/traps.c
--- linux/arch/i386/kernel/traps.c	Sat Oct 19 13:01:16 2002
+++ linux98/arch/i386/kernel/traps.c	Mon Oct 21 00:25:38 2002
@@ -49,6 +49,8 @@
 #include <linux/irq.h>
 #include <linux/module.h>
 
+#include "mach_traps.h"
+
 asmlinkage int system_call(void);
 asmlinkage void lcall7(void);
 asmlinkage void lcall27(void);
@@ -449,11 +451,10 @@
 	printk("You probably have a hardware problem with your RAM chips\n");
 
 	/* Clear and disable the memory parity error line. */
-	reason = (reason & 0xf) | 4;
-	outb(reason, 0x61);
+	clear_mem_error(reason);
 }
 
-static void io_check_error(unsigned char reason, struct pt_regs * regs)
+static inline void io_check_error(unsigned char reason, struct pt_regs * regs)
 {
 	unsigned long i;
 
@@ -487,8 +488,9 @@
 
 static void default_do_nmi(struct pt_regs * regs)
 {
-	unsigned char reason = inb(0x61);
+	unsigned char reason;
  
+	reason = get_nmi_reason();
 	if (!(reason & 0xc0)) {
 #if CONFIG_X86_LOCAL_APIC
 		/*
@@ -506,15 +508,12 @@
 	if (reason & 0x80)
 		mem_parity_error(reason, regs);
 	if (reason & 0x40)
-		io_check_error(reason, regs);
+		HANDLE_REASON_0X40(reason, regs);
 	/*
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
@@ -697,7 +696,7 @@
 
 asmlinkage void do_coprocessor_error(struct pt_regs * regs, long error_code)
 {
-	ignore_irq13 = 1;
+	ignore_fpu_irq = 1;
 	math_error((void *)regs->eip);
 }
 
@@ -754,7 +753,7 @@
 {
 	if (cpu_has_xmm) {
 		/* Handle SIMD FPU exceptions on PIII+ processors. */
-		ignore_irq13 = 1;
+		ignore_fpu_irq = 1;
 		simd_math_error((void *)regs->eip);
 	} else {
 		/*
diff -urN linux/arch/i386/kernel/vm86.c linux98/arch/i386/kernel/vm86.c
--- linux/arch/i386/kernel/vm86.c	Sat Oct 12 13:21:31 2002
+++ linux98/arch/i386/kernel/vm86.c	Sat Oct 12 16:09:20 2002
@@ -30,6 +30,7 @@
  *
  */
 
+#include <linux/config.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
 #include <linux/kernel.h>
@@ -732,10 +733,22 @@
 		free_vm86_irq(i);
 }
 
+#ifndef CONFIG_PC9800
+# define ILLEGAL_IRQ(irq) ((irq) < 3 || (irq) > 15)
+# define FIRST_VM86_IRQ	3
+#else
+/*
+ * On PC-9800, slave PIC is wired master PIC's IR7,
+ * so that we don't allow vm86 to grab IRQ7.
+ */
+# define ILLEGAL_IRQ(irq) ((irq) < 2 || (irq) == 7 || (irq) > 15)
+# define FIRST_VM86_IRQ	2
+#endif
+
 static inline void handle_irq_zombies(void)
 {
 	int i;
-	for (i=3; i<16; i++) {
+	for (i=FIRST_VM86_IRQ; i<16; i++) {
 		if (vm86_irqs[i].tsk) {
 			if (task_valid(vm86_irqs[i].tsk)) continue;
 			free_vm86_irq(i);
@@ -748,7 +761,7 @@
 	int bit;
 	unsigned long flags;
 	
-	if ( (irqnumber<3) || (irqnumber>15) ) return 0;
+	if (ILLEGAL_IRQ(irqnumber)) return 0;
 	if (vm86_irqs[irqnumber].tsk != current) return 0;
 	spin_lock_irqsave(&irqbits_lock, flags);	
 	bit = irqbits & (1 << irqnumber);
@@ -774,7 +787,7 @@
 			handle_irq_zombies();
 			if (!capable(CAP_SYS_ADMIN)) return -EPERM;
 			if (!((1 << sig) & ALLOWED_SIGS)) return -EPERM;
-			if ( (irq<3) || (irq>15) ) return -EPERM;
+			if (ILLEGAL_IRQ(irq)) return -EPERM;
 			if (vm86_irqs[irq].tsk) return -EPERM;
 			ret = request_irq(irq, &irq_handler, 0, VM86_IRQNAME, 0);
 			if (ret) return ret;
@@ -784,7 +797,7 @@
 		}
 		case  VM86_FREE_IRQ: {
 			handle_irq_zombies();
-			if ( (irqnumber<3) || (irqnumber>15) ) return -EPERM;
+			if (ILLEGAL_IRQ(irqnumber)) return -EPERM;
 			if (!vm86_irqs[irqnumber].tsk) return 0;
 			if (vm86_irqs[irqnumber].tsk != current) return -EPERM;
 			free_vm86_irq(irqnumber);
diff -urN linux/arch/i386/mach-generic/calibrate_tsc.h linux98/arch/i386/mach-generic/calibrate_tsc.h
--- linux/arch/i386/mach-generic/calibrate_tsc.h	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-generic/calibrate_tsc.h	Mon Oct 21 09:30:16 2002
@@ -0,0 +1,88 @@
+/*
+ *  arch/i386/mach-generic/calibrate_tsc.h
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
+static inline unsigned long calibrate_tsc(void)
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
diff -urN linux/arch/i386/mach-generic/io_ports.h linux98/arch/i386/mach-generic/io_ports.h
--- linux/arch/i386/mach-generic/io_ports.h	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-generic/io_ports.h	Mon Oct 21 09:47:38 2002
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
diff -urN linux/arch/i386/mach-generic/mach_reboot.h linux98/arch/i386/mach-generic/mach_reboot.h
--- linux/arch/i386/mach-generic/mach_reboot.h	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-generic/mach_reboot.h	Mon Oct 21 09:53:44 2002
@@ -0,0 +1,30 @@
+/*
+ *  arch/i386/mach-generic/mach_reboot.h
+ *
+ *  Machine specific reboot functions for generic.
+ *  Split out from reboot.c by Osamu Tomita <tomita@cinet.co.jp>
+ */
+#ifndef _MACH_REBOOT_H
+#define _MACH_REBOOT_H
+
+static inline void kb_wait(void)
+{
+	int i;
+
+	for (i = 0; i < 0x10000; i++)
+		if ((inb_p(0x64) & 0x02) == 0)
+			break;
+}
+
+static inline void mach_reboot(void)
+{
+	int i;
+	for (i = 0; i < 100; i++) {
+		kb_wait();
+		udelay(50);
+		outb(0xfe, 0x64);         /* pulse reset low */
+		udelay(50);
+	}
+}
+
+#endif /* !_MACH_REBOOT_H */
diff -urN linux/arch/i386/mach-generic/mach_resources.h linux98/arch/i386/mach-generic/mach_resources.h
--- linux/arch/i386/mach-generic/mach_resources.h	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-generic/mach_resources.h	Mon Oct 21 09:59:22 2002
@@ -0,0 +1,113 @@
+/*
+ *  arch/i386/mach-generic/mach_resources.h
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
diff -urN linux/arch/i386/mach-generic/mach_time.h linux98/arch/i386/mach-generic/mach_time.h
--- linux/arch/i386/mach-generic/mach_time.h	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-generic/mach_time.h	Mon Oct 21 10:07:35 2002
@@ -0,0 +1,122 @@
+/*
+ *  arch/i386/mach-generic/mach_time.h
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
diff -urN linux/arch/i386/mach-generic/mach_traps.h linux98/arch/i386/mach-generic/mach_traps.h
--- linux/arch/i386/mach-generic/mach_traps.h	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-generic/mach_traps.h	Mon Oct 21 10:17:02 2002
@@ -0,0 +1,31 @@
+/*
+ *  arch/i386/mach-generic/mach_traps.h
+ *
+ *  Machine specific NMI handling for generic.
+ *  Split out from traps.c by Osamu Tomita <tomita@cinet.co.jp>
+ */
+#ifndef _MACH_TRAPS_H
+#define _MACH_TRAPS_H
+
+#define HANDLE_REASON_0X40(reason, regs) io_check_error(reason, regs)
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
diff -urN linux/arch/i386/mach-pc9800/Makefile linux98/arch/i386/mach-pc9800/Makefile
--- linux/arch/i386/mach-pc9800/Makefile	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-pc9800/Makefile	Sat Sep 21 00:20:21 2002
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
diff -urN linux/arch/i386/mach-pc9800/calibrate_tsc.h linux98/arch/i386/mach-pc9800/calibrate_tsc.h
--- linux/arch/i386/mach-pc9800/calibrate_tsc.h	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-pc9800/calibrate_tsc.h	Mon Oct 21 11:01:05 2002
@@ -0,0 +1,73 @@
+/*
+ *  arch/i386/mach-pc9800/calibrate_tsc.h
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
+static inline unsigned long calibrate_tsc(void)
+{
+
+	{
+		unsigned long startlow, starthigh;
+		unsigned long endlow, endhigh;
+		unsigned short count;
+
+		for (count = inw(0x5c); inw(0x5c) == count; )
+			;
+		rdtsc(startlow,starthigh);
+		count = inw(0x5c);
+		while ((unsigned short)(inw(0x5c) - count) < CALIBRATE_LATCH)
+			;
+		rdtsc(endlow,endhigh);
+
+		last_tsc_low = endlow;
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
diff -urN linux/arch/i386/mach-pc9800/do_timer.h linux98/arch/i386/mach-pc9800/do_timer.h
--- linux/arch/i386/mach-pc9800/do_timer.h	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-pc9800/do_timer.h	Wed Oct 16 13:20:29 2002
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
diff -urN linux/arch/i386/mach-pc9800/entry_arch.h linux98/arch/i386/mach-pc9800/entry_arch.h
--- linux/arch/i386/mach-pc9800/entry_arch.h	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-pc9800/entry_arch.h	Sun Oct 20 17:42:49 2002
@@ -0,0 +1 @@
+#include "../mach-generic/entry_arch.h"
diff -urN linux/arch/i386/mach-pc9800/io_ports.h linux98/arch/i386/mach-pc9800/io_ports.h
--- linux/arch/i386/mach-pc9800/io_ports.h	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-pc9800/io_ports.h	Mon Oct 21 11:03:30 2002
@@ -0,0 +1,30 @@
+/*
+ *  arch/i386/mach-pc9800/io_ports.h
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
diff -urN linux/arch/i386/mach-pc9800/irq_vectors.h linux98/arch/i386/mach-pc9800/irq_vectors.h
--- linux/arch/i386/mach-pc9800/irq_vectors.h	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-pc9800/irq_vectors.h	Sun Oct 20 17:45:10 2002
@@ -0,0 +1 @@
+#include "../mach-generic/irq_vectors.h"
diff -urN linux/arch/i386/mach-pc9800/mach_apic.h linux98/arch/i386/mach-pc9800/mach_apic.h
--- linux/arch/i386/mach-pc9800/mach_apic.h	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-pc9800/mach_apic.h	Sun Oct 20 17:46:53 2002
@@ -0,0 +1 @@
+#include "../mach-generic/mach_apic.h"
diff -urN linux/arch/i386/mach-pc9800/mach_reboot.h linux98/arch/i386/mach-pc9800/mach_reboot.h
--- linux/arch/i386/mach-pc9800/mach_reboot.h	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-pc9800/mach_reboot.h	Mon Oct 21 11:07:36 2002
@@ -0,0 +1,21 @@
+/*
+ *  arch/i386/mach-pc9800/mach_reboot.h
+ *
+ *  Machine specific reboot functions for PC-9800.
+ *  Written by Osamu Tomita <tomita@cinet.co.jp>
+ */
+#ifndef _MACH_REBOOT_H
+#define _MACH_REBOOT_H
+
+#ifdef CMOS_WRITE
+#undef CMOS_WRITE
+#define CMOS_WRITE(a,b)	do{}while(0)
+#endif
+
+static inline void mach_reboot(void)
+{
+	outb(0, 0xf0);		/* signal CPU reset */
+	mdelay(1);
+}
+
+#endif /* !_MACH_REBOOT_H */
diff -urN linux/arch/i386/mach-pc9800/mach_resources.h linux98/arch/i386/mach-pc9800/mach_resources.h
--- linux/arch/i386/mach-pc9800/mach_resources.h	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-pc9800/mach_resources.h	Sat Oct 26 17:35:19 2002
@@ -0,0 +1,192 @@
+/*
+ *  arch/i386/mach-pc9800/mach_resources.h
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
diff -urN linux/arch/i386/mach-pc9800/mach_time.h linux98/arch/i386/mach-pc9800/mach_time.h
--- linux/arch/i386/mach-pc9800/mach_time.h	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-pc9800/mach_time.h	Mon Oct 21 11:23:06 2002
@@ -0,0 +1,136 @@
+/*
+ *  arch/i386/mach-pc9800/mach_time.h
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
diff -urN linux/arch/i386/mach-pc9800/mach_traps.h linux98/arch/i386/mach-pc9800/mach_traps.h
--- linux/arch/i386/mach-pc9800/mach_traps.h	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-pc9800/mach_traps.h	Mon Oct 21 11:26:12 2002
@@ -0,0 +1,29 @@
+/*
+ *  arch/i386/mach-pc9800/mach_traps.h
+ *
+ *  Machine specific NMI handling for PC-9800.
+ *  Written by Osamu Tomita <tomita@cinet.co.jp>
+ */
+#ifndef _MACH_TRAPS_H
+#define _MACH_TRAPS_H
+
+#define HANDLE_REASON_0X40(reason, regs) mem_parity_error(reason, regs)
+
+static inline void clear_mem_error(unsigned char reason)
+{
+	outb(0x08, 0x37);
+	outb(0x09, 0x37);
+}
+
+static inline unsigned char get_nmi_reason(void)
+{
+	return inb(0x33) << 5;
+}
+
+static inline void reassert_nmi(void)
+{
+	outb(0x09, 0x50);	/* disable NMI once */
+	outb(0x09, 0x52);	/* re-enable it */
+}
+
+#endif /* !_MACH_TRAPS_H */
diff -urN linux/arch/i386/mach-pc9800/setup.c linux98/arch/i386/mach-pc9800/setup.c
--- linux/arch/i386/mach-pc9800/setup.c	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-pc9800/setup.c	Sat Oct 26 17:08:45 2002
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
diff -urN linux/arch/i386/mach-pc9800/setup_arch_post.h linux98/arch/i386/mach-pc9800/setup_arch_post.h
--- linux/arch/i386/mach-pc9800/setup_arch_post.h	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-pc9800/setup_arch_post.h	Sat Sep 21 23:00:26 2002
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
diff -urN linux/arch/i386/mach-pc9800/setup_arch_pre.h linux98/arch/i386/mach-pc9800/setup_arch_pre.h
--- linux/arch/i386/mach-pc9800/setup_arch_pre.h	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-pc9800/setup_arch_pre.h	Sun Sep 22 07:58:29 2002
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
diff -urN linux/arch/i386/mach-pc9800/smpboot_hooks.h linux98/arch/i386/mach-pc9800/smpboot_hooks.h
--- linux/arch/i386/mach-pc9800/smpboot_hooks.h	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-pc9800/smpboot_hooks.h	Sun Sep 22 06:56:46 2002
@@ -0,0 +1,33 @@
+/* two abstractions specific to kernel/smpboot.c, mainly to cater to visws
+ * which needs to alter them. */
+
+static inline void smpboot_clear_io_apic_irqs(void)
+{
+	io_apic_irqs = 0;
+}
+
+static inline void smpboot_setup_warm_reset_vector(void)
+{
+	/*
+	 * Install writable page 0 entry to set BIOS data area.
+	 */
+	local_flush_tlb();
+
+	/*
+	 * Paranoid:  Set warm reset code and vector here back
+	 * to default values.
+	 */
+	outb(0x0f, 0x37);	/* SHUT0 = 1 */
+
+	*((volatile long *) phys_to_virt(0x404)) = 0;
+}
+
+static inline void smpboot_setup_io_apic(void)
+{
+	/*
+	 * Here we can be sure that there is an IO-APIC in the system. Let's
+	 * go and set it up:
+	 */
+	if (!skip_ioapic_setup && nr_ioapics)
+		setup_IO_APIC();
+}
diff -urN linux/arch/i386/mach-summit/calibrate_tsc.h linux98/arch/i386/mach-summit/calibrate_tsc.h
--- linux/arch/i386/mach-summit/calibrate_tsc.h	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-summit/calibrate_tsc.h	Mon Oct 21 02:46:34 2002
@@ -0,0 +1 @@
+#include "../mach-generic/calibrate_tsc.h"
diff -urN linux/arch/i386/mach-summit/io_ports.h linux98/arch/i386/mach-summit/io_ports.h
--- linux/arch/i386/mach-summit/io_ports.h	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-summit/io_ports.h	Sun Oct 20 18:08:54 2002
@@ -0,0 +1 @@
+#include "../mach-generic/io_ports.h"
diff -urN linux/arch/i386/mach-summit/mach_reboot.h linux98/arch/i386/mach-summit/mach_reboot.h
--- linux/arch/i386/mach-summit/mach_reboot.h	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-summit/mach_reboot.h	Sun Oct 20 18:10:25 2002
@@ -0,0 +1 @@
+#include "../mach-generic/mach_reboot.h"
diff -urN linux/arch/i386/mach-summit/mach_resources.h linux98/arch/i386/mach-summit/mach_resources.h
--- linux/arch/i386/mach-summit/mach_resources.h	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-summit/mach_resources.h	Sun Oct 20 18:11:27 2002
@@ -0,0 +1 @@
+#include "../mach-generic/mach_resources.h"
diff -urN linux/arch/i386/mach-summit/mach_time.h linux98/arch/i386/mach-summit/mach_time.h
--- linux/arch/i386/mach-summit/mach_time.h	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-summit/mach_time.h	Sun Oct 20 20:00:44 2002
@@ -0,0 +1 @@
+#include "../mach-generic/mach_time.h"
diff -urN linux/arch/i386/mach-summit/mach_traps.h linux98/arch/i386/mach-summit/mach_traps.h
--- linux/arch/i386/mach-summit/mach_traps.h	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-summit/mach_traps.h	Mon Oct 21 02:48:48 2002
@@ -0,0 +1 @@
+#include "../mach-generic/mach_traps.h"
diff -urN linux/arch/i386/mach-visws/calibrate_tsc.h linux98/arch/i386/mach-visws/calibrate_tsc.h
--- linux/arch/i386/mach-visws/calibrate_tsc.h	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-visws/calibrate_tsc.h	Mon Oct 21 02:46:34 2002
@@ -0,0 +1 @@
+#include "../mach-generic/calibrate_tsc.h"
diff -urN linux/arch/i386/mach-visws/io_ports.h linux98/arch/i386/mach-visws/io_ports.h
--- linux/arch/i386/mach-visws/io_ports.h	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-visws/io_ports.h	Sun Oct 20 18:08:54 2002
@@ -0,0 +1 @@
+#include "../mach-generic/io_ports.h"
diff -urN linux/arch/i386/mach-visws/mach_reboot.h linux98/arch/i386/mach-visws/mach_reboot.h
--- linux/arch/i386/mach-visws/mach_reboot.h	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-visws/mach_reboot.h	Sun Oct 20 18:10:25 2002
@@ -0,0 +1 @@
+#include "../mach-generic/mach_reboot.h"
diff -urN linux/arch/i386/mach-visws/mach_resources.h linux98/arch/i386/mach-visws/mach_resources.h
--- linux/arch/i386/mach-visws/mach_resources.h	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-visws/mach_resources.h	Sun Oct 20 18:11:27 2002
@@ -0,0 +1 @@
+#include "../mach-generic/mach_resources.h"
diff -urN linux/arch/i386/mach-visws/mach_time.h linux98/arch/i386/mach-visws/mach_time.h
--- linux/arch/i386/mach-visws/mach_time.h	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-visws/mach_time.h	Sun Oct 20 20:00:44 2002
@@ -0,0 +1 @@
+#include "../mach-generic/mach_time.h"
diff -urN linux/arch/i386/mach-visws/mach_traps.h linux98/arch/i386/mach-visws/mach_traps.h
--- linux/arch/i386/mach-visws/mach_traps.h	Thu Jan  1 09:00:00 1970
+++ linux98/arch/i386/mach-visws/mach_traps.h	Mon Oct 21 02:48:48 2002
@@ -0,0 +1 @@
+#include "../mach-generic/mach_traps.h"
