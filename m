Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbUBUCRw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 21:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbUBUCRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 21:17:51 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:8417 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S261479AbUBUCRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 21:17:23 -0500
Date: Sat, 21 Feb 2004 03:17:25 +0100
From: Christophe Saout <christophe@saout.de>
To: Jean-Luc Cooke <jlcooke@certainkey.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/proposal] dm-crypt: add digest-based iv generation mode
Message-ID: <20040221021724.GA8841@leto.cs.pocnet.net>
References: <20040219170228.GA10483@leto.cs.pocnet.net> <20040219111835.192d2741.akpm@osdl.org> <20040220171427.GD9266@certainkey.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040220171427.GD9266@certainkey.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 20, 2004 at 12:14:27PM -0500, Jean-Luc Cooke wrote:

> As for naming the cipher-hash as "aes-sha256", why not just go all the way
> and specify the mode of operation as well?
> 
> cipher-hash-modeop example: aes-sha256-cbc

cipher-modeop[-hash] is less ambiguous, because the hash-less config is
the backward-compatible mode (and for Kamikaze ECB mode).

> As for hashing the hey etc.  You should be using HMAC for that.

Ok, I've rewritten it so you can now generate an IV through HMAC with
a user-specified digest and changed the config string to
<cipher>-<mode>[-<digest>].

And I'm memcpy'ing the tfm onto the stack now to have a local copy.
So I don't need to lock and it makes HMAC precomputation possible
because I don't destroy the original tfm context.

(this is a diff against the original dm-crypt version in linux-2.6.3-mm1)


diff -Nur linux-2.6.3-mm1.orig/drivers/md/dm-crypt.c linux-2.6.3-mm1/drivers/md/dm-crypt.c
--- linux-2.6.3-mm1.orig/drivers/md/dm-crypt.c	2004-02-21 03:05:21.444341304 +0100
+++ linux-2.6.3-mm1/drivers/md/dm-crypt.c	2004-02-21 03:05:44.070901544 +0100
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
 
@@ -102,6 +104,32 @@
 	return 0;
 }
 
+static int crypt_iv_hmac(struct crypt_config *cc, u8 *iv, sector_t sector)
+{
+	struct scatterlist sg = {
+		.page = virt_to_page(iv),
+		.offset = offset_in_page(iv),
+		.length = sizeof(u64) / sizeof(u8)
+	};
+	int i;
+	int tfm_size = sizeof(*cc->digest) + cc->digest->__crt_alg->cra_ctxsize;
+	char tfm[tfm_size];
+
+	*(u64 *)iv = cpu_to_le64((u64)sector);
+
+	/* HMAC has already been initialized, finish it on private copy */
+	memcpy(tfm, cc->digest, tfm_size);
+	crypto_hmac_update(cc->digest, &sg, 1);
+	crypto_hmac_final(cc->digest, cc->key,
+	                  (unsigned int *)&cc->key_size, iv);
+
+	/* fill the rest of the vector if it is larger */
+	for(i = cc->digest_size; i < cc->iv_size; i += cc->digest_size)
+		memcpy(iv + i, iv, min(cc->digest_size, cc->iv_size - i));
+
+	return 0;
+}
+
 static inline int
 crypt_convert_scatterlist(struct crypt_config *cc, struct scatterlist *out,
                           struct scatterlist *in, unsigned int length,
@@ -116,14 +144,14 @@
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
@@ -401,6 +429,17 @@
 	}
 }
 
