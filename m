Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293686AbSCPDFj>; Fri, 15 Mar 2002 22:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293687AbSCPDF3>; Fri, 15 Mar 2002 22:05:29 -0500
Received: from [202.135.142.196] ([202.135.142.196]:26634 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S293686AbSCPDFG>; Fri, 15 Mar 2002 22:05:06 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Richard Gooch <rgooch@ras.ucalgary.ca>
Subject: Re: bit ops on unsigned long? 
In-Reply-To: Your message of "Fri, 15 Mar 2002 16:58:14 -0800."
             <Pine.LNX.4.33.0203151656320.1379-100000@home.transmeta.com> 
Date: Sat, 16 Mar 2002 14:08:08 +1100
Message-Id: <E16m4YD-0004af-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.33.0203151656320.1379-100000@home.transmeta.com> you wri
te:
> 
> 
> On Sat, 16 Mar 2002, Rusty Russell wrote:
> >
> > 	nfs is broken in 2.5 ATM because it does set_bit on an "int".
> > Can be *please* just bite the bullet and change the prototype on these
> > ops so we stop seeing the same mistakes over and over?
> 
> The problem with the prototype is that it's not always correct.
> 
> It's fine to pass non-"unsigned long *" pointers to set_bit, if you know
> the pointers are otherwise aligned. Things like buffer bitmaps etc.

Sure: just like casting.

> How does the patch look? If it has a lot of unnecessary casts, I don't
> want it, but if the casts are only in things like ext2_setbit(), then that
> might be ok..

Actually, looks good: seems most kernel coders are expecting this.
Mainly changing from set_bit(x, &array) => set_bit(x, array).

Found 5 bugs doing this, too.  Meaning they have crept in since the
last such audit about 6 months ago 8(

Richard: 3 bugs in devfs.  Particularly note that the memset was
bogus.  I can't convince myself that your memcpy & memset stuff is
right anyway, given that you can ONLY treat them as unsigned longs
(ie. bit 31 will be in byte 0 or byte 3, depending on endianness).

This fixes all the warnings on my ppc and x86/SMP boxes,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

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
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.7-pre1/arch/ppc/platforms/pmac_pic.c working-2.5.7-pre1-bitops/arch/ppc/platforms/pmac_pic.c
--- linux-2.5.7-pre1/arch/ppc/platforms/pmac_pic.c	Wed Feb 20 17:57:04 2002
+++ working-2.5.7-pre1-bitops/arch/ppc/platforms/pmac_pic.c	Sat Mar 16 12:59:37 2002
@@ -492,7 +492,7 @@
  * and disables all interrupts except for the nominated one.
  * sleep_restore_intrs() restores the states of all interrupt enables.
  */
-unsigned int sleep_save_mask[2];
+unsigned long sleep_save_mask[2];
 
 void __pmac
 pmac_sleep_save_intrs(int viaint)
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
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.7-pre1/drivers/char/n_tty.c working-2.5.7-pre1-bitops/drivers/char/n_tty.c
--- linux-2.5.7-pre1/drivers/char/n_tty.c	Wed Feb 20 17:55:24 2002
+++ working-2.5.7-pre1-bitops/drivers/char/n_tty.c	Sat Mar 16 12:59:37 2002
@@ -538,7 +538,7 @@
 	 * handle specially, do shortcut processing to speed things
 	 * up.
 	 */
-	if (!test_bit(c, &tty->process_char_map) || tty->lnext) {
+	if (!test_bit(c, tty->process_char_map) || tty->lnext) {
 		finish_erasing(tty);
 		tty->lnext = 0;
 		if (L_ECHO(tty)) {
@@ -659,7 +659,7 @@
 
 		handle_newline:
 			spin_lock_irqsave(&tty->read_lock, flags);
-			set_bit(tty->read_head, &tty->read_flags);
+			set_bit(tty->read_head, tty->read_flags);
 			put_tty_queue_nolock(c, tty);
 			tty->canon_head = tty->read_head;
 			tty->canon_data++;
@@ -811,38 +811,38 @@
 		memset(tty->process_char_map, 0, 256/8);
 
 		if (I_IGNCR(tty) || I_ICRNL(tty))
-			set_bit('\r', &tty->process_char_map);
+			set_bit('\r', tty->process_char_map);
 		if (I_INLCR(tty))
-			set_bit('\n', &tty->process_char_map);
+			set_bit('\n', tty->process_char_map);
 
 		if (L_ICANON(tty)) {
-			set_bit(ERASE_CHAR(tty), &tty->process_char_map);
-			set_bit(KILL_CHAR(tty), &tty->process_char_map);
-			set_bit(EOF_CHAR(tty), &tty->process_char_map);
-			set_bit('\n', &tty->process_char_map);
-			set_bit(EOL_CHAR(tty), &tty->process_char_map);
+			set_bit(ERASE_CHAR(tty), tty->process_char_map);
+			set_bit(KILL_CHAR(tty), tty->process_char_map);
+			set_bit(EOF_CHAR(tty), tty->process_char_map);
+			set_bit('\n', tty->process_char_map);
+			set_bit(EOL_CHAR(tty), tty->process_char_map);
 			if (L_IEXTEN(tty)) {
 				set_bit(WERASE_CHAR(tty),
-					&tty->process_char_map);
+					tty->process_char_map);
 				set_bit(LNEXT_CHAR(tty),
-					&tty->process_char_map);
+					tty->process_char_map);
 				set_bit(EOL2_CHAR(tty),
-					&tty->process_char_map);
+					tty->process_char_map);
 				if (L_ECHO(tty))
 					set_bit(REPRINT_CHAR(tty),
-						&tty->process_char_map);
+						tty->process_char_map);
 			}
 		}
 		if (I_IXON(tty)) {
-			set_bit(START_CHAR(tty), &tty->process_char_map);
-			set_bit(STOP_CHAR(tty), &tty->process_char_map);
+			set_bit(START_CHAR(tty), tty->process_char_map);
+			set_bit(STOP_CHAR(tty), tty->process_char_map);
 		}
 		if (L_ISIG(tty)) {
-			set_bit(INTR_CHAR(tty), &tty->process_char_map);
-			set_bit(QUIT_CHAR(tty), &tty->process_char_map);
-			set_bit(SUSP_CHAR(tty), &tty->process_char_map);
+			set_bit(INTR_CHAR(tty), tty->process_char_map);
+			set_bit(QUIT_CHAR(tty), tty->process_char_map);
+			set_bit(SUSP_CHAR(tty), tty->process_char_map);
 		}
-		clear_bit(__DISABLED_CHAR, &tty->process_char_map);
+		clear_bit(__DISABLED_CHAR, tty->process_char_map);
 		sti();
 		tty->raw = 0;
 		tty->real_raw = 0;
@@ -1058,7 +1058,7 @@
  				int eol;
 
 				eol = test_and_clear_bit(tty->read_tail,
-						&tty->read_flags);
+						tty->read_flags);
 				c = tty->read_buf[tty->read_tail];
 				spin_lock_irqsave(&tty->read_lock, flags);
 				tty->read_tail = ((tty->read_tail+1) &
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
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.7-pre1/drivers/char/tty_ioctl.c working-2.5.7-pre1-bitops/drivers/char/tty_ioctl.c
--- linux-2.5.7-pre1/drivers/char/tty_ioctl.c	Tue Sep 18 15:52:35 2001
+++ working-2.5.7-pre1-bitops/drivers/char/tty_ioctl.c	Sat Mar 16 12:59:37 2002
@@ -188,7 +188,7 @@
 	nr = (head - tail) & (N_TTY_BUF_SIZE-1);
 	/* Skip EOF-chars.. */
 	while (head != tail) {
-		if (test_bit(tail, &tty->read_flags) &&
+		if (test_bit(tail, tty->read_flags) &&
 		    tty->read_buf[tail] == __DISABLED_CHAR)
 			nr--;
 		tail = (tail+1) & (N_TTY_BUF_SIZE-1);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.7-pre1/drivers/macintosh/adb.c working-2.5.7-pre1-bitops/drivers/macintosh/adb.c
--- linux-2.5.7-pre1/drivers/macintosh/adb.c	Wed Feb 20 17:55:08 2002
+++ working-2.5.7-pre1-bitops/drivers/macintosh/adb.c	Sat Mar 16 12:59:37 2002
@@ -77,7 +77,7 @@
 static int adb_got_sleep = 0;
 static int adb_inited = 0;
 static pid_t adb_probe_task_pid;
-static int adb_probe_task_flag;
+static unsigned long adb_probe_task_flag;
 static wait_queue_head_t adb_probe_task_wq;
 static int sleepy_trackpad;
 int __adb_probe_sync;
@@ -439,7 +439,7 @@
 }
 
 static struct adb_request adb_sreq;
-static int adb_sreq_lock; // Use semaphore ! */ 
+static unsigned long adb_sreq_lock; // Use semaphore ! */ 
 
 int
 adb_request(struct adb_request *req, void (*done)(struct adb_request *),
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.7-pre1/drivers/usb/hub.c working-2.5.7-pre1-bitops/drivers/usb/hub.c
--- linux-2.5.7-pre1/drivers/usb/hub.c	Fri Mar  8 14:49:21 2002
+++ working-2.5.7-pre1-bitops/drivers/usb/hub.c	Sat Mar 16 12:59:37 2002
@@ -1120,7 +1120,7 @@
 					dev->devpath,
 					sizeof(dev->descriptor), ret);
         
-			clear_bit(dev->devnum, &dev->bus->devmap.devicemap);
+			clear_bit(dev->devnum, dev->bus->devmap.devicemap);
 			dev->devnum = -1;
 			return -EIO;
 		}
@@ -1129,7 +1129,7 @@
 		if (ret < 0) {
 			err("unable to get configuration (error=%d)", ret);
 			usb_destroy_configuration(dev);
-			clear_bit(dev->devnum, &dev->bus->devmap.devicemap);
+			clear_bit(dev->devnum, dev->bus->devmap.devicemap);
 			dev->devnum = -1;
 			return 1;
 		}
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.7-pre1/drivers/usb/usb.c working-2.5.7-pre1-bitops/drivers/usb/usb.c
--- linux-2.5.7-pre1/drivers/usb/usb.c	Fri Mar  8 14:49:24 2002
+++ working-2.5.7-pre1-bitops/drivers/usb/usb.c	Sat Mar 16 12:59:37 2002
@@ -1749,7 +1749,7 @@
 
 	/* Free the device number and remove the /proc/bus/usb entry */
 	if (dev->devnum > 0) {
-		clear_bit(dev->devnum, &dev->bus->devmap.devicemap);
+		clear_bit(dev->devnum, dev->bus->devmap.devicemap);
 		usbfs_remove_device(dev);
 		put_device(&dev->dev);
 	}
@@ -2449,7 +2449,7 @@
 	if (err < 0) {
 		err("USB device not accepting new address=%d (error=%d)",
 			dev->devnum, err);
-		clear_bit(dev->devnum, &dev->bus->devmap.devicemap);
+		clear_bit(dev->devnum, dev->bus->devmap.devicemap);
 		dev->devnum = -1;
 		return 1;
 	}
@@ -2462,7 +2462,7 @@
 			err("USB device not responding, giving up (error=%d)", err);
 		else
 			err("USB device descriptor short read (expected %i, got %i)", 8, err);
-		clear_bit(dev->devnum, &dev->bus->devmap.devicemap);
+		clear_bit(dev->devnum, dev->bus->devmap.devicemap);
 		dev->devnum = -1;
 		return 1;
 	}
