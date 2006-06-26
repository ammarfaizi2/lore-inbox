Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933134AbWFZXrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933134AbWFZXrx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933132AbWFZXrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:47:52 -0400
Received: from mail.sdi-muenchen.de ([62.245.203.250]:11769 "EHLO
	linux.sdi-muenchen.de") by vger.kernel.org with ESMTP
	id S933134AbWFZXrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 19:47:49 -0400
From: Stephan =?iso-8859-1?q?M=FCller?= <smueller@chronox.de>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH 03/06] ecryptfs: Validate packet length prior to parsing, add comments
Date: Tue, 27 Jun 2006 01:47:41 +0200
User-Agent: KMail/1.9.1
Cc: Michael Halcrow <mhalcrow@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606270147.42167.smueller@chronox.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel version: 2.6.17-mm1

The parsing of the encrypted file's meta data page is done byte by byte. 
The current implementation checks after each read byte whether it is still 
in the allowed range to be read. The patch changes that in the sense that:

- the check is done before the actual byte is read

- the number of checks is reduced as the format that we read is fix to make 
the code more readable and better maintainable

Two blocks are expected in the meta data page: Tag 3 and Tag 11. The 
following formats are being considered:

Tag 3:
one byte for the Tag 3 ID flag
two bytes for the body size
five fix bytes for: version string, cipher, S2K ID, hash algo,
  number of hash iterations
ECRYPTFS_SALT_SIZE bytes for salt
body_size bytes minus ECRYPTFS_SALT_SIZE  minus 5 is the encrypted key size

Tag 11:
one byte for the Tag 11 ID flag
two bytes for the Tag 11 length
14 bytes for: special flag one, special flag two, 12 skipped bytes
body_size bytes minus 14 bytes is the Tag 11 content

In addition, the patch:

- makes some branches unlikely()

- implicitly fixes two memory leaks as goto out instead of goto out_free 
were was used


Signed-off-by: Stephan Mueller <smueller@chronox.de>

---

 fs/ecryptfs/keystore.c |  160 
+++++++++++++++++++++++-------------------------
 1 files changed, 77 insertions(+), 83 deletions(-)

