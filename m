Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbVGSPdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbVGSPdL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 11:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbVGSPdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 11:33:11 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:11936 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261416AbVGSPdJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 11:33:09 -0400
Date: Wed, 20 Jul 2005 01:33:08 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: linux-kernel@vger.kernel.org
Cc: linuxppc64-dev@ozlabs.org, anton@samba.org
Subject: [PATCH] Re: RFC: IOMMU bypass
Message-Id: <20050720013308.2770521d.sfr@canb.auug.org.au>
In-Reply-To: <20050715130933.492ac904.sfr@canb.auug.org.au>
References: <20050715130933.492ac904.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

On Fri, 15 Jul 2005 13:09:33 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> We (Anton Blanchard and others) have been trying to figure out the best
> (or any) way to allow for IOMMU bypass when setting up DMA mappings on
> particular devices.  Our current idea is to hang a structure of pointers
> to DMA mapping operations off the struct device and inherit it from the
> device's parent.  This would allow for per-bus (rather than per-bus_type)
> mapping operations and also allow a driver to override the bus's
> operations for a particular device.
> 
> Does this make sense?  Comments (hopefully consructive) please.
> 
> Is there a better/simpler/more sensible way to do this?

Just to give you all something concrete to attack^Wcomment on, here is a
preliminary patch with the generic work and PPC64 converted.  It actually
helps ppc64 more than some others because we already have two different
"busses": pci and vio.

This has been built on both pSeries and iSeries ppc64 but not tested, yet.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN linus/arch/ppc64/kernel/Makefile linus-dma_bypass.3/arch/ppc64/kernel/Makefile
--- linus/arch/ppc64/kernel/Makefile	2005-06-27 16:08:00.000000000 +1000
+++ linus-dma_bypass.3/arch/ppc64/kernel/Makefile	2005-06-27 17:41:10.000000000 +1000
@@ -5,7 +5,7 @@
 EXTRA_CFLAGS	+= -mno-minimal-toc
 extra-y		:= head.o vmlinux.lds
 
-obj-y               :=	setup.o entry.o traps.o irq.o idle.o dma.o \
+obj-y               :=	setup.o entry.o traps.o irq.o idle.o \
 			time.o process.o signal.o syscalls.o misc.o ptrace.o \
 			align.o semaphore.o bitops.o pacaData.o \
 			udbg.o binfmt_elf32.o sys_ppc32.o ioctl32.o \
diff -ruN linus/arch/ppc64/kernel/bpa_iommu.c linus-dma_bypass.3/arch/ppc64/kernel/bpa_iommu.c
--- linus/arch/ppc64/kernel/bpa_iommu.c	2005-06-27 16:08:00.000000000 +1000
+++ linus-dma_bypass.3/arch/ppc64/kernel/bpa_iommu.c	2005-07-19 14:25:11.000000000 +1000
@@ -359,6 +359,11 @@
 	return mask < 0x100000000ull;
 }
 
+static int bpa_direct_set_dma_mask(struct device *dev, u64 mask)
+{
+	return pci_set_dma_mask(to_pci_dev(dev), mask);
+}
+
 void bpa_init_iommu(void)
 {
 	bpa_map_iommu();
@@ -374,4 +379,5 @@
 	pci_dma_ops.map_sg = bpa_map_sg;
 	pci_dma_ops.unmap_sg = bpa_unmap_sg;
 	pci_dma_ops.dma_supported = bpa_dma_supported;
+	pci_dma_ops.set_dma_mask = bpa_set_dma_mask;
 }
