Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313183AbSDJO62>; Wed, 10 Apr 2002 10:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313187AbSDJO61>; Wed, 10 Apr 2002 10:58:27 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:1808 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id <S313183AbSDJO6X>;
	Wed, 10 Apr 2002 10:58:23 -0400
Message-ID: <3CB451F6.5000600@namesys.com>
Date: Wed, 10 Apr 2002 18:53:42 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020310
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] ReiserFS bugfixes 7 of 13, please apply
Content-Type: multipart/mixed;
 boundary="------------010504090801020504010905"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010504090801020504010905
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------010504090801020504010905
Content-Type: message/rfc822;
 name="[PATCH] 2.5.8-pre3 patch 7 of 13"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[PATCH] 2.5.8-pre3 patch 7 of 13"


>From - Wed Apr 10 15:37:37 2002
X-Mozilla-Status2: 00000000
Return-Path: <green@namesys.com>
Delivered-To: reiser@namesys.com
Received: (qmail 13260 invoked from network); 10 Apr 2002 11:21:51 -0000
Received: from angband.namesys.com (postfix@212.16.7.85)
  by thebsh.namesys.com with SMTP; 10 Apr 2002 11:21:51 -0000
Received: by angband.namesys.com (Postfix on SuSE Linux 7.3 (i386), from userid 521)
	id EA9314D1B33; Wed, 10 Apr 2002 15:21:50 +0400 (MSD)
Date: Wed, 10 Apr 2002 15:21:50 +0400
From: Oleg Drokin <green@namesys.com>
To: reiser@namesys.com
Subject: [PATCH] 2.5.8-pre3 patch 7 of 13
Message-ID: <20020410152150.A20891@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i


This patch is to fix journal replay bug where old code would replay
transactions with mount_id != mount_id recorded in journal header.
Fixed by Chris Mason.

--- linux-2.5.8-pre2/fs/reiserfs/journal.c.orig	Mon Apr  8 15:31:43 2002
+++ linux-2.5.8-pre2/fs/reiserfs/journal.c	Mon Apr  8 15:32:20 2002
@@ -1651,11 +1651,9 @@
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
@@ -1685,13 +1683,14 @@
   if (le32_to_cpu(jh->j_first_unflushed_offset) >= 0 && 
       le32_to_cpu(jh->j_first_unflushed_offset) < SB_ONDISK_JOURNAL_SIZE(p_s_sb) && 
       le32_to_cpu(jh->j_last_flush_trans_id) > 0) {
-    last_flush_start = SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + 
+    oldest_start = SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + 
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
@@ -1704,6 +1703,7 @@
       continue_replay = 0 ;
     }
     brelse(d_bh) ;
+    goto start_log_replay;
   }
 
   if (continue_replay && is_read_only(p_s_sb->s_dev)) {
@@ -1746,17 +1746,13 @@
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



--------------010504090801020504010905--

