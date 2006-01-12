Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751445AbWALROs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbWALROs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 12:14:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbWALROs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 12:14:48 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:49837 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751445AbWALROr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 12:14:47 -0500
Date: Thu, 12 Jan 2006 18:14:18 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, jan.glauber@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 2/13] s390: des crypto code speedup.
Message-ID: <20060112171418.GC16629@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Glauber <jan.glauber@de.ibm.com>

[patch 2/13] s390: des crypto code speedup.

Provide ECB and CBC encrypt / decrypt functions to crypto API to speed up
our hardware accelerated DES implementation. This new functions allow the
crypto API to call ECB / CBC directly with large blocks in difference to the
old functions that were calles with algorithm block size (8 bytes for DES).

This is up to factor 10 faster then our old hardware implementation :)

Signed-off-by: Jan Glauber <jan.glauber@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

---

 arch/s390/crypto/des_s390.c |  217 ++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 210 insertions(+), 7 deletions(-)

diff -urpN linux-2.6/arch/s390/crypto/des_s390.c linux-2.6-patched/arch/s390/crypto/des_s390.c
--- linux-2.6/arch/s390/crypto/des_s390.c	2006-01-12 15:43:52.000000000 +0100
+++ linux-2.6-patched/arch/s390/crypto/des_s390.c	2006-01-12 15:43:52.000000000 +0100
@@ -57,18 +57,79 @@ static int des_setkey(void *ctx, const u
 	return ret;
 }
 
-static void des_encrypt(void *ctx, u8 *dst, const u8 *src)
+static void des_encrypt(void *ctx, u8 *out, const u8 *in)
 {
 	struct crypt_s390_des_ctx *dctx = ctx;
 
-	crypt_s390_km(KM_DEA_ENCRYPT, dctx->key, dst, src, DES_BLOCK_SIZE);
+	crypt_s390_km(KM_DEA_ENCRYPT, dctx->key, out, in, DES_BLOCK_SIZE);
 }
 
-static void des_decrypt(void *ctx, u8 *dst, const u8 *src)
+static void des_decrypt(void *ctx, u8 *out, const u8 *in)
 {
 	struct crypt_s390_des_ctx *dctx = ctx;
 
-	crypt_s390_km(KM_DEA_DECRYPT, dctx->key, dst, src, DES_BLOCK_SIZE);
+	crypt_s390_km(KM_DEA_DECRYPT, dctx->key, out, in, DES_BLOCK_SIZE);
+}
+
+static unsigned int des_encrypt_ecb(const struct cipher_desc *desc, u8 *out,
+				    const u8 *in, unsigned int nbytes)
+{
+	struct crypt_s390_des_ctx *sctx = crypto_tfm_ctx(desc->tfm);
+	int ret;
+
+	/* only use complete blocks */
+	nbytes &= ~(DES_BLOCK_SIZE - 1);
+	ret = crypt_s390_km(KM_DEA_ENCRYPT, sctx->key, out, in, nbytes);
+	BUG_ON((ret < 0) || (ret != nbytes));
+
+	return nbytes;
+}
+
+static unsigned int des_decrypt_ecb(const struct cipher_desc *desc, u8 *out,
+				    const u8 *in, unsigned int nbytes)
+{
+	struct crypt_s390_des_ctx *sctx = crypto_tfm_ctx(desc->tfm);
+	int ret;
+
+	/* only use complete blocks */
+	nbytes &= ~(DES_BLOCK_SIZE - 1);
+	ret = crypt_s390_km(KM_DEA_DECRYPT, sctx->key, out, in, nbytes);
+	BUG_ON((ret < 0) || (ret != nbytes));
+
+	return nbytes;
+}
+
+static unsigned int des_encrypt_cbc(const struct cipher_desc *desc, u8 *out,
+				    const u8 *in, unsigned int nbytes)
+{
+	struct crypt_s390_des_ctx *sctx = crypto_tfm_ctx(desc->tfm);
+	int ret;
+
+	/* only use complete blocks */
+	nbytes &= ~(DES_BLOCK_SIZE - 1);
+
+	memcpy(sctx->iv, desc->info, DES_BLOCK_SIZE);
+	ret = crypt_s390_kmc(KMC_DEA_ENCRYPT, &sctx->iv, out, in, nbytes);
+	BUG_ON((ret < 0) || (ret != nbytes));
+
+	memcpy(desc->info, sctx->iv, DES_BLOCK_SIZE);
+	return nbytes;
+}
+
+static unsigned int des_decrypt_cbc(const struct cipher_desc *desc, u8 *out,
+				    const u8 *in, unsigned int nbytes)
+{
+	struct crypt_s390_des_ctx *sctx = crypto_tfm_ctx(desc->tfm);
+	int ret;
+
+	/* only use complete blocks */
+	nbytes &= ~(DES_BLOCK_SIZE - 1);
+
+	memcpy(&sctx->iv, desc->info, DES_BLOCK_SIZE);
+	ret = crypt_s390_kmc(KMC_DEA_DECRYPT, &sctx->iv, out, in, nbytes);
+	BUG_ON((ret < 0) || (ret != nbytes));
+
+	return nbytes;
 }
 
 static struct crypto_alg des_alg = {
@@ -84,7 +145,11 @@ static struct crypto_alg des_alg = {
 			.cia_max_keysize	=	DES_KEY_SIZE,
 			.cia_setkey		=	des_setkey,
 			.cia_encrypt		=	des_encrypt,
-			.cia_decrypt		=	des_decrypt
+			.cia_decrypt		=	des_decrypt,
+			.cia_encrypt_ecb	=	des_encrypt_ecb,
+			.cia_decrypt_ecb	=	des_decrypt_ecb,
+			.cia_encrypt_cbc	=	des_encrypt_cbc,
+			.cia_decrypt_cbc	=	des_decrypt_cbc,
 		}
 	}
 };
