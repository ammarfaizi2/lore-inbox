Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272046AbTHMXm5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 19:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272048AbTHMXm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 19:42:57 -0400
Received: from waste.org ([209.173.204.2]:35275 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S272046AbTHMXmx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 19:42:53 -0400
Date: Wed, 13 Aug 2003 18:42:45 -0500
From: Matt Mackall <mpm@selenic.com>
To: James Morris <jmorris@intercode.com.au>,
       "David S. Miller" <davem@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] cryptoapi: "rolled" SHA1
Message-ID: <20030813234245.GF325@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A "rolled" version of SHA1 similar to that in /dev/random. About 1/4th
the size of the unrolled versions and 2/3 the speed (after factoring
out cryptoapi overhead). This also simplifies some of the magic hash
function macros.

diff -urN -X dontdiff orig/crypto/sha1.c work/crypto/sha1.c
--- orig/crypto/sha1.c	2003-07-13 22:32:29.000000000 -0500
+++ work/crypto/sha1.c	2003-08-12 18:51:49.000000000 -0500
@@ -32,6 +32,18 @@
 	return (((value) << (bits)) | ((value) >> (32 - (bits))));
 }
 
+/* The SHA Mysterious Constants */
+
+#define K1  0x5A827999L			/* Rounds  0-19: sqrt(2) * 2^30 */
+#define K2  0x6ED9EBA1L			/* Rounds 20-39: sqrt(3) * 2^30 */
+#define K3  0x8F1BBCDCL			/* Rounds 40-59: sqrt(5) * 2^30 */
+#define K4  0xCA62C1D6L			/* Rounds 60-79: sqrt(10) * 2^30 */
+
+#define f1(x,y,z)   ( z ^ (x & (y^z)) )		/* Rounds  0-19: x ? y : z */
+#define f2(x,y,z)   (x ^ y ^ z)			/* Rounds 20-39: XOR */
+#define f3(x,y,z)   ( (x & y) + (z & (x ^ y)) )	/* Rounds 40-59: majority */
+#define f4(x,y,z)   (x ^ y ^ z)			/* Rounds 60-79: XOR */
+
 /* blk0() and blk() perform the initial expand. */
 /* I got the idea of expanding during the round function from SSLeay */
 # define blk0(i) block32[i]
@@ -40,14 +52,11 @@
     ^block32[(i+2)&15]^block32[i&15],1))
 
 /* (R0+R1), R2, R3, R4 are the different operations used in SHA1 */
-#define R0(v,w,x,y,z,i) z+=((w&(x^y))^y)+blk0(i)+0x5A827999+rol(v,5); \
-                        w=rol(w,30);
-#define R1(v,w,x,y,z,i) z+=((w&(x^y))^y)+blk(i)+0x5A827999+rol(v,5); \
-                        w=rol(w,30);
-#define R2(v,w,x,y,z,i) z+=(w^x^y)+blk(i)+0x6ED9EBA1+rol(v,5);w=rol(w,30);
-#define R3(v,w,x,y,z,i) z+=(((w|x)&y)|(w&x))+blk(i)+0x8F1BBCDC+rol(v,5); \
-                        w=rol(w,30);
-#define R4(v,w,x,y,z,i) z+=(w^x^y)+blk(i)+0xCA62C1D6+rol(v,5);w=rol(w,30);
+#define R0(v,w,x,y,z,i) z+=f1(w,x,y)+blk0(i)+K1+rol(v,5); w=rol(w,30);
+#define R1(v,w,x,y,z,i) z+=f1(w,x,y) +blk(i)+K1+rol(v,5); w=rol(w,30);
+#define R2(v,w,x,y,z,i) z+=f2(w,x,y) +blk(i)+K2+rol(v,5); w=rol(w,30);
+#define R3(v,w,x,y,z,i) z+=f3(w,x,y) +blk(i)+K3+rol(v,5); w=rol(w,30);
+#define R4(v,w,x,y,z,i) z+=f4(w,x,y) +blk(i)+K4+rol(v,5); w=rol(w,30);
 
 struct sha1_ctx {
         u64 count;
@@ -55,6 +64,61 @@
         u8 buffer[64];
 };
 
+#if 1
+/* Hash a single 512-bit block. This is the core of the algorithm. */
+static void sha1_transform(u32 *state, const u8 *in)
+{
+	u32 a, b, c, d, e, i, t;
+	u32 buf[80];
+
+	/* convert/copy data to workspace */
+	for (a = 0; a < 16; a++)
+	  buf[a] = be32_to_cpu (((const u32 *)in)[a]);
+
+	/* preliminary expansion of 16 to 80 words */
+
+	for (i = 0; i < 64; i++) {
+		a = buf[i] ^ buf[i+2] ^ buf[i+8] ^ buf[i+13];
+		buf[i+16] = rol(a, 1);
+	}
+
+	/* Set up first buffer and local data buffer */
+	a = state[0];
+	b = state[1];
+	c = state[2];
+	d = state[3];
+	e = state[4];
+
+	/* Heavy mangling, in 4 sub-rounds of 20 iterations each. */
+
+	for (i = 0; i < 80; i++) {
+		if (i < 40) {
+			if (i < 20)
+				t = f1(b, c, d) + K1;
+			else
+				t = f2(b, c, d) + K2;
+		} else {
+			if (i < 60)
+				t = f3(b, c, d) + K3;
+			else
+				t = f4(b, c, d) + K4;
+		}
+		t += rol(a, 5) + e + buf[i];
+		e = d; d = c; c = rol(b, 30); b = a; a = t;
+	}
+
+	/* Add the working vars back into context.state[] */
+	state[0] += a;
+	state[1] += b;
+	state[2] += c;
+	state[3] += d;
+	state[4] += e;
+
+	/* Wipe variables */
+	a = b = c = d = e = 0;
+	memset (buf, 0x00, sizeof buf);
+}
+#else
 /* Hash a single 512-bit block. This is the core of the algorithm. */
 static void sha1_transform(u32 *state, const u8 *in)
 {
@@ -103,6 +167,7 @@
 	a = b = c = d = e = 0;
 	memset (block32, 0x00, sizeof block32);
 }
+#endif
 
 static void sha1_init(void *ctx)
 {

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
