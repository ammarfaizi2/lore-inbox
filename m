Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129444AbRBBUXT>; Fri, 2 Feb 2001 15:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129549AbRBBUXJ>; Fri, 2 Feb 2001 15:23:09 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:22984 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S129444AbRBBUW7>; Fri, 2 Feb 2001 15:22:59 -0500
Date: Fri, 2 Feb 2001 21:22:24 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "H. Peter Anvin" <hpa@transmeta.com>, Hugh Dickins <hugh@veritas.com>,
        Richard Gooch <rgooch@atnf.csiro.au>
cc: linux-kernel@vger.kernel.org
Subject: CPU capabilities -- an update proposal
Message-ID: <Pine.GSO.3.96.1010202161941.28509L-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 Following is the current state of my CPU capabilities rework.  It
introduces a new global variable, common_x86_capability, which holds the
common set of flags for CPUs.  The boot_cpu_data is used appropriately
again, i.e. it's treated as current_cpu_data before smp_store_cpu_info()
is called (it doesn't matter for UP).  I defined a set of macros named
boot_has_* for the purpose of accessing boot_cpu_data.  I did not create
current_has_* macros to access current_cpu_data as I think this might
encourage people to use them instead of cpu_has_* incorrectly.

 I tried to select the right version, either boot_has_* or cpu_has_*,
throught the kernel tree.  Almost all places were unambiguous.  The one
problematic file is arch/i386/kernel/mtrr.c -- set_mtrr_prepare() and
set_mtrr_done() make use of boot_cpu_data.x86_capability and are called
both before and after smp_store_cpu_info() is called.  Richard, is there
any way to change it?  I guess we don't need to test for PGE at all -- if
a CPU has MTRRs it should have the cr4 register and writing a zero to an
undefined bit is explicitly allowed. 

 I'm going to add a few lines of comments to include/asm-i386/processor.h
to point it out explicitly when each set of macros should be used. 

 I'm looking forward to any comments, suggestions, possible fixes.  The
patch applies to 2.4.1-ac1 as well. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-2.4.0-ac12-cpu_caps-4
diff -up --recursive --new-file linux-2.4.0-ac12.macro/arch/i386/kernel/apic.c linux-2.4.0-ac12/arch/i386/kernel/apic.c
--- linux-2.4.0-ac12.macro/arch/i386/kernel/apic.c	Sun Jan 28 09:40:31 2001
+++ linux-2.4.0-ac12/arch/i386/kernel/apic.c	Wed Jan 31 21:26:13 2001
@@ -214,7 +214,7 @@ void __init init_bsp_APIC(void)
 	 * Don't do the setup now if we have a SMP BIOS as the
 	 * through-I/O-APIC virtual wire mode might be active.
 	 */
-	if (smp_found_config || !cpu_has_apic)
+	if (smp_found_config || !boot_has_apic)
 		return;
 
 	value = apic_read(APIC_LVR);
@@ -398,7 +398,7 @@ int detect_init_APIC (void)
 		return -1;
 	}
 
