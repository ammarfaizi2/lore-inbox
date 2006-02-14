Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030403AbWBNFGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030403AbWBNFGY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 00:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030358AbWBNFF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 00:05:58 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:61647 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1030403AbWBNFFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 00:05:11 -0500
Message-Id: <20060214050450.197789000@localhost.localdomain>
References: <20060214050351.252615000@localhost.localdomain>
Date: Tue, 14 Feb 2006 14:04:36 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 45/47] remove unused generic bitops in include/linux/bitops.h
Content-Disposition: inline; filename=remove-unused.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

generic_{ffs,fls,fls64,hweight{64,32,16,8}}() were moved into
include/asm-generic/bitops.h. So all architectures don't use them.

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>


 include/linux/bitops.h |  124 -------------------------------------------------
 1 files changed, 1 insertion(+), 123 deletions(-)

Index: 2.6-rc/include/linux/bitops.h
===================================================================
--- 2.6-rc.orig/include/linux/bitops.h
+++ 2.6-rc/include/linux/bitops.h
@@ -3,88 +3,11 @@
 #include <asm/types.h>
 
 /*
- * ffs: find first bit set. This is defined the same way as
- * the libc and compiler builtin ffs routines, therefore
- * differs in spirit from the above ffz (man ffs).
- */
-
-static inline int generic_ffs(int x)
-{
-	int r = 1;
-
-	if (!x)
-		return 0;
-	if (!(x & 0xffff)) {
-		x >>= 16;
-		r += 16;
-	}
-	if (!(x & 0xff)) {
-		x >>= 8;
-		r += 8;
-	}
-	if (!(x & 0xf)) {
-		x >>= 4;
-		r += 4;
-	}
-	if (!(x & 3)) {
-		x >>= 2;
-		r += 2;
-	}
-	if (!(x & 1)) {
-		x >>= 1;
-		r += 1;
-	}
-	return r;
-}
-
-/*
- * fls: find last bit set.
- */
-
-static __inline__ int generic_fls(int x)
-{
-	int r = 32;
-
-	if (!x)
-		return 0;
-	if (!(x & 0xffff0000u)) {
-		x <<= 16;
-		r -= 16;
-	}
-	if (!(x & 0xff000000u)) {
-		x <<= 8;
-		r -= 8;
-	}
-	if (!(x & 0xf0000000u)) {
-		x <<= 4;
-		r -= 4;
-	}
-	if (!(x & 0xc0000000u)) {
-		x <<= 2;
-		r -= 2;
-	}
-	if (!(x & 0x80000000u)) {
-		x <<= 1;
-		r -= 1;
-	}
-	return r;
-}
-
-/*
  * Include this here because some architectures need generic_ffs/fls in
  * scope
  */
 #include <asm/bitops.h>
 
-
-static inline int generic_fls64(__u64 x)
-{
-	__u32 h = x >> 32;
-	if (h)
-		return fls(h) + 32;
-	return fls(x);
-}
-
 static __inline__ int get_bitmask_order(unsigned int count)
 {
 	int order;
@@ -103,54 +26,9 @@ static __inline__ int get_count_order(un
 	return order;
 }
 
-/*
- * hweightN: returns the hamming weight (i.e. the number
- * of bits set) of a N-bit word
- */
-
-static inline unsigned int generic_hweight32(unsigned int w)
-{
-        unsigned int res = (w & 0x55555555) + ((w >> 1) & 0x55555555);
-        res = (res & 0x33333333) + ((res >> 2) & 0x33333333);
-        res = (res & 0x0F0F0F0F) + ((res >> 4) & 0x0F0F0F0F);
-        res = (res & 0x00FF00FF) + ((res >> 8) & 0x00FF00FF);
-        return (res & 0x0000FFFF) + ((res >> 16) & 0x0000FFFF);
-}
-
-static inline unsigned int generic_hweight16(unsigned int w)
-{
-        unsigned int res = (w & 0x5555) + ((w >> 1) & 0x5555);
-        res = (res & 0x3333) + ((res >> 2) & 0x3333);
-        res = (res & 0x0F0F) + ((res >> 4) & 0x0F0F);
-        return (res & 0x00FF) + ((res >> 8) & 0x00FF);
-}
-
-static inline unsigned int generic_hweight8(unsigned int w)
-{
-        unsigned int res = (w & 0x55) + ((w >> 1) & 0x55);
-        res = (res & 0x33) + ((res >> 2) & 0x33);
-        return (res & 0x0F) + ((res >> 4) & 0x0F);
-}
-
-static inline unsigned long generic_hweight64(__u64 w)
-{
-#if BITS_PER_LONG < 64
-	return generic_hweight32((unsigned int)(w >> 32)) +
-				generic_hweight32((unsigned int)w);
-#else
-	u64 res;
-	res = (w & 0x5555555555555555ul) + ((w >> 1) & 0x5555555555555555ul);
-	res = (res & 0x3333333333333333ul) + ((res >> 2) & 0x3333333333333333ul);
-	res = (res & 0x0F0F0F0F0F0F0F0Ful) + ((res >> 4) & 0x0F0F0F0F0F0F0F0Ful);
-	res = (res & 0x00FF00FF00FF00FFul) + ((res >> 8) & 0x00FF00FF00FF00FFul);
-	res = (res & 0x0000FFFF0000FFFFul) + ((res >> 16) & 0x0000FFFF0000FFFFul);
-	return (res & 0x00000000FFFFFFFFul) + ((res >> 32) & 0x00000000FFFFFFFFul);
-#endif
-}
-
 static inline unsigned long hweight_long(unsigned long w)
 {
-	return sizeof(w) == 4 ? generic_hweight32(w) : generic_hweight64(w);
+	return sizeof(w) == 4 ? hweight32(w) : hweight64(w);
 }
 
 /*

--
