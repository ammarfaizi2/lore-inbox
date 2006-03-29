Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbWC2Cbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWC2Cbu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 21:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWC2Cb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 21:31:29 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:32734 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750791AbWC2Cb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 21:31:26 -0500
Date: Tue, 28 Mar 2006 20:31:11 -0600 (CST)
From: Mark Maule <maule@sgi.com>
To: linuxppc64-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: j-nomura@ce.jp.nec.com, Tony Luck <tony.luck@intel.com>, gregkh@suse.de,
       Mark Maule <maule@sgi.com>
Message-Id: <20060329023111.13892.94826.67421@lnx-maule.americas.sgi.com>
In-Reply-To: <20060329023105.13892.52299.24895@lnx-maule.americas.sgi.com>
References: <20060329023105.13892.52299.24895@lnx-maule.americas.sgi.com>
Subject: [PATCH 1/3] msi vector targeting abstractions
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Abstract portions of the MSI core for platforms that do not use standard
APIC interrupt controllers.  This is implemented through a new arch-specific
msi setup routine, and a set of msi ops which can be set on a per platform
basis.

Signed-off-by: Mark Maule <maule@sgi.com>

Index: linux-2.6/drivers/pci/msi.c
===================================================================
--- linux-2.6.orig/drivers/pci/msi.c	2006-03-27 11:11:04.000000000 -0600
+++ linux-2.6/drivers/pci/msi.c	2006-03-27 13:32:56.192398615 -0600
@@ -23,8 +23,6 @@
 #include "pci.h"
 #include "msi.h"
 
-#define MSI_TARGET_CPU		first_cpu(cpu_online_map)
-
 static DEFINE_SPINLOCK(msi_lock);
 static struct msi_desc* msi_desc[NR_IRQS] = { [0 ... NR_IRQS-1] = NULL };
 static kmem_cache_t* msi_cachep;
@@ -40,6 +38,15 @@
 u8 irq_vector[NR_IRQ_VECTORS] = { FIRST_DEVICE_VECTOR , 0 };
 #endif
 
+static struct msi_ops *msi_ops;
+
+int
+msi_register(struct msi_ops *ops)
+{
+	msi_ops = ops;
+	return 0;
+}
+
 static void msi_cache_ctor(void *p, kmem_cache_t *cache, unsigned long flags)
 {
 	memset(p, 0, NR_IRQS * sizeof(struct msi_desc));
@@ -92,7 +99,7 @@
 static void set_msi_affinity(unsigned int vector, cpumask_t cpu_mask)
 {
 	struct msi_desc *entry;
-	struct msg_address address;
+	u32 address_hi, address_lo;
 	unsigned int irq = vector;
 	unsigned int dest_cpu = first_cpu(cpu_mask);
 
@@ -108,28 +115,36 @@
 		if (!pos)
 			return;
 
+		pci_read_config_dword(entry->dev, msi_upper_address_reg(pos),
+			&address_hi);
 		pci_read_config_dword(entry->dev, msi_lower_address_reg(pos),
-			&address.lo_address.value);
-		address.lo_address.value &= MSI_ADDRESS_DEST_ID_MASK;
-		address.lo_address.value |= (cpu_physical_id(dest_cpu) <<
-									MSI_TARGET_CPU_SHIFT);
-		entry->msi_attrib.current_cpu = cpu_physical_id(dest_cpu);
+			&address_lo);
+
+		msi_ops->target(vector, dest_cpu, &address_hi, &address_lo);
+
+		pci_write_config_dword(entry->dev, msi_upper_address_reg(pos),
+			address_hi);
 		pci_write_config_dword(entry->dev, msi_lower_address_reg(pos),
-			address.lo_address.value);
+			address_lo);
 		set_native_irq_info(irq, cpu_mask);
 		break;
 	}
 	case PCI_CAP_ID_MSIX:
 	{
-		int offset = entry->msi_attrib.entry_nr * PCI_MSIX_ENTRY_SIZE +
-			PCI_MSIX_ENTRY_LOWER_ADDR_OFFSET;
+		int offset_hi =
+			entry->msi_attrib.entry_nr * PCI_MSIX_ENTRY_SIZE +
+				PCI_MSIX_ENTRY_UPPER_ADDR_OFFSET;
+		int offset_lo =
+			entry->msi_attrib.entry_nr * PCI_MSIX_ENTRY_SIZE +
+				PCI_MSIX_ENTRY_LOWER_ADDR_OFFSET;
 
-		address.lo_address.value = readl(entry->mask_base + offset);
-		address.lo_address.value &= MSI_ADDRESS_DEST_ID_MASK;
-		address.lo_address.value |= (cpu_physical_id(dest_cpu) <<
-									MSI_TARGET_CPU_SHIFT);
-		entry->msi_attrib.current_cpu = cpu_physical_id(dest_cpu);
-		writel(address.lo_address.value, entry->mask_base + offset);
+		address_hi = readl(entry->mask_base + offset_hi);
+		address_lo = readl(entry->mask_base + offset_lo);
+
+		msi_ops->target(vector, dest_cpu, &address_hi, &address_lo);
+
+		writel(address_hi, entry->mask_base + offset_hi);
+		writel(address_lo, entry->mask_base + offset_lo);
 		set_native_irq_info(irq, cpu_mask);
 		break;
 	}
