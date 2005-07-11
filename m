Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262125AbVGKQhJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262125AbVGKQhJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 12:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbVGKQfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 12:35:13 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:53891 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S262092AbVGKQdE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 12:33:04 -0400
Date: Mon, 11 Jul 2005 18:33:01 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 1/12] s390: spin lock retry.
Message-ID: <20050711163301.GA10822@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 1/12] s390: spin lock retry.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Split spin lock and r/w lock implementation into a single try which
is done inline and an out of line function that repeatedly tries
to get the lock before doing the cpu_relax(). Add a system control
to set the number of retries before a cpu is yielded.
The reason for the spin lock retry is that the diagnose 0x44 that
is used to give up the virtual cpu is quite expensive. For spin
locks that are held only for a short period of time the costs of
the diagnoses outweights the savings for spin locks that are held
for a longer timer. The default retry count is 1000.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/kernel/head64.S    |    3 
 arch/s390/kernel/setup.c     |    6 -
 arch/s390/lib/Makefile       |    4 
 arch/s390/lib/spinlock.c     |  133 ++++++++++++++++++++++
 include/asm-s390/lowcore.h   |    4 
 include/asm-s390/processor.h |    5 
 include/asm-s390/spinlock.h  |  258 +++++++++++++------------------------------
 include/linux/sysctl.h       |    1 
 kernel/sysctl.c              |   12 +-
 9 files changed, 233 insertions(+), 193 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/head64.S linux-2.6-patched/arch/s390/kernel/head64.S
--- linux-2.6/arch/s390/kernel/head64.S	2005-07-11 17:37:26.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/head64.S	2005-07-11 17:37:41.000000000 +0200
@@ -658,10 +658,8 @@ startup:basr  %r13,0                    
 #
 	la     %r1,0f-.LPG1(%r13)	# set program check address
 	stg    %r1,__LC_PGM_NEW_PSW+8
-	mvc    __LC_DIAG44_OPCODE(8),.Lnop-.LPG1(%r13)
 	diag   0,0,0x44			# test diag 0x44
 	oi     7(%r12),32		# set diag44 flag
-	mvc    __LC_DIAG44_OPCODE(8),.Ldiag44-.LPG1(%r13)
 0:	
 
 #
@@ -702,7 +700,6 @@ startup:basr  %r13,0                    
 .L4malign:.quad 0xffffffffffc00000
 .Lscan2g:.quad 0x80000000 + 0x20000 - 8 # 2GB + 128K - 8
 .Lnop:	.long  0x07000700
-.Ldiag44:.long 0x83000044
 
 	.org PARMAREA-64
 .Lduct:	.long 0,0,0,0,0,0,0,0
diff -urpN linux-2.6/arch/s390/kernel/setup.c linux-2.6-patched/arch/s390/kernel/setup.c
--- linux-2.6/arch/s390/kernel/setup.c	2005-07-11 17:37:26.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/setup.c	2005-07-11 17:37:41.000000000 +0200
@@ -437,12 +437,6 @@ setup_lowcore(void)
 		ctl_set_bit(14, 29);
 	}
 #endif
-#ifdef CONFIG_ARCH_S390X
-	if (MACHINE_HAS_DIAG44)
-		lc->diag44_opcode = 0x83000044;
-	else
-		lc->diag44_opcode = 0x07000700;
-#endif /* CONFIG_ARCH_S390X */
 	set_prefix((u32)(unsigned long) lc);
 }
 
diff -urpN linux-2.6/arch/s390/lib/Makefile linux-2.6-patched/arch/s390/lib/Makefile
--- linux-2.6/arch/s390/lib/Makefile	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/arch/s390/lib/Makefile	2005-07-11 17:37:41.000000000 +0200
@@ -5,5 +5,5 @@
 EXTRA_AFLAGS := -traditional
 
 lib-y += delay.o string.o
