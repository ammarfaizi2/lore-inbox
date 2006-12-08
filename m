Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947556AbWLIAEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947556AbWLIAEy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 19:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947539AbWLIAA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 19:00:56 -0500
Received: from rhun.apana.org.au ([64.62.148.172]:1041 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761300AbWLIAAZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 19:00:25 -0500
Date: Sat, 9 Dec 2006 10:59:52 +1100
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Alan <alan@lxorguk.ukuu.org.uk>,
       Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, ak@suse.de,
       Linus Torvalds <torvalds@osdl.org>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [patch] net: dev_watchdog() locking fix
Message-ID: <20061208235952.GA4693@gondor.apana.org.au>
References: <20061206223025.GA17227@elte.hu> <200612061857.30248.len.brown@intel.com> <20061207121135.GA15529@elte.hu> <20061207123011.4b723788@localhost.localdomain> <20061207123836.213c3214.akpm@osdl.org> <20061207204745.GC13327@elte.hu> <20061207204942.GA20524@elte.hu> <20061207205521.GA21329@elte.hu> <20061207210657.GA23229@gondor.apana.org.au> <20061208151902.4c8bb012.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061208151902.4c8bb012.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2006 at 03:19:02PM -0800, Andrew Morton wrote:
> 
> Like this?
> 
> 	/* don't get messages out of order, and no recursion */
> 	if (skb_queue_len(&npinfo->txq) == 0 &&
> 		    npinfo->poll_owner != smp_processor_id()) {
> 		local_bh_disable();	/* Where's netif_tx_trylock_bh()? */
> 		if (netif_tx_trylock(dev)) {
> 			/* try until next clock tick */
> 			for (tries = jiffies_to_usecs(1)/USEC_PER_POLL;
> 					tries > 0; --tries) {
> 				if (!netif_queue_stopped(dev))
> 					status = dev->hard_start_xmit(skb, dev);
> 
> 				if (status == NETDEV_TX_OK)
> 					break;
> 
> 				/* tickle device maybe there is some cleanup */
> 				netpoll_poll(np);
> 
> 				udelay(USEC_PER_POLL);
> 			}
> 			netif_tx_unlock(dev);
> 		}
> 		local_bh_enable();
> 	}

Looks good to me.  Thanks Andrew!
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
