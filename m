Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422758AbWJ3Xgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422758AbWJ3Xgl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 18:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422753AbWJ3Xgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 18:36:41 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:45002 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422748AbWJ3Xgk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 18:36:40 -0500
Date: Mon, 30 Oct 2006 17:36:37 -0600
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: akpm@osdl.org
Cc: LKML <linux-kernel@vger.kernel.org>, mhalcrow@us.ibm.com,
       Jeff Garzik <jeff@garzik.org>, Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 3/6] eCryptfs: Cipher code to new crypto API
Message-ID: <20061030233637.GB21515@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20061030233209.GC3458@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061030233209.GC3458@us.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update cipher block encryption code to the new crypto API.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/crypto.c          |   92 +++++++++++++++++++++++++++++--------
 fs/ecryptfs/ecryptfs_kernel.h |    9 ++--
 fs/ecryptfs/keystore.c        |  101 +++++++++++++++++++++++++++--------------
 fs/ecryptfs/main.c            |    2 +
 4 files changed, 146 insertions(+), 58 deletions(-)

401d3201a0ae8ff009eb1c363bef192ca06797b0
diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index f14c5a3..7f32fcb 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -123,6 +123,28 @@ out:
 	return rc;
 }
 
+int ecryptfs_crypto_api_algify_cipher_name(char **algified_name,
+					   char *cipher_name,
+					   char *chaining_modifier)
+{
+	int cipher_name_len = strlen(cipher_name);
+	int chaining_modifier_len = strlen(chaining_modifier);
+	int algified_name_len;
+	int rc;
+
+	algified_name_len = (chaining_modifier_len + cipher_name_len + 3);
+	(*algified_name) = kmalloc(algified_name_len, GFP_KERNEL);
+	if (!(algified_name)) {
+		rc = -ENOMEM;
+		goto out;
+	}
+	snprintf((*algified_name), algified_name_len, "%s(%s)",
+		 chaining_modifier, cipher_name);
+	rc = 0;
+out:
+	return rc;
+}
+
 /**
  * ecryptfs_derive_iv
  * @iv: destination for the derived iv vale
@@ -197,7 +219,7 @@ ecryptfs_init_crypt_stat(struct ecryptfs
 void ecryptfs_destruct_crypt_stat(struct ecryptfs_crypt_stat *crypt_stat)
 {
 	if (crypt_stat->tfm)
-		crypto_free_tfm(crypt_stat->tfm);
+		crypto_free_blkcipher(crypt_stat->tfm);
 	if (crypt_stat->hash_tfm)
 		crypto_free_hash(crypt_stat->hash_tfm);
 	memset(crypt_stat, 0, sizeof(struct ecryptfs_crypt_stat));
@@ -209,7 +231,7 @@ void ecryptfs_destruct_mount_crypt_stat(
 	if (mount_crypt_stat->global_auth_tok_key)
 		key_put(mount_crypt_stat->global_auth_tok_key);
 	if (mount_crypt_stat->global_key_tfm)
-		crypto_free_tfm(mount_crypt_stat->global_key_tfm);
+		crypto_free_blkcipher(mount_crypt_stat->global_key_tfm);
 	memset(mount_crypt_stat, 0, sizeof(struct ecryptfs_mount_crypt_stat));
 }
 
@@ -275,6 +297,11 @@ static int encrypt_scatterlist(struct ec
 			       struct scatterlist *src_sg, int size,
 			       unsigned char *iv)
 {
+	struct blkcipher_desc desc = {
+		.tfm = crypt_stat->tfm,
+		.info = iv,
+		.flags = CRYPTO_TFM_REQ_MAY_SLEEP
+	};
 	int rc = 0;
 
 	BUG_ON(!crypt_stat || !crypt_stat->tfm
@@ -288,8 +315,8 @@ static int encrypt_scatterlist(struct ec
 	}
 	/* Consider doing this once, when the file is opened */
 	mutex_lock(&crypt_stat->cs_tfm_mutex);
