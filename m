Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263077AbSJNW3s>; Mon, 14 Oct 2002 18:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262788AbSJNW1o>; Mon, 14 Oct 2002 18:27:44 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:7112 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262410AbSJNW02>;
	Mon, 14 Oct 2002 18:26:28 -0400
Date: Mon, 14 Oct 2002 15:27:57 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Summit support for 2.5 - now with subarch! [5/5]
Message-ID: <77350000.1034634477@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a raw_phys_apicid array that maps from the mps cpu number
to the apicid - this is needed because the apicids for Summit can be
larger than 32, and thus won't fit into the bitmap. Also adds little wrappers
to map neatly between the two.

Bumps up MAX_APICS for Summit.

diff -purN -X /home/mbligh/.diff.exclude subarch-4/arch/i386/kernel/mpparse.c subarch-5/arch/i386/kernel/mpparse.c
--- subarch-4/arch/i386/kernel/mpparse.c	Mon Oct 14 11:15:27 2002
+++ subarch-5/arch/i386/kernel/mpparse.c	Mon Oct 14 11:22:29 2002
@@ -71,6 +71,7 @@ static unsigned int __initdata num_proce
 unsigned long phys_cpu_present_map;
 
 int summit_x86 = 0;
+u8 raw_phys_apicid[NR_CPUS] = { [0 ... NR_CPUS-1] = BAD_APICID };
 
 /*
  * Intel MP BIOS table parsing routines:
@@ -192,7 +193,7 @@ void __init MP_processor_info (struct mp
 	if (clustered_apic_mode) {
 		phys_cpu_present_map |= (logical_apicid&0xf) << (4*quad);
 	} else {
-		phys_cpu_present_map |= 1 << m->mpc_apicid;
+		phys_cpu_present_map |= apicid_to_cpu_present(m->mpc_apicid);
 	}
 	/*
 	 * Validate version
@@ -202,6 +203,7 @@ void __init MP_processor_info (struct mp
 		ver = 0x10;
 	}
 	apic_version[m->mpc_apicid] = ver;
+	raw_phys_apicid[num_processors - 1] = m->mpc_apicid;
 }
 
 static void __init MP_bus_info (struct mpc_config_bus *m)
diff -purN -X /home/mbligh/.diff.exclude subarch-4/arch/i386/kernel/smpboot.c subarch-5/arch/i386/kernel/smpboot.c
--- subarch-4/arch/i386/kernel/smpboot.c	Fri Oct 11 21:22:07 2002
+++ subarch-5/arch/i386/kernel/smpboot.c	Mon Oct 14 11:29:39 2002
@@ -51,6 +51,7 @@
 #include <asm/desc.h>
 #include <asm/arch_hooks.h>
 #include "smpboot_hooks.h"
+#include "mach_apic.h"
 
 /* Set if we find a B stepping CPU */
 static int __initdata smp_b_stepping;
diff -purN -X /home/mbligh/.diff.exclude subarch-4/arch/i386/mach-generic/mach_apic.h subarch-5/arch/i386/mach-generic/mach_apic.h
--- subarch-4/arch/i386/mach-generic/mach_apic.h	Mon Oct 14 11:18:22 2002
+++ subarch-5/arch/i386/mach-generic/mach_apic.h	Mon Oct 14 11:22:57 2002
@@ -30,4 +30,17 @@ static inline void clustered_apic_check(
 		(clustered_apic_mode ? "NUMA-Q" : "Flat"), nr_ioapics);
 }
 
+static inline int cpu_present_to_apicid(int mps_cpu)
+{
+	if (clustered_apic_mode)
+		return ( ((mps_cpu/4)*16) + (1<<(mps_cpu%4)) );
+	else
+		return mps_cpu;
+}
+
+static inline unsigned long apicid_to_cpu_present(int apicid)
+{
+	return (1ul << apicid);
+}
+
 #endif /* __ASM_MACH_APIC_H */
