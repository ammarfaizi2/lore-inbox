Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964901AbVLUWob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964901AbVLUWob (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 17:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbVLUWob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 17:44:31 -0500
Received: from relais.videotron.ca ([24.201.245.36]:50379 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S964868AbVLUWo3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 17:44:29 -0500
Date: Wed, 21 Dec 2005 17:44:28 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: [patch 2/3] mutex subsystem: add new atomic primitives
In-reply-to: <20051221155411.GA7243@elte.hu>
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
Message-id: <Pine.LNX.4.64.0512211715490.26663@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20051221155411.GA7243@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While atomic_dec_call_if_negative() and atomic_inc_call_if_nonpositive() 
are certainly really nice and probably a good starting point for some 
consolidation of the different semaphore implementations, they still 
have stricter semantics than necessary for mutex usage.

This patch adds 3 new helpers that allows for greater flexibility in 
their implementation while preserving the mutex semantics:

  atomic_lock_call_if_contended()
  atomic_unlock_call_if_contended()
  atomic_contended_unlock_fixup()

In particular, they can be implemented in terms of a single atomic swap 
which most architectures can do natively without any locking. With this 
the mutex optimizations only have to be done in those atomic helpers 
while everything else may be generic common code.

On i386 and x86_64 those new helpers are simply defined in terms of the 
existing atomic_dec_call_if_negative() and 
atomic_inc_call_if_nonpositive() since they already provide the best 
that can be done.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

Index: linux-2.6/include/asm-generic/atomic-call-if.h
===================================================================
--- linux-2.6.orig/include/asm-generic/atomic-call-if.h
+++ linux-2.6/include/asm-generic/atomic-call-if.h
@@ -34,4 +34,51 @@ do {									\
 		fn_name(v);						\
 } while (0)
 
+/**
+ * atomic_lock_call_if_contended - lock and call function if already locked
+ * @v: pointer of type atomic_t
+ * @fn: function to call if v was already locked
+ *
+ * Atomically locks @v and calls a function if @v was already locked.
+ * When @v == 1 it is unlocked, <= 0 means locked.
+ */
+#define atomic_lock_call_if_contended(v, fn_name)			\
+do {									\
+	if (atomic_xchg(v, 0) != 1)					\
+		fn_name(v);						\
+} while (0)
+
+/**
+ * atomic_unlock_call_if_contended - unlock and call function if contended
+ * @v: pointer of type atomic_t
+ * @fn: function to call if the value was contended
+ *
+ * Atomically unlocks @v and calls a function if @v was contended.
+ * When @v == 1 it is unlocked, 0 it is locked, any negative value means
+ * locked with contention. When @v is contended, it is undefined whether @v
+ * is locked or not (implementation dependent) after this call until the @fn
+ * function uses atomic_contended_unlock_fixup() to apply the necessary
+ * fixup (if any).
+ */
+#define atomic_unlock_call_if_contended(v, fn_name)			\
+do {									\
+	if (atomic_xchg(v, 1) != 0)					\
+		fn_name(v);						\
+} while (0)
+
+/**
+ * atomic_contended_unlock_fixup - apply any needed fixup for contended unlock
+ *
+ * @v: pointer of type atomic_t
+ *
+ * This is meant to be called unconditionally from any function passed to
+ * atomic_unlock_call_if_contended. Provides any needed fixup for unlocking
+ * @v if the implementation of atomic_unlock_call_if_contended didn't manage
+ * to unlock it in the contended case.
+ */
+#define atomic_contended_unlock_fixup(v)				\
+do {									\
+	/* the xchg-based unlock doesn't need any fixup */		\
+} while (0)
+
 #endif
Index: linux-2.6/include/asm-i386/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-i386/atomic.h
+++ linux-2.6/include/asm-i386/atomic.h
@@ -294,6 +294,46 @@ do {									\
 		:"memory","cx","dx");					\
 } while (0)
 
+/**
+ * atomic_lock_call_if_contended - lock and call function if already locked
+ * @v: pointer of type atomic_t
+ * @fn: function to call if v was already locked
+ *
+ * Atomically locks @v and calls a function if @v was already locked.
+ * When @v == 1 it is unlocked, <= 0 means locked.
+ */
+#define atomic_lock_call_if_contended(v, fn_name)			\
+	atomic_dec_call_if_negative(v, fn_name)
+
+/**
+ * atomic_unlock_call_if_contended - unlock and call function if contended
+ * @v: pointer of type atomic_t
+ * @fn: function to call if the value was contended
+ *
+ * Atomically unlocks @v and calls a function if @v was contended.
+ * When @v == 1 it is unlocked, 0 it is locked, any negative value means
+ * locked with contention. When @v is contended, it is undefined whether @v
+ * is locked or not (implementation dependent) after this call until the @fn
+ * function uses atomic_contended_unlock_fixup() to apply the necessary
+ * fixup (if any).
+ */
+#define atomic_unlock_call_if_contended(v, fn_name)			\
+	atomic_inc_call_if_nonpositive(v, fn_name)
+
+/**
+ * atomic_contended_unlock_fixup - apply any needed fixup for contended unlock
+ *
+ * @v: pointer of type atomic_t
+ *
+ * This is meant to be called unconditionally from any function passed to
+ * atomic_unlock_call_if_contended. Provides any needed fixup for unlocking
+ * @v if the implementation of atomic_unlock_call_if_contended didn't manage
+ * to unlock it in the contended case.
+ */
+#define atomic_contended_unlock_fixup(v)				\
+do {									\
+	atomic_set(v, 1);						\
+} while (0)
 
 /* These are x86-specific, used by some header files */
 #define atomic_clear_mask(mask, addr) \
Index: linux-2.6/include/asm-x86_64/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-x86_64/atomic.h
+++ linux-2.6/include/asm-x86_64/atomic.h
@@ -259,6 +259,47 @@ do {									\
 		 "r8", "r9", "r10", "r11", "memory");			\
 } while (0)
 
