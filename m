Return-Path: <linux-kernel-owner+w=401wt.eu-S932451AbXAIWWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbXAIWWF (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 17:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbXAIWWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 17:22:05 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:50967 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932451AbXAIWWC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 17:22:02 -0500
Date: Tue, 9 Jan 2007 16:22:01 -0600
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, tshighla@us.ibm.com, theotso@us.ibm.com
Subject: [PATCH 1/3] eCryptfs: xattr flags and mount options
Message-ID: <20070109222201.GD16578@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20070109222107.GC16578@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070109222107.GC16578@us.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add extended attribute support to version bit vector, flags to
indicate when xattr or encrypted view modes are enabled, and support
for the new mount options.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/crypto.c          |   20 ++++++++++++++++++++
 fs/ecryptfs/ecryptfs_kernel.h |   15 ++++++++++-----
 fs/ecryptfs/main.c            |   18 ++++++++++++++++--
 3 files changed, 46 insertions(+), 7 deletions(-)

72a24201af3657aa4e6365b18ba869422fa77cee
diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 33f92d7..c2811b1 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -917,6 +917,22 @@ static void ecryptfs_generate_new_key(st
 }
 
 /**
+ * ecryptfs_copy_mount_wide_flags_to_inode_flags
+ *
+ * This function propagates the mount-wide flags to individual inode
+ * flags.
+ */
+static void ecryptfs_copy_mount_wide_flags_to_inode_flags(
+	struct ecryptfs_crypt_stat *crypt_stat,
+	struct ecryptfs_mount_crypt_stat *mount_crypt_stat)
+{
+	if (mount_crypt_stat->flags & ECRYPTFS_XATTR_METADATA_ENABLED)
+		crypt_stat->flags |= ECRYPTFS_METADATA_IN_XATTR;
+	if (mount_crypt_stat->flags & ECRYPTFS_ENCRYPTED_VIEW_ENABLED)
+		crypt_stat->flags |= ECRYPTFS_VIEW_AS_ENCRYPTED;
+}
+
+/**
  * ecryptfs_set_default_crypt_stat_vals
  * @crypt_stat
  *
@@ -926,6 +942,8 @@ static void ecryptfs_set_default_crypt_s
 	struct ecryptfs_crypt_stat *crypt_stat,
 	struct ecryptfs_mount_crypt_stat *mount_crypt_stat)
 {
+	ecryptfs_copy_mount_wide_flags_to_inode_flags(crypt_stat,
+						      mount_crypt_stat);
 	ecryptfs_set_default_sizes(crypt_stat);
 	strcpy(crypt_stat->cipher, ECRYPTFS_DEFAULT_CIPHER);
 	crypt_stat->key_size = ECRYPTFS_DEFAULT_KEY_BYTES;
@@ -971,6 +989,8 @@ int ecryptfs_new_file_context(struct den
 				"file using mount_crypt_stat\n");
 		ECRYPTFS_SET_FLAG(crypt_stat->flags, ECRYPTFS_ENCRYPTED);
 		ECRYPTFS_SET_FLAG(crypt_stat->flags, ECRYPTFS_KEY_VALID);
+		ecryptfs_copy_mount_wide_flags_to_inode_flags(crypt_stat,
+							      mount_crypt_stat);
 		memcpy(crypt_stat->keysigs[crypt_stat->num_keysigs++],
 		       mount_crypt_stat->global_auth_tok_sig,
 		       ECRYPTFS_SIG_SIZE_HEX);
diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index 51c299a..f74b343 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -43,13 +43,14 @@ #define ECRYPTFS_SUPPORTED_FILE_VERSION 
  * module; userspace tools such as the mount helper read
  * ECRYPTFS_VERSIONING_MASK from a sysfs handle in order to determine
  * how to behave. */
-#define ECRYPTFS_VERSIONING_PASSPHRASE 0x00000001
-#define ECRYPTFS_VERSIONING_PUBKEY 0x00000002
+#define ECRYPTFS_VERSIONING_PASSPHRASE            0x00000001
+#define ECRYPTFS_VERSIONING_PUBKEY                0x00000002
 #define ECRYPTFS_VERSIONING_PLAINTEXT_PASSTHROUGH 0x00000004
-#define ECRYPTFS_VERSIONING_POLICY 0x00000008
+#define ECRYPTFS_VERSIONING_POLICY                0x00000008
+#define ECRYPTFS_VERSIONING_XATTR                 0x00000010
 #define ECRYPTFS_VERSIONING_MASK (ECRYPTFS_VERSIONING_PASSPHRASE \
-                                  | ECRYPTFS_VERSIONING_PLAINTEXT_PASSTHROUGH \
-                                  | ECRYPTFS_VERSIONING_PUBKEY)
+				  | ECRYPTFS_VERSIONING_PLAINTEXT_PASSTHROUGH \
+				  | ECRYPTFS_VERSIONING_PUBKEY)
 
 #define ECRYPTFS_MAX_PASSWORD_LENGTH 64
 #define ECRYPTFS_MAX_PASSPHRASE_BYTES ECRYPTFS_MAX_PASSWORD_LENGTH
