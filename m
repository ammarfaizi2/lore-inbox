Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268482AbUIXFwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268482AbUIXFwd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 01:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268058AbUIXFuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 01:50:51 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:25555 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S268482AbUIXFoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 01:44:20 -0400
Date: Fri, 24 Sep 2004 14:46:06 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: [PATCH] Updated patches for PCI IRQ resource deallocation support [3/3]
To: greg@kroah.com, len.brown@intel.com, tony.luck@intel.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net, linux-ia64@vger.kernel.org
Message-id: <4153B49E.1060403@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: ja
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP; rv:1.4)
 Gecko/20030624 Netscape/7.1 (ax)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch for ia64 code that depends on previous two patches.

----
Name:		IRQ_deallocation_ia64.patch
Kernel Version:	2.6.9-rc2-mm1
Depends:	none
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

 linux-2.6.9-rc2-mm1-kanesige/arch/ia64/Kconfig           |    9 +
 linux-2.6.9-rc2-mm1-kanesige/arch/ia64/kernel/acpi.c     |    3 
 linux-2.6.9-rc2-mm1-kanesige/arch/ia64/kernel/iosapic.c  |   82 +++++++++++++--
 linux-2.6.9-rc2-mm1-kanesige/arch/ia64/kernel/irq.c      |    9 +
 linux-2.6.9-rc2-mm1-kanesige/arch/ia64/kernel/irq_ia64.c |   27 ++++
 linux-2.6.9-rc2-mm1-kanesige/arch/ia64/pci/pci.c         |    3 
 linux-2.6.9-rc2-mm1-kanesige/include/asm-ia64/hw_irq.h   |    2 
 linux-2.6.9-rc2-mm1-kanesige/include/asm-ia64/iosapic.h  |    4 
 8 files changed, 124 insertions(+), 15 deletions(-)

diff -puN arch/ia64/Kconfig~IRQ_deallocation_ia64 arch/ia64/Kconfig
--- linux-2.6.9-rc2-mm1/arch/ia64/Kconfig~IRQ_deallocation_ia64	2004-09-24 13:57:20.108640713 +0900
+++ linux-2.6.9-rc2-mm1-kanesige/arch/ia64/Kconfig	2004-09-24 13:57:20.143797166 +0900
@@ -500,6 +500,15 @@ config IA64_PALINFO
 	  To use this option, you have to ensure that the "/proc file system
 	  support" (CONFIG_PROC_FS) is enabled, too.
 
+config IA64_DEALLOCATE_IRQ
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
--- linux-2.6.9-rc2-mm1/arch/ia64/kernel/acpi.c~IRQ_deallocation_ia64	2004-09-24 13:57:20.110593849 +0900
+++ linux-2.6.9-rc2-mm1-kanesige/arch/ia64/kernel/acpi.c	2004-09-24 13:57:20.144773734 +0900
@@ -524,6 +524,9 @@ EXPORT_SYMBOL(acpi_register_gsi);
 void
 acpi_unregister_gsi (unsigned int irq)
 {
+#ifdef CONFIG_IA64_DEALLOCATE_IRQ
+	iosapic_unregister_intr(irq);
+#endif
 }
 EXPORT_SYMBOL(acpi_unregister_gsi);
 
