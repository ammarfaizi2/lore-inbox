Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272492AbTGaOkK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 10:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272498AbTGaOkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 10:40:10 -0400
Received: from angband.namesys.com ([212.16.7.85]:48062 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S272492AbTGaOkG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 10:40:06 -0400
Date: Thu, 31 Jul 2003 18:40:04 +0400
From: Oleg Drokin <green@namesys.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATH] [2.5] reiserfs: fix problem when fs is out of space
Message-ID: <20030731144004.GO14081@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

    This patch fixes various bad stuff that happens when you write to full or almost full
    reiserfs filesystem.


===== fs/reiserfs/bitmap.c 1.27 vs edited =====
--- 1.27/fs/reiserfs/bitmap.c	Fri Jul 11 09:22:55 2003
+++ edited/fs/reiserfs/bitmap.c	Thu Jul 31 18:01:52 2003
@@ -910,11 +910,11 @@
 int reiserfs_can_fit_pages ( struct super_block *sb /* superblock of filesystem
 						       to estimate space */ )
 {
-	b_blocknr_t space;
+	int space;
 
 	spin_lock(&REISERFS_SB(sb)->bitmap_lock);
 	space = (SB_FREE_BLOCKS(sb) - REISERFS_SB(sb)->reserved_blocks) >> ( PAGE_CACHE_SHIFT - sb->s_blocksize_bits);
 	spin_unlock(&REISERFS_SB(sb)->bitmap_lock);
 
-	return space;
+	return space>0?space:0;
 }
===== fs/reiserfs/file.c 1.20 vs edited =====
--- 1.20/fs/reiserfs/file.c	Wed Jun  4 11:50:34 2003
+++ edited/fs/reiserfs/file.c	Thu Jul 31 18:01:37 2003
@@ -1085,6 +1085,8 @@
 	    // 100% of disk space anyway.
 	    write_bytes = min_t(int, count, inode->i_sb->s_blocksize - (pos & (inode->i_sb->s_blocksize - 1)));
 	    num_pages = 1;
+	    // No blocks were claimed before, so do it now.
+	    reiserfs_claim_blocks_to_be_allocated(inode->i_sb, 1 << (PAGE_CACHE_SHIFT - inode->i_blkbits));
 	}
 
 	/* Prepare for writing into the region, read in all the
