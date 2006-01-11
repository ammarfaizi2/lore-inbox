Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbWAKWRF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbWAKWRF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 17:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbWAKWRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 17:17:04 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:48523 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751121AbWAKWRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 17:17:00 -0500
Date: Wed, 11 Jan 2006 16:16:48 -0600 (CST)
From: Mark Maule <maule@sgi.com>
To: linuxppc64-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tony Luck <tony.luck@intel.com>, gregkh@suse.de,
       Mark Maule <maule@sgi.com>
Message-Id: <20060111221648.28765.41741.34942@attica.americas.sgi.com>
In-Reply-To: <20060111221633.28765.95775.64741@attica.americas.sgi.com>
References: <20060111221633.28765.95775.64741@attica.americas.sgi.com>
Subject: [PATCH 3/3] altix:  msi support
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MSI callouts for altix.  Involves a fair amount of code reorg in sn irq.c
code as well as adding some extensions to the altix PCI provider abstaction.

Signed-off-by: Mark Maule <maule@sgi.com>

Index: linux-2.6.14/arch/ia64/sn/pci/msi.c
===================================================================
--- linux-2.6.14.orig/arch/ia64/sn/pci/msi.c	2005-12-21 22:37:02.978262311 -0600
+++ linux-2.6.14/arch/ia64/sn/pci/msi.c	2005-12-21 22:38:24.090685912 -0600
@@ -6,13 +6,205 @@
  * Copyright (C) 2005 Silicon Graphics, Inc.  All Rights Reserved.
  */
 
-#include <asm/errno.h>
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/cpumask.h>
+
+#include <asm/msi.h>
+
+#include <asm/sn/addrs.h>
+#include <asm/sn/intr.h>
+#include <asm/sn/pcibus_provider_defs.h>
+#include <asm/sn/pcidev.h>
+#include <asm/sn/nodepda.h>
+
+struct sn_msi_info {
+	u64 pci_addr;
+	struct sn_irq_info *sn_irq_info;
+};
+
+static struct sn_msi_info *sn_msi_info;
+
+static void
+sn_msi_teardown(unsigned int vector)
+{
+	nasid_t nasid;
+	int widget;
+	struct pci_dev *pdev;
+	struct pcidev_info *sn_pdev;
+	struct sn_irq_info *sn_irq_info;
+	struct pcibus_bussoft *bussoft;
+	struct sn_pcibus_provider *provider;
+
+	sn_irq_info = sn_msi_info[vector].sn_irq_info;
+	if (sn_irq_info == NULL || sn_irq_info->irq_int_bit >= 0)
+		return;
+
+	sn_pdev = (struct pcidev_info *)sn_irq_info->irq_pciioinfo;
+	pdev = sn_pdev->pdi_linux_pcidev;
+	provider = SN_PCIDEV_BUSPROVIDER(pdev);
+
+	(*provider->dma_unmap)(pdev,
+			       sn_msi_info[vector].pci_addr,
+			       PCI_DMA_FROMDEVICE);
+	sn_msi_info[vector].pci_addr = 0;
+
+	bussoft = SN_PCIDEV_BUSSOFT(pdev);
+	nasid = NASID_GET(bussoft->bs_base);
+	widget = (nasid & 1) ?
+			TIO_SWIN_WIDGETNUM(bussoft->bs_base) :
+			SWIN_WIDGETNUM(bussoft->bs_base);
+
+	sn_intr_free(nasid, widget, sn_irq_info);
+	sn_msi_info[vector].sn_irq_info = NULL;
+
+	return;
+}
 
 int
