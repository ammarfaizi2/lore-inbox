Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261261AbVAGBbT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbVAGBbT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 20:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVAGB3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 20:29:11 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:12806 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261276AbVAGB0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 20:26:23 -0500
Date: Fri, 7 Jan 2005 02:26:15 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/hfsplus/: misc cleanups
Message-ID: <20050107012615.GB14108@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below contains the following cleanups:
- make needlessly global code static
- bnode.c: remove the unused global functions hfsplus_lock_bnode and
           hfsplus_unlock_bnode


diffstat output:
 fs/hfsplus/bnode.c      |   11 -----------
 fs/hfsplus/brec.c       |   15 ++++++++++++---
 fs/hfsplus/dir.c        |   23 +++++++++++++----------
 fs/hfsplus/extents.c    |    9 +++++----
 fs/hfsplus/hfsplus_fs.h |    7 -------
 fs/hfsplus/inode.c      |    6 +++---
 fs/hfsplus/super.c      |    4 ++--
 7 files changed, 35 insertions(+), 40 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-mm2-full/fs/hfsplus/bnode.c.old	2005-01-07 00:37:53.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/hfsplus/bnode.c	2005-01-07 00:38:24.000000000 +0100
@@ -648,14 +648,3 @@
 	}
 }
 
-void hfsplus_lock_bnode(struct hfs_bnode *node)
-{
-	wait_event(node->lock_wq, !test_and_set_bit(HFS_BNODE_LOCK, &node->flags));
-}
-
-void hfsplus_unlock_bnode(struct hfs_bnode *node)
-{
-	clear_bit(HFS_BNODE_LOCK, &node->flags);
-	if (waitqueue_active(&node->lock_wq))
-		wake_up(&node->lock_wq);
-}
--- linux-2.6.10-mm2-full/fs/hfsplus/hfsplus_fs.h.old	2005-01-07 00:39:41.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/hfsplus/hfsplus_fs.h	2005-01-07 00:46:44.000000000 +0100
@@ -230,9 +230,6 @@
 #define hfs_brec_keylen hfsplus_brec_keylen
 #define hfs_brec_insert hfsplus_brec_insert
 #define hfs_brec_remove hfsplus_brec_remove
-#define hfs_bnode_split hfsplus_bnode_split
-#define hfs_brec_update_parent hfsplus_brec_update_parent
-#define hfs_btree_inc_height hfsplus_btree_inc_height
 #define hfs_find_init hfsplus_find_init
 #define hfs_find_exit hfsplus_find_exit
 #define __hfs_brec_find __hplusfs_brec_find
@@ -297,9 +294,6 @@
 u16 hfs_brec_keylen(struct hfs_bnode *, u16);
 int hfs_brec_insert(struct hfs_find_data *, void *, int);
 int hfs_brec_remove(struct hfs_find_data *);
-struct hfs_bnode *hfs_bnode_split(struct hfs_find_data *);
-int hfs_brec_update_parent(struct hfs_find_data *);
-int hfs_btree_inc_height(struct hfs_btree *);
 
 /* bfind.c */
 int hfs_find_init(struct hfs_btree *, struct hfs_find_data *);
@@ -320,7 +314,6 @@
 
 /* extents.c */
 int hfsplus_ext_cmp_key(hfsplus_btree_key *, hfsplus_btree_key *);
-void hfsplus_ext_build_key(hfsplus_btree_key *, u32, u32, u8);
 void hfsplus_ext_write_extent(struct inode *);
 int hfsplus_get_block(struct inode *, sector_t, struct buffer_head *, int);
 int hfsplus_free_fork(struct super_block *, u32, struct hfsplus_fork_raw *, int);
--- linux-2.6.10-mm2-full/fs/hfsplus/brec.c.old	2005-01-07 00:40:46.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/hfsplus/brec.c	2005-01-07 00:43:31.000000000 +0100
@@ -11,6 +11,15 @@
 #include "hfsplus_fs.h"
 #include "hfsplus_raw.h"
 
