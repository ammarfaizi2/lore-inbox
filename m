Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266989AbTAOTMO>; Wed, 15 Jan 2003 14:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267005AbTAOTMN>; Wed, 15 Jan 2003 14:12:13 -0500
Received: from franka.aracnet.com ([216.99.193.44]:48267 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S266989AbTAOTLZ>; Wed, 15 Jan 2003 14:11:25 -0500
Date: Wed, 15 Jan 2003 11:20:14 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] (3/5) Make IRQ balancing work with clustered APICs
Message-ID: <13140000.1042658414@titus>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch from James Cleverdon & John Stultz

The IRQ balancing code currently assumes that the logical apicid is
always '1 << cpu', which is not true for the larger platforms.
We express this as an abstracted macro instead, and move the 
cpu_to_logical_apicid definition to subarch, so we can make it exactly
"1 << cpu" for normal machines - maximum speed, minimum change risk.

A couple of things are abstracted from the smp_boot_cpus loop in order
to enable us to use the bios_cpu_apicid array to boot cpus from without
disturbing the code path of current machines.

diff -Nru a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
--- a/arch/i386/kernel/io_apic.c	Tue Jan 14 00:42:37 2003
+++ b/arch/i386/kernel/io_apic.c	Tue Jan 14 00:42:37 2003
@@ -278,7 +278,7 @@
 		new_cpu = move(entry->cpu, allowed_mask, now, random_number);
 		if (entry->cpu != new_cpu) {
 			entry->cpu = new_cpu;
-			set_ioapic_affinity(irq, 1 << new_cpu);
+			set_ioapic_affinity(irq, cpu_to_logical_apicid(new_cpu));
 		}
 	}
 }
diff -Nru a/arch/i386/kernel/smp.c b/arch/i386/kernel/smp.c
--- a/arch/i386/kernel/smp.c	Tue Jan 14 00:42:37 2003
+++ b/arch/i386/kernel/smp.c	Tue Jan 14 00:42:37 2003
@@ -24,6 +24,7 @@
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include <mach_ipi.h>
+#include <mach_apic.h>
 
 /*
  *	Some notes on x86 processor bugs affecting SMP operation:
diff -Nru a/arch/i386/kernel/smpboot.c b/arch/i386/kernel/smpboot.c
--- a/arch/i386/kernel/smpboot.c	Tue Jan 14 00:42:37 2003
+++ b/arch/i386/kernel/smpboot.c	Tue Jan 14 00:42:37 2003
@@ -1045,10 +1045,10 @@
 		/*
 		 * Don't even attempt to start the boot CPU!
 		 */
-		if (apicid == boot_cpu_apicid)
+		if ((apicid == boot_cpu_apicid) || (apicid == BAD_APICID))
 			continue;
 
-		if (!(phys_cpu_present_map & (1 << bit)))
+		if (!check_apicid_present(bit))
 			continue;
 		if (max_cpus <= cpucount+1)
 			continue;
diff -Nru a/include/asm-i386/mach-bigsmp/mach_apic.h b/include/asm-i386/mach-bigsmp/mach_apic.h
--- a/include/asm-i386/mach-bigsmp/mach_apic.h	Tue Jan 14 00:42:37 2003
+++ b/include/asm-i386/mach-bigsmp/mach_apic.h	Tue Jan 14 00:42:37 2003
@@ -26,6 +26,7 @@
 
 #define APIC_BROADCAST_ID     (0x0f)
 #define check_apicid_used(bitmap, apicid) (0)
