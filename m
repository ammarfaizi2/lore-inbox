Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263176AbUB0WpT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 17:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263188AbUB0WpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 17:45:18 -0500
Received: from fmr05.intel.com ([134.134.136.6]:53389 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S263176AbUB0Woc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 17:44:32 -0500
Date: Fri, 27 Feb 2004 16:11:22 -0800
From: long <tlnguyen@snoqualmie.dp.intel.com>
Message-Id: <200402280011.i1S0BMrw018575@snoqualmie.dp.intel.com>
To: linux-kernel@vger.kernel.org
Subject: Re:[PATCH]2.6.3-rc2 MSI Support for IA64
Cc: davidm@napali.hpl.hp.com, jun.nakajima@intel.com,
       tom.l.n@snoqualmie.dp.intel.com, tony.luck@intel.com,
       zwane@linuxpower.ca
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After receiving all inputs from Linux Community, we made some changes to 
the patch. Attached is an update version.

Thanks,
Long

----------------------------------------------------------------------------
diff -urN linux-2.6.3-rc2/arch/ia64/Kconfig linux-2.6.3-rc2-MSI/arch/ia64/Kconfig
--- linux-2.6.3-rc2/arch/ia64/Kconfig	2004-02-09 22:01:16.000000000 -0500
+++ linux-2.6.3-rc2-MSI/arch/ia64/Kconfig	2004-02-26 16:31:03.908765998 -0500
@@ -433,6 +433,18 @@
 	  information about which PCI hardware does work under Linux and which
 	  doesn't.
 
+config PCI_USE_VECTOR
+	bool "Message Signaled Interrupt (MSI) Support"
+	default n
+	help
+	   This enables MSI, Message Signaled Interrupt, on specific 
+	   MSI capable device functions detected upon requests from the
+	   device drivers. Message Signal Interrupt enables an MSI-capable
+	   hardware device to send an inbound Memory Write on its PCI bus
+	   instead of asserting IRQ signal on device IRQ pin.
+
+	   If you don't know what to do here, say N.
+
 config PCI_DOMAINS
 	bool
 	default PCI
diff -urN linux-2.6.3-rc2/arch/ia64/kernel/irq_ia64.c linux-2.6.3-rc2-MSI/arch/ia64/kernel/irq_ia64.c
--- linux-2.6.3-rc2/arch/ia64/kernel/irq_ia64.c	2004-02-09 22:00:36.000000000 -0500
+++ linux-2.6.3-rc2-MSI/arch/ia64/kernel/irq_ia64.c	2004-02-26 16:31:03.909742561 -0500
@@ -60,12 +60,18 @@
 int
 ia64_alloc_vector (void)
 {
+#ifdef CONFIG_PCI_USE_VECTOR
+	extern int assign_irq_vector(int irq);
+
+	return assign_irq_vector(AUTO_ASSIGN);
+#else
 	static int next_vector = IA64_FIRST_DEVICE_VECTOR;
 
 	if (next_vector > IA64_LAST_DEVICE_VECTOR)
 		/* XXX could look for sharable vectors instead of panic'ing... */
 		panic("ia64_alloc_vector: out of interrupt vectors!");
 	return next_vector++;
+#endif
 }
 
 extern unsigned int do_IRQ(unsigned long irq, struct pt_regs *regs);
diff -urN linux-2.6.3-rc2/drivers/pci/msi.c linux-2.6.3-rc2-MSI/drivers/pci/msi.c
--- linux-2.6.3-rc2/drivers/pci/msi.c	2004-02-09 22:01:16.000000000 -0500
+++ linux-2.6.3-rc2-MSI/drivers/pci/msi.c	2004-02-26 16:33:14.605053460 -0500
@@ -1,5 +1,8 @@
 /*
- * linux/drivers/pci/msi.c
+ * Purpose:	PCI Message Signaled Interrupt (MSI)
+ *
+ * Copyright (C) 2003-2004 Intel
+ * Copyright (C) Tom Long Nguyen (tom.l.nguyen@intel.com)
  */
 
 #include <linux/mm.h>
@@ -15,13 +18,10 @@
 #include <asm/errno.h>
 #include <asm/io.h>
 #include <asm/smp.h>
-#include <asm/desc.h>
-#include <asm/io_apic.h>
-#include <mach_apic.h>
 
+static void set_msi_affinity(unsigned int vector, cpumask_t cpu_mask);
 #include "msi.h"
 
-
 static spinlock_t msi_lock = SPIN_LOCK_UNLOCKED;
 static struct msi_desc* msi_desc[NR_IRQS] = { [0 ... NR_IRQS-1] = NULL };
 static kmem_cache_t* msi_cachep;
@@ -92,7 +92,6 @@
 {
 	struct msi_desc *entry;
 	struct msg_address address;
-	unsigned int dest_id;
 
 	entry = (struct msi_desc *)msi_desc[vector];
 	if (!entry || !entry->dev)
@@ -109,10 +108,9 @@
 	        entry->dev->bus->ops->read(entry->dev->bus, entry->dev->devfn,
 			msi_lower_address_reg(pos), 4,
 			&address.lo_address.value);
-		dest_id = (address.lo_address.u.dest_id &
-			MSI_ADDRESS_HEADER_MASK) |
-			(cpu_mask_to_apicid(cpu_mask) << MSI_TARGET_CPU_SHIFT);
-		address.lo_address.u.dest_id = dest_id;
+		address.lo_address.value &= MSI_ADDRESS_DEST_ID_MASK;
+		address.lo_address.value |= (cpu_mask_to_apicid(cpu_mask) << 
+			MSI_TARGET_CPU_SHIFT);
 		entry->msi_attrib.current_cpu = cpu_mask_to_apicid(cpu_mask);
 		entry->dev->bus->ops->write(entry->dev->bus, entry->dev->devfn,
 			msi_lower_address_reg(pos), 4,
@@ -125,10 +123,9 @@
 			PCI_MSIX_ENTRY_LOWER_ADDR_OFFSET;
 
 		address.lo_address.value = readl(entry->mask_base + offset);
-		dest_id = (address.lo_address.u.dest_id &
-			MSI_ADDRESS_HEADER_MASK) |
-			(cpu_mask_to_apicid(cpu_mask) << MSI_TARGET_CPU_SHIFT);
-		address.lo_address.u.dest_id = dest_id;
+		address.lo_address.value &= MSI_ADDRESS_DEST_ID_MASK;
+		address.lo_address.value |= (cpu_mask_to_apicid(cpu_mask) << 
+			MSI_TARGET_CPU_SHIFT);
 		entry->msi_attrib.current_cpu = cpu_mask_to_apicid(cpu_mask);
 		writel(address.lo_address.value, entry->mask_base + offset);
 		break;
@@ -137,14 +134,6 @@
 		break;
 	}
 }
-
-static inline void move_msi(int vector)
-{
-	if (!cpus_empty(pending_irq_balance_cpumask[vector])) {
-		set_msi_affinity(vector, pending_irq_balance_cpumask[vector]);
-		cpus_clear(pending_irq_balance_cpumask[vector]);
-	}
-}
 #endif
 
 static void mask_MSI_irq(unsigned int vector)
@@ -259,11 +248,11 @@
 
 	memset(msi_address, 0, sizeof(struct msg_address));
 	msi_address->hi_address = (u32)0;
-	dest_id = (MSI_ADDRESS_HEADER << MSI_ADDRESS_HEADER_SHIFT) |
-		 (MSI_TARGET_CPU << MSI_TARGET_CPU_SHIFT);
-	msi_address->lo_address.u.dest_mode = MSI_LOGICAL_MODE;
+	dest_id = (MSI_ADDRESS_HEADER << MSI_ADDRESS_HEADER_SHIFT);
+	msi_address->lo_address.u.dest_mode = MSI_DEST_MODE;
 	msi_address->lo_address.u.redirection_hint = MSI_REDIRECTION_HINT_MODE;
 	msi_address->lo_address.u.dest_id = dest_id;
+	msi_address->lo_address.value |= (MSI_TARGET_CPU << MSI_TARGET_CPU_SHIFT);
 }
 
 static int pci_vector_resources(void)
