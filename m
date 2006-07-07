Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbWGGQNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWGGQNW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 12:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWGGQNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 12:13:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45270 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932147AbWGGQNU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 12:13:20 -0400
Date: Fri, 7 Jul 2006 12:13:14 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: netdev@vger.kernel.org
Subject: starting mc triggers lockdep
Message-ID: <20060707161314.GA3223@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With 2.6.18rc1 + a selection of the lockdep tweaks found so far,
midnight commander makes the kernel unhappy.

		Dave


=======================================================
[ INFO: possible circular locking dependency detected ]
-------------------------------------------------------
mc/4913 is trying to acquire lock:
 (sk_lock-AF_INET){--..}, at: [<ffffffff8022800c>] tcp_sendmsg+0x1f/0xb1a

but task is already holding lock:
 (&inode->i_mutex){--..}, at: [<ffffffff802692e0>] mutex_lock+0x2a/0x2e

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&inode->i_mutex){--..}:
       [<ffffffff802ab6d5>] lock_acquire+0x4a/0x69
       [<ffffffff80269102>] __mutex_lock_slowpath+0xeb/0x29f
       [<ffffffff802692df>] mutex_lock+0x29/0x2e
       [<ffffffff8030f4a0>] create_dir+0x2c/0x1e2
       [<ffffffff8030fa5b>] sysfs_create_dir+0x59/0x78
       [<ffffffff8034d2e2>] kobject_add+0x114/0x1d8
       [<ffffffff803bb1e7>] class_device_add+0xb5/0x49d
       [<ffffffff804300b1>] netdev_register_sysfs+0x98/0xa2
       [<ffffffff80426f58>] register_netdevice+0x28c/0x376
       [<ffffffff8042709c>] register_netdev+0x5a/0x69
       [<ffffffff8098aa12>] loopback_init+0x4e/0x53
       [<ffffffff8098a918>] net_olddevs_init+0xb/0xb7
       [<ffffffff80270918>] init+0x177/0x348
       [<ffffffff80263cdd>] child_rip+0x7/0x12

-> #1 (rtnl_mutex){--..}:
       [<ffffffff802ab6d5>] lock_acquire+0x4a/0x69
       [<ffffffff80269102>] __mutex_lock_slowpath+0xeb/0x29f
       [<ffffffff802692df>] mutex_lock+0x29/0x2e
       [<ffffffff8042e0a2>] rtnl_lock+0xf/0x12
       [<ffffffff8045c7b8>] ip_mc_leave_group+0x1e/0xae
       [<ffffffff804467f7>] do_ip_setsockopt+0x6ad/0x9b2
       [<ffffffff80446baa>] ip_setsockopt+0x2a/0x84
       [<ffffffff80454a55>] udp_setsockopt+0xd/0x1c
       [<ffffffff8041f7ea>] sock_common_setsockopt+0xe/0x11
       [<ffffffff8041e965>] sys_setsockopt+0x8e/0xb4
       [<ffffffff80262f19>] tracesys+0xd0/0xdb

