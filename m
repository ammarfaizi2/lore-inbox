Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030789AbWI0Ud6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030789AbWI0Ud6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 16:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030778AbWI0Ud2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 16:33:28 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:38636 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030780AbWI0Ucy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 16:32:54 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Tony Luck <tony.luck@intel.com>, Andi Kleen <ak@suse.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 4/5] msi: Move the ia64 code into arch/ia64
Date: Wed, 27 Sep 2006 14:31:25 -0600
Message-Id: <1159389087962-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.g3cd4f
In-Reply-To: <<m11wpxm4sy.fsf@ebiederm.dsl.xmission.com>
References: <<m11wpxm4sy.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is just a few makefile tweaks and some file renames.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/ia64/kernel/Makefile    |    1 
 arch/ia64/kernel/msi_ia64.c  |  143 ++++++++++++++++++++++++++
 arch/ia64/sn/kernel/Makefile |    1 
 arch/ia64/sn/kernel/msi_sn.c |  230 ++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/Makefile         |    9 +-
 drivers/pci/msi-altix.c      |  230 ------------------------------------------
 drivers/pci/msi-apic.c       |  143 --------------------------
 7 files changed, 378 insertions(+), 379 deletions(-)

diff --git a/arch/ia64/kernel/Makefile b/arch/ia64/kernel/Makefile
index 96686f8..8ae384e 100644
--- a/arch/ia64/kernel/Makefile
+++ b/arch/ia64/kernel/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_KPROBES)		+= kprobes.o jpro
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o crash.o
 obj-$(CONFIG_IA64_UNCACHED_ALLOCATOR)	+= uncached.o
 obj-$(CONFIG_AUDIT)		+= audit.o
+obj-$(CONFIG_PCI_MSI)		+= msi_ia64.o
 mca_recovery-y			+= mca_drv.o mca_drv_asm.o
 
 obj-$(CONFIG_IA64_ESI)		+= esi.o
