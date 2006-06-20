Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbWFTVXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWFTVXr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 17:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbWFTVXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 17:23:47 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:26542 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751135AbWFTVXf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 17:23:35 -0400
In-reply-to: <20060620212134.GB18701@us.ibm.com>
From: Mike Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Mike Halcrow <mhalcrow@us.ibm.com>, Mike Halcrow <mike@halcrow.us>
Subject: [PATCH 5/12] Packet and key management update for variable key size
Message-Id: <E1Fsnh3-00079C-Sm@localhost.localdomain>
Date: Tue, 20 Jun 2006 16:23:29 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Modify packet and session key management code to support different key
sizes.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/keystore.c |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

9d85fe55c87fbfe9476f37078f05c40c1d1319ed
diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index 1a9917d..101773f 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -530,8 +530,6 @@ static int decrypt_session_key(struct ec
 	memcpy(crypt_stat->key, auth_tok->session_key.decrypted_key,
 	       auth_tok->session_key.decrypted_key_size);
 	ECRYPTFS_SET_FLAG(crypt_stat->flags, ECRYPTFS_KEY_VALID);
-	crypt_stat->key_size_bits =
-	    auth_tok->session_key.decrypted_key_size * 8;
 	ecryptfs_printk(KERN_DEBUG, "Decrypted session key:\n");
 	if (ecryptfs_verbosity > 0)
 		ecryptfs_dump_hex(crypt_stat->key,
@@ -810,11 +808,10 @@ write_tag_3_packet(char *dest, int max, 
 		BUG();
 	ecryptfs_from_hex((*key_rec).sig, auth_tok->token.password.signature,
 			  ECRYPTFS_SIG_SIZE);
-	(*key_rec).enc_key_size_bits = crypt_stat->key_size_bits;
 	encrypted_session_key_valid = 0;
 	for (i = 0; i < (crypt_stat->key_size_bits / 8); i++)
 		encrypted_session_key_valid |=
-		    auth_tok->session_key.encrypted_key[i];
+			auth_tok->session_key.encrypted_key[i];
 	if (encrypted_session_key_valid) {
 		memcpy((*key_rec).enc_key,
 		       auth_tok->session_key.encrypted_key,
@@ -824,6 +821,13 @@ write_tag_3_packet(char *dest, int max, 
 	if (auth_tok->session_key.encrypted_key_size == 0)
 		auth_tok->session_key.encrypted_key_size =
 			(crypt_stat->key_size_bits / 8);
+	if (crypt_stat->key_size_bits == 192
+	    && strcmp("aes", crypt_stat->cipher) == 0) {
+		memset((crypt_stat->key + 24), 0, 8);
+		auth_tok->session_key.encrypted_key_size = 32;
+	}
+	(*key_rec).enc_key_size_bits =
+		auth_tok->session_key.encrypted_key_size << 3;
 	if (ECRYPTFS_CHECK_FLAG(auth_tok->token.password.flags,
 				ECRYPTFS_SESSION_KEY_ENCRYPTION_KEY_SET)) {
 		ecryptfs_printk(KERN_DEBUG, "Using previously generated "
@@ -839,14 +843,11 @@ write_tag_3_packet(char *dest, int max, 
 			ecryptfs_dump_hex(session_key_encryption_key, 16);
 	}
 	if (unlikely(ecryptfs_verbosity > 0)) {
-		ecryptfs_printk(KERN_DEBUG, "Session key encryption key:"
-				"\n");
+		ecryptfs_printk(KERN_DEBUG, "Session key encryption key:\n");
 		ecryptfs_dump_hex(session_key_encryption_key, 16);
 	}
-	/* Encrypt the key with the key encryption key */
-	/* Set up the scatterlists */
 	rc = virt_to_scatterlist(crypt_stat->key,
-				 crypt_stat->key_size_bits / 8, src_sg, 2);
+				 (*key_rec).enc_key_size_bits / 8, src_sg, 2);
 	if (!rc) {
 		ecryptfs_printk(KERN_ERR, "Error generating scatterlist "
 				"for crypt_stat session key\n");
@@ -879,7 +880,7 @@ write_tag_3_packet(char *dest, int max, 
 	ecryptfs_printk(KERN_DEBUG, "Encrypting [%d] bytes of the key\n",
 			crypt_stat->key_size_bits / 8);
 	crypto_cipher_encrypt(tfm, dest_sg, src_sg,
-			      (crypt_stat->key_size_bits / 8));
+			      (*key_rec).enc_key_size_bits / 8);
 	ecryptfs_printk(KERN_DEBUG, "This should be the encrypted key:\n");
 	if (ecryptfs_verbosity > 0)
 		ecryptfs_dump_hex((*key_rec).enc_key,
-- 
1.3.3

