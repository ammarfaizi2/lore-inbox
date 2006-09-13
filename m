Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbWIMNEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbWIMNEN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 09:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWIMNEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 09:04:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48070 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750771AbWIMNDM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 09:03:12 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 4/6] Implement a general log2 facility in the kernel
Date: Wed, 13 Sep 2006 14:03:00 +0100
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       dhowells@redhat.com
Message-Id: <20060913130300.32022.69743.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060913130253.32022.69230.stgit@warthog.cambridge.redhat.com>
References: <20060913130253.32022.69230.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

This facility provides three entry points:

	log2()		Log base 2 of u32
	ll_log2()	Log base 2 of u64
	long_log2()	Log base 2 of unsigned long

These facilities can either be used inside functions on dynamic data:

	int do_something(long q)
	{
		...;
		y = log2(x)
		...;
	}

Or can be used to statically initialise global variables with constant values:

	unsigned n = log2(27);

When performing static initialisation, the compiler will report "error:
initializer element is not constant" if asked to take a log of zero or of
something not reducible to a constant.  They treat negative numbers as
unsigned.


When not dealing with a constant, they fall back to using fls() which permits
them to use arch-specific log calculation instructions - such as BSR on
x86/x86_64 or SCAN on FRV - if available.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/ext2/super.c          |    2 -
 fs/ext3/super.c          |    2 -
 include/asm-frv/bitops.h |   44 +++++++++++
 include/linux/kernel.h   |    9 --
 include/linux/log2.h     |  179 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 224 insertions(+), 12 deletions(-)

diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 681dea8..a4573b6 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -548,8 +548,6 @@ static int ext2_check_descriptors (struc
 	return 1;
 }
 
-#define log2(n) ffz(~(n))
- 
 /*
  * Maximal file size.  There is a direct, and {,double-,triple-}indirect
  * block limit, and also a limit of (2^32 - 1) 512-byte sectors in i_blocks.
diff --git a/fs/ext3/super.c b/fs/ext3/super.c
index 813d589..af1424d 100644
--- a/fs/ext3/super.c
+++ b/fs/ext3/super.c
@@ -1294,8 +1294,6 @@ #endif
 	sb->s_flags = s_flags; /* Restore MS_RDONLY status */
 }
 
-#define log2(n) ffz(~(n))
-
 /*
  * Maximal file size.  There is a direct, and {,double-,triple-}indirect
  * block limit, and also a limit of (2^32 - 1) 512-byte sectors in i_blocks.
diff --git a/include/asm-frv/bitops.h b/include/asm-frv/bitops.h
index 1f70d47..41a5866 100644
--- a/include/asm-frv/bitops.h
+++ b/include/asm-frv/bitops.h
@@ -256,6 +256,50 @@ int __ffs(unsigned long x)
 	return 31 - bit;
 }
 
+/*
+ * special slimline version of fls() for calculating log2()
+ * - note: no protection against n == 0
+ */
+#define ARCH_HAS_LOG2
+static inline __attribute__((const))
+int __log2(u32 n)
+{
+	int bit;
+	asm("scan %1,gr0,%0" : "=r"(bit) : "r"(n));
+	return 31 - bit;
+}
+
+/*
+ * special slimline version of fls64() for calculating ll_log2()
+ * - note: no protection against n == 0
+ */
+#define ARCH_HAS_LL_LOG2
+static inline __attribute__((const))
+int __ll_log2(u64 n)
+{
+	union {
+		u64 ll;
+		struct { u32 h, l; };
+	} _;
+	int bit, x, y;
+
+	_.ll = n;
+
+	asm("	subcc		%3,gr0,gr0,icc0		\n"
+	    "	ckeq		icc0,cc4		\n"
+	    "	cscan.p		%3,gr0,%0	,cc4,0	\n"
+	    "   setlos		#63,%1			\n"
+	    "	cscan.p		%4,gr0,%0	,cc4,1	\n"
+	    "   setlos		#31,%2			\n"
+	    "	csub.p		%1,%0,%0	,cc4,0	\n"
+	    "	csub		%2,%0,%0	,cc4,1	\n"
+	    : "=&r"(bit), "=r"(x), "=r"(y)
+	    : "0r"(_.h), "r"(_.l)
+	    : "icc0", "cc4"
+	    );
+	return bit;
+}
+
 #include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/hweight.h>
 
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 851aa1b..e8c6c66 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -13,6 +13,7 @@ #include <linux/stddef.h>
 #include <linux/types.h>
 #include <linux/compiler.h>
 #include <linux/bitops.h>
