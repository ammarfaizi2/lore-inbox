Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262530AbTELTTP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 15:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262531AbTELTTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 15:19:15 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:11719 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262530AbTELTTG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 15:19:06 -0400
Message-ID: <3EBFF6A1.2080501@namesys.com>
Date: Mon, 12 May 2003 23:31:45 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BK] [2.4] reiserfs: fix one more directio vs tails problem, resend]
Content-Type: multipart/mixed;
 boundary="------------020009050906070405080109"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020009050906070405080109
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


-- 
Hans


--------------020009050906070405080109
Content-Type: message/rfc822;
 name="[2.4] reiserfs: fix one more directio vs tails problem, resend"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[2.4] reiserfs: fix one more directio vs tails problem, resend"

Return-Path: <green@angband.namesys.com>
Delivered-To: reiser@namesys.com
Received: (qmail 760 invoked from network); 12 May 2003 14:01:30 -0000
Received: from angband.namesys.com (postfix@212.16.7.85)
  by thebsh.namesys.com with SMTP; 12 May 2003 14:01:30 -0000
Received: by angband.namesys.com (Postfix, from userid 521)
	id 5CC7D328AB8; Mon, 12 May 2003 18:01:30 +0400 (MSD)
Date: Mon, 12 May 2003 18:01:30 +0400
From: Oleg Drokin <green@namesys.com>
To: reiser@namesys.com
Subject: [2.4] reiserfs: fix one more directio vs tails problem, resend
Message-ID: <20030512140130.GA6665@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i

Hello!

    This changeset fixes another set problems related to directio vs packed tails.
    Thanks to Mingming Cao <mcao@us.ibm.com> for bringing the issue to our attention.
    Most of the patch was made by Chris Mason.

    Please pull from bk://namesys.com/bk/reiser3-linux-2.4-directiofix2

Diffstat:
 fs/reiserfs/inode.c           |   12 ++++++-
 fs/reiserfs/journal.c         |   66 +++++++++++++++++++++++++++---------------
 fs/reiserfs/tail_conversion.c |    1
 include/linux/reiserfs_fs.h   |    2 +
 include/linux/reiserfs_fs_i.h |    7 ++++
 5 files changed, 63 insertions(+), 25 deletions(-)

Plain text patch:

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1158  -> 1.1159 
#	include/linux/reiserfs_fs_i.h	1.8     -> 1.9    
#	 fs/reiserfs/inode.c	1.42    -> 1.43   
#	fs/reiserfs/tail_conversion.c	1.16    -> 1.17   
#	fs/reiserfs/journal.c	1.28    -> 1.29   
#	include/linux/reiserfs_fs.h	1.26    -> 1.27   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/03	green@angband.namesys.com	1.1159
# reiserfs: Fix another O_DIRECT vs tails problem. Mostly by Chris Mason.
# Thanks to Mingming Cao <mcao@us.ibm.com> for bringing the issue to our attention.
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
--- a/fs/reiserfs/inode.c	Mon May 12 18:00:53 2003
+++ b/fs/reiserfs/inode.c	Mon May 12 18:00:53 2003
@@ -469,7 +469,7 @@
     tail_end = (tail_start | (bh_result->b_size - 1)) + 1 ;
 
     index = tail_offset >> PAGE_CACHE_SHIFT ;
-    if (index != hole_page->index) {
+    if ( !hole_page || index != hole_page->index) {
 	tail_page = grab_cache_page(inode->i_mapping, index) ;
 	retval = -ENOMEM;
 	if (!tail_page) {
@@ -1810,7 +1810,12 @@
 	    flush_dcache_page(page) ;
 	    kunmap(page) ;
 	    if (buffer_mapped(bh) && bh->b_blocknr != 0) {
-	        mark_buffer_dirty(bh) ;
+	        if (!atomic_set_buffer_dirty(bh)) {
+			set_buffer_flushtime(bh);
+			refile_buffer(bh);
+			buffer_insert_inode_data_queue(bh, p_s_inode);
+			balance_dirty();
+		}
 	    }
 	}
 	UnlockPage(page) ;
@@ -2158,6 +2163,9 @@
                               struct kiobuf *iobuf, unsigned long blocknr,
 			      int blocksize) 
 {
+    lock_kernel();
+    reiserfs_commit_for_tail(inode);
+    unlock_kernel();
     return generic_direct_IO(rw, inode, iobuf, blocknr, blocksize,
                              reiserfs_get_block_direct_io) ;
 }
diff -Nru a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
--- a/fs/reiserfs/journal.c	Mon May 12 18:00:53 2003
+++ b/fs/reiserfs/journal.c	Mon May 12 18:00:53 2003
@@ -2655,32 +2655,52 @@
   inode->u.reiserfs_i.i_trans_id = SB_JOURNAL(inode->i_sb)->j_trans_id ;
 }
 
