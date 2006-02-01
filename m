Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbWBAJOU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbWBAJOU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 04:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbWBAJN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 04:13:58 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:44106 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932260AbWBAJD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 04:03:28 -0500
Message-Id: <20060201090326.139510000@localhost.localdomain>
References: <20060201090224.536581000@localhost.localdomain>
Date: Wed, 01 Feb 2006 18:02:39 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: Richard Henderson <rth@twiddle.net>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>, dev-etrax@axis.com,
       David Howells <dhowells@redhat.com>,
       Yoshinori Sato <ysato@users.sourceforge.jp>,
       Linus Torvalds <torvalds@osdl.org>, linux-ia64@vger.kernel.org,
       Hirokazu Takata <takata@linux-m32r.org>, linux-m68k@vger.kernel.org,
       linux-mips@linux-mips.org, parisc-linux@parisc-linux.org,
       linuxsh-dev@lists.sourceforge.net,
       linuxsh-shmedia-dev@lists.sourceforge.net, sparclinux@vger.kernel.org,
       ultralinux@vger.kernel.org, Miles Bader <uclinux-v850@lsi.nec.co.jp>,
       Andi Kleen <ak@suse.de>, Chris Zankel <chris@zankel.net>,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 15/44] generic ext2_{set,clear,test,find_first_zero,find_next_zero}_bit()
Content-Disposition: inline; filename=ext2-non-atomic-bitops.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the C-language equivalents of the functions below:

int ext2_set_bit(int nr, volatile unsigned long *addr);
int ext2_clear_bit(int nr, volatile unsigned long *addr);
int ext2_test_bit(int nr, const volatile unsigned long *addr);
unsigned long ext2_find_first_zero_bit(const unsigned long *addr,
                                       unsigned long size);
unsinged long ext2_find_next_zero_bit(const unsigned long *addr,
                                      unsigned long size);

In include/asm-generic/bitops/ext2-non-atomic.h

This code largely copied from:

include/asm-powerpc/bitops.h
include/asm-parisc/bitops.h

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 include/asm-generic/bitops/ext2-non-atomic.h |   18 +++
 include/asm-generic/bitops/le.h              |  126 +++++++++++++++++++++++++++
 2 files changed, 144 insertions(+)

Index: 2.6-git/include/asm-generic/bitops/ext2-non-atomic.h
===================================================================
--- /dev/null
+++ 2.6-git/include/asm-generic/bitops/ext2-non-atomic.h
@@ -0,0 +1,18 @@
+#ifndef _ASM_GENERIC_BITOPS_EXT2_NON_ATOMIC_H_
+#define _ASM_GENERIC_BITOPS_EXT2_NON_ATOMIC_H_
+
+#include <asm-generic/bitops/le.h>
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
+#endif /* _ASM_GENERIC_BITOPS_EXT2_NON_ATOMIC_H_ */
Index: 2.6-git/include/asm-generic/bitops/le.h
===================================================================
--- /dev/null
+++ 2.6-git/include/asm-generic/bitops/le.h
@@ -0,0 +1,126 @@
+#ifndef _ASM_GENERIC_BITOPS_LE_H_
+#define _ASM_GENERIC_BITOPS_LE_H_
+
+#include <asm/types.h>
+#include <asm/byteorder.h>
+
+#define BITOP_WORD(nr)		((nr) / BITS_PER_LONG)
+#define BITOP_LE_SWIZZLE	((BITS_PER_LONG-1) & ~0x7)
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
+#endif /* _ASM_GENERIC_BITOPS_LE_H_ */

--
