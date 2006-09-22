Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbWIVHHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbWIVHHS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 03:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbWIVHHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 03:07:18 -0400
Received: from ppsw-2.csi.cam.ac.uk ([131.111.8.132]:63671 "EHLO
	ppsw-2.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1750814AbWIVHHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 03:07:16 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: 2.6.18 - possible recursive locking detected (NFS/networking
	related?)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Fri, 22 Sep 2006 08:07:12 +0100
Message-Id: <1158908832.10415.6.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have my home directory on NFS and got this running 2.6.18 (vanilla)
kernel:

=======================================================
[ INFO: possible circular locking dependency detected ]
-------------------------------------------------------
bash/4354 is trying to acquire lock:
 (&inode->i_data.tree_lock){++..}, at: [<c103f991>] find_get_page+0x10/0x45

but task is already holding lock:
 (&inode->i_mutex){--..}, at: [<c145c8a6>] mutex_lock+0x19/0x20

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&inode->i_alloc_sem){--..}:
       [<c1031cc6>] lock_acquire+0x56/0x73
       [<c102ec03>] down_write+0x27/0x42
       [<c107341d>] notify_change+0xe9/0x278
       [<c105ac14>] do_truncate+0x58/0x73
       [<c10690a3>] may_open+0x1bd/0x20d
       [<c106b0ca>] open_namei+0x26e/0x61a
       [<c105a917>] do_filp_open+0x22/0x39
       [<c105a96e>] do_sys_open+0x40/0xba
       [<c105aa11>] sys_open+0x13/0x15
       [<c1002b25>] sysenter_past_esp+0x56/0x8d

-> #2 (&sysfs_inode_imutex_key){--..}:
       [<c1031cc6>] lock_acquire+0x56/0x73
       [<c145c71e>] __mutex_lock_slowpath+0xaf/0x21e
       [<c145c8a6>] mutex_lock+0x19/0x20
       [<c1096238>] create_dir+0x1e/0x1a5
       [<c1096aa5>] sysfs_create_dir+0x49/0x64
       [<c121ec65>] kobject_add+0xcd/0x17f
       [<c12afcc4>] class_device_add+0x9d/0x3e2
       [<c13b5536>] netdev_register_sysfs+0x75/0x7d
       [<c13ab32d>] register_netdevice+0x22b/0x2e5
       [<c13ac488>] register_netdev+0x5d/0x6e
       [<c12c3789>] e1000_probe+0xa68/0xb2e
       [<c1237289>] pci_device_probe+0x3a/0x61
       [<c12aeff3>] driver_probe_device+0x46/0x94
       [<c12af115>] __driver_attach+0x5a/0x89
       [<c12aea51>] bus_for_each_dev+0x45/0x6c
       [<c12aef45>] driver_attach+0x16/0x1b
       [<c12ae6ce>] bus_add_driver+0x69/0x110
       [<c12af3bc>] driver_register+0x7a/0x7f
       [<c12373f3>] __pci_register_driver+0x55/0x77
       [<c18373bd>] e1000_init_module+0x32/0x34
       [<c10003ef>] init+0x11f/0x29d
       [<c1000bf1>] kernel_thread_helper+0x5/0xb

-> #1 (rtnl_mutex){--..}:
       [<c1031cc6>] lock_acquire+0x56/0x73
       [<c145c71e>] __mutex_lock_slowpath+0xaf/0x21e
       [<c145c8a6>] mutex_lock+0x19/0x20
       [<c13b327d>] rtnl_lock+0xd/0xf
       [<c13f0231>] ip_mc_join_group+0x2b/0xd8
       [<c13d0e18>] ip_setsockopt+0x623/0x95e
       [<c13e7197>] udp_setsockopt+0x23/0xa1
       [<c13a42d6>] sock_common_setsockopt+0x1c/0x1e
       [<c13a30f1>] sys_setsockopt+0x57/0x76
       [<c13a3ef1>] sys_socketcall+0x130/0x16b
       [<c1002b25>] sysenter_past_esp+0x56/0x8d

-> #0 (&inode->i_data.tree_lock){++..}:
       [<c1031cc6>] lock_acquire+0x56/0x73
       [<c13a4998>] lock_sock+0xbc/0xcc
       [<c13d4b75>] tcp_sendmsg+0x14/0xa15
       [<c13ed10d>] inet_sendmsg+0x34/0x40
       [<c13a2746>] sock_sendmsg+0xcf/0xe7
       [<c13a3f5c>] kernel_sendmsg+0x30/0x40
       [<c142b1dc>] xs_tcp_send_request+0x106/0x2f9
       [<c142a395>] xprt_transmit+0xcc/0x1b4
       [<c14283f6>] call_transmit+0x1af/0x1dc
       [<c142d36d>] __rpc_execute+0x7c/0x199
       [<c142d4ae>] rpc_execute+0x17/0x19
       [<c1428567>] rpc_call_sync+0x75/0x9e
       [<c110b76e>] nfs3_rpc_wrapper+0x26/0x68
       [<c110ba37>] nfs3_proc_setattr+0xab/0xde
       [<c1103011>] nfs_setattr+0x111/0x139
       [<c1073435>] notify_change+0x101/0x278
       [<c105ac14>] do_truncate+0x58/0x73
       [<c10690a3>] may_open+0x1bd/0x20d
       [<c106b0ca>] open_namei+0x26e/0x61a
       [<c105a917>] do_filp_open+0x22/0x39
       [<c105a96e>] do_sys_open+0x40/0xba
       [<c105aa11>] sys_open+0x13/0x15
       [<c1002b25>] sysenter_past_esp+0x56/0x8d

