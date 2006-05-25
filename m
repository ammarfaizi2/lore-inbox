Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965138AbWEYMn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965138AbWEYMn7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 08:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965141AbWEYMn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 08:43:59 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:9381 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S965138AbWEYMn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 08:43:58 -0400
To: adilger@clusterfs.com, cmm@us.ibm.com, jitendra@linsyssoft.com
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [UPDATE][4/24]ext2 add new percpu_counter
Message-Id: <20060525214350sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Thu, 25 May 2006 21:43:50 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary of this patch:
  [4/24]  add percpu_llcounter for ext2
          - The number of blocks and inodes are counted using
            percpu_counter whose entry for counter is long type, so it
            can only have less than 2G-1.  Then I add percpu_llcounter
            whose entry for counter is long long type in ext2..

Signed-off-by: Takashi Sato sho@tnes.nec.co.jp
---
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/fs/ext2/balloc.c linux-2.6.17-rc4.tmp/fs/ext2/balloc.c
--- linux-2.6.17-rc4/fs/ext2/balloc.c	2006-03-20 14:53:29.000000000 +0900
+++ linux-2.6.17-rc4.tmp/fs/ext2/balloc.c	2006-05-25 16:30:50.201895538 +0900
@@ -106,7 +106,7 @@ static int reserve_blocks(struct super_b
 	unsigned free_blocks;
 	unsigned root_blocks;
 
-	free_blocks = percpu_counter_read_positive(&sbi->s_freeblocks_counter);
+	free_blocks = percpu_llcounter_read_positive(&sbi->s_freeblocks_counter);
 	root_blocks = le32_to_cpu(es->s_r_blocks_count);
 
 	if (free_blocks < count)
@@ -125,7 +125,7 @@ static int reserve_blocks(struct super_b
 			return 0;
 	}
 
-	percpu_counter_mod(&sbi->s_freeblocks_counter, -count);
+	percpu_llcounter_mod(&sbi->s_freeblocks_counter, -(long long)count);
 	sb->s_dirt = 1;
 	return count;
 }
@@ -135,7 +135,7 @@ static void release_blocks(struct super_
 	if (count) {
 		struct ext2_sb_info *sbi = EXT2_SB(sb);
 
-		percpu_counter_mod(&sbi->s_freeblocks_counter, count);
+		percpu_llcounter_mod(&sbi->s_freeblocks_counter, count);
 		sb->s_dirt = 1;
 	}
 }
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/fs/ext2/ialloc.c linux-2.6.17-rc4.tmp/fs/ext2/ialloc.c
--- linux-2.6.17-rc4/fs/ext2/ialloc.c	2006-03-20 14:53:29.000000000 +0900
+++ linux-2.6.17-rc4.tmp/fs/ext2/ialloc.c	2006-05-25 16:30:50.201895538 +0900
@@ -83,7 +83,7 @@ static void ext2_release_inode(struct su
 			cpu_to_le16(le16_to_cpu(desc->bg_used_dirs_count) - 1);
 	spin_unlock(sb_bgl_lock(EXT2_SB(sb), group));
 	if (dir)
-		percpu_counter_dec(&EXT2_SB(sb)->s_dirs_counter);
+		percpu_llcounter_dec(&EXT2_SB(sb)->s_dirs_counter);
 	sb->s_dirt = 1;
 	mark_buffer_dirty(bh);
 }
