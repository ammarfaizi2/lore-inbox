Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161313AbWBUDsf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161313AbWBUDsf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 22:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161308AbWBUDsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 22:48:17 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:11197 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1161307AbWBUDsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 22:48:09 -0500
Message-Id: <20060221034750.534566000@localhost.localdomain>
References: <20060221034628.799606000@localhost.localdomain>
Date: Tue, 21 Feb 2006 12:46:35 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Akinobu Mita <mita@miraclelinux.com>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: [-mm patch 7/8] m68k: fix undefined reference to generic_find_next_zero_le_bit
Content-Disposition: inline; filename=m68k-fix.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch reverts ext2 bitmap functions.

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Roman Zippel <zippel@linux-m68k.org>

 include/asm-m68k/bitops.h |   54 ++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 52 insertions(+), 2 deletions(-)

Index: 2.6-mm/include/asm-m68k/bitops.h
===================================================================
--- 2.6-mm.orig/include/asm-m68k/bitops.h
+++ 2.6-mm/include/asm-m68k/bitops.h
@@ -351,11 +351,61 @@ static inline int minix_test_bit(int nr,
 
 /* Bitmap functions for the ext2 filesystem. */
 
-#include <asm-generic/bitops/ext2-non-atomic.h>
-
+#define ext2_set_bit(nr, addr)			__test_and_set_bit((nr) ^ 24, (unsigned long *)(addr))
 #define ext2_set_bit_atomic(lock, nr, addr)	test_and_set_bit((nr) ^ 24, (unsigned long *)(addr))
+#define ext2_clear_bit(nr, addr)		__test_and_clear_bit((nr) ^ 24, (unsigned long *)(addr))
 #define ext2_clear_bit_atomic(lock, nr, addr)	test_and_clear_bit((nr) ^ 24, (unsigned long *)(addr))
 
+static inline int ext2_test_bit(int nr, const void *vaddr)
+{
+	const unsigned char *p = vaddr;
+	return (p[nr >> 3] & (1U << (nr & 7))) != 0;
+}
+
+static inline int ext2_find_first_zero_bit(const void *vaddr, unsigned size)
+{
+	const unsigned long *p = vaddr, *addr = vaddr;
+	int res;
+
+	if (!size)
+		return 0;
+
+	size = (size >> 5) + ((size & 31) > 0);
+	while (*p++ == ~0UL)
+	{
+		if (--size == 0)
+			return (p - addr) << 5;
+	}
+
+	--p;
+	for (res = 0; res < 32; res++)
+		if (!ext2_test_bit (res, p))
+			break;
+	return (p - addr) * 32 + res;
+}
+
+static inline int ext2_find_next_zero_bit(const void *vaddr, unsigned size,
+					  unsigned offset)
+{
+	const unsigned long *addr = vaddr;
+	const unsigned long *p = addr + (offset >> 5);
+	int bit = offset & 31UL, res;
+
+	if (offset >= size)
+		return size;
+
+	if (bit) {
+		/* Look for zero in first longword */
+		for (res = bit; res < 32; res++)
+			if (!ext2_test_bit (res, p))
+				return (p - addr) * 32 + res;
+		p++;
+	}
+	/* No zero yet, search remaining full bytes for a zero */
+	res = ext2_find_first_zero_bit (p, size - 32 * (p - addr));
+	return (p - addr) * 32 + res;
+}
+
 #endif /* __KERNEL__ */
 
 #endif /* _M68K_BITOPS_H */

--
