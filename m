Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264044AbUFCRXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264044AbUFCRXd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 13:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264965AbUFCRVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 13:21:30 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:56800 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S264373AbUFCRMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 13:12:03 -0400
Date: Thu, 3 Jun 2004 10:09:56 -0700
From: Paul Jackson <pj@sgi.com>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@muc.de>, Ashok Raj <ashok.raj@intel.com>,
       Christoph Hellwig <hch@infradead.org>, Jesse Barnes <jbarnes@sgi.com>,
       Joe Korty <joe.korty@ccur.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Mikael Pettersson <mikpe@csd.uu.se>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Paul Jackson <pj@sgi.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Simon Derr <Simon.Derr@bull.net>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: [PATCH] cpumask 4/10 uninline find_next_bit on ia64
Message-Id: <20040603100956.7c082b45.pj@sgi.com>
In-Reply-To: <20040603094339.03ddfd42.pj@sgi.com>
References: <20040603094339.03ddfd42.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cpumask 4/10 uninline find_next_bit on ia64

	Move the page of code (~700 bytes of instructions)
	for find_next_bit and find_next_zero_bit from inline
	in include/asm-ia64/bitops.h to a real function in
	arch/ia64/lib/bitops.c, leaving a declaration and
	macro wrapper behind.

	The other arch's with almost this same code might want to
	also uninline it: alpha, parisc, ppc, sh, sparc, sparc64.

	These are too big to inline.

 arch/ia64/lib/Makefile    |    2 
 arch/ia64/lib/bitop.c     |   88 ++++++++++++++++++++++
 include/asm-ia64/bitops.h |   92 ++---------------------
 3 files changed, 99 insertions(+), 83 deletions(-)

Signed-off-by: Paul Jackson <pj@sgi.com>

Index: 2.6.7-rc2-mm2/include/asm-ia64/bitops.h
===================================================================
--- 2.6.7-rc2-mm2.orig/include/asm-ia64/bitops.h	2004-06-03 05:39:28.000000000 -0700
+++ 2.6.7-rc2-mm2/include/asm-ia64/bitops.h	2004-06-03 05:57:10.000000000 -0700
@@ -11,7 +11,7 @@
 
 #include <linux/compiler.h>
 #include <linux/types.h>
-
+#include <asm/bitops.h>
 #include <asm/intrinsics.h>
 
 /**
@@ -359,93 +359,21 @@
 
 #endif /* __KERNEL__ */
 
-/*
- * Find next zero bit in a bitmap reasonably efficiently..
- */
-static inline int
-find_next_zero_bit (void *addr, unsigned long size, unsigned long offset)
-{
-	unsigned long *p = ((unsigned long *) addr) + (offset >> 6);
-	unsigned long result = offset & ~63UL;
-	unsigned long tmp;
-
-	if (offset >= size)
-		return size;
-	size -= result;
-	offset &= 63UL;
-	if (offset) {
-		tmp = *(p++);
-		tmp |= ~0UL >> (64-offset);
-		if (size < 64)
-			goto found_first;
-		if (~tmp)
-			goto found_middle;
-		size -= 64;
-		result += 64;
-	}
-	while (size & ~63UL) {
-		if (~(tmp = *(p++)))
-			goto found_middle;
-		result += 64;
-		size -= 64;
-	}
-	if (!size)
-		return result;
-	tmp = *p;
-found_first:
-	tmp |= ~0UL << size;
-	if (tmp == ~0UL)		/* any bits zero? */
-		return result + size;	/* nope */
-found_middle:
-	return result + ffz(tmp);
-}
+extern int __find_next_zero_bit (void *addr, unsigned long size, \
+			unsigned long offset);
+extern int __find_next_bit(const void *addr, unsigned long size, \
+			unsigned long offset);
+
+#define find_next_zero_bit(addr, size, offset) \
+			__find_next_zero_bit((addr), (size), (offset))
+#define find_next_bit(addr, size, offset) \
+			__find_next_bit((addr), (size), (offset))
 
 /*
  * The optimizer actually does good code for this case..
  */
 #define find_first_zero_bit(addr, size) find_next_zero_bit((addr), (size), 0)
 
