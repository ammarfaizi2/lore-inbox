Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262022AbVDVKIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262022AbVDVKIY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 06:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbVDVKIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 06:08:23 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:44013 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262022AbVDVKAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 06:00:17 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: herbert@gondor.apana.org.au, davem@davemloft.net
Subject: [PATCH 1/3] crypto: do not open-code be<->cpu
Date: Fri, 22 Apr 2005 12:59:03 +0300
User-Agent: KMail/1.5.4
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_nrMaCdN0FLHMG7F"
Message-Id: <200504221259.03878.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_nrMaCdN0FLHMG7F
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Patch replaces numerous be<->cpu and le<->cpu
conversions in crypto. Per lkml comments,
it is done with macros:

block[i] = load_be64(ptr,i);
store_be64(out,i, block[i]);

where i is an index: load_be64 will load i'th
big-endian value pointed by ptr (typically a char*).
Same for store.

This results in smaller and cleaner code.

Patch also adds BYTEn(x) macros for extracting n'th byte from
u32 and u64 memory operand. Currently used experssions like
((K >> 40) & 0xff) are not optimal (gcc will load entire word
and then shift and/or mask it).

Macros can be conditionally defined for different arches
for performance. Ones from this patch are found to be best
for i386.

BYTEn macros are used only by next patches.
--
vda

--Boundary-00=_nrMaCdN0FLHMG7F
Content-Type: text/x-diff;
  charset="koi8-r";
  name="1.be_le.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="1.be_le.patch"

diff -urpN linux-2.6.12-rc2.0.orig/crypto/aes.c linux-2.6.12-rc2.1.be_le/crypto/aes.c
--- linux-2.6.12-rc2.0.orig/crypto/aes.c	Tue Apr 19 14:56:08 2005
+++ linux-2.6.12-rc2.1.be_le/crypto/aes.c	Thu Apr 21 23:18:56 2005
@@ -58,6 +58,7 @@
 #include <linux/errno.h>
 #include <linux/crypto.h>
 #include <asm/byteorder.h>
+#include "helper.h"
 
 #define AES_MIN_KEY_SIZE	16
 #define AES_MAX_KEY_SIZE	32
@@ -73,9 +74,6 @@ byte(const u32 x, const unsigned n)
 	return x >> (n << 3);
 }
 
