Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030220AbVLVPlc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030220AbVLVPlc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 10:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030216AbVLVPlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 10:41:23 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:49816 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751163AbVLVPiq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 10:38:46 -0500
Date: Thu, 22 Dec 2005 16:37:49 +0100
From: Ingo Molnar <mingo@elte.hu>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [patch 04/10] mutex subsystem, add atomic_*_call_if_*() defaults to the remaining arches
Message-ID: <20051222153749.GE6090@elte.hu>
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

add asm-generic/atomic-call-if.h, and make all remaining arches use it.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 include/asm-alpha/atomic.h           |   11 ++++++++++
 include/asm-arm/atomic.h             |   11 ++++++++++
 include/asm-arm26/atomic.h           |   11 ++++++++++
 include/asm-cris/atomic.h            |   11 ++++++++++
 include/asm-frv/atomic.h             |   11 ++++++++++
 include/asm-generic/atomic-call-if.h |   37 +++++++++++++++++++++++++++++++++++
 include/asm-h8300/atomic.h           |   11 ++++++++++
 include/asm-ia64/atomic.h            |   11 ++++++++++
 include/asm-m32r/atomic.h            |   11 ++++++++++
 include/asm-m68k/atomic.h            |   11 ++++++++++
 include/asm-m68knommu/atomic.h       |   11 ++++++++++
 include/asm-mips/atomic.h            |   11 ++++++++++
 include/asm-parisc/atomic.h          |   11 ++++++++++
 include/asm-powerpc/atomic.h         |   22 ++++++++++++++++++++
 include/asm-s390/atomic.h            |   11 ++++++++++
 include/asm-sh/atomic.h              |   11 ++++++++++
 include/asm-sh64/atomic.h            |   11 ++++++++++
 include/asm-sparc/atomic.h           |   12 +++++++++++
 include/asm-sparc64/atomic.h         |   11 ++++++++++
 include/asm-v850/atomic.h            |   11 ++++++++++
 include/asm-xtensa/atomic.h          |   11 ++++++++++
 21 files changed, 269 insertions(+)

Index: linux/include/asm-alpha/atomic.h
===================================================================
--- linux.orig/include/asm-alpha/atomic.h
+++ linux/include/asm-alpha/atomic.h
@@ -178,6 +178,17 @@ static __inline__ long atomic64_sub_retu
 #define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
