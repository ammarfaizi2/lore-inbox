Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129168AbRBEORH>; Mon, 5 Feb 2001 09:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129134AbRBEOQ6>; Mon, 5 Feb 2001 09:16:58 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:35811 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S129036AbRBEOQz>; Mon, 5 Feb 2001 09:16:55 -0500
Date: Mon, 5 Feb 2001 14:49:38 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Hugh Dickins <hugh@veritas.com>
cc: "H. Peter Anvin" <hpa@transmeta.com>, Richard Gooch <rgooch@atnf.csiro.au>,
        linux-kernel@vger.kernel.org
Subject: Re: CPU capabilities -- an update proposal
In-Reply-To: <Pine.LNX.4.21.0102022217350.7240-100000@localhost.localdomain>
Message-ID: <Pine.GSO.3.96.1010205131747.18067K-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Feb 2001, Hugh Dickins wrote:

> I like common_x86_capability[], and I like that it's _not_ a struct
> cpuinfo_x86 - saves us from wasting time on inventing "common" values
> for the other cpuinfo_x86 fields (and'ing, or'ing, min'ing, etc.).

 That was my first idea.  I decided to implement it as struct cpuinfo_x86
later, though, to remove post-boot boot_cpu_data references completely.
As to the "common" values, I decided to take the KISS approach --
everything but x86_capability and x86_mask is copied from values obtained
by the BSP.  The x86_mask field is computed to be the lowest of all
steppings -- some code may find it useful; for now the only use is a bug
check in mtrr.c.  I'm not sure if it's possible to mix models with
multiple P6s in a single system.  If it is, we might adjust x86_model
appropriately.

> I agree with not defining current_has_ macros (at least until good
> reason for them appears).  And I'm glad you're doing a patch to fix
> these common capabilities, without getting bogged down in the issue
> of how to publish them via /proc (I think that's something for later).

 They are already made available in /proc/cpuinfo -- see get_cpuinfo().  I
took the simple approach and I don't think we want to complicate it more.
It's six lines of code anyway, so changing it this way or that way is
trivial, if needed.

> But I don't much like those two sets of macros (one of you is welcome
> but enough!).  Congratulations if you have indeed got them all right
> (I found no errors), but I'm afraid someone else will later choose
> the wrong one, however well you comment.  Which was why my version
> kept copying the "and" back into boot_cpu_data (admittedly a hack).

 The two sets of macros have to remain (well, we might rewrite the code to
use test_bit() directly, but what would we gain).  You are right it is
problematic to decide which macro to choose.  I've rewritten it thus again
-- with the new version almost no code needs to refer to boot_cpu_data
anymore.

> I wonder (you or hpa may very quickly point out why this is stupid
> and impossible), could we move the identify_cpu() calls into
> cpu_init()?  I used to think it was called too early for that, but
> now I see it's already using current, smp_processor_id(), printk().

 Of course.  I've already thought of this yesterday, but I did not
implement it yet because of other boot_cpu_data members such as
wp_works_ok, etc.  They are only initialized by the BSP at the moment and
it's performed after cpu_init() by various code subsystems.  I'm not sure
how to propagate them back to cpu_data[], yet.

 Also smp_store_cpu_info() should be moved early then, as there is code
that depends on certain capabilities of the current CPU as opposed to
common capabilities, MTRR support being an example. 

> If identify_cpu() went in there, then we'd only need one set of
> macros (cpu_has_ testing common_x86_capability), and a
> considerable source of potential errors would be gone.  Not just
> errors from using the wrong macro: it's worried me that so much
> of startup is relying on the feature flags before identify_cpu() 
> comes in to adjust them (e.g. adding PGE for an AMD, removing TSC
> from a Cyrix and a Centaur).  We could eliminate dodgy_tsc() then,
> its work already done.

 Yep, there are a few other issues -- the erroneous APIC flag on early AMD
K5s and non-Intel MTRR capabilities. 

> I've not applied and installed your patch, but the only problem
> I noticed was in i386_ksyms.c: you've put #if 0 #endif around the
> EXPORT_SYMBOL(boot_cpu_data), but you need to export it for UP;
> and you've no EXPORT_SYMBOL(common_x86_capability), which you'll
> need for SMP.  Actually, I'd prefer EXPORT_SYMBOL(boot_cpu_data)
> to be replaced by EXPORT_SYMBOL(common_x86_capability) (of course,
> without #ifdef 0 #endif), and the SMP/UP divergence removed from
> processor.h - give UP its own separate common_x86_capability[]
> (hmm, it's already there in setup.c, does that compile?) and
> its own cpu_data[1].  A little space wasted, but more confusion
> gone - and if you dare, boot_cpu_data can then be __initdata?

 Yep, I noticed that.  It wasn't run-time tested well -- the code wouldn't
even boot SMP on my P5.  The intent was to remove boot_cpu_data form the
list of exports and I've accomplished it now but I had to replace
common_x86_capability with common_cpu_data, as I already mentioned.  And
yes, I'm going to mark boot_cpu_data __initdata when I finish the work. 

> Very minor point: remember mem=nopentium switches off PSE,
> should be reflected in cpu_data and common_x86_capability.

 Yes.  This is now done.  Now that code may depend on common capabilities
reliably I decided to take the following approach to capabilities that are
to be disabled.

- Capabilities that are automatically disabled due to bugs or other
factors are removed from cpu_data[] and as a result they get deleted from
common capabilities, too.

- Capabilities that get disabled due to a user request are only cleared
from common capabilities.  The idea behind it is to disable their usage
for normal code, but let them still be visible for special cases (like CPU
handling and maintenance) with no need for code to revert to cpuid.

 Here is a new version of the patch.  I decided to copy
boot_cpu_data.x86_capability[0] (as filled by head.S) to
common_cpu_data.x86_capability[0] very early, at the beginning of
setup_arch().  This way even code running early on the BSP may make use
common capabilities (via cpu_has_*, for example), at least these "less
advanced" ones.  I believe the patch is cleaner now.  It fixes a few other
issues I found (like "no387" disabling the FPU only in the BSP) as well. 
I'll work to incorporate all your suggestions in the next version. 

 The patch applies to 2.4.1-ac1; I haven't checked other versions.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-2.4.1-ac1-cpu_caps-12
diff -up --recursive --new-file linux-2.4.1-ac1.macro/arch/i386/kernel/apic.c linux-2.4.1-ac1/arch/i386/kernel/apic.c
--- linux-2.4.1-ac1.macro/arch/i386/kernel/apic.c	Sat Feb  3 12:16:14 2001
+++ linux-2.4.1-ac1/arch/i386/kernel/apic.c	Sun Feb  4 17:43:28 2001
@@ -425,7 +425,13 @@ int detect_init_APIC (void)
 		printk("Could not enable APIC!\n");
 		return -1;
 	}
+	/*
+	 * About the only place to explicitly SET a bit in
+	 * common_cpu_data.x86_capability.  We are allowed to do so
+	 * though as we are the BSP.
+	 */
 	set_bit(X86_FEATURE_APIC, &boot_cpu_data.x86_capability);
+	set_bit(X86_FEATURE_APIC, &common_cpu_data.x86_capability);
 	mp_lapic_addr = APIC_DEFAULT_PHYS_BASE;
 	boot_cpu_id = 0;
 	if (nmi_watchdog != NMI_NONE)
diff -up --recursive --new-file linux-2.4.1-ac1.macro/arch/i386/kernel/i386_ksyms.c linux-2.4.1-ac1/arch/i386/kernel/i386_ksyms.c
--- linux-2.4.1-ac1.macro/arch/i386/kernel/i386_ksyms.c	Sat Feb  3 12:16:14 2001
+++ linux-2.4.1-ac1/arch/i386/kernel/i386_ksyms.c	Sun Feb  4 17:43:50 2001
@@ -48,7 +48,8 @@ EXPORT_SYMBOL(drive_info);
 extern unsigned long get_cmos_time(void);
 
 /* platform dependent support */
-EXPORT_SYMBOL(boot_cpu_data);
+EXPORT_SYMBOL(common_cpu_data);
+EXPORT_SYMBOL(export_cpu_data);
 #ifdef CONFIG_EISA
 EXPORT_SYMBOL(EISA_bus);
 #endif
@@ -119,7 +120,6 @@ EXPORT_SYMBOL(mmx_copy_page);
 #endif
 
 #ifdef CONFIG_SMP
-EXPORT_SYMBOL(cpu_data);
 EXPORT_SYMBOL(kernel_flag);
 EXPORT_SYMBOL(smp_num_cpus);
 EXPORT_SYMBOL(cpu_online_map);
diff -up --recursive --new-file linux-2.4.1-ac1.macro/arch/i386/kernel/i387.c linux-2.4.1-ac1/arch/i386/kernel/i387.c
--- linux-2.4.1-ac1.macro/arch/i386/kernel/i387.c	Sat Feb  3 12:16:14 2001
+++ linux-2.4.1-ac1/arch/i386/kernel/i387.c	Sun Feb  4 17:31:14 2001
@@ -19,7 +19,7 @@
 #include <asm/uaccess.h>
 
 #ifdef CONFIG_MATH_EMULATION
-#define HAVE_HWFP (boot_cpu_data.hard_math)
+#define HAVE_HWFP (common_cpu_data.hard_math)
 #else
 #define HAVE_HWFP 1
 #endif
diff -up --recursive --new-file linux-2.4.1-ac1.macro/arch/i386/kernel/i8259.c linux-2.4.1-ac1/arch/i386/kernel/i8259.c
--- linux-2.4.1-ac1.macro/arch/i386/kernel/i8259.c	Sat Feb  3 12:16:14 2001
+++ linux-2.4.1-ac1/arch/i386/kernel/i8259.c	Sun Feb  4 17:30:24 2001
@@ -391,7 +391,7 @@ static void math_error_irq(int cpl, void
 {
 	extern void math_error(void *);
 	outb(0,0xF0);
-	if (ignore_irq13 || !boot_cpu_data.hard_math)
+	if (ignore_irq13 || !current_cpu_data.hard_math)
 		return;
 	math_error((void *)regs->eip);
 }
diff -up --recursive --new-file linux-2.4.1-ac1.macro/arch/i386/kernel/mtrr.c linux-2.4.1-ac1/arch/i386/kernel/mtrr.c
--- linux-2.4.1-ac1.macro/arch/i386/kernel/mtrr.c	Wed Dec 13 23:54:27 2000
+++ linux-2.4.1-ac1/arch/i386/kernel/mtrr.c	Sun Feb  4 18:21:01 2001
@@ -374,7 +374,7 @@ static void set_mtrr_prepare (struct set
 	 return;
 
     /*  Save value of CR4 and clear Page Global Enable (bit 7)  */
-    if ( test_bit(X86_FEATURE_PGE, &boot_cpu_data.x86_capability) )
+    if ( cpu_has_pge )
 	asm volatile ("movl  %%cr4, %0\n\t"
 		      "movl  %0, %1\n\t"
 		      "andb  $0x7f, %b1\n\t"
@@ -431,7 +431,7 @@ static void set_mtrr_done (struct set_mt
 		  : "=r" (tmp) : : "memory");
 
     /*  Restore value of CR4  */
-    if ( test_bit(X86_FEATURE_PGE, &boot_cpu_data.x86_capability) )
+    if ( cpu_has_pge )
 	asm volatile ("movl  %0, %%cr4"
 		      : : "r" (ctxt->cr4val) : "memory");
 
@@ -1176,10 +1176,10 @@ int mtrr_add_page(unsigned long base, un
 
     case MTRR_IF_INTEL:
 	/*  For Intel PPro stepping <= 7, must be 4 MiB aligned  */
-	if ( boot_cpu_data.x86_vendor == X86_VENDOR_INTEL &&
-	     boot_cpu_data.x86 == 6 &&
-	     boot_cpu_data.x86_model == 1 &&
-	     boot_cpu_data.x86_mask <= 7 )
+	if ( common_cpu_data.x86_vendor == X86_VENDOR_INTEL &&
+	     common_cpu_data.x86 == 6 &&
+	     common_cpu_data.x86_model == 1 &&
+	     common_cpu_data.x86_mask <= 7 )
 	{
 	    if ( base & ((1 << (22-PAGE_SHIFT))-1) )
 	    {
@@ -1932,12 +1932,12 @@ static void __init centaur_mcr_init(void
 
 static int __init mtrr_setup(void)
 {
-    if ( test_bit(X86_FEATURE_MTRR, &boot_cpu_data.x86_capability) ) {
+    if ( test_bit(X86_FEATURE_MTRR, &common_cpu_data.x86_capability) ) {
 	/* Intel (P6) standard MTRRs */
 	mtrr_if = MTRR_IF_INTEL;
 	get_mtrr = intel_get_mtrr;
 	set_mtrr_up = intel_set_mtrr_up;
-	switch (boot_cpu_data.x86_vendor) {
+	switch (common_cpu_data.x86_vendor) {
 	case X86_VENDOR_AMD:
 		/* The original Athlon docs said that
 		   total addressable memory is 44 bits wide.
@@ -1949,7 +1949,7 @@ static int __init mtrr_setup(void)
 		   query the width (in bits) of the physical
 		   addressable memory on the Hammer family.
 		 */
-		if (boot_cpu_data.x86 == 7 && (cpuid_eax(0x80000000) >= 0x80000008)) {
+		if (common_cpu_data.x86 == 7 && (cpuid_eax(0x80000000) >= 0x80000008)) {
 			u32	phys_addr;
 			phys_addr = cpuid_eax(0x80000008) & 0xff ;
 			size_or_mask = ~((1 << (phys_addr - PAGE_SHIFT)) - 1);
@@ -1962,14 +1962,14 @@ static int __init mtrr_setup(void)
 		size_and_mask = 0x00f00000;
 		break;
 	}
-    } else if ( test_bit(X86_FEATURE_K6_MTRR, &boot_cpu_data.x86_capability) ) {
+    } else if ( test_bit(X86_FEATURE_K6_MTRR, &common_cpu_data.x86_capability) ) {
 	/* Pre-Athlon (K6) AMD CPU MTRRs */
 	mtrr_if = MTRR_IF_AMD_K6;
 	get_mtrr = amd_get_mtrr;
 	set_mtrr_up = amd_set_mtrr_up;
 	size_or_mask  = 0xfff00000; /* 32 bits */
 	size_and_mask = 0;
-    } else if ( test_bit(X86_FEATURE_CYRIX_ARR, &boot_cpu_data.x86_capability) ) {
+    } else if ( test_bit(X86_FEATURE_CYRIX_ARR, &common_cpu_data.x86_capability) ) {
 	/* Cyrix ARRs */
 	mtrr_if = MTRR_IF_CYRIX_ARR;
 	get_mtrr = cyrix_get_arr;
@@ -1978,7 +1978,7 @@ static int __init mtrr_setup(void)
 	cyrix_arr_init();
 	size_or_mask  = 0xfff00000; /* 32 bits */
 	size_and_mask = 0;
-    } else if ( test_bit(X86_FEATURE_CENTAUR_MCR, &boot_cpu_data.x86_capability) ) {
+    } else if ( test_bit(X86_FEATURE_CENTAUR_MCR, &common_cpu_data.x86_capability) ) {
 	/* Centaur MCRs */
 	mtrr_if = MTRR_IF_CENTAUR_MCR;
 	get_mtrr = centaur_get_mcr;
diff -up --recursive --new-file linux-2.4.1-ac1.macro/arch/i386/kernel/nmi.c linux-2.4.1-ac1/arch/i386/kernel/nmi.c
--- linux-2.4.1-ac1.macro/arch/i386/kernel/nmi.c	Wed Jan 31 22:01:50 2001
+++ linux-2.4.1-ac1/arch/i386/kernel/nmi.c	Sat Feb  3 18:14:43 2001
@@ -193,7 +193,7 @@ void nmi_watchdog_tick (struct pt_regs *
 	if (cpu_has_apic && (nmi_watchdog == NMI_LOCAL_APIC)) {
 		/* XXX: nmi_watchdog should carry this info */
 		unsigned msr;
-		if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
+		if (current_cpu_data.x86_vendor == X86_VENDOR_AMD) {
 			wrmsr(MSR_K7_PERFCTR0, -(cpu_khz/HZ*1000), -1);
 		} else {
 			wrmsr(MSR_IA32_PERFCTR1, -(cpu_khz/HZ*1000), 0);
diff -up --recursive --new-file linux-2.4.1-ac1.macro/arch/i386/kernel/setup.c linux-2.4.1-ac1/arch/i386/kernel/setup.c
--- linux-2.4.1-ac1.macro/arch/i386/kernel/setup.c	Sat Feb  3 12:16:14 2001
+++ linux-2.4.1-ac1/arch/i386/kernel/setup.c	Sun Feb  4 22:03:49 2001
@@ -102,8 +102,10 @@
  * Machine setup..
  */
 
+int hard_math_disable __initdata = 0;
 char ignore_irq13;		/* set if exception 16 works */
 struct cpuinfo_x86 boot_cpu_data = { 0, 0, 0, 0, -1, 1, 0, 0, -1 };
+struct cpuinfo_x86 common_cpu_data;
 
 unsigned long mmu_cr4_features;
 
@@ -548,7 +550,8 @@ static inline void parse_mem_cmdline (ch
 				to--;
 			if (!memcmp(from+4, "nopentium", 9)) {
 				from += 9+4;
-				clear_bit(X86_FEATURE_PSE, &boot_cpu_data.x86_capability);
+				clear_bit(X86_FEATURE_PSE,
+					&common_cpu_data.x86_capability);
 			} else if (!memcmp(from+4, "exactmap", 8)) {
 				from += 8+4;
 				e820.nr_map = 0;
@@ -601,6 +604,8 @@ void __init setup_arch(char **cmdline_p)
 	unsigned long start_pfn, max_pfn, max_low_pfn;
 	int i;
 
+	common_cpu_data.x86_capability[0] = boot_cpu_data.x86_capability[0];
+
 #ifdef CONFIG_VISWS
 	visws_get_board_type_and_rev();
 #endif
@@ -1887,6 +1892,19 @@ void __init identify_cpu(struct cpuinfo_
 {
 	int junk, i;
 	u32 xlvl, tfms;
+	__u32 x86_capability_mask;
+
+	/*
+	 * We are about to reinitialize data fetched in head.S.
+	 * But some early code might have disabled certain CPU
+	 * capabilities.  We store disabled bits for the BSP.
+	 */
+	if (!smp_processor_id()) {
+		x86_capability_mask = common_cpu_data.x86_capability[0];
+		x86_capability_mask ^= c->x86_capability[0];
+		x86_capability_mask &= c->x86_capability[0];
+		x86_capability_mask = ~x86_capability_mask;
+	}
 
 	c->loops_per_jiffy = loops_per_jiffy;
 	c->x86_cache_size = -1;
@@ -2002,12 +2020,6 @@ void __init identify_cpu(struct cpuinfo_
 	 * we do "generic changes."
 	 */
 
-	/* TSC disabled? */
-#ifdef CONFIG_TSC
-	if ( tsc_disable )
-		clear_bit(X86_FEATURE_TSC, &c->x86_capability);
-#endif
-
 	/* FXSR disabled? */
 	if (disable_x86_fxsr) {
 		clear_bit(X86_FEATURE_FXSR, &c->x86_capability);
@@ -2038,22 +2050,33 @@ void __init identify_cpu(struct cpuinfo_
 	       c->x86_capability[3]);
 
 	/*
-	 * On SMP, boot_cpu_data holds the common feature set between
-	 * all CPUs; so make sure that we indicate which features are
-	 * common between the CPUs.  The first time this routine gets
-	 * executed, c == &boot_cpu_data.
+	 * On SMP, common_cpu_data.x86_capability holds the common
+	 * feature set between all CPUs; so make sure that we
+	 * indicate which features are common between the CPUs.
 	 */
-	if ( c != &boot_cpu_data ) {
-		/* AND the already accumulated flags with these */
-		for ( i = 0 ; i < NCAPINTS ; i++ )
-			boot_cpu_data.x86_capability[i] &= c->x86_capability[i];
+
+	/*
+	 * Vendor-specific init may have set additional flags.  We
+	 * want to copy them to common flags for the BSP, but we want
+	 * to disable whatever was disabled by early code.
+	 */
+	if (!smp_processor_id()) {
+		common_cpu_data = *c;
+		common_cpu_data.x86_capability[0] &= x86_capability_mask;
 	}
 
+	if (c->x86_mask < common_cpu_data.x86_mask)
+		common_cpu_data.x86_mask = c->x86_mask;
+		
+	/* AND the already accumulated flags with these */
+	for (i = 0; i < NCAPINTS; i++)
+		common_cpu_data.x86_capability[i] &= c->x86_capability[i];
+
 	printk("CPU: Common caps: %08x %08x %08x %08x\n",
-	       boot_cpu_data.x86_capability[0],
-	       boot_cpu_data.x86_capability[1],
-	       boot_cpu_data.x86_capability[2],
-	       boot_cpu_data.x86_capability[3]);
+	       common_cpu_data.x86_capability[0],
+	       common_cpu_data.x86_capability[1],
+	       common_cpu_data.x86_capability[2],
+	       common_cpu_data.x86_capability[3]);
 }
 /*
  *	Perform early boot up checks for a valid TSC. See arch/i386/kernel/time.c
@@ -2140,6 +2163,13 @@ int get_cpuinfo(char * buffer)
 	struct cpuinfo_x86 *c = cpu_data;
 	int i, n;
 
+	p += sprintf(p, "\ncommon flags\t:");
+	for ( i = 0 ; i < 32*NCAPINTS ; i++ )
+		if ( test_bit(i, &common_cpu_data.x86_capability) &&
+		     x86_cap_flags[i] != NULL )
+			p += sprintf(p, " %s", x86_cap_flags[i]);
+	p += sprintf(p, "\n\n");
+
 	for (n = 0; n < NR_CPUS; n++, c++) {
 		int fpu_exception;
 #ifdef CONFIG_SMP
@@ -2162,7 +2192,7 @@ int get_cpuinfo(char * buffer)
 		else
 			p += sprintf(p, "stepping\t: unknown\n");
 
-		if ( test_bit(X86_FEATURE_TSC, &c->x86_capability) ) {
+		if ( cpu_has_tsc ) {
 			p += sprintf(p, "cpu MHz\t\t: %lu.%03lu\n",
 				cpu_khz / 1000, (cpu_khz % 1000));
 		}
@@ -2172,7 +2202,8 @@ int get_cpuinfo(char * buffer)
 			p += sprintf(p, "cache size\t: %d KB\n", c->x86_cache_size);
 		
 		/* We use exception 16 if we have hardware math and we've either seen it or the CPU claims it is internal */
-		fpu_exception = c->hard_math && (ignore_irq13 || cpu_has_fpu);
+		fpu_exception = c->hard_math &&
+			        (ignore_irq13 || cpu_has_fpu);
 		p += sprintf(p, "fdiv_bug\t: %s\n"
 			        "hlt_bug\t\t: %s\n"
 			        "f00f_bug\t: %s\n"
@@ -2222,13 +2253,20 @@ void __init cpu_init (void)
 	}
 	printk("Initializing CPU#%d\n", nr);
 
-	if (cpu_has_vme || cpu_has_tsc || cpu_has_de)
+	if (hard_math_disable) {
+		boot_cpu_data.hard_math = 0;
+		clear_bit(X86_FEATURE_FPU, common_cpu_data.x86_capability);
+	}
+	if (!boot_cpu_data.hard_math)
+		write_cr0(0xE | read_cr0());
+
+	if (boot_has_vme || boot_has_tsc || boot_has_de)
 		clear_in_cr4(X86_CR4_VME|X86_CR4_PVI|X86_CR4_TSD|X86_CR4_DE);
 #ifndef CONFIG_X86_TSC
-	if (tsc_disable && cpu_has_tsc) {
+	if (tsc_disable && boot_has_tsc) {
+		/* This has to be done early, before time_init(). */
 		printk("Disabling TSC...\n");
-		/**** FIX-HPA: DOES THIS REALLY BELONG HERE? ****/
-		clear_bit(X86_FEATURE_TSC, boot_cpu_data.x86_capability);
+		clear_bit(X86_FEATURE_TSC, common_cpu_data.x86_capability);
 		set_in_cr4(X86_CR4_TSD);
 	}
 #endif
diff -up --recursive --new-file linux-2.4.1-ac1.macro/arch/i386/kernel/smpboot.c linux-2.4.1-ac1/arch/i386/kernel/smpboot.c
--- linux-2.4.1-ac1.macro/arch/i386/kernel/smpboot.c	Sat Feb  3 12:16:14 2001
+++ linux-2.4.1-ac1/arch/i386/kernel/smpboot.c	Sun Feb  4 18:13:52 2001
@@ -147,7 +147,6 @@ void __init smp_store_cpu_info(int id)
 	c->pmd_quick = 0;
 	c->pgd_quick = 0;
 	c->pgtable_cache_sz = 0;
-	identify_cpu(c);
 	/*
 	 * Mask B, Pentium, but not Pentium MMX
 	 */
@@ -409,6 +408,10 @@ void __init smp_callin(void)
 
 	sti();
 
+	/*
+	 * Must be done before mtrr_init.
+	 */
+	identify_cpu(&boot_cpu_data);
 #ifdef CONFIG_MTRR
 	/*
 	 * Must be done before calibration delay is computed
@@ -803,7 +806,7 @@ static void smp_tune_scheduling (void)
 		cacheflush_time = 0;
 		return;
 	} else {
-		cachesize = boot_cpu_data.x86_cache_size;
+		cachesize = current_cpu_data.x86_cache_size;
 		if (cachesize == -1) {
 			cachesize = 16; /* Pentiums, 2x8kB cache */
 			bandwidth = 100;
@@ -890,8 +893,7 @@ void __init smp_boot_cpus(void)
 	/*
 	 * If we couldn't find a local APIC, then get out of here now!
 	 */
-	if (APIC_INTEGRATED(apic_version[boot_cpu_id]) &&
-	    !test_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability)) {
+	if (APIC_INTEGRATED(apic_version[boot_cpu_id]) && !boot_has_apic) {
 		printk(KERN_ERR "BIOS bug, local APIC #%d not detected!...\n",
 			boot_cpu_id);
 		printk(KERN_ERR "... forcing use of dummy APIC emulation. (tell your hw vendor)\n");
diff -up --recursive --new-file linux-2.4.1-ac1.macro/arch/i386/mm/fault.c linux-2.4.1-ac1/arch/i386/mm/fault.c
--- linux-2.4.1-ac1.macro/arch/i386/mm/fault.c	Mon Nov 20 18:01:59 2000
+++ linux-2.4.1-ac1/arch/i386/mm/fault.c	Sun Feb  4 17:20:45 2001
@@ -241,7 +241,7 @@ bad_area_nosemaphore:
 	/*
 	 * Pentium F0 0F C7 C8 bug workaround.
 	 */
-	if (boot_cpu_data.f00f_bug) {
+	if (common_cpu_data.f00f_bug) {
 		unsigned long nr;
 		
 		nr = (address - idt) >> 3;
diff -up --recursive --new-file linux-2.4.1-ac1.macro/drivers/char/drm/init.c linux-2.4.1-ac1/drivers/char/drm/init.c
--- linux-2.4.1-ac1.macro/drivers/char/drm/init.c	Sun Jul 30 22:09:46 2000
+++ linux-2.4.1-ac1/drivers/char/drm/init.c	Sun Feb  4 17:18:20 2001
@@ -103,7 +103,7 @@ void drm_parse_options(char *s)
 int drm_cpu_valid(void)
 {
 #if defined(__i386__)
-	if (boot_cpu_data.x86 == 3) return 0; /* No cmpxchg on a 386 */
+	if (common_cpu_data.x86 == 3) return 0; /* No cmpxchg on a 386 */
 #endif
 #if defined(__sparc__) && !defined(__sparc_v9__)
 	if (1)
diff -up --recursive --new-file linux-2.4.1-ac1.macro/drivers/char/drm/vm.c linux-2.4.1-ac1/drivers/char/drm/vm.c
--- linux-2.4.1-ac1.macro/drivers/char/drm/vm.c	Thu Oct  5 21:08:29 2000
+++ linux-2.4.1-ac1/drivers/char/drm/vm.c	Sun Feb  4 17:16:21 2001
@@ -317,7 +317,7 @@ int drm_mmap(struct file *filp, struct v
 	case _DRM_AGP:
 		if (VM_OFFSET(vma) >= __pa(high_memory)) {
 #if defined(__i386__)
-			if (boot_cpu_data.x86 > 3 && map->type != _DRM_AGP) {
+			if (common_cpu_data.x86 > 3 && map->type != _DRM_AGP) {
 				pgprot_val(vma->vm_page_prot) |= _PAGE_PCD;
 				pgprot_val(vma->vm_page_prot) &= ~_PAGE_PWT;
 			}
diff -up --recursive --new-file linux-2.4.1-ac1.macro/drivers/char/mem.c linux-2.4.1-ac1/drivers/char/mem.c
--- linux-2.4.1-ac1.macro/drivers/char/mem.c	Sat Feb  3 12:16:22 2001
+++ linux-2.4.1-ac1/drivers/char/mem.c	Sun Feb  4 17:46:14 2001
@@ -140,7 +140,7 @@ static inline pgprot_t pgprot_noncached(
 	/* On PPro and successors, PCD alone doesn't always mean 
 	    uncached because of interactions with the MTRRs. PCD | PWT
 	    means definitely uncached. */ 
-	if (boot_cpu_data.x86 > 3)
+	if (common_cpu_data.x86 > 3)
 		prot |= _PAGE_PCD | _PAGE_PWT;
 #elif defined(__powerpc__)
 	prot |= _PAGE_NO_CACHE | _PAGE_GUARDED;
@@ -179,10 +179,14 @@ static inline int noncached_address(unsi
 	 * caching for the high addresses through the KEN pin, but
 	 * we maintain the tradition of paranoia in this code.
 	 */
- 	return !( test_bit(X86_FEATURE_MTRR, &boot_cpu_data.x86_capability) ||
-		  test_bit(X86_FEATURE_K6_MTRR, &boot_cpu_data.x86_capability) ||
-		  test_bit(X86_FEATURE_CYRIX_ARR, &boot_cpu_data.x86_capability) ||
-		  test_bit(X86_FEATURE_CENTAUR_MCR, &boot_cpu_data.x86_capability) )
+ 	return !( test_bit(X86_FEATURE_MTRR,
+			&common_cpu_data.x86_capability) ||
+		  test_bit(X86_FEATURE_K6_MTRR,
+			&common_cpu_data.x86_capability) ||
+		  test_bit(X86_FEATURE_CYRIX_ARR,
+			&common_cpu_data.x86_capability) ||
+		  test_bit(X86_FEATURE_CENTAUR_MCR,
+			&common_cpu_data.x86_capability) )
 	  && addr >= __pa(high_memory);
 #else
 	return addr >= __pa(high_memory);
diff -up --recursive --new-file linux-2.4.1-ac1.macro/drivers/char/random.c linux-2.4.1-ac1/drivers/char/random.c
--- linux-2.4.1-ac1.macro/drivers/char/random.c	Sat Feb  3 12:16:23 2001
+++ linux-2.4.1-ac1/drivers/char/random.c	Sat Feb  3 18:14:43 2001
@@ -710,7 +710,7 @@ static void add_timer_randomness(struct 
 	int		entropy = 0;
 
 #if defined (__i386__)
-	if ( test_bit(X86_FEATURE_TSC, &boot_cpu_data.x86_capability) ) {
+	if ( cpu_has_tsc ) {
 		__u32 high;
 		__asm__(".byte 0x0f,0x31"
 			:"=a" (time), "=d" (high));
diff -up --recursive --new-file linux-2.4.1-ac1.macro/drivers/net/winbond-840.c linux-2.4.1-ac1/drivers/net/winbond-840.c
--- linux-2.4.1-ac1.macro/drivers/net/winbond-840.c	Sat Feb  3 12:16:41 2001
+++ linux-2.4.1-ac1/drivers/net/winbond-840.c	Sun Feb  4 17:09:08 2001
@@ -827,7 +827,7 @@ static void init_registers(struct net_de
 	writel(0xE010, ioaddr + PCIBusCfg);
 #else
 	/* When not a module we can work around broken '486 PCI boards. */
-#define x86 boot_cpu_data.x86
+#define x86 common_cpu_data.x86
 	writel((x86 <= 4 ? 0x4810 : 0xE010), ioaddr + PCIBusCfg);
 	if (x86 <= 4)
 		printk(KERN_INFO "%s: This is a 386/486 PCI system, setting cache "
diff -up --recursive --new-file linux-2.4.1-ac1.macro/drivers/scsi/sym53c8xx.c linux-2.4.1-ac1/drivers/scsi/sym53c8xx.c
--- linux-2.4.1-ac1.macro/drivers/scsi/sym53c8xx.c	Sun Jan  7 20:57:00 2001
+++ linux-2.4.1-ac1/drivers/scsi/sym53c8xx.c	Sun Feb  4 17:08:41 2001
@@ -13570,7 +13570,7 @@ sym53c8xx_pci_init(Scsi_Host_Template *t
 		extern char x86;
 		switch(x86) {
 #else
-		switch(boot_cpu_data.x86) {
+		switch(common_cpu_data.x86) {
 #endif
 		case 4:	suggested_cache_line_size = 4; break;
 		case 6:
diff -up --recursive --new-file linux-2.4.1-ac1.macro/drivers/scsi/sym53c8xx_comm.h linux-2.4.1-ac1/drivers/scsi/sym53c8xx_comm.h
--- linux-2.4.1-ac1.macro/drivers/scsi/sym53c8xx_comm.h	Tue Nov 14 10:25:03 2000
+++ linux-2.4.1-ac1/drivers/scsi/sym53c8xx_comm.h	Sun Feb  4 17:07:50 2001
@@ -2510,7 +2510,7 @@ sym53c8xx_pci_init(Scsi_Host_Template *t
 		extern char x86;
 		switch(x86) {
 #else
-		switch(boot_cpu_data.x86) {
+		switch(common_cpu_data.x86) {
 #endif
 		case 4:	suggested_cache_line_size = 4; break;
 		case 6:
diff -up --recursive --new-file linux-2.4.1-ac1.macro/drivers/video/fbmem.c linux-2.4.1-ac1/drivers/video/fbmem.c
--- linux-2.4.1-ac1.macro/drivers/video/fbmem.c	Sat Feb  3 12:16:51 2001
+++ linux-2.4.1-ac1/drivers/video/fbmem.c	Sun Feb  4 17:06:46 2001
@@ -592,7 +592,7 @@ fb_mmap(struct file *file, struct vm_are
 #elif defined(__alpha__)
 	/* Caching is off in the I/O space quadrant by design.  */
 #elif defined(__i386__)
-	if (boot_cpu_data.x86 > 3)
+	if (common_cpu_data.x86 > 3)
 		pgprot_val(vma->vm_page_prot) |= _PAGE_PCD;
 #elif defined(__mips__)
 	pgprot_val(vma->vm_page_prot) &= ~_CACHE_MASK;
diff -up --recursive --new-file linux-2.4.1-ac1.macro/drivers/video/sis/sis_main.c linux-2.4.1-ac1/drivers/video/sis/sis_main.c
--- linux-2.4.1-ac1.macro/drivers/video/sis/sis_main.c	Sat Feb  3 12:16:51 2001
+++ linux-2.4.1-ac1/drivers/video/sis/sis_main.c	Sun Feb  4 17:07:01 2001
@@ -1657,7 +1657,7 @@ static int sisfb_mmap(struct fb_info *in
 	vma->vm_pgoff = off >> PAGE_SHIFT;
 
 #if defined(__i386__)
-	if (boot_cpu_data.x86 > 3)
+	if (common_cpu_data.x86 > 3)
 		pgprot_val(vma->vm_page_prot) |= _PAGE_PCD;
 #endif
 	if (io_remap_page_range(vma->vm_start, off, vma->vm_end - vma->vm_start,
diff -up --recursive --new-file linux-2.4.1-ac1.macro/include/asm-i386/bugs.h linux-2.4.1-ac1/include/asm-i386/bugs.h
--- linux-2.4.1-ac1.macro/include/asm-i386/bugs.h	Sat Feb  3 12:06:03 2001
+++ linux-2.4.1-ac1/include/asm-i386/bugs.h	Sun Feb  4 21:55:59 2001
@@ -43,8 +43,7 @@ __setup("mca-pentium", mca_pentium);
 
 static int __init no_387(char *s)
 {
-	boot_cpu_data.hard_math = 0;
-	write_cr0(0xE | read_cr0());
+	hard_math_disable = 1;
 	return 1;
 }
 
@@ -193,8 +192,8 @@ static void __init check_config(void)
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
diff -up --recursive --new-file linux-2.4.1-ac1.macro/include/asm-i386/elf.h linux-2.4.1-ac1/include/asm-i386/elf.h
--- linux-2.4.1-ac1.macro/include/asm-i386/elf.h	Sat Feb  3 13:18:59 2001
+++ linux-2.4.1-ac1/include/asm-i386/elf.h	Sun Feb  4 17:46:44 2001
@@ -86,7 +86,7 @@ typedef struct user_fxsr_struct elf_fpxr
    instruction set this CPU supports.  This could be done in user space,
    but it's not easy, and we've already done it here.  */
 
-#define ELF_HWCAP	(boot_cpu_data.x86_capability[0])
+#define ELF_HWCAP	(common_cpu_data.x86_capability[0])
 
 /* This yields a string that ld.so will use to load implementation
    specific libraries for optimization.  This is more specific in
diff -up --recursive --new-file linux-2.4.1-ac1.macro/include/asm-i386/processor.h linux-2.4.1-ac1/include/asm-i386/processor.h
--- linux-2.4.1-ac1.macro/include/asm-i386/processor.h	Sat Feb  3 13:12:28 2001
+++ linux-2.4.1-ac1/include/asm-i386/processor.h	Sun Feb  4 22:05:49 2001
@@ -71,25 +71,64 @@ struct cpuinfo_x86 {
 extern struct cpuinfo_x86 boot_cpu_data;
 extern struct tss_struct init_tss[NR_CPUS];
 
+extern struct cpuinfo_x86 common_cpu_data;
+
 #ifdef CONFIG_SMP
 extern struct cpuinfo_x86 cpu_data[];
 #define current_cpu_data cpu_data[smp_processor_id()]
+#define export_cpu_data cpu_data
 #else
 #define cpu_data &boot_cpu_data
 #define current_cpu_data boot_cpu_data
+#define export_cpu_data boot_cpu_data
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
+/*
+ * Generic CPU capability tests.
+ */
+#define cpu_has_fpu	(test_bit(X86_FEATURE_FPU,	\
+					&common_cpu_data.x86_capability))
+#define cpu_has_vme	(test_bit(X86_FEATURE_VME,	\
+					&common_cpu_data.x86_capability))
+#define cpu_has_de	(test_bit(X86_FEATURE_DE,	\
+					&common_cpu_data.x86_capability))
+#define cpu_has_pse	(test_bit(X86_FEATURE_PSE,	\
+					&common_cpu_data.x86_capability))
+#define cpu_has_tsc	(test_bit(X86_FEATURE_TSC,	\
+					&common_cpu_data.x86_capability))
+#define cpu_has_pae	(test_bit(X86_FEATURE_PAE,	\
+					&common_cpu_data.x86_capability))
+#define cpu_has_apic	(test_bit(X86_FEATURE_APIC,	\
+					&common_cpu_data.x86_capability))
+#define cpu_has_pge	(test_bit(X86_FEATURE_PGE,	\
+					&common_cpu_data.x86_capability))
+#define cpu_has_mmx	(test_bit(X86_FEATURE_MMX,	\
+					&common_cpu_data.x86_capability))
+#define cpu_has_fxsr	(test_bit(X86_FEATURE_FXSR,	\
+					&common_cpu_data.x86_capability))
+#define cpu_has_xmm	(test_bit(X86_FEATURE_XMM,	\
+					&common_cpu_data.x86_capability))
+
+/*
+ * Boot-time CPU capability tests.  These should only be used if
+ * early code specifically needs to test a capability of the current
+ * CPU.  Early code is defined as anything before identify_cpu() gets
+ * called.  Normal code should test cpu_data[].  Note that these are
+ * really intended for CPU setup and handling functions only -- most
+ * code should use cpu_has_* macros anyway.
+ */
+#define boot_has_fpu	(test_bit(X86_FEATURE_FPU,	\
+					&boot_cpu_data.x86_capability))
+#define boot_has_vme	(test_bit(X86_FEATURE_VME,	\
+					&boot_cpu_data.x86_capability))
+#define boot_has_de	(test_bit(X86_FEATURE_DE,	\
+					&boot_cpu_data.x86_capability))
+#define boot_has_tsc	(test_bit(X86_FEATURE_TSC,	\
+					&boot_cpu_data.x86_capability))
+#define boot_has_apic	(test_bit(X86_FEATURE_APIC,	\
+					&boot_cpu_data.x86_capability))
 
+extern int hard_math_disable;
 extern char ignore_irq13;
 
 extern void identify_cpu(struct cpuinfo_x86 *);
diff -up --recursive --new-file linux-2.4.1-ac1.macro/include/asm-i386/uaccess.h linux-2.4.1-ac1/include/asm-i386/uaccess.h
--- linux-2.4.1-ac1.macro/include/asm-i386/uaccess.h	Sat Feb  3 13:12:29 2001
+++ linux-2.4.1-ac1/include/asm-i386/uaccess.h	Sun Feb  4 18:26:31 2001
@@ -52,9 +52,10 @@ extern int __verify_write(const void *, 
 #else
 
 #define access_ok(type,addr,size) ( (__range_ok(addr,size) == 0) && \
-			 ((type) == VERIFY_READ || boot_cpu_data.wp_works_ok || \
-			 segment_eq(get_fs(),KERNEL_DS) || \
-			  __verify_write((void *)(addr),(size))))
+				    ((type) == VERIFY_READ || \
+				     common_cpu_data.wp_works_ok || \
+				     segment_eq(get_fs(),KERNEL_DS) || \
+				     __verify_write((void *)(addr),(size))))
 
 #endif
 
diff -up --recursive --new-file linux-2.4.1-ac1.macro/include/asm-i386/xor.h linux-2.4.1-ac1/include/asm-i386/xor.h
--- linux-2.4.1-ac1.macro/include/asm-i386/xor.h	Sun Nov 12 19:39:51 2000
+++ linux-2.4.1-ac1/include/asm-i386/xor.h	Wed Jan 31 22:00:18 2001
@@ -845,7 +845,7 @@ static struct xor_block_template xor_blo
 		xor_speed(&xor_block_32regs);		\
 	        if (cpu_has_xmm)			\
 			xor_speed(&xor_block_pIII_sse);	\
-	        if (md_cpu_has_mmx()) {			\
+	        if (cpu_has_mmx) {			\
 	                xor_speed(&xor_block_pII_mmx);	\
 	                xor_speed(&xor_block_p5_mmx);	\
 	        }					\
diff -up --recursive --new-file linux-2.4.1-ac1.macro/include/linux/raid/md_compatible.h linux-2.4.1-ac1/include/linux/raid/md_compatible.h
--- linux-2.4.1-ac1.macro/include/linux/raid/md_compatible.h	Sat Feb  3 13:13:30 2001
+++ linux-2.4.1-ac1/include/linux/raid/md_compatible.h	Sat Feb  3 18:14:43 2001
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
