Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267107AbTB0UuZ>; Thu, 27 Feb 2003 15:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267117AbTB0UuZ>; Thu, 27 Feb 2003 15:50:25 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:64506 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id <S267107AbTB0UuS>; Thu, 27 Feb 2003 15:50:18 -0500
Date: Thu, 27 Feb 2003 14:00:19 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Daniel Phillips <phillips@arcor.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, "Theodore Ts'o" <tytso@mit.edu>,
       chrisl@vmware.com
Subject: Re: [Bug 417] New: htree much slower than regular ext3
Message-ID: <20030227140019.G1373@schatzie.adilger.int>
Mail-Followup-To: Daniel Phillips <phillips@arcor.de>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	ext2-devel@lists.sourceforge.net, Theodore Ts'o <tytso@mit.edu>,
	chrisl@vmware.com
References: <11490000.1046367063@[10.10.2.4]> <20030227200425.253F03FE26@mx01.nexgo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030227200425.253F03FE26@mx01.nexgo.de>; from phillips@arcor.de on Fri, Feb 28, 2003 at 03:55:37AM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 28, 2003  03:55 +0100, Daniel Phillips wrote:
> On Thursday 27 February 2003 18:31, Martin J. Bligh wrote:
> > Problem Description:
> > I created a directory ("test") with 32000 (ok, 31998) directories in it,
> > and  put a file called 'foo' in each of them (for i in `ls`; do cd $i &&
> > touch bar  && cd .. ; done). Then I took that ext3 partion, umounted it,
> > did a 'tune2fs -O  dir_index', then 'fsck -fD', and remounted. I then did a
> > 'time du -hs' on the  test directory, and here are the results.
> >
> > ext3+htree:
> > bwindle@razor:/giant/inodes$ time du -hs
> > 126M    .
> >
> > real    7m21.756s
> > user    0m2.021s
> > sys     0m22.190s
> >
> > I then unmounted, tune2fs -O ^dir_index, e2fsck -fD /dev/hdb1, remounted,
> > and  did another du -hs on the test directory. It took 1 minute, 48
> > seconds.
> >
> > bwindle@razor:/giant/test$ time du -hs
> > 126M    .
> >
> > real    1m48.760s
> > user    0m1.986s
> > sys     0m21.563s
> >
> >
> > I thought htree was supposed to speed up access with large numbers of
> > directories?
> 
> The du just does getdents and lstats in physical storage order, so there's no 
> possible benefit from indexing in this case, and unindexed ext3 avoids long
> search times by caching the position at which it last found an entry.  That 
> answers the question "why doesn't it speed up", however, "why did it slow way 
> down" is harder.
> 
> The single-file leaves of your directory tree don't carry any index (it's not 
> worth it with only one file) and therfore use the same code path as unindexed 
> ext3, so there's no culprit there.  I'm looking suspiciously at 
> ext3_dx_readdir, which is apparently absorbing about 11 ms per returned 
> entry. To put this in perspective, I'm used to seeing individual directory 
> operation times well below 100 us, so even if each dirent cost as much as a 
> full lookup, you'd see less than 3 seconds overhead for your 30,000 
> directories.
> 
> 11 ms sounds like two seeks for each returned dirent, which sounds like a bug.

I think you are pretty dead on there.  The difference is that with unindexed
entries, the directory entry and the inode are in the same order, while with
indexed directories they are essentially in random order to each other.  That
means that each directory lookup causes a seek to get the directory inode data
instead of doing allocation order (which is sequential reads on disk).

In the past both would have been slow equally, but the orlov allocator in
2.5 causes a number of directories to be created in the same group before
moving on to the next group, so you have nice batches of sequential reads.

I've got a patch which should help here, although it was originally written
to speed up the "create" case instead of the "lookup" case.  In the lookup
case, it will do a pre-read of a number of inode table blocks, since the cost
of doing a 64kB read and doing a 4kB read is basically the same - the cost
of the seek.

The patch was written for a 2.4.18 RH kernel, but I think the areas touched
(ext3_get_inode_loc and ext3_new_inode) are relatively unchanged, so it
should be fairly straightforward to fix the rejects by hand for 2.5.

For the create case, the patch speeds up lots-of-file creation rates a lot
(50%), regardless of whether we are using htree or not.  That is because we
do not read in empty inode table blocks from disk (which will be slow
behind a bunch of writes going on), and instead we have a pure write
workload (with the exception of reading in the inode bitmaps occasionally).

