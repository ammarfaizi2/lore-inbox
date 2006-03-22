Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422682AbWCWUmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422682AbWCWUmL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 15:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422678AbWCWUmB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 15:42:01 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:2259 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932523AbWCWUku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 15:40:50 -0500
Message-Id: <20060323203521.862355000@dyn-9-152-242-103.boeblingen.de.ibm.com>
References: <20060323203423.620978000@dyn-9-152-242-103.boeblingen.de.ibm.com>
User-Agent: quilt/0.44-1
Date: Thu, 23 Mar 2006 00:00:06 +0100
From: Arnd Bergmann <abergman@de.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, hpenner@de.ibm.com, stk@de.ibm.com,
       Segher Boessenkool <segher@kernel.crashing.org>,
       Milton Miller <miltonm@bga.com>, benh@kernel.crashing.org,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [patch 06/13] powerpc: cell interrupt controller updates
Content-Disposition: inline; filename=cell-pic-updates-3.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current interrupt controller setup on Cell is done
in a rather ad-hoc way with device tree properties
that are not standardized at all.

In an attempt to do something that follows the OF standard
(or at least the IBM extensions to it) more closely,
we have now come up with this patch. It still provides
a fallback to the old behaviour when we find older firmware,
that hack can not be removed until the existing customer
installations have upgraded.

Cc: hpenner@de.ibm.com
Cc: stk@de.ibm.com
Cc: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Milton Miller <miltonm@bga.com>
Cc: benh@kernel.crashing.org
From: Jens Osterkamp <Jens.Osterkamp@de.ibm.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linus-2.6/arch/powerpc/platforms/cell/spider-pic.c
===================================================================
--- linus-2.6.orig/arch/powerpc/platforms/cell/spider-pic.c
+++ linus-2.6/arch/powerpc/platforms/cell/spider-pic.c
@@ -84,10 +84,11 @@ static void __iomem *spider_get_irq_conf
 
 static void spider_enable_irq(unsigned int irq)
 {
+	int nodeid = (irq / IIC_NODE_STRIDE) * 0x10;
 	void __iomem *cfg = spider_get_irq_config(irq);
 	irq = spider_get_nr(irq);
 
-	out_be32(cfg, in_be32(cfg) | 0x3107000eu);
+	out_be32(cfg, in_be32(cfg) | 0x3107000eu | nodeid);
 	out_be32(cfg + 4, in_be32(cfg + 4) | 0x00020000u | irq);
 }
 
@@ -131,61 +132,108 @@ static struct hw_interrupt_type spider_p
 	.end = spider_end_irq,
 };
 
-
-int spider_get_irq(unsigned long int_pending)
+int spider_get_irq(int node)
 {
-	void __iomem *regs = spider_get_pic(int_pending);
 	unsigned long cs;
-	int irq;
-
-	cs = in_be32(regs + TIR_CS);
+	void __iomem *regs = spider_pics[node];
 
-	irq = cs >> 24;
-	if (irq != 63)
-		return irq;
+	cs = in_be32(regs + TIR_CS) >> 24;
 
-	return -1;
+	if (cs == 63)
+		return -1;
+	else
+		return cs;
 }
