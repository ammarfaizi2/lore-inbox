Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268054AbUJNWOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268054AbUJNWOg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 18:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267928AbUJNWMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 18:12:39 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:16108 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S267785AbUJNVog (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 17:44:36 -0400
Date: Thu, 14 Oct 2004 23:44:33 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] move atomic_t to asm/types.h
Message-ID: <Pine.LNX.4.61.0410142344180.29968@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This moves the definition and the initializer of atomic_t from
asm/atomic.h to asm/types.h.


 asm-alpha/atomic.h     |   13 ++-----------
 asm-alpha/types.h      |   11 +++++++++++
 asm-arm/atomic.h       |    5 +----
 asm-arm/types.h        |    4 ++++
 asm-arm26/atomic.h     |    5 +----
 asm-arm26/types.h      |    4 ++++
 asm-cris/atomic.h      |    5 +----
 asm-cris/types.h       |    4 ++++
 asm-h8300/atomic.h     |    5 ++---
 asm-h8300/types.h      |    3 +++
 asm-i386/atomic.h      |   10 +---------
 asm-i386/types.h       |    9 +++++++++
 asm-ia64/atomic.h      |   11 +----------
 asm-ia64/types.h       |   10 ++++++++++
 asm-m68k/atomic.h      |    4 +---
 asm-m68k/types.h       |    3 +++
 asm-m68knommu/atomic.h |    4 +---
 asm-mips/atomic.h      |    5 +----
 asm-mips/types.h       |    4 ++++
 asm-parisc/atomic.h    |   11 +----------
 asm-parisc/types.h     |   10 ++++++++++
 asm-ppc/atomic.h       |    4 +---
 asm-ppc/types.h        |    4 ++++
 asm-ppc64/atomic.h     |    5 +----
 asm-ppc64/types.h      |    5 +++++
 asm-s390/atomic.h      |    7 ++-----
 asm-s390/types.h       |    5 +++++
 asm-sh/atomic.h        |    6 ++----
 asm-sh/types.h         |    4 ++++
 asm-sh64/atomic.h      |    6 ++----
 asm-sh64/types.h       |    4 ++++
 asm-sparc/atomic.h     |   10 +---------
 asm-sparc/types.h      |   14 ++++++++++++++
 asm-sparc64/atomic.h   |    6 ------
 asm-sparc64/types.h    |    6 ++++++
 asm-v850/atomic.h      |    5 +----
 asm-v850/types.h       |    4 ++++
 asm-x86_64/atomic.h    |   10 +---------
 asm-x86_64/types.h     |    9 +++++++++
 39 files changed, 141 insertions(+), 113 deletions(-)

Index: linux-2.6-inc/include/asm-v850/atomic.h
===================================================================
--- linux-2.6-inc.orig/include/asm-v850/atomic.h	2004-06-16 20:27:28.000000000 +0200
+++ linux-2.6-inc/include/asm-v850/atomic.h	2004-10-11 23:57:37.000000000 +0200
@@ -15,6 +15,7 @@
 #define __V850_ATOMIC_H__
 
 #include <linux/config.h>
+#include <linux/types.h>
 
 #include <asm/system.h>
 
@@ -22,10 +23,6 @@
 #error SMP not supported
 #endif
 
-typedef struct { int counter; } atomic_t;
-
-#define ATOMIC_INIT(i)	{ (i) }
-
 #ifdef __KERNEL__
 
 #define atomic_read(v)		((v)->counter)
Index: linux-2.6-inc/include/asm-alpha/types.h
===================================================================
--- linux-2.6-inc.orig/include/asm-alpha/types.h	2004-06-16 20:26:39.000000000 +0200
+++ linux-2.6-inc/include/asm-alpha/types.h	2004-10-11 23:57:37.000000000 +0200
@@ -58,6 +58,17 @@ typedef u64 dma64_addr_t;
 
 typedef unsigned short kmem_bufctl_t;
 
+/*
+ * Counter is volatile to make sure gcc doesn't try to be clever
+ * and move things around on us. We need to use _exactly_ the address
+ * the user gave us, not some alias that contains the same information.
+ */
+typedef struct { volatile int counter; } atomic_t;
+typedef struct { volatile long counter; } atomic64_t;
+
+#define ATOMIC_INIT(i)		( (atomic_t) { (i) } )
+#define ATOMIC64_INIT(i)	( (atomic64_t) { (i) } )
+
 #endif /* __ASSEMBLY__ */
 #endif /* __KERNEL__ */
 #endif /* _ALPHA_TYPES_H */
