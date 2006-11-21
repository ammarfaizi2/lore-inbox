Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031355AbWKUTn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031355AbWKUTn0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 14:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031353AbWKUTn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 14:43:26 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:6153 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1031348AbWKUTnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 14:43:24 -0500
Date: Tue, 21 Nov 2006 20:43:24 +0100
From: Adrian Bunk <bunk@stusta.de>
To: herbert@gondor.apana.org.au
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: [2.6 patch] crypto/: remove unused functions
Message-ID: <20061121194324.GK5200@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the following no longer used functions:
- api.c: crypto_alg_available()
- digest.c: crypto_digest_init()
- digest.c: crypto_digest_update()
- digest.c: crypto_digest_final()
- digest.c: crypto_digest_digest()

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 crypto/api.c           |   15 ------------
 crypto/digest.c        |   48 -----------------------------------------
 include/linux/crypto.h |   22 ------------------
 3 files changed, 85 deletions(-)

--- linux-2.6.19-rc5-mm2/include/linux/crypto.h.old	2006-11-21 19:22:21.000000000 +0100
+++ linux-2.6.19-rc5-mm2/include/linux/crypto.h	2006-11-21 19:26:50.000000000 +0100
@@ -241,12 +241,8 @@
  * Algorithm query interface.
  */
 #ifdef CONFIG_CRYPTO
-int crypto_alg_available(const char *name, u32 flags)
-	__deprecated_for_modules;
 int crypto_has_alg(const char *name, u32 type, u32 mask);
 #else
-static int crypto_alg_available(const char *name, u32 flags)
-	__deprecated_for_modules;
 static inline int crypto_alg_available(const char *name, u32 flags)
 {
 	return 0;
@@ -707,16 +703,6 @@
 						dst, src);
 }
 
-void crypto_digest_init(struct crypto_tfm *tfm) __deprecated_for_modules;
-void crypto_digest_update(struct crypto_tfm *tfm,
-			  struct scatterlist *sg, unsigned int nsg)
-	__deprecated_for_modules;
-void crypto_digest_final(struct crypto_tfm *tfm, u8 *out)
-	__deprecated_for_modules;
-void crypto_digest_digest(struct crypto_tfm *tfm,
-			  struct scatterlist *sg, unsigned int nsg, u8 *out)
-	__deprecated_for_modules;
-
 static inline struct crypto_hash *__crypto_hash_cast(struct crypto_tfm *tfm)
 {
 	return (struct crypto_hash *)tfm;
@@ -729,14 +715,6 @@
 	return __crypto_hash_cast(tfm);
 }
 
-static int crypto_digest_setkey(struct crypto_tfm *tfm, const u8 *key,
-				unsigned int keylen) __deprecated;
-static inline int crypto_digest_setkey(struct crypto_tfm *tfm,
-                                       const u8 *key, unsigned int keylen)
-{
-	return tfm->crt_hash.setkey(crypto_hash_cast(tfm), key, keylen);
-}
-
 static inline struct crypto_hash *crypto_alloc_hash(const char *alg_name,
 						    u32 type, u32 mask)
 {
--- linux-2.6.19-rc5-mm2/crypto/api.c.old	2006-11-21 19:25:07.000000000 +0100
+++ linux-2.6.19-rc5-mm2/crypto/api.c	2006-11-21 19:25:35.000000000 +0100
@@ -466,23 +466,8 @@
 	kfree(tfm);
 }
 
-int crypto_alg_available(const char *name, u32 flags)
-{
-	int ret = 0;
-	struct crypto_alg *alg = crypto_alg_mod_lookup(name, 0,
-						       CRYPTO_ALG_ASYNC);
-	
-	if (!IS_ERR(alg)) {
-		crypto_mod_put(alg);
-		ret = 1;
-	}
-	
-	return ret;
-}
-
 EXPORT_SYMBOL_GPL(crypto_alloc_tfm);
 EXPORT_SYMBOL_GPL(crypto_free_tfm);
-EXPORT_SYMBOL_GPL(crypto_alg_available);
 
 int crypto_has_alg(const char *name, u32 type, u32 mask)
 {
--- linux-2.6.19-rc5-mm2/crypto/digest.c.old	2006-11-21 19:24:19.000000000 +0100
+++ linux-2.6.19-rc5-mm2/crypto/digest.c	2006-11-21 19:28:06.000000000 +0100
@@ -21,54 +21,6 @@
 #include "internal.h"
 #include "scatterwalk.h"
 
-void crypto_digest_init(struct crypto_tfm *tfm)
-{
-	struct crypto_hash *hash = crypto_hash_cast(tfm);
-	struct hash_desc desc = { .tfm = hash, .flags = tfm->crt_flags };
-
-	crypto_hash_init(&desc);
-}
-EXPORT_SYMBOL_GPL(crypto_digest_init);
-
-void crypto_digest_update(struct crypto_tfm *tfm,
-			  struct scatterlist *sg, unsigned int nsg)
-{
-	struct crypto_hash *hash = crypto_hash_cast(tfm);
-	struct hash_desc desc = { .tfm = hash, .flags = tfm->crt_flags };
-	unsigned int nbytes = 0;
-	unsigned int i;
-
-	for (i = 0; i < nsg; i++)
-		nbytes += sg[i].length;
-
-	crypto_hash_update(&desc, sg, nbytes);
-}
-EXPORT_SYMBOL_GPL(crypto_digest_update);
-
-void crypto_digest_final(struct crypto_tfm *tfm, u8 *out)
-{
-	struct crypto_hash *hash = crypto_hash_cast(tfm);
-	struct hash_desc desc = { .tfm = hash, .flags = tfm->crt_flags };
-
-	crypto_hash_final(&desc, out);
-}
-EXPORT_SYMBOL_GPL(crypto_digest_final);
-
-void crypto_digest_digest(struct crypto_tfm *tfm,
-			  struct scatterlist *sg, unsigned int nsg, u8 *out)
-{
-	struct crypto_hash *hash = crypto_hash_cast(tfm);
-	struct hash_desc desc = { .tfm = hash, .flags = tfm->crt_flags };
-	unsigned int nbytes = 0;
-	unsigned int i;
-
-	for (i = 0; i < nsg; i++)
-		nbytes += sg[i].length;
-
-	crypto_hash_digest(&desc, sg, nbytes, out);
-}
-EXPORT_SYMBOL_GPL(crypto_digest_digest);
-
 static int init(struct hash_desc *desc)
 {
 	struct crypto_tfm *tfm = crypto_hash_tfm(desc->tfm);