Cheers, Andreas
======================= ext3-noread.diff ====================================
diff -ru lustre-head/fs/ext3/ialloc.c lustre/fs/ext3/ialloc.c
--- lustre-head/fs/ext3/ialloc.c	Mon Dec 23 10:02:58 2002
+++ lustre/fs/ext3/ialloc.c	Mon Dec 23 09:46:20 2002
@@ -289,6 +289,37 @@
 }
 
 /*
+ * @block_group: block group of inode
+ * @offset: relative offset of inode within @block_group
+ *
+ * Check whether any of the inodes in this disk block are in use.
+ *
+ * Caller must be holding superblock lock (group/bitmap read lock in future).
+ */
+int ext3_itable_block_used(struct super_block *sb, unsigned int block_group,
+			   int offset)
+{
+	int bitmap_nr = load_inode_bitmap(sb, block_group);
+	int inodes_per_block;
+	unsigned long inum, iend;
+	struct buffer_head *ibitmap;
+
+	if (bitmap_nr < 0)
+		return 1;
+
+	inodes_per_block = sb->s_blocksize / EXT3_SB(sb)->s_inode_size;
+	inum = offset & ~(inodes_per_block - 1);
+	iend = inum + inodes_per_block;
+	ibitmap = EXT3_SB(sb)->s_inode_bitmap[bitmap_nr];
+	for (; inum < iend; inum++) {
+		if (inum != offset && ext3_test_bit(inum, ibitmap->b_data))
+			return 1;
+	}
+
+	return 0;
+}
+
+/*
  * There are two policies for allocating an inode.  If the new inode is
  * a directory, then a forward search is made for a block group with both
  * free space and a low directory-to-inode ratio; if that fails, then of
@@ -312,6 +343,7 @@
 	struct ext3_group_desc * gdp;
 	struct ext3_group_desc * tmp;
 	struct ext3_super_block * es;
+	struct ext3_iloc iloc;
 	int err = 0;
 
 	/* Cannot create files in a deleted directory */
@@ -514,9 +547,18 @@
 	inode->i_generation = sbi->s_next_generation++;
 
 	ei->i_state = EXT3_STATE_NEW;
-	err = ext3_mark_inode_dirty(handle, inode);
+	err = ext3_get_inode_loc_new(inode, &iloc, 1);
 	if (err) goto fail;
-	
+	BUFFER_TRACE(iloc->bh, "get_write_access");
+	err = ext3_journal_get_write_access(handle, iloc.bh);
+	if (err) {
+		brelse(iloc.bh);
+		iloc.bh = NULL;
+		goto fail;
+	}
+	err = ext3_mark_iloc_dirty(handle, inode, &iloc);
+	if (err) goto fail;
+
 	unlock_super (sb);
 	if(DQUOT_ALLOC_INODE(inode)) {
 		DQUOT_DROP(inode);
diff -ru lustre-head/fs/ext3/inode.c lustre/fs/ext3/inode.c
--- lustre-head/fs/ext3/inode.c	Mon Dec 23 10:02:58 2002
+++ lustre/fs/ext3/inode.c	Mon Dec 23 09:50:25 2002
@@ -2011,16 +1994,25 @@
 	ext3_journal_stop(handle, inode);
 }
 
-/* 
- * ext3_get_inode_loc returns with an extra refcount against the
- * inode's underlying buffer_head on success. 
- */
+extern int ext3_itable_block_used(struct super_block *sb,
+				  unsigned int block_group,
+				  int offset);
+
+#define NUM_INODE_PREREAD 16
 
-int ext3_get_inode_loc (struct inode *inode, struct ext3_iloc *iloc)
+/*
+ * ext3_get_inode_loc returns with an extra refcount against the inode's
+ * underlying buffer_head on success.  If this is for a new inode allocation
+ * (new is non-zero) then we may be able to optimize away the read if there
+ * are no other in-use inodes in this inode table block.  If we need to do
+ * a read, then read in a whole chunk of blocks to avoid blocking again soon
+ * if we are doing lots of creates/updates.
+ */
+int ext3_get_inode_loc_new(struct inode *inode, struct ext3_iloc *iloc, int new)
 {
 	struct super_block *sb = inode->i_sb;
 	struct ext3_sb_info *sbi = EXT3_SB(sb);
-	struct buffer_head *bh = 0;
+	struct buffer_head *bh[NUM_INODE_PREREAD];
 	unsigned long block;
 	unsigned long block_group;
 	unsigned long group_desc;
@@ -2042,38 +2034,86 @@
 	}
 	group_desc = block_group >> sbi->s_desc_per_block_bits;
 	desc = block_group & (sbi->s_desc_per_block - 1);
