Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264269AbUFXLch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264269AbUFXLch (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 07:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264270AbUFXLch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 07:32:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19177 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264269AbUFXLcQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 07:32:16 -0400
Date: Thu, 24 Jun 2004 13:31:51 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: using gcc built-ins for bitops?
Message-ID: <20040624113151.GA21376@devserv.devel.redhat.com>
References: <20040624070936.GB30057@devserv.devel.redhat.com> <20040624020022.0601d4ae.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624020022.0601d4ae.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 02:00:22AM -0700, Andrew Morton wrote:
> For the implementation it would be nice to have the old-style
> implementations in one header and the new-style ones in a separate header. 
> That would create a bit of an all-or-nothing situation, but that should be
> OK?

In addition I stuck those in asm-generic since they no longer are
architecture specific....

diff -purN linux-2.6.7/include/asm-i386/bitops.h linux/include/asm-i386/bitops.h
--- linux-2.6.7/include/asm-i386/bitops.h	2004-06-24 17:26:10.030404507 +0200
+++ linux/include/asm-i386/bitops.h	2004-06-24 18:47:26.582837487 +0200
@@ -338,34 +338,6 @@ static inline int find_first_bit(const u
  */
 int find_next_bit(const unsigned long *addr, int size, int offset);
 
-/**
- * ffz - find first zero in word.
- * @word: The word to search
- *
- * Undefined if no zero exists, so code should check against ~0UL first.
- */
-static inline unsigned long ffz(unsigned long word)
-{
-	__asm__("bsfl %1,%0"
-		:"=r" (word)
-		:"r" (~word));
-	return word;
-}
-
-/**
- * __ffs - find first bit in word.
- * @word: The word to search
- *
- * Undefined if no bit exists, so code should check against 0 first.
- */
-static inline unsigned long __ffs(unsigned long word)
-{
-	__asm__("bsfl %1,%0"
-		:"=r" (word)
-		:"rm" (word));
-	return word;
-}
-
 /*
  * fls: find last bit set.
  */
@@ -374,6 +346,12 @@ static inline unsigned long __ffs(unsign
 
 #ifdef __KERNEL__
 
+#ifdef USE_BUILTIN_BITOPS
+#include <asm-generic/bitops_gcc.h>
+#else
+#include <asm/bitops_asm.h>
+#endif
+
 /*
  * Every architecture must define this function. It's the fastest
  * way of searching a 140-bit bitmap where the first 100 bits are
@@ -394,25 +372,6 @@ static inline int sched_find_first_bit(c
 }
 
 /**
- * ffs - find first bit set
- * @x: the word to search
- *
- * This is defined the same way as
- * the libc and compiler builtin ffs routines, therefore
- * differs in spirit from the above ffz (man ffs).
- */
-static inline int ffs(int x)
-{
-	int r;
-
-	__asm__("bsfl %1,%0\n\t"
-		"jnz 1f\n\t"
-		"movl $-1,%0\n"
-		"1:" : "=r" (r) : "rm" (x));
-	return r+1;
-}
-
-/**
  * hweightN - returns the hamming weight of a N-bit word
  * @x: the word to weigh
  *
diff -purN linux-2.6.7/include/asm-generic/bitops_gcc.h linux/include/asm-generic/bitops_gcc.h
--- linux-2.6.7/include/asm-generic/bitops_gcc.h	1970-01-01 01:00:00.000000000 +0100
+++ linux/include/asm-generic/bitops_gcc.h	2004-06-24 18:45:03.483991176 +0200
@@ -0,0 +1,61 @@
+#ifndef _I386_BITOPS_GCC_H
+#define _I386_BITOPS_GCC_H
+
+/*
+ * Copyright 1992, Linus Torvalds.
+ * 
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *
+ * June 2004 - Modified by Arjan van de Ven <arjanv@redhat.com> to use gcc builtin's
+ *
+ */
+
+
+/**
+ * ffz - find first zero in word.
+ * @word: The word to search
+ *
+ * Undefined if no zero exists, so code should check against ~0UL first.
+ */
+static inline unsigned long ffz(unsigned long word)
+{
+	return __builtin_ctzl(~word);
+}
+
+/**
+ * __ffs - find first bit in word.
+ * @word: The word to search
+ *
+ * Undefined if no bit exists, so code should check against 0 first.
+ */
+static inline unsigned long __ffs(unsigned long word)
+{
+	return __builtin_ctzl(word);
+}
+
+/**
+ * ffs - find first bit set
+ * @x: the word to search
+ *
+ * This is defined the same way as
+ * the libc and compiler builtin ffs routines, therefore
+ * differs in spirit from the above ffz (man ffs).
+ */
+static inline int ffs(int x)
+{
+	return __builtin_ffs(x);
+}
+
+#endif /* _I386_BITOPS_GCC_H */
diff -purN linux-2.6.7/include/asm-i386/bitops_asm.h linux/include/asm-i386/bitops_asm.h
--- linux-2.6.7/include/asm-i386/bitops_asm.h	1970-01-01 01:00:00.000000000 +0100
+++ linux/include/asm-i386/bitops_asm.h	2004-06-24 18:45:15.669530459 +0200
@@ -0,0 +1,56 @@
+#ifndef _I386_BITOPS_ASM_H
+#define _I386_BITOPS_ASM_H
+
+/*
+ * Copyright 1992, Linus Torvalds.
+ */
+
+
+/**
+ * ffz - find first zero in word.
+ * @word: The word to search
+ *
+ * Undefined if no zero exists, so code should check against ~0UL first.
+ */
+static inline unsigned long ffz(unsigned long word)
+{
+	__asm__("bsfl %1,%0"
+		:"=r" (word)
+		:"r" (~word));
+	return word;
+}
+
+/**
+ * __ffs - find first bit in word.
+ * @word: The word to search
+ *
+ * Undefined if no bit exists, so code should check against 0 first.
+ */
+static inline unsigned long __ffs(unsigned long word)
+{
+	__asm__("bsfl %1,%0"
+		:"=r" (word)
+		:"rm" (word));
+	return word;
+}
+
+/**
+ * ffs - find first bit set
+ * @x: the word to search
+ *
+ * This is defined the same way as
+ * the libc and compiler builtin ffs routines, therefore
+ * differs in spirit from the above ffz (man ffs).
+ */
+static inline int ffs(int x)
+{
+	int r;
+
+	__asm__("bsfl %1,%0\n\t"
+		"jnz 1f\n\t"
+		"movl $-1,%0\n"
+		"1:" : "=r" (r) : "rm" (x));
+	return r+1;
+}
+
+#endif /* _I386_BITOPS_ASM_H */
diff -purN linux-2.6.7/include/linux/compiler-gcc+.h linux/include/linux/compiler-gcc+.h
--- linux-2.6.7/include/linux/compiler-gcc+.h	2004-06-24 17:26:10.513346616 +0200
+++ linux/include/linux/compiler-gcc+.h	2004-06-24 18:48:29.266323429 +0200
@@ -6,6 +6,7 @@
  */
 #include <linux/compiler-gcc.h>
 
+#define USE_BUILTIN_BITOPS
 #define inline			__inline__ __attribute__((always_inline))
 #define __inline__		__inline__ __attribute__((always_inline))
 #define __inline		__inline__ __attribute__((always_inline))
diff -purN linux-2.6.7/include/linux/compiler-gcc3.h linux/include/linux/compiler-gcc3.h
--- linux-2.6.7/include/linux/compiler-gcc3.h	2004-06-24 17:26:10.511346855 +0200
+++ linux/include/linux/compiler-gcc3.h	2004-06-24 18:48:16.189890940 +0200
@@ -19,6 +19,10 @@
 # define __attribute_used__	__attribute__((__unused__))
 #endif
 
+#if __GNUC_MINOR__ >= 4
+#define USE_BUILTIN_BITOPS
+#endif
+
 #define __attribute_pure__	__attribute__((pure))
 #define __attribute_const__	__attribute__((__const__))
 