Index: linux-2.6-inc/include/asm-ppc/types.h
===================================================================
--- linux-2.6-inc.orig/include/asm-ppc/types.h	2004-06-16 20:27:14.000000000 +0200
+++ linux-2.6-inc/include/asm-ppc/types.h	2004-10-11 23:57:37.000000000 +0200
@@ -64,6 +64,10 @@ typedef u64 sector_t;
 
 typedef unsigned int kmem_bufctl_t;
 
+typedef struct { volatile int counter; } atomic_t;
+
+#define ATOMIC_INIT(i)	{ (i) }
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
Index: linux-2.6-inc/include/asm-ppc64/types.h
===================================================================
--- linux-2.6-inc.orig/include/asm-ppc64/types.h	2004-06-16 20:27:15.000000000 +0200
+++ linux-2.6-inc/include/asm-ppc64/types.h	2004-10-11 23:57:37.000000000 +0200
@@ -73,6 +73,11 @@ typedef struct {
 } func_descr_t;
 
 typedef unsigned int kmem_bufctl_t;
+
+typedef struct { volatile int counter; } atomic_t;
+
+#define ATOMIC_INIT(i)	{ (i) }
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
Index: linux-2.6-inc/include/asm-m68k/types.h
===================================================================
--- linux-2.6-inc.orig/include/asm-m68k/types.h	2004-06-16 20:27:00.000000000 +0200
+++ linux-2.6-inc/include/asm-m68k/types.h	2004-10-11 23:57:37.000000000 +0200
@@ -62,6 +62,9 @@ typedef u32 dma64_addr_t;
 
 typedef unsigned short kmem_bufctl_t;
 
+typedef struct { volatile int counter; } atomic_t;
+#define ATOMIC_INIT(i)	{ (i) }
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
Index: linux-2.6-inc/include/asm-arm26/atomic.h
===================================================================
--- linux-2.6-inc.orig/include/asm-arm26/atomic.h	2003-07-18 23:22:37.000000000 +0200
+++ linux-2.6-inc/include/asm-arm26/atomic.h	2004-10-11 23:57:37.000000000 +0200
@@ -19,15 +19,12 @@
 #define __ASM_ARM_ATOMIC_H
 
 #include <linux/config.h>
+#include <linux/types.h>
 
 #ifdef CONFIG_SMP
 #error SMP is NOT supported
 #endif
 
-typedef struct { volatile int counter; } atomic_t;
-
-#define ATOMIC_INIT(i)	{ (i) }
-
 #ifdef __KERNEL__
 #include <asm/system.h>
 
Index: linux-2.6-inc/include/asm-parisc/types.h
===================================================================
--- linux-2.6-inc.orig/include/asm-parisc/types.h	2004-06-16 20:27:12.000000000 +0200
+++ linux-2.6-inc/include/asm-parisc/types.h	2004-10-11 23:57:37.000000000 +0200
@@ -58,6 +58,16 @@ typedef u64 dma64_addr_t;
 
 typedef unsigned int kmem_bufctl_t;
 
+/* Note that we need not lock read accesses - aligned word writes/reads
+ * are atomic, so a reader never sees unconsistent values.
+ *
+ * Cache-line alignment would conflict with, for example, linux/module.h
+ */
+
+typedef struct { volatile long counter; } atomic_t;
+
+#define ATOMIC_INIT(i)	{ (i) }
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
Index: linux-2.6-inc/include/asm-cris/atomic.h
===================================================================
--- linux-2.6-inc.orig/include/asm-cris/atomic.h	2004-06-16 20:26:48.000000000 +0200
+++ linux-2.6-inc/include/asm-cris/atomic.h	2004-10-11 23:57:37.000000000 +0200
@@ -4,6 +4,7 @@
 #define __ASM_CRIS_ATOMIC__
 
 #include <asm/system.h>
+#include <linux/types.h>
 
 /*
  * Atomic operations that C can't guarantee us.  Useful for
@@ -18,10 +19,6 @@
 
 #define __atomic_fool_gcc(x) (*(struct { int a[100]; } *)x)
 
-typedef struct { int counter; } atomic_t;
-
-#define ATOMIC_INIT(i)  { (i) }
-
 #define atomic_read(v) ((v)->counter)
 #define atomic_set(v,i) (((v)->counter) = (i))
 
Index: linux-2.6-inc/include/asm-parisc/atomic.h
===================================================================
--- linux-2.6-inc.orig/include/asm-parisc/atomic.h	2004-06-16 20:27:11.000000000 +0200
+++ linux-2.6-inc/include/asm-parisc/atomic.h	2004-10-11 23:57:37.000000000 +0200
@@ -2,6 +2,7 @@
 #define _ASM_PARISC_ATOMIC_H_
 
 #include <linux/config.h>
+#include <linux/types.h>
 #include <asm/system.h>
 /* Copyright (C) 2000 Philipp Rumpf <prumpf@tux.org>.  */
 
