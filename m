Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261753AbVASPdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbVASPdy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 10:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbVASPdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 10:33:54 -0500
Received: from [83.102.214.158] ([83.102.214.158]:16095 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S261753AbVASPdQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 10:33:16 -0500
Subject: [PATCH] JBD: fix against journal overflow
From: Alex Tomas <alex@clusterfs.com>
To: linux-kernel@vger.kernel.org
CC: ext2-devel@lists.sourceforge.net, akpm@osdl.org, alex@clusterfs.com
Organization: ClusterFS Inc.
Date: Wed, 19 Jan 2005 18:32:10 +0300
Message-ID: <m3r7khv3id.fsf@bzzz.home.net>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Good day,

under some quite high load, jbd can hit J_ASSERT(journal->j_free > 1)
in journal_next_log_block(). The cause is the following:

journal_commit_transaction()
{
        struct buffer_head *wbuf[64];

        ....

                /* If there's no more to do, or if the descriptor is full,
                   let the IO rip! */

                if (bufs == ARRAY_SIZE(wbuf) ||
                    commit_transaction->t_buffers == NULL ||
                    space_left < sizeof(journal_block_tag_t) + 16) {

so, the real limit isn't size of journal descriptor, but wbuf.

__log_space_left()
{
	/*
	 * Be pessimistic here about the number of those free blocks which
	 * might be required for log descriptor control blocks.
	 */

#define MIN_LOG_RESERVED_BLOCKS 32 /* Allow for rounding errors */

	left -= MIN_LOG_RESERVED_BLOCKS;


so, jbd expects upto 32 blocks to be used for internal purpose. but
with 64 blocks a descriptor limit we easily can break the limit.

The fix allocates wbuf in journal_init_dev(). That's enough because
we have only commit thread per filesystem.

thank, Alex


The journal_commit_transaction() generates too many descriptor blocks
because static array wbuf can hold 64 blocks only. The fix is to have
persistent array big enough to hold max. possible blocks.

Signed-off-by: Alex Tomas <alex@clusterfs.com>

Index: linux-2.6.7/include/linux/jbd.h
===================================================================
--- linux-2.6.7.orig/include/linux/jbd.h	2004-08-26 17:12:16.000000000 +0400
+++ linux-2.6.7/include/linux/jbd.h	2005-01-19 17:08:33.144512008 +0300
@@ -826,6 +826,12 @@
 	struct jbd_revoke_table_s *j_revoke_table[2];
 
 	/*
+	 * array of bhs for journal_commit_transaction
+	 */
+	struct buffer_head	**j_wbuf;
+	int			j_wbufsize;
+
+	/*
 	 * An opaque pointer to fs-private information.  ext3 puts its
 	 * superblock pointer here
 	 */
Index: linux-2.6.7/fs/jbd/commit.c
===================================================================
--- linux-2.6.7.orig/fs/jbd/commit.c	2004-08-26 17:12:40.000000000 +0400
+++ linux-2.6.7/fs/jbd/commit.c	2005-01-19 17:28:32.965111552 +0300
@@ -103,7 +103,7 @@
 {
 	transaction_t *commit_transaction;
 	struct journal_head *jh, *new_jh, *descriptor;
-	struct buffer_head *wbuf[64];
+	struct buffer_head **wbuf = journal->j_wbuf;
 	int bufs;
 	int flags;
 	int err;
@@ -271,7 +283,7 @@
 				BUFFER_TRACE(bh, "start journal writeout");
 				get_bh(bh);
 				wbuf[bufs++] = bh;
-				if (bufs == ARRAY_SIZE(wbuf)) {
+				if (bufs == journal->j_wbufsize) {
 					jbd_debug(2, "submit %d writes\n",
 							bufs);
 					spin_unlock(&journal->j_list_lock);
@@ -488,7 +500,7 @@
 		/* If there's no more to do, or if the descriptor is full,
 		   let the IO rip! */
 
-		if (bufs == ARRAY_SIZE(wbuf) ||
+		if (bufs == journal->j_wbufsize ||
 		    commit_transaction->t_buffers == NULL ||
 		    space_left < sizeof(journal_block_tag_t) + 16) {
 
Index: linux-2.6.7/fs/jbd/journal.c
===================================================================
--- linux-2.6.7.orig/fs/jbd/journal.c	2005-01-19 12:07:59.000000000 +0300
+++ linux-2.6.7/fs/jbd/journal.c	2005-01-19 17:11:08.589880720 +0300
@@ -687,6 +687,7 @@
 {
 	journal_t *journal = journal_init_common();
 	struct buffer_head *bh;
+	int n;
 
 	if (!journal)
 		return NULL;
@@ -702,6 +703,17 @@
 	journal->j_sb_buffer = bh;
 	journal->j_superblock = (journal_superblock_t *)bh->b_data;
 
+	/* journal descriptor can store upto n blocks -bzzz */
+	n = journal->j_blocksize / sizeof(journal_block_tag_t);
+	journal->j_wbufsize = n;
+	journal->j_wbuf = kmalloc(n * sizeof(struct buffer_head*), GFP_KERNEL);
+	if (!journal->j_wbuf) {
+		printk(KERN_ERR "%s: Cant allocate bhs for commit thread\n",
+			__FUNCTION__);
+		kfree(journal);
+		journal = NULL;
+	}
+	
 	return journal;
 }
  
@@ -717,7 +729,7 @@
 {
 	struct buffer_head *bh;
 	journal_t *journal = journal_init_common();
-	int err;
+	int err, n;
 	unsigned long blocknr;
 
 	if (!journal)
@@ -734,6 +746,17 @@
 	journal->j_maxlen = inode->i_size >> inode->i_sb->s_blocksize_bits;
 	journal->j_blocksize = inode->i_sb->s_blocksize;
 
+	/* journal descriptor can store upto n blocks -bzzz */
+	n = journal->j_blocksize / sizeof(journal_block_tag_t);
+	journal->j_wbufsize = n;
+	journal->j_wbuf = kmalloc(n * sizeof(struct buffer_head*), GFP_KERNEL);
+	if (!journal->j_wbuf) {
+		printk(KERN_ERR "%s: Cant allocate bhs for commit thread\n",
+			__FUNCTION__);
+		kfree(journal);
+		return NULL;
+	}
+
 	err = journal_bmap(journal, 0, &blocknr);
 	/* If that failed, give up */
 	if (err) {
@@ -1107,6 +1130,10 @@
 		iput(journal->j_inode);
 	if (journal->j_revoke)
 		journal_destroy_revoke(journal);
+	if (journal->j_wbuf) {
+		kfree(journal->j_wbuf);
+		journal->j_wbuf = NULL;
+	}
 	kfree(journal);
 }
 