diff -ruN linus/arch/ppc64/kernel/dma.c linus-dma_bypass.3/arch/ppc64/kernel/dma.c
--- linus/arch/ppc64/kernel/dma.c	2005-06-27 16:08:00.000000000 +1000
+++ linus-dma_bypass.3/arch/ppc64/kernel/dma.c	1970-01-01 10:00:00.000000000 +1000
@@ -1,151 +0,0 @@
-/*
- * Copyright (C) 2004 IBM Corporation
- *
- * Implements the generic device dma API for ppc64. Handles
- * the pci and vio busses
- */
-
-#include <linux/device.h>
-#include <linux/dma-mapping.h>
-/* Include the busses we support */
-#include <linux/pci.h>
-#include <asm/vio.h>
-#include <asm/scatterlist.h>
-#include <asm/bug.h>
-
-static struct dma_mapping_ops *get_dma_ops(struct device *dev)
-{
-#ifdef CONFIG_PCI
-	if (dev->bus == &pci_bus_type)
-		return &pci_dma_ops;
-#endif
-#ifdef CONFIG_IBMVIO
-	if (dev->bus == &vio_bus_type)
-		return &vio_dma_ops;
-#endif
-	return NULL;
-}
-
-int dma_supported(struct device *dev, u64 mask)
-{
-	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
-
-	if (dma_ops)
-		return dma_ops->dma_supported(dev, mask);
-	BUG();
-	return 0;
-}
-EXPORT_SYMBOL(dma_supported);
-
-int dma_set_mask(struct device *dev, u64 dma_mask)
-{
-#ifdef CONFIG_PCI
-	if (dev->bus == &pci_bus_type)
-		return pci_set_dma_mask(to_pci_dev(dev), dma_mask);
-#endif
-#ifdef CONFIG_IBMVIO
-	if (dev->bus == &vio_bus_type)
-		return -EIO;
-#endif /* CONFIG_IBMVIO */
-	BUG();
-	return 0;
-}
-EXPORT_SYMBOL(dma_set_mask);
-
-void *dma_alloc_coherent(struct device *dev, size_t size,
-		dma_addr_t *dma_handle, unsigned int __nocast flag)
-{
-	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
-
-	if (dma_ops)
-		return dma_ops->alloc_coherent(dev, size, dma_handle, flag);
-	BUG();
-	return NULL;
-}
-EXPORT_SYMBOL(dma_alloc_coherent);
-
-void dma_free_coherent(struct device *dev, size_t size, void *cpu_addr,
-		dma_addr_t dma_handle)
-{
-	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
-
-	if (dma_ops)
-		dma_ops->free_coherent(dev, size, cpu_addr, dma_handle);
-	else
-		BUG();
-}
-EXPORT_SYMBOL(dma_free_coherent);
-
-dma_addr_t dma_map_single(struct device *dev, void *cpu_addr, size_t size,
-		enum dma_data_direction direction)
-{
-	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
-
-	if (dma_ops)
-		return dma_ops->map_single(dev, cpu_addr, size, direction);
-	BUG();
-	return (dma_addr_t)0;
-}
-EXPORT_SYMBOL(dma_map_single);
-
-void dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
-		enum dma_data_direction direction)
-{
-	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
-
-	if (dma_ops)
-		dma_ops->unmap_single(dev, dma_addr, size, direction);
-	else
-		BUG();
-}
-EXPORT_SYMBOL(dma_unmap_single);
-
-dma_addr_t dma_map_page(struct device *dev, struct page *page,
-		unsigned long offset, size_t size,
-		enum dma_data_direction direction)
-{
-	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
-
-	if (dma_ops)
-		return dma_ops->map_single(dev,
-				(page_address(page) + offset), size, direction);
-	BUG();
-	return (dma_addr_t)0;
-}
-EXPORT_SYMBOL(dma_map_page);
-
-void dma_unmap_page(struct device *dev, dma_addr_t dma_address, size_t size,
-		enum dma_data_direction direction)
-{
-	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
-
-	if (dma_ops)
-		dma_ops->unmap_single(dev, dma_address, size, direction);
-	else
-		BUG();
-}
-EXPORT_SYMBOL(dma_unmap_page);
-
-int dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
-		enum dma_data_direction direction)
-{
-	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
-
-	if (dma_ops)
-		return dma_ops->map_sg(dev, sg, nents, direction);
-	BUG();
-	return 0;
-}
-EXPORT_SYMBOL(dma_map_sg);
-
-void dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nhwentries,
-		enum dma_data_direction direction)
-{
-	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
-
-	if (dma_ops)
-		dma_ops->unmap_sg(dev, sg, nhwentries, direction);
-	else
-		BUG();
-}
-EXPORT_SYMBOL(dma_unmap_sg);
diff -ruN linus/arch/ppc64/kernel/pci.c linus-dma_bypass.3/arch/ppc64/kernel/pci.c
--- linus/arch/ppc64/kernel/pci.c	2005-06-29 11:08:36.000000000 +1000
+++ linus-dma_bypass.3/arch/ppc64/kernel/pci.c	2005-07-19 15:28:32.000000000 +1000
@@ -71,9 +71,6 @@
 
 LIST_HEAD(hose_list);
 
