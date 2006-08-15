Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030277AbWHOLwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030277AbWHOLwx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 07:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030280AbWHOLwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 07:52:53 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:3332 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1030277AbWHOLwv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 07:52:51 -0400
Date: Tue, 15 Aug 2006 21:52:48 +1000
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [2/2] [CRYPTO] api: Mark parts of cipher interface as deprecated
Message-ID: <20060815115248.GA14552@gondor.apana.org.au>
References: <20060815115200.GA14517@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060815115200.GA14517@gondor.apana.org.au>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

[CRYPTO] api: Mark parts of cipher interface as deprecated

Mark the parts of the cipher interface that have been replaced by
block ciphers as deprecated.  Thanks to Andrew Morton for suggesting
doing this before removing them completely.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
diff --git a/crypto/cipher.c b/crypto/cipher.c
--- a/crypto/cipher.c
+++ b/crypto/cipher.c
@@ -280,7 +280,7 @@ static int ecb_encrypt(struct crypto_tfm
 
 	desc.tfm = tfm;
 	desc.crfn = cipher->cia_encrypt;
-	desc.prfn = cipher->cia_encrypt_ecb ?: ecb_process;
+	desc.prfn = cipher->__cia_encrypt_ecb ?: ecb_process;
 
 	return crypt(&desc, dst, src, nbytes);
 }
@@ -295,7 +295,7 @@ static int ecb_decrypt(struct crypto_tfm
 
 	desc.tfm = tfm;
 	desc.crfn = cipher->cia_decrypt;
-	desc.prfn = cipher->cia_decrypt_ecb ?: ecb_process;
+	desc.prfn = cipher->__cia_decrypt_ecb ?: ecb_process;
 
 	return crypt(&desc, dst, src, nbytes);
 }
