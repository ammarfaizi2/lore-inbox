Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030256AbWIETP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030256AbWIETP7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 15:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030259AbWIETP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 15:15:59 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:59344 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030256AbWIETP5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 15:15:57 -0400
Date: Tue, 5 Sep 2006 21:08:07 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjan@infradead.org>,
       Daniel Walker <dwalker@mvista.com>, Hua Zhong <hzhong@gmail.com>
Subject: Re: lockdep oddity
Message-ID: <20060905190807.GA27171@elte.hu>
References: <20060901015818.42767813.akpm@osdl.org> <20060905130356.GB6940@osiris.boeblingen.de.ibm.com> <20060905181241.GC16207@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060905181241.GC16207@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> > The reason is that the BUILD_LOCK_OPS macros in kernel/lockdep.c 
> > don't contain any of the *_acquire calls, while all of the _unlock 
> > functions contain a *_release call. Hence I get immediately 
> > unbalanced locks.
> 
> hmmm ... that sounds like a bug. Weird - i recently ran 
> PREEMPT+SMP+LOCKDEP kernels and didnt notice this.

ok, the reason i didnt find this problem is because this is fixed in my 
tree, but i didnt realize that it's a fix also for upstream ...

The patch below is what is in my tree, but that needs separation from 
other changes. I'll distill a patch for upstream.

	Ingo

NOT-Signed-off-by: Ingo Molnar <mingo@elte.hu>

Index: linux/kernel/spinlock.c
===================================================================
--- linux.orig/kernel/spinlock.c
+++ linux/kernel/spinlock.c
@@ -20,14 +20,14 @@
  * Generic declaration of the raw read_trylock() function,
  * architectures are supposed to optimize this:
  */
-int __lockfunc generic__raw_read_trylock(raw_rwlock_t *lock)
+int __lockfunc generic_raw_read_trylock(raw_rwlock_t *lock)
 {
-	__raw_read_lock(lock);
+	_raw_read_lock(lock);
 	return 1;
 }
-EXPORT_SYMBOL(generic__raw_read_trylock);
+EXPORT_SYMBOL(generic_raw_read_trylock);
 
