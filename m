Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965029AbWJJGqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965029AbWJJGqh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 02:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965031AbWJJGqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 02:46:37 -0400
Received: from havoc.gtf.org ([69.61.125.42]:47757 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S965029AbWJJGqg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 02:46:36 -0400
Date: Tue, 10 Oct 2006 02:46:26 -0400
From: Jeff Garzik <jeff@garzik.org>
To: mhalcrow@us.ibm.com, phillip@hellewell.homeip.net,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Cc: herbert@gondor.apana.org.au
Subject: [PATCH] ecryptfs: reduce legacy API usage
Message-ID: <20061010064626.GA21155@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use modern crypto APIs.

Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

This doesn't completely remove the legacy API usage from the filesystem,
but it moves the effort forward, and should be a self-contained change.

 fs/ecryptfs/crypto.c               |   63 ++++++++++++++++++++++---------------
 fs/ecryptfs/ecryptfs_kernel.h      |    9 ++---

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index ed35a97..6b62792 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -96,23 +96,27 @@ static int ecryptfs_calculate_md5(char *
 {
 	int rc = 0;
 	struct scatterlist sg;
+	struct hash_desc desc = {
+		.tfm = crypt_stat->hash,
+		.flags = CRYPTO_TFM_REQ_MAY_SLEEP,
+	};
 
-	mutex_lock(&crypt_stat->cs_md5_tfm_mutex);
+	mutex_lock(&crypt_stat->cs_hash_mutex);
 	sg_init_one(&sg, (u8 *)src, len);
-	if (!crypt_stat->md5_tfm) {
-		crypt_stat->md5_tfm =
-			crypto_alloc_tfm("md5", CRYPTO_TFM_REQ_MAY_SLEEP);
-		if (!crypt_stat->md5_tfm) {
-			rc = -ENOMEM;
+	if (!desc.tfm) {
+		desc.tfm = crypto_alloc_hash("md5", 0, CRYPTO_ALG_ASYNC);
+		if (IS_ERR(desc.tfm)) {
+			rc = PTR_ERR(desc.tfm);
 			ecryptfs_printk(KERN_ERR, "Error attempting to "
 					"allocate crypto context\n");
 			goto out;
 		}
+		crypt_stat->hash = desc.tfm;
 	}
-	crypto_digest_init(crypt_stat->md5_tfm);
-	crypto_digest_update(crypt_stat->md5_tfm, &sg, 1);
-	crypto_digest_final(crypt_stat->md5_tfm, dst);
-	mutex_unlock(&crypt_stat->cs_md5_tfm_mutex);
+	crypto_hash_init(&desc);
+	crypto_hash_update(&desc, &sg, len);
+	crypto_hash_final(&desc, dst);
+	mutex_unlock(&crypt_stat->cs_hash_mutex);
 out:
 	return rc;
 }
@@ -178,7 +182,7 @@ ecryptfs_init_crypt_stat(struct ecryptfs
 	memset((void *)crypt_stat, 0, sizeof(struct ecryptfs_crypt_stat));
 	mutex_init(&crypt_stat->cs_mutex);
 	mutex_init(&crypt_stat->cs_tfm_mutex);
-	mutex_init(&crypt_stat->cs_md5_tfm_mutex);
+	mutex_init(&crypt_stat->cs_hash_mutex);
 	ECRYPTFS_SET_FLAG(crypt_stat->flags, ECRYPTFS_STRUCT_INITIALIZED);
 }
 
@@ -191,9 +195,9 @@ ecryptfs_init_crypt_stat(struct ecryptfs
 void ecryptfs_destruct_crypt_stat(struct ecryptfs_crypt_stat *crypt_stat)
 {
 	if (crypt_stat->tfm)
-		crypto_free_tfm(crypt_stat->tfm);
-	if (crypt_stat->md5_tfm)
-		crypto_free_tfm(crypt_stat->md5_tfm);
+		crypto_free_blkcipher(crypt_stat->tfm);
+	if (crypt_stat->hash)
+		crypto_free_hash(crypt_stat->hash);
 	memset(crypt_stat, 0, sizeof(struct ecryptfs_crypt_stat));
 }
 
@@ -270,6 +274,11 @@ static int encrypt_scatterlist(struct ec
 			       unsigned char *iv)
 {
 	int rc = 0;
+	struct blkcipher_desc desc = {
+		.tfm = crypt_stat->tfm,
+		.info = iv,
+		.flags = CRYPTO_TFM_REQ_MAY_SLEEP,
+	};
 
 	BUG_ON(!crypt_stat || !crypt_stat->tfm
 	       || !ECRYPTFS_CHECK_FLAG(crypt_stat->flags,
@@ -282,7 +291,7 @@ static int encrypt_scatterlist(struct ec
 	}
 	/* Consider doing this once, when the file is opened */
 	mutex_lock(&crypt_stat->cs_tfm_mutex);
-	rc = crypto_cipher_setkey(crypt_stat->tfm, crypt_stat->key,
+	rc = crypto_blkcipher_setkey(crypt_stat->tfm, crypt_stat->key,
 				  crypt_stat->key_size);
 	if (rc) {
 		ecryptfs_printk(KERN_ERR, "Error setting key; rc = [%d]\n",
@@ -292,7 +301,7 @@ static int encrypt_scatterlist(struct ec
 		goto out;
 	}
 	ecryptfs_printk(KERN_DEBUG, "Encrypting [%d] bytes.\n", size);
-	crypto_cipher_encrypt_iv(crypt_stat->tfm, dest_sg, src_sg, size, iv);
+	crypto_blkcipher_encrypt_iv(&desc, dest_sg, src_sg, size);
 	mutex_unlock(&crypt_stat->cs_tfm_mutex);
 out:
 	return rc;
@@ -676,11 +685,16 @@ static int decrypt_scatterlist(struct ec
 			       unsigned char *iv)
 {
 	int rc = 0;
+	struct blkcipher_desc desc = {
+		.tfm = crypt_stat->tfm,
+		.info = iv,
+		.flags = CRYPTO_TFM_REQ_MAY_SLEEP,
+	};
 
 	/* Consider doing this once, when the file is opened */
 	mutex_lock(&crypt_stat->cs_tfm_mutex);
-	rc = crypto_cipher_setkey(crypt_stat->tfm, crypt_stat->key,
-				  crypt_stat->key_size);
+	rc = crypto_blkcipher_setkey(crypt_stat->tfm, crypt_stat->key,
+				     crypt_stat->key_size);
 	if (rc) {
 		ecryptfs_printk(KERN_ERR, "Error setting key; rc = [%d]\n",
 				rc);
@@ -689,8 +703,7 @@ static int decrypt_scatterlist(struct ec
 		goto out;
 	}
 	ecryptfs_printk(KERN_DEBUG, "Decrypting [%d] bytes.\n", size);
-	rc = crypto_cipher_decrypt_iv(crypt_stat->tfm, dest_sg, src_sg, size,
-				      iv);
+	rc = crypto_blkcipher_decrypt_iv(&desc, dest_sg, src_sg, size);
 	mutex_unlock(&crypt_stat->cs_tfm_mutex);
 	if (rc) {
 		ecryptfs_printk(KERN_ERR, "Error decrypting; rc = [%d]\n",
@@ -775,16 +788,18 @@ int ecryptfs_init_crypt_ctx(struct ecryp
 		goto out;
 	}
 	mutex_lock(&crypt_stat->cs_tfm_mutex);
-	crypt_stat->tfm = crypto_alloc_tfm(crypt_stat->cipher,
-					   ECRYPTFS_DEFAULT_CHAINING_MODE
-					   | CRYPTO_TFM_REQ_WEAK_KEY);
+	crypt_stat->tfm = crypto_alloc_blkcipher(crypt_stat->cipher, 0,
+						 CRYPTO_ALG_ASYNC);
 	mutex_unlock(&crypt_stat->cs_tfm_mutex);
-	if (!crypt_stat->tfm) {
+	if (IS_ERR(crypt_stat->tfm)) {
+		rc = PTR_ERR(crypt_stat->tfm);
 		ecryptfs_printk(KERN_ERR, "cryptfs: init_crypt_ctx(): "
 				"Error initializing cipher [%s]\n",
 				crypt_stat->cipher);
 		goto out;
 	}
+	crypto_blkcipher_set_flags(crypt_stat->tfm,
+		ECRYPTFS_DEFAULT_CHAINING_MODE | CRYPTO_TFM_REQ_WEAK_KEY);
 	rc = 0;
 out:
 	return rc;
diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index 872c995..eb45400 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -29,6 +29,7 @@ #define ECRYPTFS_KERNEL_H
 #include <keys/user-type.h>
 #include <linux/fs.h>
 #include <linux/scatterlist.h>
+#include <linux/crypto.h>
 
 /* Version verification for shared data structures w/ userspace */
 #define ECRYPTFS_VERSION_MAJOR 0x00
@@ -204,15 +205,15 @@ #define ECRYPTFS_KEY_VALID          0x00
 	size_t extent_shift;
 	unsigned int extent_mask;
 	struct ecryptfs_mount_crypt_stat *mount_crypt_stat;
-	struct crypto_tfm *tfm;
-	struct crypto_tfm *md5_tfm; /* Crypto context for generating
-				     * the initialization vectors */
+	struct crypto_blkcipher *tfm;
+	struct crypto_hash *hash; /* Crypto context for generating
+				   * the initialization vectors */
 	unsigned char cipher[ECRYPTFS_MAX_CIPHER_NAME_SIZE];
 	unsigned char key[ECRYPTFS_MAX_KEY_BYTES];
 	unsigned char root_iv[ECRYPTFS_MAX_IV_BYTES];
 	unsigned char keysigs[ECRYPTFS_MAX_NUM_KEYSIGS][ECRYPTFS_SIG_SIZE_HEX];
 	struct mutex cs_tfm_mutex;
-	struct mutex cs_md5_tfm_mutex;
+	struct mutex cs_hash_mutex;
 	struct mutex cs_mutex;
 };
 