-sn_msi_init(void)
+sn_msi_setup(struct pci_dev *pdev, unsigned int vector,
+	     u32 *addr_hi, u32 *addr_lo, u32 *data)
 {
+	int widget;
+	int status;
+	nasid_t nasid;
+	u64 bus_addr;
+	struct sn_irq_info *sn_irq_info;
+	struct pcibus_bussoft *bussoft = SN_PCIDEV_BUSSOFT(pdev);
+	struct sn_pcibus_provider *provider = SN_PCIDEV_BUSPROVIDER(pdev);
+
+	if (bussoft == NULL)
+		return -EINVAL;
+
+	if (provider == NULL || provider->dma_map_consistent == NULL)
+		return -EINVAL;
+
+	/*
+	 * Set up the vector plumbing.  Let the prom (via sn_intr_alloc)
+	 * decide which cpu to direct this msi at by default.
+	 */
+
+	nasid = NASID_GET(bussoft->bs_base);
+	widget = (nasid & 1) ?
+			TIO_SWIN_WIDGETNUM(bussoft->bs_base) :
+			SWIN_WIDGETNUM(bussoft->bs_base);
+
+	sn_irq_info = kzalloc(sizeof(struct sn_irq_info), GFP_KERNEL);
+	if (! sn_irq_info)
+		return -ENOMEM;
+
+	status = sn_intr_alloc(nasid, widget, sn_irq_info, vector, -1, -1);
+	if (status) {
+		kfree(sn_irq_info);
+		return -ENOMEM;
+	}
+
+	sn_irq_info->irq_int_bit = -1;		/* mark this as an MSI irq */
+	sn_irq_fixup(pdev, sn_irq_info);
+
+	/* Prom probably should fill these in, but doesn't ... */
+	sn_irq_info->irq_bridge_type = bussoft->bs_asic_type;
+	sn_irq_info->irq_bridge = (void *)bussoft->bs_base;
+
 	/*
-	 * return error until MSI is supported on altix platforms
+	 * Map the xio address into bus space
 	 */
-	return -EINVAL;
+	bus_addr = (*provider->dma_map_consistent)(pdev,
+					sn_irq_info->irq_xtalkaddr,
+					sizeof(sn_irq_info->irq_xtalkaddr),
+					SN_DMA_MSI|SN_DMA_ADDR_XIO);
+	if (! bus_addr) {
+		sn_intr_free(nasid, widget, sn_irq_info);
+		kfree(sn_irq_info);
+		return -ENOMEM;
+	}
+
+	sn_msi_info[vector].sn_irq_info = sn_irq_info;
+	sn_msi_info[vector].pci_addr = bus_addr;
+
+	*addr_hi = (u32)(bus_addr >> 32);
+	*addr_lo = (u32)(bus_addr & 0x00000000ffffffff);
+
+	/*
+	 * In the SN platform, bit 16 is a "send vector" bit which
+	 * must be present in order to move the vector through the system.
+	 */
+	*data = 0x100 + (unsigned int)vector;
+
+#ifdef CONFIG_SMP
+	set_irq_affinity_info((vector & 0xff), sn_irq_info->irq_cpuid, 0);
+#endif
+
+	return 0;
+}
+
+static void
+sn_msi_target(unsigned int vector, unsigned int cpu,
+	      u32 *addr_hi, u32 *addr_lo)
+{
+	int slice;
+	nasid_t nasid;
+	u64 bus_addr;
+	struct pci_dev *pdev;
+	struct pcidev_info *sn_pdev;
+	struct sn_irq_info *sn_irq_info;
+	struct sn_irq_info *new_irq_info;
+	struct sn_pcibus_provider *provider;
+
+	sn_irq_info = sn_msi_info[vector].sn_irq_info;
+	if (sn_irq_info == NULL || sn_irq_info->irq_int_bit >= 0)
+		return;
+
+	/*
+	 * Release XIO resources for the old MSI PCI address
+	 */
+
+        sn_pdev = (struct pcidev_info *)sn_irq_info->irq_pciioinfo;
+	pdev = sn_pdev->pdi_linux_pcidev;
+	provider = SN_PCIDEV_BUSPROVIDER(pdev);
+
+	bus_addr = (u64)(*addr_hi) << 32 | (u64)(*addr_lo);
+	(*provider->dma_unmap)(pdev, bus_addr, PCI_DMA_FROMDEVICE);
+	sn_msi_info[vector].pci_addr = 0;
+
+	nasid = cpuid_to_nasid(cpu);
+	slice = cpuid_to_slice(cpu);
+
+	new_irq_info = sn_retarget_vector(sn_irq_info, nasid, slice);
+	sn_msi_info[vector].sn_irq_info = new_irq_info;
+	if (new_irq_info == NULL)
+		return;
+
+	/*
+	 * Map the xio address into bus space
+	 */
+
+	bus_addr = (*provider->dma_map_consistent)(pdev,
+					new_irq_info->irq_xtalkaddr,
+					sizeof(new_irq_info->irq_xtalkaddr),
+					SN_DMA_MSI|SN_DMA_ADDR_XIO);
+
+	sn_msi_info[vector].pci_addr = bus_addr;
+	*addr_hi = (u32)(bus_addr >> 32);
+	*addr_lo = (u32)(bus_addr & 0x00000000ffffffff);
+}
+
+struct msi_ops sn_msi_ops = {
+	.setup = sn_msi_setup,
+	.teardown = sn_msi_teardown,
+#ifdef CONFIG_SMP
+	.target = sn_msi_target,
+#endif
+};
+
+int
+sn_msi_init(void)
+{
+	sn_msi_info =
+		kzalloc(sizeof(struct sn_msi_info) * NR_VECTORS, GFP_KERNEL);
+	if (! sn_msi_info)
+		return -ENOMEM;
+
+	msi_register(&sn_msi_ops);
+	return 0;
 }
Index: linux-2.6.14/arch/ia64/sn/kernel/io_init.c
===================================================================
--- linux-2.6.14.orig/arch/ia64/sn/kernel/io_init.c	2005-12-21 22:35:23.436286704 -0600
+++ linux-2.6.14/arch/ia64/sn/kernel/io_init.c	2005-12-21 22:38:24.091685671 -0600
@@ -51,7 +51,7 @@
  */
 
 static dma_addr_t
-sn_default_pci_map(struct pci_dev *pdev, unsigned long paddr, size_t size)
+sn_default_pci_map(struct pci_dev *pdev, unsigned long paddr, size_t size, int type)
 {
 	return 0;
 }
Index: linux-2.6.14/arch/ia64/sn/kernel/irq.c
===================================================================
--- linux-2.6.14.orig/arch/ia64/sn/kernel/irq.c	2005-12-21 22:37:58.120953676 -0600
+++ linux-2.6.14/arch/ia64/sn/kernel/irq.c	2005-12-21 22:38:24.092685429 -0600
@@ -25,11 +25,11 @@
 
 int sn_force_interrupt_flag = 1;
 extern int sn_ioif_inited;
-static struct list_head **sn_irq_lh;
+struct list_head **sn_irq_lh;
 static spinlock_t sn_irq_info_lock = SPIN_LOCK_UNLOCKED; /* non-IRQ lock */
 
