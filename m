Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269649AbUJSTAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269649AbUJSTAq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 15:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270008AbUJSSX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 14:23:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52111 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269871AbUJSR6T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 13:58:19 -0400
Date: Tue, 19 Oct 2004 18:58:07 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2/2: device-mapper: dm-crypt: new IV mode ESSIV
Message-ID: <20041019175807.GE6420@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new IV mode ''encrypted sector|salt IV'' described in
  http://article.gmane.org/gmane.linux.kernel.device-mapper.dm-crypt/472

To use ESSIV, set the ivmode (using the new syntax) to "essiv:<hash>".
"hash" should be a valid cryptoapi hash.

This, for example, is a valid dm-target line:

0 200 crypt aes-cbc-essiv:sha256 00000000000000000000000000000000 0 /dev/loop/5 0
 
Signed-Off-By: Alasdair G Kergon <agk@redhat.com>
Signed-Off-By: Christophe Saout <christophe@saout.de>
Signed-Off-By: Fruhwirth Clemens <clemens@endorphin.org>
--- diff/drivers/md/dm-crypt.c	2004-10-19 16:54:37.000000000 +0100
+++ source/drivers/md/dm-crypt.c	2004-10-19 16:54:45.000000000 +0100
@@ -1,5 +1,6 @@
 /*
  * Copyright (C) 2003 Christophe Saout <christophe@saout.de>
+ * Copyright (C) 2004 Clemens Fruhwirth <clemens@endorphin.org>
  *
  * This file is released under the GPL.
  */
@@ -15,6 +16,7 @@
 #include <linux/workqueue.h>
 #include <asm/atomic.h>
 #include <asm/scatterlist.h>
+#include <asm/page.h>
 
 #include "dm.h"
 
@@ -110,6 +112,13 @@
  *
  * plain: the initial vector is the 32-bit low-endian version of the sector
  *        number, padded with zeros if neccessary.
+ *
+ * ess_iv: "encrypted sector|salt initial vector", the sector number is 
+ *         encrypted with the bulk cipher using a salt as key. The salt
+ *         should be derived from the bulk cipher's key via hashing.
+ *
+ * plumb: unimplemented, see:
+ * http://article.gmane.org/gmane.linux.kernel.device-mapper.dm-crypt/454
  */
 
 static int crypt_iv_plain_gen(struct crypt_config *cc, u8 *iv, sector_t sector)
@@ -120,10 +129,107 @@
 	return 0;
 }
 
