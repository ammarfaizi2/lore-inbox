Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279028AbRJ2F6F>; Mon, 29 Oct 2001 00:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279029AbRJ2F5y>; Mon, 29 Oct 2001 00:57:54 -0500
Received: from h24-78-175-24.nv.shawcable.net ([24.78.175.24]:15236 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S279028AbRJ2F5n>;
	Mon, 29 Oct 2001 00:57:43 -0500
Date: Sun, 28 Oct 2001 21:58:18 -0800
From: Simon Kirby <sim@netnation.com>
To: linux-kernel@vger.kernel.org, Jan Kara <jack@ucw.cz>
Subject: Oops: Quota race in 2.4.12?
Message-ID: <20011028215818.A7887@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some of our dual CPU web servers with 2.4.12 are Oopsing while running
quotacheck.  They don't seem to die immediately, but oops many times and
eventually break.  The old tools didn't warn about quotachecking on a
live file system, so some of our servers were set up to run quotacheck
nightly.  The new tools still allow you to do it, but warn that it may
not be consistent.  We didn't have any problems with 2.2 kernels.

First oops, as already processed (grumble) by klogd:

Oct 28 04:22:32 pro kernel: remove_free_dquot: dquot not on the free list??
Oct 28 04:22:32 pro last message repeated 90 times
Oct 28 04:22:32 pro kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000004
...dates stripped:

Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c0149edc
*pde = 00000000
Oops: 0002
CPU:    1
EIP:    0010:[dqput+148/188]    Not tainted
EFLAGS: 00010246
eax: d58c8830   ebx: cf330cc0   ecx: cf330cd0   edx: 00000000
esi: cf330cc0   edi: d2847f6c   ebp: 00000000   esp: d2847f30
ds: 0018   es: 0018   ss: 0018
Process quotacheck (pid: 3933, stackpage=d2847000)
Stack: 00000000 c014a93e cf330cc0 00006000 c1a58800 00000000 d2847fa4 00000000 
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 c014b8f0 
       c1a58800 0000f465 00000000 00000004 bffffd54 d2846000 bffffd54 001e8ca0 
Call Trace: [set_dqblk+390/404] [sys_quotactl+780/892] [sys_read+188/196] [system_call+51/56] 

Code: 89 4a 04 89 53 10 89 41 04 89 08 ff 05 e4 ab 34 c0 8d 43 24 

Perhaps there is some obviously broken locking/code in the quotactl syscall?

The next Oops, 6 seconds later:

 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c0149edc
*pde = 00000000
Oops: 0002
CPU:    1
EIP:    0010:[dqput+148/188]    Not tainted
EFLAGS: 00010246
eax: d58c8830   ebx: cf330c40   ecx: cf330c50   edx: 00000000
esi: d4a08ca4   edi: d4a08bc0   ebp: c36f5a40   esp: d16f5efc
ds: 0018   es: 0018   ss: 0018
Process mv (pid: 7146, stackpage=d16f5000)
Stack: 00000000 c014acda cf330c40 d16f4000 c1a58c00 c0155a8f d4a08bc0 d4a08bc0 
       d4a08bc0 c0156370 c36f5a40 c36f5a40 00000022 00000000 e2757480 c01563f7 
       c015641d d4a08bc0 d4a08bc0 d16f4000 c0146c19 d4a08bc0 c36f5a40 d4a08bc0 
Call Trace: [dquot_drop+54/68] [ext2_free_inode+231/616] [ext2_delete_inode+0/296] [ext2_delete_inode+135/296] [ext2_delete_inode+173/296] 
   [iput+389/600] [d_delete+98/160] [vfs_unlink+492/540] [sys_unlink+169/288] [system_call+51/56] 

Code: 89 4a 04 89 53 10 89 41 04 89 08 ff 05 e4 ab 34 c0 8d 43 24 

...Many more oopses follow over time.

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
