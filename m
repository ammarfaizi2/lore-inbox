Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265173AbUAOSQO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 13:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265203AbUAOSQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 13:16:14 -0500
Received: from mail.ccur.com ([208.248.32.212]:12050 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S265173AbUAOSPg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 13:15:36 -0500
Date: Thu, 15 Jan 2004 13:15:25 -0500
From: Joe Korty <joe.korty@ccur.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Jackson <pj@sgi.com>, paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: seperator error in __mask_snprintf_len
Message-ID: <20040115181525.GA31086@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <20040107165607.GA11483@rudolph.ccur.com> <20040107113207.3aab64f5.akpm@osdl.org> <20040108051111.4ae36b58.pj@sgi.com> <16381.57040.576175.977969@cargo.ozlabs.ibm.com> <20040108225929.GA24089@tsunami.ccur.com> <16381.61618.275775.487768@cargo.ozlabs.ibm.com> <20040114150331.02220d4d.pj@sgi.com> <20040115002703.GA20971@tsunami.ccur.com> <20040114204009.3dc4c225.pj@sgi.com> <20040115081533.63c61d7f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040115081533.63c61d7f.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul and Andrew,
This patch captures what I am looking for in bitmap display and input.

The biggest feature is the folding of all functionality into the bitmap.h
family, with corresponding name and function call argument changes.

bitmap size is now expressed in #bits rather than #bytes.  The cpumask
parse and display functions now call the bitmap functions with NR_CPUS.
Thus on display exactly NR_CPUS bits are displayed, no more and no less,
and on input no value is accepted which is larger than what can be stored
in exactly NR_CPUS bits.


ChangeLog:
 o move into the bitmap.h family, rename and refactor interface to match
 o bitmap size resolution changed from byte to bit
 o no limits on string length when parsing
 o chunking (digits between commas) changed from 8 to 4 digits
 o display no longer affected by sizeof(unsigned long).
 o no alloca usage
 o works correctly independent of the size of an unsigned long.
 o works on big and little endian machine.

Downsides:
 o code is subtle and fragile.  Corner cases may be present.

Most of the subtlety is for handling bitmask size resolution down to
the bit and for detecting illegal syntax such as "3,,2" "," and "".

These routines have been tested in user-land on both a big and little
endian machine.  Testing focused mainly on standard and corner bitmap
sizes (1,2,3,4,5,7,8,15,16,17,31,32,33,36,37,48,64 and 96), for a wide
variety of legal syntax and illegal syntax (eg legal: "0", "00", "0,0",
"0,0,0,00000000000017,0", "dead,beaf", "a,beaf", "beaf,a").

Regards,
Joe



Regards,
Joe

diff -Nua 2.6/lib/Makefile.0 2.6/lib/Makefile
--- 2.6/lib/Makefile.0	2004-01-15 12:10:41.000000000 -0500
+++ 2.6/lib/Makefile	2004-01-15 11:37:01.000000000 -0500
@@ -5,7 +5,7 @@
 
 lib-y := errno.o ctype.o string.o vsprintf.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
-	 kobject.o idr.o div64.o parser.o int_sqrt.o mask.o
+	 kobject.o idr.o div64.o parser.o int_sqrt.o bitmap.o
 
 lib-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
 lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
diff -Nua 2.6/lib/bitmap.c.0 2.6/lib/bitmap.c
--- 2.6/lib/bitmap.c.0	2004-01-15 12:10:41.000000000 -0500
+++ 2.6/lib/bitmap.c	2004-01-15 12:08:10.000000000 -0500
@@ -0,0 +1,130 @@
+/*
+ * lib/bitmask.c - bitmask manipulation routines too big to go into bitmask.h
+ *
+ * Copyright 2002, Concurrent Computer Corporation, and distributed under
+ * the GNU GPL license version 2.  For other license arrangements, contact
+ * Concurrent Computer Corporation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/ctype.h>
+#include <linux/errno.h>
+#include <linux/bitmap.h>
+#include <asm/uaccess.h>
+
+#define CHUNKSZ		16
+
+#define ROUNDUP_POWER2(val,modulus) (((val) + (modulus) - 1) & ~((modulus) - 1))
+
+
+/**
+ * bitmap_snprintf - convert bitmap to an ASCII hex string.
+ * @buf: byte buffer into which string is placed
+ * @buflen: reserved size of @buf, in bytes
+ * @maskp: pointer to bitmap to convert
+ * @nmaskbits: size of bitmap, in bits
+ *
+ * Exactly nmaskbits bits are displayed.  Hex digits are grouped into
+ * fours seperated by commas.
+ */
+
+int bitmap_snprintf(char *buf, unsigned int buflen,
+	const unsigned long *maskp, unsigned int nmaskbits)
+{
+	int i, word, bit, len = 0; 
+	unsigned long val;
+	const char *sep = "";
+	int chunksz;
+	u32 chunkmask;
+
+	chunksz = nmaskbits & (CHUNKSZ - 1);
+	if (chunksz == 0)
+		chunksz = CHUNKSZ;
+
+	i = ROUNDUP_POWER2(nmaskbits, CHUNKSZ) - CHUNKSZ;
+	for (; i >= 0; i -= CHUNKSZ) {
+		chunkmask = ((1ULL << chunksz) - 1);
+		word = i / BITS_PER_LONG;
+		bit = i % BITS_PER_LONG;
+		val = (maskp[word] >> bit) & chunkmask;
+		len += snprintf(buf+len, buflen-len, "%s%0*lx", sep,
+			(chunksz+3)/4, val);
+		chunksz = CHUNKSZ;
+		sep = ",";
+	}
+	return len;
+}
+/**
+* bitmap_parse - convert an ASCII hex string into a bitmap.
+* @buf: pointer to buffer in user space containing string.
+* @buflen: buffer size in bytes.  If string is smaller than this
+*    then it must be terminated by a \0.
+* @maskp: pointer to bitmap that will contain result.
+* @nmaskbits: size of bitmap, in bits.
+*
+* Commas group hex digits into chunks. Each chunk defines exactly 16
+* bits of the resultant bitmask.  No chunk may specify a value larger
+* than 16 bits (-EOVERFLOW), and if a chunk specifies a smaller value
+* leading 0-bits are appended.
+*/
+int bitmap_parse(const char __user *ubuf, unsigned int ubuflen,
+        unsigned long *maskp, unsigned int nmaskbits)
+{
+	int i, j, c, d, n, nt;
+	int nchunks = ROUNDUP_POWER2(nmaskbits, CHUNKSZ) / CHUNKSZ;
+	u32 chunk, firstchunk = 0;
+	int chunkoff = nmaskbits & (CHUNKSZ - 1);
+	u32 chunkmask = ~((1U << chunkoff) - 1);
+
+	bitmap_clear(maskp, nmaskbits);
+
+	i = nt = 0;
+	while (ubuflen) {
+		chunk = c = n = 0;
+		while (ubuflen) {
+			if (get_user(c, ubuf++)) 
+				return -EFAULT;
+			ubuflen--;
+			if (!c || c == ',')
+				break;
+			if (isspace(c))
+				continue;
+			if (!isxdigit(c))
+				return -EINVAL;
+			if (chunk & ~((1UL << (CHUNKSZ - 4)) - 1))
+				return -EOVERFLOW;
+			d = isdigit(c) ? (c - '0') : (toupper(c) - 'A' + 10);
+			chunk = (chunk << 4) | d;
+			n++; nt++;
+		}
+		if (n==0) {
+			if (c == ',')
+				return -EINVAL;
+			if (!c)
+				break;
+		}
+		if (i >= nchunks)
+			return -EOVERFLOW;
+		if (i > 0 || chunk) {
+			bitmap_shift_right(maskp, maskp, CHUNKSZ, nmaskbits);
+			for (j = 0; j < 32; j++) {
+				if (chunk & (1 << j)) {
+					set_bit(j, maskp);
+				}
+			}
+			i++;
+			if (i == 1)
+				firstchunk = chunk;
+			if ( i == nchunks) {
+				if (chunkoff && (firstchunk & chunkmask)) {
+					/* input value > 2^nmaskbits -1 */
+					return -EOVERFLOW;
+				}
+			}
+		}
+	}
+	if (nt == 0)
+		return -EINVAL;
+	return 0;
+}
diff -Nua 2.6/include/linux/bitmap.h.0 2.6/include/linux/bitmap.h
--- 2.6/include/linux/bitmap.h.0	2004-01-15 12:10:41.000000000 -0500
+++ 2.6/include/linux/bitmap.h	2004-01-15 11:44:21.000000000 -0500
@@ -154,6 +154,12 @@
 }
 #endif
 
