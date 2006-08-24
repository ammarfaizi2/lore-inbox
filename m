Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965263AbWHXA2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965263AbWHXA2m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 20:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965257AbWHXA2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 20:28:42 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:13025 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965242AbWHXA2l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 20:28:41 -0400
Message-ID: <44ECF2B2.2030205@us.ibm.com>
Date: Wed, 23 Aug 2006 17:28:34 -0700
From: Avantika Mathur LTC <mathur@us.ibm.com>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: cmm@us.ibm.com, linux-fsdevel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       laurent.vivier@bull.net
Subject: Re: [Ext2-devel] [PATCH 9/9]ext4 super block changes for >32 bit
 blocks numbers
References: <1155172945.3161.88.camel@localhost.localdomain>	 <20060809234105.67414f03.akpm@osdl.org>
In-Reply-To: <20060809234105.67414f03.akpm@osdl.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-09 at 23:41 -0700, Andrew Morton wrote:
> On Wed, 09 Aug 2006 18:22:25 -0700
> Mingming Cao <cmm@us.ibm.com <mailto:cmm@us.ibm.com>> wrote:
>
> > In-kernel and on-disk super block changes to support >32 bit blocks numbers.
> > 
> > +static inline u32 EXT4_RELATIVE_ENCODE(ext4_fsblk_t group_base,
> > +				       ext4_fsblk_t fs_block)
> > +{
> > +	s32 gdp_block;
> > +
> > +	if (fs_block < (1ULL<<32) && group_base < (1ULL<<32))
> > +		return fs_block;
> > +
> > +	gdp_block = (fs_block - group_base);
> > +	BUG_ON ((group_base + gdp_block) != fs_block);
> > +
> > +	return gdp_block;
> > +}
> > +
> > +static inline ext4_fsblk_t EXT4_RELATIVE_DECODE(ext4_fsblk_t group_base,
> > +						u32 gdp_block)
> > +{
> > +	if (group_base >= (1ULL<<32))
> > +		return group_base + (s32) gdp_block;
> > +
> > +	if ((s32) gdp_block >= 0 && gdp_block < group_base &&
> > +		  group_base + gdp_block >= (1ULL<<32))
> > +		return group_base + gdp_block;
> > +
> > +	return gdp_block;
> > +}
>
> These seem far too large and far too commonly called to be inlined.
>
> >  
> > +
> > +#define EXT4_BLOCKS_COUNT(s)	\
> > +	(ext4_fsblk_t)(((__u64)le32_to_cpu((s)->s_blocks_count_hi) << 32) |	\
> > +	 	(__u64)le32_to_cpu((s)->s_blocks_count))
> > +#define EXT4_BLOCKS_COUNT_SET(s,v)	do {				\
> > +	(s)->s_blocks_count = cpu_to_le32((v));				\
> > +	(s)->s_blocks_count_hi = cpu_to_le32(((__u64)(v)) >> 32);	\
> > +} while (0)
> > +
> > +#define EXT4_R_BLOCKS_COUNT(s)	\
> > +	(ext4_fsblk_t)(((__u64)le32_to_cpu((s)->s_r_blocks_count_hi) << 32) |	\
> > +		 (__u64)le32_to_cpu((s)->s_r_blocks_count))
> > +#define EXT4_R_BLOCKS_COUNT_SET(s,v)	do {				\
> > +	(s)->s_r_blocks_count = cpu_to_le32((v));			\
> > +	(s)->s_r_blocks_count_hi = cpu_to_le32(((__u64)(v)) >> 32);	\
> > +} while (0)
> > +
> > +#define EXT4_FREE_BLOCKS_COUNT(s)					\
> > +	(ext4_fsblk_t)(((__u64)le32_to_cpu((s)->s_free_blocks_count_hi) << 32) | \
> > +		 (__u64)le32_to_cpu((s)->s_free_blocks_count))
> > +#define EXT4_FREE_BLOCKS_COUNT_SET(s,v)	do {				\
> > +	(s)->s_free_blocks_count = cpu_to_le32((v));			\
> > +	(s)->s_free_blocks_count_hi = cpu_to_le32(((__u64)(v)) >> 32);	\
> > +} while (0)
>
> Can these not be implemented as C functions?
>
>   

