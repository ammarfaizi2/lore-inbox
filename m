Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272280AbRIVVjw>; Sat, 22 Sep 2001 17:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272295AbRIVVjk>; Sat, 22 Sep 2001 17:39:40 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:60605
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S272280AbRIVVjY>; Sat, 22 Sep 2001 17:39:24 -0400
Date: Sat, 22 Sep 2001 17:39:37 -0400
From: Chris Mason <mason@suse.com>
To: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
cc: Beau Kuiper <kuib-kl@ljbc.wa.edu.au>
Subject: [PATCH] reiserfs speedup for 2.4.9+
Message-ID: <1696760000.1001194777@tiny>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello everyone,

Beau pointed me towards a performance bug in reiserfs, where reiserfs_write_super would be called excessively.  

Turns out that 2.4.9 included some new super handling code that 
interacted poorly with how reiserfs uses kupdated calls to 
write_super to trigger writebacks of metadata.

This is most obvious with benchmarks like bonnie++, where 
2.4.9 and 2.4.10 reiserfs do very poorly.

This patch makes things much better in my tests, I'd appreciate 
a few more testers.  The only risk is reiserfs using slightly 
more memory, but only if I've screwed something up.

-chris

--- linux/fs/reiserfs/journal.c	Sat Sep  8 08:05:32 2001
+++ linux/fs/reiserfs/journal.c	Sat Sep 22 17:10:57 2001
@@ -746,6 +746,8 @@
   }
   atomic_set(&(jl->j_commit_flushing), 0) ;
   wake_up(&(jl->j_commit_wait)) ;
+  
+  s->s_dirt = 1 ;
   return 0 ;
 }
 
@@ -2378,7 +2381,6 @@
   int count = 0;
   int start ; 
   time_t now ; 
-  int keep_dirty = 0 ;
   struct reiserfs_transaction_handle th ; 
 
   start =  SB_JOURNAL_LIST_INDEX(p_s_sb) ;
@@ -2388,10 +2390,6 @@
   if (SB_JOURNAL_LIST_INDEX(p_s_sb) < 0) {
     return 0  ;
   }
-  if (!strcmp(current->comm, "kupdate")) {
-    immediate = 0 ;
-    keep_dirty = 1 ;
-  }
   /* starting with oldest, loop until we get to the start */
   i = (SB_JOURNAL_LIST_INDEX(p_s_sb) + 1) % JOURNAL_LIST_COUNT ;
   while(i != start) {
@@ -2416,7 +2414,6 @@
     reiserfs_prepare_for_journal(p_s_sb, SB_BUFFER_WITH_SB(p_s_sb), 1) ;
     journal_mark_dirty(&th, p_s_sb, SB_BUFFER_WITH_SB(p_s_sb)) ;
     do_journal_end(&th, p_s_sb,1, COMMIT_NOW) ;
-    keep_dirty = 0 ;
   } else if (immediate) { /* belongs above, but I wanted this to be very explicit as a special case.  If they say to 
                              flush, we must be sure old transactions hit the disk too. */
     journal_join(&th, p_s_sb, 1) ;
@@ -2424,8 +2421,8 @@
     journal_mark_dirty(&th, p_s_sb, SB_BUFFER_WITH_SB(p_s_sb)) ;
     do_journal_end(&th, p_s_sb,1, COMMIT_NOW | WAIT) ;
   }
-  keep_dirty |= reiserfs_journal_kupdate(p_s_sb) ;
-  return keep_dirty ;
+  reiserfs_journal_kupdate(p_s_sb) ;
+  return 0 ;
 }
 
 /*


