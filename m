Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263005AbUCLWiI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 17:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263007AbUCLWiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 17:38:04 -0500
Received: from fmr06.intel.com ([134.134.136.7]:9388 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S263005AbUCLWhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 17:37:33 -0500
Date: Fri, 12 Mar 2004 16:08:28 -0800
From: long <tlnguyen@snoqualmie.dp.intel.com>
Message-Id: <200403130008.i2D08SMQ011709@snoqualmie.dp.intel.com>
To: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: RE[PATCH]2.6.4-rc3 MSI Support for IA64
Cc: davidm@napali.hpl.hp.com, grep@kroah.com, jgarzik@pobox.com,
       jun.nakajima@intel.com, tom.l.nguyen@intel.com, tony.luck@intel.com,
       zwane@linuxpower.ca
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for all inputs received from the previous patch posted a few
weeks ago. Based on Zwane Mwaikambo's suggestion of using a 
standard name like assign_irq_vector(), we made some changes to 
the previous posted patch. Attached is an update version, based on
kernel 2.6.4-rc3. 

Please send us your comments on this patch.

Thanks,
Long

----------------------------------------------------------------------------
diff -urN linux-2.6.4-rc3/arch/ia64/Kconfig linux-2.6.4-rc3-msi/arch/ia64/Kconfig
--- linux-2.6.4-rc3/arch/ia64/Kconfig	2004-03-09 19:00:42.000000000 -0500
+++ linux-2.6.4-rc3-msi/arch/ia64/Kconfig	2004-03-11 14:52:57.000000000 -0500
@@ -406,6 +406,18 @@
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
diff -urN linux-2.6.4-rc3/arch/ia64/kernel/irq_ia64.c linux-2.6.4-rc3-msi/arch/ia64/kernel/irq_ia64.c
--- linux-2.6.4-rc3/arch/ia64/kernel/irq_ia64.c	2004-03-09 19:00:26.000000000 -0500
+++ linux-2.6.4-rc3-msi/arch/ia64/kernel/irq_ia64.c	2004-03-11 14:52:57.000000000 -0500
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
diff -urN linux-2.6.4-rc3/drivers/pci/msi.c linux-2.6.4-rc3-msi/drivers/pci/msi.c
--- linux-2.6.4-rc3/drivers/pci/msi.c	2004-03-09 19:00:42.000000000 -0500
+++ linux-2.6.4-rc3-msi/drivers/pci/msi.c	2004-03-12 08:58:02.000000000 -0500
@@ -19,13 +19,10 @@
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
@@ -96,7 +93,6 @@
 {
 	struct msi_desc *entry;
 	struct msg_address address;
-	unsigned int dest_id;
 
 	entry = (struct msi_desc *)msi_desc[vector];
 	if (!entry || !entry->dev)
@@ -113,10 +109,9 @@
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
@@ -129,10 +124,9 @@
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
@@ -265,11 +259,11 @@
 
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
@@ -277,18 +271,8 @@
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
@@ -298,10 +282,10 @@
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
 
@@ -314,7 +298,7 @@
 		return -ENOSPC;
 
 	vector_irq[current_vector] = irq;
-	if (irq != MSI_AUTO)
+	if (irq != AUTO_ASSIGN)
 		IO_APIC_VECTOR(irq) = current_vector;
 
 	nr_alloc_vectors++;
@@ -364,8 +348,8 @@
 		return -EBUSY;
 	}
 
-	vector = assign_irq_vector(MSI_AUTO);
-	if (vector  == (FIRST_SYSTEM_VECTOR - 8))
+	vector = assign_irq_vector(AUTO_ASSIGN);	
+	if (vector  == LAST_DEVICE_VECTOR)
 		new_vector_avail = 0;
 
 	spin_unlock_irqrestore(&msi_lock, flags);
diff -urN linux-2.6.4-rc3/drivers/pci/msi.h linux-2.6.4-rc3-msi/drivers/pci/msi.h
--- linux-2.6.4-rc3/drivers/pci/msi.h	2004-03-09 19:00:38.000000000 -0500
+++ linux-2.6.4-rc3-msi/drivers/pci/msi.h	2004-03-11 14:52:57.000000000 -0500
@@ -8,7 +8,33 @@
 #ifndef MSI_H
 #define MSI_H
 
-#define MSI_AUTO -1
+#ifndef CONFIG_IA64
+#include <asm/desc.h>	
+#ifndef CONFIG_X86_64
+#include <mach_apic.h>  
+#endif
+#define LAST_DEVICE_VECTOR	(FIRST_SYSTEM_VECTOR - 8)
+#define VECTOR_STEP		8
+#else 
+#define FIRST_DEVICE_VECTOR 	IA64_FIRST_DEVICE_VECTOR
+#define LAST_DEVICE_VECTOR	IA64_LAST_DEVICE_VECTOR
+#define FIRST_SYSTEM_VECTOR 	(IA64_LAST_DEVICE_VECTOR + 1)
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
 
@@ -36,12 +62,25 @@
 static inline void move_msi(int vector) {}
 #endif
 
-#ifndef CONFIG_X86_IO_APIC
-static inline int get_ioapic_vector(struct pci_dev *dev) { return -1;}
-static inline void restore_ioapic_irq_handler(int irq) {}
+static inline int vector_resources(void)
+{
+ 	int res;
+#ifndef CONFIG_IA64
+ 	int i, repeat;
+ 	for (i = NR_REPEATS; i > 0; i--) {
+ 		if ((FIRST_DEVICE_VECTOR + i * 8) > FIRST_SYSTEM_VECTOR)
+ 			continue;
+ 		break;
+ 	}
+ 	i++;
+ 	repeat = (FIRST_SYSTEM_VECTOR - FIRST_DEVICE_VECTOR)/i;
+ 	res = i * repeat - NR_RESERVED_VECTORS + 1;
 #else
-extern void restore_ioapic_irq_handler(int irq);
+ 	res = LAST_DEVICE_VECTOR - FIRST_DEVICE_VECTOR - 1;
 #endif
+ 	
+ 	return res;
+}
 
 /*
  * MSI-X Address Register
@@ -85,25 +124,34 @@
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
diff -urN linux-2.6.4-rc3/include/asm-ia64/hw_irq.h linux-2.6.4-rc3-msi/include/asm-ia64/hw_irq.h
--- linux-2.6.4-rc3/include/asm-ia64/hw_irq.h	2004-03-09 19:00:29.000000000 -0500
+++ linux-2.6.4-rc3-msi/include/asm-ia64/hw_irq.h	2004-03-11 14:52:57.000000000 -0500
@@ -34,6 +34,8 @@
 #define IA64_MAX_VECTORED_IRQ		255
 #define IA64_NUM_VECTORS		256
 
+#define AUTO_ASSIGN			-1
+
 #define IA64_SPURIOUS_INT_VECTOR	0x0f
 
 /*
