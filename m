Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272233AbRH3OZj>; Thu, 30 Aug 2001 10:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272234AbRH3OZa>; Thu, 30 Aug 2001 10:25:30 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:55818 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S272233AbRH3OZU>; Thu, 30 Aug 2001 10:25:20 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15246.19605.948543.110386@gargle.gargle.HOWL>
Date: Thu, 30 Aug 2001 18:24:21 +0400
To: Linus Torvalds <Torvalds@Transmeta.COM>
Cc: Reiserfs developers mail-list <Reiserfs-Dev@Namesys.COM>,
        "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: [PATCH]: reiserfs: B-journal-replay.patch
X-Mailer: VM 6.89 under 21.4 (patch 3) "Academic Rigor" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

    following patch by Chris Mason allows reiserfs to fail gracefully when
    io error is hit during journal replay: just return error in stead of
    panicking.

This patch is against 2.4.10-pre2.
Please apply.

Nikita.
diff -rup linux/fs/reiserfs/journal.c linux.patched/fs/reiserfs/journal.c
--- linux/fs/reiserfs/journal.c	Wed Aug  1 17:21:10 2001
+++ linux.patched/fs/reiserfs/journal.c	Wed Aug  1 21:13:11 2001
@@ -815,7 +815,7 @@ static void remove_all_from_journal_list
 ** called by flush_journal_list, before it calls remove_all_from_journal_list
 **
 */
-static int update_journal_header_block(struct super_block *p_s_sb, unsigned long offset, unsigned long trans_id) {
+static int _update_journal_header_block(struct super_block *p_s_sb, unsigned long offset, unsigned long trans_id) {
   struct reiserfs_journal_header *jh ;
   if (trans_id >= SB_JOURNAL(p_s_sb)->j_last_flush_trans_id) {
     if (buffer_locked((SB_JOURNAL(p_s_sb)->j_header_bh)))  {
@@ -834,12 +834,21 @@ static int update_journal_header_block(s
     ll_rw_block(WRITE, 1, &(SB_JOURNAL(p_s_sb)->j_header_bh)) ;
     wait_on_buffer((SB_JOURNAL(p_s_sb)->j_header_bh)) ; 
     if (!buffer_uptodate(SB_JOURNAL(p_s_sb)->j_header_bh)) {
-      reiserfs_panic(p_s_sb, "journal-712: buffer write failed\n") ;
+      printk( "reiserfs: journal-837: IO error during journal replay\n" );
+      return -EIO ;
     }
   }
   return 0 ;
 }
 
+static int update_journal_header_block(struct super_block *p_s_sb, 
+                                       unsigned long offset, 
+				       unsigned long trans_id) {
+    if (_update_journal_header_block(p_s_sb, offset, trans_id)) {
+	reiserfs_panic(p_s_sb, "journal-712: buffer write failed\n") ;
+    }
+    return 0 ;
+}
 /* 
 ** flush any and all journal lists older than you are 
 ** can only be called from flush_journal_list
@@ -1374,6 +1383,9 @@ static int journal_transaction_is_valid(
   struct buffer_head *c_bh ;
   unsigned long offset ;
 
+  if (!d_bh)
+      return 0 ;
+
   desc = (struct reiserfs_journal_desc *)d_bh->b_data ;
   if (le32_to_cpu(desc->j_len) > 0 && !memcmp(desc->j_magic, JOURNAL_DESC_MAGIC, 8)) {
     if (oldest_invalid_trans_id && *oldest_invalid_trans_id && le32_to_cpu(desc->j_trans_id) > *oldest_invalid_trans_id) {
@@ -1641,8 +1653,6 @@ static int journal_read(struct super_blo
 
   if (continue_replay && is_read_only(p_s_sb->s_dev)) {
     printk("clm-2076: device is readonly, unable to replay log\n") ;
-    brelse(SB_JOURNAL(p_s_sb)->j_header_bh) ;
-    SB_JOURNAL(p_s_sb)->j_header_bh = NULL ;
     return -1 ;
   }
   if (continue_replay && (p_s_sb->s_flags & MS_RDONLY)) {
@@ -1734,9 +1744,14 @@ static int journal_read(struct super_blo
     printk("reiserfs: replayed %d transactions in %lu seconds\n", replay_count, 
 	    CURRENT_TIME - start) ;
   }
-  if (!is_read_only(p_s_sb->s_dev)) {
-    update_journal_header_block(p_s_sb, SB_JOURNAL(p_s_sb)->j_start, 
-                                SB_JOURNAL(p_s_sb)->j_last_flush_trans_id) ;
+  if (!is_read_only(p_s_sb->s_dev) && 
+       _update_journal_header_block(p_s_sb, SB_JOURNAL(p_s_sb)->j_start, 
+                                   SB_JOURNAL(p_s_sb)->j_last_flush_trans_id))
+  {
+      /* replay failed, caller must call free_journal_ram and abort
+      ** the mount
+      */
+      return -1 ;
   }
   return 0 ;
 }
