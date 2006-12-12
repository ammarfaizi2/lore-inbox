Return-Path: <linux-kernel-owner+w=401wt.eu-S932181AbWLLKTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWLLKTK (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 05:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbWLLKTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 05:19:09 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:40024 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932181AbWLLKTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 05:19:08 -0500
Date: Tue, 12 Dec 2006 11:16:56 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@davemloft.net>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: [patch] netpoll: fix netpoll lockups
Message-ID: <20061212101656.GA5064@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Subject: [patch] netpoll: fix netpoll lockups
From: Ingo Molnar <mingo@elte.hu>

current -git doesnt boot on my laptop due to the following netpoll 
breakages:

 - unlock the tx lock in the else branch too ...
 - use irq-safe locking instead of bh-safe locking, netpoll is
   often called from irq context.

with this patch -git boots fine with lockdep enabled and there are no 
locking complaints and everything works fine. (The netpoll_send_skb() 
portion of this patch was based on Andrew's bh-locking based netpoll 
patch in -mm.)

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 net/core/netpoll.c |   39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

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
 
@@ -231,7 +236,7 @@ repeat:
 static void netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 {
 	int status = NETDEV_TX_BUSY;
-	unsigned long tries;
+	unsigned long tries, flags;
  	struct net_device *dev = np->dev;
  	struct netpoll_info *npinfo = np->dev->npinfo;
 
@@ -242,22 +247,26 @@ static void netpoll_send_skb(struct netp
 
 	/* don't get messages out of order, and no recursion */
 	if (skb_queue_len(&npinfo->txq) == 0 &&
-	    npinfo->poll_owner != smp_processor_id() &&
-	    netif_tx_trylock(dev)) {
-		/* try until next clock tick */
-		for (tries = jiffies_to_usecs(1)/USEC_PER_POLL; tries > 0; --tries) {
-			if (!netif_queue_stopped(dev))
-				status = dev->hard_start_xmit(skb, dev);
+		    npinfo->poll_owner != smp_processor_id()) {
+		local_irq_save(flags);	/* Where's netif_tx_trylock_irqsave()? */
+		if (netif_tx_trylock(dev)) {
+			/* try until next clock tick */
+			for (tries = jiffies_to_usecs(1)/USEC_PER_POLL;
+					tries > 0; --tries) {
+				if (!netif_queue_stopped(dev))
+					status = dev->hard_start_xmit(skb, dev);
 
-			if (status == NETDEV_TX_OK)
-				break;
+				if (status == NETDEV_TX_OK)
+					break;
 
-			/* tickle device maybe there is some cleanup */
-			netpoll_poll(np);
+				/* tickle device maybe there is some cleanup */
+				netpoll_poll(np);
 
-			udelay(USEC_PER_POLL);
+				udelay(USEC_PER_POLL);
+			}
+			netif_tx_unlock(dev);
 		}
-		netif_tx_unlock(dev);
+		local_irq_restore(flags);
 	}
 
 	if (status != NETDEV_TX_OK) {
