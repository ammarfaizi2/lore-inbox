Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWEOXlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWEOXlL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 19:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWEOXlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 19:41:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64490 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750798AbWEOXlI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 19:41:08 -0400
Date: Mon, 15 May 2006 16:41:01 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Ranjit Manomohan <ranjitm@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, ranjitm@google.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] tcpdump may trace some outbound packets twice.
Message-ID: <20060515164101.054afa29@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.56.0605151602330.29636@ranjit.corp.google.com>
References: <20060514031034.5d0396e7.akpm@osdl.org>
	<20060514.134231.101346572.davem@davemloft.net>
	<Pine.LNX.4.56.0605151409110.25064@ranjit.corp.google.com>
	<20060515.142645.94689626.davem@davemloft.net>
	<Pine.LNX.4.56.0605151602330.29636@ranjit.corp.google.com>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.1.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 May 2006 16:11:05 -0700 (PDT)
Ranjit Manomohan <ranjitm@google.com> wrote:

> On Mon, 15 May 2006, David S. Miller wrote:
> 
> > From: Ranjit Manomohan <ranjitm@google.com>
> > Date: Mon, 15 May 2006 14:19:06 -0700 (PDT)
> > 
> > > Heres a new version which does a copy instead of the clone to avoid
> > > the double cloning issue.
> > 
> > I still very much dislike this patch because it is creating
> > 1 more clone per packet than is actually necessary and that
> > is very expensive.
> > 
> > dev_queue_xmit_nit() is going to clone whatever SKB you send into
> > there, so better to just bump the reference count (with skb_get())
> > instead of cloning or copying.
> > 
> 
> I was a bit apprehensive about just incrementing the refcnt but that works 
> too. Attached is the modified version.
> 
> -Thanks,
> Ranjit
> 
> --- linux-2.6/net/sched/sch_generic.c	2006-05-10 12:34:52.000000000 -0700
> +++ linux/net/sched/sch_generic.c	2006-05-15 15:48:03.000000000 -0700
> @@ -136,8 +136,12 @@
>  
>  			if (!netif_queue_stopped(dev)) {
>  				int ret;
> +				struct sk_buff *skbc = NULL;
> +				/* Increment the reference count on the skb so
> +				 * that we can use it after a successful xmit.
> +				 */
>  				if (netdev_nit)
> -					dev_queue_xmit_nit(skb, dev);
> +					skbc = skb_get(skb);

				skbc = netdev_nit ? skb_get(skb) : NULL;
>  
>  				ret = dev->hard_start_xmit(skb, dev);
>  				if (ret == NETDEV_TX_OK) { 
> @@ -145,9 +149,20 @@
>  						dev->xmit_lock_owner = -1;
>  						spin_unlock(&dev->xmit_lock);
>  					}
> +					if (skbc) {
> +						/* transmit succeeded, 
> +						 * trace the buffer. */
> +						dev_queue_xmit_nit(skbc,dev);
> +						kfree_skb(skbc);
> +					}
>  					spin_lock(&dev->queue_lock);
>  					return -1;
>  				}
> +
> +				/* Call free in case we incremented refcnt */
> +				if (skbc)
> +					kfree_skb(skbc);

kfree_skb(NULL) is legal so the conditional here is unneeded.

But the increased calls to kfree_skb(NULL) would probably bring the
"unlikely()" hordes descending on kfree_skb, so maybe:

				if (unlikely(netdev_nit))
					kfree_skb(skbc);