@@ -310,7 +310,7 @@ static int cbc_encrypt(struct crypto_tfm
 
 	desc.tfm = tfm;
 	desc.crfn = cipher->cia_encrypt;
-	desc.prfn = cipher->cia_encrypt_cbc ?: cbc_process_encrypt;
+	desc.prfn = cipher->__cia_encrypt_cbc ?: cbc_process_encrypt;
 	desc.info = tfm->crt_cipher.cit_iv;
 
 	return crypt(&desc, dst, src, nbytes);
@@ -326,7 +326,7 @@ static int cbc_encrypt_iv(struct crypto_
 
 	desc.tfm = tfm;
 	desc.crfn = cipher->cia_encrypt;
-	desc.prfn = cipher->cia_encrypt_cbc ?: cbc_process_encrypt;
+	desc.prfn = cipher->__cia_encrypt_cbc ?: cbc_process_encrypt;
 	desc.info = iv;
 
 	return crypt_iv_unaligned(&desc, dst, src, nbytes);
@@ -342,7 +342,7 @@ static int cbc_decrypt(struct crypto_tfm
 
 	desc.tfm = tfm;
 	desc.crfn = cipher->cia_decrypt;
-	desc.prfn = cipher->cia_decrypt_cbc ?: cbc_process_decrypt;
+	desc.prfn = cipher->__cia_decrypt_cbc ?: cbc_process_decrypt;
 	desc.info = tfm->crt_cipher.cit_iv;
 
 	return crypt(&desc, dst, src, nbytes);
@@ -358,7 +358,7 @@ static int cbc_decrypt_iv(struct crypto_
 
 	desc.tfm = tfm;
 	desc.crfn = cipher->cia_decrypt;
-	desc.prfn = cipher->cia_decrypt_cbc ?: cbc_process_decrypt;
+	desc.prfn = cipher->__cia_decrypt_cbc ?: cbc_process_decrypt;
 	desc.info = iv;
 
 	return crypt_iv_unaligned(&desc, dst, src, nbytes);
diff --git a/include/linux/crypto.h b/include/linux/crypto.h
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -20,7 +20,6 @@
 #include <asm/atomic.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/types.h>
 #include <linux/list.h>
 #include <linux/slab.h>
 #include <linux/string.h>
@@ -123,18 +122,42 @@ struct cipher_alg {
 	void (*cia_encrypt)(struct crypto_tfm *tfm, u8 *dst, const u8 *src);
 	void (*cia_decrypt)(struct crypto_tfm *tfm, u8 *dst, const u8 *src);
 
-	unsigned int (*cia_encrypt_ecb)(const struct cipher_desc *desc,
-					u8 *dst, const u8 *src,
-					unsigned int nbytes);
-	unsigned int (*cia_decrypt_ecb)(const struct cipher_desc *desc,
-					u8 *dst, const u8 *src,
-					unsigned int nbytes);
-	unsigned int (*cia_encrypt_cbc)(const struct cipher_desc *desc,
-					u8 *dst, const u8 *src,
-					unsigned int nbytes);
-	unsigned int (*cia_decrypt_cbc)(const struct cipher_desc *desc,
-					u8 *dst, const u8 *src,
-					unsigned int nbytes);
+	union {
+		unsigned int (*cia_encrypt_ecb)(const struct cipher_desc *desc,
+						u8 *dst, const u8 *src,
+						unsigned int nbytes)
+			__deprecated;
+		unsigned int (*__cia_encrypt_ecb)(
+			const struct cipher_desc *desc,
+			u8 *dst, const u8 *src, unsigned int nbytes);
+	};
+	union {
+		unsigned int (*cia_decrypt_ecb)(const struct cipher_desc *desc,
+						u8 *dst, const u8 *src,
+						unsigned int nbytes)
+			__deprecated;
+		unsigned int (*__cia_decrypt_ecb)(
+			const struct cipher_desc *desc,
+			u8 *dst, const u8 *src, unsigned int nbytes);
+	};
+	union {
+		unsigned int (*cia_encrypt_cbc)(const struct cipher_desc *desc,
+						u8 *dst, const u8 *src,
+						unsigned int nbytes)
+			__deprecated;
+		unsigned int (*__cia_encrypt_cbc)(
+			const struct cipher_desc *desc,
+			u8 *dst, const u8 *src, unsigned int nbytes);
+	};
+	union {
+		unsigned int (*cia_decrypt_cbc)(const struct cipher_desc *desc,
+						u8 *dst, const u8 *src,
+						unsigned int nbytes)
+			__deprecated;
+		unsigned int (*__cia_decrypt_cbc)(
+			const struct cipher_desc *desc,
+			u8 *dst, const u8 *src, unsigned int nbytes);
+	};
 };
 
 struct digest_alg {
@@ -346,18 +369,23 @@ static inline u32 crypto_tfm_alg_type(st
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
@@ -610,6 +638,13 @@ static inline void crypto_cipher_clear_f
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
@@ -659,13 +694,10 @@ static inline int crypto_digest_setkey(s
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
@@ -675,6 +707,10 @@ static inline int crypto_cipher_encrypt(
 	return tfm->crt_cipher.cit_encrypt(tfm, dst, src, nbytes);
 }                                        
 
+static int crypto_cipher_encrypt_iv(struct crypto_tfm *tfm,
+				    struct scatterlist *dst,
+				    struct scatterlist *src,
+				    unsigned int nbytes, u8 *iv) __deprecated;
 static inline int crypto_cipher_encrypt_iv(struct crypto_tfm *tfm,
                                            struct scatterlist *dst,
                                            struct scatterlist *src,
@@ -684,6 +720,10 @@ static inline int crypto_cipher_encrypt_
 	return tfm->crt_cipher.cit_encrypt_iv(tfm, dst, src, nbytes, iv);
 }                                        
 
+static int crypto_cipher_decrypt(struct crypto_tfm *tfm,
+				 struct scatterlist *dst,
+				 struct scatterlist *src,
+				 unsigned int nbytes) __deprecated;
 static inline int crypto_cipher_decrypt(struct crypto_tfm *tfm,
                                         struct scatterlist *dst,
                                         struct scatterlist *src,
@@ -693,6 +733,10 @@ static inline int crypto_cipher_decrypt(
 	return tfm->crt_cipher.cit_decrypt(tfm, dst, src, nbytes);
 }
 
+static int crypto_cipher_decrypt_iv(struct crypto_tfm *tfm,
+				    struct scatterlist *dst,
+				    struct scatterlist *src,
+				    unsigned int nbytes, u8 *iv) __deprecated;
 static inline int crypto_cipher_decrypt_iv(struct crypto_tfm *tfm,
                                            struct scatterlist *dst,
                                            struct scatterlist *src,
@@ -702,6 +746,8 @@ static inline int crypto_cipher_decrypt_
 	return tfm->crt_cipher.cit_decrypt_iv(tfm, dst, src, nbytes, iv);
 }
 
+static void crypto_cipher_set_iv(struct crypto_tfm *tfm,
+				 const u8 *src, unsigned int len) __deprecated;
 static inline void crypto_cipher_set_iv(struct crypto_tfm *tfm,
                                         const u8 *src, unsigned int len)
 {
@@ -709,6 +755,8 @@ static inline void crypto_cipher_set_iv(
 	memcpy(tfm->crt_cipher.cit_iv, src, len);
 }
 
+static void crypto_cipher_get_iv(struct crypto_tfm *tfm,
+				 u8 *dst, unsigned int len) __deprecated;
 static inline void crypto_cipher_get_iv(struct crypto_tfm *tfm,
                                         u8 *dst, unsigned int len)
 {