-#define u32_in(x) le32_to_cpu(*(const u32 *)(x))
-#define u32_out(to, from) (*(u32 *)(to) = cpu_to_le32(from))
-
 struct aes_ctx {
 	int key_length;
 	u32 E[60];
@@ -265,10 +263,10 @@ aes_set_key(void *ctx_arg, const u8 *in_
 
 	ctx->key_length = key_len;
 
-	E_KEY[0] = u32_in (in_key);
-	E_KEY[1] = u32_in (in_key + 4);
-	E_KEY[2] = u32_in (in_key + 8);
-	E_KEY[3] = u32_in (in_key + 12);
+	E_KEY[0] = load_le32(in_key,0);
+	E_KEY[1] = load_le32(in_key,1);
+	E_KEY[2] = load_le32(in_key,2);
+	E_KEY[3] = load_le32(in_key,3);
 
 	switch (key_len) {
 	case 16:
@@ -278,17 +276,17 @@ aes_set_key(void *ctx_arg, const u8 *in_
 		break;
 
 	case 24:
-		E_KEY[4] = u32_in (in_key + 16);
-		t = E_KEY[5] = u32_in (in_key + 20);
+		E_KEY[4] = load_le32(in_key,4);
+		t = E_KEY[5] = load_le32(in_key,5);
 		for (i = 0; i < 8; ++i)
 			loop6 (i);
 		break;
 
 	case 32:
-		E_KEY[4] = u32_in (in_key + 16);
-		E_KEY[5] = u32_in (in_key + 20);
-		E_KEY[6] = u32_in (in_key + 24);
-		t = E_KEY[7] = u32_in (in_key + 28);
+		E_KEY[4] = load_le32(in_key,4);
+		E_KEY[5] = load_le32(in_key,5);
+		E_KEY[6] = load_le32(in_key,6);
+		t = E_KEY[7] = load_le32(in_key,7);
 		for (i = 0; i < 7; ++i)
 			loop8 (i);
 		break;
@@ -327,10 +325,10 @@ static void aes_encrypt(void *ctx_arg, u
 	u32 b0[4], b1[4];
 	const u32 *kp = E_KEY + 4;
 
-	b0[0] = u32_in (in) ^ E_KEY[0];
-	b0[1] = u32_in (in + 4) ^ E_KEY[1];
-	b0[2] = u32_in (in + 8) ^ E_KEY[2];
-	b0[3] = u32_in (in + 12) ^ E_KEY[3];
+	b0[0] = load_le32(in,0) ^ E_KEY[0];
+	b0[1] = load_le32(in,1) ^ E_KEY[1];
+	b0[2] = load_le32(in,2) ^ E_KEY[2];
+	b0[3] = load_le32(in,3) ^ E_KEY[3];
 
 	if (ctx->key_length > 24) {
 		f_nround (b1, b0, kp);
@@ -353,10 +351,10 @@ static void aes_encrypt(void *ctx_arg, u
 	f_nround (b1, b0, kp);
 	f_lround (b0, b1, kp);
 
-	u32_out (out, b0[0]);
-	u32_out (out + 4, b0[1]);
-	u32_out (out + 8, b0[2]);
-	u32_out (out + 12, b0[3]);
+	store_le32(out,0, b0[0]);
+	store_le32(out,1, b0[1]);
+	store_le32(out,2, b0[2]);
+	store_le32(out,3, b0[3]);
 }
 
 /* decrypt a block of text */
@@ -381,10 +379,10 @@ static void aes_decrypt(void *ctx_arg, u
 	const int key_len = ctx->key_length;
 	const u32 *kp = D_KEY + key_len + 20;
 
-	b0[0] = u32_in (in) ^ E_KEY[key_len + 24];
-	b0[1] = u32_in (in + 4) ^ E_KEY[key_len + 25];
-	b0[2] = u32_in (in + 8) ^ E_KEY[key_len + 26];
-	b0[3] = u32_in (in + 12) ^ E_KEY[key_len + 27];
+	b0[0] = load_le32(in,0) ^ E_KEY[key_len + 24];
+	b0[1] = load_le32(in,1) ^ E_KEY[key_len + 25];
+	b0[2] = load_le32(in,2) ^ E_KEY[key_len + 26];
+	b0[3] = load_le32(in,3) ^ E_KEY[key_len + 27];
 
 	if (key_len > 24) {
 		i_nround (b1, b0, kp);
@@ -407,10 +405,10 @@ static void aes_decrypt(void *ctx_arg, u
 	i_nround (b1, b0, kp);
 	i_lround (b0, b1, kp);
 
-	u32_out (out, b0[0]);
-	u32_out (out + 4, b0[1]);
-	u32_out (out + 8, b0[2]);
-	u32_out (out + 12, b0[3]);
+	store_le32(out,0, b0[0]);
+	store_le32(out,1, b0[1]);
+	store_le32(out,2, b0[2]);
+	store_le32(out,3, b0[3]);
 }
 
 
@@ -448,4 +446,3 @@ module_exit(aes_fini);
 
 MODULE_DESCRIPTION("Rijndael (AES) Cipher Algorithm");
 MODULE_LICENSE("Dual BSD/GPL");
-
diff -urpN linux-2.6.12-rc2.0.orig/crypto/anubis.c linux-2.6.12-rc2.1.be_le/crypto/anubis.c
--- linux-2.6.12-rc2.0.orig/crypto/anubis.c	Tue Apr 19 14:56:08 2005
+++ linux-2.6.12-rc2.1.be_le/crypto/anubis.c	Thu Apr 21 23:19:46 2005
@@ -34,6 +34,7 @@
 #include <linux/mm.h>
 #include <asm/scatterlist.h>
 #include <linux/crypto.h>
+#include "helper.h"
 
 #define ANUBIS_MIN_KEY_SIZE	16
 #define ANUBIS_MAX_KEY_SIZE	40
@@ -462,7 +463,7 @@ static int anubis_setkey(void *ctx_arg, 
 			 unsigned int key_len, u32 *flags)
 {
 
-	int N, R, i, pos, r;
+	int N, R, i, r;
 	u32 kappa[ANUBIS_MAX_N];
 	u32 inter[ANUBIS_MAX_N];
 
@@ -483,12 +484,8 @@ static int anubis_setkey(void *ctx_arg, 
 	ctx->R = R = 8 + N;
 
 	/* * map cipher key to initial key state (mu): */
-		for (i = 0, pos = 0; i < N; i++, pos += 4) {
-		kappa[i] =
-			(in_key[pos    ] << 24) ^
-			(in_key[pos + 1] << 16) ^
-			(in_key[pos + 2] <<  8) ^
-			(in_key[pos + 3]      );
+	for (i = 0; i < N; i++) {
+		kappa[i] = load_be32(in_key,i);
 	}
 
 	/*
@@ -578,7 +575,7 @@ static int anubis_setkey(void *ctx_arg, 
 static void anubis_crypt(u32 roundKey[ANUBIS_MAX_ROUNDS + 1][4],
 		u8 *ciphertext, const u8 *plaintext, const int R)
 {
-	int i, pos, r;
+	int i;
 	u32 state[4];
 	u32 inter[4];
 
@@ -586,44 +583,39 @@ static void anubis_crypt(u32 roundKey[AN
 	 * map plaintext block to cipher state (mu)
 	 * and add initial round key (sigma[K^0]):
 	 */
-	for (i = 0, pos = 0; i < 4; i++, pos += 4) {
-		state[i] =
-			(plaintext[pos    ] << 24) ^
-			(plaintext[pos + 1] << 16) ^
-			(plaintext[pos + 2] <<  8) ^
-			(plaintext[pos + 3]      ) ^
-			roundKey[0][i];
+	for (i = 0; i < 4; i++) {
+		state[i] = load_be32(plaintext,i) ^ roundKey[0][i];
 	}
 
 	/*
 	 * R - 1 full rounds:
 	 */
 
-	for (r = 1; r < R; r++) {
+	for (i = 1; i < R; i++) {
 		inter[0] =
 			T0[(state[0] >> 24)       ] ^
 			T1[(state[1] >> 24)       ] ^
 			T2[(state[2] >> 24)       ] ^
 			T3[(state[3] >> 24)       ] ^
-			roundKey[r][0];
+			roundKey[i][0];
 		inter[1] =
 			T0[(state[0] >> 16) & 0xff] ^
 			T1[(state[1] >> 16) & 0xff] ^
 			T2[(state[2] >> 16) & 0xff] ^
 			T3[(state[3] >> 16) & 0xff] ^
-			roundKey[r][1];
+			roundKey[i][1];
 		inter[2] =
 			T0[(state[0] >>  8) & 0xff] ^
 			T1[(state[1] >>  8) & 0xff] ^
 			T2[(state[2] >>  8) & 0xff] ^
 			T3[(state[3] >>  8) & 0xff] ^
-			roundKey[r][2];
+			roundKey[i][2];
 		inter[3] =
 			T0[(state[0]      ) & 0xff] ^
 			T1[(state[1]      ) & 0xff] ^
 			T2[(state[2]      ) & 0xff] ^
 			T3[(state[3]      ) & 0xff] ^
-			roundKey[r][3];
+			roundKey[i][3];
 		state[0] = inter[0];
 		state[1] = inter[1];
 		state[2] = inter[2];
@@ -663,12 +655,8 @@ static void anubis_crypt(u32 roundKey[AN
 	 * map cipher state to ciphertext block (mu^{-1}):
 	 */
 
-	for (i = 0, pos = 0; i < 4; i++, pos += 4) {
-		u32 w = inter[i];
-		ciphertext[pos    ] = (u8)(w >> 24);
-		ciphertext[pos + 1] = (u8)(w >> 16);
-		ciphertext[pos + 2] = (u8)(w >>  8);
-		ciphertext[pos + 3] = (u8)(w      );
+	for (i = 0; i < 4; i++) {
+		store_be32(ciphertext,i, inter[i]);
 	}
 }
 
@@ -701,10 +689,7 @@ static struct crypto_alg anubis_alg = {
 
 static int __init init(void)
 {
-	int ret = 0;
-	
-	ret = crypto_register_alg(&anubis_alg);
-	return ret;
+	return crypto_register_alg(&anubis_alg);
 }
 
 static void __exit fini(void)
diff -urpN linux-2.6.12-rc2.0.orig/crypto/blowfish.c linux-2.6.12-rc2.1.be_le/crypto/blowfish.c
--- linux-2.6.12-rc2.0.orig/crypto/blowfish.c	Tue Apr 19 14:56:08 2005
+++ linux-2.6.12-rc2.1.be_le/crypto/blowfish.c	Thu Apr 21 23:20:14 2005
@@ -21,6 +21,7 @@
 #include <linux/mm.h>
 #include <asm/scatterlist.h>
 #include <linux/crypto.h>
+#include "helper.h"
 
 #define BF_BLOCK_SIZE 8
 #define BF_MIN_KEY_SIZE 4
@@ -349,25 +350,21 @@ static void encrypt_block(struct bf_ctx 
 
 static void bf_encrypt(void *ctx, u8 *dst, const u8 *src)
 {
-	const __be32 *in_blk = (const __be32 *)src;
-	__be32 *const out_blk = (__be32 *)dst;
 	u32 in32[2], out32[2];
 
-	in32[0] = be32_to_cpu(in_blk[0]);
-	in32[1] = be32_to_cpu(in_blk[1]);
+	in32[0] = load_be32(src,0);
+	in32[1] = load_be32(src,1);
 	encrypt_block(ctx, out32, in32);
-	out_blk[0] = cpu_to_be32(out32[0]);
-	out_blk[1] = cpu_to_be32(out32[1]);
+	store_be32(dst,0,out32[0]);
+	store_be32(dst,1,out32[1]);
 }
 
 static void bf_decrypt(void *ctx, u8 *dst, const u8 *src)
 {
-	const __be32 *in_blk = (const __be32 *)src;
-	__be32 *const out_blk = (__be32 *)dst;
 	const u32 *P = ((struct bf_ctx *)ctx)->p;
 	const u32 *S = ((struct bf_ctx *)ctx)->s;
-	u32 yl = be32_to_cpu(in_blk[0]);
-	u32 yr = be32_to_cpu(in_blk[1]);
+	u32 yl = load_be32(src,0);
+	u32 yr = load_be32(src,1);
 
 	ROUND(yr, yl, 17);
 	ROUND(yl, yr, 16);
@@ -389,8 +386,8 @@ static void bf_decrypt(void *ctx, u8 *ds
 	yl ^= P[1];
 	yr ^= P[0];
 
-	out_blk[0] = cpu_to_be32(yr);
-	out_blk[1] = cpu_to_be32(yl);
+	store_be32(dst,0,yr);
+	store_be32(dst,1,yl);
 }
 
 /* 
diff -urpN linux-2.6.12-rc2.0.orig/crypto/cast5.c linux-2.6.12-rc2.1.be_le/crypto/cast5.c
--- linux-2.6.12-rc2.0.orig/crypto/cast5.c	Tue Apr 19 14:56:08 2005
+++ linux-2.6.12-rc2.1.be_le/crypto/cast5.c	Thu Apr 21 23:20:40 2005
@@ -26,6 +26,7 @@
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/string.h>
+#include "helper.h"
 
 #define CAST5_BLOCK_SIZE 8
 #define CAST5_MIN_KEY_SIZE 5
@@ -589,8 +590,8 @@ static void cast5_encrypt(void *ctx, u8 
 	/* (L0,R0) <-- (m1...m64).  (Split the plaintext into left and
 	 * right 32-bit halves L0 = m1...m32 and R0 = m33...m64.)
 	 */
-	l = inbuf[0] << 24 | inbuf[1] << 16 | inbuf[2] << 8 | inbuf[3];
-	r = inbuf[4] << 24 | inbuf[5] << 16 | inbuf[6] << 8 | inbuf[7];
+	l = load_be32(inbuf,0);
+	r = load_be32(inbuf,1);
 
 	/* (16 rounds) for i from 1 to 16, compute Li and Ri as follows:
 	 *  Li = Ri-1;
@@ -634,14 +635,8 @@ static void cast5_encrypt(void *ctx, u8 
 
 	/* c1...c64 <-- (R16,L16).  (Exchange final blocks L16, R16 and
 	 *  concatenate to form the ciphertext.) */
-	outbuf[0] = (r >> 24) & 0xff;
-	outbuf[1] = (r >> 16) & 0xff;
-	outbuf[2] = (r >> 8) & 0xff;
-	outbuf[3] = r & 0xff;
-	outbuf[4] = (l >> 24) & 0xff;
-	outbuf[5] = (l >> 16) & 0xff;
-	outbuf[6] = (l >> 8) & 0xff;
-	outbuf[7] = l & 0xff;
+	store_be32(outbuf,0, r);
+	store_be32(outbuf,1, l);
 }
 
 static void cast5_decrypt(void *ctx, u8 * outbuf, const u8 * inbuf)
@@ -655,8 +650,8 @@ static void cast5_decrypt(void *ctx, u8 
 	Km = c->Km;
 	Kr = c->Kr;
 
-	l = inbuf[0] << 24 | inbuf[1] << 16 | inbuf[2] << 8 | inbuf[3];
-	r = inbuf[4] << 24 | inbuf[5] << 16 | inbuf[6] << 8 | inbuf[7];
+	l = load_be32(inbuf,0);
+	r = load_be32(inbuf,1);
 
 	if (!(c->rr)) {
 		t = l; l = r; r = t ^ F1(r, Km[15], Kr[15]);
@@ -690,14 +685,8 @@ static void cast5_decrypt(void *ctx, u8 
 		t = l; l = r; r = t ^ F1(r, Km[0], Kr[0]);
 	}
 
-	outbuf[0] = (r >> 24) & 0xff;
-	outbuf[1] = (r >> 16) & 0xff;
-	outbuf[2] = (r >> 8) & 0xff;
-	outbuf[3] = r & 0xff;
-	outbuf[4] = (l >> 24) & 0xff;
-	outbuf[5] = (l >> 16) & 0xff;
-	outbuf[6] = (l >> 8) & 0xff;
-	outbuf[7] = l & 0xff;
+	store_be32(outbuf,0, r);
+	store_be32(outbuf,1, l);
 }
 
 static void key_schedule(u32 * x, u32 * z, u32 * k)
@@ -795,13 +784,10 @@ cast5_setkey(void *ctx, const u8 * key, 
 	memset(p_key, 0, 16);
 	memcpy(p_key, key, key_len);
 
-
-	x[0] = p_key[0] << 24 | p_key[1] << 16 | p_key[2] << 8 | p_key[3];
-	x[1] = p_key[4] << 24 | p_key[5] << 16 | p_key[6] << 8 | p_key[7];
-	x[2] =
-	    p_key[8] << 24 | p_key[9] << 16 | p_key[10] << 8 | p_key[11];
-	x[3] =
-	    p_key[12] << 24 | p_key[13] << 16 | p_key[14] << 8 | p_key[15];
+	x[0] = load_be32(p_key,0);
+	x[1] = load_be32(p_key,1);
+	x[2] = load_be32(p_key,2);
+	x[3] = load_be32(p_key,3);
 
 	key_schedule(x, z, k);
 	for (i = 0; i < 16; i++)
@@ -845,4 +831,3 @@ module_exit(fini);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Cast5 Cipher Algorithm");
-
diff -urpN linux-2.6.12-rc2.0.orig/crypto/cast6.c linux-2.6.12-rc2.1.be_le/crypto/cast6.c
--- linux-2.6.12-rc2.0.orig/crypto/cast6.c	Tue Apr 19 14:56:08 2005
+++ linux-2.6.12-rc2.1.be_le/crypto/cast6.c	Thu Apr 21 23:20:48 2005
@@ -23,6 +23,7 @@
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/string.h>
+#include "helper.h"
 
 #define CAST6_BLOCK_SIZE 16
 #define CAST6_MIN_KEY_SIZE 16
@@ -395,16 +396,14 @@ cast6_setkey(void *ctx, const u8 * in_ke
 	memset (p_key, 0, 32);
 	memcpy (p_key, in_key, key_len);
 	
-	key[0] = p_key[0] << 24 | p_key[1] << 16 | p_key[2] << 8 | p_key[3];		/* A */
-	key[1] = p_key[4] << 24 | p_key[5] << 16 | p_key[6] << 8 | p_key[7];		/* B */
-	key[2] = p_key[8] << 24 | p_key[9] << 16 | p_key[10] << 8 | p_key[11];		/* C */
-	key[3] = p_key[12] << 24 | p_key[13] << 16 | p_key[14] << 8 | p_key[15];	/* D */
-	key[4] = p_key[16] << 24 | p_key[17] << 16 | p_key[18] << 8 | p_key[19];	/* E */
-	key[5] = p_key[20] << 24 | p_key[21] << 16 | p_key[22] << 8 | p_key[23];	/* F */
-	key[6] = p_key[24] << 24 | p_key[25] << 16 | p_key[26] << 8 | p_key[27];	/* G */
-	key[7] = p_key[28] << 24 | p_key[29] << 16 | p_key[30] << 8 | p_key[31];	/* H */
-	
-
+	key[0] = load_be32(p_key,0);	/* A */
+	key[1] = load_be32(p_key,1);	/* B */
+	key[2] = load_be32(p_key,2);	/* C */
+	key[3] = load_be32(p_key,3);	/* D */
+	key[4] = load_be32(p_key,4);	/* E */
+	key[5] = load_be32(p_key,5);	/* F */
+	key[6] = load_be32(p_key,6);	/* G */
+	key[7] = load_be32(p_key,7);	/* H */
 
 	for (i = 0; i < 12; i++) {
 		W (key, 2 * i);
@@ -448,10 +447,10 @@ static void cast6_encrypt (void * ctx, u
 	u32 * Km; 
 	u8 * Kr;
 
-	block[0] = inbuf[0] << 24 | inbuf[1] << 16 | inbuf[2] << 8 | inbuf[3];
-	block[1] = inbuf[4] << 24 | inbuf[5] << 16 | inbuf[6] << 8 | inbuf[7];
-	block[2] = inbuf[8] << 24 | inbuf[9] << 16 | inbuf[10] << 8 | inbuf[11];
-	block[3] = inbuf[12] << 24 | inbuf[13] << 16 | inbuf[14] << 8 | inbuf[15];
+	block[0] = load_be32(inbuf,0);
+	block[1] = load_be32(inbuf,1);
+	block[2] = load_be32(inbuf,2);
+	block[3] = load_be32(inbuf,3);
 
 	Km = c->Km[0]; Kr = c->Kr[0]; Q (block, Kr, Km);
 	Km = c->Km[1]; Kr = c->Kr[1]; Q (block, Kr, Km);
@@ -465,24 +464,12 @@ static void cast6_encrypt (void * ctx, u
 	Km = c->Km[9]; Kr = c->Kr[9]; QBAR (block, Kr, Km);
 	Km = c->Km[10]; Kr = c->Kr[10]; QBAR (block, Kr, Km);
 	Km = c->Km[11]; Kr = c->Kr[11]; QBAR (block, Kr, Km);
-	
-	outbuf[0] = (block[0] >> 24) & 0xff;
-	outbuf[1] = (block[0] >> 16) & 0xff;
-	outbuf[2] = (block[0] >> 8) & 0xff;
-	outbuf[3] = block[0] & 0xff;
-	outbuf[4] = (block[1] >> 24) & 0xff;
-	outbuf[5] = (block[1] >> 16) & 0xff;
-	outbuf[6] = (block[1] >> 8) & 0xff;
-	outbuf[7] = block[1] & 0xff;
-	outbuf[8] = (block[2] >> 24) & 0xff;
-	outbuf[9] = (block[2] >> 16) & 0xff;
-	outbuf[10] = (block[2] >> 8) & 0xff;
-	outbuf[11] = block[2] & 0xff;
-	outbuf[12] = (block[3] >> 24) & 0xff;
-	outbuf[13] = (block[3] >> 16) & 0xff;
-	outbuf[14] = (block[3] >> 8) & 0xff;
-	outbuf[15] = block[3] & 0xff;	
-}	
+
+	store_be32(outbuf,0, block[0]);
+	store_be32(outbuf,1, block[1]);
+	store_be32(outbuf,2, block[2]);
+	store_be32(outbuf,3, block[3]);
+}
 
 static void cast6_decrypt (void * ctx, u8 * outbuf, const u8 * inbuf) {
 	struct cast6_ctx * c = (struct cast6_ctx *)ctx;
@@ -490,10 +477,10 @@ static void cast6_decrypt (void * ctx, u
 	u32 * Km; 
 	u8 * Kr;
 
-	block[0] = inbuf[0] << 24 | inbuf[1] << 16 | inbuf[2] << 8 | inbuf[3];
-	block[1] = inbuf[4] << 24 | inbuf[5] << 16 | inbuf[6] << 8 | inbuf[7];
-	block[2] = inbuf[8] << 24 | inbuf[9] << 16 | inbuf[10] << 8 | inbuf[11];
-	block[3] = inbuf[12] << 24 | inbuf[13] << 16 | inbuf[14] << 8 | inbuf[15];
+	block[0] = load_be32(inbuf,0);
+	block[1] = load_be32(inbuf,1);
+	block[2] = load_be32(inbuf,2);
+	block[3] = load_be32(inbuf,3);
 
 	Km = c->Km[11]; Kr = c->Kr[11]; Q (block, Kr, Km);
 	Km = c->Km[10]; Kr = c->Kr[10]; Q (block, Kr, Km);
@@ -507,24 +494,12 @@ static void cast6_decrypt (void * ctx, u
 	Km = c->Km[2]; Kr = c->Kr[2]; QBAR (block, Kr, Km);
 	Km = c->Km[1]; Kr = c->Kr[1]; QBAR (block, Kr, Km);
 	Km = c->Km[0]; Kr = c->Kr[0]; QBAR (block, Kr, Km);
-	
-	outbuf[0] = (block[0] >> 24) & 0xff;
-	outbuf[1] = (block[0] >> 16) & 0xff;
-	outbuf[2] = (block[0] >> 8) & 0xff;
-	outbuf[3] = block[0] & 0xff;
-	outbuf[4] = (block[1] >> 24) & 0xff;
-	outbuf[5] = (block[1] >> 16) & 0xff;
-	outbuf[6] = (block[1] >> 8) & 0xff;
-	outbuf[7] = block[1] & 0xff;
-	outbuf[8] = (block[2] >> 24) & 0xff;
-	outbuf[9] = (block[2] >> 16) & 0xff;
-	outbuf[10] = (block[2] >> 8) & 0xff;
-	outbuf[11] = block[2] & 0xff;
-	outbuf[12] = (block[3] >> 24) & 0xff;
-	outbuf[13] = (block[3] >> 16) & 0xff;
-	outbuf[14] = (block[3] >> 8) & 0xff;
-	outbuf[15] = block[3] & 0xff;	
-}	
+
+	store_be32(outbuf,0, block[0]);
+	store_be32(outbuf,1, block[1]);
+	store_be32(outbuf,2, block[2]);
+	store_be32(outbuf,3, block[3]);
+}
 
 static struct crypto_alg alg = {
 	.cra_name = "cast6",
diff -urpN linux-2.6.12-rc2.0.orig/crypto/crc32c.c linux-2.6.12-rc2.1.be_le/crypto/crc32c.c
--- linux-2.6.12-rc2.0.orig/crypto/crc32c.c	Tue Apr 19 14:56:08 2005
+++ linux-2.6.12-rc2.1.be_le/crypto/crc32c.c	Thu Apr 21 23:20:30 2005
@@ -17,6 +17,7 @@
 #include <linux/crypto.h>
 #include <linux/crc32c.h>
 #include <asm/byteorder.h>
+#include "helper.h"
 
 #define CHKSUM_BLOCK_SIZE	32
 #define CHKSUM_DIGEST_SIZE	4
@@ -52,7 +53,7 @@ static int chksum_setkey(void *ctx, cons
 			*flags = CRYPTO_TFM_RES_BAD_KEY_LEN;
 		return -EINVAL;
 	}
-	mctx->crc = __cpu_to_le32(*(u32 *)key);
+	mctx->crc = load_le32(key,0);
 	return 0;
 }
 
@@ -71,7 +72,7 @@ static void chksum_final(void *ctx, u8 *
 	struct chksum_ctx *mctx = ctx;
 	u32 mcrc = (mctx->crc ^ ~(u32)0);
 	
-	*(u32 *)out = __le32_to_cpu(mcrc);
+	store_le32(out,0, mcrc);
 }
 
 static struct crypto_alg alg = {
diff -urpN linux-2.6.12-rc2.0.orig/crypto/deflate.c linux-2.6.12-rc2.1.be_le/crypto/deflate.c
--- linux-2.6.12-rc2.0.orig/crypto/deflate.c	Tue Apr 19 14:56:08 2005
+++ linux-2.6.12-rc2.1.be_le/crypto/deflate.c	Tue Apr 19 14:53:24 2005
@@ -220,4 +220,3 @@ module_exit(fini);
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Deflate Compression Algorithm for IPCOMP");
 MODULE_AUTHOR("James Morris <jmorris@intercode.com.au>");
-
diff -urpN linux-2.6.12-rc2.0.orig/crypto/des.c linux-2.6.12-rc2.1.be_le/crypto/des.c
--- linux-2.6.12-rc2.0.orig/crypto/des.c	Tue Apr 19 14:56:08 2005
+++ linux-2.6.12-rc2.1.be_le/crypto/des.c	Thu Apr 21 23:19:04 2005
@@ -26,6 +26,7 @@
 #include <linux/errno.h>
 #include <asm/scatterlist.h>
 #include <linux/crypto.h>
+#include "helper.h"
 
 #define DES_KEY_SIZE		8
 #define DES_EXPKEY_WORDS	32
@@ -35,8 +36,6 @@
 #define DES3_EDE_EXPKEY_WORDS	(3 * DES_EXPKEY_WORDS)
 #define DES3_EDE_BLOCK_SIZE	DES_BLOCK_SIZE
 
-#define ROR(d,c,o)	((d) = (d) >> (c) | (d) << (o))
-
 struct des_ctx {
 	u8 iv[DES_BLOCK_SIZE];
 	u32 expkey[DES_EXPKEY_WORDS];
@@ -282,21 +281,10 @@ static const u8 parity[] = {
 static void des_small_fips_encrypt(u32 *expkey, u8 *dst, const u8 *src)
 {
 	u32 x, y, z;
-	
-	x  = src[7];
-	x <<= 8;
-	x |= src[6];
-	x <<= 8;
-	x |= src[5];
-	x <<= 8;
-	x |= src[4];
-	y  = src[3];
-	y <<= 8;
-	y |= src[2];
-	y <<= 8;
-	y |= src[1];
-	y <<= 8;
-	y |= src[0];
+
+	x  = load_le32(src,1);
+	y  = load_le32(src,0);
+
 	z  = ((x >> 004) ^ y) & 0x0F0F0F0FL;
 	x ^= z << 004;
 	y ^= z;
@@ -635,40 +623,18 @@ static void des_small_fips_encrypt(u32 *
 	z  = ((y >> 004) ^ x) & 0x0F0F0F0FL;
 	y ^= z << 004;
 	x ^= z;
-	dst[0] = x;
-	x >>= 8;
-	dst[1] = x;
-	x >>= 8;
-	dst[2] = x;
-	x >>= 8;
-	dst[3] = x;
-	dst[4] = y;
-	y >>= 8;
-	dst[5] = y;
-	y >>= 8;
-	dst[6] = y;
-	y >>= 8;
-	dst[7] = y;
+
+	store_le32(dst,0, x);
+	store_le32(dst,1, y);
 }
 
 static void des_small_fips_decrypt(u32 *expkey, u8 *dst, const u8 *src)
 {
 	u32 x, y, z;
 	
-	x  = src[7];
-	x <<= 8;
-	x |= src[6];
-	x <<= 8;
-	x |= src[5];
-	x <<= 8;
-	x |= src[4];
-	y  = src[3];
-	y <<= 8;
-	y |= src[2];
-	y <<= 8;
-	y |= src[1];
-	y <<= 8;
-	y |= src[0];
+	x  = load_le32(src,1);
+	y  = load_le32(src,0);
+
 	z  = ((x >> 004) ^ y) & 0x0F0F0F0FL;
 	x ^= z << 004;
 	y ^= z;
@@ -1007,20 +973,9 @@ static void des_small_fips_decrypt(u32 *
 	z  = ((y >> 004) ^ x) & 0x0F0F0F0FL;
 	y ^= z << 004;
 	x ^= z;
-	dst[0] = x;
-	x >>= 8;
-	dst[1] = x;
-	x >>= 8;
-	dst[2] = x;
-	x >>= 8;
-	dst[3] = x;
-	dst[4] = y;
-	y >>= 8;
-	dst[5] = y;
-	y >>= 8;
-	dst[6] = y;
-	y >>= 8;
-	dst[7] = y;
+
+	store_le32(dst,0, x);
+	store_le32(dst,1, y);
 }
 
 /*
@@ -1159,9 +1114,7 @@ not_weak:
 		w  |= (b1[k[18+24]] | b0[k[19+24]]) << 4;
 		w  |= (b1[k[20+24]] | b0[k[21+24]]) << 2;
 		w  |=  b1[k[22+24]] | b0[k[23+24]];
-		
-		ROR(w, 4, 28);      /* could be eliminated */
-		expkey[1] = w;
+		expkey[1] = ror32(w, 4);	/* could be eliminated */
 
 		k += 48;
 		expkey += 2;
diff -urpN linux-2.6.12-rc2.0.orig/crypto/helper.h linux-2.6.12-rc2.1.be_le/crypto/helper.h
--- linux-2.6.12-rc2.0.orig/crypto/helper.h	Thu Jan  1 03:00:00 1970
+++ linux-2.6.12-rc2.1.be_le/crypto/helper.h	Fri Apr 22 12:14:40 2005
@@ -0,0 +1,59 @@
+#ifndef _CRYPTO_HELPER_H
+#define _CRYPTO_HELPER_H
+
+/* These macros are intended for use on stack or memory
+** operands, not register ones.
+**
+** Provide special case for your arch if needed */
+
+#if 0
+/* loads full u32, shifts and zero-extends low u8 to u32. Bad */
+ #define BYTE7(v) ((u8)((v) >> 56))
+ #define BYTE6(v) ((u8)((v) >> 48))
+ #define BYTE5(v) ((u8)((v) >> 40))
+ #define BYTE4(v) ((u8)((v) >> 32))
+ /* without (u32) below gcc will emit spurious shrdl insns */
+ #define BYTE3(v) ((u8)((u32)(v) >> 24))
+ #define BYTE2(v) ((u8)((u32)(v) >> 16))
+ #define BYTE1(v) ((u8)((u32)(v) >>  8))
+ #define BYTE0(v) ((u8)(v))
+#else
+/* This works best, using zero-extending byte loads (on i386) */
+ #if defined(__LITTLE_ENDIAN)
+  #define BYTE7(v) (((u8*)&(v))[7])
+  #define BYTE6(v) (((u8*)&(v))[6])
+  #define BYTE5(v) (((u8*)&(v))[5])
+  #define BYTE4(v) (((u8*)&(v))[4])
+  #define BYTE3(v) (((u8*)&(v))[3])
+  #define BYTE2(v) (((u8*)&(v))[2])
+  #define BYTE1(v) (((u8*)&(v))[1])
+  #define BYTE0(v) (((u8*)&(v))[0])
+ #elif defined(__BIG_ENDIAN)
+  #define BYTE7(v) (((u8*)&(v))[sizeof(v)-8])
+  #define BYTE6(v) (((u8*)&(v))[sizeof(v)-7])
+  #define BYTE5(v) (((u8*)&(v))[sizeof(v)-6])
+  #define BYTE4(v) (((u8*)&(v))[sizeof(v)-5])
+  #define BYTE3(v) (((u8*)&(v))[sizeof(v)-4])
+  #define BYTE2(v) (((u8*)&(v))[sizeof(v)-3])
+  #define BYTE1(v) (((u8*)&(v))[sizeof(v)-2])
+  #define BYTE0(v) (((u8*)&(v))[sizeof(v)-1])
+ #else
+  #error Give me endianness or give me death
+ #endif
+#endif
+
+
+/* TODO: on 32bit arches 64bit loads and stores can be done as
+** two separate ops. This will eliminate needless swap */
+
+#define load_le32(p,i) le32_to_cpu(((__le32*)(p))[i])
+#define load_be32(p,i) be32_to_cpu(((__be32*)(p))[i])
+#define load_le64(p,i) le64_to_cpu(((__le64*)(p))[i])
+#define load_be64(p,i) be64_to_cpu(((__be64*)(p))[i])
+
+#define store_le32(p,i,v) (((__le32*)(p))[i] = cpu_to_le32(v))
+#define store_be32(p,i,v) (((__be32*)(p))[i] = cpu_to_be32(v))
+#define store_le64(p,i,v) (((__le64*)(p))[i] = cpu_to_le64(v))
+#define store_be64(p,i,v) (((__be64*)(p))[i] = cpu_to_be64(v))
+
+#endif
diff -urpN linux-2.6.12-rc2.0.orig/crypto/hmac.c linux-2.6.12-rc2.1.be_le/crypto/hmac.c
--- linux-2.6.12-rc2.0.orig/crypto/hmac.c	Tue Apr 19 14:56:08 2005
+++ linux-2.6.12-rc2.1.be_le/crypto/hmac.c	Tue Apr 19 14:53:24 2005
@@ -131,4 +131,3 @@ EXPORT_SYMBOL_GPL(crypto_hmac_init);
 EXPORT_SYMBOL_GPL(crypto_hmac_update);
 EXPORT_SYMBOL_GPL(crypto_hmac_final);
 EXPORT_SYMBOL_GPL(crypto_hmac);
-
diff -urpN linux-2.6.12-rc2.0.orig/crypto/internal.h linux-2.6.12-rc2.1.be_le/crypto/internal.h
--- linux-2.6.12-rc2.0.orig/crypto/internal.h	Tue Apr 19 14:56:08 2005
+++ linux-2.6.12-rc2.1.be_le/crypto/internal.h	Tue Apr 19 14:53:24 2005
@@ -89,4 +89,3 @@ void crypto_exit_cipher_ops(struct crypt
 void crypto_exit_compress_ops(struct crypto_tfm *tfm);
 
 #endif	/* _CRYPTO_INTERNAL_H */
-
diff -urpN linux-2.6.12-rc2.0.orig/crypto/khazad.c linux-2.6.12-rc2.1.be_le/crypto/khazad.c
--- linux-2.6.12-rc2.0.orig/crypto/khazad.c	Tue Apr 19 14:56:08 2005
+++ linux-2.6.12-rc2.1.be_le/crypto/khazad.c	Thu Apr 21 23:18:46 2005
@@ -24,6 +24,7 @@
 #include <linux/mm.h>
 #include <asm/scatterlist.h>
 #include <linux/crypto.h>
+#include "helper.h"
 
 #define KHAZAD_KEY_SIZE		16
 #define KHAZAD_BLOCK_SIZE	8
@@ -767,22 +768,8 @@ static int khazad_setkey(void *ctx_arg, 
 		return -EINVAL;
 	}
 
-	K2 = ((u64)in_key[ 0] << 56) ^
-	     ((u64)in_key[ 1] << 48) ^
-	     ((u64)in_key[ 2] << 40) ^
-	     ((u64)in_key[ 3] << 32) ^
-	     ((u64)in_key[ 4] << 24) ^
-	     ((u64)in_key[ 5] << 16) ^
-	     ((u64)in_key[ 6] <<  8) ^
-	     ((u64)in_key[ 7]      );
-	K1 = ((u64)in_key[ 8] << 56) ^
-	     ((u64)in_key[ 9] << 48) ^
-	     ((u64)in_key[10] << 40) ^
-	     ((u64)in_key[11] << 32) ^
-	     ((u64)in_key[12] << 24) ^
-	     ((u64)in_key[13] << 16) ^
-	     ((u64)in_key[14] <<  8) ^
-	     ((u64)in_key[15]      );
+	K2 = load_be64(in_key,0);
+	K1 = load_be64(in_key,1);
 
 	/* setup the encrypt key */
 	for (r = 0; r <= KHAZAD_ROUNDS; r++) {
@@ -814,7 +801,6 @@ static int khazad_setkey(void *ctx_arg, 
 	ctx->D[KHAZAD_ROUNDS] = ctx->E[0];
 
 	return 0;
-
 }
 
 static void khazad_crypt(const u64 roundKey[KHAZAD_ROUNDS + 1],
@@ -824,15 +810,7 @@ static void khazad_crypt(const u64 round
 	int r;
 	u64 state;
 
-	state = ((u64)plaintext[0] << 56) ^
-		((u64)plaintext[1] << 48) ^
-		((u64)plaintext[2] << 40) ^
-		((u64)plaintext[3] << 32) ^
-		((u64)plaintext[4] << 24) ^
-		((u64)plaintext[5] << 16) ^
-		((u64)plaintext[6] <<  8) ^
-		((u64)plaintext[7]      ) ^
-		roundKey[0];
+	state = load_be64(plaintext,0) ^ roundKey[0];
 
 	for (r = 1; r < KHAZAD_ROUNDS; r++) {
 		state = T0[(int)(state >> 56)       ] ^
@@ -856,15 +834,7 @@ static void khazad_crypt(const u64 round
 		(T7[(int)(state      ) & 0xff] & 0x00000000000000ffULL) ^
 		roundKey[KHAZAD_ROUNDS];
 
-	ciphertext[0] = (u8)(state >> 56);
-	ciphertext[1] = (u8)(state >> 48);
-	ciphertext[2] = (u8)(state >> 40);
-	ciphertext[3] = (u8)(state >> 32);
-	ciphertext[4] = (u8)(state >> 24);
-	ciphertext[5] = (u8)(state >> 16);
-	ciphertext[6] = (u8)(state >>  8);
-	ciphertext[7] = (u8)(state      );
-
+	store_be64(ciphertext,0, state);
 }
 
 static void khazad_encrypt(void *ctx_arg, u8 *dst, const u8 *src)
@@ -906,7 +876,6 @@ static void __exit fini(void)
 {
 	crypto_unregister_alg(&khazad_alg);
 }
-
 
 module_init(init);
 module_exit(fini);
diff -urpN linux-2.6.12-rc2.0.orig/crypto/md4.c linux-2.6.12-rc2.1.be_le/crypto/md4.c
--- linux-2.6.12-rc2.0.orig/crypto/md4.c	Tue Apr 19 14:56:08 2005
+++ linux-2.6.12-rc2.1.be_le/crypto/md4.c	Tue Apr 19 14:53:24 2005
@@ -37,12 +37,6 @@ struct md4_ctx {
 	u64 byte_count;
 };
 
-static inline u32 lshift(u32 x, unsigned int s)
-{
-	x &= 0xFFFFFFFF;
-	return ((x << s) & 0xFFFFFFFF) | (x >> (32 - s));
-}
-
 static inline u32 F(u32 x, u32 y, u32 z)
 {
 	return (x & y) | ((~x) & z);
@@ -58,9 +52,9 @@ static inline u32 H(u32 x, u32 y, u32 z)
 	return x ^ y ^ z;
 }
                         
-#define ROUND1(a,b,c,d,k,s) (a = lshift(a + F(b,c,d) + k, s))
-#define ROUND2(a,b,c,d,k,s) (a = lshift(a + G(b,c,d) + k + (u32)0x5A827999,s))
-#define ROUND3(a,b,c,d,k,s) (a = lshift(a + H(b,c,d) + k + (u32)0x6ED9EBA1,s))
+#define ROUND1(a,b,c,d,k,s) (a = rol32(a + F(b,c,d) + k, s))
+#define ROUND2(a,b,c,d,k,s) (a = rol32(a + G(b,c,d) + k + (u32)0x5A827999, s))
+#define ROUND3(a,b,c,d,k,s) (a = rol32(a + H(b,c,d) + k + (u32)0x6ED9EBA1, s))
 
 /* XXX: this stuff can be optimized */
 static inline void le32_to_cpu_array(u32 *buf, unsigned int words)
@@ -247,4 +241,3 @@ module_exit(fini);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("MD4 Message Digest Algorithm");
-
diff -urpN linux-2.6.12-rc2.0.orig/crypto/michael_mic.c linux-2.6.12-rc2.1.be_le/crypto/michael_mic.c
--- linux-2.6.12-rc2.0.orig/crypto/michael_mic.c	Tue Apr 19 14:56:08 2005
+++ linux-2.6.12-rc2.1.be_le/crypto/michael_mic.c	Thu Apr 21 23:20:00 2005
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/crypto.h>
+#include "helper.h"
 
 
 struct michael_mic_ctx {
@@ -43,21 +44,6 @@ do {				\
 } while (0)
 
 
-static inline u32 get_le32(const u8 *p)
-{
-	return p[0] | (p[1] << 8) | (p[2] << 16) | (p[3] << 24);
-}
-
-
-static inline void put_le32(u8 *p, u32 v)
-{
-	p[0] = v;
-	p[1] = v >> 8;
-	p[2] = v >> 16;
-	p[3] = v >> 24;
-}
-
-
 static void michael_init(void *ctx)
 {
 	struct michael_mic_ctx *mctx = ctx;
@@ -81,13 +67,13 @@ static void michael_update(void *ctx, co
 		if (mctx->pending_len < 4)
 			return;
 
-		mctx->l ^= get_le32(mctx->pending);
+		mctx->l ^= load_le32(mctx->pending,0);
 		michael_block(mctx->l, mctx->r);
 		mctx->pending_len = 0;
 	}
 
 	while (len >= 4) {
-		mctx->l ^= get_le32(data);
+		mctx->l ^= load_le32(data,0);
 		michael_block(mctx->l, mctx->r);
 		data += 4;
 		len -= 4;
@@ -125,8 +111,8 @@ static void michael_final(void *ctx, u8 
 	/* l ^= 0; */
 	michael_block(mctx->l, mctx->r);
 
-	put_le32(out, mctx->l);
-	put_le32(out + 4, mctx->r);
+	store_le32(out,0, mctx->l);
+	store_le32(out,1, mctx->r);
 }
 
 
@@ -139,8 +125,8 @@ static int michael_setkey(void *ctx, con
 			*flags = CRYPTO_TFM_RES_BAD_KEY_LEN;
 		return -EINVAL;
 	}
-	mctx->l = get_le32(key);
-	mctx->r = get_le32(key + 4);
+	mctx->l = load_le32(key,0);
+	mctx->r = load_le32(key,1);
 	return 0;
 }
 
diff -urpN linux-2.6.12-rc2.0.orig/crypto/serpent.c linux-2.6.12-rc2.1.be_le/crypto/serpent.c
--- linux-2.6.12-rc2.0.orig/crypto/serpent.c	Tue Apr 19 14:56:08 2005
+++ linux-2.6.12-rc2.1.be_le/crypto/serpent.c	Thu Apr 21 23:19:32 2005
@@ -20,6 +20,7 @@
 #include <linux/errno.h>
 #include <asm/byteorder.h>
 #include <linux/crypto.h>
+#include "helper.h"
 
 /* Key is padded to the maximum of 256 bits before round key generation.
  * Any key length <= 256 bits (32 bytes) is allowed by the algorithm.
@@ -368,9 +369,9 @@ static int serpent_setkey(void *ctx, con
 static void serpent_encrypt(void *ctx, u8 *dst, const u8 *src)
 {
 	const u32
-		*k = ((struct serpent_ctx *)ctx)->expkey,
-		*s = (const u32 *)src;
-	u32	*d = (u32 *)dst,
+		*k = ((struct serpent_ctx *)ctx)->expkey;
+		//*s = (const u32 *)src;
+	u32	//*d = (u32 *)dst,
 		r0, r1, r2, r3, r4;
 
 /*
@@ -378,10 +379,10 @@ static void serpent_encrypt(void *ctx, u
  * on architectures with stricter alignment rules than x86
  */
 
-	r0 = le32_to_cpu(s[0]);
-	r1 = le32_to_cpu(s[1]);
-	r2 = le32_to_cpu(s[2]);
-	r3 = le32_to_cpu(s[3]);
+	r0 = load_le32(src,0);
+	r1 = load_le32(src,1);
+	r2 = load_le32(src,2);
+	r3 = load_le32(src,3);
 
 				 K(r0,r1,r2,r3,0);
 	S0(r0,r1,r2,r3,r4);	LK(r2,r1,r3,r0,r4,1);
@@ -417,24 +418,24 @@ static void serpent_encrypt(void *ctx, u
 	S6(r0,r1,r3,r2,r4);	LK(r3,r4,r1,r2,r0,31);
 	S7(r3,r4,r1,r2,r0);	 K(r0,r1,r2,r3,32);
 
-	d[0] = cpu_to_le32(r0);
-	d[1] = cpu_to_le32(r1);
-	d[2] = cpu_to_le32(r2);
-	d[3] = cpu_to_le32(r3);
+	store_le32(dst,0, r0);
+	store_le32(dst,1, r1);
+	store_le32(dst,2, r2);
+	store_le32(dst,3, r3);
 }
 
 static void serpent_decrypt(void *ctx, u8 *dst, const u8 *src)
 {
 	const u32
-		*k = ((struct serpent_ctx *)ctx)->expkey,
-		*s = (const u32 *)src;
-	u32	*d = (u32 *)dst,
+		*k = ((struct serpent_ctx *)ctx)->expkey;
+		//*s = (const u32 *)src;
+	u32	//*d = (u32 *)dst,
 		r0, r1, r2, r3, r4;
 
-	r0 = le32_to_cpu(s[0]);
-	r1 = le32_to_cpu(s[1]);
-	r2 = le32_to_cpu(s[2]);
-	r3 = le32_to_cpu(s[3]);
+	r0 = load_le32(src,0);
+	r1 = load_le32(src,1);
+	r2 = load_le32(src,2);
+	r3 = load_le32(src,3);
 
 				K(r0,r1,r2,r3,32);
 	SI7(r0,r1,r2,r3,r4);	KL(r1,r3,r0,r4,r2,31);
@@ -470,10 +471,10 @@ static void serpent_decrypt(void *ctx, u
 	SI1(r3,r1,r2,r0,r4);	KL(r4,r1,r2,r0,r3,1);
 	SI0(r4,r1,r2,r0,r3);	K(r2,r3,r1,r4,0);
 
-	d[0] = cpu_to_le32(r2);
-	d[1] = cpu_to_le32(r3);
-	d[2] = cpu_to_le32(r1);
-	d[3] = cpu_to_le32(r4);
+	store_le32(dst,0, r2);
+	store_le32(dst,1, r3);
+	store_le32(dst,2, r1);
+	store_le32(dst,3, r4);
 }
 
 static struct crypto_alg serpent_alg = {
diff -urpN linux-2.6.12-rc2.0.orig/crypto/sha1.c linux-2.6.12-rc2.1.be_le/crypto/sha1.c
--- linux-2.6.12-rc2.0.orig/crypto/sha1.c	Tue Apr 19 14:56:08 2005
+++ linux-2.6.12-rc2.1.be_le/crypto/sha1.c	Thu Apr 21 23:24:16 2005
@@ -23,6 +23,7 @@
 #include <linux/cryptohash.h>
 #include <asm/scatterlist.h>
 #include <asm/byteorder.h>
+#include "helper.h"
 
 #define SHA1_DIGEST_SIZE	20
 #define SHA1_HMAC_BLOCK_SIZE	64
@@ -67,25 +68,15 @@ static void sha1_update(void *ctx, const
 	memcpy(&sctx->buffer[j], &data[i], len - i);
 }
 
-
 /* Add padding and return the message digest. */
 static void sha1_final(void* ctx, u8 *out)
 {
 	struct sha1_ctx *sctx = ctx;
-	u32 i, j, index, padlen;
-	u64 t;
+	u32 i, index, padlen;
 	u8 bits[8] = { 0, };
 	static const u8 padding[64] = { 0x80, };
 
-	t = sctx->count;
-	bits[7] = 0xff & t; t>>=8;
-	bits[6] = 0xff & t; t>>=8;
-	bits[5] = 0xff & t; t>>=8;
-	bits[4] = 0xff & t; t>>=8;
-	bits[3] = 0xff & t; t>>=8;
-	bits[2] = 0xff & t; t>>=8;
-	bits[1] = 0xff & t; t>>=8;
-	bits[0] = 0xff & t;
+	store_be64(bits,0, sctx->count);
 
 	/* Pad out to 56 mod 64 */
 	index = (sctx->count >> 3) & 0x3f;
@@ -96,12 +87,8 @@ static void sha1_final(void* ctx, u8 *ou
 	sha1_update(sctx, bits, sizeof bits); 
 
 	/* Store state in digest */
-	for (i = j = 0; i < 5; i++, j += 4) {
-		u32 t2 = sctx->state[i];
-		out[j+3] = t2 & 0xff; t2>>=8;
-		out[j+2] = t2 & 0xff; t2>>=8;
-		out[j+1] = t2 & 0xff; t2>>=8;
-		out[j  ] = t2 & 0xff;
+	for (i = 0; i < 5; i++) {
+		store_be32(out,i, sctx->state[i]);
 	}
 
 	/* Wipe context */
diff -urpN linux-2.6.12-rc2.0.orig/crypto/sha256.c linux-2.6.12-rc2.1.be_le/crypto/sha256.c
--- linux-2.6.12-rc2.0.orig/crypto/sha256.c	Tue Apr 19 14:56:08 2005
+++ linux-2.6.12-rc2.1.be_le/crypto/sha256.c	Thu Apr 21 23:20:58 2005
@@ -22,6 +22,7 @@
 #include <linux/crypto.h>
 #include <asm/scatterlist.h>
 #include <asm/byteorder.h>
+#include "helper.h"
 
 #define SHA256_DIGEST_SIZE	32
 #define SHA256_HMAC_BLOCK_SIZE	64
@@ -58,7 +59,7 @@ static inline u32 Maj(u32 x, u32 y, u32 
 
 static inline void LOAD_OP(int I, u32 *W, const u8 *input)
 {
-	W[I] = __be32_to_cpu( ((__be32*)(input))[I] );
+	W[I] = load_be32(input,I);
 }
 
 static inline void BLEND_OP(int I, u32 *W)
@@ -280,21 +281,13 @@ static void sha256_final(void* ctx, u8 *
 {
 	struct sha256_ctx *sctx = ctx;
 	u8 bits[8];
-	unsigned int index, pad_len, t;
-	int i, j;
+	unsigned int index, pad_len;
+	int i;
 	static const u8 padding[64] = { 0x80, };
 
 	/* Save number of bits */
-	t = sctx->count[0];
-	bits[7] = t; t >>= 8;
-	bits[6] = t; t >>= 8;
-	bits[5] = t; t >>= 8;
-	bits[4] = t;
-	t = sctx->count[1];
-	bits[3] = t; t >>= 8;
-	bits[2] = t; t >>= 8;
-	bits[1] = t; t >>= 8;
-	bits[0] = t;
+	store_be32(bits,1, sctx->count[0]);
+	store_be32(bits,0, sctx->count[1]);
 
 	/* Pad out to 56 mod 64. */
 	index = (sctx->count[0] >> 3) & 0x3f;
@@ -305,18 +298,13 @@ static void sha256_final(void* ctx, u8 *
 	sha256_update(sctx, bits, 8);
 
 	/* Store state in digest */
-	for (i = j = 0; i < 8; i++, j += 4) {
-		t = sctx->state[i];
-		out[j+3] = t; t >>= 8;
-		out[j+2] = t; t >>= 8;
-		out[j+1] = t; t >>= 8;
-		out[j  ] = t;
+	for (i = 0; i < 8; i++) {
+		store_be32(out,i, sctx->state[i]);
 	}
 
 	/* Zeroize sensitive information. */
 	memset(sctx, 0, sizeof(*sctx));
 }
-
 
 static struct crypto_alg alg = {
 	.cra_name	=	"sha256",
diff -urpN linux-2.6.12-rc2.0.orig/crypto/sha512.c linux-2.6.12-rc2.1.be_le/crypto/sha512.c
--- linux-2.6.12-rc2.0.orig/crypto/sha512.c	Tue Apr 19 14:56:08 2005
+++ linux-2.6.12-rc2.1.be_le/crypto/sha512.c	Thu Apr 21 23:21:18 2005
@@ -21,6 +21,8 @@
 #include <asm/scatterlist.h>
 #include <asm/byteorder.h>
 
+#include "helper.h"
+
 #define SHA384_DIGEST_SIZE 48
 #define SHA512_DIGEST_SIZE 64
 #define SHA384_HMAC_BLOCK_SIZE  96
@@ -100,7 +102,7 @@ static const u64 sha512_K[80] = {
 
 static inline void LOAD_OP(int I, u64 *W, const u8 *input)
 {
-	W[I] = __be64_to_cpu( ((__be64*)input)[I] );
+	W[I] = load_be64(input,I);
 }
 
 static inline void BLEND_OP(int I, u64 *W)
@@ -239,10 +241,10 @@ sha512_final(void *ctx, u8 *hash)
 	index = pad_len = i = 0;
 
 	/* Save number of bits */
-	((__be32*)bits)[3] = __cpu_to_be32(sctx->count[0]);
-	((__be32*)bits)[2] = __cpu_to_be32(sctx->count[1]);
-	((__be32*)bits)[1] = __cpu_to_be32(sctx->count[2]);
-	((__be32*)bits)[0] = __cpu_to_be32(sctx->count[3]);
+	store_be32(bits,3, sctx->count[0]);
+	store_be32(bits,2, sctx->count[1]);
+	store_be32(bits,1, sctx->count[2]);
+	store_be32(bits,0, sctx->count[3]);
 
 	/* Pad out to 112 mod 128. */
 	index = (sctx->count[0] >> 3) & 0x7f;
@@ -254,7 +256,7 @@ sha512_final(void *ctx, u8 *hash)
 
 	/* Store state in digest */
 	for (i = 0; i < 8; i++)
-		((__be64*)hash)[i] = __cpu_to_be64(sctx->state[i]);
+		store_be64(hash,i, sctx->state[i]);
 
 	/* Zeroize sensitive information. */
 	memset(sctx, 0, sizeof(struct sha512_ctx));
diff -urpN linux-2.6.12-rc2.0.orig/crypto/tea.c linux-2.6.12-rc2.1.be_le/crypto/tea.c
--- linux-2.6.12-rc2.0.orig/crypto/tea.c	Tue Apr 19 14:56:08 2005
+++ linux-2.6.12-rc2.1.be_le/crypto/tea.c	Thu Apr 21 23:19:18 2005
@@ -20,6 +20,7 @@
 #include <linux/mm.h>
 #include <asm/scatterlist.h>
 #include <linux/crypto.h>
+#include "helper.h"
 
 #define TEA_KEY_SIZE		16
 #define TEA_BLOCK_SIZE		8
@@ -31,9 +32,6 @@
 #define XTEA_ROUNDS		32
 #define XTEA_DELTA		0x9e3779b9
 
-#define u32_in(x) le32_to_cpu(*(const __le32 *)(x))
-#define u32_out(to, from) (*(__le32 *)(to) = cpu_to_le32(from))
-
 struct tea_ctx {
 	u32 KEY[4];
 };
@@ -45,7 +43,6 @@ struct xtea_ctx {
 static int tea_setkey(void *ctx_arg, const u8 *in_key,
                        unsigned int key_len, u32 *flags)
 { 
-
 	struct tea_ctx *ctx = ctx_arg;
 	
 	if (key_len != 16)
@@ -54,13 +51,12 @@ static int tea_setkey(void *ctx_arg, con
 		return -EINVAL;
 	}
 
-	ctx->KEY[0] = u32_in (in_key);
-	ctx->KEY[1] = u32_in (in_key + 4);
-	ctx->KEY[2] = u32_in (in_key + 8);
-	ctx->KEY[3] = u32_in (in_key + 12);
+	ctx->KEY[0] = load_le32(in_key,0);
+	ctx->KEY[1] = load_le32(in_key,1);
+	ctx->KEY[2] = load_le32(in_key,2);
+	ctx->KEY[3] = load_le32(in_key,3);
 
 	return 0; 
-
 }
 
 static void tea_encrypt(void *ctx_arg, u8 *dst, const u8 *src)
@@ -70,8 +66,8 @@ static void tea_encrypt(void *ctx_arg, u
 
 	struct tea_ctx *ctx = ctx_arg;
 
-	y = u32_in (src);
-	z = u32_in (src + 4);
+	y = load_le32(src,0);
+	z = load_le32(src,1);
 
 	k0 = ctx->KEY[0];
 	k1 = ctx->KEY[1];
@@ -86,8 +82,8 @@ static void tea_encrypt(void *ctx_arg, u
 		z += ((y << 4) + k2) ^ (y + sum) ^ ((y >> 5) + k3);
 	}
 	
-	u32_out (dst, y);
-	u32_out (dst + 4, z);
+	store_le32(dst,0, y);
+	store_le32(dst,1, z);
 }
 
 static void tea_decrypt(void *ctx_arg, u8 *dst, const u8 *src)
@@ -97,8 +93,8 @@ static void tea_decrypt(void *ctx_arg, u
 
 	struct tea_ctx *ctx = ctx_arg;
 
-	y = u32_in (src);
-	z = u32_in (src + 4);
+	y = load_le32(src,0);
+	z = load_le32(src,1);
 
 	k0 = ctx->KEY[0];
 	k1 = ctx->KEY[1];
@@ -115,15 +111,13 @@ static void tea_decrypt(void *ctx_arg, u
 		sum -= TEA_DELTA;
 	}
 	
-	u32_out (dst, y);
-	u32_out (dst + 4, z);
-
+	store_le32(dst,0, y);
+	store_le32(dst,1, z);
 }
 
 static int xtea_setkey(void *ctx_arg, const u8 *in_key,
                        unsigned int key_len, u32 *flags)
 { 
-
 	struct xtea_ctx *ctx = ctx_arg;
 	
 	if (key_len != 16)
@@ -132,13 +126,12 @@ static int xtea_setkey(void *ctx_arg, co
 		return -EINVAL;
 	}
 
-	ctx->KEY[0] = u32_in (in_key);
-	ctx->KEY[1] = u32_in (in_key + 4);
-	ctx->KEY[2] = u32_in (in_key + 8);
-	ctx->KEY[3] = u32_in (in_key + 12);
+	ctx->KEY[0] = load_le32(in_key,0);
+	ctx->KEY[1] = load_le32(in_key,1);
+	ctx->KEY[2] = load_le32(in_key,2);
+	ctx->KEY[3] = load_le32(in_key,3);
 
 	return 0; 
-
 }
 
 static void xtea_encrypt(void *ctx_arg, u8 *dst, const u8 *src)
@@ -149,8 +142,8 @@ static void xtea_encrypt(void *ctx_arg, 
 
 	struct xtea_ctx *ctx = ctx_arg;
 
-	y = u32_in (src);
-	z = u32_in (src + 4);
+	y = load_le32(src,0);
+	z = load_le32(src,1);
 
 	while (sum != limit) {
 		y += (z << 4 ^ z >> 5) + (z ^ sum) + ctx->KEY[sum&3]; 
@@ -158,19 +151,17 @@ static void xtea_encrypt(void *ctx_arg, 
 		z += (y << 4 ^ y >> 5) + (y ^ sum) + ctx->KEY[sum>>11 &3]; 
 	}
 	
-	u32_out (dst, y);
-	u32_out (dst + 4, z);
-
+	store_le32(dst,0, y);
+	store_le32(dst,1, z);
 }
 
 static void xtea_decrypt(void *ctx_arg, u8 *dst, const u8 *src)
 { 
-
 	u32 y, z, sum;
 	struct tea_ctx *ctx = ctx_arg;
 
-	y = u32_in (src);
-	z = u32_in (src + 4);
+	y = load_le32(src,0);
+	z = load_le32(src,1);
 
 	sum = XTEA_DELTA * XTEA_ROUNDS;
 
@@ -180,9 +171,8 @@ static void xtea_decrypt(void *ctx_arg, 
 		y -= (z << 4 ^ z >> 5) + (z ^ sum) + ctx->KEY[sum & 3];
 	}
 	
-	u32_out (dst, y);
-	u32_out (dst + 4, z);
-
+	store_le32(dst,0, y);
+	store_le32(dst,1, z);
 }
 
 static struct crypto_alg tea_alg = {
diff -urpN linux-2.6.12-rc2.0.orig/crypto/tgr192.c linux-2.6.12-rc2.1.be_le/crypto/tgr192.c
--- linux-2.6.12-rc2.0.orig/crypto/tgr192.c	Tue Apr 19 14:56:08 2005
+++ linux-2.6.12-rc2.1.be_le/crypto/tgr192.c	Thu Apr 21 23:20:22 2005
@@ -26,6 +26,7 @@
 #include <linux/mm.h>
 #include <asm/scatterlist.h>
 #include <linux/crypto.h>
+#include "helper.h"
 
 #define TGR192_DIGEST_SIZE 24
 #define TGR160_DIGEST_SIZE 20
@@ -467,17 +468,9 @@ static void tgr192_transform(struct tgr1
 	u64 a, b, c, aa, bb, cc;
 	u64 x[8];
 	int i;
-	const u8 *ptr = data;
 
-	for (i = 0; i < 8; i++, ptr += 8) {
-		x[i] = (((u64)ptr[7] ) << 56) ^
-		(((u64)ptr[6] & 0xffL) << 48) ^
-		(((u64)ptr[5] & 0xffL) << 40) ^
-		(((u64)ptr[4] & 0xffL) << 32) ^
-		(((u64)ptr[3] & 0xffL) << 24) ^
-		(((u64)ptr[2] & 0xffL) << 16) ^
-		(((u64)ptr[1] & 0xffL) <<  8) ^
-		(((u64)ptr[0] & 0xffL)      );
+	for (i = 0; i < 8; i++) {
+		x[i] = load_le64(data,i);
 	}
 
 	/* save */
@@ -559,8 +552,6 @@ static void tgr192_final(void *ctx, u8 *
 {
 	struct tgr192_ctx *tctx = ctx;
 	u32 t, msb, lsb;
-	u8 *p;
-	int i, j;
 
 	tgr192_update(tctx, NULL, 0); /* flush */ ;
 
@@ -594,41 +585,14 @@ static void tgr192_final(void *ctx, u8 *
 		memset(tctx->hash, 0, 56);    /* fill next block with zeroes */
 	}
 	/* append the 64 bit count */
-	tctx->hash[56] = lsb;
-	tctx->hash[57] = lsb >> 8;
-	tctx->hash[58] = lsb >> 16;
-	tctx->hash[59] = lsb >> 24;
-	tctx->hash[60] = msb;
-	tctx->hash[61] = msb >> 8;
-	tctx->hash[62] = msb >> 16;
-	tctx->hash[63] = msb >> 24;
+	store_le32(tctx->hash,56/4, lsb);
+	store_le32(tctx->hash,60/4, msb);
 	tgr192_transform(tctx, tctx->hash);
 
-	p = tctx->hash;
-	*p++ = tctx->a >> 56; *p++ = tctx->a >> 48; *p++ = tctx->a >> 40;
-	*p++ = tctx->a >> 32; *p++ = tctx->a >> 24; *p++ = tctx->a >> 16;
-	*p++ = tctx->a >>  8; *p++ = tctx->a;\
-	*p++ = tctx->b >> 56; *p++ = tctx->b >> 48; *p++ = tctx->b >> 40;
-	*p++ = tctx->b >> 32; *p++ = tctx->b >> 24; *p++ = tctx->b >> 16;
-	*p++ = tctx->b >>  8; *p++ = tctx->b;
-	*p++ = tctx->c >> 56; *p++ = tctx->c >> 48; *p++ = tctx->c >> 40;
-	*p++ = tctx->c >> 32; *p++ = tctx->c >> 24; *p++ = tctx->c >> 16;
-	*p++ = tctx->c >>  8; *p++ = tctx->c;
-
-
 	/* unpack the hash */
-	j = 7;
-	for (i = 0; i < 8; i++) {
-		out[j--] = (tctx->a >> 8 * i) & 0xff;
-	}
-	j = 15;
-	for (i = 0; i < 8; i++) {
-		out[j--] = (tctx->b >> 8 * i) & 0xff;
-	}
-	j = 23;
-	for (i = 0; i < 8; i++) {
-		out[j--] = (tctx->c >> 8 * i) & 0xff;
-	}
+	((__be64*)out)[0] = ((__be64*)tctx->hash)[0] = cpu_to_be64(tctx->a);
+	((__be64*)out)[1] = ((__be64*)tctx->hash)[1] = cpu_to_be64(tctx->b);
+	((__be64*)out)[2] = ((__be64*)tctx->hash)[2] = cpu_to_be64(tctx->c);
 }
 
 static void tgr160_final(void *ctx, u8 * out)
diff -urpN linux-2.6.12-rc2.0.orig/crypto/twofish.c linux-2.6.12-rc2.1.be_le/crypto/twofish.c
--- linux-2.6.12-rc2.0.orig/crypto/twofish.c	Tue Apr 19 14:56:08 2005
+++ linux-2.6.12-rc2.1.be_le/crypto/twofish.c	Thu Apr 21 23:27:42 2005
@@ -42,6 +42,7 @@
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/crypto.h>
+#include "helper.h"
 
 
 /* The large precomputed tables for the Twofish cipher (twofish.c)
@@ -540,9 +541,9 @@ static const u8 calc_sb_tbl[512] = {
 #define CALC_K(a, j, k, l, m, n) \
    x = CALC_K_2 (k, l, k, l, 0); \
    y = CALC_K_2 (m, n, m, n, 4); \
-   y = (y << 8) + (y >> 24); \
+   y = rol32(y, 8); \
    x += y; y += x; ctx->a[j] = x; \
-   ctx->a[(j) + 1] = (y << 9) + (y >> 23)
+   ctx->a[(j) + 1] = rol32(y, 9)
 
 #define CALC_K192_2(a, b, c, d, j) \
    CALC_K_2 (q0[a ^ key[(j) + 16]], \
@@ -553,9 +554,9 @@ static const u8 calc_sb_tbl[512] = {
 #define CALC_K192(a, j, k, l, m, n) \
    x = CALC_K192_2 (l, l, k, k, 0); \
    y = CALC_K192_2 (n, n, m, m, 4); \
-   y = (y << 8) + (y >> 24); \
+   y = rol32(y, 8); \
    x += y; y += x; ctx->a[j] = x; \
-   ctx->a[(j) + 1] = (y << 9) + (y >> 23)
+   ctx->a[(j) + 1] = rol32(y, 9)
 
 #define CALC_K256_2(a, b, j) \
    CALC_K192_2 (q1[b ^ key[(j) + 24]], \
@@ -566,9 +567,9 @@ static const u8 calc_sb_tbl[512] = {
 #define CALC_K256(a, j, k, l, m, n) \
    x = CALC_K256_2 (k, l, 0); \
    y = CALC_K256_2 (m, n, 4); \
-   y = (y << 8) + (y >> 24); \
+   y = rol32(y, 8); \
    x += y; y += x; ctx->a[j] = x; \
-   ctx->a[(j) + 1] = (y << 9) + (y >> 23)
+   ctx->a[(j) + 1] = rol32(y, 9)
 
 
 /* Macros to compute the g() function in the encryption and decryption
@@ -620,14 +621,14 @@ static const u8 calc_sb_tbl[512] = {
  * OUTUNPACK unpacks word number n from the variable named by x, using
  * whitening subkey number m. */
 
-#define INPACK(n, x, m) \
-   x = in[4 * (n)] ^ (in[4 * (n) + 1] << 8) \
-     ^ (in[4 * (n) + 2] << 16) ^ (in[4 * (n) + 3] << 24) ^ ctx->w[m]
+#define INPACK(n, x, m) { \
+   x = load_le32(in,n) ^ ctx->w[m]; \
+}
 
-#define OUTUNPACK(n, x, m) \
+#define OUTUNPACK(n, x, m) { \
    x ^= ctx->w[m]; \
-   out[4 * (n)] = x; out[4 * (n) + 1] = x >> 8; \
-   out[4 * (n) + 2] = x >> 16; out[4 * (n) + 3] = x >> 24
+   store_le32(out,n,x); \
+}
 
 #define TF_MIN_KEY_SIZE 16
 #define TF_MAX_KEY_SIZE 32
@@ -867,7 +868,6 @@ static void twofish_decrypt(void *cx, u8
 	OUTUNPACK (1, b, 1);
 	OUTUNPACK (2, c, 2);
 	OUTUNPACK (3, d, 3);
-
 }
 
 static struct crypto_alg alg = {
diff -urpN linux-2.6.12-rc2.0.orig/crypto/wp512.c linux-2.6.12-rc2.1.be_le/crypto/wp512.c
--- linux-2.6.12-rc2.0.orig/crypto/wp512.c	Tue Apr 19 14:56:08 2005
+++ linux-2.6.12-rc2.1.be_le/crypto/wp512.c	Thu Apr 21 23:21:24 2005
@@ -24,6 +24,7 @@
 #include <linux/mm.h>
 #include <asm/scatterlist.h>
 #include <linux/crypto.h>
+#include "helper.h"
 
 #define WP512_DIGEST_SIZE 64
 #define WP384_DIGEST_SIZE 48
@@ -778,18 +779,9 @@ static void wp512_process_buffer(struct 
 	u64 block[8];    /* mu(buffer) */
 	u64 state[8];    /* the cipher state */
 	u64 L[8];
-	u8 *buffer = wctx->buffer;
 
-	for (i = 0; i < 8; i++, buffer += 8) {
-		block[i] =
-		(((u64)buffer[0]        ) << 56) ^
-		(((u64)buffer[1] & 0xffL) << 48) ^
-		(((u64)buffer[2] & 0xffL) << 40) ^
-		(((u64)buffer[3] & 0xffL) << 32) ^
-		(((u64)buffer[4] & 0xffL) << 24) ^
-		(((u64)buffer[5] & 0xffL) << 16) ^
-		(((u64)buffer[6] & 0xffL) <<  8) ^
-		(((u64)buffer[7] & 0xffL)      );
+	for (i = 0; i < 8; i++) {
+		block[i] = load_be64(wctx->buffer,i);
 	}
 
 	state[0] = block[0] ^ (K[0] = wctx->hash[0]);
@@ -985,7 +977,6 @@ static void wp512_process_buffer(struct 
 	wctx->hash[5] ^= state[5] ^ block[5];
 	wctx->hash[6] ^= state[6] ^ block[6];
 	wctx->hash[7] ^= state[7] ^ block[7];
-
 }
 
 static void wp512_init (void *ctx) {
@@ -1058,7 +1049,6 @@ static void wp512_update(void *ctx, cons
 
 	wctx->bufferBits   = bufferBits;
 	wctx->bufferPos    = bufferPos;
-
 }
 
 static void wp512_final(void *ctx, u8 *out)
@@ -1069,7 +1059,6 @@ static void wp512_final(void *ctx, u8 *o
    	u8 *bitLength   = wctx->bitLength;
    	int bufferBits  = wctx->bufferBits;
    	int bufferPos   = wctx->bufferPos;
-   	u8 *digest      = out;
 
    	buffer[bufferPos] |= 0x80U >> (bufferBits & 7);
    	bufferPos++;
@@ -1089,15 +1078,7 @@ static void wp512_final(void *ctx, u8 *o
 		   bitLength, WP512_LENGTHBYTES);
    	wp512_process_buffer(wctx);
    	for (i = 0; i < WP512_DIGEST_SIZE/8; i++) {
-		digest[0] = (u8)(wctx->hash[i] >> 56);
-		digest[1] = (u8)(wctx->hash[i] >> 48);
-		digest[2] = (u8)(wctx->hash[i] >> 40);
-		digest[3] = (u8)(wctx->hash[i] >> 32);
-		digest[4] = (u8)(wctx->hash[i] >> 24);
-		digest[5] = (u8)(wctx->hash[i] >> 16);
-		digest[6] = (u8)(wctx->hash[i] >>  8);
-		digest[7] = (u8)(wctx->hash[i]      );
-		digest += 8;
+		store_be64(out,i, wctx->hash[i]);
    	}
    	wctx->bufferBits   = bufferBits;
    	wctx->bufferPos    = bufferPos;

--Boundary-00=_nrMaCdN0FLHMG7F--

