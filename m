Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964876AbWCTThE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbWCTThE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 14:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964889AbWCTThB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 14:37:01 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:9888 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964876AbWCTTgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 14:36:54 -0500
Date: Mon, 20 Mar 2006 13:36:38 -0600
From: Mark Maule <maule@sgi.com>
To: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Cc: gregkh@suse.de, akpm@osdl.org, j-nomura@ce.jp.nec.com
Subject: [PATCH 2.6.16-rc6-mm1] fix ia64 MSI build problems
Message-ID: <20060320193638.GH31238@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix MSI-related build problems on ia64.

Move arch/ia64/sn/pci/msi.c to drivers/pci/msi-altix.c
Move struct msi_ops in drivers/pci/msi.h to the top of the file so asm/msi.h
    can make use of the declaration.
Clean up msi platform defintions in machvec.h (thanks to j-nomura@ce.jp.nec.com
    for the patch to do that).

Signed-off-by: Mark Maule <maule@sgi.com>

Index: maule/arch/ia64/sn/pci/Makefile
===================================================================
--- maule.orig/arch/ia64/sn/pci/Makefile	2006-03-20 11:07:30.602099680 -0600
+++ maule/arch/ia64/sn/pci/Makefile	2006-03-20 11:08:08.130604825 -0600
@@ -10,4 +10,3 @@
 CPPFLAGS += -I$(srctree)/arch/ia64/sn/include
 
 obj-y := pci_dma.o tioca_provider.o tioce_provider.o pcibr/
