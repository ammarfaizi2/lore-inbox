Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317381AbSGDJgS>; Thu, 4 Jul 2002 05:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317384AbSGDJgR>; Thu, 4 Jul 2002 05:36:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45578 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317381AbSGDJgP>;
	Thu, 4 Jul 2002 05:36:15 -0400
Message-ID: <3D2418FE.FEA0B9E9@zip.com.au>
Date: Thu, 04 Jul 2002 02:44:30 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@kernel.org>
CC: Neil Brown <neilb@cse.unsw.edu.au>,
       Joe Thornber <joe@fib011235813.fsnet.co.uk>, linux-lvm@sistina.com,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-lvm] LVM2 modifies the buffer_head struct?
References: <F19741gcljD2E2044cY00004523@hotmail.com> <20020702141702.GA9769@fib011235813.fsnet.co.uk> <20020703100838.GH14097@suse.de> <20020703120124.GB615@fib011235813.fsnet.co.uk> <20020703121024.GC21568@suse.de> <15651.54044.557070.109158@notabene.cse.unsw.edu.au> <20020704075830.GQ21568@suse.de> <3D2409FA.44E88C1D@zip.com.au> <20020704083941.GA6204@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> ...
> Thank you, this is what I was looking for (if you look further up, I was
> advocating this very thing). Slimming down buffer_head and just add the
> ext3 hack is perfectly acceptable to me.
> 
> Which just means that device mapper needs to do the stacking properly,
> EOD.
> 

Here it is.  We can slot this into 2.4.20-pre, or Joe can own
it.  Any preferences?

 fs/buffer.c         |   21 ++++++++++++---------
 fs/jbd/journal.c    |   14 +++++++-------
 include/linux/fs.h  |   19 +++++++++++++++++--
 include/linux/jbd.h |    2 +-
 4 files changed, 37 insertions(+), 19 deletions(-)

