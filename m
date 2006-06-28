Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422625AbWF1NbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422625AbWF1NbV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 09:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423323AbWF1NbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 09:31:21 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:24549 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S1422625AbWF1NbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 09:31:19 -0400
To: cmm@us.ibm.com, adilger@clusterfs.com, jitendra@linsyssoft.com
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: [RFC][PATCH]add ext3_fileblk_t for file relative offset
Message-Id: <20060628223109sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Wed, 28 Jun 2006 22:31:09 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On May 26, 2006, I wrote: 
> On May 26, 2006, Mingming wrote:
>> As we have discussed before, it's saner to define ext3 fs blocks type
>> and group block type and then fix the kernel ext3 block variable type
>> bugs....So above patches from me are going to be replaced by a new
>> set of ext3 filesystem blocks patches, I have sent out a RFC to the
>> ext2-devel list in the last few weeks:
>
> I agree. But the aim of this fix is to keep as much compatibility as
> possible by making only >2TB file incompatible(RO). So I didn't add
> typedef for ext3 block type.
>
> Now I'm working on changing the type of variables related to block,
> including ext3_fileblk_t. I'll send the update patches later.

I've finished this work finally.


In Mingming's patch set, the single type `ext3_fsblk_t' deal with two
different values, which are file relative offset and filesystem
relative offset.  I think it is confusing.

Therefore I added "ext3_fileblk_t" for file relative offset.
It makes maintenance easier and code clearer if file size
needs to be larger.
ext3_fileblk_t is unsigned long which is the maximum size of
current type for file relative offset.

