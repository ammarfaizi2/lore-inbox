Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262009AbUJZCq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbUJZCq6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 22:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbUJZCq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 22:46:56 -0400
Received: from gate.crashing.org ([63.228.1.57]:36823 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262215AbUJZCaD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 22:30:03 -0400
Subject: [PATCH] ppc64: Add new "Maple" platform support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 26 Oct 2004 12:26:51 +1000
Message-Id: <1098757611.17887.32.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch adds support for the Maple 970FX Eval Board. It adds the basic arch
support. For the Maple to be fully functional, it needs a couple more patches to
be applied for IDE and Ethernet that are currently pending with the respective
maintainers of those subsystems.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/include/asm-ppc64/processor.h
===================================================================
--- linux-work.orig/include/asm-ppc64/processor.h	2004-10-26 08:30:22.000000000 +1000
+++ linux-work/include/asm-ppc64/processor.h	2004-10-26 12:24:06.300890784 +1000
@@ -389,6 +389,7 @@
 #define PLATFORM_ISERIES_LPAR 0x0201
 #define PLATFORM_LPAR         0x0001
 #define PLATFORM_POWERMAC     0x0400
+#define PLATFORM_MAPLE        0x0500
 
 /* Compatibility with drivers coming from PPC32 world */
 #define _machine	(systemcfg->platform)
Index: linux-work/arch/ppc64/kernel/Makefile
===================================================================
--- linux-work.orig/arch/ppc64/kernel/Makefile	2004-10-25 21:58:12.000000000 +1000
+++ linux-work/arch/ppc64/kernel/Makefile	2004-10-26 12:24:06.301890632 +1000
@@ -49,12 +49,15 @@
 obj-$(CONFIG_PPC_PMAC)		+= pmac_setup.o pmac_feature.o pmac_pci.o \
 				   pmac_time.o pmac_nvram.o pmac_low_i2c.o
 
+obj-$(CONFIG_PPC_MAPLE)		+= maple_setup.o maple_pci.o maple_time.o
+
 obj-$(CONFIG_U3_DART)		+= u3_iommu.o
 
 ifdef CONFIG_SMP
 obj-$(CONFIG_PPC_PMAC)		+= pmac_smp.o smp-tbsync.o
 obj-$(CONFIG_PPC_ISERIES)	+= iSeries_smp.o
 obj-$(CONFIG_PPC_PSERIES)	+= pSeries_smp.o
+obj-$(CONFIG_PPC_MAPLE)		+= smp-tbsync.o
 endif
 
 obj-$(CONFIG_ALTIVEC)		+= vecemu.o vector.o
Index: linux-work/arch/ppc64/kernel/prom_init.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/prom_init.c	2004-10-25 21:58:12.000000000 +1000
+++ linux-work/arch/ppc64/kernel/prom_init.c	2004-10-26 12:24:06.304890176 +1000
@@ -1132,6 +1132,8 @@
 			if (strstr(p, RELOC("Power Macintosh")) ||
 			    strstr(p, RELOC("MacRISC4")))
 				return PLATFORM_POWERMAC;
+			if (strstr(p, RELOC("Momentum,Maple")))
+				return PLATFORM_MAPLE;
 			i += sl + 1;
 		}
 	}
Index: linux-work/arch/ppc64/kernel/idle.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/idle.c	2004-10-17 12:07:05.000000000 +1000
+++ linux-work/arch/ppc64/kernel/idle.c	2004-10-26 12:24:06.305890024 +1000
@@ -22,6 +22,7 @@
 #include <linux/cpu.h>
 #include <linux/module.h>
 #include <linux/sysctl.h>
+#include <linux/smp.h>
 
 #include <asm/system.h>
 #include <asm/processor.h>
@@ -363,12 +364,13 @@
 		}
 	}
 #endif /* CONFIG_PPC_PSERIES */
-#ifdef CONFIG_PPC_PMAC
-	if (systemcfg->platform == PLATFORM_POWERMAC) {
+#ifndef CONFIG_PPC_ISERIES
+	if (systemcfg->platform == PLATFORM_POWERMAC ||
+	    systemcfg->platform == PLATFORM_MAPLE) {
 		printk(KERN_INFO "Using native/NAP idle loop\n");
 		idle_loop = native_idle;
 	}
-#endif /* CONFIG_PPC_PMAC */
+#endif /* CONFIG_PPC_ISERIES */
 
 	return 1;
 }
Index: linux-work/arch/ppc64/kernel/udbg.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/udbg.c	2004-10-25 21:58:12.000000000 +1000
+++ linux-work/arch/ppc64/kernel/udbg.c	2004-10-26 12:24:06.306889872 +1000
@@ -20,6 +20,9 @@
 #include <asm/prom.h>
 #include <asm/pmac_feature.h>
 
