Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbVLZTZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbVLZTZr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 14:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbVLZTZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 14:25:47 -0500
Received: from relais.videotron.ca ([24.201.245.36]:53731 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932125AbVLZTZq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 14:25:46 -0500
Date: Mon, 26 Dec 2005 14:25:45 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: [patch 2/3] mutex subsystem: fastpath inlining
In-reply-to: <20051223161649.GA26830@elte.hu>
X-X-Sender: nico@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Message-id: <Pine.LNX.4.64.0512261414300.1496@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20051223161649.GA26830@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Some architectures, notably ARM for instance, might benefit from inlining
the mutex fast paths.  This patch allows for this when no debugging,
otherwise inlining is unconditionally disabled when debugging is enabled.

Signed-off-by: Nicolas Pitre <nico@cam.org>

Index: linux-2.6/include/asm-arm/mutex.h
===================================================================
--- linux-2.6.orig/include/asm-arm/mutex.h
+++ linux-2.6/include/asm-arm/mutex.h
@@ -8,6 +8,12 @@
 #ifndef _ASM_MUTEX_H
 #define _ASM_MUTEX_H
 
+/* On ARM it is best to inline the mutex fast paths, unless swp is broken. */
+#include <asm/system.h>
+#ifndef swp_is_buggy
+# define MUTEX_INLINE_FASTPATH
+#endif
+
 #if __LINUX_ARM_ARCH__ < 6
 /* On pre-ARMv6 hardware the swp based implementation is the most efficient. */
 # include <asm-generic/mutex-xchg.h>
Index: linux-2.6/kernel/mutex.c
===================================================================
--- linux-2.6.orig/kernel/mutex.c
+++ linux-2.6/kernel/mutex.c
@@ -16,16 +16,10 @@
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
 
-/*
- * In the DEBUG case we are using the "NULL fastpath" for mutexes,
- * which forces all calls into the slowpath:
- */
 #ifdef CONFIG_DEBUG_MUTEXES
 # include "mutex-debug.h"
-# include <asm-generic/mutex-null.h>
 #else
 # include "mutex.h"
-# include <asm/mutex.h>
 #endif
 
 /***
@@ -219,6 +213,7 @@ __mutex_lock_interruptible_nonatomic(str
 	return -EINTR;
 }
 
+#ifndef MUTEX_INLINE_FASTPATH
 /***
  * mutex_trylock - try acquire the mutex, without waiting
  * @lock: the mutex to be acquired
@@ -258,6 +253,7 @@ int fastcall mutex_trylock(struct mutex 
 	return ret;
 #endif
 }
+#endif
 
 /*
  * Release the lock, slowpath:
@@ -293,8 +289,16 @@ static inline void __mutex_unlock_nonato
  * We want the atomic ops to come first in the kernel image, to make
  * sure the branch is predicted by the CPU as default-untaken:
  */
-static __sched void FASTCALL(__mutex_lock_noinline(atomic_t *lock_count
-						   __IP_DECL__));
+
+#ifndef MUTEX_INLINE_FASTPATH
+/* if we don't inline fast paths, then make those static */
+static void fastcall __sched
+__mutex_lock_noinline(atomic_t *lock_count __IP_DECL__);
+static int fastcall __sched
+__mutex_lock_interruptible_noinline(atomic_t *lock_count __IP_DECL__);
+static void fastcall __sched
+__mutex_unlock_noinline(atomic_t *lock_count __IP_DECL__);
+#endif
 
 /*
  * The locking fastpath is the 1->0 transition from 'unlocked' into
@@ -305,7 +309,7 @@ static inline void __mutex_lock_atomic(s
 	__mutex_fastpath_lock(&lock->count, __mutex_lock_noinline);
 }
 
-static void fastcall __sched
+void fastcall __sched
 __mutex_lock_noinline(atomic_t *lock_count __IP_DECL__)
 {
 	struct mutex *lock = container_of(lock_count, struct mutex, count);
@@ -318,16 +322,13 @@ static inline void __mutex_lock(struct m
 	__mutex_lock_atomic(lock __IP__);
 }
 
-static int fastcall __sched
-__mutex_lock_interruptible_noinline(atomic_t *lock_count __IP_DECL__);
-
 static inline int __mutex_lock_interruptible(struct mutex *lock __IP_DECL__)
 {
 	return __mutex_fastpath_lock_retval
 			(&lock->count, __mutex_lock_interruptible_noinline);
 }
 
-static int fastcall __sched
+int fastcall __sched
 __mutex_lock_interruptible_noinline(atomic_t *lock_count __IP_DECL__)
 {
 	struct mutex *lock = container_of(lock_count, struct mutex, count);
@@ -335,9 +336,6 @@ __mutex_lock_interruptible_noinline(atom
 	return __mutex_lock_interruptible_nonatomic(lock __IP__);
 }
 
-static void __sched FASTCALL(__mutex_unlock_noinline(atomic_t *lock_count
-						     __IP_DECL__));
-
 /*
  * The unlocking fastpath is the 0->1 transition from 'locked' into
  * 'unlocked' state:
@@ -347,8 +345,8 @@ static inline void __mutex_unlock_atomic
 	__mutex_fastpath_unlock(&lock->count, __mutex_unlock_noinline);
 }
 
-static void fastcall __sched __mutex_unlock_noinline(atomic_t *lock_count
-						     __IP_DECL__)
+void fastcall __sched
+__mutex_unlock_noinline(atomic_t *lock_count __IP_DECL__)
 {
 	struct mutex *lock = container_of(lock_count, struct mutex, count);
 
@@ -360,6 +358,8 @@ static inline void __mutex_unlock(struct
 	__mutex_unlock_atomic(lock __IP__);
 }
 
+#ifndef MUTEX_INLINE_FASTPATH
+
 /***
  * mutex_lock - acquire the mutex
  * @lock: the mutex to be acquired
@@ -422,6 +422,8 @@ EXPORT_SYMBOL(mutex_lock);
 EXPORT_SYMBOL(mutex_unlock);
 EXPORT_SYMBOL(mutex_lock_interruptible);
 
+#endif
+
 /***
  * mutex_init - initialize the mutex
  * @lock: the mutex to be initialized
Index: linux-2.6/include/linux/mutex.h
===================================================================
--- linux-2.6.orig/include/linux/mutex.h
+++ linux-2.6/include/linux/mutex.h
@@ -92,10 +92,53 @@ struct mutex_waiter {
 
 extern void FASTCALL(__mutex_init(struct mutex *lock, const char *name));
 
+/*
+ * In the DEBUG case we are using the "NULL fastpath" for mutexes,
+ * which forces all calls into the slowpath. We also unconditionally disable
+ * any fastpath inlining.
+ */
+#ifdef CONFIG_DEBUG_MUTEXES
+# include <asm-generic/mutex-null.h>
+# undef MUTEX_INLINE_FASTPATH
+#else
+# include <asm/mutex.h>
+#endif
+
+#ifdef MUTEX_INLINE_FASTPATH
+
+#include <linux/sched.h>
+extern void fastcall __sched __mutex_lock_noinline(atomic_t *lock_count);
+extern int fastcall __sched __mutex_lock_interruptible_noinline(atomic_t *lock_count);
+extern void fastcall __sched __mutex_unlock_noinline(atomic_t *lock_count);
+
+static inline int mutex_trylock(struct mutex *lock)
+{
+	return __mutex_trylock(&lock->count);
+}
+
+static inline void mutex_lock(struct mutex *lock)
+{
+	__mutex_fastpath_lock(&lock->count, __mutex_lock_noinline);
+}
+
+static inline int mutex_lock_interruptible(struct mutex *lock)
+{
+	return __mutex_fastpath_lock_retval
+		(&lock->count, __mutex_lock_interruptible_noinline);
+}
+
+static inline void mutex_unlock(struct mutex *lock)
+{
+	__mutex_fastpath_unlock(&lock->count, __mutex_unlock_noinline);
+}
+
+#else
 extern void FASTCALL(mutex_lock(struct mutex *lock));
 extern int FASTCALL(mutex_lock_interruptible(struct mutex *lock));
 extern int FASTCALL(mutex_trylock(struct mutex *lock));
 extern void FASTCALL(mutex_unlock(struct mutex *lock));
+#endif
+
 extern int FASTCALL(mutex_is_locked(struct mutex *lock));
 
 #endif