+extern int bitmap_snprintf(char *buf, unsigned int buflen,
+	const unsigned long *maskp, unsigned int nmaskbits);
+
+extern int bitmap_parse(const char __user *ubuf, unsigned int ubuflen,
+        unsigned long *maskp, unsigned int nmaskbits);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __LINUX_BITMAP_H */
diff -Nua 2.6/include/linux/cpumask.h.0 2.6/include/linux/cpumask.h
--- 2.6/include/linux/cpumask.h.0	2004-01-15 12:10:41.000000000 -0500
+++ 2.6/include/linux/cpumask.h	2004-01-15 11:41:26.000000000 -0500
@@ -2,6 +2,7 @@
 #define __LINUX_CPUMASK_H
 
 #include <linux/threads.h>
+#include <linux/bitmap.h>
 #include <asm/cpumask.h>
 #include <asm/bug.h>
 
@@ -35,16 +36,10 @@
 		cpu < NR_CPUS;						\
 		cpu = next_online_cpu(cpu,map))
 
-extern int __mask_snprintf_len(char *buf, unsigned int buflen,
-		const unsigned long *maskp, unsigned int maskbytes);
-
 #define cpumask_snprintf(buf, buflen, map)				\
-	__mask_snprintf_len(buf, buflen, cpus_addr(map), sizeof(map))
-
-extern int __mask_parse_len(const char __user *ubuf, unsigned int ubuflen,
-	unsigned long *maskp, unsigned int maskbytes);
+	bitmap_snprintf(buf, buflen, cpus_addr(map), NR_CPUS)
 
 #define cpumask_parse(buf, buflen, map)					\
