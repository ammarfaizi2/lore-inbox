Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264402AbUFYG3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264402AbUFYG3V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 02:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266252AbUFYG3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 02:29:21 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:39930 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S264402AbUFYG3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 02:29:08 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH][v850]  Add find_next_bit for v850
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20040625062900.897C93A2@mctpc71>
Date: Fri, 25 Jun 2004 15:29:00 +0900 (JST)
From: miles@mctpc71.ucom.lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Since many archs use the same implementation of find_next_bit, it might
be nice to have `generic_find_next_bit' or something.]

Signed-off-by: Miles Bader <miles@gnu.org>

 include/asm-v850/bitops.h |   76 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 76 insertions(+)

diff -ruN -X../cludes linux-2.6.7-uc0/include/asm-v850/bitops.h linux-2.6.7-uc0-v850-20040625/include/asm-v850/bitops.h
--- linux-2.6.7-uc0/include/asm-v850/bitops.h	2004-05-11 13:20:53.000000000 +0900
+++ linux-2.6.7-uc0-v850-20040625/include/asm-v850/bitops.h	2004-06-25 14:24:08.000000000 +0900
@@ -193,10 +193,86 @@
 	return result + ffz (tmp);
 }
 
+
+/* This is the same as generic_ffs, but we can't use that because it's
+   inline and the #include order mucks things up.  */
+static inline int generic_ffs_for_find_next_bit(int x)
+{
+	int r = 1;
+
+	if (!x)
+		return 0;
+	if (!(x & 0xffff)) {
+		x >>= 16;
+		r += 16;
+	}
+	if (!(x & 0xff)) {
+		x >>= 8;
+		r += 8;
+	}
+	if (!(x & 0xf)) {
+		x >>= 4;
+		r += 4;
+	}
+	if (!(x & 3)) {
+		x >>= 2;
+		r += 2;
+	}
+	if (!(x & 1)) {
+		x >>= 1;
+		r += 1;
+	}
+	return r;
+}
+
+/*
+ * Find next one bit in a bitmap reasonably efficiently.
+ */
+static __inline__ unsigned long find_next_bit(const unsigned long *addr,
+	unsigned long size, unsigned long offset)
+{
+	unsigned int *p = ((unsigned int *) addr) + (offset >> 5);
+	unsigned int result = offset & ~31UL;
+	unsigned int tmp;
+
+	if (offset >= size)
+		return size;
+	size -= result;
+	offset &= 31UL;
+	if (offset) {
+		tmp = *p++;
+		tmp &= ~0UL << offset;
+		if (size < 32)
+			goto found_first;
+		if (tmp)
+			goto found_middle;
+		size -= 32;
+		result += 32;
+	}
+	while (size >= 32) {
+		if ((tmp = *p++) != 0)
+			goto found_middle;
+		result += 32;
+		size -= 32;
+	}
+	if (!size)
+		return result;
+	tmp = *p;
+
+found_first:
+	tmp &= ~0UL >> (32 - size);
+	if (tmp == 0UL)        /* Are any bits set? */
+		return result + size; /* Nope. */
+found_middle:
+	return result + generic_ffs_for_find_next_bit(tmp);
+}
+
+
 #define ffs(x) generic_ffs (x)
 #define fls(x) generic_fls (x)
 #define __ffs(x) ffs(x)
 
+
 /*
  * This is just `generic_ffs' from <linux/bitops.h>, except that it assumes
  * that at least one bit is set, and returns the real index of the bit
