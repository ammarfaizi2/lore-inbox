Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261592AbTCOVlo>; Sat, 15 Mar 2003 16:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261597AbTCOVlo>; Sat, 15 Mar 2003 16:41:44 -0500
Received: from packet.digeo.com ([12.110.80.53]:50063 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261592AbTCOVlj>;
	Sat, 15 Mar 2003 16:41:39 -0500
Date: Sat, 15 Mar 2003 13:51:58 -0800
From: Andrew Morton <akpm@digeo.com>
To: Alex Tomas <bzzz@tmi.comex.ru>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [PATCH] concurrent inode allocation for ext2 against 2.5.64
Message-Id: <20030315135158.6d5fef1a.akpm@digeo.com>
In-Reply-To: <m365qk1gzx.fsf@lexa.home.net>
References: <m365qk1gzx.fsf@lexa.home.net>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Mar 2003 21:51:43.0833 (UTC) FILETIME=[1176DC90:01C2EB3D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tomas <bzzz@tmi.comex.ru> wrote:
>
> 
> hi!
> 
> here is the patch for ext2 concurrent inode allocation. should be applied
> on top of previous concurrent-balloc patch. tested on dual p3 for several
> hours of stress-test + fsck. hope someone test it on big iron ;)
> 


> ...
> +void ext2_reserve_inode (struct super_block * sb, int group, int dir)
> +{

This can have static scope.  And, please, no spaces after the function name,
nor after the `*' thingy.  ext2 is all over the place in this regard and I'm
slowly trying to get it consistent.

I'm not sure that skipping setting s_dirt is desirable.  Sure, we haven't
actually altered the superblock.  But we sort-of "virtually dirtied" it.  The
superblock is now out-of-date and we should sync it.

It could be that not writing the superblock for a week is an OK thing to do. 
inode and block allocation counts are something which fsck can trivially fix
up.  But at the cost of a single sector write per five seconds I think it's
best to keep the superblock more up-to-date.

I'll make the same change to the block allocator patches.

>  struct ext2_bg_info {
>  	u8 debts;
>  	spinlock_t balloc_lock;
> +	spinlock_t ialloc_lock;
>  	unsigned int reserved;
>  } ____cacheline_aligned_in_smp;
> 

hm, I wonder if this should be in a separate cacheline.  We may as well use a
single lock if they're this close together.  Bill, can you test that
sometime?


diff -puN fs/ext2/ialloc.c~ext2-ialloc-no-lock_super-fixes fs/ext2/ialloc.c
--- 25/fs/ext2/ialloc.c~ext2-ialloc-no-lock_super-fixes	2003-03-15 13:36:14.000000000 -0800
+++ 25-akpm/fs/ext2/ialloc.c	2003-03-15 13:40:43.000000000 -0800
@@ -63,7 +63,17 @@ error_out:
 	return bh;
 }
 
-void ext2_reserve_inode (struct super_block * sb, int group, int dir)
+/*
+ * Speculatively reserve an inode in a blockgroup which used to have some
+ * spare ones.  Later, when we come to actually claim the inode in the bitmap
+ * it may be that it was taken.  In that case the allocator will undo this
+ * reservation and try again.
+ *
+ * The inode allocator does not physically alter the superblock.  But we still
+ * set sb->s_dirt, because the superblock was "logically" altered - we need to
+ * go and add up the free inodes counts again and flush out the superblock.
+ */
+static void ext2_reserve_inode(struct super_block *sb, int group, int dir)
 {
 	struct ext2_group_desc * desc;
 	struct buffer_head *bh;
@@ -72,7 +82,7 @@ void ext2_reserve_inode (struct super_bl
 	if (!desc) {
 		ext2_error(sb, "ext2_reserve_inode",
 			"can't get descriptor for group %d", group);
-	return;
+		return;
 	}
 
 	spin_lock(&EXT2_SB(sb)->s_bgi[group].ialloc_lock);
@@ -82,11 +92,11 @@ void ext2_reserve_inode (struct super_bl
 		desc->bg_used_dirs_count =
 			cpu_to_le16(le16_to_cpu(desc->bg_used_dirs_count) + 1);
 	spin_unlock(&EXT2_SB(sb)->s_bgi[group].ialloc_lock);
-
+	sb->s_dirt = 1;
 	mark_buffer_dirty(bh);
 }
 
-void ext2_release_inode (struct super_block * sb, int group, int dir)
+static void ext2_release_inode(struct super_block *sb, int group, int dir)
 {
 	struct ext2_group_desc * desc;
 	struct buffer_head *bh;
@@ -105,7 +115,7 @@ void ext2_release_inode (struct super_bl
 		desc->bg_used_dirs_count =
 			cpu_to_le16(le16_to_cpu(desc->bg_used_dirs_count) - 1);
 	spin_unlock(&EXT2_SB(sb)->s_bgi[group].ialloc_lock);
-
+	sb->s_dirt = 1;
 	mark_buffer_dirty(bh);
 }
 

_