-obj-$(CONFIG_PCI_MSI) += msi.o
Index: maule/arch/ia64/sn/pci/msi.c
===================================================================
--- maule.orig/arch/ia64/sn/pci/msi.c	2006-03-20 11:07:30.602099680 -0600
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,210 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2005 Silicon Graphics, Inc.  All Rights Reserved.
- */
-
-#include <linux/types.h>
-#include <linux/pci.h>
-#include <linux/cpumask.h>
-
-#include <asm/msi.h>
-
-#include <asm/sn/addrs.h>
-#include <asm/sn/intr.h>
-#include <asm/sn/pcibus_provider_defs.h>
-#include <asm/sn/pcidev.h>
-#include <asm/sn/nodepda.h>
-
-struct sn_msi_info {
-	u64 pci_addr;
-	struct sn_irq_info *sn_irq_info;
-};
-
-static struct sn_msi_info *sn_msi_info;
-
-static void
-sn_msi_teardown(unsigned int vector)
-{
-	nasid_t nasid;
-	int widget;
-	struct pci_dev *pdev;
-	struct pcidev_info *sn_pdev;
-	struct sn_irq_info *sn_irq_info;
-	struct pcibus_bussoft *bussoft;
-	struct sn_pcibus_provider *provider;
-
-	sn_irq_info = sn_msi_info[vector].sn_irq_info;
-	if (sn_irq_info == NULL || sn_irq_info->irq_int_bit >= 0)
-		return;
-
-	sn_pdev = (struct pcidev_info *)sn_irq_info->irq_pciioinfo;
-	pdev = sn_pdev->pdi_linux_pcidev;
-	provider = SN_PCIDEV_BUSPROVIDER(pdev);
-
-	(*provider->dma_unmap)(pdev,
-			       sn_msi_info[vector].pci_addr,
-			       PCI_DMA_FROMDEVICE);
-	sn_msi_info[vector].pci_addr = 0;
-
-	bussoft = SN_PCIDEV_BUSSOFT(pdev);
-	nasid = NASID_GET(bussoft->bs_base);
-	widget = (nasid & 1) ?
-			TIO_SWIN_WIDGETNUM(bussoft->bs_base) :
-			SWIN_WIDGETNUM(bussoft->bs_base);
-
-	sn_intr_free(nasid, widget, sn_irq_info);
-	sn_msi_info[vector].sn_irq_info = NULL;
-
-	return;
-}
-
-int
-sn_msi_setup(struct pci_dev *pdev, unsigned int vector,
-	     u32 *addr_hi, u32 *addr_lo, u32 *data)
-{
-	int widget;
-	int status;
-	nasid_t nasid;
-	u64 bus_addr;
-	struct sn_irq_info *sn_irq_info;
-	struct pcibus_bussoft *bussoft = SN_PCIDEV_BUSSOFT(pdev);
-	struct sn_pcibus_provider *provider = SN_PCIDEV_BUSPROVIDER(pdev);
-
-	if (bussoft == NULL)
-		return -EINVAL;
-
-	if (provider == NULL || provider->dma_map_consistent == NULL)
-		return -EINVAL;
-
-	/*
-	 * Set up the vector plumbing.  Let the prom (via sn_intr_alloc)
-	 * decide which cpu to direct this msi at by default.
-	 */
-
-	nasid = NASID_GET(bussoft->bs_base);
-	widget = (nasid & 1) ?
-			TIO_SWIN_WIDGETNUM(bussoft->bs_base) :
-			SWIN_WIDGETNUM(bussoft->bs_base);
-
-	sn_irq_info = kzalloc(sizeof(struct sn_irq_info), GFP_KERNEL);
-	if (! sn_irq_info)
-		return -ENOMEM;
-
-	status = sn_intr_alloc(nasid, widget, sn_irq_info, vector, -1, -1);
-	if (status) {
-		kfree(sn_irq_info);
-		return -ENOMEM;
-	}
-
-	sn_irq_info->irq_int_bit = -1;		/* mark this as an MSI irq */
-	sn_irq_fixup(pdev, sn_irq_info);
-
-	/* Prom probably should fill these in, but doesn't ... */
-	sn_irq_info->irq_bridge_type = bussoft->bs_asic_type;
-	sn_irq_info->irq_bridge = (void *)bussoft->bs_base;
-
-	/*
-	 * Map the xio address into bus space
-	 */
-	bus_addr = (*provider->dma_map_consistent)(pdev,
-					sn_irq_info->irq_xtalkaddr,
-					sizeof(sn_irq_info->irq_xtalkaddr),
-					SN_DMA_MSI|SN_DMA_ADDR_XIO);
-	if (! bus_addr) {
-		sn_intr_free(nasid, widget, sn_irq_info);
-		kfree(sn_irq_info);
-		return -ENOMEM;
-	}
-
-	sn_msi_info[vector].sn_irq_info = sn_irq_info;
-	sn_msi_info[vector].pci_addr = bus_addr;
-
-	*addr_hi = (u32)(bus_addr >> 32);
-	*addr_lo = (u32)(bus_addr & 0x00000000ffffffff);
-
-	/*
-	 * In the SN platform, bit 16 is a "send vector" bit which
-	 * must be present in order to move the vector through the system.
-	 */
-	*data = 0x100 + (unsigned int)vector;
-
-#ifdef CONFIG_SMP
-	set_irq_affinity_info((vector & 0xff), sn_irq_info->irq_cpuid, 0);
-#endif
-
-	return 0;
-}
-
-static void
-sn_msi_target(unsigned int vector, unsigned int cpu,
-	      u32 *addr_hi, u32 *addr_lo)
-{
-	int slice;
-	nasid_t nasid;
-	u64 bus_addr;
-	struct pci_dev *pdev;
-	struct pcidev_info *sn_pdev;
-	struct sn_irq_info *sn_irq_info;
-	struct sn_irq_info *new_irq_info;
-	struct sn_pcibus_provider *provider;
-
-	sn_irq_info = sn_msi_info[vector].sn_irq_info;
-	if (sn_irq_info == NULL || sn_irq_info->irq_int_bit >= 0)
-		return;
-
-	/*
-	 * Release XIO resources for the old MSI PCI address
-	 */
-
-        sn_pdev = (struct pcidev_info *)sn_irq_info->irq_pciioinfo;
-	pdev = sn_pdev->pdi_linux_pcidev;
-	provider = SN_PCIDEV_BUSPROVIDER(pdev);
-
-	bus_addr = (u64)(*addr_hi) << 32 | (u64)(*addr_lo);
-	(*provider->dma_unmap)(pdev, bus_addr, PCI_DMA_FROMDEVICE);
-	sn_msi_info[vector].pci_addr = 0;
-
-	nasid = cpuid_to_nasid(cpu);
-	slice = cpuid_to_slice(cpu);
-
-	new_irq_info = sn_retarget_vector(sn_irq_info, nasid, slice);
-	sn_msi_info[vector].sn_irq_info = new_irq_info;
-	if (new_irq_info == NULL)
-		return;
-
-	/*
-	 * Map the xio address into bus space
-	 */
-
-	bus_addr = (*provider->dma_map_consistent)(pdev,
-					new_irq_info->irq_xtalkaddr,
-					sizeof(new_irq_info->irq_xtalkaddr),
-					SN_DMA_MSI|SN_DMA_ADDR_XIO);
-
-	sn_msi_info[vector].pci_addr = bus_addr;
-	*addr_hi = (u32)(bus_addr >> 32);
-	*addr_lo = (u32)(bus_addr & 0x00000000ffffffff);
-}
-
-struct msi_ops sn_msi_ops = {
-	.setup = sn_msi_setup,
-	.teardown = sn_msi_teardown,
-#ifdef CONFIG_SMP
-	.target = sn_msi_target,
-#endif
-};
-
-int
-sn_msi_init(void)
-{
-	sn_msi_info =
-		kzalloc(sizeof(struct sn_msi_info) * NR_VECTORS, GFP_KERNEL);
-	if (! sn_msi_info)
-		return -ENOMEM;
-
-	msi_register(&sn_msi_ops);
-	return 0;
-}
Index: maule/drivers/pci/Makefile
===================================================================
--- maule.orig/drivers/pci/Makefile	2006-03-20 11:07:30.602099680 -0600
+++ maule/drivers/pci/Makefile	2006-03-20 11:08:08.130604825 -0600
@@ -26,7 +26,19 @@
 obj-$(CONFIG_PPC64) += setup-bus.o
 obj-$(CONFIG_MIPS) += setup-bus.o setup-irq.o
 obj-$(CONFIG_X86_VISWS) += setup-irq.o
