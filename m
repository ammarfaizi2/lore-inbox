Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261539AbVDSOOm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbVDSOOm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 10:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbVDSOOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 10:14:42 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:51114 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261539AbVDSONK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 10:13:10 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Jesper Juhl <juhl-lkml@dif.dk>
Subject: Re: [PATCH] sha512: replace open-coded be64 conversions
Date: Tue, 19 Apr 2005 17:12:09 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, vital@ilport.com.ua
References: <200504190918.10279.vda@port.imtp.ilyichevsk.odessa.ua> <200504190921.34294.vda@port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.62.0504191102360.2480@dragon.hyggekrogen.localhost>
In-Reply-To: <Pine.LNX.4.62.0504191102360.2480@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504191712.09590.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 April 2005 12:04, Jesper Juhl wrote:
> On Tue, 19 Apr 2005, Denis Vlasenko wrote:
> 
> > This + next patch were "modprobe tcrypt" tested.
> > See next mail.
> 
> Could you please send patches inline instead of as attachments. 
> Attachments mean there's more work involved in getting at them to read 
> them, and they are a pain when you want to reply and quote the patch to 
> comment on it.
> Thanks.

I'm afraid Kmail tend to subtly mangle inlined patches.
Then people start to complain that patch does not apply, and rightly so. :(

However, I can try.

I noticed that there is many more open-coded cpu<->be and cpu<->le
conversions. This is a new patch on top of previous patchset.
Seems to pass tcrypt testing.

size:
   text    data     bss     dec     hex filename
   8156     108       0    8264    2048 crypto/anubis.o
   8256     108       0    8364    20ac crypto_orig/anubis.o
  14856     108       0   14964    3a74 crypto/cast5.o
  15242     108       0   15350    3bf6 crypto_orig/cast5.o
  16639     108       0   16747    416b crypto/cast6.o
  17297     108       0   17405    43fd crypto_orig/cast6.o
   9395     244       0    9639    25a7 crypto_orig/des.o
  17981     108       0   18089    46a9 crypto/khazad.o
  18334     108       0   18442    480a crypto_orig/khazad.o
    741     108       0     849     351 crypto/michael_mic.o
    908     108       0    1016     3f8 crypto_orig/michael_mic.o
    666     108       0     774     306 crypto/sha1.o
    739     108       0     847     34f crypto_orig/sha1.o
   9535     108       0    9643    25ab crypto/sha256.o
   9579     108       0    9687    25d7 crypto_orig/sha256.o
  10495     364       0   10859    2a6b crypto/tgr192.o
  10902     364       0   11266    2c02 crypto_orig/tgr192.o
  34114     108       0   34222    85ae crypto/twofish.o
  34290     108       0   34398    865e crypto_orig/twofish.o
  23735     364       0   24099    5e23 crypto/wp512.o
  23872     364       0   24236    5eac crypto_orig/wp512.o

BTW, twofish seems to be loop-unrolled far too much for sanity.
Any objections to reduce that? I have a patch in the works.
--
vda

diff -urpN linux-2.6.12-rc2.0.orig/crypto/aes.c linux-2.6.12-rc2.1.be_le/crypto/aes.c
--- linux-2.6.12-rc2.0.orig/crypto/aes.c	Tue Apr 19 14:56:09 2005
+++ linux-2.6.12-rc2.1.be_le/crypto/aes.c	Tue Apr 19 14:53:25 2005
@@ -448,4 +448,3 @@ module_exit(aes_fini);
 
 MODULE_DESCRIPTION("Rijndael (AES) Cipher Algorithm");
 MODULE_LICENSE("Dual BSD/GPL");
-
diff -urpN linux-2.6.12-rc2.0.orig/crypto/anubis.c linux-2.6.12-rc2.1.be_le/crypto/anubis.c
--- linux-2.6.12-rc2.0.orig/crypto/anubis.c	Tue Apr 19 14:56:09 2005
+++ linux-2.6.12-rc2.1.be_le/crypto/anubis.c	Tue Apr 19 15:29:53 2005
@@ -462,7 +462,7 @@ static int anubis_setkey(void *ctx_arg, 
 			 unsigned int key_len, u32 *flags)
 {
 
-	int N, R, i, pos, r;
+	int N, R, i, r;
 	u32 kappa[ANUBIS_MAX_N];
 	u32 inter[ANUBIS_MAX_N];
 
@@ -483,12 +483,8 @@ static int anubis_setkey(void *ctx_arg, 
 	ctx->R = R = 8 + N;
 
 	/* * map cipher key to initial key state (mu): */
-		for (i = 0, pos = 0; i < N; i++, pos += 4) {
-		kappa[i] =
-			(in_key[pos    ] << 24) ^
-			(in_key[pos + 1] << 16) ^
-			(in_key[pos + 2] <<  8) ^
-			(in_key[pos + 3]      );
+	for (i = 0; i < N; i++) {
+		kappa[i] = be32_to_cpu( ((__be32*)in_key)[i] );
 	}
 
 	/*
@@ -578,7 +574,7 @@ static int anubis_setkey(void *ctx_arg, 
 static void anubis_crypt(u32 roundKey[ANUBIS_MAX_ROUNDS + 1][4],
 		u8 *ciphertext, const u8 *plaintext, const int R)
 {
-	int i, pos, r;
+	int i;
 	u32 state[4];
 	u32 inter[4];
 
@@ -586,12 +582,8 @@ static void anubis_crypt(u32 roundKey[AN
 	 * map plaintext block to cipher state (mu)
 	 * and add initial round key (sigma[K^0]):
 	 */
-	for (i = 0, pos = 0; i < 4; i++, pos += 4) {
-		state[i] =
-			(plaintext[pos    ] << 24) ^
-			(plaintext[pos + 1] << 16) ^
-			(plaintext[pos + 2] <<  8) ^
-			(plaintext[pos + 3]      ) ^
+	for (i = 0; i < 4; i++) {
+		state[i] = __be32_to_cpu( ((__be32*)plaintext)[i] ) ^
 			roundKey[0][i];
 	}
 
@@ -599,31 +591,31 @@ static void anubis_crypt(u32 roundKey[AN
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
+		((__be32*)ciphertext)[i] = __cpu_to_be32(inter[i]);
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
diff -urpN linux-2.6.12-rc2.0.orig/crypto/cast5.c linux-2.6.12-rc2.1.be_le/crypto/cast5.c
--- linux-2.6.12-rc2.0.orig/crypto/cast5.c	Tue Apr 19 14:56:09 2005
+++ linux-2.6.12-rc2.1.be_le/crypto/cast5.c	Tue Apr 19 14:53:25 2005
@@ -589,8 +589,8 @@ static void cast5_encrypt(void *ctx, u8 
 	/* (L0,R0) <-- (m1...m64).  (Split the plaintext into left and
 	 * right 32-bit halves L0 = m1...m32 and R0 = m33...m64.)
 	 */
-	l = inbuf[0] << 24 | inbuf[1] << 16 | inbuf[2] << 8 | inbuf[3];
-	r = inbuf[4] << 24 | inbuf[5] << 16 | inbuf[6] << 8 | inbuf[7];
+	l = be32_to_cpu( ((__be32*)inbuf)[0] );
+	r = be32_to_cpu( ((__be32*)inbuf)[1] );
 
 	/* (16 rounds) for i from 1 to 16, compute Li and Ri as follows:
 	 *  Li = Ri-1;
@@ -634,14 +634,8 @@ static void cast5_encrypt(void *ctx, u8 
 
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
+	((__be32*)outbuf)[0] = cpu_to_be32(r);
+	((__be32*)outbuf)[1] = cpu_to_be32(l);
 }
 
 static void cast5_decrypt(void *ctx, u8 * outbuf, const u8 * inbuf)
@@ -655,8 +649,8 @@ static void cast5_decrypt(void *ctx, u8 
 	Km = c->Km;
 	Kr = c->Kr;
 
-	l = inbuf[0] << 24 | inbuf[1] << 16 | inbuf[2] << 8 | inbuf[3];
-	r = inbuf[4] << 24 | inbuf[5] << 16 | inbuf[6] << 8 | inbuf[7];
+	l = be32_to_cpu( ((__be32*)inbuf)[0] );
+	r = be32_to_cpu( ((__be32*)inbuf)[1] );
 
 	if (!(c->rr)) {
 		t = l; l = r; r = t ^ F1(r, Km[15], Kr[15]);
@@ -690,14 +684,8 @@ static void cast5_decrypt(void *ctx, u8 
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
+	((__be32*)outbuf)[0] = cpu_to_be32(r);
+	((__be32*)outbuf)[1] = cpu_to_be32(l);
 }
 
 static void key_schedule(u32 * x, u32 * z, u32 * k)
@@ -795,13 +783,10 @@ cast5_setkey(void *ctx, const u8 * key, 
 	memset(p_key, 0, 16);
 	memcpy(p_key, key, key_len);
 
-
-	x[0] = p_key[0] << 24 | p_key[1] << 16 | p_key[2] << 8 | p_key[3];
-	x[1] = p_key[4] << 24 | p_key[5] << 16 | p_key[6] << 8 | p_key[7];
-	x[2] =
-	    p_key[8] << 24 | p_key[9] << 16 | p_key[10] << 8 | p_key[11];
-	x[3] =
-	    p_key[12] << 24 | p_key[13] << 16 | p_key[14] << 8 | p_key[15];
+	x[0] = be32_to_cpu( ((__be32*)p_key)[0] );
+	x[1] = be32_to_cpu( ((__be32*)p_key)[1] );
+	x[2] = be32_to_cpu( ((__be32*)p_key)[2] );
+	x[3] = be32_to_cpu( ((__be32*)p_key)[3] );
 
 	key_schedule(x, z, k);
 	for (i = 0; i < 16; i++)
@@ -845,4 +830,3 @@ module_exit(fini);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Cast5 Cipher Algorithm");
-
diff -urpN linux-2.6.12-rc2.0.orig/crypto/cast6.c linux-2.6.12-rc2.1.be_le/crypto/cast6.c
--- linux-2.6.12-rc2.0.orig/crypto/cast6.c	Tue Apr 19 14:56:09 2005
+++ linux-2.6.12-rc2.1.be_le/crypto/cast6.c	Tue Apr 19 14:53:25 2005
@@ -395,16 +395,14 @@ cast6_setkey(void *ctx, const u8 * in_ke
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
+	key[0] = be32_to_cpu( ((__be32*)p_key)[0] );	/* A */
+	key[1] = be32_to_cpu( ((__be32*)p_key)[1] );	/* B */
+	key[2] = be32_to_cpu( ((__be32*)p_key)[2] );	/* C */
+	key[3] = be32_to_cpu( ((__be32*)p_key)[3] );	/* D */
+	key[4] = be32_to_cpu( ((__be32*)p_key)[4] );	/* E */
+	key[5] = be32_to_cpu( ((__be32*)p_key)[5] );	/* F */
+	key[6] = be32_to_cpu( ((__be32*)p_key)[6] );	/* G */
+	key[7] = be32_to_cpu( ((__be32*)p_key)[7] );	/* H */
 
 	for (i = 0; i < 12; i++) {
 		W (key, 2 * i);
@@ -448,10 +446,10 @@ static void cast6_encrypt (void * ctx, u
 	u32 * Km; 
 	u8 * Kr;
 
-	block[0] = inbuf[0] << 24 | inbuf[1] << 16 | inbuf[2] << 8 | inbuf[3];
-	block[1] = inbuf[4] << 24 | inbuf[5] << 16 | inbuf[6] << 8 | inbuf[7];
-	block[2] = inbuf[8] << 24 | inbuf[9] << 16 | inbuf[10] << 8 | inbuf[11];
-	block[3] = inbuf[12] << 24 | inbuf[13] << 16 | inbuf[14] << 8 | inbuf[15];
+	block[0] = be32_to_cpu( ((__be32*)inbuf)[0] );
+	block[1] = be32_to_cpu( ((__be32*)inbuf)[1] );
+	block[2] = be32_to_cpu( ((__be32*)inbuf)[2] );
+	block[3] = be32_to_cpu( ((__be32*)inbuf)[3] );
 
 	Km = c->Km[0]; Kr = c->Kr[0]; Q (block, Kr, Km);
 	Km = c->Km[1]; Kr = c->Kr[1]; Q (block, Kr, Km);
@@ -465,24 +463,12 @@ static void cast6_encrypt (void * ctx, u
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
+	((__be32*)outbuf)[0] = cpu_to_be32(block[0]);
+	((__be32*)outbuf)[1] = cpu_to_be32(block[1]);
+	((__be32*)outbuf)[2] = cpu_to_be32(block[2]);
+	((__be32*)outbuf)[3] = cpu_to_be32(block[3]);
+}
 
 static void cast6_decrypt (void * ctx, u8 * outbuf, const u8 * inbuf) {
 	struct cast6_ctx * c = (struct cast6_ctx *)ctx;
@@ -490,10 +476,10 @@ static void cast6_decrypt (void * ctx, u
 	u32 * Km; 
 	u8 * Kr;
 
-	block[0] = inbuf[0] << 24 | inbuf[1] << 16 | inbuf[2] << 8 | inbuf[3];
-	block[1] = inbuf[4] << 24 | inbuf[5] << 16 | inbuf[6] << 8 | inbuf[7];
-	block[2] = inbuf[8] << 24 | inbuf[9] << 16 | inbuf[10] << 8 | inbuf[11];
-	block[3] = inbuf[12] << 24 | inbuf[13] << 16 | inbuf[14] << 8 | inbuf[15];
+	block[0] = be32_to_cpu( ((__be32*)inbuf)[0] );
+	block[1] = be32_to_cpu( ((__be32*)inbuf)[1] );
+	block[2] = be32_to_cpu( ((__be32*)inbuf)[2] );
+	block[3] = be32_to_cpu( ((__be32*)inbuf)[3] );
 
 	Km = c->Km[11]; Kr = c->Kr[11]; Q (block, Kr, Km);
 	Km = c->Km[10]; Kr = c->Kr[10]; Q (block, Kr, Km);
@@ -507,24 +493,12 @@ static void cast6_decrypt (void * ctx, u
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
+	((__be32*)outbuf)[0] = cpu_to_be32(block[0]);
+	((__be32*)outbuf)[1] = cpu_to_be32(block[1]);
+	((__be32*)outbuf)[2] = cpu_to_be32(block[2]);
+	((__be32*)outbuf)[3] = cpu_to_be32(block[3]);
+}
 
 static struct crypto_alg alg = {
 	.cra_name = "cast6",
diff -urpN linux-2.6.12-rc2.0.orig/crypto/deflate.c linux-2.6.12-rc2.1.be_le/crypto/deflate.c
--- linux-2.6.12-rc2.0.orig/crypto/deflate.c	Tue Apr 19 14:56:09 2005
+++ linux-2.6.12-rc2.1.be_le/crypto/deflate.c	Tue Apr 19 14:53:25 2005
@@ -220,4 +220,3 @@ module_exit(fini);
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Deflate Compression Algorithm for IPCOMP");
 MODULE_AUTHOR("James Morris <jmorris@intercode.com.au>");
-
diff -urpN linux-2.6.12-rc2.0.orig/crypto/des.c linux-2.6.12-rc2.1.be_le/crypto/des.c
--- linux-2.6.12-rc2.0.orig/crypto/des.c	Tue Apr 19 14:56:09 2005
+++ linux-2.6.12-rc2.1.be_le/crypto/des.c	Tue Apr 19 16:32:14 2005
@@ -35,8 +35,6 @@
 #define DES3_EDE_EXPKEY_WORDS	(3 * DES_EXPKEY_WORDS)
 #define DES3_EDE_BLOCK_SIZE	DES_BLOCK_SIZE
 
-#define ROR(d,c,o)	((d) = (d) >> (c) | (d) << (o))
-
 struct des_ctx {
 	u8 iv[DES_BLOCK_SIZE];
 	u32 expkey[DES_EXPKEY_WORDS];
@@ -282,21 +280,10 @@ static const u8 parity[] = {
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
+	x  = le32_to_cpu( ((__le32*)src)[1] );
+	y  = le32_to_cpu( ((__le32*)src)[0] );
+
 	z  = ((x >> 004) ^ y) & 0x0F0F0F0FL;
 	x ^= z << 004;
 	y ^= z;
@@ -635,40 +622,18 @@ static void des_small_fips_encrypt(u32 *
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
+	((__le32*)dst)[0] = cpu_to_le32(x);
+	((__le32*)dst)[1] = cpu_to_le32(y);
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
+	x  = le32_to_cpu( ((__le32*)src)[1] );
+	y  = le32_to_cpu( ((__le32*)src)[0] );
+
 	z  = ((x >> 004) ^ y) & 0x0F0F0F0FL;
 	x ^= z << 004;
 	y ^= z;
@@ -1007,20 +972,9 @@ static void des_small_fips_decrypt(u32 *
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
+	((__le32*)dst)[0] = cpu_to_le32(x);
+	((__le32*)dst)[1] = cpu_to_le32(y);
 }
 
 /*
@@ -1159,9 +1113,7 @@ not_weak:
 		w  |= (b1[k[18+24]] | b0[k[19+24]]) << 4;
 		w  |= (b1[k[20+24]] | b0[k[21+24]]) << 2;
 		w  |=  b1[k[22+24]] | b0[k[23+24]];
-		
-		ROR(w, 4, 28);      /* could be eliminated */
-		expkey[1] = w;
+		expkey[1] = ror32(w, 4);	/* could be eliminated */
 
 		k += 48;
 		expkey += 2;
diff -urpN linux-2.6.12-rc2.0.orig/crypto/hmac.c linux-2.6.12-rc2.1.be_le/crypto/hmac.c
--- linux-2.6.12-rc2.0.orig/crypto/hmac.c	Tue Apr 19 14:56:09 2005
+++ linux-2.6.12-rc2.1.be_le/crypto/hmac.c	Tue Apr 19 14:53:25 2005
@@ -131,4 +131,3 @@ EXPORT_SYMBOL_GPL(crypto_hmac_init);
 EXPORT_SYMBOL_GPL(crypto_hmac_update);
 EXPORT_SYMBOL_GPL(crypto_hmac_final);
 EXPORT_SYMBOL_GPL(crypto_hmac);
-
diff -urpN linux-2.6.12-rc2.0.orig/crypto/internal.h linux-2.6.12-rc2.1.be_le/crypto/internal.h
--- linux-2.6.12-rc2.0.orig/crypto/internal.h	Tue Apr 19 14:56:09 2005
+++ linux-2.6.12-rc2.1.be_le/crypto/internal.h	Tue Apr 19 14:53:25 2005
@@ -89,4 +89,3 @@ void crypto_exit_cipher_ops(struct crypt
 void crypto_exit_compress_ops(struct crypto_tfm *tfm);
 
 #endif	/* _CRYPTO_INTERNAL_H */
-
diff -urpN linux-2.6.12-rc2.0.orig/crypto/khazad.c linux-2.6.12-rc2.1.be_le/crypto/khazad.c
--- linux-2.6.12-rc2.0.orig/crypto/khazad.c	Tue Apr 19 14:56:09 2005
+++ linux-2.6.12-rc2.1.be_le/crypto/khazad.c	Tue Apr 19 14:53:25 2005
@@ -767,22 +767,8 @@ static int khazad_setkey(void *ctx_arg, 
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
+	K2 = be64_to_cpu( ((__be64*)in_key)[0] );
+	K1 = be64_to_cpu( ((__be64*)in_key)[1] );
 
 	/* setup the encrypt key */
 	for (r = 0; r <= KHAZAD_ROUNDS; r++) {
@@ -814,7 +800,6 @@ static int khazad_setkey(void *ctx_arg, 
 	ctx->D[KHAZAD_ROUNDS] = ctx->E[0];
 
 	return 0;
-
 }
 
 static void khazad_crypt(const u64 roundKey[KHAZAD_ROUNDS + 1],
@@ -824,15 +809,7 @@ static void khazad_crypt(const u64 round
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
+	state = be64_to_cpu( ((__be64*)plaintext)[0] ) ^ roundKey[0];
 
 	for (r = 1; r < KHAZAD_ROUNDS; r++) {
 		state = T0[(int)(state >> 56)       ] ^
@@ -856,15 +833,7 @@ static void khazad_crypt(const u64 round
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
+	((__be64*)ciphertext)[0] = cpu_to_be64(state);
 }
 
 static void khazad_encrypt(void *ctx_arg, u8 *dst, const u8 *src)
@@ -906,7 +875,6 @@ static void __exit fini(void)
 {
 	crypto_unregister_alg(&khazad_alg);
 }
-
 
 module_init(init);
 module_exit(fini);
diff -urpN linux-2.6.12-rc2.0.orig/crypto/md4.c linux-2.6.12-rc2.1.be_le/crypto/md4.c
--- linux-2.6.12-rc2.0.orig/crypto/md4.c	Tue Apr 19 14:56:09 2005
+++ linux-2.6.12-rc2.1.be_le/crypto/md4.c	Tue Apr 19 14:53:25 2005
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
--- linux-2.6.12-rc2.0.orig/crypto/michael_mic.c	Tue Apr 19 14:56:09 2005
+++ linux-2.6.12-rc2.1.be_le/crypto/michael_mic.c	Tue Apr 19 14:53:25 2005
@@ -45,16 +45,13 @@ do {				\
 
 static inline u32 get_le32(const u8 *p)
 {
-	return p[0] | (p[1] << 8) | (p[2] << 16) | (p[3] << 24);
+	return le32_to_cpu( ((__le32*)p)[0] );
 }
 
 
 static inline void put_le32(u8 *p, u32 v)
 {
-	p[0] = v;
-	p[1] = v >> 8;
-	p[2] = v >> 16;
-	p[3] = v >> 24;
+	((__le32*)p)[0] = cpu_to_le32(v);
 }
 
 
diff -urpN linux-2.6.12-rc2.0.orig/crypto/sha1.c linux-2.6.12-rc2.1.be_le/crypto/sha1.c
--- linux-2.6.12-rc2.0.orig/crypto/sha1.c	Tue Apr 19 14:56:09 2005
+++ linux-2.6.12-rc2.1.be_le/crypto/sha1.c	Tue Apr 19 14:53:25 2005
@@ -67,25 +67,15 @@ static void sha1_update(void *ctx, const
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
+	((__be64*)bits)[0] = cpu_to_be64(sctx->count);
 
 	/* Pad out to 56 mod 64 */
 	index = (sctx->count >> 3) & 0x3f;
@@ -96,12 +86,8 @@ static void sha1_final(void* ctx, u8 *ou
 	sha1_update(sctx, bits, sizeof bits); 
 
 	/* Store state in digest */
-	for (i = j = 0; i < 5; i++, j += 4) {
-		u32 t2 = sctx->state[i];
-		out[j+3] = t2 & 0xff; t2>>=8;
-		out[j+2] = t2 & 0xff; t2>>=8;
-		out[j+1] = t2 & 0xff; t2>>=8;
-		out[j  ] = t2 & 0xff;
+	for (i = 0; i < 5; i++) {
+		((__be32*)out)[i] = cpu_to_be32(sctx->state[i]);
 	}
 
 	/* Wipe context */
diff -urpN linux-2.6.12-rc2.0.orig/crypto/sha256.c linux-2.6.12-rc2.1.be_le/crypto/sha256.c
--- linux-2.6.12-rc2.0.orig/crypto/sha256.c	Tue Apr 19 14:56:09 2005
+++ linux-2.6.12-rc2.1.be_le/crypto/sha256.c	Tue Apr 19 14:53:25 2005
@@ -280,21 +280,13 @@ static void sha256_final(void* ctx, u8 *
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
+	((__be32*)bits)[1] = cpu_to_be32(sctx->count[0]);
+	((__be32*)bits)[0] = cpu_to_be32(sctx->count[1]);
 
 	/* Pad out to 56 mod 64. */
 	index = (sctx->count[0] >> 3) & 0x3f;
@@ -305,18 +297,13 @@ static void sha256_final(void* ctx, u8 *
 	sha256_update(sctx, bits, 8);
 
 	/* Store state in digest */
-	for (i = j = 0; i < 8; i++, j += 4) {
-		t = sctx->state[i];
-		out[j+3] = t; t >>= 8;
-		out[j+2] = t; t >>= 8;
-		out[j+1] = t; t >>= 8;
-		out[j  ] = t;
+	for (i = 0; i < 8; i++) {
+		((__be32*)out)[i] = cpu_to_be32(sctx->state[i]);
 	}
 
 	/* Zeroize sensitive information. */
 	memset(sctx, 0, sizeof(*sctx));
 }
-
 
 static struct crypto_alg alg = {
 	.cra_name	=	"sha256",
diff -urpN linux-2.6.12-rc2.0.orig/crypto/tgr192.c linux-2.6.12-rc2.1.be_le/crypto/tgr192.c
--- linux-2.6.12-rc2.0.orig/crypto/tgr192.c	Tue Apr 19 14:56:09 2005
+++ linux-2.6.12-rc2.1.be_le/crypto/tgr192.c	Tue Apr 19 15:58:00 2005
@@ -467,17 +467,9 @@ static void tgr192_transform(struct tgr1
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
+		x[i] = le64_to_cpu( ((__le64*)data)[i] );
 	}
 
 	/* save */
@@ -559,8 +551,6 @@ static void tgr192_final(void *ctx, u8 *
 {
 	struct tgr192_ctx *tctx = ctx;
 	u32 t, msb, lsb;
-	u8 *p;
-	int i, j;
 
 	tgr192_update(tctx, NULL, 0); /* flush */ ;
 
@@ -594,41 +584,14 @@ static void tgr192_final(void *ctx, u8 *
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
+	((__le32*)tctx->hash)[56/4] = cpu_to_le32(lsb);
+	((__le32*)tctx->hash)[60/4] = cpu_to_le32(msb);
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
--- linux-2.6.12-rc2.0.orig/crypto/twofish.c	Tue Apr 19 14:56:09 2005
+++ linux-2.6.12-rc2.1.be_le/crypto/twofish.c	Tue Apr 19 16:32:42 2005
@@ -540,9 +540,9 @@ static const u8 calc_sb_tbl[512] = {
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
@@ -553,9 +553,9 @@ static const u8 calc_sb_tbl[512] = {
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
@@ -566,9 +566,9 @@ static const u8 calc_sb_tbl[512] = {
 #define CALC_K256(a, j, k, l, m, n) \
    x = CALC_K256_2 (k, l, 0); \
    y = CALC_K256_2 (m, n, 4); \
-   y = (y << 8) + (y >> 24); \
+   y = rol32(y, 8); \
    x += y; y += x; ctx->a[j] = x; \
-   ctx->a[(j) + 1] = (y << 9) + (y >> 23)
+   ctx->a[(j) + 1] = rol32(y, 9)
 
 
 /* Macros to compute the g() function in the encryption and decryption
@@ -621,13 +621,11 @@ static const u8 calc_sb_tbl[512] = {
  * whitening subkey number m. */
 
 #define INPACK(n, x, m) \
-   x = in[4 * (n)] ^ (in[4 * (n) + 1] << 8) \
-     ^ (in[4 * (n) + 2] << 16) ^ (in[4 * (n) + 3] << 24) ^ ctx->w[m]
+   x = le32_to_cpu( ((__le32*)in)[n] )
 
 #define OUTUNPACK(n, x, m) \
    x ^= ctx->w[m]; \
-   out[4 * (n)] = x; out[4 * (n) + 1] = x >> 8; \
-   out[4 * (n) + 2] = x >> 16; out[4 * (n) + 3] = x >> 24
+   ((__le32*)out)[n] = cpu_to_le32(x)
 
 #define TF_MIN_KEY_SIZE 16
 #define TF_MAX_KEY_SIZE 32
@@ -867,7 +865,6 @@ static void twofish_decrypt(void *cx, u8
 	OUTUNPACK (1, b, 1);
 	OUTUNPACK (2, c, 2);
 	OUTUNPACK (3, d, 3);
-
 }
 
 static struct crypto_alg alg = {
diff -urpN linux-2.6.12-rc2.0.orig/crypto/wp512.c linux-2.6.12-rc2.1.be_le/crypto/wp512.c
--- linux-2.6.12-rc2.0.orig/crypto/wp512.c	Tue Apr 19 14:56:09 2005
+++ linux-2.6.12-rc2.1.be_le/crypto/wp512.c	Tue Apr 19 16:40:12 2005
@@ -778,18 +778,10 @@ static void wp512_process_buffer(struct 
 	u64 block[8];    /* mu(buffer) */
 	u64 state[8];    /* the cipher state */
 	u64 L[8];
-	u8 *buffer = wctx->buffer;
+	//u8 *buffer = wctx->buffer;
 
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
+		block[i] = be64_to_cpu( ((__be64*)wctx->buffer)[i] );
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
@@ -1089,14 +1079,7 @@ static void wp512_final(void *ctx, u8 *o
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
+		((__be64*)digest)[0] = cpu_to_be64(wctx->hash[i]);
 		digest += 8;
    	}
    	wctx->bufferBits   = bufferBits;

