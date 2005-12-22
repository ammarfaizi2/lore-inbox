Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965085AbVLVGxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965085AbVLVGxo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 01:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965088AbVLVGxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 01:53:43 -0500
Received: from relais.videotron.ca ([24.201.245.36]:61651 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S965085AbVLVGxk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 01:53:40 -0500
Date: Thu, 22 Dec 2005 01:53:38 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: [patch 5/5] mutex subsystem: allow for the fast path to be inlined
In-reply-to: <20051221231218.GA6747@elte.hu>
X-X-Sender: nico@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Message-id: <Pine.LNX.4.64.0512220142530.26663@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20051221155411.GA7243@elte.hu>
 <Pine.LNX.4.64.0512211735030.26663@localhost.localdomain>
 <20051221231218.GA6747@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This lets the architecture decide whether it wants the mutex fast path 
inlined or not.  On ARM it is (now) worthwhile to do so.

Also get rid of ARCH_IMPLEMENTS_MUTEX_FASTPATH since at this point it is 
rather useless.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

Index: linux-2.6/include/linux/mutex.h
===================================================================
--- linux-2.6.orig/include/linux/mutex.h
+++ linux-2.6/include/linux/mutex.h
@@ -92,10 +92,41 @@ struct mutex_waiter {
 
 extern void FASTCALL(__mutex_init(struct mutex *lock, const char *name));
 
+#ifdef CONFIG_DEBUG_MUTEXES
+#undef MUTEX_INLINE_FASTPATH
+#endif
+
+#ifdef MUTEX_INLINE_FASTPATH
+
+extern void FASTCALL(__mutex_lock_noinline(atomic_t *lock_count));
+extern int FASTCALL(__mutex_lock_interruptible_noinline(atomic_t *lock_count));
+extern void FASTCALL(__mutex_unlock_noinline(atomic_t *lock_count));
+
+static inline void mutex_lock(struct mutex *lock)
+{
+	arch_mutex_fast_lock(&lock->count, __mutex_lock_noinline);
+}
+
+static inline int mutex_lock_interruptible(struct mutex *lock)
+{
+	return arch_mutex_fast_lock_retval(&lock->count,
+					   __mutex_lock_interruptible_noinline);
+}
+
+static inline void mutex_unlock(struct mutex *lock)
+{
+	arch_mutex_fast_unlock(&lock->count, __mutex_unlock_noinline);
+}
+
+#else
+
 extern void FASTCALL(mutex_lock(struct mutex *lock));
 extern int FASTCALL(mutex_lock_interruptible(struct mutex *lock));
-extern int FASTCALL(mutex_trylock(struct mutex *lock));
 extern void FASTCALL(mutex_unlock(struct mutex *lock));
+
+#endif
+
+extern int FASTCALL(mutex_trylock(struct mutex *lock));
 extern int FASTCALL(mutex_is_locked(struct mutex *lock));
 
 #endif
Index: linux-2.6/kernel/mutex.c
===================================================================
--- linux-2.6.orig/kernel/mutex.c
+++ linux-2.6/kernel/mutex.c
@@ -313,7 +313,12 @@ static inline void __mutex_unlock_nonato
  * We want the atomic op come first, to make sure the
  * branch is predicted as default-untaken:
  */
+
+#ifndef MUTEX_INLINE_FASTPATH
 static __sched void FASTCALL(__mutex_lock_noinline(atomic_t *lock_count));
+static __sched int FASTCALL(__mutex_lock_interruptible_noinline(atomic_t *lock_count));
+static __sched void FASTCALL(__mutex_unlock_noinline(atomic_t *lock_count));
+#endif
 
 /*
  * The locking fastpath is the 1->0 transition from
@@ -324,7 +329,7 @@ static inline void __mutex_lock_atomic(s
 	arch_mutex_fast_lock(&lock->count, __mutex_lock_noinline);
 }
 
-static fastcall __sched void __mutex_lock_noinline(atomic_t *lock_count)
+fastcall __sched void __mutex_lock_noinline(atomic_t *lock_count)
 {
 	struct mutex *lock = container_of(lock_count, struct mutex, count);
 
@@ -336,15 +341,13 @@ static inline void __mutex_lock(struct m
 	__mutex_lock_atomic(lock);
 }
 
-static __sched int FASTCALL(__mutex_lock_interruptible_noinline(atomic_t *lock_count));
-
 static inline int __mutex_lock_interruptible_atomic(struct mutex *lock)
 {
 	return arch_mutex_fast_lock_retval(&lock->count,
 					   __mutex_lock_interruptible_noinline);
 }
 
-static fastcall __sched int __mutex_lock_interruptible_noinline(atomic_t *lock_count)
+fastcall __sched int __mutex_lock_interruptible_noinline(atomic_t *lock_count)
 {
 	struct mutex *lock = container_of(lock_count, struct mutex, count);
 
@@ -356,8 +359,6 @@ static inline int __mutex_lock_interrupt
 	return __mutex_lock_interruptible_atomic(lock);
 }
 
-static void __sched FASTCALL(__mutex_unlock_noinline(atomic_t *lock_count));
-
 /*
  * The unlocking fastpath is the 0->1 transition from
  * 'locked' into 'unlocked' state:
@@ -367,7 +368,7 @@ static inline void __mutex_unlock_atomic
 	arch_mutex_fast_unlock(&lock->count, __mutex_unlock_noinline);
 }
 
-static fastcall void __sched __mutex_unlock_noinline(atomic_t *lock_count)
+fastcall void __sched __mutex_unlock_noinline(atomic_t *lock_count)
 {
 	struct mutex *lock = container_of(lock_count, struct mutex, count);
 
@@ -412,25 +413,14 @@ static inline int __mutex_lock_interrupt
 #endif
 
 /*
- * Some architectures provide hand-coded mutex_lock() functions,
- * the will call the mutex_*_slowpath() generic functions:
+ * Some architectures benefit from extra performances when
+ * the fast path is inlined.
  */
-#ifdef ARCH_IMPLEMENTS_MUTEX_FASTPATH
-
-void __sched fastcall mutex_lock_slowpath(struct mutex *lock)
-{
-	__mutex_lock(lock);
-}
+#ifdef MUTEX_INLINE_FASTPATH
 
-void __sched fastcall mutex_unlock_slowpath(struct mutex *lock)
-{
-	__mutex_unlock(lock);
-}
-
-int __sched fastcall mutex_lock_interruptible_slowpath(struct mutex *lock)
-{
-	return __mutex_lock_interruptible(lock);
-}
+EXPORT_SYMBOL_GPL(__mutex_lock_noinline);
+EXPORT_SYMBOL_GPL(__mutex_lock_interruptible_noinline);
+EXPORT_SYMBOL_GPL(__mutex_unlock_noinline);
 
 #else
 
@@ -450,12 +440,12 @@ int __sched fastcall mutex_lock_interrup
 	return __mutex_lock_interruptible(lock __CALLER_IP__);
 }
 
-#endif
-
 EXPORT_SYMBOL_GPL(mutex_lock);
 EXPORT_SYMBOL_GPL(mutex_unlock);
 EXPORT_SYMBOL_GPL(mutex_lock_interruptible);
 
+#endif
+
 /*
  * Initialise the lock:
  */
Index: linux-2.6/include/asm-arm/mutex.h
===================================================================
--- linux-2.6.orig/include/asm-arm/mutex.h
+++ linux-2.6/include/asm-arm/mutex.h
@@ -1 +1,3 @@
 #include <asm-generic/mutex.h>
+
+#define MUTEX_INLINE_FASTPATH
