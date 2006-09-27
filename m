Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030739AbWI0UAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030739AbWI0UAG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 16:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030736AbWI0UAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 16:00:05 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:28820 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030737AbWI0T7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 15:59:46 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Tony Luck <tony.luck@intel.com>, Andi Kleen <ak@suse.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 3/5] msi: Refactor and move the msi irq_chip into the arch code.
Date: Wed, 27 Sep 2006 13:58:15 -0600
Message-Id: <11593870982973-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.g3cd4f
In-Reply-To: <m164f9m6dy.fsf@ebiederm.dsl.xmission.com>
References: <m164f9m6dy.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out msi_ops was simply not enough to abstract the
architecture specific details of msi.  So I have moved
the resposibility of constructing the struct irq_chip
to the architectures, and have two architecture specific
functions arch_setup_msi_irq, and arch_teardown_msi_irq.

For simple architectures those functions can do all of the work.
For architectures with platform dependencies they can call into
the appropriate platform code.

With this msi.c is finally free of assuming you have an apic,
and this actually takes less code.

The helpers for the architecture specific code are
declared in the linux/msi.h to keep them separate from
the msi functions used by drivers in linux/pci.h

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/i386/kernel/io_apic.c     |   81 +++++++++++++++-------
 arch/x86_64/kernel/io_apic.c   |   89 +++++++++++++++++-------
 drivers/pci/msi-altix.c        |   78 +++++++++++++--------
 drivers/pci/msi-apic.c         |   86 +++++++++++++++++------
 drivers/pci/msi.c              |  150 ++++++++--------------------------------
 drivers/pci/msi.h              |   27 -------
 include/asm-i386/msi.h         |   20 -----
 include/asm-ia64/machvec.h     |   21 ++++--
 include/asm-ia64/machvec_sn2.h |    9 ++
 include/asm-ia64/msi.h         |   29 --------
 include/asm-x86_64/msi.h       |   21 ------
 include/linux/msi.h            |   49 +++++++++++++
 include/linux/pci.h            |   67 ------------------
 13 files changed, 333 insertions(+), 394 deletions(-)

diff --git a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
index 100406b..5a12527 100644
--- a/arch/i386/kernel/io_apic.c
+++ b/arch/i386/kernel/io_apic.c
@@ -32,6 +32,7 @@ #include <linux/acpi.h>
 #include <linux/module.h>
 #include <linux/sysdev.h>
 #include <linux/pci.h>
+#include <linux/msi.h>
 
 #include <asm/io.h>
 #include <asm/smp.h>
@@ -2455,11 +2456,8 @@ #endif /* CONFIG_PCI_MSI */
  * MSI mesage composition
  */
 #ifdef CONFIG_PCI_MSI
