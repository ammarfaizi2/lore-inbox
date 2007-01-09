Return-Path: <linux-kernel-owner+w=401wt.eu-S932459AbXAIWW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbXAIWW6 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 17:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbXAIWW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 17:22:58 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:42587 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932459AbXAIWW4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 17:22:56 -0500
Date: Tue, 9 Jan 2007 16:22:55 -0600
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, tshighla@us.ibm.com, theotso@us.ibm.com
Subject: [PATCH 2/3] eCryptfs: Generalize metadata read/write
Message-ID: <20070109222255.GE16578@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20070109222107.GC16578@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070109222107.GC16578@us.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Generalize the metadata reading and writing mechanisms, with two
targets for now: metadata in file header and metadata in the
user.ecryptfs xattr of the lower file.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/crypto.c          |  224 ++++++++++++++++++++++++++++++++---------
 fs/ecryptfs/ecryptfs_kernel.h |   37 +++++--
 fs/ecryptfs/file.c            |   27 +----
 fs/ecryptfs/inode.c           |   61 ++++++-----
 fs/ecryptfs/main.c            |    7 +
 fs/ecryptfs/mmap.c            |   96 ++++++++++++++++--
 6 files changed, 335 insertions(+), 117 deletions(-)

6d11a3df119acb8438e2629d9ac656309ac2a61f
diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index c2811b1..e7f5441 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) 1997-2004 Erez Zadok
  * Copyright (C) 2001-2004 Stony Brook University
- * Copyright (C) 2004-2006 International Business Machines Corp.
+ * Copyright (C) 2004-2007 International Business Machines Corp.
  *   Author(s): Michael A. Halcrow <mahalcro@us.ibm.com>
  *   		Michael C. Thompson <mcthomps@us.ibm.com>
  *
@@ -865,7 +865,10 @@ void ecryptfs_set_default_sizes(struct e
 			ECRYPTFS_MINIMUM_HEADER_EXTENT_SIZE;
 	} else
 		crypt_stat->header_extent_size = PAGE_CACHE_SIZE;
-	crypt_stat->num_header_extents_at_front = 1;
+	if (crypt_stat->flags & ECRYPTFS_METADATA_IN_XATTR)
+		crypt_stat->num_header_extents_at_front = 0;
+	else
+		crypt_stat->num_header_extents_at_front = 1;
 }
 
 /**
@@ -1049,7 +1052,8 @@ struct ecryptfs_flag_map_elem {
 /* Add support for additional flags by adding elements here. */
 static struct ecryptfs_flag_map_elem ecryptfs_flag_map[] = {
 	{0x00000001, ECRYPTFS_ENABLE_HMAC},
-	{0x00000002, ECRYPTFS_ENCRYPTED}
+	{0x00000002, ECRYPTFS_ENCRYPTED},
+	{0x00000004, ECRYPTFS_METADATA_IN_XATTR}
 };
 
 /**
@@ -1239,6 +1243,21 @@ out:
 	return rc;
 }
 
+int ecryptfs_read_and_validate_header_region(char *data, struct dentry *dentry,
+					     struct vfsmount *mnt)
+{
+	int rc;
+
+	rc = ecryptfs_read_header_region(data, dentry, mnt);
+	if (rc)
+		goto out;
+	if (!contains_ecryptfs_marker(data + ECRYPTFS_FILE_SIZE_BYTES))
+		rc = -EINVAL;
+out:
+	return rc;
+}
+
+
 static void
 write_header_metadata(char *virt, struct ecryptfs_crypt_stat *crypt_stat,
 		      size_t *written)
@@ -1290,7 +1309,7 @@ struct kmem_cache *ecryptfs_header_cache
  *
  * Returns zero on success
  */
