Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266024AbUAQKHk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 05:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266027AbUAQKHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 05:07:40 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:63449 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S266024AbUAQKHb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 05:07:31 -0500
Date: Sat, 17 Jan 2004 02:07:14 -0800
From: Paul Jackson <pj@sgi.com>
To: joe.korty@ccur.com
Cc: akpm@osdl.org, paulus@samba.org, linux-kernel@vger.kernel.org,
       Matthew Dobson <colpatch@us.ibm.com>
Subject: Re: seperator error in __mask_snprintf_len
Message-Id: <20040117020714.4de583c8.pj@sgi.com>
In-Reply-To: <20040116142351.GA2433@tsunami.ccur.com>
References: <20040108051111.4ae36b58.pj@sgi.com>
	<16381.57040.576175.977969@cargo.ozlabs.ibm.com>
	<20040108225929.GA24089@tsunami.ccur.com>
	<16381.61618.275775.487768@cargo.ozlabs.ibm.com>
	<20040114150331.02220d4d.pj@sgi.com>
	<20040115002703.GA20971@tsunami.ccur.com>
	<20040114204009.3dc4c225.pj@sgi.com>
	<20040115081533.63c61d7f.akpm@osdl.org>
	<20040115181525.GA31086@tsunami.ccur.com>
	<20040115211402.04c5c2c4.pj@sgi.com>
	<20040116142351.GA2433@tsunami.ccur.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe wrote:
> First of all, I don't like my parser anymore so I hope you don't back
> out, Paul.

Well, I see Joe has already refined his version, as version 3
in my inbox.

Here is a half-baked refinement of mine, based on Joe's version 2
of a couple days ago:

 o It is called with a bit count, not a byte count.
 o It uses kmalloc()/kfree(), instead of implied alloca().
 o The M32X() eor-1 index swizzling was moved to linux/bitops.h
 o The CHUNKSZ is 32.  Thanks, Matthew.

However:
 - The parsing code is in my u32 word style, but the printing
     code in Joe's bit fiddling style.
 - It has never been tested.
 - It is now only moderately "simpler" than Joe's version 3,
     in my view.  Source line count may well favor Joe's by
     now.
 - While I moved the ifdef'd defines of the magic eor-1 index
     macro to linux/bitops.h, it's still an ifdef'd define,
     because I still think that is the most robust and maintainable
     way of stating this detail.
 - It has not been upgraded with any relavent refinements from
     Joe's version 3.

My take is that we should go with Joe's.  Personally, I don't like, and
avoid at great effort, bit coding.  However, this stuff _is_ all about
bits, and for the purposes of maintainability, I conjecture that it is
better to have code in a style that future hackers of this code are most
likely to be comfortable with.  My careful use of C types to avoid bit
details is a minor negative, even if it does reduce the code size a
little.

If there is a concensus to the contrary, and a hue and cry for my u32
word style of coding, then the printing routine should be redone in the
same style, and the other negatives above addressed, before this is
accepted.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1506  -> 1.1507 
#	        lib/bitmap.c	1.1     -> 1.2    
#	include/linux/bitops.h	1.6     -> 1.7    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/01/17	pj@sgi.com	1.1507
# rework bitmap_parse - takes bits, u32 word style algorithm
# --------------------------------------------
#
diff -Nru a/include/linux/bitops.h b/include/linux/bitops.h
--- a/include/linux/bitops.h	Sat Jan 17 01:47:35 2004
+++ b/include/linux/bitops.h	Sat Jan 17 01:47:35 2004
@@ -130,4 +130,29 @@
 	return sizeof(w) == 4 ? generic_hweight32(w) : generic_hweight64(w);
 }
 
+/*
+ * Bitops apply to arrays of unsigned long.  This is almost
+ * the same as an array of unsigned ints, except on 64 bit big
+ * endian architectures, in which the two 32-bit int halves of
+ * each long are reversed (big 32-bit halfword first, naturally).
+ *
+ * Use this BIT32X (for "BITop 32-bit indeX") macro to index the
+ * i-th word of a bit mask declared as an array of 32 bit words.
+ *
+ * Usage example accessing 32-bit words in mask[] in order,
+ * smallest first:
+ *    u32 mask[MASKLENGTH];
+ *    int i;
+ *    for (i = 0; i < MASKLENGTH; i++)
+ *        ... mask[BIT32X(i)] ...
+ */
+#ifndef BIT32X
+#include <asm/byteorder.h>
+#if BITS_PER_LONG == 64 && defined(__BIG_ENDIAN)
+#define BIT32X(i) ((i)^1)
+#elif BITS_PER_LONG == 32 || defined(__LITTLE_ENDIAN)
+#define BIT32X(i) (i)
+#endif
+#endif
+
 #endif
