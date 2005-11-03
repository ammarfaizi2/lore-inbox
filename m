Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030345AbVKCDzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030345AbVKCDzx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 22:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030346AbVKCDzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 22:55:52 -0500
Received: from c-67-182-200-232.hsd1.ut.comcast.net ([67.182.200.232]:58350
	"EHLO sshock.homelinux.net") by vger.kernel.org with ESMTP
	id S1030340AbVKCDzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 22:55:49 -0500
Date: Wed, 2 Nov 2005 20:56:11 -0700
From: Phillip Hellewell <phillip@hellewell.homeip.net>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: phillip@hellewell.homeip.net, mike@halcrow.us, mhalcrow@us.ibm.com,
       mcthomps@us.ibm.com, yoder1@us.ibm.com
Subject: [PATCH 11/12: eCryptfs] Keystore
Message-ID: <20051103035611.GK3005@sshock.rn.byu.edu>
References: <20051103033220.GD2772@sshock.rn.byu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051103033220.GD2772@sshock.rn.byu.edu>
X-URL: http://hellewell.homeip.net/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

eCryptfs keystore. Packet generation and parsing code. Authentication
token management code. This file has been trimmed down considerably to
support only mount-wide passphrases in the 0.1 release.

Signed off by: Phillip Hellewell <phillip@hellewell.homeip.net>
Signed off by: Michael Halcrow <mhalcrow@us.ibm.com>
Signed off by: Michael Thompson <mmcthomps@us.ibm.com>
Signed off by: Kent Yoder <yoder1@us.ibm.com>

 keystore.c |  860 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 860 insertions(+)
