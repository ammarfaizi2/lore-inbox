Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbVLNFSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbVLNFSq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 00:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbVLNFSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 00:18:46 -0500
Received: from omx3-ext.sgi.com ([192.48.171.25]:37582 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751268AbVLNFSp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 00:18:45 -0500
Date: Tue, 13 Dec 2005 21:18:25 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: "David S. Miller" <davem@davemloft.net>
cc: ak@suse.de, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] atomic_long_t & include/asm-generic/atomic.h V2
In-Reply-To: <20051213.192623.39998066.davem@davemloft.net>
Message-ID: <Pine.LNX.4.62.0512132117220.25541@schroedinger.engr.sgi.com>
References: <20051213154916.6667b6d8.akpm@osdl.org>
 <Pine.LNX.4.62.0512131849550.24909@schroedinger.engr.sgi.com>
 <20051214025710.GD23384@wotan.suse.de> <20051213.192623.39998066.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Dec 2005, David S. Miller wrote:

> I definitely agree with Andi here.

Ok. New rev:

atomic_long_t & include/asm-generic/atomic.h V2

Several counters already have the need to use 64 atomic variables on 64
bit platforms (see mm_counter_t in sched.h). We have to do ugly ifdefs to
fall back to 32 bit atomic on 32 bit platforms.

The VM statistics patch that I am working on will also make more extensive
use of atomic64.

This patch introduces a new type atomic_long_t by providing definitions in
asm-generic/atomic.h that works similar to the c "long" type. Its 32 bits on
32 bit platforms and 64 bits on 64 bit platforms.

