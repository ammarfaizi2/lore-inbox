Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262132AbVATMAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262132AbVATMAt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 07:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbVATMAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 07:00:49 -0500
Received: from mx1.elte.hu ([157.181.1.137]:41862 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262133AbVATL76 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 06:59:58 -0500
Date: Thu, 20 Jan 2005 12:59:47 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
Subject: [patch 2/3] spinlock fix #2: generalize [spin|rw]lock yielding
Message-ID: <20050120115947.GA31305@elte.hu>
References: <20050120114317.GA29876@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050120114317.GA29876@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this patch generalizes the facility of targeted lock-yielding originally
implemented for ppc64. This facility enables a virtual CPU to indicate
towards the hypervisor which other virtual CPU this CPU is 'blocked on',
and hence which CPU the hypervisor should yield the current timeslice
to, in order to make progress on releasing the lock.

On physical platforms these functions default to cpu_relax(). Since
physical platforms are in the overwhelming majority i've added the two
new functions to the new asm-generic/spinlock.h include file - here i
hope we can later on move more generic spinlock bits as well.

this patch solves the ppc64/PREEMPT functionality-regression reported by
Paul Mackerras. I only tested it on x86, Paul, would you mind to test it
on ppc64?

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/kernel/spinlock.c.orig
+++ linux/kernel/spinlock.c
@@ -184,7 +184,7 @@ void __lockfunc _##op##_lock(locktype##_
 		if (!(lock)->break_lock)				\
 			(lock)->break_lock = 1;				\
 		while (!op##_trylock_test(lock) && (lock)->break_lock)	\
-			cpu_relax();					\
+			locktype##_yield(lock);				\
 		preempt_disable();					\
 	}								\
 }									\
@@ -206,7 +206,7 @@ unsigned long __lockfunc _##op##_lock_ir
 		if (!(lock)->break_lock)				\
 			(lock)->break_lock = 1;				\
 		while (!op##_trylock_test(lock) && (lock)->break_lock)	\
-			cpu_relax();					\
+			locktype##_yield(lock);				\
 		preempt_disable();					\
 	}								\
 	return flags;							\
--- linux/arch/ppc64/lib/locks.c.orig
+++ linux/arch/ppc64/lib/locks.c
@@ -23,7 +23,7 @@
 /* waiting for a spinlock... */
 #if defined(CONFIG_PPC_SPLPAR) || defined(CONFIG_PPC_ISERIES)
 
