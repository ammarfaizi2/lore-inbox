Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266481AbUIXBL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266481AbUIXBL2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 21:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267598AbUIXBIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 21:08:21 -0400
Received: from citi.umich.edu ([141.211.133.111]:49189 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S267730AbUIXBDh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 21:03:37 -0400
Date: Thu, 23 Sep 2004 21:03:36 -0400 (EDT)
From: Chuck Lever <cel@citi.umich.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: hit BUG_ON in dev_queue_xmit
Message-ID: <Pine.BSO.4.58.0409232020270.28375@citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i enabled page alloc debugging in 2.6.9-rc2.... and hit this BUG.  i was
running fsx-odirect, but the callback here shows we are in the normal NFS
cached async write path.  a second panic shows we hit this in the NFS
readdir path too, so i suspect this is independent of the NFS client.

dual CPU 1.26GHz P-III system with 1GB RAM.


kernel BUG at include/asm/spinlock.h:90!
invalid operand: 0000 [#1]
SMP DEBUG_PAGEALLOC
Modules linked in:
CPU:    1
EIP:    0060:[<c0396f06>]    Not tainted VLI
EFLAGS: 00010202   (2.6.9-rc2)
EIP is at _spin_unlock+0x16/0x30
eax: 00000001   ebx: 00000000   ecx: 00000002   edx: f7eb693c
esi: f7eb6800   edi: f7eb693c   ebp: d89d1060   esp: f70a7bb4
ds: 007b   es: 007b   ss: 0068
Process fsx-odirect (pid: 924, threadinfo=f70a7000 task=f75cf6d0)
Stack: c03305bb f7eb6800 c1adfc80 c1aa0174 c1aa018c f7f2b210 c034478d
d89d1060
       f70a7d10 00000090 c1aa0160 f70a7c1c f6baf040 d89d1060 f6baf1bc
c0346922
       d89d1060 f70a7d10 f6aeaac4 c037fe1e f6aeabb8 00000000 40000206
00000040
Call Trace:
 [<c03305bb>] dev_queue_xmit+0x1db/0x280
 [<c034478d>] ip_finish_output+0xbd/0x1c0
 [<c0346922>] ip_push_pending_frames+0x2e2/0x430
 [<c037fe1e>] rpc_sleep_on+0x3e/0x60
 [<c036512e>] udp_push_pending_frames+0x14e/0x280
 [<c0365b0e>] udp_sendpage+0xde/0x150
 [<c01264e5>] update_process_times+0x45/0x60
 [<c011ad50>] autoremove_wake_function+0x0/0x60
 [<c036d7f7>] inet_sendpage+0x67/0xd0
 [<c036d790>] inet_sendpage+0x0/0xd0
 [<c03941f9>] xprt_sock_udp_send_request+0x2b9/0x360
 [<c01d0300>] nfs3_xdr_writeargs+0x120/0x130
 [<c01d01e0>] nfs3_xdr_writeargs+0x0/0x130
 [<c037ebdf>] xprt_transmit+0x4f/0x200
 [<c037d4d2>] call_transmit+0x52/0xc0
 [<c03803f1>] __rpc_execute+0x101/0x4c0
 [<c037ce12>] rpc_call_setup+0x52/0x80
 [<c037cb91>] rpc_clnt_sigmask+0x91/0xb0
 [<c01cc418>] nfs_execute_write+0x58/0xa0
 [<c01cc60c>] nfs_flush_multi+0x1ac/0x270
 [<c01cb250>] nfs_writepage+0x0/0x240
 [<c01cc95b>] nfs_flush_list+0x6b/0xf0
 [<c01cd5ae>] nfs_flush_inode+0x9e/0xb0
 [<c01cb52d>] nfs_writepages+0x9d/0x150
 [<c013f205>] do_writepages+0x25/0x50
 [<c0138930>] __filemap_fdatawrite_range+0xc0/0xd0
 [<c0138977>] filemap_fdatawrite+0x37/0x40
 [<c014d9f5>] msync_interval+0xb5/0x110
 [<c014db98>] sys_msync+0x148/0x152
 [<c01044af>] syscall_call+0x7/0xb
Code: 28 01 79 05 e8 98 ef ff ff c3 0f 0b c7 00 4e bb 3a c0 eb ea 90 81 78
04 ad 4e ad de 89 c2 75 15 0f b6 02 84 c0 7f 04 c6 02 01 c3 <0f> 0b 5a 00
4e bb 3a c0 eb f2 0f 0b 59 00 4e bb 3a c0 eb e1 8d
 <0>Kernel panic - not syncing: Fatal exception in interrupt


	- Chuck Lever
--
corporate:	<cel at netapp dot com>
personal:	<chucklever at bigfoot dot com>