+static struct cipher_mode {
+	const char	*name;
+	int			mode;
+} cipher_modes[] = {
+	{ "ecb", CRYPTO_TFM_MODE_ECB },
+	{ "cbc", CRYPTO_TFM_MODE_CBC },
+	{ "cfb", CRYPTO_TFM_MODE_CFB },
+	{ "ctr", CRYPTO_TFM_MODE_CTR },
+	{ NULL,  0 }
+};
+
 /*
  * Construct an encryption mapping:
  * <cipher> <key> <iv_offset> <dev_path> <start>
@@ -412,6 +451,7 @@
 	char *tmp;
 	char *cipher;
 	char *mode;
+	char *digest;
 	int crypto_flags;
 	int key_size;
 
@@ -423,10 +463,32 @@
 	tmp = argv[0];
 	cipher = strsep(&tmp, "-");
 	mode = strsep(&tmp, "-");
+	digest = strsep(&tmp, "-");
 
 	if (tmp)
 		DMWARN("dm-crypt: Unexpected additional cipher options");
 
+	if (mode) {
+		struct cipher_mode *cm;
+
+		for(cm = cipher_modes; cm->name; cm++)
+			if (strcmp(cm->name, mode) == 0)
+				break;
+		if (!cm->name) {
+			ti->error = "dm-crypt: Invalid cipher mode";
+			return -EINVAL;
+		}
+
+		crypto_flags = cm->mode;
+	} else {
+		crypto_flags = CRYPTO_TFM_MODE_CBC;
+	}
+
+	if (crypto_flags == CRYPTO_TFM_MODE_ECB && digest) {
+		ti->error = "dm-crypt: ECB does not support IVs";
+		return -EINVAL;
+	}
+
 	key_size = strlen(argv[1]) >> 1;
 
 	cc = kmalloc(sizeof(*cc) + key_size * sizeof(u8), GFP_KERNEL);
@@ -436,40 +498,55 @@
 		return -ENOMEM;
 	}
 
-	if (!mode || strcmp(mode, "plain") == 0)
-		cc->iv_generator = crypt_iv_plain;
-	else if (strcmp(mode, "ecb") == 0)
+	cc->digest_size = 0;
+	cc->digest = NULL;
+	if (crypto_flags == CRYPTO_TFM_MODE_ECB)
 		cc->iv_generator = NULL;
+	else if (!digest)
+		cc->iv_generator = crypt_iv_plain;
 	else {
-		ti->error = "dm-crypt: Invalid chaining mode";
-		goto bad1;
-	}
+		/* the IV generator is the name of a digest used for HMAC */
+		tfm = crypto_alloc_tfm(digest, 0);
+		if (!tfm) {
+			ti->error = "dm-crypt: Error allocating digest tfm";
+			goto bad1;
+		}
+		if (crypto_tfm_alg_type(tfm) != CRYPTO_ALG_TYPE_DIGEST) {
+			ti->error = "dm-crypt: Expected digest algorithm";
+			goto bad1;
+		}
 
-	if (cc->iv_generator)
-		crypto_flags = CRYPTO_TFM_MODE_CBC;
-	else
-		crypto_flags = CRYPTO_TFM_MODE_ECB;
+		cc->digest = tfm;
+		cc->digest_size = crypto_tfm_alg_digestsize(tfm);
+		cc->iv_generator = crypt_iv_hmac;
+	}
 
 	tfm = crypto_alloc_tfm(cipher, crypto_flags);
 	if (!tfm) {
 		ti->error = "dm-crypt: Error allocating crypto tfm";
 		goto bad1;
 	}
+	if (crypto_tfm_alg_type(tfm) != CRYPTO_ALG_TYPE_CIPHER) {
+		ti->error = "dm-crypt: Expected cipher algorithm";
+		goto bad2;
+	}
 
-	if (tfm->crt_u.cipher.cit_decrypt_iv && tfm->crt_u.cipher.cit_encrypt_iv)
-		/* at least a 32 bit sector number should fit in our buffer */
+	if (tfm->crt_cipher.cit_decrypt_iv &&
+	    tfm->crt_cipher.cit_encrypt_iv) {
+		/* at least a sector number should fit in our buffer */
 		cc->iv_size = max(crypto_tfm_alg_ivsize(tfm), 
-		                  (unsigned int)(sizeof(u32) / sizeof(u8)));
-	else {
+		                  (unsigned int)(sizeof(u64) / sizeof(u8)));
+		cc->iv_size = max(cc->iv_size, cc->digest_size);
+	} else {
 		cc->iv_size = 0;
 		if (cc->iv_generator) {
-			DMWARN("dm-crypt: Selected cipher does not support IVs");
-			cc->iv_generator = NULL;
+			ti->error = "dm-crypt: Cipher does not support IVs";
+			goto bad2;
 		}
 	}
 
 	cc->io_pool = mempool_create(MIN_IOS, mempool_alloc_slab,
-				     mempool_free_slab, _crypt_io_pool);
+	                             mempool_free_slab, _crypt_io_pool);
 	if (!cc->io_pool) {
 		ti->error = "dm-crypt: Cannot allocate crypt io mempool";
 		goto bad2;
@@ -482,7 +559,7 @@
 		goto bad3;
 	}
 
