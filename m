Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbUFJOrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbUFJOrG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 10:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbUFJOrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 10:47:06 -0400
Received: from cantor.suse.de ([195.135.220.2]:3525 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261418AbUFJOq4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 10:46:56 -0400
Subject: [PATCH 2/2]
From: Chris Mason <mason@suse.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1086878848.10973.320.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 10 Jun 2004 10:47:28 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes barriers fail asynchronously (after the submit_bh call).
This patch changes both ext3 and reiserfs to handle that without
mistaking the barrier failures for io errors.

Index: linux.rc3/fs/jbd/commit.c
===================================================================
--- linux.rc3.orig/fs/jbd/commit.c	2004-06-10 10:26:48.000000000 -0400
+++ linux.rc3/fs/jbd/commit.c	2004-06-10 10:26:52.000000000 -0400
@@ -640,12 +640,20 @@ wait_for_iobuf:
 	{
 		struct buffer_head *bh = jh2bh(descriptor);
 		int ret;
+		int barrier_done = 0;
 
 		set_buffer_dirty(bh);
-		if (journal->j_flags & JFS_BARRIER)
+		if (journal->j_flags & JFS_BARRIER) {
 			set_buffer_ordered(bh);
+			barrier_done = 1;
+		}
 		ret = sync_dirty_buffer(bh);
-		if (ret == -EOPNOTSUPP && (journal->j_flags & JFS_BARRIER)) {
+		/* is it possible for another commit to fail at roughly
+		 * the same time as this one?  If so, we don't want to
+		 * trust the barrier flag in the super, but instead want
+		 * to remember if we sent a barrier request
+		 */
+		if (ret == -EOPNOTSUPP && barrier_done) {
 			char b[BDEVNAME_SIZE];
 
 			printk(KERN_WARNING
@@ -658,6 +666,7 @@ wait_for_iobuf:
 
 			/* And try again, without the barrier */
 			clear_buffer_ordered(bh);
+			set_buffer_uptodate(bh);
 			set_buffer_dirty(bh);
 			ret = sync_dirty_buffer(bh);
 		}
Index: linux.rc3/fs/reiserfs/journal.c
===================================================================
--- linux.rc3.orig/fs/reiserfs/journal.c	2004-06-10 10:26:48.000000000 -0400
+++ linux.rc3/fs/reiserfs/journal.c	2004-06-10 10:26:52.000000000 -0400
@@ -655,6 +655,17 @@ static int submit_barrier_buffer(struct 
     return submit_bh(WRITE_BARRIER, bh) ;
 }
 
+static void check_barrier_completion(struct super_block *s, 
+                                     struct buffer_head *bh) {
+    if (buffer_eopnotsupp(bh)) {
+	clear_buffer_eopnotsupp(bh);
+	disable_barrier(s);
+	set_buffer_uptodate(bh);
+	set_buffer_dirty(bh);
+	sync_dirty_buffer(bh);
+    }
+}
+
 #define CHUNK_SIZE 32
 struct buffer_chunk {
     struct buffer_head *bh[CHUNK_SIZE];
@@ -1032,6 +1043,7 @@ static int flush_commit_list(struct supe
   } else
       wait_on_buffer(jl->j_commit_bh);
 
+  check_barrier_completion(s, jl->j_commit_bh);
   if (!buffer_uptodate(jl->j_commit_bh)) {
     reiserfs_panic(s, "journal-615: buffer write failed\n") ;
   }
@@ -1142,6 +1154,7 @@ static int _update_journal_header_block(
 	    goto sync;
 	}
 	wait_on_buffer(SB_JOURNAL(p_s_sb)->j_header_bh);
+	check_barrier_completion(p_s_sb, SB_JOURNAL(p_s_sb)->j_header_bh);
     } else {
 sync:
 	set_buffer_dirty(SB_JOURNAL(p_s_sb)->j_header_bh) ;


