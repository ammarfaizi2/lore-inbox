Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261801AbVGUPjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbVGUPjk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 11:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbVGUPjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 11:39:39 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:37613 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261801AbVGUPjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 11:39:31 -0400
Date: Thu, 21 Jul 2005 17:39:32 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [PATCH] Syncthreads support.
Message-ID: <20050721153932.GA2005@elf.ucw.cz>
References: <1121923564.2936.231.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121923564.2936.231.camel@localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch implements a new PF_SYNCTHREAD flag, which allows upcoming
> the refrigerator implementation to know that a thread is syncing data to
> disk. This allows the refrigerator to be more reliable, even under heavy
> load, because it can separate userspace processes that are submitting
> I/O from those trying to sync it and freezing the former first. We can
> thus ensure that syncing processes complete their work more quickly and
> the refrigerator is far less likely to incorrectly give up (thinking a
> syncing process is completely failing to enter the refrigerator).

This patch is ****, and pretty intrusive too. Ouch and then it is
unneccessary. We have been over this before, and explained to you in
person. Greg explained it to you, too. This one is NOT GOING IN. Drop
it from your patches, trying to submit it 10 times will not get it
accepted.

[For the record, simple solution for this one is 

sys_sync();

and only then start refrigeration].

								Pavel

[Patch left here for your amusement.]

> Signed-off by: Nigel Cunningham <nigel@suspend2.net>
> 
>  fs/buffer.c           |   45 +++++++++++++++++++++++++++++++++++++++++++--
>  include/linux/sched.h |    2 ++
>  2 files changed, 45 insertions(+), 2 deletions(-)
> diff -ruNp 410-syncthreads.patch-old/fs/buffer.c 410-syncthreads.patch-new/fs/buffer.c
> --- 410-syncthreads.patch-old/fs/buffer.c	2005-07-18 06:36:58.000000000 +1000
> +++ 410-syncthreads.patch-new/fs/buffer.c	2005-07-21 15:18:42.000000000 +1000
> @@ -171,6 +171,15 @@ EXPORT_SYMBOL(sync_blockdev);
>   */
>  int fsync_super(struct super_block *sb)
>  {
> +	int ret;
> +
> +	/* A safety net. During suspend, we might overwrite
> +	 * memory containing filesystem info. We don't then
> +	 * want to sync it to disk. */
> +	BUG_ON(test_suspend_state(SUSPEND_DISABLE_SYNCING));
> +	
> +	current->flags |= PF_SYNCTHREAD;
> +
>  	sync_inodes_sb(sb, 0);
>  	DQUOT_SYNC(sb);
>  	lock_super(sb);
> @@ -182,7 +191,10 @@ int fsync_super(struct super_block *sb)
>  	sync_blockdev(sb->s_bdev);
>  	sync_inodes_sb(sb, 1);
>  
> -	return sync_blockdev(sb->s_bdev);
> +	ret = sync_blockdev(sb->s_bdev);
> +
> +	current->flags &= ~PF_SYNCTHREAD;
> +	return ret;
>  }
>  
>  /*
> @@ -193,12 +205,21 @@ int fsync_super(struct super_block *sb)
>  int fsync_bdev(struct block_device *bdev)
>  {
>  	struct super_block *sb = get_super(bdev);
> +	int ret;
> +
> +	BUG_ON(test_suspend_state(SUSPEND_DISABLE_SYNCING));
> +
> +	current->flags |= PF_SYNCTHREAD;
> +
>  	if (sb) {
>  		int res = fsync_super(sb);
>  		drop_super(sb);
> +		current->flags &= ~PF_SYNCTHREAD;
>  		return res;
>  	}
> -	return sync_blockdev(bdev);
> +	ret = sync_blockdev(bdev);
> +	current->flags &= ~PF_SYNCTHREAD;
> +	return ret;
>  }
>  
>  /**
> @@ -278,6 +299,13 @@ EXPORT_SYMBOL(thaw_bdev);
>   */
>  static void do_sync(unsigned long wait)
>  {
> +	/* A safety net. During suspend, we might overwrite
> +	 * memory containing filesystem info. We don't then
> +	 * want to sync it to disk. */
> +	BUG_ON(test_suspend_state(SUSPEND_DISABLE_SYNCING));
> +
> +	current->flags |= PF_SYNCTHREAD;
> +
>  	wakeup_pdflush(0);
>  	sync_inodes(0);		/* All mappings, inodes and their blockdevs */
>  	DQUOT_SYNC(NULL);
> @@ -289,6 +317,8 @@ static void do_sync(unsigned long wait)
>  		printk("Emergency Sync complete\n");
>  	if (unlikely(laptop_mode))
>  		laptop_sync_completion();
> +
> +	current->flags &= ~PF_SYNCTHREAD;
>  }
>  
>  asmlinkage long sys_sync(void)
> @@ -314,6 +344,10 @@ int file_fsync(struct file *filp, struct
>  	struct super_block * sb;
>  	int ret, err;
>  
> +	BUG_ON(test_suspend_state(SUSPEND_DISABLE_SYNCING));
> +
> +	current->flags |= PF_SYNCTHREAD;
> +
>  	/* sync the inode to buffers */
>  	ret = write_inode_now(inode, 0);
>  
> @@ -328,6 +362,8 @@ int file_fsync(struct file *filp, struct
>  	err = sync_blockdev(sb->s_bdev);
>  	if (!ret)
>  		ret = err;
> +
> +	current->flags &= ~PF_SYNCTHREAD;
>  	return ret;
>  }
>  
> @@ -337,6 +373,10 @@ static long do_fsync(unsigned int fd, in
>  	struct address_space *mapping;
>  	int ret, err;
>  
> +	BUG_ON(test_suspend_state(SUSPEND_DISABLE_SYNCING));
> +
> +	current->flags |= PF_SYNCTHREAD;
> +
>  	ret = -EBADF;
>  	file = fget(fd);
>  	if (!file)
> @@ -370,6 +410,7 @@ static long do_fsync(unsigned int fd, in
>  out_putf:
>  	fput(file);
>  out:
> +	current->flags &= ~PF_SYNCTHREAD;
>  	return ret;
>  }
>  
> diff -ruNp 410-syncthreads.patch-old/include/linux/sched.h 410-syncthreads.patch-new/include/linux/sched.h
> --- 410-syncthreads.patch-old/include/linux/sched.h	2005-07-21 15:18:26.000000000 +1000
> +++ 410-syncthreads.patch-new/include/linux/sched.h	2005-07-21 15:18:42.000000000 +1000
> @@ -829,6 +829,8 @@ do { if (atomic_dec_and_test(&(tsk)->usa
>  #define PF_SYNCWRITE	0x00200000	/* I am doing a sync write */
>  #define PF_BORROWED_MM	0x00400000	/* I am a kthread doing use_mm */
>  #define PF_RANDOMIZE	0x00800000	/* randomize virtual address space */
> +#define PF_SYNCTHREAD	0x01000000	/* this thread can start activity during the 
> ++ 					   early part of freezing processes */
>  
>  /*
>   * Only the _current_ task can read/write to tsk->flags, but other
> 


-- 
teflon -- maybe it is a trademark, but it should not be.
