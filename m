Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261667AbVASIXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbVASIXX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 03:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbVASIWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 03:22:25 -0500
Received: from waste.org ([216.27.176.166]:28332 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261668AbVASIRC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 03:17:02 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9.64403262@selenic.com>
Message-Id: <10.64403262@selenic.com>
Subject: [PATCH 9/12] random pt3: Remove dead MD5 copy
Date: Wed, 19 Jan 2005 00:17:23 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove long-dead md5 code.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: rnd/drivers/char/random.c
===================================================================
--- rnd.orig/drivers/char/random.c	2005-01-18 10:40:00.654809689 -0800
+++ rnd/drivers/char/random.c	2005-01-18 10:42:17.993300522 -0800
@@ -220,10 +220,6 @@
  *
  * The code for SHA transform was taken from Peter Gutmann's
  * implementation, which has been placed in the public domain.
- * The code for MD5 transform was taken from Colin Plumb's
- * implementation, which has been placed in the public domain.
- * The MD5 cryptographic checksum was devised by Ronald Rivest, and is
- * documented in RFC 1321, "The MD5 Message Digest Algorithm".
  *
  * Further background information on this topic may be obtained from
  * RFC 1750, "Randomness Recommendations for Security", by Donald
@@ -259,7 +255,6 @@
 #define INPUT_POOL_WORDS 128
 #define OUTPUT_POOL_WORDS 32
 #define BATCH_ENTROPY_SIZE 256
-#define USE_SHA
 
 /*
  * The minimum number of bits of entropy before we wake up a read on
@@ -802,7 +797,7 @@
 
 /*
  * This chunk of code defines a function
- * void HASH_TRANSFORM(__u32 digest[HASH_BUFFER_SIZE + HASH_EXTRA_SIZE],
+ * void sha_transform(__u32 digest[HASH_BUFFER_SIZE + HASH_EXTRA_SIZE],
  * 		__u32 const data[16])
  *
  * The function hashes the input data to produce a digest in the first
@@ -812,24 +807,13 @@
  * and tacking it onto the end of the digest[] array is the quick and
  * dirty way of doing it.)
  *
- * It so happens that MD5 and SHA share most of the initial vector
- * used to initialize the digest[] array before the first call:
- * 1) 0x67452301
- * 2) 0xefcdab89
- * 3) 0x98badcfe
- * 4) 0x10325476
- * 5) 0xc3d2e1f0 (SHA only)
- *
  * For /dev/random purposes, the length of the data being hashed is
  * fixed in length, so appending a bit count in the usual way is not
  * cryptographically necessary.
  */
 
-#ifdef USE_SHA
-
 #define HASH_BUFFER_SIZE 5
 #define HASH_EXTRA_SIZE 80
-#define HASH_TRANSFORM SHATransform
 
 /* Various size/speed tradeoffs are available.  Choose 0..3. */
 #define SHA_CODE_SIZE 0
@@ -856,7 +840,7 @@
 #define subRound(a, b, c, d, e, f, k, data) \
     (e += rol32(a, 5) + f(b, c, d) + k + data, b = rol32(b, 30))
 
-static void SHATransform(__u32 digest[85], __u32 const data[16])
+static void sha_transform(__u32 digest[85], __u32 const data[16])
 {
 	__u32 A, B, C, D, E;     /* Local vars */
 	__u32 TEMP;
@@ -1058,125 +1042,6 @@
 #undef K4
 #undef subRound
 
-#else /* !USE_SHA - Use MD5 */
-
-#define HASH_BUFFER_SIZE 4
-#define HASH_EXTRA_SIZE 0
-#define HASH_TRANSFORM MD5Transform
-
-/*
- * MD5 transform algorithm, taken from code written by Colin Plumb,
- * and put into the public domain
- */
-
-/* The four core functions - F1 is optimized somewhat */
-
-/* #define F1(x, y, z) (x & y | ~x & z) */
-#define F1(x, y, z) (z ^ (x & (y ^ z)))
-#define F2(x, y, z) F1(z, x, y)
-#define F3(x, y, z) (x ^ y ^ z)
-#define F4(x, y, z) (y ^ (x | ~z))
-
-/* This is the central step in the MD5 algorithm. */
-#define MD5STEP(f, w, x, y, z, data, s) \
-	(w += f(x, y, z) + data,  w = w << s | w >> (32 - s),  w += x )
-
-/*
- * The core of the MD5 algorithm, this alters an existing MD5 hash to
- * reflect the addition of 16 longwords of new data.  MD5Update blocks
- * the data and converts bytes into longwords for this routine.
- */
-static void MD5Transform(__u32 buf[HASH_BUFFER_SIZE], __u32 const in[16])
-{
-	__u32 a, b, c, d;
-
-	a = buf[0];
-	b = buf[1];
-	c = buf[2];
-	d = buf[3];
-
-	MD5STEP(F1, a, b, c, d, in[ 0]+0xd76aa478,  7);
-	MD5STEP(F1, d, a, b, c, in[ 1]+0xe8c7b756, 12);
-	MD5STEP(F1, c, d, a, b, in[ 2]+0x242070db, 17);
-	MD5STEP(F1, b, c, d, a, in[ 3]+0xc1bdceee, 22);
-	MD5STEP(F1, a, b, c, d, in[ 4]+0xf57c0faf,  7);
-	MD5STEP(F1, d, a, b, c, in[ 5]+0x4787c62a, 12);
-	MD5STEP(F1, c, d, a, b, in[ 6]+0xa8304613, 17);
-	MD5STEP(F1, b, c, d, a, in[ 7]+0xfd469501, 22);
-	MD5STEP(F1, a, b, c, d, in[ 8]+0x698098d8,  7);
-	MD5STEP(F1, d, a, b, c, in[ 9]+0x8b44f7af, 12);
-	MD5STEP(F1, c, d, a, b, in[10]+0xffff5bb1, 17);
-	MD5STEP(F1, b, c, d, a, in[11]+0x895cd7be, 22);
-	MD5STEP(F1, a, b, c, d, in[12]+0x6b901122,  7);
-	MD5STEP(F1, d, a, b, c, in[13]+0xfd987193, 12);
-	MD5STEP(F1, c, d, a, b, in[14]+0xa679438e, 17);
-	MD5STEP(F1, b, c, d, a, in[15]+0x49b40821, 22);
-
-	MD5STEP(F2, a, b, c, d, in[ 1]+0xf61e2562,  5);
-	MD5STEP(F2, d, a, b, c, in[ 6]+0xc040b340,  9);
-	MD5STEP(F2, c, d, a, b, in[11]+0x265e5a51, 14);
-	MD5STEP(F2, b, c, d, a, in[ 0]+0xe9b6c7aa, 20);
-	MD5STEP(F2, a, b, c, d, in[ 5]+0xd62f105d,  5);
-	MD5STEP(F2, d, a, b, c, in[10]+0x02441453,  9);
-	MD5STEP(F2, c, d, a, b, in[15]+0xd8a1e681, 14);
-	MD5STEP(F2, b, c, d, a, in[ 4]+0xe7d3fbc8, 20);
-	MD5STEP(F2, a, b, c, d, in[ 9]+0x21e1cde6,  5);
-	MD5STEP(F2, d, a, b, c, in[14]+0xc33707d6,  9);
-	MD5STEP(F2, c, d, a, b, in[ 3]+0xf4d50d87, 14);
-	MD5STEP(F2, b, c, d, a, in[ 8]+0x455a14ed, 20);
-	MD5STEP(F2, a, b, c, d, in[13]+0xa9e3e905,  5);
-	MD5STEP(F2, d, a, b, c, in[ 2]+0xfcefa3f8,  9);
-	MD5STEP(F2, c, d, a, b, in[ 7]+0x676f02d9, 14);
-	MD5STEP(F2, b, c, d, a, in[12]+0x8d2a4c8a, 20);
-
-	MD5STEP(F3, a, b, c, d, in[ 5]+0xfffa3942,  4);
-	MD5STEP(F3, d, a, b, c, in[ 8]+0x8771f681, 11);
-	MD5STEP(F3, c, d, a, b, in[11]+0x6d9d6122, 16);
-	MD5STEP(F3, b, c, d, a, in[14]+0xfde5380c, 23);
-	MD5STEP(F3, a, b, c, d, in[ 1]+0xa4beea44,  4);
-	MD5STEP(F3, d, a, b, c, in[ 4]+0x4bdecfa9, 11);
-	MD5STEP(F3, c, d, a, b, in[ 7]+0xf6bb4b60, 16);
-	MD5STEP(F3, b, c, d, a, in[10]+0xbebfbc70, 23);
-	MD5STEP(F3, a, b, c, d, in[13]+0x289b7ec6,  4);
-	MD5STEP(F3, d, a, b, c, in[ 0]+0xeaa127fa, 11);
-	MD5STEP(F3, c, d, a, b, in[ 3]+0xd4ef3085, 16);
-	MD5STEP(F3, b, c, d, a, in[ 6]+0x04881d05, 23);
-	MD5STEP(F3, a, b, c, d, in[ 9]+0xd9d4d039,  4);
-	MD5STEP(F3, d, a, b, c, in[12]+0xe6db99e5, 11);
-	MD5STEP(F3, c, d, a, b, in[15]+0x1fa27cf8, 16);
-	MD5STEP(F3, b, c, d, a, in[ 2]+0xc4ac5665, 23);
-
-	MD5STEP(F4, a, b, c, d, in[ 0]+0xf4292244,  6);
-	MD5STEP(F4, d, a, b, c, in[ 7]+0x432aff97, 10);
-	MD5STEP(F4, c, d, a, b, in[14]+0xab9423a7, 15);
-	MD5STEP(F4, b, c, d, a, in[ 5]+0xfc93a039, 21);
-	MD5STEP(F4, a, b, c, d, in[12]+0x655b59c3,  6);
-	MD5STEP(F4, d, a, b, c, in[ 3]+0x8f0ccc92, 10);
-	MD5STEP(F4, c, d, a, b, in[10]+0xffeff47d, 15);
-	MD5STEP(F4, b, c, d, a, in[ 1]+0x85845dd1, 21);
-	MD5STEP(F4, a, b, c, d, in[ 8]+0x6fa87e4f,  6);
-	MD5STEP(F4, d, a, b, c, in[15]+0xfe2ce6e0, 10);
-	MD5STEP(F4, c, d, a, b, in[ 6]+0xa3014314, 15);
-	MD5STEP(F4, b, c, d, a, in[13]+0x4e0811a1, 21);
-	MD5STEP(F4, a, b, c, d, in[ 4]+0xf7537e82,  6);
-	MD5STEP(F4, d, a, b, c, in[11]+0xbd3af235, 10);
-	MD5STEP(F4, c, d, a, b, in[ 2]+0x2ad7d2bb, 15);
-	MD5STEP(F4, b, c, d, a, in[ 9]+0xeb86d391, 21);
-
-	buf[0] += a;
-	buf[1] += b;
-	buf[2] += c;
-	buf[3] += d;
-}
-
-#undef F1
-#undef F2
-#undef F3
-#undef F4
-#undef MD5STEP
-
-#endif /* !USE_SHA */
-
 /*********************************************************************
  *
  * Entropy extraction routines
@@ -1274,9 +1139,7 @@
 	buf[1] = 0xefcdab89;
 	buf[2] = 0x98badcfe;
 	buf[3] = 0x10325476;
-#ifdef USE_SHA
 	buf[4] = 0xc3d2e1f0;
-#endif
 
 	/*
 	 * As we hash the pool, we mix intermediate values of
@@ -1287,7 +1150,7 @@
 	 * function can be inverted.
 	 */
 	for (i = 0, x = 0; i < r->poolinfo->poolwords; i += 16, x+=2) {
-		HASH_TRANSFORM(buf, r->pool+i);
+		sha_transform(buf, r->pool+i);
 		add_entropy_words(r, &buf[x%HASH_BUFFER_SIZE], 1);
 	}
 
@@ -1297,7 +1160,7 @@
 	 * final time.
 	 */
 	__add_entropy_words(r, &buf[x%HASH_BUFFER_SIZE], 1, data);
-	HASH_TRANSFORM(buf, data);
+	sha_transform(buf, data);
 
 	/*
 	 * In case the hash function has some recognizable
@@ -2159,7 +2022,7 @@
 	tmp[0]=saddr;
 	tmp[1]=daddr;
 	tmp[2]=(sport << 16) + dport;
-	HASH_TRANSFORM(tmp+16, tmp);
+	sha_transform(tmp+16, tmp);
 	seq = tmp[17] + sseq + (count << COOKIEBITS);
 
 	memcpy(tmp + 3, syncookie_secret[1], sizeof(syncookie_secret[1]));
@@ -2167,7 +2030,7 @@
 	tmp[1]=daddr;
 	tmp[2]=(sport << 16) + dport;
 	tmp[3] = count;	/* minute counter */
-	HASH_TRANSFORM(tmp + 16, tmp);
+	sha_transform(tmp + 16, tmp);
 
 	/* Add in the second hash and the data */
 	return seq + ((tmp[17] + data) & COOKIEMASK);
@@ -2196,7 +2059,7 @@
 	tmp[0]=saddr;
 	tmp[1]=daddr;
 	tmp[2]=(sport << 16) + dport;
-	HASH_TRANSFORM(tmp + 16, tmp);
+	sha_transform(tmp + 16, tmp);
 	cookie -= tmp[17] + sseq;
 	/* Cookie is now reduced to (count * 2^24) ^ (hash % 2^24) */
 
@@ -2209,7 +2072,7 @@
 	tmp[1] = daddr;
 	tmp[2] = (sport << 16) + dport;
 	tmp[3] = count - diff;	/* minute counter */
-	HASH_TRANSFORM(tmp + 16, tmp);
+	sha_transform(tmp + 16, tmp);
 
 	return (cookie - tmp[17]) & COOKIEMASK;	/* Leaving the data behind */
 }
