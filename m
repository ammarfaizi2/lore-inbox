Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313859AbSDIMBf>; Tue, 9 Apr 2002 08:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313862AbSDIMBe>; Tue, 9 Apr 2002 08:01:34 -0400
Received: from [62.221.7.202] ([62.221.7.202]:45193 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S313859AbSDIMBb>; Tue, 9 Apr 2002 08:01:31 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] set-bit cleanup I: x86_capability.
Date: Tue, 09 Apr 2002 22:04:51 +1000
Message-Id: <E16uuMm-00028n-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cosmetic change: x86_capability.  Makes it an unsigned long, and
removes the gratuitous & operators (it is already an array).  These
produce warnings when set_bit() etc. takes an unsigned long * instead
of a void *.

No object code changes,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.7-pre1/include/asm-i386/processor.h working-2.5.7-pre1-bitops/include/asm-i386/processor.h
--- linux-2.5.7-pre1/include/asm-i386/processor.h	Sat Mar 16 13:03:31 2002
+++ working-2.5.7-pre1-bitops/include/asm-i386/processor.h	Sat Mar 16 13:46:30 2002
@@ -40,7 +40,7 @@
 	char	hard_math;
 	char	rfu;
        	int	cpuid_level;	/* Maximum supported CPUID level, -1=no CPUID */
-	__u32	x86_capability[NCAPINTS];
+	unsigned long	x86_capability[NCAPINTS];
 	char	x86_vendor_id[16];
 	char	x86_model_id[64];
 	int 	x86_cache_size;  /* in KB - valid for CPUS which support this
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.7-pre1/arch/i386/kernel/apic.c working-2.5.7-pre1-bitops/arch/i386/kernel/apic.c
--- linux-2.5.7-pre1/arch/i386/kernel/apic.c	Fri Mar  8 14:49:11 2002
+++ working-2.5.7-pre1-bitops/arch/i386/kernel/apic.c	Sat Mar 16 13:59:01 2002
@@ -634,7 +634,7 @@
 		printk("Could not enable APIC!\n");
 		return -1;
 	}
-	set_bit(X86_FEATURE_APIC, &boot_cpu_data.x86_capability);
+	set_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability);
 	mp_lapic_addr = APIC_DEFAULT_PHYS_BASE;
 	boot_cpu_physical_apicid = 0;
 	if (nmi_watchdog != NMI_NONE)
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.7-pre1/arch/i386/kernel/bluesmoke.c working-2.5.7-pre1-bitops/arch/i386/kernel/bluesmoke.c
--- linux-2.5.7-pre1/arch/i386/kernel/bluesmoke.c	Wed Feb 20 17:55:58 2002
+++ working-2.5.7-pre1-bitops/arch/i386/kernel/bluesmoke.c	Sat Mar 16 13:54:50 2002
@@ -123,7 +123,7 @@
 	 *	Check for MCE support
 	 */
 
-	if( !test_bit(X86_FEATURE_MCE, &c->x86_capability) )
+	if( !test_bit(X86_FEATURE_MCE, c->x86_capability) )
 		return;	
 	
 	/*
@@ -153,7 +153,7 @@
 	 *	Check for PPro style MCA
 	 */
 	 		
-	if( !test_bit(X86_FEATURE_MCA, &c->x86_capability) )
+	if( !test_bit(X86_FEATURE_MCA, c->x86_capability) )
 		return;
 		
 	/* Ok machine check is available */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.7-pre1/arch/i386/kernel/mtrr.c working-2.5.7-pre1-bitops/arch/i386/kernel/mtrr.c
--- linux-2.5.7-pre1/arch/i386/kernel/mtrr.c	Wed Feb 20 17:55:58 2002
+++ working-2.5.7-pre1-bitops/arch/i386/kernel/mtrr.c	Sat Mar 16 13:59:04 2002
@@ -387,7 +387,7 @@
 	 return;
 
     /*  Save value of CR4 and clear Page Global Enable (bit 7)  */
