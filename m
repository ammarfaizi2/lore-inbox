Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbVKUWFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbVKUWFq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 17:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbVKUWFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 17:05:16 -0500
Received: from gold.veritas.com ([143.127.12.110]:59307 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751117AbVKUWFO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 17:05:14 -0500
Date: Mon, 21 Nov 2005 20:38:10 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Richard Henderson <rth@twiddle.net>,
       "David S. Miller" <davem@davemloft.net>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] mm: fill arch atomic64 gaps
In-Reply-To: <Pine.LNX.4.61.0511212025220.19274@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0511212036340.19274@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511212025220.19274@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 21 Nov 2005 20:38:00.0974 (UTC) FILETIME=[76E2A2E0:01C5EEDB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alpha, sparc64, x86_64 are each missing some primitives from their
atomic64 support: fill in the gaps I've noticed by extrapolating asm,
follow the groupings in each file.  But powerpc and parisc still lack
atomic64.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 include/asm-alpha/atomic.h   |    7 ++++-
 include/asm-sparc64/atomic.h |    1 
 include/asm-x86_64/atomic.h  |   51 ++++++++++++++++++++++++++++++++-----------
 3 files changed, 44 insertions(+), 15 deletions(-)

--- 2.6.15-rc2/include/asm-alpha/atomic.h	2005-11-20 19:44:12.000000000 +0000
+++ linux/include/asm-alpha/atomic.h	2005-11-21 18:52:03.000000000 +0000
@@ -118,8 +118,6 @@ static __inline__ long atomic_add_return
 	return result;
 }
 
-#define atomic_add_negative(a, v)	(atomic_add_return((a), (v)) < 0)
-
 static __inline__ long atomic64_add_return(long i, atomic64_t * v)
 {
 	long temp, result;
@@ -189,6 +187,9 @@ static __inline__ long atomic64_sub_retu
 })
 #define atomic_inc_not_zero(v) atomic_add_unless((v), 1, 0)
 
+#define atomic_add_negative(a, v) (atomic_add_return((a), (v)) < 0)
+#define atomic64_add_negative(a, v) (atomic64_add_return((a), (v)) < 0)
+
 #define atomic_dec_return(v) atomic_sub_return(1,(v))
 #define atomic64_dec_return(v) atomic64_sub_return(1,(v))
 
@@ -199,6 +200,8 @@ static __inline__ long atomic64_sub_retu
 #define atomic64_sub_and_test(i,v) (atomic64_sub_return((i), (v)) == 0)
 
 #define atomic_inc_and_test(v) (atomic_add_return(1, (v)) == 0)
+#define atomic64_inc_and_test(v) (atomic64_add_return(1, (v)) == 0)
+
 #define atomic_dec_and_test(v) (atomic_sub_return(1, (v)) == 0)
 #define atomic64_dec_and_test(v) (atomic64_sub_return(1, (v)) == 0)
 
--- 2.6.15-rc2/include/asm-sparc64/atomic.h	2005-11-20 19:44:19.000000000 +0000
+++ linux/include/asm-sparc64/atomic.h	2005-11-21 18:52:03.000000000 +0000
@@ -54,6 +54,7 @@ extern int atomic64_sub_ret(int, atomic6
  * other cases.
  */
 #define atomic_inc_and_test(v) (atomic_inc_return(v) == 0)
+#define atomic64_inc_and_test(v) (atomic64_inc_return(v) == 0)
 
 #define atomic_sub_and_test(i, v) (atomic_sub_ret(i, v) == 0)
 #define atomic64_sub_and_test(i, v) (atomic64_sub_ret(i, v) == 0)
--- 2.6.15-rc2/include/asm-x86_64/atomic.h	2005-11-20 19:44:20.000000000 +0000
+++ linux/include/asm-x86_64/atomic.h	2005-11-21 18:52:03.000000000 +0000
@@ -160,8 +160,8 @@ static __inline__ int atomic_inc_and_tes
 
 /**
  * atomic_add_negative - add and test if negative
- * @v: pointer of type atomic_t
  * @i: integer value to add
+ * @v: pointer of type atomic_t
  * 
  * Atomically adds @i to @v and returns true
  * if the result is negative, or false when
@@ -178,6 +178,31 @@ static __inline__ int atomic_add_negativ
 	return c;
 }
 
+/**
+ * atomic_add_return - add and return
+ * @i: integer value to add
+ * @v: pointer of type atomic_t
+ *
+ * Atomically adds @i to @v and returns @i + @v
+ */
+static __inline__ int atomic_add_return(int i, atomic_t *v)
+{
+	int __i = i;
+	__asm__ __volatile__(
+		LOCK "xaddl %0, %1;"
+		:"=r"(i)
+		:"m"(v->counter), "0"(i));
+	return i + __i;
+}
+
+static __inline__ int atomic_sub_return(int i, atomic_t *v)
+{
+	return atomic_add_return(-i,v);
+}
+
+#define atomic_inc_return(v)  (atomic_add_return(1,v))
+#define atomic_dec_return(v)  (atomic_sub_return(1,v))
+
 /* An 64bit atomic type */
 
 typedef struct { volatile long counter; } atomic64_t;
@@ -320,14 +345,14 @@ static __inline__ int atomic64_inc_and_t
 
 /**
  * atomic64_add_negative - add and test if negative
- * @v: pointer to atomic64_t
  * @i: integer value to add
+ * @v: pointer to type atomic64_t
  *
  * Atomically adds @i to @v and returns true
  * if the result is negative, or false when
  * result is greater than or equal to zero.
  */
-static __inline__ long atomic64_add_negative(long i, atomic64_t *v)
+static __inline__ int atomic64_add_negative(long i, atomic64_t *v)
 {
 	unsigned char c;
 
@@ -339,27 +364,30 @@ static __inline__ long atomic64_add_nega
 }
 
 /**
- * atomic_add_return - add and return
- * @v: pointer of type atomic_t
+ * atomic64_add_return - add and return
  * @i: integer value to add
+ * @v: pointer to type atomic64_t
  *
  * Atomically adds @i to @v and returns @i + @v
  */
-static __inline__ int atomic_add_return(int i, atomic_t *v)
+static __inline__ long atomic64_add_return(long i, atomic64_t *v)
 {
-	int __i = i;
+	long __i = i;
 	__asm__ __volatile__(
-		LOCK "xaddl %0, %1;"
+		LOCK "xaddq %0, %1;"
 		:"=r"(i)
 		:"m"(v->counter), "0"(i));
 	return i + __i;
 }
 
-static __inline__ int atomic_sub_return(int i, atomic_t *v)
+static __inline__ long atomic64_sub_return(long i, atomic64_t *v)
 {
-	return atomic_add_return(-i,v);
+	return atomic64_add_return(-i,v);
 }
 
+#define atomic64_inc_return(v)  (atomic64_add_return(1,v))
+#define atomic64_dec_return(v)  (atomic64_sub_return(1,v))
+
 #define atomic_cmpxchg(v, old, new) ((int)cmpxchg(&((v)->counter), old, new))
 
 /**
@@ -381,9 +409,6 @@ static __inline__ int atomic_sub_return(
 })
 #define atomic_inc_not_zero(v) atomic_add_unless((v), 1, 0)
 
-#define atomic_inc_return(v)  (atomic_add_return(1,v))
-#define atomic_dec_return(v)  (atomic_sub_return(1,v))
-
 /* These are x86-specific, used by some header files */
 #define atomic_clear_mask(mask, addr) \
 __asm__ __volatile__(LOCK "andl %0,%1" \
