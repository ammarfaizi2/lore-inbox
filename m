Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbWBAJT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbWBAJT7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 04:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbWBAJTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 04:19:54 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:28746 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1751126AbWBAJD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 04:03:27 -0500
Message-Id: <20060201090324.373982000@localhost.localdomain>
References: <20060201090224.536581000@localhost.localdomain>
Date: Wed, 01 Feb 2006 18:02:35 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: Richard Henderson <rth@twiddle.net>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>, dev-etrax@axis.com,
       David Howells <dhowells@redhat.com>,
       Yoshinori Sato <ysato@users.sourceforge.jp>, linux-ia64@vger.kernel.org,
       Hirokazu Takata <takata@linux-m32r.org>,
       Greg Ungerer <gerg@uclinux.org>, linux-mips@linux-mips.org,
       parisc-linux@parisc-linux.org, linuxsh-dev@lists.sourceforge.net,
       linuxsh-shmedia-dev@lists.sourceforge.net, sparclinux@vger.kernel.org,
       ultralinux@vger.kernel.org, Miles Bader <uclinux-v850@lsi.nec.co.jp>,
       Chris Zankel <chris@zankel.net>, Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 11/44] generic find_{next,first}{,_zero}_bit()
Content-Disposition: inline; filename=find-bitops.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the C-language equivalents of the functions below:

unsigned logn find_next_bit(const unsigned long *addr, unsigned long size,
                            unsigned long offset);
unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
                                 unsigned long offset);
unsigned long find_first_zero_bit(const unsigned long *addr,
                                  unsigned long size);
unsigned long find_first_bit(const unsigned long *addr, unsigned long size);

In include/asm-generic/bitops/find.h

This code largely copied from:
arch/powerpc/lib/bitops.c

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 include/asm-generic/bitops/find.h |   99 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 99 insertions(+)

Index: 2.6-git/include/asm-generic/bitops/find.h
===================================================================
--- /dev/null
+++ 2.6-git/include/asm-generic/bitops/find.h
@@ -0,0 +1,99 @@
+#ifndef _ASM_GENERIC_BITOPS_FIND_H_
+#define _ASM_GENERIC_BITOPS_FIND_H_
+
+#include <asm/types.h>
+
+#define BITOP_WORD(nr)		((nr) / BITS_PER_LONG)
+
+/**
+ * find_next_bit - find the next set bit in a memory region
+ * @addr: The address to base the search on
+ * @offset: The bitnumber to start searching at
+ * @size: The maximum size to search
+ */
+static inline unsigned long find_next_bit(const unsigned long *addr,
+				unsigned long size, unsigned long offset)
+{
+	const unsigned long *p = addr + BITOP_WORD(offset);
+	unsigned long result = offset & ~(BITS_PER_LONG-1);
+	unsigned long tmp;
+
+	if (offset >= size)
+		return size;
+	size -= result;
+	offset %= BITS_PER_LONG;
+	if (offset) {
+		tmp = *(p++);
+		tmp &= (~0UL << offset);
+		if (size < BITS_PER_LONG)
+			goto found_first;
+		if (tmp)
+			goto found_middle;
+		size -= BITS_PER_LONG;
+		result += BITS_PER_LONG;
+	}
+	while (size & ~(BITS_PER_LONG-1)) {
+		if ((tmp = *(p++)))
+			goto found_middle;
+		result += BITS_PER_LONG;
+		size -= BITS_PER_LONG;
+	}
+	if (!size)
+		return result;
+	tmp = *p;
+
+found_first:
+	tmp &= (~0UL >> (BITS_PER_LONG - size));
+	if (tmp == 0UL)		/* Are any bits set? */
+		return result + size;	/* Nope. */
+found_middle:
+	return result + __ffs(tmp);
+}
+
+/*
+ * This implementation of find_{first,next}_zero_bit was stolen from
+ * Linus' asm-alpha/bitops.h.
+ */
+static inline unsigned long find_next_zero_bit(const unsigned long *addr,
+				unsigned long size, unsigned long offset)
+{
+	const unsigned long *p = addr + BITOP_WORD(offset);
+	unsigned long result = offset & ~(BITS_PER_LONG-1);
+	unsigned long tmp;
+
+	if (offset >= size)
+		return size;
+	size -= result;
+	offset %= BITS_PER_LONG;
+	if (offset) {
+		tmp = *(p++);
+		tmp |= ~0UL >> (BITS_PER_LONG - offset);
+		if (size < BITS_PER_LONG)
+			goto found_first;
+		if (~tmp)
+			goto found_middle;
+		size -= BITS_PER_LONG;
+		result += BITS_PER_LONG;
+	}
+	while (size & ~(BITS_PER_LONG-1)) {
+		if (~(tmp = *(p++)))
+			goto found_middle;
+		result += BITS_PER_LONG;
+		size -= BITS_PER_LONG;
+	}
+	if (!size)
+		return result;
+	tmp = *p;
+
+found_first:
+	tmp |= ~0UL << size;
+	if (tmp == ~0UL)	/* Are any bits zero? */
+		return result + size;	/* Nope. */
+found_middle:
+	return result + ffz(tmp);
+}
+
+#define find_first_zero_bit(addr, size) find_next_zero_bit((addr), (size), 0)
+#define find_first_bit(addr, size) find_next_bit((addr), (size), 0)
+
+#endif /*_ASM_GENERIC_BITOPS_FIND_H_ */

--
