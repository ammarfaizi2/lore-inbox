Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262453AbTCIEcS>; Sat, 8 Mar 2003 23:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262466AbTCIEcO>; Sat, 8 Mar 2003 23:32:14 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:51328 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S262453AbTCIEas>; Sat, 8 Mar 2003 23:30:48 -0500
Date: Sun, 9 Mar 2003 13:40:53 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] PC-9800 subarch. support for 2.5.64-ac3 (19/20) SMP
Message-ID: <20030309044053.GT1231@yuzuki.cinet.co.jp>
References: <20030309035245.GA1231@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030309035245.GA1231@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the patch to support NEC PC-9800 subarchitecture
against 2.5.64-ac3. (19/20)

SMP support for PC98.
 - Support mpc table location.
 - Handling EBDA.
 - Hnadling warm reset vector.

Regards,
Osamu tomita


diff -Nru linux-2.5.61-ac1/arch/i386/kernel/mpparse.c linux98-2.5.61-ac1/arch/i386/kernel/mpparse.c
--- linux-2.5.61-ac1/arch/i386/kernel/mpparse.c	2003-02-18 08:58:20.000000000 +0900
+++ linux98-2.5.61-ac1/arch/i386/kernel/mpparse.c	2003-02-18 15:52:44.000000000 +0900
@@ -33,6 +33,7 @@
 
 #include <mach_apic.h>
 #include <mach_mpparse.h>
+#include <bios_ebda.h>
 
 /* Have we found an MP table */
 int smp_found_config;
@@ -654,7 +655,8 @@
 		 * Read the physical hardware table.  Anything here will
 		 * override the defaults.
 		 */
-		if (!smp_read_mpc((void *)mpf->mpf_physptr)) {
+		if (!smp_read_mpc(pc98 ? phys_to_virt(mpf->mpf_physptr)
+					: (void *)mpf->mpf_physptr)) {
 			smp_found_config = 0;
 			printk(KERN_ERR "BIOS bug, MP table errors detected!...\n");
 			printk(KERN_ERR "... disabling SMP support. (tell your hw vendor)\n");
@@ -708,8 +710,23 @@
 			printk(KERN_INFO "found SMP MP-table at %08lx\n",
 						virt_to_phys(mpf));
 			reserve_bootmem(virt_to_phys(mpf), PAGE_SIZE);
-			if (mpf->mpf_physptr)
-				reserve_bootmem(mpf->mpf_physptr, PAGE_SIZE);
+			if (mpf->mpf_physptr) {
+				/*
+				 * We cannot access to MPC table to compute
+				 * table size yet, as only few megabytes from
+				 * the bottom is mapped now.
+				 * PC-9800's MPC table places on the very last
+				 * of physical memory; so that simply reserving
+				 * PAGE_SIZE from mpg->mpf_physptr yields BUG()
+				 * in reserve_bootmem.
+				 */
+				unsigned long size = PAGE_SIZE;
+				unsigned long end = max_low_pfn * PAGE_SIZE;
+				if (mpf->mpf_physptr + size > end)
+					size = end - mpf->mpf_physptr;
+				reserve_bootmem(mpf->mpf_physptr, size);
+			}
+
 			mpf_found = mpf;
 			return 1;
 		}
@@ -752,9 +769,9 @@
 	 * MP1.4 SPEC states to only scan first 1K of 4K EBDA.
 	 */
 
-	address = *(unsigned short *)phys_to_virt(0x40E);
-	address <<= 4;
-	smp_scan_config(address, 0x400);
+	address = get_bios_ebda();
+	if (address)
+		smp_scan_config(address, 0x400);
 }
 
 
diff -Nru linux-2.5.63/arch/i386/kernel/smpboot.c linux98-2.5.63/arch/i386/kernel/smpboot.c
--- linux-2.5.63/arch/i386/kernel/smpboot.c	2003-02-25 04:05:31.000000000 +0900
+++ linux98-2.5.63/arch/i386/kernel/smpboot.c	2003-02-28 13:52:18.000000000 +0900
@@ -49,10 +49,10 @@
 #include <asm/tlbflush.h>
 #include <asm/desc.h>
 #include <asm/arch_hooks.h>
-#include "smpboot_hooks.h"
 
 #include <mach_apic.h>
 #include <mach_wakecpu.h>
