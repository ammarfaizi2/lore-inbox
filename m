Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbWJMHlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbWJMHlY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 03:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWJMHlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 03:41:24 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:51144 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751305AbWJMHlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 03:41:23 -0400
Date: Fri, 13 Oct 2006 10:41:21 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, mhalcrow@us.ibm.com,
       phillip@hellewell.homeip.net
Subject: [PATCH] ecryptfs: superblock cleanups
Message-ID: <Pine.LNX.4.64.0610131040020.17802@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pekka Enberg <penberg@cs.helsinki.fi>

  - Use kmem_cache_zalloc for ecryptfs_sb_info in ecryptfs_fill_super
  - Kill useless ecryptfs_set_superblock_private wrapper
  - Rename ecryptfs_superblock_to_private to ecryptfs_sb for readability

Cc: Mike Halcrow <mhalcrow@us.ibm.com>
Cc: Phillip Hellewell <phillip@hellewell.homeip.net>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 fs/ecryptfs/crypto.c          |    5 ++---
 fs/ecryptfs/ecryptfs_kernel.h |   12 ++----------
 fs/ecryptfs/file.c            |    2 +-
 fs/ecryptfs/keystore.c        |    6 ++----
 fs/ecryptfs/main.c            |   12 +++++-------
 fs/ecryptfs/super.c           |    4 ++--
 6 files changed, 14 insertions(+), 27 deletions(-)