+/*
+ * Pull in the generic wrappers for atomic_dec_call_if_negative() and
+ * atomic_inc_call_if_nonpositive().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or enable CONFIG_MUTEX_XCHG_ALGORITHM
+ * to tell the generic mutex code to use the atomic_xchg() based
+ * fastpath implementation.
+ */
+#include <asm-generic/atomic-call-if.h>
+
 #define atomic_add_unless(v, a, u)				\
 ({								\
 	int c, old;						\
Index: linux/include/asm-arm/atomic.h
===================================================================
--- linux.orig/include/asm-arm/atomic.h
+++ linux/include/asm-arm/atomic.h
@@ -177,6 +177,17 @@ static inline void atomic_clear_mask(uns
 
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
+/*
+ * Pull in the generic wrappers for atomic_dec_call_if_negative() and
+ * atomic_inc_call_if_nonpositive().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or enable CONFIG_MUTEX_XCHG_ALGORITHM
+ * to tell the generic mutex code to use the atomic_xchg() based
+ * fastpath implementation.
+ */
+#include <asm-generic/atomic-call-if.h>
+
 static inline int atomic_add_unless(atomic_t *v, int a, int u)
 {
 	int c, old;
Index: linux/include/asm-arm26/atomic.h
===================================================================
--- linux.orig/include/asm-arm26/atomic.h
+++ linux/include/asm-arm26/atomic.h
@@ -78,6 +78,17 @@ static inline int atomic_cmpxchg(atomic_
 
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
+/*
+ * Pull in the generic wrappers for atomic_dec_call_if_negative() and
+ * atomic_inc_call_if_nonpositive().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or enable CONFIG_MUTEX_XCHG_ALGORITHM
+ * to tell the generic mutex code to use the atomic_xchg() based
+ * fastpath implementation.
+ */
+#include <asm-generic/atomic-call-if.h>
+
 static inline int atomic_add_unless(atomic_t *v, int a, int u)
 {
 	int ret;
Index: linux/include/asm-cris/atomic.h
===================================================================
--- linux.orig/include/asm-cris/atomic.h
+++ linux/include/asm-cris/atomic.h
@@ -138,6 +138,17 @@ static inline int atomic_cmpxchg(atomic_
 
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
+/*
+ * Pull in the generic wrappers for atomic_dec_call_if_negative() and
+ * atomic_inc_call_if_nonpositive().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or enable CONFIG_MUTEX_XCHG_ALGORITHM
+ * to tell the generic mutex code to use the atomic_xchg() based
+ * fastpath implementation.
+ */
+#include <asm-generic/atomic-call-if.h>
+
 static inline int atomic_add_unless(atomic_t *v, int a, int u)
 {
 	int ret;
Index: linux/include/asm-frv/atomic.h
===================================================================
--- linux.orig/include/asm-frv/atomic.h
+++ linux/include/asm-frv/atomic.h
@@ -417,6 +417,17 @@ extern uint32_t __cmpxchg_32(uint32_t *v
 #define atomic_cmpxchg(v, old, new) ((int)cmpxchg(&((v)->counter), old, new))
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
+/*
+ * Pull in the generic wrappers for atomic_dec_call_if_negative() and
+ * atomic_inc_call_if_nonpositive().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or enable CONFIG_MUTEX_XCHG_ALGORITHM
+ * to tell the generic mutex code to use the atomic_xchg() based
+ * fastpath implementation.
+ */
+#include <asm-generic/atomic-call-if.h>
+
 #define atomic_add_unless(v, a, u)				\
 ({								\
 	int c, old;						\
Index: linux/include/asm-generic/atomic-call-if.h
===================================================================
--- /dev/null
+++ linux/include/asm-generic/atomic-call-if.h
@@ -0,0 +1,37 @@
+/*
+ * asm-generic/atomic-call-if.h
+ *
+ * Generic wrappers for atomic_dec_call_if_negative() and
+ * atomic_inc_call_if_nonpositive(), based on atomic_dec_return()
+ * and atomic_inc_return().
+ */
+#ifndef _ASM_GENERIC_ATOMIC_CALL_IF_H
+#define _ASM_GENERIC_ATOMIC_CALL_IF_H
+
+/**
+ * atomic_dec_call_if_negative - decrement and call function if negative
+ * @v: pointer of type atomic_t
+ * @fn: function to call if the result is negative
+ *
+ * Atomically decrements @v and calls a function if the result is negative.
+ */
+#define atomic_dec_call_if_negative(v, fn_name)				\
+do {									\
+	if (atomic_dec_return(v) < 0)					\
+		fn_name(v);						\
+} while (0)
+
+/**
+ * atomic_inc_call_if_nonpositive - increment and call function if nonpositive
+ * @v: pointer of type atomic_t
+ * @fn: function to call if the result is nonpositive
+ *
+ * Atomically increments @v and calls a function if the result is nonpositive.
+ */
+#define atomic_inc_call_if_nonpositive(v, fn_name)			\
+do {									\
+	if (atomic_inc_return(v) <= 0)					\
+		fn_name(v);						\
+} while (0)
+
+#endif
Index: linux/include/asm-h8300/atomic.h
===================================================================
--- linux.orig/include/asm-h8300/atomic.h
+++ linux/include/asm-h8300/atomic.h
@@ -97,6 +97,17 @@ static inline int atomic_cmpxchg(atomic_
 
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
+/*
+ * Pull in the generic wrappers for atomic_dec_call_if_negative() and
+ * atomic_inc_call_if_nonpositive().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or enable CONFIG_MUTEX_XCHG_ALGORITHM
+ * to tell the generic mutex code to use the atomic_xchg() based
+ * fastpath implementation.
+ */
+#include <asm-generic/atomic-call-if.h>
+
 static inline int atomic_add_unless(atomic_t *v, int a, int u)
 {
 	int ret;
Index: linux/include/asm-ia64/atomic.h
===================================================================
--- linux.orig/include/asm-ia64/atomic.h
+++ linux/include/asm-ia64/atomic.h
@@ -91,6 +91,17 @@ ia64_atomic64_sub (__s64 i, atomic64_t *
 #define atomic_cmpxchg(v, old, new) ((int)cmpxchg(&((v)->counter), old, new))
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
+/*
+ * Pull in the generic wrappers for atomic_dec_call_if_negative() and
+ * atomic_inc_call_if_nonpositive().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or enable CONFIG_MUTEX_XCHG_ALGORITHM
+ * to tell the generic mutex code to use the atomic_xchg() based
+ * fastpath implementation.
+ */
+#include <asm-generic/atomic-call-if.h>
+
 #define atomic_add_unless(v, a, u)				\
 ({								\
 	int c, old;						\
Index: linux/include/asm-m32r/atomic.h
===================================================================
--- linux.orig/include/asm-m32r/atomic.h
+++ linux/include/asm-m32r/atomic.h
@@ -245,6 +245,17 @@ static __inline__ int atomic_dec_return(
 #define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
+/*
+ * Pull in the generic wrappers for atomic_dec_call_if_negative() and
+ * atomic_inc_call_if_nonpositive().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or enable CONFIG_MUTEX_XCHG_ALGORITHM
+ * to tell the generic mutex code to use the atomic_xchg() based
+ * fastpath implementation.
+ */
+#include <asm-generic/atomic-call-if.h>
+
 /**
  * atomic_add_unless - add unless the number is a given value
  * @v: pointer of type atomic_t
Index: linux/include/asm-m68k/atomic.h
===================================================================
--- linux.orig/include/asm-m68k/atomic.h
+++ linux/include/asm-m68k/atomic.h
@@ -142,6 +142,17 @@ static inline void atomic_set_mask(unsig
 #define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
+/*
+ * Pull in the generic wrappers for atomic_dec_call_if_negative() and
+ * atomic_inc_call_if_nonpositive().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or enable CONFIG_MUTEX_XCHG_ALGORITHM
+ * to tell the generic mutex code to use the atomic_xchg() based
+ * fastpath implementation.
+ */
+#include <asm-generic/atomic-call-if.h>
+
 #define atomic_add_unless(v, a, u)				\
 ({								\
 	int c, old;						\
Index: linux/include/asm-m68knommu/atomic.h
===================================================================
--- linux.orig/include/asm-m68knommu/atomic.h
+++ linux/include/asm-m68knommu/atomic.h
@@ -131,6 +131,17 @@ static inline int atomic_sub_return(int 
 #define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
+/*
+ * Pull in the generic wrappers for atomic_dec_call_if_negative() and
+ * atomic_inc_call_if_nonpositive().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or enable CONFIG_MUTEX_XCHG_ALGORITHM
+ * to tell the generic mutex code to use the atomic_xchg() based
+ * fastpath implementation.
+ */
+#include <asm-generic/atomic-call-if.h>
+
 #define atomic_add_unless(v, a, u)				\
 ({								\
 	int c, old;						\
Index: linux/include/asm-mips/atomic.h
===================================================================
--- linux.orig/include/asm-mips/atomic.h
+++ linux/include/asm-mips/atomic.h
@@ -291,6 +291,17 @@ static __inline__ int atomic_sub_if_posi
 #define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
+/*
+ * Pull in the generic wrappers for atomic_dec_call_if_negative() and
+ * atomic_inc_call_if_nonpositive().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or enable CONFIG_MUTEX_XCHG_ALGORITHM
+ * to tell the generic mutex code to use the atomic_xchg() based
+ * fastpath implementation.
+ */
+#include <asm-generic/atomic-call-if.h>
+
 /**
  * atomic_add_unless - add unless the number is a given value
  * @v: pointer of type atomic_t
Index: linux/include/asm-parisc/atomic.h
===================================================================
--- linux.orig/include/asm-parisc/atomic.h
+++ linux/include/asm-parisc/atomic.h
@@ -167,6 +167,17 @@ static __inline__ int atomic_read(const 
 #define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
+/*
+ * Pull in the generic wrappers for atomic_dec_call_if_negative() and
+ * atomic_inc_call_if_nonpositive().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or enable CONFIG_MUTEX_XCHG_ALGORITHM
+ * to tell the generic mutex code to use the atomic_xchg() based
+ * fastpath implementation.
+ */
+#include <asm-generic/atomic-call-if.h>
+
 /**
  * atomic_add_unless - add unless the number is a given value
  * @v: pointer of type atomic_t
Index: linux/include/asm-powerpc/atomic.h
===================================================================
--- linux.orig/include/asm-powerpc/atomic.h
+++ linux/include/asm-powerpc/atomic.h
@@ -121,6 +121,17 @@ static __inline__ int atomic_inc_return(
 }
 
 /*
+ * Pull in the generic wrappers for atomic_dec_call_if_negative() and
+ * atomic_inc_call_if_nonpositive().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or enable CONFIG_MUTEX_XCHG_ALGORITHM
+ * to tell the generic mutex code to use the atomic_xchg() based
+ * fastpath implementation.
+ */
+#include <asm-generic/atomic-call-if.h>
+
+/*
  * atomic_inc_and_test - increment and test
  * @v: pointer of type atomic_t
  *
@@ -167,6 +178,17 @@ static __inline__ int atomic_dec_return(
 #define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
+/*
+ * Pull in the generic wrappers for atomic_dec_call_if_negative() and
+ * atomic_inc_call_if_nonpositive().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or enable CONFIG_MUTEX_XCHG_ALGORITHM
+ * to tell the generic mutex code to use the atomic_xchg() based
+ * fastpath implementation.
+ */
+#include <asm-generic/atomic-call-if.h>
+
 /**
  * atomic_add_unless - add unless the number is a given value
  * @v: pointer of type atomic_t
Index: linux/include/asm-s390/atomic.h
===================================================================
--- linux.orig/include/asm-s390/atomic.h
+++ linux/include/asm-s390/atomic.h
@@ -201,6 +201,17 @@ atomic_compare_and_swap(int expected_old
 #define atomic_cmpxchg(v, o, n) (atomic_compare_and_swap((o), (n), &((v)->counter)))
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
+/*
+ * Pull in the generic wrappers for atomic_dec_call_if_negative() and
+ * atomic_inc_call_if_nonpositive().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or enable CONFIG_MUTEX_XCHG_ALGORITHM
+ * to tell the generic mutex code to use the atomic_xchg() based
+ * fastpath implementation.
+ */
+#include <asm-generic/atomic-call-if.h>
+
 #define atomic_add_unless(v, a, u)				\
 ({								\
 	int c, old;						\
Index: linux/include/asm-sh/atomic.h
===================================================================
--- linux.orig/include/asm-sh/atomic.h
+++ linux/include/asm-sh/atomic.h
@@ -103,6 +103,17 @@ static inline int atomic_cmpxchg(atomic_
 
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
+/*
+ * Pull in the generic wrappers for atomic_dec_call_if_negative() and
+ * atomic_inc_call_if_nonpositive().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or enable CONFIG_MUTEX_XCHG_ALGORITHM
+ * to tell the generic mutex code to use the atomic_xchg() based
+ * fastpath implementation.
+ */
+#include <asm-generic/atomic-call-if.h>
+
 static inline int atomic_add_unless(atomic_t *v, int a, int u)
 {
 	int ret;
Index: linux/include/asm-sh64/atomic.h
===================================================================
--- linux.orig/include/asm-sh64/atomic.h
+++ linux/include/asm-sh64/atomic.h
@@ -115,6 +115,17 @@ static inline int atomic_cmpxchg(atomic_
 
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
+/*
+ * Pull in the generic wrappers for atomic_dec_call_if_negative() and
+ * atomic_inc_call_if_nonpositive().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or enable CONFIG_MUTEX_XCHG_ALGORITHM
+ * to tell the generic mutex code to use the atomic_xchg() based
+ * fastpath implementation.
+ */
+#include <asm-generic/atomic-call-if.h>
+
 static inline int atomic_add_unless(atomic_t *v, int a, int u)
 {
 	int ret;
Index: linux/include/asm-sparc/atomic.h
===================================================================
--- linux.orig/include/asm-sparc/atomic.h
+++ linux/include/asm-sparc/atomic.h
@@ -21,6 +21,18 @@ typedef struct { volatile int counter; }
 extern int __atomic_add_return(int, atomic_t *);
 extern int atomic_cmpxchg(atomic_t *, int, int);
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
+
+/*
+ * Pull in the generic wrappers for atomic_dec_call_if_negative() and
+ * atomic_inc_call_if_nonpositive().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or enable CONFIG_MUTEX_XCHG_ALGORITHM
+ * to tell the generic mutex code to use the atomic_xchg() based
+ * fastpath implementation.
+ */
+#include <asm-generic/atomic-call-if.h>
+
 extern int atomic_add_unless(atomic_t *, int, int);
 extern void atomic_set(atomic_t *, int);
 
Index: linux/include/asm-sparc64/atomic.h
===================================================================
--- linux.orig/include/asm-sparc64/atomic.h
+++ linux/include/asm-sparc64/atomic.h
@@ -74,6 +74,17 @@ extern int atomic64_sub_ret(int, atomic6
 #define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
+/*
+ * Pull in the generic wrappers for atomic_dec_call_if_negative() and
+ * atomic_inc_call_if_nonpositive().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or enable CONFIG_MUTEX_XCHG_ALGORITHM
+ * to tell the generic mutex code to use the atomic_xchg() based
+ * fastpath implementation.
+ */
+#include <asm-generic/atomic-call-if.h>
+
 #define atomic_add_unless(v, a, u)				\
 ({								\
 	int c, old;						\
Index: linux/include/asm-v850/atomic.h
===================================================================
--- linux.orig/include/asm-v850/atomic.h
+++ linux/include/asm-v850/atomic.h
@@ -106,6 +106,17 @@ static inline int atomic_cmpxchg(atomic_
 
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
+/*
+ * Pull in the generic wrappers for atomic_dec_call_if_negative() and
+ * atomic_inc_call_if_nonpositive().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or enable CONFIG_MUTEX_XCHG_ALGORITHM
+ * to tell the generic mutex code to use the atomic_xchg() based
+ * fastpath implementation.
+ */
+#include <asm-generic/atomic-call-if.h>
+
 static inline int atomic_add_unless(atomic_t *v, int a, int u)
 {
 	int ret;
Index: linux/include/asm-xtensa/atomic.h
===================================================================
--- linux.orig/include/asm-xtensa/atomic.h
+++ linux/include/asm-xtensa/atomic.h
@@ -226,6 +226,17 @@ static inline int atomic_sub_return(int 
 #define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
+/*
+ * Pull in the generic wrappers for atomic_dec_call_if_negative() and
+ * atomic_inc_call_if_nonpositive().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or enable CONFIG_MUTEX_XCHG_ALGORITHM
+ * to tell the generic mutex code to use the atomic_xchg() based
+ * fastpath implementation.
+ */
+#include <asm-generic/atomic-call-if.h>
+
 /**
  * atomic_add_unless - add unless the number is a given value
  * @v: pointer of type atomic_t