-lib-$(CONFIG_ARCH_S390_31) += uaccess.o
-lib-$(CONFIG_ARCH_S390X) += uaccess64.o
+lib-$(CONFIG_ARCH_S390_31) += uaccess.o spinlock.o
+lib-$(CONFIG_ARCH_S390X) += uaccess64.o spinlock.o
diff -urpN linux-2.6/arch/s390/lib/spinlock.c linux-2.6-patched/arch/s390/lib/spinlock.c
--- linux-2.6/arch/s390/lib/spinlock.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/arch/s390/lib/spinlock.c	2005-07-11 17:37:41.000000000 +0200
@@ -0,0 +1,133 @@
+/*
+ *  arch/s390/lib/spinlock.c
+ *    Out of line spinlock code.
+ *
+ *  S390 version
+ *    Copyright (C) 2004 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ *    Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com)
+ */
+
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/init.h>
+#include <asm/io.h>
+
+atomic_t spin_retry_counter;
+int spin_retry = 1000;
+
+/**
+ * spin_retry= parameter
+ */
+static int __init spin_retry_setup(char *str)
+{
+	spin_retry = simple_strtoul(str, &str, 0);
+	return 1;
+}
+__setup("spin_retry=", spin_retry_setup);
+
+static inline void
+_diag44(void)
+{
+#ifdef __s390x__
+	if (MACHINE_HAS_DIAG44)
+#endif
+		asm volatile("diag 0,0,0x44");
+}
+
+void
+_raw_spin_lock_wait(spinlock_t *lp, unsigned int pc)
+{
+	int count = spin_retry;
+
+	while (1) {
+		if (count-- <= 0) {
+			_diag44();
+			count = spin_retry;
+		}
+		atomic_inc(&spin_retry_counter);
+		if (_raw_compare_and_swap(&lp->lock, 0, pc) == 0)
+			return;
+	}
+}
+EXPORT_SYMBOL(_raw_spin_lock_wait);
+
+int
+_raw_spin_trylock_retry(spinlock_t *lp, unsigned int pc)
+{
+	int count = spin_retry;
+
+	while (count-- > 0) {
+		atomic_inc(&spin_retry_counter);
+		if (_raw_compare_and_swap(&lp->lock, 0, pc) == 0)
+			return 1;
+	}
+	return 0;
+}
+EXPORT_SYMBOL(_raw_spin_trylock_retry);
+
+void
+_raw_read_lock_wait(rwlock_t *rw)
+{
+	unsigned int old;
+	int count = spin_retry;
+
+	while (1) {
+		if (count-- <= 0) {
+			_diag44();
+			count = spin_retry;
+		}
+		atomic_inc(&spin_retry_counter);
+		old = rw->lock & 0x7fffffffU;
+		if (_raw_compare_and_swap(&rw->lock, old, old + 1) == old)
+			return;
+	}
+}
+EXPORT_SYMBOL(_raw_read_lock_wait);
+
+int
+_raw_read_trylock_retry(rwlock_t *rw)
+{
+	unsigned int old;
+	int count = spin_retry;
+
+	while (count-- > 0) {
+		atomic_inc(&spin_retry_counter);
+		old = rw->lock & 0x7fffffffU;
+		if (_raw_compare_and_swap(&rw->lock, old, old + 1) == old)
+			return 1;
+	}
+	return 0;
+}
+EXPORT_SYMBOL(_raw_read_trylock_retry);
+
+void
+_raw_write_lock_wait(rwlock_t *rw)
+{
+	int count = spin_retry;
+
+	while (1) {
+		if (count-- <= 0) {
+			_diag44();
+			count = spin_retry;
+		}
+		atomic_inc(&spin_retry_counter);
+		if (_raw_compare_and_swap(&rw->lock, 0, 0x80000000) == 0)
+			return;
+	}
+}
+EXPORT_SYMBOL(_raw_write_lock_wait);
+
+int
+_raw_write_trylock_retry(rwlock_t *rw)
+{
+	int count = spin_retry;
+
+	while (count-- > 0) {
+		atomic_inc(&spin_retry_counter);
+		if (_raw_compare_and_swap(&rw->lock, 0, 0x80000000) == 0)
+			return 1;
+	}
+	return 0;
+}
+EXPORT_SYMBOL(_raw_write_trylock_retry);
diff -urpN linux-2.6/include/asm-s390/lowcore.h linux-2.6-patched/include/asm-s390/lowcore.h
--- linux-2.6/include/asm-s390/lowcore.h	2005-07-11 17:37:35.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/lowcore.h	2005-07-11 17:37:41.000000000 +0200
@@ -90,7 +90,6 @@
 #define __LC_SYSTEM_TIMER		0x278
 #define __LC_LAST_UPDATE_CLOCK		0x280
 #define __LC_STEAL_CLOCK		0x288
