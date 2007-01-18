Return-Path: <linux-kernel-owner+w=401wt.eu-S1751532AbXARV2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbXARV2K (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 16:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751556AbXARV2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 16:28:10 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:33863 "EHLO e6.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751532AbXARV2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 16:28:08 -0500
Date: Thu, 18 Jan 2007 15:28:05 -0600
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] eCryptfs: open-code flag checking and manipulation
Message-ID: <20070118212805.GE3643@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20070118212627.GC3643@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070118212627.GC3643@us.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Open-code flag checking and manipulation.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>
Signed-off-by: Trevor Highland <tshighla@us.ibm.com>

---

 fs/ecryptfs/crypto.c          |   37 +++++++++++++++----------------------
 fs/ecryptfs/debug.c           |    6 +++---
 fs/ecryptfs/ecryptfs_kernel.h |    3 ---
 fs/ecryptfs/file.c            |   17 +++++++----------
 fs/ecryptfs/inode.c           |   14 ++++++--------
 fs/ecryptfs/keystore.c        |   32 ++++++++++++++------------------
 fs/ecryptfs/mmap.c            |    8 ++++----
 7 files changed, 49 insertions(+), 68 deletions(-)

3cb9652018a1be5ae400bb9bb105bb5685fbc302
diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index ac4ea8d..e03113c 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -207,7 +207,7 @@ ecryptfs_init_crypt_stat(struct ecryptfs
 	mutex_init(&crypt_stat->cs_mutex);
 	mutex_init(&crypt_stat->cs_tfm_mutex);
 	mutex_init(&crypt_stat->cs_hash_tfm_mutex);
-	ECRYPTFS_SET_FLAG(crypt_stat->flags, ECRYPTFS_STRUCT_INITIALIZED);
+	crypt_stat->flags |= ECRYPTFS_STRUCT_INITIALIZED;
 }
 
 /**
@@ -305,8 +305,7 @@ static int encrypt_scatterlist(struct ec
 	int rc = 0;
 
 	BUG_ON(!crypt_stat || !crypt_stat->tfm
-	       || !ECRYPTFS_CHECK_FLAG(crypt_stat->flags,
-				       ECRYPTFS_STRUCT_INITIALIZED));
+	       || !(crypt_stat->flags & ECRYPTFS_STRUCT_INITIALIZED));
 	if (unlikely(ecryptfs_verbosity > 0)) {
 		ecryptfs_printk(KERN_DEBUG, "Key size [%d]; key:\n",
 				crypt_stat->key_size);
@@ -485,7 +484,7 @@ #define ECRYPTFS_PAGE_STATE_WRITTEN   3
 	lower_inode = ecryptfs_inode_to_lower(ctx->page->mapping->host);
 	inode_info = ecryptfs_inode_to_private(ctx->page->mapping->host);
 	crypt_stat = &inode_info->crypt_stat;
-	if (!ECRYPTFS_CHECK_FLAG(crypt_stat->flags, ECRYPTFS_ENCRYPTED)) {
+	if (!(crypt_stat->flags & ECRYPTFS_ENCRYPTED)) {
 		rc = ecryptfs_copy_page_to_lower(ctx->page, lower_inode,
 						 ctx->param.lower_file);
 		if (rc)
@@ -617,7 +616,7 @@ int ecryptfs_decrypt_page(struct file *f
 	crypt_stat = &(ecryptfs_inode_to_private(
 			       page->mapping->host)->crypt_stat);
 	lower_inode = ecryptfs_inode_to_lower(page->mapping->host);
-	if (!ECRYPTFS_CHECK_FLAG(crypt_stat->flags, ECRYPTFS_ENCRYPTED)) {
+	if (!(crypt_stat->flags & ECRYPTFS_ENCRYPTED)) {
 		rc = ecryptfs_do_readpage(file, page, page->index);
 		if (rc)
 			ecryptfs_printk(KERN_ERR, "Error attempting to copy "
@@ -884,7 +883,7 @@ int ecryptfs_compute_root_iv(struct ecry
 
 	BUG_ON(crypt_stat->iv_bytes > MD5_DIGEST_SIZE);
 	BUG_ON(crypt_stat->iv_bytes <= 0);
-	if (!ECRYPTFS_CHECK_FLAG(crypt_stat->flags, ECRYPTFS_KEY_VALID)) {
+	if (!(crypt_stat->flags & ECRYPTFS_KEY_VALID)) {
 		rc = -EINVAL;
 		ecryptfs_printk(KERN_WARNING, "Session key not valid; "
 				"cannot generate root IV\n");
@@ -901,8 +900,7 @@ int ecryptfs_compute_root_iv(struct ecry
 out:
 	if (rc) {
 		memset(crypt_stat->root_iv, 0, crypt_stat->iv_bytes);
-		ECRYPTFS_SET_FLAG(crypt_stat->flags,
-				  ECRYPTFS_SECURITY_WARNING);
+		crypt_stat->flags |= ECRYPTFS_SECURITY_WARNING;
 	}
 	return rc;
 }
@@ -910,7 +908,7 @@ out:
 static void ecryptfs_generate_new_key(struct ecryptfs_crypt_stat *crypt_stat)
 {
 	get_random_bytes(crypt_stat->key, crypt_stat->key_size);
-	ECRYPTFS_SET_FLAG(crypt_stat->flags, ECRYPTFS_KEY_VALID);
+	crypt_stat->flags |= ECRYPTFS_KEY_VALID;
 	ecryptfs_compute_root_iv(crypt_stat);
 	if (unlikely(ecryptfs_verbosity > 0)) {
 		ecryptfs_printk(KERN_DEBUG, "Generated new session key:\n");
@@ -950,7 +948,7 @@ static void ecryptfs_set_default_crypt_s
 	ecryptfs_set_default_sizes(crypt_stat);
 	strcpy(crypt_stat->cipher, ECRYPTFS_DEFAULT_CIPHER);
 	crypt_stat->key_size = ECRYPTFS_DEFAULT_KEY_BYTES;
-	ECRYPTFS_CLEAR_FLAG(crypt_stat->flags, ECRYPTFS_KEY_VALID);
+	crypt_stat->flags &= ~(ECRYPTFS_KEY_VALID);
 	crypt_stat->file_version = ECRYPTFS_FILE_VERSION;
 	crypt_stat->mount_crypt_stat = mount_crypt_stat;
 }
@@ -990,8 +988,8 @@ int ecryptfs_new_file_context(struct den
 	if (mount_crypt_stat->global_auth_tok) {
 		ecryptfs_printk(KERN_DEBUG, "Initializing context for new "
 				"file using mount_crypt_stat\n");
-		ECRYPTFS_SET_FLAG(crypt_stat->flags, ECRYPTFS_ENCRYPTED);
-		ECRYPTFS_SET_FLAG(crypt_stat->flags, ECRYPTFS_KEY_VALID);
+		crypt_stat->flags |= ECRYPTFS_ENCRYPTED;
+		crypt_stat->flags |= ECRYPTFS_KEY_VALID;
 		ecryptfs_copy_mount_wide_flags_to_inode_flags(crypt_stat,
 							      mount_crypt_stat);
 		memcpy(crypt_stat->keysigs[crypt_stat->num_keysigs++],
@@ -1076,11 +1074,9 @@ static int ecryptfs_process_flags(struct
 	for (i = 0; i < ((sizeof(ecryptfs_flag_map)
 			  / sizeof(struct ecryptfs_flag_map_elem))); i++)
 		if (flags & ecryptfs_flag_map[i].file_flag) {
-			ECRYPTFS_SET_FLAG(crypt_stat->flags,
-					  ecryptfs_flag_map[i].local_flag);
+			crypt_stat->flags |= ecryptfs_flag_map[i].local_flag;
 		} else
-			ECRYPTFS_CLEAR_FLAG(crypt_stat->flags,
-					    ecryptfs_flag_map[i].local_flag);
+			crypt_stat->flags &= ~(ecryptfs_flag_map[i].local_flag);
 	/* Version is in top 8 bits of the 32-bit flag vector */
 	crypt_stat->file_version = ((flags >> 24) & 0xFF);
 	(*bytes_read) = 4;