-static int reiserfs_inode_in_this_transaction(struct inode *inode) {
-  if (inode->u.reiserfs_i.i_trans_id == SB_JOURNAL(inode->i_sb)->j_trans_id || 
-      inode->u.reiserfs_i.i_trans_id == 0) {
-    return 1; 
-  } 
-  return 0 ;
+void reiserfs_update_tail_transaction(struct inode *inode) {
+  
+  inode->u.reiserfs_i.i_tail_trans_index = SB_JOURNAL_LIST_INDEX(inode->i_sb);
+
+  inode->u.reiserfs_i.i_tail_trans_id = SB_JOURNAL(inode->i_sb)->j_trans_id ;
+}
+
+static void __commit_trans_index(struct inode *inode, unsigned long id,
+                                 unsigned long index) 
+{
+    struct reiserfs_journal_list *jl ;
+    struct reiserfs_transaction_handle th ;
+    struct super_block *sb = inode->i_sb ;
+
+    jl = SB_JOURNAL_LIST(sb) + index;
+
+    /* is it from the current transaction, or from an unknown transaction? */
+    if (id == SB_JOURNAL(sb)->j_trans_id) {
+	journal_join(&th, sb, 1) ;
+	journal_end_sync(&th, sb, 1) ;
+    } else if (jl->j_trans_id == id) {
+	flush_commit_list(sb, jl, 1) ;
+    }
+    /* if the transaction id does not match, this list is long since flushed
+    ** and we don't have to do anything here
+    */
 }
+void reiserfs_commit_for_tail(struct inode *inode) {
+    unsigned long id = inode->u.reiserfs_i.i_tail_trans_id;
+    unsigned long index = inode->u.reiserfs_i.i_tail_trans_index;
 
+    /* for tails, if this info is unset there's nothing to commit */
+    if (id && index)
+	__commit_trans_index(inode, id, index);
+}
 void reiserfs_commit_for_inode(struct inode *inode) {
-  struct reiserfs_journal_list *jl ;
-  struct reiserfs_transaction_handle th ;
-  struct super_block *sb = inode->i_sb ;
-
-  jl = SB_JOURNAL_LIST(sb) + inode->u.reiserfs_i.i_trans_index ;
-
-  /* is it from the current transaction, or from an unknown transaction? */
-  if (reiserfs_inode_in_this_transaction(inode)) {
-    journal_join(&th, sb, 1) ;
-    reiserfs_update_inode_transaction(inode) ;
-    journal_end_sync(&th, sb, 1) ;
-  } else if (jl->j_trans_id == inode->u.reiserfs_i.i_trans_id) {
-    flush_commit_list(sb, jl, 1) ;
-  }
-  /* if the transaction id does not match, this list is long since flushed
-  ** and we don't have to do anything here
-  */
+    unsigned long id = inode->u.reiserfs_i.i_trans_id;
+    unsigned long index = inode->u.reiserfs_i.i_trans_index;
+
+    /* for the whole inode, assume unset id or index means it was
+     * changed in the current transaction.  More conservative
+     */
+    if (!id || !index)
+	reiserfs_update_inode_transaction(inode) ;
+
+    __commit_trans_index(inode, id, index);
 }
 
 void reiserfs_restore_prepared_buffer(struct super_block *p_s_sb, 
diff -Nru a/fs/reiserfs/tail_conversion.c b/fs/reiserfs/tail_conversion.c
--- a/fs/reiserfs/tail_conversion.c	Mon May 12 18:00:53 2003
+++ b/fs/reiserfs/tail_conversion.c	Mon May 12 18:00:53 2003
@@ -133,6 +133,7 @@
 
     inode->u.reiserfs_i.i_first_direct_byte = U32_MAX;
 
+    reiserfs_update_tail_transaction(inode);
     return 0;
 }
 
diff -Nru a/include/linux/reiserfs_fs.h b/include/linux/reiserfs_fs.h
--- a/include/linux/reiserfs_fs.h	Mon May 12 18:00:53 2003
+++ b/include/linux/reiserfs_fs.h	Mon May 12 18:00:53 2003
@@ -1558,7 +1558,9 @@
 #define JOURNAL_BUFFER(j,n) ((j)->j_ap_blocks[((j)->j_start + (n)) % JOURNAL_BLOCK_COUNT])
 
 void reiserfs_commit_for_inode(struct inode *) ;
+void reiserfs_commit_for_tail(struct inode *) ;
 void reiserfs_update_inode_transaction(struct inode *) ;
+void reiserfs_update_tail_transaction(struct inode *) ;
 void reiserfs_wait_on_write_block(struct super_block *s) ;
 void reiserfs_block_writes(struct reiserfs_transaction_handle *th) ;
 void reiserfs_allow_writes(struct super_block *s) ;
diff -Nru a/include/linux/reiserfs_fs_i.h b/include/linux/reiserfs_fs_i.h
--- a/include/linux/reiserfs_fs_i.h	Mon May 12 18:00:53 2003
+++ b/include/linux/reiserfs_fs_i.h	Mon May 12 18:00:53 2003
@@ -53,6 +53,13 @@
     ** flushed */
     unsigned long i_trans_id ;
     unsigned long i_trans_index ;
+
+    /* direct io needs to make sure the tail is on disk to avoid
+     * buffer alias problems.  This records the transaction last
+     * involved in a direct->indirect conversion for this file
+     */
+    unsigned long i_tail_trans_id;
+    unsigned long i_tail_trans_index;
 };
 
 #endif



--------------020009050906070405080109--

