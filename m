Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbVLYOXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbVLYOXR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 09:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbVLYOXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 09:23:17 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:45573 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S1750822AbVLYOXQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 09:23:16 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [EXPERIMENT] Add new "flush" option
References: <877j9ufeio.fsf@devron.myhome.or.jp>
	<20051225041900.38fdcba7.akpm@osdl.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 25 Dec 2005 23:23:06 +0900
In-Reply-To: <20051225041900.38fdcba7.akpm@osdl.org> (Andrew Morton's message of "Sun, 25 Dec 2005 04:19:00 -0800")
Message-ID: <878xu99rxx.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

>> +	if (bdi_write_congested(bdi)) {
>> +		mod_timer(&sb->flush_timer, jiffies + (HZ / 10));
>> +		return;
>> +	}
>
> The bdi_write_congested() test probably isn't doing anything useful: it
> only returns true if there's really heavy writeout in progress.  Possibly
> you could look at the disk queue accounting stats, work out how much I/O
> has been happening lately.

Umm... If queue is too busy, we can't flush immediately. So, this code
is delaying flush, and we can wait the more user's request by it, I think.

> However I wonder if all this code would become simpler if we were to just
> tweak writeback_inodes() a bit: if the superblock was mounted with MS_FLUSH
> then temporarily set wbc->sync_mode to WB_SYNC_ALL.
>
> If we do that, the regular wb_kupdate() will sync all the IS_FLUSH
> filesystems for us at dirty_writeback_centisecs intervals.  That's a bit
> less flexible, but probably less code.
>
> (Alternatively, add a new writeback_control.ms_flush_only boolean.  Set
> that, then reuse some of the code in mm/page-writeback.c in some manner).

Yes, but probably we need to change handling of bd_inode (sb->s_bdev).
The buffer_heads seems to be synced via block_super. And DQUOT_SYNC(sb)
may be needed.

I think it will need big change (and cleanup) after all. (That's no
problem itself I think, but, I would need to make more time)

> You abandoned the flush-file-in-release() idea?  That seemed faily neat. 
> What was the thinking here?

I'm still doing it in the following. I thought the other filesystems
may select other flushing strategy on ->release(), so I didn't do it in VFS.

diff -puN fs/fat/file.c~fat_flush-support fs/fat/file.c
--- linux-2.6/fs/fat/file.c~fat_flush-support	2005-12-25 04:58:16.000000000 +0900
+++ linux-2.6-hirofumi/fs/fat/file.c	2005-12-25 04:58:16.000000000 +0900
@@ -119,6 +119,7 @@ struct file_operations fat_file_operatio
 	.writev		= generic_file_writev,
 	.aio_read	= generic_file_aio_read,
 	.aio_write	= generic_file_aio_write,
+	.release	= fs_flush_sync_fdata,
 	.mmap		= generic_file_mmap,
 	.ioctl		= fat_generic_ioctl,
 	.fsync		= file_fsync,
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