@@ -137,6 +202,71 @@ static void des3_128_decrypt(void *ctx, 
 		      DES3_128_BLOCK_SIZE);
 }
 
+static unsigned int des3_128_encrypt_ecb(const struct cipher_desc *desc,
+					 u8 *out, const u8 *in,
+					 unsigned int nbytes)
+{
+	struct crypt_s390_des3_128_ctx *sctx = crypto_tfm_ctx(desc->tfm);
+	int ret;
+
+	/* only use complete blocks */
+	nbytes &= ~(DES3_128_BLOCK_SIZE - 1);
+	ret = crypt_s390_km(KM_TDEA_128_ENCRYPT, sctx->key, out, in, nbytes);
+	BUG_ON((ret < 0) || (ret != nbytes));
+
+	return nbytes;
+}
+
+static unsigned int des3_128_decrypt_ecb(const struct cipher_desc *desc,
+					 u8 *out, const u8 *in,
+					 unsigned int nbytes)
+{
+	struct crypt_s390_des3_128_ctx *sctx = crypto_tfm_ctx(desc->tfm);
+	int ret;
+
+	/* only use complete blocks */
+	nbytes &= ~(DES3_128_BLOCK_SIZE - 1);
+	ret = crypt_s390_km(KM_TDEA_128_DECRYPT, sctx->key, out, in, nbytes);
+	BUG_ON((ret < 0) || (ret != nbytes));
+
+	return nbytes;
+}
+
+static unsigned int des3_128_encrypt_cbc(const struct cipher_desc *desc,
+					 u8 *out, const u8 *in,
+					 unsigned int nbytes)
+{
+	struct crypt_s390_des3_128_ctx *sctx = crypto_tfm_ctx(desc->tfm);
+	int ret;
+
+	/* only use complete blocks */
+	nbytes &= ~(DES3_128_BLOCK_SIZE - 1);
+
+	memcpy(sctx->iv, desc->info, DES3_128_BLOCK_SIZE);
+	ret = crypt_s390_kmc(KMC_TDEA_128_ENCRYPT, &sctx->iv, out, in, nbytes);
+	BUG_ON((ret < 0) || (ret != nbytes));
+
+	memcpy(desc->info, sctx->iv, DES3_128_BLOCK_SIZE);
+	return nbytes;
+}
+
+static unsigned int des3_128_decrypt_cbc(const struct cipher_desc *desc,
+					 u8 *out, const u8 *in,
+					 unsigned int nbytes)
+{
+	struct crypt_s390_des3_128_ctx *sctx = crypto_tfm_ctx(desc->tfm);
+	int ret;
+
+	/* only use complete blocks */
+	nbytes &= ~(DES3_128_BLOCK_SIZE - 1);
+
+	memcpy(&sctx->iv, desc->info, DES3_128_BLOCK_SIZE);
+	ret = crypt_s390_kmc(KMC_TDEA_128_DECRYPT, &sctx->iv, out, in, nbytes);
+	BUG_ON((ret < 0) || (ret != nbytes));
+
+	return nbytes;
+}
+
 static struct crypto_alg des3_128_alg = {
 	.cra_name		=	"des3_ede128",
 	.cra_flags		=	CRYPTO_ALG_TYPE_CIPHER,
@@ -150,7 +280,11 @@ static struct crypto_alg des3_128_alg = 
 			.cia_max_keysize	=	DES3_128_KEY_SIZE,
 			.cia_setkey		=	des3_128_setkey,
 			.cia_encrypt		=	des3_128_encrypt,
-			.cia_decrypt		=	des3_128_decrypt
+			.cia_decrypt		=	des3_128_decrypt,
+			.cia_encrypt_ecb	=	des3_128_encrypt_ecb,
+			.cia_decrypt_ecb	=	des3_128_decrypt_ecb,
+			.cia_encrypt_cbc	=	des3_128_encrypt_cbc,
+			.cia_decrypt_cbc	=	des3_128_decrypt_cbc,
 		}
 	}
 };