-	__mask_parse_len(buf, buflen, cpus_addr(map), sizeof(map))
+	bitmap_parse(buf, buflen, cpus_addr(map), NR_CPUS)
 
 #endif /* __LINUX_CPUMASK_H */
diff -Nua 2.6/lib/mask.c.0 2.6/lib/mask.c
--- 2.6/lib/mask.c.0	2004-01-15 12:10:41.000000000 -0500
+++ 2.6/lib/mask.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,178 +0,0 @@
-/*
- * lib/mask.c
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2003 Silicon Graphics, Inc.  All Rights Reserved.
- */
-
-/*
- * Routines to manipulate multi-word bit masks, such as cpumasks.
- *
- * The ascii representation of multi-word bit masks displays each
- * 32bit word in hex (not zero filled), and for masks longer than
- * one word, uses a comma separator between words.  Words are
- * displayed in big-endian order most significant first.  And hex
- * digits within a word are also in big-endian order, of course.
- *
- * Examples:
- *   A mask with just bit 0 set displays as "1".
- *   A mask with just bit 127 set displays as "80000000,0,0,0".
- *   A mask with just bit 64 set displays as "1,0,0".
- *   A mask with bits 0, 1, 2, 4, 8, 16, 32 and 64 set displays
- *     as "1,1,10117".  The first "1" is for bit 64, the second
- *     for bit 32, the third for bit 16, and so forth, to the
- *     "7", which is for bits 2, 1 and 0.
- *   A mask with bits 32 through 39 set displays as "ff,0".
- *
- * The internal binary representation of masks is as one or
- * an array of unsigned longs, perhaps wrapped in a struct for
- * convenient use as an lvalue.  The following code doesn't know
- * about any such struct details, relying on inline macros in
- * files such as cpumask.h to pass in an unsigned long pointer
- * and a length (in bytes), describing the mask contents.
- * The 32bit words in the array are in little-endian order,
- * low order word first.  Beware that this is the reverse order
- * of the ascii representation.
- *
- * Even though the size of the input mask is provided in bytes,
- * the following code may assume that the mask is a multiple of
- * 32 or 64 bit words long, and ignore any fractional portion
- * of a word at the end.  The main reason the size is passed in
- * bytes is because it is so easy to write 'sizeof(somemask_t)'
- * in the macros.
- *
- * Masks are not a single,simple type, like classic 'C'
- * nul-term strings.  Rather they are a family of types, one
- * for each different length.  Inline macros are used to pick
- * up the actual length, where it is known to the compiler, and
- * pass it down to these routines, which work on any specified
- * length array of unsigned longs.  Poor man's templates.
- *
- * Many of the inline macros don't call into the following
- * routines.  Some of them call into other kernel routines,
- * such as memset(), set_bit() or ffs().  Some of them can
- * accomplish their task right inline, such as returning the
- * size or address of the unsigned long array, or optimized
- * versions of the macros for the most common case of an array
- * of a single unsigned long.
- */
-
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/ctype.h>
-#include <linux/slab.h>
-#include <linux/errno.h>
-#include <linux/gfp.h>
-#include <asm/uaccess.h>
-
-#define MAX_HEX_PER_BYTE 4	/* dont need > 4 hex chars to encode byte */
-#define BASE 16			/* masks are input in hex (base 16) */
-#define NUL ((char)'\0')	/* nul-terminator */
-
-/**
- * __mask_snprintf_len - represent multi-word bit mask as string.
- * @buf: The buffer to place the result into
- * @buflen: The size of the buffer, including the trailing null space
- * @maskp: Points to beginning of multi-word bit mask.
- * @maskbytes: Number of bytes in bit mask at maskp.
- *
- * This routine is expected to be called from a macro such as:
- *
- * #define cpumask_snprintf(buf, buflen, mask) \
- *   __mask_snprintf_len(buf, buflen, cpus_addr(mask), sizeof(mask))
- */
-
-int __mask_snprintf_len(char *buf, unsigned int buflen,
-	const unsigned long *maskp, unsigned int maskbytes)
-{
-	u32 *wordp = (u32 *)maskp;
-	int i = maskbytes/sizeof(u32) - 1;
-	int len = 0;
-	char *sep = "";
-
-	while (i >= 1 && wordp[i] == 0)
-		i--;
-	while (i >= 0) {
-		len += snprintf(buf+len, buflen-len, "%s%x", sep, wordp[i]);
-		sep = ",";
-		i--;
-	}
-	return len;
-}
-
-/**
- * __mask_parse_len - parse user string into maskbytes mask at maskp
- * @ubuf: The user buffer from which to take the string
- * @ubuflen: The size of this buffer, including the terminating char
- * @maskp: Place resulting mask (array of unsigned longs) here
- * @masklen: Construct mask at @maskp to have exactly @masklen bytes
- *
- * @masklen is a multiple of sizeof(unsigned long).  A mask of
- * @masklen bytes is constructed starting at location @maskp.
- * The value of this mask is specified by the user provided
- * string starting at address @ubuf.  Only bytes in the range
- * [@ubuf, @ubuf+@ubuflen) can be read from user space, and
- * reading will stop after the first byte that is not a comma
- * or valid hex digit in the characters [,0-9a-fA-F], or at
- * the point @ubuf+@ubuflen, whichever comes first.
- *
- * Since the user only needs about 2.25 chars per byte to encode
- * a mask (one char per nibble plus one comma separator or nul
- * terminator per byte), we blow them off with -EINVAL if they
- * claim a @ubuflen more than 4 (MAX_HEX_PER_BYTE) times maskbytes.
- * An empty word (delimited by two consecutive commas, for example)
- * is taken as zero.  If @buflen is zero, the entire @maskp is set
- * to zero.
- *
- * If the user provides fewer comma-separated ascii words
- * than there are 32 bit words in maskbytes, we zero fill the
- * remaining high order words.  If they provide more, they fail
- * with -EINVAL.  Each comma-separate ascii word is taken as
- * a hex representation; leading zeros are ignored, and do not
- * imply octal.  '00e1', 'e1', '00E1', 'E1' are all the same.
- * If user passes a word that is larger than fits in a u32,
- * they fail with -EOVERFLOW.
- */
-
-int __mask_parse_len(const char __user *ubuf, unsigned int ubuflen,
-	unsigned long *maskp, unsigned int maskbytes)
-{
-	char buf[maskbytes * MAX_HEX_PER_BYTE + sizeof(NUL)];
-	char *bp = buf;
-	u32 *wordp = (u32 *)maskp;
-	char *p;
-	int i, j;
-
-	if (ubuflen > maskbytes * MAX_HEX_PER_BYTE)
-		return -EINVAL;
-	if (copy_from_user(buf, ubuf, ubuflen))
-		return -EFAULT;
-	buf[ubuflen] = NUL;
-
-	/*
-	 * Put the words into wordp[] in big-endian order,
-	 * then go back and reverse them.
-	 */
-	memset(wordp, 0, maskbytes);
-	i = j = 0;
-	while ((p = strsep(&bp, ",")) != NULL) {
-		unsigned long long t;
-		if (j == maskbytes/sizeof(u32))
-			return -EINVAL;
-		t = simple_strtoull(p, 0, BASE);
-		if (t != (u32)t)
-			return -EOVERFLOW;
-		wordp[j++] = t;
-	}
-	--j;
-	while (i < j) {
-		u32 t = wordp[i];
-		wordp[i] = wordp[j];
-		wordp[j] = t;
-		i++, --j;
-	}
-	return 0;
-}