diff -Nru a/lib/bitmap.c b/lib/bitmap.c
--- a/lib/bitmap.c	Sat Jan 17 01:47:35 2004
+++ b/lib/bitmap.c	Sat Jan 17 01:47:35 2004
@@ -11,11 +11,12 @@
 #include <linux/ctype.h>
 #include <linux/errno.h>
 #include <linux/bitmap.h>
+#include <linux/slab.h>
 #include <asm/uaccess.h>
 
-#define CHUNKSZ		16
+#define CHUNKSZ		32
 
-#define ROUNDUP_POWER2(val,modulus) (((val) + (modulus) - 1) & ~((modulus) - 1))
+#define ROUND_UP(val,modulus) (((val) + (modulus) - 1) & ~((modulus) - 1))
 
 
 /**
@@ -25,8 +26,8 @@
  * @maskp: pointer to bitmap to convert
  * @nmaskbits: size of bitmap, in bits
  *
- * Exactly nmaskbits bits are displayed.  Hex digits are grouped into
- * fours seperated by commas.
+ * Exactly nmaskbits bits are displayed.  Hex digits are put
+ * in groups of eight, seperated by commas.
  */
 
 int bitmap_snprintf(char *buf, unsigned int buflen,
@@ -42,7 +43,7 @@
 	if (chunksz == 0)
 		chunksz = CHUNKSZ;
 
-	i = ROUNDUP_POWER2(nmaskbits, CHUNKSZ) - CHUNKSZ;
+	i = ROUND_UP(nmaskbits, CHUNKSZ) - CHUNKSZ;
 	for (; i >= 0; i -= CHUNKSZ) {
 		chunkmask = ((1ULL << chunksz) - 1);
 		word = i / BITS_PER_LONG;
@@ -55,6 +56,11 @@
 	}
 	return len;
 }
+
+#define MAX_HEX_PER_BYTE 4	/* dont need > 4 hex chars to encode byte */
+#define BASE 16			/* masks are input in hex (base 16) */
+#define NUL ((char)'\0')	/* nul-terminator */
+
 /**
 * bitmap_parse - convert an ASCII hex string into a bitmap.
 * @buf: pointer to buffer in user space containing string.
@@ -63,68 +69,89 @@
 * @maskp: pointer to bitmap that will contain result.
 * @nmaskbits: size of bitmap, in bits.
 *
-* Commas group hex digits into chunks. Each chunk defines exactly 16
+* Commas group hex digits into chunks. Each chunk defines exactly 32
 * bits of the resultant bitmask.  No chunk may specify a value larger
-* than 16 bits (-EOVERFLOW), and if a chunk specifies a smaller value
+* than 32 bits (-EOVERFLOW), and if a chunk specifies a smaller value
 * leading 0-bits are appended.
+*
+* Since the user only needs about 2.25 chars per byte to encode
+* a mask (one char per nibble plus one comma separator or nul
+* terminator per byte), we blow them off with -EINVAL if they
+* claim a @ubuflen more than 4 (MAX_HEX_PER_BYTE) times maskbytes.
+* An empty word (delimited by two consecutive commas, for example)
+* is taken as zero.  If @buflen is zero, the entire @maskp is set
+* to zero.
+*
+* If the user provides fewer comma-separated ascii words
+* than there are 32 bit words in maskbytes, we zero fill the
+* remaining high order words.  If they provide more, they fail
+* with -EINVAL.  Each comma-separate ascii word is taken as
+* a hex representation; leading zeros are ignored, and do not
+* imply octal.  '00e1', 'e1', '00E1', 'E1' are all the same.
+* If user passes a word that is larger than fits in a u32,
+* they fail with -EOVERFLOW.
 */