+/**
+ * atomic_lock_call_if_contended - lock and call function if already locked
+ * @v: pointer of type atomic_t
+ * @fn: function to call if v was already locked
+ *
+ * Atomically locks @v and calls a function if @v was already locked.
+ * When @v == 1 it is unlocked, <= 0 means locked.
+ */
+#define atomic_lock_call_if_contended(v, fn_name)			\
+	atomic_dec_call_if_negative(v, fn_name)
+
+/**
+ * atomic_unlock_call_if_contended - unlock and call function if contended
+ * @v: pointer of type atomic_t
+ * @fn: function to call if the value was contended
+ *
+ * Atomically unlocks @v and calls a function if @v was contended.
+ * When @v == 1 it is unlocked, 0 it is locked, any negative value means
+ * locked with contention. When @v is contended, it is undefined whether @v
+ * is locked or not (implementation dependent) after this call until the @fn
+ * function uses atomic_contended_unlock_fixup() to apply the necessary
+ * fixup (if any).
+ */
+#define atomic_unlock_call_if_contended(v, fn_name)			\
+	atomic_inc_call_if_nonpositive(v, fn_name)
+
+/**
+ * atomic_contended_unlock_fixup - apply any needed fixup for contended unlock
+ *
+ * @v: pointer of type atomic_t
+ *
+ * This is meant to be called unconditionally from any function passed to
+ * atomic_unlock_call_if_contended. Provides any needed fixup for unlocking
+ * @v if the implementation of atomic_unlock_call_if_contended didn't manage
+ * to unlock it in the contended case.
+ */
+#define atomic_contended_unlock_fixup(v)				\
+do {									\
+	atomic_set(v, 1);						\
+} while (0)
+
 /* An 64bit atomic type */
 
 typedef struct { volatile long counter; } atomic64_t;
