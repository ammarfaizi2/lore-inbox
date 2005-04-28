Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261925AbVD1IgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbVD1IgN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 04:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261866AbVD1IgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 04:36:12 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:38395 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S261962AbVD1INs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 04:13:48 -0400
Message-Id: <200504280813.j3S8DNLb019256@post.webmailer.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc64-dev@ozlabs.org
Subject: [PATCH 2/4] ppc64: Add driver for BPA interrupt controllers
Date: Thu, 28 Apr 2005 09:58:18 +0200
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

Add support for the integrated interrupt controller on BPA
CPUs. There is one of those for each SMT thread.

The mapping of interrupt numbers to HW interrupt sources
is described in arch/ppc64/kernel/bpa_iic.h.

This version hardcodes the 'Spider' chip as the secondary
interrupt controller. That is not really generic for the
architecture, but at the moment it is the only secondary
PIC that exists.

A little more work will be needed on this as soon as
we have boards with multiple external interrupt controllers.

Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

Index: linus-2.5/arch/ppc64/Kconfig
===================================================================
--- linus-2.5.orig/arch/ppc64/Kconfig	2005-04-22 06:59:52.000000000 +0200
+++ linus-2.5/arch/ppc64/Kconfig	2005-04-22 06:59:58.000000000 +0200
@@ -106,6 +106,21 @@
 	bool
 	default y
 
+config XICS
+	depends on PPC_PSERIES
+	bool
+	default y
+
+config MPIC
+	depends on PPC_PSERIES || PPC_PMAC || PPC_MAPLE
+	bool
+	default y
+
+config BPA_IIC
+	depends on PPC_BPA
+	bool
+	default y
+
 # VMX is pSeries only for now until somebody writes the iSeries
 # exception vectors for it
 config ALTIVEC
Index: linus-2.5/arch/ppc64/kernel/Makefile
===================================================================
--- linus-2.5.orig/arch/ppc64/kernel/Makefile	2005-04-22 06:59:52.000000000 +0200
+++ linus-2.5/arch/ppc64/kernel/Makefile	2005-04-22 07:01:07.000000000 +0200
@@ -28,13 +28,13 @@
 			     mf.o HvLpEvent.o iSeries_proc.o iSeries_htab.o \
 			     iSeries_iommu.o
 
-obj-$(CONFIG_PPC_MULTIPLATFORM) += nvram.o i8259.o prom_init.o prom.o mpic.o
+obj-$(CONFIG_PPC_MULTIPLATFORM) += nvram.o i8259.o prom_init.o prom.o
 
 obj-$(CONFIG_PPC_PSERIES) += pSeries_pci.o pSeries_lpar.o pSeries_hvCall.o \
 			     pSeries_nvram.o rtasd.o ras.o pSeries_reconfig.o \
-			     xics.o pSeries_setup.o pSeries_iommu.o
+			     pSeries_setup.o pSeries_iommu.o
 
-obj-$(CONFIG_PPC_BPA) += bpa_setup.o bpa_nvram.o
+obj-$(CONFIG_PPC_BPA) += bpa_setup.o bpa_nvram.o bpa_iic.o spider-pic.o
 
 obj-$(CONFIG_EEH)		+= eeh.o
 obj-$(CONFIG_PROC_FS)		+= proc_ppc64.o
@@ -50,6 +50,8 @@
 obj-$(CONFIG_BOOTX_TEXT)	+= btext.o
 obj-$(CONFIG_HVCS)		+= hvcserver.o
 obj-$(CONFIG_IBMVIO)		+= vio.o
+obj-$(CONFIG_XICS)		+= xics.o
+obj-$(CONFIG_MPIC)		+= mpic.o
 
 obj-$(CONFIG_PPC_PMAC)		+= pmac_setup.o pmac_feature.o pmac_pci.o \
 				   pmac_time.o pmac_nvram.o pmac_low_i2c.o
