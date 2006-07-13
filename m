Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbWGMEHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbWGMEHW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 00:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWGMEHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 00:07:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39566 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932168AbWGMEHV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 00:07:21 -0400
Date: Thu, 13 Jul 2006 00:07:16 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: netdev <netdev@vger.kernel.org>
Subject: another networking lockdep bug
Message-ID: <20060713040715.GE4199@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	netdev <netdev@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure if this one got reported/fixed yet, as I was running
a kernel from sometime last week..

		Dave


=======================================================
[ INFO: possible circular locking dependency detected ]
-------------------------------------------------------
git-fetch/11540 is trying to acquire lock:
 (sk_lock-AF_INET){--..}, at: [<ffffffff80228062>] tcp_sendmsg+0x1f/0xb1a

but task is already holding lock:
 (&inode->i_alloc_sem){--..}, at: [<ffffffff8022f765>] notify_change+0x105/0x2f7

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&inode->i_alloc_sem){--..}:
       [<ffffffff802ab792>] lock_acquire+0x4a/0x69
       [<ffffffff802a831c>] down_write+0x3a/0x47
       [<ffffffff8022f764>] notify_change+0x104/0x2f7
       [<ffffffff802e00c7>] do_truncate+0x52/0x72
       [<ffffffff80212d17>] may_open+0x1d5/0x231
       [<ffffffff8021c270>] open_namei+0x290/0x6b4
       [<ffffffff80229974>] do_filp_open+0x27/0x46
       [<ffffffff8021acb7>] do_sys_open+0x4e/0xcd
       [<ffffffff80234b2a>] sys_open+0x1a/0x1d
       [<ffffffff80262e4d>] system_call+0x7d/0x83

-> #2 (&sysfs_inode_imutex_key){--..}:
       [<ffffffff802ab792>] lock_acquire+0x4a/0x69
       [<ffffffff802691c2>] __mutex_lock_slowpath+0xeb/0x29f
       [<ffffffff8026939f>] mutex_lock+0x29/0x2e
       [<ffffffff8030ed74>] create_dir+0x2c/0x1e2
       [<ffffffff8030f32f>] sysfs_create_dir+0x59/0x78
       [<ffffffff8034cbd6>] kobject_add+0x114/0x1d8
       [<ffffffff803baa5d>] class_device_add+0xb5/0x49d
       [<ffffffff8042f982>] netdev_register_sysfs+0x98/0xa2
       [<ffffffff8042685f>] register_netdevice+0x28c/0x377
       [<ffffffff804269a4>] register_netdev+0x5a/0x69
       [<ffffffff8098a9f8>] loopback_init+0x4e/0x53
       [<ffffffff8098a8fe>] net_olddevs_init+0xb/0xb7
       [<ffffffff802709c0>] init+0x177/0x348
       [<ffffffff80263d9d>] child_rip+0x7/0x12

-> #1 (rtnl_mutex){--..}:
       [<ffffffff802ab792>] lock_acquire+0x4a/0x69
       [<ffffffff802691c2>] __mutex_lock_slowpath+0xeb/0x29f
       [<ffffffff8026939f>] mutex_lock+0x29/0x2e
       [<ffffffff8042d973>] rtnl_lock+0xf/0x12
       [<ffffffff8045c18a>] ip_mc_leave_group+0x1e/0xae
       [<ffffffff80446087>] do_ip_setsockopt+0x6ad/0x9b2
       [<ffffffff8044643a>] ip_setsockopt+0x2a/0x84
       [<ffffffff80454328>] udp_setsockopt+0xd/0x1c
       [<ffffffff8041f094>] sock_common_setsockopt+0xe/0x11
       [<ffffffff8041e20f>] sys_setsockopt+0x8e/0xb4
       [<ffffffff80262fd9>] tracesys+0xd0/0xdb

