Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbWGGRTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbWGGRTU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 13:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbWGGRTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 13:19:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31894 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932193AbWGGRTS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 13:19:18 -0400
Date: Fri, 7 Jul 2006 13:19:16 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: netdev@vger.kernel.org
Subject: e100 lockdep irq lock inversion.
Message-ID: <20060707171916.GA16343@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another one triggered by a Fedora-development user..

e100: eth1: e100_watchdog: link up, 100Mbps, half-duplex

=========================================================
[ INFO: possible irq lock inversion dependency detected ]
---------------------------------------------------------
ipcalc/1671 just changed the state of lock:
 (&skb_queue_lock_key){-+..}, at: [<c05ebe2f>] udp_ioctl+0x3b/0x6e
but this lock was taken by another, hard-irq-safe lock in the past:
 (&ai->aux_lock){+...}

and interrupts could create inverse lock ordering between them.


other info that might help us debug this:
no locks held by ipcalc/1671.

the first lock's dependencies:
-> (&skb_queue_lock_key){-+..} ops: 0 {
   initial-use  at:
                        [<c043c546>] lock_acquire+0x4b/0x6d
                        [<c060e5c7>] _spin_lock_irqsave+0x22/0x32
                        [<c05b0d2d>] skb_queue_tail+0x14/0x32
                        [<c05c8a53>] netlink_broadcast+0x1bf/0x28e
                        [<c04e414b>] kobject_uevent+0x345/0x3b6
                        [<c055080d>] class_device_add+0x2a7/0x3e6
                        [<c0594d0c>] input_register_device+0x106/0x238
                        [<c059947a>] psmouse_connect+0x162/0x20f
                        [<c0590a09>] serio_connect_driver+0x1e/0x2e
                        [<c0590a2f>] serio_driver_probe+0x16/0x18
                        [<c054f9a6>] driver_probe_device+0x45/0x92
                        [<c054fad3>] __driver_attach+0x68/0x93
                        [<c054f420>] bus_for_each_dev+0x3a/0x5f
                        [<c054f901>] driver_attach+0x14/0x17
                        [<c054f0f7>] bus_add_driver+0x68/0x106
                        [<c054fda1>] driver_register+0x9d/0xa2
                        [<c0591522>] serio_thread+0x152/0x27c
                        [<c04365dc>] kthread+0xc3/0xef
                        [<c0402005>] kernel_thread_helper+0x5/0xb
   in-softirq-W at:
                        [<c043c546>] lock_acquire+0x4b/0x6d
                        [<c060e5c7>] _spin_lock_irqsave+0x22/0x32
                        [<c05b0d2d>] skb_queue_tail+0x14/0x32
                        [<c05b05c4>] sock_queue_rcv_skb+0xe3/0x11f
                        [<c060adae>] packet_rcv_spkt+0x120/0x136
                        [<c05b5b86>] netif_receive_skb+0x1d4/0x26b
                        [<e09fa8e8>] e100_poll+0x15a/0x2fc [e100]
                        [<c05b7682>] net_rx_action+0xa6/0x1df
                        [<c0429809>] __do_softirq+0x78/0xf2
                        [<c04065ab>] do_softirq+0x5a/0xbe
   hardirq-on-W at:
                        [<c043c546>] lock_acquire+0x4b/0x6d
                        [<c060e2c8>] _spin_lock_bh+0x1e/0x2d
                        [<c05ebe2f>] udp_ioctl+0x3b/0x6e
                        [<c05f08e7>] inet_ioctl+0x8c/0x91
                        [<c05acabc>] sock_ioctl+0x1b5/0x1d3
                        [<c0481e56>] do_ioctl+0x22/0x67
                        [<c04820f3>] vfs_ioctl+0x258/0x26b
                        [<c048214d>] sys_ioctl+0x47/0x62
                        [<c0403f2f>] syscall_call+0x7/0xb
 }
 ... key      at: [<c09b0748>] skb_queue_lock_key+0x0/0x18