+#define hfs_bnode_split hfsplus_bnode_split
+static struct hfs_bnode *hfs_bnode_split(struct hfs_find_data *fd);
+
+#define hfs_brec_update_parent hfsplus_brec_update_parent
+static int hfs_brec_update_parent(struct hfs_find_data *fd);
+
+#define hfs_btree_inc_height hfsplus_btree_inc_height
+static int hfs_btree_inc_height(struct hfs_btree *);
+
 /* Get the length and offset of the given record in the given node */
 u16 hfs_brec_lenoff(struct hfs_bnode *node, u16 rec, u16 *off)
 {
@@ -209,7 +218,7 @@
 	return 0;
 }
 
-struct hfs_bnode *hfs_bnode_split(struct hfs_find_data *fd)
+static struct hfs_bnode *hfs_bnode_split(struct hfs_find_data *fd)
 {
 	struct hfs_btree *tree;
 	struct hfs_bnode *node, *new_node;
@@ -318,7 +327,7 @@
 	return new_node;
 }
 
-int hfs_brec_update_parent(struct hfs_find_data *fd)
+static int hfs_brec_update_parent(struct hfs_find_data *fd)
 {
 	struct hfs_btree *tree;
 	struct hfs_bnode *node, *new_node, *parent;
@@ -414,7 +423,7 @@
 	return 0;
 }
 
-int hfs_btree_inc_height(struct hfs_btree *tree)
+static int hfs_btree_inc_height(struct hfs_btree *tree)
 {
 	struct hfs_bnode *node, *new_node;
 	struct hfs_bnode_desc node_desc;
--- linux-2.6.10-mm2-full/fs/hfsplus/dir.c.old	2005-01-07 00:44:00.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/hfsplus/dir.c	2005-01-07 00:46:21.000000000 +0100
@@ -228,8 +228,8 @@
 	return 0;
 }
 
-int hfsplus_create(struct inode *dir, struct dentry *dentry, int mode,
-		   struct nameidata *nd)
+static int hfsplus_create(struct inode *dir, struct dentry *dentry, int mode,
+			  struct nameidata *nd)
 {
 	struct inode *inode;
 	int res;
@@ -250,7 +250,8 @@
 	return 0;
 }
 
-int hfsplus_link(struct dentry *src_dentry, struct inode *dst_dir, struct dentry *dst_dentry)
+static int hfsplus_link(struct dentry *src_dentry, struct inode *dst_dir, 
+			struct dentry *dst_dentry)
 {
 	struct super_block *sb = dst_dir->i_sb;
 	struct inode *inode = src_dentry->d_inode;
@@ -302,7 +303,7 @@
 	return 0;
 }
 
-int hfsplus_unlink(struct inode *dir, struct dentry *dentry)
+static int hfsplus_unlink(struct inode *dir, struct dentry *dentry)
 {
 	struct super_block *sb = dir->i_sb;
 	struct inode *inode = dentry->d_inode;
@@ -346,7 +347,7 @@
 	return res;
 }
 
-int hfsplus_mkdir(struct inode *dir, struct dentry *dentry, int mode)
+static int hfsplus_mkdir(struct inode *dir, struct dentry *dentry, int mode)
 {
 	struct inode *inode;
 	int res;
@@ -367,7 +368,7 @@
 	return 0;
 }
 
-int hfsplus_rmdir(struct inode *dir, struct dentry *dentry)
+static int hfsplus_rmdir(struct inode *dir, struct dentry *dentry)
 {
 	struct inode *inode;
 	int res;
@@ -385,7 +386,8 @@
 	return 0;
 }
 
-int hfsplus_symlink(struct inode *dir, struct dentry *dentry, const char *symname)
+static int hfsplus_symlink(struct inode *dir, struct dentry *dentry,
+			   const char *symname)
 {
 	struct super_block *sb;
 	struct inode *inode;
@@ -415,7 +417,8 @@
 	return res;
 }
 
