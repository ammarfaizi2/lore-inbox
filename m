Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932660AbWCIQXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932660AbWCIQXa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 11:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932648AbWCIQX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 11:23:29 -0500
Received: from mail.parknet.jp ([210.171.160.80]:25614 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S932659AbWCIQX2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 11:23:28 -0500
X-AuthUser: hirofumi@parknet.jp
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix a race condition between ->i_mapping and iput()
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 10 Mar 2006 01:23:25 +0900
Message-ID: <877j73ziwy.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

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

Umm... should we use an another rule to free it more early?
(e.g. if bdev's inode become I_FREEING, it should call bd_forget()
before releasing the inode_lock. And some place should call
igrab(->i_mapping->host->i_count) and iput())


What do you think, comment?

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/block_dev.c |   21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff -puN fs/block_dev.c~i_mapping-race-fix-2 fs/block_dev.c
--- linux-2.6/fs/block_dev.c~i_mapping-race-fix-2	2006-03-09 03:08:54.000000000 +0900
+++ linux-2.6-hirofumi/fs/block_dev.c	2006-03-09 03:08:54.000000000 +0900
@@ -441,13 +441,22 @@ static struct block_device *bd_acquire(s
 	spin_unlock(&bdev_lock);
 	bdev = bdget(inode->i_rdev);
 	if (bdev) {
+		struct block_device *old = NULL;
+
+		BUG_ON(inode->i_sb == blockdev_superblock);
 		spin_lock(&bdev_lock);
-		if (inode->i_bdev)
+		if (inode->i_bdev) {
+			old = inode->i_bdev;
 			__bd_forget(inode);
+		}
+		atomic_inc(&bdev->bd_inode->i_count);
 		inode->i_bdev = bdev;
 		inode->i_mapping = bdev->bd_inode->i_mapping;
 		list_add(&inode->i_devices, &bdev->bd_inodes);
 		spin_unlock(&bdev_lock);
+
+		if (old)
+			iput(old->bd_inode);
 	}
 	return bdev;
 }
@@ -456,10 +465,18 @@ static struct block_device *bd_acquire(s
 
 void bd_forget(struct inode *inode)
 {
+	struct block_device *old = NULL;
+
 	spin_lock(&bdev_lock);
-	if (inode->i_bdev)
+	if (inode->i_bdev) {
+		if (inode->i_sb != blockdev_superblock)
+			old = inode->i_bdev;
 		__bd_forget(inode);
+	}
 	spin_unlock(&bdev_lock);
+
+	if (old)
+		iput(old->bd_inode);
 }
 
 int bd_claim(struct block_device *bdev, void *holder)
_