+#include "smpboot_hooks.h"
 
 /* Set if we find a B stepping CPU */
 static int __initdata smp_b_stepping;
@@ -823,13 +823,7 @@
 
 	store_NMI_vector(&nmi_high, &nmi_low);
 
-	CMOS_WRITE(0xa, 0xf);
-	local_flush_tlb();
-	Dprintk("1.\n");
-	*((volatile unsigned short *) TRAMPOLINE_HIGH) = start_eip >> 4;
-	Dprintk("2.\n");
-	*((volatile unsigned short *) TRAMPOLINE_LOW) = start_eip & 0xf;
-	Dprintk("3.\n");
+	smpboot_setup_warm_reset_vector(start_eip);
 
 	/*
 	 * Starting actual IPI sequence...
@@ -1044,7 +1038,7 @@
 	/*
 	 * Cleanup possible dangling ends...
 	 */
-	smpboot_setup_warm_reset_vector();
+	smpboot_restore_warm_reset_vector();
 
 	/*
 	 * Allow the user to impress friends.
diff -Nru linux/include/asm-i386/mach-default/bios_ebda.h linux98/include/asm-i386/mach-default/bios_ebda.h
--- linux/include/asm-i386/mach-default/bios_ebda.h	1970-01-01 09:00:00.000000000 +0900
+++ linux98/include/asm-i386/mach-default/bios_ebda.h	2002-12-18 22:40:38.000000000 +0900
@@ -0,0 +1,15 @@
+#ifndef _MACH_BIOS_EBDA_H
+#define _MACH_BIOS_EBDA_H
+
+/*
+ * there is a real-mode segmented pointer pointing to the
+ * 4K EBDA area at 0x40E.
+ */
+static inline unsigned int get_bios_ebda(void)
+{
+	unsigned int address = *(unsigned short *)phys_to_virt(0x40E);
+	address <<= 4;
+	return address;	/* 0 means none */
+}
+
+#endif /* _MACH_BIOS_EBDA_H */
diff -Nru linux/include/asm-i386/mach-default/smpboot_hooks.h linux98/include/asm-i386/mach-default/smpboot_hooks.h
--- linux/include/asm-i386/mach-default/smpboot_hooks.h	2003-02-25 04:05:15.000000000 +0900
+++ linux98/include/asm-i386/mach-default/smpboot_hooks.h	2003-02-28 13:56:55.000000000 +0900
@@ -6,7 +6,18 @@
 	io_apic_irqs = 0;
 }
 