-	rc = crypto_cipher_setkey(crypt_stat->tfm, crypt_stat->key,
-				  crypt_stat->key_size);
+	rc = crypto_blkcipher_setkey(crypt_stat->tfm, crypt_stat->key,
+				     crypt_stat->key_size);
 	if (rc) {
 		ecryptfs_printk(KERN_ERR, "Error setting key; rc = [%d]\n",
 				rc);
@@ -298,7 +325,7 @@ static int encrypt_scatterlist(struct ec
 		goto out;
 	}
 	ecryptfs_printk(KERN_DEBUG, "Encrypting [%d] bytes.\n", size);
-	crypto_cipher_encrypt_iv(crypt_stat->tfm, dest_sg, src_sg, size, iv);
+	crypto_blkcipher_encrypt_iv(&desc, dest_sg, src_sg, size);
 	mutex_unlock(&crypt_stat->cs_tfm_mutex);
 out:
 	return rc;
@@ -681,12 +708,17 @@ static int decrypt_scatterlist(struct ec
 			       struct scatterlist *src_sg, int size,
 			       unsigned char *iv)
 {
+	struct blkcipher_desc desc = {
+		.tfm = crypt_stat->tfm,
+		.info = iv,
+		.flags = CRYPTO_TFM_REQ_MAY_SLEEP
+	};
 	int rc = 0;
 
 	/* Consider doing this once, when the file is opened */
 	mutex_lock(&crypt_stat->cs_tfm_mutex);
-	rc = crypto_cipher_setkey(crypt_stat->tfm, crypt_stat->key,
-				  crypt_stat->key_size);
+	rc = crypto_blkcipher_setkey(crypt_stat->tfm, crypt_stat->key,
+				     crypt_stat->key_size);
 	if (rc) {
 		ecryptfs_printk(KERN_ERR, "Error setting key; rc = [%d]\n",
 				rc);
@@ -695,8 +727,7 @@ static int decrypt_scatterlist(struct ec
 		goto out;
 	}
 	ecryptfs_printk(KERN_DEBUG, "Decrypting [%d] bytes.\n", size);
-	rc = crypto_cipher_decrypt_iv(crypt_stat->tfm, dest_sg, src_sg, size,
-				      iv);
+	rc = crypto_blkcipher_decrypt_iv(&desc, dest_sg, src_sg, size);
 	mutex_unlock(&crypt_stat->cs_tfm_mutex);
 	if (rc) {
 		ecryptfs_printk(KERN_ERR, "Error decrypting; rc = [%d]\n",
@@ -765,6 +796,7 @@ #define ECRYPTFS_MAX_SCATTERLIST_LEN 4
  */
 int ecryptfs_init_crypt_ctx(struct ecryptfs_crypt_stat *crypt_stat)
 {
+	char *full_alg_name;
 	int rc = -EINVAL;
 
 	if (!crypt_stat->cipher) {
@@ -781,16 +813,24 @@ int ecryptfs_init_crypt_ctx(struct ecryp
 		goto out;
 	}
 	mutex_lock(&crypt_stat->cs_tfm_mutex);
-	crypt_stat->tfm = crypto_alloc_tfm(crypt_stat->cipher,
-					   ECRYPTFS_DEFAULT_CHAINING_MODE
-					   | CRYPTO_TFM_REQ_WEAK_KEY);
-	mutex_unlock(&crypt_stat->cs_tfm_mutex);
+	rc = ecryptfs_crypto_api_algify_cipher_name(&full_alg_name,
+						    crypt_stat->cipher, "cbc");
+	if (rc)
+		goto out;	
+	crypt_stat->tfm = crypto_alloc_blkcipher(full_alg_name, 0,
+						 CRYPTO_ALG_ASYNC);
+	kfree(full_alg_name);
 	if (!crypt_stat->tfm) {
 		ecryptfs_printk(KERN_ERR, "cryptfs: init_crypt_ctx(): "
 				"Error initializing cipher [%s]\n",
 				crypt_stat->cipher);
+		mutex_unlock(&crypt_stat->cs_tfm_mutex);
 		goto out;
 	}
+	crypto_blkcipher_set_flags(crypt_stat->tfm,
+				   (ECRYPTFS_DEFAULT_CHAINING_MODE
+				    | CRYPTO_TFM_REQ_WEAK_KEY));
+	mutex_unlock(&crypt_stat->cs_tfm_mutex);
 	rc = 0;
 out:
 	return rc;
@@ -1588,10 +1628,11 @@ out:
  * event, regardless of whether this function succeeds for fails.
  */
 int
-ecryptfs_process_cipher(struct crypto_tfm **key_tfm, char *cipher_name,
+ecryptfs_process_cipher(struct crypto_blkcipher **key_tfm, char *cipher_name,
 			size_t *key_size)
 {
 	char dummy_key[ECRYPTFS_MAX_KEY_BYTES];
+	char *full_alg_name;
 	int rc;
 
 	*key_tfm = NULL;
@@ -1601,17 +1642,26 @@ ecryptfs_process_cipher(struct crypto_tf
 		      "allowable is [%d]\n", *key_size, ECRYPTFS_MAX_KEY_BYTES);
 		goto out;
 	}
-	*key_tfm = crypto_alloc_tfm(cipher_name, CRYPTO_TFM_REQ_WEAK_KEY);
-	if (!(*key_tfm)) {
-		rc = -EINVAL;
+	rc = ecryptfs_crypto_api_algify_cipher_name(&full_alg_name, cipher_name,
+						    "ecb");
+	if (rc)
+		goto out;
+	*key_tfm = crypto_alloc_blkcipher(full_alg_name, 0, CRYPTO_ALG_ASYNC);
+	kfree(full_alg_name);
+	if (IS_ERR(*key_tfm)) {
+		rc = PTR_ERR(*key_tfm);
 		printk(KERN_ERR "Unable to allocate crypto cipher with name "
-		       "[%s]\n", cipher_name);
+		       "[%s]; rc = [%d]\n", cipher_name, rc);
 		goto out;
 	}
-	if (*key_size == 0)
-		*key_size = crypto_tfm_alg_max_keysize(*key_tfm);
+	crypto_blkcipher_set_flags(*key_tfm, CRYPTO_TFM_REQ_WEAK_KEY);
+	if (*key_size == 0) {
+		struct blkcipher_alg *alg = crypto_blkcipher_alg(*key_tfm);
+
+		*key_size = alg->max_keysize;
+	}
 	get_random_bytes(dummy_key, *key_size);
-	rc = crypto_cipher_setkey(*key_tfm, dummy_key, *key_size);
+	rc = crypto_blkcipher_setkey(*key_tfm, dummy_key, *key_size);
 	if (rc) {
 		printk(KERN_ERR "Error attempting to set key of size [%Zd] for "
 		       "cipher [%s]; rc = [%d]\n", *key_size, cipher_name, rc);
diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index 840aa01..199fcda 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -205,7 +205,7 @@ #define ECRYPTFS_KEY_VALID          0x00
 	size_t extent_shift;
 	unsigned int extent_mask;
 	struct ecryptfs_mount_crypt_stat *mount_crypt_stat;
-	struct crypto_tfm *tfm;
+	struct crypto_blkcipher *tfm;
 	struct crypto_hash *hash_tfm; /* Crypto context for generating
 				       * the initialization vectors */
 	unsigned char cipher[ECRYPTFS_MAX_CIPHER_NAME_SIZE];
@@ -245,7 +245,7 @@ #define ECRYPTFS_PLAINTEXT_PASSTHROUGH_E
 	struct ecryptfs_auth_tok *global_auth_tok;
 	struct key *global_auth_tok_key;
 	size_t global_default_cipher_key_size;
-	struct crypto_tfm *global_key_tfm;
+	struct crypto_blkcipher *global_key_tfm;
 	struct mutex global_key_tfm_mutex;
 	unsigned char global_default_cipher_name[ECRYPTFS_MAX_CIPHER_NAME_SIZE
 						 + 1];
@@ -426,6 +426,9 @@ void ecryptfs_destruct_crypt_stat(struct
 void ecryptfs_destruct_mount_crypt_stat(
 	struct ecryptfs_mount_crypt_stat *mount_crypt_stat);
 int ecryptfs_init_crypt_ctx(struct ecryptfs_crypt_stat *crypt_stat);
+int ecryptfs_crypto_api_algify_cipher_name(char **algified_name,
+					   char *cipher_name,
+					   char *chaining_modifier);
 int ecryptfs_write_inode_size_to_header(struct file *lower_file,
 					struct inode *lower_inode,
 					struct inode *inode);
@@ -474,7 +477,7 @@ ecryptfs_parse_packet_set(struct ecryptf
 			  unsigned char *src, struct dentry *ecryptfs_dentry);
 int ecryptfs_truncate(struct dentry *dentry, loff_t new_length);
 int
-ecryptfs_process_cipher(struct crypto_tfm **key_tfm, char *cipher_name,
+ecryptfs_process_cipher(struct crypto_blkcipher **key_tfm, char *cipher_name,
 			size_t *key_size);
 int ecryptfs_inode_test(struct inode *inode, void *candidate_lower_inode);
 int ecryptfs_inode_set(struct inode *inode, void *lower_inode);
diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index bc706d3..8a9ff86 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -458,14 +458,16 @@ out:
 static int decrypt_session_key(struct ecryptfs_auth_tok *auth_tok,
 			       struct ecryptfs_crypt_stat *crypt_stat)
 {
-	int rc = 0;
 	struct ecryptfs_password *password_s_ptr;
-	struct crypto_tfm *tfm = NULL;
 	struct scatterlist src_sg[2], dst_sg[2];
 	struct mutex *tfm_mutex = NULL;
 	/* TODO: Use virt_to_scatterlist for these */
 	char *encrypted_session_key;
 	char *session_key;
+	struct blkcipher_desc desc = {
+		.flags = CRYPTO_TFM_REQ_MAY_SLEEP
+	};
+	int rc = 0;
 
 	password_s_ptr = &auth_tok->token.password;
 	if (ECRYPTFS_CHECK_FLAG(password_s_ptr->flags,
@@ -482,22 +484,32 @@ static int decrypt_session_key(struct ec
 	if (!strcmp(crypt_stat->cipher,
 		    crypt_stat->mount_crypt_stat->global_default_cipher_name)
 	    && crypt_stat->mount_crypt_stat->global_key_tfm) {
-		tfm = crypt_stat->mount_crypt_stat->global_key_tfm;
+		desc.tfm = crypt_stat->mount_crypt_stat->global_key_tfm;
 		tfm_mutex = &crypt_stat->mount_crypt_stat->global_key_tfm_mutex;
 	} else {
-		tfm = crypto_alloc_tfm(crypt_stat->cipher,
-				       CRYPTO_TFM_REQ_WEAK_KEY);
-		if (!tfm) {
-			printk(KERN_ERR "Error allocating crypto context\n");
-			rc = -ENOMEM;
+		char *full_alg_name;
+
+		rc = ecryptfs_crypto_api_algify_cipher_name(&full_alg_name,
+							    crypt_stat->cipher,
+							    "ecb");
+		if (rc)
+			goto out;	
+		desc.tfm = crypto_alloc_blkcipher(full_alg_name, 0,
+						  CRYPTO_ALG_ASYNC);
+		kfree(full_alg_name);
+		if (IS_ERR(desc.tfm)) {
+			rc = PTR_ERR(desc.tfm);
+			printk(KERN_ERR "Error allocating crypto context; "
+			       "rc = [%d]\n", rc);
 			goto out;
 		}
+		crypto_blkcipher_set_flags(desc.tfm, CRYPTO_TFM_REQ_WEAK_KEY);
 	}
 	if (tfm_mutex)
 		mutex_lock(tfm_mutex);
-	rc = crypto_cipher_setkey(tfm,
-				  password_s_ptr->session_key_encryption_key,
-				  crypt_stat->key_size);
+	rc = crypto_blkcipher_setkey(desc.tfm,
+				     password_s_ptr->session_key_encryption_key,
+				     crypt_stat->key_size);
 	if (rc < 0) {
 		printk(KERN_ERR "Error setting key for crypto context\n");
 		rc = -EINVAL;
@@ -528,9 +540,12 @@ static int decrypt_session_key(struct ec
 	auth_tok->session_key.decrypted_key_size =
 	    auth_tok->session_key.encrypted_key_size;
 	dst_sg[0].length = auth_tok->session_key.encrypted_key_size;
-	/* TODO: Handle error condition */
-	crypto_cipher_decrypt(tfm, dst_sg, src_sg,
-			      auth_tok->session_key.encrypted_key_size);
+	rc = crypto_blkcipher_decrypt(&desc, dst_sg, src_sg,
+				      auth_tok->session_key.encrypted_key_size);
+	if (rc) {
+		printk(KERN_ERR "Error decrypting; rc = [%d]\n", rc);
+		goto out_free_memory;
+	}
 	auth_tok->session_key.decrypted_key_size =
 	    auth_tok->session_key.encrypted_key_size;
 	memcpy(auth_tok->session_key.decrypted_key, session_key,
@@ -543,6 +558,7 @@ static int decrypt_session_key(struct ec
 	if (ecryptfs_verbosity > 0)
 		ecryptfs_dump_hex(crypt_stat->key,
 				  crypt_stat->key_size);
+out_free_memory:
 	memset(encrypted_session_key, 0, PAGE_CACHE_SIZE);
 	free_page((unsigned long)encrypted_session_key);
 	memset(session_key, 0, PAGE_CACHE_SIZE);
@@ -551,7 +567,7 @@ out_free_tfm:
 	if (tfm_mutex)
 		mutex_unlock(tfm_mutex);
 	else
-		crypto_free_tfm(tfm);
+		crypto_free_blkcipher(desc.tfm);
 out:
 	return rc;
 }
@@ -800,19 +816,21 @@ write_tag_3_packet(char *dest, size_t ma
 		   struct ecryptfs_crypt_stat *crypt_stat,
 		   struct ecryptfs_key_record *key_rec, size_t *packet_size)
 {
-	int rc = 0;
-
 	size_t i;
 	size_t signature_is_valid = 0;
 	size_t encrypted_session_key_valid = 0;
 	char session_key_encryption_key[ECRYPTFS_MAX_KEY_BYTES];
 	struct scatterlist dest_sg[2];
 	struct scatterlist src_sg[2];
-	struct crypto_tfm *tfm = NULL;
 	struct mutex *tfm_mutex = NULL;
 	size_t key_rec_size;
 	size_t packet_size_length;
 	size_t cipher_code;
+	struct blkcipher_desc desc = {
+		.tfm = NULL,
+		.flags = CRYPTO_TFM_REQ_MAY_SLEEP
+	};	
+	int rc = 0;
 
 	(*packet_size) = 0;
 	/* Check for a valid signature on the auth_tok */
@@ -879,33 +897,48 @@ write_tag_3_packet(char *dest, size_t ma
 	if (!strcmp(crypt_stat->cipher,
 		    crypt_stat->mount_crypt_stat->global_default_cipher_name)
 	    && crypt_stat->mount_crypt_stat->global_key_tfm) {
-		tfm = crypt_stat->mount_crypt_stat->global_key_tfm;
+		desc.tfm = crypt_stat->mount_crypt_stat->global_key_tfm;
 		tfm_mutex = &crypt_stat->mount_crypt_stat->global_key_tfm_mutex;
-	} else
-		tfm = crypto_alloc_tfm(crypt_stat->cipher, 0);
-	if (!tfm) {
-		ecryptfs_printk(KERN_ERR, "Could not initialize crypto "
-				"context for cipher [%s]\n",
-				crypt_stat->cipher);
-		rc = -EINVAL;
-		goto out;
+	} else {
+		char *full_alg_name;
+
+		rc = ecryptfs_crypto_api_algify_cipher_name(&full_alg_name,
+							    crypt_stat->cipher,
+							    "ecb");
+		if (rc)
+			goto out;	
+		desc.tfm = crypto_alloc_blkcipher(full_alg_name, 0,
+						  CRYPTO_ALG_ASYNC);
+		kfree(full_alg_name);
+		if (IS_ERR(desc.tfm)) {
+			rc = PTR_ERR(desc.tfm);
+			ecryptfs_printk(KERN_ERR, "Could not initialize crypto "
+					"context for cipher [%s]; rc = [%d]\n",
+					crypt_stat->cipher, rc);
+			goto out;
+		}
+		crypto_blkcipher_set_flags(desc.tfm, CRYPTO_TFM_REQ_WEAK_KEY);
 	}
 	if (tfm_mutex)
 		mutex_lock(tfm_mutex);
-	rc = crypto_cipher_setkey(tfm, session_key_encryption_key,
-				  crypt_stat->key_size);
+	rc = crypto_blkcipher_setkey(desc.tfm, session_key_encryption_key,
+				     crypt_stat->key_size);
 	if (rc < 0) {
 		if (tfm_mutex)
 			mutex_unlock(tfm_mutex);
 		ecryptfs_printk(KERN_ERR, "Error setting key for crypto "
-				"context\n");
+				"context; rc = [%d]\n", rc);
 		goto out;
 	}
 	rc = 0;
 	ecryptfs_printk(KERN_DEBUG, "Encrypting [%d] bytes of the key\n",
 			crypt_stat->key_size);
-	crypto_cipher_encrypt(tfm, dest_sg, src_sg,
-			      (*key_rec).enc_key_size);
+	rc = crypto_blkcipher_encrypt(&desc, dest_sg, src_sg,
+				      (*key_rec).enc_key_size);
+	if (rc) {
+		printk(KERN_ERR "Error encrypting; rc = [%d]\n", rc);
+		goto out;
+	}
 	if (tfm_mutex)
 		mutex_unlock(tfm_mutex);
 	ecryptfs_printk(KERN_DEBUG, "This should be the encrypted key:\n");
@@ -968,8 +1001,8 @@ encrypted_session_key_set:
 	       (*key_rec).enc_key_size);
 	(*packet_size) += (*key_rec).enc_key_size;
 out:
-	if (tfm && !tfm_mutex)
-		crypto_free_tfm(tfm);
+	if (desc.tfm && !tfm_mutex)
+		crypto_free_blkcipher(desc.tfm);
 	if (rc)
 		(*packet_size) = 0;
 	return rc;
diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index a65f486..a78d87d 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -315,6 +315,8 @@ static int ecryptfs_parse_options(struct
 		       "with key size [%Zd] bytes; rc = [%d]\n",
 		       mount_crypt_stat->global_default_cipher_name,
 		       mount_crypt_stat->global_default_cipher_key_size, rc);
+		mount_crypt_stat->global_key_tfm = NULL;
+		mount_crypt_stat->global_auth_tok_key = NULL;
 		rc = -EINVAL;
 		goto out;
 	}
-- 
1.3.3

