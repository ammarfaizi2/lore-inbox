Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266534AbUIMMSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266534AbUIMMSo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 08:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266603AbUIMMSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 08:18:44 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:9199 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S266534AbUIMMRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 08:17:24 -0400
Date: Mon, 13 Sep 2004 08:21:59 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, Ingo Molnar <mingo@elte.hu>
Subject: [PATCH] Yielding processor resources during lock contention #2
In-Reply-To: <Pine.LNX.4.53.0409120118280.2297@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.53.0409130813350.2297@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0409021231570.4481@montezuma.fsmlabs.com>
 <16703.60725.153052.169532@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.53.0409090810550.15087@montezuma.fsmlabs.com>
 <Pine.LNX.4.58.0409090751230.5912@ppc970.osdl.org>
 <Pine.LNX.4.58.0409090754270.5912@ppc970.osdl.org>
 <Pine.LNX.4.53.0409091107450.15087@montezuma.fsmlabs.com>
 <Pine.LNX.4.53.0409120009510.2297@montezuma.fsmlabs.com>
 <Pine.LNX.4.58.0409112200060.13491@ppc970.osdl.org>
 <Pine.LNX.4.53.0409120118280.2297@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Sep 2004, Zwane Mwaikambo wrote:

> Well the i386 and x86_64 versions were purely for testing purposes on my 
> part, i'm content with dropping them. The main user was going to be PPC64, 
> but i felt compelled to throw in an architecture implementation.

The following patch introduces cpu_lock_yield which allows architectures
to possibly yield processor resources during lock contention. The original
requirement stems from Paul's requirement on PPC64 LPAR systems to yield
the processor to the hypervisor instead of spinning. However the general
concept can be used beneficially on other architectures such as i386 and
x86_64 with HT to also avoid bouncing cachelines about, utilising
execution resources and possibly unecessarily consuming power during
contention.

The following patch only provides generic versions for all architectures, 
Paul, Anton could slip in the PPC64 version.

 include/asm-alpha/processor.h     |    1 +
 include/asm-arm/processor.h       |    1 +
 include/asm-arm26/processor.h     |    1 +
 include/asm-cris/processor.h      |    1 +
 include/asm-h8300/processor.h     |    1 +
 include/asm-i386/processor.h      |    1 +
 include/asm-ia64/processor.h      |    1 +
 include/asm-m68k/processor.h      |    1 +
 include/asm-m68knommu/processor.h |    1 +
 include/asm-mips/processor.h      |    1 +
 include/asm-parisc/processor.h    |    1 +
 include/asm-ppc/processor.h       |    1 +
 include/asm-ppc64/processor.h     |    1 +
 include/asm-s390/processor.h      |    2 ++
 include/asm-sh/processor.h        |    1 +
 include/asm-sh64/processor.h      |    1 +
 include/asm-sparc/processor.h     |    1 +
 include/asm-sparc64/processor.h   |    1 +
 include/asm-v850/processor.h      |    1 +
 include/asm-x86_64/processor.h    |    1 +
 kernel/spinlock.c                 |    7 +++----
 21 files changed, 24 insertions(+), 4 deletions(-)

Signed-off-by: Zwane Mwaikambo <zwane@linuxpower.ca>