@@ -56,14 +57,6 @@ static inline void atomic_spin_unlock(at
 	local_irq_restore(flags);			\
 } while (0)
 
-/* Note that we need not lock read accesses - aligned word writes/reads
- * are atomic, so a reader never sees unconsistent values.
- *
- * Cache-line alignment would conflict with, for example, linux/module.h
- */
-
-typedef struct { volatile long counter; } atomic_t;
-
 
 /* This should get optimized out since it's never called.
 ** Or get a link error if xchg is used "wrong".
@@ -199,8 +192,6 @@ static __inline__ int atomic_read(const 
 
 #define atomic_dec_and_test(v)	(atomic_dec_return(v) == 0)
 
-#define ATOMIC_INIT(i)	{ (i) }
-
 #define smp_mb__before_atomic_dec()	smp_mb()
 #define smp_mb__after_atomic_dec()	smp_mb()
 #define smp_mb__before_atomic_inc()	smp_mb()
Index: linux-2.6-inc/include/asm-arm26/types.h
===================================================================
--- linux-2.6-inc.orig/include/asm-arm26/types.h	2004-06-16 20:26:48.000000000 +0200
+++ linux-2.6-inc/include/asm-arm26/types.h	2004-10-11 23:57:37.000000000 +0200
@@ -54,6 +54,10 @@ typedef u32 dma64_addr_t;
 
 typedef unsigned int kmem_bufctl_t;
 
+typedef struct { volatile int counter; } atomic_t;
+
+#define ATOMIC_INIT(i)	{ (i) }
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
Index: linux-2.6-inc/include/asm-ia64/atomic.h
===================================================================
--- linux-2.6-inc.orig/include/asm-ia64/atomic.h	2004-08-14 13:00:31.000000000 +0200
+++ linux-2.6-inc/include/asm-ia64/atomic.h	2004-10-11 23:57:37.000000000 +0200
@@ -13,19 +13,10 @@
  *	David Mosberger-Tang <davidm@hpl.hp.com>
  */
 #include <linux/types.h>
+#include <linux/types.h>
 
 #include <asm/intrinsics.h>
 
-/*
- * On IA-64, counter must always be volatile to ensure that that the
- * memory accesses are ordered.
- */
-typedef struct { volatile __s32 counter; } atomic_t;
-typedef struct { volatile __s64 counter; } atomic64_t;
-
-#define ATOMIC_INIT(i)		((atomic_t) { (i) })
-#define ATOMIC64_INIT(i)	((atomic64_t) { (i) })
-
 #define atomic_read(v)		((v)->counter)
 #define atomic64_read(v)	((v)->counter)
 
Index: linux-2.6-inc/include/asm-i386/atomic.h
===================================================================
--- linux-2.6-inc.orig/include/asm-i386/atomic.h	2004-02-18 20:10:50.000000000 +0100
+++ linux-2.6-inc/include/asm-i386/atomic.h	2004-10-11 23:57:37.000000000 +0200
@@ -2,6 +2,7 @@
 #define __ARCH_I386_ATOMIC__
 
 #include <linux/config.h>
+#include <linux/types.h>
 
 /*
  * Atomic operations that C can't guarantee us.  Useful for
@@ -14,15 +15,6 @@
 #define LOCK ""
 #endif
 
-/*
- * Make sure gcc doesn't try to be clever and move things around
- * on us. We need to use _exactly_ the address the user gave us,
- * not some alias that contains the same information.
- */
-typedef struct { volatile int counter; } atomic_t;
-
-#define ATOMIC_INIT(i)	{ (i) }
-
 /**
  * atomic_read - read atomic variable
  * @v: pointer of type atomic_t
Index: linux-2.6-inc/include/asm-alpha/atomic.h
===================================================================
--- linux-2.6-inc.orig/include/asm-alpha/atomic.h	2004-06-16 20:26:39.000000000 +0200
+++ linux-2.6-inc/include/asm-alpha/atomic.h	2004-10-11 23:57:37.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _ALPHA_ATOMIC_H
 #define _ALPHA_ATOMIC_H
 
+#include <linux/types.h>
+
 /*
  * Atomic operations that C can't guarantee us.  Useful for
  * resource counting etc...
@@ -10,17 +12,6 @@
  */
 
 