@@ -228,6 +229,8 @@ #define ECRYPTFS_SECURITY_WARNING   0x00
 #define ECRYPTFS_ENABLE_HMAC        0x00000020
 #define ECRYPTFS_ENCRYPT_IV_PAGES   0x00000040
 #define ECRYPTFS_KEY_VALID          0x00000080
+#define ECRYPTFS_METADATA_IN_XATTR  0x00000100
+#define ECRYPTFS_VIEW_AS_ENCRYPTED  0x00000200
 	u32 flags;
 	unsigned int file_version;
 	size_t iv_bytes;
@@ -274,6 +277,8 @@ struct ecryptfs_dentry_info {
 struct ecryptfs_mount_crypt_stat {
 	/* Pointers to memory we do not own, do not free these */
 #define ECRYPTFS_PLAINTEXT_PASSTHROUGH_ENABLED 0x00000001
+#define ECRYPTFS_XATTR_METADATA_ENABLED        0x00000002
+#define ECRYPTFS_ENCRYPTED_VIEW_ENABLED        0x00000004
 	u32 flags;
 	struct ecryptfs_auth_tok *global_auth_tok;
 	struct key *global_auth_tok_key;
diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index 87f05c4..a3efdcc 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -162,7 +162,8 @@ out:
 enum { ecryptfs_opt_sig, ecryptfs_opt_ecryptfs_sig, ecryptfs_opt_debug,
        ecryptfs_opt_ecryptfs_debug, ecryptfs_opt_cipher,
        ecryptfs_opt_ecryptfs_cipher, ecryptfs_opt_ecryptfs_key_bytes,
-       ecryptfs_opt_passthrough, ecryptfs_opt_err };
+       ecryptfs_opt_passthrough, ecryptfs_opt_xattr_metadata,
+       ecryptfs_opt_encrypted_view, ecryptfs_opt_err };
 
 static match_table_t tokens = {
 	{ecryptfs_opt_sig, "sig=%s"},
@@ -173,6 +174,8 @@ static match_table_t tokens = {
 	{ecryptfs_opt_ecryptfs_cipher, "ecryptfs_cipher=%s"},
 	{ecryptfs_opt_ecryptfs_key_bytes, "ecryptfs_key_bytes=%u"},
 	{ecryptfs_opt_passthrough, "ecryptfs_passthrough"},
+	{ecryptfs_opt_xattr_metadata, "ecryptfs_xattr_metadata"},
+	{ecryptfs_opt_encrypted_view, "ecryptfs_encrypted_view"},
 	{ecryptfs_opt_err, NULL}
 };
 
@@ -313,6 +316,16 @@ static int ecryptfs_parse_options(struct
 			mount_crypt_stat->flags |=
 				ECRYPTFS_PLAINTEXT_PASSTHROUGH_ENABLED;
 			break;
+		case ecryptfs_opt_xattr_metadata:
+			mount_crypt_stat->flags |=
+				ECRYPTFS_XATTR_METADATA_ENABLED;
+			break;
+		case ecryptfs_opt_encrypted_view:
+			mount_crypt_stat->flags |=
+				ECRYPTFS_XATTR_METADATA_ENABLED;
+			mount_crypt_stat->flags |=
+				ECRYPTFS_ENCRYPTED_VIEW_ENABLED;
+			break;
 		case ecryptfs_opt_err:
 		default:
 			ecryptfs_printk(KERN_WARNING,
@@ -734,7 +747,8 @@ static struct ecryptfs_version_str_map_e
 	{ECRYPTFS_VERSIONING_PASSPHRASE, "passphrase"},
 	{ECRYPTFS_VERSIONING_PUBKEY, "pubkey"},
 	{ECRYPTFS_VERSIONING_PLAINTEXT_PASSTHROUGH, "plaintext passthrough"},
-	{ECRYPTFS_VERSIONING_POLICY, "policy"}
+	{ECRYPTFS_VERSIONING_POLICY, "policy"},
+	{ECRYPTFS_VERSIONING_XATTR, "metadata in extended attribute"}
 };
 
 static ssize_t version_str_show(struct ecryptfs_obj *obj, char *buff)
-- 
1.3.3

