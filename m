Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263181AbUKTV0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263181AbUKTV0N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 16:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263177AbUKTVZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 16:25:48 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:37640 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263182AbUKTVSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 16:18:55 -0500
Date: Sat, 20 Nov 2004 22:18:54 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: [2.6 patch] some reiser3 cleanups (fwd)
Message-ID: <20041120211853.GG2829@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch forwarded below still applies and compiles against 
2.6.10-rc2-mm2.

Please comment on or apply it.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Sat, 13 Nov 2004 00:04:03 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Hans Reiser <reiser@namesys.com>
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: [2.6 patch] some reiser3 cleanups

The patch below contains some cleanups for reiser3.
It consists of:
- removal of unused code
- making needlessly global code static

Please review this patch.


diffstat output:
 fs/reiserfs/bitmap.c           |    2 
 fs/reiserfs/dir.c              |    4 -
 fs/reiserfs/do_balan.c         |    6 +-
 fs/reiserfs/file.c             |   14 ++---
 fs/reiserfs/fix_node.c         |    2 
 fs/reiserfs/ibalance.c         |    4 -
 fs/reiserfs/inode.c            |   18 +------
 fs/reiserfs/ioctl.c            |    4 +
 fs/reiserfs/item_ops.c         |   10 +--
 fs/reiserfs/journal.c          |   25 ++-------
 fs/reiserfs/prints.c           |   75 -----------------------------
 fs/reiserfs/stree.c            |   84 +++------------------------------
 fs/reiserfs/super.c            |   32 ++----------
 fs/reiserfs/xattr_acl.c        |    4 +
 include/linux/reiserfs_acl.h   |    2 
 include/linux/reiserfs_fs.h    |   32 ------------
 include/linux/reiserfs_fs_sb.h |    1 
 17 files changed, 56 insertions(+), 263 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm5-full/include/linux/reiserfs_fs.h.old	2004-11-12 23:24:12.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/include/linux/reiserfs_fs.h	2004-11-12 23:47:55.000000000 +0100
@@ -243,10 +243,6 @@
 #define REISER2FS_SUPER_MAGIC_STRING "ReIsEr2Fs"
 #define REISER2FS_JR_SUPER_MAGIC_STRING "ReIsEr3Fs"
 
-extern const char reiserfs_3_5_magic_string[];
-extern const char reiserfs_3_6_magic_string[];
-extern const char reiserfs_jr_magic_string[];
-
 int is_reiserfs_3_5 (struct reiserfs_super_block * rs);
 int is_reiserfs_3_6 (struct reiserfs_super_block * rs);
 int is_reiserfs_jr (struct reiserfs_super_block * rs);
@@ -1559,8 +1555,6 @@
 };
 
 
-extern struct item_operations stat_data_ops, indirect_ops, direct_ops, 
-  direntry_ops;
 extern struct item_operations * item_ops [TYPE_ANY + 1];
 
 #define op_bytes_number(ih,bsize)                    item_ops[le_ih_k_type (ih)]->bytes_number (ih, bsize)
@@ -1576,11 +1570,7 @@
 
 
 
-
-
-#define COMP_KEYS comp_keys
 #define COMP_SHORT_KEYS comp_short_keys
-/*#define keys_of_same_object comp_short_keys*/
 
 /* number of blocks pointed to by the indirect item */
 #define I_UNFM_NUM(p_s_ih)	( ih_item_len(p_s_ih) / UNFM_P_SIZE )
@@ -1828,23 +1818,14 @@
 
 /* stree.c */
 int B_IS_IN_TREE(const struct buffer_head *);
-extern inline void copy_short_key (void * to, const void * from);
 extern void copy_item_head(struct item_head * p_v_to,
 								  const struct item_head * p_v_from);
 
 // first key is in cpu form, second - le
-extern int comp_keys (const struct reiserfs_key * le_key,
-			     const struct cpu_key * cpu_key);
 extern int  comp_short_keys (const struct reiserfs_key * le_key,
 				    const struct cpu_key * cpu_key);
 extern void le_key2cpu_key (struct cpu_key * to, const struct reiserfs_key * from);
 
-// both are cpu keys
-extern  int comp_cpu_keys (const struct cpu_key *, const struct cpu_key *);
-extern int comp_short_cpu_keys (const struct cpu_key *,
-				       const struct cpu_key *);
-extern void cpu_key2cpu_key (struct cpu_key *, const struct cpu_key *);
-
 // both are in le form
 extern int comp_le_keys (const struct reiserfs_key *, const struct reiserfs_key *);
 extern int comp_short_le_keys (const struct reiserfs_key *, const struct reiserfs_key *);
@@ -1874,8 +1855,6 @@
 int comp_items (const struct item_head * stored_ih, const struct path * p_s_path);
 const struct reiserfs_key * get_rkey (const struct path * p_s_chk_path,
 							 const struct super_block  * p_s_sb);
-inline int bin_search (const void * p_v_key, const void * p_v_base, 
-					   int p_n_num, int p_n_width, int * p_n_pos);
 int search_by_key (struct super_block *, const struct cpu_key *, 
 				   struct path *, int);
 #define search_item(s,key,path) search_by_key (s, key, path, DISK_LEAF_NODE_LEVEL)