-    if ( test_bit(X86_FEATURE_PGE, &boot_cpu_data.x86_capability) ) {
+    if ( test_bit(X86_FEATURE_PGE, boot_cpu_data.x86_capability) ) {
 	ctxt->cr4val = read_cr4();
 	write_cr4(ctxt->cr4val & (unsigned char) ~(1<<7));
     }
@@ -448,7 +448,7 @@
     write_cr0( read_cr0() & 0xbfffffff );
 
     /*  Restore value of CR4  */
-    if ( test_bit(X86_FEATURE_PGE, &boot_cpu_data.x86_capability) )
+    if ( test_bit(X86_FEATURE_PGE, boot_cpu_data.x86_capability) )
 	write_cr4(ctxt->cr4val);
 
     /*  Re-enable interrupts locally (if enabled previously)  */
@@ -2123,7 +2123,7 @@
 
 static int __init mtrr_setup(void)
 {
-    if ( test_bit(X86_FEATURE_MTRR, &boot_cpu_data.x86_capability) ) {
+    if ( test_bit(X86_FEATURE_MTRR, boot_cpu_data.x86_capability) ) {
 	/* Intel (P6) standard MTRRs */
 	mtrr_if = MTRR_IF_INTEL;
 	get_mtrr = intel_get_mtrr;
@@ -2167,14 +2167,14 @@
 		break;
 	}
 
-    } else if ( test_bit(X86_FEATURE_K6_MTRR, &boot_cpu_data.x86_capability) ) {
+    } else if ( test_bit(X86_FEATURE_K6_MTRR, boot_cpu_data.x86_capability) ) {
 	/* Pre-Athlon (K6) AMD CPU MTRRs */
 	mtrr_if = MTRR_IF_AMD_K6;
 	get_mtrr = amd_get_mtrr;
 	set_mtrr_up = amd_set_mtrr_up;
 	size_or_mask  = 0xfff00000; /* 32 bits */
 	size_and_mask = 0;
-    } else if ( test_bit(X86_FEATURE_CYRIX_ARR, &boot_cpu_data.x86_capability) ) {
+    } else if ( test_bit(X86_FEATURE_CYRIX_ARR, boot_cpu_data.x86_capability) ) {
 	/* Cyrix ARRs */
 	mtrr_if = MTRR_IF_CYRIX_ARR;
 	get_mtrr = cyrix_get_arr;
@@ -2183,7 +2183,7 @@
 	cyrix_arr_init();
 	size_or_mask  = 0xfff00000; /* 32 bits */
 	size_and_mask = 0;
-    } else if ( test_bit(X86_FEATURE_CENTAUR_MCR, &boot_cpu_data.x86_capability) ) {
+    } else if ( test_bit(X86_FEATURE_CENTAUR_MCR, boot_cpu_data.x86_capability) ) {
 	/* Centaur MCRs */
 	mtrr_if = MTRR_IF_CENTAUR_MCR;
 	get_mtrr = centaur_get_mcr;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.7-pre1/arch/i386/kernel/setup.c working-2.5.7-pre1-bitops/arch/i386/kernel/setup.c
--- linux-2.5.7-pre1/arch/i386/kernel/setup.c	Fri Mar  8 14:49:11 2002
+++ working-2.5.7-pre1-bitops/arch/i386/kernel/setup.c	Sat Mar 16 13:54:35 2002
@@ -610,7 +610,7 @@
 				to--;
 			if (!memcmp(from+4, "nopentium", 9)) {
 				from += 9+4;
-				clear_bit(X86_FEATURE_PSE, &boot_cpu_data.x86_capability);
+				clear_bit(X86_FEATURE_PSE, boot_cpu_data.x86_capability);
 			} else if (!memcmp(from+4, "exactmap", 8)) {
 				from += 8+4;
 				e820.nr_map = 0;
@@ -1108,7 +1108,7 @@
 
 	/* Bit 31 in normal CPUID used for nonstandard 3DNow ID;
 	   3DNow is IDd by bit 31 in extended CPUID (1*32+31) anyway */
-	clear_bit(0*32+31, &c->x86_capability);
+	clear_bit(0*32+31, c->x86_capability);
 	
 	r = get_model_name(c);
 
@@ -1119,8 +1119,8 @@
 			{
 				/* Based on AMD doc 20734R - June 2000 */
 				if ( c->x86_model == 0 ) {
-					clear_bit(X86_FEATURE_APIC, &c->x86_capability);
-					set_bit(X86_FEATURE_PGE, &c->x86_capability);
+					clear_bit(X86_FEATURE_APIC, c->x86_capability);
+					set_bit(X86_FEATURE_PGE, c->x86_capability);
 				}
 				break;
 			}
@@ -1200,7 +1200,7 @@
 				/*  Set MTRR capability flag if appropriate */
 				if (c->x86_model == 13 || c->x86_model == 9 ||
 				   (c->x86_model == 8 && c->x86_mask >= 8))
-					set_bit(X86_FEATURE_K6_MTRR, &c->x86_capability);
+					set_bit(X86_FEATURE_K6_MTRR, c->x86_capability);
 				break;
 			}
 			break;
@@ -1213,12 +1213,12 @@
 			 * here.
 			 */
 			if (c->x86_model == 6 || c->x86_model == 7) {
-				if (!test_bit(X86_FEATURE_XMM, &c->x86_capability)) {
+				if (!test_bit(X86_FEATURE_XMM, c->x86_capability)) {
 					printk(KERN_INFO "Enabling disabled K7/SSE Support.\n");
 					rdmsr(MSR_K7_HWCR, l, h);
 					l &= ~0x00008000;
 					wrmsr(MSR_K7_HWCR, l, h);
-					set_bit(X86_FEATURE_XMM, &c->x86_capability);
+					set_bit(X86_FEATURE_XMM, c->x86_capability);
 				}
 			}
 			break;
@@ -1334,12 +1334,12 @@
 
 	/* Bit 31 in normal CPUID used for nonstandard 3DNow ID;
 	   3DNow is IDd by bit 31 in extended CPUID (1*32+31) anyway */
-	clear_bit(0*32+31, &c->x86_capability);
+	clear_bit(0*32+31, c->x86_capability);
 
 	/* Cyrix used bit 24 in extended (AMD) CPUID for Cyrix MMX extensions */
-	if ( test_bit(1*32+24, &c->x86_capability) ) {
-		clear_bit(1*32+24, &c->x86_capability);
-		set_bit(X86_FEATURE_CXMMX, &c->x86_capability);
+	if ( test_bit(1*32+24, c->x86_capability) ) {
+		clear_bit(1*32+24, c->x86_capability);
+		set_bit(X86_FEATURE_CXMMX, c->x86_capability);
 	}
 
 	do_cyrix_devid(&dir0, &dir1);
@@ -1386,7 +1386,7 @@
 		} else             /* 686 */
 			p = Cx86_cb+1;
 		/* Emulate MTRRs using Cyrix's ARRs. */
-		set_bit(X86_FEATURE_CYRIX_ARR, &c->x86_capability);
+		set_bit(X86_FEATURE_CYRIX_ARR, c->x86_capability);
 		/* 6x86's contain this bug */
 		c->coma_bug = 1;
 		break;
@@ -1425,7 +1425,7 @@
 			Cx86_cb[2] = (dir0_lsn & 1) ? '3' : '4';
 			p = Cx86_cb+2;
 			c->x86_model = (dir1 & 0x20) ? 1 : 2;
-			clear_bit(X86_FEATURE_TSC, &c->x86_capability);
+			clear_bit(X86_FEATURE_TSC, c->x86_capability);
 		}
 		break;
 
@@ -1446,7 +1446,7 @@
         	if (((dir1 & 0x0f) > 4) || ((dir1 & 0xf0) == 0x20))
 			(c->x86_model)++;
 		/* Emulate MTRRs using Cyrix's ARRs. */
-		set_bit(X86_FEATURE_CYRIX_ARR, &c->x86_capability);
+		set_bit(X86_FEATURE_CYRIX_ARR, c->x86_capability);
 		break;
 
 	case 0xf:  /* Cyrix 486 without DEVID registers */
@@ -1745,7 +1745,7 @@
 
 	/* Bit 31 in normal CPUID used for nonstandard 3DNow ID;
 	   3DNow is IDd by bit 31 in extended CPUID (1*32+31) anyway */
-	clear_bit(0*32+31, &c->x86_capability);
+	clear_bit(0*32+31, c->x86_capability);
 
 	switch (c->x86) {
 
@@ -1756,7 +1756,7 @@
 				fcr_set=ECX8|DSMC|EDCTLB|EMMX|ERETSTK;
 				fcr_clr=DPDC;
 				printk(KERN_NOTICE "Disabling bugged TSC.\n");
-				clear_bit(X86_FEATURE_TSC, &c->x86_capability);
+				clear_bit(X86_FEATURE_TSC, c->x86_capability);
 #ifdef CONFIG_X86_OOSTORE
 				winchip_create_optimal_mcr();
 				/* Enable
@@ -1835,12 +1835,12 @@
 				printk(KERN_INFO "Centaur FCR is 0x%X\n",lo);
 			}
 			/* Emulate MTRRs using Centaur's MCR. */
-			set_bit(X86_FEATURE_CENTAUR_MCR, &c->x86_capability);
+			set_bit(X86_FEATURE_CENTAUR_MCR, c->x86_capability);
 			/* Report CX8 */
-			set_bit(X86_FEATURE_CX8, &c->x86_capability);
+			set_bit(X86_FEATURE_CX8, c->x86_capability);
 			/* Set 3DNow! on Winchip 2 and above. */
 			if (c->x86_model >=8)
-				set_bit(X86_FEATURE_3DNOW, &c->x86_capability);
+				set_bit(X86_FEATURE_3DNOW, c->x86_capability);
 			/* See if we can find out some more. */
 			if ( cpuid_eax(0x80000000) >= 0x80000005 ) {
 				/* Yes, we can. */
@@ -1858,8 +1858,8 @@
 					lo |= (1<<1 | 1<<7);	/* Report CX8 & enable PGE */
 					wrmsr (MSR_VIA_FCR, lo, hi);
 
-					set_bit(X86_FEATURE_CX8, &c->x86_capability);
-					set_bit(X86_FEATURE_3DNOW, &c->x86_capability);
+					set_bit(X86_FEATURE_CX8, c->x86_capability);
+					set_bit(X86_FEATURE_3DNOW, c->x86_capability);
 
 					get_model_name(c);
 					display_cacheinfo(c);
@@ -1953,7 +1953,7 @@
 		"movl $0x2333313a, %%edx\n\t"
 		"cpuid\n\t" : : : "eax", "ebx", "ecx", "edx"
 	);
-	set_bit(X86_FEATURE_CX8, &c->x86_capability);
+	set_bit(X86_FEATURE_CX8, c->x86_capability);
 }
 
 
@@ -2104,7 +2104,7 @@
 
 	/* SEP CPUID bug: Pentium Pro reports SEP but doesn't have it */
 	if ( c->x86 == 6 && c->x86_model < 3 && c->x86_mask < 3 )
-		clear_bit(X86_FEATURE_SEP, &c->x86_capability);
+		clear_bit(X86_FEATURE_SEP, c->x86_capability);
 	
 	/* Names for the Pentium II/Celeron processors 
 	   detectable only by also checking the cache size.
@@ -2134,7 +2134,7 @@
 		strcpy(c->x86_model_id, p);
 	
 #ifdef CONFIG_SMP
-	if (test_bit(X86_FEATURE_HT, &c->x86_capability)) {
+	if (test_bit(X86_FEATURE_HT, c->x86_capability)) {
 		extern	int phys_proc_id[NR_CPUS];
 		
 		u32 	eax, ebx, ecx, edx;
@@ -2301,7 +2301,7 @@
 
 static void __init squash_the_stupid_serial_number(struct cpuinfo_x86 *c)
 {
-	if( test_bit(X86_FEATURE_PN, &c->x86_capability) &&
+	if( test_bit(X86_FEATURE_PN, c->x86_capability) &&
 	    disable_x86_serial_nr ) {
 		/* Disable processor serial number */
 		unsigned long lo,hi;
@@ -2309,7 +2309,7 @@
 		lo |= 0x200000;
 		wrmsr(MSR_IA32_BBL_CR_CTL,lo,hi);
 		printk(KERN_NOTICE "CPU serial number disabled.\n");
-		clear_bit(X86_FEATURE_PN, &c->x86_capability);
+		clear_bit(X86_FEATURE_PN, c->x86_capability);
 
 		/* Disabling the serial number may affect the cpuid level */
 		c->cpuid_level = cpuid_eax(0);
@@ -2476,7 +2476,7 @@
 		/* Intel-defined flags: level 0x00000001 */
 		if ( c->cpuid_level >= 0x00000001 ) {
 			cpuid(0x00000001, &tfms, &junk, &junk,
-			      &c->x86_capability[0]);
+			      c->x86_capability[0]);
 			c->x86 = (tfms >> 8) & 15;
 			c->x86_model = (tfms >> 4) & 15;
 			c->x86_mask = tfms & 15;
@@ -2502,7 +2502,7 @@
 		}
 	}
 
-	printk(KERN_DEBUG "CPU: Before vendor init, caps: %08x %08x %08x, vendor = %d\n",
+	printk(KERN_DEBUG "CPU: Before vendor init, caps: %08lx %08lx %08lx, vendor = %d\n",
 	       c->x86_capability[0],
 	       c->x86_capability[1],
 	       c->x86_capability[2],
@@ -2562,7 +2562,7 @@
 		break;
 	}
 
-	printk(KERN_DEBUG "CPU: After vendor init, caps: %08x %08x %08x %08x\n",
+	printk(KERN_DEBUG "CPU: After vendor init, caps: %08lx %08lx %08lx %08lx\n",
 	       c->x86_capability[0],
 	       c->x86_capability[1],
 	       c->x86_capability[2],
@@ -2581,8 +2581,8 @@
 
 	/* FXSR disabled? */
 	if (disable_x86_fxsr) {
-		clear_bit(X86_FEATURE_FXSR, &c->x86_capability);
-		clear_bit(X86_FEATURE_XMM, &c->x86_capability);
+		clear_bit(X86_FEATURE_FXSR, c->x86_capability);
+		clear_bit(X86_FEATURE_XMM, c->x86_capability);
 	}
 
 	/* Disable the PN if appropriate */
@@ -2605,7 +2605,7 @@
 
 	/* Now the feature flags better reflect actual CPU features! */
 
-	printk(KERN_DEBUG "CPU:     After generic, caps: %08x %08x %08x %08x\n",
+	printk(KERN_DEBUG "CPU:     After generic, caps: %08lx %08lx %08lx %08lx\n",
 	       c->x86_capability[0],
 	       c->x86_capability[1],
 	       c->x86_capability[2],
@@ -2623,7 +2623,7 @@
 			boot_cpu_data.x86_capability[i] &= c->x86_capability[i];
 	}
 
-	printk(KERN_DEBUG "CPU:             Common caps: %08x %08x %08x %08x\n",
+	printk(KERN_DEBUG "CPU:             Common caps: %08lx %08lx %08lx %08lx\n",
 	       boot_cpu_data.x86_capability[0],
 	       boot_cpu_data.x86_capability[1],
 	       boot_cpu_data.x86_capability[2],
@@ -2732,7 +2732,7 @@
 	else
 		seq_printf(m, "stepping\t: unknown\n");
 
-	if ( test_bit(X86_FEATURE_TSC, &c->x86_capability) ) {
+	if ( test_bit(X86_FEATURE_TSC, c->x86_capability) ) {
 		seq_printf(m, "cpu MHz\t\t: %lu.%03lu\n",
 			cpu_khz / 1000, (cpu_khz % 1000));
 	}
@@ -2762,7 +2762,7 @@
 		     c->wp_works_ok ? "yes" : "no");
 
 	for ( i = 0 ; i < 32*NCAPINTS ; i++ )
-		if ( test_bit(i, &c->x86_capability) &&
+		if ( test_bit(i, c->x86_capability) &&
 		     x86_cap_flags[i] != NULL )
 			seq_printf(m, " %s", x86_cap_flags[i]);
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.7-pre1/drivers/char/mem.c working-2.5.7-pre1-bitops/drivers/char/mem.c
--- linux-2.5.7-pre1/drivers/char/mem.c	Fri Mar  8 14:49:15 2002
+++ working-2.5.7-pre1-bitops/drivers/char/mem.c	Sat Mar 16 13:37:50 2002
@@ -173,10 +173,10 @@
 	 * caching for the high addresses through the KEN pin, but
 	 * we maintain the tradition of paranoia in this code.
 	 */
- 	return !( test_bit(X86_FEATURE_MTRR, &boot_cpu_data.x86_capability) ||
-		  test_bit(X86_FEATURE_K6_MTRR, &boot_cpu_data.x86_capability) ||
-		  test_bit(X86_FEATURE_CYRIX_ARR, &boot_cpu_data.x86_capability) ||
-		  test_bit(X86_FEATURE_CENTAUR_MCR, &boot_cpu_data.x86_capability) )
+ 	return !( test_bit(X86_FEATURE_MTRR, boot_cpu_data.x86_capability) ||
+		  test_bit(X86_FEATURE_K6_MTRR, boot_cpu_data.x86_capability) ||
+		  test_bit(X86_FEATURE_CYRIX_ARR, boot_cpu_data.x86_capability) ||
+		  test_bit(X86_FEATURE_CENTAUR_MCR, boot_cpu_data.x86_capability) )
 	  && addr >= __pa(high_memory);
 #else
 	return addr >= __pa(high_memory);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.7-pre1/drivers/char/random.c working-2.5.7-pre1-bitops/drivers/char/random.c
--- linux-2.5.7-pre1/drivers/char/random.c	Wed Feb 20 17:56:33 2002
+++ working-2.5.7-pre1-bitops/drivers/char/random.c	Sat Mar 16 13:37:54 2002
@@ -736,7 +736,7 @@
 	int		entropy = 0;
 
 #if defined (__i386__)
-	if ( test_bit(X86_FEATURE_TSC, &boot_cpu_data.x86_capability) ) {
+	if ( test_bit(X86_FEATURE_TSC, boot_cpu_data.x86_capability) ) {
 		__u32 high;
 		rdtsc(time, high);
 		num ^= high;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.7-pre1/include/asm-i386/bugs.h working-2.5.7-pre1-bitops/include/asm-i386/bugs.h
--- linux-2.5.7-pre1/include/asm-i386/bugs.h	Sat Mar 16 13:36:28 2002
+++ working-2.5.7-pre1-bitops/include/asm-i386/bugs.h	Sat Mar 16 13:58:44 2002
@@ -194,7 +194,7 @@
  */
 #if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86_GOOD_APIC)
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL
-	    && test_bit(X86_FEATURE_APIC, &boot_cpu_data.x86_capability)
+	    && test_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability)
 	    && boot_cpu_data.x86 == 5
 	    && boot_cpu_data.x86_model == 2
 	    && (boot_cpu_data.x86_mask < 6 || boot_cpu_data.x86_mask == 11))
