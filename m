Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289772AbSBKO1H>; Mon, 11 Feb 2002 09:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289757AbSBKOZf>; Mon, 11 Feb 2002 09:25:35 -0500
Received: from angband.namesys.com ([212.16.7.85]:20608 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S289772AbSBKOZU>; Mon, 11 Feb 2002 09:25:20 -0500
Date: Mon, 11 Feb 2002 17:25:13 +0300
From: Oleg Drokin on behalf of Hans Reiser <reiser@namesys.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: [PATCH] 2.5 [7 of 8] 07-reiserfs-bitmap-journal-read-ahead.diff
Message-ID: <20020211172513.G1768@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   Speed up reading of journal bitmaps. RAID users should notice significant
   speedup when mounting reiserfs over self-rebuilding RAID arays.


--- linux/fs/reiserfs/journal.c.orig	Mon Feb 11 10:18:41 2002
+++ linux/fs/reiserfs/journal.c	Mon Feb 11 10:43:19 2002
@@ -71,7 +71,9 @@
 static DECLARE_WAIT_QUEUE_HEAD(reiserfs_commit_thread_done) ;
 DECLARE_TASK_QUEUE(reiserfs_commit_thread_tq) ;
 
-#define JOURNAL_TRANS_HALF 1018   /* must be correct to keep the desc and commit structs at 4k */
+#define JOURNAL_TRANS_HALF 1018   /* must be correct to keep the desc and commit
+				     structs at 4k */
+#define BUFNR 64 /*read ahead */
 
 /* cnode stat bits.  Move these into reiserfs_fs.h */
 
@@ -1598,6 +1600,41 @@
 **
 ** On exit, it sets things up so the first transaction will work correctly.
 */
+struct buffer_head * reiserfs_breada (kdev_t dev, int block, int bufsize,
+			    unsigned int max_block)
+{
+	struct buffer_head * bhlist[BUFNR];
+	unsigned int blocks = BUFNR;
+	struct buffer_head * bh;
+	int i, j;
+	
+	bh = getblk (dev, block, bufsize);
+	if (buffer_uptodate (bh))
+		return (bh);   
+		
+	if (block + BUFNR > max_block) {
+		blocks = max_block - block;
+	}
+	bhlist[0] = bh;
+	j = 1;
+	for (i = 1; i < blocks; i++) {
+		bh = getblk (dev, block + i, bufsize);
+		if (buffer_uptodate (bh)) {
+			brelse (bh);
+			break;
+		}
+		else bhlist[j++] = bh;
+	}
+	ll_rw_block (READ, j, bhlist);
+	for(i = 1; i < j; i++) 
+		brelse (bhlist[i]);
+	bh = bhlist[0];
+	wait_on_buffer (bh);
+	if (buffer_uptodate (bh))
+		return bh;
+	brelse (bh);
+	return NULL;
+}
 static int journal_read(struct super_block *p_s_sb) {
   struct reiserfs_journal_desc *desc ;
   unsigned long last_flush_trans_id = 0 ;
@@ -1668,7 +1705,8 @@
   ** all the valid transactions, and pick out the oldest.
   */
   while(continue_replay && cur_dblock < (SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + SB_ONDISK_JOURNAL_SIZE(p_s_sb))) {
-    d_bh = bread(SB_JOURNAL_DEV(p_s_sb), cur_dblock, p_s_sb->s_blocksize) ;
+    d_bh = reiserfs_breada(p_s_sb->s_dev, cur_dblock, p_s_sb->s_blocksize,
+			   SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + SB_ONDISK_JOURNAL_SIZE(p_s_sb)) ;
     ret = journal_transaction_is_valid(p_s_sb, d_bh, &oldest_invalid_trans_id, &newest_mount_id) ;
     if (ret == 1) {
       desc = (struct reiserfs_journal_desc *)d_bh->b_data ;
--- linux/fs/reiserfs/super.c.orig	Mon Feb 11 10:08:08 2002
+++ linux/fs/reiserfs/super.c	Mon Feb 11 10:33:33 2002
@@ -655,28 +655,30 @@
 
 static int read_bitmaps (struct super_block * s)
 {
-    int i, bmp, dl ;
-    struct reiserfs_super_block * rs = SB_DISK_SUPER_BLOCK(s);
+    int i, bmp;
 
-    SB_AP_BITMAP (s) = reiserfs_kmalloc (sizeof (struct buffer_head *) * sb_bmap_nr(rs), GFP_NOFS, s);
+    SB_AP_BITMAP (s) = reiserfs_kmalloc (sizeof (struct buffer_head *) * SB_BMAP_NR(s), GFP_NOFS, s);
     if (SB_AP_BITMAP (s) == 0)
 	return 1;
-    memset (SB_AP_BITMAP (s), 0, sizeof (struct buffer_head *) * sb_bmap_nr(rs));
-
-    /* reiserfs leaves the first 64k unused so that any partition
-       labeling scheme currently used will have enough space. Then we
-       need one block for the super.  -Hans */
-    bmp = (REISERFS_DISK_OFFSET_IN_BYTES / s->s_blocksize) + 1;	/* first of bitmap blocks */
-    SB_AP_BITMAP (s)[0] = reiserfs_bread (s, bmp);
-    if(!SB_AP_BITMAP(s)[0])
-	return 1;
-    for (i = 1, bmp = dl = s->s_blocksize * 8; i < sb_bmap_nr(rs); i ++) {
-	SB_AP_BITMAP (s)[i] = reiserfs_bread (s, bmp);
-	if (!SB_AP_BITMAP (s)[i])
+    for (i = 0, bmp = REISERFS_DISK_OFFSET_IN_BYTES / s->s_blocksize + 1;
+	 i < SB_BMAP_NR(s); i++, bmp = s->s_blocksize * 8 * i) {
+	SB_AP_BITMAP (s)[i] = getblk (s->s_dev, bmp, s->s_blocksize);
+	if (!buffer_uptodate(SB_AP_BITMAP(s)[i]))
+	    ll_rw_block(READ, 1, SB_AP_BITMAP(s) + i);
+    }
+    for (i = 0; i < SB_BMAP_NR(s); i++) {
+	wait_on_buffer(SB_AP_BITMAP (s)[i]);
+	if (!buffer_uptodate(SB_AP_BITMAP(s)[i])) {
+	    reiserfs_warning("sh-2029: reiserfs read_bitmaps: "
+			 "bitmap block (#%lu) reading failed\n",
+			 SB_AP_BITMAP(s)[i]->b_blocknr);
+	    for (i = 0; i < SB_BMAP_NR(s); i++)
+		brelse(SB_AP_BITMAP(s)[i]);
+	    reiserfs_kfree(SB_AP_BITMAP(s), sizeof(struct buffer_head *) * SB_BMAP_NR(s), s);
+	    SB_AP_BITMAP(s) = NULL;
 	    return 1;
-	bmp += dl;
+	}
     }
-
     return 0;
 }
 