-/*
- * Counter is volatile to make sure gcc doesn't try to be clever
- * and move things around on us. We need to use _exactly_ the address
- * the user gave us, not some alias that contains the same information.
- */
-typedef struct { volatile int counter; } atomic_t;
-typedef struct { volatile long counter; } atomic64_t;
-
-#define ATOMIC_INIT(i)		( (atomic_t) { (i) } )
-#define ATOMIC64_INIT(i)	( (atomic64_t) { (i) } )
-
 #define atomic_read(v)		((v)->counter + 0)
 #define atomic64_read(v)	((v)->counter + 0)
 
Index: linux-2.6-inc/include/asm-arm/types.h
===================================================================
--- linux-2.6-inc.orig/include/asm-arm/types.h	2004-06-16 20:26:40.000000000 +0200
+++ linux-2.6-inc/include/asm-arm/types.h	2004-10-11 23:57:37.000000000 +0200
@@ -54,6 +54,10 @@ typedef u32 dma64_addr_t;
 
 typedef unsigned int kmem_bufctl_t;
 
+typedef struct { volatile int counter; } atomic_t;
+
+#define ATOMIC_INIT(i)	{ (i) }
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
Index: linux-2.6-inc/include/asm-i386/types.h
===================================================================
--- linux-2.6-inc.orig/include/asm-i386/types.h	2004-06-16 20:26:53.000000000 +0200
+++ linux-2.6-inc/include/asm-i386/types.h	2004-10-11 23:57:37.000000000 +0200
@@ -65,6 +65,15 @@ typedef u64 sector_t;
 
 typedef unsigned short kmem_bufctl_t;
 
+/*
+ * Make sure gcc doesn't try to be clever and move things around
+ * on us. We need to use _exactly_ the address the user gave us,
+ * not some alias that contains the same information.
+ */
+typedef struct { volatile int counter; } atomic_t;
+
+#define ATOMIC_INIT(i)	{ (i) }
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
Index: linux-2.6-inc/include/asm-ia64/types.h
===================================================================
--- linux-2.6-inc.orig/include/asm-ia64/types.h	2004-06-16 20:26:56.000000000 +0200
+++ linux-2.6-inc/include/asm-ia64/types.h	2004-10-11 23:57:37.000000000 +0200
@@ -69,6 +69,16 @@ typedef u64 dma_addr_t;
 
 typedef unsigned short kmem_bufctl_t;
 
+/*
+ * On IA-64, counter must always be volatile to ensure that that the
+ * memory accesses are ordered.
+ */
+typedef struct { volatile __s32 counter; } atomic_t;
+typedef struct { volatile __s64 counter; } atomic64_t;
+
+#define ATOMIC_INIT(i)		((atomic_t) { (i) })
+#define ATOMIC64_INIT(i)	((atomic64_t) { (i) })
+
 # endif /* __KERNEL__ */
 #endif /* !__ASSEMBLY__ */
 
Index: linux-2.6-inc/include/asm-cris/types.h
===================================================================
--- linux-2.6-inc.orig/include/asm-cris/types.h	2004-06-16 20:26:49.000000000 +0200
+++ linux-2.6-inc/include/asm-cris/types.h	2004-10-11 23:57:37.000000000 +0200
@@ -54,6 +54,10 @@ typedef u32 dma64_addr_t;
 
 typedef unsigned int kmem_bufctl_t;
 
+typedef struct { int counter; } atomic_t;
+
+#define ATOMIC_INIT(i)  { (i) }
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
Index: linux-2.6-inc/include/asm-sparc64/types.h
===================================================================
--- linux-2.6-inc.orig/include/asm-sparc64/types.h	2004-06-16 20:27:27.000000000 +0200
+++ linux-2.6-inc/include/asm-sparc64/types.h	2004-10-11 23:57:37.000000000 +0200
@@ -58,6 +58,12 @@ typedef u64 dma64_addr_t;
 
 typedef unsigned short kmem_bufctl_t;
 
