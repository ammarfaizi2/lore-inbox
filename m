Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269105AbUIHLR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269105AbUIHLR4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 07:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269111AbUIHLRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 07:17:55 -0400
Received: from mx2.elte.hu ([157.181.151.9]:38081 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269105AbUIHLQd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 07:16:33 -0400
Date: Wed, 8 Sep 2004 13:17:51 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] preempt-smp.patch, 2.6.9-rc1-bk14
Message-ID: <20040908111751.GA11507@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ADZbWkCsHQ7r3kzd"
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


--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


the attached preempt-smp.patch is another piece of the voluntary-preempt
patchset: it reworks the way kernel-preemption is done on SMP, to solve
3 generic problem areas that introduce unbound latencies. Here's a
description of the changes:

SMP locking latencies are one of the last architectural problems that
cause millisec-category scheduling delays. CONFIG_PREEMPT tries to solve
some of the SMP issues but there are still lots of problems remaining:
spinlocks nested at multiple levels, spinning with irqs turned off, and
non-nested spinning with preemption turned off permanently.

The nesting problem goes like this: if a piece of kernel code (e.g. the
MM or ext3's journalling code) does the following:

	spin_lock(&spinlock_1);
	...
	spin_lock(&spinlock_2);
	...

then even with CONFIG_PREEMPT enabled, current kernels may spin on
spinlock_2 indefinitely. A number of critical sections break their long
paths by using cond_resched_lock(), but this does not break the path on
SMP, because need_resched() *of the other CPU* is not set so
cond_resched_lock() doesnt notice that a reschedule is due.

to solve this problem i've introduced a new spinlock field,
lock->break_lock, which signals towards the holding CPU that a
spinlock-break is requested by another CPU. This field is only set if a
CPU is spinning in a spinlock function [at any locking depth], so the
default overhead is zero. I've extended cond_resched_lock() to check for
this flag - in this case we can also save a reschedule. I've added the
lock_need_resched(lock) and need_lockbreak(lock) methods to check for
the need to break out of a critical section.

Another latency problem was that the stock kernel, even with
CONFIG_PREEMPT enabled, didnt have any spin-nicely preemption logic for
the following, commonly used SMP locking primitives: read_lock(),
spin_lock_irqsave(), spin_lock_irq(), spin_lock_bh(),
read_lock_irqsave(), read_lock_irq(), read_lock_bh(),
write_lock_irqsave(), write_lock_irq(), write_lock_bh(). Only
spin_lock() and write_lock() [the two simplest cases] where covered.

In addition to the preemption latency problems, the _irq() variants in
the above list didnt do any IRQ-enabling while spinning - possibly
resulting in excessive irqs-off sections of code!

preempt-smp.patch fixes all these latency problems by spinning
irq-nicely (if possible) and by requesting lock-breaks if needed. Two
architecture-level changes were necessary for this: the addition of the
break_lock field to spinlock_t and rwlock_t, and the addition of the
_raw_read_trylock() function.

Testing done by Mark H Johnson and myself indicate SMP latencies
comparable to the UP kernel - while they were basically indefinitely
high without this patch.

i successfully test-compiled and test-booted this patch ontop of BK-curr
using the following .config combinations: SMP && PREEMPT, !SMP &&
PREEMPT, SMP && !PREEMPT and !SMP && !PREEMPT on x86, !SMP && !PREEMPT
and SMP && PREEMPT on x64. I also test-booted x86 with the
generic_read_trylock function to check that it works fine. Essentially
the same patch has been in testing as part of the voluntary-preempt
patches for some time already.

!PREEMPT or !SMP kernels are not affected by this patch - other than by
the un-inlining of cond_resched_lock(), which makes sense on all
kernels.

NOTE to architecture maintainers: generic_raw_read_trylock() is a crude
version that should be replaced with the proper arch-optimized version
ASAP.

	Ingo

--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="preempt-smp.patch"


SMP locking latencies are one of the last architectural problems that
cause millisec-category scheduling delays. CONFIG_PREEMPT tries to solve
some of the SMP issues but there are still lots of problems remaining:
spinlocks nested at multiple levels, spinning with irqs turned off, and
non-nested spinning with preemption turned off permanently.

The nesting problem goes like this: if a piece of kernel code (e.g. the
MM or ext3's journalling code) does the following:

	spin_lock(&spinlock_1);
	...
	spin_lock(&spinlock_2);
	...

then even with CONFIG_PREEMPT enabled, current kernels may spin on
spinlock_2 indefinitely. A number of critical sections break their long
paths by using cond_resched_lock(), but this does not break the path on
SMP, because need_resched() *of the other CPU* is not set so
cond_resched_lock() doesnt notice that a reschedule is due.

to solve this problem i've introduced a new spinlock field,
lock->break_lock, which signals towards the holding CPU that a
spinlock-break is requested by another CPU. This field is only set if a
CPU is spinning in a spinlock function [at any locking depth], so the
default overhead is zero. I've extended cond_resched_lock() to check for
this flag - in this case we can also save a reschedule. I've added the
lock_need_resched(lock) and need_lockbreak(lock) methods to check for
the need to break out of a critical section.

Another latency problem was that the stock kernel, even with
CONFIG_PREEMPT enabled, didnt have any spin-nicely preemption logic for
the following, commonly used SMP locking primitives: read_lock(),
spin_lock_irqsave(), spin_lock_irq(), spin_lock_bh(),
read_lock_irqsave(), read_lock_irq(), read_lock_bh(),
write_lock_irqsave(), write_lock_irq(), write_lock_bh(). Only
spin_lock() and write_lock() [the two simplest cases] where covered.

In addition to the preemption latency problems, the _irq() variants in
the above list didnt do any IRQ-enabling while spinning - possibly
resulting in excessive irqs-off sections of code!

preempt-smp.patch fixes all these latency problems by spinning
irq-nicely (if possible) and by requesting lock-breaks if needed. Two
architecture-level changes were necessary for this: the addition of the
break_lock field to spinlock_t and rwlock_t, and the addition of the
_raw_read_trylock() function.

Testing done by Mark H Johnson and myself indicate SMP latencies
comparable to the UP kernel - while they were basically indefinitely
high without this patch.

i successfully test-compiled and test-booted this patch ontop of BK-curr
using the following .config combinations: SMP && PREEMPT, !SMP &&
PREEMPT, SMP && !PREEMPT and !SMP && !PREEMPT on x86, !SMP && !PREEMPT
and SMP && PREEMPT on x64. I also test-booted x86 with the
generic_read_trylock function to check that it works fine. Essentially 
the same patch has been in testing as part of the voluntary-preempt 
patches for some time already.

NOTE to architecture maintainers: generic_raw_read_trylock() is a crude
version that should be replaced with the proper arch-optimized version
ASAP.

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/include/asm-ppc64/spinlock.h.orig	
+++ linux/include/asm-ppc64/spinlock.h	
@@ -23,6 +23,9 @@
 
 typedef struct {
 	volatile unsigned int lock;
+#ifdef CONFIG_PREEMPT
+	unsigned int break_lock;
+#endif
 } spinlock_t;
 
 #ifdef __KERNEL__
@@ -136,6 +139,9 @@ static void __inline__ _raw_spin_lock_fl
  */
 typedef struct {
 	volatile signed int lock;
+#ifdef CONFIG_PREEMPT
+	unsigned int break_lock;
+#endif
 } rwlock_t;
 
 #define RW_LOCK_UNLOCKED (rwlock_t) { 0 }
@@ -216,6 +222,8 @@ static void __inline__ _raw_read_unlock(
 	: "cr0", "memory");
 }
 
+#define _raw_read_trylock(lock) generic_raw_read_trylock(lock)
+
 /*
  * This returns the old value in the lock,
  * so we got the write lock if the return value is 0.
--- linux/include/asm-parisc/system.h.orig	
+++ linux/include/asm-parisc/system.h	
@@ -176,6 +176,9 @@ typedef struct {
 	void *previous;
 	struct task_struct * task;
 #endif
+#ifdef CONFIG_PREEMPT
+	unsigned int break_lock;
+#endif
 } spinlock_t;
 
 #define __lock_aligned __attribute__((__section__(".data.lock_aligned")))
--- linux/include/asm-parisc/spinlock.h.orig	
+++ linux/include/asm-parisc/spinlock.h	
@@ -128,6 +128,9 @@ do {									\
 typedef struct {
 	spinlock_t lock;
 	volatile int counter;
+#ifdef CONFIG_PREEMPT
+	unsigned int break_lock;
+#endif
 } rwlock_t;
 
 #define RW_LOCK_UNLOCKED (rwlock_t) { __SPIN_LOCK_UNLOCKED, 0 }
@@ -136,6 +139,8 @@ typedef struct {
 
 #define rwlock_is_locked(lp) ((lp)->counter != 0)
 
+#define _raw_read_trylock(lock) generic_raw_read_trylock(lock)
+
 /* read_lock, read_unlock are pretty straightforward.  Of course it somehow
  * sucks we end up saving/restoring flags twice for read_lock_irqsave aso. */
 
--- linux/include/asm-mips/spinlock.h.orig	
+++ linux/include/asm-mips/spinlock.h	
@@ -15,6 +15,9 @@
 
 typedef struct {
 	volatile unsigned int lock;
+#ifdef CONFIG_PREEMPT
+	unsigned int break_lock;
+#endif
 } spinlock_t;
 
 #define SPIN_LOCK_UNLOCKED (spinlock_t) { 0 }
@@ -92,6 +95,9 @@ static inline unsigned int _raw_spin_try
 
 typedef struct {
 	volatile unsigned int lock;
+#ifdef CONFIG_PREEMPT
+	unsigned int break_lock;
+#endif
 } rwlock_t;
 
 #define RW_LOCK_UNLOCKED (rwlock_t) { 0 }
@@ -168,6 +174,8 @@ static inline void _raw_write_unlock(rwl
 	: "memory");
 }
 