-static inline uint64_t sn_intr_alloc(nasid_t local_nasid, int local_widget,
-				     u64 sn_irq_info,
+uint64_t sn_intr_alloc(nasid_t local_nasid, int local_widget,
+				     struct sn_irq_info *sn_irq_info,
 				     int req_irq, nasid_t req_nasid,
 				     int req_slice)
 {
@@ -39,12 +39,13 @@
 
 	SAL_CALL_NOLOCK(ret_stuff, (u64) SN_SAL_IOIF_INTERRUPT,
 			(u64) SAL_INTR_ALLOC, (u64) local_nasid,
-			(u64) local_widget, (u64) sn_irq_info, (u64) req_irq,
+			(u64) local_widget, __pa(sn_irq_info), (u64) req_irq,
 			(u64) req_nasid, (u64) req_slice);
+
 	return ret_stuff.status;
 }
 
-static inline void sn_intr_free(nasid_t local_nasid, int local_widget,
+void sn_intr_free(nasid_t local_nasid, int local_widget,
 				struct sn_irq_info *sn_irq_info)
 {
 	struct ia64_sal_retval ret_stuff;
@@ -113,73 +114,91 @@
 
 static void sn_irq_info_free(struct rcu_head *head);
 
-static void sn_set_affinity_irq(unsigned int irq, cpumask_t mask)
+struct sn_irq_info *sn_retarget_vector(struct sn_irq_info *sn_irq_info,
+				       nasid_t nasid, int slice)
 {
-	struct sn_irq_info *sn_irq_info, *sn_irq_info_safe;
-	int cpuid, cpuphys;
+	int vector;
+	int cpuphys;
+	int64_t bridge;
+	int local_widget, status;
+	nasid_t local_nasid;
+	struct sn_irq_info *new_irq_info;
+	struct sn_pcibus_provider *pci_provider;
 
-	cpuid = first_cpu(mask);
-	cpuphys = cpu_physical_id(cpuid);
+	new_irq_info = kmalloc(sizeof(struct sn_irq_info), GFP_ATOMIC);
+	if (new_irq_info == NULL)
+		return NULL;
 
-	list_for_each_entry_safe(sn_irq_info, sn_irq_info_safe,
-				 sn_irq_lh[irq], list) {
-		uint64_t bridge;
-		int local_widget, status;
-		nasid_t local_nasid;
-		struct sn_irq_info *new_irq_info;
-		struct sn_pcibus_provider *pci_provider;
-
-		new_irq_info = kmalloc(sizeof(struct sn_irq_info), GFP_ATOMIC);
-		if (new_irq_info == NULL)
-			break;
-		memcpy(new_irq_info, sn_irq_info, sizeof(struct sn_irq_info));
-
-		bridge = (uint64_t) new_irq_info->irq_bridge;
-		if (!bridge) {
-			kfree(new_irq_info);
-			break; /* irq is not a device interrupt */
-		}
+	memcpy(new_irq_info, sn_irq_info, sizeof(struct sn_irq_info));
 
-		local_nasid = NASID_GET(bridge);
+	bridge = (uint64_t) new_irq_info->irq_bridge;
+	if (!bridge) {
+		kfree(new_irq_info);
+		return NULL; /* irq is not a device interrupt */
+	}
 
-		if (local_nasid & 1)
-			local_widget = TIO_SWIN_WIDGETNUM(bridge);
-		else
-			local_widget = SWIN_WIDGETNUM(bridge);
-
-		/* Free the old PROM new_irq_info structure */
-		sn_intr_free(local_nasid, local_widget, new_irq_info);
-		/* Update kernels new_irq_info with new target info */
-		unregister_intr_pda(new_irq_info);
-
-		/* allocate a new PROM new_irq_info struct */
-		status = sn_intr_alloc(local_nasid, local_widget,
-				       __pa(new_irq_info), irq,
-				       cpuid_to_nasid(cpuid),
-				       cpuid_to_slice(cpuid));
-
-		/* SAL call failed */
-		if (status) {
-			kfree(new_irq_info);
-			break;
-		}
+	local_nasid = NASID_GET(bridge);
 
-		new_irq_info->irq_cpuid = cpuid;
-		register_intr_pda(new_irq_info);
+	if (local_nasid & 1)
+		local_widget = TIO_SWIN_WIDGETNUM(bridge);
+	else
+		local_widget = SWIN_WIDGETNUM(bridge);
 
-		pci_provider = sn_pci_provider[new_irq_info->irq_bridge_type];
-		if (pci_provider && pci_provider->target_interrupt)
-			(pci_provider->target_interrupt)(new_irq_info);
-
-		spin_lock(&sn_irq_info_lock);
-		list_replace_rcu(&sn_irq_info->list, &new_irq_info->list);
-		spin_unlock(&sn_irq_info_lock);
-		call_rcu(&sn_irq_info->rcu, sn_irq_info_free);
+	vector = sn_irq_info->irq_irq;
+	/* Free the old PROM new_irq_info structure */
+	sn_intr_free(local_nasid, local_widget, new_irq_info);
+	/* Update kernels new_irq_info with new target info */
+	unregister_intr_pda(new_irq_info);
+
+	/* allocate a new PROM new_irq_info struct */
+	status = sn_intr_alloc(local_nasid, local_widget,
+			       new_irq_info, vector,
+			       nasid, slice);
+
+	/* SAL call failed */
+	if (status) {
+		kfree(new_irq_info);
+		return NULL;
+	}
+
+	cpuphys = nasid_slice_to_cpuid(nasid, slice);
+	new_irq_info->irq_cpuid = cpuphys;
+	register_intr_pda(new_irq_info);
+
+	pci_provider = sn_pci_provider[new_irq_info->irq_bridge_type];
+
+	/*
+	 * If this represents a line interrupt, target it.  If it's
+	 * an msi (irq_int_bit < 0), it's already targeted.
+	 */
+	if (new_irq_info->irq_int_bit >= 0 &&
+	    pci_provider && pci_provider->target_interrupt)
+		(pci_provider->target_interrupt)(new_irq_info);
+
+	spin_lock(&sn_irq_info_lock);
+	list_replace_rcu(&sn_irq_info->list, &new_irq_info->list);
+	spin_unlock(&sn_irq_info_lock);
+	call_rcu(&sn_irq_info->rcu, sn_irq_info_free);
 
 #ifdef CONFIG_SMP
-		set_irq_affinity_info((irq & 0xff), cpuphys, 0);
+	set_irq_affinity_info((vector & 0xff), cpuphys, 0);
 #endif
-	}
+
+	return new_irq_info;
+}
+
+static void sn_set_affinity_irq(unsigned int irq, cpumask_t mask)
+{
+	struct sn_irq_info *sn_irq_info, *sn_irq_info_safe;
+	nasid_t nasid;
+	int slice;
+
+	nasid = cpuid_to_nasid(first_cpu(mask));
+	slice = cpuid_to_slice(first_cpu(mask));
+
+	list_for_each_entry_safe(sn_irq_info, sn_irq_info_safe,
+				 sn_irq_lh[irq], list)
+		(void)sn_retarget_vector(sn_irq_info, nasid, slice);
 }
 
 struct hw_interrupt_type irq_type_sn = {
@@ -441,5 +460,4 @@
 
 		INIT_LIST_HEAD(sn_irq_lh[i]);
 	}
-
 }
Index: linux-2.6.14/arch/ia64/sn/pci/pci_dma.c
===================================================================
--- linux-2.6.14.orig/arch/ia64/sn/pci/pci_dma.c	2005-12-21 22:35:23.446284291 -0600
+++ linux-2.6.14/arch/ia64/sn/pci/pci_dma.c	2005-12-21 22:38:24.092685429 -0600
@@ -11,7 +11,7 @@
 
 #include <linux/module.h>
 #include <asm/dma.h>
-#include <asm/sn/pcibr_provider.h>
+#include <asm/sn/intr.h>
 #include <asm/sn/pcibus_provider_defs.h>
 #include <asm/sn/pcidev.h>
 #include <asm/sn/sn_sal.h>
@@ -113,7 +113,8 @@
 	 * resources.
 	 */
 
-	*dma_handle = provider->dma_map_consistent(pdev, phys_addr, size);
+	*dma_handle = provider->dma_map_consistent(pdev, phys_addr, size,
+						   SN_DMA_ADDR_PHYS);
 	if (!*dma_handle) {
 		printk(KERN_ERR "%s: out of ATEs\n", __FUNCTION__);
 		free_pages((unsigned long)cpuaddr, get_order(size));
@@ -176,7 +177,7 @@
 	BUG_ON(dev->bus != &pci_bus_type);
 
 	phys_addr = __pa(cpu_addr);
-	dma_addr = provider->dma_map(pdev, phys_addr, size);
+	dma_addr = provider->dma_map(pdev, phys_addr, size, SN_DMA_ADDR_PHYS);
 	if (!dma_addr) {
 		printk(KERN_ERR "%s: out of ATEs\n", __FUNCTION__);
 		return 0;
@@ -260,7 +261,8 @@
 	for (i = 0; i < nhwentries; i++, sg++) {
 		phys_addr = SG_ENT_PHYS_ADDRESS(sg);
 		sg->dma_address = provider->dma_map(pdev,
-						    phys_addr, sg->length);
+						    phys_addr, sg->length,
+						    SN_DMA_ADDR_PHYS);
 
 		if (!sg->dma_address) {
 			printk(KERN_ERR "%s: out of ATEs\n", __FUNCTION__);
Index: linux-2.6.14/arch/ia64/sn/pci/pcibr/pcibr_dma.c
===================================================================
--- linux-2.6.14.orig/arch/ia64/sn/pci/pcibr/pcibr_dma.c	2005-12-21 22:35:23.445284532 -0600
+++ linux-2.6.14/arch/ia64/sn/pci/pcibr/pcibr_dma.c	2005-12-21 22:38:24.093685188 -0600
@@ -41,7 +41,7 @@
 
 static dma_addr_t
 pcibr_dmamap_ate32(struct pcidev_info *info,
-		   uint64_t paddr, size_t req_size, uint64_t flags)
+		   uint64_t paddr, size_t req_size, uint64_t flags, int dma_flags)
 {
 
 	struct pcidev_info *pcidev_info = info->pdi_host_pcidev_info;
@@ -81,9 +81,12 @@
 	if (IS_PCIX(pcibus_info))
 		ate_flags &= ~(PCI32_ATE_PREF);
 
-	xio_addr =
-	    IS_PIC_SOFT(pcibus_info) ? PHYS_TO_DMA(paddr) :
-	    PHYS_TO_TIODMA(paddr);
+	if (SN_DMA_ADDRTYPE(dma_flags == SN_DMA_ADDR_PHYS))
+		xio_addr = IS_PIC_SOFT(pcibus_info) ? PHYS_TO_DMA(paddr) :
+	    					      PHYS_TO_TIODMA(paddr);
+	else
+		xio_addr = paddr;
+
 	offset = IOPGOFF(xio_addr);
 	ate = ate_flags | (xio_addr - offset);
 
@@ -91,6 +94,13 @@
 	if (IS_PIC_SOFT(pcibus_info)) {
 		ate |= (pcibus_info->pbi_hub_xid << PIC_ATE_TARGETID_SHFT);
 	}
+
+	/*
+	 * If we're mapping for MSI, set the MSI bit in the ATE
+	 */
+	if (dma_flags & SN_DMA_MSI)
+		ate |= PCI32_ATE_MSI;
+
 	ate_write(pcibus_info, ate_index, ate_count, ate);
 
 	/*
@@ -105,20 +115,27 @@
 	if (pcibus_info->pbi_devreg[internal_device] & PCIBR_DEV_SWAP_DIR)
 		ATE_SWAP_ON(pci_addr);
 
+
 	return pci_addr;
 }
 
 static dma_addr_t
 pcibr_dmatrans_direct64(struct pcidev_info * info, uint64_t paddr,
-			uint64_t dma_attributes)
+			uint64_t dma_attributes, int dma_flags)
 {
 	struct pcibus_info *pcibus_info = (struct pcibus_info *)
 	    ((info->pdi_host_pcidev_info)->pdi_pcibus_info);
 	uint64_t pci_addr;
 
 	/* Translate to Crosstalk View of Physical Address */
-	pci_addr = (IS_PIC_SOFT(pcibus_info) ? PHYS_TO_DMA(paddr) :
-		    PHYS_TO_TIODMA(paddr)) | dma_attributes;
+	if (SN_DMA_ADDRTYPE(dma_flags) == SN_DMA_ADDR_PHYS)
+		pci_addr = IS_PIC_SOFT(pcibus_info) ?
+				PHYS_TO_DMA(paddr) :
+		    		PHYS_TO_TIODMA(paddr) | dma_attributes;
+	else
+		pci_addr = IS_PIC_SOFT(pcibus_info) ?
+				paddr :
+				paddr | dma_attributes;
 
 	/* Handle Bus mode */
 	if (IS_PCIX(pcibus_info))
@@ -130,7 +147,9 @@
 		    ((uint64_t) pcibus_info->
 		     pbi_hub_xid << PIC_PCI64_ATTR_TARG_SHFT);
 	} else
-		pci_addr |= TIOCP_PCI64_CMDTYPE_MEM;
+		pci_addr |= (dma_flags & SN_DMA_MSI) ?
+				TIOCP_PCI64_CMDTYPE_MSI :
+				TIOCP_PCI64_CMDTYPE_MEM;
 
 	/* If PCI mode, func zero uses VCHAN0, every other func uses VCHAN1 */
 	if (!IS_PCIX(pcibus_info) && PCI_FUNC(info->pdi_linux_pcidev->devfn))
@@ -142,7 +161,7 @@
 
 static dma_addr_t
 pcibr_dmatrans_direct32(struct pcidev_info * info,
-			uint64_t paddr, size_t req_size, uint64_t flags)
+			uint64_t paddr, size_t req_size, uint64_t flags, int dma_flags)
 {
 
 	struct pcidev_info *pcidev_info = info->pdi_host_pcidev_info;
@@ -158,8 +177,14 @@
 		return 0;
 	}
 
-	xio_addr = IS_PIC_SOFT(pcibus_info) ? PHYS_TO_DMA(paddr) :
-	    PHYS_TO_TIODMA(paddr);
+	if (dma_flags & SN_DMA_MSI)
+		return 0;
+
+	if (SN_DMA_ADDRTYPE(dma_flags) == SN_DMA_ADDR_PHYS)
+		xio_addr = IS_PIC_SOFT(pcibus_info) ? PHYS_TO_DMA(paddr) :
+	    					      PHYS_TO_TIODMA(paddr);
+	else
+		xio_addr = paddr;
 
 	xio_base = pcibus_info->pbi_dir_xbase;
 	offset = xio_addr - xio_base;
@@ -331,7 +356,7 @@
  */
 
 dma_addr_t
-pcibr_dma_map(struct pci_dev * hwdev, unsigned long phys_addr, size_t size)
+pcibr_dma_map(struct pci_dev * hwdev, unsigned long phys_addr, size_t size, int dma_flags)
 {
 	dma_addr_t dma_handle;
 	struct pcidev_info *pcidev_info = SN_PCIDEV_INFO(hwdev);
@@ -348,11 +373,11 @@
 		 */
 
 		dma_handle = pcibr_dmatrans_direct64(pcidev_info, phys_addr,
-						     PCI64_ATTR_PREF);
+						     PCI64_ATTR_PREF, dma_flags);
 	} else {
 		/* Handle 32-63 bit cards via direct mapping */
 		dma_handle = pcibr_dmatrans_direct32(pcidev_info, phys_addr,
-						     size, 0);
+						     size, 0, dma_flags);
 		if (!dma_handle) {
 			/*
 			 * It is a 32 bit card and we cannot do direct mapping,
@@ -360,7 +385,8 @@
 			 */
 
 			dma_handle = pcibr_dmamap_ate32(pcidev_info, phys_addr,
-							size, PCI32_ATE_PREF);
+							size, PCI32_ATE_PREF,
+							dma_flags);
 		}
 	}
 
