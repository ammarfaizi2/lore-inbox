Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262154AbVCTLbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262154AbVCTLbU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 06:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262145AbVCTL3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 06:29:43 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:16141 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261729AbVCTL2T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 06:28:19 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: race between __sync_single_inode() and
 iput()/bdev_clear_inode()
References: <87zmwzzaem.fsf@devron.myhome.or.jp>
	<20050319223843.04b31ae5.akpm@osdl.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 20 Mar 2005 20:27:59 +0900
In-Reply-To: <20050319223843.04b31ae5.akpm@osdl.org> (Andrew Morton's
 message of "Sat, 19 Mar 2005 22:38:43 -0800")
Message-ID: <87acoyo8u8.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> The __sync_single_inode() caller takes a ref on the inode to prevent things
> like this from happening.

Yes. But, in this case, that inode->i_mapping is pointing the bdev's
->i_mapping by open("/dev/hda2").

   open("/dev/hda2") -> blkdev_open() -> bd_acquire()

   		inode->i_bdev = bdev;
		inode->i_mapping = bdev->bd_inode->i_mapping;
		list_add(&inode->i_devices, &bdev->bd_inodes);

In this race case, the inode is not freeing, but ->i_mapping is freed.

> What was the call path on the other process?  The one running
> destroy_inode()?  unmount?

close("/dev/hda2").

The _bdev's_ inode is freed by close() path after restoreing
the inode->i_mapping of filesytem in bdev_clear_inode().

   close("/dev/hda2")
     -> blkdev_close()
       -> [...]
         -> iput()
           -> generic_delete_inode()
             -> bdev_clear_inode()
               -> __bd_forget()

                   /* inode is filesystem's inode, not bdev. */
                   list_del_init(&inode->i_devices);
                   inode->i_bdev = NULL;
                   inode->i_mapping = &inode->i_data;

             -> destroy_inode()  <- is freeing the bdev's inode.

And __sync_single_inode() side is updating the inode->i_atime on filesystem.

>> +/* Called under inode_lock. */
>> +void wait_inode_ilock(struct inode *inode)
>> +{
>> +	wait_queue_head_t *wqh;
>> +	DEFINE_WAIT_BIT(wq, &inode->i_state, __I_LOCK);
>> +
>> +	if (!(inode->i_state & I_LOCK))
>> +		return;
>> +
>> +	wqh = bit_waitqueue(&inode->i_state, __I_LOCK);
>> +	do {
>> +		__iget(inode);
>> +		spin_unlock(&inode_lock);
>> +		__wait_on_bit(wqh, &wq, inode_wait, TASK_UNINTERRUPTIBLE);
>> +		iput(inode);
>> +		spin_lock(&inode_lock);
>> +	} while (inode->i_state & I_LOCK);
>> +}
>
> Does this differ from wait_on_inode()?

This checks I_LOCK after taking the inode_lock. So, caller can set the
I_LOCK after this.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