diff --git a/arch/ia64/kernel/msi_ia64.c b/arch/ia64/kernel/msi_ia64.c
new file mode 100644
index 0000000..0b083f6
--- /dev/null
+++ b/arch/ia64/kernel/msi_ia64.c
@@ -0,0 +1,143 @@
+/*
+ * MSI hooks for standard x86 apic
+ */
+
+#include <linux/pci.h>
+#include <linux/irq.h>
+#include <linux/msi.h>
+#include <asm/smp.h>
+
+/*
+ * Shifts for APIC-based data
+ */
+
+#define MSI_DATA_VECTOR_SHIFT		0
+#define	    MSI_DATA_VECTOR(v)		(((u8)v) << MSI_DATA_VECTOR_SHIFT)
+
+#define MSI_DATA_DELIVERY_SHIFT		8
+#define     MSI_DATA_DELIVERY_FIXED	(0 << MSI_DATA_DELIVERY_SHIFT)
+#define     MSI_DATA_DELIVERY_LOWPRI	(1 << MSI_DATA_DELIVERY_SHIFT)
+
+#define MSI_DATA_LEVEL_SHIFT		14
+#define     MSI_DATA_LEVEL_DEASSERT	(0 << MSI_DATA_LEVEL_SHIFT)
+#define     MSI_DATA_LEVEL_ASSERT	(1 << MSI_DATA_LEVEL_SHIFT)
+
+#define MSI_DATA_TRIGGER_SHIFT		15
+#define     MSI_DATA_TRIGGER_EDGE	(0 << MSI_DATA_TRIGGER_SHIFT)
+#define     MSI_DATA_TRIGGER_LEVEL	(1 << MSI_DATA_TRIGGER_SHIFT)
+
+/*
+ * Shift/mask fields for APIC-based bus address
+ */
+
+#define MSI_TARGET_CPU_SHIFT		4
+#define MSI_ADDR_HEADER			0xfee00000
+
+#define MSI_ADDR_DESTID_MASK		0xfff0000f
+#define     MSI_ADDR_DESTID_CPU(cpu)	((cpu) << MSI_TARGET_CPU_SHIFT)
+
+#define MSI_ADDR_DESTMODE_SHIFT		2
+#define     MSI_ADDR_DESTMODE_PHYS	(0 << MSI_ADDR_DESTMODE_SHIFT)
+#define	    MSI_ADDR_DESTMODE_LOGIC	(1 << MSI_ADDR_DESTMODE_SHIFT)
+
+#define MSI_ADDR_REDIRECTION_SHIFT	3
+#define     MSI_ADDR_REDIRECTION_CPU	(0 << MSI_ADDR_REDIRECTION_SHIFT)
+#define     MSI_ADDR_REDIRECTION_LOWPRI	(1 << MSI_ADDR_REDIRECTION_SHIFT)
+
+static struct irq_chip	ia64_msi_chip;
+
+#ifdef CONFIG_SMP
+static void ia64_set_msi_irq_affinity(unsigned int irq, cpumask_t cpu_mask)
+{
+	struct msi_msg msg;
+	u32 addr;
+
+	read_msi_msg(irq, &msg);
+
+	addr = msg.address_lo;
+	addr &= MSI_ADDR_DESTID_MASK;
+	addr |= MSI_ADDR_DESTID_CPU(cpu_physical_id(first_cpu(cpu_mask)));
+	msg.address_lo = addr;
+
+	write_msi_msg(irq, &msg);
+	set_native_irq_info(irq, cpu_mask);
+}
+#endif /* CONFIG_SMP */
+
+int ia64_setup_msi_irq(unsigned int irq, struct pci_dev *pdev)
+{
+	struct msi_msg	msg;
+	unsigned long	dest_phys_id;
+	unsigned int	vector;
+
+	dest_phys_id = cpu_physical_id(first_cpu(cpu_online_map));
+	vector = irq;
+
+	msg.address_hi = 0;
+	msg.address_lo =
+		MSI_ADDR_HEADER |
+		MSI_ADDR_DESTMODE_PHYS |
+		MSI_ADDR_REDIRECTION_CPU |
+		MSI_ADDR_DESTID_CPU(dest_phys_id);
+
+	msg.data =
+		MSI_DATA_TRIGGER_EDGE |
+		MSI_DATA_LEVEL_ASSERT |
+		MSI_DATA_DELIVERY_FIXED |
+		MSI_DATA_VECTOR(vector);
+
+	write_msi_msg(irq, &msg);
+	set_irq_chip_and_handler(irq, &ia64_msi_chip, handle_edge_irq);
+
+	return 0;
+}
+
+void ia64_teardown_msi_irq(unsigned int irq)
+{
+	return;		/* no-op */
+}
+
+static void ia64_ack_msi_irq(unsigned int irq)
+{
+	move_native_irq(irq);
+	ia64_eoi();
+}
+
+static int ia64_msi_retrigger_irq(unsigned int irq)
+{
+	unsigned int vector = irq;
+	ia64_resend_irq(vector);
+	
+	return 1;
+}
+
+/*
+ * Generic ops used on most IA64 platforms.
+ */
+static struct irq_chip ia64_msi_chip = {
+	.name		= "PCI-MSI",
+	.mask		= mask_msi_irq,
+	.unmask		= unmask_msi_irq,
+	.ack		= ia64_ack_msi_irq,
+#ifdef CONFIG_SMP
+	.set_affinity	= ia64_set_msi_irq_affinity,
+#endif
+	.retrigger	= ia64_msi_retrigger_irq,
+};
+
+
+int arch_setup_msi_irq(unsigned int irq, struct pci_dev *pdev)
+{
+	if (platform_setup_msi_irq)
+		return platform_setup_msi_irq(irq, pdev);
+
+	return ia64_setup_msi_irq(irq, pdev);
+}
+
+void arch_teardown_msi_irq(unsigned int irq)
+{
+	if (platform_teardown_msi_irq)
+		return platform_teardown_msi_irq(irq);
+
+	return ia64_teardown_msi_irq(irq);
+}
diff --git a/arch/ia64/sn/kernel/Makefile b/arch/ia64/sn/kernel/Makefile
index ab9c48c..2d78f34 100644
--- a/arch/ia64/sn/kernel/Makefile
+++ b/arch/ia64/sn/kernel/Makefile
@@ -19,3 +19,4 @@ xp-y				:= xp_main.o xp_nofault.o
 obj-$(CONFIG_IA64_SGI_SN_XP)	+= xpc.o
 xpc-y				:= xpc_main.o xpc_channel.o xpc_partition.o
 obj-$(CONFIG_IA64_SGI_SN_XP)	+= xpnet.o
