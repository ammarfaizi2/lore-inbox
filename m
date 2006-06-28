Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751458AbWF1Q7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbWF1Q7T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 12:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbWF1Q6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 12:58:13 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:45572 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751462AbWF1Qz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 12:55:26 -0400
Date: Wed, 28 Jun 2006 18:55:25 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>,
       Phillip Hellewell <phillip@hellewell.homeip.net>
Cc: linux-kernel@vger.kernel.org, Michael Halcrow <mhalcrow@us.ibm.com>
Subject: [-mm patch] fs/ecryptfs/: possible cleanups
Message-ID: <20060628165525.GG13915@stusta.de>
References: <20060627015211.ce480da6.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060627015211.ce480da6.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make needlessly global functions static
- there's usually no reason for functions in C files to be marked as
  inline - gcc usually knows best whether or not to inline a function

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

BTW: please add a MAINTAINERS entry

 fs/ecryptfs/crypto.c          |   53 +++++++++++++++++++++-------------
 fs/ecryptfs/ecryptfs_kernel.h |   15 ---------
 fs/ecryptfs/inode.c           |   11 +++----
 fs/ecryptfs/keystore.c        |    2 -
 fs/ecryptfs/main.c            |    4 +-
 fs/ecryptfs/mmap.c            |    2 -
 fs/ecryptfs/super.c           |    4 +-
 7 files changed, 46 insertions(+), 45 deletions(-)

--- linux-2.6.17-mm3-full/fs/ecryptfs/ecryptfs_kernel.h.old	2006-06-27 22:54:03.000000000 +0200
+++ linux-2.6.17-mm3-full/fs/ecryptfs/ecryptfs_kernel.h	2006-06-27 22:59:14.000000000 +0200
@@ -398,17 +398,12 @@
 			     const char *name, int length,
 			     char **encoded_name);
 struct dentry *ecryptfs_lower_dentry(struct dentry *this_dentry);
-void ecryptfs_copy_attr_times(struct inode *dest, const struct inode *src);
 void ecryptfs_copy_attr_atime(struct inode *dest, const struct inode *src);
 void ecryptfs_copy_attr_all(struct inode *dest, const struct inode *src);
 void ecryptfs_copy_inode_size(struct inode *dst, const struct inode *src);
 void ecryptfs_dump_hex(char *data, int bytes);
 int virt_to_scatterlist(const void *addr, int size, struct scatterlist *sg,
 			int sg_size);
-int ecryptfs_calculate_md5(char *dst, struct ecryptfs_crypt_stat *crypt_stat,
-			   char *src, int len);
-int ecryptfs_derive_iv(char *iv, struct ecryptfs_crypt_stat *crypt_stat,
-		       pgoff_t offset);
 int ecryptfs_compute_root_iv(struct ecryptfs_crypt_stat *crypt_stat);
 void ecryptfs_rotate_iv(unsigned char *iv);
 void ecryptfs_init_crypt_stat(struct ecryptfs_crypt_stat *crypt_stat);
@@ -439,17 +434,7 @@
 					      struct inode *lower_inode,
 					      struct writeback_control *wbc);
 int ecryptfs_encrypt_page(struct ecryptfs_page_crypt_context *ctx);
-int
-ecryptfs_encrypt_page_offset(struct ecryptfs_crypt_stat *crypt_stat,
-			     struct page *dst_page, int dst_offset,
-			     struct page *src_page, int src_offset, int size,
-			     unsigned char *iv);
 int ecryptfs_decrypt_page(struct file *file, struct page *page);
