Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161568AbWJDQbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161568AbWJDQbb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 12:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161560AbWJDQb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 12:31:28 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:10970 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1161564AbWJDQbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 12:31:11 -0400
Message-Id: <20061004161512.985412000@arndb.de>
References: <20061004152610.151599000@dyn-9-152-242-103.boeblingen.de.ibm.com>
User-Agent: quilt/0.45-1
Date: Wed, 04 Oct 2006 17:26:24 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Cc: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [PATCH 14/14] cell: fix bugs found by sparse
Content-Disposition: inline; filename=cell-sparse-fixes.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Some long constants should be marked 'ul'.
- When using desc->handler_data to pass an __iomem
  register area, we need to add casts to and from
  __iomem.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Index: linux-2.6/arch/powerpc/platforms/cell/interrupt.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/interrupt.c
+++ linux-2.6/arch/powerpc/platforms/cell/interrupt.c
@@ -101,7 +101,7 @@ static void iic_ioexc_eoi(unsigned int i
 static void iic_ioexc_cascade(unsigned int irq, struct irq_desc *desc,
 			    struct pt_regs *regs)
 {
-	struct cbe_iic_regs *node_iic = desc->handler_data;
+	struct cbe_iic_regs __iomem *node_iic = (void __iomem *)desc->handler_data;
 	unsigned int base = (irq & 0xffffff00) | IIC_IRQ_TYPE_IOEXC;
 	unsigned long bits, ack;
 	int cascade;
@@ -320,7 +320,7 @@ static int __init setup_iic(void)
 	struct device_node *dn;
 	struct resource r0, r1;
 	unsigned int node, cascade, found = 0;
-	struct cbe_iic_regs *node_iic;
+	struct cbe_iic_regs __iomem *node_iic;
 	const u32 *np;
 
 	for (dn = NULL;
@@ -357,7 +357,11 @@ static int __init setup_iic(void)
 		cascade = irq_create_mapping(iic_host, cascade);
 		if (cascade == NO_IRQ)
 			continue;
-		set_irq_data(cascade, node_iic);
+		/*
+		 * irq_data is a generic pointer that gets passed back
+		 * to us later, so the forced cast is fine.
+		 */
+		set_irq_data(cascade, (void __force *)node_iic);
 		set_irq_chained_handler(cascade , iic_ioexc_cascade);
 		out_be64(&node_iic->iic_ir,
 			 (1 << 12)		/* priority */ |
Index: linux-2.6/arch/powerpc/platforms/cell/iommu.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/iommu.c
+++ linux-2.6/arch/powerpc/platforms/cell/iommu.c
@@ -345,8 +345,8 @@ static int cell_map_iommu_hardcoded(int 
 
 	/* node 0 */
 	iommu = &cell_iommus[0];
-	iommu->mapped_base = ioremap(0x20000511000, 0x1000);
-	iommu->mapped_mmio_base = ioremap(0x20000510000, 0x1000);
+	iommu->mapped_base = ioremap(0x20000511000ul, 0x1000);
+	iommu->mapped_mmio_base = ioremap(0x20000510000ul, 0x1000);
 
 	enable_mapping(iommu->mapped_base, iommu->mapped_mmio_base);
 
@@ -358,8 +358,8 @@ static int cell_map_iommu_hardcoded(int 
 
 	/* node 1 */
 	iommu = &cell_iommus[1];
-	iommu->mapped_base = ioremap(0x30000511000, 0x1000);
-	iommu->mapped_mmio_base = ioremap(0x30000510000, 0x1000);
+	iommu->mapped_base = ioremap(0x30000511000ul, 0x1000);
+	iommu->mapped_mmio_base = ioremap(0x30000510000ul, 0x1000);
 
 	enable_mapping(iommu->mapped_base, iommu->mapped_mmio_base);
 
Index: linux-2.6/arch/powerpc/platforms/cell/spider-pic.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spider-pic.c
+++ linux-2.6/arch/powerpc/platforms/cell/spider-pic.c
@@ -367,7 +367,7 @@ void __init spider_init_IRQ(void)
 		} else if (device_is_compatible(dn, "sti,platform-spider-pic")
 			   && (chip < 2)) {
 			static long hard_coded_pics[] =
-				{ 0x24000008000, 0x34000008000 };
+				{ 0x24000008000ul, 0x34000008000ul};
 			r.start = hard_coded_pics[chip];
 		} else
 			continue;

--

