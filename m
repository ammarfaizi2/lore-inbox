Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751318AbVJVHqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbVJVHqI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 03:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbVJVHqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 03:46:07 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:28680 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S1751318AbVJVHqG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 03:46:06 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [EXPERIMENT,RFC] FAT: Add "flush" option for hotplug devices
References: <871x2gf8f5.fsf@devron.myhome.or.jp>
	<20051020135014.2289fa01.akpm@osdl.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 22 Oct 2005 16:45:53 +0900
In-Reply-To: <20051020135014.2289fa01.akpm@osdl.org> (Andrew Morton's message of "Thu, 20 Oct 2005 13:50:14 -0700")
Message-ID: <87vezqc7v2.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
>
>> This option would provide kind of sane progress, and dirty buffers is
>> flushed more frequently (if fs is not active).
>
> Your implementation doesn't really do this.  bdi_write_congested() only
> returns true if the device is super-busy.  To determine whether it's "not
> active" we'd need to peek at the queue's disk_stat accounting, or at the
> queue's outstanding read/write requests.  We covered this a couple of weeks
> ago in the context of Con's swap prefetch work.

This doesn't check request queue to determine whether it's active,
instead of it, this is checking ->last_flush_jiff. (see below)

But active check based on request-queue may be good. I would need to compare...

>> +EXPORT_SYMBOL(filemap_write_and_wait);
>
> _GPL please.
>
>> +EXPORT_SYMBOL(fsync_super);
>
> Ditto

done.

Many filesystems seems to have copy of filemap_write_and_wait().

	filemap_fdatawrite(inode->i_mapping);
	filemap_fdatawait(inode->i_mapping);

Other filesystem developers also want to use this?

>> +int fat_sync_fdata(struct inode *inode, struct file *filp)
>> +{
>> +	int err = 0;
>> +
>> +	if (filp->f_mode & FMODE_WRITE) {
>> +#if 1
>> +		current->flags |= PF_SYNCWRITE;
>> +		err = filemap_write_and_wait(inode->i_mapping);
>> +		current->flags &= ~PF_SYNCWRITE;
>> +#else
>> +		down(&inode->i_sem);
>> +#if 1
>> +		err = generic_osync_inode(inode, inode->i_mapping, OSYNC_DATA);
>> +#else
>> +		err = filp->f_op->fsync(filp, filp->f_dentry, 1);
>> +#endif
>> +		up(&inode->i_sem);
>> +#endif
>> +	}
>> +	return err;
>> +}
>
> Can't we just split up do_fsync() a bit and use that?

This is calling only filemap_write_and_wait(). Sorry for dirty source.
Or are you saying we should do fdatasync(2) or fsync(2) here?

>> +static void fat_pdflush_handler(unsigned long arg)
>> +{
>> +	struct super_block *sb = (struct super_block *)arg;
>> +	fsync_super(sb);
>> +}
>
> It would be nice if /proc/sys/vm/dirty_writeback_centisecs was a per-fs
> thing.   That's non-trivial.

I agree.  And If using "flush" option, we need to bypass check of
->dirty_expire_centisecs, and need to flush sb and s_bdev.

>> +	last_flush_jiff = sbi->last_flush_jiff;
>> +
>> +	if (!time_after_eq(jiffies, last_flush_jiff + (HZ / 2))) {
>> +		mod_timer(&sbi->flush_timer, last_flush_jiff + (HZ / 2));
>> +		return;
>> +	}
>
> What's the above doing?

This checks whether fs is active.

The ->last_flush_jiff is updated by fat_mark_flush(), and if need, it
starts the timer.  And timer handler checks whether latest
fat_mark_flush() is enough old.  If ->last_flush_jif is not enough old
(fs is active), it's delaying to flush by adding the additional time.

But request-queue base may be more simple.

>> +EXPORT_SYMBOL(__fat_mark_flush);
>
> _GPL?

Ah, yes. I'll change all fat's EXPORT_SYMBOL to _GPL.

>> +void fat_flush_stop(struct super_block *sb)
>> +{
>> +	del_timer_sync(&MSDOS_SB(sb)->flush_timer);
>> +}
>
> whoops, the pdflush_operation could still be in progress.
>
> To avoid umount races I think the pdflush callback is going to need to take
> sb_lock, increment s_count, take ->s_umount, test ->s_root.  Like, for
> example, __sync_inodes.

Ugh, I'm idiot. I'll fix.

>> +void fat_flush_init(struct super_block *sb)
>> +{
>> +	struct msdos_sb_info *sbi = MSDOS_SB(sb);
>> +	init_timer(&sbi->flush_timer);
>> +	sbi->flush_timer.data = (unsigned long)sb;
>> +	sbi->flush_timer.function = fat_flush_timer;
>
> -mm has setup_timer()

OK. I'll make patch for -mm.

>> +static inline void fat_mark_flush(struct super_block *sb)
>> +{
>> +	if (MSDOS_SB(sb)->options.flush)
>> +		__fat_mark_flush(sb);
>> +}
>
> It'd be nice to make this a more generic thing, so other filesystems can
> use it without copying lots of code.
>
>> +		case Opt_flush:
>
> MS_FLUSH?   I added MS_DIRSYNC a few years ago - it wasn't too complex.

I'll add MS_FLUSH.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
