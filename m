Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262129AbVATLne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbVATLne (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 06:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbVATLnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 06:43:33 -0500
Received: from mx1.elte.hu ([157.181.1.137]:44417 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262127AbVATLn0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 06:43:26 -0500
Date: Thu, 20 Jan 2005 12:43:17 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 1/3] spinlock fix #1
Message-ID: <20050120114317.GA29876@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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


i've split up spinlocking-fixes.patch into 3 parts and reworked them. 
This is the first one, against BK-curr:

it fixes the BUILD_LOCK_OPS() bug by introducing the following 3 new
locking primitives:

  spin_trylock_test(lock)
  read_trylock_test(lock)
  write_trylock_test(lock)

this is what is needed by BUILD_LOCK_OPS(): a nonintrusive test to check
whether the real (intrusive) trylock op would succeed or not. Semantics
and naming is completely symmetric to the trylock counterpart. No
changes to exit.c.

build/boot-tested on x86. Architectures that want to support PREEMPT
need to add these definitions.

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/kernel/spinlock.c.orig
+++ linux/kernel/spinlock.c
@@ -173,8 +173,8 @@ EXPORT_SYMBOL(_write_lock);
  * (We do this in a function because inlining it would be excessive.)
  */
 
-#define BUILD_LOCK_OPS(op, locktype, is_locked_fn)			\
-void __lockfunc _##op##_lock(locktype *lock)				\
+#define BUILD_LOCK_OPS(op, locktype)					\
+void __lockfunc _##op##_lock(locktype##_t *lock)			\
 {									\
 	preempt_disable();						\
 	for (;;) {							\
@@ -183,7 +183,7 @@ void __lockfunc _##op##_lock(locktype *l
 		preempt_enable();					\
 		if (!(lock)->break_lock)				\
 			(lock)->break_lock = 1;				\
-		while (is_locked_fn(lock) && (lock)->break_lock)	\
+		while (!op##_trylock_test(lock) && (lock)->break_lock)	\
 			cpu_relax();					\
 		preempt_disable();					\
 	}								\
@@ -191,7 +191,7 @@ void __lockfunc _##op##_lock(locktype *l
 									\
 EXPORT_SYMBOL(_##op##_lock);						\
 									\
-unsigned long __lockfunc _##op##_lock_irqsave(locktype *lock)		\
+unsigned long __lockfunc _##op##_lock_irqsave(locktype##_t *lock)	\
 {									\
 	unsigned long flags;						\
 									\
@@ -205,7 +205,7 @@ unsigned long __lockfunc _##op##_lock_ir
 		preempt_enable();					\
 		if (!(lock)->break_lock)				\
 			(lock)->break_lock = 1;				\
-		while (is_locked_fn(lock) && (lock)->break_lock)	\
+		while (!op##_trylock_test(lock) && (lock)->break_lock)	\
 			cpu_relax();					\
 		preempt_disable();					\
 	}								\
@@ -214,14 +214,14 @@ unsigned long __lockfunc _##op##_lock_ir
 									\
 EXPORT_SYMBOL(_##op##_lock_irqsave);					\
 									\
-void __lockfunc _##op##_lock_irq(locktype *lock)			\
+void __lockfunc _##op##_lock_irq(locktype##_t *lock)			\
 {									\
 	_##op##_lock_irqsave(lock);					\
 }									\
 									\
 EXPORT_SYMBOL(_##op##_lock_irq);					\
 									\
-void __lockfunc _##op##_lock_bh(locktype *lock)				\
+void __lockfunc _##op##_lock_bh(locktype##_t *lock)			\
 {									\
 	unsigned long flags;						\
 									\
@@ -246,9 +246,9 @@ EXPORT_SYMBOL(_##op##_lock_bh)
  *         _[spin|read|write]_lock_irqsave()
  *         _[spin|read|write]_lock_bh()
  */
-BUILD_LOCK_OPS(spin, spinlock_t, spin_is_locked);
-BUILD_LOCK_OPS(read, rwlock_t, rwlock_is_locked);
-BUILD_LOCK_OPS(write, rwlock_t, spin_is_locked);
+BUILD_LOCK_OPS(spin, spinlock);
+BUILD_LOCK_OPS(read, rwlock);
+BUILD_LOCK_OPS(write, rwlock);
 
 #endif /* CONFIG_PREEMPT */
 
--- linux/include/linux/spinlock.h.orig
+++ linux/include/linux/spinlock.h
@@ -584,4 +584,10 @@ static inline int bit_spin_is_locked(int
 #define DEFINE_SPINLOCK(x) spinlock_t x = SPIN_LOCK_UNLOCKED
 #define DEFINE_RWLOCK(x) rwlock_t x = RW_LOCK_UNLOCKED
 
+/**
+ * spin_trylock_test - would spin_trylock() succeed?
+ * @lock: the spinlock in question.
+ */
+#define spin_trylock_test(lock)		(!spin_is_locked(lock))
+
 #endif /* __LINUX_SPINLOCK_H */
--- linux/include/asm-i386/spinlock.h.orig
+++ linux/include/asm-i386/spinlock.h
@@ -188,6 +188,18 @@ typedef struct {
 
 #define rwlock_is_locked(x) ((x)->lock != RW_LOCK_BIAS)
 
+/**
+ * read_trylock_test - would read_trylock() succeed?
+ * @lock: the rwlock in question.
+ */
+#define read_trylock_test(x) (atomic_read((atomic_t *)&(x)->lock) > 0)
+
+/**
+ * write_trylock_test - would write_trylock() succeed?
+ * @lock: the rwlock in question.
+ */
+#define write_trylock_test(x) ((x)->lock == RW_LOCK_BIAS)
+
 /*
  * On x86, we implement read-write locks as a 32-bit counter
  * with the high bit (sign) being the "contended" bit.