5998eeade839d6d4ee0c11ed01b95835a9a8378a
diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index 9b98fac..efcf00a 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -180,19 +180,27 @@ parse_tag_3_packet(struct ecryptfs_crypt
 	struct ecryptfs_auth_tok_list_item *auth_tok_list_item;
 	int length_size;
 
+	/* we check that:
+	 *   one byte for the Tag 3 ID flag
+	 *   two bytes for the body size
+	 * do not exceed the maximum_packet_size
+	 */
+	if (unlikely((*packet_size) + 3 > max_packet_size)) {
+		ecryptfs_printk(KERN_ERR, "Packet size exceeds max\n");
+		rc = -EINVAL;
+		goto out;
+	}
+
 	(*packet_size) = 0;
 	(*new_auth_tok) = NULL;
+
+	/* check for Tag 3 identifyer - one byte */
 	if (data[(*packet_size)++] != ECRYPTFS_TAG_3_PACKET_TYPE) {
 		ecryptfs_printk(KERN_ERR, "Enter w/ first byte != 0x%.2x\n",
 				ECRYPTFS_TAG_3_PACKET_TYPE);
 		rc = -EINVAL;
 		goto out;
 	}
-	if (unlikely((*packet_size) > max_packet_size)) {
-		ecryptfs_printk(KERN_ERR, "Packet size exceeds max\n");
-		rc = -EINVAL;
-		goto out;
-	}
 	/* Released: wipe_auth_tok_list called in ecryptfs_parse_packet_set or
 	 * at end of function upon failure */
 	auth_tok_list_item =
@@ -205,6 +213,8 @@ parse_tag_3_packet(struct ecryptfs_crypt
 	memset(auth_tok_list_item, 0,
 	       sizeof(struct ecryptfs_auth_tok_list_item));
 	(*new_auth_tok) = &auth_tok_list_item->auth_tok;
+
+	/* check for body size - one to two bytes */
 	rc = parse_packet_length(&data[(*packet_size)], &body_size,
 				 &length_size);
 	if (rc) {
@@ -212,36 +222,42 @@ parse_tag_3_packet(struct ecryptfs_crypt
 				"rc = [%d]\n", rc);
 		goto out_free;
 	}
-	if (body_size < (0x05 + ECRYPTFS_SALT_SIZE)) {
+	if (unlikely(body_size < (0x05 + ECRYPTFS_SALT_SIZE))) {
 		ecryptfs_printk(KERN_WARNING, "Invalid body size ([%d])\n",
 				body_size);
 		rc = -EINVAL;
 		goto out_free;
 	}
 	(*packet_size) += length_size;
-	if (unlikely((*packet_size) > max_packet_size)) {
+
+	/* now we know the length of the remainting Tag 3 packet size:
+	 *   5 fix bytes for: version string, cipher, S2K ID, hash algo,
+	 *                    number of hash iterations
+	 *   ECRYPTFS_SALT_SIZE bytes for salt
+	 *   body_size bytes minus the stuff above is the encrypted key size
+	 */
+	if (unlikely((*packet_size) + body_size > max_packet_size)) {
 		ecryptfs_printk(KERN_ERR, "Packet size exceeds max\n");
 		rc = -EINVAL;
 		goto out_free;
 	}
+
 	/* There are 5 characters of additional information in the
 	 * packet */
 	(*new_auth_tok)->session_key.encrypted_key_size =
 		body_size - (0x05 + ECRYPTFS_SALT_SIZE);
 	ecryptfs_printk(KERN_DEBUG, "Encrypted key size = [%d]\n",
 			(*new_auth_tok)->session_key.encrypted_key_size);
-	/* Version 4 (from RFC2440) */
-	if (data[(*packet_size)++] != 0x04) {
+
+	/* Version 4 (from RFC2440) - one byte */
+	if (unlikely(data[(*packet_size)++] != 0x04)) {
 		ecryptfs_printk(KERN_DEBUG, "Unknown version number "
 				"[%d]\n", data[(*packet_size) - 1]);
 		rc = -EINVAL;
 		goto out_free;
 	}
-	if (unlikely((*packet_size) > max_packet_size)) {
-		ecryptfs_printk(KERN_ERR, "Packet size exceeds max\n");
-		rc = -EINVAL;
-		goto out;
-	}
+
+	/* cipher - one byte */
 	ecryptfs_cipher_code_to_string(crypt_stat->cipher,
 				       (u16)data[(*packet_size)]);
 	/* A little extra work to differentiate among the AES key
@@ -254,59 +270,39 @@ parse_tag_3_packet(struct ecryptfs_crypt
 		crypt_stat->key_size =
 			(*new_auth_tok)->session_key.encrypted_key_size;
 	}
-	if (unlikely((*packet_size) > max_packet_size)) {
-		ecryptfs_printk(KERN_ERR, "Packet size exceeds max\n");
-		rc = -EINVAL;
-		goto out_free;
-	}
 	ecryptfs_init_crypt_ctx(crypt_stat);
 	/* S2K identifier 3 (from RFC2440) */
-	if (data[(*packet_size)++] != 0x03) {
+	if (unlikely(data[(*packet_size)++] != 0x03)) {
 		ecryptfs_printk(KERN_ERR, "Only S2K ID 3 is currently "
 				"supported\n");
 		rc = -ENOSYS;
 		goto out_free;
 	}
-	if (unlikely((*packet_size) > max_packet_size)) {
-		ecryptfs_printk(KERN_ERR, "Packet size exceeds max\n");
-		rc = -EINVAL;
-		goto out_free;
-	}
+
 	/* TODO: finish the hash mapping */
+	/* hash algorithm - one byte */
 	switch (data[(*packet_size)++]) {
 	case 0x01: /* See RFC2440 for these numbers and their mappings */
 		/* Choose MD5 */
+		/* salt - ECRYPTFS_SALT_SIZE bytes */
 		memcpy((*new_auth_tok)->token.password.salt,
 		       &data[(*packet_size)], ECRYPTFS_SALT_SIZE);
 		(*packet_size) += ECRYPTFS_SALT_SIZE;
-		if (unlikely((*packet_size) > max_packet_size)) {
-			ecryptfs_printk(KERN_ERR,
-					"Packet size exceeds max\n");
-			rc = -EINVAL;
-			goto out_free;
-		}
+
 		/* This conversion was taken straight from RFC2440 */
+		/* number of hash iterations - one byte */
 		(*new_auth_tok)->token.password.hash_iterations =
 			((u32) 16 + (data[(*packet_size)] & 15))
 				<< ((data[(*packet_size)] >> 4) + 6);
 		(*packet_size)++;
-		if (unlikely((*packet_size) > max_packet_size)) {
-			ecryptfs_printk(KERN_ERR,
-					"Packet size exceeds max\n");
-			rc = -EINVAL;
-			goto out_free;
-		}
+
+		/* encrypted session key - 
+		 *   (body_size-5-ECRYPTFS_SALT_SIZE) bytes */
 		memcpy((*new_auth_tok)->session_key.encrypted_key,
 		       &data[(*packet_size)],
 		       (*new_auth_tok)->session_key.encrypted_key_size);
 		(*packet_size) +=
 			(*new_auth_tok)->session_key.encrypted_key_size;
-		if (unlikely((*packet_size) > max_packet_size)) {
-			ecryptfs_printk(KERN_ERR,
-					"Packet size exceeds max\n");
-			rc = -EINVAL;
-			goto out_free;
-		}
 		(*new_auth_tok)->session_key.flags &=
 			~ECRYPTFS_CONTAINS_DECRYPTED_KEY;
 		(*new_auth_tok)->session_key.flags |=
@@ -319,11 +315,6 @@ parse_tag_3_packet(struct ecryptfs_crypt
 		rc = -ENOSYS;
 		goto out_free;
 	}
-	if (unlikely((*packet_size) > max_packet_size)) {
-		ecryptfs_printk(KERN_ERR, "Packet size exceeds max\n");
-		rc = -EINVAL;
-		goto out;
-	}
 	/* TODO: Use the keyring */
 	(*new_auth_tok)->uid = current->uid;
 	ECRYPTFS_SET_FLAG((*new_auth_tok)->flags, ECRYPTFS_PASSWORD);
@@ -373,17 +364,27 @@ parse_tag_11_packet(unsigned char *data,
 
 	(*packet_size) = 0;
 	(*tag_11_contents_size) = 0;
-	if (data[(*packet_size)++] != ECRYPTFS_TAG_11_PACKET_TYPE) {
-		ecryptfs_printk(KERN_WARNING,
-				"Invalid tag 11 packet format\n");
+
+	/* check that:
+	 *   one byte for the Tag 11 ID flag
+	 *   two bytes for the Tag 11 length
+	 * do not exceed the maximum_packet_size
+	 */
+	if (unlikely((*packet_size) + 3 > max_packet_size)) {
+		ecryptfs_printk(KERN_ERR, "Packet size exceeds max\n");
 		rc = -EINVAL;
 		goto out;
 	}
-	if (unlikely((*packet_size) > max_packet_size)) {
-		ecryptfs_printk(KERN_ERR, "Packet size exceeds max\n");
+
+	/* check for Tag 11 identifyer - one byte */
+	if (data[(*packet_size)++] != ECRYPTFS_TAG_11_PACKET_TYPE) {
+		ecryptfs_printk(KERN_WARNING,
+				"Invalid tag 11 packet format\n");
 		rc = -EINVAL;
 		goto out;
 	}
+
+	/* get Tag 11 content length - one or two bytes */
 	rc = parse_packet_length(&data[(*packet_size)], &body_size,
 				 &length_size);
 	if (rc) {
@@ -392,11 +393,7 @@ parse_tag_11_packet(unsigned char *data,
 		goto out;
 	}
 	(*packet_size) += length_size;
-	if (unlikely((*packet_size) > max_packet_size)) {
-		ecryptfs_printk(KERN_ERR, "Packet size exceeds max\n");
-		rc = -EINVAL;
-		goto out;
-	}
+
 	if (body_size < 13) {
 		ecryptfs_printk(KERN_WARNING, "Invalid body size ([%d])\n",
 				body_size);
@@ -405,47 +402,44 @@ parse_tag_11_packet(unsigned char *data,
 	}
 	/* We have 13 bytes of surrounding packet values */
 	(*tag_11_contents_size) = (body_size - 13);
-	if ((*tag_11_contents_size) > max_contents_bytes) {
-		rc = -ENOMEM;
-		ecryptfs_printk(KERN_WARNING, "Not enough space allocated "
-				"in contents to copy entire contents of tag 11 "
-				"packet\n");
+
+	/* now we know the length of the remainting Tag 11 packet size:
+	 *   14 fix bytes for: special flag one, special flag two,
+	 *   		       12 skipped bytes
+	 *   body_size bytes minus the stuff above is the Tag 11 content
+	 */
+	/* FIXME why is the body size one byte smaller than the actual
+	 * size of the body?
+	 * this seems to be an error here as well as in 
+	 * write_tag_11_packet() */
+	if (unlikely((*packet_size) + body_size + 1 > max_packet_size)) {
+		ecryptfs_printk(KERN_ERR, "Packet size exceeds max\n");
+		rc = -EINVAL;
 		goto out;
 	}
+
+	/* special flag one - one byte */
 	if (data[(*packet_size)++] != 0x62) {
 		ecryptfs_printk(KERN_WARNING, "Unrecognizable packet\n");
 		rc = -EINVAL;
 		goto out;
 	}
-	if (unlikely((*packet_size) > max_packet_size)) {
-		ecryptfs_printk(KERN_ERR, "Packet size exceeds max\n");
-		rc = -EINVAL;
-		goto out;
-	}
+
+	/* special flag two - one byte */
 	if (data[(*packet_size)++] != 0x08) {
 		ecryptfs_printk(KERN_WARNING, "Unrecognizable packet\n");
 		rc = -EINVAL;
 		goto out;
 	}
-	if (unlikely((*packet_size) > max_packet_size)) {
-		ecryptfs_printk(KERN_ERR, "Packet size exceeds max\n");
-		rc = -EINVAL;
-		goto out;
-	}
+
+	/* skip the next 12 bytes */
 	(*packet_size) += 12; /* We don't care about the filename or
 			       * the timestamp */
-	if (unlikely((*packet_size) > max_packet_size)) {
-		ecryptfs_printk(KERN_ERR, "Packet size exceeds max\n");
-		rc = -EINVAL;
-		goto out;
-	}
+
+	/* get the Tag 11 contents - tag_11_contents_size bytes */
 	memcpy(contents, &data[(*packet_size)], (*tag_11_contents_size));
 	(*packet_size) += (*tag_11_contents_size);
-	if (unlikely((*packet_size) > max_packet_size)) {
-		ecryptfs_printk(KERN_ERR, "Packet size exceeds max\n");
-		rc = -EINVAL;
-		goto out;
-	}
+
 out:
 	if (rc) {
 		(*packet_size) = 0;
