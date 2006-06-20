Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbWFTVYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWFTVYf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 17:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbWFTVYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 17:24:33 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:29365 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751165AbWFTVYZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 17:24:25 -0400
In-reply-to: <20060620212134.GB18701@us.ibm.com>
From: Mike Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Mike Halcrow <mhalcrow@us.ibm.com>, Mike Halcrow <mike@halcrow.us>
Subject: [PATCH 10/12] Convert bits to bytes
Message-Id: <E1Fsnhs-0007AD-0s@localhost.localdomain>
Date: Tue, 20 Jun 2006 16:24:20 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert bits to bytes, since we only deal with bytes in the code.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/crypto.c          |   22 ++++++++---------
 fs/ecryptfs/ecryptfs_kernel.h |    6 ++---
 fs/ecryptfs/keystore.c        |   54 +++++++++++++++++++++--------------------
 fs/ecryptfs/main.c            |   16 ++++++------
 4 files changed, 49 insertions(+), 49 deletions(-)

9dfc9585b6a06bc80648fba36a415defaf215427
diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 426e5e4..ab47899 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -249,13 +249,13 @@ static int encrypt_scatterlist(struct ec
 				       ECRYPTFS_STRUCT_INITIALIZED));
 	if (unlikely(ecryptfs_verbosity > 0)) {
 		ecryptfs_printk(KERN_DEBUG, "Key size [%d]; key:\n",
-				crypt_stat->key_size_bits / 8);
+				crypt_stat->key_size);
 		ecryptfs_dump_hex(crypt_stat->key,
-				  crypt_stat->key_size_bits / 8);
+				  crypt_stat->key_size);
 	}
 	/* Consider doing this once, when the file is opened */
 	rc = crypto_cipher_setkey(crypt_stat->tfm, crypt_stat->key,
-				  crypt_stat->key_size_bits / 8);
+				  crypt_stat->key_size);
 	if (rc) {
 		ecryptfs_printk(KERN_ERR, "Error setting key; rc = [%d]\n",
 				rc);
@@ -646,7 +646,7 @@ static int decrypt_scatterlist(struct ec
 
 	/* Consider doing this once, when the file is opened */
 	rc = crypto_cipher_setkey(crypt_stat->tfm, crypt_stat->key,
-				  crypt_stat->key_size_bits / 8);
+				  crypt_stat->key_size);
 	if (rc) {
 		ecryptfs_printk(KERN_ERR, "Error setting key; rc = [%d]\n",
 				rc);
@@ -733,7 +733,7 @@ int ecryptfs_init_crypt_ctx(struct ecryp
 			"Initializing cipher [%s]; strlen = [%d]; "
 			"key_size_bits = [%d]\n",
 			crypt_stat->cipher, (int)strlen(crypt_stat->cipher),
-			crypt_stat->key_size_bits);
+			crypt_stat->key_size << 3);
 	if (crypt_stat->tfm) {
 		rc = 0;
 		goto out;
@@ -803,7 +803,7 @@ int ecryptfs_compute_root_iv(struct ecry
 		goto out;
 	}
 	rc = ecryptfs_calculate_md5(dst, crypt_stat, crypt_stat->key,
-				    (crypt_stat->key_size_bits / 8));
+				    crypt_stat->key_size);
 	if (rc) {
 		ecryptfs_printk(KERN_WARNING, "Error attempting to compute "
 				"MD5 while generating root IV\n");
@@ -821,13 +821,13 @@ out:
 
 static void ecryptfs_generate_new_key(struct ecryptfs_crypt_stat *crypt_stat)
 {
-	get_random_bytes(crypt_stat->key, (crypt_stat->key_size_bits >> 3));
+	get_random_bytes(crypt_stat->key, crypt_stat->key_size);
 	ECRYPTFS_SET_FLAG(crypt_stat->flags, ECRYPTFS_KEY_VALID);
 	ecryptfs_compute_root_iv(crypt_stat);
 	if (unlikely(ecryptfs_verbosity > 0)) {
 		ecryptfs_printk(KERN_DEBUG, "Generated new session key:\n");
 		ecryptfs_dump_hex(crypt_stat->key,
-				  crypt_stat->key_size_bits / 8);
+				  crypt_stat->key_size);
 	}
 }
 
@@ -842,7 +842,7 @@ ecryptfs_set_default_crypt_stat_vals(str
 {
 	ecryptfs_set_default_sizes(crypt_stat);
 	strcpy(crypt_stat->cipher, ECRYPTFS_DEFAULT_CIPHER);
-	crypt_stat->key_size_bits = ECRYPTFS_DEFAULT_KEY_BYTES << 3;
+	crypt_stat->key_size = ECRYPTFS_DEFAULT_KEY_BYTES;
 	ECRYPTFS_CLEAR_FLAG(crypt_stat->flags, ECRYPTFS_KEY_VALID);
 	crypt_stat->file_version = ECRYPTFS_FILE_VERSION;
 }
@@ -893,8 +893,8 @@ int ecryptfs_new_file_context(struct den
 		       mount_crypt_stat->global_default_cipher_name,
 		       cipher_name_len);
 		crypt_stat->cipher[cipher_name_len] = '\0';
-		crypt_stat->key_size_bits =
-			mount_crypt_stat->global_default_cipher_key_bits;
+		crypt_stat->key_size =
+			mount_crypt_stat->global_default_cipher_key_size;
 		ecryptfs_generate_new_key(crypt_stat);
 	} else
 		/* We should not encounter this scenario since we
diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index 39057a8..cc88dc5 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -123,7 +123,7 @@ extern void ecryptfs_to_hex(char *dst, c
 extern void ecryptfs_from_hex(char *dst, char *src, int dst_size);
 
 struct ecryptfs_key_record {
-	u16 enc_key_size_bits;
+	u16 enc_key_size;
 	unsigned char type;
 	unsigned char sig[ECRYPTFS_SIG_SIZE];
 	unsigned char enc_key[ECRYPTFS_MAX_ENCRYPTED_KEY_BYTES];
@@ -193,7 +193,7 @@ #define ECRYPTFS_KEY_VALID          0x00
 	unsigned int header_extent_size;
 	unsigned int num_header_extents_at_front;
 	unsigned int extent_size; /* Data extent size; default is 4096 */
-	unsigned int key_size_bits;
+	unsigned int key_size;
 	unsigned int extent_shift;
 	unsigned int extent_mask;
 	struct crypto_tfm *tfm;
@@ -229,7 +229,7 @@ struct ecryptfs_mount_crypt_stat {
 	/* Pointers to memory we do not own, do not free these */
 	struct ecryptfs_auth_tok *global_auth_tok;
 	struct key *global_auth_tok_key;
-	unsigned int global_default_cipher_key_bits;
+	unsigned int global_default_cipher_key_size;
 	unsigned char global_default_cipher_name[ECRYPTFS_MAX_CIPHER_NAME_SIZE
 						 + 1];
 	unsigned char global_auth_tok_sig[ECRYPTFS_SIG_SIZE_HEX + 1];
diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index d301ac8..37fa03b 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -248,11 +248,11 @@ parse_tag_3_packet(struct ecryptfs_crypt
 	 * sizes; see RFC2440 */
 	switch(data[(*packet_size)++]) {
 	case RFC2440_CIPHER_AES_192:
-		crypt_stat->key_size_bits = 192;
+		crypt_stat->key_size = 24;
 		break;
 	default:
-		crypt_stat->key_size_bits =
-			(*new_auth_tok)->session_key.encrypted_key_size << 3;
+		crypt_stat->key_size =
+			(*new_auth_tok)->session_key.encrypted_key_size;
 	}
 	if (unlikely((*packet_size) > max_packet_size)) {
 		ecryptfs_printk(KERN_ERR, "Packet size exceeds max\n");
@@ -493,7 +493,7 @@ static int decrypt_session_key(struct ec
 		goto out;
 	}
 	crypto_cipher_setkey(tfm, password_s_ptr->session_key_encryption_key,
-			     (crypt_stat->key_size_bits / 8));
+			     crypt_stat->key_size);
 	/* TODO: virt_to_scatterlist */
 	encrypted_session_key = (char *)__get_free_page(GFP_KERNEL);
 	if (!encrypted_session_key) {
@@ -533,7 +533,7 @@ static int decrypt_session_key(struct ec
 	ecryptfs_printk(KERN_DEBUG, "Decrypted session key:\n");
 	if (ecryptfs_verbosity > 0)
 		ecryptfs_dump_hex(crypt_stat->key,
-				  crypt_stat->key_size_bits / 8);
+				  crypt_stat->key_size);
 	memset(encrypted_session_key, 0, PAGE_CACHE_SIZE);
 	free_page((unsigned long)encrypted_session_key);
 	memset(session_key, 0, PAGE_CACHE_SIZE);
@@ -809,7 +809,7 @@ write_tag_3_packet(char *dest, int max, 
 	ecryptfs_from_hex((*key_rec).sig, auth_tok->token.password.signature,
 			  ECRYPTFS_SIG_SIZE);
 	encrypted_session_key_valid = 0;
-	for (i = 0; i < (crypt_stat->key_size_bits / 8); i++)
+	for (i = 0; i < crypt_stat->key_size; i++)
 		encrypted_session_key_valid |=
 			auth_tok->session_key.encrypted_key[i];
 	if (encrypted_session_key_valid) {
@@ -820,14 +820,14 @@ write_tag_3_packet(char *dest, int max, 
 	}
 	if (auth_tok->session_key.encrypted_key_size == 0)
 		auth_tok->session_key.encrypted_key_size =
-			(crypt_stat->key_size_bits / 8);
-	if (crypt_stat->key_size_bits == 192
+			crypt_stat->key_size;
+	if (crypt_stat->key_size == 24
 	    && strcmp("aes", crypt_stat->cipher) == 0) {
 		memset((crypt_stat->key + 24), 0, 8);
 		auth_tok->session_key.encrypted_key_size = 32;
 	}
-	(*key_rec).enc_key_size_bits =
-		auth_tok->session_key.encrypted_key_size << 3;
+	(*key_rec).enc_key_size =
+		auth_tok->session_key.encrypted_key_size;
 	if (ECRYPTFS_CHECK_FLAG(auth_tok->token.password.flags,
 				ECRYPTFS_SESSION_KEY_ENCRYPTION_KEY_SET)) {
 		ecryptfs_printk(KERN_DEBUG, "Using previously generated "
@@ -836,7 +836,7 @@ write_tag_3_packet(char *dest, int max, 
 				session_key_encryption_key_bytes);
 		memcpy(session_key_encryption_key,
 		       auth_tok->token.password.session_key_encryption_key,
-		       (crypt_stat->key_size_bits / 8));
+		       crypt_stat->key_size);
 		ecryptfs_printk(KERN_DEBUG,
 				"Cached session key " "encryption key: \n");
 		if (ecryptfs_verbosity > 0)
@@ -847,7 +847,7 @@ write_tag_3_packet(char *dest, int max, 
 		ecryptfs_dump_hex(session_key_encryption_key, 16);
 	}
 	rc = virt_to_scatterlist(crypt_stat->key,
-				 (*key_rec).enc_key_size_bits / 8, src_sg, 2);
+				 (*key_rec).enc_key_size, src_sg, 2);
 	if (!rc) {
 		ecryptfs_printk(KERN_ERR, "Error generating scatterlist "
 				"for crypt_stat session key\n");
@@ -855,7 +855,7 @@ write_tag_3_packet(char *dest, int max, 
 		goto out;
 	}
 	rc = virt_to_scatterlist((*key_rec).enc_key,
-				 (*key_rec).enc_key_size_bits / 8, dest_sg, 2);
+				 (*key_rec).enc_key_size, dest_sg, 2);
 	if (!rc) {
 		ecryptfs_printk(KERN_ERR, "Error generating scatterlist "
 				"for crypt_stat encrypted session key\n");
@@ -870,7 +870,7 @@ write_tag_3_packet(char *dest, int max, 
 		goto out;
 	}
 	rc = crypto_cipher_setkey(tfm, session_key_encryption_key,
-				  (crypt_stat->key_size_bits / 8));
+				  crypt_stat->key_size);
 	if (rc < 0) {
 		ecryptfs_printk(KERN_ERR, "Error setting key for crypto "
 				"context\n");
@@ -878,19 +878,19 @@ write_tag_3_packet(char *dest, int max, 
 	}
 	rc = 0;
 	ecryptfs_printk(KERN_DEBUG, "Encrypting [%d] bytes of the key\n",
-			crypt_stat->key_size_bits / 8);
+			crypt_stat->key_size);
 	crypto_cipher_encrypt(tfm, dest_sg, src_sg,
-			      (*key_rec).enc_key_size_bits / 8);
+			      (*key_rec).enc_key_size);
 	ecryptfs_printk(KERN_DEBUG, "This should be the encrypted key:\n");
 	if (ecryptfs_verbosity > 0)
 		ecryptfs_dump_hex((*key_rec).enc_key,
-				  (*key_rec).enc_key_size_bits / 8);
+				  (*key_rec).enc_key_size);
 encrypted_session_key_set:
 	/* Now we have a valid key_rec.  Append it to the
 	 * key_rec set. */
 	key_rec_size = (sizeof(struct ecryptfs_key_record)
 			- ECRYPTFS_MAX_ENCRYPTED_KEY_BYTES
-			+ ((*key_rec).enc_key_size_bits / 8) );
+			+ ((*key_rec).enc_key_size));
 	/* TODO: Include a packet size limit as a parameter to this
 	 * function once we have multi-packet headers (for versions
 	 * later than 0.1 */
@@ -902,7 +902,7 @@ encrypted_session_key_set:
 	/* TODO: Packet size limit */
 	/* We have 5 bytes of surrounding packet data */
 	if ((0x05 + ECRYPTFS_SALT_SIZE
-	     + ((*key_rec).enc_key_size_bits / 8)) >= PAGE_CACHE_SIZE) {
+	     + (*key_rec).enc_key_size) >= PAGE_CACHE_SIZE) {
 		ecryptfs_printk(KERN_ERR, "Authentication token is too "
 				"large\n");
 		rc = -EINVAL;
@@ -914,7 +914,7 @@ encrypted_session_key_set:
 	/* ver+cipher+s2k+hash+salt+iter+enc_key */
 	rc = write_packet_length(&dest[(*packet_size)],
 				 (0x05 + ECRYPTFS_SALT_SIZE
-				  + ((*key_rec).enc_key_size_bits / 8)),
+				  + (*key_rec).enc_key_size),
 				 &packet_size_length);
 	if (rc) {
 		ecryptfs_printk(KERN_ERR, "Error generating tag 3 packet "
@@ -932,20 +932,20 @@ encrypted_session_key_set:
 	}
 	/* If it is AES, we need to get more specific. */
 	if (cipher_code == RFC2440_CIPHER_AES_128){
-		switch (crypt_stat->key_size_bits) {
-		case 128:
+		switch (crypt_stat->key_size) {
+		case 16:
 			break;
-		case 192:
+		case 24:
 			cipher_code = RFC2440_CIPHER_AES_192;
 			break;
-		case 256:
+		case 32:
 			cipher_code = RFC2440_CIPHER_AES_256;
 			break;
 		default:
 			rc = -EINVAL;
 			ecryptfs_printk(KERN_WARNING, "Unsupported AES key "
 					"size: [%d]\n",
-					crypt_stat->key_size_bits);
+					crypt_stat->key_size);
 			goto out;
 		}
 	}
@@ -957,8 +957,8 @@ encrypted_session_key_set:
 	(*packet_size) += ECRYPTFS_SALT_SIZE;	/* salt */
 	dest[(*packet_size)++] = 0x60;	/* hash iterations (65536) */
 	memcpy(&dest[(*packet_size)], (*key_rec).enc_key,
-	       (*key_rec).enc_key_size_bits / 8);
-	(*packet_size) += ((*key_rec).enc_key_size_bits / 8);
+	       (*key_rec).enc_key_size);
+	(*packet_size) += (*key_rec).enc_key_size;
 out:
 	if (tfm)
 		crypto_free_tfm(tfm);
diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index 57bbce7..3a19e00 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -265,13 +265,13 @@ static int ecryptfs_parse_options(struct
 			cipher_key_bytes =
 				(int)simple_strtol(cipher_key_bytes_src,
 						   &cipher_key_bytes_src, 0);
-			mount_crypt_stat->global_default_cipher_key_bits =
-				cipher_key_bytes << 3;
+			mount_crypt_stat->global_default_cipher_key_size =
+				cipher_key_bytes;
 			ecryptfs_printk(KERN_DEBUG,
 					"The mount_crypt_stat "
-					"global_default_cipher_key_bits "
+					"global_default_cipher_key_size "
 					"set to: [%d]\n", mount_crypt_stat->
-					global_default_cipher_key_bits);
+					global_default_cipher_key_size);
 			cipher_key_bytes_set = 1;
 			break;
 		case ecryptfs_opt_err:
@@ -304,12 +304,12 @@ static int ecryptfs_parse_options(struct
 		    = '\0';
 	}
 	if (!cipher_key_bytes_set) {
-		mount_crypt_stat->global_default_cipher_key_bits =
-				ECRYPTFS_DEFAULT_KEY_BYTES << 3;
-		ecryptfs_printk(KERN_DEBUG, "Cipher key bits were not "
+		mount_crypt_stat->global_default_cipher_key_size =
+			ECRYPTFS_DEFAULT_KEY_BYTES;
+		ecryptfs_printk(KERN_DEBUG, "Cipher key size was not "
 				"specified.  Defaulting to [%d]\n",
 				mount_crypt_stat->
-				global_default_cipher_key_bits);
+				global_default_cipher_key_size);
 	}
 	ecryptfs_printk(KERN_DEBUG, "Requesting the key with description: "
 			"[%s]\n", mount_crypt_stat->global_auth_tok_sig);
-- 
1.3.3