-struct dma_mapping_ops pci_dma_ops;
-EXPORT_SYMBOL(pci_dma_ops);
-
 int global_phb_number;		/* Global phb counter */
 
 /* Cached ISA bridge dev. */
diff -ruN linus/arch/ppc64/kernel/pci_direct_iommu.c linus-dma_bypass.3/arch/ppc64/kernel/pci_direct_iommu.c
--- linus/arch/ppc64/kernel/pci_direct_iommu.c	2005-06-27 16:08:00.000000000 +1000
+++ linus-dma_bypass.3/arch/ppc64/kernel/pci_direct_iommu.c	2005-07-19 15:35:04.000000000 +1000
@@ -83,6 +83,11 @@
 	return mask < 0x100000000ull;
 }
 
+static int pci_direct_set_dma_mask(struct device *dev, u64 mask)
+{
+	return pci_set_dma_mask(to_pci_dev(dev), mask);
+}
+
 void __init pci_direct_iommu_init(void)
 {
 	pci_dma_ops.alloc_coherent = pci_direct_alloc_coherent;
@@ -92,4 +97,5 @@
 	pci_dma_ops.map_sg = pci_direct_map_sg;
 	pci_dma_ops.unmap_sg = pci_direct_unmap_sg;
 	pci_dma_ops.dma_supported = pci_direct_dma_supported;
+	pci_dma_ops.set_dma_mask = pci_direct_set_dma_mask;
 }
diff -ruN linus/arch/ppc64/kernel/pci_iommu.c linus-dma_bypass.3/arch/ppc64/kernel/pci_iommu.c
--- linus/arch/ppc64/kernel/pci_iommu.c	2005-06-27 16:08:00.000000000 +1000
+++ linus-dma_bypass.3/arch/ppc64/kernel/pci_iommu.c	2005-07-19 15:35:26.000000000 +1000
@@ -127,6 +127,11 @@
 	return 1;
 }
 
+static int pci_iommu_set_dma_mask(struct device *dev, u64 mask)
+{
+	return pci_set_dma_mask(to_pci_dev(dev), mask);
+}
+
 void pci_iommu_init(void)
 {
 	pci_dma_ops.alloc_coherent = pci_iommu_alloc_coherent;
@@ -136,4 +141,5 @@
 	pci_dma_ops.map_sg = pci_iommu_map_sg;
 	pci_dma_ops.unmap_sg = pci_iommu_unmap_sg;
 	pci_dma_ops.dma_supported = pci_iommu_dma_supported;
+	pci_dma_ops.set_dma_mask = pci_iommu_set_dma_mask;
 }
diff -ruN linus/arch/ppc64/kernel/vio.c linus-dma_bypass.3/arch/ppc64/kernel/vio.c
--- linus/arch/ppc64/kernel/vio.c	2005-06-27 16:08:00.000000000 +1000
+++ linus-dma_bypass.3/arch/ppc64/kernel/vio.c	2005-07-19 15:45:05.000000000 +1000
@@ -45,6 +45,8 @@
 static struct iommu_table veth_iommu_table;
 static struct iommu_table vio_iommu_table;
 #endif
+static struct bus_type vio_bus_type;
+static struct dma_mapping_ops vio_dma_mapping_ops;
 static struct vio_dev vio_bus_device  = { /* fake "parent" device */
 	.name = vio_bus_device.dev.bus_id,
 	.type = "",
@@ -53,6 +55,7 @@
 #endif
 	.dev.bus_id = "vio",
 	.dev.bus = &vio_bus_type,
+	.dev.dma_mapping_ops = &vio_dma_mapping_ops,
 };
 
 #ifdef CONFIG_PPC_ISERIES
@@ -600,7 +603,12 @@
 	return 1;
 }
 
-struct dma_mapping_ops vio_dma_ops = {
+static int vio_set_dma_mask(struct device *dev, u64 mask)
+{
+	return -EIO;
+}
+
+static struct dma_mapping_ops vio_dma_mapping_ops = {
 	.alloc_coherent = vio_alloc_coherent,
 	.free_coherent = vio_free_coherent,
 	.map_single = vio_map_single,
@@ -608,6 +616,7 @@
 	.map_sg = vio_map_sg,
 	.unmap_sg = vio_unmap_sg,
 	.dma_supported = vio_dma_supported,
+	.set_dma_mask = vio_set_dma_mask,
 };
 
 static int vio_bus_match(struct device *dev, struct device_driver *drv)
@@ -629,7 +638,7 @@
 	return 0;
 }
 
