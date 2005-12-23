Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030574AbVLWQVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030574AbVLWQVV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 11:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932499AbVLWQSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 11:18:30 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:49570 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932504AbVLWQSG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 11:18:06 -0500
Date: Fri, 23 Dec 2005 17:17:29 +0100
From: Ingo Molnar <mingo@elte.hu>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [patch 05/11] mutex subsystem, add include/asm-arm/mutex.h
Message-ID: <20051223161729.GF26830@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

add the ARM version of mutex.h, which is optimized in assembly for
ARMv6, and uses the xchg implementation on pre-ARMv6.

From: Nicolas Pitre <nico@cam.org>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 include/asm-arm/mutex.h |  102 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 102 insertions(+)

Index: linux/include/asm-arm/mutex.h
===================================================================
--- /dev/null
+++ linux/include/asm-arm/mutex.h
@@ -0,0 +1,102 @@
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
+	/* type-check the function too: */				\
+	void fastcall (*__tmp)(atomic_t *) = fail_fn;			\
+	int __ex_flag, __res;						\
+									\
+	(void)__tmp;							\
+	typecheck(atomic_t *, count);					\
+									\
+	__asm__ (							\
+	"ldrex	%0, [%2]\n\t"						\
+	"sub	%0, %0, #1\n\t"						\
+	"strex	%1, %0, [%2]"						\
+	: "=&r" (__res), "=&r" (__ex_flag)				\
+	: "r" (&(count)->counter)					\
+	: "cc","memory" );						\
+	__res |= __ex_flag;						\
+	if (unlikely(__res != 0))					\
+		fail_fn(count);						\
+} while (0)
+
+#define __mutex_fastpath_lock_retval(count, fail_fn)			\
+({									\
+	/* type-check the function too: */				\
+	int fastcall (*__tmp)(atomic_t *) = fail_fn;			\
+	int __ex_flag, __res;						\
+									\
+	(void)__tmp;							\
+	typecheck(atomic_t *, count);					\
+									\
+	__asm__ (							\
+	"ldrex	%0, [%2]\n\t"						\
+	"sub	%0, %0, #1\n\t"						\
+	"strex	%1, %0, [%2]"						\
+	: "=&r" (__res), "=&r" (__ex_flag)				\
+	: "r" (&(count)->counter)					\
+	: "cc","memory" );						\
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
+	/* type-check the function too: */				\
+	void fastcall (*__tmp)(atomic_t *) = fail_fn;			\
+	int __ex_flag, __res, __orig;					\
+									\
+	(void)__tmp;							\
+	typecheck(atomic_t *, count);					\
+									\
+	__asm__ (							\
+	"ldrex	%0, [%3]\n\t"						\
+	"add	%1, %0, #1\n\t"						\
+	"strex	%2, %1, [%3]"						\
+	: "=&r" (__orig), "=&r" (__res), "=&r" (__ex_flag)		\
+	: "r" (&(count)->counter)					\
+	: "cc","memory" );						\
+	__orig |= __ex_flag;						\
+	if (unlikely(__orig != 0))					\
+		fail_fn(count);						\
+} while (0)
+
+/*
+ * If the unlock was done on a contended lock, or if the unlock simply fails
+ * then the mutex remains locked.
+ */
+#define __mutex_slowpath_needs_to_unlock()	1
+
+#endif
+#endif
