Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319262AbSH2Qmd>; Thu, 29 Aug 2002 12:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319261AbSH2Qmd>; Thu, 29 Aug 2002 12:42:33 -0400
Received: from ppp-217-133-223-7.dialup.tiscali.it ([217.133.223.7]:34961 "EHLO
	home.ldb.ods.org") by vger.kernel.org with ESMTP id <S319262AbSH2Ql6>;
	Thu, 29 Aug 2002 12:41:58 -0400
Subject: [PATCH 4/4] i386 usage of dynamic fixup and CPU selection
From: Luca Barbieri <ldb@ldb.ods.org>
To: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-+m0nd+6D+A8AWTOS4PUA"
X-Mailer: Ximian Evolution 1.0.5 
Date: 29 Aug 2002 18:46:10 +0200
Message-Id: <1030639570.1490.59.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+m0nd+6D+A8AWTOS4PUA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This is the final patch that makes the whole i386 tree take advantage of
the dynamic fixup and individual CPU selection features.

By applying the is_smp() one, the previous 3 patches and this one you
should get something that, in theory, should work.

Most changes are simple to understand and allow dynamic fixup to modify
the code to choose the fastest instructions for the processor.

Here is some explaination for the more unintuitive ones:

* 3dnow memcpy
- the non-movq function has been eliminated since movntq can be easily
converted to movq

* tsc
- CONFIG_X86_TSC is always defined to y (see CPU selection patch)
- rdtsc* is always available
- __rdtsc* should be used if the cpu_has_tsc is known to be true (saves
padding nops)
- If the processor doesn't support it it will be replaced by a call to a
function that emulates it with gettimeofday (however note that the
frequency is not currently the CPU one).

* f00f
- with this patch f00f becomes a cpu feature flag rather than a boolean

* spinlocks
- spin_(un)lock_string is removed since the BKL code no longer uses it

* dynamic_fixup_int3
- if int3 is disabled, it is the same as dynamic_fixup_int

* __cpu_...
- These macros don't assume anything based on config options. They are
mostly used to panic if the processor isn't among the ones selected
during configuration (note however that the kernel panics based on
features, not processor type, so some unselected processors might
actually work, but this of course isn't guaranteed).

* x86_64
- rdtsc usage and definitions in x86_64 are modified to use __rdtsc* for
consistency with i386

* smp
- The patch doesn't try very hard to speed up SMP kernels on UP machines
simply because doing so optimally is impossible. However, lock prefixes
are fixed if int3 use is enabled.

* 386
- The patch also doesn't try hard to make 386 kernels run optimally on
486+ because it's also impossible. However, invlpg is translated to a
call to a function that flush the whole tlb, so 486+s will at least
benefit from this.


Diffstat:
 arch/i386/lib/mmx.c                  |  107 -----------------------------------
 include/asm-i386/spinlock.h          |   67 +++++++--------------
 include/asm-i386/bugs.h              |   51 ++++++++++++----
 include/asm-i386/cpufeature.h        |   40 +++++++++++--
 arch/i386/lib/checksum.S             |   36 +++++------
 include/asm-i386/string.h            |   30 +++------
 include/asm-i386/checksum.h          |   25 +++++++-
 arch/i386/kernel/cpu/common.c        |   24 +++++--
 include/asm-i386/apic.h              |   23 +++++--
 include/asm-i386/msr.h               |   21 +++++-
 arch/i386/kernel/cpu/intel.c         |   21 ++++--
 include/asm-i386/io.h                |   20 ++----
 arch/i386/kernel/cpu/centaur.c       |   18 ++++-
 include/asm-i386/system.h            |   16 +++--
 include/asm-i386/processor.h         |   14 +---
 include/asm-i386/page.h              |   13 ----
 include/asm-i386/string-486.h        |   11 ---
 include/asm-i386/linkage.h           |   11 +++
 include/asm-x86_64/msr.h             |   10 ++-
 arch/i386/kernel/time.c              |   10 +--
 arch/i386/lib/memcpy.c               |    9 +-
 arch/i386/kernel/cpu/amd.c           |    9 ++
 include/asm-i386/timex.h             |    8 +-
 include/asm-i386/mmx.h               |    8 ++
 arch/x86_64/kernel/time.c            |    8 +-
 arch/i386/lib/delay.c                |    8 +-
 include/asm-i386/tlbflush.h          |    7 --
 include/asm-i386/atomic.h            |    7 ++
 include/asm-i386/bitops.h            |    6 +
 drivers/net/hamradio/soundmodem/sm.h |    4 -
 arch/x86_64/lib/delay.c              |    4 -
 arch/x86_64/kernel/smpboot.c         |    4 -
 arch/x86_64/kernel/apic.c            |    4 -
 arch/i386/mm/init.c                  |    4 -
 arch/i386/mm/fault.c                 |    4 -
 arch/i386/kernel/smpboot.c           |    4 -
 arch/i386/kernel/apic.c              |    4 -
 include/asm-i386/fixmap.h            |    2 
 drivers/net/hamradio/baycom_epp.c    |    2 
 drivers/input/joystick/analog.c      |    2 
 drivers/char/random.c                |    2 
 arch/i386/lib/Makefile               |    2 
 arch/i386/kernel/traps.c             |    2 
 arch/i386/kernel/i386_ksyms.c        |    2 
 arch/i386/kernel/cpu/proc.c          |    2 
 45 files changed, 347 insertions(+), 339 deletions(-)


diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_base/arch/i386/kernel/apic.c linux-2.5.32_final/arch/i386/kernel/apic.c
--- linux-2.5.32_base/arch/i386/kernel/apic.c	2002-08-27 21:27:33.000000000 +0200
+++ linux-2.5.32_final/arch/i386/kernel/apic.c	2002-08-28 04:43:52.000000000 +0200
@@ -885,7 +885,7 @@ int __init calibrate_APIC_clock(void)
 	 * We wrapped around just now. Let's start:
 	 */
 	if (cpu_has_tsc)
-		rdtscll(t1);
+		__rdtscll(t1);
 	tt1 = apic_read(APIC_TMCCT);
 
 	/*
@@ -896,7 +896,7 @@ int __init calibrate_APIC_clock(void)
 
 	tt2 = apic_read(APIC_TMCCT);
 	if (cpu_has_tsc)
-		rdtscll(t2);
+		__rdtscll(t2);
 
 	/*
 	 * The APIC bus clock counter is 32 bits only, it
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_base/arch/i386/kernel/cpu/amd.c linux-2.5.32_final/arch/i386/kernel/cpu/amd.c
--- linux-2.5.32_base/arch/i386/kernel/cpu/amd.c	2002-08-27 21:27:32.000000000 +0200
+++ linux-2.5.32_final/arch/i386/kernel/cpu/amd.c	2002-08-28 04:43:52.000000000 +0200
@@ -43,6 +43,8 @@ static void __init init_amd(struct cpuin
 	switch(c->x86)
 	{
 		case 5:
+			set_bit(X86_FEATURE_WANTS_686_CHECKSUM, c->x86_capability);
+			
 			if( c->x86_model < 6 )
 			{
 				/* Based on AMD doc 20734R - June 2000 */
@@ -68,10 +70,10 @@ static void __init init_amd(struct cpuin
 
 				n = K6_BUG_LOOP;
 				f_vide = vide;
-				rdtscl(d);
+				__rdtscl(d);
 				while (n--) 
 					f_vide();
-				rdtscl(d2);
+				__rdtscl(d2);
 				d = d2-d;
 				
 				/* Knock these two lines out if it debugs out ok */
@@ -149,6 +151,9 @@ static void __init init_amd(struct cpuin
 					set_bit(X86_FEATURE_XMM, c->x86_capability);
 				}
 			}
+
+			set_bit(X86_FEATURE_GOOD_APIC, c->x86_capability);
+			
 			break;
 
 	}
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_base/arch/i386/kernel/cpu/centaur.c linux-2.5.32_final/arch/i386/kernel/cpu/centaur.c
--- linux-2.5.32_base/arch/i386/kernel/cpu/centaur.c	2002-08-27 21:26:33.000000000 +0200
+++ linux-2.5.32_final/arch/i386/kernel/cpu/centaur.c	2002-08-28 04:43:52.000000000 +0200
@@ -3,9 +3,10 @@
 #include <linux/bitops.h>
 #include <asm/processor.h>
 #include <asm/msr.h>
+#include <asm/e820.h>
 #include "cpu.h"
 
-#ifdef CONFIG_X86_OOSTORE
+#ifdef CONFIG_X86_MAY_HAVE_OOSTORE
 
 static u32 __init power2(u32 x)
 {
@@ -290,7 +291,10 @@ static void __init init_centaur(struct c
 				fcr_clr=DPDC;
 				printk(KERN_NOTICE "Disabling bugged TSC.\n");
 				clear_bit(X86_FEATURE_TSC, c->x86_capability);
-#ifdef CONFIG_X86_OOSTORE
+#ifdef CONFIG_X86_MAY_HAVE_OOSTORE
+				set_bit(X86_FEATURE_OOSTORE, c->x86_capability);
+				set_bit(X86_FEATURE_NEEDS_SFENCE, c->x86_capability);	
+				
 				centaur_create_optimal_mcr();
 				/* Enable
 					write combining on non-stack, non-string
@@ -318,7 +322,10 @@ static void __init init_centaur(struct c
 				}
 				fcr_set=ECX8|DSMC|DTLOCK|EMMX|EBRPRED|ERETSTK|E2MMX|EAMD3D;
 				fcr_clr=DPDC;
-#ifdef CONFIG_X86_OOSTORE
+#ifdef CONFIG_X86_MAY_HAVE_OOSTORE
+				set_bit(X86_FEATURE_OOSTORE, c->x86_capability);
+				set_bit(X86_FEATURE_NEEDS_SFENCE, c->x86_capability);	
+				
 				winchip2_unprotect_mcr();
 				winchip2_create_optimal_mcr();
 				rdmsr(MSR_IDT_MCR_CTRL, lo, hi);
@@ -336,7 +343,10 @@ static void __init init_centaur(struct c
 				name="3";
 				fcr_set=ECX8|DSMC|DTLOCK|EMMX|EBRPRED|ERETSTK|E2MMX|EAMD3D;
 				fcr_clr=DPDC;
-#ifdef CONFIG_X86_OOSTORE
+#ifdef CONFIG_X86_MAY_HAVE_OOSTORE
+				set_bit(X86_FEATURE_OOSTORE, c->x86_capability);
+				set_bit(X86_FEATURE_NEEDS_SFENCE, c->x86_capability);	
+				
 				winchip2_unprotect_mcr();
 				winchip2_create_optimal_mcr();
 				rdmsr(MSR_IDT_MCR_CTRL, lo, hi);
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_base/arch/i386/kernel/cpu/common.c linux-2.5.32_final/arch/i386/kernel/cpu/common.c
--- linux-2.5.32_base/arch/i386/kernel/cpu/common.c	2002-08-27 21:26:32.000000000 +0200
+++ linux-2.5.32_final/arch/i386/kernel/cpu/common.c	2002-08-28 04:43:52.000000000 +0200
@@ -42,7 +42,6 @@ static int __init cachesize_setup(char *
 }
 __setup("cachesize=", cachesize_setup);
 
-#ifndef CONFIG_X86_TSC
 static int tsc_disable __initdata = 0;
 
 static int __init tsc_setup(char *str)
@@ -52,7 +51,6 @@ static int __init tsc_setup(char *str)
 }
 
 __setup("notsc", tsc_setup);
-#endif
 
 int __init get_model_name(struct cpuinfo_x86 *c)
 {
@@ -294,11 +292,26 @@ void __init identify_cpu(struct cpuinfo_
 	 */
 
 	/* TSC disabled? */
-#ifndef CONFIG_X86_TSC
 	if ( tsc_disable )
 		clear_bit(X86_FEATURE_TSC, c->x86_capability);
-#endif
 
+	/* Pentium and later do speculative loads */
+	if(c->x86 >= 5)
+		set_bit(X86_FEATURE_NEEDS_LFENCE, c->x86_capability);
+
+	if(c->x86 >= 6)
+		set_bit(X86_FEATURE_WANTS_686_CHECKSUM, c->x86_capability);
+	
+	/* Intel SSE-capable processors have all AMD MMX extensions */
+	if(test_bit(X86_FEATURE_XMM, c->x86_capability))
+		set_bit(X86_FEATURE_MMXEXT, c->x86_capability);
+
+	if(test_bit(X86_FEATURE_MMXEXT, c->x86_capability) || test_bit(X86_FEATURE_3DNOW, c->x86_capability))
+		set_bit(X86_FEATURE_WANTS_PREFETCH, c->x86_capability);
+
+	if(test_bit(X86_FEATURE_3DNOW, c->x86_capability))
+		set_bit(X86_FEATURE_WANTS_PREFETCHW, c->x86_capability);
+	
 	/* FXSR disabled? */
 	if (disable_x86_fxsr) {
 		clear_bit(X86_FEATURE_FXSR, c->x86_capability);
@@ -433,14 +446,13 @@ void __init cpu_init (void)
 
 	if (cpu_has_vme || cpu_has_tsc || cpu_has_de)
 		clear_in_cr4(X86_CR4_VME|X86_CR4_PVI|X86_CR4_TSD|X86_CR4_DE);
-#ifndef CONFIG_X86_TSC
+
 	if (tsc_disable && cpu_has_tsc) {
 		printk(KERN_NOTICE "Disabling TSC...\n");
 		/**** FIX-HPA: DOES THIS REALLY BELONG HERE? ****/
 		clear_bit(X86_FEATURE_TSC, boot_cpu_data.x86_capability);
 		set_in_cr4(X86_CR4_TSD);
 	}
-#endif
 
 	/*
 	 * Initialize the per-CPU GDT with the boot GDT,
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_base/arch/i386/kernel/cpu/intel.c linux-2.5.32_final/arch/i386/kernel/cpu/intel.c
--- linux-2.5.32_base/arch/i386/kernel/cpu/intel.c	2002-08-27 21:26:38.000000000 +0200
+++ linux-2.5.32_final/arch/i386/kernel/cpu/intel.c	2002-08-28 04:43:52.000000000 +0200
@@ -137,17 +137,18 @@ static void __init init_intel(struct cpu
 	char *p = NULL;
 	unsigned int l1i = 0, l1d = 0, l2 = 0, l3 = 0; /* Cache sizes */
 
-#ifdef CONFIG_X86_F00F_BUG
+#ifdef CONFIG_X86_MAY_HAVE_F00F_BUG
 	/*
 	 * All current models of Pentium and Pentium with MMX technology CPUs
 	 * have the F0 0F bug, which lets nonpriviledged users lock up the system.
 	 * Note that the workaround only should be initialized once...
 	 */
-	c->f00f_bug = 0;
+
 	if ( c->x86 == 5 ) {
 		static int f00f_workaround_enabled = 0;
 
-		c->f00f_bug = 1;
+		set_bit(X86_FEATURE_F00F_BUG, c->x86_capability);		
+		
 		if ( !f00f_workaround_enabled ) {
 			trap_init_f00f_bug();
 			printk(KERN_NOTICE "Intel Pentium with F0 0F bug - workaround enabled.\n");
@@ -222,9 +223,17 @@ static void __init init_intel(struct cpu
 		c->x86_cache_size = l2 ? l2 : (l1i+l1d);
 	}
 
-	/* SEP CPUID bug: Pentium Pro reports SEP but doesn't have it */
-	if ( c->x86 == 6 && c->x86_model < 3 && c->x86_mask < 3 )
-		clear_bit(X86_FEATURE_SEP, c->x86_capability);
+	if ( c->x86 == 6 && c->x86_model < 3 )
+	{
+		/* SEP CPUID bug: Pentium Pro reports SEP but doesn't have it */		
+		if(c->x86_mask < 3)
+			clear_bit(X86_FEATURE_SEP, c->x86_capability);
+
+		set_bit(X86_FEATURE_NEEDS_SFENCE, c->x86_capability);
+	}
+
+	if((c->x86 >= 6) || __cpu_has_mmx)
+		set_bit(X86_FEATURE_GOOD_APIC, c->x86_capability);
 	
 	/* Names for the Pentium II/Celeron processors 
 	   detectable only by also checking the cache size.
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_base/arch/i386/kernel/cpu/proc.c linux-2.5.32_final/arch/i386/kernel/cpu/proc.c
--- linux-2.5.32_base/arch/i386/kernel/cpu/proc.c	2002-08-27 21:27:31.000000000 +0200
+++ linux-2.5.32_final/arch/i386/kernel/cpu/proc.c	2002-08-28 04:43:52.000000000 +0200
@@ -88,7 +88,7 @@ static int show_cpuinfo(struct seq_file 
 			"flags\t\t:",
 		     c->fdiv_bug ? "yes" : "no",
 		     c->hlt_works_ok ? "no" : "yes",
-		     c->f00f_bug ? "yes" : "no",
+		     __cpu_has_f00f_bug ? "yes" : "no",
 		     c->coma_bug ? "yes" : "no",
 		     c->hard_math ? "yes" : "no",
 		     fpu_exception ? "yes" : "no",
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_base/arch/i386/kernel/i386_ksyms.c linux-2.5.32_final/arch/i386/kernel/i386_ksyms.c
--- linux-2.5.32_base/arch/i386/kernel/i386_ksyms.c	2002-08-27 21:26:42.000000000 +0200
+++ linux-2.5.32_final/arch/i386/kernel/i386_ksyms.c	2002-08-28 04:43:52.000000000 +0200
@@ -118,7 +118,7 @@ EXPORT_SYMBOL(pcibios_set_irq_routing);
 EXPORT_SYMBOL(pcibios_get_irq_routing_table);
 #endif
 
-#ifdef CONFIG_X86_USE_3DNOW
+#ifdef CONFIG_X86_MAY_HAVE_3DNOW
 EXPORT_SYMBOL(_mmx_memcpy);
 EXPORT_SYMBOL(mmx_clear_page);
 EXPORT_SYMBOL(mmx_copy_page);
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_base/arch/i386/kernel/smpboot.c linux-2.5.32_final/arch/i386/kernel/smpboot.c
--- linux-2.5.32_base/arch/i386/kernel/smpboot.c	2002-08-27 21:26:42.000000000 +0200
+++ linux-2.5.32_final/arch/i386/kernel/smpboot.c	2002-08-28 04:43:52.000000000 +0200
@@ -246,7 +246,7 @@ static void __init synchronize_tsc_bp (v
 		 */
 		atomic_inc(&tsc_count_start);
 
-		rdtscll(tsc_values[smp_processor_id()]);
+		__rdtscll(tsc_values[smp_processor_id()]);
 		/*
 		 * We clear the TSC in the last loop:
 		 */
@@ -318,7 +318,7 @@ static void __init synchronize_tsc_ap (v
 		while (atomic_read(&tsc_count_start) != num_booting_cpus())
 			mb();
 
-		rdtscll(tsc_values[smp_processor_id()]);
+		__rdtscll(tsc_values[smp_processor_id()]);
 		if (i == NR_LOOPS-1)
 			write_tsc(0, 0);
 
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_base/arch/i386/kernel/time.c linux-2.5.32_final/arch/i386/kernel/time.c
--- linux-2.5.32_base/arch/i386/kernel/time.c	2002-08-28 04:42:43.000000000 +0200
+++ linux-2.5.32_final/arch/i386/kernel/time.c	2002-08-28 04:43:52.000000000 +0200
@@ -86,13 +86,14 @@ extern unsigned long wall_jiffies;
 
 spinlock_t rtc_lock = SPIN_LOCK_UNLOCKED;
 
+#ifdef CONFIG_X86_MAY_HAVE_TSC
 static inline unsigned long do_fast_gettimeoffset(void)
 {
 	register unsigned long eax, edx;
 
 	/* Read the Time Stamp Counter */
 
-	rdtsc(eax,edx);
+	__rdtsc(eax,edx);
 
 	/* .. relative to previous jiffy (32 bits is enough) */
 	eax -= last_tsc_low;	/* tsc_low delta */
@@ -157,6 +158,7 @@ extern spinlock_t i8259A_lock;
  * comp.protocols.time.ntp!
  */
 
+#ifdef CONFIG_X86_MAY_NOT_HAVE_TSC
 static unsigned long do_slow_gettimeoffset(void)
 {
 	int count;
@@ -523,7 +525,7 @@ static void timer_interrupt(int irq, voi
 	
 		/* read Pentium cycle counter */
 
-		rdtscl(last_tsc_low);
+		__rdtscl(last_tsc_low);
 
 		spin_lock(&i8253_lock);
 		outb_p(0x00, 0x43);     /* latch the count ASAP */
@@ -619,12 +621,12 @@ static unsigned long __init calibrate_ts
 		unsigned long endlow, endhigh;
 		unsigned long count;
 
-		rdtsc(startlow,starthigh);
+		__rdtsc(startlow,starthigh);
 		count = 0;
 		do {
 			count++;
 		} while ((inb(0x61) & 0x20) == 0);
-		rdtsc(endlow,endhigh);
+		__rdtsc(endlow,endhigh);
 
 		last_tsc_low = endlow;
 
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_base/arch/i386/kernel/traps.c linux-2.5.32_final/arch/i386/kernel/traps.c
--- linux-2.5.32_base/arch/i386/kernel/traps.c	2002-08-28 04:42:43.000000000 +0200
+++ linux-2.5.32_final/arch/i386/kernel/traps.c	2002-08-28 04:43:52.000000000 +0200
@@ -790,7 +790,7 @@ asmlinkage void math_emulate(long arg)
 
 #endif /* CONFIG_MATH_EMULATION */
 
-#ifdef CONFIG_X86_F00F_BUG
+#ifdef CONFIG_X86_MAY_HAVE_F00F_BUG
 void __init trap_init_f00f_bug(void)
 {
 	__set_fixmap(FIX_F00F_IDT, __pa(&idt_table), PAGE_KERNEL_RO);
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_base/arch/i386/lib/checksum.S linux-2.5.32_final/arch/i386/lib/checksum.S
--- linux-2.5.32_base/arch/i386/lib/checksum.S	2002-08-27 21:26:38.000000000 +0200
+++ linux-2.5.32_final/arch/i386/lib/checksum.S	2002-08-28 04:43:52.000000000 +0200
@@ -27,7 +27,8 @@
 
 #include <linux/config.h>
 #include <asm/errno.h>
-				
+#include <linux/linkage.h>
+		
 /*
  * computes a partial checksum, e.g. for TCP/UDP fragments
  */
@@ -37,11 +38,10 @@ unsigned int csum_partial(const unsigned
  */
 		
 .text
-.align 4
-.globl csum_partial								
-		
-#ifndef CONFIG_X86_USE_PPRO_CHECKSUM
 
+	
+#ifdef CONFIG_X86_MAY_NOT_WANT_686_CHECKSUM
+		
 	  /*		
 	   * Experiments with Ethernet and SLIP connections show that buff
 	   * is aligned on either a 2-byte or 4-byte boundary.  We get at
@@ -49,7 +49,7 @@ unsigned int csum_partial(const unsigned
 	   * Fortunately, it is easy to convert 2-byte alignment to 4-byte
 	   * alignment for the unrolled loop.
 	   */		
-csum_partial:	
+ENTRY(csum_partial_non686)
 	pushl %esi
 	pushl %ebx
 	movl 20(%esp),%eax	# Function arg: unsigned int sum
@@ -115,11 +115,12 @@ csum_partial:	
 	popl %esi
 	ret
 
-#else
+#endif
 
+#ifdef CONFIG_X86_MAY_WANT_686_CHECKSUM
 /* Version for PentiumII/PPro */
 
-csum_partial:
+ENTRY(csum_partial_686)
 	pushl %esi
 	pushl %ebx
 	movl 20(%esp),%eax	# Function arg: unsigned int sum
@@ -214,9 +215,8 @@ csum_partial:
 	popl %ebx
 	popl %esi
 	ret
-				
 #endif
-
+			
 /*
 unsigned int csum_partial_copy_generic (const char *src, char *dst,
 				  int len, int sum, int *src_err_ptr, int *dst_err_ptr)
@@ -245,15 +245,12 @@ unsigned int csum_partial_copy_generic (
 	.long 9999b, 6002f	;	\
 	.previous
 
-.align 4
-.globl csum_partial_copy_generic
-				
-#ifndef CONFIG_X86_USE_PPRO_CHECKSUM
-
+#ifdef CONFIG_X86_MAY_NOT_WANT_686_CHECKSUM
+	
 #define ARGBASE 16		
 #define FP		12
 		
-csum_partial_copy_generic:
+ENTRY(csum_partial_copy_generic_non686)
 	subl  $4,%esp	
 	pushl %edi
 	pushl %esi
@@ -372,8 +369,10 @@ DST(	movb %cl, (%edi)	)
 	popl %ecx			# equivalent to addl $4,%esp
 	ret	
 
-#else
+#undef ARGBASE
+#endif
 
+#ifdef CONFIG_X86_MAY_WANT_686_CHECKSUM
 /* Version for PentiumII/PPro */
 
 #define ROUND1(x) \
@@ -388,7 +387,7 @@ DST(	movb %cl, (%edi)	)
 
 #define ARGBASE 12
 		
-csum_partial_copy_generic:
+ENTRY(csum_partial_copy_generic_686)
 	pushl %ebx
 	pushl %edi
 	pushl %esi
@@ -458,5 +457,4 @@ DST(	movb %dl, (%edi)         )
 				
 #undef ROUND
 #undef ROUND1		
-		
 #endif
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_base/arch/i386/lib/delay.c linux-2.5.32_final/arch/i386/lib/delay.c
--- linux-2.5.32_base/arch/i386/lib/delay.c	2002-08-27 21:26:40.000000000 +0200
+++ linux-2.5.32_final/arch/i386/lib/delay.c	2002-08-28 04:43:52.000000000 +0200
@@ -28,15 +28,15 @@ int x86_udelay_tsc = 0;		/* Delay via TS
  *	to have one that we trust.
  */
 
-static void __rdtsc_delay(unsigned long loops)
+static inline void __rdtsc_delay(unsigned long loops)
 {
 	unsigned long bclock, now;
 	
-	rdtscl(bclock);
+	__rdtscl(bclock);
 	do
 	{
 		rep_nop();
-		rdtscl(now);
+		__rdtscl(now);
 	} while ((now-bclock) < loops);
 }
 
@@ -44,7 +44,7 @@ static void __rdtsc_delay(unsigned long 
  *	Non TSC based delay loop for 386, 486, MediaGX
  */
  
-static void __loop_delay(unsigned long loops)
+static inline void __loop_delay(unsigned long loops)
 {
 	int d0;
 	__asm__ __volatile__(
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_base/arch/i386/lib/Makefile linux-2.5.32_final/arch/i386/lib/Makefile
--- linux-2.5.32_base/arch/i386/lib/Makefile	2002-08-27 21:26:33.000000000 +0200
+++ linux-2.5.32_final/arch/i386/lib/Makefile	2002-08-28 04:43:52.000000000 +0200
@@ -8,7 +8,7 @@ obj-y = checksum.o old-checksum.o delay.
 	usercopy.o getuser.o \
 	memcpy.o strstr.o
 
-obj-$(CONFIG_X86_USE_3DNOW) += mmx.o
+obj-$(CONFIG_X86_MAY_HAVE_3DNOW) += mmx.o
 obj-$(CONFIG_HAVE_DEC_LOCK) += dec_and_lock.o
 obj-$(CONFIG_DEBUG_IOVIRT)  += iodebug.o
 
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_base/arch/i386/lib/memcpy.c linux-2.5.32_final/arch/i386/lib/memcpy.c
--- linux-2.5.32_base/arch/i386/lib/memcpy.c	2002-08-27 21:27:32.000000000 +0200
+++ linux-2.5.32_final/arch/i386/lib/memcpy.c	2002-08-28 04:43:52.000000000 +0200
@@ -6,11 +6,10 @@
 
 void * memcpy(void * to, const void * from, size_t n)
 {
-#ifdef CONFIG_X86_USE_3DNOW
-	return __memcpy3d(to, from, n);
-#else
-	return __memcpy(to, from, n);
-#endif
+	if(cpu_has_3dnow)
+		return __memcpy3d(to, from, n);
+	else
+		return __memcpy(to, from, n);
 }
 
 void * memset(void * s, int c, size_t count)
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_base/arch/i386/lib/mmx.c linux-2.5.32_final/arch/i386/lib/mmx.c
--- linux-2.5.32_base/arch/i386/lib/mmx.c	2002-08-27 21:26:43.000000000 +0200
+++ linux-2.5.32_final/arch/i386/lib/mmx.c	2002-08-28 04:43:52.000000000 +0200
@@ -6,7 +6,6 @@
 #include <asm/i387.h>
 #include <asm/hardirq.h> 
 
-
 /*
  *	MMX 3DNow! library helper functions
  *
@@ -121,8 +120,6 @@ void *_mmx_memcpy(void *to, const void *
 	return p;
 }
 
-#ifdef CONFIG_MK7
-
 /*
  *	The K7 has streaming cache bypass load/store. The Cyrix III, K6 and
  *	other MMX using processors do not.
@@ -251,110 +248,6 @@ static void fast_copy_page(void *to, voi
 	kernel_fpu_end();
 }
 
-#else
-
-/*
- *	Generic MMX implementation without K7 specific streaming
- */
- 
-static void fast_clear_page(void *page)
-{
-	int i;
-	
-	kernel_fpu_begin();
-	
-	__asm__ __volatile__ (
-		"  pxor %%mm0, %%mm0\n" : :
-	);
-
-	for(i=0;i<4096/128;i++)
-	{
-		__asm__ __volatile__ (
-		"  movq %%mm0, (%0)\n"
-		"  movq %%mm0, 8(%0)\n"
-		"  movq %%mm0, 16(%0)\n"
-		"  movq %%mm0, 24(%0)\n"
-		"  movq %%mm0, 32(%0)\n"
-		"  movq %%mm0, 40(%0)\n"
-		"  movq %%mm0, 48(%0)\n"
-		"  movq %%mm0, 56(%0)\n"
-		"  movq %%mm0, 64(%0)\n"
-		"  movq %%mm0, 72(%0)\n"
-		"  movq %%mm0, 80(%0)\n"
-		"  movq %%mm0, 88(%0)\n"
-		"  movq %%mm0, 96(%0)\n"
-		"  movq %%mm0, 104(%0)\n"
-		"  movq %%mm0, 112(%0)\n"
-		"  movq %%mm0, 120(%0)\n"
-		: : "r" (page) : "memory");
-		page+=128;
-	}
-
-	kernel_fpu_end();
-}
-
-static void fast_copy_page(void *to, void *from)
-{
-	int i;
-	
-	
-	kernel_fpu_begin();
-
-	__asm__ __volatile__ (
-		"1: prefetch (%0)\n"
-		"   prefetch 64(%0)\n"
-		"   prefetch 128(%0)\n"
-		"   prefetch 192(%0)\n"
-		"   prefetch 256(%0)\n"
-		"2:  \n"
-		".section .fixup, \"ax\"\n"
-		"3: movw $0x1AEB, 1b\n"	/* jmp on 26 bytes */
-		"   jmp 2b\n"
-		".previous\n"
-		".section __ex_table,\"a\"\n"
-		"	.align 4\n"
-		"	.long 1b, 3b\n"
-		".previous"
-		: : "r" (from) );
-
-	for(i=0; i<4096/64; i++)
-	{
-		__asm__ __volatile__ (
-		"1: prefetch 320(%0)\n"
-		"2: movq (%0), %%mm0\n"
-		"   movq 8(%0), %%mm1\n"
-		"   movq 16(%0), %%mm2\n"
-		"   movq 24(%0), %%mm3\n"
-		"   movq %%mm0, (%1)\n"
-		"   movq %%mm1, 8(%1)\n"
-		"   movq %%mm2, 16(%1)\n"
-		"   movq %%mm3, 24(%1)\n"
-		"   movq 32(%0), %%mm0\n"
-		"   movq 40(%0), %%mm1\n"
-		"   movq 48(%0), %%mm2\n"
-		"   movq 56(%0), %%mm3\n"
-		"   movq %%mm0, 32(%1)\n"
-		"   movq %%mm1, 40(%1)\n"
-		"   movq %%mm2, 48(%1)\n"
-		"   movq %%mm3, 56(%1)\n"
-		".section .fixup, \"ax\"\n"
-		"3: movw $0x05EB, 1b\n"	/* jmp on 5 bytes */
-		"   jmp 2b\n"
-		".previous\n"
-		".section __ex_table,\"a\"\n"
-		"	.align 4\n"
-		"	.long 1b, 3b\n"
-		".previous"
-		: : "r" (from), "r" (to) : "memory");
-		from+=64;
-		to+=64;
-	}
-	kernel_fpu_end();
-}
-
-
-#endif
-
 /*
  *	Favour MMX for page clear and copy. 
  */
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_base/arch/i386/mm/fault.c linux-2.5.32_final/arch/i386/mm/fault.c
--- linux-2.5.32_base/arch/i386/mm/fault.c	2002-08-27 21:26:30.000000000 +0200
+++ linux-2.5.32_final/arch/i386/mm/fault.c	2002-08-28 04:43:52.000000000 +0200
@@ -286,11 +286,10 @@ bad_area:
 		return;
 	}
 
-#ifdef CONFIG_X86_F00F_BUG
 	/*
 	 * Pentium F0 0F C7 C8 bug workaround.
 	 */
-	if (boot_cpu_data.f00f_bug) {
+	if (cpu_has_f00f_bug) {
 		unsigned long nr;
 		
 		nr = (address - idt_descr.address) >> 3;
@@ -300,7 +299,6 @@ bad_area:
 			return;
 		}
 	}
-#endif
 
 no_context:
 	/* Are we prepared to handle this kernel fault?  */
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_base/arch/i386/mm/init.c linux-2.5.32_final/arch/i386/mm/init.c
--- linux-2.5.32_base/arch/i386/mm/init.c	2002-08-27 21:26:37.000000000 +0200
+++ linux-2.5.32_final/arch/i386/mm/init.c	2002-08-28 04:43:52.000000000 +0200
@@ -348,7 +348,7 @@ void __init paging_init(void)
 	 * We will bail out later - printk doesn't work right now so
 	 * the user would just see a hanging kernel.
 	 */
-	if (cpu_has_pae)
+	if (__cpu_has_pae)
 		set_in_cr4(X86_CR4_PAE);
 #endif
 	__flush_tlb_all();
@@ -457,7 +457,7 @@ void __init mem_init(void)
 	       );
 
 #if CONFIG_X86_PAE
-	if (!cpu_has_pae)
+	if (!__cpu_has_pae)
 		panic("cannot execute a PAE-enabled kernel on a PAE-less CPU!");
 #endif
 	if (boot_cpu_data.wp_works_ok < 0)
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_base/arch/x86_64/kernel/apic.c linux-2.5.32_final/arch/x86_64/kernel/apic.c
--- linux-2.5.32_base/arch/x86_64/kernel/apic.c	2002-08-27 21:26:35.000000000 +0200
+++ linux-2.5.32_final/arch/x86_64/kernel/apic.c	2002-08-28 04:43:52.000000000 +0200
@@ -870,7 +870,7 @@ int __init calibrate_APIC_clock(void)
 	 * We wrapped around just now. Let's start:
 	 */
 	if (cpu_has_tsc)
-		rdtscll(t1);
+		__rdtscll(t1);
 	tt1 = apic_read(APIC_TMCCT);
 
 	/*
@@ -881,7 +881,7 @@ int __init calibrate_APIC_clock(void)
 
 	tt2 = apic_read(APIC_TMCCT);
 	if (cpu_has_tsc)
-		rdtscll(t2);
+		__rdtscll(t2);
 
 	/*
 	 * The APIC bus clock counter is 32 bits only, it
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_base/arch/x86_64/kernel/smpboot.c linux-2.5.32_final/arch/x86_64/kernel/smpboot.c
--- linux-2.5.32_base/arch/x86_64/kernel/smpboot.c	2002-08-27 21:27:34.000000000 +0200
+++ linux-2.5.32_final/arch/x86_64/kernel/smpboot.c	2002-08-28 04:43:52.000000000 +0200
@@ -232,7 +232,7 @@ static void __init synchronize_tsc_bp (v
 		 */
 		atomic_inc(&tsc_count_start);
 
-		rdtscll(tsc_values[smp_processor_id()]);
+		__rdtscll(tsc_values[smp_processor_id()]);
 		/*
 		 * We clear the TSC in the last loop:
 		 */
@@ -298,7 +298,7 @@ static void __init synchronize_tsc_ap (v
 		atomic_inc(&tsc_count_start);
 		while (atomic_read(&tsc_count_start) != smp_num_cpus) mb();
 
-		rdtscll(tsc_values[smp_processor_id()]);
+		__rdtscll(tsc_values[smp_processor_id()]);
 		if (i == NR_LOOPS-1)
 			write_tsc(0, 0);
 
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_base/arch/x86_64/kernel/time.c linux-2.5.32_final/arch/x86_64/kernel/time.c
--- linux-2.5.32_base/arch/x86_64/kernel/time.c	2002-08-27 21:26:54.000000000 +0200
+++ linux-2.5.32_final/arch/x86_64/kernel/time.c	2002-08-28 04:43:52.000000000 +0200
@@ -88,7 +88,7 @@ inline unsigned long do_gettimeoffset(vo
 
 	/* Read the Time Stamp Counter */
 
-	rdtsc(eax,edx);
+	__rdtsc(eax,edx);
 
 	/* .. relative to previous jiffy (32 bits is enough) */
 	eax -= last_tsc_low;	/* tsc_low delta */
@@ -336,7 +336,7 @@ static void timer_interrupt(int irq, voi
 	
 		/* read Pentium cycle counter */
 
-		rdtscl(last_tsc_low);
+		__rdtscl(last_tsc_low);
 
 		spin_lock(&i8253_lock);
 		outb_p(0x00, 0x43);     /* latch the count ASAP */
@@ -435,12 +435,12 @@ static unsigned long __init calibrate_ts
 		unsigned int endlow, endhigh;
 		unsigned int count;
 
-		rdtsc(startlow,starthigh);
+		__rdtsc(startlow,starthigh);
 		count = 0;
 		do {
 			count++;
 		} while ((inb(0x61) & 0x20) == 0);
-		rdtsc(endlow,endhigh);
+		__rdtsc(endlow,endhigh);
 
 		last_tsc_low = endlow; 
 
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_base/arch/x86_64/lib/delay.c linux-2.5.32_final/arch/x86_64/lib/delay.c
--- linux-2.5.32_base/arch/x86_64/lib/delay.c	2002-08-27 21:26:40.000000000 +0200
+++ linux-2.5.32_final/arch/x86_64/lib/delay.c	2002-08-28 04:43:52.000000000 +0200
@@ -24,11 +24,11 @@ void __delay(unsigned long loops)
 #ifndef CONFIG_SIMNOW
 	unsigned long bclock, now;
 	
-	rdtscl(bclock);
+	__rdtscl(bclock);
 	do
 	{
 		rep_nop(); 
-		rdtscl(now);
+		__rdtscl(now);
 	}
 	while((now-bclock) < loops);
 #endif
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_base/drivers/char/random.c linux-2.5.32_final/drivers/char/random.c
--- linux-2.5.32_base/drivers/char/random.c	2002-08-27 21:26:33.000000000 +0200
+++ linux-2.5.32_final/drivers/char/random.c	2002-08-28 04:43:52.000000000 +0200
@@ -739,7 +739,7 @@ static void add_timer_randomness(struct 
 #if defined (__i386__) || defined (__x86_64__)
 	if (cpu_has_tsc) {
 		__u32 high;
-		rdtsc(time, high);
+		__rdtsc(time, high);
 		num ^= high;
 	} else {
 		time = jiffies;
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_base/drivers/input/joystick/analog.c linux-2.5.32_final/drivers/input/joystick/analog.c
--- linux-2.5.32_base/drivers/input/joystick/analog.c	2002-08-27 21:26:40.000000000 +0200
+++ linux-2.5.32_final/drivers/input/joystick/analog.c	2002-08-28 04:43:52.000000000 +0200
@@ -137,7 +137,7 @@ struct analog_port {
  */
 
 #ifdef __i386__
-#define GET_TIME(x)	do { if (cpu_has_tsc) rdtscl(x); else x = get_time_pit(); } while (0)
+#define GET_TIME(x)	do { if (cpu_has_tsc) __rdtscl(x); else x = get_time_pit(); } while (0)
 #define DELTA(x,y)	(cpu_has_tsc?((y)-(x)):((x)-(y)+((x)<(y)?1193180L/HZ:0)))
 #define TIME_NAME	(cpu_has_tsc?"TSC":"PIT")
 static unsigned int get_time_pit(void)
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_base/drivers/net/hamradio/baycom_epp.c linux-2.5.32_final/drivers/net/hamradio/baycom_epp.c
--- linux-2.5.32_base/drivers/net/hamradio/baycom_epp.c	2002-08-27 21:27:33.000000000 +0200
+++ linux-2.5.32_final/drivers/net/hamradio/baycom_epp.c	2002-08-28 04:43:52.000000000 +0200
@@ -812,7 +812,7 @@ static int receive(struct net_device *de
 #define GETTICK(x)                                                \
 ({                                                                \
 	if (cpu_has_tsc)                                          \
-		rdtscl(x);                                        \
+		__rdtscl(x);                                        \
 })
 #else /* __i386__ */
 #define GETTICK(x)
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_base/drivers/net/hamradio/soundmodem/sm.h linux-2.5.32_final/drivers/net/hamradio/soundmodem/sm.h
--- linux-2.5.32_base/drivers/net/hamradio/soundmodem/sm.h	2002-08-27 21:26:30.000000000 +0200
+++ linux-2.5.32_final/drivers/net/hamradio/soundmodem/sm.h	2002-08-28 04:43:52.000000000 +0200
@@ -305,9 +305,9 @@ static inline unsigned int lcm(unsigned 
 ({                                                                      \
 	if (cpu_has_tsc) {                                              \
 		unsigned int cnt1, cnt2;                                \
-		rdtscl(cnt1);                                           \
+		__rdtscl(cnt1);                                           \
 		cmd;                                                    \
-		rdtscl(cnt2);                                           \
+		__rdtscl(cnt2);                                           \
 		var = cnt2-cnt1;                                        \
 	} else {                                                        \
 		cmd;                                                    \
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_base/include/asm-i386/apic.h linux-2.5.32_final/include/asm-i386/apic.h
--- linux-2.5.32_base/include/asm-i386/apic.h	2002-08-27 21:27:33.000000000 +0200
+++ linux-2.5.32_final/include/asm-i386/apic.h	2002-08-28 04:44:09.000000000 +0200
@@ -6,6 +6,7 @@
 #include <asm/fixmap.h>
 #include <asm/apicdef.h>
 #include <asm/system.h>
+#include <asm/fixup.h>
 
 #ifdef CONFIG_X86_LOCAL_APIC
 
@@ -41,14 +42,26 @@ static __inline__ void apic_wait_icr_idl
 	do { } while ( apic_read( APIC_ICR ) & APIC_ICR_BUSY );
 }
 
-#ifdef CONFIG_X86_GOOD_APIC
-# define FORCE_READ_AROUND_WRITE 0
-# define apic_read_around(x)
-# define apic_write_around(x,y) apic_write((x),(y))
-#else
+#if defined(CONFIG_X86_MAY_HAVE_GOOD_APIC) && defined(CONFIG_X86_MAY_NOT_HAVE_GOOD_APIC)
+# define FORCE_READ_AROUND_WRITE 1
+# define apic_read_around(x) apic_read(x)
+
+/* The dummy "i" operand serves to generate an informative compiler
+   warning if the memory address happens to be non-constant */
+# define apic_write_around(reg, v)  \
+do { \
+	unsigned long __eax; \
+	asm volatile(dynamic_fixup_int3 asm_byte(DYNAMIC_FIXUP_INT3_APIC_WRITE) ".long %1" : "=a" (__eax), "=m" (*(volatile u32*)(__fix_to_virt(FIX_APIC_BASE)+(reg))) : "0" (v), "i" (__fix_to_virt(FIX_APIC_BASE)+(reg))); \
+} while(0)
+
+#elif defined(CONFIG_X86_MAY_NOT_HAVE_GOOD_APIC)
 # define FORCE_READ_AROUND_WRITE 1
 # define apic_read_around(x) apic_read(x)
 # define apic_write_around(x,y) apic_write_atomic((x),(y))
+#else
+# define FORCE_READ_AROUND_WRITE 0
+# define apic_read_around(x)
+# define apic_write_around(x,y) apic_write((x),(y))
 #endif
 
 static inline void ack_APIC_irq(void)
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_base/include/asm-i386/atomic.h linux-2.5.32_final/include/asm-i386/atomic.h
--- linux-2.5.32_base/include/asm-i386/atomic.h	2002-08-27 21:26:38.000000000 +0200
+++ linux-2.5.32_final/include/asm-i386/atomic.h	2002-08-28 04:43:52.000000000 +0200
@@ -2,6 +2,8 @@
 #define __ARCH_I386_ATOMIC__
 
 #include <linux/config.h>
+#include <linux/smp.h>
+#include <asm/fixup.h>
 
 /*
  * Atomic operations that C can't guarantee us.  Useful for
@@ -9,7 +11,12 @@
  */
 
 #ifdef CONFIG_SMP
+/* dynamic fixup will set nop or lock */
+#ifdef CONFIG_X86_DYNAMIC_FIXUP_INT3
+#define LOCK "int3 ; "
+#else
 #define LOCK "lock ; "
+#endif
 #else
 #define LOCK ""
 #endif
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_base/include/asm-i386/bitops.h linux-2.5.32_final/include/asm-i386/bitops.h
--- linux-2.5.32_base/include/asm-i386/bitops.h	2002-08-27 21:26:53.000000000 +0200
+++ linux-2.5.32_final/include/asm-i386/bitops.h	2002-08-28 04:43:52.000000000 +0200
@@ -7,6 +7,7 @@
 
 #include <linux/config.h>
 #include <linux/compiler.h>
+#include <asm/fixup.h>
 
 /*
  * These have to be done with inline assembly: that way the bit-setting
@@ -17,7 +18,12 @@
  */
 
 #ifdef CONFIG_SMP
+/* dynamic fixup will set nop or lock */
+#ifdef CONFIG_X86_DYNAMIC_FIXUP_INT3
+#define LOCK_PREFIX "int3 ; "
+#else
 #define LOCK_PREFIX "lock ; "
+#endif
 #else
 #define LOCK_PREFIX ""
 #endif
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_base/include/asm-i386/bugs.h linux-2.5.32_final/include/asm-i386/bugs.h
--- linux-2.5.32_base/include/asm-i386/bugs.h	2002-08-27 21:26:35.000000000 +0200
+++ linux-2.5.32_final/include/asm-i386/bugs.h	2002-08-28 04:43:52.000000000 +0200
@@ -159,6 +159,14 @@ static void __init check_popad(void)
  *   the need to do extra reads from the APIC.
 */
 
+static inline void cpu_feature_panic(char* str)
+{
+	panic("This machine lacks a processor feature that the current kernel was compiled to require: %s\n"
+	      "You should install an appropriate kernel from your distribution or recompile the kernel with support for this processor.\n"
+	      "Processor information: ", str);
+	print_cpu_info(&boot_cpu_data);
+}
+
 static void __init check_config(void)
 {
 /*
@@ -166,17 +174,22 @@ static void __init check_config(void)
  * i486+ only features! (WP works in supervisor mode and the
  * new "invlpg" and "bswap" instructions)
  */
-#if defined(CONFIG_X86_WP_WORKS_OK) || defined(CONFIG_X86_INVLPG) || defined(CONFIG_X86_BSWAP)
+#if defined(CONFIG_X86_WP_WORKS_OK) || defined(CONFIG_X86_BSWAP)
 	if (boot_cpu_data.x86 == 3)
-		panic("Kernel requires i486+ for 'invlpg' and other features");
+		cpu_feature_panic("486 processor");
 #endif
 
+#if !defined(CONFIG_X86_MARCH_386) && !defined(CONFIG_X86_MARCH_486) && !defined(CONFIG_X86_MARCH_586) && defined(CONFIG_X86_MARCH_686) 
+	if(boot_cpu_data.x86 < 6)
+		cpu_feature_panic("686 processor");
+#endif
+	
 /*
  * If we configured ourselves for a TSC, we'd better have one!
  */
-#ifdef CONFIG_X86_TSC
-	if (!cpu_has_tsc)
-		panic("Kernel compiled for Pentium+, requires TSC feature!");
+#if !defined(CONFIG_X86_MAY_NOT_HAVE_TSC)
+	if (!__cpu_has_tsc)
+		cpu_feature_panic("TSC");
 #endif
 
 /*
@@ -185,13 +198,27 @@ static void __init check_config(void)
  * integrated APIC (see 11AP erratum in "Pentium Processor
  * Specification Update").
  */
-#if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86_GOOD_APIC)
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL
-	    && cpu_has_apic
-	    && boot_cpu_data.x86 == 5
-	    && boot_cpu_data.x86_model == 2
-	    && (boot_cpu_data.x86_mask < 6 || boot_cpu_data.x86_mask == 11))
-		panic("Kernel compiled for PMMX+, assumes a local APIC without the read-before-write bug!");
+#if defined(CONFIG_X86_LOCAL_APIC) && !defined(CONFIG_X86_MAY_NOT_HAVE_GOOD_APIC)
+	if (!__cpu_has_good_apic)
+		cpu_feature_panic("local APIC without the read-before-write bug");
+#endif
+
+#if !defined(CONFIG_M686)
+	if(boot_cpu_data.x86_vendor == X86_VENDOR_INTEL
+	   && boot_cpu_data.x86 == 6
+	   && boot_cpu_data.x86_model <= 1
+		)
+		cpu_feature_panic("processor without out-of-order store bug");
+#endif
+
+#if !defined(CONFIG_X86_MAY_NOT_HAVE_3DNOW)
+	if(!__cpu_has_3dnow)
+		cpu_feature_panic("3DNow");
+#endif
+
+#if !defined(CONFIG_X86_MAY_NOT_HAVE_XMM2)
+	if(!__cpu_has_xmm2)
+		cpu_feature_panic("SSE2");
 #endif
 }
 
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_base/include/asm-i386/checksum.h linux-2.5.32_final/include/asm-i386/checksum.h
--- linux-2.5.32_base/include/asm-i386/checksum.h	2002-08-27 21:27:07.000000000 +0200
+++ linux-2.5.32_final/include/asm-i386/checksum.h	2002-08-28 04:43:52.000000000 +0200
@@ -2,6 +2,7 @@
 #define _I386_CHECKSUM_H
 
 #include <linux/in6.h>
+#include <asm/cpufeature.h>
 
 /*
  * computes the checksum of a memory block at buff, length len,
@@ -15,7 +16,16 @@
  *
  * it's best to have buff aligned on a 32-bit boundary
  */
-asmlinkage unsigned int csum_partial(const unsigned char * buff, int len, unsigned int sum);
+asmlinkage unsigned int csum_partial_686(const unsigned char * buff, int len, unsigned int sum);
+asmlinkage unsigned int csum_partial_non686(const unsigned char * buff, int len, unsigned int sum);
+
+static inline unsigned int csum_partial(const unsigned char * buff, int len, unsigned int sum)
+{
+	if(cpu_wants_686_checksum)
+		return csum_partial_686(buff, len, sum);
+	else
+		return csum_partial_non686(buff, len, sum);
+}
 
 /*
  * the same as csum_partial, but copies from src while it
@@ -25,9 +35,20 @@ asmlinkage unsigned int csum_partial(con
  * better 64-bit) boundary
  */
 
-asmlinkage unsigned int csum_partial_copy_generic( const char *src, char *dst, int len, int sum,
+asmlinkage unsigned int csum_partial_copy_generic_686( const char *src, char *dst, int len, int sum,
+						   int *src_err_ptr, int *dst_err_ptr);
+asmlinkage unsigned int csum_partial_copy_generic_non686( const char *src, char *dst, int len, int sum,
 						   int *src_err_ptr, int *dst_err_ptr);
 
+static inline unsigned int csum_partial_copy_generic( const char *src, char *dst, int len, int sum,
+						   int *src_err_ptr, int *dst_err_ptr)
+{
+	if(cpu_wants_686_checksum)
+		return csum_partial_copy_generic_686(src, dst, len, sum, src_err_ptr, dst_err_ptr);
+	else
+		return csum_partial_copy_generic_non686(src, dst, len, sum, src_err_ptr, dst_err_ptr);
+}
+
 /*
  *	Note: when you get a NULL pointer exception here this means someone
  *	passed in an incorrect kernel address to one of these functions.
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_base/include/asm-i386/cpufeature.h linux-2.5.32_final/include/asm-i386/cpufeature.h
--- linux-2.5.32_base/include/asm-i386/cpufeature.h	2002-08-27 21:26:36.000000000 +0200
+++ linux-2.5.32_final/include/asm-i386/cpufeature.h	2002-08-28 04:43:52.000000000 +0200
@@ -61,29 +61,57 @@
 #define X86_FEATURE_K6_MTRR	(3*32+ 1) /* AMD K6 nonstandard MTRRs */
 #define X86_FEATURE_CYRIX_ARR	(3*32+ 2) /* Cyrix ARRs (= MTRRs) */
 #define X86_FEATURE_CENTAUR_MCR	(3*32+ 3) /* Centaur MCRs (= MTRRs) */
-
+#define X86_FEATURE_NEEDS_LFENCE (3*32+ 4) /* Pentium or later */
+#define X86_FEATURE_NEEDS_SFENCE (3*32+ 5) /* Winchip OOStore or bad PPro */
+#define X86_FEATURE_OOSTORE	(3*32+ 6) /* Winchip OOStore */
+#define X86_FEATURE_WANTS_686_CHECKSUM	(3*32+ 7) /* 686 checksum */
+#define X86_FEATURE_WANTS_PREFETCH	(3*32+ 8) /* prefetch(nta) - doesn't matter which since it's trivially fixed up (use prefetchnta in asm code) */
+#define X86_FEATURE_WANTS_PREFETCHW	(3*32+ 9) /* write prefetch */
+#define X86_FEATURE_F00F_BUG	(3*32+ 10) /* Intel P5 lock cmpxchg8b bug */
+#define X86_FEATURE_GOOD_APIC	(3*32+ 11) /* Pentium or later */
 
 #define cpu_has(c, bit)		test_bit(bit, (c)->x86_capability)
 #define boot_cpu_has(bit)	test_bit(bit, boot_cpu_data.x86_capability)
 
-#define cpu_has_fpu		boot_cpu_has(X86_FEATURE_FPU)
+#define __cpu_has_fpu		boot_cpu_has(X86_FEATURE_FPU)
 #define cpu_has_vme		boot_cpu_has(X86_FEATURE_VME)
 #define cpu_has_de		boot_cpu_has(X86_FEATURE_DE)
 #define cpu_has_pse		boot_cpu_has(X86_FEATURE_PSE)
-#define cpu_has_tsc		boot_cpu_has(X86_FEATURE_TSC)
-#define cpu_has_pae		boot_cpu_has(X86_FEATURE_PAE)
+#define __cpu_has_tsc		boot_cpu_has(X86_FEATURE_TSC)
+#define __cpu_has_pae		boot_cpu_has(X86_FEATURE_PAE)
 #define cpu_has_pge		boot_cpu_has(X86_FEATURE_PGE)
 #define cpu_has_apic		boot_cpu_has(X86_FEATURE_APIC)
 #define cpu_has_mtrr		boot_cpu_has(X86_FEATURE_MTRR)
-#define cpu_has_mmx		boot_cpu_has(X86_FEATURE_MMX)
+#define __cpu_has_mmx		boot_cpu_has(X86_FEATURE_MMX)
 #define cpu_has_fxsr		boot_cpu_has(X86_FEATURE_FXSR)
-#define cpu_has_xmm		boot_cpu_has(X86_FEATURE_XMM)
+#define __cpu_has_xmm		boot_cpu_has(X86_FEATURE_XMM)
+#define __cpu_has_xmm2		boot_cpu_has(X86_FEATURE_XMM2)
 #define cpu_has_ht		boot_cpu_has(X86_FEATURE_HT)
 #define cpu_has_mp		boot_cpu_has(X86_FEATURE_MP)
+#define __cpu_has_mmxext	boot_cpu_has(X86_FEATURE_MMXEXT)
+#define __cpu_has_3dnow		boot_cpu_has(X86_FEATURE_3DNOW)
+#define __cpu_has_3dnowext	boot_cpu_has(X86_FEATURE_3DNOWEXT)
 #define cpu_has_k6_mtrr		boot_cpu_has(X86_FEATURE_K6_MTRR)
 #define cpu_has_cyrix_arr	boot_cpu_has(X86_FEATURE_CYRIX_ARR)
 #define cpu_has_centaur_mcr	boot_cpu_has(X86_FEATURE_CENTAUR_MCR)
 
+#define cpu_needs_lfence	boot_cpu_has(X86_FEATURE_NEEDS_LFENCE)
+#define cpu_needs_sfence	boot_cpu_has(X86_FEATURE_NEEDS_SFENCE)
+#define __cpu_has_oostore		boot_cpu_has(X86_FEATURE_OOSTORE)
+#define __cpu_wants_686_checksum	boot_cpu_has(X86_FEATURE_WANTS_686_CHECKSUM)
+#define __cpu_wants_prefetch	boot_cpu_has(X86_FEATURE_WANTS_PREFETCH)
+#define __cpu_wants_prefetchw	boot_cpu_has(X86_FEATURE_WANTS_PREFETCHW)
+#define __cpu_has_f00f_bug	boot_cpu_has(X86_FEATURE_F00F_BUG)
+#define __cpu_has_good_apic	boot_cpu_has(X86_FEATURE_GOOD_APIC)
+
+#ifdef CONFIG_X86_PAE
+#define cpu_uses_pae		1
+#else
+#define cpu_uses_pae		0
+#endif
+
+#include <asm/cpufeature_config.h>
+
 #endif /* __ASM_I386_CPUFEATURE_H */
 
 /* 
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_base/include/asm-i386/fixmap.h linux-2.5.32_final/include/asm-i386/fixmap.h
--- linux-2.5.32_base/include/asm-i386/fixmap.h	2002-08-27 21:26:32.000000000 +0200
+++ linux-2.5.32_final/include/asm-i386/fixmap.h	2002-08-28 04:43:52.000000000 +0200
@@ -62,7 +62,7 @@ enum fixed_addresses {
 	FIX_LI_PCIA,	/* Lithium PCI Bridge A */
 	FIX_LI_PCIB,	/* Lithium PCI Bridge B */
 #endif
-#ifdef CONFIG_X86_F00F_BUG
+#ifdef CONFIG_X86_MAY_HAVE_F00F_BUG
 	FIX_F00F_IDT,	/* Virtual mapping for IDT */
 #endif
 #ifdef CONFIG_HIGHMEM
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_base/include/asm-i386/io.h linux-2.5.32_final/include/asm-i386/io.h
--- linux-2.5.32_base/include/asm-i386/io.h	2002-08-27 21:26:42.000000000 +0200
+++ linux-2.5.32_final/include/asm-i386/io.h	2002-08-28 04:43:52.000000000 +0200
@@ -2,6 +2,7 @@
 #define _ASM_IO_H
 
 #include <linux/config.h>
+#include <asm/fixup.h>
 
 /*
  * This file contains the definitions for the x86 IO instructions
@@ -266,28 +267,23 @@ out:
  *	2. Accidentally out of order processors (PPro errata #51)
  */
  
-#if defined(CONFIG_X86_OOSTORE) || defined(CONFIG_X86_PPRO_FENCE)
+#if defined(CONFIG_X86_MAY_HAVE_OOSTORE) || defined(CONFIG_M686)
 
 static inline void flush_write_buffers(void)
 {
-	__asm__ __volatile__ ("lock; addl $0,0(%%esp)": : :"memory");
+	asm volatile(dynamic_fixup_int asm_byte(DYNAMIC_FIXUP_INT_IO_FENCE) asm_nop asm_nop);
 }
 
-#define dma_cache_inv(_start,_size)		flush_write_buffers()
-#define dma_cache_wback(_start,_size)		flush_write_buffers()
-#define dma_cache_wback_inv(_start,_size)	flush_write_buffers()
-
 #else
 
-/* Nothing to do */
-
-#define dma_cache_inv(_start,_size)		do { } while (0)
-#define dma_cache_wback(_start,_size)		do { } while (0)
-#define dma_cache_wback_inv(_start,_size)	do { } while (0)
-#define flush_write_buffers()
+#define flush_write_buffers() do {} while(0)
 
 #endif
 
+#define dma_cache_inv(_start,_size)		flush_write_buffers()
+#define dma_cache_wback(_start,_size)		flush_write_buffers()
+#define dma_cache_wback_inv(_start,_size)	flush_write_buffers()
+
 #endif /* __KERNEL__ */
 
 #ifdef SLOW_IO_BY_JUMPING
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_base/include/asm-i386/linkage.h linux-2.5.32_final/include/asm-i386/linkage.h
--- linux-2.5.32_base/include/asm-i386/linkage.h	2002-08-27 21:26:43.000000000 +0200
+++ linux-2.5.32_final/include/asm-i386/linkage.h	2002-08-28 04:43:52.000000000 +0200
@@ -4,9 +4,18 @@
 #define asmlinkage CPP_ASMLINKAGE __attribute__((regparm(0)))
 #define FASTCALL(x)	x __attribute__((regparm(3)))
 
-#ifdef CONFIG_X86_ALIGNMENT_16
+#ifdef CONFIG_X86_ALIGNMENT_32
+#define __ALIGN .align 32,0x90
+#define __ALIGN_STR ".align 32,0x90"
+#elif defined(CONFIG_X86_ALIGNMENT_16)
 #define __ALIGN .align 16,0x90
 #define __ALIGN_STR ".align 16,0x90"
+#elif defined(CONFIG_X86_ALIGNMENT_4)
+#define __ALIGN .align 4,0x90
+#define __ALIGN_STR ".align 4,0x90"
+#else
+#define __ALIGN
+#define __ALIGN_STR ""
 #endif
 
 #endif
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_base/include/asm-i386/mmx.h linux-2.5.32_final/include/asm-i386/mmx.h
--- linux-2.5.32_base/include/asm-i386/mmx.h	2002-08-27 21:26:43.000000000 +0200
+++ linux-2.5.32_final/include/asm-i386/mmx.h	2002-08-28 04:43:52.000000000 +0200
@@ -6,9 +6,15 @@
  */
 
 #include <linux/types.h>
- 
+
+#ifdef CONFIG_X86_MAY_HAVE_3DNOW
 extern void *_mmx_memcpy(void *to, const void *from, size_t size);
 extern void mmx_clear_page(void *page);
 extern void mmx_copy_page(void *to, void *from);
+#else
+#define _mmx_memcpy(...) 0
+#define mmx_clear_page(...) do {} while(0)
+#define mmx_copy_page(...) do {} while(0)
+#endif
 
 #endif
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_base/include/asm-i386/msr.h linux-2.5.32_final/include/asm-i386/msr.h
--- linux-2.5.32_base/include/asm-i386/msr.h	2002-08-27 21:26:32.000000000 +0200
+++ linux-2.5.32_final/include/asm-i386/msr.h	2002-08-28 04:43:52.000000000 +0200
@@ -17,15 +17,30 @@
 			  : /* no outputs */ \
 			  : "c" (msr), "a" (val1), "d" (val2))
 
-#define rdtsc(low,high) \
+#define __rdtsc(low,high) \
      __asm__ __volatile__("rdtsc" : "=a" (low), "=d" (high))
 
-#define rdtscl(low) \
+#define __rdtscl(low) \
      __asm__ __volatile__("rdtsc" : "=a" (low) : : "edx")
 
-#define rdtscll(val) \
+#define __rdtscll(val) \
      __asm__ __volatile__("rdtsc" : "=A" (val))
 
+#if defined(__KERNEL__) && defined(CONFIG_X86_MAY_NOT_HAVE_TSC)
+#define rdtsc(low,high) \
+     __asm__ __volatile__("rdtsc; .byte 0x86, 0x76, 0" /* nop */ : "=a" (low), "=d" (high))
+
+#define rdtscl(low) \
+     __asm__ __volatile__("rdtsc; .byte 0x86, 0x76, 0" /* nop */ : "=a" (low) : : "edx")
+
+#define rdtscll(val) \
+     __asm__ __volatile__("rdtsc; .byte 0x86, 0x76, 0" /* nop */ : "=A" (val))
+#else
+#define rdtsc(low, high) __rdtsc(low, high)
+#define rdtscl(low) __rdtscl(low)
+#define rdtscll(val) __rdtscll(val)
+#endif
+
 #define write_tsc(val1,val2) wrmsr(0x10, val1, val2)
 
 #define rdpmc(counter,low,high) \
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_base/include/asm-i386/page.h linux-2.5.32_final/include/asm-i386/page.h
--- linux-2.5.32_base/include/asm-i386/page.h	2002-08-27 21:26:36.000000000 +0200
+++ linux-2.5.32_final/include/asm-i386/page.h	2002-08-28 04:43:52.000000000 +0200
@@ -14,24 +14,15 @@
 
 #include <linux/config.h>
 
-#ifdef CONFIG_X86_USE_3DNOW
-
 #include <asm/mmx.h>
 
-#define clear_page(page)	mmx_clear_page((void *)(page))
-#define copy_page(to,from)	mmx_copy_page(to,from)
-
-#else
-
 /*
  *	On older X86 processors its not a win to use MMX here it seems.
  *	Maybe the K6-III ?
  */
  
-#define clear_page(page)	memset((void *)(page), 0, PAGE_SIZE)
-#define copy_page(to,from)	memcpy((void *)(to), (void *)(from), PAGE_SIZE)
-
-#endif
+#define clear_page(page)	do {if(cpu_has_3dnow) mmx_clear_page((void *)(page)); else memset((void *)(page), 0, PAGE_SIZE);} while(0)
+#define copy_page(to,from)	do {if(cpu_has_3dnow) mmx_copy_page((void *)(to), (void*)(from));  else memcpy((void *)(to), (void *)(from), PAGE_SIZE);} while(0)
 
 #define clear_user_page(page, vaddr, pg)	clear_page(page)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_base/include/asm-i386/processor.h linux-2.5.32_final/include/asm-i386/processor.h
--- linux-2.5.32_base/include/asm-i386/processor.h	2002-08-27 21:26:32.000000000 +0200
+++ linux-2.5.32_final/include/asm-i386/processor.h	2002-08-28 04:43:52.000000000 +0200
@@ -14,6 +14,7 @@
 #include <asm/types.h>
 #include <asm/sigcontext.h>
 #include <asm/cpufeature.h>
+#include <asm/bitops.h>
 #include <linux/cache.h>
 #include <linux/config.h>
 #include <linux/threads.h>
@@ -55,7 +56,6 @@ struct cpuinfo_x86 {
 	int 	x86_cache_size;  /* in KB - valid for CPUS which support this
 				    call  */
 	int	fdiv_bug;
-	int	f00f_bug;
 	int	coma_bug;
 	unsigned long loops_per_jiffy;
 } __attribute__((__aligned__(SMP_CACHE_BYTES)));
@@ -467,25 +467,19 @@ static inline void rep_nop(void)
 #define cpu_relax()	rep_nop()
 
 /* Prefetch instructions for Pentium III and AMD Athlon */
-#ifdef 	CONFIG_MPENTIUMIII
+#ifdef 	CONFIG_X86_MAY_WANT_PREFETCH
 
 #define ARCH_HAS_PREFETCH
 extern inline void prefetch(const void *x)
 {
 	__asm__ __volatile__ ("prefetchnta (%0)" : : "r"(x));
 }
+#endif
 
-#elif CONFIG_X86_USE_3DNOW
-
-#define ARCH_HAS_PREFETCH
+#ifdef 	CONFIG_X86_MAY_WANT_PREFETCHW
 #define ARCH_HAS_PREFETCHW
 #define ARCH_HAS_SPINLOCK_PREFETCH
 
-extern inline void prefetch(const void *x)
-{
-	 __asm__ __volatile__ ("prefetch (%0)" : : "r"(x));
-}
-
 extern inline void prefetchw(const void *x)
 {
 	 __asm__ __volatile__ ("prefetchw (%0)" : : "r"(x));
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_base/include/asm-i386/spinlock.h linux-2.5.32_final/include/asm-i386/spinlock.h
--- linux-2.5.32_base/include/asm-i386/spinlock.h	2002-08-27 21:26:37.000000000 +0200
+++ linux-2.5.32_final/include/asm-i386/spinlock.h	2002-08-28 04:43:52.000000000 +0200
@@ -1,10 +1,11 @@
 #ifndef __ASM_SPINLOCK_H
 #define __ASM_SPINLOCK_H
 
+#include <linux/config.h>
 #include <asm/atomic.h>
 #include <asm/rwlock.h>
 #include <asm/page.h>
-#include <linux/config.h>
+#include <asm/fixup.h>
 
 extern int printk(const char * fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
@@ -40,19 +41,7 @@ typedef struct {
  */
 
 #define spin_is_locked(x)	(*(volatile signed char *)(&(x)->lock) <= 0)
-#define spin_unlock_wait(x)	do { barrier(); } while(spin_is_locked(x))
-
-#define spin_lock_string \
-	"\n1:\t" \
-	"lock ; decb %0\n\t" \
-	"js 2f\n" \
-	LOCK_SECTION_START("") \
-	"2:\t" \
-	"cmpb $0,%0\n\t" \
-	"rep;nop\n\t" \
-	"jle 2b\n\t" \
-	"jmp 1b\n" \
-	LOCK_SECTION_END
+#define spin_unlock_wait(x)      	do { barrier(); } while(spin_is_locked(x))
 
 /*
  * This works. Despite all the confusion.
@@ -60,49 +49,28 @@ typedef struct {
  * (PPro errata 66, 92)
  */
  
-#if !defined(CONFIG_X86_OOSTORE) && !defined(CONFIG_X86_PPRO_FENCE)
-
-#define spin_unlock_string \
-	"movb $1,%0" \
-		:"=m" (lock->lock) : : "memory"
-
-
 static inline void _raw_spin_unlock(spinlock_t *lock)
 {
-#ifdef CONFIG_DEBUG_SPINLOCK
+#ifdef CONFIG_DEBUG_SPINLOCK	
 	if (lock->magic != SPINLOCK_MAGIC)
 		BUG();
 	if (!spin_is_locked(lock))
 		BUG();
 #endif
+
+#if !defined(CONFIG_X86_MAY_HAVE_OOSTORE) && !defined(CONFIG_M686)
 	__asm__ __volatile__(
-		spin_unlock_string
+		"movb $1, %0" \
+		:"=m" (lock->lock) : : "memory"
 	);
-}
-
-#else
-
-#define spin_unlock_string \
-	"xchgb %b0, %1" \
-		:"=q" (oldval), "=m" (lock->lock) \
-		:"0" (oldval) : "memory"
-
-static inline void _raw_spin_unlock(spinlock_t *lock)
-{
-	char oldval = 1;
-#ifdef CONFIG_DEBUG_SPINLOCK
-	if (lock->magic != SPINLOCK_MAGIC)
-		BUG();
-	if (!spin_is_locked(lock))
-		BUG();
-#endif
+#else	
 	__asm__ __volatile__(
-		spin_unlock_string
+		dynamic_fixup_int "movb %%dl, %0"
+		:"=m" (lock->lock) : : "memory", "edx"
 	);
+#endif	
 }
 
-#endif
-
 static inline int _raw_spin_trylock(spinlock_t *lock)
 {
 	char oldval;
@@ -124,7 +92,16 @@ printk("eip: %p\n", &&here);
 	}
 #endif
 	__asm__ __volatile__(
-		spin_lock_string
+		"\n1:\t" \
+		LOCK "decb %0\n\t" \
+		"js 2f\n" \
+		LOCK_SECTION_START("") \
+		"2:\t" \
+		"cmpb $0,%0\n\t" \
+		"rep;nop\n\t" \
+		"jle 2b\n\t" \
+		"jmp 1b\n" \
+		LOCK_SECTION_END
 		:"=m" (lock->lock) : : "memory");
 }
 
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_base/include/asm-i386/string-486.h linux-2.5.32_final/include/asm-i386/string-486.h
--- linux-2.5.32_base/include/asm-i386/string-486.h	2002-08-27 21:26:40.000000000 +0200
+++ linux-2.5.32_final/include/asm-i386/string-486.h	2002-08-28 04:43:52.000000000 +0200
@@ -350,8 +350,6 @@ return (to);
 
 #include <linux/config.h>
 
-#ifdef CONFIG_X86_USE_3DNOW
-
 #include <asm/mmx.h>
 
 /*
@@ -360,14 +358,14 @@ return (to);
 
 static inline void * __constant_memcpy3d(void * to, const void * from, size_t len)
 {
-	if (len < 512)
+	if (!cpu_has_3dnow || (len < 512))
 		return __memcpy_c(to, from, len);
 	return _mmx_memcpy(to, from, len);
 }
 
 static inline void *__memcpy3d(void *to, const void *from, size_t len)
 {
-	if(len < 512)
+	if(!cpu_has_3dnow || (len < 512))
 		return __memcpy_g(to, from, len);
 	return _mmx_memcpy(to, from, len);
 }
@@ -376,17 +374,12 @@ static inline void *__memcpy3d(void *to,
 (__builtin_constant_p(count) ? \
  __constant_memcpy3d((d),(s),(count)) : \
  __memcpy3d((d),(s),(count)))
- 
-#else /* CONFIG_X86_USE_3DNOW */
 
 /*
 **	Generic routines
 */
 

-#define memcpy(d, s, count) __memcpy(d, s, count)
-
-#endif /* CONFIG_X86_USE_3DNOW */ 
 

 extern void __struct_cpy_bug( void );
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_base/include/asm-i386/string.h linux-2.5.32_final/include/asm-i386/string.h
--- linux-2.5.32_base/include/asm-i386/string.h	2002-08-27 21:27:33.000000000 +0200
+++ linux-2.5.32_final/include/asm-i386/string.h	2002-08-28 04:43:52.000000000 +0200
@@ -12,6 +12,10 @@
  * Also, the byte strings actually work correctly. Forget
  * the i486 routines for now as they may be broken..
  */
+/*
+  If you enable this, make sure CONFIG_X86_MAY_WANT_STRING_486 and
+  CONFIG_X86_MAY_NOT_WANT_STRING_486 are optimally handled.
+*/  
 #if FIXED_486_STRING && defined(CONFIG_X86_USE_STRING_486)
 #include <asm/string-486.h>
 #else
@@ -285,9 +289,8 @@ __asm__ __volatile__( \
 
 #define __HAVE_ARCH_MEMCPY
 
-#ifdef CONFIG_X86_USE_3DNOW
-
 #include <asm/mmx.h>
+#include <asm/processor.h>
 
 /*
  *	This CPU favours 3DNow strongly (eg AMD Athlon)
@@ -295,16 +298,18 @@ __asm__ __volatile__( \
 
 static inline void * __constant_memcpy3d(void * to, const void * from, size_t len)
 {
-	if (len < 512)
+	if(!cpu_has_3dnow || (len < 512))
 		return __constant_memcpy(to, from, len);
-	return _mmx_memcpy(to, from, len);
+	else
+		return _mmx_memcpy(to, from, len);
 }
 
 static __inline__ void *__memcpy3d(void *to, const void *from, size_t len)
 {
-	if (len < 512)
+	if(!cpu_has_3dnow || (len < 512))
 		return __memcpy(to, from, len);
-	return _mmx_memcpy(to, from, len);
+	else
+		return _mmx_memcpy(to, from, len);
 }
 
 #define memcpy(t, f, n) \
@@ -312,19 +317,6 @@ static __inline__ void *__memcpy3d(void 
  __constant_memcpy3d((t),(f),(n)) : \
  __memcpy3d((t),(f),(n)))
 
-#else
-
-/*
- *	No 3D Now!
- */
- 
-#define memcpy(t, f, n) \
-(__builtin_constant_p(n) ? \
- __constant_memcpy((t),(f),(n)) : \
- __memcpy((t),(f),(n)))
-
-#endif
-
 /*
  * struct_cpy(x,y), copy structure *x into (matching structure) *y.
  *
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_base/include/asm-i386/system.h linux-2.5.32_final/include/asm-i386/system.h
--- linux-2.5.32_base/include/asm-i386/system.h	2002-08-27 21:26:31.000000000 +0200
+++ linux-2.5.32_final/include/asm-i386/system.h	2002-08-28 04:43:52.000000000 +0200
@@ -282,12 +282,18 @@ static inline unsigned long __cmpxchg(vo
  * Some non intel clones support out of order store. wmb() ceases to be a
  * nop for these.
  */
- 
-#define mb() 	__asm__ __volatile__ ("lock; addl $0,0(%%esp)": : :"memory")
-#define rmb()	mb()
 
-#ifdef CONFIG_X86_OOSTORE
-#define wmb() 	__asm__ __volatile__ ("lock; addl $0,0(%%esp)": : :"memory")
+#if !defined(CONFIG_X86_MAY_NOT_HAVE_XMM2)
+#define __mb_string
+#else
+#define __mb_string asm_nop asm_nop
+#endif
+
+#define mb()	__asm__ __volatile__ ("mfence" __mb_string : : :"memory")
+#define rmb()	__asm__ __volatile__ ("lfence" __mb_string : : :"memory")
+
+#if defined(CONFIG_X86_MAY_HAVE_OOSTORE)
+#define wmb() 	__asm__ __volatile__ (dynamic_fixup_int asm_byte(DYNAMIC_FIXUP_INT_SFENCE) asm_nop asm_nop : : :"memory")
 #else
 #define wmb()	__asm__ __volatile__ ("": : :"memory")
 #endif
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_base/include/asm-i386/timex.h linux-2.5.32_final/include/asm-i386/timex.h
--- linux-2.5.32_base/include/asm-i386/timex.h	2002-08-27 21:26:39.000000000 +0200
+++ linux-2.5.32_final/include/asm-i386/timex.h	2002-08-28 04:43:52.000000000 +0200
@@ -40,14 +40,14 @@ extern cycles_t cacheflush_time;
 
 static inline cycles_t get_cycles (void)
 {
-#ifndef CONFIG_X86_TSC
-	return 0;
-#else
 	unsigned long long ret;
 
+#ifdef __KERNEL__	
+	__asm__ __volatile__("rdtsc; nop" : "=A" (ret));
+#else
 	rdtscll(ret);
+#endif	
 	return ret;
-#endif
 }
 
 extern unsigned long cpu_khz;
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_base/include/asm-i386/tlbflush.h linux-2.5.32_final/include/asm-i386/tlbflush.h
--- linux-2.5.32_base/include/asm-i386/tlbflush.h	2002-08-27 21:26:41.000000000 +0200
+++ linux-2.5.32_final/include/asm-i386/tlbflush.h	2002-08-28 04:43:52.000000000 +0200
@@ -45,12 +45,9 @@ extern unsigned long pgkern_mask;
 			__flush_tlb();					\
 	} while (0)
 
-#ifndef CONFIG_X86_INVLPG
-#define __flush_tlb_one(addr) __flush_tlb()
-#else
+/* gets fixed up on 386 */
 #define __flush_tlb_one(addr) \
-__asm__ __volatile__("invlpg %0": :"m" (*(char *) addr))
-#endif
+	__asm__ __volatile__("invlpg %0": :"m" (*(char *) addr))
 
 /*
  * TLB flushing:
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_base/include/asm-x86_64/msr.h linux-2.5.32_final/include/asm-x86_64/msr.h
--- linux-2.5.32_base/include/asm-x86_64/msr.h	2002-08-27 21:27:31.000000000 +0200
+++ linux-2.5.32_final/include/asm-x86_64/msr.h	2002-08-28 04:43:52.000000000 +0200
@@ -43,18 +43,22 @@
 		     : "c" (msr), "0" ((__u32)val), "d" ((val)>>32), "i" (-EFAULT));\
 	ret__; })
 
-#define rdtsc(low,high) \
+#define __rdtsc(low,high) \
      __asm__ __volatile__("rdtsc" : "=a" (low), "=d" (high))
 
-#define rdtscl(low) \
+#define __rdtscl(low) \
      __asm__ __volatile__ ("rdtsc" : "=a" (low) : : "edx")
 
-#define rdtscll(val) do { \
+#define __rdtscll(val) do { \
      unsigned int a,d; \
      asm volatile("rdtsc" : "=a" (a), "=d" (d)); \
      (val) = ((unsigned long)a) | (((unsigned long)d)<<32); \
 } while(0)
 
+#define rdtsc(low,high) __rdtsc(low,high)
+#define rdtscl(low) __rdtscl(low)
+#define rdtscll(val) __rdtscll(val)
+
 #define rdpmc(counter,low,high) \
      __asm__ __volatile__("rdpmc" \
 			  : "=a" (low), "=d" (high) \


--=-+m0nd+6D+A8AWTOS4PUA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9bk/Sdjkty3ft5+cRAslMAKCvrbSweeHsTmiA7TxWnWHBa/F90gCePviA
rtUA5CTpPTCNNVq36aS3ZNA=
=J2tU
-----END PGP SIGNATURE-----

--=-+m0nd+6D+A8AWTOS4PUA--
