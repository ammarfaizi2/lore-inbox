Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbVKQKMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbVKQKMv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 05:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbVKQKMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 05:12:51 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:63126 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S1750719AbVKQKMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 05:12:50 -0500
Date: Thu, 17 Nov 2005 11:12:51 +0100
From: Sander <sander@humilis.net>
To: Sander <sander@humilis.net>
Cc: Neil Brown <neilb@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: segfault mdadm --write-behind, 2.6.14-mm2  (was: Re: RAID1 ramdisk patch)
Message-ID: <20051117101251.GA2883@favonius>
Reply-To: sander@humilis.net
References: <431B9558.1070900@baanhofman.nl> <17179.40731.907114.194935@cse.unsw.edu.au> <20051116133639.GA18274@favonius> <20051116142000.5c63449f.akpm@osdl.org> <17275.48113.533555.948181@cse.unsw.edu.au> <20051117075041.GA5563@favonius>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051117075041.GA5563@favonius>
X-Uptime: 10:11:06 up 2 days, 22:47, 20 users,  load average: 1.07, 1.67, 1.78
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sander wrote (ao):
# Neil Brown wrote (ao):
# > On Wednesday November 16, akpm@osdl.org wrote:
# > > Sander <sander@humilis.net> wrote:
# > > > With 2.6.14-mm2 (x86) and mdadm 2.1 I get a Segmentation fault when I
# > > > try this:
# > > 
# > > It oopsed in reiser4.  reiserfs-dev added to Cc...
# > > 
# > 
# > Hmm... It appears that md/bitmap is calling prepare_write and
# > commit_write with 'file' as NULL - this works for some filesystems,
# > but not for reiser4.
# > 
# > Does this patch help.
# 
# Something changed, but it didn't fix it it seems:
# 
# # mdadm -C /dev/md1 --bitmap=/storage/raid1.bitmap -l1 -n2 /dev/loop0 --write-behind /dev/loop1
# mdadm: RUN_ARRAY failed: No such file or directory

FWIW, the following happens when I point --bitmap to /tmp/raid1.bitmap
which is tmpfs, and also happens when I attach both loop0 and loop1 to
files on tmpfs.

This would suggest that reiser4 is not solely at fault?

The difference btw is that I can reboot with 'shutdown -r now'
instead of sysrq. And that mdadm hangs:

# mdadm -C /dev/md1 --bitmap=/tmp/raid1.bitmap -l1 -n2 /dev/loop0 --write-behind /dev/loop1
mdadm: RUN_ARRAY failed: No such file or directory

# mdadm -C /dev/md1 -f --bitmap=/tmp/raid1.bitmap -l1 -n2 /dev/loop0 --write-behind /dev/loop1
mdadm: /dev/loop0 appears to be part of a raid array:
    level=raid1 devices=2 ctime=Thu Nov 17 11:04:31 2005
mdadm: /dev/loop1 appears to be part of a raid array:
    level=raid1 devices=2 ctime=Thu Nov 17 11:04:31 2005
Continue creating array? yes
[hang, no prompt, no reaction to ctrl-c, etc]


[42949549.780000] md: bind<loop0>
[42949549.780000] md: bind<loop1>
[42949549.780000] md: md1: raid array is not clean -- starting background reconstruction
[42949549.790000] md1: bitmap file is out of date (0 < 1) -- forcing full recovery
[42949549.790000] md1: bitmap file is out of date, doing full recovery
[42949549.790000] md1: bitmap initialized from disk: read 0/4 pages, set 0 bits, status: 524288
[42949549.790000] Bad page state at free_hot_cold_page (in process 'mdadm', page c10dcc20)
[42949549.790000] flags:0x80000019 mapping:f5155c84 mapcount:0 count:0
[42949549.790000] Backtrace:
[42949549.790000]  [<c013b320>] bad_page+0x70/0xb0
[42949549.790000]  [<c013bab1>] free_hot_cold_page+0x51/0xd0
[42949549.790000]  [<c02b0a90>] bitmap_file_put+0x30/0x70
[42949549.790000]  [<c02b1f8e>] bitmap_free+0x1e/0xb0
[42949549.790000]  [<c02b2126>] bitmap_create+0xd6/0x2a0
[42949549.790000]  [<c02ab95a>] do_md_run+0x2ba/0x500
[42949549.790000]  [<c02ac8a7>] add_new_disk+0x157/0x3b0
[42949549.790000]  [<c0179034>] mpage_writepages+0x124/0x3d0
[42949549.790000]  [<c013c23e>] __pagevec_free+0x3e/0x60
[42949549.790000]  [<c013eff9>] release_pages+0x29/0x160
[42949549.790000]  [<c02adb81>] md_ioctl+0x5a1/0x630
[42949549.790000]  [<c0137918>] find_get_pages+0x18/0x40
[42949549.790000]  [<c02ad5e0>] md_ioctl+0x0/0x630
[42949549.790000]  [<c01ede74>] blkdev_driver_ioctl+0x54/0x60
[42949549.790000]  [<c01edfb4>] blkdev_ioctl+0x134/0x180
[42949549.790000]  [<c015e158>] block_ioctl+0x18/0x20
[42949549.790000]  [<c015e140>] block_ioctl+0x0/0x20
[42949549.790000]  [<c01674ff>] do_ioctl+0x1f/0x70
[42949549.790000]  [<c016769c>] vfs_ioctl+0x5c/0x1e0
[42949549.790000]  [<c0156c91>] __fput+0xe1/0x140
[42949549.790000]  [<c016785d>] sys_ioctl+0x3d/0x70
[42949549.790000]  [<c0102f49>] syscall_call+0x7/0xb
[42949549.790000] Trying to fix it up, but a reboot is needed
[42949549.790000] md1: failed to create bitmap (524288)
[42949549.790000] md: pers->run() failed ...
[42949549.790000] md: md1 stopped.
[42949549.790000] md: unbind<loop1>
[42949549.790000] md: export_rdev(loop1)
[42949549.790000] md: unbind<loop0>
[42949549.790000] md: export_rdev(loop0)


-- 
Humilis IT Services and Solutions
http://www.humilis.net