Index: 2.6/fs/ecryptfs/crypto.c
===================================================================
--- 2.6.orig/fs/ecryptfs/crypto.c
+++ 2.6/fs/ecryptfs/crypto.c
@@ -913,8 +913,7 @@ int ecryptfs_new_file_context(struct den
 	struct ecryptfs_crypt_stat *crypt_stat =
 	    &ecryptfs_inode_to_private(ecryptfs_dentry->d_inode)->crypt_stat;
 	struct ecryptfs_mount_crypt_stat *mount_crypt_stat =
-	    &ecryptfs_superblock_to_private(
-		    ecryptfs_dentry->d_sb)->mount_crypt_stat;
+	    &ecryptfs_sb(ecryptfs_dentry->d_sb)->mount_crypt_stat;
 	int cipher_name_len;
 
 	ecryptfs_set_default_crypt_stat_vals(crypt_stat, mount_crypt_stat);
@@ -1389,7 +1388,7 @@ static int ecryptfs_read_headers_virt(ch
 	int bytes_read;
 
 	ecryptfs_set_default_sizes(crypt_stat);
-	crypt_stat->mount_crypt_stat = &ecryptfs_superblock_to_private(
+	crypt_stat->mount_crypt_stat = &ecryptfs_sb(
 		ecryptfs_dentry->d_sb)->mount_crypt_stat;
 	offset = ECRYPTFS_FILE_SIZE_BYTES;
 	rc = contains_ecryptfs_marker(page_virt + offset);
Index: 2.6/fs/ecryptfs/ecryptfs_kernel.h
===================================================================
--- 2.6.orig/fs/ecryptfs/ecryptfs_kernel.h
+++ 2.6/fs/ecryptfs/ecryptfs_kernel.h
@@ -312,17 +312,9 @@ ecryptfs_set_inode_lower(struct inode *i
 	ecryptfs_inode_to_private(inode)->wii_inode = lower_inode;
 }
 
-static inline struct ecryptfs_sb_info *
-ecryptfs_superblock_to_private(struct super_block *sb)
+static inline struct ecryptfs_sb_info * ecryptfs_sb(struct super_block *sb)
 {
-	return (struct ecryptfs_sb_info *)sb->s_fs_info;
-}
-
-static inline void
-ecryptfs_set_superblock_private(struct super_block *sb,
-				struct ecryptfs_sb_info *sb_info)
-{
-	sb->s_fs_info = sb_info;
+	return sb->s_fs_info;
 }
 
 static inline struct super_block *
Index: 2.6/fs/ecryptfs/file.c
===================================================================
--- 2.6.orig/fs/ecryptfs/file.c
+++ 2.6/fs/ecryptfs/file.c
@@ -234,7 +234,7 @@ static int ecryptfs_open(struct inode *i
 	memset(file_info, 0, sizeof(*file_info));
 	lower_dentry = ecryptfs_dentry_to_lower(ecryptfs_dentry);
 	crypt_stat = &ecryptfs_inode_to_private(inode)->crypt_stat;
-	mount_crypt_stat = &ecryptfs_superblock_to_private(
+	mount_crypt_stat = &ecryptfs_sb(
 		ecryptfs_dentry->d_sb)->mount_crypt_stat;
 	mutex_lock(&crypt_stat->cs_mutex);
 	if (!ECRYPTFS_CHECK_FLAG(crypt_stat->flags, ECRYPTFS_POLICY_APPLIED)) {
Index: 2.6/fs/ecryptfs/keystore.c
===================================================================
--- 2.6.orig/fs/ecryptfs/keystore.c
+++ 2.6/fs/ecryptfs/keystore.c
@@ -584,8 +584,7 @@ int ecryptfs_parse_packet_set(struct ecr
 	struct list_head *walker;
 	struct ecryptfs_auth_tok *chosen_auth_tok = NULL;
 	struct ecryptfs_mount_crypt_stat *mount_crypt_stat =
-		&ecryptfs_superblock_to_private(
-			ecryptfs_dentry->d_sb)->mount_crypt_stat;
+		&ecryptfs_sb(ecryptfs_dentry->d_sb)->mount_crypt_stat;
 	struct ecryptfs_auth_tok *candidate_auth_tok = NULL;
 	size_t packet_size;
 	struct ecryptfs_auth_tok *new_auth_tok;
@@ -1002,8 +1001,7 @@ ecryptfs_generate_key_packet_set(char *d
 	int rc = 0;
 	struct ecryptfs_auth_tok *auth_tok;
 	struct ecryptfs_mount_crypt_stat *mount_crypt_stat =
-		&ecryptfs_superblock_to_private(
-			ecryptfs_dentry->d_sb)->mount_crypt_stat;
+		&ecryptfs_sb(ecryptfs_dentry->d_sb)->mount_crypt_stat;
 	size_t written;
 	struct ecryptfs_key_record key_rec;
 
Index: 2.6/fs/ecryptfs/main.c
===================================================================
--- 2.6.orig/fs/ecryptfs/main.c
+++ 2.6/fs/ecryptfs/main.c
@@ -202,7 +202,7 @@ static int ecryptfs_parse_options(struct
 	struct key *auth_tok_key = NULL;
 	struct ecryptfs_auth_tok *auth_tok = NULL;
 	struct ecryptfs_mount_crypt_stat *mount_crypt_stat =
-		&ecryptfs_superblock_to_private(sb)->mount_crypt_stat;
+		&ecryptfs_sb(sb)->mount_crypt_stat;
 	substring_t args[MAX_OPT_ARGS];
 	int token;
 	char *sig_src;
@@ -383,19 +383,17 @@ struct kmem_cache *ecryptfs_sb_info_cach
 static int
 ecryptfs_fill_super(struct super_block *sb, void *raw_data, int silent)
 {
+	struct ecryptfs_sb_info *sb_info;
 	int rc = 0;
 
 	/* Released in ecryptfs_put_super() */
-	ecryptfs_set_superblock_private(sb,
-					kmem_cache_alloc(ecryptfs_sb_info_cache,
-							 SLAB_KERNEL));
-	if (!ecryptfs_superblock_to_private(sb)) {
+	sb_info = kmem_cache_zalloc(ecryptfs_sb_info_cache, GFP_KERNEL);
+	if (!sb_info) {
 		ecryptfs_printk(KERN_WARNING, "Out of memory\n");
 		rc = -ENOMEM;
 		goto out;
 	}
-	memset(ecryptfs_superblock_to_private(sb), 0,
-	       sizeof(struct ecryptfs_sb_info));
+	sb->s_fs_info = sb_info;
 	sb->s_op = &ecryptfs_sops;
 	/* Released through deactivate_super(sb) from get_sb_nodev */
 	sb->s_root = d_alloc(NULL, &(const struct qstr) {
Index: 2.6/fs/ecryptfs/super.c
===================================================================
--- 2.6.orig/fs/ecryptfs/super.c
+++ 2.6/fs/ecryptfs/super.c
@@ -102,11 +102,11 @@ void ecryptfs_init_inode(struct inode *i
  */
 static void ecryptfs_put_super(struct super_block *sb)
 {
-	struct ecryptfs_sb_info *sb_info = ecryptfs_superblock_to_private(sb);
+	struct ecryptfs_sb_info *sb_info = ecryptfs_sb(sb);
 
 	ecryptfs_destruct_mount_crypt_stat(&sb_info->mount_crypt_stat);
 	kmem_cache_free(ecryptfs_sb_info_cache, sb_info);
-	ecryptfs_set_superblock_private(sb, NULL);
+	sb->s_fs_info = NULL;
 }
 
 /**
