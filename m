Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129387AbRAHVAG>; Mon, 8 Jan 2001 16:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131200AbRAHU74>; Mon, 8 Jan 2001 15:59:56 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:26 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129387AbRAHU7x>; Mon, 8 Jan 2001 15:59:53 -0500
Date: Mon, 8 Jan 2001 22:00:03 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: [PATCH,serious] Fix raid5 crashes in 2.4.0
Message-ID: <20010108220003.U27646@athlon.random>
In-Reply-To: <20010108181625.A11766@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010108181625.A11766@gruyere.muc.suse.de>; from ak@suse.de on Mon, Jan 08, 2001 at 06:16:25PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 06:16:25PM +0100, Andi Kleen wrote:
> 
> Hallo Linus,
> 
> The following patch fixes an oops in 2.4.0 RAID5 initialisation when the kernel
> was configured without CONFIG_X86_FXSR but is booted on a CPU supporting SSE. 
> The problem is that without the FXSR config the OSFXSR flag is not set during
> bootup, which causes any operation referencing XMM registers to fault. The 
> raid code only checks for XMM support though, but not if FXSR support is enabled.
> The sse2 code would oops while it's do its speed benchmarks, which happens at boot
> when RAID5 is compiled in.
> This patch just makes the SSE2 code conditional on CONFIG_X86_FXSR||
> CONFIG_X86_RUNTIME_FXSR
> 
> I think it would impact CD users when their kernel doesn't boot because of this. 
> It happened on several machines at SuSE.
> Please consider it for 2.4.1.

Below there's a fix that I much prefer (makes fxsr always dynamic and it allows
it to be disabled via kernel param for asymetric MP), forward ported stright
from the PIII patch in 2.2.19pre6aa1. Only sfence remains a compile option for
performance reasons and it's defined for Athlon too indeed (but see below for
the usage of the compile option sfence information).

diff -urN -X /home/andrea/bin/dontdiff 2.4.0ac3/arch/i386/config.in 2.4.0ac3-fxsr/arch/i386/config.in
--- 2.4.0ac3/arch/i386/config.in	Mon Jan  8 02:06:15 2001
+++ 2.4.0ac3-fxsr/arch/i386/config.in	Mon Jan  8 06:03:40 2001
@@ -33,7 +33,7 @@
 	 Pentium-Classic		CONFIG_M586TSC \
 	 Pentium-MMX			CONFIG_M586MMX \
 	 Pentium-Pro/Celeron/Pentium-II	CONFIG_M686 \
-	 Pentium-III			CONFIG_M686FXSR \
+	 Pentium-III			CONFIG_MPENTIUMIII \
 	 Pentium-4			CONFIG_MPENTIUM4 \
 	 K6/K6-II/K6-III		CONFIG_MK6 \
 	 Athlon/K7			CONFIG_MK7 \
@@ -45,7 +45,7 @@
 # Define implied options from the CPU selection here
 #
 
-unset CONFIG_X86_FXSR
+unset CONFIG_X86_SFENCE
 
 if [ "$CONFIG_M386" = "y" ]; then
    define_bool CONFIG_X86_CMPXCHG n
@@ -87,14 +87,13 @@
    define_bool CONFIG_X86_PGE y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
 fi
