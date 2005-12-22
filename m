Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030217AbVLVRQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030217AbVLVRQx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 12:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030223AbVLVRQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 12:16:52 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:46011 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030217AbVLVRQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 12:16:31 -0500
Date: Thu, 22 Dec 2005 11:15:19 -0600 (CST)
From: Mark Maule <maule@sgi.com>
To: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tony Luck <tony.luck@intel.com>, Mark Maule <maule@sgi.com>
Message-Id: <20051222171626.8240.40685.41154@lnx-maule.americas.sgi.com>
In-Reply-To: <20051222171616.8240.37671.12506@lnx-maule.americas.sgi.com>
References: <20051222171616.8240.37671.12506@lnx-maule.americas.sgi.com>
Subject: [PATCH 2/3] per-platform IA64_{FIRST,LAST}_DEVICE_VECTOR definitions
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Abstract IA64_FIRST_DEVICE_VECTOR/IA64_LAST_DEVICE_VECTOR since SN platforms
use a subset of the IA64 range.  Implement this by making the above macros
global variables which the platform can override in it setup code.

Also add a reserve_irq_vector() routine used by SN to mark a vector's as
in-use when that weren't allocated through assign_irq_vector().

Signed-off-by: Mark Maule <maule@sgi.com>

Index: msi/arch/ia64/kernel/irq_ia64.c
===================================================================
--- msi.orig/arch/ia64/kernel/irq_ia64.c	2005-12-21 13:14:22.440102173 -0600
+++ msi/arch/ia64/kernel/irq_ia64.c	2005-12-21 18:55:04.977044476 -0600
@@ -46,6 +46,10 @@
 
 #define IRQ_DEBUG	0
 
+/* These can be overridden in platform_irq_init */
+int ia64_first_device_vector = IA64_DEF_FIRST_DEVICE_VECTOR;
+int ia64_last_device_vector = IA64_DEF_LAST_DEVICE_VECTOR;
+
 /* default base addr of IPI table */
 void __iomem *ipi_base_addr = ((void __iomem *)
 			       (__IA64_UNCACHED_OFFSET | IA64_IPI_DEFAULT_BASE_ADDR));
@@ -60,7 +64,7 @@
 };
 EXPORT_SYMBOL(isa_irq_to_vector_map);
 
-static unsigned long ia64_vector_mask[BITS_TO_LONGS(IA64_NUM_DEVICE_VECTORS)];
+static unsigned long ia64_vector_mask[BITS_TO_LONGS(IA64_MAX_DEVICE_VECTORS)];
 
 int
 assign_irq_vector (int irq)
@@ -89,6 +93,17 @@
 		printk(KERN_WARNING "%s: double free!\n", __FUNCTION__);
 }
 
+int
+reserve_irq_vector (int vector)
+{
+	if (vector < IA64_FIRST_DEVICE_VECTOR ||
+	    vector > IA64_LAST_DEVICE_VECTOR)
+		return -EINVAL;
+
+	return test_and_set_bit(IA64_FIRST_DEVICE_VECTOR + vector,
+				ia64_vector_mask);
+}
+
 #ifdef CONFIG_SMP
 #	define IS_RESCHEDULE(vec)	(vec == IA64_IPI_RESCHEDULE)
 #else
Index: msi/arch/ia64/sn/kernel/irq.c
===================================================================
--- msi.orig/arch/ia64/sn/kernel/irq.c	2005-12-21 13:14:22.441078639 -0600
+++ msi/arch/ia64/sn/kernel/irq.c	2005-12-21 18:55:04.999503161 -0600
@@ -203,6 +203,9 @@
 	int i;
 	irq_desc_t *base_desc = irq_desc;
 
