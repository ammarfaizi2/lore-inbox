Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318366AbSGYIzC>; Thu, 25 Jul 2002 04:55:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318369AbSGYIzC>; Thu, 25 Jul 2002 04:55:02 -0400
Received: from sunny.pacific.net.au ([203.25.148.40]:33510 "EHLO
	sunny.pacific.net.au") by vger.kernel.org with ESMTP
	id <S318366AbSGYIzB>; Thu, 25 Jul 2002 04:55:01 -0400
From: "David Luyer" <david@luyer.net>
To: <linux-kernel@vger.kernel.org>
Subject: Linux-2.4.18-rc3-ac3: bug with using whole disks as filesystems
Date: Thu, 25 Jul 2002 18:58:12 +1000
Message-ID: <004901c233b9$680612b0$638317d2@pacific.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I attempted to mkfs and use a whole disk rather than a partition
with reiserfs.  It failed (not a major problem, I'll just make a
partition), but it failed with a "kernel BUG" message, so here 'tis.

A subsequent attempt to cfdisk the same disk hung and refused
to die even with a kill -9.

Here's the hung cfdisk (fdisk could touch the disk while this
is hung).

root@praxis8:~# ps lx | grep cfdisk
100     0   469   312  15   0  1852  692 rwsem_ D    pts/0      0:00
cfdisk /dev/sdb
100     0   513   476  16   0  1336  428 pipe_w S    pts/1      0:00
grep cfdisk

After reboot everything worked fine.

Original commands to cause failure:
  mkfs -b 8192 /dev/sdb -f
  mount /dev/sdb /cache

/dev/sdb is an IBM ServeRAID array, of 4x36Gb/2=72Gb.

Jul 25 18:48:03 praxis8 kernel: kernel BUG at buffer.c:2511!
Jul 25 18:48:03 praxis8 kernel: invalid operand: 0000
Jul 25 18:48:03 praxis8 kernel: CPU:    0
Jul 25 18:48:03 praxis8 kernel: EIP:    0010:[grow_buffers+86/276]
Not tainted
Jul 25 18:48:03 praxis8 kernel: EFLAGS: 00010206
Jul 25 18:48:03 praxis8 kernel: eax: 00001e00   ebx: 00000008   ecx:
00000200   edx: f7932800
Jul 25 18:48:03 praxis8 kernel: esi: 00000010   edi: 00000810   ebp:
00000008   esp: f503fdbc
Jul 25 18:48:03 praxis8 kernel: ds: 0018   es: 0018   ss: 0018
Jul 25 18:48:03 praxis8 kernel: Process mount (pid: 466,
stackpage=f503f000)
Jul 25 18:48:03 praxis8 kernel: Stack: 00000810 00002000 00000008
f644a000 0000d100 c01387db 00000810 00000008
Jul 25 18:48:03 praxis8 kernel:        00002000 f2473280 f7558400
f7558400 c01389ec 00000810 00000008 00002000
Jul 25 18:48:03 praxis8 kernel:        f24732cc c018c94c 00000810
00000008 00002000 c018235b f7558400 00000008
Jul 25 18:48:03 praxis8 kernel: Call Trace:    [getblk+39/64]
[bread+24/112] [reiserfs_bread+24/28] [read_super_block+383/856]
[reiserfs_read_super+165/1124]
Jul 25 18:48:03 praxis8 kernel:   [get_sb_bdev+464/584]
[alloc_vfsmnt+118/160] [do_kern_mount+85/260] [do_add_mount+105/312]
[do_mount+326/352] [copy_mount_options+85/164]
Jul 25 18:48:03 praxis8 kernel:   [sys_mount+175/272]
[system_call+51/56]
Jul 25 18:48:03 praxis8 kernel:
Jul 25 18:48:03 praxis8 kernel: Code: 0f 0b cf 09 36 68 23 c0 b9 ff ff
ff ff 89 fa b6 00 90 8d 74

David.
--
David Luyer                                     Phone:   +61 3 9674 7525
Network Development Manager    P A C I F I C    Fax:     +61 3 9699 8693
Pacific Internet (Australia)  I N T E R N E T   Mobile:  +61 4 1111 BYTE
http://www.pacific.net.au/                      NASDAQ:  PCNTF

