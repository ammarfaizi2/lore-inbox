Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964849AbVLISVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbVLISVv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 13:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964857AbVLISUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 13:20:36 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:42455 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964849AbVLIST5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 13:19:57 -0500
Message-Id: <20051209182054.167727000@localhost>
References: <20051209180414.872465000@localhost>
Date: Fri, 09 Dec 2005 19:04:19 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Maximino Aguilar <maguilar@us.ibm.com>,
       Arnd Bergmann <arndb@de.ibm.com>
Subject: [PATCH 5/8] cell: enable pause(0) in cpu_idle
Content-Disposition: inline; filename=bpa-pmd-add-3.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables support for pause(0) power management state
for the Cell Broadband Processor, which is import for power efficient
operation. The pervasive infrastructure will in the future enable
us to introduce more functionality specific to the Cell's
pervasive unit.

This version contains fixes for a few problems found by
Milton Miller and a fix to keep running on Cell BE DD2
CPUs, where the hardware feature is broken.

From: Maximino Aguilar <maguilar@us.ibm.com>
Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

Index: linux-2.6.15-rc/arch/powerpc/platforms/cell/Makefile
===================================================================
--- linux-2.6.15-rc.orig/arch/powerpc/platforms/cell/Makefile
+++ linux-2.6.15-rc/arch/powerpc/platforms/cell/Makefile
@@ -1,4 +1,6 @@
 obj-y			+= interrupt.o iommu.o setup.o spider-pic.o
+obj-y			+= pervasive.o
+
 obj-$(CONFIG_SMP)	+= smp.o
 obj-$(CONFIG_SPU_FS)	+= spufs/ spu_base.o
 builtin-spufs-$(CONFIG_SPU_FS)	+= spu_syscalls.o