+	ia64_first_device_vector = IA64_SN2_FIRST_DEVICE_VECTOR;
+	ia64_last_device_vector = IA64_SN2_LAST_DEVICE_VECTOR;
+
 	for (i = 0; i < NR_IRQS; i++) {
 		if (base_desc[i].handler == &no_irq_type) {
 			base_desc[i].handler = &irq_type_sn;
@@ -287,6 +290,7 @@
 	/* link it into the sn_irq[irq] list */
 	spin_lock(&sn_irq_info_lock);
 	list_add_rcu(&sn_irq_info->list, sn_irq_lh[sn_irq_info->irq_irq]);
+	reserve_irq_vector(sn_irq_info->irq_irq);
 	spin_unlock(&sn_irq_info_lock);
 
 	(void)register_intr_pda(sn_irq_info);
@@ -310,8 +314,11 @@
 	spin_lock(&sn_irq_info_lock);
 	list_del_rcu(&sn_irq_info->list);
 	spin_unlock(&sn_irq_info_lock);
+	if (list_empty(sn_irq_lh[sn_irq_info->irq_irq]))
+		free_irq_vector(sn_irq_info->irq_irq);
 	call_rcu(&sn_irq_info->rcu, sn_irq_info_free);
 	pci_dev_put(pci_dev);
+
 }
 
 static inline void
Index: msi/include/asm-ia64/hw_irq.h
===================================================================
--- msi.orig/include/asm-ia64/hw_irq.h	2005-12-21 13:14:22.530913485 -0600
+++ msi/include/asm-ia64/hw_irq.h	2005-12-21 18:55:05.017079522 -0600
@@ -47,9 +47,19 @@
 #define IA64_CMC_VECTOR			0x1f	/* corrected machine-check interrupt vector */
 /*
  * Vectors 0x20-0x2f are reserved for legacy ISA IRQs.
+ * Use vectors 0x30-0xe7 as the default device vector range for ia64.
+ * Platforms may choose to reduce this range in platform_irq_setup, but the
+ * platform range must fall within
+ *	[IA64_DEF_FIRST_DEVICE_VECTOR..IA64_DEF_LAST_DEVICE_VECTOR]
  */
-#define IA64_FIRST_DEVICE_VECTOR	0x30
-#define IA64_LAST_DEVICE_VECTOR		0xe7
+extern int ia64_first_device_vector;
+extern int ia64_last_device_vector;
+
+#define IA64_DEF_FIRST_DEVICE_VECTOR	0x30
+#define IA64_DEF_LAST_DEVICE_VECTOR	0xe7
+#define IA64_FIRST_DEVICE_VECTOR	ia64_first_device_vector
+#define IA64_LAST_DEVICE_VECTOR		ia64_last_device_vector
+#define IA64_MAX_DEVICE_VECTORS		(IA64_DEF_LAST_DEVICE_VECTOR - IA64_DEF_FIRST_DEVICE_VECTOR + 1)
 #define IA64_NUM_DEVICE_VECTORS		(IA64_LAST_DEVICE_VECTOR - IA64_FIRST_DEVICE_VECTOR + 1)
 
 #define IA64_MCA_RENDEZ_VECTOR		0xe8	/* MCA rendez interrupt */
@@ -83,6 +93,7 @@
 
 extern int assign_irq_vector (int irq);	/* allocate a free vector */
 extern void free_irq_vector (int vector);
+extern int reserve_irq_vector (int vector);
 extern void ia64_send_ipi (int cpu, int vector, int delivery_mode, int redirect);
 extern void register_percpu_irq (ia64_vector vec, struct irqaction *action);
 
Index: msi/drivers/pci/msi.c
===================================================================
--- msi.orig/drivers/pci/msi.c	2005-12-21 16:10:32.838675711 -0600
+++ msi/drivers/pci/msi.c	2005-12-21 18:55:05.020985381 -0600
@@ -35,7 +35,7 @@
 
 #ifndef CONFIG_X86_IO_APIC
 int vector_irq[NR_VECTORS] = { [0 ... NR_VECTORS - 1] = -1};
-u8 irq_vector[NR_IRQ_VECTORS] = { FIRST_DEVICE_VECTOR , 0 };
+u8 irq_vector[NR_IRQ_VECTORS] = { [0 ... NR_IRQ_VECTORS - 1 ] = 0 };
 #endif
 
 static struct msi_ops *msi_ops;
@@ -377,6 +377,11 @@
 		printk(KERN_WARNING "PCI: MSI cache init failed\n");
 		return status;
 	}
+
+#ifndef CONFIG_X86_IO_APIC
+	irq_vector[0] = FIRST_DEVICE_VECTOR;
+#endif
+
 	last_alloc_vector = assign_irq_vector(AUTO_ASSIGN);
 	if (last_alloc_vector < 0) {
 		pci_msi_enable = 0;
