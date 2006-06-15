Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030451AbWFOOkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030451AbWFOOkF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 10:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030455AbWFOOkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 10:40:04 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:59008 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S1030451AbWFOOkC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 10:40:02 -0400
Message-ID: <1150382401.449171412bdfe@imp1-g19.free.fr>
Date: Thu, 15 Jun 2006 16:40:01 +0200
From: deweerdt@free.fr
To: linux-kernel@vger.kernel.org
Cc: mingo@redhat.com, greearb@candelatech.com
Subject: lock validator: false positive in vlan_dev.c
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.5
X-Originating-IP: 195.167.234.130
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Assigning an inet address to a vlanized interface triggered the following BUG
from the lock validator (kernel is 2.6.17-rc6-mm2):

[176619.872000] ====================================
[176619.872000] [ BUG: possible deadlock detected! ]
[176619.872000] ------------------------------------
[176619.872000] ifconfig/13283 is trying to acquire lock:
[176619.872000]  (&dev->xmit_lock){-+..}, at: [<c02f7471>] dev_mc_add+0x31/0x11d
[176619.872000]
[176619.872000] but task is already holding lock:
[176619.872000]  (&dev->xmit_lock){-+..}, at: [<c02f7471>] dev_mc_add+0x31/0x11d
[176619.872000]
[176619.872000] which could potentially lead to deadlocks!
[176619.872000]
[176619.872000] other info that might help us debug this:
[176619.872000] 2 locks held by ifconfig/13283:
[176619.872000]  #0:  (rtnl_mutex){--..}, at: [<c036c722>] mutex_lock+0x8/0xa
[176619.872000]  #1:  (&dev->xmit_lock){-+..}, at: [<c02f7471>]
dev_mc_add+0x31/0x11d
[176619.872000]
[176619.872000] stack backtrace:
[176619.872000]  [<c0103da1>] show_trace_log_lvl+0x136/0x150
[176619.872000]  [<c0104f12>] show_trace+0x1b/0x1d
[176619.872000]  [<c0104f3a>] dump_stack+0x26/0x28
[176619.872000]  [<c0137823>] __lock_acquire+0x2ea/0xd37
[176619.872000]  [<c0138684>] lock_acquire+0x60/0x75
[176619.872000]  [<c036dc5d>] _spin_lock_bh+0x4a/0x58
[176619.872000]  [<c02f7471>] dev_mc_add+0x31/0x11d
[176619.872000]  [<f8b5ed9e>] vlan_dev_set_multicast_list+0xf5/0x309 [8021q]
[176619.872000]  [<c02f7346>] __dev_mc_upload+0x26/0x28
[176619.872000]  [<c02f7504>] dev_mc_add+0xc4/0x11d
[176619.872000]  [<c033cd14>] igmp_group_added+0x10c/0x111
[176619.872000]  [<c033d5ff>] ip_mc_inc_group+0x1a2/0x234
[176619.872000]  [<c033d6b4>] ip_mc_up+0x23/0x66
[176619.872000]  [<c0339392>] inetdev_init+0x117/0x158
[176619.872000]  [<c033ae6f>] devinet_ioctl+0x5db/0x67c
[176619.872000]  [<c033b1cb>] inet_ioctl+0x7b/0x95
[176619.872000]  [<c02e8caa>] sock_ioctl+0xb1/0x252
[176619.872000]  [<c018561a>] do_ioctl+0x2a/0x80
[176619.872000]  [<c01856c2>] vfs_ioctl+0x52/0x2db
[176619.872000]  [<c01859b7>] sys_ioctl+0x6c/0x79
[176619.872000]  [<c036e80d>] sysenter_past_esp+0x56/0x8d
[176619.872000]  [<b7f76410>] 0xb7f76410

The following steps are needed to reproduce the BUG:
vconfig add eth0 2
ifconfig eth0.2 172.31.23.22

This seels to be a false positive because the first dev->xmit_lock held is the
one from the vlan interface and the second is the one belonging to the real
interface.

I considered adding dev_mc_add(..., int nesting) ->net_tx_lock_bh(..., int
nesting) -> spin_lock_bh_nested(..., int nesting) but the number of calling
places is important, so I wondered if someone would come up with a better
solution.

Thanks,
Frederik
