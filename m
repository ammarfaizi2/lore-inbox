Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262028AbVCTGkE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbVCTGkE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 01:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbVCTGjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 01:39:39 -0500
Received: from fire.osdl.org ([65.172.181.4]:8667 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262028AbVCTGjR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 01:39:17 -0500
Date: Sat, 19 Mar 2005 22:38:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: race between __sync_single_inode() and
 iput()/bdev_clear_inode()
Message-Id: <20050319223843.04b31ae5.akpm@osdl.org>
In-Reply-To: <87zmwzzaem.fsf@devron.myhome.or.jp>
References: <87zmwzzaem.fsf@devron.myhome.or.jp>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
>
> ...
> I got the above Oops while doing fs stress test.
> 
> The cause of this was race condition between __sync_single_inode() and
> iput()/bdev_clear_inode().
> 
> This race seems following condition.
> 
>           cpu0 (fs's inode)                 cpu1 (bdev's inode)
> ------------------------------------------------------------------------
>                                                close("/dev/hda2")
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

The __sync_single_inode() caller takes a ref on the inode to prevent things
like this from happening.

What was the call path on the other process?  The one running
destroy_inode()?  unmount?

> I wrote the attached patch for making sure fs's inode is not in
> __sync_single_inode().

It would be nicer to honour the extra inode ref in the unmount path, if
poss.  Only swizzle i_mapping when the inode is really not in use.

> +/* Called under inode_lock. */
> +void wait_inode_ilock(struct inode *inode)
> +{
> +	wait_queue_head_t *wqh;
> +	DEFINE_WAIT_BIT(wq, &inode->i_state, __I_LOCK);
> +
> +	if (!(inode->i_state & I_LOCK))
> +		return;
> +
> +	wqh = bit_waitqueue(&inode->i_state, __I_LOCK);
> +	do {
> +		__iget(inode);
> +		spin_unlock(&inode_lock);
> +		__wait_on_bit(wqh, &wq, inode_wait, TASK_UNINTERRUPTIBLE);
> +		iput(inode);
> +		spin_lock(&inode_lock);
> +	} while (inode->i_state & I_LOCK);
> +}

Does this differ from wait_on_inode()?

