Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423866AbWKIPBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423866AbWKIPBO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 10:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423876AbWKIPBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 10:01:14 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:28377 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1423866AbWKIPBM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 10:01:12 -0500
From: Kevin Corry <kevcorry@us.ibm.com>
Organization: IBM
To: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [RFC,PATCH 1/2] Oprofile-on-Cell prereqs
Date: Thu, 9 Nov 2006 09:01:07 -0600
User-Agent: KMail/1.8.3
References: <200611090858.11590.kevcorry@us.ibm.com>
In-Reply-To: <200611090858.11590.kevcorry@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611090901.07548.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add routines for managing the Cell PMU interrupts.

The following routines are added to arch/powerpc/platforms/cell/pmu.c:
 cbe_clear_pm_interrupts()
 cbe_enable_pm_interrupts()
 cbe_disable_pm_interrupts()
 cbe_query_pm_interrupts()
 pm_init_IRQ()

This also adds two routines to arch/powerpc/platforms/cell/interrupt.c
to manipulate the IIC_IS and IIC_IR registers:
 iic_clear_pmi_interrupt()
 iic_set_interrupt_routing()

We are still working on how to clean up cbe_clear_pm_interrupts() and
cbe_enable_pm_interrupts() so we hopefully won't need to call the
iic_ routines (and also not need the additions to interrupt.c).

Signed-Off-By: Kevin Corry <kevcorry@us.ibm.com>
Signed-Off-By: Carl Love <carll@us.ibm.com>

Index: linux-2.6.18-arnd5/arch/powerpc/platforms/cell/pmu.c
===================================================================
--- linux-2.6.18-arnd5.orig/arch/powerpc/platforms/cell/pmu.c
+++ linux-2.6.18-arnd5/arch/powerpc/platforms/cell/pmu.c
@@ -23,10 +23,12 @@
  */
 
 #include <linux/types.h>
+#include <linux/interrupt.h>
 #include <asm/io.h>
 #include <asm/machdep.h>
 #include <asm/reg.h>
 #include <asm/spu.h>
+#include <asm/pmc.h>
 
 #include "cbe_regs.h"
 #include "interrupt.h"
@@ -339,3 +341,78 @@ void cbe_read_trace_buffer(u32 cpu, u64 
 }
 EXPORT_SYMBOL_GPL(cbe_read_trace_buffer);
 