-	if (!cpu_has_apic) {
+	if (!boot_has_apic) {
 		if (boot_cpu_data.x86 == 5) {
 			printk("APIC turned off by hardware.\n");
 			return -1;
@@ -887,13 +887,13 @@ asmlinkage void smp_error_interrupt(void
  */
 void __init APIC_init_uniprocessor (void)
 {
-	if (!smp_found_config && !cpu_has_apic)
+	if (!smp_found_config && !boot_has_apic)
 		return;
 
 	/*
 	 * Complain if the BIOS pretends there is one.
 	 */
-	if (!cpu_has_apic && APIC_INTEGRATED(apic_version[boot_cpu_id])) {
+	if (!boot_has_apic && APIC_INTEGRATED(apic_version[boot_cpu_id])) {
 		printk(KERN_ERR "BIOS bug, local APIC #%d not detected!...\n",
 			boot_cpu_id);
 		return;
diff -up --recursive --new-file linux-2.4.0-ac12.macro/arch/i386/kernel/i386_ksyms.c linux-2.4.0-ac12/arch/i386/kernel/i386_ksyms.c
--- linux-2.4.0-ac12.macro/arch/i386/kernel/i386_ksyms.c	Sun Jan 28 09:40:31 2001
+++ linux-2.4.0-ac12/arch/i386/kernel/i386_ksyms.c	Sun Jan 28 20:53:20 2001
@@ -48,7 +48,9 @@ EXPORT_SYMBOL(drive_info);
 extern unsigned long get_cmos_time(void);
 
 /* platform dependent support */
+#if 0
 EXPORT_SYMBOL(boot_cpu_data);
+#endif
 #ifdef CONFIG_EISA
 EXPORT_SYMBOL(EISA_bus);
 #endif
diff -up --recursive --new-file linux-2.4.0-ac12.macro/arch/i386/kernel/i387.c linux-2.4.0-ac12/arch/i386/kernel/i387.c
--- linux-2.4.0-ac12.macro/arch/i386/kernel/i387.c	Sun Jan 28 09:40:31 2001
+++ linux-2.4.0-ac12/arch/i386/kernel/i387.c	Sun Jan 28 21:33:16 2001
@@ -19,7 +19,7 @@
 #include <asm/uaccess.h>
 
 #ifdef CONFIG_MATH_EMULATION
-#define HAVE_HWFP (boot_cpu_data.hard_math)
+#define HAVE_HWFP (current_cpu_data.hard_math)
 #else
 #define HAVE_HWFP 1
 #endif
diff -up --recursive --new-file linux-2.4.0-ac12.macro/arch/i386/kernel/i8259.c linux-2.4.0-ac12/arch/i386/kernel/i8259.c
--- linux-2.4.0-ac12.macro/arch/i386/kernel/i8259.c	Sun Jan 28 09:40:31 2001
+++ linux-2.4.0-ac12/arch/i386/kernel/i8259.c	Sun Jan 28 21:42:20 2001
@@ -504,6 +504,6 @@ void __init init_IRQ(void)
 	 * External FPU? Set up irq13 if so, for
 	 * original braindamaged IBM FERR coupling.
 	 */
-	if (boot_cpu_data.hard_math && !cpu_has_fpu)
+	if (boot_cpu_data.hard_math && !boot_has_fpu)
 		setup_irq(13, &irq13);
 }
diff -up --recursive --new-file linux-2.4.0-ac12.macro/arch/i386/kernel/nmi.c linux-2.4.0-ac12/arch/i386/kernel/nmi.c
--- linux-2.4.0-ac12.macro/arch/i386/kernel/nmi.c	Thu Jan 18 07:17:30 2001
+++ linux-2.4.0-ac12/arch/i386/kernel/nmi.c	Sun Jan 28 21:43:53 2001
@@ -193,7 +193,7 @@ void nmi_watchdog_tick (struct pt_regs *
 	if (cpu_has_apic && (nmi_watchdog == NMI_LOCAL_APIC)) {
 		/* XXX: nmi_watchdog should carry this info */
 		unsigned msr;
-		if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
+		if (current_cpu_data.x86_vendor == X86_VENDOR_AMD) {
 			wrmsr(MSR_K7_PERFCTR0, -(cpu_khz/HZ*1000), -1);
 		} else {
 			wrmsr(MSR_IA32_PERFCTR1, -(cpu_khz/HZ*1000), 0);
diff -up --recursive --new-file linux-2.4.0-ac12.macro/arch/i386/kernel/setup.c linux-2.4.0-ac12/arch/i386/kernel/setup.c
--- linux-2.4.0-ac12.macro/arch/i386/kernel/setup.c	Sun Jan 28 09:40:31 2001
+++ linux-2.4.0-ac12/arch/i386/kernel/setup.c	Fri Feb  2 07:55:35 2001
@@ -104,6 +104,7 @@
 
 char ignore_irq13;		/* set if exception 16 works */
 struct cpuinfo_x86 boot_cpu_data = { 0, 0, 0, 0, -1, 1, 0, 0, -1 };
+__u32 common_x86_capability[NCAPINTS] = { -1U, -1U, -1U, -1U };
 
 unsigned long mmu_cr4_features;
 
@@ -2002,7 +2003,7 @@ void __init identify_cpu(struct cpuinfo_
 	 */
 
 	/* TSC disabled? */
-#ifdef CONFIG_TSC
+#ifndef CONFIG_X86_TSC
 	if ( tsc_disable )
 		clear_bit(X86_FEATURE_TSC, &c->x86_capability);
 #endif
@@ -2037,22 +2038,19 @@ void __init identify_cpu(struct cpuinfo_
 	       c->x86_capability[3]);
 
 	/*
-	 * On SMP, boot_cpu_data holds the common feature set between
-	 * all CPUs; so make sure that we indicate which features are
-	 * common between the CPUs.  The first time this routine gets
-	 * executed, c == &boot_cpu_data.
+	 * On SMP, common_x86_capability holds the common feature
+	 * set between all CPUs; so make sure that we indicate
+	 * which features are common between the CPUs.
 	 */
-	if ( c != &boot_cpu_data ) {
-		/* AND the already accumulated flags with these */
-		for ( i = 0 ; i < NCAPINTS ; i++ )
-			boot_cpu_data.x86_capability[i] &= c->x86_capability[i];
-	}
+	/* AND the already accumulated flags with these */
+	for (i = 0; i < NCAPINTS; i++)
+		common_x86_capability[i] &= c->x86_capability[i];
 
 	printk("CPU: Common caps: %08x %08x %08x %08x\n",
-	       boot_cpu_data.x86_capability[0],
-	       boot_cpu_data.x86_capability[1],
-	       boot_cpu_data.x86_capability[2],
-	       boot_cpu_data.x86_capability[3]);
+	       common_x86_capability[0],
+	       common_x86_capability[1],
+	       common_x86_capability[2],
+	       common_x86_capability[3]);
 }
 /*
  *	Perform early boot up checks for a valid TSC. See arch/i386/kernel/time.c
@@ -2139,6 +2137,13 @@ int get_cpuinfo(char * buffer)
 	struct cpuinfo_x86 *c = cpu_data;
 	int i, n;
 
+	p += sprintf(p, "\ncommon flags\t:");
+	for ( i = 0 ; i < 32*NCAPINTS ; i++ )
+		if ( test_bit(i, &common_x86_capability) &&
+		     x86_cap_flags[i] != NULL )
+			p += sprintf(p, " %s", x86_cap_flags[i]);
+	p += sprintf(p, "\n\n");
+
 	for (n = 0; n < NR_CPUS; n++, c++) {
 		int fpu_exception;
 #ifdef CONFIG_SMP
@@ -2171,7 +2176,9 @@ int get_cpuinfo(char * buffer)
 			p += sprintf(p, "cache size\t: %d KB\n", c->x86_cache_size);
 		
 		/* We use exception 16 if we have hardware math and we've either seen it or the CPU claims it is internal */
-		fpu_exception = c->hard_math && (ignore_irq13 || cpu_has_fpu);
+		fpu_exception = c->hard_math &&
+			        (ignore_irq13 ||
+				 test_bit(X86_FEATURE_FPU, &c->x86_capability));
 		p += sprintf(p, "fdiv_bug\t: %s\n"
 			        "hlt_bug\t\t: %s\n"
 			        "f00f_bug\t: %s\n"
@@ -2221,10 +2228,10 @@ void __init cpu_init (void)
 	}
 	printk("Initializing CPU#%d\n", nr);
 
-	if (cpu_has_vme || cpu_has_tsc || cpu_has_de)
+	if (boot_has_vme || boot_has_tsc || boot_has_de)
 		clear_in_cr4(X86_CR4_VME|X86_CR4_PVI|X86_CR4_TSD|X86_CR4_DE);
 #ifndef CONFIG_X86_TSC
-	if (tsc_disable && cpu_has_tsc) {
+	if (tsc_disable && boot_has_tsc) {
 		printk("Disabling TSC...\n");
 		/**** FIX-HPA: DOES THIS REALLY BELONG HERE? ****/
 		clear_bit(X86_FEATURE_TSC, boot_cpu_data.x86_capability);
diff -up --recursive --new-file linux-2.4.0-ac12.macro/arch/i386/kernel/smpboot.c linux-2.4.0-ac12/arch/i386/kernel/smpboot.c
--- linux-2.4.0-ac12.macro/arch/i386/kernel/smpboot.c	Sun Jan 28 09:40:31 2001
+++ linux-2.4.0-ac12/arch/i386/kernel/smpboot.c	Wed Jan 31 22:27:05 2001
@@ -890,8 +890,7 @@ void __init smp_boot_cpus(void)
 	/*
 	 * If we couldn't find a local APIC, then get out of here now!
 	 */
-	if (APIC_INTEGRATED(apic_version[boot_cpu_id]) &&
-	    !test_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability)) {
+	if (APIC_INTEGRATED(apic_version[boot_cpu_id]) && !boot_has_apic) {
 		printk(KERN_ERR "BIOS bug, local APIC #%d not detected!...\n",
 			boot_cpu_id);
 		printk(KERN_ERR "... forcing use of dummy APIC emulation. (tell your hw vendor)\n");
diff -up --recursive --new-file linux-2.4.0-ac12.macro/arch/i386/kernel/time.c linux-2.4.0-ac12/arch/i386/kernel/time.c
--- linux-2.4.0-ac12.macro/arch/i386/kernel/time.c	Wed Jan  3 07:54:00 2001
+++ linux-2.4.0-ac12/arch/i386/kernel/time.c	Sun Jan 28 21:50:37 2001
@@ -657,7 +657,7 @@ void __init time_init(void)
  
  	dodgy_tsc();
  	
-	if (cpu_has_tsc) {
+	if (boot_has_tsc) {
 		unsigned long tsc_quotient = calibrate_tsc();
 		if (tsc_quotient) {
 			fast_gettimeoffset_quotient = tsc_quotient;
diff -up --recursive --new-file linux-2.4.0-ac12.macro/arch/i386/mm/init.c linux-2.4.0-ac12/arch/i386/mm/init.c
--- linux-2.4.0-ac12.macro/arch/i386/mm/init.c	Sun Jan 28 09:40:31 2001
+++ linux-2.4.0-ac12/arch/i386/mm/init.c	Wed Jan 31 21:49:59 2001
@@ -351,14 +351,14 @@ static void __init pagetable_init (void)
 			vaddr = i*PGDIR_SIZE + j*PMD_SIZE;
 			if (end && (vaddr >= end))
 				break;
-			if (cpu_has_pse) {
+			if (boot_has_pse) {
 				unsigned long __pe;
 
 				set_in_cr4(X86_CR4_PSE);
 				boot_cpu_data.wp_works_ok = 1;
 				__pe = _KERNPG_TABLE + _PAGE_PSE + __pa(vaddr);
 				/* Make it "global" too if supported */
-				if (cpu_has_pge) {
+				if (boot_has_pge) {
 					set_in_cr4(X86_CR4_PGE);
 					__pe += _PAGE_GLOBAL;
 				}
@@ -452,7 +452,7 @@ void __init paging_init(void)
 	 * We will bail out later - printk doesnt work right now so
 	 * the user would just see a hanging kernel.
 	 */
-	if (cpu_has_pae)
+	if (boot_has_pae)
 		set_in_cr4(X86_CR4_PAE);
 #endif
 
@@ -611,7 +611,7 @@ void __init mem_init(void)
 	       );
 
 #if CONFIG_X86_PAE
-	if (!cpu_has_pae)
+	if (!boot_has_pae)
 		panic("cannot execute a PAE-enabled kernel on a PAE-less CPU!");
 #endif
 	if (boot_cpu_data.wp_works_ok < 0)
diff -up --recursive --new-file linux-2.4.0-ac12.macro/drivers/char/mem.c linux-2.4.0-ac12/drivers/char/mem.c
--- linux-2.4.0-ac12.macro/drivers/char/mem.c	Sun Jan 28 09:40:44 2001
+++ linux-2.4.0-ac12/drivers/char/mem.c	Wed Jan 31 22:25:13 2001
@@ -179,10 +179,10 @@ static inline int noncached_address(unsi
 	 * caching for the high addresses through the KEN pin, but
 	 * we maintain the tradition of paranoia in this code.
 	 */
- 	return !( test_bit(X86_FEATURE_MTRR, &boot_cpu_data.x86_capability) ||
-		  test_bit(X86_FEATURE_K6_MTRR, &boot_cpu_data.x86_capability) ||
-		  test_bit(X86_FEATURE_CYRIX_ARR, &boot_cpu_data.x86_capability) ||
-		  test_bit(X86_FEATURE_CENTAUR_MCR, &boot_cpu_data.x86_capability) )
+ 	return !( test_bit(X86_FEATURE_MTRR, &common_x86_capability) ||
+		  test_bit(X86_FEATURE_K6_MTRR, &common_x86_capability) ||
+		  test_bit(X86_FEATURE_CYRIX_ARR, &common_x86_capability) ||
+		  test_bit(X86_FEATURE_CENTAUR_MCR, &common_x86_capability) )
 	  && addr >= __pa(high_memory);
 #else
 	return addr >= __pa(high_memory);
diff -up --recursive --new-file linux-2.4.0-ac12.macro/drivers/char/random.c linux-2.4.0-ac12/drivers/char/random.c
--- linux-2.4.0-ac12.macro/drivers/char/random.c	Sun Jan 28 09:40:44 2001
+++ linux-2.4.0-ac12/drivers/char/random.c	Wed Jan 31 22:20:58 2001
@@ -710,7 +710,7 @@ static void add_timer_randomness(struct 
 	int		entropy = 0;
 
 #if defined (__i386__)
-	if ( test_bit(X86_FEATURE_TSC, &boot_cpu_data.x86_capability) ) {
+	if ( cpu_has_tsc ) {
 		__u32 high;
 		__asm__(".byte 0x0f,0x31"
 			:"=a" (time), "=d" (high));
diff -up --recursive --new-file linux-2.4.0-ac12.macro/include/asm-i386/bugs.h linux-2.4.0-ac12/include/asm-i386/bugs.h
--- linux-2.4.0-ac12.macro/include/asm-i386/bugs.h	Sun Jan 28 09:41:20 2001
+++ linux-2.4.0-ac12/include/asm-i386/bugs.h	Wed Jan 31 22:18:40 2001
@@ -83,12 +83,12 @@ static void __init check_fpu(void)
 		extern void __buggy_fxsr_alignment(void);
 		__buggy_fxsr_alignment();
 	}
-	if (cpu_has_fxsr) {
+	if (boot_has_fxsr) {
 		printk(KERN_INFO "Enabling fast FPU save and restore... ");
 		set_in_cr4(X86_CR4_OSFXSR);
 		printk("done.\n");
 	}
-	if (cpu_has_xmm) {
+	if (boot_has_xmm) {
 		printk(KERN_INFO "Enabling unmasked SIMD FPU exception support... ");
 		set_in_cr4(X86_CR4_OSXMMEXCPT);
 		printk("done.\n");
@@ -174,7 +174,7 @@ static void __init check_config(void)
  * If we configured ourselves for a TSC, we'd better have one!
  */
 #ifdef CONFIG_X86_TSC
-	if (!cpu_has_tsc)
+	if (!boot_has_tsc)
 		panic("Kernel compiled for Pentium+, requires TSC feature!");
 #endif
 
@@ -182,7 +182,7 @@ static void __init check_config(void)
  * If we configured ourselves for PGE, we'd better have it.
  */
 #ifdef CONFIG_X86_PGE
-	if (!cpu_has_pge)
+	if (!boot_has_pge)
 		panic("Kernel compiled for PPro+, requires PGE feature!");
 #endif
 
@@ -193,8 +193,8 @@ static void __init check_config(void)
  * Specification Update").
  */
 #if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86_GOOD_APIC)
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL
-	    && test_bit(X86_FEATURE_APIC, &boot_cpu_data.x86_capability)
+	if (boot_has_apic
+	    && boot_cpu_data.x86_vendor == X86_VENDOR_INTEL
 	    && boot_cpu_data.x86 == 5
 	    && boot_cpu_data.x86_model == 2
 	    && (boot_cpu_data.x86_mask < 6 || boot_cpu_data.x86_mask == 11))
diff -up --recursive --new-file linux-2.4.0-ac12.macro/include/asm-i386/elf.h linux-2.4.0-ac12/include/asm-i386/elf.h
--- linux-2.4.0-ac12.macro/include/asm-i386/elf.h	Sun Jan  7 21:42:56 2001
+++ linux-2.4.0-ac12/include/asm-i386/elf.h	Wed Jan 31 22:14:50 2001
@@ -86,7 +86,7 @@ typedef struct user_fxsr_struct elf_fpxr
    instruction set this CPU supports.  This could be done in user space,
    but it's not easy, and we've already done it here.  */
 
-#define ELF_HWCAP	(boot_cpu_data.x86_capability[0])
+#define ELF_HWCAP	(common_x86_capability[0])
 
 /* This yields a string that ld.so will use to load implementation
    specific libraries for optimization.  This is more specific in
diff -up --recursive --new-file linux-2.4.0-ac12.macro/include/asm-i386/processor.h linux-2.4.0-ac12/include/asm-i386/processor.h
--- linux-2.4.0-ac12.macro/include/asm-i386/processor.h	Sun Jan 28 09:41:20 2001
+++ linux-2.4.0-ac12/include/asm-i386/processor.h	Wed Jan 31 22:08:09 2001
@@ -68,27 +68,52 @@ struct cpuinfo_x86 {
  * capabilities of CPUs
  */
 
+
 extern struct cpuinfo_x86 boot_cpu_data;
 extern struct tss_struct init_tss[NR_CPUS];
 
 #ifdef CONFIG_SMP
+extern __u32 common_x86_capability[NCAPINTS];
 extern struct cpuinfo_x86 cpu_data[];
 #define current_cpu_data cpu_data[smp_processor_id()]
 #else
+#define common_x86_capability boot_cpu_data.x86_capability
 #define cpu_data &boot_cpu_data
 #define current_cpu_data boot_cpu_data
 #endif
 
-#define cpu_has_pge	(test_bit(X86_FEATURE_PGE,  boot_cpu_data.x86_capability))
-#define cpu_has_pse	(test_bit(X86_FEATURE_PSE,  boot_cpu_data.x86_capability))
-#define cpu_has_pae	(test_bit(X86_FEATURE_PAE,  boot_cpu_data.x86_capability))
-#define cpu_has_tsc	(test_bit(X86_FEATURE_TSC,  boot_cpu_data.x86_capability))
-#define cpu_has_de	(test_bit(X86_FEATURE_DE,   boot_cpu_data.x86_capability))
-#define cpu_has_vme	(test_bit(X86_FEATURE_VME,  boot_cpu_data.x86_capability))
-#define cpu_has_fxsr	(test_bit(X86_FEATURE_FXSR, boot_cpu_data.x86_capability))
-#define cpu_has_xmm	(test_bit(X86_FEATURE_XMM,  boot_cpu_data.x86_capability))
-#define cpu_has_fpu	(test_bit(X86_FEATURE_FPU,  boot_cpu_data.x86_capability))
-#define cpu_has_apic	(test_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability))
+#define cpu_has_fpu	(test_bit(X86_FEATURE_FPU,  common_x86_capability))
+#define cpu_has_vme	(test_bit(X86_FEATURE_VME,  common_x86_capability))
+#define cpu_has_de	(test_bit(X86_FEATURE_DE,   common_x86_capability))
+#define cpu_has_pse	(test_bit(X86_FEATURE_PSE,  common_x86_capability))
+#define cpu_has_tsc	(test_bit(X86_FEATURE_TSC,  common_x86_capability))
+#define cpu_has_pae	(test_bit(X86_FEATURE_PAE,  common_x86_capability))
+#define cpu_has_apic	(test_bit(X86_FEATURE_APIC, common_x86_capability))
+#define cpu_has_pge	(test_bit(X86_FEATURE_PGE,  common_x86_capability))
+#define cpu_has_mmx	(test_bit(X86_FEATURE_MMX,  common_x86_capability))
+#define cpu_has_fxsr	(test_bit(X86_FEATURE_FXSR, common_x86_capability))
+#define cpu_has_xmm	(test_bit(X86_FEATURE_XMM,  common_x86_capability))
+
+#define boot_has_fpu	(test_bit(X86_FEATURE_FPU,	\
+						boot_cpu_data.x86_capability))
+#define boot_has_vme	(test_bit(X86_FEATURE_VME,	\
+						boot_cpu_data.x86_capability))
+#define boot_has_de	(test_bit(X86_FEATURE_DE,	\
+						boot_cpu_data.x86_capability))
+#define boot_has_pse	(test_bit(X86_FEATURE_PSE,	\
+						boot_cpu_data.x86_capability))
+#define boot_has_tsc	(test_bit(X86_FEATURE_TSC,	\
+						boot_cpu_data.x86_capability))
+#define boot_has_pae	(test_bit(X86_FEATURE_PAE,	\
+						boot_cpu_data.x86_capability))
+#define boot_has_apic	(test_bit(X86_FEATURE_APIC,	\
+						boot_cpu_data.x86_capability))
+#define boot_has_pge	(test_bit(X86_FEATURE_PGE,	\
+						boot_cpu_data.x86_capability))
+#define boot_has_fxsr	(test_bit(X86_FEATURE_FXSR,	\
+						boot_cpu_data.x86_capability))
+#define boot_has_xmm	(test_bit(X86_FEATURE_XMM,	\
+						boot_cpu_data.x86_capability))
 
 extern char ignore_irq13;
 
diff -up --recursive --new-file linux-2.4.0-ac12.macro/include/asm-i386/xor.h linux-2.4.0-ac12/include/asm-i386/xor.h
--- linux-2.4.0-ac12.macro/include/asm-i386/xor.h	Sun Nov 12 19:39:51 2000
+++ linux-2.4.0-ac12/include/asm-i386/xor.h	Wed Jan 31 22:00:18 2001
@@ -845,7 +845,7 @@ static struct xor_block_template xor_blo
 		xor_speed(&xor_block_32regs);		\
 	        if (cpu_has_xmm)			\
 			xor_speed(&xor_block_pIII_sse);	\
-	        if (md_cpu_has_mmx()) {			\
+	        if (cpu_has_mmx) {			\
 	                xor_speed(&xor_block_pII_mmx);	\
 	                xor_speed(&xor_block_p5_mmx);	\
 	        }					\
diff -up --recursive --new-file linux-2.4.0-ac12.macro/include/linux/raid/md_compatible.h linux-2.4.0-ac12/include/linux/raid/md_compatible.h
--- linux-2.4.0-ac12.macro/include/linux/raid/md_compatible.h	Sat Jan 27 21:56:31 2001
+++ linux-2.4.0-ac12/include/linux/raid/md_compatible.h	Wed Jan 31 22:04:09 2001
@@ -27,13 +27,7 @@
 /* 000 */
 #define md__get_free_pages(x,y) __get_free_pages(x,y)
 
-#ifdef __i386__
-/* 001 */
-extern __inline__ int md_cpu_has_mmx(void)
-{
-	return test_bit(X86_FEATURE_MMX,  &boot_cpu_data.x86_capability);
-}
-#endif
+/* 001 - md_cpu_has_mmx - use cpu_has_mmx instead */
 
 /* 002 */
 #define md_clear_page(page)        clear_page(page)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
