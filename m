Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266274AbTAFENc>; Sun, 5 Jan 2003 23:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266292AbTAFENc>; Sun, 5 Jan 2003 23:13:32 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:56814 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id <S266274AbTAFEN3>; Sun, 5 Jan 2003 23:13:29 -0500
Date: Sun, 5 Jan 2003 21:21:37 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       "Rusty's Trivial Patches" <trivial@rustcorp.com.au>,
       "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4 ext3 ino_t removal
Message-ID: <20030105212137.A31555@schatzie.adilger.int>
Mail-Followup-To: Marcelo Tosatti <marcelo@conectiva.com.br>,
	Rusty's Trivial Patches <trivial@rustcorp.com.au>,
	"Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.4.21-pre2 removes my erronous use of ino_t in a
couple of places in the ext3 code.  This has been replaced with unsigned
long (the same as is used for inode->i_ino).  This quiets a bunch of
warnings on ia64 compiles, and also replaces a couple of %ld with %lu
to forestall output wierdness with filesystems with a few billion inodes.

Cheers, Andreas
======================= ext3-2.4-ino_t.diff ===============================
--- linux/fs/ext3/ialloc.c.orig	Sat Oct 19 11:42:23 2002
+++ linux/fs/ext3/ialloc.c	Sat Jan  4 12:14:18 2003
@@ -64,8 +64,8 @@ static int read_inode_bitmap (struct sup
 	if (!bh) {
 		ext3_error (sb, "read_inode_bitmap",
 			    "Cannot read inode bitmap - "
-			    "block_group = %lu, inode_bitmap = %lu",
-			    block_group, (unsigned long) gdp->bg_inode_bitmap);
+			    "block_group = %lu, inode_bitmap = %u",
+			    block_group, gdp->bg_inode_bitmap);
 		retval = -EIO;
 	}
 	/*
@@ -531,19 +532,19 @@ out:
 }
 
 /* Verify that we are loading a valid orphan from disk */
-struct inode *ext3_orphan_get (struct super_block * sb, ino_t ino)
+struct inode *ext3_orphan_get(struct super_block *sb, unsigned long ino)
 {
-	ino_t max_ino = le32_to_cpu(EXT3_SB(sb)->s_es->s_inodes_count);
+	unsigned long max_ino = le32_to_cpu(EXT3_SB(sb)->s_es->s_inodes_count);
 	unsigned long block_group;
 	int bit;
 	int bitmap_nr;
 	struct buffer_head *bh;
 	struct inode *inode = NULL;
-	
+
 	/* Error cases - e2fsck has already cleaned up for us */
 	if (ino > max_ino) {
 		ext3_warning(sb, __FUNCTION__,
-			     "bad orphan ino %ld!  e2fsck was run?\n", ino);
+			     "bad orphan ino %lu!  e2fsck was run?\n", ino);
 		return NULL;
 	}
 
@@ -552,7 +553,7 @@ struct inode *ext3_orphan_get (struct su
 	if ((bitmap_nr = load_inode_bitmap(sb, block_group)) < 0 ||
 	    !(bh = EXT3_SB(sb)->s_inode_bitmap[bitmap_nr])) {
 		ext3_warning(sb, __FUNCTION__,
-			     "inode bitmap error for orphan %ld\n", ino);
+			     "inode bitmap error for orphan %lu\n", ino);
 		return NULL;
 	}
 
