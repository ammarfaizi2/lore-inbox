Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267384AbUBSRCy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 12:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267385AbUBSRCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 12:02:54 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:50093 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S267384AbUBSRCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 12:02:47 -0500
Date: Thu, 19 Feb 2004 18:02:32 +0100
From: Christophe Saout <christophe@saout.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH/proposal] dm-crypt: add digest-based iv generation mode
Message-ID: <20040219170228.GA10483@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

since some people keep complaining that the IV generation mechanisms
supplied in cryptoloop (and now dm-crypt) are insecure, which they
somewhat are, I just hacked a small digest based IV generation mechanism.

It simply hashes the sector number and the key and uses it as IV.

You can specify the encryption mode as "cipher-digest" like aes-md5 or
serpent-sha1 or some other combination.

Consider this as a proposal, I'm not a crypto expert. Tell me if it
contains other flaws that should be fixed.

At least the "cryptoloop-exploit" Jari Ruusu posted doesn't work anymore.


--- linux-2.6.3-mm1.orig/drivers/md/dm-crypt.c	2004-02-19 17:43:53.213856776 +0100
+++ linux-2.6.3-mm1/drivers/md/dm-crypt.c	2004-02-19 17:43:59.404915592 +0100
@@ -61,11 +61,13 @@
 	/*
 	 * crypto related data
 	 */
-	struct crypto_tfm *tfm;
+	struct crypto_tfm *cipher;
+	struct crypto_tfm *digest;
 	sector_t iv_offset;
 	int (*iv_generator)(struct crypt_config *cc, u8 *iv, sector_t sector);
 	int iv_size;
 	int key_size;
+	int digest_size;
 	u8 key[0];
 };
 
@@ -102,6 +104,35 @@
 	return 0;
 }
 
+static int crypt_iv_digest(struct crypt_config *cc, u8 *iv, sector_t sector)
+{
+	static DECLARE_MUTEX(tfm_mutex);
+	struct scatterlist sg[2] = {
+		{
+			.page = virt_to_page(iv),
+			.offset = offset_in_page(iv),
+			.length = sizeof(u64) / sizeof(u8)
+		}, {
+			.page = virt_to_page(cc->key),
+			.offset = offset_in_page(cc->key),
+			.length = cc->key_size
+		}
+	};
+	int i;
+
+	*(u64 *)iv = cpu_to_le64((u64)sector);
+
+	/* digests use the context in the tfm, sigh */
+	down(&tfm_mutex);
+	crypto_digest_digest(cc->digest, sg, 2, iv);
+	up(&tfm_mutex);
+
+	for(i = cc->digest_size; i < cc->iv_size; i += cc->digest_size)
+		memcpy(iv + i, iv, min(cc->digest_size, cc->iv_size - i));
+
+	return 0;
+}
+
 static inline int
 crypt_convert_scatterlist(struct crypt_config *cc, struct scatterlist *out,
                           struct scatterlist *in, unsigned int length,
@@ -116,14 +147,14 @@
 			return r;
 
 		if (write)
-			r = crypto_cipher_encrypt_iv(cc->tfm, out, in, length, iv);
+			r = crypto_cipher_encrypt_iv(cc->cipher, out, in, length, iv);
 		else
-			r = crypto_cipher_decrypt_iv(cc->tfm, out, in, length, iv);
+			r = crypto_cipher_decrypt_iv(cc->cipher, out, in, length, iv);
 	} else {
 		if (write)
-			r = crypto_cipher_encrypt(cc->tfm, out, in, length);
+			r = crypto_cipher_encrypt(cc->cipher, out, in, length);
 		else
-			r = crypto_cipher_decrypt(cc->tfm, out, in, length);
+			r = crypto_cipher_decrypt(cc->cipher, out, in, length);
 	}
 
 	return r;
@@ -436,13 +467,26 @@
 		return -ENOMEM;
 	}
 