+
 int bitmap_parse(const char __user *ubuf, unsigned int ubuflen,
         unsigned long *maskp, unsigned int nmaskbits)
 {
-	int i, j, c, d, n, nt;
-	int nchunks = ROUNDUP_POWER2(nmaskbits, CHUNKSZ) / CHUNKSZ;
-	u32 chunk, firstchunk = 0;
-	int chunkoff = nmaskbits & (CHUNKSZ - 1);
-	u32 chunkmask = ~((1U << chunkoff) - 1);
-
-	bitmap_clear(maskp, nmaskbits);
-
-	i = nt = 0;
-	while (ubuflen) {
-		chunk = c = n = 0;
-		while (ubuflen) {
-			if (get_user(c, ubuf++)) 
-				return -EFAULT;
-			ubuflen--;
-			if (!c || c == ',')
-				break;
-			if (isspace(c))
-				continue;
-			if (!isxdigit(c))
-				return -EINVAL;
-			if (chunk & ~((1UL << (CHUNKSZ - 4)) - 1))
-				return -EOVERFLOW;
-			d = isdigit(c) ? (c - '0') : (toupper(c) - 'A' + 10);
-			chunk = (chunk << 4) | d;
-			n++; nt++;
-		}
-		if (n==0) {
-			if (c == ',')
-				return -EINVAL;
-			if (!c)
-				break;
+	char *buf;		/* copy user's ubuf[] to here */
+	char *bp;		/* strsep() cursor over buf[] */
+	unsigned maskbytes;	/* bytes in nmaskbits, round to sizeof(u32) */
+	u32 *wordp;		/* access output maskp as array of u32 */
+	char *p;		/* scan comma separated input hex words */
+	int i, j;		/* index output wordp[] */
+	int lwbits;		/* num bits ok set in last word (0 == all) */
+	int ret;		/* return value */
+
+	maskbytes = ROUND_UP(nmaskbits, CHUNKSZ)/CHUNKSZ;
+	if (ubuflen > maskbytes * MAX_HEX_PER_BYTE)
+		return -EINVAL;
+	buf = kmalloc(maskbytes * MAX_HEX_PER_BYTE + sizeof(NUL), GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+	if (copy_from_user(buf, ubuf, ubuflen)) {
+		ret = -EFAULT;
+		goto out;
+	}
+	buf[ubuflen] = NUL;
+
+	/*
+	 * Put the words into wordp[] in big-endian order,
+	 * make sure no bits above nmaskbits set in last word,
+	 * and then go back and reverse the words.
+	 */
+	wordp = (u32 *)maskp;
+	memset(maskp, 0, ROUND_UP(maskbytes, sizeof(*maskp)));
+	i = j = 0;
+	bp = buf;
+	while ((p = strsep(&bp, ",")) != NULL) {
+		unsigned long long t;
+		if (j == maskbytes/sizeof(u32)) {
+			ret = -EINVAL;
+			goto out;
 		}
-		if (i >= nchunks)
-			return -EOVERFLOW;
-		if (i > 0 || chunk) {
-			bitmap_shift_right(maskp, maskp, CHUNKSZ, nmaskbits);
-			for (j = 0; j < 32; j++) {
-				if (chunk & (1 << j)) {
-					set_bit(j, maskp);
-				}
-			}
-			i++;
-			if (i == 1)
-				firstchunk = chunk;
-			if ( i == nchunks) {
-				if (chunkoff && (firstchunk & chunkmask)) {
-					/* input value > 2^nmaskbits -1 */
-					return -EOVERFLOW;
-				}
-			}
+		t = simple_strtoull(p, 0, BASE);
+		if (t != (u32)t) {
+			ret = -EOVERFLOW;
+			goto out;
 		}
+		wordp[BIT32X(j++)] = t;
 	}
-	if (nt == 0)
-		return -EINVAL;
-	return 0;
+	lwbits = nmaskbits % CHUNKSZ;
+	if (lwbits && (wordp[0] & ~((1<<lwbits) - 1))) {
+		ret = -EOVERFLOW;
+		goto out;
+	}
+	--j;
+	while (i < j) {
+		u32 t = wordp[BIT32X(i)];
+		wordp[BIT32X(i)] = wordp[BIT32X(j)];
+		wordp[BIT32X(j)] = t;
+		i++, --j;
+	}
+	ret = 0;
+ out:
+	kfree(buf);
+	return ret;
 }


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