@@ -1944,7 +1923,6 @@
 int reiserfs_encode_fh( struct dentry *dentry, __u32 *data, int *lenp, 
 						int connectable );
 
-int reiserfs_prepare_write(struct file *, struct page *, unsigned, unsigned) ;
 int reiserfs_truncate_file(struct inode *, int update_timestamps) ;
 void make_cpu_key (struct cpu_key * cpu_key, struct inode * inode, loff_t offset,
 		   int type, int key_length);
@@ -1960,9 +1938,6 @@
 				   const char * symname, loff_t i_size,
 				   struct dentry *dentry, struct inode *inode);
 
-int reiserfs_sync_inode (struct reiserfs_transaction_handle *th,
-                         struct inode * inode);
-
 void reiserfs_update_sd_size (struct reiserfs_transaction_handle *th,
                               struct inode * inode, loff_t size);
 
@@ -2061,15 +2036,12 @@
 int fix_nodes (int n_op_mode, struct tree_balance * p_s_tb, 
 	       struct item_head * p_s_ins_ih, const void *);
 void unfix_nodes (struct tree_balance *);
-void free_buffers_in_tb (struct tree_balance * p_s_tb);
 
 
 /* prints.c */
 void reiserfs_panic (struct super_block * s, const char * fmt, ...) __attribute__ ( ( noreturn ) );
 void reiserfs_info (struct super_block *s, const char * fmt, ...);
-void reiserfs_printk (const char * fmt, ...);
 void reiserfs_debug (struct super_block *s, int level, const char * fmt, ...);
-void print_virtual_node (struct virtual_node * vn);
 void print_indirect_item (struct buffer_head * bh, int item_num);
 void store_print_tb (struct tree_balance * tb);
 void print_cur_tb (char * mes);
@@ -2079,7 +2051,6 @@
 #define PRINT_DIRECTORY_ITEMS 2 /* print directory items */
 #define PRINT_DIRECT_ITEMS 4 /* print contents of direct items */
 void print_block (struct buffer_head * bh, ...);
-void print_path (struct tree_balance * tb, struct path * path);
 void print_bmap (struct super_block * s, int silent);
 void print_bmap_block (int i, char * data, int size, int silent);
 /*void print_super_block (struct super_block * s, char * mes);*/
@@ -2120,8 +2091,6 @@
 int get_left_neighbor_position (struct tree_balance * tb, int h);
 int get_right_neighbor_position (struct tree_balance * tb, int h);
 void replace_key (struct tree_balance * tb, struct buffer_head *, int, struct buffer_head *, int);
-void replace_lkey (struct tree_balance *, int, struct item_head *);
-void replace_rkey (struct tree_balance *, int, struct item_head *);
 void make_empty_node (struct buffer_info *);
 struct buffer_head * get_FEB (struct tree_balance *);
 
@@ -2246,7 +2215,6 @@
 /* prototypes from ioctl.c */
 int reiserfs_ioctl (struct inode * inode, struct file * filp, 
  		    unsigned int cmd, unsigned long arg);
-int reiserfs_unpack (struct inode * inode, struct file * filp);
  
 /* ioctl's command */
 #define REISERFS_IOC_UNPACK		_IOW(0xCD,1,long)
--- linux-2.6.10-rc1-mm5-full/include/linux/reiserfs_fs_sb.h.old	2004-11-12 23:34:02.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/include/linux/reiserfs_fs_sb.h	2004-11-12 23:34:09.000000000 +0100
@@ -497,7 +497,6 @@
 
 #define reiserfs_error_panic(s) (REISERFS_SB(s)->s_mount_opt & (1 << REISERFS_ERROR_PANIC))
 #define reiserfs_error_ro(s) (REISERFS_SB(s)->s_mount_opt & (1 << REISERFS_ERROR_RO))
-#define reiserfs_error_continue(s) (REISERFS_SB(s)->s_mount_opt & (1 << REISERFS_ERROR_CONTINUE))
 
 void reiserfs_file_buffer (struct buffer_head * bh, int list);
 extern struct file_system_type reiserfs_fs_type;
--- linux-2.6.10-rc1-mm5-full/fs/reiserfs/bitmap.c.old	2004-11-12 23:20:13.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/fs/reiserfs/bitmap.c	2004-11-12 23:49:41.000000000 +0100
@@ -405,7 +405,7 @@
 }
 
 /* preallocated blocks don't need to be run through journal_mark_freed */
