Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263281AbTLQEEK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 23:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263357AbTLQEEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 23:04:10 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:54702 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263281AbTLQEDv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 23:03:51 -0500
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM LTC
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.com>
Subject: [PATCH] 2.6.0-test11: cpu_sibling_map, the never ending story
Date: Tue, 16 Dec 2003 20:03:11 -0800
User-Agent: KMail/1.5
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_BW93/SEwz2SBY+e"
Message-Id: <200312162003.13809.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_BW93/SEwz2SBY+e
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Jun Nakajima is concerned about pulling out the non-power-of-2 code and that 
someone somewhere besides us might have cpuid APIC numbers that don't agree 
with the values in the APIC ID register.  (And is absolutely not hinting 
about new CPUs coming down the pipe.)

This patch should put the code back and use the sub-arch mechanism to only use 
APIC ID for Summit.


diff -pru 2.6.0-test11/arch/i386/kernel/cpu/intel.c 
t11/arch/i386/kernel/cpu/intel.c
--- 2.6.0-test11/arch/i386/kernel/cpu/intel.c	2003-11-26 12:43:27.000000000 
-0800
+++ t11/arch/i386/kernel/cpu/intel.c	2003-12-11 15:21:21.000000000 -0800
@@ -10,6 +10,7 @@
 #include <asm/uaccess.h>
 
 #include "cpu.h"
+#include "mach_apic.h"
 
 extern int trap_init_f00f_bug(void);
 
