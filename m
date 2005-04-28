Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261941AbVD1IbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261941AbVD1IbA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 04:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbVD1Iaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 04:30:55 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:43003 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S261966AbVD1INs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 04:13:48 -0400
Message-Id: <200504280813.j3S8DNLa019256@post.webmailer.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc64-dev@ozlabs.org
Subject: [PATCH 1/4] ppc64: add BPA platform type
Date: Thu, 28 Apr 2005 09:56:59 +0200
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>
References: <200504190318.32556.arnd@arndb.de>
In-Reply-To: <200504190318.32556.arnd@arndb.de>
X-KMail-CryptoFormat: 15
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the basic support for running on BPA machines.

It should be possible to configure a kernel for any
combination of CONFIG_PPC_BPA with any of the other
multiplatform targets.

Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

Index: linus-2.5/MAINTAINERS
===================================================================
--- linus-2.5.orig/MAINTAINERS	2005-04-22 06:57:27.000000000 +0200
+++ linus-2.5/MAINTAINERS	2005-04-22 06:57:59.000000000 +0200
@@ -493,6 +493,13 @@
 W:   http://sourceforge.net/projects/bonding/
 S:   Supported
 
+BROADBAND PROCESSOR ARCHITECTURE
+P:	Arnd Bergmann
+M:	arnd@arndb.de
+L:	linuxppc64-dev@ozlabs.org
+W:	http://linuxppc64.org
+S:	Supported
+
 BTTV VIDEO4LINUX DRIVER
 P:	Gerd Knorr
 M:	kraxel@bytesex.org
Index: linus-2.5/arch/ppc64/Kconfig
===================================================================
--- linus-2.5.orig/arch/ppc64/Kconfig	2005-04-22 06:57:28.000000000 +0200
+++ linus-2.5/arch/ppc64/Kconfig	2005-04-22 06:58:22.000000000 +0200
@@ -73,6 +73,10 @@
 	bool "  IBM pSeries & new iSeries"
 	default y
 
+config PPC_BPA
+	bool "  Broadband Processor Architecture"
+	depends on PPC_MULTIPLATFORM
+
 config PPC_PMAC
 	depends on PPC_MULTIPLATFORM
 	bool "  Apple G5 based machines"
@@ -252,7 +256,7 @@
 
 config PPC_RTAS
 	bool
-	depends on PPC_PSERIES
+	depends on PPC_PSERIES || PPC_BPA
 	default y
 
 config RTAS_PROC
Index: linus-2.5/arch/ppc64/Makefile
===================================================================
--- linus-2.5.orig/arch/ppc64/Makefile	2005-04-22 06:52:24.000000000 +0200
+++ linus-2.5/arch/ppc64/Makefile	2005-04-22 06:57:59.000000000 +0200
@@ -83,12 +83,14 @@
 boottarget-$(CONFIG_PPC_PSERIES) := zImage zImage.initrd
 boottarget-$(CONFIG_PPC_MAPLE) := zImage zImage.initrd
 boottarget-$(CONFIG_PPC_ISERIES) := vmlinux.sminitrd vmlinux.initrd vmlinux.sm
+boottarget-$(CONFIG_PPC_BPA) := zImage zImage.initrd
 $(boottarget-y): vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
 bootimage-$(CONFIG_PPC_PSERIES) := $(boot)/zImage
 bootimage-$(CONFIG_PPC_PMAC) := vmlinux
 bootimage-$(CONFIG_PPC_MAPLE) := $(boot)/zImage
+bootimage-$(CONFIG_PPC_BPA) := zImage
 bootimage-$(CONFIG_PPC_ISERIES) := vmlinux
 BOOTIMAGE := $(bootimage-y)
 install: vmlinux
Index: linus-2.5/arch/ppc64/kernel/Makefile
===================================================================
--- linus-2.5.orig/arch/ppc64/kernel/Makefile	2005-04-22 06:57:31.000000000 +0200
+++ linus-2.5/arch/ppc64/kernel/Makefile	2005-04-22 06:59:10.000000000 +0200
@@ -34,6 +34,8 @@
 			     pSeries_nvram.o rtasd.o ras.o pSeries_reconfig.o \
 			     xics.o pSeries_setup.o pSeries_iommu.o
 
+obj-$(CONFIG_PPC_BPA) += bpa_setup.o bpa_nvram.o
+
 obj-$(CONFIG_EEH)		+= eeh.o
 obj-$(CONFIG_PROC_FS)		+= proc_ppc64.o
 obj-$(CONFIG_RTAS_FLASH)	+= rtas_flash.o