@@ -251,30 +266,6 @@
 	.set_affinity	= set_msi_affinity
 };
 
-static void msi_data_init(struct msg_data *msi_data,
-			  unsigned int vector)
-{
-	memset(msi_data, 0, sizeof(struct msg_data));
-	msi_data->vector = (u8)vector;
-	msi_data->delivery_mode = MSI_DELIVERY_MODE;
-	msi_data->level = MSI_LEVEL_MODE;
-	msi_data->trigger = MSI_TRIGGER_MODE;
-}
-
-static void msi_address_init(struct msg_address *msi_address)
-{
-	unsigned int	dest_id;
-	unsigned long	dest_phys_id = cpu_physical_id(MSI_TARGET_CPU);
-
-	memset(msi_address, 0, sizeof(struct msg_address));
-	msi_address->hi_address = (u32)0;
-	dest_id = (MSI_ADDRESS_HEADER << MSI_ADDRESS_HEADER_SHIFT);
-	msi_address->lo_address.u.dest_mode = MSI_PHYSICAL_MODE;
-	msi_address->lo_address.u.redirection_hint = MSI_REDIRECTION_HINT_MODE;
-	msi_address->lo_address.u.dest_id = dest_id;
-	msi_address->lo_address.value |= (dest_phys_id << MSI_TARGET_CPU_SHIFT);
-}
-
 static int msi_free_vector(struct pci_dev* dev, int vector, int reassign);
 static int assign_msi_vector(void)
 {
@@ -369,13 +360,29 @@
 		return status;
 	}
 
+	status = msi_arch_init();
+	if (status < 0) {
+		pci_msi_enable = 0;
+		printk(KERN_WARNING
+		       "PCI: MSI arch init failed.  MSI disabled.\n");
+		return status;
+	}
+
+	if (! msi_ops) {
+		printk(KERN_WARNING
+		       "PCI: MSI ops not registered. MSI disabled.\n");
+		status = -EINVAL;
+		return status;
+	}
+
+	last_alloc_vector = assign_irq_vector(AUTO_ASSIGN);
 	status = msi_cache_init();
 	if (status < 0) {
 		pci_msi_enable = 0;
 		printk(KERN_WARNING "PCI: MSI cache init failed\n");
 		return status;
 	}
