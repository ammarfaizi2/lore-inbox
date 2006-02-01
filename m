Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964900AbWBAJV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964900AbWBAJV6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 04:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbWBAJUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 04:20:11 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:74 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932067AbWBAJDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 04:03:25 -0500
Message-Id: <20060201090322.422243000@localhost.localdomain>
References: <20060201090224.536581000@localhost.localdomain>
Date: Wed, 01 Feb 2006 18:02:30 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: Richard Henderson <rth@twiddle.net>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Russell King <rmk@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>,
       dev-etrax@axis.com, linux-ia64@vger.kernel.org,
       Hirokazu Takata <takata@linux-m32r.org>, linux-mips@linux-mips.org,
       parisc-linux@parisc-linux.org, linuxppc-dev@ozlabs.org,
       linuxsh-dev@lists.sourceforge.net,
       linuxsh-shmedia-dev@lists.sourceforge.net, sparclinux@vger.kernel.org,
       ultralinux@vger.kernel.org, Chris Zankel <chris@zankel.net>,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 06/44] generic __{,test_and_}{set,clear,change}_bit() and test_bit()
Content-Disposition: inline; filename=non-atomic-bitops.h
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the C-language equivalents of the functions below:

void __set_bit(int nr, volatile unsigned long *addr);
void __clear_bit(int nr, volatile unsigned long *addr);
void __change_bit(int nr, volatile unsigned long *addr);
int __test_and_set_bit(int nr, volatile unsigned long *addr);
int __test_and_clear_bit(int nr, volatile unsigned long *addr);
int __test_and_change_bit(int nr, volatile unsigned long *addr);
int test_bit(int nr, const volatile unsigned long *addr);

In include/asm-generic/bitops/non-atomic.h

This code largely copied from:
asm-powerpc/bitops.h

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 include/asm-generic/bitops/non-atomic.h |  111 ++++++++++++++++++++++++++++++++
 1 files changed, 111 insertions(+)

Index: 2.6-git/include/asm-generic/bitops/non-atomic.h
===================================================================
--- /dev/null
+++ 2.6-git/include/asm-generic/bitops/non-atomic.h
@@ -0,0 +1,111 @@
+#ifndef _ASM_GENERIC_BITOPS_NON_ATOMIC_H_
+#define _ASM_GENERIC_BITOPS_NON_ATOMIC_H_
+
+#include <asm/types.h>
+
+#define BITOP_MASK(nr)		(1UL << ((nr) % BITS_PER_LONG))
+#define BITOP_WORD(nr)		((nr) / BITS_PER_LONG)
+
+/**
+ * __set_bit - Set a bit in memory
+ * @nr: the bit to set
+ * @addr: the address to start counting from
+ *
+ * Unlike set_bit(), this function is non-atomic and may be reordered.
+ * If it's called on the same region of memory simultaneously, the effect
+ * may be that only one operation succeeds.
+ */
+static __inline__ void __set_bit(int nr, volatile unsigned long *addr)
+{
+	unsigned long mask = BITOP_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
+
+	*p  |= mask;
+}
+
+static __inline__ void __clear_bit(int nr, volatile unsigned long *addr)
+{
+	unsigned long mask = BITOP_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
+
+	*p &= ~mask;
+}
+
+/**
+ * __change_bit - Toggle a bit in memory
+ * @nr: the bit to change
+ * @addr: the address to start counting from
+ *
+ * Unlike change_bit(), this function is non-atomic and may be reordered.
+ * If it's called on the same region of memory simultaneously, the effect
+ * may be that only one operation succeeds.
+ */
+static __inline__ void __change_bit(int nr, volatile unsigned long *addr)
+{
+	unsigned long mask = BITOP_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
+
+	*p ^= mask;
+}
+
+/**
+ * __test_and_set_bit - Set a bit and return its old value
+ * @nr: Bit to set
+ * @addr: Address to count from
+ *
+ * This operation is non-atomic and can be reordered.  
+ * If two examples of this operation race, one can appear to succeed
+ * but actually fail.  You must protect multiple accesses with a lock.
+ */
+static __inline__ int __test_and_set_bit(int nr, volatile unsigned long *addr)
+{
+	unsigned long mask = BITOP_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
+	unsigned long old = *p;
+
+	*p = old | mask;
+	return (old & mask) != 0;
+}
+
+/**
+ * __test_and_clear_bit - Clear a bit and return its old value
+ * @nr: Bit to clear
+ * @addr: Address to count from
+ *
+ * This operation is non-atomic and can be reordered.  
+ * If two examples of this operation race, one can appear to succeed
+ * but actually fail.  You must protect multiple accesses with a lock.
+ */
+static __inline__ int __test_and_clear_bit(int nr, volatile unsigned long *addr)
+{
+	unsigned long mask = BITOP_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
+	unsigned long old = *p;
+
+	*p = old & ~mask;
+	return (old & mask) != 0;
+}
+
+/* WARNING: non atomic and it can be reordered! */
+static __inline__ int __test_and_change_bit(int nr,
+					    volatile unsigned long *addr)
+{
+	unsigned long mask = BITOP_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
+	unsigned long old = *p;
+
+	*p = old ^ mask;
+	return (old & mask) != 0;
+}
+
+/**
+ * test_bit - Determine whether a bit is set
+ * @nr: bit number to test
+ * @addr: Address to start counting from
+ */
+static __inline__ int test_bit(int nr, __const__ volatile unsigned long *addr)
+{
+	return 1UL & (addr[BITOP_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
+}
+
+#endif /* _ASM_GENERIC_BITOPS_NON_ATOMIC_H_ */

--
