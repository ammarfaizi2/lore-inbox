Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030429AbWHOSLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030429AbWHOSLM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 14:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030431AbWHOSLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 14:11:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28376 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030429AbWHOSLK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 14:11:10 -0400
Date: Tue, 15 Aug 2006 14:11:03 -0400
From: Bill Nottingham <notting@redhat.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: lockdep: adding bonding device triggers warning
Message-ID: <20060815181103.GA9690@nostromo.devel.redhat.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.17-1.2564.fc6 is 2.6.18rc4+.

Happened with 'echo "+bond0" > /sys/class/net/bonding_masters'

bonding: bond0 is being created...

=======================================================
[ INFO: possible circular locking dependency detected ]
2.6.17-1.2564.fc6 #1
-------------------------------------------------------
bash/9497 is trying to acquire lock:
 (rtnl_mutex){--..}, at: [<c0612860>] mutex_lock+0x21/0x24

but task is already holding lock:
 (&bonding_rwsem){----}, at: [<f8c332e0>] bonding_store_bonds+0x28/0x1c6 [bonding]

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&bonding_rwsem){----}:
       [<c043c08e>] lock_acquire+0x4b/0x6d
       [<c0438fed>] down_write+0x2d/0x48
       [<f8c2d88f>] bond_netdev_event+0x2f/0x78 [bonding]
       [<c0614f35>] notifier_call_chain+0x20/0x31
       [<c0430c84>] raw_notifier_call_chain+0x8/0xa
       [<c05b99e2>] dev_change_name+0x16e/0x179
       [<c05b9d08>] dev_ifsioc+0x31b/0x3c2
       [<c05ba2c4>] dev_ioctl+0x350/0x46e
       [<c05afe89>] sock_ioctl+0x1c7/0x1d3
       [<c0483032>] do_ioctl+0x22/0x67
       [<c04832cf>] vfs_ioctl+0x258/0x26b
       [<c0483329>] sys_ioctl+0x47/0x62
       [<c0403faf>] syscall_call+0x7/0xb

-> #0 (rtnl_mutex){--..}:
       [<c043c08e>] lock_acquire+0x4b/0x6d
       [<c06126f1>] __mutex_lock_slowpath+0xbc/0x20a
       [<c0612860>] mutex_lock+0x21/0x24
       [<c05c0450>] rtnl_lock+0xd/0xf
       [<f8c2bc5f>] bond_create+0x15/0x1bd [bonding]
       [<f8c3337a>] bonding_store_bonds+0xc2/0x1c6 [bonding]
       [<c0554e98>] class_attr_store+0x20/0x25
       [<c04aa0c8>] sysfs_write_file+0xab/0xd1
       [<c0473307>] vfs_write+0xab/0x157
       [<c047394c>] sys_write+0x3b/0x60
       [<c0403faf>] syscall_call+0x7/0xb

other info that might help us debug this:

1 lock held by bash/9497:
 #0:  (&bonding_rwsem){----}, at: [<f8c332e0>] bonding_store_bonds+0x28/0x1c6 [bonding]

stack backtrace:
 [<c04051ee>] show_trace_log_lvl+0x58/0x159
 [<c04057ea>] show_trace+0xd/0x10
 [<c0405903>] dump_stack+0x19/0x1b
 [<c043b176>] print_circular_bug_tail+0x59/0x64
 [<c043b98e>] __lock_acquire+0x80d/0x99c
 [<c043c08e>] lock_acquire+0x4b/0x6d
 [<c06126f1>] __mutex_lock_slowpath+0xbc/0x20a
 [<c0612860>] mutex_lock+0x21/0x24
 [<c05c0450>] rtnl_lock+0xd/0xf
 [<f8c2bc5f>] bond_create+0x15/0x1bd [bonding]
 [<f8c3337a>] bonding_store_bonds+0xc2/0x1c6 [bonding]
 [<c0554e98>] class_attr_store+0x20/0x25
 [<c04aa0c8>] sysfs_write_file+0xab/0xd1
 [<c0473307>] vfs_write+0xab/0x157
 [<c047394c>] sys_write+0x3b/0x60
 [<c0403faf>] syscall_call+0x7/0xb
DWARF2 unwinder stuck at syscall_call+0x7/0xb
Leftover inexact backtrace:
 [<c04057ea>] show_trace+0xd/0x10
 [<c0405903>] dump_stack+0x19/0x1b
 [<c043b176>] print_circular_bug_tail+0x59/0x64
 [<c043b98e>] __lock_acquire+0x80d/0x99c
 [<c043c08e>] lock_acquire+0x4b/0x6d
 [<c06126f1>] __mutex_lock_slowpath+0xbc/0x20a
 [<c0612860>] mutex_lock+0x21/0x24
 [<c05c0450>] rtnl_lock+0xd/0xf
 [<f8c2bc5f>] bond_create+0x15/0x1bd [bonding]
 [<f8c3337a>] bonding_store_bonds+0xc2/0x1c6 [bonding]
 [<c0554e98>] class_attr_store+0x20/0x25
 [<c04aa0c8>] sysfs_write_file+0xab/0xd1
 [<c0473307>] vfs_write+0xab/0x157
 [<c047394c>] sys_write+0x3b/0x60
 [<c0403faf>] syscall_call+0x7/0xb

