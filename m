Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272273AbTHIH0H (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 03:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272274AbTHIH0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 03:26:06 -0400
Received: from waste.org ([209.173.204.2]:34477 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S272273AbTHIHZo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 03:25:44 -0400
Date: Sat, 9 Aug 2003 02:25:41 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] random: remove legacy
Message-ID: <20030809072541.GP31810@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes a bunch of dead code

- long unused md5 implementation
- 3 unused implementations of SHA1 inner loop
- kill 2.2 waitqueue compatibility
- misnamed implementation of log2 -> fls

diff -urN -X dontdiff orig/drivers/char/random.c work/drivers/char/random.c
--- orig/drivers/char/random.c	2003-08-07 22:36:24.000000000 -0500
+++ work/drivers/char/random.c	2003-08-08 00:24:01.000000000 -0500
@@ -227,10 +227,6 @@
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
@@ -265,7 +261,6 @@
 #define INPUT_POOL_SIZE 512
 #define BLOCKING_POOL_SIZE 128
 #define BATCH_ENTROPY_SIZE 256
-#define USE_SHA
 
 /*
  * The minimum number of bits of entropy before we wake up a read on
@@ -373,16 +368,6 @@
  */
 
 /*
- * Linux 2.2 compatibility
- */
-#ifndef DECLARE_WAITQUEUE
-#define DECLARE_WAITQUEUE(WAIT, PTR)	struct wait_queue WAIT = { PTR, NULL }
-#endif
-#ifndef DECLARE_WAIT_QUEUE_HEAD
-#define DECLARE_WAIT_QUEUE_HEAD(WAIT) struct wait_queue *WAIT
-#endif
-
-/*
  * Static global variables
  */
 static struct entropy_store *input_pool, *blocking_pool, *nonblocking_pool;
@@ -422,43 +407,6 @@
 }
 #endif
 
-/*
- * More asm magic....
- * 
- * For entropy estimation, we need to do an integral base 2
- * logarithm.  
- *
- * Note the "12bits" suffix - this is used for numbers between
- * 0 and 4095 only.  This allows a few shortcuts.
- */
-#if 0	/* Slow but clear version */
-static inline __u32 int_ln_12bits(__u32 word)
-{
-	__u32 nbits = 0;
-	
-	while (word >>= 1)
-		nbits++;
-	return nbits;
-}
-#else	/* Faster (more clever) version, courtesy Colin Plumb */
-static inline __u32 int_ln_12bits(__u32 word)
-{
-	/* Smear msbit right to make an n-bit mask */
-	word |= word >> 8;
-	word |= word >> 4;
-	word |= word >> 2;
-	word |= word >> 1;
-	/* Remove one bit to make this a logarithm */
-	word >>= 1;
-	/* Count the bits set in the word */
-	word -= (word >> 1) & 0x555;
-	word = (word & 0x333) + ((word >> 2) & 0x333);
-	word += (word >> 4);
-	word += (word >> 8);
-	return word & 15;
-}
-#endif
-
 #if 0
 #define DEBUG_ENT(fmt, arg...) printk(KERN_DEBUG "random: %04d %04d %04d: " fmt,\
   input_pool->entropy_count, blocking_pool->entropy_count,\
@@ -788,10 +736,7 @@
 		 * Round down by 1 bit on general principles,
 		 * and limit entropy entimate to 12 bits.
 		 */
-		delta >>= 1;
-		delta &= (1 << 12) - 1;
-
-		entropy = int_ln_12bits(delta);
+		entropy = min_t(int, fls(delta>>1), 11);
 	}
 	batch_entropy_store(num, time, entropy);
 }
@@ -835,7 +780,7 @@
 
 /*
  * This chunk of code defines a function
- * void HASH_TRANSFORM(__u32 digest[HASH_BUFFER_SIZE + HASH_EXTRA_SIZE],
+ * void SHATransform(__u32 digest[HASH_BUFFER_SIZE + HASH_EXTRA_SIZE],
  * 		__u32 const data[16])
  * 
  * The function hashes the input data to produce a digest in the first
@@ -845,27 +790,13 @@
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
-
-/* Various size/speed tradeoffs are available.  Choose 0..3. */
-#define SHA_CODE_SIZE 0
 
 /*
  * SHA transform algorithm, taken from code written by Peter Gutmann,
@@ -901,7 +832,7 @@
 
     /*
      * Do the preliminary expansion of 16 to 80 words.  Doing it
-     * out-of-line line this is faster than doing it in-line on
+     * out-of-line line like this is faster than doing it in-line on
      * register-starved machines like the x86, and not really any
      * slower on real processors.
      */