- 
-void spider_init_IRQ(void)
+
+/* hardcoded part to be compatible with older firmware */
+
+void spider_init_IRQ_hardcoded(void)
 {
 	int node;
-	struct device_node *dn;
-	unsigned int *property;
 	long spiderpic;
+	long pics[] = { 0x24000008000, 0x34000008000 };
 	int n;
 
-/* FIXME: detect multiple PICs as soon as the device tree has them */
-	for (node = 0; node < 1; node++) {
-		dn = of_find_node_by_path("/");
-		n = prom_n_addr_cells(dn);
-		property = (unsigned int *) get_property(dn,
-				"platform-spider-pic", NULL);
+	pr_debug("%s(%d): Using hardcoded defaults\n", __FUNCTION__, __LINE__);
 
-		if (!property)
-			continue;
-		for (spiderpic = 0; n > 0; --n)
-			spiderpic = (spiderpic << 32) + *property++;
+	for (node = 0; node < num_present_cpus()/2; node++) {
+		spiderpic = pics[node];
 		printk(KERN_DEBUG "SPIDER addr: %lx\n", spiderpic);
 		spider_pics[node] = __ioremap(spiderpic, 0x800, _PAGE_NO_CACHE);
 		for (n = 0; n < IIC_NUM_EXT; n++) {
 			int irq = n + IIC_EXT_OFFSET + node * IIC_NODE_STRIDE;
 			get_irq_desc(irq)->handler = &spider_pic;
+		}
 
  		/* do not mask any interrupts because of level */
  		out_be32(spider_pics[node] + TIR_MSK, 0x0);
- 		
+
  		/* disable edge detection clear */
  		/* out_be32(spider_pics[node] + TIR_EDC, 0x0); */
- 		
+
  		/* enable interrupt packets to be output */
  		out_be32(spider_pics[node] + TIR_PIEN,
 			in_be32(spider_pics[node] + TIR_PIEN) | 0x1);
- 		
+
  		/* Enable the interrupt detection enable bit. Do this last! */
  		out_be32(spider_pics[node] + TIR_DEN,
-			in_be32(spider_pics[node] +TIR_DEN) | 0x1);
+			in_be32(spider_pics[node] + TIR_DEN) | 0x1);
+	}
+}
+
+void spider_init_IRQ(void)
+{
+	long spider_reg;
+	struct device_node *dn;
+	char *compatible;
+	int n, node = 0;
+
+	for (dn = NULL; (dn = of_find_node_by_name(dn, "interrupt-controller"));) {
+		compatible = (char *)get_property(dn, "compatible", NULL);
 
+		if (!compatible)
+			continue;
+
+		if (strstr(compatible, "CBEA,platform-spider-pic"))
+			spider_reg = *(long *)get_property(dn,"reg", NULL);
+		else if (strstr(compatible, "sti,platform-spider-pic")) {
+			spider_init_IRQ_hardcoded();
+			return;
+		} else
+			continue;
+
+		if (!spider_reg)
+			printk("interrupt controller does not have reg property !\n");
+
+		n = prom_n_addr_cells(dn);
+
+		if ( n != 2)
+			printk("reg property with invalid number of elements \n");
+
+		spider_pics[node] = __ioremap(spider_reg, 0x800, _PAGE_NO_CACHE);
+
+		printk("SPIDER addr: %lx with %i addr_cells mapped to %p\n",
+		       spider_reg, n, spider_pics[node]);
+
+		for (n = 0; n < IIC_NUM_EXT; n++) {
+			int irq = n + IIC_EXT_OFFSET + node * IIC_NODE_STRIDE;
+			get_irq_desc(irq)->handler = &spider_pic;
 		}
+
+		/* do not mask any interrupts because of level */
+		out_be32(spider_pics[node] + TIR_MSK, 0x0);
+
+		/* disable edge detection clear */
+		/* out_be32(spider_pics[node] + TIR_EDC, 0x0); */
+
+		/* enable interrupt packets to be output */
+		out_be32(spider_pics[node] + TIR_PIEN,
+			in_be32(spider_pics[node] + TIR_PIEN) | 0x1);
+
+		/* Enable the interrupt detection enable bit. Do this last! */
+		out_be32(spider_pics[node] + TIR_DEN,
+			in_be32(spider_pics[node] + TIR_DEN) | 0x1);
+
+		node++;
 	}
 }
Index: linus-2.6/arch/powerpc/platforms/cell/interrupt.c
===================================================================
--- linus-2.6.orig/arch/powerpc/platforms/cell/interrupt.c
+++ linus-2.6/arch/powerpc/platforms/cell/interrupt.c
@@ -123,7 +123,7 @@ static int iic_external_get_irq(struct i
 		    pending.class != 2)
 			break;
 		irq = IIC_EXT_OFFSET
-			+ spider_get_irq(pending.prio + node * IIC_NODE_STRIDE)
+			+ spider_get_irq(node)
 			+ node * IIC_NODE_STRIDE;
 		break;
 	case 0x01 ... 0x04:
@@ -174,40 +174,104 @@ int iic_get_irq(struct pt_regs *regs)
 	return irq;
 }
 
