Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269578AbUJSTAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269578AbUJSTAs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 15:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269788AbUJSSUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 14:20:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9612 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S270008AbUJSRvc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 13:51:32 -0400
Date: Tue, 19 Oct 2004 18:51:28 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 1/2: device-mapper: dm-crypt generator extension
Message-ID: <20041019175128.GD6420@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Create crypt_iv_operations structure with generator method
and move the plain iv generator into this structure.
 
Optionally accept an extended <sector format> syntax:
  <cipher>-<chaining mode>-<iv mode>

This also makes it ready to support chaining modes other than CBC 
mode, such as CMC (not implemented in cryptoapi yet), 
The problems outlined by Adam J. Richter in
  http://article.gmane.org/gmane.linux.kernel.device-mapper.dm-crypt/454
would be fixed by switching to CMC chaining mode. 

Example of a valid target line:
  0 200 crypt aes-cbc-plain 00000000000000000000000000000000 0 /dev/loop/5 0
 
Signed-Off-By: Alasdair G Kergon <agk@redhat.com>
Signed-Off-By: Christophe Saout <christophe@saout.de>
--- diff/drivers/md/dm-crypt.c	2004-10-19 16:54:13.000000000 +0100
+++ source/drivers/md/dm-crypt.c	2004-10-19 16:54:37.000000000 +0100
@@ -46,6 +46,16 @@
 	int write;
 };
 
+struct crypt_config;
+
+struct crypt_iv_operations {
+	int (*ctr)(struct crypt_config *cc, struct dm_target *ti,
+	           const char *opts);
+	void (*dtr)(struct crypt_config *cc);
+	const char *(*status)(struct crypt_config *cc);
+	int (*generator)(struct crypt_config *cc, u8 *iv, sector_t sector);
+};
+
 /*
  * Crypt: maps a linear range of a block device
  * and encrypts / decrypts at the same time.
@@ -64,7 +74,9 @@
 	/*
 	 * crypto related data
 	 */
-	int (*iv_generator)(struct crypt_config *cc, u8 *iv, sector_t sector);
+	struct crypt_iv_operations *iv_gen_ops;
+	char *iv_mode;
+	void *iv_gen_private;
 	sector_t iv_offset;
 	unsigned int iv_size;
 
@@ -94,9 +106,13 @@
 
 
 /*
- * Different IV generation algorithms
+ * Different IV generation algorithms:
+ *
+ * plain: the initial vector is the 32-bit low-endian version of the sector
+ *        number, padded with zeros if neccessary.
  */
-static int crypt_iv_plain(struct crypt_config *cc, u8 *iv, sector_t sector)
+
+static int crypt_iv_plain_gen(struct crypt_config *cc, u8 *iv, sector_t sector)
 {
 	memset(iv, 0, cc->iv_size);
 	*(u32 *)iv = cpu_to_le32(sector & 0xffffffff);
@@ -104,6 +120,11 @@
 	return 0;
 }
 