--- linux-2.6.14-rc5-mm1/fs/ecryptfs/keystore.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.14-rc5-mm1-ecryptfs/fs/ecryptfs/keystore.c	2005-11-01 15:51:59.000000000 -0600
@@ -0,0 +1,860 @@
+/**
+ * eCryptfs: Linux filesystem encryption layer
+ * In-kernel key management code.  Includes functions to parse and
+ * write authentication token-related packets with the underlying
+ * file.
+ *
+ * Copyright (c) 2005 International Business Machines Corp.
+ *   Author(s): Michael A. Halcrow <mhalcrow@us.ibm.com>
+ *              Michael C. Thompson <mcthomps@us.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
+ * 02111-1307, USA.
+ */
+
+#include <linux/string.h>
+#include <linux/sched.h>
+#include <linux/syscalls.h>
+#include <linux/pagemap.h>
+#include <linux/key.h>
+#include <linux/random.h>
+#include <linux/crypto.h>
+#include <asm/scatterlist.h>
+#include "ecryptfs_kernel.h"
+
+/**
+ * request_key returned an error instead of a valid key address;
+ * determine the type of error, make appropriate log entries, and
+ * return an error code.
+ */
+int process_request_key_err(long err_code)
+{
+	int rc = 0;
+	switch (err_code) {
+	case ENOKEY:
+		ecryptfs_printk(0, KERN_WARNING, "No key\n");
+		rc = -ENOENT;
+		break;
+	case EKEYEXPIRED:
+		ecryptfs_printk(0, KERN_WARNING, "Key expired\n");
+		rc = -ETIME;
+		break;
+	case EKEYREVOKED:
+		ecryptfs_printk(0, KERN_WARNING, "Key revoked\n");
+		rc = -EINVAL;
+		break;
+	default:
+		ecryptfs_printk(0, KERN_WARNING, "Unknown error code: "
+				"[%lu]\n", err_code);
+		rc = -EINVAL;
+	}
+	return rc;
+}
+
+static void ecryptfs_dump_auth_tok(struct ecryptfs_auth_tok *auth_tok)
+{
+	ecryptfs_printk(1, KERN_NOTICE, "Auth tok at mem loc [%p]:\n",
+			auth_tok);
+	ecryptfs_printk(1, KERN_NOTICE, " * instanceof = [%d]\n",
+			auth_tok->instanceof);
+	ecryptfs_printk(1, KERN_NOTICE, " * instantiated = [%d]\n",
+			auth_tok->instantiated);
+	switch (auth_tok->instanceof) {
+		char salt[ECRYPTFS_SALT_SIZE * 2 + 1];
+		char sig[ECRYPTFS_SIG_SIZE_HEX + 1];
+	case ECRYPTFS_PASSWORD:
+		ecryptfs_printk(1, KERN_NOTICE, " * password = [%s]\n",
+				auth_tok->token.password.password);
+		ecryptfs_printk(1, KERN_NOTICE, " * password_size = [%d]\n",
+				auth_tok->token.password.password_size);
+		ecryptfs_to_hex(salt, auth_tok->token.password.salt,
+				ECRYPTFS_SALT_SIZE);
+		salt[ECRYPTFS_SALT_SIZE * 2] = '\0';
+		ecryptfs_printk(1, KERN_NOTICE, " * salt = [%s]\n", salt);
+		ecryptfs_printk(1, KERN_NOTICE, " * saltless = [%d]\n",
+				auth_tok->token.password.saltless);
+		memcpy(sig, auth_tok->token.password.signature,
+		       ECRYPTFS_SIG_SIZE_HEX);
+		sig[ECRYPTFS_SIG_SIZE_HEX] = '\0';
+		ecryptfs_printk(1, KERN_NOTICE, " * signature = [%s]\n", sig);
+		break;
+	case ECRYPTFS_PRIVATE_KEY:
+		ecryptfs_printk(1, KERN_NOTICE, " * (NO PRIVATE KEY SUPPORT "
+				"IN ECRYPTFS VERSION 0.1)\n");
+		break;
+	default:
+		ecryptfs_printk(1, KERN_NOTICE, " * Unrecognized instanceof\n");
+	}
+	ecryptfs_printk(1, KERN_NOTICE, " * session_key.flags = [0x%x]\n",
+			auth_tok->session_key.flags);
+	if (auth_tok->session_key.flags
+	    & ECRYPTFS_USERSPACE_SHOULD_TRY_TO_DECRYPT) {
+		ecryptfs_printk(1, KERN_NOTICE,
+				" * Userspace decrypt request set\n");
+	}
+	if (auth_tok->session_key.flags
+	    & ECRYPTFS_USERSPACE_SHOULD_TRY_TO_ENCRYPT) {
+		ecryptfs_printk(1, KERN_NOTICE,
+				" * Userspace encrypt request set\n");
+	}
+	if (auth_tok->session_key.flags & ECRYPTFS_CONTAINS_DECRYPTED_KEY) {
+		ecryptfs_printk(1, KERN_NOTICE, " * Contains decrypted key\n");
+		ecryptfs_printk(1, KERN_NOTICE,
+				" * session_key.decrypted_key_size = [0x%x]\n",
+				auth_tok->session_key.decrypted_key_size);
+		ecryptfs_printk(1, KERN_NOTICE, " * Decrypted session key "
+				"dump:\n");
+		if (ecryptfs_verbosity > 0) {
+			ecryptfs_dump_hex(auth_tok->session_key.decrypted_key,
+					  ECRYPTFS_DEFAULT_KEY_BYTES);
+		}
+	}
+	if (auth_tok->session_key.flags & ECRYPTFS_CONTAINS_ENCRYPTED_KEY) {
+		ecryptfs_printk(1, KERN_NOTICE, " * Contains encrypted key\n");
+		ecryptfs_printk(1, KERN_NOTICE,
+				" * session_key.encrypted_key_size = [0x%x]\n",
+				auth_tok->session_key.encrypted_key_size);
+		ecryptfs_printk(1, KERN_NOTICE, " * Encrypted session key "
+				"dump:\n");
+		if (ecryptfs_verbosity > 0) {
+			ecryptfs_dump_hex(auth_tok->session_key.encrypted_key,
+					  auth_tok->session_key.
+					  encrypted_key_size);
+		}
+	}
+}
+
+static void wipe_auth_tok_list(struct list_head *auth_tok_list_head)
+{
+	struct list_head *walker;
+	ecryptfs_printk(1, KERN_NOTICE, "Enter\n");
+	walker = auth_tok_list_head->next;
+	while (walker != auth_tok_list_head) {
+		struct ecryptfs_auth_tok_list_item *auth_tok_list_item;
+		auth_tok_list_item =
+		    list_entry(walker, struct ecryptfs_auth_tok_list_item,
+			       list);
+		walker = auth_tok_list_item->list.next;
+		ecryptfs_kmem_cache_free(ecryptfs_auth_tok_list_item_cache,
+					 auth_tok_list_item);
+	}
+	ecryptfs_printk(1, KERN_NOTICE, "Exit\n");
+}
+
+kmem_cache_t *ecryptfs_auth_tok_list_item_cache;
+
+/**
+ * @return Zero on success
+ */
+static int parse_packet_length(unsigned char *data, int *offset, int *size)
+{
+	int rc = 0;
+	if (data[(*offset)] < 192) {
+		/* One-byte length */
+/*		(*size) = data[(*offset)++] - 0x05 - ECRYPTFS_SALT_SIZE; */
+		(*size) = data[(*offset)++];
+	} else if (data[(*offset)] < 224) {
+		/* Two-byte length */
+		(*size) = ((data[(*offset)++] - 192) * 256);
+		(*size) += (data[(*offset)++] + 192);
+	} else if (data[(*offset)] == 255) {
+		/* Three-byte length; we're not supposed to see this */
+		ecryptfs_printk(0, KERN_ERR, "Three-byte packet length\n");
+		rc = -EINVAL;
+		goto out;
+	} else {
+		ecryptfs_printk(0, KERN_ERR, "Error parsing packet length\n");
+		rc = -EINVAL;
+		goto out;
+	}
+out:
+	return rc;
+}
+
+static int write_packet_length(char *dest, int *dest_offset, int size)
+{
+	int rc = 0;
+	if (size < 192) {
+		dest[(*dest_offset)] = size;
+		(*dest_offset)++;
+	} else if (size < 65536) {
+		dest[(*dest_offset)] = (((size - 192) / 256) + 192);
+		(*dest_offset)++;
+		dest[(*dest_offset)] = ((size - 192) % 256);
+		(*dest_offset)++;
+	} else {
+		/**
+		*p++ = 255;
+		*p++ = size >> 24;
+		*p++ = size >> 16;
+		*p++ = size >>  8;
+		*p++ = size;
+		*/
+		rc = -EINVAL;
+		ecryptfs_printk(0, KERN_WARNING,
+				"Unsupported packet size: [%d]\n", size);
+	}
+	return rc;
+}
+
+/**
+ * Passphrase packet.
+ *
+ * @return New offset in the packet set page; error value on error.
+ */
+static int
+parse_tag_3_packet(struct ecryptfs_crypt_stats *crypt_stats,
+		   unsigned char *data, struct list_head *auth_tok_list)
+{
+	int i = 0;
+	int rc = 0;
+	int body_size = 0;
+	struct ecryptfs_auth_tok *auth_tok;
+	struct ecryptfs_auth_tok_list_item *auth_tok_list_item;
+
+	ecryptfs_printk(1, KERN_NOTICE, "Enter\n");
+	if (data[i++] != 0x8c) {
+		ecryptfs_printk(0, KERN_ERR, "Enter w/ first byte != 0x8c\n");
+		rc = -EINVAL;
+		goto out_no_mem;
+	}
+	/* Released: wipe_auth_tok_list called in ecryptfs_parse_packet_set or
+	 * at end of function upon failure */
+	auth_tok_list_item =
+	    ecryptfs_kmem_cache_alloc(ecryptfs_auth_tok_list_item_cache,
+				      SLAB_KERNEL);
+	if (!auth_tok_list_item) {
+		ecryptfs_printk(0, KERN_ERR, "Unable to allocate memory\n");
+		rc = -ENOMEM;
+		goto out_no_mem;
+	}
+	auth_tok = &auth_tok_list_item->auth_tok;
+	memset(auth_tok, 0, sizeof(struct ecryptfs_auth_tok));
+	/* TODO: Make *sure* it's encrypted; do this w/ policy tokens.
+	 * Actually, this is probably not the right place to set this
+	 * flag. If the eCryptfs marker matches, then we probably have
+	 * a real tag 3 packet, and hence the file is most likely
+	 * encrypted. */
+	rc = parse_packet_length(data, &i, &body_size);
+	if (rc) {
+		goto out;
+	}
+	auth_tok->session_key.encrypted_key_size =
+	    body_size - (0x05 + ECRYPTFS_SALT_SIZE);
+	ecryptfs_printk(1, KERN_NOTICE, "Encrypted key size = [%d]\n",
+			auth_tok->session_key.encrypted_key_size);
+	if (data[i++] != 0x04) {
+		ecryptfs_printk(1, KERN_NOTICE, "Unknown version number "
+				"[%d]\n", data[i - 1]);
+		rc = -EINVAL;
+		goto out;
+	}
+	/* TODO: finish the cipher mapping */
+	switch (data[i++]) {
+	case 0x01:
+		/* IDEA not supported */
+		crypt_stats->cipher[0] = '\0';
+		/* TODO: Error msg */
+		rc = -ENOSYS;
+		goto out;
+	case 0x02:
+		/* Choose Triple-DES */
+		strcpy(crypt_stats->cipher, "des3_ede");
+		break;
+	case 0x03:
+		/* Choose CAST5 */
+		strcpy(crypt_stats->cipher, "cast5");
+		break;
+	case 0x04:
+		/* Choose blowfish */
+		strcpy(crypt_stats->cipher, "blowfish");
+		break;
+	case 0x07:
+		/* Choose AES-128 */
+		strcpy(crypt_stats->cipher, "aes");
+		crypt_stats->key_size_bits = 128;
+		break;
+	case 0x08:
+		/* Choose AES-192 */
+		strcpy(crypt_stats->cipher, "aes");
+		crypt_stats->key_size_bits = 192;
+		break;
+	case 0x09:
+		/* Choose AES-256 */
+		strcpy(crypt_stats->cipher, "aes");
+		crypt_stats->key_size_bits = 256;
+		break;
+	default:
+		crypt_stats->cipher[0] = '\0';
+		/* TODO: Error msg */
+		rc = -EINVAL;
+		goto out;
+	}
+	ecryptfs_init_crypt_ctx(crypt_stats);
+	if (data[i++] != 0x03) {
+		ecryptfs_printk(0, KERN_ERR, "Only S2K ID 3 is currently "
+				"supported\n");
+		rc = -ENOSYS;
+		goto out;
+	}
+	/* TODO: finish the hash mapping */
+	switch (data[i++]) {
+	case 0x01:
+		/* Choose MD5 */
+		memcpy(auth_tok->token.password.salt, &data[i],
+		       ECRYPTFS_SALT_SIZE);
+		i += ECRYPTFS_SALT_SIZE;
+		auth_tok->token.password.hash_iterations =
+		    ((u32) 16 + (data[i] & 15)) << ((data[i] >> 4) + 6);
+		i++;
+		memcpy(auth_tok->session_key.encrypted_key, &data[i],
+		       auth_tok->session_key.encrypted_key_size);
+		i += auth_tok->session_key.encrypted_key_size;
+		auth_tok->session_key.flags &= ~ECRYPTFS_CONTAINS_DECRYPTED_KEY;
+		auth_tok->session_key.flags |= ECRYPTFS_CONTAINS_ENCRYPTED_KEY;
+		auth_tok->token.password.hash_algo = 0x01;
+		break;
+	default:
+		ecryptfs_printk(0, KERN_ERR, "Unsupported hash algorithm: "
+				"[%d]\n", data[i - 1]);
+		rc = -ENOSYS;
+		goto out;
+	}
+	/* TODO: Use the keyring */
+	auth_tok->uid = current->uid;
+	auth_tok->instanceof = ECRYPTFS_PASSWORD;
+	if (data[i++] != 0xed) {
+		ecryptfs_printk(0, KERN_ERR, "No (ecryptfs-specific) literal "
+				"packet containing authentication token "
+				"signature found after tag 3 packet\n");
+		rc = -EINVAL;
+		goto out;
+	}
+	if (data[i++] != (ECRYPTFS_SIG_SIZE + 13)) {
+		ecryptfs_printk(0, KERN_ERR, "Unrecognizable packet\n");
+		rc = -EINVAL;
+		goto out;
+	}
+	if (data[i++] != 0x62) {
+		ecryptfs_printk(0, KERN_ERR, "Unrecognizable packet\n");
+		rc = -EINVAL;
+		goto out;
+	}
+	if (data[i++] != 0x08) {
+		ecryptfs_printk(0, KERN_ERR, "Unrecognizable packet\n");
+		rc = -EINVAL;
+		goto out;
+	}
+	i += 12;		/* We don't care about the filename or the timestamp */
+	/* TODO: Parametarize; we might actually want userspace to
+	 * decrypt the session key. */
+	auth_tok->session_key.flags &=
+	    ~ECRYPTFS_USERSPACE_SHOULD_TRY_TO_DECRYPT;
+	auth_tok->session_key.flags &=
+	    ~ECRYPTFS_USERSPACE_SHOULD_TRY_TO_ENCRYPT;
+	ecryptfs_to_hex(auth_tok->token.password.signature, &data[i],
+			ECRYPTFS_SIG_SIZE);
+	auth_tok->token.password.signature[ECRYPTFS_PASSWORD_SIG_SIZE] = '\0';
+	rc = i;
+	list_add(&auth_tok_list_item->list, auth_tok_list);
+	crypt_stats->encrypted = 1;
+	goto out_success;
+out:
+	ecryptfs_kmem_cache_free(ecryptfs_auth_tok_list_item_cache,
+				 auth_tok_list_item);
+out_no_mem:
+out_success:
+	ecryptfs_printk(1, KERN_NOTICE, "Exit; rc = [%d]\n", rc);
+	return rc;
+}
+
+/**
+ * Decrypt the session key with the given auth_tok.
+ *
+ * TODO: Performance: This is a good candidate for optimization.
+ *
+ * @param auth_tok
+ * @return 0 on success; non-zero error otherwise
+ */
+static int decrypt_session_key(struct ecryptfs_auth_tok *auth_tok,
+			       struct ecryptfs_crypt_stats *crypt_stats)
+{
+	int rc = 0;
+	struct ecryptfs_password *password_s_ptr;
+	struct crypto_tfm *tfm = NULL;
+	struct scatterlist src_sg[2], dst_sg[2];
+	/* TODO: Use virt_to_scatterlist for these */
+	char *encrypted_session_key;
+	char *session_key;
+	password_s_ptr = &auth_tok->token.password;
+	if (password_s_ptr->session_key_encryption_key_set) {
+		ecryptfs_printk(1, KERN_NOTICE, "Session key encryption key "
+				"set; skipping key generation\n");
+		goto session_key_encryption_key_set;
+	}
+      session_key_encryption_key_set:
+	ecryptfs_printk(1, KERN_NOTICE, "Session key encryption key (size [%d])"
+			":\n", password_s_ptr->session_key_encryption_key_size);
+	if (ecryptfs_verbosity > 0) {
+		ecryptfs_dump_hex(password_s_ptr->session_key_encryption_key,
+				  password_s_ptr->
+				  session_key_encryption_key_size);
+	}
+	tfm = crypto_alloc_tfm(crypt_stats->cipher, 0);
+	crypto_cipher_setkey(tfm, password_s_ptr->session_key_encryption_key,
+			     password_s_ptr->session_key_encryption_key_size);
+	/* TODO: virt_to_scatterlist */
+	encrypted_session_key = (char *)__get_free_page(GFP_KERNEL);
+	if (!encrypted_session_key) {
+		ecryptfs_printk(0, KERN_ERR, "Out of memory\n");
+		rc = -ENOMEM;
+		goto out;
+	}
+	session_key = (char *)__get_free_page(GFP_KERNEL);
+	if (!session_key) {
+		ecryptfs_kfree(encrypted_session_key);
+		ecryptfs_printk(0, KERN_ERR, "Out of memory\n");
+		rc = -ENOMEM;
+		goto out;
+	}
+	memcpy(encrypted_session_key, auth_tok->session_key.encrypted_key,
+	       auth_tok->session_key.encrypted_key_size);
+	src_sg[0].page = virt_to_page(encrypted_session_key);
+	src_sg[0].offset = 0;
+	/* TODO: key_size < PAGE_CACHE_SIZE */
+	src_sg[0].length = auth_tok->session_key.encrypted_key_size;
+	dst_sg[0].page = virt_to_page(session_key);
+	dst_sg[0].offset = 0;
+	auth_tok->session_key.decrypted_key_size =
+	    auth_tok->session_key.encrypted_key_size;
+	dst_sg[0].length = auth_tok->session_key.encrypted_key_size;
+	/* TODO: Handle error condition */
+	crypto_cipher_decrypt(tfm, dst_sg, src_sg,
+			      auth_tok->session_key.encrypted_key_size);
+	auth_tok->session_key.decrypted_key_size =
+	    auth_tok->session_key.encrypted_key_size;
+	memcpy(auth_tok->session_key.decrypted_key, session_key,
+	       auth_tok->session_key.decrypted_key_size);
+	auth_tok->session_key.flags |= ECRYPTFS_CONTAINS_DECRYPTED_KEY;
+	memcpy(crypt_stats->key, auth_tok->session_key.decrypted_key,
+	       auth_tok->session_key.decrypted_key_size);
+	crypt_stats->key_valid = 1;
+	crypt_stats->key_size_bits =
+	    auth_tok->session_key.decrypted_key_size * 8;
+	ecryptfs_printk(1, KERN_NOTICE, "Decrypted session key:\n");
+	if (ecryptfs_verbosity > 0) {
+		ecryptfs_dump_hex(crypt_stats->key,
+				  crypt_stats->key_size_bits / 8);
+	}
+	free_page((unsigned long)encrypted_session_key);
+	free_page((unsigned long)session_key);
+out:
+	if (tfm)
+		crypto_free_tfm(tfm);
+	return rc;
+}
+
+/**
+ * N.B. This comment is applicable to 0.2 release (and later) only.
+ * Extract the authentication token signatures.  eCryptfs expects this
+ * function to recover the symmetric key of the crypt_stats structure
+ * if at all possible, given the current packet set.  Authentication
+ * tokens are composed of the tokens themselves and their descriptors.
+ * It is possible to have an authentication token object in the
+ * keyring that only has a descriptor and not a token component.  Each
+ * eCryptfs file header contains a concatenation of descriptors.  For
+ * each descriptor, this function assures that an authentication token
+ * object is instantiated in the keyring.  This instantiation takes
+ * place in the request_key callout application.  Thus, the callout
+ * application requires the complete descriptor.  The crypt_stats
+ * object contains a set of descriptors that apply to this file.  When
+ * the headers are written out, they are re-constructed from the set
+ * of authentication token descriptors.
+ *
+ * If at any point we have a problem parsing the packets, we will -EIO and
+ * just bail out.
+ *
+ * GOAL: Get crypt_stats to have the file's session key.
+ * 
+ * @param dest	The header page in memory
+ * @return	0 if a valid authentication token was retrieved and processed;
+ * 		negative value for file not encrypted or for error conditions
+ */
+int ecryptfs_parse_packet_set(unsigned char *dest,
+			      struct ecryptfs_crypt_stats *crypt_stats,
+			      struct dentry *ecryptfs_dentry)
+{
+	int i = (ECRYPTFS_FILE_SIZE_BYTES + MAGIC_ECRYPTFS_MARKER_SIZE_BYTES);
+	int rc = 0;
+	int found_auth_tok = 0;
+	int next_packet_is_auth_tok_packet;
+	char sig[ECRYPTFS_SIG_SIZE_HEX];
+	struct list_head auth_tok_list;
+	struct list_head *walker;
+	struct ecryptfs_auth_tok *chosen_auth_tok = NULL;
+	struct ecryptfs_mount_crypt_stats *mount_crypt_stats =
+	    &(SUPERBLOCK_TO_PRIVATE(ecryptfs_dentry->d_sb)->mount_crypt_stats);
+	struct ecryptfs_auth_tok *candidate_auth_tok = NULL;
+
+	ecryptfs_printk(1, KERN_NOTICE, "Enter\n");
+	if (!contains_ecryptfs_marker(dest)) {
+		ecryptfs_printk(0, KERN_NOTICE, "eCryptfs marker not found\n");
+		rc = -EINVAL;	/* TODO: Make this a #define */
+		goto out;
+	}
+	ecryptfs_set_default_sizes(crypt_stats);
+	INIT_LIST_HEAD(&auth_tok_list);
+
+	/* Parse the header to find as many packets as we can, these will be
+	 * added the our &auth_tok_list */
+	next_packet_is_auth_tok_packet = 1;
+	while (next_packet_is_auth_tok_packet) {
+		switch (dest[i]) {
+		case 0x8c:	/* tag 3 packet; s2k */
+			rc = parse_tag_3_packet(crypt_stats,
+						(unsigned char *)&dest[i],
+						&auth_tok_list);
+			if (rc != -EINVAL && rc != -ENOMEM) {
+				i += rc;
+				rc = 0;
+			} else {
+				ecryptfs_printk(0, KERN_ERR, "Error parsing "
+						"tag 3 packet\n");
+				rc = -EIO;
+				goto out_wipe_list;
+			}
+			break;
+		default:
+			ecryptfs_printk(1, KERN_NOTICE, "No packet at offset "
+					"[%d] of the file header; hex value of "
+					"character is [0x%.2x]\n", i, dest[i]);
+			next_packet_is_auth_tok_packet = 0;
+		}
+	}
+	if (list_empty(&auth_tok_list)) {
+		rc = -EINVAL;	/* Do not support non-encrypted files */
+		goto out;
+	}
+
+	/* If we have a global auth tok, then use it should be tried */
+	if (mount_crypt_stats->global_auth_tok) {
+		memcpy(sig, mount_crypt_stats->global_auth_tok_sig,
+		       ECRYPTFS_SIG_SIZE_HEX);
+		chosen_auth_tok = mount_crypt_stats->global_auth_tok;
+	} else {
+		BUG();		/* This should not be the case in 0.1 release */
+	}
+	/* Scan list to see if our chosen_auth_tok works */
+	list_for_each(walker, &auth_tok_list) {
+		struct ecryptfs_auth_tok_list_item *auth_tok_list_item;
+		auth_tok_list_item =
+		    list_entry(walker, struct ecryptfs_auth_tok_list_item,
+			       list);
+		candidate_auth_tok = &auth_tok_list_item->auth_tok;
+		if (unlikely(ecryptfs_verbosity > 0)) {
+			ecryptfs_printk(1, KERN_NOTICE,
+					"Considering cadidate auth tok:\n");
+			ecryptfs_dump_auth_tok(candidate_auth_tok);
+		}
+		/* TODO: Replace ECRYPTFS_SIG_SIZE_HEX w/ dynamic value */
+		if ((candidate_auth_tok->instanceof == ECRYPTFS_PASSWORD) &&
+		    !strncmp(candidate_auth_tok->token.password.signature,
+			     sig, ECRYPTFS_SIG_SIZE_HEX)) {
+			found_auth_tok = 1;
+			goto leave_list;
+			/* TODO: Transfer the common salt into the
+			 * crypt_stats salt */
+		}
+	}
+leave_list:
+	if (!found_auth_tok) {
+		ecryptfs_printk(0, KERN_ERR, "Could not find authentication "
+				"token on temporary list for sig [%.*s]\n",
+				ECRYPTFS_SIG_SIZE_HEX, sig);
+		goto out_wipe_list;
+	} else {
+		memcpy(&(candidate_auth_tok->token.password),
+		       &(chosen_auth_tok->token.password),
+		       sizeof(struct ecryptfs_password));
+		decrypt_session_key(candidate_auth_tok, crypt_stats);
+	}
+
+out_wipe_list:
+	wipe_auth_tok_list(&auth_tok_list);
+out:
+	ecryptfs_printk(1, KERN_NOTICE, "Exit; rc = [%d]\n", rc);
+	return rc;
+}
+
+/**
+ * Write passphrase packet
+ *
+ * @param dest Buffer into which to write the packet
+ * @param max Maximum number of bytes that can be writtn
+ * @return Number of bytes written; 0 on error
+ */
+static int
+write_tag_3_packet(char *dest, int dest_offset, int max,
+		   struct ecryptfs_auth_tok *auth_tok,
+		   struct ecryptfs_crypt_stats *crypt_stats)
+{
+	int rc = 0;
+	struct ecryptfs_key_record key_rec;
+	int i;
+	int signature_is_valid = 0;
+	int encrypted_session_key_valid = 0;
+	char session_key_encryption_key[ECRYPTFS_MAX_KEY_BYTES];
+	struct scatterlist dest_sg[2];
+	struct scatterlist src_sg[2];
+	struct crypto_tfm *tfm = NULL;
+	int key_rec_size;
+	int offset_save = 0;
+
+	ecryptfs_printk(1, KERN_NOTICE, "Enter; dest_offset = [%d]\n",
+			dest_offset);
+	/* Check for a valid signature on the auth_tok */
+	for (i = 0; i < ECRYPTFS_SIG_SIZE_HEX; i++)
+		signature_is_valid |= auth_tok->token.password.signature[i];
+	if (!signature_is_valid) {
+		BUG();
+	}
+	ecryptfs_from_hex(key_rec.sig, auth_tok->token.password.signature,
+			  ECRYPTFS_SIG_SIZE);
+	key_rec.enc_key_size_bits = crypt_stats->key_size_bits;
+	key_rec.type = ECRYPTFS_PACKET_SET_TYPE_PASSWORD;
+
+	encrypted_session_key_valid = 0;
+	if (auth_tok->session_key.encrypted_key_size == 0) {
+		auth_tok->session_key.encrypted_key_size =
+		    ECRYPTFS_MAX_ENCRYPTED_KEY_BYTES;
+	}
+	for (i = 0; i < auth_tok->session_key.encrypted_key_size; i++)
+		encrypted_session_key_valid |=
+		    auth_tok->session_key.encrypted_key[i];
+	if (auth_tok->session_key.encrypted_key_size == 0) {
+		ecryptfs_printk(0, KERN_WARNING, "auth_tok->session_key."
+				"encrypted_key_size == 0");
+		auth_tok->session_key.encrypted_key_size =
+		    ECRYPTFS_DEFAULT_KEY_BYTES;
+	}
+	if (encrypted_session_key_valid) {
+		memcpy(key_rec.enc_key,
+		       auth_tok->session_key.encrypted_key,
+		       auth_tok->session_key.encrypted_key_size);
+		goto encrypted_session_key_set;
+	}
+	if (auth_tok->token.password.session_key_encryption_key_set) {
+		ecryptfs_printk(1, KERN_NOTICE, "Using previously generated "
+				"session key encryption key of size [%d]\n",
+				auth_tok->token.password.
+				session_key_encryption_key_size);
+		memcpy(session_key_encryption_key,
+		       auth_tok->token.password.session_key_encryption_key,
+		       auth_tok->token.password.
+		       session_key_encryption_key_size);
+		ecryptfs_printk(1, KERN_NOTICE,
+				"Cached session key " "encryption key: \n");
+		ecryptfs_dump_hex(session_key_encryption_key, 16);
+
+		goto session_key_encryption_key_set;
+	}
+      session_key_encryption_key_set:
+	if (unlikely(ecryptfs_verbosity > 0)) {
+		ecryptfs_printk(1, KERN_NOTICE, "Session key encryption key:"
+				"\n");
+		ecryptfs_dump_hex(session_key_encryption_key, 16);
+	}
+	/* Encrypt the key with the key encryption key */
+	/* Set up the scatterlists */
+	rc = virt_to_scatterlist(crypt_stats->key,
+				 crypt_stats->key_size_bits / 8, src_sg, 2);
+	if (!rc) {
+		ecryptfs_printk(0, KERN_ERR, "Error generating scatterlist "
+				"for crypt_stats session key\n");
+		rc = -ENOMEM;
+		goto out;
+	}
+	rc = virt_to_scatterlist(key_rec.enc_key,
+				 key_rec.enc_key_size_bits / 8, dest_sg, 2);
+	if (!rc) {
+		ecryptfs_printk(0, KERN_ERR, "Error generating scatterlist "
+				"for crypt_stats encrypted session key\n");
+		rc = -ENOMEM;
+		goto out;
+	}
+	/* Initialize the key encryption context */
+	ASSERT(crypt_stats->cipher);
+	if ((tfm = crypto_alloc_tfm(crypt_stats->cipher, 0)) == NULL) {
+		ecryptfs_printk(0, KERN_ERR, "Could not initialize crypto "
+				"context for cipher [%s]\n",
+				crypt_stats->cipher);
+		rc = 0;
+		goto out;
+	}
+	/* Set the key encryption key */
+	rc = crypto_cipher_setkey(tfm, session_key_encryption_key,
+				  ECRYPTFS_DEFAULT_KEY_BYTES);
+	if (rc < 0) {
+		ecryptfs_printk(0, KERN_ERR, "Error setting key for crypto "
+				"context\n");
+		rc = 0;
+		goto out;
+	}
+	ecryptfs_printk(1, KERN_NOTICE, "Encrypting [%d] bytes of the key\n",
+			crypt_stats->key_size_bits / 8);
+	crypto_cipher_encrypt(tfm, dest_sg, src_sg,
+			      crypt_stats->key_size_bits / 8);
+
+	ecryptfs_printk(1, KERN_NOTICE, "This should be the encrypted key:\n");
+	ecryptfs_dump_hex(key_rec.enc_key, key_rec.enc_key_size_bits / 8);
+encrypted_session_key_set:
+	/* Now we have a valid key_rec.  Append it to the
+	 * key_rec set. */
+	key_rec_size = KEY_REC_SIZE(key_rec);
+	if ((dest_offset + key_rec_size) >= ECRYPTFS_MAX_KEYSET_SIZE) {
+		ecryptfs_printk(0, KERN_ERR, "Keyset too large\n");
+		rc = 0;
+		goto out;
+	}
+	offset_save = dest_offset;
+	if ((dest_offset + 0x05 + ECRYPTFS_SALT_SIZE
+	     + (key_rec.enc_key_size_bits / 8)) >= PAGE_CACHE_SIZE) {
+		ecryptfs_printk(0, KERN_ERR, "Too many authentication tokens; "
+				"cryptfs does not yet support this many\n");
+		rc = 0;
+		goto out;
+	}
+	/* This format is inspired by OpenPGP; see RFC 2440
+	 * packet tag 3 */
+	*(dest + (dest_offset++)) = 0x8c;	/* tag 3 */
+	/* ver+cipher+s2k+hash+salt+iter+enc_key */
+	rc = write_packet_length(dest, &dest_offset,
+				 (0x05 + ECRYPTFS_SALT_SIZE
+				  + (key_rec.enc_key_size_bits / 8)));
+	*(dest + (dest_offset++)) = 0x04;	/* version 4 */
+	if (strcmp(crypt_stats->cipher, "des3_ede") == 0) {
+		*(dest + (dest_offset++)) = 0x02;	/* Triple-DES */
+	} else if (strcmp(crypt_stats->cipher, "cast5") == 0) {
+		*(dest + (dest_offset++)) = 0x03;	/* CAST5 */
+	} else if (strcmp(crypt_stats->cipher, "blowfish") == 0) {
+		*(dest + (dest_offset++)) = 0x04;	/* BLOWFISH */
+	} else if (strcmp(crypt_stats->cipher, "aes") == 0) {
+		switch (crypt_stats->key_size_bits) {
+		case 128:
+			*(dest + (dest_offset++)) = 0x07;	/* AES-128 */
+			break;
+		case 192:
+			*(dest + (dest_offset++)) = 0x08;	/* AES-192 */
+			break;
+		case 256:
+			*(dest + (dest_offset++)) = 0x09;	/* AES-256 */
+			break;
+		default:
+			rc = -EINVAL;
+			ecryptfs_printk(0, KERN_WARNING, "Unsupported AES key "
+					"size: [%d]\n", 
+					crypt_stats->key_size_bits);
+			goto out;
+		}
+	} else {
+		rc = -EINVAL;
+		ecryptfs_printk(0, KERN_WARNING, "Unsupported cipher: [%s]\n",
+				crypt_stats->cipher);
+
+		goto out;
+	}
+	*(dest + (dest_offset++)) = 0x03;	/* S2K */
+	*(dest + (dest_offset++)) = 0x01;	/* MD5 (TODO) */
+	memcpy((dest + dest_offset), auth_tok->token.password.salt,
+	       ECRYPTFS_SALT_SIZE);
+	dest_offset += ECRYPTFS_SALT_SIZE;	/* salt */
+	*(dest + (dest_offset++)) = 0x60;	/* hash iterations */
+	memcpy((dest + dest_offset), key_rec.enc_key,
+	       key_rec.enc_key_size_bits / 8);
+	dest_offset += (key_rec.enc_key_size_bits / 8);
+	/* Write auth tok signature packet */
+	*(dest + (dest_offset++)) = 0xed;	/* tag 11 */
+	*(dest + (dest_offset++)) = ECRYPTFS_SIG_SIZE + 13;	/* packet
+								 * length */
+	*(dest + (dest_offset++)) = 0x62;	/* binary type */
+	*(dest + (dest_offset++)) = 0x08;	/* filename length */
+	strncpy((dest + dest_offset), "_CONSOLE", 0x08);
+	dest_offset += 0x08;
+	memset((dest + dest_offset), 0, 4);
+	dest_offset += 4;
+	memcpy((dest + dest_offset), key_rec.sig, ECRYPTFS_SIG_SIZE);
+	dest_offset += ECRYPTFS_SIG_SIZE;
+	*(dest + (dest_offset)) = 0x00;	/* NULL terminator */
+	rc = dest_offset;
+out:
+	if (tfm)
+		crypto_free_tfm(tfm);
+	ecryptfs_printk(1, KERN_NOTICE, "Exit; rc = [%d]\n", rc);
+	return rc;
+}
+
+/**
+ * Generates a key packet set and writes it to the virtual address
+ * passed in.
+ *
+ * @param dest		Page to which to write the key record set
+ * @param crypt_stats	The cryptographic context from which the authentication
+ * 			tokens will be retrieved
+ * @return		Size of the data written; 0 if there was nothing to
+ * 			write or if a problem was encountered
+ */
+int
+ecryptfs_generate_key_packet_set(char *dest_base, int start_offset,
+				 struct ecryptfs_crypt_stats *crypt_stats,
+				 struct dentry *ecryptfs_dentry)
+{
+	int rc = 0;
+	struct ecryptfs_auth_tok *auth_tok;
+	int dest_offset = start_offset;
+	struct ecryptfs_mount_crypt_stats *mount_crypt_stats =
+	    &(SUPERBLOCK_TO_PRIVATE(ecryptfs_dentry->d_sb)->mount_crypt_stats);
+
+	ecryptfs_printk(1, KERN_NOTICE, "Enter; start_offset = [%d]\n",
+			start_offset);
+	if (mount_crypt_stats->global_auth_tok) {
+		auth_tok = mount_crypt_stats->global_auth_tok;
+		switch (auth_tok->instanceof) {
+		case ECRYPTFS_PASSWORD:
+			rc = write_tag_3_packet(dest_base, dest_offset,
+						PAGE_CACHE_SIZE, auth_tok,
+						crypt_stats);
+			break;
+		default:
+			ecryptfs_printk(0, KERN_WARNING, "Unknown "
+					"authentication token type [%d]\n",
+					auth_tok->instanceof);
+			rc = 0;
+		}
+		if (rc == 0) {
+			ecryptfs_printk(1, KERN_WARNING, "Error writing "
+					"authentication token packet with sig "
+					"= [%s]\n",
+					mount_crypt_stats->global_auth_tok_sig);
+			goto out;
+		} else {
+			dest_offset += rc;
+		}
+	} else {
+		BUG();
+	}
+      out:
+	ecryptfs_printk(1, KERN_NOTICE, "Exit; rc = [%d]\n", rc);
+	return rc;
+}
