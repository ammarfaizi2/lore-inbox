Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262309AbUCXXsG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 18:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbUCXXsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 18:48:06 -0500
Received: from fmr05.intel.com ([134.134.136.6]:24991 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S262309AbUCXXq5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 18:46:57 -0500
Date: Wed, 24 Mar 2004 17:21:27 -0800
From: long <tlnguyen@snoqualmie.dp.intel.com>
Message-Id: <200403250121.i2P1LRoO003081@snoqualmie.dp.intel.com>
To: zwane@linuxpower.ca
Subject: RE[PATCH]2.6.5-rc2 MSI Support for IA64
Cc: davidm@napali.hpl.hp.com, grep@kroah.com, jgarzik@pobox.com,
       jun.nakajima@intel.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, tom.l.nguyen@intel.com,
       tony.luck@intel.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane,

I updated the patch based on inputs below:

1. Both you and David Mosberger agreed on consolidating the vector
allocators as assign_irq_vector(AUTO_ASSIGN) has the same semantics
as ia64_alloc_vector(). This patch converts the existing uses of
ia64_alloc_vector() to assign_irq_vector(AUTO_ASSIGN).

2. Regarding vector allocation, assign_irq_vector() in existing 
drivers/pci/msi.c only allocate 166 vectors before going -ENOSPC.
This patch modifies the existing function assign_irq_vector() in
drivers/pci/msi.c to maximize the number of allocated vectors to
188 before going -ENOSPC. 

3. As you pointed out that ia64 already does the vector based 
interrupt numbering. In this patch, CONFIG_PCI_USE_VECTOR will 
be defined as below.
 
+config PCI_USE_VECTOR
+	bool
+	default y if IA64
+	help
+	   This enables MSI, Message Signaled Interrupt, on specific 
+	   MSI capable device functions detected upon requests from the
+	   device drivers. Message Signal Interrupt enables an MSI-capable
+	   hardware device to send an inbound Memory Write on its PCI bus
+	   instead of asserting IRQ signal on device IRQ pin.
+


Please send us your comments on this patch.

Thanks,
Long

--------------------------------------------------------------------
diff -urN linux-2.6.5-rc2/arch/ia64/hp/sim/simeth.c 2.6.5-rc2-msibase/arch/ia64/hp/sim/simeth.c
--- linux-2.6.5-rc2/arch/ia64/hp/sim/simeth.c	2004-03-19 19:11:32.000000000 -0500
+++ 2.6.5-rc2-msibase/arch/ia64/hp/sim/simeth.c	2004-03-23 11:01:52.000000000 -0500
@@ -228,7 +228,7 @@
 		return err;
 	}
 
-	dev->irq = ia64_alloc_vector();
+	dev->irq = assign_irq_vector(AUTO_ASSIGN);
 
 	/*
 	 * attach the interrupt in the simulator, this does enable interrupts
diff -urN linux-2.6.5-rc2/arch/ia64/hp/sim/simserial.c 2.6.5-rc2-msibase/arch/ia64/hp/sim/simserial.c
--- linux-2.6.5-rc2/arch/ia64/hp/sim/simserial.c	2004-03-19 19:11:11.000000000 -0500
+++ 2.6.5-rc2-msibase/arch/ia64/hp/sim/simserial.c	2004-03-23 11:01:52.000000000 -0500
@@ -1051,7 +1051,7 @@
 		if (state->type == PORT_UNKNOWN) continue;
 
 		if (!state->irq) {
-			state->irq = ia64_alloc_vector();
+			state->irq = assign_irq_vector(AUTO_ASSIGN);
 			ia64_ssc_connect_irq(KEYBOARD_INTR, state->irq);
 		}
 
diff -urN linux-2.6.5-rc2/arch/ia64/Kconfig 2.6.5-rc2-msibase/arch/ia64/Kconfig
--- linux-2.6.5-rc2/arch/ia64/Kconfig	2004-03-19 19:11:51.000000000 -0500
+++ 2.6.5-rc2-msibase/arch/ia64/Kconfig	2004-03-23 11:01:52.000000000 -0500
@@ -411,6 +411,16 @@
 	  information about which PCI hardware does work under Linux and which
 	  doesn't.
 
+config PCI_USE_VECTOR
+	bool
+	default y if IA64
+	help
+	   This enables MSI, Message Signaled Interrupt, on specific 
+	   MSI capable device functions detected upon requests from the
+	   device drivers. Message Signal Interrupt enables an MSI-capable
+	   hardware device to send an inbound Memory Write on its PCI bus
+	   instead of asserting IRQ signal on device IRQ pin.
+
 config PCI_DOMAINS
 	bool
 	default PCI
diff -urN linux-2.6.5-rc2/arch/ia64/kernel/iosapic.c 2.6.5-rc2-msibase/arch/ia64/kernel/iosapic.c
--- linux-2.6.5-rc2/arch/ia64/kernel/iosapic.c	2004-03-19 19:11:09.000000000 -0500
+++ 2.6.5-rc2-msibase/arch/ia64/kernel/iosapic.c	2004-03-23 11:01:52.000000000 -0500
@@ -435,7 +435,7 @@
 	    || iosapic_intr_info[vector].gsi_base || iosapic_intr_info[vector].dmode
 	    || iosapic_intr_info[vector].polarity || iosapic_intr_info[vector].trigger)
 	{
-		new_vector = ia64_alloc_vector();
+		new_vector = assign_irq_vector(AUTO_ASSIGN);
 		printk(KERN_INFO "Reassigning vector %d to %d\n", vector, new_vector);
 		memcpy(&iosapic_intr_info[new_vector], &iosapic_intr_info[vector],
 		       sizeof(struct iosapic_intr_info));
@@ -500,7 +500,7 @@
 
 	vector = gsi_to_vector(gsi);
 	if (vector < 0)
-		vector = ia64_alloc_vector();
+		vector = assign_irq_vector(AUTO_ASSIGN);
 
 	register_intr(gsi, vector, IOSAPIC_LOWEST_PRIORITY,
 		      polarity, trigger);
@@ -538,7 +538,7 @@
 		delivery = IOSAPIC_PMI;
 		break;
 	      case ACPI_INTERRUPT_INIT:
-		vector = ia64_alloc_vector();
+		vector = assign_irq_vector(AUTO_ASSIGN);
 		delivery = IOSAPIC_INIT;
 		break;
 	      case ACPI_INTERRUPT_CPEI:
@@ -708,7 +708,7 @@
 				vector = isa_irq_to_vector(gsi);
 			else
 				/* new GSI; allocate a vector for it */