@@ -2477,7 +2477,7 @@
 			err("USB device descriptor short read (expected %Zi, got %i)",
 				sizeof(dev->descriptor), err);
 	
-		clear_bit(dev->devnum, &dev->bus->devmap.devicemap);
+		clear_bit(dev->devnum, dev->bus->devmap.devicemap);
 		dev->devnum = -1;
 		return 1;
 	}
@@ -2486,7 +2486,7 @@
 	if (err < 0) {
 		err("unable to get device %d configuration (error=%d)",
 			dev->devnum, err);
-		clear_bit(dev->devnum, &dev->bus->devmap.devicemap);
+		clear_bit(dev->devnum, dev->bus->devmap.devicemap);
 		dev->devnum = -1;
 		return 1;
 	}
@@ -2496,7 +2496,7 @@
 	if (err) {
 		err("failed to set device %d default configuration (error=%d)",
 			dev->devnum, err);
-		clear_bit(dev->devnum, &dev->bus->devmap.devicemap);
+		clear_bit(dev->devnum, dev->bus->devmap.devicemap);
 		dev->devnum = -1;
 		return 1;
 	}
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.7-pre1/fs/devfs/util.c working-2.5.7-pre1-bitops/fs/devfs/util.c
--- linux-2.5.7-pre1/fs/devfs/util.c	Wed Feb 20 17:55:34 2002
+++ working-2.5.7-pre1-bitops/fs/devfs/util.c	Sat Mar 16 13:12:36 2002
@@ -125,7 +125,7 @@
 struct major_list
 {
     spinlock_t lock;
-    __u32 bits[8];
+    unsigned long bits[256 / BITS_PER_LONG];
 };
 
 /*  Block majors already assigned:
@@ -212,7 +212,7 @@
 struct minor_list
 {
     int major;
-    __u32 bits[8];
+    unsigned long bits[256 / BITS_PER_LONG];
     struct minor_list *next;
 };
 
@@ -355,7 +355,7 @@
 {
     int number;
     unsigned int length;
-    __u32 *bits;
+    unsigned long *bits;
 
     /*  Get around stupid lack of semaphore initialiser  */
     spin_lock (&space->init_lock);
