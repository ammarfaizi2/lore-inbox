Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265898AbTAFEdx>; Sun, 5 Jan 2003 23:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265982AbTAFEdx>; Sun, 5 Jan 2003 23:33:53 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:60654 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id <S265898AbTAFEdv>; Sun, 5 Jan 2003 23:33:51 -0500
Date: Sun, 5 Jan 2003 21:42:09 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Andrew Morton <akpm@zip.com.au>,
       "Rusty's Trivial Patches" <trivial@rustcorp.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5 ext3 ino_t removal
Message-ID: <20030105214209.C31555@schatzie.adilger.int>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	Rusty's Trivial Patches <trivial@rustcorp.com.au>,
	linux-kernel@vger.kernel.org
References: <20030105213303.B31555@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030105213303.B31555@schatzie.adilger.int>; from adilger@clusterfs.com on Sun, Jan 05, 2003 at 09:33:03PM -0700
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 05, 2003  21:33 -0700, Andreas Dilger wrote:
> This patch against 2.5.53 removes my erronous use of ino_t in a
> couple of places in the ext3 code.  This has been replaced with unsigned
> long (the same as is used for inode->i_ino).  This patch matches the fix
> submitted to 2.4 for fixing 64-bit compiler warnings, and also replaces a
> couple of %ld with %lu to forestall output wierdness with filesystems with
> a few billion inodes.

Sorry - I sent the 2.4 version in the previous patch.  This is the 2.5
version.

Cheers, Andreas
======================= ext3-2.5-ino_t.diff ===============================
--- 1.24/fs/ext3/ialloc.c	Sat Dec 21 09:24:41 2002
+++ edited/fs/ext3/ialloc.c	Sat Jan  4 12:49:23 2003
@@ -417,7 +417,7 @@
 	struct buffer_head *bitmap_bh = NULL;
 	struct buffer_head *bh2;
 	int group;
-	ino_t ino;
+	unsigned long ino;
 	struct inode * inode;
 	struct ext3_group_desc * gdp;
 	struct ext3_super_block * es;
@@ -463,7 +463,7 @@
 		BUFFER_TRACE(bitmap_bh, "get_write_access");
 		err = ext3_journal_get_write_access(handle, bitmap_bh);
 		if (err) goto fail;
-		
+
 		if (ext3_set_bit(ino, bitmap_bh->b_data)) {
 			ext3_error (sb, "ext3_new_inode",
 				      "bit already set for inode %lu", ino);
@@ -619,19 +619,18 @@
 }
 
 /* Verify that we are loading a valid orphan from disk */
-struct inode *ext3_orphan_get (struct super_block * sb, ino_t ino)
+struct inode *ext3_orphan_get(struct super_block *sb, unsigned long ino)
 {
-	ino_t max_ino = le32_to_cpu(EXT3_SB(sb)->s_es->s_inodes_count);
+	unsigned long max_ino = le32_to_cpu(EXT3_SB(sb)->s_es->s_inodes_count);
 	unsigned long block_group;
 	int bit;
 	struct buffer_head *bitmap_bh = NULL;
 	struct inode *inode = NULL;
-	
+
 	/* Error cases - e2fsck has already cleaned up for us */
 	if (ino > max_ino) {
 		ext3_warning(sb, __FUNCTION__,
-			     "bad orphan ino %lu!  e2fsck was run?\n",
-			     (unsigned long) ino);
+			     "bad orphan ino %lu!  e2fsck was run?\n", ino);
 		goto out;
 	}
 
@@ -640,8 +639,7 @@
 	bitmap_bh = read_inode_bitmap(sb, block_group);
 	if (!bitmap_bh) {
 		ext3_warning(sb, __FUNCTION__,
-			     "inode bitmap error for orphan %lu\n",
-			     (unsigned long) ino);
+			     "inode bitmap error for orphan %lu\n", ino);
 		goto out;
 	}
 
