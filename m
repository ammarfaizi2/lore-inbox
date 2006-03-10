Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422675AbWCJBFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422675AbWCJBFr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 20:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422677AbWCJBFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 20:05:47 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:30894 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S1422675AbWCJBFq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 20:05:46 -0500
Message-ID: <4410D0F1.3030307@vilain.net>
Date: Fri, 10 Mar 2006 14:05:53 +1300
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Write the inode itself in block_fsync()
References: <87bqwfzixu.fsf@duaron.myhome.or.jp>
In-Reply-To: <87bqwfzixu.fsf@duaron.myhome.or.jp>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi wrote:

>Hi,
>
>For block device's inode, we don't write a inode's meta data
>itself. But, I think we should write inode's meta data for fsync().
>  
>

Ouch... won't that halve performance of database transaction logs?

>Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
>---
>
> fs/block_dev.c |   16 +++++++++++++++-
> 1 file changed, 15 insertions(+), 1 deletion(-)
>
>diff -puN fs/block_dev.c~block_fsync-write-inode fs/block_dev.c
>--- linux-2.6/fs/block_dev.c~block_fsync-write-inode	2006-03-05 21:51:15.000000000 +0900
>+++ linux-2.6-hirofumi/fs/block_dev.c	2006-03-05 22:28:28.000000000 +0900
>@@ -19,6 +19,7 @@
> #include <linux/module.h>
> #include <linux/blkpg.h>
> #include <linux/buffer_head.h>
>+#include <linux/writeback.h>
> #include <linux/mpage.h>
> #include <linux/mount.h>
> #include <linux/uio.h>
>@@ -232,7 +233,20 @@ static loff_t block_llseek(struct file *
>  
> static int block_fsync(struct file *filp, struct dentry *dentry, int datasync)
> {
>-	return sync_blockdev(I_BDEV(filp->f_mapping->host));
>+	struct inode *inode = dentry->d_inode;
>+	int ret = 0, err;
>+
>+	if (!datasync || (inode->i_state & I_DIRTY_DATASYNC)) {
>+		struct writeback_control wbc = {
>+			.sync_mode = WB_SYNC_ALL,
>+			.nr_to_write = 0,	/* sys_fsync did this */
>+		};
>+		ret = sync_inode(inode, &wbc);
>+	}
>+	err = sync_blockdev(I_BDEV(filp->f_mapping->host));
>+	if (!ret)
>+		ret = err;
>+	return err;
> }
> 
> /*
>_
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>