-				vector = ia64_alloc_vector();
+				vector = assign_irq_vector(AUTO_ASSIGN);
 
 			register_intr(gsi, vector, IOSAPIC_LOWEST_PRIORITY, IOSAPIC_POL_LOW,
 				      IOSAPIC_LEVEL);
diff -urN linux-2.6.5-rc2/arch/ia64/kernel/irq_ia64.c 2.6.5-rc2-msibase/arch/ia64/kernel/irq_ia64.c
--- linux-2.6.5-rc2/arch/ia64/kernel/irq_ia64.c	2004-03-19 19:11:05.000000000 -0500
+++ 2.6.5-rc2-msibase/arch/ia64/kernel/irq_ia64.c	2004-03-23 11:01:52.000000000 -0500
@@ -73,13 +73,13 @@
 }
 
 int
-ia64_alloc_vector (void)
+assign_irq_vector (int irq)
 {
 	static int next_vector = IA64_FIRST_DEVICE_VECTOR;
 
 	if (next_vector > IA64_LAST_DEVICE_VECTOR)
 		/* XXX could look for sharable vectors instead of panic'ing... */
-		panic("ia64_alloc_vector: out of interrupt vectors!");
+		panic("assign_irq_vector: out of interrupt vectors!");
 	return next_vector++;
 }
 
diff -urN linux-2.6.5-rc2/drivers/pci/msi.c 2.6.5-rc2-msibase/drivers/pci/msi.c
--- linux-2.6.5-rc2/drivers/pci/msi.c	2004-03-19 19:11:50.000000000 -0500
+++ 2.6.5-rc2-msibase/drivers/pci/msi.c	2004-03-23 11:01:52.000000000 -0500
@@ -19,19 +19,16 @@
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
 
 static int pci_msi_enable = 1;
-static int nr_alloc_vectors = 0;
+static int last_alloc_vector = 0;
 static int nr_released_vectors = 0;
 static int nr_reserved_vectors = NR_HP_RESERVED_VECTORS;
 static int nr_msix_devices = 0;
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
@@ -265,62 +259,39 @@
 
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
 