-	bh = sbi->s_group_desc[group_desc];
-	if (!bh) {
+	if (!sbi->s_group_desc[group_desc]) {
 		ext3_error(sb, __FUNCTION__, "Descriptor not loaded");
 		goto bad_inode;
 	}
 
-	gdp = (struct ext3_group_desc *) bh->b_data;
+	gdp = (struct ext3_group_desc *)(sbi->s_group_desc[group_desc]->b_data);
+
 	/*
 	 * Figure out the offset within the block group inode table
 	 */
-	offset = ((inode->i_ino - 1) % sbi->s_inodes_per_group) *
-		sbi->s_inode_size;
+	offset = ((inode->i_ino - 1) % sbi->s_inodes_per_group);
+
 	block = le32_to_cpu(gdp[desc].bg_inode_table) +
-		(offset >> EXT3_BLOCK_SIZE_BITS(sb));
-	if (!(bh = sb_bread(sb, block))) {
-		ext3_error (sb, __FUNCTION__,
-			    "unable to read inode block - "
-			    "inode=%lu, block=%lu", inode->i_ino, block);
-		goto bad_inode;
+		(offset * sbi->s_inode_size >> EXT3_BLOCK_SIZE_BITS(sb));
+
+	bh[0] = sb_getblk(sb, block);
+	if (buffer_uptodate(bh[0]))
+		goto done;
+
+	/* If we don't really need to read this block, and it isn't already
+	 * in memory, then we just zero it out.  Otherwise, we keep the
+	 * current block contents (deleted inode data) for posterity.
+	 */
+	if (new && !ext3_itable_block_used(sb, block_group, offset)) {
+		lock_buffer(bh[0]);
+		memset(bh[0]->b_data, 0, bh[0]->b_size);
+		mark_buffer_uptodate(bh[0], 1);
+		unlock_buffer(bh[0]);
+	} else {
+		unsigned long block_end, itable_end;
+		int count = 1;
+
+		itable_end = le32_to_cpu(gdp[desc].bg_inode_table) +
+				sbi->s_itb_per_group;
+		block_end = block + NUM_INODE_PREREAD;
+		if (block_end > itable_end)
+			block_end = itable_end;
+
+		for (; block < block_end; block++) {
+			bh[count] = sb_getblk(sb, block);
+			if (count && (buffer_uptodate(bh[count]) ||
+				      buffer_locked(bh[count]))) {
+				__brelse(bh[count]);
+			} else
+				count++;
+		}
+
+		ll_rw_block(READ, count, bh);
+
+		/* Release all but the block we actually need (bh[0]) */
+		while (--count > 0)
+			__brelse(bh[count]);
+
+		wait_on_buffer(bh[0]);
+		if (!buffer_uptodate(bh[0])) {
+			ext3_error(sb, __FUNCTION__,
+				   "unable to read inode block - "
+				   "inode=%lu, block=%lu", inode->i_ino,
+				   bh[0]->b_blocknr);
+			goto bad_inode;
+		}
 	}
-	offset &= (EXT3_BLOCK_SIZE(sb) - 1);
+ done:
+	offset = (offset * sbi->s_inode_size) & (EXT3_BLOCK_SIZE(sb) - 1);
 
-	iloc->bh = bh;
-	iloc->raw_inode = (struct ext3_inode *) (bh->b_data + offset);
+	iloc->bh = bh[0];
+	iloc->raw_inode = (struct ext3_inode *)(bh[0]->b_data + offset);
 	iloc->block_group = block_group;
-	
+
 	return 0;
-	
+
  bad_inode:
 	return -EIO;
 }
 
+int ext3_get_inode_loc(struct inode *inode, struct ext3_iloc *iloc)
+{
+	return ext3_get_inode_loc_new(inode, iloc, 0);
+}
+
 void ext3_read_inode(struct inode * inode)
 {
 	struct ext3_iloc iloc;
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

