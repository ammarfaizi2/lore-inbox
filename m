Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbTIWA60 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 20:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbTIWA60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 20:58:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10932 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261996AbTIWA6W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 20:58:22 -0400
Message-ID: <3F6F9A9A.9030003@pobox.com>
Date: Mon, 22 Sep 2003 20:58:02 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: Andrew Morton <akpm@osdl.org>, Robert Walsh <rjwalsh@durables.org>,
       wangdi <wangdi@clusterfs.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] netpoll-core
References: <20030922184526.GL2414@waste.org>
In-Reply-To: <20030922184526.GL2414@waste.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:

> +void netpoll_poll(struct netpoll *np)
> +{
> +	int budget = 1;
> +
> +	if(!np || !np->dev || !(np->dev->flags & IFF_UP))
> +		return;

should test netif_running() not IFF_UP, IMO


> +	disable_irq(np->dev->irq);
> +
> +	/* Process pending work on NIC */
> +	np->irqfunc(np->dev->irq, np->dev, 0);
> +
> +	/* If scheduling is stopped, tickle NAPI bits */
> +	if(trapped && np->dev->poll &&
> +	   test_bit(__LINK_STATE_RX_SCHED, &np->dev->state))
> +		np->dev->poll(np->dev, &budget);
> +
> +	enable_irq(np->dev->irq);
> +}

Calling the irq function from two different places, netpoll code and 
arch code, worries me.


> +static void refill_skbs(void)
> +{
> +	struct sk_buff *skb;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&skb_list_lock, flags);
> +	while (nr_skbs < MAX_SKBS) {
> +		skb = alloc_skb(MAX_SKB_SIZE, GFP_ATOMIC);
> +		if (!skb)
> +			break;
> +
> +		skb->next = skbs;
> +		skbs = skb;
> +		nr_skbs++;
> +	}
> +	spin_unlock_irqrestore(&skb_list_lock, flags);
> +}

if it's a simple list, why not lock, find out number of allocations, 
unlock, allocate a bunch of skbs, then finally lock again and tie back 
into list.


> +static void zap_completion_queue(void)
> +{
> +	unsigned long flags;
> +	struct softnet_data *sd = &get_cpu_var(softnet_data);
> +
> +	if (sd->completion_queue) {
> +		struct sk_buff *clist;
> +
> +		local_irq_save(flags);
> +		clist = sd->completion_queue;
> +		sd->completion_queue = NULL;
> +		local_irq_save(flags);
> +
> +		while (clist != NULL) {
> +			struct sk_buff *skb = clist;
> +			clist = clist->next;
> +			__kfree_skb(skb);
> +		}
> +	}
> +
> +	put_cpu_var(softnet_data);
> +}

this should be somewhere in a more general place...  otherwise, somebody 
will inevitably change softnet and forget to change this code.



> +void netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
> +{
> +	int status;
> +
> +repeat:
> +	if(!np || !np->dev || !(np->dev->flags & IFF_UP)) {

netif_running()


> +	spin_lock(&np->dev->xmit_lock);
> +	np->dev->xmit_lock_owner = smp_processor_id();
> +
> +	if (netif_queue_stopped(np->dev)) {
> +		np->dev->xmit_lock_owner = -1;
> +		spin_unlock(&np->dev->xmit_lock);
> +
> +		netpoll_poll(np);
> +		zap_completion_queue();
> +		goto repeat;
> +	}
> +
> +	status = np->dev->hard_start_xmit(skb, np->dev);
> +	np->dev->xmit_lock_owner = -1;
> +	spin_unlock(&np->dev->xmit_lock);

this worries be too, but I don't have any outright objections.  Mainly 
similar to the above comments -- this is intimate with the net stack 
locking, and at the very least shouldn't be hidden in a little-used 
corner of the code :)



> +static int rx_hook(struct sk_buff *skb)
[...]

> diff -puN include/linux/netdevice.h~netpoll-core include/linux/netdevice.h
> --- l/include/linux/netdevice.h~netpoll-core	2003-09-22 13:15:31.000000000 -0500
> +++ l-mpm/include/linux/netdevice.h	2003-09-22 13:15:31.000000000 -0500
> @@ -452,13 +452,13 @@ struct net_device
>  						     unsigned char *haddr);
>  	int			(*neigh_setup)(struct net_device *dev, struct neigh_parms *);
>  	int			(*accept_fastpath)(struct net_device *, struct dst_entry*);
> +#ifdef CONFIG_NETPOLL
> +	int			(*rx_hook)(struct sk_buff *skb);
> +#endif
[...]
> diff -puN net/core/dev.c~netpoll-core net/core/dev.c
> --- l/net/core/dev.c~netpoll-core	2003-09-22 13:15:31.000000000 -0500
> +++ l-mpm/net/core/dev.c	2003-09-22 13:16:34.000000000 -0500
[...]
> @@ -1552,6 +1541,13 @@ int netif_receive_skb(struct sk_buff *sk
>  	int ret = NET_RX_DROP;
>  	unsigned short type = skb->protocol;
>  
> +#ifdef CONFIG_NETPOLL
> +	if (skb->dev->rx_hook && skb->dev->rx_hook(skb)) {
> +		kfree_skb(skb);
> +		return NET_RX_DROP;
> +	}
> +#endif

This allows wholesale replacement of the IPv4 net stack, something we've 
traditionally avoided.

	Jeff