-static int setup_iic(int cpu, struct iic *iic)
+/* hardcoded part to be compatible with older firmware */
+
+static int setup_iic_hardcoded(void)
 {
 	struct device_node *np;
-	int nodeid = cpu / 2;
+	int nodeid, cpu;
 	unsigned long regs;
+	struct iic *iic;
 
-	for (np = of_find_node_by_type(NULL, "cpu");
-	     np;
-	     np = of_find_node_by_type(np, "cpu")) {
-		if (nodeid == *(int *)get_property(np, "node-id", NULL))
-			break;
-	}
+	for_each_cpu(cpu) {
+		iic = &per_cpu(iic, cpu);
+		nodeid = cpu/2;
 
-	if (!np) {
-		printk(KERN_WARNING "IIC: CPU %d not found\n", cpu);
-		iic->regs = NULL;
-		iic->target_id = 0xff;
-		return -ENODEV;
-	}
+		for (np = of_find_node_by_type(NULL, "cpu");
+		     np;
+		     np = of_find_node_by_type(np, "cpu")) {
+			if (nodeid == *(int *)get_property(np, "node-id", NULL))
+				break;
+			}
+
+		if (!np) {
+			printk(KERN_WARNING "IIC: CPU %d not found\n", cpu);
+			iic->regs = NULL;
+			iic->target_id = 0xff;
+			return -ENODEV;
+			}
+
+		regs = *(long *)get_property(np, "iic", NULL);
+
+		/* hack until we have decided on the devtree info */
+		regs += 0x400;
+		if (cpu & 1)
+			regs += 0x20;
+
+		printk(KERN_INFO "IIC for CPU %d at %lx\n", cpu, regs);
+		iic->regs = __ioremap(regs, sizeof(struct iic_regs),
+				      _PAGE_NO_CACHE);
 
-	regs = *(long *)get_property(np, "iic", NULL);
+		iic->target_id = (nodeid << 4) + ((cpu & 1) ? 0xf : 0xe);
+	}
 
-	/* hack until we have decided on the devtree info */
-	regs += 0x400;
-	if (cpu & 1)
-		regs += 0x20;
-
-	printk(KERN_DEBUG "IIC for CPU %d at %lx\n", cpu, regs);
-	iic->regs = __ioremap(regs, sizeof(struct iic_regs),
-					 _PAGE_NO_CACHE);
-	iic->target_id = (nodeid << 4) + ((cpu & 1) ? 0xf : 0xe);
 	return 0;
 }
 
+static int setup_iic(void)
+{
+	struct device_node *dn;
+	unsigned long *regs;
+	char *compatible;
+ 	unsigned *np, found = 0;
+	struct iic *iic = NULL;
+
+	for (dn = NULL; (dn = of_find_node_by_name(dn, "interrupt-controller"));) {
+		compatible = (char *)get_property(dn, "compatible", NULL);
+
+		if (!compatible) {
+			printk(KERN_WARNING "no compatible property found !\n");
+			continue;
+		}
+
+ 		if (strstr(compatible, "IBM,CBEA-Internal-Interrupt-Controller"))
+ 			regs = (unsigned long *)get_property(dn,"reg", NULL);
+ 		else
+			continue;
+
+ 		if (!regs)
+ 			printk(KERN_WARNING "IIC: no reg property\n");
+
+ 		np = (unsigned int *)get_property(dn, "ibm,interrupt-server-ranges", NULL);
+
+ 		if (!np) {
+			printk(KERN_WARNING "IIC: CPU association not found\n");
+			iic->regs = NULL;
+			iic->target_id = 0xff;
+			return -ENODEV;
+		}
+
+ 		iic = &per_cpu(iic, np[0]);
+ 		iic->regs = __ioremap(regs[0], sizeof(struct iic_regs),
+ 				      _PAGE_NO_CACHE);
+		iic->target_id = ((np[0] & 2) << 3) + ((np[0] & 1) ? 0xf : 0xe);
+ 		printk("IIC for CPU %d at %lx mapped to %p\n", np[0], regs[0], iic->regs);
+
+ 		iic = &per_cpu(iic, np[1]);
+ 		iic->regs = __ioremap(regs[2], sizeof(struct iic_regs),
+ 				      _PAGE_NO_CACHE);
+		iic->target_id = ((np[1] & 2) << 3) + ((np[1] & 1) ? 0xf : 0xe);
+ 		printk("IIC for CPU %d at %lx mapped to %p\n", np[1], regs[2], iic->regs);
+
+		found++;
+  	}
+
+	if (found)
+		return 0;
+	else
+		return -ENODEV;
+}
+
 #ifdef CONFIG_SMP
 
 /* Use the highest interrupt priorities for IPI */
@@ -283,10 +347,12 @@ void iic_init_IRQ(void)
 	int cpu, irq_offset;
 	struct iic *iic;
 
+	if (setup_iic() < 0)
+		setup_iic_hardcoded();
+
 	irq_offset = 0;
 	for_each_cpu(cpu) {
 		iic = &per_cpu(iic, cpu);
-		setup_iic(cpu, iic);
 		if (iic->regs)
 			out_be64(&iic->regs->prio, 0xff);
 	}
Index: linus-2.6/arch/powerpc/platforms/cell/interrupt.h
===================================================================
--- linus-2.6.orig/arch/powerpc/platforms/cell/interrupt.h
+++ linus-2.6/arch/powerpc/platforms/cell/interrupt.h
@@ -57,7 +57,7 @@ extern void iic_local_disable(void);
 extern u8 iic_get_target_id(int cpu);
 
 extern void spider_init_IRQ(void);
-extern int spider_get_irq(unsigned long int_pending);
+extern int spider_get_irq(int node);
 
 #endif
 #endif /* ASM_CELL_PIC_H */

--

