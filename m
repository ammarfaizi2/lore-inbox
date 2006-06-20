Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbWFTVXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbWFTVXH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 17:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWFTVXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 17:23:06 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:50579 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751087AbWFTVXE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 17:23:04 -0400
In-reply-to: <20060620212134.GB18701@us.ibm.com>
From: Mike Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Mike Halcrow <mhalcrow@us.ibm.com>, Mike Halcrow <mike@halcrow.us>
Subject: [PATCH 2/12] Support for larger maximum key size
Message-Id: <E1FsngZ-00078k-Jc@localhost.localdomain>
Date: Tue, 20 Jun 2006 16:22:59 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Support for larger maximum key size. Necessary for future patches that
will enable cipher selection and keysize specification. Increments the
version number because ECRYPTFS_MAX_KEY_BYTES changes, which changes a
struct that is accessed in both userspace and kernel space.

Note that with this patch, users must upgrade their userspace utility
package to one prefixed ``ecryptfs-util-git-2.6.17-rc6-mm2++'' or
higher (see the eCryptfs SourceForge page for userspace utilities).

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/ecryptfs_kernel.h |    4 ++--
 fs/ecryptfs/keystore.c        |   34 ++++++++++++++++++----------------
 2 files changed, 20 insertions(+), 18 deletions(-)

d13ab4035bb6c56bfb7d82523069324523e99f62
diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index 8e35dbd..1fd6039 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -32,7 +32,7 @@ #include <linux/scatterlist.h>
 
 /* Version verification for shared data structures w/ userspace */
 #define ECRYPTFS_VERSION_MAJOR 0x00
-#define ECRYPTFS_VERSION_MINOR 0x01
+#define ECRYPTFS_VERSION_MINOR 0x02
 #define ECRYPTFS_SUPPORTED_FILE_VERSION 0x01
 
 #define ECRYPTFS_MAX_PASSWORD_LENGTH 64
@@ -45,7 +45,7 @@ #define ECRYPTFS_SALT_SIZE_HEX (ECRYPTFS
 #define ECRYPTFS_SIG_SIZE 8
 #define ECRYPTFS_SIG_SIZE_HEX (ECRYPTFS_SIG_SIZE*2)
 #define ECRYPTFS_PASSWORD_SIG_SIZE ECRYPTFS_SIG_SIZE_HEX
-#define ECRYPTFS_MAX_KEY_BYTES 16
+#define ECRYPTFS_MAX_KEY_BYTES 64
 #define ECRYPTFS_MAX_ENCRYPTED_KEY_BYTES 512
 #define ECRYPTFS_DEFAULT_IV_BYTES 16
 #define ECRYPTFS_FILE_VERSION 0x01
diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index c250888..a83914c 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -486,8 +486,17 @@ static int decrypt_session_key(struct ec
 		rc = -ENOMEM;
 		goto out;
 	}
+	if (password_s_ptr->session_key_encryption_key_bytes
+	    < crypto_tfm_alg_min_keysize(tfm)) {
+		printk(KERN_WARNING "Session key encryption key is [%d] bytes; "
+		       "minimum keysize for selected cipher is [%d] bytes.\n",
+		       password_s_ptr->session_key_encryption_key_bytes,
+		       crypto_tfm_alg_min_keysize(tfm));
+		rc = -EINVAL;
+		goto out;
+	}
 	crypto_cipher_setkey(tfm, password_s_ptr->session_key_encryption_key,
-			     password_s_ptr->session_key_encryption_key_bytes);
+			     (crypt_stat->key_size_bits / 8));
 	/* TODO: virt_to_scatterlist */
 	encrypted_session_key = (char *)__get_free_page(GFP_KERNEL);
 	if (!encrypted_session_key) {
@@ -806,24 +815,18 @@ write_tag_3_packet(char *dest, int max, 
 			  ECRYPTFS_SIG_SIZE);
 	(*key_rec).enc_key_size_bits = crypt_stat->key_size_bits;
 	encrypted_session_key_valid = 0;
-	if (auth_tok->session_key.encrypted_key_size == 0)
-		auth_tok->session_key.encrypted_key_size =
-		    ECRYPTFS_MAX_ENCRYPTED_KEY_BYTES;
-	for (i = 0; i < auth_tok->session_key.encrypted_key_size; i++)
+	for (i = 0; i < (crypt_stat->key_size_bits / 8); i++)
 		encrypted_session_key_valid |=
 		    auth_tok->session_key.encrypted_key[i];
-	if (auth_tok->session_key.encrypted_key_size == 0) {
-		ecryptfs_printk(KERN_WARNING, "auth_tok->session_key."
-				"encrypted_key_size == 0");
-		auth_tok->session_key.encrypted_key_size =
-		    ECRYPTFS_DEFAULT_KEY_BYTES;
-	}
 	if (encrypted_session_key_valid) {
 		memcpy((*key_rec).enc_key,
 		       auth_tok->session_key.encrypted_key,
 		       auth_tok->session_key.encrypted_key_size);
 		goto encrypted_session_key_set;
 	}
+	if (auth_tok->session_key.encrypted_key_size == 0)
+		auth_tok->session_key.encrypted_key_size =
+			(crypt_stat->key_size_bits / 8);
 	if (ECRYPTFS_CHECK_FLAG(auth_tok->token.password.flags,
 				ECRYPTFS_SESSION_KEY_ENCRYPTION_KEY_SET)) {
 		ecryptfs_printk(KERN_DEBUG, "Using previously generated "
@@ -832,8 +835,7 @@ write_tag_3_packet(char *dest, int max, 
 				session_key_encryption_key_bytes);
 		memcpy(session_key_encryption_key,
 		       auth_tok->token.password.session_key_encryption_key,
-		       auth_tok->token.password.
-		       session_key_encryption_key_bytes);
+		       (crypt_stat->key_size_bits / 8));
 		ecryptfs_printk(KERN_DEBUG,
 				"Cached session key " "encryption key: \n");
 		if (ecryptfs_verbosity > 0)
@@ -870,7 +872,7 @@ write_tag_3_packet(char *dest, int max, 
 		goto out;
 	}
 	rc = crypto_cipher_setkey(tfm, session_key_encryption_key,
-				  ECRYPTFS_DEFAULT_KEY_BYTES);
+				  (crypt_stat->key_size_bits / 8));
 	if (rc < 0) {
 		ecryptfs_printk(KERN_ERR, "Error setting key for crypto "
 				"context\n");
@@ -880,7 +882,7 @@ write_tag_3_packet(char *dest, int max, 
 	ecryptfs_printk(KERN_DEBUG, "Encrypting [%d] bytes of the key\n",
 			crypt_stat->key_size_bits / 8);
 	crypto_cipher_encrypt(tfm, dest_sg, src_sg,
-			      crypt_stat->key_size_bits / 8);
+			      (crypt_stat->key_size_bits / 8));
 	ecryptfs_printk(KERN_DEBUG, "This should be the encrypted key:\n");
 	if (ecryptfs_verbosity > 0)
 		ecryptfs_dump_hex((*key_rec).enc_key,
@@ -889,7 +891,7 @@ encrypted_session_key_set:
 	/* Now we have a valid key_rec.  Append it to the
 	 * key_rec set. */
 	key_rec_size = (sizeof(struct ecryptfs_key_record)
-			- ECRYPTFS_MAX_KEY_BYTES
+			- ECRYPTFS_MAX_ENCRYPTED_KEY_BYTES
 			+ ((*key_rec).enc_key_size_bits / 8) );
 	/* TODO: Include a packet size limit as a parameter to this
 	 * function once we have multi-packet headers (for versions
-- 
1.3.3

