Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262806AbVAQOdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262806AbVAQOdo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 09:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262807AbVAQOdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 09:33:44 -0500
Received: from mx1.elte.hu ([157.181.1.137]:7384 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262806AbVAQOdb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 09:33:31 -0500
Date: Mon, 17 Jan 2005 15:33:01 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Wedgwood <cw@f00f.org>, torvalds@osdl.org, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org
Subject: Re: Horrible regression with -CURRENT from "Don't busy-lock-loop in preemptable spinlocks" patch
Message-ID: <20050117143301.GA10341@elte.hu>
References: <20050117055044.GA3514@taniwha.stupidest.org> <20050116230922.7274f9a2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050116230922.7274f9a2.akpm@osdl.org>
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


* Andrew Morton <akpm@osdl.org> wrote:

> > +BUILD_LOCK_OPS(spin, spinlock_t, spin_is_locked);
> > +BUILD_LOCK_OPS(read, rwlock_t, rwlock_is_locked);
> > +BUILD_LOCK_OPS(write, rwlock_t, spin_is_locked);
> 
> If you replace the last line with
> 
> 	BUILD_LOCK_OPS(write, rwlock_t, rwlock_is_locked);
> 
> does it help?

this is not enough - the proper solution should be the patch below,
which i sent earlier today as a reply to Paul Mackerras' comments.

	Ingo

--
the first fix is that there was no compiler warning on x86 because it
uses macros - i fixed this by changing the spinlock field to be
'->slock'. (we could also use inline functions to get type protection, i
chose this solution because it was the easiest to do.)

the second fix is to split rwlock_is_locked() into two functions:

 +/**
 + * read_is_locked - would read_trylock() fail?
 + * @lock: the rwlock in question.
 + */
 +#define read_is_locked(x) (atomic_read((atomic_t *)&(x)->lock) <= 0)
 +
 +/**
 + * write_is_locked - would write_trylock() fail?
 + * @lock: the rwlock in question.
 + */
 +#define write_is_locked(x) ((x)->lock != RW_LOCK_BIAS)

this canonical naming of them also enabled the elimination of the newly
added 'is_locked_fn' argument to the BUILD_LOCK_OPS macro.

the third change was to change the other user of rwlock_is_locked(), and
to put a migration helper there: architectures that dont have
read/write_is_locked defined yet will get a #warning message but the
build will succeed. (except if PREEMPT is enabled - there we really
need.)

compile and boot-tested on x86, on SMP and UP, PREEMPT and !PREEMPT. 
Non-x86 architectures should work fine, except PREEMPT+SMP builds which
will need the read_is_locked()/write_is_locked() definitions.
!PREEMPT+SMP builds will work fine and will produce a #warning.

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/kernel/spinlock.c.orig
+++ linux/kernel/spinlock.c
@@ -173,7 +173,7 @@ EXPORT_SYMBOL(_write_lock);
  * (We do this in a function because inlining it would be excessive.)
  */
 
-#define BUILD_LOCK_OPS(op, locktype, is_locked_fn)			\
+#define BUILD_LOCK_OPS(op, locktype)					\
 void __lockfunc _##op##_lock(locktype *lock)				\
 {									\
 	preempt_disable();						\
@@ -183,7 +183,7 @@ void __lockfunc _##op##_lock(locktype *l
 		preempt_enable();					\
 		if (!(lock)->break_lock)				\
 			(lock)->break_lock = 1;				\
-		while (is_locked_fn(lock) && (lock)->break_lock)	\
+		while (op##_is_locked(lock) && (lock)->break_lock)	\
 			cpu_relax();					\
 		preempt_disable();					\
 	}								\
@@ -205,7 +205,7 @@ unsigned long __lockfunc _##op##_lock_ir
 		preempt_enable();					\
 		if (!(lock)->break_lock)				\
 			(lock)->break_lock = 1;				\
-		while (is_locked_fn(lock) && (lock)->break_lock)	\
+		while (op##_is_locked(lock) && (lock)->break_lock)	\
 			cpu_relax();					\
 		preempt_disable();					\
 	}								\
@@ -246,9 +246,9 @@ EXPORT_SYMBOL(_##op##_lock_bh)
  *         _[spin|read|write]_lock_irqsave()
  *         _[spin|read|write]_lock_bh()
  */
-BUILD_LOCK_OPS(spin, spinlock_t, spin_is_locked);
-BUILD_LOCK_OPS(read, rwlock_t, rwlock_is_locked);
-BUILD_LOCK_OPS(write, rwlock_t, spin_is_locked);
+BUILD_LOCK_OPS(spin, spinlock_t);
+BUILD_LOCK_OPS(read, rwlock_t);
+BUILD_LOCK_OPS(write, rwlock_t);
 
 #endif /* CONFIG_PREEMPT */
 
--- linux/include/asm-i386/spinlock.h.orig
+++ linux/include/asm-i386/spinlock.h
@@ -15,7 +15,7 @@ asmlinkage int printk(const char * fmt, 
  */
 
 typedef struct {
-	volatile unsigned int lock;
+	volatile unsigned int slock;
 #ifdef CONFIG_DEBUG_SPINLOCK
 	unsigned magic;
 #endif
@@ -43,7 +43,7 @@ typedef struct {
  * We make no fairness assumptions. They have a cost.
  */
 
-#define spin_is_locked(x)	(*(volatile signed char *)(&(x)->lock) <= 0)
+#define spin_is_locked(x)	(*(volatile signed char *)(&(x)->slock) <= 0)
 #define spin_unlock_wait(x)	do { barrier(); } while(spin_is_locked(x))
 
 #define spin_lock_string \
@@ -83,7 +83,7 @@ typedef struct {
 
 #define spin_unlock_string \
 	"movb $1,%0" \
-		:"=m" (lock->lock) : : "memory"
+		:"=m" (lock->slock) : : "memory"
 
 
 static inline void _raw_spin_unlock(spinlock_t *lock)
@@ -101,7 +101,7 @@ static inline void _raw_spin_unlock(spin
 
 #define spin_unlock_string \
 	"xchgb %b0, %1" \
-		:"=q" (oldval), "=m" (lock->lock) \
+		:"=q" (oldval), "=m" (lock->slock) \
 		:"0" (oldval) : "memory"
 
 static inline void _raw_spin_unlock(spinlock_t *lock)
@@ -123,7 +123,7 @@ static inline int _raw_spin_trylock(spin
 	char oldval;
 	__asm__ __volatile__(
 		"xchgb %b0,%1"
-		:"=q" (oldval), "=m" (lock->lock)
+		:"=q" (oldval), "=m" (lock->slock)
 		:"0" (0) : "memory");
 	return oldval > 0;
 }
@@ -138,7 +138,7 @@ static inline void _raw_spin_lock(spinlo
 #endif
 	__asm__ __volatile__(
 		spin_lock_string
-		:"=m" (lock->lock) : : "memory");
+		:"=m" (lock->slock) : : "memory");
 }
 
 static inline void _raw_spin_lock_flags (spinlock_t *lock, unsigned long flags)
@@ -151,7 +151,7 @@ static inline void _raw_spin_lock_flags 
 #endif
 	__asm__ __volatile__(
 		spin_lock_string_flags
-		:"=m" (lock->lock) : "r" (flags) : "memory");
+		:"=m" (lock->slock) : "r" (flags) : "memory");
 }
 
 /*
@@ -186,7 +186,17 @@ typedef struct {
 
 #define rwlock_init(x)	do { *(x) = RW_LOCK_UNLOCKED; } while(0)
 
-#define rwlock_is_locked(x) ((x)->lock != RW_LOCK_BIAS)
+/**
+ * read_is_locked - would read_trylock() fail?
+ * @lock: the rwlock in question.
+ */
+#define read_is_locked(x) (atomic_read((atomic_t *)&(x)->lock) <= 0)
+
+/**
+ * write_is_locked - would write_trylock() fail?
+ * @lock: the rwlock in question.
+ */
+#define write_is_locked(x) ((x)->lock != RW_LOCK_BIAS)
 
 /*
  * On x86, we implement read-write locks as a 32-bit counter
--- linux/kernel/exit.c.orig
+++ linux/kernel/exit.c
@@ -861,8 +861,12 @@ task_t fastcall *next_thread(const task_
 #ifdef CONFIG_SMP
 	if (!p->sighand)
 		BUG();
+#ifndef write_is_locked
+# warning please implement read_is_locked()/write_is_locked()!
+# define write_is_locked rwlock_is_locked
+#endif
 	if (!spin_is_locked(&p->sighand->siglock) &&
-				!rwlock_is_locked(&tasklist_lock))
+				!write_is_locked(&tasklist_lock))
 		BUG();
 #endif
 	return pid_task(p->pids[PIDTYPE_TGID].pid_list.next, PIDTYPE_TGID);

