Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbWCJEaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWCJEaB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 23:30:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbWCJEaB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 23:30:01 -0500
Received: from smtp.osdl.org ([65.172.181.4]:63367 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751116AbWCJEaA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 23:30:00 -0500
Date: Thu, 9 Mar 2006 20:27:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix a race condition between ->i_mapping and iput()
Message-Id: <20060309202757.004a7f06.akpm@osdl.org>
In-Reply-To: <877j73ziwy.fsf@duaron.myhome.or.jp>
References: <877j73ziwy.fsf@duaron.myhome.or.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
>
> Hi,
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
> This lifetime rule may be a poor, but very simple.
> 
> Umm... should we use an another rule to free it more early?
> (e.g. if bdev's inode become I_FREEING, it should call bd_forget()
> before releasing the inode_lock. And some place should call
> igrab(->i_mapping->host->i_count) and iput())
> 
> 
> What do you think, comment?

Maybe.   This code seems relatively straightforward though.

It would be preferable to have a couple of comments in there explaining
what the new refcounting is there for.

>  
>...
>
>  void bd_forget(struct inode *inode)
>  {
> +	struct block_device *old = NULL;
> +
>  	spin_lock(&bdev_lock);
> -	if (inode->i_bdev)
> +	if (inode->i_bdev) {
> +		if (inode->i_sb != blockdev_superblock)
> +			old = inode->i_bdev;
>  		__bd_forget(inode);
> +	}
>  	spin_unlock(&bdev_lock);
> +
> +	if (old)
> +		iput(old->bd_inode);
>  }

We're missing an atomic_inc(i_count) here?
