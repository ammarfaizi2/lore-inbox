Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbVIFS46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbVIFS46 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 14:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbVIFS46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 14:56:58 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:52922 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S1750799AbVIFS45
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 14:56:57 -0400
Date: Tue, 6 Sep 2005 20:56:40 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, "David S. Miller" <davem@redhat.com>,
       Pieter Dejaeghere <pieter@dejaeghere.net>
Subject: Re: [PATCH] Arcnet, linux 2.6.13
In-Reply-To: <39543.217.136.171.4.1125904710.squirrel@www.pieter.dejaeghere.net>
Message-Id: <Pine.OSF.4.05.10509061609100.23151-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Sep 2005, Pieter Dejaeghere wrote:

> In the current arcnet driver, the hard_start_xmit method allocates a
> buffer for an outgoing transmission. However, this method doesn't check
> whether there was already an allocated buffer from an earlier outgoing
> transmission. This patch checks whether lp->next_tx already had an
> allocated buffer, and if so, it returns NETDEV_TX_BUSY. This prevents
> buffers from dissapearing under heavy traffic.
> 
> This patch seems to work fine on my arcnet network, and I also sent it to
> the person (Esben Nielsen simlo@phys.au.dk) who made some arcnet patches
> in 2.6.8 and 2.6.11, and they work fine on his setup too.
> 

Yes, I tested it. It works and apparently solves a problem I have had for
a long time with lost buffers and extremely long ping times, when pinging
with large packages. 

Please, apply this patch.

Andrew and David: I CC'ed you guyes because you took care of it the last
time :-)


Esben


> url to the patch:
> http://pieter.dejaeghere.net:9080/arcnet/patch-buffer
> 
> inlined (hopefully without broken linewraps):
> --- linux-2.6.12-gentoo-r1/drivers/net/arcnet/arcnet.c	2005-06-25
> 20:42:46.000000000 +0200
> +++ linux-2.6.13-gentoo/drivers/net/arcnet/arcnet.c	2005-09-03
> 19:46:54.227846664 +0200
> @@ -597,7 +597,7 @@ static int arcnet_send_packet(struct sk_
>  	struct ArcProto *proto;
>  	int txbuf;
>  	unsigned long flags;
> -	int freeskb = 0;
> +	int freeskb, retval;
> 
>  	BUGMSG(D_DURING,
>  	       "transmit requested (status=%Xh, txbufs=%d/%d, len=%d, protocol
> %x)\n",
> @@ -615,7 +615,7 @@ static int arcnet_send_packet(struct sk_
>  	if (skb->len - ARC_HDR_SIZE > XMTU && !proto->continue_tx) {
>  		BUGMSG(D_NORMAL, "fixme: packet too large: compensating badly!\n");
>  		dev_kfree_skb(skb);
> -		return 0;	/* don't try again */
> +		return NETDEV_TX_OK;	/* don't try again */
>  	}
> 
>  	/* We're busy transmitting a packet... */
> @@ -623,8 +623,11 @@ static int arcnet_send_packet(struct sk_
> 
>  	spin_lock_irqsave(&lp->lock, flags);
>  	AINTMASK(0);
> -
> -	txbuf = get_arcbuf(dev);
> +	if(lp->next_tx == -1)
> +		txbuf = get_arcbuf(dev);
> +	else {
> +		txbuf = -1;
> +	}
>  	if (txbuf != -1) {
>  		if (proto->prepare_tx(dev, pkt, skb->len, txbuf) &&
>  		    !proto->ack_tx) {
> @@ -638,6 +641,8 @@ static int arcnet_send_packet(struct sk_
>  			lp->outgoing.skb = skb;
>  			lp->outgoing.pkt = pkt;
> 
> +			freeskb = 0;
> +
>  			if (proto->continue_tx &&
>  			    proto->continue_tx(dev, txbuf)) {
>  			  BUGMSG(D_NORMAL,
> @@ -645,10 +650,12 @@ static int arcnet_send_packet(struct sk_
>  				 "(proto='%c')\n", proto->suffix);
>  			}
>  		}
> -
> +		retval = NETDEV_TX_OK;
> +		dev->trans_start = jiffies;
>  		lp->next_tx = txbuf;
>  	} else {
> -		freeskb = 1;
> +		retval = NETDEV_TX_BUSY;
> +		freeskb = 0;
>  	}
> 
>  	BUGMSG(D_DEBUG, "%s: %d: %s, status:
> %x\n",__FILE__,__LINE__,__FUNCTION__,ASTATUS());
> @@ -664,7 +671,7 @@ static int arcnet_send_packet(struct sk_
>  	if (freeskb) {
>  		dev_kfree_skb(skb);
>  	}
> -	return 0;		/* no need to try again */
> +	return retval;		/* no need to try again */
>  }
> 
> 
> @@ -690,7 +697,6 @@ static int go_tx(struct net_device *dev)
>  	/* start sending */
>  	ACOMMAND(TXcmd | (lp->cur_tx << 3));
> 
> -	dev->trans_start = jiffies;
>  	lp->stats.tx_packets++;
>  	lp->lasttrans_dest = lp->lastload_dest;
>  	lp->lastload_dest = 0;
> @@ -917,6 +923,9 @@ irqreturn_t arcnet_interrupt(int irq, vo
> 
>  			BUGMSG(D_RECON, "Network reconfiguration detected (status=%Xh)\n",
>  			       status);
> +			/* MYRECON bit is at bit 7 of diagstatus */
> +			if(diagstatus & 0x80)
> +				BUGMSG(D_RECON,"Put out that recon myself\n");
> 
>  			/* is the RECON info empty or old? */
>  			if (!lp->first_recon || !lp->last_recon ||
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



