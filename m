Return-Path: <linux-kernel-owner+w=401wt.eu-S1751287AbWLLMvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbWLLMvo (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 07:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbWLLMvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 07:51:43 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:51001 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751288AbWLLMvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 07:51:42 -0500
Date: Tue, 12 Dec 2006 13:49:35 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@davemloft.net>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: [patch] net, 8139too.c: fix netpoll deadlock
Message-ID: <20061212124935.GA4356@elte.hu>
References: <20061212101656.GA5064@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061212101656.GA5064@elte.hu>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [patch] net, 8139too.c: fix netpoll deadlock
From: Ingo Molnar <mingo@elte.hu>

fix deadlock in the 8139too driver: poll handlers should never forcibly 
enable local interrupts, because they might be used by netpoll/printk 
from IRQ context.

=================================
[ INFO: inconsistent lock state ]
2.6.19 #11
---------------------------------
inconsistent {softirq-on-W} -> {in-softirq-W} usage.
swapper/1 [HC0[0]:SC1[1]:HE1:SE0] takes:
 (&npinfo->poll_lock){-+..}, at: [<c0350a41>] net_rx_action+0x64/0x1de
{softirq-on-W} state was registered at:
  [<c0134c86>] mark_lock+0x5b/0x39c
  [<c0135012>] mark_held_locks+0x4b/0x68
  [<c01351e9>] trace_hardirqs_on+0x115/0x139
  [<c02879e6>] rtl8139_poll+0x3d7/0x3f4
  [<c035c85d>] netpoll_poll+0x82/0x32f
  [<c035c775>] netpoll_send_skb+0xc9/0x12f
  [<c035cdcc>] netpoll_send_udp+0x253/0x25b
  [<c0288463>] write_msg+0x40/0x65
  [<c011cead>] __call_console_drivers+0x45/0x51
  [<c011cf16>] _call_console_drivers+0x5d/0x61
  [<c011d4fb>] release_console_sem+0x11f/0x1d8
  [<c011d7d7>] register_console+0x1ac/0x1b3
  [<c02883f8>] init_netconsole+0x55/0x67
  [<c010040c>] init+0x9a/0x24e
  [<c01049cf>] kernel_thread_helper+0x7/0x10
  [<ffffffff>] 0xffffffff
irq event stamp: 819992
hardirqs last  enabled at (819992): [<c0350a16>] net_rx_action+0x39/0x1de
hardirqs last disabled at (819991): [<c0350b1e>] net_rx_action+0x141/0x1de
softirqs last  enabled at (817552): [<c01214e4>] __do_softirq+0xa3/0xa8
softirqs last disabled at (819987): [<c0106051>] do_softirq+0x5b/0xc9

other info that might help us debug this:
no locks held by swapper/1.

stack backtrace:
 [<c0104d88>] dump_trace+0x63/0x1e8
 [<c0104f26>] show_trace_log_lvl+0x19/0x2e
 [<c010532d>] show_trace+0x12/0x14
 [<c0105343>] dump_stack+0x14/0x16
 [<c0134980>] print_usage_bug+0x23c/0x246
 [<c0134d33>] mark_lock+0x108/0x39c
 [<c01356a7>] __lock_acquire+0x361/0x9ed
 [<c0136018>] lock_acquire+0x56/0x72
 [<c03aff1f>] _spin_lock+0x35/0x42
 [<c0350a41>] net_rx_action+0x64/0x1de
 [<c0121493>] __do_softirq+0x52/0xa8
 [<c0106051>] do_softirq+0x5b/0xc9
 [<c0121338>] irq_exit+0x3c/0x48
 [<c0106163>] do_IRQ+0xa4/0xbd
 [<c01047c6>] common_interrupt+0x2e/0x34
 [<c011db92>] vprintk+0x2c0/0x309
 [<c011dbf6>] printk+0x1b/0x1d
 [<c01003f2>] init+0x80/0x24e
 [<c01049cf>] kernel_thread_helper+0x7/0x10
 =======================

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 drivers/net/8139too.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: linux-hres-timers.q/drivers/net/8139too.c
===================================================================
--- linux-hres-timers.q.orig/drivers/net/8139too.c
+++ linux-hres-timers.q/drivers/net/8139too.c
@@ -2131,14 +2131,15 @@ static int rtl8139_poll(struct net_devic
 	}
 
 	if (done) {
+		unsigned long flags;
 		/*
 		 * Order is important since data can get interrupted
 		 * again when we think we are done.
 		 */
-		local_irq_disable();
+		local_irq_save(flags);
 		RTL_W16_F(IntrMask, rtl8139_intr_mask);
 		__netif_rx_complete(dev);
-		local_irq_enable();
+		local_irq_restore(flags);
 	}
 	spin_unlock(&tp->rx_lock);
 
