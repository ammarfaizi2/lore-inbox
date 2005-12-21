Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbVLUEQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbVLUEQX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 23:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbVLUEQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 23:16:22 -0500
Received: from relais.videotron.ca ([24.201.245.36]:49407 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932273AbVLUEQV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 23:16:21 -0500
Date: Tue, 20 Dec 2005 23:16:17 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 04/15] Generic Mutex Subsystem,
 add-atomic-call-func-x86_64.patch
In-reply-to: <Pine.LNX.4.64.0512192358160.26663@localhost.localdomain>
X-X-Sender: nico@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       David Howells <dhowells@redhat.com>
Message-id: <Pine.LNX.4.64.0512202304580.26663@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20051219013507.GE27658@elte.hu>
 <Pine.LNX.4.64.0512190948410.1678@montezuma.fsmlabs.com>
 <1135025932.4760.1.camel@localhost.localdomain>
 <20051220043109.GC32039@elte.hu>
 <Pine.LNX.4.64.0512192358160.26663@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Dec 2005, Nicolas Pitre wrote:

> On Tue, 20 Dec 2005, Ingo Molnar wrote:
> 
> > 
> > * David Woodhouse <dwmw2@infradead.org> wrote:
> > 
> > > On Mon, 2005-12-19 at 09:49 -0800, Zwane Mwaikambo wrote:
> > > > Hi Ingo,
> > > >         Doesn't this corrupt caller saved registers?
> > > 
> > > Looks like it. I _really_ don't like calling functions from inline 
> > > asm. It's not nice. Can't we use atomic_dec_return() for this?
> > 
> > we can use atomic_dec_return(), but that will add one more instruction 
> > to the fastpath. OTOH, atomic_dec_return() is available on every 
> > architecture, so it's a really tempting thing. I'll experiment with it.
> 
> Please consider using (a variant of) xchg() instead.  Although 
> atomic_dec() is available on all architectures, its implementation is 
> far from being the most efficient thing to do for them all.

Actually, the best thing to do is to let the architecture do what is the 
most efficient.  Please consider this patch that adds the flexibility 
for any architecture to use the optimal mechanism it has for atomic 
locking.  It also let it decide whether inlining the fast path is a good 
thing or not.  This patch should leave i386 unchanged.  It applies on 
top of your last posted mutex patch serie.

Index: linux-2.6/include/linux/mutex.h
===================================================================
--- linux-2.6.orig/include/linux/mutex.h
+++ linux-2.6/include/linux/mutex.h
@@ -14,6 +14,8 @@
 #include <asm/atomic.h>
 #include <linux/list.h>
 #include <linux/spinlock_types.h>
+#include <linux/linkage.h>
+#include <asm/mutex.h>
 
 /*
  * Simple, straightforward mutexes with strict semantics:
@@ -93,12 +95,49 @@ extern void FASTCALL(__mutex_init(struct
 #define DEFINE_MUTEX(mutexname) \
 	struct mutex mutexname = __MUTEX_INITIALIZER(mutexname)
 
+/*
+ * We can speed up the lock-acquire, but only if the architecture
+ * supports it and if there's no debugging state
+ * to be set up (!DEBUG_MUTEXESS).
+ */
+#ifdef CONFIG_DEBUG_MUTEXESS
+#undef MUTEX_LOCKLESS_FASTPATH
+#endif
+
+/*
+ * We can inline the lock-acquire, but only if the architecture
+ * wants it, and if MUTEX_LOCKLESS_FASTPATH is active.
+ */
+#ifndef MUTEX_LOCKLESS_FASTPATH
+#undef  MUTEX_INLINE_FASTPATH
+#endif
+
+/* out of line contention handlers */
+extern void FASTCALL(__mutex_lock_noinline(atomic_t *lock_count));
+extern void FASTCALL(__mutex_unlock_noinline(atomic_t *lock_count));
+
+#ifdef MUTEX_INLINE_FASTPATH
+
+#define mutex_lock(lock) \
+	__arch_fast_mutex_lock(&lock->count, __mutex_lock_noinline)
+#define mutex_unlock(lock) \
+	__arch_fast_mutex_unlock(&lock->count, __mutex_unlock_noinline)
+#define mutex_trylock(lock) \
+	__arch_fast_mutex_trylock(&lock->count)
+#define mutex_is_locked(lock) \
+	({ mb(); atomic_read(&lock->count) != 1; })
+
+#else
+
 extern void FASTCALL(mutex_lock(struct mutex *lock));
