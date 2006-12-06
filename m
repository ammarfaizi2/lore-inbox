Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937777AbWLFXMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937777AbWLFXMn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 18:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937778AbWLFXMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 18:12:43 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:45938 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937777AbWLFXMl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 18:12:41 -0500
Date: Wed, 6 Dec 2006 17:12:37 -0600
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: akpm@osdl.org
Cc: LKML <linux-kernel@vger.kernel.org>, trevor.highland@gmail.com,
       tyhicks@ou.edu, mhalcrow@us.ibm.com
Subject: [PATCH 2/2] eCryptfs: Public key; packet management
Message-ID: <20061206231236.GB9358@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20061206230638.GA9358@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061206230638.GA9358@us.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Public key support code. This reads and writes packets in the header
that contain public key encrypted file keys. It calls the messaging
code in the previous patch to send and receive encryption and
decryption request packets from the userspace daemon.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>
---

 fs/ecryptfs/Makefile          |    2 
 fs/ecryptfs/ecryptfs_kernel.h |    7 
 fs/ecryptfs/keystore.c        |  784 +++++++++++++++++++++++++++++++++++++----
 fs/ecryptfs/main.c            |   49 ++-
 fs/ecryptfs/messaging.c       |   10 -
 fs/ecryptfs/mmap.c            |   91 -----
 fs/ecryptfs/netlink.c         |    4 
 7 files changed, 777 insertions(+), 170 deletions(-)

9979020958c5ee2d0d671cf47144a4a93def964d
diff --git a/fs/ecryptfs/Makefile b/fs/ecryptfs/Makefile
index ca65624..1f11072 100644
--- a/fs/ecryptfs/Makefile
+++ b/fs/ecryptfs/Makefile
@@ -4,4 +4,4 @@ #
 
 obj-$(CONFIG_ECRYPT_FS) += ecryptfs.o
 
-ecryptfs-objs := dentry.o file.o inode.o main.o super.o mmap.o crypto.o keystore.o debug.o
+ecryptfs-objs := dentry.o file.o inode.o main.o super.o mmap.o crypto.o keystore.o messaging.o netlink.o debug.o
diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index 2bae036..3d78107 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -32,6 +32,7 @@ #include <keys/user-type.h>
 #include <linux/fs.h>
 #include <linux/namei.h>
 #include <linux/scatterlist.h>
+#include <linux/hash.h>
 
 /* Version verification for shared data structures w/ userspace */
 #define ECRYPTFS_VERSION_MAJOR 0x00
@@ -46,7 +47,8 @@ #define ECRYPTFS_VERSIONING_PUBKEY 0x000
 #define ECRYPTFS_VERSIONING_PLAINTEXT_PASSTHROUGH 0x00000004
 #define ECRYPTFS_VERSIONING_POLICY 0x00000008
 #define ECRYPTFS_VERSIONING_MASK (ECRYPTFS_VERSIONING_PASSPHRASE \
-                                  | ECRYPTFS_VERSIONING_PLAINTEXT_PASSTHROUGH)
+                                  | ECRYPTFS_VERSIONING_PLAINTEXT_PASSTHROUGH \
+                                  | ECRYPTFS_VERSIONING_PUBKEY)
 
 #define ECRYPTFS_MAX_PASSWORD_LENGTH 64
 #define ECRYPTFS_MAX_PASSPHRASE_BYTES ECRYPTFS_MAX_PASSWORD_LENGTH