-obj-$(CONFIG_PCI_MSI) += msi.o msi-apic.o
+
+ifdef CONFIG_PCI_MSI
+obj-y += msi.o msi-apic.o
+
+ifdef CONFIG_IA64_GENERIC
+obj-y += msi-altix.o
+else
+ifdef CONFIG_IA64_SGI_SN2
+obj-y += msi-altix.o
+endif
+endif
+
+endif #CONFIG_PCI_MSI
 
 #
 # ACPI Related PCI FW Functions
Index: maule/drivers/pci/msi-altix.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ maule/drivers/pci/msi-altix.c	2006-03-20 11:30:42.572360932 -0600
@@ -0,0 +1,210 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2005 Silicon Graphics, Inc.  All Rights Reserved.
+ */
+
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/cpumask.h>
+
+#include <asm/sn/addrs.h>
+#include <asm/sn/intr.h>
+#include <asm/sn/pcibus_provider_defs.h>
+#include <asm/sn/pcidev.h>
+#include <asm/sn/nodepda.h>
+
+#include "msi.h"
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
+
+int
+sn_msi_setup(struct pci_dev *pdev, unsigned int vector,
+	     u32 *addr_hi, u32 *addr_lo, u32 *data)
+{
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
+	/*
+	 * Map the xio address into bus space
+	 */
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
+}
Index: maule/drivers/pci/msi.h
===================================================================
--- maule.orig/drivers/pci/msi.h	2006-03-17 15:56:47.985483772 -0600
+++ maule/drivers/pci/msi.h	2006-03-20 12:08:49.730770784 -0600
@@ -6,6 +6,65 @@
 #ifndef MSI_H
 #define MSI_H
 