+#define _raw_read_trylock(lock) generic_raw_read_trylock(lock)
+
 static inline int _raw_write_trylock(rwlock_t *rw)
 {
 	unsigned int tmp;
--- linux/include/asm-ppc/spinlock.h.orig	
+++ linux/include/asm-ppc/spinlock.h	
@@ -13,6 +13,9 @@ typedef struct {
 	volatile unsigned long owner_pc;
 	volatile unsigned long owner_cpu;
 #endif
+#ifdef CONFIG_PREEMPT
+	unsigned int break_lock;
+#endif
 } spinlock_t;
 
 #ifdef __KERNEL__
@@ -83,6 +86,9 @@ typedef struct {
 #ifdef CONFIG_DEBUG_SPINLOCK
 	volatile unsigned long owner_pc;
 #endif
+#ifdef CONFIG_PREEMPT
+	unsigned int break_lock;
+#endif
 } rwlock_t;
 
 #ifdef CONFIG_DEBUG_SPINLOCK
@@ -192,5 +198,7 @@ extern int _raw_write_trylock(rwlock_t *
 
 #endif
 
+#define _raw_read_trylock(lock) generic_raw_read_trylock(lock)
+
 #endif /* __ASM_SPINLOCK_H */
 #endif /* __KERNEL__ */
--- linux/include/asm-x86_64/spinlock.h.orig	
+++ linux/include/asm-x86_64/spinlock.h	
@@ -18,6 +18,9 @@ typedef struct {
 #ifdef CONFIG_DEBUG_SPINLOCK
 	unsigned magic;
 #endif
+#ifdef CONFIG_PREEMPT
+	unsigned int break_lock;
+#endif
 } spinlock_t;
 
 #define SPINLOCK_MAGIC	0xdead4ead
@@ -141,6 +144,9 @@ typedef struct {
 #ifdef CONFIG_DEBUG_SPINLOCK
 	unsigned magic;
 #endif
+#ifdef CONFIG_PREEMPT
+	unsigned int break_lock;
+#endif
 } rwlock_t;
 
 #define RWLOCK_MAGIC	0xdeaf1eed
@@ -187,6 +193,16 @@ static inline void _raw_write_lock(rwloc
 #define _raw_read_unlock(rw)		asm volatile("lock ; incl %0" :"=m" ((rw)->lock) : : "memory")
 #define _raw_write_unlock(rw)	asm volatile("lock ; addl $" RW_LOCK_BIAS_STR ",%0":"=m" ((rw)->lock) : : "memory")
 
+static inline int _raw_read_trylock(rwlock_t *lock)
+{
+	atomic_t *count = (atomic_t *)lock;
+	atomic_dec(count);
+	if (atomic_read(count) < RW_LOCK_BIAS)
+		return 1;
+	atomic_inc(count);
+	return 0;
+}
+
 static inline int _raw_write_trylock(rwlock_t *lock)
 {
 	atomic_t *count = (atomic_t *)lock;
--- linux/include/asm-ia64/spinlock.h.orig	
+++ linux/include/asm-ia64/spinlock.h	
@@ -19,6 +19,9 @@
 
 typedef struct {
 	volatile unsigned int lock;
+#ifdef CONFIG_PREEMPT
+	unsigned int break_lock;
+#endif
 } spinlock_t;
 
 #define SPIN_LOCK_UNLOCKED			(spinlock_t) { 0 }
@@ -116,6 +119,9 @@ do {											\
 typedef struct {
 	volatile int read_counter	: 31;
 	volatile int write_lock		:  1;
+#ifdef CONFIG_PREEMPT
+	unsigned int break_lock;
+#endif
 } rwlock_t;
 #define RW_LOCK_UNLOCKED (rwlock_t) { 0, 0 }
 
@@ -190,6 +196,8 @@ do {										\
 
 #endif /* !ASM_SUPPORTED */
 
+#define _raw_read_trylock(lock) generic_raw_read_trylock(lock)
+
 #define _raw_write_unlock(x)								\
 ({											\
 	smp_mb__before_clear_bit();	/* need barrier before releasing lock... */	\
--- linux/include/linux/spinlock.h.orig	
+++ linux/include/linux/spinlock.h	
@@ -41,6 +41,7 @@
 #define __lockfunc fastcall __attribute__((section(".spinlock.text")))
 
 int __lockfunc _spin_trylock(spinlock_t *lock);
+int __lockfunc _read_trylock(rwlock_t *lock);
 int __lockfunc _write_trylock(rwlock_t *lock);
 void __lockfunc _spin_lock(spinlock_t *lock);
 void __lockfunc _write_lock(rwlock_t *lock);
@@ -69,6 +70,8 @@ void __lockfunc _write_unlock_irq(rwlock
 void __lockfunc _write_unlock_bh(rwlock_t *lock);
 int __lockfunc _spin_trylock_bh(spinlock_t *lock);
 
+int __lockfunc generic_raw_read_trylock(rwlock_t *lock);
+
 extern unsigned long __lock_text_start;
 extern unsigned long __lock_text_end;
 #else
@@ -213,11 +216,15 @@ typedef struct {
 #define _raw_read_unlock(lock)	do { (void)(lock); } while(0)
 #define _raw_write_lock(lock)	do { (void)(lock); } while(0)
 #define _raw_write_unlock(lock)	do { (void)(lock); } while(0)
+#define _raw_read_trylock(lock) ({ (void)(lock); (1); })
 #define _raw_write_trylock(lock) ({ (void)(lock); (1); })
 
 #define _spin_trylock(lock)	({preempt_disable(); _raw_spin_trylock(lock) ? \
 				1 : ({preempt_enable(); 0;});})
 
+#define _read_trylock(lock)	({preempt_disable();_raw_read_trylock(lock) ? \
+				1 : ({preempt_enable(); 0;});})
+
 #define _write_trylock(lock)	({preempt_disable(); _raw_write_trylock(lock) ? \
 				1 : ({preempt_enable(); 0;});})
 
@@ -401,21 +408,36 @@ do { \
  * methods are defined as nops in the case they are not required.
  */
 #define spin_trylock(lock)	_spin_trylock(lock)
+#define read_trylock(lock)	_read_trylock(lock)
 #define write_trylock(lock)	_write_trylock(lock)
 
-/* Where's read_trylock? */
-
 #if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT)
-void __preempt_spin_lock(spinlock_t *lock);
-void __preempt_write_lock(rwlock_t *lock);
-#endif
+
+extern void __lockfunc spin_lock(spinlock_t *lock);
+extern void __lockfunc write_lock(rwlock_t *lock);
+extern void __lockfunc read_lock(rwlock_t *lock);
+extern void __lockfunc
+	__spin_lock_irqsave(spinlock_t *lock, unsigned long *flags);
+extern void __lockfunc spin_lock_irq(spinlock_t *lock);
+extern void __lockfunc spin_lock_bh(spinlock_t *lock);
+extern void __lockfunc
+	__read_lock_irqsave(rwlock_t *lock, unsigned long *flags);
+extern void __lockfunc read_lock_irq(rwlock_t *lock);
+extern void __lockfunc read_lock_bh(rwlock_t *lock);
+extern void __lockfunc
+	__write_lock_irqsave(rwlock_t *lock, unsigned long *flags);
+extern void __lockfunc write_lock_irq(rwlock_t *lock);
+extern void __lockfunc write_lock_bh(rwlock_t *lock);
+ 
+#define spin_lock_irqsave(lock, flags) __spin_lock_irqsave(lock, &(flags))
+#define read_lock_irqsave(lock, flags) __read_lock_irqsave(lock, &(flags))
+#define write_lock_irqsave(lock, flags) __write_lock_irqsave(lock, &(flags))
+
+#else
 
 #define spin_lock(lock)		_spin_lock(lock)
 #define write_lock(lock)	_write_lock(lock)
 #define read_lock(lock)		_read_lock(lock)
-#define spin_unlock(lock)	_spin_unlock(lock)
-#define write_unlock(lock)	_write_unlock(lock)
-#define read_unlock(lock)	_read_unlock(lock)
 
 #ifdef CONFIG_SMP
 #define spin_lock_irqsave(lock, flags)	flags = _spin_lock_irqsave(lock)
@@ -435,6 +457,13 @@ void __preempt_write_lock(rwlock_t *lock
 
 #define write_lock_irq(lock)		_write_lock_irq(lock)
 #define write_lock_bh(lock)		_write_lock_bh(lock)
+
+#endif
+
+#define spin_unlock(lock)	_spin_unlock(lock)
+#define write_unlock(lock)	_write_unlock(lock)
+#define read_unlock(lock)	_read_unlock(lock)
+
 #define spin_unlock_irqrestore(lock, flags)	_spin_unlock_irqrestore(lock, flags)
 #define spin_unlock_irq(lock)		_spin_unlock_irq(lock)
 #define spin_unlock_bh(lock)		_spin_unlock_bh(lock)
@@ -457,6 +486,7 @@ extern void _metered_read_lock    (rwloc
 extern void _metered_read_unlock  (rwlock_t *lock);
 extern void _metered_write_lock   (rwlock_t *lock);
 extern void _metered_write_unlock (rwlock_t *lock);
+extern int  _metered_read_trylock (rwlock_t *lock);
 extern int  _metered_write_trylock(rwlock_t *lock);
 #endif
 
@@ -484,8 +514,11 @@ static inline void bit_spin_lock(int bit
 	preempt_disable();
 #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
 	while (test_and_set_bit(bitnum, addr)) {
-		while (test_bit(bitnum, addr))
+		while (test_bit(bitnum, addr)) {
+			preempt_enable();
 			cpu_relax();
+			preempt_disable();
+		}
 	}
 #endif
 }
--- linux/include/linux/sched.h.orig	
+++ linux/include/linux/sched.h	
@@ -958,23 +958,7 @@ static inline void cond_resched(void)
 		__cond_resched();
 }
 
-/*
- * cond_resched_lock() - if a reschedule is pending, drop the given lock,
- * call schedule, and on return reacquire the lock.
- *
- * This works OK both with and without CONFIG_PREEMPT.  We do strange low-level
- * operations here to prevent schedule() from being called twice (once via
- * spin_unlock(), once by hand).
- */
-static inline void cond_resched_lock(spinlock_t * lock)
-{
-	if (need_resched()) {
-		_raw_spin_unlock(lock);
-		preempt_enable_no_resched();
-		__cond_resched();
-		spin_lock(lock);
-	}
-}
+extern int cond_resched_lock(spinlock_t * lock);
 
 /* Reevaluate whether the task has signals pending delivery.
    This is required every time the blocked sigset_t changes.
--- linux/include/asm-arm/spinlock.h.orig	
+++ linux/include/asm-arm/spinlock.h	
@@ -17,6 +17,9 @@
  */
 typedef struct {
 	volatile unsigned int lock;
+#ifdef CONFIG_PREEMPT
+	unsigned int break_lock;
+#endif
 } spinlock_t;
 
 #define SPIN_LOCK_UNLOCKED	(spinlock_t) { 0 }
@@ -70,6 +73,9 @@ static inline void _raw_spin_unlock(spin
  */
 typedef struct {
 	volatile unsigned int lock;
+#ifdef CONFIG_PREEMPT
+	unsigned int break_lock;
+#endif
 } rwlock_t;
 
 #define RW_LOCK_UNLOCKED	(rwlock_t) { 0 }
@@ -143,6 +149,8 @@ static inline void _raw_read_unlock(rwlo
 	: "cc", "memory");
 }
 
+#define _raw_read_trylock(lock) generic_raw_read_trylock(lock)
+
 static inline int _raw_write_trylock(rwlock_t *rw)
 {
 	unsigned long tmp;
--- linux/include/asm-sparc/spinlock.h.orig	
+++ linux/include/asm-sparc/spinlock.h	
@@ -16,6 +16,9 @@
 struct _spinlock_debug {
 	unsigned char lock;
 	unsigned long owner_pc;
+#ifdef CONFIG_PREEMPT
+	unsigned int break_lock;
+#endif
 };
 typedef struct _spinlock_debug spinlock_t;
 
@@ -36,6 +39,9 @@ struct _rwlock_debug {
 	volatile unsigned int lock;
 	unsigned long owner_pc;
 	unsigned long reader_pc[NR_CPUS];
+#ifdef CONFIG_PREEMPT
+	unsigned int break_lock;
+#endif
 };
 typedef struct _rwlock_debug rwlock_t;
 
@@ -79,8 +85,14 @@ do {	unsigned long flags; \
 
 #else /* !CONFIG_DEBUG_SPINLOCK */
 
-typedef unsigned char spinlock_t;
-#define SPIN_LOCK_UNLOCKED	0
+typedef struct {
+	unsigned char lock;
+#ifdef CONFIG_PREEMPT
+	unsigned int break_lock;
+#endif
+} spinlock_t;
+
+#define SPIN_LOCK_UNLOCKED	{ 0, }
 
 #define spin_lock_init(lock)   (*((unsigned char *)(lock)) = 0)
 #define spin_is_locked(lock)    (*((volatile unsigned char *)(lock)) != 0)
@@ -137,7 +149,12 @@ extern __inline__ void _raw_spin_unlock(
  * XXX This might create some problems with my dual spinlock
  * XXX scheme, deadlocks etc. -DaveM
  */
-typedef struct { volatile unsigned int lock; } rwlock_t;
+typedef struct {
+	volatile unsigned int lock;
+#ifdef CONFIG_PREEMPT
+	unsigned int break_lock;
+#endif
+} rwlock_t;
 
 #define RW_LOCK_UNLOCKED (rwlock_t) { 0 }
 
--- linux/include/asm-alpha/spinlock.h.orig	
+++ linux/include/asm-alpha/spinlock.h	
@@ -23,6 +23,9 @@ typedef struct {
 	struct task_struct * task;
 	const char *base_file;
 #endif
+#ifdef CONFIG_PREEMPT
+	unsigned int break_lock;
+#endif
 } spinlock_t;
 
 #ifdef CONFIG_DEBUG_SPINLOCK
@@ -96,6 +99,9 @@ static inline int _raw_spin_trylock(spin
 
 typedef struct {
 	volatile int write_lock:1, read_counter:31;
+#ifdef CONFIG_PREEMPT
+	unsigned int break_lock;
+#endif
 } /*__attribute__((aligned(32)))*/ rwlock_t;
 
 #define RW_LOCK_UNLOCKED (rwlock_t) { 0, 0 }
--- linux/include/asm-i386/spinlock.h.orig	
+++ linux/include/asm-i386/spinlock.h	
@@ -19,6 +19,9 @@ typedef struct {
 #ifdef CONFIG_DEBUG_SPINLOCK
 	unsigned magic;
 #endif
+#ifdef CONFIG_PREEMPT
+	unsigned int break_lock;
+#endif
 } spinlock_t;
 
 #define SPINLOCK_MAGIC	0xdead4ead
@@ -170,6 +173,9 @@ typedef struct {
 #ifdef CONFIG_DEBUG_SPINLOCK
 	unsigned magic;
 #endif
+#ifdef CONFIG_PREEMPT
+	unsigned int break_lock;
+#endif
 } rwlock_t;
 
 #define RWLOCK_MAGIC	0xdeaf1eed
@@ -216,6 +222,16 @@ static inline void _raw_write_lock(rwloc
 #define _raw_read_unlock(rw)		asm volatile("lock ; incl %0" :"=m" ((rw)->lock) : : "memory")
 #define _raw_write_unlock(rw)	asm volatile("lock ; addl $" RW_LOCK_BIAS_STR ",%0":"=m" ((rw)->lock) : : "memory")
 
+static inline int _raw_read_trylock(rwlock_t *lock)
+{
+	atomic_t *count = (atomic_t *)lock;
+	atomic_dec(count);
+	if (atomic_read(count) < RW_LOCK_BIAS)
+		return 1;
+	atomic_inc(count);
+	return 0;
+}
+
 static inline int _raw_write_trylock(rwlock_t *lock)
 {
 	atomic_t *count = (atomic_t *)lock;
--- linux/include/asm-s390/spinlock.h.orig	
+++ linux/include/asm-s390/spinlock.h	
@@ -36,6 +36,9 @@
 
 typedef struct {
 	volatile unsigned int lock;
+#ifdef CONFIG_PREEMPT
+	unsigned int break_lock;
+#endif
 } __attribute__ ((aligned (4))) spinlock_t;
 
 #define SPIN_LOCK_UNLOCKED (spinlock_t) { 0 }
@@ -105,6 +108,9 @@ extern inline void _raw_spin_unlock(spin
 typedef struct {
 	volatile unsigned long lock;
 	volatile unsigned long owner_pc;
+#ifdef CONFIG_PREEMPT
+	unsigned int break_lock;
+#endif
 } rwlock_t;
 
 #define RW_LOCK_UNLOCKED (rwlock_t) { 0, 0 }
@@ -211,6 +217,8 @@ typedef struct {
 		       "m" ((rw)->lock) : "2", "3", "cc", "memory" )
 #endif /* __s390x__ */
 
+#define _raw_read_trylock(lock) generic_raw_read_trylock(lock)
+
 extern inline int _raw_write_trylock(rwlock_t *rw)
 {
 	unsigned long result, reg;
--- linux/include/asm-sparc64/spinlock.h.orig	
+++ linux/include/asm-sparc64/spinlock.h	
@@ -304,6 +304,8 @@ do {	unsigned long flags; \
 
 #endif /* CONFIG_DEBUG_SPINLOCK */
 
+#define _raw_read_trylock(lock) generic_raw_read_trylock(lock)
+
 #endif /* !(__ASSEMBLY__) */
 
 #endif /* !(__SPARC64_SPINLOCK_H) */
--- linux/include/asm-sh/spinlock.h.orig	
+++ linux/include/asm-sh/spinlock.h	
@@ -17,6 +17,9 @@
  */
 typedef struct {
 	volatile unsigned long lock;
+#ifdef CONFIG_PREEMPT
+	unsigned int break_lock;
+#endif
 } spinlock_t;
 
 #define SPIN_LOCK_UNLOCKED	(spinlock_t) { 0 }
@@ -68,6 +71,9 @@ static inline void _raw_spin_unlock(spin
 typedef struct {
 	spinlock_t lock;
 	atomic_t counter;
+#ifdef CONFIG_PREEMPT
+	unsigned int break_lock;
+#endif
 } rwlock_t;
 
 #define RW_LOCK_BIAS		0x01000000
@@ -105,6 +111,8 @@ static inline void _raw_write_unlock(rwl
 	_raw_spin_unlock(&rw->lock);
 }
 
+#define _raw_read_trylock(lock) generic_raw_read_trylock(lock)
+
 static inline int _raw_write_trylock(rwlock_t *rw)
 {
 	if (atomic_sub_and_test(RW_LOCK_BIAS, &rw->counter))
--- linux/kernel/spinlock.c.orig	
+++ linux/kernel/spinlock.c	
@@ -2,6 +2,8 @@
  * Copyright (2004) Linus Torvalds
  *
  * Author: Zwane Mwaikambo <zwane@fsmlabs.com>
+ *
+ * Copyright (2004) Ingo Molnar
  */
 
 #include <linux/config.h>
@@ -11,6 +13,17 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 
+/*
+ * Generic declaration of the raw read_trylock() function,
+ * architectures are supposed to optimize this:
+ */
+int __lockfunc generic_raw_read_trylock(rwlock_t *lock)
+{
+	_raw_read_lock(lock);
+	return 1;
+}
+EXPORT_SYMBOL(generic_raw_read_trylock);
+
 int __lockfunc _spin_trylock(spinlock_t *lock)
 {
 	preempt_disable();
@@ -22,6 +35,17 @@ int __lockfunc _spin_trylock(spinlock_t 
 }
 EXPORT_SYMBOL(_spin_trylock);
 
+int __lockfunc _read_trylock(rwlock_t *lock)
+{
+	preempt_disable();
+	if (_raw_read_trylock(lock))
+		return 1;
+	
+	preempt_enable();
+	return 0;
+}
+EXPORT_SYMBOL(_read_trylock);
+
 int __lockfunc _write_trylock(rwlock_t *lock)
 {
 	preempt_disable();
@@ -33,34 +57,22 @@ int __lockfunc _write_trylock(rwlock_t *
 }
 EXPORT_SYMBOL(_write_trylock);
 
-#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT)
-void __lockfunc _spin_lock(spinlock_t *lock)
-{
-	preempt_disable();
-	if (unlikely(!_raw_spin_trylock(lock)))
-		__preempt_spin_lock(lock);
-}
+#ifndef CONFIG_PREEMPT
 
-void __lockfunc _write_lock(rwlock_t *lock)
-{
-	preempt_disable();
-	if (unlikely(!_raw_write_trylock(lock)))
-		__preempt_write_lock(lock);
-}
-#else
 void __lockfunc _spin_lock(spinlock_t *lock)
 {
 	preempt_disable();
 	_raw_spin_lock(lock);
 }
 
+EXPORT_SYMBOL(_spin_lock);
+
 void __lockfunc _write_lock(rwlock_t *lock)
 {
 	preempt_disable();
 	_raw_write_lock(lock);
 }
-#endif
-EXPORT_SYMBOL(_spin_lock);
+
 EXPORT_SYMBOL(_write_lock);
 
 void __lockfunc _read_lock(rwlock_t *lock)
@@ -70,27 +82,6 @@ void __lockfunc _read_lock(rwlock_t *loc
 }
 EXPORT_SYMBOL(_read_lock);
 
-void __lockfunc _spin_unlock(spinlock_t *lock)
-{
-	_raw_spin_unlock(lock);
-	preempt_enable();
-}
-EXPORT_SYMBOL(_spin_unlock);
-
-void __lockfunc _write_unlock(rwlock_t *lock)
-{
-	_raw_write_unlock(lock);
-	preempt_enable();
-}
-EXPORT_SYMBOL(_write_unlock);
-
-void __lockfunc _read_unlock(rwlock_t *lock)
-{
-	_raw_read_unlock(lock);
-	preempt_enable();
-}
-EXPORT_SYMBOL(_read_unlock);
-
 unsigned long __lockfunc _spin_lock_irqsave(spinlock_t *lock)
 {
 	unsigned long flags;
@@ -172,6 +163,113 @@ void __lockfunc _write_lock_bh(rwlock_t 
 }
 EXPORT_SYMBOL(_write_lock_bh);
 
+#else /* CONFIG_PREEMPT: */
+
+/*
+ * This could be a long-held lock. We both prepare to spin for a long
+ * time (making _this_ CPU preemptable if possible), and we also signal
+ * towards that other CPU that it should break the lock ASAP.
+ *
+ * (We do this in a function because inlining it would be excessive.)
+ */
+
+#define BUILD_LOCK_OPS(op, locktype)					\
+void __lockfunc op##_lock(locktype *lock)				\
+{									\
+	preempt_disable();						\
+	for (;;) {							\
+		if (likely(_raw_##op##_trylock(lock)))			\
+			break;						\
+		preempt_enable();					\
+		if (!(lock)->break_lock)				\
+			(lock)->break_lock = 1;				\
+		cpu_relax();						\
+		preempt_disable();					\
+	}								\
+}									\
+									\
+EXPORT_SYMBOL(op##_lock);						\
+									\
+void __lockfunc __##op##_lock_irqsave(locktype *lock, unsigned long *flags)\
+{									\
+	preempt_disable();						\
+	for (;;) {							\
+		local_irq_save(*flags);					\
+		if (likely(_raw_##op##_trylock(lock)))			\
+			break;						\
+		local_irq_restore(*flags);				\
+									\
+		preempt_enable();					\
+		if (!(lock)->break_lock)				\
+			(lock)->break_lock = 1;				\
+		cpu_relax();						\
+		preempt_disable();					\
+	}								\
+}									\
+									\
+EXPORT_SYMBOL(__##op##_lock_irqsave);					\
+									\
+void __lockfunc op##_lock_irq(locktype *lock)				\
+{									\
+	unsigned long flags;						\
+									\
+	__##op##_lock_irqsave(lock, &flags);				\
+}									\
+									\
+EXPORT_SYMBOL(op##_lock_irq);						\
+									\
+void __lockfunc op##_lock_bh(locktype *lock)				\
+{									\
+	unsigned long flags;						\
+									\
+	/*							*/	\
+	/* Careful: we must exclude softirqs too, hence the	*/	\
+	/* irq-disabling. We use the generic preemption-aware	*/	\
+	/* function:						*/	\
+	/**/								\
+	__##op##_lock_irqsave(lock, &flags);				\
+	local_bh_disable();						\
+	local_irq_restore(flags);					\
+}									\
+									\
+EXPORT_SYMBOL(op##_lock_bh)
+
+/*
+ * Build preemption-friendly versions of the following
+ * lock-spinning functions:
+ *
+ *         [spin|read|write]_lock()
+ *         [spin|read|write]_lock_irq()
+ *         __[spin|read|write]_lock_irqsave()
+ *         [spin|read|write]_lock_bh()
+ */
+BUILD_LOCK_OPS(spin, spinlock_t);
+BUILD_LOCK_OPS(read, rwlock_t);
+BUILD_LOCK_OPS(write, rwlock_t);
+
+#endif /* CONFIG_PREEMPT */
+
+void __lockfunc _spin_unlock(spinlock_t *lock)
+{
+	_raw_spin_unlock(lock);
+	preempt_enable();
+}
+EXPORT_SYMBOL(_spin_unlock);
+
+void __lockfunc _write_unlock(rwlock_t *lock)
+{
+	_raw_write_unlock(lock);
+	preempt_enable();
+}
+EXPORT_SYMBOL(_write_unlock);
+
+void __lockfunc _read_unlock(rwlock_t *lock)
+{
+	_raw_read_unlock(lock);
+	preempt_enable();
+}
+EXPORT_SYMBOL(_read_unlock);
+
 void __lockfunc _spin_unlock_irqrestore(spinlock_t *lock, unsigned long flags)
 {
 	_raw_spin_unlock(lock);
--- linux/kernel/sched.c.orig	
+++ linux/kernel/sched.c	
@@ -3529,6 +3529,37 @@ void __sched __cond_resched(void)
 
 EXPORT_SYMBOL(__cond_resched);
 
+/*
+ * cond_resched_lock() - if a reschedule is pending, drop the given lock,
+ * call schedule, and on return reacquire the lock.
+ *
+ * This works OK both with and without CONFIG_PREEMPT.  We do strange low-level
+ * operations here to prevent schedule() from being called twice (once via
+ * spin_unlock(), once by hand).
+ */
+int cond_resched_lock(spinlock_t * lock)
+{
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT)
+	if (lock->break_lock) {
+		lock->break_lock = 0;
+		spin_unlock(lock);
+		cpu_relax();
+		spin_lock(lock);
+	}
+#endif
+	if (need_resched()) {
+		_raw_spin_unlock(lock);
+		preempt_enable_no_resched();
+		set_current_state(TASK_RUNNING);
+		schedule();
+		spin_lock(lock);
+		return 1;
+	}
+	return 0;
+}
+
+EXPORT_SYMBOL(cond_resched_lock);
+
 /**
  * yield - yield the current processor to other threads.
  *

--ADZbWkCsHQ7r3kzd--
