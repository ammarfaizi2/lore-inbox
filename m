Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267595AbUHTHEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267595AbUHTHEZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 03:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267597AbUHTHEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 03:04:25 -0400
Received: from ozlabs.org ([203.10.76.45]:37062 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267595AbUHTHEU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 03:04:20 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16677.41654.992265.563552@cargo.ozlabs.ibm.com>
Date: Fri, 20 Aug 2004 17:05:26 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: Olof Johansson <olof@austin.ibm.com>, anton@samba.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 Better little-endian bitops
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below patch reuses the big-endian bitops for the little endian ones, and
moves the ext2_{set,clear}_bit_atomic functions to be truly atomic
instead of lock based.

This requires that the bitmaps passed to the ext2_* bitop functions
are 8-byte aligned.  I have been assured that they will be 512-byte or
1024-byte aligned, and sparc and ppc32 also impose an alignment
requirement on the bitmap.

Signed-off-by: Olof Johansson <olof@austin.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -puN include/asm-ppc64/bitops.h~ext2-set-bit include/asm-ppc64/bitops.h
--- linux-2.5/include/asm-ppc64/bitops.h~ext2-set-bit	2004-08-18 12:04:43.208963520 -0500
+++ linux-2.5-olof/include/asm-ppc64/bitops.h	2004-08-18 15:11:57.088963696 -0500
@@ -22,6 +22,15 @@
  * it will be a bad memory reference since we want to store in chunks
  * of unsigned long (64 bits here) size.
  *
+ * There are a few little-endian macros used mostly for filesystem bitmaps,
+ * these work on similar bit arrays layouts, but byte-oriented:
+ *
+ *   |7...0|15...8|23...16|31...24|39...32|47...40|55...48|63...56|
+ *
+ * The main difference is that bit 3-5 in the bit number field needs to be
+ * reversed compared to the big-endian bit fields. This can be achieved
+ * by XOR with 0b111000 (0x38).
+ *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
  * as published by the Free Software Foundation; either version
@@ -306,71 +315,34 @@ static __inline__ int test_le_bit(unsign
 	return (ADDR[nr >> 3] >> (nr & 7)) & 1;
 }
 
+#define test_and_clear_le_bit(nr, addr) \
+	test_and_clear_bit((nr) ^ 0x38, (addr))
+#define test_and_set_le_bit(nr, addr) \
+	test_and_set_bit((nr) ^ 0x38, (addr))
+
 /*
  * non-atomic versions
  */
-static __inline__ void __set_le_bit(unsigned long nr, unsigned long *addr)
-{
-	unsigned char *ADDR = (unsigned char *)addr;
 
-	ADDR += nr >> 3;
-	*ADDR |= 1 << (nr & 0x07);
-}
-
-static __inline__ void __clear_le_bit(unsigned long nr, unsigned long *addr)
-{
-	unsigned char *ADDR = (unsigned char *)addr;
-
-	ADDR += nr >> 3;
-	*ADDR &= ~(1 << (nr & 0x07));
-}
-
-static __inline__ int __test_and_set_le_bit(unsigned long nr, unsigned long *addr)
-{
-	int mask, retval;
-	unsigned char *ADDR = (unsigned char *)addr;
-
-	ADDR += nr >> 3;
-	mask = 1 << (nr & 0x07);
-	retval = (mask & *ADDR) != 0;
-	*ADDR |= mask;
-	return retval;
-}
-
-static __inline__ int __test_and_clear_le_bit(unsigned long nr, unsigned long *addr)
-{
-	int mask, retval;
-	unsigned char *ADDR = (unsigned char *)addr;
-
-	ADDR += nr >> 3;
-	mask = 1 << (nr & 0x07);
-	retval = (mask & *ADDR) != 0;
-	*ADDR &= ~mask;
-	return retval;
-}
+#define __set_le_bit(nr, addr) \
+	__set_bit((nr) ^ 0x38, (addr))
+#define __clear_le_bit(nr, addr) \
+	__clear_bit((nr) ^ 0x38, (addr))
+#define __test_and_clear_le_bit(nr, addr) \
+	__test_and_clear_bit((nr) ^ 0x38, (addr))
+#define __test_and_set_le_bit(nr, addr) \
+	__test_and_set_bit((nr) ^ 0x38, (addr))
 
 #define ext2_set_bit(nr,addr) \
-	__test_and_set_le_bit((nr),(unsigned long*)addr)
+	__test_and_set_le_bit((nr), (unsigned long*)addr)
 #define ext2_clear_bit(nr, addr) \
-	__test_and_clear_le_bit((nr),(unsigned long*)addr)
+	__test_and_clear_le_bit((nr), (unsigned long*)addr)
+
+#define ext2_set_bit_atomic(lock, nr, addr) \
+	test_and_set_le_bit((nr), (unsigned long*)addr)
+#define ext2_clear_bit_atomic(lock, nr, addr) \
+	test_and_clear_le_bit((nr), (unsigned long*)addr)
 
-#define ext2_set_bit_atomic(lock, nr, addr)		\
-	({						\
-		int ret;				\
-		spin_lock(lock);			\
-		ret = ext2_set_bit((nr), (addr));	\
-		spin_unlock(lock);			\
-		ret;					\
-	})
-
-#define ext2_clear_bit_atomic(lock, nr, addr)		\
-	({						\
-		int ret;				\
-		spin_lock(lock);			\
-		ret = ext2_clear_bit((nr), (addr));	\
-		spin_unlock(lock);			\
-		ret;					\
-	})
 
 #define ext2_test_bit(nr, addr)      test_le_bit((nr),(unsigned long*)addr)
 #define ext2_find_first_zero_bit(addr, size) \