Index: linux-2.6.9-rc1-bk18-stage/include/asm-alpha/processor.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-bk18/include/asm-alpha/processor.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 processor.h
--- linux-2.6.9-rc1-bk18-stage/include/asm-alpha/processor.h	11 Sep 2004 14:17:53 -0000	1.1.1.1
+++ linux-2.6.9-rc1-bk18-stage/include/asm-alpha/processor.h	12 Sep 2004 03:53:09 -0000
@@ -73,6 +73,7 @@ unsigned long get_wchan(struct task_stru
   ((tsk) == current ? rdusp() : (tsk)->thread_info->pcb.usp)
 
 #define cpu_relax()	barrier()
+#define cpu_lock_yield(lock, lock_test) do { cpu_relax(); } while (lock_test(lock))
 
 #define ARCH_HAS_PREFETCH
 #define ARCH_HAS_PREFETCHW
Index: linux-2.6.9-rc1-bk18-stage/include/asm-arm/processor.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-bk18/include/asm-arm/processor.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 processor.h
--- linux-2.6.9-rc1-bk18-stage/include/asm-arm/processor.h	11 Sep 2004 14:17:53 -0000	1.1.1.1
+++ linux-2.6.9-rc1-bk18-stage/include/asm-arm/processor.h	12 Sep 2004 03:53:42 -0000
@@ -85,6 +85,7 @@ extern void release_thread(struct task_s
 unsigned long get_wchan(struct task_struct *p);
 
 #define cpu_relax()			barrier()
+#define cpu_lock_yield(lock, lock_test) do { cpu_relax(); } while (lock_test(lock))
 
 /*
  * Create a new kernel thread
Index: linux-2.6.9-rc1-bk18-stage/include/asm-arm26/processor.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-bk18/include/asm-arm26/processor.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 processor.h
--- linux-2.6.9-rc1-bk18-stage/include/asm-arm26/processor.h	11 Sep 2004 14:17:54 -0000	1.1.1.1
+++ linux-2.6.9-rc1-bk18-stage/include/asm-arm26/processor.h	12 Sep 2004 03:57:27 -0000
@@ -102,6 +102,7 @@ extern void release_thread(struct task_s
 unsigned long get_wchan(struct task_struct *p);
 
 #define cpu_relax()			barrier()
+#define cpu_lock_yield(lock, lock_test) do { cpu_relax(); } while (lock_test(lock))
 
 /* Prepare to copy thread state - unlazy all lazy status */
 #define prepare_to_copy(tsk)    do { } while (0)
Index: linux-2.6.9-rc1-bk18-stage/include/asm-cris/processor.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-bk18/include/asm-cris/processor.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 processor.h
--- linux-2.6.9-rc1-bk18-stage/include/asm-cris/processor.h	11 Sep 2004 14:17:54 -0000	1.1.1.1
+++ linux-2.6.9-rc1-bk18-stage/include/asm-cris/processor.h	12 Sep 2004 03:53:31 -0000
@@ -75,5 +75,6 @@ extern inline void release_thread(struct
 #define init_stack      (init_thread_union.stack)
 
 #define cpu_relax()     barrier()
+#define cpu_lock_yield(lock, lock_test) do { cpu_relax(); } while (lock_test(lock))
 
 #endif /* __ASM_CRIS_PROCESSOR_H */
Index: linux-2.6.9-rc1-bk18-stage/include/asm-h8300/processor.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-bk18/include/asm-h8300/processor.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 processor.h
--- linux-2.6.9-rc1-bk18-stage/include/asm-h8300/processor.h	11 Sep 2004 14:17:54 -0000	1.1.1.1
+++ linux-2.6.9-rc1-bk18-stage/include/asm-h8300/processor.h	12 Sep 2004 03:57:17 -0000
@@ -136,5 +136,6 @@ unsigned long get_wchan(struct task_stru
 #define	KSTK_ESP(tsk)	((tsk) == current ? rdusp() : (tsk)->thread.usp)
 
 #define cpu_relax()    do { } while (0)
+#define cpu_lock_yield(lock, lock_test) do { cpu_relax(); } while (lock_test(lock))
 
 #endif
Index: linux-2.6.9-rc1-bk18-stage/include/asm-i386/processor.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-bk18/include/asm-i386/processor.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 processor.h
--- linux-2.6.9-rc1-bk18-stage/include/asm-i386/processor.h	11 Sep 2004 14:17:54 -0000	1.1.1.1
+++ linux-2.6.9-rc1-bk18-stage/include/asm-i386/processor.h	13 Sep 2004 12:16:28 -0000
@@ -553,6 +553,7 @@ static inline void rep_nop(void)
 }
 
 #define cpu_relax()	rep_nop()
+#define	cpu_lock_yield(lock, lock_test)	do { cpu_relax(); } while (lock_test(lock))
 
 /* generic versions from gas */
 #define GENERIC_NOP1	".byte 0x90\n"
Index: linux-2.6.9-rc1-bk18-stage/include/asm-ia64/processor.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-bk18/include/asm-ia64/processor.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 processor.h
--- linux-2.6.9-rc1-bk18-stage/include/asm-ia64/processor.h	11 Sep 2004 14:17:54 -0000	1.1.1.1
+++ linux-2.6.9-rc1-bk18-stage/include/asm-ia64/processor.h	12 Sep 2004 03:54:36 -0000
@@ -576,6 +576,7 @@ ia64_eoi (void)
 }
 
 #define cpu_relax()	ia64_hint(ia64_hint_pause)
+#define cpu_lock_yield(lock, lock_test) do { cpu_relax(); } while (lock_test(lock))
 
 static inline void
 ia64_set_lrr0 (unsigned long val)
Index: linux-2.6.9-rc1-bk18-stage/include/asm-m68k/processor.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-bk18/include/asm-m68k/processor.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 processor.h
--- linux-2.6.9-rc1-bk18-stage/include/asm-m68k/processor.h	11 Sep 2004 14:17:55 -0000	1.1.1.1
+++ linux-2.6.9-rc1-bk18-stage/include/asm-m68k/processor.h	12 Sep 2004 03:54:22 -0000
@@ -135,5 +135,6 @@ unsigned long get_wchan(struct task_stru
 #define	KSTK_ESP(tsk)	((tsk) == current ? rdusp() : (tsk)->thread.usp)
 
 #define cpu_relax()	barrier()
+#define cpu_lock_yield(lock, lock_test) do { cpu_relax(); } while (lock_test(lock))
 
 #endif
Index: linux-2.6.9-rc1-bk18-stage/include/asm-m68knommu/processor.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-bk18/include/asm-m68knommu/processor.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 processor.h
--- linux-2.6.9-rc1-bk18-stage/include/asm-m68knommu/processor.h	11 Sep 2004 14:17:55 -0000	1.1.1.1
+++ linux-2.6.9-rc1-bk18-stage/include/asm-m68knommu/processor.h	12 Sep 2004 03:54:29 -0000
@@ -132,5 +132,6 @@ unsigned long get_wchan(struct task_stru
 #define	KSTK_ESP(tsk)	((tsk) == current ? rdusp() : (tsk)->thread.usp)
 
 #define cpu_relax()    do { } while (0)
+#define cpu_lock_yield(lock, lock_test) do { cpu_relax(); } while (lock_test(lock))
 
 #endif
Index: linux-2.6.9-rc1-bk18-stage/include/asm-mips/processor.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-bk18/include/asm-mips/processor.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 processor.h
--- linux-2.6.9-rc1-bk18-stage/include/asm-mips/processor.h	11 Sep 2004 14:17:55 -0000	1.1.1.1
+++ linux-2.6.9-rc1-bk18-stage/include/asm-mips/processor.h	12 Sep 2004 03:54:13 -0000
@@ -263,6 +263,7 @@ unsigned long get_wchan(struct task_stru
 #define KSTK_STATUS(tsk) (*(unsigned long *)(__KSTK_TOS(tsk) + __PT_REG(cp0_status)))
 
 #define cpu_relax()	barrier()
+#define cpu_lock_yield(lock, lock_test) do { cpu_relax(); } while (lock_test(lock))
 
 #endif /* __KERNEL__ */
 
Index: linux-2.6.9-rc1-bk18-stage/include/asm-parisc/processor.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-bk18/include/asm-parisc/processor.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 processor.h
--- linux-2.6.9-rc1-bk18-stage/include/asm-parisc/processor.h	11 Sep 2004 14:17:55 -0000	1.1.1.1
+++ linux-2.6.9-rc1-bk18-stage/include/asm-parisc/processor.h	12 Sep 2004 03:54:01 -0000
@@ -341,6 +341,7 @@ extern inline void prefetchw(const void 
 #endif
 
 #define cpu_relax()	barrier()
+#define cpu_lock_yield(lock, lock_test) do { cpu_relax(); } while (lock_test(lock))
 
 #endif /* __ASSEMBLY__ */
 
Index: linux-2.6.9-rc1-bk18-stage/include/asm-ppc/processor.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-bk18/include/asm-ppc/processor.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 processor.h
--- linux-2.6.9-rc1-bk18-stage/include/asm-ppc/processor.h	11 Sep 2004 14:17:55 -0000	1.1.1.1
+++ linux-2.6.9-rc1-bk18-stage/include/asm-ppc/processor.h	12 Sep 2004 03:54:49 -0000
@@ -177,6 +177,7 @@ void _nmask_and_or_msr(unsigned long nma
 #define have_of (_machine == _MACH_chrp || _machine == _MACH_Pmac)
 
 #define cpu_relax()	barrier()
+#define cpu_lock_yield(lock, lock_test) do { cpu_relax(); } while (lock_test(lock))
 
 /*
  * Prefetch macros.
Index: linux-2.6.9-rc1-bk18-stage/include/asm-ppc64/processor.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-bk18/include/asm-ppc64/processor.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 processor.h
--- linux-2.6.9-rc1-bk18-stage/include/asm-ppc64/processor.h	11 Sep 2004 14:17:55 -0000	1.1.1.1
+++ linux-2.6.9-rc1-bk18-stage/include/asm-ppc64/processor.h	12 Sep 2004 03:53:51 -0000
@@ -599,6 +599,7 @@ static inline unsigned long __pack_fe01(
 }
 
 #define cpu_relax()	do { HMT_low(); HMT_medium(); barrier(); } while (0)
+#define cpu_lock_yield(lock, lock_test) do { cpu_relax(); } while (lock_test(lock))
 
 /*
  * Prefetch macros.
Index: linux-2.6.9-rc1-bk18-stage/include/asm-s390/processor.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-bk18/include/asm-s390/processor.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 processor.h
--- linux-2.6.9-rc1-bk18-stage/include/asm-s390/processor.h	11 Sep 2004 14:17:56 -0000	1.1.1.1
+++ linux-2.6.9-rc1-bk18-stage/include/asm-s390/processor.h	12 Sep 2004 03:55:00 -0000
@@ -208,6 +208,8 @@ unsigned long get_wchan(struct task_stru
 	asm volatile ("ex 0,%0" : : "i" (__LC_DIAG44_OPCODE) : "memory")
 #endif /* __s390x__ */
 
+#define cpu_lock_yield(lock, lock_test) do { cpu_relax(); } while (lock_test(lock))
+
 /*
  * Set PSW mask to specified value, while leaving the
  * PSW addr pointing to the next instruction.
Index: linux-2.6.9-rc1-bk18-stage/include/asm-sh/processor.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-bk18/include/asm-sh/processor.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 processor.h
--- linux-2.6.9-rc1-bk18-stage/include/asm-sh/processor.h	11 Sep 2004 14:17:56 -0000	1.1.1.1
+++ linux-2.6.9-rc1-bk18-stage/include/asm-sh/processor.h	12 Sep 2004 03:55:17 -0000
@@ -273,5 +273,6 @@ extern unsigned long get_wchan(struct ta
 
 #define cpu_sleep()	__asm__ __volatile__ ("sleep" : : : "memory")
 #define cpu_relax()	do { } while (0)
+#define cpu_lock_yield(lock, lock_test) do { cpu_relax(); } while (lock_test(lock))
 
 #endif /* __ASM_SH_PROCESSOR_H */
Index: linux-2.6.9-rc1-bk18-stage/include/asm-sh64/processor.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-bk18/include/asm-sh64/processor.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 processor.h
--- linux-2.6.9-rc1-bk18-stage/include/asm-sh64/processor.h	11 Sep 2004 14:17:56 -0000	1.1.1.1
+++ linux-2.6.9-rc1-bk18-stage/include/asm-sh64/processor.h	12 Sep 2004 03:55:08 -0000
@@ -286,6 +286,7 @@ extern unsigned long get_wchan(struct ta
 #define KSTK_ESP(tsk)  ((tsk)->thread.sp)
 
 #define cpu_relax()	do { } while (0)
+#define cpu_lock_yield(lock, lock_test) do { cpu_relax(); } while (lock_test(lock))
 
 #endif	/* __ASSEMBLY__ */
 #endif /* __ASM_SH64_PROCESSOR_H */
Index: linux-2.6.9-rc1-bk18-stage/include/asm-sparc/processor.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-bk18/include/asm-sparc/processor.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 processor.h
--- linux-2.6.9-rc1-bk18-stage/include/asm-sparc/processor.h	11 Sep 2004 14:17:56 -0000	1.1.1.1
+++ linux-2.6.9-rc1-bk18-stage/include/asm-sparc/processor.h	12 Sep 2004 03:55:36 -0000
@@ -128,6 +128,7 @@ extern unsigned long get_wchan(struct ta
 extern struct task_struct *last_task_used_math;
 
 #define cpu_relax()	barrier()
+#define cpu_lock_yield(lock, lock_test) do { cpu_relax(); } while (lock_test(lock))
 
 #endif
 
Index: linux-2.6.9-rc1-bk18-stage/include/asm-sparc64/processor.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-bk18/include/asm-sparc64/processor.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 processor.h
--- linux-2.6.9-rc1-bk18-stage/include/asm-sparc64/processor.h	11 Sep 2004 14:17:56 -0000	1.1.1.1
+++ linux-2.6.9-rc1-bk18-stage/include/asm-sparc64/processor.h	12 Sep 2004 03:55:29 -0000
@@ -195,6 +195,7 @@ extern unsigned long get_wchan(struct ta
 #define KSTK_ESP(tsk)  ((tsk)->thread_info->kregs->u_regs[UREG_FP])
 
 #define cpu_relax()	barrier()
+#define cpu_lock_yield(lock, lock_test) do { cpu_relax(); } while (lock_test(lock))
 
 #endif /* !(__ASSEMBLY__) */
 
Index: linux-2.6.9-rc1-bk18-stage/include/asm-v850/processor.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-bk18/include/asm-v850/processor.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 processor.h
--- linux-2.6.9-rc1-bk18-stage/include/asm-v850/processor.h	11 Sep 2004 14:17:56 -0000	1.1.1.1
+++ linux-2.6.9-rc1-bk18-stage/include/asm-v850/processor.h	12 Sep 2004 03:55:47 -0000
@@ -115,6 +115,7 @@ unsigned long get_wchan (struct task_str
 
 
 #define cpu_relax()    ((void)0)
+#define cpu_lock_yield(lock, lock_test) do { cpu_relax(); } while (lock_test(lock))
 
 
 #else /* __ASSEMBLY__ */
Index: linux-2.6.9-rc1-bk18-stage/include/asm-x86_64/processor.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-bk18/include/asm-x86_64/processor.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 processor.h
--- linux-2.6.9-rc1-bk18-stage/include/asm-x86_64/processor.h	11 Sep 2004 14:17:56 -0000	1.1.1.1
+++ linux-2.6.9-rc1-bk18-stage/include/asm-x86_64/processor.h	13 Sep 2004 12:16:13 -0000
@@ -404,6 +404,7 @@ static inline void prefetchw(void *x) 
 #define spin_lock_prefetch(x)  prefetchw(x)
 
 #define cpu_relax()   rep_nop()
+#define	cpu_lock_yield(lock, lock_test)	do { cpu_relax(); } while (lock_test(lock))
 
 /*
  *      NSC/Cyrix CPU configuration register indexes
Index: linux-2.6.9-rc1-bk18-stage/kernel/spinlock.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-bk18/kernel/spinlock.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 spinlock.c
--- linux-2.6.9-rc1-bk18-stage/kernel/spinlock.c	11 Sep 2004 14:17:58 -0000	1.1.1.1
+++ linux-2.6.9-rc1-bk18-stage/kernel/spinlock.c	12 Sep 2004 03:47:37 -0000
@@ -10,6 +10,7 @@
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <asm/processor.h>
 
 int __lockfunc _spin_trylock(spinlock_t *lock)
 {
@@ -53,8 +54,7 @@ static inline void __preempt_spin_lock(s
 
 	do {
 		preempt_enable();
-		while (spin_is_locked(lock))
-			cpu_relax();
+		cpu_lock_yield(lock, spin_is_locked);
 		preempt_disable();
 	} while (!_raw_spin_trylock(lock));
 }
@@ -75,8 +75,7 @@ static inline void __preempt_write_lock(
 
 	do {
 		preempt_enable();
-		while (rwlock_is_locked(lock))
-			cpu_relax();
+		cpu_lock_yield(lock, rwlock_is_locked);
 		preempt_disable();
 	} while (!_raw_write_trylock(lock));
 }
