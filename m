Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262072AbVAOAwD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbVAOAwD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 19:52:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbVAOAui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 19:50:38 -0500
Received: from waste.org ([216.27.176.166]:10209 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262073AbVAOAtN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 19:49:13 -0500
Date: Fri, 14 Jan 2005 18:49:08 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9.563253706@selenic.com>
Message-Id: <10.563253706@selenic.com>
Subject: [PATCH 9/10] random pt2: kill redundant rotate_left definitions
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We've got three definitions of rotate_left. Remove x86 and duplicate
rotate definitions. Remaining definition is fixed up such that recent
gcc will generate rol instructions on x86 at least.

A later patch will move this to bitops and clean up the other tree users.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: rnd/drivers/char/random.c
===================================================================
--- rnd.orig/drivers/char/random.c	2005-01-12 21:28:06.993624332 -0800
+++ rnd/drivers/char/random.c	2005-01-12 21:28:07.768525540 -0800
@@ -401,26 +401,10 @@
  * purposes
  *
  *****************************************************************/
-
-/*
- * Unfortunately, while the GCC optimizer for the i386 understands how
- * to optimize a static rotate left of x bits, it doesn't know how to
- * deal with a variable rotate of x bits.  So we use a bit of asm magic.
- */
-#if (!defined (__i386__))
-static inline __u32 rotate_left(int i, __u32 word)
-{
-	return (word << i) | (word >> (32 - i));
-}
-#else
-static inline __u32 rotate_left(int i, __u32 word)
+static inline __u32 rol32(__u32 word, int shift)
 {
-	__asm__("roll %%cl,%0"
-		:"=r" (word)
-		:"0" (word),"c" (i));
-	return word;
+	return (word << shift) | (word >> (32 - shift));
 }
-#endif
 
 /*
  * More asm magic....
@@ -572,7 +556,7 @@
 	add_ptr = r->add_ptr;
 
 	while (nwords--) {
-		w = rotate_left(input_rotate, next_w);
+		w = rol32(input_rotate, next_w);
 		if (nwords > 0)
 			next_w = *in++;
 		i = add_ptr = (add_ptr - 1) & wordmask;
@@ -941,10 +925,8 @@
 #define K3  0x8F1BBCDCL			/* Rounds 40-59: sqrt(5) * 2^30 */
 #define K4  0xCA62C1D6L			/* Rounds 60-79: sqrt(10) * 2^30 */
 
-#define ROTL(n,X)  (((X) << n ) | ((X) >> (32 - n)))
-
 #define subRound(a, b, c, d, e, f, k, data) \
-    (e += ROTL(5, a) + f(b, c, d) + k + data, b = ROTL(30, b))
+    (e += rol32(a, 5) + f(b, c, d) + k + data, b = rol32(b, 30))
 
 static void SHATransform(__u32 digest[85], __u32 const data[16])
 {
@@ -962,7 +944,7 @@
 	memcpy(W, data, 16*sizeof(__u32));
 	for (i = 0; i < 64; i++) {
 		TEMP = W[i] ^ W[i+2] ^ W[i+8] ^ W[i+13];
-		W[i+16] = ROTL(1, TEMP);
+		W[i+16] = rol32(TEMP, 1);
 	}
 
 	/* Set up first buffer and local data buffer */
@@ -990,25 +972,25 @@
 			else
 				TEMP = f4(B, C, D) + K4;
 		}
-		TEMP += ROTL(5, A) + E + W[i];
-		E = D; D = C; C = ROTL(30, B); B = A; A = TEMP;
+		TEMP += rol32(A, 5) + E + W[i];
+		E = D; D = C; C = rol32(B, 30); B = A; A = TEMP;
 	}
 #elif SHA_CODE_SIZE == 1
 	for (i = 0; i < 20; i++) {
-		TEMP = f1(B, C, D) + K1 + ROTL(5, A) + E + W[i];
-		E = D; D = C; C = ROTL(30, B); B = A; A = TEMP;
+		TEMP = f1(B, C, D) + K1 + rol32(A, 5) + E + W[i];
+		E = D; D = C; C = rol32(B, 30); B = A; A = TEMP;
 	}
 	for (; i < 40; i++) {
-		TEMP = f2(B, C, D) + K2 + ROTL(5, A) + E + W[i];
-		E = D; D = C; C = ROTL(30, B); B = A; A = TEMP;
+		TEMP = f2(B, C, D) + K2 + rol32(A, 5) + E + W[i];
+		E = D; D = C; C = rol32(B, 30); B = A; A = TEMP;
 	}
 	for (; i < 60; i++) {
-		TEMP = f3(B, C, D) + K3 + ROTL(5, A) + E + W[i];
-		E = D; D = C; C = ROTL(30, B); B = A; A = TEMP;
+		TEMP = f3(B, C, D) + K3 + rol32(A, 5) + E + W[i];
+		E = D; D = C; C = rol22(B, 30); B = A; A = TEMP;
 	}
 	for (; i < 80; i++) {
-		TEMP = f4(B, C, D) + K4 + ROTL(5, A) + E + W[i];
-		E = D; D = C; C = ROTL(30, B); B = A; A = TEMP;
+		TEMP = f4(B, C, D) + K4 + rol32(A, 5) + E + W[i];
+		E = D; D = C; C = rol32(B, 30); B = A; A = TEMP;
 	}
 #elif SHA_CODE_SIZE == 2
 	for (i = 0; i < 20; i += 5) {
@@ -1138,7 +1120,6 @@
 #undef W
 }
 
-#undef ROTL
 #undef f1
 #undef f2
 #undef f3
