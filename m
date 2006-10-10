Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030214AbWJJWil@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbWJJWil (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 18:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030612AbWJJWiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 18:38:16 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:60546 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030609AbWJJWiH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 18:38:07 -0400
To: torvalds@osdl.org
Subject: [PATCH 8/16] befs: endianness annotations
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXQEf-0008Vr-S7@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 23:38:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: Sat, 24 Dec 2005 14:28:55 -0500

split the data structures that exist in host- and disk-endian variants,
annotate the fields of disk-endian ones, propagate changes.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/befs/befs.h          |    4 +-
 fs/befs/befs_fs_types.h |  107 +++++++++++++++++++++++++++++++----------------
 fs/befs/btree.c         |   28 ++++++------
 fs/befs/datastream.c    |   10 ++--
 fs/befs/debug.c         |    9 ++--
 fs/befs/endian.h        |   20 ++++-----
 6 files changed, 106 insertions(+), 72 deletions(-)

diff --git a/fs/befs/befs.h b/fs/befs/befs.h
index c400bb6..d9a40ab 100644
--- a/fs/befs/befs.h
+++ b/fs/befs/befs.h
@@ -94,7 +94,7 @@ void befs_debug(const struct super_block
 
 void befs_dump_super_block(const struct super_block *sb, befs_super_block *);
 void befs_dump_inode(const struct super_block *sb, befs_inode *);
-void befs_dump_index_entry(const struct super_block *sb, befs_btree_super *);
+void befs_dump_index_entry(const struct super_block *sb, befs_disk_btree_super *);
 void befs_dump_index_node(const struct super_block *sb, befs_btree_nodehead *);
 /****************************/
 
@@ -136,7 +136,7 @@ blockno2iaddr(struct super_block *sb, be
 static inline unsigned int
 befs_iaddrs_per_block(struct super_block *sb)
 {
-	return BEFS_SB(sb)->block_size / sizeof (befs_inode_addr);
+	return BEFS_SB(sb)->block_size / sizeof (befs_disk_inode_addr);
 }
 
 static inline int
diff --git a/fs/befs/befs_fs_types.h b/fs/befs/befs_fs_types.h
index 128066b..e2595c2 100644
--- a/fs/befs/befs_fs_types.h
+++ b/fs/befs/befs_fs_types.h
@@ -84,15 +84,22 @@ typedef u32 __bitwise fs32;
 typedef u16 __bitwise fs16;
 
 typedef u64 befs_off_t;
-typedef u64 befs_time_t;
+typedef fs64 befs_time_t;
 
 /* Block runs */
 typedef struct {
+	fs32 allocation_group;
+	fs16 start;
+	fs16 len;
+} PACKED befs_disk_block_run;
+
+typedef struct {
 	u32 allocation_group;
 	u16 start;
 	u16 len;
 } PACKED befs_block_run;
 
+typedef befs_disk_block_run befs_disk_inode_addr;
 typedef befs_block_run befs_inode_addr;
 
 /*
@@ -100,31 +107,31 @@ typedef befs_block_run befs_inode_addr;
  */
 typedef struct {
 	char name[B_OS_NAME_LENGTH];
-	u32 magic1;
-	u32 fs_byte_order;
+	fs32 magic1;
+	fs32 fs_byte_order;
 
-	u32 block_size;
-	u32 block_shift;
+	fs32 block_size;
+	fs32 block_shift;
 
-	befs_off_t num_blocks;
-	befs_off_t used_blocks;
+	fs64 num_blocks;
+	fs64 used_blocks;
 
-	u32 inode_size;
+	fs32 inode_size;
 
-	u32 magic2;
-	u32 blocks_per_ag;
-	u32 ag_shift;
-	u32 num_ags;
+	fs32 magic2;
+	fs32 blocks_per_ag;
+	fs32 ag_shift;
+	fs32 num_ags;
 
-	u32 flags;
+	fs32 flags;
 
-	befs_block_run log_blocks;
-	befs_off_t log_start;
-	befs_off_t log_end;
+	befs_disk_block_run log_blocks;
+	fs64 log_start;
+	fs64 log_end;
 
-	u32 magic3;
-	befs_inode_addr root_dir;
-	befs_inode_addr indices;
+	fs32 magic3;
+	befs_disk_inode_addr root_dir;
+	befs_disk_inode_addr indices;
 
 } PACKED befs_super_block;
 
@@ -133,6 +140,16 @@ typedef struct {
  * be longer than one block!
  */
 typedef struct {
+	befs_disk_block_run direct[BEFS_NUM_DIRECT_BLOCKS];
+	fs64 max_direct_range;
+	befs_disk_block_run indirect;
+	fs64 max_indirect_range;
+	befs_disk_block_run double_indirect;
+	fs64 max_double_indirect_range;
+	fs64 size;
+} PACKED befs_disk_data_stream;
+
+typedef struct {
 	befs_block_run direct[BEFS_NUM_DIRECT_BLOCKS];
 	befs_off_t max_direct_range;
 	befs_block_run indirect;
@@ -144,35 +161,35 @@ typedef struct {
 
 /* Attribute */
 typedef struct {
-	u32 type;
-	u16 name_size;
-	u16 data_size;
+	fs32 type;
+	fs16 name_size;
+	fs16 data_size;
 	char name[1];
 } PACKED befs_small_data;
 
 /* Inode structure */
 typedef struct {
-	u32 magic1;
-	befs_inode_addr inode_num;
-	u32 uid;
-	u32 gid;
-	u32 mode;
-	u32 flags;
+	fs32 magic1;
+	befs_disk_inode_addr inode_num;
+	fs32 uid;
+	fs32 gid;
+	fs32 mode;
+	fs32 flags;
 	befs_time_t create_time;
 	befs_time_t last_modified_time;
-	befs_inode_addr parent;
-	befs_inode_addr attributes;
-	u32 type;
+	befs_disk_inode_addr parent;
+	befs_disk_inode_addr attributes;
+	fs32 type;
 
-	u32 inode_size;
-	u32 etc;		/* not use */
+	fs32 inode_size;
+	fs32 etc;		/* not use */
 
 	union {
-		befs_data_stream datastream;
+		befs_disk_data_stream datastream;
 		char symlink[BEFS_SYMLINK_LEN];
 	} data;
 
-	u32 pad[4];		/* not use */
+	fs32 pad[4];		/* not use */
 	befs_small_data small_data[1];
 } PACKED befs_inode;
 
@@ -193,6 +210,16 @@ enum btree_types {
 };
 
 typedef struct {
+	fs32 magic;
+	fs32 node_size;
+	fs32 max_depth;
+	fs32 data_type;
+	fs64 root_node_ptr;
+	fs64 free_node_ptr;
+	fs64 max_size;
+} PACKED befs_disk_btree_super;
+
+typedef struct {
 	u32 magic;
 	u32 node_size;
 	u32 max_depth;
@@ -206,11 +233,19 @@ typedef struct {
  * Header stucture of each btree node
  */
 typedef struct {
+	fs64 left;
+	fs64 right;
+	fs64 overflow;
+	fs16 all_key_count;
+	fs16 all_key_length;
+} PACKED befs_btree_nodehead;
+
+typedef struct {
 	befs_off_t left;
 	befs_off_t right;
 	befs_off_t overflow;
 	u16 all_key_count;
 	u16 all_key_length;
-} PACKED befs_btree_nodehead;
+} PACKED befs_host_btree_nodehead;
 
 #endif				/* _LINUX_BEFS_FS_TYPES */
diff --git a/fs/befs/btree.c b/fs/befs/btree.c
index 12e0fd6..81b042e 100644
--- a/fs/befs/btree.c
+++ b/fs/befs/btree.c
@@ -79,7 +79,7 @@ #include "datastream.h"
  * In memory structure of each btree node
  */
 typedef struct {
-	befs_btree_nodehead head;	/* head of node converted to cpu byteorder */
+	befs_host_btree_nodehead head;	/* head of node converted to cpu byteorder */
 	struct buffer_head *bh;
 	befs_btree_nodehead *od_node;	/* on disk node */
 } befs_btree_node;
@@ -101,9 +101,9 @@ static int befs_bt_read_node(struct supe
 
 static int befs_leafnode(befs_btree_node * node);
 
-static u16 *befs_bt_keylen_index(befs_btree_node * node);
+static fs16 *befs_bt_keylen_index(befs_btree_node * node);
 
-static befs_off_t *befs_bt_valarray(befs_btree_node * node);
+static fs64 *befs_bt_valarray(befs_btree_node * node);
 
 static char *befs_bt_keydata(befs_btree_node * node);
 
@@ -135,7 +135,7 @@ befs_bt_read_super(struct super_block *s
 		   befs_btree_super * sup)
 {
 	struct buffer_head *bh = NULL;
-	befs_btree_super *od_sup = NULL;
+	befs_disk_btree_super *od_sup = NULL;
 
 	befs_debug(sb, "---> befs_btree_read_super()");
 
@@ -145,7 +145,7 @@ befs_bt_read_super(struct super_block *s
 		befs_error(sb, "Couldn't read index header.");
 		goto error;
 	}
-	od_sup = (befs_btree_super *) bh->b_data;
+	od_sup = (befs_disk_btree_super *) bh->b_data;
 	befs_dump_index_entry(sb, od_sup);
 
 	sup->magic = fs32_to_cpu(sb, od_sup->magic);
@@ -341,7 +341,7 @@ befs_find_key(struct super_block *sb, be
 	u16 keylen;
 	int findkey_len;
 	char *thiskey;
-	befs_off_t *valarray;
+	fs64 *valarray;
 
 	befs_debug(sb, "---> befs_find_key() %s", findkey);
 
@@ -421,7 +421,7 @@ befs_btree_read(struct super_block *sb, 
 	befs_btree_super bt_super;
 	befs_off_t node_off = 0;
 	int cur_key;
-	befs_off_t *valarray;
+	fs64 *valarray;
 	char *keystart;
 	u16 keylen;
 	int res;
@@ -571,7 +571,7 @@ befs_btree_seekleaf(struct super_block *
 				   this_node->head.overflow);
 			*node_off = this_node->head.overflow;
 		} else {
-			befs_off_t *valarray = befs_bt_valarray(this_node);
+			fs64 *valarray = befs_bt_valarray(this_node);
 			*node_off = fs64_to_cpu(sb, valarray[0]);
 		}
 		if (befs_bt_read_node(sb, ds, this_node, *node_off) != BEFS_OK) {
@@ -621,7 +621,7 @@ befs_leafnode(befs_btree_node * node)
  *
  * Except that rounding up to 8 works, and rounding up to 4 doesn't.
  */
-static u16 *
+static fs16 *
 befs_bt_keylen_index(befs_btree_node * node)
 {
 	const int keylen_align = 8;
@@ -632,7 +632,7 @@ befs_bt_keylen_index(befs_btree_node * n
 	if (tmp)
 		off += keylen_align - tmp;
 
-	return (u16 *) ((void *) node->od_node + off);
+	return (fs16 *) ((void *) node->od_node + off);
 }
 
 /**
@@ -642,13 +642,13 @@ befs_bt_keylen_index(befs_btree_node * n
  * Returns a pointer to the start of the value array
  * of the node pointed to by the node header
  */
-static befs_off_t *
+static fs64 *
 befs_bt_valarray(befs_btree_node * node)
 {
 	void *keylen_index_start = (void *) befs_bt_keylen_index(node);
-	size_t keylen_index_size = node->head.all_key_count * sizeof (u16);
+	size_t keylen_index_size = node->head.all_key_count * sizeof (fs16);
 
-	return (befs_off_t *) (keylen_index_start + keylen_index_size);
+	return (fs64 *) (keylen_index_start + keylen_index_size);
 }
 
 /**
@@ -680,7 +680,7 @@ befs_bt_get_key(struct super_block *sb, 
 {
 	int prev_key_end;
 	char *keystart;
-	u16 *keylen_index;
+	fs16 *keylen_index;
 
 	if (index < 0 || index > node->head.all_key_count) {
 		*keylen = 0;
diff --git a/fs/befs/datastream.c b/fs/befs/datastream.c
index 67335e2..aacb4da 100644
--- a/fs/befs/datastream.c
+++ b/fs/befs/datastream.c
@@ -311,7 +311,7 @@ befs_find_brun_indirect(struct super_blo
 	befs_blocknr_t indir_start_blk;
 	befs_blocknr_t search_blk;
 	struct buffer_head *indirblock;
-	befs_block_run *array;
+	befs_disk_block_run *array;
 
 	befs_block_run indirect = data->indirect;
 	befs_blocknr_t indirblockno = iaddr2blockno(sb, &indirect);
@@ -333,7 +333,7 @@ befs_find_brun_indirect(struct super_blo
 			return BEFS_ERR;
 		}
 
-		array = (befs_block_run *) indirblock->b_data;
+		array = (befs_disk_block_run *) indirblock->b_data;
 
 		for (j = 0; j < arraylen; ++j) {
 			int len = fs16_to_cpu(sb, array[j].len);
@@ -426,7 +426,7 @@ befs_find_brun_dblindirect(struct super_
 	struct buffer_head *dbl_indir_block;
 	struct buffer_head *indir_block;
 	befs_block_run indir_run;
-	befs_inode_addr *iaddr_array = NULL;
+	befs_disk_inode_addr *iaddr_array = NULL;
 	befs_sb_info *befs_sb = BEFS_SB(sb);
 
 	befs_blocknr_t indir_start_blk =
@@ -481,7 +481,7 @@ befs_find_brun_dblindirect(struct super_
 
 	dbl_block_indx =
 	    dblindir_indx - (dbl_which_block * befs_iaddrs_per_block(sb));
-	iaddr_array = (befs_inode_addr *) dbl_indir_block->b_data;
+	iaddr_array = (befs_disk_inode_addr *) dbl_indir_block->b_data;
 	indir_run = fsrun_to_cpu(sb, iaddr_array[dbl_block_indx]);
 	brelse(dbl_indir_block);
 	iaddr_array = NULL;
@@ -506,7 +506,7 @@ befs_find_brun_dblindirect(struct super_
 	}
 
 	block_indx = indir_indx - (which_block * befs_iaddrs_per_block(sb));
-	iaddr_array = (befs_inode_addr *) indir_block->b_data;
+	iaddr_array = (befs_disk_inode_addr *) indir_block->b_data;
 	*run = fsrun_to_cpu(sb, iaddr_array[block_indx]);
 	brelse(indir_block);
 	iaddr_array = NULL;
diff --git a/fs/befs/debug.c b/fs/befs/debug.c
index bb68370..e831a8f 100644
--- a/fs/befs/debug.c
+++ b/fs/befs/debug.c
@@ -230,21 +230,20 @@ befs_dump_small_data(const struct super_
 
 /* unused */
 void
-befs_dump_run(const struct super_block *sb, befs_block_run run)
+befs_dump_run(const struct super_block *sb, befs_disk_block_run run)
 {
 #ifdef CONFIG_BEFS_DEBUG
 
-	run = fsrun_to_cpu(sb, run);
+	befs_block_run n = fsrun_to_cpu(sb, run);
 
-	befs_debug(sb, "[%u, %hu, %hu]",
-		   run.allocation_group, run.start, run.len);
+	befs_debug(sb, "[%u, %hu, %hu]", n.allocation_group, n.start, n.len);
 
 #endif				//CONFIG_BEFS_DEBUG
 }
 #endif  /*  0  */
 
 void
-befs_dump_index_entry(const struct super_block *sb, befs_btree_super * super)
+befs_dump_index_entry(const struct super_block *sb, befs_disk_btree_super * super)
 {
 #ifdef CONFIG_BEFS_DEBUG
 
diff --git a/fs/befs/endian.h b/fs/befs/endian.h
index 979c543..e254a20 100644
--- a/fs/befs/endian.h
+++ b/fs/befs/endian.h
@@ -68,26 +68,26 @@ cpu_to_fs16(const struct super_block *sb
 /* Composite types below here */
 
 static inline befs_block_run
-fsrun_to_cpu(const struct super_block *sb, befs_block_run n)
+fsrun_to_cpu(const struct super_block *sb, befs_disk_block_run n)
 {
 	befs_block_run run;
 
 	if (BEFS_SB(sb)->byte_order == BEFS_BYTESEX_LE) {
-		run.allocation_group = le32_to_cpu(n.allocation_group);
-		run.start = le16_to_cpu(n.start);
-		run.len = le16_to_cpu(n.len);
+		run.allocation_group = le32_to_cpu((__force __le32)n.allocation_group);
+		run.start = le16_to_cpu((__force __le16)n.start);
+		run.len = le16_to_cpu((__force __le16)n.len);
 	} else {
-		run.allocation_group = be32_to_cpu(n.allocation_group);
-		run.start = be16_to_cpu(n.start);
-		run.len = be16_to_cpu(n.len);
+		run.allocation_group = be32_to_cpu((__force __be32)n.allocation_group);
+		run.start = be16_to_cpu((__force __be16)n.start);
+		run.len = be16_to_cpu((__force __be16)n.len);
 	}
 	return run;
 }
 
-static inline befs_block_run
+static inline befs_disk_block_run
 cpu_to_fsrun(const struct super_block *sb, befs_block_run n)
 {
-	befs_block_run run;
+	befs_disk_block_run run;
 
 	if (BEFS_SB(sb)->byte_order == BEFS_BYTESEX_LE) {
 		run.allocation_group = cpu_to_le32(n.allocation_group);
@@ -102,7 +102,7 @@ cpu_to_fsrun(const struct super_block *s
 }
 
 static inline befs_data_stream
-fsds_to_cpu(const struct super_block *sb, befs_data_stream n)
+fsds_to_cpu(const struct super_block *sb, befs_disk_data_stream n)
 {
 	befs_data_stream data;
 	int i;
-- 
1.4.2.GIT