Also cleans up the determination of the mm_counter_t in sched.h.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc5-mm2/include/asm-generic/atomic.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-rc5-mm2/include/asm-generic/atomic.h	2005-12-13 20:55:53.000000000 -0800
@@ -0,0 +1,116 @@
+#ifndef _ASM_GENERIC_ATOMIC_H
+#define _ASM_GENERIC_ATOMIC_H 
+/*
+ * Copyright (C) 2005 Silicon Graphics, Inc.
+ *	Christoph Lameter <clameter@sgi.com>
+ *
+ * Allows to provide arch independent atomic definitions without the need to
+ * edit all arch specific atomic.h files.
+ */
+
+
+/*
+ * Suppport for atomic_long_t
+ *
+ * Casts for parameters are avoided for existing atomic functions in order to
+ * avoid issues with cast-as-lval under gcc 4.x and other limitations that the
+ * macros of a platform may have.
+ */
+
+#if BIT_PER_LONG == 64
+
+typedef atomic64_t atomic_long_t;
+
+#define ATOMIC_LONG_INIT(i)	ATOMIC64_INIT(i)
+
+static inline long atomic_long_read(atomic_long_t *l)
+{
+	atomic64_t *v = (atomic64_t *)l;
+
+	return (long)atomic64_read((atomic64_t *)v);
+}
+
+static inline void atomic_long_set(atomic_long_t *l, long i)
+{
+	atomic64_t *v = (atomic64_t *)l;
+
+	atomic_set(v, i);
+}
+
+static inline void atomic_long_inc(atomic_long_t *l)
+{
+	atomic64_t *v = (atomic64_t *)l;
+
+	atomic64_inc(p);
+}
+
+static inline void atomic_long_dec(atomic_long_t *l)
+{
+	atomic64_t *v = (atomic64_t *)l;
+
+	atomic64_dec(v);
+}
+
+static inline void atomic_long_add(long i, atomic_long_t *l)
+{
+	atomic64_t *v = (atomic64_t *)l;
+
+	atomic64_add(i, p);
+}
+
+static inline void atomic_long_sub(long i, atomic_long_t *l)
+{
+	atomic64_t *v = (atomic64_t *)l;
+
+	atomic64_sub(i, v);
+}
+
+#else
+
+typedef atomic_t atomic_long_t;
+
+#define ATOMIC_LONG_INIT(i)	ATOMIC_INIT(i)
+static inline long atomic_long_read(atomic_long_t *l)
+{
+	atomic_t *v = (atomic_t *)l;
+
+	return (long)atomic_read((atomic_t *)v);
+}
+
+static inline void atomic_long_set(atomic_long_t *l, long i)
+{
+	atomic_t *v = (atomic_t *)l;
+
+	atomic_set(v, i);
+}
+
+static inline void atomic_long_inc(atomic_long_t *l)
+{
+	atomic_t *v = (atomic_t *)l;
+
+	atomic_inc(p);
+}
+
+static inline void atomic_long_dec(atomic_long_t *l)
+{
+	atomic_t *v = (atomic_t *)l;
+
+	atomic_dec(v);
+}
+
+static inline void atomic_long_add(long i, atomic_long_t *l)
+{
+	atomic_t *v = (atomic_t *)l;
+
+	atomic_add(i, p);
+}
+
+static inline void atomic_long_sub(long i, atomic_long_t *l)
+{
+	atomic_t *v = (atomic_t *)l;
+
+	atomic_sub(i, v);
+}
+
+#endif
+#endif
Index: linux-2.6.15-rc5-mm2/include/linux/sched.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/linux/sched.h	2005-12-12 09:10:34.000000000 -0800
+++ linux-2.6.15-rc5-mm2/include/linux/sched.h	2005-12-13 20:41:07.000000000 -0800
@@ -259,25 +259,12 @@ extern void arch_unmap_area_topdown(stru
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
Index: linux-2.6.15-rc5-mm2/include/asm-ia64/atomic.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/asm-ia64/atomic.h	2005-12-12 10:08:36.000000000 -0800
+++ linux-2.6.15-rc5-mm2/include/asm-ia64/atomic.h	2005-12-13 20:41:07.000000000 -0800
@@ -192,4 +192,5 @@ atomic64_add_negative (__s64 i, atomic64
 #define smp_mb__before_atomic_inc()	barrier()
 #define smp_mb__after_atomic_inc()	barrier()
 
+#include <asm-generic/atomic.h>
 #endif /* _ASM_IA64_ATOMIC_H */
Index: linux-2.6.15-rc5-mm2/include/asm-m68k/atomic.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/asm-m68k/atomic.h	2005-12-12 10:08:36.000000000 -0800
+++ linux-2.6.15-rc5-mm2/include/asm-m68k/atomic.h	2005-12-13 20:41:07.000000000 -0800
@@ -157,4 +157,5 @@ static inline void atomic_set_mask(unsig
 #define smp_mb__before_atomic_inc()	barrier()
 #define smp_mb__after_atomic_inc()	barrier()
 
+#include <asm-generic/atomic.h>
 #endif /* __ARCH_M68K_ATOMIC __ */
Index: linux-2.6.15-rc5-mm2/include/asm-parisc/atomic.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/asm-parisc/atomic.h	2005-12-12 10:08:36.000000000 -0800
+++ linux-2.6.15-rc5-mm2/include/asm-parisc/atomic.h	2005-12-13 20:41:07.000000000 -0800
@@ -216,4 +216,5 @@ static __inline__ int atomic_read(const 
 #define smp_mb__before_atomic_inc()	smp_mb()
 #define smp_mb__after_atomic_inc()	smp_mb()
 
+#include <asm-generic/atomic.h>
 #endif
Index: linux-2.6.15-rc5-mm2/include/asm-m32r/atomic.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/asm-m32r/atomic.h	2005-12-12 10:08:36.000000000 -0800
+++ linux-2.6.15-rc5-mm2/include/asm-m32r/atomic.h	2005-12-13 20:41:07.000000000 -0800
@@ -313,4 +313,5 @@ static __inline__ void atomic_set_mask(u
 #define smp_mb__before_atomic_inc()	barrier()
 #define smp_mb__after_atomic_inc()	barrier()
 
+#include <asm-generic/atomic.h>
 #endif	/* _ASM_M32R_ATOMIC_H */
Index: linux-2.6.15-rc5-mm2/include/asm-frv/atomic.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/asm-frv/atomic.h	2005-12-12 10:08:36.000000000 -0800
+++ linux-2.6.15-rc5-mm2/include/asm-frv/atomic.h	2005-12-13 20:41:07.000000000 -0800
@@ -426,4 +426,5 @@ extern uint32_t __cmpxchg_32(uint32_t *v
 })
 #define atomic_inc_not_zero(v) atomic_add_unless((v), 1, 0)
 
+#include <asm-generic/atomic.h>
 #endif /* _ASM_ATOMIC_H */
Index: linux-2.6.15-rc5-mm2/include/asm-cris/atomic.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/asm-cris/atomic.h	2005-12-12 10:08:36.000000000 -0800
+++ linux-2.6.15-rc5-mm2/include/asm-cris/atomic.h	2005-12-13 20:41:07.000000000 -0800
@@ -156,4 +156,5 @@ static inline int atomic_add_unless(atom
 #define smp_mb__before_atomic_inc()    barrier()
 #define smp_mb__after_atomic_inc()     barrier()
 
+#include <asm-generic/atomic.h>
 #endif
Index: linux-2.6.15-rc5-mm2/include/asm-arm26/atomic.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/asm-arm26/atomic.h	2005-12-12 10:08:36.000000000 -0800
+++ linux-2.6.15-rc5-mm2/include/asm-arm26/atomic.h	2005-12-13 20:41:07.000000000 -0800
@@ -118,5 +118,6 @@ static inline void atomic_clear_mask(uns
 #define smp_mb__before_atomic_inc()	barrier()
 #define smp_mb__after_atomic_inc()	barrier()
 
+#include <asm-generic/atomic.h>
 #endif
 #endif
Index: linux-2.6.15-rc5-mm2/include/asm-sparc/atomic.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/asm-sparc/atomic.h	2005-12-12 10:08:36.000000000 -0800
+++ linux-2.6.15-rc5-mm2/include/asm-sparc/atomic.h	2005-12-13 20:41:07.000000000 -0800
@@ -159,4 +159,5 @@ static inline int __atomic24_sub(int i, 
 
 #endif /* !(__KERNEL__) */
 
+#include <asm-generic/atomic.h>
 #endif /* !(__ARCH_SPARC_ATOMIC__) */
Index: linux-2.6.15-rc5-mm2/include/asm-s390/atomic.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/asm-s390/atomic.h	2005-12-12 10:08:36.000000000 -0800
+++ linux-2.6.15-rc5-mm2/include/asm-s390/atomic.h	2005-12-13 20:41:07.000000000 -0800
@@ -182,5 +182,6 @@ static __inline__ int atomic64_add_unles
 #define smp_mb__before_atomic_inc()	smp_mb()
 #define smp_mb__after_atomic_inc()	smp_mb()
 
+#include <asm-generic/atomic.h>
 #endif /* __KERNEL__ */
 #endif /* __ARCH_S390_ATOMIC__  */
Index: linux-2.6.15-rc5-mm2/include/asm-h8300/atomic.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/asm-h8300/atomic.h	2005-12-12 10:08:36.000000000 -0800
+++ linux-2.6.15-rc5-mm2/include/asm-h8300/atomic.h	2005-12-13 20:41:07.000000000 -0800
@@ -137,4 +137,5 @@ static __inline__ void atomic_set_mask(u
 #define smp_mb__before_atomic_inc()    barrier()
 #define smp_mb__after_atomic_inc() barrier()
 
+#include <asm-generic/atomic.h>
 #endif /* __ARCH_H8300_ATOMIC __ */
Index: linux-2.6.15-rc5-mm2/include/asm-arm/atomic.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/asm-arm/atomic.h	2005-12-12 10:08:36.000000000 -0800
+++ linux-2.6.15-rc5-mm2/include/asm-arm/atomic.h	2005-12-13 20:41:07.000000000 -0800
@@ -205,5 +205,6 @@ static inline int atomic_add_unless(atom
 #define smp_mb__before_atomic_inc()	barrier()
 #define smp_mb__after_atomic_inc()	barrier()
 
+#include <asm-generic/atomic.h>
 #endif
 #endif
Index: linux-2.6.15-rc5-mm2/include/asm-alpha/atomic.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/asm-alpha/atomic.h	2005-12-12 10:08:36.000000000 -0800
+++ linux-2.6.15-rc5-mm2/include/asm-alpha/atomic.h	2005-12-13 20:41:07.000000000 -0800
@@ -216,4 +216,5 @@ static __inline__ long atomic64_sub_retu
 #define smp_mb__before_atomic_inc()	smp_mb()
 #define smp_mb__after_atomic_inc()	smp_mb()
 
+#include <asm-generic/atomic.h>
 #endif /* _ALPHA_ATOMIC_H */
Index: linux-2.6.15-rc5-mm2/include/asm-sh64/atomic.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/asm-sh64/atomic.h	2005-12-12 10:08:36.000000000 -0800
+++ linux-2.6.15-rc5-mm2/include/asm-sh64/atomic.h	2005-12-13 20:41:07.000000000 -0800
@@ -152,4 +152,5 @@ static __inline__ void atomic_set_mask(u
 #define smp_mb__before_atomic_inc()	barrier()
 #define smp_mb__after_atomic_inc()	barrier()
 
+#include <asm-generic/atomic.h>
 #endif /* __ASM_SH64_ATOMIC_H */
Index: linux-2.6.15-rc5-mm2/include/asm-v850/atomic.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/asm-v850/atomic.h	2005-12-12 10:08:36.000000000 -0800
+++ linux-2.6.15-rc5-mm2/include/asm-v850/atomic.h	2005-12-13 20:41:07.000000000 -0800
@@ -126,4 +126,5 @@ static inline int atomic_add_unless(atom
 #define smp_mb__before_atomic_inc()	barrier()
 #define smp_mb__after_atomic_inc()	barrier()
 
+#include <asm-generic/atomic.h>
 #endif /* __V850_ATOMIC_H__ */
Index: linux-2.6.15-rc5-mm2/include/asm-sparc64/atomic.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/asm-sparc64/atomic.h	2005-12-12 10:08:36.000000000 -0800
+++ linux-2.6.15-rc5-mm2/include/asm-sparc64/atomic.h	2005-12-13 20:41:07.000000000 -0800
@@ -96,4 +96,5 @@ extern int atomic64_sub_ret(int, atomic6
 #define smp_mb__after_atomic_inc()	barrier()
 #endif
 
+#include <asm-generic/atomic.h>
 #endif /* !(__ARCH_SPARC64_ATOMIC__) */
Index: linux-2.6.15-rc5-mm2/include/asm-m68knommu/atomic.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/asm-m68knommu/atomic.h	2005-12-12 10:08:36.000000000 -0800
+++ linux-2.6.15-rc5-mm2/include/asm-m68knommu/atomic.h	2005-12-13 20:41:07.000000000 -0800
@@ -143,4 +143,5 @@ static inline int atomic_sub_return(int 
 #define atomic_dec_return(v) atomic_sub_return(1,(v))
 #define atomic_inc_return(v) atomic_add_return(1,(v))
 
+#include <asm-generic/atomic.h>
 #endif /* __ARCH_M68KNOMMU_ATOMIC __ */
Index: linux-2.6.15-rc5-mm2/include/asm-xtensa/atomic.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/asm-xtensa/atomic.h	2005-12-12 10:08:36.000000000 -0800
+++ linux-2.6.15-rc5-mm2/include/asm-xtensa/atomic.h	2005-12-13 20:41:07.000000000 -0800
@@ -286,6 +286,7 @@ static inline void atomic_set_mask(unsig
 #define smp_mb__before_atomic_inc()	barrier()
 #define smp_mb__after_atomic_inc()	barrier()
 
+#include <asm-generic/atomic.h>
 #endif /* __KERNEL__ */
 
 #endif /* _XTENSA_ATOMIC_H */
Index: linux-2.6.15-rc5-mm2/include/asm-x86_64/atomic.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/asm-x86_64/atomic.h	2005-12-12 10:08:36.000000000 -0800
+++ linux-2.6.15-rc5-mm2/include/asm-x86_64/atomic.h	2005-12-13 20:41:07.000000000 -0800
@@ -424,4 +424,5 @@ __asm__ __volatile__(LOCK "orl %0,%1" \
 #define smp_mb__before_atomic_inc()	barrier()
 #define smp_mb__after_atomic_inc()	barrier()
 
+#include <asm-generic/atomic.h>
 #endif
Index: linux-2.6.15-rc5-mm2/include/asm-sh/atomic.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/asm-sh/atomic.h	2005-12-12 10:08:36.000000000 -0800
+++ linux-2.6.15-rc5-mm2/include/asm-sh/atomic.h	2005-12-13 20:41:07.000000000 -0800
@@ -140,4 +140,5 @@ static __inline__ void atomic_set_mask(u
 #define smp_mb__before_atomic_inc()	barrier()
 #define smp_mb__after_atomic_inc()	barrier()
 
+#include <asm-generic/atomic.h>
 #endif /* __ASM_SH_ATOMIC_H */
Index: linux-2.6.15-rc5-mm2/include/asm-i386/atomic.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/asm-i386/atomic.h	2005-12-12 10:08:36.000000000 -0800
+++ linux-2.6.15-rc5-mm2/include/asm-i386/atomic.h	2005-12-13 20:41:07.000000000 -0800
@@ -258,4 +258,5 @@ __asm__ __volatile__(LOCK "orl %0,%1" \
 #define smp_mb__before_atomic_inc()	barrier()
 #define smp_mb__after_atomic_inc()	barrier()
 
+#include <asm-generic/atomic.h>
 #endif
Index: linux-2.6.15-rc5-mm2/include/asm-powerpc/atomic.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/asm-powerpc/atomic.h	2005-12-12 10:08:36.000000000 -0800
+++ linux-2.6.15-rc5-mm2/include/asm-powerpc/atomic.h	2005-12-13 20:41:07.000000000 -0800
@@ -402,5 +402,6 @@ static __inline__ long atomic64_dec_if_p
 
 #endif /* __powerpc64__ */
 
+#include <asm-generic/atomic.h>
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_ATOMIC_H_ */
Index: linux-2.6.15-rc5-mm2/include/asm-mips/atomic.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/asm-mips/atomic.h	2005-12-12 10:08:36.000000000 -0800
+++ linux-2.6.15-rc5-mm2/include/asm-mips/atomic.h	2005-12-13 20:41:07.000000000 -0800
@@ -713,4 +713,5 @@ static __inline__ long atomic64_sub_if_p
 #define smp_mb__before_atomic_inc()	smp_mb()
 #define smp_mb__after_atomic_inc()	smp_mb()
 
+#include <asm-generic/atomic.h>
 #endif /* _ASM_ATOMIC_H */