@@ -369,18 +395,18 @@
 
 dma_addr_t
 pcibr_dma_map_consistent(struct pci_dev * hwdev, unsigned long phys_addr,
-			 size_t size)
+			 size_t size, int dma_flags)
 {
 	dma_addr_t dma_handle;
 	struct pcidev_info *pcidev_info = SN_PCIDEV_INFO(hwdev);
 
 	if (hwdev->dev.coherent_dma_mask == ~0UL) {
 		dma_handle = pcibr_dmatrans_direct64(pcidev_info, phys_addr,
-					    PCI64_ATTR_BAR);
+					    PCI64_ATTR_BAR, dma_flags);
 	} else {
 		dma_handle = (dma_addr_t) pcibr_dmamap_ate32(pcidev_info,
 						    phys_addr, size,
-						    PCI32_ATE_BAR);
+						    PCI32_ATE_BAR, dma_flags);
 	}
 
 	return dma_handle;
Index: linux-2.6.14/arch/ia64/sn/pci/tioca_provider.c
===================================================================
--- linux-2.6.14.orig/arch/ia64/sn/pci/tioca_provider.c	2005-12-21 22:35:23.446284291 -0600
+++ linux-2.6.14/arch/ia64/sn/pci/tioca_provider.c	2005-12-21 22:38:24.093685188 -0600
@@ -515,11 +515,17 @@
  * use the GART mapped mode.
  */
 static uint64_t
