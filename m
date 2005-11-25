Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751428AbVKYNcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbVKYNcb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 08:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbVKYNcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 08:32:31 -0500
Received: from mail.renesas.com ([202.234.163.13]:4815 "EHLO
	mail02.idc.renesas.com") by vger.kernel.org with ESMTP
	id S1751428AbVKYNca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 08:32:30 -0500
Date: Fri, 25 Nov 2005 22:32:22 +0900 (JST)
Message-Id: <20051125.223222.861035853.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, fujiwara@linux-m32r.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, takata@linux-m32r.org
Subject: [PATCH 2.6.15-rc2-mm1] m32r: Introduce atomic_cmpxchg and
 atomic_inc_not_zero operations
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.17 (Jumbo Shrimp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce atomic_cmpxchg and atomic_inc_not_zero operations for m32r.

Signed-off-by: Hayato Fujiwara <fujiwara@linux-m32r.org>
Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 include/asm-m32r/atomic.h |   21 +++++++++++++++
 include/asm-m32r/system.h |   64 ++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 83 insertions(+), 2 deletions(-)

Index: linux-2.6.15-rc2-mm1/include/asm-m32r/atomic.h
===================================================================
--- linux-2.6.15-rc2-mm1.orig/include/asm-m32r/atomic.h	2005-11-20 12:25:03.000000000 +0900
+++ linux-2.6.15-rc2-mm1/include/asm-m32r/atomic.h	2005-11-25 21:38:12.481890968 +0900
@@ -242,6 +242,27 @@ static __inline__ int atomic_dec_return(
  */
 #define atomic_add_negative(i,v) (atomic_add_return((i), (v)) < 0)
 
+#define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
+
+/**
+ * atomic_add_unless - add unless the number is a given value
+ * @v: pointer of type atomic_t
+ * @a: the amount to add to v...
+ * @u: ...unless v is equal to u.
+ *
+ * Atomically adds @a to @v, so long as it was not @u.
+ * Returns non-zero if @v was not @u, and zero otherwise.
+ */
+#define atomic_add_unless(v, a, u)				\
+({								\
+	int c, old;						\
+	c = atomic_read(v);					\
+	while (c != (u) && (old = atomic_cmpxchg((v), c, c + (a))) != c) \
+		c = old;					\
+	c != (u);						\
+})
+#define atomic_inc_not_zero(v) atomic_add_unless((v), 1, 0)
+
 static __inline__ void atomic_clear_mask(unsigned long  mask, atomic_t *addr)
 {
 	unsigned long flags;
Index: linux-2.6.15-rc2-mm1/include/asm-m32r/system.h
===================================================================
--- linux-2.6.15-rc2-mm1.orig/include/asm-m32r/system.h	2005-11-24 18:30:43.000000000 +0900
+++ linux-2.6.15-rc2-mm1/include/asm-m32r/system.h	2005-11-25 21:38:12.499888232 +0900
@@ -11,6 +11,7 @@
  */
 
 #include <linux/config.h>
+#include <asm/assembler.h>
 
 #ifdef __KERNEL__
 
@@ -142,8 +143,6 @@ static inline void local_irq_disable(voi
 		!(flags & 0x40);			\
 	})
 
-#endif  /* __KERNEL__ */
-
 #define nop()	__asm__ __volatile__ ("nop" : : )
 
 #define xchg(ptr,x) \
@@ -223,6 +222,67 @@ static __inline__ unsigned long __xchg(u
 	return (tmp);
 }
 
+#define __HAVE_ARCH_CMPXCHG	1
+
+static __inline__ unsigned long
+__cmpxchg_u32(volatile unsigned int *p, unsigned int old, unsigned int new)
+{
+	unsigned long flags;
+	unsigned int retval;
+
+	local_irq_save(flags);
+	__asm__ __volatile__ (
+			DCACHE_CLEAR("%0", "r4", "%1")
+			M32R_LOCK" %0, @%1;	\n"
+		"	bne	%0, %2, 1f;	\n"
+			M32R_UNLOCK" %3, @%1;	\n"
+		"	bra	2f;		\n"
+                "       .fillinsn		\n"
+		"1:"
+			M32R_UNLOCK" %2, @%1;	\n"
+                "       .fillinsn		\n"
+		"2:"
+			: "=&r" (retval)
+			: "r" (p), "r" (old), "r" (new)
+			: "cbit", "memory"
+#ifdef CONFIG_CHIP_M32700_TS1
+			, "r4"
+#endif  /* CONFIG_CHIP_M32700_TS1 */
+		);
+	local_irq_restore(flags);
+
+	return retval;
+}
+
+/* This function doesn't exist, so you'll get a linker error
+   if something tries to do an invalid cmpxchg().  */
+extern void __cmpxchg_called_with_bad_pointer(void);
+
+static __inline__ unsigned long
+__cmpxchg(volatile void *ptr, unsigned long old, unsigned long new, int size)
+{
+	switch (size) {
+	case 4:
+		return __cmpxchg_u32(ptr, old, new);
+#if 0	/* we don't have __cmpxchg_u64 */
+	case 8:
+		return __cmpxchg_u64(ptr, old, new);
+#endif /* 0 */
+	}
+	__cmpxchg_called_with_bad_pointer();
+	return old;
+}
+
+#define cmpxchg(ptr,o,n)						 \
+  ({									 \
+     __typeof__(*(ptr)) _o_ = (o);					 \
+     __typeof__(*(ptr)) _n_ = (n);					 \
+     (__typeof__(*(ptr))) __cmpxchg((ptr), (unsigned long)_o_,		 \
+				    (unsigned long)_n_, sizeof(*(ptr))); \
+  })
+
+#endif  /* __KERNEL__ */
+
 /*
  * Memory barrier.
  *

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
