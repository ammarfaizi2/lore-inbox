Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266645AbSLWGbx>; Mon, 23 Dec 2002 01:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266649AbSLWGbx>; Mon, 23 Dec 2002 01:31:53 -0500
Received: from franka.aracnet.com ([216.99.193.44]:58002 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S266645AbSLWGbu>; Mon, 23 Dec 2002 01:31:50 -0500
Date: Sun, 22 Dec 2002 22:39:55 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2/8 Move NUMA-Q support into subarch
Message-ID: <42060000.1040625595@titus>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a shell of a NUMA-Q subarch directory, and copies
mach-default/mach_apic.h into it. I then edited the default version
to remove the NUMA-Q stuff, and the NUMA-Q version to remove the
default stuff.

diff -urpN -X /home/fletch/.diff.exclude 01-subarch/arch/i386/Makefile 11-numaq1/arch/i386/Makefile
--- 01-subarch/arch/i386/Makefile	Sun Dec 22 12:08:42 2002
+++ 11-numaq1/arch/i386/Makefile	Sun Dec 22 12:09:22 2002
@@ -53,6 +53,10 @@ mcore-y  := mach-default
 mflags-$(CONFIG_VISWS) := -Iinclude/asm-i386/mach-visws
 mcore-$(CONFIG_VISWS)  := mach-visws
 
+#NUMAQ subarch support
+mflags-$(CONFIG_X86_NUMAQ) := -Iinclude/asm-i386/mach-numaq
+mcore-$(CONFIG_X86_NUMAQ)  := mach-default
+
 #add other subarch support here
 
 #default subarch .h files
diff -urpN -X /home/fletch/.diff.exclude 01-subarch/include/asm-i386/mach-default/mach_apic.h 11-numaq1/include/asm-i386/mach-default/mach_apic.h
--- 01-subarch/include/asm-i386/mach-default/mach_apic.h	Sun Dec 22 12:08:42 2002
+++ 11-numaq1/include/asm-i386/mach-default/mach_apic.h	Sun Dec 22 12:09:22 2002
@@ -12,7 +12,7 @@ static inline unsigned long calculate_ld
 #define APIC_DFR_VALUE	(APIC_DFR_FLAT)
 
 #ifdef CONFIG_SMP
- #define TARGET_CPUS (clustered_apic_mode ? 0xf : cpu_online_map)
+ #define TARGET_CPUS (cpu_online_map)
 #else
  #define TARGET_CPUS 0x01
 #endif
@@ -27,15 +27,12 @@ static inline void summit_check(char *oe
 static inline void clustered_apic_check(void)
 {
 	printk("Enabling APIC mode:  %s.  Using %d I/O APICs\n",
-		(clustered_apic_mode ? "NUMA-Q" : "Flat"), nr_ioapics);
+					"Flat", nr_ioapics);
 }
 
 static inline int cpu_present_to_apicid(int mps_cpu)
 {
-	if (clustered_apic_mode)
-		return ( ((mps_cpu/4)*16) + (1<<(mps_cpu%4)) );
-	else
-		return mps_cpu;
+	return  mps_cpu;
 }
 
 static inline unsigned long apicid_to_cpu_present(int apicid)
diff -urpN -X /home/fletch/.diff.exclude 01-subarch/include/asm-i386/mach-numaq/mach_apic.h 11-numaq1/include/asm-i386/mach-numaq/mach_apic.h
--- 01-subarch/include/asm-i386/mach-numaq/mach_apic.h	Wed Dec 31 16:00:00 1969
+++ 11-numaq1/include/asm-i386/mach-numaq/mach_apic.h	Sun Dec 22 12:09:22 2002
@@ -0,0 +1,39 @@
+#ifndef __ASM_MACH_APIC_H
+#define __ASM_MACH_APIC_H
+
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
+#define TARGET_CPUS (0xf)
+
+#define APIC_BROADCAST_ID      0x0F
+#define check_apicid_used(bitmap, apicid) (bitmap & (1 << apicid))
+
+static inline void summit_check(char *oem, char *productid) 
+{
+}
+
+static inline void clustered_apic_check(void)
+{
+	printk("Enabling APIC mode:  %s.  Using %d I/O APICs\n",
+		"NUMA-Q", nr_ioapics);
+}
+
+static inline int cpu_present_to_apicid(int mps_cpu)
+{
+	return ( ((mps_cpu/4)*16) + (1<<(mps_cpu%4)) );
+}
+
+static inline unsigned long apicid_to_cpu_present(int apicid)
+{
+	return (1ul << apicid);
+}
+
+#endif /* __ASM_MACH_APIC_H */

