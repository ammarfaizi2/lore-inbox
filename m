Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965075AbVLVGwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965075AbVLVGwA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 01:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965084AbVLVGwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 01:52:00 -0500
Received: from relais.videotron.ca ([24.201.245.36]:30669 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S965075AbVLVGv7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 01:51:59 -0500
Date: Thu, 22 Dec 2005 01:51:57 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: [patch 2/5] mutex subsystem: add architecture specific mutex primitives
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
Message-id: <Pine.LNX.4.64.0512220121440.26663@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20051221155411.GA7243@elte.hu>
 <Pine.LNX.4.64.0512211735030.26663@localhost.localdomain>
 <20051221231218.GA6747@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While atomic_dec_call_if_negative() and atomic_inc_call_if_nonpositive()
are certainly really nice and probably a good starting point for some
consolidation of the different semaphore implementations, they still
have stricter semantics than necessary for mutex usage.

This patch adds 2 new helpers that allows for greater flexibility in
their implementation while preserving the mutex semantics:

  arch_mutex_fast_lock()
  arch_mutex_fast_unlock()

In particular, they can be implemented in terms of a single atomic swap
which most architectures can do natively without any locking. With this
the mutex optimizations only have to be done in those atomic helpers
while everything else may be generic common code.

On i386 and x86_64 those new helpers are simply defined in terms of the 
existing atomic_dec_call_if_negative() and 
atomic_inc_call_if_nonpositive() since they already provide the best 
implementation that can be done.

A new include/asm/mutex.h file is created for all architectures and they 
all default to including asm-generic/mutex.h for now, except for i386 
and x86_64 which have their own definitions.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

Index: linux-2.6/include/asm-alpha/mutex.h
===================================================================
--- /dev/null
+++ linux-2.6/include/asm-alpha/mutex.h
@@ -0,0 +1 @@
+#include <asm-generic/mutex.h>
Index: linux-2.6/include/asm-arm/mutex.h
===================================================================
--- /dev/null
+++ linux-2.6/include/asm-arm/mutex.h
@@ -0,0 +1 @@
+#include <asm-generic/mutex.h>
Index: linux-2.6/include/asm-arm26/mutex.h
===================================================================
--- /dev/null
+++ linux-2.6/include/asm-arm26/mutex.h
@@ -0,0 +1 @@
+#include <asm-generic/mutex.h>
Index: linux-2.6/include/asm-cris/mutex.h
===================================================================
--- /dev/null
+++ linux-2.6/include/asm-cris/mutex.h
@@ -0,0 +1 @@
+#include <asm-generic/mutex.h>
Index: linux-2.6/include/asm-frv/mutex.h
===================================================================
--- /dev/null
+++ linux-2.6/include/asm-frv/mutex.h
@@ -0,0 +1 @@
+#include <asm-generic/mutex.h>
Index: linux-2.6/include/asm-generic/mutex.h
===================================================================
--- /dev/null
+++ linux-2.6/include/asm-generic/mutex.h
@@ -0,0 +1,62 @@
+/*
+ * asm-generic/mutex.h
+ *
+ * Generic wrappers for architecture specific low-level mutex
+ * fast path locking and unlocking.  Each architecture is welcome
+ * to provide optimized versions for those.
+ */
+
+#ifndef _ASM_GENERIC_MUTEX_H
+#define _ASM_GENERIC_MUTEX_H
+
+#include <asm/atomic.h>
+
+/**
+ * arch_mutex_fast_lock - lock mutex and call function if already locked
+ * @v: pointer of type atomic_t
+ * @contention_fn: function to call if v was already locked
+ *
+ * Atomically locks @v and calls a function if @v was already locked.
+ * When @v == 1 it is unlocked, <= 0 means locked.
+ */
+#define arch_mutex_fast_lock(v, contention_fn)				\
+do {									\
+	if (atomic_xchg(v, 0) != 1)					\
+		contention_fn(v);					\
+} while (0)
+
+/**
+ * arch_mutex_fast_unlock - unlock and call function if contended
+ * @v: pointer of type atomic_t
+ * @contention_fn: function to call if v was contended
+ *
+ * Atomically unlocks @v and calls a function if @v was contended.
+ * When @v == 1 it is unlocked, 0 it is locked, any negative value means
+ * locked with contention.
+ *
+ * If @v was contended, its value becomes undefined until the @contention_fn
+ * calls arch_mutex_unlock_fixup() to apply the necessary fix-up (if any,
+ * depending on the implementation) before the state of @v is defined again.
+ */
+#define arch_mutex_fast_unlock(v, contention_fn)			\
+do {									\
+	if (atomic_xchg(v, 1) != 0)					\
+		contention_fn(v);					\
+} while (0)
+
+/**
+ * arch_mutex_unlock_fixup - apply any needed fixup after contended unlock
+ *
+ * @v: pointer of type atomic_t
+ *
+ * This is meant to be called from any contention function passed to
+ * arch_mutex_fast_unlock(). It provides any required fixup for unlocking
+ * @v if the implementation of arch_mutex_fast_unlock() didn't manage to
+ * unlock it in the contended case.
+ */
+#define arch_mutex_unlock_fixup(v)					\
+do {									\
+	/* the xchg-based unlock doesn't need any fixup */		\
+} while (0)
+
+#endif
Index: linux-2.6/include/asm-h8300/mutex.h
===================================================================
--- /dev/null
+++ linux-2.6/include/asm-h8300/mutex.h
@@ -0,0 +1 @@
+#include <asm-generic/mutex.h>
Index: linux-2.6/include/asm-i386/mutex.h
===================================================================
--- /dev/null
+++ linux-2.6/include/asm-i386/mutex.h
@@ -0,0 +1,23 @@
+/*
+ * asm-i386/mutex.h
+ *
+ * Optimized i386 low-level mutex fast path locking and unlocking.
+ */
+
+#ifndef _ASM_MUTEX_H
+#define _ASM_MUTEX_H
+
+#include <asm/atomic.h>
+
+/* Please look into asm-generic/mutex.h for a description of those */
+
+#define arch_mutex_fast_lock(v, contention_fn)				\
+	atomic_dec_call_if_negative(v, contention_fn)
+
+#define arch_mutex_fast_unlock(v, contention_fn)			\
+	atomic_inc_call_if_nonpositive(v, contention_fn)
+
+#define arch_mutex_unlock_fixup(v)					\
+	atomic_set(v, 1)
+
+#endif
Index: linux-2.6/include/asm-ia64/mutex.h
===================================================================
--- /dev/null
+++ linux-2.6/include/asm-ia64/mutex.h
@@ -0,0 +1 @@
+#include <asm-generic/mutex.h>
Index: linux-2.6/include/asm-m32r/mutex.h
===================================================================
--- /dev/null
+++ linux-2.6/include/asm-m32r/mutex.h
@@ -0,0 +1 @@
+#include <asm-generic/mutex.h>
Index: linux-2.6/include/asm-m68k/mutex.h
===================================================================
--- /dev/null
+++ linux-2.6/include/asm-m68k/mutex.h
@@ -0,0 +1 @@
+#include <asm-generic/mutex.h>
Index: linux-2.6/include/asm-m68knommu/mutex.h
===================================================================
--- /dev/null
+++ linux-2.6/include/asm-m68knommu/mutex.h
@@ -0,0 +1 @@
+#include <asm-generic/mutex.h>
Index: linux-2.6/include/asm-mips/mutex.h
===================================================================
--- /dev/null
+++ linux-2.6/include/asm-mips/mutex.h
@@ -0,0 +1 @@
+#include <asm-generic/mutex.h>
Index: linux-2.6/include/asm-parisc/mutex.h
===================================================================
--- /dev/null
+++ linux-2.6/include/asm-parisc/mutex.h
@@ -0,0 +1 @@
+#include <asm-generic/mutex.h>
Index: linux-2.6/include/asm-powerpc/mutex.h
===================================================================
--- /dev/null
+++ linux-2.6/include/asm-powerpc/mutex.h
@@ -0,0 +1 @@
+#include <asm-generic/mutex.h>
Index: linux-2.6/include/asm-ppc/mutex.h
===================================================================
--- /dev/null
+++ linux-2.6/include/asm-ppc/mutex.h
@@ -0,0 +1 @@
+#include <asm-generic/mutex.h>
Index: linux-2.6/include/asm-ppc64/mutex.h
===================================================================
--- /dev/null
+++ linux-2.6/include/asm-ppc64/mutex.h
@@ -0,0 +1 @@
+#include <asm-generic/mutex.h>
Index: linux-2.6/include/asm-s390/mutex.h
===================================================================
--- /dev/null
+++ linux-2.6/include/asm-s390/mutex.h
@@ -0,0 +1 @@
+#include <asm-generic/mutex.h>
Index: linux-2.6/include/asm-sh/mutex.h
===================================================================
--- /dev/null
+++ linux-2.6/include/asm-sh/mutex.h
@@ -0,0 +1 @@
+#include <asm-generic/mutex.h>
Index: linux-2.6/include/asm-sh64/mutex.h
===================================================================
--- /dev/null
+++ linux-2.6/include/asm-sh64/mutex.h
@@ -0,0 +1 @@
+#include <asm-generic/mutex.h>
Index: linux-2.6/include/asm-sparc/mutex.h
===================================================================
--- /dev/null
+++ linux-2.6/include/asm-sparc/mutex.h
@@ -0,0 +1 @@
+#include <asm-generic/mutex.h>
Index: linux-2.6/include/asm-sparc64/mutex.h
===================================================================
--- /dev/null
+++ linux-2.6/include/asm-sparc64/mutex.h
@@ -0,0 +1 @@
+#include <asm-generic/mutex.h>
Index: linux-2.6/include/asm-um/mutex.h
===================================================================
--- /dev/null
+++ linux-2.6/include/asm-um/mutex.h
@@ -0,0 +1 @@
+#include <asm-generic/mutex.h>
Index: linux-2.6/include/asm-v850/mutex.h
===================================================================
--- /dev/null
+++ linux-2.6/include/asm-v850/mutex.h
@@ -0,0 +1 @@
+#include <asm-generic/mutex.h>
Index: linux-2.6/include/asm-x86_64/mutex.h
===================================================================
--- /dev/null
+++ linux-2.6/include/asm-x86_64/mutex.h
@@ -0,0 +1,23 @@
+/*
+ * asm-x86_64/mutex.h
+ *
+ * Optimized x86_64 low-level mutex fast path locking and unlocking.
+ */
+
+#ifndef _ASM_MUTEX_H
+#define _ASM_MUTEX_H
+
+#include <asm/atomic.h>
+
+/* Please look into asm-generic/mutex.h for a description of those */
+
+#define arch_mutex_fast_lock(v, contention_fn)				\
+	atomic_dec_call_if_negative(v, contention_fn)
+
+#define arch_mutex_fast_unlock(v, contention_fn)			\
+	atomic_inc_call_if_nonpositive(v, contention_fn)
+
+#define arch_mutex_unlock_fixup(v)					\
+	atomic_set(v, 1)
+
+#endif
Index: linux-2.6/include/asm-xtensa/mutex.h
===================================================================
--- /dev/null
+++ linux-2.6/include/asm-xtensa/mutex.h
@@ -0,0 +1 @@
+#include <asm-generic/mutex.h>
