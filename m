Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932510AbVJTUuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510AbVJTUuz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 16:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932532AbVJTUuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 16:50:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6291 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932510AbVJTUuy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 16:50:54 -0400
Date: Thu, 20 Oct 2005 13:50:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [EXPERIMENT,RFC] FAT: Add "flush" option for hotplug devices
Message-Id: <20051020135014.2289fa01.akpm@osdl.org>
In-Reply-To: <871x2gf8f5.fsf@devron.myhome.or.jp>
References: <871x2gf8f5.fsf@devron.myhome.or.jp>
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
> This adds new "flush" option on experiment for hotplug devices.
> 
> Current implementation of "flush" option does,
> 
> 	- synchronizing data pages at ->release() (last close(2))
> 	- if user's work seems to be done (fs is not active), all
> 	  metadata syncs by pdflush()

Seems like a sensible thing to do.

> This option would provide kind of sane progress, and dirty buffers is
> flushed more frequently (if fs is not active).

Your implementation doesn't really do this.  bdi_write_congested() only
returns true if the device is super-busy.  To determine whether it's "not
active" we'd need to peek at the queue's disk_stat accounting, or at the
queue's outstanding read/write requests.  We covered this a couple of weeks
ago in the context of Con's swap prefetch work.

>  This option doesn't
> provide any robustness (robustness is provided by other options), but
> probably the option is proper for hotplug devices.

Well...  It does a full fsync_super() - that's pretty robust.

> +EXPORT_SYMBOL(filemap_write_and_wait);

_GPL please.

> +EXPORT_SYMBOL(fsync_super);

Ditto

> +/*
> + * Copyright (C) 2005, OGAWA Hirofumi
> + * Released under GPL v2.
> + */
> +
> +#include <linux/fs.h>
> +#include <linux/blkdev.h>
> +#include <linux/writeback.h>
> +#include <linux/msdos_fs.h>
> +
> +int fat_sync_fdata(struct inode *inode, struct file *filp)
> +{
> +	int err = 0;
> +
> +	if (filp->f_mode & FMODE_WRITE) {
> +#if 1
> +		current->flags |= PF_SYNCWRITE;
> +		err = filemap_write_and_wait(inode->i_mapping);
> +		current->flags &= ~PF_SYNCWRITE;
> +#else
> +		down(&inode->i_sem);
> +#if 1
> +		err = generic_osync_inode(inode, inode->i_mapping, OSYNC_DATA);
> +#else
> +		err = filp->f_op->fsync(filp, filp->f_dentry, 1);
> +#endif
> +		up(&inode->i_sem);
> +#endif
> +	}
> +	return err;
> +}

Can't we just split up do_fsync() a bit and use that?

> +static void fat_pdflush_handler(unsigned long arg)
> +{
> +	struct super_block *sb = (struct super_block *)arg;
> +	fsync_super(sb);
> +}

It would be nice if /proc/sys/vm/dirty_writeback_centisecs was a per-fs
thing.   That's non-trivial.

> +static void fat_flush_timer(unsigned long data)
> +{
> +	struct super_block *sb = (struct super_block *)data;
> +	struct msdos_sb_info *sbi = MSDOS_SB(sb);
> +	struct backing_dev_info *bdi = blk_get_backing_dev_info(sb->s_bdev);
> +	unsigned long last_flush_jiff;
> +
> +	if (bdi_write_congested(bdi)) {

As indicated above, this won't be very effective.

> +		mod_timer(&sbi->flush_timer, jiffies + (HZ / 10));
> +		return;
> +	}
> +
> +	last_flush_jiff = sbi->last_flush_jiff;
> +
> +	if (!time_after_eq(jiffies, last_flush_jiff + (HZ / 2))) {
> +		mod_timer(&sbi->flush_timer, last_flush_jiff + (HZ / 2));
> +		return;
> +	}

What's the above doing?

> +	if (pdflush_operation(fat_pdflush_handler, (unsigned long)sb) < 0)
> +		mod_timer(&sbi->flush_timer, jiffies + HZ);
> +}
> +
> +void __fat_mark_flush(struct super_block *sb)
> +{
> +	struct msdos_sb_info *sbi = MSDOS_SB(sb);
> +
> +	sbi->last_flush_jiff = jiffies;
> +	/*
> +	 * make sure by smb_wmb() that dirty buffers before here is
> +	 * processed at the timer routine.
> +	 */
> +	smp_wmb();
> +
> +	if (!timer_pending(&sbi->flush_timer))
> +		mod_timer(&sbi->flush_timer, jiffies + HZ);
> +}
> +EXPORT_SYMBOL(__fat_mark_flush);

_GPL?

> +void fat_flush_stop(struct super_block *sb)
> +{
> +	del_timer_sync(&MSDOS_SB(sb)->flush_timer);
> +}

whoops, the pdflush_operation could still be in progress.

To avoid umount races I think the pdflush callback is going to need to take
sb_lock, increment s_count, take ->s_umount, test ->s_root.  Like, for
example, __sync_inodes.

> +void fat_flush_init(struct super_block *sb)
> +{
> +	struct msdos_sb_info *sbi = MSDOS_SB(sb);
> +	init_timer(&sbi->flush_timer);
> +	sbi->flush_timer.data = (unsigned long)sb;
> +	sbi->flush_timer.function = fat_flush_timer;

-mm has setup_timer()

> +
> +static inline void fat_mark_flush(struct super_block *sb)
> +{
> +	if (MSDOS_SB(sb)->options.flush)
> +		__fat_mark_flush(sb);
> +}

It'd be nice to make this a more generic thing, so other filesystems can
use it without copying lots of code.

> +		case Opt_flush:

MS_FLUSH?   I added MS_DIRSYNC a few years ago - it wasn't too complex.


