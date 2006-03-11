Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbWCKQAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbWCKQAp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 11:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWCKQAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 11:00:45 -0500
Received: from mail.parknet.jp ([210.171.160.80]:27151 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1751189AbWCKQAp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 11:00:45 -0500
X-AuthUser: hirofumi@parknet.jp
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Fix a race condition between ->i_mapping and iput()
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 12 Mar 2006 01:00:22 +0900
Message-ID: <87hd65geeh.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This race became a cause of oops, and can reproduce by the following.

    while true; do
	dd if=/dev/zero of=/dev/.static/dev/hdg1 bs=512 count=1000 & sync
    done


This race condition was between __sync_single_inode() and iput().

          cpu0 (fs's inode)                 cpu1 (bdev's inode)
------------------------------------------------------------------------
                                       close("/dev/hda2")
                                       [...]
__sync_single_inode()
   /* copy the bdev's ->i_mapping */
   mapping = inode->i_mapping;

                                       generic_forget_inode()
                                          bdev_clear_inode()
					     /* restre the fs's ->i_mapping */
				             inode->i_mapping = &inode->i_data;
				          /* bdev's inode was freed */
                                          destroy_inode(inode);

   if (wait) {
      /* dereference a freed bdev's mapping->host */
      filemap_fdatawait(mapping);  /* Oops */

Since __sync_signle_inode() is only taking a ref-count of fs's inode,
the another process can be close() and freeing the bdev's inode while
writing fs's inode.  So, __sync_signle_inode() accesses the freed
->i_mapping, oops.

This patch takes ref-count of bdev's inode for fs's inode before
setting a ->i_mapping, and the clear_inode() of fs's inode does iput().
So, if fs's inode is still living, bdev's inode shouldn't be freed.

This lifetime rule may be a poor, but very simple.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/block_dev.c |   32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff -puN fs/block_dev.c~i_mapping-race-fix-2 fs/block_dev.c
--- linux-2.6/fs/block_dev.c~i_mapping-race-fix-2	2006-03-11 16:19:07.000000000 +0900
+++ linux-2.6-hirofumi/fs/block_dev.c	2006-03-11 17:52:11.000000000 +0900
@@ -418,21 +418,31 @@ EXPORT_SYMBOL(bdput);
 static struct block_device *bd_acquire(struct inode *inode)
 {
 	struct block_device *bdev;
+
 	spin_lock(&bdev_lock);
 	bdev = inode->i_bdev;
-	if (bdev && igrab(bdev->bd_inode)) {
+	if (bdev) {
+		atomic_inc(&bdev->bd_inode->i_count);
 		spin_unlock(&bdev_lock);
 		return bdev;
 	}
 	spin_unlock(&bdev_lock);
+
 	bdev = bdget(inode->i_rdev);
 	if (bdev) {
 		spin_lock(&bdev_lock);
-		if (inode->i_bdev)
-			__bd_forget(inode);
-		inode->i_bdev = bdev;
-		inode->i_mapping = bdev->bd_inode->i_mapping;
-		list_add(&inode->i_devices, &bdev->bd_inodes);
+		if (!inode->i_bdev) {
+			/*
+			 * We take an additional bd_inode->i_count for inode,
+			 * and it's released in clear_inode() of inode.
+			 * So, we can access it via ->i_mapping always
+			 * without igrab().
+			 */
+			atomic_inc(&bdev->bd_inode->i_count);
+			inode->i_bdev = bdev;
+			inode->i_mapping = bdev->bd_inode->i_mapping;
+			list_add(&inode->i_devices, &bdev->bd_inodes);
+		}
 		spin_unlock(&bdev_lock);
 	}
 	return bdev;
@@ -442,10 +452,18 @@ static struct block_device *bd_acquire(s
 
 void bd_forget(struct inode *inode)
 {
+	struct block_device *bdev = NULL;
+
 	spin_lock(&bdev_lock);
-	if (inode->i_bdev)
+	if (inode->i_bdev) {
+		if (inode->i_sb != blockdev_superblock)
+			bdev = inode->i_bdev;
 		__bd_forget(inode);
+	}
 	spin_unlock(&bdev_lock);
+
+	if (bdev)
+		iput(bdev->bd_inode);
 }
 
 int bd_claim(struct block_device *bdev, void *holder)
_