-void reiserfs_free_prealloc_block (struct reiserfs_transaction_handle *th, 
+static void reiserfs_free_prealloc_block (struct reiserfs_transaction_handle *th, 
 			  struct inode *inode, b_blocknr_t block) {
     RFALSE(!th->t_super, "vs-4060: trying to free block on nonexistent device");
     RFALSE(is_reusable (th->t_super, block, 1) == 0, "vs-4070: can not free such block");
--- linux-2.6.10-rc1-mm5-full/fs/reiserfs/dir.c.old	2004-11-12 23:20:45.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/fs/reiserfs/dir.c	2004-11-12 23:49:41.000000000 +0100
@@ -15,7 +15,7 @@
 extern struct reiserfs_key  MIN_KEY;
 
 static int reiserfs_readdir (struct file *, void *, filldir_t);
-int reiserfs_dir_fsync(struct file *filp, struct dentry *dentry, int datasync) ;
+static int reiserfs_dir_fsync(struct file *filp, struct dentry *dentry, int datasync) ;
 
 struct file_operations reiserfs_dir_operations = {
     .read	= generic_read_dir,
@@ -24,7 +24,7 @@
     .ioctl	= reiserfs_ioctl,
 };
 
-int reiserfs_dir_fsync(struct file *filp, struct dentry *dentry, int datasync) {
+static int reiserfs_dir_fsync(struct file *filp, struct dentry *dentry, int datasync) {
   struct inode *inode = dentry->d_inode;
   int err;
   reiserfs_write_lock(inode->i_sb);
--- linux-2.6.10-rc1-mm5-full/fs/reiserfs/do_balan.c.old	2004-11-12 23:21:20.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/fs/reiserfs/do_balan.c	2004-11-12 23:49:40.000000000 +0100
@@ -1382,7 +1382,7 @@
 }
 
 
-void check_after_balance_leaf (struct tree_balance * tb)
+static void check_after_balance_leaf (struct tree_balance * tb)
 {
     if (tb->lnum[0]) {
 	if (B_FREE_SPACE (tb->L[0]) != 
@@ -1422,14 +1422,14 @@
 }
 
 
-void check_leaf_level (struct tree_balance * tb)
+static void check_leaf_level (struct tree_balance * tb)
 {
   check_leaf (tb->L[0]);
   check_leaf (tb->R[0]);
   check_leaf (PATH_PLAST_BUFFER (tb->tb_path));
 }
 
-void check_internal_levels (struct tree_balance * tb)
+static void check_internal_levels (struct tree_balance * tb)
 {
   int h;
 
--- linux-2.6.10-rc1-mm5-full/fs/reiserfs/file.c.old	2004-11-12 23:22:19.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/fs/reiserfs/file.c	2004-11-12 23:49:40.000000000 +0100
@@ -147,7 +147,7 @@
 /* Allocates blocks for a file to fulfil write request.
    Maps all unmapped but prepared pages from the list.
    Updates metadata with newly allocated blocknumbers as needed */
-int reiserfs_allocate_blocks_for_region(
+static int reiserfs_allocate_blocks_for_region(
 				struct reiserfs_transaction_handle *th,
 				struct inode *inode, /* Inode we work with */
 				loff_t pos, /* Writing position */
@@ -587,7 +587,7 @@
 }
 
 /* Unlock pages prepared by reiserfs_prepare_file_region_for_write */
-void reiserfs_unprepare_pages(struct page **prepared_pages, /* list of locked pages */
+static void reiserfs_unprepare_pages(struct page **prepared_pages, /* list of locked pages */
 			      int num_pages /* amount of pages */) {
     int i; // loop counter
 
@@ -602,7 +602,7 @@
 
 /* This function will copy data from userspace to specified pages within
    supplied byte range */
-int reiserfs_copy_from_user_to_file_region(
+static int reiserfs_copy_from_user_to_file_region(
 				loff_t pos, /* In-file position */
 				int num_pages, /* Number of pages affected */
 				int write_bytes, /* Amount of bytes to write */
@@ -714,7 +714,7 @@
 /* Submit pages for write. This was separated from actual file copying
    because we might want to allocate block numbers in-between.
    This function assumes that caller will adjust file size to correct value. */
-int reiserfs_submit_file_region_for_write(
+static int reiserfs_submit_file_region_for_write(
 				struct reiserfs_transaction_handle *th,
 				struct inode *inode,
 				loff_t pos, /* Writing position offset */
@@ -795,7 +795,7 @@
 
 /* Look if passed writing region is going to touch file's tail
    (if it is present). And if it is, convert the tail to unformatted node */
-int reiserfs_check_for_tail_and_convert( struct inode *inode, /* inode to deal with */
+static int reiserfs_check_for_tail_and_convert( struct inode *inode, /* inode to deal with */
 					 loff_t pos, /* Writing position */
 					 int write_bytes /* amount of bytes to write */
 				        )
@@ -851,7 +851,7 @@
    append), it is zeroed, then. 
    Returns number of unallocated blocks that should be allocated to cover
    new file data.*/
-int reiserfs_prepare_file_region_for_write(
+static int reiserfs_prepare_file_region_for_write(
 				struct inode *inode /* Inode of the file */,
 				loff_t pos, /* position in the file */
 				int num_pages, /* number of pages to
@@ -1148,7 +1148,7 @@
    Future Features: providing search_by_key with hints.
 
 */
-ssize_t reiserfs_file_write( struct file *file, /* the file we are going to write into */
+static ssize_t reiserfs_file_write( struct file *file, /* the file we are going to write into */
                              const char __user *buf, /*  pointer to user supplied data
 (in userspace) */
                              size_t count, /* amount of bytes to write */
--- linux-2.6.10-rc1-mm5-full/fs/reiserfs/fix_node.c.old	2004-11-12 23:24:35.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/fs/reiserfs/fix_node.c	2004-11-12 23:49:40.000000000 +0100
@@ -724,7 +724,7 @@
 }
 
 
-void free_buffers_in_tb (
+static void free_buffers_in_tb (
 		       struct tree_balance * p_s_tb
 		       ) {
   int n_counter;
--- linux-2.6.10-rc1-mm5-full/fs/reiserfs/ibalance.c.old	2004-11-12 23:25:19.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/fs/reiserfs/ibalance.c	2004-11-12 23:49:41.000000000 +0100
@@ -698,7 +698,7 @@
 
 
 /* Replace delimiting key of buffers L[h] and S[h] by the given key.*/
-void	replace_lkey (
+static void replace_lkey (
 		      struct tree_balance * tb,
 		      int h,
 		      struct item_head * key
@@ -718,7 +718,7 @@
 
 
 /* Replace delimiting key of buffers S[h] and R[h] by the given key.*/
-void	replace_rkey (
+static void replace_rkey (
 		      struct tree_balance * tb,
 		      int h,
 		      struct item_head * key
--- linux-2.6.10-rc1-mm5-full/fs/reiserfs/inode.c.old	2004-11-12 23:26:04.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/fs/reiserfs/inode.c	2004-11-12 23:49:40.000000000 +0100
@@ -32,6 +32,8 @@
 			       struct buffer_head * bh_result, int create);
 static int reiserfs_commit_write(struct file *f, struct page *page,
                                  unsigned from, unsigned to);
+static int reiserfs_prepare_write(struct file *f, struct page *page,
+				  unsigned from, unsigned to);
 
 void reiserfs_delete_inode (struct inode * inode)
 {
@@ -408,8 +410,8 @@
 
 // this is called to create file map. So, _get_block_create_0 will not
 // read direct item
-int reiserfs_bmap (struct inode * inode, sector_t block,
-		   struct buffer_head * bh_result, int create)
+static int reiserfs_bmap (struct inode * inode, sector_t block,
+			  struct buffer_head * bh_result, int create)
 {
     if (!file_capable (inode, block))
 	return -EFBIG;
@@ -1567,16 +1569,6 @@
     return 0;
 }
 
-/* FIXME: no need any more. right? */
-int reiserfs_sync_inode (struct reiserfs_transaction_handle *th, struct inode * inode)
-{
-  int err = 0;
-
-  reiserfs_update_sd (th, inode);
-  return err;
-}
-
-
 /* stat data of new object is inserted already, this inserts the item
    containing "." and ".." entries */
 static int reiserfs_new_directory (struct reiserfs_transaction_handle *th, 
@@ -2414,7 +2406,7 @@
     return reiserfs_write_full_page(page, wbc) ;
 }
 
-int reiserfs_prepare_write(struct file *f, struct page *page, 
+static int reiserfs_prepare_write(struct file *f, struct page *page, 
 			   unsigned from, unsigned to) {
     struct inode *inode = page->mapping->host ;
     int ret;
--- linux-2.6.10-rc1-mm5-full/fs/reiserfs/ioctl.c.old	2004-11-12 23:28:20.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/fs/reiserfs/ioctl.c	2004-11-12 23:49:41.000000000 +0100
@@ -9,6 +9,8 @@
 #include <linux/pagemap.h>
 #include <linux/smp_lock.h>
 
+static int reiserfs_unpack (struct inode * inode, struct file * filp);
+
 /*
 ** reiserfs_ioctl - handler for ioctl for inode
 ** supported commands:
@@ -87,7 +89,7 @@
 ** Function try to convert tail from direct item into indirect.
 ** It set up nopack attribute in the REISERFS_I(inode)->nopack
 */
-int reiserfs_unpack (struct inode * inode, struct file * filp)
+static int reiserfs_unpack (struct inode * inode, struct file * filp)
 {
     int retval = 0;
     int index ;
--- linux-2.6.10-rc1-mm5-full/fs/reiserfs/item_ops.c.old	2004-11-12 23:29:12.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/fs/reiserfs/item_ops.c	2004-11-12 23:49:41.000000000 +0100
@@ -110,7 +110,7 @@
 		      vi->vi_index, vi->vi_type, vi->vi_ih);
 }
 
-struct item_operations stat_data_ops = {
+static struct item_operations stat_data_ops = {
 	.bytes_number		= sd_bytes_number,
 	.decrement_key		= sd_decrement_key,
 	.is_left_mergeable	= sd_is_left_mergeable,
@@ -213,7 +213,7 @@
 		      vi->vi_index, vi->vi_type, vi->vi_ih);
 }
 
-struct item_operations direct_ops = {
+static struct item_operations direct_ops = {
 	.bytes_number		= direct_bytes_number,
 	.decrement_key		= direct_decrement_key,
 	.is_left_mergeable	= direct_is_left_mergeable,
@@ -367,7 +367,7 @@
 		      vi->vi_index, vi->vi_type, vi->vi_ih);
 }
 
-struct item_operations indirect_ops = {
+static struct item_operations indirect_ops = {
 	.bytes_number		= indirect_bytes_number,
 	.decrement_key		= indirect_decrement_key,
 	.is_left_mergeable	= indirect_is_left_mergeable,
@@ -660,7 +660,7 @@
     printk ("\n");
 }
 
-struct item_operations direntry_ops = {
+static struct item_operations direntry_ops = {
 	.bytes_number		= direntry_bytes_number,
 	.decrement_key		= direntry_decrement_key,
 	.is_left_mergeable	= direntry_is_left_mergeable,
@@ -750,7 +750,7 @@
     reiserfs_warning (NULL, "green-16011: Invalid item type observed, run fsck ASAP");
 }
 
-struct item_operations errcatch_ops = {
+static struct item_operations errcatch_ops = {
     errcatch_bytes_number,
     errcatch_decrement_key,
     errcatch_is_left_mergeable,
--- linux-2.6.10-rc1-mm5-full/fs/reiserfs/journal.c.old	2004-11-12 23:30:44.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/fs/reiserfs/journal.c	2004-11-12 23:51:44.000000000 +0100
@@ -436,19 +436,6 @@
   return (struct reiserfs_journal_cnode *)0 ;
 }
 
-/* returns a cnode with same size, block number and dev as bh in the current transaction hash.  NULL if not found */
-static inline struct reiserfs_journal_cnode *get_journal_hash(struct super_block *p_s_sb, struct buffer_head *bh) {
-  struct reiserfs_journal *journal = SB_JOURNAL (p_s_sb);
-  struct reiserfs_journal_cnode *cn ;
-  if (bh) {
-    cn =  get_journal_hash_dev(p_s_sb, journal->j_hash_table, bh->b_blocknr);
-  }
-  else {
-    return (struct reiserfs_journal_cnode *)0 ;
-  }
-  return cn ;
-}
-
 /*
 ** this actually means 'can this block be reallocated yet?'.  If you set search_all, a block can only be allocated
 ** if it is not in the current transaction, was not freed by the current transaction, and has no chance of ever
@@ -516,7 +503,7 @@
 
 /* insert cn into table
 */
-inline void insert_journal_hash(struct reiserfs_journal_cnode **table, struct reiserfs_journal_cnode *cn) {
+static inline void insert_journal_hash(struct reiserfs_journal_cnode **table, struct reiserfs_journal_cnode *cn) {
   struct reiserfs_journal_cnode *cn_orig ;
 
   cn_orig = journal_hash(table, cn->sb, cn->blocknr) ;
@@ -693,7 +680,7 @@
 }
 
 
-atomic_t nr_reiserfs_jh = ATOMIC_INIT(0);
+static atomic_t nr_reiserfs_jh = ATOMIC_INIT(0);
 static struct reiserfs_jh *alloc_jh(void) {
     struct reiserfs_jh *jh;
     while(1) {
@@ -1090,7 +1077,7 @@
   return NULL ;
 }
 
-void remove_journal_hash(struct super_block *, struct reiserfs_journal_cnode **,
+static void remove_journal_hash(struct super_block *, struct reiserfs_journal_cnode **,
 struct reiserfs_journal_list *, unsigned long, int);
 
 /*
@@ -2028,7 +2015,7 @@
    Right now it is only used from journal code. But later we might use it
    from other places.
    Note: Do not use journal_getblk/sb_getblk functions here! */
-struct buffer_head * reiserfs_breada (struct block_device *dev, int block, int bufsize,
+static struct buffer_head * reiserfs_breada (struct block_device *dev, int block, int bufsize,
 			    unsigned int max_block)
 {
 	struct buffer_head * bhlist[BUFNR];
@@ -3848,7 +3835,7 @@
   return journal->j_errno;
 }
 
-void
+static void
 __reiserfs_journal_abort_hard (struct super_block *sb)
 {
     struct reiserfs_journal *journal = SB_JOURNAL (sb);
@@ -3866,7 +3853,7 @@
 #endif
 }
 
-void
+static void
 __reiserfs_journal_abort_soft (struct super_block *sb, int errno)
 {
     struct reiserfs_journal *journal = SB_JOURNAL (sb);
--- linux-2.6.10-rc1-mm5-full/fs/reiserfs/prints.c.old	2004-11-12 23:32:34.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/fs/reiserfs/prints.c	2004-11-12 23:49:41.000000000 +0100
@@ -286,7 +286,7 @@
 }
 
 /* No newline.. reiserfs_printk calls can be followed by printk's */
-void reiserfs_printk (const char * fmt, ...)
+static void reiserfs_printk (const char * fmt, ...)
 {
   do_reiserfs_warning(fmt);
   printk (error_buf);
@@ -366,30 +366,6 @@
 	 reiserfs_bdevname (sb), error_buf);
 }
 
-static void
-do_handle_error (struct super_block *sb, int errno)
-{
-    if (reiserfs_error_panic (sb)) {
-        panic ("REISERFS: panic (device %s): Panic forced after error\n",
-               reiserfs_bdevname (sb));
-    }
-
-    if (reiserfs_error_ro (sb)) {
-        printk (KERN_CRIT "REISERFS: error (device %s): Re-mounting fs "
-                "readonly\n", reiserfs_bdevname (sb));
-        reiserfs_journal_abort (sb, errno);
-    }
-}
-
-void
-reiserfs_error (struct super_block * sb, int errno, const char *fmt, ...)
-{
-    do_reiserfs_warning (fmt);
-    printk (KERN_CRIT "REISERFS: error (device %s): %s\n",
-            reiserfs_bdevname (sb), error_buf);
-    do_handle_error (sb, errno);
-}
-
 void
 reiserfs_abort (struct super_block *sb, int errno, const char *fmt, ...)
 {
@@ -410,53 +386,6 @@
     reiserfs_journal_abort (sb, errno);
 }
 
-void print_virtual_node (struct virtual_node * vn)
-{
-    int i;
-    struct virtual_item * vi;
-
-    printk ("VIRTUAL NODE CONTAINS %d items, has size %d,%s,%s, ITEM_POS=%d POS_IN_ITEM=%d MODE=\'%c\'\n",
-	    vn->vn_nr_item, vn->vn_size,
-	    (vn->vn_vi[0].vi_type & VI_TYPE_LEFT_MERGEABLE )? "left mergeable" : "", 
-	    (vn->vn_vi[vn->vn_nr_item - 1].vi_type & VI_TYPE_RIGHT_MERGEABLE) ? "right mergeable" : "",
-	    vn->vn_affected_item_num, vn->vn_pos_in_item, vn->vn_mode);
-    
-    vi = vn->vn_vi;
-    for (i = 0; i < vn->vn_nr_item; i ++, vi ++)
-	op_print_vi (vi);
-	
-}
-
-
-void print_path (struct tree_balance * tb, struct path * path)
-{
-    int h = 0;
-    struct buffer_head * bh;
-    
-    if (tb) {
-	while (tb->insert_size[h]) {
-	    bh = PATH_H_PBUFFER (path, h);
-	    printk ("block %llu (level=%d), position %d\n", bh ? (unsigned long long)bh->b_blocknr : 0LL,
-		    bh ? B_LEVEL (bh) : 0, PATH_H_POSITION (path, h));
-	    h ++;
-	}
-  } else {
-      int offset = path->path_length;
-      struct buffer_head * bh;
-      printk ("Offset    Bh     (b_blocknr, b_count) Position Nr_item\n");
-      while ( offset > ILLEGAL_PATH_ELEMENT_OFFSET ) {
-	  bh = PATH_OFFSET_PBUFFER (path, offset);
-	  printk ("%6d %10p (%9llu, %7d) %8d %7d\n", offset, 
-		  bh, bh ? (unsigned long long)bh->b_blocknr : 0LL, bh ? atomic_read (&(bh->b_count)) : 0,
-		  PATH_OFFSET_POSITION (path, offset), bh ? B_NR_ITEMS (bh) : -1);
-	  
-	  offset --;
-      }
-  }
-
-}
-
-
 /* this prints internal nodes (4 keys/items in line) (dc_number,
    dc_size)[k_dirid, k_objectid, k_offset, k_uniqueness](dc_number,
    dc_size)...*/
@@ -648,7 +577,7 @@
 
 
 
-char print_tb_buf[2048];
+static char print_tb_buf[2048];
 
 /* this stores initial state of tree balance in the print_tb_buf */
 void store_print_tb (struct tree_balance * tb)
--- linux-2.6.10-rc1-mm5-full/fs/reiserfs/stree.c.old	2004-11-12 23:36:00.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/fs/reiserfs/stree.c	2004-11-12 23:49:41.000000000 +0100
@@ -12,14 +12,10 @@
  *  This file contains functions dealing with S+tree
  *
  * B_IS_IN_TREE
- * copy_short_key
  * copy_item_head
  * comp_short_keys
  * comp_keys
- * comp_cpu_keys
  * comp_short_le_keys
- * comp_short_cpu_keys
- * cpu_key2cpu_key
  * le_key2cpu_key
  * comp_le_keys
  * bin_search
@@ -72,11 +68,6 @@
   return ( B_LEVEL (p_s_bh) != FREE_LEVEL );
 }
 
-inline void copy_short_key (void * to, const void * from)
-{
-    memcpy (to, from, SHORT_KEY_SIZE);
-}
-
 //
 // to gets item head in le form
 //
@@ -117,7 +108,7 @@
    Compare keys using all 4 key fields.
    Returns: -1 if key1 < key2 0
    if key1 = key2 1 if key1 > key2 */
-inline int  comp_keys (const struct reiserfs_key * le_key, const struct cpu_key * cpu_key)
+static inline int  comp_keys (const struct reiserfs_key * le_key, const struct cpu_key * cpu_key)
 {
   int retval;
 
@@ -143,37 +134,6 @@
 }
 
 
-//
-// FIXME: not used yet
-//
-inline int comp_cpu_keys (const struct cpu_key * key1, 
-			  const struct cpu_key * key2)
-{
-    if (key1->on_disk_key.k_dir_id < key2->on_disk_key.k_dir_id)
-	return -1;
-    if (key1->on_disk_key.k_dir_id > key2->on_disk_key.k_dir_id)
-	return 1;
-
-    if (key1->on_disk_key.k_objectid < key2->on_disk_key.k_objectid)
-	return -1;
-    if (key1->on_disk_key.k_objectid > key2->on_disk_key.k_objectid)
-	return 1;
-
-    if (cpu_key_k_offset (key1) < cpu_key_k_offset (key2))
-	return -1;
-    if (cpu_key_k_offset (key1) > cpu_key_k_offset (key2))
-	return 1;
-
-    reiserfs_warning (NULL, "comp_cpu_keys: type are compared for %K and %K",
-		      key1, key2);
-
-    if (cpu_key_k_type (key1) < cpu_key_k_type (key2))
-	return -1;
-    if (cpu_key_k_type (key1) > cpu_key_k_type (key2))
-	return 1;
-    return 0;
-}
-
 inline int comp_short_le_keys (const struct reiserfs_key * key1, const struct reiserfs_key * key2)
 {
   __u32 * p_s_1_u32, * p_s_2_u32;
@@ -190,32 +150,6 @@
   return 0;
 }
 
-inline int comp_short_cpu_keys (const struct cpu_key * key1, 
-				const struct cpu_key * key2)
-{
-  __u32 * p_s_1_u32, * p_s_2_u32;
-  int n_key_length = REISERFS_SHORT_KEY_LEN;
-
-  p_s_1_u32 = (__u32 *)key1;
-  p_s_2_u32 = (__u32 *)key2;
-
-  for( ; n_key_length--; ++p_s_1_u32, ++p_s_2_u32 ) {
-    if ( *p_s_1_u32 < *p_s_2_u32 )
-      return -1;
-    if ( *p_s_1_u32 > *p_s_2_u32 )
-      return 1;
-  }
-  return 0;
-}
-
-
-
-inline void cpu_key2cpu_key (struct cpu_key * to, const struct cpu_key * from)
-{
-    memcpy (to, from, sizeof (struct cpu_key));
-}
-
-
 inline void le_key2cpu_key (struct cpu_key * to, const struct reiserfs_key * from)
 {
     to->on_disk_key.k_dir_id = le32_to_cpu (from->k_dir_id);
@@ -255,7 +189,7 @@
  there are no possible items, and we have not found it. With each examination we
  cut the number of possible items it could be by one more than half rounded down,
  or we find it. */
-inline	int bin_search (
+static inline	int bin_search (
               const void * p_v_key, /* Key to search for.                   */
 	      const void * p_v_base,/* First item in the array.             */
 	      int       p_n_num,    /* Number of items in the array.        */
@@ -272,7 +206,7 @@
     int   n_rbound, n_lbound, n_j;
 
    for ( n_j = ((n_rbound = p_n_num - 1) + (n_lbound = 0))/2; n_lbound <= n_rbound; n_j = (n_rbound + n_lbound)/2 )
-     switch( COMP_KEYS((struct reiserfs_key *)((char * )p_v_base + n_j * p_n_width), (struct cpu_key *)p_v_key) )  {
+     switch( comp_keys((struct reiserfs_key *)((char * )p_v_base + n_j * p_n_width), (struct cpu_key *)p_v_key) )  {
      case -1: n_lbound = n_j + 1; continue;
      case  1: n_rbound = n_j - 1; continue;
      case  0: *p_n_pos = n_j;     return ITEM_FOUND; /* Key found in the array.  */
@@ -301,7 +235,7 @@
    of the path, and going upwards.  We must check the path's validity at each step.  If the key is not in
    the path, there is no delimiting key in the tree (buffer is first or last buffer in tree), and in this
    case we return a special key, either MIN_KEY or MAX_KEY. */
-inline	const struct  reiserfs_key * get_lkey  (
+static inline	const struct  reiserfs_key * get_lkey  (
 	                const struct path         * p_s_chk_path,
                         const struct super_block  * p_s_sb
                       ) {
@@ -396,11 +330,11 @@
   RFALSE( !PATH_PLAST_BUFFER(p_s_chk_path)->b_bdev,
 	  "PAP-5060: device must not be NODEV");
 
-  if ( COMP_KEYS(get_lkey(p_s_chk_path, p_s_sb), p_s_key) == 1 )
+  if ( comp_keys(get_lkey(p_s_chk_path, p_s_sb), p_s_key) == 1 )
     /* left delimiting key is bigger, that the key we look for */
     return 0;
-  //  if ( COMP_KEYS(p_s_key, get_rkey(p_s_chk_path, p_s_sb)) != -1 )
-  if ( COMP_KEYS(get_rkey(p_s_chk_path, p_s_sb), p_s_key) != 1 )
+  //  if ( comp_keys(p_s_key, get_rkey(p_s_chk_path, p_s_sb)) != -1 )
+  if ( comp_keys(get_rkey(p_s_chk_path, p_s_sb), p_s_key) != 1 )
     /* p_s_key must be less than right delimitiing key */
     return 0;
   return 1;
@@ -745,7 +679,7 @@
         /* only check that the key is in the buffer if p_s_key is not
            equal to the MAX_KEY. Latter case is only possible in
            "finish_unfinished()" processing during mount. */
-        RFALSE( COMP_KEYS( &MAX_KEY, p_s_key ) && 
+        RFALSE( comp_keys( &MAX_KEY, p_s_key ) && 
                 ! key_in_buffer(p_s_search_path, p_s_key, p_s_sb),
 		"PAP-5130: key is not in the buffer");
 #ifdef CONFIG_REISERFS_CHECK
@@ -1192,7 +1126,7 @@
 }
 
 /* Calculate number of bytes which will be deleted or cut during balance */
-int calc_deleted_bytes_number(
+static int calc_deleted_bytes_number(
     struct  tree_balance  * p_s_tb,
     char                    c_mode
     ) {
--- linux-2.6.10-rc1-mm5-full/fs/reiserfs/super.c.old	2004-11-12 23:40:18.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/fs/reiserfs/super.c	2004-11-12 23:49:41.000000000 +0100
@@ -28,9 +28,9 @@
 
 struct file_system_type reiserfs_fs_type;
 
-const char reiserfs_3_5_magic_string[] = REISERFS_SUPER_MAGIC_STRING;
-const char reiserfs_3_6_magic_string[] = REISER2FS_SUPER_MAGIC_STRING;
-const char reiserfs_jr_magic_string[] = REISER2FS_JR_SUPER_MAGIC_STRING;
+static const char reiserfs_3_5_magic_string[] = REISERFS_SUPER_MAGIC_STRING;
+static const char reiserfs_3_6_magic_string[] = REISER2FS_SUPER_MAGIC_STRING;
+static const char reiserfs_jr_magic_string[] = REISER2FS_JR_SUPER_MAGIC_STRING;
 
 int is_reiserfs_3_5 (struct reiserfs_super_block * rs)
 {
@@ -102,7 +102,7 @@
   reiserfs_write_unlock(s);
 }
 
-void reiserfs_unlockfs(struct super_block *s) {
+static void reiserfs_unlockfs(struct super_block *s) {
   reiserfs_allow_writes(s) ;
 }
 
@@ -516,7 +516,7 @@
     REISERFS_I(inode)->i_acl_default = NULL;
 }
 
-struct super_operations reiserfs_sops = 
+static struct super_operations reiserfs_sops = 
 {
   .alloc_inode = reiserfs_alloc_inode,
   .destroy_inode = reiserfs_destroy_inode,
@@ -1125,24 +1125,6 @@
   return 0;
 }
 
-void check_bitmap (struct super_block * s)
-{
-  int i = 0;
-  int free = 0;
-  char * buf;
-
-  while (i < SB_BLOCK_COUNT (s)) {
-    buf = SB_AP_BITMAP (s)[i / (s->s_blocksize * 8)].bh->b_data;
-    if (!reiserfs_test_le_bit (i % (s->s_blocksize * 8), buf))
-      free ++;
-    i ++;
-  }
-
-  if (free != SB_FREE_BLOCKS (s))
-    reiserfs_warning (s,"vs-4000: check_bitmap: %d free blocks, must be %d",
-		      free, SB_FREE_BLOCKS (s));
-}
-
 static int read_super_block (struct super_block * s, int offset)
 {
     struct buffer_head * bh;
@@ -1266,7 +1248,7 @@
 // FIXME: we look for only one name in a directory. If tea and yura
 // bith have the same value - we ask user to send report to the
 // mailing list
-__u32 find_hash_out (struct super_block * s)
+static __u32 find_hash_out (struct super_block * s)
 {
     int retval;
     struct inode * inode;
@@ -1397,7 +1379,7 @@
 }
 
 // this is used to set up correct value for old partitions
-int function2code (hashf_t func)
+static int function2code (hashf_t func)
 {
     if (func == keyed_hash)
 	return TEA_HASH;
--- linux-2.6.10-rc1-mm5-full/include/linux/reiserfs_acl.h.old	2004-11-12 23:42:44.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/include/linux/reiserfs_acl.h	2004-11-12 23:44:44.000000000 +0100
@@ -50,7 +50,6 @@
 
 #ifdef CONFIG_REISERFS_FS_POSIX_ACL
 struct posix_acl * reiserfs_get_acl(struct inode *inode, int type);
-int reiserfs_set_acl(struct inode *inode, int type, struct posix_acl *acl);
 int reiserfs_acl_chmod (struct inode *inode);
 int reiserfs_inherit_default_acl (struct inode *dir, struct dentry *dentry, struct inode *inode);
 int reiserfs_cache_default_acl (struct inode *dir);
@@ -60,7 +59,6 @@
 extern struct reiserfs_xattr_handler posix_acl_access_handler;
 #else
 
-#define reiserfs_set_acl NULL
 #define reiserfs_get_acl NULL
 #define reiserfs_cache_default_acl(inode) 0
 
--- linux-2.6.10-rc1-mm5-full/fs/reiserfs/xattr_acl.c.old	2004-11-12 23:43:40.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/fs/reiserfs/xattr_acl.c	2004-11-12 23:49:41.000000000 +0100
@@ -9,6 +9,8 @@
 #include <linux/reiserfs_acl.h>
 #include <asm/uaccess.h>
 
+static int reiserfs_set_acl(struct inode *inode, int type, struct posix_acl *acl);
+
 static int
 xattr_set_acl(struct inode *inode, int type, const void *value, size_t size)
 {
@@ -243,7 +245,7 @@
  * inode->i_sem: down
  * BKL held [before 2.5.x]
  */
-int
+static int
 reiserfs_set_acl(struct inode *inode, int type, struct posix_acl *acl)
 {
         char *name;

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

