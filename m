Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316496AbSEUDbM>; Mon, 20 May 2002 23:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316497AbSEUDbL>; Mon, 20 May 2002 23:31:11 -0400
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:60082 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S316496AbSEUDbI>; Mon, 20 May 2002 23:31:08 -0400
Message-ID: <3CE9BE9E.9030006@didntduck.org>
Date: Mon, 20 May 2002 23:27:26 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] remaining cpu_has cleanups
Content-Type: multipart/mixed;
 boundary="------------090106090909020500040405"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090106090909020500040405
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch cleans up the remaining direct tests against x86_capability. 
      It moves the cpu_has_* macros to the more appropriate 
cpufeature.h.  It also introduces the cpu_has() macro to test features 
for individual cpus.

-- 

						Brian Gerst

--------------090106090909020500040405
Content-Type: text/plain;
 name="cpu_has-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpu_has-1"

diff -urN linux-bk/arch/i386/kernel/bluesmoke.c linux/arch/i386/kernel/bluesmoke.c
--- linux-bk/arch/i386/kernel/bluesmoke.c	Wed May 15 10:27:23 2002
+++ linux/arch/i386/kernel/bluesmoke.c	Mon May 20 23:03:56 2002
@@ -68,11 +68,11 @@
 	unsigned int cpu = smp_processor_id();
 
 	/* Thermal monitoring */
-	if (!test_bit(X86_FEATURE_ACPI, c->x86_capability))
+	if (!cpu_has(c, X86_FEATURE_ACPI))
 		return;	/* -ENODEV */
 
 	/* Clock modulation */
-	if (!test_bit(X86_FEATURE_ACC, c->x86_capability))
+	if (!cpu_has(c, X86_FEATURE_ACC))
 		return;	/* -ENODEV */
 
 	rdmsr(MSR_IA32_MISC_ENABLE, l, h);
@@ -274,7 +274,7 @@
 	 *	Check for MCE support
 	 */
 
-	if( !test_bit(X86_FEATURE_MCE, c->x86_capability) )
+	if( !cpu_has(c, X86_FEATURE_MCE) )
 		return;	
 
 	/*
@@ -304,7 +304,7 @@
 	 *	Check for PPro style MCA
 	 */
  		
-	if( !test_bit(X86_FEATURE_MCA, c->x86_capability) )
+	if( !cpu_has(c, X86_FEATURE_MCA) )
 		return;
 
 	/* Ok machine check is available */
diff -urN linux-bk/arch/i386/kernel/microcode.c linux/arch/i386/kernel/microcode.c
--- linux-bk/arch/i386/kernel/microcode.c	Wed May 15 10:27:25 2002
+++ linux/arch/i386/kernel/microcode.c	Mon May 20 22:58:28 2002
@@ -211,7 +211,7 @@
 	req->err = 1; /* assume update will fail on this cpu */
 
 	if (c->x86_vendor != X86_VENDOR_INTEL || c->x86 < 6 ||
-		test_bit(X86_FEATURE_IA64, c->x86_capability)){
+	    	cpu_has(c, X86_FEATURE_IA64)) {
 		printk(KERN_ERR "microcode: CPU%d not a capable Intel processor\n", cpu_num);
 		return;
 	}
diff -urN linux-bk/arch/i386/kernel/msr.c linux/arch/i386/kernel/msr.c
--- linux-bk/arch/i386/kernel/msr.c	Wed May 15 10:27:25 2002
+++ linux/arch/i386/kernel/msr.c	Mon May 20 22:47:29 2002
@@ -236,7 +236,7 @@
   
   if ( !(cpu_online_map & (1UL << cpu)) )
     return -ENXIO;		/* No such CPU */
-  if ( !test_bit(X86_FEATURE_MSR, c->x86_capability) )
+  if ( !cpu_has(c, X86_FEATURE_MSR) )
     return -EIO;		/* MSR not supported */
   
   return 0;
diff -urN linux-bk/arch/i386/kernel/mtrr.c linux/arch/i386/kernel/mtrr.c
--- linux-bk/arch/i386/kernel/mtrr.c	Wed May 15 10:27:26 2002
+++ linux/arch/i386/kernel/mtrr.c	Mon May 20 22:56:57 2002
@@ -387,7 +387,7 @@
 	 return;
 
     /*  Save value of CR4 and clear Page Global Enable (bit 7)  */