the second lock's dependencies:
-> (&ai->aux_lock){+...} ops: 0 {
   initial-use  at:
                        [<c043c546>] lock_acquire+0x4b/0x6d
                        [<c060e5c7>] _spin_lock_irqsave+0x22/0x32
                        [<e09b6cd8>] mpi_start_xmit+0x79/0xdd [airo]
                        [<c05b5fc5>] dev_hard_start_xmit+0x19f/0x1fc
                        [<c05c48d8>] __qdisc_run+0xdd/0x197
                        [<c05b7a40>] dev_queue_xmit+0x12a/0x222
                        [<c060a98a>] packet_sendmsg_spkt+0x172/0x199
                        [<c05ac5df>] sock_sendmsg+0xe8/0x103
                        [<c05ad7a7>] sys_sendto+0xbe/0xdc
                        [<c05adf27>] sys_socketcall+0xfb/0x186
                        [<c0403f2f>] syscall_call+0x7/0xb
   in-hardirq-W at:
                        [<c043c546>] lock_acquire+0x4b/0x6d
                        [<c060e5c7>] _spin_lock_irqsave+0x22/0x32
                        [<e09b7b6d>] airo_interrupt+0xe31/0xffb [airo]
                        [<c0451020>] handle_IRQ_event+0x20/0x4d
                        [<c04510e1>] __do_IRQ+0x94/0xef
                        [<c04066c8>] do_IRQ+0xb9/0xcd
                        [<c04049d1>] common_interrupt+0x25/0x2c
                        [<c04030aa>] cpu_idle+0xa7/0xc1
                        [<c0400591>] rest_init+0x23/0x26
                        [<c07a7810>] start_kernel+0x3a1/0x3a9
                        [<c0400210>] 0xc0400210
 }
 ... key      at: [<e09c2a80>] __key.24227+0x0/0xffff6704 [airo]
  -> (&skb_queue_lock_key){-+..} ops: 0 {
     initial-use  at:
                      [<c043c546>] lock_acquire+0x4b/0x6d
                      [<c060e5c7>] _spin_lock_irqsave+0x22/0x32
                      [<c05b0d2d>] skb_queue_tail+0x14/0x32
                      [<c05c8a53>] netlink_broadcast+0x1bf/0x28e
                      [<c04e414b>] kobject_uevent+0x345/0x3b6
                      [<c055080d>] class_device_add+0x2a7/0x3e6
                      [<c0594d0c>] input_register_device+0x106/0x238
                      [<c059947a>] psmouse_connect+0x162/0x20f
                      [<c0590a09>] serio_connect_driver+0x1e/0x2e
                      [<c0590a2f>] serio_driver_probe+0x16/0x18
                      [<c054f9a6>] driver_probe_device+0x45/0x92
                      [<c054fad3>] __driver_attach+0x68/0x93
                      [<c054f420>] bus_for_each_dev+0x3a/0x5f
                      [<c054f901>] driver_attach+0x14/0x17
                      [<c054f0f7>] bus_add_driver+0x68/0x106
                      [<c054fda1>] driver_register+0x9d/0xa2
                      [<c0591522>] serio_thread+0x152/0x27c
                      [<c04365dc>] kthread+0xc3/0xef
                      [<c0402005>] kernel_thread_helper+0x5/0xb
     in-softirq-W at:
                      [<c043c546>] lock_acquire+0x4b/0x6d
                      [<c060e5c7>] _spin_lock_irqsave+0x22/0x32
                      [<c05b0d2d>] skb_queue_tail+0x14/0x32
                      [<c05b05c4>] sock_queue_rcv_skb+0xe3/0x11f
                      [<c060adae>] packet_rcv_spkt+0x120/0x136
                      [<c05b5b86>] netif_receive_skb+0x1d4/0x26b
                      [<e09fa8e8>] e100_poll+0x15a/0x2fc [e100]
                      [<c05b7682>] net_rx_action+0xa6/0x1df
                      [<c0429809>] __do_softirq+0x78/0xf2
                      [<c04065ab>] do_softirq+0x5a/0xbe
     hardirq-on-W at:
                      [<c043c546>] lock_acquire+0x4b/0x6d
                      [<c060e2c8>] _spin_lock_bh+0x1e/0x2d
                      [<c05ebe2f>] udp_ioctl+0x3b/0x6e
                      [<c05f08e7>] inet_ioctl+0x8c/0x91
                      [<c05acabc>] sock_ioctl+0x1b5/0x1d3
                      [<c0481e56>] do_ioctl+0x22/0x67
                      [<c04820f3>] vfs_ioctl+0x258/0x26b
                      [<c048214d>] sys_ioctl+0x47/0x62
                      [<c0403f2f>] syscall_call+0x7/0xb
   }
   ... key      at: [<c09b0748>] skb_queue_lock_key+0x0/0x18
 ... acquired at:
   [<c043c546>] lock_acquire+0x4b/0x6d
   [<c060e5c7>] _spin_lock_irqsave+0x22/0x32
   [<c05b0d2d>] skb_queue_tail+0x14/0x32
   [<e09b6ce8>] mpi_start_xmit+0x89/0xdd [airo]
   [<c05b5fc5>] dev_hard_start_xmit+0x19f/0x1fc
   [<c05c48d8>] __qdisc_run+0xdd/0x197
   [<c05b7a40>] dev_queue_xmit+0x12a/0x222
   [<c060a98a>] packet_sendmsg_spkt+0x172/0x199
   [<c05ac5df>] sock_sendmsg+0xe8/0x103
   [<c05ad7a7>] sys_sendto+0xbe/0xdc
   [<c05adf27>] sys_socketcall+0xfb/0x186
   [<c0403f2f>] syscall_call+0x7/0xb


stack backtrace:
 [<c0405167>] show_trace_log_lvl+0x54/0xfd
 [<c040571e>] show_trace+0xd/0x10
 [<c040583d>] dump_stack+0x19/0x1b
 [<c043aa70>] print_irq_inversion_bug+0xe1/0xee
 [<c043ab6e>] check_usage_backwards+0x32/0x3b
 [<c043ae49>] mark_lock+0x217/0x36a
 [<c043ba86>] __lock_acquire+0x43e/0x98d
 [<c043c546>] lock_acquire+0x4b/0x6d
 [<c060e2c8>] _spin_lock_bh+0x1e/0x2d
 [<c05ebe2f>] udp_ioctl+0x3b/0x6e
 [<c05f08e7>] inet_ioctl+0x8c/0x91
 [<c05acabc>] sock_ioctl+0x1b5/0x1d3
 [<c0481e56>] do_ioctl+0x22/0x67
 [<c04820f3>] vfs_ioctl+0x258/0x26b
 [<c048214d>] sys_ioctl+0x47/0x62
 [<c0403f2f>] syscall_call+0x7/0xb

-- 
http://www.codemonkey.org.uk
