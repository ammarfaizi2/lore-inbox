Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbWFTVZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbWFTVZP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 17:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWFTVZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 17:25:14 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:28296 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751148AbWFTVYp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 17:24:45 -0400
In-reply-to: <20060620212134.GB18701@us.ibm.com>
From: Mike Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Mike Halcrow <mhalcrow@us.ibm.com>, Mike Halcrow <mike@halcrow.us>
Subject: [PATCH 12/12] More intelligent use of TFM objects
Message-Id: <E1FsniC-0007Ae-2h@localhost.localdomain>
Date: Tue, 20 Jun 2006 16:24:40 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More intelligent use of crypto context (tfm) objects. Add locking for
tfm's belonging to inode's. Make the mount-wide crypt_stat referenced
by each inode crypt_stat. Add a cipher validity check on mount. Use
the mount's tfm for key encryption operations, since such operations
only occur on file open.

This patch finishes the set of patches that, among a few other things,
provides the ability for the user to specify his cipher and key size
at mount time.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/crypto.c          |  129 ++++++++++++++++++++++++++++++++++++++---
 fs/ecryptfs/ecryptfs_kernel.h |   10 +++
 fs/ecryptfs/keystore.c        |   45 +++++++++++---
 fs/ecryptfs/main.c            |   57 ++++++++++++------
 fs/ecryptfs/super.c           |    4 +
 5 files changed, 208 insertions(+), 37 deletions(-)

fb18cbd2fde3da3c3a38f95ca2f33343669493cc
diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 5727753..0ea3f5c 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -158,10 +158,13 @@ out:
  *
  * Initialize the crypt_stat structure.
  */
-void ecryptfs_init_crypt_stat(struct ecryptfs_crypt_stat *crypt_stat)
+void
+ecryptfs_init_crypt_stat(struct ecryptfs_crypt_stat *crypt_stat)
 {
 	memset((void *)crypt_stat, 0, sizeof(struct ecryptfs_crypt_stat));
 	mutex_init(&crypt_stat->cs_mutex);
+	mutex_init(&crypt_stat->cs_tfm_mutex);
+	mutex_init(&crypt_stat->cs_md5_tfm_mutex);
 	ECRYPTFS_SET_FLAG(crypt_stat->flags, ECRYPTFS_STRUCT_INITIALIZED);
 }
 
@@ -180,6 +183,17 @@ void ecryptfs_destruct_crypt_stat(struct
 	memset(crypt_stat, 0, sizeof(struct ecryptfs_crypt_stat));
 }
 
+void ecryptfs_destruct_mount_crypt_stat(
+	struct ecryptfs_mount_crypt_stat *mount_crypt_stat)
+{
+	printk(KERN_INFO "%s\n", __FUNCTION__);
+	if (mount_crypt_stat->global_auth_tok_key)
+		key_put(mount_crypt_stat->global_auth_tok_key);
+	if (mount_crypt_stat->global_key_tfm)
+		crypto_free_tfm(mount_crypt_stat->global_key_tfm);
+	memset(mount_crypt_stat, 0, sizeof(struct ecryptfs_mount_crypt_stat));
+}
+
 /**
  * virt_to_scatterlist
  * @addr: Virtual address
@@ -254,16 +268,19 @@ static int encrypt_scatterlist(struct ec
 				  crypt_stat->key_size);
 	}
 	/* Consider doing this once, when the file is opened */
+	mutex_lock(&crypt_stat->cs_tfm_mutex);
 	rc = crypto_cipher_setkey(crypt_stat->tfm, crypt_stat->key,
 				  crypt_stat->key_size);
 	if (rc) {
 		ecryptfs_printk(KERN_ERR, "Error setting key; rc = [%d]\n",
 				rc);
+		mutex_unlock(&crypt_stat->cs_tfm_mutex);
 		rc = -EINVAL;
 		goto out;
 	}
 	ecryptfs_printk(KERN_DEBUG, "Encrypting [%d] bytes.\n", size);
 	crypto_cipher_encrypt_iv(crypt_stat->tfm, dest_sg, src_sg, size, iv);
+	mutex_unlock(&crypt_stat->cs_tfm_mutex);
 out:
 	return rc;
 }