+typedef struct { volatile int counter; } atomic_t;
+typedef struct { volatile __s64 counter; } atomic64_t;
+
+#define ATOMIC_INIT(i)		{ (i) }
+#define ATOMIC64_INIT(i)	{ (i) }
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
Index: linux-2.6-inc/include/asm-sh/atomic.h
===================================================================
--- linux-2.6-inc.orig/include/asm-sh/atomic.h	2004-06-16 20:27:19.000000000 +0200
+++ linux-2.6-inc/include/asm-sh/atomic.h	2004-10-11 23:57:37.000000000 +0200
@@ -1,16 +1,14 @@
 #ifndef __ASM_SH_ATOMIC_H
 #define __ASM_SH_ATOMIC_H
 
+#include <linux/types.h>
+
 /*
  * Atomic operations that C can't guarantee us.  Useful for
  * resource counting etc..
  *
  */
 
-typedef struct { volatile int counter; } atomic_t;
-
-#define ATOMIC_INIT(i)	( (atomic_t) { (i) } )
-
 #define atomic_read(v)		((v)->counter)
 #define atomic_set(v,i)		((v)->counter = (i))
 
Index: linux-2.6-inc/include/asm-x86_64/atomic.h
===================================================================
--- linux-2.6-inc.orig/include/asm-x86_64/atomic.h	2004-02-18 20:11:35.000000000 +0100
+++ linux-2.6-inc/include/asm-x86_64/atomic.h	2004-10-11 23:57:37.000000000 +0200
@@ -2,6 +2,7 @@
 #define __ARCH_X86_64_ATOMIC__
 
 #include <linux/config.h>
+#include <linux/types.h>
 
 /* atomic_t should be 32 bit signed type */
 
@@ -16,15 +17,6 @@
 #define LOCK ""
 #endif
 
-/*
- * Make sure gcc doesn't try to be clever and move things around
- * on us. We need to use _exactly_ the address the user gave us,
- * not some alias that contains the same information.
- */
-typedef struct { volatile int counter; } atomic_t;
-
-#define ATOMIC_INIT(i)	{ (i) }
-
 /**
  * atomic_read - read atomic variable
  * @v: pointer of type atomic_t
Index: linux-2.6-inc/include/asm-ppc64/atomic.h
===================================================================
--- linux-2.6-inc.orig/include/asm-ppc64/atomic.h	2004-06-16 20:27:15.000000000 +0200
+++ linux-2.6-inc/include/asm-ppc64/atomic.h	2004-10-11 23:57:37.000000000 +0200
@@ -13,12 +13,9 @@
 #ifndef _ASM_PPC64_ATOMIC_H_ 
 #define _ASM_PPC64_ATOMIC_H_
 
+#include <linux/types.h>
 #include <asm/memory.h>
 
-typedef struct { volatile int counter; } atomic_t;
-
-#define ATOMIC_INIT(i)	{ (i) }
-
 #define atomic_read(v)		((v)->counter)
 #define atomic_set(v,i)		(((v)->counter) = (i))
 
Index: linux-2.6-inc/include/asm-s390/types.h
===================================================================
--- linux-2.6-inc.orig/include/asm-s390/types.h	2004-06-16 20:27:19.000000000 +0200
+++ linux-2.6-inc/include/asm-s390/types.h	2004-10-11 23:57:37.000000000 +0200
@@ -81,6 +81,11 @@ typedef u32 dma_addr_t;
 
 typedef unsigned int kmem_bufctl_t;
 
+typedef struct {
+	volatile int counter;
+} __attribute__ ((aligned (4))) atomic_t;
+#define ATOMIC_INIT(i)  { (i) }
+
 #ifndef __s390x__
 typedef union {
 	unsigned long long pair;
Index: linux-2.6-inc/include/asm-sh64/atomic.h
===================================================================
--- linux-2.6-inc.orig/include/asm-sh64/atomic.h	2004-08-14 13:00:49.000000000 +0200
+++ linux-2.6-inc/include/asm-sh64/atomic.h	2004-10-11 23:57:37.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef __ASM_SH64_ATOMIC_H
 #define __ASM_SH64_ATOMIC_H
 
+#include <linux/types.h>
+
 /*
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
@@ -19,10 +21,6 @@
  *
  */
 
-typedef struct { volatile int counter; } atomic_t;
-
-#define ATOMIC_INIT(i)	( (atomic_t) { (i) } )
-
 #define atomic_read(v)		((v)->counter)
 #define atomic_set(v,i)		((v)->counter = (i))
 