Here is a patch to implement these macros as C functions

Thanks,
Avantika
---
Avantika Mathur
IBM LTC

---------------------------

diff -uprN linux-2.6.18-rc4/fs/ext4/balloc.c linux-2.6.18-rc4-patched/fs/ext4/balloc.c

--- linux-2.6.18-rc4/fs/ext4/balloc.c	2006-08-17 09:31:13.000000000 -0700

+++ linux-2.6.18-rc4-patched/fs/ext4/balloc.c	2006-08-14 15:33:30.000000000 -0700

@@ -331,7 +331,7 @@ void ext4_free_blocks_sb(handle_t *handl

 	es = sbi->s_es;

 	if (block < le32_to_cpu(es->s_first_data_block) ||
 	    block + count < block ||
-	    block + count > EXT4_BLOCKS_COUNT(es)) {
+	    block + count > ext4_blocks_count(es)) {
 		ext4_error (sb, "ext4_free_blocks",
 			    "Freeing blocks not in datazone - "
 			    "block = "E3FSBLK", count = %lu", block, count);
@@ -1174,7 +1174,7 @@ static int ext4_has_free_blocks(struct e
 	ext4_fsblk_t free_blocks, root_blocks;
 
 	free_blocks = percpu_counter_read_positive(&sbi->s_freeblocks_counter);
-	root_blocks = EXT4_R_BLOCKS_COUNT(sbi->s_es);
+	root_blocks = ext4_r_blocks_count(sbi->s_es);
 	if (free_blocks < root_blocks + 1 && !capable(CAP_SYS_RESOURCE) &&
 		sbi->s_resuid != current->fsuid &&
 		(sbi->s_resgid == 0 || !in_group_p (sbi->s_resgid))) {
@@ -1273,7 +1273,7 @@ ext4_fsblk_t ext4_new_blocks(handle_t *h
 	 * First, test whether the goal block is free.
 	 */
 	if (goal < le32_to_cpu(es->s_first_data_block) ||
-	    goal >= EXT4_BLOCKS_COUNT(es))
+	    goal >= ext4_blocks_count(es))
 		goal = le32_to_cpu(es->s_first_data_block);
 	ext4_get_group_no_and_offset(sb, goal, &group_no, &grp_target_blk);
 	gdp = ext4_get_group_desc(sb, group_no, &gdp_bh);
@@ -1419,11 +1419,11 @@ allocated:
 	jbd_unlock_bh_state(bitmap_bh);
 #endif
 
-	if (ret_block + num - 1 >= EXT4_BLOCKS_COUNT(es)) {
+	if (ret_block + num - 1 >= ext4_blocks_count(es)) {
 		ext4_error(sb, "ext4_new_block",
 			    "block("E3FSBLK") >= blocks count("E3FSBLK") - "
 			    "block_group = %lu, es == %p ", ret_block,
-			EXT4_BLOCKS_COUNT(es), group_no, es);
+			ext4_blocks_count(es), group_no, es);
 		goto out;
 	}
 
diff -uprN linux-2.6.18-rc4/fs/ext4/ialloc.c linux-2.6.18-rc4-patched/fs/ext4/ialloc.c
--- linux-2.6.18-rc4/fs/ext4/ialloc.c	2006-08-17 09:31:13.000000000 -0700
+++ linux-2.6.18-rc4-patched/fs/ext4/ialloc.c	2006-08-14 11:17:51.000000000 -0700
@@ -306,7 +306,7 @@ static int find_group_orlov(struct super
 		goto fallback;
 	}
 
-	blocks_per_dir = EXT4_BLOCKS_COUNT(es) - freeb;
+	blocks_per_dir = ext4_blocks_count(es) - freeb;
 	sector_div(blocks_per_dir, ndirs);
 
 	max_dirs = ndirs / ngroups + inodes_per_group / 16;
diff -uprN linux-2.6.18-rc4/fs/ext4/resize.c linux-2.6.18-rc4-patched/fs/ext4/resize.c
--- linux-2.6.18-rc4/fs/ext4/resize.c	2006-08-17 09:31:13.000000000 -0700
+++ linux-2.6.18-rc4-patched/fs/ext4/resize.c	2006-08-14 11:00:25.000000000 -0700
@@ -27,7 +27,7 @@ static int verify_group_input(struct sup
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_super_block *es = sbi->s_es;
-	ext4_fsblk_t start = EXT4_BLOCKS_COUNT(es);
+	ext4_fsblk_t start = ext4_blocks_count(es);
 	ext4_fsblk_t end = start + input->blocks_count;
 	unsigned group = input->group;
 	ext4_fsblk_t itend = input->inode_table + sbi->s_itb_per_group;
@@ -286,6 +286,18 @@ exit_journal:
 	return err;
 }
 
+static void ext4_blocks_count_set(struct ext4_super_block *es, __u32 v)
+{
+	es->s_blocks_count = cpu_to_le32(v);
+	es->s_blocks_count_hi = cpu_to_le32(((__u64) v) >> 32);
+}
+
+static void ext4_r_blocks_count_set(struct ext4_super_block *es, __u32 v)
+{
+	es->s_r_blocks_count = cpu_to_le32(v);
+	es->s_r_blocks_count_hi = cpu_to_le32(((__u64) v) >> 32);
+}
+
 /*
  * Iterate through the groups which hold BACKUP superblock/GDT copies in an
  * ext4 filesystem.  The counters should be initialized to 1, 5, and 7 before
@@ -836,7 +848,7 @@ int ext4_group_add(struct super_block *s
 	 * blocks/inodes before the group is live won't actually let us
 	 * allocate the new space yet.
 	 */
-	EXT4_BLOCKS_COUNT_SET(es, EXT4_BLOCKS_COUNT(es) +
+	ext4_blocks_count_set(es, ext4_blocks_count(es) +
 		input->blocks_count);
 	es->s_inodes_count = cpu_to_le32(le32_to_cpu(es->s_inodes_count) +
 		EXT4_INODES_PER_GROUP(sb));
@@ -872,7 +884,7 @@ int ext4_group_add(struct super_block *s
 
 	/* Update the reserved block counts only once the new group is
 	 * active. */
-	EXT4_R_BLOCKS_COUNT_SET(es, EXT4_R_BLOCKS_COUNT(es) +
+	ext4_r_blocks_count_set(es, ext4_r_blocks_count(es) +
 		input->reserved_blocks);
 
 	/* Update the free space counts */
@@ -923,7 +935,7 @@ int ext4_group_extend(struct super_block
 	/* We don't need to worry about locking wrt other resizers just
 	 * yet: we're going to revalidate es->s_blocks_count after
 	 * taking lock_super() below. */
-	o_blocks_count = EXT4_BLOCKS_COUNT(es);
+	o_blocks_count = ext4_blocks_count(es);
 	o_groups_count = EXT4_SB(sb)->s_groups_count;
 
 	if (test_opt(sb, DEBUG))
@@ -989,7 +1001,7 @@ int ext4_group_extend(struct super_block
 	}
 
 	lock_super(sb);
-	if (o_blocks_count != EXT4_BLOCKS_COUNT(es)) {
+	if (o_blocks_count != ext4_blocks_count(es)) {
 		ext4_warning(sb, __FUNCTION__,
 			     "multiple resizers run on filesystem!");
 		unlock_super(sb);
@@ -1005,7 +1017,7 @@ int ext4_group_extend(struct super_block
 		ext4_journal_stop(handle);
 		goto exit_put;
 	}
-	EXT4_BLOCKS_COUNT_SET(es, o_blocks_count + add);
+	ext4_blocks_count_set(es, o_blocks_count + add);
 	ext4_journal_dirty_metadata(handle, EXT4_SB(sb)->s_sbh);
 	sb->s_dirt = 1;
 	unlock_super(sb);
@@ -1018,7 +1030,7 @@ int ext4_group_extend(struct super_block
 		goto exit_put;
 	if (test_opt(sb, DEBUG))
 		printk(KERN_DEBUG "EXT4-fs: extended group to %llu blocks\n",
-		       EXT4_BLOCKS_COUNT(es));
+		       ext4_blocks_count(es));
 	update_backups(sb, EXT4_SB(sb)->s_sbh->b_blocknr, (char *)es,
 		       sizeof(struct ext4_super_block));
 exit_put:
diff -uprN linux-2.6.18-rc4/fs/ext4/super.c linux-2.6.18-rc4-patched/fs/ext4/super.c
--- linux-2.6.18-rc4/fs/ext4/super.c	2006-08-17 09:31:13.000000000 -0700
+++ linux-2.6.18-rc4-patched/fs/ext4/super.c	2006-08-17 14:46:51.000000000 -0700
@@ -62,6 +62,50 @@ static void ext4_unlockfs(struct super_b
 static void ext4_write_super (struct super_block * sb);
 static void ext4_write_super_lockfs(struct super_block *sb);
 
+ext4_fsblk_t ext4_blocks_count(struct ext4_super_block *es)
+{
+	return (ext4_fsblk_t) ((__u64)le32_to_cpu(es->s_blocks_count_hi) << 32 | 
+				(__u64)le32_to_cpu(es->s_blocks_count));
+}
+
+ext4_fsblk_t ext4_r_blocks_count(struct ext4_super_block *es)
+{
+	return (ext4_fsblk_t) ((__u64)le32_to_cpu(es->s_r_blocks_count_hi) << 32 | 
+				(__u64)le32_to_cpu(es->s_r_blocks_count));
+}
+
+u32 ext4_relative_encode(ext4_fsblk_t group_base, ext4_fsblk_t fs_block)
+{
+	s32 gdp_block;
+
+	if (fs_block < (1ULL<<32) && group_base < (1ULL<<32))
+		return fs_block;
+
+	gdp_block = (fs_block - group_base);
+	BUG_ON ((group_base + gdp_block) != fs_block);
+
+	return gdp_block;
+}
+
+ext4_fsblk_t ext4_relative_decode(ext4_fsblk_t group_base, u32 gdp_block)
+{
+	if (group_base >= (1ULL<<32))
+		return group_base + (s32) gdp_block;
+
+	if ((s32) gdp_block >= 0 && gdp_block < group_base &&
+	   	  group_base + gdp_block >= (1ULL<<32))
+		return group_base + gdp_block;
+
+	return gdp_block;
+}
+
+
+static void ext4_free_blocks_count_set(struct ext4_super_block *es, __u32 v)
+{
+	es->s_free_blocks_count = cpu_to_le32(v);
+	es->s_free_blocks_count_hi = cpu_to_le32(((__u64) v) >> 32);
+}
+
 /*
  * Wrappers for jbd2_journal_start/end.
  *
@@ -1191,7 +1235,7 @@ static int ext4_check_descriptors (struc
 		gdp++;
 	}
 
-	EXT4_FREE_BLOCKS_COUNT_SET(sbi->s_es, ext4_count_free_blocks(sb));
+	ext4_free_blocks_count_set(sbi->s_es, ext4_count_free_blocks(sb));
 	sbi->s_es->s_free_inodes_count=cpu_to_le32(ext4_count_free_inodes(sb));
 	return 1;
 }
@@ -1579,7 +1623,7 @@ static int ext4_fill_super (struct super
 		goto failed_mount;
 	}
 
-	if (EXT4_BLOCKS_COUNT(es) >
+	if (ext4_blocks_count(es) >
 		    (sector_t)(~0ULL) >> (sb->s_blocksize_bits - 9)) {
 		printk(KERN_ERR "EXT4-fs: filesystem on %s:"
 			" too large to mount safely\n", sb->s_id);
@@ -1591,7 +1635,7 @@ static int ext4_fill_super (struct super
 
 	if (EXT4_BLOCKS_PER_GROUP(sb) == 0)
 		goto cantfind_ext4;
-	blocks_count = (EXT4_BLOCKS_COUNT(es) -
+	blocks_count = (ext4_blocks_count(es) -
 			le32_to_cpu(es->s_first_data_block) +
 			EXT4_BLOCKS_PER_GROUP(sb) - 1);
 	do_div(blocks_count, EXT4_BLOCKS_PER_GROUP(sb));
@@ -1909,7 +1953,7 @@ static journal_t *ext4_get_dev_journal(s
 		goto out_bdev;
 	}
 
-	len = EXT4_BLOCKS_COUNT(es);
+	len = ext4_blocks_count(es);
 	start = sb_block + 1;
 	brelse(bh);	/* we're done with the superblock */
 
@@ -2079,7 +2123,7 @@ static void ext4_commit_super (struct su
 	if (!sbh)
 		return;
 	es->s_wtime = cpu_to_le32(get_seconds());
-	EXT4_FREE_BLOCKS_COUNT_SET(es, ext4_count_free_blocks(sb));
+	ext4_free_blocks_count_set(es, ext4_count_free_blocks(sb));
 	es->s_free_inodes_count = cpu_to_le32(ext4_count_free_inodes(sb));
 	BUFFER_TRACE(sbh, "marking dirty");
 	mark_buffer_dirty(sbh);
@@ -2272,7 +2316,7 @@ static int ext4_remount (struct super_bl
 	ext4_init_journal_params(sb, sbi->s_journal);
 
 	if ((*flags & MS_RDONLY) != (sb->s_flags & MS_RDONLY) ||
-		n_blocks_count > EXT4_BLOCKS_COUNT(es)) {
+		n_blocks_count > ext4_blocks_count(es)) {
 		if (sbi->s_mount_opt & EXT4_MOUNT_ABORT) {
 			err = -EROFS;
 			goto restore_opts;
@@ -2393,10 +2437,10 @@ static int ext4_statfs (struct dentry * 
 
 	buf->f_type = EXT4_SUPER_MAGIC;
 	buf->f_bsize = sb->s_blocksize;
-	buf->f_blocks = EXT4_BLOCKS_COUNT(es) - overhead;
+	buf->f_blocks = ext4_blocks_count(es) - overhead;
 	buf->f_bfree = percpu_counter_sum(&sbi->s_freeblocks_counter);
-	buf->f_bavail = buf->f_bfree - EXT4_R_BLOCKS_COUNT(es);
-	if (buf->f_bfree < EXT4_R_BLOCKS_COUNT(es))
+	buf->f_bavail = buf->f_bfree - ext4_r_blocks_count(es);
+	if (buf->f_bfree < ext4_r_blocks_count(es))
 		buf->f_bavail = 0;
 	buf->f_files = le32_to_cpu(es->s_inodes_count);
 	buf->f_ffree = percpu_counter_sum(&sbi->s_freeinodes_counter);
diff -uprN linux-2.6.18-rc4/include/linux/ext4_fs.h linux-2.6.18-rc4-patched/include/linux/ext4_fs.h
--- linux-2.6.18-rc4/include/linux/ext4_fs.h	2006-08-17 09:31:13.000000000 -0700
+++ linux-2.6.18-rc4-patched/include/linux/ext4_fs.h	2006-08-17 14:39:22.000000000 -0700
@@ -139,46 +139,20 @@ struct ext4_group_desc
 #ifdef __KERNEL__
 #include <linux/ext4_fs_i.h>
 #include <linux/ext4_fs_sb.h>
-static inline u32 EXT4_RELATIVE_ENCODE(ext4_fsblk_t group_base,
-				       ext4_fsblk_t fs_block)
-{
-	s32 gdp_block;
-
-	if (fs_block < (1ULL<<32) && group_base < (1ULL<<32))
-		return fs_block;
-
-	gdp_block = (fs_block - group_base);
-	BUG_ON ((group_base + gdp_block) != fs_block);
-
-	return gdp_block;
-}
-
-static inline ext4_fsblk_t EXT4_RELATIVE_DECODE(ext4_fsblk_t group_base,
-						u32 gdp_block)
-{
-	if (group_base >= (1ULL<<32))
-		return group_base + (s32) gdp_block;
-
-	if ((s32) gdp_block >= 0 && gdp_block < group_base &&
-		  group_base + gdp_block >= (1ULL<<32))
-		return group_base + gdp_block;
-
-	return gdp_block;
-}
 
 #define EXT4_BLOCK_BITMAP(bg, group_base)	\
-		EXT4_RELATIVE_DECODE(group_base, le32_to_cpu((bg)->bg_block_bitmap))
+		ext4_relative_decode(group_base, le32_to_cpu((bg)->bg_block_bitmap))
 #define EXT4_INODE_BITMAP(bg, group_base)	\
-		EXT4_RELATIVE_DECODE(group_base, le32_to_cpu((bg)->bg_inode_bitmap))
+		ext4_relative_decode(group_base, le32_to_cpu((bg)->bg_inode_bitmap))
 #define EXT4_INODE_TABLE(bg, group_base)	\
-		EXT4_RELATIVE_DECODE(group_base, le32_to_cpu((bg)->bg_inode_table))
+		ext4_relative_decode(group_base, le32_to_cpu((bg)->bg_inode_table))
 
 #define EXT4_BLOCK_BITMAP_SET(bg, group_base, value)	\
-	do {(bg)->bg_block_bitmap = EXT4_RELATIVE_ENCODE(group_base, value);} while(0)
+	do {(bg)->bg_block_bitmap = ext4_relative_encode(group_base, value);} while(0)
 #define EXT4_INODE_BITMAP_SET(bg, group_base, value)	\
-	do {(bg)->bg_inode_bitmap = EXT4_RELATIVE_ENCODE(group_base, value);} while(0)
+	do {(bg)->bg_inode_bitmap = ext4_relative_encode(group_base, value);} while(0)
 #define EXT4_INODE_TABLE_SET(bg, group_base, value)	\
-	do {(bg)->bg_inode_table = EXT4_RELATIVE_ENCODE(group_base, value);} while(0)
+	do {(bg)->bg_inode_table = ext4_relative_encode(group_base, value);} while(0)
 
 #define EXT4_IS_USED_BLOCK_BITMAP(bg)	\
 	((bg)->bg_block_bitmap != 0)
@@ -543,30 +517,9 @@ struct ext4_super_block {
 	__u32	s_reserved[169];	/* Padding to the end of the block */
 };
 
-
-#define EXT4_BLOCKS_COUNT(s)	\
-	(ext4_fsblk_t)(((__u64)le32_to_cpu((s)->s_blocks_count_hi) << 32) |	\
-	 	(__u64)le32_to_cpu((s)->s_blocks_count))
-#define EXT4_BLOCKS_COUNT_SET(s,v)	do {				\
-	(s)->s_blocks_count = cpu_to_le32((v));				\
-	(s)->s_blocks_count_hi = cpu_to_le32(((__u64)(v)) >> 32);	\
-} while (0)
-
-#define EXT4_R_BLOCKS_COUNT(s)	\
-	(ext4_fsblk_t)(((__u64)le32_to_cpu((s)->s_r_blocks_count_hi) << 32) |	\
-		 (__u64)le32_to_cpu((s)->s_r_blocks_count))
-#define EXT4_R_BLOCKS_COUNT_SET(s,v)	do {				\
-	(s)->s_r_blocks_count = cpu_to_le32((v));			\
-	(s)->s_r_blocks_count_hi = cpu_to_le32(((__u64)(v)) >> 32);	\
-} while (0)
-
 #define EXT4_FREE_BLOCKS_COUNT(s)					\
 	(ext4_fsblk_t)(((__u64)le32_to_cpu((s)->s_free_blocks_count_hi) << 32) | \
 		 (__u64)le32_to_cpu((s)->s_free_blocks_count))
-#define EXT4_FREE_BLOCKS_COUNT_SET(s,v)	do {				\
-	(s)->s_free_blocks_count = cpu_to_le32((v));			\
-	(s)->s_free_blocks_count_hi = cpu_to_le32(((__u64)(v)) >> 32);	\
-} while (0)
 
 #ifdef __KERNEL__
 static inline struct ext4_sb_info * EXT4_SB(struct super_block *sb)
@@ -947,6 +900,10 @@ extern void ext4_abort (struct super_blo
 extern void ext4_warning (struct super_block *, const char *, const char *, ...)
 	__attribute__ ((format (printf, 3, 4)));
 extern void ext4_update_dynamic_rev (struct super_block *sb);
+extern ext4_fsblk_t ext4_blocks_count(struct ext4_super_block *es);
+extern ext4_fsblk_t ext4_r_blocks_count(struct ext4_super_block *es);
+extern u32 ext4_relative_encode(ext4_fsblk_t group_base, ext4_fsblk_t fs_block);
+extern ext4_fsblk_t ext4_relative_decode(ext4_fsblk_t group_base, u32 gdp_block);
 
 #define ext4_std_error(sb, errno)				\
 do {								\




