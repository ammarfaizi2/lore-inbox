Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422637AbWCIQW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422637AbWCIQW6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 11:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422636AbWCIQW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 11:22:58 -0500
Received: from mail.parknet.jp ([210.171.160.80]:25358 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1422637AbWCIQW4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 11:22:56 -0500
X-AuthUser: hirofumi@parknet.jp
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Write the inode itself in block_fsync()
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 10 Mar 2006 01:22:53 +0900
Message-ID: <87bqwfzixu.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

For block device's inode, we don't write a inode's meta data
itself. But, I think we should write inode's meta data for fsync().

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/block_dev.c |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff -puN fs/block_dev.c~block_fsync-write-inode fs/block_dev.c
--- linux-2.6/fs/block_dev.c~block_fsync-write-inode	2006-03-05 21:51:15.000000000 +0900
+++ linux-2.6-hirofumi/fs/block_dev.c	2006-03-05 22:28:28.000000000 +0900
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/blkpg.h>
 #include <linux/buffer_head.h>
+#include <linux/writeback.h>
 #include <linux/mpage.h>
 #include <linux/mount.h>
 #include <linux/uio.h>
@@ -232,7 +233,20 @@ static loff_t block_llseek(struct file *
  
 static int block_fsync(struct file *filp, struct dentry *dentry, int datasync)
 {
-	return sync_blockdev(I_BDEV(filp->f_mapping->host));
+	struct inode *inode = dentry->d_inode;
+	int ret = 0, err;
+
+	if (!datasync || (inode->i_state & I_DIRTY_DATASYNC)) {
+		struct writeback_control wbc = {
+			.sync_mode = WB_SYNC_ALL,
+			.nr_to_write = 0,	/* sys_fsync did this */
+		};
+		ret = sync_inode(inode, &wbc);
+	}
+	err = sync_blockdev(I_BDEV(filp->f_mapping->host));
+	if (!ret)
+		ret = err;
+	return err;
 }
 
 /*
_