For example:
static unsigned long blocks_for_truncate(struct inode *inode)
{
	unsigned long needed;  <- for file relative offset


This patch applies on top of Mingming's patches which were posted at:
  http://marc.theaimsgroup.com/?l=ext2-devel&m=114981607414944&w=2


Signed-off-by: Takashi Sato <sho@tnes.nec.co.jp>
---
diff -Nurp -x CVS ../../linux-2.6.17.org/fs/ext3/dir.c linux-2.6.17-rc6-48bitext3/fs/ext3/dir.c
--- ../../linux-2.6.17.org/fs/ext3/dir.c	2006-06-19 17:29:39.000000000 +0800
+++ linux-2.6.17-rc6-48bitext3/fs/ext3/dir.c	2006-06-20 14:58:51.000000000 +0800
@@ -126,7 +126,7 @@ static int ext3_readdir(struct file * fi
 	offset = filp->f_pos & (sb->s_blocksize - 1);
 
 	while (!error && !stored && filp->f_pos < inode->i_size) {
-		unsigned long blk = filp->f_pos >> EXT3_BLOCK_SIZE_BITS(sb);
+		ext3_fileblk_t blk = filp->f_pos >> EXT3_BLOCK_SIZE_BITS(sb);
 		struct buffer_head map_bh;
 		struct buffer_head *bh = NULL;
 
diff -Nurp -x CVS ../../linux-2.6.17.org/fs/ext3/inode.c linux-2.6.17-rc6-48bitext3/fs/ext3/inode.c
--- ../../linux-2.6.17.org/fs/ext3/inode.c	2006-06-19 17:31:49.000000000 +0800
+++ linux-2.6.17-rc6-48bitext3/fs/ext3/inode.c	2006-06-21 10:46:24.000000000 +0800
@@ -105,7 +105,7 @@ int ext3_forget(handle_t *handle, int is
  */
 static unsigned long blocks_for_truncate(struct inode *inode) 
 {
-	unsigned long needed;
+	ext3_fileblk_t needed;
 
 	needed = inode->i_blocks >> (inode->i_sb->s_blocksize_bits - 9);
 
@@ -282,7 +282,7 @@ static int verify_chain(Indirect *from, 
  */
 
 static int ext3_block_to_path(struct inode *inode,
-			long i_block, int offsets[4], int *boundary)
+			ext3_fileblk_t i_block, int offsets[4], int *boundary)
 {
 	int ptrs = EXT3_ADDR_PER_BLOCK(inode->i_sb);
 	int ptrs_bits = EXT3_ADDR_PER_BLOCK_BITS(inode->i_sb);
@@ -445,7 +445,7 @@ static ext3_fsblk_t ext3_find_near(struc
  *	stores it in *@goal and returns zero.
  */
 
-static ext3_fsblk_t ext3_find_goal(struct inode *inode, long block,
+static ext3_fsblk_t ext3_find_goal(struct inode *inode, ext3_fileblk_t block,
 		Indirect chain[4], Indirect *partial)
 {
 	struct ext3_block_alloc_info *block_i;
@@ -680,7 +680,7 @@ failed:
  * chain to new block and return 0.
  */
 static int ext3_splice_branch(handle_t *handle, struct inode *inode,
-			long block, Indirect *where, int num, int blks)
+			ext3_fileblk_t block, Indirect *where, int num, int blks)
 {
 	int i;
 	int err = 0;
@@ -784,7 +784,7 @@ err_out:
  * return < 0, error case.
  */
 int ext3_get_blocks_handle(handle_t *handle, struct inode *inode,
-		sector_t iblock, unsigned long maxblocks,
+		ext3_fileblk_t iblock, unsigned long maxblocks,
 		struct buffer_head *bh_result,
 		int create, int extend_disksize)
 {
@@ -996,7 +996,7 @@ get_block:
  * `handle' can be NULL if create is zero
  */
 struct buffer_head *ext3_getblk(handle_t *handle, struct inode *inode,
-				long block, int create, int *errp)
+				ext3_fileblk_t block, int create, int *errp)
 {
 	struct buffer_head dummy;
 	int fatal = 0, err;
@@ -1060,7 +1060,7 @@ err:
 }
 
 struct buffer_head *ext3_bread(handle_t *handle, struct inode *inode,
-			       int block, int create, int *err)
+			       ext3_fileblk_t block, int create, int *err)
 {
 	struct buffer_head * bh;
 
@@ -1759,7 +1759,8 @@ int ext3_block_truncate_page(handle_t *h
 {
 	ext3_fsblk_t index = from >> PAGE_CACHE_SHIFT;
 	unsigned offset = from & (PAGE_CACHE_SIZE-1);
-	unsigned blocksize, iblock, length, pos;
+	unsigned blocksize, length, pos;
+	ext3_fileblk_t iblock;
 	struct inode *inode = mapping->host;
 	struct buffer_head *bh;
 	int err = 0;
@@ -2232,7 +2233,7 @@ void ext3_truncate(struct inode *inode)
 	Indirect *partial;
 	__le32 nr = 0;
 	int n;
-	long last_block;
+	ext3_fileblk_t last_block;
 	unsigned blocksize = inode->i_sb->s_blocksize;
 	struct page *page;
 
diff -Nurp -x CVS ../../linux-2.6.17.org/fs/ext3/namei.c linux-2.6.17-rc6-48bitext3/fs/ext3/namei.c
--- ../../linux-2.6.17.org/fs/ext3/namei.c	2006-03-20 13:53:29.000000000 +0800
+++ linux-2.6.17-rc6-48bitext3/fs/ext3/namei.c	2006-06-20 14:58:51.000000000 +0800
@@ -51,7 +51,7 @@
 
 static struct buffer_head *ext3_append(handle_t *handle,
 					struct inode *inode,
-					u32 *block, int *err)
+					ext3_fileblk_t *block, int *err)
 {
 	struct buffer_head *bh;
 
@@ -144,8 +144,8 @@ struct dx_map_entry
 };
 
 #ifdef CONFIG_EXT3_INDEX
-static inline unsigned dx_get_block (struct dx_entry *entry);
-static void dx_set_block (struct dx_entry *entry, unsigned value);
+static inline ext3_fileblk_t dx_get_block (struct dx_entry *entry);
+static void dx_set_block (struct dx_entry *entry, ext3_fileblk_t value);
 static inline unsigned dx_get_hash (struct dx_entry *entry);
 static void dx_set_hash (struct dx_entry *entry, unsigned value);
 static unsigned dx_get_count (struct dx_entry *entries);
@@ -166,7 +166,7 @@ static void dx_sort_map(struct dx_map_en
 static struct ext3_dir_entry_2 *dx_move_dirents (char *from, char *to,
 		struct dx_map_entry *offsets, int count);
 static struct ext3_dir_entry_2* dx_pack_dirents (char *base, int size);
-static void dx_insert_block (struct dx_frame *frame, u32 hash, u32 block);
+static void dx_insert_block (struct dx_frame *frame, u32 hash, ext3_fileblk_t block);
 static int ext3_htree_next_block(struct inode *dir, __u32 hash,
 				 struct dx_frame *frame,
 				 struct dx_frame *frames, 
@@ -181,12 +181,12 @@ static int ext3_dx_add_entry(handle_t *h
  * Mask them off for now.
  */
 
-static inline unsigned dx_get_block (struct dx_entry *entry)
+static inline ext3_fileblk_t dx_get_block (struct dx_entry *entry)
 {
 	return le32_to_cpu(entry->block) & 0x00ffffff;
 }
 
-static inline void dx_set_block (struct dx_entry *entry, unsigned value)
+static inline void dx_set_block (struct dx_entry *entry, ext3_fileblk_t value)
 {
 	entry->block = cpu_to_le32(value);
 }
@@ -244,7 +244,7 @@ static void dx_show_index (char * label,
         printk("%s index ", label);
         for (i = 0; i < n; i++)
         {
-                printk("%x->%u ", i? dx_get_hash(entries + i): 0, dx_get_block(entries + i));
+                printk("%x->%lu ", i? dx_get_hash(entries + i): 0, dx_get_block(entries + i));
         }
         printk("\n");
 }
@@ -297,7 +297,7 @@ struct stats dx_show_entries(struct dx_h
 	printk("%i indexed blocks...\n", count);
 	for (i = 0; i < count; i++, entries++)
 	{
-		u32 block = dx_get_block(entries), hash = i? dx_get_hash(entries): 0;
+		ext3_fileblk_t block = dx_get_block(entries), hash = i? dx_get_hash(entries): 0;
 		u32 range = i < count - 1? (dx_get_hash(entries + 1) - hash): ~hash;
 		struct stats stats;
 		printk("%s%3u:%03u hash %8x/%8x ",levels?"":"   ", i, block, hash, range);
@@ -534,7 +534,7 @@ static inline struct ext3_dir_entry_2 *e
  * into the tree.  If there is an error it is returned in err.
  */
 static int htree_dirblock_to_tree(struct file *dir_file,
-				  struct inode *dir, int block,
+				  struct inode *dir, ext3_fileblk_t block,
 				  struct dx_hash_info *hinfo,
 				  __u32 start_hash, __u32 start_minor_hash)
 {
@@ -542,7 +542,7 @@ static int htree_dirblock_to_tree(struct
 	struct ext3_dir_entry_2 *de, *top;
 	int err, count = 0;
 
-	dxtrace(printk("In htree dirblock_to_tree: block %d\n", block));
+	dxtrace(printk("In htree dirblock_to_tree: block %lu\n", block));
 	if (!(bh = ext3_bread (NULL, dir, block, 0, &err)))
 		return err;
 
@@ -585,7 +585,8 @@ int ext3_htree_fill_tree(struct file *di
 	struct ext3_dir_entry_2 *de;
 	struct dx_frame frames[2], *frame;
 	struct inode *dir;
-	int block, err;
+	ext3_fileblk_t block;
+	int err;
 	int count = 0;
 	int ret;
 	__u32 hashval;
@@ -713,7 +714,7 @@ static void dx_sort_map (struct dx_map_e
 	} while(more);
 }
 
-static void dx_insert_block(struct dx_frame *frame, u32 hash, u32 block)
+static void dx_insert_block(struct dx_frame *frame, u32 hash, ext3_fileblk_t block)
 {
 	struct dx_entry *entries = frame->entries;
 	struct dx_entry *old = frame->at, *new = old + 1;
@@ -810,13 +811,14 @@ static struct buffer_head * ext3_find_en
 	struct super_block * sb;
 	struct buffer_head * bh_use[NAMEI_RA_SIZE];
 	struct buffer_head * bh, *ret = NULL;
-	unsigned long start, block, b;
+	ext3_fileblk_t start, block, b;
 	int ra_max = 0;		/* Number of bh's in the readahead
 				   buffer, bh_use[] */
 	int ra_ptr = 0;		/* Current index into readahead
 				   buffer */
 	int num = 0;
-	int nblocks, i, err;
+	ext3_fileblk_t nblocks;
+	int i, err;
 	struct inode *dir = dentry->d_parent->d_inode;
 	int namelen;
 	const u8 *name;
@@ -927,7 +929,7 @@ static struct buffer_head * ext3_dx_find
 	struct dx_frame frames[2], *frame;
 	struct ext3_dir_entry_2 *de, *top;
 	struct buffer_head *bh;
-	unsigned long block;
+	ext3_fileblk_t block;
 	int retval;
 	int namelen = dentry->d_name.len;
 	const u8 *name = dentry->d_name.name;
@@ -1107,7 +1109,7 @@ static struct ext3_dir_entry_2 *do_split
 	unsigned blocksize = dir->i_sb->s_blocksize;
 	unsigned count, continued;
 	struct buffer_head *bh2;
-	u32 newblock;
+	ext3_fileblk_t newblock;
 	u32 hash2;
 	struct dx_map_entry *map;
 	char *data1 = (*bh)->b_data, *data2;
@@ -1148,7 +1150,7 @@ static struct ext3_dir_entry_2 *do_split
 	dx_sort_map (map, count);
 	hash2 = map[split].hash;
 	continued = hash2 == map[split - 1].hash;
-	dxtrace(printk("Split block %i at %x, %i/%i\n",
+	dxtrace(printk("Split block %lu at %x, %i/%i\n",
 		dx_get_block(frame->at), hash2, split, count-split));
 
 	/* Fancy dance to stay within two buffers */
@@ -1296,7 +1298,7 @@ static int make_indexed_dir(handle_t *ha
 	int		retval;
 	unsigned	blocksize;
 	struct dx_hash_info hinfo;
-	u32		block;
+	ext3_fileblk_t		block;
 	struct fake_dirent *fde;
 
 	blocksize =  dir->i_sb->s_blocksize;
@@ -1380,7 +1382,7 @@ static int ext3_add_entry (handle_t *han
 #endif
 	unsigned blocksize;
 	unsigned nlen, rlen;
-	u32 block, blocks;
+	ext3_fileblk_t block, blocks;
 
 	sb = dir->i_sb;
 	blocksize = sb->s_blocksize;
@@ -1463,7 +1465,7 @@ static int ext3_dx_add_entry(handle_t *h
 		       dx_get_count(entries), dx_get_limit(entries)));
 	/* Need to split index? */
 	if (dx_get_count(entries) == dx_get_limit(entries)) {
-		u32 newblock;
+		ext3_fileblk_t newblock;
 		unsigned icount = dx_get_count(entries);
 		int levels = frame - frames;
 		struct dx_entry *entries2;
diff -Nurp -x CVS ../../linux-2.6.17.org/fs/ext3/super.c linux-2.6.17-rc6-48bitext3/fs/ext3/super.c
--- ../../linux-2.6.17.org/fs/ext3/super.c	2006-06-19 17:31:49.000000000 +0800
+++ linux-2.6.17-rc6-48bitext3/fs/ext3/super.c	2006-06-20 14:58:51.000000000 +0800
@@ -2577,7 +2577,7 @@ static ssize_t ext3_quota_read(struct su
 			       size_t len, loff_t off)
 {
 	struct inode *inode = sb_dqopt(sb)->files[type];
-	sector_t blk = off >> EXT3_BLOCK_SIZE_BITS(sb);
+	ext3_fileblk_t blk = off >> EXT3_BLOCK_SIZE_BITS(sb);
 	int err = 0;
 	int offset = off & (sb->s_blocksize - 1);
 	int tocopy;
@@ -2615,7 +2615,7 @@ static ssize_t ext3_quota_write(struct s
 				const char *data, size_t len, loff_t off)
 {
 	struct inode *inode = sb_dqopt(sb)->files[type];
-	sector_t blk = off >> EXT3_BLOCK_SIZE_BITS(sb);
+	ext3_fileblk_t blk = off >> EXT3_BLOCK_SIZE_BITS(sb);
 	int err = 0;
 	int offset = off & (sb->s_blocksize - 1);
 	int tocopy;
diff -Nurp -x CVS ../../linux-2.6.17.org/include/linux/ext3_fs.h linux-2.6.17-rc6-48bitext3/include/linux/ext3_fs.h
--- ../../linux-2.6.17.org/include/linux/ext3_fs.h	2006-06-19 17:31:49.000000000 +0800
+++ linux-2.6.17-rc6-48bitext3/include/linux/ext3_fs.h	2006-06-20 14:59:41.000000000 +0800
@@ -897,10 +897,10 @@ extern unsigned long ext3_count_free (st
 /* inode.c */
 int ext3_forget(handle_t *handle, int is_metadata, struct inode *inode,
 		struct buffer_head *bh, ext3_fsblk_t blocknr);
-struct buffer_head * ext3_getblk (handle_t *, struct inode *, long, int, int *);
-struct buffer_head * ext3_bread (handle_t *, struct inode *, int, int, int *);
+struct buffer_head * ext3_getblk (handle_t *, struct inode *, ext3_fileblk_t, int, int *);
+struct buffer_head * ext3_bread (handle_t *, struct inode *, ext3_fileblk_t, int, int *);
 int ext3_get_blocks_handle(handle_t *handle, struct inode *inode,
-	sector_t iblock, unsigned long maxblocks, struct buffer_head *bh_result,
+	ext3_fileblk_t iblock, unsigned long maxblocks, struct buffer_head *bh_result,
 	int create, int extend_disksize);
 
 extern void ext3_read_inode (struct inode *);
diff -Nurp -x CVS ../../linux-2.6.17.org/include/linux/ext3_fs_i.h linux-2.6.17-rc6-48bitext3/include/linux/ext3_fs_i.h
--- ../../linux-2.6.17.org/include/linux/ext3_fs_i.h	2006-06-19 17:31:20.000000000 +0800
+++ linux-2.6.17-rc6-48bitext3/include/linux/ext3_fs_i.h	2006-06-20 14:59:41.000000000 +0800
@@ -27,6 +27,9 @@ typedef int ext3_grpblk_t;
 /* data type for filesystem-wide blocks number */
 typedef sector_t ext3_fsblk_t;
 
+/* data type for block offset of file */
+typedef unsigned long ext3_fileblk_t;
+
 #define E3FSBLK SECTOR_FMT
 
 struct ext3_reserve_window {
@@ -50,7 +53,7 @@ struct ext3_block_alloc_info {
 	 * most-recently-allocated block in this file.
 	 * We use this for detecting linearly ascending allocation requests.
 	 */
-	__u32                   last_alloc_logical_block;
+	ext3_fileblk_t                   last_alloc_logical_block;
 	/*
 	 * Was i_next_alloc_goal in ext3_inode_info
 	 * is the *physical* companion to i_next_alloc_block.
@@ -102,7 +105,7 @@ struct ext3_inode_info {
 	/* block reservation info */
 	struct ext3_block_alloc_info *i_block_alloc_info;
 
-	__u32	i_dir_start_lookup;
+	ext3_fileblk_t	i_dir_start_lookup;
 #ifdef CONFIG_EXT3_FS_XATTR
 	/*
 	 * Extended attributes can be read independently of the main file


Cheers, sho

