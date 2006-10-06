Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbWJFNek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbWJFNek (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 09:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbWJFNek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 09:34:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20898 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932310AbWJFNei (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 09:34:38 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 4/4] LOG2: Provide ilog2() fallbacks for powerpc [try #4]
Date: Fri, 06 Oct 2006 14:34:22 +0100
To: torvalds@osdl.org, akpm@osdl.org, sfr@canb.auug.org.au
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       dhowells@redhat.com
Message-Id: <20061006133422.9972.29416.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20061006133414.9972.79007.stgit@warthog.cambridge.redhat.com>
References: <20061006133414.9972.79007.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Provide ilog2() fallbacks for powerpc for 32-bit numbers and 64-bit numbers on
ppc64.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 arch/powerpc/Kconfig          |    4 ++--
 include/asm-powerpc/bitops.h  |   21 ++++++++++++++++++++-
 include/asm-powerpc/page_32.h |   10 +---------
 3 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 1cf67b7..9515489 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -43,11 +43,11 @@ config RWSEM_XCHGADD_ALGORITHM
 
 config ARCH_HAS_ILOG2_U32
 	bool
-	default n
+	default y
 
 config ARCH_HAS_ILOG2_U64
 	bool
-	default n
+	default y if 64BIT
 
 config GENERIC_HWEIGHT
 	bool
diff --git a/include/asm-powerpc/bitops.h b/include/asm-powerpc/bitops.h
index c341063..0288144 100644
--- a/include/asm-powerpc/bitops.h
+++ b/include/asm-powerpc/bitops.h
@@ -190,7 +190,8 @@ #include <asm-generic/bitops/non-atomic.
  * Return the zero-based bit position (LE, not IBM bit numbering) of
  * the most significant 1-bit in a double word.
  */
-static __inline__ int __ilog2(unsigned long x)
+static __inline__ __attribute__((const))
+int __ilog2(unsigned long x)
 {
 	int lz;
 
@@ -198,6 +199,24 @@ static __inline__ int __ilog2(unsigned l
 	return BITS_PER_LONG - 1 - lz;
 }
 
+static inline __attribute__((const))
+int __ilog2_u32(u32 n)
+{
+	int bit;
+	asm ("cntlzw %0,%1" : "=r" (bit) : "r" (n));
+	return 31 - bit;
+}
+
+#ifdef __powerpc64__
+static inline __attribute__((const))
+int __ilog2_u64(u32 n)
+{
+	int bit;
+	asm ("cntlzd %0,%1" : "=r" (bit) : "r" (n));
+	return 63 - bit;
+}
+#endif
+
 /*
  * Determines the bit position of the least significant 0 bit in the
  * specified double word. The returned bit position will be
diff --git a/include/asm-powerpc/page_32.h b/include/asm-powerpc/page_32.h
index 2677bad..07f6d3c 100644
--- a/include/asm-powerpc/page_32.h
+++ b/include/asm-powerpc/page_32.h
@@ -26,15 +26,7 @@ extern void clear_pages(void *page, int 
 static inline void clear_page(void *page) { clear_pages(page, 0); }
 extern void copy_page(void *to, void *from);
 
-/* Pure 2^n version of get_order */
-extern __inline__ int get_order(unsigned long size)
-{
-	int lz;
-
-	size = (size-1) >> PAGE_SHIFT;
-	asm ("cntlzw %0,%1" : "=r" (lz) : "r" (size));
-	return 32 - lz;
-}
+#include <asm-generic/page.h>
 
 #endif /* __ASSEMBLY__ */
 