+obj-$(CONFIG_PCI_MSI)		+= msi_sn.o
diff --git a/arch/ia64/sn/kernel/msi_sn.c b/arch/ia64/sn/kernel/msi_sn.c
new file mode 100644
index 0000000..6ffd1f8
--- /dev/null
+++ b/arch/ia64/sn/kernel/msi_sn.c
@@ -0,0 +1,230 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2006 Silicon Graphics, Inc.  All Rights Reserved.
+ */
+
+#include <linux/types.h>
+#include <linux/irq.h>
+#include <linux/pci.h>
+#include <linux/cpumask.h>
+#include <linux/msi.h>
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
+static struct sn_msi_info sn_msi_info[NR_IRQS];
+
+static struct irq_chip sn_msi_chip;
+
+void sn_teardown_msi_irq(unsigned int irq)
+{
+	nasid_t nasid;
+	int widget;
+	struct pci_dev *pdev;
+	struct pcidev_info *sn_pdev;
+	struct sn_irq_info *sn_irq_info;
+	struct pcibus_bussoft *bussoft;
+	struct sn_pcibus_provider *provider;
+
+	sn_irq_info = sn_msi_info[irq].sn_irq_info;
+	if (sn_irq_info == NULL || sn_irq_info->irq_int_bit >= 0)
+		return;
+
+	sn_pdev = (struct pcidev_info *)sn_irq_info->irq_pciioinfo;
+	pdev = sn_pdev->pdi_linux_pcidev;
+	provider = SN_PCIDEV_BUSPROVIDER(pdev);
+
+	(*provider->dma_unmap)(pdev,
+			       sn_msi_info[irq].pci_addr,
+			       PCI_DMA_FROMDEVICE);
+	sn_msi_info[irq].pci_addr = 0;
+
+	bussoft = SN_PCIDEV_BUSSOFT(pdev);
+	nasid = NASID_GET(bussoft->bs_base);
+	widget = (nasid & 1) ?
+			TIO_SWIN_WIDGETNUM(bussoft->bs_base) :
+			SWIN_WIDGETNUM(bussoft->bs_base);
+
+	sn_intr_free(nasid, widget, sn_irq_info);
+	sn_msi_info[irq].sn_irq_info = NULL;
+
+	return;
+}
+
+int sn_setup_msi_irq(unsigned int irq, struct pci_dev *pdev)
+{
+	struct msi_msg msg;
+	struct msi_desc *entry;
+	int widget;
+	int status;
+	nasid_t nasid;
+	u64 bus_addr;
+	struct sn_irq_info *sn_irq_info;
+	struct pcibus_bussoft *bussoft = SN_PCIDEV_BUSSOFT(pdev);
+	struct sn_pcibus_provider *provider = SN_PCIDEV_BUSPROVIDER(pdev);
+
+	entry = get_irq_data(irq);
+	if (!entry->msi_attrib.is_64)
+		return -EINVAL;
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
+	status = sn_intr_alloc(nasid, widget, sn_irq_info, irq, -1, -1);
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
+	sn_msi_info[irq].sn_irq_info = sn_irq_info;
+	sn_msi_info[irq].pci_addr = bus_addr;
+
+	msg.address_hi = (u32)(bus_addr >> 32);
+	msg.address_lo = (u32)(bus_addr & 0x00000000ffffffff);
+
+	/*
+	 * In the SN platform, bit 16 is a "send vector" bit which
+	 * must be present in order to move the vector through the system.
+	 */
+	msg.data = 0x100 + irq;
+
+#ifdef CONFIG_SMP
+	set_irq_affinity_info(irq, sn_irq_info->irq_cpuid, 0);
+#endif
+
+	write_msi_msg(irq, &msg);
+	set_irq_chip_and_handler(irq, &sn_msi_chip, handle_edge_irq);
+
+	return 0;
+}
+
+#ifdef CONFIG_SMP
+static void sn_set_msi_irq_affinity(unsigned int irq, cpumask_t cpu_mask)
+{
+	struct msi_msg msg;
+	int slice;
+	nasid_t nasid;
+	u64 bus_addr;
+	struct pci_dev *pdev;
+	struct pcidev_info *sn_pdev;
+	struct sn_irq_info *sn_irq_info;
+	struct sn_irq_info *new_irq_info;
+	struct sn_pcibus_provider *provider;
+	unsigned int cpu;
+
+	cpu = first_cpu(cpu_mask);
+	sn_irq_info = sn_msi_info[irq].sn_irq_info;
+	if (sn_irq_info == NULL || sn_irq_info->irq_int_bit >= 0)
+		return;
+
+	/*
+	 * Release XIO resources for the old MSI PCI address
+	 */
+
+	read_msi_msg(irq, &msg);
+        sn_pdev = (struct pcidev_info *)sn_irq_info->irq_pciioinfo;
+	pdev = sn_pdev->pdi_linux_pcidev;
+	provider = SN_PCIDEV_BUSPROVIDER(pdev);
+
+	bus_addr = (u64)(msg.address_hi) << 32 | (u64)(msg.address_lo);
+	(*provider->dma_unmap)(pdev, bus_addr, PCI_DMA_FROMDEVICE);
+	sn_msi_info[irq].pci_addr = 0;
+
+	nasid = cpuid_to_nasid(cpu);
+	slice = cpuid_to_slice(cpu);
+
+	new_irq_info = sn_retarget_vector(sn_irq_info, nasid, slice);
+	sn_msi_info[irq].sn_irq_info = new_irq_info;
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
+	sn_msi_info[irq].pci_addr = bus_addr;
+	msg.address_hi = (u32)(bus_addr >> 32);
+	msg.address_lo = (u32)(bus_addr & 0x00000000ffffffff);
+
+	write_msi_msg(irq, &msg);
+	set_native_irq_info(irq, cpu_mask);
+}
+#endif /* CONFIG_SMP */
+
+static void sn_ack_msi_irq(unsigned int irq)
+{
+	move_native_irq(irq);
+	ia64_eoi();
+}
+
+static int sn_msi_retrigger_irq(unsigned int irq)
+{
+	unsigned int vector = irq;
+	ia64_resend_irq(vector);
+
+	return 1;
+}
+
+static struct irq_chip sn_msi_chip = {
+	.name		= "PCI-MSI",
+	.mask		= mask_msi_irq,
+	.unmask		= unmask_msi_irq,
+	.ack		= sn_ack_msi_irq,
+#ifdef CONFIG_SMP
+	.set_affinity	= sn_set_msi_irq_affinity,
+#endif
+	.retrigger	= sn_msi_retrigger_irq,
+};
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 2752c57..04694ec 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -14,6 +14,9 @@ obj-$(CONFIG_HOTPLUG) += hotplug.o
 # Build the PCI Hotplug drivers if we were asked to
 obj-$(CONFIG_HOTPLUG_PCI) += hotplug/
 
