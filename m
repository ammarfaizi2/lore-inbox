Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030322AbVKPNgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030322AbVKPNgb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 08:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030333AbVKPNgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 08:36:31 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:25994 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S1030322AbVKPNgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 08:36:31 -0500
Date: Wed, 16 Nov 2005 14:36:39 +0100
From: Sander <sander@humilis.net>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: segfault mdadm --write-behind, 2.6.14-mm2  (was: Re: RAID1 ramdisk patch)
Message-ID: <20051116133639.GA18274@favonius>
Reply-To: sander@humilis.net
References: <431B9558.1070900@baanhofman.nl> <17179.40731.907114.194935@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17179.40731.907114.194935@cse.unsw.edu.au>
X-Uptime: 12:58:56 up 2 days,  1:29, 21 users,  load average: 1.29, 1.60, 1.67
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote (ao):
>  If you use mdadm-2.0 and mark a device as --write-mostly, then all
>  read requests will go to the other device(s) if possible,.
>  e.g.
>    mdadm --create /dev/md0 --level=1 --raid-disks=2 /dev/ramdisk \
>       --writemostly /dev/realdisk
> 
>  Does this suit your needs?
> 
>  You can also arrange for the write to the writemostly device to be
>  'write-behind' so that the filesystem doesn't wait for the write to
>  complete.  This can reduce write-latency (though not increase write
>  throughput) at a very small cost of reliability (if the RAM dies, the
>  disk may not be 100% up-to-date).

With 2.6.14-mm2 (x86) and mdadm 2.1 I get a Segmentation fault when I
try this:

mdadm -C /dev/md1 -l1 -n2 --bitmap=/storage/md1.bitmap /dev/loop0 \
--write-behind /dev/loop1

loop0 is attached to a file on tmpfs, and loop1 is attached
to a file on a lvm2 volume (reiser4, if that matters).

I can create and use the array with:

mdadm -C /dev/md1 -l1 -n2 /dev/loop0 /dev/loop1

and

mdadm -C /dev/md1 -l1 -n2 /dev/loop0 --write-mostly /dev/loop1

mdadm is compiled with:
gcc (GCC) 4.0.3 20051023 (prerelease) (Debian 4.0.2-3)

Can/should I provide more info?

	With kind regards, Sander

This is what I get if I reboot, create the images with dd,
attach them with losetup and try to create the array with mdadm:


[42949575.730000] loop: loaded (max 8 devices)
[42949584.840000] md: bind<loop0>
[42949584.840000] md: bind<loop1>
[42949584.840000] md: md1: raid array is not clean -- starting background reconstruction
[42949584.840000] md1: bitmap file is out of date (0 < 1) -- forcing full recovery
[42949584.840000] md1: bitmap file is out of date, doing full recovery
[42949584.840000] Unable to handle kernel NULL pointer dereference at virtual address 00000008
[42949584.840000]  printing eip:
[42949584.840000] c01c33dd
[42949584.840000] *pde = 00000000
[42949584.840000] Oops: 0000 [#1]
[42949584.840000] last sysfs file: /devices/pci0000:00/0000:00:11.0/i2c-0/name
[42949584.840000] Modules linked in: loop dm_mod i2c_viapro i2c_core
[42949584.840000] CPU:    0
[42949584.840000] EIP:    0060:[<c01c33dd>]    Not tainted VLI
[42949584.840000] EFLAGS: 00010286   (2.6.14-mm2)
[42949584.840000] EIP is at prepare_write_unix_file+0x1d/0xab
[42949584.840000] eax: 00000000   ebx: c01c33c0   ecx: 00000000   edx: c104ce60
[42949584.840000] esi: c104ce60   edi: f2f2f4a0   ebp: 00000000   esp: c2d6bd90
[42949584.840000] ds: 007b   es: 007b   ss: 0068
[42949584.840000] Process mdadm (pid: 749, threadinfo=c2d6b000 task=c3784580)
[42949584.840000] Stack: 30303034 00000000 c104ce60 c01c33c0 c104ce60 f2f2f4a0 00000001 c02b00f2
[42949584.840000]        00001000 00000f00 f2f2f4a0 c2674000 c104ce60 c02b1154 c03a97dc f7c278cc
[42949584.840000]        c2d6bddc c02b05b4 c03a975c f7c278cc 00000000 00000000 00000000 00031f20
[42949584.840000] Call Trace:
[42949584.840000]  [<c01c33c0>] prepare_write_unix_file+0x0/0xab
[42949584.840000]  [<c02b00f2>] write_page+0x52/0x140
[42949584.840000]  [<c02b1154>] bitmap_init_from_disk+0x384/0x450
[42949584.840000]  [<c02b05b4>] bitmap_read_sb+0x84/0x2f0
[42949584.840000]  [<c02b21f3>] bitmap_create+0x1a3/0x2a0
[42949584.840000]  [<c02ab95a>] do_md_run+0x2ba/0x500
[42949584.840000]  [<c02ac8a7>] add_new_disk+0x157/0x3b0
[42949584.840000]  [<c0179034>] mpage_writepages+0x124/0x3d0
[42949584.840000]  [<c013c23e>] __pagevec_free+0x3e/0x60
[42949584.840000]  [<c013eff9>] release_pages+0x29/0x160
[42949584.840000]  [<c02adb81>] md_ioctl+0x5a1/0x630
[42949584.840000]  [<c0137918>] find_get_pages+0x18/0x40
[42949584.840000]  [<c02ad5e0>] md_ioctl+0x0/0x630
[42949584.840000]  [<c01ede74>] blkdev_driver_ioctl+0x54/0x60
[42949584.840000]  [<c01edfb4>] blkdev_ioctl+0x134/0x180
[42949584.840000]  [<c015e158>] block_ioctl+0x18/0x20
[42949584.840000]  [<c015e140>] block_ioctl+0x0/0x20
[42949584.840000]  [<c01674ff>] do_ioctl+0x1f/0x70
[42949584.840000]  [<c016769c>] vfs_ioctl+0x5c/0x1e0
[42949584.840000]  [<c0156c91>] __fput+0xe1/0x140
[42949584.840000]  [<c016785d>] sys_ioctl+0x3d/0x70
[42949584.840000]  [<c0102f49>] syscall_call+0x7/0xb
[42949584.840000] Code: 02 00 00 eb 89 89 f6 8d bc 27 00 00 00 00 83 ec 1c 89 5c 24 0c 89 7c 24 14 89 6c 24 18 89 c5 89 74 24 10 89 54 24 08 89 4c 24 04 <8b> 40 08 8b 40 08 8b 80 94 00 00 00 e8 92 20 fd ff 3d 18 fc ff
[42949584.840000]


-- 
Humilis IT Services and Solutions
http://www.humilis.net
