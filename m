Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261519AbUKILCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbUKILCI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 06:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbUKIK7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 05:59:19 -0500
Received: from calvin.codito.com ([203.199.140.162]:28821 "EHLO
	magrathea.codito.co.in") by vger.kernel.org with ESMTP
	id S261497AbUKIK4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 05:56:01 -0500
From: Amit Shah <amit.shah@codito.com>
Organization: Codito Technologies
To: Ingo Molnar <mingo@elte.hu>
Subject: RT-V0.7.22 Bug with fbdev and e100
Date: Tue, 9 Nov 2004 16:23:50 +0530
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
X-GnuPG-Fingerprint: 3001 346D 47C2 E445 EC1B  2EE1 E8FD 8F83 4E56 1092
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411091623.51495.amit.shah@codito.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

I got this:

ifconfig/4106: BUG in enable_irq at kernel/irq/manage.c:112
BUG: sleeping function called from invalid context ifconfig(4106) at 
kernel/rt.c:1320
in_atomic():1 [00000001], irqs_disabled():0
 [<c0108047>] dump_stack+0x1e/0x22 (20)
 [<c0120f35>] __might_sleep+0xba/0xc9 (36)
 [<c013d07a>] __spin_lock+0x33/0x52 (24)
 [<c013d0b1>] _spin_lock+0x18/0x1c (16)
 [<c01501ea>] kmem_cache_alloc+0x40/0xff (32)
 [<c01f48dc>] soft_cursor+0x50/0x23c (80)
 [<c01efa57>] bit_cursor+0x297/0x474 (160)
 [<c01eb73f>] fbcon_cursor+0x1af/0x273 (68)
 [<c022752b>] hide_cursor+0x2c/0x41 (20)
 [<c022abbb>] vt_console_print+0x307/0x316 (52)
 [<c0124ada>] __call_console_drivers+0x5e/0x60 (32)
 [<c0124c0b>] call_console_drivers+0xb3/0x154 (40)
 [<c0124fb3>] release_console_sem+0x52/0xe3 (32)
 [<c0124eb2>] vprintk+0x119/0x160 (36)
 [<c0124d95>] printk+0x18/0x1c (16)
 [<c014508a>] enable_irq+0xe6/0xf0 (52)
 [<f8c2b370>] e100_up+0x111/0x21f [e100] (48)
 [<f8c2c5d8>] e100_open+0x2c/0x71 [e100] (32)
 [<c027a4f5>] dev_open+0x78/0x86 (28)
 [<c027bc4a>] dev_change_flags+0x56/0x127 (36)
 [<c02b8c60>] devinet_ioctl+0x242/0x5bc (104)
 [<c02badc6>] inet_ioctl+0x5a/0x9a (28)
 [<c027131c>] sock_ioctl+0xbb/0x21f (32)
 [<c0179ef7>] sys_ioctl+0xdc/0x241 (44)
 [<c0107177>] syscall_call+0x7/0xb (-8124)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c02cc920>] .... _raw_spin_lock_irqsave+0x1d/0x82
.....[<c0144fcc>] ..   ( <= enable_irq+0x28/0xf0)
.. [<c013ddd0>] .... print_traces+0x18/0x4c
.....[<c0108047>] ..   ( <= dump_stack+0x1e/0x22)

 [<c0108047>] dump_stack+0x1e/0x22 (20)
 [<c014508f>] enable_irq+0xeb/0xf0 (52)
 [<f8c2b370>] e100_up+0x111/0x21f [e100] (48)
 [<f8c2c5d8>] e100_open+0x2c/0x71 [e100] (32)
 [<c027a4f5>] dev_open+0x78/0x86 (28)
 [<c027bc4a>] dev_change_flags+0x56/0x127 (36)
 [<c02b8c60>] devinet_ioctl+0x242/0x5bc (104)
 [<c02badc6>] inet_ioctl+0x5a/0x9a (28)
 [<c027131c>] sock_ioctl+0xbb/0x21f (32)
 [<c0179ef7>] sys_ioctl+0xdc/0x241 (44)
 [<c0107177>] syscall_call+0x7/0xb (-8124)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c02cc920>] .... _raw_spin_lock_irqsave+0x1d/0x82
.....[<c0144fcc>] ..   ( <= enable_irq+0x28/0xf0)
.. [<c013ddd0>] .... print_traces+0x18/0x4c
.....[<c0108047>] ..   ( <= dump_stack+0x1e/0x22)

IRQ#17 thread RT prio: 44.
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
IRQ#3 thread RT prio: 43.
IRQ#8 thread RT prio: 42.


drivers/video/console/fbcon.c:fbcon_cursor needs additional locking?

Amit.
-- 
Amit Shah
Codito Technologies Pvt. Ltd.