-if [ "$CONFIG_M686FXSR" = "y" ]; then
+if [ "$CONFIG_MPENTIUMIII" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
    define_bool CONFIG_X86_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_PGE y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
-   define_bool CONFIG_X86_FXSR y
-   define_bool CONFIG_X86_XMM y
+   define_bool CONFIG_X86_SFENCE y
 fi
 if [ "$CONFIG_MPENTIUM4" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 7
@@ -102,8 +101,7 @@
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_PGE y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
-   define_bool CONFIG_X86_FXSR y
-   define_bool CONFIG_X86_XMM y
+   define_bool CONFIG_X86_SFENCE y
 fi
 if [ "$CONFIG_MK6" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
@@ -118,6 +116,7 @@
    define_bool CONFIG_X86_USE_3DNOW y
    define_bool CONFIG_X86_PGE y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
+   define_bool CONFIG_X86_SFENCE y
 fi
 if [ "$CONFIG_MCRUSOE" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
@@ -158,9 +157,7 @@
    define_bool CONFIG_X86_PAE y
 fi
 
-if [ "$CONFIG_X86_FXSR" != "y" ]; then
-   bool 'Math emulation' CONFIG_MATH_EMULATION
-fi
+bool 'Math emulation' CONFIG_MATH_EMULATION
 bool 'MTRR (Memory Type Range Register) support' CONFIG_MTRR
 bool 'Symmetric multi-processing support' CONFIG_SMP
 if [ "$CONFIG_SMP" != "y" ]; then
diff -urN -X /home/andrea/bin/dontdiff 2.4.0ac3/arch/i386/kernel/i387.c 2.4.0ac3-fxsr/arch/i386/kernel/i387.c
--- 2.4.0ac3/arch/i386/kernel/i387.c	Tue Nov 28 18:39:59 2000
+++ 2.4.0ac3-fxsr/arch/i386/kernel/i387.c	Mon Jan  8 06:01:37 2001
@@ -18,14 +18,6 @@
 #include <asm/ptrace.h>
 #include <asm/uaccess.h>
 
-#if defined(CONFIG_X86_FXSR)
-#define HAVE_FXSR 1
-#elif defined(CONFIG_X86_RUNTIME_FXSR)
-#define HAVE_FXSR (cpu_has_fxsr)
-#else
-#define HAVE_FXSR 0
-#endif
-
 #ifdef CONFIG_MATH_EMULATION
 #define HAVE_HWFP (boot_cpu_data.hard_math)
 #else
@@ -35,13 +27,13 @@
 /*
  * The _current_ task is using the FPU for the first time
  * so initialize it and set the mxcsr to its default
- * value at reset if we support FXSR and then
+ * value at reset if we support XMM instructions and then
  * remeber the current task has used the FPU.
  */
 void init_fpu(void)
 {
 	__asm__("fninit");
-	if ( HAVE_FXSR )
+	if ( HAVE_XMM )
 		load_mxcsr(0x1f80);
 		
 	current->used_math = 1;
@@ -207,7 +199,7 @@
 
 void set_fpu_mxcsr( struct task_struct *tsk, unsigned short mxcsr )
 {
-	if ( HAVE_FXSR ) {
+	if ( HAVE_XMM ) {
 		tsk->thread.i387.fxsave.mxcsr = mxcsr;
 	}
 }
@@ -429,8 +421,9 @@
 int get_fpxregs( struct user_fxsr_struct *buf, struct task_struct *tsk )
 {
 	if ( HAVE_FXSR ) {
-		__copy_to_user( (void *)buf, &tsk->thread.i387.fxsave,
-				sizeof(struct user_fxsr_struct) );
+		if (__copy_to_user( (void *)buf, &tsk->thread.i387.fxsave,
+				    sizeof(struct user_fxsr_struct) ))
+			return -EFAULT;
 		return 0;
 	} else {
 		return -EIO;
diff -urN -X /home/andrea/bin/dontdiff 2.4.0ac3/arch/i386/kernel/setup.c 2.4.0ac3-fxsr/arch/i386/kernel/setup.c
--- 2.4.0ac3/arch/i386/kernel/setup.c	Tue Jan  2 17:41:12 2001
+++ 2.4.0ac3-fxsr/arch/i386/kernel/setup.c	Mon Jan  8 02:48:19 2001
@@ -147,6 +147,7 @@
 extern unsigned long cpu_khz;
 
 static int disable_x86_serial_nr __initdata = 1;
+int disable_x86_fxsr __initdata = 0;
 
 /*
  * This is set up by the setup-routine at boot-time
@@ -1795,6 +1796,13 @@
 	return 1;
 }
 __setup("serialnumber", x86_serial_nr_setup);
+
+int __init x86_fxsr_setup(char * s)
+{
+	disable_x86_fxsr = 1;
+	return 1;
+}
+__setup("nofxsr", x86_fxsr_setup);
 
 
 /* Standard macro to see if a specific flag is changeable */
diff -urN -X /home/andrea/bin/dontdiff 2.4.0ac3/include/asm-i386/bugs.h 2.4.0ac3-fxsr/include/asm-i386/bugs.h
--- 2.4.0ac3/include/asm-i386/bugs.h	Fri Jan  5 04:48:57 2001
+++ 2.4.0ac3-fxsr/include/asm-i386/bugs.h	Mon Jan  8 06:13:32 2001
@@ -66,6 +66,8 @@
  */
 static void __init check_fpu(void)
 {
+	extern int disable_x86_fxsr;
+
 	if (!boot_cpu_data.hard_math) {
 #ifndef CONFIG_MATH_EMULATION
 		printk(KERN_EMERG "No coprocessor found and no math emulation present.\n");
@@ -76,26 +78,26 @@
 	}
 
 /* Enable FXSR and company _before_ testing for FP problems. */
-#if defined(CONFIG_X86_FXSR) || defined(CONFIG_X86_RUNTIME_FXSR)
 	/*
 	 * Verify that the FXSAVE/FXRSTOR data will be 16-byte aligned.
 	 */
-	if (offsetof(struct task_struct, thread.i387.fxsave) & 15)
-		panic("Kernel compiled for PII/PIII+ with FXSR, data not 16-byte aligned!");
-
-	if (cpu_has_fxsr) {
-		printk(KERN_INFO "Enabling fast FPU save and restore... ");
-		set_in_cr4(X86_CR4_OSFXSR);
-		printk("done.\n");
+	if (offsetof(struct task_struct, thread.i387.fxsave) & 15) {
+		extern void __buggy_fxsr_alignment(void);
+		__buggy_fxsr_alignment();
 	}
-#endif
-#ifdef CONFIG_X86_XMM
-	if (cpu_has_xmm) {
-		printk(KERN_INFO "Enabling unmasked SIMD FPU exception support... ");
-		set_in_cr4(X86_CR4_OSXMMEXCPT);
-		printk("done.\n");
-	}
-#endif
+	if (!disable_x86_fxsr) {
+		if (cpu_has_fxsr) {
+			printk(KERN_INFO "Enabling fast FPU save and restore... ");
+			set_in_cr4(X86_CR4_OSFXSR);
+			printk("done.\n");
+		}
+		if (cpu_has_xmm) {
+			printk(KERN_INFO "Enabling unmasked SIMD FPU exception support... ");
+			set_in_cr4(X86_CR4_OSXMMEXCPT);
+			printk("done.\n");
+		}
+	} else
+		printk(KERN_INFO "Disabling fast FPU save and restore.\n");
 
 	/* Test for the divl bug.. */
 	__asm__("fninit\n\t"
@@ -202,14 +204,6 @@
 	    && boot_cpu_data.x86_model == 2
 	    && (boot_cpu_data.x86_mask < 6 || boot_cpu_data.x86_mask == 11))
 		panic("Kernel compiled for PMMX+, assumes a local APIC without the read-before-write bug!");
-#endif
-
-/*
- * If we configured ourselves for FXSR, we'd better have it.
- */
-#ifdef CONFIG_X86_FXSR
-	if (!cpu_has_fxsr)
-		panic("Kernel compiled for PII/PIII+, requires FXSR feature!");
 #endif
 }
 
diff -urN -X /home/andrea/bin/dontdiff 2.4.0ac3/include/asm-i386/i387.h 2.4.0ac3-fxsr/include/asm-i386/i387.h
--- 2.4.0ac3/include/asm-i386/i387.h	Fri Jan  5 19:16:36 2001
+++ 2.4.0ac3-fxsr/include/asm-i386/i387.h	Mon Jan  8 06:36:31 2001
@@ -50,10 +50,8 @@
 extern void set_fpu_mxcsr( struct task_struct *tsk, unsigned short mxcsr );
 
 #define load_mxcsr( val ) do { \
-	if ( cpu_has_xmm ) { \
-		unsigned long __mxcsr = ((unsigned long)(val) & 0xffff); \
-		asm volatile( "ldmxcsr %0" : : "m" (__mxcsr) ); \
-	} \
+	unsigned long __mxcsr = ((unsigned long)(val) & 0xffbf); \
+	asm volatile( "ldmxcsr %0" : : "m" (__mxcsr) ); \
 } while (0)
 
 /*
diff -urN -X /home/andrea/bin/dontdiff 2.4.0ac3/include/asm-i386/processor.h 2.4.0ac3-fxsr/include/asm-i386/processor.h
--- 2.4.0ac3/include/asm-i386/processor.h	Fri Jan  5 19:12:50 2001
+++ 2.4.0ac3-fxsr/include/asm-i386/processor.h	Mon Jan  8 06:32:58 2001
@@ -88,6 +88,8 @@
 #define cpu_has_fxsr	(test_bit(X86_FEATURE_FXSR, boot_cpu_data.x86_capability))
 #define cpu_has_xmm	(test_bit(X86_FEATURE_XMM,  boot_cpu_data.x86_capability))
 #define cpu_has_fpu	(test_bit(X86_FEATURE_FPU,  boot_cpu_data.x86_capability))
+#define HAVE_FXSR	(mmu_cr4_features & X86_CR4_OSFXSR)
+#define HAVE_XMM	(mmu_cr4_features & X86_CR4_OSXMMEXCPT)
 
 extern char ignore_irq13;
 
diff -urN -X /home/andrea/bin/dontdiff 2.4.0ac3/include/asm-i386/system.h 2.4.0ac3-fxsr/include/asm-i386/system.h
--- 2.4.0ac3/include/asm-i386/system.h	Mon Jan  8 02:06:21 2001
+++ 2.4.0ac3-fxsr/include/asm-i386/system.h	Mon Jan  8 06:32:58 2001
@@ -271,7 +271,7 @@
  * The Pentium III does add a real memory barrier with the
  * sfence instruction, so we use that where appropriate.
  */
-#ifndef CONFIG_X86_XMM
+#ifndef CONFIG_X86_SFENCE
 #define mb() 	__asm__ __volatile__ ("lock; addl $0,0(%%esp)": : :"memory")
 #else
 #define mb()	__asm__ __volatile__ ("sfence": : :"memory")
diff -urN -X /home/andrea/bin/dontdiff 2.4.0ac3/include/asm-i386/xor.h 2.4.0ac3-fxsr/include/asm-i386/xor.h
--- 2.4.0ac3/include/asm-i386/xor.h	Tue Nov 28 18:40:01 2000
+++ 2.4.0ac3-fxsr/include/asm-i386/xor.h	Mon Jan  8 06:02:30 2001
@@ -843,7 +843,7 @@
 	do {						\
 		xor_speed(&xor_block_8regs);		\
 		xor_speed(&xor_block_32regs);		\
-	        if (cpu_has_xmm)			\
+	        if (HAVE_XMM)				\
 			xor_speed(&xor_block_pIII_sse);	\
 	        if (md_cpu_has_mmx()) {			\
 	                xor_speed(&xor_block_pII_mmx);	\
@@ -855,4 +855,4 @@
    We may also be able to load into the L1 only depending on how the cpu
    deals with a load to a line that is being prefetched.  */
 #define XOR_SELECT_TEMPLATE(FASTEST) \
-	(cpu_has_xmm ? &xor_block_pIII_sse : FASTEST)
+	(HAVE_XMM ? &xor_block_pIII_sse : FASTEST)


mb() implemented as sfence in PIII and P4 and Athlon is wrong according to
24319102.pdf page 3-634. sfence is a plain wmb() and so it's useless in
write-back/write-through type of memory because the IA32 architecture always
enforces ordered writes (infact wmb() is always a no-op). It _only_ enforce
_ordering_ between writes. Nothing else.

	SFENCE
	Store Fence Opcode Instruction Description
	0F AE /7 SFENCE
		Guarantees that every store instruction that precedes in
		program order the store fence instruction is globally visible
		before any store instruction which follows the fence is
		globally visible.

Abusing the fact sfence is _maybe_ flushing the write buffer synchronously
without allowing the sfence to pass reads is wrong and it can break with any
other hardware implementation of the intel architecture 32bit that follows the
specifications strictly and it's not even obvious that reads can still pass
reads in the IA32 architecture (on IA32 we _only_ know that certainly nothing
can pass a write).

So this is an incremental fix that fixes the buggy usage of sfence in mb().

diff -urN -X /home/andrea/bin/dontdiff 2.4.0ac3-fxsr/arch/i386/config.in 2.4.0ac3-fxsr-sfence/arch/i386/config.in
--- 2.4.0ac3-fxsr/arch/i386/config.in	Mon Jan  8 21:43:16 2001
+++ 2.4.0ac3-fxsr-sfence/arch/i386/config.in	Mon Jan  8 21:46:47 2001
@@ -45,8 +45,6 @@
 # Define implied options from the CPU selection here
 #
 
-unset CONFIG_X86_SFENCE
-
 if [ "$CONFIG_M386" = "y" ]; then
    define_bool CONFIG_X86_CMPXCHG n
    define_int  CONFIG_X86_L1_CACHE_SHIFT 4
@@ -93,7 +91,6 @@
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_PGE y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
-   define_bool CONFIG_X86_SFENCE y
 fi
 if [ "$CONFIG_MPENTIUM4" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 7
@@ -101,7 +98,6 @@
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_PGE y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
-   define_bool CONFIG_X86_SFENCE y
 fi
 if [ "$CONFIG_MK6" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
@@ -116,7 +112,6 @@
    define_bool CONFIG_X86_USE_3DNOW y
    define_bool CONFIG_X86_PGE y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
-   define_bool CONFIG_X86_SFENCE y
 fi
 if [ "$CONFIG_MCRUSOE" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
diff -urN -X /home/andrea/bin/dontdiff 2.4.0ac3-fxsr/include/asm-i386/system.h 2.4.0ac3-fxsr-sfence/include/asm-i386/system.h
--- 2.4.0ac3-fxsr/include/asm-i386/system.h	Mon Jan  8 06:32:58 2001
+++ 2.4.0ac3-fxsr-sfence/include/asm-i386/system.h	Mon Jan  8 21:42:06 2001
@@ -267,15 +267,8 @@
  * I expect future Intel CPU's to have a weaker ordering,
  * but I'd also expect them to finally get their act together
  * and add some real memory barriers if so.
- *
- * The Pentium III does add a real memory barrier with the
- * sfence instruction, so we use that where appropriate.
  */
-#ifndef CONFIG_X86_SFENCE
 #define mb() 	__asm__ __volatile__ ("lock; addl $0,0(%%esp)": : :"memory")
-#else
-#define mb()	__asm__ __volatile__ ("sfence": : :"memory")
-#endif
 #define rmb()	mb()
 #define wmb()	__asm__ __volatile__ ("": : :"memory")
 
Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
