Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030361AbWI1Sbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030361AbWI1Sbx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 14:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030360AbWI1Sbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 14:31:52 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:37329 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030358AbWI1Sbr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 14:31:47 -0400
Date: Thu, 28 Sep 2006 13:31:40 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: akpm@osdl.org
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] eCryptfs: Enable plaintext passthrough
Message-ID: <20060928183139.GA5082@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Code that is currently unused in mmap.c can simply pass through
unencrypted data. This patch adds a mount option to enable that
functionality.

Note that, with this patch, one can encrypt a directory full of
unencrypted files by doing something like this for each file:

cp file.txt .file.txt; mv .file.txt file.txt

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/crypto.c          |    4 ----
 fs/ecryptfs/ecryptfs_kernel.h |    5 ++++-
 fs/ecryptfs/file.c            |   40 +++++++++++++++++++++++++++++-----------
 fs/ecryptfs/inode.c           |    4 ++--
 fs/ecryptfs/main.c            |    7 ++++++-
 5 files changed, 41 insertions(+), 19 deletions(-)

39a20eb2e87eb501c849a78f41640f11c6a0a01d
diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 39d7ec0..ed35a97 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -1394,8 +1394,6 @@ static int ecryptfs_read_headers_virt(ch
 	offset = ECRYPTFS_FILE_SIZE_BYTES;
 	rc = contains_ecryptfs_marker(page_virt + offset);
 	if (rc == 0) {
-		ecryptfs_printk(KERN_WARNING, "Valid eCryptfs marker not "
-				"found\n");
 		rc = -EINVAL;
 		goto out;
 	}
@@ -1463,8 +1461,6 @@ int ecryptfs_read_headers(struct dentry 
 					    &lower_file->f_pos);
 	set_fs(oldfs);
 	if (bytes_read != ECRYPTFS_DEFAULT_EXTENT_SIZE) {
-		ecryptfs_printk(KERN_ERR, "Expected size of header not read."
-				"Instead [%d] bytes were read\n", bytes_read);
 		rc = -EINVAL;
 		goto out;
 	}
diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index bae19ea..3911219 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -42,7 +42,8 @@ #define ECRYPTFS_VERSIONING_PASSPHRASE 0
 #define ECRYPTFS_VERSIONING_PUBKEY 0x00000002
 #define ECRYPTFS_VERSIONING_PLAINTEXT_PASSTHROUGH 0x00000004
 #define ECRYPTFS_VERSIONING_POLICY 0x00000008
-#define ECRYPTFS_VERSIONING_MASK (ECRYPTFS_VERSIONING_PASSPHRASE)
+#define ECRYPTFS_VERSIONING_MASK (ECRYPTFS_VERSIONING_PASSPHRASE \
+                                  | ECRYPTFS_VERSIONING_PLAINTEXT_PASSTHROUGH)
 
 #define ECRYPTFS_MAX_PASSWORD_LENGTH 64
 #define ECRYPTFS_MAX_PASSPHRASE_BYTES ECRYPTFS_MAX_PASSWORD_LENGTH
