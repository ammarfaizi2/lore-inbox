Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261761AbULGHWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbULGHWv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 02:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbULGHWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 02:22:46 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:6559 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261737AbULGHUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 02:20:46 -0500
Message-ID: <41B559E6.5090601@jp.fujitsu.com>
Date: Tue, 07 Dec 2004 16:21:10 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: ja
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Len Brown <len.brown@intel.com>,
       "Luck, Tony" <tony.luck@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: [PATCH] IRQ resource deallocation [2/2]
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is IA64 portion of IRQ resource deallocation.
This depends on patch [2/2].

----

Kernel Version:	2.6.10-rc3
Depends:	IRQ_deallocation_acpi.patch
Description:

This is an ia64 portion of IRQ resource deallocation. It implements
pcibios_disable_device() and acpi_unregister_gsi() for ia64.

    o acpi_unregister_gsi()

        Summary of changes for implementing this interface:

        - Add new function iosapic_unregister_intr() into
          arch/ia64/kernel/iosapic.c. This function frees an interrupt
          vector and related data structures.

        - Add new function free_irq_vector() into
          arch/ia64/kernel/irq_ia64.c. This frees an unused vector.

        - Change assign_irq_vector() to be able to support
          free_irq_vector().

    o pcibios_disable_device()

        This calls acpi_pci_irq_disable() to deallocate IRQ resources.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>


---

 linux-2.6.10-rc3-kanesige/arch/ia64/Kconfig           |    9 +
 linux-2.6.10-rc3-kanesige/arch/ia64/kernel/acpi.c     |    9 +
 linux-2.6.10-rc3-kanesige/arch/ia64/kernel/iosapic.c  |   96 ++++++++++++++++--
 linux-2.6.10-rc3-kanesige/arch/ia64/kernel/irq.c      |    3 
 linux-2.6.10-rc3-kanesige/arch/ia64/kernel/irq_ia64.c |   27 ++++-
 linux-2.6.10-rc3-kanesige/arch/ia64/pci/pci.c         |    8 +
 linux-2.6.10-rc3-kanesige/include/asm-ia64/hw_irq.h   |    2 
 linux-2.6.10-rc3-kanesige/include/asm-ia64/iosapic.h  |    4 
 8 files changed, 145 insertions(+), 13 deletions(-)

diff -puN arch/ia64/Kconfig~IRQ_deallocation_ia64 arch/ia64/Kconfig
--- linux-2.6.10-rc3/arch/ia64/Kconfig~IRQ_deallocation_ia64	2004-12-06 19:58:12.392540698 +0900
+++ linux-2.6.10-rc3-kanesige/arch/ia64/Kconfig	2004-12-06 19:58:12.407189233 +0900
@@ -302,6 +302,15 @@ config IA64_PALINFO
 	  To use this option, you have to ensure that the "/proc file system
 	  support" (CONFIG_PROC_FS) is enabled, too.
 
+config ACPI_DEALLOCATE_IRQ
+	bool "IRQ resource deallocation support (EXPERIMENTAL)"
+	depends on IOSAPIC && EXPERIMENTAL
+	default n
+	help
+	  Say Y here to experiment with deallocating IRQ resources
+	  dynamically.
+	  Say N if you want to disable IRQ resource deallocation.
+
 source "drivers/firmware/Kconfig"
 
 source "fs/Kconfig.binfmt"
diff -puN arch/ia64/kernel/acpi.c~IRQ_deallocation_ia64 arch/ia64/kernel/acpi.c
--- linux-2.6.10-rc3/arch/ia64/kernel/acpi.c~IRQ_deallocation_ia64	2004-12-06 19:58:12.394493836 +0900
+++ linux-2.6.10-rc3-kanesige/arch/ia64/kernel/acpi.c	2004-12-06 19:58:12.408165802 +0900
@@ -517,6 +517,15 @@ acpi_register_gsi (u32 gsi, int edge_lev
 }
 EXPORT_SYMBOL(acpi_register_gsi);
 
