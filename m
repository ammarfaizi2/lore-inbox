Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262528AbVAUV6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262528AbVAUV6a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 16:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbVAUV5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 16:57:16 -0500
Received: from waste.org ([216.27.176.166]:29913 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262532AbVAUVlW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 16:41:22 -0500
Date: Fri, 21 Jan 2005 15:41:07 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6.314297600@selenic.com>
Message-Id: <7.314297600@selenic.com>
Subject: [PATCH 6/12] random pt4: Replace SHA with faster version
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A replacement SHA routine that's slightly larger, but over twice as
fast. It's also faster and much smaller than the cryptolib version.

             size      speed    buffer size
original:    350B      2.3us     320B
cryptolib:  5776B      1.2us      80B
this code:   466B      1.0us     320B
alternate:  2112B      1.0us      80B

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: rnd/lib/sha1.c
===================================================================
--- rnd.orig/lib/sha1.c	2005-01-12 21:27:15.445196197 -0800
+++ rnd/lib/sha1.c	2005-01-12 21:28:24.051449644 -0800
@@ -1,18 +1,16 @@
 /*
- * SHA transform algorithm, taken from code written by Peter Gutmann,
- * and placed in the public domain.
+ * SHA transform algorithm, originally taken from code written by
+ * Peter Gutmann, and placed in the public domain.
  */
 
 #include <linux/kernel.h>
-#include <linux/string.h>
 #include <linux/cryptohash.h>
 
 /* The SHA f()-functions.  */
 
-#define f1(x,y,z)   (z ^ (x & (y ^ z)))		/* Rounds  0-19: x ? y : z */
-#define f2(x,y,z)   (x ^ y ^ z)			/* Rounds 20-39: XOR */
-#define f3(x,y,z)   ((x & y) + (z & (x ^ y)))	/* Rounds 40-59: majority */
-#define f4(x,y,z)   (x ^ y ^ z)			/* Rounds 60-79: XOR */
+#define f1(x,y,z)   (z ^ (x & (y ^ z)))		/* x ? y : z */
+#define f2(x,y,z)   (x ^ y ^ z)			/* XOR */
+#define f3(x,y,z)   ((x & y) + (z & (x ^ y)))	/* majority */
 
 /* The SHA Mysterious Constants */
 
@@ -26,64 +24,53 @@
  *
  * @digest: 160 bit digest to update
  * @data:   512 bits of data to hash
- * @W:      80 words of workspace
+ * @W:      80 words of workspace, caller should clear
  *
  * This function generates a SHA1 digest for a single. Be warned, it
  * does not handle padding and message digest, do not confuse it with
  * the full FIPS 180-1 digest algorithm for variable length messages.
  */
-void sha_transform(__u32 *digest, const char *data, __u32 *W)
+void sha_transform(__u32 *digest, const char *in, __u32 *W)
 {
-	__u32 A, B, C, D, E;
-	__u32 TEMP;
-	int i;
+	__u32 a, b, c, d, e, t, i;
 
-	memset(W, 0, sizeof(W));
 	for (i = 0; i < 16; i++)
-		W[i] = be32_to_cpu(((const __u32 *)data)[i]);
-	/*
-	 * Do the preliminary expansion of 16 to 80 words.  Doing it
-	 * out-of-line line this is faster than doing it in-line on
-	 * register-starved machines like the x86, and not really any
-	 * slower on real processors.
-	 */
-	for (i = 0; i < 64; i++) {
-		TEMP = W[i] ^ W[i+2] ^ W[i+8] ^ W[i+13];
-		W[i+16] = rol32(TEMP, 1);
+		W[i] = be32_to_cpu(((const __u32 *)in)[i]);
+
+	for (i = 0; i < 64; i++)
+		W[i+16] = rol32(W[i+13] ^ W[i+8] ^ W[i+2] ^ W[i], 1);
+
+	a = digest[0];
+	b = digest[1];
+	c = digest[2];
+	d = digest[3];
+	e = digest[4];
+
+	for (i = 0; i < 20; i++) {
+		t = f1(b, c, d) + K1 + rol32(a, 5) + e + W[i];
+		e = d; d = c; c = rol32(b, 30); b = a; a = t;
 	}
 
-	/* Set up first buffer and local data buffer */
-	A = digest[ 0 ];
-	B = digest[ 1 ];
-	C = digest[ 2 ];
-	D = digest[ 3 ];
-	E = digest[ 4 ];
-
-	/* Heavy mangling, in 4 sub-rounds of 20 iterations each. */
-	for (i = 0; i < 80; i++) {
-		if (i < 40) {
-			if (i < 20)
-				TEMP = f1(B, C, D) + K1;
-			else
-				TEMP = f2(B, C, D) + K2;
-		} else {
-			if (i < 60)
-				TEMP = f3(B, C, D) + K3;
-			else
-				TEMP = f4(B, C, D) + K4;
-		}
-		TEMP += rol32(A, 5) + E + W[i];
-		E = D; D = C; C = rol32(B, 30); B = A; A = TEMP;
+	for (; i < 40; i ++) {
+		t = f2(b, c, d) + K2 + rol32(a, 5) + e + W[i];
+		e = d; d = c; c = rol32(b, 30); b = a; a = t;
 	}
 
-	/* Build message digest */
-	digest[0] += A;
-	digest[1] += B;
-	digest[2] += C;
-	digest[3] += D;
-	digest[4] += E;
+	for (; i < 60; i ++) {
+		t = f3(b, c, d) + K3 + rol32(a, 5) + e + W[i];
+		e = d; d = c; c = rol32(b, 30); b = a; a = t;
+	}
+
+	for (; i < 80; i ++) {
+		t = f2(b, c, d) + K4 + rol32(a, 5) + e + W[i];
+		e = d; d = c; c = rol32(b, 30); b = a; a = t;
+	}
 
-	/* W is wiped by the caller */
+	digest[0] += a;
+	digest[1] += b;
+	digest[2] += c;
+	digest[3] += d;
+	digest[4] += e;
 }
 
 /*