+#define check_apicid_present(bit) (phys_cpu_present_map & (1 << bit))
 
 static inline unsigned long calculate_ldr(unsigned long old)
 {
@@ -78,6 +79,13 @@
 {
 	return (1ul << phys_apicid);
 }
+
+extern volatile u8 cpu_2_logical_apicid[];
+/* Mapping from cpu number to logical apicid */
+static inline int cpu_to_logical_apicid(int cpu)
+{
+       return (int)cpu_2_logical_apicid[cpu];
+ }
 
 static inline int mpc_apic_id(struct mpc_config_processor *m, int quad)
 {
diff -Nru a/include/asm-i386/mach-default/mach_apic.h b/include/asm-i386/mach-default/mach_apic.h
--- a/include/asm-i386/mach-default/mach_apic.h	Tue Jan 14 00:42:37 2003
+++ b/include/asm-i386/mach-default/mach_apic.h	Tue Jan 14 00:42:37 2003
@@ -17,6 +17,7 @@
 
 #define APIC_BROADCAST_ID      0x0F
 #define check_apicid_used(bitmap, apicid) (bitmap & (1 << apicid))
+#define check_apicid_present(bit) (phys_cpu_present_map & (1 << bit))
 
 static inline int apic_id_registered(void)
 {
@@ -60,6 +61,12 @@
 static inline int apicid_to_node(int logical_apicid)
 {
 	return 0;
+}
+
+/* Mapping from cpu number to logical apicid */
+static inline int cpu_to_logical_apicid(int cpu)
+{
+	return 1 << cpu;
 }
 
 static inline int cpu_present_to_apicid(int mps_cpu)
diff -Nru a/include/asm-i386/mach-numaq/mach_apic.h b/include/asm-i386/mach-numaq/mach_apic.h
--- a/include/asm-i386/mach-numaq/mach_apic.h	Tue Jan 14 00:42:37 2003
+++ b/include/asm-i386/mach-numaq/mach_apic.h	Tue Jan 14 00:42:37 2003
@@ -13,6 +13,7 @@
  
 #define APIC_BROADCAST_ID      0x0F
 #define check_apicid_used(bitmap, apicid) ((bitmap) & (1 << (apicid)))
+#define check_apicid_present(bit) (phys_cpu_present_map & (1 << bit))
 
 static inline int apic_id_registered(void)
 {
@@ -43,6 +44,13 @@
 {
 	/* We don't have a good way to do this yet - hack */
 	return 0xf;
+}
+
+/* Mapping from cpu number to logical apicid */
+extern volatile u8 cpu_2_logical_apicid[];
+static inline int cpu_to_logical_apicid(int cpu)
+{
+	return (int)cpu_2_logical_apicid[cpu];
 }
 
 static inline int cpu_present_to_apicid(int mps_cpu)
diff -Nru a/include/asm-i386/mach-summit/mach_apic.h b/include/asm-i386/mach-summit/mach_apic.h
--- a/include/asm-i386/mach-summit/mach_apic.h	Tue Jan 14 00:42:37 2003
+++ b/include/asm-i386/mach-summit/mach_apic.h	Tue Jan 14 00:42:37 2003
@@ -31,6 +31,9 @@
 #define APIC_BROADCAST_ID     (x86_summit ? 0xFF : 0x0F)
 #define check_apicid_used(bitmap, apicid) (0)
 
+/* we don't use the phys_cpu_present_map to indicate apicid presence */
+#define check_apicid_present(bit) (1) 
+
 static inline void clustered_apic_check(void)
 {
 	printk("Enabling APIC mode:  %s.  Using %d I/O APICs\n",
@@ -40,6 +43,13 @@
 static inline int apicid_to_node(int logical_apicid)
 {
 	return (logical_apicid >> 5);          /* 2 clusterids per CEC */
+}
+
+/* Mapping from cpu number to logical apicid */
+extern volatile u8 cpu_2_logical_apicid[];
+static inline int cpu_to_logical_apicid(int cpu)
+{
+	return (int)cpu_2_logical_apicid[cpu];
 }
 
 static inline int cpu_present_to_apicid(int mps_cpu)
diff -Nru a/include/asm-i386/smp.h b/include/asm-i386/smp.h
--- a/include/asm-i386/smp.h	Tue Jan 14 00:42:37 2003
+++ b/include/asm-i386/smp.h	Tue Jan 14 00:42:37 2003
@@ -76,12 +76,6 @@
 	return hweight32(cpu_callout_map);
 }
 
-/* Mapping from cpu number to logical apicid */
-extern volatile u8 cpu_2_logical_apicid[];
-static inline int cpu_to_logical_apicid(int cpu)
-{
-	return (int)cpu_2_logical_apicid[cpu];
-}
 extern void map_cpu_to_logical_apicid(void);
 extern void unmap_cpu_to_logical_apicid(int cpu);
 

