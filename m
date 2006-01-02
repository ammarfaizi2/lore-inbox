Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750838AbWABQfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbWABQfB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 11:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbWABQet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 11:34:49 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:23252 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750818AbWABQe1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 11:34:27 -0500
Date: Mon, 2 Jan 2006 17:34:06 +0100
From: Ingo Molnar <mingo@elte.hu>, Nicolas Pitre <nico@cam.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>, Al Viro <viro@ftp.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [patch 06/19] mutex subsystem, add include/asm-arm/mutex.h
Message-ID: <20060102163406.GG31501@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.9 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.9 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

add the ARM version of mutex.h, which is optimized in assembly for
ARMv6, and uses the xchg implementation on pre-ARMv6.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 include/asm-arm/mutex.h |  128 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 128 insertions(+)

Index: linux/include/asm-arm/mutex.h
===================================================================
--- /dev/null
+++ linux/include/asm-arm/mutex.h
@@ -0,0 +1,128 @@
+/*
+ * include/asm-arm/mutex.h
+ *
+ * ARM optimized mutex locking primitives
+ *
+ * Please look into asm-generic/mutex-xchg.h for a formal definition.
+ */
+#ifndef _ASM_MUTEX_H
+#define _ASM_MUTEX_H
+
+#if __LINUX_ARM_ARCH__ < 6
+/* On pre-ARMv6 hardware the swp based implementation is the most efficient. */
+# include <asm-generic/mutex-xchg.h>
+#else
+
+/*
+ * Attempting to lock a mutex on ARMv6+ can be done with a bastardized
+ * atomic decrement (it is not a reliable atomic decrement but it satisfies
+ * the defined semantics for our purpose, while being smaller and faster
+ * than a real atomic decrement or atomic swap.  The idea is to attempt
+ * decrementing the lock value only once.  If once decremented it isn't zero,
+ * or if its store-back fails due to a dispute on the exclusive store, we
+ * simply bail out immediately through the slow path where the lock will be
+ * reattempted until it succeeds.
+ */
+#define __mutex_fastpath_lock(count, fail_fn)				\
+do {									\
+	int __ex_flag, __res;						\
+									\
+	typecheck(atomic_t *, count);					\
+	typecheck_fn(fastcall void (*)(atomic_t *), fail_fn);		\
+									\
+	__asm__ (							\
+		"ldrex	%0, [%2]	\n"				\
+		"sub	%0, %0, #1	\n"				\
+		"strex	%1, %0, [%2]	\n"				\
+									\
+		: "=&r" (__res), "=&r" (__ex_flag)			\
+		: "r" (&(count)->counter)				\
+		: "cc","memory" );					\
+									\
+	if (unlikely(__res || __ex_flag))				\
+		fail_fn(count);						\
+} while (0)
+
+#define __mutex_fastpath_lock_retval(count, fail_fn)			\
+({									\
+	int __ex_flag, __res;						\
+									\
+	typecheck(atomic_t *, count);					\
+	typecheck_fn(fastcall int (*)(atomic_t *), fail_fn);		\
+									\
+	__asm__ (							\
+		"ldrex	%0, [%2]	\n"				\
+		"sub	%0, %0, #1	\n"				\
+		"strex	%1, %0, [%2]	\n"				\
+									\
+		: "=&r" (__res), "=&r" (__ex_flag)			\
+		: "r" (&(count)->counter)				\
+		: "cc","memory" );					\
+									\
+	__res |= __ex_flag;						\
+	if (unlikely(__res != 0))					\
+		__res = fail_fn(count);					\
+	__res;								\
+})
+
+/*
+ * Same trick is used for the unlock fast path. However the original value,
+ * rather than the result, is used to test for success in order to have
+ * better generated assembly.
+ */
+#define __mutex_fastpath_unlock(count, fail_fn)				\
+do {									\
+	int __ex_flag, __res, __orig;					\
+									\
+	typecheck(atomic_t *, count);					\
+	typecheck_fn(fastcall void (*)(atomic_t *), fail_fn);		\
+									\
+	__asm__ (							\
+		"ldrex	%0, [%3]	\n"				\
+		"add	%1, %0, #1	\n"				\
+		"strex	%2, %1, [%3]	\n"				\
+									\
+		: "=&r" (__orig), "=&r" (__res), "=&r" (__ex_flag)	\
+		: "r" (&(count)->counter)				\
+		: "cc","memory" );					\
+									\
+	if (unlikely(__orig || __ex_flag))				\
+		fail_fn(count);						\
+} while (0)
+
+/*
+ * If the unlock was done on a contended lock, or if the unlock simply fails
+ * then the mutex remains locked.
+ */
+#define __mutex_slowpath_needs_to_unlock()	1
+
+/*
+ * For __mutex_fastpath_trylock we use another construct which could be
+ * described as a "single value cmpxchg".
+ *
+ * This provides the needed trylock semantics like cmpxchg would, but it is
+ * lighter and less generic than a true cmpxchg implementation.
+ */
+static inline int
+__mutex_fastpath_trylock(atomic_t *count, int (*fail_fn)(atomic_t *))
+{
+	int __ex_flag, __res, __orig;
+
+	__asm__ (
+
+		"1: ldrex	%0, [%3]	\n"
+		"subs		%1, %0, #1	\n"
+		"strexeq	%2, %1, [%3]	\n"
+		"movlt		%0, #0		\n"
+		"cmpeq		%2, #0		\n"
+		"bgt		1b		\n"
+
+		: "=&r" (__orig), "=&r" (__res), "=&r" (__ex_flag)
+		: "r" (&count->counter)
+		: "cc", "memory" );
+
+	return __orig;
+}
+
+#endif
+#endif
