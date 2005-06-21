Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262378AbVFUWOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262378AbVFUWOO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 18:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbVFUWMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 18:12:47 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:11006 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262554AbVFUVj3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 17:39:29 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 7/11] ppc64: add BPA platform type
Date: Tue, 21 Jun 2005 23:24:19 +0200
User-Agent: KMail/1.7.2
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
References: <200506212310.54156.arnd@arndb.de> <200506212320.05799.arnd@arndb.de> <200506212322.36453.arnd@arndb.de>
In-Reply-To: <200506212322.36453.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506212324.19713.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the basic support for running on BPA machines.
So far, this is only the IBM workstation, and it will
not run on others without a little more generalization.

It should be possible to configure a kernel for any
combination of CONFIG_PPC_BPA with any of the other
multiplatform targets.

Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

--

 MAINTAINERS                          |    7 +
 arch/ppc64/Kconfig                   |    6 +
 arch/ppc64/Makefile                  |    2
 arch/ppc64/kernel/Makefile           |    3
 arch/ppc64/kernel/bpa_setup.c        |  135 +++++++++++++++++++++++++++++++++++
 arch/ppc64/kernel/cpu_setup_power4.S |   16 +++-
 arch/ppc64/kernel/cputable.c         |   11 ++
 arch/ppc64/kernel/irq.c              |    3
 arch/ppc64/kernel/proc_ppc64.c       |    2
 arch/ppc64/kernel/prom_init.c        |    4 -
 arch/ppc64/kernel/setup.c            |    4 +
 arch/ppc64/kernel/traps.c            |    4 +
 include/asm-ppc64/mmu.h              |    5 -
 include/asm-ppc64/processor.h        |   15 +++
 include/asm-ppc64/smp.h              |    8 ++
 15 files changed, 216 insertions(+), 9 deletions(-)

--- linux-cg.orig/MAINTAINERS	2005-06-21 02:58:35.570002888 -0400
+++ linux-cg/MAINTAINERS	2005-06-21 03:01:35.220979888 -0400
@@ -499,6 +499,13 @@ L:   bonding-devel@lists.sourceforge.net
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
--- linux-cg.orig/arch/ppc64/Kconfig	2005-06-21 02:58:35.572002584 -0400
+++ linux-cg/arch/ppc64/Kconfig	2005-06-21 03:01:35.221979736 -0400
@@ -77,6 +77,10 @@ config PPC_PSERIES
 	bool "  IBM pSeries & new iSeries"
 	default y
 
+config PPC_BPA
+	bool "  Broadband Processor Architecture"
+	depends on PPC_MULTIPLATFORM
+
 config PPC_PMAC
 	depends on PPC_MULTIPLATFORM
 	bool "  Apple G5 based machines"
@@ -256,7 +260,7 @@ config MSCHUNKS
 
 config PPC_RTAS
 	bool
-	depends on PPC_PSERIES
+	depends on PPC_PSERIES || PPC_BPA
 	default y
 
 config RTAS_PROC
--- linux-cg.orig/arch/ppc64/Makefile	2005-06-21 02:58:35.574002280 -0400
+++ linux-cg/arch/ppc64/Makefile	2005-06-21 03:01:35.222979584 -0400
@@ -90,12 +90,14 @@ boot := arch/ppc64/boot
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
--- linux-cg.orig/arch/ppc64/kernel/Makefile	2005-06-21 02:58:35.577001824 -0400
+++ linux-cg/arch/ppc64/kernel/Makefile	2005-06-21 03:01:35.222979584 -0400
@@ -34,6 +34,8 @@ obj-$(CONFIG_PPC_PSERIES) += pSeries_pci
 			     pSeries_nvram.o rtasd.o ras.o pSeries_reconfig.o \
 			     xics.o pSeries_setup.o pSeries_iommu.o
 
+obj-$(CONFIG_PPC_BPA) += bpa_setup.o bpa_nvram.o
+
 obj-$(CONFIG_EEH)		+= eeh.o
 obj-$(CONFIG_PROC_FS)		+= proc_ppc64.o
 obj-$(CONFIG_RTAS_FLASH)	+= rtas_flash.o
@@ -60,6 +62,7 @@ ifdef CONFIG_SMP
 obj-$(CONFIG_PPC_PMAC)		+= pmac_smp.o smp-tbsync.o
 obj-$(CONFIG_PPC_ISERIES)	+= iSeries_smp.o
 obj-$(CONFIG_PPC_PSERIES)	+= pSeries_smp.o
+obj-$(CONFIG_PPC_BPA)		+= pSeries_smp.o
 obj-$(CONFIG_PPC_MAPLE)		+= smp-tbsync.o
 endif
 
