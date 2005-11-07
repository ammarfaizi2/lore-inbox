Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964985AbVKGRcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964985AbVKGRcr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 12:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965099AbVKGRcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 12:32:45 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:36873 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S964937AbVKGRcm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 12:32:42 -0500
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] fat: move fat_clusters_flush() to write_super()
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 08 Nov 2005 02:32:29 +0900
Message-ID: <87hdaotlci.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is overkill to update the FS_INFO whenever modifying
prev_free/free_clusters, because those are just a hint.

So, this patch uses ->write_super() for updating FS_INFO instead.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/fatent.c |    8 ++++++--
 fs/fat/inode.c  |   10 ++++++++--
 fs/fat/misc.c   |    2 --
 3 files changed, 14 insertions(+), 6 deletions(-)

diff -puN fs/fat/fatent.c~fat_write_super fs/fat/fatent.c
--- linux-2.6.14/fs/fat/fatent.c~fat_write_super	2005-11-07 02:14:05.000000000 +0900
+++ linux-2.6.14-hirofumi/fs/fat/fatent.c	2005-11-07 03:46:35.000000000 +0900
@@ -476,6 +476,7 @@ int fat_alloc_clusters(struct inode *ino
 				sbi->prev_free = entry;
 				if (sbi->free_clusters != -1)
 					sbi->free_clusters--;
+				sb->s_dirt = 1;
 
 				cluster[idx_clus] = entry;
 				idx_clus++;
@@ -496,6 +497,7 @@ int fat_alloc_clusters(struct inode *ino
 
 	/* Couldn't allocate the free entries */
 	sbi->free_clusters = 0;
+	sb->s_dirt = 1;
 	err = -ENOSPC;
 
 out:
@@ -509,7 +511,6 @@ out:
 	}
 	for (i = 0; i < nr_bhs; i++)
 		brelse(bhs[i]);
-	fat_clusters_flush(sb);
 
 	if (err && idx_clus)
 		fat_free_clusters(inode, cluster[0]);
@@ -542,8 +543,10 @@ int fat_free_clusters(struct inode *inod
 		}
 
 		ops->ent_put(&fatent, FAT_ENT_FREE);
-		if (sbi->free_clusters != -1)
+		if (sbi->free_clusters != -1) {
 			sbi->free_clusters++;
+			sb->s_dirt = 1;
+		}
 
 		if (nr_bhs + fatent.nr_bhs > MAX_BUF_PER_PAGE) {
 			if (sb->s_flags & MS_SYNCHRONOUS) {
@@ -605,6 +608,7 @@ int fat_count_free_clusters(struct super
 		} while (fat_ent_next(sbi, &fatent));
 	}
 	sbi->free_clusters = free;
+	sb->s_dirt = 1;
 	fatent_brelse(&fatent);
 out:
 	unlock_fat(sbi);
diff -puN fs/fat/inode.c~fat_write_super fs/fat/inode.c
--- linux-2.6.14/fs/fat/inode.c~fat_write_super	2005-11-07 02:14:05.000000000 +0900
+++ linux-2.6.14-hirofumi/fs/fat/inode.c	2005-11-07 03:55:16.000000000 +0900
@@ -374,12 +374,17 @@ static void fat_clear_inode(struct inode
 	unlock_kernel();
 }
 
-static void fat_put_super(struct super_block *sb)
+static void fat_write_super(struct super_block *sb)
 {
-	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+	sb->s_dirt = 0;
 
 	if (!(sb->s_flags & MS_RDONLY))
 		fat_clusters_flush(sb);
+}
+
+static void fat_put_super(struct super_block *sb)
+{
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 
 	if (sbi->nls_disk) {
 		unload_nls(sbi->nls_disk);
@@ -546,6 +551,7 @@ static struct super_operations fat_sops 
 	.write_inode	= fat_write_inode,
 	.delete_inode	= fat_delete_inode,
 	.put_super	= fat_put_super,
+	.write_super	= fat_write_super,
 	.statfs		= fat_statfs,
 	.clear_inode	= fat_clear_inode,
 	.remount_fs	= fat_remount,
diff -puN fs/fat/misc.c~fat_write_super fs/fat/misc.c
--- linux-2.6.14/fs/fat/misc.c~fat_write_super	2005-11-07 02:14:05.000000000 +0900
+++ linux-2.6.14-hirofumi/fs/fat/misc.c	2005-11-07 03:46:35.000000000 +0900
@@ -67,8 +67,6 @@ void fat_clusters_flush(struct super_blo
 		if (sbi->prev_free != -1)
 			fsinfo->next_cluster = cpu_to_le32(sbi->prev_free);
 		mark_buffer_dirty(bh);
-		if (sb->s_flags & MS_SYNCHRONOUS)
-			sync_dirty_buffer(bh);
 	}
 	brelse(bh);
 }
_