@@ -60,6 +62,7 @@
 obj-$(CONFIG_PPC_PMAC)		+= pmac_smp.o smp-tbsync.o
 obj-$(CONFIG_PPC_ISERIES)	+= iSeries_smp.o
 obj-$(CONFIG_PPC_PSERIES)	+= pSeries_smp.o
+obj-$(CONFIG_PPC_BPA)		+= pSeries_smp.o
 obj-$(CONFIG_PPC_MAPLE)		+= smp-tbsync.o
 endif
 
Index: linus-2.5/arch/ppc64/kernel/bpa_setup.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linus-2.5/arch/ppc64/kernel/bpa_setup.c	2005-04-22 06:58:22.000000000 +0200
@@ -0,0 +1,207 @@
+/*
+ *  linux/arch/ppc/kernel/bpa_setup.c
+ *
+ *  Copyright (C) 1995  Linus Torvalds
+ *  Adapted from 'alpha' version by Gary Thomas
+ *  Modified by Cort Dougan (cort@cs.nmt.edu)
+ *  Modified by PPC64 Team, IBM Corp
+ *  Modified by BPA Team, IBM Deutschland Entwicklung GmbH
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#undef DEBUG
+
+#include <linux/config.h>
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/stddef.h>
+#include <linux/unistd.h>
+#include <linux/slab.h>
+#include <linux/user.h>
+#include <linux/reboot.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/irq.h>
+#include <linux/seq_file.h>
+#include <linux/root_dev.h>
+#include <linux/console.h>
+
+#include <asm/mmu.h>
+#include <asm/processor.h>
+#include <asm/io.h>
+#include <asm/pgtable.h>
+#include <asm/prom.h>
+#include <asm/rtas.h>
+#include <asm/pci-bridge.h>
+#include <asm/iommu.h>
+#include <asm/dma.h>
+#include <asm/machdep.h>
+#include <asm/time.h>
+#include <asm/nvram.h>
+#include <asm/cputable.h>
+
+#include "pci.h"
+
+#ifdef DEBUG
+#define DBG(fmt...) udbg_printf(fmt)
+#else
+#define DBG(fmt...)
+#endif
+
+extern void pSeries_get_boot_time(struct rtc_time *rtc_time);
+extern void pSeries_get_rtc_time(struct rtc_time *rtc_time);
+extern int  pSeries_set_rtc_time(struct rtc_time *rtc_time);
+
+extern unsigned long ppc_proc_freq;
+extern unsigned long ppc_tb_freq;
+
+void bpa_get_cpuinfo(struct seq_file *m)
+{
+	struct device_node *root;
+	const char *model = "";
+
+	root = of_find_node_by_path("/");
+	if (root)
+		model = get_property(root, "model", NULL);
+	seq_printf(m, "machine\t\t: BPA %s\n", model);
+	of_node_put(root);
+}
+
+static void __init bpa_progress(char *s, unsigned short hex)
+{
+	printk("*** %04x : %s\n", hex, s ? s : "");
+}
+
+extern void setup_default_decr(void);
+
+/* Some sane defaults: 125 MHz timebase, 1GHz processor */
+#define DEFAULT_TB_FREQ		125000000UL
+#define DEFAULT_PROC_FREQ	(DEFAULT_TB_FREQ * 8)
+
+/* FIXME: consolidate this into rtas.c or similar */
+static void __init pSeries_calibrate_decr(void)
+{
+	struct device_node *cpu;
+	struct div_result divres;
+	unsigned int *fp;
+	int node_found;
+
+	/*
+	 * The cpu node should have a timebase-frequency property
+	 * to tell us the rate at which the decrementer counts.
+	 */
+	cpu = of_find_node_by_type(NULL, "cpu");
+
+	ppc_tb_freq = DEFAULT_TB_FREQ;		/* hardcoded default */
+	node_found = 0;
+	if (cpu != 0) {
+		fp = (unsigned int *)get_property(cpu, "timebase-frequency",
+						  NULL);
+		if (fp != 0) {
+			node_found = 1;
+			ppc_tb_freq = *fp;
+		}
+	}
+	if (!node_found)
+		printk(KERN_ERR "WARNING: Estimating decrementer frequency "
+				"(not found)\n");
+
+	ppc_proc_freq = DEFAULT_PROC_FREQ;
+	node_found = 0;
+	if (cpu != 0) {
+		fp = (unsigned int *)get_property(cpu, "clock-frequency",
+						  NULL);
+		if (fp != 0) {
+			node_found = 1;
+			ppc_proc_freq = *fp;
+		}
+	}
+	if (!node_found)
+		printk(KERN_ERR "WARNING: Estimating processor frequency "
+				"(not found)\n");
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
+
+static void __init bpa_setup_arch(void)
+{
+#ifdef CONFIG_SMP
+	smp_init_pSeries();
+#endif
+
+	/* init to some ~sane value until calibrate_delay() runs */
+	loops_per_jiffy = 50000000;
+
+	if (ROOT_DEV == 0) {
+		printk("No ramdisk, default root is /dev/hda2\n");
+		ROOT_DEV = Root_HDA2;
+	}
+
+	/* Find and initialize PCI host bridges */
+	init_pci_config_tokens();
+	find_and_init_phbs();
+
+#ifdef CONFIG_DUMMY_CONSOLE
+	conswitchp = &dummy_con;
+#endif
+
+	// bpa_nvram_init();
+}
+
+/*
+ * Early initialization.  Relocation is on but do not reference unbolted pages
+ */
+static void __init bpa_init_early(void)
+{
+	DBG(" -> bpa_init_early()\n");
+
+	hpte_init_native();
+
+	pci_direct_iommu_init();
+
+	ppc64_interrupt_controller = IC_BPA_IIC;
+
+	DBG(" <- bpa_init_early()\n");
+}
+
+
+static int __init bpa_probe(int platform)
+{
+	if (platform != PLATFORM_BPA)
+		return 0;
+
+	return 1;
+}
+
+struct machdep_calls __initdata bpa_md = {
+	.probe			= bpa_probe,
+	.setup_arch		= bpa_setup_arch,
+	.init_early		= bpa_init_early,
+	.get_cpuinfo		= bpa_get_cpuinfo,
+	.restart		= rtas_restart,
+	.power_off		= rtas_power_off,
+	.halt			= rtas_halt,
+	.get_boot_time		= pSeries_get_boot_time,
+	.get_rtc_time		= pSeries_get_rtc_time,
+	.set_rtc_time		= pSeries_set_rtc_time,
+	.calibrate_decr		= pSeries_calibrate_decr,
+	.progress		= bpa_progress,
+};
Index: linus-2.5/arch/ppc64/kernel/cpu_setup_power4.S
===================================================================
--- linus-2.5.orig/arch/ppc64/kernel/cpu_setup_power4.S	2005-04-22 06:52:24.000000000 +0200
+++ linus-2.5/arch/ppc64/kernel/cpu_setup_power4.S	2005-04-22 06:57:59.000000000 +0200
@@ -73,7 +73,21 @@
 
 _GLOBAL(__setup_cpu_power4)
 	blr
-	
+
+_GLOBAL(__setup_cpu_be)
+        /* Set large page sizes LP=0: 16MB, LP=1: 64KB */
+        addi    r3, 0,  0
+        ori     r3, r3, HID6_LB
+        sldi    r3, r3, 32
+        nor     r3, r3, r3
+        mfspr   r4, SPRN_HID6
+        and     r4, r4, r3
+        addi    r3, 0, 0x02000
+        sldi    r3, r3, 32
+        or      r4, r4, r3
+        mtspr   SPRN_HID6, r4
+	blr
+
 _GLOBAL(__setup_cpu_ppc970)
 	mfspr	r0,SPRN_HID0
 	li	r11,5			/* clear DOZE and SLEEP */
Index: linus-2.5/arch/ppc64/kernel/cputable.c
===================================================================
--- linus-2.5.orig/arch/ppc64/kernel/cputable.c	2005-04-22 06:52:24.000000000 +0200
+++ linus-2.5/arch/ppc64/kernel/cputable.c	2005-04-22 06:57:59.000000000 +0200
@@ -34,6 +34,7 @@
 extern void __setup_cpu_power3(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_power4(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_ppc970(unsigned long offset, struct cpu_spec* spec);
+extern void __setup_cpu_be(unsigned long offset, struct cpu_spec* spec);
 
 
 /* We only set the altivec features if the kernel was compiled with altivec
@@ -162,6 +163,16 @@
 	    __setup_cpu_power4,
 	    COMMON_PPC64_FW
     },
+    {	/* BE DD1.x  */
+	    0xffff0000, 0x00700000, "Broadband Engine",
+	    CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE |
+		    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_ALTIVEC_COMP |
+		    CPU_FTR_SMT,
+	    COMMON_USER_PPC64 | PPC_FEATURE_HAS_ALTIVEC_COMP,
+	    128, 128,
+	    __setup_cpu_be,
+	    COMMON_PPC64_FW
+    },
     {	/* default match */
 	    0x00000000, 0x00000000, "POWER4 (compatible)",
   	    CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE |
Index: linus-2.5/arch/ppc64/kernel/irq.c
===================================================================
--- linus-2.5.orig/arch/ppc64/kernel/irq.c	2005-04-22 06:52:24.000000000 +0200
+++ linus-2.5/arch/ppc64/kernel/irq.c	2005-04-22 06:57:59.000000000 +0200
@@ -395,6 +395,9 @@
 	if (ppc64_interrupt_controller == IC_OPEN_PIC)
 		return real_irq;	/* no mapping for openpic (for now) */
 
+	if (ppc64_interrupt_controller == IC_BPA_IIC)
+		return real_irq;	/* no mapping for iic either */
+
 	/* don't map interrupts < MIN_VIRT_IRQ */
 	if (real_irq < MIN_VIRT_IRQ) {
 		virt_irq_to_real_map[real_irq] = real_irq;
Index: linus-2.5/arch/ppc64/kernel/proc_ppc64.c
===================================================================
--- linus-2.5.orig/arch/ppc64/kernel/proc_ppc64.c	2005-04-22 06:52:24.000000000 +0200
+++ linus-2.5/arch/ppc64/kernel/proc_ppc64.c	2005-04-22 06:57:59.000000000 +0200
@@ -53,7 +53,7 @@
 	if (!root)
 		return 1;
 
-	if (!(systemcfg->platform & PLATFORM_PSERIES))
+	if (!(systemcfg->platform & (PLATFORM_PSERIES | PLATFORM_BPA)))
 		return 0;
 
 	if (!proc_mkdir("rtas", root))
Index: linus-2.5/arch/ppc64/kernel/prom_init.c
===================================================================
--- linus-2.5.orig/arch/ppc64/kernel/prom_init.c	2005-04-22 06:52:24.000000000 +0200
+++ linus-2.5/arch/ppc64/kernel/prom_init.c	2005-04-22 06:58:20.000000000 +0200
@@ -1731,9 +1731,9 @@
 		     &getprop_rval, sizeof(getprop_rval));
 
 	/*
-	 * On pSeries, copy the CPU hold code
+	 * On pSeries and BPA, copy the CPU hold code
 	 */
-       	if (RELOC(of_platform) & PLATFORM_PSERIES)
+       	if (RELOC(of_platform) & (PLATFORM_PSERIES | PLATFORM_BPA))
        		copy_and_flush(0, KERNELBASE - offset, 0x100, 0);
 
 	/*
Index: linus-2.5/arch/ppc64/kernel/setup.c
===================================================================
--- linus-2.5.orig/arch/ppc64/kernel/setup.c	2005-04-22 06:52:24.000000000 +0200
+++ linus-2.5/arch/ppc64/kernel/setup.c	2005-04-22 06:57:59.000000000 +0200
@@ -348,6 +348,7 @@
 extern struct machdep_calls pSeries_md;
 extern struct machdep_calls pmac_md;
 extern struct machdep_calls maple_md;
+extern struct machdep_calls bpa_md;
 
 /* Ultimately, stuff them in an elf section like initcalls... */
 static struct machdep_calls __initdata *machines[] = {
@@ -360,6 +361,9 @@
 #ifdef CONFIG_PPC_MAPLE
 	&maple_md,
 #endif /* CONFIG_PPC_MAPLE */
+#ifdef CONFIG_PPC_BPA
+	&bpa_md,
+#endif
 	NULL
 };
 
Index: linus-2.5/arch/ppc64/kernel/traps.c
===================================================================
--- linus-2.5.orig/arch/ppc64/kernel/traps.c	2005-04-22 06:57:28.000000000 +0200
+++ linus-2.5/arch/ppc64/kernel/traps.c	2005-04-22 06:57:59.000000000 +0200
@@ -126,6 +126,10 @@
 			printk("POWERMAC ");
 			nl = 1;
 			break;
+		case PLATFORM_BPA:
+			printk("BPA ");
+			nl = 1;
+			break;
 	}
 	if (nl)
 		printk("\n");
Index: linus-2.5/include/asm-ppc64/mmu.h
===================================================================
--- linus-2.5.orig/include/asm-ppc64/mmu.h	2005-04-22 06:52:24.000000000 +0200
+++ linus-2.5/include/asm-ppc64/mmu.h	2005-04-22 06:57:59.000000000 +0200
@@ -196,6 +196,8 @@
 #define SLB_VSID_N		0x0000000000000200	/* no-execute */
 #define SLB_VSID_L		0x0000000000000100	/* largepage (4M) */
 #define SLB_VSID_C		0x0000000000000080	/* class */
+#define SLB_VSID_LS		0x0000000000000070	/* LS if 1, then second
+							   large page size */
 
 #define SLB_VSID_KERNEL		(SLB_VSID_KP|SLB_VSID_C)
 #define SLB_VSID_USER		(SLB_VSID_KP|SLB_VSID_KS)
Index: linus-2.5/include/asm-ppc64/processor.h
===================================================================
--- linus-2.5.orig/include/asm-ppc64/processor.h	2005-04-22 06:57:29.000000000 +0200
+++ linus-2.5/include/asm-ppc64/processor.h	2005-04-22 06:57:59.000000000 +0200
@@ -217,14 +217,22 @@
 #define   HID0_ABE	(1<<3)		/* Address Broadcast Enable */
 #define	  HID0_BHTE	(1<<2)		/* Branch History Table Enable */
 #define	  HID0_BTCD	(1<<1)		/* Branch target cache disable */
+#define	SPRN_HID6	0x3F9	/* Hardware Implementation Register 6 */
+#define	  HID6_LB	(0x0F<<12)	/* Concurrent Large Page Modes */
+#define	  HID6_DLP	(1<<20)		/* Disable all large page modes (4K only) */
 #define	SPRN_MSRDORM	0x3F1	/* Hardware Implementation Register 1 */
 #define SPRN_HID1	0x3F1	/* Hardware Implementation Register 1 */
 #define	SPRN_IABR	0x3F2	/* Instruction Address Breakpoint Register */
 #define	SPRN_NIADORM	0x3F3	/* Hardware Implementation Register 2 */
 #define SPRN_HID4	0x3F4	/* 970 HID4 */
 #define SPRN_HID5	0x3F6	/* 970 HID5 */
-#define	SPRN_TSC 	0x3FD	/* Thread switch control */
-#define	SPRN_TST 	0x3FC	/* Thread switch timeout */
+#define	SPRN_TSCR	0x399   /* Thread switch control on BE */
+#define	SPRN_TTR	0x39A   /* Thread switch timeout on BE */
+#define	  TSCR_DEC_ENABLE	0x200000 /* Decrementer Interrupt */
+#define	  TSCR_EE_ENABLE	0x100000 /* External Interrupt */
+#define	  TSCR_EE_BOOST		0x080000 /* External Interrupt Boost */
+#define	SPRN_TSC 	0x3FD	/* Thread switch control on others */
+#define	SPRN_TST 	0x3FC	/* Thread switch timeout on others */
 #define	SPRN_IAC1	0x3F4	/* Instruction Address Compare 1 */
 #define	SPRN_IAC2	0x3F5	/* Instruction Address Compare 2 */
 #define	SPRN_ICCR	0x3FB	/* Instruction Cache Cacheability Register */
@@ -411,8 +419,9 @@
 #define	PV_POWER5	0x003A
 #define PV_POWER5p	0x003B
 #define PV_970FX	0x003C
-#define	PV_630        	0x0040
-#define	PV_630p	        0x0041
+#define	PV_630		0x0040
+#define	PV_630p		0x0041
+#define	PV_BE		0x0070
 
 /* Platforms supported by PPC64 */
 #define PLATFORM_PSERIES      0x0100
@@ -421,6 +430,7 @@
 #define PLATFORM_LPAR         0x0001
 #define PLATFORM_POWERMAC     0x0400
 #define PLATFORM_MAPLE        0x0500
+#define PLATFORM_BPA          0x1000
 
 /* Compatibility with drivers coming from PPC32 world */
 #define _machine	(systemcfg->platform)
@@ -432,6 +442,7 @@
 #define IC_INVALID    0
 #define IC_OPEN_PIC   1
 #define IC_PPC_XIC    2
+#define IC_BPA_IIC    3
 
 #define XGLUE(a,b) a##b
 #define GLUE(a,b) XGLUE(a,b)
Index: linus-2.5/include/asm-ppc64/smp.h
===================================================================
--- linus-2.5.orig/include/asm-ppc64/smp.h	2005-04-22 06:52:24.000000000 +0200
+++ linus-2.5/include/asm-ppc64/smp.h	2005-04-22 06:58:20.000000000 +0200
@@ -85,6 +85,14 @@
 
 extern struct smp_ops_t *smp_ops;
 
+#ifdef CONFIG_PPC_PSERIES
+void vpa_init(int cpu);
+#else
+static inline void vpa_init(int cpu)
+{
+}
+#endif /* CONFIG_PPC_PSERIES */
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* !(_PPC64_SMP_H) */