-static inline void smpboot_setup_warm_reset_vector(void)
+static inline void smpboot_setup_warm_reset_vector(unsigned long start_eip)
+{
+	CMOS_WRITE(0xa, 0xf);
+	local_flush_tlb();
+	Dprintk("1.\n");
+	*((volatile unsigned short *) TRAMPOLINE_HIGH) = start_eip >> 4;
+	Dprintk("2.\n");
+	*((volatile unsigned short *) TRAMPOLINE_LOW) = start_eip & 0xf;
+	Dprintk("3.\n");
+}
+
+static inline void smpboot_restore_warm_reset_vector(void)
 {
 	/*
 	 * Install writable page 0 entry to set BIOS data area.
diff -Nru linux/include/asm-i386/mach-pc9800/bios_ebda.h linux98/include/asm-i386/mach-pc9800/bios_ebda.h
--- linux/include/asm-i386/mach-pc9800/bios_ebda.h	1970-01-01 09:00:00.000000000 +0900
+++ linux98/include/asm-i386/mach-pc9800/bios_ebda.h	2002-12-18 22:49:59.000000000 +0900
@@ -0,0 +1,14 @@
+#ifndef _MACH_BIOS_EBDA_H
+#define _MACH_BIOS_EBDA_H
+
+/*
+ * PC-9800 has no EBDA.
+ * Its BIOS uses 0x40E for other purpose,
+ * Not pointer to 4K EBDA area.
+ */
+static inline unsigned int get_bios_ebda(void)
+{
+	return 0;	/* 0 means none */
+}
+
+#endif /* _MACH_BIOS_EBDA_H */
diff -Nru linux/include/asm-i386/mach-pc9800/mach_wakecpu.h linux98/include/asm-i386/mach-pc9800/mach_wakecpu.h
--- linux/include/asm-i386/mach-pc9800/mach_wakecpu.h	1970-01-01 09:00:00.000000000 +0900
+++ linux98/include/asm-i386/mach-pc9800/mach_wakecpu.h	2003-01-10 11:40:16.000000000 +0900
@@ -0,0 +1,45 @@
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
+/*
+ * On PC-9800, continuation on warm reset is done by loading
+ * %ss:%sp from 0x0000:0404 and executing 'lret', so:
+ */
+#define TRAMPOLINE_LOW phys_to_virt(0x4fa)
+#define TRAMPOLINE_HIGH phys_to_virt(0x4fc)
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
diff -Nru linux/include/asm-i386/mach-pc9800/smpboot_hooks.h linux98/include/asm-i386/mach-pc9800/smpboot_hooks.h
--- linux/include/asm-i386/mach-pc9800/smpboot_hooks.h	1970-01-01 09:00:00.000000000 +0900
+++ linux98/include/asm-i386/mach-pc9800/smpboot_hooks.h	2003-02-28 13:53:53.000000000 +0900
@@ -0,0 +1,52 @@
+/* two abstractions specific to kernel/smpboot.c, mainly to cater to visws
+ * which needs to alter them. */
+
+static inline void smpboot_clear_io_apic_irqs(void)
+{
+	io_apic_irqs = 0;
+}
+
+static inline void smpboot_setup_warm_reset_vector(unsigned long start_eip)
+{
+	/* reset code is stored in 8255 on PC-9800. */
+	outb(0x0e, 0x37);	/* SHUT0 = 0 */
+	local_flush_tlb();
+	Dprintk("1.\n");
+	*((volatile unsigned short *) TRAMPOLINE_HIGH) = start_eip >> 4;
+	Dprintk("2.\n");
+	*((volatile unsigned short *) TRAMPOLINE_LOW) = start_eip & 0xf;
+	Dprintk("3.\n");
+	/*
+	 * On PC-9800, continuation on warm reset is done by loading
+	 * %ss:%sp from 0x0000:0404 and executing 'lret', so:
+	 */
+	/* 0x3f0 is on unused interrupt vector and should be safe... */
+	*((volatile unsigned long *) phys_to_virt(0x404)) = 0x000003f0;
+	Dprintk("4.\n");
+}
+
+static inline void smpboot_restore_warm_reset_vector(void)
+{
+	/*
+	 * Install writable page 0 entry to set BIOS data area.
+	 */
+	local_flush_tlb();
+
+	/*
+	 * Paranoid:  Set warm reset code and vector here back
+	 * to default values.
+	 */
+	outb(0x0f, 0x37);	/* SHUT0 = 1 */
+
+	*((volatile long *) phys_to_virt(0x404)) = 0;
+}
+
+static inline void smpboot_setup_io_apic(void)
+{
+	/*
+	 * Here we can be sure that there is an IO-APIC in the system. Let's
+	 * go and set it up:
+	 */
+	if (!skip_ioapic_setup && nr_ioapics)
+		setup_IO_APIC();
+}
diff -Nru linux/include/asm-i386/mach-visws/smpboot_hooks.h linux98/include/asm-i386/mach-visws/smpboot_hooks.h
--- linux/include/asm-i386/mach-visws/smpboot_hooks.h	2003-02-25 04:05:10.000000000 +0900
+++ linux98/include/asm-i386/mach-visws/smpboot_hooks.h	2003-02-28 13:57:13.000000000 +0900
@@ -1,10 +1,21 @@
+static inline void smpboot_setup_warm_reset_vector(unsigned long start_eip)
+{
+	CMOS_WRITE(0xa, 0xf);
+	local_flush_tlb();
+	Dprintk("1.\n");
+	*((volatile unsigned short *) TRAMPOLINE_HIGH) = start_eip >> 4;
+	Dprintk("2.\n");
+	*((volatile unsigned short *) TRAMPOLINE_LOW) = start_eip & 0xf;
+	Dprintk("3.\n");
+}
+
 /* for visws do nothing for any of these */
 
 static inline void smpboot_clear_io_apic_irqs(void)
 {
 }
 
-static inline void smpboot_setup_warm_reset_vector(void)
+static inline void smpboot_restore_warm_reset_vector(void)
 {
 }
 
