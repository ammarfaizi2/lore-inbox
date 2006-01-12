Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751432AbWALRPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbWALRPO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 12:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbWALRPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 12:15:13 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:59821 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751462AbWALROt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 12:14:49 -0500
Date: Thu, 12 Jan 2006 18:14:30 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, jan.glauber@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 3/13] s390: aes crypto code fixes.
Message-ID: <20060112171430.GD16629@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Glauber <jan.glauber@de.ibm.com>

[patch 3/13] s390: aes crypto code fixes.

Call KM[C] only with a multiple of block size.
Check return value of KM[C] instructions and complain about erros

Signed-off-by: Jan Glauber <jan.glauber@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

---

 arch/s390/crypto/aes_s390.c |   60 ++++++++++++++++++++++++++++++++------------
 1 files changed, 44 insertions(+), 16 deletions(-)

diff -urpN linux-2.6/arch/s390/crypto/aes_s390.c linux-2.6-patched/arch/s390/crypto/aes_s390.c
--- linux-2.6/arch/s390/crypto/aes_s390.c	2006-01-12 15:43:19.000000000 +0100
+++ linux-2.6-patched/arch/s390/crypto/aes_s390.c	2006-01-12 15:43:53.000000000 +0100
@@ -114,80 +114,108 @@ static unsigned int aes_encrypt_ecb(cons
 				    const u8 *in, unsigned int nbytes)
 {
 	struct s390_aes_ctx *sctx = crypto_tfm_ctx(desc->tfm);
+	int ret;
+
+	/* only use complete blocks */
+	nbytes &= ~(AES_BLOCK_SIZE - 1);
 
 	switch (sctx->key_len) {
 	case 16:
-		crypt_s390_km(KM_AES_128_ENCRYPT, &sctx->key, out, in, nbytes);
+		ret = crypt_s390_km(KM_AES_128_ENCRYPT, &sctx->key, out, in, nbytes);
+		BUG_ON((ret < 0) || (ret != nbytes));
 		break;
 	case 24:
-		crypt_s390_km(KM_AES_192_ENCRYPT, &sctx->key, out, in, nbytes);
+		ret = crypt_s390_km(KM_AES_192_ENCRYPT, &sctx->key, out, in, nbytes);
+		BUG_ON((ret < 0) || (ret != nbytes));
 		break;
 	case 32:
-		crypt_s390_km(KM_AES_256_ENCRYPT, &sctx->key, out, in, nbytes);
+		ret = crypt_s390_km(KM_AES_256_ENCRYPT, &sctx->key, out, in, nbytes);
+		BUG_ON((ret < 0) || (ret != nbytes));
 		break;
 	}
-	return nbytes & ~(AES_BLOCK_SIZE - 1);
+	return nbytes;
 }
 
 static unsigned int aes_decrypt_ecb(const struct cipher_desc *desc, u8 *out,
 				    const u8 *in, unsigned int nbytes)
 {
 	struct s390_aes_ctx *sctx = crypto_tfm_ctx(desc->tfm);
+	int ret;
+
+	/* only use complete blocks */
+	nbytes &= ~(AES_BLOCK_SIZE - 1);
 
 	switch (sctx->key_len) {
 	case 16:
-		crypt_s390_km(KM_AES_128_DECRYPT, &sctx->key, out, in, nbytes);
+		ret = crypt_s390_km(KM_AES_128_DECRYPT, &sctx->key, out, in, nbytes);
+		BUG_ON((ret < 0) || (ret != nbytes));
 		break;
 	case 24:
-		crypt_s390_km(KM_AES_192_DECRYPT, &sctx->key, out, in, nbytes);
+		ret = crypt_s390_km(KM_AES_192_DECRYPT, &sctx->key, out, in, nbytes);
+		BUG_ON((ret < 0) || (ret != nbytes));
 		break;
 	case 32:
-		crypt_s390_km(KM_AES_256_DECRYPT, &sctx->key, out, in, nbytes);
+		ret = crypt_s390_km(KM_AES_256_DECRYPT, &sctx->key, out, in, nbytes);
+		BUG_ON((ret < 0) || (ret != nbytes));
 		break;
 	}
-	return nbytes & ~(AES_BLOCK_SIZE - 1);
+	return nbytes;
 }
 
 static unsigned int aes_encrypt_cbc(const struct cipher_desc *desc, u8 *out,
 				    const u8 *in, unsigned int nbytes)
 {
 	struct s390_aes_ctx *sctx = crypto_tfm_ctx(desc->tfm);
+	int ret;
+
+	/* only use complete blocks */
+	nbytes &= ~(AES_BLOCK_SIZE - 1);
 
 	memcpy(&sctx->iv, desc->info, AES_BLOCK_SIZE);
 	switch (sctx->key_len) {
 	case 16:
-		crypt_s390_kmc(KMC_AES_128_ENCRYPT, &sctx->iv, out, in, nbytes);
+		ret = crypt_s390_kmc(KMC_AES_128_ENCRYPT, &sctx->iv, out, in, nbytes);
+		BUG_ON((ret < 0) || (ret != nbytes));
 		break;
 	case 24:
-		crypt_s390_kmc(KMC_AES_192_ENCRYPT, &sctx->iv, out, in, nbytes);
+		ret = crypt_s390_kmc(KMC_AES_192_ENCRYPT, &sctx->iv, out, in, nbytes);
+		BUG_ON((ret < 0) || (ret != nbytes));
 		break;
 	case 32:
-		crypt_s390_kmc(KMC_AES_256_ENCRYPT, &sctx->iv, out, in, nbytes);
+		ret = crypt_s390_kmc(KMC_AES_256_ENCRYPT, &sctx->iv, out, in, nbytes);
+		BUG_ON((ret < 0) || (ret != nbytes));
 		break;
 	}
 	memcpy(desc->info, &sctx->iv, AES_BLOCK_SIZE);
 
-	return nbytes & ~(AES_BLOCK_SIZE - 1);
+	return nbytes;
 }
 
 static unsigned int aes_decrypt_cbc(const struct cipher_desc *desc, u8 *out,
 				    const u8 *in, unsigned int nbytes)
 {
 	struct s390_aes_ctx *sctx = crypto_tfm_ctx(desc->tfm);
+	int ret;
+
+	/* only use complete blocks */
+	nbytes &= ~(AES_BLOCK_SIZE - 1);
 
 	memcpy(&sctx->iv, desc->info, AES_BLOCK_SIZE);
 	switch (sctx->key_len) {
 	case 16:
-		crypt_s390_kmc(KMC_AES_128_DECRYPT, &sctx->iv, out, in, nbytes);
+		ret = crypt_s390_kmc(KMC_AES_128_DECRYPT, &sctx->iv, out, in, nbytes);
+		BUG_ON((ret < 0) || (ret != nbytes));
 		break;
 	case 24:
-		crypt_s390_kmc(KMC_AES_192_DECRYPT, &sctx->iv, out, in, nbytes);
+		ret = crypt_s390_kmc(KMC_AES_192_DECRYPT, &sctx->iv, out, in, nbytes);
+		BUG_ON((ret < 0) || (ret != nbytes));
 		break;
 	case 32:
-		crypt_s390_kmc(KMC_AES_256_DECRYPT, &sctx->iv, out, in, nbytes);
+		ret = crypt_s390_kmc(KMC_AES_256_DECRYPT, &sctx->iv, out, in, nbytes);
+		BUG_ON((ret < 0) || (ret != nbytes));
 		break;
 	}
-	return nbytes & ~(AES_BLOCK_SIZE - 1);
+	return nbytes;
 }
 
 