other info that might help us debug this:

2 locks held by bash/4354:
 #0:  (&inode->i_mutex){--..}, at: [<c145c8a6>] mutex_lock+0x19/0x20
 #1:  (&inode->i_alloc_sem){--..}, at: [<c107341d>] notify_change+0xe9/0x278

stack backtrace:
 [<c1003cc8>] show_trace_log_lvl+0x57/0x16f
 [<c10042f1>] show_trace+0x16/0x19
 [<c10043b9>] dump_stack+0x1a/0x1f
 [<c103103c>] print_circular_bug_tail+0x59/0x64
 [<c1031872>] __lock_acquire+0x82b/0x9b6
 [<c1031cc6>] lock_acquire+0x56/0x73
 [<c13a4998>] lock_sock+0xbc/0xcc
 [<c13d4b75>] tcp_sendmsg+0x14/0xa15
 [<c13ed10d>] inet_sendmsg+0x34/0x40
 [<c13a2746>] sock_sendmsg+0xcf/0xe7
 [<c13a3f5c>] kernel_sendmsg+0x30/0x40
 [<c142b1dc>] xs_tcp_send_request+0x106/0x2f9
 [<c142a395>] xprt_transmit+0xcc/0x1b4
 [<c14283f6>] call_transmit+0x1af/0x1dc
 [<c142d36d>] __rpc_execute+0x7c/0x199
 [<c142d4ae>] rpc_execute+0x17/0x19
 [<c1428567>] rpc_call_sync+0x75/0x9e
 [<c110b76e>] nfs3_rpc_wrapper+0x26/0x68
 [<c110ba37>] nfs3_proc_setattr+0xab/0xde
 [<c1103011>] nfs_setattr+0x111/0x139
 [<c1073435>] notify_change+0x101/0x278
 [<c105ac14>] do_truncate+0x58/0x73
 [<c10690a3>] may_open+0x1bd/0x20d
 [<c106b0ca>] open_namei+0x26e/0x61a
 [<c105a917>] do_filp_open+0x22/0x39
 [<c105a96e>] do_sys_open+0x40/0xba
 [<c105aa11>] sys_open+0x13/0x15
 [<c1002b25>] sysenter_past_esp+0x56/0x8d
DWARF2 unwinder stuck at sysenter_past_esp+0x56/0x8d
Leftover inexact backtrace:
 [<c10042f1>] show_trace+0x16/0x19
 [<c10043b9>] dump_stack+0x1a/0x1f
 [<c103103c>] print_circular_bug_tail+0x59/0x64
 [<c1031872>] __lock_acquire+0x82b/0x9b6
 [<c1031cc6>] lock_acquire+0x56/0x73
 [<c13a4998>] lock_sock+0xbc/0xcc
 [<c13d4b75>] tcp_sendmsg+0x14/0xa15
 [<c13ed10d>] inet_sendmsg+0x34/0x40
 [<c13a2746>] sock_sendmsg+0xcf/0xe7
 [<c13a3f5c>] kernel_sendmsg+0x30/0x40
 [<c142b1dc>] xs_tcp_send_request+0x106/0x2f9
 [<c142a395>] xprt_transmit+0xcc/0x1b4
 [<c14283f6>] call_transmit+0x1af/0x1dc
 [<c142d36d>] __rpc_execute+0x7c/0x199
 [<c142d4ae>] rpc_execute+0x17/0x19
 [<c1428567>] rpc_call_sync+0x75/0x9e
 [<c110b76e>] nfs3_rpc_wrapper+0x26/0x68
 [<c110ba37>] nfs3_proc_setattr+0xab/0xde
 [<c1103011>] nfs_setattr+0x111/0x139
 [<c1073435>] notify_change+0x101/0x278
 [<c105ac14>] do_truncate+0x58/0x73
 [<c10690a3>] may_open+0x1bd/0x20d
 [<c106b0ca>] open_namei+0x26e/0x61a
 [<c105a917>] do_filp_open+0x22/0x39
 [<c105a96e>] do_sys_open+0x40/0xba
 [<c105aa11>] sys_open+0x13/0x15
 [<c1002b25>] sysenter_past_esp+0x56/0x8d

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://www.linux-ntfs.org/ & http://www-stu.christs.cam.ac.uk/~aia21/