Index: linus-2.5/arch/ppc64/kernel/bpa_iic.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linus-2.5/arch/ppc64/kernel/bpa_iic.c	2005-04-22 06:59:58.000000000 +0200
@@ -0,0 +1,270 @@
+/*
+ * BPA Internal Interrupt Controller
+ *
+ * (C) Copyright IBM Deutschland Entwicklung GmbH 2005
+ *
+ * Author: Arnd Bergmann <arndb@de.ibm.com>
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
+#include <asm/pgtable.h>
+#include <asm/prom.h>
+#include <asm/ptrace.h>
+
+#include "bpa_iic.h"
+
+struct iic_pending_bits {
+	u32 data;
+	u8 flags;
+	u8 class;
+	u8 source;
+	u8 prio;
+};
+
+enum iic_pending_flags {
+	IIC_VALID = 0x80,
+	IIC_IPI   = 0x40,
+};
+
+struct iic_regs {
+	struct iic_pending_bits pending;
+	struct iic_pending_bits pending_destr;
+	u64 generate;
+	u64 prio;
+};
+
+struct iic {
+	struct iic_regs __iomem *regs;
+};
+
+static DEFINE_PER_CPU(struct iic, iic);
+
+void iic_local_enable(void)
+{
+	out_be64(&__get_cpu_var(iic).regs->prio, 0xff);
+}
+
+void iic_local_disable(void)
+{
+	out_be64(&__get_cpu_var(iic).regs->prio, 0x0);
+}
+
+static unsigned int iic_startup(unsigned int irq)
+{
+	return 0;
+}
+
+static void iic_enable(unsigned int irq)
+{
+	iic_local_enable();
+}
+
+static void iic_disable(unsigned int irq)
+{
+}
+
+static void iic_end(unsigned int irq)
+{
+	iic_local_enable();
+}
+
+static struct hw_interrupt_type iic_pic = {
+	.typename = " BPA-IIC  ",
+	.startup = iic_startup,
+	.enable = iic_enable,
+	.disable = iic_disable,
+	.end = iic_end,
+};
+
+static int iic_external_get_irq(struct iic_pending_bits pending)
+{
+	int irq;
+	unsigned char node, unit;
+
+	node = pending.source >> 4;
+	unit = pending.source & 0xf;
+	irq = -1;
+
+	/*
+	 * This mapping is specific to the Broadband
+	 * Engine. We might need to get the numbers
+	 * from the device tree to support future CPUs.
+	 */
+	switch (unit) {
+	case 0x00:
+	case 0x0b:
+		/*
+		 * One of these units can be connected
+		 * to an external interrupt controller.
+		 */
+		if (pending.prio > 0x3f ||
+		    pending.class != 2)
+			break;
+		irq = IIC_EXT_OFFSET
+			+ spider_get_irq(pending.prio + node * IIC_NODE_STRIDE)
+			+ node * IIC_NODE_STRIDE;
+		break;
+	case 0x01 ... 0x04:
+	case 0x07 ... 0x0a:
+		/*
+		 * These units are connected to the SPEs
+		 */
+		if (pending.class > 2)
+			break;
+		irq = IIC_SPE_OFFSET
+			+ pending.class * IIC_CLASS_STRIDE
+			+ node * IIC_NODE_STRIDE
+			+ unit;
+		break;
+	}
+	if (irq == -1)
+		printk(KERN_WARNING "Unexpected interrupt class %02x, "
+			"source %02x, prio %02x, cpu %02x\n", pending.class,
+			pending.source, pending.prio, smp_processor_id());
+	return irq;
+}
+
+/* Get an IRQ number from the pending state register of the IIC */
+int iic_get_irq(struct pt_regs *regs)
+{
+	struct iic *iic;
+	int irq;
+	struct iic_pending_bits pending;
+
+	iic = &__get_cpu_var(iic);
+	*(unsigned long *) &pending = 
+		in_be64((unsigned long __iomem *) &iic->regs->pending_destr);
+
+	irq = -1;
+	if (pending.flags & IIC_VALID) {
+		if (pending.flags & IIC_IPI) {
+			irq = IIC_IPI_OFFSET + (pending.prio >> 4);
+/*
+			if (irq > 0x80)
+				printk(KERN_WARNING "Unexpected IPI prio %02x"
+					"on CPU %02x\n", pending.prio,
+							smp_processor_id());
+*/
+		} else {
+			irq = iic_external_get_irq(pending);
+		}
+	}
+	return irq;
+}
+
+static struct iic_regs __iomem *find_iic(int cpu)
+{
+	struct device_node *np;
+	int nodeid = cpu / 2;
+	unsigned long regs;
+	struct iic_regs __iomem *iic_regs;
+
+	for (np = of_find_node_by_type(NULL, "cpu");
+	     np;
+	     np = of_find_node_by_type(np, "cpu")) {
+		if (nodeid == *(int *)get_property(np, "node-id", NULL))
+			break;
+	}
+
+	if (!np) {
+		printk(KERN_WARNING "IIC: CPU %d not found\n", cpu);
+		iic_regs = NULL;
+	} else {
+		regs = *(long *)get_property(np, "iic", NULL);
+
+		/* hack until we have decided on the devtree info */
+		regs += 0x400;
+		if (cpu & 1)
+			regs += 0x20;
+
+		printk(KERN_DEBUG "IIC for CPU %d at %lx\n", cpu, regs);
+		iic_regs = __ioremap(regs, sizeof(struct iic_regs),
+						 _PAGE_NO_CACHE);
+	}
+	return iic_regs;
+}
+
+#ifdef CONFIG_SMP
+void iic_setup_cpu(void)
+{
+	out_be64(&__get_cpu_var(iic).regs->prio, 0xff);
+}
+
+void iic_cause_IPI(int cpu, int mesg)
+{
+	out_be64(&per_cpu(iic, cpu).regs->generate, mesg);
+}
+
+static irqreturn_t iic_ipi_action(int irq, void *dev_id, struct pt_regs *regs)
+{
+
+	smp_message_recv(irq - IIC_IPI_OFFSET, regs);
+	return IRQ_HANDLED;
+}
+
+static void iic_request_ipi(int irq, const char *name)
+{
+	/* IPIs are marked SA_INTERRUPT as they must run with irqs
+	 * disabled */
+	get_irq_desc(irq)->handler = &iic_pic;
+	get_irq_desc(irq)->status |= IRQ_PER_CPU;
+	request_irq(irq, iic_ipi_action, SA_INTERRUPT, name, NULL);
+}
+
+void iic_request_IPIs(void)
+{
+	iic_request_ipi(IIC_IPI_OFFSET + PPC_MSG_CALL_FUNCTION, "IPI-call");
+	iic_request_ipi(IIC_IPI_OFFSET + PPC_MSG_RESCHEDULE, "IPI-resched");
+#ifdef CONFIG_DEBUGGER
+	iic_request_ipi(IIC_IPI_OFFSET + PPC_MSG_DEBUGGER_BREAK, "IPI-debug");
+#endif /* CONFIG_DEBUGGER */
+}
+#endif /* CONFIG_SMP */
+
+static void iic_setup_spe_handlers(void)
+{
+	int be, isrc;
+
+	/* Assume two threads per BE are present */
+	for (be=0; be < num_present_cpus() / 2; be++) {
+		for (isrc = 0; isrc < IIC_CLASS_STRIDE * 3; isrc++) {
+			int irq = IIC_NODE_STRIDE * be + IIC_SPE_OFFSET + isrc;
+			get_irq_desc(irq)->handler = &iic_pic;
+		}
+	}
+}
+
+void iic_init_IRQ(void)
+{
+	int cpu, irq_offset;
+	struct iic *iic;
+
+	irq_offset = 0;
+	for_each_cpu(cpu) {
+		iic = &per_cpu(iic, cpu);
+		iic->regs = find_iic(cpu);
+		if (iic->regs)
+			out_be64(&iic->regs->prio, 0xff);
+	}
+	iic_setup_spe_handlers();
+}
Index: linus-2.5/arch/ppc64/kernel/bpa_iic.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linus-2.5/arch/ppc64/kernel/bpa_iic.h	2005-04-22 06:59:58.000000000 +0200
@@ -0,0 +1,62 @@
+#ifndef ASM_BPA_IIC_H
+#define ASM_BPA_IIC_H
+#ifdef __KERNEL__
+/*
+ * Mapping of IIC pending bits into per-node
+ * interrupt numbers.
+ *
+ * IRQ     FF CC SS PP   FF CC SS PP	Description
+ *
+ * 00-3f   80 02 +0 00 - 80 02 +0 3f	South Bridge
+ * 00-3f   80 02 +b 00 - 80 02 +b 3f	South Bridge
+ * 41-4a   80 00 +1 ** - 80 00 +a **	SPU Class 0
+ * 51-5a   80 01 +1 ** - 80 01 +a **	SPU Class 1
+ * 61-6a   80 02 +1 ** - 80 02 +a **	SPU Class 2
+ * 70-7f   C0 ** ** 00 - C0 ** ** 0f	IPI
+ *
+ *    F flags
+ *    C class
+ *    S source
+ *    P Priority
+ *    + node number
+ *    * don't care
+ *
+ * A node consists of a Broadband Engine and an optional
+ * south bridge device providing a maximum of 64 IRQs.
+ * The south bridge may be connected to either IOIF0
+ * or IOIF1.
+ * Each SPE is represented as three IRQ lines, one per
+ * interrupt class.
+ * 16 IRQ numbers are reserved for inter processor
+ * interruptions, although these are only used in the
+ * range of the first node.
+ *
+ * This scheme needs 128 IRQ numbers per BIF node ID,
+ * which means that with the total of 512 lines
+ * available, we can have a maximum of four nodes.
+ */
+
+enum {
+	IIC_EXT_OFFSET   = 0x00, /* Start of south bridge IRQs */
+	IIC_NUM_EXT      = 0x40, /* Number of south bridge IRQs */
+	IIC_SPE_OFFSET   = 0x40, /* Start of SPE interrupts */
+	IIC_CLASS_STRIDE = 0x10, /* SPE IRQs per class    */
+	IIC_IPI_OFFSET   = 0x70, /* Start of IPI IRQs */
+	IIC_NUM_IPIS     = 0x10, /* IRQs reserved for IPI */
+	IIC_NODE_STRIDE  = 0x80, /* Total IRQs per node   */
+};
+
+extern void iic_init_IRQ(void);
+extern int  iic_get_irq(struct pt_regs *regs);
+extern void iic_cause_IPI(int cpu, int mesg);
+extern void iic_request_IPIs(void);
+extern void iic_setup_cpu(void);
+extern void iic_local_enable(void);
+extern void iic_local_disable(void);
+
+
+extern void spider_init_IRQ(void);
+extern int spider_get_irq(unsigned long int_pending);
+
+#endif
+#endif /* ASM_BPA_IIC_H */
Index: linus-2.5/arch/ppc64/kernel/bpa_setup.c
===================================================================
--- linus-2.5.orig/arch/ppc64/kernel/bpa_setup.c	2005-04-22 06:59:52.000000000 +0200
+++ linus-2.5/arch/ppc64/kernel/bpa_setup.c	2005-04-22 06:59:58.000000000 +0200
@@ -45,6 +45,7 @@
 #include <asm/cputable.h>
 
 #include "pci.h"
