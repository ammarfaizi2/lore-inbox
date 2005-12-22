Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030338AbVLVWEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030338AbVLVWEp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 17:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030341AbVLVWEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 17:04:45 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:48800 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030338AbVLVWEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 17:04:43 -0500
Subject: Re: [patch 00/10] mutex subsystem, -V5
From: Arjan van de Ven <arjan@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Nicolas Pitre <nico@cam.org>, Ingo Molnar <mingo@elte.hu>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.64.0512220941320.4827@g5.osdl.org>
References: <20051222153717.GA6090@elte.hu>
	 <Pine.LNX.4.64.0512221134150.26663@localhost.localdomain>
	 <Pine.LNX.4.64.0512220941320.4827@g5.osdl.org>
Content-Type: text/plain
Date: Thu, 22 Dec 2005 23:04:22 +0100
Message-Id: <1135289062.6454.3.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-22 at 09:44 -0800, Linus Torvalds wrote:
> 
> On Thu, 22 Dec 2005, Nicolas Pitre wrote:
> 
> > On Thu, 22 Dec 2005, Ingo Molnar wrote:
> > 
> > > Changes since -V4:
> > > 
> > > - removed __ARCH_WANT_XCHG_BASED_ATOMICS and implemented
> > >   CONFIG_MUTEX_XCHG_ALGORITHM instead, based on comments from
> > >   Christoph Hellwig.
> > > 
> > > - updated ARM to use CONFIG_MUTEX_XCHG_ALGORITHM.
> > 
> > This is still not what I'd like to see, per my previous comments.
> > 
> > Do you have any strong reason for pursuing that route instead of going 
> > with my suggested approach?
> 
> I'd just prefer a 
> 
> 	<asm-generic/mutex-xchg-algo.h>


something like this?

