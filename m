Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269266AbUI3Nhi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269266AbUI3Nhi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 09:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269250AbUI3NZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 09:25:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23448 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269267AbUI3NYF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 09:24:05 -0400
Date: Thu, 30 Sep 2004 14:23:39 +0100
Message-Id: <200409301323.i8UDNdVK004783@sisko.scot.redhat.com>
From: Stephen Tweedie <sct@redhat.com>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Andreas Dilger <adilger@clusterfs.com>, "Theodore Ts'o" <tytso@mit.edu>,
       ext2-devel@lists.sourceforge.net
Cc: Stephen Tweedie <sct@redhat.com>
Subject: [Patch 5/10]: ext3 online resize: lock newly-created buffers
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lock buffers before initialising their contents to avoid any risk of
being overwritten by the results of a parallel read.

Signed-off-by: Stephen Tweedie <sct@redhat.com>

--- linux-2.6.9-rc2-mm4/fs/ext3/resize.c.=K0004=.orig
+++ linux-2.6.9-rc2-mm4/fs/ext3/resize.c
@@ -118,13 +118,16 @@ static struct buffer_head *bclean(handle
 	int err;
 
 	bh = sb_getblk(sb, blk);
-	set_buffer_uptodate(bh);
 	if ((err = ext3_journal_get_write_access(handle, bh))) {
 		brelse(bh);
 		bh = ERR_PTR(err);
-	} else
+	} else {
+		lock_buffer(bh);
 		memset(bh->b_data, 0, sb->s_blocksize);
-
+		set_buffer_uptodate(bh);
+		unlock_buffer(bh);
+	}
+	
 	return bh;
 }
 
@@ -201,12 +204,14 @@ static int setup_new_group_blocks(struct
 		ext3_debug("update backup group %#04lx (+%d)\n", block, bit);
 
 		gdb = sb_getblk(sb, block);
-		set_buffer_uptodate(gdb);
 		if ((err = ext3_journal_get_write_access(handle, gdb))) {
 			brelse(gdb);
 			goto exit_bh;
 		}
+		lock_buffer(bh);
 		memcpy(gdb->b_data, sbi->s_group_desc[i], bh->b_size);
+		set_buffer_uptodate(gdb);
+		unlock_buffer(bh);
 		ext3_journal_dirty_metadata(handle, gdb);
 		ext3_set_bit(bit, bh->b_data);
 		brelse(gdb);
@@ -642,14 +647,16 @@ static void update_backups(struct super_
 			break;
 
 		bh = sb_getblk(sb, group * bpg + blk_off);
-		set_buffer_uptodate(bh);
 		ext3_debug(sb, __FUNCTION__, "update metadata backup %#04lx\n",
 			   bh->b_blocknr);
 		if ((err = ext3_journal_get_write_access(handle, bh)))
 			break;
+		lock_buffer(bh);
 		memcpy(bh->b_data, data, size);
 		if (rest)
 			memset(bh->b_data + size, 0, rest);
+		set_buffer_uptodate(bh);
+		unlock_buffer(bh);
 		ext3_journal_dirty_metadata(handle, bh);
 		brelse(bh);
 	}