-struct bus_type vio_bus_type = {
+static struct bus_type vio_bus_type = {
 	.name = "vio",
 	.match = vio_bus_match,
 };
diff -ruN linus/drivers/base/core.c linus-dma_bypass.3/drivers/base/core.c
--- linus/drivers/base/core.c	2005-07-01 09:58:50.000000000 +1000
+++ linus-dma_bypass.3/drivers/base/core.c	2005-07-19 15:18:22.000000000 +1000
@@ -251,6 +251,9 @@
 	if (parent)
 		klist_add_tail(&parent->klist_children, &dev->knode_parent);
 
+	if (parent && (dev->dma_mapping_ops == NULL))
+		dev->dma_mapping_ops = parent->dma_mapping_ops;
+
 	/* notify platform of device entry */
 	if (platform_notify)
 		platform_notify(dev);
diff -ruN linus/drivers/pci/probe.c linus-dma_bypass.3/drivers/pci/probe.c
--- linus/drivers/pci/probe.c	2005-07-06 21:18:22.000000000 +1000
+++ linus-dma_bypass.3/drivers/pci/probe.c	2005-07-19 15:43:37.000000000 +1000
@@ -9,6 +9,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/cpumask.h>
+#include <linux/dma-mapping.h>
 #include "pci.h"
 
 #define CARDBUS_LATENCY_TIMER	176	/* secondary latency timer */
@@ -22,6 +23,8 @@
 
 LIST_HEAD(pci_devices);
 
+struct dma_mapping_ops pci_dma_ops;
+
 #ifdef HAVE_PCI_LEGACY
 /**
  * pci_create_legacy_files - create legacy I/O port and memory files
@@ -915,6 +918,8 @@
 	dev->parent = parent;
 	dev->release = pci_release_bus_bridge_dev;
 	sprintf(dev->bus_id, "pci%04x:%02x", pci_domain_nr(b), bus);
+	if (parent == NULL)
+		dev->dma_mapping_ops = &pci_dma_ops;
 	error = device_register(dev);
 	if (error)
 		goto dev_reg_err;
diff -ruN linus/include/asm-ppc64/dma-mapping.h linus-dma_bypass.3/include/asm-ppc64/dma-mapping.h
--- linus/include/asm-ppc64/dma-mapping.h	2005-06-27 16:08:08.000000000 +1000
+++ linus-dma_bypass.3/include/asm-ppc64/dma-mapping.h	2005-07-19 13:47:08.000000000 +1000
@@ -16,25 +16,72 @@
 
 #define DMA_ERROR_CODE		(~(dma_addr_t)0x0)
 
-extern int dma_supported(struct device *dev, u64 mask);
-extern int dma_set_mask(struct device *dev, u64 dma_mask);
-extern void *dma_alloc_coherent(struct device *dev, size_t size,
-		dma_addr_t *dma_handle, unsigned int __nocast flag);
-extern void dma_free_coherent(struct device *dev, size_t size, void *cpu_addr,
-		dma_addr_t dma_handle);
-extern dma_addr_t dma_map_single(struct device *dev, void *cpu_addr,
-		size_t size, enum dma_data_direction direction);
-extern void dma_unmap_single(struct device *dev, dma_addr_t dma_addr,
-		size_t size, enum dma_data_direction direction);
-extern dma_addr_t dma_map_page(struct device *dev, struct page *page,
+static inline struct dma_mapping_ops *__get_dma_ops(struct device *dev)
+{
+	BUG_ON(dev->dma_mapping_ops == NULL);
+	return dev->dma_mapping_ops;
+}
+
+static inline int dma_supported(struct device *dev, u64 mask)
+{
+	return dev->dma_mapping_ops &&
+		__get_dma_ops(dev)->dma_supported(dev, mask);
+}
+
+static inline int dma_set_mask(struct device *dev, u64 dma_mask)
+{
+	return __get_dma_ops(dev)->set_dma_mask(dev, dma_mask);
+}
+
+static inline void *dma_alloc_coherent(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, unsigned int __nocast flag)
+{
+	return __get_dma_ops(dev)->alloc_coherent(dev, size, dma_handle, flag);
+}
+
+static inline void dma_free_coherent(struct device *dev, size_t size,
+		void *cpu_addr, dma_addr_t dma_handle)
+{
+	__get_dma_ops(dev)->free_coherent(dev, size, cpu_addr, dma_handle);
+}
+
+static inline dma_addr_t dma_map_single(struct device *dev, void *cpu_addr,
+		size_t size, enum dma_data_direction direction)
+{
+	return __get_dma_ops(dev)->map_single(dev, cpu_addr, size, direction);
+}
+
+static inline void dma_unmap_single(struct device *dev, dma_addr_t dma_addr,
+		size_t size, enum dma_data_direction direction)
+{
+	__get_dma_ops(dev)->unmap_single(dev, dma_addr, size, direction);
+}
+
+static inline dma_addr_t dma_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size,
-		enum dma_data_direction direction);
-extern void dma_unmap_page(struct device *dev, dma_addr_t dma_address,
-		size_t size, enum dma_data_direction direction);
-extern int dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
-		enum dma_data_direction direction);
-extern void dma_unmap_sg(struct device *dev, struct scatterlist *sg,
-		int nhwentries, enum dma_data_direction direction);
+		enum dma_data_direction direction)
+{
+	return __get_dma_ops(dev)->map_single(dev,
+			(page_address(page) + offset), size, direction);
+}
+
+static inline void dma_unmap_page(struct device *dev, dma_addr_t dma_address,
+		size_t size, enum dma_data_direction direction)
+{
+	__get_dma_ops(dev)->unmap_single(dev, dma_address, size, direction);
+}
+
+static inline int dma_map_sg(struct device *dev, struct scatterlist *sg,
+		int nents, enum dma_data_direction direction)
+{
+	return __get_dma_ops(dev)->map_sg(dev, sg, nents, direction);
+}
+
+static inline void dma_unmap_sg(struct device *dev, struct scatterlist *sg,
+		int nhwentries, enum dma_data_direction direction)
+{
+	__get_dma_ops(dev)->unmap_sg(dev, sg, nhwentries, direction);
+}
 
 static inline void
 dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle, size_t size,
@@ -113,24 +160,4 @@
 	/* nothing to do */
 }
 
