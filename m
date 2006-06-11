Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750922AbWFKUOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbWFKUOI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 16:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbWFKUOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 16:14:07 -0400
Received: from waste.org ([64.81.244.121]:59556 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1750890AbWFKUOE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 16:14:04 -0400
Date: Sun, 11 Jun 2006 15:04:07 -0500
From: Matt Mackall <mpm@selenic.com>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
Subject: Re: [PATCH RFC] netpoll: don't spin forever sending to stopped queues
Message-ID: <20060611200407.GG24227@waste.org>
References: <44886381.9050506@goop.org> <20060608210702.GD24227@waste.org> <4488D9D6.6070205@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4488D9D6.6070205@goop.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2006 at 07:15:50PM -0700, Jeremy Fitzhardinge wrote:
> Matt Mackall wrote:
> >That's odd. Netpoll holds a reference to the device, of course, but so
> >does a normal "up" interface. So that shouldn't be the problem.
> >Another possibility is that outgoing packets from printks in the
> >driver are causing difficulty. Not sure what can be done about that.
> >  
> Here's a patch.  I haven't tested it beyond compiling it, and I don't 
> know if it is actually correct.  In this case, it seems pointless to 
> spin waiting for an even which will never happen.  Should 
> netif_poll_disable() cause netpoll_send_skb() (or something) to not even 
> bother trying to send?  netif_poll_disable seems mysteriously simple to me.
> 
>    J

Did this work for you at all?

> When transmitting a skb in netpoll_send_skb(), only retry a limited
> number of times if the device queue is stopped.

Where limited = once?

> Signed-off-by: Jeremy Fitzhardinge <jeremy@goop.org>
> 
> diff -r aac813f54617 net/core/netpoll.c
> --- a/net/core/netpoll.c	Wed Jun 07 14:53:40 2006 -0700
> +++ b/net/core/netpoll.c	Thu Jun 08 19:00:29 2006 -0700
> @@ -280,15 +280,10 @@ static void netpoll_send_skb(struct netp
> 		 * network drivers do not expect to be called if the queue is
> 		 * stopped.
> 		 */
> -		if (netif_queue_stopped(np->dev)) {
> -			np->dev->xmit_lock_owner = -1;
> -			spin_unlock(&np->dev->xmit_lock);
> -			netpoll_poll(np);
> -			udelay(50);
> -			continue;
> -		}
> -
> -		status = np->dev->hard_start_xmit(skb, np->dev);
> +		status = NETDEV_TX_BUSY;
> +		if (!netif_queue_stopped(np->dev))
> +			status = np->dev->hard_start_xmit(skb, np->dev);
> +
> 		np->dev->xmit_lock_owner = -1;
> 		spin_unlock(&np->dev->xmit_lock);
> 
> 
> 

-- 
Mathematics is the supreme nostalgia of our time.
