Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267659AbUH3Kfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267659AbUH3Kfq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 06:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267661AbUH3Kfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 06:35:46 -0400
Received: from 203-97-51-114.dsl.clear.net.nz ([203.97.51.114]:47047 "EHLO
	et.endace.com") by vger.kernel.org with ESMTP id S267659AbUH3Kfl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 06:35:41 -0400
Message-ID: <001001c48e7d$17c63b60$5440a8c0@zeus>
From: "James Spooner" <james@endace.com>
To: <linux-kernel@vger.kernel.org>
Subject: JFS kernel BUG
Date: Mon, 30 Aug 2004 22:35:39 +1200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've encountered a problem writing large files onto a JFS
filesystem under 2.6.8.1.  As follows.  What is interesting
is that this bug is triggered as the file reaches the 512GB
mark, co-incidence perhaps? :)

mower:~# mount
rootfs on / type rootfs (rw)
/dev/root on / type ext3 (rw)
proc on /proc type proc (rw,nodiratime)
/dev/hda1 on /boot type ext3 (rw)
/dev/md0 on /one type jfs (rw)

mower:~# ls -lh /one
total 512G
-rw-r--r--  1 root root 512G Aug 31 10:25 tmp2

Underlying volume is a RAID0 of 3Ware controllers.

Total volume size is just short of 3TB.

File is being opened using O_DIRECT, bypassing the filesystem
cache.  I've also pulled out Andrew Mortons 2.6.9-rc1-mm1
but to no avail.

Any ideas here?

Cheers

James

BUG() output follows....

BUG at fs/jfs/jfs_xtree.c:1701 assert(p->header.nextindex == ((__u16)(2 +
1)))
------------[ cut here ]------------
kernel BUG at fs/jfs/jfs_xtree.c:1701!
invalid operand: 0000 [#1]
PREEMPT SMP
Modules linked in: jfs af_packet e1000 dm_mod 3w_9xxx parport_pc lp parport
unix
CPU:    0
EIP:    0060:[<f892ee9d>]    Not tainted
EFLAGS: 00010282   (2.6.8.1)
EIP is at xtExtend+0x3f9/0x786 [jfs]
eax: 00000052   ebx: 00000000   ecx: c047ebd4   edx: 00000286
esi: 00000001   edi: 00000000   ebp: dc4bb1c8   esp: f1c0ba8c
ds: 007b   es: 007b   ss: 0068
Process dfwrite (pid: 1701, threadinfo=f1c0a000 task=f1c0c130)
Stack: f8952b1d f8952b0a 000006a5 f894fac0 f1c0baf4 00000001 f895c5d0
00000008
       00000009 00000000 00000000 dc4bb138 dc4bb0e8 00000000 07fffff8
00000000
       00007730 00000000 dc4bb0e8 ed01000a 07fffff8 00000000 08015ff8
00000000
Call Trace:
 [<f89435a8>] extBalloc+0xf6/0x231 [jfs]
 [<c01772b3>] __mark_inode_dirty+0x1df/0x1e4
 [<f89432d1>] extAlloc+0x41d/0x45b [jfs]
 [<f8928344>] jfs_get_blocks+0x2d8/0x356 [jfs]
 [<c014bc90>] find_extend_vma+0x29/0x7e
 [<c0179d28>] get_more_blocks+0x12d/0x157
 [<c017a523>] do_direct_IO+0x351/0x3e8
 [<c0179ad1>] dio_bio_complete+0xb1/0xf2
 [<c017a7ea>] direct_io_worker+0x230/0x5e6
 [<c017ad94>] __blockdev_direct_IO+0x1f4/0x2da
 [<f892806c>] jfs_get_blocks+0x0/0x356 [jfs]
 [<f8928543>] jfs_direct_IO+0x76/0x82 [jfs]
 [<f892806c>] jfs_get_blocks+0x0/0x356 [jfs]
 [<c013c0d4>] generic_file_direct_IO+0x79/0x93
 [<c013bb06>] generic_file_aio_write_nolock+0x85a/0xb29
 [<c023f522>] copy_from_user+0x4a/0x74
 [<c02702c8>] opost+0xd0/0x20b
 [<c0400a73>] skb_to_sgvec+0x208/0x21e
 [<c0272b62>] write_chan+0x176/0x239
 [<c013be49>] generic_file_write_nolock+0x74/0x8c
 [<c013bf59>] generic_file_write+0x56/0x6e
 [<c0153f47>] vfs_write+0xbc/0x127
 [<c023f4c8>] copy_to_user+0x3e/0x4e
 [<c0154083>] sys_write+0x51/0x80
 [<c0105e47>] syscall_call+0x7/0xb
Code: 0f 0b a5 06 0a 2b 95 f8 8b 6c 24 2c 31 db 83 c5 20 0f b6 45


--

James Spooner, BCMS                     email: james@endace.com
Appliance Division                      voice:   +64 7 834 6721
Endace Technology                         fax:   +64 7 858 5095
Hamilton, New Zealand                  mobile:   +64 2 144 7638