+/*
+ * MSI operation vector.  Used by the msi core code (drivers/pci/msi.c)
+ * to abstract platform-specific tasks relating to MSI address generation
+ * and resource management.
+ */
+struct msi_ops {
+	/**
+	 * setup - generate an MSI bus address and data for a given vector
+	 * @pdev: PCI device context (in)
+	 * @vector: vector allocated by the msi core (in)
+	 * @addr_hi: upper 32 bits of PCI bus MSI address (out)
+	 * @addr_lo: lower 32 bits of PCI bus MSI address (out)
+	 * @data: MSI data payload (out)
+	 *
+	 * Description: The setup op is used to generate a PCI bus addres and
+	 * data which the msi core will program into the card MSI capability
+	 * registers.  The setup routine is responsible for picking an initial
+	 * cpu to target the MSI at.  The setup routine is responsible for
+	 * examining pdev to determine the MSI capabilities of the card and
+	 * generating a suitable address/data.  The setup routine is
+	 * responsible for allocating and tracking any system resources it
+	 * needs to route the MSI to the cpu it picks, and for associating
+	 * those resources with the passed in vector.
+	 *
+	 * Returns 0 if the MSI address/data was successfully setup.
+	 */
+	int	(*setup)    (struct pci_dev *pdev, unsigned int vector,
+			     u32 *addr_hi, u32 *addr_lo, u32 *data);
+
+	/**
+	 * teardown - release resources allocated by setup
+	 * @vector: vector context for resources (in)
+	 *
+	 * Description:  The teardown op is used to release any resources
+	 * that were allocated in the setup routine associated with the passed
+	 * in vector.
+	 */
+	void	(*teardown) (unsigned int vector);
+
+	/**
+	 * target - retarget an MSI at a different cpu
+	 * @vector: vector context for resources (in)
+	 * @cpu:  new cpu to direct vector at (in)
+	 * @addr_hi: new value of PCI bus upper 32 bits (in/out)
+	 * @addr_lo: new value of PCI bus lower 32 bits (in/out)
+	 *
+	 * Description:  The target op is used to redirect an MSI vector
+	 * at a different cpu.  addr_hi/addr_lo coming in are the existing
+	 * values that the MSI core has programmed into the card.  The
+	 * target code is responsible for freeing any resources (if any)
+	 * associated with the old address, and generating a new PCI bus
+	 * addr_hi/addr_lo that will redirect the vector at the indicated cpu.
+	 */
+	void	(*target)   (unsigned int vector, unsigned int cpu,
+			     u32 *addr_hi, u32 *addr_lo);
+};
+
+extern int msi_register(struct msi_ops *);
+
 #include <asm/msi.h>
 
 /*
@@ -83,61 +142,4 @@
 	struct pci_dev *dev;
 };
 
-/*
- * MSI operation vector.  Used by the msi core code (drivers/pci/msi.c)
- * to abstract platform-specific tasks relating to MSI address generation
- * and resource management.
- */
-struct msi_ops {
-	/**
-	 * setup - generate an MSI bus address and data for a given vector
-	 * @pdev: PCI device context (in)
-	 * @vector: vector allocated by the msi core (in)
-	 * @addr_hi: upper 32 bits of PCI bus MSI address (out)
-	 * @addr_lo: lower 32 bits of PCI bus MSI address (out)
-	 * @data: MSI data payload (out)
-	 *
-	 * Description: The setup op is used to generate a PCI bus addres and
-	 * data which the msi core will program into the card MSI capability
-	 * registers.  The setup routine is responsible for picking an initial
-	 * cpu to target the MSI at.  The setup routine is responsible for
-	 * examining pdev to determine the MSI capabilities of the card and
-	 * generating a suitable address/data.  The setup routine is
-	 * responsible for allocating and tracking any system resources it
-	 * needs to route the MSI to the cpu it picks, and for associating
-	 * those resources with the passed in vector.
-	 *
-	 * Returns 0 if the MSI address/data was successfully setup.
-	 */
-	int	(*setup)    (struct pci_dev *pdev, unsigned int vector,
-			     u32 *addr_hi, u32 *addr_lo, u32 *data);
-
-	/**
-	 * teardown - release resources allocated by setup
-	 * @vector: vector context for resources (in)
-	 *
-	 * Description:  The teardown op is used to release any resources
-	 * that were allocated in the setup routine associated with the passed
-	 * in vector.
-	 */
-	void	(*teardown) (unsigned int vector);
-
-	/**
-	 * target - retarget an MSI at a different cpu
-	 * @vector: vector context for resources (in)
-	 * @cpu:  new cpu to direct vector at (in)
-	 * @addr_hi: new value of PCI bus upper 32 bits (in/out)
-	 * @addr_lo: new value of PCI bus lower 32 bits (in/out)
-	 *
-	 * Description:  The target op is used to redirect an MSI vector
-	 * at a different cpu.  addr_hi/addr_lo coming in are the existing
-	 * values that the MSI core has programmed into the card.  The
-	 * target code is responsible for freeing any resources (if any)
-	 * associated with the old address, and generating a new PCI bus
-	 * addr_hi/addr_lo that will redirect the vector at the indicated cpu.
-	 */
-	void	(*target)   (unsigned int vector, unsigned int cpu,
-			     u32 *addr_hi, u32 *addr_lo);
-};
-
 #endif /* MSI_H */
