Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030208AbVHPQGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030208AbVHPQGg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 12:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030207AbVHPQGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 12:06:36 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:57352 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S1030208AbVHPQGf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 12:06:35 -0400
Date: Tue, 16 Aug 2005 11:42:01 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Zachary Amsden <zach@vmware.com>, linux-kernel@vger.kernel.org
Cc: Chris Wright <chrisw@osdl.org>, akpm@osdl.org, chrisl@vmware.com,
       pratap@vmware.com, virtualization@lists.osdl.org
Subject: [RFC] [PATCH] Split host arch headers for UML's benefit
Message-ID: <20050816154201.GA6733@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below fixes the recent UML compilation failure in -rc5-mm1
without making the UML build reach further into the i386 headers.  It
splits the i386 ptrace.h and system.h into UML-usable and UML-unusable
pieces.  

The string "abi" is in there because I did ptrace.h first, and that
involves separating the ptrace ABI stuff from everything else (if
pt_regs is not considered part of the abi).  However, the system.h
split is between random stuff that UML can use and random stuff that
it can't.  So, perhaps better names would be -uml or -userspace or
something.

This isolates UML somewhat from host header changes while allowing it
to reuse host stuff.  Build failures like the current one would be
less frequent.  It also allows UML headers to be cleaned up - see the
deletions from ptrace-generic.h and system-generic.h which used to
rename the stuff from the host headers which UML couldn't use.

ptrace.h and system.h are the two problem cases at the moment.  There
are others, but not a lot.  These two are the messiest ones.

Any arch which runs UML would need similar treatment - right now,
that's i386, x86_64, and s390.

				Jeff

Index: linux-2.6.13-rc5-mm1-abi/include/asm-i386/ptrace-abi.h
===================================================================
--- linux-2.6.13-rc5-mm1-abi.orig/include/asm-i386/ptrace-abi.h	2005-08-16 05:22:15.349927640 -0400
+++ linux-2.6.13-rc5-mm1-abi/include/asm-i386/ptrace-abi.h	2005-08-16 11:30:46.000000000 -0400
@@ -0,0 +1,36 @@
+#ifndef __PTRACE_ABI__
+#define __PTRACE_ABI__
+
+#define EBX 0
+#define ECX 1
+#define EDX 2
+#define ESI 3
+#define EDI 4
+#define EBP 5
+#define EAX 6
+#define DS 7
+#define ES 8
+#define FS 9
+#define GS 10
+#define ORIG_EAX 11
+#define EIP 12
+#define CS  13
+#define EFL 14
+#define UESP 15
+#define SS   16
+#define FRAME_SIZE 17
+
+/* Arbitrarily choose the same ptrace numbers as used by the Sparc code. */
+#define PTRACE_GETREGS            12
+#define PTRACE_SETREGS            13
+#define PTRACE_GETFPREGS          14
+#define PTRACE_SETFPREGS          15
+#define PTRACE_GETFPXREGS         18
+#define PTRACE_SETFPXREGS         19
+
+#define PTRACE_OLDSETOPTIONS         21
+
+#define PTRACE_GET_THREAD_AREA    25
+#define PTRACE_SET_THREAD_AREA    26
+
+#endif
Index: linux-2.6.13-rc5-mm1-abi/include/asm-i386/ptrace.h
===================================================================
--- linux-2.6.13-rc5-mm1-abi.orig/include/asm-i386/ptrace.h	2005-08-16 08:48:01.000000000 -0400
+++ linux-2.6.13-rc5-mm1-abi/include/asm-i386/ptrace.h	2005-08-16 11:03:34.000000000 -0400
@@ -1,24 +1,7 @@
 #ifndef _I386_PTRACE_H
 #define _I386_PTRACE_H
 
-#define EBX 0
-#define ECX 1
-#define EDX 2
-#define ESI 3
-#define EDI 4
-#define EBP 5
-#define EAX 6
-#define DS 7
-#define ES 8
-#define FS 9
-#define GS 10
-#define ORIG_EAX 11
-#define EIP 12
-#define CS  13
-#define EFL 14
-#define UESP 15
-#define SS   16
-#define FRAME_SIZE 17
+#include <asm/ptrace-abi.h>
 
 /* this struct defines the way the registers are stored on the 
    stack during a system call. */
