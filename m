Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030505AbWHUOQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030505AbWHUOQO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 10:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030503AbWHUOQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 10:16:14 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:16646 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1030468AbWHUOQN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 10:16:13 -0400
Date: Tue, 22 Aug 2006 00:15:50 +1000
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2/2] [CRYPTO] api: Mark parts of cipher interface as deprecated
Message-ID: <20060821141549.GA26835@gondor.apana.org.au>
References: <20060815115200.GA14517@gondor.apana.org.au> <20060815115248.GA14552@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060815115248.GA14552@gondor.apana.org.au>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2006 at 09:52:48PM +1000, herbert wrote:
> 
> [CRYPTO] api: Mark parts of cipher interface as deprecated
> 
> Mark the parts of the cipher interface that have been replaced by
> block ciphers as deprecated.  Thanks to Andrew Morton for suggesting
> doing this before removing them completely.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

I've replaced it with the following patch which should actually work
with the geode aes patch.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
bf2ed06b30860493907cbdfd4da785f53d35acdf
diff --git a/crypto/cipher.c b/crypto/cipher.c
index 3264617..9e03701 100644
--- a/crypto/cipher.c
+++ b/crypto/cipher.c
@@ -23,6 +23,28 @@ #include <asm/scatterlist.h>
 #include "internal.h"
 #include "scatterwalk.h"
 
