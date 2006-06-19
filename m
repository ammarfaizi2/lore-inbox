Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932534AbWFSSoy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932534AbWFSSoy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 14:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932546AbWFSSoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 14:44:03 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:457 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932540AbWFSSnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 14:43:23 -0400
Message-Id: <20060619183404.144740000@klappe.arndb.de>
References: <20060619183315.653672000@klappe.arndb.de>
Date: Mon, 19 Jun 2006 20:33:16 +0200
From: arnd@arndb.de
To: paulus@samba.org
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: [patch 01/20] cell: add RAS support
Content-Disposition: inline; filename=cell-ras-4.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

This is a first version of support for the Cell BE "Reliability,
Availability and Serviceability" features.

It doesn't yet handle some of the RAS interrupts (the ones described in
iic_is/iic_irr), I'm still working on a proper way to expose these. They
are essentially a cascaded controller by themselves (sic !) though I may
just handle them locally to the iic driver. I need also to sync with
David Erb on the way he hooked in the performance monitor interrupt.

So that's all for 2.6.17 and I'll do more work on that with my rework of
the powerpc interrupt layer that I'm hacking on at the moment.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: powerpc.git/arch/powerpc/kernel/head_64.S
===================================================================
--- powerpc.git.orig/arch/powerpc/kernel/head_64.S
+++ powerpc.git/arch/powerpc/kernel/head_64.S
@@ -316,6 +316,21 @@ label##_pSeries:					\
 	mtspr	SPRN_SPRG1,r13;		/* save r13 */	\
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, label##_common)
 
+#define HSTD_EXCEPTION_PSERIES(n, label)		\
+	. = n;						\
+	.globl label##_pSeries;				\
+label##_pSeries:					\
+	HMT_MEDIUM;					\
+	mtspr	SPRN_SPRG1,r20;		/* save r20 */	\
+	mfspr	r20,SPRN_HSRR0;		/* copy HSRR0 to SRR0 */ \
+	mtspr	SPRN_SRR0,r20;				\
+	mfspr	r20,SPRN_HSRR1;		/* copy HSRR0 to SRR0 */ \
+	mtspr	SPRN_SRR1,r20;				\
+	mfspr	r20,SPRN_SPRG1;		/* restore r20 */ \
+	mtspr	SPRN_SPRG1,r13;		/* save r13 */	\
+	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, label##_common)
+
+
 #define STD_EXCEPTION_ISERIES(n, label, area)		\
 	.globl label##_iSeries;				\
 label##_iSeries:					\
@@ -544,8 +559,17 @@ system_call_pSeries:
 
 	STD_EXCEPTION_PSERIES(0xf20, altivec_unavailable)
 
+#ifdef CONFIG_CBE_RAS
+	HSTD_EXCEPTION_PSERIES(0x1200, cbe_system_error)
+#endif /* CONFIG_CBE_RAS */
 	STD_EXCEPTION_PSERIES(0x1300, instruction_breakpoint)
+#ifdef CONFIG_CBE_RAS
+	HSTD_EXCEPTION_PSERIES(0x1600, cbe_maintenance)
+#endif /* CONFIG_CBE_RAS */
 	STD_EXCEPTION_PSERIES(0x1700, altivec_assist)
+#ifdef CONFIG_CBE_RAS
+	HSTD_EXCEPTION_PSERIES(0x1800, cbe_thermal)
+#endif /* CONFIG_CBE_RAS */
 
 	. = 0x3000
 
@@ -827,6 +851,11 @@ machine_check_common:
 #else
 	STD_EXCEPTION_COMMON(0x1700, altivec_assist, .unknown_exception)
 #endif
