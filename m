Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262098AbVGKQhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbVGKQhK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 12:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbVGKQfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 12:35:00 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:64387 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S262100AbVGKQdS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 12:33:18 -0400
Date: Mon, 11 Jul 2005 18:33:15 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 2/12] s390: find_next_{zero}_bit fixes.
Message-ID: <20050711163315.GB10822@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 2/12] s390: find_next_{zero}_bit fixes.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

The find_next_{zero}_bit primitives on s390* should never return a
bit number bigger then the bit field size. In the case of a bitfield
that doesn't end on a word boundary, an offset  that makes the search
start at the last word of the bit field and the last word doesn't
contain any zero/one bits the search is continued with a call to
find_first_bit with a negative size. The search normally ends pretty
quickly because the words following the bit field contain a mix of
zeros and ones. But the bit number that is returned in this case
is too big.

To fix this and additional if to check for this case is needed.
To make the code easier to read I removed the assembler parts
from the find_next_{zero}_bit functions, the C-ified code is
as good.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 include/asm-s390/bitops.h |  436 ++++++++++++++--------------------------------
 1 files changed, 138 insertions(+), 298 deletions(-)

diff -urpN linux-2.6/include/asm-s390/bitops.h linux-2.6-patched/include/asm-s390/bitops.h
--- linux-2.6/include/asm-s390/bitops.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/bitops.h	2005-07-11 17:37:42.000000000 +0200
@@ -527,13 +527,64 @@ __constant_test_bit(unsigned long nr, co
  __constant_test_bit((nr),(addr)) : \
  __test_bit((nr),(addr)) )
 
-#ifndef __s390x__
+/*
+ * ffz = Find First Zero in word. Undefined if no zero exists,
+ * so code should check against ~0UL first..
+ */
+static inline unsigned long ffz(unsigned long word)
+{
+        unsigned long bit = 0;
+
+#ifdef __s390x__
+	if (likely((word & 0xffffffff) == 0xffffffff)) {
+		word >>= 32;
+		bit += 32;
+	}
+#endif
+	if (likely((word & 0xffff) == 0xffff)) {
+		word >>= 16;
+		bit += 16;
+	}
+	if (likely((word & 0xff) == 0xff)) {
+		word >>= 8;
+		bit += 8;
+	}
+	return bit + _zb_findmap[word & 0xff];
+}
+
+/*
+ * __ffs = find first bit in word. Undefined if no bit exists,
+ * so code should check against 0UL first..
+ */
+static inline unsigned long __ffs (unsigned long word)
+{
+	unsigned long bit = 0;
+
+#ifdef __s390x__
+	if (likely((word & 0xffffffff) == 0)) {
+		word >>= 32;
+		bit += 32;
+	}
+#endif
+	if (likely((word & 0xffff) == 0)) {
+		word >>= 16;
+		bit += 16;
+	}
+	if (likely((word & 0xff) == 0)) {
+		word >>= 8;
+		bit += 8;
+	}
+	return bit + _sb_findmap[word & 0xff];
+}
 
 /*
  * Find-bit routines..
  */
+
+#ifndef __s390x__
+
 static inline int
