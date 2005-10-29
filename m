Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbVJ2ImV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbVJ2ImV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 04:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbVJ2ImV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 04:42:21 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:51473 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S1750769AbVJ2ImU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 04:42:20 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix !mapping_cap_writeback_dirty(inode->i_mapping)
References: <43288A84.2090107@sm.sony.co.jp>
	<87oe6uwjy7.fsf@devron.myhome.or.jp> <433C25D9.9090602@sm.sony.co.jp>
	<20051011142608.6ff3ca58.akpm@osdl.org>
	<87r7armlgz.fsf@ibmpc.myhome.or.jp>
	<20051011211601.72a0f91c.akpm@osdl.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 29 Oct 2005 17:42:09 +0900
In-Reply-To: <20051011211601.72a0f91c.akpm@osdl.org> (Andrew Morton's message of "Tue, 11 Oct 2005 21:16:01 -0700")
Message-ID: <87vezgd89q.fsf_-_@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Isn't write_inode_now() buggy?  If !mapping_cap_writeback_dirty() we
> should still write the inode itself?
>
> diff -puN fs/fs-writeback.c~write_inode_now-write-inode-if-not-bdi_cap_no_writeback fs/fs-writeback.c
> --- devel/fs/fs-writeback.c~write_inode_now-write-inode-if-not-bdi_cap_no_writeback	2005-10-11 21:13:25.000000000 -0700
> +++ devel-akpm/fs/fs-writeback.c	2005-10-11 21:13:40.000000000 -0700
> @@ -558,7 +558,7 @@ int write_inode_now(struct inode *inode,
>  	};
>  
>  	if (!mapping_cap_writeback_dirty(inode->i_mapping))
> -		return 0;
> +		wbc.nr_to_write = 0;
>  
>  	might_sleep();
>  	spin_lock(&inode_lock);

You are right, and I was wrong.

Yes, if block device has BDI_CAP_NO_WRITEBACK and inode->i_mapping
was changing to bd_inode->i_mapping,
the !mapping_cap_writeback_dirty(inode->i_mapping) is true, so we need
to write the inode itself of block special file.

I think we need to fix sync_sb_inodes() too. What do you think?

Since wbc.nr_to_write includes the information on how many pages were
written, we can't change wbc.nr_to_write in sync_sb_inodes().

This patch fixed the following case,

	# mke2fs -m0 -F file
	# mount -t ext2 file mnt -o loop
	# cd mnt
	# mknod ram b 1 0
	# cat ram
	# cd ..
	# umount mnt
	# e2fsck -f file
           "mnt/ram" wasn't flushed and it was corrupted

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>



Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fs-writeback.c |   34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff -puN fs/fs-writeback.c~device-inode-write-fix fs/fs-writeback.c
--- linux-2.6.14/fs/fs-writeback.c~device-inode-write-fix	2005-10-29 08:06:28.000000000 +0900
+++ linux-2.6.14-hirofumi/fs/fs-writeback.c	2005-10-29 08:06:28.000000000 +0900
@@ -151,7 +151,8 @@ static int write_inode(struct inode *ino
  * Called under inode_lock.
  */
 static int
-__sync_single_inode(struct inode *inode, struct writeback_control *wbc)
+__sync_single_inode(struct inode *inode, struct writeback_control *wbc,
+		    int inode_only)
 {
 	unsigned dirty;
 	struct address_space *mapping = inode->i_mapping;
@@ -168,7 +169,9 @@ __sync_single_inode(struct inode *inode,
 
 	spin_unlock(&inode_lock);
 
-	ret = do_writepages(mapping, wbc);
+	ret = 0;
+	if (!inode_only)
+		ret = do_writepages(mapping, wbc);
 
 	/* Don't write the inode if only I_DIRTY_PAGES was set */
 	if (dirty & (I_DIRTY_SYNC | I_DIRTY_DATASYNC)) {
@@ -177,7 +180,7 @@ __sync_single_inode(struct inode *inode,
 			ret = err;
 	}
 
-	if (wait) {
+	if (!inode_only && wait) {
 		int err = filemap_fdatawait(mapping);
 		if (ret == 0)
 			ret = err;
@@ -242,7 +245,7 @@ __sync_single_inode(struct inode *inode,
  */
 static int
 __writeback_single_inode(struct inode *inode,
-			struct writeback_control *wbc)
+			 struct writeback_control *wbc, int inode_only)
 {
 	wait_queue_head_t *wqh;
 
@@ -267,7 +270,7 @@ __writeback_single_inode(struct inode *i
 			spin_lock(&inode_lock);
 		} while (inode->i_state & I_LOCK);
 	}
-	return __sync_single_inode(inode, wbc);
+	return __sync_single_inode(inode, wbc, inode_only);
 }
 
 /*
@@ -304,6 +307,7 @@ static void
 sync_sb_inodes(struct super_block *sb, struct writeback_control *wbc)
 {
 	const unsigned long start = jiffies;	/* livelock avoidance */
+	int inode_only;
 
 	if (!wbc->for_kupdate || list_empty(&sb->s_io))
 		list_splice_init(&sb->s_dirty, &sb->s_io);
@@ -315,7 +319,8 @@ sync_sb_inodes(struct super_block *sb, s
 		struct backing_dev_info *bdi = mapping->backing_dev_info;
 		long pages_skipped;
 
-		if (!bdi_cap_writeback_dirty(bdi)) {
+		inode_only = 0;
+		if (!mapping_cap_writeback_dirty(mapping)) {
 			list_move(&inode->i_list, &sb->s_dirty);
 			if (sb == blockdev_superblock) {
 				/*
@@ -324,12 +329,7 @@ sync_sb_inodes(struct super_block *sb, s
 				 */
 				continue;
 			}
-			/*
-			 * Dirty memory-backed inode against a filesystem other
-			 * than the kernel-internal bdev filesystem.  Skip the
-			 * entire superblock.
-			 */
-			break;
+			inode_only = 1;
 		}
 
 		if (wbc->nonblocking && bdi_write_congested(bdi)) {
@@ -363,7 +363,7 @@ sync_sb_inodes(struct super_block *sb, s
 		BUG_ON(inode->i_state & I_FREEING);
 		__iget(inode);
 		pages_skipped = wbc->pages_skipped;
-		__writeback_single_inode(inode, wbc);
+		__writeback_single_inode(inode, wbc, inode_only);
 		if (wbc->sync_mode == WB_SYNC_HOLD) {
 			inode->dirtied_when = jiffies;
 			list_move(&inode->i_list, &sb->s_dirty);
@@ -551,18 +551,18 @@ void sync_inodes(int wait)
  
 int write_inode_now(struct inode *inode, int sync)
 {
-	int ret;
 	struct writeback_control wbc = {
 		.nr_to_write = LONG_MAX,
 		.sync_mode = WB_SYNC_ALL,
 	};
+	int ret, inode_only = 0;
 
 	if (!mapping_cap_writeback_dirty(inode->i_mapping))
-		return 0;
+		inode_only = 1;
 
 	might_sleep();
 	spin_lock(&inode_lock);
-	ret = __writeback_single_inode(inode, &wbc);
+	ret = __writeback_single_inode(inode, &wbc, inode_only);
 	spin_unlock(&inode_lock);
 	if (sync)
 		wait_on_inode(inode);
@@ -586,7 +586,7 @@ int sync_inode(struct inode *inode, stru
 	int ret;
 
 	spin_lock(&inode_lock);
-	ret = __writeback_single_inode(inode, wbc);
+	ret = __writeback_single_inode(inode, wbc, 0);
 	spin_unlock(&inode_lock);
 	return ret;
 }
_