-	cc->tfm = tfm;
+	cc->cipher = tfm;
 	cc->key_size = key_size;
 	if ((key_size == 0 && strcmp(argv[1], "-") != 0)
 	    || crypt_decode_key(cc->key, argv[1], key_size) < 0) {
@@ -490,11 +567,16 @@
 		goto bad4;
 	}
 
-	if (tfm->crt_u.cipher.cit_setkey(tfm, cc->key, key_size) < 0) {
+	if (tfm->crt_cipher.cit_setkey(tfm, cc->key, key_size) < 0) {
 		ti->error = "dm-crypt: Error setting key";
 		goto bad4;
 	}
 
+	/* precompute part of the HMAC here, it only depends on the key */
+	if (cc->digest)
+		crypto_hmac_init(cc->digest, cc->key,
+		                 (unsigned int *)&key_size);
+
 	if (sscanf(argv[2], SECTOR_FORMAT, &cc->iv_offset) != 1) {
 		ti->error = "dm-crypt: Invalid iv_offset sector";
 		goto bad4;
@@ -521,6 +603,8 @@
 bad2:
 	crypto_free_tfm(tfm);
 bad1:
+	if (cc->digest)
+		crypto_free_tfm(cc->digest);
 	kfree(cc);
 	return -EINVAL;
 }
@@ -532,7 +616,10 @@
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
@@ -669,9 +756,10 @@
 			char *result, unsigned int maxlen)
 {
 	struct crypt_config *cc = (struct crypt_config *) ti->private;
+	struct cipher_mode *cm;
 	char buffer[32];
 	const char *cipher;
-	const char *mode = NULL;
+	const char *digest;
 	int offset;
 
 	switch (type) {
@@ -680,20 +768,20 @@
 		break;
 
 	case STATUSTYPE_TABLE:
-		cipher = crypto_tfm_alg_name(cc->tfm);
+		cipher = crypto_tfm_alg_name(cc->cipher);
 
-		switch(cc->tfm->crt_u.cipher.cit_mode) {
-		case CRYPTO_TFM_MODE_CBC:
-			mode = "plain";
-			break;
-		case CRYPTO_TFM_MODE_ECB:
-			mode = "ecb";
-			break;
-		default:
-			BUG();
-		}
+		for(cm = cipher_modes; cm->name; cm++)
+			if (cm->mode == cc->cipher->crt_cipher.cit_mode)
+				break;
+		BUG_ON(!cm->name);
+
+		if (cc->digest)
+			digest = crypto_tfm_alg_name(cc->digest);
+		else
+			digest = "";
 
-		snprintf(result, maxlen, "%s-%s ", cipher, mode);
+		snprintf(result, maxlen, "%s-%s%s%s ", cipher, cm->name,
+		         digest[0] ? "-" : "", digest);
 		offset = strlen(result);
 
 		if (cc->key_size > 0) {
diff -Nur linux-2.6.3-mm1.orig/drivers/md/Kconfig linux-2.6.3-mm1/drivers/md/Kconfig
--- linux-2.6.3-mm1.orig/drivers/md/Kconfig	2004-02-21 03:04:59.338701872 +0100
+++ linux-2.6.3-mm1/drivers/md/Kconfig	2004-02-21 03:05:44.071901392 +0100
@@ -174,6 +174,7 @@
 	tristate "Crypt target support"
 	depends on BLK_DEV_DM && EXPERIMENTAL
 	select CRYPTO
+	select CRYPTO_HMAC
 	---help---
 	  This device-mapper target allows you to create a device that
 	  transparently encrypts the data on it. You'll need to activate