-tioca_dma_map(struct pci_dev *pdev, uint64_t paddr, size_t byte_count)
+tioca_dma_map(struct pci_dev *pdev, uint64_t paddr, size_t byte_count, int dma_flags)
 {
 	uint64_t mapaddr;
 
 	/*
+	 * Not supported for now ...
+	 */
+	if (dma_flags & SN_DMA_MSI)
+		return 0;
+
+	/*
 	 * If card is 64 or 48 bit addresable, use a direct mapping.  32
 	 * bit direct is so restrictive w.r.t. where the memory resides that
 	 * we don't use it even though CA has some support.
Index: linux-2.6.14/arch/ia64/sn/pci/tioce_provider.c
===================================================================
--- linux-2.6.14.orig/arch/ia64/sn/pci/tioce_provider.c	2005-12-21 22:35:23.445284532 -0600
+++ linux-2.6.14/arch/ia64/sn/pci/tioce_provider.c	2005-12-21 22:38:24.094684947 -0600
@@ -52,7 +52,8 @@
 	(ATE_PAGE((start)+(len)-1, pagesize) - ATE_PAGE(start, pagesize) + 1)
 
 #define ATE_VALID(ate)	((ate) & (1UL << 63))
-#define ATE_MAKE(addr, ps) (((addr) & ~ATE_PAGEMASK(ps)) | (1UL << 63))
+#define ATE_MAKE(addr, ps, msi) \
+	(((addr) & ~ATE_PAGEMASK(ps)) | (1UL << 63) | ((msi)?(1UL << 62):0))
 
 /*
  * Flavors of ate-based mapping supported by tioce_alloc_map()
@@ -78,15 +79,17 @@
  *
  * 63    - must be 1 to indicate d64 mode to CE hardware
  * 62    - barrier bit ... controlled with tioce_dma_barrier()
- * 61    - 0 since this is not an MSI transaction
+ * 61    - msi bit ... specified through dma_flags
  * 60:54 - reserved, MBZ
  */
 static uint64_t
-tioce_dma_d64(unsigned long ct_addr)
+tioce_dma_d64(unsigned long ct_addr, int dma_flags)
 {
 	uint64_t bus_addr;
 
 	bus_addr = ct_addr | (1UL << 63);
+	if (dma_flags & SN_DMA_MSI)
+		bus_addr |= (1UL << 61);
 
 	return bus_addr;
 }
@@ -143,7 +146,7 @@
  */
 static uint64_t
 tioce_alloc_map(struct tioce_kernel *ce_kern, int type, int port,
-		uint64_t ct_addr, int len)
+		uint64_t ct_addr, int len, int dma_flags)
 {
 	int i;
 	int j;
@@ -152,6 +155,7 @@
 	int entries;
 	int nates;
 	int pagesize;
+	int msi_capable, msi_wanted;
 	uint64_t *ate_shadow;
 	uint64_t *ate_reg;
 	uint64_t addr;
@@ -173,6 +177,7 @@
 		ate_reg = ce_mmr->ce_ure_ate3240;
 		pagesize = ce_kern->ce_ate3240_pagesize;
 		bus_base = TIOCE_M32_MIN;
+		msi_capable = 1;
 		break;
 	case TIOCE_ATE_M40:
 		first = 0;
@@ -181,6 +186,7 @@
 		ate_reg = ce_mmr->ce_ure_ate40;
 		pagesize = MB(64);
 		bus_base = TIOCE_M40_MIN;
+		msi_capable = 0;
 		break;
 	case TIOCE_ATE_M40S:
 		/*
@@ -193,11 +199,16 @@
 		ate_reg = ce_mmr->ce_ure_ate3240;
 		pagesize = GB(16);
 		bus_base = TIOCE_M40S_MIN;
+		msi_capable = 0;
 		break;
 	default:
 		return 0;
 	}
 
+	msi_wanted = dma_flags & SN_DMA_MSI;
+	if (msi_wanted && !msi_capable)
+		return 0;
+
 	nates = ATE_NPAGES(ct_addr, len, pagesize);
 	if (nates > entries)
 		return 0;
@@ -226,7 +237,7 @@
 	for (j = 0; j < nates; j++) {
 		uint64_t ate;
 
-		ate = ATE_MAKE(addr, pagesize);
+		ate = ATE_MAKE(addr, pagesize, msi_wanted);
 		ate_shadow[i + j] = ate;
 		writeq(ate, &ate_reg[i + j]);
 		addr += pagesize;
@@ -253,7 +264,7 @@
  * Map @paddr into 32-bit bus space of the CE associated with @pcidev_info.
  */
 static uint64_t
-tioce_dma_d32(struct pci_dev *pdev, uint64_t ct_addr)
+tioce_dma_d32(struct pci_dev *pdev, uint64_t ct_addr, int dma_flags)
 {
 	int dma_ok;
 	int port;
@@ -263,6 +274,9 @@
 	uint64_t ct_lower;
 	dma_addr_t bus_addr;
 
+	if (dma_flags & SN_DMA_MSI)
+		return 0;
+
 	ct_upper = ct_addr & ~0x3fffffffUL;
 	ct_lower = ct_addr & 0x3fffffffUL;
 
@@ -387,7 +401,7 @@
  */
 static uint64_t
 tioce_do_dma_map(struct pci_dev *pdev, uint64_t paddr, size_t byte_count,
-		 int barrier)
+		 int barrier, int dma_flags)
 {
 	unsigned long flags;
 	uint64_t ct_addr;
@@ -403,15 +417,18 @@
 	if (dma_mask < 0x7fffffffUL)
 		return 0;
 
-	ct_addr = PHYS_TO_TIODMA(paddr);
+	if (SN_DMA_ADDRTYPE(dma_flags) == SN_DMA_ADDR_PHYS)
+		ct_addr = PHYS_TO_TIODMA(paddr);
+	else
+		ct_addr = paddr;
 
 	/*
 	 * If the device can generate 64 bit addresses, create a D64 map.
-	 * Since this should never fail, bypass the rest of the checks.
 	 */
 	if (dma_mask == ~0UL) {
-		mapaddr = tioce_dma_d64(ct_addr);
-		goto dma_map_done;
+		mapaddr = tioce_dma_d64(ct_addr, dma_flags);
+		if (mapaddr)
+			goto dma_map_done;
 	}
 
 	pcidev_to_tioce(pdev, NULL, &ce_kern, &port);
@@ -454,18 +471,22 @@
 
 		if (byte_count > MB(64)) {
 			mapaddr = tioce_alloc_map(ce_kern, TIOCE_ATE_M40S,
-						  port, ct_addr, byte_count);
+						  port, ct_addr, byte_count,
+						  dma_flags);
 			if (!mapaddr)
 				mapaddr =
 				    tioce_alloc_map(ce_kern, TIOCE_ATE_M40, -1,
-						    ct_addr, byte_count);
+						    ct_addr, byte_count,
+						    dma_flags);
 		} else {
 			mapaddr = tioce_alloc_map(ce_kern, TIOCE_ATE_M40, -1,
-						  ct_addr, byte_count);
+						  ct_addr, byte_count,
+						  dma_flags);
 			if (!mapaddr)
 				mapaddr =
 				    tioce_alloc_map(ce_kern, TIOCE_ATE_M40S,
-						    port, ct_addr, byte_count);
+						    port, ct_addr, byte_count,
+						    dma_flags);
 		}
 	}
 