Index: linux-2.6.15-rc/arch/powerpc/platforms/cell/pervasive.c
===================================================================
--- /dev/null
+++ linux-2.6.15-rc/arch/powerpc/platforms/cell/pervasive.c
@@ -0,0 +1,169 @@
+/*
+ * CBE Pervasive Monitor and Debug
+ *
+ * (C) Copyright IBM Corporation 2005
+ *
+ * Authors: Maximino Aguilar (maguilar@us.ibm.com)
+ *          Michael N. Day (mnday@us.ibm.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/config.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/percpu.h>
+#include <linux/types.h>
+
+#include <asm/io.h>
+#include <asm/machdep.h>
+#include <asm/prom.h>
+#include <asm/pgtable.h>
+#include <asm/reg.h>
+
+#include "pervasive.h"
+
+struct cbe_pervasive {
+	struct pmd_regs __iomem *regs;
+	int power_management_enable;
+};
+
+static DEFINE_PER_CPU(struct cbe_pervasive, cbe_pervasive);
+
+static void pause_zero(void)
+{
+	unsigned int multi_threading_control;
+
+	/* Reset Thread Run Latch (latch is set in idle.c) */
+	ppc64_runlatch_off();
+
+	local_irq_disable();
+	if (__get_cpu_var(cbe_pervasive).power_management_enable) {
+		/* Pause the PU */
+		HMT_low();
+		multi_threading_control = 0;
+		mtspr(SPRN_CTRLT,multi_threading_control);
+	}
+	local_irq_disable();
+}
+
+static void pause_zero_idle(void)
+{
+	set_thread_flag(TIF_POLLING_NRFLAG);
+
+	while (1) {
+		if (!need_resched()) {
+			while (!need_resched()) {
+				ppc64_runlatch_off();
+				pause_zero();
+				/*
+				 * Go into low thread priority and possibly
+				 * low power mode.
+				 */
+				HMT_low();
+				HMT_very_low();
+			}
+
+			HMT_medium();
+		}
+
+		ppc64_runlatch_on();
+		preempt_enable_no_resched();
+		schedule();
+		preempt_disable();
+	}
+}
+
+static void enable_pause_zero(void * data)
+{
+	unsigned long thread_switch_control;
+	unsigned long temp_register;
+	struct cbe_pervasive *cbe_pervasive;
+
+	cbe_pervasive = &get_cpu_var(cbe_pervasive);
+
+	if (!cbe_pervasive->regs)
+		return;
+
+	pr_debug("Power Management: CPU %d\n", smp_processor_id());
+
+	 /* Enable Pause(0) control bit */
+	temp_register = in_be64(&cbe_pervasive->regs->pm_control);
+
+	out_be64(&cbe_pervasive->regs->pm_control,
+		 temp_register|PMD_PAUSE_ZERO_CONTROL);
+
+	/* Enable DEC and EE interrupt request */
+	thread_switch_control  = mfspr(SPRN_TSC_CELL);
+	thread_switch_control |= TSC_CELL_EE_ENABLE | TSC_CELL_EE_BOOST;
+
+	if (smp_processor_id()%2)
+		thread_switch_control |= TSC_CELL_DEC_ENABLE_1;
+	else
+		thread_switch_control |= TSC_CELL_DEC_ENABLE_0;
+
+	mtspr(SPRN_TSC_CELL, thread_switch_control);
+
+	cbe_pervasive->power_management_enable = 1;
+	put_cpu_var(cbe_pervasive);
+}
+
+static struct pmd_regs __iomem *find_pmd_mmio(int cpu)
+{
+	struct device_node *node;
+	int node_number = cpu / 2;
+	struct pmd_regs __iomem *pmd_mmio_area;
+	unsigned long real_address;
+
+	for (node = of_find_node_by_type(NULL, "cpu"); node;
+		node = of_find_node_by_type(node, "cpu")) {
+			if (node_number == *(int *)
+				get_property(node, "node-id", NULL))
+			break;
+	}
+
+	if (!node) {
+		printk(KERN_WARNING "PMD: CPU %d not found\n", cpu);
+		pmd_mmio_area = NULL;
+	} else {
+		real_address = *(long *)get_property(node, "pervasive", NULL);
+		pr_debug("PMD for CPU %d at %lx\n", cpu, real_address);
+		pmd_mmio_area = __ioremap(real_address, 0x1000, _PAGE_NO_CACHE);
+	}
+	return pmd_mmio_area;
+}
+
+void __init cell_pervasive_init(void)
+{
+	struct cbe_pervasive *cbe_pervasive;
+	int cpu;
+
+	if (!cpu_has_feature(CPU_FTR_PAUSE_ZERO))
+		return;
+
+	for_each_cpu(cpu) {
+		cbe_pervasive = &per_cpu(cbe_pervasive, cpu);
+		cbe_pervasive->regs = find_pmd_mmio(cpu);
+	}
+}
+
+static int __init enable_pause_zero_init(void)
+{
+	on_each_cpu(enable_pause_zero, NULL, 0, 1);
+	ppc_md.idle_loop = pause_zero_idle;
+	return 0;
+}
+
+arch_initcall(enable_pause_zero_init);
Index: linux-2.6.15-rc/arch/powerpc/platforms/cell/pervasive.h
===================================================================
--- /dev/null
+++ linux-2.6.15-rc/arch/powerpc/platforms/cell/pervasive.h
@@ -0,0 +1,62 @@
+/*
+ * Cell Pervasive Monitor and Debug interface and HW structures
+ *
+ * (C) Copyright IBM Corporation 2005
+ *
+ * Authors: Maximino Aguilar (maguilar@us.ibm.com)
+ *          David J. Erb (djerb@us.ibm.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+
+#ifndef PERVASIVE_H
+#define PERVASIVE_H
+
+struct pmd_regs {
+	u8 pad_0x0000_0x0800[0x0800 - 0x0000];			/* 0x0000 */
+
+	/* Thermal Sensor Registers */
+	u64  ts_ctsr1;						/* 0x0800 */
+	u64  ts_ctsr2;						/* 0x0808 */
+	u64  ts_mtsr1;						/* 0x0810 */
+	u64  ts_mtsr2;						/* 0x0818 */
+	u64  ts_itr1;						/* 0x0820 */
+	u64  ts_itr2;						/* 0x0828 */
+	u64  ts_gitr;						/* 0x0830 */
+	u64  ts_isr;						/* 0x0838 */
+	u64  ts_imr;						/* 0x0840 */
+	u64  tm_cr1;						/* 0x0848 */
+	u64  tm_cr2;						/* 0x0850 */
+	u64  tm_simr;						/* 0x0858 */
+	u64  tm_tpr;						/* 0x0860 */
+	u64  tm_str1;						/* 0x0868 */
+	u64  tm_str2;						/* 0x0870 */
+	u64  tm_tsr;						/* 0x0878 */
+
+	/* Power Management */
+	u64  pm_control;					/* 0x0880 */
+#define PMD_PAUSE_ZERO_CONTROL		0x10000
+	u64  pm_status;						/* 0x0888 */
+
+	/* Time Base Register */
+	u64  tbr;						/* 0x0890 */
+
+	u8   pad_0x0898_0x1000 [0x1000 - 0x0898];		/* 0x0898 */
+};
+
+void __init cell_pervasive_init(void);
+
+#endif
Index: linux-2.6.15-rc/arch/powerpc/platforms/cell/setup.c
===================================================================
--- linux-2.6.15-rc.orig/arch/powerpc/platforms/cell/setup.c
+++ linux-2.6.15-rc/arch/powerpc/platforms/cell/setup.c
@@ -49,6 +49,7 @@
 
 #include "interrupt.h"
 #include "iommu.h"
