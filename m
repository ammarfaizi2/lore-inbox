Return-Path: <linux-kernel-owner+w=401wt.eu-S1757289AbWLIWCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757289AbWLIWCG (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 17:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757265AbWLIWCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 17:02:06 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:59016
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1757289AbWLIWCE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 17:02:04 -0500
Date: Sat, 09 Dec 2006 14:02:05 -0800 (PST)
Message-Id: <20061209.140205.126778911.davem@davemloft.net>
To: herbert@gondor.apana.org.au
Cc: akpm@osdl.org, mingo@elte.hu, alan@lxorguk.ukuu.org.uk, lenb@kernel.org,
       linux-kernel@vger.kernel.org, ak@suse.de, torvalds@osdl.org
Subject: Re: [patch] net: dev_watchdog() locking fix
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061208235952.GA4693@gondor.apana.org.au>
References: <20061207210657.GA23229@gondor.apana.org.au>
	<20061208151902.4c8bb012.akpm@osdl.org>
	<20061208235952.GA4693@gondor.apana.org.au>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Sat, 9 Dec 2006 10:59:52 +1100

> On Fri, Dec 08, 2006 at 03:19:02PM -0800, Andrew Morton wrote:
> > 
> > Like this?
> > 
> > 	/* don't get messages out of order, and no recursion */
> > 	if (skb_queue_len(&npinfo->txq) == 0 &&
> > 		    npinfo->poll_owner != smp_processor_id()) {
> > 		local_bh_disable();	/* Where's netif_tx_trylock_bh()? */
> > 		if (netif_tx_trylock(dev)) {
> > 			/* try until next clock tick */
> > 			for (tries = jiffies_to_usecs(1)/USEC_PER_POLL;
> > 					tries > 0; --tries) {
> > 				if (!netif_queue_stopped(dev))
> > 					status = dev->hard_start_xmit(skb, dev);
> > 
> > 				if (status == NETDEV_TX_OK)
> > 					break;
> > 
> > 				/* tickle device maybe there is some cleanup */
> > 				netpoll_poll(np);
> > 
> > 				udelay(USEC_PER_POLL);
> > 			}
> > 			netif_tx_unlock(dev);
> > 		}
> > 		local_bh_enable();
> > 	}
> 
> Looks good to me.  Thanks Andrew!

I've applied this patch, thanks a lot.