-find_first_zero_bit(const unsigned long * addr, unsigned int size)
+find_first_zero_bit(const unsigned long * addr, unsigned long size)
 {
 	typedef struct { long _[__BITOPS_WORDS(size)]; } addrtype;
 	unsigned long cmp, count;
@@ -548,7 +599,7 @@ find_first_zero_bit(const unsigned long 
                 "   srl  %2,5\n"
                 "0: c    %1,0(%0,%4)\n"
                 "   jne  1f\n"
-                "   ahi  %0,4\n"
+                "   la   %0,4(%0)\n"
                 "   brct %2,0b\n"
                 "   lr   %0,%3\n"
                 "   j    4f\n"
@@ -574,7 +625,7 @@ find_first_zero_bit(const unsigned long 
 }
 
 static inline int
-find_first_bit(const unsigned long * addr, unsigned int size)
+find_first_bit(const unsigned long * addr, unsigned long size)
 {
 	typedef struct { long _[__BITOPS_WORDS(size)]; } addrtype;
 	unsigned long cmp, count;
@@ -589,7 +640,7 @@ find_first_bit(const unsigned long * add
                 "   srl  %2,5\n"
                 "0: c    %1,0(%0,%4)\n"
                 "   jne  1f\n"
-                "   ahi  %0,4\n"
+                "   la   %0,4(%0)\n"
                 "   brct %2,0b\n"
                 "   lr   %0,%3\n"
                 "   j    4f\n"
@@ -614,89 +665,8 @@ find_first_bit(const unsigned long * add
         return (res < size) ? res : size;
 }
 
-static inline int
-find_next_zero_bit (const unsigned long * addr, int size, int offset)
-{
-        unsigned long * p = ((unsigned long *) addr) + (offset >> 5);
-        unsigned long bitvec, reg;
-        int set, bit = offset & 31, res;
-
-        if (bit) {
-                /*
-                 * Look for zero in first word
-                 */
-                bitvec = (*p) >> bit;
-                __asm__("   slr  %0,%0\n"
-                        "   lhi  %2,0xff\n"
-                        "   tml  %1,0xffff\n"
-                        "   jno  0f\n"
-                        "   ahi  %0,16\n"
-                        "   srl  %1,16\n"
-                        "0: tml  %1,0x00ff\n"
-                        "   jno  1f\n"
-                        "   ahi  %0,8\n"
-                        "   srl  %1,8\n"
-                        "1: nr   %1,%2\n"
-                        "   ic   %1,0(%1,%3)\n"
-                        "   alr  %0,%1"
-                        : "=&d" (set), "+a" (bitvec), "=&d" (reg)
-                        : "a" (&_zb_findmap) : "cc" );
-                if (set < (32 - bit))
-                        return set + offset;
-                offset += 32 - bit;
-                p++;
-        }
-        /*
-         * No zero yet, search remaining full words for a zero
-         */
-        res = find_first_zero_bit (p, size - 32 * (p - (unsigned long *) addr));
-        return (offset + res);
-}
-
-static inline int
-find_next_bit (const unsigned long * addr, int size, int offset)
-{
-        unsigned long * p = ((unsigned long *) addr) + (offset >> 5);
-        unsigned long bitvec, reg;
-        int set, bit = offset & 31, res;
-
-        if (bit) {
-                /*
-                 * Look for set bit in first word
-                 */
-                bitvec = (*p) >> bit;
-                __asm__("   slr  %0,%0\n"
-                        "   lhi  %2,0xff\n"
-                        "   tml  %1,0xffff\n"
-                        "   jnz  0f\n"
-                        "   ahi  %0,16\n"
-                        "   srl  %1,16\n"
-                        "0: tml  %1,0x00ff\n"
-                        "   jnz  1f\n"
-                        "   ahi  %0,8\n"
-                        "   srl  %1,8\n"
-                        "1: nr   %1,%2\n"
-                        "   ic   %1,0(%1,%3)\n"
-                        "   alr  %0,%1"
-                        : "=&d" (set), "+a" (bitvec), "=&d" (reg)
-                        : "a" (&_sb_findmap) : "cc" );
-                if (set < (32 - bit))
-                        return set + offset;
-                offset += 32 - bit;
-                p++;
-        }
-        /*
-         * No set bit yet, search remaining full words for a bit
-         */
-        res = find_first_bit (p, size - 32 * (p - (unsigned long *) addr));
-        return (offset + res);
-}
-
 #else /* __s390x__ */
 
-/*
- * Find-bit routines..
- */
 static inline unsigned long
 find_first_zero_bit(const unsigned long * addr, unsigned long size)
 {
@@ -712,7 +682,7 @@ find_first_zero_bit(const unsigned long 
                 "   srlg  %2,%2,6\n"
                 "0: cg    %1,0(%0,%4)\n"
                 "   jne   1f\n"
-                "   aghi  %0,8\n"
+                "   la    %0,8(%0)\n"
                 "   brct  %2,0b\n"
                 "   lgr   %0,%3\n"
                 "   j     5f\n"
@@ -785,143 +755,66 @@ find_first_bit(const unsigned long * add
         return (res < size) ? res : size;
 }
 
-static inline unsigned long
-find_next_zero_bit (const unsigned long * addr, unsigned long size, unsigned long offset)
-{
-        unsigned long * p = ((unsigned long *) addr) + (offset >> 6);
-        unsigned long bitvec, reg;
-        unsigned long set, bit = offset & 63, res;
-
-        if (bit) {
-                /*
-                 * Look for zero in first word
-                 */
-                bitvec = (*p) >> bit;
-                __asm__("   lhi  %2,-1\n"
-                        "   slgr %0,%0\n"
-                        "   clr  %1,%2\n"
-                        "   jne  0f\n"
-                        "   aghi %0,32\n"
-                        "   srlg %1,%1,32\n"
-			"0: lghi %2,0xff\n"
-                        "   tmll %1,0xffff\n"
-                        "   jno  1f\n"
-                        "   aghi %0,16\n"
-                        "   srlg %1,%1,16\n"
-                        "1: tmll %1,0x00ff\n"
-                        "   jno  2f\n"
-                        "   aghi %0,8\n"
-                        "   srlg %1,%1,8\n"
-                        "2: ngr  %1,%2\n"
-                        "   ic   %1,0(%1,%3)\n"
-                        "   algr %0,%1"
-                        : "=&d" (set), "+a" (bitvec), "=&d" (reg)
-                        : "a" (&_zb_findmap) : "cc" );
-                if (set < (64 - bit))
-                        return set + offset;
-                offset += 64 - bit;
-                p++;
-        }
-        /*
-         * No zero yet, search remaining full words for a zero
-         */
-        res = find_first_zero_bit (p, size - 64 * (p - (unsigned long *) addr));
-        return (offset + res);
-}
-
-static inline unsigned long
-find_next_bit (const unsigned long * addr, unsigned long size, unsigned long offset)
-{
-        unsigned long * p = ((unsigned long *) addr) + (offset >> 6);
-        unsigned long bitvec, reg;
-        unsigned long set, bit = offset & 63, res;
-
-        if (bit) {
-                /*
-                 * Look for zero in first word
-                 */
-                bitvec = (*p) >> bit;
-                __asm__("   slgr %0,%0\n"
-                        "   ltr  %1,%1\n"
-                        "   jnz  0f\n"
-                        "   aghi %0,32\n"
-                        "   srlg %1,%1,32\n"
-			"0: lghi %2,0xff\n"
-                        "   tmll %1,0xffff\n"
-                        "   jnz  1f\n"
-                        "   aghi %0,16\n"
-                        "   srlg %1,%1,16\n"
-                        "1: tmll %1,0x00ff\n"
-                        "   jnz  2f\n"
-                        "   aghi %0,8\n"
-                        "   srlg %1,%1,8\n"
-                        "2: ngr  %1,%2\n"
-                        "   ic   %1,0(%1,%3)\n"
-                        "   algr %0,%1"
-                        : "=&d" (set), "+a" (bitvec), "=&d" (reg)
-                        : "a" (&_sb_findmap) : "cc" );
-                if (set < (64 - bit))
-                        return set + offset;
-                offset += 64 - bit;
-                p++;
-        }
-        /*
-         * No set bit yet, search remaining full words for a bit
-         */
-        res = find_first_bit (p, size - 64 * (p - (unsigned long *) addr));
-        return (offset + res);
-}
-
 #endif /* __s390x__ */
 
-/*
- * ffz = Find First Zero in word. Undefined if no zero exists,
- * so code should check against ~0UL first..
- */
-static inline unsigned long ffz(unsigned long word)
+static inline int
+find_next_zero_bit (const unsigned long * addr, unsigned long size,
+		    unsigned long offset)
 {
-        unsigned long bit = 0;
+        const unsigned long *p;
+	unsigned long bit, set;
 
-#ifdef __s390x__
-	if (likely((word & 0xffffffff) == 0xffffffff)) {
-		word >>= 32;
-		bit += 32;
+	if (offset >= size)
+		return size;
+	bit = offset & (__BITOPS_WORDSIZE - 1);
+	offset -= bit;
+	size -= offset;
+	p = addr + offset / __BITOPS_WORDSIZE;
+	if (bit) {
+		/*
+		 * s390 version of ffz returns __BITOPS_WORDSIZE
+		 * if no zero bit is present in the word.
+		 */
+		set = ffz(*p >> bit) + bit;
+		if (set >= size)
+			return size + offset;
+		if (set < __BITOPS_WORDSIZE)
+			return set + offset;
+		offset += __BITOPS_WORDSIZE;
+		size -= __BITOPS_WORDSIZE;
+		p++;
 	}
-#endif
-	if (likely((word & 0xffff) == 0xffff)) {
-		word >>= 16;
-		bit += 16;
-	}
-	if (likely((word & 0xff) == 0xff)) {
-		word >>= 8;
-		bit += 8;
-	}
-	return bit + _zb_findmap[word & 0xff];
+	return offset + find_first_zero_bit(p, size);
 }
 
-/*
- * __ffs = find first bit in word. Undefined if no bit exists,
- * so code should check against 0UL first..
- */
-static inline unsigned long __ffs (unsigned long word)
+static inline int
+find_next_bit (const unsigned long * addr, unsigned long size,
+	       unsigned long offset)
 {
-	unsigned long bit = 0;
+        const unsigned long *p;
+	unsigned long bit, set;
 
-#ifdef __s390x__
-	if (likely((word & 0xffffffff) == 0)) {
-		word >>= 32;
-		bit += 32;
+	if (offset >= size)
+		return size;
+	bit = offset & (__BITOPS_WORDSIZE - 1);
+	offset -= bit;
+	size -= offset;
+	p = addr + offset / __BITOPS_WORDSIZE;
+	if (bit) {
+		/*
+		 * s390 version of __ffs returns __BITOPS_WORDSIZE
+		 * if no one bit is present in the word.
+		 */
+		set = __ffs(*p & (~0UL << bit));
+		if (set >= size)
+			return size + offset;
+		if (set < __BITOPS_WORDSIZE)
+			return set + offset;
+		offset += __BITOPS_WORDSIZE;
+		size -= __BITOPS_WORDSIZE;
+		p++;
 	}
-#endif
-	if (likely((word & 0xffff) == 0)) {
-		word >>= 16;
-		bit += 16;
-	}
-	if (likely((word & 0xff) == 0)) {
-		word >>= 8;
-		bit += 8;
-	}
-	return bit + _sb_findmap[word & 0xff];
+	return offset + find_first_bit(p, size);
 }
 
 /*
@@ -1031,49 +924,6 @@ ext2_find_first_zero_bit(void *vaddr, un
         return (res < size) ? res : size;
 }
 
-static inline int 
-ext2_find_next_zero_bit(void *vaddr, unsigned int size, unsigned offset)
-{
-        unsigned long *addr = vaddr;
-        unsigned long *p = addr + (offset >> 5);
-        unsigned long word, reg;
-        unsigned int bit = offset & 31UL, res;
-
-        if (offset >= size)
-                return size;
-
-        if (bit) {
-                __asm__("   ic   %0,0(%1)\n"
-                        "   icm  %0,2,1(%1)\n"
-                        "   icm  %0,4,2(%1)\n"
-                        "   icm  %0,8,3(%1)"
-                        : "=&a" (word) : "a" (p) : "cc" );
-		word >>= bit;
-                res = bit;
-                /* Look for zero in first longword */
-                __asm__("   lhi  %2,0xff\n"
-                        "   tml  %1,0xffff\n"
-                	"   jno  0f\n"
-                	"   ahi  %0,16\n"
-                	"   srl  %1,16\n"
-                	"0: tml  %1,0x00ff\n"
-                	"   jno  1f\n"
-                	"   ahi  %0,8\n"
-                	"   srl  %1,8\n"
-                	"1: nr   %1,%2\n"
-                	"   ic   %1,0(%1,%3)\n"
-                	"   alr  %0,%1"
-                	: "+&d" (res), "+&a" (word), "=&d" (reg)
-                  	: "a" (&_zb_findmap) : "cc" );
-                if (res < 32)
-			return (p - addr)*32 + res;
-                p++;
-        }
-        /* No zero yet, search remaining full bytes for a zero */
-        res = ext2_find_first_zero_bit (p, size - 32 * (p - addr));
-        return (p - addr) * 32 + res;
-}
-
 #else /* __s390x__ */
 
 static inline unsigned long
@@ -1120,56 +970,46 @@ ext2_find_first_zero_bit(void *vaddr, un
         return (res < size) ? res : size;
 }
 
-static inline unsigned long
+#endif /* __s390x__ */
+
+static inline int
 ext2_find_next_zero_bit(void *vaddr, unsigned long size, unsigned long offset)
 {
-        unsigned long *addr = vaddr;
-        unsigned long *p = addr + (offset >> 6);
-        unsigned long word, reg;
-        unsigned long bit = offset & 63UL, res;
+        unsigned long *addr = vaddr, *p;
+	unsigned long word, bit, set;
 
         if (offset >= size)
                 return size;
-
+	bit = offset & (__BITOPS_WORDSIZE - 1);
+	offset -= bit;
+	size -= offset;
+	p = addr + offset / __BITOPS_WORDSIZE;
         if (bit) {
-                __asm__("   lrvg %0,%1" /* load reversed, neat instruction */
-                        : "=a" (word) : "m" (*p) );
-                word >>= bit;
-                res = bit;
-                /* Look for zero in first 8 byte word */
-                __asm__("   lghi %2,0xff\n"
-			"   tmll %1,0xffff\n"
-			"   jno  2f\n"
-			"   ahi  %0,16\n"
-			"   srlg %1,%1,16\n"
-                	"0: tmll %1,0xffff\n"
-                        "   jno  2f\n"
-                        "   ahi  %0,16\n"
-                        "   srlg %1,%1,16\n"
-                        "1: tmll %1,0xffff\n"
-                        "   jno  2f\n"
-                        "   ahi  %0,16\n"
-                        "   srl  %1,16\n"
-                        "2: tmll %1,0x00ff\n"
-                	"   jno  3f\n"
-                	"   ahi  %0,8\n"
-                	"   srl  %1,8\n"
-                	"3: ngr  %1,%2\n"
-                	"   ic   %1,0(%1,%3)\n"
-                	"   alr  %0,%1"
-                	: "+&d" (res), "+a" (word), "=&d" (reg)
-                  	: "a" (&_zb_findmap) : "cc" );
-                if (res < 64)
-			return (p - addr)*64 + res;
-                p++;
+#ifndef __s390x__
+                asm("   ic   %0,0(%1)\n"
+		    "   icm  %0,2,1(%1)\n"
+		    "   icm  %0,4,2(%1)\n"
+		    "   icm  %0,8,3(%1)"
+		    : "=&a" (word) : "a" (p), "m" (*p) : "cc" );
+#else
+                asm("   lrvg %0,%1" : "=a" (word) : "m" (*p) );
+#endif
+		/*
+		 * s390 version of ffz returns __BITOPS_WORDSIZE
+		 * if no zero bit is present in the word.
+		 */
+		set = ffz(word >> bit) + bit;
+		if (set >= size)
+			return size + offset;
+		if (set < __BITOPS_WORDSIZE)
+			return set + offset;
+		offset += __BITOPS_WORDSIZE;
+		size -= __BITOPS_WORDSIZE;
+		p++;
         }
-        /* No zero yet, search remaining full bytes for a zero */
-        res = ext2_find_first_zero_bit (p, size - 64 * (p - addr));
-        return (p - addr) * 64 + res;
+	return offset + ext2_find_first_zero_bit(p, size);
 }
 
-#endif /* __s390x__ */
-
 /* Bitmap functions for the minix filesystem.  */
 /* FIXME !!! */
 #define minix_test_and_set_bit(nr,addr) \