@@ -473,7 +494,7 @@
 	 * 32-bit direct is the next mode to try
 	 */
 	if (!mapaddr && dma_mask >= 0xffffffffUL)
-		mapaddr = tioce_dma_d32(pdev, ct_addr);
+		mapaddr = tioce_dma_d32(pdev, ct_addr, dma_flags);
 
 	/*
 	 * Last resort, try 32-bit ATE-based map.
@@ -481,12 +502,12 @@
 	if (!mapaddr)
 		mapaddr =
 		    tioce_alloc_map(ce_kern, TIOCE_ATE_M32, -1, ct_addr,
-				    byte_count);
+				    byte_count, dma_flags);
 
 	spin_unlock_irqrestore(&ce_kern->ce_lock, flags);
 
 dma_map_done:
-	if (mapaddr & barrier)
+	if (mapaddr && barrier)
 		mapaddr = tioce_dma_barrier(mapaddr, 1);
 
 	return mapaddr;
@@ -502,9 +523,9 @@
  * in the address.
  */
 static uint64_t
-tioce_dma(struct pci_dev *pdev, uint64_t paddr, size_t byte_count)
+tioce_dma(struct pci_dev *pdev, uint64_t paddr, size_t byte_count, int dma_flags)
 {
-	return tioce_do_dma_map(pdev, paddr, byte_count, 0);
+	return tioce_do_dma_map(pdev, paddr, byte_count, 0, dma_flags);
 }
 
 /**
@@ -516,9 +537,9 @@
  * Simply call tioce_do_dma_map() to create a map with the barrier bit set
  * in the address.
  */ static uint64_t