+#include "bpa_iic.h"
 
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
@@ -143,6 +144,9 @@
 
 static void __init bpa_setup_arch(void)
 {
+	ppc_md.init_IRQ       = iic_init_IRQ;
+	ppc_md.get_irq        = iic_get_irq;
+
 #ifdef CONFIG_SMP
 	smp_init_pSeries();
 #endif
@@ -158,7 +162,7 @@
 	/* Find and initialize PCI host bridges */
 	init_pci_config_tokens();
 	find_and_init_phbs();
-
+	spider_init_IRQ();
 #ifdef CONFIG_DUMMY_CONSOLE
 	conswitchp = &dummy_con;
 #endif
Index: linus-2.5/arch/ppc64/kernel/pSeries_smp.c
===================================================================
--- linus-2.5.orig/arch/ppc64/kernel/pSeries_smp.c	2005-04-22 06:58:22.000000000 +0200
+++ linus-2.5/arch/ppc64/kernel/pSeries_smp.c	2005-04-22 06:59:58.000000000 +0200
@@ -1,5 +1,5 @@
 /*
- * SMP support for pSeries machines.
+ * SMP support for pSeries and BPA machines.
  *
  * Dave Engebretsen, Peter Bergner, and
  * Mike Corrigan {engebret|bergner|mikec}@us.ibm.com
@@ -47,6 +47,7 @@
 #include <asm/pSeries_reconfig.h>
 
 #include "mpic.h"
+#include "bpa_iic.h"
 
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
@@ -286,6 +287,7 @@
 	return 1;
 }
 
+#ifdef CONFIG_XICS
 static inline void smp_xics_do_message(int cpu, int msg)
 {
 	set_bit(msg, &xics_ipi_message[cpu].value);
@@ -334,6 +336,37 @@
 	rtas_set_indicator(GLOBAL_INTERRUPT_QUEUE,
 		(1UL << interrupt_server_size) - 1 - default_distrib_server, 1);
 }
+#endif /* CONFIG_XICS */
+#ifdef CONFIG_BPA_IIC
+static void smp_iic_message_pass(int target, int msg)
+{
+	unsigned int i;
+
+	if (target < NR_CPUS) {
+		iic_cause_IPI(target, msg);
+	} else {
+		for_each_online_cpu(i) {
+			if (target == MSG_ALL_BUT_SELF
+			    && i == smp_processor_id())
+				continue;
+			iic_cause_IPI(i, msg);
+		}
+	}
+}
+
+static int __init smp_iic_probe(void)
+{
+	iic_request_IPIs();
+
+	return cpus_weight(cpu_possible_map);
+}
+
+static void __devinit smp_iic_setup_cpu(int cpu)
+{
+	if (cpu != boot_cpuid)
+		iic_setup_cpu();
+}
+#endif /* CONFIG_BPA_IIC */
 
 static DEFINE_SPINLOCK(timebase_lock);
 static unsigned long timebase = 0;
@@ -388,14 +421,15 @@
 
 	return 1;
 }