+extern u8 real_readb(volatile u8 *addr);
+extern void real_writeb(u8 data, volatile u8 *addr);
+
 struct NS16550 {
 	/* this struct must be packed */
 	unsigned char rbr;  /* 0 */
@@ -148,9 +151,6 @@
 #endif /* CONFIG_PPC_PMAC */
 
 #if CONFIG_PPC_PMAC
-extern u8 real_readb(volatile u8 *addr);
-extern void real_writeb(u8 data, volatile u8 *addr);
-
 static void udbg_real_putc(unsigned char c)
 {
 	while ((real_readb(sccc) & SCC_TXRDY) == 0)
@@ -171,6 +171,32 @@
 }
 #endif /* CONFIG_PPC_PMAC */
 
+#ifdef CONFIG_PPC_MAPLE
+void udbg_maple_real_putc(unsigned char c)
+{
+	if (udbg_comport) {
+		while ((real_readb(&udbg_comport->lsr) & LSR_THRE) == 0)
+			/* wait for idle */;
+		real_writeb(c, &udbg_comport->thr); eieio();
+		if (c == '\n') {
+			/* Also put a CR.  This is for convenience. */
+			while ((real_readb(&udbg_comport->lsr) & LSR_THRE) == 0)
+				/* wait for idle */;
+			real_writeb('\r', &udbg_comport->thr); eieio();
+		}
+	}
+}
+
+void udbg_init_maple_realmode(void)
+{
+	udbg_comport = (volatile struct NS16550 *)0xf40003f8;
+
+	ppc_md.udbg_putc = udbg_maple_real_putc;
+	ppc_md.udbg_getc = NULL;
+	ppc_md.udbg_getc_poll = NULL;
+}
+#endif /* CONFIG_PPC_MAPLE */
+
 void udbg_putc(unsigned char c)
 {
 	if (udbg_comport) {
Index: linux-work/arch/ppc64/Makefile
===================================================================
--- linux-work.orig/arch/ppc64/Makefile	2004-10-13 08:59:06.000000000 +1000
+++ linux-work/arch/ppc64/Makefile	2004-10-26 12:24:06.307889720 +1000
@@ -55,11 +55,13 @@
 boot := arch/ppc64/boot
 
 boottarget-$(CONFIG_PPC_PSERIES) := zImage zImage.initrd
+boottarget-$(CONFIG_PPC_MAPLE) := zImage zImage.initrd
 boottarget-$(CONFIG_PPC_ISERIES) := vmlinux.sminitrd vmlinux.initrd vmlinux.sm
 $(boottarget-y): vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
 bootimage-$(CONFIG_PPC_PSERIES) := zImage
+bootimage-$(CONFIG_PPC_MAPLE) := zImage
 bootimage-$(CONFIG_PPC_ISERIES) := vmlinux
 BOOTIMAGE := $(bootimage-y)
 install: vmlinux
Index: linux-work/arch/ppc64/kernel/maple_setup.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/ppc64/kernel/maple_setup.c	2004-10-26 12:24:06.309889416 +1000
@@ -0,0 +1,243 @@
+/*
+ *  arch/ppc64/kernel/maple_setup.c
+ *
+ *  (c) Copyright 2004 Benjamin Herrenschmidt (benh@kernel.crashing.org),
+ *                     IBM Corp. 
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ *
+ */
+
+#define DEBUG
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/stddef.h>
+#include <linux/unistd.h>
+#include <linux/ptrace.h>
+#include <linux/slab.h>
+#include <linux/user.h>
+#include <linux/a.out.h>
+#include <linux/tty.h>
+#include <linux/string.h>
+#include <linux/delay.h>
+#include <linux/ioport.h>
+#include <linux/major.h>
+#include <linux/initrd.h>
+#include <linux/vt_kern.h>
+#include <linux/console.h>
+#include <linux/ide.h>
+#include <linux/pci.h>
+#include <linux/adb.h>
+#include <linux/cuda.h>
+#include <linux/pmu.h>
+#include <linux/irq.h>
+#include <linux/seq_file.h>
+#include <linux/root_dev.h>
+#include <linux/serial.h>
+#include <linux/smp.h>
+
+#include <asm/processor.h>
+#include <asm/sections.h>
+#include <asm/prom.h>
+#include <asm/system.h>
+#include <asm/pgtable.h>
+#include <asm/bitops.h>
+#include <asm/io.h>
+#include <asm/pci-bridge.h>
+#include <asm/iommu.h>
+#include <asm/machdep.h>
+#include <asm/dma.h>
+#include <asm/cputable.h>
+#include <asm/time.h>
+#include <asm/of_device.h>
+#include <asm/lmb.h>
+
+#include "mpic.h"
+
+#ifdef DEBUG
+#define DBG(fmt...) udbg_printf(fmt)
+#else
+#define DBG(fmt...)
+#endif
+
+extern int maple_set_rtc_time(struct rtc_time *tm);
+extern void maple_get_rtc_time(struct rtc_time *tm);
+extern void maple_get_boot_time(struct rtc_time *tm);
+extern void maple_calibrate_decr(void);
+extern void maple_pci_init(void);
+extern void maple_pcibios_fixup(void);
+extern int maple_pci_get_legacy_ide_irq(struct pci_dev *dev, int channel);
+extern void generic_find_legacy_serial_ports(unsigned int *default_speed);
+
+
+static void maple_restart(char *cmd)
+{
+}
+
+static void maple_power_off(void)
+{
+}
+
+static void maple_halt(void)
+{
+}
+
+#ifdef CONFIG_SMP
+struct smp_ops_t maple_smp_ops = {
+	.probe		= smp_mpic_probe,
+	.message_pass	= smp_mpic_message_pass,
+	.kick_cpu	= smp_generic_kick_cpu,
+	.setup_cpu	= smp_mpic_setup_cpu,
+	.give_timebase	= smp_generic_give_timebase,
+	.take_timebase	= smp_generic_take_timebase,
+};
+#endif /* CONFIG_SMP */
+
+void __init maple_setup_arch(void)
+{
+	/* init to some ~sane value until calibrate_delay() runs */
+	loops_per_jiffy = 50000000;
+
+	/* Setup SMP callback */
+#ifdef CONFIG_SMP
+	smp_ops = &maple_smp_ops;
+#endif
+	/* Setup the PCI DMA to "direct" by default. May be overriden
+	 * by iommu later on
+	 */
+	pci_dma_init_direct();
+
+	/* Lookup PCI hosts */
+       	maple_pci_init();
+
+#ifdef CONFIG_DUMMY_CONSOLE
+	conswitchp = &dummy_con;
+#endif
+}
+
+/* 
+ * Early initialization.
+ */
+static void __init maple_init_early(void)
+{
+	unsigned int default_speed;
+
+	DBG(" -> maple_init_early\n");
+
+	/* Initialize hash table, from now on, we can take hash faults
+	 * and call ioremap
+	 */
+	hpte_init_native();
+
+	/* Find the serial port */
+       	generic_find_legacy_serial_ports(&default_speed);
+
+	DBG("naca->serialPortAddr: %lx\n", (long)naca->serialPortAddr);
+
+	if (naca->serialPortAddr) {
+		void *comport;
+		/* Map the uart for udbg. */
+		comport = (void *)__ioremap(naca->serialPortAddr, 16, _PAGE_NO_CACHE);
+		udbg_init_uart(comport, default_speed);
+
+		ppc_md.udbg_putc = udbg_putc;
+		ppc_md.udbg_getc = udbg_getc;
+		ppc_md.udbg_getc_poll = udbg_getc_poll;
+		DBG("Hello World !\n");
+	}
+
+	/* Setup interrupt mapping options */
+	naca->interrupt_controller = IC_OPEN_PIC;
+
+	DBG(" <- maple_init_early\n");
+}
+
+
+static __init void maple_init_IRQ(void)
+{
+	struct device_node *root;
+	unsigned int *opprop;
+	unsigned long opic_addr;
+	struct mpic *mpic;
+	unsigned char senses[128];
+	int n;
+
+	DBG(" -> maple_init_IRQ\n");
+
+	/* XXX: Non standard, replace that with a proper openpic/mpic node
+	 * in the device-tree. Find the Open PIC if present */
+	root = of_find_node_by_path("/");
+	opprop = (unsigned int *) get_property(root,
+				"platform-open-pic", NULL);
+	if (opprop == 0)
+		panic("OpenPIC not found !\n");
+
+	n = prom_n_addr_cells(root);
+	for (opic_addr = 0; n > 0; --n)
+		opic_addr = (opic_addr << 32) + *opprop++;
+	of_node_put(root);
+
+	/* Obtain sense values from device-tree */
+	prom_get_irq_senses(senses, 0, 128);
+
+	mpic = mpic_alloc(opic_addr,
+			  MPIC_PRIMARY | MPIC_BIG_ENDIAN |
+			  MPIC_BROKEN_U3 | MPIC_WANTS_RESET,
+			  0, 0, 128, 128, senses, 128, "U3-MPIC");
+	BUG_ON(mpic == NULL);
+	mpic_init(mpic);
+
+	DBG(" <- maple_init_IRQ\n");
+}
+
+static void __init maple_progress(char *s, unsigned short hex)
+{
+	printk("*** %04x : %s\n", hex, s ? s : "");
+}
+
+
+/*
+ * Called very early, MMU is off, device-tree isn't unflattened
+ */
+static int __init maple_probe(int platform)
+{
+	if (platform != PLATFORM_MAPLE)
+		return 0;
+	/*
+	 * On U3, the DART (iommu) must be allocated now since it
+	 * has an impact on htab_initialize (due to the large page it
+	 * occupies having to be broken up so the DART itself is not
+	 * part of the cacheable linar mapping
+	 */
+	alloc_u3_dart_table();
+
+	return 1;
+}
+
+struct machdep_calls __initdata maple_md = {
+	.probe			= maple_probe,
+	.setup_arch		= maple_setup_arch,
+	.init_early		= maple_init_early,
+	.init_IRQ		= maple_init_IRQ,
+	.get_irq		= mpic_get_irq,
+	.pcibios_fixup		= maple_pcibios_fixup,
+#if 0
+	.pci_get_legacy_ide_irq	= maple_pci_get_legacy_ide_irq,
+#endif
+	.restart		= maple_restart,
+	.power_off		= maple_power_off,
+	.halt			= maple_halt,
+       	.get_boot_time		= maple_get_boot_time,
+       	.set_rtc_time		= maple_set_rtc_time,
+       	.get_rtc_time		= maple_get_rtc_time,
+      	.calibrate_decr		= maple_calibrate_decr,
+	.progress		= maple_progress,
+};
Index: linux-work/arch/ppc64/kernel/setup.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/setup.c	2004-10-26 11:18:05.630004280 +1000
+++ linux-work/arch/ppc64/kernel/setup.c	2004-10-26 12:24:06.312888960 +1000
@@ -75,11 +75,14 @@
 extern void udbg_init_pmac_realmode(void);
 /* That's RTAS panel debug */
 extern void call_rtas_display_status_delay(unsigned char c);
+/* Here's maple real mode debug */
+extern void udbg_init_maple_realmode(void);
 
 #define EARLY_DEBUG_INIT() do {} while(0)
 
 #if 0
 #define EARLY_DEBUG_INIT() udbg_init_debug_lpar()
+#define EARLY_DEBUG_INIT() udbg_init_maple_realmode()
 #define EARLY_DEBUG_INIT() udbg_init_pmac_realmode()
 #define EARLY_DEBUG_INIT()						\
 	do { ppc_md.udbg_putc = call_rtas_display_status_delay; } while(0)
@@ -326,6 +329,7 @@
 
 extern struct machdep_calls pSeries_md;
 extern struct machdep_calls pmac_md;
+extern struct machdep_calls maple_md;
 
 /* Ultimately, stuff them in an elf section like initcalls... */
 static struct machdep_calls __initdata *machines[] = {
@@ -335,6 +339,9 @@
 #ifdef CONFIG_PPC_PMAC
 	&pmac_md,
 #endif /* CONFIG_PPC_PMAC */
+#ifdef CONFIG_PPC_MAPLE
+	&maple_md,
+#endif /* CONFIG_PPC_MAPLE */
 	NULL
 };
 
@@ -633,6 +640,7 @@
 	printk("naca->debug_switch            = 0x%lx\n", naca->debug_switch);
 	printk("naca->interrupt_controller    = 0x%ld\n", naca->interrupt_controller);
 	printk("systemcfg                     = 0x%p\n", systemcfg);
+	printk("systemcfg->platform           = 0x%x\n", systemcfg->platform);
 	printk("systemcfg->processorCount     = 0x%lx\n", systemcfg->processorCount);
 	printk("systemcfg->physicalMemorySize = 0x%lx\n", systemcfg->physicalMemorySize);
 	printk("systemcfg->dCacheL1LineSize   = 0x%x\n", systemcfg->dCacheL1LineSize);
Index: linux-work/arch/ppc64/Kconfig
===================================================================
--- linux-work.orig/arch/ppc64/Kconfig	2004-10-20 13:01:00.000000000 +1000
+++ linux-work/arch/ppc64/Kconfig	2004-10-26 12:24:06.314888656 +1000
@@ -80,6 +80,16 @@
 	select ADB_PMU
 	select U3_DART
 
+config PPC_MAPLE
+	depends on PPC_MULTIPLATFORM
+	bool "  Maple 970FX Evaluation Board"
+	select U3_DART
+	select MPIC_BROKEN_U3
+	default n
+	help
+          This option enables support for the Maple 970FX Evaluation Board.
+	  For more informations, refer to http://www.970eval.com
+
 config PPC
 	bool
 	default y
@@ -115,6 +125,11 @@
 	depends on PPC_MULTIPLATFORM
 	default n
 
+config MPIC_BROKEN_U3
+	bool
+	depends on PPC_MAPLE
+	default y
+
 config PPC_PMAC64
 	bool
 	depends on PPC_PMAC
Index: linux-work/arch/ppc64/kernel/maple_time.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/ppc64/kernel/maple_time.c	2004-10-26 12:24:06.317888200 +1000
@@ -0,0 +1,226 @@
+/*
+ *  arch/ppc64/kernel/maple_time.c
+ *
+ *  (c) Copyright 2004 Benjamin Herrenschmidt (benh@kernel.crashing.org),
+ *                     IBM Corp. 
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ *
+ */
+
+#undef DEBUG
+
+#include <linux/config.h>
+#include <linux/errno.h>
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/param.h>
+#include <linux/string.h>
+#include <linux/mm.h>
+#include <linux/init.h>
+#include <linux/time.h>
+#include <linux/adb.h>
+#include <linux/pmu.h>
+#include <linux/interrupt.h>
+#include <linux/mc146818rtc.h>
+#include <linux/bcd.h>
+
+#include <asm/sections.h>
+#include <asm/prom.h>
+#include <asm/system.h>
+#include <asm/io.h>
+#include <asm/pgtable.h>
+#include <asm/machdep.h>
+#include <asm/time.h>
+
+#ifdef DEBUG
+#define DBG(x...) printk(x)
+#else
+#define DBG(x...)
+#endif
+
+extern void setup_default_decr(void);
+extern void GregorianDay(struct rtc_time * tm);
+
+extern unsigned long ppc_tb_freq;
+extern unsigned long ppc_proc_freq;
+static int maple_rtc_addr;
+
+static int maple_clock_read(int addr)
+{
+	outb_p(addr, maple_rtc_addr);
+	return inb_p(maple_rtc_addr+1);
+}
+
+static void maple_clock_write(unsigned long val, int addr)
+{
+	outb_p(addr, maple_rtc_addr);
+	outb_p(val, maple_rtc_addr+1);
+}
+
+void maple_get_rtc_time(struct rtc_time *tm)
+{
+	int uip, i;
+
+	/* The Linux interpretation of the CMOS clock register contents:
+	 * When the Update-In-Progress (UIP) flag goes from 1 to 0, the
+	 * RTC registers show the second which has precisely just started.
+	 * Let's hope other operating systems interpret the RTC the same way.
+	 */
+
+	/* Since the UIP flag is set for about 2.2 ms and the clock
+	 * is typically written with a precision of 1 jiffy, trying
+	 * to obtain a precision better than a few milliseconds is
+	 * an illusion. Only consistency is interesting, this also
+	 * allows to use the routine for /dev/rtc without a potential
+	 * 1 second kernel busy loop triggered by any reader of /dev/rtc.
+	 */
+
+	for (i = 0; i<1000000; i++) {
+		uip = maple_clock_read(RTC_FREQ_SELECT);
+		tm->tm_sec = maple_clock_read(RTC_SECONDS);
+		tm->tm_min = maple_clock_read(RTC_MINUTES);
+		tm->tm_hour = maple_clock_read(RTC_HOURS);
+		tm->tm_mday = maple_clock_read(RTC_DAY_OF_MONTH);
+		tm->tm_mon = maple_clock_read(RTC_MONTH);
+		tm->tm_year = maple_clock_read(RTC_YEAR);
+		uip |= maple_clock_read(RTC_FREQ_SELECT);
+		if ((uip & RTC_UIP)==0)
+			break;
+	}
+
+	if (!(maple_clock_read(RTC_CONTROL) & RTC_DM_BINARY)
+	    || RTC_ALWAYS_BCD) {
+		BCD_TO_BIN(tm->tm_sec);
+		BCD_TO_BIN(tm->tm_min);
+		BCD_TO_BIN(tm->tm_hour);
+		BCD_TO_BIN(tm->tm_mday);
+		BCD_TO_BIN(tm->tm_mon);
+		BCD_TO_BIN(tm->tm_year);
+	  }
+	if ((tm->tm_year + 1900) < 1970)
+		tm->tm_year += 100;
+
+	GregorianDay(tm);
+}
+
+int maple_set_rtc_time(struct rtc_time *tm)
+{
+	unsigned char save_control, save_freq_select;
+	int sec, min, hour, mon, mday, year;
+
+	spin_lock(&rtc_lock);
+
+	save_control = maple_clock_read(RTC_CONTROL); /* tell the clock it's being set */
+
+	maple_clock_write((save_control|RTC_SET), RTC_CONTROL);
+
+	save_freq_select = maple_clock_read(RTC_FREQ_SELECT); /* stop and reset prescaler */
+
+	maple_clock_write((save_freq_select|RTC_DIV_RESET2), RTC_FREQ_SELECT);
+
+	sec = tm->tm_sec;
+	min = tm->tm_min;
+	hour = tm->tm_hour;
+	mon = tm->tm_mon;
+	mday = tm->tm_mday;
+	year = tm->tm_year;
+
+	if (!(save_control & RTC_DM_BINARY) || RTC_ALWAYS_BCD) {
+		BIN_TO_BCD(sec);
+		BIN_TO_BCD(min);
+		BIN_TO_BCD(hour);
+		BIN_TO_BCD(mon);
+		BIN_TO_BCD(mday);
+		BIN_TO_BCD(year);
+	}
+	maple_clock_write(sec, RTC_SECONDS);
+	maple_clock_write(min, RTC_MINUTES);
+	maple_clock_write(hour, RTC_HOURS);
+	maple_clock_write(mon, RTC_MONTH);
+	maple_clock_write(mday, RTC_DAY_OF_MONTH);
+	maple_clock_write(year, RTC_YEAR);
+
+	/* The following flags have to be released exactly in this order,
+	 * otherwise the DS12887 (popular MC146818A clone with integrated
+	 * battery and quartz) will not reset the oscillator and will not
+	 * update precisely 500 ms later. You won't find this mentioned in
+	 * the Dallas Semiconductor data sheets, but who believes data
+	 * sheets anyway ...                           -- Markus Kuhn
+	 */
+	maple_clock_write(save_control, RTC_CONTROL);
+	maple_clock_write(save_freq_select, RTC_FREQ_SELECT);
+
+	spin_unlock(&rtc_lock);
+
+	return 0;
+}
+
+void __init maple_get_boot_time(struct rtc_time *tm)
+{
+	struct device_node *rtcs;
+
+	rtcs = find_compatible_devices("rtc", "pnpPNP,b00");
+	if (rtcs && rtcs->addrs) {
+		maple_rtc_addr = rtcs->addrs[0].address;
+		printk(KERN_INFO "Maple: Found RTC at 0x%x\n", maple_rtc_addr);
+	} else {
+		maple_rtc_addr = RTC_PORT(0); /* legacy address */
+		printk(KERN_INFO "Maple: No device node for RTC, assuming "
+		       "legacy address (0x%x)\n", maple_rtc_addr);
+	}
+	
+	maple_get_rtc_time(tm);
+}
+
+/* XXX FIXME: Some sane defaults: 125 MHz timebase, 1GHz processor */
+#define DEFAULT_TB_FREQ		125000000UL
+#define DEFAULT_PROC_FREQ	(DEFAULT_TB_FREQ * 8)
+
+void __init maple_calibrate_decr(void)
+{
+	struct device_node *cpu;
+	struct div_result divres;
+	unsigned int *fp = NULL;
+
+	/*
+	 * The cpu node should have a timebase-frequency property
+	 * to tell us the rate at which the decrementer counts.
+	 */
+	cpu = of_find_node_by_type(NULL, "cpu");
+
+	ppc_tb_freq = DEFAULT_TB_FREQ;
+	if (cpu != 0)
+		fp = (unsigned int *)get_property(cpu, "timebase-frequency", NULL);
+	if (fp != NULL)
+		ppc_tb_freq = *fp;
+	else
+		printk(KERN_ERR "WARNING: Estimating decrementer frequency (not found)\n");
+	fp = NULL;
+	ppc_proc_freq = DEFAULT_PROC_FREQ;
+	if (cpu != 0)
+		fp = (unsigned int *)get_property(cpu, "clock-frequency", NULL);
+	if (fp != NULL)
+		ppc_proc_freq = *fp;
+	else
+		printk(KERN_ERR "WARNING: Estimating processor frequency (not found)\n");
+
+	of_node_put(cpu);
+
+	printk(KERN_INFO "time_init: decrementer frequency = %lu.%.6lu MHz\n",
+	       ppc_tb_freq/1000000, ppc_tb_freq%1000000);
+	printk(KERN_INFO "time_init: processor frequency   = %lu.%.6lu MHz\n",
+	       ppc_proc_freq/1000000, ppc_proc_freq%1000000);
+
+	tb_ticks_per_jiffy = ppc_tb_freq / HZ;
+	tb_ticks_per_sec = tb_ticks_per_jiffy * HZ;
+	tb_ticks_per_usec = ppc_tb_freq / 1000000;
+	tb_to_us = mulhwu_scale_factor(ppc_tb_freq, 1000000);
+	div128_by_32(1024*1024, 0, tb_ticks_per_sec, &divres);
+	tb_to_xs = divres.result_low;
+
+	setup_default_decr();
+}
Index: linux-work/arch/ppc64/kernel/misc.S
===================================================================
--- linux-work.orig/arch/ppc64/kernel/misc.S	2004-10-20 13:01:00.000000000 +1000
+++ linux-work/arch/ppc64/kernel/misc.S	2004-10-26 12:24:06.319887896 +1000
@@ -591,7 +591,7 @@
 	isync
 	b	1b
 
-#ifdef CONFIG_PPC_PMAC
+#if defined(CONFIG_PPC_PMAC) || defined(CONFIG_PPC_MAPLE)
 /*
  * Do an IO access in real mode
  */
@@ -653,7 +653,7 @@
 	sync
 	isync
 	blr
-#endif /* CONFIG_PPC_PMAC */
+#endif /* defined(CONFIG_PPC_PMAC) || defined(CONFIG_PPC_MAPLE) */
 
 /*
  * Create a kernel thread
Index: linux-work/arch/ppc64/kernel/maple_pci.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/ppc64/kernel/maple_pci.c	2004-10-26 12:24:06.323887288 +1000
@@ -0,0 +1,528 @@
+/*
+ * Copyright (C) 2004 Benjamin Herrenschmuidt (benh@kernel.crashing.org),
+ *		      IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#define DEBUG
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/string.h>
+#include <linux/init.h>
+#include <linux/bootmem.h>
+
+#include <asm/sections.h>
+#include <asm/io.h>
+#include <asm/prom.h>
+#include <asm/pci-bridge.h>
+#include <asm/machdep.h>
+#include <asm/iommu.h>
+
+#include "pci.h"
+
+#ifdef DEBUG
+#define DBG(x...) printk(x)
+#else
+#define DBG(x...)
+#endif
+
+extern int pci_probe_only;
+extern int pci_read_irq_line(struct pci_dev *pci_dev);
+
+static struct pci_controller *u3_agp, *u3_ht;
+
+static int __init fixup_one_level_bus_range(struct device_node *node, int higher)
+{
+	for (; node != 0;node = node->sibling) {
+		int * bus_range;
+		unsigned int *class_code;
+		int len;
+
+		/* For PCI<->PCI bridges or CardBus bridges, we go down */
+		class_code = (unsigned int *) get_property(node, "class-code", NULL);
+		if (!class_code || ((*class_code >> 8) != PCI_CLASS_BRIDGE_PCI &&
+			(*class_code >> 8) != PCI_CLASS_BRIDGE_CARDBUS))
+			continue;
+		bus_range = (int *) get_property(node, "bus-range", &len);
+		if (bus_range != NULL && len > 2 * sizeof(int)) {
+			if (bus_range[1] > higher)
+				higher = bus_range[1];
+		}
+		higher = fixup_one_level_bus_range(node->child, higher);
+	}
+	return higher;
+}
+
+/* This routine fixes the "bus-range" property of all bridges in the
+ * system since they tend to have their "last" member wrong on macs
+ *
+ * Note that the bus numbers manipulated here are OF bus numbers, they
+ * are not Linux bus numbers.
+ */
+static void __init fixup_bus_range(struct device_node *bridge)
+{
+	int * bus_range;
+	int len;
+
+	/* Lookup the "bus-range" property for the hose */
+	bus_range = (int *) get_property(bridge, "bus-range", &len);
+	if (bus_range == NULL || len < 2 * sizeof(int)) {
+		printk(KERN_WARNING "Can't get bus-range for %s\n",
+			       bridge->full_name);
+		return;
+	}
+	bus_range[1] = fixup_one_level_bus_range(bridge->child, bus_range[1]);
+}
+
+
+#define U3_AGP_CFA0(devfn, off)	\
+	((1 << (unsigned long)PCI_SLOT(dev_fn)) \
+	| (((unsigned long)PCI_FUNC(dev_fn)) << 8) \
+	| (((unsigned long)(off)) & 0xFCUL))
+
+#define U3_AGP_CFA1(bus, devfn, off)	\
+	((((unsigned long)(bus)) << 16) \
+	|(((unsigned long)(devfn)) << 8) \
+	|(((unsigned long)(off)) & 0xFCUL) \
+	|1UL)
+
+static unsigned long u3_agp_cfg_access(struct pci_controller* hose,
+				       u8 bus, u8 dev_fn, u8 offset)
+{
+	unsigned int caddr;
+
+	if (bus == hose->first_busno) {
+		if (dev_fn < (11 << 3))
+			return 0;
+		caddr = U3_AGP_CFA0(dev_fn, offset);
+	} else
+		caddr = U3_AGP_CFA1(bus, dev_fn, offset);
+
+	/* Uninorth will return garbage if we don't read back the value ! */
+	do {
+		out_le32(hose->cfg_addr, caddr);
+	} while (in_le32(hose->cfg_addr) != caddr);
+
+	offset &= 0x07;
+	return ((unsigned long)hose->cfg_data) + offset;
+}
+
+static int u3_agp_read_config(struct pci_bus *bus, unsigned int devfn,
+			      int offset, int len, u32 *val)
+{
+	struct pci_controller *hose;
+	unsigned long addr;
+
+	hose = pci_bus_to_host(bus);
+	if (hose == NULL)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	addr = u3_agp_cfg_access(hose, bus->number, devfn, offset);
+	if (!addr)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	/*
+	 * Note: the caller has already checked that offset is
+	 * suitably aligned and that len is 1, 2 or 4.
+	 */
+	switch (len) {
+	case 1:
+		*val = in_8((u8 *)addr);
+		break;
+	case 2:
+		*val = in_le16((u16 *)addr);
+		break;
+	default:
+		*val = in_le32((u32 *)addr);
+		break;
+	}
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int u3_agp_write_config(struct pci_bus *bus, unsigned int devfn,
+			       int offset, int len, u32 val)
+{
+	struct pci_controller *hose;
+	unsigned long addr;
+
+	hose = pci_bus_to_host(bus);
+	if (hose == NULL)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	addr = u3_agp_cfg_access(hose, bus->number, devfn, offset);
+	if (!addr)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	/*
+	 * Note: the caller has already checked that offset is
+	 * suitably aligned and that len is 1, 2 or 4.
+	 */
+	switch (len) {
+	case 1:
+		out_8((u8 *)addr, val);
+		(void) in_8((u8 *)addr);
+		break;
+	case 2:
+		out_le16((u16 *)addr, val);
+		(void) in_le16((u16 *)addr);
+		break;
+	default:
+		out_le32((u32 *)addr, val);
+		(void) in_le32((u32 *)addr);
+		break;
+	}
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static struct pci_ops u3_agp_pci_ops =
+{
+	u3_agp_read_config,
+	u3_agp_write_config
+};
+
+
+#define U3_HT_CFA0(devfn, off)		\
+		((((unsigned long)devfn) << 8) | offset)
+#define U3_HT_CFA1(bus, devfn, off)	\
+		(U3_HT_CFA0(devfn, off) \
+		+ (((unsigned long)bus) << 16) \
+		+ 0x01000000UL)
+
+static unsigned long u3_ht_cfg_access(struct pci_controller* hose,
+				      u8 bus, u8 devfn, u8 offset)
+{
+	if (bus == hose->first_busno) {
+		if (PCI_SLOT(devfn) == 0)
+			return 0;
+		return ((unsigned long)hose->cfg_data) + U3_HT_CFA0(devfn, offset);
+	} else
+		return ((unsigned long)hose->cfg_data) + U3_HT_CFA1(bus, devfn, offset);
+}
+
+static int u3_ht_read_config(struct pci_bus *bus, unsigned int devfn,
+			     int offset, int len, u32 *val)
+{
+	struct pci_controller *hose;
+	unsigned long addr;
+
+	hose = pci_bus_to_host(bus);
+	if (hose == NULL)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	addr = u3_ht_cfg_access(hose, bus->number, devfn, offset);
+	if (!addr)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	/*
+	 * Note: the caller has already checked that offset is
+	 * suitably aligned and that len is 1, 2 or 4.
+	 */
+	switch (len) {
+	case 1:
+		*val = in_8((u8 *)addr);
+		break;
+	case 2:
+		*val = in_le16((u16 *)addr);
+		break;
+	default:
+		*val = in_le32((u32 *)addr);
+		break;
+	}
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int u3_ht_write_config(struct pci_bus *bus, unsigned int devfn,
+			      int offset, int len, u32 val)
+{
+	struct pci_controller *hose;
+	unsigned long addr;
+
+	hose = pci_bus_to_host(bus);
+	if (hose == NULL)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	addr = u3_ht_cfg_access(hose, bus->number, devfn, offset);
+	if (!addr)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	/*
+	 * Note: the caller has already checked that offset is
+	 * suitably aligned and that len is 1, 2 or 4.
+	 */
+	switch (len) {
+	case 1:
+		out_8((u8 *)addr, val);
+		(void) in_8((u8 *)addr);
+		break;
+	case 2:
+		out_le16((u16 *)addr, val);
+		(void) in_le16((u16 *)addr);
+		break;
+	default:
+		out_le32((u32 *)addr, val);
+		(void) in_le32((u32 *)addr);
+		break;
+	}
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static struct pci_ops u3_ht_pci_ops =
+{
+	u3_ht_read_config,
+	u3_ht_write_config
+};
+
+static void __init setup_u3_agp(struct pci_controller* hose)
+{
+	/* On G5, we move AGP up to high bus number so we don't need
+	 * to reassign bus numbers for HT. If we ever have P2P bridges
+	 * on AGP, we'll have to move pci_assign_all_busses to the
+	 * pci_controller structure so we enable it for AGP and not for
+	 * HT childs.
+	 * We hard code the address because of the different size of
+	 * the reg address cell, we shall fix that by killing struct
+	 * reg_property and using some accessor functions instead
+	 */
+       	hose->first_busno = 0xf0;
+	hose->last_busno = 0xff;
+	hose->ops = &u3_agp_pci_ops;
+	hose->cfg_addr = ioremap(0xf0000000 + 0x800000, 0x1000);
+	hose->cfg_data = ioremap(0xf0000000 + 0xc00000, 0x1000);
+
+	u3_agp = hose;
+}
+
+static void __init setup_u3_ht(struct pci_controller* hose)
+{
+	hose->ops = &u3_ht_pci_ops;
+
+	/* We hard code the address because of the different size of
+	 * the reg address cell, we shall fix that by killing struct
+	 * reg_property and using some accessor functions instead
+	 */
+	hose->cfg_data = (volatile unsigned char *)ioremap(0xf2000000, 0x02000000);
+
+	hose->first_busno = 0;
+	hose->last_busno = 0xef;
+
+	u3_ht = hose;
+}
+
+static int __init add_bridge(struct device_node *dev)
+{
+	int len;
+	struct pci_controller *hose;
+	char* disp_name;
+	int *bus_range;
+	int primary = 1;
+ 	struct property *of_prop;
+
+	DBG("Adding PCI host bridge %s\n", dev->full_name);
+
+       	bus_range = (int *) get_property(dev, "bus-range", &len);
+       	if (bus_range == NULL || len < 2 * sizeof(int)) {
+       		printk(KERN_WARNING "Can't get bus-range for %s, assume bus 0\n",
+       			       dev->full_name);
+       	}
+
+       	hose = pci_alloc_pci_controller(phb_type_apple);
+       	if (!hose)
+       		return -ENOMEM;
+       	hose->arch_data = dev;
+       	hose->first_busno = bus_range ? bus_range[0] : 0;
+       	hose->last_busno = bus_range ? bus_range[1] : 0xff;
+
+	of_prop = (struct property *)alloc_bootmem(sizeof(struct property) +
+			sizeof(hose->global_number));        
+	if (of_prop) {
+		memset(of_prop, 0, sizeof(struct property));
+		of_prop->name = "linux,pci-domain";
+		of_prop->length = sizeof(hose->global_number);
+		of_prop->value = (unsigned char *)&of_prop[1];
+		memcpy(of_prop->value, &hose->global_number, sizeof(hose->global_number));
+		prom_add_property(dev, of_prop);
+	}
+
+	disp_name = NULL;
+       	if (device_is_compatible(dev, "u3-agp")) {
+       		setup_u3_agp(hose);
+       		disp_name = "U3-AGP";
+       		primary = 0;
+       	} else if (device_is_compatible(dev, "u3-ht")) {
+       		setup_u3_ht(hose);
+       		disp_name = "U3-HT";
+       		primary = 1;
+       	}
+       	printk(KERN_INFO "Found %s PCI host bridge. Firmware bus number: %d->%d\n",
+       		disp_name, hose->first_busno, hose->last_busno);
+
+       	/* Interpret the "ranges" property */
+       	/* This also maps the I/O region and sets isa_io/mem_base */
+       	pci_process_bridge_OF_ranges(hose, dev);
+	pci_setup_phb_io(hose, primary);
+
+       	/* Fixup "bus-range" OF property */
+       	fixup_bus_range(dev);
+
+	return 0;
+}
+
+
+void __init maple_pcibios_fixup(void)
+{
+	struct pci_dev *dev = NULL;
+
+	DBG(" -> maple_pcibios_fixup\n");
+
+	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL)
+		pci_read_irq_line(dev);
+
+	/* Do the mapping of the IO space */
+	phbs_remap_io();
+
+	/* Fixup the pci_bus sysdata pointers */
+	pci_fix_bus_sysdata();
+
+	/* Setup the iommu */
+	iommu_setup_u3();
+
+	DBG(" <- maple_pcibios_fixup\n");
+}
+
+static void __init maple_fixup_phb_resources(void)
+{
+	struct pci_controller *hose, *tmp;
+	
+	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
+		unsigned long offset = (unsigned long)hose->io_base_virt - pci_io_base;
+		hose->io_resource.start += offset;
+		hose->io_resource.end += offset;
+		printk(KERN_INFO "PCI Host %d, io start: %lx; io end: %lx\n",
+		       hose->global_number,
+		       hose->io_resource.start, hose->io_resource.end);
+	}
+}
+
+void __init maple_pci_init(void)
+{
+	struct device_node *np, *root;
+	struct device_node *ht = NULL;
+
+	/* Probe root PCI hosts, that is on U3 the AGP host and the
+	 * HyperTransport host. That one is actually "kept" around
+	 * and actually added last as it's resource management relies
+	 * on the AGP resources to have been setup first
+	 */
+	root = of_find_node_by_path("/");
+	if (root == NULL) {
+		printk(KERN_CRIT "maple_find_bridges: can't find root of device tree\n");
+		return;
+	}
+	for (np = NULL; (np = of_get_next_child(root, np)) != NULL;) {
+		if (np->name == NULL)
+			continue;
+		if (strcmp(np->name, "pci") == 0) {
+			if (add_bridge(np) == 0)
+				of_node_get(np);
+		}
+		if (strcmp(np->name, "ht") == 0) {
+			of_node_get(np);
+			ht = np;
+		}
+	}
+	of_node_put(root);
+
+	/* Now setup the HyperTransport host if we found any
+	 */
+	if (ht && add_bridge(ht) != 0)
+		of_node_put(ht);
+
+	/* Fixup the IO resources on our host bridges as the common code
+	 * does it only for childs of the host bridges
+	 */
+	maple_fixup_phb_resources();
+
+	/* Setup the linkage between OF nodes and PHBs */ 
+	pci_devs_phb_init();
+
+	/* Fixup the PCI<->OF mapping for U3 AGP due to bus renumbering. We
+	 * assume there is no P2P bridge on the AGP bus, which should be a
+	 * safe assumptions hopefully.
+	 */
+	if (u3_agp) {
+		struct device_node *np = u3_agp->arch_data;
+		np->busno = 0xf0;
+		for (np = np->child; np; np = np->sibling)
+			np->busno = 0xf0;
+	}
+
+	/* Tell pci.c to use the common resource allocation mecanism */
+	pci_probe_only = 0;
+	
+	/* Allow all IO */
+	io_page_mask = -1;
+}
+
+int maple_pci_get_legacy_ide_irq(struct pci_dev *pdev, int channel)
+{
+	struct device_node *np;
+	int irq = channel ? 15 : 14;
+
+	if (pdev->vendor != PCI_VENDOR_ID_AMD ||
+	    pdev->device != PCI_DEVICE_ID_AMD_8111_IDE)
+		return irq;
+
+	np = pci_device_to_OF_node(pdev);
+	if (np == NULL)
+		return irq;
+	if (np->n_intrs < 2)
+		return irq;
+	return np->intrs[channel & 0x1].line;
+}
+
+/* XXX: To remove once all firmwares are ok */
+static void fixup_maple_ide(struct pci_dev* dev)
+{
+#if 0 /* Enable this to enable IDE port 0 */
+	{
+		u8 v;
+
+		pci_read_config_byte(dev, 0x40, &v);
+		v |= 2;
+		pci_write_config_byte(dev, 0x40, v);
+	}
+#endif
+#if 0 /* fix bus master base */
+	pci_write_config_dword(dev, 0x20, 0xcc01);
+	printk("old ide resource: %lx -> %lx \n",
+	       dev->resource[4].start, dev->resource[4].end);
+	dev->resource[4].start = 0xcc00;
+	dev->resource[4].end = 0xcc10;
+#endif
+#if 1 /* Enable this to fixup IDE sense/polarity of irqs in IO-APICs */
+	{
+		struct pci_dev *apicdev;
+		u32 v;
+
+		apicdev = pci_get_slot (dev->bus, PCI_DEVFN(5,0));
+		if (apicdev == NULL)
+			printk("IDE Fixup IRQ: Can't find IO-APIC !\n");
+		else {
+			pci_write_config_byte(apicdev, 0xf2, 0x10 + 2*14);
+			pci_read_config_dword(apicdev, 0xf4, &v);
+			v &= ~0x00000022;
+			pci_write_config_dword(apicdev, 0xf4, v);
+			pci_write_config_byte(apicdev, 0xf2, 0x10 + 2*15);
+			pci_read_config_dword(apicdev, 0xf4, &v);
+			v &= ~0x00000022;
+			pci_write_config_dword(apicdev, 0xf4, v);
+			pci_dev_put(apicdev);
+		}
+	}
+#endif
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8111_IDE,
+			 fixup_maple_ide);
Index: linux-work/arch/ppc64/configs/maple_defconfig
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/ppc64/configs/maple_defconfig	2004-10-26 12:24:06.328886528 +1000
@@ -0,0 +1,921 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.9
+# Wed Oct 20 15:39:14 2004
+#
+CONFIG_64BIT=y
+CONFIG_MMU=y
+CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_GENERIC_ISA_DMA=y
+CONFIG_HAVE_DEC_LOCK=y
+CONFIG_EARLY_PRINTK=y
+CONFIG_COMPAT=y
+CONFIG_FRAME_POINTER=y
+CONFIG_FORCE_MAX_ZONEORDER=13
+
+#
+# Code maturity level options
+#
+CONFIG_EXPERIMENTAL=y
+CONFIG_CLEAN_COMPILE=y
+
+#
+# General setup
+#
+CONFIG_LOCALVERSION=""
+CONFIG_SWAP=y
+CONFIG_SYSVIPC=y
+# CONFIG_POSIX_MQUEUE is not set
+# CONFIG_BSD_PROCESS_ACCT is not set
+CONFIG_SYSCTL=y
+# CONFIG_AUDIT is not set
+CONFIG_LOG_BUF_SHIFT=17
+# CONFIG_HOTPLUG is not set
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+# CONFIG_EMBEDDED is not set
+CONFIG_KALLSYMS=y
+CONFIG_KALLSYMS_ALL=y
+# CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_FUTEX=y
+CONFIG_EPOLL=y
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_AS=y
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SHMEM=y
+# CONFIG_TINY_SHMEM is not set
+
+#
+# Loadable module support
+#
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_FORCE_UNLOAD=y
+CONFIG_OBSOLETE_MODPARM=y
+# CONFIG_MODVERSIONS is not set
+CONFIG_KMOD=y
+CONFIG_STOP_MACHINE=y
+CONFIG_SYSVIPC_COMPAT=y
+
+#
+# Platform support
+#
+# CONFIG_PPC_ISERIES is not set
+CONFIG_PPC_MULTIPLATFORM=y
+# CONFIG_PPC_PSERIES is not set
+# CONFIG_PPC_PMAC is not set
+CONFIG_PPC_MAPLE=y
+CONFIG_PPC=y
+CONFIG_PPC64=y
+CONFIG_PPC_OF=y
+# CONFIG_ALTIVEC is not set
+CONFIG_U3_DART=y
+CONFIG_MPIC_BROKEN_U3=y
+CONFIG_BOOTX_TEXT=y
+CONFIG_POWER4_ONLY=y
+CONFIG_IOMMU_VMERGE=y
+CONFIG_SMP=y
+# CONFIG_IRQ_ALL_CPUS is not set
+CONFIG_NR_CPUS=2
+# CONFIG_SCHED_SMT is not set
+# CONFIG_PREEMPT is not set
+
+#
+# General setup
+#
+CONFIG_PCI=y
+CONFIG_PCI_DOMAINS=y
+CONFIG_BINFMT_ELF=y
+# CONFIG_BINFMT_MISC is not set
+CONFIG_PCI_LEGACY_PROC=y
+CONFIG_PCI_NAMES=y
+CONFIG_PROC_DEVICETREE=y
+# CONFIG_CMDLINE_BOOL is not set
+
+#
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+# CONFIG_DEBUG_DRIVER is not set
+
+#
+# Memory Technology Devices (MTD)
+#
+# CONFIG_MTD is not set
+
+#
+# Parallel port support
+#
+# CONFIG_PARPORT is not set
+
+#
+# Plug and Play support
+#
+
+#
+# Block devices
+#
+# CONFIG_BLK_DEV_FD is not set
+# CONFIG_BLK_CPQ_DA is not set
+# CONFIG_BLK_CPQ_CISS_DA is not set
+# CONFIG_BLK_DEV_DAC960 is not set
+# CONFIG_BLK_DEV_UMEM is not set
+# CONFIG_BLK_DEV_LOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_SX8 is not set
+# CONFIG_BLK_DEV_UB is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_SIZE=8192
+# CONFIG_BLK_DEV_INITRD is not set
+
+#
+# ATA/ATAPI/MFM/RLL support
+#
+CONFIG_IDE=y
+CONFIG_BLK_DEV_IDE=y
+
+#
+# Please see Documentation/ide.txt for help/info on IDE drives
+#
+# CONFIG_BLK_DEV_IDE_SATA is not set
+CONFIG_BLK_DEV_IDEDISK=y
+# CONFIG_IDEDISK_MULTI_MODE is not set
+CONFIG_BLK_DEV_IDECD=y
+# CONFIG_BLK_DEV_IDETAPE is not set
+# CONFIG_BLK_DEV_IDEFLOPPY is not set
+CONFIG_IDE_TASK_IOCTL=y
+CONFIG_IDE_TASKFILE_IO=y
+
+#
+# IDE chipset support/bugfixes
+#
+CONFIG_IDE_GENERIC=y
+CONFIG_BLK_DEV_IDEPCI=y
+CONFIG_IDEPCI_SHARE_IRQ=y
+# CONFIG_BLK_DEV_OFFBOARD is not set
+CONFIG_BLK_DEV_GENERIC=y
+# CONFIG_BLK_DEV_OPTI621 is not set
+# CONFIG_BLK_DEV_SL82C105 is not set
+CONFIG_BLK_DEV_IDEDMA_PCI=y
+# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
+CONFIG_IDEDMA_PCI_AUTO=y
+# CONFIG_IDEDMA_ONLYDISK is not set
+# CONFIG_BLK_DEV_AEC62XX is not set
+# CONFIG_BLK_DEV_ALI15X3 is not set
+CONFIG_BLK_DEV_AMD74XX=y
+# CONFIG_BLK_DEV_CMD64X is not set
+# CONFIG_BLK_DEV_TRIFLEX is not set
+# CONFIG_BLK_DEV_CY82C693 is not set
+# CONFIG_BLK_DEV_CS5520 is not set
+# CONFIG_BLK_DEV_CS5530 is not set
+# CONFIG_BLK_DEV_HPT34X is not set
+# CONFIG_BLK_DEV_HPT366 is not set
+# CONFIG_BLK_DEV_SC1200 is not set
+# CONFIG_BLK_DEV_PIIX is not set
+# CONFIG_BLK_DEV_NS87415 is not set
+# CONFIG_BLK_DEV_PDC202XX_OLD is not set
+# CONFIG_BLK_DEV_PDC202XX_NEW is not set
+# CONFIG_BLK_DEV_SVWKS is not set
+# CONFIG_BLK_DEV_SIIMAGE is not set
+# CONFIG_BLK_DEV_SLC90E66 is not set
+# CONFIG_BLK_DEV_TRM290 is not set
+# CONFIG_BLK_DEV_VIA82CXXX is not set
+# CONFIG_IDE_ARM is not set
+CONFIG_BLK_DEV_IDEDMA=y
+# CONFIG_IDEDMA_IVB is not set
+CONFIG_IDEDMA_AUTO=y
+# CONFIG_BLK_DEV_HD is not set
+
+#
+# SCSI device support
+#
+# CONFIG_SCSI is not set
+
+#
+# Multi-device support (RAID and LVM)
+#
+# CONFIG_MD is not set
+
+#
+# Fusion MPT device support
+#
+
+#
+# IEEE 1394 (FireWire) support
+#
+# CONFIG_IEEE1394 is not set
+
+#
+# I2O device support
+#
+# CONFIG_I2O is not set
+
+#
+# Macintosh device drivers
+#
+
+#
+# Networking support
+#
+CONFIG_NET=y
+
+#
+# Networking options
+#
+CONFIG_PACKET=y
+CONFIG_PACKET_MMAP=y
+# CONFIG_NETLINK_DEV is not set
+CONFIG_UNIX=y
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+# CONFIG_IP_PNP_BOOTP is not set
+# CONFIG_IP_PNP_RARP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_IP_MROUTE is not set
+# CONFIG_ARPD is not set
+# CONFIG_SYN_COOKIES is not set
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_TUNNEL is not set
+# CONFIG_IPV6 is not set
+# CONFIG_NETFILTER is not set
+
+#
+# SCTP Configuration (EXPERIMENTAL)
+#
+# CONFIG_IP_SCTP is not set
+# CONFIG_ATM is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_NET_DIVERT is not set
+# CONFIG_ECONET is not set
+# CONFIG_WAN_ROUTER is not set
+# CONFIG_NET_HW_FLOWCONTROL is not set
+
+#
+# QoS and/or fair queueing
+#
+# CONFIG_NET_SCHED is not set
+# CONFIG_NET_CLS_ROUTE is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+CONFIG_NETDEVICES=y
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+
+#
+# ARCnet devices
+#
+# CONFIG_ARCNET is not set
+
+#
+# Ethernet (10 or 100Mbit)
+#
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+# CONFIG_HAPPYMEAL is not set
+# CONFIG_SUNGEM is not set
+# CONFIG_NET_VENDOR_3COM is not set
+
+#
+# Tulip family network device support
+#
+# CONFIG_NET_TULIP is not set
+# CONFIG_HP100 is not set
+CONFIG_NET_PCI=y
+# CONFIG_PCNET32 is not set
+CONFIG_AMD8111_ETH=y
+# CONFIG_AMD8111E_NAPI is not set
+# CONFIG_ADAPTEC_STARFIRE is not set
+# CONFIG_B44 is not set
+# CONFIG_FORCEDETH is not set
+# CONFIG_DGRS is not set
+# CONFIG_EEPRO100 is not set
+# CONFIG_E100 is not set
+# CONFIG_FEALNX is not set
+# CONFIG_NATSEMI is not set
+# CONFIG_NE2K_PCI is not set
+# CONFIG_8139CP is not set
+# CONFIG_8139TOO is not set
+# CONFIG_SIS900 is not set
+# CONFIG_EPIC100 is not set
+# CONFIG_SUNDANCE is not set
+# CONFIG_VIA_RHINE is not set
+# CONFIG_VIA_VELOCITY is not set
+
+#
+# Ethernet (1000 Mbit)
+#
+# CONFIG_ACENIC is not set
+# CONFIG_DL2K is not set
+CONFIG_E1000=y
+# CONFIG_E1000_NAPI is not set
+# CONFIG_NS83820 is not set
+# CONFIG_HAMACHI is not set
+# CONFIG_YELLOWFIN is not set
+# CONFIG_R8169 is not set
+# CONFIG_SK98LIN is not set
+# CONFIG_TIGON3 is not set
+
+#
+# Ethernet (10000 Mbit)
+#
+# CONFIG_IXGB is not set
+# CONFIG_S2IO is not set
+
+#
+# Token Ring devices
+#
+# CONFIG_TR is not set
+
+#
+# Wireless LAN (non-hamradio)
+#
+# CONFIG_NET_RADIO is not set
+
+#
+# Wan interfaces
+#
+# CONFIG_WAN is not set
+# CONFIG_FDDI is not set
+# CONFIG_HIPPI is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
+
+#
+# ISDN subsystem
+#
+# CONFIG_ISDN is not set
+
+#
+# Telephony Support
+#
+# CONFIG_PHONE is not set
+
+#
+# Input device support
+#
+CONFIG_INPUT=y
+
+#
+# Userland interfaces
+#
+CONFIG_INPUT_MOUSEDEV=y
+# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=1600
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1200
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_TSDEV is not set
+# CONFIG_INPUT_EVDEV is not set
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input I/O drivers
+#
+# CONFIG_GAMEPORT is not set
+CONFIG_SOUND_GAMEPORT=y
+# CONFIG_SERIO is not set
+# CONFIG_SERIO_I8042 is not set
+
+#
+# Input Device Drivers
+#
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
+# CONFIG_INPUT_MISC is not set
+
+#
+# Character devices
+#
+CONFIG_VT=y
+CONFIG_VT_CONSOLE=y
+CONFIG_HW_CONSOLE=y
+# CONFIG_SERIAL_NONSTANDARD is not set
+
+#
+# Serial drivers
+#
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_NR_UARTS=4
+# CONFIG_SERIAL_8250_EXTENDED is not set
+
+#
+# Non-8250 serial port support
+#
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+# CONFIG_SERIAL_PMACZILOG is not set
+CONFIG_UNIX98_PTYS=y
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
+
+#
+# IPMI
+#
+# CONFIG_IPMI_HANDLER is not set
+
+#
+# Watchdog Cards
+#
+# CONFIG_WATCHDOG is not set
+# CONFIG_RTC is not set
+# CONFIG_GEN_RTC is not set
+# CONFIG_DTLK is not set
+# CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
+
+#
+# Ftape, the floppy tape device driver
+#
+# CONFIG_AGP is not set
+# CONFIG_DRM is not set
+# CONFIG_RAW_DRIVER is not set
+
+#
+# I2C support
+#
+CONFIG_I2C=y
+CONFIG_I2C_CHARDEV=y
+
+#
+# I2C Algorithms
+#
+CONFIG_I2C_ALGOBIT=y
+# CONFIG_I2C_ALGOPCF is not set
+# CONFIG_I2C_ALGOPCA is not set
+
+#
+# I2C Hardware Bus support
+#
+# CONFIG_I2C_ALI1535 is not set
+# CONFIG_I2C_ALI1563 is not set
+# CONFIG_I2C_ALI15X3 is not set
+# CONFIG_I2C_AMD756 is not set
+CONFIG_I2C_AMD8111=y
+# CONFIG_I2C_I801 is not set
+# CONFIG_I2C_I810 is not set
+# CONFIG_I2C_ISA is not set
+# CONFIG_I2C_NFORCE2 is not set
+# CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_PROSAVAGE is not set
+# CONFIG_I2C_SAVAGE4 is not set
+# CONFIG_SCx200_ACB is not set
+# CONFIG_I2C_SIS5595 is not set
+# CONFIG_I2C_SIS630 is not set
+# CONFIG_I2C_SIS96X is not set
+# CONFIG_I2C_VIA is not set
+# CONFIG_I2C_VIAPRO is not set
+# CONFIG_I2C_VOODOO3 is not set
+# CONFIG_I2C_PCA_ISA is not set
+
+#
+# Hardware Sensors Chip support
+#
+# CONFIG_I2C_SENSOR is not set
+# CONFIG_SENSORS_ADM1021 is not set
+# CONFIG_SENSORS_ADM1025 is not set
+# CONFIG_SENSORS_ADM1031 is not set
+# CONFIG_SENSORS_ASB100 is not set
+# CONFIG_SENSORS_DS1621 is not set
+# CONFIG_SENSORS_FSCHER is not set
+# CONFIG_SENSORS_GL518SM is not set
+# CONFIG_SENSORS_IT87 is not set
+# CONFIG_SENSORS_LM75 is not set
+# CONFIG_SENSORS_LM77 is not set
+# CONFIG_SENSORS_LM78 is not set
+# CONFIG_SENSORS_LM80 is not set
+# CONFIG_SENSORS_LM83 is not set
+# CONFIG_SENSORS_LM85 is not set
+# CONFIG_SENSORS_LM90 is not set
+# CONFIG_SENSORS_MAX1619 is not set
+# CONFIG_SENSORS_SMSC47M1 is not set
+# CONFIG_SENSORS_VIA686A is not set
+# CONFIG_SENSORS_W83781D is not set
+# CONFIG_SENSORS_W83L785TS is not set
+# CONFIG_SENSORS_W83627HF is not set
+
+#
+# Other I2C Chip support
+#
+# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_SENSORS_PCF8574 is not set
+# CONFIG_SENSORS_PCF8591 is not set
+# CONFIG_SENSORS_RTC8564 is not set
+# CONFIG_I2C_DEBUG_CORE is not set
+# CONFIG_I2C_DEBUG_ALGO is not set
+# CONFIG_I2C_DEBUG_BUS is not set
+# CONFIG_I2C_DEBUG_CHIP is not set
+
+#
+# Dallas's 1-wire bus
+#
+# CONFIG_W1 is not set
+
+#
+# Misc devices
+#
+
+#
+# Multimedia devices
+#
+# CONFIG_VIDEO_DEV is not set
+
+#
+# Digital Video Broadcasting Devices
+#
+# CONFIG_DVB is not set
+
+#
+# Graphics support
+#
+# CONFIG_FB is not set
+
+#
+# Console display driver support
+#
+# CONFIG_VGA_CONSOLE is not set
+CONFIG_DUMMY_CONSOLE=y
+
+#
+# Sound
+#
+# CONFIG_SOUND is not set
+
+#
+# USB support
+#
+CONFIG_USB=y
+# CONFIG_USB_DEBUG is not set
+
+#
+# Miscellaneous USB options
+#
+CONFIG_USB_DEVICEFS=y
+# CONFIG_USB_BANDWIDTH is not set
+# CONFIG_USB_DYNAMIC_MINORS is not set
+# CONFIG_USB_OTG is not set
+
+#
+# USB Host Controller Drivers
+#
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_SPLIT_ISO=y
+CONFIG_USB_EHCI_ROOT_HUB_TT=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_UHCI_HCD=y
+
+#
+# USB Device Class drivers
+#
+# CONFIG_USB_BLUETOOTH_TTY is not set
+# CONFIG_USB_ACM is not set
+# CONFIG_USB_PRINTER is not set
+# CONFIG_USB_STORAGE is not set
+
+#
+# USB Human Interface Devices (HID)
+#
+CONFIG_USB_HID=y
+CONFIG_USB_HIDINPUT=y
+# CONFIG_HID_FF is not set
+# CONFIG_USB_HIDDEV is not set
+# CONFIG_USB_AIPTEK is not set
+# CONFIG_USB_WACOM is not set
+# CONFIG_USB_KBTAB is not set
+# CONFIG_USB_POWERMATE is not set
+# CONFIG_USB_MTOUCH is not set
+# CONFIG_USB_EGALAX is not set
+# CONFIG_USB_XPAD is not set
+# CONFIG_USB_ATI_REMOTE is not set
+
+#
+# USB Imaging devices
+#
+# CONFIG_USB_MDC800 is not set
+
+#
+# USB Multimedia devices
+#
+# CONFIG_USB_DABUSB is not set
+
+#
+# Video4Linux support is needed for USB Multimedia device support
+#
+
+#
+# USB Network adaptors
+#
+# CONFIG_USB_CATC is not set
+# CONFIG_USB_KAWETH is not set
+CONFIG_USB_PEGASUS=y
+# CONFIG_USB_RTL8150 is not set
+# CONFIG_USB_USBNET is not set
+
+#
+# USB port drivers
+#
+
+#
+# USB Serial Converter support
+#
+CONFIG_USB_SERIAL=y
+# CONFIG_USB_SERIAL_CONSOLE is not set
+CONFIG_USB_SERIAL_GENERIC=y
+# CONFIG_USB_SERIAL_BELKIN is not set
+# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
+# CONFIG_USB_SERIAL_EMPEG is not set
+# CONFIG_USB_SERIAL_FTDI_SIO is not set
+# CONFIG_USB_SERIAL_VISOR is not set
+# CONFIG_USB_SERIAL_IPAQ is not set
+# CONFIG_USB_SERIAL_IR is not set
+# CONFIG_USB_SERIAL_EDGEPORT is not set
+# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
+# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
+CONFIG_USB_SERIAL_KEYSPAN=y
+CONFIG_USB_SERIAL_KEYSPAN_MPR=y
+CONFIG_USB_SERIAL_KEYSPAN_USA28=y
+CONFIG_USB_SERIAL_KEYSPAN_USA28X=y
+CONFIG_USB_SERIAL_KEYSPAN_USA28XA=y
+CONFIG_USB_SERIAL_KEYSPAN_USA28XB=y
+CONFIG_USB_SERIAL_KEYSPAN_USA19=y
+CONFIG_USB_SERIAL_KEYSPAN_USA18X=y
+CONFIG_USB_SERIAL_KEYSPAN_USA19W=y
+CONFIG_USB_SERIAL_KEYSPAN_USA19QW=y
+CONFIG_USB_SERIAL_KEYSPAN_USA19QI=y
+CONFIG_USB_SERIAL_KEYSPAN_USA49W=y
+CONFIG_USB_SERIAL_KEYSPAN_USA49WLC=y
+# CONFIG_USB_SERIAL_KLSI is not set
+# CONFIG_USB_SERIAL_KOBIL_SCT is not set
+# CONFIG_USB_SERIAL_MCT_U232 is not set
+# CONFIG_USB_SERIAL_PL2303 is not set
+# CONFIG_USB_SERIAL_SAFE is not set
+# CONFIG_USB_SERIAL_CYBERJACK is not set
+# CONFIG_USB_SERIAL_XIRCOM is not set
+# CONFIG_USB_SERIAL_OMNINET is not set
+CONFIG_USB_EZUSB=y
+
+#
+# USB Miscellaneous drivers
+#
+# CONFIG_USB_EMI62 is not set
+# CONFIG_USB_EMI26 is not set
+# CONFIG_USB_TIGL is not set
+# CONFIG_USB_AUERSWALD is not set
+# CONFIG_USB_RIO500 is not set
+# CONFIG_USB_LEGOTOWER is not set
+# CONFIG_USB_LCD is not set
+# CONFIG_USB_LED is not set
+# CONFIG_USB_CYTHERM is not set
+# CONFIG_USB_PHIDGETSERVO is not set
+# CONFIG_USB_TEST is not set
+
+#
+# USB Gadget Support
+#
+# CONFIG_USB_GADGET is not set
+
+#
+# File systems
+#
+CONFIG_EXT2_FS=y
+# CONFIG_EXT2_FS_XATTR is not set
+CONFIG_EXT3_FS=y
+# CONFIG_EXT3_FS_XATTR is not set
+CONFIG_JBD=y
+# CONFIG_JBD_DEBUG is not set
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_XFS_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_ROMFS_FS is not set
+# CONFIG_QUOTA is not set
+# CONFIG_AUTOFS_FS is not set
+# CONFIG_AUTOFS4_FS is not set
+
+#
+# CD-ROM/DVD Filesystems
+#
+# CONFIG_ISO9660_FS is not set
+# CONFIG_UDF_FS is not set
+
+#
+# DOS/FAT/NT Filesystems
+#
+CONFIG_FAT_FS=y
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_FAT_DEFAULT_CODEPAGE=437
+CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_SYSFS=y
+# CONFIG_DEVFS_FS is not set
+CONFIG_DEVPTS_FS_XATTR=y
+# CONFIG_DEVPTS_FS_SECURITY is not set
+CONFIG_TMPFS=y
+# CONFIG_HUGETLBFS is not set
+# CONFIG_HUGETLB_PAGE is not set
+CONFIG_RAMFS=y
+
+#
+# Miscellaneous filesystems
+#
+# CONFIG_ADFS_FS is not set
+# CONFIG_AFFS_FS is not set
+# CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
+# CONFIG_BEFS_FS is not set
+# CONFIG_BFS_FS is not set
+# CONFIG_EFS_FS is not set
+# CONFIG_CRAMFS is not set
+# CONFIG_VXFS_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+
+#
+# Network File Systems
+#
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+CONFIG_NFS_V4=y
+# CONFIG_NFS_DIRECTIO is not set
+# CONFIG_NFSD is not set
+CONFIG_ROOT_NFS=y
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+# CONFIG_EXPORTFS is not set
+CONFIG_SUNRPC=y
+CONFIG_SUNRPC_GSS=y
+CONFIG_RPCSEC_GSS_KRB5=y
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
+# CONFIG_SMB_FS is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
+
+#
+# Partition Types
+#
+CONFIG_PARTITION_ADVANCED=y
+# CONFIG_ACORN_PARTITION is not set
+# CONFIG_OSF_PARTITION is not set
+# CONFIG_AMIGA_PARTITION is not set
+# CONFIG_ATARI_PARTITION is not set
+CONFIG_MAC_PARTITION=y
+CONFIG_MSDOS_PARTITION=y
+# CONFIG_BSD_DISKLABEL is not set
+# CONFIG_MINIX_SUBPARTITION is not set
+# CONFIG_SOLARIS_X86_PARTITION is not set
+# CONFIG_UNIXWARE_DISKLABEL is not set
+# CONFIG_LDM_PARTITION is not set
+# CONFIG_SGI_PARTITION is not set
+# CONFIG_ULTRIX_PARTITION is not set
+# CONFIG_SUN_PARTITION is not set
+# CONFIG_EFI_PARTITION is not set
+
+#
+# Native Language Support
+#
+CONFIG_NLS=y
+CONFIG_NLS_DEFAULT="utf-8"
+# CONFIG_NLS_CODEPAGE_437 is not set
+# CONFIG_NLS_CODEPAGE_737 is not set
+# CONFIG_NLS_CODEPAGE_775 is not set
+# CONFIG_NLS_CODEPAGE_850 is not set
+# CONFIG_NLS_CODEPAGE_852 is not set
+# CONFIG_NLS_CODEPAGE_855 is not set
+# CONFIG_NLS_CODEPAGE_857 is not set
+# CONFIG_NLS_CODEPAGE_860 is not set
+# CONFIG_NLS_CODEPAGE_861 is not set
+# CONFIG_NLS_CODEPAGE_862 is not set
+# CONFIG_NLS_CODEPAGE_863 is not set
+# CONFIG_NLS_CODEPAGE_864 is not set
+# CONFIG_NLS_CODEPAGE_865 is not set
+# CONFIG_NLS_CODEPAGE_866 is not set
+# CONFIG_NLS_CODEPAGE_869 is not set
+# CONFIG_NLS_CODEPAGE_936 is not set
+# CONFIG_NLS_CODEPAGE_950 is not set
+# CONFIG_NLS_CODEPAGE_932 is not set
+# CONFIG_NLS_CODEPAGE_949 is not set
+# CONFIG_NLS_CODEPAGE_874 is not set
+# CONFIG_NLS_ISO8859_8 is not set
+# CONFIG_NLS_CODEPAGE_1250 is not set
+# CONFIG_NLS_CODEPAGE_1251 is not set
+# CONFIG_NLS_ASCII is not set
+# CONFIG_NLS_ISO8859_1 is not set
+# CONFIG_NLS_ISO8859_2 is not set
+# CONFIG_NLS_ISO8859_3 is not set
+# CONFIG_NLS_ISO8859_4 is not set
+# CONFIG_NLS_ISO8859_5 is not set
+# CONFIG_NLS_ISO8859_6 is not set
+# CONFIG_NLS_ISO8859_7 is not set
+# CONFIG_NLS_ISO8859_9 is not set
+# CONFIG_NLS_ISO8859_13 is not set
+# CONFIG_NLS_ISO8859_14 is not set
+# CONFIG_NLS_ISO8859_15 is not set
+# CONFIG_NLS_KOI8_R is not set
+# CONFIG_NLS_KOI8_U is not set
+CONFIG_NLS_UTF8=y
+
+#
+# Profiling support
+#
+# CONFIG_PROFILING is not set
+
+#
+# Kernel hacking
+#
+CONFIG_DEBUG_KERNEL=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_SLAB=y
+CONFIG_DEBUG_SPINLOCK_SLEEP=y
+# CONFIG_DEBUG_INFO is not set
+CONFIG_DEBUG_STACKOVERFLOW=y
+CONFIG_DEBUG_STACK_USAGE=y
+CONFIG_DEBUGGER=y
+CONFIG_XMON=y
+CONFIG_XMON_DEFAULT=y
+# CONFIG_PPCDBG is not set
+# CONFIG_IRQSTACKS is not set
+# CONFIG_SCHEDSTATS is not set
+
+#
+# Security options
+#
+# CONFIG_SECURITY is not set
+
+#
+# Cryptographic options
+#
+CONFIG_CRYPTO=y
+# CONFIG_CRYPTO_HMAC is not set
+# CONFIG_CRYPTO_NULL is not set
+# CONFIG_CRYPTO_MD4 is not set
+CONFIG_CRYPTO_MD5=y
+# CONFIG_CRYPTO_SHA1 is not set
+# CONFIG_CRYPTO_SHA256 is not set
+# CONFIG_CRYPTO_SHA512 is not set
+# CONFIG_CRYPTO_WP512 is not set
+CONFIG_CRYPTO_DES=y
+# CONFIG_CRYPTO_BLOWFISH is not set
+# CONFIG_CRYPTO_TWOFISH is not set
+# CONFIG_CRYPTO_SERPENT is not set
+# CONFIG_CRYPTO_AES is not set
+# CONFIG_CRYPTO_CAST5 is not set
+# CONFIG_CRYPTO_CAST6 is not set
+# CONFIG_CRYPTO_TEA is not set
+# CONFIG_CRYPTO_ARC4 is not set
+# CONFIG_CRYPTO_KHAZAD is not set
+# CONFIG_CRYPTO_DEFLATE is not set
+# CONFIG_CRYPTO_MICHAEL_MIC is not set
+# CONFIG_CRYPTO_CRC32C is not set
+# CONFIG_CRYPTO_TEST is not set
+
+#
+# Library routines
+#
+CONFIG_CRC_CCITT=y
+CONFIG_CRC32=y
+# CONFIG_LIBCRC32C is not set


