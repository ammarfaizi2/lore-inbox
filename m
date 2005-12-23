Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030436AbVLWFEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030436AbVLWFEu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 00:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030437AbVLWFEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 00:04:50 -0500
Received: from relais.videotron.ca ([24.201.245.36]:3127 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1030436AbVLWFEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 00:04:49 -0500
Date: Fri, 23 Dec 2005 00:04:49 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 0/8] mutex subsystem, -V6
In-reply-to: <Pine.LNX.4.64.0512221846470.26663@localhost.localdomain>
X-X-Sender: nico@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Message-id: <Pine.LNX.4.64.0512222359360.26663@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20051222230438.GA13302@elte.hu>
 <Pine.LNX.4.64.0512221846470.26663@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Dec 2005, Nicolas Pitre wrote:

> > Nico, Christoph, does this approach work for you? Nico, you might want 
> > to try an ARM-specific mutex.h implementation.
> 
> Yes, I'm happy.  And the ARM version will be sent your way soon.

Here it is:

Index: linux-2.6/include/asm-arm/mutex.h
===================================================================
--- linux-2.6.orig/include/asm-arm/mutex.h
+++ linux-2.6/include/asm-arm/mutex.h
@@ -1,8 +1,83 @@
 /*
- * Pull in the generic wrappers for __mutex_fastpath_lock() and
- * __mutex_fastpath_unlock().
+ * include/asm-arm/mutex.h
  *
- * TODO: implement optimized primitives instead
+ * ARM optimized mutex locking primitives
+ *
+ * Please look into asm-generic/mutex-xchg.h for a formal definition.
+ */
+
+#if __LINUX_ARM_ARCH__ >= 6
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
+#define __mutex_fastpath_lock(v, fail)					\
+do {									\
+	int __ex_flag, __res;						\
+	__asm__ (							\
+	"ldrex	%0, [%2]\n\t"						\
+	"sub	%0, %0, #1\n\t"						\
+	"strex	%1, %0, [%2]"						\
+	: "=&r" (__res), "=&r" (__ex_flag)				\
+	: "r" (&(v)->counter)						\
+	: "cc","memory" );						\
+	__res |= __ex_flag;						\
+	if (unlikely(__res != 0))					\
+		fail(v);						\
+} while (0)
+
+#define __mutex_fastpath_lock_retval(v, fail)				\
+({									\
+	int __ex_flag, __res;						\
+	__asm__ (							\
+	"ldrex	%0, [%2]\n\t"						\
+	"sub	%0, %0, #1\n\t"						\
+	"strex	%1, %0, [%2]"						\
+	: "=&r" (__res), "=&r" (__ex_flag)				\
+	: "r" (&(v)->counter)						\
+	: "cc","memory" );						\
+	__res |= __ex_flag;						\
+	if (unlikely(__res != 0))					\
+		__res = fail(v);					\
+	__res;								\
+})
+
+/*
+ * Same trick is used for the unlock fast path. However the original value,
+ * rather than the result, is used to test for success in order to have
+ * better generated assembly.
  */
+#define __mutex_fastpath_unlock(v, fail)				\
+do {									\
+	int __ex_flag, __res, __orig;					\
+	__asm__ (							\
+	"ldrex	%0, [%3]\n\t"						\
+	"add	%1, %0, #1\n\t"						\
+	"strex	%2, %1, [%3]"						\
+	: "=&r" (__orig), "=&r" (__res), "=&r" (__ex_flag)		\
+	: "r" (&(v)->counter)						\
+	: "cc","memory" );						\
+	__orig |= __ex_flag;						\
+	if (unlikely(__orig != 0))					\
+		fail(v);						\
+} while (0)
 
+/*
+ * If the unlock was done on a contended lock, or if the unlock simply fails
+ * then the mutex remains locked.
+ */
+#define __mutex_slowpath_needs_to_unlock()	(1)
+
+#else
+
+/* On pre-ARMv6 hardware the swp based implementation is the most efficient. */
 #include <asm-generic/mutex-xchg.h>
+
+#endif
