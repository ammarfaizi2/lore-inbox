Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272014AbTG2TGO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 15:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272042AbTG2TGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 15:06:14 -0400
Received: from genericorp.net ([64.191.13.250]:55700 "EHLO
	nofrills.genericorp.net") by vger.kernel.org with ESMTP
	id S272014AbTG2TF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 15:05:57 -0400
Message-ID: <34018.204.17.42.117.1059505497.squirrel@www.genericorp.net>
Date: Tue, 29 Jul 2003 12:04:57 -0700 (MST)
Subject: Oops from tun module
From: "Dave O" <cxreg@pobox.com>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.0
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I added a tun/tap interface using tunctl(8) from the user-mode-linux
project under 2.6.0-test1, which created a device tap0, owned by user 1000
(tunctl -u 1000).  In doing so, the tun module was automatically loaded,
but showed a refcount of 0 in lsmod.  I was able to successfully "rmmod
tun", but after doing this every program that tried to open /proc/net/dev
(including ifconfig) immediately segfaults and causes an Oops.  I was able
to modprobe tun.o back in and that restored sane behavior.  I imagine the
module should have had it's refcount incremented when the device is
created.

Steps to reproduce:

meatloop:/home/daveo# tunctl
Set 'tap0' persistent and owned by uid 0
meatloop:/home/daveo# rmmod tun
meatloop:/home/daveo# ifconfig
Segmentation fault

Oops is as follows:

Unable to handle kernel paging request at virtual address e08b3115
 printing eip:
e08b3115
*pde = 01574067
*pte = 00000000
Oops: 0000 [#7]
CPU:    0
EIP:    0060:[<e08b3115>]    Not tainted
EFLAGS: 00010282
EIP is at 0xe08b3115
eax: e08b3115   ebx: dfcd5000   ecx: c043ec76   edx: 00000000
esi: deb7e240   edi: dfcd5000   ebp: d8c91f04   esp: d8c91eac
ds: 007b   es: 007b   ss: 0068
Process ifconfig (pid: 744, threadinfo=d8c90000 task=daa7c180)
Stack: c03767fc dfcd5000 c043ec20 dfcd5c00 00001898 00000040 00000000
00000000
       00000000 00000000 00000000 00000000 00001075 00000031 00000000
00000000
       00000000 00000000 00000000 00000000 deb7e240 deb7e240 d8c91f24
c0376829
Call Trace:
 [<c03767fc>] dev_seq_printf_stats+0xdd/0xe4
 [<c0376829>] dev_seq_show+0x26/0x77
 [<c01671f4>] seq_read+0x1d0/0x2f7
 [<c014a038>] vfs_read+0xc5/0x12f
 [<c014a2c4>] sys_read+0x3f/0x5d
 [<c01090d3>] syscall_call+0x7/0xb

Code:  Bad EIP value.
 <6>note: ifconfig[744] exited with preempt_count 1
bad: scheduling while atomic!
Call Trace:
 [<c011640c>] schedule+0x3ab/0x3b0
 [<c013bc7c>] unmap_page_range+0x41/0x67
 [<c013be57>] unmap_vmas+0x1b5/0x20b
 [<c013f829>] exit_mmap+0x7a/0x18c
 [<c0114b20>] do_page_fault+0x0/0x4cc
 [<c0117e18>] mmput+0x67/0xb5
 [<c011b9f5>] do_exit+0xf5/0x4ab
 [<c0114b20>] do_page_fault+0x0/0x4cc
 [<c01098c8>] do_divide_error+0x0/0xdd
 [<c0114c4e>] do_page_fault+0x12e/0x4cc
 [<c016290d>] get_new_inode_fast+0x41/0xe7
 [<c0130867>] find_get_page+0x2c/0x53
 [<c0249f8a>] vsnprintf+0x231/0x43b
 [<c0114b20>] do_page_fault+0x0/0x4cc
 [<c010927d>] error_code+0x2d/0x38
 [<c03767fc>] dev_seq_printf_stats+0xdd/0xe4
 [<c0376829>] dev_seq_show+0x26/0x77
 [<c01671f4>] seq_read+0x1d0/0x2f7
 [<c014a038>] vfs_read+0xc5/0x12f
 [<c014a2c4>] sys_read+0x3f/0x5d
 [<c01090d3>] syscall_call+0x7/0xb