Index: linux-2.6-inc/include/asm-v850/types.h
===================================================================
--- linux-2.6-inc.orig/include/asm-v850/types.h	2004-06-16 20:27:29.000000000 +0200
+++ linux-2.6-inc/include/asm-v850/types.h	2004-10-11 23:57:37.000000000 +0200
@@ -61,6 +61,10 @@ typedef u32 dma_addr_t;
 
 typedef unsigned int kmem_bufctl_t;
 
+typedef struct { int counter; } atomic_t;
+
+#define ATOMIC_INIT(i)	{ (i) }
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
Index: linux-2.6-inc/include/asm-sparc64/atomic.h
===================================================================
--- linux-2.6-inc.orig/include/asm-sparc64/atomic.h	2004-06-16 20:27:26.000000000 +0200
+++ linux-2.6-inc/include/asm-sparc64/atomic.h	2004-10-11 23:57:37.000000000 +0200
@@ -10,12 +10,6 @@
 
 #include <linux/types.h>
 
-typedef struct { volatile int counter; } atomic_t;
-typedef struct { volatile __s64 counter; } atomic64_t;
-
-#define ATOMIC_INIT(i)		{ (i) }
-#define ATOMIC64_INIT(i)	{ (i) }
-
 #define atomic_read(v)		((v)->counter)
 #define atomic64_read(v)	((v)->counter)
 
Index: linux-2.6-inc/include/asm-mips/types.h
===================================================================
--- linux-2.6-inc.orig/include/asm-mips/types.h	2004-06-16 20:27:05.000000000 +0200
+++ linux-2.6-inc/include/asm-mips/types.h	2004-10-11 23:57:37.000000000 +0200
@@ -101,6 +101,10 @@ typedef u64 sector_t;
 
 typedef unsigned short kmem_bufctl_t;
 
+typedef struct { volatile int counter; } atomic_t;
+
+#define ATOMIC_INIT(i)    { (i) }
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
Index: linux-2.6-inc/include/asm-h8300/types.h
===================================================================
--- linux-2.6-inc.orig/include/asm-h8300/types.h	2004-06-16 20:26:50.000000000 +0200
+++ linux-2.6-inc/include/asm-h8300/types.h	2004-10-11 23:57:37.000000000 +0200
@@ -60,6 +60,9 @@ typedef u64 sector_t;
 
 typedef unsigned int kmem_bufctl_t;
 
+typedef struct { int counter; } atomic_t;
+#define ATOMIC_INIT(i)	{ (i) }
+
 #endif /* __KERNEL__ */
 
 #endif /* __ASSEMBLY__ */
Index: linux-2.6-inc/include/asm-sparc/atomic.h
===================================================================
--- linux-2.6-inc.orig/include/asm-sparc/atomic.h	2004-06-16 20:27:24.000000000 +0200
+++ linux-2.6-inc/include/asm-sparc/atomic.h	2004-10-13 21:25:59.274516083 +0200
@@ -11,13 +11,10 @@
 #define __ARCH_SPARC_ATOMIC__
 
 #include <linux/config.h>
-
-typedef struct { volatile int counter; } atomic_t;
+#include <linux/types.h>
 
 #ifdef __KERNEL__
 
-#define ATOMIC_INIT(i)  { (i) }
-
 extern int __atomic_add_return(int, atomic_t *);
 extern void atomic_set(atomic_t *, int);
 
@@ -50,11 +47,8 @@ extern void atomic_set(atomic_t *, int);
 /* This is the old 24-bit implementation.  It's still used internally
  * by some sparc-specific code, notably the semaphore implementation.
  */
-typedef struct { volatile int counter; } atomic24_t;
-
 #ifndef CONFIG_SMP
 
-#define ATOMIC24_INIT(i)  { (i) }
 #define atomic24_read(v)          ((v)->counter)
 #define atomic24_set(v, i)        (((v)->counter) = i)
 
@@ -73,8 +67,6 @@ typedef struct { volatile int counter; }
  *	 31                          8 7      0
  */
 
