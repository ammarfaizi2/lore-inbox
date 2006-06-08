Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964944AbWFHTHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964944AbWFHTHg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 15:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964945AbWFHTHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 15:07:35 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:34481 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S964944AbWFHTHf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 15:07:35 -0400
Message-ID: <448875D1.5080905@free.fr>
Date: Thu, 08 Jun 2006 21:09:05 +0200
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Kernel development list <linux-kernel@vger.kernel.org>
Subject: 2.6.17-rc6-mm1/pktcdvd - BUG: possible circular locking
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This BUG happened while pktcdvd service was starting. 
Basically, the 2 following commands were issued:
- modprobe ptkcdvd
- pktsetup dvd /dev/dvd

 
cdrom: This disc doesn't have any tracks I recognize!
pktcdvd: writer pktcdvd0 mapped to hdc

=====================================================
[ BUG: possible circular locking deadlock detected! ]
-----------------------------------------------------
vol_id/2298 is trying to acquire lock:
 (&ctl_mutex){....}, at: [<c027fa01>] mutex_lock+0x21/0x24

but task is already holding lock:
 (&bdev->bd_mutex){....}, at: [<c0155009>] do_open+0x68/0x38b

which lock already depends on the new lock,
which could lead to circular deadlocks!

the existing dependency chain (in reverse order) is:

-> #1 (&bdev->bd_mutex){....}:
       [<c01294c1>] lock_acquire+0x43/0x5c
       [<c027fab7>] mutex_lock_nested+0xb3/0x1db
       [<c0155009>] do_open+0x68/0x38b
       [<c015539a>] blkdev_get+0x6e/0x79
       [<e0ebf2aa>] pkt_ctl_ioctl+0x20f/0x586 [pktcdvd]
       [<c015cea0>] do_ioctl+0x3c/0x4f
       [<c015d0b6>] vfs_ioctl+0x203/0x21a
       [<c015d0f9>] sys_ioctl+0x2c/0x47
       [<c0280985>] sysenter_past_esp+0x56/0x79

-> #0 (&ctl_mutex){....}:
       [<c01294c1>] lock_acquire+0x43/0x5c
       [<c027f8b8>] __mutex_lock_slowpath+0x9b/0x1c3
       [<c027fa01>] mutex_lock+0x21/0x24
       [<e0ebffd7>] pkt_open+0x1e/0xbef [pktcdvd]
       [<c015503b>] do_open+0x9a/0x38b
       [<c01554b3>] blkdev_open+0x1f/0x48
       [<c014d229>] __dentry_open+0xb8/0x186
       [<c014d365>] nameidata_to_filp+0x1c/0x2e
       [<c014d3a5>] do_filp_open+0x2e/0x35
       [<c014e24a>] do_sys_open+0x40/0xbb
       [<c014e2f1>] sys_open+0x16/0x18
       [<c0280985>] sysenter_past_esp+0x56/0x79

other info that might help us debug this:

1 lock held by vol_id/2298:
 #0:  (&bdev->bd_mutex){....}, at: [<c0155009>] do_open+0x68/0x38b

stack backtrace:
 [<c0104836>] show_trace+0xd/0x10
 [<c0104852>] dump_stack+0x19/0x1b
 [<c0128c32>] print_circular_bug_tail+0x59/0x64
 [<c0129358>] __lock_acquire+0x5a9/0x6cf
 [<c01294c1>] lock_acquire+0x43/0x5c
 [<c027f8b8>] __mutex_lock_slowpath+0x9b/0x1c3
 [<c027fa01>] mutex_lock+0x21/0x24
 [<e0ebffd7>] pkt_open+0x1e/0xbef [pktcdvd]
 [<c015503b>] do_open+0x9a/0x38b
 [<c01554b3>] blkdev_open+0x1f/0x48
 [<c014d229>] __dentry_open+0xb8/0x186
 [<c014d365>] nameidata_to_filp+0x1c/0x2e
 [<c014d3a5>] do_filp_open+0x2e/0x35
 [<c014e24a>] do_sys_open+0x40/0xbb
 [<c014e2f1>] sys_open+0x16/0x18
 [<c0280985>] sysenter_past_esp+0x56/0x79