+#ifdef CONFIG_ACPI_DEALLOCATE_IRQ
+void
+acpi_unregister_gsi (u32 gsi)
+{
+	iosapic_unregister_intr(gsi);
+}
+EXPORT_SYMBOL(acpi_unregister_gsi);
+#endif /* CONFIG_ACPI_DEALLOCATE_IRQ */
+
 static int __init
 acpi_parse_fadt (unsigned long phys_addr, unsigned long size)
 {
diff -puN arch/ia64/kernel/iosapic.c~IRQ_deallocation_ia64 arch/ia64/kernel/iosapic.c
--- linux-2.6.10-rc3/arch/ia64/kernel/iosapic.c~IRQ_deallocation_ia64	2004-12-06 19:58:12.396446974 +0900
+++ linux-2.6.10-rc3-kanesige/arch/ia64/kernel/iosapic.c	2004-12-06 19:58:12.409142371 +0900
@@ -111,6 +111,7 @@ static struct iosapic_intr_info {
 	unsigned char	dmode	: 3;	/* delivery mode (see iosapic.h) */
 	unsigned char 	polarity: 1;	/* interrupt polarity (see iosapic.h) */
 	unsigned char	trigger	: 1;	/* trigger mode (see iosapic.h) */
+	int		refcnt;		/* reference counter */
 } iosapic_intr_info[IA64_NUM_VECTORS];
 
 static struct iosapic {
@@ -177,7 +178,7 @@ gsi_to_irq (unsigned int gsi)
 static void
 set_rte (unsigned int vector, unsigned int dest, int mask)
 {
-	unsigned long pol, trigger, dmode, flags;
+	unsigned long pol, trigger, dmode;
 	u32 low32, high32;
 	char __iomem *addr;
 	int rte_index;
@@ -218,13 +219,9 @@ set_rte (unsigned int vector, unsigned i
 	/* dest contains both id and eid */
 	high32 = (dest << IOSAPIC_DEST_SHIFT);
 
-	spin_lock_irqsave(&iosapic_lock, flags);
-	{
-		iosapic_write(addr, IOSAPIC_RTE_HIGH(rte_index), high32);
-		iosapic_write(addr, IOSAPIC_RTE_LOW(rte_index), low32);
-		iosapic_intr_info[vector].low32 = low32;
-	}
-	spin_unlock_irqrestore(&iosapic_lock, flags);
+	iosapic_write(addr, IOSAPIC_RTE_HIGH(rte_index), high32);
+	iosapic_write(addr, IOSAPIC_RTE_LOW(rte_index), low32);
+	iosapic_intr_info[vector].low32 = low32;
 }
 
 static void
@@ -475,6 +472,7 @@ register_intr (unsigned int gsi, int vec
 	iosapic_intr_info[vector].addr     = iosapic_address;
 	iosapic_intr_info[vector].gsi_base = gsi_base;
 	iosapic_intr_info[vector].trigger  = trigger;
+	iosapic_intr_info[vector].refcnt++;
 
 	if (trigger == IOSAPIC_EDGE)
 		irq_type = &irq_type_iosapic_edge;
@@ -581,6 +579,7 @@ iosapic_register_intr (unsigned int gsi,
 	{
 		vector = gsi_to_vector(gsi);
 		if (vector > 0) {
+			iosapic_intr_info[vector].refcnt++;
 			spin_unlock_irqrestore(&iosapic_lock, flags);
 			return vector;
 		}
@@ -589,6 +588,8 @@ iosapic_register_intr (unsigned int gsi,
 		dest = get_target_cpu(gsi, vector);
 		register_intr(gsi, vector, IOSAPIC_LOWEST_PRIORITY,
 			polarity, trigger);
+
+		set_rte(vector, dest, 1);
 	}
 	spin_unlock_irqrestore(&iosapic_lock, flags);
 
@@ -597,10 +598,87 @@ iosapic_register_intr (unsigned int gsi,
 	       (polarity == IOSAPIC_POL_HIGH ? "high" : "low"),
 	       cpu_logical_id(dest), dest, vector);
 
-	set_rte(vector, dest, 1);
 	return vector;
 }
 
+#ifdef CONFIG_ACPI_DEALLOCATE_IRQ
+void
+iosapic_unregister_intr (unsigned int gsi)
+{
+	unsigned long flags;
+	int irq, vector;
+	irq_desc_t *idesc;
+	int rte_index;
+	unsigned long trigger, polarity;
+	
+	/*
+	 * If the irq associated with the gsi is not found,
+	 * iosapic_unregister_intr() is unbalanced. We need to check
+	 * this again after getting locks.
+	 */
+	irq = gsi_to_irq(gsi);
+	if (irq < 0) {
+		printk(KERN_ERR "iosapic_unregister_intr(%u) unbalanced\n", gsi);
+		WARN_ON(1);
+		return;
+	}
+	vector = irq_to_vector(irq);
+
+	idesc = irq_descp(irq);
+	spin_lock_irqsave(&idesc->lock, flags);
+	spin_lock(&iosapic_lock);
+	{
+		rte_index = iosapic_intr_info[vector].rte_index;
+		if (rte_index < 0) {
+			spin_unlock(&iosapic_lock);
+			spin_unlock_irqrestore(&idesc->lock, flags);
+			printk(KERN_ERR "iosapic_unregister_intr(%u) unbalanced\n", gsi);
+			WARN_ON(1);
+			return;
+		}
+
+		if (--iosapic_intr_info[vector].refcnt > 0) {
+			spin_unlock(&iosapic_lock);
+			spin_unlock_irqrestore(&idesc->lock, flags);
+			return;
+		}
+
+		/*
+		 * If interrupt handlers still exist on the irq
+		 * associated with the gsi, don't unregister the
+		 * interrupt.
+		 */
+		if (idesc->action) {
+			iosapic_intr_info[vector].refcnt++;
+			spin_unlock(&iosapic_lock);
+			spin_unlock_irqrestore(&idesc->lock, flags);
+			printk(KERN_WARNING "Cannot unregister GSI. IRQ %u is still in use.\n", irq);
+			return;
+		}
+
+		/* Clear the interrupt controller descriptor. */
+		idesc->handler = &no_irq_type;
+
+		trigger  = iosapic_intr_info[vector].trigger;
+		polarity = iosapic_intr_info[vector].polarity;
+
+		/* Clear the interrupt information. */
+		memset(&iosapic_intr_info[vector], 0, sizeof(struct iosapic_intr_info));
+		iosapic_intr_info[vector].rte_index = -1;	/* mark as unused */
+	}
+	spin_unlock(&iosapic_lock);
+	spin_unlock_irqrestore(&idesc->lock, flags);
+
+	/* Free the interrupt vector */
+	free_irq_vector(vector);
+
+	printk(KERN_INFO "GSI %u (%s, %s) -> vector %d unregisterd.\n",
+	       gsi, (trigger == IOSAPIC_EDGE ? "edge" : "level"),
+	       (polarity == IOSAPIC_POL_HIGH ? "high" : "low"),
+	       vector);
+}
+#endif /* CONFIG_ACPI_DEALLOCATE_IRQ */
+
 /*
  * ACPI calls this when it finds an entry for a platform interrupt.
  * Note that the irq_base and IOSAPIC address must be set in iosapic_init().
diff -puN arch/ia64/kernel/irq.c~IRQ_deallocation_ia64 arch/ia64/kernel/irq.c
--- linux-2.6.10-rc3/arch/ia64/kernel/irq.c~IRQ_deallocation_ia64	2004-12-06 19:58:12.398400112 +0900
+++ linux-2.6.10-rc3-kanesige/arch/ia64/kernel/irq.c	2004-12-06 19:58:12.409142371 +0900
@@ -1030,6 +1030,9 @@ void move_irq(int irq)
 	irq_desc_t *desc = irq_descp(irq);
 	int redir = test_bit(irq, pending_irq_redir);
 
+	if (unlikely(!desc->handler->set_affinity))
+		return;
+
 	if (!cpus_empty(pending_irq_cpumask[irq])) {
 		cpus_and(tmp, pending_irq_cpumask[irq], cpu_online_map);
 		if (unlikely(!cpus_empty(tmp))) {
diff -puN arch/ia64/kernel/irq_ia64.c~IRQ_deallocation_ia64 arch/ia64/kernel/irq_ia64.c
--- linux-2.6.10-rc3/arch/ia64/kernel/irq_ia64.c~IRQ_deallocation_ia64	2004-12-06 19:58:12.400353250 +0900
+++ linux-2.6.10-rc3-kanesige/arch/ia64/kernel/irq_ia64.c	2004-12-06 19:58:12.410118940 +0900
@@ -75,15 +75,34 @@ irq_exit (void)
 	preempt_enable_no_resched();
 }
 
+static unsigned long ia64_vector_mask[BITS_TO_LONGS(IA64_NUM_DEVICE_VECTORS)];
+
 int
 assign_irq_vector (int irq)
 {
-	static int next_vector = IA64_FIRST_DEVICE_VECTOR;
-
-	if (next_vector > IA64_LAST_DEVICE_VECTOR)
+	int pos, vector;
+ again:
+	pos = find_first_zero_bit(ia64_vector_mask, IA64_NUM_DEVICE_VECTORS);
+	vector = IA64_FIRST_DEVICE_VECTOR + pos;
+	if (vector > IA64_LAST_DEVICE_VECTOR)
 		/* XXX could look for sharable vectors instead of panic'ing... */
 		panic("assign_irq_vector: out of interrupt vectors!");
-	return next_vector++;
+	if (test_and_set_bit(pos, ia64_vector_mask))
+		goto again;
+	return vector;
+}
+
+void
+free_irq_vector (int vector)
+{
+	int pos;
+
+	if (vector < IA64_FIRST_DEVICE_VECTOR || vector > IA64_LAST_DEVICE_VECTOR)
+		return;
+
+	pos = vector - IA64_FIRST_DEVICE_VECTOR;
+	if (!test_and_clear_bit(pos, ia64_vector_mask))
+		printk(KERN_WARNING "%s: double free!\n", __FUNCTION__);
 }
 
 extern unsigned int do_IRQ(unsigned long irq, struct pt_regs *regs);
diff -puN arch/ia64/pci/pci.c~IRQ_deallocation_ia64 arch/ia64/pci/pci.c
--- linux-2.6.10-rc3/arch/ia64/pci/pci.c~IRQ_deallocation_ia64	2004-12-06 19:58:12.401329819 +0900
+++ linux-2.6.10-rc3-kanesige/arch/ia64/pci/pci.c	2004-12-06 19:58:12.410118940 +0900
@@ -480,6 +480,14 @@ pcibios_enable_device (struct pci_dev *d
 	return acpi_pci_irq_enable(dev);
 }
 
+#ifdef CONFIG_ACPI_DEALLOCATE_IRQ
+void
+pcibios_disable_device (struct pci_dev *dev)
+{
+	acpi_pci_irq_disable(dev);
+}
+#endif /* CONFIG_ACPI_DEALLOCATE_IRQ */
+
 void
 pcibios_align_resource (void *data, struct resource *res,
 		        unsigned long size, unsigned long align)
diff -puN include/asm-ia64/hw_irq.h~IRQ_deallocation_ia64 include/asm-ia64/hw_irq.h
--- linux-2.6.10-rc3/include/asm-ia64/hw_irq.h~IRQ_deallocation_ia64	2004-12-06 19:58:12.403282957 +0900
+++ linux-2.6.10-rc3-kanesige/include/asm-ia64/hw_irq.h	2004-12-06 19:58:12.410118940 +0900
@@ -50,6 +50,7 @@ typedef u8 ia64_vector;
  */
 #define IA64_FIRST_DEVICE_VECTOR	0x30
 #define IA64_LAST_DEVICE_VECTOR		0xe7
+#define IA64_NUM_DEVICE_VECTORS		(IA64_LAST_DEVICE_VECTOR - IA64_FIRST_DEVICE_VECTOR + 1)
 
 #define IA64_MCA_RENDEZ_VECTOR		0xe8	/* MCA rendez interrupt */
 #define IA64_PERFMON_VECTOR		0xee	/* performanc monitor interrupt vector */
@@ -81,6 +82,7 @@ extern __u8 isa_irq_to_vector_map[16];
 extern struct hw_interrupt_type irq_type_ia64_lsapic;	/* CPU-internal interrupt controller */
 
 extern int assign_irq_vector (int irq);	/* allocate a free vector */
+extern void free_irq_vector (int vector);
 extern void ia64_send_ipi (int cpu, int vector, int delivery_mode, int redirect);
 extern void register_percpu_irq (ia64_vector vec, struct irqaction *action);
 
diff -puN include/asm-ia64/iosapic.h~IRQ_deallocation_ia64 include/asm-ia64/iosapic.h
--- linux-2.6.10-rc3/include/asm-ia64/iosapic.h~IRQ_deallocation_ia64	2004-12-06 19:58:12.405236095 +0900
+++ linux-2.6.10-rc3-kanesige/include/asm-ia64/iosapic.h	2004-12-06 19:58:12.411095509 +0900
@@ -78,6 +78,9 @@ extern int gsi_to_irq (unsigned int gsi)
 extern void iosapic_enable_intr (unsigned int vector);
 extern int iosapic_register_intr (unsigned int gsi, unsigned long polarity,
 				  unsigned long trigger);
+#ifdef CONFIG_ACPI_DEALLOCATE_IRQ
+extern void iosapic_unregister_intr (unsigned int irq);
+#endif
 extern void __init iosapic_override_isa_irq (unsigned int isa_irq, unsigned int gsi,
 				      unsigned long polarity,
 				      unsigned long trigger);
@@ -97,6 +100,7 @@ extern void __init map_iosapic_to_node (
 #define iosapic_system_init(pcat_compat)			do { } while (0)
 #define iosapic_init(address,gsi_base)				do { } while (0)
 #define iosapic_register_intr(gsi,polarity,trigger)		(gsi)
+#define iosapic_unregister_intr(irq)				do { } while (0)
 #define iosapic_override_isa_irq(isa_irq,gsi,polarity,trigger)	do { } while (0)
 #define iosapic_register_platform_intr(type,gsi,pmi,eid,id, \
 	polarity,trigger)					(gsi)

_