@@ -287,11 +287,11 @@ static int find_group_orlov(struct super
 	struct ext2_group_desc *desc;
 	struct buffer_head *bh;
 
-	freei = percpu_counter_read_positive(&sbi->s_freeinodes_counter);
+	freei = percpu_llcounter_read_positive(&sbi->s_freeinodes_counter);
 	avefreei = freei / ngroups;
-	free_blocks = percpu_counter_read_positive(&sbi->s_freeblocks_counter);
+	free_blocks = percpu_llcounter_read_positive(&sbi->s_freeblocks_counter);
 	avefreeb = free_blocks / ngroups;
-	ndirs = percpu_counter_read_positive(&sbi->s_dirs_counter);
+	ndirs = percpu_llcounter_read_positive(&sbi->s_dirs_counter);
 
 	if ((parent == sb->s_root->d_inode) ||
 	    (EXT2_I(parent)->i_flags & EXT2_TOPDIR_FL)) {
@@ -328,7 +328,7 @@ static int find_group_orlov(struct super
 	}
 
 	if (ndirs == 0)
-		ndirs = 1;	/* percpu_counters are approximate... */
+		ndirs = 1;	/* percpu_llcounters are approximate... */
 
 	blocks_per_dir = (le32_to_cpu(es->s_blocks_count)-free_blocks) / ndirs;
 
@@ -543,9 +543,9 @@ got:
 		goto fail;
 	}
 
-	percpu_counter_mod(&sbi->s_freeinodes_counter, -1);
+	percpu_llcounter_mod(&sbi->s_freeinodes_counter, -1);
 	if (S_ISDIR(mode))
-		percpu_counter_inc(&sbi->s_dirs_counter);
+		percpu_llcounter_inc(&sbi->s_dirs_counter);
 
 	spin_lock(sb_bgl_lock(sbi, group));
 	gdp->bg_free_inodes_count =
@@ -670,7 +670,7 @@ unsigned long ext2_count_free_inodes (st
 	}
 	brelse(bitmap_bh);
 	printk("ext2_count_free_inodes: stored = %lu, computed = %lu, %lu\n",
-		percpu_counter_read(&EXT2_SB(sb)->s_freeinodes_counter),
+		percpu_llcounter_read(&EXT2_SB(sb)->s_freeinodes_counter),
 		desc_count, bitmap_count);
 	unlock_super(sb);
 	return desc_count;
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/fs/ext2/super.c linux-2.6.17-rc4.tmp/fs/ext2/super.c
--- linux-2.6.17-rc4/fs/ext2/super.c	2006-05-25 16:18:35.846435784 +0900
+++ linux-2.6.17-rc4.tmp/fs/ext2/super.c	2006-05-25 16:30:50.202872101 +0900
@@ -126,9 +126,9 @@ static void ext2_put_super (struct super
 			brelse (sbi->s_group_desc[i]);
 	kfree(sbi->s_group_desc);
 	kfree(sbi->s_debts);
-	percpu_counter_destroy(&sbi->s_freeblocks_counter);
-	percpu_counter_destroy(&sbi->s_freeinodes_counter);
-	percpu_counter_destroy(&sbi->s_dirs_counter);
+	percpu_llcounter_destroy(&sbi->s_freeblocks_counter);
+	percpu_llcounter_destroy(&sbi->s_freeinodes_counter);
+	percpu_llcounter_destroy(&sbi->s_dirs_counter);
 	brelse (sbi->s_sbh);
 	sb->s_fs_info = NULL;
 	kfree(sbi);
@@ -834,9 +834,9 @@ static int ext2_fill_super(struct super_
 		printk ("EXT2-fs: not enough memory\n");
 		goto failed_mount;
 	}
-	percpu_counter_init(&sbi->s_freeblocks_counter);
-	percpu_counter_init(&sbi->s_freeinodes_counter);
-	percpu_counter_init(&sbi->s_dirs_counter);
+	percpu_llcounter_init(&sbi->s_freeblocks_counter);
+	percpu_llcounter_init(&sbi->s_freeinodes_counter);
+	percpu_llcounter_init(&sbi->s_dirs_counter);
 	bgl_lock_init(&sbi->s_blockgroup_lock);
 	sbi->s_debts = kmalloc(sbi->s_groups_count * sizeof(*sbi->s_debts),
 			       GFP_KERNEL);
@@ -886,11 +886,11 @@ static int ext2_fill_super(struct super_
 		ext2_warning(sb, __FUNCTION__,
 			"mounting ext3 filesystem as ext2");
 	ext2_setup_super (sb, es, sb->s_flags & MS_RDONLY);
-	percpu_counter_mod(&sbi->s_freeblocks_counter,
+	percpu_llcounter_mod(&sbi->s_freeblocks_counter,
 				ext2_count_free_blocks(sb));
-	percpu_counter_mod(&sbi->s_freeinodes_counter,
+	percpu_llcounter_mod(&sbi->s_freeinodes_counter,
 				ext2_count_free_inodes(sb));
-	percpu_counter_mod(&sbi->s_dirs_counter,
+	percpu_llcounter_mod(&sbi->s_dirs_counter,
 				ext2_count_dirs(sb));
 	return 0;
 
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/include/linux/ext2_fs_sb.h linux-2.6.17-rc4.tmp/include/linux/ext2_fs_sb.h
--- linux-2.6.17-rc4/include/linux/ext2_fs_sb.h	2006-03-20 14:53:29.000000000 +0900
+++ linux-2.6.17-rc4.tmp/include/linux/ext2_fs_sb.h	2006-05-25 16:30:50.203848663 +0900
@@ -17,7 +17,7 @@
 #define _LINUX_EXT2_FS_SB
 
 #include <linux/blockgroup_lock.h>
-#include <linux/percpu_counter.h>
+#include <linux/percpu_llcounter.h>
 
 /*
  * second extended-fs super-block data in memory
@@ -49,9 +49,9 @@ struct ext2_sb_info {
 	u32 s_next_generation;
 	unsigned long s_dir_count;
 	u8 *s_debts;
-	struct percpu_counter s_freeblocks_counter;
-	struct percpu_counter s_freeinodes_counter;
-	struct percpu_counter s_dirs_counter;
+	struct percpu_llcounter s_freeblocks_counter;
+	struct percpu_llcounter s_freeinodes_counter;
+	struct percpu_llcounter s_dirs_counter;
 	struct blockgroup_lock s_blockgroup_lock;
 };
 



