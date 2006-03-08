Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751058AbWCHHFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbWCHHFj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 02:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751862AbWCHHFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 02:05:39 -0500
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:20426 "EHLO
	topsns2.toshiba-tops.co.jp") by vger.kernel.org with ESMTP
	id S1751058AbWCHHFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 02:05:38 -0500
Date: Wed, 08 Mar 2006 16:05:29 +0900 (JST)
Message-Id: <20060308.160529.37994551.nemoto@toshiba-tops.co.jp>
To: linux-kernel@vger.kernel.org
Cc: herbert@gondor.apana.org.au, akpm@osdl.org
Subject: [PATCH] crypto: alignment fixes
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes some alignment problem on crypto modules.

1. Many cipher setkey functions load key words directly but the key
   words might not be aligned.  Enforce correct alignment in the
   setkey wrapper.
2. Some cipher modules lack cra_alignmask.
3. Some hash modules (and sha_transform() library function) load/store
   data words directly.  Use get_unaligned()/put_unaligned() for them.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

 crypto/cipher.c      |    7 +++++++
 crypto/des.c         |    1 +
 crypto/michael_mic.c |   11 ++++++-----
 crypto/serpent.c     |    1 +
 crypto/sha1.c        |    3 ++-
 crypto/sha256.c      |    3 ++-
 crypto/sha512.c      |    3 ++-
 crypto/tgr192.c      |   12 ++++++++----
 lib/sha1.c           |    3 ++-
 9 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/crypto/cipher.c b/crypto/cipher.c