diff -purN -X /home/mbligh/.diff.exclude subarch-4/arch/i386/mach-summit/mach_apic.h subarch-5/arch/i386/mach-summit/mach_apic.h
--- subarch-4/arch/i386/mach-summit/mach_apic.h	Mon Oct 14 11:18:08 2002
+++ subarch-5/arch/i386/mach-summit/mach_apic.h	Mon Oct 14 11:24:16 2002
@@ -38,4 +38,20 @@ static inline void clustered_apic_check(
 		(x86_summit ? "Summit" : "Flat"), nr_ioapics);
 }
 
+static inline int cpu_present_to_apicid(int mps_cpu)
+{
+	if (x86_summit)
+		return (int) raw_phys_apicid[mps_cpu];
+	else
+		return mps_cpu;
+}
+
+static inline unsigned long apicid_to_phys_cpu_present(int apicid)
+{
+	if (x86_summit)
+		return (1ul << (((apicid >> 4) << 2) | (apicid & 0x3)));
+	else
+		return (1ul << apicid);
+}
+
 #endif /* __ASM_MACH_APIC_H */
diff -purN -X /home/mbligh/.diff.exclude subarch-4/include/asm-i386/mpspec.h subarch-5/include/asm-i386/mpspec.h
--- subarch-4/include/asm-i386/mpspec.h	Fri Oct 11 21:21:02 2002
+++ subarch-5/include/asm-i386/mpspec.h	Mon Oct 14 11:22:29 2002
@@ -16,11 +16,11 @@
 /*
  * a maximum of 16 APICs with the current APIC ID architecture.
  */
-#ifdef CONFIG_X86_NUMAQ
+#ifdef CONFIG_X86_NUMA
 #define MAX_APICS 256
-#else /* !CONFIG_X86_NUMAQ */
+#else /* !CONFIG_X86_NUMA */
 #define MAX_APICS 16
-#endif /* CONFIG_X86_NUMAQ */
+#endif /* CONFIG_X86_NUMA */
 
 #define MAX_MPC_ENTRY 1024
 
diff -purN -X /home/mbligh/.diff.exclude subarch-4/include/asm-i386/smp.h subarch-5/include/asm-i386/smp.h
--- subarch-4/include/asm-i386/smp.h	Mon Oct 14 10:59:14 2002
+++ subarch-5/include/asm-i386/smp.h	Mon Oct 14 11:22:29 2002
@@ -65,6 +65,7 @@ extern void zap_low_mappings (void);
  * the real APIC ID <-> CPU # mapping.
  */
 #define MAX_APICID 256
+#define BAD_APICID 0xFFu
 extern volatile int cpu_to_physical_apicid[NR_CPUS];
 extern volatile int physical_apicid_to_cpu[MAX_APICID];
 extern volatile int cpu_to_logical_apicid[NR_CPUS];
diff -purN -X /home/mbligh/.diff.exclude subarch-4/include/asm-i386/smpboot.h subarch-5/include/asm-i386/smpboot.h
--- subarch-4/include/asm-i386/smpboot.h	Fri Oct 11 21:22:19 2002
+++ subarch-5/include/asm-i386/smpboot.h	Mon Oct 14 11:22:29 2002
@@ -24,15 +24,6 @@
 #endif /* CONFIG_CLUSTERED_APIC */
 
 /*
- * How to map from the cpu_present_map
- */
-#ifdef CONFIG_CLUSTERED_APIC
- #define cpu_present_to_apicid(mps_cpu) ( ((mps_cpu/4)*16) + (1<<(mps_cpu%4)) )
-#else /* !CONFIG_CLUSTERED_APIC */
- #define cpu_present_to_apicid(apicid) (apicid)
-#endif /* CONFIG_CLUSTERED_APIC */
-
-/*
  * Mappings between logical cpu number and logical / physical apicid
  * The first four macros are trivial, but it keeps the abstraction consistent
  */