-/*
- * DMA operations are abstracted for G5 vs. i/pSeries, PCI vs. VIO
- */
-struct dma_mapping_ops {
-	void *		(*alloc_coherent)(struct device *dev, size_t size,
-				dma_addr_t *dma_handle, unsigned int __nocast flag);
-	void		(*free_coherent)(struct device *dev, size_t size,
-				void *vaddr, dma_addr_t dma_handle);
-	dma_addr_t	(*map_single)(struct device *dev, void *ptr,
-				size_t size, enum dma_data_direction direction);
-	void		(*unmap_single)(struct device *dev, dma_addr_t dma_addr,
-				size_t size, enum dma_data_direction direction);
-	int		(*map_sg)(struct device *dev, struct scatterlist *sg,
-				int nents, enum dma_data_direction direction);
-	void		(*unmap_sg)(struct device *dev, struct scatterlist *sg,
-				int nents, enum dma_data_direction direction);
-	int		(*dma_supported)(struct device *dev, u64 mask);
-	int		(*dac_dma_supported)(struct device *dev, u64 mask);
-};
-
 #endif	/* _ASM_DMA_MAPPING_H */
diff -ruN linus/include/asm-ppc64/pci.h linus-dma_bypass.3/include/asm-ppc64/pci.h
--- linus/include/asm-ppc64/pci.h	2005-07-13 11:38:01.000000000 +1000
+++ linus-dma_bypass.3/include/asm-ppc64/pci.h	2005-07-19 15:55:23.000000000 +1000
@@ -66,15 +66,15 @@
 
 extern unsigned int pcibios_assign_all_busses(void);
 
-extern struct dma_mapping_ops pci_dma_ops;
-
 /* For DAC DMA, we currently don't support it by default, but
  * we let the platform override this
  */
 static inline int pci_dac_dma_supported(struct pci_dev *hwdev,u64 mask)
 {
+#if 0
 	if (pci_dma_ops.dac_dma_supported)
 		return pci_dma_ops.dac_dma_supported(&hwdev->dev, mask);
+#endif
 	return 0;
 }
 
