Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964997AbWHXSUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964997AbWHXSUL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 14:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965074AbWHXSUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 14:20:11 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:51079 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964997AbWHXSUH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 14:20:07 -0400
Date: Thu, 24 Aug 2006 13:20:06 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, mhalcrow@us.ibm.com
Subject: [PATCH 3/4] eCryptfs: Open-code flag manipulation
Message-ID: <20060824182006.GD17658@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20060824181722.GA17658@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824181722.GA17658@us.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Open-code flag checking and manipulation.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/crypto.c          |   37 +++++++++++++-------------------
 fs/ecryptfs/debug.c           |   10 ++++-----
 fs/ecryptfs/ecryptfs_kernel.h |    3 ---
 fs/ecryptfs/file.c            |   17 ++++++---------
 fs/ecryptfs/inode.c           |   14 +++++-------
 fs/ecryptfs/keystore.c        |   48 +++++++++++++++++------------------------
 fs/ecryptfs/main.c            |    3 +--
 fs/ecryptfs/mmap.c            |    8 +++----
 8 files changed, 58 insertions(+), 82 deletions(-)

6c21efe97f4e0c862a962f007349ee0e4b2aff6b
diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 39d7ec0..112134a 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -179,7 +179,7 @@ ecryptfs_init_crypt_stat(struct ecryptfs
 	mutex_init(&crypt_stat->cs_mutex);
 	mutex_init(&crypt_stat->cs_tfm_mutex);
 	mutex_init(&crypt_stat->cs_md5_tfm_mutex);
-	ECRYPTFS_SET_FLAG(crypt_stat->flags, ECRYPTFS_STRUCT_INITIALIZED);
+	crypt_stat->flags |= ECRYPTFS_STRUCT_INITIALIZED;
 }
 
 /**
@@ -272,8 +272,7 @@ static int encrypt_scatterlist(struct ec
 	int rc = 0;
 
 	BUG_ON(!crypt_stat || !crypt_stat->tfm
-	       || !ECRYPTFS_CHECK_FLAG(crypt_stat->flags,
-				       ECRYPTFS_STRUCT_INITIALIZED));
+	       || !(crypt_stat->flags & ECRYPTFS_STRUCT_INITIALIZED));
 	if (unlikely(ecryptfs_verbosity > 0)) {
 		ecryptfs_printk(KERN_DEBUG, "Key size [%d]; key:\n",
 				crypt_stat->key_size);
@@ -452,7 +451,7 @@ #define ECRYPTFS_PAGE_STATE_WRITTEN   3
 	lower_inode = ecryptfs_inode_to_lower(ctx->page->mapping->host);
 	inode_info = ecryptfs_inode_to_private(ctx->page->mapping->host);
 	crypt_stat = &inode_info->crypt_stat;
-	if (!ECRYPTFS_CHECK_FLAG(crypt_stat->flags, ECRYPTFS_ENCRYPTED)) {
+	if (!(crypt_stat->flags & ECRYPTFS_ENCRYPTED)) {
 		rc = ecryptfs_copy_page_to_lower(ctx->page, lower_inode,
 						 ctx->param.lower_file);
 		if (rc)
@@ -584,7 +583,7 @@ int ecryptfs_decrypt_page(struct file *f
 	crypt_stat = &(ecryptfs_inode_to_private(
 			       page->mapping->host)->crypt_stat);
 	lower_inode = ecryptfs_inode_to_lower(page->mapping->host);
-	if (!ECRYPTFS_CHECK_FLAG(crypt_stat->flags, ECRYPTFS_ENCRYPTED)) {
+	if (!(crypt_stat->flags & ECRYPTFS_ENCRYPTED)) {
 		rc = ecryptfs_do_readpage(file, page, page->index);
 		if (rc)
 			ecryptfs_printk(KERN_ERR, "Error attempting to copy "
@@ -834,7 +833,7 @@ int ecryptfs_compute_root_iv(struct ecry
 
 	BUG_ON(crypt_stat->iv_bytes > MD5_DIGEST_SIZE);
 	BUG_ON(crypt_stat->iv_bytes <= 0);
-	if (!ECRYPTFS_CHECK_FLAG(crypt_stat->flags, ECRYPTFS_KEY_VALID)) {
+	if (!(crypt_stat->flags & ECRYPTFS_KEY_VALID)) {
 		rc = -EINVAL;
 		ecryptfs_printk(KERN_WARNING, "Session key not valid; "
 				"cannot generate root IV\n");
@@ -851,8 +850,7 @@ int ecryptfs_compute_root_iv(struct ecry
 out:
 	if (rc) {
 		memset(crypt_stat->root_iv, 0, crypt_stat->iv_bytes);
-		ECRYPTFS_SET_FLAG(crypt_stat->flags,
-				  ECRYPTFS_SECURITY_WARNING);
+		crypt_stat->flags |= ECRYPTFS_SECURITY_WARNING;
 	}
 	return rc;
 }
@@ -860,7 +858,7 @@ out:
 static void ecryptfs_generate_new_key(struct ecryptfs_crypt_stat *crypt_stat)
 {
 	get_random_bytes(crypt_stat->key, crypt_stat->key_size);
-	ECRYPTFS_SET_FLAG(crypt_stat->flags, ECRYPTFS_KEY_VALID);
+	crypt_stat->flags |= ECRYPTFS_KEY_VALID;
 	ecryptfs_compute_root_iv(crypt_stat);
 	if (unlikely(ecryptfs_verbosity > 0)) {
 		ecryptfs_printk(KERN_DEBUG, "Generated new session key:\n");
@@ -882,7 +880,7 @@ static void ecryptfs_set_default_crypt_s
 	ecryptfs_set_default_sizes(crypt_stat);
 	strcpy(crypt_stat->cipher, ECRYPTFS_DEFAULT_CIPHER);
 	crypt_stat->key_size = ECRYPTFS_DEFAULT_KEY_BYTES;
-	ECRYPTFS_CLEAR_FLAG(crypt_stat->flags, ECRYPTFS_KEY_VALID);
+	crypt_stat->flags &= ~(ECRYPTFS_KEY_VALID);
 	crypt_stat->file_version = ECRYPTFS_FILE_VERSION;
 	crypt_stat->mount_crypt_stat = mount_crypt_stat;
 }
@@ -922,8 +920,8 @@ int ecryptfs_new_file_context(struct den
 	if (mount_crypt_stat->global_auth_tok) {
 		ecryptfs_printk(KERN_DEBUG, "Initializing context for new "
 				"file using mount_crypt_stat\n");
-		ECRYPTFS_SET_FLAG(crypt_stat->flags, ECRYPTFS_ENCRYPTED);
-		ECRYPTFS_SET_FLAG(crypt_stat->flags, ECRYPTFS_KEY_VALID);
+		crypt_stat->flags |= ECRYPTFS_ENCRYPTED;
+		crypt_stat->flags |= ECRYPTFS_KEY_VALID;
 		memcpy(crypt_stat->keysigs[crypt_stat->num_keysigs++],
 		       mount_crypt_stat->global_auth_tok_sig,
 		       ECRYPTFS_SIG_SIZE_HEX);
@@ -1005,11 +1003,9 @@ static int ecryptfs_process_flags(struct
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
@@ -1046,8 +1042,7 @@ write_ecryptfs_flags(char *page_virt, st
 
 	for (i = 0; i < ((sizeof(ecryptfs_flag_map)
 			  / sizeof(struct ecryptfs_flag_map_elem))); i++)
-		if (ECRYPTFS_CHECK_FLAG(crypt_stat->flags,
-					ecryptfs_flag_map[i].local_flag))
+		if (crypt_stat->flags & ecryptfs_flag_map[i].local_flag)
 			flags |= ecryptfs_flag_map[i].file_flag;
 	/* Version is in top 8 bits of the 32-bit flag vector */
 	flags |= ((((u8)crypt_stat->file_version) << 24) & 0xFF000000);