--- linux-cg.orig/arch/ppc64/kernel/bpa_setup.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-cg/arch/ppc64/kernel/bpa_setup.c	2005-06-21 03:01:52.874957760 -0400
@@ -0,0 +1,135 @@
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
+static void bpa_progress(char *s, unsigned short hex)
+{
+	printk("*** %04x : %s\n", hex, s ? s : "");
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
+	.get_boot_time		= rtas_get_boot_time,
+	.get_rtc_time		= rtas_get_rtc_time,
+	.set_rtc_time		= rtas_set_rtc_time,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= bpa_progress,
+};
--- linux-cg.orig/arch/ppc64/kernel/cpu_setup_power4.S	2005-06-21 02:58:35.581001216 -0400
+++ linux-cg/arch/ppc64/kernel/cpu_setup_power4.S	2005-06-21 03:01:35.224979280 -0400
@@ -73,7 +73,21 @@ _GLOBAL(__970_cpu_preinit)
 
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
--- linux-cg.orig/arch/ppc64/kernel/cputable.c	2005-06-21 02:58:35.584000760 -0400
+++ linux-cg/arch/ppc64/kernel/cputable.c	2005-06-21 03:01:35.224979280 -0400
@@ -34,6 +34,7 @@ EXPORT_SYMBOL(cur_cpu_spec);
 extern void __setup_cpu_power3(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_power4(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_ppc970(unsigned long offset, struct cpu_spec* spec);
+extern void __setup_cpu_be(unsigned long offset, struct cpu_spec* spec);
 
 
 /* We only set the altivec features if the kernel was compiled with altivec
@@ -162,6 +163,16 @@ struct cpu_spec	cpu_specs[] = {
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
--- linux-cg.orig/arch/ppc64/kernel/irq.c	2005-06-21 02:58:35.586000456 -0400
+++ linux-cg/arch/ppc64/kernel/irq.c	2005-06-21 03:01:35.225979128 -0400
@@ -395,6 +395,9 @@ int virt_irq_create_mapping(unsigned int
 	if (ppc64_interrupt_controller == IC_OPEN_PIC)
 		return real_irq;	/* no mapping for openpic (for now) */
 
+	if (ppc64_interrupt_controller == IC_BPA_IIC)
+		return real_irq;	/* no mapping for iic either */
+
 	/* don't map interrupts < MIN_VIRT_IRQ */
 	if (real_irq < MIN_VIRT_IRQ) {
 		virt_irq_to_real_map[real_irq] = real_irq;
--- linux-cg.orig/arch/ppc64/kernel/proc_ppc64.c	2005-06-21 02:58:35.588000152 -0400
+++ linux-cg/arch/ppc64/kernel/proc_ppc64.c	2005-06-21 03:01:35.226978976 -0400
@@ -53,7 +53,7 @@ static int __init proc_ppc64_create(void
 	if (!root)
 		return 1;
 
-	if (!(systemcfg->platform & PLATFORM_PSERIES))
+	if (!(systemcfg->platform & (PLATFORM_PSERIES | PLATFORM_BPA)))
 		return 0;
 
 	if (!proc_mkdir("rtas", root))
--- linux-cg.orig/arch/ppc64/kernel/prom_init.c	2005-06-21 02:58:35.589999848 -0400
+++ linux-cg/arch/ppc64/kernel/prom_init.c	2005-06-21 03:01:35.228978672 -0400
@@ -1915,9 +1915,9 @@ unsigned long __init prom_init(unsigned 
 		prom_send_capabilities();
 
 	/*
-	 * On pSeries, copy the CPU hold code
+	 * On pSeries and BPA, copy the CPU hold code
 	 */
-       	if (RELOC(of_platform) & PLATFORM_PSERIES)
+       	if (RELOC(of_platform) & (PLATFORM_PSERIES | PLATFORM_BPA))
        		copy_and_flush(0, KERNELBASE - offset, 0x100, 0);
 
 	/*
--- linux-cg.orig/arch/ppc64/kernel/setup.c	2005-06-21 02:58:35.592999392 -0400
+++ linux-cg/arch/ppc64/kernel/setup.c	2005-06-21 03:01:35.229978520 -0400
@@ -343,6 +343,7 @@ static void __init setup_cpu_maps(void)
 extern struct machdep_calls pSeries_md;
 extern struct machdep_calls pmac_md;
 extern struct machdep_calls maple_md;
+extern struct machdep_calls bpa_md;
 
 /* Ultimately, stuff them in an elf section like initcalls... */
 static struct machdep_calls __initdata *machines[] = {
@@ -355,6 +356,9 @@ static struct machdep_calls __initdata *
 #ifdef CONFIG_PPC_MAPLE
 	&maple_md,
 #endif /* CONFIG_PPC_MAPLE */
+#ifdef CONFIG_PPC_BPA
+	&bpa_md,
+#endif
 	NULL
 };
 
--- linux-cg.orig/arch/ppc64/kernel/traps.c	2005-06-21 02:58:35.594999088 -0400
+++ linux-cg/arch/ppc64/kernel/traps.c	2005-06-21 03:01:35.230978368 -0400
@@ -126,6 +126,10 @@ int die(const char *str, struct pt_regs 
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
--- linux-cg.orig/include/asm-ppc64/mmu.h	2005-06-21 02:58:35.596998784 -0400
+++ linux-cg/include/asm-ppc64/mmu.h	2005-06-21 03:01:35.231978216 -0400
@@ -47,9 +47,10 @@
 #define SLB_VSID_KS		ASM_CONST(0x0000000000000800)
 #define SLB_VSID_KP		ASM_CONST(0x0000000000000400)
 #define SLB_VSID_N		ASM_CONST(0x0000000000000200) /* no-execute */
-#define SLB_VSID_L		ASM_CONST(0x0000000000000100) /* largepage 16M */
+#define SLB_VSID_L		ASM_CONST(0x0000000000000100) /* largepage */
 #define SLB_VSID_C		ASM_CONST(0x0000000000000080) /* class */
-
+#define SLB_VSID_LS		ASM_CONST(0x0000000000000070) /* size of largepage */
+ 
 #define SLB_VSID_KERNEL		(SLB_VSID_KP|SLB_VSID_C)
 #define SLB_VSID_USER		(SLB_VSID_KP|SLB_VSID_KS)
 
--- linux-cg.orig/include/asm-ppc64/processor.h	2005-06-21 02:58:35.598998480 -0400
+++ linux-cg/include/asm-ppc64/processor.h	2005-06-21 03:01:35.232978064 -0400
@@ -138,8 +138,16 @@
 #define	SPRN_NIADORM	0x3F3	/* Hardware Implementation Register 2 */
 #define SPRN_HID4	0x3F4	/* 970 HID4 */
 #define SPRN_HID5	0x3F6	/* 970 HID5 */
-#define	SPRN_TSC 	0x3FD	/* Thread switch control */
-#define	SPRN_TST 	0x3FC	/* Thread switch timeout */
+#define	SPRN_HID6	0x3F9	/* BE HID 6 */
+#define	  HID6_LB	(0x0F<<12) /* Concurrent Large Page Modes */
+#define	  HID6_DLP	(1<<20)	/* Disable all large page modes (4K only) */
+#define	SPRN_TSCR	0x399   /* Thread switch control on BE */
+#define	SPRN_TTR	0x39A   /* Thread switch timeout on BE */
+#define	  TSCR_DEC_ENABLE	0x200000 /* Decrementer Interrupt */
+#define	  TSCR_EE_ENABLE	0x100000 /* External Interrupt */
+#define	  TSCR_EE_BOOST		0x080000 /* External Interrupt Boost */
+#define	SPRN_TSC 	0x3FD	/* Thread switch control on others */
+#define	SPRN_TST 	0x3FC	/* Thread switch timeout on others */
 #define	SPRN_L2CR	0x3F9	/* Level 2 Cache Control Regsiter */
 #define	SPRN_LR		0x008	/* Link Register */
 #define	SPRN_PIR	0x3FF	/* Processor Identification Register */
@@ -259,6 +267,7 @@
 #define PV_970FX	0x003C
 #define	PV_630        	0x0040
 #define	PV_630p	        0x0041
+#define	PV_BE		0x0070
 
 /* Platforms supported by PPC64 */
 #define PLATFORM_PSERIES      0x0100
@@ -267,6 +276,7 @@
 #define PLATFORM_LPAR         0x0001
 #define PLATFORM_POWERMAC     0x0400
 #define PLATFORM_MAPLE        0x0500
+#define PLATFORM_BPA          0x1000
 
 /* Compatibility with drivers coming from PPC32 world */
 #define _machine	(systemcfg->platform)
@@ -278,6 +288,7 @@
 #define IC_INVALID    0
 #define IC_OPEN_PIC   1
 #define IC_PPC_XIC    2
+#define IC_BPA_IIC    3
 
 #define XGLUE(a,b) a##b
 #define GLUE(a,b) XGLUE(a,b)
--- linux-cg.orig/include/asm-ppc64/smp.h	2005-06-21 02:58:35.601998024 -0400
+++ linux-cg/include/asm-ppc64/smp.h	2005-06-21 03:01:35.232978064 -0400
@@ -85,6 +85,14 @@ extern void smp_generic_take_timebase(vo
 
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