+	cc->digest_size = 0;
+	cc->digest = NULL;
 	if (!mode || strcmp(mode, "plain") == 0)
 		cc->iv_generator = crypt_iv_plain;
 	else if (strcmp(mode, "ecb") == 0)
 		cc->iv_generator = NULL;
 	else {
-		ti->error = "dm-crypt: Invalid chaining mode";
-		goto bad1;
+		tfm = crypto_alloc_tfm(mode, 0);
+		if (!tfm) {
+			ti->error = "dm-crypt: Error allocating digest tfm";
+			goto bad1;
+		}
+		if (crypto_tfm_alg_type(tfm) != CRYPTO_ALG_TYPE_DIGEST) {
+			ti->error = "dm-crypt: Expected digest algorithm";
+			goto bad1;
+		}
+
+		cc->digest = tfm;
+		cc->digest_size = crypto_tfm_alg_digestsize(tfm);
+		cc->iv_generator = crypt_iv_digest;
 	}
 
 	if (cc->iv_generator)
@@ -455,12 +499,18 @@
 		ti->error = "dm-crypt: Error allocating crypto tfm";
 		goto bad1;
 	}
+	if (crypto_tfm_alg_type(tfm) != CRYPTO_ALG_TYPE_CIPHER) {
+		ti->error = "dm-crypt: Expected cipher algorithm";
+		goto bad1;
+	}
 
-	if (tfm->crt_u.cipher.cit_decrypt_iv && tfm->crt_u.cipher.cit_encrypt_iv)
-		/* at least a 32 bit sector number should fit in our buffer */
+	if (tfm->crt_u.cipher.cit_decrypt_iv &&
+	    tfm->crt_u.cipher.cit_encrypt_iv) {
+		/* at least a sector number should fit in our buffer */
 		cc->iv_size = max(crypto_tfm_alg_ivsize(tfm), 
-		                  (unsigned int)(sizeof(u32) / sizeof(u8)));
-	else {
+		                  (unsigned int)(sizeof(u64) / sizeof(u8)));
+		cc->iv_size = max(cc->iv_size, cc->digest_size);
+	} else {
 		cc->iv_size = 0;
 		if (cc->iv_generator) {
 			DMWARN("dm-crypt: Selected cipher does not support IVs");
@@ -482,7 +532,7 @@
 		goto bad3;
 	}
 
-	cc->tfm = tfm;
+	cc->cipher = tfm;
 	cc->key_size = key_size;
 	if ((key_size == 0 && strcmp(argv[1], "-") != 0)
 	    || crypt_decode_key(cc->key, argv[1], key_size) < 0) {
@@ -521,6 +571,8 @@
 bad2:
 	crypto_free_tfm(tfm);
 bad1:
+	if (cc->digest)
+		crypto_free_tfm(cc->digest);
 	kfree(cc);
 	return -EINVAL;
 }
@@ -532,7 +584,10 @@
 	mempool_destroy(cc->page_pool);
 	mempool_destroy(cc->io_pool);
 
-	crypto_free_tfm(cc->tfm);
+	crypto_free_tfm(cc->cipher);
+	if (cc->digest)
+		crypto_free_tfm(cc->digest);
+
 	dm_put_device(ti, cc->dev);
 	kfree(cc);
 }
@@ -680,11 +735,14 @@
 		break;
 
 	case STATUSTYPE_TABLE:
-		cipher = crypto_tfm_alg_name(cc->tfm);
+		cipher = crypto_tfm_alg_name(cc->cipher);
 
-		switch(cc->tfm->crt_u.cipher.cit_mode) {
+		switch(cc->cipher->crt_u.cipher.cit_mode) {
 		case CRYPTO_TFM_MODE_CBC:
-			mode = "plain";
+			if (cc->digest)
+				mode = crypto_tfm_alg_name(cc->digest);
+			else
+				mode = "plain";
 			break;
 		case CRYPTO_TFM_MODE_ECB:
 			mode = "ecb";