-
+#ifdef CONFIG_MPIC
 static struct smp_ops_t pSeries_mpic_smp_ops = {
 	.message_pass	= smp_mpic_message_pass,
 	.probe		= smp_mpic_probe,
 	.kick_cpu	= smp_pSeries_kick_cpu,
 	.setup_cpu	= smp_mpic_setup_cpu,
 };
-
+#endif
+#ifdef CONFIG_XICS
 static struct smp_ops_t pSeries_xics_smp_ops = {
 	.message_pass	= smp_xics_message_pass,
 	.probe		= smp_xics_probe,
@@ -403,6 +437,16 @@
 	.setup_cpu	= smp_xics_setup_cpu,
 	.cpu_bootable	= smp_pSeries_cpu_bootable,
 };
+#endif
+#ifdef CONFIG_BPA_IIC
+static struct smp_ops_t bpa_iic_smp_ops = {
+	.message_pass	= smp_iic_message_pass,
+	.probe		= smp_iic_probe,
+	.kick_cpu	= smp_pSeries_kick_cpu,
+	.setup_cpu	= smp_iic_setup_cpu,
+	.cpu_bootable	= smp_pSeries_cpu_bootable,
+};
+#endif
 
 /* This is called very early */
 void __init smp_init_pSeries(void)
@@ -411,10 +455,25 @@
 
 	DBG(" -> smp_init_pSeries()\n");
 
