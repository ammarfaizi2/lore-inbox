Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263864AbUE1UQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263864AbUE1UQP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 16:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263876AbUE1UQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 16:16:15 -0400
Received: from potato.cts.ucla.edu ([149.142.36.49]:53421 "EHLO
	potato.cts.ucla.edu") by vger.kernel.org with ESMTP id S263864AbUE1UP6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 16:15:58 -0400
Date: Fri, 28 May 2004 13:15:48 -0700 (PDT)
From: Chris Stromsoe <cbs@cts.ucla.edu>
To: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Dave Kleikamp <shaggy@austin.ibm.com>
Subject: oops, 2.4.26 and jfs
Message-ID: <Pine.LNX.4.58.0405281307550.18184@potato.cts.ucla.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This morning during a cron run while doing a find across /, I got the
following oops.

There is only the one jfs partition on the machine It has 607376 inodes in
use out of 17524128 total, and 27350660 bytes out of 35806700.  The
partition is on top of a 3-disk md RAID5 that is under constant pressure
(it's a virus quarantine).  All processes trying to do anything with the
partition are stuck in D state.

Right before the oops, I logged:

May 26 06:28:10 begonia kernel: __alloc_pages: 0-order allocation failed (gfp=0x1f0/0)
May 26 06:28:11 begonia last message repeated 3 times
May 26 06:28:11 begonia kernel: __alloc_pages: 0-order allocation failed (gfp=0x1d0/0)
May 27 06:29:13 begonia kernel: __alloc_pages: 0-order allocation failed (gfp=0x1f0/0)
May 27 06:29:24 begonia last message repeated 3 times
May 28 06:28:44 begonia kernel: __alloc_pages: 1-order allocation failed (gfp=0x1f0/0)
May 28 06:28:45 begonia kernel: __alloc_pages: 0-order allocation failed (gfp=0x1f0/0)
May 28 06:28:50 begonia last message repeated 3 times
May 28 06:28:50 begonia kernel: __alloc_pages: 1-order allocation failed (gfp=0x1f0/0)
May 28 06:28:50 begonia kernel: __alloc_pages: 0-order allocation failed (gfp=0x1d0/0)

I don't have correct modules or System.map output; I rebuilt the
kernel/modules/system.map yesterday to prepare for a reboot, and
over-wrote the System.map and modules with the new files.


-Chris


cbs@begonia:~ > ksymoops -L -M < oops
ksymoops 2.4.5 on i686 2.4.26.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -L (specified)
     -o /lib/modules/2.4.26/ (default)
     -M (specified)

Warning (expand_objects): object
/lib/modules/2.4.26/kernel/drivers/net/eepro100.o for module eepro100 has changed since load
Warning (expand_objects): object /lib/modules/2.4.26/kernel/drivers/net/mii.o for module mii has changed since load
May 28 06:28:50 begonia kernel: BUG at jfs_txnmgr.c:2849 assert(log)
May 28 06:28:50 begonia kernel: kernel BUG at jfs_txnmgr.c:2849!
May 28 06:28:50 begonia kernel: invalid operand: 0000
May 28 06:28:50 begonia kernel: CPU:    1
May 28 06:28:50 begonia kernel: EIP:    0010:[LogSyncRelease+89/204]    Not tainted
May 28 06:28:50 begonia kernel: EFLAGS: 00010282
May 28 06:28:50 begonia kernel: eax: 00000028   ebx: c3fa74a0   ecx: ffffffff   edx: 00000002
May 28 06:28:50 begonia kernel: esi: 00000000   edi: f88054a8   ebp: ea595dbc   esp: ea595da4
May 28 06:28:50 begonia kernel: ds: 0018   es: 0018   ss: 0018
May 28 06:28:50 begonia kernel: Process mimedefang.pl (pid: 23467, stackpage=ea595000)
May 28 06:28:50 begonia kernel: Stack: c028fd4b c028fd3e 00000b21 c028fe80 00000107 000006ff ea595dd8 c01965ae
May 28 06:28:50 begonia kernel:        c3fa74a0 c8d128f0 f48827a0 00000000 00000102 ea595e40 c019521e ea595e04
May 28 06:28:50 begonia kernel:        f48827a0 00000000 00000102 00000001 ea595e1c f88054a8 f7ad3880 fffffffb
May 28 06:28:50 begonia kernel: Call Trace:    [txAbortCommit+82/172] [txCommit+686/700] [__mark_inode_dirty+51/172] [jfs_create+444/548] [__lru_cache_del+116/124]
May 28 06:28:50 begonia kernel: Code: 0f 0b 21 0b 3e fd 28 c0 83 c4 10 f0 ff 4b 48 8b 43 48 85 c0
Using defaults from ksymoops -t elf32-i386 -a i386


>>ebx; c3fa74a0 <_end+3c0cdac/3896e90c>
>>ecx; ffffffff <END_OF_CODE+72f05d4/????>
>>edi; f88054a8 <_end+3846adb4/3896e90c>
>>ebp; ea595dbc <_end+2a1fb6c8/3896e90c>
>>esp; ea595da4 <_end+2a1fb6b0/3896e90c>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a
Code;  00000002 Before first symbol
   2:   21 0b                     and    %ecx,(%ebx)
Code;  00000004 Before first symbol
   4:   3e                        ds
Code;  00000005 Before first symbol
   5:   fd                        std
Code;  00000006 Before first symbol
   6:   28 c0                     sub    %al,%al
Code;  00000008 Before first symbol
   8:   83 c4 10                  add    $0x10,%esp
Code;  0000000b Before first symbol
   b:   f0 ff 4b 48               lock decl 0x48(%ebx)
Code;  0000000f Before first symbol
   f:   8b 43 48                  mov    0x48(%ebx),%eax
Code;  00000012 Before first symbol
  12:   85 c0                     test   %eax,%eax


2 warnings issued.  Results may not be reliable.