-#define ATOMIC24_INIT(i)	{ ((i) << 8) }
-
 static inline int atomic24_read(const atomic24_t *v)
 {
 	int ret = v->counter;
Index: linux-2.6-inc/include/asm-m68knommu/atomic.h
===================================================================
--- linux-2.6-inc.orig/include/asm-m68knommu/atomic.h	2004-06-16 20:27:00.000000000 +0200
+++ linux-2.6-inc/include/asm-m68knommu/atomic.h	2004-10-11 23:57:37.000000000 +0200
@@ -1,6 +1,7 @@
 #ifndef __ARCH_M68KNOMMU_ATOMIC__
 #define __ARCH_M68KNOMMU_ATOMIC__
 
+#include <linux/types.h>
 #include <asm/system.h>	/* local_irq_XXX() */
 
 /*
@@ -12,9 +13,6 @@
  * We do not have SMP m68k systems, so we don't have to deal with that.
  */
 
-typedef struct { int counter; } atomic_t;
-#define ATOMIC_INIT(i)	{ (i) }
-
 #define atomic_read(v)		((v)->counter)
 #define atomic_set(v, i)	(((v)->counter) = i)
 
Index: linux-2.6-inc/include/asm-m68k/atomic.h
===================================================================
--- linux-2.6-inc.orig/include/asm-m68k/atomic.h	2004-08-14 13:00:36.000000000 +0200
+++ linux-2.6-inc/include/asm-m68k/atomic.h	2004-10-11 23:57:37.000000000 +0200
@@ -1,6 +1,7 @@
 #ifndef __ARCH_M68K_ATOMIC__
 #define __ARCH_M68K_ATOMIC__
 
+#include <linux/types.h>
 #include <asm/system.h>	/* local_irq_XXX() */
 
 /*
@@ -12,9 +13,6 @@
  * We do not have SMP m68k systems, so we don't have to deal with that.
  */
 
-typedef struct { int counter; } atomic_t;
-#define ATOMIC_INIT(i)	{ (i) }
-
 #define atomic_read(v)		((v)->counter)
 #define atomic_set(v, i)	(((v)->counter) = i)
 
Index: linux-2.6-inc/include/asm-s390/atomic.h
===================================================================
--- linux-2.6-inc.orig/include/asm-s390/atomic.h	2004-06-16 20:27:17.000000000 +0200
+++ linux-2.6-inc/include/asm-s390/atomic.h	2004-10-11 23:57:37.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef __ARCH_S390_ATOMIC__
 #define __ARCH_S390_ATOMIC__
 
+#include <linux/types.h>
+
 /*
  *  include/asm-s390/atomic.h
  *
@@ -21,11 +23,6 @@
  * S390 uses 'Compare And Swap' for atomicity in SMP enviroment
  */
 
-typedef struct {
-	volatile int counter;
-} __attribute__ ((aligned (4))) atomic_t;
-#define ATOMIC_INIT(i)  { (i) }
-
 #ifdef __KERNEL__
 
 #define __CS_LOOP(ptr, op_val, op_string) ({				\
Index: linux-2.6-inc/include/asm-mips/atomic.h
===================================================================
--- linux-2.6-inc.orig/include/asm-mips/atomic.h	2004-08-14 13:00:40.000000000 +0200
+++ linux-2.6-inc/include/asm-mips/atomic.h	2004-10-11 23:57:37.000000000 +0200
@@ -18,6 +18,7 @@
  * main big wrapper ...
  */
 #include <linux/config.h>
+#include <linux/types.h>
 #include <linux/spinlock.h>
 
 #ifndef _ASM_ATOMIC_H
@@ -25,10 +26,6 @@
 
 extern spinlock_t atomic_lock;
 
-typedef struct { volatile int counter; } atomic_t;
-
-#define ATOMIC_INIT(i)    { (i) }
-
 /*
  * atomic_read - read atomic variable
  * @v: pointer of type atomic_t
Index: linux-2.6-inc/include/asm-sh/types.h
===================================================================
--- linux-2.6-inc.orig/include/asm-sh/types.h	2004-06-16 20:27:21.000000000 +0200
+++ linux-2.6-inc/include/asm-sh/types.h	2004-10-11 23:57:37.000000000 +0200
@@ -60,6 +60,10 @@ typedef u64 sector_t;
 
 typedef unsigned int kmem_bufctl_t;
 
+typedef struct { volatile int counter; } atomic_t;
+
+#define ATOMIC_INIT(i)	( (atomic_t) { (i) } )
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
Index: linux-2.6-inc/include/asm-ppc/atomic.h
===================================================================
--- linux-2.6-inc.orig/include/asm-ppc/atomic.h	2004-06-16 20:27:13.000000000 +0200
+++ linux-2.6-inc/include/asm-ppc/atomic.h	2004-10-11 23:57:37.000000000 +0200
@@ -5,11 +5,9 @@
 #ifndef _ASM_PPC_ATOMIC_H_
 #define _ASM_PPC_ATOMIC_H_
 
-typedef struct { volatile int counter; } atomic_t;
-
 #ifdef __KERNEL__
 
-#define ATOMIC_INIT(i)	{ (i) }
+#include <linux/types.h>
 
 #define atomic_read(v)		((v)->counter)
 #define atomic_set(v,i)		(((v)->counter) = (i))
Index: linux-2.6-inc/include/asm-sparc/types.h
===================================================================
--- linux-2.6-inc.orig/include/asm-sparc/types.h	2004-06-16 20:27:25.000000000 +0200
+++ linux-2.6-inc/include/asm-sparc/types.h	2004-10-13 21:25:59.276515736 +0200
@@ -35,6 +35,8 @@ typedef unsigned long long __u64;
 
 #ifdef __KERNEL__
 
+#include <linux/config.h>
+
 #define BITS_PER_LONG 32
 
 #ifndef __ASSEMBLY__
@@ -56,6 +58,18 @@ typedef u32 dma64_addr_t;
 
 typedef unsigned short kmem_bufctl_t;
 
+typedef struct { volatile int counter; } atomic_t;
+
+#define ATOMIC_INIT(i)		{ (i) }
+
+typedef struct { volatile int counter; } atomic24_t;
+
+#ifndef CONFIG_SMP
+#define ATOMIC24_INIT(i)	{ (i) }
+#else
+#define ATOMIC24_INIT(i)	{ ((i) << 8) }
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
Index: linux-2.6-inc/include/asm-arm/atomic.h
===================================================================
--- linux-2.6-inc.orig/include/asm-arm/atomic.h	2004-06-16 20:26:40.000000000 +0200
+++ linux-2.6-inc/include/asm-arm/atomic.h	2004-10-11 23:57:37.000000000 +0200
@@ -12,10 +12,7 @@
 #define __ASM_ARM_ATOMIC_H
 
 #include <linux/config.h>
-
-typedef struct { volatile int counter; } atomic_t;
-
-#define ATOMIC_INIT(i)	{ (i) }
+#include <linux/types.h>
 
 #ifdef __KERNEL__
 
Index: linux-2.6-inc/include/asm-h8300/atomic.h
===================================================================
--- linux-2.6-inc.orig/include/asm-h8300/atomic.h	2004-06-16 20:26:50.000000000 +0200
+++ linux-2.6-inc/include/asm-h8300/atomic.h	2004-10-11 23:57:37.000000000 +0200
@@ -1,14 +1,13 @@
 #ifndef __ARCH_H8300_ATOMIC__
 #define __ARCH_H8300_ATOMIC__
 
+#include <linux/types.h>
+
 /*
  * Atomic operations that C can't guarantee us.  Useful for
  * resource counting etc..
  */
 
-typedef struct { int counter; } atomic_t;
-#define ATOMIC_INIT(i)	{ (i) }
-
 #define atomic_read(v)		((v)->counter)
 #define atomic_set(v, i)	(((v)->counter) = i)
 
Index: linux-2.6-inc/include/asm-sh64/types.h
===================================================================
--- linux-2.6-inc.orig/include/asm-sh64/types.h	2004-08-14 13:00:49.000000000 +0200
+++ linux-2.6-inc/include/asm-sh64/types.h	2004-10-11 23:57:37.000000000 +0200
@@ -67,6 +67,10 @@ typedef u64 dma64_addr_t;
 
 typedef unsigned int kmem_bufctl_t;
 
+typedef struct { volatile int counter; } atomic_t;
+
+#define ATOMIC_INIT(i)	( (atomic_t) { (i) } )
+
 #endif /* __ASSEMBLY__ */
 
 #define BITS_PER_LONG 32
Index: linux-2.6-inc/include/asm-x86_64/types.h
===================================================================
--- linux-2.6-inc.orig/include/asm-x86_64/types.h	2004-06-16 20:27:30.000000000 +0200
+++ linux-2.6-inc/include/asm-x86_64/types.h	2004-10-11 23:57:37.000000000 +0200
@@ -53,6 +53,15 @@ typedef u64 sector_t;
 
 typedef unsigned short kmem_bufctl_t;
 
+/*
+ * Make sure gcc doesn't try to be clever and move things around
+ * on us. We need to use _exactly_ the address the user gave us,
+ * not some alias that contains the same information.
+ */
+typedef struct { volatile int counter; } atomic_t;
+
+#define ATOMIC_INIT(i)	{ (i) }
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
