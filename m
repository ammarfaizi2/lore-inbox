Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbWAZDiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWAZDiE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 22:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbWAZDiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 22:38:03 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:37605 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932107AbWAZDiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 22:38:00 -0500
Date: Thu, 26 Jan 2006 12:38:06 +0900
To: Grant Grundler <iod00d@hp.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
Subject: [PATCH 10/12] generic ext2_{set,clear,test,find_first_zero,find_next_zero}_bit()
Message-ID: <20060126033806.GI11138@miraclelinux.com>
References: <20060125112625.GA18584@miraclelinux.com> <20060125113206.GD18584@miraclelinux.com> <20060125200250.GA26443@flint.arm.linux.org.uk> <20060125205907.GF9995@esmail.cup.hp.com> <20060126032713.GA9984@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060126032713.GA9984@miraclelinux.com>
User-Agent: Mutt/1.5.9i
From: mita@miraclelinux.com (Akinobu Mita)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the C-language equivalents of the functions below:

int ext2_set_bit(int nr, volatile unsigned long *addr);
int ext2_clear_bit(int nr, volatile unsigned long *addr);
int ext2_test_bit(int nr, const volatile unsigned long *addr);
unsigned long ext2_find_first_zero_bit(const unsigned long *addr,
                                       unsigned long size);

HAVE_ARCH_EXT2_NON_ATOMIC_BITOPS is defined when the architecture has
its own
version of these functions.

unsinged long ext2_find_next_zero_bit(const unsigned long *addr,
                                      unsigned long size);

This code largely copied from:
include/asm-powerpc/bitops.h
include/asm-parisc/bitops.h

Index: 2.6-git/include/asm-generic/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-generic/bitops.h	2006-01-25 19:14:11.000000000 +0900
+++ 2.6-git/include/asm-generic/bitops.h	2006-01-25 19:14:11.000000000 +0900
@@ -5,6 +5,7 @@
 
 #define BITOP_MASK(nr)		(1UL << ((nr) % BITS_PER_LONG))
 #define BITOP_WORD(nr)		((nr) / BITS_PER_LONG)
+#define BITOP_LE_SWIZZLE	((BITS_PER_LONG-1) & ~0x7)
 
 #ifndef HAVE_ARCH_ATOMIC_BITOPS
 
@@ -510,6 +511,140 @@
 
 #endif /* HAVE_ARCH_HWEIGHT64_BITOPS */
 