+static int crypt_iv_essiv_ctr(struct crypt_config *cc, struct dm_target *ti,
+	                      const char *opts)
+{
+	struct crypto_tfm *essiv_tfm;
+	struct crypto_tfm *hash_tfm;
+	struct scatterlist sg;
+	unsigned int saltsize;
+	u8 *salt;
+
+	if (opts == NULL) {
+		ti->error = PFX "Digest algorithm missing for ESSIV mode";
+		return -EINVAL;
+	}
+
+	/* Hash the cipher key with the given hash algorithm */
+	hash_tfm = crypto_alloc_tfm(opts, 0);
+	if (hash_tfm == NULL) {
+		ti->error = PFX "Error initializing ESSIV hash";
+		return -EINVAL;
+	}
+
+	if (crypto_tfm_alg_type(hash_tfm) != CRYPTO_ALG_TYPE_DIGEST) {
+		ti->error = PFX "Expected digest algorithm for ESSIV hash";
+		crypto_free_tfm(hash_tfm);
+		return -EINVAL;
+	}
+
+	saltsize = crypto_tfm_alg_digestsize(hash_tfm);
+	salt = kmalloc(saltsize, GFP_KERNEL);
+	if (salt == NULL) {
+		ti->error = PFX "Error kmallocing salt storage in ESSIV";
+		crypto_free_tfm(hash_tfm);
+		return -ENOMEM;
+	}
+
+	sg.page = virt_to_page(cc->key);
+	sg.offset = offset_in_page(cc->key);
+	sg.length = cc->key_size;
+	crypto_digest_digest(hash_tfm, &sg, 1, salt);
+	crypto_free_tfm(hash_tfm);
+
+	/* Setup the essiv_tfm with the given salt */
+	essiv_tfm = crypto_alloc_tfm(crypto_tfm_alg_name(cc->tfm),
+	                             CRYPTO_TFM_MODE_ECB);
+	if (essiv_tfm == NULL) {
+		ti->error = PFX "Error allocating crypto tfm for ESSIV";
+		kfree(salt);
+		return -EINVAL;
+	}
+	if (crypto_tfm_alg_blocksize(essiv_tfm)
+	    != crypto_tfm_alg_ivsize(cc->tfm)) {
+		ti->error = PFX "Block size of ESSIV cipher does "
+			        "not match IV size of block cipher";
+		crypto_free_tfm(essiv_tfm);
+		kfree(salt);
+		return -EINVAL;
+	}
+	if (crypto_cipher_setkey(essiv_tfm, salt, saltsize) < 0) {
+		ti->error = PFX "Failed to set key for ESSIV cipher";
+		crypto_free_tfm(essiv_tfm);
+		kfree(salt);
+		return -EINVAL;
+	}
+	kfree(salt);
+
+	cc->iv_gen_private = (void *)essiv_tfm;
+	return 0;
+}
+
+static void crypt_iv_essiv_dtr(struct crypt_config *cc)
+{
+	crypto_free_tfm((struct crypto_tfm *)cc->iv_gen_private);
+	cc->iv_gen_private = NULL;
+}
+
+static int crypt_iv_essiv_gen(struct crypt_config *cc, u8 *iv, sector_t sector)
+{
+	struct scatterlist sg = { NULL, };
+
+	memset(iv, 0, cc->iv_size);
+	*(u64 *)iv = cpu_to_le64(sector);
+
+	sg.page = virt_to_page(iv);
+	sg.offset = offset_in_page(iv);
+	sg.length = cc->iv_size;
+	crypto_cipher_encrypt((struct crypto_tfm *)cc->iv_gen_private,
+	                      &sg, &sg, cc->iv_size);
+
+	return 0;
+}
+
 static struct crypt_iv_operations crypt_iv_plain_ops = {
 	.generator = crypt_iv_plain_gen
 };
 
+static struct crypt_iv_operations crypt_iv_essiv_ops = {
+	.ctr       = crypt_iv_essiv_ctr,
+	.dtr       = crypt_iv_essiv_dtr,
+	.generator = crypt_iv_essiv_gen
+};
+
 
 static inline int
 crypt_convert_scatterlist(struct crypt_config *cc, struct scatterlist *out,
@@ -503,7 +609,7 @@
 	cc->tfm = tfm;
 
 	/* 
-	 * Choose ivmode. Valid modes: "plain"
+	 * Choose ivmode. Valid modes: "plain", "essiv:<esshash>". 
 	 * See comments at iv code
 	 */
 
@@ -511,6 +617,8 @@
 		cc->iv_gen_ops = NULL;
 	else if (strcmp(ivmode, "plain") == 0)
 		cc->iv_gen_ops = &crypt_iv_plain_ops;
+	else if (strcmp(ivmode, "essiv") == 0)
+		cc->iv_gen_ops = &crypt_iv_essiv_ops;
 	else {
 		ti->error = PFX "Invalid IV mode";
 		goto bad2;
@@ -521,9 +629,9 @@
 		goto bad2;
 
 	if (tfm->crt_cipher.cit_decrypt_iv && tfm->crt_cipher.cit_encrypt_iv)
-		/* at least a 32 bit sector number should fit in our buffer */
+		/* at least a 64 bit sector number should fit in our buffer */
 		cc->iv_size = max(crypto_tfm_alg_ivsize(tfm),
-		                  (unsigned int)(sizeof(u32) / sizeof(u8)));
+		                  (unsigned int)(sizeof(u64) / sizeof(u8)));
 	else {
 		cc->iv_size = 0;
 		if (cc->iv_gen_ops) {