@@ -653,19 +651,17 @@
 			!(inode = iget(sb, ino)) || is_bad_inode(inode) ||
 			NEXT_ORPHAN(inode) > max_ino) {
 		ext3_warning(sb, __FUNCTION__,
-			     "bad orphan inode %lu!  e2fsck was run?\n", (unsigned long)ino);
+			     "bad orphan inode %lu!  e2fsck was run?\n", ino);
 		printk(KERN_NOTICE "ext3_test_bit(bit=%d, block=%llu) = %d\n",
-		       bit, 
-			(unsigned long long)bitmap_bh->b_blocknr, 
-			ext3_test_bit(bit, bitmap_bh->b_data));
+		       bit, (unsigned long long)bitmap_bh->b_blocknr,
+		       ext3_test_bit(bit, bitmap_bh->b_data));
 		printk(KERN_NOTICE "inode=%p\n", inode);
 		if (inode) {
 			printk(KERN_NOTICE "is_bad_inode(inode)=%d\n",
 			       is_bad_inode(inode));
-			printk(KERN_NOTICE "NEXT_ORPHAN(inode)=%d\n",
+			printk(KERN_NOTICE "NEXT_ORPHAN(inode)=%u\n",
 			       NEXT_ORPHAN(inode));
-			printk(KERN_NOTICE "max_ino=%lu\n",
-			       (unsigned long) max_ino);
+			printk(KERN_NOTICE "max_ino=%lu\n", max_ino);
 		}
 		/* Avoid freeing blocks if we got a bad deleted inode */
 		if (inode && inode->i_nlink == 0)
--- 1.32/fs/ext3/namei.c	Sat Dec 21 09:24:44 2002
+++ edited/fs/ext3/namei.c	Sat Jan  4 12:53:06 2003
@@ -1869,10 +1869,10 @@
 	struct list_head *prev;
 	struct ext3_inode_info *ei = EXT3_I(inode);
 	struct ext3_sb_info *sbi;
-	ino_t ino_next; 
+	unsigned long ino_next;
 	struct ext3_iloc iloc;
 	int err = 0;
-	
+
 	lock_super(inode->i_sb);
 	if (list_empty(&ei->i_orphan)) {
 		unlock_super(inode->i_sb);
@@ -1883,7 +1883,7 @@
 	prev = ei->i_orphan.prev;
 	sbi = EXT3_SB(inode->i_sb);
 
-	jbd_debug(4, "remove inode %ld from orphan list\n", inode->i_ino);
+	jbd_debug(4, "remove inode %lu from orphan list\n", inode->i_ino);
 
 	list_del_init(&ei->i_orphan);
 
@@ -1893,13 +1893,13 @@
 	 * list in memory. */
 	if (!handle)
 		goto out;
-	
+
 	err = ext3_reserve_inode_write(handle, inode, &iloc);
 	if (err)
 		goto out_err;
 
 	if (prev == &sbi->s_orphan) {
-		jbd_debug(4, "superblock will point to %ld\n", ino_next);
+		jbd_debug(4, "superblock will point to %lu\n", ino_next);
 		BUFFER_TRACE(sbi->s_sbh, "get_write_access");
 		err = ext3_journal_get_write_access(handle, sbi->s_sbh);
 		if (err)
@@ -1910,8 +1910,8 @@
 		struct ext3_iloc iloc2;
 		struct inode *i_prev =
 			&list_entry(prev, struct ext3_inode_info, i_orphan)->vfs_inode;
-		
-		jbd_debug(4, "orphan inode %ld will point to %ld\n",
+
+		jbd_debug(4, "orphan inode %lu will point to %lu\n",
 			  i_prev->i_ino, ino_next);
 		err = ext3_reserve_inode_write(handle, i_prev, &iloc2);
 		if (err)
@@ -1926,7 +1926,7 @@
 	if (err)
 		goto out_brelse;
 
-out_err: 	
+out_err:
 	ext3_std_error(inode->i_sb, err);
 out:
 	unlock_super(inode->i_sb);
--- 1.20/include/linux/ext3_fs.h	Sun Nov 17 12:00:57 2002
+++ edited/include/linux/ext3_fs.h	Sat Jan  4 12:45:16 2003
@@ -704,7 +704,7 @@
 /* ialloc.c */
 extern struct inode * ext3_new_inode (handle_t *, struct inode *, int);
 extern void ext3_free_inode (handle_t *, struct inode *);
-extern struct inode * ext3_orphan_get (struct super_block *, ino_t);
+extern struct inode * ext3_orphan_get (struct super_block *, unsigned long);
 extern unsigned long ext3_count_free_inodes (struct super_block *);
 extern unsigned long ext3_count_dirs (struct super_block *);
 extern void ext3_check_inodes_bitmap (struct super_block *);

--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

