Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965086AbVLVGx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965086AbVLVGx3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 01:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965088AbVLVGx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 01:53:29 -0500
Received: from relais.videotron.ca ([24.201.245.36]:26067 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S965086AbVLVGx1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 01:53:27 -0500
Date: Thu, 22 Dec 2005 01:53:26 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: [patch 4/5] mutex subsystem: allow architecture defined fast path for
 mutex_lock_interruptible
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
Message-id: <Pine.LNX.4.64.0512220136470.26663@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20051221155411.GA7243@elte.hu>
 <Pine.LNX.4.64.0512211735030.26663@localhost.localdomain>
 <20051221231218.GA6747@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds another architecture helper, 
arch_mutex_fast_lock_retval(), to allows for mutex_lock_interruptible
to have an architecture defined fast path.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

Index: linux-2.6/include/asm-generic/mutex.h
===================================================================
--- linux-2.6.orig/include/asm-generic/mutex.h
+++ linux-2.6/include/asm-generic/mutex.h
@@ -26,6 +26,24 @@ do {									\
 } while (0)
 
 /**
+ * arch_mutex_fast_lock_retval - lock mutex and call function if already locked
+ * @v: pointer of type atomic_t
+ * @contention_fn: function to call if v was already locked
+ *
+ * Atomically locks @v and calls a function if @v was already locked.
+ * When @v == 1 it is unlocked, <= 0 means locked.
+ *
+ * Returns 0 if no contention, otherwise returns whatever from @contention_fn.
+ */
+#define arch_mutex_fast_lock_retval(v, contention_fn)			\
+({									\
+	int __retval = 0;						\
+	if (unlikely(atomic_xchg(v, 0) != 1))				\
+		__retval = contention_fn(v);				\
+	__retval;							\
+})
+
+/**
  * arch_mutex_fast_unlock - unlock and call function if contended
  * @v: pointer of type atomic_t
  * @contention_fn: function to call if v was contended
Index: linux-2.6/include/asm-i386/mutex.h
===================================================================
--- linux-2.6.orig/include/asm-i386/mutex.h
+++ linux-2.6/include/asm-i386/mutex.h
@@ -14,6 +14,14 @@
 #define arch_mutex_fast_lock(v, contention_fn)				\
 	atomic_dec_call_if_negative(v, contention_fn)
 
+#define arch_mutex_fast_lock_retval(v, contention_fn)			\
+({									\
+	int __retval = 0;						\
+	if (unlikely(atomic_dec_return(v) < 0))				\
+ 		__retval = contention_fnv);				\
+	__retval;							\
+})
+
 #define arch_mutex_fast_unlock(v, contention_fn)			\
 	atomic_inc_call_if_nonpositive(v, contention_fn)
 
Index: linux-2.6/kernel/mutex.c
===================================================================
--- linux-2.6.orig/kernel/mutex.c
+++ linux-2.6/kernel/mutex.c
@@ -336,11 +336,24 @@ static inline void __mutex_lock(struct m
 	__mutex_lock_atomic(lock);
 }
 
+static __sched int FASTCALL(__mutex_lock_interruptible_noinline(atomic_t *lock_count));
+
+static inline int __mutex_lock_interruptible_atomic(struct mutex *lock)
+{
+	return arch_mutex_fast_lock_retval(&lock->count,
+					   __mutex_lock_interruptible_noinline);
+}
+
+static fastcall __sched int __mutex_lock_interruptible_noinline(atomic_t *lock_count)
+{
+	struct mutex *lock = container_of(lock_count, struct mutex, count);
+
+	return __mutex_lock_interruptible_nonatomic(lock);
+}
+
 static inline int __mutex_lock_interruptible(struct mutex *lock)
 {
-	if (unlikely(atomic_dec_return(&lock->count) < 0))
-		return __mutex_lock_interruptible_nonatomic(lock);
-	return 0;
+	return __mutex_lock_interruptible_atomic(lock);
 }
 
 static void __sched FASTCALL(__mutex_unlock_noinline(atomic_t *lock_count));
Index: linux-2.6/include/asm-x86_64/mutex.h
===================================================================
--- linux-2.6.orig/include/asm-x86_64/mutex.h
+++ linux-2.6/include/asm-x86_64/mutex.h
@@ -14,6 +14,14 @@
 #define arch_mutex_fast_lock(v, contention_fn)				\
 	atomic_dec_call_if_negative(v, contention_fn)
 
+#define arch_mutex_fast_lock_retval(v, contention_fn)			\
+({									\
+	int __retval = 0;						\
+	if (unlikely(atomic_dec_return(v) < 0))				\
+ 		__retval = contention_fnv);				\
+	__retval;							\
+})
+
 #define arch_mutex_fast_unlock(v, contention_fn)			\
 	atomic_inc_call_if_nonpositive(v, contention_fn)
 
