Return-Path: <linux-kernel-owner+w=401wt.eu-S1761271AbWLHXUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761271AbWLHXUh (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 18:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761272AbWLHXUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 18:20:37 -0500
Received: from smtp.osdl.org ([65.172.181.25]:50149 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761271AbWLHXUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 18:20:36 -0500
Date: Fri, 8 Dec 2006 15:19:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Ingo Molnar <mingo@elte.hu>, Alan <alan@lxorguk.ukuu.org.uk>,
       Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, ak@suse.de,
       Linus Torvalds <torvalds@osdl.org>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [patch] net: dev_watchdog() locking fix
Message-Id: <20061208151902.4c8bb012.akpm@osdl.org>
In-Reply-To: <20061207210657.GA23229@gondor.apana.org.au>
References: <20061206223025.GA17227@elte.hu>
	<200612061857.30248.len.brown@intel.com>
	<20061207121135.GA15529@elte.hu>
	<20061207123011.4b723788@localhost.localdomain>
	<20061207123836.213c3214.akpm@osdl.org>
	<20061207204745.GC13327@elte.hu>
	<20061207204942.GA20524@elte.hu>
	<20061207205521.GA21329@elte.hu>
	<20061207210657.GA23229@gondor.apana.org.au>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2006 08:06:57 +1100
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> On Thu, Dec 07, 2006 at 09:55:22PM +0100, Ingo Molnar wrote:
> > 
> > fallout of the recent big networking merge i guess. Tested fix below. 
> > David, Herbert, do you agree with it, or is it a false positive?
> 
> I agree that this is a bug, but the fix is in the wrong spot.  The
> dev_watchdog function already runs in softirq context so it doesn't
> need to disable BH.
> 
> You can almost be guaranteed that if netpoll is involved in a bug
> then it should be fixed :)
> 
> In this case, it's taking the tx lock in process context which is
> not allowed.  So it should disable BH before taking the tx lock.
> 

Like this?

	/* don't get messages out of order, and no recursion */
	if (skb_queue_len(&npinfo->txq) == 0 &&
		    npinfo->poll_owner != smp_processor_id()) {
		local_bh_disable();	/* Where's netif_tx_trylock_bh()? */
		if (netif_tx_trylock(dev)) {
			/* try until next clock tick */
			for (tries = jiffies_to_usecs(1)/USEC_PER_POLL;
					tries > 0; --tries) {
				if (!netif_queue_stopped(dev))
					status = dev->hard_start_xmit(skb, dev);

				if (status == NETDEV_TX_OK)
					break;

				/* tickle device maybe there is some cleanup */
				netpoll_poll(np);

				udelay(USEC_PER_POLL);
			}
			netif_tx_unlock(dev);
		}
		local_bh_enable();
	}


--- a/net/core/netpoll.c~netpoll-locking-fix
+++ a/net/core/netpoll.c
@@ -242,22 +242,26 @@ static void netpoll_send_skb(struct netp
 
 	/* don't get messages out of order, and no recursion */
 	if (skb_queue_len(&npinfo->txq) == 0 &&
-	    npinfo->poll_owner != smp_processor_id() &&
-	    netif_tx_trylock(dev)) {
-		/* try until next clock tick */
-		for (tries = jiffies_to_usecs(1)/USEC_PER_POLL; tries > 0; --tries) {
-			if (!netif_queue_stopped(dev))
-				status = dev->hard_start_xmit(skb, dev);
+		    npinfo->poll_owner != smp_processor_id()) {
+		local_bh_disable();	/* Where's netif_tx_trylock_bh()? */
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
+		local_bh_enable();
 	}
 
 	if (status != NETDEV_TX_OK) {
_

