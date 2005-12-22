Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030292AbVLVVhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030292AbVLVVhs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 16:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbVLVVhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 16:37:47 -0500
Received: from relais.videotron.ca ([24.201.245.36]:60926 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1030292AbVLVVhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 16:37:46 -0500
Date: Thu, 22 Dec 2005 16:37:44 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: [patch 1/2] mutex subsystem: basic per arch fast path primitives
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
Message-id: <Pine.LNX.4.64.0512221630430.26663@localhost.localdomain>
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

On Thu, 22 Dec 2005, Nicolas Pitre wrote:

> On Thu, 22 Dec 2005, Ingo Molnar wrote:
> 
> > what i _DONT_ want is some over-opaque per-arch thing that will again 
> > escallate into the same situation as semaphores: 23 different 
> > implementations nobody is able to change at once, nobody is able to add 
> > features or debugging to, and by today there's probably is no single 
> > person on this planet who knows all 23 of them to begin with.
> 
> I agree completely with you.  But what I don't want is core code 
> needlessly restricting architecture specific implementation for short 
> and well defined fast paths.  Maybe that's where we must agree upon: a 
> well defined fast path helper for mutexes?

OK, let's look at actual code please.  Do you have anything against this 
and the following patches?

This patch adds fast path mutex primitives for all architectures.  It 
replaces your atomic_*_call_if_* patches that didn't seem to please 
everybody, mutex usage notwithstanding.

Comments?

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
@@ -0,0 +1,77 @@
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
+ * __mutex_fastpath_lock - lock mutex and call function if already locked
+ * @v: pointer of type atomic_t
+ * @contention_fn: function to call if v was already locked
+ *
+ * Atomically locks @v and calls a function if @v was already locked.
+ * When @v == 1 it is unlocked, <= 0 means locked.
+ */
+#define __mutex_fastpath_lock(v, contention_fn)				\
+do {									\
+	if (atomic_xchg(v, 0) != 1)					\
+		contention_fn(v);					\
+} while (0)
+
+/**
+ * __mutex_fastpath_lock_retval - lock mutex and call function if already locked
+ * @v: pointer of type atomic_t
+ * @contention_fn: function to call if v was already locked
+ *
+ * Atomically locks @v and calls a function if @v was already locked.
+ * When @v == 1 it is unlocked, <= 0 means locked.
+ *
+ * It also returns 0 if the lock was successful (@v wasn't locked), otherwise
+ * it returns what @contention_fn returned.
+ */
+#define __mutex_fastpath_lock_retval(v, contention_fn)				\
+({									\
+	int __retval = 0;						\
+	if (atomic_xchg(v, 0) != 1)					\
+		__retval = contention_fn(v);				\
+	__retval;							\
+})
+
+/**
+ * __mutex_fastpath_unlock - unlock and call function if contended
+ * @v: pointer of type atomic_t
+ * @contention_fn: function to call if v was contended
+ *
+ * Atomically unlocks @v and calls a function if @v was contended.
+ * When @v == 1 it is unlocked, 0 it is locked, any negative value means
+ * locked with contention.
+ *
+ * If @v was contended, its new value is implementation defined (it can be
+ * either locked or unlocked).  The contention function (slow path) should
+ * use __mutex_slowpath_needs_unlock() to determine if the mutex needs
+ * manual unlocking.
+ */
+#define __mutex_fastpath_unlock(v, contention_fn)			\
+do {									\
+	if (atomic_xchg(v, 1) != 0)					\
+		contention_fn(v);					\
+} while (0)
+
+/**
+ * __mutex_slowpath_needs_unlock - tell the state of a contended unlock
+ *
+ * This is meant to be called from any contention function passed to
+ * __mutex_fastpath_unlock(). It tells the contention (slow path) function
+ * whether or not it has to unlock the mutex manually after unlocking a
+ * contended lock was attempted.
+ */
+#define __mutex_slowpath_needs_unlock()	(0) /* xchg always unlocks */
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
@@ -0,0 +1,70 @@
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
+/*
+ * Please look into asm-generic/mutex.h for a description of semantics
+ * expected for those.
+ */
+
+#define __mutex_fastpath_lock(v, contention_fn)				\
+do {									\
+	fastcall void (*__tmp)(atomic_t *) = contention_fn;		\
+	unsigned int dummy;						\
+									\
+	(void)__tmp;							\
+	typecheck(atomic_t *, v);					\
+									\
+	__asm__ __volatile__(						\
+		LOCK "decl (%%eax)\n"  					\
+		"js 2f\n"						\
+		"1:\n"							\
+		LOCK_SECTION_START("")					\
+		"2: call "#contention_fn"\n\t"				\
+		"jmp 1b\n"						\
+		LOCK_SECTION_END					\
+		:"=a"(dummy)						\
+		:"a" (v)						\
+		:"memory", "ecx", "edx");				\
+} while (0)
+
+#define __mutex_fastpath_lock_retval(v, contention_fn)			\
+({									\
+	int __retval = 0;						\
+	if (unlikely(atomic_dec_return(v) < 0))				\
+		__retval = contention_fn(v);				\
+	__retval;							\
+})
+
+#define __mutex_fastpath_unlock(v, contention_fn)			\
+do {									\
+	fastcall void (*__tmp)(atomic_t *) = contention_fn;		\
+	unsigned int dummy;						\
+									\
+	(void)__tmp;							\
+	typecheck(atomic_t *, v);					\
+									\
+	__asm__ __volatile__(						\
+		LOCK "incl (%%eax)\n"  					\
+		"jle 2f\n"						\
+		"1:\n"							\
+		LOCK_SECTION_START("")					\
+		"2: call "#contention_fn"\n\t"				\
+		"jmp 1b\n"						\
+		LOCK_SECTION_END					\
+		:"=a" (dummy)						\
+		:"a" (v)						\
+		:"memory", "ecx", "edx");				\
+} while (0)
+
+/* In the contended case, the unlock doesn't actually unlock */
+#define __mutex_slowpath_needs_unlock()	(1)
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
@@ -0,0 +1,72 @@
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
+/*
+ * Please look into asm-generic/mutex.h for a description of semantics
+ * expected for those.
+ */
+
+#define __mutex_fastpath_lock(v, contention_fn)				\
+do {									\
+	fastcall void (*__tmp)(atomic_t *) = contention_fn;		\
+	unsigned long dummy;						\
+									\
+	(void)__tmp;							\
+	typecheck(atomic_t *, v);					\
+									\
+	__asm__ __volatile__(						\
+		LOCK "decl (%%rdi)\n"  					\
+		"js 2f\n"						\
+		"1:\n"							\
+		LOCK_SECTION_START("")					\
+		"2: call "#contention_fn"\n\t"				\
+		"jmp 1b\n"						\
+		LOCK_SECTION_END					\
+		:"=D" (dummy)						\
+		:"D" (v)						\
+		:"rax", "rsi", "rdx", "rcx",				\
+		 "r8", "r9", "r10", "r11", "memory");			\
+} while (0)
+
+#define __mutex_fastpath_lock_retval(v, contention_fn)			\
+({									\
+	int __retval = 0;						\
+	if (unlikely(atomic_dec_return(v) < 0))				\
+		__retval = contention_fn(v);				\
+	__retval;							\
+})
+
+#define __mutex_fastpath_unlock(v, contention_fn)			\
+do {									\
+	fastcall void (*__tmp)(atomic_t *) = contention_fn;		\
+	unsigned long dummy;						\
+									\
+	(void)__tmp;							\
+	typecheck(atomic_t *, v);					\
+									\
+	__asm__ __volatile__(						\
+		LOCK "incl (%%rdi)\n"  					\
+		"jle 2f\n"						\
+		"1:\n"							\
+		LOCK_SECTION_START("")					\
+		"2: call "#contention_fn"\n\t"				\
+		"jmp 1b\n"						\
+		LOCK_SECTION_END					\
+		:"=D" (dummy)						\
+		:"D" (v)						\
+		:"rax", "rsi", "rdx", "rcx",				\
+		 "r8", "r9", "r10", "r11", "memory");			\
+} while (0)
+
+/* In the contended case, the unlock doesn't actually unlock */
+#define __mutex_slowpath_needs_unlock()	(1)
+
+#endif
Index: linux-2.6/include/asm-xtensa/mutex.h
===================================================================
--- /dev/null
+++ linux-2.6/include/asm-xtensa/mutex.h
@@ -0,0 +1 @@
+#include <asm-generic/mutex.h>
