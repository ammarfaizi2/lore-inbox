Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136009AbREBWAt>; Wed, 2 May 2001 18:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136007AbREBWAj>; Wed, 2 May 2001 18:00:39 -0400
Received: from ftoomsh.progsoc.uts.edu.au ([138.25.6.1]:35848 "EHLO ftoomsh")
	by vger.kernel.org with ESMTP id <S135992AbREBWAW>;
	Wed, 2 May 2001 18:00:22 -0400
Date: Thu, 3 May 2001 07:59:53 +1000 (EST)
From: Shaun <delius@progsoc.uts.edu.au>
To: Jens Axboe <axboe@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Disk Performance Measurements
In-Reply-To: <20010502124445.J25336@suse.de>
Message-ID: <Pine.LNX.4.21.0105030750410.10591-100000@ftoomsh.progsoc.uts.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > In regards to diskr/wblk, drive_stat_acct() increments the number of
> > sectors/blocks read based n the values in the request being processed by
> > add_request(). But add_request() is only called for requests that can't be
> > merged with requests currently on the queue. Thus the counters can't be
> > updated for sectors that are read by being added to aqueued
> > request. Unless I'm mistaken this makes the diskr/wblk mostly useless.
> 
> Look again, drive_stat_acct is also called for list merges (just with 0
> set for new i/o of course).

Ok, this problem must has been fixed in later versions. In my 2.2.16
kernel:

[shaunc@ufs block]$ grep -irn "drive_stat_acct" ll_rw_blk.c
307:static inline void drive_stat_acct(int cmd, unsigned long nr_sectors,
318:            printk(KERN_ERR "drive_stat_acct: cmd not R/W?\n");
676: * which is important for drive_stat_acct() above.  */
715:            drive_stat_acct(req->cmd, req->nr_sectors, disk_index);
[shaunc@ufs block]$ grep -irn "dk_drive_rblk" ll_rw_blk.c
313:            kstat.dk_drive_rblk[disk_index] += nr_sectors;
 
> > record the _kilobytes_ read or written to the disks. His code adds
> > drive_pg_stat_acct(). This routine increments disk_pgin/out once for each
> > call to make_request(). Presumably he has assumed every call to
> > make_request will always be for 2 sectors/1 Kilobytes worth of
> > data. However I added printk() statements to try to verify this and found
> > that the request to the block device need not be 1024 bytes, I frequently
> > saw 4096 requests. In fact, the "correct_size" for the block device
> > appeared to be changeable from partition to partition on the same
> > disk. This "correct_size" appears to be related to the block size for the
> > filesystem on the partition/disk? Following from the above logic it would
> > appear that the pgin/pgout statistics are also useless since you don't
> > know how large the requests were?
> 
> The size of requests will typically vary with the block size set by
> ext2. So if you have 1kB block size on your fs, that partition will
> receive 1kB buffers. Similar for 4kB. The stats collected in the kernel
> are sector based, units of 512 bytes. The proc printed value should be
> in kB however for pgpin/out and 512b sectors for rio/rblk wio/wblk.

Again, this isn't the case in the 2.2.16 kernel I'm working with. Each
call to make_request() causes pgin/pgout to be incremented, since these
requests can be of different sizes (even for the same disk) I can't see
how a kb value can be deduced. 

Just as a question though, a disk/partition doesn't need to have a
filesystem on it, so why is the "correct_size" for a buffer request on the
block device defined based on a filesystem block system? 

Thanks,
Shaun
 

