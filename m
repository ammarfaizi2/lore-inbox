Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135974AbREBGcc>; Wed, 2 May 2001 02:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135975AbREBGcX>; Wed, 2 May 2001 02:32:23 -0400
Received: from ftoomsh.progsoc.uts.edu.au ([138.25.6.1]:58384 "EHLO ftoomsh")
	by vger.kernel.org with ESMTP id <S135974AbREBGcF>;
	Wed, 2 May 2001 02:32:05 -0400
Date: Wed, 2 May 2001 16:31:42 +1000 (EST)
From: Shaun <delius@progsoc.uts.edu.au>
To: linux-kernel@vger.kernel.org
Subject: Disk Performance Measurements
Message-ID: <Pine.LNX.4.21.0105021528170.10591-100000@ftoomsh.progsoc.uts.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,

I've now been battling for several days with the kernel performance stats
for disks and have come to the conclusion I need some assistance from
someone with a little more understanding of the block device support in
the kernel (and the kernel in general).

Initially I've been looking at the relevance of the statistics in the
/proc/stat file (this is on a 2.2.16 kernel). My understanding of these
figures is as follows:
	- There are seven different statistics kept for each of the first
4 IDE disks
	- The relevant fields are disk, disk_rio, disk_rblk, disk_wblk,
disk_pgin, disk_pgout. The columns following the labels represent hda,
hdb, hdc and hdd respectively.
	- disk = disk_rio + disk_wio - the total number of ios issued to
the device
	- disk_rio - the total number of read ios issued to the device
	- disk_wio - the total number of write ios issed to the device
	- disk_rblk - The total number of blocks read from the device
	- disk_wblk - the total number of blocks written to the device
	- disk_pgin - The total number of buffer reads fulfilled
	- disk_pgout - the total number of buffer writes fulfilled

These statistics are maintained by code in devices/block/ll_rw_blk.c. My
problem is that both disk_r/wblk and disk_pgin/out appear to be incorrect. 

In regards to diskr/wblk, drive_stat_acct() increments the number of
sectors/blocks read based n the values in the request being processed by
add_request(). But add_request() is only called for requests that can't be
merged with requests currently on the queue. Thus the counters can't be
updated for sectors that are read by being added to aqueued
request. Unless I'm mistaken this makes the diskr/wblk mostly useless.

The disk_pgin/out fields appear to have been added based on a patch by
Sebastian Godard
(http://www.uwsg.indiana.edu/hypermail/linux/kernel/0002.1/1106.html) submitted
on the 13th of Feb 200. According to his email the statistics should
record the _kilobytes_ read or written to the disks. His code adds
drive_pg_stat_acct(). This routine increments disk_pgin/out once for each
call to make_request(). Presumably he has assumed every call to
make_request will always be for 2 sectors/1 Kilobytes worth of
data. However I added printk() statements to try to verify this and found
that the request to the block device need not be 1024 bytes, I frequently
saw 4096 requests. In fact, the "correct_size" for the block device
appeared to be changeable from partition to partition on the same
disk. This "correct_size" appears to be related to the block size for the
filesystem on the partition/disk? Following from the above logic it would
appear that the pgin/pgout statistics are also useless since you don't
know how large the requests were?

Is any of my understanding incorrect? If not it looks like these
statistics can't really be used.

In addition to trying to work out the meaning of the /proc/stat fields
I've been looking at the statistics provided through the 'sard' kernel
patche (which adds stats to the /proc/partitions file). These appear to
be correct, does anyone on this list have any comments regarding this
patch?

Please CC me on any replies as I am not subscribed to the list

Thanks,
Shaun