@@ -41,19 +24,6 @@
 	int  xss;
 };
 
-/* Arbitrarily choose the same ptrace numbers as used by the Sparc code. */
-#define PTRACE_GETREGS            12
-#define PTRACE_SETREGS            13
-#define PTRACE_GETFPREGS          14
-#define PTRACE_SETFPREGS          15
-#define PTRACE_GETFPXREGS         18
-#define PTRACE_SETFPXREGS         19
-
-#define PTRACE_OLDSETOPTIONS         21
-
-#define PTRACE_GET_THREAD_AREA    25
-#define PTRACE_SET_THREAD_AREA    26
-
 #ifdef __KERNEL__
 
 #include <asm/vm86.h>
Index: linux-2.6.13-rc5-mm1-abi/include/asm-i386/system-abi.h
===================================================================
--- linux-2.6.13-rc5-mm1-abi.orig/include/asm-i386/system-abi.h	2005-08-16 05:22:15.349927640 -0400
+++ linux-2.6.13-rc5-mm1-abi/include/asm-i386/system-abi.h	2005-08-16 11:32:28.000000000 -0400
@@ -0,0 +1,190 @@
+#ifndef __SYSTEM_ABI__
+#define __SYSTEM_ABI__
+
+#include <asm/cpufeature.h>
+
+#ifdef CONFIG_SMP
+#define smp_mb()	mb()
+#define smp_rmb()	rmb()
+#define smp_wmb()	wmb()
+#define smp_read_barrier_depends()	read_barrier_depends()
+#define set_mb(var, value) do { xchg(&var, value); } while (0)
+#else
+#define smp_mb()	barrier()
+#define smp_rmb()	barrier()
+#define smp_wmb()	barrier()
+#define smp_read_barrier_depends()	do { } while(0)
+#define set_mb(var, value) do { var = value; barrier(); } while (0)
+#endif
+
+#define xchg(ptr,v) ((__typeof__(*(ptr)))__xchg((unsigned long)(v),(ptr),sizeof(*(ptr))))
+
+#define tas(ptr) (xchg((ptr),1))
+
+struct __xchg_dummy { unsigned long a[100]; };
+#define __xg(x) ((struct __xchg_dummy *)(x))
+
+/*
+ * Note: no "lock" prefix even on SMP: xchg always implies lock anyway
+ * Note 2: xchg has side effect, so that attribute volatile is necessary,
+ *	  but generally the primitive is invalid, *ptr is output argument. --ANK
+ */
+static inline unsigned long __xchg(unsigned long x, volatile void * ptr, int size)
+{
+	switch (size) {
+		case 1:
+			__asm__ __volatile__("xchgb %b0,%1"
+				:"=q" (x)
+				:"m" (*__xg(ptr)), "0" (x)
+				:"memory");
+			break;
+		case 2:
+			__asm__ __volatile__("xchgw %w0,%1"
+				:"=r" (x)
+				:"m" (*__xg(ptr)), "0" (x)
+				:"memory");
+			break;
+		case 4:
+			__asm__ __volatile__("xchgl %0,%1"
+				:"=r" (x)
+				:"m" (*__xg(ptr)), "0" (x)
+				:"memory");
+			break;
+	}
+	return x;
+}
+
+/* 
+ * Alternative instructions for different CPU types or capabilities.
+ * 
+ * This allows to use optimized instructions even on generic binary
+ * kernels.
+ * 
+ * length of oldinstr must be longer or equal the length of newinstr
+ * It can be padded with nops as needed.
+ * 
+ * For non barrier like inlines please define new variants
+ * without volatile and memory clobber.
+ */
+#define alternative(oldinstr, newinstr, feature) 	\
+	asm volatile ("661:\n\t" oldinstr "\n662:\n" 		     \
+		      ".section .altinstructions,\"a\"\n"     	     \
+		      "  .align 4\n"				       \
+		      "  .long 661b\n"            /* label */          \
+		      "  .long 663f\n"		  /* new instruction */ 	\
+		      "  .byte %c0\n"             /* feature bit */    \
+		      "  .byte 662b-661b\n"       /* sourcelen */      \
+		      "  .byte 664f-663f\n"       /* replacementlen */ \
+		      ".previous\n"						\
+		      ".section .altinstr_replacement,\"ax\"\n"			\
+		      "663:\n\t" newinstr "\n664:\n"   /* replacement */    \
+		      ".previous" :: "i" (feature) : "memory")  
+
+/*
+ * Alternative inline assembly with input.
+ * 
+ * Pecularities:
+ * No memory clobber here. 
+ * Argument numbers start with 1.
+ * Best is to use constraints that are fixed size (like (%1) ... "r")
+ * If you use variable sized constraints like "m" or "g" in the 
+ * replacement maake sure to pad to the worst case length.
+ */
+#define alternative_input(oldinstr, newinstr, feature, input...)		\
+	asm volatile ("661:\n\t" oldinstr "\n662:\n"				\
+		      ".section .altinstructions,\"a\"\n"			\
+		      "  .align 4\n"						\
+		      "  .long 661b\n"            /* label */			\
+		      "  .long 663f\n"		  /* new instruction */ 	\
+		      "  .byte %c0\n"             /* feature bit */		\
+		      "  .byte 662b-661b\n"       /* sourcelen */		\
+		      "  .byte 664f-663f\n"       /* replacementlen */ 		\
+		      ".previous\n"						\
+		      ".section .altinstr_replacement,\"ax\"\n"			\
+		      "663:\n\t" newinstr "\n664:\n"   /* replacement */ 	\
+		      ".previous" :: "i" (feature), ##input)
+
+/*
+ * Force strict CPU ordering.
+ * And yes, this is required on UP too when we're talking
+ * to devices.
+ *
+ * For now, "wmb()" doesn't actually do anything, as all
+ * Intel CPU's follow what Intel calls a *Processor Order*,
+ * in which all writes are seen in the program order even
+ * outside the CPU.
+ *
+ * I expect future Intel CPU's to have a weaker ordering,
+ * but I'd also expect them to finally get their act together
+ * and add some real memory barriers if so.
+ *
+ * Some non intel clones support out of order store. wmb() ceases to be a
+ * nop for these.
+ */
+ 
+
+/* 
+ * Actually only lfence would be needed for mb() because all stores done 
+ * by the kernel should be already ordered. But keep a full barrier for now. 
+ */
+
+#define mb() alternative("lock; addl $0,0(%%esp)", "mfence", X86_FEATURE_XMM2)
+#define rmb() alternative("lock; addl $0,0(%%esp)", "lfence", X86_FEATURE_XMM2)
+
+/**
+ * read_barrier_depends - Flush all pending reads that subsequents reads
+ * depend on.
+ *
+ * No data-dependent reads from memory-like regions are ever reordered
+ * over this barrier.  All reads preceding this primitive are guaranteed
+ * to access memory (but not necessarily other CPUs' caches) before any
+ * reads following this primitive that depend on the data return by
+ * any of the preceding reads.  This primitive is much lighter weight than
+ * rmb() on most CPUs, and is never heavier weight than is
+ * rmb().
+ *
+ * These ordering constraints are respected by both the local CPU
+ * and the compiler.
+ *
+ * Ordering is not guaranteed by anything other than these primitives,
+ * not even by data dependencies.  See the documentation for
+ * memory_barrier() for examples and URLs to more information.
+ *
+ * For example, the following code would force ordering (the initial
+ * value of "a" is zero, "b" is one, and "p" is "&a"):
+ *
+ * <programlisting>
+ *	CPU 0				CPU 1
+ *
+ *	b = 2;
+ *	memory_barrier();
+ *	p = &b;				q = p;
+ *					read_barrier_depends();
+ *					d = *q;
+ * </programlisting>
+ *
+ * because the read of "*q" depends on the read of "p" and these
+ * two reads are separated by a read_barrier_depends().  However,
+ * the following code, with the same initial values for "a" and "b":
+ *
+ * <programlisting>
+ *	CPU 0				CPU 1
+ *
+ *	a = 2;
+ *	memory_barrier();
+ *	b = 3;				y = b;
+ *					read_barrier_depends();
+ *					x = a;
+ * </programlisting>
+ *
+ * does not enforce ordering, since there is no data dependency between
+ * the read of "a" and the read of "b".  Therefore, on some CPUs, such
+ * as Alpha, "y" could be set to 3 and "x" to 0.  Use rmb()
+ * in cases like thiswhere there are no data dependencies.
+ **/
+
+#define read_barrier_depends()	do { } while(0)
+
+extern unsigned long arch_align_stack(unsigned long sp);
+
+#endif
Index: linux-2.6.13-rc5-mm1-abi/include/asm-i386/system.h
===================================================================
--- linux-2.6.13-rc5-mm1-abi.orig/include/asm-i386/system.h	2005-08-16 08:48:01.000000000 -0400
+++ linux-2.6.13-rc5-mm1-abi/include/asm-i386/system.h	2005-08-16 11:26:36.000000000 -0400
@@ -7,6 +7,8 @@
 #include <asm/cpufeature.h>
 #include <linux/bitops.h> /* for LOCK_PREFIX */
 
+#include <asm/system-abi.h>
+
 #ifdef __KERNEL__
 
 struct task_struct;	/* one of the stranger aspects of C forward declarations.. */
@@ -112,14 +114,6 @@
 
 #define nop() __asm__ __volatile__ ("nop")
 
-#define xchg(ptr,v) ((__typeof__(*(ptr)))__xchg((unsigned long)(v),(ptr),sizeof(*(ptr))))
-
-#define tas(ptr) (xchg((ptr),1))
-
-struct __xchg_dummy { unsigned long a[100]; };
-#define __xg(x) ((struct __xchg_dummy *)(x))
-
-
 /*
  * The semantics of XCHGCMP8B are a bit strange, this is why
  * there is a loop and the loading of %%eax and %%edx has to
@@ -175,36 +169,6 @@
  __set_64bit(ptr, ll_low(value), ll_high(value)) )
 
 /*
- * Note: no "lock" prefix even on SMP: xchg always implies lock anyway
- * Note 2: xchg has side effect, so that attribute volatile is necessary,
- *	  but generally the primitive is invalid, *ptr is output argument. --ANK
- */
-static inline unsigned long __xchg(unsigned long x, volatile void * ptr, int size)
-{
-	switch (size) {
-		case 1:
-			__asm__ __volatile__("xchgb %b0,%1"
-				:"=q" (x)
-				:"m" (*__xg(ptr)), "0" (x)
-				:"memory");
-			break;
-		case 2:
-			__asm__ __volatile__("xchgw %w0,%1"
-				:"=r" (x)
-				:"m" (*__xg(ptr)), "0" (x)
-				:"memory");
-			break;
-		case 4:
-			__asm__ __volatile__("xchgl %0,%1"
-				:"=r" (x)
-				:"m" (*__xg(ptr)), "0" (x)
-				:"memory");
-			break;
-	}
-	return x;
-}
-
-/*
  * Atomic compare and exchange.  Compare OLD with MEM, if identical,
  * store NEW in MEM.  Return the initial value in MEM.  Success is
  * indicated by comparing RETURN with OLD.
@@ -256,137 +220,6 @@
 }; 
 #endif
 
-/* 
- * Alternative instructions for different CPU types or capabilities.
- * 
- * This allows to use optimized instructions even on generic binary
- * kernels.
- * 
- * length of oldinstr must be longer or equal the length of newinstr
- * It can be padded with nops as needed.
- * 
- * For non barrier like inlines please define new variants
- * without volatile and memory clobber.
- */
-#define alternative(oldinstr, newinstr, feature) 	\
-	asm volatile ("661:\n\t" oldinstr "\n662:\n" 		     \
-		      ".section .altinstructions,\"a\"\n"     	     \
-		      "  .align 4\n"				       \
-		      "  .long 661b\n"            /* label */          \
-		      "  .long 663f\n"		  /* new instruction */ 	\
-		      "  .byte %c0\n"             /* feature bit */    \
-		      "  .byte 662b-661b\n"       /* sourcelen */      \
-		      "  .byte 664f-663f\n"       /* replacementlen */ \
-		      ".previous\n"						\
-		      ".section .altinstr_replacement,\"ax\"\n"			\
-		      "663:\n\t" newinstr "\n664:\n"   /* replacement */    \
-		      ".previous" :: "i" (feature) : "memory")  
-
-/*
- * Alternative inline assembly with input.
- * 
- * Pecularities:
- * No memory clobber here. 
- * Argument numbers start with 1.
- * Best is to use constraints that are fixed size (like (%1) ... "r")
- * If you use variable sized constraints like "m" or "g" in the 
- * replacement maake sure to pad to the worst case length.
- */
-#define alternative_input(oldinstr, newinstr, feature, input...)		\
-	asm volatile ("661:\n\t" oldinstr "\n662:\n"				\
-		      ".section .altinstructions,\"a\"\n"			\
-		      "  .align 4\n"						\
-		      "  .long 661b\n"            /* label */			\
-		      "  .long 663f\n"		  /* new instruction */ 	\
-		      "  .byte %c0\n"             /* feature bit */		\
-		      "  .byte 662b-661b\n"       /* sourcelen */		\
-		      "  .byte 664f-663f\n"       /* replacementlen */ 		\
-		      ".previous\n"						\
-		      ".section .altinstr_replacement,\"ax\"\n"			\
-		      "663:\n\t" newinstr "\n664:\n"   /* replacement */ 	\
-		      ".previous" :: "i" (feature), ##input)
-
-/*
- * Force strict CPU ordering.
- * And yes, this is required on UP too when we're talking
- * to devices.
- *
- * For now, "wmb()" doesn't actually do anything, as all
- * Intel CPU's follow what Intel calls a *Processor Order*,
- * in which all writes are seen in the program order even
- * outside the CPU.
- *
- * I expect future Intel CPU's to have a weaker ordering,
- * but I'd also expect them to finally get their act together
- * and add some real memory barriers if so.
- *
- * Some non intel clones support out of order store. wmb() ceases to be a
- * nop for these.
- */
- 
-
-/* 
- * Actually only lfence would be needed for mb() because all stores done 
- * by the kernel should be already ordered. But keep a full barrier for now. 
- */
-
-#define mb() alternative("lock; addl $0,0(%%esp)", "mfence", X86_FEATURE_XMM2)
-#define rmb() alternative("lock; addl $0,0(%%esp)", "lfence", X86_FEATURE_XMM2)
-
-/**
- * read_barrier_depends - Flush all pending reads that subsequents reads
- * depend on.
- *
- * No data-dependent reads from memory-like regions are ever reordered
- * over this barrier.  All reads preceding this primitive are guaranteed
- * to access memory (but not necessarily other CPUs' caches) before any
- * reads following this primitive that depend on the data return by
- * any of the preceding reads.  This primitive is much lighter weight than
- * rmb() on most CPUs, and is never heavier weight than is
- * rmb().
- *
- * These ordering constraints are respected by both the local CPU
- * and the compiler.
- *
- * Ordering is not guaranteed by anything other than these primitives,
- * not even by data dependencies.  See the documentation for
- * memory_barrier() for examples and URLs to more information.
- *
- * For example, the following code would force ordering (the initial
- * value of "a" is zero, "b" is one, and "p" is "&a"):
- *
- * <programlisting>
- *	CPU 0				CPU 1
- *
- *	b = 2;
- *	memory_barrier();
- *	p = &b;				q = p;
- *					read_barrier_depends();
- *					d = *q;
- * </programlisting>
- *
- * because the read of "*q" depends on the read of "p" and these
- * two reads are separated by a read_barrier_depends().  However,
- * the following code, with the same initial values for "a" and "b":
- *
- * <programlisting>
- *	CPU 0				CPU 1
- *
- *	a = 2;
- *	memory_barrier();
- *	b = 3;				y = b;
- *					read_barrier_depends();
- *					x = a;
- * </programlisting>
- *
- * does not enforce ordering, since there is no data dependency between
- * the read of "a" and the read of "b".  Therefore, on some CPUs, such
- * as Alpha, "y" could be set to 3 and "x" to 0.  Use rmb()
- * in cases like thiswhere there are no data dependencies.
- **/
-
-#define read_barrier_depends()	do { } while(0)
-
 #ifdef CONFIG_X86_OOSTORE
 /* Actually there are no OOO store capable CPUs for now that do SSE, 
    but make it already an possibility. */
@@ -395,20 +228,6 @@
 #define wmb()	__asm__ __volatile__ ("": : :"memory")
 #endif
 
-#ifdef CONFIG_SMP
-#define smp_mb()	mb()
-#define smp_rmb()	rmb()
-#define smp_wmb()	wmb()
-#define smp_read_barrier_depends()	read_barrier_depends()
-#define set_mb(var, value) do { xchg(&var, value); } while (0)
-#else
-#define smp_mb()	barrier()
-#define smp_rmb()	barrier()
-#define smp_wmb()	barrier()
-#define smp_read_barrier_depends()	do { } while(0)
-#define set_mb(var, value) do { var = value; barrier(); } while (0)
-#endif
-
 #define set_wmb(var, value) do { var = value; wmb(); } while (0)
 
 #include <mach_system.h>
@@ -439,6 +258,4 @@
 	wbinvd();
 }
 
-extern unsigned long arch_align_stack(unsigned long sp);
-
 #endif
Index: linux-2.6.13-rc5-mm1-abi/include/asm-um/ptrace-generic.h
===================================================================
--- linux-2.6.13-rc5-mm1-abi.orig/include/asm-um/ptrace-generic.h	2005-06-17 15:48:29.000000000 -0400
+++ linux-2.6.13-rc5-mm1-abi/include/asm-um/ptrace-generic.h	2005-08-16 11:31:30.000000000 -0400
@@ -9,19 +9,7 @@
 #ifndef __ASSEMBLY__
 
 #include "linux/config.h"
-
-#define pt_regs pt_regs_subarch
-#define show_regs show_regs_subarch
-#define send_sigtrap send_sigtrap_subarch
-
-#include "asm/arch/ptrace.h"
-
-#undef pt_regs
-#undef show_regs
-#undef send_sigtrap
-#undef user_mode
-#undef instruction_pointer
-
+#include "asm/arch/ptrace-abi.h"
 #include "sysdep/ptrace.h"
 
 struct pt_regs {
Index: linux-2.6.13-rc5-mm1-abi/include/asm-um/system-generic.h
===================================================================
--- linux-2.6.13-rc5-mm1-abi.orig/include/asm-um/system-generic.h	2005-06-17 15:48:29.000000000 -0400
+++ linux-2.6.13-rc5-mm1-abi/include/asm-um/system-generic.h	2005-08-16 11:32:15.000000000 -0400
@@ -1,19 +1,7 @@
 #ifndef __UM_SYSTEM_GENERIC_H
 #define __UM_SYSTEM_GENERIC_H
 
-#include "asm/arch/system.h"
-
-#undef switch_to
-#undef local_irq_save
-#undef local_irq_restore
-#undef local_irq_disable
-#undef local_irq_enable
-#undef local_save_flags
-#undef local_irq_restore
-#undef local_irq_enable
-#undef local_irq_disable
-#undef local_irq_save
-#undef irqs_disabled
+#include "asm/arch/system-abi.h"
 
 extern void *switch_to(void *prev, void *next, void *last);
 
