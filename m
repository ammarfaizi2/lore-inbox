Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbWJFNei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbWJFNei (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 09:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbWJFNei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 09:34:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20130 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932174AbWJFNeh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 09:34:37 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 3/4] LOG2: Alter get_order() so that it can make use of ilog2() on a constant [try #4]
Date: Fri, 06 Oct 2006 14:34:20 +0100
To: torvalds@osdl.org, akpm@osdl.org, sfr@canb.auug.org.au
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       dhowells@redhat.com
Message-Id: <20061006133420.9972.82238.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20061006133414.9972.79007.stgit@warthog.cambridge.redhat.com>
References: <20061006133414.9972.79007.stgit@warthog.cambridge.redhat.com>
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

 include/asm-generic/page.h |   38 ++++++++++++++++++++++++++++++++++----
 1 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/page.h b/include/asm-generic/page.h
index a96b5d9..b55052c 100644
--- a/include/asm-generic/page.h
+++ b/include/asm-generic/page.h
@@ -4,21 +4,51 @@ #define _ASM_GENERIC_PAGE_H
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__
 
-#include <linux/compiler.h>
+#include <linux/log2.h>
 
-/* Pure 2^n version of get_order */
-static __inline__ __attribute_const__ int get_order(unsigned long size)
+/*
+ * non-const pure 2^n version of get_order
+ * - the arch may override these in asm/bitops.h if they can be implemented
+ *   more efficiently than using the arch log2 routines
+ * - we use the non-const log2() instead if the arch has defined one suitable
+ */
+#ifndef ARCH_HAS_GET_ORDER
+static inline __attribute__((const))
+int __get_order(unsigned long size, int page_shift)
 {
+#if BITS_PER_LONG == 32 && defined(ARCH_HAS_ILOG2_U32)
+	int order = __ilog2_u32(size) - page_shift;
+	return order >= 0 ? order : 0;
+#elif BITS_PER_LONG == 64 && defined(ARCH_HAS_ILOG2_U64)
+	int order = __ilog2_u64(size) - page_shift;
+	return order >= 0 ? order : 0;
+#else
 	int order;
 
-	size = (size - 1) >> (PAGE_SHIFT - 1);
+	size = (size - 1) >> (page_shift - 1);
 	order = -1;
 	do {
 		size >>= 1;
 		order++;
 	} while (size);
 	return order;
+#endif
 }
+#endif
+
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
 
 #endif	/* __ASSEMBLY__ */
 #endif	/* __KERNEL__ */
