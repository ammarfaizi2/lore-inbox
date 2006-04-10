Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbWDJR7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWDJR7u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 13:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932068AbWDJR7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 13:59:49 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:14045 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932069AbWDJR7q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 13:59:46 -0400
Subject: [RFC][PATCH 3/3] ext3 percpu counter mod changes to suppport more
	than 2**31 free blocks
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: akpm@osdl.org
Cc: kiran@scalex86.org, Laurent Vivier <Laurent.Vivier@bull.net>,
       linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Content-Type: text/plain
Organization: IBM LTC
Date: Mon, 10 Apr 2006 10:59:43 -0700
Message-Id: <1144691983.3964.56.camel@dyn9047017067.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 3/3] - Change ext3 to make use of percpu_counter_mod_ll()(added
in patch 1/3) to prevent counter overflow, when updating the free blocks
counter.

Signed-Off-By: Mingming Cao <cmm@us.ibm.com> 

---

 fs/ext3/ialloc.c                  |    0 
 linux-2.6.16-cmm/fs/ext3/balloc.c |    4 ++--
 linux-2.6.16-cmm/fs/ext3/resize.c |    2 +-
 linux-2.6.16-cmm/fs/ext3/super.c  |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff -puN fs/ext3/balloc.c~ext3_16tb_freeblks_counter_mod_fix fs/ext3/balloc.c
--- linux-2.6.16/fs/ext3/balloc.c~ext3_16tb_freeblks_counter_mod_fix	2006-04-05 10:18:29.000000000 -0700
+++ linux-2.6.16-cmm/fs/ext3/balloc.c	2006-04-05 15:51:14.000000000 -0700
@@ -467,7 +467,7 @@ do_more:
 		cpu_to_le16(le16_to_cpu(desc->bg_free_blocks_count) +
 			group_freed);
 	spin_unlock(sb_bgl_lock(sbi, block_group));
-	percpu_counter_mod(&sbi->s_freeblocks_counter, count);
+	percpu_counter_mod_ll(&sbi->s_freeblocks_counter, count);
 
 	/* We dirtied the bitmap block */
 	BUFFER_TRACE(bitmap_bh, "dirtied bitmap block");
@@ -1431,7 +1431,7 @@ allocated:
 	gdp->bg_free_blocks_count =
 			cpu_to_le16(le16_to_cpu(gdp->bg_free_blocks_count) - num);
 	spin_unlock(sb_bgl_lock(sbi, group_no));
-	percpu_counter_mod(&sbi->s_freeblocks_counter, -num);
+	percpu_counter_mod_ll(&sbi->s_freeblocks_counter, -num);
 
 	BUFFER_TRACE(gdp_bh, "journal_dirty_metadata for group descriptor");
 	err = ext3_journal_dirty_metadata(handle, gdp_bh);
diff -puN fs/ext3/resize.c~ext3_16tb_freeblks_counter_mod_fix fs/ext3/resize.c
--- linux-2.6.16/fs/ext3/resize.c~ext3_16tb_freeblks_counter_mod_fix	2006-04-05 10:18:29.000000000 -0700
+++ linux-2.6.16-cmm/fs/ext3/resize.c	2006-04-05 10:20:45.000000000 -0700
@@ -869,7 +869,7 @@ int ext3_group_add(struct super_block *s
 		input->reserved_blocks);
 
 	/* Update the free space counts */
-	percpu_counter_mod(&sbi->s_freeblocks_counter,
+	percpu_counter_mod_ll(&sbi->s_freeblocks_counter,
 			   input->free_blocks_count);
 	percpu_counter_mod(&sbi->s_freeinodes_counter,
 			   EXT3_INODES_PER_GROUP(sb));
diff -puN fs/ext3/super.c~ext3_16tb_freeblks_counter_mod_fix fs/ext3/super.c
--- linux-2.6.16/fs/ext3/super.c~ext3_16tb_freeblks_counter_mod_fix	2006-04-05 10:18:29.000000000 -0700
+++ linux-2.6.16-cmm/fs/ext3/super.c	2006-04-05 15:53:58.000000000 -0700
@@ -2367,7 +2367,7 @@ static int ext3_statfs (struct super_blo
 	buf->f_type = EXT3_SUPER_MAGIC;
 	buf->f_bsize = sb->s_blocksize;
 	buf->f_blocks = le32_to_cpu(es->s_blocks_count) - overhead;
-	buf->f_bfree = percpu_counter_sum(&sbi->s_freeblocks_counter);
+	buf->f_bfree = (unsigned long)percpu_counter_sum_ll(&sbi->s_freeblocks_counter);
 	buf->f_bavail = buf->f_bfree - le32_to_cpu(es->s_r_blocks_count);
 	if (buf->f_bfree < le32_to_cpu(es->s_r_blocks_count))
 		buf->f_bavail = 0;
diff -puN fs/ext3/ialloc.c~ext3_16tb_freeblks_counter_mod_fix fs/ext3/ialloc.c

_


