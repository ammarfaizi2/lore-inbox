Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261660AbVAYTYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbVAYTYl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 14:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbVAYTYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 14:24:41 -0500
Received: from smtp3.pp.htv.fi ([213.243.153.36]:6084 "EHLO smtp3.pp.htv.fi")
	by vger.kernel.org with ESMTP id S261660AbVAYTYb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 14:24:31 -0500
Subject: UDF madness
From: Attila Body <compi@freemail.hu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 25 Jan 2005 21:24:45 +0000
Message-Id: <1106688285.5297.3.camel@smiley>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've spent some time (2 weekwnds) on this issue, while I was able to
realize that not the packet-writing but the UDF driver is broken

here is the recipie to reproduve the issue:

dd if=/dev/zer of=udf.img bs=1024k count=3000
mkudffs udf.img
mount -o loop udf.img /mnt/tmp
cd /mnt/tmp
tar xjvf /usr/src/linux-2.6.11-rc2
cd /
umount /mnt/tmp

On the end I get a never ending umount process in D state. sysreq-T
tells the following about the umount process:



umount        D C03F93E0     0  5848   5655                     (NOTLB)
c797dd68 00200082 ca674560 c03f93e0 00000040 00000000 c81e327c 0000000c 
       000ae62d 925f0dc0 000f43e3 ca674560 ca6746b0 c797c000 cebf184c
00200282 
       ca674560 c02ea6e0 cebf1854 00000001 ca674560 c01170c0 cebf1854
cebf1854 
Call Trace:
 [<c02ea6e0>] __down+0x90/0x110
 [<c01170c0>] default_wake_function+0x0/0x20
 [<c017c511>] __mark_inode_dirty+0xd1/0x1c0
 [<c02ea8ab>] __down_failed+0x7/0xc
 [<e0d1fda0>] .text.lock.balloc+0x8/0x128 [udf]
 [<e0d25767>] udf_write_aext+0xf7/0x170 [udf]
 [<e0d1fbac>] udf_free_blocks+0xcc/0x100 [udf]
 [<e0d2cda4>] extent_trunc+0x124/0x180 [udf]
 [<e0d2d025>] udf_discard_prealloc+0x225/0x2e0 [udf]
 [<e0d21301>] udf_clear_inode+0x41/0x50 [udf]
 [<c017285e>] clear_inode+0xde/0x120
 [<c01728df>] dispose_list+0x3f/0xb0
 [<c0172a92>] invalidate_inodes+0x62/0x90
 [<c015e9ad>] generic_shutdown_super+0x5d/0x140
 [<c015f69d>] kill_block_super+0x2d/0x50
 [<c015e84d>] deactivate_super+0x6d/0x90
 [<c0175e6f>] sys_umount+0x3f/0xa0
 [<c014bc8d>] do_munmap+0x13d/0x180
 [<c014bd14>] sys_munmap+0x44/0x70
 [<c0175ee7>] sys_oldumount+0x17/0x20
 [<c0103263>] syscall_call+0x7/0xb

any ideas (or patches?)

Thanks,

compi

