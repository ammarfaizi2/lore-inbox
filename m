Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265672AbTFNNvc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 09:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265674AbTFNNvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 09:51:32 -0400
Received: from franka.aracnet.com ([216.99.193.44]:2011 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S265672AbTFNNva
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 09:51:30 -0400
Date: Sat, 14 Jun 2003 07:05:14 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 805] New: umount an nfs volume hangs and oopses
Message-ID: <408350000.1055599514@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

           Summary: umount an nfs volume hangs and oopses
    Kernel Version: 2.5.70+bk (around 14 Jun, 10:00 CET)
            Status: NEW
          Severity: normal
             Owner: trond.myklebust@fys.uio.no
         Submitter: fork0@users.sf.net


Gentoo
mount-2.11y, gcc-3.2.2, nfs-utils-1.0.3
NFS server: Debian/unstable, 2.4.20, nfs-kernel-server-1.0.3-1
NFS as module.

Problem Description:
An attempt to umount an NFS mountpoint hangs the machine
for some time (some minutes), than umount oopses.

Steps to reproduce:
$ mount host:/oops /net/oops
$ umount /net/oops

umount        R current  4290083808  4426   4416                     (NOTLB)
Call Trace:
 [<dc919620>] nfs_sops+0x0/0x60 [nfs]
 [<dc8d635f>] rpc_destroy_client+0x5f/0x90 [sunrpc]
 [<dc903940>] nfs_put_super+0x20/0x50 [nfs]
 [<c017e99a>] generic_shutdown_super+0x3da/0x440
 [<c010ae48>] common_interrupt+0x18/0x20
 [<c01804e6>] kill_anon_super+0x16/0x180
 [<c0157091>] kmem_cache_free+0x1d1/0x2c0
 [<dc90660a>] nfs_kill_super+0x1a/0x30 [nfs]
 [<c017df1f>] deactivate_super+0xcf/0x2b0
 [<c01a0ca8>] free_vfsmnt+0x28/0x30
 [<dc919760>] nfs_fs_type+0x0/0x20 [nfs]
 [<c01a208c>] sys_umount+0x3c/0xa0
 [<c0174d22>] sys_close+0x102/0x230
 [<c01a2109>] sys_oldumount+0x19/0x20
 [<c010a4db>] syscall_call+0x7/0xb

... after a while, filled with chaotic pressings SysRq+t, SysRq+u, SysRq+...
and boring copying the previous trace onto paper:

Unable to handle kernel paging request at virtual address 00100104
 printing eip:
c019660e
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c019660e>]    Not tainted
EFLAGS: 00010246
EIP is at dput+0xee/0x680
eax: 00100100   ebx: db0f40a4   ecx: db0f40d0   edx: 00200200
esi: db0f41a4   edi: db0f40a4   ebp: db009e28   esp: db009e04
ds: 007b   es: 007b   ss: 0068
Process umount (pid: 4426, threadinfo=db008000 task=db4b0da0)
Stack: db0f40a4 c031fe10 db0f40a4 db009e6c 00000010 ffff007b c019007b db0f40a4 
       db0f41a4 db009e6c dc8eddda db0f40a4 db0f40a4 db0f47d0 db009e88 00000000 
       db0b9804 db0f47d0 db0f41a4 db0b9284 db0f40d0 db0b9204 db0f412c db0f4170 
Call Trace:
 [<c019007b>] file_ioctl+0xbb/0x190
 [<dc8eddda>] rpc_depopulate+0x19a/0x2e0 [sunrpc]
 [<dc8ee60c>] rpc_rmdir+0xac/0xd0 [sunrpc]
 [<dc919620>] nfs_sops+0x0/0x60 [nfs]
 [<dc8d635f>] rpc_destroy_client+0x5f/0x90 [sunrpc]
 [<dc903940>] nfs_put_super+0x20/0x50 [nfs]
 [<c017e99a>] generic_shutdown_super+0x3da/0x440
 [<c010ae48>] common_interrupt+0x18/0x20
 [<c01804e6>] kill_anon_super+0x16/0x180
 [<c0157091>] kmem_cache_free+0x1d1/0x2c0
 [<dc90660a>] nfs_kill_super+0x1a/0x30 [nfs]
 [<c017df1f>] deactivate_super+0xcf/0x2b0
 [<c01a0ca8>] free_vfsmnt+0x28/0x30
 [<dc919760>] nfs_fs_type+0x0/0x20 [nfs]
 [<c01a208c>] sys_umount+0x3c/0xa0
 [<c0174d22>] sys_close+0x102/0x230
 [<c01a2109>] sys_oldumount+0x19/0x20
 [<c010a4db>] syscall_call+0x7/0xb

Code: 89 50 04 89 02 c7 41 04 00 02 20 00 81 7b 08 3c 4b 24 1d c7 
 <6>note: umount[4426] exited with preempt_count 3
bad: scheduling while atomic!
Call Trace:
 [<c0121d21>] schedule+0x6e1/0x6f0
 [<c015ec5e>] unmap_page_range+0x4e/0x80
 [<c015ee8e>] unmap_vmas+0x1fe/0x360
 [<c0164be9>] exit_mmap+0xc9/0x2c0
 [<c01252a3>] mmput+0xb3/0x140
 [<c012b69f>] do_exit+0x27f/0xaa0
 [<c010b68c>] die+0x21c/0x220
 [<c011fa0d>] do_page_fault+0x15d/0x4dc
 [<c012dd66>] tasklet_action+0x46/0x70
 [<c010d0a5>] do_IRQ+0x255/0x3b0
 [<c010ae48>] common_interrupt+0x18/0x20
 [<c011f8b0>] do_page_fault+0x0/0x4dc
 [<c010aee5>] error_code+0x2d/0x38
 [<c019660e>] dput+0xee/0x680
 [<c019007b>] file_ioctl+0xbb/0x190
 [<dc8eddda>] rpc_depopulate+0x19a/0x2e0 [sunrpc]
 [<dc8ee60c>] rpc_rmdir+0xac/0xd0 [sunrpc]
 [<dc919620>] nfs_sops+0x0/0x60 [nfs]
 [<dc8d635f>] rpc_destroy_client+0x5f/0x90 [sunrpc]
 [<dc903940>] nfs_put_super+0x20/0x50 [nfs]
 [<c017e99a>] generic_shutdown_super+0x3da/0x440
 [<c010ae48>] common_interrupt+0x18/0x20
 [<c01804e6>] kill_anon_super+0x16/0x180
 [<c0157091>] kmem_cache_free+0x1d1/0x2c0
 [<dc90660a>] nfs_kill_super+0x1a/0x30 [nfs]
 [<c017df1f>] deactivate_super+0xcf/0x2b0
 [<c01a0ca8>] free_vfsmnt+0x28/0x30
 [<dc919760>] nfs_fs_type+0x0/0x20 [nfs]
 [<c01a208c>] sys_umount+0x3c/0xa0
 [<c0174d22>] sys_close+0x102/0x230
 [<c01a2109>] sys_oldumount+0x19/0x20
 [<c010a4db>] syscall_call+0x7/0xb