(this one is incremental to the patch series; a full one against -rc6 is
at http://www.fenrus.org/mutex.patch )

diff -purN linux-2.6.15-rc6-mx/arch/arm/Kconfig linux-2.6.15-rc6-mx-new/arch/arm/Kconfig
--- linux-2.6.15-rc6-mx/arch/arm/Kconfig	2005-12-22 21:55:11.000000000 +0100
+++ linux-2.6.15-rc6-mx-new/arch/arm/Kconfig	2005-12-22 19:54:31.000000000 +0100
@@ -50,10 +50,6 @@ config UID16
 	bool
 	default y
 
-config MUTEX_XCHG_ALGORITHM
-	bool
-	default y
-
 config RWSEM_GENERIC_SPINLOCK
 	bool
 	default y
diff -purN linux-2.6.15-rc6-mx/include/asm-alpha/atomic.h linux-2.6.15-rc6-mx-new/include/asm-alpha/atomic.h
--- linux-2.6.15-rc6-mx/include/asm-alpha/atomic.h	2005-12-22 21:54:47.000000000 +0100
+++ linux-2.6.15-rc6-mx-new/include/asm-alpha/atomic.h	2005-12-22 22:38:56.000000000 +0100
@@ -178,17 +178,6 @@ static __inline__ long atomic64_sub_retu
 #define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
-/*
- * Pull in the generic wrappers for atomic_dec_call_if_negative() and
- * atomic_inc_call_if_nonpositive().
- *
- * TODO: implement optimized primitives instead, or leave the generic
- * implementation in place, or enable CONFIG_MUTEX_XCHG_ALGORITHM
- * to tell the generic mutex code to use the atomic_xchg() based
- * fastpath implementation.
- */
-#include <asm-generic/atomic-call-if.h>
-
 #define atomic_add_unless(v, a, u)				\
 ({								\
 	int c, old;						\
diff -purN linux-2.6.15-rc6-mx/include/asm-alpha/mutex.h linux-2.6.15-rc6-mx-new/include/asm-alpha/mutex.h
--- linux-2.6.15-rc6-mx/include/asm-alpha/mutex.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.15-rc6-mx-new/include/asm-alpha/mutex.h	2005-12-22 22:38:56.000000000 +0100
@@ -0,0 +1,10 @@
+/*
+ * Pull in the generic wrappers for __mutex_fastpath_lock() and
+ * __mutex_fastpath_unlock().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based
+ * generic implementation.
+ */
+
+#include <asm-generic/mutex-dec.h>
diff -purN linux-2.6.15-rc6-mx/include/asm-arm/atomic.h linux-2.6.15-rc6-mx-new/include/asm-arm/atomic.h
--- linux-2.6.15-rc6-mx/include/asm-arm/atomic.h	2005-12-22 21:55:11.000000000 +0100
+++ linux-2.6.15-rc6-mx-new/include/asm-arm/atomic.h	2005-12-22 22:38:56.000000000 +0100
@@ -175,12 +175,6 @@ static inline void atomic_clear_mask(uns
 
 #endif /* __LINUX_ARM_ARCH__ */
 
-/*
- * Pull in the generic wrappers for atomic_dec_call_if_negative() and
- * atomic_inc_call_if_nonpositive():
- */
-#include <asm-generic/atomic-call-if.h>
-
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
 static inline int atomic_add_unless(atomic_t *v, int a, int u)
diff -purN linux-2.6.15-rc6-mx/include/asm-arm/mutex.h linux-2.6.15-rc6-mx-new/include/asm-arm/mutex.h
--- linux-2.6.15-rc6-mx/include/asm-arm/mutex.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.15-rc6-mx-new/include/asm-arm/mutex.h	2005-12-22 22:38:56.000000000 +0100
@@ -0,0 +1,8 @@
+/*
+ * Pull in the generic wrappers for __mutex_fastpath_lock() and
+ * __mutex_fastpath_unlock().
+ *
+ * TODO: implement optimized primitives instead
+ */
+
+#include <asm-generic/mutex-xchg.h>
diff -purN linux-2.6.15-rc6-mx/include/asm-arm26/atomic.h linux-2.6.15-rc6-mx-new/include/asm-arm26/atomic.h
--- linux-2.6.15-rc6-mx/include/asm-arm26/atomic.h	2005-12-22 21:54:47.000000000 +0100
+++ linux-2.6.15-rc6-mx-new/include/asm-arm26/atomic.h	2005-12-22 22:38:56.000000000 +0100
@@ -76,17 +76,6 @@ static inline int atomic_cmpxchg(atomic_
 	return ret;
 }
 
-/*
- * Pull in the generic wrappers for atomic_dec_call_if_negative() and
- * atomic_inc_call_if_nonpositive().
- *
- * TODO: implement optimized primitives instead, or leave the generic
- * implementation in place, or enable CONFIG_MUTEX_XCHG_ALGORITHM
- * to tell the generic mutex code to use the atomic_xchg() based
- * fastpath implementation.
- */
-#include <asm-generic/atomic-call-if.h>
-
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
 static inline int atomic_add_unless(atomic_t *v, int a, int u)
diff -purN linux-2.6.15-rc6-mx/include/asm-arm26/mutex.h linux-2.6.15-rc6-mx-new/include/asm-arm26/mutex.h
--- linux-2.6.15-rc6-mx/include/asm-arm26/mutex.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.15-rc6-mx-new/include/asm-arm26/mutex.h	2005-12-22 22:38:56.000000000 +0100
@@ -0,0 +1,8 @@
+/*
+ * Pull in the generic wrappers for __mutex_fastpath_lock() and
+ * __mutex_fastpath_unlock().
+ *
+ * TODO: implement optimized primitives instead
+ */
+
+#include <asm-generic/mutex-xchg.h>
diff -purN linux-2.6.15-rc6-mx/include/asm-cris/atomic.h linux-2.6.15-rc6-mx-new/include/asm-cris/atomic.h
--- linux-2.6.15-rc6-mx/include/asm-cris/atomic.h	2005-12-22 21:54:47.000000000 +0100
+++ linux-2.6.15-rc6-mx-new/include/asm-cris/atomic.h	2005-12-22 22:38:56.000000000 +0100
@@ -136,17 +136,6 @@ static inline int atomic_cmpxchg(atomic_
 	return ret;
 }
 
-/*
- * Pull in the generic wrappers for atomic_dec_call_if_negative() and
- * atomic_inc_call_if_nonpositive().
- *
- * TODO: implement optimized primitives instead, or leave the generic
- * implementation in place, or enable CONFIG_MUTEX_XCHG_ALGORITHM
- * to tell the generic mutex code to use the atomic_xchg() based
- * fastpath implementation.
- */
-#include <asm-generic/atomic-call-if.h>
-
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
 static inline int atomic_add_unless(atomic_t *v, int a, int u)
diff -purN linux-2.6.15-rc6-mx/include/asm-cris/mutex.h linux-2.6.15-rc6-mx-new/include/asm-cris/mutex.h
--- linux-2.6.15-rc6-mx/include/asm-cris/mutex.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.15-rc6-mx-new/include/asm-cris/mutex.h	2005-12-22 22:38:56.000000000 +0100
@@ -0,0 +1,10 @@
+/*
+ * Pull in the generic wrappers for __mutex_fastpath_lock() and
+ * __mutex_fastpath_unlock().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based
+ * generic implementation.
+ */
+
+#include <asm-generic/mutex-dec.h>
diff -purN linux-2.6.15-rc6-mx/include/asm-frv/atomic.h linux-2.6.15-rc6-mx-new/include/asm-frv/atomic.h
--- linux-2.6.15-rc6-mx/include/asm-frv/atomic.h	2005-12-22 21:54:47.000000000 +0100
+++ linux-2.6.15-rc6-mx-new/include/asm-frv/atomic.h	2005-12-22 22:38:56.000000000 +0100
@@ -417,17 +417,6 @@ extern uint32_t __cmpxchg_32(uint32_t *v
 #define atomic_cmpxchg(v, old, new) ((int)cmpxchg(&((v)->counter), old, new))
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
-/*
- * Pull in the generic wrappers for atomic_dec_call_if_negative() and
- * atomic_inc_call_if_nonpositive().
- *
- * TODO: implement optimized primitives instead, or leave the generic
- * implementation in place, or enable CONFIG_MUTEX_XCHG_ALGORITHM
- * to tell the generic mutex code to use the atomic_xchg() based
- * fastpath implementation.
- */
-#include <asm-generic/atomic-call-if.h>
-
 #define atomic_add_unless(v, a, u)				\
 ({								\
 	int c, old;						\
diff -purN linux-2.6.15-rc6-mx/include/asm-frv/mutex.h linux-2.6.15-rc6-mx-new/include/asm-frv/mutex.h
--- linux-2.6.15-rc6-mx/include/asm-frv/mutex.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.15-rc6-mx-new/include/asm-frv/mutex.h	2005-12-22 22:38:56.000000000 +0100
@@ -0,0 +1,10 @@
+/*
+ * Pull in the generic wrappers for __mutex_fastpath_lock() and
+ * __mutex_fastpath_unlock().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based
+ * generic implementation.
+ */
+
+#include <asm-generic/mutex-dec.h>
diff -purN linux-2.6.15-rc6-mx/include/asm-generic/atomic-call-if.h linux-2.6.15-rc6-mx-new/include/asm-generic/atomic-call-if.h
--- linux-2.6.15-rc6-mx/include/asm-generic/atomic-call-if.h	2005-12-22 21:54:47.000000000 +0100
+++ linux-2.6.15-rc6-mx-new/include/asm-generic/atomic-call-if.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,37 +0,0 @@
-/*
- * asm-generic/atomic-call-if.h
- *
- * Generic wrappers for atomic_dec_call_if_negative() and
- * atomic_inc_call_if_nonpositive(), based on atomic_dec_return()
- * and atomic_inc_return().
- */
-#ifndef _ASM_GENERIC_ATOMIC_CALL_IF_H
-#define _ASM_GENERIC_ATOMIC_CALL_IF_H
-
-/**
- * atomic_dec_call_if_negative - decrement and call function if negative
- * @v: pointer of type atomic_t
- * @fn: function to call if the result is negative
- *
- * Atomically decrements @v and calls a function if the result is negative.
- */
-#define atomic_dec_call_if_negative(v, fn_name)				\
-do {									\
-	if (atomic_dec_return(v) < 0)					\
-		fn_name(v);						\
-} while (0)
-
-/**
- * atomic_inc_call_if_nonpositive - increment and call function if nonpositive
- * @v: pointer of type atomic_t
- * @fn: function to call if the result is nonpositive
- *
- * Atomically increments @v and calls a function if the result is nonpositive.
- */
-#define atomic_inc_call_if_nonpositive(v, fn_name)			\
-do {									\
-	if (atomic_inc_return(v) <= 0)					\
-		fn_name(v);						\
-} while (0)
-
-#endif
diff -purN linux-2.6.15-rc6-mx/include/asm-generic/mutex-dec.h linux-2.6.15-rc6-mx-new/include/asm-generic/mutex-dec.h
--- linux-2.6.15-rc6-mx/include/asm-generic/mutex-dec.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.15-rc6-mx-new/include/asm-generic/mutex-dec.h	2005-12-22 22:38:56.000000000 +0100
@@ -0,0 +1,66 @@
+/*
+ * asm-generic/mutex-dec.h
+ *
+ * Generic wrappers for the mutex fastpath based on an xchg() implementation
+ * 
+ */
+#ifndef _ASM_GENERIC_MUTEX_DEC_H
+#define _ASM_GENERIC_MUTEX_DEC_H
+
+/**
+ *  __mutex_fastpath_lock - try to take the lock by moving the count from 1 to a 0 value
+ *  @v: pointer of type atomic_t
+ *  @fn: function to call if the original value was not 1
+ *
+ * Change the count from 1 to a value lower than 1, and call <fn> if it wasn't 
+ * 1 originally. 
+ * This function MUST leave the value lower than 1 evne when the "1" assertion wasn't true.
+ */
+#define __mutex_fastpath_lock(v, fn_name)				\
+do {									\
+	if (unlikely(atomic_dec_return(v) < 0))				\
+		fn_name(v);						\
+} while (0)
+
+
+/**
+ *  __mutex_fastpath_lock_retval - try to take the lock by moving the count from 1 to a 0 value
+ *  @v: pointer of type atomic_t
+ *  @fn: function to call if the original value was not 1
+ *
+ * Change the count from 1 to a value lower than 1, and call <fn> if it wasn't 
+ * 1 originally. 
+ * This function returns 0 if the fastpath succeeds, or anything the slow path function returns
+ */
+ */
+
+static inline __mutex_fastpath_lock_retval(struct mutex *lock,  void (*__tmp)(atomic_t *)fn_name)
+{
+	if (unlikely(atomic_dec_return(&lock->count) < 0))
+		return fn_name(lock);
+	else 
+		return 0;
+}
+
+
+/**
+ *  __mutex_fastpath_unlock - try to promote the mutex from 0 to 1
+ *  @v: pointer of type atomic_t
+ *  @fn: function to call if the original value was not 1
+ *
+ * try to promote the mutex from 0 to 1. if it wasn't 0, call <function> 
+ * In the failure case, this function is allowed to either set the value to 
+ * 1, or to set it to a value lower than one.
+ * If the implementation sets it to a value of lower than one, the
+ * __mutex_slowpath_needs_to_unlock() macro needs to return 1, it needs
+ * to return 0 otherwise.
+ */
+#define __mutex_fastpath_unlock(v, fn_name)				\
+do {									\
+	if (unlikely(atomic_inc_return(v) <= 0))			\
+		fn_name(v);						\
+} while (0)
+
+#define __mutex_slowpath_needs_to_unlock() 1
+
+#endif
diff -purN linux-2.6.15-rc6-mx/include/asm-generic/mutex-xchg.h linux-2.6.15-rc6-mx-new/include/asm-generic/mutex-xchg.h
--- linux-2.6.15-rc6-mx/include/asm-generic/mutex-xchg.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.15-rc6-mx-new/include/asm-generic/mutex-xchg.h	2005-12-22 22:38:56.000000000 +0100
@@ -0,0 +1,70 @@
+/*
+ * asm-generic/mutex-xchg.h
+ *
+ * Generic wrappers for the mutex fastpath based on an xchg() implementation
+ * 
+ * NOTE: An xchg based implementation is less optimal than a decrement/increment
+ *       based implementation. If your architecture has a reasonable atomic dec/inc
+ *       then don't use this file, use mutex-dec.h instead!
+ */
+#ifndef _ASM_GENERIC_MUTEX_XCHG_H
+#define _ASM_GENERIC_MUTEX_XCHG_H
+
+/**
+ *  __mutex_fastpath_lock - try to take the lock by moving the count from 1 to a 0 value
+ *  @v: pointer of type atomic_t
+ *  @fn: function to call if the original value was not 1
+ *
+ * Change the count from 1 to a value lower than 1, and call <fn> if it wasn't 
+ * 1 originally. 
+ * This function MUST leave the value lower than 1 evne when the "1" assertion wasn't true.
+ */
+
+#define __mutex_fastpath_lock(v, fn_name)				\
+do {									\
+	if (unlikely(atomic_xchg(&lock->count, 0) != 1))
+		fn_name(v);						\
+} while (0)
+
+/**
+ *  __mutex_fastpath_lock_retval - try to take the lock by moving the count from 1 to a 0 value
+ *  @v: pointer of type atomic_t
+ *  @fn: function to call if the original value was not 1
+ *
+ * Change the count from 1 to a value lower than 1, and call <fn> if it wasn't 
+ * 1 originally. 
+ * This function returns 0 if the fastpath succeeds, or anything the slow path function returns
+ */
+ */
+
+static inline __mutex_fastpath_lock_retval(struct mutex *lock,  void (*__tmp)(atomic_t *)fn_name)
+{
+	if (unlikely(atomic_xchg(&lock->count, 0) != 1))
+		return fn_name(lock);
+	else 
+		return 0;
+}
+
+
+/**
+ *  __mutex_fastpath_unlock - try to promote the mutex from 0 to 1
+ *  @v: pointer of type atomic_t
+ *  @fn: function to call if the original value was not 1
+ *
+ * try to promote the mutex from 0 to 1. if it wasn't 0, call <function> 
+ * In the failure case, this function is allowed to either set the value to 
+ * 1, or to set it to a value lower than one.
+ * If the implementation sets it to a value of lower than one, the
+ * __mutex_slowpath_needs_to_unlock() macro needs to return 1, it needs
+ * to return 0 otherwise.
+ */
+
+#define __mutex_fastpath_unlock(v, fn_name)			\
+do {									\
+	if (unlikely(atomic_xchg(&lock->count, 1) != 0))
+		fn_name(v);						\
+} while (0)
+
+#define __mutex_slowpath_needs_to_unlock() 0
+
+#endif
diff -purN linux-2.6.15-rc6-mx/include/asm-h8300/atomic.h linux-2.6.15-rc6-mx-new/include/asm-h8300/atomic.h
--- linux-2.6.15-rc6-mx/include/asm-h8300/atomic.h	2005-12-22 21:54:47.000000000 +0100
+++ linux-2.6.15-rc6-mx-new/include/asm-h8300/atomic.h	2005-12-22 19:54:35.000000000 +0100
@@ -95,19 +95,6 @@ static inline int atomic_cmpxchg(atomic_
 	return ret;
 }
 
-/*
- * Pull in the generic wrappers for atomic_dec_call_if_negative() and
- * atomic_inc_call_if_nonpositive().
- *
- * TODO: implement optimized primitives instead, or leave the generic
- * implementation in place, or enable CONFIG_MUTEX_XCHG_ALGORITHM
- * to tell the generic mutex code to use the atomic_xchg() based
- * fastpath implementation.
- */
-#include <asm-generic/atomic-call-if.h>
-
-#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
-
 static inline int atomic_add_unless(atomic_t *v, int a, int u)
 {
 	int ret;
diff -purN linux-2.6.15-rc6-mx/include/asm-h8300/mutex.h linux-2.6.15-rc6-mx-new/include/asm-h8300/mutex.h
--- linux-2.6.15-rc6-mx/include/asm-h8300/mutex.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.15-rc6-mx-new/include/asm-h8300/mutex.h	2005-12-22 22:38:56.000000000 +0100
@@ -0,0 +1,10 @@
+/*
+ * Pull in the generic wrappers for __mutex_fastpath_lock() and
+ * __mutex_fastpath_unlock().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based
+ * generic implementation.
+ */
+
+#include <asm-generic/mutex-dec.h>
diff -purN linux-2.6.15-rc6-mx/include/asm-i386/atomic.h linux-2.6.15-rc6-mx-new/include/asm-i386/atomic.h
--- linux-2.6.15-rc6-mx/include/asm-i386/atomic.h	2005-12-22 21:54:47.000000000 +0100
+++ linux-2.6.15-rc6-mx-new/include/asm-i386/atomic.h	2005-12-22 22:38:56.000000000 +0100
@@ -240,63 +240,6 @@ static __inline__ int atomic_sub_return(
 #define atomic_inc_return(v)  (atomic_add_return(1,v))
 #define atomic_dec_return(v)  (atomic_sub_return(1,v))
 
-/**
- * atomic_dec_call_if_negative - decrement and call function if negative
- * @v: pointer of type atomic_t
- * @fn: function to call if the result is negative
- *
- * Atomically decrements @v and calls a function if the result is negative.
- */
-#define atomic_dec_call_if_negative(v, fn_name)				\
-do {									\
-	fastcall void (*__tmp)(atomic_t *) = fn_name;			\
-	unsigned int dummy;						\
-									\
-	(void)__tmp;							\
-	typecheck(atomic_t *, v);					\
-									\
-	__asm__ __volatile__(						\
-		LOCK "decl (%%eax)\n"  					\
-		"js 2f\n"						\
-		"1:\n"							\
-		LOCK_SECTION_START("")					\
-		"2: call "#fn_name"\n\t"				\
-		"jmp 1b\n"						\
-		LOCK_SECTION_END					\
-		:"=a"(dummy)						\
-		:"a" (v)						\
-		:"memory", "ecx", "edx");				\
-} while (0)
-
-/**
- * atomic_inc_call_if_nonpositive - increment and call function if nonpositive
- * @v: pointer of type atomic_t
- * @fn: function to call if the result is nonpositive
- *
- * Atomically increments @v and calls a function if the result is nonpositive.
- */
-#define atomic_inc_call_if_nonpositive(v, fn_name)			\
-do {									\
-	fastcall void (*__tmp)(atomic_t *) = fn_name;			\
-	unsigned int dummy;						\
-									\
-	(void)__tmp;							\
-	typecheck(atomic_t *, v);					\
-									\
-	__asm__ __volatile__(						\
-		LOCK "incl (%%eax)\n"  					\
-		"jle 2f\n"						\
-		"1:\n"							\
-		LOCK_SECTION_START("")					\
-		"2: call "#fn_name"\n\t"				\
-		"jmp 1b\n"						\
-		LOCK_SECTION_END					\
-		:"=a" (dummy)						\
-		:"a" (v)						\
-		:"memory", "ecx", "edx");				\
-} while (0)
-
-
 /* These are x86-specific, used by some header files */
 #define atomic_clear_mask(mask, addr) \
 __asm__ __volatile__(LOCK "andl %0,%1" \
diff -purN linux-2.6.15-rc6-mx/include/asm-i386/mutex.h linux-2.6.15-rc6-mx-new/include/asm-i386/mutex.h
--- linux-2.6.15-rc6-mx/include/asm-i386/mutex.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.15-rc6-mx-new/include/asm-i386/mutex.h	2005-12-22 22:38:56.000000000 +0100
@@ -0,0 +1,96 @@
+/*
+ * Mutexes: blocking mutual exclusion locks
+ *
+ * started by Ingo Molnar:
+ *
+ *  Copyright (C) 2004, 2005 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
+ */
+ 
+/**
+ *  __mutex_fastpath_lock - try to take the lock by moving the count from 1 to a 0 value
+ *  @v: pointer of type atomic_t
+ *  @fn: function to call if the original value was not 1
+ *
+ * Change the count from 1 to a value lower than 1, and call <fn> if it wasn't 
+ * 1 originally. 
+ * This function MUST leave the value lower than 1 evne when the "1" assertion wasn't true.
+ */
+ */
+#define __mutex_fastpath_lock(v, fn_name)				\
+do {									\
+	fastcall void (*__tmp)(atomic_t *) = fn_name;			\
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
+		"2: call "#fn_name"\n\t"				\
+		"jmp 1b\n"						\
+		LOCK_SECTION_END					\
+		:"=a"(dummy)						\
+		:"a" (v)						\
+		:"memory", "ecx", "edx");				\
+} while (0)
+
+
+/**
+ *  __mutex_fastpath_lock_retval - try to take the lock by moving the count from 1 to a 0 value
+ *  @v: pointer of type atomic_t
+ *  @fn: function to call if the original value was not 1
+ *
+ * Change the count from 1 to a value lower than 1, and call <fn> if it wasn't 
+ * 1 originally. 
+ * This function returns 0 if the fastpath succeeds, or anything the slow path function returns
+ */
+ */
+
+static inline __mutex_fastpath_lock_retval(struct mutex *lock,  void (*__tmp)(atomic_t *)fn_name)
+{
+	if (unlikely(atomic_dec_return(&lock->count) < 0))
+		return fn_name(lock);
+	else 
+		return 0;
+}
+
+
+/**
+ *  __mutex_fastpath_unlock - try to promote the mutex from 0 to 1
+ *  @v: pointer of type atomic_t
+ *  @fn: function to call if the original value was not 1
+ *
+ * try to promote the mutex from 0 to 1. if it wasn't 0, call <function> 
+ * In the failure case, this function is allowed to either set the value to 
+ * 1, or to set it to a value lower than one.
+ * If the implementation sets it to a value of lower than one, the
+ * __mutex_slowpath_needs_to_unlock() macro needs to return 1, it needs
+ * to return 0 otherwise.
+ */
+#define __mutex_fastpath_unlock(v, fn_name)			\
+do {									\
+	fastcall void (*__tmp)(atomic_t *) = fn_name;			\
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
+		"2: call "#fn_name"\n\t"				\
+		"jmp 1b\n"						\
+		LOCK_SECTION_END					\
+		:"=a" (dummy)						\
+		:"a" (v)						\
+		:"memory", "ecx", "edx");				\
+} while (0)
+
+
+#define __mutex_slowpath_needs_to_unlock() 1
+
diff -purN linux-2.6.15-rc6-mx/include/asm-ia64/atomic.h linux-2.6.15-rc6-mx-new/include/asm-ia64/atomic.h
--- linux-2.6.15-rc6-mx/include/asm-ia64/atomic.h	2005-12-22 21:54:47.000000000 +0100
+++ linux-2.6.15-rc6-mx-new/include/asm-ia64/atomic.h	2005-12-22 22:38:56.000000000 +0100
@@ -91,17 +91,6 @@ ia64_atomic64_sub (__s64 i, atomic64_t *
 #define atomic_cmpxchg(v, old, new) ((int)cmpxchg(&((v)->counter), old, new))
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
-/*
- * Pull in the generic wrappers for atomic_dec_call_if_negative() and
- * atomic_inc_call_if_nonpositive().
- *
- * TODO: implement optimized primitives instead, or leave the generic
- * implementation in place, or enable CONFIG_MUTEX_XCHG_ALGORITHM
- * to tell the generic mutex code to use the atomic_xchg() based
- * fastpath implementation.
- */
-#include <asm-generic/atomic-call-if.h>
-
 #define atomic_add_unless(v, a, u)				\
 ({								\
 	int c, old;						\
diff -purN linux-2.6.15-rc6-mx/include/asm-ia64/mutex.h linux-2.6.15-rc6-mx-new/include/asm-ia64/mutex.h
--- linux-2.6.15-rc6-mx/include/asm-ia64/mutex.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.15-rc6-mx-new/include/asm-ia64/mutex.h	2005-12-22 22:38:56.000000000 +0100
@@ -0,0 +1,10 @@
+/*
+ * Pull in the generic wrappers for __mutex_fastpath_lock() and
+ * __mutex_fastpath_unlock().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based
+ * generic implementation.
+ */
+
+#include <asm-generic/mutex-dec.h>
diff -purN linux-2.6.15-rc6-mx/include/asm-m32r/atomic.h linux-2.6.15-rc6-mx-new/include/asm-m32r/atomic.h
--- linux-2.6.15-rc6-mx/include/asm-m32r/atomic.h	2005-12-22 21:54:47.000000000 +0100
+++ linux-2.6.15-rc6-mx-new/include/asm-m32r/atomic.h	2005-12-22 22:38:56.000000000 +0100
@@ -245,17 +245,6 @@ static __inline__ int atomic_dec_return(
 #define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
-/*
- * Pull in the generic wrappers for atomic_dec_call_if_negative() and
- * atomic_inc_call_if_nonpositive().
- *
- * TODO: implement optimized primitives instead, or leave the generic
- * implementation in place, or enable CONFIG_MUTEX_XCHG_ALGORITHM
- * to tell the generic mutex code to use the atomic_xchg() based
- * fastpath implementation.
- */
-#include <asm-generic/atomic-call-if.h>
-
 /**
  * atomic_add_unless - add unless the number is a given value
  * @v: pointer of type atomic_t
diff -purN linux-2.6.15-rc6-mx/include/asm-m32r/mutex.h linux-2.6.15-rc6-mx-new/include/asm-m32r/mutex.h
--- linux-2.6.15-rc6-mx/include/asm-m32r/mutex.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.15-rc6-mx-new/include/asm-m32r/mutex.h	2005-12-22 22:38:56.000000000 +0100
@@ -0,0 +1,10 @@
+/*
+ * Pull in the generic wrappers for __mutex_fastpath_lock() and
+ * __mutex_fastpath_unlock().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based
+ * generic implementation.
+ */
+
+#include <asm-generic/mutex-dec.h>
diff -purN linux-2.6.15-rc6-mx/include/asm-m68k/atomic.h linux-2.6.15-rc6-mx-new/include/asm-m68k/atomic.h
--- linux-2.6.15-rc6-mx/include/asm-m68k/atomic.h	2005-12-22 21:54:47.000000000 +0100
+++ linux-2.6.15-rc6-mx-new/include/asm-m68k/atomic.h	2005-12-22 22:38:56.000000000 +0100
@@ -142,17 +142,6 @@ static inline void atomic_set_mask(unsig
 #define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
-/*
- * Pull in the generic wrappers for atomic_dec_call_if_negative() and
- * atomic_inc_call_if_nonpositive().
- *
- * TODO: implement optimized primitives instead, or leave the generic
- * implementation in place, or enable CONFIG_MUTEX_XCHG_ALGORITHM
- * to tell the generic mutex code to use the atomic_xchg() based
- * fastpath implementation.
- */
-#include <asm-generic/atomic-call-if.h>
-
 #define atomic_add_unless(v, a, u)				\
 ({								\
 	int c, old;						\
diff -purN linux-2.6.15-rc6-mx/include/asm-m68k/mutex.h linux-2.6.15-rc6-mx-new/include/asm-m68k/mutex.h
--- linux-2.6.15-rc6-mx/include/asm-m68k/mutex.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.15-rc6-mx-new/include/asm-m68k/mutex.h	2005-12-22 22:38:56.000000000 +0100
@@ -0,0 +1,10 @@
+/*
+ * Pull in the generic wrappers for __mutex_fastpath_lock() and
+ * __mutex_fastpath_unlock().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based
+ * generic implementation.
+ */
+
+#include <asm-generic/mutex-dec.h>
diff -purN linux-2.6.15-rc6-mx/include/asm-m68knommu/atomic.h linux-2.6.15-rc6-mx-new/include/asm-m68knommu/atomic.h
--- linux-2.6.15-rc6-mx/include/asm-m68knommu/atomic.h	2005-12-22 21:54:47.000000000 +0100
+++ linux-2.6.15-rc6-mx-new/include/asm-m68knommu/atomic.h	2005-12-22 22:38:56.000000000 +0100
@@ -131,17 +131,6 @@ static inline int atomic_sub_return(int 
 #define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
-/*
- * Pull in the generic wrappers for atomic_dec_call_if_negative() and
- * atomic_inc_call_if_nonpositive().
- *
- * TODO: implement optimized primitives instead, or leave the generic
- * implementation in place, or enable CONFIG_MUTEX_XCHG_ALGORITHM
- * to tell the generic mutex code to use the atomic_xchg() based
- * fastpath implementation.
- */
-#include <asm-generic/atomic-call-if.h>
-
 #define atomic_add_unless(v, a, u)				\
 ({								\
 	int c, old;						\
diff -purN linux-2.6.15-rc6-mx/include/asm-m68knommu/mutex.h linux-2.6.15-rc6-mx-new/include/asm-m68knommu/mutex.h
--- linux-2.6.15-rc6-mx/include/asm-m68knommu/mutex.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.15-rc6-mx-new/include/asm-m68knommu/mutex.h	2005-12-22 22:38:56.000000000 +0100
@@ -0,0 +1,10 @@
+/*
+ * Pull in the generic wrappers for __mutex_fastpath_lock() and
+ * __mutex_fastpath_unlock().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based
+ * generic implementation.
+ */
+
+#include <asm-generic/mutex-dec.h>
diff -purN linux-2.6.15-rc6-mx/include/asm-mips/atomic.h linux-2.6.15-rc6-mx-new/include/asm-mips/atomic.h
--- linux-2.6.15-rc6-mx/include/asm-mips/atomic.h	2005-12-22 21:54:47.000000000 +0100
+++ linux-2.6.15-rc6-mx-new/include/asm-mips/atomic.h	2005-12-22 22:38:56.000000000 +0100
@@ -291,17 +291,6 @@ static __inline__ int atomic_sub_if_posi
 #define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
-/*
- * Pull in the generic wrappers for atomic_dec_call_if_negative() and
- * atomic_inc_call_if_nonpositive().
- *
- * TODO: implement optimized primitives instead, or leave the generic
- * implementation in place, or enable CONFIG_MUTEX_XCHG_ALGORITHM
- * to tell the generic mutex code to use the atomic_xchg() based
- * fastpath implementation.
- */
-#include <asm-generic/atomic-call-if.h>
-
 /**
  * atomic_add_unless - add unless the number is a given value
  * @v: pointer of type atomic_t
diff -purN linux-2.6.15-rc6-mx/include/asm-mips/mutex.h linux-2.6.15-rc6-mx-new/include/asm-mips/mutex.h
--- linux-2.6.15-rc6-mx/include/asm-mips/mutex.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.15-rc6-mx-new/include/asm-mips/mutex.h	2005-12-22 22:38:56.000000000 +0100
@@ -0,0 +1,10 @@
+/*
+ * Pull in the generic wrappers for __mutex_fastpath_lock() and
+ * __mutex_fastpath_unlock().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based
+ * generic implementation.
+ */
+
+#include <asm-generic/mutex-dec.h>
diff -purN linux-2.6.15-rc6-mx/include/asm-parisc/atomic.h linux-2.6.15-rc6-mx-new/include/asm-parisc/atomic.h
--- linux-2.6.15-rc6-mx/include/asm-parisc/atomic.h	2005-12-22 21:54:47.000000000 +0100
+++ linux-2.6.15-rc6-mx-new/include/asm-parisc/atomic.h	2005-12-22 22:38:56.000000000 +0100
@@ -167,17 +167,6 @@ static __inline__ int atomic_read(const 
 #define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
-/*
- * Pull in the generic wrappers for atomic_dec_call_if_negative() and
- * atomic_inc_call_if_nonpositive().
- *
- * TODO: implement optimized primitives instead, or leave the generic
- * implementation in place, or enable CONFIG_MUTEX_XCHG_ALGORITHM
- * to tell the generic mutex code to use the atomic_xchg() based
- * fastpath implementation.
- */
-#include <asm-generic/atomic-call-if.h>
-
 /**
  * atomic_add_unless - add unless the number is a given value
  * @v: pointer of type atomic_t
diff -purN linux-2.6.15-rc6-mx/include/asm-parisc/mutex.h linux-2.6.15-rc6-mx-new/include/asm-parisc/mutex.h
--- linux-2.6.15-rc6-mx/include/asm-parisc/mutex.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.15-rc6-mx-new/include/asm-parisc/mutex.h	2005-12-22 22:38:56.000000000 +0100
@@ -0,0 +1,10 @@
+/*
+ * Pull in the generic wrappers for __mutex_fastpath_lock() and
+ * __mutex_fastpath_unlock().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based
+ * generic implementation.
+ */
+
+#include <asm-generic/mutex-dec.h>
diff -purN linux-2.6.15-rc6-mx/include/asm-powerpc/atomic.h linux-2.6.15-rc6-mx-new/include/asm-powerpc/atomic.h
--- linux-2.6.15-rc6-mx/include/asm-powerpc/atomic.h	2005-12-22 21:54:47.000000000 +0100
+++ linux-2.6.15-rc6-mx-new/include/asm-powerpc/atomic.h	2005-12-22 22:38:56.000000000 +0100
@@ -121,17 +121,6 @@ static __inline__ int atomic_inc_return(
 }
 
 /*
- * Pull in the generic wrappers for atomic_dec_call_if_negative() and
- * atomic_inc_call_if_nonpositive().
- *
- * TODO: implement optimized primitives instead, or leave the generic
- * implementation in place, or enable CONFIG_MUTEX_XCHG_ALGORITHM
- * to tell the generic mutex code to use the atomic_xchg() based
- * fastpath implementation.
- */
-#include <asm-generic/atomic-call-if.h>
-
-/*
  * atomic_inc_and_test - increment and test
  * @v: pointer of type atomic_t
  *
diff -purN linux-2.6.15-rc6-mx/include/asm-powerpc/mutex.h linux-2.6.15-rc6-mx-new/include/asm-powerpc/mutex.h
--- linux-2.6.15-rc6-mx/include/asm-powerpc/mutex.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.15-rc6-mx-new/include/asm-powerpc/mutex.h	2005-12-22 22:38:56.000000000 +0100
@@ -0,0 +1,10 @@
+/*
+ * Pull in the generic wrappers for __mutex_fastpath_lock() and
+ * __mutex_fastpath_unlock().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based
+ * generic implementation.
+ */
+
+#include <asm-generic/mutex-dec.h>
diff -purN linux-2.6.15-rc6-mx/include/asm-s390/atomic.h linux-2.6.15-rc6-mx-new/include/asm-s390/atomic.h
--- linux-2.6.15-rc6-mx/include/asm-s390/atomic.h	2005-12-22 21:54:47.000000000 +0100
+++ linux-2.6.15-rc6-mx-new/include/asm-s390/atomic.h	2005-12-22 22:38:56.000000000 +0100
@@ -201,17 +201,6 @@ atomic_compare_and_swap(int expected_old
 #define atomic_cmpxchg(v, o, n) (atomic_compare_and_swap((o), (n), &((v)->counter)))
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
-/*
- * Pull in the generic wrappers for atomic_dec_call_if_negative() and
- * atomic_inc_call_if_nonpositive().
- *
- * TODO: implement optimized primitives instead, or leave the generic
- * implementation in place, or enable CONFIG_MUTEX_XCHG_ALGORITHM
- * to tell the generic mutex code to use the atomic_xchg() based
- * fastpath implementation.
- */
-#include <asm-generic/atomic-call-if.h>
-
 #define atomic_add_unless(v, a, u)				\
 ({								\
 	int c, old;						\
diff -purN linux-2.6.15-rc6-mx/include/asm-s390/mutex.h linux-2.6.15-rc6-mx-new/include/asm-s390/mutex.h
--- linux-2.6.15-rc6-mx/include/asm-s390/mutex.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.15-rc6-mx-new/include/asm-s390/mutex.h	2005-12-22 22:38:56.000000000 +0100
@@ -0,0 +1,10 @@
+/*
+ * Pull in the generic wrappers for __mutex_fastpath_lock() and
+ * __mutex_fastpath_unlock().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based
+ * generic implementation.
+ */
+
+#include <asm-generic/mutex-dec.h>
diff -purN linux-2.6.15-rc6-mx/include/asm-sh/atomic.h linux-2.6.15-rc6-mx-new/include/asm-sh/atomic.h
--- linux-2.6.15-rc6-mx/include/asm-sh/atomic.h	2005-12-22 21:54:47.000000000 +0100
+++ linux-2.6.15-rc6-mx-new/include/asm-sh/atomic.h	2005-12-22 22:38:56.000000000 +0100
@@ -101,17 +101,6 @@ static inline int atomic_cmpxchg(atomic_
 	return ret;
 }
 
-/*
- * Pull in the generic wrappers for atomic_dec_call_if_negative() and
- * atomic_inc_call_if_nonpositive().
- *
- * TODO: implement optimized primitives instead, or leave the generic
- * implementation in place, or enable CONFIG_MUTEX_XCHG_ALGORITHM
- * to tell the generic mutex code to use the atomic_xchg() based
- * fastpath implementation.
- */
-#include <asm-generic/atomic-call-if.h>
-
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
 static inline int atomic_add_unless(atomic_t *v, int a, int u)
diff -purN linux-2.6.15-rc6-mx/include/asm-sh/mutex.h linux-2.6.15-rc6-mx-new/include/asm-sh/mutex.h
--- linux-2.6.15-rc6-mx/include/asm-sh/mutex.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.15-rc6-mx-new/include/asm-sh/mutex.h	2005-12-22 22:38:56.000000000 +0100
@@ -0,0 +1,10 @@
+/*
+ * Pull in the generic wrappers for __mutex_fastpath_lock() and
+ * __mutex_fastpath_unlock().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based
+ * generic implementation.
+ */
+
+#include <asm-generic/mutex-dec.h>
diff -purN linux-2.6.15-rc6-mx/include/asm-sh64/atomic.h linux-2.6.15-rc6-mx-new/include/asm-sh64/atomic.h
--- linux-2.6.15-rc6-mx/include/asm-sh64/atomic.h	2005-12-22 21:54:47.000000000 +0100
+++ linux-2.6.15-rc6-mx-new/include/asm-sh64/atomic.h	2005-12-22 22:38:56.000000000 +0100
@@ -113,17 +113,6 @@ static inline int atomic_cmpxchg(atomic_
 	return ret;
 }
 
-/*
- * Pull in the generic wrappers for atomic_dec_call_if_negative() and
- * atomic_inc_call_if_nonpositive().
- *
- * TODO: implement optimized primitives instead, or leave the generic
- * implementation in place, or enable CONFIG_MUTEX_XCHG_ALGORITHM
- * to tell the generic mutex code to use the atomic_xchg() based
- * fastpath implementation.
- */
-#include <asm-generic/atomic-call-if.h>
-
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
 static inline int atomic_add_unless(atomic_t *v, int a, int u)
diff -purN linux-2.6.15-rc6-mx/include/asm-sh64/mutex.h linux-2.6.15-rc6-mx-new/include/asm-sh64/mutex.h
--- linux-2.6.15-rc6-mx/include/asm-sh64/mutex.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.15-rc6-mx-new/include/asm-sh64/mutex.h	2005-12-22 22:38:56.000000000 +0100
@@ -0,0 +1,10 @@
+/*
+ * Pull in the generic wrappers for __mutex_fastpath_lock() and
+ * __mutex_fastpath_unlock().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based
+ * generic implementation.
+ */
+
+#include <asm-generic/mutex-dec.h>
diff -purN linux-2.6.15-rc6-mx/include/asm-sparc/mutex.h linux-2.6.15-rc6-mx-new/include/asm-sparc/mutex.h
--- linux-2.6.15-rc6-mx/include/asm-sparc/mutex.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.15-rc6-mx-new/include/asm-sparc/mutex.h	2005-12-22 22:38:56.000000000 +0100
@@ -0,0 +1,10 @@
+/*
+ * Pull in the generic wrappers for __mutex_fastpath_lock() and
+ * __mutex_fastpath_unlock().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based
+ * generic implementation.
+ */
+
+#include <asm-generic/mutex-dec.h>
diff -purN linux-2.6.15-rc6-mx/include/asm-sparc64/atomic.h linux-2.6.15-rc6-mx-new/include/asm-sparc64/atomic.h
--- linux-2.6.15-rc6-mx/include/asm-sparc64/atomic.h	2005-12-22 21:54:47.000000000 +0100
+++ linux-2.6.15-rc6-mx-new/include/asm-sparc64/atomic.h	2005-12-22 22:38:56.000000000 +0100
@@ -74,17 +74,6 @@ extern int atomic64_sub_ret(int, atomic6
 #define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
-/*
- * Pull in the generic wrappers for atomic_dec_call_if_negative() and
- * atomic_inc_call_if_nonpositive().
- *
- * TODO: implement optimized primitives instead, or leave the generic
- * implementation in place, or enable CONFIG_MUTEX_XCHG_ALGORITHM
- * to tell the generic mutex code to use the atomic_xchg() based
- * fastpath implementation.
- */
-#include <asm-generic/atomic-call-if.h>
-
 #define atomic_add_unless(v, a, u)				\
 ({								\
 	int c, old;						\
diff -purN linux-2.6.15-rc6-mx/include/asm-sparc64/mutex.h linux-2.6.15-rc6-mx-new/include/asm-sparc64/mutex.h
--- linux-2.6.15-rc6-mx/include/asm-sparc64/mutex.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.15-rc6-mx-new/include/asm-sparc64/mutex.h	2005-12-22 22:38:56.000000000 +0100
@@ -0,0 +1,10 @@
+/*
+ * Pull in the generic wrappers for __mutex_fastpath_lock() and
+ * __mutex_fastpath_unlock().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based
+ * generic implementation.
+ */
+
+#include <asm-generic/mutex-dec.h>
diff -purN linux-2.6.15-rc6-mx/include/asm-um/mutex.h linux-2.6.15-rc6-mx-new/include/asm-um/mutex.h
--- linux-2.6.15-rc6-mx/include/asm-um/mutex.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.15-rc6-mx-new/include/asm-um/mutex.h	2005-12-22 22:38:56.000000000 +0100
@@ -0,0 +1,10 @@
+/*
+ * Pull in the generic wrappers for __mutex_fastpath_lock() and
+ * __mutex_fastpath_unlock().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based
+ * generic implementation.
+ */
+
+#include <asm-generic/mutex-dec.h>
diff -purN linux-2.6.15-rc6-mx/include/asm-v850/atomic.h linux-2.6.15-rc6-mx-new/include/asm-v850/atomic.h
--- linux-2.6.15-rc6-mx/include/asm-v850/atomic.h	2005-12-22 21:54:47.000000000 +0100
+++ linux-2.6.15-rc6-mx-new/include/asm-v850/atomic.h	2005-12-22 22:38:56.000000000 +0100
@@ -104,17 +104,6 @@ static inline int atomic_cmpxchg(atomic_
 	return ret;
 }
 
-/*
- * Pull in the generic wrappers for atomic_dec_call_if_negative() and
- * atomic_inc_call_if_nonpositive().
- *
- * TODO: implement optimized primitives instead, or leave the generic
- * implementation in place, or enable CONFIG_MUTEX_XCHG_ALGORITHM
- * to tell the generic mutex code to use the atomic_xchg() based
- * fastpath implementation.
- */
-#include <asm-generic/atomic-call-if.h>
-
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
 static inline int atomic_add_unless(atomic_t *v, int a, int u)
diff -purN linux-2.6.15-rc6-mx/include/asm-v850/mutex.h linux-2.6.15-rc6-mx-new/include/asm-v850/mutex.h
--- linux-2.6.15-rc6-mx/include/asm-v850/mutex.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.15-rc6-mx-new/include/asm-v850/mutex.h	2005-12-22 22:38:56.000000000 +0100
@@ -0,0 +1,10 @@
+/*
+ * Pull in the generic wrappers for __mutex_fastpath_lock() and
+ * __mutex_fastpath_unlock().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based
+ * generic implementation.
+ */
+
+#include <asm-generic/mutex-dec.h>
diff -purN linux-2.6.15-rc6-mx/include/asm-x86_64/atomic.h linux-2.6.15-rc6-mx-new/include/asm-x86_64/atomic.h
--- linux-2.6.15-rc6-mx/include/asm-x86_64/atomic.h	2005-12-22 21:54:47.000000000 +0100
+++ linux-2.6.15-rc6-mx-new/include/asm-x86_64/atomic.h	2005-12-22 22:38:56.000000000 +0100
@@ -203,64 +203,6 @@ static __inline__ int atomic_sub_return(
 #define atomic_inc_return(v)  (atomic_add_return(1,v))
 #define atomic_dec_return(v)  (atomic_sub_return(1,v))
 
-/**
- * atomic_dec_call_if_negative - decrement and call function if negative
- * @v: pointer of type atomic_t
- * @fn: function to call if the result is negative
- *
- * Atomically decrements @v and calls a function if the result is negative.
- */
-#define atomic_dec_call_if_negative(v, fn_name)				\
-do {									\
-	fastcall void (*__tmp)(atomic_t *) = fn_name;			\
-	unsigned long dummy;						\
-									\
-	(void)__tmp;							\
-	typecheck(atomic_t *, v);					\
-									\
-	__asm__ __volatile__(						\
-		LOCK "decl (%%rdi)\n"  					\
-		"js 2f\n"						\
-		"1:\n"							\
-		LOCK_SECTION_START("")					\
-		"2: call "#fn_name"\n\t"				\
-		"jmp 1b\n"						\
-		LOCK_SECTION_END					\
-		:"=D" (dummy)						\
-		:"D" (v)						\
-		:"rax", "rsi", "rdx", "rcx",				\
-		 "r8", "r9", "r10", "r11", "memory");			\
-} while (0)
-
-/**
- * atomic_inc_call_if_nonpositive - increment and call function if nonpositive
- * @v: pointer of type atomic_t
- * @fn: function to call if the result is nonpositive
- *
- * Atomically increments @v and calls a function if the result is nonpositive.
- */
-#define atomic_inc_call_if_nonpositive(v, fn_name)			\
-do {									\
-	fastcall void (*__tmp)(atomic_t *) = fn_name;			\
-	unsigned long dummy;						\
-									\
-	(void)__tmp;							\
-	typecheck(atomic_t *, v);					\
-									\
-	__asm__ __volatile__(						\
-		LOCK "incl (%%rdi)\n"  					\
-		"jle 2f\n"						\
-		"1:\n"							\
-		LOCK_SECTION_START("")					\
-		"2: call "#fn_name"\n\t"				\
-		"jmp 1b\n"						\
-		LOCK_SECTION_END					\
-		:"=D" (dummy)						\
-		:"D" (v)						\
-		:"rax", "rsi", "rdx", "rcx",				\
-		 "r8", "r9", "r10", "r11", "memory");			\
-} while (0)
-
 /* An 64bit atomic type */
 
 typedef struct { volatile long counter; } atomic64_t;
diff -purN linux-2.6.15-rc6-mx/include/asm-x86_64/mutex.h linux-2.6.15-rc6-mx-new/include/asm-x86_64/mutex.h
--- linux-2.6.15-rc6-mx/include/asm-x86_64/mutex.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.15-rc6-mx-new/include/asm-x86_64/mutex.h	2005-12-22 22:38:56.000000000 +0100
@@ -0,0 +1,69 @@
+
+/*
+ * Mutexes: blocking mutual exclusion locks
+ *
+ * started by Ingo Molnar:
+ *
+ *  Copyright (C) 2004, 2005 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
+ */
+ 
+/**
+ * __mutex_fastpath_lock - decrement and call function if negative
+ * @v: pointer of type atomic_t
+ * @fn: function to call if the result is negative
+ *
+ * Atomically decrements @v and calls a function if the result is negative.
+ */
+#define __mutex_fastpath_lock(v, fn_name)				\
+do {									\
+	fastcall void (*__tmp)(atomic_t *) = fn_name;			\
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
+		"2: call "#fn_name"\n\t"				\
+		"jmp 1b\n"						\
+		LOCK_SECTION_END					\
+		:"=D" (dummy)						\
+		:"D" (v)						\
+		:"rax", "rsi", "rdx", "rcx",				\
+		 "r8", "r9", "r10", "r11", "memory");			\
+} while (0)
+
+/**
+ * __mutex_fastpath_unlock - increment and call function if nonpositive
+ * @v: pointer of type atomic_t
+ * @fn: function to call if the result is nonpositive
+ *
+ * Atomically increments @v and calls a function if the result is nonpositive.
+ */
+#define __mutex_fastpath_unlock(v, fn_name)			\
+do {									\
+	fastcall void (*__tmp)(atomic_t *) = fn_name;			\
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
+		"2: call "#fn_name"\n\t"				\
+		"jmp 1b\n"						\
+		LOCK_SECTION_END					\
+		:"=D" (dummy)						\
+		:"D" (v)						\
+		:"rax", "rsi", "rdx", "rcx",				\
+		 "r8", "r9", "r10", "r11", "memory");			\
+} while (0)
+
+
+#define __mutex_slowpath_needs_to_unlock() 1
diff -purN linux-2.6.15-rc6-mx/include/asm-xtensa/atomic.h linux-2.6.15-rc6-mx-new/include/asm-xtensa/atomic.h
--- linux-2.6.15-rc6-mx/include/asm-xtensa/atomic.h	2005-12-22 21:54:47.000000000 +0100
+++ linux-2.6.15-rc6-mx-new/include/asm-xtensa/atomic.h	2005-12-22 22:38:56.000000000 +0100
@@ -226,17 +226,6 @@ static inline int atomic_sub_return(int 
 #define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
-/*
- * Pull in the generic wrappers for atomic_dec_call_if_negative() and
- * atomic_inc_call_if_nonpositive().
- *
- * TODO: implement optimized primitives instead, or leave the generic
- * implementation in place, or enable CONFIG_MUTEX_XCHG_ALGORITHM
- * to tell the generic mutex code to use the atomic_xchg() based
- * fastpath implementation.
- */
-#include <asm-generic/atomic-call-if.h>
-
 /**
  * atomic_add_unless - add unless the number is a given value
  * @v: pointer of type atomic_t
diff -purN linux-2.6.15-rc6-mx/include/asm-xtensa/mutex.h linux-2.6.15-rc6-mx-new/include/asm-xtensa/mutex.h
--- linux-2.6.15-rc6-mx/include/asm-xtensa/mutex.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.15-rc6-mx-new/include/asm-xtensa/mutex.h	2005-12-22 22:38:56.000000000 +0100
@@ -0,0 +1,10 @@
+/*
+ * Pull in the generic wrappers for __mutex_fastpath_lock() and
+ * __mutex_fastpath_unlock().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based
+ * generic implementation.
+ */
+
+#include <asm-generic/mutex-dec.h>
diff -purN linux-2.6.15-rc6-mx/kernel/mutex.c linux-2.6.15-rc6-mx-new/kernel/mutex.c
--- linux-2.6.15-rc6-mx/kernel/mutex.c	2005-12-22 21:54:58.000000000 +0100
+++ linux-2.6.15-rc6-mx-new/kernel/mutex.c	2005-12-22 22:38:56.000000000 +0100
@@ -18,6 +18,8 @@
 #include <linux/kallsyms.h>
 #include <linux/interrupt.h>
 
+#include <asm/mutex.h>
+
 /*
  * Various debugging wrappers - they are mostly NOPs in the !DEBUG case:
  */
@@ -308,26 +310,17 @@ int fastcall mutex_trylock(struct mutex 
 static inline void __mutex_unlock_nonatomic(struct mutex *lock __IP_DECL__)
 {
 	DEBUG_WARN_ON(lock->owner != current_thread_info());
+
+	spin_lock_mutex(&lock->wait_lock);
+
 	/*
-	 * Set it back to 'unlocked' early. We can do this outside the
-	 * lock, because we are in the slowpath for sure, so we'll have a
-	 * waiter in flight (later on, if necessary), and if some other
-	 * task comes around, let it steal the lock - we'll cope with it.
-	 * Waiters take care of themselves and stay in flight until
-	 * necessary.
-	 *
-	 * (in the xchg based implementation the fastpath has set the
-	 *  count to 1 already, so we must not set it here, because we
-	 *  dont own the lock anymore. In the debug case we must set
-	 *  the lock inside the spinlock.)
+	 * some architectures leave the lock unlocked in the fastpath failure
+	 * case, others need to leave it locked. In the later case we have to
+	 * unlock it here
 	 */
-#if !defined(CONFIG_MUTEX_XCHG_ALGORITHM) && !defined(CONFIG_DEBUG_MUTEXES)
-	atomic_set(&lock->count, 1);
-#endif
-	spin_lock_mutex(&lock->wait_lock);
-#ifdef CONFIG_DEBUG_MUTEXES
-	atomic_set(&lock->count, 1);
-#endif
+	if (__mutex_slowpath_needs_to_unlock())
+		atomic_set(&lock->count, 1);
+
 	debug_mutex_unlock(lock);
 
 	if (!list_empty(&lock->wait_list))
@@ -358,12 +351,7 @@ static __sched void FASTCALL(__mutex_loc
  */
 static inline void __mutex_lock_atomic(struct mutex *lock)
 {
-#ifdef CONFIG_MUTEX_XCHG_ALGORITHM
-	if (unlikely(atomic_xchg(&lock->count, 0) != 1))
-		__mutex_lock_noinline(&lock->count);
-#else
-	atomic_dec_call_if_negative(&lock->count, __mutex_lock_noinline);
-#endif
+	__mutex_fastpath_lock(&lock->count, __mutex_lock_noinline)
 }
 
 /*
@@ -385,13 +373,8 @@ static inline void __mutex_lock(struct m
 
 static inline int __mutex_lock_interruptible(struct mutex *lock)
 {
-#ifdef CONFIG_MUTEX_XCHG_ALGORITHM
-	if (unlikely(atomic_xchg(&lock->count, 0) != 1))
-		return __mutex_lock_interruptible_nonatomic(lock);
-#else
-	if (unlikely(atomic_dec_return(&lock->count) < 0))
-		return __mutex_lock_interruptible_nonatomic(lock);
-#endif
+	return __mutex_fastpath_lock_retval
+			(&lock->count, __mutex_lock_interruptible_nonatomic);	
 	return 0;
 }
 
@@ -403,12 +386,7 @@ static void __sched FASTCALL(__mutex_unl
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