@@ -561,7 +563,8 @@ int ecryptfs_close_lower_file(struct fil
 
 int ecryptfs_process_helo(unsigned int transport, uid_t uid, pid_t pid);
 int ecryptfs_process_quit(uid_t uid, pid_t pid);
-int ecryptfs_process_response(struct ecryptfs_message *msg, pid_t pid, u32 seq);
+int ecryptfs_process_response(struct ecryptfs_message *msg, uid_t uid,
+			      pid_t pid, u32 seq);
 int ecryptfs_send_message(unsigned int transport, char *data, int data_len,
 			  struct ecryptfs_msg_ctx **msg_ctx);
 int ecryptfs_wait_for_response(struct ecryptfs_msg_ctx *msg_ctx,
diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index c3746f5..84e9907 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -7,6 +7,7 @@
  * Copyright (C) 2004-2006 International Business Machines Corp.
  *   Author(s): Michael A. Halcrow <mhalcrow@us.ibm.com>
  *              Michael C. Thompson <mcthomps@us.ibm.com>
+ *              Trevor S. Highland <trevor.highland@gmail.com>
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
@@ -64,26 +65,6 @@ int process_request_key_err(long err_cod
 	return rc;
 }
 
-static void wipe_auth_tok_list(struct list_head *auth_tok_list_head)
-{
-	struct list_head *walker;
-	struct ecryptfs_auth_tok_list_item *auth_tok_list_item;
-
-	walker = auth_tok_list_head->next;
-	while (walker != auth_tok_list_head) {
-		auth_tok_list_item =
-		    list_entry(walker, struct ecryptfs_auth_tok_list_item,
-			       list);
-		walker = auth_tok_list_item->list.next;
-		memset(auth_tok_list_item, 0,
-		       sizeof(struct ecryptfs_auth_tok_list_item));
-		kmem_cache_free(ecryptfs_auth_tok_list_item_cache,
-				auth_tok_list_item);
-	}
-}
-
-struct kmem_cache *ecryptfs_auth_tok_list_item_cache;
-
 /**
  * parse_packet_length
  * @data: Pointer to memory containing length at offset
@@ -102,12 +83,12 @@ static int parse_packet_length(unsigned 
 	(*size) = 0;
 	if (data[0] < 192) {
 		/* One-byte length */
-		(*size) = data[0];
+		(*size) = (unsigned char)data[0];
 		(*length_size) = 1;
 	} else if (data[0] < 224) {
 		/* Two-byte length */
-		(*size) = ((data[0] - 192) * 256);
-		(*size) += (data[1] + 192);
+		(*size) = (((unsigned char)(data[0]) - 192) * 256);
+		(*size) += ((unsigned char)(data[1]) + 192);
 		(*length_size) = 2;
 	} else if (data[0] == 255) {
 		/* Five-byte length; we're not supposed to see this */
@@ -154,6 +135,499 @@ static int write_packet_length(char *des
 	return rc;
 }
 
+static int
+write_tag_64_packet(char *signature, struct ecryptfs_session_key *session_key,
+		    char **packet, size_t *packet_len)
+{
+	size_t i = 0;
+	size_t data_len;
+	size_t packet_size_len;
+	char *message;
+	int rc;
+
+	/*
+	 *              ***** TAG 64 Packet Format *****
+	 *    | Content Type                       | 1 byte       |
+	 *    | Key Identifier Size                | 1 or 2 bytes |
+	 *    | Key Identifier                     | arbitrary    |
+	 *    | Encrypted File Encryption Key Size | 1 or 2 bytes |
+	 *    | Encrypted File Encryption Key      | arbitrary    |
+	 */
+	data_len = (5 + ECRYPTFS_SIG_SIZE_HEX
+		    + session_key->encrypted_key_size);
+	*packet = kmalloc(data_len, GFP_KERNEL);
+	message = *packet;
+	if (!message) {
+		ecryptfs_printk(KERN_ERR, "Unable to allocate memory\n");
+		rc = -ENOMEM;
+		goto out;
+	}
+	message[i++] = ECRYPTFS_TAG_64_PACKET_TYPE;
+	rc = write_packet_length(&message[i], ECRYPTFS_SIG_SIZE_HEX,
+				 &packet_size_len);
+	if (rc) {
+		ecryptfs_printk(KERN_ERR, "Error generating tag 64 packet "
+				"header; cannot generate packet length\n");
+		goto out;
+	}
+	i += packet_size_len;
+	memcpy(&message[i], signature, ECRYPTFS_SIG_SIZE_HEX);
+	i += ECRYPTFS_SIG_SIZE_HEX;
+	rc = write_packet_length(&message[i], session_key->encrypted_key_size,
+				 &packet_size_len);
+	if (rc) {
+		ecryptfs_printk(KERN_ERR, "Error generating tag 64 packet "
+				"header; cannot generate packet length\n");
+		goto out;
+	}
+	i += packet_size_len;
+	memcpy(&message[i], session_key->encrypted_key,
+	       session_key->encrypted_key_size);
+	i += session_key->encrypted_key_size;
+	*packet_len = i;
+out:
+	return rc;
+}
+
+static int
+parse_tag_65_packet(struct ecryptfs_session_key *session_key, u16 *cipher_code,
+		    struct ecryptfs_message *msg)
+{
+	size_t i = 0;
+	char *data;
+	size_t data_len;
+	size_t m_size;
+	size_t message_len;
+	u16 checksum = 0;
+	u16 expected_checksum = 0;
+	int rc;
+
+	/*
+	 *              ***** TAG 65 Packet Format *****
+	 *         | Content Type             | 1 byte       |
+	 *         | Status Indicator         | 1 byte       |
+	 *         | File Encryption Key Size | 1 or 2 bytes |
+	 *         | File Encryption Key      | arbitrary    |
+	 */
+	message_len = msg->data_len;
+	data = msg->data;
+	if (message_len < 4) {
+		rc = -EIO;
+		goto out;
+	}
+	if (data[i++] != ECRYPTFS_TAG_65_PACKET_TYPE) {
+		ecryptfs_printk(KERN_ERR, "Type should be ECRYPTFS_TAG_65\n");
+		rc = -EIO;
+		goto out;
+	}
+	if (data[i++]) {
+		ecryptfs_printk(KERN_ERR, "Status indicator has non-zero value "
+				"[%d]\n", data[i-1]);
+		rc = -EIO;
+		goto out;
+	}
+	rc = parse_packet_length(&data[i], &m_size, &data_len);
+	if (rc) {
+		ecryptfs_printk(KERN_WARNING, "Error parsing packet length; "
+				"rc = [%d]\n", rc);
+		goto out;
+	}
+	i += data_len;
+	if (message_len < (i + m_size)) {
+		ecryptfs_printk(KERN_ERR, "The received netlink message is "
+				"shorter than expected\n");
+		rc = -EIO;
+		goto out;
+	}
+	if (m_size < 3) {
+		ecryptfs_printk(KERN_ERR,
+				"The decrypted key is not long enough to "
+				"include a cipher code and checksum\n");
+		rc = -EIO;
+		goto out;
+	}
+	*cipher_code = data[i++];
+	/* The decrypted key includes 1 byte cipher code and 2 byte checksum */
+	session_key->decrypted_key_size = m_size - 3;
+	if (session_key->decrypted_key_size > ECRYPTFS_MAX_KEY_BYTES) {
+		ecryptfs_printk(KERN_ERR, "key_size [%d] larger than "
+				"the maximum key size [%d]\n",
+				session_key->decrypted_key_size,
+				ECRYPTFS_MAX_ENCRYPTED_KEY_BYTES);
+		rc = -EIO;
+		goto out;
+	}
+	memcpy(session_key->decrypted_key, &data[i],
+	       session_key->decrypted_key_size);
+	i += session_key->decrypted_key_size;
+	expected_checksum += (unsigned char)(data[i++]) << 8;
+	expected_checksum += (unsigned char)(data[i++]);
+	for (i = 0; i < session_key->decrypted_key_size; i++)
+		checksum += session_key->decrypted_key[i];
+	if (expected_checksum != checksum) {
+		ecryptfs_printk(KERN_ERR, "Invalid checksum for file "
+				"encryption  key; expected [%x]; calculated "
+				"[%x]\n", expected_checksum, checksum);
+		rc = -EIO;
+	}
+out:
+	return rc;
+}
+
+
+static int
+write_tag_66_packet(char *signature, size_t cipher_code,
+		    struct ecryptfs_crypt_stat *crypt_stat, char **packet,
+		    size_t *packet_len)
+{
+	size_t i = 0;
+	size_t j;
+	size_t data_len;
+	size_t checksum = 0;
+	size_t packet_size_len;
+	char *message;
+	int rc;
+
+	/*
+	 *              ***** TAG 66 Packet Format *****
+	 *         | Content Type             | 1 byte       |
+	 *         | Key Identifier Size      | 1 or 2 bytes |
+	 *         | Key Identifier           | arbitrary    |
+	 *         | File Encryption Key Size | 1 or 2 bytes |
+	 *         | File Encryption Key      | arbitrary    |
+	 */
+	data_len = (5 + ECRYPTFS_SIG_SIZE_HEX + crypt_stat->key_size);
+	*packet = kmalloc(data_len, GFP_KERNEL);
+	message = *packet;
+	if (!message) {
+		ecryptfs_printk(KERN_ERR, "Unable to allocate memory\n");
+		rc = -ENOMEM;
+		goto out;
+	}
+	message[i++] = ECRYPTFS_TAG_66_PACKET_TYPE;
+	rc = write_packet_length(&message[i], ECRYPTFS_SIG_SIZE_HEX,
+				 &packet_size_len);
+	if (rc) {
+		ecryptfs_printk(KERN_ERR, "Error generating tag 66 packet "
+				"header; cannot generate packet length\n");
+		goto out;
+	}
+	i += packet_size_len;
+	memcpy(&message[i], signature, ECRYPTFS_SIG_SIZE_HEX);
+	i += ECRYPTFS_SIG_SIZE_HEX;
+	/* The encrypted key includes 1 byte cipher code and 2 byte checksum */
+	rc = write_packet_length(&message[i], crypt_stat->key_size + 3,
+				 &packet_size_len);
+	if (rc) {
+		ecryptfs_printk(KERN_ERR, "Error generating tag 66 packet "
+				"header; cannot generate packet length\n");
+		goto out;
+	}
+	i += packet_size_len;
+	message[i++] = cipher_code;
+	memcpy(&message[i], crypt_stat->key, crypt_stat->key_size);
+	i += crypt_stat->key_size;
+	for (j = 0; j < crypt_stat->key_size; j++)
+		checksum += crypt_stat->key[j];
+	message[i++] = (checksum / 256) % 256;
+	message[i++] = (checksum % 256);
+	*packet_len = i;
+out:
+	return rc;
+}
+
+static int
+parse_tag_67_packet(struct ecryptfs_key_record *key_rec,
+		    struct ecryptfs_message *msg)
+{
+	size_t i = 0;
+	char *data;
+	size_t data_len;
+	size_t message_len;
+	int rc;
+
+	/*
+	 *              ***** TAG 65 Packet Format *****
+	 *    | Content Type                       | 1 byte       |
+	 *    | Status Indicator                   | 1 byte       |
+	 *    | Encrypted File Encryption Key Size | 1 or 2 bytes |
+	 *    | Encrypted File Encryption Key      | arbitrary    |
+	 */
+	message_len = msg->data_len;
+	data = msg->data;
+	/* verify that everything through the encrypted FEK size is present */
+	if (message_len < 4) {
+		rc = -EIO;
+		goto out;
+	}
+	if (data[i++] != ECRYPTFS_TAG_67_PACKET_TYPE) {
+		ecryptfs_printk(KERN_ERR, "Type should be ECRYPTFS_TAG_67\n");
+		rc = -EIO;
+		goto out;
+	}
+	if (data[i++]) {
+		ecryptfs_printk(KERN_ERR, "Status indicator has non zero value"
+				" [%d]\n", data[i-1]);
+		rc = -EIO;
+		goto out;
+	}
+	rc = parse_packet_length(&data[i], &key_rec->enc_key_size, &data_len);
+	if (rc) {
+		ecryptfs_printk(KERN_WARNING, "Error parsing packet length; "
+				"rc = [%d]\n", rc);
+		goto out;
+	}
+	i += data_len;
+	if (message_len < (i + key_rec->enc_key_size)) {
+		ecryptfs_printk(KERN_ERR, "message_len [%d]; max len is [%d]\n",
+				message_len, (i + key_rec->enc_key_size));
+		rc = -EIO;
+		goto out;
+	}
+	if (key_rec->enc_key_size > ECRYPTFS_MAX_ENCRYPTED_KEY_BYTES) {
+		ecryptfs_printk(KERN_ERR, "Encrypted key_size [%d] larger than "
+				"the maximum key size [%d]\n",
+				key_rec->enc_key_size,
+				ECRYPTFS_MAX_ENCRYPTED_KEY_BYTES);
+		rc = -EIO;
+		goto out;
+	}
+	memcpy(key_rec->enc_key, &data[i], key_rec->enc_key_size);
+out:
+	return rc;
+}
+
+/**
+ * decrypt_pki_encrypted_session_key - Decrypt the session key with
+ * the given auth_tok.
+ *
+ * Returns Zero on success; non-zero error otherwise.
+ */
+static int decrypt_pki_encrypted_session_key(
+	struct ecryptfs_mount_crypt_stat *mount_crypt_stat,
+	struct ecryptfs_auth_tok *auth_tok,
+	struct ecryptfs_crypt_stat *crypt_stat)
+{
+	u16 cipher_code = 0;
+	struct ecryptfs_msg_ctx *msg_ctx;
+	struct ecryptfs_message *msg = NULL;
+	char *netlink_message;
+	size_t netlink_message_length;
+	int rc;
+
+	rc = write_tag_64_packet(mount_crypt_stat->global_auth_tok_sig,
+				 &(auth_tok->session_key),
+				 &netlink_message, &netlink_message_length);
+	if (rc) {
+		ecryptfs_printk(KERN_ERR, "Failed to write tag 64 packet");
+		goto out;
+	}
+	rc = ecryptfs_send_message(ecryptfs_transport, netlink_message,
+				   netlink_message_length, &msg_ctx);
+	if (rc) {
+		ecryptfs_printk(KERN_ERR, "Error sending netlink message\n");
+		goto out;
+	}
+	rc = ecryptfs_wait_for_response(msg_ctx, &msg);
+	if (rc) {
+		ecryptfs_printk(KERN_ERR, "Failed to receive tag 65 packet "
+				"from the user space daemon\n");
+		rc = -EIO;
+		goto out;
+	}
+	rc = parse_tag_65_packet(&(auth_tok->session_key),
+				 &cipher_code, msg);
+	if (rc) {
+		printk(KERN_ERR "Failed to parse tag 65 packet; rc = [%d]\n",
+		       rc);
+		goto out;
+	}
+	auth_tok->session_key.flags |= ECRYPTFS_CONTAINS_DECRYPTED_KEY;
+	memcpy(crypt_stat->key, auth_tok->session_key.decrypted_key,
+	       auth_tok->session_key.decrypted_key_size);
+	crypt_stat->key_size = auth_tok->session_key.decrypted_key_size;
+	rc = ecryptfs_cipher_code_to_string(crypt_stat->cipher, cipher_code);
+	if (rc) {
+		ecryptfs_printk(KERN_ERR, "Cipher code [%d] is invalid\n",
+				cipher_code)
+		goto out;
+	}
+	crypt_stat->flags |= ECRYPTFS_KEY_VALID;
+	if (ecryptfs_verbosity > 0) {
+		ecryptfs_printk(KERN_DEBUG, "Decrypted session key:\n");
+		ecryptfs_dump_hex(crypt_stat->key,
+				  crypt_stat->key_size);
+	}
+out:
+	if (msg)
+		kfree(msg);
+	return rc;
+}
+
+static void wipe_auth_tok_list(struct list_head *auth_tok_list_head)
+{
+	struct list_head *walker;
+	struct ecryptfs_auth_tok_list_item *auth_tok_list_item;
+
+	walker = auth_tok_list_head->next;
+	while (walker != auth_tok_list_head) {
+		auth_tok_list_item =
+		    list_entry(walker, struct ecryptfs_auth_tok_list_item,
+			       list);
+		walker = auth_tok_list_item->list.next;
+		memset(auth_tok_list_item, 0,
+		       sizeof(struct ecryptfs_auth_tok_list_item));
+		kmem_cache_free(ecryptfs_auth_tok_list_item_cache,
+				auth_tok_list_item);
+	}
+	auth_tok_list_head->next = NULL;
+}
+
+struct kmem_cache *ecryptfs_auth_tok_list_item_cache;
+
+
+/**
+ * parse_tag_1_packet
+ * @crypt_stat: The cryptographic context to modify based on packet
+ *              contents.
+ * @data: The raw bytes of the packet.
+ * @auth_tok_list: eCryptfs parses packets into authentication tokens;
+ *                 a new authentication token will be placed at the end
+ *                 of this list for this packet.
+ * @new_auth_tok: Pointer to a pointer to memory that this function
+ *                allocates; sets the memory address of the pointer to
+ *                NULL on error. This object is added to the
+ *                auth_tok_list.
+ * @packet_size: This function writes the size of the parsed packet
+ *               into this memory location; zero on error.
+ *
+ * Returns zero on success; non-zero on error.
+ */
+static int
+parse_tag_1_packet(struct ecryptfs_crypt_stat *crypt_stat,
+		   unsigned char *data, struct list_head *auth_tok_list,
+		   struct ecryptfs_auth_tok **new_auth_tok,
+		   size_t *packet_size, size_t max_packet_size)
+{
+	size_t body_size;
+	struct ecryptfs_auth_tok_list_item *auth_tok_list_item;
+	size_t length_size;
+	int rc = 0;
+
+	(*packet_size) = 0;
+	(*new_auth_tok) = NULL;
+
+	/* we check that:
+	 *   one byte for the Tag 1 ID flag
+	 *   two bytes for the body size
+	 * do not exceed the maximum_packet_size
+	 */
+	if (unlikely((*packet_size) + 3 > max_packet_size)) {
+		ecryptfs_printk(KERN_ERR, "Packet size exceeds max\n");
+		rc = -EINVAL;
+		goto out;
+	}
+	/* check for Tag 1 identifier - one byte */
+	if (data[(*packet_size)++] != ECRYPTFS_TAG_1_PACKET_TYPE) {
+		ecryptfs_printk(KERN_ERR, "Enter w/ first byte != 0x%.2x\n",
+				ECRYPTFS_TAG_1_PACKET_TYPE);
+		rc = -EINVAL;
+		goto out;
+	}
+	/* Released: wipe_auth_tok_list called in ecryptfs_parse_packet_set or
+	 * at end of function upon failure */
+	auth_tok_list_item =
+		kmem_cache_alloc(ecryptfs_auth_tok_list_item_cache,
+				 SLAB_KERNEL);
+	if (!auth_tok_list_item) {
+		ecryptfs_printk(KERN_ERR, "Unable to allocate memory\n");
+		rc = -ENOMEM;
+		goto out;
+	}
+	memset(auth_tok_list_item, 0,
+	       sizeof(struct ecryptfs_auth_tok_list_item));
+	(*new_auth_tok) = &auth_tok_list_item->auth_tok;
+	/* check for body size - one to two bytes
+	 *
+	 *              ***** TAG 1 Packet Format *****
+	 *    | version number                     | 1 byte       |
+	 *    | key ID                             | 8 bytes      |
+	 *    | public key algorithm               | 1 byte       |
+	 *    | encrypted session key              | arbitrary    |
+	 */
+	rc = parse_packet_length(&data[(*packet_size)], &body_size,
+				 &length_size);
+	if (rc) {
+		ecryptfs_printk(KERN_WARNING, "Error parsing packet length; "
+				"rc = [%d]\n", rc);
+		goto out_free;
+	}
+	if (unlikely(body_size < (0x02 + ECRYPTFS_SIG_SIZE))) {
+		ecryptfs_printk(KERN_WARNING, "Invalid body size ([%d])\n",
+				body_size);
+		rc = -EINVAL;
+		goto out_free;
+	}
+	(*packet_size) += length_size;
+	if (unlikely((*packet_size) + body_size > max_packet_size)) {
+		ecryptfs_printk(KERN_ERR, "Packet size exceeds max\n");
+		rc = -EINVAL;
+		goto out_free;
+	}
+	/* Version 3 (from RFC2440) - one byte */
+	if (unlikely(data[(*packet_size)++] != 0x03)) {
+		ecryptfs_printk(KERN_DEBUG, "Unknown version number "
+				"[%d]\n", data[(*packet_size) - 1]);
+		rc = -EINVAL;
+		goto out_free;
+	}
+	/* Read Signature */
+	ecryptfs_to_hex((*new_auth_tok)->token.private_key.signature,
+			&data[(*packet_size)], ECRYPTFS_SIG_SIZE);
+	*packet_size += ECRYPTFS_SIG_SIZE;
+	/* This byte is skipped because the kernel does not need to
+	 * know which public key encryption algorithm was used */
+	(*packet_size)++;
+	(*new_auth_tok)->session_key.encrypted_key_size =
+		body_size - (0x02 + ECRYPTFS_SIG_SIZE);
+	if ((*new_auth_tok)->session_key.encrypted_key_size
+	    > ECRYPTFS_MAX_ENCRYPTED_KEY_BYTES) {
+		ecryptfs_printk(KERN_ERR, "Tag 1 packet contains key larger "
+				"than ECRYPTFS_MAX_ENCRYPTED_KEY_BYTES");
+		rc = -EINVAL;
+		goto out;
+	}
+	ecryptfs_printk(KERN_DEBUG, "Encrypted key size = [%d]\n",
+			(*new_auth_tok)->session_key.encrypted_key_size);
+	memcpy((*new_auth_tok)->session_key.encrypted_key,
+	       &data[(*packet_size)], (body_size - 0x02 - ECRYPTFS_SIG_SIZE));
+	(*packet_size) += (*new_auth_tok)->session_key.encrypted_key_size;
+	(*new_auth_tok)->session_key.flags &=
+		~ECRYPTFS_CONTAINS_DECRYPTED_KEY;
+	(*new_auth_tok)->session_key.flags |=
+		ECRYPTFS_CONTAINS_ENCRYPTED_KEY;
+	(*new_auth_tok)->token_type = ECRYPTFS_PRIVATE_KEY;
+	ECRYPTFS_SET_FLAG((*new_auth_tok)->flags, ECRYPTFS_PRIVATE_KEY);
+	/* TODO: Why are we setting this flag here? Don't we want the
+	 * userspace to decrypt the session key? */
+	ECRYPTFS_CLEAR_FLAG((*new_auth_tok)->session_key.flags,
+			    ECRYPTFS_USERSPACE_SHOULD_TRY_TO_DECRYPT);
+	ECRYPTFS_CLEAR_FLAG((*new_auth_tok)->session_key.flags,
+			    ECRYPTFS_USERSPACE_SHOULD_TRY_TO_ENCRYPT);
+	list_add(&auth_tok_list_item->list, auth_tok_list);
+	goto out;
+out_free:
+	(*new_auth_tok) = NULL;
+	memset(auth_tok_list_item, 0,
+	       sizeof(struct ecryptfs_auth_tok_list_item));
+	kmem_cache_free(ecryptfs_auth_tok_list_item_cache,
+			auth_tok_list_item);
+out:
+	if (rc)
+		(*packet_size) = 0;
+	return rc;
+}
+
 /**
  * parse_tag_3_packet
  * @crypt_stat: The cryptographic context to modify based on packet
@@ -178,10 +652,10 @@ parse_tag_3_packet(struct ecryptfs_crypt
 		   struct ecryptfs_auth_tok **new_auth_tok,
 		   size_t *packet_size, size_t max_packet_size)
 {
-	int rc = 0;
 	size_t body_size;
 	struct ecryptfs_auth_tok_list_item *auth_tok_list_item;
 	size_t length_size;
+	int rc = 0;
 
 	(*packet_size) = 0;
 	(*new_auth_tok) = NULL;
@@ -360,9 +834,9 @@ parse_tag_11_packet(unsigned char *data,
 		    size_t max_contents_bytes, size_t *tag_11_contents_size,
 		    size_t *packet_size, size_t max_packet_size)
 {
-	int rc = 0;
 	size_t body_size;
 	size_t length_size;
+	int rc = 0;
 
 	(*packet_size) = 0;
 	(*tag_11_contents_size) = 0;
@@ -461,7 +935,6 @@ static int decrypt_session_key(struct ec
 	struct ecryptfs_password *password_s_ptr;
 	struct scatterlist src_sg[2], dst_sg[2];
 	struct mutex *tfm_mutex = NULL;
-	/* TODO: Use virt_to_scatterlist for these */
 	char *encrypted_session_key;
 	char *session_key;
 	struct blkcipher_desc desc = {
@@ -589,7 +1062,6 @@ int ecryptfs_parse_packet_set(struct ecr
 			      struct dentry *ecryptfs_dentry)
 {
 	size_t i = 0;
-	int rc = 0;
 	size_t found_auth_tok = 0;
 	size_t next_packet_is_auth_tok_packet;
 	char sig[ECRYPTFS_SIG_SIZE_HEX];
@@ -605,6 +1077,7 @@ int ecryptfs_parse_packet_set(struct ecr
 	unsigned char sig_tmp_space[ECRYPTFS_SIG_SIZE];
 	size_t tag_11_contents_size;
 	size_t tag_11_packet_size;
+	int rc = 0;
 
 	INIT_LIST_HEAD(&auth_tok_list);
 	/* Parse the header to find as many packets as we can, these will be
@@ -659,6 +1132,21 @@ int ecryptfs_parse_packet_set(struct ecr
 			ECRYPTFS_SET_FLAG(crypt_stat->flags,
 					  ECRYPTFS_ENCRYPTED);
 			break;
+		case ECRYPTFS_TAG_1_PACKET_TYPE:
+			rc = parse_tag_1_packet(crypt_stat,
+						(unsigned char *)&src[i],
+						&auth_tok_list, &new_auth_tok,
+						&packet_size, max_packet_size);
+			if (rc) {
+				ecryptfs_printk(KERN_ERR, "Error parsing "
+						"tag 1 packet\n");
+				rc = -EIO;
+				goto out_wipe_list;
+			}
+			i += packet_size;
+			ECRYPTFS_SET_FLAG(crypt_stat->flags,
+					  ECRYPTFS_ENCRYPTED);
+			break;
 		case ECRYPTFS_TAG_11_PACKET_TYPE:
 			ecryptfs_printk(KERN_WARNING, "Invalid packet set "
 					"(Tag 11 not allowed by itself)\n");
@@ -706,31 +1194,47 @@ int ecryptfs_parse_packet_set(struct ecr
 			goto leave_list;
 			/* TODO: Transfer the common salt into the
 			 * crypt_stat salt */
+		} else if ((candidate_auth_tok->token_type
+			    == ECRYPTFS_PRIVATE_KEY)
+			   && !strncmp(candidate_auth_tok->token.private_key.signature,
+				     sig, ECRYPTFS_SIG_SIZE_HEX)) {
+			found_auth_tok = 1;
+			goto leave_list;
 		}
 	}
-leave_list:
 	if (!found_auth_tok) {
 		ecryptfs_printk(KERN_ERR, "Could not find authentication "
 				"token on temporary list for sig [%.*s]\n",
 				ECRYPTFS_SIG_SIZE_HEX, sig);
 		rc = -EIO;
 		goto out_wipe_list;
-	} else {
+	}
+leave_list:
+	rc = -ENOTSUPP;
+	if ((ECRYPTFS_CHECK_FLAG(candidate_auth_tok->flags,
+			         ECRYPTFS_PRIVATE_KEY))) {
+		memcpy(&(candidate_auth_tok->token.private_key),
+		       &(chosen_auth_tok->token.private_key),
+		       sizeof(struct ecryptfs_private_key));
+		rc = decrypt_pki_encrypted_session_key(mount_crypt_stat,
+						       candidate_auth_tok,
+						       crypt_stat);
+	} else if (candidate_auth_tok->token_type == ECRYPTFS_PASSWORD) {
 		memcpy(&(candidate_auth_tok->token.password),
 		       &(chosen_auth_tok->token.password),
 		       sizeof(struct ecryptfs_password));
 		rc = decrypt_session_key(candidate_auth_tok, crypt_stat);
-		if (rc) {
-			ecryptfs_printk(KERN_ERR, "Error decrypting the "
-					"session key\n");
-			goto out_wipe_list;
-		}
-		rc = ecryptfs_compute_root_iv(crypt_stat);
-		if (rc) {
-			ecryptfs_printk(KERN_ERR, "Error computing "
-					"the root IV\n");
-			goto out_wipe_list;
-		}
+	}
+	if (rc) {
+		ecryptfs_printk(KERN_ERR, "Error decrypting the "
+				"session key; rc = [%d]\n", rc);
+		goto out_wipe_list;
+	}
+	rc = ecryptfs_compute_root_iv(crypt_stat);
+	if (rc) {
+		ecryptfs_printk(KERN_ERR, "Error computing "
+				"the root IV\n");
+		goto out_wipe_list;
 	}
 	rc = ecryptfs_init_crypt_ctx(crypt_stat);
 	if (rc) {
@@ -743,6 +1247,145 @@ out_wipe_list:
 out:
 	return rc;
 }
+static int
+pki_encrypt_session_key(struct ecryptfs_auth_tok *auth_tok,
+			struct ecryptfs_crypt_stat *crypt_stat,
+			struct ecryptfs_key_record *key_rec)
+{
+	struct ecryptfs_msg_ctx *msg_ctx = NULL;
+	char *netlink_payload;
+	size_t netlink_payload_length;
+	struct ecryptfs_message *msg;
+	int rc;
+
+	rc = write_tag_66_packet(auth_tok->token.private_key.signature,
+				 ecryptfs_code_for_cipher_string(crypt_stat),
+				 crypt_stat, &netlink_payload,
+				 &netlink_payload_length);
+	if (rc) {
+		ecryptfs_printk(KERN_ERR, "Error generating tag 66 packet\n");
+		goto out;
+	}
+	rc = ecryptfs_send_message(ecryptfs_transport, netlink_payload,
+				   netlink_payload_length, &msg_ctx);
+	if (rc) {
+		ecryptfs_printk(KERN_ERR, "Error sending netlink message\n");
+		goto out;
+	}
+	rc = ecryptfs_wait_for_response(msg_ctx, &msg);
+	if (rc) {
+		ecryptfs_printk(KERN_ERR, "Failed to receive tag 67 packet "
+				"from the user space daemon\n");
+		rc = -EIO;
+		goto out;
+	}
+	rc = parse_tag_67_packet(key_rec, msg);
+	if (rc)
+		ecryptfs_printk(KERN_ERR, "Error parsing tag 67 packet\n");
+	kfree(msg);
+out:
+	if (netlink_payload)
+		kfree(netlink_payload);
+	return rc;
+}
+/**
+ * write_tag_1_packet - Write an RFC2440-compatible tag 1 (public key) packet
+ * @dest: Buffer into which to write the packet
+ * @max: Maximum number of bytes that can be writtn
+ * @packet_size: This function will write the number of bytes that end
+ *               up constituting the packet; set to zero on error
+ *
+ * Returns zero on success; non-zero on error.
+ */
+static int
+write_tag_1_packet(char *dest, size_t max, struct ecryptfs_auth_tok *auth_tok,
+		   struct ecryptfs_crypt_stat *crypt_stat,
+		   struct ecryptfs_mount_crypt_stat *mount_crypt_stat,
+		   struct ecryptfs_key_record *key_rec, size_t *packet_size)
+{
+	size_t i;
+	size_t encrypted_session_key_valid = 0;
+	size_t key_rec_size;
+	size_t packet_size_length;
+	int rc = 0;
+
+	(*packet_size) = 0;
+	ecryptfs_from_hex(key_rec->sig, auth_tok->token.private_key.signature,
+			  ECRYPTFS_SIG_SIZE);
+	encrypted_session_key_valid = 0;
+	for (i = 0; i < crypt_stat->key_size; i++)
+		encrypted_session_key_valid |=
+			auth_tok->session_key.encrypted_key[i];
+	if (encrypted_session_key_valid) {
+		memcpy(key_rec->enc_key,
+		       auth_tok->session_key.encrypted_key,
+		       auth_tok->session_key.encrypted_key_size);
+		goto encrypted_session_key_set;
+	}
+	if (auth_tok->session_key.encrypted_key_size == 0)
+		auth_tok->session_key.encrypted_key_size =
+			auth_tok->token.private_key.key_size;
+	rc = pki_encrypt_session_key(auth_tok, crypt_stat, key_rec);
+	if (rc) {
+		ecryptfs_printk(KERN_ERR, "Failed to encrypt session key "
+				"via a pki");
+		goto out;
+	}
+	if (ecryptfs_verbosity > 0) {
+		ecryptfs_printk(KERN_DEBUG, "Encrypted key:\n");
+		ecryptfs_dump_hex(key_rec->enc_key, key_rec->enc_key_size);
+	}
+encrypted_session_key_set:
+	/* Now we have a valid key_rec.  Append it to the
+	 * key_rec set. */
+	key_rec_size = (sizeof(struct ecryptfs_key_record)
+			- ECRYPTFS_MAX_ENCRYPTED_KEY_BYTES
+			+ (key_rec->enc_key_size));
+	/* TODO: Include a packet size limit as a parameter to this
+	 * function once we have multi-packet headers (for versions
+	 * later than 0.1 */
+	if (key_rec_size >= ECRYPTFS_MAX_KEYSET_SIZE) {
+		ecryptfs_printk(KERN_ERR, "Keyset too large\n");
+		rc = -EINVAL;
+		goto out;
+	}
+	/*              ***** TAG 1 Packet Format *****
+	 *    | version number                     | 1 byte       |
+	 *    | key ID                             | 8 bytes      |
+	 *    | public key algorithm               | 1 byte       |
+	 *    | encrypted session key              | arbitrary    |
+	 */
+	if ((0x02 + ECRYPTFS_SIG_SIZE + key_rec->enc_key_size) >= max) {
+		ecryptfs_printk(KERN_ERR,
+				"Authentication token is too large\n");
+		rc = -EINVAL;
+		goto out;
+	}
+	dest[(*packet_size)++] = ECRYPTFS_TAG_1_PACKET_TYPE;
+	/* This format is inspired by OpenPGP; see RFC 2440
+	 * packet tag 1 */
+	rc = write_packet_length(&dest[(*packet_size)],
+				 (0x02 + ECRYPTFS_SIG_SIZE +
+				 key_rec->enc_key_size),
+				 &packet_size_length);
+	if (rc) {
+		ecryptfs_printk(KERN_ERR, "Error generating tag 1 packet "
+				"header; cannot generate packet length\n");
+		goto out;
+	}
+	(*packet_size) += packet_size_length;
+	dest[(*packet_size)++] = 0x03; /* version 3 */
+	memcpy(&dest[(*packet_size)], key_rec->sig, ECRYPTFS_SIG_SIZE);
+	(*packet_size) += ECRYPTFS_SIG_SIZE;
+	dest[(*packet_size)++] = RFC2440_CIPHER_RSA;
+	memcpy(&dest[(*packet_size)], key_rec->enc_key,
+	       key_rec->enc_key_size);
+	(*packet_size) += key_rec->enc_key_size;
+out:
+	if (rc)
+		(*packet_size) = 0;
+	return rc;
+}
 
 /**
  * write_tag_11_packet
@@ -758,8 +1401,8 @@ static int
 write_tag_11_packet(char *dest, int max, char *contents, size_t contents_length,
 		    size_t *packet_length)
 {
-	int rc = 0;
 	size_t packet_size_length;
+	int rc = 0;
 
 	(*packet_length) = 0;
 	if ((13 + contents_length) > max) {
@@ -817,7 +1460,6 @@ write_tag_3_packet(char *dest, size_t ma
 		   struct ecryptfs_key_record *key_rec, size_t *packet_size)
 {
 	size_t i;
-	size_t signature_is_valid = 0;
 	size_t encrypted_session_key_valid = 0;
 	char session_key_encryption_key[ECRYPTFS_MAX_KEY_BYTES];
 	struct scatterlist dest_sg[2];
@@ -833,19 +1475,14 @@ write_tag_3_packet(char *dest, size_t ma
 	int rc = 0;
 
 	(*packet_size) = 0;
-	/* Check for a valid signature on the auth_tok */
-	for (i = 0; i < ECRYPTFS_SIG_SIZE_HEX; i++)
-		signature_is_valid |= auth_tok->token.password.signature[i];
-	if (!signature_is_valid)
-		BUG();
-	ecryptfs_from_hex((*key_rec).sig, auth_tok->token.password.signature,
+	ecryptfs_from_hex(key_rec->sig, auth_tok->token.password.signature,
 			  ECRYPTFS_SIG_SIZE);
 	encrypted_session_key_valid = 0;
 	for (i = 0; i < crypt_stat->key_size; i++)
 		encrypted_session_key_valid |=
 			auth_tok->session_key.encrypted_key[i];
 	if (encrypted_session_key_valid) {
-		memcpy((*key_rec).enc_key,
+		memcpy(key_rec->enc_key,
 		       auth_tok->session_key.encrypted_key,
 		       auth_tok->session_key.encrypted_key_size);
 		goto encrypted_session_key_set;
@@ -858,10 +1495,10 @@ write_tag_3_packet(char *dest, size_t ma
 		memset((crypt_stat->key + 24), 0, 8);
 		auth_tok->session_key.encrypted_key_size = 32;
 	}
-	(*key_rec).enc_key_size =
+	key_rec->enc_key_size =
 		auth_tok->session_key.encrypted_key_size;
-	if (ECRYPTFS_CHECK_FLAG(auth_tok->token.password.flags,
-				ECRYPTFS_SESSION_KEY_ENCRYPTION_KEY_SET)) {
+	if (auth_tok->token.password.flags &
+	    ECRYPTFS_SESSION_KEY_ENCRYPTION_KEY_SET) {
 		ecryptfs_printk(KERN_DEBUG, "Using previously generated "
 				"session key encryption key of size [%d]\n",
 				auth_tok->token.password.
@@ -879,15 +1516,15 @@ write_tag_3_packet(char *dest, size_t ma
 		ecryptfs_dump_hex(session_key_encryption_key, 16);
 	}
 	rc = virt_to_scatterlist(crypt_stat->key,
-				 (*key_rec).enc_key_size, src_sg, 2);
+				 key_rec->enc_key_size, src_sg, 2);
 	if (!rc) {
 		ecryptfs_printk(KERN_ERR, "Error generating scatterlist "
 				"for crypt_stat session key\n");
 		rc = -ENOMEM;
 		goto out;
 	}
-	rc = virt_to_scatterlist((*key_rec).enc_key,
-				 (*key_rec).enc_key_size, dest_sg, 2);
+	rc = virt_to_scatterlist(key_rec->enc_key,
+				 key_rec->enc_key_size, dest_sg, 2);
 	if (!rc) {
 		ecryptfs_printk(KERN_ERR, "Error generating scatterlist "
 				"for crypt_stat encrypted session key\n");
@@ -943,14 +1580,14 @@ write_tag_3_packet(char *dest, size_t ma
 		mutex_unlock(tfm_mutex);
 	ecryptfs_printk(KERN_DEBUG, "This should be the encrypted key:\n");
 	if (ecryptfs_verbosity > 0)
-		ecryptfs_dump_hex((*key_rec).enc_key,
-				  (*key_rec).enc_key_size);
+		ecryptfs_dump_hex(key_rec->enc_key,
+				  key_rec->enc_key_size);
 encrypted_session_key_set:
 	/* Now we have a valid key_rec.  Append it to the
 	 * key_rec set. */
 	key_rec_size = (sizeof(struct ecryptfs_key_record)
 			- ECRYPTFS_MAX_ENCRYPTED_KEY_BYTES
-			+ ((*key_rec).enc_key_size));
+			+ (key_rec->enc_key_size));
 	/* TODO: Include a packet size limit as a parameter to this
 	 * function once we have multi-packet headers (for versions
 	 * later than 0.1 */
@@ -962,7 +1599,7 @@ encrypted_session_key_set:
 	/* TODO: Packet size limit */
 	/* We have 5 bytes of surrounding packet data */
 	if ((0x05 + ECRYPTFS_SALT_SIZE
-	     + (*key_rec).enc_key_size) >= max) {
+	     + key_rec->enc_key_size) >= max) {
 		ecryptfs_printk(KERN_ERR, "Authentication token is too "
 				"large\n");
 		rc = -EINVAL;
@@ -974,7 +1611,7 @@ encrypted_session_key_set:
 	/* ver+cipher+s2k+hash+salt+iter+enc_key */
 	rc = write_packet_length(&dest[(*packet_size)],
 				 (0x05 + ECRYPTFS_SALT_SIZE
-				  + (*key_rec).enc_key_size),
+				  + key_rec->enc_key_size),
 				 &packet_size_length);
 	if (rc) {
 		ecryptfs_printk(KERN_ERR, "Error generating tag 3 packet "
@@ -997,9 +1634,9 @@ encrypted_session_key_set:
 	       ECRYPTFS_SALT_SIZE);
 	(*packet_size) += ECRYPTFS_SALT_SIZE;	/* salt */
 	dest[(*packet_size)++] = 0x60;	/* hash iterations (65536) */
-	memcpy(&dest[(*packet_size)], (*key_rec).enc_key,
-	       (*key_rec).enc_key_size);
-	(*packet_size) += (*key_rec).enc_key_size;
+	memcpy(&dest[(*packet_size)], key_rec->enc_key,
+	       key_rec->enc_key_size);
+	(*packet_size) += key_rec->enc_key_size;
 out:
 	if (desc.tfm && !tfm_mutex)
 		crypto_free_blkcipher(desc.tfm);
@@ -1029,13 +1666,13 @@ ecryptfs_generate_key_packet_set(char *d
 				 struct dentry *ecryptfs_dentry, size_t *len,
 				 size_t max)
 {
-	int rc = 0;
 	struct ecryptfs_auth_tok *auth_tok;
 	struct ecryptfs_mount_crypt_stat *mount_crypt_stat =
 		&ecryptfs_superblock_to_private(
 			ecryptfs_dentry->d_sb)->mount_crypt_stat;
 	size_t written;
 	struct ecryptfs_key_record key_rec;
+	int rc = 0;
 
 	(*len) = 0;
 	if (mount_crypt_stat->global_auth_tok) {
@@ -1062,20 +1699,23 @@ ecryptfs_generate_key_packet_set(char *d
 				goto out;
 			}
 			(*len) += written;
+		} else if (auth_tok->token_type == ECRYPTFS_PRIVATE_KEY) {
+			rc = write_tag_1_packet(dest_base + (*len),
+						max, auth_tok,
+						crypt_stat,mount_crypt_stat,
+						&key_rec, &written);
+			if (rc) {
+				ecryptfs_printk(KERN_WARNING, "Error "
+						"writing tag 1 packet\n");
+				goto out;
+			}
+			(*len) += written;
 		} else {
 			ecryptfs_printk(KERN_WARNING, "Unsupported "
 					"authentication token type\n");
 			rc = -EINVAL;
 			goto out;
 		}
-		if (rc) {
-			ecryptfs_printk(KERN_WARNING, "Error writing "
-					"authentication token packet with sig "
-					"= [%s]\n",
-					mount_crypt_stat->global_auth_tok_sig);
-			rc = -EIO;
-			goto out;
-		}
 	} else
 		BUG();
 	if (likely((max - (*len)) > 0)) {
diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index a3c344b..a3fb7bf 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2004-2006 International Business Machines Corp.
  *   Author(s): Michael A. Halcrow <mahalcro@us.ibm.com>
  *              Michael C. Thompson <mcthomps@us.ibm.com>
+ *              Tyler Hicks <tyhicks@ou.edu>
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
@@ -48,6 +49,43 @@ MODULE_PARM_DESC(ecryptfs_verbosity,
 		 "Initial verbosity level (0 or 1; defaults to "
 		 "0, which is Quiet)");
 
+/**
+ * Module parameter that defines the number of netlink message buffer
+ * elements
+ */
+unsigned int ecryptfs_message_buf_len = ECRYPTFS_DEFAULT_MSG_CTX_ELEMS;
+
+module_param(ecryptfs_message_buf_len, uint, 0);
+MODULE_PARM_DESC(ecryptfs_message_buf_len,
+		 "Number of message buffer elements");
+
+/**
+ * Module parameter that defines the maximum guaranteed amount of time to wait
+ * for a response through netlink.  The actual sleep time will be, more than
+ * likely, a small amount greater than this specified value, but only less if
+ * the netlink message successfully arrives.
+ */
+signed long ecryptfs_message_wait_timeout = ECRYPTFS_MAX_MSG_CTX_TTL / HZ;
+
+module_param(ecryptfs_message_wait_timeout, long, 0);
+MODULE_PARM_DESC(ecryptfs_message_wait_timeout,
+		 "Maximum number of seconds that an operation will "
+		 "sleep while waiting for a message response from "
+		 "userspace");
+
+/**
+ * Module parameter that is an estimate of the maximum number of users
+ * that will be concurrently using eCryptfs. Set this to the right
+ * value to balance performance and memory use.
+ */
+unsigned int ecryptfs_number_of_users = ECRYPTFS_DEFAULT_NUM_USERS;
+
+module_param(ecryptfs_number_of_users, uint, 0);
+MODULE_PARM_DESC(ecryptfs_number_of_users, "An estimate of the number of "
+		 "concurrent users of eCryptfs");
+
+unsigned int ecryptfs_transport = ECRYPTFS_DEFAULT_TRANSPORT;
+
 void __ecryptfs_printk(const char *fmt, ...)
 {
 	va_list args;
@@ -347,9 +385,10 @@ static int ecryptfs_parse_options(struct
 		rc = -EINVAL;
 		goto out;
 	}
-	if (auth_tok->token_type != ECRYPTFS_PASSWORD) {
+	if (auth_tok->token_type != ECRYPTFS_PASSWORD
+	    && auth_tok->token_type != ECRYPTFS_PRIVATE_KEY) {
 		ecryptfs_printk(KERN_ERR, "Invalid auth_tok structure "
-				"returned from key\n");
+				"returned from key query\n");
 		rc = -EINVAL;
 		goto out;
 	}
@@ -798,6 +837,11 @@ static int __init ecryptfs_init(void)
 		ecryptfs_free_kmem_caches();
 		goto out;
 	}
+	rc = ecryptfs_init_messaging(ecryptfs_transport);
+	if (rc) {
+		ecryptfs_printk(KERN_ERR, "Failure occured while attempting to "
+				"initialize the eCryptfs netlink socket\n");
+	}
 out:
 	return rc;
 }
@@ -809,6 +853,7 @@ static void __exit ecryptfs_exit(void)
 	sysfs_remove_file(&ecryptfs_subsys.kset.kobj,
 			  &sysfs_attr_version_str.attr);
 	subsystem_unregister(&ecryptfs_subsys);
+	ecryptfs_release_messaging(ecryptfs_transport);
 	unregister_filesystem(&ecryptfs_fs_type);
 	ecryptfs_free_kmem_caches();
 }
diff --git a/fs/ecryptfs/messaging.c b/fs/ecryptfs/messaging.c
index c22b32f..e8ba627 100644
--- a/fs/ecryptfs/messaging.c
+++ b/fs/ecryptfs/messaging.c
@@ -243,7 +243,8 @@ unlock:
  * userspace. Returns zero upon delivery to desired context element;
  * non-zero upon delivery failure or error.
  */
-int ecryptfs_process_response(struct ecryptfs_message *msg, pid_t pid, u32 seq)
+int ecryptfs_process_response(struct ecryptfs_message *msg, uid_t uid,
+			      pid_t pid, u32 seq)
 {
 	struct ecryptfs_daemon_id *id;
 	struct ecryptfs_msg_ctx *msg_ctx;
@@ -268,6 +269,13 @@ int ecryptfs_process_response(struct ecr
 				msg_ctx->task->euid, pid);
 		goto wake_up;
 	}
+	if (msg_ctx->task->euid != uid) {
+		rc = -EBADMSG;
+		ecryptfs_printk(KERN_WARNING, "Received message from user "
+				"[%d]; expected message from user [%d]\n",
+				uid, msg_ctx->task->euid);
+		goto unlock;
+	}
 	if (id->pid != pid) {
 		rc = -EBADMSG;
 		ecryptfs_printk(KERN_ERR, "User [%d] received a "
diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index 3001189..0af3aa3 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -528,90 +528,6 @@ out:
 	return rc;
 }
 
-static int
-process_new_file(struct ecryptfs_crypt_stat *crypt_stat,
-		 struct file *file, struct inode *inode)
-{
-	struct page *header_page;
-	const struct address_space_operations *lower_a_ops;
-	struct inode *lower_inode;
-	struct file *lower_file;
-	char *header_virt;
-	int rc = 0;
-	int current_header_page = 0;
-	int header_pages;
-	int more_header_data_to_be_written = 1;
-
-	lower_inode = ecryptfs_inode_to_lower(inode);
-	lower_file = ecryptfs_file_to_lower(file);
-	lower_a_ops = lower_inode->i_mapping->a_ops;
-	header_pages = ((crypt_stat->header_extent_size
-			 * crypt_stat->num_header_extents_at_front)
-			/ PAGE_CACHE_SIZE);
-	BUG_ON(header_pages < 1);
-	while (current_header_page < header_pages) {
-		rc = ecryptfs_grab_and_map_lower_page(&header_page,
-						      &header_virt,
-						      lower_inode,
-						      current_header_page);
-		if (rc) {
-			ecryptfs_printk(KERN_ERR, "grab_cache_page for "
-					"header page [%d] failed; rc = [%d]\n",
-					current_header_page, rc);
-			goto out;
-		}
-		rc = lower_a_ops->prepare_write(lower_file, header_page, 0,
-						PAGE_CACHE_SIZE);
-		if (rc) {
-			ecryptfs_printk(KERN_ERR, "Error preparing to write "
-					"header page out; rc = [%d]\n", rc);
-			goto out;
-		}
-		memset(header_virt, 0, PAGE_CACHE_SIZE);
-		if (more_header_data_to_be_written) {
-			rc = ecryptfs_write_headers_virt(header_virt,
-							 crypt_stat,
-							 file->f_path.dentry);
-			if (rc) {
-				ecryptfs_printk(KERN_WARNING, "Error "
-						"generating header; rc = "
-						"[%d]\n", rc);
-				rc = -EIO;
-				memset(header_virt, 0, PAGE_CACHE_SIZE);
-				ecryptfs_unmap_and_release_lower_page(
-					header_page);
-				goto out;
-			}
-			if (current_header_page == 0)
-				memset(header_virt, 0, 8);
-			more_header_data_to_be_written = 0;
-		}
-		rc = lower_a_ops->commit_write(lower_file, header_page, 0,
-					       PAGE_CACHE_SIZE);
-		ecryptfs_unmap_and_release_lower_page(header_page);
-		if (rc < 0) {
-			ecryptfs_printk(KERN_ERR,
-					"Error commiting header page write; "
-					"rc = [%d]\n", rc);
-			break;
-		}
-		current_header_page++;
-	}
-	if (rc >= 0) {
-		rc = 0;
-		ecryptfs_printk(KERN_DEBUG, "lower_inode->i_blocks = "
-				"[0x%.16x]\n", lower_inode->i_blocks);
-		i_size_write(inode, 0);
-		lower_inode->i_mtime = lower_inode->i_ctime = CURRENT_TIME;
-		mark_inode_dirty_sync(inode);
-	}
-	ecryptfs_printk(KERN_DEBUG, "Clearing ECRYPTFS_NEW_FILE flag in "
-			"crypt_stat at memory location [%p]\n", crypt_stat);
-	ECRYPTFS_CLEAR_FLAG(crypt_stat->flags, ECRYPTFS_NEW_FILE);
-out:
-	return rc;
-}
-
 /**
  * ecryptfs_commit_write
  * @file: The eCryptfs file object
@@ -643,12 +559,7 @@ static int ecryptfs_commit_write(struct 
 	if (ECRYPTFS_CHECK_FLAG(crypt_stat->flags, ECRYPTFS_NEW_FILE)) {
 		ecryptfs_printk(KERN_DEBUG, "ECRYPTFS_NEW_FILE flag set in "
 			"crypt_stat at memory location [%p]\n", crypt_stat);
-		rc = process_new_file(crypt_stat, file, inode);
-		if (rc) {
-			ecryptfs_printk(KERN_ERR, "Error processing new "
-					"file; rc = [%d]\n", rc);
-			goto out;
-		}
+		ECRYPTFS_CLEAR_FLAG(crypt_stat->flags, ECRYPTFS_NEW_FILE);
 	} else
 		ecryptfs_printk(KERN_DEBUG, "Not a new file\n");
 	ecryptfs_printk(KERN_DEBUG, "Calling fill_zeros_to_end_of_page"
diff --git a/fs/ecryptfs/netlink.c b/fs/ecryptfs/netlink.c
index aba061d..e3aa225 100644
--- a/fs/ecryptfs/netlink.c
+++ b/fs/ecryptfs/netlink.c
@@ -107,8 +107,8 @@ static int ecryptfs_process_nl_response(
 				"incorrectly specified data length\n");
 		goto out;
 	}
-	rc = ecryptfs_process_response(msg, NETLINK_CREDS(skb)->pid,
-				       nlh->nlmsg_seq);
+	rc = ecryptfs_process_response(msg, NETLINK_CREDS(skb)->uid,
+				       NETLINK_CREDS(skb)->pid, nlh->nlmsg_seq);
 	if (rc)
 		printk(KERN_ERR
 		       "Error processing response message; rc = [%d]\n", rc);
-- 
1.3.3