--- 2.4.19-rc1/fs/buffer.c~ext3-journal-head	Thu Jul  4 02:25:17 2002
+++ 2.4.19-rc1-akpm/fs/buffer.c	Thu Jul  4 02:36:06 2002
@@ -587,9 +587,10 @@ struct buffer_head * get_hash_table(kdev
 void buffer_insert_inode_queue(struct buffer_head *bh, struct inode *inode)
 {
 	spin_lock(&lru_list_lock);
-	if (bh->b_inode)
+	if (buffer_inode(bh))
 		list_del(&bh->b_inode_buffers);
-	bh->b_inode = inode;
+	else
+		set_buffer_inode(bh);
 	list_add(&bh->b_inode_buffers, &inode->i_dirty_buffers);
 	spin_unlock(&lru_list_lock);
 }
@@ -597,9 +598,10 @@ void buffer_insert_inode_queue(struct bu
 void buffer_insert_inode_data_queue(struct buffer_head *bh, struct inode *inode)
 {
 	spin_lock(&lru_list_lock);
-	if (bh->b_inode)
+	if (buffer_inode(bh))
 		list_del(&bh->b_inode_buffers);
-	bh->b_inode = inode;
+	else
+		set_buffer_inode(bh);
 	list_add(&bh->b_inode_buffers, &inode->i_dirty_data_buffers);
 	spin_unlock(&lru_list_lock);
 }
@@ -608,13 +610,13 @@ void buffer_insert_inode_data_queue(stru
    remove_inode_queue functions.  */
 static void __remove_inode_queue(struct buffer_head *bh)
 {
-	bh->b_inode = NULL;
+	clear_buffer_inode(bh);
 	list_del(&bh->b_inode_buffers);
 }
 
 static inline void remove_inode_queue(struct buffer_head *bh)
 {
-	if (bh->b_inode)
+	if (buffer_inode(bh))
 		__remove_inode_queue(bh);
 }
 
@@ -746,6 +748,7 @@ void init_buffer(struct buffer_head *bh,
 	bh->b_list = BUF_CLEAN;
 	bh->b_end_io = handler;
 	bh->b_private = private;
+	bh->b_journal_head = NULL;
 }
 
 static void end_buffer_io_async(struct buffer_head * bh, int uptodate)
@@ -843,9 +846,9 @@ int fsync_buffers_list(struct list_head 
 		bh = BH_ENTRY(list->next);
 		list_del(&bh->b_inode_buffers);
 		if (!buffer_dirty(bh) && !buffer_locked(bh))
-			bh->b_inode = NULL;
+			clear_buffer_inode(bh);
 		else {
-			bh->b_inode = &tmp;
+			set_buffer_inode(bh);
 			list_add(&bh->b_inode_buffers, &tmp.i_dirty_buffers);
 			if (buffer_dirty(bh)) {
 				get_bh(bh);
@@ -1129,7 +1132,7 @@ struct buffer_head * bread(kdev_t dev, i
  */
 static void __put_unused_buffer_head(struct buffer_head * bh)
 {
-	if (bh->b_inode)
+	if (buffer_inode(bh))
 		BUG();
 	if (nr_unused_buffer_heads >= MAX_UNUSED_BUFFERS) {
 		kmem_cache_free(bh_cachep, bh);
--- 2.4.19-rc1/include/linux/fs.h~ext3-journal-head	Thu Jul  4 02:25:17 2002
+++ 2.4.19-rc1-akpm/include/linux/fs.h	Thu Jul  4 02:25:17 2002
@@ -219,6 +219,7 @@ enum bh_state_bits {
 	BH_Wait_IO,	/* 1 if we should write out this buffer */
 	BH_Launder,	/* 1 if we can throttle on this buffer */
 	BH_JBD,		/* 1 if it has an attached journal_head */
+	BH_Inode,	/* 1 if it is attached to i_dirty[_data]_buffers */
 
 	BH_PrivateStart,/* not a state bit, but the first bit available
 			 * for private allocation by other entities
@@ -261,11 +262,10 @@ struct buffer_head {
 	struct page *b_page;		/* the page this bh is mapped to */
 	void (*b_end_io)(struct buffer_head *bh, int uptodate); /* I/O completion */
  	void *b_private;		/* reserved for b_end_io */
-
+	void *b_journal_head;		/* ext3 journal_heads */
 	unsigned long b_rsector;	/* Real buffer location on disk */
 	wait_queue_head_t b_wait;
 
-	struct inode *	     b_inode;
 	struct list_head     b_inode_buffers;	/* doubly linked list of inode dirty buffers */
 };
 
@@ -1181,6 +1181,21 @@ static inline void mark_buffer_async(str
 		clear_bit(BH_Async, &bh->b_state);
 }
 
+static inline void set_buffer_inode(struct buffer_head *bh)
+{
+	set_bit(BH_Inode, &bh->b_state);
+}
+
+static inline void clear_buffer_inode(struct buffer_head *bh)
+{
+	clear_bit(BH_Inode, &bh->b_state);
+}
+
+static inline int buffer_inode(struct buffer_head *bh)
+{
+	return test_bit(BH_Inode, &bh->b_state);
+}
+
 /*
  * If an error happens during the make_request, this function
  * has to be recalled. It marks the buffer as clean and not
--- 2.4.19-rc1/fs/jbd/journal.c~ext3-journal-head	Thu Jul  4 02:25:17 2002
+++ 2.4.19-rc1-akpm/fs/jbd/journal.c	Thu Jul  4 02:25:17 2002
@@ -1625,8 +1625,8 @@ static void journal_free_journal_head(st
  *
  * Whenever a buffer has an attached journal_head, its ->b_state:BH_JBD bit
  * is set.  This bit is tested in core kernel code where we need to take
- * JBD-specific actions.  Testing the zeroness of ->b_private is not reliable
- * there.
+ * JBD-specific actions.  Testing the zeroness of ->b_journal_head is not
+ * reliable there.
  *
  * When a buffer has its BH_JBD bit set, its ->b_count is elevated by one.
  *
@@ -1681,9 +1681,9 @@ struct journal_head *journal_add_journal
 
 		if (buffer_jbd(bh)) {
 			/* Someone did it for us! */
-			J_ASSERT_BH(bh, bh->b_private != NULL);
+			J_ASSERT_BH(bh, bh->b_journal_head != NULL);
 			journal_free_journal_head(jh);
-			jh = bh->b_private;
+			jh = bh->b_journal_head;
 		} else {
 			/*
 			 * We actually don't need jh_splice_lock when
@@ -1691,7 +1691,7 @@ struct journal_head *journal_add_journal
 			 */
 			spin_lock(&jh_splice_lock);
 			set_bit(BH_JBD, &bh->b_state);
-			bh->b_private = jh;
+			bh->b_journal_head = jh;
 			jh->b_bh = bh;
 			atomic_inc(&bh->b_count);
 			spin_unlock(&jh_splice_lock);
@@ -1700,7 +1700,7 @@ struct journal_head *journal_add_journal
 	}
 	jh->b_jcount++;
 	spin_unlock(&journal_datalist_lock);
-	return bh->b_private;
+	return bh->b_journal_head;
 }
 
 /*
@@ -1733,7 +1733,7 @@ void __journal_remove_journal_head(struc
 			J_ASSERT_BH(bh, jh2bh(jh) == bh);
 			BUFFER_TRACE(bh, "remove journal_head");
 			spin_lock(&jh_splice_lock);
-			bh->b_private = NULL;
+			bh->b_journal_head = NULL;
 			jh->b_bh = NULL;	/* debug, really */
 			clear_bit(BH_JBD, &bh->b_state);
 			__brelse(bh);
--- 2.4.19-rc1/include/linux/jbd.h~ext3-journal-head	Thu Jul  4 02:25:17 2002
+++ 2.4.19-rc1-akpm/include/linux/jbd.h	Thu Jul  4 02:26:29 2002
@@ -246,7 +246,7 @@ static inline struct buffer_head *jh2bh(
 
 static inline struct journal_head *bh2jh(struct buffer_head *bh)
 {
-	return bh->b_private;
+	return bh->b_journal_head;
 }
 
 struct jbd_revoke_table_s;

-