-> #0 (sk_lock-AF_INET){--..}:
       [<ffffffff802ab792>] lock_acquire+0x4a/0x69
       [<ffffffff8023726c>] lock_sock+0xd4/0xe7
       [<ffffffff80228061>] tcp_sendmsg+0x1e/0xb1a
       [<ffffffff80248ff8>] inet_sendmsg+0x45/0x53
       [<ffffffff80259dd3>] sock_sendmsg+0x110/0x130
       [<ffffffff8041ed0c>] kernel_sendmsg+0x3c/0x52
       [<ffffffff8853c9e9>] xs_tcp_send_request+0x117/0x320 [sunrpc]
       [<ffffffff8853b8d5>] xprt_transmit+0x105/0x21e [sunrpc]
       [<ffffffff8853a71e>] call_transmit+0x1f4/0x239 [sunrpc]
       [<ffffffff8853f06e>] __rpc_execute+0x9b/0x1e6 [sunrpc]
       [<ffffffff8853f1de>] rpc_execute+0x1a/0x1d [sunrpc]
       [<ffffffff885394ad>] rpc_call_sync+0x87/0xb9 [sunrpc]
       [<ffffffff885a5587>] nfs3_rpc_wrapper+0x2e/0x74 [nfs]
       [<ffffffff885a5870>] nfs3_proc_setattr+0x9b/0xd3 [nfs]
       [<ffffffff8859bffb>] nfs_setattr+0xe9/0x11e [nfs]
       [<ffffffff8022f7b4>] notify_change+0x154/0x2f7
       [<ffffffff802e00c7>] do_truncate+0x52/0x72
       [<ffffffff80212d17>] may_open+0x1d5/0x231
       [<ffffffff8021c270>] open_namei+0x290/0x6b4
       [<ffffffff80229974>] do_filp_open+0x27/0x46
       [<ffffffff8021acb7>] do_sys_open+0x4e/0xcd
       [<ffffffff80234b2a>] sys_open+0x1a/0x1d
       [<ffffffff80262fd9>] tracesys+0xd0/0xdb


other info that might help us debug this:

2 locks held by git-fetch/11540:
 #0:  (&inode->i_mutex){--..}, at: [<ffffffff802693a0>] mutex_lock+0x2a/0x2e
 #1:  (&inode->i_alloc_sem){--..}, at: [<ffffffff8022f765>] notify_change+0x105/0x2f7

stack backtrace:

Call Trace:
 [<ffffffff802719b8>] show_trace+0xaa/0x23d
 [<ffffffff80271b60>] dump_stack+0x15/0x17
 [<ffffffff802a99ec>] print_circular_bug_tail+0x6c/0x77
 [<ffffffff802aaff1>] __lock_acquire+0x853/0xa54
 [<ffffffff802ab793>] lock_acquire+0x4b/0x69
 [<ffffffff8023726d>] lock_sock+0xd5/0xe7
 [<ffffffff80228062>] tcp_sendmsg+0x1f/0xb1a
 [<ffffffff80248ff9>] inet_sendmsg+0x46/0x53
 [<ffffffff80259dd4>] sock_sendmsg+0x111/0x130
 [<ffffffff8041ed0d>] kernel_sendmsg+0x3d/0x52
 [<ffffffff8853c9ea>] :sunrpc:xs_tcp_send_request+0x118/0x320
 [<ffffffff8853b8d6>] :sunrpc:xprt_transmit+0x106/0x21e
 [<ffffffff8853a71f>] :sunrpc:call_transmit+0x1f5/0x239
 [<ffffffff8853f06f>] :sunrpc:__rpc_execute+0x9c/0x1e6
 [<ffffffff8853f1df>] :sunrpc:rpc_execute+0x1b/0x1d
 [<ffffffff885394ae>] :sunrpc:rpc_call_sync+0x88/0xb9
 [<ffffffff885a5588>] :nfs:nfs3_rpc_wrapper+0x2f/0x74
 [<ffffffff885a5871>] :nfs:nfs3_proc_setattr+0x9c/0xd3
 [<ffffffff8859bffc>] :nfs:nfs_setattr+0xea/0x11e
 [<ffffffff8022f7b5>] notify_change+0x155/0x2f7
 [<ffffffff802e00c8>] do_truncate+0x53/0x72
 [<ffffffff80212d18>] may_open+0x1d6/0x231
 [<ffffffff8021c271>] open_namei+0x291/0x6b4
 [<ffffffff80229975>] do_filp_open+0x28/0x46
 [<ffffffff8021acb8>] do_sys_open+0x4f/0xcd
 [<ffffffff80234b2b>] sys_open+0x1b/0x1d
 [<ffffffff80262fda>] tracesys+0xd1/0xdb


-- 
http://www.codemonkey.org.uk
