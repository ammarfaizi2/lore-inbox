Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030311AbVLVVlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030311AbVLVVlD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 16:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030315AbVLVVlC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 16:41:02 -0500
Received: from relais.videotron.ca ([24.201.245.36]:49199 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1030311AbVLVVlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 16:41:00 -0500
Date: Thu, 22 Dec 2005 16:40:44 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: [patch 2/2] mutex subsystem: use the per architecture fast path
 lock_unlock defines
In-reply-to: <Pine.LNX.4.64.0512221613010.26663@localhost.localdomain>
X-X-Sender: nico@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
Cc: Christoph Hellwig <hch@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>, Andi Kleen <ak@suse.de>
Message-id: <Pine.LNX.4.64.0512221637570.26663@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20051222114147.GA18878@elte.hu>
 <20051222115329.GA30964@infradead.org>
 <Pine.LNX.4.64.0512221025070.26663@localhost.localdomain>
 <20051222154012.GA6284@elte.hu>
 <Pine.LNX.4.64.0512221113560.26663@localhost.localdomain>
 <20051222164415.GA10628@elte.hu>
 <20051222165828.GA5268@flint.arm.linux.org.uk>
 <20051222210446.GA16092@elte.hu>
 <Pine.LNX.4.64.0512221613010.26663@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This switch the core over to the architecture defined fast path locking 
primitives.  It also adds __mutex_lock_interruptible_noinline and 
friends.

Index: linux-2.6/kernel/mutex.c
===================================================================
--- linux-2.6.orig/kernel/mutex.c
+++ linux-2.6/kernel/mutex.c
@@ -266,13 +266,8 @@ __mutex_lock_interruptible_nonatomic(str
  */
 int fastcall mutex_trylock(struct mutex *lock)
 {
-#ifdef __HAVE_ARCH_CMPXCHG
 	if (atomic_cmpxchg(&lock->count, 1, 0) == 1)
 		return 1;
-#else
-	if (atomic_dec_return(&lock->count) == 0)
-		return 1;
-#endif
 	return 0;
 }
 
@@ -316,13 +311,14 @@ static inline void __mutex_unlock_nonato
 	 * Waiters take care of themselves and stay in flight until
 	 * necessary.
 	 *
-	 * (in the xchg based implementation the fastpath has set the
+	 * (depending on the implementation the fastpath has set the
 	 *  count to 1 already, so we must not set it here, because we
 	 *  dont own the lock anymore. In the debug case we must set
 	 *  the lock inside the spinlock.)
 	 */
-#if !defined(CONFIG_MUTEX_XCHG_ALGORITHM) && !defined(CONFIG_DEBUG_MUTEXES)
-	atomic_set(&lock->count, 1);
+#if !defined(CONFIG_DEBUG_MUTEXES)
+	if (__mutex_slowpath_needs_unlock())
+		atomic_set(&lock->count, 1);
 #endif
 	spin_lock_mutex(&lock->wait_lock);
 #ifdef CONFIG_DEBUG_MUTEXES
@@ -349,21 +345,12 @@ static inline void __mutex_unlock_nonato
 static __sched void FASTCALL(__mutex_lock_noinline(atomic_t *lock_count));
 
 /*
- * Some architectures do not have fast dec_and_test atomic primitives,
- * for them we are providing an atomic_xchg() based mutex implementation,
- * if they enable CONFIG_MUTEX_XCHG_ALGORITHM.
- *
  * The locking fastpath is the 1->0 transition from 'unlocked' into
  * 'locked' state:
  */
 static inline void __mutex_lock_atomic(struct mutex *lock)
 {
-#ifdef CONFIG_MUTEX_XCHG_ALGORITHM
-	if (unlikely(atomic_xchg(&lock->count, 0) != 1))
-		__mutex_lock_noinline(&lock->count);
-#else
-	atomic_dec_call_if_negative(&lock->count, __mutex_lock_noinline);
-#endif
+	__mutex_fastpath_lock(&lock->count, __mutex_lock_noinline);
 }
 
 /*
@@ -383,16 +370,23 @@ static inline void __mutex_lock(struct m
 	__mutex_lock_atomic(lock);
 }
 
+static __sched int FASTCALL(__mutex_lock_interruptible_noinline(atomic_t *lock_count));
+
+static int __mutex_lock_interruptible_atomic(struct mutex *lock)
+{
+	__mutex_fastpath_lock_retval(&lock->count, __mutex_lock_interruptible_noinline);
+}
+
+static int fastcall __sched __mutex_lock_interruptible_noinline(atomic_t *lock_count)
+{
+	struct mutex *lock = container_of(lock_count, struct mutex, count);
+
+	return __mutex_lock_interruptible_nonatomic(lock);
+}
+
 static inline int __mutex_lock_interruptible(struct mutex *lock)
 {
-#ifdef CONFIG_MUTEX_XCHG_ALGORITHM
-	if (unlikely(atomic_xchg(&lock->count, 0) != 1))
-		return __mutex_lock_interruptible_nonatomic(lock);
-#else
-	if (unlikely(atomic_dec_return(&lock->count) < 0))
-		return __mutex_lock_interruptible_nonatomic(lock);
-#endif
-	return 0;
+	__mutex_lock_interruptible_atomic(lock);
 }
 
 static void __sched FASTCALL(__mutex_unlock_noinline(atomic_t *lock_count));
@@ -403,12 +397,7 @@ static void __sched FASTCALL(__mutex_unl
  */
 static inline void __mutex_unlock_atomic(struct mutex *lock)
 {
-#ifdef CONFIG_MUTEX_XCHG_ALGORITHM
-	if (unlikely(atomic_xchg(&lock->count, 1) != 0))
-		__mutex_unlock_noinline(&lock->count);
-#else
-	atomic_inc_call_if_nonpositive(&lock->count, __mutex_unlock_noinline);
-#endif
+	__mutex_fastpath_unlock(&lock->count, __mutex_unlock_noinline);
 }
 
 static void fastcall __sched __mutex_unlock_noinline(atomic_t *lock_count)
Index: linux-2.6/include/linux/mutex.h
===================================================================
--- linux-2.6.orig/include/linux/mutex.h
+++ linux-2.6/include/linux/mutex.h
@@ -12,6 +12,7 @@
  */
 #include <linux/list.h>
 #include <linux/spinlock_types.h>
+#include <asm/mutex.h>
 
 #include <asm/atomic.h>
 
