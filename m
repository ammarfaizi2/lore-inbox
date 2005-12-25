Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbVLYMT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbVLYMT1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 07:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbVLYMT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 07:19:27 -0500
Received: from smtp.osdl.org ([65.172.181.4]:52957 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750768AbVLYMT0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 07:19:26 -0500
Date: Sun, 25 Dec 2005 04:19:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [EXPERIMENT] Add new "flush" option
Message-Id: <20051225041900.38fdcba7.akpm@osdl.org>
In-Reply-To: <877j9ufeio.fsf@devron.myhome.or.jp>
References: <877j9ufeio.fsf@devron.myhome.or.jp>
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.8.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
>
> This adds new "flush" option for hotplug devices.
> 
> Current implementation of "flush" option does,
> 
> 	- synchronizing data pages at ->release() (last close(2))
> 	- if user's work seems to be done (fs is not active), all
> 	  metadata syncs by pdflush()
> 
> This option would provide kind of sane progress, and dirty buffers is
> flushed more frequently (if fs is not active).  This option doesn't
> provide any robustness (robustness is provided by other options), but
> probably the option is proper for hotplug devices.
> 
> (Please don't assume that dirty buffers is synchronized at any point.
> This implementation will be changed easily.)
>
> ...
>
> +
> +#define FLUSH_INITAL_DELAY	HZ
> +#define FLUSH_DELAY		(HZ / 2)
> +
> +int fs_flush_sync_fdata(struct inode *inode, struct file *filp)
> +{
> +	int err = 0;
> +
> +	if (IS_FLUSH(inode) && filp->f_mode & FMODE_WRITE) {
> +		current->flags |= PF_SYNCWRITE;
> +		err = filemap_write_and_wait(inode->i_mapping);
> +		current->flags &= ~PF_SYNCWRITE;
> +	}
> +	return err;
> +}

You can use filp->f_mapping here, remove the inode* argument.

> +EXPORT_SYMBOL(fs_flush_sync_fdata);
> +
> +static void fs_flush_pdflush_handler(unsigned long arg)
> +{
> +	struct super_block *sb = (struct super_block *)arg;
> +	fsync_super(sb);
> +	up_read(&sb->s_umount);
> +}
> +
> +static void fs_flush_timer(unsigned long data)
> +{
> +	struct super_block *sb = (struct super_block *)data;
> +	struct backing_dev_info *bdi = blk_get_backing_dev_info(sb->s_bdev);
> +	unsigned long last_flush_jiff;
> +	int err;
> +
> +	if (bdi_write_congested(bdi)) {
> +		mod_timer(&sb->flush_timer, jiffies + (HZ / 10));
> +		return;
> +	}

The bdi_write_congested() test probably isn't doing anything useful: it
only returns true if there's really heavy writeout in progress.  Possibly
you could look at the disk queue accounting stats, work out how much I/O
has been happening lately.

> +	last_flush_jiff = sb->last_flush_jiff;
> +
> +	if (!time_after_eq(jiffies, last_flush_jiff + FLUSH_DELAY)) {
> +		mod_timer(&sb->flush_timer, last_flush_jiff + FLUSH_DELAY);
> +		return;
> +	}
> +
> +	if (down_read_trylock(&sb->s_umount)) {
> +		if (sb->s_root) {
> +			err = pdflush_operation(fs_flush_pdflush_handler, data);
> +			if (!err)
> +				return;
> +			mod_timer(&sb->flush_timer, jiffies + FLUSH_DELAY);
> +		}
> +		up_read(&sb->s_umount);
> +	}
> +}
>
> +void __fs_mark_flush(struct super_block *sb)
> +{
> +	sb->last_flush_jiff = jiffies;
> +	/*
> +	 * make sure by smb_wmb() that dirty buffers before here is
> +	 * processed at the timer routine.
> +	 */
> +	smp_wmb();
> +
> +	if (!timer_pending(&sb->flush_timer))
> +		mod_timer(&sb->flush_timer, jiffies + FLUSH_INITAL_DELAY);
> +}
> +EXPORT_SYMBOL(__fs_mark_flush);
> +
> +/*
> + * caller must take down_write(sb->s_umount), otherwise pdflush
> + * handler may be run after this del_timer_sync.
> + */
> +void fs_flush_stop(struct super_block *sb)
> +{
> +	sb->s_flags &= ~MS_FLUSH;
> +	del_timer_sync(&sb->flush_timer);
> +}
> +
> +void fs_flush_init(struct super_block *sb)
> +{
> +	init_timer(&sb->flush_timer);
> +	sb->flush_timer.data = (unsigned long)sb;
> +	sb->flush_timer.function = fs_flush_timer;
> +	sb->last_flush_jiff = 0;
> +}

The superblock lifetime handling all looks OK to me.


However I wonder if all this code would become simpler if we were to just
tweak writeback_inodes() a bit: if the superblock was mounted with MS_FLUSH
then temporarily set wbc->sync_mode to WB_SYNC_ALL.

If we do that, the regular wb_kupdate() will sync all the IS_FLUSH
filesystems for us at dirty_writeback_centisecs intervals.  That's a bit
less flexible, but probably less code.

(Alternatively, add a new writeback_control.ms_flush_only boolean.  Set
that, then reuse some of the code in mm/page-writeback.c in some manner).

You abandoned the flush-file-in-release() idea?  That seemed faily neat. 
What was the thinking here?

