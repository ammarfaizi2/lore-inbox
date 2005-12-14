Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbVLNTiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbVLNTiK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 14:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbVLNTiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 14:38:10 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:20574 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S932099AbVLNTiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 14:38:09 -0500
Date: Wed, 14 Dec 2005 14:38:05 -0500
From: Jeff Mahoney <jeffm@suse.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: ReiserFS List <reiserfs-list@namesys.com>
Subject: [PATCH] reiserfs: close open transactions on error path
Message-ID: <20051214193805.GA5600@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.201-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 The following patch fixes a bug where if the journal is aborted, it can
 leave a transaction open. The result will be a BUG when another code path
 attempts to start a transaction and will get a "nesting into different fs"
 error, since current->journal_info will be left non-NULL.

 Original fix against SUSE kernel by Chris Mason <mason@suse.com>

Signed-off-by: Jeff Mahoney <jeffm@suse.com>

diff -ruNpX dontdiff linux-2.6.14.orig/fs/reiserfs/inode.c linux-2.6.14.fixed/fs/reiserfs/inode.c
--- linux-2.6.14.orig/fs/reiserfs/inode.c	2005-10-27 20:02:08.000000000 -0400
+++ linux-2.6.14.fixed/fs/reiserfs/inode.c	2005-12-05 17:10:37.000000000 -0500
@@ -32,6 +32,7 @@ void reiserfs_delete_inode(struct inode 
 	    JOURNAL_PER_BALANCE_CNT * 2 +
 	    2 * REISERFS_QUOTA_INIT_BLOCKS(inode->i_sb);
 	struct reiserfs_transaction_handle th;
+	int err;
 
 	truncate_inode_pages(&inode->i_data, 0);
 
@@ -49,15 +50,13 @@ void reiserfs_delete_inode(struct inode 
 		}
 		reiserfs_update_inode_transaction(inode);
 
-		if (reiserfs_delete_object(&th, inode)) {
-			up(&inode->i_sem);
-			goto out;
-		}
+		err = reiserfs_delete_object(&th, inode);
 
 		/* Do quota update inside a transaction for journaled quotas. We must do that
 		 * after delete_object so that quota updates go into the same transaction as
 		 * stat data deletion */
-		DQUOT_FREE_INODE(inode);
+		if (!err) 
+			DQUOT_FREE_INODE(inode);
 
 		if (journal_end(&th, inode->i_sb, jbegin_count)) {
 			up(&inode->i_sem);
@@ -66,6 +65,12 @@ void reiserfs_delete_inode(struct inode 
 
 		up(&inode->i_sem);
 
+		/* check return value from reiserfs_delete_object after
+		 * ending the transaction
+		 */
+		if (err)
+		    goto out;
+
 		/* all items of file are deleted, so we can remove "save" link */
 		remove_save_link(inode, 0 /* not truncate */ );	/* we can't do anything
 								 * about an error here */
@@ -2099,6 +2104,7 @@ int reiserfs_truncate_file(struct inode 
 	struct page *page = NULL;
 	int error;
 	struct buffer_head *bh = NULL;
+	int err2;
 
 	reiserfs_write_lock(p_s_inode->i_sb);
 
@@ -2137,13 +2143,17 @@ int reiserfs_truncate_file(struct inode 
 		   either appears truncated properly or not truncated at all */
 		add_save_link(&th, p_s_inode, 1);
-	error = reiserfs_do_truncate(&th, p_s_inode, page, update_timestamps);
+	err2 = reiserfs_do_truncate(&th, p_s_inode, page, update_timestamps);
-	if (error)
-		goto out;
 	error =
 	    journal_end(&th, p_s_inode->i_sb, JOURNAL_PER_BALANCE_CNT * 2 + 1);
 	if (error)
 		goto out;
 
+	/* check reiserfs_do_truncate after ending the transaction */
+	if (err2) {
+		error = err2;
+  		goto out;
+	}
+	
 	if (update_timestamps) {
 		error = remove_save_link(p_s_inode, 1 /* truncate */ );
 		if (error)
-- 
Jeff Mahoney
SuSE Labs