-tioce_dma_consistent(struct pci_dev *pdev, uint64_t paddr, size_t byte_count)
+tioce_dma_consistent(struct pci_dev *pdev, uint64_t paddr, size_t byte_count, int dma_flags)
 {
-	return tioce_do_dma_map(pdev, paddr, byte_count, 1);
+	return tioce_do_dma_map(pdev, paddr, byte_count, 1, dma_flags);
 }
 
 /**
Index: linux-2.6.14/include/asm-ia64/sn/intr.h
===================================================================
--- linux-2.6.14.orig/include/asm-ia64/sn/intr.h	2005-12-21 22:35:23.446284291 -0600
+++ linux-2.6.14/include/asm-ia64/sn/intr.h	2005-12-21 22:38:24.094684947 -0600
@@ -3,13 +3,14 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 1992 - 1997, 2000-2004 Silicon Graphics, Inc. All rights reserved.
+ * Copyright (C) 1992 - 1997, 2000-2005 Silicon Graphics, Inc. All rights reserved.
  */
 
 #ifndef _ASM_IA64_SN_INTR_H
 #define _ASM_IA64_SN_INTR_H
 
 #include <linux/rcupdate.h>
+#include <asm/sn/types.h>
 
 #define SGI_UART_VECTOR		(0xe9)
 
@@ -40,6 +41,7 @@
 	int		irq_cpuid;	/* kernel logical cpuid	     */
 	int		irq_irq;	/* the IRQ number */
 	int		irq_int_bit;	/* Bridge interrupt pin */
+					/* <0 means MSI */
 	uint64_t	irq_xtalkaddr;	/* xtalkaddr IRQ is sent to  */
 	int		irq_bridge_type;/* pciio asic type (pciio.h) */
 	void	       *irq_bridge;	/* bridge generating irq     */
@@ -53,6 +55,12 @@
 };
 
 extern void sn_send_IPI_phys(int, long, int, int);