@@ -271,18 +260,8 @@
 	static int res = -EINVAL;
 	int nr_free_vectors;
 
-	if (res == -EINVAL) {
-		int i, repeat;
-		for (i = NR_REPEATS; i > 0; i--) {
-			if ((FIRST_DEVICE_VECTOR + i * 8) > FIRST_SYSTEM_VECTOR)
-				continue;
-			break;
-		}
-		i++;
-		repeat = (FIRST_SYSTEM_VECTOR - FIRST_DEVICE_VECTOR)/i;
-		res = i * repeat - NR_RESERVED_VECTORS + 1;
-	}
-
+	if (res == -EINVAL) 
+		res = vector_resources();
 	nr_free_vectors = res + nr_released_vectors - nr_alloc_vectors;
 
 	return nr_free_vectors;
@@ -292,10 +271,10 @@
 {
 	static int current_vector = FIRST_DEVICE_VECTOR, offset = 0;
 
-	if (irq != MSI_AUTO && IO_APIC_VECTOR(irq) > 0)
+	if (irq != AUTO_ASSIGN && IO_APIC_VECTOR(irq) > 0)
 		return IO_APIC_VECTOR(irq);
 next:
-	current_vector += 8;
+	current_vector += VECTOR_STEP;	
 	if (current_vector == SYSCALL_VECTOR)
 		goto next;
 
@@ -308,7 +287,7 @@
 		return -ENOSPC;
 
 	vector_irq[current_vector] = irq;
-	if (irq != MSI_AUTO)
+	if (irq != AUTO_ASSIGN)
 		IO_APIC_VECTOR(irq) = current_vector;
 
 	nr_alloc_vectors++;
@@ -358,10 +337,9 @@
 		return -EBUSY;
 	}
 
