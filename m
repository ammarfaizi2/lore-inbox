Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbWACQu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbWACQu7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 11:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbWACQqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 11:46:43 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:51109 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932422AbWACQqU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 11:46:20 -0500
Date: Tue, 3 Jan 2006 17:46:04 +0100
From: Ingo Molnar <mingo@elte.hu>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>, Al Viro <viro@ftp.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [patch 03/19] mutex subsystem, add asm-generic/mutex-[dec|xchg|null].h implementations
Message-ID: <20060103164604.GD25802@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.0 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.9 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add three (generic) mutex fastpath implementations.

The mutex-xchg.h implementation is atomic_xchg() based, and should
work fine on every architecture.

The mutex-dec.h implementation is atomic_dec_return() based - this
one too should work on every architecture, but might not perform the
most optimally on architectures that have no atomic-dec/inc instructions.

The mutex-null.h implementation forces all calls into the slowpath. This
is used for mutex debugging, but it can also be used on platforms that do
not want (or need) a fastpath at all.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@infradead.org>

----

 include/asm-generic/mutex-dec.h  |  103 ++++++++++++++++++++++++++++++++++++
 include/asm-generic/mutex-null.h |   24 ++++++++
 include/asm-generic/mutex-xchg.h |  111 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 238 insertions(+)

