Return-Path: <linux-kernel-owner+w=401wt.eu-S1751515AbWLLQX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515AbWLLQX3 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 11:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbWLLQXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 11:23:25 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:37392 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751513AbWLLQXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 11:23:01 -0500
Date: Tue, 12 Dec 2006 17:20:42 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@davemloft.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] netpoll: fix netpoll lockup
Message-ID: <20061212162042.GA18359@elte.hu>
References: <20061212101656.GA5064@elte.hu> <Pine.LNX.4.64.0612120811180.6452@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612120811180.6452@woody.osdl.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> On Tue, 12 Dec 2006, Ingo Molnar wrote:
> > 
> > current -git doesnt boot on my laptop due to the following netpoll 
> > breakages:
> > 
> >  - unlock the tx lock in the else branch too ...
> >  - use irq-safe locking instead of bh-safe locking, netpoll is
> >    often called from irq context.
> 
> This one doesn't apply for me any more, probably because David checked 
> in the patch from Andrew that fixed at least _part_ of the problem.
> 
> Davem, Ingo, Herbert, can you verify whether the fixes in the current 
> -git tree replace this patch from Ingo, or whether Ingo's patch is 
> still needed and just needs to be refreshed.

the first half of it is still needed - find the delta patch ontop of 
current -git below.

	Ingo

------------------------>
Subject: [patch] netpoll: fix netpoll lockup
From: Ingo Molnar <mingo@elte.hu>

current -git doesnt boot on my laptop due to netpoll
not unlocking the tx lock in the else branch.

booted this up on my laptop with lockdep enabled and there are
no locking complaints and it works fine.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 net/core/netpoll.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

Index: linux-hres-timers.q/net/core/netpoll.c
===================================================================
--- linux-hres-timers.q.orig/net/core/netpoll.c
+++ linux-hres-timers.q/net/core/netpoll.c
@@ -55,6 +55,7 @@ static void queue_process(struct work_st
 	struct netpoll_info *npinfo =
 		container_of(work, struct netpoll_info, tx_work.work);
 	struct sk_buff *skb;
+	unsigned long flags;
 
 	while ((skb = skb_dequeue(&npinfo->txq))) {
 		struct net_device *dev = skb->dev;
@@ -64,15 +65,19 @@ static void queue_process(struct work_st
 			continue;
 		}
 
-		netif_tx_lock_bh(dev);
+		local_irq_save(flags);
+		netif_tx_lock(dev);
 		if (netif_queue_stopped(dev) ||
 		    dev->hard_start_xmit(skb, dev) != NETDEV_TX_OK) {
 			skb_queue_head(&npinfo->txq, skb);
-			netif_tx_unlock_bh(dev);
+			netif_tx_unlock(dev);
+			local_irq_restore(flags);
 
 			schedule_delayed_work(&npinfo->tx_work, HZ/10);
 			return;
 		}
+		netif_tx_unlock(dev);
+		local_irq_restore(flags);
 	}
 }
 