-	if (ppc64_interrupt_controller == IC_OPEN_PIC)
+	switch (ppc64_interrupt_controller) {
+#ifdef CONFIG_MPIC
+	case IC_OPEN_PIC:
 		smp_ops = &pSeries_mpic_smp_ops;
-	else
+		break;
+#endif
+#ifdef CONFIG_XICS
+	case IC_PPC_XIC:
 		smp_ops = &pSeries_xics_smp_ops;
+		break;
+#endif
+#ifdef CONFIG_BPA_IIC
+	case IC_BPA_IIC:
+		smp_ops = &bpa_iic_smp_ops;
+		break;
+#endif
+	default:
+		panic("Invalid interrupt controller");
+	}
 
 #ifdef CONFIG_HOTPLUG_CPU
 	smp_ops->cpu_disable = pSeries_cpu_disable;
Index: linus-2.5/arch/ppc64/kernel/smp.c
===================================================================
--- linus-2.5.orig/arch/ppc64/kernel/smp.c	2005-04-22 06:58:22.000000000 +0200
+++ linus-2.5/arch/ppc64/kernel/smp.c	2005-04-22 06:59:58.000000000 +0200
@@ -71,7 +71,7 @@
 
 int smt_enabled_at_boot = 1;
 
-#ifdef CONFIG_PPC_MULTIPLATFORM
+#if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_PMAC) || defined(CONFIG_PPC_MAPLE)
 void smp_mpic_message_pass(int target, int msg)
 {
 	/* make sure we're sending something that translates to an IPI */
Index: linus-2.5/arch/ppc64/kernel/spider-pic.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linus-2.5/arch/ppc64/kernel/spider-pic.c	2005-04-22 06:59:58.000000000 +0200
@@ -0,0 +1,191 @@
+/*
+ * External Interrupt Controller on Spider South Bridge
+ *
+ * (C) Copyright IBM Deutschland Entwicklung GmbH 2005
+ *
+ * Author: Arnd Bergmann <arndb@de.ibm.com>
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
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+
+#include <asm/pgtable.h>
+#include <asm/prom.h>
+#include <asm/io.h>
+
+#include "bpa_iic.h"
+
+/* register layout taken from Spider spec, table 7.4-4 */
+enum {
+	TIR_DEN		= 0x004, /* Detection Enable Register */
+	TIR_MSK		= 0x084, /* Mask Level Register */
+	TIR_EDC		= 0x0c0, /* Edge Detection Clear Register */
+	TIR_PNDA	= 0x100, /* Pending Register A */
+	TIR_PNDB	= 0x104, /* Pending Register B */
+	TIR_CS		= 0x144, /* Current Status Register */
+	TIR_LCSA	= 0x150, /* Level Current Status Register A */
+	TIR_LCSB	= 0x154, /* Level Current Status Register B */
+	TIR_LCSC	= 0x158, /* Level Current Status Register C */
+	TIR_LCSD	= 0x15c, /* Level Current Status Register D */
+	TIR_CFGA	= 0x200, /* Setting Register A0 */
+	TIR_CFGB	= 0x204, /* Setting Register B0 */
+			/* 0x208 ... 0x3ff Setting Register An/Bn */
+	TIR_PPNDA	= 0x400, /* Packet Pending Register A */
+	TIR_PPNDB	= 0x404, /* Packet Pending Register B */
+	TIR_PIERA	= 0x408, /* Packet Output Error Register A */
+	TIR_PIERB	= 0x40c, /* Packet Output Error Register B */
+	TIR_PIEN	= 0x444, /* Packet Output Enable Register */
+	TIR_PIPND	= 0x454, /* Packet Output Pending Register */
+	TIRDID		= 0x484, /* Spider Device ID Register */
+	REISTIM		= 0x500, /* Reissue Command Timeout Time Setting */
+	REISTIMEN	= 0x504, /* Reissue Command Timeout Setting */
+	REISWAITEN	= 0x508, /* Reissue Wait Control*/
+};
+
+static void __iomem *spider_pics[4];
+
+static void __iomem *spider_get_pic(int irq)
+{
+	int node = irq / IIC_NODE_STRIDE;
+	irq %= IIC_NODE_STRIDE;
+
+	if (irq >= IIC_EXT_OFFSET &&
+	    irq < IIC_EXT_OFFSET + IIC_NUM_EXT &&
+	    spider_pics)
+		return spider_pics[node];
+	return NULL;
+}
+
+static int spider_get_nr(unsigned int irq)
+{
+	return (irq % IIC_NODE_STRIDE) - IIC_EXT_OFFSET;
+}
+
+static void __iomem *spider_get_irq_config(int irq)
+{
+	void __iomem *pic;
+	pic = spider_get_pic(irq);
+	return pic + TIR_CFGA + 8 * spider_get_nr(irq);
+}
+
+static void spider_enable_irq(unsigned int irq)
+{
+	void __iomem *cfg = spider_get_irq_config(irq);
+	irq = spider_get_nr(irq);
+
+	out_be32(cfg, in_be32(cfg) | 0x3107000eu);
+	out_be32(cfg + 4, in_be32(cfg + 4) | 0x00020000u | irq);
+}
+
+static void spider_disable_irq(unsigned int irq)
+{
+	void __iomem *cfg = spider_get_irq_config(irq);
+	irq = spider_get_nr(irq);
+
+	out_be32(cfg, in_be32(cfg) & ~0x30000000u);
+}
+
+static unsigned int spider_startup_irq(unsigned int irq)
+{
+	spider_enable_irq(irq);
+	return 0;
+}
+
+static void spider_shutdown_irq(unsigned int irq)
+{
+	spider_disable_irq(irq);
+}
+
+static void spider_end_irq(unsigned int irq)
+{
+	spider_enable_irq(irq);
+}
+
+static void spider_ack_irq(unsigned int irq)
+{
+	spider_disable_irq(irq);
+	iic_local_enable();
+}
+
+static struct hw_interrupt_type spider_pic = {
+	.typename = " SPIDER  ",
+	.startup = spider_startup_irq,
+	.shutdown = spider_shutdown_irq,
+	.enable = spider_enable_irq,
+	.disable = spider_disable_irq,
+	.ack = spider_ack_irq,
+	.end = spider_end_irq,
+};
+
+
+int spider_get_irq(unsigned long int_pending)
+{
+	void __iomem *regs = spider_get_pic(int_pending);
+	unsigned long cs;
+	int irq;
+
+	cs = in_be32(regs + TIR_CS);
+
+	irq = cs >> 24;
+	if (irq != 63)
+		return irq;
+
+	return -1;
+}
+ 
+void spider_init_IRQ(void)
+{
+	int node;
+	struct device_node *dn;
+	unsigned int *property;
+	long spiderpic;
+	int n;
+
+/* FIXME: detect multiple PICs as soon as the device tree has them */
+	for (node = 0; node < 1; node++) {
+		dn = of_find_node_by_path("/");
+		n = prom_n_addr_cells(dn);
+		property = (unsigned int *) get_property(dn,
+				"platform-spider-pic", NULL);
+
+		if (!property)
+			continue;
+		for (spiderpic = 0; n > 0; --n)
+			spiderpic = (spiderpic << 32) + *property++;
+		printk(KERN_DEBUG "SPIDER addr: %lx\n", spiderpic);
+		spider_pics[node] = __ioremap(spiderpic, 0x800, _PAGE_NO_CACHE);
+		for (n = 0; n < IIC_NUM_EXT; n++) {
+			int irq = n + IIC_EXT_OFFSET + node * IIC_NODE_STRIDE;
+			get_irq_desc(irq)->handler = &spider_pic;
+
+ 		/* do not mask any interrupts because of level */
+ 		out_be32(spider_pics[node] + TIR_MSK, 0x0);
+ 		
+ 		/* disable edge detection clear */
+ 		/* out_be32(spider_pics[node] + TIR_EDC, 0x0); */
+ 		
+ 		/* enable interrupt packets to be output */
+ 		out_be32(spider_pics[node] + TIR_PIEN,
+			in_be32(spider_pics[node] + TIR_PIEN) | 0x1);
+ 		
+ 		/* Enable the interrupt detection enable bit. Do this last! */
+ 		out_be32(spider_pics[node] + TIR_DEN,
+			in_be32(spider_pics[node] +TIR_DEN) | 0x1);
+
+		}
+	}
+}