diff -ruN linus/include/asm-ppc64/vio.h linus-dma_bypass.3/include/asm-ppc64/vio.h
--- linus/include/asm-ppc64/vio.h	2005-06-27 16:08:08.000000000 +1000
+++ linus-dma_bypass.3/include/asm-ppc64/vio.h	2005-06-27 17:40:50.000000000 +1000
@@ -57,10 +57,6 @@
 int vio_enable_interrupts(struct vio_dev *dev);
 int vio_disable_interrupts(struct vio_dev *dev);
 
-extern struct dma_mapping_ops vio_dma_ops;
-
-extern struct bus_type vio_bus_type;
-
 struct vio_device_id {
 	char *type;
 	char *compat;
diff -ruN linus/include/linux/device.h linus-dma_bypass.3/include/linux/device.h
--- linus/include/linux/device.h	2005-07-13 11:38:01.000000000 +1000
+++ linus-dma_bypass.3/include/linux/device.h	2005-07-19 13:44:49.000000000 +1000
@@ -45,6 +45,7 @@
 struct device_driver;
 struct class;
 struct class_device;
+struct dma_mapping_ops;
 
 struct bus_type {
 	const char		* name;
@@ -301,6 +302,7 @@
 
 	struct dma_coherent_mem	*dma_mem; /* internal for coherent mem
 					     override */
+	struct dma_mapping_ops	*dma_mapping_ops;
 
 	void	(*release)(struct device * dev);
 };
diff -ruN linus/include/linux/dma-mapping.h linus-dma_bypass.3/include/linux/dma-mapping.h
--- linus/include/linux/dma-mapping.h	2005-06-27 16:08:11.000000000 +1000
+++ linus-dma_bypass.3/include/linux/dma-mapping.h	2005-07-19 15:54:50.000000000 +1000
@@ -21,6 +21,28 @@
 #define DMA_30BIT_MASK	0x000000003fffffffULL
 #define DMA_29BIT_MASK	0x000000001fffffffULL
 
+struct scatterlist;
+
+/*
+ * DMA operations may be defined per bus or per device.
+ */
+struct dma_mapping_ops {
+	void *		(*alloc_coherent)(struct device *dev, size_t size,
+				dma_addr_t *dma_handle, unsigned int __nocast flag);
+	void		(*free_coherent)(struct device *dev, size_t size,
+				void *vaddr, dma_addr_t dma_handle);
+	dma_addr_t	(*map_single)(struct device *dev, void *ptr,
+				size_t size, enum dma_data_direction direction);
+	void		(*unmap_single)(struct device *dev, dma_addr_t dma_addr,
+				size_t size, enum dma_data_direction direction);
+	int		(*map_sg)(struct device *dev, struct scatterlist *sg,
+				int nents, enum dma_data_direction direction);
+	void		(*unmap_sg)(struct device *dev, struct scatterlist *sg,
+				int nents, enum dma_data_direction direction);
+	int		(*dma_supported)(struct device *dev, u64 mask);
+	int		(*set_dma_mask)(struct device *dev, u64 mask);
+};
+
 #include <asm/dma-mapping.h>
 
 /* Backwards compat, remove in 2.7.x */
diff -ruN linus/include/linux/pci.h linus-dma_bypass.3/include/linux/pci.h
--- linus/include/linux/pci.h	2005-07-06 21:18:22.000000000 +1000
+++ linus-dma_bypass.3/include/linux/pci.h	2005-07-19 15:42:03.000000000 +1000
@@ -18,6 +18,7 @@
 #define LINUX_PCI_H
 
 #include <linux/mod_devicetable.h>
+#include <linux/dma-mapping.h>
 
 /*
  * Under PCI, each device has 256 bytes of configuration address space,
@@ -722,6 +723,12 @@
 extern struct list_head pci_root_buses;	/* list of all known PCI buses */
 extern struct list_head pci_devices;	/* list of all devices */
 
+/*
+ * These DMA mapping ops will be applied to all discovered
+ * pci busses and inherited, by default, by all pci devices.
+ */
+extern struct dma_mapping_ops pci_dma_ops;
+
 void pcibios_fixup_bus(struct pci_bus *);
 int pcibios_enable_device(struct pci_dev *, int mask);
 char *pcibios_setup (char *str);