-static int msi_msg_setup(struct pci_dev *pdev, unsigned int irq, struct msi_msg *msg)
+static int msi_compose_msg(struct pci_dev *pdev, unsigned int irq, struct msi_msg *msg)
 {
-	/* For now always this code always uses physical delivery
-	 * mode.
-	 */
 	int vector;
 	unsigned dest;
 
@@ -2489,34 +2487,71 @@ static int msi_msg_setup(struct pci_dev 
 	return vector;
 }
 
-static void msi_msg_teardown(unsigned int irq)
-{
-	return;
-}
-
-static void msi_msg_set_affinity(unsigned int irq, cpumask_t mask, struct msi_msg *msg)
+#ifdef CONFIG_SMP
+static void set_msi_irq_affinity(unsigned int irq, cpumask_t mask)
 {
+	struct msi_msg msg;
+	unsigned int dest;
+	cpumask_t tmp;
 	int vector;
-	unsigned dest;
+
+	cpus_and(tmp, mask, cpu_online_map);
+	if (cpus_empty(tmp))
+		tmp = TARGET_CPUS;
 
 	vector = assign_irq_vector(irq);
-	if (vector > 0) {
-		dest = cpu_mask_to_apicid(mask);
+	if (vector < 0)
+		return;
 
-		msg->data &= ~MSI_DATA_VECTOR_MASK;
-		msg->data |= MSI_DATA_VECTOR(vector);
-		msg->address_lo &= ~MSI_ADDR_DEST_ID_MASK;
-		msg->address_lo |= MSI_ADDR_DEST_ID(dest);
-	}
+	dest = cpu_mask_to_apicid(mask);
+
+	read_msi_msg(irq, &msg);
+
+	msg.data &= ~MSI_DATA_VECTOR_MASK;
+	msg.data |= MSI_DATA_VECTOR(vector);
+	msg.address_lo &= ~MSI_ADDR_DEST_ID_MASK;
+	msg.address_lo |= MSI_ADDR_DEST_ID(dest);
+
+	write_msi_msg(irq, &msg);
+	set_native_irq_info(irq, mask);
 }
+#endif /* CONFIG_SMP */
 
-struct msi_ops arch_msi_ops = {
-	.needs_64bit_address = 0,
-	.setup = msi_msg_setup,
-	.teardown = msi_msg_teardown,
-	.target = msi_msg_set_affinity,
+/*
+ * IRQ Chip for MSI PCI/PCI-X/PCI-Express Devices,
+ * which implement the MSI or MSI-X Capability Structure.
+ */
+static struct irq_chip msi_chip = {
+	.name		= "PCI-MSI",
+	.unmask		= unmask_msi_irq,
+	.mask		= mask_msi_irq,
+	.ack		= ack_ioapic_irq,
+#ifdef CONFIG_SMP
+	.set_affinity	= set_msi_irq_affinity,
+#endif
+	.retrigger	= ioapic_retrigger_irq,
 };
 
+int arch_setup_msi_irq(unsigned int irq, struct pci_dev *dev)
+{
+	struct msi_msg msg;
+	int ret;
+	ret = msi_compose_msg(dev, irq, &msg);
+	if (ret < 0)
+		return ret;
+
+	write_msi_msg(irq, &msg);
+
+	set_irq_chip_and_handler(irq, &msi_chip, handle_edge_irq);
+
+	return 0;
+}
+
+void arch_teardown_msi_irq(unsigned int irq)
+{
+	return;
+}
+
 #endif /* CONFIG_PCI_MSI */
 
 /*
diff --git a/arch/x86_64/kernel/io_apic.c b/arch/x86_64/kernel/io_apic.c
index 31c270f..e55028f 100644
--- a/arch/x86_64/kernel/io_apic.c
+++ b/arch/x86_64/kernel/io_apic.c
@@ -30,6 +30,7 @@ #include <linux/pci.h>
 #include <linux/mc146818rtc.h>
 #include <linux/acpi.h>
 #include <linux/sysdev.h>
+#include <linux/msi.h>
 #ifdef CONFIG_ACPI
 #include <acpi/acpi_bus.h>
 #endif
@@ -1701,11 +1702,8 @@ void destroy_irq(unsigned int irq)
  * MSI mesage composition
  */
 #ifdef CONFIG_PCI_MSI
-static int msi_msg_setup(struct pci_dev *pdev, unsigned int irq, struct msi_msg *msg)
+static int msi_compose_msg(struct pci_dev *pdev, unsigned int irq, struct msi_msg *msg)
 {
-	/* For now always this code always uses physical delivery
-	 * mode.
-	 */
 	int vector;
 	unsigned dest;
 
@@ -1739,39 +1737,76 @@ static int msi_msg_setup(struct pci_dev 
 	return vector;
 }
 
-static void msi_msg_teardown(unsigned int irq)
-{
-	return;
-}
-
-static void msi_msg_set_affinity(unsigned int irq, cpumask_t mask, struct msi_msg *msg)
+#ifdef CONFIG_SMP
+static void set_msi_irq_affinity(unsigned int irq, cpumask_t mask)
 {
+	struct msi_msg msg;
+	unsigned int dest;
+	cpumask_t tmp;
 	int vector;
-	unsigned dest;
+
+	cpus_and(tmp, mask, cpu_online_map);
+	if (cpus_empty(tmp))
+		tmp = TARGET_CPUS;
+
+	cpus_and(mask, tmp, CPU_MASK_ALL);
 
 	vector = assign_irq_vector(irq, mask);
-	if (vector > 0) {
-		cpumask_t tmp;
+	if (vector < 0)
+		return;
 
-		cpus_clear(tmp);
-		cpu_set(vector >> 8, tmp);
-		dest = cpu_mask_to_apicid(tmp);
+	cpus_clear(tmp);
+	cpu_set(vector >> 8, tmp);
+	dest = cpu_mask_to_apicid(tmp);
 
-		msg->data &= ~MSI_DATA_VECTOR_MASK;
-		msg->data |= MSI_DATA_VECTOR(vector);
-		msg->address_lo &= ~MSI_ADDR_DEST_ID_MASK;
-		msg->address_lo |= MSI_ADDR_DEST_ID(dest);
-	}
+	read_msi_msg(irq, &msg);
+
+	msg.data &= ~MSI_DATA_VECTOR_MASK;
+	msg.data |= MSI_DATA_VECTOR(vector);
+	msg.address_lo &= ~MSI_ADDR_DEST_ID_MASK;
+	msg.address_lo |= MSI_ADDR_DEST_ID(dest);
+
+	write_msi_msg(irq, &msg);
+	set_native_irq_info(irq, mask);
 }
+#endif /* CONFIG_SMP */
 
-struct msi_ops arch_msi_ops = {
-	.needs_64bit_address = 0,
-	.setup = msi_msg_setup,
-	.teardown = msi_msg_teardown,
-	.target = msi_msg_set_affinity,
+/*
+ * IRQ Chip for MSI PCI/PCI-X/PCI-Express Devices,
+ * which implement the MSI or MSI-X Capability Structure.
+ */
+static struct irq_chip msi_chip = {
+	.name		= "PCI-MSI",
+	.unmask		= unmask_msi_irq,
+	.mask		= mask_msi_irq,
+	.ack		= ack_apic_edge,
+#ifdef CONFIG_SMP
+	.set_affinity	= set_msi_irq_affinity,
+#endif
+	.retrigger	= ioapic_retrigger_irq,
 };
 
-#endif
+int arch_setup_msi_irq(unsigned int irq, struct pci_dev *dev)
+{
+	struct msi_msg msg;
+	int ret;
+	ret = msi_compose_msg(dev, irq, &msg);
+	if (ret < 0)
+		return ret;
+
+	write_msi_msg(irq, &msg);
+
+	set_irq_chip_and_handler(irq, &msi_chip, handle_edge_irq);
+
+	return 0;
+}
+
+void arch_teardown_msi_irq(unsigned int irq)
+{
+	return;
+}
+
+#endif /* CONFIG_PCI_MSI */
 
 /*
  * Hypertransport interrupt support
diff --git a/drivers/pci/msi-altix.c b/drivers/pci/msi-altix.c
index 7aedc2a..2b44128 100644
--- a/drivers/pci/msi-altix.c
+++ b/drivers/pci/msi-altix.c
@@ -9,6 +9,7 @@
 #include <linux/types.h>
 #include <linux/pci.h>
 #include <linux/cpumask.h>
+#include <linux/msi.h>
 
 #include <asm/sn/addrs.h>
 #include <asm/sn/intr.h>
@@ -16,17 +17,16 @@ #include <asm/sn/pcibus_provider_defs.h>
 #include <asm/sn/pcidev.h>
 #include <asm/sn/nodepda.h>
 
-#include "msi.h"
-
 struct sn_msi_info {
 	u64 pci_addr;
 	struct sn_irq_info *sn_irq_info;
 };
 
-static struct sn_msi_info *sn_msi_info;
+static struct sn_msi_info sn_msi_info[NR_IRQS];
+
+static struct irq_chip sn_msi_chip;
 
-static void
-sn_msi_teardown(unsigned int irq)
+void sn_teardown_msi_irq(unsigned int irq)
 {
 	nasid_t nasid;
 	int widget;
@@ -61,9 +61,10 @@ sn_msi_teardown(unsigned int irq)
 	return;
 }
 
-int
-sn_msi_setup(struct pci_dev *pdev, unsigned int irq, struct msi_msg *msg)
+int sn_setup_msi_irq(unsigned int irq, struct pci_dev *pdev)
 {
+	struct msi_msg msg;
+	struct msi_desc *entry;
 	int widget;
 	int status;
 	nasid_t nasid;
@@ -72,6 +73,10 @@ sn_msi_setup(struct pci_dev *pdev, unsig
 	struct pcibus_bussoft *bussoft = SN_PCIDEV_BUSSOFT(pdev);
 	struct sn_pcibus_provider *provider = SN_PCIDEV_BUSPROVIDER(pdev);
 
+	entry = get_irq_data(irq);
+	if (!entry->msi_attrib.is_64bit)
+		return -EINVAL;
+
 	if (bussoft == NULL)
 		return -EINVAL;
 
@@ -121,25 +126,29 @@ sn_msi_setup(struct pci_dev *pdev, unsig
 	sn_msi_info[irq].sn_irq_info = sn_irq_info;
 	sn_msi_info[irq].pci_addr = bus_addr;
 
-	msg->address_hi = (u32)(bus_addr >> 32);
-	msg->address_lo = (u32)(bus_addr & 0x00000000ffffffff);
+	msg.address_hi = (u32)(bus_addr >> 32);
+	msg.address_lo = (u32)(bus_addr & 0x00000000ffffffff);
 
 	/*
 	 * In the SN platform, bit 16 is a "send vector" bit which
 	 * must be present in order to move the vector through the system.
 	 */
-	msg->data = 0x100 + irq;
+	msg.data = 0x100 + irq;
 
 #ifdef CONFIG_SMP
 	set_irq_affinity_info(irq, sn_irq_info->irq_cpuid, 0);
 #endif
 
+	write_msi_msg(irq, &msg);
+	set_irq_chip_and_handler(irq, &sn_msi_chip, handle_edge_irq);
+
 	return 0;
 }
 
-static void
-sn_msi_target(unsigned int irq, cpumask_t cpu_mask, struct msi_msg *msg)
+#ifdef CONFIG_SMP
+static void sn_set_msi_irq_affinity(unsigned int irq, cpumask_t cpu_mask)
 {
+	struct msi_msg msg;
 	int slice;
 	nasid_t nasid;
 	u64 bus_addr;
@@ -159,6 +168,7 @@ sn_msi_target(unsigned int irq, cpumask_
 	 * Release XIO resources for the old MSI PCI address
 	 */
 
+	read_msi_msg(irq, &msg);
         sn_pdev = (struct pcidev_info *)sn_irq_info->irq_pciioinfo;
 	pdev = sn_pdev->pdi_linux_pcidev;
 	provider = SN_PCIDEV_BUSPROVIDER(pdev);
@@ -185,27 +195,35 @@ sn_msi_target(unsigned int irq, cpumask_
 					SN_DMA_MSI|SN_DMA_ADDR_XIO);
 
 	sn_msi_info[irq].pci_addr = bus_addr;
-	msg->address_hi = (u32)(bus_addr >> 32);
-	msg->address_lo = (u32)(bus_addr & 0x00000000ffffffff);
+	msg.address_hi = (u32)(bus_addr >> 32);
+	msg.address_lo = (u32)(bus_addr & 0x00000000ffffffff);
+
+	write_msi_msg(irq, &msg);
+	set_native_irq_info(irq, cpu_mask);
 }
+#endif /* CONFIG_SMP */
 
-struct msi_ops sn_msi_ops = {
-	.needs_64bit_address = 1,
-	.setup = sn_msi_setup,
-	.teardown = sn_msi_teardown,
-#ifdef CONFIG_SMP
-	.target = sn_msi_target,
-#endif
-};
+static void sn_ack_msi_irq(unsigned int irq)
+{
+	move_native_irq(irq);
+	ia64_eoi();
+}
 
-int
-sn_msi_init(void)
+static int sn_msi_retrigger_irq(unsigned int irq)
 {
-	sn_msi_info =
-		kzalloc(sizeof(struct sn_msi_info) * NR_IRQS, GFP_KERNEL);
-	if (! sn_msi_info)
-		return -ENOMEM;
+	unsigned int vector = irq;
+	ia64_resend_irq(vector);
 
-	msi_register(&sn_msi_ops);
-	return 0;
+	return 1;
 }
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
diff --git a/drivers/pci/msi-apic.c b/drivers/pci/msi-apic.c
index afc0ed1..0b083f6 100644
--- a/drivers/pci/msi-apic.c
+++ b/drivers/pci/msi-apic.c
@@ -4,10 +4,9 @@
 
 #include <linux/pci.h>
 #include <linux/irq.h>
+#include <linux/msi.h>
 #include <asm/smp.h>
 
-#include "msi.h"
-
 /*
  * Shifts for APIC-based data
  */
@@ -31,6 +30,7 @@ #define     MSI_DATA_TRIGGER_LEVEL	(1 <<
  * Shift/mask fields for APIC-based bus address
  */
 
+#define MSI_TARGET_CPU_SHIFT		4
 #define MSI_ADDR_HEADER			0xfee00000
 
 #define MSI_ADDR_DESTID_MASK		0xfff0000f
@@ -44,58 +44,100 @@ #define MSI_ADDR_REDIRECTION_SHIFT	3
 #define     MSI_ADDR_REDIRECTION_CPU	(0 << MSI_ADDR_REDIRECTION_SHIFT)
 #define     MSI_ADDR_REDIRECTION_LOWPRI	(1 << MSI_ADDR_REDIRECTION_SHIFT)
 
+static struct irq_chip	ia64_msi_chip;
 
-static void
-msi_target_apic(unsigned int irq, cpumask_t cpu_mask, struct msi_msg *msg)
+#ifdef CONFIG_SMP
+static void ia64_set_msi_irq_affinity(unsigned int irq, cpumask_t cpu_mask)
 {
-	u32 addr = msg->address_lo;
+	struct msi_msg msg;
+	u32 addr;
+
+	read_msi_msg(irq, &msg);
 
+	addr = msg.address_lo;
 	addr &= MSI_ADDR_DESTID_MASK;
 	addr |= MSI_ADDR_DESTID_CPU(cpu_physical_id(first_cpu(cpu_mask)));
+	msg.address_lo = addr;
 
-	msg->address_lo = addr;
+	write_msi_msg(irq, &msg);
+	set_native_irq_info(irq, cpu_mask);
 }
+#endif /* CONFIG_SMP */
 
-static int
-msi_setup_apic(struct pci_dev *pdev,	/* unused in generic */
-		unsigned int irq,
-		struct msi_msg *msg)
+int ia64_setup_msi_irq(unsigned int irq, struct pci_dev *pdev)
 {
+	struct msi_msg	msg;
 	unsigned long	dest_phys_id;
 	unsigned int	vector;
 
 	dest_phys_id = cpu_physical_id(first_cpu(cpu_online_map));
 	vector = irq;
 
-	msg->address_hi = 0;
-	msg->address_lo =
+	msg.address_hi = 0;
+	msg.address_lo =
 		MSI_ADDR_HEADER |
 		MSI_ADDR_DESTMODE_PHYS |
 		MSI_ADDR_REDIRECTION_CPU |
 		MSI_ADDR_DESTID_CPU(dest_phys_id);
 
-	msg->data =
+	msg.data =
 		MSI_DATA_TRIGGER_EDGE |
 		MSI_DATA_LEVEL_ASSERT |
 		MSI_DATA_DELIVERY_FIXED |
 		MSI_DATA_VECTOR(vector);
 
+	write_msi_msg(irq, &msg);
+	set_irq_chip_and_handler(irq, &ia64_msi_chip, handle_edge_irq);
+
 	return 0;
 }
 
-static void
-msi_teardown_apic(unsigned int irq)
+void ia64_teardown_msi_irq(unsigned int irq)
 {
 	return;		/* no-op */
 }
 
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
 /*
- * Generic ops used on most IA archs/platforms.  Set with msi_register()
+ * Generic ops used on most IA64 platforms.
  */
-
-struct msi_ops msi_apic_ops = {
-	.needs_64bit_address = 0,
-	.setup = msi_setup_apic,
-	.teardown = msi_teardown_apic,
-	.target = msi_target_apic,
+static struct irq_chip ia64_msi_chip = {
+	.name		= "PCI-MSI",
+	.mask		= mask_msi_irq,
+	.unmask		= unmask_msi_irq,
+	.ack		= ia64_ack_msi_irq,
+#ifdef CONFIG_SMP
+	.set_affinity	= ia64_set_msi_irq_affinity,
+#endif
+	.retrigger	= ia64_msi_retrigger_irq,
 };
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
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index fc7dd2a..f9fdc54 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -15,6 +15,7 @@ #include <linux/ioport.h>
 #include <linux/smp_lock.h>
 #include <linux/pci.h>
 #include <linux/proc_fs.h>
+#include <linux/msi.h>
 
 #include <asm/errno.h>
 #include <asm/io.h>
@@ -29,15 +30,6 @@ static kmem_cache_t* msi_cachep;
 
 static int pci_msi_enable = 1;
 
-static struct msi_ops *msi_ops;
-
-int
-msi_register(struct msi_ops *ops)
-{
-	msi_ops = ops;
-	return 0;
-}
-
 static int msi_cache_init(void)
 {
 	msi_cachep = kmem_cache_create("msi_cache", sizeof(struct msi_desc),
@@ -80,8 +72,9 @@ static void msi_set_mask_bit(unsigned in
 	}
 }
 
-static void read_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
+void read_msi_msg(unsigned int irq, struct msi_msg *msg)
 {
+	struct msi_desc *entry = get_irq_data(irq);
 	switch(entry->msi_attrib.type) {
 	case PCI_CAP_ID_MSI:
 	{
@@ -118,8 +111,9 @@ static void read_msi_msg(struct msi_desc
 	}
 }
 
-static void write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
+void write_msi_msg(unsigned int irq, struct msi_msg *msg)
 {
+	struct msi_desc *entry = get_irq_data(irq);
 	switch (entry->msi_attrib.type) {
 	case PCI_CAP_ID_MSI:
 	{
@@ -157,53 +151,16 @@ static void write_msi_msg(struct msi_des
 	}
 }
 
-#ifdef CONFIG_SMP
-static void set_msi_affinity(unsigned int irq, cpumask_t cpu_mask)
-{
-	struct msi_desc *entry;
-	struct msi_msg msg;
-
-	entry = msi_desc[irq];
-	if (!entry || !entry->dev)
-		return;
-
-	read_msi_msg(entry, &msg);
-	msi_ops->target(irq, cpu_mask, &msg);
-	write_msi_msg(entry, &msg);
-	set_native_irq_info(irq, cpu_mask);
-}
-#else
-#define set_msi_affinity NULL
-#endif /* CONFIG_SMP */
-
-static void mask_MSI_irq(unsigned int irq)
+void mask_msi_irq(unsigned int irq)
 {
 	msi_set_mask_bit(irq, 1);
 }
 
-static void unmask_MSI_irq(unsigned int irq)
+void unmask_msi_irq(unsigned int irq)
 {
 	msi_set_mask_bit(irq, 0);
 }
 
-static void ack_msi_irq(unsigned int irq)
-{
-	move_native_irq(irq);
-	ack_APIC_irq();
-}
-
-/*
- * IRQ Chip for MSI PCI/PCI-X/PCI-Express Devices,
- * which implement the MSI or MSI-X Capability Structure.
- */
-static struct irq_chip msi_chip = {
-	.name		= "PCI-MSI",
-	.unmask		= unmask_MSI_irq,
-	.mask		= mask_MSI_irq,
-	.ack		= ack_msi_irq,
-	.set_affinity	= set_msi_affinity
-};
-
 static int msi_free_irq(struct pci_dev* dev, int irq);
 static int msi_init(void)
 {
@@ -219,22 +176,6 @@ static int msi_init(void)
 		return status;
 	}
 
-	status = msi_arch_init();
-	if (status < 0) {
-		pci_msi_enable = 0;
-		printk(KERN_WARNING
-		       "PCI: MSI arch init failed.  MSI disabled.\n");
-		return status;
-	}
-
-	if (! msi_ops) {
-		pci_msi_enable = 0;
-		printk(KERN_WARNING
-		       "PCI: MSI ops not registered. MSI disabled.\n");
-		status = -EINVAL;
-		return status;
-	}
-
 	status = msi_cache_init();
 	if (status < 0) {
 		pci_msi_enable = 0;
@@ -268,7 +209,7 @@ static void attach_msi_entry(struct msi_
 	spin_unlock_irqrestore(&msi_lock, flags);
 }
 
-static int create_msi_irq(struct irq_chip *chip)
+static int create_msi_irq(void)
 {
 	struct msi_desc *entry;
 	int irq;
@@ -283,7 +224,6 @@ static int create_msi_irq(struct irq_chi
 		return -EBUSY;
 	}
 
-	set_irq_chip_and_handler(irq, chip, handle_edge_irq);
 	set_irq_data(irq, entry);
 
 	return irq;
@@ -473,7 +413,7 @@ int pci_save_msix_state(struct pci_dev *
 		struct msi_desc *entry;
 
 		entry = msi_desc[irq];
-		read_msi_msg(entry, &entry->msg_save);
+		read_msi_msg(irq, &entry->msg_save);
 
 		tail = msi_desc[irq]->link.tail;
 		irq = tail;
@@ -512,7 +452,7 @@ void pci_restore_msix_state(struct pci_d
 	irq = head = dev->irq;
 	while (head != tail) {
 		entry = msi_desc[irq];
-		write_msi_msg(entry, &entry->msg_save);
+		write_msi_msg(irq, &entry->msg_save);
 
 		tail = msi_desc[irq]->link.tail;
 		irq = tail;
@@ -524,39 +464,6 @@ void pci_restore_msix_state(struct pci_d
 }
 #endif
 
-static int msi_register_init(struct pci_dev *dev, struct msi_desc *entry)
-{
-	int status;
-	struct msi_msg msg;
-	int pos;
-	u16 control;
-
-	pos = entry->msi_attrib.pos;
-	pci_read_config_word(dev, msi_control_reg(pos), &control);
-
-	/* Configure MSI capability structure */
-	status = msi_ops->setup(dev, dev->irq, &msg);
-	if (status < 0)
-		return status;
-
-	write_msi_msg(entry, &msg);
-	if (entry->msi_attrib.maskbit) {
-		unsigned int maskbits, temp;
-		/* All MSIs are unmasked by default, Mask them all */
-		pci_read_config_dword(dev,
-			msi_mask_bits_reg(pos, is_64bit_address(control)),
-			&maskbits);
-		temp = (1 << multi_msi_capable(control));
-		temp = ((temp - 1) & ~temp);
-		maskbits |= temp;
-		pci_write_config_dword(dev,
-			msi_mask_bits_reg(pos, is_64bit_address(control)),
-			maskbits);
-	}
-
-	return 0;
-}
-
 /**
  * msi_capability_init - configure device's MSI capability structure
  * @dev: pointer to the pci_dev data structure of MSI device function
@@ -576,7 +483,7 @@ static int msi_capability_init(struct pc
    	pos = pci_find_capability(dev, PCI_CAP_ID_MSI);
 	pci_read_config_word(dev, msi_control_reg(pos), &control);
 	/* MSI Entry Initialization */
-	irq = create_msi_irq(&msi_chip);
+	irq = create_msi_irq();
 	if (irq < 0)
 		return irq;
 
@@ -589,16 +496,27 @@ static int msi_capability_init(struct pc
 	entry->msi_attrib.maskbit = is_mask_bit_support(control);
 	entry->msi_attrib.default_irq = dev->irq;	/* Save IOAPIC IRQ */
 	entry->msi_attrib.pos = pos;
-	dev->irq = irq;
-	entry->dev = dev;
 	if (is_mask_bit_support(control)) {
 		entry->mask_base = (void __iomem *)(long)msi_mask_bits_reg(pos,
 				is_64bit_address(control));
 	}
+	entry->dev = dev;
+	if (entry->msi_attrib.maskbit) {
+		unsigned int maskbits, temp;
+		/* All MSIs are unmasked by default, Mask them all */
+		pci_read_config_dword(dev,
+			msi_mask_bits_reg(pos, is_64bit_address(control)),
+			&maskbits);
+		temp = (1 << multi_msi_capable(control));
+		temp = ((temp - 1) & ~temp);
+		maskbits |= temp;
+		pci_write_config_dword(dev,
+			msi_mask_bits_reg(pos, is_64bit_address(control)),
+			maskbits);
+	}
 	/* Configure MSI capability structure */
-	status = msi_register_init(dev, entry);
-	if (status != 0) {
-		dev->irq = entry->msi_attrib.default_irq;
+	status = arch_setup_msi_irq(irq, dev);
+	if (status < 0) {
 		destroy_msi_irq(irq);
 		return status;
 	}
@@ -607,6 +525,7 @@ static int msi_capability_init(struct pc
 	/* Set MSI enabled bits	 */
 	enable_msi_mode(dev, pos, PCI_CAP_ID_MSI);
 
+	dev->irq = irq;
 	return 0;
 }
 
@@ -624,7 +543,6 @@ static int msix_capability_init(struct p
 				struct msix_entry *entries, int nvec)
 {
 	struct msi_desc *head = NULL, *tail = NULL, *entry = NULL;
-	struct msi_msg msg;
 	int status;
 	int irq, pos, i, j, nr_entries, temp = 0;
 	unsigned long phys_addr;
@@ -648,7 +566,7 @@ static int msix_capability_init(struct p
 
 	/* MSI-X Table Initialization */
 	for (i = 0; i < nvec; i++) {
-		irq = create_msi_irq(&msi_chip);
+		irq = create_msi_irq();
 		if (irq < 0)
 			break;
 
@@ -676,13 +594,12 @@ static int msix_capability_init(struct p
 		temp = irq;
 		tail = entry;
 		/* Configure MSI-X capability structure */
-		status = msi_ops->setup(dev, irq, &msg);
+		status = arch_setup_msi_irq(irq, dev);
 		if (status < 0) {
 			destroy_msi_irq(irq);
 			break;
 		}
 
-		write_msi_msg(entry, &msg);
 		attach_msi_entry(entry, irq);
 	}
 	if (i != nvec) {
@@ -746,7 +663,6 @@ int pci_msi_supported(struct pci_dev * d
 int pci_enable_msi(struct pci_dev* dev)
 {
 	int pos, temp, status;
-	u16 control;
 
 	if (pci_msi_supported(dev) < 0)
 		return -EINVAL;
@@ -761,10 +677,6 @@ int pci_enable_msi(struct pci_dev* dev)
 	if (!pos)
 		return -EINVAL;
 
-	pci_read_config_word(dev, msi_control_reg(pos), &control);
-	if (!is_64bit_address(control) && msi_ops->needs_64bit_address)
-		return -EINVAL;
-
 	WARN_ON(!msi_lookup_irq(dev, PCI_CAP_ID_MSI));
 
 	/* Check whether driver already requested for MSI-X irqs */
@@ -831,7 +743,7 @@ static int msi_free_irq(struct pci_dev* 
 	void __iomem *base;
 	unsigned long flags;
 
-	msi_ops->teardown(irq);
+	arch_teardown_msi_irq(irq);
 
 	spin_lock_irqsave(&msi_lock, flags);
 	entry = msi_desc[irq];
diff --git a/drivers/pci/msi.h b/drivers/pci/msi.h
index 77823bf..f0cca17 100644
--- a/drivers/pci/msi.h
+++ b/drivers/pci/msi.h
@@ -6,8 +6,6 @@
 #ifndef MSI_H
 #define MSI_H
 
-#include <asm/msi.h>
-
 /*
  * MSI-X Address Register
  */
@@ -49,29 +47,4 @@ #define msix_unmask(address)	 	(address 
 #define msix_mask(address)		(address | PCI_MSIX_FLAGS_BITMASK)
 #define msix_is_pending(address) 	(address & PCI_MSIX_FLAGS_PENDMASK)
 
-struct msi_desc {
-	struct {
-		__u8	type	: 5; 	/* {0: unused, 5h:MSI, 11h:MSI-X} */
-		__u8	maskbit	: 1; 	/* mask-pending bit supported ?   */
-		__u8	unused	: 1;
-		__u8	is_64	: 1;	/* Address size: 0=32bit 1=64bit  */
-		__u8	pos;	 	/* Location of the msi capability */
-		__u16	entry_nr;    	/* specific enabled entry 	  */
-		unsigned default_irq;	/* default pre-assigned irq	  */
-	}msi_attrib;
-
-	struct {
-		__u16	head;
-		__u16	tail;
-	}link;
-
-	void __iomem *mask_base;
-	struct pci_dev *dev;
-
-#ifdef CONFIG_PM
-	/* PM save area for MSIX address/data */
-	struct msi_msg msg_save;
-#endif
-};
-
 #endif /* MSI_H */
diff --git a/include/asm-i386/msi.h b/include/asm-i386/msi.h
deleted file mode 100644
index 7368a89..0000000
--- a/include/asm-i386/msi.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- * Copyright (C) 2003-2004 Intel
- * Copyright (C) Tom Long Nguyen (tom.l.nguyen@intel.com)
- */
-
-#ifndef ASM_MSI_H
-#define ASM_MSI_H
-
-#include <asm/desc.h>
-#include <mach_apic.h>
-
-extern struct msi_ops arch_msi_ops;
-
-static inline int msi_arch_init(void)
-{
-	msi_register(&arch_msi_ops);
-	return 0;
-}
-
-#endif /* ASM_MSI_H */
diff --git a/include/asm-ia64/machvec.h b/include/asm-ia64/machvec.h
index 15b545a..90cba96 100644
--- a/include/asm-ia64/machvec.h
+++ b/include/asm-ia64/machvec.h
@@ -20,6 +20,7 @@ struct page;
 struct mm_struct;
 struct pci_bus;
 struct task_struct;
+struct pci_dev;
 
 typedef void ia64_mv_setup_t (char **);
 typedef void ia64_mv_cpu_init_t (void);
@@ -75,7 +76,9 @@ typedef unsigned char ia64_mv_readb_rela
 typedef unsigned short ia64_mv_readw_relaxed_t (const volatile void __iomem *);
 typedef unsigned int ia64_mv_readl_relaxed_t (const volatile void __iomem *);
 typedef unsigned long ia64_mv_readq_relaxed_t (const volatile void __iomem *);
-typedef int ia64_mv_msi_init_t (void);
+
+typedef int ia64_mv_setup_msi_irq_t (unsigned int irq, struct pci_dev *pdev);
+typedef void ia64_mv_teardown_msi_irq_t (unsigned int irq);
 
 static inline void
 machvec_noop (void)
@@ -154,7 +157,8 @@ #  define platform_readw_relaxed        
 #  define platform_readl_relaxed        ia64_mv.readl_relaxed
 #  define platform_readq_relaxed        ia64_mv.readq_relaxed
 #  define platform_migrate		ia64_mv.migrate
-#  define platform_msi_init		ia64_mv.msi_init
+#  define platform_setup_msi_irq	ia64_mv.setup_msi_irq
+#  define platform_teardown_msi_irq	ia64_mv.teardown_msi_irq
 # endif
 
 /* __attribute__((__aligned__(16))) is required to make size of the
@@ -204,7 +208,8 @@ struct ia64_machine_vector {
 	ia64_mv_readl_relaxed_t *readl_relaxed;
 	ia64_mv_readq_relaxed_t *readq_relaxed;
 	ia64_mv_migrate_t *migrate;
-	ia64_mv_msi_init_t *msi_init;
+	ia64_mv_setup_msi_irq_t *setup_msi_irq;
+	ia64_mv_teardown_msi_irq_t *teardown_msi_irq;
 } __attribute__((__aligned__(16))); /* align attrib? see above comment */
 
 #define MACHVEC_INIT(name)			\
@@ -250,7 +255,8 @@ #define MACHVEC_INIT(name)			\
 	platform_readl_relaxed,			\
 	platform_readq_relaxed,			\
 	platform_migrate,			\
-	platform_msi_init,			\
+	platform_setup_msi_irq,			\
+	platform_teardown_msi_irq,		\
 }
 
 extern struct ia64_machine_vector ia64_mv;
@@ -404,8 +410,11 @@ #endif
 #ifndef platform_migrate
 # define platform_migrate machvec_noop_task
 #endif
-#ifndef platform_msi_init
-# define platform_msi_init	((ia64_mv_msi_init_t*)NULL)
+#ifndef platform_setup_msi_irq
+# define platform_setup_msi_irq		((ia64_mv_setup_msi_irq_t*)NULL)
+#endif
+#ifndef platform_teardown_msi_irq
+# define platform_teardown_msi_irq	((ia64_mv_teardown_msi_irq_t*)NULL)
 #endif
 
 #endif /* _ASM_IA64_MACHVEC_H */
diff --git a/include/asm-ia64/machvec_sn2.h b/include/asm-ia64/machvec_sn2.h
index cf724dc..c54b165 100644
--- a/include/asm-ia64/machvec_sn2.h
+++ b/include/asm-ia64/machvec_sn2.h
@@ -67,7 +67,8 @@ extern ia64_mv_dma_sync_sg_for_device	sn
 extern ia64_mv_dma_mapping_error	sn_dma_mapping_error;
 extern ia64_mv_dma_supported		sn_dma_supported;
 extern ia64_mv_migrate_t		sn_migrate;
-extern ia64_mv_msi_init_t		sn_msi_init;
+extern ia64_mv_setup_msi_irq_t		sn_setup_msi_irq;
+extern ia64_mv_teardown_msi_irq_t	sn_teardown_msi_irq;
 
 
 /*
@@ -120,9 +121,11 @@ #define platform_dma_mapping_error		sn_d
 #define platform_dma_supported		sn_dma_supported
 #define platform_migrate		sn_migrate
 #ifdef CONFIG_PCI_MSI
-#define platform_msi_init		sn_msi_init
+#define platform_setup_msi_irq		sn_setup_msi_irq
+#define platform_teardown_msi_irq	sn_teardown_msi_irq
 #else
-#define platform_msi_init		((ia64_mv_msi_init_t*)NULL)
+#define platform_setup_msi_irq		((ia64_mv_setup_msi_irq_t*)NULL)
+#define platform_teardown_msi_irq	((ia64_mv_teardown_msi_irq_t*)NULL)
 #endif
 
 #include <asm/sn/io.h>
diff --git a/include/asm-ia64/msi.h b/include/asm-ia64/msi.h
deleted file mode 100644
index bb92b0d..0000000
--- a/include/asm-ia64/msi.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/*
- * Copyright (C) 2003-2004 Intel
- * Copyright (C) Tom Long Nguyen (tom.l.nguyen@intel.com)
- */
-
-#ifndef ASM_MSI_H
-#define ASM_MSI_H
-
-#define NR_VECTORS		NR_IRQS
-#define FIRST_DEVICE_VECTOR 	IA64_FIRST_DEVICE_VECTOR
-#define LAST_DEVICE_VECTOR	IA64_LAST_DEVICE_VECTOR
-static inline void set_intr_gate (int nr, void *func) {}
-#define IO_APIC_VECTOR(irq)	(irq)
-#define ack_APIC_irq		ia64_eoi
-#define MSI_TARGET_CPU_SHIFT	4
-
-extern struct msi_ops msi_apic_ops;
-
-static inline int msi_arch_init(void)
-{
-	if (platform_msi_init)
-		return platform_msi_init();
-
-	/* default ops for most ia64 platforms */
-	msi_register(&msi_apic_ops);
-	return 0;
-}
-
-#endif /* ASM_MSI_H */
diff --git a/include/asm-x86_64/msi.h b/include/asm-x86_64/msi.h
deleted file mode 100644
index 1876fda..0000000
--- a/include/asm-x86_64/msi.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- * Copyright (C) 2003-2004 Intel
- * Copyright (C) Tom Long Nguyen (tom.l.nguyen@intel.com)
- */
-
-#ifndef ASM_MSI_H
-#define ASM_MSI_H
-
-#include <asm/desc.h>
-#include <asm/mach_apic.h>
-#include <asm/smp.h>
-
-extern struct msi_ops arch_msi_ops;
-
-static inline int msi_arch_init(void)
-{
-	msi_register(&arch_msi_ops);
-	return 0;
-}
-
-#endif /* ASM_MSI_H */
diff --git a/include/linux/msi.h b/include/linux/msi.h
new file mode 100644
index 0000000..c7ef943
--- /dev/null
+++ b/include/linux/msi.h
@@ -0,0 +1,49 @@
+#ifndef LINUX_MSI_H
+#define LINUX_MSI_H
+
+struct msi_msg {
+	u32	address_lo;	/* low 32 bits of msi message address */
+	u32	address_hi;	/* high 32 bits of msi message address */
+	u32	data;		/* 16 bits of msi message data */
+};
+
+/* Heper functions */
+extern void mask_msi_irq(unsigned int irq);
+extern void unmask_msi_irq(unsigned int irq);
+extern void read_msi_msg(unsigned int irq, struct msi_msg *msg);
+
+extern void write_msi_msg(unsigned int irq, struct msi_msg *msg);
+
+struct msi_desc {
+	struct {
+		__u8	type	: 5; 	/* {0: unused, 5h:MSI, 11h:MSI-X} */
+		__u8	maskbit	: 1; 	/* mask-pending bit supported ?   */
+		__u8	unused	: 1;
+		__u8	is_64	: 1;	/* Address size: 0=32bit 1=64bit  */
+		__u8	pos;	 	/* Location of the msi capability */
+		__u16	entry_nr;    	/* specific enabled entry 	  */
+		unsigned default_irq;	/* default pre-assigned irq	  */
+	}msi_attrib;
+
+	struct {
+		__u16	head;
+		__u16	tail;
+	}link;
+
+	void __iomem *mask_base;
+	struct pci_dev *dev;
+
+#ifdef CONFIG_PM
+	/* PM save area for MSIX address/data */
+	struct msi_msg msg_save;
+#endif
+};
+
+/*
+ * The arch hook for setup up msi irqs
+ */
+int arch_setup_msi_irq(unsigned int irq, struct pci_dev *dev);
+void arch_teardown_msi_irq(unsigned int irq);
+
+
+#endif /* LINUX_MSI_H */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 64cae66..9fa0740 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -599,11 +599,6 @@ struct msix_entry {
 	u16	entry;	/* driver uses to specify entry, OS writes */
 };
 
-struct msi_msg {
-	u32	address_lo;	/* low 32 bits of msi message address */
-	u32	address_hi;	/* high 32 bits of msi message address */
-	u32	data;		/* 16 bits of msi message data */
-};
 
 #ifndef CONFIG_PCI_MSI
 static inline void pci_scan_msi_device(struct pci_dev *dev) {}
@@ -621,68 +616,6 @@ extern int pci_enable_msix(struct pci_de
 	struct msix_entry *entries, int nvec);
 extern void pci_disable_msix(struct pci_dev *dev);
 extern void msi_remove_pci_irq_vectors(struct pci_dev *dev);
-
-/*
- * MSI operation vector.  Used by the msi core code (drivers/pci/msi.c)
- * to abstract platform-specific tasks relating to MSI address generation
- * and resource management.
- */
-struct msi_ops {
-	int needs_64bit_address;
-	/**
-	 * setup - generate an MSI bus address and data for a given vector
-	 * @pdev: PCI device context (in)
-	 * @irq: irq allocated by the msi core (in)
-	 * @msg: PCI bus address and data for msi message (out)
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
-	 **/
-
-	int	(*setup)    (struct pci_dev *pdev, unsigned int irq,
-			     struct msi_msg *msg);
-
-	/**
-	 * teardown - release resources allocated by setup
-	 * @vector: vector context for resources (in)
-	 *
-	 * Description:  The teardown op is used to release any resources
-	 * that were allocated in the setup routine associated with the passed
-	 * in vector.
-	 **/
-
-	void	(*teardown) (unsigned int irq);
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
-	 **/
-
-	void	(*target)   (unsigned int irq, cpumask_t cpumask,
-			     struct msi_msg *msg);
-};
-
-extern int msi_register(struct msi_ops *ops);
-
 #endif
 
 #ifdef CONFIG_HT_IRQ
-- 
1.4.2.rc3.g7e18e-dirty

