Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261970AbVAHWZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbVAHWZV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 17:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261972AbVAHWWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 17:22:50 -0500
Received: from stateless.plumtree.co.nz ([202.89.35.97]:50313 "HELO
	stateless.plumtree.co.nz") by vger.kernel.org with SMTP
	id S261970AbVAHWUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 17:20:02 -0500
Date: Sun, 9 Jan 2005 11:19:56 +1300
From: Nicholas Lee <nj.lee@plumtree.co.nz>
To: linux-kernel@vger.kernel.org
Subject: evms md raid-1: kernel panic under load. With 2.6.8.1
Message-ID: <20050108221956.GA11437@stateless>
Mail-Followup-To: Nicholas Lee <nj.lee@plumtree.co.nz>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I've got an IBM x205 with three scsi disks:
[nic@river:/var/log] dmesg | grep scsi0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36

[nic@river:/var/log] dmesg | grep "SCSI device s" | grep sec
SCSI device sda: 35548320 512-byte hdwr sectors (18201 MB)
SCSI device sdb: 71096640 512-byte hdwr sectors (36401 MB)
SCSI device sdc: 71096640 512-byte hdwr sectors (36401 MB)

Linux kernel 2.6.8.1 with evms-2.4.0 and device-mapper.1.00.19 patches.


[nic@river:/var/log] dmesg | grep device-
device-mapper: 4.2.0-ioctl (2004-06-08) initialised: dm@uk.sistina.com

md:
[nic@river:/var/log] dmesg | grep md
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27

[nic@river:/var/log] cat /proc/mdstat
Personalities : [raid1]
md0 : active raid1 sdc[1] sdb[0]
      35548224 blocks [2/2] [UU]

unused devices: <none>


[nic@river:~] lsmod
Module                  Size  Used by
parport_pc             24320  -
lp                     10528  -
parport                39872  -
8250                   17536  -
serial_core            20480  -
raid1                  15040  -
rtc                    11264  -


Couple times my system has locked up and kernel panic. This time I
managed to get a panic message:


17:52:33 river kernel:  [__get_free_pages+29/56] __get_free_pages+0x1d/0x38
Jan  7 17:52:33 river kernel:  [kmem_getpages+31/188] kmem_getpages+0x1f/0xbc
Jan  7 17:52:33 river kernel:  [cache_grow+130/252] cache_grow+0x82/0xfc
Jan  7 17:52:33 river kernel:  [cache_alloc_refill+393/460] cache_alloc_refill+0x189/0x1cc
Jan  7 17:52:33 river kernel:  [as_remove_queued_request+217/232] as_remove_queued_request+0xd9/0xe8
Jan  7 17:52:33 river kernel:  [kmem_cache_alloc+47/56] kmem_cache_alloc+0x2f/0x38
Jan  7 17:52:33 river kernel:  [__scsi_get_command+26/76] __scsi_get_command+0x1a/0x4c
Jan  7 17:52:33 river kernel:  [scsi_get_command+20/112] scsi_get_command+0x14/0x70
Jan  7 17:52:33 river kernel:  [scsi_prep_fn+231/392] scsi_prep_fn+0xe7/0x188
Jan  7 17:52:33 river kernel:  [elv_next_request+16/216] elv_next_request+0x10/0xd8
Jan  7 17:52:33 river kernel:  [scsi_request_fn+66/720] scsi_request_fn+0x42/0x2d0
Jan  7 17:52:33 river kernel:  [__generic_unplug_device+50/56] __generic_unplug_device+0x32/0x38
Jan  7 17:52:33 river kernel:  [generic_unplug_device+11/16] generic_unplug_device+0xb/0x10
Jan  7 17:52:33 river kernel:  [blk_unplug_work+13/20] blk_unplug_work+0xd/0x14
Jan  7 17:52:33 river kernel:  [worker_thread+399/520] worker_thread+0x18f/0x208
Jan  7 17:52:33 river kernel:  [worker_thread+0/520] worker_thread+0x0/0x208
Jan  7 17:52:33 river kernel:  [blk_unplug_work+0/20] blk_unplug_work+0x0/0x14
Jan  7 17:52:33 river kernel:  [default_wake_function+0/28] default_wake_function+0x0/0x1c
Jan  7 17:52:33 river kernel:  [default_wake_function+0/28] default_wake_function+0x0/0x1c
Jan  7 17:52:33 river kernel:  [kthread+112/160] kthread+0x70/0xa0
Jan  7 17:52:33 river kernel:  [kthread+0/160] kthread+0x0/0xa0
Jan  7 17:52:33 river kernel:  [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc
Jan  7 17:52:33 river kernel: ------------[ cut here ]------------
Jan  7 17:52:33 river kernel: kernel BUG at include/linux/blkdev.h:565!
Jan  7 17:52:33 river kernel: invalid operand: 0000 [#1]
Jan  7 17:52:33 river kernel: Modules linked in: parport_pc lp parport 8250 serial_core raid1 rtc
Jan  7 17:52:33 river kernel: CPU:    0
Jan  7 17:52:33 river kernel: EIP:    0060:[scsi_request_fn+315/720]    Not tainted
Jan  7 17:52:33 river kernel: EFLAGS: 00010046   (2.6.8.1)
Jan  7 17:52:33 river kernel: EIP is at scsi_request_fn+0x13b/0x2d0
Jan  7 17:52:33 river kernel: eax: 00000001   ebx: dfcb5afc   ecx: 0012f248   edx: dfcb5afc
Jan  7 17:52:33 river kernel: esi: c17da000   edi: effb9600   ebp: efc01028   esp: eff16f48
Jan  7 17:52:33 river kernel: ds: 007b   es: 007b   ss: 0068
Jan  7 17:52:33 river kernel: Process kblockd/0 (pid: 5, threadinfo=eff16000 task=eff60030)
Jan  7 17:52:33 river kernel: Stack: efc01028 00000292 effbf480 efc01028 c17da18c c025910e efc01028 efc01128
Jan  7 17:52:33 river kernel:        c025911f efc01028 c0259151 efc01028 c011ed13 efc01028 eff16000 eff93f58
Jan  7 17:52:33 river kernel:        effbf480 c011eb84 effbf480 effbf48c c0259144 ffffffff ffffffff 00000001
Jan  7 17:52:33 river kernel: Call Trace:
Jan  7 17:52:33 river kernel:  [__generic_unplug_device+50/56] __generic_unplug_device+0x32/0x38
Jan  7 17:52:33 river kernel:  [generic_unplug_device+11/16] generic_unplug_device+0xb/0x10
Jan  7 17:52:33 river kernel:  [blk_unplug_work+13/20] blk_unplug_work+0xd/0x14
Jan  7 17:52:33 river kernel:  [worker_thread+399/520] worker_thread+0x18f/0x208
Jan  7 17:52:33 river kernel:  [worker_thread+0/520] worker_thread+0x0/0x208
Jan  7 17:52:33 river kernel:  [blk_unplug_work+0/20] blk_unplug_work+0x0/0x14
Jan  7 17:52:33 river kernel:  [default_wake_function+0/28] default_wake_function+0x0/0x1c
Jan  7 17:52:33 river kernel:  [default_wake_function+0/28] default_wake_function+0x0/0x1c
Jan  7 17:52:33 river kernel:  [kthread+112/160] kthread+0x70/0xa0
Jan  7 17:52:33 river kernel:  [kthread+0/160] kthread+0x0/0xa0
Jan  7 17:52:33 river kernel:  [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc
Jan  7 17:52:33 river kernel: Code: 0f 0b 35 02 37 b6 36 c0 90 8d 74 26 00 8b 43 04 89 42 04 89
Jan  7 20:02:20 river syslogd 1.4.1#16: restart.



At the time of the panic, system disk load was increase with a backup
running remote via rsync on a 500MB+ file.

The panic was caused by a "cp -a" on a 500MB+ directory.

All the filesystems on md1 are xfs based.


I'm wonder if there is a bug caused by a combination of evms, xfs and
raid1?


PS: Not subscribed. Please CC.

Thanks.
Nicholas
