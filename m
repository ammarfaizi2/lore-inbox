Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262523AbVAUVxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262523AbVAUVxK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 16:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262550AbVAUVvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 16:51:04 -0500
Received: from waste.org ([216.27.176.166]:27097 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262528AbVAUVlT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 16:41:19 -0500
Date: Fri, 21 Jan 2005 15:41:06 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3.314297600@selenic.com>
Message-Id: <4.314297600@selenic.com>
Subject: [PATCH 3/12] random pt4: Kill the SHA variants
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kill the unrolled SHA variants, they're unused and duplicate code in
cryptoapi.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: rnd2/drivers/char/random.c
===================================================================
--- rnd2.orig/drivers/char/random.c	2005-01-20 12:22:16.709058715 -0800
+++ rnd2/drivers/char/random.c	2005-01-20 12:28:27.979725732 -0800
@@ -698,9 +698,6 @@
 #define EXTRACT_SIZE 10
 #define HASH_EXTRA_SIZE 80
 
-/* Various size/speed tradeoffs are available.  Choose 0..3. */
-#define SHA_CODE_SIZE 0
-
 /*
  * SHA transform algorithm, taken from code written by Peter Gutmann,
  * and placed in the public domain.
@@ -720,9 +717,6 @@
 #define K3  0x8F1BBCDCL			/* Rounds 40-59: sqrt(5) * 2^30 */
 #define K4  0xCA62C1D6L			/* Rounds 60-79: sqrt(10) * 2^30 */
 
-#define subRound(a, b, c, d, e, f, k, data) \
-    (e += rol32(a, 5) + f(b, c, d) + k + data, b = rol32(b, 30))
-
 static void sha_transform(__u32 digest[85], __u32 const data[16])
 {
 	__u32 A, B, C, D, E;     /* Local vars */
@@ -750,11 +744,6 @@
 	E = digest[ 4 ];
 
 	/* Heavy mangling, in 4 sub-rounds of 20 iterations each. */
-#if SHA_CODE_SIZE == 0
-	/*
-	 * Approximately 50% of the speed of the largest version, but
-	 * takes up 1/16 the space.  Saves about 6k on an i386 kernel.
-	 */
 	for (i = 0; i < 80; i++) {
 		if (i < 40) {
 			if (i < 20)
@@ -770,139 +759,6 @@
 		TEMP += rol32(A, 5) + E + W[i];
 		E = D; D = C; C = rol32(B, 30); B = A; A = TEMP;
 	}
-#elif SHA_CODE_SIZE == 1
-	for (i = 0; i < 20; i++) {
-		TEMP = f1(B, C, D) + K1 + rol32(A, 5) + E + W[i];
-		E = D; D = C; C = rol32(B, 30); B = A; A = TEMP;
-	}
-	for (; i < 40; i++) {
-		TEMP = f2(B, C, D) + K2 + rol32(A, 5) + E + W[i];
-		E = D; D = C; C = rol32(B, 30); B = A; A = TEMP;
-	}
-	for (; i < 60; i++) {
-		TEMP = f3(B, C, D) + K3 + rol32(A, 5) + E + W[i];
-		E = D; D = C; C = rol22(B, 30); B = A; A = TEMP;
-	}
-	for (; i < 80; i++) {
-		TEMP = f4(B, C, D) + K4 + rol32(A, 5) + E + W[i];
-		E = D; D = C; C = rol32(B, 30); B = A; A = TEMP;
-	}
-#elif SHA_CODE_SIZE == 2
-	for (i = 0; i < 20; i += 5) {
-		subRound(A, B, C, D, E, f1, K1, W[i  ]);
-		subRound(E, A, B, C, D, f1, K1, W[i+1]);
-		subRound(D, E, A, B, C, f1, K1, W[i+2]);
-		subRound(C, D, E, A, B, f1, K1, W[i+3]);
-		subRound(B, C, D, E, A, f1, K1, W[i+4]);
-	}
-	for (; i < 40; i += 5) {
-		subRound(A, B, C, D, E, f2, K2, W[i  ]);
-		subRound(E, A, B, C, D, f2, K2, W[i+1]);
-		subRound(D, E, A, B, C, f2, K2, W[i+2]);
-		subRound(C, D, E, A, B, f2, K2, W[i+3]);
-		subRound(B, C, D, E, A, f2, K2, W[i+4]);
-	}
-	for (; i < 60; i += 5) {
-		subRound(A, B, C, D, E, f3, K3, W[i  ]);
-		subRound(E, A, B, C, D, f3, K3, W[i+1]);
-		subRound(D, E, A, B, C, f3, K3, W[i+2]);
-		subRound(C, D, E, A, B, f3, K3, W[i+3]);
-		subRound(B, C, D, E, A, f3, K3, W[i+4]);
-	}
-	for (; i < 80; i += 5) {
-		subRound(A, B, C, D, E, f4, K4, W[i  ]);
-		subRound(E, A, B, C, D, f4, K4, W[i+1]);
-		subRound(D, E, A, B, C, f4, K4, W[i+2]);
-		subRound(C, D, E, A, B, f4, K4, W[i+3]);
-		subRound(B, C, D, E, A, f4, K4, W[i+4]);
-	}
-#elif SHA_CODE_SIZE == 3 /* Really large version */
-	subRound(A, B, C, D, E, f1, K1, W[ 0]);
-	subRound(E, A, B, C, D, f1, K1, W[ 1]);
-	subRound(D, E, A, B, C, f1, K1, W[ 2]);
-	subRound(C, D, E, A, B, f1, K1, W[ 3]);
-	subRound(B, C, D, E, A, f1, K1, W[ 4]);
-	subRound(A, B, C, D, E, f1, K1, W[ 5]);
-	subRound(E, A, B, C, D, f1, K1, W[ 6]);
-	subRound(D, E, A, B, C, f1, K1, W[ 7]);
-	subRound(C, D, E, A, B, f1, K1, W[ 8]);
-	subRound(B, C, D, E, A, f1, K1, W[ 9]);
-	subRound(A, B, C, D, E, f1, K1, W[10]);
-	subRound(E, A, B, C, D, f1, K1, W[11]);
-	subRound(D, E, A, B, C, f1, K1, W[12]);
-	subRound(C, D, E, A, B, f1, K1, W[13]);
-	subRound(B, C, D, E, A, f1, K1, W[14]);
-	subRound(A, B, C, D, E, f1, K1, W[15]);
-	subRound(E, A, B, C, D, f1, K1, W[16]);
-	subRound(D, E, A, B, C, f1, K1, W[17]);
-	subRound(C, D, E, A, B, f1, K1, W[18]);
-	subRound(B, C, D, E, A, f1, K1, W[19]);
-
-	subRound(A, B, C, D, E, f2, K2, W[20]);
-	subRound(E, A, B, C, D, f2, K2, W[21]);
-	subRound(D, E, A, B, C, f2, K2, W[22]);
-	subRound(C, D, E, A, B, f2, K2, W[23]);
-	subRound(B, C, D, E, A, f2, K2, W[24]);
-	subRound(A, B, C, D, E, f2, K2, W[25]);
-	subRound(E, A, B, C, D, f2, K2, W[26]);
-	subRound(D, E, A, B, C, f2, K2, W[27]);
-	subRound(C, D, E, A, B, f2, K2, W[28]);
-	subRound(B, C, D, E, A, f2, K2, W[29]);
-	subRound(A, B, C, D, E, f2, K2, W[30]);
-	subRound(E, A, B, C, D, f2, K2, W[31]);
-	subRound(D, E, A, B, C, f2, K2, W[32]);
-	subRound(C, D, E, A, B, f2, K2, W[33]);
-	subRound(B, C, D, E, A, f2, K2, W[34]);
-	subRound(A, B, C, D, E, f2, K2, W[35]);
-	subRound(E, A, B, C, D, f2, K2, W[36]);
-	subRound(D, E, A, B, C, f2, K2, W[37]);
-	subRound(C, D, E, A, B, f2, K2, W[38]);
-	subRound(B, C, D, E, A, f2, K2, W[39]);
-
-	subRound(A, B, C, D, E, f3, K3, W[40]);
-	subRound(E, A, B, C, D, f3, K3, W[41]);
-	subRound(D, E, A, B, C, f3, K3, W[42]);
-	subRound(C, D, E, A, B, f3, K3, W[43]);
-	subRound(B, C, D, E, A, f3, K3, W[44]);
-	subRound(A, B, C, D, E, f3, K3, W[45]);
-	subRound(E, A, B, C, D, f3, K3, W[46]);
-	subRound(D, E, A, B, C, f3, K3, W[47]);
-	subRound(C, D, E, A, B, f3, K3, W[48]);
-	subRound(B, C, D, E, A, f3, K3, W[49]);
-	subRound(A, B, C, D, E, f3, K3, W[50]);
-	subRound(E, A, B, C, D, f3, K3, W[51]);
-	subRound(D, E, A, B, C, f3, K3, W[52]);
-	subRound(C, D, E, A, B, f3, K3, W[53]);
-	subRound(B, C, D, E, A, f3, K3, W[54]);
-	subRound(A, B, C, D, E, f3, K3, W[55]);
-	subRound(E, A, B, C, D, f3, K3, W[56]);
-	subRound(D, E, A, B, C, f3, K3, W[57]);
-	subRound(C, D, E, A, B, f3, K3, W[58]);
-	subRound(B, C, D, E, A, f3, K3, W[59]);
-
-	subRound(A, B, C, D, E, f4, K4, W[60]);
-	subRound(E, A, B, C, D, f4, K4, W[61]);
-	subRound(D, E, A, B, C, f4, K4, W[62]);
-	subRound(C, D, E, A, B, f4, K4, W[63]);
-	subRound(B, C, D, E, A, f4, K4, W[64]);
-	subRound(A, B, C, D, E, f4, K4, W[65]);
-	subRound(E, A, B, C, D, f4, K4, W[66]);
-	subRound(D, E, A, B, C, f4, K4, W[67]);
-	subRound(C, D, E, A, B, f4, K4, W[68]);
-	subRound(B, C, D, E, A, f4, K4, W[69]);
-	subRound(A, B, C, D, E, f4, K4, W[70]);
-	subRound(E, A, B, C, D, f4, K4, W[71]);
-	subRound(D, E, A, B, C, f4, K4, W[72]);
-	subRound(C, D, E, A, B, f4, K4, W[73]);
-	subRound(B, C, D, E, A, f4, K4, W[74]);
-	subRound(A, B, C, D, E, f4, K4, W[75]);
-	subRound(E, A, B, C, D, f4, K4, W[76]);
-	subRound(D, E, A, B, C, f4, K4, W[77]);
-	subRound(C, D, E, A, B, f4, K4, W[78]);
-	subRound(B, C, D, E, A, f4, K4, W[79]);
-#else
-#error Illegal SHA_CODE_SIZE
-#endif
 
 	/* Build message digest */
 	digest[0] += A;
@@ -923,7 +779,6 @@
 #undef K2
 #undef K3
 #undef K4
-#undef subRound
 
 /*********************************************************************
  *