+#include "pervasive.h"
 
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
@@ -165,6 +166,7 @@ static void __init cell_setup_arch(void)
 	init_pci_config_tokens();
 	find_and_init_phbs();
 	spider_init_IRQ();
+	cell_pervasive_init();
 #ifdef CONFIG_DUMMY_CONSOLE
 	conswitchp = &dummy_con;
 #endif
Index: linux-2.6.15-rc/arch/powerpc/kernel/head_64.S
===================================================================
--- linux-2.6.15-rc.orig/arch/powerpc/kernel/head_64.S
+++ linux-2.6.15-rc/arch/powerpc/kernel/head_64.S
@@ -401,7 +401,7 @@ label##_common:						\
 	.globl __start_interrupts
 __start_interrupts:
 
-	STD_EXCEPTION_PSERIES(0x100, system_reset)
+	STD_EXCEPTION_PSERIES(0x100, system_reset_check)
 
 	. = 0x200
 _machine_check_pSeries:
@@ -880,6 +880,28 @@ unrecov_fer:
 	bl	.unrecoverable_exception
 	b	1b
 
+/* This is a new system reset handler for the BE processor.
+ * SRR1 stores wake information that must be decoded to determine why
+ * the processor was at the system reset handler.
+ */
+
+	.align 7
+	.globl system_reset_check_common
+system_reset_check_common:
+BEGIN_FTR_SECTION
+	mr	r22,r12    /* r12 has SRR1 saved */
+	srwi	r22,r22,16
+	andi.	r22,r22,MSR_WAKEMASK
+	cmpwi	r22,MSR_WAKEEE
+	beq	hardware_interrupt_common
+	cmpwi	r22,MSR_WAKEDEC
+	beq	decrementer_common
+	cmpwi	r22,MSR_WAKEMT
+	bne	system_reset_common
+END_FTR_SECTION_IFSET(CPU_FTR_PAUSE_ZERO)
+	EXCEPTION_PROLOG_COMMON(0x100, PACA_EXGEN);
+	b	fast_exception_return
+
 /*
  * Here r13 points to the paca, r9 contains the saved CR,
  * SRR0 and SRR1 are saved in r11 and r12,
Index: linux-2.6.15-rc/arch/powerpc/kernel/idle_64.c
===================================================================
--- linux-2.6.15-rc.orig/arch/powerpc/kernel/idle_64.c
+++ linux-2.6.15-rc/arch/powerpc/kernel/idle_64.c
@@ -40,7 +40,6 @@ void default_idle(void)
 		if (!need_resched()) {
 			while (!need_resched() && !cpu_is_offline(cpu)) {
 				ppc64_runlatch_off();
-
 				/*
 				 * Go into low thread priority and possibly
 				 * low power mode.
Index: linux-2.6.15-rc/include/asm-powerpc/cputable.h
===================================================================
--- linux-2.6.15-rc.orig/include/asm-powerpc/cputable.h
+++ linux-2.6.15-rc/include/asm-powerpc/cputable.h
@@ -106,6 +106,7 @@ extern void do_cpu_ftr_fixups(unsigned l
 #define CPU_FTR_LOCKLESS_TLBIE		ASM_CONST(0x0000040000000000)
 #define CPU_FTR_MMCRA_SIHV		ASM_CONST(0x0000080000000000)
 #define CPU_FTR_CI_LARGE_PAGE		ASM_CONST(0x0000100000000000)
+#define CPU_FTR_PAUSE_ZERO		ASM_CONST(0x0000200000000000)
 #else
 /* ensure on 32b processors the flags are available for compiling but
  * don't do anything */