+#ifdef CONFIG_CBE_RAS
+	STD_EXCEPTION_COMMON(0x1200, cbe_system_error, .cbe_system_error_exception)
+	STD_EXCEPTION_COMMON(0x1600, cbe_maintenance, .cbe_maintenance_exception)
+	STD_EXCEPTION_COMMON(0x1800, cbe_thermal, .cbe_thermal_exception)
+#endif /* CONFIG_CBE_RAS */
 
 /*
  * Here we have detected that the kernel stack pointer is bad.
Index: powerpc.git/arch/powerpc/platforms/cell/Kconfig
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/cell/Kconfig
+++ powerpc.git/arch/powerpc/platforms/cell/Kconfig
@@ -16,4 +16,8 @@ config SPUFS_MMAP
 	select MEMORY_HOTPLUG
 	default y
 
+config CBE_RAS
+	bool "RAS features for bare metal Cell BE"
+	default y
+
 endmenu
Index: powerpc.git/arch/powerpc/platforms/cell/Makefile
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/cell/Makefile
+++ powerpc.git/arch/powerpc/platforms/cell/Makefile
@@ -1,5 +1,6 @@
 obj-y			+= interrupt.o iommu.o setup.o spider-pic.o
-obj-y			+= pervasive.o
+obj-y			+= cbe_regs.o pervasive.o
+obj-$(CONFIG_CBE_RAS)	+= ras.o
 
 obj-$(CONFIG_SMP)	+= smp.o
 obj-$(CONFIG_SPU_FS)	+= spu-base.o spufs/
Index: powerpc.git/arch/powerpc/platforms/cell/pervasive.c
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/cell/pervasive.c
+++ powerpc.git/arch/powerpc/platforms/cell/pervasive.c
@@ -37,36 +37,28 @@
 #include <asm/reg.h>
 
 #include "pervasive.h"
+#include "cbe_regs.h"
 
 static DEFINE_SPINLOCK(cbe_pervasive_lock);
-struct cbe_pervasive {
-	struct pmd_regs __iomem *regs;
-	unsigned int thread;
-};
-
-/* can't use per_cpu from setup_arch */
-static struct cbe_pervasive cbe_pervasive[NR_CPUS];
 
 static void __init cbe_enable_pause_zero(void)
 {
 	unsigned long thread_switch_control;
 	unsigned long temp_register;
-	struct cbe_pervasive *p;
-	int thread;
+	struct cbe_pmd_regs __iomem *pregs;
 
 	spin_lock_irq(&cbe_pervasive_lock);
-	p = &cbe_pervasive[smp_processor_id()];
-
-	if (!cbe_pervasive->regs)
+	pregs = cbe_get_cpu_pmd_regs(smp_processor_id());
+	if (pregs == NULL)
 		goto out;
 
 	pr_debug("Power Management: CPU %d\n", smp_processor_id());
 
 	 /* Enable Pause(0) control bit */
-	temp_register = in_be64(&p->regs->pm_control);
+	temp_register = in_be64(&pregs->pm_control);
 
-	out_be64(&p->regs->pm_control,
-		 temp_register|PMD_PAUSE_ZERO_CONTROL);
+	out_be64(&pregs->pm_control,
+		 temp_register | CBE_PMD_PAUSE_ZERO_CONTROL);
 
 	/* Enable DEC and EE interrupt request */
 	thread_switch_control  = mfspr(SPRN_TSC_CELL);
@@ -75,25 +67,16 @@ static void __init cbe_enable_pause_zero
 	switch ((mfspr(SPRN_CTRLF) & CTRL_CT)) {
 	case CTRL_CT0:
 		thread_switch_control |= TSC_CELL_DEC_ENABLE_0;
-		thread = 0;
 		break;
 	case CTRL_CT1:
 		thread_switch_control |= TSC_CELL_DEC_ENABLE_1;
-		thread = 1;
 		break;
 	default:
 		printk(KERN_WARNING "%s: unknown configuration\n",
 			__FUNCTION__);
-		thread = -1;
 		break;
 	}
 
-	if (p->thread != thread)
-		printk(KERN_WARNING "%s: device tree inconsistant, "
-				     "cpu %i: %d/%d\n", __FUNCTION__,
-				     smp_processor_id(),
-				     p->thread, thread);
-
 	mtspr(SPRN_TSC_CELL, thread_switch_control);
 
 out:
@@ -104,6 +87,11 @@ static void cbe_idle(void)
 {
 	unsigned long ctrl;
 
+	/* Why do we do that on every idle ? Couldn't that be done once for
+	 * all or do we lose the state some way ? Also, the pm_control
+	 * register setting, that can't be set once at boot ? We really want
+	 * to move that away in order to implement a simple powersave
+	 */
 	cbe_enable_pause_zero();
 
 	while (1) {
@@ -152,8 +140,15 @@ static int cbe_system_reset_exception(st
 		timer_interrupt(regs);
 		break;
 	case SRR1_WAKEMT:
-		/* no action required */
 		break;
+#ifdef CONFIG_CBE_RAS
+	case SRR1_WAKESYSERR:
+		cbe_system_error_exception(regs);
+		break;
+	case SRR1_WAKETHERM:
+		cbe_thermal_exception(regs);
+		break;
+#endif /* CONFIG_CBE_RAS */
 	default:
 		/* do system reset */
 		return 0;
@@ -162,68 +157,11 @@ static int cbe_system_reset_exception(st
 	return 1;
 }
 
-static int __init cbe_find_pmd_mmio(int cpu, struct cbe_pervasive *p)
+void __init cbe_pervasive_init(void)
 {
-	struct device_node *node;
-	unsigned int *int_servers;
-	char *addr;
-	unsigned long real_address;
-	unsigned int size;
-
-	struct pmd_regs __iomem *pmd_mmio_area;
-	int hardid, thread;
-	int proplen;
-
-	pmd_mmio_area = NULL;
-	hardid = get_hard_smp_processor_id(cpu);
-	for (node = NULL; (node = of_find_node_by_type(node, "cpu"));) {
-		int_servers = (void *) get_property(node,
-				"ibm,ppc-interrupt-server#s", &proplen);
-		if (!int_servers) {
-			printk(KERN_WARNING "%s misses "
-				"ibm,ppc-interrupt-server#s property",
-				node->full_name);
-			continue;
-		}
-		for (thread = 0; thread < proplen / sizeof (int); thread++) {
-			if (hardid == int_servers[thread]) {
-				addr = get_property(node, "pervasive", NULL);
-				goto found;
-			}
-		}
-	}
-
-	printk(KERN_WARNING "%s: CPU %d not found\n", __FUNCTION__, cpu);
-	return -EINVAL;
-
-found:
-	real_address = *(unsigned long*) addr;
-	addr += sizeof (unsigned long);
-	size = *(unsigned int*) addr;
-
-	pr_debug("pervasive area for CPU %d at %lx, size %x\n",
-			cpu, real_address, size);
-	p->regs = ioremap(real_address, size);
-	p->thread = thread;
-	return 0;
-}
-
-void __init cell_pervasive_init(void)
-{
-	struct cbe_pervasive *p;
-	int cpu;
-	int ret;
-
 	if (!cpu_has_feature(CPU_FTR_PAUSE_ZERO))
 		return;
 
-	for_each_possible_cpu(cpu) {
-		p = &cbe_pervasive[cpu];
-		ret = cbe_find_pmd_mmio(cpu, p);
-		if (ret)
-			return;
-	}
-
 	ppc_md.idle_loop = cbe_idle;
 	ppc_md.system_reset_exception = cbe_system_reset_exception;
 }
Index: powerpc.git/arch/powerpc/platforms/cell/ras.c
===================================================================
--- /dev/null
+++ powerpc.git/arch/powerpc/platforms/cell/ras.c
@@ -0,0 +1,112 @@
+#define DEBUG
+
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/smp.h>
+
+#include <asm/reg.h>
+#include <asm/io.h>
+#include <asm/prom.h>
+#include <asm/machdep.h>
+
+#include "ras.h"
+#include "cbe_regs.h"
+
+
+static void dump_fir(int cpu)
+{
+	struct cbe_pmd_regs __iomem *pregs = cbe_get_cpu_pmd_regs(cpu);
+	struct cbe_iic_regs __iomem *iregs = cbe_get_cpu_iic_regs(cpu);
+
+	if (pregs == NULL)
+		return;
+
+	/* Todo: do some nicer parsing of bits and based on them go down
+	 * to other sub-units FIRs and not only IIC
+	 */
+	printk(KERN_ERR "Global Checkstop FIR    : 0x%016lx\n",
+	       in_be64(&pregs->checkstop_fir));
+	printk(KERN_ERR "Global Recoverable FIR  : 0x%016lx\n",
+	       in_be64(&pregs->checkstop_fir));
+	printk(KERN_ERR "Global MachineCheck FIR : 0x%016lx\n",
+	       in_be64(&pregs->spec_att_mchk_fir));
+
+	if (iregs == NULL)
+		return;
+	printk(KERN_ERR "IOC FIR                 : 0x%016lx\n",
+	       in_be64(&iregs->ioc_fir));
+
+}
+
+void cbe_system_error_exception(struct pt_regs *regs)
+{
+	int cpu = smp_processor_id();
+
+	printk(KERN_ERR "System Error Interrupt on CPU %d !\n", cpu);
+	dump_fir(cpu);
+	dump_stack();
+}
+
+void cbe_maintenance_exception(struct pt_regs *regs)
+{
+	int cpu = smp_processor_id();
+
+	/*
+	 * Nothing implemented for the maintenance interrupt at this point
+	 */
+
+	printk(KERN_ERR "Unhandled Maintenance interrupt on CPU %d !\n", cpu);
+	dump_stack();
+}
+
+void cbe_thermal_exception(struct pt_regs *regs)
+{
+	int cpu = smp_processor_id();
+
+	/*
+	 * Nothing implemented for the thermal interrupt at this point
+	 */
+
+	printk(KERN_ERR "Unhandled Thermal interrupt on CPU %d !\n", cpu);
+	dump_stack();
+}
+
+static int cbe_machine_check_handler(struct pt_regs *regs)
+{
+	int cpu = smp_processor_id();
+
+	printk(KERN_ERR "Machine Check Interrupt on CPU %d !\n", cpu);
+	dump_fir(cpu);
+
+	/* No recovery from this code now, lets continue */
+	return 0;
+}
+
+void __init cbe_ras_init(void)
+{
+	unsigned long hid0;
+
+	/*
+	 * Enable System Error & thermal interrupts and wakeup conditions
+	 */
+
+	hid0 = mfspr(SPRN_HID0);
+	hid0 |= HID0_CBE_THERM_INT_EN | HID0_CBE_THERM_WAKEUP |
+		HID0_CBE_SYSERR_INT_EN | HID0_CBE_SYSERR_WAKEUP;
+	mtspr(SPRN_HID0, hid0);
+	mb();
+
+	/*
+	 * Install machine check handler. Leave setting of precise mode to
+	 * what the firmware did for now
+	 */
+	ppc_md.machine_check_exception = cbe_machine_check_handler;
+	mb();
+
+	/*
+	 * For now, we assume that IOC_FIR is already set to forward some
+	 * error conditions to the System Error handler. If that is not true
+	 * then it will have to be fixed up here.
+	 */
+}
Index: powerpc.git/arch/powerpc/platforms/cell/ras.h
===================================================================
--- /dev/null
+++ powerpc.git/arch/powerpc/platforms/cell/ras.h
@@ -0,0 +1,9 @@
+#ifndef RAS_H
+#define RAS_H
+
+extern void cbe_system_error_exception(struct pt_regs *regs);
+extern void cbe_maintenance_exception(struct pt_regs *regs);
+extern void cbe_thermal_exception(struct pt_regs *regs);
+extern void cbe_ras_init(void);
+
+#endif /* RAS_H */
Index: powerpc.git/arch/powerpc/platforms/cell/setup.c
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/cell/setup.c
+++ powerpc.git/arch/powerpc/platforms/cell/setup.c
@@ -52,7 +52,9 @@
 
 #include "interrupt.h"
 #include "iommu.h"
+#include "cbe_regs.h"
 #include "pervasive.h"
+#include "ras.h"
 
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
@@ -82,6 +84,12 @@ static void __init cell_setup_arch(void)
 	ppc_md.init_IRQ       = iic_init_IRQ;
 	ppc_md.get_irq        = iic_get_irq;
 
+	cbe_regs_init();
+
+#ifdef CONFIG_CBE_RAS
+	cbe_ras_init();
+#endif
+
 #ifdef CONFIG_SMP
 	smp_init_cell();
 #endif
@@ -98,7 +106,7 @@ static void __init cell_setup_arch(void)
 	init_pci_config_tokens();
 	find_and_init_phbs();
 	spider_init_IRQ();
-	cell_pervasive_init();
+	cbe_pervasive_init();
 #ifdef CONFIG_DUMMY_CONSOLE
 	conswitchp = &dummy_con;
 #endif
Index: powerpc.git/include/asm-powerpc/reg.h
===================================================================
--- powerpc.git.orig/include/asm-powerpc/reg.h
+++ powerpc.git/include/asm-powerpc/reg.h
@@ -386,6 +386,8 @@
 #define   SRR1_WAKEMT		0x00280000 /* mtctrl */
 #define   SRR1_WAKEDEC		0x00180000 /* Decrementer interrupt */
 #define   SRR1_WAKETHERM	0x00100000 /* Thermal management interrupt */
+#define SPRN_HSRR0	0x13A	/* Save/Restore Register 0 */
+#define SPRN_HSRR1	0x13B	/* Save/Restore Register 1 */
 
 #ifndef SPRN_SVR
 #define SPRN_SVR	0x11E	/* System Version Register */
Index: powerpc.git/arch/powerpc/platforms/cell/pervasive.h
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/cell/pervasive.h
+++ powerpc.git/arch/powerpc/platforms/cell/pervasive.h
@@ -25,38 +25,9 @@
 #ifndef PERVASIVE_H
 #define PERVASIVE_H
 
-struct pmd_regs {
-	u8 pad_0x0000_0x0800[0x0800 - 0x0000];			/* 0x0000 */
-
-	/* Thermal Sensor Registers */
-	u64  ts_ctsr1;						/* 0x0800 */
-	u64  ts_ctsr2;						/* 0x0808 */
-	u64  ts_mtsr1;						/* 0x0810 */
-	u64  ts_mtsr2;						/* 0x0818 */
-	u64  ts_itr1;						/* 0x0820 */
-	u64  ts_itr2;						/* 0x0828 */
-	u64  ts_gitr;						/* 0x0830 */
-	u64  ts_isr;						/* 0x0838 */
-	u64  ts_imr;						/* 0x0840 */
-	u64  tm_cr1;						/* 0x0848 */
-	u64  tm_cr2;						/* 0x0850 */
-	u64  tm_simr;						/* 0x0858 */
-	u64  tm_tpr;						/* 0x0860 */
-	u64  tm_str1;						/* 0x0868 */
-	u64  tm_str2;						/* 0x0870 */
-	u64  tm_tsr;						/* 0x0878 */
-
-	/* Power Management */
-	u64  pm_control;					/* 0x0880 */
-#define PMD_PAUSE_ZERO_CONTROL		0x10000
-	u64  pm_status;						/* 0x0888 */
-
-	/* Time Base Register */
-	u64  tbr;						/* 0x0890 */
-
-	u8   pad_0x0898_0x1000 [0x1000 - 0x0898];		/* 0x0898 */
-};
-
-void __init cell_pervasive_init(void);
+extern void cbe_pervasive_init(void);
+extern void cbe_system_error_exception(struct pt_regs *regs);
+extern void cbe_maintenance_exception(struct pt_regs *regs);
+extern void cbe_thermal_exception(struct pt_regs *regs);
 
 #endif
Index: powerpc.git/arch/powerpc/platforms/cell/cbe_regs.h
===================================================================
--- /dev/null
+++ powerpc.git/arch/powerpc/platforms/cell/cbe_regs.h
@@ -0,0 +1,129 @@
+/*
+ * cbe_regs.h
+ *
+ * This file is intended to hold the various register definitions for CBE
+ * on-chip system devices (memory controller, IO controller, etc...)
+ *
+ * (c) 2006 Benjamin Herrenschmidt <benh@kernel.crashing.org>, IBM Corp.
+ */
+
+#ifndef CBE_REGS_H
+#define CBE_REGS_H
+
+/*
+ *
+ * Some HID register definitions
+ *
+ */
+
+/* CBE specific HID0 bits */
+#define HID0_CBE_THERM_WAKEUP	0x0000020000000000ul
+#define HID0_CBE_SYSERR_WAKEUP	0x0000008000000000ul
+#define HID0_CBE_THERM_INT_EN	0x0000000400000000ul
+#define HID0_CBE_SYSERR_INT_EN	0x0000000200000000ul
+
+
+/*
+ *
+ * Pervasive unit register definitions
+ *
+ */
+
+struct cbe_pmd_regs {
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
+#define CBE_PMD_PAUSE_ZERO_CONTROL		0x10000
+	u64  pm_status;						/* 0x0888 */
+
+	/* Time Base Register */
+	u64  tbr;						/* 0x0890 */
+
+	u8   pad_0x0898_0x0c00 [0x0c00 - 0x0898];		/* 0x0898 */
+
+	/* Fault Isolation Registers */
+	u64  checkstop_fir;					/* 0x0c00 */
+	u64  recoverable_fir;
+	u64  spec_att_mchk_fir;
+	u64  fir_mode_reg;
+	u64  fir_enable_mask;
+
+	u8   pad_0x0c28_0x1000 [0x1000 - 0x0c28];		/* 0x0c28 */
+};
+
+extern struct cbe_pmd_regs __iomem *cbe_get_pmd_regs(struct device_node *np);
+extern struct cbe_pmd_regs __iomem *cbe_get_cpu_pmd_regs(int cpu);
+
+/*
+ *
+ * IIC unit register definitions
+ *
+ */
+
+struct cbe_iic_pending_bits {
+	u32 data;
+	u8 flags;
+	u8 class;
+	u8 source;
+	u8 prio;
+};
+
+#define CBE_IIC_IRQ_VALID	0x80
+#define CBE_IIC_IRQ_IPI		0x40
+
+struct cbe_iic_thread_regs {
+	struct cbe_iic_pending_bits pending;
+	struct cbe_iic_pending_bits pending_destr;
+	u64 generate;
+	u64 prio;
+};
+
+struct cbe_iic_regs {
+	u8	pad_0x0000_0x0400[0x0400 - 0x0000];		/* 0x0000 */
+
+	/* IIC interrupt registers */
+	struct	cbe_iic_thread_regs thread[2];			/* 0x0400 */
+	u64     iic_ir;						/* 0x0440 */
+	u64     iic_is;						/* 0x0448 */
+
+	u8	pad_0x0450_0x0500[0x0500 - 0x0450];		/* 0x0450 */
+
+	/* IOC FIR */
+	u64	ioc_fir_reset;					/* 0x0500 */
+	u64	ioc_fir_set;
+	u64	ioc_checkstop_enable;
+	u64	ioc_fir_error_mask;
+	u64	ioc_syserr_enable;
+	u64	ioc_fir;
+
+	u8	pad_0x0530_0x1000[0x1000 - 0x0530];		/* 0x0530 */
+};
+
+extern struct cbe_iic_regs __iomem *cbe_get_iic_regs(struct device_node *np);
+extern struct cbe_iic_regs __iomem *cbe_get_cpu_iic_regs(int cpu);
+
+
+/* Init this module early */
+extern void cbe_regs_init(void);
+
+
+#endif /* CBE_REGS_H */
Index: powerpc.git/arch/powerpc/platforms/cell/interrupt.c
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/cell/interrupt.c
+++ powerpc.git/arch/powerpc/platforms/cell/interrupt.c
@@ -33,29 +33,10 @@
 #include <asm/ptrace.h>
 
 #include "interrupt.h"
-
-struct iic_pending_bits {
-	u32 data;
-	u8 flags;
-	u8 class;
-	u8 source;
-	u8 prio;
-};
-
-enum iic_pending_flags {
-	IIC_VALID = 0x80,
-	IIC_IPI   = 0x40,
-};
-
-struct iic_regs {
-	struct iic_pending_bits pending;
-	struct iic_pending_bits pending_destr;
-	u64 generate;
-	u64 prio;
-};
+#include "cbe_regs.h"
 
 struct iic {
-	struct iic_regs __iomem *regs;
+	struct cbe_iic_thread_regs __iomem *regs;
 	u8 target_id;
 };
 
@@ -115,7 +96,7 @@ static struct hw_interrupt_type iic_pic 
 	.end = iic_end,
 };
 
-static int iic_external_get_irq(struct iic_pending_bits pending)
+static int iic_external_get_irq(struct cbe_iic_pending_bits pending)
 {
 	int irq;
 	unsigned char node, unit;
@@ -168,15 +149,15 @@ int iic_get_irq(struct pt_regs *regs)
 {
 	struct iic *iic;
 	int irq;
-	struct iic_pending_bits pending;
+	struct cbe_iic_pending_bits pending;
 
 	iic = &__get_cpu_var(iic);
 	*(unsigned long *) &pending = 
 		in_be64((unsigned long __iomem *) &iic->regs->pending_destr);
 
 	irq = -1;
-	if (pending.flags & IIC_VALID) {
-		if (pending.flags & IIC_IPI) {
+	if (pending.flags & CBE_IIC_IRQ_VALID) {
+		if (pending.flags & CBE_IIC_IRQ_IPI) {
 			irq = IIC_IPI_OFFSET + (pending.prio >> 4);
 /*
 			if (irq > 0x80)
@@ -226,7 +207,7 @@ static int setup_iic_hardcoded(void)
 			regs += 0x20;
 
 		printk(KERN_INFO "IIC for CPU %d at %lx\n", cpu, regs);
-		iic->regs = ioremap(regs, sizeof(struct iic_regs));
+		iic->regs = ioremap(regs, sizeof(struct cbe_iic_thread_regs));
 		iic->target_id = (nodeid << 4) + ((cpu & 1) ? 0xf : 0xe);
 	}
 
@@ -267,12 +248,12 @@ static int setup_iic(void)
 		}
 
  		iic = &per_cpu(iic, np[0]);
- 		iic->regs = ioremap(regs[0], sizeof(struct iic_regs));
+ 		iic->regs = ioremap(regs[0], sizeof(struct cbe_iic_thread_regs));
 		iic->target_id = ((np[0] & 2) << 3) + ((np[0] & 1) ? 0xf : 0xe);
  		printk("IIC for CPU %d at %lx mapped to %p\n", np[0], regs[0], iic->regs);
 
  		iic = &per_cpu(iic, np[1]);
- 		iic->regs = ioremap(regs[2], sizeof(struct iic_regs));
+ 		iic->regs = ioremap(regs[2], sizeof(struct cbe_iic_thread_regs));
 		iic->target_id = ((np[1] & 2) << 3) + ((np[1] & 1) ? 0xf : 0xe);
  		printk("IIC for CPU %d at %lx mapped to %p\n", np[1], regs[2], iic->regs);
 
Index: powerpc.git/arch/powerpc/kernel/prom.c
===================================================================
--- powerpc.git.orig/arch/powerpc/kernel/prom.c
+++ powerpc.git/arch/powerpc/kernel/prom.c
@@ -2096,3 +2096,46 @@ int prom_update_property(struct device_n
 	return 0;
 }
 
+
+/* Find the device node for a given logical cpu number, also returns the cpu
+ * local thread number (index in ibm,interrupt-server#s) if relevant and
+ * asked for (non NULL)
+ */
+struct device_node *of_get_cpu_node(int cpu, unsigned int *thread)
+{
+	int hardid;
+	struct device_node *np;
+
+	hardid = get_hard_smp_processor_id(cpu);
+
+	for_each_node_by_type(np, "cpu") {
+		u32 *intserv;
+		unsigned int plen, t;
+
+		/* Check for ibm,ppc-interrupt-server#s. If it doesn't exist
+		 * fallback to "reg" property and assume no threads
+		 */
+		intserv = (u32 *)get_property(np, "ibm,ppc-interrupt-server#s",
+					      &plen);
+		if (intserv == NULL) {
+			u32 *reg = (u32 *)get_property(np, "reg", NULL);
+			if (reg == NULL)
+				continue;
+			if (*reg == hardid) {
+				if (thread)
+					*thread = 0;
+				return np;
+			}
+		} else {
+			plen /= sizeof(u32);
+			for (t = 0; t < plen; t++) {
+				if (hardid == intserv[t]) {
+					if (thread)
+						*thread = t;
+					return np;
+				}
+			}
+		}
+	}
+	return NULL;
+}
Index: powerpc.git/arch/powerpc/platforms/cell/cbe_regs.c
===================================================================
--- /dev/null
+++ powerpc.git/arch/powerpc/platforms/cell/cbe_regs.c
@@ -0,0 +1,128 @@
+/*
+ * cbe_regs.c
+ *
+ * Accessor routines for the various MMIO register blocks of the CBE
+ *
+ * (c) 2006 Benjamin Herrenschmidt <benh@kernel.crashing.org>, IBM Corp.
+ */
+
+
+#include <linux/config.h>
+#include <linux/percpu.h>
+#include <linux/types.h>
+
+#include <asm/io.h>
+#include <asm/pgtable.h>
+#include <asm/prom.h>
+#include <asm/ptrace.h>
+
+#include "cbe_regs.h"
+
+#define MAX_CBE		2
+
+/*
+ * Current implementation uses "cpu" nodes. We build our own mapping
+ * array of cpu numbers to cpu nodes locally for now to allow interrupt
+ * time code to have a fast path rather than call of_get_cpu_node(). If
+ * we implement cpu hotplug, we'll have to install an appropriate norifier
+ * in order to release references to the cpu going away
+ */
+static struct cbe_regs_map
+{
+	struct device_node *cpu_node;
+	struct cbe_pmd_regs __iomem *pmd_regs;
+	struct cbe_iic_regs __iomem *iic_regs;
+} cbe_regs_maps[MAX_CBE];
+static int cbe_regs_map_count;
+
+static struct cbe_thread_map
+{
+	struct device_node *cpu_node;
+	struct cbe_regs_map *regs;
+} cbe_thread_map[NR_CPUS];
+
+static struct cbe_regs_map *cbe_find_map(struct device_node *np)
+{
+	int i;
+
+	for (i = 0; i < cbe_regs_map_count; i++)
+		if (cbe_regs_maps[i].cpu_node == np)
+			return &cbe_regs_maps[i];
+	return NULL;
+}
+
+struct cbe_pmd_regs __iomem *cbe_get_pmd_regs(struct device_node *np)
+{
+	struct cbe_regs_map *map = cbe_find_map(np);
+	if (map == NULL)
+		return NULL;
+	return map->pmd_regs;
+}
+
+struct cbe_pmd_regs __iomem *cbe_get_cpu_pmd_regs(int cpu)
+{
+	struct cbe_regs_map *map = cbe_thread_map[cpu].regs;
+	if (map == NULL)
+		return NULL;
+	return map->pmd_regs;
+}
+
+
+struct cbe_iic_regs __iomem *cbe_get_iic_regs(struct device_node *np)
+{
+	struct cbe_regs_map *map = cbe_find_map(np);
+	if (map == NULL)
+		return NULL;
+	return map->iic_regs;
+}
+struct cbe_iic_regs __iomem *cbe_get_cpu_iic_regs(int cpu)
+{
+	struct cbe_regs_map *map = cbe_thread_map[cpu].regs;
+	if (map == NULL)
+		return NULL;
+	return map->iic_regs;
+}
+
+void __init cbe_regs_init(void)
+{
+	int i;
+	struct device_node *cpu;
+
+	/* Build local fast map of CPUs */
+	for_each_cpu(i)
+		cbe_thread_map[i].cpu_node = of_get_cpu_node(i, NULL);
+
+	/* Find maps for each device tree CPU */
+	for_each_node_by_type(cpu, "cpu") {
+		struct cbe_regs_map *map = &cbe_regs_maps[cbe_regs_map_count++];
+
+		/* That hack must die die die ! */
+		struct address_prop {
+			unsigned long address;
+			unsigned int len;
+		} __attribute__((packed)) *prop;
+
+
+		if (cbe_regs_map_count > MAX_CBE) {
+			printk(KERN_ERR "cbe_regs: More BE chips than supported"
+			       "!\n");
+			cbe_regs_map_count--;
+			return;
+		}
+		map->cpu_node = cpu;
+		for_each_cpu(i)
+			if (cbe_thread_map[i].cpu_node == cpu)
+				cbe_thread_map[i].regs = map;
+
+		prop = (struct address_prop *)get_property(cpu, "pervasive",
+							   NULL);
+		if (prop != NULL)
+			map->pmd_regs = ioremap(prop->address, prop->len);
+
+		prop = (struct address_prop *)get_property(cpu, "iic",
+							   NULL);
+		if (prop != NULL)
+			map->iic_regs = ioremap(prop->address, prop->len);
+	}
+}
+
Index: powerpc.git/include/asm-powerpc/prom.h
===================================================================
--- powerpc.git.orig/include/asm-powerpc/prom.h
+++ powerpc.git/include/asm-powerpc/prom.h
@@ -238,5 +238,8 @@ void of_parse_dma_window(struct device_n
 
 extern void kdump_move_device_tree(void);
 
+/* CPU OF node matching */
+struct device_node *of_get_cpu_node(int cpu, unsigned int *thread);
+
 #endif /* __KERNEL__ */
 #endif /* _POWERPC_PROM_H */
Index: powerpc.git/arch/powerpc/configs/cell_defconfig
===================================================================
--- powerpc.git.orig/arch/powerpc/configs/cell_defconfig
+++ powerpc.git/arch/powerpc/configs/cell_defconfig
@@ -133,6 +133,7 @@ CONFIG_CELL_IIC=y
 #
 CONFIG_SPU_FS=m
 CONFIG_SPUFS_MMAP=y
+CONFIG_CBE_RAS=y
 
 #
 # Kernel options

--

