Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264631AbUD1DaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264631AbUD1DaF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 23:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264632AbUD1DaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 23:30:05 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:26561 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S264631AbUD1D3b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 23:29:31 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: [patch] 2.6.6-rc3 Allow architectures to reenable interrupts on contended spinlocks 
In-reply-to: Your message of "Tue, 27 Apr 2004 09:01:17 MST."
             <Pine.LNX.4.58.0404270856260.19703@ppc970.osdl.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 28 Apr 2004 13:29:25 +1000
Message-ID: <7094.1083122965@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Apr 2004 09:01:17 -0700 (PDT), 
Linus Torvalds <torvalds@osdl.org> wrote:
>Aargh. Ugly ugly. Can you instead _first_ do all the infrastructure, and 
>just add the unused "flags" argument to all architectures ...

As requested by Linus, update all architectures to add the common
infrastructure.  Tested on ia64 and i386.


Enable interrupts while waiting for a disabled spinlock, but only if
interrupts were enabled before issuing spin_lock_irqsave().

This patch consists of three sections :-

* An architecture independent change to call _raw_spin_lock_flags()
  instead of _raw_spin_lock() when the flags are available.

* An ia64 specific change to implement _raw_spin_lock_flags() and to
  define _raw_spin_lock(lock) as _raw_spin_lock_flags(lock, 0) for the
  ASM_SUPPORTED case.

* Patches for all other architectures and for ia64 with !ASM_SUPPORTED
  to map _raw_spin_lock_flags(lock, flags) to _raw_spin_lock(lock).
  Architecture maintainers can define _raw_spin_lock_flags() to do
  something useful if they want to enable interrupts while waiting for
  a disabled spinlock.


Index: 2.6.6-rc3/include/linux/spinlock.h
===================================================================
--- 2.6.6-rc3.orig/include/linux/spinlock.h	Thu Dec 18 13:58:49 2003
+++ 2.6.6-rc3/include/linux/spinlock.h	Wed Apr 28 13:23:42 2004
@@ -257,7 +257,7 @@
 do { \
 	local_irq_save(flags); \
 	preempt_disable(); \
-	_raw_spin_lock(lock); \
+	_raw_spin_lock_flags(lock, flags); \
 } while (0)
 
 #define spin_lock_irq(lock) \


Index: 2.6.6-rc3/include/asm-ia64/spinlock.h
===================================================================
--- 2.6.6-rc3.orig/include/asm-ia64/spinlock.h	Mon Apr  5 11:04:32 2004
+++ 2.6.6-rc3/include/asm-ia64/spinlock.h	Wed Apr 28 13:23:42 2004
@@ -32,10 +32,10 @@
  * carefully coded to touch only those registers that spin_lock() marks "clobbered".
  */
 
-#define IA64_SPINLOCK_CLOBBERS "ar.ccv", "ar.pfs", "p14", "r28", "r29", "r30", "b6", "memory"
+#define IA64_SPINLOCK_CLOBBERS "ar.ccv", "ar.pfs", "p14", "p15", "r27", "r28", "r29", "r30", "b6", "memory"
 
 static inline void
