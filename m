Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313182AbSDJO5q>; Wed, 10 Apr 2002 10:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313183AbSDJO5p>; Wed, 10 Apr 2002 10:57:45 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:528 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id <S313182AbSDJO5o>;
	Wed, 10 Apr 2002 10:57:44 -0400
Message-ID: <3CB451CC.8050609@namesys.com>
Date: Wed, 10 Apr 2002 18:53:00 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020310
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] ReiserFS 6 of 13, please apply, (resending, may be a duplicate)
Content-Type: multipart/mixed;
 boundary="------------060004090603070907060802"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060004090603070907060802
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------060004090603070907060802
Content-Type: message/rfc822;
 name="[PATCH] 2.5.8-pre3 patch 6 of 13"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[PATCH] 2.5.8-pre3 patch 6 of 13"


>From - Wed Apr 10 15:37:37 2002
X-Mozilla-Status2: 00000000
Return-Path: <green@namesys.com>
Delivered-To: reiser@namesys.com
Received: (qmail 13255 invoked from network); 10 Apr 2002 11:21:50 -0000
Received: from angband.namesys.com (postfix@212.16.7.85)
  by thebsh.namesys.com with SMTP; 10 Apr 2002 11:21:50 -0000
Received: by angband.namesys.com (Postfix on SuSE Linux 7.3 (i386), from userid 521)
	id DF3DE4D1B34; Wed, 10 Apr 2002 15:21:50 +0400 (MSD)
Date: Wed, 10 Apr 2002 15:21:50 +0400
From: Oleg Drokin <green@namesys.com>
To: reiser@namesys.com
Subject: [PATCH] 2.5.8-pre3 patch 6 of 13
Message-ID: <20020410152150.A20886@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i


This patch solves a problem where separate journal device was not freed
if journal initialisation failed

--- linux-2.5.8-pre2/fs/reiserfs/journal.c.orig	Mon Apr  8 14:00:50 2002
+++ linux-2.5.8-pre2/fs/reiserfs/journal.c	Mon Apr  8 15:31:43 2002
@@ -2049,6 +2049,7 @@
 		   SB_ONDISK_JOURNAL_1st_BLOCK(p_s_sb) + SB_ONDISK_JOURNAL_SIZE(p_s_sb));
      if (!bhjh) {
 	 printk("sh-459: unable to read  journal header\n") ;
+	 release_journal_dev(p_s_sb, journal);
 	 return 1 ;
      }
      jh = (struct reiserfs_journal_header *)(bhjh->b_data);
@@ -2065,7 +2066,8 @@
 		jh->jh_journal.jp_journal_magic, jname,
 		sb_jp_journal_magic(rs), fname);
 	 brelse (bhjh);
-    return 1 ;
+	 release_journal_dev(p_s_sb, journal);
+	 return 1 ;
   }
      
   SB_JOURNAL_TRANS_MAX(p_s_sb)      = le32_to_cpu (jh->jh_journal.jp_journal_trans_max);
@@ -2165,11 +2167,13 @@
   SB_JOURNAL_LIST(p_s_sb)[0].j_list_bitmap = get_list_bitmap(p_s_sb, SB_JOURNAL_LIST(p_s_sb)) ;
   if (!(SB_JOURNAL_LIST(p_s_sb)[0].j_list_bitmap)) {
     reiserfs_warning("journal-2005, get_list_bitmap failed for journal list 0\n") ;
+    release_journal_dev(p_s_sb, journal);
     return 1 ;
   }
   if (journal_read(p_s_sb) < 0) {
     reiserfs_warning("Replay Failure, unable to mount\n") ;
     free_journal_ram(p_s_sb) ;
+    release_journal_dev(p_s_sb, journal);
     return 1 ;
   }
   SB_JOURNAL_LIST_INDEX(p_s_sb) = 0 ; /* once the read is done, we can set this



--------------060004090603070907060802--