@@ -563,7 +564,7 @@ struct inode *ext3_orphan_get (struct su
 	if (!ext3_test_bit(bit, bh->b_data) || !(inode = iget(sb, ino)) ||
 	    is_bad_inode(inode) || NEXT_ORPHAN(inode) > max_ino) {
 		ext3_warning(sb, __FUNCTION__,
-			     "bad orphan inode %ld!  e2fsck was run?\n", ino);
+			     "bad orphan inode %lu!  e2fsck was run?\n", ino);
 		printk(KERN_NOTICE "ext3_test_bit(bit=%d, block=%ld) = %d\n",
 		       bit, bh->b_blocknr, ext3_test_bit(bit, bh->b_data));
 		printk(KERN_NOTICE "inode=%p\n", inode);
@@ -570,9 +571,9 @@ struct inode *ext3_orphan_get (struct su
 		if (inode) {
 			printk(KERN_NOTICE "is_bad_inode(inode)=%d\n",
 			       is_bad_inode(inode));
-			printk(KERN_NOTICE "NEXT_ORPHAN(inode)=%d\n",
+			printk(KERN_NOTICE "NEXT_ORPHAN(inode)=%u\n",
 			       NEXT_ORPHAN(inode));
-			printk(KERN_NOTICE "max_ino=%ld\n", max_ino);
+			printk(KERN_NOTICE "max_ino=%lu\n", max_ino);
 		}
 		/* Avoid freeing blocks if we got a bad deleted inode */
 		if (inode && inode->i_nlink == 0)
--- linux/fs/ext3/namei.c.orig	Sat Oct 19 11:42:45 2002
+++ linux/fs/ext3/namei.c	Sat Jan  4 12:13:27 2003
@@ -716,10 +716,10 @@ int ext3_orphan_del(handle_t *handle, st
 {
 	struct list_head *prev;
 	struct ext3_sb_info *sbi;
-	ino_t ino_next; 
+	unsigned long ino_next;
 	struct ext3_iloc iloc;
 	int err = 0;
-	
+
 	lock_super(inode->i_sb);
 	if (list_empty(&inode->u.ext3_i.i_orphan)) {
 		unlock_super(inode->i_sb);
@@ -730,7 +730,7 @@ int ext3_orphan_del(handle_t *handle, st
 	prev = inode->u.ext3_i.i_orphan.prev;
 	sbi = EXT3_SB(inode->i_sb);
 
-	jbd_debug(4, "remove inode %ld from orphan list\n", inode->i_ino);
+	jbd_debug(4, "remove inode %lu from orphan list\n", inode->i_ino);
 
 	list_del(&inode->u.ext3_i.i_orphan);
 	INIT_LIST_HEAD(&inode->u.ext3_i.i_orphan);
@@ -741,13 +741,13 @@ int ext3_orphan_del(handle_t *handle, st
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
@@ -758,8 +758,8 @@ int ext3_orphan_del(handle_t *handle, st
 		struct ext3_iloc iloc2;
 		struct inode *i_prev =
 			list_entry(prev, struct inode, u.ext3_i.i_orphan);
-		
-		jbd_debug(4, "orphan inode %ld will point to %ld\n",
+
+		jbd_debug(4, "orphan inode %lu will point to %lu\n",
 			  i_prev->i_ino, ino_next);
 		err = ext3_reserve_inode_write(handle, i_prev, &iloc2);
 		if (err)
@@ -774,7 +774,7 @@ int ext3_orphan_del(handle_t *handle, st
 	if (err)
 		goto out_brelse;
 
-out_err: 	
+out_err:
 	ext3_std_error(inode->i_sb, err);
 out:
 	unlock_super(inode->i_sb);
--- linux/include/linux/ext3_fs.h.orig	Thu Jan  2 16:10:24 2003
+++ linux/include/linux/ext3_fs.h	Sat Jan  4 12:25:41 2003
@@ -622,7 +622,7 @@ extern int ext3_sync_file (struct file *
 /* ialloc.c */
 extern struct inode * ext3_new_inode (handle_t *, const struct inode *, int);
 extern void ext3_free_inode (handle_t *, struct inode *);
-extern struct inode * ext3_orphan_get (struct super_block *, ino_t);
+extern struct inode * ext3_orphan_get (struct super_block *, unsigned long);
 extern unsigned long ext3_count_free_inodes (struct super_block *);
 extern void ext3_check_inodes_bitmap (struct super_block *);
 extern unsigned long ext3_count_free (struct buffer_head *, unsigned);
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

