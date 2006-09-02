Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751546AbWIBUjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546AbWIBUjb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 16:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751545AbWIBUjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 16:39:31 -0400
Received: from khc.piap.pl ([195.187.100.11]:32915 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751539AbWIBUja (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 16:39:30 -0400
To: <linux-kernel@vger.kernel.org>
Cc: netdev@vger.kernel.org
Subject: 2.6.18-rc5 with GRE, iptables and Speedtouch ADSL, PPP over ATM
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sat, 02 Sep 2006 22:39:28 +0200
Message-ID: <m3odty57gf.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

FYI: Just enabled kernel lock testers on my old laptop machine
doing "internet services". 2.6.18-rc5, i686. All details available
on request, of course.

There is IP GRE tunnel here running over ADSL connection (USB
Thomson/Alcatel Speedtouch 330, PPP over ATM, in-kernel drivers).
Ethernet is DLink Tulip-based (PC Card 32-bit), probably not
relevant here. Iptables doing mostly ACCEPTs, REJECT and DROPs in
INPUT and FORWARD, there is also MASQUERADE but it probably doesn't
matter. Few ip rules directing some traffic to the GRE tunnel as well.

=======================================================
[ INFO: possible circular locking dependency detected ]
-------------------------------------------------------
swapper/0 is trying to acquire lock:
 (&dev->queue_lock){-+..}, at: [<c02c8c46>] dev_queue_xmit+0x56/0x290

but task is already holding lock:
 (&dev->_xmit_lock){-+..}, at: [<c02c8e14>] dev_queue_xmit+0x224/0x290

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&dev->_xmit_lock){-+..}:
       [<c012e7b6>] lock_acquire+0x76/0xa0
       [<c0336241>] _spin_lock_bh+0x31/0x40
       [<c02d25a9>] dev_activate+0x69/0x120
       [<c02c8149>] dev_open+0x59/0x70
       [<c02c6921>] dev_change_flags+0x51/0x110
       [<c0302464>] devinet_ioctl+0x484/0x670
       [<c030295b>] inet_ioctl+0x6b/0x80
       [<c02bc6e8>] sock_ioctl+0x118/0x200
       [<c01698b0>] do_ioctl+0x20/0x70
       [<c0169957>] vfs_ioctl+0x57/0x290
       [<c0169bc9>] sys_ioctl+0x39/0x60
       [<c0102c8d>] sysenter_past_esp+0x56/0x8d

-> #0 (&dev->queue_lock){-+..}:
       [<c012e7b6>] lock_acquire+0x76/0xa0
       [<c03361fc>] _spin_lock+0x2c/0x40
       [<c02c8c46>] dev_queue_xmit+0x56/0x290
       [<c02e2cfd>] ip_output+0x1ad/0x250
       [<c883dea2>] ipgre_tunnel_xmit+0x412/0x740 [ip_gre]
       [<c02c73db>] dev_hard_start_xmit+0x1bb/0x220
       [<c02c8e2b>] dev_queue_xmit+0x23b/0x290
       [<c02e2cfd>] ip_output+0x1ad/0x250
       [<c03142bc>] reject+0x37c/0x6d0
       [<c0313688>] ipt_do_table+0x2b8/0x330
       [<c03137b7>] ipt_hook+0x27/0x30
       [<c02d6529>] nf_iterate+0x59/0x80
       [<c02d667a>] nf_hook_slow+0x4a/0xc0
       [<c02ddb55>] ip_local_deliver+0x175/0x1c0
       [<c02dd7bc>] ip_rcv+0x25c/0x480
       [<c02c705e>] netif_receive_skb+0x15e/0x1e0
       [<c02c8922>] process_backlog+0x82/0x110
       [<c02c8a22>] net_rx_action+0x72/0x120
       [<c01194b5>] __do_softirq+0x55/0xc0
       [<c0104b13>] do_softirq+0x63/0xd0

other info that might help us debug this:

2 locks held by swapper/0:
 #0:  (&table->lock){-.-+}, at: [<c0313421>] ipt_do_table+0x51/0x330
 #1:  (&dev->_xmit_lock){-+..}, at: [<c02c8e14>] dev_queue_xmit+0x224/0x290

stack backtrace:
 [<c0103522>] show_trace+0x12/0x20
 [<c0103b79>] dump_stack+0x19/0x20
 [<c012d6c1>] print_circular_bug_tail+0x61/0x70
 [<c012e196>] __lock_acquire+0xac6/0xd70
 [<c012e7b6>] lock_acquire+0x76/0xa0
 [<c03361fc>] _spin_lock+0x2c/0x40
 [<c02c8c46>] dev_queue_xmit+0x56/0x290
 [<c02e2cfd>] ip_output+0x1ad/0x250
 [<c883dea2>] ipgre_tunnel_xmit+0x412/0x740 [ip_gre]
 [<c02c73db>] dev_hard_start_xmit+0x1bb/0x220
 [<c02c8e2b>] dev_queue_xmit+0x23b/0x290
 [<c02e2cfd>] ip_output+0x1ad/0x250
 [<c03142bc>] reject+0x37c/0x6d0
 [<c0313688>] ipt_do_table+0x2b8/0x330
 [<c03137b7>] ipt_hook+0x27/0x30
 [<c02d6529>] nf_iterate+0x59/0x80
 [<c02d667a>] nf_hook_slow+0x4a/0xc0
 [<c02ddb55>] ip_local_deliver+0x175/0x1c0
 [<c02dd7bc>] ip_rcv+0x25c/0x480
 [<c02c705e>] netif_receive_skb+0x15e/0x1e0
 [<c02c8922>] process_backlog+0x82/0x110
 [<c02c8a22>] net_rx_action+0x72/0x120
 [<c01194b5>] __do_softirq+0x55/0xc0
 [<c0104b13>] do_softirq+0x63/0xd0
 =======================
 [<c0119395>] irq_exit+0x35/0x40
 [<c0104c0f>] do_IRQ+0x8f/0xf0
 [<c0102ef9>] common_interrupt+0x25/0x2c
 [<c01018e9>] cpu_idle+0x39/0x50
 [<c010052e>] rest_init+0x1e/0x30
 [<c041f76e>] start_kernel+0x25e/0x2c0
 [<c0100199>] 0xc0100199

-- 
Krzysztof Halasa

-- 
VGER BF report: U 0.5
