Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262979AbSJNW23>; Mon, 14 Oct 2002 18:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262824AbSJNW14>; Mon, 14 Oct 2002 18:27:56 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:65529 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262407AbSJNW00>; Mon, 14 Oct 2002 18:26:26 -0400
Date: Mon, 14 Oct 2002 15:27:42 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Summit support for 2.5 - now with subarch! [2/5]
Message-ID: <77120000.1034634462@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This puts the DFR (desination format register) value into a #define, and
calculates the LDR (logical desitination register) correctly dependant
on platform. Similarly for TARGET_CPUS.

diff -urpN -X /home/fletch/.diff.exclude subarch-1/arch/i386/kernel/apic.c subarch-2/arch/i386/kernel/apic.c
--- subarch-1/arch/i386/kernel/apic.c	Sun Oct 13 20:16:03 2002
+++ subarch-2/arch/i386/kernel/apic.c	Sun Oct 13 20:22:18 2002
@@ -329,15 +329,13 @@ void __init setup_local_APIC (void)
 		 * Put the APIC into flat delivery mode.
 		 * Must be "all ones" explicitly for 82489DX.
 		 */
-		apic_write_around(APIC_DFR, 0xffffffff);
+		apic_write_around(APIC_DFR, APIC_DFR_VALUE);
 
 		/*
 		 * Set up the logical destination ID.
 		 */
 		value = apic_read(APIC_LDR);
-		value &= ~APIC_LDR_MASK;
-		value |= (1<<(smp_processor_id()+24));
-		apic_write_around(APIC_LDR, value);
+		apic_write_around(APIC_LDR, calculate_ldr(value));
 	}
 
 	/*
diff -urpN -X /home/fletch/.diff.exclude subarch-1/arch/i386/mach-generic/mach_apic.h subarch-2/arch/i386/mach-generic/mach_apic.h
--- subarch-1/arch/i386/mach-generic/mach_apic.h	Sun Oct 13 20:16:21 2002
+++ subarch-2/arch/i386/mach-generic/mach_apic.h	Sun Oct 13 20:22:18 2002
@@ -1,4 +1,20 @@
 #ifndef __ASM_MACH_APIC_H
 #define __ASM_MACH_APIC_H
 
+static inline unsigned long calculate_ldr(unsigned long old)
+{
+	unsigned long id;
+
+	id = 1UL << smp_processor_id();
+	return ((old & ~APIC_LDR_MASK) | SET_APIC_LOGICAL_ID(id));
+}
+
+#define APIC_DFR_VALUE	(APIC_DFR_FLAT)
+
+#ifdef CONFIG_SMP
+ #define TARGET_CPUS (clustered_apic_mode ? 0xf : cpu_online_map)
+#else
+ #define TARGET_CPUS 0x01
+#endif
+
 #endif /* __ASM_MACH_APIC_H */
diff -urpN -X /home/fletch/.diff.exclude subarch-1/arch/i386/mach-summit/mach_apic.h subarch-2/arch/i386/mach-summit/mach_apic.h
--- subarch-1/arch/i386/mach-summit/mach_apic.h	Sun Oct 13 20:16:52 2002
+++ subarch-2/arch/i386/mach-summit/mach_apic.h	Sun Oct 13 21:43:23 2002
@@ -1,4 +1,26 @@
 #ifndef __ASM_MACH_APIC_H
 #define __ASM_MACH_APIC_H
 
+extern int x86_summit;
+
+#define XAPIC_DEST_CPUS_MASK    0x0Fu
+#define XAPIC_DEST_CLUSTER_MASK 0xF0u
+
+#define xapic_phys_to_log_apicid(phys_apic) ( (1ul << ((phys_apic) & 0x3)) |\
+		((phys_apic) & XAPIC_DEST_CLUSTER_MASK) )
+
+static inline unsigned long calculate_ldr(unsigned long old)
+{
+	unsigned long id;
+
+	if (x86_summit)
+		id = xapic_phys_to_log_apicid(hard_smp_processor_id());
+	else
+		id = 1UL << smp_processor_id();
+	return ((old & ~APIC_LDR_MASK) | SET_APIC_LOGICAL_ID(id));
+}
+
+#define APIC_DFR_VALUE	(x86_summit ? APIC_DFR_CLUSTER : APIC_DFR_FLAT)
+#define TARGET_CPUS	(x86_summit ? XAPIC_DEST_CPUS_MASK : cpu_online_map)
+
 #endif /* __ASM_MACH_APIC_H */
diff -urpN -X /home/fletch/.diff.exclude subarch-1/include/asm-i386/apicdef.h subarch-2/include/asm-i386/apicdef.h
--- subarch-1/include/asm-i386/apicdef.h	Fri Oct 11 21:22:09 2002
+++ subarch-2/include/asm-i386/apicdef.h	Sun Oct 13 20:22:18 2002
@@ -32,6 +32,8 @@
 #define			SET_APIC_LOGICAL_ID(x)	(((x)<<24))
 #define			APIC_ALL_CPUS		0xFF
 #define		APIC_DFR	0xE0
+#define			APIC_DFR_CLUSTER		0x0FFFFFFFul
+#define			APIC_DFR_FLAT			0xFFFFFFFFul
 #define		APIC_SPIV	0xF0
 #define			APIC_SPIV_FOCUS_DISABLED	(1<<9)
 #define			APIC_SPIV_APIC_ENABLED		(1<<8)
diff -urpN -X /home/fletch/.diff.exclude subarch-1/include/asm-i386/smp.h subarch-2/include/asm-i386/smp.h
--- subarch-1/include/asm-i386/smp.h	Fri Oct 11 21:22:09 2002
+++ subarch-2/include/asm-i386/smp.h	Sun Oct 13 20:22:18 2002
@@ -21,17 +21,10 @@
 #endif
 #endif
 
-#ifdef CONFIG_SMP
-# ifdef CONFIG_CLUSTERED_APIC
-#  define TARGET_CPUS 0xf     /* all CPUs in *THIS* quad */
-#  define INT_DELIVERY_MODE 0     /* physical delivery on LOCAL quad */
-# else
-#  define TARGET_CPUS cpu_online_map
-#  define INT_DELIVERY_MODE 1     /* logical delivery broadcast to all procs */
-# endif
+#ifdef CONFIG_CLUSTERED_APIC
+ #define INT_DELIVERY_MODE 0     /* physical delivery on LOCAL quad */
 #else
-# define INT_DELIVERY_MODE 1     /* logical delivery */
-# define TARGET_CPUS 0x01
+ #define INT_DELIVERY_MODE 1     /* logical delivery broadcast to all procs */
 #endif
 
 #ifndef clustered_apic_mode

