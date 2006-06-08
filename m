Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932324AbWFHIQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbWFHIQq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 04:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932547AbWFHIQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 04:16:46 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:7210 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932324AbWFHIQq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 04:16:46 -0400
Date: Thu, 8 Jun 2006 10:19:26 +0200
From: Jens Axboe <axboe@suse.de>
To: reiserfs-dev@namesys.com
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: 2.6.17-rc6-mm1 reiser4 oopses on mount
Message-ID: <20060608081925.GX5207@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With the recent talks on what to merge and what not, I thought I'd try
and see how reiser4 fares in the io testing I was going to do in
2.6.17-rc6-mm1 anyways. I didn't get very far.

ml370:~ # mkfs.reiser4 /dev/cciss/c0d0p1
[...]
ml370:~ # mount /dev/cciss/c0d0p1 /data/ 
Killed

ml370:~ # dmesg
[...]
Unable to handle kernel NULL pointer dereference at 0000000000000013
RIP: 
 [<ffffffff80371a8c>] debugfs_mknod+0xc6/0x103
PGD 1181ea067 PUD 1181da067 PMD 0 
Oops: 0000 [1] SMP 
last sysfs file:
/devices/pci0000:00/0000:00:02.0/0000:02:00.2/0000:07:03.0/subsystem_device
CPU 3 
Modules linked in: cciss
Pid: 3638, comm: mount Not tainted 2.6.17-rc6-mm1 #1
RIP: 0010:[<ffffffff80371a8c>]  [<ffffffff80371a8c>]
debugfs_mknod+0xc6/0x103
RSP: 0018:ffff810118f77af8  EFLAGS: 00010202
RAX: 00000000ffffffef RBX: ffff810119d86378 RCX: 000000004487db63
RDX: 0000000039f626e8 RSI: 0000000039f626e8 RDI: ffffffff805c2e60
RBP: 00000000000041ed R08: ffff81011bfdc000 R09: 0000000000000000
R10: ffff810118f778b8 R11: ffffffff8031bbbc R12: fffffffffffffff3
R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff803080d1
FS:  00002b0f8adb46d0(0000) GS:ffff81011bfbf240(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000013 CR3: 0000000118f8a000 CR4: 00000000000006e0
Process mount (pid: 3638, threadinfo ffff810118f76000, task
ffff81011b719090)
Stack:  00000000000041ed ffff81011b7c7650 ffff81011be3aec0
0000000000000000
 0000000000000000 ffffffff80371bb1 ffff810118846400 fffffffffffffff3
 ffff810118846400 0000000000000000
Call Trace:
 [<ffffffff80371bb1>] debugfs_create_file+0xe8/0x18f
 [<ffffffff803081fd>] fill_super+0x12c/0x1e6
 [<ffffffff803080d1>] fill_super+0x0/0x1e6
 [<ffffffff802ad29f>] get_sb_bdev+0xeb/0x138
 [<ffffffff802ad06b>] vfs_kern_mount+0x3f/0x9f
 [<ffffffff802ad10d>] do_kern_mount+0x36/0x4d
 [<ffffffff802b55cc>] do_mount+0x674/0x6e6
 [<ffffffff8023c386>] invalidate_bh_lru+0x0/0x3e
 [<ffffffff8026cba5>] smp_call_function+0x3c/0x47
 [<ffffffff80209e8a>] get_page_from_freelist+0x221/0x3bf
 [<ffffffff8020ec19>] __alloc_pages+0x71/0x2ac
 [<ffffffff8024a76c>] sys_mount+0x8c/0xd6
 [<ffffffff8025bbd2>] system_call+0x7e/0x83


Code: 49 83 7c 24 20 00 75 2c 83 c8 ff 48 85 db 74 24 48 89 de 4c 
RIP  [<ffffffff80371a8c>] debugfs_mknod+0xc6/0x103
 RSP <ffff810118f77af8>
CR2: 0000000000000013

Looks like a NULL dentry was passed in to debugfs_mknod.

-- 
Jens Axboe