@@ -303,9 +304,11 @@ enum {
 	    CPU_FTR_MMCRA | CPU_FTR_SMT |
 	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_LOCKLESS_TLBIE |
 	    CPU_FTR_MMCRA_SIHV,
-	CPU_FTRS_CELL = CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
+	CPU_FTRS_CELL_V2 = CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 |
-	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT,
+	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT |
+	    CPU_FTR_CTRL,
+	CPU_FTRS_CELL = CPU_FTRS_CELL_V2 | CPU_FTR_PAUSE_ZERO,
 	CPU_FTRS_COMPATIBLE = CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2,
 #endif
@@ -387,7 +390,7 @@ enum {
 #endif
 #ifdef __powerpc64__
 	    CPU_FTRS_POWER3 & CPU_FTRS_RS64 & CPU_FTRS_POWER4 &
-	    CPU_FTRS_PPC970 & CPU_FTRS_POWER5 & CPU_FTRS_CELL &
+	    CPU_FTRS_PPC970 & CPU_FTRS_POWER5 & CPU_FTRS_CELL_V2 &
 #endif
 	    CPU_FTRS_POSSIBLE,
 };
Index: linux-2.6.15-rc/include/asm-powerpc/reg.h
===================================================================
--- linux-2.6.15-rc.orig/include/asm-powerpc/reg.h
+++ linux-2.6.15-rc/include/asm-powerpc/reg.h
@@ -92,6 +92,15 @@
 #define MSR_RI		__MASK(MSR_RI_LG)	/* Recoverable Exception */
 #define MSR_LE		__MASK(MSR_LE_LG)	/* Little Endian */
 
+/* Wake Events */
+#define MSR_WAKEMASK	0x0038
+#define MSR_WAKERESET	0x0038
+#define MSR_WAKESYSERR	0x0030
+#define MSR_WAKEEE	0x0020
+#define MSR_WAKEMT	0x0028
+#define MSR_WAKEDEC	0x0018
+#define MSR_WAKETHERM	0x0010
+
 #ifdef CONFIG_PPC64
 #define MSR_		MSR_ME | MSR_RI | MSR_IR | MSR_DR | MSR_ISF
 #define MSR_KERNEL      MSR_ | MSR_SF | MSR_HV
@@ -257,11 +266,11 @@
 #define	SPRN_HID6	0x3F9	/* BE HID 6 */
 #define	  HID6_LB	(0x0F<<12) /* Concurrent Large Page Modes */
 #define	  HID6_DLP	(1<<20)	/* Disable all large page modes (4K only) */
-#define	SPRN_TSCR	0x399   /* Thread switch control on BE */
-#define	SPRN_TTR	0x39A   /* Thread switch timeout on BE */
-#define	  TSCR_DEC_ENABLE	0x200000 /* Decrementer Interrupt */
-#define	  TSCR_EE_ENABLE	0x100000 /* External Interrupt */
-#define	  TSCR_EE_BOOST		0x080000 /* External Interrupt Boost */
+#define	SPRN_TSC_CELL	0x399	/* Thread switch control on Cell */
+#define	  TSC_CELL_DEC_ENABLE_0	0x400000 /* Decrementer Interrupt */
+#define	  TSC_CELL_DEC_ENABLE_1	0x200000 /* Decrementer Interrupt */
+#define	  TSC_CELL_EE_ENABLE	0x100000 /* External Interrupt */
+#define	  TSC_CELL_EE_BOOST	0x080000 /* External Interrupt Boost */
 #define	SPRN_TSC 	0x3FD	/* Thread switch control on others */
 #define	SPRN_TST 	0x3FC	/* Thread switch timeout on others */
 #if !defined(SPRN_IAC1) && !defined(SPRN_IAC2)
Index: linux-2.6.15-rc/arch/powerpc/kernel/cputable.c
===================================================================
--- linux-2.6.15-rc.orig/arch/powerpc/kernel/cputable.c
+++ linux-2.6.15-rc/arch/powerpc/kernel/cputable.c
@@ -273,7 +273,18 @@ struct cpu_spec	cpu_specs[] = {
 		.oprofile_model		= &op_model_power4,
 #endif
 	},
-	{	/* BE DD1.x */
+	{	/* Cell BE 2.x */
+		.pvr_mask		= 0xffffff00,
+		.pvr_value		= 0x00700400,
+		.cpu_name		= "Cell Broadband Engine",
+		.cpu_features		= CPU_FTRS_CELL_V2,
+		.cpu_user_features	= COMMON_USER_PPC64 |
+			PPC_FEATURE_CELL | PPC_FEATURE_HAS_ALTIVEC_COMP,
+		.icache_bsize		= 128,
+		.dcache_bsize		= 128,
+		.cpu_setup		= __setup_cpu_be,
+	},
+	{	/* Generic Cell BE */
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x00700000,
 		.cpu_name		= "Cell Broadband Engine",

--

