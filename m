Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964963AbVKHPBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964963AbVKHPBU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 10:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964973AbVKHPBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 10:01:20 -0500
Received: from fmr24.intel.com ([143.183.121.16]:24252 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S964963AbVKHPBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 10:01:19 -0500
Date: Tue, 8 Nov 2005 07:00:38 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, gregkh@suse.de, ak@muc.de
Subject: Changing MSI to use physical delivery mode always.
Message-ID: <20051108070038.A15318@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

MSI was hard coded to use logical delivery mode for i386/x86_64 and 
physical mode for ia64.

With recent x86_64 we moved to physical flat mode that broke MSI.

Made MSI to work with physical mode, this will be consistent on all
archs. 

-- 
Cheers,
Ashok Raj
- Open Source Technology Center


MSI hardcoded delivery mode to use logical delivery mode. Recently 
x86_64 moved to use physical mode addressing to support physflat mode.
With this mode enabled noticed that my eth with MSI werent working. 

msi_address_init()  was hardcoded to use logical mode for i386 and x86_64.
So when we switch to use physical mode, things stopped working.

Since anyway we dont use lowest priority delivery with MSI, its always
directed to just a single CPU. Its safe  and simpler to use 
physical mode always, even when we use logical delivery mode for IPI's 
or other ioapic RTE's.


Signed-off-by: Ashok Raj <ashok.raj@intel.com>
-----------------------------------------------------------
 drivers/pci/msi.c        |   19 +++++++++++--------
 include/asm-i386/msi.h   |    9 +--------
 include/asm-i386/smp.h   |    6 ++++++
 include/asm-ia64/msi.h   |    3 ---
 include/asm-x86_64/msi.h |    4 +---
 include/asm-x86_64/smp.h |    6 ++++++
 6 files changed, 25 insertions(+), 22 deletions(-)

Index: linux-2.6.14-mm1/drivers/pci/msi.c
===================================================================
--- linux-2.6.14-mm1.orig/drivers/pci/msi.c
+++ linux-2.6.14-mm1/drivers/pci/msi.c
@@ -23,6 +23,8 @@
 #include "pci.h"
 #include "msi.h"
 
+#define TARGET_CPU		first_cpu(cpu_online_map)
+
 static DEFINE_SPINLOCK(msi_lock);
 static struct msi_desc* msi_desc[NR_IRQS] = { [0 ... NR_IRQS-1] = NULL };
 static kmem_cache_t* msi_cachep;
@@ -92,6 +94,7 @@ static void set_msi_affinity(unsigned in
 	struct msi_desc *entry;
 	struct msg_address address;
 	unsigned int irq = vector;
+	unsigned int dest_cpu = first_cpu(cpu_mask);
 
 	entry = (struct msi_desc *)msi_desc[vector];
 	if (!entry || !entry->dev)
@@ -108,9 +111,9 @@ static void set_msi_affinity(unsigned in
 		pci_read_config_dword(entry->dev, msi_lower_address_reg(pos),
 			&address.lo_address.value);
 		address.lo_address.value &= MSI_ADDRESS_DEST_ID_MASK;
-		address.lo_address.value |= (cpu_mask_to_apicid(cpu_mask) <<
-			MSI_TARGET_CPU_SHIFT);
-		entry->msi_attrib.current_cpu = cpu_mask_to_apicid(cpu_mask);
+		address.lo_address.value |= (cpu_physical_id(dest_cpu) <<
+									MSI_TARGET_CPU_SHIFT);
+		entry->msi_attrib.current_cpu = cpu_physical_id(dest_cpu);
 		pci_write_config_dword(entry->dev, msi_lower_address_reg(pos),
 			address.lo_address.value);
 		set_native_irq_info(irq, cpu_mask);
@@ -123,9 +126,8 @@ static void set_msi_affinity(unsigned in
 
 		address.lo_address.value = readl(entry->mask_base + offset);
 		address.lo_address.value &= MSI_ADDRESS_DEST_ID_MASK;
-		address.lo_address.value |= (cpu_mask_to_apicid(cpu_mask) <<
-			MSI_TARGET_CPU_SHIFT);
-		entry->msi_attrib.current_cpu = cpu_mask_to_apicid(cpu_mask);
+		address.lo_address.value |= (dest_cpu << MSI_TARGET_CPU_SHIFT);
+		entry->msi_attrib.current_cpu = cpu_physical_id(dest_cpu);
 		writel(address.lo_address.value, entry->mask_base + offset);
 		set_native_irq_info(irq, cpu_mask);
 		break;
@@ -259,14 +261,15 @@ static void msi_data_init(struct msg_dat
 static void msi_address_init(struct msg_address *msi_address)
 {
 	unsigned int	dest_id;
+	unsigned long	dest_phys_id = cpu_physical_id(TARGET_CPU);
 
 	memset(msi_address, 0, sizeof(struct msg_address));
 	msi_address->hi_address = (u32)0;
 	dest_id = (MSI_ADDRESS_HEADER << MSI_ADDRESS_HEADER_SHIFT);
-	msi_address->lo_address.u.dest_mode = MSI_DEST_MODE;
+	msi_address->lo_address.u.dest_mode = MSI_PHYSICAL_MODE;
 	msi_address->lo_address.u.redirection_hint = MSI_REDIRECTION_HINT_MODE;
 	msi_address->lo_address.u.dest_id = dest_id;
-	msi_address->lo_address.value |= (MSI_TARGET_CPU << MSI_TARGET_CPU_SHIFT);
+	msi_address->lo_address.value |= (dest_phys_id << MSI_TARGET_CPU_SHIFT);
 }
 
 static int msi_free_vector(struct pci_dev* dev, int vector, int reassign);
Index: linux-2.6.14-mm1/include/asm-i386/msi.h
===================================================================
--- linux-2.6.14-mm1.orig/include/asm-i386/msi.h
+++ linux-2.6.14-mm1/include/asm-i386/msi.h
@@ -10,13 +10,6 @@
 #include <mach_apic.h>
 
 #define LAST_DEVICE_VECTOR		232
-#define MSI_DEST_MODE			MSI_LOGICAL_MODE
-#define MSI_TARGET_CPU_SHIFT		12
-
-#ifdef CONFIG_SMP
-#define MSI_TARGET_CPU		logical_smp_processor_id()
-#else
-#define MSI_TARGET_CPU	cpu_to_logical_apicid(first_cpu(cpu_online_map))
-#endif
+#define MSI_TARGET_CPU_SHIFT	12
 
 #endif /* ASM_MSI_H */
Index: linux-2.6.14-mm1/include/asm-i386/smp.h
===================================================================
--- linux-2.6.14-mm1.orig/include/asm-i386/smp.h
+++ linux-2.6.14-mm1/include/asm-i386/smp.h
@@ -45,6 +45,8 @@ extern void unlock_ipi_call_lock(void);
 #define MAX_APICID 256
 extern u8 x86_cpu_to_apicid[];
 
+#define cpu_physical_id(cpu)	x86_cpu_to_apicid[cpu]
+
 #ifdef CONFIG_HOTPLUG_CPU
 extern void cpu_exit_clear(void);
 extern void cpu_uninit(void);
@@ -92,6 +94,10 @@ extern int __cpu_disable(void);
 extern void __cpu_die(unsigned int cpu);
 #endif /* !__ASSEMBLY__ */
 
+#else /* CONFIG_SMP */
+
+#define cpu_physical_id(cpu)		boot_cpu_physical_apicid
+
 #define NO_PROC_ID		0xFF		/* No processor magic marker */
 
 #endif
Index: linux-2.6.14-mm1/include/asm-ia64/msi.h
===================================================================
--- linux-2.6.14-mm1.orig/include/asm-ia64/msi.h
+++ linux-2.6.14-mm1/include/asm-ia64/msi.h
@@ -12,9 +12,6 @@
 static inline void set_intr_gate (int nr, void *func) {}
 #define IO_APIC_VECTOR(irq)	(irq)
 #define ack_APIC_irq		ia64_eoi
-#define cpu_mask_to_apicid(mask) cpu_physical_id(first_cpu(mask))
-#define MSI_DEST_MODE		MSI_PHYSICAL_MODE
-#define MSI_TARGET_CPU	((ia64_getreg(_IA64_REG_CR_LID) >> 16) & 0xffff)
 #define MSI_TARGET_CPU_SHIFT	4
 
 #endif /* ASM_MSI_H */
Index: linux-2.6.14-mm1/include/asm-x86_64/msi.h
===================================================================
--- linux-2.6.14-mm1.orig/include/asm-x86_64/msi.h
+++ linux-2.6.14-mm1/include/asm-x86_64/msi.h
@@ -11,8 +11,6 @@
 #include <asm/smp.h>
 
 #define LAST_DEVICE_VECTOR		232
-#define MSI_DEST_MODE			MSI_LOGICAL_MODE
-#define MSI_TARGET_CPU_SHIFT		12
-#define MSI_TARGET_CPU			logical_smp_processor_id()
+#define MSI_TARGET_CPU_SHIFT	12
 
 #endif /* ASM_MSI_H */
Index: linux-2.6.14-mm1/include/asm-x86_64/smp.h
===================================================================
--- linux-2.6.14-mm1.orig/include/asm-x86_64/smp.h
+++ linux-2.6.14-mm1/include/asm-x86_64/smp.h
@@ -135,5 +135,11 @@ static __inline int logical_smp_processo
 }
 #endif
 
+#ifdef CONFIG_SMP
+#define cpu_physical_id(cpu)		x86_cpu_to_apicid[cpu]
+#else
+#define cpu_physical_id(cpu)		boot_cpu_id
+#endif
+
 #endif
 
