Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbTDQKPZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 06:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbTDQKPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 06:15:24 -0400
Received: from angband.namesys.com ([212.16.7.85]:29608 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP id S261292AbTDQKPX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 06:15:23 -0400
Date: Thu, 17 Apr 2003 14:27:17 +0400
From: Oleg Drokin <green@namesys.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [2.4] reiserfs: journal replay fix (anniversary resend)
Message-ID: <20030417142716.A6290@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

    This changeset fixes reiserfs transactions replay code that sometimes
    may pick incorrect stuff to replay. Patch by Chris Mason.
    This changeset seems to be doomed. It was first submitted on April 17th, 2002.
    (and I thought it was accepted, anyway I cannot find another reason on why it
    was never resubmitted if it was not accepted. It was sent with some other changes,
    and some of those other changes are now in the tree which is even more strange).

    Anyway, here is this resurrected changeset, please pull from
    bk://namesys.com/bk/reiser3-linux-2.4-journal-replay-fix

Diffstat:
 journal.c |   20 ++++++++------------
 1 files changed, 8 insertions(+), 12 deletions(-)

Plain text patch:

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1101  -> 1.1102 
#	fs/reiserfs/journal.c	1.26    -> 1.27   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/04/17	green@angband.namesys.com	1.1102
# reiserfs: Fix for journal replay process, to only replay transactions from last mount. By Chris Mason.
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
--- a/fs/reiserfs/journal.c	Thu Apr 17 14:09:48 2003
+++ b/fs/reiserfs/journal.c	Thu Apr 17 14:09:48 2003
@@ -1637,11 +1637,9 @@
 }
 static int journal_read(struct super_block *p_s_sb) {
   struct reiserfs_journal_desc *desc ;
-  unsigned long last_flush_trans_id = 0 ;
   unsigned long oldest_trans_id = 0;
   unsigned long oldest_invalid_trans_id = 0 ;
   time_t start ;
-  unsigned long last_flush_start = 0;
   unsigned long oldest_start = 0;
   unsigned long cur_dblock = 0 ;
   unsigned long newest_mount_id = 9 ;
@@ -1671,13 +1669,14 @@
   if (le32_to_cpu(jh->j_first_unflushed_offset) >= 0 && 
       le32_to_cpu(jh->j_first_unflushed_offset) < JOURNAL_BLOCK_COUNT &&
       le32_to_cpu(jh->j_last_flush_trans_id) > 0) {
-    last_flush_start = reiserfs_get_journal_block(p_s_sb) + 
+    oldest_start = reiserfs_get_journal_block(p_s_sb) + 
                        le32_to_cpu(jh->j_first_unflushed_offset) ;
-    last_flush_trans_id = le32_to_cpu(jh->j_last_flush_trans_id) ;
+    oldest_trans_id = le32_to_cpu(jh->j_last_flush_trans_id) + 1;
+    newest_mount_id = le32_to_cpu(jh->j_mount_id);
     reiserfs_debug(p_s_sb, REISERFS_DEBUG_CODE, "journal-1153: found in "
                    "header: first_unflushed_offset %d, last_flushed_trans_id "
 		   "%lu\n", le32_to_cpu(jh->j_first_unflushed_offset), 
-		   last_flush_trans_id) ;
+		   le32_to_cpu(jh->j_last_flush_trans_id)) ;
     valid_journal_header = 1 ;
 
     /* now, we try to read the first unflushed offset.  If it is not valid, 
@@ -1690,6 +1689,7 @@
       continue_replay = 0 ;
     }
     brelse(d_bh) ;
+    goto start_log_replay;
   }
 
   if (continue_replay && is_read_only(p_s_sb->s_dev)) {
@@ -1732,17 +1732,13 @@
 	              "newest_mount_id to %d\n", le32_to_cpu(desc->j_mount_id));
       }
       cur_dblock += le32_to_cpu(desc->j_len) + 2 ;
-    } 
-    else {
+    } else {
       cur_dblock++ ;
     }
     brelse(d_bh) ;
   }
-  /* step three, starting at the oldest transaction, replay */
-  if (last_flush_start > 0) {
-    oldest_start = last_flush_start ;
-    oldest_trans_id = last_flush_trans_id + 1 ;
-  } 
+
+start_log_replay:
   cur_dblock = oldest_start ;
   if (oldest_trans_id)  {
     reiserfs_debug(p_s_sb, REISERFS_DEBUG_CODE, "journal-1206: Starting replay "
