Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266955AbTBLOMS>; Wed, 12 Feb 2003 09:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267176AbTBLOLp>; Wed, 12 Feb 2003 09:11:45 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:49280 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S267174AbTBLOJV>; Wed, 12 Feb 2003 09:09:21 -0500
Date: Wed, 12 Feb 2003 23:18:01 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCHSET] PC-9800 subarch. support for 2.5.60 (33/34) SMP
Message-ID: <20030212141801.GH1551@yuzuki.cinet.co.jp>
References: <20030212131737.GA1551@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030212131737.GA1551@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patchset to support NEC PC-9800 subarchitecture
against 2.5.60 (33/34).

SMP support.

- Osamu Tomita

diff -Nru linux-2.5.50-ac1/arch/i386/kernel/mpparse.c linux98-2.5.54/arch/i386/kernel/mpparse.c
--- linux-2.5.50-ac1/arch/i386/kernel/mpparse.c	2003-01-04 20:02:50.000000000 +0900
+++ linux98-2.5.54/arch/i386/kernel/mpparse.c	2003-01-04 20:02:53.000000000 +0900
@@ -33,6 +33,7 @@
 
 #include <mach_apic.h>
 #include <mach_mpparse.h>
+#include <bios_ebda.h>
 
 /* Have we found an MP table */
 int smp_found_config;
@@ -653,7 +654,8 @@
 		 * Read the physical hardware table.  Anything here will
 		 * override the defaults.
 		 */
-		if (!smp_read_mpc((void *)mpf->mpf_physptr)) {
+		if (!smp_read_mpc(pc98 ? phys_to_virt(mpf->mpf_physptr)
+					: (void *)mpf->mpf_physptr)) {
 			smp_found_config = 0;
 			printk(KERN_ERR "BIOS bug, MP table errors detected!...\n");
 			printk(KERN_ERR "... disabling SMP support. (tell your hw vendor)\n");
@@ -707,8 +709,23 @@
 			printk("found SMP MP-table at %08lx\n",
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
@@ -751,11 +768,12 @@
 	 * MP1.4 SPEC states to only scan first 1K of 4K EBDA.
 	 */
 
-	address = *(unsigned short *)phys_to_virt(0x40E);
-	address <<= 4;
-	smp_scan_config(address, 0x400);
-	if (smp_found_config)
-		printk(KERN_WARNING "WARNING: MP table in the EBDA can be UNSAFE, contact linux-smp@vger.kernel.org if you experience SMP problems!\n");
+	address = get_bios_ebda();
+	if (address) {
+		smp_scan_config(address, 0x400);
+		if (smp_found_config)
+			printk(KERN_WARNING "WARNING: MP table in the EBDA can be UNSAFE, contact linux-smp@vger.kernel.org if you experience SMP problems!\n");
+	}
 }
 
 
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
diff -Nru linux/arch/i386/kernel/smpboot.c linux98/arch/i386/kernel/smpboot.c
--- linux/arch/i386/kernel/smpboot.c	2003-01-09 13:04:14.000000000 +0900
+++ linux98/arch/i386/kernel/smpboot.c	2003-01-10 11:29:24.000000000 +0900
@@ -825,13 +825,27 @@
 
 	store_NMI_vector(&nmi_high, &nmi_low);
 
+#ifndef CONFIG_X86_PC9800
 	CMOS_WRITE(0xa, 0xf);
+#else
+	/* reset code is stored in 8255 on PC-9800. */
+	outb(0x0e, 0x37);	/* SHUT0 = 0 */
+#endif
 	local_flush_tlb();
 	Dprintk("1.\n");
 	*((volatile unsigned short *) TRAMPOLINE_HIGH) = start_eip >> 4;
 	Dprintk("2.\n");
 	*((volatile unsigned short *) TRAMPOLINE_LOW) = start_eip & 0xf;
 	Dprintk("3.\n");
+#ifdef CONFIG_X86_PC9800
+	/*
+	 * On PC-9800, continuation on warm reset is done by loading
+	 * %ss:%sp from 0x0000:0404 and executing 'lret', so:
+	 */
+	/* 0x3f0 is on unused interrupt vector and should be safe... */
+	*((volatile unsigned long *) phys_to_virt(0x404)) = 0x000003f0;
+	Dprintk("4.\n");
+#endif
 
 	/*
 	 * Starting actual IPI sequence...
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