@@ -919,11 +850,6 @@
     E = digest[ 4 ];
 
     /* Heavy mangling, in 4 sub-rounds of 20 iterations each. */
-#if SHA_CODE_SIZE == 0
-    /*
-     * Approximately 50% of the speed of the largest version, but
-     * takes up 1/16 the space.  Saves about 6k on an i386 kernel.
-     */
     for (i = 0; i < 80; i++) {
 	if (i < 40) {
 	    if (i < 20)
@@ -939,139 +865,6 @@
 	TEMP += ROTL(5, A) + E + W[i];
 	E = D; D = C; C = ROTL(30, B); B = A; A = TEMP;
     }
-#elif SHA_CODE_SIZE == 1
-    for (i = 0; i < 20; i++) {
-	TEMP = f1(B, C, D) + K1 + ROTL(5, A) + E + W[i];
-	E = D; D = C; C = ROTL(30, B); B = A; A = TEMP;
-    }
-    for (; i < 40; i++) {
-	TEMP = f2(B, C, D) + K2 + ROTL(5, A) + E + W[i];
-	E = D; D = C; C = ROTL(30, B); B = A; A = TEMP;
-    }
-    for (; i < 60; i++) {
-	TEMP = f3(B, C, D) + K3 + ROTL(5, A) + E + W[i];
-	E = D; D = C; C = ROTL(30, B); B = A; A = TEMP;
-    }
-    for (; i < 80; i++) {
-	TEMP = f4(B, C, D) + K4 + ROTL(5, A) + E + W[i];
-	E = D; D = C; C = ROTL(30, B); B = A; A = TEMP;
-    }
-#elif SHA_CODE_SIZE == 2
-    for (i = 0; i < 20; i += 5) {
-	subRound( A, B, C, D, E, f1, K1, W[ i   ] );
-	subRound( E, A, B, C, D, f1, K1, W[ i+1 ] );
-	subRound( D, E, A, B, C, f1, K1, W[ i+2 ] );
-	subRound( C, D, E, A, B, f1, K1, W[ i+3 ] );
-	subRound( B, C, D, E, A, f1, K1, W[ i+4 ] );
-    }
-    for (; i < 40; i += 5) {
-	subRound( A, B, C, D, E, f2, K2, W[ i   ] );
-	subRound( E, A, B, C, D, f2, K2, W[ i+1 ] );
-	subRound( D, E, A, B, C, f2, K2, W[ i+2 ] );
-	subRound( C, D, E, A, B, f2, K2, W[ i+3 ] );
-	subRound( B, C, D, E, A, f2, K2, W[ i+4 ] );
-    }
-    for (; i < 60; i += 5) {
-	subRound( A, B, C, D, E, f3, K3, W[ i   ] );
-	subRound( E, A, B, C, D, f3, K3, W[ i+1 ] );
-	subRound( D, E, A, B, C, f3, K3, W[ i+2 ] );
-	subRound( C, D, E, A, B, f3, K3, W[ i+3 ] );
-	subRound( B, C, D, E, A, f3, K3, W[ i+4 ] );
-    }
-    for (; i < 80; i += 5) {
-	subRound( A, B, C, D, E, f4, K4, W[ i   ] );
-	subRound( E, A, B, C, D, f4, K4, W[ i+1 ] );
-	subRound( D, E, A, B, C, f4, K4, W[ i+2 ] );
-	subRound( C, D, E, A, B, f4, K4, W[ i+3 ] );
-	subRound( B, C, D, E, A, f4, K4, W[ i+4 ] );
-    }
-#elif SHA_CODE_SIZE == 3 /* Really large version */
-    subRound( A, B, C, D, E, f1, K1, W[  0 ] );
-    subRound( E, A, B, C, D, f1, K1, W[  1 ] );
-    subRound( D, E, A, B, C, f1, K1, W[  2 ] );
-    subRound( C, D, E, A, B, f1, K1, W[  3 ] );
-    subRound( B, C, D, E, A, f1, K1, W[  4 ] );
-    subRound( A, B, C, D, E, f1, K1, W[  5 ] );
-    subRound( E, A, B, C, D, f1, K1, W[  6 ] );
-    subRound( D, E, A, B, C, f1, K1, W[  7 ] );
-    subRound( C, D, E, A, B, f1, K1, W[  8 ] );
-    subRound( B, C, D, E, A, f1, K1, W[  9 ] );
-    subRound( A, B, C, D, E, f1, K1, W[ 10 ] );
-    subRound( E, A, B, C, D, f1, K1, W[ 11 ] );
-    subRound( D, E, A, B, C, f1, K1, W[ 12 ] );
-    subRound( C, D, E, A, B, f1, K1, W[ 13 ] );
-    subRound( B, C, D, E, A, f1, K1, W[ 14 ] );
-    subRound( A, B, C, D, E, f1, K1, W[ 15 ] );
-    subRound( E, A, B, C, D, f1, K1, W[ 16 ] );
-    subRound( D, E, A, B, C, f1, K1, W[ 17 ] );
-    subRound( C, D, E, A, B, f1, K1, W[ 18 ] );
-    subRound( B, C, D, E, A, f1, K1, W[ 19 ] );
-
-    subRound( A, B, C, D, E, f2, K2, W[ 20 ] );
-    subRound( E, A, B, C, D, f2, K2, W[ 21 ] );
-    subRound( D, E, A, B, C, f2, K2, W[ 22 ] );
-    subRound( C, D, E, A, B, f2, K2, W[ 23 ] );
-    subRound( B, C, D, E, A, f2, K2, W[ 24 ] );
-    subRound( A, B, C, D, E, f2, K2, W[ 25 ] );
-    subRound( E, A, B, C, D, f2, K2, W[ 26 ] );
-    subRound( D, E, A, B, C, f2, K2, W[ 27 ] );
-    subRound( C, D, E, A, B, f2, K2, W[ 28 ] );
-    subRound( B, C, D, E, A, f2, K2, W[ 29 ] );
-    subRound( A, B, C, D, E, f2, K2, W[ 30 ] );
-    subRound( E, A, B, C, D, f2, K2, W[ 31 ] );
-    subRound( D, E, A, B, C, f2, K2, W[ 32 ] );
-    subRound( C, D, E, A, B, f2, K2, W[ 33 ] );
-    subRound( B, C, D, E, A, f2, K2, W[ 34 ] );
-    subRound( A, B, C, D, E, f2, K2, W[ 35 ] );
-    subRound( E, A, B, C, D, f2, K2, W[ 36 ] );
-    subRound( D, E, A, B, C, f2, K2, W[ 37 ] );
-    subRound( C, D, E, A, B, f2, K2, W[ 38 ] );
-    subRound( B, C, D, E, A, f2, K2, W[ 39 ] );
-    
-    subRound( A, B, C, D, E, f3, K3, W[ 40 ] );
-    subRound( E, A, B, C, D, f3, K3, W[ 41 ] );
-    subRound( D, E, A, B, C, f3, K3, W[ 42 ] );
-    subRound( C, D, E, A, B, f3, K3, W[ 43 ] );
-    subRound( B, C, D, E, A, f3, K3, W[ 44 ] );
-    subRound( A, B, C, D, E, f3, K3, W[ 45 ] );
-    subRound( E, A, B, C, D, f3, K3, W[ 46 ] );
-    subRound( D, E, A, B, C, f3, K3, W[ 47 ] );
-    subRound( C, D, E, A, B, f3, K3, W[ 48 ] );
-    subRound( B, C, D, E, A, f3, K3, W[ 49 ] );
-    subRound( A, B, C, D, E, f3, K3, W[ 50 ] );
-    subRound( E, A, B, C, D, f3, K3, W[ 51 ] );
-    subRound( D, E, A, B, C, f3, K3, W[ 52 ] );
-    subRound( C, D, E, A, B, f3, K3, W[ 53 ] );
-    subRound( B, C, D, E, A, f3, K3, W[ 54 ] );
-    subRound( A, B, C, D, E, f3, K3, W[ 55 ] );
-    subRound( E, A, B, C, D, f3, K3, W[ 56 ] );
-    subRound( D, E, A, B, C, f3, K3, W[ 57 ] );
-    subRound( C, D, E, A, B, f3, K3, W[ 58 ] );
-    subRound( B, C, D, E, A, f3, K3, W[ 59 ] );
-
-    subRound( A, B, C, D, E, f4, K4, W[ 60 ] );
-    subRound( E, A, B, C, D, f4, K4, W[ 61 ] );
-    subRound( D, E, A, B, C, f4, K4, W[ 62 ] );
-    subRound( C, D, E, A, B, f4, K4, W[ 63 ] );
-    subRound( B, C, D, E, A, f4, K4, W[ 64 ] );
-    subRound( A, B, C, D, E, f4, K4, W[ 65 ] );
-    subRound( E, A, B, C, D, f4, K4, W[ 66 ] );
-    subRound( D, E, A, B, C, f4, K4, W[ 67 ] );
-    subRound( C, D, E, A, B, f4, K4, W[ 68 ] );
-    subRound( B, C, D, E, A, f4, K4, W[ 69 ] );
-    subRound( A, B, C, D, E, f4, K4, W[ 70 ] );
-    subRound( E, A, B, C, D, f4, K4, W[ 71 ] );
-    subRound( D, E, A, B, C, f4, K4, W[ 72 ] );
-    subRound( C, D, E, A, B, f4, K4, W[ 73 ] );
-    subRound( B, C, D, E, A, f4, K4, W[ 74 ] );
-    subRound( A, B, C, D, E, f4, K4, W[ 75 ] );
-    subRound( E, A, B, C, D, f4, K4, W[ 76 ] );
-    subRound( D, E, A, B, C, f4, K4, W[ 77 ] );
-    subRound( C, D, E, A, B, f4, K4, W[ 78 ] );
-    subRound( B, C, D, E, A, f4, K4, W[ 79 ] );
-#else
-#error Illegal SHA_CODE_SIZE
-#endif
 
     /* Build message digest */
     digest[ 0 ] += A;
@@ -1094,125 +887,6 @@
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
@@ -1324,9 +998,8 @@
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
@@ -1336,7 +1009,7 @@
 		 * function can be inverted.
 		 */
 		for (i = 0, x = 0; i < r->poolinfo->poolwords; i += 16, x+=2) {
-			HASH_TRANSFORM(tmp, r->pool+i);
+			SHATransform(tmp, r->pool+i);
 			add_entropy_words(r, &tmp[x%HASH_BUFFER_SIZE], 1);
 		}
 		
@@ -2204,7 +1877,7 @@
 	tmp[0]=saddr;
 	tmp[1]=daddr;
 	tmp[2]=(sport << 16) + dport;
-	HASH_TRANSFORM(tmp+16, tmp);
+	SHATransform(tmp+16, tmp);
 	seq = tmp[17] + sseq + (count << COOKIEBITS);
 
 	memcpy(tmp+3, syncookie_secret[1], sizeof(syncookie_secret[1]));
@@ -2212,7 +1885,7 @@
 	tmp[1]=daddr;
 	tmp[2]=(sport << 16) + dport;
 	tmp[3] = count;	/* minute counter */
-	HASH_TRANSFORM(tmp+16, tmp);
+	SHATransform(tmp+16, tmp);
 
 	/* Add in the second hash and the data */
 	return seq + ((tmp[17] + data) & COOKIEMASK);
@@ -2241,7 +1914,7 @@
 	tmp[0]=saddr;
 	tmp[1]=daddr;
 	tmp[2]=(sport << 16) + dport;
-	HASH_TRANSFORM(tmp+16, tmp);
+	SHATransform(tmp+16, tmp);
 	cookie -= tmp[17] + sseq;
 	/* Cookie is now reduced to (count * 2^24) ^ (hash % 2^24) */
 
@@ -2254,7 +1927,7 @@
 	tmp[1] = daddr;
 	tmp[2] = (sport << 16) + dport;
 	tmp[3] = count - diff;	/* minute counter */
-	HASH_TRANSFORM(tmp+16, tmp);
+	SHATransform(tmp+16, tmp);
 
 	return (cookie - tmp[17]) & COOKIEMASK;	/* Leaving the data behind */
 }


-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