-int __lockfunc _spin_trylock(spinlock_t *lock)
+int __lockfunc __spin_trylock(raw_spinlock_t *lock)
 {
 	preempt_disable();
 	if (_raw_spin_trylock(lock)) {
@@ -38,9 +38,46 @@ int __lockfunc _spin_trylock(spinlock_t 
 	preempt_enable();
 	return 0;
 }
-EXPORT_SYMBOL(_spin_trylock);
+EXPORT_SYMBOL(__spin_trylock);
+
+int __lockfunc __spin_trylock_irq(raw_spinlock_t *lock)
+{
+	local_irq_disable();
+	preempt_disable();
+
+	if (_raw_spin_trylock(lock)) {
+		spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
+		return 1;
+	}
+
+	__preempt_enable_no_resched();
+	local_irq_enable();
+	preempt_check_resched();
+
+	return 0;
+}
+EXPORT_SYMBOL(__spin_trylock_irq);
 
-int __lockfunc _read_trylock(rwlock_t *lock)
+int __lockfunc __spin_trylock_irqsave(raw_spinlock_t *lock,
+					 unsigned long *flags)
+{
+	local_irq_save(*flags);
+	preempt_disable();
+
+	if (_raw_spin_trylock(lock)) {
+		spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
+		return 1;
+	}
+
+	__preempt_enable_no_resched();
+	local_irq_restore(*flags);
+	preempt_check_resched();
+
+	return 0;
+}
+EXPORT_SYMBOL(__spin_trylock_irqsave);
+
+int __lockfunc __read_trylock(raw_rwlock_t *lock)
 {
 	preempt_disable();
 	if (_raw_read_trylock(lock)) {
@@ -51,9 +88,9 @@ int __lockfunc _read_trylock(rwlock_t *l
 	preempt_enable();
 	return 0;
 }
-EXPORT_SYMBOL(_read_trylock);
+EXPORT_SYMBOL(__read_trylock);
 
-int __lockfunc _write_trylock(rwlock_t *lock)
+int __lockfunc __write_trylock(raw_rwlock_t *lock)
 {
 	preempt_disable();
 	if (_raw_write_trylock(lock)) {
@@ -64,7 +101,7 @@ int __lockfunc _write_trylock(rwlock_t *
 	preempt_enable();
 	return 0;
 }
-EXPORT_SYMBOL(_write_trylock);
+EXPORT_SYMBOL(__write_trylock);
 
 /*
  * If lockdep is enabled then we use the non-preemption spin-ops
@@ -72,17 +109,17 @@ EXPORT_SYMBOL(_write_trylock);
  * not re-enabled during lock-acquire (which the preempt-spin-ops do):
  */
 #if !defined(CONFIG_PREEMPT) || !defined(CONFIG_SMP) || \
-	defined(CONFIG_PROVE_LOCKING)
+	defined(CONFIG_DEBUG_LOCK_ALLOC) || defined(CONFIG_PREEMPT_RT)
 
-void __lockfunc _read_lock(rwlock_t *lock)
+void __lockfunc __read_lock(raw_rwlock_t *lock)
 {
 	preempt_disable();
 	rwlock_acquire_read(&lock->dep_map, 0, 0, _RET_IP_);
 	_raw_read_lock(lock);
 }
-EXPORT_SYMBOL(_read_lock);
+EXPORT_SYMBOL(__read_lock);
 
-unsigned long __lockfunc _spin_lock_irqsave(spinlock_t *lock)
+unsigned long __lockfunc __spin_lock_irqsave(raw_spinlock_t *lock)
 {
 	unsigned long flags;
 
@@ -101,27 +138,27 @@ unsigned long __lockfunc _spin_lock_irqs
 #endif
 	return flags;
 }
-EXPORT_SYMBOL(_spin_lock_irqsave);
+EXPORT_SYMBOL(__spin_lock_irqsave);
 
-void __lockfunc _spin_lock_irq(spinlock_t *lock)
+void __lockfunc __spin_lock_irq(raw_spinlock_t *lock)
 {
 	local_irq_disable();
 	preempt_disable();
 	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
 	_raw_spin_lock(lock);
 }
-EXPORT_SYMBOL(_spin_lock_irq);
+EXPORT_SYMBOL(__spin_lock_irq);
 
-void __lockfunc _spin_lock_bh(spinlock_t *lock)
+void __lockfunc __spin_lock_bh(raw_spinlock_t *lock)
 {
 	local_bh_disable();
 	preempt_disable();
 	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
 	_raw_spin_lock(lock);
 }
-EXPORT_SYMBOL(_spin_lock_bh);
+EXPORT_SYMBOL(__spin_lock_bh);
 
-unsigned long __lockfunc _read_lock_irqsave(rwlock_t *lock)
+unsigned long __lockfunc __read_lock_irqsave(raw_rwlock_t *lock)
 {
 	unsigned long flags;
 
@@ -131,27 +168,27 @@ unsigned long __lockfunc _read_lock_irqs
 	_raw_read_lock(lock);
 	return flags;
 }
-EXPORT_SYMBOL(_read_lock_irqsave);
+EXPORT_SYMBOL(__read_lock_irqsave);
 
-void __lockfunc _read_lock_irq(rwlock_t *lock)
+void __lockfunc __read_lock_irq(raw_rwlock_t *lock)
 {
 	local_irq_disable();
 	preempt_disable();
 	rwlock_acquire_read(&lock->dep_map, 0, 0, _RET_IP_);
 	_raw_read_lock(lock);
 }
-EXPORT_SYMBOL(_read_lock_irq);
+EXPORT_SYMBOL(__read_lock_irq);
 
-void __lockfunc _read_lock_bh(rwlock_t *lock)
+void __lockfunc __read_lock_bh(raw_rwlock_t *lock)
 {
 	local_bh_disable();
 	preempt_disable();
 	rwlock_acquire_read(&lock->dep_map, 0, 0, _RET_IP_);
 	_raw_read_lock(lock);
 }
-EXPORT_SYMBOL(_read_lock_bh);
+EXPORT_SYMBOL(__read_lock_bh);
 
-unsigned long __lockfunc _write_lock_irqsave(rwlock_t *lock)
+unsigned long __lockfunc __write_lock_irqsave(raw_rwlock_t *lock)
 {
 	unsigned long flags;
 
@@ -161,43 +198,43 @@ unsigned long __lockfunc _write_lock_irq
 	_raw_write_lock(lock);
 	return flags;
 }
-EXPORT_SYMBOL(_write_lock_irqsave);
+EXPORT_SYMBOL(__write_lock_irqsave);
 
-void __lockfunc _write_lock_irq(rwlock_t *lock)
+void __lockfunc __write_lock_irq(raw_rwlock_t *lock)
 {
 	local_irq_disable();
 	preempt_disable();
 	rwlock_acquire(&lock->dep_map, 0, 0, _RET_IP_);
 	_raw_write_lock(lock);
 }
-EXPORT_SYMBOL(_write_lock_irq);
+EXPORT_SYMBOL(__write_lock_irq);
 
-void __lockfunc _write_lock_bh(rwlock_t *lock)
+void __lockfunc __write_lock_bh(raw_rwlock_t *lock)
 {
 	local_bh_disable();
 	preempt_disable();
 	rwlock_acquire(&lock->dep_map, 0, 0, _RET_IP_);
 	_raw_write_lock(lock);
 }
-EXPORT_SYMBOL(_write_lock_bh);
+EXPORT_SYMBOL(__write_lock_bh);
 
-void __lockfunc _spin_lock(spinlock_t *lock)
+void __lockfunc __spin_lock(raw_spinlock_t *lock)
 {
 	preempt_disable();
 	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
 	_raw_spin_lock(lock);
 }
 
-EXPORT_SYMBOL(_spin_lock);
+EXPORT_SYMBOL(__spin_lock);
 
-void __lockfunc _write_lock(rwlock_t *lock)
+void __lockfunc __write_lock(raw_rwlock_t *lock)
 {
 	preempt_disable();
 	rwlock_acquire(&lock->dep_map, 0, 0, _RET_IP_);
 	_raw_write_lock(lock);
 }
 
-EXPORT_SYMBOL(_write_lock);
+EXPORT_SYMBOL(__write_lock);
 
 #else /* CONFIG_PREEMPT: */
 
@@ -210,7 +247,7 @@ EXPORT_SYMBOL(_write_lock);
  */
 
 #define BUILD_LOCK_OPS(op, locktype)					\
-void __lockfunc _##op##_lock(locktype##_t *lock)			\
+void __lockfunc __##op##_lock(locktype##_t *lock)			\
 {									\
 	for (;;) {							\
 		preempt_disable();					\
@@ -220,15 +257,16 @@ void __lockfunc _##op##_lock(locktype##_
 									\
 		if (!(lock)->break_lock)				\
 			(lock)->break_lock = 1;				\
-		while (!op##_can_lock(lock) && (lock)->break_lock)	\
+		while (!__raw_##op##_can_lock(&(lock)->raw_lock) &&	\
+			       		(lock)->break_lock)		\
 			cpu_relax();					\
 	}								\
 	(lock)->break_lock = 0;						\
 }									\
 									\
-EXPORT_SYMBOL(_##op##_lock);						\
+EXPORT_SYMBOL(__##op##_lock);						\
 									\
-unsigned long __lockfunc _##op##_lock_irqsave(locktype##_t *lock)	\
+unsigned long __lockfunc __##op##_lock_irqsave(locktype##_t *lock)	\
 {									\
 	unsigned long flags;						\
 									\
@@ -242,23 +280,24 @@ unsigned long __lockfunc _##op##_lock_ir
 									\
 		if (!(lock)->break_lock)				\
 			(lock)->break_lock = 1;				\
-		while (!op##_can_lock(lock) && (lock)->break_lock)	\
+		while (!__raw_##op##_can_lock(&(lock)->raw_lock) &&	\
+						 (lock)->break_lock)	\
 			cpu_relax();					\
 	}								\
 	(lock)->break_lock = 0;						\
 	return flags;							\
 }									\
 									\
-EXPORT_SYMBOL(_##op##_lock_irqsave);					\
+EXPORT_SYMBOL(__##op##_lock_irqsave);					\
 									\
-void __lockfunc _##op##_lock_irq(locktype##_t *lock)			\
+void __lockfunc __##op##_lock_irq(locktype##_t *lock)			\
 {									\
-	_##op##_lock_irqsave(lock);					\
+	__##op##_lock_irqsave(lock);					\
 }									\
 									\
-EXPORT_SYMBOL(_##op##_lock_irq);					\
+EXPORT_SYMBOL(__##op##_lock_irq);					\
 									\
-void __lockfunc _##op##_lock_bh(locktype##_t *lock)			\
+void __lockfunc __##op##_lock_bh(locktype##_t *lock)			\
 {									\
 	unsigned long flags;						\
 									\
@@ -267,147 +306,161 @@ void __lockfunc _##op##_lock_bh(locktype
 	/* irq-disabling. We use the generic preemption-aware	*/	\
 	/* function:						*/	\
 	/**/								\
-	flags = _##op##_lock_irqsave(lock);				\
+	flags = __##op##_lock_irqsave(lock);				\
 	local_bh_disable();						\
 	local_irq_restore(flags);					\
 }									\
 									\
-EXPORT_SYMBOL(_##op##_lock_bh)
+EXPORT_SYMBOL(__##op##_lock_bh)
 
 /*
  * Build preemption-friendly versions of the following
  * lock-spinning functions:
  *
- *         _[spin|read|write]_lock()
- *         _[spin|read|write]_lock_irq()
- *         _[spin|read|write]_lock_irqsave()
- *         _[spin|read|write]_lock_bh()
+ *         __[spin|read|write]_lock()
+ *         __[spin|read|write]_lock_irq()
+ *         __[spin|read|write]_lock_irqsave()
+ *         __[spin|read|write]_lock_bh()
  */
-BUILD_LOCK_OPS(spin, spinlock);
-BUILD_LOCK_OPS(read, rwlock);
-BUILD_LOCK_OPS(write, rwlock);
+BUILD_LOCK_OPS(spin, raw_spinlock);
+BUILD_LOCK_OPS(read, raw_rwlock);
+BUILD_LOCK_OPS(write, raw_rwlock);
 
 #endif /* CONFIG_PREEMPT */
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 
-void __lockfunc _spin_lock_nested(spinlock_t *lock, int subclass)
+void __lockfunc __spin_lock_nested(raw_spinlock_t *lock, int subclass)
 {
 	preempt_disable();
 	spin_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
 	_raw_spin_lock(lock);
 }
 
-EXPORT_SYMBOL(_spin_lock_nested);
+EXPORT_SYMBOL(__spin_lock_nested);
 
 #endif
 
-void __lockfunc _spin_unlock(spinlock_t *lock)
+void __lockfunc __spin_unlock(raw_spinlock_t *lock)
 {
 	spin_release(&lock->dep_map, 1, _RET_IP_);
 	_raw_spin_unlock(lock);
 	preempt_enable();
 }
-EXPORT_SYMBOL(_spin_unlock);
+EXPORT_SYMBOL(__spin_unlock);
 
-void __lockfunc _write_unlock(rwlock_t *lock)
+void __lockfunc __spin_unlock_no_resched(raw_spinlock_t *lock)
+{
+	spin_release(&lock->dep_map, 1, _RET_IP_);
+	_raw_spin_unlock(lock);
+	__preempt_enable_no_resched();
+}
+/* not exported */
+
+void __lockfunc __write_unlock(raw_rwlock_t *lock)
 {
 	rwlock_release(&lock->dep_map, 1, _RET_IP_);
 	_raw_write_unlock(lock);
 	preempt_enable();
 }
-EXPORT_SYMBOL(_write_unlock);
+EXPORT_SYMBOL(__write_unlock);
 
-void __lockfunc _read_unlock(rwlock_t *lock)
+void __lockfunc __read_unlock(raw_rwlock_t *lock)
 {
 	rwlock_release(&lock->dep_map, 1, _RET_IP_);
 	_raw_read_unlock(lock);
 	preempt_enable();
 }
-EXPORT_SYMBOL(_read_unlock);
+EXPORT_SYMBOL(__read_unlock);
 
-void __lockfunc _spin_unlock_irqrestore(spinlock_t *lock, unsigned long flags)
+void __lockfunc __spin_unlock_irqrestore(raw_spinlock_t *lock, unsigned long flags)
 {
 	spin_release(&lock->dep_map, 1, _RET_IP_);
 	_raw_spin_unlock(lock);
+	__preempt_enable_no_resched();
 	local_irq_restore(flags);
-	preempt_enable();
+	preempt_check_resched();
 }
-EXPORT_SYMBOL(_spin_unlock_irqrestore);
+EXPORT_SYMBOL(__spin_unlock_irqrestore);
 
-void __lockfunc _spin_unlock_irq(spinlock_t *lock)
+void __lockfunc __spin_unlock_irq(raw_spinlock_t *lock)
 {
 	spin_release(&lock->dep_map, 1, _RET_IP_);
 	_raw_spin_unlock(lock);
+	__preempt_enable_no_resched();
 	local_irq_enable();
-	preempt_enable();
+	preempt_check_resched();
 }
-EXPORT_SYMBOL(_spin_unlock_irq);
+EXPORT_SYMBOL(__spin_unlock_irq);
 
-void __lockfunc _spin_unlock_bh(spinlock_t *lock)
+void __lockfunc __spin_unlock_bh(raw_spinlock_t *lock)
 {
 	spin_release(&lock->dep_map, 1, _RET_IP_);
 	_raw_spin_unlock(lock);
-	preempt_enable_no_resched();
+	__preempt_enable_no_resched();
 	local_bh_enable_ip((unsigned long)__builtin_return_address(0));
 }
-EXPORT_SYMBOL(_spin_unlock_bh);
+EXPORT_SYMBOL(__spin_unlock_bh);
 
-void __lockfunc _read_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
+void __lockfunc __read_unlock_irqrestore(raw_rwlock_t *lock, unsigned long flags)
 {
 	rwlock_release(&lock->dep_map, 1, _RET_IP_);
 	_raw_read_unlock(lock);
+	__preempt_enable_no_resched();
 	local_irq_restore(flags);
-	preempt_enable();
+	preempt_check_resched();
 }
-EXPORT_SYMBOL(_read_unlock_irqrestore);
+EXPORT_SYMBOL(__read_unlock_irqrestore);
 
-void __lockfunc _read_unlock_irq(rwlock_t *lock)
+void __lockfunc __read_unlock_irq(raw_rwlock_t *lock)
 {
 	rwlock_release(&lock->dep_map, 1, _RET_IP_);
 	_raw_read_unlock(lock);
+	__preempt_enable_no_resched();
 	local_irq_enable();
-	preempt_enable();
+	preempt_check_resched();
 }
-EXPORT_SYMBOL(_read_unlock_irq);
+EXPORT_SYMBOL(__read_unlock_irq);
 
-void __lockfunc _read_unlock_bh(rwlock_t *lock)
+void __lockfunc __read_unlock_bh(raw_rwlock_t *lock)
 {
 	rwlock_release(&lock->dep_map, 1, _RET_IP_);
 	_raw_read_unlock(lock);
-	preempt_enable_no_resched();
+	__preempt_enable_no_resched();
 	local_bh_enable_ip((unsigned long)__builtin_return_address(0));
 }
-EXPORT_SYMBOL(_read_unlock_bh);
+EXPORT_SYMBOL(__read_unlock_bh);
 
-void __lockfunc _write_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
+void __lockfunc __write_unlock_irqrestore(raw_rwlock_t *lock, unsigned long flags)
 {
 	rwlock_release(&lock->dep_map, 1, _RET_IP_);
 	_raw_write_unlock(lock);
+	__preempt_enable_no_resched();
 	local_irq_restore(flags);
-	preempt_enable();
+	preempt_check_resched();
 }
-EXPORT_SYMBOL(_write_unlock_irqrestore);
+EXPORT_SYMBOL(__write_unlock_irqrestore);
 
-void __lockfunc _write_unlock_irq(rwlock_t *lock)
+void __lockfunc __write_unlock_irq(raw_rwlock_t *lock)
 {
 	rwlock_release(&lock->dep_map, 1, _RET_IP_);
 	_raw_write_unlock(lock);
+	__preempt_enable_no_resched();
 	local_irq_enable();
-	preempt_enable();
+	preempt_check_resched();
 }
-EXPORT_SYMBOL(_write_unlock_irq);
+EXPORT_SYMBOL(__write_unlock_irq);
 
-void __lockfunc _write_unlock_bh(rwlock_t *lock)
+void __lockfunc __write_unlock_bh(raw_rwlock_t *lock)
 {
 	rwlock_release(&lock->dep_map, 1, _RET_IP_);
 	_raw_write_unlock(lock);
-	preempt_enable_no_resched();
+	__preempt_enable_no_resched();
 	local_bh_enable_ip((unsigned long)__builtin_return_address(0));
 }
-EXPORT_SYMBOL(_write_unlock_bh);
+EXPORT_SYMBOL(__write_unlock_bh);
 
-int __lockfunc _spin_trylock_bh(spinlock_t *lock)
+int __lockfunc __spin_trylock_bh(raw_spinlock_t *lock)
 {
 	local_bh_disable();
 	preempt_disable();
@@ -416,13 +469,13 @@ int __lockfunc _spin_trylock_bh(spinlock
 		return 1;
 	}
 
-	preempt_enable_no_resched();
+	__preempt_enable_no_resched();
 	local_bh_enable_ip((unsigned long)__builtin_return_address(0));
 	return 0;
 }
-EXPORT_SYMBOL(_spin_trylock_bh);
+EXPORT_SYMBOL(__spin_trylock_bh);
 
-int in_lock_functions(unsigned long addr)
+int in_lock_functions(unsigned long addr)
 {
 	/* Linker adds these: start and end of __lockfunc functions */
 	extern char __lock_text_start[], __lock_text_end[];
