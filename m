Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbWEZOXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWEZOXk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 10:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbWEZOWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 10:22:21 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:973 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750785AbWEZOV6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 10:21:58 -0400
In-reply-to: <20060526142117.GA2764@us.ibm.com>
From: Mike Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>,
       Mike Halcrow <mhalcrow@us.ibm.com>, Mike Halcrow <mike@halcrow.us>
Subject: [PATCH 1/10] Convert ASSERT to BUG_ON
Message-Id: <E1FjdCG-000335-IS@localhost.localdomain>
Date: Fri, 26 May 2006 09:21:48 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use the kernel BUG_ON() macro rather than the eCryptfs ASSERT(). Note
that this temporarily renders the CONFIG_ECRYPT_DEBUG build option
unused. We certainly plan on using it in the future; for now, is it
okay to leave it in fs/Kconfig, or would you like to remove it?

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/crypto.c          |   16 ++++++++--------
 fs/ecryptfs/ecryptfs_kernel.h |   17 -----------------
 fs/ecryptfs/file.c            |    4 ++--
 fs/ecryptfs/inode.c           |   18 +++++++++---------
 fs/ecryptfs/keystore.c        |    2 +-
 fs/ecryptfs/mmap.c            |    8 ++++----
 6 files changed, 24 insertions(+), 41 deletions(-)

