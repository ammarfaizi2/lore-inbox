Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262526AbVAUVxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262526AbVAUVxJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 16:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262523AbVAUVvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 16:51:53 -0500
Received: from waste.org ([216.27.176.166]:27609 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262529AbVAUVlT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 16:41:19 -0500
Date: Fri, 21 Jan 2005 15:41:07 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <7.314297600@selenic.com>
Message-Id: <8.314297600@selenic.com>
Subject: [PATCH 7/12] random pt4: Update cryptolib to use SHA fro lib
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the cryptolib SHA implementation and use the faster and much
smaller SHA implementation from lib/. Saves about 5K. This also saves
time by doing one memset per update call rather than one per SHA
block.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: rnd2/crypto/sha1.c
===================================================================
--- rnd2.orig/crypto/sha1.c	2005-01-20 12:24:48.135753454 -0800
+++ rnd2/crypto/sha1.c	2005-01-20 12:30:22.143171131 -0800
@@ -4,8 +4,7 @@
  * SHA1 Secure Hash Algorithm.
  *
  * Derived from cryptoapi implementation, adapted for in-place
- * scatterlist interface.  Originally based on the public domain
- * implementation written by Steve Reid.
+ * scatterlist interface.
  *
  * Copyright (c) Alan Smithee.
  * Copyright (c) Andrew McDonald <andrew@mcdonald.org.uk>
@@ -13,7 +12,7 @@
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or (at your option) 
+ * Software Foundation; either version 2 of the License, or (at your option)
  * any later version.
  *
  */
@@ -21,84 +20,19 @@
 #include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/crypto.h>
+#include <linux/cryptohash.h>
 #include <asm/scatterlist.h>
 #include <asm/byteorder.h>
 
 #define SHA1_DIGEST_SIZE	20
 #define SHA1_HMAC_BLOCK_SIZE	64
 
-/* blk0() and blk() perform the initial expand. */
-/* I got the idea of expanding during the round function from SSLeay */
-# define blk0(i) block32[i]
-
-#define blk(i) (block32[i&15] = rol32(block32[(i+13)&15]^block32[(i+8)&15] \
-    ^block32[(i+2)&15]^block32[i&15],1))
-
-/* (R0+R1), R2, R3, R4 are the different operations used in SHA1 */
-#define R0(v,w,x,y,z,i) z+=((w&(x^y))^y)+blk0(i)+0x5A827999+rol32(v,5); \
-                        w=rol32(w,30);
-#define R1(v,w,x,y,z,i) z+=((w&(x^y))^y)+blk(i)+0x5A827999+rol32(v,5); \
-                        w=rol32(w,30);
-#define R2(v,w,x,y,z,i) z+=(w^x^y)+blk(i)+0x6ED9EBA1+rol32(v,5);w=rol32(w,30);
-#define R3(v,w,x,y,z,i) z+=(((w|x)&y)|(w&x))+blk(i)+0x8F1BBCDC+rol32(v,5); \
-                        w=rol32(w,30);
-#define R4(v,w,x,y,z,i) z+=(w^x^y)+blk(i)+0xCA62C1D6+rol32(v,5);w=rol32(w,30);
-
 struct sha1_ctx {
         u64 count;
         u32 state[5];
         u8 buffer[64];
 };
 
