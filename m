Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317189AbSH0TdR>; Tue, 27 Aug 2002 15:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317191AbSH0TdR>; Tue, 27 Aug 2002 15:33:17 -0400
Received: from tolkor.sgi.com ([192.48.180.13]:34254 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S317189AbSH0TdM>;
	Tue, 27 Aug 2002 15:33:12 -0400
From: Dean Nelson <dcn@sgi.com>
Message-Id: <200208271937.OAA78345@cyan.americas.sgi.com>
Date: Tue, 27 Aug 2002 14:37:27 -0500 (CDT)
To: linux-kernel@vger.kernel.org
Subject: atomic64_t proposal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm proposing the creation of an atomic64_t variable, which is a 64-bit
version of atomic_t, and the usage of the __typeof__ keyword in macro versions
of the atomic operations to enable them to operate on either type (atomic_t and
atomic64_t).

I submitted the following patch to David Mosberger to be considered for
inclusion in the IA-64 linux kernel. He suggested that I bring the topic up
on this list so that the other 64-bit platform maintainers can commment.

Thanks,
Dean


 ==============================================================================
diff -Naur 2.4.18-ia64/linux/include/asm-ia64/atomic.h linux/linux/include/asm-ia64/atomic.h
--- 2.4.18-ia64/linux/include/asm-ia64/atomic.h	Wed Jul 17 07:12:34 2002
+++ linux/linux/include/asm-ia64/atomic.h	Wed Aug 21 18:12:13 2002
@@ -5,10 +5,6 @@
  * Atomic operations that C can't guarantee us.  Useful for
  * resource counting etc..
  *
- * NOTE: don't mess with the types below!  The "unsigned long" and
- * "int" types were carefully placed so as to ensure proper operation
- * of the macros.
- *
  * Copyright (C) 1998, 1999, 2002 Hewlett-Packard Co
  *	David Mosberger-Tang <davidm@hpl.hp.com>
  */
@@ -21,63 +17,59 @@
  * memory accesses are ordered.
  */
 typedef struct { volatile __s32 counter; } atomic_t;
+typedef struct { volatile __s64 counter; } atomic64_t;
 
 #define ATOMIC_INIT(i)		((atomic_t) { (i) })
+#define ATOMIC64_INIT(i)	((atomic64_t) { (i) })
 
 #define atomic_read(v)		((v)->counter)
 #define atomic_set(v,i)		(((v)->counter) = (i))
 
-static __inline__ int
-ia64_atomic_add (int i, atomic_t *v)
-{
-	__s32 old, new;
-	CMPXCHG_BUGCHECK_DECL
-
-	do {
-		CMPXCHG_BUGCHECK(v);
-		old = atomic_read(v);
-		new = old + i;
-	} while (ia64_cmpxchg("acq", v, old, old + i, sizeof(atomic_t)) != old);
-	return new;
-}
-
-static __inline__ int
-ia64_atomic_sub (int i, atomic_t *v)
-{
-	__s32 old, new;
-	CMPXCHG_BUGCHECK_DECL
-
-	do {
-		CMPXCHG_BUGCHECK(v);
-		old = atomic_read(v);
-		new = old - i;
-	} while (ia64_cmpxchg("acq", v, old, new, sizeof(atomic_t)) != old);
-	return new;
-}
+#define ia64_atomic_add(i,v)						\
+({									\
+	__typeof__((v)->counter) _old, _new;				\
+	CMPXCHG_BUGCHECK_DECL						\
+									\
+	do {								\
+		CMPXCHG_BUGCHECK(v);					\
+		_old = atomic_read(v);					\
+		_new = _old + (i);					\
+	} while (ia64_cmpxchg("acq", (v), _old, _new, sizeof(*(v))) != _old); \
+	(__typeof__((v)->counter)) _new;	/* return new value */	\
+})
+
+#define ia64_atomic_sub(i,v)						\
+({									\
+	__typeof__((v)->counter) _old, _new;				\
+	CMPXCHG_BUGCHECK_DECL						\
+									\
+	do {								\
+		CMPXCHG_BUGCHECK(v);					\
+		_old = atomic_read(v);					\
+		_new = _old - (i);					\
+	} while (ia64_cmpxchg("acq", (v), _old, _new, sizeof(*(v))) != _old); \
+	(__typeof__((v)->counter)) _new;	/* return new value */	\
+})
 
 /*
  * Atomically add I to V and return TRUE if the resulting value is
  * negative.
  */
-static __inline__ int
-atomic_add_negative (int i, atomic_t *v)
-{
-	return ia64_atomic_add(i, v) < 0;
-}
+#define atomic_add_negative(i,v)	(ia64_atomic_add((i), (v)) < 0)
 
 #define atomic_add_return(i,v)						\
 	((__builtin_constant_p(i) &&					\
 	  (   (i ==  1) || (i ==  4) || (i ==  8) || (i ==  16)		\
 	   || (i == -1) || (i == -4) || (i == -8) || (i == -16)))	\
 	 ? ia64_fetch_and_add(i, &(v)->counter)				\
-	 : ia64_atomic_add(i, v))
+	 : ia64_atomic_add((i), (v)))
 
 #define atomic_sub_return(i,v)						\
 	((__builtin_constant_p(i) &&					\
 	  (   (i ==  1) || (i ==  4) || (i ==  8) || (i ==  16)		\
 	   || (i == -1) || (i == -4) || (i == -8) || (i == -16)))	\
 	 ? ia64_fetch_and_add(-(i), &(v)->counter)			\
-	 : ia64_atomic_sub(i, v))
+	 : ia64_atomic_sub((i), (v)))
 
 #define atomic_dec_return(v)		atomic_sub_return(1, (v))
 #define atomic_inc_return(v)		atomic_add_return(1, (v))
 ==============================================================================