+struct cipher_alg_compat {
+	unsigned int cia_min_keysize;
+	unsigned int cia_max_keysize;
+	int (*cia_setkey)(struct crypto_tfm *tfm, const u8 *key,
+	                  unsigned int keylen);
+	void (*cia_encrypt)(struct crypto_tfm *tfm, u8 *dst, const u8 *src);
+	void (*cia_decrypt)(struct crypto_tfm *tfm, u8 *dst, const u8 *src);
+
+	unsigned int (*cia_encrypt_ecb)(const struct cipher_desc *desc,
+					u8 *dst, const u8 *src,
+					unsigned int nbytes);
+	unsigned int (*cia_decrypt_ecb)(const struct cipher_desc *desc,
+					u8 *dst, const u8 *src,
+					unsigned int nbytes);
+	unsigned int (*cia_encrypt_cbc)(const struct cipher_desc *desc,
+					u8 *dst, const u8 *src,
+					unsigned int nbytes);
+	unsigned int (*cia_decrypt_cbc)(const struct cipher_desc *desc,
+					u8 *dst, const u8 *src,
+					unsigned int nbytes);
+};
+
 static inline void xor_64(u8 *a, const u8 *b)
 {
 	((u32 *)a)[0] ^= ((u32 *)b)[0];
@@ -276,7 +298,7 @@ static int ecb_encrypt(struct crypto_tfm
                        struct scatterlist *src, unsigned int nbytes)
 {
 	struct cipher_desc desc;
-	struct cipher_alg *cipher = &tfm->__crt_alg->cra_cipher;
+	struct cipher_alg_compat *cipher = (void *)&tfm->__crt_alg->cra_cipher;
 
 	desc.tfm = tfm;
 	desc.crfn = cipher->cia_encrypt;
@@ -291,7 +313,7 @@ static int ecb_decrypt(struct crypto_tfm
 		       unsigned int nbytes)
 {
 	struct cipher_desc desc;
-	struct cipher_alg *cipher = &tfm->__crt_alg->cra_cipher;
+	struct cipher_alg_compat *cipher = (void *)&tfm->__crt_alg->cra_cipher;
 
 	desc.tfm = tfm;
 	desc.crfn = cipher->cia_decrypt;
@@ -306,7 +328,7 @@ static int cbc_encrypt(struct crypto_tfm
 		       unsigned int nbytes)
 {
 	struct cipher_desc desc;
-	struct cipher_alg *cipher = &tfm->__crt_alg->cra_cipher;
+	struct cipher_alg_compat *cipher = (void *)&tfm->__crt_alg->cra_cipher;
 
 	desc.tfm = tfm;
 	desc.crfn = cipher->cia_encrypt;
@@ -322,7 +344,7 @@ static int cbc_encrypt_iv(struct crypto_
                           unsigned int nbytes, u8 *iv)
 {
 	struct cipher_desc desc;
-	struct cipher_alg *cipher = &tfm->__crt_alg->cra_cipher;
+	struct cipher_alg_compat *cipher = (void *)&tfm->__crt_alg->cra_cipher;
 
 	desc.tfm = tfm;
 	desc.crfn = cipher->cia_encrypt;
@@ -338,7 +360,7 @@ static int cbc_decrypt(struct crypto_tfm
 		       unsigned int nbytes)
 {
 	struct cipher_desc desc;
-	struct cipher_alg *cipher = &tfm->__crt_alg->cra_cipher;
+	struct cipher_alg_compat *cipher = (void *)&tfm->__crt_alg->cra_cipher;
 
 	desc.tfm = tfm;
 	desc.crfn = cipher->cia_decrypt;
@@ -354,7 +376,7 @@ static int cbc_decrypt_iv(struct crypto_
                           unsigned int nbytes, u8 *iv)
 {
 	struct cipher_desc desc;
-	struct cipher_alg *cipher = &tfm->__crt_alg->cra_cipher;
+	struct cipher_alg_compat *cipher = (void *)&tfm->__crt_alg->cra_cipher;
 
 	desc.tfm = tfm;
 	desc.crfn = cipher->cia_decrypt;
diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index 5a5466d..0be666b 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -20,7 +20,6 @@ #define _LINUX_CRYPTO_H
 #include <asm/atomic.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/types.h>
 #include <linux/list.h>
 #include <linux/slab.h>
 #include <linux/string.h>
@@ -137,16 +136,16 @@ struct cipher_alg {
 
 	unsigned int (*cia_encrypt_ecb)(const struct cipher_desc *desc,
 					u8 *dst, const u8 *src,
-					unsigned int nbytes);
+					unsigned int nbytes) __deprecated;
 	unsigned int (*cia_decrypt_ecb)(const struct cipher_desc *desc,
 					u8 *dst, const u8 *src,
-					unsigned int nbytes);
+					unsigned int nbytes) __deprecated;
 	unsigned int (*cia_encrypt_cbc)(const struct cipher_desc *desc,
 					u8 *dst, const u8 *src,
-					unsigned int nbytes);
+					unsigned int nbytes) __deprecated;
 	unsigned int (*cia_decrypt_cbc)(const struct cipher_desc *desc,
 					u8 *dst, const u8 *src,
-					unsigned int nbytes);
+					unsigned int nbytes) __deprecated;
 };
 
 struct digest_alg {
@@ -358,18 +357,23 @@ static inline u32 crypto_tfm_alg_type(st
 	return tfm->__crt_alg->cra_flags & CRYPTO_ALG_TYPE_MASK;
 }
 
+static unsigned int crypto_tfm_alg_min_keysize(struct crypto_tfm *tfm)
+	__deprecated;
 static inline unsigned int crypto_tfm_alg_min_keysize(struct crypto_tfm *tfm)
 {
 	BUG_ON(crypto_tfm_alg_type(tfm) != CRYPTO_ALG_TYPE_CIPHER);
 	return tfm->__crt_alg->cra_cipher.cia_min_keysize;
 }
 
+static unsigned int crypto_tfm_alg_max_keysize(struct crypto_tfm *tfm)
+	__deprecated;
 static inline unsigned int crypto_tfm_alg_max_keysize(struct crypto_tfm *tfm)
 {
 	BUG_ON(crypto_tfm_alg_type(tfm) != CRYPTO_ALG_TYPE_CIPHER);
 	return tfm->__crt_alg->cra_cipher.cia_max_keysize;
 }
 
+static unsigned int crypto_tfm_alg_ivsize(struct crypto_tfm *tfm) __deprecated;
 static inline unsigned int crypto_tfm_alg_ivsize(struct crypto_tfm *tfm)
 {
 	BUG_ON(crypto_tfm_alg_type(tfm) != CRYPTO_ALG_TYPE_CIPHER);
@@ -622,6 +626,13 @@ static inline void crypto_cipher_clear_f
 	crypto_tfm_clear_flags(crypto_cipher_tfm(tfm), flags);
 }
 
+static inline int crypto_cipher_setkey(struct crypto_cipher *tfm,
+                                       const u8 *key, unsigned int keylen)
+{
+	return crypto_cipher_crt(tfm)->cit_setkey(crypto_cipher_tfm(tfm),
+						  key, keylen);
+}
+
 static inline void crypto_cipher_encrypt_one(struct crypto_cipher *tfm,
 					     u8 *dst, const u8 *src)
 {
@@ -671,13 +682,10 @@ static inline int crypto_digest_setkey(s
 	return tfm->crt_digest.dit_setkey(tfm, key, keylen);
 }
 
-static inline int crypto_cipher_setkey(struct crypto_tfm *tfm,
-                                       const u8 *key, unsigned int keylen)
-{
-	BUG_ON(crypto_tfm_alg_type(tfm) != CRYPTO_ALG_TYPE_CIPHER);
-	return tfm->crt_cipher.cit_setkey(tfm, key, keylen);
-}
-
+static int crypto_cipher_encrypt(struct crypto_tfm *tfm,
+				 struct scatterlist *dst,
+				 struct scatterlist *src,
+				 unsigned int nbytes) __deprecated;
 static inline int crypto_cipher_encrypt(struct crypto_tfm *tfm,
                                         struct scatterlist *dst,
                                         struct scatterlist *src,
@@ -687,6 +695,10 @@ static inline int crypto_cipher_encrypt(
 	return tfm->crt_cipher.cit_encrypt(tfm, dst, src, nbytes);
 }                                        
 
+static int crypto_cipher_encrypt_iv(struct crypto_tfm *tfm,
+				    struct scatterlist *dst,
+				    struct scatterlist *src,
+				    unsigned int nbytes, u8 *iv) __deprecated;
 static inline int crypto_cipher_encrypt_iv(struct crypto_tfm *tfm,
                                            struct scatterlist *dst,
                                            struct scatterlist *src,
@@ -696,6 +708,10 @@ static inline int crypto_cipher_encrypt_
 	return tfm->crt_cipher.cit_encrypt_iv(tfm, dst, src, nbytes, iv);
 }                                        
 
+static int crypto_cipher_decrypt(struct crypto_tfm *tfm,
+				 struct scatterlist *dst,
+				 struct scatterlist *src,
+				 unsigned int nbytes) __deprecated;
 static inline int crypto_cipher_decrypt(struct crypto_tfm *tfm,
                                         struct scatterlist *dst,
                                         struct scatterlist *src,
@@ -705,6 +721,10 @@ static inline int crypto_cipher_decrypt(
 	return tfm->crt_cipher.cit_decrypt(tfm, dst, src, nbytes);
 }
 
+static int crypto_cipher_decrypt_iv(struct crypto_tfm *tfm,
+				    struct scatterlist *dst,
+				    struct scatterlist *src,
+				    unsigned int nbytes, u8 *iv) __deprecated;
 static inline int crypto_cipher_decrypt_iv(struct crypto_tfm *tfm,
                                            struct scatterlist *dst,
                                            struct scatterlist *src,
@@ -714,6 +734,8 @@ static inline int crypto_cipher_decrypt_
 	return tfm->crt_cipher.cit_decrypt_iv(tfm, dst, src, nbytes, iv);
 }
 
+static void crypto_cipher_set_iv(struct crypto_tfm *tfm,
+				 const u8 *src, unsigned int len) __deprecated;
 static inline void crypto_cipher_set_iv(struct crypto_tfm *tfm,
                                         const u8 *src, unsigned int len)
 {
@@ -721,6 +743,8 @@ static inline void crypto_cipher_set_iv(
 	memcpy(tfm->crt_cipher.cit_iv, src, len);
 }
 
+static void crypto_cipher_get_iv(struct crypto_tfm *tfm,
+				 u8 *dst, unsigned int len) __deprecated;
 static inline void crypto_cipher_get_iv(struct crypto_tfm *tfm,
                                         u8 *dst, unsigned int len)
 {