@@ -1271,10 +1266,8 @@ int ecryptfs_write_headers(struct dentry
 
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
index 2261945..9cae01d 100644
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
@@ -55,12 +55,12 @@ void ecryptfs_dump_auth_tok(struct ecryp
 		sig[ECRYPTFS_SIG_SIZE_HEX] = '\0';
 		ecryptfs_printk(KERN_DEBUG, " * signature = [%s]\n", sig);
 	}
-	if (ECRYPTFS_CHECK_FLAG(auth_tok->flags, ECRYPTFS_CONTAINS_SECRET)) {
+	if (auth_tok->flags & ECRYPTFS_CONTAINS_SECRET) {
 		ecryptfs_printk(KERN_DEBUG, " * contains secret value\n");
 	} else {
 		ecryptfs_printk(KERN_DEBUG, " * lacks secret value\n");
 	}
-	if (ECRYPTFS_CHECK_FLAG(auth_tok->flags, ECRYPTFS_EXPIRED))
+	if (auth_tok->flags & ECRYPTFS_EXPIRED)
 		ecryptfs_printk(KERN_DEBUG, " * expired\n");
 	ecryptfs_printk(KERN_DEBUG, " * session_key.flags = [0x%x]\n",
 			auth_tok->session_key.flags);
diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index 8d4e8ef..fcf6d8b 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -79,9 +79,6 @@ #define RFC2440_CIPHER_AES_256 0x09
 #define RFC2440_CIPHER_TWOFISH 0x0a
 #define RFC2440_CIPHER_CAST_6 0x0b
 
-#define ECRYPTFS_SET_FLAG(flag_bit_vector, flag) (flag_bit_vector |= (flag))
-#define ECRYPTFS_CLEAR_FLAG(flag_bit_vector, flag) (flag_bit_vector &= ~(flag))
-#define ECRYPTFS_CHECK_FLAG(flag_bit_vector, flag) (flag_bit_vector & (flag))
 #define RFC2440_CIPHER_RSA 0x01
 
 /**
diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
index b707a99..6da9363 100644
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -233,11 +233,11 @@ static int ecryptfs_open(struct inode *i
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
 	/* This mntget & dget is undone via fput when the file is released */
@@ -261,7 +261,7 @@ static int ecryptfs_open(struct inode *i
 	lower_inode = lower_dentry->d_inode;
 	if (S_ISDIR(ecryptfs_dentry->d_inode->i_mode)) {
 		ecryptfs_printk(KERN_DEBUG, "This is a directory\n");
-		ECRYPTFS_CLEAR_FLAG(crypt_stat->flags, ECRYPTFS_ENCRYPTED);
+		crypt_stat->flags &= ~(ECRYPTFS_ENCRYPTED);
 		rc = 0;
 		goto out;
 	}
@@ -272,16 +272,13 @@ static int ecryptfs_open(struct inode *i
 		rc = -ENOENT;
 		mutex_unlock(&crypt_stat->cs_mutex);
 		goto out_puts;
-	} else if (!ECRYPTFS_CHECK_FLAG(crypt_stat->flags,
-					ECRYPTFS_POLICY_APPLIED)
-		   || !ECRYPTFS_CHECK_FLAG(crypt_stat->flags,
-					   ECRYPTFS_KEY_VALID)) {
+	} else if (!(crypt_stat->flags & ECRYPTFS_POLICY_APPLIED)
+		   || !(crypt_stat->flags & ECRYPTFS_KEY_VALID)) {
 		rc = ecryptfs_read_headers(ecryptfs_dentry, lower_file);
 		if (rc) {
 			ecryptfs_printk(KERN_DEBUG,
 					"Valid headers not found\n");
-			ECRYPTFS_CLEAR_FLAG(crypt_stat->flags,
-					    ECRYPTFS_ENCRYPTED);
+			crypt_stat->flags &= ~(ECRYPTFS_ENCRYPTED);
 			/* At this point, we could just move on and
 			 * have the encrypted data passed through
 			 * as-is to userspace. For release 0.1, we are
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index d8659ff..bfc7f41 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -202,17 +202,15 @@ static int grow_file(struct dentry *ecry
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
 	}
 	i_size_write(inode, 0);
 	ecryptfs_write_inode_size_to_header(lower_file, lower_inode, inode);
-	ECRYPTFS_SET_FLAG(ecryptfs_inode_to_private(inode)->crypt_stat.flags,
-			  ECRYPTFS_NEW_FILE);
+	ecryptfs_inode_to_private(inode)->crypt_stat.flags |= ECRYPTFS_NEW_FILE;
 out:
 	return rc;
 }
@@ -267,10 +265,10 @@ #endif
 	lower_inode = tlower_dentry->d_inode;
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
@@ -427,7 +425,7 @@ static struct dentry *ecryptfs_lookup(st
 	memset(page_virt, 0, PAGE_CACHE_SIZE);
 	rc = ecryptfs_read_header_region(page_virt, tlower_dentry, nd->mnt);
 	crypt_stat = &ecryptfs_inode_to_private(dentry->d_inode)->crypt_stat;
-	if (!ECRYPTFS_CHECK_FLAG(crypt_stat->flags, ECRYPTFS_POLICY_APPLIED))
+	if (!(crypt_stat->flags & ECRYPTFS_POLICY_APPLIED))
 		ecryptfs_set_default_sizes(crypt_stat);
 	if (rc) {
 		rc = 0;
diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index f171bed..f8b0841 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -608,13 +608,13 @@ parse_tag_1_packet(struct ecryptfs_crypt
 		ECRYPTFS_CONTAINS_ENCRYPTED_KEY;
 	/* TODO: Use the keyring */
 	(*new_auth_tok)->uid = current->uid;
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
@@ -795,13 +795,13 @@ parse_tag_3_packet(struct ecryptfs_crypt
 	}
 	/* TODO: Use the keyring */
 	(*new_auth_tok)->uid = current->uid;
-	ECRYPTFS_SET_FLAG((*new_auth_tok)->flags, ECRYPTFS_PASSWORD);
+	(*new_auth_tok)->flags |= ECRYPTFS_PASSWORD;
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
@@ -944,8 +944,7 @@ static int decrypt_session_key(struct ec
 	int rc = 0;
 
 	password_s_ptr = &auth_tok->token.password;
-	if (ECRYPTFS_CHECK_FLAG(password_s_ptr->flags,
-				ECRYPTFS_SESSION_KEY_ENCRYPTION_KEY_SET))
+	if (password_s_ptr->flags & ECRYPTFS_SESSION_KEY_ENCRYPTION_KEY_SET)
 		ecryptfs_printk(KERN_DEBUG, "Session key encryption key "
 				"set; skipping key generation\n");
 	ecryptfs_printk(KERN_DEBUG, "Session key encryption key (size [%d])"
@@ -1017,7 +1016,7 @@ static int decrypt_session_key(struct ec
 	auth_tok->session_key.flags |= ECRYPTFS_CONTAINS_DECRYPTED_KEY;
 	memcpy(crypt_stat->key, auth_tok->session_key.decrypted_key,
 	       auth_tok->session_key.decrypted_key_size);
-	ECRYPTFS_SET_FLAG(crypt_stat->flags, ECRYPTFS_KEY_VALID);
+	crypt_stat->flags |= ECRYPTFS_KEY_VALID;
 	ecryptfs_printk(KERN_DEBUG, "Decrypted session key:\n");
 	if (ecryptfs_verbosity > 0)
 		ecryptfs_dump_hex(crypt_stat->key,
@@ -1119,8 +1118,7 @@ int ecryptfs_parse_packet_set(struct ecr
 					sig_tmp_space, tag_11_contents_size);
 			new_auth_tok->token.password.signature[
 				ECRYPTFS_PASSWORD_SIG_SIZE] = '\0';
-			ECRYPTFS_SET_FLAG(crypt_stat->flags,
-					  ECRYPTFS_ENCRYPTED);
+			crypt_stat->flags |= ECRYPTFS_ENCRYPTED;
 			break;
 		case ECRYPTFS_TAG_1_PACKET_TYPE:
 			rc = parse_tag_1_packet(crypt_stat,
@@ -1134,8 +1132,7 @@ int ecryptfs_parse_packet_set(struct ecr
 				goto out_wipe_list;
 			}
 			i += packet_size;
-			ECRYPTFS_SET_FLAG(crypt_stat->flags,
-					  ECRYPTFS_ENCRYPTED);
+			crypt_stat->flags |= ECRYPTFS_ENCRYPTED;
 			break;
 		case ECRYPTFS_TAG_11_PACKET_TYPE:
 			ecryptfs_printk(KERN_WARNING, "Invalid packet set "
@@ -1177,8 +1174,7 @@ int ecryptfs_parse_packet_set(struct ecr
 			ecryptfs_dump_auth_tok(candidate_auth_tok);
 		}
 		/* TODO: Replace ECRYPTFS_SIG_SIZE_HEX w/ dynamic value */
-		if ((ECRYPTFS_CHECK_FLAG(candidate_auth_tok->flags,
-					 ECRYPTFS_PASSWORD))
+		if ((candidate_auth_tok->flags & ECRYPTFS_PASSWORD)
 		    && !strncmp(candidate_auth_tok->token.password.signature,
 				sig, ECRYPTFS_SIG_SIZE_HEX)) {
 			found_auth_tok = 1;
@@ -1186,8 +1182,7 @@ int ecryptfs_parse_packet_set(struct ecr
 			/* TODO: Transfer the common salt into the
 			 * crypt_stat salt */
 		}
-		else if ((ECRYPTFS_CHECK_FLAG(candidate_auth_tok->flags,
-					      ECRYPTFS_PRIVATE_KEY))
+		else if ((candidate_auth_tok->flags & ECRYPTFS_PRIVATE_KEY)
 		   && !strncmp(candidate_auth_tok->token.private_key.signature,
 			       sig, ECRYPTFS_SIG_SIZE_HEX)) {
 			found_auth_tok = 1;
@@ -1202,16 +1197,14 @@ int ecryptfs_parse_packet_set(struct ecr
 		goto out_wipe_list;
 	}
 leave_list:
-	if ((ECRYPTFS_CHECK_FLAG(candidate_auth_tok->flags,
-			         ECRYPTFS_PRIVATE_KEY))) {
+	if (candidate_auth_tok->flags & ECRYPTFS_PRIVATE_KEY) {
 		memcpy(&(candidate_auth_tok->token.private_key),
 		       &(chosen_auth_tok->token.private_key),
 		       sizeof(struct ecryptfs_private_key));
 		rc = decrypt_pki_encrypted_session_key(mount_crypt_stat,
 						       candidate_auth_tok,
 						       crypt_stat);
-	} else if ((ECRYPTFS_CHECK_FLAG(candidate_auth_tok->flags,
-					ECRYPTFS_PASSWORD))) {
+	} else if (candidate_auth_tok->flags & ECRYPTFS_PASSWORD) {
 		memcpy(&(candidate_auth_tok->token.password),
 		       &(chosen_auth_tok->token.password),
 		       sizeof(struct ecryptfs_password));
@@ -1651,7 +1644,7 @@ ecryptfs_generate_key_packet_set(char *d
 	(*len) = 0;
 	if (mount_crypt_stat->global_auth_tok) {
 		auth_tok = mount_crypt_stat->global_auth_tok;
-		if (ECRYPTFS_CHECK_FLAG(auth_tok->flags, ECRYPTFS_PASSWORD)) {
+		if (auth_tok->flags & ECRYPTFS_PASSWORD) {
 			rc = write_tag_3_packet((dest_base + (*len)),
 						max, auth_tok,
 						crypt_stat, &key_rec,
@@ -1673,8 +1666,7 @@ ecryptfs_generate_key_packet_set(char *d
 				goto out;
 			}
 			(*len) += written;
-		} else if (ECRYPTFS_CHECK_FLAG(auth_tok->flags,
-					       ECRYPTFS_PRIVATE_KEY)) {
+		} else if (auth_tok->flags & ECRYPTFS_PRIVATE_KEY) {
 			rc = write_tag_1_packet(dest_base + (*len),
 						max, auth_tok,
 						crypt_stat,mount_crypt_stat,
diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index 9aacb75..b45ee2c 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -392,8 +392,7 @@ static int ecryptfs_parse_options(struct
 		rc = -EINVAL;
 		goto out;
 	}
-	if (!ECRYPTFS_CHECK_FLAG(auth_tok->flags,
-				 (ECRYPTFS_PASSWORD | ECRYPTFS_PRIVATE_KEY))) {
+	if (!(auth_tok->flags & (ECRYPTFS_PASSWORD | ECRYPTFS_PRIVATE_KEY))) {
 		ecryptfs_printk(KERN_ERR, "Invalid auth_tok structure "
 				"returned from key\n");
 		rc = -EINVAL;
diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index 02f8ca1..5be06ac 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -279,8 +279,8 @@ static int ecryptfs_readpage(struct file
 	crypt_stat =
 		&ecryptfs_inode_to_private(file->f_dentry->d_inode)->crypt_stat;
 	if (!crypt_stat
-	    || !ECRYPTFS_CHECK_FLAG(crypt_stat->flags, ECRYPTFS_ENCRYPTED)
-	    || ECRYPTFS_CHECK_FLAG(crypt_stat->flags, ECRYPTFS_NEW_FILE)) {
+	    || !(crypt_stat->flags & ECRYPTFS_ENCRYPTED)
+	    || (crypt_stat->flags & ECRYPTFS_NEW_FILE)) {
 		ecryptfs_printk(KERN_DEBUG,
 				"Passing through unencrypted page\n");
 		rc = ecryptfs_do_readpage(file, page, page->index);
@@ -556,10 +556,10 @@ static int ecryptfs_commit_write(struct 
 	mutex_lock(&lower_inode->i_mutex);
 	crypt_stat =
 		&ecryptfs_inode_to_private(file->f_dentry->d_inode)->crypt_stat;
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

