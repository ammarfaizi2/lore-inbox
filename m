Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263687AbUDVHOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263687AbUDVHOE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 03:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263795AbUDVHMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 03:12:51 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:5820 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263640AbUDVHKM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 03:10:12 -0400
Date: Thu, 22 Apr 2004 00:07:09 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, wli@holomorphy.com, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: [Patch 6 of 17] cpumask v4 - Uninline find_next_bit on ia64
Message-Id: <20040422000709.0dfd1fab.pj@sgi.com>
In-Reply-To: <20040421232247.22ffe1f2.pj@sgi.com>
References: <20040421232247.22ffe1f2.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mask6-unline-find-next-bit-ia64 - Uninline find_next_bit on ia64

	Move the page of code (~700 bytes of instructions)
	for find_next_bit and find_next_zero_bit from inline
	in include/asm-ia64/bitops.h to a real function in
	arch/ia64/lib/bitops.c, leaving a declaration and
	macro wrapper behind.

	The other arch's with almost this same code might want to
	also uninline it: alpha, parisc, ppc, sh, sparc, sparc64.

	These are too big to inline.

Index: 2.6.5.bitmap/include/asm-ia64/bitops.h
===================================================================
--- 2.6.5.bitmap.orig/include/asm-ia64/bitops.h	2004-04-08 03:02:48.000000000 -0700
+++ 2.6.5.bitmap/include/asm-ia64/bitops.h	2004-04-08 03:03:28.000000000 -0700
@@ -11,7 +11,7 @@
 
 #include <linux/compiler.h>
 #include <linux/types.h>
-
+#include <asm/bitops.h>
 #include <asm/intrinsics.h>
 
 /**
@@ -236,7 +236,7 @@
 }
 
 /**
- * test_and_change_bit - Change a bit and return its new value
+ * test_and_change_bit - Change a bit and return its old value
  * @nr: Bit to set
  * @addr: Address to count from
  *
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
Index: 2.6.5.bitmap/include/asm-cris/bitops.h
===================================================================
--- 2.6.5.bitmap.orig/include/asm-cris/bitops.h	2004-04-08 03:02:48.000000000 -0700
+++ 2.6.5.bitmap/include/asm-cris/bitops.h	2004-04-08 03:03:28.000000000 -0700
@@ -169,7 +169,7 @@
 	return retval;
 }
 /**
- * test_and_change_bit - Change a bit and return its new value
+ * test_and_change_bit - Change a bit and return its old value
  * @nr: Bit to change
  * @addr: Address to count from
  *
Index: 2.6.5.bitmap/include/asm-i386/bitops.h
===================================================================
--- 2.6.5.bitmap.orig/include/asm-i386/bitops.h	2004-04-08 03:02:48.000000000 -0700
+++ 2.6.5.bitmap/include/asm-i386/bitops.h	2004-04-08 03:03:28.000000000 -0700
@@ -212,7 +212,7 @@
 }
 
 /**
- * test_and_change_bit - Change a bit and return its new value
+ * test_and_change_bit - Change a bit and return its old value
  * @nr: Bit to change
  * @addr: Address to count from
  *
Index: 2.6.5.bitmap/include/asm-mips/bitops.h
===================================================================
--- 2.6.5.bitmap.orig/include/asm-mips/bitops.h	2004-04-08 03:02:48.000000000 -0700
+++ 2.6.5.bitmap/include/asm-mips/bitops.h	2004-04-08 03:03:28.000000000 -0700
@@ -296,7 +296,7 @@
 }
 
 /*
- * test_and_change_bit - Change a bit and return its new value
+ * test_and_change_bit - Change a bit and return its old value
  * @nr: Bit to change
  * @addr: Address to count from
  *
@@ -567,7 +567,7 @@
 }
 
 /*
- * test_and_change_bit - Change a bit and return its new value
+ * test_and_change_bit - Change a bit and return its old value
  * @nr: Bit to change
  * @addr: Address to count from
  *
Index: 2.6.5.bitmap/include/asm-x86_64/bitops.h
===================================================================
--- 2.6.5.bitmap.orig/include/asm-x86_64/bitops.h	2004-04-08 03:02:48.000000000 -0700
+++ 2.6.5.bitmap/include/asm-x86_64/bitops.h	2004-04-08 03:03:28.000000000 -0700
@@ -204,7 +204,7 @@
 }
 
 /**
- * test_and_change_bit - Change a bit and return its new value
+ * test_and_change_bit - Change a bit and return its old value
  * @nr: Bit to change
  * @addr: Address to count from
  *
Index: 2.6.5.bitmap/arch/ia64/lib/bitop.c
===================================================================
--- 2.6.5.bitmap.orig/arch/ia64/lib/bitop.c	2004-04-08 03:03:18.000000000 -0700
+++ 2.6.5.bitmap/arch/ia64/lib/bitop.c	2004-04-08 03:03:28.000000000 -0700
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
Index: 2.6.5.bitmap/arch/ia64/lib/Makefile
===================================================================
--- 2.6.5.bitmap.orig/arch/ia64/lib/Makefile	2004-04-08 03:01:12.000000000 -0700
+++ 2.6.5.bitmap/arch/ia64/lib/Makefile	2004-04-08 03:03:28.000000000 -0700
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
