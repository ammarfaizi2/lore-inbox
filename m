Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbVKVANk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbVKVANk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 19:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964787AbVKVANQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 19:13:16 -0500
Received: from fmr23.intel.com ([143.183.121.15]:7148 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S964781AbVKVANN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 19:13:13 -0500
Message-Id: <20051122000204.778874000@araj-sfield-2>
References: <20051121233914.979360000@araj-sfield-2>
Date: Mon, 21 Nov 2005 15:39:15 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, ak@muc.de, gregkh@suse.de, venkatesh.pallipadi@intel.com
Subject: [patch 1/2] Convert bigsmp to use flat physical mode
Content-Disposition: inline; filename=bigsmp_physflat_03.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When we bring up a new CPU via INIT/startup IPI messages, the CPU that's coming
up sends a xTPR message to the chipset. Intel chipsets (at least) don't provide
any architectural guarantee on what the chipset will do with this message. For
example, the E850x chipsets uses this xTPR message to interpret the interrupt
operating mode of the platform. When the CPU coming online sends this message,
it always indicates that it is in logical flat mode. For the CPU hotplug case,
the platform may already be functioning in cluster APIC mode at this time, the
chipset can get confused and mishandle I/O device and IPI interrupt routing.

The situation eventually gets corrected when the new CPU sends another xTPR
update when we switch it to cluster mode, but there's a window during which the
chipset may be in an inconsistent state. This patch avoids this problem by
using the flat physical interrupt delivery mode instead of cluster mode for
bigsmp (>8 cpu) support.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Depends on: pci-changing-msi-to-use-physical-delivery-mode-always.patch
>From Gregkh's tree.

---------------------------------------------------------------
 include/asm-i386/mach-bigsmp/mach_apic.h    |   75 ++++++++++++----------------
 include/asm-i386/mach-bigsmp/mach_apicdef.h |    4 -
 2 files changed, 36 insertions(+), 43 deletions(-)

Index: linux-2.6.15-rc1-mm2/include/asm-i386/mach-bigsmp/mach_apic.h
===================================================================
--- linux-2.6.15-rc1-mm2.orig/include/asm-i386/mach-bigsmp/mach_apic.h
+++ linux-2.6.15-rc1-mm2/include/asm-i386/mach-bigsmp/mach_apic.h
@@ -1,17 +1,10 @@
 #ifndef __ASM_MACH_APIC_H
 #define __ASM_MACH_APIC_H
-#include <asm/smp.h>
 
-#define SEQUENTIAL_APICID
-#ifdef SEQUENTIAL_APICID
-#define xapic_phys_to_log_apicid(phys_apic) ( (1ul << ((phys_apic) & 0x3)) |\
-		((phys_apic<<2) & (~0xf)) )
-#elif CLUSTERED_APICID
-#define xapic_phys_to_log_apicid(phys_apic) ( (1ul << ((phys_apic) & 0x3)) |\
-		((phys_apic) & (~0xf)) )
-#endif
 
-#define NO_BALANCE_IRQ (1)
+extern u8 bios_cpu_apicid[];
+
+#define xapic_phys_to_log_apicid(cpu) (bios_cpu_apicid[cpu])
 #define esr_disable (1)
 
 static inline int apic_id_registered(void)
@@ -19,7 +12,6 @@ static inline int apic_id_registered(voi
 	return (1);
 }
 
-#define APIC_DFR_VALUE	(APIC_DFR_CLUSTER)
 /* Round robin the irqs amoung the online cpus */
 static inline cpumask_t target_cpus(void)
 { 
@@ -32,29 +24,34 @@ static inline cpumask_t target_cpus(void
 	} while (cpu >= NR_CPUS);
 	return cpumask_of_cpu(cpu);
 }
-#define TARGET_CPUS	(target_cpus())
 
-#define INT_DELIVERY_MODE dest_Fixed
-#define INT_DEST_MODE 1     /* logical delivery broadcast to all procs */
+#undef APIC_DEST_LOGICAL
+#define APIC_DEST_LOGICAL 	0
+#define TARGET_CPUS		(target_cpus())
+#define APIC_DFR_VALUE		(APIC_DFR_FLAT)
+#define INT_DELIVERY_MODE	(dest_Fixed)
+#define INT_DEST_MODE		(0)    /* phys delivery to target proc */
+#define NO_BALANCE_IRQ		(0)
+#define WAKE_SECONDARY_VIA_INIT
+
 
 static inline unsigned long check_apicid_used(physid_mask_t bitmap, int apicid)
 {
-	return 0;
+	return (0);
 }
 
