Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964887AbWCPWqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbWCPWqw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 17:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964889AbWCPWqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 17:46:51 -0500
Received: from smtp.osdl.org ([65.172.181.4]:60362 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964887AbWCPWqu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 17:46:50 -0500
Date: Thu, 16 Mar 2006 14:49:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix a race condition between ->i_mapping and iput()
Message-Id: <20060316144906.3e646f7e.akpm@osdl.org>
In-Reply-To: <87hd65geeh.fsf@duaron.myhome.or.jp>
References: <87hd65geeh.fsf@duaron.myhome.or.jp>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
>
> This race became a cause of oops, and can reproduce by the following.
> 
>     while true; do
> 	dd if=/dev/zero of=/dev/.static/dev/hdg1 bs=512 count=1000 & sync
>     done
> 
> 
> This race condition was between __sync_single_inode() and iput().
> 
>           cpu0 (fs's inode)                 cpu1 (bdev's inode)
> ------------------------------------------------------------------------
>                                        close("/dev/hda2")
>                                        [...]
> __sync_single_inode()
>    /* copy the bdev's ->i_mapping */
>    mapping = inode->i_mapping;
> 
>                                        generic_forget_inode()
>                                           bdev_clear_inode()
> 					     /* restre the fs's ->i_mapping */
> 				             inode->i_mapping = &inode->i_data;
> 				          /* bdev's inode was freed */
>                                           destroy_inode(inode);
> 
>    if (wait) {
>       /* dereference a freed bdev's mapping->host */
>       filemap_fdatawait(mapping);  /* Oops */
> 
> Since __sync_signle_inode() is only taking a ref-count of fs's inode,
> the another process can be close() and freeing the bdev's inode while
> writing fs's inode.  So, __sync_signle_inode() accesses the freed
> ->i_mapping, oops.
> 
> This patch takes ref-count of bdev's inode for fs's inode before
> setting a ->i_mapping, and the clear_inode() of fs's inode does iput().
> So, if fs's inode is still living, bdev's inode shouldn't be freed.
> 

OK, so to rephrase:

Whenever /dev/sda's inode->i_mapping points at a kernel-internal blockdev
inode's i_data, we will hold a ref on that blockdev inode, to pin its
i_data.  That sounds sane.


> 
> diff -puN fs/block_dev.c~i_mapping-race-fix-2 fs/block_dev.c
> --- linux-2.6/fs/block_dev.c~i_mapping-race-fix-2	2006-03-11 16:19:07.000000000 +0900
> +++ linux-2.6-hirofumi/fs/block_dev.c	2006-03-11 17:52:11.000000000 +0900
> @@ -418,21 +418,31 @@ EXPORT_SYMBOL(bdput);
>  static struct block_device *bd_acquire(struct inode *inode)
>  {
>  	struct block_device *bdev;
> +
>  	spin_lock(&bdev_lock);
>  	bdev = inode->i_bdev;
> -	if (bdev && igrab(bdev->bd_inode)) {
> +	if (bdev) {
> +		atomic_inc(&bdev->bd_inode->i_count);

No longer checking (I_FREEING|I_WILL_FREE).  Why was this change included?

>  		spin_unlock(&bdev_lock);
>  		return bdev;
>  	}
>  	spin_unlock(&bdev_lock);
> +
>  	bdev = bdget(inode->i_rdev);
>  	if (bdev) {
>  		spin_lock(&bdev_lock);
> -		if (inode->i_bdev)
> -			__bd_forget(inode);
> -		inode->i_bdev = bdev;
> -		inode->i_mapping = bdev->bd_inode->i_mapping;
> -		list_add(&inode->i_devices, &bdev->bd_inodes);
> +		if (!inode->i_bdev) {
> +			/*
> +			 * We take an additional bd_inode->i_count for inode,
> +			 * and it's released in clear_inode() of inode.
> +			 * So, we can access it via ->i_mapping always
> +			 * without igrab().
> +			 */
> +			atomic_inc(&bdev->bd_inode->i_count);
> +			inode->i_bdev = bdev;
> +			inode->i_mapping = bdev->bd_inode->i_mapping;
> +			list_add(&inode->i_devices, &bdev->bd_inodes);
> +		}

And why this change?  The removal of the __bd_forget() and the changed
behaviour if (inode->i_bdev != NULL)?