-	vector = assign_irq_vector(MSI_AUTO);
+	vector = assign_irq_vector(AUTO_ASSIGN);	
 	if (vector  == (FIRST_SYSTEM_VECTOR - 8))
 		new_vector_avail = 0;
-
 	spin_unlock_irqrestore(&msi_lock, flags);
 	return vector;
 }
diff -urN linux-2.6.3-rc2/drivers/pci/msi.h linux-2.6.3-rc2-MSI/drivers/pci/msi.h
--- linux-2.6.3-rc2/drivers/pci/msi.h	2004-02-09 22:01:04.000000000 -0500
+++ linux-2.6.3-rc2-MSI/drivers/pci/msi.h	2004-02-26 16:32:56.028881812 -0500
@@ -1,12 +1,38 @@
 /*
- *	msi.h
+ *
+ * Copyright (C) 2003-2004 Intel
+ * Copyright (C) Tom Long Nguyen (tom.l.nguyen@intel.com)
  *
  */
 
 #ifndef MSI_H
 #define MSI_H
 
-#define MSI_AUTO -1
+#ifndef CONFIG_IA64
+#include <asm/desc.h>	
+#ifndef CONFIG_X86_64
+#include <mach_apic.h>  
+#endif
+#define VECTOR_STEP		8
+#else 
+#define FIRST_DEVICE_VECTOR 	IA64_FIRST_DEVICE_VECTOR
+#define FIRST_SYSTEM_VECTOR 	(IA64_LAST_DEVICE_VECTOR + 8)
+#define VECTOR_STEP		1
+static inline void set_intr_gate (int nr, void *func) {}
+#define IO_APIC_VECTOR(irq)	(irq)
+#define ack_APIC_irq		ia64_eoi
+#define irq_desc		_irq_desc
+#define cpu_mask_to_apicid(mask) cpu_physical_id(first_cpu(mask))
+#endif
+ 
+#if !defined(AUTO_ASSIGN)
+#define AUTO_ASSIGN 	-1
+#endif
+
+#if !defined(SYSCALL_VECTOR)
+#define SYSCALL_VECTOR	    	0x80
+#endif
+
 #define NR_REPEATS	23
 #define NR_RESERVED_VECTORS 3 /*FIRST_DEVICE_VECTOR,FIRST_SYSTEM_VECTOR,0x80 */
 
@@ -28,15 +54,43 @@
 #define set_msi_irq_affinity	set_msi_affinity
 #else
 #define set_msi_irq_affinity	NULL
