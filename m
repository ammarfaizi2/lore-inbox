Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751183AbWFTVYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbWFTVYo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 17:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbWFTVYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 17:24:41 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:15774 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751183AbWFTVYi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 17:24:38 -0400
In-reply-to: <20060620212134.GB18701@us.ibm.com>
From: Mike Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Mike Halcrow <mhalcrow@us.ibm.com>, Mike Halcrow <mike@halcrow.us>
Subject: [PATCH 11/12] More elegant AES key size manipulation
Message-Id: <E1Fsni2-0007AX-1m@localhost.localdomain>
Date: Tue, 20 Jun 2006 16:24:30 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move logic to deal with AES special cases into the function that
performs string to cipher code mapping.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/crypto.c          |   35 +++++++++++++++++++++++++++--------
 fs/ecryptfs/ecryptfs_kernel.h |    2 +-
 fs/ecryptfs/keystore.c        |   21 +--------------------
 3 files changed, 29 insertions(+), 29 deletions(-)

340ac69819b8ff314c0b2f7d3d648d3535fd8135
diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index ab47899..5727753 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -1042,16 +1042,35 @@ ecryptfs_cipher_code_str_map[] = {
  *
  * Returns zero on no match, or the cipher code on match
  */
-u16 ecryptfs_code_for_cipher_string(char *str)
+u16 ecryptfs_code_for_cipher_string(struct ecryptfs_crypt_stat *crypt_stat)
 {
 	int i;
-
-	for (i = 0; i < (sizeof(ecryptfs_cipher_code_str_map)
-			 / sizeof(struct ecryptfs_cipher_code_str_map_elem));
-	     i++)
-		if (strcmp(str, ecryptfs_cipher_code_str_map[i].cipher_str)==0)
-			return ecryptfs_cipher_code_str_map[i].cipher_code;
-	return 0;
+	u16 code = 0;
+	struct ecryptfs_cipher_code_str_map_elem *map =
+		ecryptfs_cipher_code_str_map;
+
+	if (strcmp(crypt_stat->cipher, "aes") == 0)
+		switch (crypt_stat->key_size) {
+		case 16:
+			code = RFC2440_CIPHER_AES_128;
+			break;
+		case 24:
+			code = RFC2440_CIPHER_AES_192;
+			break;
+		case 32:
+			code = RFC2440_CIPHER_AES_256;
+		}
+	else
+		for (i = 0; i < (sizeof(ecryptfs_cipher_code_str_map)
+				 / sizeof(struct
+					  ecryptfs_cipher_code_str_map_elem));
+		     i++)
+			if (strcmp(crypt_stat->cipher, map[i].cipher_str)
+			    == 0) {
+				code = map[i].cipher_code;
+				break;
+			}
+	return code;
 }
 
 /**
diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index cc88dc5..d0b9151 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -454,7 +454,7 @@ int ecryptfs_new_file_context(struct den
 int contains_ecryptfs_marker(char *data);
 int ecryptfs_read_header_region(char *data, struct dentry *dentry,
 				struct nameidata *nd);
-u16 ecryptfs_code_for_cipher_string(char *str);
+u16 ecryptfs_code_for_cipher_string(struct ecryptfs_crypt_stat *crypt_stat);
 int ecryptfs_cipher_code_to_string(char *str, u16 cipher_code);
 void ecryptfs_set_default_sizes(struct ecryptfs_crypt_stat *crypt_stat);
 int ecryptfs_generate_key_packet_set(char *dest_base,
diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index 37fa03b..09a56f3 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -923,32 +923,13 @@ encrypted_session_key_set:
 	}
 	(*packet_size) += packet_size_length;
 	dest[(*packet_size)++] = 0x04; /* version 4 */
-	cipher_code = ecryptfs_code_for_cipher_string(crypt_stat->cipher);
+	cipher_code = ecryptfs_code_for_cipher_string(crypt_stat);
 	if (cipher_code == 0) {
 		ecryptfs_printk(KERN_WARNING, "Unable to generate code for "
 				"cipher [%s]\n", crypt_stat->cipher);
 		rc = -EINVAL;
 		goto out;
 	}
-	/* If it is AES, we need to get more specific. */
-	if (cipher_code == RFC2440_CIPHER_AES_128){
-		switch (crypt_stat->key_size) {
-		case 16:
-			break;
-		case 24:
-			cipher_code = RFC2440_CIPHER_AES_192;
-			break;
-		case 32:
-			cipher_code = RFC2440_CIPHER_AES_256;
-			break;
-		default:
-			rc = -EINVAL;
-			ecryptfs_printk(KERN_WARNING, "Unsupported AES key "
-					"size: [%d]\n",
-					crypt_stat->key_size);
-			goto out;
-		}
-	}
 	dest[(*packet_size)++] = cipher_code;
 	dest[(*packet_size)++] = 0x03;	/* S2K */
 	dest[(*packet_size)++] = 0x01;	/* MD5 (TODO: parameterize) */
-- 
1.3.3