+extern uint64_t sn_intr_alloc(nasid_t, int,
+			      struct sn_irq_info *,
+			      int, nasid_t, int);
+extern void sn_intr_free(nasid_t, int, struct sn_irq_info *);
+extern struct sn_irq_info *sn_retarget_vector(struct sn_irq_info *, nasid_t, int);
+extern struct list_head **sn_irq_lh;
 
 #define CPU_VECTOR_TO_IRQ(cpuid,vector) (vector)
 
Index: linux-2.6.14/include/asm-ia64/sn/pcibr_provider.h
===================================================================
--- linux-2.6.14.orig/include/asm-ia64/sn/pcibr_provider.h	2005-12-21 22:35:23.446284291 -0600
+++ linux-2.6.14/include/asm-ia64/sn/pcibr_provider.h	2005-12-21 22:38:24.094684947 -0600
@@ -3,7 +3,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 1992-1997,2000-2004 Silicon Graphics, Inc. All rights reserved.
+ * Copyright (C) 1992-1997,2000-2005 Silicon Graphics, Inc. All rights reserved.
  */
 #ifndef _ASM_IA64_SN_PCI_PCIBR_PROVIDER_H
 #define _ASM_IA64_SN_PCI_PCIBR_PROVIDER_H
@@ -55,6 +55,7 @@
 #define PCI32_ATE_V                     (0x1 << 0)
 #define PCI32_ATE_CO                    (0x1 << 1)
 #define PCI32_ATE_PREC                  (0x1 << 2)
+#define PCI32_ATE_MSI                   (0x1 << 2)
 #define PCI32_ATE_PREF                  (0x1 << 3)
 #define PCI32_ATE_BAR                   (0x1 << 4)
 #define PCI32_ATE_ADDR_SHFT             12
@@ -129,8 +130,8 @@
 
 extern int  pcibr_init_provider(void);
 extern void *pcibr_bus_fixup(struct pcibus_bussoft *, struct pci_controller *);
-extern dma_addr_t pcibr_dma_map(struct pci_dev *, unsigned long, size_t);
-extern dma_addr_t pcibr_dma_map_consistent(struct pci_dev *, unsigned long, size_t);
+extern dma_addr_t pcibr_dma_map(struct pci_dev *, unsigned long, size_t, int type);
+extern dma_addr_t pcibr_dma_map_consistent(struct pci_dev *, unsigned long, size_t, int type);
 extern void pcibr_dma_unmap(struct pci_dev *, dma_addr_t, int);
 
 /*
Index: linux-2.6.14/include/asm-ia64/sn/pcibus_provider_defs.h
===================================================================
--- linux-2.6.14.orig/include/asm-ia64/sn/pcibus_provider_defs.h	2005-12-21 22:35:23.446284291 -0600
+++ linux-2.6.14/include/asm-ia64/sn/pcibus_provider_defs.h	2005-12-21 22:38:24.095684706 -0600
@@ -3,7 +3,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 1992 - 1997, 2000-2004 Silicon Graphics, Inc. All rights reserved.
+ * Copyright (C) 1992 - 1997, 2000-2005 Silicon Graphics, Inc. All rights reserved.
  */
 #ifndef _ASM_IA64_SN_PCI_PCIBUS_PROVIDER_H
 #define _ASM_IA64_SN_PCI_PCIBUS_PROVIDER_H
@@ -45,13 +45,24 @@
  */
 
 struct sn_pcibus_provider {
-	dma_addr_t	(*dma_map)(struct pci_dev *, unsigned long, size_t);
-	dma_addr_t	(*dma_map_consistent)(struct pci_dev *, unsigned long, size_t);
+	dma_addr_t	(*dma_map)(struct pci_dev *, unsigned long, size_t, int flags);
+	dma_addr_t	(*dma_map_consistent)(struct pci_dev *, unsigned long, size_t, int flags);
 	void		(*dma_unmap)(struct pci_dev *, dma_addr_t, int);
 	void *		(*bus_fixup)(struct pcibus_bussoft *, struct pci_controller *);
  	void		(*force_interrupt)(struct sn_irq_info *);
  	void		(*target_interrupt)(struct sn_irq_info *);
 };
 
+/*
+ * Flags used by the map interfaces
+ * bits 3:0 specifies format of passed in address
+ * bit  4   specifies that address is to be used for MSI
+ */
+
+#define SN_DMA_ADDRTYPE(x)	((x) & 0xf)
+#define     SN_DMA_ADDR_PHYS	1	/* address is an xio address. */
+#define     SN_DMA_ADDR_XIO	2	/* address is phys memory */
+#define SN_DMA_MSI		0x10	/* Bus address is to be used for MSI */
+
 extern struct sn_pcibus_provider *sn_pci_provider[];
 #endif				/* _ASM_IA64_SN_PCI_PCIBUS_PROVIDER_H */
Index: linux-2.6.14/include/asm-ia64/sn/tiocp.h
===================================================================
--- linux-2.6.14.orig/include/asm-ia64/sn/tiocp.h	2005-12-21 22:35:23.446284291 -0600
+++ linux-2.6.14/include/asm-ia64/sn/tiocp.h	2005-12-21 22:38:24.095684706 -0600
@@ -3,13 +3,14 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2003-2004 Silicon Graphics, Inc. All rights reserved.
+ * Copyright (C) 2003-2005 Silicon Graphics, Inc. All rights reserved.
  */
 #ifndef _ASM_IA64_SN_PCI_TIOCP_H
 #define _ASM_IA64_SN_PCI_TIOCP_H
 
 #define TIOCP_HOST_INTR_ADDR            0x003FFFFFFFFFFFFFUL
 #define TIOCP_PCI64_CMDTYPE_MEM         (0x1ull << 60)
+#define TIOCP_PCI64_CMDTYPE_MSI         (0x3ull << 60)
 
 
 /*****************************************************************************