@@ -645,17 +662,20 @@ static int decrypt_scatterlist(struct ec
 	int rc = 0;
 
 	/* Consider doing this once, when the file is opened */
+	mutex_lock(&crypt_stat->cs_tfm_mutex);
 	rc = crypto_cipher_setkey(crypt_stat->tfm, crypt_stat->key,
 				  crypt_stat->key_size);
 	if (rc) {
 		ecryptfs_printk(KERN_ERR, "Error setting key; rc = [%d]\n",
 				rc);
+		mutex_unlock(&crypt_stat->cs_tfm_mutex);
 		rc = -EINVAL;
 		goto out;
 	}
 	ecryptfs_printk(KERN_DEBUG, "Decrypting [%d] bytes.\n", size);
 	rc = crypto_cipher_decrypt_iv(crypt_stat->tfm, dest_sg, src_sg, size,
 				      iv);
+	mutex_unlock(&crypt_stat->cs_tfm_mutex);
 	if (rc) {
 		ecryptfs_printk(KERN_ERR, "Error decrypting; rc = [%d]\n",
 				rc);
@@ -725,7 +745,7 @@ int ecryptfs_init_crypt_ctx(struct ecryp
 {
 	int rc = -EINVAL;
 
-	if (crypt_stat->cipher == NULL) {
+	if (!crypt_stat->cipher) {
 		ecryptfs_printk(KERN_ERR, "No cipher specified\n");
 		goto out;
 	}
@@ -738,12 +758,14 @@ int ecryptfs_init_crypt_ctx(struct ecryp
 		rc = 0;
 		goto out;
 	}
+	mutex_lock(&crypt_stat->cs_tfm_mutex);
 	crypt_stat->tfm = crypto_alloc_tfm(crypt_stat->cipher,
 					   ECRYPTFS_DEFAULT_CHAINING_MODE
 					   | CRYPTO_TFM_REQ_WEAK_KEY);
-	if (crypt_stat->tfm == NULL) {
-		ecryptfs_printk(KERN_ERR, "cryptfs: init_crypt_ctx(): Error "
-				"initializing cipher [%s]\n",
+	mutex_unlock(&crypt_stat->cs_tfm_mutex);
+	if (!crypt_stat->tfm) {
+		ecryptfs_printk(KERN_ERR, "cryptfs: init_crypt_ctx(): "
+				"Error initializing cipher [%s]\n",
 				crypt_stat->cipher);
 		goto out;
 	}
@@ -837,14 +859,16 @@ static void ecryptfs_generate_new_key(st
  *
  * Default values in the event that policy does not override them.
  */
-static void
-ecryptfs_set_default_crypt_stat_vals(struct ecryptfs_crypt_stat *crypt_stat)
+static void ecryptfs_set_default_crypt_stat_vals(
+	struct ecryptfs_crypt_stat *crypt_stat,
+	struct ecryptfs_mount_crypt_stat *mount_crypt_stat)
 {
 	ecryptfs_set_default_sizes(crypt_stat);
 	strcpy(crypt_stat->cipher, ECRYPTFS_DEFAULT_CIPHER);
 	crypt_stat->key_size = ECRYPTFS_DEFAULT_KEY_BYTES;
 	ECRYPTFS_CLEAR_FLAG(crypt_stat->flags, ECRYPTFS_KEY_VALID);
 	crypt_stat->file_version = ECRYPTFS_FILE_VERSION;
+	crypt_stat->mount_crypt_stat = mount_crypt_stat;
 }
 
 /**
@@ -877,7 +901,7 @@ int ecryptfs_new_file_context(struct den
 		    ecryptfs_dentry->d_sb)->mount_crypt_stat;
 	int cipher_name_len;
 
-	ecryptfs_set_default_crypt_stat_vals(crypt_stat);
+	ecryptfs_set_default_crypt_stat_vals(crypt_stat, mount_crypt_stat);
 	/* See if there are mount crypt options */
 	if (mount_crypt_stat->global_auth_tok) {
 		ecryptfs_printk(KERN_DEBUG, "Initializing context for new "
@@ -1353,6 +1377,8 @@ int ecryptfs_read_headers_virt(char *pag
 	int bytes_read;
 
 	ecryptfs_set_default_sizes(crypt_stat);
+	crypt_stat->mount_crypt_stat = &ecryptfs_superblock_to_private(
+		ecryptfs_dentry->d_sb)->mount_crypt_stat;
 	offset = ECRYPTFS_FILE_SIZE_BYTES;
 	rc = contains_ecryptfs_marker(page_virt + offset);
 	if (rc == 0) {
@@ -1536,3 +1562,90 @@ ecryptfs_decode_filename(struct ecryptfs
 out:
 	return error;
 }
+
+/**
+ * ecryptfs_process_cipher - Perform cipher initialization.
+ * @tfm: Crypto context set by this function
+ * @key_tfm: Crypto context for key material, set by this function
+ * @cipher_name: Name of the cipher.
+ * @key_size: Size of the key in bytes.
+ *
+ * Returns zero on success. Any crypto_tfm structs allocated here
+ * should be released by other functions, such as on a superblock put
+ * event, regardless of whether this function succeeds for fails.
+ */
+int
+ecryptfs_process_cipher(struct crypto_tfm **tfm, struct crypto_tfm **key_tfm,
+			char *cipher_name, unsigned int key_size)
+{
+	char dummy_key[ECRYPTFS_MAX_KEY_BYTES];
+	int rc;
+
+	*tfm = *key_tfm = NULL;
+	if (key_size > ECRYPTFS_MAX_KEY_BYTES) {
+		rc = -EINVAL;
+		printk(KERN_ERR "Requested key size is [%d] bytes; maximum "
+		       "allowable is [%d]\n", key_size, ECRYPTFS_MAX_KEY_BYTES);
+		goto out;
+	}
+	*tfm = crypto_alloc_tfm(cipher_name, (ECRYPTFS_DEFAULT_CHAINING_MODE
+					      | CRYPTO_TFM_REQ_WEAK_KEY));
+	if (!(*tfm)) {
+		rc = -EINVAL;
+		printk(KERN_ERR "Unable to allocate crypto cipher with name "
+		       "[%s]\n", cipher_name);
+		goto out;
+	}
+	*key_tfm = crypto_alloc_tfm(cipher_name, CRYPTO_TFM_REQ_WEAK_KEY);
+	if (!(*key_tfm)) {
+		rc = -EINVAL;
+		printk(KERN_ERR "Unable to allocate crypto cipher with name "
+		       "[%s]\n", cipher_name);
+		goto out;
+	}
+	if (key_size < crypto_tfm_alg_min_keysize(*tfm)) {
+		rc = -EINVAL;
+		printk(KERN_ERR "Request key size is [%d]; minimum key size "
+		       "supported by cipher [%s] is [%d]\n", key_size,
+		       cipher_name, crypto_tfm_alg_min_keysize(*tfm));
+		goto out;
+	}
+	if (key_size < crypto_tfm_alg_min_keysize(*key_tfm)) {
+		rc = -EINVAL;
+		printk(KERN_ERR "Request key size is [%d]; minimum key size "
+		       "supported by cipher [%s] is [%d]\n", key_size,
+		       cipher_name, crypto_tfm_alg_min_keysize(*key_tfm));
+		goto out;
+	}
+	if (key_size > crypto_tfm_alg_max_keysize(*tfm)) {
+		rc = -EINVAL;
+		printk(KERN_ERR "Request key size is [%d]; maximum key size "
+		       "supported by cipher [%s] is [%d]\n", key_size,
+		       cipher_name, crypto_tfm_alg_min_keysize(*tfm));
+		goto out;
+	}
+	if (key_size > crypto_tfm_alg_max_keysize(*key_tfm)) {
+		rc = -EINVAL;
+		printk(KERN_ERR "Request key size is [%d]; maximum key size "
+		       "supported by cipher [%s] is [%d]\n", key_size,
+		       cipher_name, crypto_tfm_alg_min_keysize(*key_tfm));
+		goto out;
+	}
+	get_random_bytes(dummy_key, key_size);
+	rc = crypto_cipher_setkey(*tfm, dummy_key, key_size);
+	if (rc) {
+		printk(KERN_ERR "Error attempting to set key of size [%d] for "
+		       "cipher [%s]; rc = [%d]\n", key_size, cipher_name, rc);
+		rc = -EINVAL;
+		goto out;
+	}
+	rc = crypto_cipher_setkey(*key_tfm, dummy_key, key_size);
+	if (rc) {
+		printk(KERN_ERR "Error attempting to set key of size [%d] for "
+		       "cipher [%s]; rc = [%d]\n", key_size, cipher_name, rc);
+		rc = -EINVAL;
+		goto out;
+	}
+out:
+	return rc;
+}
diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index d0b9151..c37a452 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -196,6 +196,7 @@ #define ECRYPTFS_KEY_VALID          0x00
 	unsigned int key_size;
 	unsigned int extent_shift;
 	unsigned int extent_mask;
+	struct ecryptfs_mount_crypt_stat *mount_crypt_stat;
 	struct crypto_tfm *tfm;
 	struct crypto_tfm *md5_tfm; /* Crypto context for generating
 				     * the initialization vectors */
@@ -203,6 +204,8 @@ #define ECRYPTFS_KEY_VALID          0x00
 	unsigned char key[ECRYPTFS_MAX_KEY_BYTES];
 	unsigned char root_iv[ECRYPTFS_MAX_IV_BYTES];
 	unsigned char keysigs[ECRYPTFS_MAX_NUM_KEYSIGS][ECRYPTFS_SIG_SIZE_HEX];
+	struct mutex cs_tfm_mutex;
+	struct mutex cs_md5_tfm_mutex;
 	struct mutex cs_mutex;
 };
 
@@ -230,6 +233,8 @@ struct ecryptfs_mount_crypt_stat {
 	struct ecryptfs_auth_tok *global_auth_tok;
 	struct key *global_auth_tok_key;
 	unsigned int global_default_cipher_key_size;
+	struct crypto_tfm *global_key_tfm;
+	struct mutex global_key_tfm_mutex;
 	unsigned char global_default_cipher_name[ECRYPTFS_MAX_CIPHER_NAME_SIZE
 						 + 1];
 	unsigned char global_auth_tok_sig[ECRYPTFS_SIG_SIZE_HEX + 1];
@@ -408,6 +413,8 @@ int ecryptfs_compute_root_iv(struct ecry
 void ecryptfs_rotate_iv(unsigned char *iv);
 void ecryptfs_init_crypt_stat(struct ecryptfs_crypt_stat *crypt_stat);
 void ecryptfs_destruct_crypt_stat(struct ecryptfs_crypt_stat *crypt_stat);
+void ecryptfs_destruct_mount_crypt_stat(
+	struct ecryptfs_mount_crypt_stat *mount_crypt_stat);
 int ecryptfs_init_crypt_ctx(struct ecryptfs_crypt_stat *crypt_stat);
 int ecryptfs_write_inode_size_to_header(struct file *lower_file,
 					struct inode *lower_inode,
@@ -465,5 +472,8 @@ int
 ecryptfs_parse_packet_set(struct ecryptfs_crypt_stat *crypt_stat,
 			  unsigned char *src, struct dentry *ecryptfs_dentry);
 int ecryptfs_truncate(struct dentry *dentry, loff_t new_length);
+int
+ecryptfs_process_cipher(struct crypto_tfm **tfm, struct crypto_tfm **key_tfm,
+			char *cipher_name, unsigned int key_size);
 
 #endif /* #ifndef ECRYPTFS_KERNEL_H */
diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index 09a56f3..e80d7a6 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -460,6 +460,7 @@ static int decrypt_session_key(struct ec
 	struct ecryptfs_password *password_s_ptr;
 	struct crypto_tfm *tfm = NULL;
 	struct scatterlist src_sg[2], dst_sg[2];
+	struct mutex *tfm_mutex = NULL;
 	/* TODO: Use virt_to_scatterlist for these */
 	char *encrypted_session_key;
 	char *session_key;
@@ -476,12 +477,19 @@ static int decrypt_session_key(struct ec
 		ecryptfs_dump_hex(password_s_ptr->session_key_encryption_key,
 				  password_s_ptr->
 				  session_key_encryption_key_bytes);
-	tfm = crypto_alloc_tfm(crypt_stat->cipher, 0);
-	if (!tfm) {
-		ecryptfs_printk(KERN_ERR, "Error allocating crypto "
-				"context\n");
-		rc = -ENOMEM;
-		goto out;
+	if (!strcmp(crypt_stat->cipher,
+		    crypt_stat->mount_crypt_stat->global_default_cipher_name)
+	    && crypt_stat->mount_crypt_stat->global_key_tfm) {
+		tfm = crypt_stat->mount_crypt_stat->global_key_tfm;
+		tfm_mutex = &crypt_stat->mount_crypt_stat->global_key_tfm_mutex;
+	} else {
+		tfm = crypto_alloc_tfm(crypt_stat->cipher,
+				       CRYPTO_TFM_REQ_WEAK_KEY);
+		if (!tfm) {
+			printk(KERN_ERR "Error allocating crypto context\n");
+			rc = -ENOMEM;
+			goto out;
+		}
 	}
 	if (password_s_ptr->session_key_encryption_key_bytes
 	    < crypto_tfm_alg_min_keysize(tfm)) {
@@ -492,6 +500,8 @@ static int decrypt_session_key(struct ec
 		rc = -EINVAL;
 		goto out;
 	}
+	if (tfm_mutex)
+		mutex_lock(tfm_mutex);
 	crypto_cipher_setkey(tfm, password_s_ptr->session_key_encryption_key,
 			     crypt_stat->key_size);
 	/* TODO: virt_to_scatterlist */
@@ -539,7 +549,10 @@ static int decrypt_session_key(struct ec
 	memset(session_key, 0, PAGE_CACHE_SIZE);
 	free_page((unsigned long)session_key);
 out_free_tfm:
-	crypto_free_tfm(tfm);
+	if (tfm_mutex)
+		mutex_unlock(tfm_mutex);
+	else
+		crypto_free_tfm(tfm);
 out:
 	return rc;
 }
@@ -796,6 +809,7 @@ write_tag_3_packet(char *dest, int max, 
 	struct scatterlist dest_sg[2];
 	struct scatterlist src_sg[2];
 	struct crypto_tfm *tfm = NULL;
+	struct mutex *tfm_mutex = NULL;
 	int key_rec_size;
 	int packet_size_length;
 	int cipher_code;
@@ -862,16 +876,27 @@ write_tag_3_packet(char *dest, int max, 
 		rc = -ENOMEM;
 		goto out;
 	}
-	if ((tfm = crypto_alloc_tfm(crypt_stat->cipher, 0)) == NULL) {
+	if (!strcmp(crypt_stat->cipher,
+		    crypt_stat->mount_crypt_stat->global_default_cipher_name)
+	    && crypt_stat->mount_crypt_stat->global_key_tfm) {
+		tfm = crypt_stat->mount_crypt_stat->global_key_tfm;
+		tfm_mutex = &crypt_stat->mount_crypt_stat->global_key_tfm_mutex;
+	} else
+		tfm = crypto_alloc_tfm(crypt_stat->cipher, 0);
+	if (!tfm) {
 		ecryptfs_printk(KERN_ERR, "Could not initialize crypto "
 				"context for cipher [%s]\n",
 				crypt_stat->cipher);
 		rc = -EINVAL;
 		goto out;
 	}
+	if (tfm_mutex)
+		mutex_lock(tfm_mutex);
 	rc = crypto_cipher_setkey(tfm, session_key_encryption_key,
 				  crypt_stat->key_size);
 	if (rc < 0) {
+		if (tfm_mutex)
+			mutex_unlock(tfm_mutex);
 		ecryptfs_printk(KERN_ERR, "Error setting key for crypto "
 				"context\n");
 		goto out;
@@ -881,6 +906,8 @@ write_tag_3_packet(char *dest, int max, 
 			crypt_stat->key_size);
 	crypto_cipher_encrypt(tfm, dest_sg, src_sg,
 			      (*key_rec).enc_key_size);
+	if (tfm_mutex)
+		mutex_unlock(tfm_mutex);
 	ecryptfs_printk(KERN_DEBUG, "This should be the encrypted key:\n");
 	if (ecryptfs_verbosity > 0)
 		ecryptfs_dump_hex((*key_rec).enc_key,
@@ -941,7 +968,7 @@ encrypted_session_key_set:
 	       (*key_rec).enc_key_size);
 	(*packet_size) += (*key_rec).enc_key_size;
 out:
-	if (tfm)
+	if (tfm && !tfm_mutex)
 		crypto_free_tfm(tfm);
 	if (rc)
 		(*packet_size) = 0;
diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index 3a19e00..7598ba0 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -28,6 +28,7 @@ #include <linux/file.h>
 #include <linux/module.h>
 #include <linux/namei.h>
 #include <linux/skbuff.h>
+#include <linux/crypto.h>
 #include <linux/netlink.h>
 #include <linux/mount.h>
 #include <linux/dcache.h>
@@ -212,6 +213,7 @@ static int ecryptfs_parse_options(struct
 	char *cipher_name_dst;
 	char *cipher_name_src;
 	char *cipher_key_bytes_src;
+	struct crypto_tfm *tmp_tfm;
 	int cipher_name_len;
 
 	if (!options) {
@@ -311,6 +313,22 @@ static int ecryptfs_parse_options(struct
 				mount_crypt_stat->
 				global_default_cipher_key_size);
 	}
+	rc = ecryptfs_process_cipher(
+		&tmp_tfm,
+		&mount_crypt_stat->global_key_tfm,
+		mount_crypt_stat->global_default_cipher_name,
+		mount_crypt_stat->global_default_cipher_key_size);
+	if (tmp_tfm)
+		crypto_free_tfm(tmp_tfm);
+	if (rc) {
+		printk(KERN_ERR "Error attempting to initialize cipher [%s] "
+		       "with key size [%d] bytes; rc = [%d]\n",
+		       mount_crypt_stat->global_default_cipher_name,
+		       mount_crypt_stat->global_default_cipher_key_size, rc);
+		rc = -EINVAL;
+		goto out;
+	}
+	mutex_init(&mount_crypt_stat->global_key_tfm_mutex);
 	ecryptfs_printk(KERN_DEBUG, "Requesting the key with description: "
 			"[%s]\n", mount_crypt_stat->global_auth_tok_sig);
 	/* The reference to this key is held until umount is done The
@@ -494,11 +512,13 @@ static struct super_block *ecryptfs_get_
 	}
 	rc = ecryptfs_parse_options(sb, raw_data);
 	if (rc) {
+		deactivate_super(sb);
 		sb = ERR_PTR(rc);
 		goto out;
 	}
 	rc = ecryptfs_read_super(sb, dev_name);
 	if (rc) {
+		deactivate_super(sb);
 		sb = ERR_PTR(rc);
 		ecryptfs_printk(KERN_ERR, "Reading sb failed. "
 				"sb = [%p]\n", sb);
@@ -516,10 +536,9 @@ out:
  */
 static void ecryptfs_kill_block_super(struct super_block *sb)
 {
-	struct ecryptfs_mount_crypt_stat *mount_crypt_stat =
-		&(ecryptfs_superblock_to_private(sb)->mount_crypt_stat);
-
-	memset(mount_crypt_stat, 0, sizeof(struct ecryptfs_mount_crypt_stat));
+	printk(KERN_INFO "%s\n", __FUNCTION__);
+/*	ecryptfs_destruct_mount_crypt_stat(
+	&(ecryptfs_superblock_to_private(sb)->mount_crypt_stat)); */
 	generic_shutdown_super(sb);
 }
 
@@ -549,19 +568,19 @@ inode_info_init_once(void *vptr, struct 
 /* This provides a means of backing out cache creations out of the kernel
  * so that we can elegantly fail should we run out of memory.
  */
-#define ECRYPTFS_AUTH_TOK_LIST_ITEM_CACHE 	0x0001
-#define ECRYPTFS_AUTH_TOK_PKT_SET_CACHE         0x0002
-#define ECRYPTFS_AUTH_TOK_REQUEST_CACHE         0x0004
-#define ECRYPTFS_AUTH_TOK_REQUEST_BLOB_CACHE    0x0008
-#define ECRYPTFS_FILE_INFO_CACHE 		0x0010
-#define ECRYPTFS_DENTRY_INFO_CACHE 		0x0020
-#define ECRYPTFS_INODE_INFO_CACHE 		0x0040
-#define ECRYPTFS_SB_INFO_CACHE 			0x0080
-#define ECRYPTFS_HEADER_CACHE_0 		0x0100
-#define ECRYPTFS_HEADER_CACHE_1 		0x0200
-#define ECRYPTFS_HEADER_CACHE_2 		0x0400
-#define ECRYPTFS_LOWER_PAGE_CACHE 		0x0800
-#define ECRYPTFS_CACHE_CREATION_SUCCESS		0x0FF1
+#define ECRYPTFS_AUTH_TOK_LIST_ITEM_CACHE    0x0001
+#define ECRYPTFS_AUTH_TOK_PKT_SET_CACHE      0x0002
+#define ECRYPTFS_AUTH_TOK_REQUEST_CACHE      0x0004
+#define ECRYPTFS_AUTH_TOK_REQUEST_BLOB_CACHE 0x0008
+#define ECRYPTFS_FILE_INFO_CACHE             0x0010
+#define ECRYPTFS_DENTRY_INFO_CACHE           0x0020
+#define ECRYPTFS_INODE_INFO_CACHE            0x0040
+#define ECRYPTFS_SB_INFO_CACHE               0x0080
+#define ECRYPTFS_HEADER_CACHE_0              0x0100
+#define ECRYPTFS_HEADER_CACHE_1              0x0200
+#define ECRYPTFS_HEADER_CACHE_2              0x0400
+#define ECRYPTFS_LOWER_PAGE_CACHE            0x0800
+#define ECRYPTFS_CACHE_CREATION_SUCCESS      0x0FF1
 
 static short ecryptfs_allocated_caches;
 
@@ -599,13 +618,13 @@ static int ecryptfs_init_kmem_caches(voi
 				"kmem_cache_create failed\n");
 
 	ecryptfs_dentry_info_cache =
-	    kmem_cache_create("ecryptfs_dentry_cache",
+	    kmem_cache_create("ecryptfs_dentry_info_cache",
 			      sizeof(struct ecryptfs_dentry_info),
 			      0, SLAB_HWCACHE_ALIGN, NULL, NULL);
 	if (ecryptfs_dentry_info_cache)
 		rc |= ECRYPTFS_DENTRY_INFO_CACHE;
 	else
-		ecryptfs_printk(KERN_WARNING, "ecryptfs_dentry_cache "
+		ecryptfs_printk(KERN_WARNING, "ecryptfs_dentry_info_cache "
 				"kmem_cache_create failed\n");
 
 	ecryptfs_inode_info_cache =
diff --git a/fs/ecryptfs/super.c b/fs/ecryptfs/super.c
index 94c50f1..b60bf07 100644
--- a/fs/ecryptfs/super.c
+++ b/fs/ecryptfs/super.c
@@ -27,6 +27,7 @@ #include <linux/fs.h>
 #include <linux/mount.h>
 #include <linux/key.h>
 #include <linux/seq_file.h>
+#include <linux/crypto.h>
 #include "ecryptfs_kernel.h"
 
 struct kmem_cache *ecryptfs_inode_info_cache;
@@ -107,8 +108,9 @@ static void ecryptfs_put_super(struct su
 {
 	struct ecryptfs_sb_info *sb_info = ecryptfs_superblock_to_private(sb);
 
+	printk(KERN_INFO "%s\n", __FUNCTION__);
 	mntput(sb_info->lower_mnt);
-	key_put(sb_info->mount_crypt_stat.global_auth_tok_key);
+	ecryptfs_destruct_mount_crypt_stat(&sb_info->mount_crypt_stat);
 	kmem_cache_free(ecryptfs_sb_info_cache, sb_info);
 	ecryptfs_set_superblock_private(sb, NULL);
 }
-- 
1.3.3

