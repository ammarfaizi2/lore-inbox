Return-Path: <linux-kernel-owner+w=401wt.eu-S932163AbXAPAiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbXAPAiS (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 19:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932158AbXAPAiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 19:38:18 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:15955 "EHLO virtualhost.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932163AbXAPAiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 19:38:17 -0500
Date: Tue, 16 Jan 2007 11:38:54 +1100
From: Jens Axboe <jens.axboe@oracle.com>
To: Ricardo Correia <rcorreia@wizy.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to flush the disk write cache from userspace
Message-ID: <20070116003854.GE4067@kernel.dk>
References: <200701140405.33748.rcorreia@wizy.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701140405.33748.rcorreia@wizy.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 14 2007, Ricardo Correia wrote:
> Hi, (please CC: to my email address, I'm not subscribed)
> 
> Quick question: how can I flush the disk write cache from userspace?
> 
> Long question:
> 
> I'm porting the Solaris ZFS filesystem to the FUSE/Linux filesystem
> framework.  This is a copy-on-write, transactional filesystem and so
> it needs to ensure correct ordering of writes when transactions are
> written to disk.
> 
> At the moment, when transactions end, I'm using a fsync() on the block
> device followed by a ioctl(BLKFLSBUF).
> 
> This is because, according to the fsync manpage, even after fsync()
> returns, data might still be in the disk write cache, so fsync by
> itself doesn't guarantee data safety on power failure.

Depends. Only if the file system does the right thing here, iirc only
reiserfs with barriers enabled issue a real disk flush for fsync. So you
can't rely on it in general.

> I was looking for something like the Solaris
> ioctl(DKIOCFLUSHWRITECACHE), which does exactly what I need.
> 
> The most similar thing I could find was ioctl(BLKFLSBUF), however a
> search for BLKFLSBUF on the Linux 2.6.15 source doesn't seem to return
> anything related to IDE or SCSI disks.
> 
> Can I trust ioctl(BLKFLSBUF) to flush disks' write caches (for disks
> that follow the specs)?

BLKFLSBUF doesn't flush the disk cache either, it just flushes
every dirty page in the block device address space. It would not be very
hard to do, basically we have most of the support code in place for this
for IO barriers. Basically it would be something like:

blockdev_cache_flush(bdev)
{
        request_queue_t *q = bdev_get_queue(bdev);
        struct request *rq = blk_get_request(q, WRITE, GFP_WHATEVER);
        int ret;

        ret = blk_execute_rq(q, bdev->bd_disk, rq, 0);
        blk_put_request(rq);
        return ret;
}

Somewhat simplified of course, but it should get the point across.
Putting that in fs/buffer.c:sync_blockdev() would make BLKFLSBUF work.

As always with these things, the devil is in the details. It requires
the device to support a ->prepare_flush() queue hook, and not all
devices do that. It will work for IDE/SATA/SCSI, though. In some devices
you don't want/need to do a real disk flush, it depends on the write
cache settings, battery backing, etc.

-- 
Jens Axboe

