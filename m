Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbUCLJce (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 04:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbUCLJce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 04:32:34 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:36112 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262050AbUCLJbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 04:31:49 -0500
Date: Fri, 12 Mar 2004 09:31:46 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Chris Mason <mason@suse.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lockfs patch for 2.6
Message-ID: <20040312093146.A13678@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org
References: <1078867885.25075.1458.camel@watt.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1078867885.25075.1458.camel@watt.suse.com>; from mason@suse.com on Tue, Mar 09, 2004 at 04:31:25PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2004 at 04:31:25PM -0500, Chris Mason wrote:
>  /*
> + * triggered by the device mapper code to lock a filesystem and force
> + * it into a consistent state.
> + *
> + * This takes the block device bd_mount_sem to make sure no new mounts
> + * happen on bdev until unlockfs is called.  If a super is found on this
> + * block device, we hould a read lock on the s->s_umount sem to make sure
> + * nobody unmounts until the snapshot creation is done
> + */
> +void sync_super_lockfs(struct block_device *bdev) 
> +{
> +	struct super_block *sb;
> +	down(&bdev->bd_mount_sem);
> +	sb = get_super(bdev);
> +	if (sb) {
> +		lock_super(sb);
> +		if (sb->s_dirt && sb->s_op->write_super)
> +			sb->s_op->write_super(sb);
> +		if (sb->s_op->write_super_lockfs)
> +			sb->s_op->write_super_lockfs(sb);

Can we please rename write_super_lockfs to a sane name?

freeze_fs/thaw_fs sounds like a good name.

> +void unlockfs(struct block_device *bdev)
> +{
> +	struct list_head *p;
> +	/*
> +	 * copied from get_super, but we need to
> +	 * do special things since lockfs left the
> +	 * s_umount sem held
> +	 */
> +	spin_lock(&sb_lock);
> +	list_for_each(p, &super_blocks) {
> +		struct super_block *s = sb_entry(p);
> +		/*
> +		 * if there is a super for this block device
> +		 * in the list, get_super must have found it
> +		 * during sync_super_lockfs, so our drop_super
> +		 * will drop the reference created there.
> +		 */
> +		if (s->s_bdev == bdev && s->s_root) {
> +			spin_unlock(&sb_lock);
> +			if (s->s_op->unlockfs)
> +				s->s_op->unlockfs(s);
> +			drop_super(s);
> +			goto unlock;
> +		}
> +	}
> +	spin_unlock(&sb_lock);
> +unlock:
> +	up(&bdev->bd_mount_sem);
> +}
> +EXPORT_SYMBOL(unlockfs);

This looks ugly.  What about returning the superblock from the freeze
routine so you can simply pass it into the thaw routine?

> ===================================================================
> --- linux.dm.orig/fs/buffer.c	2004-02-27 15:47:36.139106189 -0500
> +++ linux.dm/fs/buffer.c	2004-02-27 15:48:41.516739161 -0500
> @@ -260,6 +260,17 @@
>  	return sync_blockdev(bdev);
>  }
>  
> +int fsync_bdev_lockfs(struct block_device *bdev)
> +{
> +	int res;
> +	res = fsync_bdev(bdev);
> +	if (res)
> +		return res;
> +	sync_super_lockfs(bdev);
> +	return sync_blockdev(bdev);
> +}
> +EXPORT_SYMBOL(fsync_bdev_lockfs);

This looks grossly misnamed again.  And why do you need to have
sync_super_locks splitted out?  Calling it on it's own doesn't make much
sense.

> --- linux.dm.orig/include/linux/buffer_head.h	2004-02-05 16:56:30.000000000 -0500
> +++ linux.dm/include/linux/buffer_head.h	2004-02-27 15:48:41.530734995 -0500
> @@ -164,6 +164,8 @@
>  wait_queue_head_t *bh_waitq_head(struct buffer_head *bh);
>  void wake_up_buffer(struct buffer_head *bh);
>  int fsync_bdev(struct block_device *);
> +int fsync_bdev_lockfs(struct block_device *);
> +void unlockfs(struct block_device *);

Again rather misplaced.  Even a fs not using bufferheads at all would
benefit from the interface.