-	last_alloc_vector = assign_irq_vector(AUTO_ASSIGN);
+
 	if (last_alloc_vector < 0) {
 		pci_msi_enable = 0;
 		printk(KERN_WARNING "PCI: No interrupt vectors available for MSI\n");
@@ -515,9 +522,11 @@
  **/
 static int msi_capability_init(struct pci_dev *dev)
 {
+	int status;
 	struct msi_desc *entry;
-	struct msg_address address;
-	struct msg_data data;
+	u32 address_lo;
+	u32 address_hi;
+	u32 data;
 	int pos, vector;
 	u16 control;
 
@@ -546,23 +555,27 @@
 		entry->mask_base = (void __iomem *)(long)msi_mask_bits_reg(pos,
 				is_64bit_address(control));
 	}
+	/* Configure MSI capability structure */
+	status = msi_ops->setup(dev, vector,
+				&address_hi,
+				&address_lo,
+				&data);
+	if (status < 0) {
+		dev->irq = entry->msi_attrib.default_vector;
+		kmem_cache_free(msi_cachep, entry);
+		return status;
+	}
 	/* Replace with MSI handler */
 	irq_handler_init(PCI_CAP_ID_MSI, vector, entry->msi_attrib.maskbit);
-	/* Configure MSI capability structure */
-	msi_address_init(&address);
-	msi_data_init(&data, vector);
-	entry->msi_attrib.current_cpu = ((address.lo_address.u.dest_id >>
-				MSI_TARGET_CPU_SHIFT) & MSI_TARGET_CPU_MASK);
-	pci_write_config_dword(dev, msi_lower_address_reg(pos),
-			address.lo_address.value);
+
+	pci_write_config_dword(dev, msi_lower_address_reg(pos), address_lo);
 	if (is_64bit_address(control)) {
 		pci_write_config_dword(dev,
-			msi_upper_address_reg(pos), address.hi_address);
-		pci_write_config_word(dev,
-			msi_data_reg(pos, 1), *((u32*)&data));
+			msi_upper_address_reg(pos), address_hi);
+		pci_write_config_word(dev, msi_data_reg(pos, 1), data);
 	} else