-void __spin_yield(spinlock_t *lock)
+void spinlock_yield(spinlock_t *lock)
 {
 	unsigned int lock_value, holder_cpu, yield_count;
 	struct paca_struct *holder_paca;
@@ -54,7 +54,7 @@ void __spin_yield(spinlock_t *lock)
  * This turns out to be the same for read and write locks, since
  * we only know the holder if it is write-locked.
  */
-void __rw_yield(rwlock_t *rw)
+void rwlock_yield(rwlock_t *rw)
 {
 	int lock_value;
 	unsigned int holder_cpu, yield_count;
@@ -87,7 +87,7 @@ void spin_unlock_wait(spinlock_t *lock)
 	while (lock->lock) {
 		HMT_low();
 		if (SHARED_PROCESSOR)
-			__spin_yield(lock);
+			spinlock_yield(lock);
 	}
 	HMT_medium();
 }
--- linux/include/asm-ia64/spinlock.h.orig
+++ linux/include/asm-ia64/spinlock.h
@@ -17,6 +17,8 @@
 #include <asm/intrinsics.h>
 #include <asm/system.h>
 
+#include <asm-generic/spinlock.h>
+
 typedef struct {
 	volatile unsigned int lock;
 #ifdef CONFIG_PREEMPT
--- linux/include/asm-generic/spinlock.h.orig
+++ linux/include/asm-generic/spinlock.h
@@ -0,0 +1,11 @@
+#ifndef _ASM_GENERIC_SPINLOCK_H
+#define _ASM_GENERIC_SPINLOCK_H
+
+/*
+ * Virtual platforms might use these to
+ * yield to specific virtual CPUs:
+ */
+#define spinlock_yield(lock)	cpu_relax()
+#define rwlock_yield(lock)	cpu_relax()
+
+#endif /* _ASM_GENERIC_SPINLOCK_H */
--- linux/include/linux/spinlock.h.orig
+++ linux/include/linux/spinlock.h
@@ -206,6 +206,8 @@ typedef struct {
 #define _raw_spin_unlock(lock) do { (void)(lock); } while(0)
 #endif /* CONFIG_DEBUG_SPINLOCK */
 
+#define spinlock_yield(lock)	(void)(lock)
+
 /* RW spinlocks: No debug version */
 
 #if (__GNUC__ > 2)
@@ -224,6 +226,8 @@ typedef struct {
 #define _raw_read_trylock(lock) ({ (void)(lock); (1); })
 #define _raw_write_trylock(lock) ({ (void)(lock); (1); })
 
+#define rwlock_yield(lock)	(void)(lock)
+
 #define _spin_trylock(lock)	({preempt_disable(); _raw_spin_trylock(lock) ? \
 				1 : ({preempt_enable(); 0;});})
 
--- linux/include/asm-i386/spinlock.h.orig
+++ linux/include/asm-i386/spinlock.h
@@ -7,6 +7,8 @@
 #include <linux/config.h>
 #include <linux/compiler.h>
 
+#include <asm-generic/spinlock.h>
+
 asmlinkage int printk(const char * fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
 
--- linux/include/asm-ppc64/spinlock.h.orig
+++ linux/include/asm-ppc64/spinlock.h
@@ -64,11 +64,11 @@ static __inline__ void _raw_spin_unlock(
 #if defined(CONFIG_PPC_SPLPAR) || defined(CONFIG_PPC_ISERIES)
 /* We only yield to the hypervisor if we are in shared processor mode */
 #define SHARED_PROCESSOR (get_paca()->lppaca.shared_proc)
-extern void __spin_yield(spinlock_t *lock);
-extern void __rw_yield(rwlock_t *lock);
+extern void spinlock_yield(spinlock_t *lock);
+extern void rwlock_yield(rwlock_t *lock);
 #else /* SPLPAR || ISERIES */
-#define __spin_yield(x)	barrier()
-#define __rw_yield(x)	barrier()
+#define spinlock_yield(x)	barrier()
+#define rwlock_yield(x)	barrier()
 #define SHARED_PROCESSOR	0
 #endif
 extern void spin_unlock_wait(spinlock_t *lock);
@@ -109,7 +109,7 @@ static void __inline__ _raw_spin_lock(sp
 		do {
 			HMT_low();
 			if (SHARED_PROCESSOR)
-				__spin_yield(lock);
+				spinlock_yield(lock);
 		} while (likely(lock->lock != 0));
 		HMT_medium();
 	}
@@ -127,7 +127,7 @@ static void __inline__ _raw_spin_lock_fl
 		do {
 			HMT_low();
 			if (SHARED_PROCESSOR)
-				__spin_yield(lock);
+				spinlock_yield(lock);
 		} while (likely(lock->lock != 0));
 		HMT_medium();
 		local_irq_restore(flags_dis);
@@ -201,7 +201,7 @@ static void __inline__ _raw_read_lock(rw
 		do {
 			HMT_low();
 			if (SHARED_PROCESSOR)
-				__rw_yield(rw);
+				rwlock_yield(rw);
 		} while (likely(rw->lock < 0));
 		HMT_medium();
 	}
@@ -258,7 +258,7 @@ static void __inline__ _raw_write_lock(r
 		do {
 			HMT_low();
 			if (SHARED_PROCESSOR)
-				__rw_yield(rw);
+				rwlock_yield(rw);
 		} while (likely(rw->lock != 0));
 		HMT_medium();
 	}
--- linux/include/asm-x86_64/spinlock.h.orig
+++ linux/include/asm-x86_64/spinlock.h
@@ -6,6 +6,8 @@
 #include <asm/page.h>
 #include <linux/config.h>
 
+#include <asm-generic/spinlock.h>
+
 extern int printk(const char * fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
 