acfbd08111d5f3d1f0aff5064791f86260899aeb
diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 809d9f5..49b7eb3 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -245,9 +245,9 @@ static int encrypt_scatterlist(struct ec
 {
 	int rc = 0;
 
-	ASSERT(crypt_stat && crypt_stat->tfm
-	       && ECRYPTFS_CHECK_FLAG(crypt_stat->flags,
-				      ECRYPTFS_STRUCT_INITIALIZED));
+	BUG_ON(!crypt_stat || !crypt_stat->tfm
+	       || !ECRYPTFS_CHECK_FLAG(crypt_stat->flags,
+				       ECRYPTFS_STRUCT_INITIALIZED));
 	if (unlikely(ecryptfs_verbosity > 0)) {
 		ecryptfs_printk(KERN_DEBUG, "Key size [%d]; key:\n",
 				crypt_stat->key_size_bits / 8);
@@ -467,8 +467,8 @@ #define ECRYPTFS_PAGE_STATE_WRITTEN   3
 			prior_lower_page_idx = lower_page_idx;
 			page_state = ECRYPTFS_PAGE_STATE_READ;
 		}
-		ASSERT(page_state == ECRYPTFS_PAGE_STATE_MODIFIED
-		       || page_state == ECRYPTFS_PAGE_STATE_READ);
+		BUG_ON(!(page_state == ECRYPTFS_PAGE_STATE_MODIFIED
+			 || page_state == ECRYPTFS_PAGE_STATE_READ));
 		rc = ecryptfs_derive_iv(extent_iv, crypt_stat,
 					(base_extent + extent_offset));
 		if (rc) {
@@ -505,7 +505,7 @@ #define ECRYPTFS_PAGE_STATE_WRITTEN   3
 		page_state = ECRYPTFS_PAGE_STATE_MODIFIED;
 		extent_offset++;
 	}
-	ASSERT(orig_byte_offset == 0);
+	BUG_ON(orig_byte_offset != 0);
 	rc = ecryptfs_write_out_page(ctx, lower_page, lower_inode, 0,
 				     (lower_byte_offset
 				      + crypt_stat->extent_size));
@@ -792,8 +792,8 @@ int ecryptfs_compute_root_iv(struct ecry
 	int rc = 0;
 	char dst[MD5_DIGEST_SIZE];
 
-	ASSERT(crypt_stat->iv_bytes <= MD5_DIGEST_SIZE);
-	ASSERT(crypt_stat->iv_bytes > 0);
+	BUG_ON(crypt_stat->iv_bytes > MD5_DIGEST_SIZE);
+	BUG_ON(crypt_stat->iv_bytes <= 0);
 	if (!ECRYPTFS_CHECK_FLAG(crypt_stat->flags, ECRYPTFS_KEY_VALID)) {
 		rc = -EINVAL;
 		ecryptfs_printk(KERN_WARNING, "Session key not valid; "
diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index b58e515..14b3f99 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -26,10 +26,6 @@
 #ifndef ECRYPTFS_KERNEL_H
 #define ECRYPTFS_KERNEL_H
 
-#ifdef CONFIG_ECRYPT_DEBUG
-#define OBSERVE_ASSERTS 1
-#endif
-
 #include <keys/user-type.h>
 #include <linux/fs.h>
 #include <asm/semaphore.h>
@@ -259,19 +255,6 @@ struct ecryptfs_auth_tok_list_item {
 	struct ecryptfs_auth_tok auth_tok;
 };
 
-#ifdef OBSERVE_ASSERTS
-#define ASSERT(EX)	                                                      \
-do {	                                                                      \
-        if (unlikely(!(EX))) {                                                \
-	        printk(KERN_CRIT "ASSERTION FAILED: %s at %s:%d (%s)\n", #EX, \
-	               __FILE__, __LINE__, __FUNCTION__);	              \
-                BUG();                                                        \
-        }	                                                              \
-} while (0)
-#else
-#define ASSERT(EX) do { /* nothing */ } while (0)
-#endif /* OBSERVE_ASSERTS */
-
 static inline struct ecryptfs_file_info *
 ecryptfs_file_to_private(struct file *file)
 {
diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
index cb03aee..ef7d7fa 100644
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -530,7 +530,7 @@ static int ecryptfs_lock(struct file *fi
 
 	if (ecryptfs_file_to_private(file))
 		lower_file = ecryptfs_file_to_lower(file);
-	ASSERT(lower_file);
+	BUG_ON(!lower_file);
 	rc = -EINVAL;
 	if (!fl)
 		goto out;
@@ -560,7 +560,7 @@ static ssize_t ecryptfs_sendfile(struct 
 
 	if (ecryptfs_file_to_private(file))
 		lower_file = ecryptfs_file_to_lower(file);
-	ASSERT(lower_file);
+	BUG_ON(!lower_file);
 	if (lower_file->f_op && lower_file->f_op->sendfile)
 		rc = lower_file->f_op->sendfile(lower_file, ppos, count,
 						actor, target);
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 3505dd7..c24b043 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -61,15 +61,15 @@ void ecryptfs_copy_inode_size(struct ino
 
 void ecryptfs_copy_attr_atime(struct inode *dest, const struct inode *src)
 {
-	ASSERT(dest != NULL);
-	ASSERT(src != NULL);
+	BUG_ON(!dest);
+	BUG_ON(!src);
 	dest->i_atime = src->i_atime;
 }
 
 void ecryptfs_copy_attr_times(struct inode *dest, const struct inode *src)
 {
-	ASSERT(dest != NULL);
-	ASSERT(src != NULL);
+	BUG_ON(!dest);
+	BUG_ON(!src);
 	dest->i_atime = src->i_atime;
 	dest->i_mtime = src->i_mtime;
 	dest->i_ctime = src->i_ctime;
@@ -78,8 +78,8 @@ void ecryptfs_copy_attr_times(struct ino
 static void ecryptfs_copy_attr_timesizes(struct inode *dest,
 					 const struct inode *src)
 {
-	ASSERT(dest != NULL);
-	ASSERT(src != NULL);
+	BUG_ON(!dest);
+	BUG_ON(!src);
 	dest->i_atime = src->i_atime;
 	dest->i_mtime = src->i_mtime;
 	dest->i_ctime = src->i_ctime;
@@ -88,8 +88,8 @@ static void ecryptfs_copy_attr_timesizes
 
 void ecryptfs_copy_attr_all(struct inode *dest, const struct inode *src)
 {
-	ASSERT(dest != NULL);
-	ASSERT(src != NULL);
+	BUG_ON(!dest);
+	BUG_ON(!src);
 	dest->i_mode = src->i_mode;
 	dest->i_nlink = src->i_nlink;
 	dest->i_uid = src->i_uid;
@@ -392,7 +392,7 @@ static struct dentry *ecryptfs_lookup(st
 		lower_dentry->d_name.name);
 	lower_inode = lower_dentry->d_inode;
 	ecryptfs_copy_attr_atime(dir, lower_dir_dentry->d_inode);
-	ASSERT(atomic_read(&lower_dentry->d_count));
+	BUG_ON(!atomic_read(&lower_dentry->d_count));
 	ecryptfs_set_dentry_private(dentry,
 				    kmem_cache_alloc(ecryptfs_dentry_info_cache,
 						     SLAB_KERNEL));
diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index 19ba826..7c5ac0d 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -506,7 +506,7 @@ static int decrypt_session_key(struct ec
 	       auth_tok->session_key.encrypted_key_size);
 	src_sg[0].page = virt_to_page(encrypted_session_key);
 	src_sg[0].offset = 0;
-	ASSERT(auth_tok->session_key.encrypted_key_size < PAGE_CACHE_SIZE);
+	BUG_ON(auth_tok->session_key.encrypted_key_size > PAGE_CACHE_SIZE);
 	src_sg[0].length = auth_tok->session_key.encrypted_key_size;
 	dst_sg[0].page = virt_to_page(session_key);
 	dst_sg[0].offset = 0;
diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index 58f5e12..0c0411a 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -280,7 +280,7 @@ static int ecryptfs_readpage(struct file
 	int rc = 0;
 	struct ecryptfs_crypt_stat *crypt_stat;
 
-	ASSERT(file && file->f_dentry && file->f_dentry->d_inode);
+	BUG_ON(!(file && file->f_dentry && file->f_dentry->d_inode));
 	crypt_stat =
 		&ecryptfs_inode_to_private(file->f_dentry->d_inode)->crypt_stat;
 	if (!crypt_stat
@@ -553,7 +553,7 @@ process_new_file(struct ecryptfs_crypt_s
 	header_pages = ((crypt_stat->header_extent_size
 			 * crypt_stat->num_header_extents_at_front)
 			/ PAGE_CACHE_SIZE);
-	ASSERT(header_pages >= 1);
+	BUG_ON(header_pages < 1);
 	while (current_header_page < header_pages) {
 		rc = ecryptfs_grab_and_map_lower_page(&header_page,
 						      &header_virt,
@@ -646,8 +646,8 @@ static int ecryptfs_commit_write(struct 
 	mutex_lock(&lower_inode->i_mutex);
 	crypt_stat =
 		&ecryptfs_inode_to_private(file->f_dentry->d_inode)->crypt_stat;
-	ASSERT(crypt_stat);
-	ASSERT(lower_file);
+	BUG_ON(!crypt_stat);
+	BUG_ON(!lower_file);
 	if (ECRYPTFS_CHECK_FLAG(crypt_stat->flags, ECRYPTFS_NEW_FILE)) {
 		ecryptfs_printk(KERN_DEBUG, "ECRYPTFS_NEW_FILE flag set in "
 			"crypt_stat at memory location [%p]\n", crypt_stat);
-- 
1.3.3