@@ -277,6 +278,7 @@ static void __init init_intel(struct cpu
 		extern	int phys_proc_id[NR_CPUS];
 		
 		u32 	eax, ebx, ecx, edx;
+		int 	index_lsb, index_msb, tmp;
 		int 	cpu = smp_processor_id();
 
 		cpuid(1, &eax, &ebx, &ecx, &edx);
@@ -285,6 +287,8 @@ static void __init init_intel(struct cpu
 		if (smp_num_siblings == 1) {
 			printk(KERN_INFO  "CPU: Hyper-Threading is disabled\n");
 		} else if (smp_num_siblings > 1 ) {
+			index_lsb = 0;
+			index_msb = 31;
 			/*
 			 * At this point we only support two siblings per
 			 * processor package.
@@ -295,13 +299,19 @@ static void __init init_intel(struct cpu
 				smp_num_siblings = 1;
 				goto too_many_siblings;
 			}
-			/* cpuid returns the value latched in the HW at reset,
-			 * not the APIC ID register's value.  For any box
-			 * whose BIOS changes APIC IDs, like clustered APIC
-			 * systems, we must use hard_smp_processor_id.
-			 * See Intel's IA-32 SW Dev's Manual Vol2 under CPUID.
-			 */
-			phys_proc_id[cpu] = hard_smp_processor_id() & ~(smp_num_siblings - 1);
+			tmp = smp_num_siblings;
+			while ((tmp & 1) == 0) {
+				tmp >>=1 ;
+				index_lsb++;
+			}
+			tmp = smp_num_siblings;
+			while ((tmp & 0x80000000 ) == 0) {
+				tmp <<=1 ;
+				index_msb--;
+			}
+			if (index_lsb != index_msb )
+				index_msb++;
+			phys_proc_id[cpu] = phys_pkg_id((ebx >> 24) & 0xFF, index_msb);
 
 			printk(KERN_INFO  "CPU: Physical Processor ID: %d\n",
                                phys_proc_id[cpu]);
diff -pru 2.6.0-test11/include/asm-i386/genapic.h 
t11/include/asm-i386/genapic.h
--- 2.6.0-test11/include/asm-i386/genapic.h	2003-11-26 12:44:23.000000000 
-0800
+++ t11/include/asm-i386/genapic.h	2003-12-11 14:52:24.000000000 -0800
@@ -45,6 +45,7 @@ struct genapic { 
 	void (*setup_portio_remap)(void); 
 	int (*check_phys_apicid_present)(int boot_cpu_physical_apicid);
 	void (*enable_apic_mode)(void);
+	u32 (*phys_pkg_id)(u32 cpuid_apic, int index_msb);
 
 	/* mpparse */
 	void (*mpc_oem_bus_info)(struct mpc_config_bus *, char *, 
@@ -105,6 +106,7 @@ struct genapic { 
 	APICFUNC(send_IPI_allbutself), \
 	APICFUNC(send_IPI_all), \
 	APICFUNC(enable_apic_mode), \
+	APICFUNC(phys_pkg_id), \
 	}
 
 extern struct genapic *genapic;
diff -pru 2.6.0-test11/include/asm-i386/mach-bigsmp/mach_apic.h 
t11/include/asm-i386/mach-bigsmp/mach_apic.h
--- 2.6.0-test11/include/asm-i386/mach-bigsmp/mach_apic.h	2003-11-26 
12:45:38.000000000 -0800
+++ t11/include/asm-i386/mach-bigsmp/mach_apic.h	2003-12-10 16:51:47.000000000 
-0800
@@ -173,4 +173,9 @@ static inline unsigned int cpu_mask_to_a
 	return apicid;
 }
 
+static inline u32 phys_pkg_id(u32 cpuid_apic, int index_msb)
+{
+	return cpuid_apic >> index_msb;
+}
+
 #endif /* __ASM_MACH_APIC_H */
diff -pru 2.6.0-test11/include/asm-i386/mach-default/mach_apic.h 
t11/include/asm-i386/mach-default/mach_apic.h
--- 2.6.0-test11/include/asm-i386/mach-default/mach_apic.h	2003-11-26 
12:46:07.000000000 -0800
+++ t11/include/asm-i386/mach-default/mach_apic.h	2003-12-10 
16:52:18.000000000 -0800
@@ -127,4 +127,9 @@ static inline void enable_apic_mode(void
 {
 }
 
+static inline u32 phys_pkg_id(u32 cpuid_apic, int index_msb)
+{
+	return cpuid_apic >> index_msb;
+}
+
 #endif /* __ASM_MACH_APIC_H */
diff -pru 2.6.0-test11/include/asm-i386/mach-es7000/mach_apic.h 
t11/include/asm-i386/mach-es7000/mach_apic.h
--- 2.6.0-test11/include/asm-i386/mach-es7000/mach_apic.h	2003-11-26 
12:42:51.000000000 -0800
+++ t11/include/asm-i386/mach-es7000/mach_apic.h	2003-12-10 16:52:29.000000000 
-0800
@@ -191,4 +191,9 @@ static inline unsigned int cpu_mask_to_a
 	return apicid;
 }
 
+static inline u32 phys_pkg_id(u32 cpuid_apic, int index_msb)
+{
+	return cpuid_apic >> index_msb;
+}
+
 #endif /* __ASM_MACH_APIC_H */
diff -pru 2.6.0-test11/include/asm-i386/mach-generic/mach_apic.h 
t11/include/asm-i386/mach-generic/mach_apic.h
--- 2.6.0-test11/include/asm-i386/mach-generic/mach_apic.h	2003-11-26 
12:43:35.000000000 -0800
+++ t11/include/asm-i386/mach-generic/mach_apic.h	2003-12-10 
16:52:58.000000000 -0800
@@ -27,5 +27,6 @@
 #define check_apicid_used (genapic->check_apicid_used)
 #define cpu_mask_to_apicid (genapic->cpu_mask_to_apicid)
 #define enable_apic_mode (genapic->enable_apic_mode)
+#define phys_pkg_id (genapic->phys_pkg_id)
 
 #endif /* __ASM_MACH_APIC_H */
diff -pru 2.6.0-test11/include/asm-i386/mach-numaq/mach_apic.h 
t11/include/asm-i386/mach-numaq/mach_apic.h
--- 2.6.0-test11/include/asm-i386/mach-numaq/mach_apic.h	2003-11-26 
12:43:40.000000000 -0800
+++ t11/include/asm-i386/mach-numaq/mach_apic.h	2003-12-10 16:57:54.000000000 
-0800
@@ -141,4 +141,10 @@ static inline unsigned int cpu_mask_to_a
 	return (int) 0xF;
 }
 
+/* No NUMA-Q box has a HT CPU, but it can't hurt to use the default code. */
+static inline u32 phys_pkg_id(u32 cpuid_apic, int index_msb)
+{
+	return cpuid_apic >> index_msb;
+}
+
 #endif /* __ASM_MACH_APIC_H */
diff -pru 2.6.0-test11/include/asm-i386/mach-summit/mach_apic.h 
t11/include/asm-i386/mach-summit/mach_apic.h
--- 2.6.0-test11/include/asm-i386/mach-summit/mach_apic.h	2003-11-26 
12:44:33.000000000 -0800
+++ t11/include/asm-i386/mach-summit/mach_apic.h	2003-12-10 16:55:32.000000000 
-0800
@@ -173,4 +173,15 @@ static inline unsigned int cpu_mask_to_a
 	return apicid;
 }
 
+/* cpuid returns the value latched in the HW at reset, not the APIC ID
+ * register's value.  For any box whose BIOS changes APIC IDs, like
+ * clustered APIC systems, we must use hard_smp_processor_id.
+ *
+ * See Intel's IA-32 SW Dev's Manual Vol2 under CPUID.
+ */
+static inline u32 phys_pkg_id(u32 cpuid_apic, int index_msb)
+{
+	return hard_smp_processor_id() >> index_msb;
+}
+
 #endif /* __ASM_MACH_APIC_H */
diff -pru 2.6.0-test11/include/asm-i386/mach-visws/mach_apic.h 
t11/include/asm-i386/mach-visws/mach_apic.h
--- 2.6.0-test11/include/asm-i386/mach-visws/mach_apic.h	2003-11-26 
12:42:51.000000000 -0800
+++ t11/include/asm-i386/mach-visws/mach_apic.h	2003-12-10 16:58:13.000000000 
-0800
@@ -88,4 +88,10 @@ static inline unsigned int cpu_mask_to_a
 {
 	return cpus_coerce_const(cpumask);
 }
+
+static inline u32 phys_pkg_id(u32 cpuid_apic, int index_msb)
+{
+	return cpuid_apic >> index_msb;
+}
+
 #endif /* __ASM_MACH_APIC_H */

--Boundary-00=_BW93/SEwz2SBY+e
Content-Type: text/x-diff;
  charset="us-ascii";
  name="cpu_sibling_map_2003-12-11_2.6.0-test11"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="cpu_sibling_map_2003-12-11_2.6.0-test11"

diff -pru 2.6.0-test11/arch/i386/kernel/cpu/intel.c t11/arch/i386/kernel/cpu/intel.c
--- 2.6.0-test11/arch/i386/kernel/cpu/intel.c	2003-11-26 12:43:27.000000000 -0800
+++ t11/arch/i386/kernel/cpu/intel.c	2003-12-11 15:21:21.000000000 -0800
@@ -10,6 +10,7 @@
 #include <asm/uaccess.h>
 
 #include "cpu.h"
+#include "mach_apic.h"
 
 extern int trap_init_f00f_bug(void);
 
@@ -277,6 +278,7 @@ static void __init init_intel(struct cpu
 		extern	int phys_proc_id[NR_CPUS];
 		
 		u32 	eax, ebx, ecx, edx;
+		int 	index_lsb, index_msb, tmp;
 		int 	cpu = smp_processor_id();
 
 		cpuid(1, &eax, &ebx, &ecx, &edx);
@@ -285,6 +287,8 @@ static void __init init_intel(struct cpu
 		if (smp_num_siblings == 1) {
 			printk(KERN_INFO  "CPU: Hyper-Threading is disabled\n");
 		} else if (smp_num_siblings > 1 ) {
+			index_lsb = 0;
+			index_msb = 31;
 			/*
 			 * At this point we only support two siblings per
 			 * processor package.
@@ -295,13 +299,19 @@ static void __init init_intel(struct cpu
 				smp_num_siblings = 1;
 				goto too_many_siblings;
 			}
-			/* cpuid returns the value latched in the HW at reset,
-			 * not the APIC ID register's value.  For any box
-			 * whose BIOS changes APIC IDs, like clustered APIC
-			 * systems, we must use hard_smp_processor_id.
-			 * See Intel's IA-32 SW Dev's Manual Vol2 under CPUID.
-			 */
-			phys_proc_id[cpu] = hard_smp_processor_id() & ~(smp_num_siblings - 1);
+			tmp = smp_num_siblings;
+			while ((tmp & 1) == 0) {
+				tmp >>=1 ;
+				index_lsb++;
+			}
+			tmp = smp_num_siblings;
+			while ((tmp & 0x80000000 ) == 0) {
+				tmp <<=1 ;
+				index_msb--;
+			}
+			if (index_lsb != index_msb )
+				index_msb++;
+			phys_proc_id[cpu] = phys_pkg_id((ebx >> 24) & 0xFF, index_msb);
 
 			printk(KERN_INFO  "CPU: Physical Processor ID: %d\n",
                                phys_proc_id[cpu]);
diff -pru 2.6.0-test11/include/asm-i386/genapic.h t11/include/asm-i386/genapic.h
--- 2.6.0-test11/include/asm-i386/genapic.h	2003-11-26 12:44:23.000000000 -0800
+++ t11/include/asm-i386/genapic.h	2003-12-11 14:52:24.000000000 -0800
@@ -45,6 +45,7 @@ struct genapic { 
 	void (*setup_portio_remap)(void); 
 	int (*check_phys_apicid_present)(int boot_cpu_physical_apicid);
 	void (*enable_apic_mode)(void);
+	u32 (*phys_pkg_id)(u32 cpuid_apic, int index_msb);
 
 	/* mpparse */
 	void (*mpc_oem_bus_info)(struct mpc_config_bus *, char *, 
@@ -105,6 +106,7 @@ struct genapic { 
 	APICFUNC(send_IPI_allbutself), \
 	APICFUNC(send_IPI_all), \
 	APICFUNC(enable_apic_mode), \
+	APICFUNC(phys_pkg_id), \
 	}
 
 extern struct genapic *genapic;
diff -pru 2.6.0-test11/include/asm-i386/mach-bigsmp/mach_apic.h t11/include/asm-i386/mach-bigsmp/mach_apic.h
--- 2.6.0-test11/include/asm-i386/mach-bigsmp/mach_apic.h	2003-11-26 12:45:38.000000000 -0800
+++ t11/include/asm-i386/mach-bigsmp/mach_apic.h	2003-12-10 16:51:47.000000000 -0800
@@ -173,4 +173,9 @@ static inline unsigned int cpu_mask_to_a
 	return apicid;
 }
 
+static inline u32 phys_pkg_id(u32 cpuid_apic, int index_msb)
+{
+	return cpuid_apic >> index_msb;
+}
+
 #endif /* __ASM_MACH_APIC_H */
diff -pru 2.6.0-test11/include/asm-i386/mach-default/mach_apic.h t11/include/asm-i386/mach-default/mach_apic.h
--- 2.6.0-test11/include/asm-i386/mach-default/mach_apic.h	2003-11-26 12:46:07.000000000 -0800
+++ t11/include/asm-i386/mach-default/mach_apic.h	2003-12-10 16:52:18.000000000 -0800
@@ -127,4 +127,9 @@ static inline void enable_apic_mode(void
 {
 }
 
+static inline u32 phys_pkg_id(u32 cpuid_apic, int index_msb)
+{
+	return cpuid_apic >> index_msb;
+}
+
 #endif /* __ASM_MACH_APIC_H */
diff -pru 2.6.0-test11/include/asm-i386/mach-es7000/mach_apic.h t11/include/asm-i386/mach-es7000/mach_apic.h
--- 2.6.0-test11/include/asm-i386/mach-es7000/mach_apic.h	2003-11-26 12:42:51.000000000 -0800
+++ t11/include/asm-i386/mach-es7000/mach_apic.h	2003-12-10 16:52:29.000000000 -0800
@@ -191,4 +191,9 @@ static inline unsigned int cpu_mask_to_a
 	return apicid;
 }
 
+static inline u32 phys_pkg_id(u32 cpuid_apic, int index_msb)
+{
+	return cpuid_apic >> index_msb;
+}
+
 #endif /* __ASM_MACH_APIC_H */
diff -pru 2.6.0-test11/include/asm-i386/mach-generic/mach_apic.h t11/include/asm-i386/mach-generic/mach_apic.h
--- 2.6.0-test11/include/asm-i386/mach-generic/mach_apic.h	2003-11-26 12:43:35.000000000 -0800
+++ t11/include/asm-i386/mach-generic/mach_apic.h	2003-12-10 16:52:58.000000000 -0800
@@ -27,5 +27,6 @@
 #define check_apicid_used (genapic->check_apicid_used)
 #define cpu_mask_to_apicid (genapic->cpu_mask_to_apicid)
 #define enable_apic_mode (genapic->enable_apic_mode)
+#define phys_pkg_id (genapic->phys_pkg_id)
 
 #endif /* __ASM_MACH_APIC_H */
diff -pru 2.6.0-test11/include/asm-i386/mach-numaq/mach_apic.h t11/include/asm-i386/mach-numaq/mach_apic.h
--- 2.6.0-test11/include/asm-i386/mach-numaq/mach_apic.h	2003-11-26 12:43:40.000000000 -0800
+++ t11/include/asm-i386/mach-numaq/mach_apic.h	2003-12-10 16:57:54.000000000 -0800
@@ -141,4 +141,10 @@ static inline unsigned int cpu_mask_to_a
 	return (int) 0xF;
 }
 
+/* No NUMA-Q box has a HT CPU, but it can't hurt to use the default code. */
+static inline u32 phys_pkg_id(u32 cpuid_apic, int index_msb)
+{
+	return cpuid_apic >> index_msb;
+}
+
 #endif /* __ASM_MACH_APIC_H */
diff -pru 2.6.0-test11/include/asm-i386/mach-summit/mach_apic.h t11/include/asm-i386/mach-summit/mach_apic.h
--- 2.6.0-test11/include/asm-i386/mach-summit/mach_apic.h	2003-11-26 12:44:33.000000000 -0800
+++ t11/include/asm-i386/mach-summit/mach_apic.h	2003-12-10 16:55:32.000000000 -0800
@@ -173,4 +173,15 @@ static inline unsigned int cpu_mask_to_a
 	return apicid;
 }
 
+/* cpuid returns the value latched in the HW at reset, not the APIC ID
+ * register's value.  For any box whose BIOS changes APIC IDs, like
+ * clustered APIC systems, we must use hard_smp_processor_id.
+ *
+ * See Intel's IA-32 SW Dev's Manual Vol2 under CPUID.
+ */
+static inline u32 phys_pkg_id(u32 cpuid_apic, int index_msb)
+{
+	return hard_smp_processor_id() >> index_msb;
+}
+
 #endif /* __ASM_MACH_APIC_H */
diff -pru 2.6.0-test11/include/asm-i386/mach-visws/mach_apic.h t11/include/asm-i386/mach-visws/mach_apic.h
--- 2.6.0-test11/include/asm-i386/mach-visws/mach_apic.h	2003-11-26 12:42:51.000000000 -0800
+++ t11/include/asm-i386/mach-visws/mach_apic.h	2003-12-10 16:58:13.000000000 -0800
@@ -88,4 +88,10 @@ static inline unsigned int cpu_mask_to_a
 {
 	return cpus_coerce_const(cpumask);
 }
+
+static inline u32 phys_pkg_id(u32 cpuid_apic, int index_msb)
+{
+	return cpuid_apic >> index_msb;
+}
+
 #endif /* __ASM_MACH_APIC_H */

--Boundary-00=_BW93/SEwz2SBY+e--