-extern int FASTCALL(mutex_lock_interruptible(struct mutex *lock));
-extern int FASTCALL(mutex_trylock(struct mutex *lock));
 extern void FASTCALL(mutex_unlock(struct mutex *lock));
+extern int FASTCALL(mutex_trylock(struct mutex *lock));
 extern int FASTCALL(mutex_is_locked(struct mutex *lock));
 
+#endif
+
+extern int FASTCALL(mutex_lock_interruptible(struct mutex *lock));
+
 /*
  * Debugging variant of mutexes. The only difference is that they accept
  * the semaphore APIs too:
Index: linux-2.6/kernel/mutex.c
===================================================================
--- linux-2.6.orig/kernel/mutex.c
+++ linux-2.6/kernel/mutex.c
@@ -21,20 +21,6 @@
 #include <linux/interrupt.h>
 
 /*
- * We can speed up the lock-acquire, if the architecture
- * supports cmpxchg and if there's no debugging state
- * to be set up (!DEBUG_MUTEXESS).
- *
- * trick: we can use cmpxchg on the release side too, if bit
- * 0 of lock->owner is set if there is at least a single pending
- * task in the wait_list. This way the release atomic-fastpath
- * can be a mirror image of the acquire path:
- */
-#if defined(__HAVE_ARCH_CMPXCHG) && !defined(CONFIG_DEBUG_MUTEXESS)
-# define MUTEX_LOCKLESS_FASTPATH
-#endif
-
-/*
  * In the debug case we carry the caller's instruction pointer into
  * other functions, but we dont want the function argument overhead
  * in the nondebug case - hence these macros:
@@ -373,9 +359,7 @@ repeat:
 static int __mutex_trylock(struct mutex *lock __IP_DECL__)
 {
 #ifdef MUTEX_LOCKLESS_FASTPATH
-	if (atomic_cmpxchg(&lock->count, 1, 0) == 1)
-		return 1;
-	return 0;
+	return __arch_fast_mutex_trylock(&lock->count);
 #else
 	struct thread_info *ti = current_thread_info();
 	unsigned long flags;
@@ -397,19 +381,6 @@ static int __mutex_trylock(struct mutex 
 #endif
 }
 
-int fastcall mutex_is_locked(struct mutex *lock)
-{
-	mb();
-	return atomic_read(&lock->count) != 1;
-}
-
-EXPORT_SYMBOL_GPL(mutex_is_locked);
-
-int __sched fastcall mutex_trylock(struct mutex *lock)
-{
-	return __mutex_trylock(lock __CALLER_IP__);
-}
-
 /*
  * Release the lock:
  */
@@ -457,7 +428,6 @@ static inline void __mutex_unlock_nonato
  * We want the atomic op come first, to make sure the
  * branch is predicted as default-untaken:
  */
-static __sched void FASTCALL(__mutex_lock_noinline(atomic_t *lock_count));
 
 /*
  * The locking fastpath is the 1->0 transition from
@@ -465,39 +435,41 @@ static __sched void FASTCALL(__mutex_loc
  */
 static inline void __mutex_lock_atomic(struct mutex *lock)
 {
-	atomic_dec_call_if_negative(&lock->count, __mutex_lock_noinline);
+	__arch_fast_mutex_lock(&lock->count, __mutex_lock_noinline);
 }
 
-static fastcall __sched void __mutex_lock_noinline(atomic_t *lock_count)
+fastcall __sched void __mutex_lock_noinline(atomic_t *lock_count)
 {
 	struct mutex *lock = container_of(lock_count, struct mutex, count);
 
 	__mutex_lock_nonatomic(lock);
 }
 
+EXPORT_SYMBOL_GPL(__mutex_lock_noinline);
+
 static inline void __mutex_lock(struct mutex *lock)
 {
 	__mutex_lock_atomic(lock);
 }
 
-static void __sched FASTCALL(__mutex_unlock_noinline(atomic_t *lock_count));
-
 /*
  * The unlocking fastpath is the 0->1 transition from
  * 'locked' into 'unlocked' state:
  */
 static inline void __mutex_unlock_atomic(struct mutex *lock)
 {
-	atomic_inc_call_if_nonpositive(&lock->count, __mutex_unlock_noinline);
+	__arch_fast_mutex_unlock(&lock->count, __mutex_unlock_noinline);
 }
 
-static fastcall void __sched __mutex_unlock_noinline(atomic_t *lock_count)
+fastcall void __sched __mutex_unlock_noinline(atomic_t *lock_count)
 {
 	struct mutex *lock = container_of(lock_count, struct mutex, count);
 
 	__mutex_unlock_nonatomic(lock);
 }
 