+#include <linux/log2.h>
 #include <asm/byteorder.h>
 #include <asm/bug.h>
 
@@ -154,14 +155,6 @@ #endif
 
 unsigned long int_sqrt(unsigned long);
 
-static inline int __attribute_pure__ long_log2(unsigned long x)
-{
-	int r = 0;
-	for (x >>= 1; x > 0; x >>= 1)
-		r++;
-	return r;
-}
-
 static inline unsigned long
 __attribute_const__ roundup_pow_of_two(unsigned long x)
 {
diff --git a/include/linux/log2.h b/include/linux/log2.h
new file mode 100644
index 0000000..9bef055
--- /dev/null
+++ b/include/linux/log2.h
@@ -0,0 +1,179 @@
+/* Log base 2 calculation
+ *
+ * Copyright (C) 2006 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _LINUX_LOG2_H
+#define _LINUX_LOG2_H
+
+#include <linux/types.h>
+#include <linux/bitops.h>
+
+/*
+ * deal with unrepresentable constant logarithms
+ */
+extern __attribute__((const, noreturn))
+int ____log2_NaN(void);
+
+/*
+ * non-constant log of base 2 calculation
+ * - the arch may override these in asm/bitops.h if they can be implemented
+ *   more efficiently than using fls() and fls64()
+ */
+#ifndef ARCH_HAS_LOG2
+static inline __attribute__((const))
+int __log2(u32 n)
+{
+	return fls(n) - 1;
+}
+#endif
+
+#ifndef ARCH_HAS_LL_LOG2
+static inline __attribute__((const))
+int __ll_log2(u64 n)
+{
+	return fls64(n) - 1;
+}
+#endif
+
+/*
+ * constant-capable 32-bit log of base 2 calculation
+ * - this can be used to initialise global variables from constant data, hence
+ *   the massive ternary operator construction
+ */
+#define log2(n)					\
+(						\
+	__builtin_constant_p(n) ? (		\
+		n < 1 ? ____log2_NaN() :	\
+		n >= (1ULL << 31) ? 31 :	\
+		n >= (1ULL << 30) ? 30 :	\
+		n >= (1ULL << 29) ? 29 :	\
+		n >= (1ULL << 28) ? 28 :	\
+		n >= (1ULL << 27) ? 27 :	\
+		n >= (1ULL << 26) ? 26 :	\
+		n >= (1ULL << 25) ? 25 :	\
+		n >= (1ULL << 24) ? 24 :	\
+		n >= (1ULL << 23) ? 23 :	\
+		n >= (1ULL << 22) ? 22 :	\
+		n >= (1ULL << 21) ? 21 :	\
+		n >= (1ULL << 20) ? 20 :	\
+		n >= (1ULL << 19) ? 19 :	\
+		n >= (1ULL << 18) ? 18 :	\
+		n >= (1ULL << 17) ? 17 :	\
+		n >= (1ULL << 16) ? 16 :	\
+		n >= (1ULL << 15) ? 15 :	\
+		n >= (1ULL << 14) ? 14 :	\
+		n >= (1ULL << 13) ? 13 :	\
+		n >= (1ULL << 12) ? 12 :	\
+		n >= (1ULL << 11) ? 11 :	\
+		n >= (1ULL << 10) ? 10 :	\
+		n >= (1ULL <<  9) ?  9 :	\
+		n >= (1ULL <<  8) ?  8 :	\
+		n >= (1ULL <<  7) ?  7 :	\
+		n >= (1ULL <<  6) ?  6 :	\
+		n >= (1ULL <<  5) ?  5 :	\
+		n >= (1ULL <<  4) ?  4 :	\
+		n >= (1ULL <<  3) ?  3 :	\
+		n >= (1ULL <<  2) ?  2 :	\
+		n >= (1ULL <<  1) ?  1 :	\
+		n >= (1ULL <<  0) ?  0 :	\
+		____log2_NaN()			\
+				   ) :		\
+	__log2(n)				\
+ )
+
+/*
+ * constant-capable 64-bit log of base 2 calculation
+ * - this can be used to initialise global variables from constant data, hence
+ *   the massive ternary operator construction
+ */
+#define ll_log2(n)				\
+(						\
+	__builtin_constant_p(n) ? (		\
+		n < 1 ? ____log2_NaN() :	\
+		n >= (1ULL << 63) ? 63 :	\
+		n >= (1ULL << 62) ? 62 :	\
+		n >= (1ULL << 61) ? 61 :	\
+		n >= (1ULL << 60) ? 60 :	\
+		n >= (1ULL << 59) ? 59 :	\
+		n >= (1ULL << 58) ? 58 :	\
+		n >= (1ULL << 57) ? 57 :	\
+		n >= (1ULL << 56) ? 56 :	\
+		n >= (1ULL << 55) ? 55 :	\
+		n >= (1ULL << 54) ? 54 :	\
+		n >= (1ULL << 53) ? 53 :	\
+		n >= (1ULL << 52) ? 52 :	\
+		n >= (1ULL << 51) ? 51 :	\
+		n >= (1ULL << 50) ? 50 :	\
+		n >= (1ULL << 49) ? 49 :	\
+		n >= (1ULL << 48) ? 48 :	\
+		n >= (1ULL << 47) ? 47 :	\
+		n >= (1ULL << 46) ? 46 :	\
+		n >= (1ULL << 45) ? 45 :	\
+		n >= (1ULL << 44) ? 44 :	\
+		n >= (1ULL << 43) ? 43 :	\
+		n >= (1ULL << 42) ? 42 :	\
+		n >= (1ULL << 41) ? 41 :	\
+		n >= (1ULL << 40) ? 40 :	\
+		n >= (1ULL << 39) ? 39 :	\
+		n >= (1ULL << 38) ? 38 :	\
+		n >= (1ULL << 37) ? 37 :	\
+		n >= (1ULL << 36) ? 36 :	\
+		n >= (1ULL << 35) ? 35 :	\
+		n >= (1ULL << 34) ? 34 :	\
+		n >= (1ULL << 33) ? 33 :	\
+		n >= (1ULL << 32) ? 32 :	\
+		n >= (1ULL << 31) ? 31 :	\
+		n >= (1ULL << 30) ? 30 :	\
+		n >= (1ULL << 29) ? 29 :	\
+		n >= (1ULL << 28) ? 28 :	\
+		n >= (1ULL << 27) ? 27 :	\
+		n >= (1ULL << 26) ? 26 :	\
+		n >= (1ULL << 25) ? 25 :	\
+		n >= (1ULL << 24) ? 24 :	\
+		n >= (1ULL << 23) ? 23 :	\
+		n >= (1ULL << 22) ? 22 :	\
+		n >= (1ULL << 21) ? 21 :	\
+		n >= (1ULL << 20) ? 20 :	\
+		n >= (1ULL << 19) ? 19 :	\
+		n >= (1ULL << 18) ? 18 :	\
+		n >= (1ULL << 17) ? 17 :	\
+		n >= (1ULL << 16) ? 16 :	\
+		n >= (1ULL << 15) ? 15 :	\
+		n >= (1ULL << 14) ? 14 :	\
+		n >= (1ULL << 13) ? 13 :	\
+		n >= (1ULL << 12) ? 12 :	\
+		n >= (1ULL << 11) ? 11 :	\
+		n >= (1ULL << 10) ? 10 :	\
+		n >= (1ULL <<  9) ?  9 :	\
+		n >= (1ULL <<  8) ?  8 :	\
+		n >= (1ULL <<  7) ?  7 :	\
+		n >= (1ULL <<  6) ?  6 :	\
+		n >= (1ULL <<  5) ?  5 :	\
+		n >= (1ULL <<  4) ?  4 :	\
+		n >= (1ULL <<  3) ?  3 :	\
+		n >= (1ULL <<  2) ?  2 :	\
+		n >= (1ULL <<  1) ?  1 :	\
+		n >= (1ULL <<  0) ?  0 :	\
+		____log2_NaN()			\
+				   ) :		\
+	__ll_log2(n)				\
+ )
+
+/*
+ * constant-capable unsigned long log of base 2 calculation
+ * - this can be used to initialise global variables from constant data
+ */
+#if BITS_PER_LONG == 32
+#define long_log2(n) log2(n)
+#else
+#define long_log2(n) ll_log2(n)
+#endif
+
+#endif /* _LINUX_LOG2_H */
