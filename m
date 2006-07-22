Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbWGVD06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbWGVD06 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 23:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWGVD06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 23:26:58 -0400
Received: from tara2.wa.amnet.net.au ([203.161.126.21]:10382 "EHLO
	tara2.wa.amnet.net.au") by vger.kernel.org with ESMTP
	id S1751222AbWGVD05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 23:26:57 -0400
Date: Sat, 22 Jul 2006 11:25:33 +0800
From: Michael Deegan <michael@ucc.gu.uwa.edu.au>
To: linux-kernel@vger.kernel.org
Subject: BUG: lock held at task exit time!
Message-ID: <20060722032533.GZ3874@wibble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Subliminal-Message: .yenom em dneS .tsixe ton od segassem lanimilbuS
X-ICQ-UIN: 562440
X-Random-Number: 0
User-Agent: Mutt/1.5.11+cvs20060403
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: michael@wibble
X-SA-Exim-Scanned: No (on localhost.localdomain); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I think somehere might be interested in this, though I'm not sure who. I do
not have the knowledge to say whether it originates within ext3, VFS, or
elsewhere.

Anyway, I discovered an OOPS spammed into my ssh sessions to this machine,
and kern.log contained:

Jul 22 06:26:55 localhost kernel: EXT3-fs error (device sda2): ext3_readdir: bad entry in directory #691212: directory entry across blocks - offset=12, inode=691211, rec_len=12320, name_len=2
Jul 22 06:26:55 localhost kernel: Remounting filesystem read-only
Jul 22 06:27:47 localhost kernel: Unable to handle kernel paging request at virtual address 0017e95a
Jul 22 06:27:47 localhost kernel:  printing eip:
Jul 22 06:27:47 localhost kernel: c01502c1
Jul 22 06:27:47 localhost kernel: *pde = 00000000
Jul 22 06:27:47 localhost kernel: Oops: 0000 [#1]
Jul 22 06:27:47 localhost kernel: Modules linked in: i2c_via dm_mod
Jul 22 06:27:47 localhost kernel: CPU:    0
Jul 22 06:27:47 localhost kernel: EIP:    0060:[<c01502c1>]    Not tainted VLI
Jul 22 06:27:47 localhost kernel: EFLAGS: 00010203   (2.6.16.18 #1)
Jul 22 06:27:47 localhost kernel: EIP is at __d_find_alias+0x14/0x9a
Jul 22 06:27:47 localhost kernel: eax: 00008000   ebx: 0017e95a   ecx: 0017e95a   edx: c73ed128
Jul 22 06:27:47 localhost kernel: esi: 00000000   edi: c73ec0ec   ebp: c73ed110   esp: c4d0ede4
Jul 22 06:27:47 localhost kernel: ds: 007b   es: 007b   ss: 0068
Jul 22 06:27:47 localhost kernel: Process find (pid: 27598, threadinfo=c4d0e000 task=c63eba90)
Jul 22 06:27:47 localhost kernel: Stack: <0>00000001 c73ed110 c6c0b878 c6c0b878 c73ed364 c0150743 c73ed110 c13eb600
Jul 22 06:27:47 localhost kernel:        c6c0b878 c017145b c3c67818 c03d65e0 c6c0b878 c73ed2f4 c0148d04 c4d0ee70
Jul 22 06:27:47 localhost kernel:        c4d0ee64 c4d0ef1c c1145da0 95ca2dfe c73ed2f4 c67f2000 c4d0ef1c c0149435
Jul 22 06:27:47 localhost kernel: Call Trace:
Jul 22 06:27:47 localhost kernel:  [<c0150743>] d_splice_alias+0x19/0xb2
Jul 22 06:27:47 localhost kernel:  [<c017145b>] ext3_lookup+0x72/0x77
Jul 22 06:27:47 localhost kernel:  [<c0148d04>] do_lookup+0xa3/0x137
Jul 22 06:27:47 localhost kernel:  [<c0149435>] __link_path_walk+0x69d/0xa77
Jul 22 06:27:47 localhost kernel:  [<c01525ef>] mntput_no_expire+0x11/0x52
Jul 22 06:27:47 localhost kernel:  [<c01498be>] link_path_walk+0xaf/0xb9
Jul 22 06:27:47 localhost kernel:  [<c0359f7c>] __mutex_lock_slowpath+0x1d0/0x276
Jul 22 06:27:47 localhost kernel:  [<c0149856>] link_path_walk+0x47/0xb9
Jul 22 06:27:47 localhost kernel:  [<c0149c74>] do_path_lookup+0x17f/0x19f
Jul 22 06:27:47 localhost kernel:  [<c014a15a>] __user_walk_fd+0x2a/0x3f
Jul 22 06:27:47 localhost kernel:  [<c0144f65>] vfs_lstat_fd+0x12/0x39
Jul 22 06:27:47 localhost kernel:  [<c01455e9>] sys_lstat64+0xf/0x23
Jul 22 06:27:47 localhost kernel:  [<c0102409>] syscall_call+0x7/0xb
Jul 22 06:27:47 localhost kernel: Code: 8d 4b c4 8b 59 3c 8d 74 26 00 8d 51 3c 8d 46 18 39 c2 75 96 5b 5e c3 55 89 c5 57 56 31 f6 53 51 89 14 24 8b 48 18 8d 50 18 eb 53 <8b> 19 8d 74 26 00 0f b7 45 28 8d 79 c4 25 00 f0 00 00 3d 00 40
Jul 22 06:27:47 localhost kernel:  BUG: find/27598, lock held at task exit time!
Jul 22 06:27:47 localhost kernel:  [c73ed364] {inode_init_once}
Jul 22 06:27:47 localhost kernel: .. held by:              find:27598 [c63eba90, 126]
Jul 22 06:27:47 localhost kernel: ... acquired at:               do_lookup+0x69/0x137

/dev/sda2 is my root partition. Fortunately /var was on a different partition.
Unsurprisingly the root partition contains errors:

    Pass 1: Checking inodes, blocks, and sizes
    Inode 114510 has illegal block(s).  Clear? no

    Illegal block #8 (3342783228) in inode 114510.  IGNORED.
    Inodes that were part of a corrupted orphan linked list found.  Fix? no

    Inode 318876 was part of the orphaned inode list.  IGNORED.
    Inode 351606 was part of the orphaned inode list.  IGNORED.
    Inode 491835 was part of the orphaned inode list.  IGNORED.
    Deleted inode 556073 has zero dtime.  Fix? no

I am of course assuming that the mere presence of filesystem errors
shouldn't cause the kernel to oops.

Output of ver_linux (keeping in mind I can't tell what has been apt-get
upgraded since the kernel was compiled):

    Linux plugh 2.6.16.18 #1 Sun May 28 01:17:17 WST 2006 i586 GNU/Linux

    Gnu C                  4.0.4
    Gnu make               3.81
    binutils               2.17
    util-linux             2.12r
    mount                  2.12r
    module-init-tools      3.2.2
    e2fsprogs              1.39
    reiserfsprogs          line
    reiser4progs           line
    PPP                    2.4.4b1
    Linux C Library        2.3.6
    Dynamic linker (ldd)   2.3.6
    Procps                 3.2.7
    Net-tools              1.60
    Console-tools          0.2.3
    Sh-utils               5.96
    Modules Loaded         i2c_via dm_mod

The machine is my household webserver (128MiB K6II-500, Debian
testing/etch). It is still performing normally, despite a read only root fs
(including /tmp). I'm happy to keep the machine in this state if further
diagnostics are required; otherwise I'll eventually just build a new kernel
and reboot it.

I'm not on the list, so please CC replies (though I'll probably check the
archives from time to time anyway).

Thanks,

-MD

-- 
-------------------------------------------------------------------------------
Michael Deegan           Hugaholic          http://wibble.darktech.org/gallery/
------------------------- Nyy Tybel Gb Gur Ulcabgbnq! -------------------------
