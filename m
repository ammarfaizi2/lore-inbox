Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWC2OIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWC2OIt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 09:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbWC2OIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 09:08:49 -0500
Received: from mail.daysofwonder.com ([213.186.49.53]:28377 "EHLO
	mail.daysofwonder.com") by vger.kernel.org with ESMTP
	id S1750739AbWC2OIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 09:08:48 -0500
Subject: BUG: ide related "soft lockup detected on CPU"
From: Brice Figureau <brice+lklm@daysofwonder.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 29 Mar 2006 16:07:15 +0200
Message-Id: <1143641235.15002.51.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just encountered the following traces in my logs on a mail server.
The server is a mono Xeon HT running an highmem SMP 2.6.15.1 kernel.
The server uses a md raid1 array of several partitions of two PATA hard
disk.

First evidence:
at 19:05 I got the following:

kernel: hdc: irq timeout: status=0xd0 { Busy }
kernel: ide: failed opcode was: 0xe7
kernel: hdc: status timeout: status=0xd0 { Busy }
kernel: ide: failed opcode was: unknown
kernel: hdc: DMA disabled
kernel: hdc: drive not ready for command
kernel: ide1: reset: success

then the BUG: exactly two hours later:

kernel: BUG: soft lockup detected on CPU#0!
kernel:
kernel: Pid: 8, comm:             events/0
kernel: EIP: 0060:[ide_pio_sector+193/247] CPU: 0
kernel: EIP is at ide_pio_sector+0xc1/0xf7
kernel:  EFLAGS: 00000202    Not tainted  (2.6.15.1-zen)
kernel: EAX: c1972000 EBX: c277ac00 ECX: 00000000 EDX: 00000170
kernel: ESI: 00000001 EDI: c04ebc80 EBP: c1973b0c DS: 007b ES: 007b
kernel: CR0: 8005003b CR2: 080d1000 CR3: 19df5000 CR4: 000006d0
kernel:  [show_regs+351/393] show_regs+0x15f/0x189
kernel:  [softlockup_tick+125/134] softlockup_tick+0x7d/0x86
kernel:  [do_timer+71/209] do_timer+0x47/0xd1
kernel:  [timer_interrupt+54/128] timer_interrupt+0x36/0x80
kernel:  [handle_IRQ_event+51/106] handle_IRQ_event+0x33/0x6a
kernel:  [__do_IRQ+139/243] __do_IRQ+0x8b/0xf3
kernel:  [do_IRQ+28/40] do_IRQ+0x1c/0x28
kernel:  [common_interrupt+26/32] common_interrupt+0x1a/0x20
kernel:  [ide_pio_multi+61/74] ide_pio_multi+0x3d/0x4a
kernel:  [task_out_intr+223/267] task_out_intr+0xdf/0x10b
kernel:  [ide_intr+199/329] ide_intr+0xc7/0x149
kernel:  [handle_IRQ_event+51/106] handle_IRQ_event+0x33/0x6a
kernel:  [__do_IRQ+139/243] __do_IRQ+0x8b/0xf3
kernel:  [do_IRQ+28/40] do_IRQ+0x1c/0x28
kernel:  [common_interrupt+26/32] common_interrupt+0x1a/0x20
kernel:  [pg0+942723126/1068528640] ipt_hook+0x36/0x3a [iptable_filter]
kernel:  [nf_iterate+105/129] nf_iterate+0x69/0x81
kernel:  [nf_hook_slow+99/258] nf_hook_slow+0x63/0x102
kernel:  [ip_local_deliver+455/508] ip_local_deliver+0x1c7/0x1fc
kernel:  [ip_rcv+667/1323] ip_rcv+0x29b/0x52b
kernel:  [netif_receive_skb+428/577] netif_receive_skb+0x1ac/0x241
kernel:  [e1000_clean_rx_irq+384/1279] e1000_clean_rx_irq+0x180/0x4ff
kernel:  [e1000_clean+164/345] e1000_clean+0xa4/0x159
kernel:  [net_rx_action+155/374] net_rx_action+0x9b/0x176
kernel:  [__do_softirq+194/215] __do_softirq+0xc2/0xd7
kernel:  [do_softirq+54/56] do_softirq+0x36/0x38
kernel:  [irq_exit+56/58] irq_exit+0x38/0x3a
kernel:  [do_IRQ+33/40] do_IRQ+0x21/0x28
kernel:  [common_interrupt+26/32] common_interrupt+0x1a/0x20
kernel:  [update_defense_level+246/577] update_defense_level+0xf6/0x241
kernel:  [defense_work_handler+8/41] defense_work_handler+0x8/0x29
kernel:  [worker_thread+404/549] worker_thread+0x194/0x225
kernel:  [kthread+183/188] kthread+0xb7/0xbc
kernel:  [kernel_thread_helper+5/11] kernel_thread_helper+0x5/0xb

then another one exactly two hours later:
kernel: BUG: soft lockup detected on CPU#0!
kernel:
kernel: Pid: 813, comm:            md7_raid1
kernel: EIP: 0060:[ide_pio_sector+193/247] CPU: 0
kernel: EIP is at ide_pio_sector+0xc1/0xf7
kernel:  EFLAGS: 00000206    Not tainted  (2.6.15.1-zen)
kernel: EAX: f7de6000 EBX: e4b4d200 ECX: 00000000 EDX: 00000170
kernel: ESI: 00000001 EDI: c04ebc80 EBP: f7de77e4 DS: 007b ES: 007b
kernel: CR0: 8005003b CR2: 0807a564 CR3: 28101000 CR4: 000006d0
kernel:  [show_regs+351/393] show_regs+0x15f/0x189
kernel:  [softlockup_tick+125/134] softlockup_tick+0x7d/0x86
kernel:  [do_timer+71/209] do_timer+0x47/0xd1
kernel:  [timer_interrupt+54/128] timer_interrupt+0x36/0x80
kernel:  [handle_IRQ_event+51/106] handle_IRQ_event+0x33/0x6a
kernel:  [__do_IRQ+139/243] __do_IRQ+0x8b/0xf3
kernel:  [do_IRQ+28/40] do_IRQ+0x1c/0x28
kernel:  [common_interrupt+26/32] common_interrupt+0x1a/0x20
kernel:  [ide_pio_multi+61/74] ide_pio_multi+0x3d/0x4a
kernel:  [task_out_intr+223/267] task_out_intr+0xdf/0x10b
kernel:  [ide_intr+199/329] ide_intr+0xc7/0x149
kernel:  [handle_IRQ_event+51/106] handle_IRQ_event+0x33/0x6a
kernel:  [__do_IRQ+139/243] __do_IRQ+0x8b/0xf3
kernel:  [do_IRQ+28/40] do_IRQ+0x1c/0x28
kernel:  [common_interrupt+26/32] common_interrupt+0x1a/0x20
kernel:  [pg0+942826616/1068528640] ip_conntrack_find_get+0x13/0x53
[ip_conntrack]
kernel:  [pg0+942829645/1068528640] ip_conntrack_in+0x1cd/0x2fd
[ip_conntrack]
kernel:  [pg0+942823525/1068528640] ip_conntrack_local+0x68/0x6a
[ip_conntrack]
kernel:  [nf_iterate+105/129] nf_iterate+0x69/0x81
kernel:  [nf_hook_slow+99/258] nf_hook_slow+0x63/0x102
kernel:  [ip_queue_xmit+1049/1372] ip_queue_xmit+0x419/0x55c
kernel:  [tcp_transmit_skb+1157/1888] tcp_transmit_skb+0x485/0x760
kernel:  [tcp_send_ack+186/256] tcp_send_ack+0xba/0x100
kernel:  [__tcp_ack_snd_check+94/129] __tcp_ack_snd_check+0x5e/0x81
kernel:  [tcp_rcv_established+1708/2214] tcp_rcv_established+0x6ac/0x8a6
kernel:  [tcp_v4_do_rcv+268/273] tcp_v4_do_rcv+0x10c/0x111
kernel:  [tcp_v4_rcv+1564/2089] tcp_v4_rcv+0x61c/0x829
kernel:  [ip_local_deliver+199/508] ip_local_deliver+0xc7/0x1fc
kernel:  [ip_rcv+667/1323] ip_rcv+0x29b/0x52b
kernel:  [netif_receive_skb+428/577] netif_receive_skb+0x1ac/0x241
kernel:  [e1000_clean_rx_irq+384/1279] e1000_clean_rx_irq+0x180/0x4ff
kernel:  [e1000_clean+164/345] e1000_clean+0xa4/0x159
kernel:  [net_rx_action+155/374] net_rx_action+0x9b/0x176
kernel:  [__do_softirq+194/215] __do_softirq+0xc2/0xd7
kernel:  [do_softirq+54/56] do_softirq+0x36/0x38
kernel:  [irq_exit+56/58] irq_exit+0x38/0x3a
kernel:  [do_IRQ+33/40] do_IRQ+0x21/0x28
kernel:  [common_interrupt+26/32] common_interrupt+0x1a/0x20
kernel:  [set_page_address+305/368] set_page_address+0x131/0x170
kernel:  [flush_all_zero_pkmaps+108/110] flush_all_zero_pkmaps+0x6c/0x6e
kernel:  [kmap_high+371/387] kmap_high+0x173/0x183
kernel:  [kmap+55/57] kmap+0x37/0x39
kernel:  [__blk_queue_bounce+476/556] __blk_queue_bounce+0x1dc/0x22c
kernel:  [blk_queue_bounce+55/78] blk_queue_bounce+0x37/0x4e
kernel:  [__make_request+87/1186] __make_request+0x57/0x4a2
kernel:  [generic_make_request+176/285] generic_make_request+0xb0/0x11d
kernel:  [raid1d+864/882] raid1d+0x360/0x372
kernel:  [md_thread+101/288] md_thread+0x65/0x120
kernel:  [kthread+183/188] kthread+0xb7/0xbc
kernel:  [kernel_thread_helper+5/11] kernel_thread_helper+0x5/0xb

and then the next one, exactly one hour later:
kernel: BUG: soft lockup detected on CPU#0!
kernel:
kernel: Pid: 813, comm:            md7_raid1
kernel: EIP: 0060:[ide_pio_sector+193/247] CPU: 0
kernel: EIP is at ide_pio_sector+0xc1/0xf7
kernel:  EFLAGS: 00000206    Not tainted  (2.6.15.1-zen)
kernel: EAX: f7de6000 EBX: d02fd000 ECX: 00000000 EDX: 00000170
kernel: ESI: 00000001 EDI: c04ebc80 EBP: f7de7a2c DS: 007b ES: 007b
kernel: CR0: 8005003b CR2: b7f2aee0 CR3: 004bc000 CR4: 000006d0
kernel:  [show_regs+351/393] show_regs+0x15f/0x189
kernel:  [softlockup_tick+125/134] softlockup_tick+0x7d/0x86
kernel:  [do_timer+71/209] do_timer+0x47/0xd1
kernel:  [timer_interrupt+54/128] timer_interrupt+0x36/0x80
kernel:  [handle_IRQ_event+51/106] handle_IRQ_event+0x33/0x6a
kernel:  [__do_IRQ+139/243] __do_IRQ+0x8b/0xf3
kernel:  [do_IRQ+28/40] do_IRQ+0x1c/0x28
kernel:  [common_interrupt+26/32] common_interrupt+0x1a/0x20
kernel:  [ide_pio_multi+61/74] ide_pio_multi+0x3d/0x4a
kernel:  [pre_task_out_intr+255/257] pre_task_out_intr+0xff/0x101
kernel:  [__ide_do_rw_disk+687/1246] __ide_do_rw_disk+0x2af/0x4de
kernel:  [ide_do_rw_disk+65/144] ide_do_rw_disk+0x41/0x90
kernel:  [start_request+308/537] start_request+0x134/0x219
kernel:  [ide_do_request+552/923] ide_do_request+0x228/0x39b
kernel:  [ide_intr+260/329] ide_intr+0x104/0x149
kernel:  [handle_IRQ_event+51/106] handle_IRQ_event+0x33/0x6a
kernel:  [__do_IRQ+139/243] __do_IRQ+0x8b/0xf3
kernel:  [do_IRQ+28/40] do_IRQ+0x1c/0x28
kernel:  [common_interrupt+26/32] common_interrupt+0x1a/0x20
kernel:  [pg0+942723126/1068528640] ipt_hook+0x36/0x3a [iptable_filter]
kernel:  [nf_iterate+105/129] nf_iterate+0x69/0x81
kernel:  [nf_hook_slow+99/258] nf_hook_slow+0x63/0x102
kernel:  [ip_local_deliver+455/508] ip_local_deliver+0x1c7/0x1fc
kernel:  [ip_rcv+667/1323] ip_rcv+0x29b/0x52b
kernel:  [netif_receive_skb+428/577] netif_receive_skb+0x1ac/0x241
kernel:  [e1000_clean_rx_irq+384/1279] e1000_clean_rx_irq+0x180/0x4ff
kernel:  [e1000_clean+164/345] e1000_clean+0xa4/0x159
kernel:  [net_rx_action+155/374] net_rx_action+0x9b/0x176
kernel:  [__do_softirq+194/215] __do_softirq+0xc2/0xd7
kernel:  [do_softirq+54/56] do_softirq+0x36/0x38
kernel:  [irq_exit+56/58] irq_exit+0x38/0x3a
kernel:  [do_IRQ+33/40] do_IRQ+0x21/0x28
kernel:  [common_interrupt+26/32] common_interrupt+0x1a/0x20
kernel:  [generic_make_request+176/285] generic_make_request+0xb0/0x11d
kernel:  [raid1d+864/882] raid1d+0x360/0x372
kernel:  [md_thread+101/288] md_thread+0x65/0x120
kernel:  [kthread+183/188] kthread+0xb7/0xbc
kernel:  [kernel_thread_helper+5/11] kernel_thread_helper+0x5/0xb

If I understood correctly, the kernel spent too much time in a soft
interrupt that was trying to use one of the ide drive.

What is strange is the interval of time between the problems. I looked
to the cron list to see what happens each hours at this exact time.
It seems that the culprit is sysstat.
It is setup to perform at 19:05 a daily summary, and every 5 minutes
sysstat is running to gather statistics.

Also note, that /dev/md7 holds /var/log where sysstat is storing its
statistics.

Also note that it's the first time it does that since I got this server
2 years ago.

Is it a kernel bug, a hardware problem or simply because the server was
busy doing writes or reads ?

I'm not subscribed to the list as I'm reading it through its archives,
so please CC: me.

Thank you for any answer,
--
Brice Figureau