+/*
+ * Enabling/disabling interrupts for the entire performance monitoring unit.
+ */
+
+u32 cbe_clear_pm_interrupts(u32 cpu)
+{
+	u32 mask;
+
+	/* First read pm_status to clear the interrupt -- order is important! */
+	mask = cbe_read_pm(cpu, pm_status);
+
+	/* Then clear the PMI interrupt bit. */
+	iic_clear_pmi_interrupt(cpu);
+
+	return mask;
+}
+EXPORT_SYMBOL_GPL(cbe_clear_pm_interrupts);
+
+void cbe_enable_pm_interrupts(u32 cpu, u32 thread, u32 mask)
+{
+	/* Set which node and thread will handle the next interrupt */
+	iic_set_interrupt_routing(cpu, thread, 0);
+
+	/* Enable pm interrupts */
+	if (mask)
+		cbe_write_pm(cpu, pm_status, mask);
+}
+EXPORT_SYMBOL_GPL(cbe_enable_pm_interrupts);
+
+void cbe_disable_pm_interrupts(u32 cpu)
+{
+	cbe_write_pm(cpu, pm_status, 0);
+	cbe_clear_pm_interrupts(cpu);
+}
+EXPORT_SYMBOL_GPL(cbe_disable_pm_interrupts);
+
+u32 cbe_query_pm_interrupts(u32 cpu)
+{
+	return cbe_read_pm(cpu, pm_status);
+}
+EXPORT_SYMBOL_GPL(cbe_query_pm_interrupts);
+
+static irqreturn_t cbe_pm_irq(int irq, void *dev_id, struct pt_regs *regs)
+{
+	perf_irq(regs);
+	return IRQ_HANDLED;
+}
+
+int __init pm_init_IRQ(void)
+{
+	unsigned int irq;
+	int rc, node;
+
+	for_each_cbe_node(node) {
+		irq = irq_create_mapping(NULL, IIC_IRQ_IOEX_PMI |
+					       (node << IIC_IRQ_NODE_SHIFT));
+		if (irq == NO_IRQ) {
+			printk("ERROR: Unable to allocate irq for node %d\n",
+			       node);
+			return -EINVAL;
+		}
+
+		rc = request_irq(irq, cbe_pm_irq,
+				 IRQF_DISABLED, "cbe-pmu-0", NULL);
+		if (rc) {
+			printk("ERROR: Request for irq on node %d failed\n",
+			       node);
+			return rc;
+		}
+	}
+
+	return 0;
+}
+arch_initcall(pm_init_IRQ);
+
Index: linux-2.6.18-arnd5/arch/powerpc/platforms/cell/pmu.h
===================================================================
--- linux-2.6.18-arnd5.orig/arch/powerpc/platforms/cell/pmu.h
+++ linux-2.6.18-arnd5/arch/powerpc/platforms/cell/pmu.h
@@ -22,8 +22,8 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#ifndef __PERFMON_H__
-#define __PERFMON_H__
+#ifndef __CELL_PMU_H__
+#define __CELL_PMU_H__
 
 enum pm_reg_name {
 	group_control,
@@ -54,4 +54,20 @@ extern void cbe_disable_pm(u32 cpu);
 
 extern void cbe_read_trace_buffer(u32 cpu, u64 *buf);
 
-#endif
+extern void cbe_enable_pm_interrupts(u32 cpu, u32 thread, u32 mask);
+extern void cbe_disable_pm_interrupts(u32 cpu);
+extern u32  cbe_query_pm_interrupts(u32 cpu);
+extern u32  cbe_clear_pm_interrupts(u32 cpu);
+
+/* FIXME: Don't assume each node always has two logical CPUs.
+ *        Also, we should definitely find a better header file to put these in.
+ */
+#define for_each_cbe_node(node) \
+	for ((node) = 0; (node) < num_possible_cpus() >> 1; (node)++)
+
+#define for_each_online_cbe_node(node) \
+	for ((node) = 0; (node) < num_online_cpus() >> 1; (node)++)
+
+#define cbe_cpu_to_node(cpu) ((cpu) >> 1)
+
+#endif /* __CELL_PMU_H__ */
Index: linux-2.6.18-arnd5/arch/powerpc/platforms/cell/interrupt.c
===================================================================
--- linux-2.6.18-arnd5.orig/arch/powerpc/platforms/cell/interrupt.c
+++ linux-2.6.18-arnd5/arch/powerpc/platforms/cell/interrupt.c
@@ -397,3 +397,27 @@ void __init iic_init_IRQ(void)
 	/* Enable on current CPU */
 	iic_setup_cpu();
 }
+
+void iic_clear_pmi_interrupt(int cpu)
+{
+	/* Write 1 to PMI bit of the IIC_IS register to clear the interrupt. */
+	struct cbe_iic_regs __iomem *iic_regs = cbe_get_cpu_iic_regs(cpu);
+	out_be64(&iic_regs->iic_is, CBE_IIC_IS_PMI);
+}
+
+void iic_set_interrupt_routing(int cpu, int thread, int priority)
+{
+	struct cbe_iic_regs __iomem *iic_regs = cbe_get_cpu_iic_regs(cpu);
+	struct cbe_iic_ir iic_ir;
+	int node = cpu >> 1;
+
+	/* Set which node and thread will handle the next interrupt */
+	iic_ir.val = 0;
+	iic_ir.priority = priority;
+	iic_ir.dst_node_id = node;
+	if (thread == 0)
+		iic_ir.dst_unit_id = CBE_IIC_IR_PT0;
+	else
+		iic_ir.dst_unit_id = CBE_IIC_IR_PT1;
+	out_be64(&iic_regs->iic_ir.val, iic_ir.val);
+}
Index: linux-2.6.18-arnd5/arch/powerpc/platforms/cell/interrupt.h
===================================================================
--- linux-2.6.18-arnd5.orig/arch/powerpc/platforms/cell/interrupt.h
+++ linux-2.6.18-arnd5/arch/powerpc/platforms/cell/interrupt.h
@@ -83,5 +83,8 @@ extern u8 iic_get_target_id(int cpu);
 
 extern void spider_init_IRQ(void);
 
+extern void iic_clear_pmi_interrupt(int cpu);
+extern void iic_set_interrupt_routing(int cpu, int thread, int priority);
+
 #endif
 #endif /* ASM_CELL_PIC_H */