Index: linux/include/asm-generic/mutex-dec.h
===================================================================
--- /dev/null
+++ linux/include/asm-generic/mutex-dec.h
@@ -0,0 +1,103 @@
+/*
+ * asm-generic/mutex-dec.h
+ *
+ * Generic implementation of the mutex fastpath, based on atomic
+ * decrement/increment.
+ */
+#ifndef _ASM_GENERIC_MUTEX_DEC_H
+#define _ASM_GENERIC_MUTEX_DEC_H
+
+/**
+ *  __mutex_fastpath_lock - try to take the lock by moving the count
+ *                          from 1 to a 0 value
+ *  @count: pointer of type atomic_t
+ *  @fail_fn: function to call if the original value was not 1
+ *
+ * Change the count from 1 to a value lower than 1, and call <fail_fn> if
+ * it wasn't 1 originally. This function MUST leave the value lower than
+ * 1 even when the "1" assertion wasn't true.
+ */
+#define __mutex_fastpath_lock(count, fail_fn)				\
+do {									\
+	if (unlikely(atomic_dec_return(count) < 0))			\
+		fail_fn(count);						\
+} while (0)
+
+/**
+ *  __mutex_fastpath_lock_retval - try to take the lock by moving the count
+ *                                 from 1 to a 0 value
+ *  @count: pointer of type atomic_t
+ *  @fail_fn: function to call if the original value was not 1
+ *
+ * Change the count from 1 to a value lower than 1, and call <fail_fn> if
+ * it wasn't 1 originally. This function returns 0 if the fastpath succeeds,
+ * or anything the slow path function returns.
+ */
+static inline int
+__mutex_fastpath_lock_retval(atomic_t *count, int (*fail_fn)(atomic_t *))
+{
+	if (unlikely(atomic_dec_return(count) < 0))
+		return fail_fn(count);
+	else
+		return 0;
+}
+
+/**
+ *  __mutex_fastpath_unlock - try to promote the count from 0 to 1
+ *  @count: pointer of type atomic_t
+ *  @fail_fn: function to call if the original value was not 0
+ *
+ * Try to promote the count from 0 to 1. If it wasn't 0, call <fail_fn>.
+ * In the failure case, this function is allowed to either set the value to
+ * 1, or to set it to a value lower than 1.
+ *
+ * If the implementation sets it to a value of lower than 1, then the
+ * __mutex_slowpath_needs_to_unlock() macro needs to return 1, it needs
+ * to return 0 otherwise.
+ */
+#define __mutex_fastpath_unlock(count, fail_fn)				\
+do {									\
+	if (unlikely(atomic_inc_return(count) <= 0))			\
+		fail_fn(count);						\
+} while (0)
+
+#define __mutex_slowpath_needs_to_unlock()		1
+
+/**
+ * __mutex_fastpath_trylock - try to acquire the mutex, without waiting
+ *
+ *  @count: pointer of type atomic_t
+ *  @fail_fn: fallback function
+ *
+ * Change the count from 1 to a value lower than 1, and return 0 (failure)
+ * if it wasn't 1 originally, or return 1 (success) otherwise. This function
+ * MUST leave the value lower than 1 even when the "1" assertion wasn't true.
+ * Additionally, if the value was < 0 originally, this function must not leave
+ * it to 0 on failure.
+ *
+ * If the architecture has no effective trylock variant, it should call the
+ * <fail_fn> spinlock-based trylock variant unconditionally.
+ */
+static inline int
+__mutex_fastpath_trylock(atomic_t *count, int (*fail_fn)(atomic_t *))
+{
+	/*
+	 * We have two variants here. The cmpxchg based one is the best one
+	 * because it never induce a false contention state.  It is included
+	 * here because architectures using the inc/dec algorithms over the
+	 * xchg ones are much more likely to support cmpxchg natively.
+	 *
+	 * If not we fall back to the spinlock based variant - that is
+	 * just as efficient (and simpler) as a 'destructive' probing of
+	 * the mutex state would be.
+	 */
+#ifdef __HAVE_ARCH_CMPXCHG
+	if (likely(atomic_cmpxchg(count, 1, 0)) == 1)
+		return 1;
+	return 0;
+#else
+	return fail_fn(count);
+#endif
+}
+
+#endif
Index: linux/include/asm-generic/mutex-null.h
===================================================================
--- /dev/null
+++ linux/include/asm-generic/mutex-null.h
@@ -0,0 +1,24 @@
+/*
+ * asm-generic/mutex-null.h
+ *
+ * Generic implementation of the mutex fastpath, based on NOP :-)
+ *
+ * This is used by the mutex-debugging infrastructure, but it can also
+ * be used by architectures that (for whatever reason) want to use the
+ * spinlock based slowpath.
+ */
+#ifndef _ASM_GENERIC_MUTEX_NULL_H
+#define _ASM_GENERIC_MUTEX_NULL_H
+
+/* extra parameter only needed for mutex debugging: */
+#ifndef __IP__
+# define __IP__
+#endif
+
+#define __mutex_fastpath_lock(count, fail_fn)		fail_fn(count __IP__)
+#define __mutex_fastpath_lock_retval(count, fail_fn)	fail_fn(count __IP__)
+#define __mutex_fastpath_unlock(count, fail_fn)		fail_fn(count __IP__)
+#define __mutex_fastpath_trylock(count, fail_fn)	fail_fn(count)
+#define __mutex_slowpath_needs_to_unlock()		1
+
+#endif
Index: linux/include/asm-generic/mutex-xchg.h
===================================================================
--- /dev/null
+++ linux/include/asm-generic/mutex-xchg.h
@@ -0,0 +1,111 @@
+/*
+ * asm-generic/mutex-xchg.h
+ *
+ * Generic implementation of the mutex fastpath, based on xchg().
+ *
+ * NOTE: An xchg based implementation is less optimal than an atomic
+ *       decrement/increment based implementation. If your architecture
+ *       has a reasonable atomic dec/inc then you should probably use
+ *	 asm-generic/mutex-dec.h instead, or you could open-code an
+ *	 optimized version in asm/mutex.h.
+ */
+#ifndef _ASM_GENERIC_MUTEX_XCHG_H
+#define _ASM_GENERIC_MUTEX_XCHG_H
+
+/**
+ *  __mutex_fastpath_lock - try to take the lock by moving the count
+ *                          from 1 to a 0 value
+ *  @count: pointer of type atomic_t
+ *  @fail_fn: function to call if the original value was not 1
+ *
+ * Change the count from 1 to a value lower than 1, and call <fail_fn> if it
+ * wasn't 1 originally. This function MUST leave the value lower than 1
+ * even when the "1" assertion wasn't true.
+ */
+#define __mutex_fastpath_lock(count, fail_fn)				\
+do {									\
+	if (unlikely(atomic_xchg(count, 0) != 1))			\
+		fail_fn(count);						\
+} while (0)
+
+
+/**
+ *  __mutex_fastpath_lock_retval - try to take the lock by moving the count
+ *                                 from 1 to a 0 value
+ *  @count: pointer of type atomic_t
+ *  @fail_fn: function to call if the original value was not 1
+ *
+ * Change the count from 1 to a value lower than 1, and call <fail_fn> if it
+ * wasn't 1 originally. This function returns 0 if the fastpath succeeds,
+ * or anything the slow path function returns
+ */
+static inline int
+__mutex_fastpath_lock_retval(atomic_t *count, int (*fail_fn)(atomic_t *))
+{
+	if (unlikely(atomic_xchg(count, 0) != 1))
+		return fail_fn(count);
+	else
+		return 0;
+}
+
+/**
+ *  __mutex_fastpath_unlock - try to promote the mutex from 0 to 1
+ *  @count: pointer of type atomic_t
+ *  @fail_fn: function to call if the original value was not 0
+ *
+ * try to promote the mutex from 0 to 1. if it wasn't 0, call <function>
+ * In the failure case, this function is allowed to either set the value to
+ * 1, or to set it to a value lower than one.
+ * If the implementation sets it to a value of lower than one, the
+ * __mutex_slowpath_needs_to_unlock() macro needs to return 1, it needs
+ * to return 0 otherwise.
+ */
+#define __mutex_fastpath_unlock(count, fail_fn)				\
+do {									\
+	if (unlikely(atomic_xchg(count, 1) != 0))			\
+		fail_fn(count);						\
+} while (0)
+
+#define __mutex_slowpath_needs_to_unlock()		0
+
+/**
+ * __mutex_fastpath_trylock - try to acquire the mutex, without waiting
+ *
+ *  @count: pointer of type atomic_t
+ *  @fail_fn: spinlock based trylock implementation
+ *
+ * Change the count from 1 to a value lower than 1, and return 0 (failure)
+ * if it wasn't 1 originally, or return 1 (success) otherwise. This function
+ * MUST leave the value lower than 1 even when the "1" assertion wasn't true.
+ * Additionally, if the value was < 0 originally, this function must not leave
+ * it to 0 on failure.
+ *
+ * If the architecture has no effective trylock variant, it should call the
+ * <fail_fn> spinlock-based trylock variant unconditionally.
+ */
+static inline int
+__mutex_fastpath_trylock(atomic_t *count, int (*fail_fn)(atomic_t *))
+{
+	int prev = atomic_xchg(count, 0);
+
+	if (unlikely(prev < 0)) {
+		/*
+		 * The lock was marked contended so we must restore that
+		 * state. If while doing so we get back a prev value of 1
+		 * then we just own it.
+		 *
+		 * [ In the rare case of the mutex going to 1, to 0, to -1
+		 *   and then back to 0 in this few-instructions window,
+		 *   this has the potential to trigger the slowpath for the
+		 *   owner's unlock path needlessly, but that's not a problem
+		 *   in practice. ]
+		 */
+		prev = atomic_xchg(count, prev);
+		if (prev < 0)
+			prev = 0;
+	}
+
+	return prev;
+}
+
+#endif