@@ -238,6 +239,8 @@ struct ecryptfs_dentry_info {
  */
 struct ecryptfs_mount_crypt_stat {
 	/* Pointers to memory we do not own, do not free these */
+#define ECRYPTFS_PLAINTEXT_PASSTHROUGH_ENABLED 0x00000001
+	u32 flags;
 	struct ecryptfs_auth_tok *global_auth_tok;
 	struct key *global_auth_tok_key;
 	size_t global_default_cipher_key_size;
diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
index 1cc2cc0..c8550c9 100644
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -211,6 +211,7 @@ static int ecryptfs_open(struct inode *i
 {
 	int rc = 0;
 	struct ecryptfs_crypt_stat *crypt_stat = NULL;
+	struct ecryptfs_mount_crypt_stat *mount_crypt_stat;
 	struct dentry *ecryptfs_dentry = file->f_dentry;
 	/* Private value of ecryptfs_dentry allocated in
 	 * ecryptfs_lookup() */
@@ -233,6 +234,8 @@ static int ecryptfs_open(struct inode *i
 	memset(file_info, 0, sizeof(*file_info));
 	lower_dentry = ecryptfs_dentry_to_lower(ecryptfs_dentry);
 	crypt_stat = &ecryptfs_inode_to_private(inode)->crypt_stat;
+	mount_crypt_stat = &ecryptfs_superblock_to_private(
+		ecryptfs_dentry->d_sb)->mount_crypt_stat;
 	mutex_lock(&crypt_stat->cs_mutex);
 	if (!ECRYPTFS_CHECK_FLAG(crypt_stat->flags, ECRYPTFS_POLICY_APPLIED)) {
 		ecryptfs_printk(KERN_DEBUG, "Setting flags for stat...\n");
@@ -267,12 +270,21 @@ static int ecryptfs_open(struct inode *i
 		goto out;
 	}
 	mutex_lock(&crypt_stat->cs_mutex);
-	if (i_size_read(lower_inode) == 0) {
-		ecryptfs_printk(KERN_EMERG, "Zero-length lower file; "
-				"ecryptfs_create() had a problem?\n");
-		rc = -ENOENT;
+	if (i_size_read(lower_inode) < ECRYPTFS_MINIMUM_HEADER_EXTENT_SIZE) {
+		if (!(mount_crypt_stat->flags
+		      & ECRYPTFS_PLAINTEXT_PASSTHROUGH_ENABLED)) {
+			rc = -EIO;
+			printk(KERN_WARNING "Attempt to read file that is "
+			       "not in a valid eCryptfs format, and plaintext "
+			       "passthrough mode is not enabled; returning "
+			       "-EIO\n");
+			mutex_unlock(&crypt_stat->cs_mutex);
+			goto out_puts;
+		}
+		crypt_stat->flags &= ~(ECRYPTFS_ENCRYPTED);
+		rc = 0;
 		mutex_unlock(&crypt_stat->cs_mutex);
-		goto out_puts;
+		goto out;
 	} else if (!ECRYPTFS_CHECK_FLAG(crypt_stat->flags,
 					ECRYPTFS_POLICY_APPLIED)
 		   || !ECRYPTFS_CHECK_FLAG(crypt_stat->flags,
@@ -281,15 +293,21 @@ static int ecryptfs_open(struct inode *i
 		if (rc) {
 			ecryptfs_printk(KERN_DEBUG,
 					"Valid headers not found\n");
+			if (!(mount_crypt_stat->flags
+			      & ECRYPTFS_PLAINTEXT_PASSTHROUGH_ENABLED)) {
+				rc = -EIO;
+				printk(KERN_WARNING "Attempt to read file that "
+				       "is not in a valid eCryptfs format, "
+				       "and plaintext passthrough mode is not "
+				       "enabled; returning -EIO\n");
+				mutex_unlock(&crypt_stat->cs_mutex);
+				goto out_puts;
+			}
 			ECRYPTFS_CLEAR_FLAG(crypt_stat->flags,
 					    ECRYPTFS_ENCRYPTED);
-			/* At this point, we could just move on and
-			 * have the encrypted data passed through
-			 * as-is to userspace. For release 0.1, we are
-			 * going to default to -EIO. */
-			rc = -EIO;
+			rc = 0;
 			mutex_unlock(&crypt_stat->cs_mutex);
-			goto out_puts;
+			goto out;
 		}
 	}
 	mutex_unlock(&crypt_stat->cs_mutex);
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 503fb39..efdd2b7 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -436,8 +436,8 @@ static struct dentry *ecryptfs_lookup(st
 	} else {
 		if (!contains_ecryptfs_marker(page_virt
 					      + ECRYPTFS_FILE_SIZE_BYTES)) {
-			ecryptfs_printk(KERN_WARNING, "Underlying file "
-					"lacks recognizable eCryptfs marker\n");
+			kmem_cache_free(ecryptfs_header_cache_2, page_virt);
+			goto out;
 		}
 		memcpy(&file_size, page_virt, sizeof(file_size));
 		file_size = be64_to_cpu(file_size);
diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index b7e3bd0..c88a8c9 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -126,7 +126,7 @@ out:
 enum { ecryptfs_opt_sig, ecryptfs_opt_ecryptfs_sig, ecryptfs_opt_debug,
        ecryptfs_opt_ecryptfs_debug, ecryptfs_opt_cipher,
        ecryptfs_opt_ecryptfs_cipher, ecryptfs_opt_ecryptfs_key_bytes,
-       ecryptfs_opt_err };
+       ecryptfs_opt_passthrough, ecryptfs_opt_err };
 
 static match_table_t tokens = {
 	{ecryptfs_opt_sig, "sig=%s"},
@@ -136,6 +136,7 @@ static match_table_t tokens = {
 	{ecryptfs_opt_cipher, "cipher=%s"},
 	{ecryptfs_opt_ecryptfs_cipher, "ecryptfs_cipher=%s"},
 	{ecryptfs_opt_ecryptfs_key_bytes, "ecryptfs_key_bytes=%u"},
+	{ecryptfs_opt_passthrough, "ecryptfs_passthrough"},
 	{ecryptfs_opt_err, NULL}
 };
 
@@ -273,6 +274,10 @@ static int ecryptfs_parse_options(struct
 					global_default_cipher_key_size);
 			cipher_key_bytes_set = 1;
 			break;
+		case ecryptfs_opt_passthrough:
+			mount_crypt_stat->flags |=
+				ECRYPTFS_PLAINTEXT_PASSTHROUGH_ENABLED;
+			break;
 		case ecryptfs_opt_err:
 		default:
 			ecryptfs_printk(KERN_WARNING,
-- 
1.3.3

