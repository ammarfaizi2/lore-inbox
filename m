Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282487AbRKZUHW>; Mon, 26 Nov 2001 15:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282483AbRKZUFu>; Mon, 26 Nov 2001 15:05:50 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:47623 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S282463AbRKZUET>; Mon, 26 Nov 2001 15:04:19 -0500
Message-ID: <3C02A00B.B9948342@zip.com.au>
Date: Mon, 26 Nov 2001 12:03:23 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: mingo@elte.hu, velco@fadata.bg, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [PATCH] Scalable page cache
In-Reply-To: <3C029BE0.2BEA2264@zip.com.au>,
		<Pine.LNX.4.33.0111262201420.18923-100000@localhost.localdomain>
		<20011126.111854.102567147.davem@redhat.com>
		<3C029BE0.2BEA2264@zip.com.au> <20011126.115723.41632923.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
> Ahh, speaking of bitops, what's the status of the ext3 bitops bugs I
> found Andrew? :-)  Those are pretty serious.

err, umm,  shuffles feet...

Here's the current rolled-up ext3 diff which I've been using.
It needs to be resynced with pestiferous ext3 CVS, changelogged
and pushed out this week.



--- linux-2.4.15-pre9/fs/ext3/inode.c	Thu Nov 22 10:56:33 2001
+++ linux-akpm/fs/ext3/inode.c	Thu Nov 22 11:07:03 2001
@@ -1026,9 +1026,20 @@ static int ext3_prepare_write(struct fil
 	if (ret != 0)
 		goto prepare_write_failed;
 
-	if (ext3_should_journal_data(inode))
+	if (ext3_should_journal_data(inode)) {
 		ret = walk_page_buffers(handle, page->buffers,
 				from, to, NULL, do_journal_get_write_access);
+		if (ret) {
+			/*
+			 * We're going to fail this prepare_write(),
+			 * so commit_write() will not be called.
+			 * We need to undo block_prepare_write()'s kmap().
+			 * AKPM: Do we need to clear PageUptodate?  I don't
+			 * think so.
+			 */
+			kunmap(page);
+		}
+	}
 prepare_write_failed:
 	if (ret)
 		ext3_journal_stop(handle, inode);
@@ -1096,7 +1107,7 @@ static int ext3_commit_write(struct file
 		kunmap(page);
 		if (pos > inode->i_size)
 			inode->i_size = pos;
-		set_bit(EXT3_STATE_JDATA, &inode->u.ext3_i.i_state);
+		EXT3_I(inode)->i_state |= EXT3_STATE_JDATA;
 	} else {
 		if (ext3_should_order_data(inode)) {
 			ret = walk_page_buffers(handle, page->buffers,
@@ -1104,8 +1115,17 @@ static int ext3_commit_write(struct file
 		}
 		/* Be careful here if generic_commit_write becomes a
 		 * required invocation after block_prepare_write. */
-		if (ret == 0)
+		if (ret == 0) {
 			ret = generic_commit_write(file, page, from, to);
+		} else {
+			/*
+			 * block_prepare_write() was called, but we're not
+			 * going to call generic_commit_write().  So we
+			 * need to perform generic_commit_write()'s kunmap
+			 * by hand.
+			 */
+			kunmap(page);
+		}
 	}
 	if (inode->i_size > inode->u.ext3_i.i_disksize) {
 		inode->u.ext3_i.i_disksize = inode->i_size;
@@ -1140,7 +1160,7 @@ static int ext3_bmap(struct address_spac
 	journal_t *journal;
 	int err;
 	
-	if (test_and_clear_bit(EXT3_STATE_JDATA, &inode->u.ext3_i.i_state)) {
+	if (EXT3_I(inode)->i_state & EXT3_STATE_JDATA) {
 		/* 
 		 * This is a REALLY heavyweight approach, but the use of
 		 * bmap on dirty files is expected to be extremely rare:
@@ -1159,6 +1179,7 @@ static int ext3_bmap(struct address_spac
 		 * everything they get.
 		 */
 		
+		EXT3_I(inode)->i_state &= ~EXT3_STATE_JDATA;
 		journal = EXT3_JOURNAL(inode);
 		journal_lock_updates(journal);
 		err = journal_flush(journal);
@@ -2203,7 +2224,7 @@ static int ext3_do_update_inode(handle_t
 	/* If we are not tracking these fields in the in-memory inode,
 	 * then preserve them on disk, but still initialise them to zero
 	 * for new inodes. */
-	if (inode->u.ext3_i.i_state & EXT3_STATE_NEW) {
+	if (EXT3_I(inode)->i_state & EXT3_STATE_NEW) {
 		raw_inode->i_faddr = 0;
 		raw_inode->i_frag = 0;
 		raw_inode->i_fsize = 0;
@@ -2249,7 +2270,7 @@ static int ext3_do_update_inode(handle_t
 	rc = ext3_journal_dirty_metadata(handle, bh);
 	if (!err)
 		err = rc;
-	inode->u.ext3_i.i_state &= ~EXT3_STATE_NEW;
+	EXT3_I(inode)->i_state &= ~EXT3_STATE_NEW;
 
 out_brelse:
 	brelse (bh);
--- linux-2.4.15-pre9/fs/ext3/super.c	Thu Nov 22 10:56:33 2001
+++ linux-akpm/fs/ext3/super.c	Thu Nov 22 11:07:03 2001
@@ -1350,7 +1350,7 @@ static int ext3_load_journal(struct supe
 	journal_t *journal;
 	int journal_inum = le32_to_cpu(es->s_journal_inum);
 	int journal_dev = le32_to_cpu(es->s_journal_dev);
-	int err;
+	int err = 0;
 	int really_read_only;
 
 	really_read_only = is_read_only(sb->s_dev);
@@ -1400,9 +1400,10 @@ static int ext3_load_journal(struct supe
 	}
 
 	if (!EXT3_HAS_INCOMPAT_FEATURE(sb, EXT3_FEATURE_INCOMPAT_RECOVER))
-		journal_wipe(journal, !really_read_only);
+		err = journal_wipe(journal, !really_read_only);
+	if (!err)
+		err = journal_load(journal);
 
-	err = journal_load(journal);
 	if (err) {
 		printk(KERN_ERR "EXT3-fs: error loading journal.\n");
 		journal_destroy(journal);
--- linux-2.4.15-pre9/fs/jbd/journal.c	Thu Nov 22 10:56:33 2001
+++ linux-akpm/fs/jbd/journal.c	Thu Nov 22 11:07:03 2001
@@ -757,7 +757,8 @@ journal_t * journal_init_inode (struct i
 	journal->j_inode = inode;
 	jbd_debug(1,
 		  "journal %p: inode %s/%ld, size %Ld, bits %d, blksize %ld\n",
-		  journal, bdevname(inode->i_dev), inode->i_ino, inode->i_size,
+		  journal, bdevname(inode->i_dev), inode->i_ino, 
+		  (long long) inode->i_size,
 		  inode->i_sb->s_blocksize_bits, inode->i_sb->s_blocksize);
 
 	journal->j_maxlen = inode->i_size >> inode->i_sb->s_blocksize_bits;
@@ -772,6 +773,18 @@ journal_t * journal_init_inode (struct i
 	return journal;
 }
 
+/* 
+ * If the journal init or create aborts, we need to mark the journal
+ * superblock as being NULL to prevent the journal destroy from writing
+ * back a bogus superblock. 
+ */
+static void journal_fail_superblock (journal_t *journal)
+{
+	struct buffer_head *bh = journal->j_sb_buffer;
+	brelse(bh);
+	journal->j_sb_buffer = NULL;
+}
+
 /*
  * Given a journal_t structure, initialise the various fields for
  * startup of a new journaling session.  We use this both when creating
@@ -825,6 +838,7 @@ int journal_create (journal_t *journal)
 	if (journal->j_maxlen < JFS_MIN_JOURNAL_BLOCKS) {
 		printk (KERN_ERR "Journal length (%d blocks) too short.\n",
 			journal->j_maxlen);
+		journal_fail_superblock(journal);
 		return -EINVAL;
 	}
 
@@ -915,7 +929,8 @@ static int journal_get_superblock(journa
 {
 	struct buffer_head *bh;
 	journal_superblock_t *sb;
-
+	int err = -EIO;
+	
 	bh = journal->j_sb_buffer;
 
 	J_ASSERT(bh != NULL);
@@ -925,16 +940,18 @@ static int journal_get_superblock(journa
 		if (!buffer_uptodate(bh)) {
 			printk (KERN_ERR
 				"JBD: IO error reading journal superblock\n");
-			return -EIO;
+			goto out;
 		}
 	}
 
 	sb = journal->j_superblock;
 
+	err = -EINVAL;
+	
 	if (sb->s_header.h_magic != htonl(JFS_MAGIC_NUMBER) ||
 	    sb->s_blocksize != htonl(journal->j_blocksize)) {
 		printk(KERN_WARNING "JBD: no valid journal superblock found\n");
-		return -EINVAL;
+		goto out;
 	}
 
 	switch(ntohl(sb->s_header.h_blocktype)) {
@@ -946,17 +963,21 @@ static int journal_get_superblock(journa
 		break;
 	default:
 		printk(KERN_WARNING "JBD: unrecognised superblock format ID\n");
-		return -EINVAL;
+		goto out;
 	}
 
 	if (ntohl(sb->s_maxlen) < journal->j_maxlen)
 		journal->j_maxlen = ntohl(sb->s_maxlen);
 	else if (ntohl(sb->s_maxlen) > journal->j_maxlen) {
 		printk (KERN_WARNING "JBD: journal file too short\n");
-		return -EINVAL;
+		goto out;
 	}
 
 	return 0;
+
+out:
+	journal_fail_superblock(journal);
+	return err;
 }
 
 /*
@@ -1061,7 +1082,10 @@ void journal_destroy (journal_t *journal
 	/* We can now mark the journal as empty. */
 	journal->j_tail = 0;
 	journal->j_tail_sequence = ++journal->j_transaction_sequence;
-	journal_update_superblock(journal, 1);
+	if (journal->j_sb_buffer) {
+		journal_update_superblock(journal, 1);
+		brelse(journal->j_sb_buffer);
+	}
 
 	if (journal->j_inode)
 		iput(journal->j_inode);
@@ -1069,7 +1093,6 @@ void journal_destroy (journal_t *journal
 		journal_destroy_revoke(journal);
 
 	unlock_journal(journal);
-	brelse(journal->j_sb_buffer);
 	kfree(journal);
 	MOD_DEC_USE_COUNT;
 }
--- linux-2.4.15-pre9/fs/jbd/transaction.c	Thu Nov 22 10:56:33 2001
+++ linux-akpm/fs/jbd/transaction.c	Thu Nov 22 11:07:03 2001
@@ -1058,21 +1058,6 @@ int journal_dirty_data (handle_t *handle
 		JBUFFER_TRACE(jh, "not on a transaction");
 		__journal_file_buffer(jh, handle->h_transaction, wanted_jlist);
 	}
-	/*
-	 * We need to mark the buffer dirty and refile it inside the lock to
-	 * protect it from release by journal_try_to_free_buffer()
-	 *
-	 * We set ->b_flushtime to something small enough to typically keep
-	 * kupdate away from the buffer.
-	 *
-	 * We don't need to do a balance_dirty() - __block_commit_write()
-	 * does that.
-	 */
-	if (!async && !atomic_set_buffer_dirty(jh2bh(jh))) {
-		jh2bh(jh)->b_flushtime =
-			jiffies + journal->j_commit_interval + 1 * HZ;
-		refile_buffer(jh2bh(jh));
-	}
 no_journal:
 	spin_unlock(&journal_datalist_lock);
 	if (need_brelse) {
@@ -1604,8 +1589,6 @@ static int __journal_try_to_free_buffer(
 
 	assert_spin_locked(&journal_datalist_lock);
 
-	if (!buffer_jbd(bh))
-		return 1;
 	jh = bh2jh(bh);
 
 	if (buffer_locked(bh) || buffer_dirty(bh)) {
--- linux-2.4.15-pre9/Documentation/Configure.help	Thu Nov 22 10:56:31 2001
+++ linux-akpm/Documentation/Configure.help	Thu Nov 22 11:07:03 2001
@@ -13712,7 +13712,7 @@ CONFIG_EXT2_FS
 Ext3 journaling file system support (EXPERIMENTAL)
 CONFIG_EXT3_FS
   This is the journaling version of the Second extended file system
-  (often called ext3), the de facto standard Linux file system
+  (often called ext2), the de facto standard Linux file system
   (method to organize files on a storage device) for hard disks.
 
   The journaling code included in this driver means you do not have
--- linux-2.4.15-pre9/Documentation/Changes	Mon Sep 17 23:10:44 2001
+++ linux-akpm/Documentation/Changes	Thu Nov 22 11:07:03 2001
@@ -53,7 +53,7 @@ o  Gnu make               3.77          
 o  binutils               2.9.1.0.25              # ld -v
 o  util-linux             2.10o                   # fdformat --version
 o  modutils               2.4.2                   # insmod -V
-o  e2fsprogs              1.19                    # tune2fs
+o  e2fsprogs              1.25                    # tune2fs
 o  reiserfsprogs          3.x.0j                  # reiserfsck 2>&1|grep reiserfsprogs
 o  pcmcia-cs              3.1.21                  # cardmgr -V
 o  PPP                    2.4.0                   # pppd --version
@@ -317,8 +317,7 @@ o  <ftp://rawhide.redhat.com/pub/rawhide
 
 E2fsprogs
 ---------
-o  <http://prdownloads.sourceforge.net/e2fsprogs/e2fsprogs-1.19.tar.gz>
-o  <http://prdownloads.sourceforge.net/e2fsprogs/e2fsprogs-1.19-0.src.rpm>
+o  <http://prdownloads.sourceforge.net/e2fsprogs/e2fsprogs-1.25.tar.gz>
 
 Reiserfsprogs
 -------------
--- linux-2.4.15-pre9/Documentation/filesystems/Locking	Fri Feb 16 15:53:08 2001
+++ linux-akpm/Documentation/filesystems/Locking	Thu Nov 22 11:07:03 2001
@@ -123,6 +123,10 @@ prototypes:
 	int (*prepare_write)(struct file *, struct page *, unsigned, unsigned);
 	int (*commit_write)(struct file *, struct page *, unsigned, unsigned);
 	int (*bmap)(struct address_space *, long);
+	int (*flushpage) (struct page *, unsigned long);
+	int (*releasepage) (struct page *, int);
+	int (*direct_IO)(int, struct inode *, struct kiobuf *, unsigned long, int);
+
 locking rules:
 	All may block
 		BKL	PageLocked(page)
@@ -132,6 +136,8 @@ sync_page:	no	maybe
 prepare_write:	no	yes
 commit_write:	no	yes
 bmap:		yes
+flushpage:	no	yes
+releasepage:	no	yes
 
 	->prepare_write(), ->commit_write(), ->sync_page() and ->readpage()
 may be called from the request handler (/dev/loop).
@@ -144,6 +150,15 @@ well-defined...
 filesystems and by the swapper. The latter will eventually go away. All
 instances do not actually need the BKL. Please, keep it that way and don't
 breed new callers.
+	->flushpage() is called when the filesystem must attempt to drop
+some or all of the buffers from the page when it is being truncated.  It
+returns zero on success.  If ->flushpage is zero, the kernel uses
+block_flushpage() instead.
+	->releasepage() is called when the kernel is about to try to drop the
+buffers from the page in preparation for freeing it.  It returns zero to
+indicate that the buffers are (or may be) freeable.  If ->flushpage is zero,
+the kernel assumes that the fs has no private interest in the buffers.
+
 	Note: currently almost all instances of address_space methods are
 using BKL for internal serialization and that's one of the worst sources
 of contention. Normally they are calling library functions (in fs/buffer.c)