-/*
- * Find next bit in a bitmap reasonably efficiently..
- */
-static inline int
-find_next_bit(const void *addr, unsigned long size, unsigned long offset)
-{
-	unsigned long *p = ((unsigned long *) addr) + (offset >> 6);
-	unsigned long result = offset & ~63UL;
-	unsigned long tmp;
-
-	if (offset >= size)
-		return size;
-	size -= result;
-	offset &= 63UL;
-	if (offset) {
-		tmp = *(p++);
-		tmp &= ~0UL << offset;
-		if (size < 64)
-			goto found_first;
-		if (tmp)
-			goto found_middle;
-		size -= 64;
-		result += 64;
-	}
-	while (size & ~63UL) {
-		if ((tmp = *(p++)))
-			goto found_middle;
-		result += 64;
-		size -= 64;
-	}
-	if (!size)
-		return result;
-	tmp = *p;
-  found_first:
-	tmp &= ~0UL >> (64-size);
-	if (tmp == 0UL)		/* Are any bits set? */
-		return result + size; /* Nope. */
-  found_middle:
-	return result + __ffs(tmp);
-}
-
 #define find_first_bit(addr, size) find_next_bit((addr), (size), 0)
 
 #ifdef __KERNEL__
Index: 2.6.7-rc2-mm2/arch/ia64/lib/bitop.c
===================================================================
--- 2.6.7-rc2-mm2.orig/arch/ia64/lib/bitop.c	2004-06-03 05:57:10.000000000 -0700
+++ 2.6.7-rc2-mm2/arch/ia64/lib/bitop.c	2004-06-03 05:57:10.000000000 -0700
@@ -0,0 +1,88 @@
+#include <linux/compiler.h>
+#include <linux/types.h>
+#include <asm/intrinsics.h>
+#include <linux/module.h>
+#include <asm/bitops.h>
+
+/*
+ * Find next zero bit in a bitmap reasonably efficiently..
+ */
+
+int __find_next_zero_bit (void *addr, unsigned long size, unsigned long offset)
+{
+	unsigned long *p = ((unsigned long *) addr) + (offset >> 6);
+	unsigned long result = offset & ~63UL;
+	unsigned long tmp;
+
+	if (offset >= size)
+		return size;
+	size -= result;
+	offset &= 63UL;
+	if (offset) {
+		tmp = *(p++);
+		tmp |= ~0UL >> (64-offset);
+		if (size < 64)
+			goto found_first;
+		if (~tmp)
+			goto found_middle;
+		size -= 64;
+		result += 64;
+	}
+	while (size & ~63UL) {
+		if (~(tmp = *(p++)))
+			goto found_middle;
+		result += 64;
+		size -= 64;
+	}
+	if (!size)
+		return result;
+	tmp = *p;
+found_first:
+	tmp |= ~0UL << size;
+	if (tmp == ~0UL)		/* any bits zero? */
+		return result + size;	/* nope */
+found_middle:
+	return result + ffz(tmp);
+}
+EXPORT_SYMBOL(__find_next_zero_bit);
+
+/*
+ * Find next bit in a bitmap reasonably efficiently..
+ */
+int __find_next_bit(const void *addr, unsigned long size, unsigned long offset)
+{
+	unsigned long *p = ((unsigned long *) addr) + (offset >> 6);
+	unsigned long result = offset & ~63UL;
+	unsigned long tmp;
+
+	if (offset >= size)
+		return size;
+	size -= result;
+	offset &= 63UL;
+	if (offset) {
+		tmp = *(p++);
+		tmp &= ~0UL << offset;
+		if (size < 64)
+			goto found_first;
+		if (tmp)
+			goto found_middle;
+		size -= 64;
+		result += 64;
+	}
+	while (size & ~63UL) {
+		if ((tmp = *(p++)))
+			goto found_middle;
+		result += 64;
+		size -= 64;
+	}
+	if (!size)
+		return result;
+	tmp = *p;
+  found_first:
+	tmp &= ~0UL >> (64-size);
+	if (tmp == 0UL)		/* Are any bits set? */
+		return result + size; /* Nope. */
+  found_middle:
+	return result + __ffs(tmp);
+}
+EXPORT_SYMBOL(__find_next_bit);
Index: 2.6.7-rc2-mm2/arch/ia64/lib/Makefile
===================================================================
--- 2.6.7-rc2-mm2.orig/arch/ia64/lib/Makefile	2004-06-03 05:43:00.000000000 -0700
+++ 2.6.7-rc2-mm2/arch/ia64/lib/Makefile	2004-06-03 05:57:10.000000000 -0700
@@ -6,7 +6,7 @@
 
 lib-y := __divsi3.o __udivsi3.o __modsi3.o __umodsi3.o			\
 	__divdi3.o __udivdi3.o __moddi3.o __umoddi3.o			\
-	checksum.o clear_page.o csum_partial_copy.o copy_page.o		\
+	bitop.o checksum.o clear_page.o csum_partial_copy.o copy_page.o	\
 	clear_user.o strncpy_from_user.o strlen_user.o strnlen_user.o	\
 	flush.o ip_fast_csum.o do_csum.o				\
 	memset.o strlen.o swiotlb.o


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
