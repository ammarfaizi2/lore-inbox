Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751495AbVKJB5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbVKJB5j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 20:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbVKJB5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 20:57:39 -0500
Received: from gold.veritas.com ([143.127.12.110]:53 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751495AbVKJB5i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 20:57:38 -0500
Date: Thu, 10 Nov 2005 01:56:26 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Richard Henderson <rth@twiddle.net>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       "David S. Miller" <davem@davemloft.net>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 09/15] mm: fill arch atomic64 gaps
In-Reply-To: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0511100153350.5814@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 10 Nov 2005 01:57:37.0932 (UTC) FILETIME=[204934C0:01C5E59A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alpha, s390, sparc64, x86_64 are each missing some primitives from their
atomic64 support: fill in the gaps I've noticed by extrapolating asm,
follow the groupings in each file, and say "int" for the booleans rather
than long or long long.  But powerpc and parisc still have no atomic64.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 include/asm-alpha/atomic.h   |    7 ++++--
 include/asm-s390/atomic.h    |   10 ++++++--
 include/asm-sparc64/atomic.h |    1 
 include/asm-x86_64/atomic.h  |   49 ++++++++++++++++++++++++++++++++-----------
 4 files changed, 50 insertions(+), 17 deletions(-)

--- mm08/include/asm-alpha/atomic.h	2005-10-28 01:02:08.000000000 +0100
+++ mm09/include/asm-alpha/atomic.h	2005-11-09 14:39:48.000000000 +0000
@@ -118,8 +118,6 @@ static __inline__ long atomic_add_return
 	return result;
 }
 
-#define atomic_add_negative(a, v)	(atomic_add_return((a), (v)) < 0)
-
 static __inline__ long atomic64_add_return(long i, atomic64_t * v)
 {
 	long temp, result;
@@ -177,6 +175,9 @@ static __inline__ long atomic64_sub_retu
 	return result;
 }
 
+#define atomic_add_negative(a, v) (atomic_add_return((a), (v)) < 0)
+#define atomic64_add_negative(a, v) (atomic64_add_return((a), (v)) < 0)
+
 #define atomic_dec_return(v) atomic_sub_return(1,(v))
 #define atomic64_dec_return(v) atomic64_sub_return(1,(v))
 
@@ -187,6 +188,8 @@ static __inline__ long atomic64_sub_retu
 #define atomic64_sub_and_test(i,v) (atomic64_sub_return((i), (v)) == 0)
 
 #define atomic_inc_and_test(v) (atomic_add_return(1, (v)) == 0)
+#define atomic64_inc_and_test(v) (atomic64_add_return(1, (v)) == 0)
+
 #define atomic_dec_and_test(v) (atomic_sub_return(1, (v)) == 0)
 #define atomic64_dec_and_test(v) (atomic64_sub_return(1, (v)) == 0)
 
--- mm08/include/asm-s390/atomic.h	2005-08-29 00:41:01.000000000 +0100
+++ mm09/include/asm-s390/atomic.h	2005-11-09 14:39:48.000000000 +0000
@@ -131,7 +131,7 @@ static __inline__ long long atomic64_add
 {
 	return __CSG_LOOP(v, i, "agr");
 }
-static __inline__ long long atomic64_add_negative(long long i, atomic64_t * v)
+static __inline__ int atomic64_add_negative(long long i, atomic64_t * v)
 {
 	return __CSG_LOOP(v, i, "agr") < 0;
 }
@@ -139,6 +139,10 @@ static __inline__ void atomic64_sub(long
 {
 	       __CSG_LOOP(v, i, "sgr");
 }
+static __inline__ long long atomic64_sub_return(long long i, atomic64_t * v)
+{
+	return __CSG_LOOP(v, i, "sgr");
+}
 static __inline__ void atomic64_inc(volatile atomic64_t * v)
 {
 	       __CSG_LOOP(v, 1, "agr");
@@ -147,7 +151,7 @@ static __inline__ long long atomic64_inc
 {
 	return __CSG_LOOP(v, 1, "agr");
 }
-static __inline__ long long atomic64_inc_and_test(volatile atomic64_t * v)
+static __inline__ int atomic64_inc_and_test(volatile atomic64_t * v)
 {
 	return __CSG_LOOP(v, 1, "agr") == 0;
 }
@@ -159,7 +163,7 @@ static __inline__ long long atomic64_dec
 {
 	return __CSG_LOOP(v, 1, "sgr");
 }
-static __inline__ long long atomic64_dec_and_test(volatile atomic64_t * v)
+static __inline__ int atomic64_dec_and_test(volatile atomic64_t * v)
 {
 	return __CSG_LOOP(v, 1, "sgr") == 0;
 }
--- mm08/include/asm-sparc64/atomic.h	2005-10-28 01:02:08.000000000 +0100
+++ mm09/include/asm-sparc64/atomic.h	2005-11-09 14:39:48.000000000 +0000
@@ -54,6 +54,7 @@ extern int atomic64_sub_ret(int, atomic6
  * other cases.
  */
 #define atomic_inc_and_test(v) (atomic_inc_return(v) == 0)
+#define atomic64_inc_and_test(v) (atomic64_inc_return(v) == 0)
 
 #define atomic_sub_and_test(i, v) (atomic_sub_ret(i, v) == 0)
 #define atomic64_sub_and_test(i, v) (atomic64_sub_ret(i, v) == 0)
--- mm08/include/asm-x86_64/atomic.h	2004-12-24 21:37:29.000000000 +0000
+++ mm09/include/asm-x86_64/atomic.h	2005-11-09 14:39:48.000000000 +0000
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
+ * @v: pointer to atomic64_t
  *
  * Atomically adds @i to @v and returns true
  * if the result is negative, or false when
  * result is greater than or equal to zero.
  */
-static __inline__ long atomic64_add_negative(long i, atomic64_t *v)
+static __inline__ int atomic64_add_negative(long i, atomic64_t *v)
 {
 	unsigned char c;
 
@@ -339,29 +364,29 @@ static __inline__ long atomic64_add_nega
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
 
-#define atomic_inc_return(v)  (atomic_add_return(1,v))
-#define atomic_dec_return(v)  (atomic_sub_return(1,v))
+#define atomic64_inc_return(v)  (atomic64_add_return(1,v))
+#define atomic64_dec_return(v)  (atomic64_sub_return(1,v))
 
 /* These are x86-specific, used by some header files */
 #define atomic_clear_mask(mask, addr) \