+#endif
+
+#if defined(CONFIG_SMP) && !defined(CONFIG_IA64)
+static inline void move_msi(int vector)
+{
+	if (!cpus_empty(pending_irq_balance_cpumask[vector])) {
+		set_msi_affinity(vector, pending_irq_balance_cpumask[vector]);
+		cpus_clear(pending_irq_balance_cpumask[vector]);
+	}
+}
+#else
 static inline void move_msi(int vector) {}
 #endif
 
 #ifndef CONFIG_X86_IO_APIC
 static inline int get_ioapic_vector(struct pci_dev *dev) { return -1;}
-static inline void restore_ioapic_irq_handler(int irq) {}
+#endif
+
+static inline int vector_resources(void)
+{
+	int res;
+#ifndef CONFIG_IA64
+	int i, repeat;
+	for (i = NR_REPEATS; i > 0; i--) {
+		if ((FIRST_DEVICE_VECTOR + i * 8) > FIRST_SYSTEM_VECTOR)
+			continue;
+		break;
+	}
+	i++;
+	repeat = (FIRST_SYSTEM_VECTOR - FIRST_DEVICE_VECTOR)/i;
+	res = i * repeat - NR_RESERVED_VECTORS + 1;
 #else
-extern void restore_ioapic_irq_handler(int irq);
+	res = FIRST_SYSTEM_VECTOR - FIRST_DEVICE_VECTOR - 8;
 #endif
+	
+	return res;
+}
 
 /*
  * MSI-X Address Register
@@ -80,25 +134,34 @@
 #define msix_mask(address)		(address | PCI_MSIX_FLAGS_BITMASK)
 #define msix_is_pending(address) 	(address & PCI_MSIX_FLAGS_PENDMASK)
 
-
 /*
  * MSI Defined Data Structures
  */
 #define MSI_ADDRESS_HEADER		0xfee
 #define MSI_ADDRESS_HEADER_SHIFT	12
 #define MSI_ADDRESS_HEADER_MASK		0xfff000
-#define MSI_TARGET_CPU_SHIFT		4
+#define MSI_ADDRESS_DEST_ID_MASK	0xfff0000f
 #define MSI_TARGET_CPU_MASK		0xff
 #define MSI_DELIVERY_MODE		0
 #define MSI_LEVEL_MODE			1	/* Edge always assert */
 #define MSI_TRIGGER_MODE		0	/* MSI is edge sensitive */
+#define MSI_PHYSICAL_MODE		0
 #define MSI_LOGICAL_MODE		1
 #define MSI_REDIRECTION_HINT_MODE	0
+
+#ifdef CONFIG_IA64
+#define MSI_DEST_MODE			MSI_PHYSICAL_MODE
+#define MSI_TARGET_CPU	((ia64_getreg(_IA64_REG_CR_LID) >> 16) & 0xffff)
+#define MSI_TARGET_CPU_SHIFT		4
+#else
+#define MSI_DEST_MODE			MSI_LOGICAL_MODE
+#define MSI_TARGET_CPU_SHIFT		12
 #ifdef CONFIG_SMP
 #define MSI_TARGET_CPU			logical_smp_processor_id()
 #else
 #define MSI_TARGET_CPU			TARGET_CPUS
 #endif
+#endif
 
 struct msg_data {
 #if defined(__LITTLE_ENDIAN_BITFIELD)
diff -urN linux-2.6.3-rc2/include/asm-ia64/hw_irq.h linux-2.6.3-rc2-MSI/include/asm-ia64/hw_irq.h
--- linux-2.6.3-rc2/include/asm-ia64/hw_irq.h	2004-02-09 22:00:44.000000000 -0500
+++ linux-2.6.3-rc2-MSI/include/asm-ia64/hw_irq.h	2004-02-26 16:31:03.937086310 -0500
@@ -34,6 +34,8 @@
 #define IA64_MAX_VECTORED_IRQ		255
 #define IA64_NUM_VECTORS		256
 
+#define AUTO_ASSIGN			-1
+
 #define IA64_SPURIOUS_INT_VECTOR	0x0f
 
 /*
