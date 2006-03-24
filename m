Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932590AbWCXSsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932590AbWCXSsN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 13:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932591AbWCXSsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 13:48:13 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:3301 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932590AbWCXSsL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 13:48:11 -0500
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: use guarded ioremap for on-chip mappings
Date: Fri, 24 Mar 2006 19:47:52 +0100
User-Agent: KMail/1.9.1
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Arnd Bergmann <abergman@de.ibm.com>, stk@de.ibm.com,
       linux-kernel@vger.kernel.org, Milton Miller <miltonm@bga.com>,
       Paul Mackerras <paulus@samba.org>, hpenner@de.ibm.com,
       cbe-oss-dev@ozlabs.org
References: <20060323203423.620978000@dyn-9-152-242-103.boeblingen.de.ibm.com> <20060323203521.862355000@dyn-9-152-242-103.boeblingen.de.ibm.com> <1143152153.4257.28.camel@localhost.localdomain>
In-Reply-To: <1143152153.4257.28.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603241947.53301.arnd.bergmann@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: powerpc: use guarded ioremap for cell on-chip mappings

I'm not sure where the information came from, but I assumed
that doing cache-inhibited mappings for mmio regions was
sufficient.

It seems we also need the guarded bit set, like everyone
else, which is the default for ioremap.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

---
Index: linus-2.6/arch/powerpc/platforms/cell/interrupt.c
===================================================================
--- linus-2.6.orig/arch/powerpc/platforms/cell/interrupt.c
+++ linus-2.6/arch/powerpc/platforms/cell/interrupt.c
@@ -226,9 +226,7 @@ static int setup_iic_hardcoded(void)
 			regs += 0x20;
 
 		printk(KERN_INFO "IIC for CPU %d at %lx\n", cpu, regs);
-		iic->regs = __ioremap(regs, sizeof(struct iic_regs),
-				      _PAGE_NO_CACHE);
-
+		iic->regs = ioremap(regs, sizeof(struct iic_regs));
 		iic->target_id = (nodeid << 4) + ((cpu & 1) ? 0xf : 0xe);
 	}
 
@@ -269,14 +267,12 @@ static int setup_iic(void)
 		}
 
  		iic = &per_cpu(iic, np[0]);
- 		iic->regs = __ioremap(regs[0], sizeof(struct iic_regs),
- 				      _PAGE_NO_CACHE);
+ 		iic->regs = ioremap(regs[0], sizeof(struct iic_regs));
 		iic->target_id = ((np[0] & 2) << 3) + ((np[0] & 1) ? 0xf : 0xe);
  		printk("IIC for CPU %d at %lx mapped to %p\n", np[0], regs[0], iic->regs);
 
  		iic = &per_cpu(iic, np[1]);
- 		iic->regs = __ioremap(regs[2], sizeof(struct iic_regs),
- 				      _PAGE_NO_CACHE);
+ 		iic->regs = ioremap(regs[2], sizeof(struct iic_regs));
 		iic->target_id = ((np[1] & 2) << 3) + ((np[1] & 1) ? 0xf : 0xe);
  		printk("IIC for CPU %d at %lx mapped to %p\n", np[1], regs[2], iic->regs);
 
Index: linus-2.6/arch/powerpc/platforms/cell/iommu.c
===================================================================
--- linus-2.6.orig/arch/powerpc/platforms/cell/iommu.c
+++ linus-2.6/arch/powerpc/platforms/cell/iommu.c
@@ -344,8 +344,8 @@ static int cell_map_iommu_hardcoded(int 
 
 	/* node 0 */
 	iommu = &cell_iommus[0];
-	iommu->mapped_base = __ioremap(0x20000511000, 0x1000, _PAGE_NO_CACHE);
-	iommu->mapped_mmio_base = __ioremap(0x20000510000, 0x1000, _PAGE_NO_CACHE);
+	iommu->mapped_base = ioremap(0x20000511000, 0x1000);
+	iommu->mapped_mmio_base = ioremap(0x20000510000, 0x1000);
 
 	enable_mapping(iommu->mapped_base, iommu->mapped_mmio_base);
 
@@ -357,8 +357,8 @@ static int cell_map_iommu_hardcoded(int 
 
 	/* node 1 */
 	iommu = &cell_iommus[1];
-	iommu->mapped_base = __ioremap(0x30000511000, 0x1000, _PAGE_NO_CACHE);
-	iommu->mapped_mmio_base = __ioremap(0x30000510000, 0x1000, _PAGE_NO_CACHE);
+	iommu->mapped_base = ioremap(0x30000511000, 0x1000);
+	iommu->mapped_mmio_base = ioremap(0x30000510000, 0x1000);
 
 	enable_mapping(iommu->mapped_base, iommu->mapped_mmio_base);
 
@@ -407,8 +407,8 @@ static int cell_map_iommu(void)
 		iommu->base = *base;
 		iommu->mmio_base = *mmio_base;
 
-		iommu->mapped_base = __ioremap(*base, 0x1000, _PAGE_NO_CACHE);
-		iommu->mapped_mmio_base = __ioremap(*mmio_base, 0x1000, _PAGE_NO_CACHE);
+		iommu->mapped_base = ioremap(*base, 0x1000);
+		iommu->mapped_mmio_base = ioremap(*mmio_base, 0x1000);
 
 		enable_mapping(iommu->mapped_base,
 			       iommu->mapped_mmio_base);
Index: linus-2.6/arch/powerpc/platforms/cell/pervasive.c
===================================================================
--- linus-2.6.orig/arch/powerpc/platforms/cell/pervasive.c
+++ linus-2.6/arch/powerpc/platforms/cell/pervasive.c
@@ -203,7 +203,7 @@ found:
 
 	pr_debug("pervasive area for CPU %d at %lx, size %x\n",
 			cpu, real_address, size);
-	p->regs = __ioremap(real_address, size, _PAGE_NO_CACHE);
+	p->regs = ioremap(real_address, size);
 	p->thread = thread;
 	return 0;
 }
Index: linus-2.6/arch/powerpc/platforms/cell/spider-pic.c
===================================================================
--- linus-2.6.orig/arch/powerpc/platforms/cell/spider-pic.c
+++ linus-2.6/arch/powerpc/platforms/cell/spider-pic.c
@@ -159,7 +159,7 @@ void spider_init_IRQ_hardcoded(void)
 	for (node = 0; node < num_present_cpus()/2; node++) {
 		spiderpic = pics[node];
 		printk(KERN_DEBUG "SPIDER addr: %lx\n", spiderpic);
-		spider_pics[node] = __ioremap(spiderpic, 0x800, _PAGE_NO_CACHE);
+		spider_pics[node] = ioremap(spiderpic, 0x800);
 		for (n = 0; n < IIC_NUM_EXT; n++) {
 			int irq = n + IIC_EXT_OFFSET + node * IIC_NODE_STRIDE;
 			get_irq_desc(irq)->handler = &spider_pic;
@@ -210,7 +210,7 @@ void spider_init_IRQ(void)
 		if ( n != 2)
 			printk("reg property with invalid number of elements \n");
 
-		spider_pics[node] = __ioremap(spider_reg, 0x800, _PAGE_NO_CACHE);
+		spider_pics[node] = ioremap(spider_reg, 0x800);
 
 		printk("SPIDER addr: %lx with %i addr_cells mapped to %p\n",
 		       spider_reg, n, spider_pics[node]);