-#define __LC_DIAG44_OPCODE		0x290
 #define __LC_KERNEL_STACK               0xD40
 #define __LC_THREAD_INFO		0xD48
 #define __LC_ASYNC_STACK                0xD50
@@ -286,8 +285,7 @@ struct _lowcore
 	__u64        system_timer;             /* 0x278 */
 	__u64        last_update_clock;        /* 0x280 */
 	__u64        steal_clock;              /* 0x288 */
-	__u32        diag44_opcode;            /* 0x290 */
-        __u8         pad8[0xc00-0x294];        /* 0x294 */
+        __u8         pad8[0xc00-0x290];        /* 0x290 */
         /* System info area */
 	__u64        save_area[16];            /* 0xc00 */
         __u8         pad9[0xd40-0xc80];        /* 0xc80 */
diff -urpN linux-2.6/include/asm-s390/processor.h linux-2.6-patched/include/asm-s390/processor.h
--- linux-2.6/include/asm-s390/processor.h	2005-07-11 17:37:35.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/processor.h	2005-07-11 17:37:41.000000000 +0200
@@ -203,7 +203,10 @@ unsigned long get_wchan(struct task_stru
 # define cpu_relax()	asm volatile ("diag 0,0,68" : : : "memory")
 #else /* __s390x__ */
 # define cpu_relax() \
-	asm volatile ("ex 0,%0" : : "i" (__LC_DIAG44_OPCODE) : "memory")
+	do { \
+		if (MACHINE_HAS_DIAG44) \
+			asm volatile ("diag 0,0,68" : : : "memory"); \
+	} while (0)
 #endif /* __s390x__ */
 
 /*
diff -urpN linux-2.6/include/asm-s390/spinlock.h linux-2.6-patched/include/asm-s390/spinlock.h
--- linux-2.6/include/asm-s390/spinlock.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/spinlock.h	2005-07-11 17:37:41.000000000 +0200
@@ -11,21 +11,16 @@
 #ifndef __ASM_SPINLOCK_H
 #define __ASM_SPINLOCK_H
 
-#ifdef __s390x__
-/*
- * Grmph, take care of %&#! user space programs that include
- * asm/spinlock.h. The diagnose is only available in kernel
- * context.
- */
-#ifdef __KERNEL__
-#include <asm/lowcore.h>
-#define __DIAG44_INSN "ex"
-#define __DIAG44_OPERAND __LC_DIAG44_OPCODE
-#else
-#define __DIAG44_INSN "#"
-#define __DIAG44_OPERAND 0
-#endif
-#endif /* __s390x__ */
+static inline int
+_raw_compare_and_swap(volatile unsigned int *lock,
+		      unsigned int old, unsigned int new)
+{
+	asm volatile ("cs %0,%3,0(%4)"
+		      : "=d" (old), "=m" (*lock)
+		      : "0" (old), "d" (new), "a" (lock), "m" (*lock)
+		      : "cc", "memory" );
+	return old;
+}
 
 /*
  * Simple spin lock operations.  There are two variants, one clears IRQ's
@@ -41,58 +36,35 @@ typedef struct {
 #endif
 } __attribute__ ((aligned (4))) spinlock_t;
 
-#define SPIN_LOCK_UNLOCKED (spinlock_t) { 0 }
-#define spin_lock_init(lp) do { (lp)->lock = 0; } while(0)
+#define SPIN_LOCK_UNLOCKED	(spinlock_t) { 0 }
+#define spin_lock_init(lp)	do { (lp)->lock = 0; } while(0)
 #define spin_unlock_wait(lp)	do { barrier(); } while(((volatile spinlock_t *)(lp))->lock)
-#define spin_is_locked(x) ((x)->lock != 0)
+#define spin_is_locked(x)	((x)->lock != 0)
 #define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
 
-extern inline void _raw_spin_lock(spinlock_t *lp)
+extern void _raw_spin_lock_wait(spinlock_t *lp, unsigned int pc);
+extern int _raw_spin_trylock_retry(spinlock_t *lp, unsigned int pc);
+
+static inline void _raw_spin_lock(spinlock_t *lp)
 {
-#ifndef __s390x__
-	unsigned int reg1, reg2;
-        __asm__ __volatile__("    bras  %0,1f\n"
-                           "0:  diag  0,0,68\n"
-                           "1:  slr   %1,%1\n"
-                           "    cs    %1,%0,0(%3)\n"
-                           "    jl    0b\n"
-                           : "=&d" (reg1), "=&d" (reg2), "=m" (lp->lock)
-			   : "a" (&lp->lock), "m" (lp->lock)
-			   : "cc", "memory" );
-#else /* __s390x__ */
-	unsigned long reg1, reg2;
-        __asm__ __volatile__("    bras  %1,1f\n"
-                           "0:  " __DIAG44_INSN " 0,%4\n"
-                           "1:  slr   %0,%0\n"
-                           "    cs    %0,%1,0(%3)\n"
-                           "    jl    0b\n"
-                           : "=&d" (reg1), "=&d" (reg2), "=m" (lp->lock)
-			   : "a" (&lp->lock), "i" (__DIAG44_OPERAND),
-			     "m" (lp->lock) : "cc", "memory" );
-#endif /* __s390x__ */
-}
-
-extern inline int _raw_spin_trylock(spinlock_t *lp)
-{
-	unsigned long reg;
-	unsigned int result;
-
-	__asm__ __volatile__("    basr  %1,0\n"
-			   "0:  cs    %0,%1,0(%3)"
-			   : "=d" (result), "=&d" (reg), "=m" (lp->lock)
-			   : "a" (&lp->lock), "m" (lp->lock), "0" (0)
-			   : "cc", "memory" );
-	return !result;
+	unsigned long pc = (unsigned long) __builtin_return_address(0);
+
+	if (unlikely(_raw_compare_and_swap(&lp->lock, 0, pc) != 0))
+		_raw_spin_lock_wait(lp, pc);
 }
 