-/* Hash a single 512-bit block. This is the core of the algorithm. */
-static void sha1_transform(u32 *state, const u8 *in)
-{
-	u32 a, b, c, d, e;
-	u32 block32[16];
-
-	/* convert/copy data to workspace */
-	for (a = 0; a < sizeof(block32)/sizeof(u32); a++)
-	  block32[a] = be32_to_cpu (((const u32 *)in)[a]);
-
-	/* Copy context->state[] to working vars */
-	a = state[0];
-	b = state[1];
-	c = state[2];
-	d = state[3];
-	e = state[4];
-
-	/* 4 rounds of 20 operations each. Loop unrolled. */
-	R0(a,b,c,d,e, 0); R0(e,a,b,c,d, 1); R0(d,e,a,b,c, 2); R0(c,d,e,a,b, 3);
-	R0(b,c,d,e,a, 4); R0(a,b,c,d,e, 5); R0(e,a,b,c,d, 6); R0(d,e,a,b,c, 7);
-	R0(c,d,e,a,b, 8); R0(b,c,d,e,a, 9); R0(a,b,c,d,e,10); R0(e,a,b,c,d,11);
-	R0(d,e,a,b,c,12); R0(c,d,e,a,b,13); R0(b,c,d,e,a,14); R0(a,b,c,d,e,15);
-	R1(e,a,b,c,d,16); R1(d,e,a,b,c,17); R1(c,d,e,a,b,18); R1(b,c,d,e,a,19);
-	R2(a,b,c,d,e,20); R2(e,a,b,c,d,21); R2(d,e,a,b,c,22); R2(c,d,e,a,b,23);
-	R2(b,c,d,e,a,24); R2(a,b,c,d,e,25); R2(e,a,b,c,d,26); R2(d,e,a,b,c,27);
-	R2(c,d,e,a,b,28); R2(b,c,d,e,a,29); R2(a,b,c,d,e,30); R2(e,a,b,c,d,31);
-	R2(d,e,a,b,c,32); R2(c,d,e,a,b,33); R2(b,c,d,e,a,34); R2(a,b,c,d,e,35);
-	R2(e,a,b,c,d,36); R2(d,e,a,b,c,37); R2(c,d,e,a,b,38); R2(b,c,d,e,a,39);
-	R3(a,b,c,d,e,40); R3(e,a,b,c,d,41); R3(d,e,a,b,c,42); R3(c,d,e,a,b,43);
-	R3(b,c,d,e,a,44); R3(a,b,c,d,e,45); R3(e,a,b,c,d,46); R3(d,e,a,b,c,47);
-	R3(c,d,e,a,b,48); R3(b,c,d,e,a,49); R3(a,b,c,d,e,50); R3(e,a,b,c,d,51);
-	R3(d,e,a,b,c,52); R3(c,d,e,a,b,53); R3(b,c,d,e,a,54); R3(a,b,c,d,e,55);
-	R3(e,a,b,c,d,56); R3(d,e,a,b,c,57); R3(c,d,e,a,b,58); R3(b,c,d,e,a,59);
-	R4(a,b,c,d,e,60); R4(e,a,b,c,d,61); R4(d,e,a,b,c,62); R4(c,d,e,a,b,63);
-	R4(b,c,d,e,a,64); R4(a,b,c,d,e,65); R4(e,a,b,c,d,66); R4(d,e,a,b,c,67);
-	R4(c,d,e,a,b,68); R4(b,c,d,e,a,69); R4(a,b,c,d,e,70); R4(e,a,b,c,d,71);
-	R4(d,e,a,b,c,72); R4(c,d,e,a,b,73); R4(b,c,d,e,a,74); R4(a,b,c,d,e,75);
-	R4(e,a,b,c,d,76); R4(d,e,a,b,c,77); R4(c,d,e,a,b,78); R4(b,c,d,e,a,79);
-	/* Add the working vars back into context.state[] */
-	state[0] += a;
-	state[1] += b;
-	state[2] += c;
-	state[3] += d;
-	state[4] += e;
-	/* Wipe variables */
-	a = b = c = d = e = 0;
-	memset (block32, 0x00, sizeof block32);
-}
-
 static void sha1_init(void *ctx)
 {
 	struct sha1_ctx *sctx = ctx;
@@ -115,19 +49,21 @@
 {
 	struct sha1_ctx *sctx = ctx;
 	unsigned int i, j;
+	u32 temp[SHA_WORKSPACE_WORDS];
 
 	j = (sctx->count >> 3) & 0x3f;
 	sctx->count += len << 3;
 
 	if ((j + len) > 63) {
 		memcpy(&sctx->buffer[j], data, (i = 64-j));
-		sha1_transform(sctx->state, sctx->buffer);
+		sha_transform(sctx->state, sctx->buffer, temp);
 		for ( ; i + 63 < len; i += 64) {
-			sha1_transform(sctx->state, &data[i]);
+			sha_transform(sctx->state, &data[i], temp);
 		}
 		j = 0;
 	}
 	else i = 0;
+	memset(temp, 0, sizeof(temp));
 	memcpy(&sctx->buffer[j], &data[i], len - i);
 }
 
