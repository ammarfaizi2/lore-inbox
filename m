Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751176AbVLUSox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbVLUSox (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 13:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbVLUSoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 13:44:21 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:50374 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751169AbVLUSnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 13:43:52 -0500
Date: Wed, 21 Dec 2005 12:42:41 -0600 (CST)
From: Mark Maule <maule@sgi.com>
To: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tony Luck <tony.luck@intel.com>, Mark Maule <maule@sgi.com>
Message-Id: <20051221184348.5003.7540.53186@attica.americas.sgi.com>
In-Reply-To: <20051221184337.5003.85653.32527@attica.americas.sgi.com>
References: <20051221184337.5003.85653.32527@attica.americas.sgi.com>
Subject: [PATCH 2/4] msi vector targeting abstractions
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Abstract portions of the MSI core for platforms that do not use standard
APIC interrupt controllers.  This is implemented through a set of callouts
which default to current behavior, but which can be overridden by calling
msi_register_callouts() in the platform msi init code.

Signed-off-by: Mark Maule <maule@sgi.com>

Index: msi/drivers/pci/msi.c
===================================================================
--- msi.orig/drivers/pci/msi.c	2005-12-19 15:34:28.427921393 -0600
+++ msi/drivers/pci/msi.c	2005-12-19 18:22:03.290742240 -0600
@@ -40,6 +40,8 @@
 u8 irq_vector[NR_IRQ_VECTORS] = { FIRST_DEVICE_VECTOR , 0 };
 #endif
 
+static struct msi_callouts msi_callouts;
+
 static void msi_cache_ctor(void *p, kmem_cache_t *cache, unsigned long flags)
 {
 	memset(p, 0, NR_IRQS * sizeof(struct msi_desc));
@@ -89,10 +91,25 @@
 }
 
 #ifdef CONFIG_SMP
+static void msi_target_generic(unsigned int vector,
+			       unsigned int dest_cpu,
+			       uint32_t *address_hi,	/* in/out */
+			       uint32_t *address_lo)	/* in/out */
+{
+	struct msg_address address;
+
+	address.lo_address.value = *address_lo;
+	address.lo_address.value &= MSI_ADDRESS_DEST_ID_MASK;
+	address.lo_address.value |=
+		(cpu_physical_id(dest_cpu) << MSI_TARGET_CPU_SHIFT);
+
+	*address_lo = address.lo_address.value;
+}
+
 static void set_msi_affinity(unsigned int vector, cpumask_t cpu_mask)
 {
 	struct msi_desc *entry;
-	struct msg_address address;
+	uint32_t address_hi, address_lo;
 	unsigned int irq = vector;
 	unsigned int dest_cpu = first_cpu(cpu_mask);
 
@@ -108,28 +125,38 @@
    		if (!(pos = pci_find_capability(entry->dev, PCI_CAP_ID_MSI)))
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
+		msi_callouts.msi_target(vector, dest_cpu,
+					&address_hi, &address_lo);
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
+
+		address_hi = readl(entry->mask_base + offset_hi);
+		address_lo = readl(entry->mask_base + offset_lo);
+
+		msi_callouts.msi_target(vector, dest_cpu,
+					&address_hi, &address_lo);
 
-		address.lo_address.value = readl(entry->mask_base + offset);
-		address.lo_address.value &= MSI_ADDRESS_DEST_ID_MASK;
-		address.lo_address.value |= (cpu_physical_id(dest_cpu) <<
-									MSI_TARGET_CPU_SHIFT);
-		entry->msi_attrib.current_cpu = cpu_physical_id(dest_cpu);
-		writel(address.lo_address.value, entry->mask_base + offset);
+		writel(address_hi, entry->mask_base + offset_hi);
+		writel(address_lo, entry->mask_base + offset_lo);
 		set_native_irq_info(irq, cpu_mask);
 		break;
 	}
@@ -249,28 +276,43 @@
 	.set_affinity	= set_msi_irq_affinity
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
+static int
+msi_setup_generic(struct pci_dev *pdev,	/* unused in generic */
+		  unsigned int vector,
+		  uint32_t *address_hi,
+		  uint32_t *address_lo,
+		  uint32_t *data)
 {
 	unsigned int	dest_id;
 	unsigned long	dest_phys_id = cpu_physical_id(MSI_TARGET_CPU);
+	struct msg_address msi_address;
+	union msg_data msi_data;
 
-	memset(msi_address, 0, sizeof(struct msg_address));
-	msi_address->hi_address = (u32)0;
+	memset(&msi_address, 0, sizeof(struct msg_address));
+	msi_address.hi_address = (u32)0;
 	dest_id = (MSI_ADDRESS_HEADER << MSI_ADDRESS_HEADER_SHIFT);
-	msi_address->lo_address.u.dest_mode = MSI_PHYSICAL_MODE;
-	msi_address->lo_address.u.redirection_hint = MSI_REDIRECTION_HINT_MODE;
-	msi_address->lo_address.u.dest_id = dest_id;
-	msi_address->lo_address.value |= (dest_phys_id << MSI_TARGET_CPU_SHIFT);
+	msi_address.lo_address.u.dest_mode = MSI_PHYSICAL_MODE;
+	msi_address.lo_address.u.redirection_hint = MSI_REDIRECTION_HINT_MODE;
+	msi_address.lo_address.u.dest_id = dest_id;
+	msi_address.lo_address.value |= (dest_phys_id << MSI_TARGET_CPU_SHIFT);
+
+	memset(&msi_data, 0, sizeof(union msg_data));
+	msi_data.u.vector = (u8)vector;
+	msi_data.u.delivery_mode = MSI_DELIVERY_MODE;
+	msi_data.u.level = MSI_LEVEL_MODE;
+	msi_data.u.trigger = MSI_TRIGGER_MODE;
+
+	*address_hi = msi_address.hi_address;
+	*address_lo = msi_address.lo_address.value;
+	*data = msi_data.value;
+
+	return 0;
+}
+
+void
+msi_teardown_generic(unsigned int vector)
+{
+	return;		/* no-op in most archs */
 }
 
 static int msi_free_vector(struct pci_dev* dev, int vector, int reassign);
@@ -517,9 +559,10 @@
  **/
 static int msi_capability_init(struct pci_dev *dev)
 {
+	int status;
 	struct msi_desc *entry;
 	struct msg_address address;
-	struct msg_data data;
+	union msg_data data;
 	int pos, vector;
 	u16 control;
 
@@ -546,13 +589,18 @@
 		entry->mask_base = (void __iomem *)(long)msi_mask_bits_reg(pos,
 				is_64bit_address(control));
 	}
+	/* Configure MSI capability structure */
+	status = msi_callouts.msi_setup(dev, vector,
+					&address.hi_address,
+					&address.lo_address.value,
+					&data.value);
+	if (status < 0) {
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
+
 	pci_write_config_dword(dev, msi_lower_address_reg(pos),
 			address.lo_address.value);
 	if (is_64bit_address(control)) {
@@ -598,12 +646,13 @@
 {
 	struct msi_desc *head = NULL, *tail = NULL, *entry = NULL;
 	struct msg_address address;
-	struct msg_data data;
+	union msg_data data;
 	int vector, pos, i, j, nr_entries, temp = 0;
 	u32 phys_addr, table_offset;
  	u16 control;
 	u8 bir;
 	void __iomem *base;
+	int status;
 
    	pos = pci_find_capability(dev, PCI_CAP_ID_MSIX);
 	/* Request & Map MSI-X table region */
@@ -650,11 +699,13 @@
 		/* Replace with MSI-X handler */
 		irq_handler_init(PCI_CAP_ID_MSIX, vector, 1);
 		/* Configure MSI-X capability structure */
-		msi_address_init(&address);
-		msi_data_init(&data, vector);
-		entry->msi_attrib.current_cpu =
-			((address.lo_address.u.dest_id >>
-			MSI_TARGET_CPU_SHIFT) & MSI_TARGET_CPU_MASK);
+		status = msi_callouts.msi_setup(dev, vector,
+						&address.hi_address,
+						&address.lo_address.value,
+						&data.value);
+		if (status < 0)
+			break;
+
 		writel(address.lo_address.value,
 			base + j * PCI_MSIX_ENTRY_SIZE +
 			PCI_MSIX_ENTRY_LOWER_ADDR_OFFSET);
@@ -796,6 +847,8 @@
 	void __iomem *base;
 	unsigned long flags;
 
+	(*msi_callouts.msi_teardown)(vector);
+
 	spin_lock_irqsave(&msi_lock, flags);
 	entry = msi_desc[vector];
 	if (!entry || entry->dev != dev) {
@@ -1126,6 +1179,26 @@
 	}
 }
 
+/*
+ * Generic callouts used on most archs/platforms.  Override with
+ * msi_register_callouts()
+ */
+
+static struct msi_callouts msi_callouts = {
+	.msi_setup = msi_setup_generic,
+	.msi_teardown = msi_teardown_generic,
+#ifdef CONFIG_SMP
+	.msi_target = msi_target_generic,
+#endif
+};
+
+int
+msi_register_callouts(struct msi_callouts *co)
+{
+	msi_callouts = *co;	/* structure copy */
+	return 0;
+}
+
 EXPORT_SYMBOL(pci_enable_msi);
 EXPORT_SYMBOL(pci_disable_msi);
 EXPORT_SYMBOL(pci_enable_msix);
Index: msi/drivers/pci/msi.h
===================================================================
--- msi.orig/drivers/pci/msi.h	2005-12-19 15:34:28.428897860 -0600
+++ msi/drivers/pci/msi.h	2005-12-19 16:08:08.081789136 -0600
@@ -84,24 +84,29 @@
 #define MSI_LOGICAL_MODE		1
 #define MSI_REDIRECTION_HINT_MODE	0
 
-struct msg_data {
+union msg_data {
+	struct {
 #if defined(__LITTLE_ENDIAN_BITFIELD)
-	__u32	vector		:  8;
-	__u32	delivery_mode	:  3;	/* 000b: FIXED | 001b: lowest prior */
-	__u32	reserved_1	:  3;
-	__u32	level		:  1;	/* 0: deassert | 1: assert */
-	__u32	trigger		:  1;	/* 0: edge | 1: level */
-	__u32	reserved_2	: 16;
+		__u32	vector		:  8;
+		__u32	delivery_mode	:  3;	/* 000b: FIXED */
+						/* 001b: lowest prior */
+		__u32	reserved_1	:  3;
+		__u32	level		:  1;	/* 0: deassert | 1: assert */
+		__u32	trigger		:  1;	/* 0: edge | 1: level */
+		__u32	reserved_2	: 16;
 #elif defined(__BIG_ENDIAN_BITFIELD)
-	__u32	reserved_2	: 16;
-	__u32	trigger		:  1;	/* 0: edge | 1: level */
-	__u32	level		:  1;	/* 0: deassert | 1: assert */
-	__u32	reserved_1	:  3;
-	__u32	delivery_mode	:  3;	/* 000b: FIXED | 001b: lowest prior */
-	__u32	vector		:  8;
+		__u32	reserved_2	: 16;
+		__u32	trigger		:  1;	/* 0: edge | 1: level */
+		__u32	level		:  1;	/* 0: deassert | 1: assert */
+		__u32	reserved_1	:  3;
+		__u32	delivery_mode	:  3;	/* 000b: FIXED */
+						/* 001b: lowest prior */
+		__u32	vector		:  8;
 #else
 #error "Bitfield endianness not defined! Check your byteorder.h"
 #endif
+	}u;
+	__u32 value;
 } __attribute__ ((packed));
 
 struct msg_address {
@@ -138,7 +143,7 @@
 		__u8	reserved: 1; 	/* reserved			  */
 		__u8	entry_nr;    	/* specific enabled entry 	  */
 		__u8	default_vector; /* default pre-assigned vector    */
-		__u8	current_cpu; 	/* current destination cpu	  */
+		__u8	unused; 	/* formerly unused destination cpu*/
 	}msi_attrib;
 
 	struct {
Index: msi/include/linux/pci.h
===================================================================
--- msi.orig/include/linux/pci.h	2005-12-19 15:34:28.428897860 -0600
+++ msi/include/linux/pci.h	2005-12-19 18:23:28.984670376 -0600
@@ -478,6 +478,18 @@
 	u16	entry;	/* driver uses to specify entry, OS writes */
 };
 
+struct msi_callouts {
+	int	(*msi_setup) (struct pci_dev *pdev,
+			      unsigned int vector,
+			      uint32_t *addr_hi, uint32_t *addr_lo,
+			      uint32_t *data);
+	void	(*msi_teardown) (unsigned int vector);
+#ifdef CONFIG_SMP
+	void	(*msi_target) (unsigned int vector, unsigned int cpu,
+			       uint32_t *addr_hi, uint32_t *addr_lo);
+#endif
+};
+
 #ifndef CONFIG_PCI_MSI
 static inline void pci_scan_msi_device(struct pci_dev *dev) {}
 static inline int pci_enable_msi(struct pci_dev *dev) {return -1;}
@@ -486,6 +498,7 @@
 	struct msix_entry *entries, int nvec) {return -1;}
 static inline void pci_disable_msix(struct pci_dev *dev) {}
 static inline void msi_remove_pci_irq_vectors(struct pci_dev *dev) {}
+static inline int msi_register_callouts(struct msi_callouts *co) {return -1;}
 #else
 extern void pci_scan_msi_device(struct pci_dev *dev);
 extern int pci_enable_msi(struct pci_dev *dev);
@@ -494,6 +507,7 @@
 	struct msix_entry *entries, int nvec);
 extern void pci_disable_msix(struct pci_dev *dev);
 extern void msi_remove_pci_irq_vectors(struct pci_dev *dev);
+extern int msi_register_callouts(struct msi_callouts *co);
 #endif
 
 extern void pci_block_user_cfg_access(struct pci_dev *dev);