+# Build the PCI MSI interrupt support
+obj-$(CONFIG_PCI_MSI) += msi.o
+
 #
 # Some architectures use the generic PCI setup functions
 #
@@ -28,12 +31,6 @@ obj-$(CONFIG_MIPS) += setup-bus.o setup-
 obj-$(CONFIG_X86_VISWS) += setup-irq.o
 obj-$(CONFIG_HT_IRQ) += htirq.o
 
-msiobj-y := msi.o
-msiobj-$(CONFIG_IA64) += msi-apic.o
-msiobj-$(CONFIG_IA64_GENERIC) += msi-altix.o
-msiobj-$(CONFIG_IA64_SGI_SN2) += msi-altix.o
-obj-$(CONFIG_PCI_MSI) += $(msiobj-y)
-
 #
 # ACPI Related PCI FW Functions
 #
diff --git a/drivers/pci/msi-altix.c b/drivers/pci/msi-altix.c
deleted file mode 100644
index 6ffd1f8..0000000
--- a/drivers/pci/msi-altix.c
+++ /dev/null
@@ -1,230 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2006 Silicon Graphics, Inc.  All Rights Reserved.
- */
-
-#include <linux/types.h>
-#include <linux/irq.h>
-#include <linux/pci.h>
-#include <linux/cpumask.h>
-#include <linux/msi.h>
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
-static struct sn_msi_info sn_msi_info[NR_IRQS];
-
-static struct irq_chip sn_msi_chip;
-
-void sn_teardown_msi_irq(unsigned int irq)
-{
-	nasid_t nasid;
-	int widget;
-	struct pci_dev *pdev;
-	struct pcidev_info *sn_pdev;
-	struct sn_irq_info *sn_irq_info;
-	struct pcibus_bussoft *bussoft;
-	struct sn_pcibus_provider *provider;
-
-	sn_irq_info = sn_msi_info[irq].sn_irq_info;
-	if (sn_irq_info == NULL || sn_irq_info->irq_int_bit >= 0)
-		return;
-
-	sn_pdev = (struct pcidev_info *)sn_irq_info->irq_pciioinfo;
-	pdev = sn_pdev->pdi_linux_pcidev;
-	provider = SN_PCIDEV_BUSPROVIDER(pdev);
-
-	(*provider->dma_unmap)(pdev,
-			       sn_msi_info[irq].pci_addr,
-			       PCI_DMA_FROMDEVICE);
-	sn_msi_info[irq].pci_addr = 0;
-
-	bussoft = SN_PCIDEV_BUSSOFT(pdev);
-	nasid = NASID_GET(bussoft->bs_base);
-	widget = (nasid & 1) ?
-			TIO_SWIN_WIDGETNUM(bussoft->bs_base) :
-			SWIN_WIDGETNUM(bussoft->bs_base);
-
-	sn_intr_free(nasid, widget, sn_irq_info);
-	sn_msi_info[irq].sn_irq_info = NULL;
-
-	return;
-}
-
-int sn_setup_msi_irq(unsigned int irq, struct pci_dev *pdev)
-{
-	struct msi_msg msg;
-	struct msi_desc *entry;
-	int widget;
-	int status;
-	nasid_t nasid;
-	u64 bus_addr;
-	struct sn_irq_info *sn_irq_info;
-	struct pcibus_bussoft *bussoft = SN_PCIDEV_BUSSOFT(pdev);
-	struct sn_pcibus_provider *provider = SN_PCIDEV_BUSPROVIDER(pdev);
-
-	entry = get_irq_data(irq);
-	if (!entry->msi_attrib.is_64)
-		return -EINVAL;
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
-	status = sn_intr_alloc(nasid, widget, sn_irq_info, irq, -1, -1);
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
-	sn_msi_info[irq].sn_irq_info = sn_irq_info;
-	sn_msi_info[irq].pci_addr = bus_addr;
-
-	msg.address_hi = (u32)(bus_addr >> 32);
-	msg.address_lo = (u32)(bus_addr & 0x00000000ffffffff);
-
-	/*
-	 * In the SN platform, bit 16 is a "send vector" bit which
-	 * must be present in order to move the vector through the system.
-	 */
-	msg.data = 0x100 + irq;
-
-#ifdef CONFIG_SMP
-	set_irq_affinity_info(irq, sn_irq_info->irq_cpuid, 0);
-#endif
-
-	write_msi_msg(irq, &msg);
-	set_irq_chip_and_handler(irq, &sn_msi_chip, handle_edge_irq);
-
-	return 0;
-}
-
-#ifdef CONFIG_SMP
-static void sn_set_msi_irq_affinity(unsigned int irq, cpumask_t cpu_mask)
-{
-	struct msi_msg msg;
-	int slice;
-	nasid_t nasid;
-	u64 bus_addr;
-	struct pci_dev *pdev;
-	struct pcidev_info *sn_pdev;
-	struct sn_irq_info *sn_irq_info;
-	struct sn_irq_info *new_irq_info;
-	struct sn_pcibus_provider *provider;
-	unsigned int cpu;
-
-	cpu = first_cpu(cpu_mask);
-	sn_irq_info = sn_msi_info[irq].sn_irq_info;
-	if (sn_irq_info == NULL || sn_irq_info->irq_int_bit >= 0)
-		return;
-
-	/*
-	 * Release XIO resources for the old MSI PCI address
-	 */
-
-	read_msi_msg(irq, &msg);
-        sn_pdev = (struct pcidev_info *)sn_irq_info->irq_pciioinfo;
-	pdev = sn_pdev->pdi_linux_pcidev;
-	provider = SN_PCIDEV_BUSPROVIDER(pdev);
-
-	bus_addr = (u64)(msg.address_hi) << 32 | (u64)(msg.address_lo);
-	(*provider->dma_unmap)(pdev, bus_addr, PCI_DMA_FROMDEVICE);
-	sn_msi_info[irq].pci_addr = 0;
-
-	nasid = cpuid_to_nasid(cpu);
-	slice = cpuid_to_slice(cpu);
-
-	new_irq_info = sn_retarget_vector(sn_irq_info, nasid, slice);
-	sn_msi_info[irq].sn_irq_info = new_irq_info;
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
-	sn_msi_info[irq].pci_addr = bus_addr;
-	msg.address_hi = (u32)(bus_addr >> 32);
-	msg.address_lo = (u32)(bus_addr & 0x00000000ffffffff);
-
-	write_msi_msg(irq, &msg);
-	set_native_irq_info(irq, cpu_mask);
-}
-#endif /* CONFIG_SMP */
-
-static void sn_ack_msi_irq(unsigned int irq)
-{
-	move_native_irq(irq);
-	ia64_eoi();
-}
-
-static int sn_msi_retrigger_irq(unsigned int irq)
-{
-	unsigned int vector = irq;
-	ia64_resend_irq(vector);
-
-	return 1;
-}
-
-static struct irq_chip sn_msi_chip = {
-	.name		= "PCI-MSI",
-	.mask		= mask_msi_irq,
-	.unmask		= unmask_msi_irq,
-	.ack		= sn_ack_msi_irq,
-#ifdef CONFIG_SMP
-	.set_affinity	= sn_set_msi_irq_affinity,
-#endif
-	.retrigger	= sn_msi_retrigger_irq,
-};
diff --git a/drivers/pci/msi-apic.c b/drivers/pci/msi-apic.c
deleted file mode 100644
index 0b083f6..0000000
--- a/drivers/pci/msi-apic.c
+++ /dev/null
@@ -1,143 +0,0 @@
-/*
- * MSI hooks for standard x86 apic
- */
-
-#include <linux/pci.h>
-#include <linux/irq.h>
-#include <linux/msi.h>
-#include <asm/smp.h>
-
-/*
- * Shifts for APIC-based data
- */
-
-#define MSI_DATA_VECTOR_SHIFT		0
-#define	    MSI_DATA_VECTOR(v)		(((u8)v) << MSI_DATA_VECTOR_SHIFT)
-
-#define MSI_DATA_DELIVERY_SHIFT		8
-#define     MSI_DATA_DELIVERY_FIXED	(0 << MSI_DATA_DELIVERY_SHIFT)
-#define     MSI_DATA_DELIVERY_LOWPRI	(1 << MSI_DATA_DELIVERY_SHIFT)
-
-#define MSI_DATA_LEVEL_SHIFT		14
-#define     MSI_DATA_LEVEL_DEASSERT	(0 << MSI_DATA_LEVEL_SHIFT)
-#define     MSI_DATA_LEVEL_ASSERT	(1 << MSI_DATA_LEVEL_SHIFT)
-
-#define MSI_DATA_TRIGGER_SHIFT		15
-#define     MSI_DATA_TRIGGER_EDGE	(0 << MSI_DATA_TRIGGER_SHIFT)
-#define     MSI_DATA_TRIGGER_LEVEL	(1 << MSI_DATA_TRIGGER_SHIFT)
-
-/*
- * Shift/mask fields for APIC-based bus address
- */
-
-#define MSI_TARGET_CPU_SHIFT		4
-#define MSI_ADDR_HEADER			0xfee00000
-
-#define MSI_ADDR_DESTID_MASK		0xfff0000f
-#define     MSI_ADDR_DESTID_CPU(cpu)	((cpu) << MSI_TARGET_CPU_SHIFT)
-
-#define MSI_ADDR_DESTMODE_SHIFT		2
-#define     MSI_ADDR_DESTMODE_PHYS	(0 << MSI_ADDR_DESTMODE_SHIFT)
-#define	    MSI_ADDR_DESTMODE_LOGIC	(1 << MSI_ADDR_DESTMODE_SHIFT)
-
-#define MSI_ADDR_REDIRECTION_SHIFT	3
-#define     MSI_ADDR_REDIRECTION_CPU	(0 << MSI_ADDR_REDIRECTION_SHIFT)
-#define     MSI_ADDR_REDIRECTION_LOWPRI	(1 << MSI_ADDR_REDIRECTION_SHIFT)
-
-static struct irq_chip	ia64_msi_chip;
-
-#ifdef CONFIG_SMP
-static void ia64_set_msi_irq_affinity(unsigned int irq, cpumask_t cpu_mask)
-{
-	struct msi_msg msg;
-	u32 addr;
-
-	read_msi_msg(irq, &msg);
-
-	addr = msg.address_lo;
-	addr &= MSI_ADDR_DESTID_MASK;
-	addr |= MSI_ADDR_DESTID_CPU(cpu_physical_id(first_cpu(cpu_mask)));
-	msg.address_lo = addr;
-
-	write_msi_msg(irq, &msg);
-	set_native_irq_info(irq, cpu_mask);
-}
-#endif /* CONFIG_SMP */
-
-int ia64_setup_msi_irq(unsigned int irq, struct pci_dev *pdev)
-{
-	struct msi_msg	msg;
-	unsigned long	dest_phys_id;
-	unsigned int	vector;
-
-	dest_phys_id = cpu_physical_id(first_cpu(cpu_online_map));
-	vector = irq;
-
-	msg.address_hi = 0;
-	msg.address_lo =
-		MSI_ADDR_HEADER |
-		MSI_ADDR_DESTMODE_PHYS |
-		MSI_ADDR_REDIRECTION_CPU |
-		MSI_ADDR_DESTID_CPU(dest_phys_id);
-
-	msg.data =
-		MSI_DATA_TRIGGER_EDGE |
-		MSI_DATA_LEVEL_ASSERT |
-		MSI_DATA_DELIVERY_FIXED |
-		MSI_DATA_VECTOR(vector);
-
-	write_msi_msg(irq, &msg);
-	set_irq_chip_and_handler(irq, &ia64_msi_chip, handle_edge_irq);
-
-	return 0;
-}
-
-void ia64_teardown_msi_irq(unsigned int irq)
-{
-	return;		/* no-op */
-}
-
-static void ia64_ack_msi_irq(unsigned int irq)
-{
-	move_native_irq(irq);
-	ia64_eoi();
-}
-
-static int ia64_msi_retrigger_irq(unsigned int irq)
-{
-	unsigned int vector = irq;
-	ia64_resend_irq(vector);
-	
-	return 1;
-}
-
-/*
- * Generic ops used on most IA64 platforms.
- */
-static struct irq_chip ia64_msi_chip = {
-	.name		= "PCI-MSI",
-	.mask		= mask_msi_irq,
-	.unmask		= unmask_msi_irq,
-	.ack		= ia64_ack_msi_irq,
-#ifdef CONFIG_SMP
-	.set_affinity	= ia64_set_msi_irq_affinity,
-#endif
-	.retrigger	= ia64_msi_retrigger_irq,
-};
-
-
-int arch_setup_msi_irq(unsigned int irq, struct pci_dev *pdev)
-{
-	if (platform_setup_msi_irq)
-		return platform_setup_msi_irq(irq, pdev);
-
-	return ia64_setup_msi_irq(irq, pdev);
-}
-
-void arch_teardown_msi_irq(unsigned int irq)
-{
-	if (platform_teardown_msi_irq)
-		return platform_teardown_msi_irq(irq);
-
-	return ia64_teardown_msi_irq(irq);
-}
-- 
1.4.2.rc3.g7e18e-dirty

