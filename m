Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269303AbUIYKpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269303AbUIYKpn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 06:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269304AbUIYKpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 06:45:43 -0400
Received: from lucidpixels.com ([66.45.37.187]:36313 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S269303AbUIYKpi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 06:45:38 -0400
Date: Sat, 25 Sep 2004 06:45:36 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: linux-kernel@vger.kernel.org
Subject: Reproducable DoS with NFS+XFS under 2.6.{5,8.1}
Message-ID: <Pine.LNX.4.61.0409250642050.19470@p500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Two issues.

1 - With 2.6.5
2 - With 2.6.8.1

1 - I have the actual oops.
2 - Reproducable every time I do it but I'd have to copy the panic off the
     screen which isn't entirely there.


Problem 1: If you try to copy a file off of an NFS share while it is being 
written:

------------[ cut here ]------------
kernel BUG at fs/xfs/support/debug.c:106!
invalid operand: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<c02751a4>]    Not tainted
EFLAGS: 00010246   (2.6.5)
EIP is at cmn_err+0xa4/0xc0
eax: 00000000   ebx: ee5a4000   ecx: c0536d24   edx: c0473e98
esi: c042a9c9   edi: c054bb9e   ebp: 00000000   esp: ee5a5a30
ds: 007b   es: 007b   ss: 0068
Process nfsd (pid: 263, threadinfo=ee5a4000 task=ee5dc6c0)
Stack: c043f961 c042cc0b c054bb60 00000293 ee5a4000 04f93a8f 00000000
e31d1a60
        c02418f7 00000000 c0437320 ee39b8e0 ee39b360 04f93a8f ee5a4000
00000000
        ef3fd51c efa42a00 c0274c02 ef4b4698 00000000 00000000 e31d1a60
ee39b37c
Call Trace:
  [<c02418f7>] xfs_iget_core+0x4a7/0x590
  [<c0274c02>] vn_initialize+0x92/0xb0
  [<c0241afa>] xfs_iget+0x11a/0x150
  [<c0261533>] xfs_vget+0x63/0x100
  [<c02744b3>] vfs_vget+0x43/0x50
  [<c0273e11>] linvfs_get_dentry+0x51/0x90
  [<c01b1f5d>] find_exported_dentry+0x3d/0x700
  [<c02e4885>] e1000_alloc_rx_buffers+0x65/0x110
  [<c02e44b5>] e1000_clean_rx_irq+0x105/0x470
  [<c02e4187>] e1000_clean+0x97/0xc0
  [<c0342df4>] net_rx_action+0x74/0x100
  [<c033dd77>] alloc_skb+0x47/0xf0
  [<c033d3d7>] sock_alloc_send_pskb+0xc7/0x1d0
  [<c033d50d>] sock_alloc_send_skb+0x2d/0x40
  [<c03b2001>] do_bindings+0x91/0x2e0
  [<c0342759>] dev_queue_xmit+0x209/0x2a0
  [<c0375194>] ip_finish_output2+0xa4/0x1b0
  [<c03750f0>] ip_finish_output2+0x0/0x1b0
  [<c034cf73>] nf_hook_slow+0xf3/0x140
  [<c01ba74a>] exp_find_key+0x8a/0xa0
  [<c01b29cd>] export_decode_fh+0x5d/0x7a
  [<c01b4c70>] nfsd_acceptable+0x0/0x120
  [<c01b4f70>] fh_verify+0x1e0/0x5a0
  [<c01b4c70>] nfsd_acceptable+0x0/0x120
  [<c0116faf>] scheduler_tick+0x1f/0x520
  [<c01b67f9>] nfsd_open+0x39/0x150
  [<c01b6f7d>] nfsd_write+0x5d/0x360
  [<c010971b>] do_IRQ+0xfb/0x130
  [<c013b190>] cache_flusharray+0x50/0x100
  [<c033df74>] kfree_skbmem+0x24/0x30
  [<c033dff7>] __kfree_skb+0x77/0x100
  [<c03ff104>] svcauth_unix_accept+0x274/0x2c0
  [<c01be608>] nfsd3_proc_write+0xb8/0x120
  [<c01b30d8>] nfsd_dispatch+0xd8/0x1e0
  [<c01b3000>] nfsd_dispatch+0x0/0x1e0
  [<c03fb2f8>] svc_process+0x4b8/0x620
  [<c01b2e46>] nfsd+0x206/0x3c0
  [<c01b2c40>] nfsd+0x0/0x3c0
  [<c0104f0d>] kernel_thread_helper+0x5/0x18

Code: 0f 0b 6a 00 2b cc 42 c0 83 c4 10 5b 5e 5f 5d c3 e8 c7 28 ea
  <6>note: nfsd[263] exited with preempt_count 1

And then NFS stops working.

Problem 2:

I can re-produce this every time I try it.

% removepkg kde* x11*
% cd /nfs/slackware-10.0/slackware
% installpkg k/*tgz x11*tgz

It gets to the following package:
Installing package kdebase-3.2.3-i486-1 ([required])...
Then PANICS the 2.6.8.1 kernel!!!

If I ftp the packages over, it is fine, no problems at all.