@@ -1117,8 +1113,7 @@ write_ecryptfs_flags(char *page_virt, st
 
 	for (i = 0; i < ((sizeof(ecryptfs_flag_map)
 			  / sizeof(struct ecryptfs_flag_map_elem))); i++)
-		if (ECRYPTFS_CHECK_FLAG(crypt_stat->flags,
-					ecryptfs_flag_map[i].local_flag))
+		if (crypt_stat->flags & ecryptfs_flag_map[i].local_flag)
 			flags |= ecryptfs_flag_map[i].file_flag;
 	/* Version is in top 8 bits of the 32-bit flag vector */
 	flags |= ((((u8)crypt_stat->file_version) << 24) & 0xFF000000);
@@ -1416,10 +1411,8 @@ int ecryptfs_write_metadata(struct dentr
 
 	crypt_stat = &ecryptfs_inode_to_private(
 		ecryptfs_dentry->d_inode)->crypt_stat;
-	if (likely(ECRYPTFS_CHECK_FLAG(crypt_stat->flags,
-				       ECRYPTFS_ENCRYPTED))) {
-		if (!ECRYPTFS_CHECK_FLAG(crypt_stat->flags,
-					 ECRYPTFS_KEY_VALID)) {
+	if (likely(crypt_stat->flags & ECRYPTFS_ENCRYPTED)) {
+		if (!(crypt_stat->flags & ECRYPTFS_KEY_VALID)) {
 			ecryptfs_printk(KERN_DEBUG, "Key is "
 					"invalid; bailing out\n");
 			rc = -EINVAL;
diff --git a/fs/ecryptfs/debug.c b/fs/ecryptfs/debug.c
index 61f8e89..434c7ef 100644
--- a/fs/ecryptfs/debug.c
+++ b/fs/ecryptfs/debug.c
@@ -36,7 +36,7 @@ void ecryptfs_dump_auth_tok(struct ecryp
 
 	ecryptfs_printk(KERN_DEBUG, "Auth tok at mem loc [%p]:\n",
 			auth_tok);
-	if (ECRYPTFS_CHECK_FLAG(auth_tok->flags, ECRYPTFS_PRIVATE_KEY)) {
+	if (auth_tok->flags & ECRYPTFS_PRIVATE_KEY) {
 		ecryptfs_printk(KERN_DEBUG, " * private key type\n");
 		ecryptfs_printk(KERN_DEBUG, " * (NO PRIVATE KEY SUPPORT "
 				"IN ECRYPTFS VERSION 0.1)\n");
@@ -46,8 +46,8 @@ void ecryptfs_dump_auth_tok(struct ecryp
 				ECRYPTFS_SALT_SIZE);
 		salt[ECRYPTFS_SALT_SIZE * 2] = '\0';
 		ecryptfs_printk(KERN_DEBUG, " * salt = [%s]\n", salt);
-		if (ECRYPTFS_CHECK_FLAG(auth_tok->token.password.flags,
-					ECRYPTFS_PERSISTENT_PASSWORD)) {
+		if (auth_tok->token.password.flags &
+		    ECRYPTFS_PERSISTENT_PASSWORD) {
 			ecryptfs_printk(KERN_DEBUG, " * persistent\n");
 		}
 		memcpy(sig, auth_tok->token.password.signature,
diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index 0e38d0d..046f0c3 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -94,9 +94,6 @@ #define RFC2440_CIPHER_AES_256 0x09
 #define RFC2440_CIPHER_TWOFISH 0x0a
 #define RFC2440_CIPHER_CAST_6 0x0b
 
-#define ECRYPTFS_SET_FLAG(flag_bit_vector, flag) (flag_bit_vector |= (flag))
-#define ECRYPTFS_CLEAR_FLAG(flag_bit_vector, flag) (flag_bit_vector &= ~(flag))
-#define ECRYPTFS_CHECK_FLAG(flag_bit_vector, flag) (flag_bit_vector & (flag))
 #define RFC2440_CIPHER_RSA 0x01
 
 /**
diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
index 652ed77..bd969ad 100644
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -273,11 +273,11 @@ static int ecryptfs_open(struct inode *i
 	lower_dentry = ecryptfs_dentry_to_lower(ecryptfs_dentry);
 	crypt_stat = &ecryptfs_inode_to_private(inode)->crypt_stat;
 	mutex_lock(&crypt_stat->cs_mutex);
-	if (!ECRYPTFS_CHECK_FLAG(crypt_stat->flags, ECRYPTFS_POLICY_APPLIED)) {
+	if (!(crypt_stat->flags & ECRYPTFS_POLICY_APPLIED)) {
 		ecryptfs_printk(KERN_DEBUG, "Setting flags for stat...\n");
 		/* Policy code enabled in future release */
-		ECRYPTFS_SET_FLAG(crypt_stat->flags, ECRYPTFS_POLICY_APPLIED);
-		ECRYPTFS_SET_FLAG(crypt_stat->flags, ECRYPTFS_ENCRYPTED);
+		crypt_stat->flags |= ECRYPTFS_POLICY_APPLIED;
+		crypt_stat->flags |= ECRYPTFS_ENCRYPTED;
 	}
 	mutex_unlock(&crypt_stat->cs_mutex);
 	lower_flags = file->f_flags;
@@ -297,15 +297,13 @@ static int ecryptfs_open(struct inode *i
 	lower_inode = lower_dentry->d_inode;
 	if (S_ISDIR(ecryptfs_dentry->d_inode->i_mode)) {
 		ecryptfs_printk(KERN_DEBUG, "This is a directory\n");
-		ECRYPTFS_CLEAR_FLAG(crypt_stat->flags, ECRYPTFS_ENCRYPTED);
+		crypt_stat->flags &= ~(ECRYPTFS_ENCRYPTED);
 		rc = 0;
 		goto out;
 	}
 	mutex_lock(&crypt_stat->cs_mutex);
-	if (!ECRYPTFS_CHECK_FLAG(crypt_stat->flags,
-				 ECRYPTFS_POLICY_APPLIED)
-	    || !ECRYPTFS_CHECK_FLAG(crypt_stat->flags,
-				    ECRYPTFS_KEY_VALID)) {
+	if (!(crypt_stat->flags & ECRYPTFS_POLICY_APPLIED)
+	    || !(crypt_stat->flags & ECRYPTFS_KEY_VALID)) {
 		rc = ecryptfs_read_metadata(ecryptfs_dentry, lower_file);
 		if (rc) {
 			ecryptfs_printk(KERN_DEBUG,
@@ -320,9 +318,8 @@ static int ecryptfs_open(struct inode *i
 				mutex_unlock(&crypt_stat->cs_mutex);
 				goto out_puts;
 			}
-			ECRYPTFS_CLEAR_FLAG(crypt_stat->flags,
-					    ECRYPTFS_ENCRYPTED);
 			rc = 0;
+			crypt_stat->flags &= ~(ECRYPTFS_ENCRYPTED);
 			mutex_unlock(&crypt_stat->cs_mutex);
 			goto out;
 		}
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 7d33917..9135718 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -161,9 +161,8 @@ static int grow_file(struct dentry *ecry
 	ecryptfs_set_file_lower(&fake_file, lower_file);
 	rc = ecryptfs_fill_zeros(&fake_file, 1);
 	if (rc) {
-		ECRYPTFS_SET_FLAG(
-			ecryptfs_inode_to_private(inode)->crypt_stat.flags,
-			ECRYPTFS_SECURITY_WARNING);
+		ecryptfs_inode_to_private(inode)->crypt_stat.flags |=
+			ECRYPTFS_SECURITY_WARNING;
 		ecryptfs_printk(KERN_WARNING, "Error attempting to fill zeros "
 				"in file; rc = [%d]\n", rc);
 		goto out;
@@ -172,8 +171,7 @@ static int grow_file(struct dentry *ecry
 	ecryptfs_write_inode_size_to_metadata(lower_file, lower_inode, inode,
 					      ecryptfs_dentry,
 					      ECRYPTFS_LOWER_I_MUTEX_NOT_HELD);
-	ECRYPTFS_SET_FLAG(ecryptfs_inode_to_private(inode)->crypt_stat.flags,
-			  ECRYPTFS_NEW_FILE);
+	ecryptfs_inode_to_private(inode)->crypt_stat.flags |= ECRYPTFS_NEW_FILE;
 out:
 	return rc;
 }
@@ -216,10 +214,10 @@ #endif
 	lower_inode = lower_dentry->d_inode;
 	if (S_ISDIR(ecryptfs_dentry->d_inode->i_mode)) {
 		ecryptfs_printk(KERN_DEBUG, "This is a directory\n");
-		ECRYPTFS_CLEAR_FLAG(crypt_stat->flags, ECRYPTFS_ENCRYPTED);
+		crypt_stat->flags &= ~(ECRYPTFS_ENCRYPTED);
 		goto out_fput;
 	}
-	ECRYPTFS_SET_FLAG(crypt_stat->flags, ECRYPTFS_NEW_FILE);
+	crypt_stat->flags |= ECRYPTFS_NEW_FILE;
 	ecryptfs_printk(KERN_DEBUG, "Initializing crypto context\n");
 	rc = ecryptfs_new_file_context(ecryptfs_dentry);
 	if (rc) {
@@ -373,7 +371,7 @@ static struct dentry *ecryptfs_lookup(st
 		goto out_dput;
 	}
 	crypt_stat = &ecryptfs_inode_to_private(dentry->d_inode)->crypt_stat;
-	if (!ECRYPTFS_CHECK_FLAG(crypt_stat->flags, ECRYPTFS_POLICY_APPLIED))
+	if (!(crypt_stat->flags & ECRYPTFS_POLICY_APPLIED))
 		ecryptfs_set_default_sizes(crypt_stat);
 	rc = ecryptfs_read_and_validate_header_region(page_virt, lower_dentry,
 						      nd->mnt);
diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index cd9c091..81156e9 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -606,13 +606,13 @@ parse_tag_1_packet(struct ecryptfs_crypt
 	(*new_auth_tok)->session_key.flags |=
 		ECRYPTFS_CONTAINS_ENCRYPTED_KEY;
 	(*new_auth_tok)->token_type = ECRYPTFS_PRIVATE_KEY;
-	ECRYPTFS_SET_FLAG((*new_auth_tok)->flags, ECRYPTFS_PRIVATE_KEY);
+	(*new_auth_tok)->flags |= ECRYPTFS_PRIVATE_KEY;
 	/* TODO: Why are we setting this flag here? Don't we want the
 	 * userspace to decrypt the session key? */
-	ECRYPTFS_CLEAR_FLAG((*new_auth_tok)->session_key.flags,
-			    ECRYPTFS_USERSPACE_SHOULD_TRY_TO_DECRYPT);
-	ECRYPTFS_CLEAR_FLAG((*new_auth_tok)->session_key.flags,
-			    ECRYPTFS_USERSPACE_SHOULD_TRY_TO_ENCRYPT);
+	(*new_auth_tok)->session_key.flags &=
+		~(ECRYPTFS_USERSPACE_SHOULD_TRY_TO_DECRYPT);
+	(*new_auth_tok)->session_key.flags &=
+		~(ECRYPTFS_USERSPACE_SHOULD_TRY_TO_ENCRYPT);
 	list_add(&auth_tok_list_item->list, auth_tok_list);
 	goto out;
 out_free:
@@ -792,10 +792,10 @@ parse_tag_3_packet(struct ecryptfs_crypt
 	(*new_auth_tok)->token_type = ECRYPTFS_PASSWORD;
 	/* TODO: Parametarize; we might actually want userspace to
 	 * decrypt the session key. */
-	ECRYPTFS_CLEAR_FLAG((*new_auth_tok)->session_key.flags,
-			    ECRYPTFS_USERSPACE_SHOULD_TRY_TO_DECRYPT);
-	ECRYPTFS_CLEAR_FLAG((*new_auth_tok)->session_key.flags,
-			    ECRYPTFS_USERSPACE_SHOULD_TRY_TO_ENCRYPT);
+	(*new_auth_tok)->session_key.flags &=
+			    ~(ECRYPTFS_USERSPACE_SHOULD_TRY_TO_DECRYPT);
+	(*new_auth_tok)->session_key.flags &=
+			    ~(ECRYPTFS_USERSPACE_SHOULD_TRY_TO_ENCRYPT);
 	list_add(&auth_tok_list_item->list, auth_tok_list);
 	goto out;
 out_free:
@@ -940,8 +940,7 @@ static int decrypt_session_key(struct ec
 	int rc = 0;
 
 	password_s_ptr = &auth_tok->token.password;
-	if (ECRYPTFS_CHECK_FLAG(password_s_ptr->flags,
-				ECRYPTFS_SESSION_KEY_ENCRYPTION_KEY_SET))
+	if (password_s_ptr->flags & ECRYPTFS_SESSION_KEY_ENCRYPTION_KEY_SET)
 		ecryptfs_printk(KERN_DEBUG, "Session key encryption key "
 				"set; skipping key generation\n");
 	ecryptfs_printk(KERN_DEBUG, "Session key encryption key (size [%d])"
@@ -1023,7 +1022,7 @@ static int decrypt_session_key(struct ec
 	auth_tok->session_key.flags |= ECRYPTFS_CONTAINS_DECRYPTED_KEY;
 	memcpy(crypt_stat->key, auth_tok->session_key.decrypted_key,
 	       auth_tok->session_key.decrypted_key_size);
-	ECRYPTFS_SET_FLAG(crypt_stat->flags, ECRYPTFS_KEY_VALID);
+	crypt_stat->flags |= ECRYPTFS_KEY_VALID;
 	ecryptfs_printk(KERN_DEBUG, "Decrypted session key:\n");
 	if (ecryptfs_verbosity > 0)
 		ecryptfs_dump_hex(crypt_stat->key,
@@ -1126,8 +1125,7 @@ int ecryptfs_parse_packet_set(struct ecr
 					sig_tmp_space, tag_11_contents_size);
 			new_auth_tok->token.password.signature[
 				ECRYPTFS_PASSWORD_SIG_SIZE] = '\0';
-			ECRYPTFS_SET_FLAG(crypt_stat->flags,
-					  ECRYPTFS_ENCRYPTED);
+			crypt_stat->flags |= ECRYPTFS_ENCRYPTED;
 			break;
 		case ECRYPTFS_TAG_1_PACKET_TYPE:
 			rc = parse_tag_1_packet(crypt_stat,
@@ -1141,8 +1139,7 @@ int ecryptfs_parse_packet_set(struct ecr
 				goto out_wipe_list;
 			}
 			i += packet_size;
-			ECRYPTFS_SET_FLAG(crypt_stat->flags,
-					  ECRYPTFS_ENCRYPTED);
+			crypt_stat->flags |= ECRYPTFS_ENCRYPTED;
 			break;
 		case ECRYPTFS_TAG_11_PACKET_TYPE:
 			ecryptfs_printk(KERN_WARNING, "Invalid packet set "
@@ -1208,8 +1205,7 @@ int ecryptfs_parse_packet_set(struct ecr
 	}
 leave_list:
 	rc = -ENOTSUPP;
-	if ((ECRYPTFS_CHECK_FLAG(candidate_auth_tok->flags,
-			         ECRYPTFS_PRIVATE_KEY))) {
+	if (candidate_auth_tok->token_type == ECRYPTFS_PRIVATE_KEY) {
 		memcpy(&(candidate_auth_tok->token.private_key),
 		       &(chosen_auth_tok->token.private_key),
 		       sizeof(struct ecryptfs_private_key));
diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index 6f167f1..2a7ba51 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -295,8 +295,8 @@ static int ecryptfs_readpage(struct file
 	crypt_stat = &ecryptfs_inode_to_private(file->f_path.dentry->d_inode)
 			->crypt_stat;
 	if (!crypt_stat
-	    || !ECRYPTFS_CHECK_FLAG(crypt_stat->flags, ECRYPTFS_ENCRYPTED)
-	    || ECRYPTFS_CHECK_FLAG(crypt_stat->flags, ECRYPTFS_NEW_FILE)) {
+	    || !(crypt_stat->flags & ECRYPTFS_ENCRYPTED)
+	    || (crypt_stat->flags & ECRYPTFS_NEW_FILE)) {
 		ecryptfs_printk(KERN_DEBUG,
 				"Passing through unencrypted page\n");
 		rc = ecryptfs_do_readpage(file, page, page->index);
@@ -657,10 +657,10 @@ static int ecryptfs_commit_write(struct 
 	mutex_lock(&lower_inode->i_mutex);
 	crypt_stat = &ecryptfs_inode_to_private(file->f_path.dentry->d_inode)
 				->crypt_stat;
-	if (ECRYPTFS_CHECK_FLAG(crypt_stat->flags, ECRYPTFS_NEW_FILE)) {
+	if (crypt_stat->flags & ECRYPTFS_NEW_FILE) {
 		ecryptfs_printk(KERN_DEBUG, "ECRYPTFS_NEW_FILE flag set in "
 			"crypt_stat at memory location [%p]\n", crypt_stat);
-		ECRYPTFS_CLEAR_FLAG(crypt_stat->flags, ECRYPTFS_NEW_FILE);
+		crypt_stat->flags &= ~(ECRYPTFS_NEW_FILE);
 	} else
 		ecryptfs_printk(KERN_DEBUG, "Not a new file\n");
 	ecryptfs_printk(KERN_DEBUG, "Calling fill_zeros_to_end_of_page"
-- 
1.3.3

