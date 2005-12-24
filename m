Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932499AbVLXFXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932499AbVLXFXQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 00:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbVLXFXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 00:23:16 -0500
Received: from relais.videotron.ca ([24.201.245.36]:39795 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932499AbVLXFXQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 00:23:16 -0500
Date: Sat, 24 Dec 2005 00:23:14 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 00/11] mutex subsystem, -V7
In-reply-to: <Pine.LNX.4.64.0512240009270.26663@localhost.localdomain>
X-X-Sender: nico@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Message-id: <Pine.LNX.4.64.0512240021380.26663@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20051223161649.GA26830@elte.hu>
 <Pine.LNX.4.64.0512240009270.26663@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Dec 2005, Nicolas Pitre wrote:

> Here's another one, allowing architecture specific trylock 
> implementations.  New generic xchg-based and ARMv6 implementations are 
> provided, while everything else remains the same.

Sorry, the previous patch was missing one file (mutex-dec.h).

Signed-off-by: Nicolas Pitre <nico@cam.org>

Index: linux-2.6/include/asm-generic/mutex-xchg.h
===================================================================
--- linux-2.6.orig/include/asm-generic/mutex-xchg.h
+++ linux-2.6/include/asm-generic/mutex-xchg.h
@@ -69,4 +69,38 @@ do {									\
 
 #define __mutex_slowpath_needs_to_unlock()		0
 
+/**
+ * __mutex_trylock - try to acquire the mutex, without waiting
+ *
+ *  @count: pointer of type atomic_t
+ *
+ * Change the count from 1 to a value lower than 1, and return 0 (failure)
+ * if it wasn't 1 originally, or return 1 (success) otherwise. This function
+ * MUST leave the value lower than 1 even when the "1" assertion wasn't true.
+ * Additionally, if the value was < 0 originally, this function must not leave
+ * it to 0 on failure.
+ */
+static inline int
+__mutex_trylock(atomic_t *count)
+{
+	int prev = atomic_xchg(count, 0);
+
+	if (unlikely(prev < 0)) {
+		/*
+		 * The lock was marked contended so we must restore that
+		 * state. If while doing so we get back a prev value of 1
+		 * then we just own it.
+		 *
+		 * IN all cases this has the potential to trigger the
+		 * slowpath for the owner's unlock path - but this is not
+		 * a big problem in practice.
+		 */
+		prev = atomic_xchg(count, -1);
+		if (prev < 0)
+			prev = 0;
+	}
+
+	return prev;
+}
+
 #endif
Index: linux-2.6/include/asm-i386/mutex.h
===================================================================
--- linux-2.6.orig/include/asm-i386/mutex.h
+++ linux-2.6/include/asm-i386/mutex.h
@@ -99,4 +99,38 @@ do {									\
 
 #define __mutex_slowpath_needs_to_unlock()	1
 
+/**
+ * __mutex_trylock - try to acquire the mutex, without waiting
+ *
+ *  @count: pointer of type atomic_t
+ *
+ * Change the count from 1 to a value lower than 1, and return 0 (failure)
+ * if it wasn't 1 originally, or return 1 (success) otherwise. This function
+ * MUST leave the value lower than 1 even when the "1" assertion wasn't true.
+ * Additionally, if the value was < 0 originally, this function must not leave
+ * it to 0 on failure.
+ */
+static inline int
+__mutex_trylock(atomic_t *count)
+{
+	/*
+	 * We have two variants here. The cmpxchg based one is the best one
+	 * because it never induce a false contention state.
+	 * If not available we fall back to the atomic_dec_return variant.
+	 *
+	 * The atomic_dec_return variant might end up making the counter
+	 * negative in the failure case, which may trigger the slowpath
+	 * for the owner's unlock path - but this is not a big problem
+	 * in practice.
+	 */
+#ifdef __HAVE_ARCH_CMPXCHG
+	if (likely(atomic_cmpxchg(count, 1, 0)) == 1)
+		return 1;
+#else
+	if (likely(atomic_dec_return(count) == 0))
+		return 1;
+#endif
+	return 0;
+}
+
 #endif
Index: linux-2.6/include/asm-x86_64/mutex.h
===================================================================
--- linux-2.6.orig/include/asm-x86_64/mutex.h
+++ linux-2.6/include/asm-x86_64/mutex.h
@@ -71,4 +71,21 @@ do {									\
 
 #define __mutex_slowpath_needs_to_unlock()	1
 
+/**
+ * __mutex_trylock - try to acquire the mutex, without waiting
+ *
+ *  @count: pointer of type atomic_t
+ *
+ * Change the count from 1 to 0 and return 1 (success), or return 0 (failure)
+ * if it wasn't 1 originally.
+ */
+static inline int
+__mutex_trylock(atomic_t *count)
+{
+	if (likely(atomic_cmpxchg(count, 1, 0)) == 1)
+		return 1;
+	else
+		return 0;
+}
+
 #endif
Index: linux-2.6/kernel/mutex.c
===================================================================
--- linux-2.6.orig/kernel/mutex.c
+++ linux-2.6/kernel/mutex.c
@@ -219,19 +219,6 @@ __mutex_lock_interruptible_nonatomic(str
 	return -EINTR;
 }
 
-/*
- * We have three mutex_trylock() variants. The cmpxchg based one is
- * the best one (because it has no side-effect on mutex_unlock()),
- * but cmpxchg is not available on every architecture, so we also
- * provide an atomic_dec_return based variant too. The debug variant
- * takes the internal lock.
- *
- * [ The atomic_dec_return variant might end up making the counter
- *   negative in the failure case, which may trigger the slowpath
- *   for the owner's unlock path - but this is not a big problem
- *   in practice. ]
- */
-#ifndef CONFIG_DEBUG_MUTEXES
 /***
  * mutex_trylock - try acquire the mutex, without waiting
  * @lock: the mutex to be acquired
@@ -248,24 +235,13 @@ __mutex_lock_interruptible_nonatomic(str
  */
 int fastcall mutex_trylock(struct mutex *lock)
 {
-#ifdef __HAVE_ARCH_CMPXCHG
-	if (atomic_cmpxchg(&lock->count, 1, 0) == 1)
-		return 1;
+#ifndef CONFIG_DEBUG_MUTEXES
+	return __mutex_trylock(&lock->count);
 #else
-	if (atomic_dec_return(&lock->count) == 0)
-		return 1;
-#endif
-	return 0;
-}
-
-#else /* CONFIG_DEBUG_MUTEXES: */
-
-/*
- * In the debug case we take the spinlock and check whether we can
- * get the lock:
- */
-int fastcall mutex_trylock(struct mutex *lock)
-{
+	/*
+	 * In the debug case we take the spinlock and check whether we can
+	 * get the lock:
+	 */
 	struct thread_info *ti = current_thread_info();
 	int ret = 0;
 
@@ -280,10 +256,9 @@ int fastcall mutex_trylock(struct mutex 
 	spin_unlock_mutex(&lock->wait_lock);
 
 	return ret;
+#endif
 }
 
-#endif /* CONFIG_DEBUG_MUTEXES */
-
 /*
  * Release the lock, slowpath:
  */
Index: linux-2.6/include/asm-arm/mutex.h
===================================================================
--- linux-2.6.orig/include/asm-arm/mutex.h
+++ linux-2.6/include/asm-arm/mutex.h
@@ -98,5 +98,31 @@ do {									\
  */
 #define __mutex_slowpath_needs_to_unlock()	1
 
+/*
+ * For __mutex_trylock we use another construct which could be described
+ * as an "incomplete atomic decrement" or a "single value cmpxchg" since
+ * it has two modes of failure:
+ *
+ * 1) if the exclusive store fails we fail, and
+ *
+ * 2) if the decremented value is not zero we don't even attempt the store.
+ *
+ * This provides the needed trylock semantics like cmpxchg would, but it is
+ * lighter and less generic than a true cmpxchg implementation.
+ */
+static inline int __mutex_trylock(atomic_t *count)
+{
+	int __ex_flag, __res;
+	__asm__ (
+	"ldrex	%0, [%2]\n\t"
+	"subs	%0, %0, #1\n\t"
+	"strexeq %1, %0, [%2]"
+	: "=&r" (__res), "=&r" (__ex_flag)
+	: "r" (&count->counter)
+	: "cc","memory" );
+	__res |= __ex_flag;
+	return __res == 0;
+}
+
 #endif
 #endif
Index: linux-2.6/include/asm-generic/mutex-dec.h
===================================================================
--- linux-2.6.orig/include/asm-generic/mutex-dec.h
+++ linux-2.6/include/asm-generic/mutex-dec.h
@@ -63,4 +63,40 @@ do {									\
 
 #define __mutex_slowpath_needs_to_unlock()		1
 
+/**
+ * __mutex_trylock - try to acquire the mutex, without waiting
+ *
+ *  @count: pointer of type atomic_t
+ *
+ * Change the count from 1 to a value lower than 1, and return 0 (failure)
+ * if it wasn't 1 originally, or return 1 (success) otherwise. This function
+ * MUST leave the value lower than 1 even when the "1" assertion wasn't true.
+ * Additionally, if the value was < 0 originally, this function must not leave
+ * it to 0 on failure.
+ */
+static inline int
+__mutex_trylock(atomic_t *count)
+{
+	/*
+	 * We have two variants here. The cmpxchg based one is the best one
+	 * because it never induce a false contention state.  It is included
+	 * here because architectures using the inc/dec algorithms over the
+	 * xchg ones are much more likely to support cmpxchg natively.
+	 * If not we fall back to the atomic_dec_return variant.
+	 *
+	 * The atomic_dec_return variant might end up making the counter
+	 * negative in the failure case, which may trigger the slowpath
+	 * for the owner's unlock path - but this is not a big problem
+	 * in practice.
+	 */
+#ifdef __HAVE_ARCH_CMPXCHG
+	if (likely(atomic_cmpxchg(count, 1, 0)) == 1)
+		return 1;
+#else
+	if (likely(atomic_dec_return(count) == 0))
+		return 1;
+#endif
+	return 0;
+}
+
 #endif
