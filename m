Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263868AbUCZAQv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 19:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263831AbUCZAHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 19:07:54 -0500
Received: from waste.org ([209.173.204.2]:55705 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263833AbUCYX6K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 18:58:10 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <14.524465763@selenic.com>
Message-Id: <15.524465763@selenic.com>
Subject: [PATCH 14/22] /dev/random: kill unused md5 copy
Date: Thu, 25 Mar 2004 17:57:45 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


/dev/random  kill unused md5 copy

Remove long-dead md5 code

 tiny-mpm/drivers/char/random.c |  160 +++--------------------------------------
 1 files changed, 12 insertions(+), 148 deletions(-)

diff -puN drivers/char/random.c~kill-md5 drivers/char/random.c
--- tiny/drivers/char/random.c~kill-md5	2004-03-20 13:38:31.000000000 -0600
+++ tiny-mpm/drivers/char/random.c	2004-03-20 13:38:31.000000000 -0600
@@ -221,17 +221,13 @@
  * number generator, which speed up the mixing function of the entropy
  * pool, taken from PGPfone.  Dale Worley has also contributed many
  * useful ideas and suggestions to improve this driver.
- * 
+ *
  * Any flaws in the design are solely my responsibility, and should
  * not be attributed to the Phil, Colin, or any of authors of PGP.
- * 
+ *
  * The code for SHA transform was taken from Peter Gutmann's
  * implementation, which has been placed in the public domain.
- * The code for MD5 transform was taken from Colin Plumb's
- * implementation, which has been placed in the public domain.
- * The MD5 cryptographic checksum was devised by Ronald Rivest, and is
- * documented in RFC 1321, "The MD5 Message Digest Algorithm".
- * 
+ *
  * Further background information on this topic may be obtained from
  * RFC 1750, "Randomness Recommendations for Security", by Donald
  * Eastlake, Steve Crocker, and Jeff Schiller.
@@ -266,7 +262,6 @@
 #define INPUT_POOL_SIZE 512
 #define BLOCKING_POOL_SIZE 128
 #define BATCH_ENTROPY_SIZE 256
-#define USE_SHA
 
 /*
  * The minimum number of bits of entropy before we wake up a read on
@@ -872,9 +867,9 @@ EXPORT_SYMBOL(add_disk_randomness);
 
 /*
  * This chunk of code defines a function
- * void HASH_TRANSFORM(__u32 digest[HASH_BUFFER_SIZE + HASH_EXTRA_SIZE],
+ * void sha_transform(__u32 digest[HASH_BUFFER_SIZE + HASH_EXTRA_SIZE],
  * 		__u32 const data[16])
- * 
+ *
  * The function hashes the input data to produce a digest in the first
  * HASH_BUFFER_SIZE words of the digest[] array, and uses HASH_EXTRA_SIZE
  * more words for internal purposes.  (This buffer is exported so the
@@ -882,24 +877,13 @@ EXPORT_SYMBOL(add_disk_randomness);
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
@@ -929,7 +913,7 @@ EXPORT_SYMBOL(add_disk_randomness);
     ( e += ROTL( 5, a ) + f( b, c, d ) + k + data, b = ROTL( 30, b ) )
 
 
-static void SHATransform(__u32 digest[85], __u32 const data[16])
+static void sha_transform(__u32 digest[85], __u32 const data[16])
 {
     __u32 A, B, C, D, E;     /* Local vars */
     __u32 TEMP;
@@ -1131,125 +1115,6 @@ static void SHATransform(__u32 digest[85
 #undef K3	
 #undef K4	
 #undef subRound
-	
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
-	( w += f(x, y, z) + data,  w = w<<s | w>>(32-s),  w += x )
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
 
 /*********************************************************************
  *
@@ -1368,9 +1233,8 @@ static ssize_t extract_entropy(struct en
 		tmp[1] = 0xefcdab89;
 		tmp[2] = 0x98badcfe;
 		tmp[3] = 0x10325476;
-#ifdef USE_SHA
 		tmp[4] = 0xc3d2e1f0;
-#endif
+
 		/*
 		 * As we hash the pool, we mix intermediate values of
 		 * the hash back into the pool.  This eliminates
@@ -1380,7 +1244,7 @@ static ssize_t extract_entropy(struct en
 		 * function can be inverted.
 		 */
 		for (i = 0, x = 0; i < r->poolinfo->poolwords; i += 16, x+=2) {
-			HASH_TRANSFORM(tmp, r->pool+i);
+			sha_transform(tmp, r->pool+i);
 			add_entropy_words(r, &tmp[x%HASH_BUFFER_SIZE], 1);
 		}
 		
@@ -2277,7 +2141,7 @@ __u32 secure_tcp_syn_cookie(__u32 saddr,
 	tmp[0]=saddr;
 	tmp[1]=daddr;
 	tmp[2]=(sport << 16) + dport;
-	HASH_TRANSFORM(tmp+16, tmp);
+	sha_transform(tmp+16, tmp);
 	seq = tmp[17] + sseq + (count << COOKIEBITS);
 
 	memcpy(tmp+3, syncookie_secret[1], sizeof(syncookie_secret[1]));
@@ -2285,7 +2149,7 @@ __u32 secure_tcp_syn_cookie(__u32 saddr,
 	tmp[1]=daddr;
 	tmp[2]=(sport << 16) + dport;
 	tmp[3] = count;	/* minute counter */
-	HASH_TRANSFORM(tmp+16, tmp);
+	sha_transform(tmp+16, tmp);
 
 	/* Add in the second hash and the data */
 	return seq + ((tmp[17] + data) & COOKIEMASK);
@@ -2314,7 +2178,7 @@ __u32 check_tcp_syn_cookie(__u32 cookie,
 	tmp[0]=saddr;
 	tmp[1]=daddr;
 	tmp[2]=(sport << 16) + dport;
-	HASH_TRANSFORM(tmp+16, tmp);
+	sha_transform(tmp+16, tmp);
 	cookie -= tmp[17] + sseq;
 	/* Cookie is now reduced to (count * 2^24) ^ (hash % 2^24) */
 
@@ -2327,7 +2191,7 @@ __u32 check_tcp_syn_cookie(__u32 cookie,
 	tmp[1] = daddr;
 	tmp[2] = (sport << 16) + dport;
 	tmp[3] = count - diff;	/* minute counter */
-	HASH_TRANSFORM(tmp+16, tmp);
+	sha_transform(tmp+16, tmp);
 
 	return (cookie - tmp[17]) & COOKIEMASK;	/* Leaving the data behind */
 }

_
