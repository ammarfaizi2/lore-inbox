Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267627AbTAGUkL>; Tue, 7 Jan 2003 15:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267495AbTAGUbu>; Tue, 7 Jan 2003 15:31:50 -0500
Received: from franka.aracnet.com ([216.99.193.44]:25549 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267493AbTAGUbQ>; Tue, 7 Jan 2003 15:31:16 -0500
Date: Tue, 07 Jan 2003 12:24:52 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] (4/7) move one more to subarch, general tidy up
Message-ID: <597900000.1041971092@titus>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Moves check_phys_apicid_present() into subarch, and cleans up a
couple of stupid errors, and some bracketing issues in the macros.

diff -urpN -X /home/fletch/.diff.exclude 03-boot_error/arch/i386/kernel/smpboot.c 04-more_numaq1/arch/i386/kernel/smpboot.c
--- 03-boot_error/arch/i386/kernel/smpboot.c	Tue Jan  7 09:25:53 2003
+++ 04-more_numaq1/arch/i386/kernel/smpboot.c	Tue Jan  7 09:26:53 2003
@@ -821,7 +821,7 @@ static int __init do_boot_cpu(int apicid
 	unsigned long boot_error;
 	int timeout, cpu;
 	unsigned long start_eip;
-	unsigned short nmi_high, nmi_low;
+	unsigned short nmi_high = 0, nmi_low = 0;

 	cpu = ++cpucount;
 	/*
@@ -1052,10 +1052,9 @@ static void __init smp_boot_cpus(unsigne
 	 * CPU too, but we do it for the sake of robustness anyway.
 	 * Makes no sense to do this check in clustered apic mode, so skip it
 	 */
-	if (!clustered_apic_mode &&
-	    !test_bit(boot_cpu_physical_apicid, &phys_cpu_present_map)) {
+	if (!check_phys_apicid_present(boot_cpu_physical_apicid)) {
 		printk("weird, boot CPU (#%d) not listed by the BIOS.\n",
-							boot_cpu_physical_apicid);
+				boot_cpu_physical_apicid);
 		phys_cpu_present_map |= (1 << hard_smp_processor_id());
 	}

diff -urpN -X /home/fletch/.diff.exclude 03-boot_error/include/asm-i386/mach-default/mach_apic.h 04-more_numaq1/include/asm-i386/mach-default/mach_apic.h
--- 03-boot_error/include/asm-i386/mach-default/mach_apic.h	Tue Jan  7 09:24:35 2003
+++ 04-more_numaq1/include/asm-i386/mach-default/mach_apic.h	Tue Jan  7 09:26:53 2003
@@ -84,4 +84,9 @@ static inline void setup_portio_remap(vo
 {
 }

+static inline int check_phys_apicid_present(int boot_cpu_physical_apicid)
+{
+	return test_bit(boot_cpu_physical_apicid, &phys_cpu_present_map);
+}
+
 #endif /* __ASM_MACH_APIC_H */
diff -urpN -X /home/fletch/.diff.exclude 03-boot_error/include/asm-i386/mach-numaq/mach_apic.h 04-more_numaq1/include/asm-i386/mach-numaq/mach_apic.h
--- 03-boot_error/include/asm-i386/mach-numaq/mach_apic.h	Tue Jan  7 09:24:35 2003
+++ 04-more_numaq1/include/asm-i386/mach-numaq/mach_apic.h	Tue Jan  7 09:26:53 2003
@@ -1,14 +1,14 @@
 #ifndef __ASM_MACH_APIC_H
 #define __ASM_MACH_APIC_H

-#define APIC_DFR_VALUE	(APIC_DFR_FLAT)
+#define APIC_DFR_VALUE	(APIC_DFR_CLUSTER)

 #define TARGET_CPUS (0xf)

 #define no_balance_irq (1)

 #define APIC_BROADCAST_ID      0x0F
-#define check_apicid_used(bitmap, apicid) (bitmap & (1 << apicid))
+#define check_apicid_used(bitmap, apicid) ((bitmap) & (1 << (apicid)))

 static inline int apic_id_registered(void)
 {
@@ -26,6 +26,10 @@ static inline void clustered_apic_check(
 		"NUMA-Q", nr_ioapics);
 }

+/*
+ * Skip adding the timer int on secondary nodes, which causes
+ * a small but painful rift in the time-space continuum.
+ */
 static inline int multi_timer_check(int apic, int irq)
 {
 	return (apic != 0 && irq == 0);
@@ -80,6 +84,11 @@ static inline void setup_portio_remap(vo
 	xquad_portio = ioremap (XQUAD_PORTIO_BASE, numnodes*XQUAD_PORTIO_QUAD);
 	printk("xquad_portio vaddr 0x%08lx, len %08lx\n",
 		(u_long) xquad_portio, (u_long) numnodes*XQUAD_PORTIO_QUAD);
+}
+
+static inline int check_phys_apicid_present(int boot_cpu_physical_apicid)
+{
+	return (1);
 }

 #endif /* __ASM_MACH_APIC_H */
diff -urpN -X /home/fletch/.diff.exclude 03-boot_error/include/asm-i386/mach-summit/mach_apic.h 04-more_numaq1/include/asm-i386/mach-summit/mach_apic.h
--- 03-boot_error/include/asm-i386/mach-summit/mach_apic.h	Tue Jan  7 09:24:35 2003
+++ 04-more_numaq1/include/asm-i386/mach-summit/mach_apic.h	Tue Jan  7 09:26:53 2003
@@ -65,4 +65,9 @@ static inline void setup_portio_remap(vo
 {
 }

+static inline int check_phys_apicid_present(int boot_cpu_physical_apicid)
+{
+	return (1);
+}
+
 #endif /* __ASM_MACH_APIC_H */
diff -urpN -X /home/fletch/.diff.exclude 03-boot_error/include/asm-i386/smp.h 04-more_numaq1/include/asm-i386/smp.h
--- 03-boot_error/include/asm-i386/smp.h	Thu Jan  2 22:05:15 2003
+++ 04-more_numaq1/include/asm-i386/smp.h	Tue Jan  7 09:26:53 2003
@@ -22,7 +22,7 @@
 #endif
 #endif

-#ifdef CONFIG_CLUSTERED_APIC
+#ifdef CONFIG_X86_NUMAQ
  #define INT_DELIVERY_MODE 0     /* physical delivery on LOCAL quad */
 #else
  #define INT_DELIVERY_MODE 1     /* logical delivery broadcast to all procs */