@@ -207,6 +341,71 @@ static void des3_192_decrypt(void *ctx, 
 		      DES3_192_BLOCK_SIZE);
 }
 
+static unsigned int des3_192_encrypt_ecb(const struct cipher_desc *desc,
+					 u8 *out, const u8 *in,
+					 unsigned int nbytes)
+{
+	struct crypt_s390_des3_192_ctx *sctx = crypto_tfm_ctx(desc->tfm);
+	int ret;
+
+	/* only use complete blocks */
+	nbytes &= ~(DES3_192_BLOCK_SIZE - 1);
+	ret = crypt_s390_km(KM_TDEA_192_ENCRYPT, sctx->key, out, in, nbytes);
+	BUG_ON((ret < 0) || (ret != nbytes));
+
+	return nbytes;
+}
+
+static unsigned int des3_192_decrypt_ecb(const struct cipher_desc *desc,
+					 u8 *out, const u8 *in,
+					 unsigned int nbytes)
+{
+	struct crypt_s390_des3_192_ctx *sctx = crypto_tfm_ctx(desc->tfm);
+	int ret;
+
+	/* only use complete blocks */
+	nbytes &= ~(DES3_192_BLOCK_SIZE - 1);
+	ret = crypt_s390_km(KM_TDEA_192_DECRYPT, sctx->key, out, in, nbytes);
+	BUG_ON((ret < 0) || (ret != nbytes));
+
+	return nbytes;
+}
+
+static unsigned int des3_192_encrypt_cbc(const struct cipher_desc *desc,
+					 u8 *out, const u8 *in,
+					 unsigned int nbytes)
+{
+	struct crypt_s390_des3_192_ctx *sctx = crypto_tfm_ctx(desc->tfm);
+	int ret;
+
+	/* only use complete blocks */
+	nbytes &= ~(DES3_192_BLOCK_SIZE - 1);
+
+	memcpy(sctx->iv, desc->info, DES3_192_BLOCK_SIZE);
+	ret = crypt_s390_kmc(KMC_TDEA_192_ENCRYPT, &sctx->iv, out, in, nbytes);
+	BUG_ON((ret < 0) || (ret != nbytes));
+
+	memcpy(desc->info, sctx->iv, DES3_192_BLOCK_SIZE);
+	return nbytes;
+}
+
+static unsigned int des3_192_decrypt_cbc(const struct cipher_desc *desc,
+					 u8 *out, const u8 *in,
+					 unsigned int nbytes)
+{
+	struct crypt_s390_des3_192_ctx *sctx = crypto_tfm_ctx(desc->tfm);
+	int ret;
+
+	/* only use complete blocks */
+	nbytes &= ~(DES3_192_BLOCK_SIZE - 1);
+
+	memcpy(&sctx->iv, desc->info, DES3_192_BLOCK_SIZE);
+	ret = crypt_s390_kmc(KMC_TDEA_192_DECRYPT, &sctx->iv, out, in, nbytes);
+	BUG_ON((ret < 0) || (ret != nbytes));
+
+	return nbytes;
+}
+
 static struct crypto_alg des3_192_alg = {
 	.cra_name		=	"des3_ede",
 	.cra_flags		=	CRYPTO_ALG_TYPE_CIPHER,
@@ -220,7 +419,11 @@ static struct crypto_alg des3_192_alg = 
 			.cia_max_keysize	=	DES3_192_KEY_SIZE,
 			.cia_setkey		=	des3_192_setkey,
 			.cia_encrypt		=	des3_192_encrypt,
-			.cia_decrypt		=	des3_192_decrypt
+			.cia_decrypt		=	des3_192_decrypt,
+			.cia_encrypt_ecb	=	des3_192_encrypt_ecb,
+			.cia_decrypt_ecb	=	des3_192_decrypt_ecb,
+			.cia_encrypt_cbc	=	des3_192_encrypt_cbc,
+			.cia_decrypt_cbc	=	des3_192_decrypt_cbc,
 		}
 	}
 };