-    if ( test_bit(X86_FEATURE_PGE, boot_cpu_data.x86_capability) ) {
+    if ( cpu_has_pge ) {
 	ctxt->cr4val = read_cr4();
 	write_cr4(ctxt->cr4val & (unsigned char) ~(1<<7));
     }
@@ -448,7 +448,7 @@
     write_cr0( read_cr0() & 0xbfffffff );
 
     /*  Restore value of CR4  */
-    if ( test_bit(X86_FEATURE_PGE, boot_cpu_data.x86_capability) )
+    if ( cpu_has_pge )
 	write_cr4(ctxt->cr4val);
 
     /*  Re-enable interrupts locally (if enabled previously)  */
@@ -2122,7 +2122,7 @@
 
 static int __init mtrr_setup(void)
 {
-    if ( test_bit(X86_FEATURE_MTRR, boot_cpu_data.x86_capability) ) {
+    if ( cpu_has_mtrr ) {
 	/* Intel (P6) standard MTRRs */
 	mtrr_if = MTRR_IF_INTEL;
 	get_mtrr = intel_get_mtrr;
@@ -2166,14 +2166,14 @@
 		break;
 	}
 
-    } else if ( test_bit(X86_FEATURE_K6_MTRR, boot_cpu_data.x86_capability) ) {
+    } else if ( cpu_has_k6_mtrr ) {
 	/* Pre-Athlon (K6) AMD CPU MTRRs */
 	mtrr_if = MTRR_IF_AMD_K6;
 	get_mtrr = amd_get_mtrr;
 	set_mtrr_up = amd_set_mtrr_up;
 	size_or_mask  = 0xfff00000; /* 32 bits */
 	size_and_mask = 0;
-    } else if ( test_bit(X86_FEATURE_CYRIX_ARR, boot_cpu_data.x86_capability) ) {
+    } else if ( cpu_has_cyrix_arr ) {
 	/* Cyrix ARRs */
 	mtrr_if = MTRR_IF_CYRIX_ARR;
 	get_mtrr = cyrix_get_arr;
@@ -2182,7 +2182,7 @@
 	cyrix_arr_init();
 	size_or_mask  = 0xfff00000; /* 32 bits */
 	size_and_mask = 0;
-    } else if ( test_bit(X86_FEATURE_CENTAUR_MCR, boot_cpu_data.x86_capability) ) {
+    } else if ( cpu_has_centaur_mcr ) {
 	/* Centaur MCRs */
 	mtrr_if = MTRR_IF_CENTAUR_MCR;
 	get_mtrr = centaur_get_mcr;
diff -urN linux-bk/arch/i386/kernel/setup.c linux/arch/i386/kernel/setup.c
--- linux-bk/arch/i386/kernel/setup.c	Mon May 20 22:27:42 2002
+++ linux/arch/i386/kernel/setup.c	Mon May 20 22:47:29 2002
@@ -1226,7 +1226,7 @@
 			 * here.
 			 */
 			if (c->x86_model == 6 || c->x86_model == 7) {
-				if (!test_bit(X86_FEATURE_XMM, c->x86_capability)) {
+				if (!cpu_has(c, X86_FEATURE_XMM)) {
 					printk(KERN_INFO "Enabling disabled K7/SSE Support.\n");
 					rdmsr(MSR_K7_HWCR, l, h);
 					l &= ~0x00008000;
@@ -2153,7 +2153,7 @@
 		strcpy(c->x86_model_id, p);
 	
 #ifdef CONFIG_SMP
-	if (test_bit(X86_FEATURE_HT, c->x86_capability)) {
+	if (cpu_has(c, X86_FEATURE_HT)) {
 		extern	int phys_proc_id[NR_CPUS];
 		
 		u32 	eax, ebx, ecx, edx;
@@ -2322,8 +2322,7 @@
 
 static void __init squash_the_stupid_serial_number(struct cpuinfo_x86 *c)
 {
-	if( test_bit(X86_FEATURE_PN, c->x86_capability) &&
-	    disable_x86_serial_nr ) {
+	if (cpu_has(c, X86_FEATURE_PN) && disable_x86_serial_nr ) {
 		/* Disable processor serial number */
 		unsigned long lo,hi;
 		rdmsr(MSR_IA32_BBL_CR_CTL,lo,hi);
@@ -2760,7 +2759,7 @@
 	else
 		seq_printf(m, "stepping\t: unknown\n");
 
-	if ( test_bit(X86_FEATURE_TSC, c->x86_capability) ) {
+	if ( cpu_has(c, X86_FEATURE_TSC) ) {
 		seq_printf(m, "cpu MHz\t\t: %lu.%03lu\n",
 			cpu_khz / 1000, (cpu_khz % 1000));
 	}
diff -urN linux-bk/arch/i386/kernel/smpboot.c linux/arch/i386/kernel/smpboot.c
--- linux-bk/arch/i386/kernel/smpboot.c	Mon May 20 22:27:42 2002
+++ linux/arch/i386/kernel/smpboot.c	Mon May 20 22:57:28 2002
@@ -1087,8 +1087,7 @@
 	/*
 	 * If we couldn't find a local APIC, then get out of here now!
 	 */
-	if (APIC_INTEGRATED(apic_version[boot_cpu_physical_apicid]) &&
-	    !test_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability)) {
+	if (APIC_INTEGRATED(apic_version[boot_cpu_physical_apicid]) && !cpu_has_apic) {
 		printk(KERN_ERR "BIOS bug, local APIC #%d not detected!...\n",
 			boot_cpu_physical_apicid);
 		printk(KERN_ERR "... forcing use of dummy APIC emulation. (tell your hw vendor)\n");
@@ -1203,8 +1202,7 @@
 	 * If Hyper-Threading is avaialble, construct cpu_sibling_map[], so
 	 * that we can tell the sibling CPU efficiently.
 	 */
-	if (test_bit(X86_FEATURE_HT, boot_cpu_data.x86_capability)
-	    && smp_num_siblings > 1) {
+	if (cpu_has_ht && smp_num_siblings > 1) {
 		for (cpu = 0; cpu < NR_CPUS; cpu++)
 			cpu_sibling_map[cpu] = NO_PROC_ID;
 		
diff -urN linux-bk/drivers/char/random.c linux/drivers/char/random.c
--- linux-bk/drivers/char/random.c	Mon May 20 22:27:57 2002
+++ linux/drivers/char/random.c	Mon May 20 23:13:54 2002
@@ -736,7 +736,7 @@
 	int		entropy = 0;
 
 #if defined (__i386__) || defined (__x86_64__)
-	if (cpu_has_tsc)
+	if (cpu_has_tsc) {
 		__u32 high;
 		rdtsc(time, high);
 		num ^= high;
diff -urN linux-bk/include/asm-i386/bugs.h linux/include/asm-i386/bugs.h
--- linux-bk/include/asm-i386/bugs.h	Mon May 20 21:38:35 2002
+++ linux/include/asm-i386/bugs.h	Mon May 20 23:07:18 2002
@@ -186,7 +186,7 @@
  */
 #if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86_GOOD_APIC)
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL
-	    && test_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability)
+	    && cpu_has_apic
 	    && boot_cpu_data.x86 == 5
 	    && boot_cpu_data.x86_model == 2
 	    && (boot_cpu_data.x86_mask < 6 || boot_cpu_data.x86_mask == 11))
diff -urN linux-bk/include/asm-i386/cpufeature.h linux/include/asm-i386/cpufeature.h
--- linux-bk/include/asm-i386/cpufeature.h	Thu Mar  7 21:18:15 2002
+++ linux/include/asm-i386/cpufeature.h	Mon May 20 23:05:54 2002
@@ -7,9 +7,6 @@
 #ifndef __ASM_I386_CPUFEATURE_H
 #define __ASM_I386_CPUFEATURE_H
 
-/* Sample usage: CPU_FEATURE_P(cpu.x86_capability, FPU) */
-#define CPU_FEATURE_P(CAP, FEATURE) test_bit(CAP, X86_FEATURE_##FEATURE ##_BIT)
-
 #define NCAPINTS	4	/* Currently we have 4 32-bit words worth of info */
 
 /* Intel-defined CPU features, CPUID level 0x00000001, word 0 */
@@ -65,6 +62,28 @@
 #define X86_FEATURE_CYRIX_ARR	(3*32+ 2) /* Cyrix ARRs (= MTRRs) */
 #define X86_FEATURE_CENTAUR_MCR	(3*32+ 3) /* Centaur MCRs (= MTRRs) */
 
+
+#define cpu_has(c, bit)		test_bit(bit, (c)->x86_capability)
+#define boot_cpu_has(bit)	test_bit(bit, boot_cpu_data.x86_capability)
+
+#define cpu_has_fpu		boot_cpu_has(X86_FEATURE_FPU)
+#define cpu_has_vme		boot_cpu_has(X86_FEATURE_VME)
+#define cpu_has_de		boot_cpu_has(X86_FEATURE_DE)
+#define cpu_has_pse		boot_cpu_has(X86_FEATURE_PSE)
+#define cpu_has_tsc		boot_cpu_has(X86_FEATURE_TSC)
+#define cpu_has_pae		boot_cpu_has(X86_FEATURE_PAE)
+#define cpu_has_pge		boot_cpu_has(X86_FEATURE_PGE)
+#define cpu_has_apic		boot_cpu_has(X86_FEATURE_APIC)
+#define cpu_has_mtrr		boot_cpu_has(X86_FEATURE_MTRR)
+#define cpu_has_mmx		boot_cpu_has(X86_FEATURE_MMX)
+#define cpu_has_fxsr		boot_cpu_has(X86_FEATURE_FXSR)
+#define cpu_has_xmm		boot_cpu_has(X86_FEATURE_XMM)
+#define cpu_has_ht		boot_cpu_has(X86_FEATURE_HT)
+#define cpu_has_mp		boot_cpu_has(X86_FEATURE_MP)
+#define cpu_has_k6_mtrr		boot_cpu_has(X86_FEATURE_K6_MTRR)
+#define cpu_has_cyrix_arr	boot_cpu_has(X86_FEATURE_CYRIX_ARR)
+#define cpu_has_centaur_mcr	boot_cpu_has(X86_FEATURE_CENTAUR_MCR)
+
 #endif /* __ASM_I386_CPUFEATURE_H */
 
 /* 
diff -urN linux-bk/include/asm-i386/processor.h linux/include/asm-i386/processor.h
--- linux-bk/include/asm-i386/processor.h	Mon May 20 22:28:00 2002
+++ linux/include/asm-i386/processor.h	Mon May 20 23:07:18 2002
@@ -77,19 +77,6 @@
 #define current_cpu_data boot_cpu_data
 #endif
 
-#define cpu_has_pge	(test_bit(X86_FEATURE_PGE,  boot_cpu_data.x86_capability))
-#define cpu_has_pse	(test_bit(X86_FEATURE_PSE,  boot_cpu_data.x86_capability))
-#define cpu_has_pae	(test_bit(X86_FEATURE_PAE,  boot_cpu_data.x86_capability))
-#define cpu_has_tsc	(test_bit(X86_FEATURE_TSC,  boot_cpu_data.x86_capability))
-#define cpu_has_de	(test_bit(X86_FEATURE_DE,   boot_cpu_data.x86_capability))
-#define cpu_has_vme	(test_bit(X86_FEATURE_VME,  boot_cpu_data.x86_capability))
-#define cpu_has_fxsr	(test_bit(X86_FEATURE_FXSR, boot_cpu_data.x86_capability))
-#define cpu_has_mmx	(test_bit(X86_FEATURE_MMX,  boot_cpu_data.x86_capability))
-#define cpu_has_xmm	(test_bit(X86_FEATURE_XMM,  boot_cpu_data.x86_capability))
-#define cpu_has_fpu	(test_bit(X86_FEATURE_FPU,  boot_cpu_data.x86_capability))
-#define cpu_has_apic	(test_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability))
-#define cpu_has_mp (test_bit(X86_FEATURE_MP, boot_cpu_data.x86_capability))
-
 extern char ignore_irq13;
 
 extern void identify_cpu(struct cpuinfo_x86 *);

--------------090106090909020500040405--