-/* we don't use the phys_cpu_present_map to indicate apicid presence */
-static inline unsigned long check_apicid_present(int bit) 
+static inline unsigned long check_apicid_present(int bit)
 {
-	return 1;
+	return (1);
 }
 
-#define apicid_cluster(apicid) (apicid & 0xF0)
-
-static inline unsigned long calculate_ldr(unsigned long old)
+static inline unsigned long calculate_ldr(int cpu)
 {
-	unsigned long id;
-	id = xapic_phys_to_log_apicid(hard_smp_processor_id());
-	return ((old & ~APIC_LDR_MASK) | SET_APIC_LOGICAL_ID(id));
+	unsigned long val, id;
+	val = apic_read(APIC_LDR) & ~APIC_LDR_MASK;
+	id = xapic_phys_to_log_apicid(cpu);
+	val |= SET_APIC_LOGICAL_ID(id);
+	return val;
 }
 
 /*
@@ -67,37 +64,35 @@ static inline unsigned long calculate_ld
 static inline void init_apic_ldr(void)
 {
 	unsigned long val;
+	int cpu = smp_processor_id();
 
 	apic_write_around(APIC_DFR, APIC_DFR_VALUE);
-	val = apic_read(APIC_LDR) & ~APIC_LDR_MASK;
-	val = calculate_ldr(val);
+	val = calculate_ldr(cpu);
 	apic_write_around(APIC_LDR, val);
 }
 
 static inline void clustered_apic_check(void)
 {
 	printk("Enabling APIC mode:  %s.  Using %d I/O APICs\n",
-		"Cluster", nr_ioapics);
+		"Physflat", nr_ioapics);
 }
 
 static inline int multi_timer_check(int apic, int irq)
 {
-	return 0;
+	return (0);
 }
 
 static inline int apicid_to_node(int logical_apicid)
 {
-	return 0;
+	return (0);
 }
 
-extern u8 bios_cpu_apicid[];
-
 static inline int cpu_present_to_apicid(int mps_cpu)
 {
 	if (mps_cpu < NR_CPUS)
-		return (int)bios_cpu_apicid[mps_cpu];
-	else
-		return BAD_APICID;
+		return (int) bios_cpu_apicid[mps_cpu];
+
+	return BAD_APICID;
 }
 
 static inline physid_mask_t apicid_to_cpu_present(int phys_apicid)
@@ -109,10 +104,10 @@ extern u8 cpu_2_logical_apicid[];
 /* Mapping from cpu number to logical apicid */
 static inline int cpu_to_logical_apicid(int cpu)
 {
-       if (cpu >= NR_CPUS)
-	       return BAD_APICID;
-       return (int)cpu_2_logical_apicid[cpu];
- }
+	if (cpu >= NR_CPUS)
+		return BAD_APICID;
+	return cpu_physical_id(cpu);
+}
 
 static inline int mpc_apic_id(struct mpc_config_processor *m,
 			struct mpc_config_translation *translation_record)
@@ -128,11 +123,9 @@ static inline int mpc_apic_id(struct mpc
 static inline physid_mask_t ioapic_phys_id_map(physid_mask_t phys_map)
 {
 	/* For clustered we don't have a good way to do this yet - hack */
-	return physids_promote(0xFUL);
+	return physids_promote(0xFFL);
 }
 
-#define WAKE_SECONDARY_VIA_INIT
-
 static inline void setup_portio_remap(void)
 {
 }
Index: linux-2.6.15-rc1-mm2/include/asm-i386/mach-bigsmp/mach_apicdef.h
===================================================================
--- linux-2.6.15-rc1-mm2.orig/include/asm-i386/mach-bigsmp/mach_apicdef.h
+++ linux-2.6.15-rc1-mm2/include/asm-i386/mach-bigsmp/mach_apicdef.h
@@ -1,11 +1,11 @@
 #ifndef __ASM_MACH_APICDEF_H
 #define __ASM_MACH_APICDEF_H
 
-#define		APIC_ID_MASK		(0x0F<<24)
+#define		APIC_ID_MASK		(0xFF<<24)
 
 static inline unsigned get_apic_id(unsigned long x) 
 { 
-	return (((x)>>24)&0x0F);
+	return (((x)>>24)&0xFF);
 } 
 
 #define		GET_APIC_ID(x)	get_apic_id(x)

--

