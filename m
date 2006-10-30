Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422755AbWJ3XdS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422755AbWJ3XdS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 18:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422756AbWJ3XdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 18:33:18 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:37081 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1422755AbWJ3XdQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 18:33:16 -0500
Date: Mon, 30 Oct 2006 17:33:15 -0600
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: akpm@osdl.org
Cc: LKML <linux-kernel@vger.kernel.org>, mhalcrow@us.ibm.com
Subject: [PATCH 1/6] eCryptfs: Clean up crypto initialization
Message-ID: <20061030233315.GD3458@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20061030233209.GC3458@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061030233209.GC3458@us.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the crypto initialization code; let the crypto API take care
of the key size checks.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/crypto.c          |   66 +++++++----------------------------------
 fs/ecryptfs/ecryptfs_kernel.h |    4 +-
 fs/ecryptfs/keystore.c        |   19 +++++-------
 fs/ecryptfs/main.c            |   13 +-------
 4 files changed, 24 insertions(+), 78 deletions(-)

4a2f411a7a2449b5dd09e5b9688dbd76e7b2b280
diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index ed35a97..82e7d02 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -1573,35 +1573,26 @@ out:
 
 /**
  * ecryptfs_process_cipher - Perform cipher initialization.
- * @tfm: Crypto context set by this function
  * @key_tfm: Crypto context for key material, set by this function
- * @cipher_name: Name of the cipher.
- * @key_size: Size of the key in bytes.
+ * @cipher_name: Name of the cipher
+ * @key_size: Size of the key in bytes
  *
  * Returns zero on success. Any crypto_tfm structs allocated here
  * should be released by other functions, such as on a superblock put
  * event, regardless of whether this function succeeds for fails.
  */
 int
-ecryptfs_process_cipher(struct crypto_tfm **tfm, struct crypto_tfm **key_tfm,
-			char *cipher_name, size_t key_size)
+ecryptfs_process_cipher(struct crypto_tfm **key_tfm, char *cipher_name,
+			size_t *key_size)
 {
 	char dummy_key[ECRYPTFS_MAX_KEY_BYTES];
 	int rc;
 
-	*tfm = *key_tfm = NULL;
-	if (key_size > ECRYPTFS_MAX_KEY_BYTES) {
+	*key_tfm = NULL;
+	if (*key_size > ECRYPTFS_MAX_KEY_BYTES) {
 		rc = -EINVAL;
 		printk(KERN_ERR "Requested key size is [%Zd] bytes; maximum "
-		       "allowable is [%d]\n", key_size, ECRYPTFS_MAX_KEY_BYTES);
-		goto out;
-	}
-	*tfm = crypto_alloc_tfm(cipher_name, (ECRYPTFS_DEFAULT_CHAINING_MODE
-					      | CRYPTO_TFM_REQ_WEAK_KEY));
-	if (!(*tfm)) {
-		rc = -EINVAL;
-		printk(KERN_ERR "Unable to allocate crypto cipher with name "
-		       "[%s]\n", cipher_name);
+		      "allowable is [%d]\n", *key_size, ECRYPTFS_MAX_KEY_BYTES);
 		goto out;
 	}
 	*key_tfm = crypto_alloc_tfm(cipher_name, CRYPTO_TFM_REQ_WEAK_KEY);
@@ -1611,46 +1602,13 @@ ecryptfs_process_cipher(struct crypto_tf
 		       "[%s]\n", cipher_name);
 		goto out;
 	}
-	if (key_size < crypto_tfm_alg_min_keysize(*tfm)) {
-		rc = -EINVAL;
-		printk(KERN_ERR "Request key size is [%Zd]; minimum key size "
-		       "supported by cipher [%s] is [%d]\n", key_size,
-		       cipher_name, crypto_tfm_alg_min_keysize(*tfm));
-		goto out;
-	}
-	if (key_size < crypto_tfm_alg_min_keysize(*key_tfm)) {
-		rc = -EINVAL;
-		printk(KERN_ERR "Request key size is [%Zd]; minimum key size "
-		       "supported by cipher [%s] is [%d]\n", key_size,
-		       cipher_name, crypto_tfm_alg_min_keysize(*key_tfm));
-		goto out;
-	}
-	if (key_size > crypto_tfm_alg_max_keysize(*tfm)) {
-		rc = -EINVAL;
-		printk(KERN_ERR "Request key size is [%Zd]; maximum key size "
-		       "supported by cipher [%s] is [%d]\n", key_size,
-		       cipher_name, crypto_tfm_alg_min_keysize(*tfm));
-		goto out;
-	}
-	if (key_size > crypto_tfm_alg_max_keysize(*key_tfm)) {
-		rc = -EINVAL;
-		printk(KERN_ERR "Request key size is [%Zd]; maximum key size "
-		       "supported by cipher [%s] is [%d]\n", key_size,
-		       cipher_name, crypto_tfm_alg_min_keysize(*key_tfm));
-		goto out;
-	}
-	get_random_bytes(dummy_key, key_size);
-	rc = crypto_cipher_setkey(*tfm, dummy_key, key_size);
-	if (rc) {
-		printk(KERN_ERR "Error attempting to set key of size [%Zd] for "
-		       "cipher [%s]; rc = [%d]\n", key_size, cipher_name, rc);
-		rc = -EINVAL;
-		goto out;
-	}
-	rc = crypto_cipher_setkey(*key_tfm, dummy_key, key_size);
+	if (*key_size == 0)
+		*key_size = crypto_tfm_alg_max_keysize(*key_tfm);
+	get_random_bytes(dummy_key, *key_size);
+	rc = crypto_cipher_setkey(*key_tfm, dummy_key, *key_size);
 	if (rc) {
 		printk(KERN_ERR "Error attempting to set key of size [%Zd] for "
-		       "cipher [%s]; rc = [%d]\n", key_size, cipher_name, rc);
+		       "cipher [%s]; rc = [%d]\n", *key_size, cipher_name, rc);
 		rc = -EINVAL;
 		goto out;
 	}
diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index 872c995..4112df9 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -473,8 +473,8 @@ ecryptfs_parse_packet_set(struct ecryptf
 			  unsigned char *src, struct dentry *ecryptfs_dentry);
 int ecryptfs_truncate(struct dentry *dentry, loff_t new_length);
 int
-ecryptfs_process_cipher(struct crypto_tfm **tfm, struct crypto_tfm **key_tfm,
-			char *cipher_name, size_t key_size);
+ecryptfs_process_cipher(struct crypto_tfm **key_tfm, char *cipher_name,
+			size_t *key_size);
 int ecryptfs_inode_test(struct inode *inode, void *candidate_lower_inode);
 int ecryptfs_inode_set(struct inode *inode, void *lower_inode);
 void ecryptfs_init_inode(struct inode *inode, struct inode *lower_inode);
diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index ba45478..bc706d3 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -493,19 +493,16 @@ static int decrypt_session_key(struct ec
 			goto out;
 		}
 	}
-	if (password_s_ptr->session_key_encryption_key_bytes
-	    < crypto_tfm_alg_min_keysize(tfm)) {
-		printk(KERN_WARNING "Session key encryption key is [%d] bytes; "
-		       "minimum keysize for selected cipher is [%d] bytes.\n",
-		       password_s_ptr->session_key_encryption_key_bytes,
-		       crypto_tfm_alg_min_keysize(tfm));
-		rc = -EINVAL;
-		goto out;
-	}
 	if (tfm_mutex)
 		mutex_lock(tfm_mutex);
-	crypto_cipher_setkey(tfm, password_s_ptr->session_key_encryption_key,
-			     crypt_stat->key_size);
+	rc = crypto_cipher_setkey(tfm,
+				  password_s_ptr->session_key_encryption_key,
+				  crypt_stat->key_size);
+	if (rc < 0) {
+		printk(KERN_ERR "Error setting key for crypto context\n");
+		rc = -EINVAL;
+		goto out_free_tfm;
+	}
 	/* TODO: virt_to_scatterlist */
 	encrypted_session_key = (char *)__get_free_page(GFP_KERNEL);
 	if (!encrypted_session_key) {
diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index 5938a23..a65f486 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -208,7 +208,6 @@ static int ecryptfs_parse_options(struct
 	char *cipher_name_dst;
 	char *cipher_name_src;
 	char *cipher_key_bytes_src;
-	struct crypto_tfm *tmp_tfm;
 	int cipher_name_len;
 
 	if (!options) {
@@ -305,20 +304,12 @@ static int ecryptfs_parse_options(struct
 		    = '\0';
 	}
 	if (!cipher_key_bytes_set) {
-		mount_crypt_stat->global_default_cipher_key_size =
-			ECRYPTFS_DEFAULT_KEY_BYTES;
-		ecryptfs_printk(KERN_DEBUG, "Cipher key size was not "
-				"specified.  Defaulting to [%d]\n",
-				mount_crypt_stat->
-				global_default_cipher_key_size);
+		mount_crypt_stat->global_default_cipher_key_size = 0;
 	}
 	rc = ecryptfs_process_cipher(
-		&tmp_tfm,
 		&mount_crypt_stat->global_key_tfm,
 		mount_crypt_stat->global_default_cipher_name,
-		mount_crypt_stat->global_default_cipher_key_size);
-	if (tmp_tfm)
-		crypto_free_tfm(tmp_tfm);
+		&mount_crypt_stat->global_default_cipher_key_size);
 	if (rc) {
 		printk(KERN_ERR "Error attempting to initialize cipher [%s] "
 		       "with key size [%Zd] bytes; rc = [%d]\n",
-- 
1.3.3

