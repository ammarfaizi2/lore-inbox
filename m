Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbWIMND6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWIMND6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 09:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWIMNDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 09:03:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42182 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750773AbWIMNDJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 09:03:09 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 5/6] Alter get_order() so that it can make use of long_log2() on a constant
Date: Wed, 13 Sep 2006 14:03:02 +0100
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       dhowells@redhat.com
Message-Id: <20060913130302.32022.98771.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060913130253.32022.69230.stgit@warthog.cambridge.redhat.com>
References: <20060913130253.32022.69230.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Alter get_order() so that it can make use of long_log2() on a constant to
produce a constant value, retaining the ability for an arch to override it in
the non-const case.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 include/asm-generic/page.h |   14 -------------
 include/linux/log2.h       |   46 ++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 44 insertions(+), 16 deletions(-)

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
index 9bef055..a2f6858 100644
--- a/include/linux/log2.h
+++ b/include/linux/log2.h
@@ -1,4 +1,4 @@
-/* Log base 2 calculation
+/* Base 2 logarithm calculation stuff
  *
  * Copyright (C) 2006 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
@@ -25,6 +25,7 @@ int ____log2_NaN(void);
  * non-constant log of base 2 calculation
  * - the arch may override these in asm/bitops.h if they can be implemented
  *   more efficiently than using fls() and fls64()
+ * - the arch is not required to handle n==0 if implementing the fallback
  */
 #ifndef ARCH_HAS_LOG2
 static inline __attribute__((const))
@@ -43,6 +44,36 @@ int __ll_log2(u64 n)
 #endif
 
 /*
+ * non-const pure 2^n version of get_order
+ * - the arch may override these in asm/bitops.h if they can be implemented
+ *   more efficiently than using the arch log2 routines
+ * - we use the non-const log2() instead if the arch has defined one suitable
+ */
+#ifndef ARCH_HAS_GET_ORDER
+static inline __attribute__((const))
+int __get_order(unsigned long size, int page_shift)
+{
+#if BITS_PER_LONG == 32 && defined(ARCH_HAS_LOG2)
+	int order = __log2(size) - page_shift;
+	return order >= 0 ? order : 0;
+#elif BITS_PER_LONG == 64 && defined(ARCH_HAS_LL_LOG2)
+	int order = __ll_log2(size) - page_shift;
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
+/*
  * constant-capable 32-bit log of base 2 calculation
  * - this can be used to initialise global variables from constant data, hence
  *   the massive ternary operator construction
@@ -167,7 +198,7 @@ (						\
  )
 
 /*
- * constant-capable unsigned long log of base 2 calculation
+ * constant-capable log of base 2 calculation of unsigned long
  * - this can be used to initialise global variables from constant data
  */
 #if BITS_PER_LONG == 32
@@ -176,4 +207,15 @@ #else
 #define long_log2(n) ll_log2(n)
 #endif
 
+/*
+ * calculate allocation order based on the current page size
+ * - this can be used to initialise global variables from constant data
+ */
+#define get_order(n)							\
+(									\
+	__builtin_constant_p(n) ?					\
+	((n < (1UL << PAGE_SHIFT)) ? 0 : long_log2(n) - PAGE_SHIFT) :	\
+	__get_order(n, PAGE_SHIFT)					\
+ )
+
 #endif /* _LINUX_LOG2_H */
