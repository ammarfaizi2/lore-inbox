Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964900AbVKVKed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964900AbVKVKed (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 05:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbVKVKed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 05:34:33 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:188 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S964900AbVKVKed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 05:34:33 -0500
Date: Tue, 22 Nov 2005 11:34:29 +0100
From: Sander <sander@humilis.net>
To: Neil Brown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, sander@humilis.net,
       linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: Please help me understand ->writepage. Was Re: segfault mdadm --write-behind, 2.6.14-mm2  (was: Re: RAID1 ramdisk patch)
Message-ID: <20051122103428.GA12072@favonius>
Reply-To: sander@humilis.net
References: <17179.40731.907114.194935@cse.unsw.edu.au> <20051116133639.GA18274@favonius> <20051116142000.5c63449f.akpm@osdl.org> <17275.48113.533555.948181@cse.unsw.edu.au> <20051117075041.GA5563@favonius> <20051117101251.GA2883@favonius> <20051117101511.GB2883@favonius> <17282.21309.229128.930997@cse.unsw.edu.au> <20051121155144.62bedaab.akpm@osdl.org> <17282.35980.613583.592130@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17282.35980.613583.592130@cse.unsw.edu.au>
X-Uptime: 11:04:50 up 4 days, 19:11, 21 users,  load average: 2.06, 1.95, 2.21
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote (ao):
> On Monday November 21, akpm@osdl.org wrote:
> > bitmap->filemap_attr can be allocated with kzalloc() now.
> Yes, thanks.
> 
> So Sander, could you try this patch for main against reiser4?  It
> seems to work on ext3 and tmpfs and has some chance of not mucking up
> on reiser4.

It doesn't crash or segfault anymore. It works with the bitmap file on
tmpfs, but not yet on reiser4.

This is kernel 2.6.15-rc1-mm2 with your (Neil Brown's) patch.


loop0 is connected to a file on tmpfs
loop1 to a file on reiser4
/storage/raid1.bitmap is also on reiser4

# mdadm -C /dev/md1 --bitmap=/storage/raid1.bitmap -l1 -n2 /dev/loop0 --write-behind /dev/loop1
mdadm: RUN_ARRAY failed: No such file or directory

# cat /proc/mdstat
Personalities : [linear] [raid0] [raid1] [raid5] [multipath] [raid6] [raid10]
md0 : active raid1 sdd1[3] sdc1[2] sdb1[1] sda1[0]
      1003904 blocks [4/4] [UUUU]

unused devices: <none>

# mdadm -C /dev/md1 --bitmap=/storage/raid1.bitmap -l1 -n2 /dev/loop0 --write-behind /dev/loop1
mdadm: /dev/loop0 appears to be part of a raid array:
    level=raid1 devices=2 ctime=Tue Nov 22 11:09:15 2005
mdadm: /dev/loop1 appears to be part of a raid array:
    level=raid1 devices=2 ctime=Tue Nov 22 11:09:15 2005
Continue creating array? yes
mdadm: bitmap file /storage/raid1.bitmap already exists, use --force to overwrite

# mdadm -C /dev/md1 -f --bitmap=/storage/raid1.bitmap -l1 -n2 /dev/loop0 --write-behind /dev/loop1
mdadm: /dev/loop0 appears to be part of a raid array:
    level=raid1 devices=2 ctime=Tue Nov 22 11:09:15 2005
mdadm: /dev/loop1 appears to be part of a raid array:
    level=raid1 devices=2 ctime=Tue Nov 22 11:09:15 2005
Continue creating array? yes
mdadm: RUN_ARRAY failed: Success

# cat /proc/mdstat 
Personalities : [linear] [raid0] [raid1] [raid5] [multipath] [raid6] [raid10] 
md0 : active raid1 sdd1[3] sdc1[2] sdb1[1] sda1[0]
      1003904 blocks [4/4] [UUUU]
      
unused devices: <none>


dmesg:
[42949583.660000] loop: loaded (max 8 devices)
[42949655.110000] md: bind<loop0>
[42949655.110000] md: bind<loop1>
[42949655.110000] md: md1: raid array is not clean -- starting background reconstruction
[42949655.110000] md1: bitmap file is out of date (0 < 1) -- forcing full recovery
[42949655.110000] md1: bitmap file is out of date, doing full recovery
[42949655.680000] md1: bitmap initialized from disk: read 0/4 pages, set 0 bits, status: 1
[42949655.680000] md1: failed to create bitmap (1)
[42949655.680000] md: pers->run() failed ...
[42949655.680000] md: md1 stopped.
[42949655.680000] md: unbind<loop1>
[42949655.680000] md: export_rdev(loop1)
[42949655.680000] md: unbind<loop0>
[42949655.680000] md: export_rdev(loop0)
[42949671.480000] md: bind<loop0>
[42949671.480000] md: bind<loop1>
[42949671.480000] md: md1: raid array is not clean -- starting background reconstruction
[42949671.480000] md1: bitmap file is out of date (0 < 1) -- forcing full recovery
[42949671.480000] md1: bitmap file is out of date, doing full recovery
[42949671.770000] md1: bitmap initialized from disk: read 0/4 pages, set 0 bits, status: 1
[42949671.770000] md1: failed to create bitmap (1)
[42949671.770000] md: pers->run() failed ...
[42949671.770000] md: md1 stopped.
[42949671.770000] md: unbind<loop1>
[42949671.770000] md: export_rdev(loop1)
[42949671.770000] md: unbind<loop0>
[42949671.770000] md: export_rdev(loop0)


It does work with the bitmap file on tmpfs:

# mdadm -C /dev/md1 -f --bitmap=/tmp/raid1.bitmap -l1 -n2 /dev/loop0 --write-behind /dev/loop1
mdadm: /dev/loop0 appears to be part of a raid array:
    level=raid1 devices=2 ctime=Tue Nov 22 11:20:48 2005
mdadm: /dev/loop1 appears to be part of a raid array:
    level=raid1 devices=2 ctime=Tue Nov 22 11:20:48 2005
Continue creating array? yes
mdadm: array /dev/md1 started.

silo1:~# cat /proc/mdstat 
Personalities : [linear] [raid0] [raid1] [raid5] [multipath] [raid6] [raid10] 
md1 : active raid1 loop1[1] loop0[0]
      509056 blocks [2/2] [UU]
      [>....................]  resync =  1.2% (6528/509056) finish=2.5min speed=3264K/sec
      bitmap: 63/63 pages [252KB], 4KB chunk, file: /tmp/raid1.bitmap

md0 : active raid1 sdd1[3] sdc1[2] sdb1[1] sda1[0]
      1003904 blocks [4/4] [UUUU]
      
unused devices: <none>


Is there anything you need me to test further?

Thanks for the patch!

	Sander

-- 
Humilis IT Services and Solutions
http://www.humilis.net
