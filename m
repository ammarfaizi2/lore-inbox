Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbWIMSgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbWIMSgK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 14:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWIMSgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 14:36:03 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6543 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751089AbWIMSfq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 14:35:46 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 5/7] Alter get_order() so that it can make use of ilog2() on a constant [try #3]
Date: Wed, 13 Sep 2006 19:35:31 +0100
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       dhowells@redhat.com
Message-Id: <20060913183531.22109.85723.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060913183522.22109.10565.stgit@warthog.cambridge.redhat.com>
References: <20060913183522.22109.10565.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Alter get_order() so that it can make use of ilog2() on a constant to produce a
constant value, retaining the ability for an arch to override it in the
non-const case.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 include/asm-generic/page.h |   14 --------------
 include/linux/log2.h       |   45 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 14 deletions(-)

diff --git a/include/asm-generic/page.h b/include/asm-generic/page.h
index a96b5d9..a7e374e 100644
--- a/include/asm-generic/page.h
+++ b/include/asm-generic/page.h
@@ -6,20 +6,6 @@ #ifndef __ASSEMBLY__
 
 #include <linux/compiler.h>
 
-/* Pure 2^n version of get_order */
-static __inline__ __attribute_const__ int get_order(unsigned long size)
-{
-	int order;
-
-	size = (size - 1) >> (PAGE_SHIFT - 1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
-}
-
 #endif	/* __ASSEMBLY__ */
 #endif	/* __KERNEL__ */
 
diff --git a/include/linux/log2.h b/include/linux/log2.h
index 6ce81b7..88b7b0e 100644
--- a/include/linux/log2.h
+++ b/include/linux/log2.h
@@ -25,6 +25,7 @@ int ____ilog2_NaN(void);
  * non-constant log of base 2 calculators
  * - the arch may override these in asm/bitops.h if they can be implemented
  *   more efficiently than using fls() and fls64()
+ * - the arch is not required to handle n==0 if implementing the fallback
  */
 #ifndef ARCH_HAS_ILOG2_U32
 static inline __attribute__((const))
@@ -42,6 +43,36 @@ int __ilog2_u64(u64 n)
 }
 #endif
 
+/*
+ * non-const pure 2^n version of get_order
+ * - the arch may override these in asm/bitops.h if they can be implemented
+ *   more efficiently than using the arch log2 routines
+ * - we use the non-const log2() instead if the arch has defined one suitable
+ */
+#ifndef ARCH_HAS_GET_ORDER
+static inline __attribute__((const))
+int __get_order(unsigned long size, int page_shift)
+{
+#if BITS_PER_LONG == 32 && defined(ARCH_HAS_ILOG2_U32)
+	int order = __ilog2_u32(size) - page_shift;
+	return order >= 0 ? order : 0;
+#elif BITS_PER_LONG == 64 && defined(ARCH_HAS_ILOG2_U64)
+	int order = __ilog2_u64(size) - page_shift;
+	return order >= 0 ? order : 0;
+#else
+	int order;
+
+	size = (size - 1) >> (page_shift - 1);
+	order = -1;
+	do {
+		size >>= 1;
+		order++;
+	} while (size);
+	return order;
+#endif
+}
+#endif
+
 /**
  * ilog2_u32 - log of base 2 of 32-bit unsigned value
  * @n - parameter
@@ -185,4 +216,18 @@ #else
 #define ilog2(n) ilog2_u64(n)
 #endif
 
+/**
+ * get_order - calculate log2(pages) to hold a block of the specified size
+ * @n - size
+ *
+ * calculate allocation order based on the current page size
+ * - this can be used to initialise global variables from constant data
+ */
+#define get_order(n)							\
+(									\
+	__builtin_constant_p(n) ?					\
+	((n < (1UL << PAGE_SHIFT)) ? 0 : ilog2(n) - PAGE_SHIFT) :	\
+	__get_order(n, PAGE_SHIFT)					\
+ )
+
 #endif /* _LINUX_LOG2_H */
