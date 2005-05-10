Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261667AbVEJPB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbVEJPB3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 11:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbVEJPB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 11:01:28 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:22977 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261667AbVEJPAs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 11:00:48 -0400
Subject: [PATCH] sync_sb_inodes cleanup
From: Vladimir Saveliev <vs@namesys.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "reiserfs-dev@namesys.com" <reiserfs-dev@namesys.com>
Content-Type: multipart/mixed; boundary="=-OKJMEVgsoRoNGAILEDjB"
Message-Id: <1115737238.4456.320.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 10 May 2005 19:00:39 +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-OKJMEVgsoRoNGAILEDjB
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello

sync_sb_inodes is called twice and both times like:
spin_lock(&inode_lock);
sync_sb_inodes(sb, wbc);
spin_unlock(&inode_lock);

This patch makes generic_sync_sb_inodes to spin lock itself.
Please, apply this patch. It helps reiser4 to get rid of some oddities.

--=-OKJMEVgsoRoNGAILEDjB
Content-Disposition: attachment; filename=sync_sb_inodes-cleanup.patch
Content-Type: text/plain; name=sync_sb_inodes-cleanup.patch; charset=KOI8-R
Content-Transfer-Encoding: 7bit


sync_sb_inodes is always called like:
	spin_lock(&inode_lock);
	sync_sb_inodes(sb, wbc);
	spin_unlock(&inode_lock);
This patch moves spin_lock/spin_unlock down to sync_sb_inodes.


 fs/fs-writeback.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff -puN fs/fs-writeback.c~sync_sb_inodes-cleanup fs/fs-writeback.c
--- linux-2.6.12-rc3-mm3/fs/fs-writeback.c~sync_sb_inodes-cleanup	2005-05-10 18:41:30.822421511 +0400
+++ linux-2.6.12-rc3-mm3-vs/fs/fs-writeback.c	2005-05-10 18:45:07.907203826 +0400
@@ -283,8 +283,6 @@ __writeback_single_inode(struct inode *i
  * WB_SYNC_HOLD is a hack for sys_sync(): reattach the inode to sb->s_dirty so
  * that it can be located for waiting on in __writeback_single_inode().
  *
- * Called under inode_lock.
- *
  * If `bdi' is non-zero then we're being asked to writeback a specific queue.
  * This function assumes that the blockdev superblock's inodes are backed by
  * a variety of queues, so all inodes are searched.  For other superblocks,
@@ -305,6 +303,8 @@ generic_sync_sb_inodes(struct super_bloc
 {
 	const unsigned long start = jiffies;	/* livelock avoidance */
 
+	spin_lock(&inode_lock);
+
 	if (!wbc->for_kupdate || list_empty(&sb->s_io))
 		list_splice_init(&sb->s_dirty, &sb->s_io);
 
@@ -384,6 +384,7 @@ generic_sync_sb_inodes(struct super_bloc
 		if (wbc->nr_to_write <= 0)
 			break;
 	}
+	spin_unlock(&inode_lock);
 	return;		/* Leave any unwritten inodes on s_io */
 }
 EXPORT_SYMBOL(generic_sync_sb_inodes);
@@ -436,11 +437,8 @@ restart:
 			 * be unmounted by the time it is released.
 			 */
 			if (down_read_trylock(&sb->s_umount)) {
-				if (sb->s_root) {
-					spin_lock(&inode_lock);
+				if (sb->s_root)
 					sync_sb_inodes(sb, wbc);
-					spin_unlock(&inode_lock);
-				}
 				up_read(&sb->s_umount);
 			}
 			spin_lock(&sb_lock);
@@ -476,9 +474,7 @@ void sync_inodes_sb(struct super_block *
 			(inodes_stat.nr_inodes - inodes_stat.nr_unused) +
 			nr_dirty + nr_unstable;
 	wbc.nr_to_write += wbc.nr_to_write / 2;		/* Bit more for luck */
-	spin_lock(&inode_lock);
 	sync_sb_inodes(sb, &wbc);
-	spin_unlock(&inode_lock);
 }
 
 /*

_

--=-OKJMEVgsoRoNGAILEDjB--

