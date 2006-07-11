Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbWGKLtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbWGKLtL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 07:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbWGKLtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 07:49:11 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:12843 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751221AbWGKLtK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 07:49:10 -0400
Date: Tue, 11 Jul 2006 13:51:44 +0200
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Cc: john.ronciak@intel.com, jesse.brandeburg@intel.com,
       trond.myklebust@fys.uio.no
Subject: e1000 vs nfs/net circular locking report
Message-ID: <20060711115143.GB4113@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Upon cd'ing to an nfs mounted directory, I received this report. It's
perfectly reproducible.

=======================================================
[ INFO: possible circular locking dependency detected ]
-------------------------------------------------------
bash/9673 is trying to acquire lock:
 (sk_lock-AF_INET){--..}, at: [<b0355dc9>] tcp_sendmsg+0x14/0xb20

but task is already holding lock:
 (&inode->i_mutex){--..}, at: [<b0391396>] mutex_lock+0x1c/0x1f

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&inode->i_mutex){--..}:
       [<b013a17a>] lock_acquire+0x5d/0x79
       [<b0391152>] __mutex_lock_slowpath+0x6e/0x296
       [<b0391396>] mutex_lock+0x1c/0x1f
       [<b019d78f>] create_dir+0x1e/0x1b8
       [<b019e07b>] sysfs_create_dir+0x2d/0x67
       [<b0298b47>] kobject_add+0x8e/0x199
       [<b02e7645>] class_device_add+0xaf/0x43d
       [<b0342a55>] netdev_register_sysfs+0x6b/0x80
       [<b0338210>] register_netdevice+0x22d/0x3e4
       [<b03396bf>] register_netdev+0x59/0x6c
       [<b02f1375>] e1000_probe+0xb5d/0xcb3
       [<b02a26a4>] pci_device_probe+0x44/0x5f
       [<b02e68c9>] driver_probe_device+0x3e/0xb0
       [<b02e6a3d>] __driver_attach+0x8a/0x8c
       [<b02e62fa>] bus_for_each_dev+0x43/0x61
       [<b02e682c>] driver_attach+0x19/0x1b
       [<b02e5f73>] bus_add_driver+0x70/0x12c
       [<b02e6cb5>] driver_register+0x5d/0x8d
       [<b02a2810>] __pci_register_driver+0x4f/0x6a
       [<b0497ae2>] e1000_init_module+0x42/0x50
       [<b01003eb>] init+0x10f/0x30a
       [<b0101005>] kernel_thread_helper+0x5/0xb

-> #1 (rtnl_mutex){--..}:
       [<b013a17a>] lock_acquire+0x5d/0x79
       [<b0391152>] __mutex_lock_slowpath+0x6e/0x296
       [<b0391396>] mutex_lock+0x1c/0x1f
       [<b0340e51>] rtnl_lock+0xd/0xf
       [<b0373ed3>] ip_mc_join_group+0x32/0xde
       [<b0351ae8>] ip_setsockopt+0x860/0xb1f
       [<b0369b16>] udp_setsockopt+0x23/0xa2
       [<b03307ff>] sock_common_setsockopt+0x1e/0x25
       [<b032f3e6>] sys_setsockopt+0x4e/0x8b
       [<b03303b6>] sys_socketcall+0x1f1/0x254
       [<b01030a5>] sysenter_past_esp+0x56/0x8d

-> #0 (sk_lock-AF_INET){--..}:
       [<b013a17a>] lock_acquire+0x5d/0x79
       [<b0330f96>] lock_sock+0xd7/0xe4
       [<b0355dc9>] tcp_sendmsg+0x14/0xb20
       [<b0370663>] inet_sendmsg+0x2e/0x4d
       [<b032e929>] sock_sendmsg+0xcf/0xf3
       [<b0330441>] kernel_sendmsg+0x28/0x37
       [<b0382bbe>] xs_tcp_send_request+0x1d4/0x381
       [<b0381a0e>] xprt_transmit+0x45/0x200
       [<b0380ba5>] call_transmit+0x15c/0x216
       [<b03851b3>] __rpc_execute+0x6d/0x1f2
       [<b0385356>] rpc_execute+0x14/0x16
       [<b037f7d9>] rpc_call_sync+0x8d/0xa2
       [<b02018d5>] nfs3_rpc_wrapper+0x43/0x66
       [<b0201d3d>] nfs3_proc_lookup+0xc9/0x153
       [<b01f5f09>] nfs_lookup+0xc8/0x1f7
       [<b0173a78>] do_lookup+0x10d/0x13a
       [<b0174d5d>] __link_path_walk+0x383/0xedb
       [<b01758fb>] link_path_walk+0x46/0xd2
       [<b0175bc3>] do_path_lookup+0xbd/0x268
       [<b017655a>] __user_walk_fd+0x32/0x4a
       [<b016fca8>] vfs_stat_fd+0x1b/0x41
       [<b016fd5b>] vfs_stat+0x11/0x13
       [<b016fd71>] sys_stat64+0x14/0x28
       [<b01030a5>] sysenter_past_esp+0x56/0x8d

other info that might help us debug this:

1 lock held by bash/9673:
 #0:  (&inode->i_mutex){--..}, at: [<b0391396>] mutex_lock+0x1c/0x1f

stack backtrace:
 [<b01041db>] show_trace+0x12/0x14
 [<b01048a4>] dump_stack+0x19/0x1b
 [<b0139137>] print_circular_bug_tail+0x5d/0x66
 [<b0139b9e>] __lock_acquire+0xa5e/0xcf5
 [<b013a17a>] lock_acquire+0x5d/0x79
 [<b0330f96>] lock_sock+0xd7/0xe4
 [<b0355dc9>] tcp_sendmsg+0x14/0xb20
 [<b0370663>] inet_sendmsg+0x2e/0x4d
 [<b032e929>] sock_sendmsg+0xcf/0xf3
 [<b0330441>] kernel_sendmsg+0x28/0x37
 [<b0382bbe>] xs_tcp_send_request+0x1d4/0x381
 [<b0381a0e>] xprt_transmit+0x45/0x200
 [<b0380ba5>] call_transmit+0x15c/0x216
 [<b03851b3>] __rpc_execute+0x6d/0x1f2
 [<b0385356>] rpc_execute+0x14/0x16
 [<b037f7d9>] rpc_call_sync+0x8d/0xa2
 [<b02018d5>] nfs3_rpc_wrapper+0x43/0x66
 [<b0201d3d>] nfs3_proc_lookup+0xc9/0x153
 [<b01f5f09>] nfs_lookup+0xc8/0x1f7
 [<b0173a78>] do_lookup+0x10d/0x13a
 [<b0174d5d>] __link_path_walk+0x383/0xedb
 [<b01758fb>] link_path_walk+0x46/0xd2
 [<b0175bc3>] do_path_lookup+0xbd/0x268
 [<b017655a>] __user_walk_fd+0x32/0x4a
 [<b016fca8>] vfs_stat_fd+0x1b/0x41
 [<b016fd5b>] vfs_stat+0x11/0x13
 [<b016fd71>] sys_stat64+0x14/0x28
 [<b01030a5>] sysenter_past_esp+0x56/0x8d

-- 
Jens Axboe