+EXPORT_SYMBOL_GPL(__mutex_unlock_noinline);
+
 static inline void __mutex_unlock(struct mutex *lock)
 {
 	__mutex_unlock_atomic(lock);
@@ -517,6 +489,8 @@ static inline void __mutex_unlock(struct
 
 #endif
 
+#ifndef MUTEX_INLINE_FASTPATH
+
 void __sched fastcall mutex_lock(struct mutex *lock)
 {
 	__mutex_lock(lock __CALLER_IP__);
@@ -532,6 +506,23 @@ void __sched fastcall mutex_unlock(struc
 
 EXPORT_SYMBOL_GPL(mutex_unlock);
 
+int __sched fastcall mutex_trylock(struct mutex *lock)
+{
+	return __mutex_trylock(lock __CALLER_IP__);
+}
+
+EXPORT_SYMBOL_GPL(mutex_trylock);
+
+int fastcall mutex_is_locked(struct mutex *lock)
+{
+	mb();
+	return atomic_read(&lock->count) != 1;
+}
+
+EXPORT_SYMBOL_GPL(mutex_is_locked);
+
+#endif
+
 int __sched fastcall mutex_lock_interruptible(struct mutex *lock)
 {
 	return __mutex_lock_interruptible(lock, 0 __CALLER_IP__);
Index: linux-2.6/include/asm-generic/mutex.h
===================================================================
--- /dev/null
+++ linux-2.6/include/asm-generic/mutex.h
@@ -0,0 +1,22 @@
+/*
+ *  linux/include/asm-generic/mutex.h
+ *
+ *  Reference implementation for lockless fast path mutex operations
+ */
+
+#define MUTEX_LOCKLESS_FASTPATH
+
+#define __arch_fast_mutex_lock(count, contention_fn)			\
+do {									\
+	if (atomic_xchg(count, 0) != 1)					\
+		contention_fn(count);					\
+} while (0)
+
+#define __arch_fast_mutex_unlock(count, contention_fn)			\
+do {									\
+	if (atomic_xchg(count, 1) != 0)					\
+		contention_fn(count);					\
+} while (0)
+
+#define __arch_fast_mutex_trylock(count)				\
+	(atomic_cmpxchg(count, 1, 0) == 1)
Index: linux-2.6/include/asm-i386/mutex.h
===================================================================
--- /dev/null
+++ linux-2.6/include/asm-i386/mutex.h
@@ -0,0 +1,44 @@
+#define MUTEX_LOCKLESS_FASTPATH
+
+#define __arch_fast_mutex_lock(v, contention)				\
+do {									\
+	fastcall void (*__tmp)(atomic_t *) = contention;		\
+									\
+	(void)__tmp;							\
+	typecheck(atomic_t *, v);					\
+									\
+	__asm__ __volatile__(						\
+		LOCK "decl (%%eax)\n"  					\
+		"js 2f\n"						\
+		"1:\n"							\
+		LOCK_SECTION_START("")					\
+		"2: call "#contention"\n\t"				\
+		"jmp 1b\n"						\
+		LOCK_SECTION_END					\
+		:							\
+		:"a" (v)						\
+		:"memory","cx","dx");					\
+} while (0)
+
+#define __arch_fast_mutex_unlock(v, contention)				\
+do {									\
+	fastcall void (*__tmp)(atomic_t *) = contention;		\
+									\
+	(void)__tmp;							\
+	typecheck(atomic_t *, v);					\
+									\
+	__asm__ __volatile__(						\
+		LOCK "incl (%%eax)\n"  					\
+		"jle 2f\n"						\
+		"1:\n"							\
+		LOCK_SECTION_START("")					\
+		"2: call "#contention"\n\t"				\
+		"jmp 1b\n"						\
+		LOCK_SECTION_END					\
+		:							\
+		:"a" (v)						\
+		:"memory","cx","dx");					\
+} while (0)
+
+#define __arch_fast_mutex_trylock(v)					\
+	(atomic_cmpxchg(v, 1, 0) == 1)
Index: linux-2.6/include/asm-arm/mutex.h
===================================================================
--- /dev/null
+++ linux-2.6/include/asm-arm/mutex.h
@@ -0,0 +1,9 @@
+#include <asm/system.h>
+
+#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
+
+#include <asm-generic/mutex.h>
+
+#ifndef swp_is_buggy
+#define MUTEX_INLINE_FASTPATH
+#endif


Nicolas