-extern inline void _raw_spin_unlock(spinlock_t *lp)
+static inline int _raw_spin_trylock(spinlock_t *lp)
 {
-	unsigned int old;
+	unsigned long pc = (unsigned long) __builtin_return_address(0);
 
-	__asm__ __volatile__("cs %0,%3,0(%4)"
-			   : "=d" (old), "=m" (lp->lock)
-			   : "0" (lp->lock), "d" (0), "a" (lp)
-			   : "cc", "memory" );
+	if (likely(_raw_compare_and_swap(&lp->lock, 0, pc) == 0))
+		return 1;
+	return _raw_spin_trylock_retry(lp, pc);
+}
+
+static inline void _raw_spin_unlock(spinlock_t *lp)
+{
+	_raw_compare_and_swap(&lp->lock, lp->lock, 0);
 }
 		
 /*
@@ -106,7 +78,7 @@ extern inline void _raw_spin_unlock(spin
  * read-locks.
  */
 typedef struct {
-	volatile unsigned long lock;
+	volatile unsigned int lock;
 	volatile unsigned long owner_pc;
 #ifdef CONFIG_PREEMPT
 	unsigned int break_lock;
@@ -129,123 +101,55 @@ typedef struct {
  */
 #define write_can_lock(x) ((x)->lock == 0)
 
-#ifndef __s390x__
-#define _raw_read_lock(rw)   \
-        asm volatile("   l     2,0(%1)\n"   \
-                     "   j     1f\n"     \
-                     "0: diag  0,0,68\n" \
-                     "1: la    2,0(2)\n"     /* clear high (=write) bit */ \
-                     "   la    3,1(2)\n"     /* one more reader */ \
-                     "   cs    2,3,0(%1)\n"  /* try to write new value */ \
-                     "   jl    0b"       \
-                     : "=m" ((rw)->lock) : "a" (&(rw)->lock), \
-		       "m" ((rw)->lock) : "2", "3", "cc", "memory" )
-#else /* __s390x__ */
-#define _raw_read_lock(rw)   \
-        asm volatile("   lg    2,0(%1)\n"   \
-                     "   j     1f\n"     \
-                     "0: " __DIAG44_INSN " 0,%2\n" \
-                     "1: nihh  2,0x7fff\n" /* clear high (=write) bit */ \
-                     "   la    3,1(2)\n"   /* one more reader */  \
-                     "   csg   2,3,0(%1)\n" /* try to write new value */ \
-                     "   jl    0b"       \
-                     : "=m" ((rw)->lock) \
-		     : "a" (&(rw)->lock), "i" (__DIAG44_OPERAND), \
-		       "m" ((rw)->lock) : "2", "3", "cc", "memory" )
-#endif /* __s390x__ */
-
-#ifndef __s390x__
-#define _raw_read_unlock(rw) \
-        asm volatile("   l     2,0(%1)\n"   \
-                     "   j     1f\n"     \
-                     "0: diag  0,0,68\n" \
-                     "1: lr    3,2\n"    \
-                     "   ahi   3,-1\n"    /* one less reader */ \
-                     "   cs    2,3,0(%1)\n" \
-                     "   jl    0b"       \
-                     : "=m" ((rw)->lock) : "a" (&(rw)->lock), \
-		       "m" ((rw)->lock) : "2", "3", "cc", "memory" )
-#else /* __s390x__ */
-#define _raw_read_unlock(rw) \
-        asm volatile("   lg    2,0(%1)\n"   \
-                     "   j     1f\n"     \
-                     "0: " __DIAG44_INSN " 0,%2\n" \
-                     "1: lgr   3,2\n"    \
-                     "   bctgr 3,0\n"    /* one less reader */ \
-                     "   csg   2,3,0(%1)\n" \
-                     "   jl    0b"       \
-                     : "=m" ((rw)->lock) \
-		     : "a" (&(rw)->lock), "i" (__DIAG44_OPERAND), \
-		       "m" ((rw)->lock) : "2", "3", "cc", "memory" )
-#endif /* __s390x__ */
-
-#ifndef __s390x__
-#define _raw_write_lock(rw) \
-        asm volatile("   lhi   3,1\n"    \
-                     "   sll   3,31\n"    /* new lock value = 0x80000000 */ \
-                     "   j     1f\n"     \
-                     "0: diag  0,0,68\n" \
-                     "1: slr   2,2\n"     /* old lock value must be 0 */ \
-                     "   cs    2,3,0(%1)\n" \
-                     "   jl    0b"       \
-                     : "=m" ((rw)->lock) : "a" (&(rw)->lock), \
-		       "m" ((rw)->lock) : "2", "3", "cc", "memory" )
-#else /* __s390x__ */
-#define _raw_write_lock(rw) \
-        asm volatile("   llihh 3,0x8000\n" /* new lock value = 0x80...0 */ \
-                     "   j     1f\n"       \
-                     "0: " __DIAG44_INSN " 0,%2\n"   \
-                     "1: slgr  2,2\n"      /* old lock value must be 0 */ \
-                     "   csg   2,3,0(%1)\n" \
-                     "   jl    0b"         \
-                     : "=m" ((rw)->lock) \
-		     : "a" (&(rw)->lock), "i" (__DIAG44_OPERAND), \
-		       "m" ((rw)->lock) : "2", "3", "cc", "memory" )
-#endif /* __s390x__ */
-
-#ifndef __s390x__
-#define _raw_write_unlock(rw) \
-        asm volatile("   slr   3,3\n"     /* new lock value = 0 */ \
-                     "   j     1f\n"     \
-                     "0: diag  0,0,68\n" \
-                     "1: lhi   2,1\n"    \
-                     "   sll   2,31\n"    /* old lock value must be 0x80000000 */ \
-                     "   cs    2,3,0(%1)\n" \
-                     "   jl    0b"       \
-                     : "=m" ((rw)->lock) : "a" (&(rw)->lock), \
-		       "m" ((rw)->lock) : "2", "3", "cc", "memory" )
-#else /* __s390x__ */
-#define _raw_write_unlock(rw) \
-        asm volatile("   slgr  3,3\n"      /* new lock value = 0 */ \
-                     "   j     1f\n"       \
-                     "0: " __DIAG44_INSN " 0,%2\n"   \
-                     "1: llihh 2,0x8000\n" /* old lock value must be 0x8..0 */\
-                     "   csg   2,3,0(%1)\n"   \
-                     "   jl    0b"         \
-                     : "=m" ((rw)->lock) \
-		     : "a" (&(rw)->lock), "i" (__DIAG44_OPERAND), \
-		       "m" ((rw)->lock) : "2", "3", "cc", "memory" )
-#endif /* __s390x__ */
-
-#define _raw_read_trylock(lock) generic_raw_read_trylock(lock)
-
-extern inline int _raw_write_trylock(rwlock_t *rw)
-{
-	unsigned long result, reg;
-	
-	__asm__ __volatile__(
-#ifndef __s390x__
-			     "   lhi  %1,1\n"
-			     "   sll  %1,31\n"
-			     "   cs   %0,%1,0(%3)"
-#else /* __s390x__ */
-			     "   llihh %1,0x8000\n"
-			     "0: csg %0,%1,0(%3)\n"
-#endif /* __s390x__ */
-			     : "=d" (result), "=&d" (reg), "=m" (rw->lock)
-			     : "a" (&rw->lock), "m" (rw->lock), "0" (0UL)
-			     : "cc", "memory" );
-	return result == 0;
+extern void _raw_read_lock_wait(rwlock_t *lp);
+extern int _raw_read_trylock_retry(rwlock_t *lp);
+extern void _raw_write_lock_wait(rwlock_t *lp);
+extern int _raw_write_trylock_retry(rwlock_t *lp);
+
+static inline void _raw_read_lock(rwlock_t *rw)
+{
+	unsigned int old;
+	old = rw->lock & 0x7fffffffU;
+	if (_raw_compare_and_swap(&rw->lock, old, old + 1) != old)
+		_raw_read_lock_wait(rw);
+}
+
+static inline void _raw_read_unlock(rwlock_t *rw)
+{
+	unsigned int old, cmp;
+
+	old = rw->lock;
+	do {
+		cmp = old;
+		old = _raw_compare_and_swap(&rw->lock, old, old - 1);
+	} while (cmp != old);
+}
+
+static inline void _raw_write_lock(rwlock_t *rw)
+{
+	if (unlikely(_raw_compare_and_swap(&rw->lock, 0, 0x80000000) != 0))
+		_raw_write_lock_wait(rw);
+}
+
+static inline void _raw_write_unlock(rwlock_t *rw)
+{
+	_raw_compare_and_swap(&rw->lock, 0x80000000, 0);
+}
+
+static inline int _raw_read_trylock(rwlock_t *rw)
+{
+	unsigned int old;
+	old = rw->lock & 0x7fffffffU;
+	if (likely(_raw_compare_and_swap(&rw->lock, old, old + 1) == old))
+		return 1;
+	return _raw_read_trylock_retry(rw);
+}
+
+static inline int _raw_write_trylock(rwlock_t *rw)
+{
+	if (likely(_raw_compare_and_swap(&rw->lock, 0, 0x80000000) == 0))
+		return 1;
+	return _raw_write_trylock_retry(rw);
 }
 
 #endif /* __ASM_SPINLOCK_H */
diff -urpN linux-2.6/include/linux/sysctl.h linux-2.6-patched/include/linux/sysctl.h
--- linux-2.6/include/linux/sysctl.h	2005-07-11 17:37:35.000000000 +0200
+++ linux-2.6-patched/include/linux/sysctl.h	2005-07-11 17:37:41.000000000 +0200
@@ -137,6 +137,7 @@ enum
 	KERN_BOOTLOADER_TYPE=67, /* int: boot loader type */
 	KERN_RANDOMIZE=68, /* int: randomize virtual address space */
 	KERN_SETUID_DUMPABLE=69, /* int: behaviour of dumps for setuid core */
+	KERN_SPIN_RETRY=70,	/* int: number of spinlock retries */
 };
 
 
diff -urpN linux-2.6/kernel/sysctl.c linux-2.6-patched/kernel/sysctl.c
--- linux-2.6/kernel/sysctl.c	2005-07-11 17:37:35.000000000 +0200
+++ linux-2.6-patched/kernel/sysctl.c	2005-07-11 17:37:41.000000000 +0200
@@ -114,6 +114,7 @@ extern int unaligned_enabled;
 extern int sysctl_ieee_emulation_warnings;
 #endif
 extern int sysctl_userprocess_debug;
+extern int spin_retry;
 #endif
 
 extern int sysctl_hz_timer;
@@ -643,7 +644,16 @@ static ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
 	},
-
+#if defined(CONFIG_ARCH_S390)
+	{
+		.ctl_name	= KERN_SPIN_RETRY,
+		.procname	= "spin_retry",
+		.data		= &spin_retry,
+		.maxlen		= sizeof (int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+#endif
 	{ .ctl_name = 0 }
 };
 
