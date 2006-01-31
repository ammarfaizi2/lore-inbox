Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751504AbWAaV0D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbWAaV0D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 16:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbWAaV0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 16:26:03 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:1946 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751504AbWAaV0B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 16:26:01 -0500
Date: Tue, 31 Jan 2006 22:24:32 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [lock validator] inet6_destroy_sock(): soft-safe -> soft-unsafe lock dependency
Message-ID: <20060131212432.GA18812@elte.hu>
References: <20060127001807.GA17179@elte.hu> <E1F2IcV-0007Iq-00@gondolin.me.apana.org.au> <20060128152204.GA13940@elte.hu> <20060131102758.GA31460@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060131102758.GA31460@gondor.apana.org.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Herbert Xu <herbert@gondor.apana.org.au> wrote:

> This inference is where the validator errs.  sk_dst_lock is never (or 
> should never be, and as far as I can see none of the traces show it to 
> do so) obtained in a real softirq context.

just to make sure - is the trace below a safe use of sk_dst_lock too?  
Here sk_dst_lock seems to be taken in real softirq context.

	Ingo

============================
[ BUG: illegal lock usage! ]
----------------------------
illegal {softirq-on} -> {in-softirq} usage.
sshd/2476 [HC0[0]:SC1[2]:HE1:SE0] takes:
 (&sk->sk_dst_lock){-+}, at: [<c0499015>] inet6_destroy_sock+0x25/0x100
{softirq-on} state was registered at:
 [<c04a1bd8>] ipv6_dev_get_saddr+0x138/0x640
hardirqs last enabled at: [<c04dea45>] _spin_unlock_irqrestore+0x25/0x30
softirqs last enabled at: [<c01231e5>] irq_exit+0x45/0x50

other info that might help us debug this:
3 locks held by sshd/2476:
 #0:  (&p->proc_lock){--}, at: [<c011f1a3>] release_task+0x23/0x150
 #1:  (&tp->rx_lock){-+}, at: [<c0342a15>] rtl8139_poll+0x45/0x4c0
 #2:  (&sk->sk_lock.slock/1){-+}, at: [<c047e8f6>] tcp_v4_rcv+0x726/0x9d0

stack backtrace:
 [<c010437d>] show_trace+0xd/0x10
 [<c0104397>] dump_stack+0x17/0x20
 [<c0139538>] print_usage_bug+0x1d8/0x230
 [<c01398a8>] mark_lock+0x318/0x350
 [<c0139d73>] debug_lock_chain+0x493/0x1090
 [<c013a9ad>] debug_lock_chain_spin+0x3d/0x60
 [<c0269272>] _raw_write_lock+0x32/0x1a0
 [<c04de9e8>] _write_lock+0x8/0x10
 [<c0499015>] inet6_destroy_sock+0x25/0x100
 [<c04b8672>] tcp_v6_destroy_sock+0x12/0x20
 [<c046bbda>] inet_csk_destroy_sock+0x4a/0x150
 [<c047625c>] tcp_rcv_state_process+0xd4c/0xdd0
 [<c047d8e9>] tcp_v4_do_rcv+0xa9/0x340
 [<c047eabb>] tcp_v4_rcv+0x8eb/0x9d0
 [<c0462c76>] ip_local_deliver+0xa6/0x190
 [<c04629f8>] ip_rcv+0x2f8/0x4d0
 [<c044bcb6>] netif_receive_skb+0x1b6/0x2a0
 [<c0342d3a>] rtl8139_poll+0x36a/0x4c0
 [<c044a682>] net_rx_action+0xd2/0x1f0
 [<c0123527>] __do_softirq+0x97/0x130
 [<c01054d9>] do_softirq+0x69/0x100
 =======================
 [<c01231e5>] irq_exit+0x45/0x50
 [<c01055c4>] do_IRQ+0x54/0x70
 [<c01038a9>] common_interrupt+0x25/0x2c
 [<c0120990>] do_wait+0x7d0/0xad0
 [<c0120cc2>] sys_wait4+0x32/0x40
 [<c0120cf5>] sys_waitpid+0x25/0x30
 [<c0102e17>] sysenter_past_esp+0x54/0x8d
