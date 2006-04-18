Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbWDRAAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbWDRAAp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 20:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932075AbWDRAAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 20:00:45 -0400
Received: from kevlar.burdell.org ([66.92.73.214]:47799 "EHLO
	kevlar.burdell.org") by vger.kernel.org with ESMTP id S932074AbWDRAAo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 20:00:44 -0400
Date: Mon, 17 Apr 2006 20:00:42 -0400
From: Sonny Rao <sonny@burdell.org>
To: linux-kernel@vger.kernel.org
Cc: anton@samba.org
Subject: BUG: spinlock lockup/wrong CPU/recursion -- when reading numa_maps on 2.6.17-rc1
Message-ID: <20060418000042.GA7376@kevlar.burdell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I ran into a deadlock on 2.6.16-mm2 when I was running a
multi-threaded application and was reading /proc/<pid>/numa_maps for
the app. 

I recompiled with DEBUG_SPINLOCK and I can get various error messages
on kernels ranging from 2.6.17-rc1 to serveral mm kernels including
2.6.16-mm[12] and 2.6.16-rc5-mm[23] (mm kernels before this seem to break
a lot on my box)

My current guess, based on my rudimentary understanding of the code, is
that  we are rescheduling while holding a spinlock in
check_pte_range() which is called from show_numa_map() in mempolicy.c.  

Specifically, the gather_stats() function which is called inside
check_pte_range() has a cond_resched() at the end.  Maybe that line
should be changed to cond_resched_lock() or should simply be removed.   

I'll try removing it and see what happens.

To reproduce: I run my multi-threaded application in a loop and run
another loop which cats the numa_maps file for the currently running
instance of my application.

Here are some messages from some kernels

2.6.17-rc1:

Message from syslogd@iceberg at Sat Apr 15 23:53:52 2006 ...
iceberg kernel: BUG: spinlock lockup on CPU#0, test-sr6/1362,
c000000d97b46b50

Message from syslogd@iceberg at Sat Apr 15 23:53:57 2006 ...
iceberg kernel: BUG: spinlock lockup on CPU#16, cat/1673,
c000000d97b46b50

cpu 0x10: Vector: 501 (Hardware Interrupt) at [c0000005ac7776a0]
    pc: c00000000001e6a4: .__delay+0x4/0x30
    lr: c000000000215318: ._raw_spin_lock+0xfc/0x18c
    sp: c0000005ac777920
   msr: 8000000000009032
  current = 0xc0000005ad58a040
  paca    = 0xc000000000568180
    pid   = 1673, comm = cat
10:mon> t
[link register   ] c000000000215318 ._raw_spin_lock+0xfc/0x18c
[c0000005ac777920] c000000000215364 ._raw_spin_lock+0x148/0x18c (unreliable)
[c0000005ac7779b0] c000000000455f30 ._spin_lock+0x10/0x24
[c0000005ac777a30] c0000000000a5724 .check_pte_range+0xb4/0x1b8
[c0000005ac777af0] c0000000000a5c88 .show_numa_map+0x460/0x6a4
[c0000005ac777c20] c0000000000e2534 .seq_read+0x2f4/0x450
[c0000005ac777d00] c0000000000b6fd4 .vfs_read+0xe0/0x1b0
[c0000005ac777d90] c0000000000b71ac .sys_read+0x54/0x98
[c0000005ac777e30] c00000000000871c syscall_exit+0x0/0x40
--- Exception: c01 (System Call) at 000000000ff69164



2.6.16-mm2:

Message from syslogd@iceberg at Sat Apr 15 22:18:15 2006 ...
iceberg kernel: BUG: spinlock cpu recursion on CPU#0, test-sr6/4566

Message from syslogd@iceberg at Sat Apr 15 22:18:15 2006 ...
iceberg kernel:  lock: c0000001b7f71510, .magic: dead4ead, .owner:
cat/4871, .owner_cpu: 0

BUG: spinlock lockup on CPU#0, test-sr6/4566, c0000001b7f71510
Call Trace:
[C0000001AF5C7970] [C00000000000E6B0] .show_stack+0x74/0x1b4 (unreliable)
[C0000001AF5C7A20] [C00000000021A9DC] ._raw_spin_lock+0x148/0x18c
[C0000001AF5C7AB0] [C000000000461168] ._spin_lock+0x10/0x24
[C0000001AF5C7B30] [C0000000000994FC] .__handle_mm_fault+0xde4/0xf04
[C0000001AF5C7C30] [C000000000462CF8] .do_page_fault+0x540/0x810
[C0000001AF5C7E30] [C000000000004860] .handle_page_fault+0x20/0x54
BUG: spinlock lockup on CPU#8, cat/4872, c0000001b7f71510
Call Trace:
[C000000F7F923870] [C00000000000E6B0] .show_stack+0x74/0x1b4 (unreliable)
[C000000F7F923920] [C00000000021A9DC] ._raw_spin_lock+0x148/0x18c
[C000000F7F9239B0] [C000000000461168] ._spin_lock+0x10/0x24
[C000000F7F923A30] [C0000000000AA398] .check_pte_range+0xb4/0x1b8
[C000000F7F923AF0] [C0000000000AA8FC] .show_numa_map+0x460/0x69c
[C000000F7F923C20] [C0000000000E752C] .seq_read+0x2f4/0x450
[C000000F7F923D00] [C0000000000BBF70] .vfs_read+0xe0/0x1b0
[C000000F7F923D90] [C0000000000BC148] .sys_read+0x54/0x98
[C000000F7F923E30] [C00000000000871C] syscall_exit+0x0/0x40


2.6.16-mm1

Message from syslogd@iceberg at Mon Apr 17 14:40:51 2006 ...
iceberg kernel: BUG: spinlock wrong CPU on CPU#16, cat/30761

Message from syslogd@iceberg at Mon Apr 17 14:40:51 2006 ...
iceberg kernel:  lock: c000000ba7b6d450, .magic: dead4ead, .owner:
cat/30761, .owner_cpu: 18

BUG: spinlock wrong CPU on CPU#16, cat/30761
 lock: c000000ba7b6d450, .magic: dead4ead, .owner: cat/30761,
.owner_cpu: 18
Call Trace:
[C0000001AE3F37F0] [C00000000000E8D8] .show_stack+0x74/0x1b4 (unreliable)
[C0000001AE3F38A0] [C00000000021896C] .spin_bug+0xcc/0xec
[C0000001AE3F3930] [C000000000218A14] ._raw_spin_unlock+0x88/0xbc
[C0000001AE3F39B0] [C00000000045F920] ._spin_unlock+0x10/0x24
[C0000001AE3F3A30] [C0000000000A83C4] .check_pte_range+0x170/0x1b8
[C0000001AE3F3AF0] [C0000000000A886C] .show_numa_map+0x460/0x69c
[C0000001AE3F3C20] [C0000000000E56F8] .seq_read+0x2f4/0x450
[C0000001AE3F3D00] [C0000000000B9ED8] .vfs_read+0xe0/0x1b0
[C0000001AE3F3D90] [C0000000000BA0B0] .sys_read+0x54/0x98
[C0000001AE3F3E30] [C00000000000871C] syscall_exit+0x0/0x40


Sonny
