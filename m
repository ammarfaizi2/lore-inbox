Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262069AbVBAQyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbVBAQyn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 11:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbVBAQyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 11:54:43 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:48811 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262069AbVBAQyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 11:54:02 -0500
Date: Tue, 1 Feb 2005 17:54:01 +0100
From: Jan Kara <jack@suse.cz>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, vs@namesys.com
Subject: [PATCH] Fix reiserfs quota SMP locks
Message-ID: <20050201165401.GA17148@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello!

  Attached patch adds missing SMP locks to the reiserfs quota code and
one missing lock_buffer(). Please apply.

							Bye
								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reiserlock-2.6.11-rc2.diff"

From: Vladimir Saveliev <vs@namesys.com>, Jan Kara <jack@suse.cz>

Add missing SMP locking and one lock_buffer() to the reiserfs quota code.

Signed-off-by: Jan Kara <jack@suse.cz>

diff -rupX /home/jack/.kerndiffexclude linux-2.6.11-rc2/fs/reiserfs/super.c linux-2.6.11-rc2-reiserlock/fs/reiserfs/super.c
--- linux-2.6.11-rc2/fs/reiserfs/super.c	2005-01-27 12:56:27.000000000 +0100
+++ linux-2.6.11-rc2-reiserlock/fs/reiserfs/super.c	2005-02-01 19:48:42.000000000 +0100
@@ -1835,9 +1835,11 @@ static int reiserfs_dquot_initialize(str
     int ret;
 
     /* We may create quota structure so we need to reserve enough blocks */
+    reiserfs_write_lock(inode->i_sb);
     journal_begin(&th, inode->i_sb, 2*REISERFS_QUOTA_INIT_BLOCKS);
     ret = dquot_initialize(inode, type);
     journal_end(&th, inode->i_sb, 2*REISERFS_QUOTA_INIT_BLOCKS);
+    reiserfs_write_unlock(inode->i_sb);
     return ret;
 }
 
@@ -1847,9 +1849,11 @@ static int reiserfs_dquot_drop(struct in
     int ret;
 
     /* We may delete quota structure so we need to reserve enough blocks */
+    reiserfs_write_lock(inode->i_sb);
     journal_begin(&th, inode->i_sb, 2*REISERFS_QUOTA_INIT_BLOCKS);
     ret = dquot_drop(inode);
     journal_end(&th, inode->i_sb, 2*REISERFS_QUOTA_INIT_BLOCKS);
+    reiserfs_write_unlock(inode->i_sb);
     return ret;
 }
 
@@ -1858,9 +1862,11 @@ static int reiserfs_write_dquot(struct d
     struct reiserfs_transaction_handle th;
     int ret;
 
+    reiserfs_write_lock(dquot->dq_sb);
     journal_begin(&th, dquot->dq_sb, REISERFS_QUOTA_TRANS_BLOCKS);
     ret = dquot_commit(dquot);
     journal_end(&th, dquot->dq_sb, REISERFS_QUOTA_TRANS_BLOCKS);
+    reiserfs_write_unlock(dquot->dq_sb);
     return ret;
 }
 
@@ -1869,9 +1875,11 @@ static int reiserfs_acquire_dquot(struct
     struct reiserfs_transaction_handle th;
     int ret;
 
+    reiserfs_write_lock(dquot->dq_sb);
     journal_begin(&th, dquot->dq_sb, REISERFS_QUOTA_INIT_BLOCKS);
     ret = dquot_acquire(dquot);
     journal_end(&th, dquot->dq_sb, REISERFS_QUOTA_INIT_BLOCKS);
+    reiserfs_write_unlock(dquot->dq_sb);
     return ret;
 }
 
@@ -1880,9 +1888,11 @@ static int reiserfs_release_dquot(struct
     struct reiserfs_transaction_handle th;
     int ret;
 
+    reiserfs_write_lock(dquot->dq_sb);
     journal_begin(&th, dquot->dq_sb, REISERFS_QUOTA_INIT_BLOCKS);
     ret = dquot_release(dquot);
     journal_end(&th, dquot->dq_sb, REISERFS_QUOTA_INIT_BLOCKS);
+    reiserfs_write_unlock(dquot->dq_sb);
     return ret;
 }
 
@@ -1904,9 +1914,11 @@ static int reiserfs_write_info(struct su
     int ret;
 
     /* Data block + inode block */
+    reiserfs_write_lock(sb);
     journal_begin(&th, sb, 2);
     ret = dquot_commit_info(sb, type);
     journal_end(&th, sb, 2);
+    reiserfs_write_unlock(sb);
     return ret;
 }
 
@@ -1993,7 +2005,9 @@ static ssize_t reiserfs_quota_read(struc
 	tocopy = sb->s_blocksize - offset < toread ? sb->s_blocksize - offset : toread;
 	tmp_bh.b_state = 0;
 	/* Quota files are without tails so we can safely use this function */
+	reiserfs_write_lock(sb);
 	err = reiserfs_get_block(inode, blk, &tmp_bh, 0);
+	reiserfs_write_unlock(sb);
 	if (err)
 	    return err;
 	if (!buffer_mapped(&tmp_bh))    /* A hole? */
@@ -2041,8 +2055,11 @@ static ssize_t reiserfs_quota_write(stru
 	    err = -EIO;
 	    goto out;
 	}
+	lock_buffer(bh);
 	memcpy(bh->b_data+offset, data, tocopy);
+	flush_dcache_page(bh->b_page);
 	set_buffer_uptodate(bh);
+	unlock_buffer(bh);
 	reiserfs_prepare_for_journal(sb, bh, 1);
 	journal_mark_dirty(current->journal_info, sb, bh);
 	if (!journal_quota)

--0F1p//8PRICkK4MW--