+#ifndef HAVE_ARCH_EXT2_NON_ATOMIC_BITOPS
+
+#include <asm/byteorder.h>
+
+#if defined(__LITTLE_ENDIAN)
+
+static __inline__ int generic_test_le_bit(unsigned long nr,
+				  __const__ unsigned long *addr)
+{
+	__const__ unsigned char	*tmp = (__const__ unsigned char *) addr;
+	return (tmp[nr >> 3] >> (nr & 7)) & 1;
+}
+
+#define generic___set_le_bit(nr, addr) __set_bit(nr, addr)
+#define generic___clear_le_bit(nr, addr) __clear_bit(nr, addr)
+
+#define generic_test_and_set_le_bit(nr, addr) test_and_set_bit(nr, addr)
+#define generic_test_and_clear_le_bit(nr, addr) test_and_clear_bit(nr, addr)
+
+#define generic___test_and_set_le_bit(nr, addr) __test_and_set_bit(nr, addr)
+#define generic___test_and_clear_le_bit(nr, addr) __test_and_clear_bit(nr, addr)
+
+#define generic_find_next_zero_le_bit(addr, size, offset) find_next_zero_bit(addr, size, offset)
+
+#elif defined(__BIG_ENDIAN)
+
+static __inline__ int generic_test_le_bit(unsigned long nr,
+				  __const__ unsigned long *addr)
+{
+	__const__ unsigned char	*tmp = (__const__ unsigned char *) addr;
+	return (tmp[nr >> 3] >> (nr & 7)) & 1;
+}
+
+#define generic___set_le_bit(nr, addr) \
+	__set_bit((nr) ^ BITOP_LE_SWIZZLE, (addr))
+#define generic___clear_le_bit(nr, addr) \
+	__clear_bit((nr) ^ BITOP_LE_SWIZZLE, (addr))
+
+#define generic_test_and_set_le_bit(nr, addr) \
+	test_and_set_bit((nr) ^ BITOP_LE_SWIZZLE, (addr))
+#define generic_test_and_clear_le_bit(nr, addr) \
+	test_and_clear_bit((nr) ^ BITOP_LE_SWIZZLE, (addr))
+
+#define generic___test_and_set_le_bit(nr, addr) \
+	__test_and_set_bit((nr) ^ BITOP_LE_SWIZZLE, (addr))
+#define generic___test_and_clear_le_bit(nr, addr) \
+	__test_and_clear_bit((nr) ^ BITOP_LE_SWIZZLE, (addr))
+
+/* include/linux/byteorder does not support "unsigned long" type */
+static inline unsigned long ext2_swabp(const unsigned long * x)
+{
+#if BITS_PER_LONG == 64
+	return (unsigned long) __swab64p((u64 *) x);
+#elif BITS_PER_LONG == 32
+	return (unsigned long) __swab32p((u32 *) x);
+#else
+#error BITS_PER_LONG not defined
+#endif
+}
+
+/* include/linux/byteorder doesn't support "unsigned long" type */
+static inline unsigned long ext2_swab(const unsigned long y)
+{
+#if BITS_PER_LONG == 64
+	return (unsigned long) __swab64((u64) y);
+#elif BITS_PER_LONG == 32
+	return (unsigned long) __swab32((u32) y);
+#else
+#error BITS_PER_LONG not defined
+#endif
+}
+
+static __inline__ unsigned long generic_find_next_zero_le_bit(const unsigned long *addr,
+				unsigned long size, unsigned long offset)
+{
+	const unsigned long *p = addr + BITOP_WORD(offset);
+	unsigned long result = offset & ~(BITS_PER_LONG - 1);
+	unsigned long tmp;
+
+	if (offset >= size)
+		return size;
+	size -= result;
+	offset &= (BITS_PER_LONG - 1UL);
+	if (offset) {
+		tmp = ext2_swabp(p++);
+		tmp |= (~0UL >> (BITS_PER_LONG - offset));
+		if (size < BITS_PER_LONG)
+			goto found_first;
+		if (~tmp)
+			goto found_middle;
+		size -= BITS_PER_LONG;
+		result += BITS_PER_LONG;
+	}
+
+	while (size & ~(BITS_PER_LONG - 1)) {
+		if (~(tmp = *(p++)))
+			goto found_middle_swap;
+		result += BITS_PER_LONG;
+		size -= BITS_PER_LONG;
+	}
+	if (!size)
+		return result;
+	tmp = ext2_swabp(p);
+found_first:
+	tmp |= ~0UL << size;
+	if (tmp == ~0UL)	/* Are any bits zero? */
+		return result + size; /* Nope. Skip ffz */
+found_middle:
+	return result + ffz(tmp);
+
+found_middle_swap:
+	return result + ffz(ext2_swab(tmp));
+}
+#else
+#error "Please fix <asm/byteorder.h>"
+#endif
+
+#define generic_find_first_zero_le_bit(addr, size) \
+        generic_find_next_zero_le_bit((addr), (size), 0)
+
+#define ext2_set_bit(nr,addr)	\
+	generic___test_and_set_le_bit((nr),(unsigned long *)(addr))
+#define ext2_clear_bit(nr,addr)	\
+	generic___test_and_clear_le_bit((nr),(unsigned long *)(addr))
+
+#define ext2_test_bit(nr,addr)	\
+	generic_test_le_bit((nr),(unsigned long *)(addr))
+#define ext2_find_first_zero_bit(addr, size) \
+	generic_find_first_zero_le_bit((unsigned long *)(addr), (size))
+#define ext2_find_next_zero_bit(addr, size, off) \
+	generic_find_next_zero_le_bit((unsigned long *)(addr), (size), (off))
+
+#endif /* HAVE_ARCH_EXT2_NON_ATOMIC_BITOPS */
+
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_GENERIC_BITOPS_H */
