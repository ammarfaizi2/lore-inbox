Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030278AbWADT7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030278AbWADT7I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 14:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965284AbWADT6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 14:58:14 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:37835 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S965241AbWADT5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 14:57:36 -0500
Message-Id: <20060104194502.253418000@localhost>
References: <20060104193120.050539000@localhost>
Date: Wed, 04 Jan 2006 20:31:33 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Al Viro <viro@ftp.linux.org.uk>, Mark Nutter <mnutter@us.ibm.com>,
       Arnd Bergmann <arndb@de.ibm.com>
Subject: [PATCH 13/13] spufs: set irq affinity for running threads
Content-Disposition: inline; filename=spu-irq-affinity.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For far, all SPU triggered interrupts always end up on
the first SMT thread, which is a bad solution.

This patch implements setting the affinity to the
CPU that was running last when entering execution on
an SPU. This should result in a significant reduction
in IPI calls and better cache locality for SPE thread
specific data.

Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

Index: linux-2.6.15-rc/include/asm-powerpc/spu.h
===================================================================
--- linux-2.6.15-rc.orig/include/asm-powerpc/spu.h
+++ linux-2.6.15-rc/include/asm-powerpc/spu.h
@@ -147,6 +147,7 @@ struct spu *spu_alloc(void);
 void spu_free(struct spu *spu);
 int spu_irq_class_0_bottom(struct spu *spu);
 int spu_irq_class_1_bottom(struct spu *spu);
+void spu_irq_setaffinity(struct spu *spu, int cpu);
 
 extern struct spufs_calls {
 	asmlinkage long (*create_thread)(const char __user *name,
Index: linux-2.6.15-rc/arch/powerpc/platforms/cell/interrupt.c
===================================================================
--- linux-2.6.15-rc.orig/arch/powerpc/platforms/cell/interrupt.c
+++ linux-2.6.15-rc/arch/powerpc/platforms/cell/interrupt.c
@@ -23,6 +23,7 @@
 #include <linux/config.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/module.h>
 #include <linux/percpu.h>
 #include <linux/types.h>
 
@@ -55,6 +56,7 @@ struct iic_regs {
 
 struct iic {
 	struct iic_regs __iomem *regs;
+	u8 target_id;
 };
 
 static DEFINE_PER_CPU(struct iic, iic);
@@ -172,12 +174,11 @@ int iic_get_irq(struct pt_regs *regs)
 	return irq;
 }
 
-static struct iic_regs __iomem *find_iic(int cpu)
+static int setup_iic(int cpu, struct iic *iic)
 {
 	struct device_node *np;
 	int nodeid = cpu / 2;
 	unsigned long regs;
-	struct iic_regs __iomem *iic_regs;
 
 	for (np = of_find_node_by_type(NULL, "cpu");
 	     np;
@@ -188,20 +189,23 @@ static struct iic_regs __iomem *find_iic
 
 	if (!np) {
 		printk(KERN_WARNING "IIC: CPU %d not found\n", cpu);
-		iic_regs = NULL;
-	} else {
-		regs = *(long *)get_property(np, "iic", NULL);
-
-		/* hack until we have decided on the devtree info */
-		regs += 0x400;
-		if (cpu & 1)
-			regs += 0x20;
-
-		printk(KERN_DEBUG "IIC for CPU %d at %lx\n", cpu, regs);
-		iic_regs = __ioremap(regs, sizeof(struct iic_regs),
-						 _PAGE_NO_CACHE);
+		iic->regs = NULL;
+		iic->target_id = 0xff;
+		return -ENODEV;
 	}
-	return iic_regs;
+
+	regs = *(long *)get_property(np, "iic", NULL);
+
+	/* hack until we have decided on the devtree info */
+	regs += 0x400;
+	if (cpu & 1)
+		regs += 0x20;
+
+	printk(KERN_DEBUG "IIC for CPU %d at %lx\n", cpu, regs);
+	iic->regs = __ioremap(regs, sizeof(struct iic_regs),
+					 _PAGE_NO_CACHE);
+	iic->target_id = (nodeid << 4) + ((cpu & 1) ? 0xf : 0xe);
+	return 0;
 }
 
 #ifdef CONFIG_SMP
@@ -227,6 +231,12 @@ void iic_cause_IPI(int cpu, int mesg)
 	out_be64(&per_cpu(iic, cpu).regs->generate, (IIC_NUM_IPIS - 1 - mesg) << 4);
 }
 
+u8 iic_get_target_id(int cpu)
+{
+	return per_cpu(iic, cpu).target_id;
+}
+EXPORT_SYMBOL_GPL(iic_get_target_id);
+
 static irqreturn_t iic_ipi_action(int irq, void *dev_id, struct pt_regs *regs)
 {
 	smp_message_recv(iic_irq_to_ipi(irq), regs);
@@ -276,7 +286,7 @@ void iic_init_IRQ(void)
 	irq_offset = 0;
 	for_each_cpu(cpu) {
 		iic = &per_cpu(iic, cpu);
-		iic->regs = find_iic(cpu);
+		setup_iic(cpu, iic);
 		if (iic->regs)
 			out_be64(&iic->regs->prio, 0xff);
 	}
Index: linux-2.6.15-rc/arch/powerpc/platforms/cell/interrupt.h
===================================================================
--- linux-2.6.15-rc.orig/arch/powerpc/platforms/cell/interrupt.h
+++ linux-2.6.15-rc/arch/powerpc/platforms/cell/interrupt.h
@@ -54,6 +54,7 @@ extern void iic_setup_cpu(void);
 extern void iic_local_enable(void);
 extern void iic_local_disable(void);
 
+extern u8 iic_get_target_id(int cpu);
 
 extern void spider_init_IRQ(void);
 extern int spider_get_irq(unsigned long int_pending);
Index: linux-2.6.15-rc/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- linux-2.6.15-rc.orig/arch/powerpc/platforms/cell/spu_base.c
+++ linux-2.6.15-rc/arch/powerpc/platforms/cell/spu_base.c
@@ -507,6 +507,14 @@ int spu_irq_class_1_bottom(struct spu *s
 	return ret;
 }
 
+void spu_irq_setaffinity(struct spu *spu, int cpu)
+{
+	u64 target = iic_get_target_id(cpu);
+	u64 route = target << 48 | target << 32 | target << 16;
+	spu_int_route_set(spu, route);
+}
+EXPORT_SYMBOL_GPL(spu_irq_setaffinity);
+
 static void __iomem * __init map_spe_prop(struct device_node *n,
 						 const char *name)
 {
Index: linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/sched.c
===================================================================
--- linux-2.6.15-rc.orig/arch/powerpc/platforms/cell/spufs/sched.c
+++ linux-2.6.15-rc/arch/powerpc/platforms/cell/spufs/sched.c
@@ -357,6 +357,11 @@ int spu_activate(struct spu_context *ctx
 	if (!spu)
 		return (signal_pending(current)) ? -ERESTARTSYS : -EAGAIN;
 	bind_context(spu, ctx);
+	/*
+	 * We're likely to wait for interrupts on the same
+	 * CPU that we are now on, so send them here.
+	 */
+	spu_irq_setaffinity(spu, smp_processor_id());
 	put_active_spu(spu);
 	return 0;
 }

--