diff -puN arch/ia64/kernel/iosapic.c~IRQ_deallocation_ia64 arch/ia64/kernel/iosapic.c
--- linux-2.6.9-rc2-mm1/arch/ia64/kernel/iosapic.c~IRQ_deallocation_ia64	2004-09-24 13:57:20.112546986 +0900
+++ linux-2.6.9-rc2-mm1-kanesige/arch/ia64/kernel/iosapic.c	2004-09-24 13:57:20.145750302 +0900
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
 	char *addr;
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
@@ -576,6 +574,7 @@ iosapic_register_intr (unsigned int gsi,
 	{
 		vector = gsi_to_vector(gsi);
 		if (vector > 0) {
+			iosapic_intr_info[vector].refcnt++;
 			spin_unlock_irqrestore(&iosapic_lock, flags);
 			return vector;
 		}
@@ -584,6 +583,8 @@ iosapic_register_intr (unsigned int gsi,
 		dest = get_target_cpu(gsi, vector);
 		register_intr(gsi, vector, IOSAPIC_LOWEST_PRIORITY,
 			polarity, trigger);
+
+		set_rte(vector, dest, 1);
 	}
 	spin_unlock_irqrestore(&iosapic_lock, flags);
 
@@ -592,10 +593,73 @@ iosapic_register_intr (unsigned int gsi,
 	       (polarity == IOSAPIC_POL_HIGH ? "high" : "low"),
 	       cpu_logical_id(dest), dest, vector);
 
-	set_rte(vector, dest, 1);
 	return vector;
 }
 
+#ifdef CONFIG_IA64_DEALLOCATE_IRQ
+void
+iosapic_unregister_intr (unsigned int irq)
+{
+	unsigned long flags;
+	irq_desc_t *idesc;
+	int rte_index;
+	unsigned int gsi;
+	unsigned long trigger, polarity;
+	ia64_vector vector = irq_to_vector(irq);
+		
+	idesc = irq_descp(irq);
+	spin_lock_irqsave(&idesc->lock, flags);
+	spin_lock(&iosapic_lock);
+	{
+		rte_index = iosapic_intr_info[vector].rte_index;
+		if (rte_index < 0) {
+			spin_unlock(&iosapic_lock);
+			spin_unlock_irqrestore(&idesc->lock, flags);
+			return;		/* not an IOSAPIC interrupt */
+		}
+
+		if (--iosapic_intr_info[vector].refcnt > 0) {
+			spin_unlock(&iosapic_lock);
+			spin_unlock_irqrestore(&idesc->lock, flags);
+			return;
+		}
+
+		/*
+		 * If interrupt handlers still exists on the irq
+		 * associated with the gsi, don't unregister the
+		 * interrupt.
+		 */
+		if (unlikely(idesc->action)) {
+			iosapic_intr_info[vector].refcnt++;
+			spin_unlock_irqrestore(&idesc->lock, flags);
+			printk(KERN_WARNING "Cannot unregister GSI. IRQ %u is still in use.\n", irq);
+			return;
+		}
+
+		/* Clear the interrupt controller descriptor. */
+		idesc->handler = &no_irq_type;
+
+		gsi = iosapic_intr_info[vector].gsi_base + rte_index;
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
+#endif /* CONFIG_IA64_DEALLOCATE_IRQ */
+
 /*
  * ACPI calls this when it finds an entry for a platform interrupt.
  * Note that the irq_base and IOSAPIC address must be set in iosapic_init().
diff -puN arch/ia64/kernel/irq.c~IRQ_deallocation_ia64 arch/ia64/kernel/irq.c
--- linux-2.6.9-rc2-mm1/arch/ia64/kernel/irq.c~IRQ_deallocation_ia64	2004-09-24 13:57:20.130125212 +0900
+++ linux-2.6.9-rc2-mm1-kanesige/arch/ia64/kernel/irq.c	2004-09-24 13:57:20.145750302 +0900
@@ -879,8 +879,11 @@ int setup_irq(unsigned int irq, struct i
 	struct irqaction *old, **p;
 	irq_desc_t *desc = irq_descp(irq);
 
-	if (desc->handler == &no_irq_type)
+	spin_lock_irqsave(&desc->lock,flags);
+	if (desc->handler == &no_irq_type) {
+		spin_unlock_irqrestore(&desc->lock,flags);
 		return -ENOSYS;
+	}
 	/*
 	 * Some drivers like serial.c use request_irq() heavily,
 	 * so we have to be careful not to interfere with a
@@ -906,7 +909,6 @@ int setup_irq(unsigned int irq, struct i
 	/*
 	 * The following block of code has to be executed atomically
 	 */
-	spin_lock_irqsave(&desc->lock,flags);
 	p = &desc->action;
 	if ((old = *p) != NULL) {
 		/* Can't share interrupts unless both agree to */
@@ -1040,6 +1042,9 @@ void move_irq(int irq)
 	irq_desc_t *desc = irq_descp(irq);
 	int redir = test_bit(irq, pending_irq_redir);
 
+	if (unlikely(!desc->handler->set_affinity))
+		return;
+
 	if (!cpus_empty(pending_irq_cpumask[irq])) {
 		cpus_and(tmp, pending_irq_cpumask[irq], cpu_online_map);
 		if (unlikely(!cpus_empty(tmp))) {
diff -puN arch/ia64/kernel/irq_ia64.c~IRQ_deallocation_ia64 arch/ia64/kernel/irq_ia64.c
--- linux-2.6.9-rc2-mm1/arch/ia64/kernel/irq_ia64.c~IRQ_deallocation_ia64	2004-09-24 13:57:20.132078348 +0900
+++ linux-2.6.9-rc2-mm1-kanesige/arch/ia64/kernel/irq_ia64.c	2004-09-24 13:57:20.146726871 +0900
@@ -74,15 +74,34 @@ irq_exit (void)
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
--- linux-2.6.9-rc2-mm1/arch/ia64/pci/pci.c~IRQ_deallocation_ia64	2004-09-24 13:57:20.137937757 +0900
+++ linux-2.6.9-rc2-mm1-kanesige/arch/ia64/pci/pci.c	2004-09-24 13:57:20.146726871 +0900
@@ -451,6 +451,9 @@ pcibios_enable_device (struct pci_dev *d
 void
 pcibios_disable_device (struct pci_dev *dev)
 {
+#ifdef CONFIG_IA64_DEALLOCATE_IRQ
+	acpi_pci_irq_disable(dev);
+#endif /* CONFIG_IA64_DEALLOCATE_IRQ */
 }
 
 void
diff -puN include/asm-ia64/hw_irq.h~IRQ_deallocation_ia64 include/asm-ia64/hw_irq.h
--- linux-2.6.9-rc2-mm1/include/asm-ia64/hw_irq.h~IRQ_deallocation_ia64	2004-09-24 13:57:20.139890894 +0900
+++ linux-2.6.9-rc2-mm1-kanesige/include/asm-ia64/hw_irq.h	2004-09-24 13:57:20.147703439 +0900
@@ -50,6 +50,7 @@ typedef u8 ia64_vector;
  */
 #define IA64_FIRST_DEVICE_VECTOR	0x30
 #define IA64_LAST_DEVICE_VECTOR		0xe7
+#define IA64_NUM_DEVICE_VECTORS		(IA64_LAST_DEVICE_VECTOR - IA64_FIRST_DEVICE_VECTOR + 1)
 
 #define IA64_MCA_RENDEZ_VECTOR		0xe8	/* MCA rendez interrupt */
 #define IA64_PERFMON_VECTOR		0xee	/* performanc monitor interrupt vector */
@@ -83,6 +84,7 @@ extern unsigned long ipi_base_addr;
 extern struct hw_interrupt_type irq_type_ia64_lsapic;	/* CPU-internal interrupt controller */
 
 extern int assign_irq_vector (int irq);	/* allocate a free vector */
+extern void free_irq_vector (int vector);
 extern void ia64_send_ipi (int cpu, int vector, int delivery_mode, int redirect);
 extern void register_percpu_irq (ia64_vector vec, struct irqaction *action);
 
diff -puN include/asm-ia64/iosapic.h~IRQ_deallocation_ia64 include/asm-ia64/iosapic.h
--- linux-2.6.9-rc2-mm1/include/asm-ia64/iosapic.h~IRQ_deallocation_ia64	2004-09-24 13:57:20.141844030 +0900
+++ linux-2.6.9-rc2-mm1-kanesige/include/asm-ia64/iosapic.h	2004-09-24 13:57:20.147703439 +0900
@@ -78,6 +78,9 @@ extern int gsi_to_irq (unsigned int gsi)
 extern void iosapic_enable_intr (unsigned int vector);
 extern int iosapic_register_intr (unsigned int gsi, unsigned long polarity,
 				  unsigned long trigger);
+#ifdef CONFIG_IA64_DEALLOCATE_IRQ
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

