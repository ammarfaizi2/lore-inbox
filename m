Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262207AbVATQNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262207AbVATQNk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 11:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbVATQM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 11:12:27 -0500
Received: from mx1.elte.hu ([157.181.1.137]:50892 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262181AbVATQJP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 11:09:15 -0500
Date: Thu, 20 Jan 2005 17:08:39 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Peter Chubb <peterc@gelato.unsw.edu.au>, Chris Wedgwood <cw@f00f.org>,
       Andrew Morton <akpm@osdl.org>, paulus@samba.org,
       linux-kernel@vger.kernel.org, tony.luck@intel.com,
       dsw@gelato.unsw.edu.au, benh@kernel.crashing.org,
       linux-ia64@vger.kernel.org, hch@infradead.org, wli@holomorphy.com,
       jbarnes@sgi.com
Subject: [patch 1/3] spinlock fix #1, *_can_lock() primitives
Message-ID: <20050120160839.GA13067@elte.hu>
References: <16877.42598.336096.561224@wombat.chubb.wattle.id.au> <20050119080403.GB29037@elte.hu> <16878.9678.73202.771962@wombat.chubb.wattle.id.au> <20050119092013.GA2045@elte.hu> <16878.54402.344079.528038@cargo.ozlabs.ibm.com> <20050120023445.GA3475@taniwha.stupidest.org> <20050119190104.71f0a76f.akpm@osdl.org> <20050120031854.GA8538@taniwha.stupidest.org> <16879.29449.734172.893834@wombat.chubb.wattle.id.au> <Pine.LNX.4.58.0501200747230.8178@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501200747230.8178@ppc970.osdl.org>
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


* Linus Torvalds <torvalds@osdl.org> wrote:

> We have a sense problem with the "trylock()" cases - some return "it
> was locked" (semaphores), and some return "I succeeded" (spinlocks),
> so not only is the sense not immediately obvious from the usage, it's
> actually _different_ for semaphores and for spinlocks.

well, this is primarily a problem of the semaphore primitives. 

anyway, here's my first patch again, with s/trylock_test/can_lock/.

	Ingo

--
it fixes the BUILD_LOCK_OPS() bug by introducing the following 3 new
locking primitives:

  spin_can_lock(lock)
  read_can_lock(lock)
  write_can_lock(lock)

this is what is needed by BUILD_LOCK_OPS(): a nonintrusive test to check
whether the real (intrusive) trylock op would succeed or not. Semantics
and naming is completely symmetric to the trylock counterpart. No
changes to exit.c.

build/boot-tested on x86. Architectures that want to support PREEMPT
need to add these definitions.

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
+		while (!op##_can_lock(lock) && (lock)->break_lock)	\
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
+		while (!op##_can_lock(lock) && (lock)->break_lock)	\
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
+ * spin_can_lock - would spin_trylock() succeed?
+ * @lock: the spinlock in question.
+ */
+#define spin_can_lock(lock)		(!spin_is_locked(lock))
+
 #endif /* __LINUX_SPINLOCK_H */
--- linux/include/asm-i386/spinlock.h.orig
+++ linux/include/asm-i386/spinlock.h
@@ -188,6 +188,18 @@ typedef struct {
 
 #define rwlock_is_locked(x) ((x)->lock != RW_LOCK_BIAS)
 
+/**
+ * read_can_lock - would read_trylock() succeed?
+ * @lock: the rwlock in question.
+ */
+#define read_can_lock(x) (atomic_read((atomic_t *)&(x)->lock) > 0)
+
+/**
+ * write_can_lock - would write_trylock() succeed?
+ * @lock: the rwlock in question.
+ */
+#define write_can_lock(x) ((x)->lock == RW_LOCK_BIAS)
+
 /*
  * On x86, we implement read-write locks as a 32-bit counter
  * with the high bit (sign) being the "contended" bit.
