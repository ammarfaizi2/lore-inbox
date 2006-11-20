Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966325AbWKTSL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966325AbWKTSL3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 13:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966288AbWKTSKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 13:10:52 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:57550 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S934276AbWKTSHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 13:07:08 -0500
Message-Id: <20061120180527.841828000@arndb.de>
References: <20061120174454.067872000@arndb.de>
User-Agent: quilt/0.45-1
Date: Mon, 20 Nov 2006 18:45:15 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Paul Mackerras <paulus@samba.org>, Kevin Corry <kevcorry@us.ibm.com>,
       Carl Love <carll@us.ibm.com>, Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [PATCH 21/22] cell: add routines for managing PMU interrupts
Content-Disposition: inline; filename=oprofile-for-cell-prereqs-new-routines-for-managing-pmu-interrupts.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Corry <kevcorry@us.ibm.com>

The following routines are added to arch/powerpc/platforms/cell/pmu.c:
 cbe_clear_pm_interrupts()
 cbe_enable_pm_interrupts()
 cbe_disable_pm_interrupts()
 cbe_query_pm_interrupts()
 cbe_pm_irq()
 cbe_init_pm_irq()

This also adds a routine in arch/powerpc/platforms/cell/interrupt.c and
some macros in cbe_regs.h to manipulate the IIC_IR register:
 iic_set_interrupt_routing()

Signed-off-by: Kevin Corry <kevcorry@us.ibm.com>
Signed-off-by: Carl Love <carll@us.ibm.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Index: linux-2.6/arch/powerpc/platforms/cell/pmu.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/pmu.c
+++ linux-2.6/arch/powerpc/platforms/cell/pmu.c
@@ -22,9 +22,11 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+#include <linux/interrupt.h>
 #include <linux/types.h>
 #include <asm/io.h>
 #include <asm/machdep.h>
+#include <asm/pmc.h>
 #include <asm/reg.h>
 #include <asm/spu.h>
 
@@ -338,3 +340,71 @@ void cbe_read_trace_buffer(u32 cpu, u64 
 }
 EXPORT_SYMBOL_GPL(cbe_read_trace_buffer);
 
+/*
+ * Enabling/disabling interrupts for the entire performance monitoring unit.
+ */
+
+u32 cbe_query_pm_interrupts(u32 cpu)
+{
+	return cbe_read_pm(cpu, pm_status);
+}
+EXPORT_SYMBOL_GPL(cbe_query_pm_interrupts);
+
+u32 cbe_clear_pm_interrupts(u32 cpu)
+{
+	/* Reading pm_status clears the interrupt bits. */
+	return cbe_query_pm_interrupts(cpu);
+}
+EXPORT_SYMBOL_GPL(cbe_clear_pm_interrupts);
+
+void cbe_enable_pm_interrupts(u32 cpu, u32 thread, u32 mask)
+{
+	/* Set which node and thread will handle the next interrupt. */
+	iic_set_interrupt_routing(cpu, thread, 0);
+
+	/* Enable the interrupt bits in the pm_status register. */
+	if (mask)
+		cbe_write_pm(cpu, pm_status, mask);
+}
+EXPORT_SYMBOL_GPL(cbe_enable_pm_interrupts);
+
+void cbe_disable_pm_interrupts(u32 cpu)
+{
+	cbe_clear_pm_interrupts(cpu);
+	cbe_write_pm(cpu, pm_status, 0);
+}
+EXPORT_SYMBOL_GPL(cbe_disable_pm_interrupts);
+
+static irqreturn_t cbe_pm_irq(int irq, void *dev_id, struct pt_regs *regs)
+{
+	perf_irq(regs);
+	return IRQ_HANDLED;
+}
+
+int __init cbe_init_pm_irq(void)
+{
+	unsigned int irq;
+	int rc, node;
+
+	for_each_node(node) {
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
+arch_initcall(cbe_init_pm_irq);
+
Index: linux-2.6/arch/powerpc/platforms/cell/interrupt.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/interrupt.c
+++ linux-2.6/arch/powerpc/platforms/cell/interrupt.c
@@ -396,3 +396,19 @@ void __init iic_init_IRQ(void)
 	/* Enable on current CPU */
 	iic_setup_cpu();
 }
+
+void iic_set_interrupt_routing(int cpu, int thread, int priority)
+{
+	struct cbe_iic_regs __iomem *iic_regs = cbe_get_cpu_iic_regs(cpu);
+	u64 iic_ir = 0;
+	int node = cpu >> 1;
+
+	/* Set which node and thread will handle the next interrupt */
+	iic_ir |= CBE_IIC_IR_PRIO(priority) |
+		  CBE_IIC_IR_DEST_NODE(node);
+	if (thread == 0)
+		iic_ir |= CBE_IIC_IR_DEST_UNIT(CBE_IIC_IR_PT_0);
+	else
+		iic_ir |= CBE_IIC_IR_DEST_UNIT(CBE_IIC_IR_PT_1);
+	out_be64(&iic_regs->iic_ir, iic_ir);
+}
Index: linux-2.6/arch/powerpc/platforms/cell/interrupt.h
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/interrupt.h
+++ linux-2.6/arch/powerpc/platforms/cell/interrupt.h
@@ -83,5 +83,7 @@ extern u8 iic_get_target_id(int cpu);
 
 extern void spider_init_IRQ(void);
 
+extern void iic_set_interrupt_routing(int cpu, int thread, int priority);
+
 #endif
 #endif /* ASM_CELL_PIC_H */
Index: linux-2.6/include/asm-powerpc/cell-pmu.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/cell-pmu.h
+++ linux-2.6/include/asm-powerpc/cell-pmu.h
@@ -87,4 +87,9 @@ extern void cbe_disable_pm(u32 cpu);
 
 extern void cbe_read_trace_buffer(u32 cpu, u64 *buf);
 
+extern void cbe_enable_pm_interrupts(u32 cpu, u32 thread, u32 mask);
+extern void cbe_disable_pm_interrupts(u32 cpu);
+extern u32  cbe_query_pm_interrupts(u32 cpu);
+extern u32  cbe_clear_pm_interrupts(u32 cpu);
+
 #endif /* __ASM_CELL_PMU_H__ */
Index: linux-2.6/arch/powerpc/platforms/cell/cbe_regs.h
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/cbe_regs.h
+++ linux-2.6/arch/powerpc/platforms/cell/cbe_regs.h
@@ -185,6 +185,14 @@ struct cbe_iic_regs {
 	struct	cbe_iic_thread_regs thread[2];			/* 0x0400 */
 
 	u64	iic_ir;						/* 0x0440 */
+#define CBE_IIC_IR_PRIO(x)      (((x) & 0xf) << 12)
+#define CBE_IIC_IR_DEST_NODE(x) (((x) & 0xf) << 4)
+#define CBE_IIC_IR_DEST_UNIT(x) ((x) & 0xf)
+#define CBE_IIC_IR_IOC_0        0x0
+#define CBE_IIC_IR_IOC_1S       0xb
+#define CBE_IIC_IR_PT_0         0xe
+#define CBE_IIC_IR_PT_1         0xf
+
 	u64	iic_is;						/* 0x0448 */
 #define CBE_IIC_IS_PMI		0x2
 

--