@@ -382,7 +382,7 @@
 	}
 	space->num_free = (length - space->length) << 3;
 	space->bits = bits;
-	memset (bits + space->length, 0, length - space->length);
+	memset ((void *)bits + space->length, 0, length - space->length);
 	space->length = length;
     }
     number = find_first_zero_bit (space->bits, space->length << 3);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.7-pre1/fs/open.c working-2.5.7-pre1-bitops/fs/open.c
--- linux-2.5.7-pre1/fs/open.c	Fri Mar  8 14:49:26 2002
+++ working-2.5.7-pre1-bitops/fs/open.c	Sat Mar 16 12:59:37 2002
@@ -704,7 +704,7 @@
 	write_lock(&files->file_lock);
 
 repeat:
- 	fd = find_next_zero_bit(files->open_fds, 
+ 	fd = find_next_zero_bit(files->open_fds->fds_bits, 
 				files->max_fdset, 
 				files->next_fd);
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.7-pre1/include/asm-i386/bitops.h working-2.5.7-pre1-bitops/include/asm-i386/bitops.h
--- linux-2.5.7-pre1/include/asm-i386/bitops.h	Sat Mar 16 13:03:31 2002
+++ working-2.5.7-pre1-bitops/include/asm-i386/bitops.h	Sat Mar 16 13:48:31 2002
@@ -34,7 +34,7 @@
  * Note that @nr may be almost arbitrarily large; this function is not
  * restricted to acting on a single-word quantity.
  */
-static __inline__ void set_bit(int nr, volatile void * addr)
+static __inline__ void set_bit(int nr, volatile unsigned long * addr)
 {
 	__asm__ __volatile__( LOCK_PREFIX
 		"btsl %1,%0"
@@ -51,7 +51,7 @@
  * If it's called on the same region of memory simultaneously, the effect
  * may be that only one operation succeeds.
  */
-static __inline__ void __set_bit(int nr, volatile void * addr)
+static __inline__ void __set_bit(int nr, volatile unsigned long * addr)
 {
 	__asm__(
 		"btsl %1,%0"
@@ -69,7 +69,7 @@
  * you should call smp_mb__before_clear_bit() and/or smp_mb__after_clear_bit()
  * in order to ensure changes are visible on other processors.
  */
-static __inline__ void clear_bit(int nr, volatile void * addr)
+static __inline__ void clear_bit(int nr, volatile unsigned long * addr)
 {
 	__asm__ __volatile__( LOCK_PREFIX
 		"btrl %1,%0"
@@ -77,7 +77,7 @@
 		:"Ir" (nr));
 }
 
-static __inline__ void __clear_bit(int nr, volatile void * addr)
+static __inline__ void __clear_bit(int nr, volatile unsigned long * addr)
 {
 	__asm__ __volatile__(
 		"btrl %1,%0"
@@ -96,7 +96,7 @@
  * If it's called on the same region of memory simultaneously, the effect
  * may be that only one operation succeeds.
  */
-static __inline__ void __change_bit(int nr, volatile void * addr)
+static __inline__ void __change_bit(int nr, volatile unsigned long * addr)
 {
 	__asm__ __volatile__(
 		"btcl %1,%0"
@@ -113,7 +113,7 @@
  * Note that @nr may be almost arbitrarily large; this function is not
  * restricted to acting on a single-word quantity.
  */
-static __inline__ void change_bit(int nr, volatile void * addr)
+static __inline__ void change_bit(int nr, volatile unsigned long * addr)
 {
 	__asm__ __volatile__( LOCK_PREFIX
 		"btcl %1,%0"
@@ -129,7 +129,7 @@
  * This operation is atomic and cannot be reordered.  
  * It also implies a memory barrier.
  */
-static __inline__ int test_and_set_bit(int nr, volatile void * addr)
+static __inline__ int test_and_set_bit(int nr, volatile unsigned long * addr)
 {
 	int oldbit;
 
@@ -149,7 +149,7 @@
  * If two examples of this operation race, one can appear to succeed
  * but actually fail.  You must protect multiple accesses with a lock.
  */
-static __inline__ int __test_and_set_bit(int nr, volatile void * addr)
+static __inline__ int __test_and_set_bit(int nr, volatile unsigned long * addr)
 {
 	int oldbit;
 
@@ -168,7 +168,7 @@
  * This operation is atomic and cannot be reordered.  
  * It also implies a memory barrier.
  */
-static __inline__ int test_and_clear_bit(int nr, volatile void * addr)
+static __inline__ int test_and_clear_bit(int nr, volatile unsigned long * addr)
 {
 	int oldbit;
 
@@ -188,7 +188,7 @@
  * If two examples of this operation race, one can appear to succeed
  * but actually fail.  You must protect multiple accesses with a lock.
  */
-static __inline__ int __test_and_clear_bit(int nr, volatile void * addr)
+static __inline__ int __test_and_clear_bit(int nr, volatile unsigned long *addr)
 {
 	int oldbit;
 
@@ -200,7 +200,7 @@
 }
 
 /* WARNING: non atomic and it can be reordered! */
-static __inline__ int __test_and_change_bit(int nr, volatile void * addr)
+static __inline__ int __test_and_change_bit(int nr, volatile unsigned long *addr)
 {
 	int oldbit;
 
@@ -219,7 +219,7 @@
  * This operation is atomic and cannot be reordered.  
  * It also implies a memory barrier.
  */
-static __inline__ int test_and_change_bit(int nr, volatile void * addr)
+static __inline__ int test_and_change_bit(int nr, volatile unsigned long* addr)
 {
 	int oldbit;
 
@@ -239,12 +239,12 @@
 static int test_bit(int nr, const volatile void * addr);
 #endif
 
-static __inline__ int constant_test_bit(int nr, const volatile void * addr)
+static __inline__ int constant_test_bit(int nr, const volatile unsigned long * addr)
 {
 	return ((1UL << (nr & 31)) & (((const volatile unsigned int *) addr)[nr >> 5])) != 0;
 }
 
-static __inline__ int variable_test_bit(int nr, volatile void * addr)
+static __inline__ int variable_test_bit(int nr, volatile unsigned long * addr)
 {
 	int oldbit;
 
@@ -268,7 +268,7 @@
  * Returns the bit-number of the first zero bit, not the number of the byte
  * containing a bit.
  */
-static __inline__ int find_first_zero_bit(void * addr, unsigned size)
+static __inline__ int find_first_zero_bit(unsigned long * addr, unsigned size)
 {
 	int d0, d1, d2;
 	int res;
@@ -300,7 +300,7 @@
  * Returns the bit-number of the first set bit, not the number of the byte
  * containing a bit.
  */
-static __inline__ int find_first_bit(void * addr, unsigned size)
+static __inline__ int find_first_bit(unsigned long * addr, unsigned size)
 {
 	int d0, d1;
 	int res;
@@ -326,7 +326,7 @@
  * @offset: The bitnumber to start searching at
  * @size: The maximum size to search
  */
-static __inline__ int find_next_zero_bit (void * addr, int size, int offset)
+static __inline__ int find_next_zero_bit(unsigned long * addr, int size, int offset)
 {
 	unsigned long * p = ((unsigned long *) addr) + (offset >> 5);
 	int set = 0, bit = offset & 31, res;
@@ -359,9 +359,9 @@
  * @offset: The bitnumber to start searching at
  * @size: The maximum size to search
  */
-static __inline__ int find_next_bit(void * addr, int size, int offset)
+static __inline__ int find_next_bit(unsigned long *addr, int size, int offset)
 {
-	unsigned long * p = ((unsigned long *) addr) + (offset >> 5);
+	unsigned long * p = addr + (offset >> 5);
 	int set = 0, bit = offset & 31, res;
 
 	if (bit) {
@@ -382,7 +382,7 @@
 	/*
 	 * No set bit yet, search remaining full words for a bit
 	 */
-	res = find_first_bit (p, size - 32 * (p - (unsigned long *) addr));
+	res = find_first_bit (p, size - 32 * (p - addr));
 	return (offset + set + res);
 }
 
@@ -469,18 +469,23 @@
 
 #ifdef __KERNEL__
 
-#define ext2_set_bit                 __test_and_set_bit
-#define ext2_clear_bit               __test_and_clear_bit
-#define ext2_test_bit                test_bit
-#define ext2_find_first_zero_bit     find_first_zero_bit
-#define ext2_find_next_zero_bit      find_next_zero_bit
+#define ext2_set_bit(nr,addr) \
+	__test_and_set_bit((nr),(unsigned long*)addr)
+#define ext2_clear_bit(nr, addr) \
+	__test_and_clear_bit((nr),(unsigned long*)addr)
+#define ext2_test_bit(nr, addr)      test_bit((nr),(unsigned long*)addr)
+#define ext2_find_first_zero_bit(addr, size) \
+	find_first_zero_bit((unsigned long*)addr, size)
+#define ext2_find_next_zero_bit(addr, size, off) \
+	find_next_zero_bit((unsigned long*)addr, size, off)
 
 /* Bitmap functions for the minix filesystem.  */
-#define minix_test_and_set_bit(nr,addr) __test_and_set_bit(nr,addr)
-#define minix_set_bit(nr,addr) __set_bit(nr,addr)
-#define minix_test_and_clear_bit(nr,addr) __test_and_clear_bit(nr,addr)
-#define minix_test_bit(nr,addr) test_bit(nr,addr)
-#define minix_find_first_zero_bit(addr,size) find_first_zero_bit(addr,size)
+#define minix_test_and_set_bit(nr,addr) __test_and_set_bit(nr,(void*)addr)
+#define minix_set_bit(nr,addr) __set_bit(nr,(void*)addr)
+#define minix_test_and_clear_bit(nr,addr) __test_and_clear_bit(nr,(void*)addr)
+#define minix_test_bit(nr,addr) test_bit(nr,(void*)addr)
+#define minix_find_first_zero_bit(addr,size) \
+	find_first_zero_bit((void*)addr,size)
 
 #endif /* __KERNEL__ */
 
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
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.7-pre1/include/asm-i386/pgtable.h working-2.5.7-pre1-bitops/include/asm-i386/pgtable.h
--- linux-2.5.7-pre1/include/asm-i386/pgtable.h	Sat Mar 16 13:27:33 2002
+++ working-2.5.7-pre1-bitops/include/asm-i386/pgtable.h	Sat Mar 16 13:48:37 2002
@@ -288,10 +288,10 @@
 static inline pte_t pte_mkyoung(pte_t pte)	{ (pte).pte_low |= _PAGE_ACCESSED; return pte; }
 static inline pte_t pte_mkwrite(pte_t pte)	{ (pte).pte_low |= _PAGE_RW; return pte; }
 
-static inline  int ptep_test_and_clear_dirty(pte_t *ptep)	{ return test_and_clear_bit(_PAGE_BIT_DIRTY, ptep); }
-static inline  int ptep_test_and_clear_young(pte_t *ptep)	{ return test_and_clear_bit(_PAGE_BIT_ACCESSED, ptep); }
-static inline void ptep_set_wrprotect(pte_t *ptep)		{ clear_bit(_PAGE_BIT_RW, ptep); }
-static inline void ptep_mkdirty(pte_t *ptep)			{ set_bit(_PAGE_BIT_DIRTY, ptep); }
+static inline  int ptep_test_and_clear_dirty(pte_t *ptep)	{ return test_and_clear_bit(_PAGE_BIT_DIRTY, &ptep->pte_low); }
+static inline  int ptep_test_and_clear_young(pte_t *ptep)	{ return test_and_clear_bit(_PAGE_BIT_ACCESSED, &ptep->pte_low); }
+static inline void ptep_set_wrprotect(pte_t *ptep)		{ clear_bit(_PAGE_BIT_RW, &ptep->pte_low); }
+static inline void ptep_mkdirty(pte_t *ptep)			{ set_bit(_PAGE_BIT_DIRTY, &ptep->pte_low); }
 
 /*
  * Conversion functions: convert a page and protection to a page entry,
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
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.7-pre1/include/asm-i386/thread_info.h working-2.5.7-pre1-bitops/include/asm-i386/thread_info.h
--- linux-2.5.7-pre1/include/asm-i386/thread_info.h	Sat Mar 16 13:03:31 2002
+++ working-2.5.7-pre1-bitops/include/asm-i386/thread_info.h	Sat Mar 16 13:46:30 2002
@@ -23,7 +23,7 @@
 struct thread_info {
 	struct task_struct	*task;		/* main task structure */
 	struct exec_domain	*exec_domain;	/* execution domain */
-	__u32			flags;		/* low level flags */
+	unsigned long		flags;		/* low level flags */
 	__u32			cpu;		/* current CPU */
 	__s32			preempt_count; /* 0 => preemptable, <0 => BUG */
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.7-pre1/include/asm-ppc/bitops.h working-2.5.7-pre1-bitops/include/asm-ppc/bitops.h
--- linux-2.5.7-pre1/include/asm-ppc/bitops.h	Fri Mar 15 13:00:59 2002
+++ working-2.5.7-pre1-bitops/include/asm-ppc/bitops.h	Sat Mar 16 12:59:37 2002
@@ -30,7 +30,7 @@
  * These used to be if'd out here because using : "cc" as a constraint
  * resulted in errors from egcs.  Things appear to be OK with gcc-2.95.
  */
-static __inline__ void set_bit(int nr, volatile void * addr)
+static __inline__ void set_bit(int nr, volatile unsigned long * addr)
 {
 	unsigned long old;
 	unsigned long mask = 1 << (nr & 0x1f);
@@ -50,7 +50,7 @@
 /*
  * non-atomic version
  */
-static __inline__ void __set_bit(int nr, volatile void *addr)
+static __inline__ void __set_bit(int nr, volatile unsigned long *addr)
 {
 	unsigned long mask = 1 << (nr & 0x1f);
 	unsigned long *p = ((unsigned long *)addr) + (nr >> 5);
@@ -64,7 +64,7 @@
 #define smp_mb__before_clear_bit()	smp_mb()
 #define smp_mb__after_clear_bit()	smp_mb()
 
-static __inline__ void clear_bit(int nr, volatile void *addr)
+static __inline__ void clear_bit(int nr, volatile unsigned long *addr)
 {
 	unsigned long old;
 	unsigned long mask = 1 << (nr & 0x1f);
@@ -84,7 +84,7 @@
 /*
  * non-atomic version
  */
-static __inline__ void __clear_bit(int nr, volatile void *addr)
+static __inline__ void __clear_bit(int nr, volatile unsigned long *addr)
 {
 	unsigned long mask = 1 << (nr & 0x1f);
 	unsigned long *p = ((unsigned long *)addr) + (nr >> 5);
@@ -92,7 +92,7 @@
 	*p &= ~mask;
 }
 
-static __inline__ void change_bit(int nr, volatile void *addr)
+static __inline__ void change_bit(int nr, volatile unsigned long *addr)
 {
 	unsigned long old;
 	unsigned long mask = 1 << (nr & 0x1f);
@@ -112,7 +112,7 @@
 /*
  * non-atomic version
  */
-static __inline__ void __change_bit(int nr, volatile void *addr)
+static __inline__ void __change_bit(int nr, volatile unsigned long *addr)
 {
 	unsigned long mask = 1 << (nr & 0x1f);
 	unsigned long *p = ((unsigned long *)addr) + (nr >> 5);
@@ -123,7 +123,7 @@
 /*
  * test_and_*_bit do imply a memory barrier (?)
  */
-static __inline__ int test_and_set_bit(int nr, volatile void *addr)
+static __inline__ int test_and_set_bit(int nr, volatile unsigned long *addr)
 {
 	unsigned int old, t;
 	unsigned int mask = 1 << (nr & 0x1f);
@@ -146,7 +146,7 @@
 /*
  * non-atomic version
  */
-static __inline__ int __test_and_set_bit(int nr, volatile void *addr)
+static __inline__ int __test_and_set_bit(int nr, volatile unsigned long *addr)
 {
 	unsigned long mask = 1 << (nr & 0x1f);
 	unsigned long *p = ((unsigned long *)addr) + (nr >> 5);
@@ -156,7 +156,7 @@
 	return (old & mask) != 0;
 }
 
-static __inline__ int test_and_clear_bit(int nr, volatile void *addr)
+static __inline__ int test_and_clear_bit(int nr, volatile unsigned long *addr)
 {
 	unsigned int old, t;
 	unsigned int mask = 1 << (nr & 0x1f);
@@ -179,7 +179,7 @@
 /*
  * non-atomic version
  */
-static __inline__ int __test_and_clear_bit(int nr, volatile void *addr)
+static __inline__ int __test_and_clear_bit(int nr, volatile unsigned long *addr)
 {
 	unsigned long mask = 1 << (nr & 0x1f);
 	unsigned long *p = ((unsigned long *)addr) + (nr >> 5);
@@ -189,7 +189,7 @@
 	return (old & mask) != 0;
 }
 
-static __inline__ int test_and_change_bit(int nr, volatile void *addr)
+static __inline__ int test_and_change_bit(int nr, volatile unsigned long *addr)
 {
 	unsigned int old, t;
 	unsigned int mask = 1 << (nr & 0x1f);
@@ -212,7 +212,7 @@
 /*
  * non-atomic version
  */
-static __inline__ int __test_and_change_bit(int nr, volatile void *addr)
+static __inline__ int __test_and_change_bit(int nr, volatile unsigned long *addr)
 {
 	unsigned long mask = 1 << (nr & 0x1f);
 	unsigned long *p = ((unsigned long *)addr) + (nr >> 5);
@@ -222,7 +222,7 @@
 	return (old & mask) != 0;
 }
 
-static __inline__ int test_bit(int nr, __const__ volatile void *addr)
+static __inline__ int test_bit(int nr, __const__ volatile unsigned long *addr)
 {
 	__const__ unsigned int *p = (__const__ unsigned int *) addr;
 
@@ -230,7 +230,7 @@
 }
 
 /* Return the bit position of the most significant 1 bit in a word */
-static __inline__ int __ilog2(unsigned int x)
+static __inline__ int __ilog2(unsigned long x)
 {
 	int lz;
 
@@ -238,7 +238,7 @@
 	return 31 - lz;
 }
 
-static __inline__ int ffz(unsigned int x)
+static __inline__ int ffz(unsigned long x)
 {
 	if ((x = ~x) == 0)
 		return 32;
@@ -296,7 +296,7 @@
  * @offset: The bitnumber to start searching at
  * @size: The maximum size to search
  */
-static __inline__ unsigned long find_next_bit(void *addr,
+static __inline__ unsigned long find_next_bit(unsigned long *addr,
 	unsigned long size, unsigned long offset)
 {
 	unsigned int *p = ((unsigned int *) addr) + (offset >> 5);
@@ -353,7 +353,7 @@
 #define find_first_zero_bit(addr, size) \
 	find_next_zero_bit((addr), (size), 0)
 
-static __inline__ unsigned long find_next_zero_bit(void * addr,
+static __inline__ unsigned long find_next_zero_bit(unsigned long * addr,
 	unsigned long size, unsigned long offset)
 {
 	unsigned int * p = ((unsigned int *) addr) + (offset >> 5);
@@ -394,8 +394,8 @@
 
 #ifdef __KERNEL__
 
-#define ext2_set_bit(nr, addr)		__test_and_set_bit((nr) ^ 0x18, addr)
-#define ext2_clear_bit(nr, addr)	__test_and_clear_bit((nr) ^ 0x18, addr)
+#define ext2_set_bit(nr, addr)	__test_and_set_bit((nr) ^ 0x18, (unsigned long *)(addr))
+#define ext2_clear_bit(nr, addr) __test_and_clear_bit((nr) ^ 0x18, (unsigned long *)(addr))
 
 static __inline__ int ext2_test_bit(int nr, __const__ void * addr)
 {
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.7-pre1/include/linux/devfs_fs_kernel.h working-2.5.7-pre1-bitops/include/linux/devfs_fs_kernel.h
--- linux-2.5.7-pre1/include/linux/devfs_fs_kernel.h	Fri Mar 15 15:37:39 2002
+++ working-2.5.7-pre1-bitops/include/linux/devfs_fs_kernel.h	Sat Mar 16 13:54:53 2002
@@ -54,7 +54,7 @@
     unsigned char sem_initialised;
     unsigned int num_free;          /*  Num free in bits       */
     unsigned int length;            /*  Array length in bytes  */
-    __u32 *bits;
+    unsigned long *bits;
     struct semaphore semaphore;
 };
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.7-pre1/include/linux/hfs_sysdep.h working-2.5.7-pre1-bitops/include/linux/hfs_sysdep.h
--- linux-2.5.7-pre1/include/linux/hfs_sysdep.h	Fri Mar 15 13:32:10 2002
+++ working-2.5.7-pre1-bitops/include/linux/hfs_sysdep.h	Sat Mar 16 12:59:37 2002
@@ -200,16 +200,16 @@
 #endif
 
 static inline int hfs_clear_bit(int bitnr, hfs_u32 *lword) {
-	return test_and_clear_bit(BITNR(bitnr), lword);
+	return test_and_clear_bit(BITNR(bitnr), (unsigned long *)lword);
 }
 
 static inline int hfs_set_bit(int bitnr, hfs_u32 *lword) {
-	return test_and_set_bit(BITNR(bitnr), lword);
+	return test_and_set_bit(BITNR(bitnr), (unsigned long *)lword);
 }
 
 static inline int hfs_test_bit(int bitnr, const hfs_u32 *lword) {
 	/* the kernel should declare the second arg of test_bit as const */
-	return test_bit(BITNR(bitnr), (void *)lword);
+	return test_bit(BITNR(bitnr), (unsigned long *)lword);
 }
 
 #undef BITNR
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.7-pre1/include/linux/sunrpc/svcsock.h working-2.5.7-pre1-bitops/include/linux/sunrpc/svcsock.h
--- linux-2.5.7-pre1/include/linux/sunrpc/svcsock.h	Fri Mar 15 13:07:05 2002
+++ working-2.5.7-pre1-bitops/include/linux/sunrpc/svcsock.h	Sat Mar 16 12:59:37 2002
@@ -22,7 +22,7 @@
 
 	struct svc_serv *	sk_server;	/* service for this socket */
 	unsigned char		sk_inuse;	/* use count */
-	unsigned int		sk_flags;
+	unsigned long		sk_flags;
 #define	SK_BUSY		0			/* enqueued/receiving */
 #define	SK_CONN		1			/* conn pending */
 #define	SK_CLOSE	2			/* dead or dying */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.7-pre1/kernel/sched.c working-2.5.7-pre1-bitops/kernel/sched.c
--- linux-2.5.7-pre1/kernel/sched.c	Wed Mar 13 13:30:39 2002
+++ working-2.5.7-pre1-bitops/kernel/sched.c	Sat Mar 16 12:59:37 2002
@@ -1451,8 +1451,10 @@
 	set_tsk_need_resched(idle);
 	__restore_flags(flags);
 
+#ifdef CONFIG_PREEMPT
 	/* Set the preempt count _outside_ the spinlocks! */
 	idle->thread_info->preempt_count = (idle->lock_depth >= 0);
+#endif
 }
 
 extern void init_timervecs(void);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.7-pre1/mm/swapfile.c working-2.5.7-pre1-bitops/mm/swapfile.c
--- linux-2.5.7-pre1/mm/swapfile.c	Fri Mar  8 14:49:30 2002
+++ working-2.5.7-pre1-bitops/mm/swapfile.c	Sat Mar 16 12:59:37 2002
@@ -959,7 +959,7 @@
 		p->lowest_bit = 0;
 		p->highest_bit = 0;
 		for (i = 1 ; i < 8*PAGE_SIZE ; i++) {
-			if (test_bit(i,(char *) swap_header)) {
+			if (test_bit(i,(unsigned long *) swap_header)) {
 				if (!p->lowest_bit)
 					p->lowest_bit = i;
 				p->highest_bit = i;
@@ -974,7 +974,7 @@
 			goto bad_swap;
 		}
 		for (i = 1 ; i < maxpages ; i++) {
-			if (test_bit(i,(char *) swap_header))
+			if (test_bit(i,(unsigned long *) swap_header))
 				p->swap_map[i] = 0;
 			else
 				p->swap_map[i] = SWAP_MAP_BAD;