-		pci_write_config_word(dev,
-			msi_data_reg(pos, 0), *((u32*)&data));
+		pci_write_config_word(dev, msi_data_reg(pos, 0), data);
+
 	if (entry->msi_attrib.maskbit) {
 		unsigned int maskbits, temp;
 		/* All MSIs are unmasked by default, Mask them all */
@@ -652,18 +665,20 @@
 		/* Replace with MSI-X handler */
 		irq_handler_init(PCI_CAP_ID_MSIX, vector, 1);
 		/* Configure MSI-X capability structure */
-		msi_address_init(&address);
-		msi_data_init(&data, vector);
-		entry->msi_attrib.current_cpu =
-			((address.lo_address.u.dest_id >>
-			MSI_TARGET_CPU_SHIFT) & MSI_TARGET_CPU_MASK);
-		writel(address.lo_address.value,
+		status = msi_ops->setup(dev, vector,
+					&address_hi,
+					&address_lo,
+					&data);
+		if (status < 0)
+			break;
+
+		writel(address_lo,
 			base + j * PCI_MSIX_ENTRY_SIZE +
 			PCI_MSIX_ENTRY_LOWER_ADDR_OFFSET);
-		writel(address.hi_address,
+		writel(address_hi,
 			base + j * PCI_MSIX_ENTRY_SIZE +
 			PCI_MSIX_ENTRY_UPPER_ADDR_OFFSET);
-		writel(*(u32*)&data,
+		writel(data,
 			base + j * PCI_MSIX_ENTRY_SIZE +
 			PCI_MSIX_ENTRY_DATA_OFFSET);
 		attach_msi_entry(entry, vector);
@@ -809,6 +824,8 @@
 	void __iomem *base;
 	unsigned long flags;
 
+	msi_ops->teardown(vector);
+
 	spin_lock_irqsave(&msi_lock, flags);
 	entry = msi_desc[vector];
 	if (!entry || entry->dev != dev) {
Index: linux-2.6/include/asm-i386/msi.h
===================================================================
--- linux-2.6.orig/include/asm-i386/msi.h	2006-03-27 11:11:06.000000000 -0600
+++ linux-2.6/include/asm-i386/msi.h	2006-03-27 13:22:19.533603545 -0600
@@ -12,4 +12,12 @@
 #define LAST_DEVICE_VECTOR		232
 #define MSI_TARGET_CPU_SHIFT	12
 
+extern struct msi_ops msi_apic_ops;
+
+static inline int msi_arch_init(void)
+{
+	msi_register(&msi_apic_ops);
+	return 0;
+}
+
 #endif /* ASM_MSI_H */
Index: linux-2.6/include/asm-x86_64/msi.h
===================================================================
--- linux-2.6.orig/include/asm-x86_64/msi.h	2006-03-27 11:11:07.000000000 -0600
+++ linux-2.6/include/asm-x86_64/msi.h	2006-03-27 13:22:19.536532943 -0600
@@ -13,4 +13,12 @@
 #define LAST_DEVICE_VECTOR		232
 #define MSI_TARGET_CPU_SHIFT	12
 
+extern struct msi_ops msi_apic_ops;
+
+static inline int msi_arch_init(void)
+{
+	msi_register(&msi_apic_ops);
+	return 0;
+}
+
 #endif /* ASM_MSI_H */
Index: linux-2.6/include/asm-ia64/machvec.h
===================================================================
--- linux-2.6.orig/include/asm-ia64/machvec.h	2006-03-27 11:11:06.000000000 -0600
+++ linux-2.6/include/asm-ia64/machvec.h	2006-03-27 13:27:36.669263094 -0600
@@ -76,6 +76,7 @@
 typedef unsigned short ia64_mv_readw_relaxed_t (const volatile void __iomem *);
 typedef unsigned int ia64_mv_readl_relaxed_t (const volatile void __iomem *);
 typedef unsigned long ia64_mv_readq_relaxed_t (const volatile void __iomem *);
+typedef int ia64_mv_msi_init_t (void);
 
 static inline void
 machvec_noop (void)
@@ -154,6 +155,7 @@
 #  define platform_readl_relaxed        ia64_mv.readl_relaxed
 #  define platform_readq_relaxed        ia64_mv.readq_relaxed
 #  define platform_migrate		ia64_mv.migrate
+#  define platform_msi_init		ia64_mv.msi_init
 # endif
 
 /* __attribute__((__aligned__(16))) is required to make size of the
@@ -203,6 +205,7 @@
 	ia64_mv_readl_relaxed_t *readl_relaxed;
 	ia64_mv_readq_relaxed_t *readq_relaxed;
 	ia64_mv_migrate_t *migrate;
+	ia64_mv_msi_init_t *msi_init;
 } __attribute__((__aligned__(16))); /* align attrib? see above comment */
 
 #define MACHVEC_INIT(name)			\
@@ -248,6 +251,7 @@
 	platform_readl_relaxed,			\
 	platform_readq_relaxed,			\
 	platform_migrate,			\
+	platform_msi_init,			\
 }
 
 extern struct ia64_machine_vector ia64_mv;
@@ -399,5 +403,8 @@
 #ifndef platform_migrate
 # define platform_migrate machvec_noop_task
 #endif
+#ifndef platform_msi_init
+# define platform_msi_init	((ia64_mv_msi_init_t*)NULL)
+#endif
 
 #endif /* _ASM_IA64_MACHVEC_H */
Index: linux-2.6/include/asm-ia64/machvec_sn2.h
===================================================================
--- linux-2.6.orig/include/asm-ia64/machvec_sn2.h	2006-03-27 11:11:06.000000000 -0600
+++ linux-2.6/include/asm-ia64/machvec_sn2.h	2006-03-27 13:29:15.149771095 -0600
@@ -117,6 +117,11 @@
 #define platform_dma_mapping_error		sn_dma_mapping_error
 #define platform_dma_supported		sn_dma_supported
 #define platform_migrate		sn_migrate
+#ifdef CONFIG_PCI_MSI
+#define platform_msi_init		sn_msi_init
+#else
+#define platform_msi_init		((ia64_mv_msi_init_t*)NULL)
+#endif
 
 #include <asm/sn/io.h>
 
Index: linux-2.6/include/asm-ia64/msi.h
===================================================================
--- linux-2.6.orig/include/asm-ia64/msi.h	2006-03-27 11:11:06.000000000 -0600
+++ linux-2.6/include/asm-ia64/msi.h	2006-03-27 13:22:19.540438807 -0600
@@ -14,4 +14,16 @@
 #define ack_APIC_irq		ia64_eoi
 #define MSI_TARGET_CPU_SHIFT	4
 
+extern struct msi_ops msi_apic_ops;
+
+static inline int msi_arch_init(void)
+{
+	if (platform_msi_init)
+		return platform_msi_init();
+
+	/* default ops for most ia64 platforms */
+	msi_register(&msi_apic_ops);
+	return 0;
+}
+
 #endif /* ASM_MSI_H */
Index: linux-2.6/drivers/pci/Makefile
===================================================================
--- linux-2.6.orig/drivers/pci/Makefile	2006-03-27 11:11:03.000000000 -0600
+++ linux-2.6/drivers/pci/Makefile	2006-03-27 13:22:19.540438807 -0600
@@ -26,7 +26,11 @@
 obj-$(CONFIG_PPC64) += setup-bus.o
 obj-$(CONFIG_MIPS) += setup-bus.o setup-irq.o
 obj-$(CONFIG_X86_VISWS) += setup-irq.o
-obj-$(CONFIG_PCI_MSI) += msi.o
+
+msiobj-y := msi.o msi-apic.o
+msiobj-$(CONFIG_IA64_GENERIC) += msi-altix.o
+msiobj-$(CONFIG_IA64_SGI_SN2) += msi-altix.o
+obj-$(CONFIG_PCI_MSI) += $(msiobj-y)
 
 #
 # ACPI Related PCI FW Functions
Index: linux-2.6/drivers/pci/msi-apic.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/drivers/pci/msi-apic.c	2006-03-27 13:22:19.541415273 -0600
@@ -0,0 +1,100 @@
+/*
+ * MSI hooks for standard x86 apic
+ */
+
+#include <linux/pci.h>
+#include <linux/irq.h>
+
+#include "msi.h"
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
+
+static void
+msi_target_apic(unsigned int vector,
+		unsigned int dest_cpu,
+		u32 *address_hi,	/* in/out */
+		u32 *address_lo)	/* in/out */
+{
+	u32 addr = *address_lo;
+
+	addr &= MSI_ADDR_DESTID_MASK;
+	addr |= MSI_ADDR_DESTID_CPU(cpu_physical_id(dest_cpu));
+
+	*address_lo = addr;
+}
+
+static int
+msi_setup_apic(struct pci_dev *pdev,	/* unused in generic */
+		unsigned int vector,
+		u32 *address_hi,
+		u32 *address_lo,
+		u32 *data)
+{
+	unsigned long	dest_phys_id;
+
+	dest_phys_id = cpu_physical_id(first_cpu(cpu_online_map));
+
+	*address_hi = 0;
+	*address_lo =	MSI_ADDR_HEADER |
+			MSI_ADDR_DESTMODE_PHYS |
+			MSI_ADDR_REDIRECTION_CPU |
+			MSI_ADDR_DESTID_CPU(dest_phys_id);
+
+	*data = MSI_DATA_TRIGGER_EDGE |
+		MSI_DATA_LEVEL_ASSERT |
+		MSI_DATA_DELIVERY_FIXED |
+		MSI_DATA_VECTOR(vector);
+
+	return 0;
+}
+
+static void
+msi_teardown_apic(unsigned int vector)
+{
+	return;		/* no-op */
+}
+
+/*
+ * Generic ops used on most IA archs/platforms.  Set with msi_register()
+ */
+
+struct msi_ops msi_apic_ops = {
+	.setup = msi_setup_apic,
+	.teardown = msi_teardown_apic,
+	.target = msi_target_apic,
+};
Index: linux-2.6/drivers/pci/msi.h
===================================================================
--- linux-2.6.orig/drivers/pci/msi.h	2006-03-27 11:11:04.000000000 -0600
+++ linux-2.6/drivers/pci/msi.h	2006-03-27 13:22:19.542391739 -0600
@@ -6,6 +6,68 @@
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
+	 **/
+
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
+	 **/
+
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
+	 **/
+
+	void	(*target)   (unsigned int vector, unsigned int cpu,
+			     u32 *addr_hi, u32 *addr_lo);
+};
+
+extern int msi_register(struct msi_ops *ops);
+
 #include <asm/msi.h>
 
 /*
@@ -63,67 +125,6 @@
 #define msix_mask(address)		(address | PCI_MSIX_FLAGS_BITMASK)
 #define msix_is_pending(address) 	(address & PCI_MSIX_FLAGS_PENDMASK)
 
-/*
- * MSI Defined Data Structures
- */
-#define MSI_ADDRESS_HEADER		0xfee
-#define MSI_ADDRESS_HEADER_SHIFT	12
-#define MSI_ADDRESS_HEADER_MASK		0xfff000
-#define MSI_ADDRESS_DEST_ID_MASK	0xfff0000f
-#define MSI_TARGET_CPU_MASK		0xff
-#define MSI_DELIVERY_MODE		0
-#define MSI_LEVEL_MODE			1	/* Edge always assert */
-#define MSI_TRIGGER_MODE		0	/* MSI is edge sensitive */
-#define MSI_PHYSICAL_MODE		0
-#define MSI_LOGICAL_MODE		1
-#define MSI_REDIRECTION_HINT_MODE	0
-
-struct msg_data {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-	__u32	vector		:  8;
-	__u32	delivery_mode	:  3;	/* 000b: FIXED | 001b: lowest prior */
-	__u32	reserved_1	:  3;
-	__u32	level		:  1;	/* 0: deassert | 1: assert */
-	__u32	trigger		:  1;	/* 0: edge | 1: level */
-	__u32	reserved_2	: 16;
-#elif defined(__BIG_ENDIAN_BITFIELD)
-	__u32	reserved_2	: 16;
-	__u32	trigger		:  1;	/* 0: edge | 1: level */
-	__u32	level		:  1;	/* 0: deassert | 1: assert */
-	__u32	reserved_1	:  3;
-	__u32	delivery_mode	:  3;	/* 000b: FIXED | 001b: lowest prior */
-	__u32	vector		:  8;
-#else
-#error "Bitfield endianness not defined! Check your byteorder.h"
-#endif
-} __attribute__ ((packed));
-
-struct msg_address {
-	union {
-		struct {
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-			__u32	reserved_1	:  2;
-			__u32	dest_mode	:  1;	/*0:physic | 1:logic */
-			__u32	redirection_hint:  1;  	/*0: dedicated CPU
-							  1: lowest priority */
-			__u32	reserved_2	:  4;
- 			__u32	dest_id		: 24;	/* Destination ID */
-#elif defined(__BIG_ENDIAN_BITFIELD)
- 			__u32	dest_id		: 24;	/* Destination ID */
-			__u32	reserved_2	:  4;
-			__u32	redirection_hint:  1;  	/*0: dedicated CPU
-							  1: lowest priority */
-			__u32	dest_mode	:  1;	/*0:physic | 1:logic */
-			__u32	reserved_1	:  2;
-#else
-#error "Bitfield endianness not defined! Check your byteorder.h"
-#endif
-      		}u;
-       		__u32  value;
-	}lo_address;
-	__u32 	hi_address;
-} __attribute__ ((packed));
-
 struct msi_desc {
 	struct {
 		__u8	type	: 5; 	/* {0: unused, 5h:MSI, 11h:MSI-X} */
@@ -132,7 +133,7 @@
 		__u8	reserved: 1; 	/* reserved			  */
 		__u8	entry_nr;    	/* specific enabled entry 	  */
 		__u8	default_vector; /* default pre-assigned vector    */
-		__u8	current_cpu; 	/* current destination cpu	  */
+		__u8	unused; 	/* formerly unused destination cpu*/
 	}msi_attrib;
 
 	struct {
Index: linux-2.6/drivers/pci/msi-altix.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/drivers/pci/msi-altix.c	2006-03-27 13:22:19.543368205 -0600
@@ -0,0 +1,18 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2006 Silicon Graphics, Inc.  All Rights Reserved.
+ */
+
+#include <asm/errno.h>
+
+int
+sn_msi_init(void)
+{
+	/*
+	 * return error until MSI is supported on altix platforms
+	 */
+	return -EINVAL;
+}