-int ecryptfs_write_headers_virt(char *page_virt,
+int ecryptfs_write_headers_virt(char *page_virt, size_t *size,
 				struct ecryptfs_crypt_stat *crypt_stat,
 				struct dentry *ecryptfs_dentry)
 {
@@ -1311,11 +1330,53 @@ int ecryptfs_write_headers_virt(char *pa
 	if (rc)
 		ecryptfs_printk(KERN_WARNING, "Error generating key packet "
 				"set; rc = [%d]\n", rc);
+	if (size) {
+		offset += written;
+		*size = offset;
+	}
+	return rc;
+}
+
+int ecryptfs_write_metadata_to_contents(struct ecryptfs_crypt_stat *crypt_stat,
+					struct file *lower_file,
+					char *page_virt)
+{
+	mm_segment_t oldfs;
+	int current_header_page;
+	int header_pages;
+
+	lower_file->f_pos = 0;
+	oldfs = get_fs();
+	set_fs(get_ds());
+	lower_file->f_op->write(lower_file, (char __user *)page_virt,
+				PAGE_CACHE_SIZE, &lower_file->f_pos);
+	header_pages = ((crypt_stat->header_extent_size
+			 * crypt_stat->num_header_extents_at_front)
+			/ PAGE_CACHE_SIZE);
+	memset(page_virt, 0, PAGE_CACHE_SIZE);
+	current_header_page = 1;
+	while (current_header_page < header_pages) {
+		lower_file->f_op->write(lower_file, (char __user *)page_virt,
+					PAGE_CACHE_SIZE, &lower_file->f_pos);
+		current_header_page++;
+	}
+	set_fs(oldfs);
+	return 0;
+}
+
+int ecryptfs_write_metadata_to_xattr(struct dentry *ecryptfs_dentry,
+				     struct ecryptfs_crypt_stat *crypt_stat,
+				     char *page_virt, size_t size)
+{
+	int rc;
+
+	rc = ecryptfs_setxattr(ecryptfs_dentry, ECRYPTFS_XATTR_NAME, page_virt,
+			       size, 0);
 	return rc;
 }
 
 /**
- * ecryptfs_write_headers
+ * ecryptfs_write_metadata
  * @lower_file: The lower file struct, which was returned from dentry_open
  *
  * Write the file headers out.  This will likely involve a userspace
@@ -1326,14 +1387,12 @@ int ecryptfs_write_headers_virt(char *pa
  *
  * Returns zero on success; non-zero on error
  */
-int ecryptfs_write_headers(struct dentry *ecryptfs_dentry,
-			   struct file *lower_file)
+int ecryptfs_write_metadata(struct dentry *ecryptfs_dentry,
+			    struct file *lower_file)
 {
-	mm_segment_t oldfs;
 	struct ecryptfs_crypt_stat *crypt_stat;
 	char *page_virt;
-	int current_header_page;
-	int header_pages;
+	size_t size;
 	int rc = 0;
 
 	crypt_stat = &ecryptfs_inode_to_private(
@@ -1360,48 +1419,36 @@ int ecryptfs_write_headers(struct dentry
 		rc = -ENOMEM;
 		goto out;
 	}
-
-	rc = ecryptfs_write_headers_virt(page_virt, crypt_stat,
-					 ecryptfs_dentry);
+	rc = ecryptfs_write_headers_virt(page_virt, &size, crypt_stat,
+  					 ecryptfs_dentry);
 	if (unlikely(rc)) {
 		ecryptfs_printk(KERN_ERR, "Error whilst writing headers\n");
 		memset(page_virt, 0, PAGE_CACHE_SIZE);
 		goto out_free;
 	}
-	ecryptfs_printk(KERN_DEBUG,
-			"Writing key packet set to underlying file\n");
-	lower_file->f_pos = 0;
-	oldfs = get_fs();
-	set_fs(get_ds());
-	ecryptfs_printk(KERN_DEBUG, "Calling lower_file->f_op->"
-			"write() w/ header page; lower_file->f_pos = "
-			"[0x%.16x]\n", lower_file->f_pos);
-	lower_file->f_op->write(lower_file, (char __user *)page_virt,
-				PAGE_CACHE_SIZE, &lower_file->f_pos);
-	header_pages = ((crypt_stat->header_extent_size
-			 * crypt_stat->num_header_extents_at_front)
-			/ PAGE_CACHE_SIZE);
-	memset(page_virt, 0, PAGE_CACHE_SIZE);
-	current_header_page = 1;
-	while (current_header_page < header_pages) {
-		ecryptfs_printk(KERN_DEBUG, "Calling lower_file->f_op->"
-				"write() w/ zero'd page; lower_file->f_pos = "
-				"[0x%.16x]\n", lower_file->f_pos);
-		lower_file->f_op->write(lower_file, (char __user *)page_virt,
-					PAGE_CACHE_SIZE, &lower_file->f_pos);
-		current_header_page++;
+	if (crypt_stat->flags & ECRYPTFS_METADATA_IN_XATTR)
+		rc = ecryptfs_write_metadata_to_xattr(ecryptfs_dentry,
+						      crypt_stat, page_virt,
+						      size);
+	else
+		rc = ecryptfs_write_metadata_to_contents(crypt_stat, lower_file,
+							 page_virt);
+	if (rc) {
+		printk(KERN_ERR "Error writing metadata out to lower file; "
+		       "rc = [%d]\n", rc);
+		goto out_free;
 	}
-	set_fs(oldfs);
-	ecryptfs_printk(KERN_DEBUG,
-			"Done writing key packet set to underlying file.\n");
 out_free:
 	kmem_cache_free(ecryptfs_header_cache_0, page_virt);
 out:
 	return rc;
 }
 
+#define ECRYPTFS_DONT_VALIDATE_HEADER_SIZE 0
+#define ECRYPTFS_VALIDATE_HEADER_SIZE 1
 static int parse_header_metadata(struct ecryptfs_crypt_stat *crypt_stat,
-				 char *virt, int *bytes_read)
+				 char *virt, int *bytes_read,
+				 int validate_header_size)
 {
 	int rc = 0;
 	u32 header_extent_size;
@@ -1416,9 +1463,10 @@ static int parse_header_metadata(struct 
 	crypt_stat->num_header_extents_at_front =
 		(int)num_header_extents_at_front;
 	(*bytes_read) = 6;
-	if ((crypt_stat->header_extent_size
-	     * crypt_stat->num_header_extents_at_front)
-	    < ECRYPTFS_MINIMUM_HEADER_EXTENT_SIZE) {
+	if ((validate_header_size == ECRYPTFS_VALIDATE_HEADER_SIZE)
+	    && ((crypt_stat->header_extent_size
+		 * crypt_stat->num_header_extents_at_front)
+		< ECRYPTFS_MINIMUM_HEADER_EXTENT_SIZE)) {
 		rc = -EINVAL;
 		ecryptfs_printk(KERN_WARNING, "Invalid header extent size: "
 				"[%d]\n", crypt_stat->header_extent_size);
@@ -1449,7 +1497,8 @@ static void set_default_header_data(stru
  */
 static int ecryptfs_read_headers_virt(char *page_virt,
 				      struct ecryptfs_crypt_stat *crypt_stat,
-				      struct dentry *ecryptfs_dentry)
+				      struct dentry *ecryptfs_dentry,
+				      int validate_header_size)
 {
 	int rc = 0;
 	int offset;
@@ -1483,7 +1532,7 @@ static int ecryptfs_read_headers_virt(ch
 	offset += bytes_read;
 	if (crypt_stat->file_version >= 1) {
 		rc = parse_header_metadata(crypt_stat, (page_virt + offset),
-					   &bytes_read);
+					   &bytes_read, validate_header_size);
 		if (rc) {
 			ecryptfs_printk(KERN_WARNING, "Error reading header "
 					"metadata; rc = [%d]\n", rc);
@@ -1498,12 +1547,60 @@ out:
 }
 
 /**
- * ecryptfs_read_headers
+ * ecryptfs_read_xattr_region
+ *
+ * Attempts to read the crypto metadata from the extended attribute
+ * region of the lower file.
+ */
+int ecryptfs_read_xattr_region(char *page_virt, struct dentry *ecryptfs_dentry)
+{
+	ssize_t size;
+	int rc = 0;
+
+	size = ecryptfs_getxattr(ecryptfs_dentry, ECRYPTFS_XATTR_NAME,
+				 page_virt, ECRYPTFS_DEFAULT_EXTENT_SIZE);
+	if (size < 0) {
+		printk(KERN_DEBUG "Error attempting to read the [%s] "
+		       "xattr from the lower file; return value = [%d]\n",
+		       ECRYPTFS_XATTR_NAME, size);
+		rc = -EINVAL;
+		goto out;
+	}
+out:
+	return rc;
+}
+
+int ecryptfs_read_and_validate_xattr_region(char *page_virt,
+					    struct dentry *ecryptfs_dentry)
+{
+	int rc;
+
+	rc = ecryptfs_read_xattr_region(page_virt, ecryptfs_dentry);
+	if (rc)
+		goto out;
+	if (!contains_ecryptfs_marker(page_virt	+ ECRYPTFS_FILE_SIZE_BYTES)) {
+		printk(KERN_WARNING "Valid data found in [%s] xattr, but "
+			"the marker is invalid\n", ECRYPTFS_XATTR_NAME);
+		rc = -EINVAL;
+	}
+out:
+	return rc;
+}
+
+/**
+ * ecryptfs_read_metadata
+ *
+ * Common entry point for reading file metadata. From here, we could
+ * retrieve the header information from the header region of the file,
+ * the xattr region of the file, or some other repostory that is
+ * stored separately from the file itself. The current implementation
+ * supports retrieving the metadata information from the file contents
+ * and from the xattr region.
  *
  * Returns zero if valid headers found and parsed; non-zero otherwise
  */
-int ecryptfs_read_headers(struct dentry *ecryptfs_dentry,
-			  struct file *lower_file)
+int ecryptfs_read_metadata(struct dentry *ecryptfs_dentry,
+			   struct file *lower_file)
 {
 	int rc = 0;
 	char *page_virt = NULL;
@@ -1532,11 +1629,36 @@ int ecryptfs_read_headers(struct dentry 
 		goto out;
 	}
 	rc = ecryptfs_read_headers_virt(page_virt, crypt_stat,
-					ecryptfs_dentry);
+					ecryptfs_dentry,
+					ECRYPTFS_VALIDATE_HEADER_SIZE);
 	if (rc) {
-		ecryptfs_printk(KERN_DEBUG, "Valid eCryptfs headers not "
-				"found\n");
-		rc = -EINVAL;
+		rc = ecryptfs_read_xattr_region(page_virt,
+						ecryptfs_dentry);
+		if (rc) {
+			printk(KERN_DEBUG "Valid eCryptfs headers not found in "
+			       "file header region or xattr region\n");
+			rc = -EINVAL;
+			goto out;
+		}
+		rc = ecryptfs_read_headers_virt(page_virt, crypt_stat,
+						ecryptfs_dentry,
+						ECRYPTFS_DONT_VALIDATE_HEADER_SIZE);
+		if (rc) {
+			printk(KERN_DEBUG "Valid eCryptfs headers not found in "
+			       "file xattr region either\n");
+			rc = -EINVAL;
+		}
+		if (crypt_stat->mount_crypt_stat->flags
+		    & ECRYPTFS_XATTR_METADATA_ENABLED) {
+			crypt_stat->flags |= ECRYPTFS_METADATA_IN_XATTR;
+		} else {
+			printk(KERN_WARNING "Attempt to access file with "
+			       "crypto metadata only in the extended attribute "
+			       "region, but eCryptfs was mounted without "
+			       "xattr support enabled. eCryptfs will not treat "
+			       "this like an encrypted file.\n");
+			rc = -EINVAL;
+		}
 	}
 out:
 	if (page_virt) {
diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index f74b343..aecca2f 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -4,7 +4,7 @@
  *
  * Copyright (C) 1997-2003 Erez Zadok
  * Copyright (C) 2001-2003 Stony Brook University
- * Copyright (C) 2004-2006 International Business Machines Corp.
+ * Copyright (C) 2004-2007 International Business Machines Corp.
  *   Author(s): Michael A. Halcrow <mahalcro@us.ibm.com>
  *              Trevor S. Highland <trevor.highland@gmail.com>
  *              Tyler Hicks <tyhicks@ou.edu>
@@ -50,8 +50,8 @@ #define ECRYPTFS_VERSIONING_POLICY      
 #define ECRYPTFS_VERSIONING_XATTR                 0x00000010
 #define ECRYPTFS_VERSIONING_MASK (ECRYPTFS_VERSIONING_PASSPHRASE \
 				  | ECRYPTFS_VERSIONING_PLAINTEXT_PASSTHROUGH \
-				  | ECRYPTFS_VERSIONING_PUBKEY)
-
+				  | ECRYPTFS_VERSIONING_PUBKEY \
+				  | ECRYPTFS_VERSIONING_XATTR)
 #define ECRYPTFS_MAX_PASSWORD_LENGTH 64
 #define ECRYPTFS_MAX_PASSPHRASE_BYTES ECRYPTFS_MAX_PASSWORD_LENGTH
 #define ECRYPTFS_SALT_SIZE 8
@@ -83,6 +83,7 @@ #define ECRYPTFS_TRANSPORT_NETLINK 0
 #define ECRYPTFS_TRANSPORT_CONNECTOR 1
 #define ECRYPTFS_TRANSPORT_RELAYFS 2
 #define ECRYPTFS_DEFAULT_TRANSPORT ECRYPTFS_TRANSPORT_NETLINK
+#define ECRYPTFS_XATTR_NAME "user.ecryptfs"
 
 #define RFC2440_CIPHER_DES3_EDE 0x02
 #define RFC2440_CIPHER_CAST_5 0x03
@@ -480,6 +481,7 @@ extern struct kmem_cache *ecryptfs_sb_in
 extern struct kmem_cache *ecryptfs_header_cache_0;
 extern struct kmem_cache *ecryptfs_header_cache_1;
 extern struct kmem_cache *ecryptfs_header_cache_2;
+extern struct kmem_cache *ecryptfs_xattr_cache;
 extern struct kmem_cache *ecryptfs_lower_page_cache;
 
 int ecryptfs_interpose(struct dentry *hidden_dentry,
@@ -506,9 +508,13 @@ int ecryptfs_init_crypt_ctx(struct ecryp
 int ecryptfs_crypto_api_algify_cipher_name(char **algified_name,
 					   char *cipher_name,
 					   char *chaining_modifier);
-int ecryptfs_write_inode_size_to_header(struct file *lower_file,
-					struct inode *lower_inode,
-					struct inode *inode);
+#define ECRYPTFS_LOWER_I_MUTEX_NOT_HELD 0
+#define ECRYPTFS_LOWER_I_MUTEX_HELD 1
+int ecryptfs_write_inode_size_to_metadata(struct file *lower_file,
+					  struct inode *lower_inode,
+					  struct inode *inode,
+					  struct dentry *ecryptfs_dentry,
+					  int lower_i_mutex_held);
 int ecryptfs_get_lower_page(struct page **lower_page, struct inode *lower_inode,
 			    struct file *lower_file,
 			    unsigned long lower_page_index, int byte_offset,
@@ -530,17 +536,21 @@ int ecryptfs_writepage_and_release_lower
 					      struct writeback_control *wbc);
 int ecryptfs_encrypt_page(struct ecryptfs_page_crypt_context *ctx);
 int ecryptfs_decrypt_page(struct file *file, struct page *page);
-int ecryptfs_write_headers(struct dentry *ecryptfs_dentry,
-			   struct file *lower_file);
-int ecryptfs_write_headers_virt(char *page_virt,
+int ecryptfs_write_metadata(struct dentry *ecryptfs_dentry,
+			    struct file *lower_file);
+int ecryptfs_write_headers_virt(char *page_virt, size_t *size,
 				struct ecryptfs_crypt_stat *crypt_stat,
 				struct dentry *ecryptfs_dentry);
-int ecryptfs_read_headers(struct dentry *ecryptfs_dentry,
-			  struct file *lower_file);
+int ecryptfs_read_metadata(struct dentry *ecryptfs_dentry,
+			   struct file *lower_file);
 int ecryptfs_new_file_context(struct dentry *ecryptfs_dentry);
 int contains_ecryptfs_marker(char *data);
 int ecryptfs_read_header_region(char *data, struct dentry *dentry,
 				struct vfsmount *mnt);
+int ecryptfs_read_and_validate_header_region(char *data, struct dentry *dentry,
+					     struct vfsmount *mnt);
+int ecryptfs_read_and_validate_xattr_region(char *page_virt,
+					    struct dentry *ecryptfs_dentry);
 u16 ecryptfs_code_for_cipher_string(struct ecryptfs_crypt_stat *crypt_stat);
 int ecryptfs_cipher_code_to_string(char *str, u16 cipher_code);
 void ecryptfs_set_default_sizes(struct ecryptfs_crypt_stat *crypt_stat);
@@ -563,6 +573,11 @@ int ecryptfs_open_lower_file(struct file
 			     struct dentry *lower_dentry,
 			     struct vfsmount *lower_mnt, int flags);
 int ecryptfs_close_lower_file(struct file *lower_file);
+ssize_t ecryptfs_getxattr(struct dentry *dentry, const char *name, void *value,
+			  size_t size);
+int
+ecryptfs_setxattr(struct dentry *dentry, const char *name, const void *value,
+		  size_t size, int flags);
 
 int ecryptfs_process_helo(unsigned int transport, uid_t uid, pid_t pid);
 int ecryptfs_process_quit(uid_t uid, pid_t pid);
diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
index 779c347..f22c3a7 100644
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) 1997-2004 Erez Zadok
  * Copyright (C) 2001-2004 Stony Brook University
- * Copyright (C) 2004-2006 International Business Machines Corp.
+ * Copyright (C) 2004-2007 International Business Machines Corp.
  *   Author(s): Michael A. Halcrow <mhalcrow@us.ibm.com>
  *   		Michael C. Thompson <mcthomps@us.ibm.com>
  *
@@ -293,26 +293,11 @@ static int ecryptfs_open(struct inode *i
 		goto out;
 	}
 	mutex_lock(&crypt_stat->cs_mutex);
-	if (i_size_read(lower_inode) < ECRYPTFS_MINIMUM_HEADER_EXTENT_SIZE) {
-		if (!(mount_crypt_stat->flags
-		      & ECRYPTFS_PLAINTEXT_PASSTHROUGH_ENABLED)) {
-			rc = -EIO;
-			printk(KERN_WARNING "Attempt to read file that is "
-			       "not in a valid eCryptfs format, and plaintext "
-			       "passthrough mode is not enabled; returning "
-			       "-EIO\n");
-			mutex_unlock(&crypt_stat->cs_mutex);
-			goto out_puts;
-		}
-		crypt_stat->flags &= ~(ECRYPTFS_ENCRYPTED);
-		rc = 0;
-		mutex_unlock(&crypt_stat->cs_mutex);
-		goto out;
-	} else if (!ECRYPTFS_CHECK_FLAG(crypt_stat->flags,
-					ECRYPTFS_POLICY_APPLIED)
-		   || !ECRYPTFS_CHECK_FLAG(crypt_stat->flags,
-					   ECRYPTFS_KEY_VALID)) {
-		rc = ecryptfs_read_headers(ecryptfs_dentry, lower_file);
+	if (!ECRYPTFS_CHECK_FLAG(crypt_stat->flags,
+				 ECRYPTFS_POLICY_APPLIED)
+	    || !ECRYPTFS_CHECK_FLAG(crypt_stat->flags,
+				    ECRYPTFS_KEY_VALID)) {
+		rc = ecryptfs_read_metadata(ecryptfs_dentry, lower_file);
 		if (rc) {
 			ecryptfs_printk(KERN_DEBUG,
 					"Valid headers not found\n");
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index d4f02f3..6b45b29 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) 1997-2004 Erez Zadok
  * Copyright (C) 2001-2004 Stony Brook University
- * Copyright (C) 2004-2006 International Business Machines Corp.
+ * Copyright (C) 2004-2007 International Business Machines Corp.
  *   Author(s): Michael A. Halcrow <mahalcro@us.ibm.com>
  *              Michael C. Thompsion <mcthomps@us.ibm.com>
  *
@@ -169,7 +169,9 @@ static int grow_file(struct dentry *ecry
 		goto out;
 	}
 	i_size_write(inode, 0);
-	ecryptfs_write_inode_size_to_header(lower_file, lower_inode, inode);
+	ecryptfs_write_inode_size_to_metadata(lower_file, lower_inode, inode,
+					      ecryptfs_dentry,
+					      ECRYPTFS_LOWER_I_MUTEX_NOT_HELD);
 	ECRYPTFS_SET_FLAG(ecryptfs_inode_to_private(inode)->crypt_stat.flags,
 			  ECRYPTFS_NEW_FILE);
 out:
@@ -225,7 +227,7 @@ #endif
 				"context\n");
 		goto out_fput;
 	}
-	rc = ecryptfs_write_headers(ecryptfs_dentry, lower_file);
+	rc = ecryptfs_write_metadata(ecryptfs_dentry, lower_file);
 	if (rc) {
 		ecryptfs_printk(KERN_DEBUG, "Error writing headers\n");
 		goto out_fput;
@@ -362,32 +364,33 @@ static struct dentry *ecryptfs_lookup(st
 	}
 	/* Released in this function */
 	page_virt = kmem_cache_zalloc(ecryptfs_header_cache_2,
-				     GFP_USER);
+				      GFP_USER);
 	if (!page_virt) {
 		rc = -ENOMEM;
 		ecryptfs_printk(KERN_ERR,
 				"Cannot ecryptfs_kmalloc a page\n");
 		goto out_dput;
 	}
-
-	rc = ecryptfs_read_header_region(page_virt, lower_dentry, nd->mnt);
 	crypt_stat = &ecryptfs_inode_to_private(dentry->d_inode)->crypt_stat;
 	if (!ECRYPTFS_CHECK_FLAG(crypt_stat->flags, ECRYPTFS_POLICY_APPLIED))
 		ecryptfs_set_default_sizes(crypt_stat);
+	rc = ecryptfs_read_and_validate_header_region(page_virt, lower_dentry,
+						      nd->mnt);
 	if (rc) {
-		rc = 0;
-		ecryptfs_printk(KERN_WARNING, "Error reading header region;"
-				" assuming unencrypted\n");
-	} else {
-		if (!contains_ecryptfs_marker(page_virt
-					      + ECRYPTFS_FILE_SIZE_BYTES)) {
+		rc = ecryptfs_read_and_validate_xattr_region(page_virt, dentry);
+		if (rc) {
+			printk(KERN_DEBUG "Valid metadata not found in header "
+			       "region or xattr region; treating file as "
+			       "unencrypted\n");
+			rc = 0;
 			kmem_cache_free(ecryptfs_header_cache_2, page_virt);
 			goto out;
 		}
-		memcpy(&file_size, page_virt, sizeof(file_size));
-		file_size = be64_to_cpu(file_size);
-		i_size_write(dentry->d_inode, (loff_t)file_size);
+		crypt_stat->flags |= ECRYPTFS_METADATA_IN_XATTR;
 	}
+	memcpy(&file_size, page_virt, sizeof(file_size));
+	file_size = be64_to_cpu(file_size);
+	i_size_write(dentry->d_inode, (loff_t)file_size);
 	kmem_cache_free(ecryptfs_header_cache_2, page_virt);
 	goto out;
 
@@ -781,20 +784,26 @@ int ecryptfs_truncate(struct dentry *den
 			goto out_fput;
 		}
 		i_size_write(inode, new_length);
-		rc = ecryptfs_write_inode_size_to_header(lower_file,
-							 lower_dentry->d_inode,
-							 inode);
+		rc = ecryptfs_write_inode_size_to_metadata(
+			lower_file, lower_dentry->d_inode, inode, dentry,
+			ECRYPTFS_LOWER_I_MUTEX_NOT_HELD);
 		if (rc) {
-			ecryptfs_printk(KERN_ERR,
-					"Problem with ecryptfs_write"
-					"_inode_size\n");
+			printk(KERN_ERR	"Problem with "
+			       "ecryptfs_write_inode_size_to_metadata; "
+			       "rc = [%d]\n", rc);
 			goto out_fput;
 		}
 	} else { /* new_length < i_size_read(inode) */
 		vmtruncate(inode, new_length);
-		ecryptfs_write_inode_size_to_header(lower_file,
-						    lower_dentry->d_inode,
-						    inode);
+		rc = ecryptfs_write_inode_size_to_metadata(
+			lower_file, lower_dentry->d_inode, inode, dentry,
+			ECRYPTFS_LOWER_I_MUTEX_NOT_HELD);
+		if (rc) {
+			printk(KERN_ERR	"Problem with "
+			       "ecryptfs_write_inode_size_to_metadata; "
+			       "rc = [%d]\n", rc);
+			goto out_fput;
+		}
 		/* We are reducing the size of the ecryptfs file, and need to
 		 * know if we need to reduce the size of the lower file. */
 		lower_size_before_truncate =
@@ -881,7 +890,7 @@ out:
 	return rc;
 }
 
-static int
+int
 ecryptfs_setxattr(struct dentry *dentry, const char *name, const void *value,
 		  size_t size, int flags)
 {
@@ -901,7 +910,7 @@ out:
 	return rc;
 }
 
-static ssize_t
+ssize_t
 ecryptfs_getxattr(struct dentry *dentry, const char *name, void *value,
 		  size_t size)
 {
diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index a3efdcc..26fe405 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) 1997-2003 Erez Zadok
  * Copyright (C) 2001-2003 Stony Brook University
- * Copyright (C) 2004-2006 International Business Machines Corp.
+ * Copyright (C) 2004-2007 International Business Machines Corp.
  *   Author(s): Michael A. Halcrow <mahalcro@us.ibm.com>
  *              Michael C. Thompson <mcthomps@us.ibm.com>
  *              Tyler Hicks <tyhicks@ou.edu>
@@ -642,6 +642,11 @@ static struct ecryptfs_cache_info {
 		.size = PAGE_CACHE_SIZE,
 	},
 	{
+		.cache = &ecryptfs_xattr_cache,
+		.name = "ecryptfs_xattr_cache",
+		.size = PAGE_CACHE_SIZE,
+	},
+	{
 		.cache = &ecryptfs_lower_page_cache,
 		.name = "ecryptfs_lower_page_cache",
 		.size = PAGE_CACHE_SIZE,
diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index 0af3aa3..ba3650d 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -6,7 +6,7 @@
  *
  * Copyright (C) 1997-2003 Erez Zadok
  * Copyright (C) 2001-2003 Stony Brook University
- * Copyright (C) 2004-2006 International Business Machines Corp.
+ * Copyright (C) 2004-2007 International Business Machines Corp.
  *   Author(s): Michael A. Halcrow <mahalcro@us.ibm.com>
  *
  * This program is free software; you can redistribute it and/or
@@ -308,6 +308,9 @@ out:
 	return rc;
 }
 
+/**
+ * Called with lower inode mutex held.
+ */
 static int fill_zeros_to_end_of_page(struct page *page, unsigned int to)
 {
 	struct inode *inode = page->mapping->host;
@@ -407,10 +410,9 @@ static void ecryptfs_unmap_and_release_l
  *
  * Returns zero on success; non-zero on error.
  */
-int
-ecryptfs_write_inode_size_to_header(struct file *lower_file,
-				    struct inode *lower_inode,
-				    struct inode *inode)
+static int ecryptfs_write_inode_size_to_header(struct file *lower_file,
+					       struct inode *lower_inode,
+					       struct inode *inode)
 {
 	int rc = 0;
 	struct page *header_page;
@@ -442,6 +444,80 @@ out:
 	return rc;
 }
 
+static int ecryptfs_write_inode_size_to_xattr(struct inode *lower_inode,
+					      struct inode *inode,
+					      struct dentry *ecryptfs_dentry,
+					      int lower_i_mutex_held)
+{
+	ssize_t size;
+	void *xattr_virt;
+	struct dentry *lower_dentry;
+	u64 file_size;
+	int rc;
+
+	xattr_virt = kmem_cache_alloc(ecryptfs_xattr_cache, GFP_KERNEL);
+	if (!xattr_virt) {
+		printk(KERN_ERR "Out of memory whilst attempting to write "
+		       "inode size to xattr\n");
+		rc = -ENOMEM;
+		goto out;
+	}
+	lower_dentry = ecryptfs_dentry_to_lower(ecryptfs_dentry);
+	if (!lower_dentry->d_inode->i_op->getxattr) {
+		printk(KERN_WARNING
+		       "No support for setting xattr in lower filesystem\n");
+		rc = -ENOSYS;
+		kmem_cache_free(ecryptfs_xattr_cache, xattr_virt);
+		goto out;
+	}
+	if (!lower_i_mutex_held)
+		mutex_lock(&lower_dentry->d_inode->i_mutex);
+	size = lower_dentry->d_inode->i_op->getxattr(lower_dentry,
+						     ECRYPTFS_XATTR_NAME,
+						     xattr_virt,
+						     PAGE_CACHE_SIZE);
+	if (!lower_i_mutex_held)
+		mutex_unlock(&lower_dentry->d_inode->i_mutex);
+	if (size < 0)
+		size = 8;
+	file_size = (u64)i_size_read(inode);
+	file_size = cpu_to_be64(file_size);
+	memcpy(xattr_virt, &file_size, sizeof(u64));
+	if (!lower_i_mutex_held)
+		mutex_lock(&lower_dentry->d_inode->i_mutex);
+	rc = lower_dentry->d_inode->i_op->setxattr(lower_dentry,
+						   ECRYPTFS_XATTR_NAME,
+						   xattr_virt, size, 0);
+	if (!lower_i_mutex_held)
+		mutex_unlock(&lower_dentry->d_inode->i_mutex);
+	if (rc)
+		printk(KERN_ERR "Error whilst attempting to write inode size "
+		       "to lower file xattr; rc = [%d]\n", rc);
+	kmem_cache_free(ecryptfs_xattr_cache, xattr_virt);
+out:
+	return rc;
+}
+
+int
+ecryptfs_write_inode_size_to_metadata(struct file *lower_file,
+				      struct inode *lower_inode,
+				      struct inode *inode,
+				      struct dentry *ecryptfs_dentry,
+				      int lower_i_mutex_held)
+{
+	struct ecryptfs_crypt_stat *crypt_stat;
+
+	crypt_stat = &ecryptfs_inode_to_private(inode)->crypt_stat;
+	if (crypt_stat->flags & ECRYPTFS_METADATA_IN_XATTR)
+		return ecryptfs_write_inode_size_to_xattr(lower_inode, inode,
+							  ecryptfs_dentry,
+							  lower_i_mutex_held);
+	else
+		return ecryptfs_write_inode_size_to_header(lower_file,
+							   lower_inode,
+							   inode);
+}
+
 int ecryptfs_get_lower_page(struct page **lower_page, struct inode *lower_inode,
 			    struct file *lower_file,
 			    unsigned long lower_page_index, int byte_offset,
@@ -528,6 +604,8 @@ out:
 	return rc;
 }
 
+struct kmem_cache *ecryptfs_xattr_cache;
+
 /**
  * ecryptfs_commit_write
  * @file: The eCryptfs file object
@@ -581,7 +659,6 @@ static int ecryptfs_commit_write(struct 
 				"index [0x%.16x])\n", page->index);
 		goto out;
 	}
-	rc = 0;
 	inode->i_blocks = lower_inode->i_blocks;
 	pos = (page->index << PAGE_CACHE_SHIFT) + to;
 	if (pos > i_size_read(inode)) {
@@ -589,7 +666,12 @@ static int ecryptfs_commit_write(struct 
 		ecryptfs_printk(KERN_DEBUG, "Expanded file size to "
 				"[0x%.16x]\n", i_size_read(inode));
 	}
-	ecryptfs_write_inode_size_to_header(lower_file, lower_inode, inode);
+	rc = ecryptfs_write_inode_size_to_metadata(lower_file, lower_inode,
+						   inode, file->f_dentry,
+						   ECRYPTFS_LOWER_I_MUTEX_HELD);
+	if (rc)
+		printk(KERN_ERR "Error writing inode size to metadata; "
+		       "rc = [%d]\n", rc);
 	lower_inode->i_mtime = lower_inode->i_ctime = CURRENT_TIME;
 	mark_inode_dirty_sync(inode);
 out:
-- 
1.3.3

