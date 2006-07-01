Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbWGAMYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbWGAMYX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 08:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWGAMYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 08:24:23 -0400
Received: from tornado.reub.net ([202.89.145.182]:41601 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1751127AbWGAMYX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 08:24:23 -0400
Message-ID: <44A6696A.1010506@reub.net>
Date: Sun, 02 Jul 2006 00:24:10 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 3.0a1 (Windows/20060627)
MIME-Version: 1.0
To: Neil Brown <neilb@suse.de>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Weird RAID/SATA problem [ once was Re: 2.6.17-mm3 ]
References: <20060630105401.2dc1d3f3.akpm@osdl.org>	<44A5C1D5.20200@reub.net>	<17573.50871.307879.557218@cse.unsw.edu.au>	<44A5D079.6070505@reub.net>	<17573.55937.866300.638738@cse.unsw.edu.au>	<44A6390E.1030608@reub.net>	<17574.15295.828980.278323@cse.unsw.edu.au>	<44A64BD8.90906@reub.net>	<17574.21399.979888.127483@cse.unsw.edu.au>	<44A65EB7.5020201@reub.net> <17574.25837.681984.389682@cse.unsw.edu.au>
In-Reply-To: <17574.25837.681984.389682@cse.unsw.edu.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/07/2006 12:05 a.m., Neil Brown wrote:
> On Saturday July 1, reuben-lkml@reub.net wrote:
>>> Only difference I can think of is still barriers... Does this patch
>>> make any difference?
>> You will be happy to know that yes, it does make a difference.
>>
>> Applied to -mm4, RAID-1 now comes up with all arrays in sync and everything 
>> looking good.  Tried it twice, and both times raid-1 came up perfectly with
>>
>> md0 : active raid1 sdc2[1] sda2[0]
>>        24410688 blocks [2/2] [UU]
>>        bitmap: 0/187 pages [0KB], 64KB chunk
>>
>> for each md.
>>
> 
> Cool.... so who is giving us that EIO.  I'm guessing
> end_that_request_first or .._last, but where is it getting to there
> from?
> 
> What is you remove that last patch (so it still tries barrier writes)
> but add this patch (so WARN_ON gives us a trace when it happens).

Bear in mind that this does not include Ingo's fix for the md stuff:


Bootdata ok (command line is ro root=/dev/md0 panic=60 console=ttyS0,57600 single)
Linux version 2.6.17-mm4 (root@tornado.reub.net) (gcc version 4.1.1 20060629 
(Red Hat 4.1.1-6)) #3 SMP Sun Jul 2 00:11:13 NZST 2006

<snip>

mice: PS/2 mouse device common for all mice
md: raid1 personality registered for level 1
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
EDAC MC: Ver: 2.0.0 Jul  1 2006
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
BIOS EDD facility v0.16 2004-Jun-25, 3 devices found
Freeing unused kernel memory: 216k freed
Red Hat nash version 5.0.46 starting
Mounting proc filesystem
Mounting sysfs filesystem
Creating /dev
Creating initial device nodes
Setting up hotplug.
Creating block device nodes.
Loading ide-disk.ko module
md: Autodetecting RAID arrays.
md: invalid raid superblock magic on sda10
md: sda10 has invalid sb, not importing!
BUG: warning at fs/block_dev.c:1109/__blkdev_put()

Call Trace:
  [<ffffffff802bf192>] __blkdev_put+0x9c/0x1bb
  [<ffffffff802bf2bf>] blkdev_put_partition+0xe/0x10
  [<ffffffff8041f434>] unlock_rdev+0x49/0x50
  [<ffffffff8041fc9a>] md_import_device+0x24a/0x2a0
  [<ffffffff8033af8a>] selinux_capable+0x24/0x29
  [<ffffffff80424a21>] md_ioctl+0xc1/0x154f
  [<ffffffff8033a693>] avc_has_perm+0x49/0x5b
  [<ffffffff80350762>] blkdev_driver_ioctl+0x62/0x80
  [<ffffffff80350e76>] blkdev_ioctl+0x6f6/0x75a
  [<ffffffff8023f674>] wake_up_inode+0x18/0x24
  [<ffffffff8033ae13>] inode_has_perm+0x62/0x71
  [<ffffffff802bfa62>] blkdev_open+0x0/0x61
  [<ffffffff802bfa8e>] blkdev_open+0x2c/0x61
  [<ffffffff8033aecc>] file_has_perm+0xaa/0xb9
  [<ffffffff802beb12>] block_ioctl+0x1b/0x1f
  [<ffffffff802432ea>] do_ioctl+0x2a/0x8f
  [<ffffffff8023185b>] vfs_ioctl+0x27b/0x2a0
  [<ffffffff8024e76a>] sys_ioctl+0x5f/0x82
  [<ffffffff8022fadd>] sys_fcntl+0x33d/0x34f
  [<ffffffff8026014a>] system_call+0x7e/0x83

BUG: warning at fs/block_dev.c:1128/__blkdev_put()

Call Trace:
  [<ffffffff803576f8>] kobject_put+0x19/0x21
  [<ffffffff802bf274>] __blkdev_put+0x17e/0x1bb
  [<ffffffff802bf2bf>] blkdev_put_partition+0xe/0x10
  [<ffffffff8041f434>] unlock_rdev+0x49/0x50
  [<ffffffff8041fc9a>] md_import_device+0x24a/0x2a0
  [<ffffffff8033af8a>] selinux_capable+0x24/0x29
  [<ffffffff80424a21>] md_ioctl+0xc1/0x154f
  [<ffffffff8033a693>] avc_has_perm+0x49/0x5b
  [<ffffffff80350762>] blkdev_driver_ioctl+0x62/0x80
  [<ffffffff80350e76>] blkdev_ioctl+0x6f6/0x75a
  [<ffffffff8023f674>] wake_up_inode+0x18/0x24
  [<ffffffff8033ae13>] inode_has_perm+0x62/0x71
  [<ffffffff802bfa62>] blkdev_open+0x0/0x61
  [<ffffffff802bfa8e>] blkdev_open+0x2c/0x61
  [<ffffffff8033aecc>] file_has_perm+0xaa/0xb9
  [<ffffffff802beb12>] block_ioctl+0x1b/0x1f
  [<ffffffff802432ea>] do_ioctl+0x2a/0x8f
  [<ffffffff8023185b>] vfs_ioctl+0x27b/0x2a0
  [<ffffffff8024e76a>] sys_ioctl+0x5f/0x82
  [<ffffffff8022fadd>] sys_fcntl+0x33d/0x34f
  [<ffffffff8026014a>] system_call+0x7e/0x83

md: invalid raid superblock magic on sdc10
md: sdc10 has invalid sb, not importing!
BUG: warning at fs/block_dev.c:1109/__blkdev_put()

Call Trace:
  [<ffffffff802bf192>] __blkdev_put+0x9c/0x1bb
  [<ffffffff802bf2bf>] blkdev_put_partition+0xe/0x10
  [<ffffffff8041f434>] unlock_rdev+0x49/0x50
  [<ffffffff8041fc9a>] md_import_device+0x24a/0x2a0
  [<ffffffff8033af8a>] selinux_capable+0x24/0x29
  [<ffffffff80424a21>] md_ioctl+0xc1/0x154f
  [<ffffffff8033a693>] avc_has_perm+0x49/0x5b
  [<ffffffff80350762>] blkdev_driver_ioctl+0x62/0x80
  [<ffffffff80350e76>] blkdev_ioctl+0x6f6/0x75a
  [<ffffffff8023f674>] wake_up_inode+0x18/0x24
  [<ffffffff8033ae13>] inode_has_perm+0x62/0x71
  [<ffffffff802bfa62>] blkdev_open+0x0/0x61
  [<ffffffff802bfa8e>] blkdev_open+0x2c/0x61
  [<ffffffff8033aecc>] file_has_perm+0xaa/0xb9
  [<ffffffff802beb12>] block_ioctl+0x1b/0x1f
  [<ffffffff802432ea>] do_ioctl+0x2a/0x8f
  [<ffffffff8023185b>] vfs_ioctl+0x27b/0x2a0
  [<ffffffff8024e76a>] sys_ioctl+0x5f/0x82
  [<ffffffff8022fadd>] sys_fcntl+0x33d/0x34f
  [<ffffffff8026014a>] system_call+0x7e/0x83

BUG: warning at fs/block_dev.c:1128/__blkdev_put()

Call Trace:
  [<ffffffff803576f8>] kobject_put+0x19/0x21
  [<ffffffff802bf274>] __blkdev_put+0x17e/0x1bb
  [<ffffffff802bf2bf>] blkdev_put_partition+0xe/0x10
  [<ffffffff8041f434>] unlock_rdev+0x49/0x50
  [<ffffffff8041fc9a>] md_import_device+0x24a/0x2a0
  [<ffffffff8033af8a>] selinux_capable+0x24/0x29
  [<ffffffff80424a21>] md_ioctl+0xc1/0x154f
  [<ffffffff8033a693>] avc_has_perm+0x49/0x5b
  [<ffffffff80350762>] blkdev_driver_ioctl+0x62/0x80
  [<ffffffff80350e76>] blkdev_ioctl+0x6f6/0x75a
  [<ffffffff8023f674>] wake_up_inode+0x18/0x24
  [<ffffffff8033ae13>] inode_has_perm+0x62/0x71
  [<ffffffff802bfa62>] blkdev_open+0x0/0x61
  [<ffffffff802bfa8e>] blkdev_open+0x2c/0x61
  [<ffffffff8033aecc>] file_has_perm+0xaa/0xb9
  [<ffffffff802beb12>] block_ioctl+0x1b/0x1f
  [<ffffffff802432ea>] do_ioctl+0x2a/0x8f
  [<ffffffff8023185b>] vfs_ioctl+0x27b/0x2a0
  [<ffffffff8024e76a>] sys_ioctl+0x5f/0x82
  [<ffffffff8022fadd>] sys_fcntl+0x33d/0x34f
  [<ffffffff8026014a>] system_call+0x7e/0x83

md: autorun ...
md: considering sdc11 ...
md:  adding sdc11 ...
md: sdc7 has different UUID to sdc11
md: sdc6 has different UUID to sdc11
md: sdc5 has different UUID to sdc11
md: sdc3 has different UUID to sdc11
md: sdc2 has different UUID to sdc11
md:  adding sda11 ...
md: sda7 has different UUID to sdc11
md: sda6 has different UUID to sdc11
md: sda5 has different UUID to sdc11
md: sda3 has different UUID to sdc11
md: sda2 has different UUID to sdc11
md: created md5
md: bind<sda11>
md: bind<sdc11>
md: running: <sdc11><sda11>
raid1: raid set md5 active with 2 out of 2 mirrors
md5: bitmap initialized from disk: read 10/10 pages, set 0 bits, status: 0
created bitmap (153 pages) for device md5
BUG: warning at drivers/md/md.c:411/super_written_barrier()

Call Trace:
  <IRQ> [<ffffffff80422231>] super_written_barrier+0x61/0x100
  [<ffffffff8023c000>] bio_endio+0x5a/0x6a
  [<ffffffff8022e24f>] __end_that_request_first+0x16f/0x4c9
  [<ffffffff8024afaa>] end_that_request_first+0xc/0xe
  [<ffffffff8034e825>] blk_ordered_complete_seq+0x7d/0x8c
  [<ffffffff8034e864>] post_flush_end_io+0x30/0x35
  [<ffffffff8034e748>] end_that_request_last+0xd8/0xf4
  [<ffffffff803d83a1>] scsi_end_request+0xb1/0xdd
  [<ffffffff803d87cd>] scsi_io_completion+0x3cd/0x3dc
  [<ffffffff803d8802>] scsi_blk_pc_done+0x26/0x28
  [<ffffffff803d3e53>] scsi_finish_command+0x66/0x73
  [<ffffffff803d8b71>] scsi_softirq_done+0xe1/0xf0
  [<ffffffff80239980>] blk_done_softirq+0x6e/0x7e
  [<ffffffff80211f5e>] __do_softirq+0x63/0xe5
  [<ffffffff80261322>] call_softirq+0x1e/0x28
  [<ffffffff8026ac58>] do_softirq+0x34/0x8b
  [<ffffffff802872c8>] irq_exit+0x48/0x4a
  [<ffffffff8026ac1a>] do_IRQ+0x6b/0x75
  [<ffffffff8025a3f1>] mwait_idle+0x0/0x4f
  [<ffffffff80260644>] ret_from_intr+0x0/0xa
  <EOI> [<ffffffff80268e00>] prepare_to_copy+0x32/0x3b
  [<ffffffff80268e04>] prepare_to_copy+0x36/0x3b
  [<ffffffff80268e03>] prepare_to_copy+0x35/0x3b
  [<ffffffff8026ee04>] mce_init+0x35/0xec
  [<ffffffff8026ee00>] mce_init+0x31/0xec
  [<ffffffff80268e00>] prepare_to_copy+0x32/0x3b
<repeats dozens of times>
  [<ffffffff80268e00>] prepare_to_copy+0x32/0x3b
  [<ffffffff8026ee00>] mce_init+0x31/0xec
  [<ffffffff80268e00>] prepare_to_copy+0x32/0x3b
<repeats dozens of times>
  [<ffffffff80268e00>] prepare_to_copy+0x32/0x3b
  [<ffffffff80208e00>] __d_lookup+0xa0/0x140
  [<ffffffff802a669f>] handle_bad_irq+0x0/0x1fd
  [<ffffffff802a669f>] handle_bad_irq+0x0/0x1fd
<repeats dozens of times>

reuben
