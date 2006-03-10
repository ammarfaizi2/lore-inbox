Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751316AbWCJPbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbWCJPbG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 10:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWCJPbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 10:31:05 -0500
Received: from mail.parknet.jp ([210.171.160.80]:2319 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1751316AbWCJPbE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 10:31:04 -0500
X-AuthUser: hirofumi@parknet.jp
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix a race condition between ->i_mapping and iput()
References: <877j73ziwy.fsf@duaron.myhome.or.jp>
	<20060309202757.004a7f06.akpm@osdl.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 11 Mar 2006 00:30:53 +0900
In-Reply-To: <20060309202757.004a7f06.akpm@osdl.org> (Andrew Morton's message of "Thu, 9 Mar 2006 20:27:57 -0800")
Message-ID: <871wxas4eq.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

>>  void bd_forget(struct inode *inode)
>>  {
>> +	struct block_device *old = NULL;
>> +
>>  	spin_lock(&bdev_lock);
>> -	if (inode->i_bdev)
>> +	if (inode->i_bdev) {
>> +		if (inode->i_sb != blockdev_superblock)
>> +			old = inode->i_bdev;
>>  		__bd_forget(inode);
>> +	}
>>  	spin_unlock(&bdev_lock);
>> +
>> +	if (old)
>> +		iput(old->bd_inode);
>>  }
>
> We're missing an atomic_inc(i_count) here?

I think we don't need an atomic_inc(i_count) here. The inode of
argument has already I_FREEING, so we just call iput(bdev's inode).

But, sorry. My patch seems broken.

With that simple rule, the code became more simple. And comment was
added.

I'll test a following patch today.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

diff -puN fs/block_dev.c~i_mapping-race-fix-2 fs/block_dev.c
--- linux-2.6/fs/block_dev.c~i_mapping-race-fix-2	2006-03-10 22:54:09.000000000 +0900
+++ linux-2.6-hirofumi/fs/block_dev.c	2006-03-10 23:05:03.000000000 +0900
@@ -432,21 +432,32 @@ EXPORT_SYMBOL(bdput);
 static struct block_device *bd_acquire(struct inode *inode)
 {
 	struct block_device *bdev;
+
+	BUG_ON(inode->i_sb == blockdev_superblock);
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
@@ -456,10 +467,18 @@ static struct block_device *bd_acquire(s
 
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
