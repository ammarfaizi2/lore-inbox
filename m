Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267489AbTAGUdP>; Tue, 7 Jan 2003 15:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267490AbTAGUcu>; Tue, 7 Jan 2003 15:32:50 -0500
Received: from franka.aracnet.com ([216.99.193.44]:12749 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267489AbTAGUbJ>; Tue, 7 Jan 2003 15:31:09 -0500
Date: Tue, 07 Jan 2003 12:31:24 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] (6/7) remove clustered_apic_mode from smpboot.c
Message-ID: <601690000.1041971483@titus>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This removes clustered_apic_mode from smpboot.c into subarch,
creating a headerfile "mach_wakecpu" for all the cpu wakeup stuff.
This is pretty much the last of clustered_apic_mode ... ;-)

diff -urpN -X /home/fletch/.diff.exclude 05-cleanup_cpu_apicid/arch/i386/kernel/smpboot.c 06-smpboot_cam/arch/i386/kernel/smpboot.c
--- 05-cleanup_cpu_apicid/arch/i386/kernel/smpboot.c	Tue Jan  7 09:27:26 2003
+++ 06-smpboot_cam/arch/i386/kernel/smpboot.c	Tue Jan  7 10:32:41 2003
@@ -53,6 +53,7 @@
 #include "smpboot_hooks.h"

 #include <mach_apic.h>
+#include <mach_wakecpu.h>

 /* Set if we find a B stepping CPU */
 static int __initdata smp_b_stepping;
@@ -348,8 +349,7 @@ void __init smp_callin(void)
 	 * our local APIC.  We have to wait for the IPI or we'll
 	 * lock up on an APIC access.
 	 */
-	if (!clustered_apic_mode)
-		while (!atomic_read(&init_deasserted));
+	wait_for_init_deassert(&init_deasserted);

 	/*
 	 * (This works even if the APIC is not enabled.)
@@ -398,12 +398,7 @@ void __init smp_callin(void)
 	 */

 	Dprintk("CALLIN, before setup_local_APIC().\n");
-	/*
-	 * Because we use NMIs rather than the INIT-STARTUP sequence to
-	 * bootstrap the CPUs, the APIC may be in a weird state. Kick it.
-	 */
-	if (clustered_apic_mode)
-		clear_local_APIC();
+	smp_callin_clear_local_apic();
 	setup_local_APIC();
 	map_cpu_to_logical_apicid();

@@ -555,7 +550,7 @@ void unmap_cpu_to_logical_apicid(int cpu
 }

 #if APIC_DEBUG