-> #0 (sk_lock-AF_INET){--..}:
       [<ffffffff802ab6d5>] lock_acquire+0x4a/0x69
       [<ffffffff802371ea>] lock_sock+0xd4/0xe7
       [<ffffffff8022800b>] tcp_sendmsg+0x1e/0xb1a
       [<ffffffff80248f4b>] inet_sendmsg+0x45/0x53
       [<ffffffff80259d25>] sock_sendmsg+0x110/0x130
       [<ffffffff8041f462>] kernel_sendmsg+0x3c/0x52
       [<ffffffff885399e9>] xs_tcp_send_request+0x117/0x320 [sunrpc]
       [<ffffffff885388d5>] xprt_transmit+0x105/0x21e [sunrpc]
       [<ffffffff8853771e>] call_transmit+0x1f4/0x239 [sunrpc]
       [<ffffffff8853c06e>] __rpc_execute+0x9b/0x1e6 [sunrpc]
       [<ffffffff8853c1de>] rpc_execute+0x1a/0x1d [sunrpc]
       [<ffffffff885364ad>] rpc_call_sync+0x87/0xb9 [sunrpc]
       [<ffffffff885a2587>] nfs3_rpc_wrapper+0x2e/0x74 [nfs]
       [<ffffffff885a2a14>] nfs3_proc_lookup+0xe0/0x163 [nfs]
       [<ffffffff88594b10>] nfs_lookup+0xef/0x1d6 [nfs]
       [<ffffffff8020d300>] do_lookup+0xd0/0x18c
       [<ffffffff80209f27>] __link_path_walk+0xa29/0xf7d
       [<ffffffff8020f076>] link_path_walk+0x69/0x101
       [<ffffffff8020a22b>] __link_path_walk+0xd2d/0xf7d
       [<ffffffff8020f076>] link_path_walk+0x69/0x101
       [<ffffffff8020d096>] do_path_lookup+0x27b/0x2e7
       [<ffffffff802258da>] __user_walk_fd+0x40/0x5c
       [<ffffffff8022ae4a>] vfs_stat_fd+0x26/0x5d
       [<ffffffff80225592>] sys_newstat+0x21/0x3c
       [<ffffffff80262f19>] tracesys+0xd0/0xdb

other info that might help us debug this:

1 lock held by mc/4913:
 #0:  (&inode->i_mutex){--..}, at: [<ffffffff802692e0>] mutex_lock+0x2a/0x2e

stack backtrace:

Call Trace:
 [<ffffffff80271910>] show_trace+0xaa/0x23d
 [<ffffffff80271ab8>] dump_stack+0x15/0x17
 [<ffffffff802a992f>] print_circular_bug_tail+0x6c/0x77
 [<ffffffff802aaf34>] __lock_acquire+0x853/0xa54
 [<ffffffff802ab6d6>] lock_acquire+0x4b/0x69
 [<ffffffff802371eb>] lock_sock+0xd5/0xe7
 [<ffffffff8022800c>] tcp_sendmsg+0x1f/0xb1a
 [<ffffffff80248f4c>] inet_sendmsg+0x46/0x53
 [<ffffffff80259d26>] sock_sendmsg+0x111/0x130
 [<ffffffff8041f463>] kernel_sendmsg+0x3d/0x52
 [<ffffffff885399ea>] :sunrpc:xs_tcp_send_request+0x118/0x320
 [<ffffffff885388d6>] :sunrpc:xprt_transmit+0x106/0x21e
 [<ffffffff8853771f>] :sunrpc:call_transmit+0x1f5/0x239
 [<ffffffff8853c06f>] :sunrpc:__rpc_execute+0x9c/0x1e6
 [<ffffffff8853c1df>] :sunrpc:rpc_execute+0x1b/0x1d
 [<ffffffff885364ae>] :sunrpc:rpc_call_sync+0x88/0xb9
 [<ffffffff885a2588>] :nfs:nfs3_rpc_wrapper+0x2f/0x74
 [<ffffffff885a2a15>] :nfs:nfs3_proc_lookup+0xe1/0x163
 [<ffffffff88594b11>] :nfs:nfs_lookup+0xf0/0x1d6
 [<ffffffff8020d301>] do_lookup+0xd1/0x18c
 [<ffffffff80209f28>] __link_path_walk+0xa2a/0xf7d
 [<ffffffff8020f077>] link_path_walk+0x6a/0x101
 [<ffffffff8020a22c>] __link_path_walk+0xd2e/0xf7d
 [<ffffffff8020f077>] link_path_walk+0x6a/0x101
 [<ffffffff8020d097>] do_path_lookup+0x27c/0x2e7
 [<ffffffff802258db>] __user_walk_fd+0x41/0x5c
 [<ffffffff8022ae4b>] vfs_stat_fd+0x27/0x5d
 [<ffffffff80225593>] sys_newstat+0x22/0x3c
 [<ffffffff80262f1a>] tracesys+0xd1/0xdb

-- 
http://www.codemonkey.org.uk