-int hfsplus_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t rdev)
+static int hfsplus_mknod(struct inode *dir, struct dentry *dentry,
+			 int mode, dev_t rdev)
 {
 	struct super_block *sb;
 	struct inode *inode;
@@ -440,8 +443,8 @@
 	return 0;
 }
 
-int hfsplus_rename(struct inode *old_dir, struct dentry *old_dentry,
-		   struct inode *new_dir, struct dentry *new_dentry)
+static int hfsplus_rename(struct inode *old_dir, struct dentry *old_dentry,
+			  struct inode *new_dir, struct dentry *new_dentry)
 {
 	int res;
 
--- linux-2.6.10-mm2-full/fs/hfsplus/extents.c.old	2005-01-07 00:46:52.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/hfsplus/extents.c	2005-01-07 00:47:22.000000000 +0100
@@ -37,8 +37,8 @@
 	return be32_to_cpu(k1s) < be32_to_cpu(k2s) ? -1 : 1;
 }
 
-void hfsplus_ext_build_key(hfsplus_btree_key *key, u32 cnid,
-			  u32 block, u8 type)
+static void hfsplus_ext_build_key(hfsplus_btree_key *key, u32 cnid,
+				  u32 block, u8 type)
 {
 	key->key_len = cpu_to_be16(HFSPLUS_EXT_KEYLEN - 2);
 	key->ext.cnid = cpu_to_be32(cnid);
@@ -263,8 +263,9 @@
 	return -EIO;
 }
 
-int hfsplus_free_extents(struct super_block *sb, struct hfsplus_extent *extent,
-			 u32 offset, u32 block_nr)
+static int hfsplus_free_extents(struct super_block *sb,
+				struct hfsplus_extent *extent,
+				u32 offset, u32 block_nr)
 {
 	u32 count, start;
 	int i;
--- linux-2.6.10-mm2-full/fs/hfsplus/inode.c.old	2005-01-07 00:47:43.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/hfsplus/inode.c	2005-01-07 00:48:16.000000000 +0100
@@ -40,7 +40,7 @@
 	return generic_block_bmap(mapping, block, hfsplus_get_block);
 }
 
-int hfsplus_releasepage(struct page *page, int mask)
+static int hfsplus_releasepage(struct page *page, int mask)
 {
 	struct inode *inode = page->mapping->host;
 	struct super_block *sb = inode->i_sb;
@@ -297,7 +297,7 @@
 extern struct inode_operations hfsplus_dir_inode_operations;
 extern struct file_operations hfsplus_dir_operations;
 
-struct inode_operations hfsplus_file_inode_operations = {
+static struct inode_operations hfsplus_file_inode_operations = {
 	.lookup		= hfsplus_file_lookup,
 	.truncate	= hfsplus_file_truncate,
 	.permission	= hfsplus_permission,
@@ -306,7 +306,7 @@
 	.listxattr	= hfsplus_listxattr,
 };
 
-struct file_operations hfsplus_file_operations = {
+static struct file_operations hfsplus_file_operations = {
 	.llseek 	= generic_file_llseek,
 	.read		= generic_file_read,
 	.write		= generic_file_write,
--- linux-2.6.10-mm2-full/fs/hfsplus/super.c.old	2005-01-07 00:48:30.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/hfsplus/super.c	2005-01-07 00:48:50.000000000 +0100
@@ -94,7 +94,7 @@
 	make_bad_inode(inode);
 }
 
-int hfsplus_write_inode(struct inode *inode, int unused)
+static int hfsplus_write_inode(struct inode *inode, int unused)
 {
 	struct hfsplus_vh *vhdr;
 	int ret = 0;
@@ -239,7 +239,7 @@
 	return 0;
 }
 
-int hfsplus_remount(struct super_block *sb, int *flags, char *data)
+static int hfsplus_remount(struct super_block *sb, int *flags, char *data)
 {
 	if ((*flags & MS_RDONLY) == (sb->s_flags & MS_RDONLY))
 		return 0;