-static inline void inquire_remote_apic(int apicid)
+static inline void __inquire_remote_apic(int apicid)
 {
 	int i, regs[] = { APIC_ID >> 4, APIC_LVR >> 4, APIC_SPIV >> 4 };
 	char *names[] = { "ID", "VERSION", "SPIV" };
@@ -650,6 +645,15 @@ wakeup_secondary_cpu(int phys_apicid, un
 	unsigned long send_status = 0, accept_status = 0;
 	int maxlvt, timeout, num_starts, j;

+	/*
+	 * Be paranoid about clearing APIC errors.
+	 */
+	if (APIC_INTEGRATED(apic_version[phys_apicid])) {
+		apic_read_around(APIC_SPIV);
+		apic_write(APIC_ESR, 0);
+		apic_read(APIC_ESR);
+	}
+
 	Dprintk("Asserting INIT.\n");

 	/*
@@ -819,11 +823,7 @@ static int __init do_boot_cpu(int apicid

 	Dprintk("Setting warm reset code and vector.\n");

-	if (clustered_apic_mode) {
-		/* stash the current NMI vector, so we can put things back */
-		nmi_high = *((volatile unsigned short *) TRAMPOLINE_HIGH);
-		nmi_low = *((volatile unsigned short *) TRAMPOLINE_LOW);
-	}
+	store_NMI_vector(&nmi_high, &nmi_low);

 	CMOS_WRITE(0xa, 0xf);
 	local_flush_tlb();
@@ -834,15 +834,6 @@ static int __init do_boot_cpu(int apicid
 	Dprintk("3.\n");

 	/*
-	 * Be paranoid about clearing APIC errors.
-	 */
-	if (!clustered_apic_mode && APIC_INTEGRATED(apic_version[apicid])) {
-		apic_read_around(APIC_SPIV);
-		apic_write(APIC_ESR, 0);
-		apic_read(APIC_ESR);
-	}
-
-	/*
 	 * Starting actual IPI sequence...
 	 */
 	boot_error = wakeup_secondary_cpu(apicid, start_eip);
@@ -879,10 +870,7 @@ static int __init do_boot_cpu(int apicid
 			else
 				/* trampoline code not run */
 				printk("Not responding.\n");
-#if APIC_DEBUG
-			if (!clustered_apic_mode)
-				inquire_remote_apic(apicid);
-#endif
+			inquire_remote_apic(apicid);
 		}
 	}
 	if (boot_error) {
@@ -896,11 +884,6 @@ static int __init do_boot_cpu(int apicid
 	/* mark "stuck" area as not stuck */
 	*((volatile unsigned long *)phys_to_virt(8192)) = 0;

-	if(clustered_apic_mode) {
-		printk("Restoring NMI vector\n");
-		*((volatile unsigned short *) TRAMPOLINE_HIGH) = nmi_high;
-		*((volatile unsigned short *) TRAMPOLINE_LOW) = nmi_low;
-	}
 	return boot_error;
 }

diff -urpN -X /home/fletch/.diff.exclude 05-cleanup_cpu_apicid/include/asm-i386/mach-default/mach_apic.h 06-smpboot_cam/include/asm-i386/mach-default/mach_apic.h
--- 05-cleanup_cpu_apicid/include/asm-i386/mach-default/mach_apic.h	Tue Jan  7 09:26:53 2003
+++ 06-smpboot_cam/include/asm-i386/mach-default/mach_apic.h	Tue Jan  7 09:30:08 2003
@@ -78,8 +78,6 @@ static inline int mpc_apic_id(struct mpc
 	return (m->mpc_apicid);
 }

-#define WAKE_SECONDARY_VIA_INIT
-
 static inline void setup_portio_remap(void)
 {
 }
diff -urpN -X /home/fletch/.diff.exclude 05-cleanup_cpu_apicid/include/asm-i386/mach-default/mach_wakecpu.h 06-smpboot_cam/include/asm-i386/mach-default/mach_wakecpu.h
--- 05-cleanup_cpu_apicid/include/asm-i386/mach-default/mach_wakecpu.h	Wed Dec 31 16:00:00 1969
+++ 06-smpboot_cam/include/asm-i386/mach-default/mach_wakecpu.h	Tue Jan  7 10:32:41 2003
@@ -0,0 +1,41 @@
+#ifndef __ASM_MACH_WAKECPU_H
+#define __ASM_MACH_WAKECPU_H
+
+/*
+ * This file copes with machines that wakeup secondary CPUs by the
+ * INIT, INIT, STARTUP sequence.
+ */
+
+#define WAKE_SECONDARY_VIA_INIT
+
+#define TRAMPOLINE_LOW phys_to_virt(0x467)
+#define TRAMPOLINE_HIGH phys_to_virt(0x469)
+
+#define boot_cpu_apicid boot_cpu_physical_apicid
+
+static inline void wait_for_init_deassert(atomic_t *deassert)
+{
+	while (!atomic_read(deassert));
+	return;
+}
+
+/* Nothing to do for most platforms, since cleared by the INIT cycle */
+static inline void smp_callin_clear_local_apic(void)
+{
+}
+
+static inline void store_NMI_vector(unsigned short *high, unsigned short *low)
+{
+}
+
+static inline void restore_NMI_vector(unsigned short *high, unsigned short *low)
+{
+}
+
+#if APIC_DEBUG
+ #define inquire_remote_apic(apicid) __inquire_remote_apic(apicid)
+#else
+ #define inquire_remote_apic(apicid) {}
+#endif
+
+#endif /* __ASM_MACH_WAKECPU_H */
diff -urpN -X /home/fletch/.diff.exclude 05-cleanup_cpu_apicid/include/asm-i386/mach-numaq/mach_apic.h 06-smpboot_cam/include/asm-i386/mach-numaq/mach_apic.h
--- 05-cleanup_cpu_apicid/include/asm-i386/mach-numaq/mach_apic.h	Tue Jan  7 09:26:53 2003
+++ 06-smpboot_cam/include/asm-i386/mach-numaq/mach_apic.h	Tue Jan  7 09:30:08 2003
@@ -73,8 +73,6 @@ static inline int mpc_apic_id(struct mpc
 	return logical_apicid;
 }

-#define WAKE_SECONDARY_VIA_NMI
-
 static inline void setup_portio_remap(void)
 {
 	if (numnodes <= 1)
diff -urpN -X /home/fletch/.diff.exclude 05-cleanup_cpu_apicid/include/asm-i386/mach-numaq/mach_wakecpu.h 06-smpboot_cam/include/asm-i386/mach-numaq/mach_wakecpu.h
--- 05-cleanup_cpu_apicid/include/asm-i386/mach-numaq/mach_wakecpu.h	Wed Dec 31 16:00:00 1969
+++ 06-smpboot_cam/include/asm-i386/mach-numaq/mach_wakecpu.h	Tue Jan  7 11:10:20 2003
@@ -0,0 +1,43 @@
+#ifndef __ASM_MACH_WAKECPU_H
+#define __ASM_MACH_WAKECPU_H
+
+/* This file copes with machines that wakeup secondary CPUs by NMIs */
+
+#define WAKE_SECONDARY_VIA_NMI
+
+#define TRAMPOLINE_LOW phys_to_virt(0x8)
+#define TRAMPOLINE_HIGH phys_to_virt(0xa)
+
+#define boot_cpu_apicid boot_cpu_logical_apicid
+
+/* We don't do anything here because we use NMI's to boot instead */
+static inline void wait_for_init_deassert(atomic_t *deassert)
+{
+}
+
+/*
+ * Because we use NMIs rather than the INIT-STARTUP sequence to
+ * bootstrap the CPUs, the APIC may be in a weird state. Kick it.
+ */
+static inline void smp_callin_clear_local_apic(void)
+{
+	clear_local_APIC();
+}
+
+static inline void store_NMI_vector(unsigned short *high, unsigned short *low)
+{
+	printk("Storing NMI vector\n");
+	*high = *((volatile unsigned short *) TRAMPOLINE_HIGH);
+	*low = *((volatile unsigned short *) TRAMPOLINE_LOW);
+}
+
+static inline void restore_NMI_vector(unsigned short *high, unsigned short *low)
+{
+	printk("Restoring NMI vector\n");
+	*((volatile unsigned short *) TRAMPOLINE_HIGH) = *high;
+	*((volatile unsigned short *) TRAMPOLINE_LOW) = *low;
+}
+
+#define inquire_remote_apic(apicid) {}
+
+#endif /* __ASM_MACH_WAKECPU_H */
diff -urpN -X /home/fletch/.diff.exclude 05-cleanup_cpu_apicid/include/asm-i386/mach-summit/mach_apic.h 06-smpboot_cam/include/asm-i386/mach-summit/mach_apic.h
--- 05-cleanup_cpu_apicid/include/asm-i386/mach-summit/mach_apic.h	Tue Jan  7 09:26:53 2003
+++ 06-smpboot_cam/include/asm-i386/mach-summit/mach_apic.h	Tue Jan  7 09:30:08 2003
@@ -59,8 +59,6 @@ static inline unsigned long apicid_to_ph
 		return (1ul << apicid);
 }

-#define WAKE_SECONDARY_VIA_INIT
-
 static inline void setup_portio_remap(void)
 {
 }
diff -urpN -X /home/fletch/.diff.exclude 05-cleanup_cpu_apicid/include/asm-i386/smpboot.h 06-smpboot_cam/include/asm-i386/smpboot.h
--- 05-cleanup_cpu_apicid/include/asm-i386/smpboot.h	Tue Jan  7 09:29:11 2003
+++ 06-smpboot_cam/include/asm-i386/smpboot.h	Tue Jan  7 09:30:49 2003
@@ -9,19 +9,4 @@
  #endif /* CONFIG_CLUSTERED_APIC */
 #endif

-#ifdef CONFIG_CLUSTERED_APIC
- #define TRAMPOLINE_LOW phys_to_virt(0x8)
- #define TRAMPOLINE_HIGH phys_to_virt(0xa)
-#else /* !CONFIG_CLUSTERED_APIC */
- #define TRAMPOLINE_LOW phys_to_virt(0x467)
- #define TRAMPOLINE_HIGH phys_to_virt(0x469)
-#endif /* CONFIG_CLUSTERED_APIC */
-
-#ifdef CONFIG_CLUSTERED_APIC
- #define boot_cpu_apicid boot_cpu_logical_apicid
-#else /* !CONFIG_CLUSTERED_APIC */
- #define boot_cpu_apicid boot_cpu_physical_apicid
-#endif /* CONFIG_CLUSTERED_APIC */
-
-
 #endif