-static int pci_vector_resources(void)
-{
-	static int res = -EINVAL;
-	int nr_free_vectors;
-
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
-	nr_free_vectors = res + nr_released_vectors - nr_alloc_vectors;
-
-	return nr_free_vectors;
-}
-
+#ifndef CONFIG_IA64
 int assign_irq_vector(int irq)
 {
 	static int current_vector = FIRST_DEVICE_VECTOR, offset = 0;
 
-	if (irq != MSI_AUTO && IO_APIC_VECTOR(irq) > 0)
+	if (irq != AUTO_ASSIGN && IO_APIC_VECTOR(irq) > 0)
 		return IO_APIC_VECTOR(irq);
 next:
-	current_vector += 8;
+	current_vector += 8;	
 	if (current_vector == SYSCALL_VECTOR)
 		goto next;
 
-	if (current_vector > FIRST_SYSTEM_VECTOR) {
+	if (current_vector >= FIRST_SYSTEM_VECTOR) {
 		offset++;
+		if (!(offset%8))
+			return -ENOSPC;
 		current_vector = FIRST_DEVICE_VECTOR + offset;
 	}
 
-	if (current_vector == FIRST_SYSTEM_VECTOR)
-		return -ENOSPC;
-
 	vector_irq[current_vector] = irq;
-	if (irq != MSI_AUTO)
+	if (irq != AUTO_ASSIGN)
 		IO_APIC_VECTOR(irq) = current_vector;
 
-	nr_alloc_vectors++;
-
 	return current_vector;
 }
+#endif
 
 static int assign_msi_vector(void)
 {
@@ -333,10 +304,6 @@
 	 * vector is assigned unique among drivers.
 	 */
 	spin_lock_irqsave(&msi_lock, flags);
-	if (!(pci_vector_resources() > 0)) {
-		spin_unlock_irqrestore(&msi_lock, flags);
-		return -EBUSY;
-	}
 
 	if (!new_vector_avail) {
 		/*
@@ -363,9 +330,9 @@
 		spin_unlock_irqrestore(&msi_lock, flags);
 		return -EBUSY;
 	}
-
-	vector = assign_irq_vector(MSI_AUTO);
-	if (vector  == (FIRST_SYSTEM_VECTOR - 8))
+	vector = assign_irq_vector(AUTO_ASSIGN);	
+	last_alloc_vector = vector;
+	if (vector  == LAST_DEVICE_VECTOR)
 		new_vector_avail = 0;
 
 	spin_unlock_irqrestore(&msi_lock, flags);
@@ -924,7 +891,8 @@
 	 * msi_lock is provided to ensure that enough vectors resources are
 	 * available before granting.
 	 */
-	free_vectors = pci_vector_resources();
+	free_vectors = pci_vector_resources(last_alloc_vector, 
+				nr_released_vectors);
 	/* Ensure that each MSI/MSI-X device has one vector reserved by
 	   default to avoid any MSI-X driver to take all available
  	   resources */
diff -urN linux-2.6.5-rc2/drivers/pci/msi.h 2.6.5-rc2-msibase/drivers/pci/msi.h
--- linux-2.6.5-rc2/drivers/pci/msi.h	2004-03-19 19:11:33.000000000 -0500
+++ 2.6.5-rc2-msibase/drivers/pci/msi.h	2004-03-23 11:01:52.000000000 -0500
@@ -8,10 +8,30 @@
 #ifndef MSI_H
 #define MSI_H
 
-#define MSI_AUTO -1
-#define NR_REPEATS	23
-#define NR_RESERVED_VECTORS 3 /*FIRST_DEVICE_VECTOR,FIRST_SYSTEM_VECTOR,0x80 */
-
+#ifndef CONFIG_IA64
+#include <asm/desc.h>	
+#ifndef CONFIG_X86_64
+#include <mach_apic.h>  
+#endif
+#define LAST_DEVICE_VECTOR	232
+#else 
+#define FIRST_DEVICE_VECTOR 	IA64_FIRST_DEVICE_VECTOR
+#define LAST_DEVICE_VECTOR	IA64_LAST_DEVICE_VECTOR
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
 /*
  * Assume the maximum number of hot plug slots supported by the system is about
  * ten. The worstcase is that each of these slots is hot-added with a device,
@@ -36,12 +56,34 @@
 static inline void move_msi(int vector) {}
 #endif
 
-#ifndef CONFIG_X86_IO_APIC
-static inline int get_ioapic_vector(struct pci_dev *dev) { return -1;}
-static inline void restore_ioapic_irq_handler(int irq) {}
+static inline int pci_vector_resources(int last, int nr_released)
+{					
+	int count = nr_released;
+
+#ifndef CONFIG_IA64
+	int next = last;
+	int offset = (last % 8);
+
+	while (next < FIRST_SYSTEM_VECTOR) {
+		next += 8;
+		if (next == SYSCALL_VECTOR)
+			continue;
+		count++;
+		if (next >= FIRST_SYSTEM_VECTOR) {
+			if (offset%8) {
+				next = FIRST_DEVICE_VECTOR + offset;
+				offset++;
+				continue;
+			} 
+			count--;
+		} 	
+	}
 #else
-extern void restore_ioapic_irq_handler(int irq);
+ 	count += (LAST_DEVICE_VECTOR - last);
 #endif
+	
+	return count; 
+}
 
 /*
  * MSI-X Address Register
@@ -85,25 +127,34 @@
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
diff -urN linux-2.6.5-rc2/include/asm-ia64/hw_irq.h 2.6.5-rc2-msibase/include/asm-ia64/hw_irq.h
--- linux-2.6.5-rc2/include/asm-ia64/hw_irq.h	2004-03-19 19:11:09.000000000 -0500
+++ 2.6.5-rc2-msibase/include/asm-ia64/hw_irq.h	2004-03-23 11:01:52.000000000 -0500
@@ -34,6 +34,8 @@
 #define IA64_MAX_VECTORED_IRQ		255
 #define IA64_NUM_VECTORS		256
 
+#define AUTO_ASSIGN			-1
+
 #define IA64_SPURIOUS_INT_VECTOR	0x0f
 
 /*
@@ -80,7 +82,7 @@
 
 extern struct hw_interrupt_type irq_type_ia64_lsapic;	/* CPU-internal interrupt controller */
 
-extern int ia64_alloc_vector (void);	/* allocate a free vector */
+extern int assign_irq_vector (int irq);	/* allocate a free vector */
 extern void ia64_send_ipi (int cpu, int vector, int delivery_mode, int redirect);
 extern void register_percpu_irq (ia64_vector vec, struct irqaction *action);
 
