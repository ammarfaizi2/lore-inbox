Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbWJKJrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWJKJrb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 05:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbWJKJrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 05:47:31 -0400
Received: from dev.mellanox.co.il ([194.90.237.44]:29314 "EHLO
	dev.mellanox.co.il") by vger.kernel.org with ESMTP id S1751072AbWJKJra
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 05:47:30 -0400
Date: Wed, 11 Oct 2006 11:46:49 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: David Miller <davem@davemloft.net>
Cc: shemminger@osdl.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       openib-general@openib.org, rolandd@cisco.com
Subject: Re: Dropping NETIF_F_SG since no checksum feature.
Message-ID: <20061011094649.GD2701@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20061011.022015.63051509.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061011.022015.63051509.davem@davemloft.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. David Miller <davem@davemloft.net>:
> Subject: Re: Dropping NETIF_F_SG since no checksum feature.
> 
> From: "Michael S. Tsirkin" <mst@mellanox.co.il>
> Date: Wed, 11 Oct 2006 11:05:04 +0200
> 
> > So, it seems that if I set NETIF_F_SG but clear NETIF_F_ALL_CSUM,
> > data will be copied over rather than sent directly.
> > So why does dev.c have to force set NETIF_F_SG to off then?
> 
> Because it's more efficient to copy into a linear destination
> buffer of an SKB than page sub-chunks when doing checksum+copy.
> 

Thanks for the explanation.
Obviously its true as long as you can allocate the skb that big.
I think you won't realistically be able to get 64K in a
linear SKB on a busy system, though, is not that right?

OTOH, having large MTU (e.g. 64K) helps performance a lot since it
reduces receive side processing overhead.

So, if I understand what you are saying correctly,
things do work correctly (just slower for small skb) if NETIF_F_SG is set bug
clear, it seems that all we need to do is drop the following in dev.c:

        /* Fix illegal SG+CSUM combinations. */
        if ((dev->features & NETIF_F_SG) &&
            !(dev->features & NETIF_F_ALL_CSUM)) {
                printk(KERN_NOTICE "%s: Dropping NETIF_F_SG since no checksum feature.\n",
                       dev->name);
                dev->features &= ~NETIF_F_SG;
        }

is that right?

-- 
MST
