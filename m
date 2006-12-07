Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163336AbWLGU5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163336AbWLGU5K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 15:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163352AbWLGU5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 15:57:10 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:44033 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163336AbWLGU5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 15:57:07 -0500
Date: Thu, 7 Dec 2006 21:55:22 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, Len Brown <lenb@kernel.org>,
       linux-kernel@vger.kernel.org, ak@suse.de,
       Linus Torvalds <torvalds@osdl.org>,
       "David S. Miller" <davem@davemloft.net>,
       Herbert Xu <herbert@gondor.apana.org.au>
Subject: [patch] net: dev_watchdog() locking fix
Message-ID: <20061207205521.GA21329@elte.hu>
References: <20061206223025.GA17227@elte.hu> <200612061857.30248.len.brown@intel.com> <20061207121135.GA15529@elte.hu> <20061207123011.4b723788@localhost.localdomain> <20061207123836.213c3214.akpm@osdl.org> <20061207204745.GC13327@elte.hu> <20061207204942.GA20524@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061207204942.GA20524@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> > patch below should apply to tail of current-ish -mm. Build and boot 
> > tested on x86_64.
> 
> btw., lockdep noticed a locking breakage in netconsole, see the log 
> below. My guess: dev_watchdog shouldnt be taking the lock without _bh.

fallout of the recent big networking merge i guess. Tested fix below. 
David, Herbert, do you agree with it, or is it a false positive?

	Ingo

------------->
Subject: [patch] net: dev_watchdog() locking fix
From: Ingo Molnar <mingo@elte.hu>

lockdep noticed the following bug:

=================================
[ INFO: inconsistent lock state ]
2.6.19-mm1 #4
---------------------------------
inconsistent {softirq-on-W} -> {in-softirq-W} usage.
swapper/0 [HC0[0]:SC1[1]:HE1:SE0] takes:
 (&dev->_xmit_lock){-+..}, at: [<ffffffff80453151>] dev_watchdog+0x15/0xe0
{softirq-on-W} state was registered at:
  [<ffffffff80251078>] mark_lock+0x78/0x3cf
  [<ffffffff80251422>] mark_held_locks+0x53/0x71
  [<ffffffff802515ed>] trace_hardirqs_on+0x113/0x137
  [<ffffffff803cda5f>] rtl8139_poll+0x3c9/0x3ee
  [<ffffffff8044f03d>] netpoll_poll+0xa1/0x32f
  [<ffffffff8044ef44>] netpoll_send_skb+0xdf/0x137
  [<ffffffff8044f5b4>] netpoll_send_udp+0x263/0x270
  [<ffffffff803ce632>] write_msg+0x4c/0x7e
  [<ffffffff8023671b>] __call_console_drivers+0x5f/0x70
  [<ffffffff80236790>] _call_console_drivers+0x64/0x68
  [<ffffffff80236e6c>] release_console_sem+0x148/0x207
  [<ffffffff80237165>] register_console+0x1b1/0x1ba
  [<ffffffff803ce5b4>] init_netconsole+0x54/0x68
  [<ffffffff802071d9>] init+0x178/0x347
  [<ffffffff8020ab98>] child_rip+0xa/0x12
  [<ffffffffffffffff>] 0xffffffffffffffff
irq event stamp: 23912
hardirqs last  enabled at (23912): [<ffffffff804aedc5>] _spin_unlock_irq+0x28/0x52
hardirqs last disabled at (23911): [<ffffffff804aecec>] _spin_lock_irq+0xf/0x3e
softirqs last  enabled at (23896): [<ffffffff8023befd>] __do_softirq+0xdb/0xe4
softirqs last disabled at (23909): [<ffffffff8020af0c>] call_softirq+0x1c/0x30

other info that might help us debug this:
no locks held by swapper/0.

stack backtrace:

Call Trace:
 [<ffffffff8020b304>] dump_trace+0xc1/0x3eb
 [<ffffffff8020b667>] show_trace+0x39/0x57
 [<ffffffff8020b89c>] dump_stack+0x13/0x15
 [<ffffffff80250cff>] print_usage_bug+0x26b/0x27a
 [<ffffffff8025112b>] mark_lock+0x12b/0x3cf
 [<ffffffff80251b0b>] __lock_acquire+0x3c0/0xa0f
 [<ffffffff80252426>] lock_acquire+0x4d/0x67
 [<ffffffff804ae747>] _spin_lock+0x2c/0x38
 [<ffffffff80453151>] dev_watchdog+0x15/0xe0
 [<ffffffff802401d9>] run_timer_softirq+0x167/0x1db
 [<ffffffff8023be84>] __do_softirq+0x62/0xe4
 [<ffffffff8020af0c>] call_softirq+0x1c/0x30
 [<ffffffff8020c6a2>] do_softirq+0x36/0x9c
 [<ffffffff8023bb47>] irq_exit+0x45/0x51
 [<ffffffff80219d79>] smp_apic_timer_interrupt+0x49/0x5c
 [<ffffffff8020a9bb>] apic_timer_interrupt+0x6b/0x70
 [<ffffffff80208823>] default_idle+0x36/0x50
 [<ffffffff802088d8>] cpu_idle+0x9b/0xd4
 [<ffffffff802193f9>] start_secondary+0x498/0x4a7

taking the lock _bh safe fixes it for me.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 net/sched/sch_generic.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-mm-genapic.q/net/sched/sch_generic.c
===================================================================
--- linux-mm-genapic.q.orig/net/sched/sch_generic.c
+++ linux-mm-genapic.q/net/sched/sch_generic.c
@@ -197,7 +197,7 @@ static void dev_watchdog(unsigned long a
 {
 	struct net_device *dev = (struct net_device *)arg;
 
-	netif_tx_lock(dev);
+	netif_tx_lock_bh(dev);
 	if (dev->qdisc != &noop_qdisc) {
 		if (netif_device_present(dev) &&
 		    netif_running(dev) &&
@@ -213,7 +213,7 @@ static void dev_watchdog(unsigned long a
 				dev_hold(dev);
 		}
 	}
-	netif_tx_unlock(dev);
+	netif_tx_unlock_bh(dev);
 
 	dev_put(dev);
 }
