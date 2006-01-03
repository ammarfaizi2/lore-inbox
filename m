Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbWACQvB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbWACQvB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 11:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbWACQqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 11:46:38 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:59016 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932428AbWACQqW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 11:46:22 -0500
Date: Tue, 3 Jan 2006 17:46:10 +0100
From: Ingo Molnar <mingo@elte.hu>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>, Al Viro <viro@ftp.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [patch 04/19] mutex subsystem, add include/asm-i386/mutex.h
Message-ID: <20060103164610.GE25802@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arjan van de Ven <arjan@infradead.org>

add the i386 version of mutex.h, optimized in assembly.

Signed-off-by: Arjan van de Ven <arjan@infradead.org>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 include/asm-i386/mutex.h |  136 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 136 insertions(+)

Index: linux/include/asm-i386/mutex.h
===================================================================
--- /dev/null
+++ linux/include/asm-i386/mutex.h
@@ -0,0 +1,136 @@
+/*
+ * Assembly implementation of the mutex fastpath, based on atomic
+ * decrement/increment.
+ *
+ * started by Ingo Molnar:
+ *
+ *  Copyright (C) 2004, 2005 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
+ */
+#ifndef _ASM_MUTEX_H
+#define _ASM_MUTEX_H
+
+/**
+ *  __mutex_fastpath_lock - try to take the lock by moving the count
+ *                          from 1 to a 0 value
+ *  @count: pointer of type atomic_t
+ *  @fn: function to call if the original value was not 1
+ *
+ * Change the count from 1 to a value lower than 1, and call <fn> if it
+ * wasn't 1 originally. This function MUST leave the value lower than 1
+ * even when the "1" assertion wasn't true.
+ */
+#define __mutex_fastpath_lock(count, fail_fn)				\
+do {									\
+	unsigned int dummy;						\
+									\
+	typecheck(atomic_t *, count);					\
+	typecheck_fn(fastcall void (*)(atomic_t *), fail_fn);		\
+									\
+	__asm__ __volatile__(						\
+		LOCK	"   decl (%%eax)	\n"			\
+			"   js 2f		\n"			\
+			"1:			\n"			\
+									\
+		LOCK_SECTION_START("")					\
+			"2: call "#fail_fn"	\n"			\
+			"   jmp 1b		\n"			\
+		LOCK_SECTION_END					\
+									\
+		:"=a" (dummy)						\
+		: "a" (count)						\
+		: "memory", "ecx", "edx");				\
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
+__mutex_fastpath_lock_retval(atomic_t *count,
+			     int fastcall (*fail_fn)(atomic_t *))
+{
+	if (unlikely(atomic_dec_return(count) < 0))
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
+ * try to promote the mutex from 0 to 1. if it wasn't 0, call <fail_fn>.
+ * In the failure case, this function is allowed to either set the value
+ * to 1, or to set it to a value lower than 1.
+ *
+ * If the implementation sets it to a value of lower than 1, the
+ * __mutex_slowpath_needs_to_unlock() macro needs to return 1, it needs
+ * to return 0 otherwise.
+ */
+#define __mutex_fastpath_unlock(count, fail_fn)				\
+do {									\
+	unsigned int dummy;						\
+									\
+	typecheck(atomic_t *, count);					\
+	typecheck_fn(fastcall void (*)(atomic_t *), fail_fn);		\
+									\
+	__asm__ __volatile__(						\
+		LOCK	"   incl (%%eax)	\n"			\
+			"   jle 2f		\n"			\
+			"1:			\n"			\
+									\
+		LOCK_SECTION_START("")					\
+			"2: call "#fail_fn"	\n"			\
+			"   jmp 1b		\n"			\
+		LOCK_SECTION_END					\
+									\
+		:"=a" (dummy)						\
+		: "a" (count)						\
+		: "memory", "ecx", "edx");				\
+} while (0)
+
+#define __mutex_slowpath_needs_to_unlock()	1
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
