Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263262AbTIWEQp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 00:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263273AbTIWEQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 00:16:45 -0400
Received: from waste.org ([209.173.204.2]:61069 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263262AbTIWEQl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 00:16:41 -0400
Date: Mon, 22 Sep 2003 23:16:17 -0500
From: Matt Mackall <mpm@selenic.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, Robert Walsh <rjwalsh@durables.org>,
       wangdi <wangdi@clusterfs.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] netpoll-core
Message-ID: <20030923041617.GD32488@waste.org>
References: <20030922184526.GL2414@waste.org> <3F6F9A9A.9030003@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F6F9A9A.9030003@pobox.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 22, 2003 at 08:58:02PM -0400, Jeff Garzik wrote:
> Matt Mackall wrote:
> 
> >+void netpoll_poll(struct netpoll *np)
> >+{
> >+	int budget = 1;
> >+
> >+	if(!np || !np->dev || !(np->dev->flags & IFF_UP))
> >+		return;
> 
> should test netif_running() not IFF_UP, IMO

Sure. I modeled it on the ip autoconf code which wasn't exactly
pretty, but now I think I have a firmer grasp on the net stack.
 
> 
> >+	disable_irq(np->dev->irq);
> >+
> >+	/* Process pending work on NIC */
> >+	np->irqfunc(np->dev->irq, np->dev, 0);
> >+
> >+	/* If scheduling is stopped, tickle NAPI bits */
> >+	if(trapped && np->dev->poll &&
> >+	   test_bit(__LINK_STATE_RX_SCHED, &np->dev->state))
> >+		np->dev->poll(np->dev, &budget);
> >+
> >+	enable_irq(np->dev->irq);
> >+}
> 
> Calling the irq function from two different places, netpoll code and 
> arch code, worries me.

Why? The interrupt handlers don't have a special calling convention to
speak of. 

> >+static void refill_skbs(void)
> >+{
> >+	struct sk_buff *skb;
> >+	unsigned long flags;
> >+
> >+	spin_lock_irqsave(&skb_list_lock, flags);
> >+	while (nr_skbs < MAX_SKBS) {
> >+		skb = alloc_skb(MAX_SKB_SIZE, GFP_ATOMIC);
> >+		if (!skb)
> >+			break;
> >+
> >+		skb->next = skbs;
> >+		skbs = skb;
> >+		nr_skbs++;
> >+	}
> >+	spin_unlock_irqrestore(&skb_list_lock, flags);
> >+}
> 
> if it's a simple list, why not lock, find out number of allocations, 
> unlock, allocate a bunch of skbs, then finally lock again and tie back 
> into list.

That could work too. The above is more or less the same as what's in
the RH 2.4 netdump patches and works well enough.
 
> >+static void zap_completion_queue(void)
[...]
> 
> this should be somewhere in a more general place...  otherwise, somebody 
> will inevitably change softnet and forget to change this code.

Fair enough. Suggestions?

> >+void netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
> >+{
> >+	int status;
> >+
> >+repeat:
> >+	if(!np || !np->dev || !(np->dev->flags & IFF_UP)) {
> 
> netif_running()
> 
> 
> >+	spin_lock(&np->dev->xmit_lock);
> >+	np->dev->xmit_lock_owner = smp_processor_id();
> >+
> >+	if (netif_queue_stopped(np->dev)) {
> >+		np->dev->xmit_lock_owner = -1;
> >+		spin_unlock(&np->dev->xmit_lock);
> >+
> >+		netpoll_poll(np);
> >+		zap_completion_queue();
> >+		goto repeat;
> >+	}
> >+
> >+	status = np->dev->hard_start_xmit(skb, np->dev);
> >+	np->dev->xmit_lock_owner = -1;
> >+	spin_unlock(&np->dev->xmit_lock);
> 
> this worries be too, but I don't have any outright objections.  Mainly 
> similar to the above comments -- this is intimate with the net stack 
> locking, and at the very least shouldn't be hidden in a little-used 
> corner of the code :)

Actually I think it's going to be effectively hidden to anyone who
doesn't use the netpoll interface as no one else is going to have a
use for this sort of functionality. There might be a more generic
place for zapping completions but not for this.

> >+#ifdef CONFIG_NETPOLL
> >+	if (skb->dev->rx_hook && skb->dev->rx_hook(skb)) {
> >+		kfree_skb(skb);
> >+		return NET_RX_DROP;
> >+	}
> >+#endif
> 
> This allows wholesale replacement of the IPv4 net stack, something we've 
> traditionally avoided.

Heh. Here I was thinking I was doing the right thing by making it
generic. I can just add a netpoll flag somewhere in netdevice instead.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