Index: maule/drivers/pci/pci.h
===================================================================
--- maule.orig/drivers/pci/pci.h	2006-03-17 15:56:47.989484242 -0600
+++ maule/drivers/pci/pci.h	2006-03-20 11:29:45.621538709 -0600
@@ -51,11 +51,9 @@
 struct msi_ops;
 #ifdef CONFIG_PCI_MSI
 void disable_msi_mode(struct pci_dev *dev, int pos, int type);
-int msi_register(struct msi_ops *ops);
 void pci_no_msi(void);
 #else
 static inline void disable_msi_mode(struct pci_dev *dev, int pos, int type) { }
-static inline int msi_register(struct msi_ops *ops) { return 0; }
 static inline void pci_no_msi(void) { }
 #endif
 
Index: maule/include/asm-ia64/machvec.h
===================================================================
--- maule.orig/include/asm-ia64/machvec.h	2006-03-17 15:56:50.153738431 -0600
+++ maule/include/asm-ia64/machvec.h	2006-03-20 11:41:25.865449097 -0600
@@ -404,12 +404,7 @@
 # define platform_migrate machvec_noop_task
 #endif
 #ifndef platform_msi_init
-#ifdef CONFIG_PCI_MSI
-#include <asm/msi.h>		/* pull in ia64_msi_init() */
-# define platform_msi_init	ia64_msi_init
-#else
 # define platform_msi_init	NULL
-#endif /* CONFIG_PCI_MSI */
 #endif
 
 #endif /* _ASM_IA64_MACHVEC_H */
Index: maule/include/asm-ia64/msi.h
===================================================================
--- maule.orig/include/asm-ia64/msi.h	2006-03-20 11:30:18.137433515 -0600
+++ maule/include/asm-ia64/msi.h	2006-03-20 12:06:40.671281126 -0600
@@ -16,13 +16,14 @@
 
 extern struct msi_ops msi_apic_ops;
 
-/* default ia64 msi init routine */
-static inline int ia64_msi_init(void)
+static inline int msi_arch_init(void)
 {
+	if (platform_msi_init)
+		return platform_msi_init();
+
+	/* default ia64 ops */
 	msi_register(&msi_apic_ops);
 	return 0;
 }
 
-#define msi_arch_init		platform_msi_init	/* in asm/machvec.h */
-
 #endif /* ASM_MSI_H */
