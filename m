Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbVLIS65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbVLIS65 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 13:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbVLIS65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 13:58:57 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:49080 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1750718AbVLIS64 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 13:58:56 -0500
Date: Fri, 9 Dec 2005 10:58:40 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       linux-ia64@ver.kernel.org
cc: ak@suse.de
Subject: [RFC] Introduce atomic_long_t
Message-ID: <Pine.LNX.4.62.0512091053260.2656@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Several counters already have the need to use 64 atomic variables on 64
bit platforms (see mm_counter_t in sched.h). We have to do ugly ifdefs to
fall back to 32 bit atomic on 32 bit platforms.

The VM statistics patch that I am working on will also need to make more 
extensive use of 64 bit counters when available.

This patch introduces a new type atomic_long_t that works similar to the c
"long" type. Its 32 bits on 32 bit platforms and 64 bits on 64 bit platforms.

The patch uses atomic_long_t to clean up the mess in include/linux/sched.h.
Implementations for all arches provided but only tested on ia64.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc5/include/linux/sched.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/sched.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/linux/sched.h	2005-12-09 10:22:54.000000000 -0800
@@ -254,25 +254,12 @@ extern void arch_unmap_area_topdown(stru
  * The mm counters are not protected by its page_table_lock,
  * so must be incremented atomically.
  */
-#ifdef ATOMIC64_INIT
-#define set_mm_counter(mm, member, value) atomic64_set(&(mm)->_##member, value)
-#define get_mm_counter(mm, member) ((unsigned long)atomic64_read(&(mm)->_##member))
-#define add_mm_counter(mm, member, value) atomic64_add(value, &(mm)->_##member)
-#define inc_mm_counter(mm, member) atomic64_inc(&(mm)->_##member)
-#define dec_mm_counter(mm, member) atomic64_dec(&(mm)->_##member)
-typedef atomic64_t mm_counter_t;
-#else /* !ATOMIC64_INIT */
-/*
- * The counters wrap back to 0 at 2^32 * PAGE_SIZE,
- * that is, at 16TB if using 4kB page size.
- */
-#define set_mm_counter(mm, member, value) atomic_set(&(mm)->_##member, value)
-#define get_mm_counter(mm, member) ((unsigned long)atomic_read(&(mm)->_##member))
-#define add_mm_counter(mm, member, value) atomic_add(value, &(mm)->_##member)
-#define inc_mm_counter(mm, member) atomic_inc(&(mm)->_##member)
-#define dec_mm_counter(mm, member) atomic_dec(&(mm)->_##member)
-typedef atomic_t mm_counter_t;
-#endif /* !ATOMIC64_INIT */
+#define set_mm_counter(mm, member, value) atomic_long_set(&(mm)->_##member, value)
+#define get_mm_counter(mm, member) ((unsigned long)atomic_long_read(&(mm)->_##member))
+#define add_mm_counter(mm, member, value) atomic_long_add(value, &(mm)->_##member)
+#define inc_mm_counter(mm, member) atomic_long_inc(&(mm)->_##member)
+#define dec_mm_counter(mm, member) atomic_long_dec(&(mm)->_##member)
+typedef atomic_long_t mm_counter_t;
 
 #else  /* NR_CPUS < CONFIG_SPLIT_PTLOCK_CPUS */
 /*
Index: linux-2.6.15-rc5/include/asm-ia64/atomic.h
===================================================================
--- linux-2.6.15-rc5.orig/include/asm-ia64/atomic.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/asm-ia64/atomic.h	2005-12-09 10:46:19.000000000 -0800
@@ -25,6 +25,7 @@ typedef struct { volatile __s64 counter;
 
 #define ATOMIC_INIT(i)		((atomic_t) { (i) })
 #define ATOMIC64_INIT(i)	((atomic64_t) { (i) })
+#define ATOMIC_LONG_INIT(i)	ATOMIC64_INIT(i)
 
 #define atomic_read(v)		((v)->counter)
 #define atomic64_read(v)	((v)->counter)
@@ -186,6 +187,14 @@ atomic64_add_negative (__s64 i, atomic64
 #define atomic64_inc(v)			atomic64_add(1, (v))
 #define atomic64_dec(v)			atomic64_sub(1, (v))
 
+#define atomic_long_t			atomic64_t
+#define atomic_long_read(v)		atomic64_read(v)
+#define atomic_long_set(v,i)		atomic64_set(v,i)
+#define atomic_long_inc(v)		atomic64_inc(v)
+#define atomic_long_dec(v)		atomic64_dec(v)
+#define atomic_long_add(i,v)		atomic64_add(i,v)
+#define atomic_long_sub(i,v)		atomic64_sub(i,v)
+
 /* Atomic operations are already serializing */
 #define smp_mb__before_atomic_dec()	barrier()
 #define smp_mb__after_atomic_dec()	barrier()
Index: linux-2.6.15-rc5/include/asm-x86_64/atomic.h
===================================================================
--- linux-2.6.15-rc5.orig/include/asm-x86_64/atomic.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/asm-x86_64/atomic.h	2005-12-09 10:48:23.000000000 -0800
@@ -418,6 +418,15 @@ __asm__ __volatile__(LOCK "andl %0,%1" \
 __asm__ __volatile__(LOCK "orl %0,%1" \
 : : "r" ((unsigned)mask),"m" (*(addr)) : "memory")
 
+#define ATOMIC_LONG_INIT(i)		ATOMIC64_INIT(i)
+#define atomic_long_t			atomic64_t
+#define atomic_long_read(v)		atomic64_read(v)
+#define atomic_long_set(v,i)		atomic64_set(v,i)
+#define atomic_long_inc(v)		atomic64_inc(v)
+#define atomic_long_dec(v)		atomic64_dec(v)
+#define atomic_long_add(i,v)		atomic64_add(i,v)
+#define atomic_long_sub(i,v)		atomic64_sub(i,v)
+
 /* Atomic operations are already serializing on x86 */
 #define smp_mb__before_atomic_dec()	barrier()
 #define smp_mb__after_atomic_dec()	barrier()
Index: linux-2.6.15-rc5/include/asm-i386/atomic.h
===================================================================
--- linux-2.6.15-rc5.orig/include/asm-i386/atomic.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/asm-i386/atomic.h	2005-12-09 10:46:02.000000000 -0800
@@ -248,6 +248,15 @@ __asm__ __volatile__(LOCK "andl %0,%1" \
 __asm__ __volatile__(LOCK "orl %0,%1" \
 : : "r" (mask),"m" (*(addr)) : "memory")
 
+#define ATOMIC_LONG_INIT(i)	ATOMIC_INIT(i)
+#define atomic_long_t		atomic_t
+#define atomic_long_read(v)	atomic_read(v)
+#define atomic_long_set(v,i)	atomic_set(v,i)
+#define atomic_long_inc(v)	atomic_inc(v)
+#define atomic_long_dec(v)	atomic_dec(v)
+#define atomic_long_add(i,v)	atomic_add(i,v)
+#define atomic_long_sub(i,v)	atomic_sub(i,v)
+
 /* Atomic operations are already serializing on x86 */
 #define smp_mb__before_atomic_dec()	barrier()
 #define smp_mb__after_atomic_dec()	barrier()
Index: linux-2.6.15-rc5/include/asm-m68k/atomic.h
===================================================================
--- linux-2.6.15-rc5.orig/include/asm-m68k/atomic.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/asm-m68k/atomic.h	2005-12-09 10:46:37.000000000 -0800
@@ -151,6 +151,15 @@ static inline void atomic_set_mask(unsig
 })
 #define atomic_inc_not_zero(v) atomic_add_unless((v), 1, 0)
 
+#define ATOMIC_LONG_INIT(i)	ATOMIC_INIT(i)
+#define atomic_long_t		atomic_t
+#define atomic_long_read(v)	atomic_read(v)
+#define atomic_long_set(v,i)	atomic_set(v,i)
+#define atomic_long_inc(v)	atomic_inc(v)
+#define atomic_long_dec(v)	atomic_dec(v)
+#define atomic_long_add(i,v)	atomic_add(i,v)
+#define atomic_long_sub(i,v)	atomic_sub(i,v)
+
 /* Atomic operations are already serializing */
 #define smp_mb__before_atomic_dec()	barrier()
 #define smp_mb__after_atomic_dec()	barrier()
Index: linux-2.6.15-rc5/include/asm-parisc/atomic.h
===================================================================
--- linux-2.6.15-rc5.orig/include/asm-parisc/atomic.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/asm-parisc/atomic.h	2005-12-09 10:47:09.000000000 -0800
@@ -211,6 +211,15 @@ static __inline__ int atomic_read(const 
 
 #define ATOMIC_INIT(i)	{ (i) }
 
+#define ATOMIC_LONG_INIT(i)	ATOMIC_INIT(i)
+#define atomic_long_t		atomic_t
+#define atomic_long_read(v)	atomic_read(v)
+#define atomic_long_set(v,i)	atomic_set(v,i)
+#define atomic_long_inc(v)	atomic_inc(v)
+#define atomic_long_dec(v)	atomic_dec(v)
+#define atomic_long_add(i,v)	atomic_add(i,v)
+#define atomic_long_sub(i,v)	atomic_sub(i,v)
+
 #define smp_mb__before_atomic_dec()	smp_mb()
 #define smp_mb__after_atomic_dec()	smp_mb()
 #define smp_mb__before_atomic_inc()	smp_mb()
Index: linux-2.6.15-rc5/include/asm-m32r/atomic.h
===================================================================
--- linux-2.6.15-rc5.orig/include/asm-m32r/atomic.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/asm-m32r/atomic.h	2005-12-09 10:46:32.000000000 -0800
@@ -307,6 +307,15 @@ static __inline__ void atomic_set_mask(u
 	local_irq_restore(flags);
 }
 
+#define ATOMIC_LONG_INIT(i)	ATOMIC_INIT(i)
+#define atomic_long_t		atomic_t
+#define atomic_long_read(v)	atomic_read(v)
+#define atomic_long_set(v,i)	atomic_set(v,i)
+#define atomic_long_inc(v)	atomic_inc(v)
+#define atomic_long_dec(v)	atomic_dec(v)
+#define atomic_long_add(i,v)	atomic_add(i,v)
+#define atomic_long_sub(i,v)	atomic_sub(i,v)
+
 /* Atomic operations are already serializing on m32r */
 #define smp_mb__before_atomic_dec()	barrier()
 #define smp_mb__after_atomic_dec()	barrier()
Index: linux-2.6.15-rc5/include/asm-frv/atomic.h
===================================================================
--- linux-2.6.15-rc5.orig/include/asm-frv/atomic.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/asm-frv/atomic.h	2005-12-09 10:45:48.000000000 -0800
@@ -426,4 +426,13 @@ extern uint32_t __cmpxchg_32(uint32_t *v
 })
 #define atomic_inc_not_zero(v) atomic_add_unless((v), 1, 0)
 
+#define ATOMIC_LONG_INIT(i)	ATOMIC_INIT(i)
+#define atomic_long_t		atomic_t
+#define atomic_long_read(v)	atomic_read(v)
+#define atomic_long_set(v,i)	atomic_set(v,i)
+#define atomic_long_inc(v)	atomic_inc(v)
+#define atomic_long_dec(v)	atomic_dec(v)
+#define atomic_long_add(i,v)	atomic_add(i,v)
+#define atomic_long_sub(i,v)	atomic_sub(i,v)
+
 #endif /* _ASM_ATOMIC_H */
Index: linux-2.6.15-rc5/include/asm-cris/atomic.h
===================================================================
--- linux-2.6.15-rc5.orig/include/asm-cris/atomic.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/asm-cris/atomic.h	2005-12-09 10:45:43.000000000 -0800
@@ -150,6 +150,15 @@ static inline int atomic_add_unless(atom
 }
 #define atomic_inc_not_zero(v) atomic_add_unless((v), 1, 0)
 
+#define ATOMIC_LONG_INIT(i)	ATOMIC_INIT(i)
+#define atomic_long_t		atomic_t
+#define atomic_long_read(v)	atomic_read(v)
+#define atomic_long_set(v,i)	atomic_set(v,i)
+#define atomic_long_inc(v)	atomic_inc(v)
+#define atomic_long_dec(v)	atomic_dec(v)
+#define atomic_long_add(i,v)	atomic_add(i,v)
+#define atomic_long_sub(i,v)	atomic_sub(i,v)
+
 /* Atomic operations are already serializing */
 #define smp_mb__before_atomic_dec()    barrier()
 #define smp_mb__after_atomic_dec()     barrier()
Index: linux-2.6.15-rc5/include/asm-arm26/atomic.h
===================================================================
--- linux-2.6.15-rc5.orig/include/asm-arm26/atomic.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/asm-arm26/atomic.h	2005-12-09 10:45:09.000000000 -0800
@@ -100,6 +100,7 @@ static inline void atomic_clear_mask(uns
         local_irq_restore(flags);
 }
 
+#define ATOMIC_LONG_INIT(i)	ATOMIC_INIT(i)
 #define atomic_add(i, v)        (void) atomic_add_return(i, v)
 #define atomic_inc(v)           (void) atomic_add_return(1, v)
 #define atomic_sub(i, v)        (void) atomic_sub_return(i, v)
@@ -113,6 +114,15 @@ static inline void atomic_clear_mask(uns
 #define atomic_add_negative(i,v) (atomic_add_return(i, v) < 0)
 
 /* Atomic operations are already serializing on ARM26 */
+#define atomic_long_t		atomic_t
+#define atomic_long_read(v)	atomic_read(v)
+#define atomic_long_set(v,i)	atomic_set(v,i)
+#define atomic_long_inc(v)	atomic_inc(v)
+#define atomic_long_dec(v)	atomic_dec(v)
+#define atomic_long_add(i,v)	atomic_add(i,v)
+#define atomic_long_sub(i,v)	atomic_sub(i,v)
+
+
 #define smp_mb__before_atomic_dec()	barrier()
 #define smp_mb__after_atomic_dec()	barrier()
 #define smp_mb__before_atomic_inc()	barrier()
Index: linux-2.6.15-rc5/include/asm-sparc/atomic.h
===================================================================
--- linux-2.6.15-rc5.orig/include/asm-sparc/atomic.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/asm-sparc/atomic.h	2005-12-09 10:48:03.000000000 -0800
@@ -151,6 +151,15 @@ static inline int __atomic24_sub(int i, 
 
 #define atomic24_add_negative(i, v) (__atomic24_add((i), (v)) < 0)
 
+#define ATOMIC_LONG_INIT(i)	ATOMIC_INIT(i)
+#define atomic_long_t		atomic_t
+#define atomic_long_read(v)	atomic_read(v)
+#define atomic_long_set(v,i)	atomic_set(v,i)
+#define atomic_long_inc(v)	atomic_inc(v)
+#define atomic_long_dec(v)	atomic_dec(v)
+#define atomic_long_add(i,v)	atomic_add(i,v)
+#define atomic_long_sub(i,v)	atomic_sub(i,v)
+
 /* Atomic operations are already serializing */
 #define smp_mb__before_atomic_dec()	barrier()
 #define smp_mb__after_atomic_dec()	barrier()
Index: linux-2.6.15-rc5/include/asm-s390/atomic.h
===================================================================
--- linux-2.6.15-rc5.orig/include/asm-s390/atomic.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/asm-s390/atomic.h	2005-12-09 10:47:40.000000000 -0800
@@ -210,6 +210,15 @@ atomic_compare_and_swap(int expected_old
 })
 #define atomic_inc_not_zero(v) atomic_add_unless((v), 1, 0)
 
+#define ATOMIC_LONG_INIT(i)		ATOMIC64_INIT(i)
+#define atomic_long_t			atomic64_t
+#define atomic_long_read(v)		atomic64_read(v)
+#define atomic_long_set(v,i)		atomic64_set(v,i)
+#define atomic_long_inc(v)		atomic64_inc(v)
+#define atomic_long_dec(v)		atomic64_dec(v)
+#define atomic_long_add(i,v)		atomic64_add(i,v)
+#define atomic_long_sub(i,v)		atomic64_sub(i,v)
+
 #define smp_mb__before_atomic_dec()	smp_mb()
 #define smp_mb__after_atomic_dec()	smp_mb()
 #define smp_mb__before_atomic_inc()	smp_mb()
Index: linux-2.6.15-rc5/include/asm-h8300/atomic.h
===================================================================
--- linux-2.6.15-rc5.orig/include/asm-h8300/atomic.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/asm-h8300/atomic.h	2005-12-09 10:45:53.000000000 -0800
@@ -131,6 +131,15 @@ static __inline__ void atomic_set_mask(u
                              : "=m" (*v) : "g" (mask) :"er0","er1");
 }
 
+#define ATOMIC_LONG_INIT(i)	ATOMIC_INIT(i)
+#define atomic_long_t		atomic_t
+#define atomic_long_read(v)	atomic_read(v)
+#define atomic_long_set(v,i)	atomic_set(v,i)
+#define atomic_long_inc(v)	atomic_inc(v)
+#define atomic_long_dec(v)	atomic_dec(v)
+#define atomic_long_add(i,v)	atomic_add(i,v)
+#define atomic_long_sub(i,v)	atomic_sub(i,v)
+
 /* Atomic operations are already serializing */
 #define smp_mb__before_atomic_dec()    barrier()
 #define smp_mb__after_atomic_dec() barrier()
Index: linux-2.6.15-rc5/include/asm-arm/atomic.h
===================================================================
--- linux-2.6.15-rc5.orig/include/asm-arm/atomic.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/asm-arm/atomic.h	2005-12-09 10:45:21.000000000 -0800
@@ -199,6 +199,15 @@ static inline int atomic_add_unless(atom
 
 #define atomic_add_negative(i,v) (atomic_add_return(i, v) < 0)
 
+#define ATOMIC_LONG_INIT(i)	ATOMIC_INIT(i)
+#define atomic_long_t		atomic_t
+#define atomic_long_read(v)	atomic_read(v)
+#define atomic_long_set(v,i)	atomic_set(v,i)
+#define atomic_long_inc(v)	atomic_inc(v)
+#define atomic_long_dec(v)	atomic_dec(v)
+#define atomic_long_add(i,v)	atomic_add(i,v)
+#define atomic_long_sub(i,v)	atomic_sub(i,v)
+
 /* Atomic operations are already serializing on ARM */
 #define smp_mb__before_atomic_dec()	barrier()
 #define smp_mb__after_atomic_dec()	barrier()
Index: linux-2.6.15-rc5/include/asm-alpha/atomic.h
===================================================================
--- linux-2.6.15-rc5.orig/include/asm-alpha/atomic.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/asm-alpha/atomic.h	2005-12-09 10:44:43.000000000 -0800
@@ -211,6 +211,15 @@ static __inline__ long atomic64_sub_retu
 #define atomic_dec(v) atomic_sub(1,(v))
 #define atomic64_dec(v) atomic64_sub(1,(v))
 
+#define ATOMIC_LONG_INIT(i)		ATOMIC64_INIT(i)
+#define atomic_long_t			atomic64_t
+#define atomic_long_read(v)		atomic64_read(v)
+#define atomic_long_set(v,i)		atomic64_set(v,i)
+#define atomic_long_inc(v)		atomic64_inc(v)
+#define atomic_long_dec(v)		atomic64_dec(v)
+#define atomic_long_add(i,v)		atomic64_add(i,v)
+#define atomic_long_sub(i,v)		atomic64_sub(i,v)
+
 #define smp_mb__before_atomic_dec()	smp_mb()
 #define smp_mb__after_atomic_dec()	smp_mb()
 #define smp_mb__before_atomic_inc()	smp_mb()
Index: linux-2.6.15-rc5/include/asm-sh64/atomic.h
===================================================================
--- linux-2.6.15-rc5.orig/include/asm-sh64/atomic.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/asm-sh64/atomic.h	2005-12-09 10:47:44.000000000 -0800
@@ -146,6 +146,15 @@ static __inline__ void atomic_set_mask(u
 	local_irq_restore(flags);
 }
 
+#define ATOMIC_LONG_INIT(i)	ATOMIC_INIT(i)
+#define atomic_long_t		atomic_t
+#define atomic_long_read(v)	atomic_read(v)
+#define atomic_long_set(v,i)	atomic_set(v,i)
+#define atomic_long_inc(v)	atomic_inc(v)
+#define atomic_long_dec(v)	atomic_dec(v)
+#define atomic_long_add(i,v)	atomic_add(i,v)
+#define atomic_long_sub(i,v)	atomic_sub(i,v)
+
 /* Atomic operations are already serializing on SH */
 #define smp_mb__before_atomic_dec()	barrier()
 #define smp_mb__after_atomic_dec()	barrier()
Index: linux-2.6.15-rc5/include/asm-v850/atomic.h
===================================================================
--- linux-2.6.15-rc5.orig/include/asm-v850/atomic.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/asm-v850/atomic.h	2005-12-09 10:48:14.000000000 -0800
@@ -120,6 +120,15 @@ static inline int atomic_add_unless(atom
 
 #define atomic_inc_not_zero(v) atomic_add_unless((v), 1, 0)
 
+#define ATOMIC_LONG_INIT(i)	ATOMIC_INIT(i)
+#define atomic_long_t		atomic_t
+#define atomic_long_read(v)	atomic_read(v)
+#define atomic_long_set(v,i)	atomic_set(v,i)
+#define atomic_long_inc(v)	atomic_inc(v)
+#define atomic_long_dec(v)	atomic_dec(v)
+#define atomic_long_add(i,v)	atomic_add(i,v)
+#define atomic_long_sub(i,v)	atomic_sub(i,v)
+
 /* Atomic operations are already serializing on ARM */
 #define smp_mb__before_atomic_dec()	barrier()
 #define smp_mb__after_atomic_dec()	barrier()
Index: linux-2.6.15-rc5/include/asm-sparc64/atomic.h
===================================================================
--- linux-2.6.15-rc5.orig/include/asm-sparc64/atomic.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/asm-sparc64/atomic.h	2005-12-09 10:47:59.000000000 -0800
@@ -83,6 +83,15 @@ extern int atomic64_sub_ret(int, atomic6
 })
 #define atomic_inc_not_zero(v) atomic_add_unless((v), 1, 0)
 
+#define ATOMIC_LONG_INIT(i)		ATOMIC64_INIT(i)
+#define atomic_long_t			atomic64_t
+#define atomic_long_read(v)		atomic64_read(v)
+#define atomic_long_set(v,i)		atomic64_set(v,i)
+#define atomic_long_inc(v)		atomic64_inc(v)
+#define atomic_long_dec(v)		atomic64_dec(v)
+#define atomic_long_add(i,v)		atomic64_add(i,v)
+#define atomic_long_sub(i,v)		atomic64_sub(i,v)
+
 /* Atomic operations are already serializing */
 #ifdef CONFIG_SMP
 #define smp_mb__before_atomic_dec()	membar_storeload_loadload();
Index: linux-2.6.15-rc5/include/asm-m68knommu/atomic.h
===================================================================
--- linux-2.6.15-rc5.orig/include/asm-m68knommu/atomic.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/asm-m68knommu/atomic.h	2005-12-09 10:46:41.000000000 -0800
@@ -143,4 +143,13 @@ static inline int atomic_sub_return(int 
 #define atomic_dec_return(v) atomic_sub_return(1,(v))
 #define atomic_inc_return(v) atomic_add_return(1,(v))
 
+#define ATOMIC_LONG_INIT(i)	ATOMIC_INIT(i)
+#define atomic_long_t		atomic_t
+#define atomic_long_read(v)	atomic_read(v)
+#define atomic_long_set(v,i)	atomic_set(v,i)
+#define atomic_long_inc(v)	atomic_inc(v)
+#define atomic_long_dec(v)	atomic_dec(v)
+#define atomic_long_add(i,v)	atomic_add(i,v)
+#define atomic_long_sub(i,v)	atomic_sub(i,v)
+
 #endif /* __ARCH_M68KNOMMU_ATOMIC __ */
Index: linux-2.6.15-rc5/include/asm-xtensa/atomic.h
===================================================================
--- linux-2.6.15-rc5.orig/include/asm-xtensa/atomic.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/asm-xtensa/atomic.h	2005-12-09 10:48:29.000000000 -0800
@@ -280,6 +280,15 @@ static inline void atomic_set_mask(unsig
 	);
 }
 
+#define ATOMIC_LONG_INIT(i)	ATOMIC_INIT(i)
+#define atomic_long_t		atomic_t
+#define atomic_long_read(v)	atomic_read(v)
+#define atomic_long_set(v,i)	atomic_set(v,i)
+#define atomic_long_inc(v)	atomic_inc(v)
+#define atomic_long_dec(v)	atomic_dec(v)
+#define atomic_long_add(i,v)	atomic_add(i,v)
+#define atomic_long_sub(i,v)	atomic_sub(i,v)
+
 /* Atomic operations are already serializing */
 #define smp_mb__before_atomic_dec()	barrier()
 #define smp_mb__after_atomic_dec()	barrier()
Index: linux-2.6.15-rc5/include/asm-sh/atomic.h
===================================================================
--- linux-2.6.15-rc5.orig/include/asm-sh/atomic.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/asm-sh/atomic.h	2005-12-09 10:47:48.000000000 -0800
@@ -134,6 +134,15 @@ static __inline__ void atomic_set_mask(u
 	local_irq_restore(flags);
 }
 
+#define ATOMIC_LONG_INIT(i)	ATOMIC_INIT(i)
+#define atomic_long_t		atomic_t
+#define atomic_long_read(v)	atomic_read(v)
+#define atomic_long_set(v,i)	atomic_set(v,i)
+#define atomic_long_inc(v)	atomic_inc(v)
+#define atomic_long_dec(v)	atomic_dec(v)
+#define atomic_long_add(i,v)	atomic_add(i,v)
+#define atomic_long_sub(i,v)	atomic_sub(i,v)
+
 /* Atomic operations are already serializing on SH */
 #define smp_mb__before_atomic_dec()	barrier()
 #define smp_mb__after_atomic_dec()	barrier()
Index: linux-2.6.15-rc5/include/asm-mips/atomic.h
===================================================================
--- linux-2.6.15-rc5.orig/include/asm-mips/atomic.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/asm-mips/atomic.h	2005-12-09 10:46:56.000000000 -0800
@@ -713,4 +713,13 @@ static __inline__ long atomic64_sub_if_p
 #define smp_mb__before_atomic_inc()	smp_mb()
 #define smp_mb__after_atomic_inc()	smp_mb()
 
+#define ATOMIC_LONG_INIT(i)		ATOMIC64_INIT(i)
+#define atomic_long_t			atomic64_t
+#define atomic_long_read(v)		atomic64_read(v)
+#define atomic_long_set(v,i)		atomic64_set(v,i)
+#define atomic_long_inc(v)		atomic64_inc(v)
+#define atomic_long_dec(v)		atomic64_dec(v)
+#define atomic_long_add(i,v)		atomic64_add(i,v)
+#define atomic_long_sub(i,v)		atomic64_sub(i,v)
+
 #endif /* _ASM_ATOMIC_H */
Index: linux-2.6.15-rc5/include/asm-powerpc/atomic.h
===================================================================
--- linux-2.6.15-rc5.orig/include/asm-powerpc/atomic.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/asm-powerpc/atomic.h	2005-12-09 10:47:23.000000000 -0800
@@ -400,6 +400,26 @@ static __inline__ long atomic64_dec_if_p
 	return t;
 }
 
+#define ATOMIC_LONG_INIT(i)		ATOMIC64_INIT(i)
+#define atomic_long_t			atomic64_t
+#define atomic_long_read(v)		atomic64_read(v)
+#define atomic_long_set(v,i)		atomic64_set(v,i)
+#define atomic_long_inc(v)		atomic64_inc(v)
+#define atomic_long_dec(v)		atomic64_dec(v)
+#define atomic_long_add(i,v)		atomic64_add(i,v)
+#define atomic_long_sub(i,v)		atomic64_sub(i,v)
+
+#else
+
+#define ATOMIC_LONG_INIT(i)	ATOMIC_INIT(i)
+#define atomic_long_t		atomic_t
+#define atomic_long_read(v)	atomic_read(v)
+#define atomic_long_set(v,i)	atomic_set(v,i)
+#define atomic_long_inc(v)	atomic_inc(v)
+#define atomic_long_dec(v)	atomic_dec(v)
+#define atomic_long_add(i,v)	atomic_add(i,v)
+#define atomic_long_sub(i,v)	atomic_sub(i,v)
+
 #endif /* __powerpc64__ */
 
 #endif /* __KERNEL__ */
