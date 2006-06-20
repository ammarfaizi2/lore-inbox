Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751164AbWFTV1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbWFTV1X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 17:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWFTVX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 17:23:59 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:31363 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751136AbWFTVXz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 17:23:55 -0400
In-reply-to: <20060620212134.GB18701@us.ibm.com>
From: Mike Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Mike Halcrow <mhalcrow@us.ibm.com>, Mike Halcrow <mike@halcrow.us>
Subject: [PATCH 7/12] Set the key size from the default for the mount
Message-Id: <E1FsnhN-00079U-Uc@localhost.localdomain>
Date: Tue, 20 Jun 2006 16:23:49 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the hard-coded key size and use the one specified through the
mount parameter.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/crypto.c |   34 +++++++++++++++++++++-------------
 1 files changed, 21 insertions(+), 13 deletions(-)

1c89f303eaa145c890c10369fa8a6835fbf0fbd8
diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index c278c20..966426d 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -730,8 +730,10 @@ int ecryptfs_init_crypt_ctx(struct ecryp
 		goto out;
 	}
 	ecryptfs_printk(KERN_DEBUG,
-			"Initializing cipher [%s]; strlen = [%d]\n",
-			crypt_stat->cipher, (int)strlen(crypt_stat->cipher));
+			"Initializing cipher [%s]; strlen = [%d]; "
+			"key_size_bits = [%d]\n",
+			crypt_stat->cipher, (int)strlen(crypt_stat->cipher),
+			crypt_stat->key_size_bits);
 	if (crypt_stat->tfm) {
 		rc = 0;
 		goto out;
@@ -816,6 +818,18 @@ out:
 	return rc;
 }
 
+static void ecryptfs_generate_new_key(struct ecryptfs_crypt_stat *crypt_stat)
+{
+	get_random_bytes(crypt_stat->key, (crypt_stat->key_size_bits >> 3));
+	ECRYPTFS_SET_FLAG(crypt_stat->flags, ECRYPTFS_KEY_VALID);
+	ecryptfs_compute_root_iv(crypt_stat);
+	if (unlikely(ecryptfs_verbosity > 0)) {
+		ecryptfs_printk(KERN_DEBUG, "Generated new session key:\n");
+		ecryptfs_dump_hex(crypt_stat->key,
+				  crypt_stat->key_size_bits / 8);
+	}
+}
+
 /**
  * ecryptfs_set_default_crypt_stat_vals
  * @crypt_stat
@@ -825,19 +839,10 @@ out:
 static void
 ecryptfs_set_default_crypt_stat_vals(struct ecryptfs_crypt_stat *crypt_stat)
 {
-	int key_size_bits = ECRYPTFS_DEFAULT_KEY_BYTES * 8;
-
 	ecryptfs_set_default_sizes(crypt_stat);
 	strcpy(crypt_stat->cipher, ECRYPTFS_DEFAULT_CIPHER);
-	crypt_stat->key_size_bits = key_size_bits;
-	get_random_bytes(crypt_stat->key, key_size_bits / 8);
-	ECRYPTFS_SET_FLAG(crypt_stat->flags, ECRYPTFS_KEY_VALID);
-	ecryptfs_compute_root_iv(crypt_stat);
-	if (unlikely(ecryptfs_verbosity > 0)) {
-		ecryptfs_printk(KERN_DEBUG, "Generated new session key:\n");
-		ecryptfs_dump_hex(crypt_stat->key,
-				  crypt_stat->key_size_bits / 8);
-	}
+	crypt_stat->key_size_bits = ECRYPTFS_DEFAULT_KEY_BYTES << 3;
+	ECRYPTFS_CLEAR_FLAG(crypt_stat->flags, ECRYPTFS_KEY_VALID);
 	crypt_stat->file_version = ECRYPTFS_FILE_VERSION;
 }
 
@@ -887,6 +892,9 @@ int ecryptfs_new_file_context(struct den
 		       mount_crypt_stat->global_default_cipher_name,
 		       cipher_name_len);
 		crypt_stat->cipher[cipher_name_len] = '\0';
+		crypt_stat->key_size_bits =
+			mount_crypt_stat->global_default_cipher_key_bits;
+		ecryptfs_generate_new_key(crypt_stat);
 	} else
 		/* We should not encounter this scenario since we
 		 * should detect lack of global_auth_tok at mount time
-- 
1.3.3

