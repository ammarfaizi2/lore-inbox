Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262748AbUCKGK7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 01:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262753AbUCKGK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 01:10:59 -0500
Received: from dsl017-049-110.sfo4.dsl.speakeasy.net ([69.17.49.110]:4480 "EHLO
	jm.kir.nu") by vger.kernel.org with ESMTP id S262748AbUCKGKy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 01:10:54 -0500
Date: Wed, 10 Mar 2004 22:08:19 -0800
From: Jouni Malinen <jkmaline@cc.hut.fi>
To: James Morris <jmorris@redhat.com>
Cc: Clay Haapala <chaapala@cisco.com>, "David S. Miller" <davem@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Crypto API and keyed non-HMAC digest algorithms / Michael MIC
Message-ID: <20040311060818.GA3739@jm.kir.nu>
References: <20040311030035.GA3782@jm.kir.nu> <Xine.LNX.4.44.0403102302450.935-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0403102302450.935-100000@thoron.boston.redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2004 at 11:06:37PM -0500, James Morris wrote:

> I can't reproduce it now either (AFAICR, it oopsed in test_hash().  
> 
> I suspect it may have been caused by loading tcrypt module which was out
> of sync with the digest setkey change.

That's possible. It didn't fail in my test with an updated version from
the BK repository either, so I would assume this issue can be called
resolved.

Here's the digest setkey part of the previous combined patch; I'll send
a patch for Michael MIC separately.



Added support for using keyed digest with an optional dit_setkey handler.
This does not change the behavior of the existing digest algorithms, but
allows new ones to add setkey handler that can be used to initialize the
algorithm with a key or seed. setkey is to be called after init, but before
any of the update call(s).


diff -Nru a/crypto/digest.c b/crypto/digest.c
--- a/crypto/digest.c	Tue Mar  9 21:25:13 2004
+++ b/crypto/digest.c	Tue Mar  9 21:25:13 2004
@@ -42,6 +42,15 @@
 	tfm->__crt_alg->cra_digest.dia_final(crypto_tfm_ctx(tfm), out);
 }
 
+static int setkey(struct crypto_tfm *tfm, const u8 *key, unsigned int keylen)
+{
+	u32 flags;
+	if (tfm->__crt_alg->cra_digest.dia_setkey == NULL)
+		return -ENOSYS;
+	return tfm->__crt_alg->cra_digest.dia_setkey(crypto_tfm_ctx(tfm),
+						     key, keylen, &flags);
+}
+
 static void digest(struct crypto_tfm *tfm,
                    struct scatterlist *sg, unsigned int nsg, u8 *out)
 {
@@ -72,6 +81,7 @@
 	ops->dit_update	= update;
 	ops->dit_final	= final;
 	ops->dit_digest	= digest;
+	ops->dit_setkey	= setkey;
 	
 	return crypto_alloc_hmac_block(tfm);
 }
diff -Nru a/crypto/tcrypt.c b/crypto/tcrypt.c
--- a/crypto/tcrypt.c	Tue Mar  9 21:25:13 2004
+++ b/crypto/tcrypt.c	Tue Mar  9 21:25:13 2004
@@ -112,6 +112,10 @@
 		sg[0].length = hash_tv[i].psize;
 
 		crypto_digest_init (tfm);
+		if (tfm->crt_u.digest.dit_setkey) {
+			crypto_digest_setkey (tfm, hash_tv[i].key,
+					      hash_tv[i].ksize);
+		}
 		crypto_digest_update (tfm, sg, 1);
 		crypto_digest_final (tfm, result);
 
diff -Nru a/crypto/tcrypt.h b/crypto/tcrypt.h
--- a/crypto/tcrypt.h	Tue Mar  9 21:25:13 2004
+++ b/crypto/tcrypt.h	Tue Mar  9 21:25:13 2004
@@ -30,6 +30,8 @@
 	char digest[MAX_DIGEST_SIZE];
 	unsigned char np;
 	unsigned char tap[MAX_TAP];		
+	char key[128]; /* only used with keyed hash algorithms */
+	unsigned char ksize;
 };
 
 struct hmac_testvec {	
diff -Nru a/include/linux/crypto.h b/include/linux/crypto.h
--- a/include/linux/crypto.h	Tue Mar  9 21:25:13 2004
+++ b/include/linux/crypto.h	Tue Mar  9 21:25:13 2004
@@ -76,6 +76,8 @@
 	void (*dia_init)(void *ctx);
 	void (*dia_update)(void *ctx, const u8 *data, unsigned int len);
 	void (*dia_final)(void *ctx, u8 *out);
+	int (*dia_setkey)(void *ctx, const u8 *key,
+	                  unsigned int keylen, u32 *flags);
 };
 
 struct compress_alg {
@@ -157,6 +159,8 @@
 	void (*dit_final)(struct crypto_tfm *tfm, u8 *out);
 	void (*dit_digest)(struct crypto_tfm *tfm, struct scatterlist *sg,
 	                   unsigned int nsg, u8 *out);
+	int (*dit_setkey)(struct crypto_tfm *tfm,
+	                  const u8 *key, unsigned int keylen);
 #ifdef CONFIG_CRYPTO_HMAC
 	void *dit_hmac_block;
 #endif
@@ -280,6 +284,15 @@
 {
 	BUG_ON(crypto_tfm_alg_type(tfm) != CRYPTO_ALG_TYPE_DIGEST);
 	tfm->crt_digest.dit_digest(tfm, sg, nsg, out);
+}
+
+static inline int crypto_digest_setkey(struct crypto_tfm *tfm,
+                                       const u8 *key, unsigned int keylen)
+{
+	BUG_ON(crypto_tfm_alg_type(tfm) != CRYPTO_ALG_TYPE_DIGEST);
+	if (tfm->crt_digest.dit_setkey == NULL)
+		return -ENOSYS;
+	return tfm->crt_digest.dit_setkey(tfm, key, keylen);
 }
 
 static inline int crypto_cipher_setkey(struct crypto_tfm *tfm,


-- 
Jouni Malinen                                            PGP id EFC895FA