-_raw_spin_lock (spinlock_t *lock)
+_raw_spin_lock_flags (spinlock_t *lock, unsigned long flags)
 {
 	register volatile unsigned int *ptr asm ("r31") = &lock->lock;
 
@@ -50,9 +50,10 @@
 		      "cmpxchg4.acq r30 = [%1], r30, ar.ccv\n\t"
 		      "movl r29 = ia64_spinlock_contention_pre3_4;;\n\t"
 		      "cmp4.ne p14, p0 = r30, r0\n\t"
-		      "mov b6 = r29;;\n"
+		      "mov b6 = r29;;\n\t"
+		      "mov r27=%2\n\t"
 		      "(p14) br.cond.spnt.many b6"
-		      : "=r"(ptr) : "r"(ptr) : IA64_SPINLOCK_CLOBBERS);
+		      : "=r"(ptr) : "r"(ptr), "r" (flags) : IA64_SPINLOCK_CLOBBERS);
 # else
 	asm volatile ("{\n\t"
 		      "  mov ar.ccv = r0\n\t"
@@ -60,33 +61,38 @@
 		      "  mov r30 = 1;;\n\t"
 		      "}\n\t"
 		      "cmpxchg4.acq r30 = [%1], r30, ar.ccv;;\n\t"
-		      "cmp4.ne p14, p0 = r30, r0\n"
+		      "cmp4.ne p14, p0 = r30, r0\n\t"
+		      "mov r27=%2\n\t"
 		      "(p14) brl.cond.spnt.many ia64_spinlock_contention_pre3_4;;"
-		      : "=r"(ptr) : "r"(ptr) : IA64_SPINLOCK_CLOBBERS);
+		      : "=r"(ptr) : "r"(ptr), "r" (flags) : IA64_SPINLOCK_CLOBBERS);
 # endif /* CONFIG_MCKINLEY */
 #else
 # ifdef CONFIG_ITANIUM
 	/* don't use brl on Itanium... */
 	/* mis-declare, so we get the entry-point, not it's function descriptor: */
 	asm volatile ("mov r30 = 1\n\t"
+		      "mov r27=%2\n\t"
 		      "mov ar.ccv = r0;;\n\t"
 		      "cmpxchg4.acq r30 = [%0], r30, ar.ccv\n\t"
 		      "movl r29 = ia64_spinlock_contention;;\n\t"
 		      "cmp4.ne p14, p0 = r30, r0\n\t"
-		      "mov b6 = r29;;\n"
+		      "mov b6 = r29;;\n\t"
 		      "(p14) br.call.spnt.many b6 = b6"
-		      : "=r"(ptr) : "r"(ptr) : IA64_SPINLOCK_CLOBBERS);
+		      : "=r"(ptr) : "r"(ptr), "r" (flags) : IA64_SPINLOCK_CLOBBERS);
 # else
 	asm volatile ("mov r30 = 1\n\t"
+		      "mov r27=%2\n\t"
 		      "mov ar.ccv = r0;;\n\t"
 		      "cmpxchg4.acq r30 = [%0], r30, ar.ccv;;\n\t"
 		      "cmp4.ne p14, p0 = r30, r0\n\t"
 		      "(p14) brl.call.spnt.many b6=ia64_spinlock_contention;;"
-		      : "=r"(ptr) : "r"(ptr) : IA64_SPINLOCK_CLOBBERS);
+		      : "=r"(ptr) : "r"(ptr), "r" (flags) : IA64_SPINLOCK_CLOBBERS);
 # endif /* CONFIG_MCKINLEY */
 #endif
 }
+#define _raw_spin_lock(lock) _raw_spin_lock_flags(lock, 0)
 #else /* !ASM_SUPPORTED */