+static struct crypt_iv_operations crypt_iv_plain_ops = {
+	.generator = crypt_iv_plain_gen
+};
+
+
 static inline int
 crypt_convert_scatterlist(struct crypt_config *cc, struct scatterlist *out,
                           struct scatterlist *in, unsigned int length,
@@ -112,8 +133,8 @@
 	u8 iv[cc->iv_size];
 	int r;
 
-	if (cc->iv_generator) {
-		r = cc->iv_generator(cc, iv, sector);
+	if (cc->iv_gen_ops) {
+		r = cc->iv_gen_ops->generator(cc, iv, sector);
 		if (r < 0)
 			return r;
 
@@ -412,7 +433,9 @@
 	struct crypto_tfm *tfm;
 	char *tmp;
 	char *cipher;
-	char *mode;
+	char *chainmode;
+	char *ivmode;
+	char *ivopts;
 	unsigned int crypto_flags;
 	unsigned int key_size;
 
@@ -423,7 +446,9 @@
 
 	tmp = argv[0];
 	cipher = strsep(&tmp, "-");
-	mode = strsep(&tmp, "-");
+	chainmode = strsep(&tmp, "-");
+	ivopts = strsep(&tmp, "-");
+	ivmode = strsep(&ivopts, ":");
 
 	if (tmp)
 		DMWARN(PFX "Unexpected additional cipher options");
@@ -437,19 +462,33 @@
 		return -ENOMEM;
 	}
 
-	if (!mode || strcmp(mode, "plain") == 0)
-		cc->iv_generator = crypt_iv_plain;
-	else if (strcmp(mode, "ecb") == 0)
-		cc->iv_generator = NULL;
-	else {
-		ti->error = PFX "Invalid chaining mode";
+	cc->key_size = key_size;
+	if ((key_size == 0 && strcmp(argv[1], "-") != 0)
+	    || crypt_decode_key(cc->key, argv[1], key_size) < 0) {
+		ti->error = PFX "Error decoding key";
 		goto bad1;
 	}
 
-	if (cc->iv_generator)
+	/* Compatiblity mode for old dm-crypt cipher strings */
+	if (!chainmode || (strcmp(chainmode, "plain") == 0 && !ivmode)) {
+		chainmode = "cbc";
+		ivmode = "plain";
+	}
+
+	/* Choose crypto_flags according to chainmode */
+	if (strcmp(chainmode, "cbc") == 0)
 		crypto_flags = CRYPTO_TFM_MODE_CBC;
-	else
+	else if (strcmp(chainmode, "ecb") == 0)
 		crypto_flags = CRYPTO_TFM_MODE_ECB;
+	else {
+		ti->error = PFX "Unknown chaining mode";
+		goto bad1;
+	}
+
+	if (crypto_flags != CRYPTO_TFM_MODE_ECB && !ivmode) {
+		ti->error = PFX "This chaining mode requires an IV mechanism";
+		goto bad1;
+	}
 
 	tfm = crypto_alloc_tfm(cipher, crypto_flags);
 	if (!tfm) {
@@ -461,15 +500,37 @@
 		goto bad2;
 	}
 
+	cc->tfm = tfm;
+
+	/* 
+	 * Choose ivmode. Valid modes: "plain"
+	 * See comments at iv code
+	 */
+
+	if (ivmode == NULL)
+		cc->iv_gen_ops = NULL;
+	else if (strcmp(ivmode, "plain") == 0)
+		cc->iv_gen_ops = &crypt_iv_plain_ops;
+	else {
+		ti->error = PFX "Invalid IV mode";
+		goto bad2;
+	}
+
+	if (cc->iv_gen_ops && cc->iv_gen_ops->ctr &&
+	    cc->iv_gen_ops->ctr(cc, ti, ivopts) < 0)
+		goto bad2;
+
 	if (tfm->crt_cipher.cit_decrypt_iv && tfm->crt_cipher.cit_encrypt_iv)
 		/* at least a 32 bit sector number should fit in our buffer */
 		cc->iv_size = max(crypto_tfm_alg_ivsize(tfm),
 		                  (unsigned int)(sizeof(u32) / sizeof(u8)));
 	else {
 		cc->iv_size = 0;
-		if (cc->iv_generator) {
+		if (cc->iv_gen_ops) {
 			DMWARN(PFX "Selected cipher does not support IVs");
-			cc->iv_generator = NULL;
+			if (cc->iv_gen_ops->dtr)
+				cc->iv_gen_ops->dtr(cc);
+			cc->iv_gen_ops = NULL;
 		}
 	}
 
@@ -477,52 +538,59 @@
 				     mempool_free_slab, _crypt_io_pool);
 	if (!cc->io_pool) {
 		ti->error = PFX "Cannot allocate crypt io mempool";
-		goto bad2;
+		goto bad3;
 	}
 
 	cc->page_pool = mempool_create(MIN_POOL_PAGES, mempool_alloc_page,
 				       mempool_free_page, NULL);
 	if (!cc->page_pool) {
 		ti->error = PFX "Cannot allocate page mempool";
-		goto bad3;
-	}
-
-	cc->tfm = tfm;
-	cc->key_size = key_size;
-	if ((key_size == 0 && strcmp(argv[1], "-") != 0)
-	    || crypt_decode_key(cc->key, argv[1], key_size) < 0) {
-		ti->error = PFX "Error decoding key";
 		goto bad4;
 	}
 
 	if (tfm->crt_cipher.cit_setkey(tfm, cc->key, key_size) < 0) {
 		ti->error = PFX "Error setting key";
-		goto bad4;
+		goto bad5;
 	}
 
 	if (sscanf(argv[2], SECTOR_FORMAT, &cc->iv_offset) != 1) {
 		ti->error = PFX "Invalid iv_offset sector";
-		goto bad4;
+		goto bad5;
 	}
 
 	if (sscanf(argv[4], SECTOR_FORMAT, &cc->start) != 1) {
 		ti->error = PFX "Invalid device sector";
-		goto bad4;
+		goto bad5;
 	}
 
 	if (dm_get_device(ti, argv[3], cc->start, ti->len,
 	                  dm_table_get_mode(ti->table), &cc->dev)) {
 		ti->error = PFX "Device lookup failed";
-		goto bad4;
+		goto bad5;
 	}
 
+	if (ivmode && cc->iv_gen_ops) {
+		if (ivopts)
+			*(ivopts - 1) = ':';
+		cc->iv_mode = kmalloc(strlen(ivmode) + 1, GFP_KERNEL);
+		if (!cc->iv_mode) {
+			ti->error = PFX "Error kmallocing iv_mode string";
+			goto bad5;
+		}
+		strcpy(cc->iv_mode, ivmode);
+	} else
+		cc->iv_mode = NULL;
+
 	ti->private = cc;
 	return 0;
 
-bad4:
+bad5:
 	mempool_destroy(cc->page_pool);
-bad3:
+bad4:
 	mempool_destroy(cc->io_pool);
+bad3:
+	if (cc->iv_gen_ops && cc->iv_gen_ops->dtr)
+		cc->iv_gen_ops->dtr(cc);
 bad2:
 	crypto_free_tfm(tfm);
 bad1:
@@ -537,6 +605,10 @@
 	mempool_destroy(cc->page_pool);
 	mempool_destroy(cc->io_pool);
 
+	if (cc->iv_mode)
+		kfree(cc->iv_mode);
+	if (cc->iv_gen_ops && cc->iv_gen_ops->dtr)
+		cc->iv_gen_ops->dtr(cc);
 	crypto_free_tfm(cc->tfm);
 	dm_put_device(ti, cc->dev);
 	kfree(cc);
@@ -691,7 +763,7 @@
 	struct crypt_config *cc = (struct crypt_config *) ti->private;
 	char buffer[32];
 	const char *cipher;
-	const char *mode = NULL;
+	const char *chainmode = NULL;
 	unsigned int sz = 0;
 
 	switch (type) {
@@ -704,16 +776,19 @@
 
 		switch(cc->tfm->crt_cipher.cit_mode) {
 		case CRYPTO_TFM_MODE_CBC:
-			mode = "plain";
+			chainmode = "cbc";
 			break;
 		case CRYPTO_TFM_MODE_ECB:
-			mode = "ecb";
+			chainmode = "ecb";
 			break;
 		default:
 			BUG();
 		}
 
-		DMEMIT("%s-%s ", cipher, mode);
+		if (cc->iv_mode)
+			DMEMIT("%s-%s-%s ", cipher, chainmode, cc->iv_mode);
+		else
+			DMEMIT("%s-%s ", cipher, chainmode);
 
 		if (cc->key_size > 0) {
 			if ((maxlen - sz) < ((cc->key_size << 1) + 1))
@@ -737,7 +812,7 @@
 
 static struct target_type crypt_target = {
 	.name   = "crypt",
-	.version= {1, 0, 0},
+	.version= {1, 1, 0},
 	.module = THIS_MODULE,
 	.ctr    = crypt_ctr,
 	.dtr    = crypt_dtr,
