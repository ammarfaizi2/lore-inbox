Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030431AbWBNFTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030431AbWBNFTy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 00:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030425AbWBNFTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 00:19:12 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:21711 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1030371AbWBNFFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 00:05:04 -0500
Message-Id: <20060214050444.051147000@localhost.localdomain>
References: <20060214050351.252615000@localhost.localdomain>
Date: Tue, 14 Feb 2006 14:04:03 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Richard Henderson <rth@twiddle.net>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>, dev-etrax@axis.com,
       David Howells <dhowells@redhat.com>,
       Yoshinori Sato <ysato@users.sourceforge.jp>, linux-ia64@vger.kernel.org,
       Hirokazu Takata <takata@linux-m32r.org>,
       Greg Ungerer <gerg@uclinux.org>, linux-mips@linux-mips.org,
       parisc-linux@parisc-linux.org, linuxsh-dev@lists.sourceforge.net,
       linuxsh-shmedia-dev@lists.sourceforge.net, sparclinux@vger.kernel.org,
       ultralinux@vger.kernel.org, Miles Bader <uclinux-v850@lsi.nec.co.jp>,
       Chris Zankel <chris@zankel.net>, Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 12/47] generic find_{next,first}{,_zero}_bit()
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
 include/asm-generic/bitops/find.h |   13 ++++
 lib/find_next_bit.c               |  114 +++++++++++++++++++++++++++-----------
 2 files changed, 95 insertions(+), 32 deletions(-)

Index: 2.6-rc/include/asm-generic/bitops/find.h
===================================================================
--- /dev/null
+++ 2.6-rc/include/asm-generic/bitops/find.h
@@ -0,0 +1,13 @@
+#ifndef _ASM_GENERIC_BITOPS_FIND_H_
+#define _ASM_GENERIC_BITOPS_FIND_H_
+
+extern unsigned long find_next_bit(const unsigned long *addr, unsigned long
+		size, unsigned long offset);
+
+extern unsigned long find_next_zero_bit(const unsigned long *addr, unsigned
+		long size, unsigned long offset);
+
+#define find_first_bit(addr, size) find_next_bit((addr), (size), 0)
+#define find_first_zero_bit(addr, size) find_next_zero_bit((addr), (size), 0)
+
+#endif /*_ASM_GENERIC_BITOPS_FIND_H_ */
Index: 2.6-rc/lib/find_next_bit.c
===================================================================
--- 2.6-rc.orig/lib/find_next_bit.c
+++ 2.6-rc/lib/find_next_bit.c
@@ -11,48 +11,98 @@
 
 #include <linux/bitops.h>
 #include <linux/module.h>
+#include <asm/types.h>
 
-int find_next_bit(const unsigned long *addr, int size, int offset)
+#define BITOP_WORD(nr)		((nr) / BITS_PER_LONG)
+
+/**
+ * find_next_bit - find the next set bit in a memory region
+ * @addr: The address to base the search on
+ * @offset: The bitnumber to start searching at
+ * @size: The maximum size to search
+ */
+unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
+		unsigned long offset)
 {
-	const unsigned long *base;
-	const int NBITS = sizeof(*addr) * 8;
+	const unsigned long *p = addr + BITOP_WORD(offset);
+	unsigned long result = offset & ~(BITS_PER_LONG-1);
 	unsigned long tmp;
 
-	base = addr;
+	if (offset >= size)
+		return size;
+	size -= result;
+	offset %= BITS_PER_LONG;
 	if (offset) {
-		int suboffset;
-
-		addr += offset / NBITS;
-
-		suboffset = offset % NBITS;
-		if (suboffset) {
-			tmp = *addr;
-			tmp >>= suboffset;
-			if (tmp)
-				goto finish;
-		}
-
-		addr++;
+		tmp = *(p++);
+		tmp &= (~0UL << offset);
+		if (size < BITS_PER_LONG)
+			goto found_first;
+		if (tmp)
+			goto found_middle;
+		size -= BITS_PER_LONG;
+		result += BITS_PER_LONG;
 	}
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
 
-	while ((tmp = *addr) == 0)
-		addr++;
+EXPORT_SYMBOL(find_next_bit);
 
-	offset = (addr - base) * NBITS;
+/*
+ * This implementation of find_{first,next}_zero_bit was stolen from
+ * Linus' asm-alpha/bitops.h.
+ */
+unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
+		unsigned long offset)
+{
+	const unsigned long *p = addr + BITOP_WORD(offset);
+	unsigned long result = offset & ~(BITS_PER_LONG-1);
+	unsigned long tmp;
 
- finish:
-	/* count the remaining bits without using __ffs() since that takes a 32-bit arg */
-	while (!(tmp & 0xff)) {
-		offset += 8;
-		tmp >>= 8;
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
 	}
-
-	while (!(tmp & 1)) {
-		offset++;
-		tmp >>= 1;
+	while (size & ~(BITS_PER_LONG-1)) {
+		if (~(tmp = *(p++)))
+			goto found_middle;
+		result += BITS_PER_LONG;
+		size -= BITS_PER_LONG;
 	}
-
-	return offset;
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
 }
 
-EXPORT_SYMBOL(find_next_bit);
+EXPORT_SYMBOL(find_next_zero_bit);

--