+#define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
 # define _raw_spin_lock(x)								\
 do {											\
 	__u32 *ia64_spinlock_ptr = (__u32 *) (x);					\
Index: 2.6.6-rc3/arch/ia64/kernel/head.S
===================================================================
--- 2.6.6-rc3.orig/arch/ia64/kernel/head.S	Mon Apr  5 11:02:53 2004
+++ 2.6.6-rc3/arch/ia64/kernel/head.S	Wed Apr 28 13:23:42 2004
@@ -866,12 +866,14 @@
 	 * Inputs:
 	 *   ar.pfs - saved CFM of caller
 	 *   ar.ccv - 0 (and available for use)
+	 *   r27    - flags from spin_lock_irqsave or 0.  Must be preserved.
 	 *   r28    - available for use.
 	 *   r29    - available for use.
 	 *   r30    - available for use.
 	 *   r31    - address of lock, available for use.
 	 *   b6     - return address
 	 *   p14    - available for use.
+	 *   p15    - used to track flag status.
 	 *
 	 * If you patch this code to use more registers, do not forget to update
 	 * the clobber lists for spin_lock() in include/asm-ia64/spinlock.h.
@@ -885,22 +887,26 @@
 	.save rp, r28
 	.body
 	nop 0
-	nop 0
+	tbit.nz p15,p0=r27,IA64_PSR_I_BIT
 	.restore sp		// pop existing prologue after next insn
 	mov b6 = r28
 	.prologue
 	.save ar.pfs, r0
 	.altrp b6
 	.body
+	;;
+(p15)	ssm psr.i		// reenable interrupts if they were on
+				// DavidM says that srlz.d is slow and is not required in this case
 .wait:
 	// exponential backoff, kdb, lockmeter etc. go in here
 	hint @pause
 	ld4 r30=[r31]		// don't use ld4.bias; if it's contended, we won't write the word
 	nop 0
 	;;
-	cmp4.eq p14,p0=r30,r0
-(p14)	br.cond.sptk.few b6	// lock is now free, try to acquire
-	br.cond.sptk.few .wait
+	cmp4.ne p14,p0=r30,r0
+(p14)	br.cond.sptk.few .wait
+(p15)	rsm psr.i		// disable interrupts if we reenabled them
+	br.cond.sptk.few b6	// lock is now free, try to acquire
 END(ia64_spinlock_contention_pre3_4)
 
 #else
@@ -909,14 +915,20 @@
 	.prologue
 	.altrp b6
 	.body
+	tbit.nz p15,p0=r27,IA64_PSR_I_BIT
+	;;
 .wait:
+(p15)	ssm psr.i		// reenable interrupts if they were on
+				// DavidM says that srlz.d is slow and is not required in this case
+.wait2:
 	// exponential backoff, kdb, lockmeter etc. go in here
 	hint @pause
 	ld4 r30=[r31]		// don't use ld4.bias; if it's contended, we won't write the word
 	;;
 	cmp4.ne p14,p0=r30,r0
 	mov r30 = 1
-(p14)	br.cond.sptk.few .wait
+(p14)	br.cond.sptk.few .wait2
+(p15)	rsm psr.i		// disable interrupts if we reenabled them
 	;;
 	cmpxchg4.acq r30=[r31], r30, ar.ccv
 	;;



Index: 2.6.6-rc3/include/asm-alpha/spinlock.h
===================================================================
--- 2.6.6-rc3.orig/include/asm-alpha/spinlock.h	Thu Dec 18 13:59:05 2003
+++ 2.6.6-rc3/include/asm-alpha/spinlock.h	Wed Apr 28 13:23:42 2004
@@ -36,6 +36,7 @@
 
 #define spin_is_locked(x)	((x)->lock != 0)
 #define spin_unlock_wait(x)	({ do { barrier(); } while ((x)->lock); })
+#define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
 
 #ifdef CONFIG_DEBUG_SPINLOCK
 extern void _raw_spin_unlock(spinlock_t * lock);
Index: 2.6.6-rc3/include/asm-arm/spinlock.h
===================================================================
--- 2.6.6-rc3.orig/include/asm-arm/spinlock.h	Thu Mar 11 16:13:53 2004
+++ 2.6.6-rc3/include/asm-arm/spinlock.h	Wed Apr 28 13:23:42 2004
@@ -24,6 +24,7 @@
 #define spin_lock_init(x)	do { *(x) = SPIN_LOCK_UNLOCKED; } while (0)
 #define spin_is_locked(x)	((x)->lock != 0)
 #define spin_unlock_wait(x)	do { barrier(); } while (spin_is_locked(x))
+#define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
 
 static inline void _raw_spin_lock(spinlock_t *lock)
 {
Index: 2.6.6-rc3/include/asm-i386/spinlock.h
===================================================================
--- 2.6.6-rc3.orig/include/asm-i386/spinlock.h	Thu Mar 11 16:13:53 2004
+++ 2.6.6-rc3/include/asm-i386/spinlock.h	Wed Apr 28 13:23:42 2004
@@ -42,6 +42,7 @@
 
 #define spin_is_locked(x)	(*(volatile signed char *)(&(x)->lock) <= 0)
 #define spin_unlock_wait(x)	do { barrier(); } while(spin_is_locked(x))
+#define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
 
 #define spin_lock_string \
 	"\n1:\t" \
Index: 2.6.6-rc3/include/asm-mips/spinlock.h
===================================================================
--- 2.6.6-rc3.orig/include/asm-mips/spinlock.h	Wed Apr 28 13:20:34 2004
+++ 2.6.6-rc3/include/asm-mips/spinlock.h	Wed Apr 28 13:23:42 2004
@@ -23,6 +23,7 @@
 
 #define spin_is_locked(x)	((x)->lock != 0)
 #define spin_unlock_wait(x)	do { barrier(); } while ((x)->lock)
+#define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
 
 /*
  * Simple spin lock operations.  There are two variants, one clears IRQ's
Index: 2.6.6-rc3/include/asm-parisc/spinlock.h
===================================================================
--- 2.6.6-rc3.orig/include/asm-parisc/spinlock.h	Thu Dec 18 13:58:40 2003
+++ 2.6.6-rc3/include/asm-parisc/spinlock.h	Wed Apr 28 13:23:42 2004
@@ -15,6 +15,7 @@
 #define spin_is_locked(x) ((x)->lock == 0)
 
 #define spin_unlock_wait(x)	do { barrier(); } while(((volatile spinlock_t *)(x))->lock == 0)
+#define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
 
 #if 1
 #define _raw_spin_lock(x) do { \
Index: 2.6.6-rc3/include/asm-ppc/spinlock.h
===================================================================
--- 2.6.6-rc3.orig/include/asm-ppc/spinlock.h	Thu Dec 18 13:58:40 2003
+++ 2.6.6-rc3/include/asm-ppc/spinlock.h	Wed Apr 28 13:23:42 2004
@@ -27,6 +27,7 @@
 #define spin_lock_init(x) 	do { *(x) = SPIN_LOCK_UNLOCKED; } while(0)
 #define spin_is_locked(x)	((x)->lock != 0)
 #define spin_unlock_wait(x)	do { barrier(); } while(spin_is_locked(x))
+#define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
 
 #ifndef CONFIG_DEBUG_SPINLOCK
 
Index: 2.6.6-rc3/include/asm-ppc64/spinlock.h
===================================================================
--- 2.6.6-rc3.orig/include/asm-ppc64/spinlock.h	Thu Dec 18 13:58:05 2003
+++ 2.6.6-rc3/include/asm-ppc64/spinlock.h	Wed Apr 28 13:23:42 2004
@@ -22,6 +22,7 @@
 #define SPIN_LOCK_UNLOCKED	(spinlock_t) { 0 }
 
 #define spin_is_locked(x)	((x)->lock != 0)
+#define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
 
 static __inline__ int _raw_spin_trylock(spinlock_t *lock)
 {
Index: 2.6.6-rc3/include/asm-s390/spinlock.h
===================================================================
--- 2.6.6-rc3.orig/include/asm-s390/spinlock.h	Wed Apr 28 13:20:38 2004
+++ 2.6.6-rc3/include/asm-s390/spinlock.h	Wed Apr 28 13:23:42 2004
@@ -42,6 +42,7 @@
 #define spin_lock_init(lp) do { (lp)->lock = 0; } while(0)
 #define spin_unlock_wait(lp)	do { barrier(); } while(((volatile spinlock_t *)(lp))->lock)
 #define spin_is_locked(x) ((x)->lock != 0)
+#define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
 
 extern inline void _raw_spin_lock(spinlock_t *lp)
 {
Index: 2.6.6-rc3/include/asm-sh/spinlock.h
===================================================================
--- 2.6.6-rc3.orig/include/asm-sh/spinlock.h	Thu Feb  5 10:12:32 2004
+++ 2.6.6-rc3/include/asm-sh/spinlock.h	Wed Apr 28 13:23:42 2004
@@ -25,6 +25,7 @@
 
 #define spin_is_locked(x)	((x)->lock != 0)
 #define spin_unlock_wait(x)	do { barrier(); } while (spin_is_locked(x))
+#define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
 
 /*
  * Simple spin lock operations.  There are two variants, one clears IRQ's
Index: 2.6.6-rc3/include/asm-sparc/spinlock.h
===================================================================
--- 2.6.6-rc3.orig/include/asm-sparc/spinlock.h	Thu Dec 18 13:59:16 2003
+++ 2.6.6-rc3/include/asm-sparc/spinlock.h	Wed Apr 28 13:23:42 2004
@@ -216,6 +216,8 @@
 
 #endif /* CONFIG_DEBUG_SPINLOCK */
 
+#define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
+
 #endif /* !(__ASSEMBLY__) */
 
 #endif /* __SPARC_SPINLOCK_H */
Index: 2.6.6-rc3/include/asm-sparc64/spinlock.h
===================================================================
--- 2.6.6-rc3.orig/include/asm-sparc64/spinlock.h	Thu Mar 11 16:13:55 2004
+++ 2.6.6-rc3/include/asm-sparc64/spinlock.h	Wed Apr 28 13:23:42 2004
@@ -106,6 +106,8 @@
 
 #endif /* CONFIG_DEBUG_SPINLOCK */
 
+#define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
+
 /* Multi-reader locks, these are much saner than the 32-bit Sparc ones... */
 
 #ifndef CONFIG_DEBUG_SPINLOCK
Index: 2.6.6-rc3/include/asm-x86_64/spinlock.h
===================================================================
--- 2.6.6-rc3.orig/include/asm-x86_64/spinlock.h	Thu Feb  5 10:12:33 2004
+++ 2.6.6-rc3/include/asm-x86_64/spinlock.h	Wed Apr 28 13:23:42 2004
@@ -41,6 +41,7 @@
 
 #define spin_is_locked(x)	(*(volatile signed char *)(&(x)->lock) <= 0)
 #define spin_unlock_wait(x)	do { barrier(); } while(spin_is_locked(x))
+#define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
 
 #define spin_lock_string \
 	"\n1:\t" \