index 65bcea0..5b72d91 100644
--- a/crypto/cipher.c
+++ b/crypto/cipher.c
@@ -263,10 +263,17 @@ static unsigned int ecb_process(const st
 static int setkey(struct crypto_tfm *tfm, const u8 *key, unsigned int keylen)
 {
 	struct cipher_alg *cia = &tfm->__crt_alg->cra_cipher;
+	unsigned long alignmask = crypto_tfm_alg_alignmask(tfm);
 	
 	if (keylen < cia->cia_min_keysize || keylen > cia->cia_max_keysize) {
 		tfm->crt_flags |= CRYPTO_TFM_RES_BAD_KEY_LEN;
 		return -EINVAL;
+	} else if ((unsigned long)key & alignmask) {
+		u8 stack[keylen + alignmask];
+		u8 *buf = (u8 *)ALIGN((unsigned long)stack, alignmask + 1);
+		memcpy(buf, key, keylen);
+		return cia->cia_setkey(crypto_tfm_ctx(tfm), buf, keylen,
+				       &tfm->crt_flags);
 	} else
 		return cia->cia_setkey(crypto_tfm_ctx(tfm), key, keylen,
 		                       &tfm->crt_flags);
diff --git a/crypto/des.c b/crypto/des.c
index 7bb5486..2d74cab 100644
--- a/crypto/des.c
+++ b/crypto/des.c
@@ -965,6 +965,7 @@ static struct crypto_alg des3_ede_alg = 
 	.cra_blocksize		=	DES3_EDE_BLOCK_SIZE,
 	.cra_ctxsize		=	sizeof(struct des3_ede_ctx),
 	.cra_module		=	THIS_MODULE,
+	.cra_alignmask		=	3,
 	.cra_list		=	LIST_HEAD_INIT(des3_ede_alg.cra_list),
 	.cra_u			=	{ .cipher = {
 	.cia_min_keysize	=	DES3_EDE_KEY_SIZE,
diff --git a/crypto/michael_mic.c b/crypto/michael_mic.c
index 4f6ab23..80dbe87 100644
--- a/crypto/michael_mic.c
+++ b/crypto/michael_mic.c
@@ -16,6 +16,7 @@
 #include <linux/string.h>
 #include <linux/crypto.h>
 #include <linux/types.h>
+#include <asm/unaligned.h>
 
 
 struct michael_mic_ctx {
@@ -78,7 +79,7 @@ static void michael_update(void *ctx, co
 	src = (const __le32 *)data;
 
 	while (len >= 4) {
-		mctx->l ^= le32_to_cpup(src++);
+		mctx->l ^= le32_to_cpu(get_unaligned(src++));
 		michael_block(mctx->l, mctx->r);
 		len -= 4;
 	}
@@ -116,8 +117,8 @@ static void michael_final(void *ctx, u8 
 	/* l ^= 0; */
 	michael_block(mctx->l, mctx->r);
 
-	dst[0] = cpu_to_le32(mctx->l);
-	dst[1] = cpu_to_le32(mctx->r);
+	put_unaligned(cpu_to_le32(mctx->l), &dst[0]);
+	put_unaligned(cpu_to_le32(mctx->r), &dst[1]);
 }
 
 
@@ -133,8 +134,8 @@ static int michael_setkey(void *ctx, con
 		return -EINVAL;
 	}
 
-	mctx->l = le32_to_cpu(data[0]);
-	mctx->r = le32_to_cpu(data[1]);
+	mctx->l = le32_to_cpu(get_unaligned(&data[0]));
+	mctx->r = le32_to_cpu(get_unaligned(&data[1]));
 	return 0;
 }
 
diff --git a/crypto/serpent.c b/crypto/serpent.c
index 52ad1a4..e366406 100644
--- a/crypto/serpent.c
+++ b/crypto/serpent.c
@@ -481,6 +481,7 @@ static struct crypto_alg serpent_alg = {
 	.cra_flags		=	CRYPTO_ALG_TYPE_CIPHER,
 	.cra_blocksize		=	SERPENT_BLOCK_SIZE,
 	.cra_ctxsize		=	sizeof(struct serpent_ctx),
+	.cra_alignmask		=	3,
 	.cra_module		=	THIS_MODULE,
 	.cra_list		=	LIST_HEAD_INIT(serpent_alg.cra_list),
 	.cra_u			=	{ .cipher = {
diff --git a/crypto/sha1.c b/crypto/sha1.c
index 21571ed..d84a006 100644
--- a/crypto/sha1.c
+++ b/crypto/sha1.c
@@ -24,6 +24,7 @@
 #include <linux/types.h>
 #include <asm/scatterlist.h>
 #include <asm/byteorder.h>
+#include <asm/unaligned.h>
 
 #define SHA1_DIGEST_SIZE	20
 #define SHA1_HMAC_BLOCK_SIZE	64
@@ -100,7 +101,7 @@ static void sha1_final(void* ctx, u8 *ou
 
 	/* Store state in digest */
 	for (i = 0; i < 5; i++)
-		dst[i] = cpu_to_be32(sctx->state[i]);
+		put_unaligned(cpu_to_be32(sctx->state[i]), &dst[i]);
 
 	/* Wipe context */
 	memset(sctx, 0, sizeof *sctx);
diff --git a/crypto/sha256.c b/crypto/sha256.c
index 9d5ef67..f497dde 100644
--- a/crypto/sha256.c
+++ b/crypto/sha256.c
@@ -23,6 +23,7 @@
 #include <linux/types.h>
 #include <asm/scatterlist.h>
 #include <asm/byteorder.h>
+#include <asm/unaligned.h>
 
 #define SHA256_DIGEST_SIZE	32
 #define SHA256_HMAC_BLOCK_SIZE	64
@@ -300,7 +301,7 @@ static void sha256_final(void* ctx, u8 *
 
 	/* Store state in digest */
 	for (i = 0; i < 8; i++)
-		dst[i] = cpu_to_be32(sctx->state[i]);
+		put_unaligned(cpu_to_be32(sctx->state[i]), &dst[i]);
 
 	/* Zeroize sensitive information. */
 	memset(sctx, 0, sizeof(*sctx));
diff --git a/crypto/sha512.c b/crypto/sha512.c
index 3e6e939..0208d2d 100644
--- a/crypto/sha512.c
+++ b/crypto/sha512.c
@@ -21,6 +21,7 @@
 
 #include <asm/scatterlist.h>
 #include <asm/byteorder.h>
+#include <asm/unaligned.h>
 
 #define SHA384_DIGEST_SIZE 48
 #define SHA512_DIGEST_SIZE 64
@@ -258,7 +259,7 @@ sha512_final(void *ctx, u8 *hash)
 
 	/* Store state in digest */
 	for (i = 0; i < 8; i++)
-		dst[i] = cpu_to_be64(sctx->state[i]);
+		put_unaligned(cpu_to_be64(sctx->state[i]), &dst[i]);
 
 	/* Zeroize sensitive information. */
 	memset(sctx, 0, sizeof(struct sha512_ctx));
diff --git a/crypto/tgr192.c b/crypto/tgr192.c
index 2d8e44f..bc2f314 100644
--- a/crypto/tgr192.c
+++ b/crypto/tgr192.c
@@ -28,6 +28,7 @@
 #include <asm/scatterlist.h>
 #include <linux/crypto.h>
 #include <linux/types.h>
+#include <asm/unaligned.h>
 
 #define TGR192_DIGEST_SIZE 24
 #define TGR160_DIGEST_SIZE 20
@@ -472,7 +473,7 @@ static void tgr192_transform(struct tgr1
 	const __le64 *ptr = (const __le64 *)data;
 
 	for (i = 0; i < 8; i++)
-		x[i] = le64_to_cpu(ptr[i]);
+		x[i] = le64_to_cpu(get_unaligned(ptr + i));
 
 	/* save */
 	a = aa = tctx->a;
@@ -596,9 +597,12 @@ static void tgr192_final(void *ctx, u8 *
 	tgr192_transform(tctx, tctx->hash);
 
 	be64p = (__be64 *)tctx->hash;
-	dst[0] = be64p[0] = cpu_to_be64(tctx->a);
-	dst[1] = be64p[1] = cpu_to_be64(tctx->b);
-	dst[2] = be64p[2] = cpu_to_be64(tctx->c);
+	be64p[0] = cpu_to_be64(tctx->a);
+	be64p[1] = cpu_to_be64(tctx->b);
+	be64p[2] = cpu_to_be64(tctx->c);
+	put_unaligned(be64p[0], &dst[0]);
+	put_unaligned(be64p[1], &dst[1]);
+	put_unaligned(be64p[2], &dst[2]);
 }
 
 static void tgr160_final(void *ctx, u8 * out)
diff --git a/lib/sha1.c b/lib/sha1.c
index 1cdabe3..4997950 100644
--- a/lib/sha1.c
+++ b/lib/sha1.c
@@ -6,6 +6,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/cryptohash.h>
+#include <asm/unaligned.h>
 
 /* The SHA f()-functions.  */
 
@@ -41,7 +42,7 @@ void sha_transform(__u32 *digest, const 
 	__u32 a, b, c, d, e, t, i;
 
 	for (i = 0; i < 16; i++)
-		W[i] = be32_to_cpu(((const __be32 *)in)[i]);
+		W[i] = be32_to_cpu(get_unaligned((const __be32 *)in + i));
 
 	for (i = 0; i < 64; i++)
 		W[i+16] = rol32(W[i+13] ^ W[i+8] ^ W[i+2] ^ W[i], 1);
