Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750913AbWIMSB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbWIMSB2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 14:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750908AbWIMSAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 14:00:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56541 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750786AbWIMSAT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 14:00:19 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 4/7] Implement a general integer log2 facility in the kernel [try #2]
Date: Wed, 13 Sep 2006 18:59:40 +0100
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       dhowells@redhat.com
Message-Id: <20060913175940.21216.63597.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060913175934.21216.73561.stgit@warthog.cambridge.redhat.com>
References: <20060913175934.21216.73561.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

This facility provides three entry points:

	ilog2()		Log base 2 of unsigned long
	ilog2_u32()	Log base 2 of u32
	ilog2_u64()	Log base 2 of u64

These facilities can either be used inside functions on dynamic data:

	int do_something(long q)
	{
		...;
		y = ilog2(x)
		...;
	}

Or can be used to statically initialise global variables with constant values:

	unsigned n = ilog2(27);

When performing static initialisation, the compiler will report "error:
initializer element is not constant" if asked to take a log of zero or of
something not reducible to a constant.  They treat negative numbers as
unsigned.


When not dealing with a constant, they fall back to using fls() which permits
them to use arch-specific log calculation instructions - such as BSR on
x86/x86_64 or SCAN on FRV - if available.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/ext2/super.c          |    6 -
 fs/ext3/super.c          |    6 -
 include/asm-frv/bitops.h |   44 +++++++++++
 include/linux/kernel.h   |    9 --
 include/linux/log2.h     |  188 ++++++++++++++++++++++++++++++++++++++++++++++
 mm/page_alloc.c          |    4 -
 6 files changed, 239 insertions(+), 18 deletions(-)

diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 681dea8..b4b4eae 100644
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
@@ -784,9 +782,9 @@ static int ext2_fill_super(struct super_
 	sbi->s_sbh = bh;
 	sbi->s_mount_state = le16_to_cpu(es->s_state);
 	sbi->s_addr_per_block_bits =
-		log2 (EXT2_ADDR_PER_BLOCK(sb));
+		ilog2 (EXT2_ADDR_PER_BLOCK(sb));
 	sbi->s_desc_per_block_bits =
-		log2 (EXT2_DESC_PER_BLOCK(sb));
+		ilog2 (EXT2_DESC_PER_BLOCK(sb));
 
 	if (sb->s_magic != EXT2_SUPER_MAGIC)
 		goto cantfind_ext2;
diff --git a/fs/ext3/super.c b/fs/ext3/super.c
index 813d589..b088686 100644
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
@@ -1543,8 +1541,8 @@ static int ext3_fill_super (struct super
 	sbi->s_desc_per_block = blocksize / sizeof(struct ext3_group_desc);
 	sbi->s_sbh = bh;
 	sbi->s_mount_state = le16_to_cpu(es->s_state);
-	sbi->s_addr_per_block_bits = log2(EXT3_ADDR_PER_BLOCK(sb));
-	sbi->s_desc_per_block_bits = log2(EXT3_DESC_PER_BLOCK(sb));
+	sbi->s_addr_per_block_bits = ilog2(EXT3_ADDR_PER_BLOCK(sb));
+	sbi->s_desc_per_block_bits = ilog2(EXT3_DESC_PER_BLOCK(sb));
 	for (i=0; i < 4; i++)
 		sbi->s_hash_seed[i] = le32_to_cpu(es->s_hash_seed[i]);
 	sbi->s_def_hash_version = es->s_def_hash_version;
diff --git a/include/asm-frv/bitops.h b/include/asm-frv/bitops.h
index 1f70d47..f8560ed 100644
--- a/include/asm-frv/bitops.h
+++ b/include/asm-frv/bitops.h
@@ -256,6 +256,50 @@ int __ffs(unsigned long x)
 	return 31 - bit;
 }
 
+/*
+ * special slimline version of fls() for calculating ilog2_u32()
+ * - note: no protection against n == 0
+ */
+#define ARCH_HAS_ILOG2_U32
+static inline __attribute__((const))
+int __ilog2_u32(u32 n)
+{
+	int bit;
+	asm("scan %1,gr0,%0" : "=r"(bit) : "r"(n));
+	return 31 - bit;
+}
+
+/*
+ * special slimline version of fls64() for calculating ilog2_u64()
+ * - note: no protection against n == 0
+ */
+#define ARCH_HAS_ILOG2_U64
+static inline __attribute__((const))
+int __ilog2_u64(u64 n)
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
index 0000000..6ce81b7
--- /dev/null
+++ b/include/linux/log2.h
@@ -0,0 +1,188 @@
+/* Integer base 2 logarithm calculation
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
+int ____ilog2_NaN(void);
+
+/*
+ * non-constant log of base 2 calculators
+ * - the arch may override these in asm/bitops.h if they can be implemented
+ *   more efficiently than using fls() and fls64()
+ */
+#ifndef ARCH_HAS_ILOG2_U32
+static inline __attribute__((const))
+int __ilog2_u32(u32 n)
+{
+	return fls(n) - 1;
+}
+#endif
+
+#ifndef ARCH_HAS_ILOG2_U64
+static inline __attribute__((const))
+int __ilog2_u64(u64 n)
+{
+	return fls64(n) - 1;
+}
+#endif
+
+/**
+ * ilog2_u32 - log of base 2 of 32-bit unsigned value
+ * @n - parameter
+ *
+ * constant-capable 32-bit log of base 2 calculation
+ * - this can be used to initialise global variables from constant data, hence
+ *   the massive ternary operator construction
+ */
+#define ilog2_u32(n)					\
+(						\
+	__builtin_constant_p(n) ? (		\
+		n < 1 ? ____ilog2_NaN() :	\
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
+		____ilog2_NaN()			\
+				   ) :		\
+	__ilog2_u32(n)				\
+ )
+
+/**
+ * ilog2_u64 - log of base 2 of 64-bit unsigned value
+ * @n - parameter
+ *
+ * constant-capable 64-bit log of base 2 calculation
+ * - this can be used to initialise global variables from constant data, hence
+ *   the massive ternary operator construction
+ */
+#define ilog2_u64(n)				\
+(						\
+	__builtin_constant_p(n) ? (		\
+		n < 1 ? ____ilog2_NaN() :	\
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
+		____ilog2_NaN()			\
+				   ) :		\
+	__ilog2_u64(n)				\
+ )
+
+/**
+ * ilog2 - log of base 2 of unsigned long value
+ * @n - parameter
+ *
+ * constant-capable unsigned long log of base 2 calculation
+ * - this can be used to initialise global variables from constant data
+ */
+#if BITS_PER_LONG == 32
+#define ilog2(n) ilog2_u32(n)
+#else
+#define ilog2(n) ilog2_u64(n)
+#endif
+
+#endif /* _LINUX_LOG2_H */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 54a4f53..2ccb960 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2420,7 +2420,7 @@ void *__init alloc_large_system_hash(con
 	if (numentries > max)
 		numentries = max;
 
-	log2qty = long_log2(numentries);
+	log2qty = ilog2(numentries);
 
 	do {
 		size = bucketsize << log2qty;
@@ -2442,7 +2442,7 @@ void *__init alloc_large_system_hash(con
 	printk("%s hash table entries: %d (order: %d, %lu bytes)\n",
 	       tablename,
 	       (1U << log2qty),
-	       long_log2(size) - PAGE_SHIFT,
+	       ilog2(size) - PAGE_SHIFT,
 	       size);
 
 	if (_hash_shift)