-int
-ecryptfs_decrypt_page_offset(struct ecryptfs_crypt_stat *crypt_stat,
-			     struct page *dst_page, int dst_offset,
-			     struct page *src_page, int src_offset, int size,
-			     unsigned char *iv);
 int ecryptfs_write_headers(struct dentry *ecryptfs_dentry,
 			   struct file *lower_file);
 int ecryptfs_write_headers_virt(char *page_virt,
--- linux-2.6.17-mm3-full/fs/ecryptfs/crypto.c.old	2006-06-27 22:54:18.000000000 +0200
+++ linux-2.6.17-mm3-full/fs/ecryptfs/crypto.c	2006-06-27 23:01:53.000000000 +0200
@@ -35,6 +35,17 @@
 #include <linux/scatterlist.h>
 #include "ecryptfs_kernel.h"
 
+static int
+ecryptfs_decrypt_page_offset(struct ecryptfs_crypt_stat *crypt_stat,
+			     struct page *dst_page, int dst_offset,
+			     struct page *src_page, int src_offset, int size,
+			     unsigned char *iv);
+static int
+ecryptfs_encrypt_page_offset(struct ecryptfs_crypt_stat *crypt_stat,
+			     struct page *dst_page, int dst_offset,
+			     struct page *src_page, int src_offset, int size,
+			     unsigned char *iv);
+
 /**
  * ecryptfs_to_hex
  * @dst: Buffer to take hex character representation of contents of
@@ -42,7 +53,7 @@
  * @src: Buffer to be converted to a hex string respresentation
  * @src_size: number of bytes to convert
  */
-inline void ecryptfs_to_hex(char *dst, char *src, int src_size)
+void ecryptfs_to_hex(char *dst, char *src, int src_size)
 {
 	int x;
 
@@ -57,7 +68,7 @@
  * @src: Buffer to be converted from a hex string respresentation to raw value
  * @dst_size: size of dst buffer, or number of hex characters pairs to convert
  */
-inline void ecryptfs_from_hex(char *dst, char *src, int dst_size)
+void ecryptfs_from_hex(char *dst, char *src, int dst_size)
 {
 	int x;
 	char tmp[3] = { 0, };
@@ -79,8 +90,9 @@
  * Uses the allocated crypto context that crypt_stat references to
  * generate the MD5 sum of the contents of src.
  */
-int ecryptfs_calculate_md5(char *dst, struct ecryptfs_crypt_stat *crypt_stat,
-			   char *src, int len)
+static int ecryptfs_calculate_md5(char *dst,
+				  struct ecryptfs_crypt_stat *crypt_stat,
+				  char *src, int len)
 {
 	int rc = 0;
 	struct scatterlist sg;
@@ -114,8 +126,8 @@
  *
  * Returns zero on success; non-zero on error.
  */
-int ecryptfs_derive_iv(char *iv, struct ecryptfs_crypt_stat *crypt_stat,
-		       pgoff_t offset)
+static int ecryptfs_derive_iv(char *iv, struct ecryptfs_crypt_stat *crypt_stat,
+			      pgoff_t offset)
 {
 	int rc = 0;
 	char dst[MD5_DIGEST_SIZE];
@@ -284,7 +296,7 @@
 	return rc;
 }
 
-void
+static void
 ecryptfs_extent_to_lwr_pg_idx_and_offset(unsigned long *lower_page_idx,
 					 int *byte_offset,
 					 struct ecryptfs_crypt_stat *crypt_stat,
@@ -326,9 +338,10 @@
 			(*byte_offset));
 }
 
-int ecryptfs_write_out_page(struct ecryptfs_page_crypt_context *ctx,
-			    struct page *lower_page, struct inode *lower_inode,
-			    int byte_offset_in_page, int bytes_to_write)
+static int ecryptfs_write_out_page(struct ecryptfs_page_crypt_context *ctx,
+				   struct page *lower_page,
+				   struct inode *lower_inode,
+				   int byte_offset_in_page, int bytes_to_write)
 {
 	int rc = 0;
 
@@ -356,9 +369,11 @@
 	return rc;
 }
 
-int ecryptfs_read_in_page(struct ecryptfs_page_crypt_context *ctx,
-			  struct page **lower_page, struct inode *lower_inode,
-			  unsigned long lower_page_idx, int byte_offset_in_page)
+static int ecryptfs_read_in_page(struct ecryptfs_page_crypt_context *ctx,
+				 struct page **lower_page,
+				 struct inode *lower_inode,
+				 unsigned long lower_page_idx,
+				 int byte_offset_in_page)
 {
 	int rc = 0;
 
@@ -690,7 +705,7 @@
  *
  * Returns the number of bytes encrypted
  */
-int
+static int
 ecryptfs_encrypt_page_offset(struct ecryptfs_crypt_stat *crypt_stat,
 			     struct page *dst_page, int dst_offset,
 			     struct page *src_page, int src_offset, int size,
@@ -712,7 +727,7 @@
  *
  * Returns the number of bytes decrypted
  */
-int
+static int
 ecryptfs_decrypt_page_offset(struct ecryptfs_crypt_stat *crypt_stat,
 			     struct page *dst_page, int dst_offset,
 			     struct page *src_page, int src_offset, int size,
@@ -1348,7 +1363,7 @@
  * compatibility for files created with the prior versions of
  * eCryptfs.
  */
-inline void set_default_header_data(struct ecryptfs_crypt_stat *crypt_stat)
+static void set_default_header_data(struct ecryptfs_crypt_stat *crypt_stat)
 {
 	crypt_stat->header_extent_size = 4096;
 	crypt_stat->num_header_extents_at_front = 1;
@@ -1362,9 +1377,9 @@
  *
  * Returns zero on success
  */
-int ecryptfs_read_headers_virt(char *page_virt,
-			       struct ecryptfs_crypt_stat *crypt_stat,
-			       struct dentry *ecryptfs_dentry)
+static int ecryptfs_read_headers_virt(char *page_virt,
+				      struct ecryptfs_crypt_stat *crypt_stat,
+				      struct dentry *ecryptfs_dentry)
 {
 	int rc = 0;
 	int offset;
--- linux-2.6.17-mm3-full/fs/ecryptfs/inode.c.old	2006-06-27 22:59:31.000000000 +0200
+++ linux-2.6.17-mm3-full/fs/ecryptfs/inode.c	2006-06-27 23:02:12.000000000 +0200
@@ -32,7 +32,7 @@
 #include <linux/crypto.h>
 #include "ecryptfs_kernel.h"
 
-static inline struct dentry *lock_parent(struct dentry *dentry)
+static struct dentry *lock_parent(struct dentry *dentry)
 {
 	struct dentry *dir;
 
@@ -41,13 +41,13 @@
 	return dir;
 }
 
-static inline void unlock_parent(struct dentry *dentry)
+static void unlock_parent(struct dentry *dentry)
 {
 	mutex_unlock(&(dentry->d_parent->d_inode->i_mutex));
 	dput(dentry->d_parent);
 }
 
-static inline void unlock_dir(struct dentry *dir)
+static void unlock_dir(struct dentry *dir)
 {
 	mutex_unlock(&dir->d_inode->i_mutex);
 	dput(dir);
@@ -66,7 +66,8 @@
 	dest->i_atime = src->i_atime;
 }
 
-void ecryptfs_copy_attr_times(struct inode *dest, const struct inode *src)
+static void ecryptfs_copy_attr_times(struct inode *dest,
+				     const struct inode *src)
 {
 	BUG_ON(!dest);
 	BUG_ON(!src);
@@ -755,7 +756,7 @@
 	return ERR_PTR(rc);
 }
 
-static inline void
+static void
 ecryptfs_put_link(struct dentry *dentry, struct nameidata *nd, void *ptr)
 {
 	/* Free the char* */
--- linux-2.6.17-mm3-full/fs/ecryptfs/keystore.c.old	2006-06-27 23:00:04.000000000 +0200
+++ linux-2.6.17-mm3-full/fs/ecryptfs/keystore.c	2006-06-27 23:00:12.000000000 +0200
@@ -741,7 +741,7 @@
  *
  * Returns zero on success; non-zero on error.
  */
-int
+static int
 write_tag_11_packet(char *dest, int max, char *contents, int contents_length,
 		    int *packet_length)
 {
--- linux-2.6.17-mm3-full/fs/ecryptfs/main.c.old	2006-06-27 23:00:27.000000000 +0200
+++ linux-2.6.17-mm3-full/fs/ecryptfs/main.c	2006-06-27 23:02:27.000000000 +0200
@@ -148,7 +148,7 @@
  *
  * Returns zero on good version; non-zero otherwise
  */
-int ecryptfs_verify_version(u16 version)
+static int ecryptfs_verify_version(u16 version)
 {
 	int rc = 0;
 	unsigned char major;
@@ -374,7 +374,7 @@
  *
  * Preform the cleanup for ecryptfs_read_super()
  */
-static inline void ecryptfs_cleanup_read_super(struct super_block *sb)
+static void ecryptfs_cleanup_read_super(struct super_block *sb)
 {
 	up_write(&sb->s_umount);
 	deactivate_super(sb);
--- linux-2.6.17-mm3-full/fs/ecryptfs/mmap.c.old	2006-06-27 23:00:49.000000000 +0200
+++ linux-2.6.17-mm3-full/fs/ecryptfs/mmap.c	2006-06-27 23:01:06.000000000 +0200
@@ -391,7 +391,7 @@
 	return rc;
 }
 
-void ecryptfs_unmap_and_release_lower_page(struct page *lower_page)
+static void ecryptfs_unmap_and_release_lower_page(struct page *lower_page)
 {
 	kunmap(lower_page);
 	ecryptfs_printk(KERN_DEBUG, "Unlocking lower page with index = "
--- linux-2.6.17-mm3-full/fs/ecryptfs/super.c.old	2006-06-27 23:02:40.000000000 +0200
+++ linux-2.6.17-mm3-full/fs/ecryptfs/super.c	2006-06-27 23:02:47.000000000 +0200
@@ -122,7 +122,7 @@
  * Get the filesystem statistics. Currently, we let this pass right through
  * to the lower filesystem and take no action ourselves.
  */
-static inline int ecryptfs_statfs(struct dentry *dentry, struct kstatfs *buf)
+static int ecryptfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
 	return vfs_statfs(ecryptfs_dentry_to_lower(dentry), buf);
 }
@@ -137,7 +137,7 @@
  * on the inode free list. We use this to drop out reference to the
  * lower inode.
  */
-static inline void ecryptfs_clear_inode(struct inode *inode)
+static void ecryptfs_clear_inode(struct inode *inode)
 {
 	iput(ecryptfs_inode_to_lower(inode));
 }

